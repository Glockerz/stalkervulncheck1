-- Decompiled with Potassium's decompiler.

local oklab = require(script.Parent.Parent.libraries.oklab);

return function(p1: number, p2: number, p3: number) -- Line: 17, Name: oklch
    -- upvalues: oklab (copy)
    local linear_srgb_to_color3 = oklab.linear_srgb_to_color3;
    local oklab_to_linear_srgb = oklab.oklab_to_linear_srgb;
    local oklch_to_oklab = oklab.oklch_to_oklab;
    local math_clamp_ret = math.clamp(p1, 0, 1);

    return linear_srgb_to_color3(oklab_to_linear_srgb(oklch_to_oklab((Vector3.new(math_clamp_ret, p2, p3)))), true);
end;