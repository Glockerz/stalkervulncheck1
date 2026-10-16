-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local DeathCause = require(game:GetService("ReplicatedStorage"):WaitForChild("DeathCause"));
local SPH_Assets = ReplicatedStorage.SPH_Assets;
local Modules = SPH_Assets.Modules;
local GameConfig = require(SPH_Assets.GameConfig);
local u2 = require(Modules.BridgeNet).CreateBridge("ReplicateHit");
local ExplosionFX = require(Modules.ExplosionFX);
local FractureGlass = require(Modules.FractureGlass);
local ObjectDestruction = require(Modules.ObjectDestruction);
local Gunsmith = require(Modules.Gunsmith);
local PierceMod = require(Modules.PierceMod);
local NpcFriendlyFire = require(ReplicatedStorage:WaitForChild("spawnNpc"):WaitForChild("NpcFriendlyFire"));
local u3 = nil;

local function AttackerRegistry() -- Line: 26
    -- upvalues: u3 (ref)
    if u3 == nil then
        local success, result = pcall(function() -- Line: 28
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCAttackerRegistry", 5));
        end);
        u3 = success and result and result or false;
    end;

    return u3 or nil;
end;

local PartCache = require(Modules.PartCache);
local FastCast = require(Modules.FastCast);
local DTS_Assets = ReplicatedStorage:FindFirstChild("DTS_Assets");
local u4;

if DTS_Assets then
    u4 = require(DTS_Assets.Modules.Antitank);
else
    u4 = nil;
end;

local SPH_Workspace = workspace:WaitForChild("SPH_Workspace");
local Folder = Instance.new("Folder");
Folder.Name = "ServerCache";
Folder.Parent = SPH_Workspace;
local Folder2 = Instance.new("Folder");
Folder2.Name = "ServerProjectiles";
Folder2.Parent = SPH_Workspace;
local Part = Instance.new("Part");
Part.Name = "ServerBullet";
Part.Size = Vector3.new(0.2, 0.2, 0.2);
Part.Transparency = 1;
Part.Anchored = true;
Part.CanCollide = false;
Part.CanQuery = false;
Part.CanTouch = false;
local u5 = PartCache.new(Part, 100, Folder);
local u6 = FastCast.new();

