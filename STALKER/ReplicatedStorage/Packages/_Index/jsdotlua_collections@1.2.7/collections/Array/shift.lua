-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local isArray = require(script.Parent:WaitForChild("isArray"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1) -- Line: 6
    -- upvalues: _G___DEV__ (copy), isArray (copy)
    if _G___DEV__ and not isArray(p1) then
        error(string.format("Array.shift called on non-array %s", (typeof(p1))));
    end;

    if #p1 > 0 then
        return table.remove(p1, 1);
    end;

    return nil;
end;