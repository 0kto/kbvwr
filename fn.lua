local awful     = require("awful")
local helpers   = require("helpers")
local wibox     = require("wibox")

local kbvwr  = {}
kbvwr.config = require("kbvwr.config")
kbvwr.fn     = {}



-- function to determine level from dict of active modifiers
function kbvwr.fn.level_from_modifiers(dict_avtive_modifiers)
    -- this function looks at the 'dict_avtive_modifiers' dictionary to determine the
    -- current level to be displayed.
    -- keyboard_layout.keymap / keyboard_layout.colormap / keyboard_layout.keydesc
    lvl = 0
    if dict_avtive_modifiers['Alt_L']     then lvl = lvl + 2^0 end
    if dict_avtive_modifiers['Alt_R']     then lvl = lvl + 2^1 end
    if dict_avtive_modifiers['Caps_Lock'] then lvl = lvl + 2^2 end
    if dict_avtive_modifiers['Control_L'] then lvl = lvl + 2^3 end
    if dict_avtive_modifiers['Control_R'] then lvl = lvl + 2^4 end
    if dict_avtive_modifiers['shift']     then lvl = lvl + 2^5 end
    if dict_avtive_modifiers['Super_L']   then lvl = lvl + 2^6 end

    return kbvwr.fn.level_from_lvl(lvl)
end

-- function to translate lvl=sum_i (a_i*2^i) to level
function kbvwr.fn.level_from_lvl(lvl)
    local level = 1
    if     lvl == 1 then -- Alt_L
        level = 12
    elseif lvl == 2 then -- Alt_R
        level = 4
    elseif lvl == 4 then -- Caps_Lock
        level = 2
    elseif lvl == 8 then -- Control_L
        level = 3
    elseif lvl == 16 then -- Control_R
        level = 11
    elseif lvl == 32 then -- shift
        level = 2
    elseif lvl == 64 then -- Super_L
        level = 6
    elseif lvl == 2 + 32 then -- Alt_R + shift
        level = 5
    elseif lvl == 64 + 32 then -- Super_L + shift
        level = 7
    elseif lvl == 64 + 1 then -- Super_L + Alt_L
        level = 8
    elseif lvl == 64 + 8 then -- Super_L + Control_L
        level = 9
    elseif lvl == 64 + 8 + 1 then -- Super_L + Control_L + Alt_L
        level = 10
    end
    -- naughty.notify({text = "level is " .. level .. "\n lvl is " .. lvl})
    return level
end

