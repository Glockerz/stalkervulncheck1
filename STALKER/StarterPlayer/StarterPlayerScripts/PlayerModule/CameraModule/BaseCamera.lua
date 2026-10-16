-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("UserInputService");
local VRService = game:GetService("VRService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
require(CommonUtils:WaitForChild("FlagUtil"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUI = require(script.Parent:WaitForChild("CameraUI"));
local LocalPlayer = Players.LocalPlayer;
Vector2.new(0, 0);
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 70
    -- upvalues: u1 (copy), ConnectionUtil (copy), LocalPlayer (copy), UserGameSettings (copy)
    local v2 = setmetatable({}, u1);
    v2._connections = ConnectionUtil.new();
    v2.gamepadZoomLevels = { 0, 10, 20 };
    v2.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
    v2.cameraType = nil;
    v2.cameraMovementMode = nil;
    v2.lastCameraTransform = nil;
    v2.lastUserPanCamera = tick();
    v2.humanoidRootPart = nil;
    v2.humanoidCache = {};
    v2.lastSubject = nil;
    v2.lastSubjectPosition = Vector3.new(0, 5, 0);
    v2.lastSubjectCFrame = CFrame.new(v2.lastSubjectPosition);
    v2.currentSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);
    v2.inFirstPerson = false;
    v2.inMouseLockedMode = false;
    v2.resetCameraAngle = true;
    v2.enabled = false;
    v2.cameraChangedConn = nil;
    v2.shouldUseVRRotation = false;
    v2.VRRotationIntensityAvailable = false;
    v2.lastVRRotationIntensityCheckTime = 0;
    v2.lastVRRotationTime = 0;
    v2.vrRotateKeyCooldown = {};
    v2.cameraTranslationConstraints = Vector3.new(1, 1, 1);
    v2.humanoidJumpOrigin = nil;
    v2.trackingHumanoid = nil;
    v2.cameraFrozen = false;
    v2.subjectStateChangedConn = nil;
    v2.gamepadZoomPressConnection = nil;
    v2.mouseLockOffset = Vector3.new(0, 0, 0);
    UserGameSettings:SetCameraYInvertVisible();
    UserGameSettings:SetGamepadCameraSensitivityVisible();

    return v2;
end;

function u1.GetModuleName(p3) -- Line: 130
    return "BaseCamera";
end;

function u1._setUpConfigurations(u4) -- Line: 134
    -- upvalues: LocalPlayer (copy)
    u4._connections:trackConnection("CHARACTER_ADDED", LocalPlayer.CharacterAdded:Connect(function(p5) -- Line: 135
        -- upvalues: u4 (copy)
        u4:OnCharacterAdded(p5);
    end));
    u4.humanoidRootPart = nil;
    u4._connections:trackConnection("CAMERA_MODE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function() -- Line: 140
        -- upvalues: u4 (copy)
        u4:OnPlayerCameraPropertyChange();
    end));
    u4._connections:trackConnection("CAMERA_MIN_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() -- Line: 143
        -- upvalues: u4 (copy)
        u4:OnPlayerCameraPropertyChange();
    end));
    u4._connections:trackConnection("CAMERA_MAX_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() -- Line: 146
        -- upvalues: u4 (copy)
        u4:OnPlayerCameraPropertyChange();
    end));
    u4:OnPlayerCameraPropertyChange();
end;

function u1.OnCharacterAdded(p6, p7) -- Line: 152
    p6.resetCameraAngle = p6.resetCameraAngle or p6:GetEnabled();
    p6.humanoidRootPart = nil;
end;

function u1.GetHumanoidRootPart(p8) -- Line: 159
    -- upvalues: LocalPlayer (copy)
    local v9 = (not p8.humanoidRootPart and LocalPlayer.Character and true or false) and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v9 then
        p8.humanoidRootPart = v9.RootPart;
    end;

    return p8.humanoidRootPart;
end;

function u1.GetBodyPartToFollow(p10: table, p11: userdata, p12: boolean) -- Line: 171
    if p11:GetState() == Enum.HumanoidStateType.Dead then
        local Parent = p11.Parent;

        if Parent and Parent:IsA("Model") then
            return Parent:FindFirstChild("Head") or p11.RootPart;
        end;
    end;

    return p11.RootPart;
