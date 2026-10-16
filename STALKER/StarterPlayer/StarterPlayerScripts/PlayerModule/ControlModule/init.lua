-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Workspace = game:GetService("Workspace");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRService = game:GetService("VRService");
script.Parent:WaitForChild("CommonUtils");
local Keyboard = require(script:WaitForChild("Keyboard"));
local Gamepad = require(script:WaitForChild("Gamepad"));
local DynamicThumbstick = require(script:WaitForChild("DynamicThumbstick"));
local success, result = pcall(function() -- Line: 41
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate");
end);
local u2 = success and result;
local TouchThumbstick = require(script:WaitForChild("TouchThumbstick"));
local ClickToMoveController = require(script:WaitForChild("ClickToMoveController"));
local TouchJump = require(script:WaitForChild("TouchJump"));
local VehicleController = require(script:WaitForChild("VehicleController"));
local success2, result2 = pcall(function() -- Line: 58
    return UserSettings():IsUserFeatureEnabled("UserPlayerScriptsSupportMicroGamepad");
end);
local u3 = success2 and result2;
local Value = Enum.ContextActionPriority.Medium.Value;
local u4 = {
    [Enum.TouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbstick] = TouchThumbstick,
    [Enum.DevTouchMovementMode.Thumbstick] = TouchThumbstick,
    [Enum.TouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
    [Enum.TouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.TouchMovementMode.Default] = DynamicThumbstick,
    [Enum.ComputerMovementMode.Default] = Keyboard,
    [Enum.ComputerMovementMode.KeyboardMouse] = Keyboard,
    [Enum.DevComputerMovementMode.KeyboardMouse] = Keyboard,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController
};

function u1.new() -- Line: 92
    -- upvalues: u1 (copy), Players (copy), VehicleController (copy), Value (copy), RunService (copy), UserGameSettings (copy), GuiService (copy), UserInputService (copy)
    local u5 = setmetatable({}, u1);
    u5.controllers = {};
    u5.activeControlModule = nil;
    u5.activeController = nil;
    u5.touchJumpController = nil;
    u5.moveFunction = Players.LocalPlayer.Move;
    u5.humanoid = nil;
    u5.controlsEnabled = true;
    u5.humanoidSeatedConn = nil;
    u5.vehicleController = nil;
    u5.touchControlFrame = nil;
    u5.currentTorsoAngle = 0;
    u5.inputMoveVector = Vector3.new(0, 0, 0);
    u5.vehicleController = VehicleController.new(Value);
    Players.LocalPlayer.CharacterAdded:Connect(function(p6) -- Line: 117
        -- upvalues: u5 (copy)
        u5:OnCharacterAdded(p6);
    end);
    Players.LocalPlayer.CharacterRemoving:Connect(function(p7) -- Line: 118
        -- upvalues: u5 (copy)
        u5:OnCharacterRemoving(p7);
    end);

    if Players.LocalPlayer.Character then
        u5:OnCharacterAdded(Players.LocalPlayer.Character);
    end;

    RunService:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p8) -- Line: 123
        -- upvalues: u5 (copy)
        u5:OnRenderStepped(p8);
    end);
    UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- Line: 127
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- Line: 130
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() -- Line: 134
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- Line: 137
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    u5.playerGui = nil;
    u5.touchGui = nil;
    u5.playerGuiAddedConn = nil;
    GuiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function() -- Line: 146
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
        u5:UpdateActiveControlModuleEnabled();
    end);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 151
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    u5.playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not u5.playerGui then
        u5.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect(function(p9) -- Line: 157
            -- upvalues: u5 (copy)
            if p9:IsA("PlayerGui") then
                u5.playerGui = p9;
                u5.playerGuiAddedConn:Disconnect();
                u5.playerGuiAddedConn = nil;
                u5:UpdateMovementMode();
            end;
        end);
    end;

    u5:UpdateMovementMode();

    return u5;
end;

function u1.GetMoveVector(p10) -- Line: 175
    return not p10.activeController and Vector3.new(0, 0, 0) or p10.activeController:GetMoveVector();
end;

