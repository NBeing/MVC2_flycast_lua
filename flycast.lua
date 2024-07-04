local BTN_B = 1 << 1 -- hk
local BTN_A = 1 << 2  -- lk
local BTN_Y = 1 << 9 -- heavy 
local BTN_X = 1 << 10 --light poonch
-- c == assist 2
-- z == assist 1

DC_MVC2_MEMORY_TABLE = {
  ['game_timer'] = 0x2C289630,
  ['stage_id'] = 0x2C289638,
  ['stage_id_select'] = 0x22C26A95C,
  ['p1_level'] = 0x2C28964A,
  ['p1_char1_facing_right'] = 0x2C268450,
  ['p1_char2_facing_right'] = 0x2C268F98,
  ['p1_char3_facing_right'] = 0x2C269AE0,
  ['p1_char1_id'] = 0x2C268341,
  ['p1_char2_id'] = 0x2C268E89,
  ['p1_char3_id'] = 0x2C2699D1,
  ['p1_char1_active'] = 0x2C268340,
  ['p1_char2_active'] = 0x2C268E88,
  ['p1_char3_active'] = 0x2C2699D0,
  ['p1_char1_health'] = 0x2C268760,
  ['p1_char2_health'] = 0x2C2692A8,
  ['p1_char3_health'] = 0x2C269DF0,
  ['p2_level'] = 0x2C28964B,
  ['p2_char1_facing_right'] = 0x2C2689F4,
  ['p2_char2_facing_right'] = 0x2C26953C,
  ['p2_char3_facing_right'] = 0x2C26A084,
  ['p2_char1_id'] = 0x2C2688E5,
  ['p2_char2_id'] = 0x2C26942D,
  ['p2_char3_id'] = 0x2C269F75,
  ['p2_char1_active'] = 0x2C2688E4,
  ['p2_char2_active'] = 0x2C26942C,
  ['p2_char3_active'] = 0x2C269F74,
  ['p2_char1_health'] = 0x2C268D04,
  ['p2_char2_health'] = 0x2C26984C,
  ['p2_char3_health'] = 0x2C26A394,
  ['in_match'] = 0x2C2895F0,
  ['p1_char1_magneto_flight_timer'] = 0x2C2685EA, -- Flight Timer (Magneto)	2C2685EA
  -- P1_A_Unfly,2C268516,0,Byte
  -- P1_B_Unfly,2C26905E,0,Byte
  -- P1_C_Unfly,2C269BA6,0,Byte
  -- P2_A_Unfly,2C268ABA,255,Byte
  -- P2_B_Unfly,2C269602,0,Byte
  -- P2_C_Unfly,2C26A14A,0,Byte
  ['p1_char1_unfly'] = 0x2C268516,
  ['p2_char2_block_stun'] = 0x2C26960A,
  
  -- Knockdown_State,,,Byte
  -- P1_A_Knockdown_State,2C268510,0,Byte
  -- P1_B_Knockdown_State,2C269058,0,Byte
  -- P1_C_Knockdown_State,2C269BA0,0,Byte
  -- P2_A_Knockdown_State,2C268AB4,0,Byte
  -- P2_B_Knockdown_State,2C2695FC,0,Byte
  -- P2_C_Knockdown_State,2C26A144,0,Byte
  ['p1_char1_hit_stop2'] = 0x2C2684E0,
  ['p1_char2_hit_stop2'] = 0x2C269028,
  ['p1_char3_hit_stop2'] = 0x2C269B70,
  ['p2_char1_hit_stop2'] = 0x2C268A84,
  ['p2_char2_hit_stop2'] = 0x2C2695CC,
  ['p2_char3_hit_stop2'] = 0x2C26A114,
  ['p2_char1_knockdown_state'] = 0x2C268AB4,

    --   Throw_Counter_Mash,,,Byte
    -- P1_A_Throw_Counter_Mash,2C26859C,0,2 Byte
    -- P1_B_Throw_Counter_Mash,2C2690E4,0,2 Byte
    -- P1_C_Throw_Counter_Mash,2C269C2C,0,2 Byte
    -- P2_A_Throw_Counter_Mash,2C268B40,0,2 Byte
    -- P2_B_Throw_Counter_Mash,2C269688,0,2 Byte
    -- P2_C_Throw_Counter_Mash,2C26A1D0,0,2 Byte

    -- implement no dizzy, set to 80
--     P1_A_Dizzy	2C268521	80	Byte
-- P1_B_Dizzy	2C269069	80	Byte
-- P1_C_Dizzy	2C269BB1	80	Byte
-- P2_A_Dizzy	2C268AC5	80	Byte
-- P2_B_Dizzy	2C26960D	80	Byte
-- P2_C_Dizzy	2C26A155	80	Byte
['p1_char1_is_point'] = 0x2C268751,
['p1_char2_is_point'] = 0x2C269299,
['p1_char3_is_point'] = 0x2C269DE1,
['p2_char1_is_point'] = 0x2C268CF5,
['p2_char2_is_point'] = 0x2C26983D,
['p2_char3_is_point'] = 0x2C26A385,
-- is point
-- Is_Point,,,Byte
-- P1_A_Is_Point,2C268751,0,Byte
-- P1_B_Is_Point,2C269299,1,Byte
-- P1_C_Is_Point,2C269DE1,2,Byte
-- P2_A_Is_Point,2C268CF5,0,Byte
-- P2_B_Is_Point,2C26983D,1,Byte
-- P2_C_Is_Point,2C26A385,2,Byte

-- This is really like player status 2 in VSAV
-- Is_ProxBlock,,,Byte
-- P1_A_Is_Prox_Block,2C268499,0,Byte
-- P1_B_Is_Prox_Block,2C268FE1,24,Byte
-- P1_C_Is_Prox_Block,2C269B29,24,Byte
-- P2_A_Is_Prox_Block,2C268A3D,0,Byte
-- P2_B_Is_Prox_Block,2C269585,24,Byte
-- P2_C_Is_Prox_Block,2C26A0CD,24,Byte
['p2_char1_status2'] = 0x2C268A3D,
['p2_char2_status2'] = 0x2C269585,
['rom_framecount'] = 0x2C1F9D80


}

