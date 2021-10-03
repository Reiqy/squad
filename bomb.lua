local timer = require "timer"

local t = {}

function t.newBomb(_serialNumber, _time)
    return {
        serialNumber=_serialNumber,
        timer=timer.newTimer(_time),
        sources={},
        modules={}
    }
end

function t.addModule(_bomb, _module)
    table.insert(_bomb.modules, _module)
end

function t.newModule(_type)
    return {type=_type}
end

local function newCutModule(_prefab)
    local module = t.newModule("cut")

    return module
end

function t.newModuleFromPrefab(_prefab)
    if (_prefab.type == "cut") then
        return newCutModule(_prefab)
    end
    return t.newModule("test")
end

return t