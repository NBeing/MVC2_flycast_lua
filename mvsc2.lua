-- Require the configuration module
config = require './training/mvc2_config'
pMem = require './training/player_functions'
display = require './training/display_functions'
live = require './training/live_functions'
--
doMove = require './training/do_move_functions'
sequence_manager = require './training/sequence_manager'
moveChar = require './training/move_characters_functions'
--
ui = config.ui

----
-- Define a custom sequence
local customSequence = {
  {
    waitFrames = 10,
    action = function()
      doMove.ForceSpecials(1)
    end
  },
  {
    waitFrames = 20,
    action = function()
      doMove.ForceSpecials(3)
    end
  }
  -- Add more actions as needed
}

----
function cbVBlank()
  sequence_manager.runSequence()
end

function cbOverlay()
  ui.beginWindow("Tests", 0, 0, 0, 0)
  -- Tests
  -- GetPoint()
  local PMemPoint = ui.text("T-pMem.GetPoint:  " .. tostring(pMem.GetPoint(1)))
  local GetPMemValue = ui.text("T-pMem.GetPMemVal:  " .. tostring(pMem.GetPMemValue("P1_X_Position_Arena")))
  local LookUpAddress = ui.text("T-live.LookUpAddress:  " .. tostring(live.LookUpAddress("P1_Knockdown_State")))
  local LookUpValue = ui.text("T-live.LookUpValue:  " .. tostring(live.LookUpValue("P1_Knockdown_State")))
  local LookUpKey = ui.text("T-live.LookUpKey:  " .. tostring(live.LookUpKey("P1_Knockdown_State")))
  local rAdrObj = ui.text("T-display.rAdrObj:  " .. tostring(display.ReadAddressObject("Knockdown_State")))
  -- Move Players
  ui.button('Move Players Right', function()
    moveChar.movePlayers()
  end)
  -- Create the button to start the sequence
  ui.button('Do Special', function()
    sequence_manager.startSequence(customSequence)
  end)

  ui.endWindow()
end

flycast_callbacks = {
  -- start = cbStart,
  -- resume = cbResume,
  overlay = cbOverlay,
  vblank = cbVBlank
}
