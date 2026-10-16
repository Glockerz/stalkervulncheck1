-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = { "CameraMinZoomDistance", "CameraMaxZoomDistance", "CameraMode", "DevCameraOcclusionMode", "DevComputerCameraMode", "DevTouchCameraMode", "DevComputerMovementMode", "DevTouchMovementMode", "DevEnableMouseLock" };
local u3 = { "ComputerCameraMovementMode", "ComputerMovementMode", "ControlMode", "GamepadCameraSensitivity", "MouseSensitivity", "RotationType", "TouchCameraMovementMode", "TouchMovementMode" };
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local VRService = game:GetService("VRService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CommonUtils = script.Parent:WaitForChild("CommonUtils");
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local CameraUtils = require(script:WaitForChild("CameraUtils"));
local CameraInput = require(script:WaitForChild("CameraInput"));
local ClassicCamera = require(script:WaitForChild("ClassicCamera"));
local OrbitalCamera = require(script:WaitForChild("OrbitalCamera"));
local LegacyCamera = require(script:WaitForChild("LegacyCamera"));
local VehicleCamera = require(script:WaitForChild("VehicleCamera"));
local VRCamera = require(script:WaitForChild("VRCamera"));
local VRVehicleCamera = require(script:WaitForChild("VRVehicleCamera"));
local Invisicam = require(script:WaitForChild("Invisicam"));
local Poppercam = require(script:WaitForChild("Poppercam"));
local TransparencyController = require(script:WaitForChild("TransparencyController"));
local MouseLockController = require(script:WaitForChild("MouseLockController"));
local u4 = {};
local u5 = {};

if not Players.LocalPlayer then
    return {};
end;

assert(Players.LocalPlayer, "Strict typing check");
local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts");
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default);
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow);
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle);
local UserFlag = FlagUtil.getUserFlag("UserPlayerConnectionMemoryLeak");
local UserFlag2 = FlagUtil.getUserFlag("UserPSFixCameraControllerReset");

function u1.new() -- Line: 144
    -- upvalues: TransparencyController (copy), UserFlag (copy), ConnectionUtil (copy), u1 (copy), Players (copy), MouseLockController (copy), RunService (copy), u2 (copy), u3 (copy), UserGameSettings (copy), UserInputService (copy)
    local v6 = {
        activeTransparencyController = TransparencyController.new()
    };
    local v7;

    if UserFlag then
        v7 = ConnectionUtil.new();
    else
        v7 = nil;
    end;

    v6.connectionUtil = v7;
    local u8 = setmetatable(v6, u1);
    u8.activeCameraController = nil;
    u8.activeOcclusionModule = nil;
    u8.activeMouseLockController = nil;
    u8.currentComputerCameraMovementMode = nil;
    u8.cameraSubjectChangedConn = nil;
    u8.cameraTypeChangedConn = nil;

    for _, v in pairs(Players:GetPlayers()) do
        u8:OnPlayerAdded(v);
    end;

    Players.PlayerAdded:Connect(function(p9) -- Line: 167
        -- upvalues: u8 (copy)
        u8:OnPlayerAdded(p9);
    end);

    if UserFlag then
        Players.PlayerRemoving:Connect(function(p10) -- Line: 172
            -- upvalues: u8 (copy)
            u8:OnPlayerRemoving(p10);
        end);
    end;

    u8.activeTransparencyController:Enable(true);
    u8.activeMouseLockController = MouseLockController.new();
    assert(u8.activeMouseLockController, "Strict typing check");
    local BindableToggleEvent = u8.activeMouseLockController:GetBindableToggleEvent();

    if BindableToggleEvent then
        BindableToggleEvent:Connect(function() -- Line: 184
            -- upvalues: u8 (copy)
            u8:OnMouseLockToggled();
        end);
    end;

    u8:ActivateCameraController();
    u8:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);
    u8:OnCurrentCameraChanged();
    RunService:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p11) -- Line: 192
        -- upvalues: u8 (copy)
        u8:Update(p11);
    end);

    for _, v in pairs(u2) do
        Players.LocalPlayer:GetPropertyChangedSignal(v):Connect(function() -- Line: 196
            -- upvalues: u8 (copy), v (copy)
            u8:OnLocalPlayerCameraPropertyChanged(v);
        end);
    end;

    for _, v in pairs(u3) do
        UserGameSettings:GetPropertyChangedSignal(v):Connect(function() -- Line: 202
            -- upvalues: u8 (copy), v (copy)
            u8:OnUserGameSettingsPropertyChanged(v);
        end);
    end;

    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 206
        -- upvalues: u8 (copy)
        u8:OnCurrentCameraChanged();
    end);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 209
        -- upvalues: u8 (copy)
        u8:OnPreferredInputChanged();
    end);

    return u8;
