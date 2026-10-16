-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
game:GetService("HttpService");
local SPH_Assets = ReplicatedStorage.SPH_Assets;
local _ = SPH_Assets.Animations;
local Modules = SPH_Assets.Modules;
local _ = Players.LocalPlayer;
local GameConfig = require(SPH_Assets.GameConfig);
print("【 SPEARHEAD 】 " .. "Loading Client " .. GameConfig.version);
local HitFX = require(Modules.HitFX);
local ShellEjection = require(Modules.ShellEjection);
local BulletHandler = require(Modules.BulletHandler);
local BridgeNet = require(ReplicatedStorage.SPH_Assets.Modules.BridgeNet);
local v1 = BridgeNet.CreateBridge("BodyAnimCommand");
local v2 = BridgeNet.CreateBridge("ReplicateFire");
local v3 = BridgeNet.CreateBridge("ReplicateSound");
local v4 = BridgeNet.CreateBridge("ReplicateHit");
local v5 = BridgeNet.CreateBridge("ReplicateBolt");
local v6 = BridgeNet.CreateBridge("ReplicateCharacterSound");
local v7 = BridgeNet.CreateBridge("ReplicateToggleAttachment");
local v8 = BridgeNet.CreateBridge("ReplicateMagGrab");
local v9 = BridgeNet.CreateBridge("ReplicateLean");
local v10 = BridgeNet.CreateBridge("ReplicateBipodSound");
local u11 = {};
local u12 = {};

local function AddRig(p13: userdata, p14: string) -- Line: 38
    -- upvalues: u11 (copy)
    u11[p14] = {
        animator = p13.AnimationController.Animator,
        LoadedAnimations = {}
    };
end;

v1:Connect(function(p15: userdata, p16: any) -- Line: 109
    -- upvalues: GameConfig (copy), TweenService (copy)
    if not p15 then
        return;
    end;

    local Humanoid = p15:FindFirstChild("Humanoid");

    if not (Humanoid and (Humanoid.Health > 0 and (p15:FindFirstChild("Torso") or p15:FindFirstChild("UpperTorso")))) then
        return;
    end;

    local v17;

    if p15.Humanoid.RigType == Enum.HumanoidRigType.R6 then
        v17 = p15.Torso.Neck;
    else
        v17 = p15.UpperTorso.Neck;
    end;

    TweenService:Create(v17, TweenInfo.new(GameConfig.replicatedHeadRotationSpeed, Enum.EasingStyle.Quad), {
        C1 = p16
    }):Play();
end);
v9:Connect(function(p18: userdata, p19: any) -- Line: 129
    -- upvalues: TweenService (copy)
    if not p18 then
        return;
    end;

    if not p18:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    local v20 = CFrame.new(-p19 / 2, 0, 0) * CFrame.Angles(1.5707963267948966, math.rad(17 * p19) + 3.141592653589793, 0);
    local RootJoint = p18.HumanoidRootPart:FindFirstChild("RootJoint");

    if RootJoint then
        TweenService:Create(RootJoint, TweenInfo.new(0.5), {
            C1 = v20
        }):Play();
    end;
end);
v2:Connect(function(p21: userdata, p22, p23: boolean, p24: any) -- Line: 46, Name: FireBullet
    -- upvalues: BulletHandler (copy), ShellEjection (copy)
    local v25;

    if p21 then
        v25 = p21.Character;
    else
        v25 = p21;
    end;

    if not (v25 and v25:FindFirstChild("WeaponRig")) then
        return;
    end;

    local v26 = v25:FindFirstChildWhichIsA("Tool");

    if v26 and v26:FindFirstChild("SPH_Weapon") then
        local WeaponRig = v25.WeaponRig;
        local v27 = WeaponRig.Weapon:FindFirstChildWhichIsA("Model");
        local WeaponStats = require(v26.SPH_Weapon.WeaponStats);
        local _ = v27.Grip.Muzzle;
        local Ammo = v26.Ammo;

        if p24.muzzleChance then
            if p24.IsSuppressor then
                BulletHandler.FireFX(p21, v27, "Muzzle", p24.muzzleChance, true);
            else
                BulletHandler.FireFX(p21, v27, "Muzzle", p24.muzzleChance, false);
            end;
        else
            BulletHandler.FireFX(p21, v27, "Muzzle", WeaponStats.muzzleChance);
        end;

        local Muzzle = v27.Grip.Muzzle;
        local Position = Muzzle.WorldCFrame.Position;
        local LookVector = Muzzle.WorldCFrame.LookVector;
        local muzzleVelocity = WeaponStats.muzzleVelocity;

        if p24.muzzleVelocity then
            muzzleVelocity = p24.muzzleVelocity;
        end;

        local v28 = nil;
        local tracers = WeaponStats.tracers;
        local tracerTiming = WeaponStats.tracerTiming;
        local tracerColor = WeaponStats.tracerColor;

        if p24.tracers then
            tracers = p24.tracers;
            tracerTiming = p24.tracerTiming;
            tracerColor = p24.tracerColor;
        end;

        if tracers then
            if Ammo.MagAmmo.Value % tracerTiming ~= 0 then
                tracerColor = v28;
            end;
        else
            tracerColor = v28;
        end;

        if tracerColor == "Random" then
            tracerColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255));
        end;

        BulletHandler.FireBullet(WeaponRig, Position, LookVector, LookVector * muzzleVelocity * 3.5, v26, p21, tracerColor, true, p24);

        if WeaponStats.fireMode ~= "Manual" and WeaponStats.shellEject then
            ShellEjection.ejectShell(p21, v26, v27);
        end;
    end;
