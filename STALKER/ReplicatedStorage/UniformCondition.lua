-- Decompiled with Potassium's decompiler.

local u1 = {
    MAX = 100,
    SCALE_CURVE = { {
            at = 100,
            mult = 1
        }, {
            at = 75,
            mult = 0.9
        }, {
            at = 50,
            mult = 0.7
        }, {
            at = 25,
            mult = 0.4
        }, {
            at = 0,
            mult = 0.1
        } }
};
u1.FLOOR = u1.SCALE_CURVE[#u1.SCALE_CURVE].mult;
u1.WEAR_PER_DAMAGE = 0.1;
u1.DEATH_WEAR = 10;
u1.MAX_MITIGATION = 0.95;
u1.CLASSES = {
    Civilian = {
        Rupture = 0,
        Anomalous = 0
    },
    Field = {
        Rupture = 0.1,
        Anomalous = 0.05
    },
    Reinforced = {
        Rupture = 0.25,
        Anomalous = 0.1
    },
    Hazard = {
        Rupture = 0.08,
        Anomalous = 0.35
    },
    Protective = {
        Rupture = 0.32,
        Anomalous = 0.3
    },
    Universal = {
        Rupture = 0.45,
        Anomalous = 0.3
    }
};
u1.REPAIR_TIERS = { {
        item = "AramidFabrics",
        min = 0,
        max = 45,
        amount = 25,
        seconds = 30,
        requires = "Thread"
    }, {
        item = "TextileFabrics",
        min = 0,
        max = 60,
        amount = 16,
        seconds = 24,
        requires = "Thread"
    }, {
        item = "ClothFabric",
        min = 20,
        max = 75,
        amount = 13,
        seconds = 18,
        requires = "Thread"
    }, {
        item = "Thread",
        min = 45,
        max = 85,
        amount = 8,
        seconds = 12
    }, {
        item = "ElectricalTape",
        min = 65,
        max = 90,
        amount = 5,
        seconds = 8
    } };

function u1.IsUniform(p2) -- Line: 164
    local v3;

    if type(p2) == "table" then
        v3 = p2.ItemType == "Uniform";
    else
        v3 = false;
    end;

    return v3;
end;

function u1.ClassFor(p4) -- Line: 173
    -- upvalues: u1 (copy)
    if not u1.IsUniform(p4) then
        return nil;
    end;

    local UniformClass = p4.UniformClass;

    if type(UniformClass) == "string" then
        return u1.CLASSES[UniformClass] and UniformClass and UniformClass or nil;
    end;

    return nil;
end;

function u1.Rated(p5, p6) -- Line: 182
    -- upvalues: u1 (copy)
    local v7 = u1.ClassFor(p5);

    if not v7 then
        return 0;
    end;

    local v8 = u1.CLASSES[v7];

    return v8 and v8[p6] or 0;
end;

function u1.Get(p9, p10) -- Line: 196
    -- upvalues: u1 (copy)
    if not u1.IsUniform(p10) then
        return u1.MAX;
    end;

    if p9 then
        p9 = p9.CurrentDurability;
    end;

    if type(p9) == "number" then
        return math.clamp(p9, 0, u1.MAX);
    end;

    return u1.MAX;
end;

function u1.Scale(p11) -- Line: 207
    -- upvalues: u1 (copy)
    local v12 = tonumber(p11) or u1.MAX;
    local math_clamp_ret = math.clamp(v12, 0, u1.MAX);
    local SCALE_CURVE = u1.SCALE_CURVE;

    if SCALE_CURVE[1].at <= math_clamp_ret then
        return SCALE_CURVE[1].mult;
    end;

    for i = 1, #SCALE_CURVE - 1 do
        local v13 = SCALE_CURVE[i];
        local v14 = SCALE_CURVE[i + 1];

        if math_clamp_ret <= v13.at and v14.at <= math_clamp_ret then
            local v15 = v13.at - v14.at;

            if v15 <= 0 then
                return v14.mult;
            end;

            return v14.mult + (v13.mult - v14.mult) * ((math_clamp_ret - v14.at) / v15);
        end;

        local _ = i;
    end;

    return SCALE_CURVE[#SCALE_CURVE].mult;
end;

function u1.Effective(p16, p17, p18) -- Line: 226
    -- upvalues: u1 (copy)
    local v19 = u1.Rated(p17, p18);

    return v19 <= 0 and 0 or v19 * u1.Scale(u1.Get(p16, p17));
end;

function u1.Mitigate(p20, p21, p22, p23) -- Line: 236
    -- upvalues: u1 (copy)
    local v24 = tonumber(p22) or 0;

    if v24 <= 0 then
        return v24;
    end;

    local v25 = u1.Effective(p20, p21, p23);

    return v24 * (1 - math.clamp(v25, 0, u1.MAX_MITIGATION));
end;

function u1.ScaleRad(p26, p27, p28) -- Line: 245
    -- upvalues: u1 (copy)
    local v29 = tonumber(p28) or 0;

    if v29 <= 0 then
        return 0;
    end;

    if u1.IsUniform(p27) then
        return v29 * u1.Scale(u1.Get(p26, p27));
    end;

    return v29;
end;

function u1.Wear(p30, p31, p32) -- Line: 254
    -- upvalues: u1 (copy)
    local v33 = u1.Get(p30, p31);
    local v34 = tonumber(p32) or 0;

    if v34 <= 0 then
        return v33;
    end;

    return math.max(0, v33 - v34 * u1.WEAR_PER_DAMAGE);
end;

function u1.FieldMax() -- Line: 263
    -- upvalues: u1 (copy)
    local v35 = 0;

    for _, v in ipairs(u1.REPAIR_TIERS) do
        if v35 < v.max then
            v35 = v.max;
        end;
    end;

    return v35;
end;

function u1.UsableRepairs(p36) -- Line: 276
    -- upvalues: u1 (copy)
    local v37 = tonumber(p36) or u1.MAX;
    local v38 = {};

    for _, v in ipairs(u1.REPAIR_TIERS) do
        if v.min <= v37 and v37 < v.max then
            table.insert(v38, v);
        end;
    end;

    return v38;
end;

function u1.RepairTierFor(p39) -- Line: 287
    -- upvalues: u1 (copy)
    if type(p39) ~= "string" then
        return nil;
    end;

    for _, v in ipairs(u1.REPAIR_TIERS) do
        if v.item == p39 then
            return v;
        end;
    end;

    return nil;
end;

function u1.RepairResult(p40, p41) -- Line: 297
    local v42 = tonumber(p40) or 0;

    if not p41 then
        return v42;
    end;

    local math_min_ret = math.min(p41.max, v42 + p41.amount);

    return math.max(v42, math_min_ret);
end;

return u1;