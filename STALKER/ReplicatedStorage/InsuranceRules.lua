-- Decompiled with Potassium's decompiler.

local u1 = {
    RATE = 0.08,
    MIN_FEE = 250,
    ROUND_TO = 50,
    MIN_VALUE = 1000,
    WEAR_PCT = 0.1,
    FULL_COVERAGE_PRODUCT_ID = 3717623887,
    SLOTS = { "Primary", "Secondary", "Sidearm", "Melee", "Head", "FaceWear", "EyeWear", "NightOptical", "Body", "BeltGear", "Backpack" }
};
local u2 = {};

for _, v in ipairs(u1.SLOTS) do
    u2[v] = true;
end;

function u1.Fee(p3) -- Line: 26
    -- upvalues: u1 (copy)
    local v4 = tonumber(p3);

    if not (v4 and (v4 == v4 and v4 >= u1.MIN_VALUE)) then
        return nil;
    end;

    local v5 = math.floor(v4 * u1.RATE / u1.ROUND_TO + 0.5) * u1.ROUND_TO;

    return math.max(u1.MIN_FEE, v5);
end;

function u1.Eligible(p6: string, p7: any, p8: any) -- Line: 33
    -- upvalues: u2 (copy), u1 (copy)
    if not u2[p6] then
        return false;
    end;

    if type(p7) ~= "table" or type(p8) ~= "table" then
        return false;
    end;

    if p7.NonDroppable == true or p8.TaskBound then
        return false;
    end;

    return u1.Fee(p7.BaseSellValue) ~= nil;
end;

function u1.Worn(p9, p10) -- Line: 41
    -- upvalues: u1 (copy)
    if type(p10) ~= "number" or p10 <= 0 then
        return nil;
    end;

    if type(p9) ~= "number" then
        p9 = p10;
    end;

    local v11 = math.clamp(p9, 0, p10) - p10 * u1.WEAR_PCT;

    return math.max(0, v11);
end;

function u1.Selection(p12: table, p13: any) -- Line: 49
    if type(p13) ~= "table" then
        return nil;
    end;

    local v14 = {};
    local v15 = 0;

    for i, v in pairs(p13) do
        if type(i) ~= "number" or (type(v) ~= "string" or (not p12[v] or v14[v])) then
            return nil;
        end;

        v14[v] = true;
        v15 = v15 + 1;
    end;

    if v15 == 0 then
        return nil;
    end;

    return v14;
end;

return u1;