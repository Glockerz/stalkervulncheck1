-- Decompiled with Potassium's decompiler.

local u1 = {
    CODE_ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789",
    CODE_LEN = 4
};

function u1.CodeFor(p2: string) -- Line: 15
    -- upvalues: u1 (copy)
    local v3 = 2166136261;

    for i = 1, #p2 do
        local bit32_bxor_ret = bit32.bxor(v3, string.byte(p2, i));
        v3 = (bit32.lshift(bit32_bxor_ret, 24) + bit32_bxor_ret * 403) % 4294967296;
        local _ = i;
    end;

    local v4 = #u1.CODE_ALPHABET;
    local v5 = {};

    for i = 1, u1.CODE_LEN do
        local v6 = v3 % v4;
        local string_sub_ret = string.sub(u1.CODE_ALPHABET, v6 + 1, v6 + 1);
        table.insert(v5, string_sub_ret);
        v3 = v3 // v4;
        local _ = i;
    end;

    return table.concat(v5);
end;

function u1.PlaceLabel(p7: string?, p8: string?) -- Line: 35
    -- upvalues: u1 (copy)
    local string_upper_ret = string.upper(p7 or "The Zone");

    if type(p8) == "string" and p8:find("[^0%-]") then
        return string_upper_ret .. " - " .. u1.CodeFor(p8);
    end;

    return string_upper_ret;
end;

local u9 = {
    ["America/New_York"] = "US East",
    ["America/Detroit"] = "US East",
    ["America/Indiana/Indianapolis"] = "US East",
    ["America/Kentucky/Louisville"] = "US East",
    ["America/Chicago"] = "US Central",
    ["America/Denver"] = "US Central",
    ["America/Los_Angeles"] = "US West",
    ["America/Phoenix"] = "US West",
    ["America/Toronto"] = "Canada",
    ["America/Vancouver"] = "Canada",
    ["America/Montreal"] = "Canada",
    ["America/Sao_Paulo"] = "South America",
    ["Europe/London"] = "EU West",
    ["Europe/Dublin"] = "EU West",
    ["Europe/Paris"] = "EU West",
    ["Europe/Amsterdam"] = "EU West",
    ["Europe/Brussels"] = "EU West",
    ["Europe/Madrid"] = "EU West",
    ["Europe/Lisbon"] = "EU West",
    ["Europe/Berlin"] = "EU Central",
    ["Europe/Warsaw"] = "EU Central",
    ["Europe/Vienna"] = "EU Central",
    ["Europe/Prague"] = "EU Central",
    ["Europe/Zurich"] = "EU Central",
    ["Europe/Rome"] = "EU Central",
    ["Europe/Stockholm"] = "EU North",
    ["Europe/Helsinki"] = "EU North",
    ["Europe/Oslo"] = "EU North",
    ["Europe/Copenhagen"] = "EU North"
};
local u10 = { { "Asia/", "Asia" }, { "Australia/", "Oceania" }, { "Pacific/Auckland", "Oceania" }, { "Africa/", "Africa" } };

function u1.RegionFor(p11: string?, p12: string?) -- Line: 60
    -- upvalues: u9 (copy), u10 (copy)
    if type(p11) == "string" then
        local v13 = u9[p11];

        if v13 then
            return v13;
        end;

        for _, v in ipairs(u10) do
            if string.sub(p11, 1, #v[1]) == v[1] then
                return v[2];
            end;
        end;
    end;

    return (type(p12) ~= "string" or #p12 ~= 2) and "Unknown" or string.upper(p12);
end;

local u14 = {};
local u15 = {
    ["US East"] = "NA",
    ["US Central"] = "NA",
    ["US West"] = "NA",
    Canada = "NA",
    ["EU West"] = "EU",
    ["EU Central"] = "EU",
    ["EU North"] = "EU",
    Asia = "AS",
    Oceania = "OC",
    ["South America"] = "SA",
    Africa = "AF"
};

for i, v in pairs({
    NA = { "US", "CA", "MX" },
    SA = { "BR", "AR", "CL", "CO", "PE", "VE", "UY", "PY", "BO", "EC" },
    EU = { "GB", "IE", "FR", "DE", "NL", "BE", "LU", "ES", "PT", "IT", "CH", "AT", "PL", "CZ", "SK", "HU", "SE", "NO", "DK", "FI", "IS", "EE", "LV", "LT", "RO", "BG", "GR", "HR", "SI", "RS", "UA", "TR" },
    AS = { "JP", "KR", "CN", "HK", "TW", "SG", "IN", "ID", "MY", "TH", "PH", "VN", "AE", "SA", "IL", "PK" },
    OC = { "AU", "NZ" },
    AF = { "ZA", "EG", "NG", "KE", "MA" }
}) do
    local v16 = i;

    for _, v2 in ipairs(v) do
        u14[v2] = v16;
    end;
end;

function u1.GroupForCountry(p17: string?) -- Line: 90
    -- upvalues: u14 (copy)
    if type(p17) == "string" then
        return u14[string.upper(p17)];
    end;

    return nil;
end;

function u1.GroupForRegion(p18: string?) -- Line: 95
    -- upvalues: u15 (copy), u1 (copy)
    if type(p18) == "string" then
        return u15[p18] or #p18 == 2 and u1.GroupForCountry(p18) or nil;
    end;

    return nil;
end;

function u1.Sort(p19: any, u20: string?) -- Line: 102
    -- upvalues: u1 (copy)
    local table_clone_ret = table.clone(p19);
    table.sort(table_clone_ret, function(p21, p22) -- Line: 104
        -- upvalues: u20 (copy), u1 (ref)
        local v23;

        if u20 == nil then
            v23 = false;
        else
            v23 = u1.GroupForRegion(p21.region) == u20;
        end;

        local v24;

        if u20 == nil then
            v24 = false;
        else
            v24 = u1.GroupForRegion(p22.region) == u20;
        end;

        if v23 ~= v24 then
            return v23;
        end;

        if p21.players == p22.players then
            return p21.code < p22.code;
        end;

        return p21.players > p22.players;
    end);

    return table_clone_ret;
end;

function u1.HasRoom(p25: any, p26: number) -- Line: 114
    return p26 <= p25.max - p25.players;
end;

function u1.Resolve(p27: string, p28: any, p29: number) -- Line: 120
    -- upvalues: u1 (copy)
    local v30 = nil;

    for _, v in ipairs(p28) do
        if v.code == p27 and (v30 == nil or v.max - v.players > v30.max - v30.players) then
            v30 = v;
        end;
    end;

    if not v30 then
        return nil, "gone";
    end;

    if u1.HasRoom(v30, p29) then
        return v30, nil;
    end;

    return nil, "full";
end;

return u1;