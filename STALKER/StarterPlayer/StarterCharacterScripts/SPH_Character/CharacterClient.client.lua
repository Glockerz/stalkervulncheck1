-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("TestService");
game:GetService("HttpService");
local ContextActionService = game:GetService("ContextActionService");
local SPH_Assets = ReplicatedStorage.SPH_Assets;
local Modules = SPH_Assets.Modules;
local Animations = SPH_Assets.Animations;
local LocalPlayer = Players.LocalPlayer;
local Parent = script.Parent.Parent;
local Humanoid = Parent:WaitForChild("Humanoid");
local HumanoidRootPart = Parent:WaitForChild("HumanoidRootPart");
local RootJoint = HumanoidRootPart:WaitForChild("RootJoint");
local u1;

if Humanoid.RigType == Enum.HumanoidRigType.R6 then
    u1 = Parent.Torso.Neck;
else
    u1 = Parent.UpperTorso.Neck;
end;

local workspace_CurrentCamera = workspace.CurrentCamera;

if workspace_CurrentCamera.CameraSubject ~= Humanoid then
    workspace_CurrentCamera.CameraSubject = Humanoid;
end;

workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

if workspace_CurrentCamera:FindFirstChild("WeaponRig") then
    workspace_CurrentCamera.WeaponRig:Destroy();
end;

local FieldOfView = workspace_CurrentCamera.FieldOfView;
local WeldMod = require(Modules.WeldMod);
local BridgeNet = require(Modules.BridgeNet);
local ViewMod = require(Modules.ViewMod);
local SpringModule = require(Modules.SpringModule);
require(Modules.HitFX);
local ShellEjection = require(Modules.ShellEjection);
local BulletHandler = require(Modules.BulletHandler);
local Mods = require(SPH_Assets.Mods);
BulletHandler.Initialize(LocalPlayer);
local GameConfig = require(SPH_Assets.GameConfig);
local u2 = {};
local u3 = {};

local function track(p4) -- Line: 113
    -- upvalues: u2 (copy), u3 (copy)
    local string_sub_ret = string.sub(p4, 1, 9);
    local Attribute = script:GetAttribute(p4);

    if string_sub_ret == "SpeedCap_" then
        u2[p4] = type(Attribute) == "number" and Attribute and Attribute or nil;

        return;
    end;

    if string_sub_ret == "SpeedMul_" then
        local v5;

        if type(Attribute) == "number" then
            v5 = math.clamp(Attribute, 0, 1) or nil;
        else
            v5 = nil;
        end;

        u3[p4] = v5;
    end;
end;

for i in pairs(script:GetAttributes()) do
    local string_sub_ret = string.sub(i, 1, 9);
    local Attribute = script:GetAttribute(i);

    if string_sub_ret == "SpeedCap_" then
        u2[i] = type(Attribute) == "number" and Attribute and Attribute or nil;
    elseif string_sub_ret == "SpeedMul_" then
        local v6;

        if type(Attribute) == "number" then
            v6 = math.clamp(Attribute, 0, 1) or nil;
        else
            v6 = nil;
        end;

        u3[i] = v6;
    end;
end;

script.AttributeChanged:Connect(track);
Humanoid.WalkSpeed = GameConfig.walkSpeed;
local Shells = workspace:WaitForChild("SPH_Workspace"):WaitForChild("Shells");
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IgnoreWater = true;
RaycastParams_new_ret.RespectCanCollide = true;
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.FilterDescendantsInstances = { Parent, workspace_CurrentCamera, Shells };
local u7 = SpringModule.new();
local u8 = SpringModule.new();
local u9 = SpringModule.new();
u9.Damping = 9;
local u10 = SpringModule.new();
u10.Damping = 9;
local u11 = BridgeNet.CreateBridge("BodyAnimRequest");
local u12 = BridgeNet.CreateBridge("SwitchWeapon");
local u13 = BridgeNet.CreateBridge("PlayerFire");
local u14 = BridgeNet.CreateBridge("PlaySound");
local u15 = BridgeNet.CreateBridge("Reload");
local u16 = BridgeNet.CreateBridge("PlayerChamber");
local u17 = BridgeNet.CreateBridge("MoveBolt");
local u18 = BridgeNet.CreateBridge("SwitchFireMode");
local u19 = BridgeNet.CreateBridge("PlayCharacterSound");
local u20 = BridgeNet.CreateBridge("PlayerDropGun");
local u21 = BridgeNet.CreateBridge("PlayerToggleAttachment");
local u22 = BridgeNet.CreateBridge("RepBoltOpen");
local u23 = BridgeNet.CreateBridge("MagGrab");
local u24 = BridgeNet.CreateBridge("PlayerLean");
local u25 = 0;
local u26 = 0;
local walkSpeed = GameConfig.walkSpeed;
local u27 = walkSpeed;
local u28 = game.Lighting:FindFirstChild("SPH_DoF") or GameConfig.blurEffects and Instance.new("DepthOfFieldEffect", game.Lighting);

if u28 then
    u28.Name = "SPH_DoF";
end;

local u29 = false;
local u30 = true;
local u31 = false;
local u32 = false;
local u33 = false;
local u34 = true;
local u35 = false;
local u36 = false;
local u37 = 0;
local u38 = nil;
local u39 = false;
local u40 = false;
local u41 = false;
local u42 = true;
local u43 = false;
local u44 = false;
local u45 = false;
local u46 = false;
local AttModels = SPH_Assets.AttModels;
local AttModules = SPH_Assets.AttModules;
local u47 = nil;
local u48 = nil;
local u49 = nil;
local u50 = nil;
local u51 = nil;
local u52 = nil;
local u53 = nil;
local u54 = nil;
local u55 = nil;
local u56 = nil;
local ModTable = require(Modules.ModTable);
local WeaponCondition = require(ReplicatedStorage:WaitForChild("WeaponCondition"));

function resetMods()
    -- upvalues: ModTable (copy)
    ModTable.aimFovMinMod = 1;
    ModTable.AimTimeMod = 1;
    ModTable.gunLengthMod = 0;
    ModTable.IsSuppressor = false;
    ModTable.EnableLaserAtt = nil;
    ModTable.EnableFlashlightAtt = nil;
    ModTable.laserAtt = nil;
    ModTable.flashlightAtt = nil;
    ModTable.bipodAtt = nil;
    ModTable.isRangefinder = nil;
    ModTable.recoilMod.vertical = 1;
    ModTable.recoilMod.horizontal = 1;
    ModTable.recoilMod.camShake = 1;
    ModTable.recoilMod.damping = 1;
    ModTable.recoilMod.speed = 1;
    ModTable.recoilMod.aimReduction = 1;
    ModTable.gunRecoilMod.vertical = 1;
    ModTable.gunRecoilMod.horizontal = 1;
    ModTable.gunRecoilMod.damping = 1;
    ModTable.gunRecoilMod.speed = 1;
    ModTable.gunRecoilMod.punchMultiplier = 1;
    ModTable.damage.Head = 1;
    ModTable.damage.Torso = 1;
    ModTable.damage.Other = 1;
    ModTable.fireRate = 1;
    ModTable.muzzleChance = nil;
    ModTable.muzzleVelocity = nil;
    ModTable.bulletForce = nil;
    ModTable.spread = 1;
    ModTable.shotgun = nil;
    ModTable.shotgunPellets = nil;
    ModTable.ammoType = nil;
    ModTable.tracers = nil;
    ModTable.tracerTiming = nil;
    ModTable.tracerColor = nil;
    ModTable.magazineCapacity = nil;
    ModTable.startAmmoPool = nil;
    ModTable.maxAmmoPool = nil;
    ModTable.reloadSpeedModifier = 1;
    ModTable.armorPenMultiplier = 1;
end;

function setMods(p57, p58)
    -- upvalues: ModTable (copy)
    ModTable.aimFovMinMod = ModTable.aimFovMinMod * p57.aimFovMinMod;
    ModTable.AimTimeMod = ModTable.AimTimeMod * p57.AimTimeMod;
    ModTable.gunLengthMod = ModTable.gunLengthMod + p57.gunLength;

    if p57.IsSuppressor then
        ModTable.IsSuppressor = p57.IsSuppressor;
    end;

    if p57.EnableLaser then
        ModTable.EnableLaserAtt = p57.EnableLaser;
        ModTable.laserAtt = p58;
    end;

    if p57.EnableFlashlight then
        ModTable.EnableFlashlightAtt = p57.EnableFlashlight;
        ModTable.flashlightAtt = p58;
    end;

    if p57.IsBipod then
        ModTable.bipodAtt = p58;
    end;

    if p57.isRangefinder then
        ModTable.isRangefinder = p57.isRangefinder;
    end;

    ModTable.recoilMod.vertical = ModTable.recoilMod.vertical * p57.recoil.vertical;
    ModTable.recoilMod.horizontal = ModTable.recoilMod.horizontal * p57.recoil.horizontal;
    ModTable.recoilMod.camShake = ModTable.recoilMod.camShake * p57.recoil.camShake;
    ModTable.recoilMod.damping = ModTable.recoilMod.damping * p57.recoil.damping;
    ModTable.recoilMod.speed = ModTable.recoilMod.speed * p57.recoil.speed;
    ModTable.recoilMod.aimReduction = ModTable.recoilMod.aimReduction * p57.recoil.aimReduction;
    ModTable.gunRecoilMod.vertical = ModTable.gunRecoilMod.vertical * p57.gunRecoil.vertical;
    ModTable.gunRecoilMod.horizontal = ModTable.gunRecoilMod.horizontal * p57.gunRecoil.horizontal;
    ModTable.gunRecoilMod.damping = ModTable.gunRecoilMod.damping * p57.gunRecoil.damping;
    ModTable.gunRecoilMod.speed = ModTable.gunRecoilMod.speed * p57.gunRecoil.speed;
    ModTable.gunRecoilMod.punchMultiplier = ModTable.gunRecoilMod.punchMultiplier * p57.gunRecoil.punchMultiplier;
    ModTable.damage.Head = ModTable.damage.Head * p57.damage.Head;
    ModTable.damage.Torso = ModTable.damage.Torso * p57.damage.Torso;
    ModTable.damage.Other = ModTable.damage.Other * p57.damage.Other;
    ModTable.spread = ModTable.spread * p57.spread;
    ModTable.fireRate = ModTable.fireRate * p57.fireRate;

    if p57.muzzleChance then
        ModTable.muzzleChance = p57.muzzleChance;
    end;

    if p57.muzzleVelocity then
        ModTable.muzzleVelocity = p57.muzzleVelocity;
    end;

    if p57.bulletForce then
        ModTable.bulletForce = p57.bulletForce;
    end;

    if p57.shotgun then
        ModTable.shotgun = p57.shotgun;
    end;

    if p57.shotgunPellets then
        ModTable.shotgunPellets = p57.shotgunPellets;
    end;

    if p57.ammoType then
        ModTable.ammoType = p57.ammoType;
    end;

    if p57.tracers then
        ModTable.tracers = p57.tracers;
    end;

    if p57.tracerTiming then
        ModTable.tracerTiming = p57.tracerTiming;
    end;

    if p57.tracerColor then
        ModTable.tracerColor = p57.tracerColor;
    end;

    if p57.magazineCapacity then
        ModTable.magazineCapacity = p57.magazineCapacity;
    end;

    if p57.startAmmoPool then
        ModTable.startAmmoPool = p57.startAmmoPool;
    end;

    if p57.maxAmmoPool then
        ModTable.maxAmmoPool = p57.maxAmmoPool;
    end;

    if p57.armorPenMultiplier then
        ModTable.armorPenMultiplier = ModTable.armorPenMultiplier * p57.armorPenMultiplier;
    end;

    ModTable.reloadSpeedModifier = ModTable.reloadSpeedModifier * p57.reloadSpeedModifier;
end;

local u59 = false;
local u60 = false;
local u61 = false;
local u62 = { Parent };
local CFrame_new_ret = CFrame.new();
local BlurEffect = Instance.new("BlurEffect");
BlurEffect.Enabled = false;
BlurEffect.Size = 0;
BlurEffect.Name = "FiringBlur";
BlurEffect.Parent = game:GetService("Lighting");
local u63 = nil;
local u64 = 0;
local u65 = nil;
local u66 = nil;
local u67 = nil;
local u68 = nil;
local u69 = nil;
local u70 = nil;
local u71 = nil;
local u72 = nil;
local u73 = nil;
local u74 = nil;
local u75 = nil;
local u76 = nil;
local CFrame_new_ret2 = CFrame.new();
local CFrame_new_ret3 = CFrame.new();
local CFrame_new_ret4 = CFrame.new();
local CFrame_new_ret5 = CFrame.new();
local FieldOfView2 = workspace_CurrentCamera.FieldOfView;
local u77 = 0;
local u78 = 0;
local Vector2_zero = Vector2.zero;
local CFrame_new_ret6 = CFrame.new(1000000, 0, 0);
local u79 = 0;
local u80 = Humanoid.Animator:LoadAnimation(SPH_Assets.Animations.Crouch_Idle);
u80.Looped = true;
u80.Priority = Enum.AnimationPriority.Idle;
local u81 = Humanoid.Animator:LoadAnimation(SPH_Assets.Animations.Crouch_Move);
u81.Looped = true;
u81.Priority = Enum.AnimationPriority.Movement;
local u82 = Humanoid.Animator:LoadAnimation(SPH_Assets.Animations.Prone_Idle);
u82.Looped = true;
u82.Priority = Enum.AnimationPriority.Idle;
local u83 = Humanoid.Animator:LoadAnimation(SPH_Assets.Animations.Prone_Move);
u83.Looped = true;
u83.Priority = Enum.AnimationPriority.Movement;
local u84 = nil;
local u85 = {};
local u86 = Vector3.new(0, 0, 0);
local CameraMode = LocalPlayer.CameraMode;
local u87 = {};
local u88 = 1;
local u89 = 0;
local u90 = 0;
local u91 = LocalPlayer:GetAttribute("SavedAimSensitivity") or GameConfig.defaultAimSensitivity;
local u92 = 0;
local u93 = 0;
local u94 = SPH_Assets.HUD.LaserDotUI:Clone();
local Attachment = Instance.new("Attachment");
Attachment.Parent = workspace.Terrain;
u94.Enabled = false;
u94.Parent = Attachment;
local Attachment2 = Instance.new("Attachment");
Attachment2.Position = Vector3.new(0, 0.1, 0);
Attachment2.Parent = Attachment;
local Attachment3 = Instance.new("Attachment");
Attachment3.Position = Vector3.new(0, -0.1, 0);
Attachment3.Parent = Attachment;
local Trail = Instance.new("Trail");
Trail.Attachment0 = Attachment2;
Trail.Attachment1 = Attachment3;
Trail.FaceCamera = true;
Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.5), NumberSequenceKeypoint.new(1, 0.5) });
Trail.Parent = Attachment;
Trail.Lifetime = 0.1;
Trail.WidthScale = NumberSequence.new(2);
Trail.LightEmission = 0.5;
Trail.LightInfluence = 0.5;
Trail.Texture = "rbxassetid://5367817750";
Trail.Enabled = false;
local Beam = Instance.new("Beam");
Beam.Attachment1 = Attachment;
Beam.LightInfluence = 0;
Beam.Brightness = 3;
Beam.Segments = 1;
Beam.Width0 = 0.02;
Beam.Width1 = 0.02;
Beam.FaceCamera = true;
Beam.Transparency = NumberSequence.new(0.5);
Beam.Name = "FirstPersonLaser";
Beam.Parent = Attachment;
Beam.Enabled = false;
local u95 = Beam:Clone();
u95.Name = "ThirdPersonLaser";
u95.Parent = Attachment;
u95.Enabled = false;

if HumanoidRootPart:FindFirstChild("Died") then
    HumanoidRootPart.Died.Volume = 0;
end;

if GameConfig.lockFirstPerson then
    LocalPlayer.CameraMode = Enum.CameraMode.Classic;
end;

rig = ViewMod.RigModel(LocalPlayer);
local u96 = rig["Left Arm"];
local u97 = rig["Right Arm"];
u96.Color = Parent["Left Arm"].Color;
u97.Color = Parent["Right Arm"].Color;

for _, descendant in ipairs(rig:GetDescendants()) do
    if descendant.Name == "Skin" then
        if descendant.Parent.Name == "Left Arm" then
            descendant.Color = Parent["Left Arm"].Color;
        elseif descendant.Parent.Name == "Right Arm" then
            descendant.Color = Parent["Right Arm"].Color;
        end;
    end;
end;

local CrosshairGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("CrosshairGui");
local u98 = nil;
local DynamicCrosshair = require(game.ReplicatedStorage.DynamicCrosshair);

