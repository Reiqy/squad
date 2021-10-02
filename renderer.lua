local t = {}

local transform, canvas, showFPS

function t.setup(sourceWidth, sourceHeight, targetWidth, targetHeight, debug)
    showFPS = debug or false

    transform = love.math.newTransform()
    transform:scale(targetWidth / sourceWidth, targetHeight / sourceHeight)

    canvas = love.graphics.newCanvas(sourceWidth, sourceHeight)
end

function t.beginDraw()
    love.graphics.setCanvas(canvas)
end

local function draw()
    love.graphics.draw(canvas, transform)

    if (showFPS) then
        love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 0, 0)
    end
end

function t.endDraw()
    love.graphics.setCanvas()
    draw()
end

-- Bomb

local function drawBombModule(position, module, bombX, bombY, bombWidth, bombHeight, bombModuleOffset)
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0)

    local horizontalModuleSpace = math.floor((bombWidth - 2 * bombModuleOffset) / 3)
    local verticalModuleSpace = (bombHeight - 2 * bombModuleOffset) / 2
    local x = (position - 1) * horizontalModuleSpace + math.floor((horizontalModuleSpace - module.width) / 2) + (bombX + bombModuleOffset)
    local row = 0
    --if (position > 3) then
    --    row = 1
    --end
    local y = verticalModuleSpace * row + math.floor((horizontalModuleSpace - module.height / 2)) + (bombY + bombModuleOffset)
    love.graphics.rectangle("fill", x, y, module.width, module.height)

    love.graphics.setColor(r, g, b, a)
end

local function drawBombCase(bomb)
    love.graphics.rectangle("fill", bomb.x, bomb.y, bomb.width, bomb.height)

    for i, module in ipairs(bomb.modules) do
        drawBombModule(i, module, bomb.x, bomb.y, bomb.width, bomb.height, bomb.moduleOffset)
    end
end

function t.drawBomb(bomb)
    drawBombCase(bomb)
end

return t