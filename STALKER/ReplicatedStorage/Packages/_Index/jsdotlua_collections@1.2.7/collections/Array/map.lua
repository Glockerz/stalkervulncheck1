-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function, p3: any) -- Line: 10
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        if typeof(p1) ~= "table" then
            error(string.format("Array.map called on %s", (typeof(p1))));
        end;

        if typeof(p2) ~= "function" then
            error("callback is not a function");
        end;
    end;

    local v4 = 1;
    local v5 = {};

    while v4 <= #p1 do
        local v6 = p1[v4];

        if v6 ~= nil then
            local v7;

            if p3 == nil then
                v7 = p2(v6, v4, p1);
            else
                v7 = p2(p3, v6, v4, p1);
            end;

            v5[v4] = v7;
        end;

        v4 = v4 + 1;
    end;

    return v5;
end;