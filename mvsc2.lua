-- Require the configuration module
config = require './training/mvc2_config'
pMem = require './training/player_functions'
display = require './training/display_functions'
live = require './training/live_functions'
--
doMove = require './training/do_move_functions'
sequence_manager = require './training/sequence_manager'
move_characters = require './training/move_characters_functions'
--
ui = config.ui

----
-- Define a custom sequence
local customSequence = {
  {
    waitFrames = 0,
    action = function()
      doMove.ForceSpecials(1)
    end
  },
  {
    waitFrames = 9,
    action = function()
      doMove.ForceSpecials(3)
    end
  }
  -- Add more actions as needed
}

local FS_FLAG = false

function cbVBlank()
  if FS_FLAG then
    sequence_manager.runSequence()
  end
end

function cbOverlay()

  -- Check for frame skip
  if read8(ALL.Frame_Skip_Counter) == 4 then
    FS_FLAG = true
    -- print("Frame Skip Enabled")
  else
    FS_FLAG = false
  end

  ui.beginWindow("Tests", 0, 0, 0, 0)
  local PMemPoint = ui.text("T-pMem.GetPoint:  " .. tostring(pMem.GetPoint(1)))
  local GetPMemValue = ui.text("T-pMem.GetPMemVal:  " .. tostring(pMem.GetPMemValue("P1_X_Position_Arena")))
  local LookUpAddress = ui.text("T-live.LookUpAddress:  " .. tostring(live.LookUpAddress("P1_Knockdown_State")))
  local LookUpValue = ui.text("T-live.LookUpValue:  " .. tostring(live.LookUpValue("P1_Knockdown_State")))
  local LookUpKey = ui.text("T-live.LookUpKey:  " .. tostring(live.LookUpKey("P1_Knockdown_State")))
  local rAdrObj = ui.text("T-display.rAdrObj:  " .. tostring(display.ReadAddressObject("Knockdown_State")))
  -- Create the button to start the sequence
  ui.button('Do Sequence01', function()
    sequence_manager.startSequence(customSequence)
  end)
  ui.button('Move Camera', function()
    sequence_manager.startSequence(move_characters)
  end)

  ui.endWindow()
end

flycast_callbacks = {
  -- start = cbStart,
  -- resume = cbResume,
  overlay = cbOverlay,
  vblank = cbVBlank
}
