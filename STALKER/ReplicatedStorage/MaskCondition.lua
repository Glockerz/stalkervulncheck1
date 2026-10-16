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
u1.MAX_MITIGATION = 0.95;
u1.WEAR_PER_DAMAGE = 0.25;
u1.DEATH_WEAR = 10;
u1.SOUNDS = {
    FitFilter = "rbxassetid://135825883444002",
    RemoveFilter = "rbxassetid://121394537152611",
    Charge25 = "rbxassetid://136530588997983",
    Charge10 = "rbxassetid://110259629267396"
};
u1.SOUND_RANGE = 25;
u1.CHARGE_WARNINGS = {
    {
        at = 25,
        sound = u1.SOUNDS.Charge25
    },
    {
        at = 10,
        sound = u1.SOUNDS.Charge10
    }
};

function u1.WarningCrossed(p2, p3) -- Line: 112
    -- upvalues: u1 (copy)
    local v4 = tonumber(p2);
    local v5 = tonumber(p3);

    if v4 == nil or v5 == nil then
        return nil;
    end;

    if v4 <= v5 then
        return nil;
    end;

    local v6 = nil;

    for _, v in ipairs(u1.CHARGE_WARNINGS) do
        if v.at < v4 and v5 <= v.at then
            v6 = v;
        end;
    end;

    return v6;
end;

u1.REPAIR_TIERS = { {
        item = "RespiratorServiceKit",
        min = 0,
        max = 50,
        amount = 26,
        seconds = 30
    }, {
        item = "GripTape",
        min = 20,
        max = 68,
        amount = 17,
        seconds = 22
    }, {
        item = "ClothFabric",
        min = 22,
        max = 78,
        amount = 13,
        seconds = 16
    }, {
        item = "ElectricalTape",
        min = 48,
        max = 88,
        amount = 8,
        seconds = 10
    }, {
        item = "Disenfectant",
        min = 66,
        max = 92,
        amount = 5,
        seconds = 8
    } };

function u1.IsMask(p7) -- Line: 163
    local v8;

    if type(p7) == "table" and (p7.ItemType == "FaceWear" and type(p7.RadResist) == "number") then
        v8 = p7.RadResist > 0;
    else
        v8 = false;
    end;

    return v8;
end;

function u1.TakesFilter(p9) -- Line: 192
    -- upvalues: u1 (copy)
    local v10 = u1.IsMask(p9) and p9.SelfContained ~= true;

    return v10;
end;

function u1.IsFilter(p11) -- Line: 196
    local v12;

    if type(p11) == "table" then
        v12 = p11.ItemType == "MaskFilter";
    else
        v12 = false;
    end;

    return v12;
end;

local function durabilityOf(p13) -- Line: 208
    if type(p13) ~= "table" then
        return nil;
    end;

    local CurrentDurability = p13.CurrentDurability;

    if CurrentDurability == nil and type(p13.Metadata) == "table" then
        CurrentDurability = p13.Metadata.CurrentDurability;
    end;

    return CurrentDurability;
end;

function u1.Get(p14, p15) -- Line: 224
    -- upvalues: u1 (copy)
    if not u1.IsMask(p15) then
        return u1.MAX;
    end;

    local v16;

    if type(p14) == "table" then
        v16 = p14.CurrentDurability;

        if v16 == nil and type(p14.Metadata) == "table" then
            v16 = p14.Metadata.CurrentDurability;
        end;
    else
        v16 = nil;
    end;

    if type(v16) == "number" then
        return math.clamp(v16, 0, u1.MAX);
    end;

    return u1.MAX;
end;

