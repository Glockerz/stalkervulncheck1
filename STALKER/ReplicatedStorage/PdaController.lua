-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = Workspace.CurrentCamera;
local success, result = pcall(function() -- Line: 17
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("PdaSound", 5));
end);

local function sfx(p1) -- Line: 20
    -- upvalues: success (copy), result (copy)
    if success and result then
        result.Play(p1);
    end;
end;

local function click() -- Line: 23
    -- upvalues: success (copy), result (copy)
    if success and result then
        result.PlayClick(5);
    end;
end;

local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
CFrame.new();
local u2 = 0.8 * require(ReplicatedStorage:WaitForChild("SPH_Assets"):WaitForChild("GameConfig")).walkSpeed;
local u3 = { "Map", "Tasks", "Radio", "Contacts", "Reputation" };

if not require(ReplicatedStorage:WaitForChild("PlaceConfig")).IsLobby then
    table.insert(u3, "Music");
end;

table.insert(u3, "Settings");

local function findScreenPart(p4) -- Line: 82
    local Screen = p4:FindFirstChild("Screen");

    if Screen and Screen:IsA("BasePart") then
        return Screen;
    end;

    if p4.PrimaryPart then
        return p4.PrimaryPart;
    end;

    for _, descendant in ipairs(p4:GetDescendants()) do
        if descendant:IsA("BasePart") then
            return descendant;
        end;
    end;

    return nil;
end;

local function findMountPoint(p5) -- Line: 92
    return p5:FindFirstChild("RightHand") or p5:FindFirstChild("Right Arm");
end;

local function zoomDistanceFor(p6) -- Line: 100
    -- upvalues: CurrentCamera (copy)
    local ViewportSize = CurrentCamera.ViewportSize;
    local v7 = ViewportSize.Y > 0 and ViewportSize.X / ViewportSize.Y or 1.7777777777777777;
    local v8 = math.rad(CurrentCamera.FieldOfView) / 2;
    local math_tan_ret = math.tan(v8);
    local Size = p6.Size;

    return math.max(Size.Y / (math_tan_ret * 1.36), Size.X / (math_tan_ret * 1.36 * v7));
end;

