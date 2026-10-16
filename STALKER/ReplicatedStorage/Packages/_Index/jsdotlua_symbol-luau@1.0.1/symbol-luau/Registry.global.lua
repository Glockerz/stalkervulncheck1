-- Decompiled with Potassium's decompiler.

local Symbol = require(script.Parent:WaitForChild("Symbol"));
local u1 = {};

return {
    getOrInit = function(p2: string) -- Line: 6, Name: getOrInit
        -- upvalues: u1 (ref), Symbol (copy)
        if u1[p2] == nil then
            u1[p2] = Symbol.new(p2);
        end;

        return u1[p2];
    end,

    __clear = function() -- Line: 14, Name: __clear
        -- upvalues: u1 (ref)
        u1 = {};
    end
};