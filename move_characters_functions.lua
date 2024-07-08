config = require './training/mvc2_config'
live = require './training/live_functions'

local function movePlayers()
  -- Unlock Camera
  write8(SystemMemoryAddresses.Camera_Lock.Address, 2)
  -- Move Players to Right Corner
  writeFloat(live.LookUpAddress("P1_X_Position_Arena"), 1100)
  writeFloat(live.LookUpAddress("P2_X_Position_Arena"), 1250)
  -- Move Camera
  writeFloat(SystemMemoryAddresses.Camera_X_Position.Address, 960)
  writeFloat(SystemMemoryAddresses.Camera_X_Rotation.Address, 960)
  -- Lock Camera
  -- Wait 
  write8(SystemMemoryAddresses.Camera_Lock.Address, 1)
end

return {
  movePlayers = movePlayers
}