CHARACTER = {"Ryu", "Zangief", "Guile", "Morrigan", "Anakaris", "Strider", "Cyclops", "Wolverine", "Psylocke", "Iceman",
           "Rogue", "Captain America", "Spider-Man", "Hulk", "Venom", "Dr. Doom", "Tron Bonne", "Jill", "Hayato",
           "Ruby Heart", "Son Son", "Amingo", "Marrow", "Cable", "Abyss 1", "Abyss 2", "Abyss 3", "Chun-Li",
           "Mega Man", "Roll", "Akuma", "Bulleta", "Felicia", "Charlie", "Sakura", "Dan", "Cammy", "Dhalsim",
           "Dictator", "Ken", "Gambit", "Juggernaut", "Storm", "Sabretooth", "Magneto", "Shuma Gorath", "War Machine",
           "Silver Samurai", "Omega Red", "Spiral", "Colossus", "Iron Man", "Sentinel", "Blackheart", "Thanos", "Jin",
           "Captain Commando", "Bone Wolverine", "Servbot"}

STAGES = {"Airship", "Desert", "Industrial", "Circus", "Swamp", "Cavern", "Clock Tower", "River", "Abyss Temple",
        "Airship (Alt)", "Desert (Alt)", "Circus (Alt)", "Swamp (Alt)", "Cavern (Alt)", "Clock Tower (Alt)",
        "River (Alt)"}

GLOBALS = {
  is_infinite_flight_enabled = false
}
function cbStart()
  local s = flycast.state
  print("Game started: " .. s.media)
  print("Game Id: " .. s.gameId)
  print("Display: " .. s.display.width .. "x" .. s.display.height)
end

function infinite_flight()
  print("Calling inf flight function")
  flycast.memory.write16(DC_MVC2_MEMORY_TABLE.p1_char1_magneto_flight_timer, 0xFFFF)
