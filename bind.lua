-- awesomeWM lua packages =============================================
local gears = require("gears")
-- local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
-- elenepan stuff =====================================================
local apps    = require("apps")
local helpers = require("helpers")
-- needed kbvwr stuff =================================================
local kbvwr   = {}
kbvwr.config  = require("kbvwr.config")
kbvwr.keys    = require("kbvwr.keys")
kbvwr.fn      = require("kbvwr.fn")
-- package bind =======================================================
kbvwr.bind                   = {}
kbvwr.bind.octal             = kbvwr.fn.genOctalList(kbvwr.keys)
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
bindkey( none, "XF86AudioMute",         " icon:ﱝ ", "media",  "mute sound",      global, function () helpers.volume_control(0) end)
bindkey( none, "XF86AudioLowerVolume",  " icon:ﱜ ", "media",  "decrease volume", global, function () helpers.volume_control(-5) end)
bindkey( none, "XF86AudioRaiseVolume",  " icon:ﱛ ", "media",  "increase volume", global, function () helpers.volume_control(5) end)
bindkey( none, "XF86AudioMicMute",      " icon: ", "media",  "mute microphone", global,
        function() awful.spawn.with_shell("amixer -D pulse sset Capture toggle &> /dev/null") end)
bindkey( none, "XF86Display",           " icon: ", "tools",  "configure display layout", global, function () awful.spawn("arandr") end)
bindkey( none, "XF86Tools",             " icon: ", "awesome", "show keyboard bindings", global, function() keyboard_viewer_show() end)
bindkey( none, "XF86LaunchA",           "tray",     "awesome", "toggle tray visibility", global, function() tray_toggle() end)
bindkey( none, "XF86Explorer",          " icon:﵁ ", "awesome", "toggle dashboard visibility", global, 
function() if dashboard_show then dashboard_show() end end)
-- TODO:
-- Return is made up by two keys, which must be mapped seperately
-- -- bindkey( { " " },       "Return1",     " icon: ", "apps",    "spawn terminal", global, function() awful.spawn(user.terminal) end)
-- -- bindkey( { " ", " " }, "Return1",    " icon: icon: ",      "apps",   "spawn floating terminal", global, function() awful.spawn(user.floating_terminal, {floating = true}) end)
bindkey( { " " },       "Return",      " icon: ", "apps",    "spawn terminal", global, function() awful.spawn(user.terminal) end)
-- bindkey( { " ", " " }, "Return",      " icon: icon: ",     "apps",   "spawn floating terminal", global, function() awful.spawn(user.floating_terminal, {floating = true}) end)
bindkey( { " " },       "e",           " icon: icon: ", "apps", "open ranger", global, function() apps.file_manager() end)
bindkey( { " ", " " }, "e",           " icon: ", "apps",    "open pcmanfm", global, function() awful.spawn("pcmanfm") end)
-- awesome and layout =================================================
bindkey( { " " },       "Escape",      " icon: ",     "awesome", "show shutdown menu", global, function() exit_screen_show() end)
bindkey( { " " },       "`",           "sidebar",  "awesome", "toggle sidebar visibility", global, function() sidebar_toggle() end)
bindkey( { " ", " " }, "c", "clear",       "awesome", "clear all notifications",    global,
        function() 
            awesome.emit_signal("elemental::dismiss")
            naughty.destroy_all_notifications()
        end)
