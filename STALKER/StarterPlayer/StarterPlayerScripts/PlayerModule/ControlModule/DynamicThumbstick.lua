-- Decompiled with Potassium's decompiler.

local Value = Enum.ContextActionPriority.High.Value;
local u1 = { 0.10999999999999999, 0.30000000000000004, 0.4, 0.5, 0.6, 0.7, 0.75 };
local u2 = #u1;
local TweenInfo_new_ret = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local UserFlag = FlagUtil.getUserFlag("UserAllowAbilityControls");
local UserFlag2 = FlagUtil.getUserFlag("UserAllowAbilityControlsBonus");
local success, result = pcall(function() -- Line: 42
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate");
end);
local u3 = success and result;
local u4;

if UserFlag then
    u4 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
else
    u4 = nil;
end;

local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
    LocalPlayer = Players.LocalPlayer;
end;

local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u5 = setmetatable({}, BaseCharacterController);
u5.__index = u5;

function u5.new() -- Line: 64
    -- upvalues: BaseCharacterController (copy), u5 (copy)
    local v6 = BaseCharacterController.new();
    local v7 = setmetatable(v6, u5);
    v7.moveTouchObject = nil;
    v7.moveTouchLockedIn = false;
    v7.moveTouchFirstChanged = false;
    v7.moveTouchStartPosition = nil;
    v7.startImage = nil;
    v7.endImage = nil;
    v7.middleImages = {};
    v7.startImageFadeTween = nil;
    v7.endImageFadeTween = nil;
    v7.middleImageFadeTweens = {};
    v7.isFirstTouch = true;
    v7.thumbstickFrame = nil;
    v7.onRenderSteppedConn = nil;
    v7.fadeInAndOutBalance = 0.5;
    v7.fadeInAndOutHalfDuration = 0.3;
    v7.hasFadedBackgroundInPortrait = false;
    v7.hasFadedBackgroundInLandscape = false;
    v7.tweenInAlphaStart = nil;
    v7.tweenOutAlphaStart = nil;

    return v7;
end;

function u5.GetIsJumping(p8) -- Line: 99
    local isJumping = p8.isJumping;
    p8.isJumping = false;

    return isJumping;
end;

function u5.Enable(p9: table, p10: boolean?, p11: any) -- Line: 105
    if p10 == nil then
        return false;
    end;

    local v12 = p10 and true or false;

    if p9.enabled == v12 then
        return true;
    end;

    if v12 then
        if not p9.thumbstickFrame then
            p9:Create(p11);
        end;

        p9:BindContextActions();
    else
        p9:UnbindContextActions();
        p9:OnInputEnded();
    end;

    p9.enabled = v12;
    p9.thumbstickFrame.Visible = v12;

    return nil;
end;

function u5.OnInputEnded(p13) -- Line: 130
    p13.moveTouchObject = nil;
    p13.moveVector = Vector3.new(0, 0, 0);
    p13:FadeThumbstick(false);
end;

function u5.FadeThumbstick(p14: table, p15: boolean?) -- Line: 136
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), u1 (copy)
    if not p15 and p14.moveTouchObject then
        return;
    end;

    if p14.isFirstTouch then
        return;
    end;

    if p14.startImageFadeTween then
        p14.startImageFadeTween:Cancel();
    end;

    if p14.endImageFadeTween then
        p14.endImageFadeTween:Cancel();
    end;

    for i = 1, #p14.middleImages do
        local v16;

        if p14.middleImageFadeTweens[i] then
            p14.middleImageFadeTweens[i]:Cancel();
            v16 = i;
        else
            v16 = i;
        end;
    end;

    if p15 then
        p14.startImageFadeTween = TweenService:Create(p14.startImage, TweenInfo_new_ret, {
            ImageTransparency = 0
        });
        p14.startImageFadeTween:Play();
        p14.endImageFadeTween = TweenService:Create(p14.endImage, TweenInfo_new_ret, {
            ImageTransparency = 0.2
        });
        p14.endImageFadeTween:Play();

        for i = 1, #p14.middleImages do
            p14.middleImageFadeTweens[i] = TweenService:Create(p14.middleImages[i], TweenInfo_new_ret, {
                ImageTransparency = u1[i]
            });
            p14.middleImageFadeTweens[i]:Play();
            local _ = i;
        end;

        return;
    end;

    p14.startImageFadeTween = TweenService:Create(p14.startImage, TweenInfo_new_ret, {
        ImageTransparency = 1
    });
    p14.startImageFadeTween:Play();
    p14.endImageFadeTween = TweenService:Create(p14.endImage, TweenInfo_new_ret, {
        ImageTransparency = 1
    });
    p14.endImageFadeTween:Play();

    for i = 1, #p14.middleImages do
        p14.middleImageFadeTweens[i] = TweenService:Create(p14.middleImages[i], TweenInfo_new_ret, {
            ImageTransparency = 1
        });
        p14.middleImageFadeTweens[i]:Play();
        local _ = i;
    end;