end;

function u1.GetCameraMovementModeFromSettings(p12) -- Line: 216
    -- upvalues: Players (copy), CameraUtils (copy), UserInputService (copy), UserGameSettings (copy)
    if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic);
    end;

    local v13, v14;

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        v13 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevTouchCameraMode);
        v14 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode);
    else
        v13 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevComputerCameraMode);
        v14 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode);
    end;

    if v13 == Enum.DevComputerCameraMovementMode.UserChoice then
        return v14;
    end;

    return v13;
end;

function u1.ActivateOcclusionModule(p15, p16) -- Line: 241
    -- upvalues: Poppercam (copy), Invisicam (copy), u5 (copy), Players (copy)
    local v17;

    if p16 == Enum.DevCameraOcclusionMode.Zoom then
        v17 = Poppercam;
    else
        if p16 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode");

            return;
        end;

        v17 = Invisicam;
    end;

    p15.occlusionMode = p16;

    if p15.activeOcclusionModule and p15.activeOcclusionModule:GetOcclusionMode() == p16 then
        if not p15.activeOcclusionModule:GetEnabled() then
            p15.activeOcclusionModule:Enable(true);
        end;

        return;
    end;

    local activeOcclusionModule = p15.activeOcclusionModule;
    p15.activeOcclusionModule = u5[v17];

    if not p15.activeOcclusionModule then
        p15.activeOcclusionModule = v17.new();

        if p15.activeOcclusionModule then
            u5[v17] = p15.activeOcclusionModule;
        end;
    end;

    if p15.activeOcclusionModule then
        if p15.activeOcclusionModule:GetOcclusionMode() ~= p16 then
            warn("CameraScript ActivateOcclusionModule mismatch: ", p15.activeOcclusionModule:GetOcclusionMode(), "~=", p16);
        end;

        if activeOcclusionModule then
            if activeOcclusionModule == p15.activeOcclusionModule then
                warn("CameraScript ActivateOcclusionModule failure to detect already running correct module");
            else
                activeOcclusionModule:Enable(false);
            end;
        end;

        if p16 == Enum.DevCameraOcclusionMode.Invisicam then
            if Players.LocalPlayer.Character then
                p15.activeOcclusionModule:CharacterAdded(Players.LocalPlayer.Character, Players.LocalPlayer);
            end;
        else
            for _, v in pairs(Players:GetPlayers()) do
                if v and v.Character then
                    p15.activeOcclusionModule:CharacterAdded(v.Character, v);
                end;
            end;

            p15.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
        end;

        p15.activeOcclusionModule:Enable(true);
    end;
end;

function u1.ShouldUseVehicleCamera(p18) -- Line: 320
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return false;
    end;

    local CameraType = workspace_CurrentCamera.CameraType;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local v19 = CameraType == Enum.CameraType.Custom and true or CameraType == Enum.CameraType.Follow;
    local v20 = CameraSubject and CameraSubject:IsA("VehicleSeat") or false;
    local v21 = p18.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam;

    if v20 then
        if not v19 then
            v21 = v19;
        end;
    else
        v21 = v20;
    end;

    return v21;
end;

