local t = {}

t.serialNumber = "MPZ8Z5"

t.time = 600

t.sources = {
    {type="timer", strength=1},
    {type="battery", strength=1}
}

t.output = {
    {type="detonator", min=1, max=1}
}

t.modules = {
    {
        type="cut",
        count=2,
        binding={
            {1, 1},
            {2, 2}
        }
    }
}

t.connections = {
    {
        {type="source", name="timer"},
        {type="module", position=1, pin=1}
    },
    {
        {type="source", "battery"},
        {type="module", position=1, pin=2}
    },
    {
        {type="module", position=1, pin=1},
        {type="output", "detonator"}
    },
    {
        {type="module", position=1, pin=2},
        {type="output", "detonator"}
    }
}

return t