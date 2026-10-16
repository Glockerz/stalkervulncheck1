-- Decompiled with Potassium's decompiler.

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local serverSideShoot = require(ReplicatedStorage.openSphMod.serverSideShoot);
local NPC_Ammo = require(script.Parent.NPC_Ammo);
local NpcAimSpread = require(script.Parent.NpcAimSpread);
local u2 = { Vector3.new(0, 0.75, 0), Vector3.new(-0.7, 0, 0), Vector3.new(0.7, 0, 0) };
game:GetService("Players");
local u3 = nil;

local function getSuppressionRemote() -- Line: 47
    -- upvalues: u3 (ref)
    if u3 and u3.Parent then
        return u3;
    end;

    local miscEvents = game:GetService("ReplicatedStorage"):FindFirstChild("miscEvents");
    u3 = miscEvents and miscEvents:FindFirstChild("npcSuppression") or nil;

    return u3;
end;

local u4 = {
    burst = 0.6,
    semi = 0.25,
    fullauto = 0.15
};
local u5 = {
    Bandit = 2,
    Military = 1.1,
    Loner = 1.3,
    ClearSky = 1.2,
    Monolith = 1
};
local u6 = {
    BANDIT_FACTION = "Bandit",
    MILITARY_FACTION = "Military",
    LONER_FACTION = "Loner",
    CLEARSKY_FACTION = "ClearSky",
    MONOLITH_FACTION = "Monolith"
};
local u7 = { "semi", "fullauto", "burst", "semi" };

local function ensureRigIdlePlaying(p8) -- Line: 100
    if not (p8.NPC and p8.NPC.Parent) then
        return;
    end;

    local WeaponRig = p8.NPC:FindFirstChild("WeaponRig");

    if not WeaponRig then
        return;
    end;

    local v9 = WeaponRig:FindFirstChildOfClass("AnimationController");

    if v9 then
        v9 = v9:FindFirstChildOfClass("Animator");
    end;

    if not v9 then
        return;
    end;

    for _, v in ipairs(v9:GetPlayingAnimationTracks()) do
        if v.Priority == Enum.AnimationPriority.Idle and v.WeightCurrent > 0.01 then
            return;
        end;
    end;

    local v10 = p8.wepStats and p8.wepStats.idleAnim;

    if not v10 then
        return;
    end;

    local v11 = require(game.ReplicatedStorage:WaitForChild("spawnNpc"):WaitForChild("NPC_WeaponRig")).LoadAnimTrack(p8.NPC, v10, Enum.AnimationPriority.Idle);

    if v11 then
        v11.Looped = true;
        v11:Play(0.15);
    end;
end;

