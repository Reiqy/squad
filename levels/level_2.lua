local t = {}

t.serialNumber = "E0YYL5"

t.time = 62

t.bg = "res/sprites/bg_level_2.png"

t.modules = {
    {type="none"},
    {type="none"},
    {type="straight", rotation=1},
    {type="none"},
    {type="none"},
    {type="left", rotation=1},
}

t.rules = {
    {
        {type="timer"},
        {type="module", number=3, direction="top"}
    },
    {
        {type="battery"},
        {type="module", number=3, direction="right"}
    },
    {
        {type="module", number=3, direction="left"},
        {type="bomb"}
    },
    {
        {type="module", number=3, direction="bottom"},
        {type="module", number=6, direction="top"}
    },
    {
        {type="module", number=6, direction="right"},
        {type="bomb"}
    }
}

t.joinedModules = {}

t.lines = {}

return t