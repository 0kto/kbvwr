-- awesomeWM lua packages =============================================
local beautiful = require("beautiful")

-- needed kbvwr stuff =================================================
local kbvwr  = {}
-- package config =====================================================
kbvwr.config = {}

kbvwr.config.font             = "Cousine Nerd Font"
kbvwr.config.fontsize         = "12"
kbvwr.config.fontsize_symbols = "15"

kbvwr.config.default_key_bg       = x.color0
kbvwr.config.default_key_fg       = x.foreground
kbvwr.config.modifier_key_bg	  = x.color8
kbvwr.config.modifier_key_fg	  = x.color0
kbvwr.config.active_key_bg        = x.color9
kbvwr.config.active_key_fg        = x.color0

kbvwr.config.groupcolors = {}
kbvwr.config.groupcolors["modifier"] = kbvwr.config.modifier_key_bg
kbvwr.config.groupcolors["launch"]   = x.color2
kbvwr.config.groupcolors["apps"]     = x.color3
kbvwr.config.groupcolors["media"]    = x.color4
kbvwr.config.groupcolors["client"]   = x.color5
kbvwr.config.groupcolors["layout"]   = x.color6
kbvwr.config.groupcolors["awesome"]  = x.color7
kbvwr.config.groupcolors["tools"]    = x.color8
kbvwr.config.groupcolors["tags"]     = x.color13

kbvwr.config.bg = beautiful.exit_screen_bg or beautiful.wibar_bg or "#111111"
kbvwr.config.fg = beautiful.exit_screen_fg or beautiful.wibar_fg or "#FEFEFE"

kbvwr.config.kb_width   = dpi(1221)
kbvwr.config.kb_height  = dpi( 491)

kbvwr.config.box_radius = dpi(  12)
kbvwr.config.box_gap    = dpi(   6)

-- Key geometry is defined here.
kbvwr.config.keys        = {}
kbvwr.config.keys.gap    = {}
kbvwr.config.keys.gap["default"]     = 6
kbvwr.config.keys.gap["Fx"]          = kbvwr.config.keys.gap["default"] / 2
kbvwr.config.keys.height = {} 
kbvwr.config.keys.height["default"]  = 65
kbvwr.config.keys.height["Fx"]       = kbvwr.config.keys.height["default"] * 0.75
kbvwr.config.keys.width  = {} 
kbvwr.config.keys.width["default"]   = 65
kbvwr.config.keys.width["Escape"]    = kbvwr.config.keys.width["default"] * 1.3
kbvwr.config.keys.width["Delete"]    = kbvwr.config.keys.width["Escape"]
kbvwr.config.keys.width["Fx"]        = kbvwr.config.keys.width["default"] * 0.85
kbvwr.config.keys.width["BackSpace"] = kbvwr.config.keys.width["default"] * 2
kbvwr.config.keys.width["Tab"]       = kbvwr.config.keys.width["default"] * 1.5
kbvwr.config.keys.width["Return1"]   = kbvwr.config.keys.width["default"] * 1.5
kbvwr.config.keys.width["Caps_Lock"] = kbvwr.config.keys.width["default"] * 1.8
kbvwr.config.keys.width["Return2"]   = kbvwr.config.keys.width["default"] * 1.2
kbvwr.config.keys.width["Shift_L"]   = kbvwr.config.keys.width["default"] * 1.25
kbvwr.config.keys.width["Shift_R"]   = kbvwr.config.keys.width["default"] * 2.85
kbvwr.config.keys.width["Fn"]        = kbvwr.config.keys.width["default"]
kbvwr.config.keys.width["Control_L"] = kbvwr.config.keys.width["default"] * 1.25
kbvwr.config.keys.width["Super_L"]   = kbvwr.config.keys.width["default"]
kbvwr.config.keys.width["Alt_L"]     = kbvwr.config.keys.width["default"]
kbvwr.config.keys.width["Space"]     = kbvwr.config.keys.width["default"] * 5 + kbvwr.config.keys.gap["default"] * 4
kbvwr.config.keys.width["Alt_R"]     = kbvwr.config.keys.width["default"]
kbvwr.config.keys.width["Print"]     = kbvwr.config.keys.width["default"]
kbvwr.config.keys.width["Control_R"] = kbvwr.config.keys.width["default"]
kbvwr.config.keys.width["Arrow"]     = (kbvwr.config.keys.width["Shift_R"] - 2 * kbvwr.config.keys.gap["default"]) / 3

