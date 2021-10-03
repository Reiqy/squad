local renderer = require "renderer"
local loader = require "loader"
local bomb = require "bomb"
local timer = require "timer"
local resources = require "resources"

local t = {}

local changeScene

local unpackedBomb

local assetsLoaded = false
local blueprintBackground

local view = "blueprint"

t.level = nil

local function unpackLevel(_level)
    unpackedBomb = bomb.newBomb(_level.serialNumber, _level.time)

    for i, module in ipairs(_level.modules) do
        bomb.addModule(unpackedBomb, bomb.newModuleFromPrefab(module))
    end
end

function t.setupScene(_changeScene)
    changeScene = _changeScene

    t.level = 1

    if (not assetsLoaded) then
        assetsLoaded = true

        blueprintBackground = love.graphics.newImage(resources.backgrounds.blueprint)
    end

    unpackLevel(loader.getLevel(t.level))
end

function t.handleInput(_command)
    if (_command == "escape") then
        changeScene("menu")
    end
end

function t.updateScene(_dt)
    if (unpackedBomb) then
        timer.updateTimer(unpackedBomb.timer, _dt)
    end
end

local function drawBombScene()
    if (unpackedBomb) then
        renderer.drawBomb(unpackedBomb)
    end
end

local function drawBlueprintScene()
    love.graphics.draw(blueprintBackground, 0, 0)
end

function t.drawScene()
    if (view == "bomb") then
        drawBombScene()
    elseif (view == "blueprint") then
        drawBlueprintScene()
    end
end

return t