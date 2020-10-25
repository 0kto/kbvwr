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

-- Helper function that puts a widget inside a box with a specified background color
-- Invisible margins are added so that the boxes created with this function are evenly separated
-- The widget_to_be_boxed is vertically and horizontally centered inside the box
function kbvwr.fn.create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(kbvwr.config.box_radius)

    local boxed_widget = wibox.widget {
        -- Add margins
        {
            -- Add background color
            {
                -- Center widget_to_be_boxed horizontally
                nil,
                {
                    -- Center widget_to_be_boxed vertically
                    nil,
                    -- The actual widget goes here
                    widget_to_be_boxed,
                    layout = wibox.layout.align.vertical,
                    expand = "none"
                },
                layout = wibox.layout.align.horizontal,
                expand = "none"
            },
            widget = box_container,
        },
        margins = kbvwr.config.box_gap,
        color = "#FF000000",
        widget = wibox.container.margin
    }

    return boxed_widget
end

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




-- -- Function to update key color (in layout)
-- function kbvwr.fn.mark_key_active(kbvwr, pressed_key, color)
--   local key_widget = kbvwr.widget:get_children_by_id(pressed_key)
--   -- local element = kbvwr.widget.kblayout.widget.widget
--   naughty.notify({
--     text = key_widget.text
--   })
--   -- element.bg = color
--   -- element.text = "color"
--   -- kbvwr.widget.kblayout.widget.widget
--   -- layouts[level].widget = color 
-- end




return kbvwr.fn
