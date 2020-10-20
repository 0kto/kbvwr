local helpers = require('helpers')
local icons   = require('icons')
local wibox   = require('wibox')
local naughty   = require('naughty')

local kbvwr         = {}
kbvwr.layout        = {}
kbvwr.config        = require('kbvwr.config')

local function expanded_array(value, iterations)
	output = {}
	for ii = 1,iterations, 1 do
		table.insert(output, value)
	end
	return output
end

local function has_key(tab, key)
    for _,value in ipairs(tab) do
        if value == key then
            return true
        end
    end
    return false
end

kbvwr.layout.keymap = {}
-- Fn + F[1-12] Keys need to be defined as well
kbvwr.layout.keymap['XF86AudioMute']         = {}
kbvwr.layout.keymap['XF86AudioLowerVolume']  = {}
kbvwr.layout.keymap['XF86AudioRaiseVolume']  = {}
kbvwr.layout.keymap['XF86AudioMicMute']      = {}
kbvwr.layout.keymap['XF86MonBrightnessDown'] = {}
kbvwr.layout.keymap['XF86MonBrightnessUp']   = {}
kbvwr.layout.keymap['XF86Display']           = {}
kbvwr.layout.keymap['XF86WLAN']              = {}
kbvwr.layout.keymap['XF86Tools']             = {}
kbvwr.layout.keymap['XF86Search']            = {}
kbvwr.layout.keymap['XF86LaunchA']           = {}
kbvwr.layout.keymap['XF86Explorer']          = {}
kbvwr.layout.keymap['XF86Bluetooth']         = {}
-- XF86Switch_VT_1

