-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local PlayerScripts = game:GetService("Players").LocalPlayer.PlayerScripts;
local ControlModule = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"));
local u1 = require(script:WaitForChild("Spring")).new(ControlModule:GetMoveVector());
local Humanoid = script.Parent:WaitForChild("Humanoid");
local Speed = script:WaitForChild("Speed");
local Damper = script:WaitForChild("Damper");
RunService:BindToRenderStep("___update", Enum.RenderPriority.Character.Value - 1, function() -- Line: 16
    -- upvalues: u1 (copy), ControlModule (copy), Speed (copy), Damper (copy), Humanoid (copy)
    u1.Target = ControlModule:GetMoveVector();
    u1.Speed = Speed.Value;
    u1.Damper = Damper.Value;
    Humanoid:Move(u1.Position, true);
end);