-- Decompiled with Potassium's decompiler.

local Humanoid = game.Players.LocalPlayer.Character.Humanoid;
local Health = Humanoid.Health;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u2 = require(game.ReplicatedStorage.CameraShaker).new(Enum.RenderPriority.Camera.Value, function(p1) -- Line: 10
    -- upvalues: workspace_CurrentCamera (copy)
    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * p1;
end);
u2:Start();
Humanoid.HealthChanged:Connect(function(p3) -- Line: 16
    -- upvalues: Health (ref), u2 (copy)
    if p3 < Health then
        difference = Health - p3;
        Health = p3;
        u2:ShakeOnce(difference / 4, 10, 0, 1.5);
    end;
end);