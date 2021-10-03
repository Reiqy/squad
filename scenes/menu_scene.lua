local renderer = require "renderer"
local game_scene = require "scenes.game_scene"
local resources = require "resources"

local t = {}

local changeScene

local function onButtonPlay()
    changeScene("game")
end

local function onButtonCredits()
    changeScene("credits")
end

local function onButtonExit()
    love.event.quit()
end

local buttons = {
    {text="Play", action=onButtonPlay, selected=false},
    {text="Credits", action=onButtonCredits, selected=false},
    {text="Exit", action=onButtonExit, selected=false}
}

local selectedButton
local convertedToText = false

local assetsLoaded = false
local background

local function changeSelectedButton(_newSelectedButton)
    if selectedButton then
        buttons[selectedButton].selected = false
    end
    selectedButton = _newSelectedButton
    buttons[selectedButton].selected = true
end

function t.setupScene(_changeScene)
    changeScene = _changeScene

    changeSelectedButton(1)
    font = renderer.getFont()
    if (not convertedToText) then
        convertedToText = true
        for i, button in ipairs(buttons) do
            button.text = love.graphics.newText(font, button.text)
        end
    end
    print(game_scene.level)
    if (game_scene.level) then
        buttons[1].additionalText = love.graphics.newText(font, " (Level " .. tostring(game_scene.level) .. ")")
    end

    if (not assetsLoaded) then
        background = love.graphics.newImage(resources.backgrounds.menu)
    end
end

function t.handleInput(_command)
    local buttonToSelect = selectedButton
    if (_command == "up") then
        buttonToSelect = buttonToSelect - 1
    elseif (_command == "down") then
        buttonToSelect = buttonToSelect + 1
    elseif (_command == "enter") then
        buttons[selectedButton].action()
    elseif (_command == "escape") then
        onButtonExit()
    end

    if (buttonToSelect > table.getn(buttons)) then
        buttonToSelect = 1
    elseif (buttonToSelect == 0) then
        buttonToSelect = table.getn(buttons)
    end

    if (buttonToSelect ~= selectedButton) then
        changeSelectedButton(buttonToSelect)
    end
end

function t.updateScene(_dt)
end

function t.drawScene()
    love.graphics.draw(background, 0, 0)
    for i, button in ipairs(buttons) do
        r, g, b, a = love.graphics.getColor()
        if (button.selected) then
            love.graphics.setColor(172 / 255, 50 / 255, 50 / 255)
        end

        love.graphics.draw(button.text, 20, (i - 1) * 32)
        if (button.additionalText) then
            love.graphics.draw(button.additionalText, 20 + button.text:getWidth(), (i - 1) * 32)
        end

        love.graphics.setColor(r, g, b, a)
    end
end

return t