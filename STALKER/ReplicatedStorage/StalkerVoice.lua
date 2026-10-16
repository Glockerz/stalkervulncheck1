-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StalkerNames = require(ReplicatedStorage:WaitForChild("StalkerNames"));
local u1 = {};
local u2 = { {
        name = "Loner",
        npcId = "ZoneLoner",
        weight = 7,
        tones = {
            respectful = 5,
            dry = 3,
            sarcastic = 2,
            hostile = 0
        },
        uniforms = { "BlackJacketJeans", "PeacoatJeans", "FieldJacketJeans", "BDUTopJeans", "LonerOutfit", "GreyTrenchCoatJumper", "LayeredTrenchCoatJeans", "LongOvercoatCargoPants" }
    }, {
        name = "Bandit",
        npcId = "ZoneBandit",
        weight = 3,
        tones = {
            respectful = 0,
            dry = 2,
            sarcastic = 3,
            hostile = 5
        },
        uniforms = { "BlackPeacoatJeans", "CollarJacketJeans", "CollarJacketHoodie", "BrownTrenchCoatCargoPants" }
    } };
u1.FACTIONS = u2;
u1.SKIN_TONES = {
    Color3.fromRGB(255, 220, 200),
    Color3.fromRGB(255, 200, 170),
    Color3.fromRGB(225, 180, 140),
    Color3.fromRGB(190, 145, 110),
    Color3.fromRGB(150, 110, 85),
    Color3.fromRGB(110, 80, 60),
    Color3.fromRGB(80, 55, 40)
};
u1.NAMED_MODELS = {};

function u1.LookFor(p3, p4) -- Line: 90
    -- upvalues: u1 (copy), u2 (copy)
    if type(p3) ~= "string" or p3 == "" then
        return nil;
    end;

    local v5 = u1.NAMED_MODELS[p3];

    if v5 then
        return {
            model = v5
        };
    end;

    local v6 = u2[1];

    for _, v in ipairs(u2) do
        if v.name == p4 then
            v6 = v;
            break;
        end;
    end;

    if not (v6 and (v6.uniforms and #v6.uniforms > 0)) then
        return nil;
    end;

    local v7 = 5381;

    for i = 1, #p3 do
        v7 = (v7 * 33 + p3:byte(i)) % 4294967296;
        local _ = i;
    end;

    return {
        uniform = v6.uniforms[v7 % #v6.uniforms + 1],
        skin = math.floor(v7 / 7919) % #u1.SKIN_TONES + 1
    };
end;

local u8 = { "respectful", "sarcastic", "hostile", "dry" };

function u1.PickTone(p9, p10) -- Line: 112
    -- upvalues: u8 (copy)
    local v11 = p9 or {};
    local v12 = 0;

    for _, v in ipairs(u8) do
        v12 = v12 + (v11[v] or 0);
    end;

    if v12 <= 0 then
        return "dry";
    end;

    local v13 = p10:NextNumber() * v12;

    for _, v in ipairs(u8) do
        local v14 = v11[v] or 0;

        if v14 > 0 then
            v13 = v13 - v14;

            if v13 <= 0 then
                return v;
            end;
        end;
    end;

    return "dry";
end;

local u15 = nil;

function u1.RollSpeaker(p16, p17) -- Line: 135
    -- upvalues: u2 (copy), u15 (ref)
    local v18 = p16 or Random.new();
    local v19 = 0;

    for _, v in ipairs(u2) do
        v19 = v19 + v.weight;
    end;

    local v20 = v18:NextNumber() * v19;
    local v21 = u2[#u2];

    for _, v in ipairs(u2) do
        v20 = v20 - v.weight;

        if v20 <= 0 then
            v21 = v;
            break;
        end;
    end;

    return u15(v21, v18, p17);
end;

function u1.RollSpeakerOf(p22, p23, p24) -- Line: 154
    -- upvalues: u2 (copy), u15 (ref)
    local v25 = p23 or Random.new();
    local v26 = u2[1];

    for _, v in ipairs(u2) do
        if v.name == p22 then
            v26 = v;
            break;
        end;
    end;

    return u15(v26, v25, p24);
end;

u15 = function(p27, p28, p29) -- Line: 163
    -- upvalues: StalkerNames (copy), u1 (copy)
    local v30 = nil;

    for i = 1, 8 do
        v30 = StalkerNames.Random(p28);

        if v30 ~= p29 then
            break;
        end;

        local _ = i;
    end;

    local uniforms = p27.uniforms;
    local v31 = {
        faction = p27.name,
        npcId = p27.npcId,
        name = v30
    };
    local v32;

    if uniforms and #uniforms > 0 then
        v32 = uniforms[p28:NextInteger(1, #uniforms)] or nil;
    else
        v32 = nil;
    end;

    v31.uniform = v32;
    v31.skin = p28:NextInteger(1, #u1.SKIN_TONES);
    v31.tones = p27.tones;

    return v31;
end;

function u1.FactionName(p33) -- Line: 184
    -- upvalues: u2 (copy)
    for _, v in ipairs(u2) do
        if v.npcId == p33 then
            return v.name;
        end;
    end;

    return nil;
end;

return u1;