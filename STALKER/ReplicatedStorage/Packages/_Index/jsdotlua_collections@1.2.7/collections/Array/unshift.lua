-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local isArray = require(script.Parent:WaitForChild("isArray"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1, ...) -- Line: 6
    -- upvalues: _G___DEV__ (copy), isArray (copy)
    if _G___DEV__ and not isArray(p1) then
        error(string.format("Array.unshift called on non-array %s", (typeof(p1))));
    end;

    local v2 = select("#", ...);

    if v2 > 0 then
        for i = v2, 1, -1 do
            local v3 = select(i, ...);
            table.insert(p1, 1, v3);
            local _ = i;
        end;
    end;

    return #p1;
end;