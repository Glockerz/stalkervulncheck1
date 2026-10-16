-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
UserSettings():GetService("UserGameSettings");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local UserFlag = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserAllowAbilityControls");
local u1;

if UserFlag then
    u1 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
else
    u1 = nil;
end;

local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u2 = setmetatable({}, BaseCharacterController);
u2.__index = u2;

function u2.new() -- Line: 29
    -- upvalues: BaseCharacterController (copy), u2 (copy)
    local v3 = BaseCharacterController.new();
    local v4 = setmetatable(v3, u2);
    v4.isFollowStick = false;
    v4.thumbstickFrame = nil;
    v4.moveTouchObject = nil;
    v4.onTouchMovedConn = nil;
    v4.onTouchEndedConn = nil;
    v4.screenPos = nil;
    v4.stickImage = nil;
    v4.thumbstickSize = nil;

    return v4;
end;

function u2.Enable(p5: table, p6: boolean?, p7: any) -- Line: 44
    if p6 == nil then
        return false;
    end;

    local v8 = p6 and true or false;

    if p5.enabled == v8 then
        return true;
    end;

    p5.moveVector = Vector3.new(0, 0, 0);
    p5.isJumping = false;

    if v8 then
        if not p5.thumbstickFrame then
            p5:Create(p7);
        end;

        p5.thumbstickFrame.Visible = true;
    else
        p5.thumbstickFrame.Visible = false;
        p5:OnInputEnded();
    end;

    p5.enabled = v8;
end;

function u2.OnInputEnded(p9) -- Line: 65
    p9.thumbstickFrame.Position = p9.screenPos;
    p9.stickImage.Position = UDim2.new(0, p9.thumbstickFrame.Size.X.Offset / 2 - p9.thumbstickSize / 4, 0, p9.thumbstickFrame.Size.Y.Offset / 2 - p9.thumbstickSize / 4);
    p9.moveVector = Vector3.new(0, 0, 0);
    p9.isJumping = false;
    p9.thumbstickFrame.Position = p9.screenPos;
    p9.moveTouchObject = nil;
end;

