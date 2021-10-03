local timer = require "timer"

local t = {}

local rotationSpeed = 1
local scheduleCheck = true

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

function t.newModuleFromPrefab(_prefab)
    if (_prefab.type == "none") then
        return {type="none"}
    else
        return {type=_prefab.type, rotation=_prefab.rotation, rotateTo=_prefab.rotation}
    end
    return t.newModule("test")
end

function t.doAction(_bomb, _selectedModule)
    if _bomb.modules[_selectedModule].type ~= "none" then
        local toRotate = {
            _selectedModule
        }
        if (_bomb.joinedModules[_selectedModule]) then
            for i, val in ipairs(_bomb.joinedModules[_selectedModule]) do
                table.insert(toRotate, val)
            end
        end
        for i, val in ipairs(toRotate) do
            _bomb.modules[val].rotateTo = _bomb.modules[val].rotateTo + 1
            if (_bomb.modules[val].rotateTo >= 4) then
                _bomb.modules[val].rotateTo = _bomb.modules[val].rotateTo - 4
            end
        end
        scheduleCheck = true
    end
end

local function checkRules(_rules, _additionalRules, _timerOut)
    scheduleCheck = false

    local energized = {
        {type="battery"}
    }

    if (_timerOut) then
        table.insert(energized, {type="timer"})
    end

    while (true) do
        local toEnergize = {}
        for i, node in ipairs(energized) do
            for i, rule in ipairs(_rules) do
                if (node.type == rule[1].type) then
                    local check = false
                    if (node.type ~= "module") then
                        local add = true
                        for i, val in ipairs(energized) do
                            if (rule[2] == val) then
                                add = false
                                break
                            end
                        end
                        if (add) then
                            for i, val in ipairs(toEnergize) do
                                if (rule[2] == val) then
                                    add = false
                                    break
                                end
                            end
                        end
                        if (add) then
                            table.insert(toEnergize, rule[2])
                        end
                        check = true
                    else
                        if (node.number == rule[1].number and node.direction == rule[1].direction) then
                            local add = true
                            for i, val in ipairs(energized) do
                                if (rule[2] == val) then
                                    add = false
                                    break
                                end
                            end
                            if (add) then
                                for i, val in ipairs(toEnergize) do
                                    if (rule[2] == val) then
                                        add = false
                                        break
                                    end
                                end
                            end
                            if (add) then
                                table.insert(toEnergize, rule[2])
                            end
                            check = true
                        end
                    end
                    if (check and rule[2].type == "bomb") then
                        return true
                    end
                end
            end
            for i, rule in ipairs(_additionalRules) do
                if (node.type == rule[1].type) then
                    local check = false
                    if (node.number == rule[1].number and node.direction == rule[1].direction) then
                        local add = true
                        for i, val in ipairs(energized) do
                            if (rule[2] == val) then
                                add = false
                                break
                            end
                        end
                        if (add) then
                            for i, val in ipairs(toEnergize) do
                                if (rule[2] == val) then
                                    add = false
                                    break
                                end
                            end
                        end
                        if (add) then
                            table.insert(toEnergize, rule[2])
                        end
                        check = true
                    end
                    if (check and rule[2].type == "bomb") then
                        return true
                    end
                end
            end
        end
        if (table.getn(toEnergize) == 0) then
            break
        end
        for i, node in ipairs(toEnergize) do
            table.insert(energized, node)
        end
    end

    return false
end

function t.updateBomb(_bomb, _dt, _timeSpeed)
    timer.updateTimer(_bomb.timer, _timeSpeed * _dt)
    for i, module in ipairs(_bomb.modules) do
        if (module.type ~= "none") then
            if (math.abs(module.rotation - module.rotateTo) > 0.1) then
                module.rotation = module.rotation + rotationSpeed * _dt
                if (module.rotation >= 4) then
                    module.rotation = module.rotation - 4
                end
            else
                module.rotation = module.rotateTo
            end
        end
    end

    if (_bomb.timer.time <= 0) then
        scheduleCheck = true
    end

    local exploded = false
    if (scheduleCheck) then
        local rules = _bomb.rules
        local additionalRules = {}
        for i, module in ipairs(_bomb.modules) do
            local topBottomRule = {{type="module", number=i, direction="top"}, {type="module", number=i, direction="bottom"}}
            local bottomTopRule = {{type="module", number=i, direction="bottom"}, {type="module", number=i, direction="top"}}
            local leftRightRule = {{type="module", number=i, direction="left"}, {type="module", number=i, direction="right"}}
            local rightLeftRule = {{type="module", number=i, direction="right"}, {type="module", number=i, direction="left"}}

            local leftTopRule = {{type="module", number=i, direction="left"}, {type="module", number=i, direction="top"}}
            local topLeftRule = {{type="module", number=i, direction="top"}, {type="module", number=i, direction="left"}}
            local topRightRule = {{type="module", number=i, direction="top"}, {type="module", number=i, direction="right"}}
            local rightTopRule = {{type="module", number=i, direction="right"}, {type="module", number=i, direction="top"}}
            local rightBottomRule = {{type="module", number=i, direction="right"}, {type="module", number=i, direction="bottom"}}
            local bottomRightRule = {{type="module", number=i, direction="bottom"}, {type="module", number=i, direction="right"}}
            local bottomLeftRule = {{type="module", number=i, direction="bottom"}, {type="module", number=i, direction="left"}}
            local leftBottomRule = {{type="module", number=i, direction="left"}, {type="module", number=i, direction="bottom"}}
            

            if (module.type == "straight") then
                if (module.rotateTo == 1 or module.rotateTo == 3) then
                    table.insert(additionalRules, topBottomRule)
                    table.insert(additionalRules, bottomTopRule)
                elseif (module.rotateTo == 0 or module.rotateTo == 2) then
                    table.insert(additionalRules, leftRightRule)
                    table.insert(additionalRules, rightLeftRule)
                end
            elseif (module.type == "left") then
                if (module.rotateTo == 0) then
                    table.insert(additionalRules, leftTopRule)
                    table.insert(additionalRules, topLeftRule)
                elseif (module.rotateTo == 1) then
                    table.insert(additionalRules, topRightRule)
                    table.insert(additionalRules, rightTopRule)
                elseif (module.rotateTo == 2) then
                    table.insert(additionalRules, rightBottomRule)
                    table.insert(additionalRules, bottomRightRule)
                elseif (module.rotateTo == 3) then
                    table.insert(additionalRules, bottomLeftRule)
                    table.insert(additionalRules, leftBottomRule)
                end
            elseif (module.type == "doubleLeft") then
                if (module.rotateTo == 0 or module.rotateTo == 2) then
                    table.insert(additionalRules, leftTopRule)
                    table.insert(additionalRules, topLeftRule)
                    table.insert(additionalRules, rightBottomRule)
                    table.insert(additionalRules, bottomRightRule)
                elseif (module.rotateTo == 1 or module.rotateTo == 3) then
                    table.insert(additionalRules, leftBottomRule)
                    table.insert(additionalRules, bottomLeftRule)
                    table.insert(additionalRules, rightTopRule)
                    table.insert(additionalRules, topRightRule)
                end
            end
        end
        exploded = checkRules(rules, additionalRules, _bomb.timer.time <= 0)
    end

    if (exploded) then
        return "explode"
    elseif (_bomb.timer.time <= 0) then
        return "win"
    end
    return "none"
end

return t