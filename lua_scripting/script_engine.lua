-- Script execution engine
local ScriptEngine = {}

function ScriptEngine.execute(code, context)
    -- Sandboxed execution environment
    local env = {
        math = math,
        string = string,
        table = table,
        os = {
            time = os.time,
            date = os.date
        },
        context = context or {}
    }
    
    local func, err = load(code, "script", "t", env)
    if not func then
        return nil, err
    end
    
    local success, result = pcall(func)
    if not success then
        return nil, result
    end
    
    return result
end

function ScriptEngine.validate(code)
    local func, err = load(code, "script", "t", {})
    return func ~= nil, err
end

return ScriptEngine

