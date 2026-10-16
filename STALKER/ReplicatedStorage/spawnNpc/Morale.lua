-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
u1.HIT_MORALE_SCALE = 60;
u1.ALLY_DEATH_MORALE = 20;
u1.OUTNUMBERED_RATE = 2;
u1.RECOVER_RATE = 3;
u1.RECOVER_AFTER = 5;

function u1.New(p2) -- Line: 19
    -- upvalues: u1 (copy)
    return setmetatable({
        lastHitAt = (-1 / 0),
        value = p2,
        bravery = p2
    }, u1);
end;

function u1.Hit(p3, p4, p5, p6) -- Line: 23
    -- upvalues: u1 (copy)
    if p5 <= 0 or p4 <= 0 then
        return;
    end;

    p3.value = math.max(0, p3.value - p4 / p5 * u1.HIT_MORALE_SCALE);
    p3.lastHitAt = p6;
end;

function u1.AllyDied(p7) -- Line: 29
    -- upvalues: u1 (copy)
    p7.value = math.max(0, p7.value - u1.ALLY_DEATH_MORALE);
end;

function u1.Tick(p8, p9, p10, p11, p12) -- Line: 33
    -- upvalues: u1 (copy)
    if p10 + 1 < p11 then
        p8.value = p8.value - u1.OUTNUMBERED_RATE * p9;
    end;

    if p12 - p8.lastHitAt >= u1.RECOVER_AFTER then
        p8.value = p8.value + u1.RECOVER_RATE * p9;
    end;

    p8.value = math.clamp(p8.value, 0, p8.bravery);
end;

function u1.SetBravery(p13, p14) -- Line: 42
    local v15 = p13.bravery - p13.value;
    p13.bravery = p14;
    p13.value = math.clamp(p14 - v15, 0, p14);
end;

function u1.Value(p16) -- Line: 48
    return p16.value;
end;

return u1;