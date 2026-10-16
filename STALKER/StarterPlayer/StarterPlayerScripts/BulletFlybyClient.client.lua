-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local u1 = {
    close = "BulletCrack",
    whiz = "BulletWhiz",
    far = "BulletWhizFar"
};
local u2 = {
    close = {
        min = 5,
        max = 60
    },
    whiz = {
        min = 10,
        max = 80
    },
    far = {
        min = 20,
        max = 120
    }
};
local LocalPlayer = Players.LocalPlayer;
local CameraShaker = require(ReplicatedStorage:WaitForChild("CameraShaker"));
local _ = workspace.CurrentCamera;
local u4 = CameraShaker.new(Enum.RenderPriority.Camera.Value + 1, function(p3) -- Line: 44
    if workspace.CurrentCamera then
        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * p3;
    end;
end);
u4:Start();
local u5 = {
    close = {
        magnitude = 0.8,
        roughness = 14,
        fadeIn = 0.02,
        fadeOut = 0.3
    },
    whiz = {
        magnitude = 0.3,
        roughness = 10,
        fadeIn = 0.02,
        fadeOut = 0.2
    }
};
local u6 = nil;

local function getSoundsFolder() -- Line: 58
    -- upvalues: u6 (ref), ReplicatedStorage (copy)
    if u6 and u6.Parent then
        return u6;
    end;

    local SPH_Assets = ReplicatedStorage:FindFirstChild("SPH_Assets");

    if SPH_Assets then
        SPH_Assets = SPH_Assets:FindFirstChild("Sounds");
    end;

    u6 = SPH_Assets;

    return u6;
end;

local function pickSound(p7) -- Line: 65
    -- upvalues: u6 (ref), ReplicatedStorage (copy)
    local v8;

    if u6 and u6.Parent then
        v8 = u6;
    else
        local SPH_Assets = ReplicatedStorage:FindFirstChild("SPH_Assets");

        if SPH_Assets then
            SPH_Assets = SPH_Assets:FindFirstChild("Sounds");
        end;

        u6 = SPH_Assets;
        v8 = u6;
    end;

    if not v8 then
        return nil;
    end;

    local v9 = v8:FindFirstChild(p7);

    if not v9 or #v9:GetChildren() == 0 then
        return nil;
    end;

    local Children = v9:GetChildren();

    for i = 1, 4 do
        local v10 = Children[math.random(1, #Children)];

        if v10 and v10:IsA("Sound") then
            return v10;
        end;

        local _ = i;
    end;

    return nil;
end;

local function playFlyby(p11, p12) -- Line: 78
    -- upvalues: u1 (copy), pickSound (copy), LocalPlayer (copy), u2 (copy), Debris (copy)
    local v13 = u1[p11];

    if not v13 then
        return;
    end;

    local v14 = pickSound(v13);

    if not v14 then
        return;
    end;

    if not p12 then
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        p12 = Character.Position;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.1, 0.1, 0.1);
    Part.Position = p12;
    Part.Parent = workspace;
    local v15 = v14:Clone();
    v15.PlaybackSpeed = v14.PlaybackSpeed + math.random(-5, 5) / 100;
    local v16 = u2[p11];

    if v16 then
        v15.RollOffMode = Enum.RollOffMode.Linear;
        v15.RollOffMinDistance = v16.min;
        v15.RollOffMaxDistance = v16.max;
    end;

    v15.Parent = Part;
    v15:Play();
    local u17 = false;
    v15.Ended:Once(function() -- Line: 116, Name: cleanup
        -- upvalues: u17 (ref), Part (copy)
        if u17 then
            return;
        end;

        u17 = true;

        if Part and Part.Parent then
            Part:Destroy();
        end;
    end);
    Debris:AddItem(Part, (math.max(3, (v15.TimeLength > 0 and v15.TimeLength or 3) + 2)));
end;

local function applyShake(p18) -- Line: 125
    -- upvalues: u5 (copy), u4 (copy)
    local v19 = u5[p18];

    if not v19 then
        return;
    end;

    u4:ShakeOnce(v19.magnitude, v19.roughness, v19.fadeIn, v19.fadeOut);
end;

ReplicatedStorage:WaitForChild("miscEvents"):WaitForChild("bulletFlyby").OnClientEvent:Connect(function(p20, p21) -- Line: 132
    -- upvalues: playFlyby (copy), u5 (copy), u4 (copy)
    playFlyby(p20, p21);
    local v22 = u5[p20];

    if not v22 then
        return;
    end;

    u4:ShakeOnce(v22.magnitude, v22.roughness, v22.fadeIn, v22.fadeOut);
end);