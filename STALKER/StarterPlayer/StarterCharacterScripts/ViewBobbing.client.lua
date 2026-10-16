-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = game.Players.LocalPlayer;
local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid");
LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = nil;
local u2 = Vector3.new(0, 0, 0);
local math_clamp_ret = math.clamp(Humanoid.WalkSpeed / 16, 0.5, 2);
local u3 = 0;

local function lerp(p4, p5, p6) -- Line: 25
    return p4 + (p5 - p4) * p6;
end;

u1 = RunService.RenderStepped:Connect(function(p7) -- Line: 29, Name: updateCamera
    -- upvalues: Humanoid (copy), u1 (ref), u3 (ref), UserInputService (copy), u2 (ref), math_clamp_ret (copy), workspace_CurrentCamera (copy)
    if Humanoid.Health <= 0 then
        u1:Disconnect();

        return;
    end;

    u3 = u3 + p7;

    if u3 < 0.015384615384615385 then
        return;
    end;

    local v8 = u3;
    u3 = 0;
    local X = UserInputService:GetMouseDelta().X;
    local v9 = u2;
    local math_clamp_ret2 = math.clamp(X, -0.5, 0.5);
    local math_random_ret = math.random(-0.5, 0.5);
    u2 = v9 + (Vector3.new(math_clamp_ret2, math_random_ret, math.random(-0.5, 0.5)) - v9) * (v8 * 0.25 * 60);
    local v10;

    if Humanoid.MoveDirection.Magnitude > 0.01 then
        local v11 = time() * Humanoid.WalkSpeed * 0.5;
        local v12 = math.sin(v11) * 0.02 * math_clamp_ret;
        local v13 = time() * Humanoid.WalkSpeed * 0.3;
        local v14 = math.sin(v13) * 0.02 * math_clamp_ret;
        local v15 = time() * Humanoid.WalkSpeed * 0.7;
        local v16 = math.sin(v15) * 0.02 * math_clamp_ret;
        v10 = Vector3.new(v12, v14, v16) or Vector3.new(0, 0, 0);
    else
        v10 = Vector3.new(0, 0, 0);
    end;

    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(v10.X), math.rad(v10.Y), (math.rad(v10.Z))) * CFrame.fromEulerAnglesXYZ(0, 0, (math.rad(u2.X)));
end);