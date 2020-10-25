-- awesomeWM lua packages =============================================
local gears = require("gears")
-- local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
-- elenepan stuff =====================================================
local apps    = require("apps")
-- local helpers = require("helpers")
-- needed kbvwr stuff =================================================
local kbvwr   = {}
kbvwr.config  = require("kbvwr.config")
kbvwr.keys    = require("kbvwr.keys")
kbvwr.fn      = {}
kbvwr.fn.keys = require("kbvwr.fn.keys")
-- package bind =======================================================
kbvwr.bind                   = {}
kbvwr.bind.octal             = kbvwr.fn.keys.genOctalList(kbvwr.keys)
kbvwr.bind.globalkeybindings = {}
kbvwr.bind.clientkeybindings = {}


-- shorthand
local none = {}
local global = true
local client = false
local function               bindkey(modifiers, key, symbol, group, description, isGlobalkey, fn)
    return kbvwr.fn.keys.bind(kbvwr, modifiers, key, symbol, group, description, isGlobalkey, fn)
end
-- Symbols for modifiers
--[[
         : Caps_Lock         : Shift
         : Control_L         : Control_R
         : Super_L        none: no modifier
         : Alt_L             : Alt_R
--]]
-- globalkeybindings ==================================================
bindkey( none, 'XF86AudioMute',         " icon:ﱝ ", "media", "mute sound",      global, function () helpers.volume_control(0) end)
bindkey( none, 'XF86AudioLowerVolume',  " icon:ﱜ ", "media", "decrease volume", global, function () helpers.volume_control(-5) end)
bindkey( none, 'XF86AudioRaiseVolume',  " icon:ﱛ ", "media", "increase volume", global, function () helpers.volume_control(5) end)
bindkey( none, 'XF86AudioMicMute',      " icon: ", "media", "mute microphone", global,
        function() awful.spawn.with_shell("amixer -D pulse sset Capture toggle &> /dev/null") end)
bindkey( none, 'XF86MonBrightnessDown', " icon: ", "launcher", "decrease laptop brightness", global, function () awful.spawn.with_shell("light -U 10") end)
bindkey( none, 'XF86MonBrightnessUp',   " icon: ", "launcher", "increase laptop brightness", global, function () awful.spawn.with_shell("light -A 10") end)
bindkey( none, 'XF86Display',           " icon: ", "tools", "configure display layout", global, function () awful.spawn("arandr") end)
bindkey( none, 'XF86Search',            " icon:ﰍ ", "launcher", "activate sidebar web search prompt", global, 
        function() if sidebar_activate_prompt then sidebar_activate_prompt("web_search") end end)
bindkey( none, 'XF86Tools',             " icon: ", "awesome", "show keyboard bindings", global, function() keyboard_viewer_show() end)
bindkey( none, 'XF86LaunchA',           "tray",    "awesome", "toggle tray visibility", global, function() tray_toggle() end)
bindkey( none, 'XF86Explorer',          " icon:﵁ ", "awesome",  "toggle dashboard visibility", global, 
function() if dashboard_show then dashboard_show() end end)

