-- Decompiled with Potassium's decompiler.

local Ammo = script.Parent.Ammo;
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local UDim2_fromScale_ret = UDim2.fromScale(Ammo.Position.X.Scale, Ammo.Position.Y.Scale);
local Vector3Value = Instance.new("Vector3Value");
local u1 = 0;
local u2 = 0;
Vector3Value:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 14
    -- upvalues: u1 (ref), Vector3Value (copy), u2 (ref)
    u1 = Vector3Value.Value.X;
    u2 = Vector3Value.Value.Y;
end);
RunService.Heartbeat:Connect(function() -- Line: 19
    -- upvalues: UserInputService (copy), TweenService (copy), Vector3Value (copy)
    local MouseDelta = UserInputService:GetMouseDelta();
    TweenService:Create(Vector3Value, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        Value = Vector3.new(MouseDelta.X, MouseDelta.Y, 0)
    }):Play();
end);
RunService.Heartbeat:Connect(function() -- Line: 29
    -- upvalues: UserInputService (copy), Ammo (copy), UDim2_fromScale_ret (copy)
    local MouseDelta = UserInputService:GetMouseDelta();
    Ammo.Position = UDim2_fromScale_ret + UDim2.fromOffset(MouseDelta.X, MouseDelta.Y);
end);