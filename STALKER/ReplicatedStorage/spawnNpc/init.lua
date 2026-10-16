-- Decompiled with Potassium's decompiler.

local v1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
ReplicatedStorage:WaitForChild("SPH_Assets");
local script_NPC_WeaponRig = require(script.NPC_WeaponRig);
require(script.NPC_Ammo);
local script_NPC_Combat = require(script.NPC_Combat);
local script_NPC_Movement = require(script.NPC_Movement);
local NpcSight = require(ReplicatedStorage:WaitForChild("NpcSight"));
local script_NPC_Stance = require(script.NPC_Stance);
local script_StanceRules = require(script.StanceRules);
local script_TacticsRules = require(script.TacticsRules);
local script_Morale = require(script.Morale);
local script_CoverFinder = require(script.CoverFinder);
local script_SquadBoard = require(script.SquadBoard);
local script_NpcKnowledge = require(script.NpcKnowledge);
local script_Perception = require(script.Perception);
local script_NpcSuppression = require(script.NpcSuppression);
local script_NpcSearch = require(script.NpcSearch);
local script_NpcSquadShare = require(script.NpcSquadShare);
local script_NpcPersonality = require(script.NpcPersonality);
local script_NpcSuppressFire = require(script.NpcSuppressFire);
local script_NpcOpportunity = require(script.NpcOpportunity);
local script_NpcWeaponClass = require(script.NpcWeaponClass);
local script_NpcTelemetry = require(script.NpcTelemetry);
local script_NpcRadioChatter = require(script.NpcRadioChatter);
local script_NpcMutants = require(script.NpcMutants);
local script_NpcMutantDistress = require(script.NpcMutantDistress);
local StalkerNames = require(ReplicatedStorage:WaitForChild("StalkerNames"));
local u2 = {
    MILITARY_FACTION = {
        IdealMinRange = 30,
        IdealMaxRange = 300,
        TARGET_UPDATE_RATE = 0.5,
        NoLOSOverrideTime = 11,
        StrafeInterval = 1.8,
        GiveupTime = 150
    }
};
local u3 = CFrame.new(0, -0.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793);
local u4 = RunService:IsStudio();

