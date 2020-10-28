-- awesomeWM lua packages =============================================
local awful     = require("awful")
local wibox     = require("wibox")
local naughty   = require("naughty")
-- elenapan-awesome (to be eliminated) ================================
local helpers   = require("helpers")

-- needed kbvwr stuff =================================================
local kbvwr  = {}
kbvwr.config = require("kbvwr.config")
-- package fn =========================================================
kbvwr.fn     = {}

-- Function to draw a nice key.
function kbvwr.fn.create_key(key,keymap,colormap,level,height,width)

  local text = keymap[key][level] or ""
  local  font = kbvwr.config.font.." ".. kbvwr.config.fontsize
  if text ~= "" and text:find "icon:" ~= nil then
    font = kbvwr.config.font.." ".. kbvwr.config.fontsize_symbols
    text = text:gsub("icon:", "")
  end
  
  -- set font color if bg is the default key color
  local bg = colormap[key][level] or kbvwr.config.default_key_color
  if bg ~= kbvwr.config.default_key_color then
    fg = kbvwr.config.default_key_color
  else
    fg = kbvwr.config.fg
  end

  local key_box = wibox.widget {
    id = key.."_"..level,
    {
      font = font,
      align = "center",
      valign = "center",
      widget = wibox.widget.textbox(text, true)
    },
    widget = wibox.widget {
      bg = bg,
      fg = fg,
      forced_height = dpi(height),
      forced_width  = dpi(width),
      shape = helpers.rrect(dpi(4)),
      widget = wibox.container.background()
    }
  }
  return key_box
end

function kbvwr.fn.formatIcon(input)
  if input ~= nil and input ~= "" and input:find "icon:" ~= nil then
    output = "<span font='".. kbvwr.config.fontsize_symbols .."'>".. input:gsub("icon:", "") .."</span>"
    return output
  else
    return input
  end
end

return kbvwr.fn
