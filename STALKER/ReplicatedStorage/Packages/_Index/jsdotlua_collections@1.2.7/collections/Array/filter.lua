-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function, p3: any) -- Line: 10
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        if typeof(p1) ~= "table" then
            error(string.format("Array.filter called on %s", (typeof(p1))));
        end;

        if typeof(p2) ~= "function" then
            error("callback is not a function");
        end;
    end;

    local v4 = #p1;
    local v5 = {};
    local v6 = 1;

    if p3 == nil then
        for i = 1, v4 do
            local v7 = p1[i];
            local v8;

            if v7 == nil or not p2(v7, i, p1) then
                v8 = i;
            else
                v5[v6] = v7;
                v6 = v6 + 1;
                v8 = i;
            end;
        end;

        return v5;
    end;

    for i = 1, v4 do
        local v9 = p1[i];
        local v10;

        if v9 == nil or not p2(p3, v9, i, p1) then
            v10 = i;
        else
            v5[v6] = v9;
            v6 = v6 + 1;
            v10 = i;
        end;
    end;

    return v5;
end;