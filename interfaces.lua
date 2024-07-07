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
  "Note1",
  "Note2"
}

-- Interface for StagesInfo
local StagesInfo = {
  "Dec",
  "Hex",
  "Name",
  "Custom2",
  "Custom3"
}

-- Interface for InputsInfo
local InputsInfo = {
  "Dec",
  "Hex",
  "Custom1",
  "Custom2",
  "Name"
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
