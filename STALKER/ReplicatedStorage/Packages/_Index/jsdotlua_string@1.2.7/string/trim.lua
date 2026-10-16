-- Decompiled with Potassium's decompiler.

local trimStart = require(script.Parent:WaitForChild("trimStart"));
local trimEnd = require(script.Parent:WaitForChild("trimEnd"));

return function(p1: string) -- Line: 4
    -- upvalues: trimStart (copy), trimEnd (copy)
    return trimStart(trimEnd(p1));
end;