bindkey( { " ", " " }, "r", " icon:ﰇ ", "awesome", "restart awesomeWM", global, function() awesome.restart() end)
bindkey( { " " },       "<", " icon:ﱖ ", "layout",  "switch to next layout", global, function () awful.layout.inc( 1) end)
bindkey( { " ", " " }, "<", " icon:﩯 ", "layout",  "switch to previous layout", global, function () awful.layout.inc(-1) end)
bindkey( { " ", " " },       "h",       " icon:ﰂ ",      "layout", "increase number of clients", global, function() awful.tag.incnmaster(1, nil, true) end)
bindkey( { " ", " " },       "j",       " icon:吝 ",      "layout", "lower number of columns", global, function() awful.tag.incncol(-1, nil, true) end)
bindkey( { " ", " " },       "k",       " icon:溺 ",      "layout", "increase number of columns", global, function() awful.tag.incncol(1, nil, true) end)
bindkey( { " ", " " },       "l",       " icon:ﯰ ",      "layout", "lower number of clients", global, function() awful.tag.incnmaster(-1, nil, true)  end)
bindkey( { " ", " ", " " }, "h",       "  \r  ", "layout", "move border left", global, function() helpers.resize_dwim(client.focus, "left") end)
bindkey( { " ", " ", " " }, "j",       "  \r  ", "layout", "move border down", global, function() helpers.resize_dwim(client.focus, "down") end)
bindkey( { " ", " ", " " }, "k",       "   ",    "layout", "move border up", global, function() helpers.resize_dwim(client.focus, "up") end)
bindkey( { " ", " ", " " }, "l",       "   ",    "layout", "move border left", global, function() awful.client.focus.bydirection("right") end)
-- -tools =============================================================
bindkey( { " ", " " }, "Delete",      "#!-top",   "tools",   "show bashtop", global, function() apps.process_monitor() end)
bindkey( { " " },            "y",      " icon: ", "tools",  "yubico-oath", global, function () awful.spawn("passdmenu") end)
bindkey( { " " },            "p",      " icon: ", "tools",  "pass via dmenu", global, function () awful.spawn("passdmenu") end)
bindkey( { },                 "Print",  " icon: ", "tools",  "screenshot: full screen", global, function() apps.screenshot("full")  end)
bindkey( { " " },            "Print",  " icon: ", "tools",  "screenshot: save area", global, function() apps.screenshot("selection") end)
bindkey( { " ", " "},       "Print",  " icon: ", "tools",  "screenshot: clip area", global, function() apps.screenshot("clipboard") end)
bindkey( { " ", " "},       "Print",  " icon: ", "tools",  "browse screenshots", global, function() apps.screenshot("browse") end)
bindkey( { " ", " ", " "}, "Print",  " icon: ", "tools",  "screenshot: edit", global, function() apps.screenshot("gimp") end)
-- -launch ============================================================
bindkey( none, "XF86MonBrightnessDown", " icon: ", "launch", "decrease laptop brightness", global, function () awful.spawn.with_shell("light -U 10") end)
bindkey( none, "XF86MonBrightnessUp",   " icon: ", "launch", "increase laptop brightness", global, function () awful.spawn.with_shell("light -A 10") end)
bindkey( none, "XF86Search",            " icon:ﰍ ", "launch", "activate sidebar web search prompt", global, 
        function() if sidebar_activate_prompt then sidebar_activate_prompt("web_search") end end)
bindkey( { " " }, "r",                 "run",      "launch", "activate sidebar run prompt", global,
        function ()
            if sidebar_activate_prompt then sidebar_activate_prompt("run") end
        end)
bindkey( { " " }, "d",                 "rofi",      "launch","rofi launcher", global,
        function()
            awful.spawn.with_shell("rofi -matching fuzzy -show combi")
        end)
