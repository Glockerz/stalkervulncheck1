-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = Workspace.CurrentCamera;
local UITheme = require(ReplicatedStorage:WaitForChild("InventoryController"):WaitForChild("UITheme"));
local C = UITheme.C;
local HEADER_FONT = UITheme.HEADER_FONT;
local BODY_FONT = UITheme.BODY_FONT;
local BODY_FONT_BOLD = UITheme.BODY_FONT_BOLD;
local Color3_fromRGB_ret = Color3.fromRGB(20, 18, 15);
local Color3_fromRGB_ret2 = Color3.fromRGB(96, 34, 28);
local Color3_fromRGB_ret3 = Color3.fromRGB(120, 200, 110);
local TimeLimit = require(ReplicatedStorage:WaitForChild("TaskController"):WaitForChild("TimeLimit"));
local u1 = nil;
local u2 = nil;

local function requestWithTimeout(u3, p4) -- Line: 44
    -- upvalues: u2 (ref)
    local u5 = false;
    local u6 = nil;
    local u7 = nil;
    task.spawn(function() -- Line: 46
        -- upvalues: u6 (ref), u7 (ref), u2 (ref), u3 (copy), u5 (ref)
        local success, result = pcall(function() -- Line: 47
            -- upvalues: u2 (ref), u3 (ref)
            return u2:RequestOffers(u3);
        end);
        u6 = success;
        u7 = result;
        u5 = true;
    end);
    local os_clock_ret = os.clock();

    while not u5 and os.clock() - os_clock_ret < p4 do
        task.wait(0.1);
    end;

    if u5 then
        return u6, u7;
    end;

    return false, ("no answer after %d s"):format(p4);
end;

local StoryRules = require(ReplicatedStorage:WaitForChild("StoryRules"));

