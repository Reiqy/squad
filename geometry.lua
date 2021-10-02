local t = {}

function t.newVec2(_x, _y)
    local x = _x
    local y = _y or _x
    return {x=x, y=y}
end

return t