-- local BTN_B = 1 << 1 -- hk
-- local BTN_A = 1 << 2  -- lk
-- local BTN_Y = 1 << 9 -- heavy 
-- local BTN_X = 1 << 10 --light poonch
-- local BTN_C = assist 2
-- local BTN_Z = assist 1
-- Imports
-- Util
local util = require './training/utilities'
-- MVC2 Addresses
local mvc2 = util.read_object_from_json_file('./training/data/SPREADSHEET.json')
local jSS = mvc2.SPREADSHEET -- json file: Spreadsheet object (contains other objects)
local jAdr = mvc2.AllAddresses -- json file: AllAddresses (contains unfiltered object with k-v addresses)
local jKeywords = mvc2.Keywords -- json file: Keywords (contains unfiltered object with k-v keywords)

-- Data
local DC_MVC2_MEMORY_TABLE = require './training/data/DC_MVC2_MEMORY_TABLE'
local CHARACTER = require './training/data/characters'
local STAGES = require './training/data/stages'

-- Buttons
-- -- local buttonUtil            = require './training/buttons'

-- Readers / Writers Aliases
local read8 = flycast.memory.read8
local read16 = flycast.memory.read16
local write8 = flycast.memory.write8
local write16 = flycast.memory.write16

-- -- Example will be read8(jAdr.P1_A_Is_Point)

GLOBALS = {
  is_infinite_flight_enabled = false,
  util = util,
  CHARACTER = CHARACTER,
  STAGES = STAGES
  -- MAGNETRO_CHAR_DATA = mvc2
}

function cbStart()

end

function infinite_flight()
  -- print(read8(jAdr.ID_2))
  -- print(flycast.memory.read8(jAdr.ID_2))

  flycast.memory.write16(DC_MVC2_MEMORY_TABLE.p1_char1_magneto_flight_timer, 0xFFFF)
end

local function fire_every_frame()
  if GLOBALS.is_infinite_flight_enabled == true then
    -- print("Infinite flight enabled")
    infinite_flight()
  end
end

time_to_release_pb = nil
started_guarding_frame = nil

-- GetPoint function returns prefix for the on-point && active character for the specified player.
-- 
-- Parameters:
--   - oneOrTwo: A number indicating the player (1 for player 1, 2 for player 2).
-- 
-- Returns:
--   - A string representing the prefix for the on-point && active character for the specified player.
function GetPoint(oneOrTwo)

  -- First we want the player, then the character (a, b or c) who is on point.
  local pointPrefix = '' -- will contain the character that is on point for the specified player.

  if oneOrTwo == 1 then
    if flycast.memory.read8(jAdr.P1_A_Is_Point) == 0 then
      pointPrefix = 'P1_A_'
      return pointPrefix
    elseif flycast.memory.read8(jAdr.P1_B_Is_Point) == 0 then
      pointPrefix = 'P1_B_'
      return pointPrefix
    elseif flycast.memory.read8(jAdr.P1_C_Is_Point) == 0 then
      pointPrefix = 'P1_C_'
      return pointPrefix
    end
  else
    if oneOrTwo == 2 then
      if flycast.memory.read8(jAdr.P2_A_Is_Point) == 0 then
        pointPrefix = 'P2_A_'
        return pointPrefix
      elseif flycast.memory.read8(jAdr.P2_B_Is_Point) == 0 then
        pointPrefix = 'P2_B_'
        return pointPrefix
      elseif flycast.memory.read8(jAdr.P2_C_Is_Point) == 0 then
        pointPrefix = 'P2_C_'
        return pointPrefix
      end
    else
      return
    end
  end
end

function GetPMemUsingPoint(player, address_name)
  local pointCharForPlayer = GetPoint(player)
  local concat = pointCharForPlayer .. address_name
  local lookUp = jAdr[concat]
  return flycast.memory.read8(lookUp) -- Example: P1_A_ .. Health_Big
end