local function BuildCursor(p99) -- Line: 471
    -- upvalues: u98 (ref), DynamicCrosshair (copy), CrosshairGui (copy), RaycastParams_new_ret (copy)
    print("BUILDING CURSOR");
    u98 = DynamicCrosshair.New(CrosshairGui, 20, 60, 40, 30, false);
    u98:Size(7, 2);
    u98:Display({
        BackgroundTransparency = 0.4,
        Image = nil,
        ImageTransparency = 0,
        BackgroundColor3 = Color3.new(0.729412, 0.729412, 0.729412)
    });
    u98:Enable();

    if p99 then
        u98:UseMuzzleAttach(p99, 600, RaycastParams_new_ret);
    end;
end;

local function DestroyCursor() -- Line: 487
    -- upvalues: u98 (ref)
    if u98 then
        u98:Destroy();
        u98 = nil;
    end;
end;

local Humanoid2 = Instance.new("Humanoid", rig);

for _, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
    if v ~= Enum.HumanoidStateType.None then
        Humanoid2:SetStateEnabled(v, false);
    end;
end;

local Animator = Instance.new("Animator", Humanoid2);
local Shirt = Instance.new("Shirt", rig);
local rig_AnimBase = rig.AnimBase;
rig_AnimBase.CFrame = CFrame_new_ret6;
rig.Parent = workspace_CurrentCamera;
local u100 = Parent:FindFirstChild("WeaponRig") or Parent:WaitForChild("WeaponRig");
local Animator2 = u100:WaitForChild("AnimationController").Animator;

function loadAttachment(p101)
    -- upvalues: u66 (ref), u47 (ref), AttModules (copy), u52 (ref), AttModels (copy), FieldOfView2 (ref), FieldOfView (copy), WeldMod (copy), u48 (ref), u53 (ref), u49 (ref), u54 (ref), u50 (ref), u55 (ref), u51 (ref), u56 (ref)
    if p101 ~= nil then
        if u66.SightAtt and (p101:FindFirstChild("Node_Sight") ~= nil and (u66.SightAtt and u66.SightAtt ~= "")) then
            u47 = require(AttModules[u66.SightAtt]);
            u52 = AttModels[u66.SightAtt]:Clone();
            u52.Parent = p101;
            u52:SetPrimaryPartCFrame(p101.Node_Sight.CFrame);

            if u52:FindFirstChild("AimPos2") then
                if p101:FindFirstChild("AimPart2") then
                    p101.AimPart2.CFrame = u52.AimPos2.CFrame;
                else
                    local v102 = p101.AimPart:Clone();
                    v102.Parent = p101;
                    v102.Name = "AimPart2";
                    v102.CFrame = u52.AimPos2.CFrame;
                end;
            end;

            if u47.maxFOV then
                print(FieldOfView2);

                if FieldOfView2 == u66.maxFOV or FieldOfView then
                    FieldOfView2 = u47.maxFOV;
                end;
            end;

            if u47.ADSEnabled then
                u66.ADSEnabled = u47.ADSEnabled;
            end;

            setMods(u47, u66.SightAtt);

            for _, child in pairs(p101:GetChildren()) do
                if child.Name == "IS" then
                    child.Transparency = 1;
                end;

                if child.Name == "ISF" then
                    child.Transparency = 0;
                end;

                if child.Name == "RailMount" then
                    child.Transparency = 0;
                end;
            end;

            local Grip_AimPart = p101:WaitForChild("Grip"):FindFirstChild("Grip_AimPart");

            if Grip_AimPart then
                Grip_AimPart:Destroy();
            end;

            p101.AimPart.CFrame = u52.AimPos.CFrame;
            WeldMod.Weld(p101.AimPart, p101.Node_Sight);
            WeldMod.WeldModel(u52, p101.Node_Sight, false);
        end;

        if u66.BarrelAtt and (p101:FindFirstChild("Node_Barrel") ~= nil and u66.BarrelAtt ~= "") then
            u48 = require(AttModules[u66.BarrelAtt]);
            u53 = AttModels[u66.BarrelAtt]:Clone();
            u53.Parent = p101;
            u53:SetPrimaryPartCFrame(p101.Node_Barrel.CFrame);

            if u53:FindFirstChild("BarrelPos") ~= nil then
                p101.Grip.Muzzle.WorldCFrame = u53.BarrelPos.CFrame;
            end;

            setMods(u48, u66.BarrelAtt);
            WeldMod.WeldModel(u53, p101.Node_Barrel, false);
        end;

        if u66.UnderBarrelAtt and (p101:FindFirstChild("Node_UnderBarrel") ~= nil and u66.UnderBarrelAtt ~= "") then
            u49 = require(AttModules[u66.UnderBarrelAtt]);
            u54 = AttModels[u66.UnderBarrelAtt]:Clone();
            u54.Parent = p101;
            u54:SetPrimaryPartCFrame(p101.Node_UnderBarrel.CFrame);
            setMods(u49, u66.UnderBarrelAtt);
            WeldMod.WeldModel(u54, p101.Node_UnderBarrel, false);
        end;

        if u66.OtherAtt and (p101:FindFirstChild("Node_Other") ~= nil and u66.OtherAtt ~= "") then
            u50 = require(AttModules[u66.OtherAtt]);
            u55 = AttModels[u66.OtherAtt]:Clone();
            u55.Parent = p101;
            u55:SetPrimaryPartCFrame(p101.Node_Other.CFrame);
            setMods(u50, u66.OtherAtt);
            WeldMod.WeldModel(u55, p101.Node_Other, false);
        end;

        if u66.AmmoAtt and (p101:FindFirstChild("Node_Ammo") ~= nil and u66.AmmoAtt ~= "") then
            u51 = require(AttModules[u66.AmmoAtt]);
            setMods(u51, u66.AmmoAtt);

            if u51.ReplaceMag then
                WeldMod.Weld(p101.Mag, p101.Node_Ammo);
                p101.Mag.Transparency = 1;
                u56 = AttModels[u66.AmmoAtt]:Clone();
                u56.Parent = p101;
                u56:SetPrimaryPartCFrame(p101.Node_Ammo.CFrame);
                WeldMod.WeldModel(u56, p101.Node_Ammo, false);
                WeldMod.Weld(p101.Node_Ammo, p101.Mag, false);
                local Grip_Node_Ammo = p101:WaitForChild("Grip"):FindFirstChild("Grip_Node_Ammo");

                if Grip_Node_Ammo then
                    Grip_Node_Ammo:Destroy();
                end;
            end;
        end;
    end;
end;

local function PlayRepSound(p103) -- Line: 670
    -- upvalues: u33 (ref), u68 (ref), u65 (ref), u31 (ref), HumanoidRootPart (copy), Debris (copy), u14 (copy)
    if not u33 then
        local v104 = u68.Grip:FindFirstChild(p103);

        if v104 and u65 then
            if u31 then
                v104:Play();
            else
                local v105 = v104:Clone();
                v105.Parent = HumanoidRootPart;
                v105:Play();
                Debris:AddItem(v105, v105.TimeLength);
            end;

            u14:Fire(p103, u31);
        end;
    end;
end;

local function IsLoaded() -- Line: 687
    -- upvalues: u66 (ref), u65 (ref), u69 (ref)
    return not u66.openBolt and u65.Chambered.Value or u66.openBolt and u69.MagAmmo.Value > 0;
end;

