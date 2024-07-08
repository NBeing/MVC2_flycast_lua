-- Require necessary modules
config = require './training/mvc2_config'
live = require './training/live_functions'

local move_characters = {}

-- Define each step of the movePlayers function
move_characters.movePlayersSteps = {
  {
    waitFrames = 0,
    action = function()
      -- Unlock Camera
      write8(SystemMemoryAddresses.Camera_Lock.Address, 2)
      -- Move Players to Right Corner
      writeFloat(live.LookUpAddress("P1_X_Position_Arena"), 1150)
      writeFloat(live.LookUpAddress("P2_X_Position_Arena"), 1200)
      -- Move Camera
      writeFloat(SystemMemoryAddresses.Camera_X_Position.Address, 960)
      writeFloat(SystemMemoryAddresses.Camera_X_Rotation.Address, 960)
    end
  },
  -- {
  --   waitFrames = 1,
  --   action = function()
  --   end
  -- },
  -- {
  --   waitFrames = 1,
  --   action = function()
  --   end
  -- },
  {
    waitFrames = 0,
    action = function()
      write8(SystemMemoryAddresses.Camera_Lock.Address, 1)
    end
  }
}

return move_characters.movePlayersSteps