bindkey( { " " },       'Escape',  "quit",      "awesome", "show shutdown menu", global, function() exit_screen_show() end)
bindkey( { " " },       'grave',   "sidebar",   "awesome", "toggle sidebar visibility", global, function() sidebar_toggle() end)
bindkey( { " ", " " }, 'r',       "restart",   "awesome", "restart awesomeWM", global, function() awesome.restart() end)
bindkey( { " ", " " }, '-',       "gap -",     "layout", "decrease gap", global, function() awful.tag.incgap(5, nil) end)
bindkey( { " ", " " }, '=',       "gap +",     "layout", "increase gap", global, function() awful.tag.incgap(-5, nil) end)
bindkey( { " ", " " }, 'Delete',  "#!-top",   "tools",  "show bashtop", global, function() apps.process_monitor() end)
-- TODO:
-- Return is made up by two keys, which must be mapped seperately
bindkey( { " " },             'Return1', " icon: ",   "apps",   "spawn terminal", global, function() awful.spawn(user.terminal) end)
bindkey( { " " },             'Return2', " icon: ",   "apps",   "spawn terminal", global, function() awful.spawn(user.terminal) end)
bindkey( { " ", " " },       'Return1', " icon: icon: ", "apps",   "spawn floating terminal", global, function() awful.spawn(user.floating_terminal, {floating = true}) end)
bindkey( { " ", " " },       'Return2', " icon: icon: ", "apps",   "spawn floating terminal", global, function() awful.spawn(user.floating_terminal, {floating = true}) end)
bindkey( { " ", " " },       'Return1', "wibar",     "launch", "toggle wibar visibility", global, function() wibars_toggle() end)
bindkey( { " ", " " },       'Return2', "wibar",     "launch", "toggle wibar visibility", global, function() wibars_toggle() end)
bindkey( { " " },             'Tab',     " icon: ",   "client", "window switcher", global, function() window_switcher_show(awful.screen.focused()) end)
bindkey( { " " },             'e',       " icon: icon: ",  "apps",   "open ranger", global, function() apps.file_manager() end)
bindkey( { " ", " " },       'e',       " icon: ",   "apps",   "open pcmanfm", global, function() awful.spawn("pcmanfm") end)
bindkey( { " " },             'r',       "run",       "launch", "activate sidebar run prompt", global,
        function ()
            if sidebar_activate_prompt then sidebar_activate_prompt("run") end
        end)
bindkey( { " " },             'u',       " icon: icon: ", "client", "switch to urgent client", global,
        function ()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then awful.tag.history.restore() else awful.client.urgent.jumpto() end
        end)
bindkey( { " " },             'p',       " icon: ",    "tools",  "pass via dmenu", global, function () awful.spawn("passdmenu") end)
bindkey( { " " },             'd',       "rofi",      "launcher","rofi launcher", global,
        function()
            awful.spawn.with_shell("rofi -matching fuzzy -show combi")
        end)
-- --     -- hkl keys
bindkey( { " " },             'h',       " icon: \r icon: ", "client", "focus left", global, function() awful.client.focus.bydirection("left") end)
bindkey( { " " },             'j',       " icon: \r icon: ", "client", "focus down", global, function() awful.client.focus.bydirection("down") end)
bindkey( { " " },             'k',       " icon:  icon: ",   "client", "focus up", global, function() awful.client.focus.bydirection("up") end)
bindkey( { " " },             'l',       " icon: icon: ",    "client", "focus right", global, function() awful.client.focus.bydirection("right") end)
bindkey( { " ", " " },       'h',       " icon:ﰂ ",           "layout", "increase number of clients", global, function() awful.tag.incnmaster(1, nil, true) end)
bindkey( { " ", " " },       'j',       " icon:吝 ",           "layout", "lower number of columns", global, function() awful.tag.incncol(-1, nil, true) end)
bindkey( { " ", " " },       'k',       " icon:溺 ",           "layout", "increase number of columns", global, function() awful.tag.incncol(1, nil, true) end)
bindkey( { " ", " " },       'l',       " icon:ﯰ ",           "layout", "lower number of clients", global, function() awful.tag.incnmaster(-1, nil, true)  end)
bindkey( { " ", " ", " " }, 'h',       " icon: \r icon: ", "layout", "move border left", global, function() helpers.resize_dwim(client.focus, "left") end)
bindkey( { " ", " ", " " }, 'j',       " icon: \r icon: ", "layout", "move border down", global, function() helpers.resize_dwim(client.focus, "down") end)
bindkey( { " ", " ", " " }, 'k',       " icon:  icon: ",   "layout", "move border up", global, function() helpers.resize_dwim(client.focus, "up") end)
bindkey( { " ", " ", " " }, 'l',       " icon:  icon: ",   "layout", "move border left", global, function() awful.client.focus.bydirection("right") end)

bindkey( { " ", " " },       'n',       "restore min", "layout",  "restore minimized client",   global,
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then client.focus = c end
        end)
bindkey( { " ", " " },       'space',   "layout -",    "layout", "switch to previous layout", global, function () awful.layout.inc(-1) end)
bindkey( { " " },             'space',   "layout +",    "layout", "switch to next layout", global, function () awful.layout.inc( 1) end)
bindkey( { " ", " " },       'space',   "clear",       "awesome", "clear all notifications",    global,
        function() 
            awesome.emit_signal("elemental::dismiss")
            naughty.destroy_all_notifications()
        end)
