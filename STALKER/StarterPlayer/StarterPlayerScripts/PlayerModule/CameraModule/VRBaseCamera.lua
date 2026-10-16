-- Decompiled with Potassium's decompiler.

local success, result = pcall(function() -- Line: 17
    return UserSettings():IsUserFeatureEnabled("UserVRVehicleCameraOrbital");
end);
local u1 = success and result;
local VRService = game:GetService("VRService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local UserFlag = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserVRRemoveLuaEdgeBlur");
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local u2 = setmetatable({}, BaseCamera);
u2.__index = u2;

function u2.new() -- Line: 42
    -- upvalues: BaseCamera (copy), u2 (copy)
    local v3 = BaseCamera.new();
    local v4 = setmetatable(v3, u2);
    v4.gamepadZoomLevels = { 0, 7 };
    v4.headScale = 1;
    v4:SetCameraToSubjectDistance(7);
    v4.VRFadeResetTimer = 0;
    v4.VREdgeBlurTimer = 0;
    v4.gamepadResetConnection = nil;
    v4.needsReset = true;
    v4.recentered = false;
    v4:Reset();

    return v4;
end;

function u2.Reset(p5) -- Line: 68
    p5.stepRotateTimeout = 0;
end;

function u2.GetModuleName(p6) -- Line: 72
    return "VRBaseCamera";
end;

function u2.GamepadZoomPress(p7) -- Line: 76
    -- upvalues: BaseCamera (copy)
    BaseCamera.GamepadZoomPress(p7);
    p7:GamepadReset();
    p7:ResetZoom();
end;

function u2.GamepadReset(p8) -- Line: 84
    p8.stepRotateTimeout = 0;
    p8.needsReset = true;
end;

function u2.ResetZoom(p9) -- Line: 89
    -- upvalues: ZoomController (copy)
    ZoomController.SetZoomParameters(p9.currentSubjectDistance, 0);
    ZoomController.ReleaseSpring();
end;

function u2.OnEnabledChanged(u10) -- Line: 94
    -- upvalues: BaseCamera (copy), CameraInput (copy), VRService (copy), u1 (ref), UserFlag (copy), LocalPlayer (copy), Lighting (copy)
    BaseCamera.OnEnabledChanged(u10);

    if u10.enabled then
        u10.gamepadResetConnection = CameraInput.gamepadReset:Connect(function() -- Line: 98
            -- upvalues: u10 (copy)
            u10:GamepadReset();
        end);
        u10.thirdPersonOptionChanged = VRService:GetPropertyChangedSignal("ThirdPersonFollowCamEnabled"):Connect(function() -- Line: 103
            -- upvalues: u1 (ref), u10 (copy)
            if u1 then
                u10:Reset();

                return;
            end;

            if not u10:IsInFirstPerson() then
                u10:Reset();
            end;
        end);
        u10.vrRecentered = VRService.UserCFrameChanged:Connect(function(p11, p12) -- Line: 114
            -- upvalues: u10 (copy)
            if p11 == Enum.UserCFrame.Floor then
                u10.recentered = true;
            end;
        end);

        return;
    end;

    if u10.inFirstPerson then
        u10:GamepadZoomPress();
    end;

    if u10.thirdPersonOptionChanged then
        u10.thirdPersonOptionChanged:Disconnect();
        u10.thirdPersonOptionChanged = nil;
    end;

    if u10.vrRecentered then
        u10.vrRecentered:Disconnect();
        u10.vrRecentered = nil;
    end;

    if u10.cameraHeadScaleChangedConn then
        u10.cameraHeadScaleChangedConn:Disconnect();
        u10.cameraHeadScaleChangedConn = nil;
    end;

    if u10.gamepadResetConnection then
        u10.gamepadResetConnection:Disconnect();
        u10.gamepadResetConnection = nil;
    end;

    if not UserFlag then
        u10.VREdgeBlurTimer = 0;
        u10:UpdateEdgeBlur(LocalPlayer, 1);
    end;

    local VRFade = Lighting:FindFirstChild("VRFade");

    if VRFade then
        VRFade.Brightness = 0;
    end;
end;

function u2.OnCurrentCameraChanged(u13) -- Line: 158
    -- upvalues: BaseCamera (copy)
    BaseCamera.OnCurrentCameraChanged(u13);

    if u13.cameraHeadScaleChangedConn then
        u13.cameraHeadScaleChangedConn:Disconnect();
        u13.cameraHeadScaleChangedConn = nil;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        u13.cameraHeadScaleChangedConn = workspace_CurrentCamera:GetPropertyChangedSignal("HeadScale"):Connect(function() -- Line: 170
            -- upvalues: u13 (copy)
            u13:OnHeadScaleChanged();
        end);
        u13:OnHeadScaleChanged();
    end;
