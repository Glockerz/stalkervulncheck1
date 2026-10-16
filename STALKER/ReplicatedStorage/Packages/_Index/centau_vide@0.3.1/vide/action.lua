-- Decompiled with Potassium's decompiler.

local table_freeze_ret = table.freeze({});

local function is_action(p1) -- Line: 8
    -- upvalues: table_freeze_ret (copy)
    return getmetatable(p1) == table_freeze_ret;
end;

local function action(p2: function, p3: number?) -- Line: 12
    -- upvalues: table_freeze_ret (copy)
    local v4 = {
        priority = p3 or 1,
        callback = p2
    };
    setmetatable(v4, table_freeze_ret);

    return table.freeze(v4);
end;

return function() -- Line: 23
    -- upvalues: action (copy), is_action (copy)
    return action, is_action;
end;