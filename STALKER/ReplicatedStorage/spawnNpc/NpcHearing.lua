-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local NpcKnowledge = require(script.Parent:WaitForChild("NpcKnowledge"));
local NpcSquadShare = require(script.Parent:WaitForChild("NpcSquadShare"));
local NpcTelemetry = require(script.Parent:WaitForChild("NpcTelemetry"));
local NpcRadioChatter = require(script.Parent:WaitForChild("NpcRadioChatter"));
local u1 = {
    RANGE = {
        pistol = 250,
        rifle = 400,
        marksman = 550,
        shotgun = 350,
        subsonic = 100
    },
    SUPPRESSED_MULT = 0.35,
    CALIBER_CLASS = {
        ["9x18mm"] = "pistol",
        ["9x19mm"] = "pistol",
        [".45ACP"] = "pistol",
        ["7.62x25mm"] = "pistol",
        ["5.45x39mm"] = "rifle",
        ["5.56x45mm"] = "rifle",
        ["7.62x39mm"] = "rifle",
        ["7.62x54mm"] = "marksman",
        ["12gauge"] = "shotgun",
        ["9x39mm"] = "subsonic"
    },
    SUPPRESSOR_NAME_PATTERNS = { "suppress", "silenc", "pbs", "supp_" }
};
local u2 = {};

function u1.ModelSuppressed(p3) -- Line: 61
    -- upvalues: u2 (copy), ReplicatedStorage (copy), u1 (copy)
    if type(p3) ~= "string" then
        return false;
    end;

    local v4 = u2[p3];

    if v4 ~= nil then
        return v4;
    end;

    local SPH_Assets = ReplicatedStorage:FindFirstChild("SPH_Assets");

    if SPH_Assets then
        SPH_Assets = SPH_Assets:FindFirstChild("WeaponModels");
    end;

    if SPH_Assets then
        SPH_Assets = SPH_Assets:FindFirstChild(p3);
    end;

    if not SPH_Assets then
        return false;
    end;

    local v5 = false;

    for _, descendant in ipairs(SPH_Assets:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            local string_lower_ret = string.lower(descendant.Name);

            for _, v in ipairs(u1.SUPPRESSOR_NAME_PATTERNS) do
                if string.find(string_lower_ret, v, 1, true) then
                    v5 = true;
                    break;
                end;
            end;

            if v5 then
                break;
            end;
        end;
    end;

    u2[p3] = v5;

    return v5;
end;

u1.EVENT_INTERVAL = 0.5;
u1.ERR_PER_STUD = 0.08;
u1.ERR_MIN = 3;
u1.ERR_MAX = 40;
u1.FACING_TOWARD_MULT = 0.75;
u1.FACING_AWAY_MULT = 1.25;
u1.OCCLUDED_ERR_MULT = 1.3;
u1.OCCLUDED_RANGE_MULT = 0.6;
u1.MAX_OCCLUSION_RAYS = 12;
u1.SUSPICIOUS_SECONDS = 12;
u1.INVESTIGATE_FRACTION = 0.6;

function u1.ClassOf(p6, p7, p8) -- Line: 110
    -- upvalues: u1 (copy)
    local v9 = p6 and p6.shotgun and "shotgun" or (p6 and u1.CALIBER_CLASS[p6.ammoType or ""] or "rifle");
    local v10 = u1.ModelSuppressed(p7);

    if not v10 then
        if p8 == nil then
            v10 = false;
        else
            v10 = p8:GetAttribute("Suppressed") == true;
        end;
    end;

    return v9, v10;
end;

function u1.Range(p11, p12) -- Line: 118
    -- upvalues: u1 (copy)
    local v13 = u1.RANGE[p11] or u1.RANGE.rifle;

    if p12 and p11 ~= "subsonic" then
        v13 = v13 * u1.SUPPRESSED_MULT;
    end;

    return v13;
end;

function u1.Error(p14, p15, p16) -- Line: 125
    -- upvalues: u1 (copy)
    local math_clamp_ret = math.clamp(p14 * u1.ERR_PER_STUD, u1.ERR_MIN, u1.ERR_MAX);

    if p15 > 0 then
        math_clamp_ret = math_clamp_ret * (1 + (u1.FACING_TOWARD_MULT - 1) * p15);
    elseif p15 < 0 then
        math_clamp_ret = math_clamp_ret * (1 + (u1.FACING_AWAY_MULT - 1) * -p15);
    end;

    if p16 then
        math_clamp_ret = math_clamp_ret * u1.OCCLUDED_ERR_MULT;
    end;

    return math.clamp(math_clamp_ret, u1.ERR_MIN, u1.ERR_MAX * u1.OCCLUDED_ERR_MULT);
end;

local u17 = setmetatable({}, {
    __mode = "k"
});
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;
local u18 = nil;

local function shooterIsAllyOf(p19, p20) -- Line: 142
    -- upvalues: Players (copy), u18 (ref)
    if Players:GetPlayerFromCharacter(p20) then
        return false;
    end;

    local Attribute = p19:GetAttribute("Faction");
    local Attribute2 = p20:GetAttribute("Faction");

    if not (Attribute and Attribute2) then
        return false;
    end;

    if u18 == nil then
        local success, result = pcall(function() -- Line: 147
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);
        local v21;

        if success and type(result) == "table" then
            v21 = result.HostilityMatrix or false;
        else
            v21 = false;
        end;

        u18 = v21;
    end;

    local v22 = u18 and u18[Attribute];

    if v22 and v22[Attribute2] ~= nil then
        return v22[Attribute2] ~= true;
    end;

    return Attribute == Attribute2;
end;

u1.IsAlly = shooterIsAllyOf;
local u23 = nil;
local u24 = nil;

local function investigates(p25, p26, p27, p28) -- Line: 163
    -- upvalues: u1 (copy), Players (copy), u23 (ref), NpcKnowledge (copy), u24 (ref)
    if p28 * u1.INVESTIGATE_FRACTION < p27 then
        return false;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p26);

    if not PlayerFromCharacter or p25:GetAttribute("PassiveToPlayers") == true then
        return false;
    end;

    if u23 == nil then
        local success, result = pcall(function() -- Line: 168
            return require(script.Parent:WaitForChild("NpcSearch", 5));
        end);
        u23 = success and result and result or false;
    end;

    if not (u23 and u23.Enabled(NpcKnowledge)) then
        return false;
    end;

    if u24 == nil then
        local success, result = pcall(function() -- Line: 173
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);
        local v29;

        if success and type(result) == "table" then
            v29 = result.LosProvokeFactions or false;
        else
            v29 = false;
        end;

        u24 = v29;
    end;

    local Attribute = p25:GetAttribute("Faction");

    if not (u24 and (Attribute and u24[Attribute])) then
        return false;
    end;

    local _G_MainTaskService = _G.MainTaskService;

    if _G_MainTaskService and _G_MainTaskService.HasTruceWith then
        local success, result = pcall(_G_MainTaskService.HasTruceWith, PlayerFromCharacter, Attribute);

        if success and result then
            return false;
        end;
    end;

    return true;