end;

function u1.GetSubjectCFrame(p13) -- Line: 183
    local lastSubjectCFrame = p13.lastSubjectCFrame;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CameraSubject;
    end;

    if not workspace_CurrentCamera then
        return lastSubjectCFrame;
    end;

    if workspace_CurrentCamera:IsA("Humanoid") then
        local v14 = workspace_CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = workspace_CurrentCamera.CameraOffset;

        if p13:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = workspace_CurrentCamera.RootPart;

        if v14 and (workspace_CurrentCamera.Parent and workspace_CurrentCamera.Parent:IsA("Model")) then
            RootPart = workspace_CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v15;

            if workspace_CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if workspace_CurrentCamera.AutomaticScalingEnabled then
                    v15 = Vector3.new(0, 1.5, 0);
                    local RootPart2 = workspace_CurrentCamera.RootPart;

                    if RootPart == RootPart2 then
                        v15 = v15 + Vector3.new(0, (RootPart2.Size.Y - 2) / 2, 0);
                    end;
                else
                    v15 = Vector3.new(0, 2, 0);
                end;
            else
                v15 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectCFrame = RootPart.CFrame * CFrame.new((v14 and Vector3.new(0, 0, 0) or v15) + CameraOffset);
        end;
    elseif workspace_CurrentCamera:IsA("BasePart") then
        lastSubjectCFrame = workspace_CurrentCamera.CFrame;
    elseif workspace_CurrentCamera:IsA("Model") then
        if workspace_CurrentCamera.PrimaryPart then
            lastSubjectCFrame = workspace_CurrentCamera:GetPrimaryPartCFrame();
        else
            lastSubjectCFrame = CFrame.new();
        end;
    end;

    if lastSubjectCFrame then
        p13.lastSubjectCFrame = lastSubjectCFrame;
    end;

    return lastSubjectCFrame;
end;

function u1.GetSubjectVelocity(p16) -- Line: 257
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CameraSubject;
    end;

    if not workspace_CurrentCamera then
        return Vector3.new(0, 0, 0);
    end;

    if workspace_CurrentCamera:IsA("BasePart") then
        return workspace_CurrentCamera.Velocity;
    end;

    if workspace_CurrentCamera:IsA("Humanoid") then
        local RootPart = workspace_CurrentCamera.RootPart;

        if RootPart then
            return RootPart.Velocity;
        end;
    else
        local v17 = workspace_CurrentCamera:IsA("Model") and workspace_CurrentCamera.PrimaryPart;

        if v17 then
            return v17.Velocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u1.GetSubjectRotVelocity(p18) -- Line: 286
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CameraSubject;
    end;

    if not workspace_CurrentCamera then
        return Vector3.new(0, 0, 0);
    end;

    if workspace_CurrentCamera:IsA("BasePart") then
        return workspace_CurrentCamera.RotVelocity;
    end;

    if workspace_CurrentCamera:IsA("Humanoid") then
        local RootPart = workspace_CurrentCamera.RootPart;

        if RootPart then
            return RootPart.RotVelocity;
        end;
    else
        local v19 = workspace_CurrentCamera:IsA("Model") and workspace_CurrentCamera.PrimaryPart;

        if v19 then
            return v19.RotVelocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u1.StepZoom(p20) -- Line: 315
    -- upvalues: CameraInput (copy), ZoomController (copy)
    local currentSubjectDistance = p20.currentSubjectDistance;
    local ZoomDelta = CameraInput.getZoomDelta();

    if math.abs(ZoomDelta) > 0 then
        local v21;

        if ZoomDelta > 0 then
            v21 = math.max(currentSubjectDistance + ZoomDelta * (currentSubjectDistance * 0.5 + 1), p20.FIRST_PERSON_DISTANCE_THRESHOLD);
        else
            v21 = math.max((currentSubjectDistance + ZoomDelta) / (1 - ZoomDelta * 0.5), 0.5);
        end;

        p20:SetCameraToSubjectDistance(v21 < p20.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v21);
    end;

    return ZoomController.GetZoomRadius();
