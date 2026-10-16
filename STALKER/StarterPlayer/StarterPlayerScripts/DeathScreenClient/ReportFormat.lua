-- Decompiled with Potassium's decompiler.

local v12 = {
    Money = function(p1: number?) -- Line: 7, Name: Money
        local v2 = tonumber(p1) or 0;
        local math_floor_ret = math.floor(v2);
        local v3 = tostring(math_floor_ret);
        local v4 = v3:sub(1, 1) == "-";

        if v4 then
            v3 = v3:sub(2);
        end;

        return (v4 and "-" or "") .. v3:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    end,

    Duration = function(p5: number?) -- Line: 15, Name: Duration
        local v6 = tonumber(p5) or 0;
        local math_floor_ret = math.floor(v6);
        local math_max_ret = math.max(0, math_floor_ret);
        local v7 = math_max_ret // 3600;
        local v8 = math_max_ret % 3600 // 60;
        local v9 = math_max_ret % 60;

        if v7 > 0 then
            return ("%dh %dm"):format(v7, v8);
        end;

        if v8 > 0 then
            return ("%dm %ds"):format(v8, v9);
        end;

        return ("%ds"):format(v9);
    end,

    Condition = function(p10: number, p11: number) -- Line: 24, Name: Condition
        return ("%d%% > %d%%"):format(math.floor(p10 * 100 + 0.5), (math.floor(p11 * 100 + 0.5)));
    end
};
local u13 = {
    blinddog = "a blind dog",
    boar = "a boar",
    flesh = "a flesh",
    mutant = "a mutant"
};
local u14 = {
    whirligig = "a Whirligig",
    vortex = "a Vortex",
    electro = "an Electro",
    burner = "a Burner",
    springboard = "a Springboard"
};
local u15 = {
    bandit = "Bandit",
    military = "Military",
    loner = "Loner",
    clearsky = "Clear Sky",
    monolith = "Monolith",
    npc = "a stranger"
};
local u16 = {
    Bandit = "Bandit",
    Military = "Military",
    Loner = "Loner",
    ClearSky = "Clear Sky",
    Monolith = "Monolith"
};
local u17 = {
    bleeding = "Bled out",
    radiation = "Radiation poisoning",
    fall = "Fell",
    explosion = "Blown up",
    drowned = "Drowned"
};

local function extra(p18) -- Line: 39
    if type(p18) ~= "table" then
        return nil;
    end;

    local v19 = {};

    if type(p18.weapon) == "string" and p18.weapon ~= "" then
        table.insert(v19, p18.weapon);
    end;

    if type(p18.distance) == "number" then
        local math_floor_ret = math.floor(p18.distance + 0.5);
        table.insert(v19, ("%d m"):format(math_floor_ret));
    end;

    return #v19 > 0 and table.concat(v19, "  /  ") or nil;
end;

function v12.Headline(p20: string?, p21: any) -- Line: 51
    -- upvalues: extra (copy), u15 (copy), u16 (copy), u13 (copy), u14 (copy), u17 (copy)
    local v22 = type(p21) == "table" and p21 and p21 or nil;

    if v22 and v22.kind == "player" or type(p20) == "string" and p20:match("^player:") then
        return {
            verb = "Killed by",
            name = v22 and v22.name or p20:match("^player:(.+)$"),
            extra = extra(v22)
        };
    end;

    if not (v22 and v22.kind == "npc" or p20 and u15[p20]) then
        local v23 = v22 and (v22.kind == "mutant" and v22.type) and u13[tostring(v22.type):lower()];

        if not v23 then
            if p20 then
                v23 = u13[p20];
            else
                v23 = p20;
            end;
        end;

        return v23 and {
            verb = "Mauled by",
            name = v23
        } or (p20 and u14[p20] and {
            verb = "Caught in",
            name = u14[p20]
        } or (p20 == "emission" and {
            verb = "Caught in",
            name = "an emission"
        } or (p20 and u17[p20] and {
            verb = u17[p20]
        } or (type(p20) == "string" and p20 ~= "" and {
            verb = "Killed by",
            name = p20
        } or {
            verb = "Lost to the Zone"
        }))));
    end;

    local v24 = v22 and v22.faction and (u16[v22.faction] or v22.faction);

    if not v24 then
        if p20 then
            v24 = u15[p20];
        else
            v24 = p20;
        end;
    end;

    local v25;

    if v22 and v22.rank then
        v25 = (v24 and v24 .. ", " or "") .. v22.rank;
    else
        v25 = v24;
    end;

    local v26 = v22 and v22.name or (v24 and "a " .. v24:lower() .. " fighter" or "a gunman");

    if not (v22 and v22.name) then
        if p20 == "npc" then
            v26 = "a stranger";
            v25 = nil;
        end;
    end;

    local v27 = {
        verb = "Shot by",
        name = v26
    };

    if not (v22 and (v22.name and v25)) then
        v25 = nil;
    end;

    v27.detail = v25;
    v27.extra = extra(v22);

    return v27;
end;

return v12;