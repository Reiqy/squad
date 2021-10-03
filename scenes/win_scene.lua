local renderer = require "renderer"

local t = {}

local changeScene

function t.setupScene(_changeScene)
    changeScene = _changeScene
end

function t.handleInput(_command)
    if (_command == "escape" or _command == "enter") then
        changeScene("menu")
    end
end

function t.updateScene(_dt)
end

function t.drawScene()
    renderer.print("Wow! You have ", 16, 16)
    renderer.print("WON", 84, 16, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("the game!", 106, 16)
    renderer.print("I hope you are feeling proud.", 16, 26)
    renderer.print("You surely deserve this.", 16, 36)
    renderer.print("I would personally sign you a bomb expert certificate,", 16, 46)
    renderer.print("but we had some legal problems with this.", 16, 56)
    renderer.print("Friendly advice: Don't try this at home.", 16, 66)
    renderer.print("Bombs really are", 16, 76)
    renderer.print("unstable", 100, 76, 217 / 255, 87 / 255, 99 / 255)
    renderer.print(".", 140, 76)

    renderer.print("Press", 16, 100)
    renderer.print("[ESCAPE]", 48, 100, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("or", 90, 100)
    renderer.print("[B]", 106, 100, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("to return to main menu.", 124, 100)
end

return t