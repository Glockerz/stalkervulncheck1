-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EmoteConfig = require(ReplicatedStorage:WaitForChild("EmoteConfig"));
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(28, 30, 32);
local Color3_fromRGB_ret2 = Color3.fromRGB(70, 150, 185);
local v1 = {
    _started = false,
    _open = false,
    _emotes = {},
    _wedges = {},
    _selection = nil,
    _tracks = {},
    _emoteConns = {}
};

local function wedgeAngle(p2) -- Line: 39
    return 360 / math.max(p2, 1);
end;

local function angleForIndex(p3, p4) -- Line: 43
    return (p3 - 1) * (360 / math.max(p4, 1));
end;

local function indexForAngle(p5, p6) -- Line: 47
    local v7 = 360 / math.max(p6, 1);

    return math.floor((p5 + v7 / 2) % 360 / v7) + 1;
end;

local function validateEmotes(p8) -- Line: 54
    -- upvalues: EmoteConfig (copy)
    local v9 = {};

    for i, v in ipairs(p8 or {}) do
        if (type(v) ~= "table" or (type(v.name) ~= "string" or (v.name == "" or type(v.animId) ~= "string"))) and true or not v.animId:match("^rbxassetid://%d+$") then
            warn(("[EmoteWheel] skipping entry %d: missing or malformed name/animId"):format(i));
        elseif #v9 >= EmoteConfig.MaxEmotes then
            warn(("[EmoteWheel] skipping entry %d (%s): over MaxEmotes (%d)"):format(i, tostring(v.name), EmoteConfig.MaxEmotes));
        else
            v9[#v9 + 1] = v;
        end;
    end;

    return v9;
end;

function v1._buildGui(p10) -- Line: 75
    -- upvalues: LocalPlayer (copy), EmoteConfig (copy), Color3_fromRGB_ret (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local v11 = PlayerGui:FindFirstChild(EmoteConfig.GuiName);

    if v11 then
        v11:Destroy();
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = EmoteConfig.GuiName;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 30;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.Enabled = false;
    local Frame = Instance.new("Frame");
    Frame.Name = "Dimmer";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BackgroundTransparency = 0.65;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 1;
    Frame.Parent = ScreenGui;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Wheel";
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.Position = UDim2.fromScale(0.5, 0.5);
    Frame2.Size = UDim2.fromScale(EmoteConfig.WheelScale, EmoteConfig.WheelScale);
    Frame2.BackgroundTransparency = 1;
    Frame2.ZIndex = 2;
    Frame2.Parent = ScreenGui;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = 1;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height;
    UIAspectRatioConstraint.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Centre";
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.5);
    TextLabel.Size = UDim2.fromScale(EmoteConfig.DeadZoneScale, 0.14);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.GothamMedium;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200);
    TextLabel.Text = "Cancel";
    TextLabel.ZIndex = 5;
    TextLabel.Parent = Frame2;
    local v12 = #p10._emotes;

    for i, v in ipairs(p10._emotes) do
        local v13 = (i - 1) * (360 / math.max(v12, 1));
        local math_rad_ret = math.rad(v13);
        local v14 = 0.5 * EmoteConfig.ButtonRadius;
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "Wedge_" .. i;
        Frame3.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame3.Position = UDim2.fromScale(0.5 + v14 * math.sin(math_rad_ret), 0.5 - v14 * math.cos(math_rad_ret));
        Frame3.Size = UDim2.fromScale(0.26, 0.26);
        Frame3.BackgroundColor3 = Color3_fromRGB_ret;
        Frame3.BackgroundTransparency = 0.2;
        Frame3.BorderSizePixel = 0;
        Frame3.ZIndex = 3;
        Frame3.Parent = Frame2;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0.5, 0);
        UICorner.Parent = Frame3;
        local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint2.AspectRatio = 1;
        UIAspectRatioConstraint2.Parent = Frame3;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(90, 90, 90);
        UIStroke.Thickness = 2;
        UIStroke.Parent = Frame3;

        if v.icon then
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Icon";
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel.Size = UDim2.fromScale(0.6, 0.6);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Image = v.icon;
            ImageLabel.ZIndex = 4;
            ImageLabel.Parent = Frame3;
        else
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Label";
            TextLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
            TextLabel2.Position = UDim2.fromScale(0.5, 0.5);
            TextLabel2.Size = UDim2.fromScale(0.82, 0.34);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.Font = Enum.Font.GothamMedium;
            TextLabel2.TextScaled = true;
            TextLabel2.TextColor3 = Color3.fromRGB(235, 235, 235);
            TextLabel2.Text = v.name;
            TextLabel2.ZIndex = 4;
            TextLabel2.Parent = Frame3;
        end;

        p10._wedges[i] = {
            frame = Frame3,
            stroke = UIStroke
        };
    end;

    ScreenGui.Parent = PlayerGui;
    p10._gui = ScreenGui;
    p10._wheel = Frame2;
    p10._centre = TextLabel;
