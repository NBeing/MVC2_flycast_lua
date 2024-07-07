return {
  -- System values
  ['game_timer'] = 0x2C289630,
  ['stage_id'] = 0x2C289638,
  ['stage_id_select'] = 0x22C26A95C,
  ['p1_level'] = 0x2C28964A,
  -- Player values
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
  ['p1_char1_knockdown_state'] = 0x2C268510,

  --   Throw_Counter_Mash,,,Byte
  -- P1_A_Throw_Counter_Mash,2C26859C,0,2 Bytes
  -- P1_B_Throw_Counter_Mash,2C2690E4,0,2 Bytes
  -- P1_C_Throw_Counter_Mash,2C269C2C,0,2 Bytes
  -- P2_A_Throw_Counter_Mash,2C268B40,0,2 Bytes
  -- P2_B_Throw_Counter_Mash,2C269688,0,2 Bytes
  -- P2_C_Throw_Counter_Mash,2C26A1D0,0,2 Bytes

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
