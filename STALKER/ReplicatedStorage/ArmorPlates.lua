-- Decompiled with Potassium's decompiler.

local UniformCondition = require(script.Parent:WaitForChild("UniformCondition"));
local u5 = {
    INSERT_MIN_VEST_CONDITION = 30,
    RUPTURE_WEAR = 4,
    MAX_MITIGATION = 0.95,
    SOFT_PROFILE = "soft",
    CERAMIC_PROFILE = "ceramic",
    MAX_CONDITION = 100,
    DEATH_WEAR = 10,

    IsBodyGear = function(p1) -- Line: 73, Name: IsBodyGear
        local v2;

        if type(p1) == "table" then
            v2 = p1.ItemType == "BodyGear";
        else
            v2 = false;
        end;

        return v2;
    end,

    IsInsert = function(p3) -- Line: 77, Name: IsInsert
        local v4;

        if type(p3) == "table" then
            v4 = p3.ItemType == "ArmorInsert";
        else
            v4 = false;
        end;

        return v4;
    end
};

function u5.HasSoftArmor(p6) -- Line: 81
    -- upvalues: u5 (copy)
    local v7 = u5.IsBodyGear(p6) and type(p6.SoftArmorClass) == "number";

    return v7;
end;

function u5.AcceptsInsert(p8) -- Line: 85
    -- upvalues: u5 (copy)
    local v9 = u5.IsBodyGear(p8) and p8.AcceptsInsert == true;

    return v9;
end;

function u5.KindOf(p10) -- Line: 91
    if type(p10) ~= "table" or p10.ItemType ~= "BodyGear" then
        return nil;
    end;

    local v11 = type(p10.SoftArmorClass) == "number";
    local v12 = p10.AcceptsInsert == true;

    return v11 and v12 and "SoftSlot" or (v11 and "Integrated" or (v12 and "Carrier" or "Rig"));
end;

function u5.GetInsert(p13) -- Line: 117
    if type(p13) ~= "table" then
        return nil;
    end;

    local Metadata = p13.Metadata;

    if type(Metadata) == "table" and type(Metadata.Insert) == "table" then
        return Metadata.Insert;
    end;

    if type(p13.Insert) == "table" then
        return p13.Insert;
    end;

    return nil;
end;

local function conditionOf(p14, p15) -- Line: 129
    if p14 == nil then
        return p15;
    end;

    local v16 = tonumber(p14);

    if v16 == nil then
        return p15;
    end;

    return math.clamp(v16, 0, p15);
end;

function u5.VestCondition(p17, p18) -- Line: 161
    -- upvalues: u5 (copy)
    if not u5.HasSoftArmor(p18) then
        return 0;
    end;

    local v19 = tonumber(p18.ArmorMaxDurability) or u5.MAX_CONDITION;
    local v20;

    if type(p17) == "table" then
        v20 = p17.CurrentDurability;

        if v20 == nil and type(p17.Metadata) == "table" then
            v20 = p17.Metadata.CurrentDurability;
        end;
    else
        v20 = nil;
    end;

    if v20 == nil then
        return v19;
    end;

    local v21 = tonumber(v20);

    if v21 == nil then
        return v19;
    end;

    return math.clamp(v21, 0, v19);
end;

function u5.InsertCondition(p22, p23) -- Line: 175
    -- upvalues: u5 (copy)
    if type(p22) ~= "table" then
        return 0;
    end;

    if p23 then
        p23 = p23.ArmorMaxDurability;
    end;

    local v24 = tonumber(p23) or u5.MAX_CONDITION;
    local CurrentDurability = p22.CurrentDurability;

    if CurrentDurability == nil then
        return v24;
    end;

    local v25 = tonumber(CurrentDurability);

    if v25 == nil then
        return v24;
    end;

    return math.clamp(v25, 0, v24);
end;

