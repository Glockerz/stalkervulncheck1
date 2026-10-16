-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));
local map = require(script.Parent:WaitForChild("map"));

return function(p1: any, p2: string?) -- Line: 5
    -- upvalues: map (copy)
    if #p1 == 0 then
        return "";
    end;

    local v4 = map(p1, function(p3) -- Line: 10
        return tostring(p3);
    end);

    return table.concat(v4, p2 or ",");
end;