local function ProcessHit(p7, p8, p9, p10, p11, p12) -- Line: 77
    -- upvalues: ExplosionFX (copy), NpcFriendlyFire (copy), u4 (ref), GameConfig (copy), SPH_Assets (copy), u2 (copy), ReplicatedStorage (copy), DeathCause (copy), u3 (ref), CollectionService (copy), FractureGlass (copy), Debris (copy), ObjectDestruction (copy)
    if not (p7 and p7.Instance) then
        return;
    end;

    local Instance2 = p7.Instance;

    if not (Instance2 and Instance2.Parent) then
        return;
    end;

    local v13;

    if p9 then
        if p9.explosiveAmmo then
            v13 = p9;
        else
            v13 = p8;
        end;
    else
        v13 = p8;
    end;

    if v13.explosiveAmmo then
        local explosionRadius = p8.explosionRadius;
        local explosionEffect = p8.explosionEffect;

        if p9 and p9.explosiveAmmo then
            explosionRadius = p9.explosionRadius;
            explosionEffect = p9.explosionEffect;
        end;

        ExplosionFX(p7.Position, explosionRadius, explosionEffect, nil, false, v13);

        return;
    end;

    if NpcFriendlyFire.IsAllyHit(p11, Instance2) then
        return;
    end;

    local v14 = Instance2.Parent:FindFirstChildWhichIsA("Humanoid");
    local v15 = p8.damage[Instance2.Name] or p8.damage.Other;

    if Instance2.Name == "HumanoidRootPart" then
        v15 = p8.damage.UpperTorso or p8.damage.Torso;
    end;

    if p9 and p9.damage then
        v15 = v15 * (p9.damage[Instance2.Name] or p9.damage.Other);

        if Instance2.Name == "HumanoidRootPart" then
            v15 = p9.damage.Torso;
        end;
    end;

    if u4 and p8.ATCanDamage then
        local math_random_ret = math.random(p8.ATDefaultPen[1], p8.ATDefaultPen[2]);
        local math_random_ret2 = math.random(p8.ATDefaultDamage[1], p8.ATDefaultDamage[2]);
        local v16;

        if GameConfig.useBulletForce then
            v16 = Vector3.new(0, 0, -p8.bulletForce or 0) or nil;
        else
            v16 = nil;
        end;

        if Instance2 and Instance2:HasTag("Dragoon_Armor") then
            u4.DamageVehicle(nil, Instance2, math_random_ret, math_random_ret2, v16, true);
        elseif Instance2:HasTag("Dragoon_Armor") or Instance2:HasTag("PropSystem_Armor") then
            if Instance2:HasTag("PropSystem_Armor") then
                u4.DamageProp(nil, Instance2, math_random_ret, math_random_ret2, v16, true);
            end;
        else
            u4.DamageMisc(nil, Instance2, Instance2.Position, nil, math_random_ret, math_random_ret2, math_random_ret2, v16, true);
        end;
    end;

    local v17;

    if v13.customBehavior and SPH_Assets.CustomBehaviors:FindFirstChild(v13.customBehavior) then
        v17 = require(SPH_Assets.CustomBehaviors:FindFirstChild(v13.customBehavior));
    else
        v17 = nil;
    end;

    if v17 then
        v17.OnProjectileHit(Instance2, v14, nil, v15);
    end;

    local v18 = nil;

    if p9 and p9.customBehaviors then
        for _, v in pairs(p9.customBehaviors) do
            if SPH_Assets.CustomBehaviors:FindFirstChild(v) then
                v18 = require(SPH_Assets.CustomBehaviors:FindFirstChild(v));
            end;

            if v18 then
                v18.OnProjectileHit(Instance2, v14, nil, v15);
            end;
        end;
    end;

    if v17 and table.find(v17.Overrides, "OnProjectileHit") then
        return;
    end;

    if v18 and table.find(v18.Overrides, "OnProjectileHit") then
        return;
    end;

    if p12 then
        u2:FireAllInRange(p7.Position, GameConfig.maxHitDistance, p12, {
            Position = p7.Position,
            Normal = p7.Normal,
            Instance = p7.Instance
        });
    end;

    if v14 and v14.Health > 0 then
        local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
        local v19 = 0;

        if p12 then
            local Attribute = p12:GetAttribute("LoadedRounds");

            if Attribute then
                local HttpService = game:GetService("HttpService");
                local success, result = pcall(function() -- Line: 182
                    -- upvalues: HttpService (copy), Attribute (copy)
                    return HttpService:JSONDecode(Attribute);
                end);

                if success and (result and result[1]) then
                    local v20 = ItemDatabase.RoundTypes and ItemDatabase.RoundTypes[result[1]];
                    v19 = v20 and (v20.Penetration or 0) or v19;
                end;
            end;
        end;

        local v21 = math.floor((v19 or 0) / 10) + 1;
        local math_clamp_ret = math.clamp(v21, 1, 4);
        local PlayerFromCharacter = game:GetService("Players"):GetPlayerFromCharacter(v14.Parent);

        if PlayerFromCharacter and Instance2.Name == "Head" then
            v15 = math.min(v15, 60);
        end;

        v15 = require(game:GetService("ServerScriptService"):WaitForChild("ArmorSystem")).ApplyDamage(PlayerFromCharacter, Instance2.Name, v15, math_clamp_ret, v14.Parent, "Ballistic");

        if v14.Health > 0 and v14.Health - v15 <= 0 then
            local StringValue = Instance.new("StringValue", v14.Parent);
            StringValue.Name = "Killer";
            StringValue.Value = p11 and (p11.Name or "NPC") or "NPC";
        end;

        if v14.Parent then
            local Tag = DeathCause.Tag;
            local Parent = v14.Parent;
            local v22 = p11 and (p11:GetAttribute("Faction") or "npc") or "npc";
            Tag(Parent, (tostring(v22)));

            if p11 then
                if u3 == nil then
                    local success, result = pcall(function() -- Line: 28
                        return require(game:GetService("ServerScriptService"):WaitForChild("NPCAttackerRegistry", 5));
                    end);
                    u3 = success and result and result or false;
                end;

                if u3 or nil then
                    if u3 == nil then
                        local success, result = pcall(function() -- Line: 28
                            return require(game:GetService("ServerScriptService"):WaitForChild("NPCAttackerRegistry", 5));
                        end);
                        u3 = success and result and result or false;
                    end;

                    (u3 or nil).SetAttacker(v14.Parent, p11, true);
                end;
            end;
        end;

        v14:TakeDamage(v15);
    elseif (Instance2.Name == "Glass" or CollectionService:HasTag(Instance2, "BreakableGlass")) and (GameConfig.glassShatter and not Instance2:GetAttribute("Shattered")) then
        Instance2:SetAttribute("Shattered", true);
        local Position = p7.Position;
        local v23 = Instance2:Clone();
        v23.Name = "TempGlass";
        v23.Parent = workspace;
        local Transparency = Instance2.Transparency;
        local CanCollide = Instance2.CanCollide;
        local CanQuery = Instance2.CanQuery;
        local CanTouch = Instance2.CanTouch;
        Instance2.Transparency = 1;
        Instance2.CanCollide = false;
        Instance2.CanQuery = false;
        Instance2.CanTouch = false;
        delay(GameConfig.glassRespawnTime, function() -- Line: 236
            -- upvalues: Instance2 (copy), Transparency (copy), CanCollide (copy), CanQuery (copy), CanTouch (copy)
            if Instance2 and Instance2.Parent then
                Instance2.Transparency = Transparency;
                Instance2.CanCollide = CanCollide;
                Instance2.CanQuery = CanQuery;
                Instance2.CanTouch = CanTouch;
                Instance2:SetAttribute("Shattered", false);
            end;
        end);

        if Instance2:IsA("Part") and Instance2.Shape == Enum.PartType.Block or Instance2:IsA("WedgePart") then
            FractureGlass(v23, Position, p10 and p10.LookVector * 10 or Vector3.new(0, 0, 0));
        else
            v23:Destroy();
        end;

        local Attachment = Instance.new("Attachment", workspace.Terrain);
        Attachment.WorldPosition = Position;
        local v24 = SPH_Assets.Sounds.GlassBreak:GetChildren()[math.random(#SPH_Assets.Sounds.GlassBreak:GetChildren())]:Clone();
        v24.Parent = Attachment;
        v24:Play();
        Debris:AddItem(Attachment, v24.TimeLength);
    elseif not (Instance2.Anchored or not GameConfig.useBulletForce or (not v14 or v14.Health > 0) and v14) then
        local Attachment = Instance.new("Attachment", Instance2);
        Attachment.WorldCFrame = CFrame.new(p7.Position) * (p10 and p10 - p10.Position or CFrame.new());
        local VectorForce = Instance.new("VectorForce", Attachment);
        VectorForce.Attachment0 = Attachment;
        local v25 = p8.bulletForce or 0;

        if p9 and p9.bulletForce then
            v25 = v25 * p9.bulletForce;
        end;

        VectorForce.Force = Vector3.new(0, 0, -v25);
        Debris:AddItem(Attachment, 0.1);
    end;

    local v26 = nil;

    if Instance2.Parent:HasTag("SPH_Destructible") then
        Instance2 = Instance2.Parent;
    elseif not Instance2:HasTag("SPH_Destructible") then
        Instance2 = v26;
    end;

    if Instance2 and not Instance2:GetAttribute("Destroyed") then
        local Attribute = Instance2:GetAttribute("HP");
        Instance2:SetAttribute("HP", Attribute - v15);

        if Attribute - v15 <= 0 then
            ObjectDestruction.DestroyObject(Instance2);
        end;
    end;
end;

u6.LengthChanged:Connect(function(p27, p28, p29, p30, p31, p32) -- Line: 290
    if not p32 then
        return;
    end;

    local v33 = p32.Size.Z / 2;
    p32.CFrame = CFrame.new(p28, p28 + p29) * CFrame.new(0, 0, -(p30 - v33));
end);
u6.RayHit:Connect(function(p34, p35, p36, p37) -- Line: 298
    -- upvalues: ProcessHit (copy), u1 (copy)
    local Tool = p34.UserData.Tool;

    if not (Tool and Tool:FindFirstChild("SPH_Weapon")) then
        return;
    end;

    local WepStats = p34.UserData.WepStats;
    local NPCModel = p34.UserData.NPCModel;
    ProcessHit(p35, WepStats, p34.UserData.AttStats, p37 and p37.CFrame or CFrame.new(), NPCModel, Tool);

    if u1.ImpactHook then
        pcall(u1.ImpactHook, NPCModel, WepStats, Tool, p34.UserData.Origin, p35.Position, p35.Instance);
    end;
end);
u1.ImpactHook = nil;
u6.CastTerminating:Connect(function(p38) -- Line: 320
    -- upvalues: u5 (copy)
    u5:ReturnPart(p38.RayInfo.CosmeticBulletObject);
end);

function u1.Fire(u39, p40, p41, p42, p43, p44) -- Line: 324
    -- upvalues: FastCast (copy), GameConfig (copy), Folder2 (copy), u5 (copy), NpcFriendlyFire (copy), PierceMod (copy), Gunsmith (copy), u6 (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = p43 or { u39 };
    RaycastParams_new_ret.IgnoreWater = true;
    RaycastParams_new_ret.RespectCanCollide = true;
    local v45 = FastCast.newBehavior();
    v45.RaycastParams = RaycastParams_new_ret;
    v45.MaxDistance = GameConfig.maxBulletDistance;
    v45.AutoIgnoreContainer = true;
    v45.CosmeticBulletContainer = Folder2;
    v45.HighFidelityBehavior = FastCast.HighFidelityBehavior.Default;
    v45.CosmeticBulletProvider = u5;

    function v45.CanPierceFunction(p46, p47, p48) -- Line: 342
        -- upvalues: NpcFriendlyFire (ref), u39 (copy), PierceMod (ref)
        return NpcFriendlyFire.IsAllyHit(u39, p47.Instance) and true or PierceMod.CanPierce(p46, p47, p48);
    end;

    v45.Acceleration = GameConfig.bulletAcceleration;

    if not p40.bulletDrop then
        v45.Acceleration = Vector3.new(0, 0, 0);
    end;

    local v49 = p40.spread * 100;
    local CFrame_Angles = CFrame.Angles;
    local v50 = math.random(-v49, v49) / 100;
    local math_rad_ret = math.rad(v50);
    local v51 = math.random(-v49, v49) / 100;
    local v52 = CFrame_Angles(math_rad_ret, math.rad(v51), 0);
    local LookVector = (CFrame.lookAt(p41, p41 + p42) * v52).LookVector;
    local v53 = LookVector * p40.muzzleVelocity * 3.5;
    local v54;

    if p40.Attachments then
        v54 = Gunsmith.getAttStats(p40.Attachments);
    else
        v54 = nil;
    end;

    local v55 = u6:Fire(p41, LookVector, v53, v45);
    local v56 = {
        Player = nil
    };
    local v57;

    if p40.tracers then
        v57 = p40.tracerColor or nil;
    else
        v57 = nil;
    end;

    v56.TracerColor = v57;
    v56.Tool = p44;
    v56.IgnoreModel = u39;
    v56.FakeBullet = false;
    v56.Visible = false;
    v56.Origin = p41;
    v56.SuppressionLevel = p40.suppressionLevel or 1;
    v56.TurretFired = false;
    v56.Cracked = false;
    v56.WepStats = p40;
    v56.AttStats = v54;
    v56.NPCModel = u39;
    v55.UserData = v56;
end;

function u1.FireShotgun(p58, p59, p60, p61, p62, p63) -- Line: 392
    -- upvalues: u1 (copy)
    for i = 1, p59.shotgunPellets or 8 do
        u1.Fire(p58, p59, p60, p61, p62, p63);
        local _ = i;
    end;
end;

return u1;