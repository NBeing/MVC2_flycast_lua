local config = require './training/mvc2_config'
local display = require './training/display_functions'
local pMem = require './training/player_functions'

-- Look up an address and return the value
-- Determines if PMem/SCV or Other Type of Address.
-- @param address_name The name of the address
-- @param oneOrTwo The player number (1 or 2). OPTIONAL
local function LookUpValue(address_name, oneOrTwo)
  -- Find the section
  local sectionName, obj = config.getSectionAndObject(address_name)

  -- Determine the read function
  local readFunction = config.determineType(obj.Type, "read")
  if not readFunction then
    error("Failed to determine read function for type: " .. obj.Type)
  end
  -- print("Read function found:", readFunction)
  -- -- Perform the read operation based on the determined function
  local value
  -- Get Sub-Object from SS
  if sectionName == "PlayerMemoryAddresses" or sectionName == "SpecificCharacterAddresses" then
    if oneOrTwo then
      value = pMem.GetPMemValue(address_name, oneOrTwo)
    else
      error("OneOrTwo argument is required for GetPMemValue() but not provided")
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
  -- print("LookupValue found:", value)

  return value
end

-- Translates the `lookUpValue` based on `Note2`
local function LookUpName(address_name, oneOrTwo)
  -- Get the value using lookUpValue function
  local getVal = LookUpValue(address_name, oneOrTwo)

  -- Get the section name and object
  local sectionName, obj = config.getSectionAndObject(address_name)

  -- If Note2 exists, parse it and find the corresponding key
  if obj.Note2 then
    for line in obj.Note2:gmatch("([^\n]*)\n?") do
      local keyNumberAsString, valStringInObject = line:match("([^:]+):%s*(.*)") -- key is first match, val is second match
      if keyNumberAsString and tonumber(keyNumberAsString) == getVal then
        return valStringInObject
      end
    end
  end
  -- If no corresponding key is found, return an error message
  local errorString = "LookupName: Key not found for value: " .. tostring(getVal) .. " in "
  if obj.Description then
    errorString = errorString .. obj.Description
  else
    errorString = errorString .. sectionName
  end
  -- print("LookupName: Key not found for value: " .. tostring(getVal))
  return errorString
end

return {
  LookUpValue = LookUpValue,
  LookUpName = LookUpName
}
-- write("X_Position_Arena", 20)
-- Find address_name in SS, use PMem if necessary,
-- return section name and object
-- Push the object's "Type" into determineType
-- Store the result of what type of read function we need to use because
-- we will need to use that to write to it. If we matched read8, we
-- will need to use write8 to write to it.