end;

function u5.FadeThumbstickFrame(p17: table, p18: number, p19: number) -- Line: 179
    p17.fadeInAndOutHalfDuration = p18 * 0.5;
    p17.fadeInAndOutBalance = p19;
    p17.tweenInAlphaStart = tick();
end;

function u5.InputInFrame(p20: table, p21: userdata) -- Line: 185
    local AbsolutePosition = p20.thumbstickFrame.AbsolutePosition;
    local v22 = AbsolutePosition + p20.thumbstickFrame.AbsoluteSize;
    local Position = p21.Position;

    return Position.X >= AbsolutePosition.X and (Position.Y >= AbsolutePosition.Y and (Position.X <= v22.X and Position.Y <= v22.Y));
end;

function u5.DoFadeInBackground(p23) -- Line: 197
    -- upvalues: LocalPlayer (ref)
    local v24 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v25 = false;

    if v24 then
        if v24.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v24.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v25 = p23.hasFadedBackgroundInLandscape;
            p23.hasFadedBackgroundInLandscape = true;
        elseif v24.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v25 = p23.hasFadedBackgroundInPortrait;
            p23.hasFadedBackgroundInPortrait = true;
        end;
    end;

    if not v25 then
        p23.fadeInAndOutHalfDuration = 0.3;
        p23.fadeInAndOutBalance = 0.5;
        p23.tweenInAlphaStart = tick();
    end;
end;

function u5.DoMove(p26: table, p27: vector) -- Line: 220
    local v28;

    if p27.Magnitude < p26.radiusOfDeadZone then
        v28 = Vector3.new(0, 0, 0);
    else
        local v29 = p27.Unit * (1 - math.max(0, (p26.radiusOfMaxSpeed - p27.Magnitude) / p26.radiusOfMaxSpeed));
        v28 = Vector3.new(v29.X, 0, v29.Y);
    end;

    p26.moveVector = v28;
end;

function u5.LayoutMiddleImages(p30: table, p31: vector, p32: vector) -- Line: 238
    -- upvalues: u2 (copy)
    local v33 = p30.thumbstickSize / 2 + p30.middleSize;
    local v34 = p32 - p31;
    local v35 = v34.Magnitude - p30.thumbstickRingSize / 2 - p30.middleSize;
    local Unit = v34.Unit;
    local middleSpacing = p30.middleSpacing;

    if p30.middleSpacing * u2 < v35 then
        middleSpacing = v35 / u2;
    end;

    for i = 1, u2 do
        local v36 = p30.middleImages[i];
        local v37 = v33 + middleSpacing * (i - 1);
        local v38;

        if v33 + middleSpacing * (i - 2) < v35 then
            local v39 = p32 - Unit * v37;
            local math_clamp_ret = math.clamp(1 - (v37 - v35) / middleSpacing, 0, 1);
            v36.Visible = true;
            v36.Position = UDim2.new(0, v39.X, 0, v39.Y);
            v36.Size = UDim2.new(0, p30.middleSize * math_clamp_ret, 0, p30.middleSize * math_clamp_ret);
            v38 = i;
        else
            v36.Visible = false;
            v38 = i;
        end;
    end;
