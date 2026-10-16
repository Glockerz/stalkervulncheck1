-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {
    ClearSky = "Clear Sky",
    Loner = "Loner",
    Ecologist = "Ecologist",
    Mercenary = "Mercenary"
};

local function buysNothing(p3) -- Line: 11
    if p3.BuysEverything then
        return false;
    end;

    return type(p3.Buys) ~= "table" and true or #p3.Buys == 0;
end;

function v1.Subline(p4) -- Line: 18
    -- upvalues: u2 (copy)
    if type(p4) ~= "table" then
        return "";
    end;

    local v5 = {};

    if type(p4.RepFaction) == "string" then
        table.insert(v5, u2[p4.RepFaction] or p4.RepFaction);
        local v6 = type(p4.Standing) == "string" and (p4.Standing or "Neutral") or "Neutral";
        table.insert(v5, v6);
    end;

    local v7;

    if p4.BuysEverything then
        v7 = false;
    else
        v7 = type(p4.Buys) ~= "table" and true or #p4.Buys == 0;
    end;

    if v7 then
        if #v5 > 0 then
            table.insert(v5, "buys nothing");
        end;
    elseif type(p4.BuybackMultiplier) == "number" and p4.BuybackMultiplier > 0 then
        local math_floor_ret = math.floor(p4.BuybackMultiplier * 100 + 0.5);
        table.insert(v5, ("buys at %d%%"):format(math_floor_ret));
    end;

    return table.concat(v5, "  /  ");
end;

function v1.Counts(p8: table) -- Line: 34
    local v9 = {
        All = #p8
    };

    for _, v in ipairs(p8) do
        local Category = v.Category;

        if type(Category) == "string" and Category ~= "All" then
            v9[Category] = (v9[Category] or 0) + 1;
        end;
    end;

    return v9;
end;

function v1.TabVisible(p10: string, p11: number?, p12: boolean) -- Line: 45
    return p10 == "All" and true or (p12 or (p11 or 0) > 0);
end;

function v1.Summary(p13: string, p14: number, p15: number, p16: number) -- Line: 52
    if p13 == "REPAIR" then
        return {
            short = false,
            enabled = false,
            confirm = "CONFIRM",
            title = "REPAIR",
            after = p16
        };
    end;

    local v17 = p13 == "BUY";
    local v18 = v17 and p16 - p15 or p16 + p15;
    local v19;

    if v17 then
        v19 = v18 < 0;
    else
        v19 = v17;
    end;

    local v20 = {
        after = v18,
        short = v19
    };
    local v21;

    if p14 > 0 then
        v21 = not v19;
    else
        v21 = false;
    end;

    v20.enabled = v21;
    v20.confirm = v17 and "CONFIRM BUY" or "CONFIRM SALE";
    v20.title = ("%s (%d)"):format(v17 and "CART" or "SELLING", p14);

    return v20;
end;

return v1;