-- Helper function that puts a widget inside a box with a specified background color
-- Invisible margins are added so that the boxes created with this function are evenly separated
-- The widget_to_be_boxed is vertically and horizontally centered inside the box
function kbvwr.fn.create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(kbvwr.config.box_radius)
    -- box_container.shape = helpers.prrect(20, true, true, true, true)
    -- box_container.shape = helpers.prrect(30, true, true, false, true)

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
local key_box = wibox.widget {
  {
    name = key,
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

-- Function to create the keyboard layout for each level.
function kbvwr.fn.create_layout(keymap,colormap,level)
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
  
  -- Define keys, so they should be update-able.
  local key_Escape     = kbvwr.fn.create_key("Escape",    keymap, colormap, level, fkey_height, Escape_width )
  local key_F1         = kbvwr.fn.create_key("F1",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F2         = kbvwr.fn.create_key("F2",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F3         = kbvwr.fn.create_key("F3",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F4         = kbvwr.fn.create_key("F4",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F5         = kbvwr.fn.create_key("F5",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F6         = kbvwr.fn.create_key("F6",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F7         = kbvwr.fn.create_key("F7",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F8         = kbvwr.fn.create_key("F8",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F9         = kbvwr.fn.create_key("F9",        keymap, colormap, level, fkey_height, fkey_width )
  local key_F10        = kbvwr.fn.create_key("F10",       keymap, colormap, level, fkey_height, fkey_width )
  local key_F11        = kbvwr.fn.create_key("F11",       keymap, colormap, level, fkey_height, fkey_width )
  local key_F12        = kbvwr.fn.create_key("F12",       keymap, colormap, level, fkey_height, fkey_width )
  local key_Home       = kbvwr.fn.create_key("Home",      keymap, colormap, level, fkey_height, fkey_width )
  local key_End        = kbvwr.fn.create_key("End",       keymap, colormap, level, fkey_height, fkey_width )
  local key_Insert     = kbvwr.fn.create_key("Insert",    keymap, colormap, level, fkey_height, fkey_width )
  local key_Delete     = kbvwr.fn.create_key("Delete",    keymap, colormap, level, fkey_height, Delete_width )
 
  local key_grave      = kbvwr.fn.create_key("grave",     keymap, colormap, level, key_height, key_width )
  local key_1          = kbvwr.fn.create_key("1",         keymap, colormap, level, key_height, key_width )
  local key_2          = kbvwr.fn.create_key("2",         keymap, colormap, level, key_height, key_width )
  local key_3          = kbvwr.fn.create_key("3",         keymap, colormap, level, key_height, key_width )
  local key_4          = kbvwr.fn.create_key("4",         keymap, colormap, level, key_height, key_width )
  local key_5          = kbvwr.fn.create_key("5",         keymap, colormap, level, key_height, key_width )
  local key_6          = kbvwr.fn.create_key("6",         keymap, colormap, level, key_height, key_width )
  local key_7          = kbvwr.fn.create_key("7",         keymap, colormap, level, key_height, key_width )
  local key_8          = kbvwr.fn.create_key("8",         keymap, colormap, level, key_height, key_width )
  local key_9          = kbvwr.fn.create_key("9",         keymap, colormap, level, key_height, key_width )
  local key_0          = kbvwr.fn.create_key("0",         keymap, colormap, level, key_height, key_width )
  local key_minus      = kbvwr.fn.create_key("-",         keymap, colormap, level, key_height, key_width )
  local key_equal      = kbvwr.fn.create_key("=",         keymap, colormap, level, key_height, key_width )
  local key_BackSpace  = kbvwr.fn.create_key("BackSpace", keymap, colormap, level, key_height, BackSpace_width )

  local key_Tab        = kbvwr.fn.create_key("Tab",       keymap, colormap, level, key_height, Tab_width)
  local key_q          = kbvwr.fn.create_key("q",         keymap, colormap, level, key_height, key_width)
  local key_w          = kbvwr.fn.create_key("w",         keymap, colormap, level, key_height, key_width)
  local key_e          = kbvwr.fn.create_key("e",         keymap, colormap, level, key_height, key_width)
  local key_r          = kbvwr.fn.create_key("r",         keymap, colormap, level, key_height, key_width)
  local key_t          = kbvwr.fn.create_key("t",         keymap, colormap, level, key_height, key_width)
  local key_y          = kbvwr.fn.create_key("y",         keymap, colormap, level, key_height, key_width)
  local key_u          = kbvwr.fn.create_key("u",         keymap, colormap, level, key_height, key_width)
  local key_i          = kbvwr.fn.create_key("i",         keymap, colormap, level, key_height, key_width)
  local key_o          = kbvwr.fn.create_key("o",         keymap, colormap, level, key_height, key_width)
  local key_p          = kbvwr.fn.create_key("p",         keymap, colormap, level, key_height, key_width)
  local key_bracket_o  = kbvwr.fn.create_key("[",         keymap, colormap, level, key_height, key_width)
  local key_bracket_c  = kbvwr.fn.create_key("]",         keymap, colormap, level, key_height, key_width)
  local key_Return1    = kbvwr.fn.create_key("Return",    keymap, colormap, level, key_height, Return1_width)

  local key_Caps_Lock  = kbvwr.fn.create_key("Caps_Lock", keymap, colormap, level, key_height, Caps_Lock_width)
  local key_a          = kbvwr.fn.create_key("a",         keymap, colormap, level, key_height, key_width)
  local key_s          = kbvwr.fn.create_key("s",         keymap, colormap, level, key_height, key_width)
  local key_d          = kbvwr.fn.create_key("d",         keymap, colormap, level, key_height, key_width)
  local key_f          = kbvwr.fn.create_key("f",         keymap, colormap, level, key_height, key_width)
  local key_g          = kbvwr.fn.create_key("g",         keymap, colormap, level, key_height, key_width)
  local key_h          = kbvwr.fn.create_key("h",         keymap, colormap, level, key_height, key_width)
  local key_j          = kbvwr.fn.create_key("j",         keymap, colormap, level, key_height, key_width)
  local key_k          = kbvwr.fn.create_key("k",         keymap, colormap, level, key_height, key_width)
  local key_l          = kbvwr.fn.create_key("l",         keymap, colormap, level, key_height, key_width)
  local key_semicolon  = kbvwr.fn.create_key(";",         keymap, colormap, level, key_height, key_width)
  local key_apostrophe = kbvwr.fn.create_key("'",         keymap, colormap, level, key_height, key_width)
  local key_backslash  = kbvwr.fn.create_key("\\",        keymap, colormap, level, key_height, key_width)
  local key_Return2    = kbvwr.fn.create_key("Return",    keymap, colormap, level, key_height, Return2_width)

  local key_Shift_L    = kbvwr.fn.create_key("Shift_L",   keymap, colormap, level, key_height, Shift_L_width)
  local key_less       = kbvwr.fn.create_key("<",         keymap, colormap, level, key_height, key_width)
  local key_z          = kbvwr.fn.create_key("z",         keymap, colormap, level, key_height, key_width)
  local key_x          = kbvwr.fn.create_key("x",         keymap, colormap, level, key_height, key_width)
  local key_c          = kbvwr.fn.create_key("c",         keymap, colormap, level, key_height, key_width)
  local key_v          = kbvwr.fn.create_key("v",         keymap, colormap, level, key_height, key_width)
  local key_b          = kbvwr.fn.create_key("b",         keymap, colormap, level, key_height, key_width)
  local key_n          = kbvwr.fn.create_key("n",         keymap, colormap, level, key_height, key_width)
  local key_m          = kbvwr.fn.create_key("m",         keymap, colormap, level, key_height, key_width)
  local key_comma      = kbvwr.fn.create_key(",",         keymap, colormap, level, key_height, key_width)
  local key_dot        = kbvwr.fn.create_key(".",         keymap, colormap, level, key_height, key_width)
  local key_slash      = kbvwr.fn.create_key("/",         keymap, colormap, level, key_height, key_width)
  local key_Shift_R    = kbvwr.fn.create_key("Shift_R",   keymap, colormap, level, key_height, Shift_R_width)

  local key_Fn         = kbvwr.fn.create_key("Fn",        keymap, colormap, level, key_height, Fn_width)
  local key_Control_L  = kbvwr.fn.create_key("Control_L", keymap, colormap, level, key_height, Control_L_width)
  local key_Super_L    = kbvwr.fn.create_key("Super_L",   keymap, colormap, level, key_height, Super_L_width)
  local key_Alt_L      = kbvwr.fn.create_key("Alt_L",     keymap, colormap, level, key_height, Alt_L_width)
  local key_space      = kbvwr.fn.create_key("space",     keymap, colormap, level, key_height, space_width)
  local key_Alt_R      = kbvwr.fn.create_key("Alt_R",     keymap, colormap, level, key_height, Alt_R_width)
  local key_Print      = kbvwr.fn.create_key("Print",     keymap, colormap, level, key_height, Print_width)
  local key_Control_R  = kbvwr.fn.create_key("Control_R", keymap, colormap, level, key_height, Control_R_width)
  local key_Prior      = kbvwr.fn.create_key("Prior",     keymap, colormap, level, key_height, Arrows_width)
  local key_Up         = kbvwr.fn.create_key("Up",        keymap, colormap, level, key_height, Arrows_width)
  local key_Next       = kbvwr.fn.create_key("Next",      keymap, colormap, level, key_height, Arrows_width)

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




return kbvwr.fn
