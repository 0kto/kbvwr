

-- Functions that you use more than once and in different files would
-- be nice to define here.

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local icons = require("icons")
local notifications = require("notifications")
local naughty = ("naughty")

local helpers = {}




--[[
helpers.volume_control
helpers.resize_dwim
helpers.screen_mask
]]

-- Create rounded rectangle shape (in one line)
helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

-- Resize DWIM (Do What I Mean)
-- Resize client or factor
-- Constants --
local floating_resize_amount = dpi(20)
local tiling_resize_factor= 0.05
---------------
function helpers.resize_dwim(c, direction)
    if c and c.floating then
        if direction == "up" then
            c:relative_move(  0,  0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(  0,  0, 0,  floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(  0,  0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(  0,  0,  floating_resize_amount, 0)
        end
    elseif awful.layout.get(mouse.screen) ~= awful.layout.suit.floating then
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact( tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact( tiling_resize_factor)
        end
    end
end

function helpers.volume_control(step)
    local cmd
    if step == 0 then
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    else
        sign = step > 0 and "+" or ""
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ "..sign..tostring(step).."%"
    end
    awful.spawn.with_shell(cmd)
end

function helpers.send_key(c, key)
    awful.spawn.with_shell("xdotool key --window "..tostring(c.window).." "..key)
end

function helpers.send_key_sequence(c, seq)
    awful.spawn.with_shell("xdotool type --delay 5 --window "..tostring(c.window).." "..seq)
end

-- Adds a maximized mask to a screen
function helpers.screen_mask(s, bg)
    local mask = wibox({visible = false, ontop = true, type = "splash", screen = s})
    awful.placement.maximize(mask)
    mask.bg = bg
    return mask
end

return helpers
