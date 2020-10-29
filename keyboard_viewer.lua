-- awesomeWM lua packages =============================================
local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
-- elenapan-awesome (to be eliminated) ================================
local helpers = require("helpers")
-- needed kbvwr stuff =================================================
local kbvwr       = {}
kbvwr.config      = require("kbvwr.config")
kbvwr.fn          = require("kbvwr.fn")
kbvwr.fn.keys     = require("kbvwr.fn.keys")
kbvwr.keys        = require("kbvwr.keys")
kbvwr.bind        = require("kbvwr.bind")
-- kbvwr variables ====================================================
kbvwr.description      = "" -- description welcome text
kbvwr.lvl              = 0
kbvwr.active_modifiers = {}
for key,val in pairs(kbvwr.bind.octal) do
    kbvwr.active_modifiers[key] = false
end
for key,values in pairs(kbvwr.keys) do
    if values.isModifier then
        lvl = kbvwr.fn.keys.lvl_array({ key }, kbvwr.bind.octal)
        values.description[lvl] = values.description[1]
        values.description[1]   = nil
    end
end

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
-- Item placement
keyboard_viewer:setup {
    -- Center boxes vertically
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {
        -- Center boxes horizontally
        layout = wibox.layout.align.horizontal,
        expand = "none",
        nil,
        {   
            -- Placement of elements
            layout  = wibox.layout.fixed.vertical,
            spacing = dpi(20),
            {
                -- background keyboard
                widget = wibox.container.background(),
                bg = kbvwr.config.bg,
                shape = helpers.rrect(dpi(4)),
                {
                    -- keyboard
                    layout = wibox.layout.fixed.vertical,
                    spacing = kbvwr.config.box_gap,
                    {
                        -- row 1
                        layout = wibox.layout.fixed.horizontal,
                        spacing = kbvwr.config.keys.gap["default"],
                        {
                            -- Fx keys are grouped
                            layout = wibox.layout.fixed.horizontal,
                            spacing = kbvwr.config.keys.gap["Fx"],
                            kbvwr.keys["Escape"].w,
                            kbvwr.keys["F1"].w, kbvwr.keys["F2"].w, kbvwr.keys["F3"].w, kbvwr.keys["F4"].w
                        },
                        {
                            -- Fx keys are grouped
                            layout = wibox.layout.fixed.horizontal,
                            spacing = kbvwr.config.keys.gap["Fx"],
                            kbvwr.keys["F5"].w, kbvwr.keys["F6"].w, kbvwr.keys["F7"].w, kbvwr.keys["F8"].w
                        },
                        {
                            -- Fx keys are grouped
                            layout = wibox.layout.fixed.horizontal,
                            spacing = kbvwr.config.keys.gap["Fx"],
                            kbvwr.keys["F9"].w, kbvwr.keys["F10"].w, kbvwr.keys["F11"].w, kbvwr.keys["F12"].w
                        },
                        {
                            -- Fx keys are grouped
                            layout = wibox.layout.fixed.horizontal,
                            spacing = kbvwr.config.keys.gap["Fx"],
                            kbvwr.keys["Home"].w, kbvwr.keys["End"].w, kbvwr.keys["Insert"].w, kbvwr.keys["Delete"].w,
                        },
                    },
                    {
                    -- row 2
                      layout  = wibox.layout.fixed.horizontal,
                      spacing = kbvwr.config.keys.gap["default"],
                      kbvwr.keys["`"].w, kbvwr.keys["1"].w, kbvwr.keys["2"].w, kbvwr.keys["3"].w, kbvwr.keys["4"].w, kbvwr.keys["5"].w, kbvwr.keys["6"].w, kbvwr.keys["7"].w, kbvwr.keys["8"].w, kbvwr.keys["9"].w,
                      kbvwr.keys["0"].w, kbvwr.keys["-"].w, kbvwr.keys["="].w, kbvwr.keys["BackSpace"].w, 
                   },
                    {
                    -- row 3
                      layout  = wibox.layout.fixed.horizontal,
                      spacing = kbvwr.config.keys.gap["default"],
                      kbvwr.keys["Tab"].w, kbvwr.keys["q"].w, kbvwr.keys["w"].w, kbvwr.keys["e"].w, kbvwr.keys["r"].w, kbvwr.keys["t"].w, kbvwr.keys["y"].w, kbvwr.keys["u"].w, kbvwr.keys["i"].w, kbvwr.keys["o"].w,
                      kbvwr.keys["p"].w, kbvwr.keys["["].w, kbvwr.keys["]"].w, 
                      -- kbvwr.keys["Return1"].w, 
                    },
                    {
                    -- row 4
                      layout  = wibox.layout.fixed.horizontal,
                      spacing = kbvwr.config.keys.gap["default"],
                      kbvwr.keys["Caps_Lock"].w, kbvwr.keys["a"].w, kbvwr.keys["s"].w, kbvwr.keys["d"].w, kbvwr.keys["f"].w, kbvwr.keys["g"].w, kbvwr.keys["h"].w, kbvwr.keys["j"].w, kbvwr.keys["k"].w,
                      kbvwr.keys["l"].w, kbvwr.keys[";"].w, kbvwr.keys["\""].w, kbvwr.keys["\\"].w, kbvwr.keys["Return"].w, 
                    },
                    {
                    -- row 5
                      layout  = wibox.layout.fixed.horizontal,
                      spacing = kbvwr.config.keys.gap["default"],
                      kbvwr.keys["Shift_L"].w, kbvwr.keys["<"].w, kbvwr.keys["z"].w, kbvwr.keys["x"].w, kbvwr.keys["c"].w, kbvwr.keys["v"].w, kbvwr.keys["b"].w, kbvwr.keys["n"].w, kbvwr.keys["m"].w,
                      kbvwr.keys[","].w, kbvwr.keys["."].w, kbvwr.keys["/"].w, kbvwr.keys["Shift_R"].w, 
                    },
                    {
                    -- row 6
                      layout  = wibox.layout.fixed.horizontal,
                      spacing = kbvwr.config.keys.gap["default"],
                      kbvwr.keys["Fn"].w, kbvwr.keys["Control_L"].w, kbvwr.keys["Super_L"].w, kbvwr.keys["Alt_L"].w, kbvwr.keys["space"].w, kbvwr.keys["Alt_R"].w,
                      kbvwr.keys["Print"].w, kbvwr.keys["Control_R"].w, kbvwr.keys["Prior"].w, kbvwr.keys["Up"].w, kbvwr.keys["Next"].w, 
                    },
                },
            },
            {   
                widget = wibox.widget {
                    bg = kbvwr.config.bg,
                    forced_height = dpi(65),
                    shape = helpers.rrect(dpi(4)),
                    widget = wibox.container.background()
                },
                {
                    id = "description_textbox",
                    widget = wibox.widget.textbox(),
                    text = kbvwr.description,
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

function keyboard_viewer_show()
    keyboard_viewer_hide_grabber = awful.keygrabber.run(
        function(mod, key, event)
            --[[ currently missing: TODO
            * Scrol(l)_Lock
            * XF86WLAN
            --]]
            -- take care of possible Aliases (capitalized letters)
            key = kbvwr.config.keys.aliases[key] or key
            if kbvwr.keys[key] == nil then
                naughty.notify({title = "kbvwr: missing key!", text = "\""..key.."\" is not defined!"})
            end
            if event == "press" and (key == "XF86Tools" or key == "q") then
                keyboard_viewer_hide()
            elseif kbvwr.keys[key].isModifier == true then
                if event == "press" then
                    -- change key color
                    kbvwr.keys[key].w.bg = kbvwr.config.active_key_bg
                    kbvwr.keys[key].w.fg = kbvwr.config.active_key_fg
                    -- set modifier active
                    kbvwr.active_modifiers[key] = true
                    -- calculate current lvl
                    kbvwr.lvl = kbvwr.fn.keys.lvl_dict(kbvwr.active_modifiers, kbvwr.bind.octal)
                    -- update description
                    keyboard_viewer:get_children_by_id("description_textbox")[1].markup = kbvwr.keys[key].description[kbvwr.lvl] or ""
                    -- update symbol and key color for all normal keys
                    for key,val in pairs(kbvwr.keys) do
                        if val.isModifier == false then
                            kbvwr.keys[key].w.text.markup = kbvwr.fn.formatIcon(kbvwr.keys[key].symbol[kbvwr.lvl]) or ""
                            kbvwr.keys[key].w.bg = kbvwr.config.groupcolors[val.group[kbvwr.lvl]] or kbvwr.config.default_key_bg
                        end
                    end
                elseif event == "release" then
                    -- change key color
                    kbvwr.keys[key].w.bg = kbvwr.config.modifier_key_bg
                    kbvwr.keys[key].w.fg = kbvwr.config.modifier_key_fg
                    -- set modifier in-active
                    kbvwr.active_modifiers[key] = false
                    -- calculate current lvl
                    kbvwr.lvl = kbvwr.fn.keys.lvl_dict(kbvwr.active_modifiers, kbvwr.bind.octal)
                    -- update description
                    keyboard_viewer:get_children_by_id("description_textbox")[1].markup = kbvwr.keys[key].description[kbvwr.lvl] or ""
                    -- update symbol and key color for all normal keys
                    for key,val in pairs(kbvwr.keys) do
                        if val.isModifier == false then
                            kbvwr.keys[key].w.text.markup = kbvwr.fn.formatIcon(kbvwr.keys[key].symbol[kbvwr.lvl]) or ""
                            kbvwr.keys[key].w.bg = kbvwr.config.groupcolors[val.group[kbvwr.lvl]] or kbvwr.config.default_key_bg
                        end
                    end
                end
            elseif kbvwr.keys[key].isModifier == false then
                if event == "press" then
                    kbvwr.keys[key].w.bg = kbvwr.config.active_key_bg
                    kbvwr.keys[key].w.fg = kbvwr.config.active_key_fg
                    keyboard_viewer:get_children_by_id("description_textbox")[1].markup = kbvwr.keys[key].description[kbvwr.lvl] or ""
                elseif event == "release" then
                    kbvwr.keys[key].w.bg = kbvwr.config.groupcolors[kbvwr.keys[key].group[kbvwr.lvl]] or kbvwr.config.default_key_bg
                    kbvwr.keys[key].w.fg = kbvwr.config.default_key_fg
                    keyboard_viewer:get_children_by_id("description_textbox")[1].markup = ""
                end
            end

        end
    )
    set_visibility(true)
end
return kbvwr