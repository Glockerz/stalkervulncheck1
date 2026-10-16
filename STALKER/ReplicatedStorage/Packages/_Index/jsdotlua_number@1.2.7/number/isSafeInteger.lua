-- Decompiled with Potassium's decompiler.

local isInteger = require(script.Parent:WaitForChild("isInteger"));
local MAX_SAFE_INTEGER = require(script.Parent:WaitForChild("MAX_SAFE_INTEGER"));

return function(p1) -- Line: 5
    -- upvalues: isInteger (copy), MAX_SAFE_INTEGER (copy)
    local v2 = isInteger(p1) and math.abs(p1) <= MAX_SAFE_INTEGER;

    return v2;
end;