end;

function v1._paintSelection(p15) -- Line: 196
    -- upvalues: Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    for i, v in ipairs(p15._wedges) do
        local v16 = i == p15._selection;
        v.frame.BackgroundColor3 = v16 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;
        v.frame.BackgroundTransparency = v16 and 0.05 or 0.2;
        v.stroke.Color = v16 and Color3.fromRGB(150, 220, 245) or Color3.fromRGB(90, 90, 90);
        v.stroke.Thickness = v16 and 3 or 2;
    end;

    local v17 = p15._selection and p15._emotes[p15._selection];
    p15._centre.Text = v17 and v17.name or "Cancel";
end;

function v1._updateSelection(p18) -- Line: 210
    -- upvalues: GuiService (copy), UserInputService (copy), EmoteConfig (copy)
    local _wheel = p18._wheel;
    local v19 = #p18._emotes;

    if not _wheel or v19 == 0 then
        return;
    end;

    local GuiInset = GuiService:GetGuiInset();
    local v20 = UserInputService:GetMouseLocation() + GuiInset;
    local v21 = v20 - (_wheel.AbsolutePosition + _wheel.AbsoluteSize / 2);
    local v22;

    if v21.Magnitude >= _wheel.AbsoluteSize.Y / 2 * EmoteConfig.DeadZoneScale then
        local math_atan2_ret = math.atan2(v21.X, -v21.Y);
        local v23 = math.deg(math_atan2_ret) % 360;
        local v24 = 360 / math.max(v19, 1);
        v22 = math.floor((v23 + v24 / 2) % 360 / v24) + 1;
    else
        v22 = nil;
    end;

    if v22 == p18._selection then
        return;
    end;

    p18._selection = v22;
    p18:_paintSelection();
end;

