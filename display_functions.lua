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
  local result = ""
  for line in note:gmatch("([^\n]*)\n?") do
    if line:match(":") then
      print("Line with colon:", line)
    else
      print("Line without colon:", line)
    end
    result = result .. line .. "\n"
  end
  return result
end

-- Main function to display PMem
local function displayPMem(player, address_name)
  if address_name == "ID_2" then
    -- Handle special case for ID_2
    local json_object = config.PlayerMemoryAddresses.ID_2
    return displayJSONContents(json_object)
  end

  -- Example of handling Note2 parsing if address_name corresponds to Note2 entry
  if address_name == "Note2" then
    local note = config.PlayerMemoryAddresses.Is_Point.Note2 -- Adjust this line as per your actual data structure
    return parseNote2(note)
  end

  return formatPMemValue(player, address_name)
end

-- Return the functions as a module
return {
  displayPMem = displayPMem,
  getKeyPrefix = getKeyPrefix,
  displayJSONContents = displayJSONContents,
  formatPMemValue = formatPMemValue,
  parseNote2 = parseNote2
}
