-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local isArray = require(script.Parent:WaitForChild("isArray"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1, ...) -- Line: 12, Name: concat
    -- upvalues: isArray (copy), _G___DEV__ (copy)
    local v2 = 0;
    local v3, v4;

    if isArray(p1) then
        v3 = table.clone(p1);
        v4 = #p1;
    else
        v4 = v2 + 1;
        v3 = {
            [v4] = p1
        };
    end;

    for i = 1, select("#", ...) do
        local v5 = select(i, ...);
        local v6 = typeof(v5);
        local v7;

        if v5 == nil then
            v7 = i;
        elseif v6 == "table" then
            if _G___DEV__ and not isArray(v5) then
                error("Array.concat(...) only works with array-like tables but it received an object-like table.\nYou can avoid this error by wrapping the object-like table into an array. Example: `concat({1, 2}, {a = true})` should be `concat({1, 2}, { {a = true} }`");
            end;

            v7 = i;

            for i2 = 1, #v5 do
                v4 = v4 + 1;
                v3[v4] = v5[i2];
                local _ = i2;
            end;
        else
            v4 = v4 + 1;
            v3[v4] = v5;
            v7 = i;
        end;
    end;

    return v3;
end;