end);
v3:Connect(function(p29: userdata, p30: userdata, p31: boolean) -- Line: 146
    -- upvalues: Debris (copy)
    if not p30 then
        return;
    end;

    if not p31 then
        p30:Play();

        return;
    end;

    if not (p29 and p29.Character) then
        return;
    end;

    if not (p29.Character:FindFirstChild("Torso") and p29.Character:FindFirstChild("UpperTorso")) then
        return;
    end;

    local v32 = p30:Clone();

    if not (p30.Parent and p30.Parent:IsA("BasePart")) then
        v32.Parent = p29.Character.HumanoidRootPart;
    end;

    v32.Parent = p30.Parent;
    v32:Play();
    local TimeLength = v32.TimeLength;
    Debris:AddItem(v32, TimeLength < 1 and 1 or TimeLength);
end);
v4:Connect(function(p33: userdata, p34) -- Line: 167
    -- upvalues: HitFX (copy)
    local v35;

    if p34 then
        v35 = p34.Instance;
    else
        v35 = p34;
    end;

    if not v35 then
        return;
    end;

    if p33 then
        p33 = p33:FindFirstChild("SPH_Weapon");
    end;

    if p33 then
        p33 = p33:FindFirstChild("WeaponStats");
    end;

    if (p33 and require(p33).projectile or "Bullet") == "Bullet" then
        HitFX.HitEffect(p34.Position, v35, p34.Normal);
    end;
end);
v5:Connect(function(p36, p37, p38) -- Line: 184
    -- upvalues: BulletHandler (copy)
    if p36 then
        p36 = p36.Character;
    end;

    local v39;

    if p36 then
        v39 = p36:FindFirstChild("WeaponRig");
    else
        v39 = p36;
    end;

    if p36 then
        p36 = p36:FindFirstChildWhichIsA("Tool");
    end;

    if not (v39 and (v39:FindFirstChild("Weapon") and (p36 and p36:FindFirstChild("SPH_Weapon")))) then
        return;
    end;

    local v40 = v39.Weapon:FindFirstChildWhichIsA("Model");
    local WeaponStats = require(p36.SPH_Weapon.WeaponStats);
    BulletHandler.MoveBolt(v40, {
        fireMoveParts = WeaponStats.fireMoveParts,
        fireRate = WeaponStats.fireRate,
        emptyLockBolt = WeaponStats.emptyLockBolt
    }, p37, p38);
end);
v6:Connect(function(p41, p42) -- Line: 200
    -- upvalues: SPH_Assets (copy), Debris (copy)
    if p41 then
        p41 = p41.Character;
    end;

    if p41 then
        p41 = p41:FindFirstChild("HumanoidRootPart");
    end;

    if p41 then
        local Children = SPH_Assets.Sounds[p42]:GetChildren();
        local v43 = Children[math.random(#Children)]:Clone();
        v43.Parent = p41;
        v43:Play();
        Debris:AddItem(v43, v43.TimeLength);
    end;
end);
v7:Connect(function(p44, p45, p46) -- Line: 214
    -- upvalues: SPH_Assets (copy), u12 (copy), TweenService (copy)
    if not p44 then
        return;
    end;

    if p44.Name == "Flashlight" then
        p44:FindFirstChildWhichIsA("Light").Enabled = p45;

        return;
    end;

    if p44.Name ~= "Laser" then
        if p44.Name == "Bipod" then
            local TweenInfo_new_ret = TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.025);

            if p45 then
                for _, child in pairs(p44.Parent.Parent:GetChildren()) do
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

                return;
            end;

            for _, child in pairs(p44.Parent.Parent:GetChildren()) do
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

        return;
    end;

    if not p45 then
        for i, v in ipairs(u12) do
            if v.attachment == p44 then
                v.laserDot:Destroy();
                table.remove(u12, i);

                return;
            end;
        end;

        return;
    end;

    local Attachment = Instance.new("Attachment", workspace.Terrain);
    Attachment.Name = "ReplicatedLaser";
    local v47 = SPH_Assets.HUD.LaserDotUI:Clone();
    v47.Enabled = true;
    v47.Dot.ImageColor3 = p44.Color.Value;
    v47.Parent = Attachment;
    table.insert(u12, {
        laserDot = Attachment,
        attachment = p44,
        ignoreModel = p46
    });
end);
v10:Connect(function() -- Line: 265
    -- upvalues: SPH_Assets (copy), Debris (copy)
    local v48 = SPH_Assets.Sounds.Bipod:Clone();
    v48.Parent = workspace;
    v48:Play();
    Debris:AddItem(v48, v48.TimeLength);
end);
RunService.RenderStepped:Connect(function() -- Line: 272
    -- upvalues: u12 (copy)
    for i, v in ipairs(u12) do
        local attachment = v.attachment;

        if attachment and attachment.Parent then
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
            RaycastParams_new_ret.FilterDescendantsInstances = { v.ignoreModel };
            local laserDot = v.laserDot;
            local v49 = workspace:Raycast(attachment.WorldPosition, attachment.WorldCFrame.LookVector * 600, RaycastParams_new_ret);

            if v49 then
                v.laserDot.LaserDotUI.Enabled = true;
                laserDot.WorldPosition = v49.Position;
            else
                v.laserDot.LaserDotUI.Enabled = false;
            end;
        else
            v.laserDot:Destroy();
            table.remove(u12, i);
        end;
    end;
end);
v8:Connect(function(p50) -- Line: 294
    if p50 then
        p50.LocalTransparencyModifier = 0;

        for _, descendant in ipairs(p50:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.LocalTransparencyModifier = 0;
            end;
        end;
    end;
end);
print("【 SPEARHEAD 】 Main Client loaded successfully!");