end;

function u2.OnHeadScaleChanged(p14) -- Line: 175
    local HeadScale = workspace.CurrentCamera.HeadScale;

    for i, v in p14.gamepadZoomLevels do
        p14.gamepadZoomLevels[i] = v * HeadScale / p14.headScale;
    end;

    p14:SetCameraToSubjectDistance(p14:GetCameraToSubjectDistance() * HeadScale / p14.headScale);
    p14.headScale = HeadScale;
end;

function u2.GetVRFocus(p15, p16, p17) -- Line: 191
    local v18 = p15.lastCameraFocus or p16;
    local x = p15.cameraTranslationConstraints.x;
    local math_min_ret = math.min(1, p15.cameraTranslationConstraints.y + p17);
    p15.cameraTranslationConstraints = Vector3.new(x, math_min_ret, p15.cameraTranslationConstraints.z);
    local CameraHeight = p15:GetCameraHeight();
    local Vector3_new_ret = Vector3.new(0, CameraHeight, 0);

    return CFrame.new(Vector3.new(p16.x, v18.y, p16.z):Lerp(p16 + Vector3_new_ret, p15.cameraTranslationConstraints.y));
end;

function u2.StartFadeFromBlack(p19) -- Line: 207
    -- upvalues: UserGameSettings (copy), Lighting (copy)
    if UserGameSettings.VignetteEnabled == false then
        return;
    end;

    local VRFade = Lighting:FindFirstChild("VRFade");

    if not VRFade then
        VRFade = Instance.new("ColorCorrectionEffect");
        VRFade.Name = "VRFade";
        VRFade.Parent = Lighting;
    end;

    VRFade.Brightness = -1;
    p19.VRFadeResetTimer = 0.1;
end;

function u2.UpdateFadeFromBlack(p20: table, p21: number) -- Line: 222
    -- upvalues: Lighting (copy)
    local VRFade = Lighting:FindFirstChild("VRFade");

    if p20.VRFadeResetTimer > 0 then
        p20.VRFadeResetTimer = math.max(p20.VRFadeResetTimer - p21, 0);
        local VRFade2 = Lighting:FindFirstChild("VRFade");

        if VRFade2 and VRFade2.Brightness < 0 then
            VRFade2.Brightness = math.min(VRFade2.Brightness + p21 * 10, 0);
        end;
    elseif VRFade then
        VRFade.Brightness = 0;
    end;
end;

function u2.StartVREdgeBlur(p22, p23, p24) -- Line: 238
    -- upvalues: UserGameSettings (copy), RunService (copy), VRService (copy)
    if not p24 and UserGameSettings.VignetteEnabled == false then
        return;
    end;

    local VRBlurPart = workspace.CurrentCamera:FindFirstChild("VRBlurPart");

    if not VRBlurPart then
        VRBlurPart = Instance.new("Part");
        VRBlurPart.Name = "VRBlurPart";
        VRBlurPart.Parent = workspace.CurrentCamera;
        VRBlurPart.CanTouch = false;
        VRBlurPart.CanCollide = false;
        VRBlurPart.CanQuery = false;
        VRBlurPart.Anchored = true;
        VRBlurPart.Size = Vector3.new(0.44, 0.47, 1);
        VRBlurPart.Transparency = 1;
        VRBlurPart.CastShadow = false;
        RunService.RenderStepped:Connect(function(p25) -- Line: 258
            -- upvalues: VRService (ref), VRBlurPart (ref)
            local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local v26 = workspace.CurrentCamera.CFrame * (CFrame.new(UserCFrame.p * workspace.CurrentCamera.HeadScale) * (UserCFrame - UserCFrame.p));
            VRBlurPart.CFrame = v26 * CFrame.Angles(0, 3.141592653589793, 0) + v26.LookVector * (1.05 * workspace.CurrentCamera.HeadScale);
            VRBlurPart.Size = Vector3.new(0.44, 0.47, 1) * workspace.CurrentCamera.HeadScale;
        end);
    end;

    local VRBlurScreen = p23.PlayerGui:FindFirstChild("VRBlurScreen");
    local v27;

    if VRBlurScreen then
        v27 = VRBlurScreen:FindFirstChild("VRBlur");
    else
        v27 = nil;
    end;

    if not v27 then
        local v28 = VRBlurScreen or (Instance.new("SurfaceGui") or Instance.new("ScreenGui"));
        v28.Name = "VRBlurScreen";
        v28.Parent = p23.PlayerGui;
        v28.Adornee = VRBlurPart;
        v27 = Instance.new("ImageLabel");
        v27.Name = "VRBlur";
        v27.Parent = v28;
        v27.Image = "rbxasset://textures/ui/VR/edgeBlur.png";
        v27.AnchorPoint = Vector2.new(0.5, 0.5);
        v27.Position = UDim2.new(0.5, 0, 0.5, 0);
        v27.Size = UDim2.fromScale(workspace.CurrentCamera.ViewportSize.X * 2.3 / 512, workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512);
        v27.BackgroundTransparency = 1;
        v27.Active = true;
        v27.ScaleType = Enum.ScaleType.Stretch;
    end;

    v27.Visible = true;
    v27.ImageTransparency = 0;
    p22.VREdgeBlurTimer = 0.14;
