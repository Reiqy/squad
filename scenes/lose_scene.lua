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
    if (_command == "space" or _command == "enter") then
        changeScene("game")
    end
end

function t.updateScene(_dt)
end

function t.drawScene()
    renderer.print("Your bomb unfortunately", 16, 16)
    renderer.print("EXPLODED", 136, 16, 217 / 255, 87 / 255, 99 / 255)
    renderer.print(".", 176, 16)
    renderer.print("If you're not sure what happened, you probably", 16, 26)
    renderer.print("connected battery to the detonator.", 16, 36)
    renderer.print("Don't worry, happens to the best of us.", 16, 46)
    renderer.print("Friendly advice: Don't try this at home.", 16, 56)
    renderer.print("Bombs really are", 16, 66)
    renderer.print("unstable", 100, 66, 217 / 255, 87 / 255, 99 / 255)
    renderer.print(".", 140, 66)

    renderer.print("Press", 16, 100)
    renderer.print("[ESCAPE]", 48, 100, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("or", 90, 100)
    renderer.print("[B]", 106, 100, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("to return to main menu.", 124, 100)
    renderer.print("Press", 16, 116)
    renderer.print("[ENTER]", 48, 116, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("or", 84, 116)
    renderer.print("[X]", 100, 116, 217 / 255, 87 / 255, 99 / 255)
    renderer.print("to try again.", 118, 116)
end

return t