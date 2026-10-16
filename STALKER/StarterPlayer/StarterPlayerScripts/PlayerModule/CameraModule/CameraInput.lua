-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRService = game:GetService("VRService");
local GuiService = game:GetService("GuiService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local UserFlag = FlagUtil.getUserFlag("UserPSSinkUnknownTouchEvents");
local UserFlag2 = FlagUtil.getUserFlag("UserPSTextboxResetCameraInput");
local UserFlag3 = FlagUtil.getUserFlag("UserFixVRCameraGamepadReset");
local LocalPlayer = Players.LocalPlayer;
local Value = Enum.ContextActionPriority.Medium.Value;
local u1 = Vector2.new(1, 0.77) * 0.06981317007977318 * 60;
local u2 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u3 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u4 = Vector2.new(1, 0.66) * 0.017453292519943295;
local BindableEvent = Instance.new("BindableEvent");
local BindableEvent2 = Instance.new("BindableEvent");
local Event = BindableEvent.Event;
local Event2 = BindableEvent2.Event;
UserInputService.InputBegan:Connect(function(p5, p6) -- Line: 45
    -- upvalues: BindableEvent (copy)
    if not p6 and p5.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent:Fire();
    end;
end);
UserInputService.InputEnded:Connect(function(p7, p8) -- Line: 51
    -- upvalues: BindableEvent2 (copy)
    if p7.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent2:Fire();
    end;
end);

local function thumbstickCurve(p9) -- Line: 62
    local v10 = (math.abs(p9) - 0.1) / 0.9 * 2;
    local v11 = (math.exp(v10) - 1) / 6.38905609893065;

    return math.sign(p9) * math.clamp(v11, 0, 1);
end;

local function adjustTouchPitchSensitivity(p12) -- Line: 76
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return p12;
    end;

    local v13 = workspace_CurrentCamera.CFrame:ToEulerAnglesYXZ();

    if p12.Y * v13 >= 0 then
        return p12;
    end;

    local v14 = (1 - (math.abs(v13) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;

    return Vector2.new(1, v14) * p12;
end;

local function isInDynamicThumbstickArea(p15: vector) -- Line: 102
    -- upvalues: LocalPlayer (copy)
    local v16 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v16 then
        v16 = v16:FindFirstChild("TouchGui");
    end;

    local v17;

    if v16 then
        v17 = v16:FindFirstChild("TouchControlFrame");
    else
        v17 = v16;
    end;

    if v17 then
        v17 = v17:FindFirstChild("DynamicThumbstickFrame");
    end;

    if not v17 then
        return false;
    end;

    if not v16.Enabled then
        return false;
    end;

    local AbsolutePosition = v17.AbsolutePosition;
    local v18 = AbsolutePosition + v17.AbsoluteSize;
    local v19;

    if p15.X >= AbsolutePosition.X and (p15.Y >= AbsolutePosition.Y and p15.X <= v18.X) then
        v19 = p15.Y <= v18.Y;
    else
        v19 = false;
    end;

    return v19;
end;

local v20 = {};
local u21 = {};
local u22 = 0;

local function incPanInputCount() -- Line: 132
    -- upvalues: u22 (ref)
    u22 = math.max(0, u22 + 1);
end;

local function decPanInputCount() -- Line: 136
    -- upvalues: u22 (ref)
    u22 = math.max(0, u22 - 1);
end;

local function resetPanInputCount() -- Line: 140
    -- upvalues: u22 (ref)
    u22 = 0;
end;

local u23 = {
    Thumbstick2 = Vector2.new()
};
local u24 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u25 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u26 = {
    Pinch = 0,
    Move = Vector2.new()
};
local BindableEvent3 = Instance.new("BindableEvent");
v20.gamepadZoomPress = BindableEvent3.Event;
local u27;

if UserFlag3 then
    u27 = Instance.new("BindableEvent");
    v20.gamepadReset = u27.Event;
else
    u27 = VRService.VREnabled and Instance.new("BindableEvent") or nil;

    if VRService.VREnabled then
        v20.gamepadReset = u27.Event;
    end;
end;

function v20.getRotationActivated() -- Line: 179
    -- upvalues: u22 (ref), u23 (copy)
    return u22 > 0 and true or u23.Thumbstick2.Magnitude > 0;
end;

function v20.getRotation(p28: any, p29: boolean?) -- Line: 183
    -- upvalues: UserGameSettings (copy), u24 (copy), u23 (copy), LocalPlayer (copy), u25 (copy), adjustTouchPitchSensitivity (copy), u26 (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    local Vector2_new_ret = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
    local v30 = Vector2.new(u24.Right - u24.Left, 0) * p28;
    local v31 = u23.Thumbstick2 * UserGameSettings.GamepadCameraSensitivity * p28;
    local v32 = LocalPlayer and LocalPlayer:GetAttribute("CameraSensScale");
    local v33 = tonumber(v32) or 1;
    local v34 = u25.Movement * v33;
    local Pan = u25.Pan;
    local v35 = adjustTouchPitchSensitivity(u26.Move);

    if p29 then
        v30 = Vector2.new();
    end;

    return (v30 * 2.0943951023931953 + v31 * u1 + v34 * u2 + Pan * u3 + v35 * u4) * Vector2_new_ret;
end;

function v20.getZoomDelta() -- Line: 217
    -- upvalues: u24 (copy), u25 (copy), u26 (copy)
    return (u24.O - u24.I) * 0.1 + (-u25.Wheel + u25.Pinch) * 1 + -u26.Pinch * 0.04;
end;

local function thumbstick(p36, p37, p38) -- Line: 225
    -- upvalues: u23 (copy), thumbstickCurve (ref)
    local Position = p38.Position;
    u23[p38.KeyCode.Name] = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y));

    return Enum.ContextActionResult.Pass;
end;

local function mouseMovement(p39) -- Line: 231
    -- upvalues: u25 (copy)
    local Delta = p39.Delta;
    u25.Movement = Vector2.new(Delta.X, Delta.Y);
end;

local function mouseWheel(p40, p41, p42) -- Line: 236
    -- upvalues: u25 (copy)
    u25.Wheel = p42.Position.Z;

    return Enum.ContextActionResult.Pass;
end;

local function keypress(p43, p44, p45) -- Line: 241
    -- upvalues: u24 (copy)
    u24[p45.KeyCode.Name] = p44 == Enum.UserInputState.Begin and 1 or 0;
end;

local function gamepadZoomPress(p46, p47, p48) -- Line: 245
    -- upvalues: BindableEvent3 (copy)
    if p47 == Enum.UserInputState.Begin then
        BindableEvent3:Fire();
    end;
end;

local function gamepadReset(p49, p50, p51) -- Line: 251
    -- upvalues: u27 (ref)
    if p50 == Enum.UserInputState.Begin then
        u27:Fire();
    end;
end;

local function resetInputDevices() -- Line: 257
    -- upvalues: u23 (copy), u24 (copy), u25 (copy), u26 (copy), u22 (ref)
    for _, v in pairs({
        u23,
        u24,
        u25,
        u26
    }) do
        local v52 = v;

        for i, v2 in pairs(v) do
            if type(v2) == "boolean" then
                v52[i] = false;
            else
                v52[i] = v52[i] * 0;
            end;
        end;
    end;

    u22 = 0;
end;

local u53 = {};
local u54 = nil;
local u55 = nil;

local function touchBegan(p56: userdata, p57: boolean) -- Line: 283
    -- upvalues: u54 (ref), isInDynamicThumbstickArea (copy), u22 (ref), u53 (ref)
    assert(p56.UserInputType == Enum.UserInputType.Touch);
    assert(p56.UserInputState == Enum.UserInputState.Begin);

    if u54 == nil and (isInDynamicThumbstickArea(p56.Position) and not p57) then
        u54 = p56;

        return;
    end;

    if not p57 then
        u22 = math.max(0, u22 + 1);
    end;

    u53[p56] = p57;
end;

local function touchEnded(p58: userdata, p59: boolean) -- Line: 303
    -- upvalues: u54 (ref), u53 (ref), u55 (ref), u22 (ref)
    assert(p58.UserInputType == Enum.UserInputType.Touch);
    assert(p58.UserInputState == Enum.UserInputState.End);

    if p58 == u54 then
        u54 = nil;
    end;

    if u53[p58] == false then
        u55 = nil;
        u22 = math.max(0, u22 - 1);
    end;

    u53[p58] = nil;
end;

local function touchChanged(p60, p61) -- Line: 322
    -- upvalues: u54 (ref), u53 (ref), UserFlag (copy), u26 (copy), u55 (ref)
    assert(p60.UserInputType == Enum.UserInputType.Touch);
    assert(p60.UserInputState == Enum.UserInputState.Change);

    if p60 == u54 then
        return;
    end;

    if u53[p60] == nil then
        if UserFlag then
            u53[p60] = true;
        else
            u53[p60] = p61;
        end;
    end;

    local v62 = {};

    for i, v in pairs(u53) do
        if not v then
            table.insert(v62, i);
        end;
    end;

    if #v62 == 1 and u53[p60] == false then
        local Delta = p60.Delta;
        local v63 = u26;
        v63.Move = v63.Move + Vector2.new(Delta.X, Delta.Y);
    end;

    if #v62 ~= 2 then
        u55 = nil;

        return;
    end;

    local Magnitude = (v62[1].Position - v62[2].Position).Magnitude;

    if u55 then
        local v64 = u26;
        v64.Pinch = v64.Pinch + (Magnitude - u55);
    end;

    u55 = Magnitude;
end;

local function resetTouchState() -- Line: 370
    -- upvalues: u53 (ref), u54 (ref), u55 (ref), u22 (ref)
    u53 = {};
    u54 = nil;
    u55 = nil;
    u22 = 0;
end;

local function pointerAction(p65, p66, p67, p68) -- Line: 378
    -- upvalues: u25 (copy)
    if not p68 then
        u25.Wheel = p65;
        u25.Pan = p66;
        u25.Pinch = -p67;
    end;
end;

local function inputBegan(p69, p70) -- Line: 386
    -- upvalues: touchBegan (ref), u22 (ref)
    if p69.UserInputType == Enum.UserInputType.Touch then
        touchBegan(p69, p70);

        return;
    end;

    if p69.UserInputType == Enum.UserInputType.MouseButton2 and not p70 then
        u22 = math.max(0, u22 + 1);
    end;
end;

local function inputChanged(p71, p72) -- Line: 395
    -- upvalues: touchChanged (ref), u25 (copy)
    if p71.UserInputType == Enum.UserInputType.Touch then
        touchChanged(p71, p72);

        return;
    end;

    if p71.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = p71.Delta;
        u25.Movement = Vector2.new(Delta.X, Delta.Y);
    end;
end;

local function inputEnded(p73, p74) -- Line: 404
    -- upvalues: touchEnded (ref), u22 (ref)
    if p73.UserInputType == Enum.UserInputType.Touch then
        touchEnded(p73, p74);

        return;
    end;

    if p73.UserInputType == Enum.UserInputType.MouseButton2 then
        u22 = math.max(0, u22 - 1);
    end;
end;

local u75 = false;

function v20.setInputEnabled(p76) -- Line: 415
    -- upvalues: u75 (ref), resetInputDevices (copy), resetTouchState (ref), ContextActionService (copy), thumbstick (copy), Value (copy), keypress (copy), VRService (copy), gamepadReset (copy), gamepadZoomPress (copy), u21 (ref), UserInputService (copy), inputBegan (copy), inputChanged (copy), inputEnded (copy), pointerAction (copy), GuiService (copy)
    if u75 == p76 then
        return;
    end;

    u75 = p76;
    resetInputDevices();
    resetTouchState();

    if not u75 then
        ContextActionService:UnbindAction("RbxCameraThumbstick");
        ContextActionService:UnbindAction("RbxCameraMouseMove");
        ContextActionService:UnbindAction("RbxCameraMouseWheel");
        ContextActionService:UnbindAction("RbxCameraKeypress");
        ContextActionService:UnbindAction("RbxCameraGamepadZoom");

        if VRService.VREnabled then
            ContextActionService:UnbindAction("RbxCameraGamepadReset");
        end;

        for _, v in pairs(u21) do
            v:Disconnect();
        end;

        u21 = {};

        return;
    end;

    ContextActionService:BindActionAtPriority("RbxCameraThumbstick", thumbstick, false, Value, Enum.KeyCode.Thumbstick2);
    ContextActionService:BindActionAtPriority("RbxCameraKeypress", keypress, false, Value, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);

    if VRService.VREnabled then
        ContextActionService:BindAction("RbxCameraGamepadReset", gamepadReset, false, Enum.KeyCode.ButtonL3);
    end;

    ContextActionService:BindAction("RbxCameraGamepadZoom", gamepadZoomPress, false, Enum.KeyCode.ButtonR3);
    table.insert(u21, UserInputService.InputBegan:Connect(inputBegan));
    table.insert(u21, UserInputService.InputChanged:Connect(inputChanged));
    table.insert(u21, UserInputService.InputEnded:Connect(inputEnded));
    table.insert(u21, UserInputService.PointerAction:Connect(pointerAction));
    table.insert(u21, GuiService.MenuOpened:connect(resetTouchState));
end;

function v20.getInputEnabled() -- Line: 484
    -- upvalues: u75 (ref)
    return u75;
end;

function v20.resetInputForFrameEnd() -- Line: 488
    -- upvalues: u25 (copy), u26 (copy)
    u25.Movement = Vector2.new();
    u26.Move = Vector2.new();
    u26.Pinch = 0;
    u25.Wheel = 0;
    u25.Pan = Vector2.new();
    u25.Pinch = 0;
end;

UserInputService.WindowFocused:Connect(resetInputDevices);
UserInputService.WindowFocusReleased:Connect(resetInputDevices);

if UserFlag2 then
    UserInputService.TextBoxFocusReleased:Connect(resetInputDevices);
end;

local u77 = false;
local u78 = false;
local u79 = 0;

function v20.getHoldPan() -- Line: 512
    -- upvalues: u77 (ref)
    return u77;
end;

function v20.getTogglePan() -- Line: 516
    -- upvalues: u78 (ref)
    return u78;
end;

function v20.getPanning() -- Line: 520
    -- upvalues: u78 (ref), u77 (ref)
    return u78 or u77;
end;

function v20.setTogglePan(p80: boolean) -- Line: 524
    -- upvalues: u78 (ref)
    u78 = p80;
end;

local u81 = false;
local u82 = nil;
local u83 = nil;

function v20.enableCameraToggleInput() -- Line: 532
    -- upvalues: u81 (ref), u77 (ref), u78 (ref), u82 (ref), u83 (ref), Event (ref), u79 (ref), Event2 (ref), UserInputService (copy)
    if u81 then
        return;
    end;

    u81 = true;
    u77 = false;
    u78 = false;

    if u82 then
        u82:Disconnect();
    end;

    if u83 then
        u83:Disconnect();
    end;

    u82 = Event:Connect(function() -- Line: 549
        -- upvalues: u77 (ref), u79 (ref)
        u77 = true;
        u79 = tick();
    end);
    u83 = Event2:Connect(function() -- Line: 554
        -- upvalues: u77 (ref), u79 (ref), u78 (ref), UserInputService (ref)
        u77 = false;

        if tick() - u79 < 0.3 and (u78 or UserInputService:GetMouseDelta().Magnitude < 2) then
            u78 = not u78;
        end;
    end);
end;

function v20.disableCameraToggleInput() -- Line: 562
    -- upvalues: u81 (ref), u82 (ref), u83 (ref)
    if not u81 then
        return;
    end;

    u81 = false;

    if u82 then
        u82:Disconnect();
        u82 = nil;
    end;

    if u83 then
        u83:Disconnect();
        u83 = nil;
    end;
end;

return v20;