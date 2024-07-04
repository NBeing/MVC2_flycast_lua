
print("Loading buttons")
DC_BTN_C           = 1 << 0
DC_BTN_B           = 1 << 1
DC_BTN_A           = 1 << 2
DC_BTN_START       = 1 << 3
DC_DPAD_UP         = 1 << 4
DC_DPAD_DOWN       = 1 << 5
DC_DPAD_LEFT       = 1 << 6
DC_DPAD_RIGHT      = 1 << 7
DC_BTN_Z           = 1 << 8
DC_BTN_Y           = 1 << 9
DC_BTN_X           = 1 << 10
DC_BTN_D           = 1 << 11
DC_DPAD2_UP        = 1 << 12
DC_DPAD2_DOWN      = 1 << 13
DC_DPAD2_LEFT      = 1 << 14
DC_DPAD2_RIGHT     = 1 << 15
DC_BTN_RELOAD      = 1 << 16


function getFriendlyKeys_DC(player_num)
    local btn_map = flycast.input.getButtons(player_num)
    return {
      ["C"]     = btn_map & DC_BTN_C == 0,
      ["B"]     = btn_map & DC_BTN_B == 0,
      ["A"]     = btn_map & DC_BTN_A == 0,
      ["START"] = btn_map & DC_BTN_START == 0,
      ["UP"]    = btn_map & DC_DPAD_UP == 0,
      ["DOWN"]  = btn_map & DC_DPAD_DOWN == 0,
      ["LEFT"]  = btn_map & DC_DPAD_LEFT == 0,
      ["RIGHT"] = btn_map & DC_DPAD_RIGHT == 0,
      ["Z"]     = btn_map & DC_BTN_Z == 0,
      ["Y"]     = btn_map & DC_BTN_Y == 0,
      ["X"]     = btn_map & DC_BTN_X == 0,
      ["D"]     = btn_map & DC_BTN_D == 0,
      ["LT"]    = flycast.input.getAxis(player_num, 5) == 0xFF,
      ["RT"]    = flycast.input.getAxis(player_num, 6) == 0xFF
  }
  end

function base_button_map()
    return {
        ["C"]     = false,
        ["B"]     = false,
        ["A"]     = false,
        ["START"] = false,
        ["UP"]    = false,
        ["DOWN"]  = false,
        ["LEFT"]  = false,
        ["RIGHT"] = false,
        ["Z"]     = false,
        ["Y"]     = false,
        ["X"]     = false,
        ["D"]     = false,
        -- ["LT"]    = false,
        -- ["RT"]    = false,
    }
end

-- button_map_obj = {
--     { names = {"C"},        pressed = false, val = DC_BTN_C     },
--     { names = {"B"},        pressed = false, val = DC_BTN_B     },
--     { names = {"A"},        pressed = false, val = DC_BTN_A     },
--     { names = {"START"},    pressed = false, val = DC_BTN_START },
--     { names = {"UP"},       pressed = false, val = DC_DPAD_UP   },
--     { names = {"DOWN"},     pressed = false, val = DC_DPAD_DOWN },
--     { names = {"LEFT"},     pressed = false, val = DC_DPAD_LEFT },
--     { names = {"RIGHT"},    pressed = false, val = DC_DPAD_RIGHT},
--     { names = {"Z"},        pressed = false, val = DC_BTN_Z     },
--     { names = {"Y"},        pressed = false, val = DC_BTN_Y     },
--     { names = {"X"},        pressed = false, val = DC_BTN_X     },
--     { names = {"D"},        pressed = false, val = DC_BTN_D     },
--     -- { names = {"LT"},       pressed = false, val = },
--     -- { names = {"RT"},       pressed = false, val = },
-- }
button_map_obj = {
    ["C"]       = {pressed = false, val = DC_BTN_C     },
    ["B"]       = {pressed = false, val = DC_BTN_B     },
    ["A"]       = {pressed = false, val = DC_BTN_A     },
    ["START"]   = {pressed = false, val = DC_BTN_START },
    ["UP"]      = {pressed = false, val = DC_DPAD_UP   },
    ["DOWN"]    = {pressed = false, val = DC_DPAD_DOWN },
    ["LEFT"]    = {pressed = false, val = DC_DPAD_LEFT },
    ["RIGHT"]   = {pressed = false, val = DC_DPAD_RIGHT},
    ["Z"]       = {pressed = false, val = DC_BTN_Z     },
    ["Y"]       = {pressed = false, val = DC_BTN_Y     },
    ["X"]       = {pressed = false, val = DC_BTN_X     },
    ["D"]       = {pressed = false, val = DC_BTN_D     },
    -- { names = {"LT"},       pressed = false, val = },
    -- { names = {"RT"},       pressed = false, val = },
}

function make_input(key_arr)
    print("Making?")
    local base_inps = base_button_map()
    for k,v in pairs(key_arr) do
        print("K", v)
        base_inps[v] = true
    end       
    return base_inps
end
function test_input_table()
 return {
    make_input({"DOWN"}),
    make_input({}),
    make_input({"DOWN","RIGHT"}),
    make_input({}),
    make_input({"RIGHT", "X"}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({}),
    make_input({"UP", "X"}),

    -- make_input({"LEFT"}),
    -- make_input({"LEFT"}),
    -- make_input({"A", "RIGHT"}),
    -- make_input({"RIGHT"}),
    -- make_input({"RIGHT"}),
    -- make_input({"RIGHT"}),
}
end

function release_all_buttons_DC()
    local empty = 0
    for k,v in pairs(base_button_map()) do
        map = button_map_obj[k]
        empty = empty + button_map_obj[k].val
    end
    print("Releasing", empty)
    flycast.input.releaseButtons(1, empty)
end
function setFriendlyKeys_DC(friendly_btn_map)
    -- friendly_btn_map = base_button_map
    -- flycast.input.pressButtons(1, 0x8)
    -- print("Set")
    print("setting")
    local empty = 0
    for k,v in pairs(friendly_btn_map) do
        print("looking at",k,v)
        map = button_map_obj[k]
        if v then
            empty = empty + button_map_obj[k].val
            -- print(k, button_map_obj[k].val)
        end 
    end
    release_all_buttons_DC()
    flycast.input.pressButtons(1, empty)
end


buttonUtilModule = {
    ["setFriendlyKeys_DC"]              = setFriendlyKeys_DC,
    ["release_all_buttons_DC"]          = release_all_buttons_DC,
    ["make_input"]                      = make_input,
    ["test_input_table"]                = test_input_table,
    ["button_map_obj"]                  = button_map_obj,
    ["base_button_map"]                 = base_button_map,

}
return buttonUtilModule