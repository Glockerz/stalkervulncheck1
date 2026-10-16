-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));
local indexOf = require(script.Parent:WaitForChild("indexOf"));

return function(p1: any, p2: any, p3: number?) -- Line: 5
    -- upvalues: indexOf (copy)
    return indexOf(p1, p2, p3) ~= -1;
end;