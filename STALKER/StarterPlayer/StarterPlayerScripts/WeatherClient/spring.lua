-- Decompiled with Potassium's decompiler.

local u1 = {};

function u1.new(p2) -- Line: 44
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    local v4 = p2 or 0;
    rawset(v3, "_time0", tick());
    rawset(v3, "_position0", v4);
    rawset(v3, "_velocity0", 0 * v4);
    rawset(v3, "_target", v4);
    rawset(v3, "_damper", 1);
    rawset(v3, "_speed", 1);

    return v3;
end;

function u1.Impulse(p5, p6) -- Line: 60
    p5.Velocity = p5.Velocity + p6;
end;

function u1.TimeSkip(p7, p8) -- Line: 66
    local v9 = tick();
    local v10, v11 = p7:_positionVelocity(v9 + p8);
    rawset(p7, "_position0", v10);
    rawset(p7, "_velocity0", v11);
    rawset(p7, "_time0", v9);
end;

function u1.__index(p12, p13) -- Line: 74
    -- upvalues: u1 (copy)
    if u1[p13] then
        return u1[p13];
    end;

    if p13 == "Value" or (p13 == "Position" or p13 == "p") then
        local v14, _ = p12:_positionVelocity(tick());

        return v14;
    end;

    if p13 == "Velocity" or p13 == "v" then
        local _, v15 = p12:_positionVelocity(tick());

        return v15;
    end;

    if p13 == "Target" or p13 == "t" then
        return rawget(p12, "_target");
    end;

    if p13 == "Damper" or p13 == "d" then
        return rawget(p12, "_damper");
    end;

    if p13 == "Speed" or p13 == "s" then
        return rawget(p12, "_speed");
    end;

    error(("%q is not a valid member of Spring"):format((tostring(p13))), 2);
end;

function u1.__newindex(p16, p17, p18) -- Line: 94
    local v19 = tick();

    if p17 == "Value" or (p17 == "Position" or p17 == "p") then
        local _, v20 = p16:_positionVelocity(v19);
        rawset(p16, "_position0", p18);
        rawset(p16, "_velocity0", v20);
    elseif p17 == "Velocity" or p17 == "v" then
        local v21, _ = p16:_positionVelocity(v19);
        rawset(p16, "_position0", v21);
        rawset(p16, "_velocity0", p18);
    elseif p17 == "Target" or p17 == "t" then
        local v22, v23 = p16:_positionVelocity(v19);
        rawset(p16, "_position0", v22);
        rawset(p16, "_velocity0", v23);
        rawset(p16, "_target", p18);
    elseif p17 == "Damper" or p17 == "d" then
        local v24, v25 = p16:_positionVelocity(v19);
        rawset(p16, "_position0", v24);
        rawset(p16, "_velocity0", v25);
        local math_clamp_ret = math.clamp(p18, 0, 1);
        rawset(p16, "_damper", math_clamp_ret);
    elseif p17 == "Speed" or p17 == "s" then
        local v26, v27 = p16:_positionVelocity(v19);
        rawset(p16, "_position0", v26);
        rawset(p16, "_velocity0", v27);
        rawset(p16, "_speed", p18 < 0 and 0 or p18);
    else
        error(("%q is not a valid member of Spring"):format((tostring(p17))), 2);
    end;

    rawset(p16, "_time0", v19);
end;

function u1._positionVelocity(p28, p29) -- Line: 127
    local v30 = p29 - rawget(p28, "_time0");
    local v31 = rawget(p28, "_position0");
    local v32 = rawget(p28, "_velocity0");
    local v33 = rawget(p28, "_target");
    local v34 = rawget(p28, "_damper");
    local v35 = rawget(p28, "_speed");
    local v36 = v31 - v33;

    if v35 == 0 then
        return v31, 0;
    end;

    if v34 >= 1 then
        local v37 = v32 / v35 + v36;
        local v38 = 2.718281828459045 ^ (v35 * v30);

        return v33 + (v36 + v37 * v35 * v30) / v38, v35 * (v37 - v36 - v37 * v35 * v30) / v38;
    end;

    local v39 = (1 - v34 * v34) ^ 0.5;
    local v40 = (v32 / v35 + v34 * v36) / v39;
    local math_cos_ret = math.cos(v39 * v35 * v30);
    local math_sin_ret = math.sin(v39 * v35 * v30);
    local v41 = 2.718281828459045 ^ (v34 * v35 * v30);

    return v33 + (v36 * math_cos_ret + v40 * math_sin_ret) / v41, v35 * ((v39 * v40 - v34 * v36) * math_cos_ret - (v39 * v36 + v34 * v40) * math_sin_ret) / v41;
end;

return u1;