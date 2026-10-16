-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function, p3: any) -- Line: 10
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        if typeof(p1) ~= "table" then
            error(string.format("Array.every called on %s", (typeof(p1))));
        end;

        if typeof(p2) ~= "function" then
            error("callback is not a function");
        end;
    end;

    local v4 = 1;

    while v4 <= #p1 do
        local v5 = p1[v4];

        if v5 ~= nil then
            local v6;

            if p3 == nil then
                v6 = p2(v5, v4, p1);
            else
                v6 = p2(p3, v5, v4, p1);
            end;

            if not v6 then
                return false;
            end;
        end;

        v4 = v4 + 1;
    end;

    return true;
end;