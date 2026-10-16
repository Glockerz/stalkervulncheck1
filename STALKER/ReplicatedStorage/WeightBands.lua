-- Decompiled with Potassium's decompiler.

local u1 = {
    LIGHT = 0.9,
    HEAVY = 1,
    OVERLOADED = 1.2,
    LIGHTLOAD = 0.5,
    LIGHTLOAD_SPEED = 0.95,
    LIGHT_AGILITY = 1.3333333333333333,
    EXHAUSTION_LIGHT = 0.05,
    EXHAUSTION_LOADED = 0.45
};

function u1.ExhaustionThreshold(p2: number) -- Line: 56
    -- upvalues: u1 (copy)
    if p2 < u1.LIGHT then
        return u1.EXHAUSTION_LIGHT;
    end;

    return u1.EXHAUSTION_LOADED;
end;

local function lightLoadT(p3: number) -- Line: 64
    -- upvalues: u1 (copy)
    if p3 == p3 and u1.LIGHT > p3 then
        return math.max(0, p3 - u1.LIGHTLOAD) / (u1.LIGHT - u1.LIGHTLOAD);
    end;

    return nil;
end;

function u1.LoadSpeedMult(p4: number) -- Line: 72
    -- upvalues: u1 (copy)
    local v5;

    if p4 == p4 and u1.LIGHT > p4 then
        v5 = math.max(0, p4 - u1.LIGHTLOAD) / (u1.LIGHT - u1.LIGHTLOAD);
    else
        v5 = nil;
    end;

    return not v5 and 1 or 1 + (u1.LIGHTLOAD_SPEED - 1) * v5;
end;

function u1.AgilityFactor(p6: number) -- Line: 78
    -- upvalues: u1 (copy)
    local v7;

    if p6 == p6 and u1.LIGHT > p6 then
        v7 = math.max(0, p6 - u1.LIGHTLOAD) / (u1.LIGHT - u1.LIGHTLOAD);
    else
        v7 = nil;
    end;

    return not v7 and 1 or u1.LIGHT_AGILITY + (1 - u1.LIGHT_AGILITY) * v7;
end;

return u1;