end;

function u1.GetSubjectPosition(p22) -- Line: 340
    local lastSubjectPosition = p22.lastSubjectPosition;
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return nil;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local v23 = CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = CurrentCamera.CameraOffset;

        if p22:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = CurrentCamera.RootPart;

        if v23 and (CurrentCamera.Parent and CurrentCamera.Parent:IsA("Model")) then
            RootPart = CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v24;

            if CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if CurrentCamera.AutomaticScalingEnabled then
                    v24 = Vector3.new(0, 1.5, 0);

                    if RootPart == CurrentCamera.RootPart then
                        v24 = v24 + Vector3.new(0, CurrentCamera.RootPart.Size.Y / 2 - 1, 0);
                    end;
                else
                    v24 = Vector3.new(0, 2, 0);
                end;
            else
                v24 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectPosition = RootPart.CFrame.p + RootPart.CFrame:vectorToWorldSpace((v23 and Vector3.new(0, 0, 0) or v24) + CameraOffset);
        end;
    elseif CurrentCamera:IsA("VehicleSeat") then
        lastSubjectPosition = CurrentCamera.CFrame.p + CurrentCamera.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0));
    elseif CurrentCamera:IsA("SkateboardPlatform") then
        lastSubjectPosition = CurrentCamera.CFrame.p + Vector3.new(0, 5, 0);
    elseif CurrentCamera:IsA("BasePart") then
        lastSubjectPosition = CurrentCamera.CFrame.p;
    elseif CurrentCamera:IsA("Model") then
        if CurrentCamera.PrimaryPart then
            lastSubjectPosition = CurrentCamera:GetPrimaryPartCFrame().p;
        else
            lastSubjectPosition = CurrentCamera:GetModelCFrame().p;
        end;
    end;

    p22.lastSubject = CurrentCamera;
    p22.lastSubjectPosition = lastSubjectPosition;

    return lastSubjectPosition;
end;

function u1.OnCurrentCameraChanged(u25) -- Line: 418
    if u25.cameraSubjectChangedConn then
        u25.cameraSubjectChangedConn:Disconnect();
        u25.cameraSubjectChangedConn = nil;
    end;

    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        u25.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 427
            -- upvalues: u25 (copy)
            u25:OnNewCameraSubject();
        end);
        u25:OnNewCameraSubject();
    end;
end;

function u1.OnPlayerCameraPropertyChange(p26) -- Line: 434
    p26:SetCameraToSubjectDistance(p26.currentSubjectDistance);
end;

function u1.InputTranslationToCameraAngleChange(p27, p28, p29) -- Line: 439
    return p28 * p29;
end;

