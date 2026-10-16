-- Decompiled with Potassium's decompiler.

local Map = require(script.Parent:WaitForChild("Map"));
local u1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"));
local reduce = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("reduce"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p2) -- Line: 9, Name: coerceToTable
    -- upvalues: u1 (copy), Map (copy), reduce (copy)
    if u1(p2, Map) then
        return reduce(p2:entries(), function(p3, p4) -- Line: 15
            p3[p4[1]] = p4[2];

            return p3;
        end, {});
    end;

    return p2;
end;