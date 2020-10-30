# keyboard viewer widget for AwesomeWM

This widget is for everyone who wants an easy and interactive way of displaying the keybindings of the current awesomeWM configuration.
I came up with an 'dock' widget, which displays a virtual keyboard.
Without pressing a modifier, this is rather unimpressive, but the magic happens if you press any of your modifier keys:
* the pressed modifier is highlighted
* the keybindings, that are available with the pressed modifiers, are indicated by a symbol or string, the bg color of the key changes depending of the grouping
* if any of the available key-combinations are pressed, a description field shows details of the action.

## Attribution
Now that you know what this project is about, let's get attribution out of the way.
I learned the basics of *widget-ing* from @elenapan's [dotfiles](https://github.com/elenapan/dotfiles), which of course heavily influenced this widget.  Especially the helper functions are making life easier, and a few of the original ones can be found in `kbvwr/helpers.lua`.

Another useful source is of course the AwesomeWM documentation and the Arch Wiki, as well as other public dotfiles.

We stand on the shoulders of giants!

## Requirements
* The symbols I picked come from the "Cousine Nerd Font", but any large font with symbols should do when making the needed changes.
* I use some helper functions from @elenapan's [dotfiles](https://github.com/elenapan/dotfiles/conifg/awesomw/helpers.lua).  The required helper functions are included in this repo, to make it more portable.
* The keybindings use the handy definitions for external [apps](https://github.com/elenapan/dotfiles/config/awesomw/apps.lua) from the same repository.

## Installation
Simply clone the repo to your `$XDG_HOME_CONFIG/awesome` dotfiles. 
This repo comes with the keybindings I use on my Laptops, so you might want to adjust these (`kbvwr/binds.lua`).
In order to bind a key, use the local `bindkey()` function: 

```lua
kbvwr.fn.keys.bind(kbvwr, modifiers, key, symbol, group, description, isGlobalkey, fn)
```
where
* `kbvwr` is a table that holds all keys (`kbvwr.keys[<keyname>]`),
* `modifiers` is an array holding all modifiers for the keybinding,
* `key` is the key that is bound (always use the lowercase letter, or update aliases (`kbvwr.config.keys.aliases`) ),
* `symbol` is the string displayed on the key,
* `group` gives the grouping name, which determines the bg color,
* `description` is a longform description shown in the description area upon keypress,
* `isGlobalkey` is a boolean, which, if true adds the keybinding to `kbvwr.bind.globalkeybindings` or else to `kbvwr.bind.clientkeybindings`,
* `fn` is the function called by the shortcut.
The result is the output of the standard `awful.key()` command.

To start using the widget, include it into the main `rc.lua` config file:
```lua
local kbvwr = require("kbvwr.keyboard_viewer")
```
and register the global keybindings with
```lua
root.keys(kbvwr.bind.globalkeybindings)
```
In order to register the client keybindings, find the default rules definition and update the keyword `keys`:
```lua
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    {
        -- All clients will match this rule.
        rule = { },
        properties = {
            ...
            keys = kbvwr.bind.clientkeybindings,
            ...
        }
    },
    ...
}
```
## Configuration
All configuration is living in `kbvwr/config.lua`, which also defines the modifiers and colors.
If the keyboard layout is different for your machine, you might have to update the `keyboard_viewer:setup` block.
