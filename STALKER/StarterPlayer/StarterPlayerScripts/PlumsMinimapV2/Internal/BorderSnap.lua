-- Decompiled with Potassium's decompiler.

local function getCornerPosition(p1, p2, p3, p4) -- Line: 3
    return Vector2.new(p3, p3), Vector2.new(p3, p2.Y - p3), Vector2.new(p2.X - p3, p3), Vector2.new(p2.X - p3, p2.Y - p3);
end;

local function getRadius(p5, p6) -- Line: 7
    -- upvalues: getCornerPosition (copy)
    local math_min_ret = math.min(p6.X, p6.Y);
    math.max(p6.X, p6.Y);
    local v7 = math_min_ret * math.clamp(p5.Scale, 0, 0.5) + math.clamp(p5.Offset, 0, math_min_ret / 2);

    return v7, getCornerPosition(math_min_ret, p6, v7);
end;

local function check(p8, p9, p10, p11, p12) -- Line: 14
    if p8.X < p9.X and p8.Y < p9.Y then
        return "left-top";
    end;

    if p8.X < p10.X and p8.Y > p10.Y then
        return "left-bottom";
    end;

    if p8.X > p11.X and p8.Y < p11.Y then
        return "right-top";
    end;

    if p8.X > p12.X and p8.Y > p12.Y then
        return "right-bottom";
    end;
end;

local function clamp(p13, p14, p15, p16) -- Line: 30
    local magnitude = (p13 - p14).magnitude;

    if p15 >= magnitude then
        return p13;
    end;

    if p16 == "left-top" then
        local v17 = Vector2.new(p14.X - p13.X, p14.Y - p13.Y).Y / magnitude;
        local math_acos_ret = math.acos(v17);

        return p14 - Vector2.new(p15 * math.sin(math_acos_ret), p15 * math.cos(math_acos_ret));
    end;

    if p16 == "left-bottom" then
        local v18 = Vector2.new(p14.X - p13.X, p14.Y - p13.Y).Y / magnitude;
        local math_acos_ret = math.acos(v18);

        return p14 - Vector2.new(p15 * math.sin(math_acos_ret), p15 * math.cos(math_acos_ret));
    end;

    if p16 == "right-top" then
        local v19 = Vector2.new(p13.X - p14.X, p13.Y - p14.Y).Y / magnitude;
        local math_acos_ret = math.acos(v19);

        return p14 + Vector2.new(p15 * math.sin(math_acos_ret), p15 * math.cos(math_acos_ret));
    end;

    local v20 = Vector2.new(p13.X - p14.X, p13.Y - p14.Y).Y / magnitude;
    local math_acos_ret = math.acos(v20);

    return p14 + Vector2.new(p15 * math.sin(math_acos_ret), p15 * math.cos(math_acos_ret));
end;

return function(p21, p22, p23) -- Line: 72
    -- upvalues: getCornerPosition (copy), check (copy), clamp (copy)
    local math_min_ret = math.min(p22.X, p22.Y);
    math.max(p22.X, p22.Y);
    local v24 = math_min_ret * math.clamp(p23.Scale, 0, 0.5) + math.clamp(p23.Offset, 0, math_min_ret / 2);
    local v25, v26, v27, v28 = getCornerPosition(math_min_ret, p22, v24);
    local v29 = check(p21, v25, v26, v27, v28);

    if v29 == "left-top" then
        p21 = clamp(p21, v25, v24, v29);
    elseif v29 == "left-bottom" then
        p21 = clamp(p21, v26, v24, v29);
    elseif v29 == "right-top" then
        p21 = clamp(p21, v27, v24, v29);
    elseif v29 == "right-bottom" then
        p21 = clamp(p21, v28, v24, v29);
    end;

    return Vector2.new(math.clamp(p21.X, 0, p22.X), (math.clamp(p21.Y, 0, p22.Y)));
end;