-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function, p3: any) -- Line: 10
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        if typeof(p1) ~= "table" then
            error(string.format("Array.forEach called on %s", (typeof(p1))));
        end;

        if typeof(p2) ~= "function" then
            error("callback is not a function");
        end;
    end;

    local v4 = #p1;
    local v5 = 1;

    while v5 <= v4 do
        local v6 = p1[v5];

        if p3 == nil then
            p2(v6, v5, p1);
        else
            p2(p3, v6, v5, p1);
        end;

        v4 = #p1 < v4 and #p1 or v4;
        v5 = v5 + 1;
    end;
end;