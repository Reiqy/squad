local t = {}

local joystick = love.joystick.getJoysticks()[1]

function t.getInput()
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") or (joystick ~= nil and (joystick:getAxis(1) < -0.5 or joystick:getHat(1) == "l")) then
        return "left"
    end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") or (joystick ~= nil and (joystick:getAxis(1) > 0.5 or joystick:getHat(1) == "r")) then
        return "right"
    end
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") or (joystick ~= nil and (joystick:getAxis(2) < -0.5 or joystick:getHat(1) == "u")) then
        return "up"
    end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") or (joystick ~= nil and (joystick:getAxis(2) > 0.5 or joystick:getHat(1) == "d")) then
        return "down"
    end
    if love.keyboard.isDown("m") then
        return "music"
    end
    if love.keyboard.isDown("f12") then
        return "debug"
    end
    if love.keyboard.isDown("return") or love.keyboard.isDown("kpenter") or (joystick ~= nil and (joystick:isDown(1) or joystick:isDown(3))) then
        return "enter"
    end
    if love.keyboard.isDown("space") or (joystick ~= nil and joystick:isDown(4)) then
        return "space"
    end
    if love.keyboard.isDown("escape") or (joystick ~= nil and joystick:isDown(2)) then
        return "escape"
    end
    return "none"
end

return t