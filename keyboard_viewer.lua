local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local helpers   = require("helpers")
local naughty   = require("naughty")


local kbvwr = {}
kbvwr.bind   = require("kbvwr.bind")
kbvwr.config = require("kbvwr.config")
kbvwr.fn     = require("kbvwr.fn")
kbvwr.layout = require("kbvwr.layout")
kbvwr.widget = {}

-- Create and configure the widget
-- ====================================================================
keyboard_viewer = wibox({visible = false, ontop = true, type = "dock", screen = screen.primary})
keyboard_viewer.bg = kbvwr.config.bg
keyboard_viewer.fg = kbvwr.config.fg
awful.placement.maximize(keyboard_viewer)

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

-- Preparation
-- ============================================================================
-- generate all layouts, and select from named table
kbvwr.layouts = {}
for ii = 1,15 do
-- for ii = 1,#kbvwr.config.level do
    kbvwr.layouts[ii] = kbvwr.fn.create_layout(
            kbvwr.bind.keymap,
            kbvwr.bind.colormap,
            ii)
end
-- init modifier_active list and add hack in oder to recognize 'Shift'
-- w/o distinguishing btw. L and R.
kbvwr.modifiers_active = {}
for key,val in pairs(kbvwr.config.modifier_list) do
    if key == 'Shift_L' or key == 'Shift_R' then
        -- nil
    else
        kbvwr.modifiers_active[key] = false
    end
end
-- wibox creation
-- ============================================================================
-- create the initial widget
kbvwr.widget.kblayout = kbvwr.fn.create_layout(
        kbvwr.bind.keymap,
        kbvwr.bind.colormap,
        1)

function kbvwr.fn.update_layout(level)
    kbvwr.widget.kblayout = kbvwr.layouts[level]
end

kbvwr.widget.description = wibox.widget {
    widget = wibox.widget.textbox,
    text = "",
    font = "Sans Bold 12",
    align = "center",
    valign = "center",
}


function kbvwr.fn.update_description(text)
    kbvwr.widget.description.markup = text
end

-- Item placement
keyboard_viewer:setup {
    -- Center boxes vertically
    id     = "outer_v",
    expand = "none",
    layout = wibox.layout.align.vertical,
    nil,
    {
        -- Center boxes horizontally
        id     = "outer_h",
        expand = "none",
        layout = wibox.layout.align.horizontal,
        nil,
        {   
            -- Placement of elements
            id      = "elements",
            layout  = wibox.layout.fixed.vertical,
            spacing = dpi(20),
            {
                -- background kblayout
                widget = wibox.container.background(),
                bg = kbvwr.config.bg,
                shape = helpers.rrect(dpi(4)),
                {
                    layout = wibox.layout.align.vertical,
                    expand = "none",
                    kbvwr.widget.kblayout,
                },
            },
            {   
                id     = "description_box",
                widget = wibox.widget {
                    bg = kbvwr.config.bg,
                    forced_height = dpi(65),
                    shape = helpers.rrect(dpi(4)),
                    widget = wibox.container.background()
                },
                {
                    id = "description",
                    widget = wibox.widget.textbox("test", true),
                    align = "center",
                    valign = "center",
                },
            },
        },
        nil,

    },
    nil,
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
    keyboard_viewer_hide_grabber = awful.keygrabber.run(function(_, key, event)
        -- if event == "release" then return end
        -- Press Escape or q or F1 to hide it
        if event == "press" and (key == 'Escape' or key == 'q' or key == 'F5') then
            keyboard_viewer_hide()
        -- only look at keys that are in the kbvwr.config.modifier_list and have 
        -- the value 'true'.
        elseif kbvwr.config.modifier_list[key] then
            -- the only case the level can change
            if key == 'Shift_L' or key == 'Shift_R' then
                -- do not distinguish btw left/right shift key
                key = 'shift'
            end
            if event == "press" then
                kbvwr.modifiers_active[key] = true
            elseif event == "release" then
                kbvwr.modifiers_active[key] = false
            end

            local lvl = 0
            for key,val in pairs(kbvwr.modifiers_active) do
                -- for all active modifiers, add the according lvl value
                if val then
                    lvl = lvl + kbvwr.config.lvl[key]
                end
            end
            -- return the level using a lookup table for known levels
            kbvwr.level = kbvwr.config.level[lvl]
            -- trigger layer update
            kbvwr.fn.update_layout(kbvwr.level)
        else
            if event == "press" then
                local children = keyboard_viewer:get_all_children()[1]
                -- naughty.notify({text = children[1]})
                -- -- change description
                -- if kbvwr.bind.keydesc[key] ~= nil then
                --     kbvwr.fn.update_description(
                --         kbvwr.bind.keydesc[key][kbvwr.level] or ""
                --         )
                -- else
                --     kbvwr.fn.update_description("")
                -- end
                -- change key color
                -- kbvwr.fn.key_color_change(kbvwr, key)
            elseif event == "release" then
                -- revert description
                -- kbvwr.fn.update_description("")
                -- revert key color
                -- kbvwr.fn.key_color_reset(kbvwr, key)
            end

        end
    end)
    set_visibility(true)
end
return kbvwr