local function PlayCharSound(p106) -- Line: 691
    -- upvalues: SPH_Assets (copy), HumanoidRootPart (copy), Debris (copy), u19 (copy)
    local v107 = SPH_Assets.Sounds:FindFirstChild(p106);

    if v107 then
        local Children = v107:GetChildren();
        local v108 = Children[math.random(#Children)]:Clone();
        v108.Parent = HumanoidRootPart;
        v108:Play();
        Debris:AddItem(v108, v108.TimeLength);
        u19:Fire(p106);
    end;
end;

local function ChangeLean(p109) -- Line: 703
    -- upvalues: GameConfig (copy), u89 (ref), PlayCharSound (copy), u24 (copy)
    if not GameConfig.canLean then
        return;
    end;

    if p109 ~= u89 then
        PlayCharSound("Lean");
    end;

    u89 = p109;
    u24:Fire(p109);
end;

local function MoveBolt(p110, p111: boolean) -- Line: 710
    -- upvalues: u68 (ref), BulletHandler (copy), u66 (ref), u69 (ref), u100 (copy), PlayRepSound (copy), u17 (copy)
    local v112 = u68 and u68:GetAttribute("VMScale") or 1;
    local v113;

    if v112 == 1 then
        v113 = p110;
    elseif typeof(p110) == "CFrame" then
        v113 = p110.Rotation + p110.Position * v112;
    else
        v113 = p110 * v112;
    end;

    BulletHandler.MoveBolt(u68, u66, v113, u69.MagAmmo.Value);
    BulletHandler.MoveBolt(u100.Weapon:FindFirstChildWhichIsA("Model"), u66, p110, u69.MagAmmo.Value);

    if u69.MagAmmo.Value <= 0 and not p111 then
        PlayRepSound("Empty");
    end;

    u17:Fire(p110, u69.MagAmmo.Value);
end;

local function ToggleADS(p114) -- Line: 737
    -- upvalues: u66 (ref), ModTable (copy), u68 (ref), TweenService (copy), u52 (ref)
    if u66 and u66.ADSEnabled then
        local aimTime = u66.aimTime;
        local v115;

        if aimTime then
            if ModTable.AimTimeMod then
                aimTime = ModTable.AimTimeMod;
            end;

            v115 = TweenInfo.new(aimTime / 20, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, aimTime / 20);
        else
            v115 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.2);
        end;

        if p114 then
            if p114 then
                for _, child in pairs(u68:GetChildren()) do
                    if child.Name == "REG" then
                        TweenService:Create(child, v115, {
                            Transparency = 1
                        }):Play();
                    elseif child.Name == "ADS" then
                        TweenService:Create(child, v115, {
                            Transparency = 0
                        }):Play();
                    end;
                end;

                if u52 then
                    for _, child in pairs(u68[u52.Name]:GetChildren()) do
                        if child.Name == "REG" then
                            TweenService:Create(child, v115, {
                                Transparency = 1
                            }):Play();
                        elseif child.Name == "ADS" then
                            TweenService:Create(child, v115, {
                                Transparency = 0
                            }):Play();
                        end;
                    end;
                end;
            end;
        else
            for _, child in pairs(u68:GetChildren()) do
                if child.Name == "REG" then
                    TweenService:Create(child, v115, {
                        Transparency = 0
                    }):Play();
                elseif child.Name == "ADS" then
                    TweenService:Create(child, v115, {
                        Transparency = 1
                    }):Play();
                end;
            end;

            if u52 then
                for _, child in pairs(u68[u52.Name]:GetChildren()) do
                    if child.Name == "REG" then
                        TweenService:Create(child, v115, {
                            Transparency = 0
                        }):Play();
                    elseif child.Name == "ADS" then
                        TweenService:Create(child, v115, {
                            Transparency = 1
                        }):Play();
                    end;
                end;
            end;
        end;
    end;
end;

local function EjectShell() -- Line: 792
    -- upvalues: u42 (ref), u66 (ref), u31 (ref), ShellEjection (copy), LocalPlayer (copy), u65 (ref), u68 (ref), u100 (copy)
    u42 = true;

    if u66.shellEject then
        if u31 then
            ShellEjection.ejectShell(LocalPlayer, u65, u68);

            return;
        end;

        ShellEjection.ejectShell(LocalPlayer, u65, u100.Weapon:FindFirstChildWhichIsA("Model"));
    end;
end;

local function GetThirdPersonGunModel() -- Line: 803
    -- upvalues: u100 (copy)
    return u100.Weapon:FindFirstChildWhichIsA("Model");
end;

local function StopAnimation(p116: string, p117: number) -- Line: 808
    -- upvalues: u85 (copy)
    if not u85[p116] then
        return;
    end;

    if p117 then
        u85[p116]:Stop(p117);
        u85[p116 .. "ThirdPerson"]:Stop(p117);

        return;
    end;

    u85[p116]:Stop();
    u85[p116 .. "ThirdPerson"]:Stop();
end;

local function SwitchFireMode() -- Line: 822
    -- upvalues: u63 (ref), u66 (ref), u18 (copy)
    while true do
        u63 = u63 + 1;

        if u63 > 4 then
            u63 = 0;
            break;
        end;

        if u66.fireSwitch[u63] then
            break;
        end;
    end;

    u18:Fire(u63);
end;

local function PlayAnimation(u118: string, p119: userdata, u120: string, p121: any) -- Line: 831
    -- upvalues: u85 (copy), Animations (copy), Animator (copy), Animator2 (copy), u70 (ref), Parent (copy), u68 (ref), PlayRepSound (copy), u65 (ref), u66 (ref), PlayAnimation (copy), u15 (copy), ModTable (copy), u43 (ref), u69 (ref), u76 (ref), u16 (copy), MoveBolt (copy), u42 (ref), u31 (ref), ShellEjection (copy), LocalPlayer (copy), u100 (copy), u63 (ref), u18 (copy), u23 (copy), u22 (copy)
    local v122 = p119 or {};
    local u123 = nil;
    local v124 = nil;

    if u85[u118] then
        u123 = u85[u118];
        v124 = u85[u118 .. "ThirdPerson"];
    elseif u118 and Animations:FindFirstChild(u118) then
        u123 = Animator:LoadAnimation(Animations[u118]);
        u123.Looped = v122.looped or false;
        u123.Priority = v122.priority or Enum.AnimationPriority.Action;
        u85[u118] = u123;
        v124 = Animator2:LoadAnimation(Animations[u118]);
        v124.Looped = v122.looped or false;
        v124.Priority = v122.priority or Enum.AnimationPriority.Action;
        u85[u118 .. "ThirdPerson"] = v124;
        u123.KeyframeReached:Connect(function(p125) -- Line: 849
            -- upvalues: u70 (ref), Parent (ref), u68 (ref), PlayRepSound (ref), u65 (ref), u66 (ref), u118 (copy), u85 (ref), PlayAnimation (ref), u15 (ref), ModTable (ref), u123 (copy), u43 (ref), u69 (ref), u76 (ref), u16 (ref), MoveBolt (ref), u42 (ref), u31 (ref), ShellEjection (ref), LocalPlayer (ref), u100 (ref), u63 (ref), u18 (ref), u23 (ref), u22 (ref)
            local v126 = u70;

            if not v126 then
                local Attribute = Parent:GetAttribute("_ReloadingUntil");

                if type(Attribute) == "number" then
                    v126 = os.clock() < Attribute;
                else
                    v126 = false;
                end;
            end;

            if not (v126 or p125 ~= "MagIn" and (p125 ~= "ShellInsert" and (p125 ~= "BulletInsert" and (p125 ~= "ClipInsert" and p125 ~= "ClipInsertEnd")))) then
                return;
            end;

            if u68.Grip:FindFirstChild(p125) then
                PlayRepSound(p125);
            end;

            if p125 == "MagIn" then
                if u65 and (u66.openBolt or not u65.Chambered.Value) and u66.autoChamber then
                    u70 = true;
                    local v127;

                    if u65.BoltReady.Value then
                        v127 = u66.boltChamber;
                    else
                        v127 = u66.boltClose;
                    end;

                    local v128 = u118;

                    if u85[v128] then
                        u85[v128]:Stop(0.4);
                        u85[v128 .. "ThirdPerson"]:Stop(0.4);
                    end;

                    PlayAnimation(v127, {
                        transSpeed = 0.05,
                        priority = Enum.AnimationPriority.Action2
                    });
                end;

                local v129 = u66.bulletHandler and u68:FindFirstChild(u66.bulletHolder);

                if v129 then
                    for _, child in v129:GetChildren() do
                        if child:IsA("BasePart") and string.sub(child.Name, 1, 6) == "Bullet" then
                            child.Transparency = 0;
                        end;
                    end;
                end;

                u15:Fire(ModTable);

                if u66.magType > 1 then
                    u123.DidLoop:Once(function() -- Line: 913
                        -- upvalues: u118 (ref), u85 (ref)
                        local v130 = u118;

                        if not u85[v130] then
                            return;
                        end;

                        u85[v130]:Stop();
                        u85[v130 .. "ThirdPerson"]:Stop();
                    end);
                end;
            else
                if p125 == "ShellInsert" or p125 == "BulletInsert" then
                    if u43 then
                        u43 = false;
                        u123.Looped = false;
                        u123.Stopped:Once(function() -- Line: 921
                            -- upvalues: u65 (ref), u123 (ref), u85 (ref), u66 (ref), PlayAnimation (ref), u70 (ref)
                            if not u65 then
                                return;
                            end;

                            local Name = u123.Name;

                            if u85[Name] then
                                u85[Name]:Stop();
                                u85[Name .. "ThirdPerson"]:Stop();
                            end;

                            if u65.BoltReady.Value and not u66.openBolt then
                                u70 = false;

                                return;
                            end;

                            PlayAnimation(u66.boltClose, {
                                priority = Enum.AnimationPriority.Action2
                            });
                        end);
                    elseif u69.MagAmmo.Value + 1 >= u69.MagAmmo.MaxValue or u76.Value - 1 <= 0 then
                        u123.DidLoop:Once(function() -- Line: 931
                            -- upvalues: u65 (ref), u123 (ref), u85 (ref), u66 (ref), PlayAnimation (ref), u70 (ref)
                            if not u65 then
                                return;
                            end;

                            local Name = u123.Name;

                            if u85[Name] then
                                u85[Name]:Stop();
                                u85[Name .. "ThirdPerson"]:Stop();
                            end;

                            if u65.BoltReady.Value and (u66.operationType ~= 3 and not u66.openBolt) then
                                u70 = false;

                                return;
                            end;

                            PlayAnimation(u66.boltClose, {
                                priority = Enum.AnimationPriority.Action2
                            });
                        end);
                    else
                        local _ = u66.openBolt;
                    end;

                    local v131 = u66.bulletHolder and u68:FindFirstChild(u66.bulletHolder);
                    local v132 = v131 and v131:FindFirstChild("Bullet" .. u69.MagAmmo.MaxValue - u69.MagAmmo.Value);

                    if v132 then
                        v132.Transparency = 0;
                    end;

                    u15:Fire(ModTable);

                    return;
                end;

                if p125 == "ClipInsertEnd" then
                    local v133 = u69.MagAmmo.MaxValue - u69.MagAmmo.Value;
                    local v134 = u66.clipSize or u66.magazineCapacity;

                    if ModTable.magazineCapacity then
                        v134 = u66.clipSize or ModTable.magazineCapacity;
                    end;

                    if v133 > 0 then
                        local Name = u123.Name;

                        if u85[Name] then
                            u85[Name]:Stop();
                            u85[Name .. "ThirdPerson"]:Stop();
                        end;

                        if v134 <= v133 then
                            PlayAnimation(u66.clipReloadAnim, {
                                looped = true,
                                transSpeed = 0.17,
                                speed = u66.reloadSpeedModifier,
                                priority = Enum.AnimationPriority.Action2
                            });

                            return;
                        end;

                        PlayAnimation(u66.reloadAnim, {
                            transSpeed = 0.17,
                            speed = u66.reloadSpeedModifier,
                            priority = Enum.AnimationPriority.Action2
                        }, "Reload");
                    end;
                else
                    if p125 == "ClipInsert" then
                        u15:Fire(ModTable);

                        return;
                    end;

                    if p125 == "SlideRelease" or p125 == "BoltClose" then
                        u16:Fire();
                        u70 = false;
                        Parent:SetAttribute("_ReloadingUntil", 0);
                        MoveBolt(CFrame.new(), true);

                        if u65 then
                            u65:SetAttribute("_AutoChamberPending", false);
                        end;
                    elseif p125 == "SlidePull" and u65.Chambered.Value then
                        u42 = true;

                        if u66.shellEject then
                            if u31 then
                                ShellEjection.ejectShell(LocalPlayer, u65, u68);

                                return;
                            end;

                            ShellEjection.ejectShell(LocalPlayer, u65, u100.Weapon:FindFirstChildWhichIsA("Model"));
                        end;
                    else
                        if p125 == "Equip" then
                            return;
                        end;

                        if p125 == "Switch" and not u70 then
                            while true do
                                u63 = u63 + 1;

                                if u63 > 4 then
                                    u63 = 0;
                                    break;
                                end;

                                if u66.fireSwitch[u63] then
                                    break;
                                end;
                            end;

                            u18:Fire(u63);

                            return;
                        end;

                        if p125 == "MagGrab" then
                            if u68 and (u66.projectile ~= "Bullet" and u68:FindFirstChild(u66.projectile)) then
                                local v135 = u68:FindFirstChild(u66.projectile);
                                v135.LocalTransparencyModifier = 0;

                                for _, descendant in ipairs(v135:GetDescendants()) do
                                    if descendant:IsA("BasePart") then
                                        descendant.LocalTransparencyModifier = 0;
                                    end;
                                end;

                                local v136 = u100.Weapon:FindFirstChildWhichIsA("Model"):FindFirstChild(u66.projectile);
                                v136.LocalTransparencyModifier = 0;

                                for _, descendant in ipairs(v136:GetDescendants()) do
                                    if descendant:IsA("BasePart") then
                                        descendant.LocalTransparencyModifier = 0;
                                    end;
                                end;

                                u23:Fire();
                            end;
                        elseif p125 == "BoltOpen" then
                            u22:Fire();

                            if not u42 then
                                u42 = true;

                                if u66.shellEject then
                                    if u31 then
                                        ShellEjection.ejectShell(LocalPlayer, u65, u68);

                                        return;
                                    end;

                                    ShellEjection.ejectShell(LocalPlayer, u65, u100.Weapon:FindFirstChildWhichIsA("Model"));
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end);
        u123.Stopped:Connect(function() -- Line: 1030
            -- upvalues: u120 (copy), u70 (ref), Parent (ref), u65 (ref), u69 (ref), u66 (ref), PlayAnimation (ref), u68 (ref)
            if u120 == "Equip" then
                return;
            end;

            if u120 == "Reload" then
                u70 = false;
                Parent:SetAttribute("_ReloadingUntil", 0);

                if u65 and (u65:GetAttribute("_AutoChamberPending") and (u65:FindFirstChild("BoltReady") and (not u65.BoltReady.Value and (u69 and (u69.MagAmmo and (u69.MagAmmo.Value > 0 and (u66 and (u66.boltClose and not u66.openBolt)))))))) then
                    u65:SetAttribute("_AutoChamberPending", false);
                    PlayAnimation(u66.boltClose, {
                        transSpeed = 0.05,
                        priority = Enum.AnimationPriority.Action2
                    });
                end;

                if u66 and (u68 and (u68:FindFirstChild(u66.projectile) and u65.Chambered.Value)) then
                    local v137 = u68:FindFirstChild(u66.projectile);
                    v137.LocalTransparencyModifier = 0;

                    for _, descendant in ipairs(v137:GetDescendants()) do
                        if descendant:IsA("BasePart") then
                            descendant.LocalTransparencyModifier = 0;
                        end;
                    end;
                end;
            end;
        end);
    end;

    if u123 and not p121 then
        u123:Play(v122.transSpeed or 0);
        u123:AdjustSpeed(v122.speed or 1);
        v124:Play(v122.transSpeed or 0);
        v124:AdjustSpeed(v122.speed or 1);
    end;

    return u123;
end;

local function ChangeHoldStance(p138) -- Line: 1080
    -- upvalues: u71 (ref), u37 (ref), u38 (ref), u85 (copy), u66 (ref), PlayAnimation (copy)
    if u71 then
        return;
    end;

    if u37 == p138 and u38 then
        local Name = u38.Name;

        if u85[Name] then
            u85[Name]:Stop(0.3);
            u85[Name .. "ThirdPerson"]:Stop(0.3);
        end;

        u38 = nil;
        u37 = 0;

        return;
    end;

    u37 = p138;

    if u38 then
        local Name = u38.Name;

        if u85[Name] then
            u85[Name]:Stop(0.3);
            u85[Name .. "ThirdPerson"]:Stop(0.3);
        end;
    end;

    local v139 = nil;

    if u37 == 1 and u66.holdUpAnim then
        v139 = u66.holdUpAnim;
    elseif u37 == 2 and u66.patrolAnim then
        v139 = u66.patrolAnim;
    elseif u37 == 3 and u66.holdDownAnim then
        v139 = u66.holdDownAnim;
    end;

    if not v139 then
        if u38 then
            u38 = nil;
        end;

        return;
    end;

    u38 = PlayAnimation(v139, {
        looped = true,
        transSpeed = 0.3,
        priority = Enum.AnimationPriority.Action
    });
    u38:Play();
end;

local function ChamberAnim() -- Line: 1111
    -- upvalues: u65 (ref), u63 (ref), u66 (ref), u70 (ref), u44 (ref), ChangeHoldStance (copy), PlayAnimation (copy), Parent (copy)
    local v140;

    if u65.BoltReady.Value or u63 == 4 then
        v140 = u66.boltChamber;
    else
        v140 = u66.boltClose;
    end;

    if v140 then
        u70 = true;
        u44 = true;
        ChangeHoldStance(0);
        PlayAnimation(v140, {
            transSpeed = 0.05,
            priority = Enum.AnimationPriority.Action2
        }).Stopped:Once(function() -- Line: 1125
            -- upvalues: u44 (ref), u70 (ref), Parent (ref)
            u44 = false;
            u70 = false;
            Parent:SetAttribute("_ReloadingUntil", 0);
        end);
    end;
end;

local function IdleAnim() -- Line: 1140
    -- upvalues: PlayAnimation (copy), u66 (ref)
    PlayAnimation(u66.idleAnim, {
        looped = true,
        priority = Enum.AnimationPriority.Idle
    });
end;

local function EquipAnim() -- Line: 1144
    -- upvalues: PlayAnimation (copy), u66 (ref), u31 (ref), u35 (ref), u68 (ref), u65 (ref)
    PlayAnimation(u66.equipAnim, {
        priority = Enum.AnimationPriority.Action2
    }, "Equip");
    task.wait(0.1);

    if u31 then
        u35 = true;
    end;

    local v141 = u68:FindFirstChild(u66.projectile);

    if (u66.openBolt or not u65.Chambered.Value) and (v141 and u66.projectile ~= "Bullet") then
        v141.LocalTransparencyModifier = 1;

        for _, descendant in ipairs(v141:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.LocalTransparencyModifier = 1;
            end;
        end;
    end;
end;

local function ReloadAnim() -- Line: 1162
    -- upvalues: u65 (ref), u43 (ref), u70 (ref), ReplicatedStorage (copy), Parent (copy), GameConfig (copy), u66 (ref), u85 (copy), ChangeHoldStance (copy), u69 (ref), PlayAnimation (copy), u76 (ref), ModTable (copy)
    if not u65 then
        return;
    end;

    u43 = false;
    u70 = true;
    local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

    if Remotes then
        Remotes = Remotes:FindFirstChild("RequestReload");
    end;

    if Remotes then
        Remotes:FireServer();
    end;

    Parent:SetAttribute("_ReloadingUntil", os.clock() + GameConfig.reloadLockSeconds);

    if u66 then
        if u66.equipAnim then
            local equipAnim = u66.equipAnim;

            if u85[equipAnim] then
                u85[equipAnim]:Stop(0.1);
                u85[equipAnim .. "ThirdPerson"]:Stop(0.1);
            end;
        end;

        if u66.boltChamber then
            local boltChamber = u66.boltChamber;

            if u85[boltChamber] then
                u85[boltChamber]:Stop(0.1);
                u85[boltChamber .. "ThirdPerson"]:Stop(0.1);
            end;
        end;

        if u66.boltClose then
            local boltClose = u66.boltClose;

            if u85[boltClose] then
                u85[boltClose]:Stop(0.1);
                u85[boltClose .. "ThirdPerson"]:Stop(0.1);
            end;
        end;
    end;

    ChangeHoldStance(0);

    if u65:FindFirstChild("BoltReady") and not u65.BoltReady.Value then
        u65:SetAttribute("_AutoChamberPending", true);
    end;

    if u66.operationType ~= 3 and (u66.operationType ~= 2 or (u69.MagAmmo.Value > 0 or u65.Chambered.Value)) then
        local v142 = PlayAnimation(u66.reloadAnim, {
            transSpeed = 0.17,
            speed = u66.reloadSpeedModifier,
            priority = Enum.AnimationPriority.Action2
        }, "Reload");

        if v142 and u66.magType > 1 then
            v142.Looped = true;
        end;

        return;
    end;

    local v143 = PlayAnimation(u66.boltOpen, {
        transSpeed = 0.17,
        speed = u66.reloadSpeedModifier,
        priority = Enum.AnimationPriority.Action2
    });

    if v143 then
        v143.Stopped:Once(function() -- Line: 1241
            -- upvalues: u66 (ref), u69 (ref), u76 (ref), ModTable (ref), PlayAnimation (ref)
            if u66.magType == 3 and (u69.MagAmmo.MaxValue - u69.MagAmmo.Value >= (u66.clipSize or u66.magazineCapacity) and u76.Value >= (u66.clipSize or u66.magazineCapacity)) then
                if not ModTable.magazineCapacity then
                    PlayAnimation(u66.clipReloadAnim, {
                        looped = true,
                        transSpeed = 0.17,
                        speed = u66.reloadSpeedModifier,
                        priority = Enum.AnimationPriority.Action2
                    });

                    return;
                end;

                if u76.Value >= (u66.clipSize or ModTable.magazineCapacity) then
                    PlayAnimation(u66.clipReloadAnim, {
                        looped = true,
                        transSpeed = 0.17,
                        speed = ModTable.reloadSpeedModifier,
                        priority = Enum.AnimationPriority.Action2
                    });
                end;
            else
                local v144 = PlayAnimation(u66.reloadAnim, {
                    transSpeed = 0.17,
                    looped = true,
                    speed = u66.reloadSpeedModifier,
                    priority = Enum.AnimationPriority.Action2
                }, "Reload");

                if u66.magType > 1 then
                    v144.Looped = true;
                end;
            end;
        end);

        return;
    end;

    warn("【 SPEARHEAD 】 " .. "To use operation type " .. u66.operationType .. ", a \'boltOpen\' animation is required.");
    u70 = false;
end;

local function RefreshViewmodel() -- Line: 1301
    -- upvalues: u31 (ref), u32 (ref), u35 (ref), Parent (copy), Shirt (copy), u96 (copy), u97 (copy), PlayAnimation (copy), u66 (ref), Mods (copy), LocalPlayer (copy)
    if u31 and not u32 then
        u35 = true;
    end;

    local v145 = Parent:FindFirstChildWhichIsA("Shirt");

    if v145 then
        Shirt.ShirtTemplate = v145.ShirtTemplate;
    end;

    u96.Color = Parent["Left Arm"].Color;
    u97.Color = Parent["Right Arm"].Color;

    for _, descendant in ipairs(rig:GetDescendants()) do
        if descendant.Name == "Skin" then
            if descendant.Parent.Name == "Left Arm" then
                descendant.Color = Parent["Left Arm"].Color;
            elseif descendant.Parent.Name == "Right Arm" then
                descendant.Color = Parent["Right Arm"].Color;
            end;
        end;
    end;

    PlayAnimation(u66.idleAnim, {
        looped = true,
        priority = Enum.AnimationPriority.Idle
    });

    if Mods.onViewmodelRefresh then
        Mods.onViewmodelRefresh(LocalPlayer, rig);
    end;
end;

local function ResetHead() -- Line: 1328
    -- upvalues: u35 (ref)
    u35 = false;
end;

local function GetSineOffset(p146: number) -- Line: 1332
    local v147 = tick() * p146 * 1.3;

    return math.sin(v147) * 0.3;
end;

local function LerpNumber(p148: number, p149: number, p150: number) -- Line: 1336
    return p148 + (p149 - p148) * p150;
end;

local u151 = nil;
local u152 = false;

local function ToggleAiming(u153) -- Line: 1342
    -- upvalues: u151 (ref), u71 (ref), u152 (ref), UserInputService (copy), ToggleAiming (copy), Parent (copy), ChangeHoldStance (copy), u98 (ref), u66 (ref), u88 (ref), ToggleADS (copy), u91 (ref), PlayRepSound (copy), GameConfig (copy), LocalPlayer (copy), u93 (ref), u7 (copy), ModTable (copy), TweenService (copy), workspace_CurrentCamera (copy), FieldOfView (copy), CameraMode (copy)
    if u153 then
        if u151 then
            task.cancel(u151);
            u151 = nil;
        end;

        if u71 then
            return;
        end;
    elseif not u152 then
        if u151 then
            return;
        end;

        u151 = task.delay(0.05, function() -- Line: 1354
            -- upvalues: u151 (ref), UserInputService (ref), u71 (ref), u152 (ref), ToggleAiming (ref)
            u151 = nil;

            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                return;
            end;

            if not u71 then
                return;
            end;

            u152 = true;
            ToggleAiming(false);
            u152 = false;
        end);

        return;
    end;

    Parent:SetAttribute("Aiming", u153);

    if u153 then
        ChangeHoldStance(0);
        u71 = true;

        if u98 then
            u98:ToggleVisible(false);
        end;

        if u66.ADSEnabled and u66.ADSEnabled[u88] then
            ToggleADS(true);
        else
            ToggleADS(false);
        end;

        u91 = require(game:GetService("ReplicatedStorage").SPH_Assets.Modules.AimSensitivity).Get();
        require(game:GetService("ReplicatedStorage").SPH_Assets.Modules.AimSensitivity).SetCameraScale(u91);
        PlayRepSound("AimUp");

        if not GameConfig.lockFirstPerson then
            LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
        end;

        if GameConfig.proceduralAimAnim then
            u93 = 13;
            task.delay(0.1, function() -- Line: 1393
                -- upvalues: u71 (ref), u153 (copy), u93 (ref)
                if u71 == u153 then
                    u93 = 0;
                end;
            end);
            u7:shove(Vector3.new(0, -1, 0));
        end;
    else
        u71 = false;

        if u98 then
            u98:ToggleVisible(true);
        end;

        ToggleADS(false);
        require(game:GetService("ReplicatedStorage").SPH_Assets.Modules.AimSensitivity).SetCameraScale(nil);
        PlayRepSound("AimDown");
        local v154;

        if u66 then
            v154 = u66.aimTime / 2;

            if ModTable.AimTimeMod then
                v154 = ModTable.AimTimeMod / 2;
            end;
        else
            v154 = 0.3;
        end;

        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(v154), {
            FieldOfView = FieldOfView
        }):Play();

        if not GameConfig.lockFirstPerson then
            LocalPlayer.CameraMode = CameraMode;
        end;

        if GameConfig.proceduralAimAnim then
            u93 = 10;
            task.delay(0.1, function() -- Line: 1426
                -- upvalues: u71 (ref), u153 (copy), u93 (ref)
                if u71 == u153 then
                    u93 = 0;
                end;
            end);
            u7:shove(Vector3.new(0, -1, 0));
        end;
    end;
end;

local u155 = {
    fps = 0,
    accum = 0,
    bobAccum = 0,
    rattle = 0,
    lowReady = 0,
    lastActive = 0,
    prevFX = CFrame.new(),
    currFX = CFrame.new(),
    camRecoil = CFrame.new(),
    smoothRot = CFrame.new(),
    bobFX = CFrame.new()
};

local function UpdateViewmodelPosition(p156: number) -- Line: 1453
    -- upvalues: u155 (copy), rig_AnimBase (copy), workspace_CurrentCamera (copy), u72 (ref), u61 (ref), CFrame_new_ret (ref), u73 (ref), CFrame_new_ret3 (ref), u79 (ref), u92 (ref), CFrame_new_ret2 (ref), u68 (ref), u88 (ref), LocalPlayer (copy), CFrame_new_ret5 (ref), u66 (ref), ModTable (copy), u71 (ref), CFrame_new_ret4 (ref), Parent (copy), u31 (ref), u100 (copy), RaycastParams_new_ret (copy), GameConfig (copy), u36 (ref), u78 (ref), u29 (ref), ChangeHoldStance (copy), PlayAnimation (copy), u152 (ref), ToggleAiming (copy), u85 (copy), u46 (ref), u67 (ref), HumanoidRootPart (copy), u25 (ref), UserInputService (copy), Vector2_zero (ref), u7 (copy), u10 (copy), u9 (copy), u35 (ref), CFrame_new_ret6 (copy)
    u155.fps = 1 / p156;
    rig_AnimBase.CFrame = CFrame.new((workspace_CurrentCamera.CFrame * u72).Position);

    if u61 then
        local v157 = rig_AnimBase;
        v157.CFrame = v157.CFrame * CFrame_new_ret;
    end;

    if u73 then
        local v158 = rig_AnimBase;
        v158.CFrame = v158.CFrame * CFrame_new_ret3;
    else
        local v159 = rig_AnimBase;
        v159.CFrame = v159.CFrame * (workspace_CurrentCamera.CFrame - workspace_CurrentCamera.CFrame.Position);
    end;

    if u79 == 2 then
        local v160 = u92;
        u92 = v160 + (0.2 - v160) * 0.1;
    else
        local v161 = u92;
        u92 = v161 + (0 - v161) * 0.1;
    end;

    local v162 = rig_AnimBase;
    v162.CFrame = v162.CFrame * CFrame.new(0, u92, 0);
    CFrame_new_ret2 = CFrame_new_ret2:Lerp(CFrame.new(), p156 * 0.2 * 60);
    local v163 = rig_AnimBase;
    v163.CFrame = v163.CFrame * CFrame_new_ret2:Inverse();
    local v164 = u68:FindFirstChild("AimPart" .. u88) or u68.AimPart;
    local v165 = v164.Name == "AimPart" and 1 or u88;

    if LocalPlayer:GetAttribute("CK_SightIndex") ~= v165 then
        LocalPlayer:SetAttribute("CK_SightIndex", v165);
    end;

    CFrame_new_ret5 = v164.CFrame:ToObjectSpace(workspace_CurrentCamera.CFrame);
    local _ = u66.AimTime;

    if ModTable.AimTimeMod then
        local _ = ModTable.AimTimeMod;
    end;

    if u71 then
        local v166 = 1 - CFrame_new_ret4:ToObjectSpace(CFrame_new_ret5).Position.Magnitude / math.max(0.01, CFrame_new_ret5.Position.Magnitude);
        local math_clamp_ret = math.clamp(v166, 0, 1);
        local v167;

        if math_clamp_ret < 0.5 then
            v167 = math.sin(math_clamp_ret * 3.141592653589793) * 0.09 + 0.025;
        else
            v167 = (math_clamp_ret - 0.5) * 0.12 * 2 + 0.08;
        end;

        CFrame_new_ret4 = CFrame_new_ret4:Lerp(CFrame_new_ret5, 1 - (1 - v167) ^ (p156 * 60));
    else
        CFrame_new_ret4 = CFrame_new_ret4:Lerp(CFrame.new(), 1 - 0.91 ^ (p156 * 60));
    end;

    local v168 = rig_AnimBase;
    v168.CFrame = v168.CFrame * CFrame_new_ret4;
    local v169 = tick();

    if u71 then
        u155.lastActive = v169;
    end;

    local v170 = v169 - u155.lastActive > 3 and not u71 and 1 or 0;
    u155.lowReady = u155.lowReady + (v170 - u155.lowReady) * (1 - (1 - (u155.lowReady < v170 and 0.03 or 0.15)) ^ (p156 * 60));
    Parent:SetAttribute("LowReady", u155.lowReady);

    if u155.lowReady > 0.001 then
        local v171 = rig_AnimBase;
        v171.CFrame = v171.CFrame * (CFrame.Angles(math.rad(-8 * u155.lowReady), 0, 0) * CFrame.new(0, -0.1 * u155.lowReady, 0));
    end;

    local gunLength = u66.gunLength;

    if ModTable.gunLengthMod then
        gunLength = u66.gunLength + ModTable.gunLengthMod;
    end;

    if u31 then
        gunLength = gunLength * (u68 and u68:GetAttribute("VMScale") or 1);
    end;

    local v172 = u31 and rig_AnimBase.CFrame or u100.AnimBase.CFrame;
    local v173 = workspace:Raycast(v172.Position, v172.LookVector * gunLength, RaycastParams_new_ret);

    if v173 then
        local v174 = gunLength - (rig_AnimBase.CFrame.Position - v173.Position).Magnitude;

        if GameConfig.pushBackViewmodel and v174 > 0 then
            local v175;

            if u36 then
                v175 = v174 / 2;
            else
                v175 = v174;
            end;

            local v176 = u78;
            u78 = v176 + (v175 - v176) * (p156 * 12);
        else
            local v177 = u78;
            u78 = v177 + (0 - v177) * (p156 * 12);
        end;

        if GameConfig.raiseGunAtWall and not u29 then
            if u66.maxPushback <= v174 then
                if not u36 then
                    ChangeHoldStance(0);
                    PlayAnimation(u66.holdUpAnim, {
                        looped = true,
                        transSpeed = 0.3,
                        priority = Enum.AnimationPriority.Action
                    });
                    u36 = true;

                    if u71 then
                        u152 = true;
                        ToggleAiming(false);
                        u152 = false;
                    end;
                end;
            elseif u36 then
                local holdUpAnim = u66.holdUpAnim;

                if u85[holdUpAnim] then
                    u85[holdUpAnim]:Stop(0.3);
                    u85[holdUpAnim .. "ThirdPerson"]:Stop(0.3);
                end;

                u36 = false;

                if u46 and (not u71 and u31) then
                    ToggleAiming(true);
                end;
            end;
        end;
    else
        if u36 then
            local holdUpAnim = u66.holdUpAnim;

            if u85[holdUpAnim] then
                u85[holdUpAnim]:Stop(0.3);
                u85[holdUpAnim .. "ThirdPerson"]:Stop(0.3);
            end;
        end;

        u36 = false;

        if u46 and not (u71 or (not u31 or u67)) then
            ToggleAiming(true);
        end;

        local v178 = u78;
        u78 = v178 + (0 - v178) * (p156 * 12);
    end;

    local v179 = rig_AnimBase;
    v179.CFrame = v179.CFrame * CFrame.new(0, 0, u78);
    local v180 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.Velocity);
    local v181 = u71 and 0 or math.clamp(-v180.X, -GameConfig.maxStrafeRoll, GameConfig.maxStrafeRoll);

    if GameConfig.cameraTilting then
        v181 = v181 / 2;
    end;

    local v182 = u25;
    u25 = v182 + (v181 - v182) * (p156 * 0.07 * 60);
    local v183 = rig_AnimBase;
    v183.CFrame = v183.CFrame * CFrame.Angles(0, 0, (math.rad(u25)));
    local MouseDelta = UserInputService:GetMouseDelta();
    local v184 = Vector2_zero;

    if GameConfig.hipfireMove and (not u71 or u71 and GameConfig.offCenterAiming) then
        local hipfireMoveX = GameConfig.hipfireMoveX;
        local hipfireMoveY = GameConfig.hipfireMoveY;

        if u71 then
            hipfireMoveX = hipfireMoveX / 4;
            hipfireMoveY = hipfireMoveY / 4;
        end;

        local v185 = 1 - math.exp(p156 * -8);
        local v186 = v184.Y * (1 - v185) - MouseDelta.Y * GameConfig.hipfireMoveSpeed * p156 * 60;
        local v187 = hipfireMoveX > 0 and hipfireMoveX * math.tanh((v184.X * (1 - v185) - MouseDelta.X * GameConfig.hipfireMoveSpeed * p156 * 60) / hipfireMoveX) or 0;
        local v188 = hipfireMoveY > 0 and hipfireMoveY * math.tanh(v186 / hipfireMoveY) or 0;
        Vector2_zero = Vector2.new(v187, v188);
    else
        Vector2_zero = Vector2_zero:Lerp(Vector2.zero, 1 - 0.7 ^ (p156 * 60));
    end;

    local v189 = rig_AnimBase;
    v189.CFrame = v189.CFrame * CFrame.Angles(math.rad(Vector2_zero.Y), math.rad(Vector2_zero.X), 0);
    u7:shove((Vector3.new(-MouseDelta.X / 300, MouseDelta.Y / 160, 0)));
    local v190 = u7:update(p156);
    local v191 = rig_AnimBase;
    v191.CFrame = v191.CFrame * CFrame.new(v190.X, v190.Y, 0);
    local v192 = tick() * 0.15;
    local breathingDist = GameConfig.breathingDist;

    if u71 then
        breathingDist = breathingDist * GameConfig.breathingAimMultiplier;
    end;

    local v193 = rig_AnimBase;
    v193.CFrame = v193.CFrame * CFrame.new(breathingDist * math.sin(v192 * GameConfig.breathingSpeed / 2), breathingDist * math.sin(v192 * GameConfig.breathingSpeed), 0);
    u155.rattle = math.max(u155.rattle - p156 * 3, 0);

    if u155.rattle > 0 then
        local v194 = u155.rattle * 0.035;
        local v195 = u71 and 0.3 or 1;
        local v196 = rig_AnimBase;
        v196.CFrame = v196.CFrame * (CFrame.new((math.random() - 0.5) * v194 * v195, (math.random() - 0.5) * v194 * v195, (math.random() - 0.5) * v194 * v195) * CFrame.Angles((math.random() - 0.5) * v194 * 0.6 * v195, (math.random() - 0.5) * v194 * 0.6 * v195, (math.random() - 0.5) * v194 * 0.6 * v195));
    end;

    local v197 = u10:update(p156);
    local math_max_ret = math.max(0, v197.X);
    local Vector3_new_ret = Vector3.new(math_max_ret, v197.Y, v197.Z);
    local v198 = u66.gripPivotOffset or Vector3.new(0, -0.3, 0.5);
    local v199 = rig_AnimBase;
    v199.CFrame = v199.CFrame * (CFrame.new(v198) * CFrame.Angles(math.rad(Vector3_new_ret.X), math.rad(Vector3_new_ret.Y), 0) * CFrame.new(-v198));
    local v200 = rig_AnimBase;
    v200.CFrame = v200.CFrame * CFrame.new(0, 0, Vector3_new_ret.Z);
    local v201 = u155;
    v201.accum = v201.accum + p156;

    if u155.accum >= 0.015384615384615385 then
        local v202 = u9:update(u155.accum);
        local math_max_ret2 = math.max(0, v202.X);
        local Vector3_new_ret2 = Vector3.new(math_max_ret2, v202.Y, v202.Z);
        u155.camRecoil = CFrame.Angles(math.rad(Vector3_new_ret2.X), math.rad(Vector3_new_ret2.Y), (math.rad(Vector3_new_ret2.Z)));
        local v203 = workspace_CurrentCamera;
        v203.CFrame = v203.CFrame * u155.camRecoil;
        u155.accum = 0;
    end;

    if not u35 then
        local v204 = rig_AnimBase;
        v204.CFrame = v204.CFrame * CFrame_new_ret6;
    end;