kbvwr.config.keys.aliases = {}
kbvwr.config.keys.aliases["ISO_Level3_Shift"] = "Alt_R"
kbvwr.config.keys.aliases[" "]  = "space"
kbvwr.config.keys.aliases["~"]  = "`"
kbvwr.config.keys.aliases["!"]  = "1"
kbvwr.config.keys.aliases["@"]  = "2"
kbvwr.config.keys.aliases["#"]  = "3"
kbvwr.config.keys.aliases["$"]  = "4"
kbvwr.config.keys.aliases["%"]  = "5"
kbvwr.config.keys.aliases["^"]  = "6"
kbvwr.config.keys.aliases["&"]  = "7"
kbvwr.config.keys.aliases["*"]  = "8"
kbvwr.config.keys.aliases["("]  = "9"
kbvwr.config.keys.aliases[")"]  = "0"
kbvwr.config.keys.aliases["_"]  = "-"
kbvwr.config.keys.aliases["+"]  = "="
kbvwr.config.keys.aliases["Q"]  = "q"
kbvwr.config.keys.aliases["W"]  = "w"
kbvwr.config.keys.aliases["E"]  = "e"
kbvwr.config.keys.aliases["R"]  = "r"
kbvwr.config.keys.aliases["T"]  = "t"
kbvwr.config.keys.aliases["Y"]  = "y"
kbvwr.config.keys.aliases["U"]  = "u"
kbvwr.config.keys.aliases["I"]  = "i"
kbvwr.config.keys.aliases["O"]  = "o"
kbvwr.config.keys.aliases["P"]  = "p"
kbvwr.config.keys.aliases["{"]  = "["
kbvwr.config.keys.aliases["}"]  = "]"
kbvwr.config.keys.aliases["bracketleft"]  = "["
kbvwr.config.keys.aliases["bracketright"]  = "]"
kbvwr.config.keys.aliases["A"]  = "a"
kbvwr.config.keys.aliases["S"]  = "s"
kbvwr.config.keys.aliases["D"]  = "d"
kbvwr.config.keys.aliases["F"]  = "f"
kbvwr.config.keys.aliases["G"]  = "g"
kbvwr.config.keys.aliases["H"]  = "h"
kbvwr.config.keys.aliases["J"]  = "j"
kbvwr.config.keys.aliases["K"]  = "k"
kbvwr.config.keys.aliases["L"]  = "l"
kbvwr.config.keys.aliases[":"]  = ";"
kbvwr.config.keys.aliases["\""] = "'"
kbvwr.config.keys.aliases["|"]  = "\\"
kbvwr.config.keys.aliases[">"]  = "<"
kbvwr.config.keys.aliases["Z"]  = "z"
kbvwr.config.keys.aliases["X"]  = "x"
kbvwr.config.keys.aliases["C"]  = "c"
kbvwr.config.keys.aliases["V"]  = "v"
kbvwr.config.keys.aliases["B"]  = "b"
kbvwr.config.keys.aliases["N"]  = "n"
kbvwr.config.keys.aliases["M"]  = "m"
kbvwr.config.keys.aliases["XF86WakeUp"] = "Fn"

-- kbvwr.config.keys.aliases["<"]  = ","
-- kbvwr.config.keys.aliases[">"]  = "."
kbvwr.config.keys.aliases["?"]  = "/"


return kbvwr.config