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
        bg = colormap[key][level] or "#32302f",
        forced_height = dpi(height),
        forced_width  = dpi(width),
        shape = helpers.rrect(dpi(4)),
        widget = wibox.container.background()
      }
    }
    return key_box
  end
  -- Define keys, so they should be update-able.
  local key_Escape     = key("Escape",    keymap, colormap, level, fkey_height, Escape_width )
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
 
  local key_grave      = key("grave",     keymap, colormap, level, key_height, key_width )
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
        key_Escape, key_F1, key_F2, key_F3, key_F4
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
-- keyboard_layout.keymap              basic        shift 
-- level                                -1-          -2-  
-- Fn + F[1-12] Keys need to be defined as well
keyboard_layout.keymap["XF86AudioMute"]         = {"mute", nil, }
keyboard_layout.keymap["XF86AudioLowerVolume"]  = {"vol-", nil, }
keyboard_layout.keymap["XF86AudioRaiseVolume"]  = {"vol+", nil, }
keyboard_layout.keymap["XF86AudioMicMute"]      = {"mic mute", nil, }
keyboard_layout.keymap["XF86MonBrightnessDown"] = {"bright-", nil, }
keyboard_layout.keymap["XF86MonBrightnessUp"]   = {"bright+", nil, }
keyboard_layout.keymap["XF86Display"]           = {"display", nil, }
keyboard_layout.keymap["XF86WLAN"]              = {"WLAN", nil, }
keyboard_layout.keymap["XF86Tools"]             = {"kbvwr", nil, }
keyboard_layout.keymap["XF86Search"]            = {"search", nil, }
keyboard_layout.keymap["XF86LaunchA"]           = {"tray", nil, }
keyboard_layout.keymap["XF86Explorer"]          = {"dashbar", nil, }