end;

local function ChangeDoF(p205, p206, p207, p208) -- Line: 1675
    -- upvalues: TweenService (copy), u28 (copy)
    TweenService:Create(u28, TweenInfo.new(0.2), {
        FarIntensity = p205,
        FocusDistance = p206,
        InFocusRadius = p207,
        NearIntensity = p208
    }):Play();
end;

local u209 = {
    dotMin = 0.5,
    strafeMult = 1,
    graceTime = 0.2,
    nonFwdTimer = 0.2,
    strandGrace = 0.2,
    keyLastDown = 0
};

local function isForwardDominant() -- Line: 1692
    -- upvalues: Humanoid (copy), workspace_CurrentCamera (copy), u209 (copy)
    local MoveDirection = Humanoid.MoveDirection;

    if MoveDirection.Magnitude < 0.1 then
        return false;
    end;

    local LookVector = workspace_CurrentCamera.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

    if Vector3_new_ret.Magnitude < 0.01 then
        return true;
    end;

    local Unit = Vector3_new_ret.Unit;
    local Vector3_new_ret2 = Vector3.new(MoveDirection.X, 0, MoveDirection.Z);

    if Vector3_new_ret2.Magnitude < 0.01 then
        return false;
    end;

    return Unit:Dot(Vector3_new_ret2.Unit) > u209.dotMin;
end;

local function sprintKeyIsDown() -- Line: 1723
    -- upvalues: GameConfig (copy), UserInputService (copy)
    for _, v in ipairs(GameConfig.keySprint) do
        if UserInputService:IsKeyDown(v) then
            return true;
        end;

        if string.sub(v.Name, 1, 6) == "Button" or string.sub(v.Name, 1, 4) == "DPad" then
            local v210 = v;

            for _, v2 in ipairs(UserInputService:GetConnectedGamepads()) do
                if UserInputService:IsGamepadButtonDown(v2, v210) then
                    return true;
                end;
            end;
        end;
    end;

    return false;
end;

local function ToggleSprint(p211: boolean) -- Line: 1737
    -- upvalues: u67 (ref), Parent (copy), u71 (ref), u152 (ref), ToggleAiming (copy), ChangeHoldStance (copy), u29 (ref), PlayAnimation (copy), u66 (ref), u28 (copy), ChangeDoF (copy), u85 (copy)
    u67 = p211;
    Parent:SetAttribute("Sprinting", p211);

    if p211 then
        if u71 then
            u152 = true;
            ToggleAiming(false);
            u152 = false;
        end;

        ChangeHoldStance(0);
        require(game:GetService("ReplicatedStorage").SPH_Assets.Modules.AimSensitivity).SetCameraScale(nil);
        u29 = false;
        PlayAnimation(u66.sprintAnim, {
            looped = true,
            transSpeed = 0.2,
            priority = Enum.AnimationPriority.Action
        });

        if u28 then
            ChangeDoF(0, 6, 0, 0.3);
        end;
    elseif u66 then
        local sprintAnim = u66.sprintAnim;

        if u85[sprintAnim] then
            u85[sprintAnim]:Stop(0.2);
            u85[sprintAnim .. "ThirdPerson"]:Stop(0.2);
        end;

        if u28 then
            ChangeDoF(0, 0, 0, 0);
        end;
    end;
end;

local function ChangeWalkSpeed(p212) -- Line: 1761
    -- upvalues: walkSpeed (ref)
    walkSpeed = p212;
end;