-- bindkey( { " " }, "space",           "wibar",     "launch",  "toggle wibar visibility", global, function() wibars_toggle() end)
-- Number row =========================================================
-- bindkey( { " " }, "1", "#1", "tags", "view tag #1", global, function() wibars_toggle() end)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- local ntags = 9
-- for i = 1, ntags do
        -- View tag only.
        -- bindkey( { " " }, i, "#"..i, "tags",  "view tag #"..i, global, 
        --     function ()
        --         -- Tag back and forth
        --         helpers.tag_back_and_forth(i)

        --         -- Simple tag view
        --         -- local tag = mouse.screen.tags[i]
        --         -- if tag then
        --         -- tag:view_only()
        --         -- end
        --     end)
    --     -- Toggle tag display.
    --     awful.key({ superkey, ctrlkey }, "#" .. i + 9,
    --         function ()
    --             local screen = awful.screen.focused()
    --             local tag = screen.tags[i]
    --             if tag then
    --                 awful.tag.viewtoggle(tag)
    --             end
    --         end,
    --         {description = "toggle tag #" .. i, group = "tag"}),

    --     -- Move client to tag.
    --     awful.key({ superkey, shiftkey }, "#" .. i + 9,
    --         function ()
    --             if client.focus then
    --                 local tag = client.focus.screen.tags[i]
    --                 if tag then
    --                     client.focus:move_to_tag(tag)
    --                 end
    --             end
    --         end,
    --         {description = "move focused client to tag #"..i, group = "tag"}),

    --     -- Move all visible clients to tag and focus that tag
    --     awful.key({ superkey, altkey }, "#" .. i + 9,
    --         function ()
    --             local tag = client.focus.screen.tags[i]
    --             local clients = awful.screen.focused().clients
    --             if tag then
    --                 for _, c in pairs(clients) do
    --                     c:move_to_tag(tag)
    --                 end
    --                 tag:view_only()
    --             end
    --         end,
    --         {description = "move all visible clients to tag #"..i, group = "tag"}),
    --     -- Toggle tag on focused client.
    --     awful.key({ superkey, ctrlkey, shiftkey }, "#" .. i + 9,
    --         function ()
    --             if client.focus then
    --                 local tag = client.focus.screen.tags[i]
    --                 if tag then
    --                     client.focus:toggle_tag(tag)
    --                 end
    --             end
    --         end,
    --         {description = "toggle focused client on tag #" .. i, group = "tag"})
-- end


-- client stuff =======================================================
bindkey( { " " },       "Tab"," icon: ",   "client",  "window switcher", global, function() window_switcher_show(awful.screen.focused()) end)
bindkey( { " ", " " }, "h",  "  \r  ", "client", "focus left", global, function() awful.client.focus.bydirection("left") end)
bindkey( { " ", " " }, "j",  "  \r  ", "client", "focus down", global, function() awful.client.focus.bydirection("down") end)
bindkey( { " ", " " }, "k",  "   ",    "client", "focus up", global, function() awful.client.focus.bydirection("up") end)
bindkey( { " ", " " }, "l",  "   ",    "client", "focus right", global, function() awful.client.focus.bydirection("right") end)
bindkey( { " ", " " }, "u",  " icon: ",   "client",  "switch to urgent client", global,
        function ()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then awful.tag.history.restore() else awful.client.urgent.jumpto() end
        end)
bindkey( { " ", " " }, "-", " icon: icon: ",       "layout",  "decrease gap", global, function() awful.tag.incgap(5, nil) end)
bindkey( { " ", " " }, "=", " icon: icon: ",       "layout",  "increase gap", global, function() awful.tag.incgap(-5, nil) end)
bindkey( { " ", " " }, "t", " icon: ",         "client",  "toggle keep on top", client, function (c) c.ontop = not c.ontop end)
bindkey( { " ", " " }, "p", " icon: ",      "client",  "toggle sticky", client, function (c) c.sticky = not c.sticky end)
bindkey( { " ", " " }, "f", " icon: ",    "client",  "toggle floating", client, function () awful.client.floating.toggle() end)
bindkey( { " ", " " }, "m", "max",         "client",  "maximize client", client,
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end )
bindkey( { " " },       "n", " icon: ",         "client",  "minimize client", client,
        function (c)
            c.minimized = true
        end )
bindkey( { " ", " " }, "n", " icon: ", "layout",  "restore minimized client",   global,
        function()
            local c = awful.client.restore()
            if c then client.focus = c end
        end)
bindkey( { " " },       "o", "icon: icon: ",     "client", "move client to screen", client, function (c) c:move_to_screen() end)
-- 鹿
bindkey( { " ", " " }, "[", "icon: -",    "client", "decrease client opacity", client,
        function (c)
            c.opacity = c.opacity - 0.05
        end)
bindkey( { " ", " " }, "]", "icon: +",    "client", "increase client opacity", client,
        function (c)
            c.opacity = c.opacity + 0.05
        end)
--bindkey( { " ", " " },       "Return1", "mk master",   "client", "promote client to master", client, function (c) c:swap(awful.client.getmaster()) end)
--bindkey( { " ", " " },       "Return2", "mk master",   "client", "promote client to master", client, function (c) c:swap(awful.client.getmaster()) end)
bindkey( { " ", " "},  "c", " icon: ",    "client", "close client", client, function (c) c:kill() end)

return kbvwr.bind