-- XF86Switch_VT_1
-- XF86AudioLowerVolume          
-- XF86AudioRaiseVolume          
-- XF86AudioMicMute
-- XF86MonBrightnessDown          
-- XF86MonBrightnessUp          
-- XF86Display
-- XF86WLAN
-- XF86Tools
-- XF86Bluetooth / XF86Search
keyboard_layout.keymap["Escape"]    = {"ESC",  "ESC",      }
keyboard_layout.keymap["F1"]        = {"F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",     }
keyboard_layout.keymap["F2"]        = {"F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",     }
keyboard_layout.keymap["F3"]        = {"F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",     }
keyboard_layout.keymap["F4"]        = {"F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",     }
keyboard_layout.keymap["F5"]        = {"F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",     }
keyboard_layout.keymap["F6"]        = {"F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",     }
keyboard_layout.keymap["F7"]        = {"F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",     }
keyboard_layout.keymap["F8"]        = {"F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",     }
keyboard_layout.keymap["F9"]        = {"F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",     }
keyboard_layout.keymap["F10"]       = {"F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",    }
keyboard_layout.keymap["F11"]       = {"F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",    }
keyboard_layout.keymap["F12"]       = {"F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",    }
keyboard_layout.keymap["Home"]      = {"Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home",   }
keyboard_layout.keymap["End"]       = {"End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",    }
keyboard_layout.keymap["Insert"]    = {"Ins",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",    }
keyboard_layout.keymap["Delete"]    = {"Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",    }
-- row     2          
keyboard_layout.keymap["grave"]     = {"`",         "~",        }
keyboard_layout.keymap["1"]         = {"1",         "!",        }
keyboard_layout.keymap["2"]         = {"2",         "@",        }
keyboard_layout.keymap["3"]         = {"3",         "#",        }
keyboard_layout.keymap["4"]         = {"4",         "$",        }
keyboard_layout.keymap["5"]         = {"5",         "%",        }
keyboard_layout.keymap["6"]         = {"6",         "^",        }
keyboard_layout.keymap["7"]         = {"7",         "&",        }
keyboard_layout.keymap["8"]         = {"8",         "*",        }
keyboard_layout.keymap["9"]         = {"9",         "(",        }
keyboard_layout.keymap["0"]         = {"0",         ")",        }
keyboard_layout.keymap["-"]         = {"-",         "_",        }
keyboard_layout.keymap["="]         = {"=",         "+",        }
keyboard_layout.keymap["BackSpace"] = {"BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace","BackSpace","BackSpace",}
-- row     3          
keyboard_layout.keymap["Tab"]       = {"Tab",       "Tab",      }
keyboard_layout.keymap["q"]         = {"q",         "Q",        }
keyboard_layout.keymap["w"]         = {"w",         "W",        }
keyboard_layout.keymap["e"]         = {"e",         "E",        }
keyboard_layout.keymap["r"]         = {"r",         "R",        }
keyboard_layout.keymap["t"]         = {"t",         "T",        }
keyboard_layout.keymap["y"]         = {"y",         "Y",        }
keyboard_layout.keymap["u"]         = {"u",         "U",        }
keyboard_layout.keymap["i"]         = {"i",         "I",        }
keyboard_layout.keymap["o"]         = {"o",         "O",        }
keyboard_layout.keymap["p"]         = {"p",         "P",        }
keyboard_layout.keymap["["]         = {"[",         "{",        }
keyboard_layout.keymap["]"]         = {"]",         "}",        }
keyboard_layout.keymap["Return"]    = {"Return",    "Return",   }
-- row 4          
keyboard_layout.keymap["Caps_Lock"] = {"Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock","Caps_Lock","Caps_Lock",}
keyboard_layout.keymap["a"]         = {"a",         "A",        }
keyboard_layout.keymap["s"]         = {"s",         "S",        }
keyboard_layout.keymap["d"]         = {"d",         "D",        }
keyboard_layout.keymap["f"]         = {"f",         "F",        }
keyboard_layout.keymap["g"]         = {"g",         "G",        }
keyboard_layout.keymap["h"]         = {"h",         "H",        }
keyboard_layout.keymap["j"]         = {"j",         "J",        }
keyboard_layout.keymap["k"]         = {"k",         "K",        }
keyboard_layout.keymap["l"]         = {"l",         "L",        }
keyboard_layout.keymap[";"]         = {";",         ":",        }
keyboard_layout.keymap["'"]         = {"'",         "\"",       }
keyboard_layout.keymap["\\"]        = {"\\",        "|",        }
-- keyboard_layout.keymap["Return"] = {"Return",    "Return",   }
-- row 5              
keyboard_layout.keymap["Shift_L"]   = {"shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",    "shift",    "shift",    }
keyboard_layout.keymap["<"]         = {"<",         ">",        }
keyboard_layout.keymap["z"]         = {"z",         "Z",        }
keyboard_layout.keymap["x"]         = {"x",         "X",        }
keyboard_layout.keymap["c"]         = {"c",         "C",        }
keyboard_layout.keymap["v"]         = {"v",         "V",        }
keyboard_layout.keymap["b"]         = {"b",         "B",        }
keyboard_layout.keymap["n"]         = {"n",         "N",        }
keyboard_layout.keymap["m"]         = {"m",         "M",        }
keyboard_layout.keymap[","]         = {",",         "<",        }
keyboard_layout.keymap["."]         = {".",         ">",        }
keyboard_layout.keymap["/"]         = {"/",         "?",        }
keyboard_layout.keymap["Shift_R"]   = {"shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",    "shift",    "shift",    }
-- row 6              
keyboard_layout.keymap["Fn"]        = {"Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",       "Fn",       "Fn",       }
keyboard_layout.keymap["Control_L"] = {"Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",   "Crtl L",   "Crtl L",   }
keyboard_layout.keymap["Super_L"]   = {"mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",     "mod4",     "mod4",     }
keyboard_layout.keymap["Alt_L"]     = {"mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",     "mod1",     "mod1",     }
keyboard_layout.keymap["space"]     = {"[ ]",       "[ ]",      }
keyboard_layout.keymap["Alt_R"]     = {"Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",    "Alt R",    "Alt R",    }
keyboard_layout.keymap["Print"]     = { nil,         nil,       }
keyboard_layout.keymap["Control_R"] = {"Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",   "Ctrl R",   "Ctrl R",   }
keyboard_layout.keymap["Prior"]     = {"Prior",     "Prior",    }
keyboard_layout.keymap["Up"]        = {"Up",        "Up",       }
keyboard_layout.keymap["Next"]      = {"Next",      "Next",     }
-- row 7              
keyboard_layout.keymap["Left"]      = {"Left",      "Left",     }
keyboard_layout.keymap["Down"]      = {"Down",      "Down",     }
keyboard_layout.keymap["Right"]     = {"Right",     "Right",    }

-- long form description shoult go to
keyboard_layout.keydesc = {}


keyboard_layout.colormap = {}
-- keymap  basic  shift Control_L  Alt_L  Alt_L+shift  Super_L  Super_L+shift  Super_L+Alt_L  Super_L+Control_L  Super_L+Control_L+Alt_L  Control_R
-- level   -1-     -2-   -3-        -4-    -5-          -6-      -7-            -8-            -9-                -10-                     -11-
keyboard_layout.colormap["XF86AudioMute"]         = {}
keyboard_layout.colormap["XF86AudioLowerVolume"]  = {}
keyboard_layout.colormap["XF86AudioRaiseVolume"]  = {}
keyboard_layout.colormap["XF86AudioMicMute"]      = {}
keyboard_layout.colormap["XF86MonBrightnessDown"] = {}
keyboard_layout.colormap["XF86MonBrightnessUp"]   = {}
keyboard_layout.colormap["XF86Display"]           = {}
keyboard_layout.colormap["XF86WLAN"]              = {}
keyboard_layout.colormap["XF86Tools"]             = {}
keyboard_layout.colormap["XF86Search"]            = {}
keyboard_layout.colormap["XF86LaunchA"]           = {}
keyboard_layout.colormap["XF86Explorer"]          = {}
keyboard_layout.colormap["Escape"]    = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F1"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F2"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F3"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F4"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F5"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F6"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F7"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F8"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F9"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F10"]       = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F11"]       = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["F12"]       = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Home"]      = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["End"]       = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Insert"]    = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Delete"]    = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["grave"]     = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["1"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["2"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["3"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["4"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["5"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["6"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["7"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["8"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["9"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["0"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["-"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["="]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["BackSpace"] = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Tab"]       = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["q"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["w"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["e"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["r"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["t"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["y"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["u"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["i"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["o"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["p"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["["]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["]"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Return"]    = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Caps_Lock"] = {"#7c5f64", x.color4,  "#7c5f64", "#7c5f64", x.color4, "#7c5f64",  x.color4,  "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["a"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["s"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["d"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["f"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["g"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["h"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["j"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["k"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["l"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap[";"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["'"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["\\"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Shift_L"]   = {"#7c5f64", x.color4,  "#7c5f64", "#7c5f64", x.color4,  "#7c5f64", x.color4,  "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["<"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["z"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["x"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["c"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["v"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["b"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["n"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["m"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap[","]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["."]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["/"]         = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Shift_R"]   = {"#7c5f64", x.color4,  "#7c5f64", "#7c5f64", x.color4,  "#7c5f64", x.color4,  "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Fn"]        = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Control_L"] = {"#7c5f64", "#7c5f64", x.color4,  "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", x.color4,  x.color4,  "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Super_L"]   = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", x.color4,  x.color4,  x.color4,  "#7c5f64", x.color4,  "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Alt_L"]     = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", x.color4,  x.color4,  x.color4,  "#7c5f64", x.color4,  }
keyboard_layout.colormap["space"]     = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Alt_R"]     = {"#7c5f64", "#7c5f64", "#7c5f64", x.color4,  x.color4,  "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", }
keyboard_layout.colormap["Print"]     = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Control_R"] = {"#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", "#7c5f64", x.color4,  "#7c5f64",  }
keyboard_layout.colormap["Prior"]     = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Up"]        = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Next"]      = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Left"]      = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Down"]      = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }
keyboard_layout.colormap["Right"]     = { nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,       nil,      }

return keyboard_layout