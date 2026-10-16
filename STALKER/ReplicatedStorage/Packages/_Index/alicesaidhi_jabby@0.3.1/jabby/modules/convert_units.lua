-- Decompiled with Potassium's decompiler.

return function(p1: string, p2: number) -- Line: 1, Name: convert_units
    local math_sign_ret = math.sign(p2);
    local math_abs_ret = math.abs(p2);
    local v3 = 0;
    local v4 = {
        [4] = "T",
        [3] = "G",
        [2] = "M",
        [1] = "k",
        [0] = " ",
        [-1] = "m",
        [-2] = "u",
        [-3] = "n",
        [-4] = "p"
    };

    while math_abs_ret >= 1000 do
        v3 = v3 + 1;
        math_abs_ret = math_abs_ret / 1000;
    end;

    while math_abs_ret ~= 0 and math_abs_ret < 1 do
        v3 = v3 - 1;
        math_abs_ret = math_abs_ret * 1000;
    end;

    if math_abs_ret >= 100 then
        math_abs_ret = math.floor(math_abs_ret);
    elseif math_abs_ret >= 10 then
        math_abs_ret = math.floor(math_abs_ret * 10) / 10;
    elseif math_abs_ret >= 1 then
        math_abs_ret = math.floor(math_abs_ret * 100) / 100;
    end;

    return math_abs_ret * math_sign_ret .. v4[v3] .. p1;
end;