end;

u1.Investigates = investigates;

function u1.OnShot(p30, p31, p32, p33) -- Line: 190
    -- upvalues: u1 (copy), NpcKnowledge (copy), Players (copy), u17 (copy), shooterIsAllyOf (copy), RaycastParams_new_ret (copy), NpcRadioChatter (copy), NpcSquadShare (copy), investigates (copy), NpcTelemetry (copy)
    if not u1.Enabled(NpcKnowledge) then
        return 0;
    end;

    if typeof(p30) ~= "Instance" or typeof(p32) ~= "Vector3" then
        return 0;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p30);

    if PlayerFromCharacter and PlayerFromCharacter:GetAttribute("AdminIgnore") == true then
        return 0;
    end;

    local os_clock_ret = os.clock();
    local v34 = u17[p30];

    if v34 and os_clock_ret - v34 < u1.EVENT_INTERVAL then
        return 0;
    end;

    u17[p30] = os_clock_ret;
    local PlayerCharacters = workspace:FindFirstChild("PlayerCharacters");

    if PlayerCharacters then
        PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
    end;

    if not PlayerCharacters then
        return 0;
    end;

    if p33 then
        p33 = p33.Name;
    end;

    local v35, v36 = u1.ClassOf(p31, p33, p30);
    local v37 = u1.Range(v35, v36);
    local HumanoidRootPart = p30:FindFirstChild("HumanoidRootPart");
    local v38;

    if HumanoidRootPart then
        v38 = HumanoidRootPart.Position or p32;
    else
        v38 = p32;
    end;

    local v39 = {};

    for _, child in ipairs(PlayerCharacters:GetChildren()) do
        if child ~= p30 and not child:GetAttribute("_Dormant") then
            local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart2 then
                local Magnitude = (HumanoidRootPart2.Position - p32).Magnitude;

                if Magnitude <= v37 then
                    table.insert(v39, {
                        npc = child,
                        root = HumanoidRootPart2,
                        d = Magnitude
                    });
                end;
            end;
        end;
    end;

    table.sort(v39, function(p40, p41) -- Line: 218
        return p40.d < p41.d;
    end);
    local v42 = 0;
    local v43 = 0;

    for _, v in ipairs(v39) do
        local npc = v.npc;
        local root = v.root;
        local v44 = npc:FindFirstChildOfClass("Humanoid");

        if v44 and (v44.Health > 0 and not shooterIsAllyOf(npc, p30)) then
            local v45;

            if v.d > v37 * u1.OCCLUDED_RANGE_MULT and v42 < u1.MAX_OCCLUSION_RAYS then
                v42 = v42 + 1;
                RaycastParams_new_ret.FilterDescendantsInstances = { npc, p30 };
                local Head = npc:FindFirstChild("Head");
                local v46 = Head and Head.Position or root.Position;

                if workspace:Raycast(v46, p32 - v46, RaycastParams_new_ret) == nil then
                    v45 = false;
                else
                    v45 = true;
                end;
            else
                v45 = false;
            end;

            if not v45 or v.d <= v37 * u1.OCCLUDED_RANGE_MULT then
                local v47 = p32 - root.Position;
                local LookVector = root.CFrame.LookVector;
                local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
                local Vector3_new_ret2 = Vector3.new(v47.X, 0, v47.Z);
                local v48 = Vector3_new_ret.Magnitude > 0.001 and (Vector3_new_ret2.Magnitude > 0.001 and Vector3_new_ret.Unit:Dot(Vector3_new_ret2.Unit)) or 0;
                local v49 = u1.Error(v.d, v48, v45);
                local v50 = NpcKnowledge.Heard(npc, p30, v38, root.Position, os_clock_ret, nil, v49);
                v43 = v43 + 1;
                NpcRadioChatter.Heard(npc, p30);
                local Alerted = npc:FindFirstChild("Alerted");

                if Alerted and (Alerted.Value and (NpcSquadShare and NpcSquadShare.Enabled())) then
                    NpcSquadShare.Report(npc, p30, "heard", v50.heardPos, v50.heardError, os_clock_ret);
                end;

                if not (Alerted and Alerted.Value) and v50.heardPos then
                    npc:SetAttribute("_SuspiciousUntil", os_clock_ret + u1.SUSPICIOUS_SECONDS);
                    npc:SetAttribute("_SuspiciousAt", v50.heardPos);
                    local AssemblyLinearVelocity = root.AssemblyLinearVelocity;

                    if not root.Anchored and Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude < 1 then
                        local Position = root.Position;
                        root.CFrame = CFrame.lookAt(Position, (Vector3.new(v50.heardPos.X, Position.Y, v50.heardPos.Z)));
                    end;

                    if Alerted and investigates(npc, p30, v.d, v37) then
                        Alerted.Value = true;
                    end;
                end;
            end;
        end;
    end;

    if v43 > 0 then
        NpcTelemetry.Bump("heard", v43);
    end;

    return v43;
end;

local u51 = nil;

function u1.Enabled(p52) -- Line: 269
    -- upvalues: u51 (ref)
    if u51 == nil then
        local success, result = pcall(function() -- Line: 271
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.Hearing == true;
            else
                success = false;
            end;
        end;

        u51 = success;
    end;

    local v53 = u51 and p52.Enabled();

    return v53;
end;

function u1.SetEnabled(p54) -- Line: 279
    -- upvalues: u51 (ref)
    u51 = p54 == true;
end;

function u1.ResetThrottle() -- Line: 284
    -- upvalues: u17 (copy)
    table.clear(u17);
end;

return u1;