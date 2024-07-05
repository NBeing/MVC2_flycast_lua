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
-- 
-- Readers / Writers Aliases
local read8 = flycast.memory.read8
local read16 = flycast.memory.read16
local read32 = flycast.memory.read32
local write8 = flycast.memory.write8
local write16 = flycast.memory.write16
local write32 = flycast.memory.write32

-- Important Constants
-- Ensure the Frame_Counter address is correctly referenced
local CURRENT_FRAME_ADDRESS = SystemMemoryAddresses.Frame_Counter.Address
local CURRENT_FRAME = read32(CURRENT_FRAME_ADDRESS)

-- print(CURRENT_FRAME)
-- 
-- UI and Memory Aliases
local ui = flycast.ui
local MEMORY = flycast.memory

-- Return as a module
return {
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
  write8 = write8,
  write16 = write16,
  write32 = write32,
  CURRENT_FRAME = CURRENT_FRAME,
  ui = ui,
  MEMORY = MEMORY
}
