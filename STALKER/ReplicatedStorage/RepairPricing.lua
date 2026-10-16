-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ConditionValue = require(ReplicatedStorage:WaitForChild("ConditionValue"));
local WeaponCondition = require(ReplicatedStorage:WaitForChild("WeaponCondition"));
local UniformCondition = require(ReplicatedStorage:WaitForChild("UniformCondition"));
local MaskCondition = require(ReplicatedStorage:WaitForChild("MaskCondition"));
local HelmetCondition = require(ReplicatedStorage:WaitForChild("HelmetCondition"));
local ArmorPlates = require(ReplicatedStorage:WaitForChild("ArmorPlates"));
local u1 = {
    RATE = 0.95,
    POWER = 3,
    MIN_FEE = 200,
    COMPLEXITY = {
        Melee = 0.7,
        Uniform = 0.8,
        BodyGear = 0.9,
        Primary = 1,
        Sidearm = 1,
        HeadGear = 1,
        FaceWear = 1.1
    }
};

function u1.Complexity(p2) -- Line: 134
    -- upvalues: u1 (copy), WeaponCondition (copy), UniformCondition (copy), MaskCondition (copy), HelmetCondition (copy), ArmorPlates (copy)
    if type(p2) ~= "table" then
        return nil;
    end;

    local ItemType = p2.ItemType;
    local v3 = u1.COMPLEXITY[ItemType];

    if not v3 then
        return nil;
    end;

    if ItemType == "Primary" or (ItemType == "Sidearm" or ItemType == "Melee") then
        local v4 = WeaponCondition.MaxFor(p2);

        if not v4 or v4 <= 0 then
            return nil;
        end;
    elseif ItemType == "Uniform" then
        if not UniformCondition.IsUniform(p2) then
            return nil;
        end;
    elseif ItemType == "FaceWear" then
        if not MaskCondition.IsMask(p2) then
            return nil;
        end;
    elseif ItemType == "HeadGear" then
        if not HelmetCondition.IsHelmet(p2) then
            return nil;
        end;
    elseif ItemType == "BodyGear" and not ArmorPlates.HasSoftArmor(p2) then
        return nil;
    end;

    return v3;
end;

function u1.MaxFor(p5) -- Line: 173
    -- upvalues: WeaponCondition (copy), UniformCondition (copy), MaskCondition (copy), HelmetCondition (copy), ArmorPlates (copy)
    if type(p5) ~= "table" then
        return nil;
    end;

    local ItemType = p5.ItemType;

    if ItemType == "Primary" or (ItemType == "Sidearm" or ItemType == "Melee") then
        return WeaponCondition.MaxFor(p5);
    end;

    if ItemType == "Uniform" then
        return UniformCondition.MAX;
    end;

    if ItemType == "FaceWear" then
        return MaskCondition.MAX;
    end;

    if ItemType == "HeadGear" then
        return HelmetCondition.MaxOf(p5);
    end;

    if ItemType == "BodyGear" then
        return tonumber(p5.ArmorMaxDurability) or ArmorPlates.MAX_CONDITION;
    end;

    return nil;
end;

function u1.Quote(p6, p7, p8) -- Line: 199
    -- upvalues: u1 (copy), ConditionValue (copy)
    local v9 = u1.Complexity(p7);

    if not v9 then
        return nil;
    end;

    local v10 = ConditionValue.Ratio(p6, p7, p8);

    if v10 == nil then
        return nil;
    end;

    local math_clamp_ret = math.clamp(v10, 0, 1);
    local math_floor_ret = math.floor(math_clamp_ret * 100 + 0.5);
    local v11 = math_floor_ret < 100;
    local v12;

    if v11 then
        local v13 = (tonumber(p7.BaseSellValue) or 0) * v9 * u1.RATE * (1 - math_clamp_ret ^ u1.POWER);
        local MIN_FEE = u1.MIN_FEE;
        local math_ceil_ret = math.ceil(v13);
        v12 = math.max(MIN_FEE, math_ceil_ret);
    else
        v12 = 0;
    end;

    return {
        ratio = math_clamp_ret,
        percent = math_floor_ret,
        needed = v11,
        cost = v12
    };
end;

function u1.RestoreFull(p14, p15) -- Line: 233
    -- upvalues: u1 (copy)
    if type(p14) ~= "table" then
        return nil;
    end;

    local v16 = u1.MaxFor(p15);

    if not v16 then
        return nil;
    end;

    p14.CurrentDurability = v16;

    if type(p14.Metadata) == "table" then
        p14.Metadata.CurrentDurability = v16;
    end;

    return v16;
end;

return u1;