function BipodToggle(p213, p214)
    -- upvalues: u60 (ref), u54 (ref), u62 (copy), u71 (ref), CFrame_new_ret (ref), u68 (ref), TweenService (copy), u59 (ref)
    if not u60 then
        return;
    end;

    local TweenInfo_new_ret = TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.025);

    if p214 == true then
        local Bipod = p213.Weapon:FindFirstChildWhichIsA("Model").Grip:FindFirstChild("Bipod");

        if u54 then
            Bipod = p213.Weapon:FindFirstChildWhichIsA("Model")[u54.Name].Main.Bipod;
        end;

        local Ray_new_ret = Ray.new(Bipod.WorldPosition, Vector3.new(0, -1.5, 0));
        local v215, v216, _ = workspace:FindPartOnRayWithIgnoreList(Ray_new_ret, u62, false, true);

        if v215 then
            if u71 then
                CFrame_new_ret = CFrame_new_ret:Lerp(CFrame.new(), 0.2);
            else
                CFrame_new_ret = CFrame_new_ret:Lerp(CFrame.new(0, ((Bipod.WorldCFrame.Position - v216).magnitude - 1) * -1.5, 0), 0.2);
            end;
        else
            warn("NO WELD FOUND");
        end;

        for _, child in pairs(u68:GetChildren()) do
            if child.Name == "Bipod_Active" then
                TweenService:Create(child, TweenInfo_new_ret, {
                    Transparency = 0
                }):Play();
            elseif child.Name == "Bipod_Reg" then
                TweenService:Create(child, TweenInfo_new_ret, {
                    Transparency = 1
                }):Play();
            end;
        end;

        if u54 and u59 then
            for _, child in pairs(u68[u54.Name]:GetChildren()) do
                if child.Name == "Bipod_Active" then
                    TweenService:Create(child, TweenInfo_new_ret, {
                        Transparency = 0
                    }):Play();
                elseif child.Name == "Bipod_Reg" then
                    TweenService:Create(child, TweenInfo_new_ret, {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;
    else
        for _, child in pairs(u68:GetChildren()) do
            if child.Name == "Bipod_Active" then
                TweenService:Create(child, TweenInfo_new_ret, {
                    Transparency = 1
                }):Play();
            elseif child.Name == "Bipod_Reg" then
                TweenService:Create(child, TweenInfo_new_ret, {
                    Transparency = 0
                }):Play();
            end;
        end;

        if u54 and u59 then
            for _, child in pairs(u68[u54.Name]:GetChildren()) do
                if child.Name == "Bipod_Active" then
                    TweenService:Create(child, TweenInfo_new_ret, {
                        Transparency = 1
                    }):Play();
                elseif child.Name == "Bipod_Reg" then
                    TweenService:Create(child, TweenInfo_new_ret, {
                        Transparency = 0
                    }):Play();
                end;
            end;
        end;

        CFrame_new_ret = CFrame_new_ret:Lerp(CFrame.new(), 0.2);
    end;
end;

local function ChangeStance(p217) -- Line: 1825
    -- upvalues: u79 (ref), Parent (copy), u84 (ref), GameConfig (copy), u80 (copy), walkSpeed (ref), TweenService (copy), Humanoid (copy), PlayCharSound (copy), u81 (copy), u74 (ref), u82 (copy), u89 (ref), u24 (copy), u83 (copy)
    local v218 = u79 + p217;
    local v219 = v218 < 0 and 0 or (v218 > 2 and 2 or v218);
    Parent:SetAttribute("Stance", v219);
    local v220;

    if u84 then
        v220 = u84.IsPlaying;
    else
        v220 = false;
    end;

    if v219 == 0 then
        script.Parent.MovementLeaning:SetAttribute("DisableLean", false);

        if u84 then
            u84:Stop(GameConfig.stanceChangeTime);
        end;

        u84 = nil;
        u80:Stop(GameConfig.stanceChangeTime);
        walkSpeed = GameConfig.walkSpeed;
        TweenService:Create(Humanoid, TweenInfo.new(GameConfig.stanceChangeTime), {
            HipHeight = 0
        }):Play();
        PlayCharSound("Uncrouch");
    elseif v219 == 1 then
        script.Parent.MovementLeaning:SetAttribute("DisableLean", false);

        if u84 then
            u84:Stop(GameConfig.stanceChangeTime);
        end;

        u84 = u81;

        if u74 then
            u84:Play(GameConfig.stanceChangeTime);
        end;

        u82:Stop(GameConfig.stanceChangeTime);
        u80:Play(GameConfig.stanceChangeTime);
        walkSpeed = GameConfig.crouchSpeed;
        TweenService:Create(Humanoid, TweenInfo.new(GameConfig.stanceChangeTime), {
            HipHeight = 0
        }):Play();

        if u79 == 0 then
            PlayCharSound("Crouch");
        elseif u79 == 2 then
            PlayCharSound("Unprone");
        end;
    elseif v219 == 2 then
        if GameConfig.canLean then
            if u89 ~= 0 then
                PlayCharSound("Lean");
            end;

            u89 = 0;
            u24:Fire(0);
        end;

        script.Parent.MovementLeaning:SetAttribute("DisableLean", true);

        if u84 then
            u84:Stop(GameConfig.stanceChangeTime);
        end;

        u84 = u83;
        u80:Stop(GameConfig.stanceChangeTime);
        u82:Play(GameConfig.stanceChangeTime);
        walkSpeed = GameConfig.proneSpeed;
        TweenService:Create(Humanoid, TweenInfo.new(GameConfig.stanceChangeTime * 1.5), {
            HipHeight = -2
        }):Play();
        PlayCharSound("Prone");
    end;

    if v220 and u84 then
        u84:Play();
    end;

    u79 = v219;
end;

Parent:GetAttributeChangedSignal("InWater"):Connect(function() -- Line: 1884
    -- upvalues: Parent (copy), u79 (ref), ChangeStance (copy)
    if Parent:GetAttribute("InWater") and u79 == 2 then
        ChangeStance(-1);
    end;
end);
local u221 = {
    SPH_HoldAim = true,
    SPH_Trigger = true,
    SPH_DropGun = true,
    SPH_Reload = true,
    SPH_Chamber = true,
    SPH_SwitchSights = true,
    SPH_Freelook = true,
    SPH_HoldUp = true,
    SPH_HoldPatrol = true,
    SPH_HoldDown = true,
    SPH_SwitchFireMode = true,
    SPH_ToggleLaser = true,
    SPH_ToggleFlashlight = true,
    SPH_ToggleBipod = true
};

local function HandleInput(p222, p223, p224) -- Line: 1902
    -- upvalues: u221 (copy), LocalPlayer (copy), u45 (ref), u209 (copy), u79 (ref), u74 (ref), u71 (ref), isForwardDominant (copy), u65 (ref), ToggleSprint (copy), GameConfig (copy), walkSpeed (ref), u89 (ref), PlayCharSound (copy), u24 (copy), u67 (ref), Parent (copy), u66 (ref), u85 (copy), u28 (copy), ChangeDoF (copy), Humanoid (copy), ChangeStance (copy), u43 (ref), u70 (ref), u29 (ref), u69 (ref), PlayRepSound (copy), u34 (ref), u64 (ref), u20 (copy), u30 (ref), u32 (ref), u76 (ref), ReloadAnim (copy), UserInputService (copy), u31 (ref), u73 (ref), u36 (ref), u46 (ref), ToggleAiming (copy), ChamberAnim (copy), u68 (ref), u88 (ref), FieldOfView2 (ref), FieldOfView (copy), ToggleADS (copy), CFrame_new_ret3 (ref), workspace_CurrentCamera (copy), CFrame_new_ret2 (ref), ChangeHoldStance (copy), PlayAnimation (copy), ModTable (copy), u39 (ref), Trail (copy), u95 (copy), u21 (copy), u94 (copy), u40 (ref), u60 (ref), u61 (ref)
    local Begin = Enum.UserInputState.Begin;
    local _ = Enum.UserInputState.End;

    if p223 == Begin and (u221[p222] and LocalPlayer:GetAttribute("UIInputLocked") == true) then
        return Enum.ContextActionResult.Sink;
    end;

    if p222 == "SPH_Sprint" then
        u45 = p223 == Begin;
        u209.keyLastDown = os.clock();

        if u45 and (u79 == 0 and (u74 and not u71)) then
            if isForwardDominant() then
                if u65 and u74 then
                    ToggleSprint(true);
                end;

                walkSpeed = GameConfig.sprintSpeed;
            else
                walkSpeed = GameConfig.walkSpeed * u209.strafeMult;
            end;

            if GameConfig.canLean then
                if u89 ~= 0 then
                    PlayCharSound("Lean");
                end;

                u89 = 0;
                u24:Fire(0);
            end;
        elseif u79 == 0 then
            u67 = false;
            Parent:SetAttribute("Sprinting", false);

            if u66 then
                local sprintAnim = u66.sprintAnim;

                if u85[sprintAnim] then
                    u85[sprintAnim]:Stop(0.2);
                    u85[sprintAnim .. "ThirdPerson"]:Stop(0.2);
                end;

                if u28 then
                    ChangeDoF(0, 0, 0, 0);
                end;
            end;

            walkSpeed = GameConfig.walkSpeed;
        end;
    elseif p223 == Begin then
        if p222 == "SPH_StanceLower" and (p223 == Begin and (u79 < 2 and not Humanoid.Sit)) then
            if not GameConfig.canProne and u79 == 1 then
                return;
            end;

            if u79 == 1 and Parent:GetAttribute("InWater") then
                return;
            end;

            ChangeStance(1);

            if u67 then
                u67 = false;
                Parent:SetAttribute("Sprinting", false);

                if u66 then
                    local sprintAnim = u66.sprintAnim;

                    if u85[sprintAnim] then
                        u85[sprintAnim]:Stop(0.2);
                        u85[sprintAnim .. "ThirdPerson"]:Stop(0.2);
                    end;

                    if u28 then
                        ChangeDoF(0, 0, 0, 0);
                    end;
                end;
            end;
        elseif p222 == "SPH_StanceRaise" and (p223 == Begin and u79 > 0) then
            ChangeStance(-1);
        elseif p222 == "SPH_LeanLeft" and (p223 == Begin and (u79 < 2 and not (u67 or Humanoid.Sit))) then
            if u89 == -1 then
                if GameConfig.canLean then
                    if u89 ~= 0 then
                        PlayCharSound("Lean");
                    end;

                    u89 = 0;
                    u24:Fire(0);
                end;
            elseif GameConfig.canLean then
                if u89 ~= -1 then
                    PlayCharSound("Lean");
                end;

                u89 = -1;
                u24:Fire(-1);
            end;
        elseif p222 == "SPH_LeanRight" and (p223 == Begin and (u79 < 2 and not (u67 or Humanoid.Sit))) then
            if u89 == 1 then
                if GameConfig.canLean then
                    if u89 ~= 0 then
                        PlayCharSound("Lean");
                    end;

                    u89 = 0;
                    u24:Fire(0);
                end;
            elseif GameConfig.canLean then
                if u89 ~= 1 then
                    PlayCharSound("Lean");
                end;

                u89 = 1;
                u24:Fire(1);
            end;
        end;
    end;

    if u65 then
        if p222 == "SPH_Trigger" then
            if p223 ~= Begin then
                u29 = false;
                u34 = true;
                u64 = 0;

                return;
            end;

            u43 = true;

            if not (u67 or u70) then
                u29 = true;

                if not (not u66.openBolt and u65.Chambered.Value or u66.openBolt and u69.MagAmmo.Value > 0 or u65:GetAttribute("FireMode") == 4 and u65:GetAttribute("MagAmmo") > 0) then
                    PlayRepSound("Click");

                    return;
                end;

                if u65:GetAttribute("WeaponJammed") then
                    PlayRepSound("Click");
                    local Chambered = u65:FindFirstChild("Chambered");

                    if Chambered then
                        Chambered.Value = false;
                    end;
                end;
            end;
        else
            if p222 == "SPH_DropGun" and (p223 == Begin and not u70) then
                Unequip(u65);
                u20:Fire();

                return;
            end;

            if p222 ~= "SPH_Reload" or (p223 ~= Begin or (u70 or not (u30 and (not u32 or os.clock() - u32 >= 1.5)))) or u66.equipAnim and (u85[u66.equipAnim] and u85[u66.equipAnim].IsPlaying) then
                if p222 == "SPH_HoldAim" then
                    if UserInputService.TouchEnabled or GameConfig.toggleAiming then
                        if p223 == Begin then
                            if not u31 or (u73 or (u36 or u71)) then
                                u46 = false;
                                ToggleAiming(false);

                                return;
                            end;

                            u46 = true;
                            u67 = false;
                            Parent:SetAttribute("Sprinting", false);

                            if u66 then
                                local sprintAnim = u66.sprintAnim;

                                if u85[sprintAnim] then
                                    u85[sprintAnim]:Stop(0.2);
                                    u85[sprintAnim .. "ThirdPerson"]:Stop(0.2);
                                end;

                                if u28 then
                                    ChangeDoF(0, 0, 0, 0);
                                end;
                            end;

                            if u79 == 0 then
                                walkSpeed = GameConfig.walkSpeed;
                            end;

                            ToggleAiming(true);
                        end;
                    else
                        if p223 == Begin and (u31 and not (u73 or u36)) then
                            u46 = true;
                            u67 = false;
                            Parent:SetAttribute("Sprinting", false);

                            if u66 then
                                local sprintAnim = u66.sprintAnim;

                                if u85[sprintAnim] then
                                    u85[sprintAnim]:Stop(0.2);
                                    u85[sprintAnim .. "ThirdPerson"]:Stop(0.2);
                                end;

                                if u28 then
                                    ChangeDoF(0, 0, 0, 0);
                                end;
                            end;

                            if u79 == 0 then
                                walkSpeed = GameConfig.walkSpeed;
                            end;

                            ToggleAiming(true);

                            return;
                        end;

                        if not (u67 or (not u71 or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2))) then
                            u46 = false;
                            ToggleAiming(false);
                        end;
                    end;
                else
                    if p222 == "SPH_Chamber" and (p223 == Begin and (not u70 and u30)) then
                        ChamberAnim();

                        return;
                    end;

                    if p222 == "SPH_SwitchSights" and (p223 == Begin and (u71 and u68:FindFirstChild("AimPart2"))) then
                        local v225 = u88 + 1;

                        if u68:FindFirstChild("AimPart" .. v225) then
                            u88 = v225;
                            PlayRepSound("AimUp");
                        else
                            u88 = 1;
                            PlayRepSound("AimDown");
                        end;

                        LocalPlayer:SetAttribute("CK_SightIndex", u88);
                        FieldOfView2 = u88 == 1 and (u66.aimFovDefault or FieldOfView) or FieldOfView;

                        if u66.ADSEnabled and u66.ADSEnabled[u88] then
                            ToggleADS(true);

                            return;
                        end;

                        ToggleADS(false);

                        return;
                    end;

                    if p222 == "SPH_Freelook" then
                        if p223 == Begin then
                            u73 = true;
                            Humanoid.AutoRotate = false;
                            CFrame_new_ret3 = workspace_CurrentCamera.CFrame - workspace_CurrentCamera.CFrame.Position;

                            return;
                        end;

                        u73 = false;
                        CFrame_new_ret2 = CFrame_new_ret3:ToObjectSpace(workspace_CurrentCamera.CFrame);
                        CFrame_new_ret2 = CFrame_new_ret2 - CFrame_new_ret2.Position;
                        Humanoid.AutoRotate = true;

                        return;
                    end;

                    if p222 == "SPH_HoldUp" and (p223 == Begin and not u70) then
                        ChangeHoldStance(1);

                        return;
                    end;

                    if p222 == "SPH_HoldPatrol" and (p223 == Begin and not u70) then
                        ChangeHoldStance(2);

                        return;
                    end;

                    if p222 == "SPH_HoldDown" and (p223 == Begin and not u70) then
                        ChangeHoldStance(3);

                        return;
                    end;

                    if p222 == "SPH_SwitchFireMode" and p223 == Begin then
                        PlayAnimation(u66.switchAnim, {
                            transSpeed = 0.2
                        });

                        return;
                    end;

                    if p222 == "SPH_ToggleLaser" and p223 == Begin then
                        local v226 = u68.Grip:FindFirstChild("Laser") or u68:FindFirstChild("Laser", true):FindFirstChild("Laser", true) or ModTable.laserAtt and u68[ModTable.laserAtt].Main:FindFirstChild("Laser");

                        if v226 then
                            u39 = not u39;
                            Trail.Enabled = u39;

                            if not u31 then
                                u95.Enabled = true;
                            end;

                            PlayRepSound("Button");
                            u21:Fire(1, u39, ModTable);
                            u94.Dot.ImageColor3 = v226.Color.Value;
                            local Value = v226.Color.Value;
                            Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(1, Value) });
                        end;
                    elseif p222 == "SPH_ToggleFlashlight" and p223 == Begin then
                        local Flashlight = u68:FindFirstChild("Flashlight", true);

                        if Flashlight then
                            local v227 = Flashlight:FindFirstChildWhichIsA("Light", true);
                            u40 = not u40;
                            v227.Enabled = u40;
                            PlayRepSound("Button");
                            u21:Fire(0, v227.Enabled, ModTable);

                            if not u40 then
                                v227.Enabled = false;

                                return;
                            end;

                            if not u31 then
                                v227.Enabled = true;
                            end;
                        end;
                    elseif p222 == "SPH_ToggleBipod" and (p223 == Begin and u60) then
                        u61 = not u61;
                        BipodToggle(workspace_CurrentCamera.WeaponRig, u61);
                        u21:Fire(2, u61, ModTable);
                    end;
                end;
            elseif u66.infiniteAmmo or u76.Value > 0 then
                if u66.openBolt and u69.MagAmmo.Value < u69.MagAmmo.MaxValue then
                    ReloadAnim();

                    return;
                end;

                if u66.operationType == 4 and u65.Chambered.Value or (u66.operationType == 3 and u69.MagAmmo.Value + 1 >= u69.MagAmmo.MaxValue or (u66.operationType == 2 and u69.MagAmmo.Value >= u69.MagAmmo.MaxValue or u66.operationType == 1 and u69.MagAmmo.Value >= u69.MagAmmo.MaxValue)) then
                    return;
                end;

                ReloadAnim();
            end;
        end;
    end;
