local helpers = require("helpers")
local icons   = require("icons")
local wibox   = require("wibox")

local kbvwr         = {}
kbvwr.layout        = {}
kbvwr.config        = require("kbvwr.config")
kbvwr.layout.keymap = {}
-- kbvwr.layout.keymap              basic        shift 
-- level                                -1-          -2-  
-- Fn + F[1-12] Keys need to be defined as well
kbvwr.layout.keymap["XF86AudioMute"]         = {"mute", nil, }
kbvwr.layout.keymap["XF86AudioLowerVolume"]  = {"vol-", nil, }
kbvwr.layout.keymap["XF86AudioRaiseVolume"]  = {"vol+", nil, }
kbvwr.layout.keymap["XF86AudioMicMute"]      = {"mic mute", nil, }
kbvwr.layout.keymap["XF86MonBrightnessDown"] = {"bright-", nil, }
kbvwr.layout.keymap["XF86MonBrightnessUp"]   = {"bright+", nil, }
kbvwr.layout.keymap["XF86Display"]           = {"display", nil, }
kbvwr.layout.keymap["XF86WLAN"]              = {"WLAN", nil, }
kbvwr.layout.keymap["XF86Tools"]             = {"kbvwr", nil, }
kbvwr.layout.keymap["XF86Search"]            = {"search", nil, }
kbvwr.layout.keymap["XF86LaunchA"]           = {"tray", nil, }
kbvwr.layout.keymap["XF86Explorer"]          = {"dashbar", nil, }
-- XF86Switch_VT_1
-- XF86Bluetooth

