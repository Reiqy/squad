local renderer = require "renderer"
local resources = require "resources"

local t = {}

local changeScene

local assetsLoaded = false
local loveLogo

local currentAlpha = 1

local alphaChangeSpeed = 0.5

local phase = "decrease"
local time = 0

function t.setupScene(_changeScene)
    changeScene = _changeScene
    
    if (not assetsLoaded) then
        loveLogo = love.graphics.newImage(resources.sprites.loveLogo)
    end
end

function t.handleInput(_command)
    if (_command == "space") or (_command == "enter") then
        changeScene("menu")
    end
end

function t.updateScene(_dt)
    if (phase == "decrease") then
        currentAlpha = currentAlpha - _dt * alphaChangeSpeed
        if (currentAlpha <= 0) then
            currentAlpha = 0
            phase = "stay"
        end
    elseif (phase == "stay") then
        time = time + _dt
        if (time >= 1) then
            phase = "increase"
        end
    elseif (phase == "increase") then
        currentAlpha = currentAlpha + _dt * alphaChangeSpeed
        if (currentAlpha >= 1) then
            changeScene("menu")
        end
    end
end

function t.drawScene()
    local x, y = (320 - 64) / 2, (180 - 64) / 2
    love.graphics.draw(loveLogo, x, y)
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 0, 0, currentAlpha)
    love.graphics.rectangle("fill", x, y, 64, 64)
    love.graphics.setColor(r, g, b, a)
end


return t