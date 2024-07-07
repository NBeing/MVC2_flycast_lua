local config = require './training/mvc2_config'
local pMem = require './training/player_functions'
local interfaces = require './training/interfaces'

-- get the concatenated key
local function getKeyPrefix(player, address_name)
  local prefix = player == 1 and "P1_" or player == 2 and "P2_" or ""
  return prefix .. address_name
end

-- get the structure of the object from interfaces.lua
local function getObjectStructure(interface_name)
  -- print("Getting structure for interface:", interface_name)
  local structure = interfaces[interface_name]
  if not structure then
    print("Structure not found for interface:", interface_name)
  end
  return structure
end

-- determine which section the address_name belongs to and get the object
local function getSectionAndObject(address_name)
  local sectionName, obj
  for name, section in pairs(config.jSS) do
    if section[address_name] then
      sectionName = name
      obj = section[address_name]
      -- print("Found section:", sectionName)
      break
    end
  end

  if not obj then
    error("Address not found: " .. address_name)
  end

  return sectionName, obj
end

local function parseJSONWithOrder(address_name)
  local sectionName, obj = getSectionAndObject(address_name)

  -- Get the structure of the object
  local structure = getObjectStructure(sectionName)
  if not structure then
    error("Structure not found for section: " .. sectionName)
  else
    -- print("Structure found for section: ", sectionName)
  end

  -- Print the structure for debugging
  for i, key in ipairs(structure) do
    -- print("Structure key:", key)
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
      -- print("Adding key-value to result:", key, json_object[key])
    end
  end

  -- Include any additional keys not in the structure
  for key, value in pairs(json_object) do
    if not table.contains(structure, key) then
      result = result .. key .. ": " .. tostring(value) .. "\n"
      -- print("Adding additional key-value to result:", key, value)
    end
  end

  return result
end

-- Function to check if a table contains a value
function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- get Note2 contents if they exist
local function getNote2(address_name)
  local obj = config.jSS.PlayerMemoryAddresses[address_name]
  if obj and obj.Note2 then
    return obj.Note2
  end
  return nil
end

-- Main display PMem value
local function displayPMem(player, address_name)
  local key = getKeyPrefix(player, address_name)

  local success, value = pcall(pMem.GetPMemUsingPoint, player, address_name)
  if not success then
    return key .. ": Error"
  end

  return key .. ": " .. tostring(value)
end

-- look up an address and return the value
local function lookUpValue(address_name, oneOrTwo)
  for sectionName, section in pairs(config.jSS) do
    if type(section) == "table" then
      for key, obj in pairs(section) do
        if key == address_name then
          -- print("Found in section:", sectionName)
          -- print("Object name:", key)
          -- print("Object details:", obj)

          -- Determine the read function
          local readFunction = pMem.getReadFunction(obj.Type)
          if not readFunction then
            print("Failed to determine read function for type:", obj.Type)
            return
          end

          -- Perform the read operation based on the determined function
          local value
          if sectionName == "PlayerMemoryAddresses" or sectionName == "SpecificCharacterAddresses" then
            if oneOrTwo then
              value = pMem.GetPMemUsingPoint(oneOrTwo, address_name)
              -- print("Using GetPMemUsingPoint() with player", oneOrTwo, "and address", address_name)
            else
              print("OneOrTwo argument is required for GetPMemUsingPoint() but not provided")
              return
            end
          elseif sectionName == "Player1And2Addresses" then
            if oneOrTwo then
              local prefix = oneOrTwo == 1 and "P1_" or oneOrTwo == 2 and "P2_"
              local concat = prefix .. address_name
              local address = obj[concat]
              if address then
                value = readFunction(address)
                -- print("Using read function for address", address)
              else
                print("Concatenated address not found in object:", concat)
                return
              end
            else
              print("OneOrTwo argument is required for Player1And2Addresses but not provided")
              return
            end
          elseif sectionName == "SystemMemoryAddresses" then
            local address = obj.Address
            value = readFunction(address)
            -- print("Using read function for SystemMemoryAddresses address", address)
          else
            local address = obj.Address
            value = readFunction(address)
            -- print("Using read function for address", address)
          end

          -- print("Value from read function:", value)
          return value
        end
      end
    end
  end
  print("Address not found")
end

-- look up the name based on the value from Note2
local function lookUpName(value, address_name)
  for sectionName, section in pairs(config.jSS) do
    if type(section) == "table" then
      for key, obj in pairs(section) do
        if key == address_name then
          if obj.Note2 then
            for line in obj.Note2:gmatch("([^\n]*)\n?") do
              local key, val = line:match("([^:]+):%s*(.*)")
              if key and tonumber(key) == value then
                return val
              end
            end
          end
        end
      end
    end
  end
  return "Name not found"
end

-- Return the functions as a module
return {
  displayPMem = displayPMem,
  getNote2 = getNote2,
  lookUpValue = lookUpValue,
  lookUpName = lookUpName,
  parseJSONWithOrder = parseJSONWithOrder,
  displayJSONContents = displayJSONContents
}
