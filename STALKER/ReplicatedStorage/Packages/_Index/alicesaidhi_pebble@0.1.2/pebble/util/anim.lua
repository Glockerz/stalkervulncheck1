-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.vide);
local reduced_motion = require(script.Parent.reduced_motion);
local _ = vide.source;
local spring = vide.spring;
local untrack = vide.untrack;

return function(u1: function) -- Line: 10
    -- upvalues: untrack (copy), reduced_motion (copy), spring (copy)
    local v2 = typeof(untrack(u1));
    local u3 = reduced_motion:consume();
    local u4 = v2 == "UDim" or (v2 == "UDim2" or v2 == "Vector2");
    local u5 = spring(u1, 0.1);

    return function() -- Line: 20
        -- upvalues: u4 (ref), u3 (copy), u1 (copy), u5 (copy)
        if u4 and u3 then
            return u1();
        end;

        return u5();
    end;
end;