-- Decompiled with Potassium's decompiler.

local Internal = script.Parent.Parent.Internal;
local GoodSignal = require(Internal.GoodSignal);
require(Internal.Janitor);
require(Internal.BorderSnap);
local CameraUtils = require(Internal.CameraUtils);
local LocalPlayer = game:GetService("Players").LocalPlayer;
local DontRotate = script.Parent.Parent.GeneralSettings.DontRotate;
game:GetService("CollectionService");
local RotationCalculator = require(script.Parent.RotationCalculator);
local MinimapRenderer = require(script.Parent.MinimapRenderer);
local u1 = {
    InitializationPriority = 3,
    Signals = {
        CalculatedPlayerPosition = GoodSignal.new()
    }
};
local u2 = {};

function u1.InitializeFrame(u3: userdata, u4: table, p5: any) -- Line: 43
    -- upvalues: u2 (copy), GoodSignal (copy), LocalPlayer (copy), CameraUtils (copy), MinimapRenderer (copy)
    local u6 = p5:Add(Instance.new("ImageLabel"));
    u6.AnchorPoint = Vector2.new(0.5, 0.5);
    u6.Position = UDim2.fromScale(0.5, 0.5);
    u6.Size = UDim2.fromOffset(30, 30);
    u6.Image = "rbxassetid://" .. 5820620303;
    u6.BackgroundTransparency = 1;
    u6.ZIndex = 1000;
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Size = UDim2.fromScale(1, 1);
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.Parent = u3;
    CanvasGroup.ZIndex = 502;
    u6.Parent = CanvasGroup;
    u4.PlayerObj = u6;
    u2[u3] = u4;
    u4.PlayerPositionCalculated = GoodSignal.new();
    p5:Add(u4.CalculatedCFrame:Connect(function(p7) -- Line: 66
        -- upvalues: LocalPlayer (ref), u3 (copy), CameraUtils (ref), MinimapRenderer (ref), u6 (copy), u4 (copy)
        local v8 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

        if not v8 then
            return;
        end;

        local AbsoluteSize = u3.AbsoluteSize;
        local Position = v8.CFrame.Position;
        local v9 = CameraUtils.PointToViewport(p7, 70, MinimapRenderer.WorldToMap((Vector3.new(Position.X, 0, Position.Z))), AbsoluteSize);
        u6.Position = UDim2.fromScale(v9.X / AbsoluteSize.X, v9.Y / AbsoluteSize.Y);
        u4.PlayerPositionCalculated:Fire(Position);
    end));
end;

local function getAngleAboutYAxis(p10) -- Line: 86
    local _, _, _, v11, _, v12, _, _, _, v13, _, v14 = p10:components();

    return math.atan2(v12 - v13, v11 + v14);
end;

RotationCalculator.Signals.CalculatedRotation:Connect(function(p15) -- Line: 95
    -- upvalues: LocalPlayer (copy), u2 (copy), DontRotate (copy)
    local v16 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if not v16 then
        return;
    end;

    local _, _, _, v17, _, v18, _, _, _, v19, _, v20 = v16.CFrame:components();
    local math_atan2_ret = math.atan2(v18 - v19, v17 + v20);

    for i, v in u2 do
        local Attribute = i:GetAttribute("DontRotate");

        if Attribute then
            v.PlayerObj.Rotation = -math.deg(math_atan2_ret) - 90;
        elseif Attribute == nil and DontRotate.Value then
            v.PlayerObj.Rotation = -math.deg(math_atan2_ret) - 90;
        else
            v.PlayerObj.Rotation = math.deg(p15 - math_atan2_ret) - 90;
        end;
    end;
end);
local u21 = nil;
local u22 = nil;
game:GetService("RunService").RenderStepped:Connect(function() -- Line: 137
    -- upvalues: LocalPlayer (copy), u21 (ref), u22 (ref), u2 (copy), CameraUtils (copy), MinimapRenderer (copy), DontRotate (copy), RotationCalculator (copy), u1 (copy)
    local v23 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if not v23 then
        u21 = nil;
        u22 = nil;

        return;
    end;

    local CFrame = v23.CFrame;
    local _, _, _, v24, _, v25, _, _, _, v26, _, v27 = CFrame:components();
    local math_atan2_ret = math.atan2(v25 - v26, v24 + v27);
    local Position = CFrame.Position;
    local LookVector = CFrame.LookVector;

    if Position == u22 and math_atan2_ret == u21 then
        return;
    end;

    u22 = Position;
    u21 = math_atan2_ret;

    for i, v in u2 do
        local AbsoluteSize = v.MinimapFrame.AbsoluteSize;
        local v28 = CameraUtils.PointToViewport(v.Camera.CFrame, 70, MinimapRenderer.WorldToMap((Vector3.new(Position.X, 0, Position.Z))), AbsoluteSize);
        v.PlayerPositionCalculated:Fire(Position);
        local Attribute = i:GetAttribute("DontRotate");

        if Attribute then
            v.PlayerObj.Rotation = -math.deg(math_atan2_ret) - 90;
            v.PlayerObj.Position = UDim2.fromScale(v28.X / AbsoluteSize.X, v28.Y / AbsoluteSize.Y);
        elseif Attribute == nil and DontRotate.Value then
            v.PlayerObj.Rotation = -math.deg(math_atan2_ret) - 90;
            v.PlayerObj.Position = UDim2.fromScale(v28.X / AbsoluteSize.X, v28.Y / AbsoluteSize.Y);
        else
            v.PlayerObj.Rotation = math.deg((RotationCalculator.Heading or 0) - math_atan2_ret) - 90;
            v.PlayerObj.Position = UDim2.fromScale(v28.X / AbsoluteSize.X, v28.Y / AbsoluteSize.Y);
        end;
    end;

    u1.Signals.CalculatedPlayerPosition:Fire(Position, LookVector);
end);

function u1.CleanupFrame(p29: userdata) -- Line: 193
end;

return u1;