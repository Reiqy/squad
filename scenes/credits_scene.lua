local renderer = require "renderer"

local t = {}

local changeScene

function t.setupScene(_changeScene)
    changeScene = _changeScene
end

function t.handleInput(_command)
    if (_command == "escape") then
        changeScene("menu")
    end
end

function t.updateScene(_dt)
end

function t.drawScene()
    renderer.print("Made by", 16, 16)
    renderer.print("Reiqy", 58, 16, 217 / 255, 87 / 255, 99 / 255)
    renderer.print(" for Ludum Dare 49.", 80, 16)
    renderer.print("I would love to hear your feedback.", 16, 26)
    renderer.print("This game was made with", 16, 42)
    renderer.print("LÖVE", 136, 42, 217 / 255, 87 / 255, 99 / 255)
    renderer.print(", an awesome framework you can", 156, 42)
    renderer.print("use to make 2D games in Lua.", 16, 52)
    renderer.print("This project uses", 16, 68)
    renderer.print("BitPotion", 98, 68, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("font by Joeb Rogers.", 144, 68)

    renderer.print("Press", 16, 100)
    renderer.print("[ESCAPE]", 48, 100, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("or", 90, 100)
    renderer.print("[B]", 106, 100, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("to return to main menu.", 124, 100)
end

return t