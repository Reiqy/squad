local geometry = require "geometry"
local resources = require "resources"

local t = {}

local transform, canvas
local textToRender = {}
local defaultFont, font

local assetsLoaded = false
local moduleStraight
local moduleRight
local moduleLeft
local moduleDoubleRight
local moduleDoubleLeft

local modules = {}


local moduleSelector

function t.setup(_sourceWidth, _sourceHeight, _targetWidth, _targetHeight)
    transform = love.math.newTransform()
    transform:scale(_targetWidth / _sourceWidth, _targetHeight / _sourceHeight)

    canvas = love.graphics.newCanvas(_sourceWidth, _sourceHeight)

    defaultFont = love.graphics.getFont()
    font = love.graphics.newFont(resources.fonts.bitPotion, 48)

    if (not assetsLoaded) then
        assetsLoaded = true
        moduleStraight = love.graphics.newImage(resources.sprites.moduleStraight)
        moduleRight = love.graphics.newImage(resources.sprites.moduleRight)
        moduleLeft = love.graphics.newImage(resources.sprites.moduleLeft)
        moduleDoubleRight = love.graphics.newImage(resources.sprites.moduleDoubleRight)
        moduleDoubleLeft = love.graphics.newImage(resources.sprites.moduleDoubleLeft)

        moduleSelector = love.graphics.newImage(resources.sprites.moduleSelector)

        modules = {
            straight=moduleStraight,
            left=moduleLeft,
            right=moduleRight,
            doubleLeft=moduleDoubleLeft,
            doubleRight=moduleDoubleRight
        }
    end
end

function t.getFont()
    return font
end

function t.beginDraw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.setFont(font)
end

local function drawText()
    for _, text in ipairs(textToRender) do
        local x, y = transform:transformPoint(text.position.x, text.position.y)
        r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(text.r, text.g, text.b)
        love.graphics.print(text.text, x, y)
        love.graphics.setColor(r, g, b, a)
    end
    textToRender = {}
end

local function draw()
    love.graphics.draw(canvas, transform)

    drawText()
end

function t.endDraw()
    love.graphics.setCanvas()
    draw()
    love.graphics.setFont(defaultFont)
end

function t.print(_text, _x, _y, _r, _g, _b)
    _r = _r or 1
    _g = _g or 1
    _b = _b or 1
    local x, y = love.graphics.transformPoint(_x, _y)
    table.insert(textToRender, {text=_text, position=geometry.newVec2(x, y), r=_r, g=_g, b=_b})
end

-- Bomb

local function drawBombModule(_module)
    if (_module.type == "test") then
        local r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", 0, 0, 64, 64)
        love.graphics.setColor(r, g, b, a)
        t.print("Test", 32, 32)
    elseif (_module.type ~= "none") then
        love.graphics.push()
        love.graphics.translate(32, 32)
        love.graphics.rotate(_module.rotation * math.pi / 2)
        love.graphics.translate(-32, -32)
        love.graphics.draw(modules[_module.type], 0, 0)
        love.graphics.pop()
    end
end

local function drawBombModules(_modules, _selectedModule)
    for i, module in ipairs(_modules) do
        love.graphics.push()

        local column = math.floor((i - 1) % 3)
        local row = math.floor((i - 1) / 3)

        local x = column * (64 + 16)
        local y = row * (64 + 8)

        love.graphics.translate(x, y)

        drawBombModule(module)

        if (i == _selectedModule) then
            love.graphics.draw(moduleSelector, 0, 0)
        end

        love.graphics.pop()
    end
end

local function drawBombCase(_bomb, _selectedModule)
    love.graphics.push()
    love.graphics.translate(16, 8)
    drawBombModules(_bomb.modules, _selectedModule)
    love.graphics.pop()
end

local function timeToDisplay(_time)
    local minutes = math.floor(_time / 60)
    local seconds = math.floor(_time % 60)

    local minutesStr, secondsStr = "", ""

    if (minutes < 10) then
        minutesStr = minutesStr .. "0"
    end
    minutesStr = minutesStr .. tostring(minutes)

    if (seconds < 10) then
        secondsStr = secondsStr .. "0"
    end
    secondsStr = secondsStr .. tostring(seconds)

    return minutesStr, secondsStr
end

local function drawTimer(_timer)
    local minutes, seconds = timeToDisplay(_timer.time)
    t.print(minutes .. ":" .. seconds, 0, 0, 153 / 255, 229 / 255, 80 / 255)
end

function t.drawBomb(_bomb, _selectedModule)
    love.graphics.push()
    love.graphics.translate(16, 8)
    drawBombCase(_bomb, _selectedModule)
    love.graphics.push()
    love.graphics.translate(16, 151)
    t.print("S/N: " .. _bomb.serialNumber, 0, 0, 69 / 255, 40 / 255, 60 / 255)
    love.graphics.pop()
    love.graphics.push()
    love.graphics.translate(265, 6)
    drawTimer(_bomb.timer)
    love.graphics.pop()
    love.graphics.pop()
end

-- Blueprint

function t.drawBlueprint(_bomb)
end

return t