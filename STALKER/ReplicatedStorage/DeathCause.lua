-- Decompiled with Potassium's decompiler.

local u1 = {
    FRESHNESS = 45
};
local u2 = {
    bleeding = "bled out",
    radiation = "died of radiation",
    fall = "fell to their death",
    explosion = "blown up",
    emission = "caught in an emission",
    drowned = "drowned"
};
u1.UNKNOWN_PHRASE = "respawned";

function u1.Tag(p3, p4) -- Line: 44
    if not (p3 and (type(p4) == "string" and p4 ~= "")) then
        return;
    end;

    p3:SetAttribute("_lastDamageSource", p4:lower());
    p3:SetAttribute("_lastDamageAt", os.clock());
end;

function u1.Read(p5) -- Line: 51
    -- upvalues: u1 (copy)
    if not p5 then
        return nil;
    end;

    local Attribute = p5:GetAttribute("_lastDamageSource");

    if type(Attribute) ~= "string" or Attribute == "" then
        return nil;
    end;

    local Attribute2 = p5:GetAttribute("_lastDamageAt");

    if type(Attribute2) == "number" and os.clock() - Attribute2 <= u1.FRESHNESS then
        return Attribute;
    end;

    return nil;
end;

function u1.Describe(p6) -- Line: 62
    -- upvalues: u1 (copy), u2 (copy)
    if type(p6) ~= "string" or p6 == "" then
        return u1.UNKNOWN_PHRASE;
    end;

    local v7 = p6:match("^player:(.+)$");

    if v7 then
        return "killed by " .. v7;
    end;

    return u2[p6] or "died by " .. p6;
end;

local u8 = {
    whirligig = true,
    vortex = true,
    electro = true,
    burner = true,
    springboard = true
};
local u9 = {
    flesh = true,
    mutant = true,
    boar = true,
    blinddog = true
};
local u10 = {
    bandit = true,
    military = true,
    loner = true,
    npc = true
};

function u1.Category(p11) -- Line: 85
    -- upvalues: u8 (copy), u9 (copy), u10 (copy)
    return type(p11) == "string" and p11 ~= "" and (p11:match("^player:") and "pvp" or (u8[p11] and "anomaly" or (u9[p11] and "mutant" or (u10[p11] and "gunfight" or (p11 == "radiation" and "radiation" or (p11 == "bleeding" and "bleeding" or (p11 == "emission" and "emission" or "unknown"))))))) or "unknown";
end;

return u1;