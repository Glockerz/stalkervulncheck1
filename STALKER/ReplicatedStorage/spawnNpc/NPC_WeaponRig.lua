-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local SPH_Assets = game:GetService("ReplicatedStorage"):WaitForChild("SPH_Assets");
local Modules = SPH_Assets:WaitForChild("Modules");
local WeldMod = require(Modules:WaitForChild("WeldMod"));
local ViewMod = require(Modules:WaitForChild("ViewMod"));

function u1.LoadAnimTrack(u3, p4, p5, p6) -- Line: 10
    -- upvalues: u2 (copy), SPH_Assets (copy)
    if u2[u3] and u2[u3][p4] then
        return u2[u3][p4];
    end;

    local v7 = SPH_Assets:WaitForChild("Animations").R6:FindFirstChild(p4);

    if not (v7 and v7:IsA("Animation")) then
        return nil;
    end;

    local WeaponRig = u3:FindFirstChild("WeaponRig");

    if not WeaponRig then
        warn("[SPH_NPC] No WeaponRig when loading anim " .. p4);

        return nil;
    end;

    local AnimationController = WeaponRig:FindFirstChild("AnimationController");

    if not AnimationController then
        AnimationController = Instance.new("AnimationController");
        AnimationController.Parent = WeaponRig;
    end;

    local v8 = AnimationController:FindFirstChildOfClass("Animator");

    if not v8 then
        v8 = Instance.new("Animator");
        v8.Parent = AnimationController;
    end;

    local v9 = v8:LoadAnimation(v7);
    v9.Priority = p5 or Enum.AnimationPriority.Action;

    if p6 then
        v9.Looped = false;
    end;

    v9.KeyframeReached:Connect(function(p10) -- Line: 47
        -- upvalues: u3 (copy)
        local WeaponRig2 = u3:FindFirstChild("WeaponRig");

        if not WeaponRig2 then
            return;
        end;

        local v11 = WeaponRig2.Weapon:FindFirstChildWhichIsA("Model");

        if not v11 then
            return;
        end;

        local v12 = v11.Grip:FindFirstChild(p10);

        if v12 and v12:IsA("Sound") then
            v12:Play();
        end;
    end);

    if not u2[u3] then
        u2[u3] = {};
    end;

    u2[u3][p4] = v9;

    return v9;
end;

function u1.ClearAnimCache(p13) -- Line: 61
    -- upvalues: u2 (copy)
    u2[p13] = nil;
end;

function u1.MakeWeaponRigForCharacter(p14) -- Line: 65
    -- upvalues: ViewMod (copy), WeldMod (copy)
    local Head = p14:WaitForChild("Head");
    local v15 = ViewMod.RigModel(nil, true, Head);
    v15.Name = "WeaponRig";
    v15.Parent = p14;
    local v16 = WeldMod.BlankWeld(v15["Left Arm"], p14["Left Arm"]);
    v16.Parent = v15;
    v16.Name = "law";
    v15["Left Arm"].Transparency = 1;
    local v17 = WeldMod.BlankWeld(v15["Right Arm"], p14["Right Arm"]);
    v17.Parent = v15;
    v17.Name = "raw";
    v15["Right Arm"].Transparency = 1;
    local AnimationController = Instance.new("AnimationController");
    AnimationController.Parent = v15;
    Instance.new("Animator").Parent = AnimationController;

    return v15;
end;

