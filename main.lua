local debug = false

local renderer = require "renderer"
local geometry = require "geometry"
local bomb = require "bomb"
local timer = require "timer"
local input = require "input"
local loader = require "loader"
local resources = require "resources"

local menu_scene = require "scenes.menu_scene"
local credits_scene = require "scenes.credits_scene"
local game_scene = require "scenes.game_scene"
local logo_scene = require "scenes.logo_scene"
local lose_scene = require "scenes.lose_scene"
local win_scene = require "scenes.win_scene"

local sourceWidth, sourceHeight = 320, 180
local targetWidth, _targetHeight
local testBomb

local currentScene
local oldScene

local lastCommand = "none"

local transitionPhase = "none"
local transitionCurrentAlpha = 1
local transtionAlphaChangeSpeed = 0.8
local transitionTime = 0

local music
local playMusic = true

local changeScene
changeScene = function (_targetScene, _doTransition, _onlyDecrease)
    if (_doTransition == nil or _doTransition) then
        _doTransition = true
        oldScene = currentScene
        transitionPhase = "increase"
    end

    if (_onlyDecrease) then
        transitionCurrentAlpha = 0
        transitionPhase = "decrease"
    end

    if (_targetScene == "menu") then
        if (currentScene and currentScene == win_scene) then
            game_scene.level = nil
        end
        currentScene = menu_scene
    elseif (_targetScene == "credits") then
        currentScene = credits_scene
    elseif (_targetScene == "game") then
        currentScene = game_scene
    elseif (_targetScene == "logo") then
        currentScene = logo_scene
    elseif (_targetScene == "lose") then
        currentScene = lose_scene
    elseif (_targetScene == "win") then
        currentScene = win_scene
    end

    currentScene.setupScene(changeScene)
end

function love.load()
    love.graphics.setDefaultFilter("nearest")
    targetWidth, targetHeight = love.graphics.getDimensions()
    renderer.setup(sourceWidth, sourceHeight, targetWidth, targetHeight)

    changeScene("logo", false)

    music = love.audio.newSource(resources.music.main, "static")
end

function love.update(_dt)
    command = input.getInput()
    if (command ~= lastCommand) then
        lastCommand = command
        if (command == "music") then
            playMusic = not playMusic
        elseif (command == "debug") then
            debug = not debug
        else
            currentScene.handleInput(command)
        end
    end

    if (transitionPhase ~= "none") then
        if (transitionPhase == "decrease") then
            transitionCurrentAlpha = transitionCurrentAlpha - transtionAlphaChangeSpeed * _dt
            if (transitionCurrentAlpha <= 0) then
                transitionCurrentAlpha = 0
                transitionPhase = "none"
            end
        elseif (transitionPhase == "increase") then
            transitionCurrentAlpha = transitionCurrentAlpha + transtionAlphaChangeSpeed * _dt
            if (transitionCurrentAlpha >= 1) then
                transitionCurrentAlpha = 1
                transitionPhase = "stay"
            end
        elseif (transitionPhase == "stay") then
            transitionTime = transitionTime + _dt
            if (transitionTime >= 0.2) then
                transitionTime = 0
                transitionPhase = "decrease"
            end
        end
    end

    if (not music:isPlaying() and playMusic and not currentScene.doNotPlayAudio) then
        love.audio.play(music)
    end
    if (music:isPlaying() and not playMusic) then
        love.audio.pause(music)
    end

    currentScene.updateScene(_dt)

    if (currentScene.endMusic) then
        playMusic = false
    end
end

function love.draw()
    renderer.beginDraw()

    if (transitionPhase == "increase") then
        if (oldScene) then
            oldScene.drawScene()
        end
    else
        currentScene.drawScene()
    end

    renderer.endDraw()

    if (transitionPhase ~= "none") then
        local r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(0, 0, 0, transitionCurrentAlpha)
        local w, h = love.graphics.getDimensions()
        love.graphics.rectangle("fill", 0, 0, targetWidth, targetHeight)
        love.graphics.setColor(r, g, b, a)
    elseif (currentScene.doTransition) then
        local r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(0, 0, 0, currentScene.currentAlpha)
        local w, h = love.graphics.getDimensions()
        love.graphics.rectangle("fill", 0, 0, targetWidth, targetHeight)
        love.graphics.setColor(r, g, b, a)
    end

    if (debug) then
        love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 0, 0)
    end
end