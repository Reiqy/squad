local renderer = require "renderer"
local geometry = require "geometry"
local bomb = require "bomb"
local timer = require "timer"
local input = require "input"

local sourceWidth, sourceHeight = 320, 180
local testBomb

local scene = "menu"

local lastCommand = "none"

function love.load()
    love.graphics.setDefaultFilter("nearest")

    local targetWidth, targetHeight = love.graphics.getDimensions()
    renderer.setup(sourceWidth, sourceHeight, targetWidth, targetHeight)

    testBomb = bomb.newBomb("6QDP7GEMAH", 300)
    bomb.addModule(testBomb, bomb.newModule("test"))
    bomb.addModule(testBomb, bomb.newModule("test"))
    bomb.addModule(testBomb, bomb.newModule("test"))
    bomb.addModule(testBomb, bomb.newModule("test"))
    bomb.addModule(testBomb, bomb.newModule("test"))
    bomb.addModule(testBomb, bomb.newModule("test"))
end

local function handleInput(_input)
end

function love.update(_dt)
    timer.updateTimer(testBomb.timer, _dt)
    command = input.getInput()
    if (command ~= lastCommand) then
        lastCommand = command
        handleInput(command)
        print(command)
    end
end

function love.draw()
    renderer.beginDraw()

    renderer.drawBomb(testBomb)

    renderer.endDraw()
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 0, 0)
end