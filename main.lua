local debug = true

local renderer = require "renderer"
local geometry = require "geometry"
local bomb = require "bomb"
local timer = require "timer"
local input = require "input"
local loader = require "loader"

local menu_scene = require "scenes.menu_scene"
local credits_scene = require "scenes.credits_scene"
local game_scene = require "scenes.game_scene"
local logo_scene = require "scenes.logo_scene"

local sourceWidth, sourceHeight = 320, 180
local testBomb

local currentScene

local lastCommand = "none"

local changeScene
changeScene = function (targetScene)
    if (targetScene == "menu") then
        currentScene = menu_scene
    elseif (targetScene == "credits") then
        currentScene = credits_scene
    elseif (targetScene == "game") then
        currentScene = game_scene
    elseif (targetScene == "logo") then
        currentScene = logo_scene
    end

    currentScene.setupScene(changeScene)
end

function love.load()
    love.graphics.setDefaultFilter("nearest")

    local targetWidth, targetHeight = love.graphics.getDimensions()
    renderer.setup(sourceWidth, sourceHeight, targetWidth, targetHeight)

    changeScene("logo")

    -- testBomb = bomb.newBomb("6QDP7GEMAH", 300)
    -- bomb.addModule(testBomb, bomb.newModule("test"))
    -- bomb.addModule(testBomb, bomb.newModule("test"))
    -- bomb.addModule(testBomb, bomb.newModule("test"))
    -- bomb.addModule(testBomb, bomb.newModule("test"))
    -- bomb.addModule(testBomb, bomb.newModule("test"))
    -- bomb.addModule(testBomb, bomb.newModule("test"))

    -- loader.getLevel(1)
end

function love.update(_dt)
    --timer.updateTimer(testBomb.timer, _dt)
    command = input.getInput()
    if (command ~= lastCommand) then
        lastCommand = command
        currentScene.handleInput(command)
        print(command)
    end

    currentScene.updateScene(_dt)
end

function love.draw()
    renderer.beginDraw()
    currentScene.drawScene()
    renderer.endDraw()

    if (debug) then
        love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 0, 0)
    end
end