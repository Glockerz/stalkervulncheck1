-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local script_Parent = script.Parent;
local Position = script_Parent.Position;
local u1 = Position;
local u2 = {
    Goal = 0,
    Tween = nil,
    Value = Instance.new("NumberValue")
};
local u3 = {
    Goal = 0,
    Tween = nil,
    Value = Instance.new("NumberValue")
};
RunService.RenderStepped:Connect(function(p4) -- Line: 11
    -- upvalues: UserInputService (copy), u2 (copy), TweenService (copy), u3 (copy), u1 (ref), script_Parent (copy), Position (copy)
    local v5 = UserInputService:GetMouseDelta() * 0.5;

    if u2.Goal ~= v5.X then
        if u2.Tween then
            u2.Tween:Pause();
        end;

        u2.Goal = v5.X;
        u2.Tween = TweenService:Create(u2.Value, TweenInfo.new(0.2), {
            Value = v5.X
        });
        u2.Tween:Play();
    end;

    if u3.Goal ~= v5.Y then
        if u3.Tween then
            u3.Tween:Pause();
        end;

        u3.Goal = v5.Y;
        u3.Tween = TweenService:Create(u3.Value, TweenInfo.new(0.2), {
            Value = v5.Y
        });
        u3.Tween:Play();
    end;

    u1 = UDim2.fromOffset(u2.Value.Value, u3.Value.Value);
    script_Parent.Position = Position + u1;
end);