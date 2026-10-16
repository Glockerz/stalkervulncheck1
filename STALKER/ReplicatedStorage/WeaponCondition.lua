-- Decompiled with Potassium's decompiler.

local u1 = {
    MAX = 100,
    WEAR_PER_ROUND = 0.05,
    DEATH_WEAR = 10,
    BANDS = { {
            floor = 60,
            spreadAdd = 0,
            tier = "Oil"
        }, {
            floor = 35,
            spreadAdd = 1,
            tier = "Toolset"
        }, {
            floor = 15,
            spreadAdd = 2,
            tier = "Gunsmith"
        }, {
            floor = 0,
            spreadAdd = 3,
            tier = "Trader"
        } },
    JAM_CURVE = { {
            at = 100,
            chance = 0.002
        }, {
            at = 85,
            chance = 0.005
        }, {
            at = 70,
            chance = 0.02
        }, {
            at = 50,
            chance = 0.08
        }, {
            at = 35,
            chance = 0.15
        }, {
            at = 20,
            chance = 0.25
        }, {
            at = 10,
            chance = 0.35
        }, {
            at = 0,
            chance = 0.6
        } },
    REPAIR_TIERS = { {
            item = "ElectricalTape",
            min = 0,
            max = 25,
            amount = 6,
            seconds = 10
        }, {
            item = "WD40",
            min = 5,
            max = 45,
            amount = 10,
            seconds = 15
        }, {
            item = "Toolset",
            min = 15,
            max = 70,
            amount = 22,
            seconds = 25
        }, {
            item = "GunsmithingTools",
            min = 0,
            max = 80,
            amount = 30,
            seconds = 30
        }, {
            item = "GunCleaningLubricant",
            min = 45,
            max = 92,
            amount = 10,
            seconds = 20
        } },
    MODIFY_SECONDS = 30,
    WORK_SOUND = "rbxassetid://80151872271332"
};

function u1.FieldMax() -- Line: 126
    -- upvalues: u1 (copy)
    local v2 = 0;

    for _, v in ipairs(u1.REPAIR_TIERS) do
        if v2 < v.max then
            v2 = v.max;
        end;
    end;

    return v2;
end;

function u1.UsableRepairs(p3) -- Line: 141
    -- upvalues: u1 (copy)
    local v4 = tonumber(p3) or u1.MAX;
    local v5 = {};

    for _, v in ipairs(u1.REPAIR_TIERS) do
        if v.min <= v4 and v4 < v.max then
            table.insert(v5, v);
        end;
    end;

    return v5;
end;

function u1.RepairTierFor(p6) -- Line: 153
    -- upvalues: u1 (copy)
    if type(p6) ~= "string" then
        return nil;
    end;

    for _, v in ipairs(u1.REPAIR_TIERS) do
        if v.item == p6 then
            return v;
        end;
    end;

    return nil;
end;

function u1.RepairResult(p7, p8) -- Line: 163
    local v9 = tonumber(p7) or 0;

    if not p8 then
        return v9;
    end;

    local math_min_ret = math.min(p8.max, v9 + p8.amount);

    return math.max(v9, math_min_ret);
end;

function u1.IsWeapon(p10) -- Line: 177
    if type(p10) ~= "table" then
        return false;
    end;

    if p10.ItemType ~= "Primary" and p10.ItemType ~= "Sidearm" then
        return false;
    end;

    local v11;

    if type(p10.ToolName) == "string" then
        v11 = p10.ToolName ~= "";
    else
        v11 = false;
    end;

    return v11;
end;

function u1.MaxFor(p12) -- Line: 185
    -- upvalues: u1 (copy)
    if p12 then
        p12 = p12.WeaponMaxDurability;
    end;

    if type(p12) == "number" and p12 > 0 then
        return p12;
    end;

    return u1.MAX;
end;

function u1.Get(p13, p14) -- Line: 198
    -- upvalues: u1 (copy)
    local v15 = u1.MaxFor(p14);

    if p13 then
        p13 = p13.CurrentDurability;
    end;

    if type(p13) == "number" then
        return math.clamp(p13, 0, v15);
    end;

    return v15;
end;