end;

function u2.UpdateEdgeBlur(p29, p30, p31) -- Line: 307
    local VRBlurScreen = p30.PlayerGui:FindFirstChild("VRBlurScreen");
    local v32;

    if VRBlurScreen then
        v32 = VRBlurScreen:FindFirstChild("VRBlur");
    else
        v32 = nil;
    end;

    if v32 then
        if p29.VREdgeBlurTimer > 0 then
            p29.VREdgeBlurTimer = p29.VREdgeBlurTimer - p31;
            local VRBlurScreen2 = p30.PlayerGui:FindFirstChild("VRBlurScreen");
            local v33 = VRBlurScreen2 and VRBlurScreen2:FindFirstChild("VRBlur");

            if v33 then
                v33.ImageTransparency = 1 - math.clamp(p29.VREdgeBlurTimer, 0.01, 0.14) * 7.142857142857142;
            end;
        else
            v32.Visible = false;
        end;
    end;
end;

function u2.GetCameraHeight(p34) -- Line: 332
    return p34.inFirstPerson and 0 or 0.25881904510252074 * p34.currentSubjectDistance;
end;

function u2.GetSubjectCFrame(p35) -- Line: 339
    -- upvalues: BaseCamera (copy)
    local SubjectCFrame = BaseCamera.GetSubjectCFrame(p35);
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CameraSubject;
    end;

    if not workspace_CurrentCamera then
        return SubjectCFrame;
    end;

    if workspace_CurrentCamera:IsA("Humanoid") and (workspace_CurrentCamera:GetState() == Enum.HumanoidStateType.Dead and workspace_CurrentCamera == p35.lastSubject) then
        SubjectCFrame = p35.lastSubjectCFrame;
    end;

    if SubjectCFrame then
        p35.lastSubjectCFrame = SubjectCFrame;
    end;

    return SubjectCFrame;
end;

function u2.GetSubjectPosition(p36) -- Line: 365
    -- upvalues: BaseCamera (copy)
    local SubjectPosition = BaseCamera.GetSubjectPosition(p36);
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return nil;
    end;

    if CurrentCamera:IsA("Humanoid") then
        if CurrentCamera:GetState() == Enum.HumanoidStateType.Dead and CurrentCamera == p36.lastSubject then
            SubjectPosition = p36.lastSubjectPosition;
        end;
    elseif CurrentCamera:IsA("VehicleSeat") then
        SubjectPosition = CurrentCamera.CFrame.p + CurrentCamera.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0));
    end;

    p36.lastSubjectPosition = SubjectPosition;

    return SubjectPosition;
end;

function u2.getRotation(p37, p38) -- Line: 394
    -- upvalues: CameraInput (copy), UserGameSettings (copy)
    local Rotation = CameraInput.getRotation(p38);

    if UserGameSettings.VRSmoothRotationEnabled then
        return Rotation.X;
    end;

    if math.abs(Rotation.X) > 0.03 then
        if p37.stepRotateTimeout > 0 then
            p37.stepRotateTimeout = p37.stepRotateTimeout - p38;
        end;

        if p37.stepRotateTimeout <= 0 then
            local v39 = (Rotation.X < 0 and -1 or 1) * 0.5235987755982988;
            p37:StartFadeFromBlack();
            p37.stepRotateTimeout = 0.25;

            return v39;
        end;
    elseif math.abs(Rotation.X) < 0.02 then
        p37.stepRotateTimeout = 0;
    end;

    return 0;
end;

function u2.HandleSubjectDistance(p40, p41) -- Line: 429
    -- upvalues: u1 (ref)
    if u1 and (p41 and (p41.IsInFirstPerson and p41:IsInFirstPerson())) then
        p40:SetCameraToSubjectDistance(0);
    end;
end;

return u2;