-- Decompiled with Potassium's decompiler.

local objectIs = require(script.Parent:WaitForChild("objectIs"));

return function(p1, p2) -- Line: 18, Name: shallowEqual
    -- upvalues: objectIs (copy)
    if objectIs(p1, p2) then
        return true;
    end;

    if typeof(p1) ~= "table" or (p1 == nil or (typeof(p2) ~= "table" or p2 == nil)) then
        return false;
    end;

    for i, v in p1 do
        if not objectIs(p2[i], v) then
            return false;
        end;
    end;

    for i, v in p2 do
        if not objectIs(p1[i], v) then
            return false;
        end;
    end;

    return true;
end;