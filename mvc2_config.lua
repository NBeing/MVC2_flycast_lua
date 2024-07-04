-- mvc2_config.lua
-- Imports
local util = require './training/utilities'
local MVC2_OBJ = util.read_object_from_json_file('./training/data/SPREADSHEET.json')

-- Abstractions
local jsonSpreadsheet = MVC2_OBJ.SPREADSHEET -- json file: Spreadsheet object (contains other objects)
local jsonAllAddresses = MVC2_OBJ.AllAddresses -- json file: AllAddresses (contains unfiltered object with k-v addresses)
local jsonKeywords = MVC2_OBJ.Keywords -- json file: Keywords (contains unfiltered object with k-v keywords)

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
local CURRENT_FRAME = read32(jsonAllAddresses.Frame_Counter)

-- UI and Memory Aliases
local ui = flycast.ui
local MEMORY = flycast.memory

-- Return as a module
return {
  util = util,
  MVC2_OBJ = MVC2_OBJ,
  jsonSpreadsheet = jsonSpreadsheet,
  jsonAllAddresses = jsonAllAddresses,
  jsonKeywords = jsonKeywords,
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