function u1.GamepadZoomPress(p30) -- Line: 445
    -- upvalues: LocalPlayer (copy)
    local CameraToSubjectDistance = p30:GetCameraToSubjectDistance();
    local CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance;

    for i = #p30.gamepadZoomLevels, 1, -1 do
        local v31 = p30.gamepadZoomLevels[i];
        local v32;

        if CameraMaxZoomDistance < v31 then
            v32 = i;
        else
            if v31 < LocalPlayer.CameraMinZoomDistance then
                v31 = LocalPlayer.CameraMinZoomDistance;

                if CameraMaxZoomDistance == v31 then
                    break;
                end;
            end;

            if v31 + (CameraMaxZoomDistance - v31) / 2 < CameraToSubjectDistance then
                p30:SetCameraToSubjectDistance(v31);

                return;
            end;

            CameraMaxZoomDistance = v31;
            v32 = i;
        end;
    end;

    p30:SetCameraToSubjectDistance(p30.gamepadZoomLevels[#p30.gamepadZoomLevels]);
end;

function u1.Enable(p33: table, p34: boolean) -- Line: 482
    if p33.enabled ~= p34 then
        p33.enabled = p34;
        p33:OnEnabledChanged();
    end;
end;

function u1.OnEnabledChanged(u35) -- Line: 490
    -- upvalues: CameraInput (copy), LocalPlayer (copy)
    if not u35.enabled then
        u35._connections:disconnectAll();
        CameraInput.setInputEnabled(false);

        if u35.gamepadZoomPressConnection then
            u35.gamepadZoomPressConnection:Disconnect();
            u35.gamepadZoomPressConnection = nil;
        end;

        u35:Cleanup();

        return;
    end;

    u35:_setUpConfigurations();
    CameraInput.setInputEnabled(true);
    u35.gamepadZoomPressConnection = CameraInput.gamepadZoomPress:Connect(function() -- Line: 496
        -- upvalues: u35 (copy)
        u35:GamepadZoomPress();
    end);

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        u35.currentSubjectDistance = 0.5;

        if not u35.inFirstPerson then
            u35:EnterFirstPerson();
        end;
    end;

    if u35.cameraChangedConn then
        u35.cameraChangedConn:Disconnect();
        u35.cameraChangedConn = nil;
    end;

    u35.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 508
        -- upvalues: u35 (copy)
        u35:OnCurrentCameraChanged();
    end);
    u35:OnCurrentCameraChanged();
end;

function u1.GetEnabled(p36) -- Line: 526
    return p36.enabled;
end;

function u1.Cleanup(p37) -- Line: 530
    -- upvalues: CameraUtils (copy)
    if p37.subjectStateChangedConn then
        p37.subjectStateChangedConn:Disconnect();
        p37.subjectStateChangedConn = nil;
    end;

    if p37.cameraChangedConn then
        p37.cameraChangedConn:Disconnect();
        p37.cameraChangedConn = nil;
    end;

    p37.lastCameraTransform = nil;
    p37.lastSubjectCFrame = nil;
    CameraUtils.restoreMouseBehavior();
end;

function u1.UpdateMouseBehavior(p38) -- Line: 547
    -- upvalues: UserGameSettings (copy), CameraUI (copy), CameraInput (copy), CameraToggleStateController (copy), CameraUtils (copy)
    if p38.isCameraToggle and UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove == false then
        CameraUI.setCameraModeToastEnabled(true);
        CameraInput.enableCameraToggleInput();
        CameraToggleStateController(p38.inFirstPerson);

        return;
    end;

    CameraUI.setCameraModeToastEnabled(false);
    CameraInput.disableCameraToggleInput();

    if p38.inFirstPerson or p38.inMouseLockedMode then
        CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative);
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter);

        return;
    end;

    CameraUtils.restoreRotationType();

    if CameraInput.getRotationActivated() then
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition);

        return;
    end;

    CameraUtils.restoreMouseBehavior();
end;

function u1.UpdateForDistancePropertyChange(p39) -- Line: 575
    p39:SetCameraToSubjectDistance(p39.currentSubjectDistance);
end;

function u1.SetCameraToSubjectDistance(p40: table, p41: number) -- Line: 581
    -- upvalues: LocalPlayer (copy), ZoomController (copy)
    local currentSubjectDistance = p40.currentSubjectDistance;

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        p40.currentSubjectDistance = 0.5;

        if not p40.inFirstPerson then
            p40:EnterFirstPerson();
        end;
    else
        local math_clamp_ret = math.clamp(p41, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);

        if math_clamp_ret < 1 then
            p40.currentSubjectDistance = 0.5;

            if not p40.inFirstPerson then
                p40:EnterFirstPerson();
            end;
        else
            p40.currentSubjectDistance = math_clamp_ret;

            if p40.inFirstPerson then
                p40:LeaveFirstPerson();
            end;
        end;
    end;

    ZoomController.SetZoomParameters(p40.currentSubjectDistance, (math.sign(p41 - currentSubjectDistance)));

    return p40.currentSubjectDistance;
end;

function u1.SetCameraType(p42, p43) -- Line: 615
    p42.cameraType = p43;
end;

function u1.GetCameraType(p44) -- Line: 620
    return p44.cameraType;
end;

function u1.SetCameraMovementMode(p45, p46) -- Line: 625
    p45.cameraMovementMode = p46;
end;

function u1.GetCameraMovementMode(p47) -- Line: 629
    return p47.cameraMovementMode;
end;

