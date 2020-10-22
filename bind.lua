-- awesome stuff
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
-- elenepan stuff
local apps    = require("apps")
local helpers = require("helpers")
-- kbvwr stuff
local kbvwr         = {}
kbvwr.config        = require("kbvwr.config")
kbvwr.fn            = require("kbvwr.fn")
kbvwr.layout        = require("kbvwr.layout")
kbvwr.bind          = {}
kbvwr.bind.keymap   = kbvwr.layout.keymap
kbvwr.bind.colormap = kbvwr.layout.colormap
kbvwr.bind.keydesc  = kbvwr.layout.keydesc

-- function to return gears.key-table that can be joind to
-- keys.globalkeys
function kbvwr.bind.key(modifiers, key, desc, group, description, fn)
    awesome_modifiers = {}
    lvl = 0
    for ii,mod in ipairs(modifiers) do
        if mod == "Alt_L" then
            table.insert(awesome_modifiers, "Mod1")
            lvl = lvl + kbvwr.config.lvl['Alt_L']
        elseif mod == "Alt_R" then
            lvl = lvl + kbvwr.config.lvl['Alt_R']
        elseif mod == "Caps_Lock" then
            lvl = lvl + kbvwr.config.lvl['Caps_Lock']
        elseif mod == "Control_L" then
            table.insert(awesome_modifiers, "Control")
            lvl = lvl + kbvwr.config.lvl['Control_L']
        elseif mod == "Control_R" then
            lvl = lvl + kbvwr.config.lvl['Control_R']
        elseif mod == "Shift_L" or mod == "Shift_R" or mod == "shift" or mod == "Shift" then
            table.insert(awesome_modifiers, "Shift")
            lvl = lvl + kbvwr.config.lvl['shift']
        elseif mod == "Super_L" or mod == "Super" then
            table.insert(awesome_modifiers, "Mod4")
            lvl = lvl + kbvwr.config.lvl['Super_L']
        end
    end
    -- create normal keymapping
    map = awful.key(awesome_modifiers, key, fn, {description = description, group = group})
    -- get level from modifiers
    level = kbvwr.config.level[lvl]
    if key:find "XF86" == nil and (kbvwr.bind.keydesc[key][level] ~= nil or kbvwr.bind.keymap[key][level] ~= kbvwr.layout.keymap[key][level]) then
        -- exclude XF86.. keys, AND
        -- look for previous entries in the long description field (which is emtpy when starting out) OR make sure the keymap has changed from keyname.
        naughty.notify({text = "warning: keybinding \n \'level="..level.." + "..key.."\'\nalready exists!"})
    elseif key:find "XF86" == nil then
        kbvwr.bind.keymap[key][level]   = desc
        kbvwr.bind.colormap[key][level] = kbvwr.config.groupcolors[group] or kbvwr.config.default_key_color
        kbvwr.bind.keydesc[key][level]  = description
    end
    return map
end

