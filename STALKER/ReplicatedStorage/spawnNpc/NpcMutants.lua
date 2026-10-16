-- Decompiled with Potassium's decompiler.

local NpcThreat = require(script.Parent:WaitForChild("NpcThreat"));
local u1 = {
    CACHE_SECONDS = 0.5
};
local u2 = {};
local u3 = (-1 / 0);

function u1.Live(p4) -- Line: 16
    -- upvalues: u3 (ref), u1 (copy), u2 (ref)
    local v5 = p4 or os.clock();

    if v5 - u3 < u1.CACHE_SECONDS then
        return u2;
    end;

    u3 = v5;
    u2 = {};
    local Mutants = workspace:FindFirstChild("Mutants");

    if not Mutants then
        return u2;
    end;

    for _, child in ipairs(Mutants:GetChildren()) do
        local v6 = child:FindFirstChildOfClass("Humanoid");
        local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

        if v6 and (HumanoidRootPart and (v6.Health > 0 and child:GetAttribute("MutantType"))) then
            local v7 = {
                model = child,
                hrp = HumanoidRootPart,
                hum = v6,
                type = child:GetAttribute("MutantType")
            };
            table.insert(u2, v7);
        end;
    end;

    return u2;
end;

local u8 = nil;

function u1.Enabled() -- Line: 35
    -- upvalues: u8 (ref)
    if u8 == nil then
        local success, result = pcall(function() -- Line: 37
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.MutantCombat == true;
            else
                success = false;
            end;
        end;

        u8 = success;
    end;

    return u8;
end;

function u1.SetEnabled(p9) -- Line: 44
    -- upvalues: u8 (ref)
    u8 = p9 == true;
end;

function u1.IsMutant(p10) -- Line: 46
    local v11;

    if typeof(p10) == "Instance" then
        v11 = p10:GetAttribute("MutantType") ~= nil;
    else
        v11 = false;
    end;

    return v11;
end;

function u1.CountAggroNear(p12, p13, p14) -- Line: 52
    -- upvalues: u1 (copy), NpcThreat (copy)
    local v15 = 0;

    for _, v in ipairs(u1.Live(p14)) do
        if v.hrp.Parent and (v.hum.Health > 0 and (v.model:GetAttribute("Aggro") == true and (v.hrp.Position - p12).Magnitude <= math.min(p13, NpcThreat.MUTANT_RANGE))) then
            v15 = v15 + 1;
        end;
    end;

    return v15;
end;

return u1;