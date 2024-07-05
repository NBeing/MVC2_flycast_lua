-- mvc2_config.lua
-- Imports
local util = require './training/utilities'
local MVC2_OBJ = util.read_object_from_json_file('./training/data/SPREADSHEET.json')

-- Abstractions
local jSS = MVC2_OBJ.SPREADSHEET -- json file: Spreadsheet object (contains other objects)
local jAdr = MVC2_OBJ.AllAddresses -- json file: AllAddresses (contains unfiltered object with k-v addresses)
local jKeys = MVC2_OBJ.Keywords -- json file: Keywords (contains unfiltered object with k-v keywords)

-- Data
local DC_MVC2_MEMORY_TABLE = require './training/data/DC_MVC2_MEMORY_TABLE'
local CHARACTER = require './training/data/characters'
local STAGES = require './training/data/stages'

-- Readers / Writers Aliases
local read8 = flycast.memory.read8
local read16 = flycast.memory.read16
local read32 = flycast.memory.read32
local write8 = flycast.memory.write8
local write16 = flycast.memory.write16
local write32 = flycast.memory.write32

-- Important Constants
local CURRENT_FRAME = read32(jAdr.Frame_Counter)

-- UI and Memory Aliases
local ui = flycast.ui
local MEMORY = flycast.memory

-- Return as a module
return {
  util = util,
  MVC2_OBJ = MVC2_OBJ,
  jSS = jSS,
  jAdr = jAdr,
  jKeys = jKeys,
  DC_MVC2_MEMORY_TABLE = DC_MVC2_MEMORY_TABLE,
  CHARACTER = CHARACTER,
  STAGES = STAGES,
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

-- TODO: buttons
-- local BTN_B = 1 << 1 -- hk
-- local BTN_A = 1 << 2  -- lk
-- local BTN_Y = 1 << 9 -- heavy 
-- local BTN_X = 1 << 10 --light poonch
-- local BTN_C = assist 2
-- local BTN_Z = assist 1

-- GLOBALS = {
--   CHARACTER = CHARACTER,
--   STAGES = STAGES
-- }
