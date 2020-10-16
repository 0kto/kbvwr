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
    kbvwr.bind.key( {  }, "XF86AudioMute",         "mute",       "media",    "mute",                       function () helpers.volume_control(0) end),
    kbvwr.bind.key( {  }, "XF86AudioLowerVolume",  "vol -",      "media",    "decrease volume",            function () helpers.volume_control(-5) end),
    kbvwr.bind.key( {  }, "XF86AudioRaiseVolume",  "vol +",      "media",    "increase volume",            function () helpers.volume_control(5) end),
    kbvwr.bind.key( {  }, "XF86AudioMicMute",      "mute mic",   "media",    "mute microphone",
        function()
            awful.spawn.with_shell("amixer -D pulse sset Capture toggle &> /dev/null")
        end),
    kbvwr.bind.key( {  }, "XF86MonBrightnessDown", "bright -",   "launcher", "decrease laptop brightness", function () awful.spawn.with_shell("light -U 10") end),
    kbvwr.bind.key( {  }, "XF86MonBrightnessUp",   "bright +",   "launcher", "increase laptop brightness", function () awful.spawn.with_shell("light -A10") end),
    kbvwr.bind.key( {  }, "XF86Display",           "aRandr",     "tools",    "configure display layout",   function () awful.spawn("arandr") end),
    kbvwr.bind.key( {  }, "XF86Search",            "search",     "launcher", "activate sidebar web search prompt",
        function() if sidebar_activate_prompt then sidebar_activate_prompt("web_search") end end),
    kbvwr.bind.key( {  }, "XF86Tools",             "kbvwr",      "awesome",  "show keyboard bindings",     function() keyboard_viewer_show() end),
    kbvwr.bind.key( {  }, "XF86LaunchA",           "tray",       "awesome",  "toggle tray visibility",     function() tray_toggle() end),
    kbvwr.bind.key( {  }, "XF86Explorer",          "dashboard",  "awesome",  "toggle dashboard visibility",
        function() if dashboard_show then dashboard_show() end end),


    -- normal keyboard bindings
    kbvwr.bind.key( { "Super_L"},              "Escape", "quit",          "awesome", "show shutdown menu",          function() exit_screen_show() end),
    -- kbvwr.bind.key( { "Super_L" },             "F9",     "kbvwr",         "awesome", "show keyboard bindings",      function() keyboard_viewer_show() end),
    -- kbvwr.bind.key( { "Super_L" },             "F11",    "tray",          "awesome", "toggle tray visibility",      function () tray_toggle() end),
    kbvwr.bind.key( { "Super_L"},             "grave",   "sidebar",       "awesome", "toggle sidebar visibility",   function() sidebar_toggle() end),
    kbvwr.bind.key( { "Super_L" },             "-",      "gap -",         "layout",  "decrease gap",                function() kawful.tag.incgap(5, nil) end),
    kbvwr.bind.key( { "Super_L", "Shift"},     "-",      "gap +",         "layout",  "increase gap",                function() awful.tag.incgap(-5, nil) end),
    kbvwr.bind.key( { "Control_L", "Alt_L"},   "Delete", "#!-top",        "tools",   "show bashtop",                function() apps.process_monitor() end),
    kbvwr.bind.key( { "Super_L" },             "Return", "terminal",      "apps",    "spawn terminal",              function() awful.spawn(user.terminal) end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "Return", "wibar",         "launcher","toggle wibar visibility",     function() wibars_toggle() end),
    kbvwr.bind.key( { "Super_L", "Shift"},     "Return", "floating term", "apps",    "spawn floating terminal",     function() awful.spawn(user.floating_terminal, {floating = true}) end),
    kbvwr.bind.key( { "Super_L" },             "Tab",    "switcher",      "client",  "window switcher",             function() window_switcher_show(awful.screen.focused()) end),
    kbvwr.bind.key( { "Super_L" },             "e",      "ranger",        "tools",   "open ranger",                 function() apps.file_manager() end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "e",      "pcmanfm",       "tools",   "open pcmanfm",                function() awful.spawn("pcmanfm") end),
    kbvwr.bind.key( { "Super_L"},              "r",      "run",           "launcher","activate sidebar run prompt",
        function () if sidebar_activate_prompt then sidebar_activate_prompt("run") end end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "r",      "restart",       "awesome", "restart awesomeWM",           function() awesome.restart() end),
    kbvwr.bind.key( { "Super_L" },             "u",      "-> urgent",     "client",  "switch to urgent client",
        function ()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then awful.tag.history.restore() else awful.client.urgent.jumpto() end
        end),
    kbvwr.bind.key( { "Super_L" },             "p",      "pass",          "tools",  "pass via dmenu",               function () awful.spawn("passdmenu") end),
    kbvwr.bind.key( { "Super_L" },             "d",      "rofi",          "launcher","rofi launcher",
        function()
            awful.spawn.with_shell("rofi -matching fuzzy -show combi")
        end),

    -- hkl keys
    kbvwr.bind.key( { "Super_L" },             "h",      "focus left",    "client",  "focus left",                 function() awful.client.focus.bydirection("left") end),
    kbvwr.bind.key( { "Super_L" },             "j",      "focus down",    "client",  "focus down",                 function() awful.client.focus.bydirection("down") end),
    kbvwr.bind.key( { "Super_L" },             "k",      "focus up",      "client",  "focus up",                   function() awful.client.focus.bydirection("up") end),
    kbvwr.bind.key( { "Super_L" },             "l",      "focus right",   "client",  "focus right",                function() awful.client.focus.bydirection("right") end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "h",      "#+ master",     "layout",  "increase number of clients", function() awful.tag.incnmaster(1, nil, true) end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "j",      "#- col",        "layout",  "lower number of columns",    function() awful.tag.incncol(-1, nil, true) end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "k",      "#+ col",        "layout",  "increase number of columns", function() awful.tag.incncol(1, nil, true) end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "l",      "#- master",     "layout",  "lower number of clients",    function() awful.tag.incnmaster(-1, nil, true)  end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "h",      "| <",           "layout",  "move border left",           function() helpers.resize_dwim(client.focus, "left") end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "j",      "| v",           "layout",  "move border down",           function() helpers.resize_dwim(client.focus, "down") end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "k",      "| ^",           "layout",  "move border up",             function() helpers.resize_dwim(client.focus, "up") end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "l",      "| >",           "layout",  "move border left",           function() awful.client.focus.bydirection("right") end),

    kbvwr.bind.key( { "Super_L", "Shift_L"},   "n",      "restore min",   "layout",  "restore minimized client",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then client.focus = c end
        end),
    kbvwr.bind.key( { "Super_L" },             "space",  "clear",         "awesome", "clear all notifications",   
        function() 
            awesome.emit_signal("elemental::dismiss")
            naughty.destroy_all_notifications()
        end),

    -- Print
    kbvwr.bind.key( { },                       "Print", "screenshot",     "tools", "screenshot: full screen",      function() apps.screenshot("full")  end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "Print", "browse",         "tools", "browse screenshots",           function() apps.screenshot("browse") end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "Print", "screenshot",     "tools", "screenshot: save area",        function() apps.screenshot("selection") end),
    kbvwr.bind.key( { "Super_L", "Shift_L"},   "Print", "screenshot",     "tools", "screenshot: clip area",        function() apps.screenshot("clipboard") end),
    -- kbvwr.bind.key( { "Super_L", "Alt_L", "Shift_L"}, "Print", "edit",    "tools", "screenshot: edit",             function() apps.screenshot("gimp") end),
    
    -- direction keys
    kbvwr.bind.key( { "Super_L" },             "Up",     "focus up",      "client",  "focus up",                   function() awful.client.focus.bydirection("up") end),
    kbvwr.bind.key( { "Super_L" },             "Down",   "focus down",    "client",  "focus down",                 function() awful.client.focus.bydirection("down") end),
    kbvwr.bind.key( { "Super_L" },             "Left",   "focus left",    "client",  "focus left",                 function() awful.client.focus.bydirection("left") end),
    kbvwr.bind.key( { "Super_L" },             "Right",  "focus right",   "client",  "focus right",                function() awful.client.focus.bydirection("right") end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "Up",     "#+ master",     "layout",  "increase number of clients", function() awful.tag.incnmaster(1, nil, true) end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "Down",   "#- col",        "layout",  "lower number of columns",    function() awful.tag.incncol(-1, nil, true) end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "Left",   "#+ col",        "layout",  "increase number of columns", function() awful.tag.incncol(1, nil, true) end),
    kbvwr.bind.key( { "Super_L", "Alt_L"},     "Right",  "#- master",     "layout",  "lower number of clients",    function() awful.tag.incnmaster(-1, nil, true)  end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "Up",     "| <",           "layout",  "move border left",           function() helpers.resize_dwim(client.focus, "left") end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "Down",   "| v",           "layout",  "move border down",           function() helpers.resize_dwim(client.focus, "down") end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "Left",   "| ^",           "layout",  "move border up",             function() helpers.resize_dwim(client.focus, "up") end),
    kbvwr.bind.key( { "Super_L", "Control_L"}, "Right",  "| >",           "layout",  "move border left",           function() helpers.resize_dwim(client.focus, "right") end)

)


return kbvwr.bind