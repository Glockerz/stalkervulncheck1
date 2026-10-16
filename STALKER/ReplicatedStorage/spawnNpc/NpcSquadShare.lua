-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local NpcKnowledge = require(script.Parent:WaitForChild("NpcKnowledge"));
local NpcTelemetry = require(script.Parent:WaitForChild("NpcTelemetry"));
local u1 = {
    COMMS_RADIUS = 150,
    THROTTLE = 1,
    DELAY_MIN = 0.5,
    DELAY_MAX = 1.2,
    stats = {
        reports = 0,
        told = 0,
        woken = 0
    },
    trace = nil
};
local u2 = setmetatable({}, {
    __mode = "k"
});

function u1.Shareable(p3) -- Line: 43
    return p3 == "seen" and true or p3 == "heard";
end;

function u1.Due(p4, p5, p6) -- Line: 48
    -- upvalues: u2 (copy), u1 (copy)
    local v7 = u2[p4];

    if not v7 then
        v7 = setmetatable({}, {
            __mode = "k"
        });
        u2[p4] = v7;
    end;

    local v8 = v7[p5];

    if v8 and p6 - v8 < u1.THROTTLE then
        return false;
    end;

    v7[p5] = p6;

    return true;
end;

function u1.ResetThrottle() -- Line: 60
    -- upvalues: u2 (copy)
    table.clear(u2);
end;

function u1.Delay() -- Line: 64
    -- upvalues: u1 (copy)
    return u1.DELAY_MIN + math.random() * (u1.DELAY_MAX - u1.DELAY_MIN);
end;

function u1.Mates(p9, p10, p11, p12) -- Line: 70
    -- upvalues: u1 (copy)
    local v13 = {};

    if not p11 or p11 == "" then
        return v13;
    end;

    local v14 = u1.COMMS_RADIUS * u1.COMMS_RADIUS;

    for _, v in ipairs(p12) do
        if v.npc ~= p9 and (v.tag == p11 and (v.alive and not v.dormant)) then
            local v15 = v.pos - p10;

            if v15.X * v15.X + v15.Y * v15.Y + v15.Z * v15.Z <= v14 then
                table.insert(v13, v);
            end;
        end;
    end;

    return v13;
end;

function u1.WouldHunt(p16, p17, p18) -- Line: 87
    if p17.isPlayer then
        return not p16.passive;
    end;

    if not p17.faction or p17.faction == p16.faction then
        return false;
    end;

    if p18 then
        p18 = p18[p16.faction];
    end;

    local v19;

    if p18 == nil then
        v19 = false;
    else
        v19 = p18[p17.faction] == true;
    end;

    return v19;
end;

local u20 = nil;

