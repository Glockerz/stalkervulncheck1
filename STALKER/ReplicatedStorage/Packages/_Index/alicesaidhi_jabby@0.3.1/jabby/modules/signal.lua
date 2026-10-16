-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.connect(u2: table, u3: function) -- Line: 25
    local v4 = type(u3) == "function";
    assert(v4);
    u2.callbacks[u3] = true;

    return {
        disconnect = function() -- Line: 30, Name: disconnect
            -- upvalues: u2 (copy), u3 (copy)
            u2.callbacks[u3] = nil;
        end,

        reconnect = function() -- Line: 31, Name: reconnect
            -- upvalues: u2 (copy), u3 (copy)
            u2.callbacks[u3] = true;
        end
    };
end;

function u1.fire(p5: table, ...) -- Line: 35
    for i in p5.callbacks do
        i(...);
    end;
end;

function u1.once(p6: table, u7: function) -- Line: 41
    local u8 = nil;
    u8 = p6:connect(function(...) -- Line: 43
        -- upvalues: u8 (ref), u7 (copy)
        u8:disconnect();
        u7(...);
    end);

    return u8;
end;

function u1.wait(p9: table) -- Line: 51
    local coroutine_running_ret = coroutine.running();
    local v10 = p9:connect(function(...) -- Line: 54
        -- upvalues: coroutine_running_ret (copy)
        coroutine.resume(coroutine_running_ret, ...);
    end);
    local v11 = { coroutine.yield() };
    v10:disconnect();

    return unpack(v11);
end;

return function() -- Line: 60, Name: new_signal
    -- upvalues: u1 (copy)
    local u12 = setmetatable({
        class_name = "Signal",
        callbacks = {}
    }, u1);

    return u12, function(...) -- Line: 66, Name: fire
        -- upvalues: u12 (copy)
        for i in u12.callbacks do
            i(...);
        end;
    end;
end;