local function NormalizeAngle(p11) -- Line: 182
    local v12 = (p11 + 12.566370614359172) % 6.283185307179586;

    if v12 > 3.141592653589793 then
        v12 = v12 - 6.283185307179586;
    end;

    return v12;
end;

local function AverageAngle(p13, p14) -- Line: 190
    local v15 = (p14 - p13 + 12.566370614359172) % 6.283185307179586;

    if v15 > 3.141592653589793 then
        v15 = v15 - 6.283185307179586;
    end;

    local v16 = (p13 + v15 / 2 + 12.566370614359172) % 6.283185307179586;

    if v16 > 3.141592653589793 then
        v16 = v16 - 6.283185307179586;
    end;

    return v16;
end;

function u1.GetEstimatedVRTorsoFrame(p17) -- Line: 195
    -- upvalues: VRService (copy)
    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local _, v18, _ = UserCFrame:ToEulerAnglesYXZ();
    local v19 = -v18;

    if VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        local UserCFrame2 = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand);
        local UserCFrame3 = VRService:GetUserCFrame(Enum.UserCFrame.RightHand);
        local v20 = UserCFrame.Position - UserCFrame2.Position;
        local v21 = UserCFrame.Position - UserCFrame3.Position;
        local v22 = -math.atan2(v20.X, v20.Z);
        local v23 = (-math.atan2(v21.X, v21.Z) - v22 + 12.566370614359172) % 6.283185307179586;

        if v23 > 3.141592653589793 then
            v23 = v23 - 6.283185307179586;
        end;

        local v24 = (v22 + v23 / 2 + 12.566370614359172) % 6.283185307179586;

        if v24 > 3.141592653589793 then
            v24 = v24 - 6.283185307179586;
        end;

        local v25 = (v19 - p17.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;

        if v25 > 3.141592653589793 then
            v25 = v25 - 6.283185307179586;
        end;

        local v26 = (v24 - p17.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;

        if v26 > 3.141592653589793 then
            v26 = v26 - 6.283185307179586;
        end;

        local v27;

        if v26 > -1.5707963267948966 then
            v27 = v26 < 1.5707963267948966;
        else
            v27 = false;
        end;

        if not v27 then
            v26 = v25;
        end;

        local math_min_ret = math.min(v26, v25);
        local math_max_ret = math.max(v26, v25);
        local v28 = 0;

        if math_min_ret > 0 then
            math_max_ret = math_min_ret;
        elseif math_max_ret >= 0 then
            math_max_ret = v28;
        end;

        p17.currentTorsoAngle = math_max_ret + p17.currentTorsoAngle;
    else
        p17.currentTorsoAngle = v19;
    end;

    return CFrame.new(UserCFrame.Position) * CFrame.fromEulerAnglesYXZ(0, -p17.currentTorsoAngle, 0);
end;

function u1.GetActiveController(p29) -- Line: 239
    return p29.activeController;
end;

function u1.UpdateActiveControlModuleEnabled(u30) -- Line: 244
    -- upvalues: Players (copy), UserInputService (copy), ClickToMoveController (copy), TouchThumbstick (copy), DynamicThumbstick (copy), TouchJump (copy), GuiService (copy)
    local function _() -- Line: 246
        -- upvalues: u30 (copy), Players (ref)
        u30.activeController:Enable(false);

        if u30.touchJumpController then
            u30.touchJumpController:Enable(false);
        end;

        if u30.moveFunction then
            u30.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
        end;
    end;

    local function v31() -- Line: 257
        -- upvalues: u30 (copy), UserInputService (ref), ClickToMoveController (ref), TouchThumbstick (ref), DynamicThumbstick (ref), TouchJump (ref), Players (ref)
        if u30.touchControlFrame and (UserInputService.PreferredInput == Enum.PreferredInput.Touch and (u30.activeControlModule == ClickToMoveController or (u30.activeControlModule == TouchThumbstick or u30.activeControlModule == DynamicThumbstick))) then
            if not u30.controllers[TouchJump] then
                u30.controllers[TouchJump] = TouchJump.new();
            end;

            u30.touchJumpController = u30.controllers[TouchJump];
            u30.touchJumpController:Enable(true, u30.touchControlFrame);
        elseif u30.touchJumpController then
            u30.touchJumpController:Enable(false);
        end;

        if u30.activeControlModule == ClickToMoveController then
            u30.activeController:Enable(true, Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, u30.touchJumpController);

            return;
        end;

        if u30.touchControlFrame then
            u30.activeController:Enable(true, u30.touchControlFrame);

            return;
        end;

        u30.activeController:Enable(true);
    end;

    if not u30.activeController then
        return;
    end;

    if not u30.controlsEnabled then
        u30.activeController:Enable(false);

        if u30.touchJumpController then
            u30.touchJumpController:Enable(false);
        end;

        if u30.moveFunction then
            u30.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
        end;

        return;
    end;

    if GuiService.TouchControlsEnabled or (UserInputService.PreferredInput ~= Enum.PreferredInput.Touch or u30.activeControlModule ~= ClickToMoveController and (u30.activeControlModule ~= TouchThumbstick and u30.activeControlModule ~= DynamicThumbstick)) then
        v31();

        return;
    end;

    u30.activeController:Enable(false);

    if u30.touchJumpController then
        u30.touchJumpController:Enable(false);
    end;

    if u30.moveFunction then
        u30.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
    end;
end;

function u1.Enable(p32: table, p33: boolean?) -- Line: 315
    local v34 = p33 == nil and true or p33;

    if p32.controlsEnabled == v34 then
        return;
    end;

    p32.controlsEnabled = v34;

    if not p32.activeController then
        return;
    end;

    p32:UpdateActiveControlModuleEnabled();
end;

function u1.Disable(p35) -- Line: 330
    p35:Enable(false);
end;

function u1.SelectComputerMovementModule(p36) -- Line: 336
    -- upvalues: UserInputService (copy), Players (copy), u3 (ref), Gamepad (copy), Keyboard (copy), UserGameSettings (copy), ClickToMoveController (copy), u4 (copy)
    if not (UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled) then
        return nil, false;
    end;

    local v37 = nil;
    local DevComputerMovementMode = Players.LocalPlayer.DevComputerMovementMode;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice then
        local u38 = false;

        if u3 then
            pcall(function() -- Line: 347
                -- upvalues: u38 (ref), UserInputService (ref)
                u38 = UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad;
            end);
        end;

        if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad or u38 then
            v37 = Gamepad;
        elseif UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
            v37 = Keyboard;
        end;

        if UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v37 == Keyboard then
            v37 = ClickToMoveController;
        end;
    else
        v37 = u4[DevComputerMovementMode];

        if not v37 and DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode);
        end;
    end;

    if v37 then
        return v37, true;
    end;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
        return nil, true;
    end;

    return nil, false;
end;

function u1.SelectTouchModule(p39) -- Line: 385
    -- upvalues: Players (copy), u4 (copy), UserGameSettings (copy)
    local DevTouchMovementMode = Players.LocalPlayer.DevTouchMovementMode;
    local v40;

    if DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        v40 = u4[UserGameSettings.TouchMovementMode];
    else
        if DevTouchMovementMode == Enum.DevTouchMovementMode.Scriptable then
            return nil, true;
        end;

        v40 = u4[DevTouchMovementMode];
    end;

    return v40, true;
end;

local function getGamepadRightThumbstickPosition() -- Line: 398
    -- upvalues: UserInputService (copy)
    local GamepadState = UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1);

    for _, v in pairs(GamepadState) do
        if v.KeyCode == Enum.KeyCode.Thumbstick2 then
            return v.Position;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u1.calculateRawMoveVector(p41: table, p42: userdata, p43: vector) -- Line: 408
    -- upvalues: Workspace (copy), VRService (copy), getGamepadRightThumbstickPosition (copy)
    local CurrentCamera = Workspace.CurrentCamera;

    if not CurrentCamera then
        return p43;
    end;

    local CFrame2 = CurrentCamera.CFrame;

    if VRService.VREnabled and p42.RootPart then
        VRService:GetUserCFrame(Enum.UserCFrame.Head);
        local EstimatedVRTorsoFrame = p41:GetEstimatedVRTorsoFrame();

        if (CurrentCamera.Focus.Position - CFrame2.Position).Magnitude < 3 then
            CFrame2 = CFrame2 * EstimatedVRTorsoFrame;
        else
            CFrame2 = CurrentCamera.CFrame * (EstimatedVRTorsoFrame.Rotation + EstimatedVRTorsoFrame.Position * CurrentCamera.HeadScale);
        end;
    end;

    if p42:GetState() ~= Enum.HumanoidStateType.Swimming then
        local _, _, _, v44, v45, v46, _, _, v47, _, _, v44 = CFrame2:GetComponents();

        if v47 >= 1 or v47 <= -1 then
            v46 = -v45 * math.sign(v47);
        end;

        local math_sqrt_ret = math.sqrt(v44 * v44 + v46 * v46);

        return Vector3.new((v44 * p43.X + v46 * p43.Z) / math_sqrt_ret, 0, (v44 * p43.Z - v46 * p43.X) / math_sqrt_ret);
    end;

    if not VRService.VREnabled then
        return CFrame2:VectorToWorldSpace(p43);
    end;

    local Vector3_new_ret = Vector3.new(p43.X, 0, p43.Z);

    if Vector3_new_ret.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0);
    end;

    local v48 = -getGamepadRightThumbstickPosition().Y * 1.3962634015954636;
    local math_atan2_ret = math.atan2(-Vector3_new_ret.X, -Vector3_new_ret.Z);
    local _, v49, _ = CFrame2:ToEulerAnglesYXZ();

    return CFrame.fromEulerAnglesYXZ(v48, math_atan2_ret + v49, 0).LookVector;
