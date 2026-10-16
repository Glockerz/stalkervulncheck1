-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local GuiService = game:GetService("GuiService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
local CharacterUtil = require(CommonUtils:WaitForChild("CharacterUtil"));
local UserFlag = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserAllowAbilityControls");
local u1;

if UserFlag then
    u1 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
else
    u1 = nil;
end;

local u2 = { "rbxasset://textures/ui/Input/JumpButtonRegular.png", "rbxasset://textures/ui/Input/JumpButtonPressed.png" };
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u3 = setmetatable({}, BaseCharacterController);
u3.__index = u3;

function u3.new() -- Line: 61
    -- upvalues: BaseCharacterController (copy), u3 (copy), ConnectionUtil (copy)
    local v4 = BaseCharacterController.new();
    local v5 = setmetatable(v4, u3);
    v5.parentUIFrame = nil;
    v5.jumpButton = nil;
    v5.externallyEnabled = false;
    v5.isJumping = false;
    v5._active = false;
    v5._connectionUtil = ConnectionUtil.new();

    return v5;
end;

function u3._reset(p6) -- Line: 75
    -- upvalues: UserFlag (copy), u1 (ref), u2 (copy)
    p6.isJumping = false;
    p6.touchObject = nil;

    if p6.jumpButton then
        if UserFlag and u1.isEnabled() then
            p6.jumpButton.Image = u2[1];

            return;
        end;

        p6.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;
end;

function u3.EnableButton(u7, p8) -- Line: 90
    -- upvalues: GuiService (copy)
    if p8 == u7._active then
        return;
    end;

    if p8 then
        if not u7.jumpButton then
            u7:Create();
        end;

        u7.jumpButton.Visible = true;
        u7._connectionUtil:trackConnection("JUMP_INPUT_ENDED", u7.jumpButton.InputEnded:Connect(function(p9) -- Line: 105
            -- upvalues: u7 (copy)
            if p9 == u7.touchObject then
                u7:_reset();
            end;
        end));
        u7._connectionUtil:trackConnection("MENU_OPENED", GuiService.MenuOpened:Connect(function() -- Line: 115
            -- upvalues: u7 (copy)
            if u7.touchObject then
                u7:_reset();
            end;
        end));
    else
        if u7.jumpButton then
            u7.jumpButton.Visible = false;
        end;

        u7._connectionUtil:disconnect("JUMP_INPUT_ENDED");
        u7._connectionUtil:disconnect("MENU_OPENED");
    end;

    u7:_reset();
    u7._active = p8;
end;

function u3.UpdateEnabled(p10) -- Line: 132
    -- upvalues: CharacterUtil (copy)
    local Child = CharacterUtil.getChild("Humanoid", "Humanoid");

    if Child and p10.externallyEnabled and not ((not Child.UseJumpPower or Child.JumpPower <= 0) and (Child.UseJumpPower or Child.JumpHeight <= 0)) and Child:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
        p10:EnableButton(true);

        return;
    end;

    p10:EnableButton(false);
end;

function u3._setupConfigurations(u11) -- Line: 141
    -- upvalues: CharacterUtil (copy)
    local function update() -- Line: 142
        -- upvalues: u11 (copy)
        u11:UpdateEnabled();
    end;

    local v15 = CharacterUtil.onChild("Humanoid", "Humanoid", function(p12) -- Line: 147
        -- upvalues: u11 (copy), update (copy)
        u11:UpdateEnabled();
        u11:_reset();
        u11._connectionUtil:trackConnection("HUMANOID_JUMP_POWER", p12:GetPropertyChangedSignal("JumpPower"):Connect(update));
        u11._connectionUtil:trackConnection("HUMANOID_JUMP_HEIGHT", p12:GetPropertyChangedSignal("JumpHeight"):Connect(update));
        u11._connectionUtil:trackConnection("HUMANOID_STATE_ENABLED_CHANGED", p12.StateEnabledChanged:Connect(function(p13, p14) -- Line: 160
            -- upvalues: u11 (ref)
            if p13 == Enum.HumanoidStateType.Jumping and p14 ~= u11._active then
                u11:UpdateEnabled();
            end;
        end));
    end);
    u11._connectionUtil:trackConnection("HUMANOID", v15);
end;

function u3.Enable(p16, p17, p18) -- Line: 172
    if p18 then
        p16.parentUIFrame = p18;
    end;

    if p16.externallyEnabled == p17 then
        return;
    end;

    p16.externallyEnabled = p17;
    p16:UpdateEnabled();

    if p17 then
        p16:_setupConfigurations();

        return;
    end;

    p16._connectionUtil:disconnectAll();
end;

function u3.Create(u19) -- Line: 189
    -- upvalues: UserFlag (copy), u1 (ref), u2 (copy)
    if not u19.parentUIFrame then
        return;
    end;

    if u19.jumpButton then
        u19.jumpButton:Destroy();
        u19.jumpButton = nil;
    end;

    if u19.absoluteSizeChangedConn then
        u19.absoluteSizeChangedConn:Disconnect();
        u19.absoluteSizeChangedConn = nil;
    end;

    if UserFlag and u19.avatarAbilitiesEnabledChangedConn then
        u19.avatarAbilitiesEnabledChangedConn:Disconnect();
        u19.avatarAbilitiesEnabledChangedConn = nil;
    end;

    u19.jumpButton = Instance.new("ImageButton");
    u19.jumpButton.Name = "JumpButton";
    u19.jumpButton.Visible = false;
    u19.jumpButton.BackgroundTransparency = 1;

    if UserFlag and u1.isEnabled() then
        u19.jumpButton.Image = u2[1];
    else
        u19.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u19.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        u19.jumpButton.ImageRectSize = Vector2.new(144, 144);
    end;

    local function ResizeJumpButton() -- Line: 224
        -- upvalues: u19 (copy), UserFlag (ref), u1 (ref), u2 (ref)
        local v20 = math.min(u19.parentUIFrame.AbsoluteSize.x, u19.parentUIFrame.AbsoluteSize.y) <= 500;

        if not (UserFlag and u1.isEnabled()) then
            local v21 = v20 and 70 or 120;

            if UserFlag then
                u19.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
                u19.jumpButton.ImageRectOffset = Vector2.new(1, 146);
                u19.jumpButton.ImageRectSize = Vector2.new(144, 144);
            end;

            u19.jumpButton.Size = UDim2.new(0, v21, 0, v21);
            u19.jumpButton.Position = v20 and UDim2.new(1, -(v21 * 1.5 - 10), 1, -v21 - 20) or UDim2.new(1, -(v21 * 1.5 - 10), 1, -v21 * 1.75);

            return;
        end;

        local v22 = v20 and 72 or 120;
        u19.jumpButton.Image = u2[1];
        u19.jumpButton.ImageRectOffset = Vector2.new(0, 0);
        u19.jumpButton.ImageRectSize = Vector2.new(0, 0);
        u19.jumpButton.Size = UDim2.new(0, v22, 0, v22);
        u19.jumpButton.Position = UDim2.new(1, -v22 - (v20 and 64 or 100), 1, -v22 - (v20 and 64 or 112));
    end;

    ResizeJumpButton();
    u19.absoluteSizeChangedConn = u19.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeJumpButton);

    if UserFlag then
        u19.avatarAbilitiesEnabledChangedConn = u1.GetEnabledChangedSignal():Connect(ResizeJumpButton);
    end;

    u19.touchObject = nil;
    u19.jumpButton.InputBegan:connect(function(p23) -- Line: 262
        -- upvalues: u19 (copy), UserFlag (ref), u1 (ref), u2 (ref)
        if u19.touchObject or (p23.UserInputType ~= Enum.UserInputType.Touch or p23.UserInputState ~= Enum.UserInputState.Begin) then
            return;
        end;

        u19.touchObject = p23;

        if UserFlag and u1.isEnabled() then
            u19.jumpButton.Image = u2[2];
        else
            u19.jumpButton.ImageRectOffset = Vector2.new(146, 146);
        end;

        u19.isJumping = true;
    end);
    u19.jumpButton.Parent = u19.parentUIFrame;
end;

return u3;