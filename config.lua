local beautiful = require("beautiful")

local kbvwr  = {}
kbvwr.config = {}

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

kbvwr.config.box_radius = dpi(12)
kbvwr.config.box_gap    = dpi(6)

kbvwr.config.modifier_list = {
    ['Alt_L']     = true,
    ['Alt_R']     = true,
    ['Caps_Lock'] = true,
    ['Control_L'] = true,
    ['Control_R'] = true,
    ['shift']     = true,
    ['Super_L']   = true,
}
return kbvwr.config