end;

function u1.OnRenderStepped(p50, p51) -- Line: 467
    -- upvalues: Gamepad (copy), VRService (copy), Players (copy)
    if p50.activeController and (p50.activeController.enabled and p50.humanoid) then
        local MoveVector = p50.activeController:GetMoveVector();
        local v52 = p50.activeController:IsMoveVectorCameraRelative();
        local ClickToMoveController2 = p50:GetClickToMoveController();

        if p50.activeController == ClickToMoveController2 then
            ClickToMoveController2:OnRenderStepped(p51);
        elseif MoveVector.magnitude > 0 then
            ClickToMoveController2:CleanupPath();
        else
            ClickToMoveController2:OnRenderStepped(p51);
            MoveVector = ClickToMoveController2:GetMoveVector();
            v52 = ClickToMoveController2:IsMoveVectorCameraRelative();
        end;

        if p50.vehicleController then
            local v53;
            MoveVector, v53 = p50.vehicleController:Update(MoveVector, v52, p50.activeControlModule == Gamepad);
        end;

        if v52 then
            MoveVector = p50:calculateRawMoveVector(p50.humanoid, MoveVector);
        end;

        p50.inputMoveVector = MoveVector;

        if VRService.VREnabled then
            MoveVector = p50:updateVRMoveVector(MoveVector);
        end;

        p50.moveFunction(Players.LocalPlayer, MoveVector, false);
        local humanoid = p50.humanoid;
        local v54 = p50.activeController:GetIsJumping() or p50.touchJumpController and p50.touchJumpController:GetIsJumping();
        humanoid.Jump = v54;
    end;
