local beautiful = require("beautiful")

local kbvwr  = {}
kbvwr.config = {}

kbvwr.config.font             = "Cousine Nerd Font"
kbvwr.config.fontsize         = "12"
kbvwr.config.fontsize_symbols = "16"

kbvwr.config.groupcolors = {}
kbvwr.config.groupcolors["launcher"] = x.color2
kbvwr.config.groupcolors["apps"]     = x.color3
kbvwr.config.groupcolors["media"]    = x.color4
kbvwr.config.groupcolors["client"]   = x.color5
kbvwr.config.groupcolors["layout"]   = x.color6
kbvwr.config.groupcolors["awesome"]  = x.color7
kbvwr.config.groupcolors["tools"]    = x.color8

kbvwr.config.default_key_color       = "#32302f"
kbvwr.config.active_key_color        = x.color1
kbvwr.config.modifier_key_color		 = "#7c5f64"

kbvwr.config.bg = beautiful.exit_screen_bg or beautiful.wibar_bg or "#111111"
kbvwr.config.fg = beautiful.exit_screen_fg or beautiful.wibar_fg or "#FEFEFE"

kbvwr.config.kb_width   = dpi(1221)
kbvwr.config.kb_height  = dpi( 491)

kbvwr.config.box_radius = dpi(  12)
kbvwr.config.box_gap    = dpi(   6)

-- select which modifiers are recognized by kbvwr.
kbvwr.config.modifier_list = {
    ['Alt_L']     = true,
    ['Alt_R']     = true,
    ['Caps_Lock'] = true,
    ['Control_L'] = true,
    ['Control_R'] = true,
    ['shift']     = true,
    ['Super_L']   = true,
	['Shift_L']   = true, -- these are not actually used, but are needed 
	['Shift_R']   = true, -- to detect shift
}

-- define levels for modifier combinations.
kbvwr.config.level_modifier_combo     = {}
kbvwr.config.level_modifier_combo[1]  = {}
kbvwr.config.level_modifier_combo[2]  = { 'shift' }
kbvwr.config.level_modifier_combo[3]  = { 'Alt_R'}
kbvwr.config.level_modifier_combo[4]  = { 'Alt_R',      'shift'}
kbvwr.config.level_modifier_combo[5]  = { 'Alt_L'}
kbvwr.config.level_modifier_combo[6]  = { 'Alt_L',      'shift'}
kbvwr.config.level_modifier_combo[7]  = { 'Alt_L',      'Control_L'}
kbvwr.config.level_modifier_combo[8]  = { 'Caps_Lock'}
kbvwr.config.level_modifier_combo[9]  = { 'Control_L'}
kbvwr.config.level_modifier_combo[10] = { 'Control_R'}
kbvwr.config.level_modifier_combo[11] = { 'Super_L' }
kbvwr.config.level_modifier_combo[12] = { 'Super_L',    'shift' }
kbvwr.config.level_modifier_combo[13] = { 'Super_L',    'Alt_L' }
kbvwr.config.level_modifier_combo[14] = { 'Super_L',    'Control_L' }
kbvwr.config.level_modifier_combo[15] = { 'Super_L',    'Control_L',   'Alt_L' }

-- translate binary indicator to powers of 2.
kbvwr.config.lvl  = {
	['Alt_L']     = 2^0,
	['Alt_R']     = 2^1,
	['Caps_Lock'] = 2^2,
	['Control_L'] = 2^3,
	['Control_R'] = 2^4,
	['shift']     = 2^5,
	['Super_L']   = 2^6
}

-- define mapping between level and lvl.
kbvwr.config.level     = {}
for level,combo in pairs(kbvwr.config.level_modifier_combo) do
	local lvl = 0
	for ii = 1,#combo, 1 do
		lvl = lvl + kbvwr.config.lvl[ combo[ii] ]
	end
	kbvwr.config.level[ lvl ] = level
end

return kbvwr.config