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
local testBackground
local bombBackground

local levelBackground

local selectedModule = 0

local timeSpeed = 1

local endState = false

local lines = {}

t.level = nil

local function unpackLevel(_level)
    unpackedBomb = bomb.newBomb(_level.serialNumber, _level.time)
    levelBackground = love.graphics.newImage(_level.bg)

    for i, module in ipairs(_level.modules) do
        bomb.addModule(unpackedBomb, bomb.newModuleFromPrefab(module))
        if (module.type ~= "none" and selectedModule == 0) then
            selectedModule = i
        end
    end

    unpackedBomb.rules = {}
    for i, rule in ipairs(_level.rules) do
        table.insert(unpackedBomb.rules, rule)
    end

    unpackedBomb.joinedModules = _level.joinedModules

    lines = _level.lines

    timeSpeed = 1
    endState = false
end

function t.setupScene(_changeScene)
    changeScene = _changeScene

    if (not assetsLoaded) then
        assetsLoaded = true

        blueprintBackground = love.graphics.newImage(resources.backgrounds.blueprint)
        testBackground = love.graphics.newImage(resources.backgrounds.test)
        bombBackground = love.graphics.newImage(resources.backgrounds.bomb)
    end

    t.level = t.level or 1

    if (t.level <= 3) then
        unpackLevel(loader.getLevel(t.level))
    end
end

function t.handleInput(_command)
    if (_command == "escape") then
        changeScene("menu")
    elseif (_command == "up") or (_command == "down") then
        if (_command == "up") then
            selectedModule = selectedModule - 3
        elseif (_command == "down") then
            selectedModule = selectedModule + 3
        end
        if (selectedModule <= 0) then
            selectedModule = selectedModule + 6
        elseif (selectedModule > 6) then
            selectedModule = selectedModule - 6
        end
    elseif (_command == "left") or (_command == "right") then
        if (_command == "left") then
            selectedModule = selectedModule - 1
        elseif (_command == "right") then
            selectedModule = selectedModule + 1
        end
        if (selectedModule <= 0) then
            selectedModule = selectedModule + 3
        elseif (selectedModule > 6) then
            selectedModule = selectedModule - 3
        end
    elseif (_command == "enter") then
        bomb.doAction(unpackedBomb, selectedModule)
    elseif (_command == "space") then
        timeSpeed = 20
    end
end

local function win()
    t.level = t.level + 1
    if (t.level > 3) then
        changeScene("win")
    else
        changeScene("game")
    end
end

local function explode()
    changeScene("lose")
end

function t.updateScene(_dt)
    if (unpackedBomb) then
        local result = bomb.updateBomb(unpackedBomb, _dt, timeSpeed)
        if (result ~= "none") then
            if (result == "win") then
                win()
            elseif (result == "explode") then
                explode()
            end
        end
    end
end

local function drawBombScene(_selectedModule)
    love.graphics.draw(bombBackground, 0, 0)
    if (unpackedBomb) then
        renderer.drawBomb(unpackedBomb, _selectedModule)
    end
    if (levelBackground) then
        love.graphics.draw(levelBackground, 0, 0)
    end
end

-- local function drawBlueprintScene()
--     love.graphics.draw(blueprintBackground, 0, 0)
-- end

function t.drawScene()
    drawBombScene(selectedModule)
    for i, text in ipairs(lines) do
        renderer.print(text, 32, 100 + (i - 1) * 16, 69 / 255, 40 / 255, 60 / 255)
    end
end

return t