end

local function fire_every_frame()
  if GLOBALS.is_infinite_flight_enabled == true then

    infinite_flight()
  end
end

time_to_release_pb = nil
started_guarding_frame = nil
--  hitstop == 0       hitstop > 0             hitstop == 0
-- pre block          --> block -->     post block (returns to preblock)

function get_point_char_prefix(player)
    local player_str = ''
    if player == 1 then
        player_str = 'p1_'
    else 
        player_str = 'p2_'
    end
    if flycast.memory.read8(DC_MVC2_MEMORY_TABLE[player_str..'char1_is_point']) == 0 then 
        return player_str..'char1'
    elseif flycast.memory.read8(DC_MVC2_MEMORY_TABLE[player_str..'char2_is_point']) == 0 then 
        return player_str..'char2'
    else 
        return player_str..'char3'
    end
end
function get_ram_address_for_point_given_prefix(player, address_name)
    local player_str = get_point_char_prefix(player)
    return flycast.memory.read8(DC_MVC2_MEMORY_TABLE[player_str..'_'..address_name])
end
function cbOverlay()
    local ui = flycast.ui
    local MEMORY = flycast.memory
    
    current_frame = flycast.memory.read32(DC_MVC2_MEMORY_TABLE.rom_framecount)
    ui.beginWindow("Debug", 100, 10, 300, 0)
    ui.text("Flight Timer")
    ui.rightText(MEMORY.read16(DC_MVC2_MEMORY_TABLE.p1_char1_magneto_flight_timer))

    -- ui.text("p1 char 1 unfly")
    -- ui.rightText(flycast.memory.read8(DC_MVC2_MEMORY_TABLE.p1_char1_unfly))

    -- ui.text("p2 Char 1 block stun")
    -- ui.rightText(flycast.memory.read8(DC_MVC2_MEMORY_TABLE.p2_char2_block_stun))

    knockdown_condition = flycast.memory.read8(DC_MVC2_MEMORY_TABLE.p2_char1_knockdown_state) == 32
    hitstop_timer = flycast.memory.read8(DC_MVC2_MEMORY_TABLE.p2_char1_hit_stop2) 
    hitstop_condition = hitstop_timer > 0
    p2_char1_being_hit = knockdown_condition and hitstop_condition
    ui.text(string.format("Which is active p1? %s", get_point_char_prefix(1)))
    ui.text(string.format("Which is active p2? %s", get_point_char_prefix(2)))
    ui.text(string.format("p2 Char 1 knockdown :  %s", knockdown_condition))
    ui.text(string.format("p2 Char 1 hitstop :  %s", hitstop_condition))
    ui.text(string.format("p2 Char 1 is being hit :  %s", p2_char1_being_hit))
    is_guarding = flycast.memory.read8(DC_MVC2_MEMORY_TABLE.p2_char1_status2) == 5
    ui.text(string.format("p2 Char 1 is being guardia :  %s", is_guarding))
    -- ui.rightText(flycast.memory.read8(DC_MVC2_MEMORY_TABLE.p2_char2_block_stun))
    ui.text(string.format("FC :  %d", current_frame))
    ui.text(string.format("release on :  %s", time_to_release_pb))
    -- temp = flycast.memory.read8(DC_MVC2_MEMORY_TABLE[get_point_char_prefix(1)..'_'..'hit_stop2'])
    -- ui.text(string.format("Arbitrary lol :  %d", temp))
    ui.text(string.format("Arbitrary lol :  %d", get_ram_address_for_point_given_prefix(2, 'hit_stop2')))
     
    if is_guarding and hitstop_condition then
      pushblock(2)
    elseif is_guarding and hitstop_timer == 0 then
        release_pb(2)
    end
    -- if (current_frame == time_to_release_pb) then
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

      ui.button('Magneto be Ballin', function()
            GLOBALS.is_infinite_flight_enabled = true
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

function dummy_action_buttons(player)
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

flycast_callbacks = {
  start = cbStart,
  overlay = cbOverlay
}

print("Callback set")
f = 0
