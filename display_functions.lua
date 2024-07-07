local config = require './training/mvc2_config'
local pMem = require './training/player_functions'
local interfaces = require './training/interfaces'

-- Function to get the structure of the object from interfaces.lua
local function getObjectStructure(interface_name)
  local structure = interfaces[interface_name]
  if not structure then
    error("Structure not found for interface: " .. interface_name)
  end
  return structure
end

-- Function to determine which section the address_name belongs to and get the object
local function getSectionAndObject(address_name)
  for name, section in pairs(config.jSS) do
    if section[address_name] then
      return name, section[address_name]
    end
  end
  error("Address not found: " .. address_name)
end

-- Parses JSON data with order
-- @param address_name The name of the address
-- @return obj The parsed JSON object
-- @return structure The structure of the object
local function parseJSONWithOrder(address_name)
  local sectionName, obj = getSectionAndObject(address_name)

  -- Get the structure of the object
  local structure = getObjectStructure(sectionName)
  if not structure then
    error("Structure not found for section: " .. sectionName)
  end

  -- Insert dynamic keys for PlayerMemoryAddresses and SpecificCharacterAddresses
  if sectionName == "PlayerMemoryAddresses" or sectionName == "SpecificCharacterAddresses" then
    local dynamicKeys = {
      "P1_A_" .. address_name,
      "P1_B_" .. address_name,
      "P1_C_" .. address_name,
      "P2_A_" .. address_name,
      "P2_B_" .. address_name,
      "P2_C_" .. address_name
    }
    -- Insert dynamic keys after the Type key
    local newStructure = {}
    for i, key in ipairs(structure) do
      table.insert(newStructure, key)
      if key == "Type" then
        for _, dynamicKey in ipairs(dynamicKeys) do
          table.insert(newStructure, dynamicKey)
        end
      end
    end
    structure = newStructure
  elseif sectionName == "Player1And2Addresses" then
    local dynamicKeys = {
      "P1_" .. address_name,
      "P2_" .. address_name
    }
    -- Insert dynamic keys after the Type key
    local newStructure = {}
    for i, key in ipairs(structure) do
      table.insert(newStructure, key)
      if key == "Type" then
        for _, dynamicKey in ipairs(dynamicKeys) do
          table.insert(newStructure, dynamicKey)
        end
      end
    end
    structure = newStructure
  end

  return obj, structure
end

-- Function to display JSON contents in order with special handling for Note2
local function displayJSONContents(json_object, structure)
  -- local name = json_object.Description
  -- local result = "Name: " .. name .. "\n"
  local result = ""
  -- Display the keys and values in order
  for _, key in ipairs(structure) do
    if json_object[key] ~= nil then
      if key == "Note2" then
        local note2Value = tostring(json_object[key])
        if note2Value:match(":") then
          result = result .. key .. ":\n" .. note2Value .. "\n"
        else
          result = result .. key .. ": " .. note2Value .. "\n"
        end
      else
        result = result .. key .. ": " .. tostring(json_object[key]) .. "\n"
      end
    end
  end

  return result
end

-- Function to look up an address and return the value
-- Determines if PMem/SCV or Other Type of Address.
-- @param address_name The name of the address
-- @param oneOrTwo The player number (1 or 2)
local function lookUpValue(address_name, oneOrTwo)
  -- Find the section
  local sectionName, obj = getSectionAndObject(address_name)

  -- Determine the read function
  local readFunction = pMem.getReadFunction(obj.Type)
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

-- Parse Note2 and look up the name based on the value
local function parseNote2(note2, value)
  for line in note2:gmatch("([^\n]*)\n?") do
    local key, val = line:match("([^:]+):%s*(.*)")
    if key and tonumber(key) == value then
      return val
    end
  end
  error("Name not found for value: " .. value)
end

-- Main function to look up the name based on the value from Note2
local function lookUpName(value, address_name)
  local sectionName, obj = getSectionAndObject(address_name)
  if obj.Note2 then
    return parseNote2(obj.Note2, value)
  end
  error("Name not found for value: " .. value .. " and address: " .. address_name)
end

return {
  parseJSONWithOrder = parseJSONWithOrder,
  displayJSONContents = displayJSONContents,
  lookUpName = lookUpName,
  lookUpValue = lookUpValue
}
