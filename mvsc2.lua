-- Require the configuration module
config = require './training/mvc2_config'
pMem = require './training/player_functions'
display = require './training/display_functions'

ui = config.ui

function cbOverlay()

  ui.beginWindow("New", 100, 10, 300, 0)
  -- Draw
  ui.text(display.displayPMem(1, "Knockdown_State"))
  ui.text(display.displayPMem(2, "Knockdown_State"))
  ui.text(display.displayJSONContents(config.PlayerMemoryAddresses.Knockdown_State))
  ui.endWindow()

  -- if MEMORY.read8(DC_MVC2_MEMORY_TABLE.stage_id) == MEMORY.read8(DC_MVC2_MEMORY_TABLE.stage_id_select) and
  --   MEMORY.read8(DC_MVC2_MEMORY_TABLE.in_match) == 4 then
  --   MEMORY.write8(DC_MVC2_MEMORY_TABLE.game_timer, 99)

  --   ui.beginWindow("Game", 10, 10, 300, 0)
  --   ui.text("Game Timer")
  --   ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.game_timer))

  --   ui.text("Stage")
  --   ui.rightText(STAGES[MEMORY.read8(DC_MVC2_MEMORY_TABLE.stage_id)])
  --   ui.endWindow()

  --   ui.beginWindow("P1", math.floor((flycast.state.display.width / 4) - 125),
  --     math.floor((flycast.state.display.height / 4) - 50), 250, 0)

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_active) == 1 then
  --     ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_id) + 1])
  --   else
  --     ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_id) + 1])
  --   end
  --   ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_health))

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_active) == 1 then
  --     ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_id) + 1])
  --   else
  --     ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_id) + 1])
  --   end
  --   ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_health))

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_active) == 1 then
  --     ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_id) + 1])
  --   else
  --     ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_id) + 1])
  --   end
  --   ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_health))

  --   ui.text("")

  --   ui.text("Level")
  --   ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_level))

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_active) == 1 then
  --     ui.text("Character 1 Facing")
  --     if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_facing_right) == 1 then
  --       ui.rightText("Right")
  --     else
  --       ui.rightText("Left")
  --     end
  --   end

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_active) == 1 then
  --     ui.text("Character 2 Facing")
  --     if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char2_facing_right) == 1 then
  --       ui.rightText("Right")
  --     else
  --       ui.rightText("Left")
  --     end
  --   end

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_active) == 1 then
  --     ui.text("Character 3 Facing")
  --     if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char3_facing_right) == 1 then
  --       ui.rightText("Right")
  --     else
  --       ui.rightText("Left")
  --     end
  --   end

  --   ui.endWindow()

  --   ui.beginWindow("P1 Dummy", math.floor((flycast.state.display.width / 4) - 250),
  --     math.floor((flycast.state.display.height * (3 / 4))) - 125, 160, 0)

  --   ui.button('P1 char 1 Max Unfly', function()
  --     flycast.memory.write8(DC_MVC2_MEMORY_TABLE.p1_char1_unfly, 255)
  --   end)

  --   ui.button('Do the Funny', function()
  --     -- doSpecial()
  --     doSpecial2()
  --     -- local Camera_Lock = flycast.memory.write8(0x2C26A51F, 0x02)
  --     -- local Camera_X_Position = flycast.memory.write16(0x2C26A56C, 10000)
  --     -- local Camera_X_Rotation = flycast.memory.write16(0x2C26A524, 10000)
  --     -- local Camera_Lock = flycast.memory.write8(0x2C26A51F, 0x00)    
  --   end)
  --   ui.button('Do the load', function()
  --     flycast.emulator.loadState(1)
  --     jump(1)
  --     CURRENT_FRAME = flycast.memory.read32(DC_MVC2_MEMORY_TABLE.rom_framecount)
  --     print("Load state occurred on frame:", CURRENT_FRAME)
  --   end)
  --   ui.button('Do the save', function()
  --     CURRENT_FRAME = flycast.memory.read32(DC_MVC2_MEMORY_TABLE.rom_framecount)
  --     print("Save state was saved on frame:", CURRENT_FRAME)
  --     flycast.emulator.saveState(1)
  --     -- 24 - 0
  --     -- 25 - 0
  --     -- 26 - 2
  --   end)

  --   ui.button('Switch Character Ass', function()
  --     switch_character_a(1)
  --   end)
  --   ui.button('Switch Character B', function()
  --     switch_character_b(1)
  --   end)

  --   ui.button('Jump', function()
  --     jump(1)
  --   end)
  --   ui.button('Forward', function()
  --     forward(1, MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_facing_right))
  --   end)
  --   ui.button('Back', function()
  --     block(1, MEMORY.read8(DC_MVC2_MEMORY_TABLE.p1_char1_facing_right))
  --   end)
  --   ui.button('Crouch', function()
  --     crouch(1)
  --   end)
  --   ui.button('Release', function()
  --     release_all(1)
  --   end)

  --   ui.endWindow()

  --   ui.beginWindow("P2", math.floor((flycast.state.display.width * (3 / 4)) - 125),
  --     math.floor((flycast.state.display.height / 4) - 50), 250, 0)

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_active) == 1 then
  --     ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_id) + 1])
  --   else
  --     ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_id) + 1])
  --   end
  --   ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_health))

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_active) == 1 then
  --     ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_id) + 1])
  --   else
  --     ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_id) + 1])
  --   end
  --   ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_health))

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_active) == 1 then
  --     ui.text("* " .. CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_id) + 1])
  --   else
  --     ui.text(CHARACTER[MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_id) + 1])
  --   end
  --   ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_health))

  --   ui.text("")

  --   ui.text("Level")
  --   ui.rightText(MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_level))

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_active) == 1 then
  --     ui.text("Character 1 Facing")
  --     if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_facing_right) == 1 then
  --       ui.rightText("Right")
  --     else
  --       ui.rightText("Left")
  --     end
  --   end

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_active) == 1 then
  --     ui.text("Character 2 Facing")
  --     if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char2_facing_right) == 1 then
  --       ui.rightText("Right")
  --     else
  --       ui.rightText("Left")
  --     end
  --   end

  --   if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_active) == 1 then
  --     ui.text("Character 3 Facing")
  --     if MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char3_facing_right) == 1 then
  --       ui.rightText("Right")
  --     else
  --       ui.rightText("Left")
  --     end
  --   end

  --   ui.endWindow()

  --   ui.beginWindow("P2 Dummy", math.floor(flycast.state.display.width * (3 / 4)) + 125,
  --     math.floor(flycast.state.display.height * (3 / 4)) - 125, 160, 0)

  --   ui.button('Switch Character A', function()
  --     switch_character_a(2)
  --   end)
  --   ui.button('Switch Character B', function()
  --     switch_character_b(2)
  --   end)

  --   ui.button('Jump', function()
  --     jump(2)
  --   end)
  --   ui.button('Forward', function()
  --     forward(2, MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_facing_right))
  --   end)
  --   ui.button('Back', function()
  --     block(2, MEMORY.read8(DC_MVC2_MEMORY_TABLE.p2_char1_facing_right))
  --   end)
  --   ui.button('Crouch', function()
  --     crouch(2)
  --   end)
  --   ui.button('Release', function()
  --     release_all(2)
  --   end)

  --   ui.endWindow()
  -- end
