-- interfaces.lua
-- Interface for PlayerMemoryAddress
PlayerMemoryAddress = {
  "Description",
  "hexOffset",
  "decOffset",
  "Type",
  "Note1",
  "Note2",
  -- Allows for dynamic keys
  __index = function(t, k)
    return rawget(t, k)
  end
}

-- Interface for SpecificCharacterAddresses
SpecificCharacterAddresses = {
  "Description",
  "Type",
  "Note1",
  "Note2",
  -- Allows for dynamic keys
  __index = function(t, k)
    return rawget(t, k)
  end
}

-- Interface for Player1And2Addresses
Player1And2Addresses = {
  "Description",
  "Type",
  "Note1",
  "Note2",
  -- Allows for dynamic keys
  __index = function(t, k)
    return rawget(t, k)
  end
}

-- Interface for SystemMemoryAddresses
SystemMemoryAddresses = {
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
CharacterInfo = {
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
StagesInfo = {
  "Dec",
  "Hex",
  "Name",
  "Custom2",
  "Custom3"
}

-- Interface for InputsInfo
InputsInfo = {
  "Dec",
  "Hex",
  "Custom1",
  "Custom2",
  "Name"
}

return {
  PlayerMemoryAddress = PlayerMemoryAddress,
  SpecificCharacterAddresses = SpecificCharacterAddresses,
  Player1And2Addresses = Player1And2Addresses,
  SystemMemoryAddresses = SystemMemoryAddresses,
  CharacterInfo = CharacterInfo,
  StagesInfo = StagesInfo,
  InputsInfo = InputsInfo
}