function u1.Band(p16) -- Line: 205
    -- upvalues: u1 (copy)
    local v17 = tonumber(p16) or u1.MAX;

    for _, v in ipairs(u1.BANDS) do
        if v.floor <= v17 then
            return v;
        end;
    end;

    return u1.BANDS[#u1.BANDS];
end;

function u1.SpreadAdd(p18) -- Line: 213
    -- upvalues: u1 (copy)
    return u1.Band(p18).spreadAdd;
end;

function u1.JamChance(p19) -- Line: 217
    -- upvalues: u1 (copy)
    local v20 = tonumber(p19) or u1.MAX;
    local math_clamp_ret = math.clamp(v20, 0, u1.MAX);
    local JAM_CURVE = u1.JAM_CURVE;

    if JAM_CURVE[1].at <= math_clamp_ret then
        return JAM_CURVE[1].chance;
    end;

    for i = 1, #JAM_CURVE - 1 do
        local v21 = JAM_CURVE[i];
        local v22 = JAM_CURVE[i + 1];

        if math_clamp_ret <= v21.at and v22.at <= math_clamp_ret then
            local v23 = v21.at - v22.at;

            return v22.chance + (v21.chance - v22.chance) * (v23 > 0 and ((math_clamp_ret - v22.at) / v23 or 0) or 0);
        end;

        local _ = i;
    end;

    return JAM_CURVE[#JAM_CURVE].chance;
end;

function u1.RepairTier(p24) -- Line: 232
    -- upvalues: u1 (copy)
    return u1.Band(p24).tier;
end;

function u1.SellMult(p25, p26) -- Line: 242
    -- upvalues: u1 (copy)
    local v27 = u1.MaxFor(p26);
    local v28 = (tonumber(p25) or v27) / v27;

    return math.clamp(v28, 0, 1) * 0.6 + 0.4;
end;

function u1.ApplySpread(p29, p30) -- Line: 256
    -- upvalues: u1 (copy)
    return (tonumber(p29) or 0) + u1.SpreadAdd(p30);
end;

u1.ATTR = "WeaponCondition";

function u1.WriteToTool(p31, p32) -- Line: 267
    -- upvalues: u1 (copy)
    if typeof(p31) ~= "Instance" then
        return;
    end;

    local ATTR = u1.ATTR;
    local v33 = tonumber(p32) or u1.MAX;
    p31:SetAttribute(ATTR, (math.clamp(v33, 0, u1.MAX)));
end;

function u1.CaptureFromTool(p34, p35) -- Line: 283
    -- upvalues: u1 (copy)
    if type(p34) ~= "table" or typeof(p35) ~= "Instance" then
        return;
    end;

    local Attribute = p35:GetAttribute(u1.ATTR);

    if type(Attribute) ~= "number" then
        return;
    end;

    p34.CurrentDurability = math.clamp(Attribute, 0, u1.MAX);
end;

u1.CYCLE_ATTR = "_JamEatsCycle";

function u1.OnShot(p36, p37, p38) -- Line: 309
    -- upvalues: u1 (copy)
    if typeof(p36) ~= "Instance" then
        return;
    end;

    local Attribute = p36:GetAttribute(u1.ATTR);

    if type(Attribute) ~= "number" then
        return;
    end;

    local v39 = Attribute - u1.WEAR_PER_ROUND;
    u1.WriteToTool(p36, v39);
    local v40 = u1.JamChance(v39);
    local v41;

    if v40 > 0 then
        v41 = (p38 or math.random)() < v40;
    else
        v41 = false;
    end;

    p36:SetAttribute("WeaponJammed", v41);
    p36:SetAttribute(u1.CYCLE_ATTR, v41 and p37 and p37 or nil);
end;

function u1.CycleClearsJam(p42) -- Line: 324
    -- upvalues: u1 (copy)
    if typeof(p42) ~= "Instance" then
        return true;
    end;

    if p42:GetAttribute("WeaponJammed") and p42:GetAttribute(u1.CYCLE_ATTR) then
        p42:SetAttribute(u1.CYCLE_ATTR, nil);

        return false;
    end;

    p42:SetAttribute("WeaponJammed", false);
    p42:SetAttribute(u1.CYCLE_ATTR, nil);

    return true;
end;

return u1;