end;

local function BindAiming() -- Line: 2215
    -- upvalues: LocalPlayer (copy), u29 (ref), u45 (ref), u71 (ref), u152 (ref), ToggleAiming (copy), ContextActionService (copy), HandleInput (copy), GameConfig (copy)
    LocalPlayer:GetAttributeChangedSignal("UIInputLocked"):Connect(function() -- Line: 2219
        -- upvalues: LocalPlayer (ref), u29 (ref), u45 (ref), u71 (ref), u152 (ref), ToggleAiming (ref)
        if LocalPlayer:GetAttribute("UIInputLocked") ~= true then
            return;
        end;

        u29 = false;
        u45 = false;

        if u71 then
            u152 = true;
            ToggleAiming(false);
            u152 = false;
        end;
    end);
    ContextActionService:BindActionAtPriority("SPH_HoldAim", HandleInput, GameConfig.mobileButtons, GameConfig.gunInputPriority, unpack(GameConfig.aimGun));
    ContextActionService:SetTitle("SPH_HoldAim", "Aim");
    ContextActionService:SetPosition("SPH_HoldAim", UDim2.fromScale(0.24, 0.3));
end;

local function UnbindAiming() -- Line: 2231
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("SPH_HoldAim");
end;

local function BindGunInputs() -- Line: 2235
    -- upvalues: ContextActionService (copy), HandleInput (copy), GameConfig (copy), u31 (ref), BindAiming (copy)
    ContextActionService:BindActionAtPriority("SPH_Trigger", HandleInput, GameConfig.mobileButtons, GameConfig.gunInputPriority, unpack(GameConfig.fireGun));
    ContextActionService:BindActionAtPriority("SPH_DropGun", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.dropKey));
    ContextActionService:BindActionAtPriority("SPH_Reload", HandleInput, GameConfig.mobileButtons, GameConfig.gunInputPriority, unpack(GameConfig.keyReload));
    ContextActionService:BindActionAtPriority("SPH_Chamber", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.keyChamber));
    ContextActionService:BindActionAtPriority("SPH_SwitchSights", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.sightSwitch));
    ContextActionService:BindActionAtPriority("SPH_Freelook", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.freeLook));
    ContextActionService:BindActionAtPriority("SPH_HoldUp", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.holdUp));
    ContextActionService:BindActionAtPriority("SPH_HoldPatrol", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.holdPatrol));
    ContextActionService:BindActionAtPriority("SPH_HoldDown", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.holdDown));
    ContextActionService:BindActionAtPriority("SPH_SwitchFireMode", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.switchFireMode));
    ContextActionService:BindActionAtPriority("SPH_ToggleLaser", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.toggleLaser));
    ContextActionService:BindActionAtPriority("SPH_ToggleFlashlight", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.toggleFlashlight));
    ContextActionService:BindActionAtPriority("SPH_ToggleBipod", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.ToggleBipod));

    if u31 then
        BindAiming();
    end;

    ContextActionService:SetTitle("SPH_Trigger", "Fire");
    ContextActionService:SetPosition("SPH_Trigger", UDim2.fromScale(0.3, 0.6));
    ContextActionService:SetTitle("SPH_Reload", "Reload");
    ContextActionService:SetPosition("SPH_Reload", UDim2.fromScale(0, 0.6));
end;

local function UnbindGunInputs() -- Line: 2260
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("SPH_Trigger");
    ContextActionService:UnbindAction("SPH_DropGun");
    ContextActionService:UnbindAction("SPH_Reload");
    ContextActionService:UnbindAction("SPH_HoldAim");
    ContextActionService:UnbindAction("SPH_Chamber");
    ContextActionService:UnbindAction("SPH_SwitchSights");
    ContextActionService:UnbindAction("SPH_Freelook");
    ContextActionService:UnbindAction("SPH_HoldUp");
    ContextActionService:UnbindAction("SPH_HoldPatrol");
    ContextActionService:UnbindAction("SPH_HoldDown");
    ContextActionService:UnbindAction("SPH_SwitchFireMode");
    ContextActionService:UnbindAction("SPH_ToggleLaser");
    ContextActionService:UnbindAction("SPH_ToggleFlashlight");
    ContextActionService:UnbindAction("SPH_ToggleBipod");
end;

local function BindCharacterInputs() -- Line: 2277
    -- upvalues: ContextActionService (copy), HandleInput (copy), GameConfig (copy)
    ContextActionService:BindActionAtPriority("SPH_Sprint", HandleInput, false, GameConfig.movementInputPriority, unpack(GameConfig.keySprint));
    ContextActionService:BindActionAtPriority("SPH_StanceLower", HandleInput, GameConfig.mobileButtons, GameConfig.movementInputPriority, unpack(GameConfig.lowerStance));
    ContextActionService:BindActionAtPriority("SPH_StanceRaise", HandleInput, GameConfig.mobileButtons, GameConfig.movementInputPriority, unpack(GameConfig.raiseStance));
    ContextActionService:BindActionAtPriority("SPH_LeanLeft", HandleInput, false, GameConfig.movementInputPriority, unpack(GameConfig.leanLeft));
    ContextActionService:BindActionAtPriority("SPH_LeanRight", HandleInput, false, GameConfig.movementInputPriority, unpack(GameConfig.leanRight));
    ContextActionService:SetTitle("SPH_StanceLower", "Crouch");
    ContextActionService:SetPosition("SPH_StanceLower", UDim2.fromScale(0.4, 0));
    ContextActionService:SetTitle("SPH_StanceRaise", "Stand");
    ContextActionService:SetPosition("SPH_StanceRaise", UDim2.fromScale(0.55, -0.25));
end;

BindCharacterInputs();

local function UnbindCharacterInputs() -- Line: 2292
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("SPH_Sprint");
    ContextActionService:UnbindAction("SPH_StanceLower");
    ContextActionService:UnbindAction("SPH_StanceRaise");
    ContextActionService:UnbindAction("SPH_LeanLeft");
    ContextActionService:UnbindAction("SPH_LeanRight");
end;

Humanoid.Died:Connect(function() -- Line: 2300
    -- upvalues: u33 (ref), u98 (ref), u12 (copy), u65 (ref), u66 (ref), UserInputService (copy), u71 (ref), u152 (ref), ToggleAiming (copy), u35 (ref), rig_AnimBase (copy), CFrame_new_ret6 (copy), UnbindGunInputs (copy), GameConfig (copy), Humanoid (copy), Parent (copy), workspace_CurrentCamera (copy)
    u33 = true;

    if u98 then
        u98:Destroy();
        u98 = nil;
    end;

    u12:Fire();
    u65 = nil;
    u66 = nil;
    UserInputService.MouseIconEnabled = true;

    if u71 then
        u152 = true;
        ToggleAiming(false);
        u152 = false;
    end;

    u35 = false;
    rig_AnimBase.CFrame = CFrame_new_ret6;
    UnbindGunInputs();

    if GameConfig.useDeathCameraSubject then
        repeat
            task.wait();
        until Humanoid.Parent ~= Parent;

        workspace_CurrentCamera.CameraSubject = Humanoid;
    end;

    if rig then
        rig:Destroy();
    end;
end);

function Unequip(p228)
    -- upvalues: rig_AnimBase (copy), CFrame_new_ret6 (copy), u12 (copy), u65 (ref), u66 (ref), u98 (ref), UserInputService (copy), u71 (ref), u152 (ref), ToggleAiming (copy), u35 (ref), Animator (copy), Animator2 (copy), GameConfig (copy), LocalPlayer (copy), u87 (ref), u73 (ref), CFrame_new_ret2 (ref), CFrame_new_ret3 (ref), workspace_CurrentCamera (copy), Humanoid (copy), u28 (copy), ChangeDoF (copy), u37 (ref), u38 (ref), u39 (ref), u40 (ref), u94 (copy), Beam (copy), u95 (copy), u52 (ref), u53 (ref), u54 (ref), u55 (ref), u56 (ref), ModTable (copy), UnbindGunInputs (copy)
    rig_AnimBase.CFrame = CFrame_new_ret6;
    u12:Fire();

    if p228 == u65 then
        u65 = nil;
        u66 = nil;

        if u98 then
            u98:Destroy();
            u98 = nil;
        end;
    end;

    UserInputService.MouseIconEnabled = UserInputService.MouseBehavior == Enum.MouseBehavior.Default;

    if u71 then
        u152 = true;
        ToggleAiming(false);
        u152 = false;
    end;

    u35 = false;

    for _, v in ipairs(Animator:GetPlayingAnimationTracks()) do
        v:Stop();
    end;

    for _, v in ipairs(Animator2:GetPlayingAnimationTracks()) do
        v:Stop();
    end;

    if GameConfig.lockFirstPerson then
        LocalPlayer.CameraMode = Enum.CameraMode.Classic;
    end;

    u87 = {};
    u73 = false;
    CFrame_new_ret2 = CFrame_new_ret3:ToObjectSpace(workspace_CurrentCamera.CFrame);
    CFrame_new_ret2 = CFrame_new_ret2 - CFrame_new_ret2.Position;
    Humanoid.AutoRotate = true;

    if u28 then
        ChangeDoF(0, 0, 0, 0);
    end;

    u37 = 0;
    u38 = nil;
    u39 = false;
    u40 = false;
    u94.Enabled = false;
    Beam.Enabled = false;
    u95.Enabled = false;
    u52 = nil;
    u53 = nil;
    u54 = nil;
    u55 = nil;
    u56 = nil;
    ModTable.laserAtt = nil;
    resetMods();
    LocalPlayer:SetAttribute("rangefinderActive", false);
    UnbindGunInputs();
end;

local function GetRotationBetween(p229, p230, p231) -- Line: 2417
    local v232 = p229:Dot(p230);
    local v233 = p229:Cross(p230);

    if v232 < -0.99999 then
        return CFrame.fromAxisAngle(p231, 3.141592653589793);
    end;

    return CFrame.new(0, 0, 0, v233.x, v233.y, v233.z, 1 + v232);
end;

Parent.ChildAdded:Connect(function(u234) -- Line: 2424
    -- upvalues: SPH_Assets (copy), u33 (ref), Humanoid (copy), u41 (ref), u70 (ref), Parent (copy), UserInputService (copy), Vector2_zero (ref), u32 (ref), u36 (ref), u39 (ref), u30 (ref), u44 (ref), u12 (copy), u65 (ref), u66 (ref), u9 (copy), u10 (copy), u72 (ref), FieldOfView2 (ref), FieldOfView (copy), CFrame_new_ret2 (ref), u59 (ref), WeldMod (copy), u87 (ref), u52 (ref), u68 (ref), u31 (ref), RefreshViewmodel (copy), BuildCursor (copy), BindGunInputs (copy), ToggleSprint (copy), u45 (ref), EquipAnim (copy), PlayAnimation (copy), u69 (ref), u75 (ref), u76 (ref), MoveBolt (copy), GameConfig (copy), LocalPlayer (copy), u63 (ref), Beam (copy), ModTable (copy), ChamberAnim (copy)
    if u234:FindFirstChild("SPH_Weapon") and not SPH_Assets.WeaponModels:FindFirstChild(u234.Name) then
        warn("【 SPEARHEAD 】 " .. "No gun model could be found for \'" .. u234.Name .. "\'");

        return;
    end;

    if u234:FindFirstChild("SPH_Weapon") and not (u33 or Humanoid.Sit and (not Humanoid.Sit or u41)) then
        u70 = false;
        Parent:SetAttribute("_ReloadingUntil", 0);
        UserInputService.MouseIconEnabled = false;
        Vector2_zero = Vector2.zero;
        u32 = os.clock();
        u36 = false;
        u39 = false;
        u30 = true;
        u44 = false;
        u12:Fire(u234);
        u65 = u234;
        u66 = require(u65.SPH_Weapon.WeaponStats);
        u9.Damping = u66.recoil.damping;
        u9.Speed = u66.recoil.speed;
        u10.Damping = u66.gunRecoil.damping;
        u10.Speed = u66.gunRecoil.speed;
        u72 = u66.viewmodelOffset;
        FieldOfView2 = u66.aimFovDefault or FieldOfView;
        CFrame_new_ret2 = CFrame.new();
        u59 = u66.Bipod;

        if not u66.operationType then
            u66.operationType = 1;
        end;

        if type(u66.operationType) == "string" then
            u66.operationType = 1;
        end;

        if not u66.magType then
            u66.magType = 1;
        end;

        for _, child in ipairs(rig.Weapon:GetChildren()) do
            if child:IsA("Model") then
                child:Destroy();
            end;
        end;

        local v235 = SPH_Assets.WeaponModels:FindFirstChild(u234.Name);

        if not v235 then
            warn("【 SPEARHEAD 】 " .. "Could not find a gun model with the name: \'" .. u234.Name .. "\'!");

            return;
        end;

        local v236 = v235:Clone();

        if (u66.viewmodelScale or 1) ~= 1 then
            v236.PrimaryPart = v236.Grip;
            v236:ScaleTo(v236:GetScale() * u66.viewmodelScale);
        end;

        v236:SetAttribute("VMScale", u66.viewmodelScale or 1);
        WeldMod.WeldModel(v236, v236.Grip, false);

        for _, descendant in ipairs(v236:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.Anchored = false;
            end;
        end;

        resetMods();
        loadAttachment(v236);

        for _, v in ipairs(u66.rigParts) do
            if v236:FindFirstChild(v) then
                v236.Grip["Grip_" .. v]:Destroy();
                local v237 = WeldMod.M6D(v236.Grip, v236[v]);
                v237.Name = v;
                v237.Parent = v236.Grip;
            end;
        end;

        for _, child in ipairs(v236:GetChildren()) do
            if child.Name == "SightReticle" then
                table.insert(u87, child);
            end;
        end;

        if u52 then
            for _, child in ipairs(v236[u52.Name]:GetChildren()) do
                if child.Name == "SightReticle" then
                    table.insert(u87, child);
                end;
            end;
        end;

        v236.Parent = rig.Weapon;
        u68 = v236;
        WeldMod.BlankM6D(rig.AnimBase, v236.Grip);

        if u31 then
            RefreshViewmodel();
        end;

        BuildCursor(v236.Grip:WaitForChild("Muzzle"));
        BindGunInputs();
        ToggleSprint(u45);
        EquipAnim();
        PlayAnimation(u66.idleAnim, {
            looped = true,
            priority = Enum.AnimationPriority.Idle
        });
        u69 = u234:WaitForChild("Ammo");
        local ammoType = u66.ammoType;
        local AmmoPool = Parent:FindFirstChild("AmmoPool");
        u75 = AmmoPool:FindFirstChild(ammoType) or AmmoPool.Universal;
        u76 = u75.CurrentValue;

        if not u65.BoltReady.Value then
            MoveBolt(u66.boltDist, true);
        end;

        if GameConfig.lockFirstPerson then
            LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
        end;

        u63 = u65.FireMode.Value;

        if u68.Grip:FindFirstChild("Laser") then
            Beam.Attachment0 = u68.Grip.Laser;
        end;

        if ModTable.EnableLaserAtt then
            Beam.Attachment0 = u68[ModTable.laserAtt].Main.Laser;
        end;

        local reloadSpeedModifier = u66.reloadSpeedModifier;

        if ModTable.reloadSpeedModifier then
            reloadSpeedModifier = ModTable.reloadSpeedModifier;
        end;

        if u66.magType == 1 then
            PlayAnimation(u66.reloadAnim, {
                transSpeed = 0.17,
                speed = reloadSpeedModifier,
                priority = Enum.AnimationPriority.Action2
            }, "Reload", true);
        else
            PlayAnimation(u66.reloadAnim, {
                transSpeed = 0,
                speed = reloadSpeedModifier,
                priority = Enum.AnimationPriority.Action2,
                looped = u69.MagAmmo.MaxValue > 1
            }, "Reload", true);

            if u66.magType == 3 then
                PlayAnimation(u66.clipReloadAnim, {
                    transSpeed = 0.17,
                    looped = false,
                    speed = reloadSpeedModifier,
                    priority = Enum.AnimationPriority.Action2
                }, "Reload", true);
            end;
        end;

        PlayAnimation(u66.equipAnim, {
            priority = Enum.AnimationPriority.Action2
        }, "Equip", true).Stopped:Once(function() -- Line: 2653
            -- upvalues: u32 (ref), Parent (ref), u65 (ref), u234 (copy), u66 (ref), u70 (ref), u44 (ref), u69 (ref), ChamberAnim (ref)
            u32 = false;
            local Attribute = Parent:GetAttribute("_ReloadingUntil");

            if type(Attribute) == "number" and os.clock() < Attribute then
                return;
            end;

            if u65 == u234 and (u66 and not (u66.openBolt or (u70 or (u44 or not (u65:FindFirstChild("Chambered") and (not u65.Chambered.Value and (u69 and (u69:FindFirstChild("MagAmmo") and u69.MagAmmo.Value > 0)))))))) then
                ChamberAnim();
            end;
        end);
        PlayAnimation(u66.boltChamber, {
            transSpeed = 0.05,
            looped = false,
            priority = Enum.AnimationPriority.Action2
        }, "Chamber", true);

        if u66.operationType == 2 or u66.operationType == 3 then
            PlayAnimation(u66.boltOpen, {
                transSpeed = 0,
                looped = false,
                priority = Enum.AnimationPriority.Action2
            }, "BoltOpen", true);
            PlayAnimation(u66.boltClose, {
                looped = false,
                priority = Enum.AnimationPriority.Action2
            }, "BoltClose", true);
        end;
    end;
end);
Parent.ChildRemoved:Connect(function(p238) -- Line: 2697
    -- upvalues: u65 (ref), SPH_Assets (copy)
    if u65 and (p238:FindFirstChild("SPH_Weapon") and SPH_Assets.WeaponModels:FindFirstChild(p238.Name)) then
        Unequip(p238);
    end;
end);

local function IsActuallyAiming() -- Line: 2703
    -- upvalues: u71 (ref), u31 (ref), UserInputService (copy)
    local v239 = u71 or not u31 and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);

    return v239;
