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
      -- print("Invalid player number")
      return print("Invalid player number")
    end
  end
end

-- Retrieves the value from a memory address based on the player's point character and the address name.
-- @param address_name The name of the memory address.
local function GetPMemValue(address_name)

  local oneOrTwo

  if address_name:sub(1, 3) == "P1_" then
    oneOrTwo = 1
  elseif address_name:sub(1, 3) == "P2_" then
    oneOrTwo = 2
  end

  address_name = address_name:sub(4)

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
  local readFunction = config.determineType(lookup.Type, "read")
  if not readFunction then
    error("Failed to determine read function for type: " .. tostring(lookup.Type))
  end

  local value = readFunction(address)
  return value
end

-- Return the functions as a module
return {
  GetPoint = GetPoint,
  GetPMemValue = GetPMemValue
}
