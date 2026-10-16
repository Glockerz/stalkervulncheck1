-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent:WaitForChild("shared"));
local u1 = require(script.Parent:WaitForChild("ReactBinding.roblox"));

return {
    createRef = function() -- Line: 24
        -- upvalues: u1 (copy)
        local u2, _ = u1.create(nil);
        local v3 = {};

        if _G.__DEV__ then
            u2._source = debug.traceback("Ref created at:", 1);
        end;

        setmetatable(v3, {
            __index = function(p4, p5) -- Line: 42, Name: __index
                -- upvalues: u2 (copy)
                if p5 == "current" then
                    return u2:getValue();
                end;

                return u2[p5];
            end,

            __newindex = function(p6, p7, p8) -- Line: 49, Name: __newindex
                -- upvalues: u1 (ref), u2 (copy)
                if p7 == "current" then
                    u1.update(u2, p8);
                end;

                u2[p7] = p8;
            end,

            __tostring = function(p9) -- Line: 60, Name: __tostring
                -- upvalues: u2 (copy)
                return string.format("Ref(%s)", (tostring(u2:getValue())));
            end
        });

        return v3;
    end
};