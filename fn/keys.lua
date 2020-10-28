-- awesomeWM lua packages =============================================
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
-- needed kbvwr stuff =================================================
local kbvwr   = {}
kbvwr.config  = require("kbvwr.config")
-- package keys / keys.fn =============================================
kbvwr.fn = {}
kbvwr.fn      = require("kbvwr.fn")
kbvwr.fn.keys = {}

-- define octal numbers for modifiers =================================
-- should be called from kbvwr or rc.lua
function kbvwr.fn.keys.genOctalList(keys)
  local ii = 0
  -- generate correct octal dictionary
  local octal = {
    ['Shift'] = 2^ii,
    -- needs to be 2^0=1 in order to access the second level in
    -- keys[ <keyname> ].symbol
  }
  for key,val in pairs(keys) do
    -- test if key is a Modifier
    -- use ID as this is is the same for "Enter1"/"Enter2"
    -- or "Shift_L" and "Shift_R"
    -- if key ~= "Shift_L" or key ~= "Shift_R" then
      -- nothing ("Shift" is already taken care of)
    if val.isModifier and gears.table.hasitem(octal, val.id) == nil then
      ii = ii + 1
      octal[key] = 2^ii
    end
  end
  return octal
end

-- maybe this function is not neeeded at all. =========================
function kbvwr.fn.keys.getAwesomeModifiers(modifiers)
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
    elseif mod == "Alt_R" or mod == "" or mod == " " then
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
function kbvwr.fn.keys.lvl_array(modifiers, octal)
  -- naughty.notify({text = type(modifiers)})
  -- return lvl from modifiers
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
    elseif mod == "Alt_R" or mod == "" or mod == " " then
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

-- public function to get lvl from array of keys ======================
function kbvwr.fn.keys.lvl_dict(modifiers, octal)
  -- naughty.notify({text = type(modifiers)})
  -- return lvl from modifiers
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
      elseif mod == "Alt_R" or mod == "" or mod == " " then
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

-- public function to generate keybindings and update the respective key
function kbvwr.fn.keys.bind(kbvwr, modifiers, key, symbol, group, description, isGlobalkey, fn)
  -- check if key is available and notify if otherwise
  if gears.table.hasitem(kbvwr.keys, key) == false then
    naughty.notify({text = "'"..key.."' could not be bound, key is not defined."})
  end
  -- register symbol and description in key.symbol and key.description
  local lvl = kbvwr.fn.keys.lvl_array(modifiers, kbvwr.bind.octal)
  if kbvwr.keys[key].symbol[lvl] ~= nil and kbvwr.keys[key].symbol[lvl] ~= "" then
    naughty.notify({text = "lvl "..lvl.." + "..key.." is already defined"})
  end
  if lvl == 1 then
    kbvwr.keys[key].w.text.markup = "<span font='".. kbvwr.config.fontsize_symbols .."'>".. symbol:gsub("icon:", "") .."</span>"
    kbvwr.keys[key].w.bg = kbvwr.config.groupcolors[group] or kbvwr.config.default_key_bg
  end
  kbvwr.keys[key].symbol[lvl]      = symbol
  kbvwr.keys[key].description[lvl] = description
  kbvwr.keys[key].group[lvl]       = group
  -- create and append element to keys.globalkeys or connect to client signal
  keybind = awful.key( kbvwr.fn.keys.getAwesomeModifiers(modifiers), key, fn, {description = description, group = group})
  if isGlobalKey then
    kbvwr.bind.globalkeybindings = gears.table.join(kbvwr.bind.globalkeybindings, keybind)
  else
    kbvwr.bind.clientkeybindings = gears.table.join(kbvwr.bind.clientkeybindings, keybind)
  end
end

-- public functions to update keys ====================================
function kbvwr.fn.keys.set_bg(name, bg)
  kbvwr.keys[name].w:get_children_by_id("background")[1].bg = bg
end
function kbvwr.fn.keys.set_text(name, text)
  kbvwr.keys[name].w:get_children_by_id("text")[1].text = text
end

return kbvwr.fn.keys