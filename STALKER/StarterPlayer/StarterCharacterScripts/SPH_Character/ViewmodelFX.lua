-- Decompiled with Potassium's decompiler.

local u1 = {};

function u1.new(p2) -- Line: 3
    -- upvalues: u1 (copy)
    local v3 = {
        swaySpring = p2.new(),
        recoilSpring = p2.new(),
        gunRecoilSpring = p2.new()
    };
    v3.recoilSpring.Damping = 9;
    v3.gunRecoilSpring.Damping = 9;

    return setmetatable(v3, {
        __index = u1
    });
end;

function u1.applyBreathing(p4, p5, p6, p7, p8) -- Line: 15
    local v9 = tick() * 0.15;
    local breathingDist = p8.breathingDist;

    if p7 then
        breathingDist = breathingDist * p8.breathingAimMultiplier;
    end;

    p5.CFrame = p5.CFrame * CFrame.new(breathingDist * math.sin(v9 * p8.breathingSpeed / 2), breathingDist * math.sin(v9 * p8.breathingSpeed), 0);
end;

function u1.applyRattle(p10, p11, p12, p13, p14) -- Line: 27
    p13.rattle = math.max(p13.rattle - p12 * 3, 0);

    if p13.rattle > 0 then
        local v15 = p13.rattle * 0.035;
        local v16 = p14 and 0.3 or 1;
        p11.CFrame = p11.CFrame * (CFrame.new((math.random() - 0.5) * v15 * v16, (math.random() - 0.5) * v15 * v16, (math.random() - 0.5) * v15 * v16) * CFrame.Angles((math.random() - 0.5) * v15 * 0.6 * v16, (math.random() - 0.5) * v15 * 0.6 * v16, (math.random() - 0.5) * v15 * 0.6 * v16));
    end;
end;

function u1.applyGunRecoil(p17, p18, p19, p20) -- Line: 45
    local v21 = p17.gunRecoilSpring:update(p19);
    local math_max_ret = math.max(0, v21.X);
    local Vector3_new_ret = Vector3.new(math_max_ret, v21.Y, v21.Z);
    local v22 = p20.gripPivotOffset or Vector3.new(0, -0.3, 0.5);
    p18.CFrame = p18.CFrame * (CFrame.new(v22) * CFrame.Angles(math.rad(Vector3_new_ret.X), math.rad(Vector3_new_ret.Y), 0) * CFrame.new(-v22));
    p18.CFrame = p18.CFrame * CFrame.new(0, 0, Vector3_new_ret.Z);
end;

function u1.applyCameraRecoil(p23, p24, p25, p26) -- Line: 56
    p26.accum = p26.accum + p25;

    if p26.accum >= 0.015384615384615385 then
        local v27 = p23.recoilSpring:update(p26.accum);
        local math_max_ret = math.max(0, v27.X);
        local Vector3_new_ret = Vector3.new(math_max_ret, v27.Y, v27.Z);
        p26.camRecoil = CFrame.Angles(math.rad(Vector3_new_ret.X), math.rad(Vector3_new_ret.Y), (math.rad(Vector3_new_ret.Z)));
        p24.CFrame = p24.CFrame * p26.camRecoil;
        p26.accum = 0;
    end;
end;

function u1.applyLowReady(p28, p29, p30, p31, p32, p33) -- Line: 68
    local v34 = tick();

    if p32 then
        p31.lastActive = v34;
    end;

    local v35 = v34 - p31.lastActive > 3 and not p32 and 1 or 0;
    p31.lowReady = p31.lowReady + (v35 - p31.lowReady) * (1 - (1 - (p31.lowReady < v35 and 0.03 or 0.15)) ^ (p30 * 60));
    p33:SetAttribute("LowReady", p31.lowReady);

    if p31.lowReady > 0.001 then
        p29.CFrame = p29.CFrame * (CFrame.Angles(math.rad(-8 * p31.lowReady), 0, 0) * CFrame.new(0, -0.1 * p31.lowReady, 0));
    end;
end;

function u1.applySway(p36, p37, p38, p39) -- Line: 83
    p36.swaySpring:shove((Vector3.new(-p39.X / 300, p39.Y / 160, 0)));
    local v40 = p36.swaySpring:update(p38);
    p37.CFrame = p37.CFrame * CFrame.new(v40.X, v40.Y, 0);
end;

return u1;