kbvwr.bind.globalkeys = gears.table.join(
    -- -- Rofi youtube search and playlist selector
    -- awful.key({ superkey }, "y", apps.youtube,
    --     {description = "youtube search and play", group = "launcher"}),

    -- -- -- App drawer
    -- -- awful.key({ superkey }, "a", function()
    -- --     app_drawer_show()
    -- --                              end,
    -- --     {description = "App drawer", group = "custom"}),

    -- XF86... bindings
    kbvwr.bind.key( {  }, "XF86AudioMute",        "icon:ﱝ", "media", "mute",            function () helpers.volume_control(0) end),
    kbvwr.bind.key( {  }, "XF86AudioLowerVolume", "icon:ﱜ", "media", "decrease volume", function () helpers.volume_control(-5) end),
    kbvwr.bind.key( {  }, "XF86AudioRaiseVolume", "icon:ﱛ", "media", "increase volume", function () helpers.volume_control(5) end),
    kbvwr.bind.key( {  }, "XF86AudioMicMute",     "icon:", "media", "mute microphone",
        function()
            awful.spawn.with_shell("amixer -D pulse sset Capture toggle &> /dev/null")
        end),
    kbvwr.bind.key( {  }, "XF86MonBrightnessDown", "icon:", "launcher", "decrease laptop brightness", function () awful.spawn.with_shell("light -U 10") end),
    kbvwr.bind.key( {  }, "XF86MonBrightnessUp",   "icon:", "launcher", "increase laptop brightness", function () awful.spawn.with_shell("light -A 10") end),
    kbvwr.bind.key( {  }, "XF86Display",           "icon:", "tools",    "configure display layout",   function () awful.spawn("arandr") end),
    kbvwr.bind.key( {  }, "XF86Search",            "icon:ﰍ", "launcher", "activate sidebar web search prompt",
        function() if sidebar_activate_prompt then sidebar_activate_prompt("web_search") end end),
    kbvwr.bind.key( {  }, "XF86Tools",             "icon:", "awesome",  "show keyboard bindings",     function() keyboard_viewer_show() end),
    kbvwr.bind.key( {  }, "XF86LaunchA",           "tray",   "awesome",  "toggle tray visibility",     function() tray_toggle() end),
    kbvwr.bind.key( {  }, "XF86Explorer",          "icon:﵁", "awesome",  "toggle dashboard visibility",
        function() if dashboard_show then dashboard_show() end end),


    -- normal keyboard bindings
    kbvwr.bind.key( { "Super_L"},              "Escape", "quit",     "awesome",  "show shutdown menu",          function() exit_screen_show() end),
    kbvwr.bind.key( { "Super_L" },             "grave",  "sidebar",  "awesome",  "toggle sidebar visibility",   function() sidebar_toggle() end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "-",      "gap -",    "layout",   "decrease gap",                function() kawful.tag.incgap(5, nil) end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "=",      "gap +",    "layout",   "increase gap",                function() awful.tag.incgap(-5, nil) end),
    kbvwr.bind.key( { "Control_L", "Alt_L"},   "Delete", "#!-top",   "tools",    "show bashtop",                function() apps.process_monitor() end),
    kbvwr.bind.key( { "Super_L" },             "Return", "icon:",   "apps",     "spawn terminal",              function() awful.spawn(user.terminal) end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "Return", "wibar",    "launcher", "toggle wibar visibility",     function() wibars_toggle() end),
    kbvwr.bind.key( { "Super_L", "Shift"},     "Return", "icon:",  "apps",     "spawn floating terminal",     function() awful.spawn(user.floating_terminal, {floating = true}) end),
    kbvwr.bind.key( { "Super_L" },             "Tab",    "icon:",   "client",   "window switcher",             function() window_switcher_show(awful.screen.focused()) end),
    kbvwr.bind.key( { "Super_L" },             "e",      "icon:",  "tools",    "open ranger",                 function() apps.file_manager() end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "e",      "icon:",   "tools",    "open pcmanfm",                function() awful.spawn("pcmanfm") end),
    kbvwr.bind.key( { "Super_L"},              "r",      "run",      "launcher", "activate sidebar run prompt",
        function () if sidebar_activate_prompt then sidebar_activate_prompt("run") end end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "r",      "restart",  "awesome",  "restart awesomeWM",           function() awesome.restart() end),
    kbvwr.bind.key( { "Super_L" },             "u",      "icon: ", "client",   "switch to urgent client",
        function ()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then awful.tag.history.restore() else awful.client.urgent.jumpto() end
        end),
    kbvwr.bind.key( { "Super_L" },             "p",      "icon:",        "tools",  "pass via dmenu",               function () awful.spawn("passdmenu") end),
    kbvwr.bind.key( { "Super_L" },             "d",      "rofi",          "launcher","rofi launcher",
        function()
            awful.spawn.with_shell("rofi -matching fuzzy -show combi")
        end),

    -- hkl keys
    kbvwr.bind.key( { "Super_L" },                       "h", "icon:\r", "client", "focus left",                 function() awful.client.focus.bydirection("left") end),
    kbvwr.bind.key( { "Super_L" },                       "j", "icon:\r", "client", "focus down",                 function() awful.client.focus.bydirection("down") end),
    kbvwr.bind.key( { "Super_L" },                       "k", "icon: ",  "client", "focus up",                   function() awful.client.focus.bydirection("up") end),
    kbvwr.bind.key( { "Super_L" },                       "l", "icon: ",  "client", "focus right",                function() awful.client.focus.bydirection("right") end),
    kbvwr.bind.key( { "Super_L", "Alt_L" },              "h", "icon:ﰂ",    "layout", "increase number of clients", function() awful.tag.incnmaster(1, nil, true) end),
    kbvwr.bind.key( { "Super_L", "Alt_L" },              "j", "icon:吝",    "layout", "lower number of columns",    function() awful.tag.incncol(-1, nil, true) end),
    kbvwr.bind.key( { "Super_L", "Alt_L" },              "k", "icon:溺",    "layout", "increase number of columns", function() awful.tag.incncol(1, nil, true) end),
    kbvwr.bind.key( { "Super_L", "Alt_L" },              "l", "icon:ﯰ",    "layout", "lower number of clients",    function() awful.tag.incnmaster(-1, nil, true)  end),
    kbvwr.bind.key( { "Super_L", "Alt_L", "Control_L" }, "h", "icon:\r", "layout", "move border left",           function() helpers.resize_dwim(client.focus, "left") end),
    kbvwr.bind.key( { "Super_L", "Alt_L", "Control_L" }, "j", "icon:\r", "layout", "move border down",           function() helpers.resize_dwim(client.focus, "down") end),
    kbvwr.bind.key( { "Super_L", "Alt_L", "Control_L" }, "k", "icon: ",  "layout", "move border up",             function() helpers.resize_dwim(client.focus, "up") end),
    kbvwr.bind.key( { "Super_L", "Alt_L", "Control_L" }, "l", "icon: ",  "layout", "move border left",           function() awful.client.focus.bydirection("right") end),

    kbvwr.bind.key( { "Super_L", "Control_L"}, "n",      "restore min",   "layout",  "restore minimized client",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then client.focus = c end
        end),
    kbvwr.bind.key( { "Super_L" },             "space", "layout +", "layout", "switch to next layout", function () awful.layout.inc( 1) end),
    kbvwr.bind.key( { "Super_L", "shift" },    "space", "layout -", "layout", "switch to previous layout", function () awful.layout.inc(-1) end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "space", "clear",         "awesome", "clear all notifications",   
        function() 
            awesome.emit_signal("elemental::dismiss")
            naughty.destroy_all_notifications()
        end),

    -- Print
    kbvwr.bind.key( { },                       "Print", "icon:", "tools", "screenshot: full screen", function() apps.screenshot("full")  end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "Print", "browse", "tools", "browse screenshots",      function() apps.screenshot("browse") end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "Print", "icon:", "tools", "screenshot: save area",   function() apps.screenshot("selection") end),
    kbvwr.bind.key( { "Super_L", "Shift_L"},   "Print", "icon:", "tools", "screenshot: clip area",   function() apps.screenshot("clipboard") end),
    -- kbvwr.bind.key( { "Super_L", "Alt_L", "Shift_L"}, "Print", "edit",    "tools", "screenshot: edit",             function() apps.screenshot("gimp") end),
    
    -- direction keys
    kbvwr.bind.key(  { "Super_L" },                       "Up",    "icon:\r", "client", "focus up",                   function() awful.client.focus.bydirection("up") end),
    kbvwr.bind.key(  { "Super_L" },                       "Down",  "icon:\r", "client", "focus down",                 function() awful.client.focus.bydirection("down") end),
    kbvwr.bind.key(  { "Super_L" },                       "Left",  "icon: ",  "client", "focus left",                 function() awful.client.focus.bydirection("left") end),
    kbvwr.bind.key(  { "Super_L" },                       "Right", "icon: ",  "client", "focus right",                function() awful.client.focus.bydirection("right") end),
    kbvwr.bind.key(  { "Super_L", "Alt_L" },              "Up",    "icon:ﰂ",    "layout", "increase number of clients", function() awful.tag.incnmaster(1, nil, true) end),
    kbvwr.bind.key(  { "Super_L", "Alt_L" },              "Down",  "icon:吝",    "layout", "lower number of columns",    function() awful.tag.incncol(-1, nil, true) end),
    kbvwr.bind.key(  { "Super_L", "Alt_L" },              "Left",  "icon:溺",    "layout", "increase number of columns", function() awful.tag.incncol(1, nil, true) end),
    kbvwr.bind.key(  { "Super_L", "Alt_L" },              "Right", "icon:ﯰ",    "layout", "lower number of clients",    function() awful.tag.incnmaster(-1, nil, true)  end),
    kbvwr.bind.key(  { "Super_L", "Alt_L", "Control_L" }, "Up",    "icon:\r", "layout", "move border left",           function() helpers.resize_dwim(client.focus, "left") end),
    kbvwr.bind.key(  { "Super_L", "Alt_L", "Control_L" }, "Down",  "icon:\r", "layout", "move border down",           function() helpers.resize_dwim(client.focus, "down") end),
    kbvwr.bind.key(  { "Super_L", "Alt_L", "Control_L" }, "Left",  "icon: ",  "layout", "move border up",             function() helpers.resize_dwim(client.focus, "up") end),
    kbvwr.bind.key(  { "Super_L", "Alt_L", "Control_L" }, "Right", "icon: ",  "layout", "move border left",           function() helpers.resize_dwim(client.focus, "right") end)
)
-- standard global keys
--[[

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),



-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
})


