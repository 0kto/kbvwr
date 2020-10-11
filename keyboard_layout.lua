local wibox = require("wibox")
local icons = require("icons")
local helpers = require("helpers")


local keyboard_layout = {}
function keyboard_layout.create(keymap,colormap,level)
  -- Key geometry is defined here.
  -- gap width
  local gap_keys        = 6
  local gap_fkeys       = gap_keys / 2
  -- key height 
  local key_height      = 65
  local fkey_height     = key_height * 0.75
  -- key width
  local key_width       = 65
  local Escape_width    = key_width * 1.3
  local Delete_width    = Escape_width 
  local fkey_width      = key_width * 0.85
  local BackSpace_width = key_width * 2
  local Tab_width       = key_width * 1.5
  local Return1_width   = key_width * 1.5
  local Caps_Lock_width = key_width * 1.8
  local Return2_width   = key_width * 1.2
  local Shift_L_width   = key_width * 1.25
  local Shift_R_width   = key_width * 2.85
  local Fn_width        = key_width
  local Control_L_width = key_width * 1.25
  local Super_L_width   = key_width
  local Alt_L_width     = key_width
  local space_width     = key_width * 5 + 4 * gap_keys 
  local Alt_R_width     = key_width
  local Print_width     = key_width
  local Control_R_width = key_width
  local Arrows_width    = ( Shift_R_width - 2 * gap_keys ) / 3
  
  -- Function to draw a nice key.
  local function key(key,keymap,colormap,level,height,width)
    local key_box = wibox.widget {
      {
        font = "Sans Bold 11",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox(keymap[key][level] or "")
      },
      widget = wibox.widget {
        bg = colormap[key][level],
        forced_height = dpi(height),
        forced_width  = dpi(width),
        shape = helpers.rrect(dpi(4)),
        widget = wibox.container.background()
      }
    }
    return key_box
  end
  -- Define keys, so they should be update-able.
  local key_ESC        = key("ESC",       keymap, colormap, level, fkey_height, Escape_width )
  local key_F1         = key("F1",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F2         = key("F2",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F3         = key("F3",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F4         = key("F4",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F5         = key("F5",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F6         = key("F6",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F7         = key("F7",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F8         = key("F8",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F9         = key("F9",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F10        = key("F10",       keymap, colormap, level, fkey_height, fkey_width )
  local key_F11        = key("F11",       keymap, colormap, level, fkey_height, fkey_width )
  local key_F12        = key("F12",       keymap, colormap, level, fkey_height, fkey_width )
  local key_Home       = key("Home",      keymap, colormap, level, fkey_height, fkey_width )
  local key_End        = key("End",       keymap, colormap, level, fkey_height, fkey_width )
  local key_Insert     = key("Insert",    keymap, colormap, level, fkey_height, fkey_width )
  local key_Delete     = key("Delete",    keymap, colormap, level, fkey_height, Delete_width )
 
  local key_grave      = key("`",         keymap, colormap, level, key_height, key_width )
  local key_1          = key("1",         keymap, colormap, level, key_height, key_width )
  local key_2          = key("2",         keymap, colormap, level, key_height, key_width )
  local key_3          = key("3",         keymap, colormap, level, key_height, key_width )
  local key_4          = key("4",         keymap, colormap, level, key_height, key_width )
  local key_5          = key("5",         keymap, colormap, level, key_height, key_width )
  local key_6          = key("6",         keymap, colormap, level, key_height, key_width )
  local key_7          = key("7",         keymap, colormap, level, key_height, key_width )
  local key_8          = key("8",         keymap, colormap, level, key_height, key_width )
  local key_9          = key("9",         keymap, colormap, level, key_height, key_width )
  local key_0          = key("0",         keymap, colormap, level, key_height, key_width )
  local key_minus      = key("-",         keymap, colormap, level, key_height, key_width )
  local key_equal      = key("=",         keymap, colormap, level, key_height, key_width )
  local key_BackSpace  = key("BackSpace", keymap, colormap, level, key_height, BackSpace_width )

  local key_Tab        = key("Tab",       keymap, colormap, level, key_height, Tab_width)
  local key_q          = key("q",         keymap, colormap, level, key_height, key_width)
  local key_w          = key("w",         keymap, colormap, level, key_height, key_width)
  local key_e          = key("e",         keymap, colormap, level, key_height, key_width)
  local key_r          = key("r",         keymap, colormap, level, key_height, key_width)
  local key_t          = key("t",         keymap, colormap, level, key_height, key_width)
  local key_y          = key("y",         keymap, colormap, level, key_height, key_width)
  local key_u          = key("u",         keymap, colormap, level, key_height, key_width)
  local key_i          = key("i",         keymap, colormap, level, key_height, key_width)
  local key_o          = key("o",         keymap, colormap, level, key_height, key_width)
  local key_p          = key("p",         keymap, colormap, level, key_height, key_width)
  local key_bracket_o  = key("[",         keymap, colormap, level, key_height, key_width)
  local key_bracket_c  = key("]",         keymap, colormap, level, key_height, key_width)
  local key_Return1    = key("Return",    keymap, colormap, level, key_height, Return1_width)

  local key_Caps_Lock  = key("Caps_Lock", keymap, colormap, level, key_height, Caps_Lock_width)
  local key_a          = key("a",         keymap, colormap, level, key_height, key_width)
  local key_s          = key("s",         keymap, colormap, level, key_height, key_width)
  local key_d          = key("d",         keymap, colormap, level, key_height, key_width)
  local key_f          = key("f",         keymap, colormap, level, key_height, key_width)
  local key_g          = key("g",         keymap, colormap, level, key_height, key_width)
  local key_h          = key("h",         keymap, colormap, level, key_height, key_width)
  local key_j          = key("j",         keymap, colormap, level, key_height, key_width)
  local key_k          = key("k",         keymap, colormap, level, key_height, key_width)
  local key_l          = key("l",         keymap, colormap, level, key_height, key_width)
  local key_semicolon  = key(";",         keymap, colormap, level, key_height, key_width)
  local key_apostrophe = key("'",         keymap, colormap, level, key_height, key_width)
  local key_backslash  = key("\\",        keymap, colormap, level, key_height, key_width)
  local key_Return2    = key("Return",    keymap, colormap, level, key_height, Return2_width)

  local key_Shift_L    = key("Shift_L",   keymap, colormap, level, key_height, Shift_L_width)
  local key_less       = key("<",         keymap, colormap, level, key_height, key_width)
  local key_z          = key("z",         keymap, colormap, level, key_height, key_width)
  local key_x          = key("x",         keymap, colormap, level, key_height, key_width)
  local key_c          = key("c",         keymap, colormap, level, key_height, key_width)
  local key_v          = key("v",         keymap, colormap, level, key_height, key_width)
  local key_b          = key("b",         keymap, colormap, level, key_height, key_width)
  local key_n          = key("n",         keymap, colormap, level, key_height, key_width)
  local key_m          = key("m",         keymap, colormap, level, key_height, key_width)
  local key_comma      = key(",",         keymap, colormap, level, key_height, key_width)
  local key_dot        = key(".",         keymap, colormap, level, key_height, key_width)
  local key_slash      = key("/",         keymap, colormap, level, key_height, key_width)
  local key_Shift_R    = key("Shift_R",   keymap, colormap, level, key_height, Shift_R_width)

  local key_Fn         = key("Fn",        keymap, colormap, level, key_height, Fn_width)
  local key_Control_L  = key("Control_L", keymap, colormap, level, key_height, Control_L_width)
  local key_Super_L    = key("Super_L",   keymap, colormap, level, key_height, Super_L_width)
  local key_Alt_L      = key("Alt_L",     keymap, colormap, level, key_height, Alt_L_width)
  local key_space      = key("space",     keymap, colormap, level, key_height, space_width)
  local key_Alt_R      = key("Alt_R",     keymap, colormap, level, key_height, Alt_R_width)
  local key_Print      = key("Print",     keymap, colormap, level, key_height, Print_width)
  local key_Control_R  = key("Control_R", keymap, colormap, level, key_height, Control_R_width)
  local key_Prior      = key("Prior",     keymap, colormap, level, key_height, Arrows_width)
  local key_Up         = key("Up",        keymap, colormap, level, key_height, Arrows_width)
  local key_Next       = key("Next",      keymap, colormap, level, key_height, Arrows_width)

  -- Define Keyboard layout
  -- (here, an 6-row US ThinkPad layout w/o keypad is used)
  local layout = wibox.container {
    layout  = wibox.layout.fixed.vertical,
    spacing = gap_keys,
    -- row 1
    wibox.container {
      layout  = wibox.layout.fixed.horizontal,
      spacing = gap_keys,
      wibox.container {
        layout  = wibox.layout.fixed.horizontal,
        spacing = gap_fkeys,
        key_ESC, key_F1, key_F2, key_F3, key_F4
      },
      wibox.container {
        layout  = wibox.layout.fixed.horizontal,
        spacing = gap_fkeys,
        key_F5, key_F6, key_F7, key_F8, 
      },
       wibox.container {
        layout  = wibox.layout.fixed.horizontal,
        spacing = gap_fkeys,
        key_F9, key_F10, key_F11, key_F12,
      },
       wibox.container {
        layout  = wibox.layout.fixed.horizontal,
        spacing = gap_fkeys,
        key_Home, key_End, key_Insert, key_Delete, 
      },
    },
    -- row 2
    wibox.container {
      layout  = wibox.layout.fixed.horizontal,
      spacing = gap_keys,
      key_grave, key_1, key_2, key_3, key_4, key_5, key_6, key_7, key_8, key_9,
      key_0, key_minus, key_equal, key_BackSpace, 
   },
    -- row 3
    wibox.container {
      layout  = wibox.layout.fixed.horizontal,
      spacing = gap_keys,
      key_Tab, key_q, key_w, key_e, key_r, key_t, key_y, key_u, key_i, key_o,
      key_p, key_bracket_o, key_bracket_c, key_Return1, 
    },
    -- row 4
    wibox.container {
      layout  = wibox.layout.fixed.horizontal,
      spacing = gap_keys,
      key_Caps_Lock, key_a, key_s, key_d, key_f, key_g, key_h, key_j, key_k,
      key_l, key_semicolon, key_apostrophe, key_backslash, key_Return2, 
    },
    -- row 5
    wibox.container {
      layout  = wibox.layout.fixed.horizontal,
      spacing = gap_keys,
      key_Shift_L, key_less, key_z, key_x, key_c, key_v, key_b, key_n, key_m,
      key_comma, key_dot, key_slash, key_Shift_R, 
    },
    -- row 6
    wibox.container {
      layout  = wibox.layout.fixed.horizontal,
      spacing = gap_keys,
      key_Fn, key_Control_L, key_Super_L, key_Alt_L, key_space, key_Alt_R,
      key_Print, key_Control_R, key_Prior, key_Up, key_Next, 
    },
    widget  = wibox.container {
      widget        = wibox.container.background(),
      forced_height = dpi(65),
      forced_width  = dpi(1211),
    }
  }
  return layout
end


-- Keyboard Viewer
keyboard_layout.keymap        = {}
-- keyboard_layout.keymap              basic        shift        Fn           Alt_R     Alt_R+shift  Super_L             Super_L+shift      Super_L+Alt_L            Super_L+Control_L  Super_L+Control_L+Alt_L
-- level                                -1-          -2-          -3-          -4-        -5-         -6-                 -7-                -8-                      -9-                -10-
keyboard_layout.keymap["ESC"]       = {"ESC",       "ESC",       "FnLock",     nil,       nil,       "powermenu",        "quit awesome",     nil,                     nil,               nil,               }
keyboard_layout.keymap["F1"]        = {"F1",        "F1",        "mute",       nil,       nil,       "dashboard",         nil,               nil,                     nil,               nil,               }
-- XF86Switch_VT_1
keyboard_layout.keymap["F2"]        = {"F2",        "F2",        "vol -",      nil,       nil,       "ranger",            nil,               nil,                     nil,               nil,               }
-- XF86AudioLowerVolume          
keyboard_layout.keymap["F3"]        = {"F3",        "F3",        "vol +",      nil,       nil,       "ncmpcpp",           nil,               nil,                     nil,               nil,               }
-- XF86AudioRaiseVolume          
keyboard_layout.keymap["F4"]        = {"F4",        "F4",        "mute mic",   nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- XF86AudioMicMute
keyboard_layout.keymap["F5"]        = {"F5",        "F5",        "screen -",   nil,       nil,       "keyboard layout",   nil,               nil,                     nil,               nil,               }
-- XF86MonBrightnessDown          
keyboard_layout.keymap["F6"]        = {"F6",        "F6",        "screen +",   nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- XF86MonBrightnessUp          
keyboard_layout.keymap["F7"]        = {"F7",        "F7",        "display",    nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- XF86Display
keyboard_layout.keymap["F8"]        = {"F8",        "F8",        "wireless",   nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- XF86WLAN
keyboard_layout.keymap["F9"]        = {"F9",        "F9",        "tools",      nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- XF86Tools
keyboard_layout.keymap["F10"]       = {"F10",       "F10",       "bluetooth",  nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- XF86Bluetooth / XF86Search
keyboard_layout.keymap["F11"]       = {"F11",       "F11",       "keyboard",   nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["F12"]       = {"F12",       "F12",       "star",       nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Home"]      = {"Home",      "Home",       nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["End"]       = {"End",       "End",        nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Insert"]    = {"Ins",       "Ind",        nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Delete"]    = {"Del",       "Del",        nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- row     2          
keyboard_layout.keymap["`"]         = {"`",         "~",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["1"]         = {"1",         "!",          nil,         nil,       nil,       "switch $1",        "move to $1",      "move & switch to $1",   "toggle $1",       "add client to $1", }
keyboard_layout.keymap["2"]         = {"2",         "@",          nil,         nil,       nil,       "switch $2",        "move to $2",      "move & switch to $2",   "toggle $2",       "add client to $2", }
keyboard_layout.keymap["3"]         = {"3",         "#",          nil,         nil,       nil,       "switch $3",        "move to $3",      "move & switch to $3",   "toggle $3",       "add client to $3", }
keyboard_layout.keymap["4"]         = {"4",         "$",          nil,         nil,       nil,       "switch $4",        "move to $4",      "move & switch to $4",   "toggle $4",       "add client to $4", }
keyboard_layout.keymap["5"]         = {"5",         "%",          nil,         nil,       nil,       "switch $5",        "move to $5",      "move & switch to $5",   "toggle $5",       "add client to $5", }
keyboard_layout.keymap["6"]         = {"6",         "^",          nil,         nil,       nil,       "switch $6",        "move to $6",      "move & switch to $6",   "toggle $6",       "add client to $6", }
keyboard_layout.keymap["7"]         = {"7",         "&",          nil,         nil,       nil,       "switch $7",        "move to $7",      "move & switch to $7",   "toggle $7",       "add client to $7", }
keyboard_layout.keymap["8"]         = {"8",         "*",          nil,         nil,       nil,       "switch $8",        "move to $8",      "move & switch to $8",   "toggle $8",       "add client to $8", }
keyboard_layout.keymap["9"]         = {"9",         "(",          nil,         nil,       nil,       "switch $9",        "move to $9",      "move & switch to $9",   "toggle $9",       "add client to $9", }
keyboard_layout.keymap["0"]         = {"0",         ")",          nil,         nil,       nil,       "switch $0",        "move to $0",      "move & switch to $0",   "toggle $0",       "add client to $0", }
keyboard_layout.keymap["-"]         = {"-",         "_",          nil,         nil,       nil,       "gaps -",           "gaps +",           nil,                     nil,               nil,               }
keyboard_layout.keymap["="]         = {"=",         "+",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["BackSpace"] = {"BackSpace", "BackSpace",  nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- row     3          
keyboard_layout.keymap["Tab"]       = {"Tab",       "Tab",        nil,         nil,       nil,       "window switcher",   nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["q"]         = {"q",         "Q",          nil,         nil,       nil,        nil,                nil,              "kill all",               nil,               nil,               }
keyboard_layout.keymap["w"]         = {"w",         "W",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["e"]         = {"e",         "E",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["r"]         = {"r",         "R",          nil,         nil,       nil,       "run",              "restart awesome",  nil,                     nil,               nil,               }
keyboard_layout.keymap["t"]         = {"t",         "T",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["y"]         = {"y",         "Y",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["u"]         = {"u",         "U",          nil,        "ü",       "Ü",        "switch urgent",     nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["i"]         = {"i",         "I",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["o"]         = {"o",         "O",          nil,        "ö",       "Ö",         nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["p"]         = {"p",         "P",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["["]         = {"[",         "{",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["]"]         = {"]",         "}",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Return"]    = {"Return",    "Return",     nil,         nil,       nil,       "terminal",         "terminal (float)", nil,                     nil,               nil,               }
-- row 4          
keyboard_layout.keymap["Caps_Lock"] = {"Caps_Lock", "Caps_Lock",  nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["a"]         = {"a",         "A",          nil,        "ä",       "Ä",         nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["s"]         = {"s",         "S",          nil,        "ß",        nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["d"]         = {"d",         "D",          nil,         nil,       nil,       "rofi",              nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["f"]         = {"f",         "F",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["g"]         = {"g",         "G",          nil,         nil,       nil,       "web search",        nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["h"]         = {"h",         "H",          nil,         nil,       nil,       "focus left",        nil,              "#master +",             "resize left",      nil,               }
keyboard_layout.keymap["j"]         = {"j",         "J",          nil,         nil,       nil,       "focus down",        nil,              "#col -",                "resize down",      nil,               }
keyboard_layout.keymap["k"]         = {"k",         "K",          nil,         nil,       nil,       "focus up",          nil,              "#col +",                "resize up",        nil,               }
keyboard_layout.keymap["l"]         = {"l",         "L",          nil,         nil,       nil,       "focus right",       nil,              "#master -",             "resize right",     nil,               }
keyboard_layout.keymap[";"]         = {";",         ":",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["'"]         = {"'",         "\"",         nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["\\"]        = {"\\",        "|",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- keyboard_layout.keymap["Return"] = {"Return",    "Return",     nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- row 5              
keyboard_layout.keymap["Shift_L"]   = {"shift",     "shift",      nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["<"]         = {"<",         ">",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["z"]         = {"z",         "Z",          nil,         nil,       nil,       "next tab",         "prior tab",        nil,                     nil,               nil,               }
keyboard_layout.keymap["x"]         = {"x",         "X",          nil,         nil,       nil,       "go back",          "quit awesome",     nil,                     nil,               nil,               }
keyboard_layout.keymap["c"]         = {"c",         "C",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["v"]         = {"v",         "V",          nil,         nil,       nil,       "mute mic",         "mic overlay",      nil,                     nil,               nil,               }
keyboard_layout.keymap["b"]         = {"b",         "B",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["n"]         = {"n",         "N",          nil,         nil,       nil,       "minimize",         "un-minimize",      nil,                     nil,               nil,               }
keyboard_layout.keymap["m"]         = {"m",         "M",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap[","]         = {",",         "<",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["."]         = {".",         ">",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["/"]         = {"/",         "?",          nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Shift_R"]   = {"shift",     "shift",     "shift",     "shift",   "shift",    "shift",             nil,               nil,                     nil,               nil,               }
-- row 6              
keyboard_layout.keymap["Fn"]        = {"Fn",        "Fn",        "Fn",        "Fn",      "Fn",       "Fn",                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Control_L"] = {"control",   "control",   "control",   "control", "control",  "control",           nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Super_L"]   = {"mod4",      "mod4",      "mod4",      "mod4",    "mod4",     "mod4",              nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Alt_L"]     = {"mod1",      "mod1",      "mod1",      "mod1",    "mod1",     "mod1",              nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["space"]     = {"[ ]",       "[ ]",       "[ ]",       "[ ]",     "[ ]",      "[ ]",               nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Alt_R"]     = { nil,         nil,         nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Print"]     = {"screenshot", nil,         nil,         nil,       nil,        nil,               "browse shots",    "area shot",             "area to clip",     nil,               }
keyboard_layout.keymap["Control_R"] = { nil,         nil,         nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Prior"]     = {"Prior",     "Prior",      nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
keyboard_layout.keymap["Up"]        = {"Up",        "Up",         nil,         nil,       nil,       "focus up",          nil,               "#col +",                "resize up",       nil,               }
keyboard_layout.keymap["Next"]      = {"Next",      "Next",       nil,         nil,       nil,        nil,                nil,               nil,                     nil,               nil,               }
-- row 7              
keyboard_layout.keymap["Left"]      = {"Left",      "Left",       nil,         nil,       nil,       "focus left",        nil,              "#master +",             "resize left",      nil,               }
keyboard_layout.keymap["Down"]      = {"Down",      "Down",       nil,         nil,       nil,       "focus down",        nil,              "#col -",                "resize down",      nil,               }
keyboard_layout.keymap["Right"]     = {"Right",     "Right",      nil,         nil,       nil,       "focus right",       nil,              "#master -",             "resize right",     nil,               }

-- long form description shoult go to
-- keyboard_layout.keydesc = {}


keyboard_layout.colormap = {}
-- keymap                                basic       shift     Fn         Alt_L       Alt_L+shift Super_L  Super_L+shift  Super_L+Alt_L  Super_L+Control_L  Super_L+Control_L+Alt_L
-- level                                  -1-         -2-       -3-        -4-        -5-        -6-        -7-        -8-        -9-        -10-
keyboard_layout.colormap["ESC"]       = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["F1"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F2"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F3"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F4"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F5"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F6"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F7"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F8"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F9"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F10"]       = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F11"]       = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["F12"]       = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["Home"]      = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["End"]       = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["Insert"]    = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["Delete"]    = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["`"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["1"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["2"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["3"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["4"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["5"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["6"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["7"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["8"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["9"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["0"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["-"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["="]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["BackSpace"] = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Tab"]       = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["q"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["w"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["e"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["r"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["t"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["y"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["u"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["i"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["o"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["p"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["["]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["]"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["Return"]    = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Caps_Lock"] = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["a"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["s"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["d"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["f"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["g"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["h"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["j"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["k"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["l"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap[";"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["'"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["\\"]        = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["Shift_L"]   = {"#7c5f64", x.color4,  "#7c5f64", "#7c5f64", x.color4,  "#7c5f64", x.color4,  "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["<"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["z"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["x"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["c"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["v"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["b"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["n"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["m"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap[","]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["."]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["/"]         = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["Shift_R"]   = {"#7c5f64", x.color4,  "#7c5f64", "#7c5f64", x.color4,  "#7c5f64", x.color4,  "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Fn"]        = {"#7c5f64", "#7c5f64", x.color4,  "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Control_L"] = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", x.color4,  x.color4,  }
keyboard_layout.colormap["Super_L"]   = {x.color6,  x.color6,  x.color6,  x.color6,  x.color6,  x.color14, x.color14, x.color14, x.color14, x.color14, }
keyboard_layout.colormap["Alt_L"]     = {"#7c5f64", "#7c5f64", "#7c5f64", x.color4,  x.color4,  "#7c5f64", "#7c5f64", x.color4,  "#7c5f64", x.color4,  }
keyboard_layout.colormap["space"]     = {"#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", "#32302f", }
keyboard_layout.colormap["Alt_R"]     = {x.color5,  x.color5,  x.color5,  x.color5,  x.color5,  x.color5,  x.color5,  x.color5,  x.color5,  x.color5,  }
keyboard_layout.colormap["Print"]     = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Control_R"] = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Prior"]     = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Up"]        = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Next"]      = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Left"]      = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Down"]      = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Right"]     = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }

return keyboard_layout