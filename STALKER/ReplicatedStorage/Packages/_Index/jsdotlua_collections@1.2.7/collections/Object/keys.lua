-- Decompiled with Potassium's decompiler.

local Set = require(script.Parent.Parent:WaitForChild("Set"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));
local u1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"));

return function(p2) -- Line: 8
    -- upvalues: u1 (copy), Set (copy)
    if p2 == nil then
        error("cannot extract keys from a nil value");
    end;

    local v3 = typeof(p2);
    local v4 = nil;

    if v3 ~= "table" then
        if v3 == "string" then
            local v5 = p2:len();
            v4 = table.create(v5);

            for i = 1, v5 do
                v4[i] = tostring(i);
                local _ = i;
            end;
        end;

        return v4;
    end;

    local v6 = {};

    if u1(p2, Set) then
        return v6;
    end;

    for i in pairs(p2) do
        table.insert(v6, i);
    end;

    return v6;
end;