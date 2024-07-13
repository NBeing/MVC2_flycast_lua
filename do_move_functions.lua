-- Require the configuration module
config = require './training/mvc2_config'
live = require './training/live_functions'

base = live.LookUpAddress("P1_Base")
base2 = live.LookUpAddress("P2_Base")

Anim_AnimID = PlayerMemoryAddresses.Anim_AnimID.hexOffset
Anim_GroupID = PlayerMemoryAddresses.Anim_GroupID.hexOffset
Anim_CurrentAnimPTR = PlayerMemoryAddresses.Anim_CurrentAnimPTR.hexOffset
Animation_Value = PlayerMemoryAddresses.Animation_Value.hexOffset

DAT_FilePTR = PlayerMemoryAddresses.DAT_FilePTR.hexOffset
DAT_AnimationData_PTR = PlayerMemoryAddresses.DAT_AnimationData_PTR.hexOffset

Attack_Number = PlayerMemoryAddresses.Attack_Number.hexOffset

Normal_Strength = PlayerMemoryAddresses.Normal_Strength.hexOffset
Normal_Location = PlayerMemoryAddresses.Normal_Location.hexOffset

Special_Attack_ID = PlayerMemoryAddresses.Special_Attack_ID.hexOffset
Special_Strength = PlayerMemoryAddresses.Special_Strength.hexOffset

-- Set to 0?
Stun_Check = PlayerMemoryAddresses.Stun_Check.hexOffset
Action_Flags = PlayerMemoryAddresses.Action_Flags.hexOffset
Animation_Reset = PlayerMemoryAddresses.Animation_Reset.hexOffset

-- Main state trackers
Knockdown_State = PlayerMemoryAddresses.Knockdown_State.hexOffset
Is_Prox_Block = PlayerMemoryAddresses.Is_Prox_Block.hexOffset

-- Inputs
P1_Input_DEC = Player1And2Addresses.Input_DEC.P1_Input_DEC
P2_Input_DEC = Player1And2Addresses.Input_DEC.P2_Input_DEC

local function ForceNormals()
  write8(base + Anim_GroupID, 7)
  write8(base + Anim_AnimID, 0)
  -- write8(base + Special_Attack_ID, 0)
  -- write8(base + Normal_Strength, 1)
  -- write8(base + Normal_Location, 0)
  -- -- write8(base + 0x1e8, 0) -- chain strength

  -- write8(base + Stun_Check, 0)
  -- write8(base + Action_Flags, 0)
  -- write8(base + Animation_Reset, 0)
  write8(base + Is_Prox_Block, 7)
  write8(base + Knockdown_State, 20)
end

local function ForceSpecials(specialID, specialStrength)
  -- CharacterInfo has Special_Attack_ID _ Special_Strength
  write8(base + Special_Attack_ID, specialID)
  write8(base + Special_Strength, specialStrength)
  write8(base + Stun_Check, 0)
  write8(base + Action_Flags, 0)
  write8(base + Animation_Reset, 0)

  write8(base + Knockdown_State, 21) -- Specials
end

local function ForceSupers(superID)
  -- CharacterInfo has Special_Attack_ID
  write8(base + Special_Attack_ID, superID)
  write8(base + Special_Strength, 1)
  write8(base + Stun_Check, 0)
  write8(base + Action_Flags, 0)
  write8(base + Animation_Reset, 0)

  write8(base + Knockdown_State, 29) -- Supers
end

return {
  ForceNormals = ForceNormals,
  ForceSpecials = ForceSpecials,
  ForceSupers = ForceSupers
}

-- 0x024a and 0x024b seem to be 
-- for assist calling where 24a is a1 and 24b is a2