end;

function u5.MoveStick(p40, p41) -- Line: 269
    local v42 = Vector2.new(p40.moveTouchStartPosition.X, p40.moveTouchStartPosition.Y) - p40.thumbstickFrame.AbsolutePosition;
    local v43 = Vector2.new(p41.X, p41.Y) - p40.thumbstickFrame.AbsolutePosition;
    p40.endImage.Position = UDim2.new(0, v43.X, 0, v43.Y);
    p40:LayoutMiddleImages(v42, v43);
end;

function u5.BindContextActions(u44) -- Line: 277
    -- upvalues: TweenService (copy), ContextActionService (copy), Value (copy), UserInputService (copy)
    local function inputBegan(p45) -- Line: 278
        -- upvalues: u44 (copy), TweenService (ref)
        if u44.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;

        if not u44:InputInFrame(p45) then
            return Enum.ContextActionResult.Pass;
        end;

        if u44.isFirstTouch then
            u44.isFirstTouch = false;
            local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
            TweenService:Create(u44.startImage, TweenInfo_new_ret2, {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play();
            TweenService:Create(u44.endImage, TweenInfo_new_ret2, {
                Size = UDim2.new(0, u44.thumbstickSize, 0, u44.thumbstickSize),
                ImageColor3 = Color3.new(0, 0, 0)
            }):Play();
        end;

        u44.moveTouchLockedIn = false;
        u44.moveTouchObject = p45;
        u44.moveTouchStartPosition = p45.Position;
        u44.moveTouchFirstChanged = true;
        u44:DoFadeInBackground();

        return Enum.ContextActionResult.Pass;
    end;

    local function inputChanged(p46: userdata) -- Line: 310
        -- upvalues: u44 (copy)
        if p46 ~= u44.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;

        if u44.moveTouchFirstChanged then
            u44.moveTouchFirstChanged = false;
            local Vector2_new_ret = Vector2.new(p46.Position.X - u44.thumbstickFrame.AbsolutePosition.X, p46.Position.Y - u44.thumbstickFrame.AbsolutePosition.Y);
            u44.startImage.Visible = true;
            u44.startImage.Position = UDim2.new(0, Vector2_new_ret.X, 0, Vector2_new_ret.Y);
            u44.endImage.Visible = true;
            u44.endImage.Position = u44.startImage.Position;
            u44:FadeThumbstick(true);
            u44:MoveStick(p46.Position);
        end;

        u44.moveTouchLockedIn = true;
        local Vector2_new_ret = Vector2.new(p46.Position.X - u44.moveTouchStartPosition.X, p46.Position.Y - u44.moveTouchStartPosition.Y);

        if math.abs(Vector2_new_ret.X) > 0 or math.abs(Vector2_new_ret.Y) > 0 then
            u44:DoMove(Vector2_new_ret);
            u44:MoveStick(p46.Position);
        end;

        return Enum.ContextActionResult.Sink;
    end;

    local function inputEnded(p47) -- Line: 343
        -- upvalues: u44 (copy)
        if p47 == u44.moveTouchObject then
            u44:OnInputEnded();

            if u44.moveTouchLockedIn then
                return Enum.ContextActionResult.Sink;
            end;
        end;

        return Enum.ContextActionResult.Pass;
    end;

    ContextActionService:BindActionAtPriority("DynamicThumbstickAction", function(p48, p49, p50) -- Line: 353, Name: handleInput
        -- upvalues: inputBegan (copy), u44 (copy)
        if p49 == Enum.UserInputState.Begin then
            return inputBegan(p50);
        end;

        if p49 == Enum.UserInputState.Change then
            if p50 == u44.moveTouchObject then
                return Enum.ContextActionResult.Sink;
            end;

            return Enum.ContextActionResult.Pass;
        end;

        if p49 == Enum.UserInputState.End then
            if p50 == u44.moveTouchObject then
                u44:OnInputEnded();

                if u44.moveTouchLockedIn then
                    return Enum.ContextActionResult.Sink;
                end;
            end;

            return Enum.ContextActionResult.Pass;
        end;

        if p49 == Enum.UserInputState.Cancel then
            u44:OnInputEnded();
        end;
    end, false, Value, Enum.UserInputType.Touch);
    u44.TouchMovedCon = UserInputService.TouchMoved:Connect(function(p51: userdata, p52: boolean) -- Line: 376
        -- upvalues: inputChanged (copy)
        inputChanged(p51);
    end);
end;

function u5.UnbindContextActions(p53) -- Line: 381
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("DynamicThumbstickAction");

    if p53.TouchMovedCon then
        p53.TouchMovedCon:Disconnect();
    end;
end;

function u5.Create(u54: table, u55: userdata) -- Line: 389
    -- upvalues: UserFlag (copy), u3 (ref), u2 (copy), u1 (copy), UserFlag2 (copy), u4 (ref), RunService (copy), UserInputService (copy), GuiService (copy), LocalPlayer (ref)
    if u54.thumbstickFrame then
        u54.thumbstickFrame:Destroy();
        u54.thumbstickFrame = nil;

        if u54.onRenderSteppedConn then
            u54.onRenderSteppedConn:Disconnect();
            u54.onRenderSteppedConn = nil;
        end;

        if u54.absoluteSizeChangedConn then
            u54.absoluteSizeChangedConn:Disconnect();
            u54.absoluteSizeChangedConn = nil;
        end;

        if UserFlag and u54.avatarAbilitiesEnabledChangedConn then
            u54.avatarAbilitiesEnabledChangedConn:Disconnect();
            u54.avatarAbilitiesEnabledChangedConn = nil;
        end;
    end;

    local u56 = u3 and 100 or 0;
    u54.thumbstickFrame = Instance.new("Frame");
    u54.thumbstickFrame.BorderSizePixel = 0;
    u54.thumbstickFrame.Name = "DynamicThumbstickFrame";
    u54.thumbstickFrame.Visible = false;
    u54.thumbstickFrame.BackgroundTransparency = 1;
    u54.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    u54.thumbstickFrame.Active = false;
    u54.thumbstickFrame.Size = UDim2.new(0.4, u56, 0.6666666666666666, u56);
    u54.thumbstickFrame.Position = UDim2.new(0, -u56, 0.3333333333333333, 0);
    u54.startImage = Instance.new("ImageLabel");
    u54.startImage.Name = "ThumbstickStart";
    u54.startImage.Visible = true;
    u54.startImage.BackgroundTransparency = 1;
    u54.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u54.startImage.ImageRectOffset = Vector2.new(1, 1);
    u54.startImage.ImageRectSize = Vector2.new(144, 144);
    u54.startImage.ImageColor3 = Color3.new(0, 0, 0);
    u54.startImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u54.startImage.ZIndex = 10;
    u54.startImage.Parent = u54.thumbstickFrame;
    u54.endImage = Instance.new("ImageLabel");
    u54.endImage.Name = "ThumbstickEnd";
    u54.endImage.Visible = true;
    u54.endImage.BackgroundTransparency = 1;
    u54.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u54.endImage.ImageRectOffset = Vector2.new(1, 1);
    u54.endImage.ImageRectSize = Vector2.new(144, 144);
    u54.endImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u54.endImage.ZIndex = 10;
    u54.endImage.Parent = u54.thumbstickFrame;

    local function layoutThumbstickFrame(p57: boolean) -- Line: 410
        -- upvalues: u54 (copy), u56 (copy)
        if p57 then
            u54.thumbstickFrame.Size = UDim2.new(1, u56, 0.4, u56);
            u54.thumbstickFrame.Position = UDim2.new(0, -u56, 0.6, 0);

            return;
        end;

        u54.thumbstickFrame.Size = UDim2.new(0.4, u56, 0.6666666666666666, u56);
        u54.thumbstickFrame.Position = UDim2.new(0, -u56, 0.3333333333333333, 0);
    end;

    for i = 1, u2 do
        u54.middleImages[i] = Instance.new("ImageLabel");
        u54.middleImages[i].Name = "ThumbstickMiddle";
        u54.middleImages[i].Visible = false;
        u54.middleImages[i].BackgroundTransparency = 1;
        u54.middleImages[i].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u54.middleImages[i].ImageRectOffset = Vector2.new(1, 1);
        u54.middleImages[i].ImageRectSize = Vector2.new(144, 144);
        u54.middleImages[i].ImageTransparency = u1[i];
        u54.middleImages[i].AnchorPoint = Vector2.new(0.5, 0.5);
        u54.middleImages[i].ZIndex = 9;
        u54.middleImages[i].Parent = u54.thumbstickFrame;
        local _ = i;
    end;

    local function ResizeThumbstick() -- Line: 466
        -- upvalues: u55 (copy), UserFlag (ref), UserFlag2 (ref), u4 (ref), u54 (copy), u56 (copy)
        local AbsoluteSize = u55.AbsoluteSize;
        local v58 = math.min(AbsoluteSize.X, AbsoluteSize.Y) > 500;

        if UserFlag then
            local v59 = UserFlag2 and (u4.isEnabled() and v58) and 1.6216216216216217 or (v58 and 2 or 1);
            u54.thumbstickSize = 45 * v59;
            u54.thumbstickRingSize = 20 * v59;
            u54.middleSize = 10 * v59;
            u54.middleSpacing = 14 * v59;
            u54.radiusOfDeadZone = 2 * v59;
            u54.radiusOfMaxSpeed = 20 * v59;
            local v60 = 74 * v59;

            if u4.isEnabled() then
                u54.startImage.Position = UDim2.new(0, v60 * 0.5 + u56 + (v58 and 100 or 64), 1, -v60 * 0.5 - u56 - (v58 and 112 or 64));
                u54.startImage.Size = UDim2.new(0, v60, 0, v60);
            else
                u54.startImage.Position = UDim2.new(0, u54.thumbstickRingSize * 3.3 + u56, 1, -u54.thumbstickRingSize * 2.8 - u56);
                u54.startImage.Size = UDim2.new(0, v60, 0, v60);
            end;
        else
            if v58 then
                u54.thumbstickSize = 90;
                u54.thumbstickRingSize = 40;
                u54.middleSize = 20;
                u54.middleSpacing = 28;
                u54.radiusOfDeadZone = 4;
                u54.radiusOfMaxSpeed = 40;
            else
                u54.thumbstickSize = 45;
                u54.thumbstickRingSize = 20;
                u54.middleSize = 10;
                u54.middleSpacing = 14;
                u54.radiusOfDeadZone = 2;
                u54.radiusOfMaxSpeed = 20;
            end;

            u54.startImage.Position = UDim2.new(0, u54.thumbstickRingSize * 3.3 + u56, 1, -u54.thumbstickRingSize * 2.8 - u56);
            u54.startImage.Size = UDim2.new(0, u54.thumbstickRingSize * 3.7, 0, u54.thumbstickRingSize * 3.7);
        end;

        u54.endImage.Position = u54.startImage.Position;
        u54.endImage.Size = UDim2.new(0, u54.thumbstickSize * 0.8, 0, u54.thumbstickSize * 0.8);
    end;

    ResizeThumbstick();
    u54.absoluteSizeChangedConn = u55:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick);

    if UserFlag then
        u54.avatarAbilitiesEnabledChangedConn = u4.GetEnabledChangedSignal():Connect(ResizeThumbstick);
    end;

    local u61 = nil;

    local function onCurrentCameraChanged() -- Line: 534
        -- upvalues: u61 (ref), layoutThumbstickFrame (copy)
        if u61 then
            u61:Disconnect();
            u61 = nil;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            local function onViewportSizeChanged() -- Line: 541
                -- upvalues: workspace_CurrentCamera (copy), layoutThumbstickFrame (ref)
                local ViewportSize = workspace_CurrentCamera.ViewportSize;
                layoutThumbstickFrame(ViewportSize.X < ViewportSize.Y);
            end;

            u61 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportSizeChanged);
            local ViewportSize = workspace_CurrentCamera.ViewportSize;
            layoutThumbstickFrame(ViewportSize.X < ViewportSize.Y);
        end;
    end;

    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged);

    if workspace.CurrentCamera then
        onCurrentCameraChanged();
    end;

    u54.moveTouchStartPosition = nil;
    u54.startImageFadeTween = nil;
    u54.endImageFadeTween = nil;
    u54.middleImageFadeTweens = {};
    u54.onRenderSteppedConn = RunService.RenderStepped:Connect(function() -- Line: 561
        -- upvalues: u54 (copy)
        if u54.tweenInAlphaStart == nil then
            if u54.tweenOutAlphaStart ~= nil then
                local v62 = tick() - u54.tweenOutAlphaStart;
                local v63 = u54.fadeInAndOutHalfDuration * 2 - u54.fadeInAndOutHalfDuration * 2 * u54.fadeInAndOutBalance;
                u54.thumbstickFrame.BackgroundTransparency = math.min(v62 / v63, 1) * 0.35 + 0.65;

                if v63 < v62 then
                    u54.tweenOutAlphaStart = nil;
                end;
            end;
        else
            local v64 = tick() - u54.tweenInAlphaStart;
            local v65 = u54.fadeInAndOutHalfDuration * 2 * u54.fadeInAndOutBalance;
            u54.thumbstickFrame.BackgroundTransparency = 1 - math.min(v64 / v65, 1) * 0.35;

            if v65 < v64 then
                u54.tweenOutAlphaStart = tick();
                u54.tweenInAlphaStart = nil;
            end;
        end;
    end);
    u54.onTouchEndedConn = UserInputService.TouchEnded:connect(function(p66: userdata) -- Line: 580
        -- upvalues: u54 (copy)
        if p66 == u54.moveTouchObject then
            u54:OnInputEnded();
        end;
    end);
    GuiService.MenuOpened:connect(function() -- Line: 586
        -- upvalues: u54 (copy)
        if u54.moveTouchObject then
            u54:OnInputEnded();
        end;
    end);
    local u67 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    while not u67 do
        LocalPlayer.ChildAdded:wait();
        u67 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    end;

    local u68 = nil;
    local u69 = u67.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or u67.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight;

    local function longShowBackground() -- Line: 602
        -- upvalues: u54 (copy)
        u54.fadeInAndOutHalfDuration = 2.5;
        u54.fadeInAndOutBalance = 0.05;
        u54.tweenInAlphaStart = tick();
    end;

    u68 = u67:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function() -- Line: 608
        -- upvalues: u69 (copy), u67 (ref), u68 (ref), u54 (copy)
        if not ((not u69 or u67.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait) and (u69 or u67.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait)) then
            u68:disconnect();
            u54.fadeInAndOutHalfDuration = 2.5;
            u54.fadeInAndOutBalance = 0.05;
            u54.tweenInAlphaStart = tick();

            if u69 then
                u54.hasFadedBackgroundInPortrait = true;

                return;
            end;

            u54.hasFadedBackgroundInLandscape = true;
        end;
    end);
    u54.thumbstickFrame.Parent = u55;

    if game:IsLoaded() then
        u54.fadeInAndOutHalfDuration = 2.5;
        u54.fadeInAndOutBalance = 0.05;
        u54.tweenInAlphaStart = tick();
    else
        coroutine.wrap(function() -- Line: 628
            -- upvalues: u54 (copy)
            game.Loaded:Wait();
            u54.fadeInAndOutHalfDuration = 2.5;
            u54.fadeInAndOutBalance = 0.05;
            u54.tweenInAlphaStart = tick();
        end)();
    end;
end;

return u5;