function u1.SetIsMouseLocked(p48: table, p49: boolean) -- Line: 633
    p48.inMouseLockedMode = p49;
end;

function u1.GetIsMouseLocked(p50) -- Line: 637
    return p50.inMouseLockedMode;
end;

function u1.SetMouseLockOffset(p51, p52) -- Line: 641
    p51.mouseLockOffset = p52;
end;

function u1.GetMouseLockOffset(p53) -- Line: 645
    return p53.mouseLockOffset;
end;

function u1.InFirstPerson(p54) -- Line: 649
    return p54.inFirstPerson;
end;

function u1.EnterFirstPerson(p55) -- Line: 653
    p55.inFirstPerson = true;
    p55:UpdateMouseBehavior();
end;

function u1.LeaveFirstPerson(p56) -- Line: 658
    p56.inFirstPerson = false;
    p56:UpdateMouseBehavior();
end;

function u1.GetCameraToSubjectDistance(p57) -- Line: 664
    return p57.currentSubjectDistance;
end;

function u1.GetMeasuredDistanceToFocus(p58) -- Line: 671
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        return (CurrentCamera.CoordinateFrame.p - CurrentCamera.Focus.p).magnitude;
    end;

    return nil;
end;

function u1.GetCameraLookVector(p59) -- Line: 679
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1);
end;

function u1.CalculateNewLookCFrameFromArg(p60: table, p61: vector?, p62) -- Line: 683
    local v63 = p61 or p60:GetCameraLookVector();
    local math_asin_ret = math.asin(v63.Y);
    local math_clamp_ret = math.clamp(p62.Y, math_asin_ret + -1.3962634015954636, math_asin_ret + 1.3962634015954636);
    local Vector2_new_ret = Vector2.new(p62.X, math_clamp_ret);
    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), v63);

    return CFrame.Angles(0, -Vector2_new_ret.X, 0) * CFrame_new_ret * CFrame.Angles(-Vector2_new_ret.Y, 0, 0);
end;

function u1.CalculateNewLookVectorFromArg(p64: table, p65: vector?, p66) -- Line: 693
    return p64:CalculateNewLookCFrameFromArg(p65, p66).LookVector;
end;

function u1.CalculateNewLookVectorVRFromArg(p67: table, p68) -- Line: 698
    local unit = ((p67:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit;
    local Vector2_new_ret = Vector2.new(p68.X, 0);
    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), unit);

    return ((CFrame.Angles(0, -Vector2_new_ret.X, 0) * CFrame_new_ret * CFrame.Angles(-Vector2_new_ret.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit;
end;

function u1.GetHumanoid(p69) -- Line: 708
    -- upvalues: LocalPlayer (copy)
    local v70 = LocalPlayer and LocalPlayer.Character;

    if not v70 then
        return nil;
    end;

    local v71 = p69.humanoidCache[LocalPlayer];

    if v71 and v71.Parent == v70 then
        return v71;
    end;

    p69.humanoidCache[LocalPlayer] = nil;
    local v72 = v70:FindFirstChildOfClass("Humanoid");

    if v72 then
        p69.humanoidCache[LocalPlayer] = v72;
    end;

    return v72;
end;

function u1.GetHumanoidPartToFollow(p73: table, p74: userdata, p75: any) -- Line: 726
    if p75 ~= Enum.HumanoidStateType.Dead then
        return p74.Torso;
    end;

    local Parent = p74.Parent;

    if Parent then
        return Parent:FindFirstChild("Head") or p74.Torso;
    end;

    return p74.Torso;
end;

function u1.OnNewCameraSubject(p76) -- Line: 740
    if p76.subjectStateChangedConn then
        p76.subjectStateChangedConn:Disconnect();
        p76.subjectStateChangedConn = nil;
    end;
end;

function u1.IsInFirstPerson(p77) -- Line: 747
    return p77.inFirstPerson;
end;

function u1.Update(p78, p79) -- Line: 751
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;

function u1.GetCameraHeight(p80) -- Line: 755
    -- upvalues: VRService (copy)
    return (not VRService.VREnabled or p80.inFirstPerson) and 0 or 0.25881904510252074 * p80.currentSubjectDistance;
end;

return u1;