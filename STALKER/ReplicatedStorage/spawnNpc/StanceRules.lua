-- Decompiled with Potassium's decompiler.

local u1 = {
    CROUCH_MIN_DIST = 40,
    CROUCH_SKIP = 0.25,
    UNDER_FIRE_SECONDS = 2,
    STANCE_MIN_HOLD = 0.8,
    CROUCH_SESSION_MIN = 30,
    CROUCH_SESSION_MAX = 60,
    REPOSITION_MIN = 10,
    REPOSITION_MAX = 20,
    STILL_BEFORE_CROUCH = 1.5,
    CROUCH_SPREAD_MULT = 0.85,
    LEAN_OFFSET = 0.9
};
local u2 = {
    AIMING = true,
    FIRING = true
};
u1.LEAN_MIN_HOLD = 2;
local u3 = {
    AIMING = true,
    FIRING = true,
    IDLE = true
};

function u1.Pick(p4) -- Line: 56
    -- upvalues: u1 (copy), u2 (copy)
    if p4.moving or (p4.state == "PATHING" or p4.state == "RETREATING") then
        return "Stand";
    end;

    local v5 = p4.now or 0;

    return v5 < (p4.crouchUntil or 0) and "Crouch" or (v5 < (p4.standUntil or 0) and "Stand" or ((p4.stillFor or (1 / 0)) < u1.STILL_BEFORE_CROUCH and "Stand" or (p4.underFire and "Crouch" or (u2[p4.state] and (p4.dist >= u1.CROUCH_MIN_DIST and p4.willing >= u1.CROUCH_SKIP) and "Crouch" or "Stand"))));
end;

function u1.PickLean(p6) -- Line: 82
    -- upvalues: u1 (copy), u3 (copy)
    if p6.moving or p6.reloading then
        return 0;
    end;

    local v7 = p6.current or 0;

    return (v7 == 0 or (p6.leanedFor or (1 / 0)) >= u1.LEAN_MIN_HOLD) and (u3[p6.state] and not p6.clearStraight and (p6.clearLeft and p6.clearRight and (p6.current ~= 0 and p6.current or -1) or (p6.clearLeft and -1 or (p6.clearRight and 1 or 0))) or 0) or v7;
end;

function u1.Hold(p8: number, p9: number) -- Line: 98
    -- upvalues: u1 (copy)
    return p9 - p8 >= u1.STANCE_MIN_HOLD;
end;

return u1;