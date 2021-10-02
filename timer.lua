local t = {}

function t.newTimer(_time)
    return {time=_time}
end

function t.updateTimer(_timer, _dt)
    _timer.time = _timer.time - _dt
end

return t