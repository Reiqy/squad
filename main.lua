local renderer = require "renderer"

local sourceWidth, sourceHeight = 320, 180
local bomb

function love.load()
    love.graphics.setDefaultFilter("nearest")

    local targetWidth, targetHeight = love.graphics.getDimensions()
    renderer.setup(sourceWidth, sourceHeight, targetWidth, targetHeight, true)

    bomb = {
        x=10, y=10, width=300, height=160, moduleOffset=10,

        modules = {
            {width = 65, height = 65},
            {width = 65, height = 65},
            {width = 65, height = 65}
        }
    }
end

function love.draw()
    renderer.beginDraw()

    renderer.drawBomb(bomb)

    renderer.endDraw()
end