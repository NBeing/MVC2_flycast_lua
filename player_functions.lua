local config = require './training/mvc2_config'

-- GetPoint function
-- @param oneOrTwo: The player number (1 or 2).
-- @return string representing the prefix for the on-point && active character for the specified player.
local function GetPoint(oneOrTwo)
  local pointPrefix = '' -- will contain the character that is on point for the specified player.
  if oneOrTwo == 1 then
    if config.read8(config.PlayerMemoryAddresses.Is_Point.P1_A_Is_Point) == 0 then
      pointPrefix = 'P1_A_'
      return pointPrefix
    elseif config.read8(config.PlayerMemoryAddresses.Is_Point.P1_B_Is_Point) == 0 then
      pointPrefix = 'P1_B_'
      return pointPrefix
    elseif config.read8(config.PlayerMemoryAddresses.Is_Point.P1_C_Is_Point) == 0 then
      pointPrefix = 'P1_C_'
      return pointPrefix
    end
  else
    if oneOrTwo == 2 then
      if config.read8(config.PlayerMemoryAddresses.Is_Point.P2_A_Is_Point) == 0 then
        pointPrefix = 'P2_A_'
        return pointPrefix
      elseif config.read8(config.PlayerMemoryAddresses.Is_Point.P2_B_Is_Point) == 0 then
        pointPrefix = 'P2_B_'
        return pointPrefix
      elseif config.read8(config.PlayerMemoryAddresses.Is_Point.P2_C_Is_Point) == 0 then
        pointPrefix = 'P2_C_'
        return pointPrefix
      end
    else
      return
    end
  end
end

-- Function to get the appropriate read function based on the type
-- @param objectType The type of the object.
-- @return The read function based on the type.
local function determineReadFunction(objectType)
  if objectType then
    -- print("Type found:", objectType)
    -- Check if the type is in config.byteSize
    for _, type in ipairs(config.byteSize) do
      if type == objectType then
        -- print("Valid type:", objectType)
        if objectType == "Byte" then
          return config.read8
        elseif objectType == "2 Bytes" then
          return config.read16
        elseif objectType == "4 Bytes" then
          return config.read32
        elseif objectType == "Float" then
          return config.readFloat
        else
          -- print("Unknown type:", objectType)
          return nil
        end
      end
    end
    -- print("Invalid type:", objectType)
  else
    -- print("Type not found for object")
  end
  return nil
end

-- Retrieves the value from a memory address based on the player's point character and the address name.
-- @param oneOrTwo The player number (1 or 2).
-- @param address_name The name of the memory address.
-- @return Number from the memory address.
local function GetPMemUsingPoint(oneOrTwo, address_name)
  local pointCharForPlayer = GetPoint(oneOrTwo)
  local concat = pointCharForPlayer .. address_name

  -- Check in PlayerMemoryAddresses
  local lookup = config.PlayerMemoryAddresses[address_name]
  if not lookup then
    -- If not found, check in SpecificCharacterAddresses
    lookup = config.SpecificCharacterAddresses[address_name]
    if not lookup then
      error("Address not found for key: " .. concat)
    end
  end

  local address = lookup[concat]
  if not address then
    error("Concatenated address not found in lookup result: " .. concat)
  end

  -- Determine the read function
  local readFunction = determineReadFunction(lookup.Type)
  if not readFunction then
    error("Failed to determine read function for type: " .. tostring(lookup.Type))
  end

  local value = readFunction(address)
  return value
end

-- Return the functions as a module
return {
  GetPoint = GetPoint,
  GetPMemUsingPoint = GetPMemUsingPoint,
  determineReadFunction = determineReadFunction
}