local function RunNPCAI(u5) -- Line: 174
    -- upvalues: script_NPC_WeaponRig (copy), script_SquadBoard (copy), script_NpcRadioChatter (copy), script_NpcKnowledge (copy), script_NpcSuppression (copy), script_NPC_Combat (copy), script_NPC_Movement (copy), script_NpcOpportunity (copy), script_NpcWeaponClass (copy), script_NPC_Stance (copy), script_TacticsRules (copy), script_Morale (copy), script_NpcPersonality (copy), StalkerNames (copy), script_NpcTelemetry (copy), Players (copy), script_NpcMutants (copy), script_NpcMutantDistress (copy), script_Perception (copy), script_NpcSearch (copy), script_NpcSquadShare (copy), script_NpcSuppressFire (copy), u4 (copy), script_StanceRules (copy), NpcSight (copy), script_CoverFinder (copy), RunService (copy), u3 (copy)
    local Humanoid = u5:WaitForChild("Humanoid");
    local HumanoidRootPart = u5:WaitForChild("HumanoidRootPart");
    local u6 = tick();
    local npcConfig = require(u5:WaitForChild("npcConfig"));
    local u7 = false;
    local u8 = true;
    local u9 = {};

    repeat
        task.wait();
    until u5:FindFirstChildOfClass("Tool");

    local u10 = u5:FindFirstChildOfClass("Tool");
    local WeaponStats = require(u10.SPH_Weapon:WaitForChild("WeaponStats"));
    local v11 = u5:FindFirstChild("WeaponRig").Weapon:FindFirstChildWhichIsA("Model");
    local Muzzle = v11.Grip.Muzzle;
    local Torso = u5:WaitForChild("Torso");
    local Neck = Torso:WaitForChild("Neck");
    local u12 = {};
    local v13;

    if WeaponStats.idleAnim then
        v13 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.idleAnim, Enum.AnimationPriority.Idle) or nil;
    else
        v13 = nil;
    end;

    u12.idle = v13;
    local v14;

    if WeaponStats.sprintAnim then
        v14 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.sprintAnim, Enum.AnimationPriority.Movement) or nil;
    else
        v14 = nil;
    end;

    u12.sprint = v14;
    local v15;

    if WeaponStats.reloadAnim then
        v15 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.reloadAnim, Enum.AnimationPriority.Action, true) or nil;
    else
        v15 = nil;
    end;

    u12.reload = v15;
    local v16;

    if WeaponStats.boltChamber then
        v16 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.boltChamber, Enum.AnimationPriority.Action, true) or nil;
    else
        v16 = nil;
    end;

    u12.boltChamber = v16;
    local v17;

    if WeaponStats.boltClose then
        v17 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.boltClose, Enum.AnimationPriority.Action, true) or nil;
    else
        v17 = nil;
    end;

    u12.boltClose = v17;
    local v18;

    if WeaponStats.boltOpen then
        v18 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.boltOpen, Enum.AnimationPriority.Action, true) or nil;
    else
        v18 = nil;
    end;

    u12.boltOpen = v18;
    local v19;

    if WeaponStats.clipReloadAnim then
        v19 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.clipReloadAnim, Enum.AnimationPriority.Action, true) or nil;
    else
        v19 = nil;
    end;

    u12.clipReload = v19;
    local v20;

    if WeaponStats.equipAnim then
        v20 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.equipAnim, Enum.AnimationPriority.Action, true) or nil;
    else
        v20 = nil;
    end;

    u12.equip = v20;
    local v21;

    if WeaponStats.fireAnim then
        v21 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.fireAnim, Enum.AnimationPriority.Action2, true) or nil;
    else
        v21 = nil;
    end;

    u12.fireAnim = v21;
    local v22;

    if WeaponStats.aimAnim then
        v22 = script_NPC_WeaponRig.LoadAnimTrack(u5, WeaponStats.aimAnim, Enum.AnimationPriority.Action) or nil;
    else
        v22 = nil;
    end;

    u12.aim = v22;

    local function setTrack(p23, p24, p25) -- Line: 206
        if not p23 then
            return;
        end;

        if p24 then
            p23.Looped = true;

            if not p23.IsPlaying then
                p23:Play(p25 or 0.15, 1, 1);
            end;
        elseif p23.IsPlaying then
            p23:Stop(p25 or 0.15);
        end;
    end;

    local idle = u12.idle;

    if idle then
        idle.Looped = true;

        if not idle.IsPlaying then
            idle:Play(0.15, 1, 1);
        end;
    end;

    for _, descendant in pairs(u5:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant:CanSetNetworkOwnership() == true then
            descendant:SetNetworkOwner(nil);
        end;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = HumanoidRootPart;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = workspace.Terrain;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Attachment0 = Attachment;
    AlignOrientation.Attachment1 = Attachment2;
    AlignOrientation.RigidityEnabled = false;
    AlignOrientation.MaxTorque = 1000000;
    AlignOrientation.MaxAngularVelocity = (1 / 0);
    AlignOrientation.Responsiveness = 45;
    AlignOrientation.Parent = HumanoidRootPart;
    AlignOrientation.Enabled = false;
    local u26 = nil;
    local u27 = nil;
    local u28 = false;

    local function teardown() -- Line: 257
        -- upvalues: u28 (ref), u8 (ref), u9 (copy), script_NPC_WeaponRig (ref), u5 (copy), Attachment2 (copy), u26 (ref), u27 (ref), script_SquadBoard (ref), script_NpcRadioChatter (ref), script_NpcKnowledge (ref), script_NpcSuppression (ref)
        if u28 then
            return;
        end;

        u28 = true;
        u8 = false;

        for _, v in ipairs(u9) do
            pcall(function() -- Line: 262
                -- upvalues: v (copy)
                v:Disconnect();
            end);
        end;

        script_NPC_WeaponRig.ClearAnimCache(u5);
        Attachment2:Destroy();

        if u26 then
            u26.Release();
        end;

        if u27 then
            u27.Release();
        end;

        script_SquadBoard.Release(u5);
        script_NpcRadioChatter.Release(u5);
        script_NpcKnowledge.Release(u5);
        script_NpcKnowledge.ForgetEnemy(u5);
        script_NpcSuppression.Release(u5);
    end;

    u5.Destroying:Connect(teardown);

    if not u5.Parent then
        teardown();
    end;

    local u29 = {
        IsActive = true,
        NPC = u5,
        CharacterAsset = u5,
        Humanoid = Humanoid,
        HumanoidRootPart = HumanoidRootPart,
        Weapon = u10,
        wepStats = WeaponStats,
        npcConfig = npcConfig,
        gunModel = v11,
        muzzle = Muzzle,
        tracks = u12,
        alignOrientation = AlignOrientation,
        targetAttachment = Attachment2,
        setTrack = setTrack
    };
    local u30 = script_NPC_Combat.New(u29);
    u26 = script_NPC_Movement.New(u29);

    if u28 then
        u26.Release();
    end;

    local u31;

    if script_NpcOpportunity.Enabled() then
        local v32 = script_NpcWeaponClass.Classify(WeaponStats);
        u31 = script_NpcWeaponClass.PREFS[v32];
        local v33, v34, v35 = script_NpcWeaponClass.Ranges(v32, u26.IdealMinRange, u26.IdealMaxRange, u26.TooCloseRange);
        u26.IdealMinRange = v33;
        u26.IdealMaxRange = v34;
        u26.TooCloseRange = v35;
        u5:SetAttribute("WeaponClass", v32);
    else
        u31 = nil;
    end;

    u27 = script_NPC_Stance.New(u5, Humanoid);

    if u28 then
        u27.Release();
    end;

    local u36 = nil;
    local u37 = nil;
    local os_clock_ret = os.clock();

    local function getTactics() -- Line: 320
        -- upvalues: u36 (ref), u5 (copy), script_TacticsRules (ref)
        if u36 then
            return u36;
        end;

        local Attribute = u5:GetAttribute("Faction");
        local success, result = pcall(function() -- Line: 323
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.Tactics) == "table" then
                if Attribute then
                    Attribute = result.Tactics[Attribute];
                end;
            else
                Attribute = false;
            end;
        else
            Attribute = success;
        end;

        if Attribute then
            u36 = Attribute;
        end;

        return Attribute or script_TacticsRules.DEFAULTS;
    end;

    local u38 = false;

    local function getMorale() -- Line: 333
        -- upvalues: getTactics (copy), u37 (ref), script_Morale (ref), u38 (ref), script_TacticsRules (ref)
        local v39 = getTactics();

        if u37 then
            if not u38 and v39 ~= script_TacticsRules.DEFAULTS then
                u37:SetBravery(v39.Bravery);
                u38 = true;
            end;
        else
            u37 = script_Morale.New(v39.Bravery);
            u38 = v39 ~= script_TacticsRules.DEFAULTS;
        end;

        return u37;
    end;

    local u40 = nil;

    local function getPersona() -- Line: 350
        -- upvalues: script_NpcPersonality (ref), u40 (ref), u5 (copy), getTactics (copy)
        if not script_NpcPersonality.Enabled() then
            return nil;
        end;

        if u40 == nil then
            if u5:GetAttribute("Faction") == nil then
                return nil;
            end;

            local Attribute = u5:GetAttribute("Rank");
            local Random_new_ret = Random.new(math.random(1, 1073741824));

            local function roll() -- Line: 356
                -- upvalues: Random_new_ret (copy)
                return Random_new_ret:NextNumber();
            end;

            local Attribute2 = u5:GetAttribute("Personality");

            if type(Attribute2) ~= "string" or script_NpcPersonality.ARCHETYPES[Attribute2] == nil then
                Attribute2 = script_NpcPersonality.Roll(u5:GetAttribute("Faction"), Attribute, script_NpcPersonality.ConfigWeights(), roll);
            end;

            u40 = script_NpcPersonality.Build(getTactics(), Attribute, Attribute2, roll);
            u5:SetAttribute("Personality", u40.personality);
            u5:SetAttribute("_SupResist", u40.supMult);
            u5:SetAttribute("_CalloutChance", u40.calloutChance);
        end;

        return u40;
    end;

    local function reloadCoverFrac() -- Line: 369
        -- upvalues: getPersona (copy), script_TacticsRules (ref)
        local v41 = getPersona();

        return v41 and v41.reloadCoverFrac or script_TacticsRules.RELOAD_COVER_FRACTION;
    end;

    if not u28 then
        script_SquadBoard.Register(u5, getMorale, HumanoidRootPart);
    end;

    if u5:GetAttribute("NpcName") == nil then
        u5:SetAttribute("NpcName", StalkerNames.Random());
    end;

    if not u28 then
        script_NpcRadioChatter.Register(u5, HumanoidRootPart);
    end;

    local function magFrac() -- Line: 382
        -- upvalues: u10 (copy)
        local Ammo = u10:FindFirstChild("Ammo");

        if Ammo then
            Ammo = Ammo:FindFirstChild("MagAmmo");
        end;

        return Ammo and (Ammo.MaxValue > 0 and Ammo.Value / Ammo.MaxValue) or 1;
    end;

    local Health = Humanoid.Health;
    table.insert(u9, Humanoid.HealthChanged:Connect(function(p42) -- Line: 391
        -- upvalues: Health (ref), u5 (copy), getTactics (copy), u37 (ref), script_Morale (ref), u38 (ref), script_TacticsRules (ref), Humanoid (copy)
        if p42 < Health then
            u5:SetAttribute("_LastHitAt", os.clock());
            local v43 = getTactics();

            if u37 then
                if not u38 and v43 ~= script_TacticsRules.DEFAULTS then
                    u37:SetBravery(v43.Bravery);
                    u38 = true;
                end;
            else
                u37 = script_Morale.New(v43.Bravery);
                u38 = v43 ~= script_TacticsRules.DEFAULTS;
            end;

            u37:Hit(Health - p42, Humanoid.MaxHealth, os.clock());
        end;

        Health = p42;
    end));

    local function lockFacing(p44) -- Line: 407
        -- upvalues: u30 (copy), AlignOrientation (copy), Humanoid (copy)
        u30.UpdateFacing(p44);
        AlignOrientation.Enabled = true;
        Humanoid.AutoRotate = false;
    end;

    local function releaseFacing() -- Line: 412
        -- upvalues: u30 (copy), AlignOrientation (copy), Humanoid (copy)
        if u30.IsAiming() then
            return;
        end;

        if AlignOrientation.Enabled or not Humanoid.AutoRotate then
            AlignOrientation.Enabled = false;
            Humanoid.AutoRotate = true;
        end;
    end;

    local u45 = nil;

    local function CheckAlly(p46) -- Line: 431
        -- upvalues: u5 (copy), u45 (ref), npcConfig (copy)
        if game.Players:FindFirstChild(p46.Name) then
            return false;
        end;

        local Attribute = u5:GetAttribute("Faction");
        local Attribute2 = p46:GetAttribute("Faction");

        if Attribute and Attribute2 then
            if u45 == nil then
                local success, result = pcall(function() -- Line: 436
                    return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
                end);
                u45 = success and (result and result.HostilityMatrix) or false;
            end;

            local v47 = u45 and u45[Attribute];

            if v47 and v47[Attribute2] ~= nil then
                return v47[Attribute2] ~= true;
            end;
        end;

        local AllyTag = npcConfig.AllyTag;

        if not AllyTag or AllyTag == "" then
            return false;
        end;

        local Attribute3 = p46:GetAttribute("AllyTag");
        local v48;

        if Attribute3 == AllyTag then
            v48 = Attribute3 ~= "";
        else
            v48 = false;
        end;

        return v48;
    end;

    local function HandleDeath() -- Line: 452
        -- upvalues: Humanoid (copy), AlignOrientation (copy), u8 (ref), u29 (copy), Neck (copy), u12 (copy), u5 (copy), script_SquadBoard (ref), script_NpcTelemetry (ref), Players (ref), script_NpcMutants (ref), script_NpcMutantDistress (ref), script_NpcRadioChatter (ref), teardown (copy)
        if Humanoid.Health <= 0 then
            AlignOrientation.Enabled = false;
            Humanoid.AutoRotate = true;
            u8 = false;
            u29.IsActive = false;
            Neck.C1 = CFrame.new(0, -0.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793);
            local aim = u12.aim;

            if aim and aim.IsPlaying then
                aim:Stop(0.15);
            end;

            local idle2 = u12.idle;

            if idle2 and idle2.IsPlaying then
                idle2:Stop(0.15);
            end;

            local WeaponRig = u5:FindFirstChild("WeaponRig");

            if WeaponRig then
                for _, v in ipairs({ "raw", "law" }) do
                    local v49 = WeaponRig:FindFirstChild(v);

                    if v49 then
                        v49:Destroy();
                    end;
                end;
            end;

            script_SquadBoard.OnDeath(u5);
            local u50 = nil;
            pcall(function() -- Line: 477
                -- upvalues: u50 (ref), u5 (ref), script_NpcTelemetry (ref), Players (ref)
                u50 = require(game:GetService("ServerScriptService"):WaitForChild("NPCAttackerRegistry", 1)).GetAttacker(u5);
                local Death = script_NpcTelemetry.Death;
                local v51;

                if u50 == nil then
                    v51 = false;
                else
                    v51 = Players:GetPlayerFromCharacter(u50) ~= nil;
                end;

                Death(u5, u50, v51);
            end);

            if u50 and (script_NpcMutants.IsMutant(u50) and script_NpcMutantDistress.Enabled()) then
                pcall(script_NpcMutantDistress.OnNpcKilled, u5, u50);
            else
                script_NpcRadioChatter.AllyDown(u5, u50);
            end;

            teardown();
        end;
    end;

    local u52 = nil;

    local function AlertedHandler() -- Line: 495
        -- upvalues: u5 (copy), script_NpcKnowledge (ref), script_Perception (ref), script_NpcSuppression (ref), u5 (copy), script_NpcSearch (ref), script_NpcSquadShare (ref), script_SquadBoard (ref), script_NpcSuppressFire (ref), script_NpcOpportunity (ref), u7 (ref), u29 (copy), script_NpcTelemetry (ref), u4 (ref), HumanoidRootPart (copy), npcConfig (copy), Players (ref), CheckAlly (copy), getPersona (copy), script_StanceRules (ref), u31 (ref), u30 (copy), RaycastParams_new_ret (copy), NpcSight (ref), u26 (ref), script_NpcRadioChatter (ref), AlignOrientation (copy), Humanoid (copy), u52 (ref), getTactics (copy), u8 (ref), u6 (ref), script_NpcMutants (ref), u27 (ref), u37 (ref), script_Morale (ref), u38 (ref), script_TacticsRules (ref), os_clock_ret (ref), script_CoverFinder (ref), u10 (copy)
        if u5.Alerted.Value ~= true then
            return;
        end;

        local u53 = script_NpcKnowledge.Enabled();
        local u54 = script_Perception.Enabled(script_NpcKnowledge);
        local u55 = script_NpcSuppression.Enabled();

        local function suppTier() -- Line: 511
            -- upvalues: u55 (copy), script_NpcSuppression (ref), u5 (ref)
            return u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;
        end;

        local u56 = script_NpcSearch.Enabled(script_NpcKnowledge);
        local u57;

        if u53 then
            u57 = script_NpcSquadShare.Enabled();
        else
            u57 = u53;
        end;

        local u58 = script_SquadBoard.CoverEnabled();
        local u59;

        if u53 then
            u59 = script_NpcSuppressFire.Enabled();
        else
            u59 = u53;
        end;

        local u60;

        if u53 then
            u60 = script_NpcOpportunity.Enabled();
        else
            u60 = u53;
        end;

        local u61 = script_NpcOpportunity.NewHealthWatch();
        local u62 = nil;
        local u63 = 0;
        local u64 = 0;
        local u65 = 0;
        local u66 = "idle";
        local u67 = 0;
        local u68 = nil;

        local function knownPos(p69) -- Line: 550
            -- upvalues: u53 (copy), script_NpcKnowledge (ref), u5 (ref), u68 (ref)
            if u53 then
                return script_NpcKnowledge.BestEstimate(u5, p69, os.clock());
            end;

            return u68;
        end;

        local function targetPos(p70) -- Line: 561
            -- upvalues: u53 (copy), u7 (ref), script_NpcKnowledge (ref), u5 (ref), u68 (ref)
            local v71;

            if p70 then
                v71 = p70:FindFirstChild("HumanoidRootPart");
            else
                v71 = p70;
            end;

            if not v71 then
                return nil;
            end;

            if not u53 or u7 then
                return v71.Position;
            end;

            if u53 then
                return script_NpcKnowledge.BestEstimate(u5, p70, os.clock());
            end;

            return u68;
        end;

        function u29.AimPoint() -- Line: 567
            -- upvalues: u5 (ref), u53 (copy), u7 (ref), script_NpcKnowledge (ref), u5 (ref), u68 (ref)
            local Value = u5.Target.Value;
            local v72;

            if Value then
                v72 = Value:FindFirstChild("HumanoidRootPart");
            else
                v72 = Value;
            end;

            if not v72 then
                return nil;
            end;

            if not u53 or u7 then
                return v72.Position;
            end;

            if u53 then
                return script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
            end;

            return u68;
        end;

        local u73 = nil;

        local function markUnseen(p74) -- Line: 575
            -- upvalues: u73 (ref), script_NpcKnowledge (ref), u5 (ref)
            if u73 then
                script_NpcKnowledge.LostSight(u5, u73, p74);
                u73 = nil;
            end;
        end;

        local math_random_ret = math.random();
        local u75 = 0;
        local u76 = 0;
        local u77 = 0;
        local u78 = 0;
        local u79 = 0;
        local u80 = 0;

        local function holdingCrouch() -- Line: 592
            -- upvalues: u5 (ref)
            return u5:GetAttribute("Stance") == "Crouch";
        end;

        local v81 = math.random() * 3.141592653589793 * 2;
        local math_cos_ret = math.cos(v81);
        local math_sin_ret = math.sin(v81);
        local u82 = Vector3.new(math_cos_ret, 0, math_sin_ret) * (2 + math.random() * 2);
        local u83 = "Hold";
        local u84 = 0;
        local u85 = false;
        local u86 = 0.5;
        local math_random_ret2 = math.random();
        local u87 = nil;
        local u88 = nil;
        local os_clock_ret2 = os.clock();
        local u89 = 0;
        local u90 = false;
        local u91 = false;
        local u92 = (-1 / 0);
        local u93 = 0;
        local u94 = nil;
        local u95 = false;
        local u96 = nil;
        local u97 = false;
        local u98 = nil;
        local u99 = nil;
        local u100 = (-1 / 0);
        local RaycastParams_new_ret2 = RaycastParams.new();
        RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret2.RespectCanCollide = true;

        local function endSuppressive(p101) -- Line: 619
            -- upvalues: u98 (ref), script_NpcSuppressFire (ref), script_NpcTelemetry (ref), u5 (ref), u100 (ref), script_SquadBoard (ref), u4 (ref), u5 (ref)
            if not u98 then
                return;
            end;

            script_NpcSuppressFire.stats.ends[p101] = (script_NpcSuppressFire.stats.ends[p101] or 0) + 1;
            script_NpcTelemetry.Bump("supfire.end." .. p101);

            if script_NpcSuppressFire.trace then
                script_NpcSuppressFire.trace(u5, "end", p101);
            end;

            u98 = nil;
            u100 = os.clock();
            script_SquadBoard.ReleaseSuppress(u5);

            if u4 then
                u5:SetAttribute("Suppressing", nil);
            end;
        end;

        local function inCover() -- Line: 629
            -- upvalues: u88 (ref), HumanoidRootPart (ref)
            local v102;

            if u88 == nil then
                v102 = false;
            else
                v102 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
            end;

            return v102;
        end;

        local function stayingDown() -- Line: 634
            -- upvalues: u55 (copy), u88 (ref), HumanoidRootPart (ref), script_NpcSuppression (ref), u5 (ref)
            if u55 then
                local v103;

                if u88 == nil then
                    v103 = false;
                else
                    v103 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                end;

                if v103 then
                    local v104 = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;
                    local v105;

                    if script_NpcSuppression.HEAVY_TIER <= v104 then
                        v105 = true;
                    elseif v104 == script_NpcSuppression.MEDIUM_TIER then
                        v105 = script_NpcSuppression.Hesitating(u5, os.clock());
                    else
                        v105 = false;
                    end;

                    return v105;
                end;
            end;

            return false;
        end;

        local u106 = false;
        local u107 = npcConfig.AllyTag == "LONER_FACTION" and true or u5:GetAttribute("PassiveToPlayers") == true;

        local function isEnemy(p108) -- Line: 642
            -- upvalues: u5 (ref), Players (ref), u107 (copy), CheckAlly (ref)
            if p108 == u5.Target.Value then
                return true;
            end;

            if Players:GetPlayerFromCharacter(p108) then
                return not u107;
            end;

            return not CheckAlly(p108);
        end;

        local function updateStance(p109, p110, p111) -- Line: 647
            -- upvalues: u5 (ref), HumanoidRootPart (ref), u80 (ref), u78 (ref), getPersona (ref), u79 (ref), script_StanceRules (ref), u31 (ref), math_random_ret (copy), u88 (ref), u30 (ref), u55 (copy), script_NpcSuppression (ref), u5 (ref), u53 (copy), u7 (ref), script_NpcKnowledge (ref), u68 (ref), RaycastParams_new_ret (ref), NpcSight (ref), u77 (ref)
            local Attribute = u5:GetAttribute("_LastHitAt");
            local Attribute2 = u5:GetAttribute("_SuppressedUntil");
            local v112 = HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 1.5;

            if v112 then
                u80 = os.clock();
            end;

            if (u5:GetAttribute("Stance") or "Stand") == "Crouch" and (u78 > 0 and (u78 <= os.clock() and not v112)) then
                u78 = 0;
                local v113 = getPersona();
                u79 = os.clock() + math.random(script_StanceRules.REPOSITION_MIN, script_StanceRules.REPOSITION_MAX) * (v113 and v113.repositionMult or 1) * (u31 and u31.reposition or 1);
            end;

            local v114 = script_StanceRules.Pick({
                state = p109,
                moving = v112,
                dist = p110 or 0,
                underFire = type(Attribute) == "number" and os.clock() - Attribute < script_StanceRules.UNDER_FIRE_SECONDS and true or type(Attribute2) == "number" and os.clock() < Attribute2,
                willing = math_random_ret,
                crouchUntil = u78,
                standUntil = u79,
                stillFor = os.clock() - u80,
                now = os.clock()
            });
            local v115;

            if u88 == nil then
                v115 = false;
            else
                v115 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
            end;

            if v115 then
                v115 = u30.IsReloading();

                if not v115 then
                    if u55 then
                        local v116;

                        if u88 == nil then
                            v116 = false;
                        else
                            v116 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                        end;

                        if v116 then
                            local v117 = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;

                            if script_NpcSuppression.HEAVY_TIER <= v117 then
                                v115 = true;
                            elseif v117 == script_NpcSuppression.MEDIUM_TIER then
                                v115 = script_NpcSuppression.Hesitating(u5, os.clock());
                            else
                                v115 = false;
                            end;
                        else
                            v115 = false;
                        end;
                    else
                        v115 = false;
                    end;
                end;
            end;

            local v118 = v115 and "Crouch" or v114;
            local v119;

            if p111 then
                local v120;

                if p111 then
                    v120 = p111:FindFirstChild("HumanoidRootPart");
                else
                    v120 = p111;
                end;

                if v120 then
                    if u53 and not u7 then
                        if u53 then
                            v119 = script_NpcKnowledge.BestEstimate(u5, p111, os.clock());
                        else
                            v119 = u68;
                        end;
                    else
                        v119 = v120.Position;
                    end;
                else
                    v119 = nil;
                end;
            else
                v119 = p111;
            end;

            if not (v115 or (v118 ~= "Crouch" or not v119)) then
                local v121 = HumanoidRootPart.CFrame:PointToWorldSpace(Vector3.new(0, 0.4, 0));
                RaycastParams_new_ret.FilterDescendantsInstances = { u5, p111 };
                v118 = NpcSight.Cast(v121, v119 - v121, RaycastParams_new_ret) ~= nil and "Stand" or v118;
            end;

            if v118 ~= (u5:GetAttribute("Stance") or "Stand") and (v112 and v118 == "Stand" or script_StanceRules.Hold(u77, os.clock())) then
                u77 = os.clock();

                if v118 == "Crouch" and u78 == 0 then
                    local v122 = getPersona();
                    u78 = os.clock() + math.random(script_StanceRules.CROUCH_SESSION_MIN, script_StanceRules.CROUCH_SESSION_MAX) * (v122 and v122.coverHoldMult or 1);
                elseif v118 == "Stand" and v112 then
                    u78 = 0;
                end;

                u5:SetAttribute("Stance", v118);
            end;
        end;

        local RaycastParams_new_ret3 = RaycastParams.new();
        RaycastParams_new_ret3.FilterType = Enum.RaycastFilterType.Exclude;

        local function canSee(p123) -- Line: 707
            -- upvalues: u5 (ref), RaycastParams_new_ret3 (copy), NpcSight (ref)
            local HumanoidRootPart2 = p123:FindFirstChild("HumanoidRootPart");
            local Head = u5:FindFirstChild("Head");

            if not (HumanoidRootPart2 and Head) then
                return false;
            end;

            RaycastParams_new_ret3.FilterDescendantsInstances = { u5, p123 };

            if NpcSight.Cast(Head.Position, HumanoidRootPart2.Position - Head.Position, RaycastParams_new_ret3) == nil then
                return true;
            end;

            local Head2 = p123:FindFirstChild("Head");
            local v124;

            if Head2 == nil then
                v124 = false;
            else
                v124 = NpcSight.Cast(Head.Position, Head2.Position - Head.Position, RaycastParams_new_ret3) == nil;
            end;

            return v124;
        end;

        local function canAcquire(p125) -- Line: 720
            -- upvalues: u54 (copy), canSee (copy), script_NpcKnowledge (ref), u5 (ref), script_Perception (ref)
            if not u54 then
                return canSee(p125);
            end;

            local os_clock_ret3 = os.clock();
            local v126 = script_NpcKnowledge.Get(u5, p125, os_clock_ret3);

            if v126 and v126.visible then
                return canSee(p125);
            end;

            local v127, v128 = script_Perception.Sample(u5, p125, true, v126 and v126.knownPos or nil, os_clock_ret3);
            local v129;

            if v127 then
                v129 = canSee(p125) or false;
            else
                v129 = false;
            end;

            return script_NpcKnowledge.Notice(u5, p125, v129, v128, os_clock_ret3) >= 1;
        end;

        local TARGET_UPDATE_RATE = npcConfig.TARGET_UPDATE_RATE;

        local function TransitionTo(p130) -- Line: 735
            -- upvalues: u66 (ref), u4 (ref), u5 (ref)
            if u66 ~= p130 then
                u66 = p130;

                if u4 then
                    u5:SetAttribute("CombatState", p130);
                end;
            end;
        end;

        local u131 = nil;

        local function endTactics() -- Line: 745
            -- upvalues: u73 (ref), script_NpcKnowledge (ref), u5 (ref), u26 (ref), script_SquadBoard (ref), u83 (ref), u85 (ref), u87 (ref), u88 (ref), u90 (ref), u91 (ref), u4 (ref), u5 (ref), u131 (ref)
            local os_clock_ret3 = os.clock();

            if u73 then
                script_NpcKnowledge.LostSight(u5, u73, os_clock_ret3);
                u73 = nil;
            end;

            u26.StopSprint();
            script_SquadBoard.ReleaseCover(u5);
            script_SquadBoard.ReleaseFlank(u5);
            u83 = "Hold";
            u85 = false;
            u87 = nil;
            u88 = nil;
            u90 = false;
            u91 = false;

            if u4 and u5.Parent then
                u5:SetAttribute("Tactic", nil);
            end;

            if u131 then
                u131();
            end;
        end;

        local u132 = nil;
        local u133 = nil;
        local u134 = 0;
        local u135 = nil;
        local u136 = nil;
        local RaycastParams_new_ret4 = RaycastParams.new();
        RaycastParams_new_ret4.FilterType = Enum.RaycastFilterType.Exclude;

        u131 = function() -- Line: 767
            -- upvalues: u132 (ref), script_SquadBoard (ref), u5 (ref), u133 (ref), u29 (ref), u4 (ref), u5 (ref)
            if u132 then
                script_SquadBoard.ReleaseSearch(u5);
                u132 = nil;
                u133 = nil;
                u29.SearchLook = nil;

                if u4 and u5.Parent then
                    u5:SetAttribute("Search", nil);
                end;
            end;
        end;

        local function estimateOf(p137, p138) -- Line: 775
            -- upvalues: script_NpcKnowledge (ref), u5 (ref)
            local v139 = script_NpcKnowledge.Get(u5, p137, p138);

            return v139 and v139.knownPos and {
                pos = v139.knownPos,
                at = v139.knownAt,
                source = v139.knownSource,
                err = v139.knownError or 0
            } or nil;
        end;

        local function adoptable(p140) -- Line: 781
            -- upvalues: u5 (ref), Players (ref), u107 (copy), CheckAlly (ref)
            local v141 = p140 and p140.Parent and p140:FindFirstChildOfClass("Humanoid");
            local v142;

            if v141 == nil or v141.Health <= 0 then
                v142 = false;
            else
                v142 = p140:IsDescendantOf(workspace);

                if v142 then
                    if p140 == u5.Target.Value then
                        return true;
                    end;

                    if Players:GetPlayerFromCharacter(p140) then
                        return not u107;
                    end;

                    v142 = not CheckAlly(p140);
                end;
            end;

            return v142;
        end;

        local function giveUpSearch(p143) -- Line: 785
            -- upvalues: script_NpcTelemetry (ref), script_NpcRadioChatter (ref), u5 (ref), script_NpcKnowledge (ref), u131 (ref), u5 (ref), u68 (ref), u30 (ref), u26 (ref), AlignOrientation (ref), Humanoid (ref), u66 (ref), u4 (ref), adoptable (copy), u52 (ref)
            local os_clock_ret3 = os.clock();
            script_NpcTelemetry.Bump("search.giveup");
            script_NpcRadioChatter.Event(u5, "giveup", p143);
            script_NpcKnowledge.MarkSearched(u5, p143);
            u131();
            pcall(function() -- Line: 791
                -- upvalues: u5 (ref)
                require(game:GetService("ServerScriptService"):WaitForChild("NPCVoicelines")).Play(u5, "LostTarget");
            end);
            local Attribute = u5:GetAttribute("_RetaliateUntil");

            if Attribute and os_clock_ret3 < Attribute then
                return;
            end;

            u5.Target.Value = nil;
            u68 = nil;
            u30.StopAiming();
            u26.StopMoving();

            if not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                AlignOrientation.Enabled = false;
                Humanoid.AutoRotate = true;
            end;

            if u66 ~= "idle" then
                u66 = "idle";

                if u4 then
                    u5:SetAttribute("CombatState", "idle");
                end;
            end;

            if script_NpcKnowledge.Strongest(u5, os_clock_ret3, adoptable) == nil and (u52 and u52()) then
                u5.Alerted.Value = false;
            end;
        end;

        local function startSearch(u144, p145) -- Line: 809
            -- upvalues: u131 (ref), script_NpcTelemetry (ref), script_NpcRadioChatter (ref), u5 (ref), script_NpcSearch (ref), u5 (ref), getTactics (ref), getPersona (ref), HumanoidRootPart (ref), u30 (ref), AlignOrientation (ref), Humanoid (ref), u26 (ref), RaycastParams_new_ret4 (copy), u132 (ref), giveUpSearch (copy), script_SquadBoard (ref), math_random_ret2 (copy), u133 (ref), estimateOf (copy), u134 (ref)
            u131();
            script_NpcTelemetry.Bump("search.start");
            script_NpcRadioChatter.Event(u5, "search", u144);
            local v146 = script_NpcSearch.Profile(u5:GetAttribute("Rank"), getTactics().Aggression);
            local u147 = getPersona();

            if u147 then
                v146.watch = v146.watch * u147.watchMult;
                v146.duration = v146.duration * u147.durationMult;
            end;

            local v152 = {
                pos = function() -- Line: 822
                    -- upvalues: HumanoidRootPart (ref)
                    return HumanoidRootPart.Position;
                end,

                goTo = function(p148, p149) -- Line: 823
                    -- upvalues: u30 (ref), AlignOrientation (ref), Humanoid (ref), u26 (ref), getTactics (ref)
                    if not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                        AlignOrientation.Enabled = false;
                        Humanoid.AutoRotate = true;
                    end;

                    u26.GoTo(p148, p149 and getTactics().SprintSpeed or nil);
                end,

                moveStatus = function() -- Line: 827
                    -- upvalues: u26 (ref)
                    return u26.GoToStatus();
                end,

                stop = function() -- Line: 828
                    -- upvalues: u26 (ref)
                    u26.StopMoving();
                end,

                face = function(p150) -- Line: 829
                    -- upvalues: u30 (ref), AlignOrientation (ref), Humanoid (ref)
                    if p150 then
                        u30.UpdateFacing(p150);
                        AlignOrientation.Enabled = true;
                        Humanoid.AutoRotate = false;
                    end;
                end,

                openDirections = function(p151) -- Line: 830
                    -- upvalues: RaycastParams_new_ret4 (ref), u5 (ref), script_NpcSearch (ref), u132 (ref)
                    RaycastParams_new_ret4.FilterDescendantsInstances = { u5 };

                    return script_NpcSearch.OpenDirections(u5.Head.Position, p151, RaycastParams_new_ret4, u132.stats);
                end
            };
            local u153 = {};

            function v152.checkSpot(p154, p155) -- Line: 835
                -- upvalues: RaycastParams_new_ret4 (ref), u5 (ref), script_NpcSearch (ref), u153 (copy), u132 (ref)
                RaycastParams_new_ret4.FilterDescendantsInstances = { u5 };

                return script_NpcSearch.CheckSpot(p154, p155, u5.Head.Position, u153, RaycastParams_new_ret4, u132.stats);
            end;

            function v152.giveUp() -- Line: 839
                -- upvalues: giveUpSearch (ref), u144 (copy)
                giveUpSearch(u144);
            end;

            function v152.squadRole() -- Line: 840
                -- upvalues: script_SquadBoard (ref), u5 (ref), u144 (copy), HumanoidRootPart (ref)
                return script_SquadBoard.SearchRole(u5, u144, HumanoidRootPart.Position, os.clock());
            end;

            function v152.bold() -- Line: 841
                -- upvalues: math_random_ret2 (ref), u147 (copy), getTactics (ref)
                return math_random_ret2 < (u147 and u147.sprintWill or getTactics().Aggression);
            end;

            u132 = script_NpcSearch.New(v152, v146, p145, estimateOf(u144, p145), u5);
            u133 = u144;
            u134 = u26.pathComputes;
            pcall(function() -- Line: 844
                -- upvalues: u5 (ref)
                require(game:GetService("ServerScriptService"):WaitForChild("NPCVoicelines")).Play(u5, "Searching");
            end);
        end;

        local function cancelSprintForSuppression() -- Line: 852
            -- upvalues: u26 (ref), script_SquadBoard (ref), u5 (ref), u83 (ref), u92 (ref), u87 (ref), u85 (ref), u86 (ref), u89 (ref), u66 (ref), u4 (ref), u5 (ref), script_NpcSuppression (ref)
            u26.StopSprint();
            script_SquadBoard.EndMove(u5);
            script_SquadBoard.ReleaseCover(u5);

            if u83 == "Flank" then
                script_SquadBoard.ReleaseFlank(u5);
                u92 = os.clock();
            end;

            u87 = nil;
            u85 = false;
            u86 = 0.5;
            u89 = 0;

            if u66 ~= "idle" then
                u66 = "idle";

                if u4 then
                    u5:SetAttribute("CombatState", "idle");
                end;
            end;

            script_NpcSuppression.Count("sprintCancelled");
        end;

        task.spawn(function() -- Line: 863
            -- upvalues: u5 (ref), u8 (ref), u30 (ref), u26 (ref), TARGET_UPDATE_RATE (ref), npcConfig (ref), CheckAlly (ref), canAcquire (copy), u135 (ref), script_NpcKnowledge (ref), u5 (ref), u56 (copy), adoptable (copy), u131 (ref), u6 (ref), u68 (ref), u53 (copy), u66 (ref), u4 (ref), script_NpcMutants (ref), u7 (ref), u136 (ref), u52 (ref), u78 (ref), u79 (ref), endTactics (copy), u75 (ref), u27 (ref), u54 (copy), script_Perception (ref), u132 (ref), RaycastParams_new_ret (ref), NpcSight (ref), HumanoidRootPart (ref), script_StanceRules (ref), u76 (ref), u29 (ref), u73 (ref), u95 (ref), script_NpcTelemetry (ref), u57 (copy), script_NpcSquadShare (ref), script_NpcRadioChatter (ref), giveUpSearch (copy), u133 (ref), estimateOf (copy), startSearch (copy), script_SquadBoard (ref), u134 (ref), updateStance (copy), u86 (ref), u83 (ref), u55 (copy), script_NpcSuppression (ref), cancelSprintForSuppression (copy), u96 (ref), u97 (ref), getTactics (ref), u37 (ref), script_Morale (ref), u38 (ref), script_TacticsRules (ref), isEnemy (copy), os_clock_ret (ref), getPersona (ref), u90 (ref), u88 (ref), script_CoverFinder (ref), u58 (copy), u94 (ref), u93 (ref), u60 (copy), script_NpcOpportunity (ref), u61 (copy), Players (ref), u62 (ref), u63 (ref), u64 (ref), u65 (ref), math_random_ret2 (copy), u31 (ref), u91 (ref), u10 (ref), u92 (ref), u84 (ref), u85 (ref), os_clock_ret2 (ref), u89 (ref), u87 (ref), endSuppressive (copy), AlignOrientation (ref), Humanoid (ref), u80 (ref), u106 (ref), u59 (copy), u98 (ref), script_NpcSuppressFire (ref), u99 (ref), u100 (ref), RaycastParams_new_ret2 (copy), u67 (ref), u82 (copy)
            local function stillAlerted() -- Line: 869
                -- upvalues: u5 (ref)
                local Alerted = u5:FindFirstChild("Alerted");
                local v156;

                if Alerted == nil then
                    v156 = false;
                else
                    v156 = Alerted.Value;
                end;

                return v156;
            end;

            local function combatLoop() -- Line: 875
                -- upvalues: u8 (ref), u5 (ref), u30 (ref), u26 (ref), TARGET_UPDATE_RATE (ref), npcConfig (ref), CheckAlly (ref), canAcquire (ref), u135 (ref), script_NpcKnowledge (ref), u5 (ref), u56 (ref), adoptable (ref), u131 (ref), u6 (ref), u68 (ref), u53 (ref), u66 (ref), u4 (ref), script_NpcMutants (ref), u7 (ref), u136 (ref), u52 (ref), u78 (ref), u79 (ref), endTactics (ref), u75 (ref), u27 (ref), u54 (ref), script_Perception (ref), u132 (ref), RaycastParams_new_ret (ref), NpcSight (ref), HumanoidRootPart (ref), script_StanceRules (ref), u76 (ref), u29 (ref), u73 (ref), u95 (ref), script_NpcTelemetry (ref), u57 (ref), script_NpcSquadShare (ref), script_NpcRadioChatter (ref), giveUpSearch (ref), u133 (ref), estimateOf (ref), startSearch (ref), script_SquadBoard (ref), u134 (ref), updateStance (ref), u86 (ref), u83 (ref), u55 (ref), script_NpcSuppression (ref), cancelSprintForSuppression (ref), u96 (ref), u97 (ref), getTactics (ref), u37 (ref), script_Morale (ref), u38 (ref), script_TacticsRules (ref), isEnemy (ref), os_clock_ret (ref), getPersona (ref), u90 (ref), u88 (ref), script_CoverFinder (ref), u58 (ref), u94 (ref), u93 (ref), u60 (ref), script_NpcOpportunity (ref), u61 (ref), Players (ref), u62 (ref), u63 (ref), u64 (ref), u65 (ref), math_random_ret2 (ref), u31 (ref), u91 (ref), u10 (ref), u92 (ref), u84 (ref), u85 (ref), os_clock_ret2 (ref), u89 (ref), u87 (ref), endSuppressive (ref), AlignOrientation (ref), Humanoid (ref), u80 (ref), u106 (ref), u59 (ref), u98 (ref), script_NpcSuppressFire (ref), u99 (ref), u100 (ref), RaycastParams_new_ret2 (ref), u67 (ref), u82 (ref)
                while true do
                    while true do
                        if not u8 then
                            return;
                        end;

                        local Alerted = u5:FindFirstChild("Alerted");
                        local v157;

                        if Alerted == nil then
                            v157 = false;
                        else
                            v157 = Alerted.Value;
                        end;

                        if not v157 then
                            break;
                        end;

                        local task_wait_ret = task.wait(0.1);

                        if not (u5.Parent and u8) then
                            break;
                        end;

                        if u5:GetAttribute("_Dormant") then
                            break;
                        end;

                        TARGET_UPDATE_RATE = TARGET_UPDATE_RATE + (task_wait_ret or 0.1);

                        if TARGET_UPDATE_RATE >= npcConfig.TARGET_UPDATE_RATE then
                            TARGET_UPDATE_RATE = 0;
                            local v158 = u26.FindNearestTarget(true, CheckAlly, canAcquire);
                            local v159;

                            if v158 == nil then
                                local Attribute = u5:GetAttribute("_RetaliateUntil");
                                v159 = u5.Target.Value;

                                if Attribute and (os.clock() < Attribute and (v159 and (v159.Parent and v159:FindFirstChild("Humanoid")))) then
                                    if v159.Humanoid.Health <= 0 then
                                        v159 = v158;
                                    end;
                                else
                                    v159 = v158;
                                end;
                            else
                                v159 = v158;
                            end;

                            if u135 and u5.Target.Value ~= u135 then
                                script_NpcKnowledge.MarkSearched(u5, u135);
                            end;

                            u135 = nil;

                            if v159 == nil and u56 then
                                v159 = script_NpcKnowledge.Strongest(u5, os.clock(), adoptable);

                                if v159 and v159 ~= u5.Target.Value then
                                    u135 = v159;
                                end;
                            end;

                            if v159 ~= u5.Target.Value then
                                u131();
                                u5.Target.Value = v159;
                                u6 = tick();
                                local v160;

                                if u53 or not (v159 and v159:FindFirstChild("HumanoidRootPart")) then
                                    v160 = nil;
                                else
                                    v160 = v159.HumanoidRootPart.Position or nil;
                                end;

                                u68 = v160;

                                if u66 == "aiming" or u66 == "firing" then
                                    if u66 ~= "idle" then
                                        u66 = "idle";

                                        if u4 then
                                            u5:SetAttribute("CombatState", "idle");
                                        end;
                                    end;

                                    u30.StopAiming();
                                end;
                            end;
                        end;

                        local Value = u5.Target.Value;
                        local v161 = Value and Value:FindFirstChild("HumanoidRootPart");

                        if v161 then
                            if Value.Humanoid.Health > 0 then
                                v161 = Value:IsDescendantOf(workspace);
                            else
                                v161 = false;
                            end;
                        end;

                        local v162;

                        if v161 then
                            v162 = script_NpcMutants.IsMutant(Value) or false;
                        else
                            v162 = false;
                        end;

                        if v161 and (u66 == "aiming" or u66 == "firing") then
                            local v163;

                            if Value then
                                v163 = Value:FindFirstChild("HumanoidRootPart");
                            else
                                v163 = Value;
                            end;

                            local v164;

                            if v163 then
                                if u53 and not u7 then
                                    if u53 then
                                        v164 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                    else
                                        v164 = u68;
                                    end;
                                else
                                    v164 = v163.Position;
                                end;
                            else
                                v164 = nil;
                            end;

                            if v164 then
                                u30.UpdateFacing(v164);
                            end;
                        end;

                        if v161 then
                            u136 = nil;
                        end;

                        if v161 then
                            local DistToTarget = u26.GetDistToTarget();
                            local _ = tick() - u6 > npcConfig.NoLOSOverrideTime;
                            local WeaponState = u30.GetWeaponState();
                            local v165 = u54 and not (script_NpcKnowledge.Get(u5, Value, os.clock()) or {}).visible;
                            local v166, v167;

                            if v165 then
                                local Sample = script_Perception.Sample;
                                local v168 = u132 and u132.lookAt;

                                if not v168 then
                                    if u53 then
                                        v168 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                    else
                                        v168 = u68;
                                    end;
                                end;

                                v166, v167 = Sample(u5, Value, true, v168, os.clock());
                            else
                                v166 = true;
                                v167 = nil;
                            end;

                            RaycastParams_new_ret.FilterDescendantsInstances = { u5, Value };
                            local v169, v170;

                            if v166 then
                                v169, v170 = NpcSight.Cast(u5.Head.Position, Value.HumanoidRootPart.Position - HumanoidRootPart.Position, RaycastParams_new_ret);
                            else
                                v169 = true;
                                v170 = 0;
                            end;

                            u7 = v169 == nil;
                            local v171 = 0;
                            local v172 = u5:GetAttribute("Stance") == "Crouch" and Vector3.new(0, 0.4, 0) or Vector3.new(0, 1.4, 0);
                            local v173 = HumanoidRootPart.CFrame:PointToWorldSpace(v172);
                            local v174 = HumanoidRootPart.CFrame.RightVector * script_StanceRules.LEAN_OFFSET;
                            local Position = Value.HumanoidRootPart.Position;
                            local v175 = u7;

                            if u75 ~= 0 and v166 then
                                v175 = NpcSight.Cast(v173, Position - v173, RaycastParams_new_ret) == nil;
                            end;

                            local v176, v177, v178, v179;

                            if v175 or not v166 then
                                v176 = false;
                                v177 = false;
                                v178 = 0;
                                v179 = 0;
                            else
                                local v180;
                                v180, v179 = NpcSight.Cast(v173 - v174, Position - (v173 - v174), RaycastParams_new_ret);
                                local v181;
                                v181, v178 = NpcSight.Cast(v173 + v174, Position - (v173 + v174), RaycastParams_new_ret);
                                v177 = v180 == nil;

                                if v181 == nil then
                                    v176 = true;
                                else
                                    v176 = false;
                                end;
                            end;

                            local v182 = script_StanceRules.PickLean({
                                state = string.upper(u66),
                                moving = HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 1.5,
                                reloading = u30.IsReloading(),
                                clearStraight = v175,
                                clearLeft = v177,
                                clearRight = v176,
                                current = u75,
                                leanedFor = u75 == 0 and 0 or (os.clock() - u76 or 0)
                            });

                            if v182 ~= u75 and (v182 == 0 or script_StanceRules.Hold(u76, os.clock())) then
                                local os_clock_ret3 = os.clock();
                                u75 = v182;
                                u76 = os_clock_ret3;

                                if u27 then
                                    u27.SetLean(u75);
                                end;
                            end;

                            if u7 then
                                v179 = v171;
                            elseif u75 ~= -1 or not (v177 and v179) then
                                v179 = (u75 ~= 1 or not (v176 and v178)) and 0 or v178;
                            end;

                            u7 = u7;

                            if not u7 then
                                if u75 == -1 and v177 then
                                    v176 = v177;
                                elseif u75 ~= 1 then
                                    v176 = false;
                                end;
                            end;

                            u7 = v176;

                            if v165 then
                                local trace = script_Perception.trace;
                                local v183 = trace and ((script_NpcKnowledge.Get(u5, Value, os.clock()) or {}).notice or 0) or trace;
                                local v184 = u7;
                                local v185 = script_NpcKnowledge.Notice(u5, Value, u7, v167, os.clock());
                                u7 = u7 and v185 >= 1;

                                if script_Perception.trace then
                                    local trace2 = script_Perception.trace;
                                    local v186 = {
                                        phase = "reacquire",
                                        inCone = v166,
                                        los = v184,
                                        noticeBefore = v183,
                                        noticeAfter = v185,
                                        visible = u7
                                    };
                                    local v187;

                                    if u53 then
                                        v187 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                    else
                                        v187 = u68;
                                    end;

                                    v186.known = v187;
                                    v186.info = script_Perception.lastInfo;
                                    trace2(u5, Value, v186);
                                end;
                            elseif script_Perception.trace then
                                local trace = script_Perception.trace;
                                local v188 = {
                                    phase = "tracking",
                                    los = u7,
                                    visible = u7
                                };
                                local v189;

                                if u53 then
                                    v189 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                else
                                    v189 = u68;
                                end;

                                v188.known = v189;
                                trace(u5, Value, v188);
                            end;

                            u29.Concealment = u7 and (v169 == nil and v170 and v170 or (v179 or 0)) or 0;

                            if u4 then
                                u5:SetAttribute("Concealment", u29.Concealment > 0 and u29.Concealment or nil);
                            end;

                            if u7 then
                                u6 = tick();
                                u68 = Value.HumanoidRootPart.Position;
                            end;

                            if u53 then
                                if u73 ~= Value then
                                    local os_clock_ret3 = os.clock();

                                    if u73 then
                                        script_NpcKnowledge.LostSight(u5, u73, os_clock_ret3);
                                        u73 = nil;
                                    end;
                                end;

                                if u7 then
                                    local v190 = not u95;

                                    if v190 then
                                        script_NpcTelemetry.Bump("sighting");
                                    end;

                                    u95 = true;
                                    local v191 = script_NpcKnowledge.Seen(u5, Value, Value.HumanoidRootPart.Position, os.clock());

                                    if u57 then
                                        script_NpcSquadShare.Report(u5, Value, "seen", v191.seenPos, 0, os.clock());
                                    end;

                                    if v190 and not u132 then
                                        script_NpcRadioChatter.Contact(u5, Value);
                                    end;

                                    u73 = Value;
                                else
                                    u95 = false;
                                    script_NpcKnowledge.LostSight(u5, Value, os.clock());
                                end;
                            end;

                            if u53 and not u7 then
                                local v192;

                                if u53 then
                                    v192 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                else
                                    v192 = u68;
                                end;

                                DistToTarget = v192 and (v192 - HumanoidRootPart.Position).Magnitude or (1 / 0);
                            end;

                            if u56 then
                                local os_clock_ret3 = os.clock();

                                if u7 then
                                    if u132 then
                                        script_NpcTelemetry.Bump("search.found");
                                        script_NpcRadioChatter.Event(u5, "found", Value);
                                    end;

                                    u131();
                                    goto l3;
                                end;

                                if v162 then
                                    if tick() - u6 >= 4 then
                                        giveUpSearch(Value);
                                    else
                                        local v193 = 0;

                                        while true do
                                            if v193 == 0 then
                                                v193 = -1;

                                                if not u132 then
                                                    goto l3;
                                                end;

                                                if u132.phase ~= "hold" and u132.phase ~= "watch" then
                                                    script_SquadBoard.SearchRole(u5, Value, HumanoidRootPart.Position, os_clock_ret3);
                                                end;

                                                u132.stats.computes = u26.pathComputes - u134;
                                                u29.SearchLook = u132.lookAt;

                                                if u4 then
                                                    u5:SetAttribute("Search", u132.phase);
                                                end;

                                                if u132.phase ~= "done" and os_clock_ret3 - u132.startedAt >= u132.prof.duration then
                                                    u132:giveUp(os_clock_ret3);
                                                end;

                                                if u132 ~= nil and u132.phase ~= "done" or u5.Target.Value then
                                                    goto l3;
                                                end;

                                                break;
                                            else
                                                break;
                                            end;
                                        end;
                                    end;
                                else
                                    if u132 and u133 == Value or tick() - u6 < 1.5 then
                                        goto l4;
                                    end;

                                    if estimateOf(Value, os_clock_ret3) then
                                        startSearch(Value, os_clock_ret3);
                                        goto l4;
                                    end;

                                    local Attribute = u5:GetAttribute("_RetaliateUntil");

                                    if Attribute and os_clock_ret3 < Attribute then
                                        goto l4;
                                    end;

                                    giveUpSearch(Value);
                                end;
                            else
                                local v194 = 0;

                                while true do
                                    if v194 == 0 then
                                        v194 = -1;
                                        local v195, v196, v197, v198, v199, v200, v201, v202, v203, v204, v205, v206, v207, v208, v209, v210, v211, v212, v213, v214, v215, v216, v217, v218, v219, v220, v221, v222, v223, v224, v225, v226, v227, v228, v229, v230, v231, v232, v233, v234, v235, v236, v237, v238, v239, v240, v241, v242, v243, v244, v245, v246, v247, v248, v249, v250, v251, v252, v253, v254, v255, v256, v257, v258, v259, v260, v261, v262;

                                        if u56 or (u7 or tick() - u6 <= 10) then
                                            updateStance(string.upper(u66), DistToTarget, Value);

                                            if not (u66 == "pathing" or (u66 == "moving" or (u66 == "fleeing" or u66 == "retreating")) or (u5:GetAttribute("Stance") == "Crouch" or u75 ~= 0)) then
                                                u26.MakeRoom();
                                            end;

                                            v195 = os.clock();
                                            u86 = u86 + (task_wait_ret or 0.1);
                                            v196 = u66 == "moving" and true or u66 == "fleeing";

                                            if v196 and (u83 == "Push" or u83 == "Flank") and (u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) >= script_NpcSuppression.HEAVY_TIER then
                                                cancelSprintForSuppression();
                                                v196 = false;
                                            end;

                                            if u86 >= 0.5 and not v196 then
                                                u86 = 0;
                                                v197 = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;
                                                v198 = math.min(v195 - (u96 or v195), 2);

                                                if script_NpcSuppression.HEAVY_TIER <= v197 then
                                                    script_NpcTelemetry.AddTime("sup.heavy", v198);
                                                elseif script_NpcSuppression.MEDIUM_TIER <= v197 then
                                                    script_NpcTelemetry.AddTime("sup.medium", v198);
                                                end;

                                                u96 = v195;
                                                v199 = script_NpcSuppression.HEAVY_TIER <= v197;

                                                if v199 and not u97 then
                                                    script_NpcRadioChatter.Event(u5, "pinned", Value);
                                                end;

                                                u97 = v199;
                                                v200 = getTactics();
                                                v201 = getTactics();

                                                if u37 then
                                                    if not u38 and v201 ~= script_TacticsRules.DEFAULTS then
                                                        u37:SetBravery(v201.Bravery);
                                                        u38 = true;
                                                    end;
                                                else
                                                    u37 = script_Morale.New(v201.Bravery);
                                                    u38 = v201 ~= script_TacticsRules.DEFAULTS;
                                                end;

                                                v202 = u37;
                                                v203, v204 = script_SquadBoard.CountNear(u5, HumanoidRootPart.Position, 80, CheckAlly, isEnemy);

                                                if script_NpcMutants.Enabled() then
                                                    v204 = v204 + script_NpcMutants.CountAggroNear(HumanoidRootPart.Position, 80);
                                                end;

                                                v202:Tick(math.min(v195 - os_clock_ret, 60), v203, v204, v195);
                                                os_clock_ret = v195;
                                                v205 = getPersona();

                                                if v202:Value() >= (v205 and v205.retreatAt or v200.RetreatAt) then
                                                    u90 = false;
                                                end;

                                                if u4 then
                                                    v206 = u5;
                                                    v207 = v202:Value() + 0.5;
                                                    v206:SetAttribute("Morale", (math.floor(v207)));
                                                end;

                                                v208 = u5:GetAttribute("_LastHitAt");

                                                if u88 and (HumanoidRootPart.Position - u88).Magnitude > 8 then
                                                    script_SquadBoard.ReleaseCover(u5);
                                                    u88 = nil;
                                                end;

                                                if u88 == nil then
                                                    v209 = false;
                                                else
                                                    v209 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                                                end;

                                                if Value then
                                                    v210 = Value:FindFirstChild("HumanoidRootPart");
                                                else
                                                    v210 = Value;
                                                end;

                                                if v210 then
                                                    if u53 and not u7 then
                                                        if u53 then
                                                            v211 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                        else
                                                            v211 = u68;
                                                        end;
                                                    else
                                                        v211 = v210.Position;
                                                    end;
                                                else
                                                    v211 = nil;
                                                end;

                                                if v209 then
                                                    v212 = v211 == nil and true or script_CoverFinder.IsCovered(HumanoidRootPart.Position, v211, { u5, Value, workspace.PlayerCharacters });
                                                else
                                                    v212 = v209;
                                                end;

                                                v213 = nil;
                                                v214 = nil;

                                                if u58 and (u7 and (u66 == "aiming" or u66 == "firing")) then
                                                    script_SquadBoard.Pressure(u5, Value, v195);
                                                end;

                                                if u58 and (u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) >= script_NpcSuppression.MEDIUM_TIER then
                                                    script_SquadBoard.Announce(u5, "Pinned", Value, v195, 1.5);
                                                end;

                                                if u58 then
                                                    v213 = script_SquadBoard.Mates(u5, HumanoidRootPart.Position, Value, v195, CheckAlly);
                                                    v215 = script_SquadBoard.Covering(u5, v195);

                                                    if v215 and not u7 then
                                                        script_SquadBoard.StopCovering(u5);
                                                        v215 = nil;
                                                    end;

                                                    v214 = v213.moving or v213.pinned;

                                                    if not v214 then
                                                        u94 = nil;
                                                    end;

                                                    if not v215 and (v214 and (u7 and not u30.IsReloading())) and ((u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) < script_NpcSuppression.HEAVY_TIER and (u93 <= v195 and u94 ~= v214)) then
                                                        u94 = v214;

                                                        if math.random() < (v205 and v205.coverChance or script_SquadBoard.DEFAULT_COVER_CHANCE) and script_SquadBoard.TryCover(u5, v214, v195, v195 + 3.5) then
                                                            u93 = v195 + 3.5 + 4;
                                                            script_NpcTelemetry.Bump("cover.slot");
                                                            script_NpcRadioChatter.Event(u5, "cover", Value, {
                                                                mate = v214
                                                            });
                                                        else
                                                            v214 = v215;
                                                        end;
                                                    else
                                                        v214 = v215;
                                                    end;

                                                    if u4 then
                                                        v216 = u5;
                                                        v217 = "Covering";

                                                        if v214 then
                                                            v218 = v214.Name or nil;
                                                        else
                                                            v218 = nil;
                                                        end;

                                                        v216:SetAttribute(v217, v218);
                                                    end;
                                                end;

                                                if u60 then
                                                    script_NpcOpportunity.Observe(u61, Value.Humanoid.Health, u7, v195);
                                                    v219 = (Value.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;
                                                    v220 = Value:FindFirstChildOfClass("Tool");
                                                    v221 = Players:GetPlayerFromCharacter(Value) ~= nil;
                                                    v222 = script_NpcKnowledge.Get(u5, Value, v195);

                                                    if v222 and (v222.visible and v222.seenPos) then
                                                        if u62 and v222.seenAt - u62.t >= script_NpcOpportunity.RETREAT_MIN_DT then
                                                            if script_NpcOpportunity.Retreating(u62.pos, u62.t, v222.seenPos, v222.seenAt, HumanoidRootPart.Position) then
                                                                u63 = v195 + script_NpcOpportunity.RELOAD_WINDOW;
                                                            end;

                                                            u62 = {
                                                                pos = v222.seenPos,
                                                                t = v222.seenAt
                                                            };
                                                        elseif not u62 then
                                                            u62 = {
                                                                pos = v222.seenPos,
                                                                t = v222.seenAt
                                                            };
                                                        end;
                                                    else
                                                        u62 = nil;
                                                    end;

                                                    if v221 and v220 ~= nil then
                                                        v223 = v220:GetAttribute("ReloadedAt") or nil;
                                                    else
                                                        v223 = nil;
                                                    end;

                                                    v224 = u64;
                                                    v225 = u65;

                                                    if script_NpcOpportunity.ReloadPerceived(v195, v223, u7, v219) then
                                                        u64 = v223 + script_NpcOpportunity.RELOAD_WINDOW;

                                                        if v224 <= v195 then
                                                            script_NpcRadioChatter.Event(u5, "reload", Value);
                                                        end;
                                                    end;

                                                    if v221 then
                                                        v226 = Value:GetAttribute("HealingUntil") or nil;
                                                    else
                                                        v226 = nil;
                                                    end;

                                                    if script_NpcOpportunity.HealPerceived(v195, v226, u7, v219, Value:GetAttribute("HealingAudible") == true) then
                                                        u65 = v226 + script_NpcOpportunity.HEAL_WINDOW;

                                                        if v225 <= v195 then
                                                            script_NpcRadioChatter.Event(u5, "heal", Value);
                                                        end;
                                                    end;

                                                    v227 = {
                                                        reload = v195 < u64,
                                                        heal = v195 < u65,
                                                        retreat = v195 < u63
                                                    };
                                                    v228 = script_NpcOpportunity.Strength(v227, v205);

                                                    if u4 then
                                                        u5:SetAttribute("Opening", v227.reload and "reload" or (v227.heal and "heal" or (v227.retreat and "retreat" or nil)));
                                                        v229 = u5;
                                                        v230 = (1 - script_NpcOpportunity.HurtFrac(u61, v195)) * 100 + 0.5;
                                                        v229:SetAttribute("SeenHurt", (math.floor(v230)));
                                                    end;
                                                else
                                                    v228 = nil;
                                                end;

                                                v231 = {
                                                    morale = v202:Value(),
                                                    retreatAt = v205 and v205.retreatAt or v200.RetreatAt,
                                                    fleeAt = v205 and v205.fleeAt or v200.FleeAt,
                                                    aggression = v200.Aggression,
                                                    boldness = math_random_ret2
                                                };

                                                if v205 then
                                                    v232 = v205.pushWill;
                                                else
                                                    v232 = v205;
                                                end;

                                                v231.pushWill = v232;

                                                if v205 then
                                                    v233 = v205.flankWill;
                                                else
                                                    v233 = v205;
                                                end;

                                                v231.flankWill = v233;

                                                if v205 then
                                                    v234 = v205.mediumBold;
                                                else
                                                    v234 = v205;
                                                end;

                                                v231.mediumBold = v234;

                                                if v205 then
                                                    v235 = v205.flankUnseen;
                                                else
                                                    v235 = v205;
                                                end;

                                                v231.flankUnseen = v235;

                                                if v205 then
                                                    v236 = v205.pushOdds;
                                                else
                                                    v236 = v205;
                                                end;

                                                v231.pushOdds = v236;

                                                if v205 then
                                                    v237 = v205.pushMorale;
                                                else
                                                    v237 = v205;
                                                end;

                                                v231.pushMorale = v237;

                                                if v205 then
                                                    v238 = v205.reloadCoverFrac;
                                                else
                                                    v238 = v205;
                                                end;

                                                v231.reloadCoverFrac = v238;

                                                if v205 then
                                                    v239 = v205.intentHold;
                                                else
                                                    v239 = v205;
                                                end;

                                                v231.intentHold = v239;
                                                v231.covering = v214 ~= nil;

                                                if v213 then
                                                    v240 = v213.pressure;
                                                else
                                                    v240 = v213;
                                                end;

                                                v231.matePressure = v240;

                                                if v213 then
                                                    v241 = v213.pinned ~= nil;
                                                else
                                                    v241 = v213;
                                                end;

                                                v231.matePinned = v241;

                                                if v213 then
                                                    v213 = v213.moving ~= nil;
                                                end;

                                                v231.mateMoving = v213;
                                                v231.exploit = v205 and (v205.exploit or 0.25) or 0.25;
                                                v231.exploitPinned = v205 and (v205.exploitPinned or 0) or 0;
                                                v231.opportunity = v228;
                                                v242 = u31 and u31.push;
                                                v231.weaponPush = v242;
                                                v243 = u31 and u31.flank;
                                                v231.weaponFlank = v243;
                                                v231.fightBack = u91;
                                                v231.retreated = u90;
                                                v244 = u10:FindFirstChild("Ammo");

                                                if v244 then
                                                    v244 = v244:FindFirstChild("MagAmmo");
                                                end;

                                                v231.ammoFrac = v244 and (v244.MaxValue > 0 and v244.Value / v244.MaxValue) or 1;
                                                v231.inCover = v209;
                                                v231.coverValid = v212;

                                                if type(v208) == "number" then
                                                    v245 = v195 - v208 < script_StanceRules.UNDER_FIRE_SECONDS;
                                                else
                                                    v245 = false;
                                                end;

                                                v231.underFire = v245;
                                                v231.repositionDue = v195 < u79;
                                                v231.hasLOS = u7;
                                                v231.unseenFor = tick() - u6;
                                                v231.flankReady = v195 - u92 >= (v205 and v205.flankCooldown or script_TacticsRules.FLANK_COOLDOWN);
                                                v246 = script_SquadBoard.FlankFree(Value, u5, v195);

                                                if v246 then
                                                    v247 = u132 and not u132:AllowsTacticMove();
                                                    v246 = not v247;
                                                end;

                                                v231.flankFree = v246;
                                                v231.targetHealthFrac = u60 and script_NpcOpportunity.HurtFrac(u61, v195) or (Value.Humanoid.MaxHealth > 0 and (Value.Humanoid.Health / Value.Humanoid.MaxHealth or 1) or 1);
                                                v231.odds = v204 > 0 and (v203 + 1) / v204 or (1 / 0);
                                                v231.dist = DistToTarget;
                                                v231.tooClose = u26.TooCloseRange;
                                                v231.current = u83;
                                                v231.currentSince = u84;
                                                v231.now = v195;
                                                v231.suppression = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;
                                                v231.vsMutant = v162;
                                                v248 = script_TacticsRules.Pick(v231);

                                                if v231.suppression >= script_NpcSuppression.MEDIUM_TIER then
                                                    v231.suppression = 0;
                                                    v249 = script_TacticsRules.Pick(v231);

                                                    if v249 ~= v248 and (v249 == "Push" or v249 == "Flank") then
                                                        script_NpcSuppression.Count(v249 == "Push" and "pushBlocked" or "flankBlocked");
                                                    end;
                                                end;

                                                if v248 ~= u83 then
                                                    script_NpcTelemetry.Bump("tactic." .. v248);

                                                    if u83 == "Flank" then
                                                        script_SquadBoard.ReleaseFlank(u5);
                                                    end;

                                                    u83 = v248;
                                                    u84 = v195;
                                                    u85 = false;

                                                    if u4 then
                                                        u5:SetAttribute("Tactic", v248);
                                                    end;
                                                end;

                                                if u85 and (u83 == "Push" and v195 - os_clock_ret2 >= 4) then
                                                    u85 = false;
                                                end;

                                                if u85 and (u83 == "Reposition" and (v209 and not v212)) then
                                                    u85 = false;
                                                end;

                                                if u85 and (u83 == "Flee" and u7) then
                                                    u85 = false;
                                                end;

                                                v250 = script_TacticsRules.MOVE_MODE[u83];

                                                if v250 and (not u85 and u89 <= v195) then
                                                    if u83 == "CoverReload" then
                                                        v251 = u10:FindFirstChild("Ammo");

                                                        if v251 then
                                                            v251 = v251:FindFirstChild("MagAmmo");
                                                        end;

                                                        v252 = v251 and (v251.MaxValue > 0 and v251.Value / v251.MaxValue) or 1;
                                                        v253 = getPersona();

                                                        if v252 <= (v253 and v253.reloadCoverFrac or script_TacticsRules.RELOAD_COVER_FRACTION) then
                                                            if not (u30.IsReloading() and (u83 ~= "Flee" and u83 ~= "Retreat")) then
                                                                u89 = v195 + 1;

                                                                if Value then
                                                                    v254 = Value:FindFirstChild("HumanoidRootPart");
                                                                else
                                                                    v254 = Value;
                                                                end;

                                                                if v254 then
                                                                    if u53 and not u7 then
                                                                        if u53 then
                                                                            v255 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                        else
                                                                            v255 = u68;
                                                                        end;
                                                                    else
                                                                        v255 = v254.Position;
                                                                    end;
                                                                else
                                                                    v255 = nil;
                                                                end;

                                                                if v255 == nil then
                                                                    v256 = false;
                                                                else
                                                                    v256 = u83 ~= "Flank" and true or script_SquadBoard.TryFlank(u5, Value, v195);
                                                                end;

                                                                if v256 then
                                                                    v257 = script_CoverFinder.Find({
                                                                        from = HumanoidRootPart.Position,
                                                                        threat = v255,
                                                                        mode = v250,
                                                                        exclude = { u5, Value, workspace.PlayerCharacters },
                                                                        preferredDist = (u26.IdealMinRange + u26.IdealMaxRange) / 2,
                                                                        tooClose = u26.TooCloseRange,

                                                                        isClaimed = function(p263) -- Line: 1409, Name: isClaimed
                                                                            -- upvalues: script_SquadBoard (ref), u5 (ref)
                                                                            return script_SquadBoard.IsClaimed(p263, u5);
                                                                        end,

                                                                        isCrowded = u26.IsCrowded
                                                                    });
                                                                else
                                                                    v257 = nil;
                                                                end;

                                                                if not v257 and (v255 and (u83 == "Retreat" or u83 == "Flee")) then
                                                                    v257 = u26.ClearSpotAway(v255, u83 == "Flee" and 40 or 20);
                                                                end;

                                                                if v257 then
                                                                    script_SquadBoard.ClaimCover(u5, v257);
                                                                    u87 = v257;
                                                                    u30.StopAiming();

                                                                    if u75 ~= 0 then
                                                                        u75 = 0;

                                                                        if u27 then
                                                                            u27.SetLean(0);
                                                                        end;
                                                                    end;

                                                                    u26.SprintTo(v257, v200.SprintSpeed);
                                                                    script_SquadBoard.StopCovering(u5);
                                                                    endSuppressive("moving");

                                                                    if u58 then
                                                                        script_SquadBoard.Announce(u5, u83, Value, v195, 4);
                                                                    end;

                                                                    script_NpcRadioChatter.Event(u5, string.lower(u83), Value, {
                                                                        spot = v257
                                                                    });
                                                                    v258 = u83 == "Flee" and "fleeing" or "moving";

                                                                    if u66 ~= v258 then
                                                                        u66 = v258;

                                                                        if u4 then
                                                                            u5:SetAttribute("CombatState", v258);
                                                                        end;
                                                                    end;
                                                                else
                                                                    u89 = v195 + 3;

                                                                    if u83 == "Flank" then
                                                                        script_SquadBoard.ReleaseFlank(u5);
                                                                        u92 = v195;
                                                                    end;

                                                                    if u83 == "CoverReload" and (not u30.IsReloading() and WeaponState == "ready") then
                                                                        if u66 ~= "reloading" then
                                                                            u66 = "reloading";

                                                                            if u4 then
                                                                                u5:SetAttribute("CombatState", "reloading");
                                                                            end;
                                                                        end;

                                                                        u30.StopAiming(true);
                                                                        task.spawn(function() -- Line: 1438
                                                                            -- upvalues: u30 (ref)
                                                                            u30.PerformReload();
                                                                        end);
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    elseif not (u30.IsReloading() and (u83 ~= "Flee" and u83 ~= "Retreat")) then
                                                        u89 = v195 + 1;

                                                        if Value then
                                                            v254 = Value:FindFirstChild("HumanoidRootPart");
                                                        else
                                                            v254 = Value;
                                                        end;

                                                        if v254 then
                                                            if u53 and not u7 then
                                                                if u53 then
                                                                    v255 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                else
                                                                    v255 = u68;
                                                                end;
                                                            else
                                                                v255 = v254.Position;
                                                            end;
                                                        else
                                                            v255 = nil;
                                                        end;

                                                        if v255 == nil then
                                                            v256 = false;
                                                        else
                                                            v256 = u83 ~= "Flank" and true or script_SquadBoard.TryFlank(u5, Value, v195);
                                                        end;

                                                        if v256 then
                                                            v257 = script_CoverFinder.Find({
                                                                from = HumanoidRootPart.Position,
                                                                threat = v255,
                                                                mode = v250,
                                                                exclude = { u5, Value, workspace.PlayerCharacters },
                                                                preferredDist = (u26.IdealMinRange + u26.IdealMaxRange) / 2,
                                                                tooClose = u26.TooCloseRange,

                                                                isClaimed = function(p263) -- Line: 1409, Name: isClaimed
                                                                    -- upvalues: script_SquadBoard (ref), u5 (ref)
                                                                    return script_SquadBoard.IsClaimed(p263, u5);
                                                                end,

                                                                isCrowded = u26.IsCrowded
                                                            });
                                                        else
                                                            v257 = nil;
                                                        end;

                                                        if not v257 and (v255 and (u83 == "Retreat" or u83 == "Flee")) then
                                                            v257 = u26.ClearSpotAway(v255, u83 == "Flee" and 40 or 20);
                                                        end;

                                                        if v257 then
                                                            script_SquadBoard.ClaimCover(u5, v257);
                                                            u87 = v257;
                                                            u30.StopAiming();

                                                            if u75 ~= 0 then
                                                                u75 = 0;

                                                                if u27 then
                                                                    u27.SetLean(0);
                                                                end;
                                                            end;

                                                            u26.SprintTo(v257, v200.SprintSpeed);
                                                            script_SquadBoard.StopCovering(u5);
                                                            endSuppressive("moving");

                                                            if u58 then
                                                                script_SquadBoard.Announce(u5, u83, Value, v195, 4);
                                                            end;

                                                            script_NpcRadioChatter.Event(u5, string.lower(u83), Value, {
                                                                spot = v257
                                                            });
                                                            v258 = u83 == "Flee" and "fleeing" or "moving";

                                                            if u66 ~= v258 then
                                                                u66 = v258;

                                                                if u4 then
                                                                    u5:SetAttribute("CombatState", v258);
                                                                end;
                                                            end;
                                                        else
                                                            u89 = v195 + 3;

                                                            if u83 == "Flank" then
                                                                script_SquadBoard.ReleaseFlank(u5);
                                                                u92 = v195;
                                                            end;

                                                            if u83 == "CoverReload" and (not u30.IsReloading() and WeaponState == "ready") then
                                                                if u66 ~= "reloading" then
                                                                    u66 = "reloading";

                                                                    if u4 then
                                                                        u5:SetAttribute("CombatState", "reloading");
                                                                    end;
                                                                end;

                                                                u30.StopAiming(true);
                                                                task.spawn(function() -- Line: 1438
                                                                    -- upvalues: u30 (ref)
                                                                    u30.PerformReload();
                                                                end);
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;

                                            if u66 == "moving" or u66 == "fleeing" then
                                                v259 = u5:GetAttribute("_LastHitAt");

                                                if u66 == "fleeing" and (type(v259) == "number" and (v195 - v259 < 0.5 and DistToTarget < 15)) then
                                                    u91 = true;
                                                end;

                                                v260 = u26.SprintStatus();

                                                if v260 == "moving" and (u66 ~= "fleeing" or not u91) then
                                                    if not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                                                        AlignOrientation.Enabled = false;
                                                        Humanoid.AutoRotate = true;
                                                    end;
                                                else
                                                    u26.StopSprint();
                                                    script_SquadBoard.EndMove(u5);

                                                    if u132 then
                                                        u132:Moved(v195);
                                                    end;

                                                    if v260 == "arrived" then
                                                        u88 = u87;
                                                        os_clock_ret2 = v195;
                                                        u80 = 0;
                                                        u85 = true;

                                                        if u83 == "Retreat" then
                                                            u90 = true;
                                                        end;

                                                        if u83 == "Flank" then
                                                            script_SquadBoard.ReleaseFlank(u5);
                                                            u92 = v195;
                                                        end;
                                                    else
                                                        script_SquadBoard.ReleaseCover(u5);
                                                        u89 = v195 + 3;

                                                        if u83 == "Flank" then
                                                            script_SquadBoard.ReleaseFlank(u5);
                                                            u92 = v195;
                                                        end;
                                                    end;

                                                    u87 = nil;
                                                    v261 = u30.IsReloading() and "reloading" or "idle";

                                                    if u66 ~= v261 then
                                                        u66 = v261;

                                                        if u4 then
                                                            u5:SetAttribute("CombatState", v261);
                                                        end;
                                                    end;

                                                    if u83 ~= "Flee" or u91 then
                                                        goto l2;
                                                    end;
                                                end;
                                            else
                                                if u83 ~= "Flee" or u91 then
                                                    goto l2;
                                                end;

                                                v262 = u5:GetAttribute("_LastHitAt");

                                                if type(v262) == "number" and (v195 - v262 < 0.5 and DistToTarget < 15) then
                                                    u91 = true;
                                                    goto l2;
                                                end;

                                                u30.StopAiming();

                                                if not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                                                    AlignOrientation.Enabled = false;
                                                    Humanoid.AutoRotate = true;
                                                end;

                                                u26.StopMoving();

                                                if u66 ~= "idle" then
                                                    u66 = "idle";

                                                    if u4 then
                                                        u5:SetAttribute("CombatState", "idle");
                                                    end;
                                                end;
                                            end;
                                        else
                                            local Attribute = u5:GetAttribute("_RetaliateUntil");

                                            if Attribute and os.clock() < Attribute then
                                                updateStance(string.upper(u66), DistToTarget, Value);

                                                if not (u66 == "pathing" or (u66 == "moving" or (u66 == "fleeing" or u66 == "retreating")) or (u5:GetAttribute("Stance") == "Crouch" or u75 ~= 0)) then
                                                    u26.MakeRoom();
                                                end;

                                                v195 = os.clock();
                                                u86 = u86 + (task_wait_ret or 0.1);
                                                v196 = u66 == "moving" and true or u66 == "fleeing";

                                                if v196 and (u83 == "Push" or u83 == "Flank") and (u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) >= script_NpcSuppression.HEAVY_TIER then
                                                    cancelSprintForSuppression();
                                                    v196 = false;
                                                end;

                                                if u86 >= 0.5 and not v196 then
                                                    u86 = 0;
                                                    v197 = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;
                                                    v198 = math.min(v195 - (u96 or v195), 2);

                                                    if script_NpcSuppression.HEAVY_TIER <= v197 then
                                                        script_NpcTelemetry.AddTime("sup.heavy", v198);
                                                    elseif script_NpcSuppression.MEDIUM_TIER <= v197 then
                                                        script_NpcTelemetry.AddTime("sup.medium", v198);
                                                    end;

                                                    u96 = v195;
                                                    v199 = script_NpcSuppression.HEAVY_TIER <= v197;

                                                    if v199 and not u97 then
                                                        script_NpcRadioChatter.Event(u5, "pinned", Value);
                                                    end;

                                                    u97 = v199;
                                                    v200 = getTactics();
                                                    v201 = getTactics();

                                                    if u37 then
                                                        if not u38 and v201 ~= script_TacticsRules.DEFAULTS then
                                                            u37:SetBravery(v201.Bravery);
                                                            u38 = true;
                                                        end;
                                                    else
                                                        u37 = script_Morale.New(v201.Bravery);
                                                        u38 = v201 ~= script_TacticsRules.DEFAULTS;
                                                    end;

                                                    v202 = u37;
                                                    v203, v204 = script_SquadBoard.CountNear(u5, HumanoidRootPart.Position, 80, CheckAlly, isEnemy);

                                                    if script_NpcMutants.Enabled() then
                                                        v204 = v204 + script_NpcMutants.CountAggroNear(HumanoidRootPart.Position, 80);
                                                    end;

                                                    v202:Tick(math.min(v195 - os_clock_ret, 60), v203, v204, v195);
                                                    os_clock_ret = v195;
                                                    v205 = getPersona();

                                                    if v202:Value() >= (v205 and v205.retreatAt or v200.RetreatAt) then
                                                        u90 = false;
                                                    end;

                                                    if u4 then
                                                        v206 = u5;
                                                        v207 = v202:Value() + 0.5;
                                                        v206:SetAttribute("Morale", (math.floor(v207)));
                                                    end;

                                                    v208 = u5:GetAttribute("_LastHitAt");

                                                    if u88 and (HumanoidRootPart.Position - u88).Magnitude > 8 then
                                                        script_SquadBoard.ReleaseCover(u5);
                                                        u88 = nil;
                                                    end;

                                                    if u88 == nil then
                                                        v209 = false;
                                                    else
                                                        v209 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                                                    end;

                                                    if Value then
                                                        v210 = Value:FindFirstChild("HumanoidRootPart");
                                                    else
                                                        v210 = Value;
                                                    end;

                                                    if v210 then
                                                        if u53 and not u7 then
                                                            if u53 then
                                                                v211 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                            else
                                                                v211 = u68;
                                                            end;
                                                        else
                                                            v211 = v210.Position;
                                                        end;
                                                    else
                                                        v211 = nil;
                                                    end;

                                                    if v209 then
                                                        v212 = v211 == nil and true or script_CoverFinder.IsCovered(HumanoidRootPart.Position, v211, { u5, Value, workspace.PlayerCharacters });
                                                    else
                                                        v212 = v209;
                                                    end;

                                                    v213 = nil;
                                                    v214 = nil;

                                                    if u58 and (u7 and (u66 == "aiming" or u66 == "firing")) then
                                                        script_SquadBoard.Pressure(u5, Value, v195);
                                                    end;

                                                    if u58 and (u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) >= script_NpcSuppression.MEDIUM_TIER then
                                                        script_SquadBoard.Announce(u5, "Pinned", Value, v195, 1.5);
                                                    end;

                                                    if u58 then
                                                        v213 = script_SquadBoard.Mates(u5, HumanoidRootPart.Position, Value, v195, CheckAlly);
                                                        v215 = script_SquadBoard.Covering(u5, v195);

                                                        if v215 and not u7 then
                                                            script_SquadBoard.StopCovering(u5);
                                                            v215 = nil;
                                                        end;

                                                        v214 = v213.moving or v213.pinned;

                                                        if not v214 then
                                                            u94 = nil;
                                                        end;

                                                        if not v215 and (v214 and (u7 and not u30.IsReloading())) and ((u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) < script_NpcSuppression.HEAVY_TIER and (u93 <= v195 and u94 ~= v214)) then
                                                            u94 = v214;

                                                            if math.random() < (v205 and v205.coverChance or script_SquadBoard.DEFAULT_COVER_CHANCE) and script_SquadBoard.TryCover(u5, v214, v195, v195 + 3.5) then
                                                                u93 = v195 + 3.5 + 4;
                                                                script_NpcTelemetry.Bump("cover.slot");
                                                                script_NpcRadioChatter.Event(u5, "cover", Value, {
                                                                    mate = v214
                                                                });
                                                            else
                                                                v214 = v215;
                                                            end;
                                                        else
                                                            v214 = v215;
                                                        end;

                                                        if u4 then
                                                            v216 = u5;
                                                            v217 = "Covering";

                                                            if v214 then
                                                                v218 = v214.Name or nil;
                                                            else
                                                                v218 = nil;
                                                            end;

                                                            v216:SetAttribute(v217, v218);
                                                        end;
                                                    end;

                                                    if u60 then
                                                        script_NpcOpportunity.Observe(u61, Value.Humanoid.Health, u7, v195);
                                                        v219 = (Value.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;
                                                        v220 = Value:FindFirstChildOfClass("Tool");
                                                        v221 = Players:GetPlayerFromCharacter(Value) ~= nil;
                                                        v222 = script_NpcKnowledge.Get(u5, Value, v195);

                                                        if v222 and (v222.visible and v222.seenPos) then
                                                            if u62 and v222.seenAt - u62.t >= script_NpcOpportunity.RETREAT_MIN_DT then
                                                                if script_NpcOpportunity.Retreating(u62.pos, u62.t, v222.seenPos, v222.seenAt, HumanoidRootPart.Position) then
                                                                    u63 = v195 + script_NpcOpportunity.RELOAD_WINDOW;
                                                                end;

                                                                u62 = {
                                                                    pos = v222.seenPos,
                                                                    t = v222.seenAt
                                                                };
                                                            elseif not u62 then
                                                                u62 = {
                                                                    pos = v222.seenPos,
                                                                    t = v222.seenAt
                                                                };
                                                            end;
                                                        else
                                                            u62 = nil;
                                                        end;

                                                        if v221 and v220 ~= nil then
                                                            v223 = v220:GetAttribute("ReloadedAt") or nil;
                                                        else
                                                            v223 = nil;
                                                        end;

                                                        v224 = u64;
                                                        v225 = u65;

                                                        if script_NpcOpportunity.ReloadPerceived(v195, v223, u7, v219) then
                                                            u64 = v223 + script_NpcOpportunity.RELOAD_WINDOW;

                                                            if v224 <= v195 then
                                                                script_NpcRadioChatter.Event(u5, "reload", Value);
                                                            end;
                                                        end;

                                                        if v221 then
                                                            v226 = Value:GetAttribute("HealingUntil") or nil;
                                                        else
                                                            v226 = nil;
                                                        end;

                                                        if script_NpcOpportunity.HealPerceived(v195, v226, u7, v219, Value:GetAttribute("HealingAudible") == true) then
                                                            u65 = v226 + script_NpcOpportunity.HEAL_WINDOW;

                                                            if v225 <= v195 then
                                                                script_NpcRadioChatter.Event(u5, "heal", Value);
                                                            end;
                                                        end;

                                                        v227 = {
                                                            reload = v195 < u64,
                                                            heal = v195 < u65,
                                                            retreat = v195 < u63
                                                        };
                                                        v228 = script_NpcOpportunity.Strength(v227, v205);

                                                        if u4 then
                                                            u5:SetAttribute("Opening", v227.reload and "reload" or (v227.heal and "heal" or (v227.retreat and "retreat" or nil)));
                                                            v229 = u5;
                                                            v230 = (1 - script_NpcOpportunity.HurtFrac(u61, v195)) * 100 + 0.5;
                                                            v229:SetAttribute("SeenHurt", (math.floor(v230)));
                                                        end;
                                                    else
                                                        v228 = nil;
                                                    end;

                                                    v231 = {
                                                        morale = v202:Value(),
                                                        retreatAt = v205 and v205.retreatAt or v200.RetreatAt,
                                                        fleeAt = v205 and v205.fleeAt or v200.FleeAt,
                                                        aggression = v200.Aggression,
                                                        boldness = math_random_ret2
                                                    };

                                                    if v205 then
                                                        v232 = v205.pushWill;
                                                    else
                                                        v232 = v205;
                                                    end;

                                                    v231.pushWill = v232;

                                                    if v205 then
                                                        v233 = v205.flankWill;
                                                    else
                                                        v233 = v205;
                                                    end;

                                                    v231.flankWill = v233;

                                                    if v205 then
                                                        v234 = v205.mediumBold;
                                                    else
                                                        v234 = v205;
                                                    end;

                                                    v231.mediumBold = v234;

                                                    if v205 then
                                                        v235 = v205.flankUnseen;
                                                    else
                                                        v235 = v205;
                                                    end;

                                                    v231.flankUnseen = v235;

                                                    if v205 then
                                                        v236 = v205.pushOdds;
                                                    else
                                                        v236 = v205;
                                                    end;

                                                    v231.pushOdds = v236;

                                                    if v205 then
                                                        v237 = v205.pushMorale;
                                                    else
                                                        v237 = v205;
                                                    end;

                                                    v231.pushMorale = v237;

                                                    if v205 then
                                                        v238 = v205.reloadCoverFrac;
                                                    else
                                                        v238 = v205;
                                                    end;

                                                    v231.reloadCoverFrac = v238;

                                                    if v205 then
                                                        v239 = v205.intentHold;
                                                    else
                                                        v239 = v205;
                                                    end;

                                                    v231.intentHold = v239;
                                                    v231.covering = v214 ~= nil;

                                                    if v213 then
                                                        v240 = v213.pressure;
                                                    else
                                                        v240 = v213;
                                                    end;

                                                    v231.matePressure = v240;

                                                    if v213 then
                                                        v241 = v213.pinned ~= nil;
                                                    else
                                                        v241 = v213;
                                                    end;

                                                    v231.matePinned = v241;

                                                    if v213 then
                                                        v213 = v213.moving ~= nil;
                                                    end;

                                                    v231.mateMoving = v213;
                                                    v231.exploit = v205 and (v205.exploit or 0.25) or 0.25;
                                                    v231.exploitPinned = v205 and (v205.exploitPinned or 0) or 0;
                                                    v231.opportunity = v228;
                                                    v242 = u31 and u31.push;
                                                    v231.weaponPush = v242;
                                                    v243 = u31 and u31.flank;
                                                    v231.weaponFlank = v243;
                                                    v231.fightBack = u91;
                                                    v231.retreated = u90;
                                                    v244 = u10:FindFirstChild("Ammo");

                                                    if v244 then
                                                        v244 = v244:FindFirstChild("MagAmmo");
                                                    end;

                                                    v231.ammoFrac = v244 and (v244.MaxValue > 0 and v244.Value / v244.MaxValue) or 1;
                                                    v231.inCover = v209;
                                                    v231.coverValid = v212;

                                                    if type(v208) == "number" then
                                                        v245 = v195 - v208 < script_StanceRules.UNDER_FIRE_SECONDS;
                                                    else
                                                        v245 = false;
                                                    end;

                                                    v231.underFire = v245;
                                                    v231.repositionDue = v195 < u79;
                                                    v231.hasLOS = u7;
                                                    v231.unseenFor = tick() - u6;
                                                    v231.flankReady = v195 - u92 >= (v205 and v205.flankCooldown or script_TacticsRules.FLANK_COOLDOWN);
                                                    v246 = script_SquadBoard.FlankFree(Value, u5, v195);

                                                    if v246 then
                                                        v247 = u132 and not u132:AllowsTacticMove();
                                                        v246 = not v247;
                                                    end;

                                                    v231.flankFree = v246;
                                                    v231.targetHealthFrac = u60 and script_NpcOpportunity.HurtFrac(u61, v195) or (Value.Humanoid.MaxHealth > 0 and (Value.Humanoid.Health / Value.Humanoid.MaxHealth or 1) or 1);
                                                    v231.odds = v204 > 0 and (v203 + 1) / v204 or (1 / 0);
                                                    v231.dist = DistToTarget;
                                                    v231.tooClose = u26.TooCloseRange;
                                                    v231.current = u83;
                                                    v231.currentSince = u84;
                                                    v231.now = v195;
                                                    v231.suppression = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;
                                                    v231.vsMutant = v162;
                                                    v248 = script_TacticsRules.Pick(v231);

                                                    if v231.suppression >= script_NpcSuppression.MEDIUM_TIER then
                                                        v231.suppression = 0;
                                                        v249 = script_TacticsRules.Pick(v231);

                                                        if v249 ~= v248 and (v249 == "Push" or v249 == "Flank") then
                                                            script_NpcSuppression.Count(v249 == "Push" and "pushBlocked" or "flankBlocked");
                                                        end;
                                                    end;

                                                    if v248 ~= u83 then
                                                        script_NpcTelemetry.Bump("tactic." .. v248);

                                                        if u83 == "Flank" then
                                                            script_SquadBoard.ReleaseFlank(u5);
                                                        end;

                                                        u83 = v248;
                                                        u84 = v195;
                                                        u85 = false;

                                                        if u4 then
                                                            u5:SetAttribute("Tactic", v248);
                                                        end;
                                                    end;

                                                    if u85 and (u83 == "Push" and v195 - os_clock_ret2 >= 4) then
                                                        u85 = false;
                                                    end;

                                                    if u85 and (u83 == "Reposition" and (v209 and not v212)) then
                                                        u85 = false;
                                                    end;

                                                    if u85 and (u83 == "Flee" and u7) then
                                                        u85 = false;
                                                    end;

                                                    v250 = script_TacticsRules.MOVE_MODE[u83];

                                                    if v250 and (not u85 and u89 <= v195) then
                                                        if u83 == "CoverReload" then
                                                            v251 = u10:FindFirstChild("Ammo");

                                                            if v251 then
                                                                v251 = v251:FindFirstChild("MagAmmo");
                                                            end;

                                                            v252 = v251 and (v251.MaxValue > 0 and v251.Value / v251.MaxValue) or 1;
                                                            v253 = getPersona();

                                                            if v252 <= (v253 and v253.reloadCoverFrac or script_TacticsRules.RELOAD_COVER_FRACTION) then
                                                                if not (u30.IsReloading() and (u83 ~= "Flee" and u83 ~= "Retreat")) then
                                                                    u89 = v195 + 1;

                                                                    if Value then
                                                                        v254 = Value:FindFirstChild("HumanoidRootPart");
                                                                    else
                                                                        v254 = Value;
                                                                    end;

                                                                    if v254 then
                                                                        if u53 and not u7 then
                                                                            if u53 then
                                                                                v255 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                            else
                                                                                v255 = u68;
                                                                            end;
                                                                        else
                                                                            v255 = v254.Position;
                                                                        end;
                                                                    else
                                                                        v255 = nil;
                                                                    end;

                                                                    if v255 == nil then
                                                                        v256 = false;
                                                                    else
                                                                        v256 = u83 ~= "Flank" and true or script_SquadBoard.TryFlank(u5, Value, v195);
                                                                    end;

                                                                    if v256 then
                                                                        v257 = script_CoverFinder.Find({
                                                                            from = HumanoidRootPart.Position,
                                                                            threat = v255,
                                                                            mode = v250,
                                                                            exclude = { u5, Value, workspace.PlayerCharacters },
                                                                            preferredDist = (u26.IdealMinRange + u26.IdealMaxRange) / 2,
                                                                            tooClose = u26.TooCloseRange,

                                                                            isClaimed = function(p263) -- Line: 1409, Name: isClaimed
                                                                                -- upvalues: script_SquadBoard (ref), u5 (ref)
                                                                                return script_SquadBoard.IsClaimed(p263, u5);
                                                                            end,

                                                                            isCrowded = u26.IsCrowded
                                                                        });
                                                                    else
                                                                        v257 = nil;
                                                                    end;

                                                                    if not v257 and (v255 and (u83 == "Retreat" or u83 == "Flee")) then
                                                                        v257 = u26.ClearSpotAway(v255, u83 == "Flee" and 40 or 20);
                                                                    end;

                                                                    if v257 then
                                                                        script_SquadBoard.ClaimCover(u5, v257);
                                                                        u87 = v257;
                                                                        u30.StopAiming();

                                                                        if u75 ~= 0 then
                                                                            u75 = 0;

                                                                            if u27 then
                                                                                u27.SetLean(0);
                                                                            end;
                                                                        end;

                                                                        u26.SprintTo(v257, v200.SprintSpeed);
                                                                        script_SquadBoard.StopCovering(u5);
                                                                        endSuppressive("moving");

                                                                        if u58 then
                                                                            script_SquadBoard.Announce(u5, u83, Value, v195, 4);
                                                                        end;

                                                                        script_NpcRadioChatter.Event(u5, string.lower(u83), Value, {
                                                                            spot = v257
                                                                        });
                                                                        v258 = u83 == "Flee" and "fleeing" or "moving";

                                                                        if u66 ~= v258 then
                                                                            u66 = v258;

                                                                            if u4 then
                                                                                u5:SetAttribute("CombatState", v258);
                                                                            end;
                                                                        end;
                                                                    else
                                                                        u89 = v195 + 3;

                                                                        if u83 == "Flank" then
                                                                            script_SquadBoard.ReleaseFlank(u5);
                                                                            u92 = v195;
                                                                        end;

                                                                        if u83 == "CoverReload" and (not u30.IsReloading() and WeaponState == "ready") then
                                                                            if u66 ~= "reloading" then
                                                                                u66 = "reloading";

                                                                                if u4 then
                                                                                    u5:SetAttribute("CombatState", "reloading");
                                                                                end;
                                                                            end;

                                                                            u30.StopAiming(true);
                                                                            task.spawn(function() -- Line: 1438
                                                                                -- upvalues: u30 (ref)
                                                                                u30.PerformReload();
                                                                            end);
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        elseif not (u30.IsReloading() and (u83 ~= "Flee" and u83 ~= "Retreat")) then
                                                            u89 = v195 + 1;

                                                            if Value then
                                                                v254 = Value:FindFirstChild("HumanoidRootPart");
                                                            else
                                                                v254 = Value;
                                                            end;

                                                            if v254 then
                                                                if u53 and not u7 then
                                                                    if u53 then
                                                                        v255 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                    else
                                                                        v255 = u68;
                                                                    end;
                                                                else
                                                                    v255 = v254.Position;
                                                                end;
                                                            else
                                                                v255 = nil;
                                                            end;

                                                            if v255 == nil then
                                                                v256 = false;
                                                            else
                                                                v256 = u83 ~= "Flank" and true or script_SquadBoard.TryFlank(u5, Value, v195);
                                                            end;

                                                            if v256 then
                                                                v257 = script_CoverFinder.Find({
                                                                    from = HumanoidRootPart.Position,
                                                                    threat = v255,
                                                                    mode = v250,
                                                                    exclude = { u5, Value, workspace.PlayerCharacters },
                                                                    preferredDist = (u26.IdealMinRange + u26.IdealMaxRange) / 2,
                                                                    tooClose = u26.TooCloseRange,

                                                                    isClaimed = function(p263) -- Line: 1409, Name: isClaimed
                                                                        -- upvalues: script_SquadBoard (ref), u5 (ref)
                                                                        return script_SquadBoard.IsClaimed(p263, u5);
                                                                    end,

                                                                    isCrowded = u26.IsCrowded
                                                                });
                                                            else
                                                                v257 = nil;
                                                            end;

                                                            if not v257 and (v255 and (u83 == "Retreat" or u83 == "Flee")) then
                                                                v257 = u26.ClearSpotAway(v255, u83 == "Flee" and 40 or 20);
                                                            end;

                                                            if v257 then
                                                                script_SquadBoard.ClaimCover(u5, v257);
                                                                u87 = v257;
                                                                u30.StopAiming();

                                                                if u75 ~= 0 then
                                                                    u75 = 0;

                                                                    if u27 then
                                                                        u27.SetLean(0);
                                                                    end;
                                                                end;

                                                                u26.SprintTo(v257, v200.SprintSpeed);
                                                                script_SquadBoard.StopCovering(u5);
                                                                endSuppressive("moving");

                                                                if u58 then
                                                                    script_SquadBoard.Announce(u5, u83, Value, v195, 4);
                                                                end;

                                                                script_NpcRadioChatter.Event(u5, string.lower(u83), Value, {
                                                                    spot = v257
                                                                });
                                                                v258 = u83 == "Flee" and "fleeing" or "moving";

                                                                if u66 ~= v258 then
                                                                    u66 = v258;

                                                                    if u4 then
                                                                        u5:SetAttribute("CombatState", v258);
                                                                    end;
                                                                end;
                                                            else
                                                                u89 = v195 + 3;

                                                                if u83 == "Flank" then
                                                                    script_SquadBoard.ReleaseFlank(u5);
                                                                    u92 = v195;
                                                                end;

                                                                if u83 == "CoverReload" and (not u30.IsReloading() and WeaponState == "ready") then
                                                                    if u66 ~= "reloading" then
                                                                        u66 = "reloading";

                                                                        if u4 then
                                                                            u5:SetAttribute("CombatState", "reloading");
                                                                        end;
                                                                    end;

                                                                    u30.StopAiming(true);
                                                                    task.spawn(function() -- Line: 1438
                                                                        -- upvalues: u30 (ref)
                                                                        u30.PerformReload();
                                                                    end);
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;

                                                if u66 == "moving" or u66 == "fleeing" then
                                                    v259 = u5:GetAttribute("_LastHitAt");

                                                    if u66 == "fleeing" and (type(v259) == "number" and (v195 - v259 < 0.5 and DistToTarget < 15)) then
                                                        u91 = true;
                                                    end;

                                                    v260 = u26.SprintStatus();

                                                    if v260 == "moving" and (u66 ~= "fleeing" or not u91) then
                                                        if not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                                                            AlignOrientation.Enabled = false;
                                                            Humanoid.AutoRotate = true;
                                                        end;
                                                    else
                                                        u26.StopSprint();
                                                        script_SquadBoard.EndMove(u5);

                                                        if u132 then
                                                            u132:Moved(v195);
                                                        end;

                                                        if v260 == "arrived" then
                                                            u88 = u87;
                                                            os_clock_ret2 = v195;
                                                            u80 = 0;
                                                            u85 = true;

                                                            if u83 == "Retreat" then
                                                                u90 = true;
                                                            end;

                                                            if u83 == "Flank" then
                                                                script_SquadBoard.ReleaseFlank(u5);
                                                                u92 = v195;
                                                            end;
                                                        else
                                                            script_SquadBoard.ReleaseCover(u5);
                                                            u89 = v195 + 3;

                                                            if u83 == "Flank" then
                                                                script_SquadBoard.ReleaseFlank(u5);
                                                                u92 = v195;
                                                            end;
                                                        end;

                                                        u87 = nil;
                                                        v261 = u30.IsReloading() and "reloading" or "idle";

                                                        if u66 ~= v261 then
                                                            u66 = v261;

                                                            if u4 then
                                                                u5:SetAttribute("CombatState", v261);
                                                            end;
                                                        end;

                                                        if u83 ~= "Flee" or u91 then
                                                            goto l2;
                                                        end;
                                                    end;
                                                elseif u83 == "Flee" and not u91 then
                                                    v262 = u5:GetAttribute("_LastHitAt");

                                                    if type(v262) == "number" and (v195 - v262 < 0.5 and DistToTarget < 15) then
                                                        u91 = true;
                                                        goto l2;
                                                    end;

                                                    u30.StopAiming();

                                                    if not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                                                        AlignOrientation.Enabled = false;
                                                        Humanoid.AutoRotate = true;
                                                    end;

                                                    u26.StopMoving();

                                                    if u66 ~= "idle" then
                                                        u66 = "idle";

                                                        if u4 then
                                                            u5:SetAttribute("CombatState", "idle");
                                                        end;
                                                    end;
                                                else
                                                    local v264;

                                                    if u88 == nil then
                                                        v264 = false;
                                                    else
                                                        v264 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                                                    end;

                                                    local v265, v266, v267, v268, v269, v270, v271, v272, v273, v274, v275, v276, v277, v278, v279, v280, v281, v282, v283, v284, v285, v286, v287, v288, v289, v290, v291, v292, v293, v294, v295, v296;

                                                    if v264 and (u66 ~= "reloading" and (not u30.IsReloading() and WeaponState == "ready")) then
                                                        local Ammo = u10:FindFirstChild("Ammo");

                                                        if Ammo then
                                                            Ammo = Ammo:FindFirstChild("MagAmmo");
                                                        end;

                                                        if Ammo and Ammo.MaxValue > 0 then
                                                            local v297 = Ammo.Value / Ammo.MaxValue;
                                                            local v298 = getPersona();

                                                            if v297 <= (v298 and v298.reloadCoverFrac or script_TacticsRules.RELOAD_COVER_FRACTION) then
                                                                if u66 ~= "reloading" then
                                                                    u66 = "reloading";

                                                                    if u4 then
                                                                        u5:SetAttribute("CombatState", "reloading");
                                                                    end;
                                                                end;

                                                                u30.StopAiming(true);
                                                                task.spawn(function() -- Line: 1509
                                                                    -- upvalues: u30 (ref)
                                                                    u30.PerformReload();
                                                                end);
                                                            elseif u66 == "reloading" then
                                                                if not (u30.IsReloading() or u30.IsChamberingBolt()) then
                                                                    u30.StopAiming();

                                                                    if u66 ~= "idle" then
                                                                        u66 = "idle";

                                                                        if u4 then
                                                                            u5:SetAttribute("CombatState", "idle");
                                                                        end;
                                                                    end;
                                                                end;

                                                                if u7 then
                                                                    v265 = u30.UpdateFacing;

                                                                    if Value then
                                                                        v266 = Value:FindFirstChild("HumanoidRootPart");
                                                                    else
                                                                        v266 = Value;
                                                                    end;

                                                                    if v266 then
                                                                        if u53 and not u7 then
                                                                            if u53 then
                                                                                v267 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                            else
                                                                                v267 = u68;
                                                                            end;
                                                                        else
                                                                            v267 = v266.Position;
                                                                        end;
                                                                    else
                                                                        v267 = nil;
                                                                    end;

                                                                    v265(v267);
                                                                elseif not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                                                                    AlignOrientation.Enabled = false;
                                                                    Humanoid.AutoRotate = true;
                                                                end;

                                                                if Value then
                                                                    v268 = Value:FindFirstChild("HumanoidRootPart");
                                                                else
                                                                    v268 = Value;
                                                                end;

                                                                if v268 then
                                                                    if u53 and not u7 then
                                                                        if u53 then
                                                                            v269 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                        else
                                                                            v269 = u68;
                                                                        end;
                                                                    else
                                                                        v269 = v268.Position;
                                                                    end;
                                                                else
                                                                    v269 = nil;
                                                                end;

                                                                if v269 and DistToTarget < (u5:GetAttribute("Stance") == "Crouch" and u26.TooCloseRange or u26.IdealMinRange) then
                                                                    u26.Retreat(v269);
                                                                end;
                                                            elseif WeaponState == "needsReload" and not u30.IsReloading() then
                                                                if u66 ~= "reloading" then
                                                                    u66 = "reloading";

                                                                    if u4 then
                                                                        u5:SetAttribute("CombatState", "reloading");
                                                                    end;
                                                                end;

                                                                u30.StopAiming(true);
                                                                task.spawn(function() -- Line: 1536
                                                                    -- upvalues: u30 (ref)
                                                                    u30.PerformReload();
                                                                end);
                                                            elseif WeaponState == "needsChamber" and not u30.IsChamberingBolt() then
                                                                if u66 ~= "reloading" then
                                                                    u66 = "reloading";

                                                                    if u4 then
                                                                        u5:SetAttribute("CombatState", "reloading");
                                                                    end;
                                                                end;

                                                                task.spawn(function() -- Line: 1542
                                                                    -- upvalues: u30 (ref)
                                                                    u30.PerformChamber();
                                                                end);
                                                            else
                                                                if u55 then
                                                                    if u88 == nil then
                                                                        v270 = false;
                                                                    else
                                                                        v270 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                                                                    end;

                                                                    if v270 then
                                                                        v271 = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;

                                                                        if script_NpcSuppression.HEAVY_TIER <= v271 then
                                                                            v272 = true;
                                                                        elseif v271 == script_NpcSuppression.MEDIUM_TIER then
                                                                            v272 = script_NpcSuppression.Hesitating(u5, os.clock());
                                                                        else
                                                                            v272 = false;
                                                                        end;
                                                                    else
                                                                        v272 = false;
                                                                    end;
                                                                else
                                                                    v272 = false;
                                                                end;

                                                                if v272 then
                                                                    v272 = u26.TooCloseRange <= DistToTarget;
                                                                end;

                                                                if v272 ~= u106 then
                                                                    u106 = v272;

                                                                    if v272 then
                                                                        script_NpcSuppression.Count("stayedDown");
                                                                    end;
                                                                end;

                                                                if v272 then
                                                                    if u66 == "aiming" or u66 == "firing" then
                                                                        u30.StopAiming();
                                                                    end;

                                                                    if u75 ~= 0 then
                                                                        u75 = 0;

                                                                        if u27 then
                                                                            u27.SetLean(0);
                                                                        end;
                                                                    end;

                                                                    u26.StopMoving();

                                                                    if u66 ~= "idle" then
                                                                        u66 = "idle";

                                                                        if u4 then
                                                                            u5:SetAttribute("CombatState", "idle");
                                                                        end;
                                                                    end;
                                                                else
                                                                    if not u59 or v162 then
                                                                        goto l1;
                                                                    end;

                                                                    v273 = os.clock();
                                                                    v274 = script_NpcKnowledge.Get(u5, Value, v273);

                                                                    if u7 then
                                                                        endSuppressive("reacquired");
                                                                        goto l1;
                                                                    end;

                                                                    if not u98 then
                                                                        if v274 and (v274.knownAt and (not v274.visible and script_NpcSuppressFire.MayDecide(u99, u100, v274.knownAt, v273))) then
                                                                            u99 = v274.knownAt;
                                                                            u100 = v273;
                                                                            v275 = getPersona();
                                                                            v276, v277 = script_NpcSuppressFire.Source(v274, v273);
                                                                            v278 = u58 and script_SquadBoard.Covering(u5, v273) ~= nil;

                                                                            if v276 then
                                                                                if u30.IsReloading() then
                                                                                    if script_NpcSuppressFire.trace then
                                                                                        script_NpcSuppressFire.trace(u5, "refused", "busy");
                                                                                    end;
                                                                                else
                                                                                    v279 = u10:FindFirstChild("Ammo");

                                                                                    if v279 then
                                                                                        v279 = v279:FindFirstChild("MagAmmo");
                                                                                    end;

                                                                                    if (v279 and (v279.MaxValue > 0 and v279.Value / v279.MaxValue) or 1) <= 0 or (u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) >= script_NpcSuppression.HEAVY_TIER then
                                                                                        if script_NpcSuppressFire.trace then
                                                                                            script_NpcSuppressFire.trace(u5, "refused", "busy");
                                                                                        end;
                                                                                    elseif math.random() >= script_NpcSuppressFire.Chance(v275, v273 - v274.knownAt, v278) then
                                                                                        v280 = script_NpcSuppressFire.stats;
                                                                                        v280.refusedRoll = v280.refusedRoll + 1;
                                                                                    elseif script_SquadBoard.TrySuppress(u5, Value, v273, v273 + script_NpcSuppressFire.MAX_TIME_CAP) then
                                                                                        RaycastParams_new_ret2.FilterDescendantsInstances = { u5, workspace.PlayerCharacters };
                                                                                        v281 = script_NpcSuppressFire.PickPoint(u5.Head.Position, v274.knownPos, function(p299, p300) -- Line: 1607
                                                                                            -- upvalues: NpcSight (ref), RaycastParams_new_ret2 (ref)
                                                                                            return NpcSight.Cast(p299, p300 - p299, RaycastParams_new_ret2) == nil;
                                                                                        end);

                                                                                        if v281 then
                                                                                            v282 = {
                                                                                                bursts = 0,
                                                                                                shots = 0,
                                                                                                start = v273,
                                                                                                point = v281,
                                                                                                burst0 = u30.BurstsFired(),
                                                                                                maxBursts = v275 and v275.suppressBursts or script_NpcSuppressFire.DEFAULT_BURSTS
                                                                                            };
                                                                                            v283 = script_NpcSuppressFire.MaxShots;

                                                                                            if v275 then
                                                                                                v284 = v275.suppressBursts;
                                                                                            else
                                                                                                v284 = v275;
                                                                                            end;

                                                                                            v282.maxShots = v283(v284);
                                                                                            v282.maxTime = math.min(script_NpcSuppressFire.MAX_TIME * (v275 and v275.suppressTimeMult or 1), script_NpcSuppressFire.MAX_TIME_CAP);
                                                                                            v282.fireAt = v273 + (script_NpcSuppressFire.DELAY[u5:GetAttribute("Rank") or ""] or script_NpcSuppressFire.DEFAULT_DELAY);
                                                                                            v282.source = v277;
                                                                                            v282.covering = v278;
                                                                                            u98 = v282;
                                                                                            v285 = script_NpcSuppressFire.stats;
                                                                                            v285.episodes = v285.episodes + 1;
                                                                                            script_NpcTelemetry.Bump("supfire.start");
                                                                                            script_NpcRadioChatter.Event(u5, "supfire", Value);

                                                                                            if script_NpcSuppressFire.trace then
                                                                                                script_NpcSuppressFire.trace(u5, "start", u98);
                                                                                            end;

                                                                                            if u4 then
                                                                                                u5:SetAttribute("Suppressing", v277);
                                                                                            end;
                                                                                        else
                                                                                            script_SquadBoard.ReleaseSuppress(u5);
                                                                                            v286 = script_NpcSuppressFire.stats;
                                                                                            v286.refusedPoint = v286.refusedPoint + 1;

                                                                                            if script_NpcSuppressFire.trace then
                                                                                                script_NpcSuppressFire.trace(u5, "refused", "nopoint");
                                                                                            end;
                                                                                        end;
                                                                                    else
                                                                                        v287 = script_NpcSuppressFire.stats;
                                                                                        v287.refusedSlot = v287.refusedSlot + 1;
                                                                                    end;
                                                                                end;
                                                                            else
                                                                                v288 = script_NpcSuppressFire.stats;
                                                                                v288.refusedSource = v288.refusedSource + 1;

                                                                                if script_NpcSuppressFire.trace then
                                                                                    script_NpcSuppressFire.trace(u5, "refused", v277);
                                                                                end;
                                                                            end;
                                                                        end;

                                                                        goto l1;
                                                                    end;

                                                                    v289 = script_NpcSuppressFire.ShouldStop;
                                                                    v290 = u98;
                                                                    v291 = {
                                                                        hasLOS = false,
                                                                        moving = false,
                                                                        now = v273
                                                                    };

                                                                    if v274 and v274.knownAt then
                                                                        v292 = v273 - v274.knownAt or nil;
                                                                    else
                                                                        v292 = nil;
                                                                    end;

                                                                    v291.age = v292;
                                                                    v291.tier = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;
                                                                    v291.reloading = u30.IsReloading();
                                                                    v293 = u10:FindFirstChild("Ammo");

                                                                    if v293 then
                                                                        v293 = v293:FindFirstChild("MagAmmo");
                                                                    end;

                                                                    v291.magEmpty = (v293 and (v293.MaxValue > 0 and v293.Value / v293.MaxValue) or 1) <= 0;
                                                                    v291.tactic = u83;
                                                                    v294 = v289(v290, v291);

                                                                    if v294 then
                                                                        endSuppressive(v294);
                                                                        goto l1;
                                                                    end;

                                                                    u98.bursts = u30.BurstsFired() - u98.burst0;
                                                                    u26.StopMoving();
                                                                    u30.FaceAt(u98.point);

                                                                    if u98.fireAt <= v273 and u30.ShootAt(u98.point, script_NpcSuppressFire.SPREAD_MULT) then
                                                                        v295 = u98;
                                                                        v295.shots = v295.shots + 1;
                                                                        v296 = script_NpcSuppressFire.stats;
                                                                        v296.shots = v296.shots + 1;
                                                                        script_NpcTelemetry.Bump("supfire.round");

                                                                        if script_NpcSuppressFire.trace then
                                                                            script_NpcSuppressFire.trace(u5, "shot", u98.point);
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        elseif u66 == "reloading" then
                                                            if not (u30.IsReloading() or u30.IsChamberingBolt()) then
                                                                u30.StopAiming();

                                                                if u66 ~= "idle" then
                                                                    u66 = "idle";

                                                                    if u4 then
                                                                        u5:SetAttribute("CombatState", "idle");
                                                                    end;
                                                                end;
                                                            end;

                                                            if u7 then
                                                                v265 = u30.UpdateFacing;

                                                                if Value then
                                                                    v266 = Value:FindFirstChild("HumanoidRootPart");
                                                                else
                                                                    v266 = Value;
                                                                end;

                                                                if v266 then
                                                                    if u53 and not u7 then
                                                                        if u53 then
                                                                            v267 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                        else
                                                                            v267 = u68;
                                                                        end;
                                                                    else
                                                                        v267 = v266.Position;
                                                                    end;
                                                                else
                                                                    v267 = nil;
                                                                end;

                                                                v265(v267);
                                                            elseif not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                                                                AlignOrientation.Enabled = false;
                                                                Humanoid.AutoRotate = true;
                                                            end;

                                                            if Value then
                                                                v268 = Value:FindFirstChild("HumanoidRootPart");
                                                            else
                                                                v268 = Value;
                                                            end;

                                                            if v268 then
                                                                if u53 and not u7 then
                                                                    if u53 then
                                                                        v269 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                    else
                                                                        v269 = u68;
                                                                    end;
                                                                else
                                                                    v269 = v268.Position;
                                                                end;
                                                            else
                                                                v269 = nil;
                                                            end;

                                                            if v269 and DistToTarget < (u5:GetAttribute("Stance") == "Crouch" and u26.TooCloseRange or u26.IdealMinRange) then
                                                                u26.Retreat(v269);
                                                            end;
                                                        elseif WeaponState == "needsReload" and not u30.IsReloading() then
                                                            if u66 ~= "reloading" then
                                                                u66 = "reloading";

                                                                if u4 then
                                                                    u5:SetAttribute("CombatState", "reloading");
                                                                end;
                                                            end;

                                                            u30.StopAiming(true);
                                                            task.spawn(function() -- Line: 1536
                                                                -- upvalues: u30 (ref)
                                                                u30.PerformReload();
                                                            end);
                                                        elseif WeaponState == "needsChamber" and not u30.IsChamberingBolt() then
                                                            if u66 ~= "reloading" then
                                                                u66 = "reloading";

                                                                if u4 then
                                                                    u5:SetAttribute("CombatState", "reloading");
                                                                end;
                                                            end;

                                                            task.spawn(function() -- Line: 1542
                                                                -- upvalues: u30 (ref)
                                                                u30.PerformChamber();
                                                            end);
                                                        else
                                                            if u55 then
                                                                if u88 == nil then
                                                                    v270 = false;
                                                                else
                                                                    v270 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                                                                end;

                                                                if v270 then
                                                                    v271 = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;

                                                                    if script_NpcSuppression.HEAVY_TIER <= v271 then
                                                                        v272 = true;
                                                                    elseif v271 == script_NpcSuppression.MEDIUM_TIER then
                                                                        v272 = script_NpcSuppression.Hesitating(u5, os.clock());
                                                                    else
                                                                        v272 = false;
                                                                    end;
                                                                else
                                                                    v272 = false;
                                                                end;
                                                            else
                                                                v272 = false;
                                                            end;

                                                            if v272 then
                                                                v272 = u26.TooCloseRange <= DistToTarget;
                                                            end;

                                                            if v272 ~= u106 then
                                                                u106 = v272;

                                                                if v272 then
                                                                    script_NpcSuppression.Count("stayedDown");
                                                                end;
                                                            end;

                                                            if v272 then
                                                                if u66 == "aiming" or u66 == "firing" then
                                                                    u30.StopAiming();
                                                                end;

                                                                if u75 ~= 0 then
                                                                    u75 = 0;

                                                                    if u27 then
                                                                        u27.SetLean(0);
                                                                    end;
                                                                end;

                                                                u26.StopMoving();

                                                                if u66 ~= "idle" then
                                                                    u66 = "idle";

                                                                    if u4 then
                                                                        u5:SetAttribute("CombatState", "idle");
                                                                    end;
                                                                end;
                                                            else
                                                                if not u59 or v162 then
                                                                    goto l1;
                                                                end;

                                                                v273 = os.clock();
                                                                v274 = script_NpcKnowledge.Get(u5, Value, v273);

                                                                if u7 then
                                                                    endSuppressive("reacquired");

                                                                    if u66 == "aiming" then
                                                                        if not (u30.IsAiming() or (u30.HasAimed() or u66 == "idle")) then
                                                                            u66 = "idle";

                                                                            if u4 then
                                                                                u5:SetAttribute("CombatState", "idle");
                                                                            end;
                                                                        end;

                                                                        if u30.HasAimed() and u66 ~= "firing" then
                                                                            u66 = "firing";

                                                                            if u4 then
                                                                                u5:SetAttribute("CombatState", "firing");
                                                                            end;
                                                                        end;
                                                                    elseif u66 == "firing" then
                                                                        if u7 then
                                                                            if DistToTarget < u26.TooCloseRange then
                                                                                if u66 ~= "retreating" then
                                                                                    u66 = "retreating";

                                                                                    if u4 then
                                                                                        u5:SetAttribute("CombatState", "retreating");
                                                                                    end;
                                                                                end;

                                                                                u30.StopAiming(true);
                                                                            elseif u26.IdealMaxRange * (u5:GetAttribute("Stance") == "Crouch" and 1.5 or 1.15) < DistToTarget then
                                                                                if u66 ~= "pathing" then
                                                                                    u66 = "pathing";

                                                                                    if u4 then
                                                                                        u5:SetAttribute("CombatState", "pathing");
                                                                                    end;
                                                                                end;

                                                                                u30.StopAiming();
                                                                            else
                                                                                u30.ShootGun();

                                                                                if npcConfig.CanStrafe and (u5:GetAttribute("Stance") ~= "Crouch" and u75 == 0) then
                                                                                    u67 = u67 + 0.1;

                                                                                    if u67 >= npcConfig.StrafeInterval then
                                                                                        local v301;

                                                                                        if u88 == nil then
                                                                                            v301 = false;
                                                                                        else
                                                                                            v301 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                                                                                        end;

                                                                                        if not v301 then
                                                                                            u67 = 0;
                                                                                            u26.Strafe();
                                                                                        end;
                                                                                    end;
                                                                                end;
                                                                            end;
                                                                        else
                                                                            if u66 ~= "pathing" then
                                                                                u66 = "pathing";

                                                                                if u4 then
                                                                                    u5:SetAttribute("CombatState", "pathing");
                                                                                end;
                                                                            end;

                                                                            u30.StopAiming();
                                                                        end;
                                                                    else
                                                                        if DistToTarget < u26.TooCloseRange and (u7 or not u56) then
                                                                            if u66 ~= "retreating" then
                                                                                u66 = "retreating";

                                                                                if u4 then
                                                                                    u5:SetAttribute("CombatState", "retreating");
                                                                                end;
                                                                            end;
                                                                        elseif u7 and u26.IdealMaxRange * (u5:GetAttribute("Stance") == "Crouch" and 1.5 or 1) >= DistToTarget then
                                                                            if u7 and DistToTarget <= u26.IdealMaxRange * (u5:GetAttribute("Stance") == "Crouch" and 1.5 or 1) then
                                                                                if u66 ~= "aiming" then
                                                                                    u66 = "aiming";

                                                                                    if u4 then
                                                                                        u5:SetAttribute("CombatState", "aiming");
                                                                                    end;
                                                                                end;

                                                                                task.spawn(function() -- Line: 1697
                                                                                    -- upvalues: u30 (ref)
                                                                                    u30.Aim();
                                                                                end);
                                                                            end;
                                                                        else
                                                                            if u66 ~= "pathing" then
                                                                                u66 = "pathing";

                                                                                if u4 then
                                                                                    u5:SetAttribute("CombatState", "pathing");
                                                                                end;
                                                                            end;

                                                                            if npcConfig.CanShootWhileMoving and u7 then
                                                                                local v302;

                                                                                if Value then
                                                                                    v302 = Value:FindFirstChild("HumanoidRootPart");
                                                                                else
                                                                                    v302 = Value;
                                                                                end;

                                                                                local v303;

                                                                                if v302 then
                                                                                    if u53 and not u7 then
                                                                                        if u53 then
                                                                                            v303 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                                        else
                                                                                            v303 = u68;
                                                                                        end;
                                                                                    else
                                                                                        v303 = v302.Position;
                                                                                    end;
                                                                                else
                                                                                    v303 = nil;
                                                                                end;

                                                                                u30.UpdateFacing(v303);
                                                                                AlignOrientation.Enabled = true;
                                                                                Humanoid.AutoRotate = false;
                                                                            end;
                                                                        end;

                                                                        if u66 == "retreating" then
                                                                            if u56 and not u7 then
                                                                                if u66 ~= "idle" then
                                                                                    u66 = "idle";

                                                                                    if u4 then
                                                                                        u5:SetAttribute("CombatState", "idle");
                                                                                    end;
                                                                                end;
                                                                            else
                                                                                local v304;

                                                                                if Value then
                                                                                    v304 = Value:FindFirstChild("HumanoidRootPart");
                                                                                else
                                                                                    v304 = Value;
                                                                                end;

                                                                                local v305;

                                                                                if v304 then
                                                                                    if u53 and not u7 then
                                                                                        if u53 then
                                                                                            v305 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                                        else
                                                                                            v305 = u68;
                                                                                        end;
                                                                                    else
                                                                                        v305 = v304.Position;
                                                                                    end;
                                                                                else
                                                                                    v305 = nil;
                                                                                end;

                                                                                if v305 then
                                                                                    u26.Retreat(v305);
                                                                                end;

                                                                                if u26.TooCloseRange <= DistToTarget and u66 ~= "idle" then
                                                                                    u66 = "idle";

                                                                                    if u4 then
                                                                                        u5:SetAttribute("CombatState", "idle");
                                                                                    end;
                                                                                end;

                                                                                if u7 then
                                                                                    if npcConfig.CanShootWhileMoving then
                                                                                        local v306;

                                                                                        if Value then
                                                                                            v306 = Value:FindFirstChild("HumanoidRootPart");
                                                                                        else
                                                                                            v306 = Value;
                                                                                        end;

                                                                                        local v307;

                                                                                        if v306 then
                                                                                            if u53 and not u7 then
                                                                                                if u53 then
                                                                                                    v307 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                                                else
                                                                                                    v307 = u68;
                                                                                                end;
                                                                                            else
                                                                                                v307 = v306.Position;
                                                                                            end;
                                                                                        else
                                                                                            v307 = nil;
                                                                                        end;

                                                                                        u30.UpdateFacing(v307);
                                                                                        AlignOrientation.Enabled = true;
                                                                                        Humanoid.AutoRotate = false;
                                                                                        u30.ShootGunWhileMoving();
                                                                                    end;
                                                                                elseif not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                                                                                    AlignOrientation.Enabled = false;
                                                                                    Humanoid.AutoRotate = true;
                                                                                end;
                                                                            end;
                                                                        elseif u66 == "pathing" then
                                                                            if u7 and (DistToTarget <= u26.IdealMaxRange and u26.TooCloseRange <= DistToTarget) then
                                                                                u26.StopMoving();

                                                                                if u66 ~= "idle" then
                                                                                    u66 = "idle";

                                                                                    if u4 then
                                                                                        u5:SetAttribute("CombatState", "idle");
                                                                                    end;
                                                                                end;

                                                                                if Value:FindFirstChild("HumanoidRootPart") and (npcConfig.CanShootWhileMoving and u7) then
                                                                                    local UpdateFacing = u30.UpdateFacing;
                                                                                    local v308;

                                                                                    if Value then
                                                                                        v308 = Value:FindFirstChild("HumanoidRootPart");
                                                                                    else
                                                                                        v308 = Value;
                                                                                    end;

                                                                                    local v309;

                                                                                    if v308 then
                                                                                        if u53 and not u7 then
                                                                                            if u53 then
                                                                                                v309 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                                            else
                                                                                                v309 = u68;
                                                                                            end;
                                                                                        else
                                                                                            v309 = v308.Position;
                                                                                        end;
                                                                                    else
                                                                                        v309 = nil;
                                                                                    end;

                                                                                    UpdateFacing(v309);
                                                                                    u30.ShootGunWhileMoving();
                                                                                end;
                                                                            else
                                                                                if (u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) >= script_NpcSuppression.HEAVY_TIER then
                                                                                    u26.StopMoving();
                                                                                    script_NpcSuppression.Count("searchHeldTicks");
                                                                                    goto l0;
                                                                                end;

                                                                                if not (u7 or (not u56 or u132)) then
                                                                                    u26.StopMoving();
                                                                                    local v310;

                                                                                    if u53 then
                                                                                        v310 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                                    else
                                                                                        v310 = u68;
                                                                                    end;

                                                                                    if v310 then
                                                                                        u30.UpdateFacing(v310);
                                                                                        AlignOrientation.Enabled = true;
                                                                                        Humanoid.AutoRotate = false;
                                                                                    end;

                                                                                    goto l0;
                                                                                end;

                                                                                if u7 or not (u56 and u132) then
                                                                                    if u7 then
                                                                                        local WalkTo = u26.WalkTo;
                                                                                        local v311;

                                                                                        if Value then
                                                                                            v311 = Value:FindFirstChild("HumanoidRootPart");
                                                                                        else
                                                                                            v311 = Value;
                                                                                        end;

                                                                                        local v312;

                                                                                        if v311 then
                                                                                            if u53 and not u7 then
                                                                                                if u53 then
                                                                                                    v312 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                                                else
                                                                                                    v312 = u68;
                                                                                                end;
                                                                                            else
                                                                                                v312 = v311.Position;
                                                                                            end;
                                                                                        else
                                                                                            v312 = nil;
                                                                                        end;

                                                                                        WalkTo(v312, true);
                                                                                    else
                                                                                        if not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                                                                                            AlignOrientation.Enabled = false;
                                                                                            Humanoid.AutoRotate = true;
                                                                                        end;

                                                                                        local v313;

                                                                                        if u53 then
                                                                                            v313 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                                        else
                                                                                            v313 = u68;
                                                                                        end;

                                                                                        if v313 then
                                                                                            v313 = v313 + u82;
                                                                                        end;

                                                                                        local v314;

                                                                                        if u88 == nil then
                                                                                            v314 = false;
                                                                                        else
                                                                                            v314 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                                                                                        end;

                                                                                        if v314 and tick() - u6 < 5 then
                                                                                            u26.StopMoving();
                                                                                        elseif v313 and (HumanoidRootPart.Position - v313).Magnitude > 5 then
                                                                                            u26.WalkTo(v313, true);
                                                                                        else
                                                                                            u26.StopMoving();
                                                                                        end;
                                                                                    end;

                                                                                    goto l0;
                                                                                end;

                                                                                local os_clock_ret3 = os.clock();
                                                                                u132:Tick(os_clock_ret3, (estimateOf(Value, os_clock_ret3)));

                                                                                if not u132 or u132.phase ~= "done" then
                                                                                    goto l0;
                                                                                end;
                                                                            end;
                                                                        elseif u66 == "firing" or u66 == "aiming" then
                                                                            if u26.IdealMaxRange < DistToTarget then
                                                                                local WalkTo = u26.WalkTo;
                                                                                local v315;

                                                                                if Value then
                                                                                    v315 = Value:FindFirstChild("HumanoidRootPart");
                                                                                else
                                                                                    v315 = Value;
                                                                                end;

                                                                                local v316;

                                                                                if v315 then
                                                                                    if u53 and not u7 then
                                                                                        if u53 then
                                                                                            v316 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                                        else
                                                                                            v316 = u68;
                                                                                        end;
                                                                                    else
                                                                                        v316 = v315.Position;
                                                                                    end;
                                                                                else
                                                                                    v316 = nil;
                                                                                end;

                                                                                WalkTo(v316, true);
                                                                            else
                                                                                u26.StopMoving();
                                                                            end;
                                                                        end;
                                                                    end;
                                                                else
                                                                    if not u98 then
                                                                        if v274 and (v274.knownAt and (not v274.visible and script_NpcSuppressFire.MayDecide(u99, u100, v274.knownAt, v273))) then
                                                                            u99 = v274.knownAt;
                                                                            u100 = v273;
                                                                            v275 = getPersona();
                                                                            v276, v277 = script_NpcSuppressFire.Source(v274, v273);
                                                                            v278 = u58 and script_SquadBoard.Covering(u5, v273) ~= nil;

                                                                            if v276 then
                                                                                if u30.IsReloading() then
                                                                                    if script_NpcSuppressFire.trace then
                                                                                        script_NpcSuppressFire.trace(u5, "refused", "busy");
                                                                                    end;
                                                                                else
                                                                                    v279 = u10:FindFirstChild("Ammo");

                                                                                    if v279 then
                                                                                        v279 = v279:FindFirstChild("MagAmmo");
                                                                                    end;

                                                                                    if (v279 and (v279.MaxValue > 0 and v279.Value / v279.MaxValue) or 1) <= 0 or (u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) >= script_NpcSuppression.HEAVY_TIER then
                                                                                        if script_NpcSuppressFire.trace then
                                                                                            script_NpcSuppressFire.trace(u5, "refused", "busy");
                                                                                        end;
                                                                                    elseif math.random() >= script_NpcSuppressFire.Chance(v275, v273 - v274.knownAt, v278) then
                                                                                        v280 = script_NpcSuppressFire.stats;
                                                                                        v280.refusedRoll = v280.refusedRoll + 1;
                                                                                    elseif script_SquadBoard.TrySuppress(u5, Value, v273, v273 + script_NpcSuppressFire.MAX_TIME_CAP) then
                                                                                        RaycastParams_new_ret2.FilterDescendantsInstances = { u5, workspace.PlayerCharacters };
                                                                                        v281 = script_NpcSuppressFire.PickPoint(u5.Head.Position, v274.knownPos, function(p299, p300) -- Line: 1607
                                                                                            -- upvalues: NpcSight (ref), RaycastParams_new_ret2 (ref)
                                                                                            return NpcSight.Cast(p299, p300 - p299, RaycastParams_new_ret2) == nil;
                                                                                        end);

                                                                                        if v281 then
                                                                                            v282 = {
                                                                                                bursts = 0,
                                                                                                shots = 0,
                                                                                                start = v273,
                                                                                                point = v281,
                                                                                                burst0 = u30.BurstsFired(),
                                                                                                maxBursts = v275 and v275.suppressBursts or script_NpcSuppressFire.DEFAULT_BURSTS
                                                                                            };
                                                                                            v283 = script_NpcSuppressFire.MaxShots;

                                                                                            if v275 then
                                                                                                v284 = v275.suppressBursts;
                                                                                            else
                                                                                                v284 = v275;
                                                                                            end;

                                                                                            v282.maxShots = v283(v284);
                                                                                            v282.maxTime = math.min(script_NpcSuppressFire.MAX_TIME * (v275 and v275.suppressTimeMult or 1), script_NpcSuppressFire.MAX_TIME_CAP);
                                                                                            v282.fireAt = v273 + (script_NpcSuppressFire.DELAY[u5:GetAttribute("Rank") or ""] or script_NpcSuppressFire.DEFAULT_DELAY);
                                                                                            v282.source = v277;
                                                                                            v282.covering = v278;
                                                                                            u98 = v282;
                                                                                            v285 = script_NpcSuppressFire.stats;
                                                                                            v285.episodes = v285.episodes + 1;
                                                                                            script_NpcTelemetry.Bump("supfire.start");
                                                                                            script_NpcRadioChatter.Event(u5, "supfire", Value);

                                                                                            if script_NpcSuppressFire.trace then
                                                                                                script_NpcSuppressFire.trace(u5, "start", u98);
                                                                                            end;

                                                                                            if u4 then
                                                                                                u5:SetAttribute("Suppressing", v277);
                                                                                            end;
                                                                                        else
                                                                                            script_SquadBoard.ReleaseSuppress(u5);
                                                                                            v286 = script_NpcSuppressFire.stats;
                                                                                            v286.refusedPoint = v286.refusedPoint + 1;

                                                                                            if script_NpcSuppressFire.trace then
                                                                                                script_NpcSuppressFire.trace(u5, "refused", "nopoint");
                                                                                            end;
                                                                                        end;
                                                                                    else
                                                                                        v287 = script_NpcSuppressFire.stats;
                                                                                        v287.refusedSlot = v287.refusedSlot + 1;
                                                                                    end;
                                                                                end;
                                                                            else
                                                                                v288 = script_NpcSuppressFire.stats;
                                                                                v288.refusedSource = v288.refusedSource + 1;

                                                                                if script_NpcSuppressFire.trace then
                                                                                    script_NpcSuppressFire.trace(u5, "refused", v277);
                                                                                end;
                                                                            end;
                                                                        end;

                                                                        goto l1;
                                                                    end;

                                                                    v289 = script_NpcSuppressFire.ShouldStop;
                                                                    v290 = u98;
                                                                    v291 = {
                                                                        hasLOS = false,
                                                                        moving = false,
                                                                        now = v273
                                                                    };

                                                                    if v274 and v274.knownAt then
                                                                        v292 = v273 - v274.knownAt or nil;
                                                                    else
                                                                        v292 = nil;
                                                                    end;

                                                                    v291.age = v292;
                                                                    v291.tier = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;
                                                                    v291.reloading = u30.IsReloading();
                                                                    v293 = u10:FindFirstChild("Ammo");

                                                                    if v293 then
                                                                        v293 = v293:FindFirstChild("MagAmmo");
                                                                    end;

                                                                    v291.magEmpty = (v293 and (v293.MaxValue > 0 and v293.Value / v293.MaxValue) or 1) <= 0;
                                                                    v291.tactic = u83;
                                                                    v294 = v289(v290, v291);

                                                                    if v294 then
                                                                        endSuppressive(v294);
                                                                        goto l1;
                                                                    end;

                                                                    u98.bursts = u30.BurstsFired() - u98.burst0;
                                                                    u26.StopMoving();
                                                                    u30.FaceAt(u98.point);

                                                                    if u98.fireAt <= v273 and u30.ShootAt(u98.point, script_NpcSuppressFire.SPREAD_MULT) then
                                                                        v295 = u98;
                                                                        v295.shots = v295.shots + 1;
                                                                        v296 = script_NpcSuppressFire.stats;
                                                                        v296.shots = v296.shots + 1;
                                                                        script_NpcTelemetry.Bump("supfire.round");

                                                                        if script_NpcSuppressFire.trace then
                                                                            script_NpcSuppressFire.trace(u5, "shot", u98.point);
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    elseif u66 == "reloading" then
                                                        if not (u30.IsReloading() or u30.IsChamberingBolt()) then
                                                            u30.StopAiming();

                                                            if u66 ~= "idle" then
                                                                u66 = "idle";

                                                                if u4 then
                                                                    u5:SetAttribute("CombatState", "idle");
                                                                end;
                                                            end;
                                                        end;

                                                        if u7 then
                                                            v265 = u30.UpdateFacing;

                                                            if Value then
                                                                v266 = Value:FindFirstChild("HumanoidRootPart");
                                                            else
                                                                v266 = Value;
                                                            end;

                                                            if v266 then
                                                                if u53 and not u7 then
                                                                    if u53 then
                                                                        v267 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                    else
                                                                        v267 = u68;
                                                                    end;
                                                                else
                                                                    v267 = v266.Position;
                                                                end;
                                                            else
                                                                v267 = nil;
                                                            end;

                                                            v265(v267);
                                                        elseif not (u30.IsAiming() or not AlignOrientation.Enabled and Humanoid.AutoRotate) then
                                                            AlignOrientation.Enabled = false;
                                                            Humanoid.AutoRotate = true;
                                                        end;

                                                        if Value then
                                                            v268 = Value:FindFirstChild("HumanoidRootPart");
                                                        else
                                                            v268 = Value;
                                                        end;

                                                        if v268 then
                                                            if u53 and not u7 then
                                                                if u53 then
                                                                    v269 = script_NpcKnowledge.BestEstimate(u5, Value, os.clock());
                                                                else
                                                                    v269 = u68;
                                                                end;
                                                            else
                                                                v269 = v268.Position;
                                                            end;
                                                        else
                                                            v269 = nil;
                                                        end;

                                                        if v269 and DistToTarget < (u5:GetAttribute("Stance") == "Crouch" and u26.TooCloseRange or u26.IdealMinRange) then
                                                            u26.Retreat(v269);
                                                        end;
                                                    elseif WeaponState == "needsReload" and not u30.IsReloading() then
                                                        if u66 ~= "reloading" then
                                                            u66 = "reloading";

                                                            if u4 then
                                                                u5:SetAttribute("CombatState", "reloading");
                                                            end;
                                                        end;

                                                        u30.StopAiming(true);
                                                        task.spawn(function() -- Line: 1536
                                                            -- upvalues: u30 (ref)
                                                            u30.PerformReload();
                                                        end);
                                                    elseif WeaponState == "needsChamber" and not u30.IsChamberingBolt() then
                                                        if u66 ~= "reloading" then
                                                            u66 = "reloading";

                                                            if u4 then
                                                                u5:SetAttribute("CombatState", "reloading");
                                                            end;
                                                        end;

                                                        task.spawn(function() -- Line: 1542
                                                            -- upvalues: u30 (ref)
                                                            u30.PerformChamber();
                                                        end);
                                                    else
                                                        if u55 then
                                                            if u88 == nil then
                                                                v270 = false;
                                                            else
                                                                v270 = (HumanoidRootPart.Position - u88).Magnitude <= 4;
                                                            end;

                                                            if v270 then
                                                                v271 = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;

                                                                if script_NpcSuppression.HEAVY_TIER <= v271 then
                                                                    v272 = true;
                                                                elseif v271 == script_NpcSuppression.MEDIUM_TIER then
                                                                    v272 = script_NpcSuppression.Hesitating(u5, os.clock());
                                                                else
                                                                    v272 = false;
                                                                end;
                                                            else
                                                                v272 = false;
                                                            end;
                                                        else
                                                            v272 = false;
                                                        end;

                                                        if v272 then
                                                            v272 = u26.TooCloseRange <= DistToTarget;
                                                        end;

                                                        if v272 ~= u106 then
                                                            u106 = v272;

                                                            if v272 then
                                                                script_NpcSuppression.Count("stayedDown");
                                                            end;
                                                        end;

                                                        if v272 then
                                                            if u66 == "aiming" or u66 == "firing" then
                                                                u30.StopAiming();
                                                            end;

                                                            if u75 ~= 0 then
                                                                u75 = 0;

                                                                if u27 then
                                                                    u27.SetLean(0);
                                                                end;
                                                            end;

                                                            u26.StopMoving();

                                                            if u66 ~= "idle" then
                                                                u66 = "idle";

                                                                if u4 then
                                                                    u5:SetAttribute("CombatState", "idle");
                                                                end;
                                                            end;
                                                        else
                                                            if not u59 or v162 then
                                                                goto l1;
                                                            end;

                                                            v273 = os.clock();
                                                            v274 = script_NpcKnowledge.Get(u5, Value, v273);

                                                            if u7 then
                                                                endSuppressive("reacquired");
                                                                goto l1;
                                                            end;

                                                            if not u98 then
                                                                if v274 and (v274.knownAt and (not v274.visible and script_NpcSuppressFire.MayDecide(u99, u100, v274.knownAt, v273))) then
                                                                    u99 = v274.knownAt;
                                                                    u100 = v273;
                                                                    v275 = getPersona();
                                                                    v276, v277 = script_NpcSuppressFire.Source(v274, v273);
                                                                    v278 = u58 and script_SquadBoard.Covering(u5, v273) ~= nil;

                                                                    if v276 then
                                                                        if u30.IsReloading() then
                                                                            if script_NpcSuppressFire.trace then
                                                                                script_NpcSuppressFire.trace(u5, "refused", "busy");
                                                                            end;
                                                                        else
                                                                            v279 = u10:FindFirstChild("Ammo");

                                                                            if v279 then
                                                                                v279 = v279:FindFirstChild("MagAmmo");
                                                                            end;

                                                                            if (v279 and (v279.MaxValue > 0 and v279.Value / v279.MaxValue) or 1) <= 0 or (u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0) >= script_NpcSuppression.HEAVY_TIER then
                                                                                if script_NpcSuppressFire.trace then
                                                                                    script_NpcSuppressFire.trace(u5, "refused", "busy");
                                                                                end;
                                                                            elseif math.random() >= script_NpcSuppressFire.Chance(v275, v273 - v274.knownAt, v278) then
                                                                                v280 = script_NpcSuppressFire.stats;
                                                                                v280.refusedRoll = v280.refusedRoll + 1;
                                                                            elseif script_SquadBoard.TrySuppress(u5, Value, v273, v273 + script_NpcSuppressFire.MAX_TIME_CAP) then
                                                                                RaycastParams_new_ret2.FilterDescendantsInstances = { u5, workspace.PlayerCharacters };
                                                                                v281 = script_NpcSuppressFire.PickPoint(u5.Head.Position, v274.knownPos, function(p299, p300) -- Line: 1607
                                                                                    -- upvalues: NpcSight (ref), RaycastParams_new_ret2 (ref)
                                                                                    return NpcSight.Cast(p299, p300 - p299, RaycastParams_new_ret2) == nil;
                                                                                end);

                                                                                if v281 then
                                                                                    v282 = {
                                                                                        bursts = 0,
                                                                                        shots = 0,
                                                                                        start = v273,
                                                                                        point = v281,
                                                                                        burst0 = u30.BurstsFired(),
                                                                                        maxBursts = v275 and v275.suppressBursts or script_NpcSuppressFire.DEFAULT_BURSTS
                                                                                    };
                                                                                    v283 = script_NpcSuppressFire.MaxShots;

                                                                                    if v275 then
                                                                                        v284 = v275.suppressBursts;
                                                                                    else
                                                                                        v284 = v275;
                                                                                    end;

                                                                                    v282.maxShots = v283(v284);
                                                                                    v282.maxTime = math.min(script_NpcSuppressFire.MAX_TIME * (v275 and v275.suppressTimeMult or 1), script_NpcSuppressFire.MAX_TIME_CAP);
                                                                                    v282.fireAt = v273 + (script_NpcSuppressFire.DELAY[u5:GetAttribute("Rank") or ""] or script_NpcSuppressFire.DEFAULT_DELAY);
                                                                                    v282.source = v277;
                                                                                    v282.covering = v278;
                                                                                    u98 = v282;
                                                                                    v285 = script_NpcSuppressFire.stats;
                                                                                    v285.episodes = v285.episodes + 1;
                                                                                    script_NpcTelemetry.Bump("supfire.start");
                                                                                    script_NpcRadioChatter.Event(u5, "supfire", Value);

                                                                                    if script_NpcSuppressFire.trace then
                                                                                        script_NpcSuppressFire.trace(u5, "start", u98);
                                                                                    end;

                                                                                    if u4 then
                                                                                        u5:SetAttribute("Suppressing", v277);
                                                                                    end;
                                                                                else
                                                                                    script_SquadBoard.ReleaseSuppress(u5);
                                                                                    v286 = script_NpcSuppressFire.stats;
                                                                                    v286.refusedPoint = v286.refusedPoint + 1;

                                                                                    if script_NpcSuppressFire.trace then
                                                                                        script_NpcSuppressFire.trace(u5, "refused", "nopoint");
                                                                                    end;
                                                                                end;
                                                                            else
                                                                                v287 = script_NpcSuppressFire.stats;
                                                                                v287.refusedSlot = v287.refusedSlot + 1;
                                                                            end;
                                                                        end;
                                                                    else
                                                                        v288 = script_NpcSuppressFire.stats;
                                                                        v288.refusedSource = v288.refusedSource + 1;

                                                                        if script_NpcSuppressFire.trace then
                                                                            script_NpcSuppressFire.trace(u5, "refused", v277);
                                                                        end;
                                                                    end;
                                                                end;

                                                                goto l1;
                                                            end;

                                                            v289 = script_NpcSuppressFire.ShouldStop;
                                                            v290 = u98;
                                                            v291 = {
                                                                hasLOS = false,
                                                                moving = false,
                                                                now = v273
                                                            };

                                                            if v274 and v274.knownAt then
                                                                v292 = v273 - v274.knownAt or nil;
                                                            else
                                                                v292 = nil;
                                                            end;

                                                            v291.age = v292;
                                                            v291.tier = u55 and script_NpcSuppression.Tier(u5, os.clock()) or 0;
                                                            v291.reloading = u30.IsReloading();
                                                            v293 = u10:FindFirstChild("Ammo");

                                                            if v293 then
                                                                v293 = v293:FindFirstChild("MagAmmo");
                                                            end;

                                                            v291.magEmpty = (v293 and (v293.MaxValue > 0 and v293.Value / v293.MaxValue) or 1) <= 0;
                                                            v291.tactic = u83;
                                                            v294 = v289(v290, v291);

                                                            if v294 then
                                                                endSuppressive(v294);
                                                                goto l1;
                                                            end;

                                                            u98.bursts = u30.BurstsFired() - u98.burst0;
                                                            u26.StopMoving();
                                                            u30.FaceAt(u98.point);

                                                            if u98.fireAt <= v273 and u30.ShootAt(u98.point, script_NpcSuppressFire.SPREAD_MULT) then
                                                                v295 = u98;
                                                                v295.shots = v295.shots + 1;
                                                                v296 = script_NpcSuppressFire.stats;
                                                                v296.shots = v296.shots + 1;
                                                                script_NpcTelemetry.Bump("supfire.round");

                                                                if script_NpcSuppressFire.trace then
                                                                    script_NpcSuppressFire.trace(u5, "shot", u98.point);
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            else
                                                u5.Target.Value = nil;
                                                u68 = nil;
                                                u30.StopAiming();
                                                u26.StopMoving();

                                                if u66 ~= "idle" then
                                                    u66 = "idle";

                                                    if u4 then
                                                        u5:SetAttribute("CombatState", "idle");
                                                    end;
                                                end;
                                            end;
                                        end;

                                        break;
                                    else
                                        break;
                                    end;
                                end;
                            end;
                        else
                            if u56 then
                                local os_clock_ret3 = os.clock();
                                u136 = u136 or os_clock_ret3;

                                if os_clock_ret3 - u136 >= 4 and not (u135 or (script_NpcKnowledge.Strongest(u5, os_clock_ret3, adoptable) ~= nil or not (u52 and u52()))) then
                                    u136 = nil;
                                    u5.Alerted.Value = false;
                                end;
                            end;

                            u5:SetAttribute("Stance", "Stand");
                            u78 = 0;
                            u79 = 0;
                            endTactics();

                            if u75 ~= 0 then
                                u75 = 0;

                                if u27 then
                                    u27.SetLean(0);
                                end;
                            end;

                            if u66 ~= "idle" then
                                if u66 ~= "idle" then
                                    u66 = "idle";

                                    if u4 then
                                        u5:SetAttribute("CombatState", "idle");
                                    end;
                                end;

                                u30.StopAiming();
                                u26.StopMoving();
                            end;
                        end;
                    end;

                    u30.StopAiming();
                    u26.StopMoving();

                    while u8 and (u5.Parent and u5:GetAttribute("_Dormant")) do
                        task.wait(1);
                    end;
                end;
            end;

            local v317 = 0;

            while true do
                local success, result = pcall(combatLoop);

                if success then
                    break;
                end;

                if os.clock() - v317 > 10 then
                    v317 = os.clock();
                    warn("[NPCFREEZE] combat loop error, restarting: " .. tostring(result));
                end;

                task.wait(0.1);

                if not (u8 and u5.Parent) then
                    break;
                end;

                local Alerted = u5:FindFirstChild("Alerted");
                local v318;

                if Alerted == nil then
                    v318 = false;
                else
                    v318 = Alerted.Value;
                end;

                if not v318 then
                    break;
                end;
            end;

            u30.StopAiming();
            u26.StopMoving();
            endTactics();

            if u5.Parent then
                u5:SetAttribute("Stance", "Stand");
            end;

            if u75 ~= 0 then
                u75 = 0;

                if u27 then
                    u27.SetLean(0);
                end;
            end;
        end);
    end;

    local PropertyChangedSignal = Humanoid:GetPropertyChangedSignal("Health");
    table.insert(u9, PropertyChangedSignal:Connect(HandleDeath));
    table.insert(u9, RunService.Heartbeat:Connect(function(p319) -- Line: 1801
        -- upvalues: u8 (ref), u5 (copy), script_NpcKnowledge (ref), u5 (copy), u29 (copy), Neck (copy), u3 (ref), HumanoidRootPart (copy), Torso (copy), u30 (copy)
        if not u8 then
            return;
        end;

        if not u5.Parent then
            return;
        end;

        local Value = u5.Target.Value;
        local v320 = Value and Value:FindFirstChild("HumanoidRootPart") and Value.HumanoidRootPart.Position;

        if v320 and script_NpcKnowledge.Enabled() then
            local v321 = script_NpcKnowledge.Get(u5, Value, os.clock());

            if v321 then
                v320 = v321.visible and v320 and v320 or (u29.SearchLook or (v321.knownPos or nil));
            else
                v320 = nil;
            end;
        end;

        if v320 == nil then
            local C1 = Neck.C1;

            if C1 == u3 then
                return;
            end;

            local v322 = C1:Lerp(u3, 0.1);

            if (v322.Position - u3.Position).Magnitude < 0.001 and v322.LookVector:Dot(u3.LookVector) > 0.99999 then
                v322 = u3;
            end;

            Neck.C1 = v322;

            return;
        end;

        local math_clamp_ret = math.clamp((v320 - HumanoidRootPart.Position).Unit.Y, -0.8, 0.15);
        local math_clamp_ret2 = math.clamp(Torso.CFrame.LookVector.Y, -0.6, 0.6);
        local v323, v324 = u30.DecayRecoil(p319);
        local CFrame_Angles_ret = CFrame.Angles(-math.asin(math_clamp_ret) + math.asin(math_clamp_ret2) - math.rad(v323), math.rad(v324), 0);
        local v325 = CFrame.new(0, -0.5, 0) * CFrame_Angles_ret * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793);
        Neck.C1 = Neck.C1:Lerp(v325, 0.1 * p319 * 60);
    end));
    local u326 = nil;
    local Target = u5:FindFirstChild("Target");

    if Target then
        table.insert(u9, Target.Changed:Connect(function() -- Line: 1848
            -- upvalues: u326 (ref), u5 (copy)
            if u326 then
                u326:Disconnect();
                u326 = nil;
            end;

            local Value = u5.Target.Value;

            if Value and Value:FindFirstChild("Humanoid") then
                u326 = Value.Humanoid.Died:Connect(function() -- Line: 1852
                    -- upvalues: u5 (ref)
                    task.wait(0.25);

                    if u5.Parent then
                        u5.Target.Value = nil;
                    end;
                end);
            end;
        end));
    end;

    table.insert(u9, Humanoid.Died:Connect(HandleDeath));
    AlertedHandler();
    local u327 = 0;

    u52 = function() -- Line: 1888
        -- upvalues: u5 (copy)
        local Attribute = u5:GetAttribute("Faction");
        local success, result = pcall(function() -- Line: 1890
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and (type(result.LosProvokeFactions) == "table" and Attribute ~= nil) then
                success = result.LosProvokeFactions[Attribute] == true;
            else
                success = false;
            end;
        end;

        return success;
    end;

    local function runGiveUp(p328, p329) -- Line: 1897
        -- upvalues: npcConfig (copy), u5 (copy), u327 (ref), u6 (ref), u52 (ref), u30 (copy), u26 (ref)
        task.wait(npcConfig.GiveupTime);

        while u5.Parent and (u327 == p328 and tick() - u6 < 20) do
            task.wait(10);
        end;

        if u327 ~= p328 then
            return;
        end;

        if p329 and not u52() then
            return;
        end;

        if not u5.Parent then
            return;
        end;

        if not u5:FindFirstChild("Alerted") then
            return;
        end;

        u5.Alerted.Value = false;

        if u5:FindFirstChild("Target") then
            u5.Target.Value = nil;
        end;

        u30.StopAiming();
        u26.StopMoving();
    end;

    table.insert(u9, u5.Alerted.Changed:Connect(function() -- Line: 1922
        -- upvalues: u5 (copy), u327 (ref), AlertedHandler (copy), runGiveUp (copy)
        if not u5.Parent then
            return;
        end;

        u327 = u327 + 1;
        local v330 = u327;
        task.wait();

        if not u5.Parent then
            return;
        end;

        AlertedHandler();

        if u5.Alerted.Value == true then
            runGiveUp(v330);
        end;
    end));

    if u5.Alerted.Value == true then
        u327 = u327 + 1;
        task.spawn(runGiveUp, u327, true);
    end;

    table.insert(u9, Players.PlayerRemoving:Connect(function(p331) -- Line: 1943
        -- upvalues: u5 (copy), u30 (copy), u26 (ref)
        if not u5.Parent then
            return;
        end;

        if u5.Target.Value ~= nil and u5.Target.Value.Name == p331.Name then
            u5.Target.Value = nil;
            u30.StopAiming();
            u26.StopMoving();
        end;
    end));
end;

function v1.SpawnHostileNPC(p332, p333, p334, p335, p336) -- Line: 1953
    -- upvalues: ReplicatedStorage (copy), u2 (copy), script_NPC_WeaponRig (copy), script_NPC_Stance (copy), RunNPCAI (copy)
    local v337 = ReplicatedStorage.HostileNPC:Clone();
    local v338 = v337:FindFirstChildOfClass("Humanoid");

    if v338 then
        v338.UseJumpPower = false;
        v338.JumpHeight = 5;
    end;

    v337.ModelStreamingMode = Enum.ModelStreamingMode.Atomic;

    local function demotePersistent(p339) -- Line: 1973
        if p339:IsA("Model") and (p339.ModelStreamingMode ~= Enum.ModelStreamingMode.Default and p339.ModelStreamingMode ~= Enum.ModelStreamingMode.Nonatomic) then
            p339.ModelStreamingMode = Enum.ModelStreamingMode.Default;
        end;
    end;

    for _, descendant in ipairs(v337:GetDescendants()) do
        if descendant:IsA("Model") and (descendant.ModelStreamingMode ~= Enum.ModelStreamingMode.Default and descendant.ModelStreamingMode ~= Enum.ModelStreamingMode.Nonatomic) then
            descendant.ModelStreamingMode = Enum.ModelStreamingMode.Default;
        end;
    end;

    v337.DescendantAdded:Connect(demotePersistent);
    local npcConfig = require(v337:WaitForChild("npcConfig"));
    npcConfig.AllyTag = p335 or "";
    npcConfig.AttacksNPCs = p334 == true;
    local v340 = u2[p335 or ""];

    if v340 then
        for i, v in pairs(v340) do
            npcConfig[i] = v;
        end;
    end;

    v337:SetAttribute("HostileNPC", true);
    v337:SetAttribute("AllyTag", p335 or "");
    task.wait();

    if not v337:FindFirstChild("Animate") then
        return nil;
    end;

    script_NPC_WeaponRig.EquipGunOnRig(v337, p333);
    v337.Parent = workspace;
    v337.HumanoidRootPart.CFrame = p332.CFrame;

    if p336 == true then
        v337.Alerted.Value = true;
    end;

    script_NPC_Stance.New(v337, v337:FindFirstChildOfClass("Humanoid"));
    task.spawn(RunNPCAI, v337);

    return v337;
end;

return v1;