return {
    IsOpen = false,
    CurrentNPC = nil,
    CurrentProfile = nil,
    _savedCamType = nil,
    _savedCamCFrame = nil,
    _savedCamFOV = nil,
    _activeTween = nil,
    _savedWalkSpeed = nil,
    _savedJumpPower = nil,
    _savedJumpHeight = nil,
    _sphCharacterClient = nil,
    _freezeBound = nil,
    _savedTransparencies = nil,
    _savedAutoRotate = nil,
    _lockedCameraCFrame = nil,
    _savedCamSubject = nil,
    _savedMouseBehavior = nil,
    _savedMouseIconEnabled = nil,
    _hiddenPrompts = nil,
    _savedCameraMode = nil,
    _savedCameraMinZoom = nil,
    _savedCameraMaxZoom = nil,
    _savedControls = nil,

    Init = function(p8) -- Line: 83, Name: Init
        if p8.Gui then
            return;
        end;

        p8:_buildGui();
        p8:_wireRemotes();
        p8:_wireInput();
        p8:_wireDeathClose();
        p8.Gui.Enabled = false;
        print("[NpcInteractionController] initialized");
    end,

    _buildGui = function(u9) -- Line: 93, Name: _buildGui
        -- upvalues: LocalPlayer (copy), C (copy), HEADER_FONT (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), BODY_FONT_BOLD (copy)
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = "NpcInteractionGui";
        ScreenGui.ResetOnSpawn = false;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ScreenGui.DisplayOrder = 4;
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
        local Frame = Instance.new("Frame");
        Frame.Name = "MainFrame";
        Frame.Size = UDim2.fromScale(0.25, 0.2);
        Frame.AnchorPoint = Vector2.new(0.5, 1);
        Frame.Position = UDim2.fromScale(0.5, 0.85);
        Frame.BackgroundTransparency = 1;
        Frame.BorderSizePixel = 0;
        Frame.Parent = ScreenGui;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "NpcName";
        TextLabel.Size = UDim2.fromScale(1, 0.25);
        TextLabel.Position = UDim2.fromScale(0, 0);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.TextColor3 = C.paper;
        TextLabel.TextScaled = false;
        TextLabel.TextSize = 26;
        TextLabel.FontFace = HEADER_FONT;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
        TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel.Text = "NPC";
        TextLabel.Parent = Frame;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(0, 0, 0);
        UIStroke.Transparency = 0.5;
        UIStroke.Thickness = 1;
        UIStroke.Parent = TextLabel;
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "ButtonRow";
        Frame2.Size = UDim2.fromScale(1, 0.35);
        Frame2.Position = UDim2.fromScale(0, 0.27);
        Frame2.BackgroundTransparency = 1;
        Frame2.BorderSizePixel = 0;
        Frame2.Parent = Frame;
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
        UIListLayout.Padding = UDim.new(0.06, 0);
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout.Parent = Frame2;

        local function makeButton(p10, p11, p12, p13, p14, p15, p16) -- Line: 147
            -- upvalues: C (ref), Frame2 (copy), HEADER_FONT (ref)
            local TextButton = Instance.new("TextButton");
            TextButton.Name = p10;
            TextButton.Size = UDim2.fromScale(p15 or 0.47, 1);
            TextButton.BackgroundColor3 = C.panel;
            TextButton.BackgroundTransparency = 0;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = "";
            TextButton.AutoButtonColor = false;
            TextButton.LayoutOrder = p12;
            TextButton.Parent = p14 or Frame2;
            local UIGradient = Instance.new("UIGradient");
            UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 186, 178)) });
            UIGradient.Rotation = -90;
            UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.04), NumberSequenceKeypoint.new(1, 0.12) });
            UIGradient.Parent = TextButton;
            local UIStroke2 = Instance.new("UIStroke");
            UIStroke2.Color = C.edge;
            UIStroke2.Transparency = 0;
            UIStroke2.Thickness = 1;
            UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            UIStroke2.Parent = TextButton;
            local Frame3 = Instance.new("Frame");
            Frame3.Name = "Accent";
            Frame3.Size = UDim2.new(1, 0, 0, 3);
            Frame3.Position = UDim2.new(0, 0, 1, -3);
            Frame3.BackgroundColor3 = p13;
            Frame3.BackgroundTransparency = 0;
            Frame3.BorderSizePixel = 0;
            Frame3.Parent = TextButton;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Label";
            TextLabel2.Size = UDim2.fromScale(1, 1);
            TextLabel2.Position = UDim2.fromScale(0, 0);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.Text = p11;
            TextLabel2.TextColor3 = p16 or C.paper;
            TextLabel2.TextSize = 22;
            TextLabel2.FontFace = HEADER_FONT;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Center;
            TextLabel2.TextYAlignment = Enum.TextYAlignment.Center;
            TextLabel2.Parent = TextButton;
            local UIStroke3 = Instance.new("UIStroke");
            UIStroke3.Color = Color3.fromRGB(0, 0, 0);
            UIStroke3.Thickness = 1.5;
            UIStroke3.Transparency = 0.3;
            UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke3.Parent = TextLabel2;
            local BackgroundColor3 = TextButton.BackgroundColor3;
            TextButton.MouseEnter:Connect(function() -- Line: 204
                -- upvalues: TextButton (copy), BackgroundColor3 (copy)
                TextButton.BackgroundColor3 = BackgroundColor3:Lerp(Color3.fromRGB(255, 255, 255), 0.12);
            end);
            TextButton.MouseLeave:Connect(function() -- Line: 207
                -- upvalues: TextButton (copy), BackgroundColor3 (copy)
                TextButton.BackgroundColor3 = BackgroundColor3;
            end);

            return TextButton;
        end;

        local v17 = makeButton("TalkButton", "TALK", 1, C.paper);
        local v18 = makeButton("TradeButton", "TRADE", 2, C.amber);
        local v19 = makeButton("WorkButton", "WORK", 3, Color3_fromRGB_ret3);
        v19.Visible = false;
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "ExitRow";
        Frame3.Size = UDim2.fromScale(1, 0.22);
        Frame3.Position = UDim2.fromScale(0, 0.72);
        Frame3.BackgroundTransparency = 1;
        Frame3.BorderSizePixel = 0;
        Frame3.Parent = Frame;
        local v20 = makeButton("ExitButton", "EXIT", 1, C.blood, Frame3, 0.6, Color3.fromRGB(225, 120, 105));
        v20.AnchorPoint = Vector2.new(0.5, 0);
        v20.Position = UDim2.fromScale(0.5, 0);
        local Frame4 = Instance.new("Frame");
        Frame4.Name = "WorkPanel";
        Frame4.Size = UDim2.fromScale(0.32, 0.55);
        Frame4.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame4.Position = UDim2.fromScale(0.5, 0.45);
        Frame4.BackgroundColor3 = C.panel;
        Frame4.BackgroundTransparency = 0;
        Frame4.BorderSizePixel = 0;
        Frame4.Visible = false;
        Frame4.ZIndex = 10;
        Frame4.Parent = ScreenGui;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 186, 178)) });
        UIGradient.Rotation = -90;
        UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.04), NumberSequenceKeypoint.new(1, 0.12) });
        UIGradient.Parent = Frame4;
        local UIStroke2 = Instance.new("UIStroke");
        UIStroke2.Color = C.edge;
        UIStroke2.Thickness = 1;
        UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke2.Parent = Frame4;
        local UIPadding = Instance.new("UIPadding");
        UIPadding.PaddingTop = UDim.new(0, 12);
        UIPadding.PaddingBottom = UDim.new(0, 12);
        UIPadding.PaddingLeft = UDim.new(0, 14);
        UIPadding.PaddingRight = UDim.new(0, 14);
        UIPadding.Parent = Frame4;
        local Frame5 = Instance.new("Frame");
        Frame5.Name = "Inner";
        Frame5.Position = UDim2.fromOffset(-8, -6);
        Frame5.Size = UDim2.new(1, 16, 1, 12);
        Frame5.BackgroundTransparency = 1;
        Frame5.BorderSizePixel = 0;
        Frame5.Active = false;
        Frame5.ZIndex = 10;
        Frame5.Parent = Frame4;
        local UIStroke3 = Instance.new("UIStroke");
        UIStroke3.Color = C.inner;
        UIStroke3.Thickness = 1;
        UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke3.Parent = Frame5;
        local Frame6 = Instance.new("Frame");
        Frame6.Name = "TitleRow";
        Frame6.Size = UDim2.new(1, 0, 0, 34);
        Frame6.Position = UDim2.fromOffset(0, 0);
        Frame6.BackgroundTransparency = 1;
        Frame6.BorderSizePixel = 0;
        Frame6.ZIndex = 10;
        Frame6.Parent = Frame4;
        local Frame7 = Instance.new("Frame");
        Frame7.Name = "Mark";
        Frame7.Size = UDim2.fromOffset(3, 24);
        Frame7.Position = UDim2.fromOffset(0, 5);
        Frame7.BackgroundColor3 = C.amber;
        Frame7.BorderSizePixel = 0;
        Frame7.ZIndex = 10;
        Frame7.Parent = Frame6;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = "Title";
        TextLabel2.Size = UDim2.new(1, -52, 1, 0);
        TextLabel2.Position = UDim2.fromOffset(12, 0);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.Text = "AVAILABLE WORK";
        TextLabel2.TextColor3 = C.paper;
        TextLabel2.TextSize = 24;
        TextLabel2.FontFace = HEADER_FONT;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel2.ZIndex = 10;
        TextLabel2.Parent = Frame6;
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "CloseBtn";
        TextButton.Size = UDim2.fromOffset(32, 30);
        TextButton.AnchorPoint = Vector2.new(1, 0);
        TextButton.Position = UDim2.new(1, 0, 0, 2);
        TextButton.BackgroundColor3 = Color3_fromRGB_ret2;
        TextButton.BackgroundTransparency = 0;
        TextButton.BorderSizePixel = 0;
        TextButton.Text = "X";
        TextButton.TextColor3 = C.paper;
        TextButton.TextSize = 16;
        TextButton.FontFace = BODY_FONT_BOLD;
        TextButton.ZIndex = 10;
        TextButton.Parent = Frame6;
        local Frame8 = Instance.new("Frame");
        Frame8.Name = "Divider";
        Frame8.Size = UDim2.new(1, 0, 0, 1);
        Frame8.Position = UDim2.fromOffset(0, 42);
        Frame8.BackgroundColor3 = C.line;
        Frame8.BackgroundTransparency = 0;
        Frame8.BorderSizePixel = 0;
        Frame8.ZIndex = 10;
        Frame8.Parent = Frame4;
        local Frame9 = Instance.new("Frame");
        Frame9.Name = "Tabs";
        Frame9.Size = UDim2.new(1, 0, 0, 30);
        Frame9.Position = UDim2.fromOffset(0, 50);
        Frame9.BackgroundTransparency = 1;
        Frame9.ZIndex = 10;
        Frame9.Parent = Frame4;
        local UIListLayout2 = Instance.new("UIListLayout");
        UIListLayout2.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout2.Padding = UDim.new(0, 6);
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout2.Parent = Frame9;

        local function makeTab(p21, p22, p23) -- Line: 360
            -- upvalues: C (ref), HEADER_FONT (ref), Frame9 (copy)
            local TextButton2 = Instance.new("TextButton");
            TextButton2.Name = p21;
            TextButton2.Size = UDim2.fromOffset(124, 30);
            TextButton2.LayoutOrder = p23;
            TextButton2.BackgroundColor3 = C.row;
            TextButton2.BorderSizePixel = 0;
            TextButton2.AutoButtonColor = false;
            TextButton2.Text = p22;
            TextButton2.TextColor3 = C.dim;
            TextButton2.TextSize = 16;
            TextButton2.FontFace = HEADER_FONT;
            TextButton2.ZIndex = 11;
            TextButton2.Parent = Frame9;
            local UIStroke4 = Instance.new("UIStroke");
            UIStroke4.Name = "Edge";
            UIStroke4.Color = C.inner;
            UIStroke4.Thickness = 1;
            UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            UIStroke4.Parent = TextButton2;
            local Frame10 = Instance.new("Frame");
            Frame10.Name = "Underline";
            Frame10.AnchorPoint = Vector2.new(0.5, 1);
            Frame10.Size = UDim2.new(1, -20, 0, 2);
            Frame10.Position = UDim2.fromScale(0.5, 1);
            Frame10.BackgroundColor3 = C.amber;
            Frame10.BorderSizePixel = 0;
            Frame10.Visible = false;
            Frame10.ZIndex = 12;
            Frame10.Parent = TextButton2;

            return TextButton2;
        end;

        local v24 = makeTab("TabContracts", "CONTRACTS", 1);
        local v25 = makeTab("TabStory", "STORY", 2);
        local ScrollingFrame = Instance.new("ScrollingFrame");
        ScrollingFrame.Name = "OffersScroll";
        ScrollingFrame.Size = UDim2.new(1, 0, 1, -92);
        ScrollingFrame.Position = UDim2.fromOffset(0, 90);
        ScrollingFrame.BackgroundTransparency = 1;
        ScrollingFrame.BorderSizePixel = 0;
        ScrollingFrame.ScrollBarThickness = 4;
        ScrollingFrame.ScrollBarImageColor3 = C.edge;
        ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0);
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        ScrollingFrame.ZIndex = 10;
        ScrollingFrame.Parent = Frame4;
        local UIListLayout3 = Instance.new("UIListLayout");
        UIListLayout3.FillDirection = Enum.FillDirection.Vertical;
        UIListLayout3.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        UIListLayout3.Padding = UDim.new(0, 8);
        UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout3.Parent = ScrollingFrame;
        local UIPadding2 = Instance.new("UIPadding");
        UIPadding2.PaddingTop = UDim.new(0, 4);
        UIPadding2.PaddingBottom = UDim.new(0, 4);
        UIPadding2.Parent = ScrollingFrame;
        u9.Gui = ScreenGui;
        u9.MainFrame = Frame;
        u9.NpcName = TextLabel;
        u9.TalkBtn = v17;
        u9.TradeBtn = v18;
        u9.WorkBtn = v19;
        u9.ExitBtn = v20;
        u9.WorkPanel = Frame4;
        u9.WorkOffersScroll = ScrollingFrame;
        u9.WorkTabContracts = v24;
        u9.WorkTabStory = v25;
        u9._workTab = "contracts";
        v24.MouseButton1Click:Connect(function() -- Line: 432
            -- upvalues: u9 (copy)
            u9._workTab = "contracts";
            u9:OpenWorkPanel();
        end);
        v25.MouseButton1Click:Connect(function() -- Line: 436
            -- upvalues: u9 (copy)
            u9._workTab = "story";
            u9:OpenWorkPanel();
        end);
        u9._wpCloseBtn = TextButton;
    end,

    _wireRemotes = function(u26) -- Line: 443, Name: _wireRemotes
        -- upvalues: ReplicatedStorage (copy)
        local Remotes = ReplicatedStorage:WaitForChild("Remotes");
        local NpcInteractionRequested = Remotes:WaitForChild("NpcInteractionRequested");
        local OpenTraderFromMenu = Remotes:WaitForChild("OpenTraderFromMenu");
        local TraderClosed = Remotes:WaitForChild("TraderClosed");
        NpcInteractionRequested.OnClientEvent:Connect(function(p27, p28) -- Line: 449
            -- upvalues: u26 (copy)
            u26:Open(p27, p28);
        end);
        TraderClosed.OnClientEvent:Connect(function() -- Line: 453
            -- upvalues: u26 (copy)
            if u26.IsOpen then
                u26:Close();
            end;
        end);
        u26.TradeBtn.MouseButton1Click:Connect(function() -- Line: 459
            -- upvalues: u26 (copy), OpenTraderFromMenu (copy)
            if not u26.IsOpen then
                return;
            end;

            OpenTraderFromMenu:FireServer(u26.CurrentNPC);
            u26.Gui.Enabled = false;
        end);
        u26.TalkBtn.MouseButton1Click:Connect(function() -- Line: 465
            -- upvalues: u26 (copy), ReplicatedStorage (ref)
            if not u26.IsOpen then
                return;
            end;

            local success, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1));

            if success and result then
                result:Open(u26.CurrentNPC, u26.CurrentProfile);
                u26.Gui.Enabled = false;
            end;
        end);
        u26.ExitBtn.MouseButton1Click:Connect(function() -- Line: 474
            -- upvalues: u26 (copy)
            if not u26.IsOpen then
                return;
            end;

            u26:Close();
        end);
        u26.WorkBtn.MouseButton1Click:Connect(function() -- Line: 479
            -- upvalues: u26 (copy)
            if not u26.IsOpen then
                return;
            end;

            u26:OpenWorkPanel();
        end);
        u26._wpCloseBtn.MouseButton1Click:Connect(function() -- Line: 484
            -- upvalues: u26 (copy)
            if u26.WorkPanel then
                u26.WorkPanel.Visible = false;
            end;
        end);
    end,

    _wireInput = function(p29) -- Line: 491, Name: _wireInput
    end,

    Open = function(u30, u31, p32) -- Line: 494, Name: Open
        -- upvalues: LocalPlayer (copy), UserInputService (copy), RunService (copy), CurrentCamera (copy), StoryRules (copy), ContextActionService (copy)
        if u30.IsOpen then
            return;
        end;

        u30.IsOpen = true;
        local Character = LocalPlayer.Character;
        local v33;

        if Character then
            v33 = Character:FindFirstChildOfClass("Humanoid");
        else
            v33 = Character;
        end;

        if v33 then
            u30._savedWalkSpeed = v33.WalkSpeed;
            u30._savedJumpPower = v33.JumpPower;
            u30._savedJumpHeight = v33.JumpHeight;
            u30._savedAutoRotate = v33.AutoRotate;
            v33.WalkSpeed = 0;
            v33.JumpPower = 0;
            v33.JumpHeight = 0;
            v33.AutoRotate = false;
        end;

        local success, result = pcall(function() -- Line: 516
            -- upvalues: LocalPlayer (ref)
            return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
        end);

        if success and result then
            u30._savedControls = result;
            result:Disable();
        end;

        u30._savedMouseBehavior = UserInputService.MouseBehavior;
        u30._savedMouseIconEnabled = UserInputService.MouseIconEnabled;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        UserInputService.MouseIconEnabled = true;
        u30._savedCameraMode = LocalPlayer.CameraMode;
        u30._savedCameraMinZoom = LocalPlayer.CameraMinZoomDistance;
        u30._savedCameraMaxZoom = LocalPlayer.CameraMaxZoomDistance;
        LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
        LocalPlayer.CameraMinZoomDistance = 0;
        LocalPlayer.CameraMaxZoomDistance = 0;

        if Character then
            Character = Character:FindFirstChild("CharacterClient", true);
        end;

        if Character then
            Character:SetAttribute("SpeedCap_Dialogue", 0);
            u30._sphCharacterClient = Character;
        else
            warn("[NpcInteractionController] SPH CharacterClient not found; relying on RenderStepped freeze only");
        end;

        if not u30._freezeBound then
            u30._freezeBound = "NpcInteractionFreeze";
            RunService:BindToRenderStep(u30._freezeBound, Enum.RenderPriority.Camera.Value + 100, function() -- Line: 549
                -- upvalues: LocalPlayer (ref), CurrentCamera (ref), u30 (copy), UserInputService (ref)
                local Character2 = LocalPlayer.Character;

                if not Character2 then
                    return;
                end;

                local v34 = Character2:FindFirstChildOfClass("Humanoid");

                if v34 then
                    v34.WalkSpeed = 0;
                    v34.JumpPower = 0;
                    v34.JumpHeight = 0;
                    v34.AutoRotate = false;
                end;

                for _, descendant in ipairs(Character2:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        descendant.LocalTransparencyModifier = 1;
                    end;
                end;

                if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                end;

                if u30._lockedCameraCFrame then
                    CurrentCamera.CFrame = u30._lockedCameraCFrame;
                end;

                if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
                end;

                if not UserInputService.MouseIconEnabled then
                    UserInputService.MouseIconEnabled = true;
                end;
            end);
        end;

        if u31 then
            u30._hiddenPrompts = {};

            for _, descendant in ipairs(u31:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") and descendant.Enabled then
                    u30._hiddenPrompts[descendant] = true;
                    descendant.Enabled = false;
                end;
            end;
        end;

        u30.CurrentNPC = u31;
        u30.CurrentProfile = p32;
        local v35;

        if u31 then
            v35 = u31:GetAttribute("NpcType") == "Extractor";
        else
            v35 = u31;
        end;

        local v36 = LocalPlayer:GetAttribute("_TutorialPending") and not LocalPlayer:GetAttribute("_StarterPackGranted");

        if v36 then
            if u31 then
                v36 = u31.Name == "Crow";
            else
                v36 = u31;
            end;
        end;

        local v37;

        if u31 then
            v37 = u31:GetAttribute("NoTrade") == true;
        else
            v37 = u31;
        end;

        if u30.TradeBtn then
            u30.TradeBtn.Visible = not v35 and (not v36 and not v37);
        end;

        if u30.WorkBtn then
            u30.WorkBtn.Visible = false;

            if not (v35 or v36) then
                task.spawn(function() -- Line: 623
                    -- upvalues: u31 (copy), StoryRules (ref), u30 (copy)
                    local TaskController = require(game:GetService("ReplicatedStorage"):WaitForChild("TaskController"));
                    local v38 = TaskController:RequestOffers(u31) or {};
                    local v39 = v38.offers and #v38.offers > 0;
                    local v40 = v38.cooldown_until ~= nil;
                    local v41 = false;

                    for _, v in ipairs(TaskController:GetActiveTasks()) do
                        local v42;

                        if v.type == "delivery" then
                            v42 = v.params and v.params.destination_npc == u31.Name;
                        else
                            v42 = v.giver and v.giver.npcId == u31.Name;
                        end;

                        if v42 then
                            v41 = true;
                            break;
                        end;
                    end;

                    local v43 = false;

                    if TaskController.GetMain then
                        local Main = TaskController:GetMain();

                        if StoryRules.StoryRole(Main, u31.Name) then
                            v43 = Main.active ~= nil and true or (#(Main.available or {}) > 0 and true or Main.nextRequirement ~= nil);
                        end;
                    end;

                    if (v39 or (v40 or (v41 or v43))) and (u30.CurrentNPC == u31 and u30.WorkBtn) then
                        u30.WorkBtn.Visible = true;
                    end;
                end);
            end;
        end;

        if u30.WorkPanel then
            u30.WorkPanel.Visible = false;
        end;

        u30.NpcName.Text = string.upper(p32 and p32.DisplayName or (u31 and (u31.Name or "NPC") or "NPC"));
        u30:_startCinematicCamera(u31);
        u30.Gui.Enabled = true;
        ContextActionService:BindActionAtPriority("NpcInteractionClose", function(p44, p45) -- Line: 676
            -- upvalues: u30 (copy)
            if p45 ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass;
            end;

            u30:Close();

            return Enum.ContextActionResult.Sink;
        end, false, 200, Enum.KeyCode.Q);
    end,

    _mainSig = function(p46, p47) -- Line: 699, Name: _mainSig
        -- upvalues: u2 (ref), StoryRules (copy)
        if not (u2 and u2.GetMain) then
            return "|mt:";
        end;

        local Main = u2:GetMain();

        if not StoryRules.StoryRole(Main, p47) then
            return "|mt:";
        end;

        local active = Main.active;

        if active then
            return active.stageKind ~= "turn_in" and "|mt:active" or "|mt:" .. tostring(active.id) .. ":t";
        end;

        local v48 = {};

        for _, v in ipairs(Main.available or {}) do
            local v49 = tostring(v.id);
            table.insert(v48, v49);
        end;

        table.sort(v48);

        return "|mt:" .. table.concat(v48, ",") .. ":o:" .. tostring(Main.sideDone or 0);
    end,

    _workOffersSig = function(p50) -- Line: 730, Name: _workOffersSig
        -- upvalues: u2 (ref)
        if not u2 then
            return "";
        end;

        local v51 = u2:RequestOffers(p50.CurrentNPC) or {};
        local v52 = {};

        for _, v in ipairs(v51.offers or {}) do
            v52[#v52 + 1] = tostring(v.id);
        end;

        table.sort(v52);
        local table_concat_ret = table.concat(v52, ",");
        local v53 = tostring(v51.refresh_at or "");

        return table_concat_ret .. "|rf:" .. v53 .. p50:_mainSig(p50.CurrentNPC and p50.CurrentNPC.Name);
    end,

    OpenWorkPanel = function(u54) -- Line: 740, Name: OpenWorkPanel
        -- upvalues: u2 (ref), ReplicatedStorage (copy), C (copy), BODY_FONT_BOLD (copy), StoryRules (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), BODY_FONT (copy), requestWithTimeout (copy), HEADER_FONT (copy), TimeLimit (copy)
        local v55 = u2;

        if not v55 then
            local v56;
            v56, v55 = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3));

            if not (v56 and v55) then
                warn("[NpcInteractionController] TaskController not found");
                v55 = nil;
            end;
        end;

        u2 = v55;

        if not u2 then
            return;
        end;

        local WorkOffersScroll = u54.WorkOffersScroll;

        if not WorkOffersScroll then
            return;
        end;

        for _, child in ipairs(WorkOffersScroll:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextLabel") then
                child:Destroy();
            end;
        end;

        u54.WorkPanel.Visible = true;
        local CurrentNPC = u54.CurrentNPC;
        local u57;

        if CurrentNPC then
            u57 = CurrentNPC.Name;
        else
            u57 = CurrentNPC;
        end;

        local function sectionLabel(p58) -- Line: 764
            -- upvalues: C (ref), BODY_FONT_BOLD (ref), WorkOffersScroll (copy)
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Size = UDim2.new(1, 0, 0, 16);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.Text = p58;
            TextLabel.TextColor3 = C.dim;
            TextLabel.TextSize = 11;
            TextLabel.FontFace = BODY_FONT_BOLD;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.ZIndex = 11;
            TextLabel.Parent = WorkOffersScroll;
        end;

        local function isForThisNpc(p59) -- Line: 786
            -- upvalues: u57 (copy)
            if p59.type == "delivery" then
                return p59.params and p59.params.destination_npc == u57;
            end;

            return p59.giver and p59.giver.npcId == u57;
        end;

        local function objectivesDone(p60) -- Line: 778
            for _, v in ipairs(p60.objectives or {}) do
                if v.id ~= "return" and (v.id ~= "deliver" and not v.complete) then
                    return false;
                end;
            end;

            return true;
        end;

        local v61 = {};

        for _, v in ipairs(u2:GetActiveTasks()) do
            local v62;

            if v.type == "delivery" then
                v62 = v.params and v.params.destination_npc == u57;
            else
                v62 = v.giver and v.giver.npcId == u57;
            end;

            if v62 and (objectivesDone(v) and not v.shared_from) then
                table.insert(v61, v);
            end;
        end;

        local v63 = u2.GetMain and u2:GetMain() or nil;
        local v64 = StoryRules.StoryRole(v63, u57);
        local v65 = v64 ~= nil;
        local v66 = nil;
        local v67 = nil;
        local v68 = {};

        if v65 then
            local active = v63.active;

            if active and active.stageKind == "turn_in" then
                if StoryRules.TurnInHere(v63, u57) then
                    v66 = active;
                end;
            elseif not active and v64 == "ladder" then
                v67 = (v63.available or {})[1];

                for _, v in ipairs(v63.available or {}) do
                    v68[v.id] = v;
                end;
            end;
        end;

        local u69 = v63 and (v63.sideDone or 0) or 0;

        local function coolTime(p70) -- Line: 848
            local v71 = tonumber(p70) or 0;
            local math_floor_ret = math.floor(v71);
            local math_max_ret = math.max(0, math_floor_ret);
            local math_floor_ret2 = math.floor(math_max_ret / 3600);
            local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);

            if math_floor_ret2 > 0 then
                return string.format("%dh %02dm", math_floor_ret2, math_floor_ret3);
            end;

            if math_floor_ret3 > 0 then
                return string.format("%dm", math_floor_ret3);
            end;

            return string.format("%ds", math_max_ret);
        end;

        local function buildStoryCard(u72, u73) -- Line: 859
            -- upvalues: C (ref), WorkOffersScroll (copy), Color3_fromRGB_ret3 (ref), Color3_fromRGB_ret (ref), BODY_FONT_BOLD (ref), coolTime (copy), u69 (copy), BODY_FONT (ref), ReplicatedStorage (ref), u54 (copy), u2 (ref)
            local v74 = u73 == "turnin" and true or u73 == "offer";
            local v75;

            if u73 == "offer" then
                v75 = u72.vouchedBy or nil;
            else
                v75 = nil;
            end;

            local Frame = Instance.new("Frame");
            Frame.Size = UDim2.new(1, 0, 0, v75 and 116 or 96);
            Frame.BackgroundColor3 = v74 and Color3.fromRGB(46, 42, 34) or C.row;
            Frame.BackgroundTransparency = v74 and 0.15 or 0.45;
            Frame.BorderSizePixel = 0;
            Frame.ZIndex = 11;
            Frame.Parent = WorkOffersScroll;
            local Frame2 = Instance.new("Frame");
            Frame2.Size = UDim2.new(0, 3, 1, 0);
            Frame2.BackgroundColor3 = (u73 == "done" or (u73 == "cooldown" or u73 == "ready")) and Color3_fromRGB_ret3 or (v74 and C.amber or C.faint);
            Frame2.BorderSizePixel = 0;
            Frame2.ZIndex = 12;
            Frame2.Parent = Frame;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Size = UDim2.fromOffset(52, 16);
            TextLabel.Position = UDim2.fromOffset(12, 8);
            TextLabel.BackgroundColor3 = (u73 == "done" or (u73 == "cooldown" or u73 == "ready")) and Color3_fromRGB_ret3 or (v74 and C.amber or C.faint);
            TextLabel.BorderSizePixel = 0;
            TextLabel.Text = "STORY";
            TextLabel.TextColor3 = Color3_fromRGB_ret;
            TextLabel.TextSize = 11;
            TextLabel.FontFace = BODY_FONT_BOLD;
            TextLabel.ZIndex = 12;
            TextLabel.Parent = Frame;

            if u72.unlocks then
                local TextLabel2 = Instance.new("TextLabel");
                TextLabel2.Size = UDim2.new(1, -82, 0, 16);
                TextLabel2.Position = UDim2.fromOffset(70, 8);
                TextLabel2.BackgroundTransparency = 1;
                TextLabel2.Text = "MAP UNLOCK: " .. u72.unlocks;
                TextLabel2.TextColor3 = C.amber;
                TextLabel2.TextSize = 11;
                TextLabel2.FontFace = BODY_FONT_BOLD;
                TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel2.ZIndex = 12;
                TextLabel2.Parent = Frame;
            end;

            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Position = UDim2.fromOffset(12, 28);
            TextLabel2.Size = UDim2.new(1, -120, 0, 20);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.Text = u72.title or "Story task";
            TextLabel2.TextColor3 = v74 and C.paper or C.dim;
            TextLabel2.TextSize = 15;
            TextLabel2.FontFace = BODY_FONT_BOLD;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
            TextLabel2.ZIndex = 12;
            TextLabel2.Parent = Frame;
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Position = UDim2.fromOffset(12, 48);
            TextLabel3.Size = UDim2.new(1, -120, 0, v75 and 60 or 40);
            TextLabel3.BackgroundTransparency = 1;

            if u73 == "turnin" then
                TextLabel3.Text = (u72.turnInGiver or "Crow") .. " is waiting on this.";
            elseif u73 == "active" then
                TextLabel3.Text = "In progress.";
            elseif u73 == "done" then
                TextLabel3.Text = "Done.";
            elseif u73 == "cooldown" then
                TextLabel3.Text = "Crow has nothing new here.\nAgain in " .. coolTime(u72.cooldownLeft);
            elseif u73 == "ready" then
                TextLabel3.Text = "Ready to run again.";
            elseif u73 == "locked" then
                if u72.blockedBy and u69 >= (u72.requiresSideTasks or 0) then
                    TextLabel3.Text = "Finish " .. u72.blockedBy .. " first.";
                else
                    TextLabel3.Text = string.format("Contracts for Crow: %d / %d", u69, u72.requiresSideTasks or 0);
                end;
            else
                TextLabel3.Text = (v75 and v75 .. " is working this one. Crow will hear you out.\n" or "") .. (u72.summary or "");
            end;

            TextLabel3.TextColor3 = C.text;
            TextLabel3.TextSize = 13;
            TextLabel3.FontFace = BODY_FONT;
            TextLabel3.TextWrapped = true;
            TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel3.TextYAlignment = Enum.TextYAlignment.Top;
            TextLabel3.ZIndex = 12;
            TextLabel3.Parent = Frame;

            if not v74 then
                return;
            end;

            local TextButton = Instance.new("TextButton");
            TextButton.AnchorPoint = Vector2.new(1, 0.5);
            TextButton.Position = UDim2.new(1, -8, 0.5, 0);
            TextButton.Size = UDim2.fromOffset(92, 34);
            TextButton.BackgroundColor3 = u73 == "turnin" and Color3_fromRGB_ret3 or C.amber;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = u73 == "turnin" and "TURN IN" or (u72.replay and "RUN AGAIN" or "ACCEPT");
            TextButton.TextColor3 = Color3_fromRGB_ret;
            TextButton.TextSize = 14;
            TextButton.FontFace = BODY_FONT_BOLD;
            TextButton.ZIndex = 12;
            TextButton.Parent = Frame;
            TextButton.MouseButton1Click:Connect(function() -- Line: 980
                -- upvalues: u73 (copy), ReplicatedStorage (ref), u72 (copy), u54 (ref), u2 (ref), TextButton (copy)
                if u73 == "turnin" then
                    local success, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1));

                    if type(u72.turnIn) == "table" and (success and (result and result.OpenTurnIn)) then
                        u54.WorkPanel.Visible = false;

                        if not result:OpenTurnIn(u54.CurrentNPC, u54.CurrentProfile, {
                            id = u72.id,
                            intro = u72.turnIn.intro,
                            topics = u72.turnIn.topics,
                            accept = u72.turnIn.accept,
                            decline = u72.turnIn.decline,
                            afterTopics = u72.turnIn.afterTopics,
                            close = u72.turnIn.close,
                            rewards = {
                                money = u72.reward and u72.reward.money or 0
                            },

                            onTurnIn = function() -- Line: 999, Name: onTurnIn
                                -- upvalues: u2 (ref), u54 (ref)
                                return u2:TurnInMain(u54.CurrentNPC);
                            end
                        }) then
                            u54:OpenWorkPanel();
                        end;

                        return;
                    end;

                    TextButton.Active = false;
                    TextButton.Text = "...";
                    local v76, v77, v78 = u2:TurnInMain(u54.CurrentNPC);

                    if v76 then
                        local success2, result2 = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1));

                        if not (v78 and (success2 and (result2 and result2.SayLine))) then
                            u54:OpenWorkPanel();

                            return;
                        end;

                        u54.WorkPanel.Visible = false;

                        if not result2:SayLine(u54.CurrentNPC, u54.CurrentProfile, v78) then
                            u54:OpenWorkPanel();

                            return;
                        end;
                    else
                        TextButton.Text = "TURN IN";
                        TextButton.Active = true;
                        u2:ShowToast(({
                            missing_item = "You don\'t have what Crow\'s waiting for",
                            not_ready = "That\'s not finished yet",
                            wrong_place = "Not here. That\'s Zone business.",
                            wrong_npc = "He\'s not the one waiting on this."
                        })[v77] or "Couldn\'t do that right now");
                    end;

                    return;
                end;

                local success, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1));

                if success and result then
                    local v79 = u72.reward and u72.reward.money or 0;
                    local v80 = u72.reward and u72.reward.rep;

                    local function v81() -- Line: 1048
                        -- upvalues: u2 (ref), u72 (ref)
                        return u2:AcceptMain(u72.id);
                    end;

                    if type(u72.briefing) == "table" and result.OpenBriefingTopics then
                        u54.WorkPanel.Visible = false;
                        result:OpenBriefingTopics(u54.CurrentNPC, u54.CurrentProfile, {
                            id = u72.id,
                            intro = u72.briefing.intro,
                            topics = u72.briefing.topics,
                            accept = u72.briefing.accept,
                            decline = u72.briefing.decline,
                            rewards = {
                                money = v79,
                                rep = v80
                            },
                            onTake = v81
                        });

                        return;
                    end;

                    if result.OpenBriefing then
                        u54.WorkPanel.Visible = false;
                        result:OpenBriefing(u54.CurrentNPC, u54.CurrentProfile, {
                            id = u72.id,
                            briefing = type(u72.briefing) == "string" and u72.briefing or u72.summary,
                            rewards = {
                                money = v79
                            },
                            onTake = v81
                        });

                        return;
                    end;
                end;

                TextButton.Active = false;
                TextButton.Text = "...";
                local v82, v83 = u2:AcceptMain(u72.id);

                if v82 then
                    u54:OpenWorkPanel();

                    return;
                end;

                TextButton.Text = "ACCEPT";
                TextButton.Active = true;
                u2:ShowToast(({
                    locked = "Crow doesn\'t trust you with that yet",
                    already_active = "Finish what you\'re already carrying first",
                    wrong_place = "Not here. That\'s Zone business."
                })[v83] or "Couldn\'t do that right now");
            end);
        end;

        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.new(1, 0, 0, 48);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = "Loading contracts...";
        TextLabel.TextColor3 = C.dim;
        TextLabel.TextSize = 13;
        TextLabel.FontFace = BODY_FONT;
        TextLabel.ZIndex = 11;
        TextLabel.Parent = WorkOffersScroll;
        local v84, v85 = requestWithTimeout(CurrentNPC, 10);

        if TextLabel.Parent then
            TextLabel:Destroy();
        end;

        local v86 = not v84;

        if v86 then
            warn("[NpcInteractionController] RequestOffers failed:", v85);
        end;

        local v87 = v84 and v85 and v85 or {};
        local v88 = v87.offers or {};
        local refresh_at = v87.refresh_at;

        local function buildOfferCard(p89, u90) -- Line: 1120
            -- upvalues: C (ref), HEADER_FONT (ref), BODY_FONT (ref), BODY_FONT_BOLD (ref), TimeLimit (ref), Color3_fromRGB_ret (ref), ReplicatedStorage (ref), u54 (copy), u2 (ref)
            local Frame = Instance.new("Frame");
            Frame.Size = UDim2.new(1, 0, 0, 88);
            Frame.BackgroundColor3 = C.row;
            Frame.BackgroundTransparency = 0.2;
            Frame.BorderSizePixel = 0;
            Frame.ZIndex = 11;
            Frame.Parent = p89;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Color = C.inner;
            UIStroke.Thickness = 1;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            UIStroke.Parent = Frame;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Position = UDim2.fromOffset(10, 4);
            TextLabel2.Size = UDim2.new(1, -110, 0, 22);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = HEADER_FONT;
            TextLabel2.TextSize = 18;
            TextLabel2.TextColor3 = C.paper;
            TextLabel2.Text = u90.title or "Task";
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.ZIndex = 11;
            TextLabel2.Parent = Frame;
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Position = UDim2.fromOffset(10, 26);
            TextLabel3.Size = UDim2.new(1, -110, 0, 26);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.FontFace = BODY_FONT;
            TextLabel3.TextSize = 14;
            TextLabel3.TextColor3 = C.text;
            TextLabel3.Text = u90.description or "";
            TextLabel3.TextWrapped = true;
            TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel3.TextYAlignment = Enum.TextYAlignment.Top;
            TextLabel3.ZIndex = 11;
            TextLabel3.Parent = Frame;
            local TextLabel4 = Instance.new("TextLabel");
            TextLabel4.Position = UDim2.fromOffset(10, 58);
            TextLabel4.Size = UDim2.new(1, -110, 0, 20);
            TextLabel4.BackgroundTransparency = 1;
            TextLabel4.FontFace = BODY_FONT;
            TextLabel4.TextSize = 14;
            TextLabel4.TextColor3 = C.money;
            TextLabel4.Text = string.format("Reward: %d₽  +%d %s rep", u90.rewards and (u90.rewards.money or 0) or 0, u90.rewards and u90.rewards.rep and (u90.rewards.rep.amount or 0) or 0, u90.rewards and u90.rewards.rep and (u90.rewards.rep.faction or "?") or "?");
            TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel4.ZIndex = 11;
            TextLabel4.Parent = Frame;
            local TextLabel5 = Instance.new("TextLabel");
            TextLabel5.Name = "TimeLimit";
            TextLabel5.Position = UDim2.fromOffset(10, 58);
            TextLabel5.Size = UDim2.new(1, -110, 0, 20);
            TextLabel5.BackgroundTransparency = 1;
            TextLabel5.FontFace = BODY_FONT_BOLD;
            TextLabel5.TextSize = 14;
            TextLabel5.TextColor3 = C.dim;
            TextLabel5.Text = TimeLimit.Label(u90);
            TextLabel5.TextXAlignment = Enum.TextXAlignment.Right;
            TextLabel5.ZIndex = 11;
            TextLabel5.Parent = Frame;
            local TextButton = Instance.new("TextButton");
            TextButton.AnchorPoint = Vector2.new(1, 0.5);
            TextButton.Position = UDim2.new(1, -8, 0.5, 0);
            TextButton.Size = UDim2.fromOffset(88, 34);
            TextButton.BackgroundColor3 = C.amber;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = "INQUIRE";
            TextButton.FontFace = HEADER_FONT;
            TextButton.TextSize = 17;
            TextButton.TextColor3 = Color3_fromRGB_ret;
            TextButton.AutoButtonColor = true;
            TextButton.ZIndex = 11;
            TextButton.Parent = Frame;
            TextButton.MouseButton1Click:Connect(function() -- Line: 1205
                -- upvalues: ReplicatedStorage (ref), u54 (ref), u90 (copy), u2 (ref)
                local success, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1));

                if not (success and (result and result.OpenBriefing)) then
                    u2:ShowToast("Can\'t open the briefing right now");
                    warn("[NpcInteractionController] TalkController:OpenBriefing unavailable");

                    return;
                end;

                u54.WorkPanel.Visible = false;
                result:OpenBriefing(u54.CurrentNPC, u54.CurrentProfile, u90);
                u54.Gui.Enabled = false;
            end);

            return Frame;
        end;

        local function buildTurnInCard(u91) -- Line: 1222
            -- upvalues: WorkOffersScroll (copy), Color3_fromRGB_ret3 (ref), HEADER_FONT (ref), C (ref), BODY_FONT (ref), Color3_fromRGB_ret (ref), u2 (ref), u57 (copy), CurrentNPC (copy), u54 (copy)
            local Frame = Instance.new("Frame");
            Frame.Size = UDim2.new(1, 0, 0, 88);
            Frame.BackgroundColor3 = Color3.fromRGB(34, 48, 34);
            Frame.BackgroundTransparency = 0.15;
            Frame.BorderSizePixel = 0;
            Frame.ZIndex = 11;
            Frame.Parent = WorkOffersScroll;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Color = Color3_fromRGB_ret3;
            UIStroke.Thickness = 1;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            UIStroke.Parent = Frame;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Position = UDim2.fromOffset(10, 4);
            TextLabel2.Size = UDim2.new(1, -110, 0, 22);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = HEADER_FONT;
            TextLabel2.TextSize = 18;
            TextLabel2.TextColor3 = C.paper;
            TextLabel2.Text = u91.title or "Task";
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.ZIndex = 11;
            TextLabel2.Parent = Frame;
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Position = UDim2.fromOffset(10, 28);
            TextLabel3.Size = UDim2.new(1, -110, 0, 26);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.FontFace = BODY_FONT;
            TextLabel3.TextSize = 14;
            TextLabel3.TextColor3 = Color3.fromRGB(150, 210, 140);
            TextLabel3.Text = "Objectives complete. Ready to turn in.";
            TextLabel3.TextWrapped = true;
            TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel3.TextYAlignment = Enum.TextYAlignment.Top;
            TextLabel3.ZIndex = 11;
            TextLabel3.Parent = Frame;
            local TextLabel4 = Instance.new("TextLabel");
            TextLabel4.Position = UDim2.fromOffset(10, 58);
            TextLabel4.Size = UDim2.new(1, -110, 0, 20);
            TextLabel4.BackgroundTransparency = 1;
            TextLabel4.FontFace = BODY_FONT;
            TextLabel4.TextSize = 14;
            TextLabel4.TextColor3 = C.money;
            TextLabel4.Text = string.format("Reward: %d₽  +%d %s rep", u91.rewards and (u91.rewards.money or 0) or 0, u91.rewards and u91.rewards.rep and (u91.rewards.rep.amount or 0) or 0, u91.rewards and u91.rewards.rep and (u91.rewards.rep.faction or "?") or "?");
            TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel4.ZIndex = 11;
            TextLabel4.Parent = Frame;
            local TextButton = Instance.new("TextButton");
            TextButton.AnchorPoint = Vector2.new(1, 0.5);
            TextButton.Position = UDim2.new(1, -8, 0.5, 0);
            TextButton.Size = UDim2.fromOffset(88, 34);
            TextButton.BackgroundColor3 = Color3_fromRGB_ret3;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = "TURN IN";
            TextButton.FontFace = HEADER_FONT;
            TextButton.TextSize = 17;
            TextButton.TextColor3 = Color3_fromRGB_ret;
            TextButton.AutoButtonColor = true;
            TextButton.ZIndex = 11;
            TextButton.Parent = Frame;
            TextButton.MouseButton1Click:Connect(function() -- Line: 1292
                -- upvalues: TextButton (copy), u2 (ref), u91 (copy), u57 (ref), CurrentNPC (ref), u54 (ref)
                TextButton.Active = false;
                TextButton.Text = "...";
                local v92 = u2:Handin(u91.id, u57, CurrentNPC);

                if v92 and v92.ok then
                    u54:OpenWorkPanel();

                    return;
                end;

                TextButton.Text = "TURN IN";
                TextButton.Active = true;
                local v93 = v92 and v92.error or "unknown";
                u2:ShowToast(v93 == "missing_package" and "You no longer have the package" or (v93 == "too_far" and "Get closer to hand it in" or (v93 == "missing_items" and "You don\'t have the required items" or "Couldn\'t turn in")));
                warn("[NpcInteractionController] Handin failed:", v93);
            end);
        end;

        local function buildCooldownNotice(u94) -- Line: 1312
            -- upvalues: WorkOffersScroll (copy), C (ref), BODY_FONT_BOLD (ref), u54 (copy), CurrentNPC (copy)
            local Frame = Instance.new("Frame");
            Frame.Size = UDim2.new(1, 0, 0, 70);
            Frame.BackgroundTransparency = 1;
            Frame.ZIndex = 11;
            Frame.Parent = WorkOffersScroll;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Size = UDim2.new(1, 0, 0, 20);
            TextLabel2.Position = UDim2.fromOffset(0, 8);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.Text = "NO CONTRACTS RIGHT NOW";
            TextLabel2.TextColor3 = C.dim;
            TextLabel2.TextSize = 13;
            TextLabel2.FontFace = BODY_FONT_BOLD;
            TextLabel2.ZIndex = 11;
            TextLabel2.Parent = Frame;
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Size = UDim2.new(1, 0, 0, 26);
            TextLabel3.Position = UDim2.fromOffset(0, 30);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.TextColor3 = C.amber;
            TextLabel3.TextSize = 20;
            TextLabel3.FontFace = BODY_FONT_BOLD;
            TextLabel3.ZIndex = 11;
            TextLabel3.Parent = Frame;
            task.spawn(function() -- Line: 1340
                -- upvalues: TextLabel3 (copy), u54 (ref), u94 (copy), CurrentNPC (ref)
                while TextLabel3.Parent and (u54.WorkPanel and u54.WorkPanel.Visible) do
                    local v95 = u94 - os.time();

                    if v95 <= 0 then
                        if u54.WorkPanel and (u54.WorkPanel.Visible and u54.CurrentNPC == CurrentNPC) then
                            u54:OpenWorkPanel();

                            return;
                        end;

                        break;
                    end;

                    TextLabel3.Text = string.format("New contracts in %d:%02d", math.floor(v95 / 60), v95 % 60);
                    task.wait(1);
                end;
            end);
        end;

        local function buildRefreshFooter(u96) -- Line: 1356
            -- upvalues: C (ref), BODY_FONT (ref), WorkOffersScroll (copy), u54 (copy), CurrentNPC (copy)
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Size = UDim2.new(1, 0, 0, 18);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.TextColor3 = C.dim;
            TextLabel2.TextSize = 12;
            TextLabel2.FontFace = BODY_FONT;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Center;
            TextLabel2.ZIndex = 11;
            TextLabel2.LayoutOrder = 999;
            TextLabel2.Parent = WorkOffersScroll;
            task.spawn(function() -- Line: 1367
                -- upvalues: TextLabel2 (copy), u54 (ref), u96 (copy), CurrentNPC (ref)
                while TextLabel2.Parent and (u54.WorkPanel and u54.WorkPanel.Visible) do
                    local v97 = u96 - os.time();

                    if v97 <= 0 then
                        if u54.WorkPanel and (u54.WorkPanel.Visible and u54.CurrentNPC == CurrentNPC) then
                            u54:OpenWorkPanel();

                            return;
                        end;

                        break;
                    end;

                    TextLabel2.Text = string.format("New contracts in %d:%02d", math.floor(v97 / 60), v97 % 60);
                    task.wait(1);
                end;
            end);
        end;

        local v98 = not v65 and "contracts" or (u54._workTab or "contracts");

        if v98 == "contracts" and (#v61 == 0 and (#v88 == 0 and (v66 or v67))) then
            u54._workTab = "story";
            v98 = "story";
        end;

        if u54.WorkTabStory then
            u54.WorkTabStory.Visible = v65;
        end;

        local function paintTab(p99, p100) -- Line: 1394
            -- upvalues: C (ref)
            if not p99 then
                return;
            end;

            p99.BackgroundColor3 = p100 and C.hover or C.row;
            p99.TextColor3 = p100 and C.amber or C.dim;
            local Edge = p99:FindFirstChild("Edge");
            local Underline = p99:FindFirstChild("Underline");

            if Edge then
                Edge.Color = p100 and C.edge or C.inner;
            end;

            if Underline then
                Underline.Visible = p100;
            end;
        end;

        paintTab(u54.WorkTabContracts, v98 == "contracts");
        paintTab(u54.WorkTabStory, v98 == "story");
        local TitleRow = u54.WorkPanel:FindFirstChild("TitleRow");

        if TitleRow then
            TitleRow = TitleRow:FindFirstChild("Title");
        end;

        if TitleRow then
            TitleRow.Text = v98 == "story" and "STORY" or "AVAILABLE WORK";
        end;

        if v98 == "story" then
            local v101;

            if v63 then
                v101 = v63.roster;
            else
                v101 = v63;
            end;

            if v101 and (#v101 > 0 and v64 == "ladder") then
                for _, v in ipairs(v101) do
                    if v66 and v.id == v66.id then
                        buildStoryCard(v66, "turnin");
                    elseif v68[v.id] then
                        buildStoryCard(v68[v.id], "offer");
                    else
                        buildStoryCard(v, v.state);
                    end;
                end;
            elseif v66 then
                buildStoryCard(v66, "turnin");
            elseif v67 then
                buildStoryCard(v67, "offer");
            else
                local v102 = v63 and v63.active and "You\'re already carrying one.\nFinish it and come back." or (not (v63 and v63.nextRequirement) and "Nothing more from Crow. For now." or string.format("Crow doesn\'t trust you with the real work yet.\n\nContracts completed for him: %d / %d", v63.sideDone or 0, v63.nextRequirement));
                local TextLabel2 = Instance.new("TextLabel");
                TextLabel2.Size = UDim2.new(1, 0, 0, 90);
                TextLabel2.BackgroundTransparency = 1;
                TextLabel2.Text = v102;
                TextLabel2.TextColor3 = C.dim;
                TextLabel2.TextSize = 13;
                TextLabel2.FontFace = BODY_FONT;
                TextLabel2.TextWrapped = true;
                TextLabel2.TextXAlignment = Enum.TextXAlignment.Center;
                TextLabel2.TextYAlignment = Enum.TextYAlignment.Center;
                TextLabel2.ZIndex = 11;
                TextLabel2.Parent = WorkOffersScroll;
            end;

            u54:_finishWorkPanel(CurrentNPC, v88, refresh_at, u57);

            return;
        end;

        if #v61 > 0 then
            sectionLabel("READY TO TURN IN");

            for _, v in ipairs(v61) do
                buildTurnInCard(v);
            end;
        end;

        if #v88 > 0 then
            if #v61 > 0 then
                sectionLabel("AVAILABLE WORK");
            end;

            for i, v in ipairs(v88) do
                if i > 5 then
                    break;
                end;

                buildOfferCard(WorkOffersScroll, v);
            end;

            if refresh_at then
                buildRefreshFooter(refresh_at);
            end;
        elseif refresh_at then
            buildCooldownNotice(refresh_at);
        elseif v86 then
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Size = UDim2.new(1, 0, 0, 40);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.Text = "Couldn\'t load contracts.";
            TextLabel2.TextColor3 = Color3.fromRGB(200, 150, 140);
            TextLabel2.TextSize = 13;
            TextLabel2.FontFace = BODY_FONT;
            TextLabel2.ZIndex = 11;
            TextLabel2.Parent = WorkOffersScroll;
            local Frame = Instance.new("Frame");
            Frame.Size = UDim2.new(1, 0, 0, 34);
            Frame.BackgroundTransparency = 1;
            Frame.ZIndex = 11;
            Frame.Parent = WorkOffersScroll;
            local TextButton = Instance.new("TextButton");
            TextButton.Size = UDim2.fromOffset(110, 28);
            TextButton.Position = UDim2.new(0.5, -55, 0, 0);
            TextButton.BackgroundColor3 = C.hover;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = "RETRY";
            TextButton.TextColor3 = C.paper;
            TextButton.TextSize = 13;
            TextButton.FontFace = BODY_FONT_BOLD;
            TextButton.ZIndex = 12;
            TextButton.Parent = Frame;
            TextButton.MouseButton1Click:Connect(function() -- Line: 1504
                -- upvalues: u54 (copy), CurrentNPC (copy)
                if u54.CurrentNPC == CurrentNPC then
                    u54:OpenWorkPanel();
                end;
            end);
        elseif #v61 == 0 then
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Size = UDim2.new(1, 0, 0, 48);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.Text = "No tasks right now.\nCheck back later.";
            TextLabel2.TextColor3 = C.dim;
            TextLabel2.TextSize = 13;
            TextLabel2.FontFace = BODY_FONT;
            TextLabel2.TextWrapped = true;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Center;
            TextLabel2.TextYAlignment = Enum.TextYAlignment.Center;
            TextLabel2.ZIndex = 11;
            TextLabel2.Parent = WorkOffersScroll;
        end;

        u54:_finishWorkPanel(CurrentNPC, v88, refresh_at, u57);
    end,

    _finishWorkPanel = function(u103, u104, p105, p106, p107) -- Line: 1527, Name: _finishWorkPanel
        local v108 = {};

        for _, v in ipairs(p105) do
            v108[#v108 + 1] = tostring(v.id);
        end;

        table.sort(v108);
        u103._workSig = table.concat(v108, ",") .. "|rf:" .. tostring(p106 or "") .. u103:_mainSig(p107);
        local u109 = {};
        u103._workRefreshToken = u109;
        task.spawn(function() -- Line: 1537
            -- upvalues: u103 (copy), u109 (copy), u104 (copy)
            while true do
                task.wait(3);

                if u103._workRefreshToken ~= u109 then
                    break;
                end;

                if not (u103.WorkPanel and (u103.WorkPanel.Visible and u103.CurrentNPC == u104)) then
                    return;
                end;

                if u103:_workOffersSig() ~= u103._workSig then
                    u103:OpenWorkPanel();

                    return;
                end;
            end;
        end);
    end,

    _wireDeathClose = function(u110) -- Line: 1567, Name: _wireDeathClose
        -- upvalues: LocalPlayer (copy)
        local function hookCharacter(p111) -- Line: 1568
            -- upvalues: u110 (copy)
            local v112 = p111:FindFirstChildOfClass("Humanoid") or p111:WaitForChild("Humanoid", 10);

            if not v112 then
                return;
            end;

            v112.Died:Connect(function() -- Line: 1571
                -- upvalues: u110 (ref)
                if u110.IsOpen then
                    u110:Close();
                end;
            end);
        end;

        if LocalPlayer.Character then
            task.spawn(hookCharacter, LocalPlayer.Character);
        end;

        LocalPlayer.CharacterAdded:Connect(function(p113) -- Line: 1576
            -- upvalues: u110 (copy), hookCharacter (copy)
            if u110.IsOpen then
                u110:Close();
            end;

            hookCharacter(p113);
        end);
    end,

    Close = function(u114) -- Line: 1582, Name: Close
        -- upvalues: RunService (copy), LocalPlayer (copy), ContextActionService (copy), u1 (ref), ReplicatedStorage (copy), UserInputService (copy)
        if not u114.IsOpen then
            return;
        end;

        u114.IsOpen = false;

        if u114._savedControls then
            pcall(function() -- Line: 1591
                -- upvalues: u114 (copy)
                u114._savedControls:Enable();
            end);
            u114._savedControls = nil;
        end;

        if u114._freezeBound then
            pcall(function() -- Line: 1595
                -- upvalues: RunService (ref), u114 (copy)
                RunService:UnbindFromRenderStep(u114._freezeBound);
            end);
            u114._freezeBound = nil;
        end;

        if u114._sphCharacterClient then
            pcall(function() -- Line: 1599
                -- upvalues: u114 (copy)
                u114._sphCharacterClient:SetAttribute("SpeedCap_Dialogue", nil);
            end);
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildOfClass("Humanoid");
        end;

        if Character then
            if u114._savedWalkSpeed then
                Character.WalkSpeed = u114._savedWalkSpeed;
            end;

            if u114._savedJumpPower then
                Character.JumpPower = u114._savedJumpPower;
            end;

            if u114._savedJumpHeight then
                Character.JumpHeight = u114._savedJumpHeight;
            end;

            if u114._savedAutoRotate ~= nil then
                Character.AutoRotate = u114._savedAutoRotate;
            end;
        end;

        u114.Gui.Enabled = false;

        if u114.WorkPanel then
            u114.WorkPanel.Visible = false;
        end;

        ContextActionService:UnbindAction("NpcInteractionClose");
        u1 = u1 or require(ReplicatedStorage:WaitForChild("TraderController"));

        if u1 and u1.IsOpen then
            u1:Close("npc-interaction-closed");
            local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

            if Remotes then
                Remotes = Remotes:FindFirstChild("CloseTrader");
            end;

            if Remotes then
                Remotes:FireServer();
            end;
        end;

        local success, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1));

        if success and (result and result.IsOpen) then
            if result.Gui then
                result.Gui.Enabled = false;
            end;

            result.IsOpen = false;
            result._tree = nil;
            result._currentNode = nil;
            result._history = nil;
            result.CurrentNPC = nil;
            result.CurrentProfile = nil;

            if result._clearHistoryUI then
                result:_clearHistoryUI();
            end;

            if result._clearChoicesUI then
                result:_clearChoicesUI();
            end;
        end;

        if u114._freezeBound then
            RunService:UnbindFromRenderStep(u114._freezeBound);
            u114._freezeBound = nil;
        end;

        local Character2 = LocalPlayer.Character;

        if Character2 then
            for _, descendant in ipairs(Character2:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.LocalTransparencyModifier = 0;
                end;
            end;
        end;

        u114._savedTransparencies = nil;

        if u114._sphCharacterClient then
            u114._sphCharacterClient:SetAttribute("SpeedCap_Dialogue", nil);
        end;

        u114._sphCharacterClient = nil;

        if u114._savedControls then
            pcall(function() -- Line: 1663
                -- upvalues: u114 (copy)
                u114._savedControls:Enable();
            end);
            u114._savedControls = nil;
        end;

        local Character3 = LocalPlayer.Character;

        if Character3 then
            Character3 = Character3:FindFirstChildOfClass("Humanoid");
        end;

        if Character3 then
            if u114._savedWalkSpeed then
                Character3.WalkSpeed = u114._savedWalkSpeed;
            end;

            if u114._savedJumpPower then
                Character3.JumpPower = u114._savedJumpPower;
            end;

            if u114._savedJumpHeight then
                Character3.JumpHeight = u114._savedJumpHeight;
            end;

            if u114._savedAutoRotate ~= nil then
                Character3.AutoRotate = u114._savedAutoRotate;
            end;
        end;

        u114._savedWalkSpeed = nil;
        u114._savedJumpPower = nil;
        u114._savedJumpHeight = nil;
        u114._savedAutoRotate = nil;

        if u114._hiddenPrompts then
            for i in pairs(u114._hiddenPrompts) do
                if i and i.Parent then
                    i.Enabled = true;
                end;
            end;

            u114._hiddenPrompts = nil;
        end;

        u114:_restoreCamera();

        if u114._savedMouseBehavior ~= nil then
            UserInputService.MouseBehavior = u114._savedMouseBehavior;
        end;

        if u114._savedMouseIconEnabled ~= nil then
            UserInputService.MouseIconEnabled = u114._savedMouseIconEnabled;
        end;

        u114._savedMouseBehavior = nil;
        u114._savedMouseIconEnabled = nil;

        if u114._savedCameraMode ~= nil then
            LocalPlayer.CameraMode = u114._savedCameraMode;
        end;

        if u114._savedCameraMinZoom ~= nil then
            LocalPlayer.CameraMinZoomDistance = u114._savedCameraMinZoom;
        end;

        if u114._savedCameraMaxZoom ~= nil then
            LocalPlayer.CameraMaxZoomDistance = u114._savedCameraMaxZoom;
        end;

        u114._savedCameraMode = nil;
        u114._savedCameraMinZoom = nil;
        u114._savedCameraMaxZoom = nil;
        u114.CurrentNPC = nil;
        u114.CurrentProfile = nil;
    end,

    _startCinematicCamera = function(u115, p116) -- Line: 1717, Name: _startCinematicCamera
        -- upvalues: CurrentCamera (copy), LocalPlayer (copy), TweenService (copy)
        u115._savedCamType = CurrentCamera.CameraType;
        u115._savedCamCFrame = CurrentCamera.CFrame;
        u115._savedCamFOV = CurrentCamera.FieldOfView;
        u115._savedCamSubject = CurrentCamera.CameraSubject;
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("Head") or Character:FindFirstChild("HumanoidRootPart");
        end;

        local v117;

        if p116 then
            v117 = p116:FindFirstChild("Head", true) or p116:FindFirstChild("HumanoidRootPart", true);
        else
            v117 = p116;
        end;

        if not (Character and v117) then
            return;
        end;

        CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local LookVector = (p116:FindFirstChild("HumanoidRootPart", true) or v117).CFrame.LookVector;
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
        local v118 = Vector3_new_ret.Magnitude > 0.001 and Vector3_new_ret.Unit or Vector3.new(0, 0, -1);
        local Unit = v118:Cross(Vector3.new(0, 1, 0)).Unit;
        local Position = v117.Position;
        local CFrame_lookAt_ret = CFrame.lookAt(Position + v118 * 5 + Unit * 0 + Vector3.new(0, 0, 0), Position);
        CurrentCamera.CFrame = CFrame.lookAt(Character.Position, Character.Position + CurrentCamera.CFrame.LookVector * 10);

        if u115._activeTween then
            u115._activeTween:Cancel();
            u115._activeTween = nil;
        end;

        u115._lockedCameraCFrame = nil;
        local v119 = TweenService:Create(CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            FieldOfView = 55,
            CFrame = CFrame_lookAt_ret
        });
        u115._activeTween = v119;
        v119.Completed:Once(function() -- Line: 1767
            -- upvalues: u115 (copy), CFrame_lookAt_ret (copy)
            if u115.IsOpen then
                u115._lockedCameraCFrame = CFrame_lookAt_ret;
            end;
        end);
        v119:Play();
    end,

    _restoreCamera = function(p120) -- Line: 1775, Name: _restoreCamera
        -- upvalues: LocalPlayer (copy), CurrentCamera (copy)
        p120._lockedCameraCFrame = nil;

        if p120._activeTween then
            p120._activeTween:Cancel();
            p120._activeTween = nil;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildOfClass("Humanoid");
        end;

        CurrentCamera.CameraSubject = Character or (p120._savedCamSubject or CurrentCamera.CameraSubject);
        CurrentCamera.CameraType = p120._savedCamType or Enum.CameraType.Custom;
        CurrentCamera.FieldOfView = p120._savedCamFOV or 70;
        p120._savedCamType = nil;
        p120._savedCamCFrame = nil;
        p120._savedCamFOV = nil;
        p120._savedCamSubject = nil;
    end
};