--     -- Print
bindkey( { },                  'Print',   " icon: ",     "tools", "screenshot: full screen", global, function() apps.screenshot("full")  end)
bindkey( { " ", " "},        'Print',   "browse",      "tools", "browse screenshots", global, function() apps.screenshot("browse") end)
bindkey( { " ", " "},        'Print',   " icon: ",     "tools", "screenshot: save area", global, function() apps.screenshot("selection") end)
bindkey( { " ", " "},        'Print',   " icon: ",     "tools", "screenshot: clip area", global, function() apps.screenshot("clipboard") end)
--   bindkey( { " ", " ", " "}, "Print", "edit",      "tools", "screenshot: edit", global, function() apps.screenshot("gimp") end)

--     -- direction keys
bindkey( { " " },             'Up',      " icon: \r icon: ", "client", "focus up", global, function() awful.client.focus.bydirection("up") end)
bindkey( { " " },             'Down',    " icon: \r icon: ", "client", "focus down", global, function() awful.client.focus.bydirection("down") end)
bindkey( { " " },             'Left',    " icon:  icon: ",   "client", "focus left", global, function() awful.client.focus.bydirection("left") end)
bindkey( { " " },             'Right',   " icon: icon: ",    "client", "focus right", global, function() awful.client.focus.bydirection("right") end)
bindkey( { " ", " " },       'Up',      " icon:ﰂ ",           "layout", "increase number of clients", global, function() awful.tag.incnmaster(1, nil, true) end)
bindkey( { " ", " " },       'Down',    " icon:吝 ",           "layout", "lower number of columns", global, function() awful.tag.incncol(-1, nil, true) end)
bindkey( { " ", " " },       'Left',    " icon:溺 ",           "layout", "increase number of columns", global, function() awful.tag.incncol(1, nil, true) end)
bindkey( { " ", " " },       'Right',   " icon:ﯰ ",           "layout", "lower number of clients", global, function() awful.tag.incnmaster(-1, nil, true)  end)
bindkey( { " ", " ", " " }, 'Up',      " icon: \r icon: ", "layout", "move border left", global, function() helpers.resize_dwim(client.focus, "left") end)
bindkey( { " ", " ", " " }, 'Down',    " icon: \r icon: ", "layout", "move border down", global, function() helpers.resize_dwim(client.focus, "down") end)
bindkey( { " ", " ", " " }, 'Left',    " icon:  icon: ",   "layout", "move border up", global, function() helpers.resize_dwim(client.focus, "up") end)
bindkey( { " ", " ", " " }, 'Right',   " icon:  icon: ",   "layout", "move border left", global, function() helpers.resize_dwim(client.focus, "right") end)

-- clientkeybindings ==================================================
bindkey( { " " },             't',       "top",         "client", "toggle keep on top", client, function (c) c.ontop = not c.ontop end)
bindkey( { " " },             'o',       "mv:scrn",     "client", "move client to screen", client, function (c) c:move_to_screen() end)
bindkey( { " ", " " },       '[',       "opacity -",   "client", "decrease client opacity", client,
        function (c)
            c.opacity = c.opacity - 0.05
        end)
bindkey( { " ", " " },       ']',       "opacity +",   "client", "increase client opacity", client,
        function (c)
            c.opacity = c.opacity + 0.05
        end)
bindkey( { " " },             'p',       "sticky",      "client", "toggle sticky", client, function (c) c.sticky = not c.sticky end)
bindkey( { " ", " " },       'Return1', "mk master",   "client", "promote client to master", client, function (c) c:swap(awful.client.getmaster()) end)
bindkey( { " ", " " },       'Return2', "mk master",   "client", "promote client to master", client, function (c) c:swap(awful.client.getmaster()) end)
bindkey( { " " },             'f',       "float",       "client", "toggle floating", client, function () awful.client.floating.toggle() end)
bindkey( { " ", " "},        'c',       "close",       "client", "close client", client, function (c) c:kill() end)
bindkey( { " " },             'f',       "max",         "client", "maximize client", client,
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end )
bindkey( { " " },             'n',       "min",         "client", "minimize client", client,
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end )

return kbvwr.bind