kbvwr.layout.keymap['Escape']    = expanded_array('ESC',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F1']        = expanded_array('F1',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F2']        = expanded_array('F2',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F3']        = expanded_array('F3',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F4']        = expanded_array('F4',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F5']        = expanded_array('F5',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F6']        = expanded_array('F6',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F7']        = expanded_array('F7',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F8']        = expanded_array('F8',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F9']        = expanded_array('F9',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F10']       = expanded_array('F10',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F11']       = expanded_array('F11',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['F12']       = expanded_array('F12',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Home']      = expanded_array('Home', #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['End']       = expanded_array('End',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Insert']    = expanded_array('Ins',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Delete']    = expanded_array('Del',  #(kbvwr.config.level_modifier_combo))
-- row     2          
kbvwr.layout.keymap['grave']     = {'`',         '~',        }
kbvwr.layout.keymap['1']         = {'1',         '!',        }
kbvwr.layout.keymap['2']         = {'2',         '@',        }
kbvwr.layout.keymap['3']         = {'3',         '#',        }
kbvwr.layout.keymap['4']         = {'4',         '$',        }
kbvwr.layout.keymap['5']         = {'5',         '%',        }
kbvwr.layout.keymap['6']         = {'6',         '^',        }
kbvwr.layout.keymap['7']         = {'7',         '&',        }
kbvwr.layout.keymap['8']         = {'8',         '*',        }
kbvwr.layout.keymap['9']         = {'9',         '(',        }
kbvwr.layout.keymap['0']         = {'0',         ')',        }
kbvwr.layout.keymap['-']         = {'-',         '_',        }
kbvwr.layout.keymap['=']         = {'=',         '+',        }
kbvwr.layout.keymap['BackSpace'] = expanded_array('icon:',  #(kbvwr.config.level_modifier_combo))
-- row     3          
kbvwr.layout.keymap['Tab']       = expanded_array('icon:',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['q']         = {'q',         'Q',        }
kbvwr.layout.keymap['w']         = {'w',         'W',        }
kbvwr.layout.keymap['e']         = {'e',         'E',        }
kbvwr.layout.keymap['r']         = {'r',         'R',        }
kbvwr.layout.keymap['t']         = {'t',         'T',        }
kbvwr.layout.keymap['y']         = {'y',         'Y',        }
kbvwr.layout.keymap['u']         = {'u',         'U',        }
kbvwr.layout.keymap['i']         = {'i',         'I',        }
kbvwr.layout.keymap['o']         = {'o',         'O',        }
kbvwr.layout.keymap['p']         = {'p',         'P',        }
kbvwr.layout.keymap['[']         = {'[',         '{',        }
kbvwr.layout.keymap[']']         = {']',         '}',        }
kbvwr.layout.keymap['Return']    = expanded_array('icon:',  #(kbvwr.config.level_modifier_combo))
-- row 4          
kbvwr.layout.keymap['Caps_Lock'] = expanded_array('icon:',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['a']         = {'a',         'A',        }
kbvwr.layout.keymap['s']         = {'s',         'S',        }
kbvwr.layout.keymap['d']         = {'d',         'D',        }
kbvwr.layout.keymap['f']         = {'f',         'F',        }
kbvwr.layout.keymap['g']         = {'g',         'G',        }
kbvwr.layout.keymap['h']         = {'h',         'H',        }
kbvwr.layout.keymap['j']         = {'j',         'J',        }
kbvwr.layout.keymap['k']         = {'k',         'K',        }
kbvwr.layout.keymap['l']         = {'l',         'L',        }
kbvwr.layout.keymap[';']         = {';',         ':',        }
kbvwr.layout.keymap["'"]         = {"'",         "\"",       }
kbvwr.layout.keymap['\\']        = {'\\',        '|',        }
-- kbvwr.layout.keymap['Return'] = {'Return',    'Return',   }
-- row 5              
kbvwr.layout.keymap['Shift_L']   = expanded_array('icon:', #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['<']         = {'<',         '>',        }
kbvwr.layout.keymap['z']         = {'z',         'Z',        }
kbvwr.layout.keymap['x']         = {'x',         'X',        }
kbvwr.layout.keymap['c']         = {'c',         'C',        }
kbvwr.layout.keymap['v']         = {'v',         'V',        }
kbvwr.layout.keymap['b']         = {'b',         'B',        }
kbvwr.layout.keymap['n']         = {'n',         'N',        }
kbvwr.layout.keymap['m']         = {'m',         'M',        }
kbvwr.layout.keymap[',']         = {',',         '<',        }
kbvwr.layout.keymap['.']         = {'.',         '>',        }
kbvwr.layout.keymap['/']         = {'/',         '?',        }
kbvwr.layout.keymap['Shift_R']   = expanded_array('icon:',  #(kbvwr.config.level_modifier_combo))
-- row 6              
kbvwr.layout.keymap['Fn']        = expanded_array('Fn',     #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Control_L'] = expanded_array('icon:', #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Super_L']   = expanded_array('icon:',      #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Alt_L']     = expanded_array('icon:',   #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['space']     = expanded_array('icon:',    #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Alt_R']     = expanded_array('icon:',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Print']     = expanded_array('icon:',  #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Control_R'] = expanded_array('icon:', #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Prior']     = expanded_array('icon:',      #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Up']        = expanded_array('icon:',      #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Next']      = expanded_array('icon:',      #(kbvwr.config.level_modifier_combo))
-- row 7              
kbvwr.layout.keymap['Left']      = expanded_array('icon:',      #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Down']      = expanded_array('icon:',      #(kbvwr.config.level_modifier_combo))
kbvwr.layout.keymap['Right']     = expanded_array('icon:',      #(kbvwr.config.level_modifier_combo))

-- long form description should go to
kbvwr.layout.keydesc = {}
for key,val in pairs(kbvwr.layout.keymap) do
  kbvwr.layout.keydesc[key] = {}
end

kbvwr.layout.colormap = {}
for key,val in pairs(kbvwr.layout.keymap) do
  kbvwr.layout.colormap[key] = {}
end
-- set colormap for modifiers
for level,combo in pairs(kbvwr.config.level_modifier_combo) do
	for mod,_ in pairs(kbvwr.config.modifier_list) do
		if has_key(combo, mod) then
			if mod == 'shift' or mod == 'Shift' or mod == 'Shift_L' or mod == 'Shift_R' then
				kbvwr.layout.colormap['Shift_L'][level] = kbvwr.config.active_key_color
				kbvwr.layout.colormap['Shift_R'][level] = kbvwr.config.active_key_color

			else
				kbvwr.layout.colormap[mod][level] = kbvwr.config.active_key_color
			end
			-- naughty.notify({text = mod})
		else
			if mod == 'shift' or mod == 'Shift' then
				-- do nothing, as 'Shift_L' and 'Shift_R' are included in mod list.
			elseif (mod == 'Shift_L' or mod == 'Shift_R') and (has_key(combo, 'shift') or has_key(combo, 'Shift') or has_key(combo,'Shift_L') or has_key(combo,'Shift_R')) then
				-- do nothing in order to not overwrite active key status
			else
				kbvwr.layout.colormap[mod][level] = kbvwr.config.modifier_key_color
			end
		end
	end
end
 


return kbvwr.layout