-- Imports
local util = require './training/utilities'
local MVC2_OBJ = util.read_object_from_json_file('./training/data/SPREADSHEET.json')

-- Abstractions
local jSS = MVC2_OBJ.SPREADSHEET

-- Create shorthand variables for each sub-object
local PlayerMemoryAddresses = jSS.PlayerMemoryAddresses
local SpecificCharacterAddresses = jSS.SpecificCharacterAddresses
local Player1And2Addresses = jSS.Player1And2Addresses
local SystemMemoryAddresses = jSS.SystemMemoryAddresses
local CharacterInfo = jSS.CharacterInfo
local StagesInfo = jSS.StagesInfo
local InputsInfo = jSS.InputsInfo
local byteSize = {
  "Byte",
  "2 Bytes",
  "4 Bytes",
  "Float"
}

-- Readers / Writers Aliases
local read8 = flycast.memory.read8
local read16 = flycast.memory.read16
local read32 = flycast.memory.read32

-- Custom function to read float values
local readFloat = function(address)
  -- print("Reading float value from address", address)
  local intValue = read32(address)
  -- print("Integer value read:", intValue)

  if intValue == 0 then
    return 0.0
  end

  local sign = (intValue & 0x80000000) ~= 0 and -1 or 1
  local exponent = ((intValue >> 23) & 0xFF) - 127
  local mantissa = (intValue & 0x7FFFFF) | 0x800000

  local floatValue = sign * mantissa * (2 ^ (exponent - 23))
  -- print("Converted float value:", floatValue)
  return floatValue
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

-- Important Constants
-- Ensure the Frame_Counter address is correctly referenced
local CURRENT_FRAME_ADDRESS = SystemMemoryAddresses.Frame_Counter.Address
local CURRENT_FRAME = read32(CURRENT_FRAME_ADDRESS)

-- UI and Memory Aliases
local ui = flycast.ui
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
  read8 = read8,
  read16 = read16,
  read32 = read32,
  readFloat = readFloat,
  CURRENT_FRAME = CURRENT_FRAME,
  ui = ui,
  MEMORY = MEMORY,
  byteSize = byteSize,
  determineReadFunction = determineReadFunction
}
