-- Decompiled with Potassium's decompiler.

local u1 = {
    MG_MAGAZINE = 60,
    PISTOL_CARTRIDGES = {
        ["9x18mm"] = true,
        ["9x19mm"] = true,
        [".45ACP"] = true,
        ["7.62x25mm"] = true,
        ["4.6x30mm"] = true,
        ["5.7x28mm"] = true,
        [".357"] = true
    },
    FULL_POWER = {
        ["7.62x54mm"] = true,
        ["7.62x51mm"] = true,
        [".308"] = true,
        [".338"] = true,
        ["9x39mm"] = true
    }
};

function u1.Classify(p2) -- Line: 27
    -- upvalues: u1 (copy)
    if type(p2) ~= "table" then
        return "rifle";
    end;

    local v3 = p2.ammoType or "";

    return (p2.shotgun == true or v3 == "12gauge") and "shotgun" or (type(p2.holdUpAnim) == "string" and p2.holdUpAnim:sub(1, 6) == "Pistol" and "pistol" or ((p2.magazineCapacity or 0) >= u1.MG_MAGAZINE and "mg" or (u1.PISTOL_CARTRIDGES[v3] and "smg" or (p2.fireMode == 4 and "sniper" or (p2.fireMode == 1 and (u1.FULL_POWER[v3] or (p2.magazineCapacity or 30) <= 10) and "dmr" or "rifle")))));
end;

u1.PREFS = {
    shotgun = {
        min = 0.3,
        max = 0.35,
        close = 0.6,
        push = 1.6,
        flank = 1.3,
        reposition = 1.2
    },
    smg = {
        min = 0.6,
        max = 0.6,
        close = 0.85,
        push = 1.3,
        flank = 1.2,
        reposition = 1.1
    },
    rifle = {
        min = 1,
        max = 1,
        close = 1,
        push = 1,
        flank = 1,
        reposition = 1
    },
    dmr = {
        min = 1.3,
        max = 1.5,
        close = 1.3,
        push = 0.6,
        flank = 0.8,
        reposition = 0.8
    },
    sniper = {
        min = 1.6,
        max = 2,
        close = 1.6,
        push = 0.3,
        flank = 0.5,
        reposition = 0.7
    },
    mg = {
        min = 1.2,
        max = 1.3,
        close = 1.1,
        push = 0.5,
        flank = 0.5,
        reposition = 0.6
    },
    pistol = {
        min = 0.6,
        max = 0.6,
        close = 0.9,
        push = 1,
        flank = 1,
        reposition = 1
    }
};
u1.RANGE_CAP = 450;
u1.CLOSE_SHARE = 0.8;

function u1.Ranges(p4, p5, p6, p7) -- Line: 59
    -- upvalues: u1 (copy)
    local v8 = u1.PREFS[p4] or u1.PREFS.rifle;
    local math_min_ret = math.min(p6 * v8.max, u1.RANGE_CAP);
    local math_min_ret2 = math.min(p5 * v8.min, math_min_ret * 0.8);

    return math_min_ret2, math_min_ret, math.min(p7 * v8.close, math_min_ret2 * u1.CLOSE_SHARE);
end;

return u1;