end;

function u1.updateVRMoveVector(p55, p56) -- Line: 516
    -- upvalues: VRService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if p56.Magnitude ~= 0 or ((workspace_CurrentCamera.Focus.Position - workspace_CurrentCamera.CFrame.Position).Magnitude >= 5 or not (VRService.AvatarGestures and (p55.humanoid and not p55.humanoid.Sit))) then
        return p56;
    end;

    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local v57 = (workspace_CurrentCamera.CFrame * (UserCFrame.Rotation + UserCFrame.Position * workspace_CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * p55.humanoid.RootPart.Size.Y / 2, 0)).Position - p55.humanoid.RootPart.CFrame.Position;

    return Vector3.new(v57.x, 0, v57.z);
end;

function u1.OnHumanoidSeated(p58: table, p59: boolean, p60: userdata) -- Line: 541
    -- upvalues: Value (copy)
    if p59 then
        if p60 and p60:IsA("VehicleSeat") then
            if not p58.vehicleController then
                p58.vehicleController = p58.vehicleController.new(Value);
            end;

            p58.vehicleController:Enable(true, p60);
        end;
    elseif p58.vehicleController then
        p58.vehicleController:Enable(false, p60);
    end;
end;

function u1.OnCharacterAdded(u61, p62) -- Line: 556
    u61.humanoid = p62:FindFirstChildOfClass("Humanoid");

    while not u61.humanoid do
        p62.ChildAdded:wait();
        u61.humanoid = p62:FindFirstChildOfClass("Humanoid");
    end;

    if u61.humanoidSeatedConn then
        u61.humanoidSeatedConn:Disconnect();
        u61.humanoidSeatedConn = nil;
    end;

    u61.humanoidSeatedConn = u61.humanoid.Seated:Connect(function(p63, p64) -- Line: 567
        -- upvalues: u61 (copy)
        u61:OnHumanoidSeated(p63, p64);
    end);
    u61:UpdateMovementMode();