end

-- function release_pb(player)
--   time_to_release_pb = nil
--   flycast.input.releaseButtons(player, BTN_X | BTN_Y)
-- end
-- function pushblock(player)
--   CURRENT_FRAME = flycast.memory.read32(DC_MVC2_MEMORY_TABLE.rom_framecount)
--   flycast.input.pressButtons(player, BTN_X | BTN_Y)
--   -- if time_to_release_pb == nil then
--   --     time_to_release_pb = current_frame + 2 
--   -- end
--   -- release_all(player)

-- end
-- function switch_character_a(player)
--   release_all(player)

--   local BTN_B = 1 << 1
--   local BTN_A = 1 << 2
--   local BTN_Y = 1 << 9
--   local BTN_X = 1 << 10
--   flycast.input.pressButtons(player, BTN_X | BTN_A)

-- end

-- function switch_character_b(player)
--   release_all(player)

--   local BTN_B = 1 << 1
--   local BTN_A = 1 << 2
--   local BTN_Y = 1 << 9
--   local BTN_X = 1 << 10
--   flycast.input.pressButtons(player, BTN_Y | BTN_B)

-- end
-- function doSpecial()
--   -- 0x8C268340 --based
--   -- local based = 0x8C268340 --p1
--   local based2 = 0x8C2688E4 -- p2
--   flycast.memory.write8(based2 + 0x01E9, 0x4) -- special id
--   flycast.memory.write8(based2 + 0x01A3, 0x0) -- strength
--   flycast.memory.write8(based2 + 0x05, 0x0) -- reset anim
--   flycast.memory.write8(based2 + 0x06, 0x0) -- reset anim
--   flycast.memory.write8(based2 + 0x07, 0x0) -- reset anim ???
--   flycast.memory.write8(based2 + 0x01d0, 0x15) -- set special move state

