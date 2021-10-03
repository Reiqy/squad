local renderer = require "renderer"
local resources = require "resources"

local t = {}

local changeScene

local assetsLoaded = false
local loveLogo

t.currentAlpha = 1
t.doNotPlayAudio = true

local alphaChangeSpeed = 0.5

local phase = "decrease"
local time = 0
local sentence = "Made with LÖVE"
local textWidth

t.doTransition = true

function t.setupScene(_changeScene)
    changeScene = _changeScene
    
    if (not assetsLoaded) then
        loveLogo = love.graphics.newImage(resources.sprites.loveLogo)
    end

    local font = renderer.getFont()
end

function t.handleInput(_command)
    if (_command == "space") or (_command == "enter") then
        phase = "increase"
    end
end

function t.updateScene(_dt)
    if (phase == "decrease") then
        t.currentAlpha = t.currentAlpha - _dt * alphaChangeSpeed
        if (t.currentAlpha <= 0) then
            t.currentAlpha = 0
            phase = "stay"
        end
    elseif (phase == "stay") then
        time = time + _dt
        if (time >= 1) then
            phase = "increase"
        end
    elseif (phase == "increase") then
        t.currentAlpha = t.currentAlpha + _dt * alphaChangeSpeed
        if (t.currentAlpha >= 1) then
            changeScene("menu", false, true)
        end
    end
end

function t.drawScene()
    local x, y = (320 - 64) / 2, (180 - 64) / 2 - 20
    love.graphics.draw(loveLogo, x, y)
    --r, g, b, a = love.graphics.getColor()
    --love.graphics.setColor(0, 0, 0, currentAlpha)
    --love.graphics.rectangle("fill", x, y, 64, 64)
    --love.graphics.setColor(r, g, b, a)
    local x, y = 320 / 2 - 35, 120
    renderer.print(sentence, x, y)
end


return t