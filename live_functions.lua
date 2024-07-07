local config = require './training/mvc2_config'
local display = require './training/display_functions'
local pMem = require './training/player_functions'

-- Look up an address and return the value
-- Determines if PMem/SCV or Other Type of Address.
-- @param address_name The name of the address
-- @param oneOrTwo The player number (1 or 2). OPTIONAL
local function LookUpAll(address_name, oneOrTwo)

  local address
  local value
  local key

  -- Find the section
  local sectionName, obj = config.getSectionAndObject(address_name)

  -- Determine the read function
  local readFunction = config.determineType(obj.Type, "read")
  if not readFunction then
    error("Failed to determine read function for type: " .. obj.Type)
  end
  -- print("Read function found:", readFunction)

  -- Get Sub-Object from SS
  if sectionName == "PlayerMemoryAddresses" or sectionName == "SpecificCharacterAddresses" then

    local pointCharForPlayer = pMem.GetPoint(oneOrTwo)
    local concat = pointCharForPlayer .. address_name
    address = obj[concat]
    -- print("address: ", address)
    if not address then
      error("Concatenated address not found in object: " .. concat)
    end

    if oneOrTwo then
      value = pMem.GetPMemValue(address_name, oneOrTwo)
    else
      error("OneOrTwo argument is required for GetPMemValue() but not provided")
    end

  elseif sectionName == "Player1And2Addresses" then
    if oneOrTwo then
      local prefix = oneOrTwo == 1 and "P1_" or "P2_"
      local concat = prefix .. address_name
      address = obj[concat]
      if address then
        value = readFunction(address)
      else
        error("Concatenated address not found in object: " .. concat)
      end
    else
      error("OneOrTwo argument is required for Player1And2Addresses but not provided")
    end
    address = obj.Address
  elseif sectionName == "SystemMemoryAddresses" then
    address = obj.Address
    value = readFunction(address)
  else
    address = obj.Address
    value = readFunction(address)
  end

  if obj.Note2 then
    for line in obj.Note2:gmatch("([^\n]*)\n?") do
      local keyNumberAsString, valStringInObject = line:match("([^:]+):%s*(.*)") -- key is first match, val is second match
      -- print(value)
      if keyNumberAsString and tonumber(keyNumberAsString) == value then
        -- print("found")
        key = valStringInObject
      end
    end
  else
    -- If no corresponding key is found, return an error message
    local errorString = "LookupName: Key not found for value: " .. tostring(value) .. " in "

    if obj.Description then
      errorString = errorString .. obj.Description
    else
      errorString = errorString .. sectionName
    end

    -- print("LookupName: Key not found for value: " .. tostring(getVal))
    -- print("notfound")

    key = ""
  end
  -- print(address)
  return address, value, key
end

local function LookUpAddress(address_name, oneOrTwo)
  -- create a table to hold the 3 results from lookupAll()
  local results = {}
  -- call lookupAll() and store the results in the table
  results = {
    LookUpAll(address_name, oneOrTwo)
  }
  -- print("address: ", results[1])
  return results[1]
end

local function LookUpValue(address_name, oneOrTwo)
  -- create a table to hold the 3 results from lookupAll()
  local results = {}
  -- call lookupAll() and store the results in the table
  results = {
    LookUpAll(address_name, oneOrTwo)
  }
  -- print("value: ", results[2])
  return results[2]
end

local function LookUpKey(address_name, oneOrTwo)
  -- create a table to hold the 3 results from lookupAll()
  local results = {}
  -- call lookupAll() and store the results in the table
  results = {
    LookUpAll(address_name, oneOrTwo)
  }
  -- print("key: ", results[3])
  return results[3]
end

return {
  LookUpAll = LookUpAll,
  LookUpAddress = LookUpAddress,
  LookUpValue = LookUpValue,
  LookUpKey = LookUpKey
}