function u5.ScaleFor(p26, p27, p28) -- Line: 187
    -- upvalues: u5 (copy), UniformCondition (copy)
    local v29 = tonumber(p28) or u5.MAX_CONDITION;

    if v29 <= 0 then
        return 0;
    end;

    local v30 = tonumber(p27) or v29;
    local math_clamp_ret = math.clamp(v30, 0, v29);

    if p26 == u5.SOFT_PROFILE then
        return UniformCondition.Scale(math_clamp_ret / v29 * UniformCondition.MAX);
    end;

    return math_clamp_ret / v29;
end;

function u5.Layer(p31, p32, p33) -- Line: 237
    -- upvalues: u5 (copy)
    local v34 = nil;
    local Insert = u5.GetInsert(p31);

    if not u5.AcceptsInsert(p32) then
        Insert = nil;
    end;

    if Insert and (Insert.ID and p33) then
        local ItemData = p33.GetItemData(Insert.ID);

        if u5.IsInsert(ItemData) then
            local v35 = u5.InsertCondition(Insert, ItemData);

            if v35 > 0 then
                local v36 = tonumber(ItemData.ArmorMaxDurability) or u5.MAX_CONDITION;
                v34 = {
                    source = "Insert",
                    class = tonumber(ItemData.ArmorClass) or 0,
                    rupture = tonumber(ItemData.RuptureResist) or 0,
                    cond = v35,
                    maxCond = v36,
                    scale = u5.ScaleFor(ItemData.WearProfile or u5.CERAMIC_PROFILE, v35, v36),
                    insertEntry = Insert,
                    insertDb = ItemData
                };
            end;
        end;
    end;

    if u5.HasSoftArmor(p32) then
        local v37 = tonumber(p32.ArmorMaxDurability) or u5.MAX_CONDITION;
        local v38 = u5.VestCondition(p31, p32);
        local v39 = {
            source = "Soft",
            class = tonumber(p32.SoftArmorClass) or 0,
            rupture = tonumber(p32.RuptureResist) or 0,
            cond = v38,
            maxCond = v37,
            scale = u5.ScaleFor(u5.SOFT_PROFILE, v38, v37)
        };

        if v34 == nil then
            return v39;
        end;

        if v39.class > v34.class then
            return v39;
        end;
    end;

    return v34;
end;

function u5.InsertWeight(p40, p41) -- Line: 304
    -- upvalues: u5 (copy)
    local Insert = u5.GetInsert(p40);

    if not Insert then
        return 0;
    end;

    if not Insert.ID then
        return 0;
    end;

    if not p41 then
        return 0;
    end;

    local ItemData = p41.GetItemData(Insert.ID);

    return u5.IsInsert(ItemData) and (tonumber(ItemData.Weight) or 0) or 0;
end;

function u5.CanFitInsert(p42, p43) -- Line: 323
    -- upvalues: u5 (copy)
    if not u5.AcceptsInsert(p43) then
        return false, "This vest has no plate pocket";
    end;

    if u5.GetInsert(p42) then
        return false, "Remove the current plate first";
    end;

    if u5.HasSoftArmor(p43) then
        local v44 = tonumber(p43.ArmorMaxDurability) or u5.MAX_CONDITION;

        if u5.VestCondition(p42, p43) / v44 * 100 < u5.INSERT_MIN_VEST_CONDITION then
            return false, "Vest Too Damaged";
        end;
    end;

    return true, nil;
end;

function u5.FitDefaultInsert(p45, p46, p47) -- Line: 359
    -- upvalues: u5 (copy)
    if type(p45) ~= "table" or not u5.AcceptsInsert(p46) then
        return false;
    end;

    if type(p46.DefaultInsert) ~= "string" then
        return false;
    end;

    if u5.GetInsert(p45) then
        return false;
    end;

    if p47 then
        p47 = p47.GetItemData(p46.DefaultInsert);
    end;

    if not u5.IsInsert(p47) then
        return false;
    end;

    p45.Metadata = p45.Metadata or {};
    p45.Metadata.Insert = {
        ID = p46.DefaultInsert
    };

    return true;
end;

return u5;