function u1.ActivateCameraController(p22) -- Line: 336
    -- upvalues: LegacyCamera (copy), VRService (copy), VRCamera (copy), ClassicCamera (copy), OrbitalCamera (copy), VRVehicleCamera (copy), VehicleCamera (copy), u4 (copy), UserFlag2 (copy)
    local CameraType = workspace.CurrentCamera.CameraType;
    local CameraMovementModeFromSettings = p22:GetCameraMovementModeFromSettings();
    local v23 = nil;

    if CameraType == Enum.CameraType.Scriptable then
        if p22.activeCameraController then
            p22.activeCameraController:Enable(false);
            p22.activeCameraController = nil;
        end;

        return;
    end;

    if CameraType == Enum.CameraType.Custom then
        CameraMovementModeFromSettings = p22:GetCameraMovementModeFromSettings();
    elseif CameraType == Enum.CameraType.Track then
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Classic;
    elseif CameraType == Enum.CameraType.Follow then
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Follow;
    elseif CameraType == Enum.CameraType.Orbital then
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Orbital;
    elseif CameraType == Enum.CameraType.Attach or (CameraType == Enum.CameraType.Watch or CameraType == Enum.CameraType.Fixed) then
        v23 = LegacyCamera;
    else
        warn("CameraScript encountered an unhandled Camera.CameraType value: ", CameraType);
    end;

    if not v23 then
        if VRService.VREnabled then
            v23 = VRCamera;
        elseif CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.Classic or (CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.Follow or (CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.Default or CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.CameraToggle)) then
            v23 = ClassicCamera;
        else
            if CameraMovementModeFromSettings ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.");

                return;
            end;

            v23 = OrbitalCamera;
        end;
    end;

    if p22:ShouldUseVehicleCamera() then
        if VRService.VREnabled then
            v23 = VRVehicleCamera;
        else
            v23 = VehicleCamera;
        end;
    end;

    local v24;

    if u4[v23] then
        v24 = u4[v23];

        if UserFlag2 then
            if v24.Reset and p22.activeCameraController ~= v24 then
                v24:Reset();
            end;
        elseif v24.Reset then
            v24:Reset();
        end;
    else
        v24 = v23.new();
        u4[v23] = v24;
    end;

    if p22.activeCameraController then
        if p22.activeCameraController == v24 then
            if not p22.activeCameraController:GetEnabled() then
                p22.activeCameraController:Enable(true);
            end;
        else
            if v24.HandleSubjectDistance then
                v24:HandleSubjectDistance(p22.activeCameraController);
            end;

            p22.activeCameraController:Enable(false);
            p22.activeCameraController = v24;
            p22.activeCameraController:Enable(true);
        end;
    elseif v24 ~= nil then
        p22.activeCameraController = v24;
        assert(p22.activeCameraController, "Strict typing check");
        p22.activeCameraController:Enable(true);
    end;

    if p22.activeCameraController then
        p22.activeCameraController:SetCameraMovementMode(CameraMovementModeFromSettings);
        p22.activeCameraController:SetCameraType(CameraType);
    end;
end;

function u1.OnCameraSubjectChanged(p25) -- Line: 445
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v26;

    if workspace_CurrentCamera then
        v26 = workspace_CurrentCamera.CameraSubject;
    else
        v26 = nil;
    end;

    if p25.activeTransparencyController then
        p25.activeTransparencyController:SetSubject(v26);
    end;

    if p25.activeOcclusionModule then
        p25.activeOcclusionModule:OnCameraSubjectChanged(v26);
    end;

    p25:ActivateCameraController();
end;

function u1.OnCameraTypeChanged(p27, p28) -- Line: 460
    -- upvalues: UserInputService (copy), CameraUtils (copy)
    if p28 == Enum.CameraType.Scriptable and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils.restoreMouseBehavior();
    end;

    p27:ActivateCameraController();
end;

function u1.OnCurrentCameraChanged(u29) -- Line: 472
    local CurrentCamera = game.Workspace.CurrentCamera;

    if not CurrentCamera then
        return;
    end;

    if u29.cameraSubjectChangedConn then
        u29.cameraSubjectChangedConn:Disconnect();
    end;

    if u29.cameraTypeChangedConn then
        u29.cameraTypeChangedConn:Disconnect();
    end;

    u29.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 484
        -- upvalues: u29 (copy)
        u29:OnCameraSubjectChanged();
    end);
    u29.cameraTypeChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 488
        -- upvalues: u29 (copy), CurrentCamera (copy)
        u29:OnCameraTypeChanged(CurrentCamera.CameraType);
    end);
    u29:OnCameraSubjectChanged();
    u29:OnCameraTypeChanged(CurrentCamera.CameraType);
end;