end;

RunService.Heartbeat:Connect(function(p240: number) -- Line: 2707
    -- upvalues: u65 (ref), u33 (ref), u29 (ref), u30 (ref), u67 (ref), u70 (ref), u34 (ref), u36 (ref), Parent (copy), u37 (ref), u66 (ref), u69 (ref), u63 (ref), GameConfig (copy), u73 (ref), u32 (ref), u31 (ref), PlayAnimation (copy), BlurEffect (copy), u64 (ref), u42 (ref), u100 (copy), u68 (ref), ModTable (copy), u71 (ref), UserInputService (copy), u79 (ref), u9 (copy), u61 (ref), u10 (copy), u155 (copy), ShellEjection (copy), LocalPlayer (copy), BulletHandler (copy), MoveBolt (copy), WeaponCondition (copy), u13 (copy), u98 (ref), ChamberAnim (copy), u44 (ref), u16 (copy)
    if u65 and (not u33 and (u29 and (u30 and not (u67 or u70)))) then
        if u34 and not (u36 or (Parent:GetAttribute("_UsingItem") or (u65:GetAttribute("WeaponJammed") or u37 ~= 0))) then
            if (not u66.openBolt and u65.Chambered.Value or u66.openBolt and u69.MagAmmo.Value > 0) and (u63 > 0 and (GameConfig.fireWithFreelook or not (GameConfig.fireWithFreelook or u73))) and not u32 then
                if not (u31 or GameConfig.thirdPersonFiring) then
                    return;
                end;

                if u66.fireAnim then
                    PlayAnimation(u66.fireAnim, {
                        looped = false,
                        priority = Enum.AnimationPriority.Action2
                    });
                end;

                if u66.fireBlur and u66.fireBlur > 0 then
                    task.spawn(function() -- Line: 2729
                        -- upvalues: BlurEffect (ref), u66 (ref)
                        BlurEffect.Size = u66.fireBlur;
                        BlurEffect.Enabled = true;
                        task.wait(0.095);
                        BlurEffect.Enabled = false;
                    end);
                end;

                u64 = u64 + 1;
                u42 = false;

                if u63 == 1 or (u63 == 4 or u63 == 3 and u64 >= u66.burstNumber) then
                    u34 = false;
                    u29 = false;
                end;

                u30 = false;
                u100.Weapon:FindFirstChildWhichIsA("Model");
                local v241 = u68;
                local recoil = u66.recoil;
                local v242 = recoil.vertical * ModTable.recoilMod.vertical;
                local v243 = recoil.horizontal * ModTable.recoilMod.horizontal;
                local v244 = u71 or not u31 and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);

                if v244 then
                    v242 = v242 / (recoil.aimReduction * ModTable.recoilMod.aimReduction);
                    v243 = v243 / (recoil.aimReduction * ModTable.recoilMod.aimReduction);
                end;

                if u79 == 2 then
                    v242 = v242 / 2;
                    v243 = v243 / 2;
                end;

                local math_random_ret = math.random(-v243, v243);
                u9:shove((Vector3.new(v242, math_random_ret, recoil.camShake)));
                local gunRecoil = u66.gunRecoil;
                local vertical = gunRecoil.vertical;
                local horizontal = gunRecoil.horizontal;

                if u79 == 2 then
                    vertical = vertical / 1.5;
                    horizontal = horizontal / 1.5;
                end;

                if u61 then
                    vertical = vertical * 0.25;
                    horizontal = horizontal * 0.25;
                end;

                if u79 == 2 then
                    vertical = vertical / 2;
                    horizontal = horizontal / 2;
                end;

                local v245 = math.random() > 0.5 and 1 or -1;
                local v246 = horizontal * 0.5 + math.random() * horizontal * 0.5;
                local v247 = vertical * (0.85 + math.random() * 0.3);
                u10:shove((Vector3.new(v247, v245 * v246, gunRecoil.punchMultiplier)));
                u155.rattle = math.min(u155.rattle + 0.4, 1);
                u155.lastActive = tick();

                if u63 ~= 4 then
                    u42 = true;

                    if u66.shellEject then
                        if u31 then
                            ShellEjection.ejectShell(LocalPlayer, u65, u68);
                        else
                            ShellEjection.ejectShell(LocalPlayer, u65, u100.Weapon:FindFirstChildWhichIsA("Model"));
                        end;
                    end;
                end;

                local v248 = u66.bulletHolder and u68:FindFirstChild(u66.bulletHolder);
                local v249 = v248 and v248:FindFirstChild("Bullet" .. u69.MagAmmo.MaxValue - (u69.MagAmmo.Value - 1));

                if v249 then
                    v249.Transparency = 1;
                end;

                local v250 = u68;

                if not u31 then
                    v250 = u100.Weapon:FindFirstChildWhichIsA("Model");
                end;

                if ModTable.muzzleChance then
                    if ModTable.IsSuppressor then
                        BulletHandler.FireFX(LocalPlayer, v250, "Muzzle", ModTable.muzzleChance, true);
                    else
                        BulletHandler.FireFX(LocalPlayer, v250, "Muzzle", ModTable.muzzleChance, false);
                    end;
                else
                    BulletHandler.FireFX(LocalPlayer, v250, "Muzzle", u66.muzzleChance);
                end;

                MoveBolt(u66.boltDist);
                local v251 = u66.shotgun and u66.shotgunPellets or 1;

                if ModTable.shotgun then
                    v251 = ModTable.shotgunPellets;
                end;

                while true do
                    v251 = v251 - 1;
                    local spread = u66.spread;

                    if ModTable.spread then
                        spread = spread * ModTable.spread;
                    end;

                    local v252 = WeaponCondition.ApplySpread(spread, u65:GetAttribute(WeaponCondition.ATTR));
                    local CFrame_Angles = CFrame.Angles;
                    local math_random_ret2 = math.random(-v252, v252);
                    local math_rad_ret = math.rad(math_random_ret2);
                    local math_random_ret3 = math.random(-v252, v252);
                    local v253 = CFrame_Angles(math_rad_ret, math.rad(math_random_ret3), 0);
                    local v254, v255;

                    if u31 then
                        v254 = v241.Grip.Muzzle.WorldCFrame.Position;
                        v255 = (v241.Grip.Muzzle.WorldCFrame * v253).LookVector;
                    else
                        local Muzzle = u100.Weapon:FindFirstChildWhichIsA("Model").Grip.Muzzle;
                        v254 = Muzzle.WorldCFrame.Position;
                        v255 = (Muzzle.WorldCFrame * v253).LookVector;
                    end;

                    local muzzleVelocity = u66.muzzleVelocity;

                    if ModTable.muzzleVelocity then
                        muzzleVelocity = ModTable.muzzleVelocity;
                    end;

                    local v256 = nil;
                    local tracers = u66.tracers;
                    local tracerTiming = u66.tracerTiming;
                    local tracerColor = u66.tracerColor;

                    if ModTable.tracers then
                        tracers = ModTable.tracers;
                        tracerTiming = ModTable.tracerTiming;
                        tracerColor = ModTable.tracerColor;
                    end;

                    if tracers then
                        if u69.MagAmmo.Value % tracerTiming ~= 0 then
                            tracerColor = v256;
                        end;
                    else
                        tracerColor = v256;
                    end;

                    if tracerColor == "Random" then
                        tracerColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255));
                    end;

                    BulletHandler.FireBullet(u100, v254, v255, v255 * muzzleVelocity * 3.5, u65, LocalPlayer, tracerColor, false, ModTable);

                    if v251 <= 0 then
                        u13:Fire(v241.Grip.Muzzle.WorldCFrame, ModTable);

                        if u98 then
                            local vertical2 = gunRecoil.vertical;
                            local math_random_ret4 = math.random(-gunRecoil.horizontal, gunRecoil.horizontal);
                            u98:Shove(Vector3.new(vertical2, math_random_ret4, gunRecoil.punchMultiplier) * p240 * 60);
                        end;

                        local v257 = u66.fireRate * ModTable.fireRate;

                        if u63 == 3 and u66.burstFireRate then
                            v257 = u66.burstFireRate;
                        end;

                        if u68 and (u66.projectile ~= "Bullet" and u68:FindFirstChild(u66.projectile)) then
                            local v258 = u68:FindFirstChild(u66.projectile);
                            v258.LocalTransparencyModifier = 1;

                            for _, descendant in ipairs(v258:GetDescendants()) do
                                if descendant:IsA("BasePart") then
                                    descendant.LocalTransparencyModifier = 1;
                                end;
                            end;
                        end;

                        task.wait(60 / v257);

                        if not u65 then
                            return;
                        end;

                        if u66.autoChamber and (u63 == 4 and not u70) then
                            ChamberAnim();
                        end;

                        u30 = true;

                        return;
                    end;
                end;
            end;
        end;

        if not u66.openBolt and u65.Chambered.Value or u66.openBolt and u69.MagAmmo.Value > 0 then
            if u66.emptyCloseBolt then
                u16:Fire();
                MoveBolt(CFrame.new());
            end;
        elseif u63 == 4 and (u69.MagAmmo.Value > 0 and not (u70 or u44)) then
            ChamberAnim();
            u29 = false;
        end;
    end;
