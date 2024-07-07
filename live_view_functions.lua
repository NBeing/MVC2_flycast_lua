local config = require './training/mvc2_config'
local display = require './training/display_functions'
local pMem = require './training/player_functions'

-- Look up an address and return the value
-- Determines if PMem/SCV or Other Type of Address.
-- @param address_name The name of the address
-- @param oneOrTwo The player number (1 or 2). OPTIONAL
local function lookUpValue(address_name, oneOrTwo)
  -- Find the section
  local sectionName, obj = display.getSectionAndObject(address_name)

  -- Determine the read function
  local readFunction = pMem.determineReadFunction(obj.Type)
  if not readFunction then
    error("Failed to determine read function for type: " .. obj.Type)
  end

  -- Perform the read operation based on the determined function
  local value
  if sectionName == "PlayerMemoryAddresses" or sectionName == "SpecificCharacterAddresses" then
    if oneOrTwo then
      value = pMem.GetPMemUsingPoint(oneOrTwo, address_name)
    else
      error("OneOrTwo argument is required for GetPMemUsingPoint() but not provided")
    end
  elseif sectionName == "Player1And2Addresses" then
    if oneOrTwo then
      local prefix = oneOrTwo == 1 and "P1_" or "P2_"
      local concat = prefix .. address_name
      local address = obj[concat]
      if address then
        value = readFunction(address)
      else
        error("Concatenated address not found in object: " .. concat)
      end
    else
      error("OneOrTwo argument is required for Player1And2Addresses but not provided")
    end
  elseif sectionName == "SystemMemoryAddresses" then
    local address = obj.Address
    value = readFunction(address)
  else
    local address = obj.Address
    value = readFunction(address)
  end

  return value
end

-- Parses the Note2 string and looks up the name based on the value.
-- @param note2 The Note2 string to parse.
-- @param value The value to look up.
-- @return The name corresponding to the value.
local function parseNote2(note2, value)
  -- Iterate over each line in the Note2 string.
  for line in note2:gmatch("([^\n]*)\n?") do
    -- Extract the key and value from each line using regex.
    local key, val = line:match("([^:]+):%s*(.*)")

    -- Check if the key matches the desired value.
    if key and tonumber(key) == value then
      return val
    end
  end

  -- If no name is found for the given value, throw an error.
  error("Name not found for value: " .. value)
end

-- Translates the `lookUpValue` based on `Note2`
local function lookUpName(value, address_name)
  local sectionName, obj = display.getSectionAndObject(address_name)
  if obj.Note2 then
    return parseNote2(obj.Note2, value)
  end
  error("Name not found for value: " .. value .. " and address: " .. address_name)
end

return {
  lookUpValue = lookUpValue,
  lookUpName = lookUpName
}