return {
    IsOpen = false,
    _initialized = false,
    _pdaModel = nil,
    _pdaMountPart = nil,
    _surfaceGui = nil,
    _currentTab = nil,
    _renderStepBound = nil,
    _tabButtons = nil,
    _pageFrames = nil,
    _clockLabel = nil,
    _clockTask = nil,
    _savedCamType = nil,
    _savedCamCFrame = nil,
    _savedCamFOV = nil,
    _savedCamSubject = nil,
    _savedCameraMode = nil,
    _savedCameraMinZoom = nil,
    _savedCameraMaxZoom = nil,
    _savedMouseBehavior = nil,
    _savedMouseIconEnabled = nil,
    _savedWalkSpeed = nil,
    _savedJumpPower = nil,
    _savedJumpHeight = nil,
    _savedAutoRotate = nil,
    _sphCharacterClient = nil,
    _animTrack = nil,
    _zoomedIn = false,
    _mb1Action = nil,
    _mb2Action = nil,

    _buildModel = function(p9) -- Line: 142, Name: _buildModel
        -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy)
        local Character = LocalPlayer.Character;

        if not Character then
            return false;
        end;

        local v10 = Character:FindFirstChild("RightHand") or Character:FindFirstChild("Right Arm");

        if not v10 then
            warn("[PdaController] Player has no RightHand / Right Arm");

            return false;
        end;

        ReplicatedStorage:WaitForChild("PdaRemotes").OpenPda:FireServer();
        local PDA = Character:WaitForChild("PDA", 3);

        if not PDA then
            warn("[PdaController] PDA model didn\'t appear after OpenPda fire");

            return false;
        end;

        if PDA:WaitForChild("Screen", 3) then
            return PDA, v10;
        end;

        warn("[PdaController] PDA Screen didn\'t replicate after model arrived");

        return false;
    end,

    _destroyModel = function(p11) -- Line: 180, Name: _destroyModel
        -- upvalues: ReplicatedStorage (copy)
        local PdaRemotes = ReplicatedStorage:FindFirstChild("PdaRemotes");

        if PdaRemotes and PdaRemotes:FindFirstChild("ClosePda") then
            PdaRemotes.ClosePda:FireServer();
        end;

        p11._pdaModel = nil;
        p11._pdaMountPart = nil;
    end,

    _buildGui = function(u12) -- Line: 192, Name: _buildGui
        -- upvalues: findScreenPart (copy), LocalPlayer (copy), Font_new_ret (copy), ReplicatedStorage (copy), Font_new_ret2 (copy), u3 (copy), success (copy), result (copy), Font_new_ret3 (copy)
        if not u12._pdaModel then
            return;
        end;

        local v13 = findScreenPart(u12._pdaModel);

        if not v13 then
            warn("[PdaController] No screen part found on PDA model");

            return;
        end;

        local SurfaceGui = Instance.new("SurfaceGui");
        SurfaceGui.Name = "PdaScreen";
        SurfaceGui.Adornee = v13;
        SurfaceGui.Face = Enum.NormalId.Front;
        SurfaceGui.PixelsPerStud = 2343;
        SurfaceGui.LightInfluence = 0;
        SurfaceGui.ClipsDescendants = true;
        SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
        SurfaceGui.AlwaysOnTop = true;
        SurfaceGui.Parent = LocalPlayer.PlayerGui;
        local Frame = Instance.new("Frame");
        Frame.Name = "MainFrame";
        Frame.Size = UDim2.fromScale(0.6666666666666666, 0.6666666666666666);
        Frame:SetAttribute("RenderScale", 1.5);
        local UIScale = Instance.new("UIScale");
        UIScale.Scale = 1.5;
        UIScale.Parent = Frame;
        u12._mainFrame = Frame;
        u12._uiScale = UIScale;
        u12._designHeight = v13.Size.Y * 1562;
        Frame.BackgroundColor3 = Color3.fromRGB(25, 27, 24);
        Frame.BackgroundTransparency = 0;
        Frame.BorderSizePixel = 0;
        Frame.Parent = SurfaceGui;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(48, 48, 48);
        UIStroke.Thickness = 1;
        UIStroke.Parent = Frame;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) });
        UIGradient.Rotation = -90;
        UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) });
        UIGradient.Parent = Frame;
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "HeaderBar";
        Frame2.Size = UDim2.fromScale(1, 0.1);
        Frame2.Position = UDim2.fromScale(0, 0);
        Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Frame2.BorderSizePixel = 0;
        Frame2.Parent = Frame;
        local UIGradient2 = Instance.new("UIGradient");
        UIGradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) });
        UIGradient2.Rotation = -90;
        UIGradient2.Parent = Frame2;
        local UIStroke2 = Instance.new("UIStroke");
        UIStroke2.Color = Color3.fromRGB(48, 48, 48);
        UIStroke2.Thickness = 1;
        UIStroke2.Parent = Frame2;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "Zone";
        TextLabel.Size = UDim2.fromScale(0.5, 1);
        TextLabel.Position = UDim2.fromOffset(22, 0);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font_new_ret;
        TextLabel.TextSize = 36;
        TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220);
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
        local Attribute = LocalPlayer:GetAttribute("Zone");
        local PdaMapData = require(ReplicatedStorage:WaitForChild("PdaMapData"));
        TextLabel.Text = require(ReplicatedStorage:WaitForChild("ServerRegistryRules")).PlaceLabel(Attribute or PdaMapData.CurrentZone(), game.JobId);
        TextLabel.Parent = Frame2;
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "StatusGroup";
        Frame3.AnchorPoint = Vector2.new(1, 0);
        Frame3.Position = UDim2.new(1, -22, 0, 0);
        Frame3.Size = UDim2.fromScale(0.5, 1);
        Frame3.BackgroundTransparency = 1;
        Frame3.Parent = Frame2;
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
        UIListLayout.Padding = UDim.new(0, 22);
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout.Parent = Frame3;
        (function(p14) -- Line: 304, Name: makeBatteryIcon
            -- upvalues: Frame3 (copy)
            local Frame4 = Instance.new("Frame");
            Frame4.Name = "Battery";
            Frame4.Size = UDim2.fromOffset(50, 22);
            Frame4.BackgroundTransparency = 1;
            Frame4.LayoutOrder = p14;
            Frame4.Parent = Frame3;
            local Frame5 = Instance.new("Frame");
            Frame5.Size = UDim2.fromOffset(42, 22);
            Frame5.Position = UDim2.fromOffset(0, 0);
            Frame5.BackgroundTransparency = 1;
            Frame5.BorderSizePixel = 0;
            Frame5.Parent = Frame4;
            local UIStroke3 = Instance.new("UIStroke");
            UIStroke3.Color = Color3.fromRGB(200, 230, 200);
            UIStroke3.Thickness = 2;
            UIStroke3.Parent = Frame5;
            local Frame6 = Instance.new("Frame");
            Frame6.Size = UDim2.fromOffset(5, 11);
            Frame6.Position = UDim2.new(0, 43, 0.5, -5.5);
            Frame6.BackgroundColor3 = Color3.fromRGB(200, 230, 200);
            Frame6.BorderSizePixel = 0;
            Frame6.Parent = Frame4;

            for i = 1, 3 do
                local Frame7 = Instance.new("Frame");
                Frame7.Size = UDim2.fromOffset(10, 13);
                Frame7.Position = UDim2.fromOffset((i - 1) * 12 + 3, 5);
                Frame7.BackgroundColor3 = Color3.fromRGB(200, 230, 200);
                Frame7.BorderSizePixel = 0;
                Frame7.Parent = Frame5;
                local _ = i;
            end;
        end)(1);
        (function(p15) -- Line: 341, Name: makeSignalIcon
            -- upvalues: Frame3 (copy)
            local Frame4 = Instance.new("Frame");
            Frame4.Name = "Signal";
            Frame4.Size = UDim2.fromOffset(44, 22);
            Frame4.BackgroundTransparency = 1;
            Frame4.LayoutOrder = p15;
            Frame4.Parent = Frame3;

            for i = 1, 4 do
                local Frame5 = Instance.new("Frame");
                Frame5.Size = UDim2.fromOffset(8, i * 3 + 6);
                Frame5.AnchorPoint = Vector2.new(0, 1);
                Frame5.Position = UDim2.new(0, (i - 1) * 11, 1, -1);
                Frame5.BackgroundColor3 = Color3.fromRGB(200, 230, 200);
                Frame5.BorderSizePixel = 0;
                Frame5.Parent = Frame4;
                local _ = i;
            end;
        end)(2);
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = "Clock";
        TextLabel2.Size = UDim2.fromOffset(100, 36);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.LayoutOrder = 3;
        TextLabel2.FontFace = Font_new_ret2;
        TextLabel2.TextSize = 32;
        TextLabel2.TextColor3 = Color3.fromRGB(220, 220, 220);
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Right;
        TextLabel2.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel2.Parent = Frame3;
        local os_time_ret = os.time();
        TextLabel2.Text = string.format("%02d:%02d", math.floor(os_time_ret / 3600 % 24), (math.floor(os_time_ret / 60 % 60)));
        u12._clockLabel = TextLabel2;
        local Frame4 = Instance.new("Frame");
        Frame4.Name = "TabBar";
        Frame4.Size = UDim2.fromScale(1, 0.07);
        Frame4.Position = UDim2.fromScale(0, 0.1);
        Frame4.BackgroundTransparency = 1;
        Frame4.Parent = Frame;
        u12._tabBar = Frame4;
        local UIListLayout2 = Instance.new("UIListLayout");
        UIListLayout2.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout2.Padding = UDim.new(0, 4);
        UIListLayout2.Parent = Frame4;
        u12._tabButtons = {};

        for i, v in ipairs(u3) do
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "Tab_" .. v;
            TextButton.Size = UDim2.new(1 / #u3, -4, 1, 0);
            TextButton.LayoutOrder = i;
            TextButton.AutoButtonColor = false;
            TextButton.BackgroundColor3 = Color3.fromRGB(40, 42, 45);
            TextButton.BackgroundTransparency = 0.2;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = string.upper(v);
            TextButton.FontFace = Font_new_ret2;
            TextButton.TextSize = 24;
            TextButton.TextColor3 = Color3.fromRGB(170, 170, 170);
            TextButton.Parent = Frame4;
            local UIStroke3 = Instance.new("UIStroke");
            UIStroke3.Color = Color3.fromRGB(48, 48, 48);
            UIStroke3.Thickness = 1;
            UIStroke3.Parent = TextButton;
            u12._tabButtons[v] = TextButton;
            TextButton.MouseButton1Click:Connect(function() -- Line: 415
                -- upvalues: success (ref), result (ref), u12 (copy), v (copy)
                if success and result then
                    result.PlayClick(5);
                end;

                u12:_setTab(v);
            end);
        end;

        local function refreshTasksBadge() -- Line: 425
            -- upvalues: u12 (copy), ReplicatedStorage (ref)
            local v16 = u12._tabButtons and u12._tabButtons.Tasks;

            if not v16 then
                return;
            end;

            local success2, result2 = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3));
            local v17 = 0;
            local v18;

            if success2 and (result2 and result2.GetActiveTasks) then
                local v19 = result2:GetActiveTasks() or {};
                v18 = #v19;

                for _, v in ipairs(v19) do
                    local v20 = v.objectives or {};
                    local v21 = #v20 > 0;
                    local v22 = false;

                    for _, v2 in ipairs(v20) do
                        if v2.id == "return" or v2.id == "deliver" then
                            if not v2.complete then
                                v22 = true;
                            end;
                        elseif not v2.complete then
                            v21 = false;
                        end;
                    end;

                    local v23 = false;

                    for _, v2 in ipairs(v20) do
                        if v2.id == "return" or v2.id == "deliver" then
                            v23 = true;
                            break;
                        end;
                    end;

                    if v21 and (v22 or not v23) then
                        v17 = v17 + 1;
                    end;
                end;
            else
                v18 = 0;
            end;

            local v24 = v17 > 0 and "! " or "";

            if v18 > 0 then
                v16.Text = string.format("%sTASKS (%d)", v24, v18);
            else
                v16.Text = "TASKS";
            end;

            v16.TextColor3 = v17 > 0 and Color3.fromRGB(255, 220, 130) or Color3.fromRGB(170, 170, 170);
        end;

        task.spawn(function() -- Line: 464
            -- upvalues: ReplicatedStorage (ref), refreshTasksBadge (copy)
            local success2, result2 = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 5));

            if not (success2 and result2) then
                return;
            end;

            if result2.OnChanged then
                result2:OnChanged(refreshTasksBadge);
            end;

            refreshTasksBadge();
        end);
        local Frame5 = Instance.new("Frame");
        Frame5.Name = "ContentArea";
        Frame5.Size = UDim2.fromScale(1, 0.83);
        Frame5.Position = UDim2.fromScale(0, 0.17);
        Frame5.BackgroundTransparency = 1;
        Frame5.Parent = Frame;
        local PdaTasksPage = require(ReplicatedStorage:WaitForChild("PdaTasksPage"));
        local PdaRadioPage = require(ReplicatedStorage:WaitForChild("PdaRadioPage"));
        local PdaContactsPage = require(ReplicatedStorage:WaitForChild("PdaContactsPage"));
        local PdaReputationPage = require(ReplicatedStorage:WaitForChild("PdaReputationPage"));
        u12._pageFrames = {};

        for _, v in ipairs(u3) do
            local Frame6 = Instance.new("Frame");
            Frame6.Name = "Page_" .. v;
            Frame6.Size = UDim2.fromScale(1, 1);
            Frame6.BackgroundTransparency = 1;
            Frame6.Visible = false;
            Frame6.Parent = Frame5;

            if v == "Tasks" then
                PdaTasksPage.Build(Frame6);
            elseif v == "Radio" then
                PdaRadioPage.Build(Frame6);
            elseif v == "Contacts" then
                PdaContactsPage.Build(Frame6);
            elseif v == "Reputation" then
                PdaReputationPage.Build(Frame6);
            elseif v == "Music" then
                require(ReplicatedStorage:WaitForChild("PdaMusicPage")).Build(Frame6);
            elseif v == "Settings" then
                require(ReplicatedStorage:WaitForChild("PdaSettingsPage")).Build(Frame6);
            elseif v == "Map" then
                require(ReplicatedStorage:WaitForChild("PdaMapPage")).Build(Frame6);
            else
                local TextLabel3 = Instance.new("TextLabel");
                TextLabel3.Size = UDim2.fromScale(1, 1);
                TextLabel3.BackgroundTransparency = 1;
                TextLabel3.FontFace = Font_new_ret3;
                TextLabel3.TextSize = 32;
                TextLabel3.TextColor3 = Color3.fromRGB(180, 180, 180);
                TextLabel3.Text = v .. " coming soon";
                TextLabel3.Parent = Frame6;
            end;

            u12._pageFrames[v] = Frame6;
        end;

        u12._contentArea = Frame5;
        u12._radioFocusDisconnect = require(ReplicatedStorage:WaitForChild("RadioClient")):OnFocusDM(function() -- Line: 525
            -- upvalues: u12 (copy)
            if u12._pageFrames then
                u12:_setTab("Radio");
            end;
        end);
        u12._clockTask = task.spawn(function() -- Line: 529
            -- upvalues: u12 (copy)
            while u12._clockLabel and u12._clockLabel.Parent do
                local os_time_ret2 = os.time();
                u12._clockLabel.Text = string.format("%02d:%02d", math.floor(os_time_ret2 / 3600 % 24), (math.floor(os_time_ret2 / 60 % 60)));
                task.wait(20);
            end;
        end);

        local function enlarge(p25) -- Line: 540
            if not (p25:IsA("TextLabel") or (p25:IsA("TextButton") or p25:IsA("TextBox"))) then
                return;
            end;

            if p25.TextScaled or p25:GetAttribute("PdaBaseTextSize") then
                return;
            end;

            local TextSize = p25.TextSize;
            p25:SetAttribute("PdaBaseTextSize", TextSize);
            p25.TextSize = TextSize + (TextSize <= 18 and 4 or 2);
        end;

        for _, descendant in ipairs(Frame:GetDescendants()) do
            enlarge(descendant);
        end;

        Frame.DescendantAdded:Connect(enlarge);
        u12._surfaceGui = SurfaceGui;
        u12:_setTab("Map");

        if u12._takeover then
            u12:_applyTakeover();
        end;
    end,

    _fitMainFrame = function(p26, p27) -- Line: 561, Name: _fitMainFrame
        local _mainFrame = p26._mainFrame;
        local _uiScale = p26._uiScale;

        if not (_mainFrame and (_uiScale and (p26._designHeight and p27 > 0))) then
            return;
        end;

        local v28 = p27 / p26._designHeight;

        if math.abs(v28 - _uiScale.Scale) < 0.0005 then
            return;
        end;

        _uiScale.Scale = v28;
        _mainFrame.Size = UDim2.fromScale(1 / v28, 1 / v28);
        _mainFrame:SetAttribute("RenderScale", v28);
    end,

    _showOverlay = function(p29, p30) -- Line: 571, Name: _showOverlay
        -- upvalues: LocalPlayer (copy)
        local _mainFrame = p29._mainFrame;

        if not _mainFrame then
            return;
        end;

        if not p30 then
            if p29._surfaceGui then
                _mainFrame.Parent = p29._surfaceGui;
                p29:_fitMainFrame(p29._surfaceGui.AbsoluteSize.Y);
            end;

            if p29._overlay then
                p29._overlay:Destroy();
            end;

            p29._overlay = nil;
            p29._overlayFrame = nil;

            return;
        end;

        if p29._overlay then
            return;
        end;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = "PdaZoomOverlay";
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.ResetOnSpawn = false;
        ScreenGui.DisplayOrder = 5;
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        local Frame = Instance.new("Frame");
        Frame.Name = "Screen";
        Frame.BackgroundTransparency = 1;
        Frame.ClipsDescendants = true;
        Frame.Parent = ScreenGui;
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        p29._overlay = ScreenGui;
        p29._overlayFrame = Frame;
        p29:_updateOverlay();
        _mainFrame.Parent = Frame;
    end,

    _updateOverlay = function(p31) -- Line: 603, Name: _updateOverlay
        -- upvalues: CurrentCamera (copy)
        local _overlayFrame = p31._overlayFrame;
        local _surfaceGui = p31._surfaceGui;

        if _surfaceGui then
            _surfaceGui = _surfaceGui.Adornee;
        end;

        if not (_overlayFrame and _surfaceGui) then
            return;
        end;

        local Size = _surfaceGui.Size;
        local v32 = (1 / 0);
        local v33 = (-1 / 0);
        local v34 = (1 / 0);
        local v35 = (-1 / 0);

        for _, v in ipairs({ -1, 1 }) do
            local v36 = v;

            for _, v2 in ipairs({ -1, 1 }) do
                local v37 = CurrentCamera:WorldToViewportPoint(_surfaceGui.CFrame * Vector3.new(v36 * Size.X / 2, v2 * Size.Y / 2, -Size.Z / 2));
                v34 = math.min(v34, v37.X);
                v35 = math.max(v35, v37.X);
                v32 = math.min(v32, v37.Y);
                v33 = math.max(v33, v37.Y);
            end;
        end;

        local math_floor_ret = math.floor(v35 - v34 + 0.5);
        local math_floor_ret2 = math.floor(v33 - v32 + 0.5);
        _overlayFrame.Position = UDim2.fromOffset(math.floor(v34 + 0.5), (math.floor(v32 + 0.5)));
        _overlayFrame.Size = UDim2.fromOffset(math_floor_ret, math_floor_ret2);
        p31:_fitMainFrame(math_floor_ret2);
    end,

    _destroyGui = function(p38) -- Line: 624, Name: _destroyGui
        if p38._clockTask then
            task.cancel(p38._clockTask);
            p38._clockTask = nil;
        end;

        p38._clockLabel = nil;

        if p38._overlay then
            p38._overlay:Destroy();
        end;

        p38._overlay = nil;
        p38._overlayFrame = nil;
        p38._mainFrame = nil;
        p38._uiScale = nil;

        if p38._surfaceGui then
            p38._surfaceGui:Destroy();
            p38._surfaceGui = nil;
        end;

        if p38._radioFocusDisconnect then
            p38._radioFocusDisconnect();
            p38._radioFocusDisconnect = nil;
        end;

        p38._tabButtons = nil;
        p38._contentArea = nil;
        p38._pageFrames = nil;
        p38._currentTab = nil;
    end,

    _setTab = function(p39, p40) -- Line: 641, Name: _setTab
        if not (p39._pageFrames and p39._tabButtons) then
            return;
        end;

        p39._currentTab = p40;

        for i, v in pairs(p39._pageFrames) do
            v.Visible = i == p40;
        end;

        for i, v in pairs(p39._tabButtons) do
            if i == p40 then
                v.BackgroundColor3 = Color3.fromRGB(255, 200, 90);
                v.BackgroundTransparency = 0;
                v.TextColor3 = Color3.fromRGB(20, 20, 22);
            else
                v.BackgroundColor3 = Color3.fromRGB(40, 42, 45);
                v.BackgroundTransparency = 0.2;
                v.TextColor3 = Color3.fromRGB(170, 170, 170);
            end;
        end;
    end,

    _applyTakeover = function(p41) -- Line: 666, Name: _applyTakeover
        local _mainFrame = p41._mainFrame;

        if not (_mainFrame and p41._takeover) then
            return;
        end;

        local Page_Takeover = _mainFrame:FindFirstChild("Page_Takeover");

        if Page_Takeover then
            Page_Takeover:Destroy();
        end;

        if p41._tabBar then
            p41._tabBar.Visible = false;
        end;

        if p41._contentArea then
            p41._contentArea.Visible = false;
        end;

        local Frame = Instance.new("Frame");
        Frame.Name = "Page_Takeover";
        Frame.Position = UDim2.fromScale(0, 0.1);
        Frame.Size = UDim2.fromScale(1, 0.9);
        Frame.BackgroundTransparency = 1;
        Frame.Parent = _mainFrame;
        p41._takeover(Frame);
    end,

    _removeTakeover = function(p42) -- Line: 682, Name: _removeTakeover
        local _mainFrame = p42._mainFrame;

        if _mainFrame then
            _mainFrame = _mainFrame:FindFirstChild("Page_Takeover");
        end;

        if _mainFrame then
            _mainFrame:Destroy();
        end;

        if p42._tabBar then
            p42._tabBar.Visible = true;
        end;

        if p42._contentArea then
            p42._contentArea.Visible = true;
        end;
    end,

    ShowTakeover = function(p43, p44) -- Line: 690, Name: ShowTakeover
        -- upvalues: success (copy), result (copy)
        if not p43._takeover and (success and result) then
            result.Play("route_opened");
        end;

        if not p43._takeoverRestore then
            p43._takeoverRestore = {
                wasOpen = p43.IsOpen,
                tab = p43._currentTab,
                zoomed = p43._zoomedIn == true
            };
        end;

        p43._takeover = p44;

        if p43.IsOpen and p43._mainFrame then
            p43:_applyTakeover();
        elseif not p43.IsOpen then
            p43:Open();
        end;

        if p43._takeover == p44 and p43.IsOpen then
            p43:_enterZoom();
        end;
    end,

    HideTakeover = function(p45) -- Line: 708, Name: HideTakeover
        local _takeoverRestore = p45._takeoverRestore;
        p45._takeover = nil;
        p45._takeoverRestore = nil;

        if not _takeoverRestore then
            return;
        end;

        p45:_removeTakeover();

        if not p45.IsOpen then
            return;
        end;

        if not _takeoverRestore.wasOpen then
            p45:Close();

            return;
        end;

        if _takeoverRestore.tab then
            p45:_setTab(_takeoverRestore.tab);
        end;

        if not _takeoverRestore.zoomed then
            p45:_exitZoom();
        end;
    end,

    Open = function(u46) -- Line: 722, Name: Open
        -- upvalues: success (copy), result (copy), LocalPlayer (copy), CurrentCamera (copy), UserInputService (copy), RunService (copy), ContextActionService (copy), ReplicatedStorage (copy)
        if u46.IsOpen then
            return;
        end;

        u46.IsOpen = true;
        u46._openAt = tick();
        u46._epoch = (u46._epoch or 0) + 1;
        local _epoch = u46._epoch;

        if success and result then
            result.Play("pda_draw");
        end;

        local Character = LocalPlayer.Character;
        local u47;

        if Character then
            u47 = Character:FindFirstChildOfClass("Humanoid");
        else
            u47 = Character;
        end;

        u46._savedCamType = CurrentCamera.CameraType;
        u46._savedCamCFrame = CurrentCamera.CFrame;
        u46._savedCamFOV = CurrentCamera.FieldOfView;
        u46._savedCamSubject = CurrentCamera.CameraSubject;
        u46._savedCameraMode = LocalPlayer.CameraMode;
        u46._savedCameraMinZoom = LocalPlayer.CameraMinZoomDistance;
        u46._savedCameraMaxZoom = LocalPlayer.CameraMaxZoomDistance;
        u46._savedMouseBehavior = UserInputService.MouseBehavior;
        u46._savedMouseIconEnabled = UserInputService.MouseIconEnabled;

        if u47 then
            u46._savedWalkSpeed = u47.WalkSpeed;
            u46._savedJumpPower = u47.JumpPower;
            u46._savedJumpHeight = u47.JumpHeight;
            u46._savedAutoRotate = u47.AutoRotate;
        end;

        if Character then
            Character = Character:FindFirstChild("CharacterClient", true);
        end;

        if Character then
            u46._sphCharacterClient = Character;
        end;

        LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
        LocalPlayer.CameraMinZoomDistance = 0;
        LocalPlayer.CameraMaxZoomDistance = 0;
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
        UserInputService.MouseIconEnabled = false;
        local v48, v49 = u46:_buildModel();

        if u46._epoch ~= _epoch then
            if not u46.IsOpen then
                u46:_destroyModel();
            end;

            return;
        end;

        u46._pdaModel = v48 or nil;
        u46._pdaMountPart = v49;
        u46:_buildGui();

        if u46._epoch ~= _epoch then
            if not u46.IsOpen then
                u46:_destroyGui();
                u46:_destroyModel();
            end;

            return;
        end;

        local v50;

        if u47 then
            v50 = u47:FindFirstChildOfClass("Animator");
        else
            v50 = u47;
        end;

        if v50 then
            if u46._animTrack then
                u46._animTrack:Stop();
                u46._animTrack:Destroy();
                u46._animTrack = nil;
            end;

            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://95242444549536";
            u46._animTrack = v50:LoadAnimation(Animation);
            u46._animTrack.Looped = true;
            u46._animTrack.Priority = Enum.AnimationPriority.Action4;
            u46._animTrack:Play();
        end;

        if not u46._renderStepBound then
            u46._renderStepBound = "PdaFreeze";
            RunService:BindToRenderStep(u46._renderStepBound, Enum.RenderPriority.Camera.Value + 100, function() -- Line: 810
                -- upvalues: LocalPlayer (ref), u46 (copy), UserInputService (ref), CurrentCamera (ref)
                if not LocalPlayer.Character then
                    return;
                end;

                if u46._pdaModel then
                    for _, descendant in ipairs(u46._pdaModel:GetDescendants()) do
                        if descendant:IsA("BasePart") then
                            descendant.LocalTransparencyModifier = 0;
                        end;
                    end;
                end;

                if LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
                    LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
                end;

                if u46._zoomedIn then
                    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
                    end;

                    if not UserInputService.MouseIconEnabled then
                        UserInputService.MouseIconEnabled = true;
                    end;

                    if u46._pdaModel and u46._pdaModel.PrimaryPart then
                        local PrimaryPart = u46._pdaModel.PrimaryPart;
                        local Position = PrimaryPart.Position;
                        local LookVector = PrimaryPart.CFrame.LookVector;
                        local ViewportSize = CurrentCamera.ViewportSize;
                        local v51 = ViewportSize.Y > 0 and ViewportSize.X / ViewportSize.Y or 1.7777777777777777;
                        local v52 = math.rad(CurrentCamera.FieldOfView) / 2;
                        local math_tan_ret = math.tan(v52);
                        local Size = PrimaryPart.Size;
                        local v53 = Position + LookVector * math.max(Size.Y / (math_tan_ret * 1.36), Size.X / (math_tan_ret * 1.36 * v51));
                        CurrentCamera.CFrame = CFrame.lookAt(v53, PrimaryPart.Position, PrimaryPart.CFrame.UpVector);
                        u46:_updateOverlay();
                    end;
                else
                    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
                        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
                    end;

                    if UserInputService.MouseIconEnabled then
                        UserInputService.MouseIconEnabled = false;
                    end;
                end;
            end);
        end;

        u46._mb1Action = "PdaZoomIn";
        ContextActionService:BindActionAtPriority(u46._mb1Action, function(p54, p55) -- Line: 851
            -- upvalues: u46 (copy)
            if p55 ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass;
            end;

            if not u46.IsOpen then
                return Enum.ContextActionResult.Pass;
            end;

            if u46._zoomedIn then
                return Enum.ContextActionResult.Pass;
            end;

            u46:_enterZoom();

            return Enum.ContextActionResult.Sink;
        end, false, 250, Enum.UserInputType.MouseButton1);
        u46._mb2Action = "PdaZoomOut";
        ContextActionService:BindActionAtPriority(u46._mb2Action, function(p56, p57) -- Line: 862
            -- upvalues: u46 (copy), ReplicatedStorage (ref)
            if p57 ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass;
            end;

            if not (u46.IsOpen and u46._zoomedIn) then
                return Enum.ContextActionResult.Pass;
            end;

            local success2, result2 = pcall(require, ReplicatedStorage:WaitForChild("PdaMapPage"));

            if success2 and (result2.IsPointerOverMap and result2.IsPointerOverMap()) then
                return Enum.ContextActionResult.Pass;
            end;

            u46:_exitZoom();

            return Enum.ContextActionResult.Sink;
        end, false, 250, Enum.UserInputType.MouseButton2);

        if u47 then
            pcall(function() -- Line: 880
                -- upvalues: u47 (copy)
                u47:UnequipTools();
            end);
        end;
    end,

    _enterZoom = function(p58) -- Line: 884, Name: _enterZoom
        -- upvalues: CurrentCamera (copy), LocalPlayer (copy), u2 (copy)
        if not p58.IsOpen or p58._zoomedIn then
            return;
        end;

        if not (p58._pdaModel and p58._pdaModel.PrimaryPart) then
            return;
        end;

        p58._zoomedIn = true;
        CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        p58:_showOverlay(true);
        local v59 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

        if v59 then
            v59.AutoRotate = false;
        end;

        if p58._sphCharacterClient then
            p58._sphCharacterClient:SetAttribute("SpeedCap_Pda", u2);
        end;
    end,

    _exitZoom = function(p60) -- Line: 903, Name: _exitZoom
        -- upvalues: CurrentCamera (copy), LocalPlayer (copy)
        if not (p60.IsOpen and p60._zoomedIn) then
            return;
        end;

        p60._zoomedIn = false;
        p60:_showOverlay(false);
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        local v61 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

        if v61 then
            v61.AutoRotate = true;
        end;

        if p60._sphCharacterClient then
            p60._sphCharacterClient:SetAttribute("SpeedCap_Pda", nil);
        end;
    end,

    Close = function(p62) -- Line: 920, Name: Close
        -- upvalues: success (copy), result (copy), ContextActionService (copy), RunService (copy), LocalPlayer (copy), UserInputService (copy), CurrentCamera (copy)
        if not p62.IsOpen then
            return;
        end;

        if p62._takeover then
            p62._takeover = nil;
            p62._takeoverRestore = nil;
            local OnTakeoverDismissed = p62.OnTakeoverDismissed;

            if OnTakeoverDismissed then
                task.spawn(OnTakeoverDismissed);
            end;
        end;

        p62._epoch = (p62._epoch or 0) + 1;

        if success and result then
            result.Play("pda_holster");
        end;

        if p62._mb1Action then
            ContextActionService:UnbindAction(p62._mb1Action);
            p62._mb1Action = nil;
        end;

        if p62._mb2Action then
            ContextActionService:UnbindAction(p62._mb2Action);
            p62._mb2Action = nil;
        end;

        if p62._zoomedIn then
            p62:_exitZoom();
        end;

        p62.IsOpen = false;

        if p62._renderStepBound then
            RunService:UnbindFromRenderStep(p62._renderStepBound);
            p62._renderStepBound = nil;
        end;

        if p62._animTrack then
            p62._animTrack:Stop();
            p62._animTrack:Destroy();
            p62._animTrack = nil;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildOfClass("Humanoid");
        end;

        if Character then
            Character = Character:FindFirstChildOfClass("Animator");
        end;

        if Character then
            for _, v in ipairs(Character:GetPlayingAnimationTracks()) do
                if v.Animation and v.Animation.AnimationId == "rbxassetid://95242444549536" then
                    v:Stop(0.1);
                end;
            end;
        end;

        p62:_destroyModel();
        p62:_destroyGui();

        if p62._sphCharacterClient then
            p62._sphCharacterClient:SetAttribute("SpeedCap_Pda", nil);
        end;

        p62._sphCharacterClient = nil;
        local Character2 = LocalPlayer.Character;

        if Character2 then
            Character2 = Character2:FindFirstChildOfClass("Humanoid");
        end;

        if Character2 then
            if p62._savedWalkSpeed ~= nil then
                Character2.WalkSpeed = p62._savedWalkSpeed;
            end;

            if p62._savedJumpPower ~= nil then
                Character2.JumpPower = p62._savedJumpPower;
            end;

            if p62._savedJumpHeight ~= nil then
                Character2.JumpHeight = p62._savedJumpHeight;
            end;

            if p62._savedAutoRotate ~= nil then
                local Character3 = LocalPlayer.Character;

                if Character3 then
                    Character3 = Character3:FindFirstChildOfClass("Tool") ~= nil;
                end;

                if Character3 or p62._savedAutoRotate ~= false then
                    Character2.AutoRotate = p62._savedAutoRotate;
                else
                    Character2.AutoRotate = true;
                end;
            end;
        end;

        p62._savedWalkSpeed = nil;
        p62._savedJumpPower = nil;
        p62._savedJumpHeight = nil;
        p62._savedAutoRotate = nil;

        if p62._savedMouseBehavior ~= nil then
            UserInputService.MouseBehavior = p62._savedMouseBehavior;
        end;

        if p62._savedMouseIconEnabled ~= nil then
            UserInputService.MouseIconEnabled = p62._savedMouseIconEnabled;
        end;

        p62._savedMouseBehavior = nil;
        p62._savedMouseIconEnabled = nil;
        local Character3 = LocalPlayer.Character;

        if Character3 then
            Character3 = Character3:FindFirstChildOfClass("Tool") ~= nil;
        end;

        if p62._savedCameraMode == Enum.CameraMode.LockFirstPerson and not Character3 then
            LocalPlayer.CameraMode = Enum.CameraMode.Classic;
            LocalPlayer.CameraMinZoomDistance = 0.5;
            LocalPlayer.CameraMaxZoomDistance = 8;
        else
            if p62._savedCameraMode ~= nil then
                LocalPlayer.CameraMode = p62._savedCameraMode;
            end;

            if p62._savedCameraMinZoom ~= nil then
                LocalPlayer.CameraMinZoomDistance = p62._savedCameraMinZoom;
            end;

            if p62._savedCameraMaxZoom ~= nil then
                LocalPlayer.CameraMaxZoomDistance = p62._savedCameraMaxZoom;
            end;
        end;

        p62._savedCameraMode = nil;
        p62._savedCameraMinZoom = nil;
        p62._savedCameraMaxZoom = nil;

        if Character2 then
            CurrentCamera.CameraSubject = Character2;
        elseif p62._savedCamSubject then
            CurrentCamera.CameraSubject = p62._savedCamSubject;
        end;

        if p62._savedCamType ~= nil then
            CurrentCamera.CameraType = p62._savedCamType;
        end;

        if p62._savedCamFOV ~= nil then
            CurrentCamera.FieldOfView = p62._savedCamFOV;
        end;

        p62._savedCamType = nil;
        p62._savedCamCFrame = nil;
        p62._savedCamFOV = nil;
        p62._savedCamSubject = nil;
    end,

    _wireInput = function(u63) -- Line: 1042, Name: _wireInput
        -- upvalues: ContextActionService (copy), ReplicatedStorage (copy)
        ContextActionService:BindActionAtPriority("PdaToggle", function(p64, p65) -- Line: 1045
            -- upvalues: ReplicatedStorage (ref), u63 (copy)
            if p65 ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass;
            end;

            local success2, result2 = pcall(require, ReplicatedStorage:FindFirstChild("NpcInteractionController"));

            if success2 and (result2 and result2.IsOpen) then
                return Enum.ContextActionResult.Pass;
            end;

            local success3, result3 = pcall(require, ReplicatedStorage:FindFirstChild("TalkController"));

            if success3 and (result3 and result3.IsOpen) then
                return Enum.ContextActionResult.Pass;
            end;

            if u63.IsOpen then
                u63:Close();
            else
                u63:Open();
            end;

            return Enum.ContextActionResult.Sink;
        end, false, 200, Enum.KeyCode.P);
    end,

    Init = function(u66) -- Line: 1070, Name: Init
        -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy)
        if u66._initialized then
            return;
        end;

        u66._initialized = true;
        u66:_wireInput();

        local function watchCharacter(p67) -- Line: 1074
            -- upvalues: u66 (copy)
            if u66.IsOpen then
                u66:Close();
            end;

            p67.ChildAdded:Connect(function(p68) -- Line: 1078
                -- upvalues: u66 (ref)
                if p68:IsA("Tool") and u66.IsOpen then
                    if u66._openAt and tick() - u66._openAt < 0.6 then
                        return;
                    end;

                    u66:Close();
                end;
            end);
            local v69 = p67:FindFirstChildOfClass("Humanoid");

            if v69 then
                v69.Died:Connect(function() -- Line: 1089
                    -- upvalues: u66 (ref)
                    if u66.IsOpen then
                        u66:Close();
                    end;
                end);
            end;
        end;

        if LocalPlayer.Character then
            watchCharacter(LocalPlayer.Character);
        end;

        LocalPlayer.CharacterAdded:Connect(watchCharacter);
        task.spawn(function() -- Line: 1100
            -- upvalues: ReplicatedStorage (ref), u66 (copy)
            local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10);

            if not Remotes then
                return;
            end;

            local NpcInteractionRequested = Remotes:WaitForChild("NpcInteractionRequested", 10);

            if not NpcInteractionRequested then
                return;
            end;

            NpcInteractionRequested.OnClientEvent:Connect(function() -- Line: 1105
                -- upvalues: u66 (ref)
                if u66.IsOpen then
                    u66:Close();
                end;
            end);
        end);
        print("[PdaController] initialized");
    end
};