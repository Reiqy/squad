local t = {}

local currentLevel = 1

function t.setLevel(_level)
    currentLevel = _level
end

function t.getLevel(_level)
    local level = require "levels.level_" .. tostring(_level)
    return level
end

function t.getNextLevel()
    local level = require "levels.level_" .. tostring(currentLevel)
    currentLevel = currentLevel + 1
    return level
end

return t