function u2.Create(u10, u11) -- Line: 74
    -- upvalues: UserFlag (copy), u1 (ref), UserInputService (copy), GuiService (copy)
    if u10.thumbstickFrame then
        u10.thumbstickFrame:Destroy();
        u10.thumbstickFrame = nil;

        if u10.onTouchMovedConn then
            u10.onTouchMovedConn:Disconnect();
            u10.onTouchMovedConn = nil;
        end;

        if u10.onTouchEndedConn then
            u10.onTouchEndedConn:Disconnect();
            u10.onTouchEndedConn = nil;
        end;

        if u10.absoluteSizeChangedConn then
            u10.absoluteSizeChangedConn:Disconnect();
            u10.absoluteSizeChangedConn = nil;
        end;

        if UserFlag and u10.avatarAbilitiesEnabledChangedConn then
            u10.avatarAbilitiesEnabledChangedConn:Disconnect();
            u10.avatarAbilitiesEnabledChangedConn = nil;
        end;
    end;

    u10.thumbstickFrame = Instance.new("Frame");
    u10.thumbstickFrame.Name = "ThumbstickFrame";
    u10.thumbstickFrame.Active = true;
    u10.thumbstickFrame.Visible = false;
    u10.thumbstickFrame.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "OuterImage";
    ImageLabel.Image = "rbxasset://textures/ui/TouchControlsSheet.png";
    ImageLabel.ImageRectOffset = Vector2.new();
    ImageLabel.ImageRectSize = Vector2.new(220, 220);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Position = UDim2.new(0, 0, 0, 0);
    u10.stickImage = Instance.new("ImageLabel");
    u10.stickImage.Name = "StickImage";
    u10.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png";
    u10.stickImage.ImageRectOffset = Vector2.new(220, 0);
    u10.stickImage.ImageRectSize = Vector2.new(111, 111);
    u10.stickImage.BackgroundTransparency = 1;
    u10.stickImage.ZIndex = 2;

    local function ResizeThumbstick() -- Line: 120
        -- upvalues: u11 (copy), UserFlag (ref), u1 (ref), u10 (copy), ImageLabel (copy)
        local v12 = math.min(u11.AbsoluteSize.X, u11.AbsoluteSize.Y) <= 500;

        if UserFlag and u1.isEnabled() then
            u10.thumbstickSize = v12 and 72 or 120;
            u10.screenPos = UDim2.new(0, v12 and 64 or 100, 1, -u10.thumbstickSize - (v12 and 64 or 112));
        else
            u10.thumbstickSize = v12 and 70 or 120;
            u10.screenPos = v12 and UDim2.new(0, u10.thumbstickSize / 2 - 10, 1, -u10.thumbstickSize - 20) or UDim2.new(0, u10.thumbstickSize / 2, 1, -u10.thumbstickSize * 1.75);
        end;

        u10.thumbstickFrame.Size = UDim2.new(0, u10.thumbstickSize, 0, u10.thumbstickSize);
        u10.thumbstickFrame.Position = u10.screenPos;
        ImageLabel.Size = UDim2.new(0, u10.thumbstickSize, 0, u10.thumbstickSize);
        u10.stickImage.Size = UDim2.new(0, u10.thumbstickSize / 2, 0, u10.thumbstickSize / 2);
        u10.stickImage.Position = UDim2.new(0, u10.thumbstickSize / 2 - u10.thumbstickSize / 4, 0, u10.thumbstickSize / 2 - u10.thumbstickSize / 4);
    end;

    ResizeThumbstick();
    u10.absoluteSizeChangedConn = u11:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick);

    if UserFlag then
        u10.avatarAbilitiesEnabledChangedConn = u1.GetEnabledChangedSignal():Connect(ResizeThumbstick);
    end;

    ImageLabel.Parent = u10.thumbstickFrame;
    u10.stickImage.Parent = u10.thumbstickFrame;
    local u13 = nil;

    local function DoMove(p14) -- Line: 154
        -- upvalues: u10 (copy)
        local v15 = p14 / (u10.thumbstickSize / 2);
        local magnitude = v15.magnitude;
        local v16;

        if magnitude < 0.05 then
            v16 = Vector3.new();
        else
            local v17 = v15.unit * math.min(1, (magnitude - 0.05) / 0.95);
            v16 = Vector3.new(v17.X, 0, v17.Y);
        end;

        u10.moveVector = v16;
    end;

    local function MoveStick(p18: vector) -- Line: 172
        -- upvalues: u13 (ref), u10 (copy)
        local Vector2_new_ret = Vector2.new(p18.X - u13.X, p18.Y - u13.Y);
        local magnitude = Vector2_new_ret.magnitude;
        local v19 = u10.thumbstickFrame.AbsoluteSize.X / 2;

        if u10.isFollowStick and v19 < magnitude then
            local v20 = Vector2_new_ret.unit * v19;
            u10.thumbstickFrame.Position = UDim2.new(0, p18.X - u10.thumbstickFrame.AbsoluteSize.X / 2 - v20.X, 0, p18.Y - u10.thumbstickFrame.AbsoluteSize.Y / 2 - v20.Y);
        else
            local math_min_ret = math.min(magnitude, v19);
            Vector2_new_ret = Vector2_new_ret.unit * math_min_ret;
        end;

        u10.stickImage.Position = UDim2.new(0, Vector2_new_ret.X + u10.stickImage.AbsoluteSize.X / 2, 0, Vector2_new_ret.Y + u10.stickImage.AbsoluteSize.Y / 2);
    end;

    u10.thumbstickFrame.InputBegan:Connect(function(p21: userdata) -- Line: 189
        -- upvalues: u10 (copy), u13 (ref)
        if u10.moveTouchObject or (p21.UserInputType ~= Enum.UserInputType.Touch or p21.UserInputState ~= Enum.UserInputState.Begin) then
            return;
        end;

        u10.moveTouchObject = p21;
        u10.thumbstickFrame.Position = UDim2.new(0, p21.Position.X - u10.thumbstickFrame.Size.X.Offset / 2, 0, p21.Position.Y - u10.thumbstickFrame.Size.Y.Offset / 2);
        u13 = Vector2.new(u10.thumbstickFrame.AbsolutePosition.X + u10.thumbstickFrame.AbsoluteSize.X / 2, u10.thumbstickFrame.AbsolutePosition.Y + u10.thumbstickFrame.AbsoluteSize.Y / 2);
        Vector2.new(p21.Position.X - u13.X, p21.Position.Y - u13.Y);
    end);
    u10.onTouchMovedConn = UserInputService.TouchMoved:Connect(function(p22: userdata, p23: boolean) -- Line: 204
        -- upvalues: u10 (copy), u13 (ref), MoveStick (copy)
        if p22 == u10.moveTouchObject then
            u13 = Vector2.new(u10.thumbstickFrame.AbsolutePosition.X + u10.thumbstickFrame.AbsoluteSize.X / 2, u10.thumbstickFrame.AbsolutePosition.Y + u10.thumbstickFrame.AbsoluteSize.Y / 2);
            local v24 = Vector2.new(p22.Position.X - u13.X, p22.Position.Y - u13.Y) / (u10.thumbstickSize / 2);
            local magnitude = v24.magnitude;
            local v25;

            if magnitude < 0.05 then
                v25 = Vector3.new();
            else
                local v26 = v24.unit * math.min(1, (magnitude - 0.05) / 0.95);
                v25 = Vector3.new(v26.X, 0, v26.Y);
            end;

            u10.moveVector = v25;
            MoveStick(p22.Position);
        end;
    end);
    u10.onTouchEndedConn = UserInputService.TouchEnded:Connect(function(p27, p28) -- Line: 214
        -- upvalues: u10 (copy)
        if p27 == u10.moveTouchObject then
            u10:OnInputEnded();
        end;
    end);
    GuiService.MenuOpened:Connect(function() -- Line: 220
        -- upvalues: u10 (copy)
        if u10.moveTouchObject then
            u10:OnInputEnded();
        end;
    end);
    u10.thumbstickFrame.Parent = u11;
end;

return u2;