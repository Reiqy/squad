local t = {}

t.serialNumber = "C9DNBO"

t.time = 62

t.bg = "res/sprites/bg_level_3.png"

t.modules = {
    {type="doubleLeft", rotation=0},
    {type="doubleLeft", rotation=0},
    {type="straight", rotation=1},
    {type="doubleLeft", rotation=0},
    {type="left", rotation=0},
    {type="straight", rotation=0},
}

t.rules = {
    {
        {type="timer"},
        {type="module", number=1, direction="top"}
    },
    {
        {type="module", number=1, direction="right"},
        {type="module", number=2, direction="left"},
    },
    {
        {type="module", number=1, direction="left"},
        {type="module", number=4, direction="left"}
    },
    {
        {type="module", number=1, direction="bottom"},
        {type="module", number=4, direction="top"}
    },
    {
        {type="module", number=2, direction="left"},
        {type="module", number=1, direction="right"}
    },
    {
        {type="module", number=2, direction="top"},
        {type="module", number=3, direction="top"}
    },
    {
        {type="module", number=2, direction="right"},
        {type="module", number=3, direction="left"}
    },
    {
        {type="module", number=2, direction="bottom"},
        {type="module", number=5, direction="top"}
    },
    {
        {type="module", number=3, direction="left"},
        {type="module", number=2, direction="right"}
    },
    {
        {type="module", number=3, direction="top"},
        {type="module", number=2, direction="top"}
    },
    {
        {type="module", number=3, direction="right"},
        {type="bomb"}
    },
    {
        {type="module", number=3, direction="bottom"},
        {type="bomb"}
    },
    {
        {type="module", number=4, direction="left"},
        {type="module", number=1, direction="left"}
    },
    {
        {type="module", number=4, direction="top"},
        {type="module", number=1, direction="bottom"}
    },
    {
        {type="module", number=4, direction="right"},
        {type="module", number=5, direction="left"}
    },
    {
        {type="module", number=5, direction="left"},
        {type="module", number=4, direction="right"}
    },
    {
        {type="module", number=5, direction="top"},
        {type="module", number=2, direction="bottom"}
    },
    {
        {type="module", number=5, direction="right"},
        {type="module", number=6, direction="left"}
    },
    {
        {type="module", number=6, direction="left"},
        {type="module", number=5, direction="right"}
    },
    {
        {type="module", number=6, direction="right"},
        {type="bomb"}
    },
    {
        {type="battery"},
        {type="module", number=4, direction="bottom"}
    },
}

t.joinedModules = {
    {},
    {5},
    {},
    {},
    {2},
    {}
}

t.lines = {
}

return t