-- Decompiled with Potassium's decompiler.

local u1 = {
    Donations = { {
            amount = 100,
            productId = 3717624508
        }, {
            amount = 250,
            productId = 3717624533
        }, {
            amount = 500,
            productId = 3717624550
        }, {
            amount = 1000,
            productId = 3717624564
        }, {
            amount = 5000,
            productId = 3717624591
        }, {
            amount = 10000,
            productId = 3717624617
        } },
    BOARD_SIZE = 10,
    BOARD_REFRESH = 120,
    LEDGER_KEEP = 200,
    EXCLUDED = {
        [require(script.Parent:WaitForChild("InsuranceRules")).FULL_COVERAGE_PRODUCT_ID] = true
    }
};

function u1.Counts(p2) -- Line: 43
    -- upvalues: u1 (copy)
    local v3;

    if type(p2) == "number" and p2 > 0 then
        v3 = not u1.EXCLUDED[p2];
    else
        v3 = false;
    end;

    return v3;
end;

function u1.LedgerAdd(p4: any, p5: string, p6: any) -- Line: 51
    -- upvalues: u1 (copy)
    if type(p6) ~= "number" or p6 <= 0 then
        return nil;
    end;

    local v7 = type(p4) == "table" and p4 and p4 or {};
    local v8 = type(v7.seen) == "table" and (v7.seen or {}) or {};

    if v8[p5] then
        return nil;
    end;

    local v9 = {
        spent = (tonumber(v7.spent) or 0) + math.floor(p6),
        seen = table.clone(v8),
        order = table.clone(type(v7.order) == "table" and (v7.order or {}) or {})
    };
    v9.seen[p5] = true;
    table.insert(v9.order, p5);

    while #v9.order > u1.LEDGER_KEEP do
        v9.seen[table.remove(v9.order, 1)] = nil;
    end;

    return v9;
end;

function u1.Total(p10: any, p11: number) -- Line: 67
    return (type(p10) == "table" and (tonumber(p10.spent) or 0) or 0) + (tonumber(p11) or 0);
end;

function u1.FormatRobux(p12: number) -- Line: 72
    local math_floor_ret = math.floor(p12);

    return "R$ " .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

return u1;