function u1.Scale(p17) -- Line: 235
    -- upvalues: u1 (copy)
    local v18 = tonumber(p17) or u1.MAX;
    local math_clamp_ret = math.clamp(v18, 0, u1.MAX);
    local SCALE_CURVE = u1.SCALE_CURVE;

    if SCALE_CURVE[1].at <= math_clamp_ret then
        return SCALE_CURVE[1].mult;
    end;

    for i = 1, #SCALE_CURVE - 1 do
        local v19 = SCALE_CURVE[i];
        local v20 = SCALE_CURVE[i + 1];

        if math_clamp_ret <= v19.at and v20.at <= math_clamp_ret then
            local v21 = v19.at - v20.at;

            if v21 <= 0 then
                return v20.mult;
            end;

            return v20.mult + (v19.mult - v20.mult) * ((math_clamp_ret - v20.at) / v21);
        end;

        local _ = i;
    end;

    return SCALE_CURVE[#SCALE_CURVE].mult;
end;

function u1.GetFilter(p22) -- Line: 258
    if type(p22) ~= "table" then
        return nil;
    end;

    local Metadata = p22.Metadata;

    if type(Metadata) ~= "table" then
        return nil;
    end;

    local Filter = Metadata.Filter;

    if type(Filter) == "table" and type(Filter.ID) == "string" then
        return Filter;
    end;

    return nil;
end;

function u1.FitDefaultFilter(p23, p24, p25) -- Line: 275
    -- upvalues: u1 (copy)
    if type(p23) ~= "table" then
        return false;
    end;

    if not u1.IsMask(p24) then
        return false;
    end;

    if u1.GetFilter(p23) then
        return false;
    end;

    local DefaultFilter = p24.DefaultFilter;

    if type(DefaultFilter) ~= "string" then
        return false;
    end;

    local v26 = p25 and p25.GetItemData and p25.GetItemData(DefaultFilter);

    if not u1.IsFilter(v26) then
        return false;
    end;

    p23.Metadata = p23.Metadata or {};
    p23.Metadata.Filter = {
        ID = DefaultFilter
    };

    return true;
end;

function u1.FilterCharge(p27) -- Line: 293
    if type(p27) ~= "table" then
        return 0;
    end;

    local CurrentDurability = p27.CurrentDurability;

    return type(CurrentDurability) ~= "number" and 100 or math.clamp(CurrentDurability, 0, 100);
end;

function u1.HasActiveFilter(p28) -- Line: 317
    -- upvalues: u1 (copy)
    local Filter = u1.GetFilter(p28);

    if Filter then
        return u1.FilterCharge(Filter) > 0;
    end;

    return false;
end;

function u1.FilterCap(p29, p30) -- Line: 327
    -- upvalues: u1 (copy)
    local Filter = u1.GetFilter(p29);

    if not Filter then
        return 0;
    end;

    if u1.FilterCharge(Filter) <= 0 then
        return 0;
    end;

    local v31 = p30 and p30.GetItemData and p30.GetItemData(Filter.ID);

    if not u1.IsFilter(v31) then
        return 0;
    end;

    local v32 = tonumber(v31.FilterCap) or 0;

    return math.clamp(v32, 0, 1);
end;

function u1.FilterWeight(p33, p34) -- Line: 351
    -- upvalues: u1 (copy)
    local Filter = u1.GetFilter(p33);

    if not Filter then
        return 0;
    end;

    if not Filter.ID then
        return 0;
    end;

    if not p34 then
        return 0;
    end;

    local ItemData = p34.GetItemData(Filter.ID);

    return u1.IsFilter(ItemData) and (tonumber(ItemData.Weight) or 0) or 0;
end;

function u1.EffectiveWith(p35, p36, p37) -- Line: 370
    -- upvalues: u1 (copy)
    if not u1.IsMask(p35) then
        return 0;
    end;

    local v38 = tonumber(p35.SelfContained == true and 1 or p37) or 0;
    local math_clamp_ret = math.clamp(v38, 0, 1);

    if math_clamp_ret <= 0 then
        return 0;
    end;

    local v39 = p35.RadResist * u1.Scale(p36) * math_clamp_ret;

    return math.clamp(v39, 0, u1.MAX_MITIGATION);
end;

function u1.Effective(p40, p41, p42) -- Line: 392
    -- upvalues: u1 (copy)
    return not u1.IsMask(p41) and 0 or u1.EffectiveWith(p41, u1.Get(p40, p41), u1.FilterCap(p40, p42));
end;

function u1.CapOf(p43, p44) -- Line: 400
    -- upvalues: u1 (copy)
    if not u1.IsFilter(p43) then
        return 0;
    end;

    if (tonumber(p44) or 0) <= 0 then
        return 0;
    end;

    local v45 = tonumber(p43.FilterCap) or 0;

    return math.clamp(v45, 0, 1);
end;

function u1.Wear(p46, p47, p48) -- Line: 409
    -- upvalues: u1 (copy)
    local v49 = u1.Get(p46, p47);
    local v50 = tonumber(p48) or 0;

    if v50 <= 0 then
        return v49;
    end;

    return math.max(0, v49 - v50 * u1.WEAR_PER_DAMAGE);
end;

function u1.CrackLevel(p51) -- Line: 420
    -- upvalues: u1 (copy)
    local v52 = tonumber(p51) or u1.MAX;
    local v53 = (100 - math.clamp(v52, 0, u1.MAX)) / 10 + 0.5;
    local math_floor_ret = math.floor(v53);

    return math.clamp(math_floor_ret, 0, 10);
end;

function u1.DrainPerSecond(p54) -- Line: 429
    -- upvalues: u1 (copy)
    if not u1.IsFilter(p54) then
        return 0;
    end;

    local v55 = tonumber(p54.FilterSeconds) or 0;

    return v55 <= 0 and 0 or 100 / v55;
end;

function u1.UsableRepairs(p56) -- Line: 441
    -- upvalues: u1 (copy)
    local v57 = tonumber(p56) or u1.MAX;
    local v58 = {};

    for _, v in ipairs(u1.REPAIR_TIERS) do
        if v.min <= v57 and v57 < v.max then
            table.insert(v58, v);
        end;
    end;

    return v58;
end;

function u1.RepairTierFor(p59) -- Line: 452
    -- upvalues: u1 (copy)
    if type(p59) ~= "string" then
        return nil;
    end;

    for _, v in ipairs(u1.REPAIR_TIERS) do
        if v.item == p59 then
            return v;
        end;
    end;

    return nil;
end;

function u1.RepairResult(p60, p61) -- Line: 462
    local v62 = tonumber(p60) or 0;

    if not p61 then
        return v62;
    end;

    local math_min_ret = math.min(p61.max, v62 + p61.amount);

    return math.max(v62, math_min_ret);
end;

function u1.FieldMax() -- Line: 470
    -- upvalues: u1 (copy)
    local v63 = 0;

    for _, v in ipairs(u1.REPAIR_TIERS) do
        if v63 < v.max then
            v63 = v.max;
        end;
    end;

    return v63;
end;

return u1;