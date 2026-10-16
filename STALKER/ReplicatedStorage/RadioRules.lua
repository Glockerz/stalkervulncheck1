-- Decompiled with Potassium's decompiler.

local RadioConfig = require(script.Parent:WaitForChild("RadioConfig"));
local u7 = {
    ChannelsFor = function(p1: string) -- Line: 14, Name: ChannelsFor
        -- upvalues: RadioConfig (copy)
        return {
            {
                id = "zone",
                name = "ZONE WIDE",
                sub = "Every stalker in the Zone",
                kind = "wip"
            },
            {
                id = "trade",
                name = "TRADE",
                sub = "Listings from every server",
                kind = "trade"
            },
            {
                id = "map",
                sub = "Players in this server",
                kind = "map",
                name = string.upper(RadioConfig.MAP_NAMES[p1] or "LOCAL")
            }
        };
    end,

    CountFor = function(p2: string, p3: string, p4: any) -- Line: 23, Name: CountFor
        if type(p4) ~= "table" then
            return 0;
        end;

        if p2 ~= "map" then
            return tonumber(p4.total) or 0;
        end;

        return tonumber(p4.byPlace and p4.byPlace[p3]) or 0;
    end,

    ValidPrice = function(p5) -- Line: 33, Name: ValidPrice
        -- upvalues: RadioConfig (copy)
        if type(p5) ~= "number" or (p5 ~= p5 or p5 % 1 ~= 0) then
            return nil;
        end;

        if p5 < RadioConfig.Trade.PRICE_MIN or RadioConfig.Trade.PRICE_MAX < p5 then
            return nil;
        end;

        return p5;
    end,

    FormatRoubles = function(p6: number) -- Line: 39, Name: FormatRoubles
        local math_floor_ret = math.floor(p6);

        return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " ₽";
    end
};

function u7.ListingLine(p8) -- Line: 46
    -- upvalues: u7 (copy)
    if p8.k == "buy" then
        return "BUYING  " .. ((p8.q and p8.q > 1 and (p8.q .. "x " or "") or "") .. p8.n) .. " · " .. "Offering " .. u7.FormatRoubles(p8.pr);
    end;

    local v9 = { p8.n };

    if p8.d and p8.d ~= "" then
        table.insert(v9, p8.d);
    end;

    table.insert(v9, u7.FormatRoubles(p8.pr));

    return "SELLING  " .. table.concat(v9, " · ");
end;

function u7.MakeRef(p10: string, p11: any, p12: string) -- Line: 61
    return ("%s:%s:%s"):format(p10, tostring(p11), p12);
end;

function u7.ParseRef(p13) -- Line: 65
    if type(p13) ~= "string" then
        return nil;
    end;

    local string_match_ret, v14, v15 = string.match(p13, "^(%a+):([^:]+):(.+)$");

    if string_match_ret then
        return string_match_ret, v14, v15;
    end;

    return nil;
end;

function u7.ShouldShow(p16: any, p17: any, p18: any, p19: string?) -- Line: 74
    if type(p16) ~= "table" then
        return false;
    end;

    if p17 and p17[p16.u] then
        return false;
    end;

    if p18 and p19 then
        if p19 == "dm" then
            if p18.contacts and p18.contacts[tostring(p16.u)] then
                return false;
            end;
        elseif p18.channels and p18.channels[p19] then
            return false;
        end;
    end;

    return true;
end;

return u7;