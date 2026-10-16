-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MutantConfig = require(ReplicatedStorage:WaitForChild("MutantConfig"));
local u1 = {};
local u3 = {
    BUTCHER_TIME = 3,
    PROMPT_DISTANCE = 10,
    SPENT_DESPAWN = 20,
    MEAT_ITEM = "Mutant Meat",
    SOUND_ID = "rbxassetid://9119607416",
    SOUND_VOLUME = 5,
    SOUND_RANGE = 60,
    CORPSE_ATTRIBUTE = "Butcherable",

    IsButcherTool = function(p2) -- Line: 116, Name: IsButcherTool
        if type(p2) == "table" then
            return p2.Butchers == true;
        end;

        return false;
    end
};

for i, v in pairs(MutantConfig) do
    if type(v) == "table" and type(v.MeatYield) == "number" then
        u1[string.lower(i)] = v.MeatYield;
    end;
end;

function u3.MeatYield(p4) -- Line: 146
    -- upvalues: u1 (copy)
    return type(p4) == "string" and (u1[string.lower(p4)] or 0) or 0;
end;

u3.MEAT_CHANCE = 0.75;
u3.PART_CHANCE = 0.25;
u3.PART_CHANCE_MAX = 0.9;
local u5 = {};

for i, v in pairs(MutantConfig) do
    if type(v) == "table" and (type(v.ButcherPart) == "string" and v.ButcherPart ~= "") then
        u5[string.lower(i)] = v.ButcherPart;
    end;
end;

function u3.PartFor(p6) -- Line: 177
    -- upvalues: u5 (copy)
    if type(p6) == "string" then
        return u5[string.lower(p6)];
    end;

    return nil;
end;

function u3.IsButcherable(p7) -- Line: 185
    -- upvalues: u3 (copy)
    return u3.MeatYield(p7) > 0 and true or u3.PartFor(p7) ~= nil;
end;

function u3.Roll(p8, p9, p10) -- Line: 200
    -- upvalues: u3 (copy)
    local v11 = p9 or math.random;
    local PART_CHANCE = u3.PART_CHANCE;
    local v12 = tonumber(p10) or 1;
    local v13 = PART_CHANCE * math.max(1, v12);
    local math_min_ret = math.min(v13, u3.PART_CHANCE_MAX);
    local v14 = {
        meat = 0,
        part = nil
    };
    local v15 = u3.MeatYield(p8);

    if v15 > 0 and v11() < u3.MEAT_CHANCE then
        v14.meat = v15;
    end;

    local v16 = u3.PartFor(p8);

    if v16 and v11() < math_min_ret then
        v14.part = v16;
    end;

    return v14;
end;

return u3;