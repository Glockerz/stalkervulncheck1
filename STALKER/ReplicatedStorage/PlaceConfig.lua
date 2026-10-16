-- Decompiled with Potassium's decompiler.

local u1 = {
    IsLobby = false,
    AllowItemDrops = true,
    ItemDropLifetime = 1200,
    AllowDeathLoot = true,
    HasDayNightCycle = true,
    HasHostileNPCs = true,
    HasMutants = true,
    HasAnomalies = true,
    HasLootSpawns = true,
    HasMapData = true,
    HasAmbientWind = true,
    KinematicMutants = false,
    HasTutorial = false,
    HasWeather = false,
    HasEmissions = false,
    NpcPopulationScale = 1,
    SpawnOnTerrain = false
};

local function zone(p2: string, p3: string, p4: table?) -- Line: 142
    -- upvalues: u1 (copy)
    local v5 = {
        Id = p2,
        Name = p3
    };

    for i, v in pairs(u1) do
        v5[i] = v;
    end;

    if p4 then
        for i, v in pairs(p4) do
            v5[i] = v;
        end;
    end;

    return v5;
end;

local v6 = zone(
    "cordon",
    "Cordon",
    {
        HasTutorial = true,
        HasWeather = true,
        HasEmissions = true,
        KinematicMutants = true,
        NpcRankWeights = {
            Rookie = 80,
            Experienced = 20
        },
        MutantTuning = {
            PackSizeOffset = -1,
            MinPackSize = 2,
            HealthScale = 0.85,
            DamageScale = 0.75,
            TypeWeights = {
                Flesh = 60,
                BlindDog = 30,
                Boar = 10
            }
        },
        StashOdds = {
            Trash = 0.6,
            Good = 0.35,
            Jackpot = 0.05
        }
    }
);
local v7 = zone(
    "swamps",
    "Great Swamps",
    {
        HasMapData = true,
        KinematicMutants = true,
        HasWeather = true,
        HasEmissions = true,
        NpcPopulationScale = 5,
        SpawnOnTerrain = true,
        NpcRankScale = {
            Rookie = 0.5,
            Experienced = 1,
            Professional = 1.4,
            Veteran = 1.8,
            Expert = 2
        }
    }
);
local v8 = zone(
    "lobby",
    "Lobby",
    {
        IsLobby = true,
        AllowItemDrops = true,
        ItemDropLifetime = 600,
        AllowDeathLoot = false,
        HasDayNightCycle = false,
        HasHostileNPCs = false,
        HasMutants = false,
        HasAnomalies = false,
        HasLootSpawns = false,
        HasMapData = false,
        HasAmbientWind = false,
        HasTutorial = true
    }
);
local u9 = {
    [112318794071351] = v6,
    [111791254393417] = v7,
    [108746863880194] = v7,
    [72072976067143] = v8,
    [101784804882171] = v6,
    [72023447483665] = v7,
    [129536764649444] = v8
};
local u10 = {
    [10768697788] = {
        [112318794071351] = 101784804882171,
        [111791254393417] = 72023447483665,
        [72072976067143] = 129536764649444
    }
};
local u11 = {
    [112318794071351] = {
        swamps = 111791254393417
    },
    [111791254393417] = {
        cordon = 112318794071351
    },
    [101784804882171] = {
        swamps = 72023447483665
    },
    [72023447483665] = {
        cordon = 101784804882171
    }
};
local u12 = u9[game.PlaceId];

if not u12 then
    warn(string.format("[PlaceConfig] placeId %d is not registered; defaulting to ZONE behaviour. Add it to PlaceConfig.PLACES.", game.PlaceId));
    u12 = {
        Id = "unknown",
        Name = tostring(game.Name)
    };

    for i, v in pairs(u1) do
        u12[i] = v;
    end;
end;

function u12.IsLobbyPlace(p13) -- Line: 345
    -- upvalues: u9 (copy)
    local v14 = type(p13) == "number" and u9[p13] or nil;
    local v15;

    if v14 == nil then
        v15 = false;
    else
        v15 = v14.IsLobby == true;
    end;

    return v15;
end;

function u12.NameFor(p16: number) -- Line: 350
    -- upvalues: u9 (copy)
    local v17 = u9[p16];

    return v17 and v17.Name or "place " .. tostring(p16);
end;

function u12.InExperience(p18: number) -- Line: 359
    -- upvalues: u10 (copy)
    local v19 = u10[game.GameId];

    return v19 and (v19[p18] or 0) or p18;
end;

function u12.TransitPlaceId(p20: string) -- Line: 367
    -- upvalues: u11 (copy)
    local v21 = u11[game.PlaceId];

    if v21 then
        v21 = v21[p20];
    end;

    return v21;
end;

function u12.ItemDropsAllowed() -- Line: 392
    -- upvalues: u12 (ref)
    local Attribute = game:GetService("ReplicatedStorage"):GetAttribute("ItemDropsOverride");

    if type(Attribute) == "boolean" then
        return Attribute;
    end;

    return u12.AllowItemDrops;
end;

function u12.ItemDropLifetimeSeconds() -- Line: 406
    -- upvalues: u12 (ref)
    local Attribute = game:GetService("ReplicatedStorage"):GetAttribute("ItemDropLifetimeOverride");

    return (type(Attribute) ~= "number" or Attribute < 0) and (u12.ItemDropLifetime or 0) or Attribute;
end;

return u12;