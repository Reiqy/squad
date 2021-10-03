local t = {}

t.serialNumber = "MPZ8Z5"

t.time = 62

t.bg = "res/sprites/bg_level_1.png"

t.modules = {
    {type="none"},
    {type="none"},
    {type="straight", rotation=1},
    {type="none"},
    {type="none"},
    {type="none"},
}

t.rules = {
    {
        {type="timer"},
        {type="module", number=3, direction="top"}
    },
    {
        {type="module", number=3, direction="bottom"},
        {type="bomb"}
    }
}

t.joinedModules = {}

t.lines = {
    "Press [ENTER] or [X] or [A] to rotate object.",
    "Press [SPACE] to speed up time."
}

return t