local function config() -- Line: 95
    -- upvalues: u20 (ref)
    if u20 == nil then
        local success, result = pcall(function() -- Line: 97
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if not (success and (type(result) == "table" and result)) then
            result = false;
        end;

        u20 = result;
    end;

    return u20 or nil;
end;

local function folder() -- Line: 105
    local PlayerCharacters = workspace:FindFirstChild("PlayerCharacters");

    if PlayerCharacters then
        PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
    end;

    return PlayerCharacters;
end;

function u1.Report(p21, u22, u23, u24, u25, p26) -- Line: 112
    -- upvalues: u1 (copy), NpcTelemetry (copy), Players (copy), u20 (ref), NpcKnowledge (copy)
    if not u1.Shareable(u23) then
        return 0;
    end;

    if not (p21 and (u22 and typeof(u24) == "Vector3")) then
        return 0;
    end;

    if not u1.Due(p21, u22, p26) then
        return 0;
    end;

    local Attribute = p21:GetAttribute("_CalloutChance");

    if type(Attribute) == "number" and Attribute <= math.random() then
        return 0;
    end;

    local Attribute2 = p21:GetAttribute("AllyTag");
    local HumanoidRootPart = p21:FindFirstChild("HumanoidRootPart");
    local PlayerCharacters = workspace:FindFirstChild("PlayerCharacters");

    if PlayerCharacters then
        PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
    end;

    if not (Attribute2 and (Attribute2 ~= "" and (HumanoidRootPart and PlayerCharacters))) then
        return 0;
    end;

    local v27 = {};

    for _, child in ipairs(PlayerCharacters:GetChildren()) do
        if child ~= p21 and child:GetAttribute("AllyTag") == Attribute2 then
            local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");
            local v28 = child:FindFirstChildOfClass("Humanoid");

            if HumanoidRootPart2 and v28 then
                local v29 = {
                    npc = child,
                    pos = HumanoidRootPart2.Position,
                    tag = Attribute2,
                    alive = v28.Health > 0,
                    dormant = child:GetAttribute("_Dormant") == true
                };
                table.insert(v27, v29);
            end;
        end;
    end;

    local u30 = u1.Mates(p21, HumanoidRootPart.Position, Attribute2, v27);

    if u1.trace then
        u1.trace(p21, u22, u23, #u30);
    end;

    if #u30 == 0 then
        return 0;
    end;

    local stats = u1.stats;
    stats.reports = stats.reports + 1;
    NpcTelemetry.Bump("squad.report");
    local u31 = {
        isPlayer = Players:GetPlayerFromCharacter(u22) ~= nil,
        faction = u22:GetAttribute("Faction")
    };

    if u20 == nil then
        local success, result = pcall(function() -- Line: 97
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if not (success and (type(result) == "table" and result)) then
            result = false;
        end;

        u20 = result;
    end;

    local u32 = u20 or nil;

    if u32 then
        u32 = u32.HostilityMatrix;
    end;

    task.delay(u1.Delay(), function() -- Line: 142
        -- upvalues: u22 (copy), u30 (copy), NpcKnowledge (ref), u24 (copy), u25 (copy), u23 (copy), u1 (ref), NpcTelemetry (ref), u31 (copy), u32 (copy)
        if not u22.Parent then
            return;
        end;

        local os_clock_ret = os.clock();

        for _, v in ipairs(u30) do
            local npc = v.npc;
            local v33 = npc.Parent and npc:FindFirstChildOfClass("Humanoid");

            if v33 and v33.Health > 0 then
                NpcKnowledge.Relayed(npc, u22, u24, u25 or 0, os_clock_ret, nil, u23);
                local stats2 = u1.stats;
                stats2.told = stats2.told + 1;
                NpcTelemetry.Bump("squad.told");
                local Alerted = npc:FindFirstChild("Alerted");
                local v34 = {
                    faction = npc:GetAttribute("Faction"),
                    passive = npc:GetAttribute("AllyTag") == "LONER_FACTION" and true or npc:GetAttribute("PassiveToPlayers") == true
                };

                if Alerted and (Alerted:IsA("BoolValue") and not (Alerted.Value or (npc:GetAttribute("_Dormant") or not u1.WouldHunt(v34, u31, u32)))) then
                    Alerted.Value = true;
                    local stats3 = u1.stats;
                    stats3.woken = stats3.woken + 1;
                end;
            end;
        end;
    end);

    return #u30;
end;

local u35 = nil;

function u1.Enabled() -- Line: 171
    -- upvalues: u35 (ref), u20 (ref), NpcKnowledge (copy)
    if u35 == nil then
        if u20 == nil then
            local success, result = pcall(function() -- Line: 97
                return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
            end);

            if not (success and (type(result) == "table" and result)) then
                result = false;
            end;

            u20 = result;
        end;

        local v36 = u20 or nil;
        local v37;

        if v36 == nil or type(v36.AI) ~= "table" then
            v37 = false;
        else
            v37 = v36.AI.SquadShare == true;
        end;

        u35 = v37;
    end;

    local v38 = u35 and NpcKnowledge.Enabled();

    return v38;
end;

function u1.SetEnabled(p39) -- Line: 179
    -- upvalues: u35 (ref)
    u35 = p39 == true;
end;

return u1;