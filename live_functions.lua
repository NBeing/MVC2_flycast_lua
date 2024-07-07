local config = require './training/mvc2_config'
local display = require './training/display_functions'
local pMem = require './training/player_functions'

-- Look up an address and return the value
-- Determines if PMem/SCV or Other Type of Address.
-- @param address_name The name of the address
local function LookUpAll(address_name)

  local address
  local value
  local key

  local oneOrTwo
  local playerPrefix

  if address_name:sub(1, 3) == "P1_" then
    -- print("P1")
    oneOrTwo = 1
    playerPrefix = "P1_"
    address_name = address_name:sub(4)
  elseif address_name:sub(1, 3) == "P2_" then
    -- print("P2")
    oneOrTwo = 2
    playerPrefix = "P2_"
    address_name = address_name:sub(4)
  end
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
    if not pointCharForPlayer then
      error("Point character not found for player: " .. oneOrTwo)
    end

    local concat = pointCharForPlayer .. address_name
    address = obj[concat]

    if not address then
      error("Concatenated address not found in object: " .. concat)
    end

    local PX_ADDRESS = tostring(playerPrefix .. address_name)

    if oneOrTwo then
      value = pMem.GetPMemValue(PX_ADDRESS)
    else
      print("OneOrTwo argument is required for GetPMemValue() but not provided")
    end
  elseif sectionName == "Player1And2Addresses" then
    -- print("1")
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
    print("1")
    address = obj.Address
    value = readFunction(address)
  else
    print("1")
    address = obj.Address
    value = readFunction(address)
  end

  -- Look up the key
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
  -- print(key)
  -- print(address)
  return address, value, key
end

-- If PMem or SCV, be sure to type P1_ or P2_!
local function LookUpAddress(address_name)
  local results = {}
  results = {
    LookUpAll(address_name)
  }
  -- print("address: ", results[1])
  return results[1]
end

-- If PMem or SCV, be sure to type P1_ or P2_!
local function LookUpValue(address_name)
  local results = {}
  results = {
    LookUpAll(address_name)
  }
  -- print("value: ", results[2])
  return results[2]
end

-- If PMem or SCV, be sure to type P1_ or P2_!
local function LookUpKey(address_name)
  local results = {}
  results = {
    LookUpAll(address_name)
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
