-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local ToggleHeadlamp = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ToggleHeadlamp");

local function bulbGlare(p1) -- Line: 33
    local v2 = {};
    local Attachment = p1:FindFirstChild("Attachment");

    if not Attachment then
        return v2;
    end;

    for _, descendant in ipairs(Attachment:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("BillboardGui") then
            table.insert(v2, descendant);
        end;
    end;

    return v2;
end;

UserInputService.InputBegan:Connect(function(p3, p4) -- Line: 48
    -- upvalues: LocalPlayer (copy), ToggleHeadlamp (copy)
    if p4 then
        return;
    end;

    if p3.KeyCode == Enum.KeyCode.L and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("PETZL HeadLamp")) then
        ToggleHeadlamp:FireServer();
    end;
end);

local function findLocalHeadlamp() -- Line: 61
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("PETZL HeadLamp");
    end;

    return Character;
end;

local function isFirstPerson() -- Line: 66
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return false;
    end;

    local Head = Character:FindFirstChild("Head");

    if not Head then
        return false;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        return (workspace_CurrentCamera.CFrame.Position - Head.Position).Magnitude < 1;
    end;

    return false;
end;

local u5 = 0;
RunService.Heartbeat:Connect(function(p6) -- Line: 79
    -- upvalues: u5 (ref), LocalPlayer (copy), bulbGlare (copy)
    u5 = u5 + p6;

    if u5 < 0.25 then
        return;
    end;

    u5 = u5 - 0.25;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("PETZL HeadLamp");
    end;

    if not Character then
        return;
    end;

    local HeadLampLight = Character:FindFirstChild("HeadLampLight");

    if not HeadLampLight then
        return;
    end;

    local Character2 = LocalPlayer.Character;
    local v7;

    if Character2 then
        local Head = Character2:FindFirstChild("Head");

        if Head then
            local workspace_CurrentCamera = workspace.CurrentCamera;

            if workspace_CurrentCamera then
                v7 = (workspace_CurrentCamera.CFrame.Position - Head.Position).Magnitude < 1;
            else
                v7 = false;
            end;
        else
            v7 = false;
        end;
    else
        v7 = false;
    end;

    local v8 = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("HeadlampOn") == true;

    for _, v in ipairs((bulbGlare(HeadLampLight))) do
        local v9;

        if v8 then
            v9 = not v7;
        else
            v9 = v8;
        end;

        v.Enabled = v9;
    end;

    local SpotLight = HeadLampLight:FindFirstChild("SpotLight");

    if SpotLight and SpotLight:IsA("SpotLight") then
        SpotLight.Shadows = not v7;
    end;
end);
print("[HeadlampClient] Bound -- L toggle, local-only bulb glare hide, first-person shadow suppress");