function u1.OnLocalPlayerCameraPropertyChanged(p30: table, p31: string) -- Line: 496
    -- upvalues: Players (copy)
    if p31 == "CameraMode" then
        if Players.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if Players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                p30:ActivateCameraController();

                return;
            end;

            warn("Unhandled value for property player.CameraMode: ", Players.LocalPlayer.CameraMode);

            return;
        end;

        if not p30.activeCameraController or p30.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p30:ActivateCameraController();
        end;

        if p30.activeCameraController then
            p30.activeCameraController:UpdateForDistancePropertyChange();
        end;
    else
        if p31 == "DevComputerCameraMode" or p31 == "DevTouchCameraMode" then
            p30:ActivateCameraController();

            return;
        end;

        if p31 == "DevCameraOcclusionMode" then
            p30:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);

            return;
        end;

        if p31 == "CameraMinZoomDistance" or p31 == "CameraMaxZoomDistance" then
            if p30.activeCameraController then
                p30.activeCameraController:UpdateForDistancePropertyChange();
            end;
        else
            if p31 == "DevTouchMovementMode" then
                return;
            end;

            if p31 == "DevComputerMovementMode" then
                return;
            end;

            local _ = p31 == "DevEnableMouseLock";
        end;
    end;
end;

function u1.OnUserGameSettingsPropertyChanged(p32: table, p33: string) -- Line: 538
    if p33 == "ComputerCameraMovementMode" or p33 == "TouchCameraMovementMode" then
        p32:ActivateCameraController();
    end;
end;

function u1.OnPreferredInputChanged(p34) -- Line: 544
    p34:ActivateCameraController();
end;

function u1.Update(p35, p36) -- Line: 554
    -- upvalues: CameraInput (copy)
    if p35.activeCameraController then
        p35.activeCameraController:UpdateMouseBehavior();
        local v37, v38 = p35.activeCameraController:Update(p36);

        if p35.activeOcclusionModule and not p35.activeCameraController.skipOcclusion then
            v37, v38 = p35.activeOcclusionModule:Update(p36, v37, v38);
        end;

        local CurrentCamera = game.Workspace.CurrentCamera;
        CurrentCamera.CFrame = v37;
        CurrentCamera.Focus = v38;

        if p35.activeTransparencyController then
            p35.activeTransparencyController:Update(p36);
        end;

        if CameraInput.getInputEnabled() then
            CameraInput.resetInputForFrameEnd();
        end;
    end;
end;

function u1.OnCharacterAdded(p39: table, p40: userdata, p41: userdata) -- Line: 580
    if p39.activeOcclusionModule then
        p39.activeOcclusionModule:CharacterAdded(p40, p41);
    end;
end;

function u1.OnCharacterRemoving(p42, p43, p44) -- Line: 586
    if p42.activeOcclusionModule then
        p42.activeOcclusionModule:CharacterRemoving(p43, p44);
    end;
end;

function u1.OnPlayerAdded(u45: table, u46: userdata) -- Line: 592
    -- upvalues: UserFlag (copy)
    if UserFlag then
        if u45.connectionUtil then
            u45.connectionUtil:trackConnection(`{u46.UserId}CharacterAdded`, u46.CharacterAdded:Connect(function(p47) -- Line: 596
                -- upvalues: u45 (copy), u46 (copy)
                u45:OnCharacterAdded(p47, u46);
            end));
            u45.connectionUtil:trackConnection(`{u46.UserId}CharacterRemoving`, u46.CharacterRemoving:Connect(function(p48) -- Line: 599
                -- upvalues: u45 (copy), u46 (copy)
                u45:OnCharacterRemoving(p48, u46);
            end));
        end;
    else
        u46.CharacterAdded:Connect(function(p49) -- Line: 604
            -- upvalues: u45 (copy), u46 (copy)
            u45:OnCharacterAdded(p49, u46);
        end);
        u46.CharacterRemoving:Connect(function(p50) -- Line: 607
            -- upvalues: u45 (copy), u46 (copy)
            u45:OnCharacterRemoving(p50, u46);
        end);
    end;
end;

function u1.OnPlayerRemoving(p51: table, p52: userdata) -- Line: 613
    if p51.connectionUtil then
        p51.connectionUtil:disconnect((`{p52.UserId}CharacterAdded`));
        p51.connectionUtil:disconnect((`{p52.UserId}CharacterRemoving`));
    end;
end;

function u1.OnMouseLockToggled(p53) -- Line: 621
    if p53.activeMouseLockController then
        local IsMouseLocked = p53.activeMouseLockController:GetIsMouseLocked();
        local MouseLockOffset = p53.activeMouseLockController:GetMouseLockOffset();

        if p53.activeCameraController then
            p53.activeCameraController:SetIsMouseLocked(IsMouseLocked);
            p53.activeCameraController:SetMouseLockOffset(MouseLockOffset);
        end;
    end;
end;

u1.new();

return {};