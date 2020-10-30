-- awesomeWM lua packages =============================================
local awful     = require("awful")
local gears     = require("gears")
local naughty   = require("naughty")
local wibox     = require("wibox")
-- elenapan-awesome (to be eliminated) ================================
local helpers   = require("helpers")

-- needed kbvwr stuff =================================================
local kbvwr   = {}
kbvwr.config  = require("kbvwr.config")
-- package fn =========================================================
kbvwr.fn      = {}
kbvwr.fn.keys = {}

-- define octal numbers for modifiers =================================
--[[
    generate (dynamic) list of modifiers (look in 
    kbvwr.keys[key].isModifier) and pair them with the corresponding 
    octal numbers as powers of 2.
    These octal numbers translate to lvl -1, as arrays in lua are 
    indexed from 1 (and not zero).
--]]
function kbvwr.fn.genOctalList(keys)
  local ii = 0
  local octal = {
    ['Shift'] = 2^ii,
    -- needs to be 2^0=1 in order to access the second lvl in
    -- keys[ <keyname> ].symbol .
  }
  for key,val in pairs(keys) do
    -- test if key is a Modifier
    -- use ID as this is is the same for "Enter1"/"Enter2"
    -- or "Shift_L" and "Shift_R"
    if val.isModifier and gears.table.hasitem(octal, val.id) == nil then
      ii = ii + 1
      octal[key] = 2^ii
    end
  end
  return octal
end
-- translate array of modifiers into awesome modifiers =========================
--[[
    needed for aweful.key( AwesomeModifiers, keys, ... ).
--]]
function kbvwr.fn.getAwesomeModifiers(modifiers)
  awesome_modifiers = {}
  for ii,mod in ipairs(modifiers) do
    if mod == "Shift" or mod == "Shift_L" or mod == "Shift_R" or mod == "" or mod == " " then
      table.insert(awesome_modifiers, "Shift")
    elseif mod == "Super_L" or mod == "Super" or mod == "Mod4" or mod == "" or mod == " " then
      table.insert(awesome_modifiers, "Mod4")
    elseif mod == "Alt_L" or mod == "Mod1" or mod == "" or mod == " " then
      table.insert(awesome_modifiers, "Mod1")
    elseif mod == "Control_L" or mod == "Control" or mod == "" or mod == " " then
      table.insert(awesome_modifiers, "Control")
    elseif mod == "Alt_R" or mod == "ISO_Level3_Shift" or mod == "" or mod == " " then
      table.insert(awesome_modifiers, "Alt_R")
    elseif mod == "Control_R" or mod == "" or mod == " " then
      table.insert(awesome_modifiers, "Control_R")
    elseif mod == "Caps_Lock" or mod == "" or mod == " " then
      table.insert(awesome_modifiers, "Caps_Lock")
    end
  end
  return awesome_modifiers
end

-- public function to get lvl from array of keys ======================
--[[
    get lvl = 1 + sum(octal numbers) from array of keys, which is used 
    to access the arrays in kbvwr.keys[<key>].symbol/description/etc .
--]]
function kbvwr.fn.lvl_array(modifiers, octal)
  local lvl = 1
  for ii,mod in ipairs(modifiers) do
    if mod == "Shift" or mod == "Shift_L" or mod == "Shift_R" or mod == "" or mod == " " then
      lvl = lvl + octal["Shift"]
    elseif mod == "Super_L" or mod == "Super" or mod == "Mod4" or mod == "" or mod == " " then
      lvl = lvl + octal["Super_L"]
    elseif mod == "Alt_L" or mod == "Mod1" or mod == "" or mod == " " then
      lvl = lvl + octal["Alt_L"]
    elseif mod == "Control_L" or mod == "Control" or mod == "" or mod == " " then
      lvl = lvl + octal["Control_L"]
    elseif mod == "Alt_R" or mod == "ISO_Level3_Shift" or mod == "" or mod == " " then
      lvl = lvl + octal["Alt_R"]
    elseif mod == "Control_R" or mod == "" or mod == " " then
      lvl = lvl + octal["Control_R"]
    elseif mod == "Caps_Lock" or mod == "" or mod == " " then
      lvl = lvl + octal["Caps_Lock"]
    else 
      lvl = lvl + octal[mod]
    end
  end
  return lvl