function cbOverlay()
  local ui = flycast.ui
  local MEMORY = flycast.memory
  local current_frame = flycast.memory.read32(DC_MVC2_MEMORY_TABLE.rom_framecount)

  ui.beginWindow("Debug", 100, 10, 300, 0)
  -- local key = jKeywords.ID_2
  -- local val = flycast.memory.read16(jAdr.P1_A_ID_2) -- flycast.memory.read8(0x2C26A51F)
  -- local Camera_X_Position = flycast.memory.read16(0x2C26A56C)
  -- local Camera_X_Rotation = flycast.memory.read16(0x2C26A524)

  -- knockdown_condition = flycast.memory.read8(DC_MVC2_MEMORY_TABLE.p2_char1_knockdown_state) == 32
  -- hitstop_timer = flycast.memory.read8(DC_MVC2_MEMORY_TABLE.p2_char1_hit_stop2)
  -- hitstop_condition = hitstop_timer > 0
  -- p2_char1_being_hit = knockdown_condition and hitstop_condition
  -- knockdown_condition_p1 = flycast.memory.read8(DC_MVC2_MEMORY_TABLE.p1_char1_knockdown_state)
  -- if (knockdown_condition_p1 == 2) then
  --   current_frame_unambiguous = flycast.memory.read32(DC_MVC2_MEMORY_TABLE.rom_framecount)
  --   -- print("It is 2 on frame : " .. current_frame_unambiguous)
  -- end
  -- knockdown_condition_p1_state = flycast.memory.read8(knockdown_condition_p1)

  -- Draw
  flycast.ui.text(string.format("P1_IsPoint: %s", GetPoint(1)))
  flycast.ui.text(string.format("P2_IsPoint: %s", GetPoint(2)))
  flycast.ui.text(string.format("P2_Health_Big: %d", GetPMemUsingPoint(2, 'Health_Big')))

  -- if is_guarding and hitstop_condition then
  --   pushblock(2)
  -- elseif is_guarding and hitstop_timer == 0 then
  --   release_pb(2)
  -- end

  ui.endWindow()

  fire_every_frame()

  if MEMORY.read8(DC_MVC2_MEMORY_TABLE.stage_id) == MEMORY.read8(DC_MVC2_MEMORY_TABLE.stage_id_select) and
    MEMORY.read8(DC_MVC2_MEMORY_TABLE.in_match) == 4 then
    MEMORY.write8(DC_MVC2_MEMORY_TABLE.game_timer, 99)

    ui.beginWindow("Game", 10, 10, 300, 0)
    ui.text("Game Timer")
    ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.game_timer))

    ui.text("Stage")
    ui.rightText(STAGES[MEMORY.read8(DC_MVC2_MEMORY_TABLE.stage_id)])
    ui.endWindow()

    ui.beginWindow("P1", math.floor((flycast.state.display.width / 4) - 125),
      math.floor((flycast.state.display.height / 4) - 50), 250, 0)

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_active) == 1 then
      ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_id) + 1])
    else
      ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_id) + 1])
    end
    ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_health))

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_active) == 1 then
      ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_id) + 1])
    else
      ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_id) + 1])
    end
    ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_health))

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_active) == 1 then
      ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_id) + 1])
    else
      ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_id) + 1])
    end
    ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_health))

    ui.text("")

    ui.text("Level")
    ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_level))

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_active) == 1 then
      ui.text("Character 1 Facing")
      if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_facing_right) == 1 then
        ui.rightText("Right")
      else
        ui.rightText("Left")
      end
    end

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_active) == 1 then
      ui.text("Character 2 Facing")
      if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_facing_right) == 1 then
        ui.rightText("Right")
      else
        ui.rightText("Left")
      end
    end

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_active) == 1 then
      ui.text("Character 3 Facing")
      if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_facing_right) == 1 then
        ui.rightText("Right")
      else
        ui.rightText("Left")
      end
    end

    ui.endWindow()

    ui.beginWindow("P1 Dummy", math.floor((flycast.state.display.width / 4) - 250),
      math.floor((flycast.state.display.height * (3 / 4))) - 125, 160, 0)

    ui.button('P1 char 1 Max Unfly', function()
      flycast.memory.write8(DC_MVC2_MEMORY_TABLE.p1_char1_unfly, 255)
    end)

    ui.button('Magneto be Ballin ok', function()
      GLOBALS.is_infinite_flight_enabled = true
    end)
    ui.button('Do the Funny', function()
      -- doSpecial()
      doSpecial2()
      -- local Camera_Lock = flycast.memory.write8(0x2C26A51F, 0x02)
      -- local Camera_X_Position = flycast.memory.write16(0x2C26A56C, 10000)
      -- local Camera_X_Rotation = flycast.memory.write16(0x2C26A524, 10000)
      -- local Camera_Lock = flycast.memory.write8(0x2C26A51F, 0x00)    
    end)
    ui.button('Do the load', function()
      flycast.emulator.loadState(1)
      jump(1)
      current_frame = flycast.memory.read32(DC_MVC2_MEMORY_TABLE.rom_framecount)
      -- print("Load state occurred on frame:", current_frame)
    end)
    ui.button('Do the save', function()
      current_frame = flycast.memory.read32(DC_MVC2_MEMORY_TABLE.rom_framecount)
      -- print("Save state was saved on frame:", current_frame)
      flycast.emulator.saveState(1)
      -- 24 - 0
      -- 25 - 0
      -- 26 - 2
    end)

    ui.button('Switch Character Ass', function()
      switch_character_a(1)
    end)
    ui.button('Switch Character B', function()
      switch_character_b(1)
    end)

    ui.button('Jump', function()
      jump(1)
    end)
    ui.button('Forward', function()
      forward(1, MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_facing_right))
    end)
    ui.button('Back', function()
      block(1, MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_facing_right))
    end)
    ui.button('Crouch', function()
      crouch(1)
    end)
    ui.button('Release', function()
      release_all(1)
    end)

    ui.endWindow()

    ui.beginWindow("P2", math.floor((flycast.state.display.width * (3 / 4)) - 125),
      math.floor((flycast.state.display.height / 4) - 50), 250, 0)

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_active) == 1 then
      ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_id) + 1])
    else
      ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_id) + 1])
    end
    ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_health))

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_active) == 1 then
      ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_id) + 1])
    else
      ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_id) + 1])
    end
    ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_health))

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_active) == 1 then
      ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_id) + 1])
    else
      ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_id) + 1])
    end
    ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_health))

    ui.text("")

    ui.text("Level")
    ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_level))

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_active) == 1 then
      ui.text("Character 1 Facing")
      if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_facing_right) == 1 then
        ui.rightText("Right")
      else
        ui.rightText("Left")
      end
    end

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_active) == 1 then
      ui.text("Character 2 Facing")
      if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_facing_right) == 1 then
        ui.rightText("Right")
      else
        ui.rightText("Left")
      end
    end

    if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_active) == 1 then
      ui.text("Character 3 Facing")
      if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_facing_right) == 1 then
        ui.rightText("Right")
      else
        ui.rightText("Left")
      end
    end

    ui.endWindow()

    ui.beginWindow("P2 Dummy", math.floor(flycast.state.display.width * (3 / 4)) + 125,
      math.floor(flycast.state.display.height * (3 / 4)) - 125, 160, 0)

    ui.button('Switch Character A', function()
      switch_character_a(2)
    end)
    ui.button('Switch Character B', function()
      switch_character_b(2)
    end)

    ui.button('Jump', function()
      jump(2)
    end)
    ui.button('Forward', function()
      forward(2, MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_facing_right))
    end)
    ui.button('Back', function()
      block(2, MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_facing_right))
    end)
    ui.button('Crouch', function()
      crouch(2)
    end)
    ui.button('Release', function()
      release_all(2)
    end)

    ui.endWindow()
  end
