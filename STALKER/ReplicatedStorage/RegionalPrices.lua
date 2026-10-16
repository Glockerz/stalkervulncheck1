-- Decompiled with Potassium's decompiler.

local u1 = {
    MAX_CONCURRENT = 4,
    REFRESH_AFTER = 300
};
local utf8_char_ret = utf8.char(57346);
local u2 = {};
local u3 = {};

local function keyOf(p4, p5) -- Line: 30
    return p4 .. ":" .. tostring(p5);
end;

function u1._fetch(p6, u7) -- Line: 35
    local MarketplaceService = game:GetService("MarketplaceService");
    local u8 = p6 == "pass" and Enum.InfoType.GamePass or Enum.InfoType.Product;
    local success, result = pcall(function() -- Line: 38
        -- upvalues: MarketplaceService (copy), u7 (copy), u8 (copy)
        return MarketplaceService:GetProductInfoAsync(u7, u8);
    end);

    if success then
        return result;
    end;

    return MarketplaceService:GetProductInfo(u7, u8);
end;

local function resolve(p9, p10) -- Line: 43
    -- upvalues: u1 (copy)
    local success, result = pcall(u1._fetch, p9, p10);
    local os_clock_ret = os.clock();

    return success and type(result) == "table" and (result.IsForSale == false and {
        state = "offsale",
        at = os_clock_ret
    } or (type(result.PriceInRobux) == "number" and {
        state = "ok",
        price = result.PriceInRobux,
        at = os_clock_ret
    } or {
        state = "failed",
        at = os_clock_ret
    })) or {
        state = "failed",
        at = os_clock_ret
    };
end;

function u1.Get(p11, p12) -- Line: 52
    -- upvalues: u2 (copy)
    return type(p12) == "number" and p12 > 0 and (u2[p11 .. ":" .. tostring(p12)] or {
        state = "loading"
    }) or {
        state = "failed"
    };
end;

function u1.Prefetch(p13, u14) -- Line: 59
    -- upvalues: u2 (copy), u1 (copy), u3 (copy), resolve (copy)
    local os_clock_ret = os.clock();
    local u15 = {};

    for _, v in ipairs(p13) do
        if type(v.id) == "number" and v.id > 0 then
            local v16 = v.kind .. ":" .. tostring(v.id);
            local v17 = u2[v16];

            if ((v17 == nil or v17.state == "failed") and true or os_clock_ret - (v17.at or 0) > u1.REFRESH_AFTER) and not u3[v16] then
                u3[v16] = true;
                table.insert(u15, v);
            end;
        end;
    end;

    local u18 = 0;

    local function worker() -- Line: 74
        -- upvalues: u18 (ref), u15 (copy), u2 (ref), resolve (ref), u3 (ref), u14 (copy)
        while true do
            u18 = u18 + 1;
            local v19 = u15[u18];

            if not v19 then
                break;
            end;

            local v20 = v19.kind .. ":" .. tostring(v19.id);
            u2[v20] = resolve(v19.kind, v19.id);
            u3[v20] = nil;

            if u14 then
                local success, result = pcall(u14, v19.kind, v19.id);

                if not success then
                    warn("[RegionalPrices] onChanged: " .. tostring(result));
                end;
            end;
        end;
    end;

    for i = 1, math.min(u1.MAX_CONCURRENT, #u15) do
        task.spawn(worker);
        local _ = i;
    end;
end;

function u1.Label(p21) -- Line: 94
    -- upvalues: utf8_char_ret (copy)
    local v22;

    if p21 then
        v22 = p21.state;
    else
        v22 = p21;
    end;

    if v22 == "ok" then
        return utf8_char_ret .. " " .. tostring(p21.price), true;
    end;

    if v22 == "offsale" then
        return "UNAVAILABLE", false;
    end;

    if v22 == "loading" then
        return "...", true;
    end;

    return "", true;
end;

function u1._reset() -- Line: 102
    -- upvalues: u2 (copy), u3 (copy)
    table.clear(u2);
    table.clear(u3);
end;

return u1;