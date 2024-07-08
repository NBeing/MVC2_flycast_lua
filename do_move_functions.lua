-- Require the configuration module
config = require './training/mvc2_config'
live = require './training/live_functions'

local function ForceSpecials(specialID)
  local base = live.LookUpAddress("P1_Base")
  local Special_Attack_ID = PlayerMemoryAddresses.Special_Attack_ID.hexOffset
  local Special_Strength = PlayerMemoryAddresses.Special_Strength.hexOffset
  local Stun_Check = PlayerMemoryAddresses.Stun_Check.hexOffset
  local Action_Flags = PlayerMemoryAddresses.Action_Flags.hexOffset
  local Animation_Reset = PlayerMemoryAddresses.Animation_Reset.hexOffset
  local Knockdown_State = PlayerMemoryAddresses.Knockdown_State.hexOffset

  write8(base + Special_Attack_ID, specialID)
  write8(base + Special_Strength, 0)
  write8(base + Stun_Check, 0)
  write8(base + Action_Flags, 0)
  write8(base + Animation_Reset, 0)
  write16(base + Knockdown_State, 21) -- Special_Attacks
end

return {
  ForceSpecials = ForceSpecials
}
