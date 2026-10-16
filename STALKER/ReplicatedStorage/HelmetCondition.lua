-- Decompiled with Potassium's decompiler.

local u3 = {
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
        } },
    REPAIR_TIERS = { {
            item = "HeadGearRepairKit",
            min = 0,
            max = 45,
            amount = 30,
            seconds = 30
        }, {
            item = "HelmetSteelPlateInserts",
            min = 20,
            max = 92,
            amount = 14,
            seconds = 18,
            material = "Steel"
        }, {
            item = "AramidFabrics",
            min = 20,
            max = 92,
            amount = 14,
            seconds = 18,
            material = "Aramid"
        } },

    IsHelmet = function(p1) -- Line: 65, Name: IsHelmet
        local v2;

        if type(p1) == "table" and (p1.ItemType == "HeadGear" and (type(p1.ArmorClass) == "number" and type(p1.ArmorMaxDurability) == "number")) then
            v2 = p1.ArmorMaxDurability > 0;
        else
            v2 = false;
        end;

        return v2;
    end
};

function u3.MaxOf(p4) -- Line: 75
    -- upvalues: u3 (copy)
    return not u3.IsHelmet(p4) and 0 or p4.ArmorMaxDurability;
end;

local function durabilityOf(p5) -- Line: 86
    if type(p5) ~= "table" then
        return nil;
    end;

    local CurrentDurability = p5.CurrentDurability;

    if CurrentDurability == nil and type(p5.Metadata) == "table" then
        CurrentDurability = p5.Metadata.CurrentDurability;
    end;

    return CurrentDurability;
end;

function u3.Get(p6, p7) -- Line: 100
    -- upvalues: u3 (copy)
    local v8 = u3.MaxOf(p7);

    if v8 <= 0 then
        return 0;
    end;

    local v9;

    if type(p6) == "table" then
        v9 = p6.CurrentDurability;

        if v9 == nil and type(p6.Metadata) == "table" then
            v9 = p6.Metadata.CurrentDurability;
        end;
    else
        v9 = nil;
    end;

    if type(v9) == "number" then
        return math.clamp(v9, 0, v8);
    end;

    return v8;
end;

function u3.Percent(p10, p11) -- Line: 110
    -- upvalues: u3 (copy)
    local v12 = u3.MaxOf(p11);

    if v12 <= 0 then
        return 0;
    end;

    local v13 = u3.Get(p10, p11) / v12 * 100;

    return math.clamp(v13, 0, 100);
end;

function u3.Scale(p14) -- Line: 120
    -- upvalues: u3 (copy)
    local v15 = tonumber(p14) or 100;
    local math_clamp_ret = math.clamp(v15, 0, 100);
    local SCALE_CURVE = u3.SCALE_CURVE;

    if SCALE_CURVE[1].at <= math_clamp_ret then
        return SCALE_CURVE[1].mult;
    end;

    for i = 1, #SCALE_CURVE - 1 do
        local v16 = SCALE_CURVE[i];
        local v17 = SCALE_CURVE[i + 1];

        if math_clamp_ret <= v16.at and v17.at <= math_clamp_ret then
            local v18 = v16.at - v17.at;

            if v18 <= 0 then
                return v17.mult;
            end;

            return v17.mult + (v16.mult - v17.mult) * ((math_clamp_ret - v17.at) / v18);
        end;

        local _ = i;
    end;

    return SCALE_CURVE[#SCALE_CURVE].mult;
end;

function u3.Material(p19) -- Line: 143
    -- upvalues: u3 (copy)
    if not u3.IsHelmet(p19) then
        return nil;
    end;

    local HelmetMaterial = p19.HelmetMaterial;

    if HelmetMaterial == "Steel" or HelmetMaterial == "Aramid" then
        return HelmetMaterial;
    end;

    return nil;
end;

function u3.TierMatchesMaterial(p20, p21) -- Line: 152
    -- upvalues: u3 (copy)
    if type(p20) == "table" then
        return p20.material == nil and true or p20.material == u3.Material(p21);
    end;

    return false;
end;

function u3.UsableRepairs(p22, p23) -- Line: 159
    -- upvalues: u3 (copy)
    local v24 = tonumber(p22) or 0;
    local v25 = {};

    for _, v in ipairs(u3.REPAIR_TIERS) do
        if v.min <= v24 and (v24 < v.max and u3.TierMatchesMaterial(v, p23)) then
            table.insert(v25, v);
        end;
    end;

    return v25;
end;

function u3.RepairTierFor(p26, p27) -- Line: 176
    -- upvalues: u3 (copy)
    for _, v in ipairs(u3.REPAIR_TIERS) do
        if v.item == p26 then
            if p27 == nil or u3.TierMatchesMaterial(v, p27) then
                return v;
            end;

            return nil;
        end;
    end;

    return nil;
end;

function u3.RepairResult(p28, p29) -- Line: 191
    local v30 = tonumber(p28) or 0;

    if not p29 then
        return v30;
    end;

    local math_min_ret = math.min(p29.max, v30 + p29.amount);

    return math.max(v30, math_min_ret);
end;

function u3.ApplyRepair(p31, p32, p33) -- Line: 207
    -- upvalues: u3 (copy)
    local v34 = u3.MaxOf(p32);

    if v34 <= 0 or type(p31) ~= "table" then
        return false;
    end;

    local v35 = u3.RepairResult(u3.Percent(p31, p32), p33) / 100 * v34 * 100 + 0.5;
    p31.CurrentDurability = math.floor(v35) / 100;

    return true;
end;

function u3.FieldMax(p36) -- Line: 222
    -- upvalues: u3 (copy)
    local v37 = 0;

    for _, v in ipairs(u3.REPAIR_TIERS) do
        if (p36 == nil or u3.TierMatchesMaterial(v, p36)) and v37 < v.max then
            v37 = v.max;
        end;
    end;

    return v37;
end;

return u3;