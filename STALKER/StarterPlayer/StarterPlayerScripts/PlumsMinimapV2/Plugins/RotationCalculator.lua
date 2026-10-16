-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local GoodSignal = require(script.Parent.Parent.Internal.GoodSignal);
local CurrentCamera = game.Workspace.CurrentCamera;
local u1 = {
    Signals = {
        CalculatedRotation = GoodSignal.new()
    },
    InitializationPriority = 1,
    Heading = nil
};
RunService.RenderStepped:Connect(function(p2) -- Line: 33
    -- upvalues: CurrentCamera (copy), u1 (copy)
    local lookVector = CurrentCamera.CFrame.lookVector;
    heading = math.atan2(lookVector.x, lookVector.z);
    heading = math.deg(heading) - 90;
    u1.Heading = math.rad(heading);
    u1.Signals.CalculatedRotation:Fire((math.rad(heading)));
end);

return u1;