end

function release_pb(player)
  time_to_release_pb = nil
  flycast.input.releaseButtons(player, BTN_X | BTN_Y)
end
function pushblock(player)
  current_frame = flycast.memory.read32(DC_MVC2_MEMORY_TABLE.rom_framecount)
  flycast.input.pressButtons(player, BTN_X | BTN_Y)
  -- if time_to_release_pb == nil then
  --     time_to_release_pb = current_frame + 2 
  -- end
  -- release_all(player)

end
function switch_character_a(player)
  release_all(player)

  local BTN_B = 1 << 1
  local BTN_A = 1 << 2
  local BTN_Y = 1 << 9
  local BTN_X = 1 << 10
  flycast.input.pressButtons(player, BTN_X | BTN_A)

end

function switch_character_b(player)
  release_all(player)

  local BTN_B = 1 << 1
  local BTN_A = 1 << 2
  local BTN_Y = 1 << 9
  local BTN_X = 1 << 10
  flycast.input.pressButtons(player, BTN_Y | BTN_B)

end
function doSpecial()
  -- 0x8C268340 --based
  -- local based = 0x8C268340 --p1
  local based2 = 0x8C2688E4 -- p2
  flycast.memory.write8(based2 + 0x01E9, 0x4) -- special id
  flycast.memory.write8(based2 + 0x01A3, 0x0) -- strength
  flycast.memory.write8(based2 + 0x05, 0x0) -- reset anim
  flycast.memory.write8(based2 + 0x06, 0x0) -- reset anim
  flycast.memory.write8(based2 + 0x07, 0x0) -- reset anim ???
  flycast.memory.write8(based2 + 0x01d0, 0x15) -- set special move state

  -- local based = 0x8C268340 --p1
  local based1 = 0x8C268340 -- p2
  flycast.memory.write8(based1 + 0x01E9, 0x4) -- special id
  flycast.memory.write8(based1 + 0x01A3, 0x0) -- strength
  flycast.memory.write8(based1 + 0x05, 0x0) -- reset anim
  flycast.memory.write8(based1 + 0x06, 0x0) -- reset anim
  flycast.memory.write8(based1 + 0x07, 0x0) -- reset anim ???
  flycast.memory.write8(based1 + 0x01d0, 0x15) -- set special move state
