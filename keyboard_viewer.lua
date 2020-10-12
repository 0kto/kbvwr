local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
-- local naughty = require("naughty")

-- Appearance
local box_radius = beautiful.keyboard_viewer_box_border_radius or dpi(12)
local box_gap = dpi(6)

-- Create the widget
keyboard_viewer = wibox({visible = false, ontop = true, type = "dock", screen = screen.primary})
awful.placement.maximize(keyboard_viewer)

keyboard_viewer.bg = beautiful.keyboard_viewer_bg or beautiful.exit_screen_bg or beautiful.wibar_bg or "#111111"
keyboard_viewer.fg = beautiful.keyboard_viewer_fg or beautiful.exit_screen_fg or beautiful.wibar_fg or "#FEFEFE"

-- Add keyboard_viewer or mask to each screen
for s in screen do
    if s == screen.primary then
        s.keyboard_viewer = keyboard_viewer
    else
        s.keyboard_viewer = helpers.screen_mask(s, keyboard_viewer.bg)
    end
end

local function set_visibility(v)
    for s in screen do
        s.keyboard_viewer.visible = v
    end
end

keyboard_viewer:buttons(gears.table.join(
    -- Middle click - Hide keyboard_viewer
    awful.button({ }, 2, function ()
        keyboard_viewer_hide()
    end)
))

-- Helper function that puts a widget inside a box with a specified background color
-- Invisible margins are added so that the boxes created with this function are evenly separated
-- The widget_to_be_boxed is vertically and horizontally centered inside the box
local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(box_radius)
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
        margins = box_gap,
        color = "#FF000000",
        widget = wibox.container.margin
    }

    return boxed_widget
end

local kbvwr = {}
-- Definition of keybindings
kbvwr.bind = require("kbvwr.keybindings")


-- Keyboard viewer
kbvwr.keyboard_layout = {}
kbvwr.keyboard_layout = require("kbvwr.keyboard_layout")
-- generate all layouts, and select from named table
kbvwr.layouts = {}
for ii = 1,12 do
    kbvwr.layouts[ii] = create_boxed_widget(
        kbvwr.keyboard_layout.create(
            kbvwr.bind.keymap,
            kbvwr.bind.colormap,
            ii), 
        dpi(1211),
        dpi(491),
        x.background
        )
end
-- define list of available modifiers and set them passive
kbvwr.modifier_list = {
    ['Alt_L']     = true,
    ['Alt_R']     = true,
    ['Caps_Lock'] = true,
    ['Control_L'] = true,
    ['Control_R'] = true,
    ['shift']     = true,
    ['Super_L']   = true,
}
kbvwr.modifiers_active = {}
for key,val in pairs(kbvwr.modifier_list) do
    kbvwr.modifiers_active[key] = false
end
kbvwr.modifier_list['Shift_L'] = true -- these are not actually used, but are needed 
kbvwr.modifier_list['Shift_R'] = true -- to detect shift


-- function to determine level from dict of active modifiers
function kbvwr.level_from_modifiers(dict_avtive_modifiers)
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

    kbvwr.level = 1
    if     lvl == 1 then -- Alt_L
        kbvwr.level = 12
    elseif lvl == 2 then -- Alt_R
        kbvwr.level = 4
    elseif lvl == 4 then -- Caps_Lock
        kbvwr.level = 2
    elseif lvl == 8 then -- Control_L
        kbvwr.level = 3
    elseif lvl == 16 then -- Control_R
        kbvwr.level = 11
    elseif lvl == 32 then -- shift
        kbvwr.level = 2
    elseif lvl == 64 then -- Super_L
        kbvwr.level = 6
    elseif lvl == 2 + 32 then -- Alt_R + shift
        kbvwr.level = 5
    elseif lvl == 64 + 32 then -- Super_L + shift
        kbvwr.level = 7
    elseif lvl == 64 + 1 then -- Super_L + Alt_L
        kbvwr.level = 8
    elseif lvl == 64 + 8 then -- Super_L + Control_L
        kbvwr.level = 9
    elseif lvl == 64 + 8 + 1 then -- Super_L + Control_L + Alt_L
        kbvwr.level = 10
    end
    -- naughty.notify({text = "level is " .. kbvwr.level .. "\n lvl is " .. lvl})
    return kbvwr.level
end

local kbvwr_widget = create_boxed_widget(
        kbvwr.keyboard_layout.create(
            kbvwr.keyboard_layout.keymap,
            kbvwr.keyboard_layout.colormap,
            1), 
        dpi(1211),
        dpi(491),
        x.background
        )
kbvwr.update_widget = function()
    kbvwr_widget.widget = kbvwr.layouts[kbvwr.level]
end

local kbvwr_description = wibox.widget {
    widget = wibox.widget.textbox,
    text = "Loading your cookie...",
    font = "Sans Bold 12",
    align = "center",
    valign = "center",
}

local kbvwr_description_widget = wibox.widget {
    {
        nil,
        kbvwr_description,
        layout = wibox.layout.align.horizontal,
    },
    widget = wibox.widget {
        bg = x.background,
        forced_height = dpi(65),
        forced_width  = dpi(1221),
        shape = helpers.rrect(dpi(4)),
        widget = wibox.container.background()
        }
}

-- Item placement
keyboard_viewer:setup {
    -- Center boxes vertically
    nil,
    {
        -- Center boxes horizontally
        nil,
        {   
            nil,
            {
                -- kbvwr_keycombos,
                kbvwr_widget,
                layout = wibox.layout.fixed.horizontal
            },
            kbvwr_description_widget,
            layout = wibox.layout.align.vertical
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal

    },
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
}
-- keyboard_viewer show and hide functions, keygrabber
local keyboard_viewer_grabber

function keyboard_viewer_hide()
    awful.keygrabber.stop(keyboard_viewer_grabber)
    set_visibility(false)
end

local original_cursor = "left_ptr"
function keyboard_viewer_show()
    -- Fix cursor sometimes turning into "hand1" right after showing the keyboard_viewer
    -- Sigh... This fix does not always work
    local w = mouse.current_wibox
    if w then
        w.cursor = original_cursor
    end
    -- naughty.notify({text = "starting the keygrabber"})
    keyboard_viewer_grabber = awful.keygrabber.run(function(_, key, event)
        -- if event == "release" then return end
        -- Press Escape or q or F1 to hide it
        if event == "press" and (key == 'Escape' or key == 'q' or key == 'F5') then
            keyboard_viewer_hide()
        -- only look at keys that are in the kbvwr.modifier_list and have 
        -- the value 'true'.
        elseif kbvwr.modifier_list[key] then
            if key == "Shift_L" or key == "Shift_R" then
                -- do not distinguish btw left/right shift key
                key = "shift"
            end
            if event == "press" then
                kbvwr.modifiers_active[key] = true
            elseif event == "release" then
                kbvwr.modifiers_active[key] = false
            end
            kbvwr.level = kbvwr.level_from_modifiers(kbvwr.modifiers_active)
            kbvwr.update_widget()
        end
    end)
    set_visibility(true)
end
return kbvwr