end);
RunService.RenderStepped:Connect(function(p259: number) -- Line: 2940
    -- upvalues: u59 (ref), u65 (ref), workspace_CurrentCamera (copy), ModTable (copy), u54 (ref), u62 (copy), u61 (ref), u60 (ref), u21 (copy), u77 (ref), Humanoid (copy), u41 (ref), u31 (ref), u73 (ref), GameConfig (copy), HumanoidRootPart (copy), u33 (ref), Parent (copy), u67 (ref), u1 (ref), u11 (copy), BindAiming (copy), u40 (ref), u68 (ref), u100 (copy), u39 (ref), u95 (copy), Beam (copy), ContextActionService (copy), u35 (ref), u86 (ref), u84 (ref), u74 (ref), u66 (ref), u85 (copy), u28 (copy), ChangeDoF (copy), u79 (ref), walkSpeed (ref), u45 (ref), sprintKeyIsDown (copy), u209 (copy), u71 (ref), isForwardDominant (copy), ToggleSprint (copy), u98 (ref), RaycastParams_new_ret (copy), u89 (ref), RootJoint (copy), u90 (ref), UserInputService (copy), u26 (ref), RefreshViewmodel (copy), UpdateViewmodelPosition (copy), LocalPlayer (copy), u94 (copy), Trail (copy), Attachment (copy), u32 (ref), u27 (ref), u8 (copy), rig_AnimBase (copy), u87 (ref), FieldOfView2 (ref), u2 (copy), u3 (copy), GetRotationBetween (copy)
    if math.ceil(1 / p259) < 5 then
        print("【 SPEARHEAD 】 RenderStepped skipped due to low framerate.");

        return;
    end;

    local v260 = u59 and (u65 and workspace_CurrentCamera:WaitForChild("WeaponRig").Weapon:FindFirstChildWhichIsA("Model")) and (ModTable.bipodAtt or workspace_CurrentCamera.WeaponRig.Weapon:FindFirstChildWhichIsA("Model").Grip:FindFirstChild("Bipod"));

    if v260 then
        if u54 then
            v260 = workspace_CurrentCamera.WeaponRig.Weapon:FindFirstChildWhichIsA("Model")[u54.Name].Main.Bipod;
        end;

        local Ray_new_ret = Ray.new(v260.WorldCFrame.Position, Vector3.new(0, -1.5, 0));
        local v261, _, _ = workspace:FindPartOnRayWithIgnoreList(Ray_new_ret, u62, false, true);

        if u61 and not u60 then
            u61 = false;
            BipodToggle(workspace_CurrentCamera.WeaponRig, u61);
            u21:Fire(2, u61, ModTable);
        end;

        if v261 then
            u60 = true;
        else
            u60 = false;
        end;
    end;

    u77 = u77 - p259;

    if (Humanoid.Sit and (not u41 and u31) or u73) and GameConfig.cameraLimitInSeats then
        local v262, v263, v264 = HumanoidRootPart.CFrame:ToObjectSpace(workspace_CurrentCamera.CFrame):ToOrientation();
        local X = workspace_CurrentCamera.CFrame.Position.X;
        local Y = workspace_CurrentCamera.CFrame.Position.Y;
        local Z = workspace_CurrentCamera.CFrame.Position.Z;
        local math_deg_ret = math.deg(v262);
        local math_clamp_ret = math.clamp(math_deg_ret, -60, 60);
        local math_rad_ret = math.rad(math_clamp_ret);
        local math_deg_ret2 = math.deg(v263);
        local math_clamp_ret2 = math.clamp(math_deg_ret2, -60, 60);
        local math_rad_ret2 = math.rad(math_clamp_ret2);
        local math_deg_ret3 = math.deg(v264);
        local math_clamp_ret3 = math.clamp(math_deg_ret3, -60, 60);
        local math_rad_ret3 = math.rad(math_clamp_ret3);
        local v265 = HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(X, Y, Z) * CFrame.fromOrientation(math_rad_ret, math_rad_ret2, math_rad_ret3));
        workspace_CurrentCamera.CFrame = CFrame.new(workspace_CurrentCamera.CFrame.Position) * (v265 - v265.Position);
    end;

    if not u33 and Parent:FindFirstChild("Head") then
        if not u33 then
            local v266;

            if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                v266 = Parent.Torso.CFrame.LookVector;
            else
                v266 = Parent.UpperTorso.CFrame.LookVector;
            end;

            local CFrame2 = workspace_CurrentCamera.CFrame;

            if not (GameConfig.headRotation and not u67 or u31) then
                CFrame2 = HumanoidRootPart.CFrame;
            end;

            local LookVector = HumanoidRootPart.CFrame:ToObjectSpace(CFrame2).LookVector;
            local v267 = CFrame.Angles(0, math.asin(LookVector.X) / 1.15, 0) * CFrame.Angles(-math.asin(CFrame2.LookVector.Y) + math.asin(v266.Y), 0, 0);
            local v268 = CFrame.new(0, -0.5, 0) * v267 * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793);
            u1.C1 = u1.C1:Lerp(v268, 1 - math.exp(-GameConfig.headRotationSpeed * p259));

            if u77 <= 0 and not (u33 or GameConfig.disableHeadRotation) then
                u77 = GameConfig.headRotationEventRate;
                u11:Fire(u1.C1);
            end;
        end;

        if u31 or Parent.Head.LocalTransparencyModifier < 0.6 then
            if u31 and Parent.Head.LocalTransparencyModifier <= 0.6 then
                u31 = false;
                ContextActionService:UnbindAction("SPH_HoldAim");

                if u65 then
                    if u39 then
                        u95.Enabled = true;
                        Beam.Enabled = false;

                        if not u95.Attachment0 then
                            u95.Attachment0 = u100.Weapon:FindFirstChildWhichIsA("Model").Grip:FindFirstChild("Laser") or u100.Weapon:FindFirstChildWhichIsA("Model")[ModTable.laserAtt].Main.Laser;
                        end;
                    end;

                    if u68.Grip:FindFirstChild("Flashlight") then
                        u68.Grip.Flashlight:FindFirstChildWhichIsA("Light").Enabled = false;

                        if u100.Weapon:FindFirstChildWhichIsA("Model") and u40 then
                            u100.Weapon:FindFirstChildWhichIsA("Model").Grip.Flashlight:FindFirstChildWhichIsA("Light").Enabled = true;
                        end;
                    end;
                end;

                u35 = false;
                u86 = Vector3.new(0, 0, 0);
            end;
        else
            u31 = true;

            if u65 then
                BindAiming();

                if u40 and u68.Grip:FindFirstChild("Flashlight") then
                    u68.Grip.Flashlight:FindFirstChildWhichIsA("Light").Enabled = true;
                    u100.Weapon:FindFirstChildWhichIsA("Model").Grip.Flashlight:FindFirstChildWhichIsA("Light").Enabled = false;
                end;

                if u39 then
                    u95.Enabled = false;
                    Beam.Enabled = true;
                end;
            end;
        end;

        if u84 then
            u84:AdjustSpeed(Humanoid.WalkSpeed / 6);
        end;

        if Humanoid.MoveDirection.Magnitude > 0 and not u74 then
            u74 = true;

            if u84 then
                u84:Play(GameConfig.stanceChangeTime);
            end;
        elseif Humanoid.MoveDirection.Magnitude <= 0 then
            u74 = false;

            if u67 then
                u67 = false;
                Parent:SetAttribute("Sprinting", false);

                if u66 then
                    local sprintAnim = u66.sprintAnim;

                    if u85[sprintAnim] then
                        u85[sprintAnim]:Stop(0.2);
                        u85[sprintAnim .. "ThirdPerson"]:Stop(0.2);
                    end;

                    if u28 then
                        ChangeDoF(0, 0, 0, 0);
                    end;
                end;

                if u79 == 1 then
                    walkSpeed = GameConfig.crouchSpeed;
                elseif u79 == 2 then
                    walkSpeed = GameConfig.proneSpeed;
                else
                    walkSpeed = GameConfig.walkSpeed;
                end;
            end;

            if u84 then
                u84:Stop(GameConfig.stanceChangeTime);
            end;
        end;

        if u45 then
            if sprintKeyIsDown() then
                u209.keyLastDown = os.clock();
            elseif os.clock() - u209.keyLastDown > u209.strandGrace then
                u45 = false;

                if u67 then
                    u67 = false;
                    Parent:SetAttribute("Sprinting", false);

                    if u66 then
                        local sprintAnim = u66.sprintAnim;

                        if u85[sprintAnim] then
                            u85[sprintAnim]:Stop(0.2);
                            u85[sprintAnim .. "ThirdPerson"]:Stop(0.2);
                        end;

                        if u28 then
                            ChangeDoF(0, 0, 0, 0);
                        end;
                    end;
                end;

                if u79 == 1 then
                    walkSpeed = GameConfig.crouchSpeed;
                elseif u79 == 2 then
                    walkSpeed = GameConfig.proneSpeed;
                else
                    walkSpeed = GameConfig.walkSpeed;
                end;
            end;
        end;

        if u74 and (u45 and (u79 == 0 and not u71)) then
            if isForwardDominant() then
                u209.nonFwdTimer = 0;

                if not u67 and u65 then
                    ToggleSprint(true);
                end;

                walkSpeed = GameConfig.sprintSpeed;
            else
                u209.nonFwdTimer = u209.nonFwdTimer + p259;

                if u209.nonFwdTimer < u209.graceTime and u67 then
                    walkSpeed = GameConfig.sprintSpeed;
                else
                    if u67 then
                        u67 = false;
                        Parent:SetAttribute("Sprinting", false);

                        if u66 then
                            local sprintAnim = u66.sprintAnim;

                            if u85[sprintAnim] then
                                u85[sprintAnim]:Stop(0.2);
                                u85[sprintAnim .. "ThirdPerson"]:Stop(0.2);
                            end;

                            if u28 then
                                ChangeDoF(0, 0, 0, 0);
                            end;
                        end;
                    end;

                    walkSpeed = GameConfig.walkSpeed * u209.strafeMult;
                end;
            end;
        else
            u209.nonFwdTimer = u209.graceTime;
        end;

        if u98 then
            local v269;

            if u31 then
                v269 = workspace_CurrentCamera.WeaponRig.Weapon:FindFirstChildWhichIsA("Model");
            else
                v269 = u100.Weapon:FindFirstChildWhichIsA("Model");
            end;

            if v269 then
                local Muzzle = v269.Grip.Muzzle;
                local v270 = workspace:Raycast(Muzzle.WorldPosition, Muzzle.WorldCFrame.LookVector * 600, RaycastParams_new_ret);

                if v270 then
                    u98:SetWorldPosition(v270.Position);
                else
                    u98:SetWorldPosition(Muzzle.WorldPosition + Muzzle.WorldCFrame.LookVector * 600);
                end;
            end;
        end;

        if GameConfig.firstPersonBody and u31 then
            local v271 = -1.2 + (Parent.HumanoidRootPart.CFrame:ToObjectSpace(workspace_CurrentCamera.CFrame):ToEulerAngles() + 1.4) / 2.8;
            u86 = Vector3.new(0, 0, v271);
        else
            u86 = Vector3.new(0, 0, 0);
        end;

        local v272 = 0;
        local v273 = 0;
        local Z = u86.Z;

        if u79 == 1 then
            v273 = -1;

            if u31 then
                Z = Z - 0.3;
            end;
        elseif u79 == 2 then
            v273 = -1.5;

            if u31 then
                Z = -1.7;
            end;
        end;

        if u89 < 0 then
            v273 = v273 + -0.2;
            v272 = -1;
        elseif u89 > 0 then
            v273 = v273 + -0.2;
            v272 = 1;
        end;

        if not u41 and workspace_CurrentCamera.CameraType == Enum.CameraType.Custom then
            u86 = Vector3.new(v272, v273, Z);
            Humanoid.CameraOffset = Humanoid.CameraOffset:Lerp(u86, p259 * 0.1 * 60);
            RootJoint.C1 = RootJoint.C1:Lerp(CFrame.new(-v272 / 2, 0, 0) * CFrame.Angles(1.5707963267948966, math.rad(u89 * 17) + 3.141592653589793, 0), p259 * 0.1 * 60);
            local v274 = u90;
            u90 = v274 + (-u89 * 15 - v274) * (1 - 0.9 ^ (p259 * 60));
            local v275 = workspace_CurrentCamera;
            v275.CFrame = v275.CFrame * CFrame.Angles(0, 0, (math.rad(u90)));

            if GameConfig.cameraTilting and u31 then
                local v276 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.Velocity);
                local MouseDelta = UserInputService:GetMouseDelta();
                local v277 = u26;
                u26 = v277 + (math.clamp(-v276.X, -2, 2) + MouseDelta.X / 2 - v277) * (p259 * 0.07 * 60);
                local v278 = workspace_CurrentCamera;
                v278.CFrame = v278.CFrame * CFrame.Angles(0, 0, (math.rad(u26)));
            end;
        end;

        if u65 and workspace_CurrentCamera.CameraType == Enum.CameraType.Custom then
            if u31 and not u35 then
                RefreshViewmodel();
                ToggleSprint(u45);
            end;

            UpdateViewmodelPosition(p259);

            if u39 then
                LocalPlayer:SetAttribute("rangefinderActive", true);
                local v279 = u68.Grip:FindFirstChild("Laser") or u68[ModTable.laserAtt].Main.Laser;
                local v280 = u100.Weapon:FindFirstChildWhichIsA("Model").Grip:FindFirstChild("Laser") or u100.Weapon:FindFirstChildWhichIsA("Model")[ModTable.laserAtt].Main.Laser;

                if not u94.Enabled then
                    u94.Enabled = true;
                    u94.Dot.ImageColor3 = v279.Color.Value;
                    local Value = v279.Color.Value;
                    Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(1, Value) });

                    if GameConfig.laserTrail then
                        Beam.Color = ColorSequence.new(v279.Color.Value);
                        u95.Color = ColorSequence.new(v279.Color.Value);

                        if u31 then
                            Beam.Enabled = true;
                        else
                            u95.Enabled = true;

                            if not u95.Attachment0 then
                                u95.Attachment0 = v280;
                            end;
                        end;
                    end;
                end;

                if u31 then
                    v280 = v279 or v280;
                end;

                local RaycastParams_new_ret2 = RaycastParams.new();
                RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
                RaycastParams_new_ret2.FilterDescendantsInstances = { u68, Parent };
                RaycastParams_new_ret2.RespectCanCollide = true;
                local v281 = workspace:Raycast(v280.WorldPosition, v280.WorldCFrame.LookVector * 600, RaycastParams_new_ret2);

                if v281 then
                    Attachment.WorldPosition = v281.Position;

                    if ModTable.isRangefinder then
                        LocalPlayer:SetAttribute("tgtDistance", (Parent.Head.Position - v281.Position).Magnitude * 0.28);
                    end;
                else
                    Attachment.WorldPosition = v280.WorldCFrame.LookVector * 600;
                    LocalPlayer:SetAttribute("tgtDistance", nil);
                end;
            elseif u94.Enabled then
                u94.Enabled = false;
                Beam.Enabled = false;
                u95.Enabled = false;
                LocalPlayer:SetAttribute("rangefinderActive", false);
            end;
        elseif u35 and not u32 then
            u35 = false;
        end;

        local bobDampening = GameConfig.bobDampening;
        local v282 = bobDampening - (bobDampening - bobDampening / (u27 / GameConfig.walkSpeed)) / 2;

        if u71 then
            v282 = v282 * GameConfig.aimBobDampening;
        end;

        local v283 = GameConfig.bobSpeed * (u27 / GameConfig.walkSpeed);

        if not Humanoid.Sit then
            local v284 = tick() * v283 * 1.3;
            local v285 = math.sin(v284) * 0.3;
            local v286 = tick() * (v283 / 2) * 1.3;
            local v287 = math.sin(v286) * 0.3;
            local v288 = tick() * (v283 / 2) * 1.3;
            local v289 = math.sin(v288) * 0.3;
            u8:shove(Vector3.new(v285, v287, v289) / v282 * HumanoidRootPart.Velocity.Magnitude / v282 * p259 * 60);
        end;

        local v290 = u8:update(p259);
        rig_AnimBase.CFrame = rig_AnimBase.CFrame:ToWorldSpace(CFrame.new(v290.Y, v290.X, 0) * CFrame.Angles(v290.Y * 0.3, 0, v290.Y * 0.8));

        if GameConfig.cameraMovement and (u31 and not (Humanoid.Sit or (u41 or workspace_CurrentCamera.CameraType ~= Enum.CameraType.Custom))) then
            local Position = u8.Position;
            local v291 = workspace_CurrentCamera;
            v291.CFrame = v291.CFrame * CFrame.Angles(math.rad(Position.X / GameConfig.cameraBobDampening), math.rad(Position.Y / GameConfig.cameraBobDampening), 0);
        end;

        for _, v in ipairs(u87) do
            local Frame = v.SurfaceGui.Frame;
            local v292 = Frame:FindFirstChild("Reticle") or Frame:FindFirstChild("Holo");
            local v293 = v.CFrame:PointToObjectSpace(workspace_CurrentCamera.CFrame.Position) / v.Size;
            v292.Position = UDim2.fromScale(0.5 + v293.X, 0.5 - v293.Y);

            if v292.Name == "Holo" then
                local v294 = workspace_CurrentCamera.FieldOfView / 70;
                v292.Size = UDim2.fromScale(v294, v294);
            end;
        end;

        if u71 and not LocalPlayer:GetAttribute("CK_ScopeOwnsFov") then
            local FieldOfView3 = workspace_CurrentCamera.FieldOfView;
            workspace_CurrentCamera.FieldOfView = FieldOfView3 + (FieldOfView2 - FieldOfView3) * (1 - 0.7 ^ (p259 * 60));
        end;
    end;

    u27 = walkSpeed;

    for _, v in pairs(u2) do
        u27 = math.min(u27, v);
    end;

    if script:GetAttribute("WalkspeedOverrideToggle") then
        local Attribute = script:GetAttribute("WalkspeedOverride");

        if type(Attribute) == "number" then
            u27 = math.min(u27, Attribute);
        end;
    end;

    for _, v in pairs(u3) do
        u27 = u27 * v;
    end;

    local Attribute = script:GetAttribute("SpeedBoost_Admin");

    if type(Attribute) == "number" and Attribute > 1 then
        u27 = u27 * math.clamp(Attribute, 1, 10);
    end;

    if Humanoid.Health < 30 and GameConfig.lowHealthEffects then
        u27 = u27 * (Humanoid.Health / 30);
    end;

    local WalkSpeed = Humanoid.WalkSpeed;
    Humanoid.WalkSpeed = WalkSpeed + (u27 - WalkSpeed) * ((u27 > Humanoid.WalkSpeed and 0.06 or 0.15) * p259 * 60);

    if u79 == 2 and GameConfig.proneAngle then
        local RaycastParams_new_ret2 = RaycastParams.new();
        RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret2.FilterDescendantsInstances = { Parent };
        RaycastParams_new_ret2.IgnoreWater = true;
        RaycastParams_new_ret2.RespectCanCollide = true;
        local v295 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -2, 0), RaycastParams_new_ret2);

        if v295 and v295.Instance then
            local v296 = GetRotationBetween(HumanoidRootPart.CFrame.UpVector, v295.Normal, Vector3.new(1, 0, 0));
            local v297 = RootJoint;
            v297.C0 = v297.C0 * CFrame.Angles(v296.X, v296.Y, v296.Z);
            local _ = v296 * HumanoidRootPart.CFrame;
        end;
    end;
end);
UserInputService.InputChanged:Connect(function(p298) -- Line: 3427
    -- upvalues: u71 (ref), UserInputService (copy), GameConfig (copy), LocalPlayer (copy), FieldOfView2 (ref), u66 (ref), FieldOfView (copy), u91 (ref)
    if u71 and p298.UserInputType == Enum.UserInputType.MouseWheel then
        if UserInputService:IsKeyDown(GameConfig.holdForScrollZoom) then
            if LocalPlayer:GetAttribute("CK_ScopeOwnsFov") then
                return;
            end;

            FieldOfView2 = math.clamp(FieldOfView2 - p298.Position.Z * 3, u66.aimFovMin, u66.aimFovMax or FieldOfView);

            return;
        end;

        u91 = require(game:GetService("ReplicatedStorage").SPH_Assets.Modules.AimSensitivity).Step(u91, p298.Position.Z);
        require(game:GetService("ReplicatedStorage").SPH_Assets.Modules.AimSensitivity).SetCameraScale(u91);
    end;
end);
Humanoid.Seated:Connect(function(p299, p300) -- Line: 3464
    -- upvalues: ContextActionService (copy), u67 (ref), Parent (copy), u66 (ref), u85 (copy), u28 (copy), ChangeDoF (copy), GameConfig (copy), u89 (ref), PlayCharSound (copy), u24 (copy), u79 (ref), ChangeStance (copy), u41 (ref), u65 (ref), Humanoid (copy), BindCharacterInputs (copy)
    if p299 then
        ContextActionService:UnbindAction("SPH_Sprint");
        ContextActionService:UnbindAction("SPH_StanceLower");
        ContextActionService:UnbindAction("SPH_StanceRaise");
        ContextActionService:UnbindAction("SPH_LeanLeft");
        ContextActionService:UnbindAction("SPH_LeanRight");
        u67 = false;
        Parent:SetAttribute("Sprinting", false);

        if u66 then
            local sprintAnim = u66.sprintAnim;

            if u85[sprintAnim] then
                u85[sprintAnim]:Stop(0.2);
                u85[sprintAnim .. "ThirdPerson"]:Stop(0.2);
            end;

            if u28 then
                ChangeDoF(0, 0, 0, 0);
            end;
        end;

        if GameConfig.canLean then
            if u89 ~= 0 then
                PlayCharSound("Lean");
            end;

            u89 = 0;
            u24:Fire(0);
        end;

        if u79 == 1 then
            ChangeStance(-1);
        elseif u79 == 2 then
            ChangeStance(-1);
            ChangeStance(-1);
        end;

        if not p300:IsA("VehicleSeat") then
            u41 = false;

            return;
        end;

        u41 = true;

        if u65 then
            Humanoid:UnequipTools();
        end;
    else
        BindCharacterInputs();
        u41 = false;
    end;
end);
local u301 = true;
UserInputService.JumpRequest:Connect(function() -- Line: 3492
    -- upvalues: Humanoid (copy), Parent (copy), u79 (ref), u301 (ref), GameConfig (copy)
    if Humanoid.Sit then
        Parent.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);

        return;
    end;

    if u79 ~= 0 then
        Parent.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);

        return;
    end;

    if Parent.Humanoid.FloorMaterial == Enum.Material.Air then
        return;
    end;

    if not u301 then
        Parent.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);

        return;
    end;

    u301 = false;
    Parent.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
    task.wait(GameConfig.jumpCooldown);
    u301 = true;
end);