end
function doSpecial2()
  -- 0x8C268340 --based
  -- local based = 0x8C268340 --p1
  local based2 = 0x8C268340 -- p2
  flycast.memory.write8(based2 + 0x01E9, 0xB) -- special id
  flycast.memory.write8(based2 + 0x01A3, 0x0) -- strength
  flycast.memory.write8(based2 + 0x05, 0x0) -- reset anim
  flycast.memory.write8(based2 + 0x06, 0x0) -- reset anim
  flycast.memory.write8(based2 + 0x07, 0x0) -- reset anim ???
  flycast.memory.write8(based2 + 0x01d0, 0x1D) -- set special move state

end

function jump(player)
  local DPAD_DOWN = 1 << 5
  local DPAD_UP = 1 << 4
  flycast.input.releaseButtons(player, DPAD_DOWN)
  flycast.input.pressButtons(player, DPAD_UP)
end

function forward(player, facing_right)
  local DPAD_LEFT = 1 << 6
  local DPAD_RIGHT = 1 << 7
  if facing_right == 1 then
    flycast.input.releaseButtons(player, DPAD_LEFT)
    flycast.input.pressButtons(player, DPAD_RIGHT)
  else
    flycast.input.releaseButtons(player, DPAD_RIGHT)
    flycast.input.pressButtons(player, DPAD_LEFT)
  end
end

function block(player, facing_right)
  local DPAD_LEFT = 1 << 6
  local DPAD_RIGHT = 1 << 7
  if facing_right == 1 then
    flycast.input.releaseButtons(player, DPAD_RIGHT)
    flycast.input.pressButtons(player, DPAD_LEFT)
  else
    flycast.input.releaseButtons(player, DPAD_LEFT)
    flycast.input.pressButtons(player, DPAD_RIGHT)
  end
end

function crouch(player)
  local DPAD_UP = 1 << 4
  local DPAD_DOWN = 1 << 5

  flycast.input.releaseButtons(player, DPAD_UP)
  flycast.input.pressButtons(player, DPAD_DOWN)
end

function crouch_block(player, facing_right)
  release_all(player)
  local DPAD_DOWN = 1 << 5
  local DPAD_LEFT = 1 << 6
  local DPAD_RIGHT = 1 << 7

  if facing_right == 1 then
    flycast.input.pressButtons(player, DPAD_DOWN | DPAD_LEFT)
  else
    flycast.input.pressButtons(player, DPAD_DOWN | DPAD_RIGHT)
  end
end

function release_all(player)
  local DPAD_UP = 1 << 4
  local DPAD_DOWN = 1 << 5
  local DPAD_LEFT = 1 << 6
  local DPAD_RIGHT = 1 << 7

  local BTN_B = 1 << 1
  local BTN_A = 1 << 2
  local BTN_Y = 1 << 9
  local BTN_X = 1 << 10

  flycast.input.releaseButtons(player, DPAD_UP | DPAD_DOWN | DPAD_LEFT | DPAD_RIGHT)
  flycast.input.releaseButtons(player, BTN_X | BTN_A | BTN_Y | BTN_B)

  GLOBALS.is_infinite_flight_enabled = false
  flycast.memory.write16(DC_MVC2_MEMORY_TABLE.p1_char1_magneto_flight_timer, 0x00)

end

-- local playing = false
-- local frame_started = flycast.state.getFrameNumber()
-- local frametable = buttonUtil.test_input_table()
-- function cbVBlank()
--   -- Timer Infinite
--   --  flycast.memory.write8(0x8c289630, 0x63)
--   local fc = flycast.state.getFrameNumber()
--    -- release_all_buttons_DC()
--    if playing and fc > frame_started then
--      if frametable[fc - frame_started] ~= nil then
--        print("Should play", fc, frame_started, frametable[fc - frame_started])
--        buttonUtil.setFriendlyKeys_DC(frametable[fc - frame_started])
--      else
--        print("Stopping dude")
--        playing = false
--        buttonUtil.release_all_buttons_DC()
--      end
--    end
--  end

flycast_callbacks = {
  start = cbStart,
  overlay = cbOverlay,
  vblank = cbVBlank
}

-- print("Callback set")
-- f = 0
