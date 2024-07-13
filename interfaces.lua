-- interfaces.lua
-- Interface for PlayerMemoryAddresses
local PlayerMemoryAddresses = {
  "Description",
  "hexOffset",
  "decOffset",
  "Type",
  "Note1",
  "Note2",
  -- Dynamic keys like "P1_A_", "P1_B_", etc.
  __index = function(t, k)
    if k:match("^P[12]_[ABC]_.*") then
      return rawget(t, k)
    end
    return rawget(t, k)
  end
}

-- Interface for SpecificCharacterAddresses
local SpecificCharacterAddresses = {
  "Description",
  "Type",
  "Note1",
  "Note2",
  -- Dynamic keys like "P1_A_", "P1_B_", etc.
  __index = function(t, k)
    if k:match("^P[12]_[ABC]_.*") then
      return rawget(t, k)
    end
    return rawget(t, k)
  end
}

-- Interface for Player1And2Addresses
local Player1And2Addresses = {
  "Description",
  "Type",
  "Note1",
  "Note2",
  -- Dynamic keys like "P1_", "P2_", etc.
  __index = function(t, k)
    if k:match("^P[12]_.*") then
      return rawget(t, k)
    end
    return rawget(t, k)
  end
}

-- Interface for SystemMemoryAddresses
local SystemMemoryAddresses = {
  "Description",
  "Address",
  "Type",
  "Note1",
  "Note2",
  -- Allows for dynamic keys
  __index = function(t, k)
    return rawget(t, k)
  end
}

-- Information-Only Objects

-- Interface for CharacterInfo
local CharacterInfo = {
  "Dec",
  "Hex",
  "ENNameDev",
  "ENNamePub",
  "AAssist",
  "BAssist",
  "YAssist",
  "AInput",
  "BInput",
  "YInput",
  "ATHC",
  "BTHC",
  "YTHC",
  "ACounter",
  "BCounter",
  "YCounter",
  "SpecialID_0_0",
  "SpecialID_1_0",
  "SpecialID_2_0",
  "SpecialID_3_0",
  "SpecialID_4_0",
  "SpecialID_5_0",
  "SpecialID_6_0",
  "SpecialID_7_0",
  "SpecialID_8_0",
  "SpecialID_9_0",
  "SpecialID_10_0",
  "SpecialID_11_0",
  "SpecialID_12_0",
  "SpecialID_13_0",
  "SpecialID_14_0",
  "SpecialID_15_0",
  "SpecialID_16_0",
  "SpecialID_17_0",
  "SpecialID_18_0",
  "SpecialID_19_0",
  "SpecialID_20_0",
  "SpecialID_0_1",
  "SpecialID_1_1",
  "SpecialID_2_1",
  "SpecialID_3_1",
  "SpecialID_4_1",
  "SpecialID_5_1",
  "SpecialID_6_1",
  "SpecialID_7_1",
  "SpecialID_8_1",
  "SpecialID_9_1",
  "SpecialID_10_1",
  "SpecialID_11_1",
  "SpecialID_12_1",
  "SpecialID_13_1",
  "SpecialID_14_1",
  "SpecialID_15_1",
  "SpecialID_16_1",
  "SpecialID_17_1",
  "SpecialID_18_1",
  "SpecialID_19_1",
  "SpecialID_20_1",
  "Note1",
  "Note2"
}

-- Interface for StagesInfo
local StagesInfo = {
  "Name",
  "Dec",
  "Hex",
  "Custom1",
  "Custom2"
}

-- Interface for InputsInfo
local InputsInfo = {
  "Name",
  "Dec",
  "Hex",
  "Custom1",
  "Custom2"
}

return {
  PlayerMemoryAddresses = PlayerMemoryAddresses,
  SpecificCharacterAddresses = SpecificCharacterAddresses,
  Player1And2Addresses = Player1And2Addresses,
  SystemMemoryAddresses = SystemMemoryAddresses,
  CharacterInfo = CharacterInfo,
  StagesInfo = StagesInfo,
  InputsInfo = InputsInfo
}
