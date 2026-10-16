-- Decompiled with Potassium's decompiler.

local number = require(script.Parent.Parent:WaitForChild("number"));

return function(p1) -- Line: 4
    -- upvalues: number (copy)
    local v2 = p1 and true or false;

    if v2 then
        if p1 == 0 or p1 == "" then
            v2 = false;
        else
            v2 = not number.isNaN(p1);
        end;
    end;

    return v2;
end;