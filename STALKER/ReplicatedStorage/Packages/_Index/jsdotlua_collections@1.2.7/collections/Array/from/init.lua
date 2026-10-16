-- Decompiled with Potassium's decompiler.

local Set = require(script.Parent.Parent:WaitForChild("Set"));
local Map = require(script.Parent.Parent:WaitForChild("Map"):WaitForChild("Map"));
local isArray = require(script.Parent:WaitForChild("isArray"));
local u1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));
local fromString = require(script:WaitForChild("fromString"));
local fromSet = require(script:WaitForChild("fromSet"));
local fromMap = require(script:WaitForChild("fromMap"));
local fromArray = require(script:WaitForChild("fromArray"));

return function(p2: any, p3: function?, p4: any) -- Line: 19
    -- upvalues: isArray (copy), fromArray (copy), u1 (copy), Set (copy), fromSet (copy), Map (copy), fromMap (copy), fromString (copy)
    if p2 == nil then
        error("cannot create array from a nil value");
    end;

    local v5 = typeof(p2);

    if v5 == "table" and isArray(p2) then
        return fromArray(p2, p3, p4);
    end;

    if u1(p2, Set) then
        return fromSet(p2, p3, p4);
    end;

    if u1(p2, Map) then
        return fromMap(p2, p3, p4);
    end;

    return v5 ~= "string" and {} or fromString(p2, p3, p4);
end;