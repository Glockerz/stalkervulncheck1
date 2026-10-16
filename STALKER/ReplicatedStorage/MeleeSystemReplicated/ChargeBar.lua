-- Decompiled with Potassium's decompiler.

local v1 = {};
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local ChargeBar = script:WaitForChild("ChargeBar");
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local u6 = false;

function v1.Init() -- Line: 21
    -- upvalues: u2 (ref), ChargeBar (copy), u3 (ref), u4 (ref)
    u2 = ChargeBar:Clone();
    u3 = u2:WaitForChild("Frame");
    u4 = u3:WaitForChild("Bar");
end;

function v1.StartTracking() -- Line: 28
    -- upvalues: u2 (ref), LocalPlayer (copy), u5 (ref), RunService (copy), u3 (ref), Mouse (copy), u4 (ref), u6 (ref)
    u2.Parent = LocalPlayer.PlayerGui;
    u5 = true;
    u2.Enabled = true;
    RunService:BindToRenderStep("ChargeBarFollow", Enum.RenderPriority.Input.Value, function() -- Line: 33
        -- upvalues: u5 (ref), u3 (ref), Mouse (ref), u4 (ref), u6 (ref), u2 (ref)
        if not u5 then
            return;
        end;

        u3.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y - 5);

        if u4.Size.X.Scale < 1 or u6 then
            u3.BackgroundColor3 = u6 and Color3.fromRGB(255, 170, 0) or Color3.fromRGB(255, 255, 255);

            return;
        end;

        u2.Enabled = false;
    end);
end;

function v1.StopTracking() -- Line: 46
    -- upvalues: u2 (ref), u5 (ref), RunService (copy)
    u2.Parent = script;
    u5 = false;
    u2.Enabled = false;
    RunService:UnbindFromRenderStep("ChargeBarFollow");
end;

function v1.Charge(p7) -- Line: 54
    -- upvalues: u6 (ref), u4 (ref), u2 (ref), TweenService (copy)
    if not (p7 or u6) then
        return;
    end;

    u6 = true;
    u4.Size = UDim2.new(0, 0, 1, 0);
    u2.Enabled = true;
    TweenService:Create(u4, TweenInfo.new(p7, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, 1, 0)
    }):Play();
    task.delay(p7, function() -- Line: 64
        -- upvalues: u6 (ref)
        u6 = false;
    end);
end;

return v1;