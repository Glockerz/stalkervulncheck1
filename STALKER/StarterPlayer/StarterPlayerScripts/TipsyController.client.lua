-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local LocalPlayer = Players.LocalPlayer;
local TipsyUpdate = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TipsyUpdate");
local u1 = 0;
local u2 = 0;
local u3 = nil;
local CFrame_new_ret = CFrame.new();
local TipsyBlur = Lighting:FindFirstChild("TipsyBlur");

if not TipsyBlur then
    TipsyBlur = Instance.new("BlurEffect");
    TipsyBlur.Name = "TipsyBlur";
    TipsyBlur.Size = 0;
    TipsyBlur.Enabled = false;
    TipsyBlur.Parent = Lighting;
end;

local function getHumanoid() -- Line: 59
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    return Character and Character:FindFirstChildOfClass("Humanoid") or nil;
end;

local function clearTipsyVisuals() -- Line: 64
    -- upvalues: LocalPlayer (copy), TipsyBlur (ref)
    local Character = LocalPlayer.Character;
    local v4 = Character and Character:FindFirstChildOfClass("Humanoid") or nil;

    if v4 then
        v4.CameraOffset = Vector3.new(0, 0, 0);
    end;

    TipsyBlur.Size = 0;
    TipsyBlur.Enabled = false;
end;

local u5 = nil;
local u6 = nil;

local function calcTipsyWeight(p7) -- Line: 81
    return math.clamp(p7 / 5, 0, 1) * 0.7 + 0.3;
end;

local function setupTipsyTrack(p8) -- Line: 86
    -- upvalues: u5 (ref), u6 (ref)
    local Humanoid = p8:WaitForChild("Humanoid", 5);

    if not Humanoid then
        return;
    end;

    local Animator = Humanoid:WaitForChild("Animator", 5);

    if not Animator then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://82617441301190";
    local v9 = Animator:LoadAnimation(Animation);
    v9.Priority = Enum.AnimationPriority.Movement;
    v9.Looped = true;
    u5 = v9;
    u6 = p8;
end;

local function updateTipsyTrack() -- Line: 101
    -- upvalues: u5 (ref), u6 (ref), LocalPlayer (copy), u1 (ref)
    local v10 = u5;

    if not v10 or u6 ~= LocalPlayer.Character then
        return;
    end;

    local v11 = u1;

    if v11 <= 0.1 then
        if v10.IsPlaying then
            v10:Stop(0.5);
        end;

        return;
    end;

    local v12 = math.clamp(v11 / 5, 0, 1) * 0.7 + 0.3;

    if v10.IsPlaying then
        v10:AdjustWeight(v12, 0.5);

        return;
    end;

    v10:Play(0.5, v12);
end;

TipsyUpdate.OnClientEvent:Connect(function(p13) -- Line: 120
    -- upvalues: u1 (ref), LocalPlayer (copy), TipsyBlur (ref), updateTipsyTrack (copy)
    u1 = math.max(0, p13 or 0);

    if u1 <= 0.01 then
        local Character = LocalPlayer.Character;
        local v14 = Character and Character:FindFirstChildOfClass("Humanoid") or nil;

        if v14 then
            v14.CameraOffset = Vector3.new(0, 0, 0);
        end;

        TipsyBlur.Size = 0;
        TipsyBlur.Enabled = false;
    end;

    updateTipsyTrack();
end);
LocalPlayer.CharacterAdded:Connect(function(u15) -- Line: 126
    -- upvalues: u5 (ref), u6 (ref), setupTipsyTrack (copy), updateTipsyTrack (copy), LocalPlayer (copy), TipsyBlur (ref)
    u5 = nil;
    u6 = nil;
    task.spawn(function() -- Line: 130
        -- upvalues: setupTipsyTrack (ref), u15 (copy), updateTipsyTrack (ref)
        setupTipsyTrack(u15);
        updateTipsyTrack();
    end);
    task.wait(0.5);
    local Character = LocalPlayer.Character;
    local v16 = Character and Character:FindFirstChildOfClass("Humanoid") or nil;

    if v16 then
        v16.CameraOffset = Vector3.new(0, 0, 0);
    end;

    TipsyBlur.Size = 0;
    TipsyBlur.Enabled = false;
end);

if LocalPlayer.Character then
    task.spawn(function() -- Line: 140
        -- upvalues: setupTipsyTrack (copy), LocalPlayer (copy), updateTipsyTrack (copy)
        setupTipsyTrack(LocalPlayer.Character);
        updateTipsyTrack();
    end);
end;

RunService:BindToRenderStep("TipsySway", Enum.RenderPriority.Camera.Value + 200, function(p17) -- Line: 146
    -- upvalues: u2 (ref), u1 (ref), u3 (ref), CFrame_new_ret (ref), TipsyBlur (ref)
    u2 = u2 + p17;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local v18 = u1;

    if v18 <= 0.01 then
        u3 = nil;
        CFrame_new_ret = CFrame.new();
        TipsyBlur.Size = 0;
        TipsyBlur.Enabled = false;

        return;
    end;

    local v19;

    if u3 and workspace_CurrentCamera.CFrame == u3 then
        v19 = workspace_CurrentCamera.CFrame * CFrame_new_ret:Inverse();
    else
        v19 = workspace_CurrentCamera.CFrame;
    end;

    local v20 = v18 * 0.08 + 0.7;
    local math_rad_ret = math.rad(v18 * 0.1);
    local math_rad_ret2 = math.rad(v18 * 0.08);
    local math_rad_ret3 = math.rad(v18 * 0.03);
    local v21 = math.sin(u2 * v20 * 0.6) * math_rad_ret;
    local v22 = math.sin(u2 * v20 * 0.8 + 0.4) * math_rad_ret2;
    local v23 = math.sin(u2 * v20 * 1.3 + 1.3) * math_rad_ret3;
    local CFrame_Angles_ret = CFrame.Angles(v23, v21, v22);
    local v24 = v19 * CFrame_Angles_ret;
    workspace_CurrentCamera.CFrame = v24;
    u3 = v24;
    CFrame_new_ret = CFrame_Angles_ret;
    local v25 = v18 * 6;
    TipsyBlur.Size = v25 * 1.25 * 0.5 + v25 * 0.75 * 0.5 * math.sin(u2 * 0.45 * 3.141592653589793 * 2);
    TipsyBlur.Enabled = v18 > 0.5;
end);
print("[TipsyController] Initialized");