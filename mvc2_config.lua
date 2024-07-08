-- Imports
local util = require './training/utilities'

-- @see https://docs.google.com/spreadsheets/d/1xVxjAX3pEEPsR0tJcVAt9mCWLnzE_MVI6rIXgEIueHI}
local MVC2_OBJ = util.read_object_from_json_file('./training/data/SPREADSHEET.json')

-- Abstractions
local jSS = MVC2_OBJ.SPREADSHEET

PlayerMemoryAddresses = jSS.PlayerMemoryAddresses
SpecificCharacterAddresses = jSS.SpecificCharacterAddresses
Player1And2Addresses = jSS.Player1And2Addresses
SystemMemoryAddresses = jSS.SystemMemoryAddresses
CharacterInfo = jSS.CharacterInfo
StagesInfo = jSS.StagesInfo
InputsInfo = jSS.InputsInfo
--
ALL = MVC2_OBJ.AllAddresses

local byteSize = {
  "Byte",
  "2 Bytes",
  "4 Bytes",
  "Float"
}

-- Readers / Writers Aliases
read8 = flycast.memory.read8
read16 = flycast.memory.read16
read32 = flycast.memory.read32
--
write8 = flycast.memory.write8
write16 = flycast.memory.write16
write32 = flycast.memory.write32

-- Custom function to read float values with truncation to 7 decimal places and handling small numbers
readFloat = function(address)
  local intValue = read32(address)

  if intValue == 0 then
    return 0.0
  end

  local sign = (intValue & 0x80000000) ~= 0 and -1 or 1
  local exponent = ((intValue >> 23) & 0xFF) - 127
  local mantissa = intValue & 0x7FFFFF

  if exponent == -127 then -- This handles denormalized numbers and zero
    if mantissa == 0 then
      return 0.0 * sign -- Correctly handle negative zero
    else
      return sign * (mantissa * 2 ^ -23) * 2 ^ -126
    end
  else
    mantissa = mantissa | 0x800000 -- The implicit leading 1
    local floatValue = sign * mantissa * 2 ^ (exponent - 23)

    -- Truncate to 7 decimal places
    local formatString = "%.7f"
    local truncatedValue = tonumber(string.format(formatString, floatValue))

    -- Handle small numbers by setting them to zero if they fall within the range -0.5 to 0.5
    if truncatedValue > -0.005 and truncatedValue < 0.005 then
      return 0.0
    end

    return truncatedValue
  end
end

-- Write a float value to a memory address
writeFloat = function(address, value)
  -- print("Attempting to write float value:", value, "to address:", string.format("0x%X", address))

  -- Handle the special case of zero
  if value == 0 then
    write32(address, 0)
    -- print("Writing zero to address:", string.format("0x%X", address))
    return
  end

  -- Convert the float value to its IEEE 754 binary representation
  local sign = 0
  if value < 0 then
    sign = 1
    value = -value
  end

  local mantissa, exponent = math.frexp(value)
  -- print("Initial mantissa:", mantissa, "exponent:", exponent)
  exponent = exponent + 126

  if exponent <= 0 then
    -- Handle denormalized numbers
    mantissa = math.ldexp(mantissa, exponent + 23)
    exponent = 0
  else
    mantissa = (mantissa * 2 - 1) * math.ldexp(0.5, 24)
  end

  -- print("Adjusted mantissa:", mantissa, "adjusted exponent:", exponent)

  local b4 = (sign << 7) + (exponent >> 1)
  local b3 = ((exponent % 2) << 7) + (mantissa >> 16)
  local b2 = (mantissa >> 8) % 256
  local b1 = mantissa % 256

  -- Combine the bytes into a single 32-bit number
  local value32 = (b4 << 24) + (b3 << 16) + (b2 << 8) + b1
  -- print("Converted value to 32-bit integer:", value32)

  -- Write the 32-bit value to the memory address
  write32(address, value32)
  -- print("Wrote 32-bit integer value:", value32, "to address:", string.format("0x%X", address))
end

-- Helper function to truncate float value to a specific number of decimal places
local function truncateFloat(value, numDecimals)
  local formatString = "%." .. numDecimals .. "f"
  return tonumber(string.format(formatString, value))
end

-- Function to get the appropriate read function based on the type
-- @param objectType The type of the object.
-- @return The read function based on the type.
local function determineType(objectType, readOrWrite)
  if objectType and readOrWrite == "read" then
    -- Get Read Type
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
          print("Unknown type:", objectType)
          return nil
        end
      end
    end
    print("Invalid type:", objectType)
  elseif objectType and readOrWrite == "write" then
    -- Get Write Type
    for _, type in ipairs(config.byteSize) do
      if type == objectType then
        -- print("Valid type:", objectType)
        if objectType == "Byte" then
          return config.write8
        elseif objectType == "2 Bytes" then
          return config.write16
        elseif objectType == "4 Bytes" then
          return config.write32
        elseif objectType == "Float" then
          return config.writeFloat
        else
          print("Unknown type:", objectType)
          return nil
        end
      end
    end
    print("Type not found for object")
  end
  return nil
end

-- Finds address_name in SS and returns the section name and object
-- @param address_name Address/Keyword
-- @return sectionName Section in SS: PlayerMemoryAddresses, SpecificCharacterAddresses, Player1And2Addresses, SystemMemoryAddresses
local function getSectionAndObject(address_name)
  for name, section in pairs(config.jSS) do
    if section[address_name] then
      return name, section[address_name]
    end
  end
end

-- Important Constants
CURRENT_FRAME = read32(SystemMemoryAddresses.Frame_Counter.Address)

-- UI and Memory Aliases
ui = flycast.ui
local MEMORY = flycast.memory

-- Return as a module
return {
  MVC2_OBJ = MVC2_OBJ,
  jSS = jSS,
  PlayerMemoryAddresses = PlayerMemoryAddresses,
  SpecificCharacterAddresses = SpecificCharacterAddresses,
  Player1And2Addresses = Player1And2Addresses,
  SystemMemoryAddresses = SystemMemoryAddresses,
  CharacterInfo = CharacterInfo,
  StagesInfo = StagesInfo,
  InputsInfo = InputsInfo,
  all = all,
  read8 = read8,
  read16 = read16,
  read32 = read32,
  readFloat = readFloat,
  write8 = write8,
  write16 = write16,
  write32 = write32,
  writeFloat = writeFloat,
  CURRENT_FRAME = CURRENT_FRAME,
  ui = ui,
  byteSize = byteSize,
  determineType = determineType,
  getSectionAndObject = getSectionAndObject
}
