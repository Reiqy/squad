local timer = require "timer"

local t = {}

function t.newBomb(_serialNumber, _time)
    return {serialNumber=_serialNumber, timer=timer.newTimer(_time), modules={}}
end

function t.addModule(_bomb, _module)
    table.insert(_bomb.modules, _module)
end

function t.newModule(_type)
    return {type=_type}
end

-- Wire module

function t.newWireModule()
    local module = t.newModule("wire")
    module.red = true
    module.green = true
    module.blue = true
end

-- Password module

function t.newPasswordModule()
    local module = t.newPasswordModule()
end

return t