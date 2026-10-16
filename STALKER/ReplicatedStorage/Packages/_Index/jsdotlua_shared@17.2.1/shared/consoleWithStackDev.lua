-- Decompiled with Potassium's decompiler.

local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local console = v1.console;
local Array = v1.Array;
local ReactSharedInternals = require(script.Parent:WaitForChild("ReactSharedInternals"));
local u2 = nil;
local v5 = {
    warn = function(p3, ...) -- Line: 24
        -- upvalues: u2 (ref)
        if _G.__DEV__ then
            u2("warn", p3, { ... });
        end;
    end,

    error = function(p4, ...) -- Line: 29
        -- upvalues: u2 (ref)
        if _G.__DEV__ then
            u2("error", p4, { ... });
        end;
    end
};

u2 = function(p6, p7, p8) -- Line: 35, Name: printWarning
    -- upvalues: ReactSharedInternals (copy), Array (copy), console (copy)
    if _G.__DEV__ then
        local StackAddendum = ReactSharedInternals.ReactDebugCurrentFrame.getStackAddendum();

        if StackAddendum ~= "" then
            p7 = p7 .. "%s";
            p8 = Array.slice(p8, 1);
            table.insert(p8, StackAddendum);
        end;

        local v9 = Array.map(p8, tostring);
        table.insert(v9, 1, "Warning: " .. p7);
        console[p6](unpack(v9));
    end;
end;

return v5;