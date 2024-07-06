local config = require './training/mvc2_config'
local pMem = require './training/player_functions'

-- Function to get the concatenated key
local function getKeyPrefix(player, address_name)
  local prefix = player == 1 and "P1_" or player == 2 and "P2_" or ""
  return prefix .. address_name
end

-- Function to display JSON contents
local function displayJSONContents(json_object)
  local result = ""
  for key, value in pairs(json_object) do
    result = result .. key .. ": " .. tostring(value) .. "\n"
  end
  return result
end

-- Function to format PMem object value
local function formatPMemValue(player, address_name)
  local key = getKeyPrefix(player, address_name)

  local success, value = pcall(pMem.GetPMemUsingPoint, player, address_name)
  if not success then
    return string.format("%s: Error", key)
  end

  local formatString = string.format("%s: %d", key, value)
  return formatString
end

-- Parses the Note2 entry and returns a formatted string
local function parseNote2(note)
  local result = "Note2:\n"
  for line in note:gmatch("([^\n]*)\n?") do
    if line:match(":") then
      local key, value = line:match("([^:]+):%s*(.*)")
      result = result .. value .. ": " .. key .. "\n"
      print("Line with colon:", line, " -> ", value .. ": " .. key)
    else
      result = result .. line .. "\n"
      print("Line without colon:", line)
    end
  end
  return result
end

-- Function to get Note2 contents if they exist
local function getNote2(address_name)
  local lookUpValue = config.PlayerMemoryAddresses[address_name]
  if lookUpValue and lookUpValue.Note2 then
    return parseNote2(lookUpValue.Note2)
  end
  return nil
end

-- Main function to display PMem value
local function displayPMem(player, address_name)
  return formatPMemValue(player, address_name)
end

-- Function to handle special cases and return Note2 contents if they exist
local function displaySpecialCases(address_name)
  -- Check for Note2 and return its contents if it exists
  local note2Contents = getNote2(address_name)
  if note2Contents then
    return note2Contents
  end

  if address_name == "ID_2" then
    -- Handle special case for ID_2
    local json_object = config.PlayerMemoryAddresses.ID_2
    return displayJSONContents(json_object)
  end

  return nil
end

-- Function to look up an address and print the containing object
local function lookUpValue(address_name, oneOrTwo)
  for sectionName, section in pairs(config) do
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
              -- print("OneOrTwo argument is required for GetPMemUsingPoint() but not provided")
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
                -- print("Concatenated address not found in object:", concat)
                return
              end
            else
              -- print("OneOrTwo argument is required for Player1And2Addresses but not provided")
              return
            end
          elseif sectionName == "SystemMemoryAddresses" then
            local address = obj.Address
            value = readFunction(address)
            -- print("Using read function for SystemMemoryAddresses address", address)
          else
            local address = obj.ADDRESS
            value = readFunction(address)
            -- print("Using read function for address", address)
          end

          -- print("Value from read function:", value)
          return
        end
      end
    end
  end
  print("Address not found")
end

-- Return the functions as a module
return {
  displayPMem = displayPMem,
  displaySpecialCases = displaySpecialCases,
  getKeyPrefix = getKeyPrefix,
  displayJSONContents = displayJSONContents,
  formatPMemValue = formatPMemValue,
  parseNote2 = parseNote2,
  getNote2 = getNote2,
  lookUpValue = lookUpValue
}