function v1._grabCursor(p25) -- Line: 245
    -- upvalues: LocalPlayer (copy), RunService (copy), UserInputService (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("CustomShiftLock");
    end;

    if Character then
        Character = Character:FindFirstChild("SmoothShiftLock");
    end;

    if Character then
        Character = Character:FindFirstChild("ToggleShiftLock");
    end;

    p25._shiftLockWasEnabled = LocalPlayer:GetAttribute("ShiftLockEnabled") == true;

    if p25._shiftLockWasEnabled and Character then
        Character:Fire(false);
    end;

    local success, result = pcall(function() -- Line: 256
        -- upvalues: LocalPlayer (ref)
        return require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"));
    end);

    if success and result then
        p25._controls = result:GetControls();
        p25._controls:Disable();
    end;

    p25._savedCameraMode = LocalPlayer.CameraMode;
    LocalPlayer.CameraMode = Enum.CameraMode.Classic;
    p25._mouseUnlockConn = RunService.RenderStepped:Connect(function() -- Line: 267
        -- upvalues: UserInputService (ref)
        if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        end;

        if not UserInputService.MouseIconEnabled then
            UserInputService.MouseIconEnabled = true;
        end;
    end);
end;

function v1._releaseCursor(p26) -- Line: 277
    -- upvalues: LocalPlayer (copy), UserInputService (copy)
    if p26._mouseUnlockConn then
        p26._mouseUnlockConn:Disconnect();
        p26._mouseUnlockConn = nil;
    end;

    if p26._savedCameraMode then
        LocalPlayer.CameraMode = p26._savedCameraMode;
        p26._savedCameraMode = nil;
    end;

    if p26._controls then
        p26._controls:Enable();
        p26._controls = nil;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("CustomShiftLock");
    end;

    if Character then
        Character = Character:FindFirstChild("SmoothShiftLock");
    end;

    if Character then
        Character = Character:FindFirstChild("ToggleShiftLock");
    end;

    if p26._shiftLockWasEnabled and Character then
        Character:Fire(true);
    end;

    p26._shiftLockWasEnabled = nil;
    UserInputService.MouseIconEnabled = false;
end;

function v1._canOpen(p27) -- Line: 307
    -- upvalues: LocalPlayer (copy)
    if p27._open then
        return false;
    end;

    if #p27._emotes == 0 then
        return false;
    end;

    if LocalPlayer:GetAttribute("UIInputLocked") == true then
        return false;
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return false;
    end;

    local v28 = Character:FindFirstChildOfClass("Humanoid");

    if not v28 or v28.Health <= 0 then
        return false;
    end;

    local Attribute = Character:GetAttribute("Stance");

    return Attribute == nil or Attribute == 0;
end;

function v1.Open(u29) -- Line: 327
    -- upvalues: RunService (copy)
    if not u29:_canOpen() then
        return;
    end;

    u29._open = true;
    u29._selection = nil;
    u29._gui.Enabled = true;
    u29:_grabCursor();
    u29:_paintSelection();
    u29._selectionConn = RunService.RenderStepped:Connect(function() -- Line: 341
        -- upvalues: u29 (copy)
        u29:_updateSelection();
    end);
end;

function v1.Close(p30, p31) -- Line: 348
    if not p30._open then
        return;
    end;

    p30._open = false;
    local v32;

    if p31 then
        v32 = p30._selection or nil;
    else
        v32 = nil;
    end;

    p30._selection = nil;

    if p30._selectionConn then
        p30._selectionConn:Disconnect();
        p30._selectionConn = nil;
    end;

    p30._gui.Enabled = false;
    p30:_releaseCursor();

    if v32 then
        p30:PlayEmote(v32);
    end;
end;

function v1.StopEmote(p33) -- Line: 371
    -- upvalues: EmoteConfig (copy)
    for _, v in ipairs(p33._emoteConns) do
        v:Disconnect();
    end;

    table.clear(p33._emoteConns);

    if p33._activeTrack then
        p33._activeTrack:Stop(EmoteConfig.BlendTime);
        p33._activeTrack = nil;
    end;
end;

function v1._bindCancels(u34, p35) -- Line: 385
    -- upvalues: LocalPlayer (copy), EmoteConfig (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local u36;

    if Character then
        u36 = Character:FindFirstChildOfClass("Humanoid");
    else
        u36 = Character;
    end;

    if not u36 then
        return;
    end;

    local _emoteConns = u34._emoteConns;

    local function add(p37) -- Line: 391
        -- upvalues: _emoteConns (copy)
        _emoteConns[#_emoteConns + 1] = p37;
    end;

    local u38 = os.clock() + EmoteConfig.MoveCancelGrace;
    local v39 = RunService.Heartbeat:Connect(function() -- Line: 397
        -- upvalues: u38 (copy), u36 (copy), u34 (copy)
        if os.clock() < u38 then
            return;
        end;

        if u36.MoveDirection.Magnitude > 0.05 then
            u34:StopEmote();
        end;
    end);
    _emoteConns[#_emoteConns + 1] = v39;
    local v42 = u36.StateChanged:Connect(function(p40, p41) -- Line: 404
        -- upvalues: u34 (copy)
        if p41 == Enum.HumanoidStateType.Jumping or p41 == Enum.HumanoidStateType.Freefall then
            u34:StopEmote();
        end;
    end);
    _emoteConns[#_emoteConns + 1] = v42;
    local Health = u36.Health;
    local v45 = u36.HealthChanged:Connect(function(p43) -- Line: 412
        -- upvalues: Health (ref), u34 (copy)
        local v44 = p43 < Health;
        Health = p43;

        if v44 then
            u34:StopEmote();
        end;
    end);
    _emoteConns[#_emoteConns + 1] = v45;
    local v46 = u36.Died:Connect(function() -- Line: 418
        -- upvalues: u34 (copy)
        u34:StopEmote();
    end);
    _emoteConns[#_emoteConns + 1] = v46;
    local v48 = Character.ChildAdded:Connect(function(p47) -- Line: 423
        -- upvalues: u34 (copy)
        if p47:IsA("Tool") then
            u34:StopEmote();
        end;
    end);
    _emoteConns[#_emoteConns + 1] = v48;

    if not p35.Looped then
        local v49 = p35.Stopped:Connect(function() -- Line: 435
            -- upvalues: u34 (copy)
            u34:StopEmote();
        end);
        _emoteConns[#_emoteConns + 1] = v49;
    end;
end;

function v1.PlayEmote(p50, p51) -- Line: 441
    -- upvalues: LocalPlayer (copy), EmoteConfig (copy)
    local v52 = p50._emotes[p51];

    if not v52 then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if Character then
        Character = Character:FindFirstChildOfClass("Animator");
    end;

    if not Character then
        return;
    end;

    p50:StopEmote();
    local v53 = p50._tracks[v52.animId];

    if not v53 then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = v52.animId;
        local v54;
        v54, v53 = pcall(function() -- Line: 456
            -- upvalues: Character (copy), Animation (copy)
            return Character:LoadAnimation(Animation);
        end);

        if not (v54 and v53) then
            warn(("[EmoteWheel] failed to load %s (%s)"):format(v52.name, v52.animId));

            return;
        end;

        p50._tracks[v52.animId] = v53;
    end;

    v53.Priority = Enum.AnimationPriority.Action3;
    v53.Looped = v52.loop == true;
    v53:Play(EmoteConfig.BlendTime, 1, v52.speed or 1);
    p50._activeTrack = v53;
    p50:_bindCancels(v53);
end;

function v1.Init(u55) -- Line: 485
    -- upvalues: validateEmotes (copy), EmoteConfig (copy), UserInputService (copy), LocalPlayer (copy)
    if u55._started then
        return;
    end;

    u55._started = true;
    u55._emotes = validateEmotes(EmoteConfig.Emotes);

    if #u55._emotes == 0 then
        warn("[EmoteWheel] no valid emotes in EmoteConfig -- wheel disabled");

        return;
    end;

    u55:_buildGui();
    UserInputService.InputBegan:Connect(function(p56, p57) -- Line: 497
        -- upvalues: EmoteConfig (ref), u55 (copy)
        if p57 then
            return;
        end;

        if p56.KeyCode ~= EmoteConfig.OpenKey then
            return;
        end;

        if u55._activeTrack then
            u55:StopEmote();

            return;
        end;

        u55:Open();
    end);
    UserInputService.InputEnded:Connect(function(p58) -- Line: 509
        -- upvalues: EmoteConfig (ref), u55 (copy)
        if p58.KeyCode ~= EmoteConfig.OpenKey then
            return;
        end;

        u55:Close(true);
    end);

    local function hookCharacter(p59) -- Line: 517
        -- upvalues: u55 (copy)
        local Humanoid = p59:WaitForChild("Humanoid", 10);

        if not Humanoid then
            return;
        end;

        Humanoid.Died:Connect(function() -- Line: 520
            -- upvalues: u55 (ref)
            u55:Close(false);
            u55:StopEmote();
        end);
    end;

    if LocalPlayer.Character then
        task.spawn(hookCharacter, LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(function(p60) -- Line: 530
        -- upvalues: u55 (copy), hookCharacter (copy)
        u55:Close(false);
        u55:StopEmote();
        table.clear(u55._tracks);
        u55._activeTrack = nil;
        task.spawn(hookCharacter, p60);
    end);
    print(("[EmoteWheel] ready with %d emotes"):format(#u55._emotes));
end;

return v1;