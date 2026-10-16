-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1) -- Line: 7
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        print("Luau now has a direct table.isfrozen call that can save the overhead of this library function call");
    end;

    return table.isfrozen(p1);
end;