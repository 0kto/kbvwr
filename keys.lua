-- awesomeWM lua packages =============================================
local gears = require("gears")
local wibox = require("wibox")
-- needed kbvwr stuff =================================================
local kbvwr   = {}
kbvwr.fn      = require("kbvwr.fn")
kbvwr.config  = require("kbvwr.config")
kbvwr.helpers = require("kbvwr.helpers")
-- package keys =======================================================
kbvwr.keys    = {}

-- private function ===================================================
local function genkey(id, symbol, isModifier, description, geometry)
  key = {}
  key.id           = id
  key.symbol       = symbol
  key.group        = {}
  if key.symbol[1] == nil then
    symbol[1] = ""
  end
  key.isModifier   = isModifier
  key.description  = description
  if isModifier then
    key.bg = kbvwr.config.modifier_key_bg
    key.fg = kbvwr.config.modifier_key_fg
  else
    key.bg = kbvwr.config.default_key_bg
    key.fg = kbvwr.config.default_key_fg
  end

  key.w = wibox.container {
    id = id,
    {
      id = "text",
      widget = wibox.widget.textbox(),
      markup = symbol[1]:gsub("[^%s]+", kbvwr.fn.markupFromString ),
      font   = font,
      align  = "center",
      valign = "center",
    },
    widget = wibox.widget {
      id = "background",
      widget        = wibox.container.background(),
      bg            = key.bg,
      fg            = key.fg,
      forced_width  = dpi(geometry[1]),
      forced_height = dpi(geometry[2]),
      shape         = kbvwr.helpers.rrect(dpi(4)),
    }
  }
  return key
end
-- generate keys ======================================================
--[[
  The keys hold the widget that is displayed in the keyboard_viewer, as
  well as all related information.
  Both keys[ <keyname> ].symbol and keys[ <keyname> ].description are 
  arrays, with a _very_ high number of elements; however, these usually
  hold the value "nil" and thus space should not be an issue in lua.
  Similar to the "chmod" tool, the elements of these arrays are 
  addressed by lvl = octal digits + 1, derived by adding up the bits 
  with values of 2^0 .. 2^n, where the values are specified by the 
  dictionary kbvwr.keys.octal below. The +1 takes into account, that 
  lua starts counting at 1 rather than 0.
--]]
-- shorthands
local w  = kbvwr.config.keys.width
local wd = w["default"]
local h  = kbvwr.config.keys.height
local hd = h["default"]

