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
      error("Address not found for key: " .. concat .. " in PlayerMemoryAddresses or SpecificCharacterAddresses")
    end
  end

  local address = lookup[concat]
  if not address then
    error("Concatenated address not found in lookup result: " .. concat)
  end

  local value = config.read8(address)
  return value
end

-- Return the functions as a module
return {
  GetPoint = GetPoint,
  GetPMemUsingPoint = GetPMemUsingPoint
}
