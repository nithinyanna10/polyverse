-- Utility functions
local utils = {}

function utils.timestamp()
    return os.time()
end

function utils.format_date(timestamp)
    return os.date("%Y-%m-%d %H:%M:%S", timestamp)
end

function utils.uuid()
    return string.format("%08x-%04x-%04x-%04x-%012x",
        math.random(0, 0xffffffff),
        math.random(0, 0xffff),
        math.random(0, 0xffff),
        math.random(0, 0xffff),
        math.random(0, 0xffffffffffff))
end

return utils

