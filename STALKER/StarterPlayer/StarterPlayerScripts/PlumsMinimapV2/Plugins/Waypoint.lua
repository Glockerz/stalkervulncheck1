-- Decompiled with Potassium's decompiler.

local Internal = script.Parent.Parent.Internal;
local Janitor = require(Internal.Janitor);
local GoodSignal = require(Internal.GoodSignal);
local CameraUtils = require(Internal.CameraUtils);
local RotationCalculator = require(script.Parent.RotationCalculator);
local PlayerRenderer = require(script.Parent.PlayerRenderer);
local GeneralSettings = script.Parent.Parent.GeneralSettings;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = {
    Signals = {
        SetNewWaypoint = GoodSignal.new()
    },
    InitializationPriority = 5,
    Waypoint = nil
};
local u2 = {};

local function SetNewWaypoint(p3: vector) -- Line: 41
    -- upvalues: u1 (copy), u2 (copy), Janitor (copy), GeneralSettings (copy), RotationCalculator (copy), LocalPlayer (copy), PlayerRenderer (copy)
    u1.Waypoint = p3;
    u1.Signals.SetNewWaypoint:Fire(p3);

    for _, v in u2 do
        local v4 = v.Janitor:Add(Janitor.new());
        local v5 = v4:Add(GeneralSettings:WaitForChild("Blip"):Clone());
        v5.AnchorPoint = Vector2.new(0.5, 0.5);
        v5.Parent = v.BlipHolder;
        v5.Image = GeneralSettings.WayPoint.Texture;

        if v.Blips.Waypoint then
            v.Blips.Waypoint.Janitor:Destroy();
        end;

        v.Blips.Waypoint = {
            SnapToBorder = true,
            Rotate = false,
            Position = p3,
            Object = v5,
            Janitor = v4
        };
        v.CalculatedCFrame:Fire(v.Camera.CFrame, RotationCalculator.Heading);
    end;

    local v6 = Vector3.new(0, 0, 0);
    local v7 = Vector3.new(0, 0, 0);
    local v8 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if v8 then
        local CFrame = v8.CFrame;
        v6 = CFrame.Position;
        v7 = CFrame.LookVector;
    end;

    PlayerRenderer.Signals.CalculatedPlayerPosition:Fire(v6, v7);
end;

function u1.InitializeFrame(p9: userdata, u10: table, p11: any) -- Line: 85
    -- upvalues: u2 (copy), CameraUtils (copy), u1 (copy), RotationCalculator (copy), LocalPlayer (copy), PlayerRenderer (copy), SetNewWaypoint (copy)
    u2[p9] = u10;

    if u10.FullmapButton then
        u10.LastClick = 0;
        p11:Add(u10.FullmapButton.MouseButton1Click:Connect(function() -- Line: 91
            -- upvalues: u10 (copy), CameraUtils (ref), u1 (ref), RotationCalculator (ref), LocalPlayer (ref), PlayerRenderer (ref), SetNewWaypoint (ref)
            if tick() - u10.LastClick > 0.25 then
                u10.LastClick = tick();

                return;
            end;

            local v12 = game:GetService("UserInputService"):GetMouseLocation() - Vector2.new(0, game:GetService("GuiService"):GetInsetArea(Enum.ScreenInsets.TopbarSafeInsets).Height) - u10.FullmapButton.AbsolutePosition;
            local v13 = CameraUtils.ViewportPointToPlanePoint(u10.Camera.CFrame, u10.Camera.FieldOfView, v12, u10.FullmapButton.AbsoluteSize, 0);
            u10.LastClick = 0;

            if not u1.Waypoint or (v13 - u1.Waypoint).Magnitude > 25 then
                SetNewWaypoint(v13);

                return;
            end;

            if u10.Blips.Waypoint then
                u10.Blips.Waypoint.Janitor:Destroy();
                u10.Blips.Waypoint = nil;
            end;

            u1.Waypoint = nil;
            u10.CalculatedCFrame:Fire(u10.Camera.CFrame, RotationCalculator.Heading);
            local v14 = Vector3.new(0, 0, 0);
            local v15 = Vector3.new(0, 0, 0);
            local v16 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

            if v16 then
                local CFrame = v16.CFrame;
                v14 = CFrame.Position;
                v15 = CFrame.LookVector;
            end;

            PlayerRenderer.Signals.CalculatedPlayerPosition:Fire(v14, v15);
        end));
    end;
end;

function u1.CleanupFrame(p17) -- Line: 134
    -- upvalues: u2 (copy)
    u2[p17] = nil;
end;

return u1;