--   -- local based = 0x8C268340 --p1
--   local based1 = 0x8C268340 -- p2
--   flycast.memory.write8(based1 + 0x01E9, 0x4) -- special id
--   flycast.memory.write8(based1 + 0x01A3, 0x0) -- strength
--   flycast.memory.write8(based1 + 0x05, 0x0) -- reset anim
--   flycast.memory.write8(based1 + 0x06, 0x0) -- reset anim
--   flycast.memory.write8(based1 + 0x07, 0x0) -- reset anim ???
--   flycast.memory.write8(based1 + 0x01d0, 0x15) -- set special move state
-- end
-- function doSpecial2()
--   -- 0x8C268340 --based
--   -- local based = 0x8C268340 --p1
--   local based2 = 0x8C268340 -- p2
--   flycast.memory.write8(based2 + 0x01E9, 0xB) -- special id
--   flycast.memory.write8(based2 + 0x01A3, 0x0) -- strength
--   flycast.memory.write8(based2 + 0x05, 0x0) -- reset anim
--   flycast.memory.write8(based2 + 0x06, 0x0) -- reset anim
--   flycast.memory.write8(based2 + 0x07, 0x0) -- reset anim ???
--   flycast.memory.write8(based2 + 0x01d0, 0x1D) -- set special move state

-- end

-- function jump(player)
--   local DPAD_DOWN = 1 << 5
--   local DPAD_UP = 1 << 4
--   flycast.input.releaseButtons(player, DPAD_DOWN)
--   flycast.input.pressButtons(player, DPAD_UP)
-- end

-- function forward(player, facing_right)
--   local DPAD_LEFT = 1 << 6
--   local DPAD_RIGHT = 1 << 7
--   if facing_right == 1 then
--     flycast.input.releaseButtons(player, DPAD_LEFT)
--     flycast.input.pressButtons(player, DPAD_RIGHT)
--   else
--     flycast.input.releaseButtons(player, DPAD_RIGHT)
--     flycast.input.pressButtons(player, DPAD_LEFT)
--   end
-- end

-- function block(player, facing_right)
--   local DPAD_LEFT = 1 << 6
--   local DPAD_RIGHT = 1 << 7
--   if facing_right == 1 then
--     flycast.input.releaseButtons(player, DPAD_RIGHT)
--     flycast.input.pressButtons(player, DPAD_LEFT)
--   else
--     flycast.input.releaseButtons(player, DPAD_LEFT)
--     flycast.input.pressButtons(player, DPAD_RIGHT)
--   end
-- end

-- function crouch(player)
--   local DPAD_UP = 1 << 4
--   local DPAD_DOWN = 1 << 5

--   flycast.input.releaseButtons(player, DPAD_UP)
--   flycast.input.pressButtons(player, DPAD_DOWN)
-- end

-- function crouch_block(player, facing_right)
--   release_all(player)
--   local DPAD_DOWN = 1 << 5
--   local DPAD_LEFT = 1 << 6
--   local DPAD_RIGHT = 1 << 7

--   if facing_right == 1 then
--     flycast.input.pressButtons(player, DPAD_DOWN | DPAD_LEFT)
--   else
--     flycast.input.pressButtons(player, DPAD_DOWN | DPAD_RIGHT)
--   end
-- end

-- function release_all(player)
--   local DPAD_UP = 1 << 4
--   local DPAD_DOWN = 1 << 5
--   local DPAD_LEFT = 1 << 6
--   local DPAD_RIGHT = 1 << 7

--   local BTN_B = 1 << 1
--   local BTN_A = 1 << 2
--   local BTN_Y = 1 << 9
--   local BTN_X = 1 << 10

--   flycast.input.releaseButtons(player, DPAD_UP | DPAD_DOWN | DPAD_LEFT | DPAD_RIGHT)
--   flycast.input.releaseButtons(player, BTN_X | BTN_A | BTN_Y | BTN_B)

--   flycast.memory.write16(DC_MVC2_MEMORY_TABLE.p1_char1_magneto_flight_timer, 0x00)

-- end

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
  -- start = cbStart,
  overlay = cbOverlay
  -- vblank = cbVBlank
}
