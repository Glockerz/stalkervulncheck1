-- Decompiled with Potassium's decompiler.

local Error = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Error;

return function(p1, p2, ...) -- Line: 24, Name: invariant
    -- upvalues: Error (copy)
    if not p1 then
        error(Error(string.format(p2, ...)));
    end;
end;