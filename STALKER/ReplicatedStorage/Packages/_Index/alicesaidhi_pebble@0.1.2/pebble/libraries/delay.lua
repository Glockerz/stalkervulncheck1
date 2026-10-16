-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local vide = require(script.Parent.Parent.Parent.vide);
local source = vide.source;
local effect = vide.effect;
local cleanup = vide.cleanup;

return function(u1: number, u2: function) -- Line: 9
    -- upvalues: source (copy), effect (copy), cleanup (copy), RunService (copy)
    local u3 = source(u2());
    effect(function() -- Line: 12
        -- upvalues: u2 (copy), u1 (copy), cleanup (ref), RunService (ref), u3 (copy)
        local u4 = u2();
        local u5 = u1;
        cleanup(RunService.Heartbeat:Connect(function(p6) -- Line: 16
            -- upvalues: u5 (ref), u3 (ref), u4 (copy)
            u5 = u5 - p6;

            if u5 > 0 then
                return;
            end;

            u3(u4);
        end));
    end);

    return u3;
end;