kbvwr.layout.keymap["Escape"]    = {"ESC",  "ESC", }
kbvwr.layout.keymap["F1"]        = {"F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",   "F1",     }
kbvwr.layout.keymap["F2"]        = {"F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",   "F2",     }
kbvwr.layout.keymap["F3"]        = {"F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",   "F3",     }
kbvwr.layout.keymap["F4"]        = {"F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",   "F4",     }
kbvwr.layout.keymap["F5"]        = {"F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",   "F5",     }
kbvwr.layout.keymap["F6"]        = {"F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",   "F6",     }
kbvwr.layout.keymap["F7"]        = {"F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",   "F7",     }
kbvwr.layout.keymap["F8"]        = {"F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",   "F8",     }
kbvwr.layout.keymap["F9"]        = {"F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",   "F9",     }
kbvwr.layout.keymap["F10"]       = {"F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",  "F10",    }
kbvwr.layout.keymap["F11"]       = {"F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",  "F11",    }
kbvwr.layout.keymap["F12"]       = {"F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",  "F12",    }
kbvwr.layout.keymap["Home"]      = {"Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home", "Home",   }
kbvwr.layout.keymap["End"]       = {"End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",  "End",    }
kbvwr.layout.keymap["Insert"]    = {"Ins",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",  "Ind",    }
kbvwr.layout.keymap["Delete"]    = {"Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",  "Del",    }
-- row     2          
kbvwr.layout.keymap["grave"]     = {"`",         "~",        }
kbvwr.layout.keymap["1"]         = {"1",         "!",        }
kbvwr.layout.keymap["2"]         = {"2",         "@",        }
kbvwr.layout.keymap["3"]         = {"3",         "#",        }
kbvwr.layout.keymap["4"]         = {"4",         "$",        }
kbvwr.layout.keymap["5"]         = {"5",         "%",        }
kbvwr.layout.keymap["6"]         = {"6",         "^",        }
kbvwr.layout.keymap["7"]         = {"7",         "&",        }
kbvwr.layout.keymap["8"]         = {"8",         "*",        }
kbvwr.layout.keymap["9"]         = {"9",         "(",        }
kbvwr.layout.keymap["0"]         = {"0",         ")",        }
kbvwr.layout.keymap["-"]         = {"-",         "_",        }
kbvwr.layout.keymap["="]         = {"=",         "+",        }
kbvwr.layout.keymap["BackSpace"] = {"BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace", "BackSpace","BackSpace","BackSpace",}
-- row     3          
kbvwr.layout.keymap["Tab"]       = {"Tab",       "Tab",      }
kbvwr.layout.keymap["q"]         = {"q",         "Q",        }
kbvwr.layout.keymap["w"]         = {"w",         "W",        }
kbvwr.layout.keymap["e"]         = {"e",         "E",        }
kbvwr.layout.keymap["r"]         = {"r",         "R",        }
kbvwr.layout.keymap["t"]         = {"t",         "T",        }
kbvwr.layout.keymap["y"]         = {"y",         "Y",        }
kbvwr.layout.keymap["u"]         = {"u",         "U",        }
kbvwr.layout.keymap["i"]         = {"i",         "I",        }
kbvwr.layout.keymap["o"]         = {"o",         "O",        }
kbvwr.layout.keymap["p"]         = {"p",         "P",        }
kbvwr.layout.keymap["["]         = {"[",         "{",        }
kbvwr.layout.keymap["]"]         = {"]",         "}",        }
kbvwr.layout.keymap["Return"]    = {"Return",    "Return",   }
-- row 4          
kbvwr.layout.keymap["Caps_Lock"] = {"Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock", "Caps_Lock","Caps_Lock","Caps_Lock",}
kbvwr.layout.keymap["a"]         = {"a",         "A",        }
kbvwr.layout.keymap["s"]         = {"s",         "S",        }
kbvwr.layout.keymap["d"]         = {"d",         "D",        }
kbvwr.layout.keymap["f"]         = {"f",         "F",        }
kbvwr.layout.keymap["g"]         = {"g",         "G",        }
kbvwr.layout.keymap["h"]         = {"h",         "H",        }
kbvwr.layout.keymap["j"]         = {"j",         "J",        }
kbvwr.layout.keymap["k"]         = {"k",         "K",        }
kbvwr.layout.keymap["l"]         = {"l",         "L",        }
kbvwr.layout.keymap[";"]         = {";",         ":",        }
kbvwr.layout.keymap["'"]         = {"'",         "\"",       }
kbvwr.layout.keymap["\\"]        = {"\\",        "|",        }
-- kbvwr.layout.keymap["Return"] = {"Return",    "Return",   }
-- row 5              
kbvwr.layout.keymap["Shift_L"]   = {"shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",    "shift",    "shift",    }
kbvwr.layout.keymap["<"]         = {"<",         ">",        }
kbvwr.layout.keymap["z"]         = {"z",         "Z",        }
kbvwr.layout.keymap["x"]         = {"x",         "X",        }
kbvwr.layout.keymap["c"]         = {"c",         "C",        }
kbvwr.layout.keymap["v"]         = {"v",         "V",        }
kbvwr.layout.keymap["b"]         = {"b",         "B",        }
kbvwr.layout.keymap["n"]         = {"n",         "N",        }
kbvwr.layout.keymap["m"]         = {"m",         "M",        }
kbvwr.layout.keymap[","]         = {",",         "<",        }
kbvwr.layout.keymap["."]         = {".",         ">",        }
kbvwr.layout.keymap["/"]         = {"/",         "?",        }
kbvwr.layout.keymap["Shift_R"]   = {"shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",     "shift",    "shift",    "shift",    }
-- row 6              
kbvwr.layout.keymap["Fn"]        = {"Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",        "Fn",       "Fn",       "Fn",       }
kbvwr.layout.keymap["Control_L"] = {"Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",    "Crtl L",   "Crtl L",   "Crtl L",   }
kbvwr.layout.keymap["Super_L"]   = {"mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",      "mod4",     "mod4",     "mod4",     }
kbvwr.layout.keymap["Alt_L"]     = {"mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",      "mod1",     "mod1",     "mod1",     }
kbvwr.layout.keymap["space"]     = {"[ ]",       "[ ]",      }
kbvwr.layout.keymap["Alt_R"]     = {"Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",     "Alt R",    "Alt R",    "Alt R",    }
kbvwr.layout.keymap["Print"]     = { }
kbvwr.layout.keymap["Control_R"] = {"Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",    "Ctrl R",   "Ctrl R",   "Ctrl R",   }
kbvwr.layout.keymap["Prior"]     = {"Prior",     "Prior",    }
kbvwr.layout.keymap["Up"]        = {"Up",        "Up",       }
kbvwr.layout.keymap["Next"]      = {"Next",      "Next",     }
-- row 7              
kbvwr.layout.keymap["Left"]      = {"Left",      "Left",     }
kbvwr.layout.keymap["Down"]      = {"Down",      "Down",     }
kbvwr.layout.keymap["Right"]     = {"Right",     "Right",    }

-- long form description shoult go to
kbvwr.layout.keydesc = {}
for key,val in pairs(kbvwr.layout.keymap) do
  kbvwr.layout.keydesc[key] = {}
end


kbvwr.layout.colormap = {}
for key,val in pairs(kbvwr.layout.keymap) do
  kbvwr.layout.colormap[key] = {}
end
-- overrides
kbvwr.layout.colormap["Caps_Lock"] = {kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, }
kbvwr.layout.colormap["Shift_L"]   = {kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, }
kbvwr.layout.colormap["Shift_R"]   = {kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, }
kbvwr.layout.colormap["Fn"]        = {kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, }
kbvwr.layout.colormap["Control_L"] = {kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, }
kbvwr.layout.colormap["Super_L"]   = {kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.active_key_color,   kbvwr.config.active_key_color,   kbvwr.config.active_key_color,   kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, }
kbvwr.layout.colormap["Alt_L"]     = {kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   }
kbvwr.layout.colormap["Alt_R"]     = {kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, }
kbvwr.layout.colormap["Control_R"] = {kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.modifier_key_color, kbvwr.config.active_key_color,   kbvwr.config.modifier_key_color, }

return kbvwr.layout