function u1.SetupGun(p18, p19) -- Line: 88
    p18.CanBeDropped = false;

    if p18:FindFirstChild("Ammo") then
        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "Ammo";
    Folder.Parent = p18;
    local DoubleConstrainedValue = Instance.new("DoubleConstrainedValue");
    DoubleConstrainedValue.Name = "MagAmmo";
    DoubleConstrainedValue.MaxValue = p19.magazineCapacity;
    DoubleConstrainedValue.Value = p19.magazineAmmo or DoubleConstrainedValue.MaxValue;
    DoubleConstrainedValue.Parent = Folder;
    local DoubleConstrainedValue2 = Instance.new("DoubleConstrainedValue");
    DoubleConstrainedValue2.Name = "ArcadeAmmoPool";
    DoubleConstrainedValue2.MaxValue = p19.maxAmmoPool;
    DoubleConstrainedValue2.Value = p19.startAmmoPool;
    DoubleConstrainedValue2.Parent = Folder;

    if not p19.openBolt then
        local BoolValue = Instance.new("BoolValue");
        BoolValue.Name = "Chambered";
        BoolValue.Value = p19.startChambered;
        BoolValue.Parent = p18;

        if BoolValue.Value then
            if DoubleConstrainedValue.Value > 0 then
                DoubleConstrainedValue.Value = DoubleConstrainedValue.Value - 1;
            else
                BoolValue.Value = false;
            end;
        end;
    end;

    local BoolValue = Instance.new("BoolValue");
    BoolValue.Name = "BoltReady";
    BoolValue.Value = true;
    BoolValue.Parent = p18;
    local IntValue = Instance.new("IntValue");
    IntValue.Name = "FireMode";
    IntValue.Value = p19.fireMode;
    IntValue.Parent = p18;
end;

function u1.ToggleR6Shoulders(p20, p21) -- Line: 134
    local Torso = p20:WaitForChild("Torso");

    if not Torso then
        return;
    end;

    local v22 = Torso:WaitForChild("Left Shoulder");
    local v23 = Torso:WaitForChild("Right Shoulder");

    if v22 then
        v22.Enabled = not p21;
    end;

    if v23 then
        v23.Enabled = not p21;
    end;

    local WeaponRig = p20:WaitForChild("WeaponRig");

    if WeaponRig and WeaponRig:WaitForChild("law") then
        WeaponRig.law.Enabled = p21;
    end;

    if WeaponRig and WeaponRig:WaitForChild("raw") then
        WeaponRig.raw.Enabled = p21;
    end;
end;

function u1.EquipGunOnRig(p24, p25) -- Line: 146
    -- upvalues: u1 (copy), SPH_Assets (copy), WeldMod (copy)
    local v26 = p24:FindFirstChild("WeaponRig") or u1.MakeWeaponRigForCharacter(p24);
    local WeaponStats = require(p25:WaitForChild("SPH_Weapon"):WaitForChild("WeaponStats"));
    u1.SetupGun(p25, WeaponStats);
    local v27 = SPH_Assets:WaitForChild("WeaponModels"):FindFirstChild(p25.Name);

    if not v27 then
        warn("[SPH_NPC] Missing WeaponModels model for: " .. p25.Name);

        return nil, WeaponStats;
    end;

    local v28 = v26:FindFirstChild("Weapon") and v26.Weapon:FindFirstChildWhichIsA("Model");

    if v28 then
        v28:Destroy();
    end;

    local v29 = v27:Clone();
    v29.Name = p25.Name;
    v29.Parent = v26:WaitForChild("Weapon");

    if not WeaponStats.disableAutoRigging then
        WeldMod.WeldModel(v29, v29.Grip, false);

        for _, v in ipairs(WeaponStats.rigParts or {}) do
            local v30 = v29:FindFirstChild(v);
            local v31 = v29.Grip:FindFirstChild("Grip_" .. v);

            if v30 and v31 then
                v31:Destroy();
                local v32 = WeldMod.M6D(v29.Grip, v30);
                v32.Name = v;
                v32.Parent = v29.Grip;
            end;
        end;

        for _, descendant in ipairs(v29:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.Anchored = false;
            end;
        end;
    end;

    for _, child in ipairs(v29:GetChildren()) do
        if child.Name == "SightReticle" and child:FindFirstChild("SurfaceGui") then
            child.SurfaceGui.Enabled = false;
        end;
    end;

    if v26.AnimBase:FindFirstChild("GunMotor") then
        v26.AnimBase.GunMotor:Destroy();
    end;

    WeldMod.BlankM6D(v26.AnimBase, v29.Grip).Name = "GunMotor";
    v26.law.Enabled = true;
    v26.raw.Enabled = true;

    if v26:FindFirstChild("BaseWeld") then
        v26.BaseWeld.C0 = WeaponStats.serverOffset or CFrame.new();
    end;

    p25:Clone().Parent = p24;
    u1.ToggleR6Shoulders(p24, true);

    return v29, WeaponStats;
end;

return u1;