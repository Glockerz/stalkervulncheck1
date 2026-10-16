-- Decompiled with Potassium's decompiler.

local function provide(u1: table, u2: function) -- Line: 23
    return function(p3: userdata) -- Line: 24
        -- upvalues: u1 (copy), u2 (copy)
        local coroutine_running_ret = coroutine.running();
        local v4 = u1._values[coroutine_running_ret];
        u1._values[coroutine_running_ret] = p3;
        local success, result = pcall(u2);
        u1._values[coroutine_running_ret] = v4;

        if not success then
            error(`provided callback errored with "{result}"`, 2);
        end;

        return result;
    end;
end;

local function consume(p5: table) -- Line: 42
    local coroutine_running_ret = coroutine.running();

    return p5._values[coroutine_running_ret] or p5.default_value;
end;

return function(p6) -- Line: 47, Name: create_context
    -- upvalues: provide (copy), consume (copy)
    return {
        default_value = p6,
        _values = {},
        provide = provide,
        consume = consume
    };
end;