--]]

kbvwr.bind.clientkeys = gears.table.join(
    kbvwr.bind.key(  { "Super_L" }, "t", "top",     "client", "toggle keep on top", function (c) c.ontop = not c.ontop end),
    kbvwr.bind.key(  { "Super_L" }, "o", "mv:scrn", "client", "move client to screen", function (c) c:move_to_screen() end),
    kbvwr.bind.key(  { "Super_L", "Alt_L" }, "[", "opacity -",  "client", "decrease client opacity",
        function (c)
            c.opacity = c.opacity - 0.05
        end),
    kbvwr.bind.key(  { "Super_L", "Alt_L" }, "]", "opacity +",  "client", "increase client opacity",
        function (c)
            c.opacity = c.opacity + 0.05
        end),
    kbvwr.bind.key(  { "Super_L" }, "p", "sticky",  "client", "toggle sticky", function (c) c.sticky = not c.sticky end),
    kbvwr.bind.key(  { "Super_L", "Control_L" }, "Return", "mk master","client", "promote client to master", function (c) c:swap(awful.client.getmaster()) end),
    kbvwr.bind.key(  { "Super_L" }, "f", "float",   "client", "toggle floating", function () awful.client.floating.toggle() end),
    kbvwr.bind.key(  { "Super_L", "shift"}, "c", "close",  "client", "close client", function (c) c:kill() end),
    kbvwr.bind.key(  { "Super_L" }, "f", "max",     "client", "maximize client",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end ),
    kbvwr.bind.key(  { "Super_L" }, "n", "min",    "client", "minimize client",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end )

)
return kbvwr.bind
