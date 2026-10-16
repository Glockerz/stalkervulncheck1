-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local WeaponCondition = require(ReplicatedStorage:WaitForChild("WeaponCondition"));
local UniformCondition = require(ReplicatedStorage:WaitForChild("UniformCondition"));
local MaskCondition = require(ReplicatedStorage:WaitForChild("MaskCondition"));
local HelmetCondition = require(ReplicatedStorage:WaitForChild("HelmetCondition"));
local ArmorPlates = require(ReplicatedStorage:WaitForChild("ArmorPlates"));
local u1 = {
    CURVE_POWER = 2
};

local function durabilityOf(p2) -- Line: 55
    if type(p2) ~= "table" then
        return nil;
    end;

    local CurrentDurability = p2.CurrentDurability;

    if CurrentDurability == nil and type(p2.Metadata) == "table" then
        CurrentDurability = p2.Metadata.CurrentDurability;
    end;

    return CurrentDurability;
end;

local function ratioAgainst(p3, p4) -- Line: 66
    local v5 = tonumber(p4) or 0;

    if v5 <= 0 then
        return nil;
    end;

    local v6;

    if type(p3) == "table" then
        v6 = p3.CurrentDurability;

        if v6 == nil and type(p3.Metadata) == "table" then
            v6 = p3.Metadata.CurrentDurability;
        end;
    else
        v6 = nil;
    end;

    return type(v6) ~= "number" and 1 or math.clamp(v6, 0, v5) / v5;
end;

function u1.Ratio(p7, p8, p9) -- Line: 81
    -- upvalues: WeaponCondition (copy), UniformCondition (copy), MaskCondition (copy), HelmetCondition (copy), ArmorPlates (copy)
    if type(p8) ~= "table" then
        return nil;
    end;

    local ItemType = p8.ItemType;

    if ItemType == "Primary" or (ItemType == "Sidearm" or ItemType == "Melee") then
        local v10 = WeaponCondition.MaxFor(p8);

        if not v10 or v10 <= 0 then
            return nil;
        end;

        local v11 = WeaponCondition.Get(p7, p8);

        return math.clamp(v11, 0, v10) / v10;
    end;

    if ItemType == "Uniform" then
        if not UniformCondition.IsUniform(p8) then
            return nil;
        end;

        local v12 = UniformCondition.Get(p7, p8);

        return math.clamp(v12, 0, UniformCondition.MAX) / UniformCondition.MAX;
    end;

    if ItemType == "FaceWear" then
        if not MaskCondition.IsMask(p8) then
            return nil;
        end;

        local v13 = MaskCondition.Get(p7, p8);

        return math.clamp(v13, 0, MaskCondition.MAX) / MaskCondition.MAX;
    end;

    if ItemType == "HeadGear" then
        if not HelmetCondition.IsHelmet(p8) then
            return nil;
        end;

        local v14 = HelmetCondition.Percent(p7, p8);

        return math.clamp(v14, 0, 100) / 100;
    end;

    if ItemType == "BodyGear" then
        if not ArmorPlates.HasSoftArmor(p8) then
            return nil;
        end;

        local v15 = tonumber(p8.ArmorMaxDurability) or ArmorPlates.MAX_CONDITION;

        if v15 <= 0 then
            return nil;
        end;

        local v16 = ArmorPlates.VestCondition(p7, p8);

        return math.clamp(v16, 0, v15) / v15;
    end;

    if ItemType == "ArmorInsert" then
        local v17 = tonumber(p8.ArmorMaxDurability) or ArmorPlates.MAX_CONDITION;
        local v18 = tonumber(v17) or 0;

        if v18 <= 0 then
            return nil;
        end;

        local v19;

        if type(p7) == "table" then
            v19 = p7.CurrentDurability;

            if v19 == nil and type(p7.Metadata) == "table" then
                v19 = p7.Metadata.CurrentDurability;
            end;
        else
            v19 = nil;
        end;

        return type(v19) ~= "number" and 1 or math.clamp(v19, 0, v18) / v18;
    end;

    if ItemType ~= "MaskFilter" then
        return nil;
    end;

    local v20 = tonumber(100) or 0;

    if v20 <= 0 then
        return nil;
    end;

    local v21;

    if type(p7) == "table" then
        v21 = p7.CurrentDurability;

        if v21 == nil and type(p7.Metadata) == "table" then
            v21 = p7.Metadata.CurrentDurability;
        end;
    else
        v21 = nil;
    end;

    return type(v21) ~= "number" and 1 or math.clamp(v21, 0, v20) / v20;
end;

u1.BADGE_IMAGE = "rbxassetid://119284373011452";

function u1.BadgeColor(p22) -- Line: 142
    local v23 = tonumber(p22) or 0;
    local math_clamp_ret = math.clamp(v23, 0, 1);

    return Color3.fromHSV(math_clamp_ret / 3, 0.85, 0.95);
end;

function u1.Multiplier(p24, p25, p26) -- Line: 149
    -- upvalues: u1 (copy)
    local v27 = u1.Ratio(p24, p25, p26);

    return v27 == nil and 1 or math.clamp(v27, 0, 1) ^ u1.CURVE_POWER;
end;

function u1.UsesMultiplier(p28, p29) -- Line: 166
    -- upvalues: u1 (copy)
    if p29 then
        p29 = tonumber(p29.MaxUses);
    end;

    if not p29 or p29 <= 1 then
        return 1;
    end;

    local v30;

    if p28 then
        v30 = tonumber(p28.Uses);
    else
        v30 = p28;
    end;

    if v30 == nil and (p28 and type(p28.Metadata) == "table") then
        v30 = tonumber(p28.Metadata.Uses);
    end;

    return v30 == nil and 1 or (math.clamp(v30, 0, p29) / p29) ^ u1.CURVE_POWER;
end;

return u1;