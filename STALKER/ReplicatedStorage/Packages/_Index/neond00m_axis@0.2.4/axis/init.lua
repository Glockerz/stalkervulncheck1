-- Decompiled with Potassium's decompiler.

local u1 = _G.UserInputService or game:GetService("UserInputService");
require("@self/types");
local v2 = require("@self/input");
local u3 = require("@self/getInputDevice");

return {
    input = v2,

    update = function(p4: table) -- Line: 35, Name: update
        for _, v in p4 do
            v:update();
        end;
    end,

    device = function(p5) -- Line: 54, Name: device
        -- upvalues: u3 (copy), u1 (copy)
        return u3(p5 or u1:GetLastInputType());
    end
};