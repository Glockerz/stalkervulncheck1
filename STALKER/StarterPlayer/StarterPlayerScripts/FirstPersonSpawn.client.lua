-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local u1 = 0;

local function snapToFirstPerson() -- Line: 62
    -- upvalues: u1 (ref), LocalPlayer (copy), RunService (copy)
    u1 = u1 + 1;
    local v2 = u1;
    LocalPlayer.CameraMaxZoomDistance = 0.5;
    local v3 = os.clock() + 2;

    while os.clock() < v3 do
        RunService.RenderStepped:Wait();

        if u1 ~= v2 then
            return;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("Head");
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if Character and (workspace_CurrentCamera and (workspace_CurrentCamera.CFrame.Position - Character.Position).Magnitude <= 1.5) then
            break;
        end;
    end;

    if u1 ~= v2 then
        return;
    end;

    LocalPlayer.CameraMaxZoomDistance = 8;
end;

LocalPlayer.CharacterAdded:Connect(snapToFirstPerson);

if LocalPlayer.Character then
    task.spawn(snapToFirstPerson);
end;