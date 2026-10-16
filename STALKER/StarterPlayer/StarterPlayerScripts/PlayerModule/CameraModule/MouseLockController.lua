-- Decompiled with Potassium's decompiler.

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local Value = Enum.ContextActionPriority.Medium.Value;
local Players = game:GetService("Players");
local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local GameSettings = UserSettings().GameSettings;
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local UserFlag = FlagUtil.getUserFlag("UserFixStuckShiftLock");
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 33
    -- upvalues: u1 (copy), GameSettings (copy), Players (copy), UserInputService (copy)
    local u2 = setmetatable({}, u1);
    u2.isMouseLocked = false;
    u2.savedMouseCursor = nil;
    u2.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift };
    u2.mouseLockToggledEvent = Instance.new("BindableEvent");
    local BoundKeys = script:FindFirstChild("BoundKeys");

    if not (BoundKeys and BoundKeys:IsA("StringValue")) then
        if BoundKeys then
            BoundKeys:Destroy();
        end;

        BoundKeys = Instance.new("StringValue");
        assert(BoundKeys, "");
        BoundKeys.Name = "BoundKeys";
        BoundKeys.Value = "LeftShift,RightShift";
        BoundKeys.Parent = script;
    end;

    if BoundKeys then
        BoundKeys.Changed:Connect(function(p3) -- Line: 58
            -- upvalues: u2 (copy)
            u2:OnBoundKeysObjectChanged(p3);
        end);
        u2:OnBoundKeysObjectChanged(BoundKeys.Value);
    end;

    GameSettings.Changed:Connect(function(p4) -- Line: 65
        -- upvalues: u2 (copy)
        if p4 == "ControlMode" or p4 == "ComputerMovementMode" then
            u2:UpdateMouseLockAvailability();
        end;
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function() -- Line: 72
        -- upvalues: u2 (copy)
        u2:UpdateMouseLockAvailability();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- Line: 77
        -- upvalues: u2 (copy)
        u2:UpdateMouseLockAvailability();
    end);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 81
        -- upvalues: u2 (copy)
        u2:UpdateMouseLockAvailability();
    end);
    u2:UpdateMouseLockAvailability();

    return u2;
end;

function u1.GetIsMouseLocked(p5) -- Line: 90
    return p5.isMouseLocked;
end;

function u1.GetBindableToggleEvent(p6) -- Line: 94
    return p6.mouseLockToggledEvent.Event;
end;

function u1.GetMouseLockOffset(p7) -- Line: 98
    return Vector3.new(1.75, 0, 0);
end;

function u1.UpdateMouseLockAvailability(p8) -- Line: 102
    -- upvalues: Players (copy), GameSettings (copy), UserInputService (copy)
    local v9 = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and (Players.LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove)) and not (Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable);

    if v9 ~= p8.enabled then
        p8:EnableMouseLock(v9);
    end;
end;

function u1.OnBoundKeysObjectChanged(p10: table, p11: string) -- Line: 115
    p10.boundKeys = {};

    for i in string.gmatch(p11, "[^%s,]+") do
        local v12 = i;

        for _, v in pairs(Enum.KeyCode:GetEnumItems()) do
            if v12 == v.Name then
                p10.boundKeys[#p10.boundKeys + 1] = v;
                break;
            end;
        end;
    end;

    p10:UnbindContextActions();
    p10:BindContextActions();
end;

function u1.OnMouseLockToggled(p13) -- Line: 130
    -- upvalues: CameraUtils (copy)
    p13.isMouseLocked = not p13.isMouseLocked;

    if p13.isMouseLocked then
        local CursorImage = script:FindFirstChild("CursorImage");

        if CursorImage and (CursorImage:IsA("StringValue") and CursorImage.Value) then
            CameraUtils.setMouseIconOverride(CursorImage.Value);
        else
            if CursorImage then
                CursorImage:Destroy();
            end;

            local StringValue = Instance.new("StringValue");
            assert(StringValue, "");
            StringValue.Name = "CursorImage";
            StringValue.Value = "rbxasset://textures/MouseLockedCursor.png";
            StringValue.Parent = script;
            CameraUtils.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png");
        end;
    else
        CameraUtils.restoreMouseIcon();
    end;

    p13.mouseLockToggledEvent:Fire();
end;

function u1.DoMouseLockSwitch(p14, p15, p16, p17) -- Line: 155
    if p16 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;

    p14:OnMouseLockToggled();

    return Enum.ContextActionResult.Sink;
end;

function u1.BindContextActions(u18) -- Line: 163
    -- upvalues: ContextActionService (copy), Value (copy)
    ContextActionService:BindActionAtPriority("MouseLockSwitchAction", function(p19, p20, p21) -- Line: 164
        -- upvalues: u18 (copy)
        return u18:DoMouseLockSwitch(p19, p20, p21);
    end, false, Value, unpack(u18.boundKeys));
end;

function u1.UnbindContextActions(p22) -- Line: 169
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("MouseLockSwitchAction");
end;

function u1.IsMouseLocked(p23) -- Line: 173
    return p23.enabled and p23.isMouseLocked;
end;

function u1.EnableMouseLock(p24: table, p25: boolean) -- Line: 177
    -- upvalues: CameraUtils (copy), UserFlag (copy)
    if p25 ~= p24.enabled then
        p24.enabled = p25;

        if p24.enabled then
            p24:BindContextActions();

            return;
        end;

        CameraUtils.restoreMouseIcon();
        p24:UnbindContextActions();

        if UserFlag then
            if p24.isMouseLocked then
                p24.isMouseLocked = false;
                p24.mouseLockToggledEvent:Fire();
            end;
        else
            if p24.isMouseLocked then
                p24.mouseLockToggledEvent:Fire();
            end;

            p24.isMouseLocked = false;
        end;
    end;
end;

return u1;