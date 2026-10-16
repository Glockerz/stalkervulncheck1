-- Decompiled with Potassium's decompiler.

local console = require(script.Parent:WaitForChild("console"));
local v1 = {};
setmetatable(v1, {
    __metatable = "UninitializedState",

    __index = function(p2, p3) -- Line: 23, Name: __index
        -- upvalues: console (copy)
        if _G.__DEV__ then
            console.warn("Attempted to access uninitialized state. Use setState to initialize state");
        end;

        return nil;
    end,

    __newindex = function(p4, p5) -- Line: 31, Name: __newindex
        -- upvalues: console (copy)
        if _G.__DEV__ then
            console.error("Attempted to directly mutate state. Use setState to assign new values to state.");
        end;

        return nil;
    end,

    __tostring = function(p6) -- Line: 39, Name: __tostring
        return "<uninitialized component state>";
    end
});

return v1;