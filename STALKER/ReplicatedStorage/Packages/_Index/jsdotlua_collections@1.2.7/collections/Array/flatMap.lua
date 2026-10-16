-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local flat = require(script.Parent:WaitForChild("flat"));
local map = require(script.Parent:WaitForChild("map"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function, p3: any) -- Line: 9, Name: flatMap
    -- upvalues: _G___DEV__ (copy), flat (copy), map (copy)
    if _G___DEV__ then
        if typeof(p1) ~= "table" then
            error(string.format("Array.flatMap called on %s", (typeof(p1))));
        end;

        if typeof(p2) ~= "function" then
            error("callback is not a function");
        end;
    end;

    return flat(map(p1, p2, p3));
end;