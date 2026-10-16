-- Decompiled with Potassium's decompiler.

local None = require(script.Parent:WaitForChild("None"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1, p2, p3, p4, ...) -- Line: 12
    -- upvalues: None (copy)
    if p2 ~= nil and typeof(p2) == "table" then
        for i, v in pairs(p2) do
            if v == None then
                p1[i] = nil;
            else
                p1[i] = v;
            end;
        end;
    end;

    if p3 ~= nil and typeof(p3) == "table" then
        for i, v in pairs(p3) do
            if v == None then
                p1[i] = nil;
            else
                p1[i] = v;
            end;
        end;
    end;

    if p4 ~= nil and typeof(p4) == "table" then
        for i, v in pairs(p4) do
            if v == None then
                p1[i] = nil;
            else
                p1[i] = v;
            end;
        end;
    end;

    for i = 1, select("#", ...) do
        local v5 = select(i, ...);
        local v6;

        if v5 == nil or typeof(v5) ~= "table" then
            v6 = i;
        else
            v6 = i;

            for i2, v in pairs(v5) do
                if v == None then
                    p1[i2] = nil;
                else
                    p1[i2] = v;
                end;
            end;
        end;
    end;

    return p1;
end;