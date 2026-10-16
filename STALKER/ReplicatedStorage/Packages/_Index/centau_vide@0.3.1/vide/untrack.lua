-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local get_scope = require(script.Parent.graph).get_scope;

return function(p1: function) -- Line: 7, Name: untrack
    -- upvalues: get_scope (copy)
    local v2 = get_scope();

    if not v2 then
        return p1();
    end;

    local effect = v2.effect;
    v2.effect = false;
    local success, result = pcall(p1);
    v2.effect = effect;

    if not success then
        error(result, 0);
    end;

    return result;
end;