kbvwr.keys["Escape"]    = genkey("Escape",    {"Esc", "Esc"},          false, { }, {w["Escape"],h["Fx"]} )
kbvwr.keys["F1"]        = genkey("F1",        {"F1"},                  false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F2"]        = genkey("F2",        {"F2"},                  false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F3"]        = genkey("F3",        {"F3"},                  false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F4"]        = genkey("F4",        {"F4"},                  false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F5"]        = genkey("F5",        {"F5"},                  false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F6"]        = genkey("F6",        {"F6"},                  false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F7"]        = genkey("F7",        {"F7"},                  false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F8"]        = genkey("F8",        {"F8"},                  false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F9"]        = genkey("F9",        {"F9"},                  false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F10"]       = genkey("F10",       {"F10"},                 false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F11"]       = genkey("F11",       {"F11"},                 false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["F12"]       = genkey("F12",       {"F12"},                 false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["Home"]      = genkey("Home",      {"Home", "Home"},        false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["End"]       = genkey("End",       {"End", "End"},          false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["Insert"]    = genkey("Insert",    {"Ins", "Ins"},          false, { }, {w["Fx"],h["Fx"]}     )
kbvwr.keys["Delete"]    = genkey("Delete",    {"Del", "Del"},         false, { }, {w["Delete"],h["Fx"]} )
kbvwr.keys["`"]         = genkey("grave",     {"`", "~"},              false, { }, {wd, hd} )
kbvwr.keys["1"]         = genkey("1",         {"1", "!"},              false, { }, {wd, hd} )
kbvwr.keys["2"]         = genkey("2",         {"2", "@"},              false, { }, {wd, hd} )
kbvwr.keys["3"]         = genkey("3",         {"3", "#"},              false, { }, {wd, hd} )
kbvwr.keys["4"]         = genkey("4",         {"4", "$"},              false, { }, {wd, hd} )
kbvwr.keys["5"]         = genkey("5",         {"5", "%"},              false, { }, {wd, hd} )
kbvwr.keys["6"]         = genkey("6",         {"6", "^"},              false, { }, {wd, hd} )
kbvwr.keys["7"]         = genkey("7",         {"7", "&"},              false, { }, {wd, hd} )
kbvwr.keys["8"]         = genkey("8",         {"8", "*"},              false, { }, {wd, hd} )
kbvwr.keys["9"]         = genkey("9",         {"9", "("},              false, { }, {wd, hd} )
kbvwr.keys["0"]         = genkey("0",         {"0", ")"},              false, { }, {wd, hd} )
kbvwr.keys["-"]         = genkey("-",         {"-", "_"},              false, { }, {wd, hd} )
kbvwr.keys["="]         = genkey("=",         {"=", "+"},              false, { }, {wd, hd} )
kbvwr.keys["BackSpace"] = genkey("BackSpace", {" icon: "," icon: "}, false, { }, {w["BackSpace"], hd} )
kbvwr.keys["Tab"]       = genkey("Tab",       {" icon: "," icon: "}, false, { }, {w["Tab"], hd} )
kbvwr.keys["q"]         = genkey("q",         {"q", "Q"},              false, { }, {wd, hd} )
kbvwr.keys["w"]         = genkey("w",         {"w", "W"},              false, { }, {wd, hd} )
kbvwr.keys["e"]         = genkey("e",         {"e", "E"},              false, { }, {wd, hd} )
kbvwr.keys["r"]         = genkey("r",         {"r", "R"},              false, { }, {wd, hd} )
kbvwr.keys["t"]         = genkey("t",         {"t", "T"},              false, { }, {wd, hd} )
kbvwr.keys["y"]         = genkey("y",         {"y", "Y"},              false, { }, {wd, hd} )
kbvwr.keys["u"]         = genkey("u",         {"u", "U"},              false, { }, {wd, hd} )
kbvwr.keys["i"]         = genkey("i",         {"i", "I"},              false, { }, {wd, hd} )
kbvwr.keys["o"]         = genkey("o",         {"o", "O"},              false, { }, {wd, hd} )
kbvwr.keys["p"]         = genkey("p",         {"p", "P"},              false, { }, {wd, hd} )
kbvwr.keys["["]         = genkey("[",         {"[", "{"},              false, { }, {wd, hd} )
kbvwr.keys["]"]         = genkey("]",         {"]", "}"},              false, { }, {wd, hd} )
-- kbvwr.keys["Return"]    = genkey("Return",    {" icon: "}, false, { }, {w["Return1"], hd} )
kbvwr.keys["Caps_Lock"] = genkey("Caps_Lock", {" icon: "},            true , { "not assigned" },       {w["Caps_Lock"], hd} )
kbvwr.keys["a"]         = genkey("a",         {"a", "A"},              false, { }, {wd, hd} )
kbvwr.keys["s"]         = genkey("s",         {"s", "S"},              false, { }, {wd, hd} )
kbvwr.keys["d"]         = genkey("d",         {"d", "D"},              false, { }, {wd, hd} )
kbvwr.keys["f"]         = genkey("f",         {"f", "F"},              false, { }, {wd, hd} )
kbvwr.keys["g"]         = genkey("g",         {"g", "G"},              false, { }, {wd, hd} )
kbvwr.keys["h"]         = genkey("h",         {"h", "H"},              false, { }, {wd, hd} )
kbvwr.keys["j"]         = genkey("j",         {"j", "J"},              false, { }, {wd, hd} )
kbvwr.keys["k"]         = genkey("k",         {"k", "K"},              false, { }, {wd, hd} )
kbvwr.keys["l"]         = genkey("l",         {"l", "L"},              false, { }, {wd, hd} )
kbvwr.keys[";"]         = genkey(";",         {";", ":"},              false, { }, {wd, hd} )
kbvwr.keys["'"]         = genkey("'",        {"'", "\""},              false, { }, {wd, hd} )
kbvwr.keys["\\"]        = genkey("\\",        {"\\", "|"},             false, { }, {wd, hd} )
kbvwr.keys["Return"]    = genkey("Return",    {" icon: "," icon: "}, false, { }, {w["Return2"], hd} )
kbvwr.keys["Shift_L"]   = genkey("Shift",     {" icon: "},            true , { }, {w["Shift_L"], hd} )
kbvwr.keys["<"]         = genkey("<",         {"<", ">"},              false, { }, {wd, hd} )
kbvwr.keys["z"]         = genkey("z",         {"z", "Z"},              false, { }, {wd, hd} )
kbvwr.keys["x"]         = genkey("x",         {"x", "X"},              false, { }, {wd, hd} )
kbvwr.keys["c"]         = genkey("c",         {"c", "C"},              false, { }, {wd, hd} )
kbvwr.keys["v"]         = genkey("v",         {"v", "V"},              false, { }, {wd, hd} )
kbvwr.keys["b"]         = genkey("b",         {"b", "B"},              false, { }, {wd, hd} )
kbvwr.keys["n"]         = genkey("n",         {"n", "N"},              false, { }, {wd, hd} )
kbvwr.keys["m"]         = genkey("m",         {"m", "M"},              false, { }, {wd, hd} )
kbvwr.keys[","]         = genkey(",",         {",", "<"},              false, { }, {wd, hd} )
kbvwr.keys["."]         = genkey(".",         {".", ">"},              false, { }, {wd, hd} )
kbvwr.keys["/"]         = genkey("/",         {"/", "?"},              false, { }, {wd, hd} )
kbvwr.keys["Shift_R"]   = genkey("Shift",     {"icon: "},             true , { }, {w["Shift_R"], hd} )
kbvwr.keys["Fn"]        = genkey("Fn",        {"Fn"},                  true , { }, {w["Fn"], hd} )
kbvwr.keys["Control_L"] = genkey("Control_L", {" icon: "},            true , { "CTRL left" }, {w["Control_L"], hd} )
kbvwr.keys["Super_L"]   = genkey("Super_L",   {" icon: "},            true , { "AwesomeWM commands" }, {w["Super_L"], hd} )
kbvwr.keys["Alt_L"]     = genkey("Alt_L",     {" icon: "},            true , { "Alt" }, {w["Alt_L"], hd} )
kbvwr.keys["space"]     = genkey("space",     {" icon: "," icon: "}, false, { }, {w["Space"], hd} )
kbvwr.keys["Alt_R"]     = genkey("Alt_R",     {" icon: "},            true , { "Alt Gr" }, {w["Alt_R"], hd} )
kbvwr.keys["Print"]     = genkey("Print",     { nil },                 false, { }, {w["Print"], hd} )
kbvwr.keys["Control_R"] = genkey("Control_R", {" icon: "},            true , { "CTRL right" }, {w["Control_R"], hd} )
kbvwr.keys["Prior"]     = genkey("Prior",     {" icon: "," icon: "}, false, { }, {w["Arrow"], hd} )
kbvwr.keys["Up"]        = genkey("Up",        {" icon: "," icon: "}, false, { }, {w["Arrow"], hd} )
kbvwr.keys["Next"]      = genkey("Next",      {" icon: "," icon: "}, false, { }, {w["Arrow"], hd} )
kbvwr.keys["Left"]      = genkey("Left",      {" icon: "," icon: "}, false, { }, {w["Arrow"], hd} )
kbvwr.keys["Down"]      = genkey("Down",      {" icon: "," icon: "}, false, { }, {w["Arrow"], hd} )
kbvwr.keys["Right"]     = genkey("Right",     {" icon: "," icon: "}, false, { }, {w["Arrow"], hd} )

-- special keys =======================================================
kbvwr.keys["XF86WLAN"]              = genkey("XF86WLAN",              { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86AudioMute"]         = genkey("XF86AudioMute",         { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86AudioLowerVolume"]  = genkey("XF86AudioLowerVolume",  { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86AudioRaiseVolume"]  = genkey("XF86AudioRaiseVolume",  { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86AudioMicMute"]      = genkey("XF86AudioMicMute",      { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86MonBrightnessDown"] = genkey("XF86MonBrightnessDown", { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86MonBrightnessUp"]   = genkey("XF86MonBrightnessUp",   { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86Display"]           = genkey("XF86Display",           { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86Search"]            = genkey("XF86Search",            { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86Tools"]             = genkey("XF86Tools",             { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86LaunchA"]           = genkey("XF86LaunchA",           { nil }, false, { }, {w["Fx"], h["Fx"]} )
kbvwr.keys["XF86Explorer"]          = genkey("XF86Explorer",          { nil }, false, { }, {w["Fx"], h["Fx"]} )

return kbvwr.keys