end;

function u1.OnCharacterRemoving(p65, p66) -- Line: 574
    p65.humanoid = nil;
    p65:UpdateMovementMode();
end;

function u1.UpdateTouchGuiVisibility(p67) -- Line: 580
    -- upvalues: GuiService (copy), UserInputService (copy)
    local v68 = p67.humanoid and GuiService.TouchControlsEnabled and UserInputService.PreferredInput == Enum.PreferredInput.Touch;

    if v68 and not p67.touchGui then
        p67:CreateTouchGuiContainer();
    end;

    if p67.touchGui then
        p67.touchGui.Enabled = v68 and true or false;
    end;
end;

function u1.SwitchToController(p69, p70) -- Line: 599
    -- upvalues: Value (copy)
    if p70 then
        if not p69.controllers[p70] then
            p69.controllers[p70] = p70.new(Value);
        end;

        if p69.activeController ~= p69.controllers[p70] then
            if p69.activeController then
                p69.activeController:Enable(false);
            end;

            p69.activeController = p69.controllers[p70];
            p69.activeControlModule = p70;
            p69:UpdateActiveControlModuleEnabled();
        end;

        return;
    end;

    if p69.activeController then
        p69.activeController:Enable(false);
    end;

    p69.activeController = nil;
    p69.activeControlModule = nil;
end;

function u1.UpdateMovementMode(p71) -- Line: 638
    -- upvalues: UserInputService (copy)
    p71:UpdateTouchGuiVisibility();

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        local v72, v73 = p71:SelectTouchModule();

        if v73 and p71.touchControlFrame then
            p71:SwitchToController(v72);
        end;
    else
        p71:SwitchToController((p71:SelectComputerMovementModule()));
    end;
end;

function u1.CreateTouchGuiContainer(p74) -- Line: 654
    -- upvalues: u2 (ref)
    if not p74.playerGui then
        return;
    end;

    if p74.touchGui then
        p74.touchGui:Destroy();
    end;

    p74.touchGui = Instance.new("ScreenGui");
    p74.touchGui.Name = "TouchGui";
    p74.touchGui.ResetOnSpawn = false;
    p74.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

    if u2 then
        p74.touchGui.ClipToDeviceSafeArea = false;
    end;

    p74.touchControlFrame = Instance.new("Frame");
    p74.touchControlFrame.Name = "TouchControlFrame";
    p74.touchControlFrame.Size = UDim2.new(1, 0, 1, 0);
    p74.touchControlFrame.BackgroundTransparency = 1;
    p74.touchControlFrame.Parent = p74.touchGui;
    p74.touchGui.Parent = p74.playerGui;
end;

function u1.GetClickToMoveController(p75) -- Line: 680
    -- upvalues: ClickToMoveController (copy), Value (copy)
    if not p75.controllers[ClickToMoveController] then
        p75.controllers[ClickToMoveController] = ClickToMoveController.new(Value);
    end;

    return p75.controllers[ClickToMoveController];
end;

return u1.new();