end

-- public function to get lvl from dict of keys =======================
--[[
    get lvl = 1 + sum(octal numbers) from dict of keys, which is used 
    to access the arrays in kbvwr.keys[<key>].symbol/description/etc .
--]]
function kbvwr.fn.lvl_dict(modifiers, octal)
  local lvl = 1
  for mod,active in pairs(modifiers) do
    if active then
      if mod == "Shift" or mod == "Shift_L" or mod == "Shift_R" or mod == "" or mod == " " then
        lvl = lvl + octal["Shift"]
      elseif mod == "Super_L" or mod == "Super" or mod == "Mod4" or mod == "" or mod == " " then
        lvl = lvl + octal["Super_L"]
      elseif mod == "Alt_L" or mod == "Mod1" or mod == "" or mod == " " then
        lvl = lvl + octal["Alt_L"]
      elseif mod == "Control_L" or mod == "Control" or mod == "" or mod == " " then
        lvl = lvl + octal["Control_L"]
      elseif mod == "Alt_R" or mod == "ISO_Level3_Shift" or mod == "" or mod == " " then
        lvl = lvl + octal["Alt_R"]
      elseif mod == "Control_R" or mod == "" or mod == " " then
        lvl = lvl + octal["Control_R"]
      elseif mod == "Caps_Lock" or mod == "" or mod == " " then
        lvl = lvl + octal["Caps_Lock"]
      else 
        lvl = lvl + octal[mod]
      end
    end
  end
  return lvl
end
-- format strings to pango markup =====================================
function kbvwr.fn.markupFromString(input)
  if input ~= nil and input ~= "" then
    if input:find "icon:" ~= nil then
      output = "<span font_desc = '"..kbvwr.config.font.." "..kbvwr.config.fontsize_symbols .."'>".. input:gsub("icon:", "") .."</span>"
    else
      output = "<span font_desc = '"..kbvwr.config.font.." "..kbvwr.config.fontsize .."'>".. input .."</span>"
    end
    return output
  else
    return input
  end
end
-- generate keybinding and update key object ==========================
function kbvwr.fn.keys.bind(kbvwr, modifiers, key, symbol, group, description, isGlobalkey, fn)
  -- check if key is available and notify if otherwise
  if gears.table.hasitem(kbvwr.keys, key) == false then
    naughty.notify({text = "'"..key.."' could not be bound, key is not defined."})
  end
  -- register symbol and description in key.symbol and key.description .
  local lvl = kbvwr.fn.lvl_array(modifiers, kbvwr.bind.octal)
  if kbvwr.keys[key].symbol[lvl] ~= nil and kbvwr.keys[key].symbol[lvl] ~= "" then
    naughty.notify({text = "lvl "..lvl.." + "..key.." is already defined"})
  end
  -- for keybindings w/o modifiers (like 'Print') the bg color must be 
  -- manually updated, as this is the only lvl that is drawn by key 
  -- creation.
  if lvl == 1 then
    kbvwr.keys[key].w.text.markup = "<span font_desc = '"..kbvwr.config.font.." "..kbvwr.config.fontsize_symbols .."'>".. symbol:gsub("icon:", "") .."</span>"
    kbvwr.keys[key].w.bg = kbvwr.config.groupcolors[group] or kbvwr.config.default_key_bg
  end
  -- insert values into the arrays of the key object.
  kbvwr.keys[key].symbol[lvl]      = kbvwr.fn.markupFromString(symbol)
  kbvwr.keys[key].description[lvl] = kbvwr.fn.markupFromString(description)
  kbvwr.keys[key].group[lvl]       = group
  -- create and append element to bind.<global/client>keybindigns dictionary.
  keybind = awful.key( kbvwr.fn.getAwesomeModifiers(modifiers), key, fn, {description = kbvwr.fn.markupFromString(description), group = group})
  if isGlobalKey then
    kbvwr.bind.globalkeybindings = gears.table.join(kbvwr.bind.globalkeybindings, keybind)
  else
    kbvwr.bind.clientkeybindings = gears.table.join(kbvwr.bind.clientkeybindings, keybind)
  end
end

return kbvwr.fn
