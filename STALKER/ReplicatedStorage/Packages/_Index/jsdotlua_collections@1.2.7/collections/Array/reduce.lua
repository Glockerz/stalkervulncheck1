-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function, p3: any) -- Line: 9
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        if typeof(p1) ~= "table" then
            error(string.format("Array.reduce called on %s", (typeof(p1))));
        end;

        if typeof(p2) ~= "function" then
            error("callback is not a function");
        end;
    end;

    local v4 = #p1;
    local v5;

    if p3 == nil then
        v5 = 2;

        if v4 == 0 then
            error("reduce of empty array with no initial value");
        end;

        p3 = p1[1];
    else
        v5 = 1;
    end;

    for i = v5, v4 do
        p3 = p2(p3, p1[i], i, p1);
        local _ = i;
    end;

    return p3;
end;