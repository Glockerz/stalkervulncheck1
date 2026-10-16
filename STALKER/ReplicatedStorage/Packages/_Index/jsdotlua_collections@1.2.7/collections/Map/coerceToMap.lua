-- Decompiled with Potassium's decompiler.

local Map = require(script.Parent:WaitForChild("Map"));
local Object = require(script.Parent.Parent:WaitForChild("Object"));
local u1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p2) -- Line: 9, Name: coerceToMap
    -- upvalues: u1 (copy), Map (copy), Object (copy)
    return u1(p2, Map) and p2 and p2 or Map.new(Object.entries(p2));
end;