local function pickFireMode(p12) -- Line: 139
    -- upvalues: u7 (copy), u4 (copy)
    local v13 = {};
    local v14;

    if p12 then
        v14 = p12.fireSwitch;
    else
        v14 = p12;
    end;

    if v14 then
        for i, v in ipairs(v14) do
            if v then
                local v15 = u7[i];

                if v15 and not table.find(v13, v15) then
                    table.insert(v13, v15);
                end;
            end;
        end;
    end;

    if p12 then
        p12 = p12.magazineCapacity;
    end;

    local v16;

    if type(p12) == "number" and (p12 >= 75 and #v13 > 1) then
        v16 = {};

        for _, v in ipairs(v13) do
            if v ~= "semi" then
                table.insert(v16, v);
            end;
        end;

        if #v16 <= 0 then
            v16 = v13;
        end;
    else
        v16 = v13;
    end;

    local v17 = #v16 == 0 and { "semi" } or v16;

    if #v17 == 1 then
        return v17[1];
    end;

    local v18 = 0;

    for _, v in ipairs(v17) do
        v18 = v18 + (u4[v] or 0);
    end;

    if v18 <= 0 then
        return v17[1];
    end;

    local v19 = math.random() * v18;
    local v20 = 0;

    for _, v in ipairs(v17) do
        v20 = v20 + (u4[v] or 0);

        if v19 <= v20 then
            return v;
        end;
    end;

    return v17[1];
end;

local NpcSight = require(ReplicatedStorage:WaitForChild("NpcSight"));

function v1.New(u21) -- Line: 185
    -- upvalues: pickFireMode (copy), ensureRigIdlePlaying (copy), u6 (copy), u5 (copy), u2 (copy), NPC_Ammo (copy), NpcSight (copy), NpcAimSpread (copy), serverSideShoot (copy)
    local u22 = {};
    local npcConfig = u21.npcConfig;
    local u23 = pickFireMode(u21.wepStats);

    if game:GetService("RunService"):IsStudio() then
        u21.NPC:SetAttribute("FireMode", u23);
    end;

    ensureRigIdlePlaying(u21);
    task.delay(0.1, function() -- Line: 197
        -- upvalues: ensureRigIdlePlaying (ref), u21 (copy)
        ensureRigIdlePlaying(u21);
    end);
    task.delay(0.5, function() -- Line: 198
        -- upvalues: ensureRigIdlePlaying (ref), u21 (copy)
        ensureRigIdlePlaying(u21);
    end);
    task.spawn(function() -- Line: 203
        -- upvalues: u21 (copy), ensureRigIdlePlaying (ref)
        while u21.NPC and u21.NPC.Parent do
            task.wait(0.25);

            if not (u21.NPC and u21.NPC.Parent) then
                return;
            end;

            if u21.Humanoid and u21.Humanoid.Health <= 0 then
                return;
            end;

            ensureRigIdlePlaying(u21);
        end;
    end);

    if u6[u21.NPC and (u21.NPC:GetAttribute("AllyTag") or "") or ""] ~= nil then
        local v24 = u21.Weapon and u21.Weapon:FindFirstChild("Ammo");

        if v24 then
            v24 = v24:FindFirstChild("ArcadeAmmoPool");
        end;

        if v24 then
            v24.MaxValue = 999999;
            v24.Value = 999999;
        end;
    end;

    local Lighting = game:GetService("Lighting");

    local function isNight() -- Line: 253
        -- upvalues: Lighting (copy)
        return Lighting.ClockTime > 18 and true or Lighting.ClockTime < 6;
    end;

    local u25 = nil;

    local function setArmsGunShadows(p26) -- Line: 255
        -- upvalues: u25 (ref), u21 (copy)
        if u25 == p26 then
            return;
        end;

        u25 = p26;

        for _, v in ipairs({ "Right Arm", "Left Arm" }) do
            local v27 = u21.NPC:FindFirstChild(v);

            if v27 and v27:IsA("BasePart") then
                v27.CastShadow = p26;
            end;
        end;

        if u21.gunModel then
            for _, descendant in ipairs(u21.gunModel:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.CastShadow = p26;
                end;
            end;
        end;
    end;

    local function refresh() -- Line: 268
        -- upvalues: u21 (copy), setArmsGunShadows (copy), Lighting (copy)
        if not u21.NPC.Parent then
            return;
        end;

        setArmsGunShadows(not (u21.NPC.Alerted.Value and (Lighting.ClockTime > 18 and true or Lighting.ClockTime < 6)));
    end;

    task.delay(1, refresh);
    u21.NPC.Alerted.Changed:Connect(refresh);
    task.spawn(function() -- Line: 275
        -- upvalues: u21 (copy), setArmsGunShadows (copy), Lighting (copy)
        while u21.NPC.Parent do
            task.wait(5);

            if u21.NPC.Parent then
                setArmsGunShadows(not (u21.NPC.Alerted.Value and (Lighting.ClockTime > 18 and true or Lighting.ClockTime < 6)));
            end;
        end;
    end);
    local u28 = 0;
    local u29 = 0;
    local u30 = 0;

    local function startBurst() -- Line: 285
        -- upvalues: u23 (copy), u28 (ref)
        if u23 == "semi" then
            u28 = 1;

            return;
        end;

        if u23 == "fullauto" then
            u28 = math.random(8, 14);

            return;
        end;

        u28 = math.random(3, 5);
    end;

    local function endBurst() -- Line: 290
        -- upvalues: u28 (ref), u30 (ref), u23 (copy), u29 (ref)
        u28 = 0;
        u30 = u30 + 1;
        local v31, v32;

        if u23 == "semi" then
            v31 = 0.3;
            v32 = 0.6;
        elseif u23 == "fullauto" then
            v31 = 0.2;
            v32 = 0.45;
        else
            v31 = 0.4;
            v32 = 0.8;
        end;

        u29 = os.clock() + v31 + math.random() * (v32 - v31);
    end;

    local function getAccuracyMult() -- Line: 299
        -- upvalues: u23 (copy)
        return u23 == "semi" and 0.5 or (u23 == "fullauto" and 1.6 or 1);
    end;

    local function burstGate() -- Line: 304
        -- upvalues: u29 (ref), u28 (ref), u23 (copy)
        if os.clock() < u29 then
            return false;
        end;

        if u28 <= 0 then
            if u23 == "semi" then
                u28 = 1;
            elseif u23 == "fullauto" then
                u28 = math.random(8, 14);
            else
                u28 = math.random(3, 5);
            end;
        end;

        return true;
    end;

    local function burstAfterShot() -- Line: 309
        -- upvalues: u28 (ref), u30 (ref), u23 (copy), u29 (ref)
        u28 = u28 - 1;

        if u28 <= 0 then
            u28 = 0;
            u30 = u30 + 1;
            local v33, v34;

            if u23 == "semi" then
                v33 = 0.3;
                v34 = 0.6;
            elseif u23 == "fullauto" then
                v33 = 0.2;
                v34 = 0.45;
            else
                v33 = 0.4;
                v34 = 0.8;
            end;

            u29 = os.clock() + v33 + math.random() * (v34 - v33);
        end;
    end;

    local function getFactionMult() -- Line: 314
        -- upvalues: u21 (copy), u6 (ref), u5 (ref)
        local v35 = u6[u21.NPC and u21.NPC:GetAttribute("AllyTag") or ""];

        return v35 and u5[v35] or 1;
    end;

    local u36 = nil;

    local function getRankMult() -- Line: 325
        -- upvalues: u21 (copy), u36 (ref)
        local v37 = u21.NPC and u21.NPC:GetAttribute("Rank");

        if not v37 then
            return 1;
        end;

        if not u36 then
            local success, result = pcall(require, game:GetService("ServerScriptService"):WaitForChild("NPCConfig"));

            if success then
                u36 = result;
            end;
        end;

        local v38 = u36 and u36.Ranks and u36.Ranks[v37];

        return v38 and v38.AccuracyMult or 1;
    end;

    local function getHeadshotChance() -- Line: 337
        -- upvalues: u21 (copy), u36 (ref)
        local v39 = u21.NPC and u21.NPC:GetAttribute("Rank");

        if not v39 then
            return 0;
        end;

        if not u36 then
            local success, result = pcall(require, game:GetService("ServerScriptService"):WaitForChild("NPCConfig"));

            if success then
                u36 = result;
            end;
        end;

        local v40 = u36 and u36.Ranks and u36.Ranks[v39];

        return v40 and v40.HeadshotChance or 0;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.IgnoreWater = true;
    local u41 = nil;

    local function exposedFromMuzzle(p42, p43) -- Line: 355
        -- upvalues: u21 (copy), RaycastParams_new_ret (copy)
        local Position = u21.muzzle.WorldCFrame.Position;
        RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p42 };

        return workspace:Raycast(Position, p43 - Position, RaycastParams_new_ret) == nil;
    end;

    local function pickAimPoint(p44) -- Line: 366
        -- upvalues: getHeadshotChance (copy), u41 (ref), u21 (copy), RaycastParams_new_ret (copy), u2 (ref)
        local HumanoidRootPart = p44:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return nil;
        end;

        local Head = p44:FindFirstChild("Head");
        local v45;

        if Head == nil then
            v45 = false;
        else
            v45 = math.random() < getHeadshotChance();
        end;

        local os_clock_ret = os.clock();

        if u41 and (u41.target == p44 and (u41.head == v45 and os_clock_ret - u41.at < 0.2)) then
            if u41.offset then
                return u41.offset == "head" and Head.Position or HumanoidRootPart.CFrame:PointToWorldSpace(u41.offset);
            end;

            return nil;
        end;

        local v46 = nil;
        local v47, v48, v49, v50, v51, v52;

        if v45 then
            local Position = Head.Position;
            local Position2 = u21.muzzle.WorldCFrame.Position;
            RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

            if workspace:Raycast(Position2, Position - Position2, RaycastParams_new_ret) == nil then
                v46 = "head";
            elseif v45 then
                for i, v in ipairs(u2) do
                    v47 = HumanoidRootPart.CFrame:PointToWorldSpace(v);
                    v48 = u21.muzzle.WorldCFrame.Position;
                    RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

                    if workspace:Raycast(v48, v47 - v48, RaycastParams_new_ret) == nil then
                        v46 = v;
                        break;
                    end;
                end;

                if v46 == nil and v45 then
                    v49 = HumanoidRootPart.Position;
                    v50 = u21.muzzle.WorldCFrame.Position;
                    RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

                    if workspace:Raycast(v50, v49 - v50, RaycastParams_new_ret) == nil then
                        v46 = Vector3.new(0, 0, 0);
                    end;
                end;
            else
                v51 = HumanoidRootPart.Position;
                v52 = u21.muzzle.WorldCFrame.Position;
                RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

                if workspace:Raycast(v52, v51 - v52, RaycastParams_new_ret) == nil then
                    v46 = Vector3.new(0, 0, 0);
                else
                    for i, v in ipairs(u2) do
                        v47 = HumanoidRootPart.CFrame:PointToWorldSpace(v);
                        v48 = u21.muzzle.WorldCFrame.Position;
                        RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

                        if workspace:Raycast(v48, v47 - v48, RaycastParams_new_ret) == nil then
                            v46 = v;
                            break;
                        end;
                    end;

                    if v46 == nil and v45 then
                        v49 = HumanoidRootPart.Position;
                        v50 = u21.muzzle.WorldCFrame.Position;
                        RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

                        if workspace:Raycast(v50, v49 - v50, RaycastParams_new_ret) == nil then
                            v46 = Vector3.new(0, 0, 0);
                        end;
                    end;
                end;
            end;
        elseif v45 then
            for i, v in ipairs(u2) do
                v47 = HumanoidRootPart.CFrame:PointToWorldSpace(v);
                v48 = u21.muzzle.WorldCFrame.Position;
                RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

                if workspace:Raycast(v48, v47 - v48, RaycastParams_new_ret) == nil then
                    v46 = v;
                    break;
                end;
            end;

            if v46 == nil and v45 then
                v49 = HumanoidRootPart.Position;
                v50 = u21.muzzle.WorldCFrame.Position;
                RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

                if workspace:Raycast(v50, v49 - v50, RaycastParams_new_ret) == nil then
                    v46 = Vector3.new(0, 0, 0);
                end;
            end;
        else
            v51 = HumanoidRootPart.Position;
            v52 = u21.muzzle.WorldCFrame.Position;
            RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

            if workspace:Raycast(v52, v51 - v52, RaycastParams_new_ret) == nil then
                v46 = Vector3.new(0, 0, 0);
            else
                for i, v in ipairs(u2) do
                    v47 = HumanoidRootPart.CFrame:PointToWorldSpace(v);
                    v48 = u21.muzzle.WorldCFrame.Position;
                    RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

                    if workspace:Raycast(v48, v47 - v48, RaycastParams_new_ret) == nil then
                        v46 = v;
                        break;
                    end;
                end;

                if v46 == nil and v45 then
                    v49 = HumanoidRootPart.Position;
                    v50 = u21.muzzle.WorldCFrame.Position;
                    RaycastParams_new_ret.FilterDescendantsInstances = { u21.NPC, p44 };

                    if workspace:Raycast(v50, v49 - v50, RaycastParams_new_ret) == nil then
                        v46 = Vector3.new(0, 0, 0);
                    end;
                end;
            end;
        end;

        u41 = {
            at = os_clock_ret,
            target = p44,
            head = v45,
            offset = v46
        };

        if v46 then
            return v46 == "head" and Head.Position or HumanoidRootPart.CFrame:PointToWorldSpace(v46);
        end;

        return nil;
    end;

    local Health = u21.Humanoid.Health;
    local u53 = 0;
    u21.Humanoid.HealthChanged:Connect(function(p54) -- Line: 409
        -- upvalues: Health (ref), u21 (copy), u53 (ref)
        if p54 < Health - 0.01 then
            u21.NPC:SetAttribute("_SuppressedUntil", os.clock() + 2);
            local os_clock_ret = os.clock();

            if os_clock_ret - u53 >= 0.2 then
                u53 = os_clock_ret;
                pcall(function() -- Line: 415
                    -- upvalues: u21 (ref)
                    require(game:GetService("ServerScriptService"):WaitForChild("NPCVoicelines")).Play(u21.NPC, "Hit");
                end);
                local Torso = u21.NPC:FindFirstChild("Torso");

                if Torso then
                    Torso = Torso:FindFirstChild("Neck");
                end;

                if Torso then
                    local v55 = math.random(2) == 1 and 1 or -1;
                    local math_random_ret = math.random(0, 14);
                    local v56 = math.rad(math_random_ret) * v55;
                    local v57 = 18 + math.random(-3, 3);
                    local math_rad_ret = math.rad(v57);
                    Torso.C1 = Torso.C1 * CFrame.Angles(math_rad_ret, v56, 0);
                end;
            end;
        end;

        Health = p54;
    end);

    local function isSuppressed() -- Line: 433
        -- upvalues: u21 (copy)
        local Attribute = u21.NPC:GetAttribute("_SuppressedUntil");
        local v58;

        if Attribute == nil then
            v58 = false;
        else
            v58 = os.clock() < Attribute;
        end;

        return v58;
    end;

    local StanceRules = require(script.Parent.StanceRules);

    local function getStanceMult() -- Line: 440
        -- upvalues: u21 (copy), StanceRules (copy)
        return u21.NPC:GetAttribute("Stance") == "Crouch" and StanceRules.CROUCH_SPREAD_MULT or 1;
    end;

    local function isAirborne() -- Line: 450
        -- upvalues: u21 (copy)
        local Humanoid = u21.Humanoid;

        if not Humanoid then
            return false;
        end;

        local State = Humanoid:GetState();

        return (State == Enum.HumanoidStateType.Jumping or State == Enum.HumanoidStateType.Freefall) and true or Humanoid.FloorMaterial == Enum.Material.Air;
    end;

    local function playMuzzleFx() -- Line: 467
        -- upvalues: u21 (copy)
        local muzzle = u21.muzzle;

        if not muzzle then
            return;
        end;

        local v59 = math.random(10) <= 7;

        for _, child in ipairs(muzzle:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                if child:GetAttribute("EmitNumber") then
                    if string.find(child.Name, "Flash") then
                        if v59 then
                            child:Emit(child:GetAttribute("EmitNumber"));
                        end;
                    else
                        child:Emit(child:GetAttribute("EmitNumber"));
                    end;
                elseif child:FindFirstChild("Particles") then
                    if not string.find(child.Name, "Flash") or v59 then
                        child:Emit(child.Particles.Value);
                    end;
                elseif child.Name == "Smoke" then
                    child:Emit(10);
                elseif child.Name == "Flash" and v59 then
                    child:Emit(5);
                end;
            elseif child:IsA("Light") and v59 then
                child.Enabled = true;
                task.delay(0.05, function() -- Line: 490
                    -- upvalues: child (copy)
                    if child and child.Parent then
                        child.Enabled = false;
                    end;
                end);
            end;
        end;

        local Chamber = muzzle:FindFirstChild("Chamber");

        if Chamber then
            for _, child in ipairs(Chamber:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    if child:GetAttribute("EmitNumber") then
                        child:Emit(child:GetAttribute("EmitNumber"));
                    elseif child.Name == "Smoke" then
                        child:Emit(10);
                    elseif child.Name == "Flash" and v59 then
                        child:Emit(5);
                    end;
                end;
            end;
        end;
    end;

    local function pickSoundFrom(p60) -- Line: 512
        if not p60 or #p60:GetChildren() == 0 then
            return nil;
        end;

        local Children = p60:GetChildren();

        for i = 1, 4 do
            local v61 = Children[math.random(1, #Children)];

            if v61 and v61:IsA("Sound") then
                return v61;
            end;

            local _ = i;
        end;

        return nil;
    end;

    local function playLayer(p62, p63) -- Line: 523
        -- upvalues: u21 (copy)
        if not p62 then
            return;
        end;

        local v64 = p62:Clone();
        v64.Name = p62.Name .. p63;
        v64.PlaybackSpeed = p62.PlaybackSpeed + math.random(-5, 5) / 100;
        v64.Parent = u21.muzzle;
        v64:Play();
        game:GetService("Debris"):AddItem(v64, (math.max(0.5, (v64.TimeLength > 0 and v64.TimeLength or 1) + 0.5)));
    end;

    local function playFireSound() -- Line: 536
        -- upvalues: u21 (copy), playLayer (copy), pickSoundFrom (copy)
        local gunModel = u21.gunModel;

        if not gunModel then
            return;
        end;

        local v65 = gunModel:FindFirstChild("Grip") or gunModel:FindFirstChild("Base");

        if not v65 then
            return;
        end;

        local v66 = u21.NPC and u21.NPC:GetAttribute("Suppressed");
        local v67;

        if v66 then
            v67 = v65:FindFirstChild("SuppressorSounds");
        else
            v67 = nil;
        end;

        if not v67 or #v67:GetChildren() == 0 then
            v67 = v65:FindFirstChild("FireSounds");
        end;

        playLayer(pickSoundFrom(v67), v66 and "_NPCSup" or "_NPCFire");

        if not v66 then
            playLayer(pickSoundFrom(v65:FindFirstChild("BassSounds")), "_NPCBass");
            playLayer(pickSoundFrom(v65:FindFirstChild("MediumSounds")), "_NPCMed");
            playLayer(pickSoundFrom(v65:FindFirstChild("FarSounds")), "_NPCFar");
            playLayer(pickSoundFrom(v65:FindFirstChild("TailSounds")), "_NPCTail");
        end;
    end;

    local u68 = false;
    local u69 = false;
    local u70 = false;
    local u71 = false;
    local u72 = 0;
    local u73 = 0;
    local u74 = 0;
    local u75 = u21.wepStats.fireRate and u21.wepStats.fireRate > 0 and (60 / u21.wepStats.fireRate or 0.1) or 0.1;

    function u22.IsReloading() -- Line: 571
        -- upvalues: u70 (ref)
        return u70;
    end;

    function u22.IsChamberingBolt() -- Line: 572
        -- upvalues: u71 (ref)
        return u71;
    end;

    function u22.IsAiming() -- Line: 573
        -- upvalues: u68 (ref)
        return u68;
    end;

    function u22.HasAimed() -- Line: 574
        -- upvalues: u69 (ref)
        return u69;
    end;

    function u22.GetRecoil() -- Line: 575
        -- upvalues: u73 (ref), u74 (ref)
        return u73, u74;
    end;

    function u22.SetRecoil(p76, p77) -- Line: 576
        -- upvalues: u73 (ref), u74 (ref)
        u73 = p76;
        u74 = p77;
    end;

    function u22.GetWeaponState() -- Line: 578
        -- upvalues: NPC_Ammo (ref), u21 (copy), u70 (ref), u71 (ref)
        return NPC_Ammo.NeedsReload(u21.Weapon, u21.wepStats) and "needsReload" or (NPC_Ammo.NeedsChamber(u21.Weapon, u21.wepStats, u70, u71) and "needsChamber" or (NPC_Ammo.IsGunLoaded(u21.Weapon, u21.wepStats) and "ready" or "empty"));
    end;

    function u22.UpdateFacing(p78) -- Line: 585
        -- upvalues: u21 (copy)
        local Vector3_new_ret = Vector3.new(p78.X, u21.HumanoidRootPart.Position.Y, p78.Z);
        u21.targetAttachment.WorldCFrame = CFrame.lookAt(u21.HumanoidRootPart.Position, Vector3_new_ret);
    end;

    local function GetMuzzleAngleToTarget(p79) -- Line: 590
        -- upvalues: u21 (copy)
        local WorldCFrame = u21.muzzle.WorldCFrame;
        local v80 = p79 - WorldCFrame.Position;

        if v80.Magnitude < 0.001 then
            return 0;
        end;

        local v81 = WorldCFrame.LookVector:Dot(v80.Unit);
        local math_clamp_ret = math.clamp(v81, -1, 1);
        local math_acos_ret = math.acos(math_clamp_ret);

        return math.deg(math_acos_ret);
    end;

    local function GetAngleToTarget(p82) -- Line: 599
        -- upvalues: u21 (copy)
        local v83 = p82 - u21.HumanoidRootPart.Position;
        local Vector3_new_ret = Vector3.new(v83.X, 0, v83.Z);

        if Vector3_new_ret.Magnitude < 0.001 then
            return 0;
        end;

        local Unit = Vector3_new_ret.Unit;
        local LookVector = u21.HumanoidRootPart.CFrame.LookVector;
        local Vector3_new_ret2 = Vector3.new(LookVector.X, 0, LookVector.Z);

        if Vector3_new_ret2.Magnitude < 0.001 then
            return 180;
        end;

        local v84 = Vector3_new_ret2.Unit:Dot(Unit);
        local math_clamp_ret = math.clamp(v84, -1, 1);
        local math_acos_ret = math.acos(math_clamp_ret);

        return math.deg(math_acos_ret);
    end;

    local u85 = 0;

    function u22.StopAiming(p86) -- Line: 616
        -- upvalues: u85 (ref), u21 (copy), u69 (ref), u68 (ref)
        u85 = u85 + 1;

        if not p86 then
            u21.alignOrientation.Enabled = false;
            u21.Humanoid.AutoRotate = true;
            u69 = false;
        end;

        u68 = false;
        u21.setTrack(u21.tracks.aim, false);
    end;

    local function aimPoint() -- Line: 629
        -- upvalues: u21 (copy)
        if u21.AimPoint then
            return u21.AimPoint();
        end;

        local Value = u21.CharacterAsset.Target.Value;

        if Value then
            Value = Value:FindFirstChild("HumanoidRootPart");
        end;

        return Value and Value.Position or nil;
    end;

    function u22.Aim() -- Line: 636
        -- upvalues: u68 (ref), u70 (ref), u71 (ref), u69 (ref), u85 (ref), ensureRigIdlePlaying (ref), u21 (copy), npcConfig (copy), u22 (copy), GetAngleToTarget (copy), u73 (ref), u74 (ref)
        if u68 or (u70 or u71) then
            return;
        end;

        u68 = true;
        u69 = false;
        u85 = u85 + 1;
        local v87 = u85;
        ensureRigIdlePlaying(u21);
        u21.Humanoid.AutoRotate = false;
        u21.alignOrientation.Enabled = true;
        u21.setTrack(u21.tracks.aim, true);
        task.wait(0.05);

        if u85 ~= v87 then
            return;
        end;

        local v88 = tick();
        local math_min_ret = math.min(npcConfig.AIM_TIMEOUT, 0.8);
        local math_max_ret = math.max(npcConfig.AIM_ALIGN_THRESHOLD_DEG, npcConfig.AIM_FIRE_THRESHOLD_DEG or 0);

        while u21.IsActive and tick() - v88 < math_min_ret do
            if u21.CharacterAsset.Target.Value == nil or not u21.CharacterAsset.Target.Value:FindFirstChild("HumanoidRootPart") then
                u22.StopAiming();

                return;
            end;

            local v89;

            if u21.AimPoint then
                v89 = u21.AimPoint();
            else
                local Value = u21.CharacterAsset.Target.Value;

                if Value then
                    Value = Value:FindFirstChild("HumanoidRootPart");
                end;

                v89 = Value and Value.Position or nil;
            end;

            if not v89 then
                u22.StopAiming();

                return;
            end;

            u22.UpdateFacing(v89);
            local v90 = GetAngleToTarget(v89);
            local WorldCFrame = u21.muzzle.WorldCFrame;
            local v91 = v89 - WorldCFrame.Position;
            local v92;

            if v91.Magnitude < 0.001 then
                v92 = 0;
            else
                local v93 = WorldCFrame.LookVector:Dot(v91.Unit);
                local math_clamp_ret = math.clamp(v93, -1, 1);
                local math_acos_ret = math.acos(math_clamp_ret);
                v92 = math.deg(math_acos_ret);
            end;

            if v90 <= math_max_ret and v92 <= math_max_ret then
                u68 = false;
                u73 = 0;
                u74 = 0;
                u69 = true;

                return;
            end;

            task.wait(0.05);

            if u85 ~= v87 then
                return;
            end;
        end;

        local v94;

        if u21.AimPoint then
            v94 = u21.AimPoint();
        else
            local Value = u21.CharacterAsset.Target.Value;

            if Value then
                Value = Value:FindFirstChild("HumanoidRootPart");
            end;

            v94 = Value and Value.Position or nil;
        end;

        if v94 then
            local WorldCFrame = u21.muzzle.WorldCFrame;
            local v95 = v94 - WorldCFrame.Position;
            local v96;

            if v95.Magnitude < 0.001 then
                v96 = 0;
            else
                local v97 = WorldCFrame.LookVector:Dot(v95.Unit);
                local math_clamp_ret = math.clamp(v97, -1, 1);
                local math_acos_ret = math.acos(math_clamp_ret);
                v96 = math.deg(math_acos_ret);
            end;

            if v96 <= npcConfig.AIM_FIRE_THRESHOLD_DEG * 1.5 then
                u68 = false;
                u73 = 0;
                u74 = 0;
                u69 = true;

                return;
            end;
        end;

        u68 = false;
        u69 = false;
    end;

    function u22.ShootGun() -- Line: 713
        -- upvalues: u72 (ref), u75 (copy), u21 (copy), u29 (ref), u28 (ref), u23 (copy), pickAimPoint (copy), npcConfig (copy), NPC_Ammo (ref), ensureRigIdlePlaying (ref), playFireSound (copy), playMuzzleFx (copy), u73 (ref), u74 (ref), u6 (ref), u5 (ref), getRankMult (copy), StanceRules (copy), NpcSight (ref), NpcAimSpread (ref), serverSideShoot (ref), u30 (ref)
        local os_clock_ret = os.clock();

        if os_clock_ret - u72 < u75 then
            return;
        end;

        local Humanoid = u21.Humanoid;
        local v98;

        if Humanoid then
            local State = Humanoid:GetState();
            v98 = (State == Enum.HumanoidStateType.Jumping or State == Enum.HumanoidStateType.Freefall) and true or Humanoid.FloorMaterial == Enum.Material.Air;
        else
            v98 = false;
        end;

        if v98 then
            return;
        end;

        local v99;

        if os.clock() < u29 then
            v99 = false;
        elseif u28 <= 0 then
            if u23 == "semi" then
                u28 = 1;
                v99 = true;
            elseif u23 == "fullauto" then
                u28 = math.random(8, 14);
                v99 = true;
            else
                u28 = math.random(3, 5);
                v99 = true;
            end;
        else
            v99 = true;
        end;

        if not v99 then
            return;
        end;

        local v100 = pickAimPoint(u21.CharacterAsset.Target.Value);

        if not v100 then
            return;
        end;

        local WorldCFrame = u21.muzzle.WorldCFrame;
        local v101 = v100 - WorldCFrame.Position;
        local v102;

        if v101.Magnitude < 0.001 then
            v102 = 0;
        else
            local v103 = WorldCFrame.LookVector:Dot(v101.Unit);
            local math_clamp_ret = math.clamp(v103, -1, 1);
            local math_acos_ret = math.acos(math_clamp_ret);
            v102 = math.deg(math_acos_ret);
        end;

        if not npcConfig.CommitToTarget and npcConfig.AIM_FIRE_THRESHOLD_DEG < v102 then
            return;
        end;

        local Attribute = u21.NPC:GetAttribute("_SuppressedUntil");
        local v104;

        if Attribute == nil then
            v104 = false;
        else
            v104 = os.clock() < Attribute;
        end;

        if v104 and math.random() < 0.5 then
            return;
        end;

        if not NPC_Ammo.ConsumeAmmo(u21.Weapon, u21.wepStats) then
            return;
        end;

        u72 = os_clock_ret;
        ensureRigIdlePlaying(u21);
        playFireSound();
        playMuzzleFx();
        local recoil = u21.wepStats.recoil;
        local v105 = recoil and (recoil.vertical or 1) or 1;
        local v106 = recoil and recoil.horizontal or 0.5;
        local v107 = math.random(2) == 1 and 1 or -1;
        u73 = math.min(u73 + v105, 6);
        u74 = math.clamp(u74 + v106 * v107, -30, 30);
        local Attribute2 = u21.NPC:GetAttribute("_SuppressedUntil");
        local v108;

        if Attribute2 == nil then
            v108 = false;
        else
            v108 = os.clock() < Attribute2;
        end;

        local v109 = u6[u21.NPC and u21.NPC:GetAttribute("AllyTag") or ""];
        local v110 = (v108 and 8.5 or 5.5) * (u23 == "semi" and 0.5 or (u23 == "fullauto" and 1.6 or 1)) * (v109 and u5[v109] or 1) * getRankMult() * (u21.NPC:GetAttribute("Stance") == "Crouch" and (StanceRules.CROUCH_SPREAD_MULT or 1) or 1) * NpcSight.ConcealSpreadMult(u21.Concealment);
        local Unit = (v100 + NpcAimSpread.Offset(u21.HumanoidRootPart.Position, v100, Random.new():NextNumber(-v110, v110), Random.new():NextNumber(-v110, v110)) - u21.HumanoidRootPart.Position).Unit;
        local ShootEvent = u21.NPC:FindFirstChild("ShootEvent");

        if ShootEvent then
            ShootEvent:Fire(Unit);
        end;

        serverSideShoot.Fire(u21.NPC, u21.wepStats, u21.muzzle.WorldCFrame.Position, Unit, { u21.NPC }, u21.NPC:FindFirstChildOfClass("Tool"));
        u28 = u28 - 1;

        if u28 <= 0 then
            u28 = 0;
            u30 = u30 + 1;
            local v111, v112;

            if u23 == "semi" then
                v111 = 0.3;
                v112 = 0.6;
            elseif u23 == "fullauto" then
                v111 = 0.2;
                v112 = 0.45;
            else
                v111 = 0.4;
                v112 = 0.8;
            end;

            u29 = os.clock() + v111 + math.random() * (v112 - v111);
        end;
    end;

    function u22.FaceAt(p113) -- Line: 778
        -- upvalues: u21 (copy), u22 (copy)
        u21.Humanoid.AutoRotate = false;
        u21.alignOrientation.Enabled = true;
        u21.setTrack(u21.tracks.aim, true);
        u22.UpdateFacing(p113);
    end;

    function u22.BurstsFired() -- Line: 784
        -- upvalues: u30 (ref)
        return u30;
    end;

    function u22.ShootAt(p114, p115) -- Line: 788
        -- upvalues: u72 (ref), u75 (copy), u21 (copy), u70 (ref), u71 (ref), npcConfig (copy), u29 (ref), u28 (ref), u23 (copy), NPC_Ammo (ref), ensureRigIdlePlaying (ref), playFireSound (copy), playMuzzleFx (copy), u73 (ref), u74 (ref), u6 (ref), u5 (ref), getRankMult (copy), StanceRules (copy), NpcAimSpread (ref), serverSideShoot (ref), u30 (ref)
        local os_clock_ret = os.clock();

        if os_clock_ret - u72 < u75 then
            return false;
        end;

        local Humanoid = u21.Humanoid;
        local v116;

        if Humanoid then
            local State = Humanoid:GetState();
            v116 = (State == Enum.HumanoidStateType.Jumping or State == Enum.HumanoidStateType.Freefall) and true or Humanoid.FloorMaterial == Enum.Material.Air;
        else
            v116 = false;
        end;

        if v116 then
            return false;
        end;

        if u70 or u71 then
            return false;
        end;

        local WorldCFrame = u21.muzzle.WorldCFrame;
        local v117 = p114 - WorldCFrame.Position;
        local v118;

        if v117.Magnitude < 0.001 then
            v118 = 0;
        else
            local v119 = WorldCFrame.LookVector:Dot(v117.Unit);
            local math_clamp_ret = math.clamp(v119, -1, 1);
            local math_acos_ret = math.acos(math_clamp_ret);
            v118 = math.deg(math_acos_ret);
        end;

        if npcConfig.AIM_FIRE_THRESHOLD_DEG * 1.5 < v118 then
            return false;
        end;

        local v120;

        if os.clock() < u29 then
            v120 = false;
        elseif u28 <= 0 then
            if u23 == "semi" then
                u28 = 1;
                v120 = true;
            elseif u23 == "fullauto" then
                u28 = math.random(8, 14);
                v120 = true;
            else
                u28 = math.random(3, 5);
                v120 = true;
            end;
        else
            v120 = true;
        end;

        if not v120 then
            return false;
        end;

        local Attribute = u21.NPC:GetAttribute("_SuppressedUntil");
        local v121;

        if Attribute == nil then
            v121 = false;
        else
            v121 = os.clock() < Attribute;
        end;

        if v121 and math.random() < 0.5 then
            return false;
        end;

        if not NPC_Ammo.ConsumeAmmo(u21.Weapon, u21.wepStats) then
            return false;
        end;

        u72 = os_clock_ret;
        ensureRigIdlePlaying(u21);
        playFireSound();
        playMuzzleFx();
        local recoil = u21.wepStats.recoil;
        local v122 = recoil and (recoil.vertical or 1) or 1;
        local v123 = recoil and recoil.horizontal or 0.5;
        local v124 = math.random(2) == 1 and 1 or -1;
        u73 = math.min(u73 + v122, 6);
        u74 = math.clamp(u74 + v123 * v124, -30, 30);
        local Attribute2 = u21.NPC:GetAttribute("_SuppressedUntil");
        local v125;

        if Attribute2 == nil then
            v125 = false;
        else
            v125 = os.clock() < Attribute2;
        end;

        local v126 = u6[u21.NPC and u21.NPC:GetAttribute("AllyTag") or ""];
        local v127 = (v125 and 8.5 or 5.5) * (u23 == "semi" and 0.5 or (u23 == "fullauto" and 1.6 or 1)) * (v126 and u5[v126] or 1) * getRankMult() * (u21.NPC:GetAttribute("Stance") == "Crouch" and (StanceRules.CROUCH_SPREAD_MULT or 1) or 1) * (p115 or 1);
        local Unit = (p114 + NpcAimSpread.Offset(u21.HumanoidRootPart.Position, p114, Random.new():NextNumber(-v127, v127), Random.new():NextNumber(-v127, v127)) - u21.HumanoidRootPart.Position).Unit;
        local ShootEvent = u21.NPC:FindFirstChild("ShootEvent");

        if ShootEvent then
            ShootEvent:Fire(Unit);
        end;

        serverSideShoot.Fire(u21.NPC, u21.wepStats, u21.muzzle.WorldCFrame.Position, Unit, { u21.NPC }, u21.NPC:FindFirstChildOfClass("Tool"));
        u28 = u28 - 1;

        if u28 <= 0 then
            u28 = 0;
            u30 = u30 + 1;
            local v128, v129;

            if u23 == "semi" then
                v128 = 0.3;
                v129 = 0.6;
            elseif u23 == "fullauto" then
                v128 = 0.2;
                v129 = 0.45;
            else
                v128 = 0.4;
                v129 = 0.8;
            end;

            u29 = os.clock() + v128 + math.random() * (v129 - v128);
        end;

        return true;
    end;

    function u22.ShootGunWhileMoving() -- Line: 825
        -- upvalues: u72 (ref), u75 (copy), u21 (copy), u29 (ref), u28 (ref), u23 (copy), NPC_Ammo (ref), pickAimPoint (copy), npcConfig (copy), ensureRigIdlePlaying (ref), playFireSound (copy), playMuzzleFx (copy), u73 (ref), u74 (ref), u6 (ref), u5 (ref), getRankMult (copy), StanceRules (copy), NpcAimSpread (ref), serverSideShoot (ref), u30 (ref)
        local os_clock_ret = os.clock();

        if os_clock_ret - u72 < u75 then
            return;
        end;

        local Humanoid = u21.Humanoid;
        local v130;

        if Humanoid then
            local State = Humanoid:GetState();
            v130 = (State == Enum.HumanoidStateType.Jumping or State == Enum.HumanoidStateType.Freefall) and true or Humanoid.FloorMaterial == Enum.Material.Air;
        else
            v130 = false;
        end;

        if v130 then
            return;
        end;

        local v131;

        if os.clock() < u29 then
            v131 = false;
        elseif u28 <= 0 then
            if u23 == "semi" then
                u28 = 1;
                v131 = true;
            elseif u23 == "fullauto" then
                u28 = math.random(8, 14);
                v131 = true;
            else
                u28 = math.random(3, 5);
                v131 = true;
            end;
        else
            v131 = true;
        end;

        if not v131 then
            return;
        end;

        if not NPC_Ammo.IsGunLoaded(u21.Weapon, u21.wepStats) then
            return;
        end;

        local v132 = pickAimPoint(u21.CharacterAsset.Target.Value);

        if not v132 then
            return;
        end;

        local WorldCFrame = u21.muzzle.WorldCFrame;
        local v133 = v132 - WorldCFrame.Position;

        if v133.Magnitude < 0.001 then
            return;
        end;

        local v134 = WorldCFrame.LookVector:Dot(v133.Unit);
        local math_clamp_ret = math.clamp(v134, -1, 1);
        local math_acos_ret = math.acos(math_clamp_ret);

        if math.deg(math_acos_ret) > npcConfig.AIM_MOVING_THRESHOLD then
            return;
        end;

        local Attribute = u21.NPC:GetAttribute("_SuppressedUntil");
        local v135;

        if Attribute == nil then
            v135 = false;
        else
            v135 = os.clock() < Attribute;
        end;

        if v135 and math.random() < 0.5 then
            return;
        end;

        if not NPC_Ammo.ConsumeAmmo(u21.Weapon, u21.wepStats) then
            return;
        end;

        u72 = os_clock_ret;
        ensureRigIdlePlaying(u21);
        playFireSound();
        playMuzzleFx();
        local recoil = u21.wepStats.recoil;
        local v136 = recoil and (recoil.vertical or 1) or 1;
        local v137 = recoil and recoil.horizontal or 0.5;
        local v138 = math.random(2) == 1 and 1 or -1;
        u73 = math.min(u73 + v136, 6);
        u74 = math.clamp(u74 + v137 * v138, -30, 30);
        local Unit = v133.Unit;
        local v139 = u6[u21.NPC and u21.NPC:GetAttribute("AllyTag") or ""];
        local v140 = ((u23 == "semi" and 0.5 or (u23 == "fullauto" and 1.6 or 1)) * (v139 and u5[v139] or 1) * getRankMult() * (u21.NPC:GetAttribute("Stance") == "Crouch" and (StanceRules.CROUCH_SPREAD_MULT or 1) or 1) - 1) * 2;

        if v140 > 0 then
            Unit = NpcAimSpread.Jitter(Unit, v140 * 0.05);
        end;

        local Attribute2 = u21.NPC:GetAttribute("_SuppressedUntil");
        local v141;

        if Attribute2 == nil then
            v141 = false;
        else
            v141 = os.clock() < Attribute2;
        end;

        if v141 then
            Unit = NpcAimSpread.Jitter(Unit, 0.15000000000000002);
        end;

        local ShootEvent = u21.NPC:FindFirstChild("ShootEvent");

        if ShootEvent then
            ShootEvent:Fire(Unit);
        end;

        serverSideShoot.Fire(u21.NPC, u21.wepStats, u21.muzzle.WorldCFrame.Position, Unit, { u21.NPC }, u21.NPC:FindFirstChildOfClass("Tool"));
        u28 = u28 - 1;

        if u28 <= 0 then
            u28 = 0;
            u30 = u30 + 1;
            local v142, v143;

            if u23 == "semi" then
                v142 = 0.3;
                v143 = 0.6;
            elseif u23 == "fullauto" then
                v142 = 0.2;
                v143 = 0.45;
            else
                v142 = 0.4;
                v143 = 0.8;
            end;

            u29 = os.clock() + v142 + math.random() * (v143 - v142);
        end;
    end;

    function u22.PerformReload() -- Line: 885
        -- upvalues: u70 (ref), u21 (copy), u69 (ref), NPC_Ammo (ref)
        if u70 then
            return;
        end;

        u70 = true;
        u21.setTrack(u21.tracks.aim, false);
        u69 = false;
        local v144 = u21.wepStats.reloadSpeedModifier or 1;

        if u21.wepStats.operationType == 3 and u21.tracks.boltOpen then
            u21.tracks.boltOpen:Play(0.05, 1, v144);
            task.wait((u21.tracks.boltOpen.Length or 0.5) / v144);
        end;

        local v145 = u21.Weapon.Ammo and u21.Weapon.Ammo:FindFirstChild("MagAmmo");
        local clipReload = u21.tracks.clipReload;

        if clipReload then
            if v145 then
                clipReload = v145.Value == 0;
            else
                clipReload = v145;
            end;
        end;

        local v146 = clipReload and u21.tracks.clipReload or u21.tracks.reload;

        if u21.wepStats.magType == 2 and (v146 and v145) then
            for i = 1, v145.MaxValue - v145.Value do
                if not u21.IsActive then
                    break;
                end;

                v146:Play(0.05, 1, v144);
                task.wait((v146.Length or 0.5) / v144);
                local _ = i;
            end;
        else
            local v147;

            if v146 then
                v146:Play(0.05, 1, v144);
                v147 = (v146.Length or 1.6) / v144;
            else
                v147 = 1.6;
            end;

            task.wait(v147);
        end;

        NPC_Ammo.Reload(u21.Weapon, u21.wepStats);

        if u21.wepStats.operationType == 4 then
            u21.Weapon.BoltReady.Value = true;
        end;

        if u21.wepStats.operationType == 3 then
            local Chambered = u21.Weapon:FindFirstChild("Chambered");
            local v148 = u21.Weapon.Ammo and u21.Weapon.Ammo:FindFirstChild("MagAmmo");

            if clipReload then
                if Chambered and (v148 and v148.Value > 0) then
                    Chambered.Value = true;
                    v148.Value = v148.Value - 1;
                end;

                u21.Weapon.BoltReady.Value = true;
            elseif u21.tracks.boltClose then
                u21.tracks.boltClose:Play(0.05, 1, v144);
                task.wait((u21.tracks.boltClose.Length or 0.5) / v144);

                if Chambered and (v148 and v148.Value > 0) then
                    Chambered.Value = true;
                    v148.Value = v148.Value - 1;
                end;

                u21.Weapon.BoltReady.Value = true;
            end;
        end;

        if v146 then
            v146:Stop();
        end;

        u70 = false;
    end;

    function u22.PerformChamber() -- Line: 948
        -- upvalues: u70 (ref), u71 (ref), u21 (copy)
        if u70 or u71 then
            return;
        end;

        u71 = true;

        local function finishChamber() -- Line: 952
            -- upvalues: u21 (ref), u71 (ref)
            local v149 = u21.Weapon.BoltReady.Value and u21.tracks.boltChamber or u21.tracks.boltClose;

            if not v149 then
                u71 = false;

                return;
            end;

            v149:Play(0.05);
            v149.Stopped:Once(function() -- Line: 956
                -- upvalues: u21 (ref), u71 (ref)
                local Chambered = u21.Weapon:FindFirstChild("Chambered");
                local v150 = u21.Weapon.Ammo and u21.Weapon.Ammo:FindFirstChild("MagAmmo");

                if Chambered and (v150 and v150.Value > 0) then
                    Chambered.Value = true;
                    v150.Value = v150.Value - 1;
                end;

                u21.Weapon.BoltReady.Value = true;
                u71 = false;
            end);
        end;

        if not ((u21.wepStats.operationType == 2 or u21.wepStats.operationType == 3) and u21.tracks.boltOpen) then
            finishChamber();

            return;
        end;

        u21.tracks.boltOpen:Play(0.05);
        u21.tracks.boltOpen.Stopped:Once(finishChamber);
    end;

    function u22.DecayRecoil(p151) -- Line: 979
        -- upvalues: u73 (ref), u74 (ref)
        u73 = math.max(0, u73 - p151 * 4);
        u74 = math.abs(u74) < 0.01 and 0 or u74 - u74 * p151 * 4;

        if u73 < 0.01 then
            u73 = 0;
        end;

        return u73, u74;
    end;

    return u22;
end;

return v1;