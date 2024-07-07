local config = require './training/mvc2_config'
local pMem = require './training/player_functions'
local interfaces = require './training/interfaces'

-- Function to get the structure of the object from `interfaces.lua`
--- Retrieves the structure of an interface.
-- @param interface_name The name of the interface.
-- @return The structure of the interface.
local function getObjectStructure(interface_name)
  local structure = interfaces[interface_name]
  if not structure then
    error("Structure not found for interface: " .. interface_name)
  end
  return structure
end

-- Parses JSON data with order by using `getObjectStructure` and `getSectionAndObject`
-- @param address_name The name of the address
-- @return obj The parsed JSON object
-- @return structure The structure of the object
local function parseJSONWithOrder(address_name)
  local sectionName, obj = config.getSectionAndObject(address_name)

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

-- Main Call
local function ReadAddressObject(address_name)
  -- local address_name = "Stun_Check" -- PMem
  -- local address_name = "Sentinel_214kk_Timer" -- SpecChar
  -- local address_name = "Combo_Meter_Value" -- P1P2
  -- local address_name = "Input_DEC" -- Sys
  -- local address_name = "RubyHeart" -- CharInfo
  -- local address_name = "Boat2" -- StagesInfo
  -- local address_name = "Right" -- InputsInfo

  local json_object, structure = display.parseJSONWithOrder(address_name) -- returns two values and assigns them to json_object and structure

  if json_object then
    return display.displayJSONContents(json_object, structure)
  else
    return "Object not found"
  end
end

return {
  -- parseJSONWithOrder = parseJSONWithOrder,
  -- displayJSONContents = displayJSONContents,
  ReadAddressObject = ReadAddressObject
}
