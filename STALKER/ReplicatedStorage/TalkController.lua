-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal);
local Color3_fromRGB_ret = Color3.fromRGB(255, 180, 70);
local Color3_fromRGB_ret2 = Color3.fromRGB(130, 220, 130);
local Color3_fromRGB_ret3 = Color3.fromRGB(220, 220, 220);
local Color3_fromRGB_ret4 = Color3.fromRGB(48, 48, 48);
local Color3_fromRGB_ret5 = Color3.fromRGB(25, 27, 24);
local v6 = {
    IsOpen = false,
    CurrentNPC = nil,
    CurrentProfile = nil,
    _tree = nil,
    _currentNode = nil,
    _history = nil,
    _lastNpcFinishTime = 0,

    _npcPanelOwnsCursor = function(p1) -- Line: 44, Name: _npcPanelOwnsCursor
        -- upvalues: LocalPlayer (copy)
        local v2 = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui");

        if v2 then
            v2 = v2:FindFirstChild("NpcInteractionGui");
        end;

        return v2 and (v2:IsA("ScreenGui") and v2.Enabled) and true or false;
    end,

    _acquireCursor = function(p3) -- Line: 50, Name: _acquireCursor
        -- upvalues: UserInputService (copy), RunService (copy)
        if p3._cursorHeld or p3:_npcPanelOwnsCursor() then
            return;
        end;

        p3._cursorHeld = true;
        p3._savedMouseBehavior = UserInputService.MouseBehavior;
        p3._savedMouseIcon = UserInputService.MouseIconEnabled;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        UserInputService.MouseIconEnabled = true;
        RunService:BindToRenderStep("TalkControllerCursor", Enum.RenderPriority.Camera.Value + 101, function() -- Line: 60
            -- upvalues: UserInputService (ref)
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            end;

            if not UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = true;
            end;
        end);
    end,

    _releaseCursor = function(p4) -- Line: 70, Name: _releaseCursor
        -- upvalues: RunService (copy), UserInputService (copy)
        if not p4._cursorHeld then
            return;
        end;

        p4._cursorHeld = false;
        pcall(function() -- Line: 73
            -- upvalues: RunService (ref)
            RunService:UnbindFromRenderStep("TalkControllerCursor");
        end);

        if p4._savedMouseBehavior ~= nil then
            UserInputService.MouseBehavior = p4._savedMouseBehavior;
            p4._savedMouseBehavior = nil;
        end;

        if p4._savedMouseIcon ~= nil then
            UserInputService.MouseIconEnabled = p4._savedMouseIcon;
            p4._savedMouseIcon = nil;
        end;
    end,

    _bindCursorOwnership = function(u5) -- Line: 87, Name: _bindCursorOwnership
        if u5._cursorBound or not u5.Gui then
            return;
        end;

        u5._cursorBound = true;
        u5.Gui:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 90, Name: refresh
            -- upvalues: u5 (copy)
            if u5.Gui and u5.Gui.Enabled then
                u5:_acquireCursor();

                return;
            end;

            u5:_releaseCursor();
        end);

        if u5.Gui and u5.Gui.Enabled then
            u5:_acquireCursor();

            return;
        end;

        u5:_releaseCursor();
    end
};

local function applyBodyGradient(p7) -- Line: 101
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) });
    UIGradient.Rotation = -90;
    UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) });
    UIGradient.Parent = p7;

    return UIGradient;
end;

local function applyStroke(p8) -- Line: 116
    -- upvalues: Color3_fromRGB_ret4 (copy)
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret4;
    UIStroke.Thickness = 1;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = p8;

    return UIStroke;
end;

local function addHistoryEntry(p9, p10, p11, p12, p13) -- Line: 125
    -- upvalues: Font_new_ret (copy), Color3_fromRGB_ret3 (copy), Font_new_ret3 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Entry" .. tostring(p13);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Size = UDim2.new(1, 0, 0, 0);
    Frame.AutomaticSize = Enum.AutomaticSize.Y;
    Frame.LayoutOrder = p13;
    Frame.Parent = p9;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 2);
    UIListLayout.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Speaker";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.new(1, 0, 0, 0);
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel.Text = string.upper(p10);
    TextLabel.TextColor3 = p11;
    TextLabel.TextSize = 20;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel.TextWrapped = false;
    TextLabel.LayoutOrder = 1;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "Line";
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Size = UDim2.new(1, -16, 0, 0);
    TextLabel2.Position = UDim2.new(0, 16, 0, 0);
    TextLabel2.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel2.Text = p12;
    TextLabel2.TextColor3 = Color3_fromRGB_ret3;
    TextLabel2.TextSize = 18;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.TextWrapped = true;
    TextLabel2.LayoutOrder = 2;
    TextLabel2.Parent = Frame;

    return TextLabel2;
end;

local function makeChoiceButton(p14, p15, p16) -- Line: 174
    -- upvalues: Color3_fromRGB_ret3 (copy), Font_new_ret3 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Choice" .. tostring(p16);
    TextButton.BackgroundTransparency = 1;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = false;
    TextButton.Size = UDim2.new(1, 0, 0, 0);
    TextButton.AutomaticSize = Enum.AutomaticSize.Y;
    TextButton.LayoutOrder = p16;
    TextButton.Text = p15;
    TextButton.TextColor3 = Color3_fromRGB_ret3;
    TextButton.TextSize = 18;
    TextButton.FontFace = Font_new_ret3;
    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
    TextButton.TextYAlignment = Enum.TextYAlignment.Top;
    TextButton.TextWrapped = true;
    TextButton.Parent = p14;
    TextButton.MouseEnter:Connect(function() -- Line: 192
        -- upvalues: TextButton (copy)
        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255);
    end);
    TextButton.MouseLeave:Connect(function() -- Line: 195
        -- upvalues: TextButton (copy), Color3_fromRGB_ret3 (ref)
        TextButton.TextColor3 = Color3_fromRGB_ret3;
    end);

    return TextButton;
end;

local function topicReady(p17, p18) -- Line: 207
    for _, v in ipairs(p17.requires or {}) do
        if not p18[v] then
            return false;
        end;
    end;

    for _, v in ipairs(p17.excludes or {}) do
        if p18[v] then
            return false;
        end;
    end;

    return true;
end;

function v6._buildGui(u19) -- Line: 221
    -- upvalues: LocalPlayer (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret4 (copy), applyBodyGradient (copy), Font_new_ret (copy), Font_new_ret2 (copy), ReplicatedStorage (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "TalkGui";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.DisplayOrder = 5;
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
    local Frame = Instance.new("Frame");
    Frame.Name = "MainFrame";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(0.5, 0.7);
    Frame.BackgroundColor3 = Color3_fromRGB_ret5;
    Frame.BackgroundTransparency = 0;
    Frame.BorderSizePixel = 0;
    Frame.Parent = ScreenGui;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret4;
    UIStroke.Thickness = 1;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = Frame;
    applyBodyGradient(Frame);
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 4);
    UICorner.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 0);
    UIListLayout.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Header";
    Frame2.Size = UDim2.new(1, 0, 0.12, 0);
    Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame2.BackgroundTransparency = 0;
    Frame2.BorderSizePixel = 0;
    Frame2.LayoutOrder = 1;
    Frame2.Parent = Frame;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) });
    UIGradient.Rotation = -90;
    UIGradient.Parent = Frame2;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3_fromRGB_ret4;
    UIStroke2.Thickness = 1;
    UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke2.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "NpcName";
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "NPC NAME";
    TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220);
    TextLabel.TextSize = 30;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel.Parent = Frame2;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "HistoryFrame";
    ScrollingFrame.Size = UDim2.new(1, 0, 0.55, 0);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollBarThickness = 6;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120);
    ScrollingFrame.LayoutOrder = 2;
    ScrollingFrame.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 8);
    UIPadding.PaddingBottom = UDim.new(0, 8);
    UIPadding.PaddingLeft = UDim.new(0, 8);
    UIPadding.PaddingRight = UDim.new(0, 8);
    UIPadding.Parent = ScrollingFrame;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Padding = UDim.new(0, 8);
    UIListLayout2.Parent = ScrollingFrame;
    local ScrollingFrame2 = Instance.new("ScrollingFrame");
    ScrollingFrame2.Name = "ChoicesFrame";
    ScrollingFrame2.Size = UDim2.new(1, 0, 0.28, 0);
    ScrollingFrame2.BackgroundColor3 = Color3_fromRGB_ret5;
    ScrollingFrame2.BackgroundTransparency = 0.5;
    ScrollingFrame2.BorderSizePixel = 0;
    ScrollingFrame2.LayoutOrder = 3;
    ScrollingFrame2.Active = true;
    ScrollingFrame2.CanvasSize = UDim2.new();
    ScrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame2.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame2.ScrollBarThickness = 4;
    ScrollingFrame2.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120);
    ScrollingFrame2.Parent = Frame;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = Color3_fromRGB_ret4;
    UIStroke3.Thickness = 1;
    UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke3.Parent = ScrollingFrame2;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.PaddingTop = UDim.new(0, 12);
    UIPadding2.PaddingBottom = UDim.new(0, 12);
    UIPadding2.PaddingLeft = UDim.new(0, 12);
    UIPadding2.PaddingRight = UDim.new(0, 12);
    UIPadding2.Parent = ScrollingFrame2;
    local UIListLayout3 = Instance.new("UIListLayout");
    UIListLayout3.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout3.Padding = UDim.new(0, 4);
    UIListLayout3.Parent = ScrollingFrame2;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Footer";
    Frame3.Size = UDim2.new(1, 0, 0.05, 0);
    Frame3.BackgroundColor3 = Color3.fromRGB(27, 27, 27);
    Frame3.BackgroundTransparency = 0.5;
    Frame3.BorderSizePixel = 0;
    Frame3.LayoutOrder = 4;
    Frame3.Parent = Frame;
    local UIStroke4 = Instance.new("UIStroke");
    UIStroke4.Color = Color3_fromRGB_ret4;
    UIStroke4.Thickness = 1;
    UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke4.Parent = Frame3;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "TradeBtn";
    TextButton.Size = UDim2.fromScale(1, 1);
    TextButton.BackgroundTransparency = 1;
    TextButton.AutoButtonColor = false;
    TextButton.Text = "TRADE";
    TextButton.TextColor3 = Color3.fromRGB(255, 200, 90);
    TextButton.TextSize = 20;
    TextButton.FontFace = Font_new_ret2;
    TextButton.TextXAlignment = Enum.TextXAlignment.Center;
    TextButton.TextYAlignment = Enum.TextYAlignment.Center;
    TextButton.Parent = Frame3;
    TextButton.MouseButton1Click:Connect(function() -- Line: 368
        -- upvalues: u19 (copy), ReplicatedStorage (ref)
        if not u19.IsOpen then
            return;
        end;

        local CurrentNPC = u19.CurrentNPC;

        if not CurrentNPC then
            return;
        end;

        u19.IsOpen = false;
        u19.Gui.Enabled = false;
        u19._tree = nil;
        u19._currentNode = nil;
        u19._history = nil;
        u19:_clearHistoryUI();
        u19:_clearChoicesUI();
        u19.CurrentNPC = nil;
        u19.CurrentProfile = nil;
        local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

        if Remotes then
            Remotes = Remotes:FindFirstChild("OpenTraderFromMenu");
        end;

        if Remotes then
            Remotes:FireServer(CurrentNPC);
        end;
    end);
    u19.Gui = ScreenGui;
    u19:_bindCursorOwnership();
    u19.MainFrame = Frame;
    u19.NpcName = TextLabel;
    u19.HistoryFrame = ScrollingFrame;
    u19.ChoicesFrame = ScrollingFrame2;
    u19.TradeBtn = TextButton;
end;

function v6._clearHistoryUI(p20) -- Line: 397
    if not p20.HistoryFrame then
        return;
    end;

    for _, child in ipairs(p20.HistoryFrame:GetChildren()) do
        if not (child:IsA("UIListLayout") or child:IsA("UIPadding")) then
            child:Destroy();
        end;
    end;
end;

function v6._clearChoicesUI(p21) -- Line: 406
    if not p21.ChoicesFrame then
        return;
    end;

    for _, child in ipairs(p21.ChoicesFrame:GetChildren()) do
        if not (child:IsA("UIListLayout") or (child:IsA("UIPadding") or child:IsA("UIStroke"))) then
            child:Destroy();
        end;
    end;
end;

function v6._addHistoryLine(u22, p23, p24, p25) -- Line: 415
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), addHistoryEntry (copy)
    local v26 = #u22.HistoryFrame:GetChildren();
    addHistoryEntry(u22.HistoryFrame, p23, p25 and Color3_fromRGB_ret or Color3_fromRGB_ret2, p24, v26);
    table.insert(u22._history, {
        speaker = p23,
        text = p24,
        isNPC = p25
    });
    task.defer(function() -- Line: 420
        -- upvalues: u22 (copy)
        if u22.HistoryFrame and u22.HistoryFrame.Parent then
            u22.HistoryFrame.CanvasPosition = Vector2.new(0, u22.HistoryFrame.AbsoluteCanvasSize.Y);
        end;
    end);

    if p25 then
        u22._lastNpcFinishTime = os.clock();
    end;
end;

function v6._renderFallbackMessage(p27, p28) -- Line: 433
    -- upvalues: Font_new_ret3 (copy)
    p27:_clearHistoryUI();
    p27:_clearChoicesUI();
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "FallbackMessage";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.new(1, 0, 0, 0);
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel.Text = p28;
    TextLabel.TextColor3 = Color3.fromRGB(140, 140, 140);
    TextLabel.TextSize = 18;
    TextLabel.FontFace = Font_new_ret3;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel.TextWrapped = true;
    TextLabel.LayoutOrder = 1;
    TextLabel.Parent = p27.HistoryFrame;
end;

function v6._findNodeByName(p29, p30) -- Line: 452
    if p29._tree then
        return p29._tree:FindFirstChild(p30);
    end;

    return nil;
end;

local function groupDigits(p31) -- Line: 459
    local v32 = tonumber(p31) or 0;
    local math_floor_ret = math.floor(v32);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

function v6._setPriceTag(p33, p34) -- Line: 472
    -- upvalues: Font_new_ret2 (copy)
    if not p33.ChoicesFrame then
        return;
    end;

    local PriceTag = p33.ChoicesFrame:FindFirstChild("PriceTag");

    if PriceTag then
        PriceTag:Destroy();
    end;

    if not p34 or p34 <= 0 then
        return;
    end;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "PriceTag";
    TextLabel.LayoutOrder = 0;
    TextLabel.Size = UDim2.new(1, 0, 0, 18);
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextColor3 = Color3.fromRGB(220, 90, 90);
    TextLabel.TextSize = 16;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    local string_format = string.format;
    local v35 = tonumber(p34) or 0;
    local math_floor_ret = math.floor(v35);
    TextLabel.Text = string_format("Asking: %s RU", (tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
    TextLabel.Parent = p33.ChoicesFrame;
end;

function v6._addTransactionLine(u36, p37) -- Line: 491
    -- upvalues: Font_new_ret2 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Transaction";
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.new(1, 0, 0, 18);
    Frame.AutomaticSize = Enum.AutomaticSize.Y;
    Frame.LayoutOrder = #u36.HistoryFrame:GetChildren();
    Frame.Parent = u36.HistoryFrame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, -16, 0, 18);
    TextLabel.Position = UDim2.fromOffset(16, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextColor3 = Color3.fromRGB(220, 90, 90);
    TextLabel.TextSize = 16;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextWrapped = true;
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
    local string_format = string.format;
    local v38 = tonumber(p37) or 0;
    local math_floor_ret = math.floor(v38);
    TextLabel.Text = string_format("-%s RU", (tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
    TextLabel.Parent = Frame;
    task.defer(function() -- Line: 511
        -- upvalues: u36 (copy)
        if u36.HistoryFrame and u36.HistoryFrame.Parent then
            u36.HistoryFrame.CanvasPosition = Vector2.new(0, u36.HistoryFrame.AbsoluteCanvasSize.Y);
        end;
    end);
end;

function v6._findTree(p39, p40) -- Line: 518
    if not p40 then
        return nil;
    end;

    for _, descendant in ipairs(p40:GetDescendants()) do
        if descendant:IsA("Configuration") and descendant:GetAttribute("NodeTree") == true then
            return descendant;
        end;
    end;

    return nil;
end;

function v6._findRootNode(p41, p42) -- Line: 528
    for _, child in ipairs(p42:GetChildren()) do
        if child:IsA("Configuration") and child:GetAttribute("Type") == "DialogueRoot" then
            return child;
        end;
    end;

    return nil;
end;

function v6._getOutputs(p43, p44) -- Line: 537
    local v45 = {};
    local MainPathway = p44:FindFirstChild("MainPathway");

    if not MainPathway then
        return v45;
    end;

    local Outputs = MainPathway:FindFirstChild("Outputs");

    if not Outputs then
        return v45;
    end;

    for _, child in ipairs(Outputs:GetChildren()) do
        if child:IsA("ObjectValue") and (child.Value and child.Value.Parent) then
            table.insert(v45, child.Value.Parent);
        end;
    end;

    return v45;
end;

function v6._singleOutput(p46, p47) -- Line: 551
    return p46:_getOutputs(p47)[1];
end;

function v6._runIncomingCommands(p48, p49) -- Line: 556
    if not p48._tree then
        return;
    end;

    for _, child in ipairs(p48._tree:GetChildren()) do
        if child:IsA("Configuration") and child:GetAttribute("Type") == "Command" then
            local v50 = child;

            for _, v in ipairs(p48:_getOutputs(child)) do
                if v == p49 then
                    local Function = v50:FindFirstChild("Function");

                    if Function and Function:IsA("ModuleScript") then
                        local success, result = pcall(require, Function);

                        if success and (result and type(result.Run) == "function") then
                            pcall(result.Run);
                        end;
                    end;

                    break;
                end;
            end;
        end;
    end;
end;

function v6._getReadyTurnIns(p51) -- Line: 579
    -- upvalues: ReplicatedStorage (copy)
    local CurrentNPC = p51.CurrentNPC;

    if not CurrentNPC then
        return {}, nil;
    end;

    local success, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3));

    if not (success and result) then
        return {}, nil;
    end;

    local Name = CurrentNPC.Name;

    local function isForThisNpc(p52) -- Line: 593
        -- upvalues: Name (copy)
        if p52.type == "delivery" then
            return p52.params and p52.params.destination_npc == Name;
        end;

        return p52.giver and p52.giver.npcId == Name;
    end;

    local function objectivesDone(p53) -- Line: 585
        for _, v in ipairs(p53.objectives or {}) do
            if v.id ~= "return" and (v.id ~= "deliver" and not v.complete) then
                return false;
            end;
        end;

        return true;
    end;

    local v54 = {};

    for _, v in ipairs(result:GetActiveTasks() or {}) do
        local v55;

        if v.type == "delivery" then
            v55 = v.params and v.params.destination_npc == Name;
        else
            v55 = v.giver and v.giver.npcId == Name;
        end;

        if v55 and (objectivesDone(v) and not v.shared_from) then
            table.insert(v54, v);
        end;
    end;

    return v54, result;
end;

function v6._onTurnInClicked(p56, p57, p58, p59) -- Line: 609
    -- upvalues: ReplicatedStorage (copy)
    p56:_addHistoryLine("PLAYER", p59, false);
    local v60 = p58:Handin(p57.id, p56.CurrentNPC and p56.CurrentNPC.Name);

    if v60 and v60.ok then
        p56.IsOpen = false;
        p56.Gui.Enabled = false;
        p56._tree = nil;
        p56._currentNode = nil;
        p56._history = nil;
        p56:_clearHistoryUI();
        p56:_clearChoicesUI();
        p56.CurrentNPC = nil;
        p56.CurrentProfile = nil;
        local success, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1));

        if success and (result and result.IsOpen) then
            result:Close();
        end;
    else
        local v61 = v60 and v60.error or "unknown";
        p58:ShowToast(v61 == "missing_package" and "You no longer have the package" or (v61 == "missing_items" and "You don\'t have the required items" or "Couldn\'t turn in"));
    end;
end;

function v6._renderChoicesFromResponses(u62, p63) -- Line: 637
    -- upvalues: makeChoiceButton (copy)
    u62:_clearChoicesUI();
    table.sort(p63, function(p64, p65) -- Line: 639
        return (p64:GetAttribute("Priority") or 0) > (p65:GetAttribute("Priority") or 0);
    end);
    local v66, u67, u68, v69;

    if u62._history and #u62._history <= 1 then
        v66, u67 = u62:_getReadyTurnIns();
        u68 = u62:_negativeVendorFaction(u62.CurrentNPC);
        v69 = u62:_crowAsksSwamps(u62.CurrentNPC);
    else
        v66 = {};
        u67 = nil;
        v69 = false;
        u68 = nil;
    end;

    local v70 = 0;

    for _, v in ipairs(v66) do
        v70 = v70 + 1;
        local string_format_ret = string.format("%s  (TURN IN: %s)", (v.type == "delivery" or v.type == "fetching") and "Here\'s what you requested." or "The job is done.", v.title or "Task");
        local v71 = makeChoiceButton(u62.ChoicesFrame, tostring(v70) .. ". " .. string_format_ret, v70);
        v71.TextColor3 = Color3.fromRGB(150, 210, 140);
        v71.MouseButton1Click:Connect(function() -- Line: 669
            -- upvalues: u62 (copy), v (copy), u67 (copy), string_format_ret (copy)
            if u62.IsOpen then
                u62:_onTurnInClicked(v, u67, string_format_ret);
            end;
        end);
    end;

    if v69 then
        v70 = v70 + 1;
        makeChoiceButton(u62.ChoicesFrame, tostring(v70) .. ". How do I get to the Swamps?", v70).MouseButton1Click:Connect(function() -- Line: 679
            -- upvalues: u62 (copy)
            if u62.IsOpen then
                u62:_runAskSwamps(u62.CurrentNPC);
            end;
        end);
    end;

    if u68 then
        v70 = v70 + 1;
        local v72 = makeChoiceButton(u62.ChoicesFrame, tostring(v70) .. ". I need my name cleared.", v70);
        v72.TextColor3 = Color3.fromRGB(255, 200, 90);
        v72.MouseButton1Click:Connect(function() -- Line: 688
            -- upvalues: u62 (copy), u68 (ref)
            if u62.IsOpen then
                u62:_runClearName(u62.CurrentNPC, u68);
            end;
        end);
    end;

    for _, v in ipairs(p63) do
        v70 = v70 + 1;
        local Text = v:FindFirstChild("Text");
        local v73 = Text and Text.Value or "";
        local v74 = makeChoiceButton(u62.ChoicesFrame, tostring(v70) .. ". " .. v73, v70);
        local Attribute = v:GetAttribute("TextColor");

        if typeof(Attribute) == "Color3" then
            v74.TextColor3 = Attribute;
        end;

        v74.MouseButton1Click:Connect(function() -- Line: 711
            -- upvalues: u62 (copy), v (copy)
            if u62.IsOpen then
                u62:_onChoiceClicked(v);
            end;
        end);
    end;
end;

function v6._advanceTo(u75, u76) -- Line: 719
    u75._currentNode = u76;
    u75:_runIncomingCommands(u76);
    local Attribute = u76:GetAttribute("Type");

    if Attribute == "Prompt" then
        local Text = u76:FindFirstChild("Text");
        local v77 = Text and Text.Value or "";
        u75:_addHistoryLine(string.upper(u75.CurrentProfile and u75.CurrentProfile.DisplayName or (u75.CurrentNPC and (u75.CurrentNPC.Name or "NPC") or "NPC")), v77, true);
        local v78 = u75:_getOutputs(u76);
        local u79 = {};
        local v80 = {};

        for _, v in ipairs(v78) do
            local Attribute2 = v:GetAttribute("Type");

            if Attribute2 == "Response" then
                table.insert(v80, v);
            elseif Attribute2 == "Prompt" then
                table.insert(u79, v);
            end;
        end;

        if #v80 > 0 then
            u75:_renderChoicesFromResponses(v80);

            return;
        end;

        if #u79 == 1 then
            task.defer(function() -- Line: 744
                -- upvalues: u75 (copy), u76 (copy), u79 (copy)
                if u75.IsOpen and u75._currentNode == u76 then
                    u75:_advanceTo(u79[1]);
                end;
            end);

            return;
        end;

        if #u79 > 1 then
            u75:_renderChoicesFromResponses(u79);

            return;
        end;

        u75:_endDialogue();

        return;
    end;

    if Attribute == "Command" then
        local v81 = nil;
        local Function = u76:FindFirstChild("Function");

        if Function and Function:IsA("ModuleScript") then
            local success, result = pcall(require, Function);

            if success and (result and type(result.Run) == "function") then
                local success2, result2 = pcall(result.Run);

                if success2 and type(result2) == "string" then
                    for _, v in ipairs(u75:_getOutputs(u76)) do
                        if v.Name == result2 then
                            v81 = v;
                            break;
                        end;
                    end;
                end;
            end;
        end;

        local v82 = v81 or u75:_singleOutput(u76);

        if v82 then
            u75:_advanceTo(v82);
        end;
    end;
end;

function v6._endDialogue(u83) -- Line: 791
    -- upvalues: ReplicatedStorage (copy)
    u83:_clearChoicesUI();
    local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

    if Remotes then
        Remotes = Remotes:FindFirstChild("PlayVoiceline");
    end;

    if Remotes and u83.CurrentNPC then
        Remotes:FireServer(u83.CurrentNPC, "Goodbye");
    end;

    local os_clock_ret = os.clock();
    local v84 = math.max(0, u83._lastNpcFinishTime - os_clock_ret) + 2;
    task.delay(v84, function() -- Line: 802
        -- upvalues: u83 (copy), ReplicatedStorage (ref)
        if not u83.IsOpen then
            return;
        end;

        u83.IsOpen = false;
        u83.Gui.Enabled = false;
        u83._tree = nil;
        u83._currentNode = nil;
        u83._history = nil;
        u83:_clearHistoryUI();
        u83:_clearChoicesUI();
        u83.CurrentNPC = nil;
        u83.CurrentProfile = nil;
        local success, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1));

        if success and (result and (result.IsOpen and result.Gui)) then
            result.Gui.Enabled = true;
        end;
    end);
end;

function v6._openWorkPanelHandoff(p85) -- Line: 823
    -- upvalues: ReplicatedStorage (copy)
    local CurrentNPC = p85.CurrentNPC;
    local CurrentProfile = p85.CurrentProfile;
    p85.IsOpen = false;
    p85.Gui.Enabled = false;
    p85._tree = nil;
    p85._currentNode = nil;
    p85._history = nil;
    p85:_clearHistoryUI();
    p85:_clearChoicesUI();
    p85.CurrentNPC = nil;
    p85.CurrentProfile = nil;

    if not CurrentNPC then
        return;
    end;

    local success, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1));

    if not (success and result) then
        return;
    end;

    if result.IsOpen and result.CurrentNPC == CurrentNPC then
        if result.Gui then
            result.Gui.Enabled = true;
        end;

        result:OpenWorkPanel();

        return;
    end;

    result:Open(CurrentNPC, CurrentProfile);
    result:OpenWorkPanel();
end;

function v6._onChoiceClicked(p86, p87) -- Line: 855
    if p87:GetAttribute("OpenWorkPanel") == true then
        p86:_openWorkPanelHandoff();

        return;
    end;

    local Function = p87:FindFirstChild("Function");

    if Function and Function:IsA("ModuleScript") then
        local success, result = pcall(require, Function);

        if success and (result and type(result.Decide) == "function") then
            local Text = p87:FindFirstChild("Text");
            p86:_addHistoryLine("PLAYER", Text and Text.Value or "", false);
            local v88, v89, v90 = pcall(result.Decide);

            if v88 and v89 then
                if v90 and v90 > 0 then
                    p86:_addTransactionLine(v90);
                end;

                local v91 = p86:_findNodeByName(v89);

                if v91 then
                    p86:_advanceTo(v91);

                    return;
                end;

                p86:_endDialogue();

                return;
            end;
        end;
    end;

    local Text = p87:FindFirstChild("Text");
    p86:_addHistoryLine("PLAYER", Text and Text.Value or "", false);
    local v92 = p86:_singleOutput(p87);

    if v92 then
        p86:_advanceTo(v92);

        return;
    end;

    p86:_endDialogue();
end;

function v6._wireInput(u93) -- Line: 893
    -- upvalues: UserInputService (copy)
    UserInputService.InputBegan:Connect(function(p94, p95) -- Line: 894
        -- upvalues: u93 (copy)
        if p95 or not u93.IsOpen then
            return;
        end;

        if p94.KeyCode == Enum.KeyCode.Q then
            u93:Close();
        end;
    end);
end;

function v6.Init(p96) -- Line: 902
    if p96.Gui then
        return;
    end;

    p96:_buildGui();
    p96:_wireInput();
    p96.Gui.Enabled = false;
    print("[TalkController] initialized");
end;

function v6.Open(p97, p98, p99) -- Line: 910
    -- upvalues: Players (copy)
    if p97.IsOpen then
        return;
    end;

    p97.IsOpen = true;
    p97.CurrentNPC = p98;
    p97.CurrentProfile = p99;
    p97.NpcName.Text = string.upper(p99 and p99.DisplayName or (p98 and (p98.Name or "NPC") or "NPC"));
    p97._history = {};
    p97._lastNpcFinishTime = 0;
    p97._tree = p97:_findTree(p98);
    p97:_clearHistoryUI();
    p97:_clearChoicesUI();
    p97.Gui.Enabled = true;

    if p97.TradeBtn then
        local TradeBtn = p97.TradeBtn;
        local v100;

        if p98 then
            v100 = p98:GetAttribute("NpcType") == "Extractor" and true or p98:GetAttribute("NoTrade") == true;
        else
            v100 = p98;
        end;

        TradeBtn.Visible = not v100;
    end;

    if p98 and p98:GetAttribute("NpcType") == "Extractor" then
        p97:_runExtractDialog(p98);

        return;
    end;

    if p98 and (p98:GetAttribute("NpcType") == "SimpleTrader" and not p97._tree) then
        p97:_runSimpleTraderIntro(p98);

        return;
    end;

    local LocalPlayer2 = Players.LocalPlayer;

    if LocalPlayer2 and (LocalPlayer2:GetAttribute("_TutorialPending") and not (LocalPlayer2:GetAttribute("_StarterPackGranted") or (not p98 or p98:GetAttribute("TraderID") ~= "Crow"))) then
        p97:_runTutorialIntro(p98);

        return;
    end;

    local v101 = p97:_hatedVendorFaction(p98);

    if v101 then
        p97:_runHatedVendor(p98, v101);

        return;
    end;

    if LocalPlayer2 then
        LocalPlayer2 = LocalPlayer2:GetAttribute("_TutorialStep");
    end;

    if p98 and p98:GetAttribute("TraderID") == "Crow" then
        if LocalPlayer2 == "sell" then
            p97:_runTutorialSellLesson(p98);

            return;
        end;

        if LocalPlayer2 == "turnin" and p97:_findTutorialTask() then
            p97:_runTutorialTurnIn(p98);

            return;
        end;
    end;

    if not p97._tree then
        p97:_renderFallbackMessage("(NPC has no dialogue tree)");

        return;
    end;

    local v102 = p97:_findRootNode(p97._tree);

    if not v102 then
        p97:_renderFallbackMessage("(Dialogue tree has no root)");

        return;
    end;

    local v103 = p97:_singleOutput(v102);

    if v103 then
        p97:_advanceTo(v103);

        return;
    end;

    p97:_renderFallbackMessage("(No dialogue available)");
end;

local u104 = {
    {
        id = "money",
        label = "Money. I heard people get rich out here.",
        reply = { "Sure they do. Usually the ones selling equipment to people like you." }
    },
    {
        id = "wish",
        label = "I\'ve heard stories about the Wish Granter.",
        reply = { "Some say there\'s something at the center that\'ll give you anything you ask for.", "Funny thing about desperate men. They\'ll believe anything if you tell them it\'s waiting far enough north." }
    },
    {
        id = "debt",
        label = "I\'ve got debts back home.",
        reply = { "Maybe you\'ll make enough to go home. Maybe after a while you won\'t want to." }
    },
    {
        id = "nothing_left",
        label = "There\'s nothing left for me outside.",
        reply = { "That one\'s more common than you\'d think.", "Zone doesn\'t ask who you used to be." }
    },
    {
        id = "searching",
        label = "I\'m looking for someone.",
        followPlayer = "I don\'t know.",
        reply = { "Alive?" },
        followReply = { "Then start hoping they\'re smart." }
    },
    {
        id = "silence",
        label = "None of your business.",
        reply = { "Good. You\'ll last longer if you don\'t tell strangers everything about yourself." }
    }
};

function v6._runTutorialIntro(u105, p106) -- Line: 1076
    -- upvalues: Players (copy), u104 (copy), makeChoiceButton (copy)
    local string_upper_ret = string.upper(u105.CurrentProfile and u105.CurrentProfile.DisplayName or (p106.Name or "CROW"));
    local LocalPlayer2 = Players.LocalPlayer;

    if LocalPlayer2 then
        LocalPlayer2 = LocalPlayer2:GetAttribute("_StarterPackGranted") == true;
    end;

    u105._tutorialBusy = false;
    u105:_clearChoicesUI();

    if LocalPlayer2 then
        u105:_addHistoryLine(string_upper_ret, "Still alive? Good for you.", true);
        u105:_addHistoryLine(string_upper_ret, "Hand off was clean. I\'m not running a charity. Kill a mutant, butcher it, and bring me the meat.", true);
        u105:_tutorialShowAccept(string_upper_ret, true, nil);

        return;
    end;

    u105:_addHistoryLine(string_upper_ret, "Fresh meat. You still smell like the outside.", true);
    u105:_addHistoryLine(string_upper_ret, "Everyone who comes through here walked away from something. So before I put work in your hands. Why\'d you come to the Zone?", true);

    for i, v in ipairs(u104) do
        makeChoiceButton(u105.ChoicesFrame, i .. ". " .. v.label, i).MouseButton1Click:Connect(function() -- Line: 1100
            -- upvalues: u105 (copy), string_upper_ret (copy), v (copy)
            if not u105.IsOpen then
                return;
            end;

            u105:_tutorialAnswer(string_upper_ret, v);
        end);
    end;
end;

function v6._tutorialAnswer(u107, u108, u109) -- Line: 1109
    -- upvalues: makeChoiceButton (copy)
    if u107._tutorialBusy then
        return;
    end;

    u107._tutorialBusy = true;
    u107:_addHistoryLine("PLAYER", u109.label, false);
    u107:_clearChoicesUI();

    for _, v in ipairs(u109.reply) do
        u107:_addHistoryLine(u108, v, true);
    end;

    if not u109.followPlayer then
        u107:_tutorialBriefing(u108, u109.id);

        return;
    end;

    u107._tutorialBusy = false;
    makeChoiceButton(u107.ChoicesFrame, "1. " .. u109.followPlayer, 1).MouseButton1Click:Connect(function() -- Line: 1122
        -- upvalues: u107 (copy), u109 (copy), u108 (copy)
        if not u107.IsOpen or u107._tutorialBusy then
            return;
        end;

        u107._tutorialBusy = true;
        u107:_addHistoryLine("PLAYER", u109.followPlayer, false);
        u107:_clearChoicesUI();

        for _, v in ipairs(u109.followReply or {}) do
            u107:_addHistoryLine(u108, v, true);
        end;

        u107:_tutorialBriefing(u108, u109.id);
    end);
end;

function v6._tutorialBriefing(u110, u111, u112) -- Line: 1141
    task.delay(0.7, function() -- Line: 1142
        -- upvalues: u110 (copy), u111 (copy), u112 (copy)
        if not u110.IsOpen then
            return;
        end;

        u110:_addHistoryLine(u111, "Doesn\'t really matter why you came. Money. Debt. Legends. Running from something. Running toward something. The Zone doesn\'t care.", true);
        u110:_addHistoryLine(u111, "You eat by working out here. Simple as that.", true);
        u110:_addHistoryLine(u111, "Mutants roam the fields past the camps. Flesh, blind dogs, the odd boar. Put one down, any kind. It bites if you let it.", true);
        u110:_addHistoryLine(u111, "Then take that knife on your belt to the body and bring me the meat. First lesson in making a living out here.", true);
        u110._tutorialBusy = false;
        u110:_tutorialShowAccept(u111, false, u112);
    end);
end;

function v6._tutorialShowAccept(u113, u114, u115, u116) -- Line: 1156
    -- upvalues: makeChoiceButton (copy), ReplicatedStorage (copy)
    u113:_clearChoicesUI();
    local u117 = u115 and "I\'m on it." or "I\'ll handle it.";
    makeChoiceButton(u113.ChoicesFrame, "1. " .. u117, 1).MouseButton1Click:Connect(function() -- Line: 1160
        -- upvalues: u113 (copy), u117 (copy), ReplicatedStorage (ref), u116 (copy), u115 (copy), u114 (copy)
        if not u113.IsOpen or u113._tutorialBusy then
            return;
        end;

        u113._tutorialBusy = true;
        u113:_addHistoryLine("PLAYER", u117, false);
        u113:_clearChoicesUI();
        local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5);

        if Remotes then
            Remotes = Remotes:FindFirstChild("TutorialAcceptIntro");
        end;

        if Remotes then
            Remotes:FireServer(u116);
        end;

        if not u115 then
            u113:_addHistoryLine(u114, "Here. Skorpion, three mags, a box of rounds, bandages and a medkit. On the house. Lose it and you\'re on your own. If you need more, see what\'s on offer.", true);
        end;

        task.delay(u115 and 2 or 6, function() -- Line: 1175
            -- upvalues: u113 (ref)
            if u113.IsOpen then
                u113:Close();
            end;
        end);
    end);
end;

local function formatRoubles(p118) -- Line: 1186
    local math_floor_ret = math.floor(p118);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

function v6._hatedVendorFaction(p119, p120) -- Line: 1192
    -- upvalues: Players (copy), ReplicatedStorage (copy)
    local LocalPlayer2 = Players.LocalPlayer;

    if p120 then
        p120 = p120:GetAttribute("TraderID");
    end;

    if not (LocalPlayer2 and p120) then
        return nil;
    end;

    local success, result = pcall(require, ReplicatedStorage:WaitForChild("TraderConfig", 2));
    local v121 = success and (result and result.Traders) and result.Traders[p120];

    if not (v121 and (not v121.RepExempt and type(v121.Faction) == "string")) then
        return nil;
    end;

    local Attribute = LocalPlayer2:GetAttribute("FRep_" .. v121.Faction);

    if type(Attribute) == "number" and Attribute <= -500 then
        return v121.Faction;
    end;

    return nil;
end;

function v6._runHatedVendor(u122, u123, p124) -- Line: 1207
    -- upvalues: ReplicatedStorage (copy), makeChoiceButton (copy)
    local string_upper_ret = string.upper(u122.CurrentProfile and u122.CurrentProfile.DisplayName or (u123.Name or "TRADER"));
    u122:_clearChoicesUI();
    u122:_addHistoryLine(string_upper_ret, "I know what you\'ve done to our people. I\'m not dealing with you until you make it right.", true);
    local Remotes = ReplicatedStorage:FindFirstChild("Remotes");
    local u125;

    if Remotes then
        u125 = Remotes:FindFirstChild("FactionRepAmends");
    else
        u125 = Remotes;
    end;

    local v126, v127;

    if u125 then
        v126, v127 = pcall(function() -- Line: 1215
            -- upvalues: u125 (copy), u123 (copy)
            return u125:InvokeServer(u123, false);
        end);
    else
        v126 = false;
        v127 = nil;
    end;

    local v128;

    if v126 and (type(v127) == "table" and v127.ok) then
        v128 = v127.fee or nil;
    else
        v128 = nil;
    end;

    if v128 then
        local math_floor_ret = math.floor(v128);
        u122:_addHistoryLine(string_upper_ret, ("It\'ll cost you %s roubles. Until then I\'ll buy what you bring me, cheap, and sell you food and bandages. Nothing else."):format((tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))), true);
    end;

    local u129 = 0;

    local function choice(u130, u131) -- Line: 1222
        -- upvalues: u129 (ref), makeChoiceButton (ref), u122 (copy)
        u129 = u129 + 1;
        makeChoiceButton(u122.ChoicesFrame, u129 .. ". " .. u130, u129).MouseButton1Click:Connect(function() -- Line: 1225
            -- upvalues: u122 (ref), u131 (copy), u130 (copy)
            if u122.IsOpen then
                u131(u130);
            end;
        end);
    end;

    if v128 then
        local math_floor_ret = math.floor(v128);
        local u132 = ("Pay %s roubles."):format((tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));

        local function u134(p133) -- Line: 1231
            -- upvalues: u122 (copy), u125 (copy), u123 (copy), string_upper_ret (copy)
            u122:_addHistoryLine("PLAYER", p133, false);
            u122:_clearChoicesUI();
            local success, result = pcall(function() -- Line: 1234
                -- upvalues: u125 (ref), u123 (ref)
                return u125:InvokeServer(u123, true);
            end);

            if success and (type(result) == "table" and result.ok) then
                u122:_addHistoryLine(string_upper_ret, "Fine. We\'re square. Don\'t make me regret it.", true);
            elseif success and (type(result) == "table" and result.error == "funds") then
                u122:_addHistoryLine(string_upper_ret, "You don\'t have it. Come back when you do.", true);
            else
                u122:_addHistoryLine(string_upper_ret, "Not now. Come back later.", true);
            end;

            task.delay(2.5, function() -- Line: 1242
                -- upvalues: u122 (ref)
                if u122.IsOpen then
                    u122:Close();
                end;
            end);
        end;

        u129 = u129 + 1;
        makeChoiceButton(u122.ChoicesFrame, u129 .. ". " .. u132, u129).MouseButton1Click:Connect(function() -- Line: 1225
            -- upvalues: u122 (copy), u134 (copy), u132 (copy)
            if u122.IsOpen then
                u134(u132);
            end;
        end);
    end;

    local function u137(p135) -- Line: 1245
        -- upvalues: u122 (copy), Remotes (copy)
        u122:_addHistoryLine("PLAYER", p135, false);
        local CurrentNPC = u122.CurrentNPC;
        u122:Close();
        local v136 = Remotes and Remotes:FindFirstChild("OpenTraderFromMenu");

        if v136 and CurrentNPC then
            v136:FireServer(CurrentNPC);
        end;
    end;

    u129 = u129 + 1;
    local u138 = "Just trade.";
    makeChoiceButton(u122.ChoicesFrame, u129 .. ". Just trade.", u129).MouseButton1Click:Connect(function() -- Line: 1225
        -- upvalues: u122 (copy), u137 (copy), u138 (copy)
        if u122.IsOpen then
            u137(u138);
        end;
    end);

    local function u139() -- Line: 1252
        -- upvalues: u122 (copy)
        u122:Close();
    end;

    u129 = u129 + 1;
    local u140 = "Leave.";
    makeChoiceButton(u122.ChoicesFrame, u129 .. ". Leave.", u129).MouseButton1Click:Connect(function() -- Line: 1225
        -- upvalues: u122 (copy), u139 (copy), u140 (copy)
        if u122.IsOpen then
            u139(u140);
        end;
    end);
end;

function v6._crowAsksSwamps(p141, p142) -- Line: 1259
    -- upvalues: ReplicatedStorage (copy)
    if not p142 or p142:GetAttribute("TraderID") ~= "Crow" then
        return false;
    end;

    local success, result = pcall(require, ReplicatedStorage:WaitForChild("PlaceConfig", 2));

    if success then
        if result == nil then
            success = false;
        else
            success = result.Id == "cordon";
        end;
    end;

    return success;
end;

function v6._runAskSwamps(u143, p144) -- Line: 1268
    -- upvalues: ReplicatedStorage (copy), Players (copy), makeChoiceButton (copy)
    local string_upper_ret = string.upper(u143.CurrentProfile and u143.CurrentProfile.DisplayName or (p144.Name or "CROW"));
    u143:_addHistoryLine("PLAYER", "How do I get to the Swamps?", false);
    u143:_clearChoicesUI();
    local StoryRules = require(ReplicatedStorage:WaitForChild("StoryRules"));
    local success, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 2));
    local v145 = success and (result and (result.GetMain and result:GetMain())) or nil;
    local LocalPlayer2 = Players.LocalPlayer;
    local v146;

    if LocalPlayer2 == nil then
        v146 = false;
    else
        v146 = LocalPlayer2:GetAttribute(StoryRules.ACCESS_ATTR) == true and true or LocalPlayer2:GetAttribute(StoryRules.FOUND_ATTR) == true;
    end;

    local v147 = StoryRules.SwampsAdvice(v145, v146);
    local SWAMPS_ADVICE = StoryRules.SWAMPS_ADVICE;
    local v148;

    if v147.kind == "notyet" then
        v148 = SWAMPS_ADVICE.notyet;

        if type(v147.done) == "number" and type(v147.need) == "number" then
            v148 = v148 .. "\n\n" .. SWAMPS_ADVICE.notyetCount:format(v147.done, v147.need);
        end;
    elseif v147.kind == "offer" then
        v148 = SWAMPS_ADVICE.offer:format(v147.title or "the job");
    elseif v147.kind == "active" then
        v148 = SWAMPS_ADVICE.active:format(v147.title or "what you\'re carrying");
    else
        v148 = SWAMPS_ADVICE[v147.kind] or SWAMPS_ADVICE.known;
    end;

    u143:_addHistoryLine(string_upper_ret, v148, true);

    if v147.kind == "offer" or v147.kind == "intro_offer" then
        makeChoiceButton(u143.ChoicesFrame, "1. Show me.", 1).MouseButton1Click:Connect(function() -- Line: 1299
            -- upvalues: u143 (copy), ReplicatedStorage (ref)
            if not u143.IsOpen then
                return;
            end;

            local success2, result2 = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1));

            if success2 and result2 then
                result2._workTab = "story";
            end;

            u143:_openWorkPanelHandoff();
        end);

        return;
    end;

    makeChoiceButton(u143.ChoicesFrame, "1. Right.", 1).MouseButton1Click:Connect(function() -- Line: 1308
        -- upvalues: u143 (copy)
        if u143.IsOpen then
            u143:_returnToNpcMenu();
        end;
    end);
end;

function v6._negativeVendorFaction(p149, p150) -- Line: 1316
    -- upvalues: Players (copy), ReplicatedStorage (copy)
    local LocalPlayer2 = Players.LocalPlayer;

    if p150 then
        p150 = p150:GetAttribute("TraderID");
    end;

    if not (LocalPlayer2 and p150) then
        return nil;
    end;

    local success, result = pcall(require, ReplicatedStorage:WaitForChild("TraderConfig", 2));
    local v151 = success and (result and result.Traders) and result.Traders[p150];

    if not (v151 and (not v151.RepExempt and type(v151.Faction) == "string")) then
        return nil;
    end;

    local Attribute = LocalPlayer2:GetAttribute("FRep_" .. v151.Faction);

    if type(Attribute) == "number" and (Attribute < 0 and Attribute > -500) then
        return v151.Faction;
    end;

    return nil;
end;

local u152 = {
    Loner = "Loners",
    ClearSky = "Clear Sky",
    Ecologist = "The Ecologists",
    Mercenary = "Mercenaries"
};

function v6._runClearName(u153, u154, p155) -- Line: 1333
    -- upvalues: ReplicatedStorage (copy), makeChoiceButton (copy), u152 (copy)
    local string_upper_ret = string.upper(u153.CurrentProfile and u153.CurrentProfile.DisplayName or (u154.Name or "TRADER"));
    u153:_addHistoryLine("PLAYER", "I need my name cleared.", false);
    u153:_clearChoicesUI();
    local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

    if Remotes then
        Remotes = Remotes:FindFirstChild("FactionRepAmends");
    end;

    local v156, v157;

    if Remotes then
        v156, v157 = pcall(function() -- Line: 1341
            -- upvalues: Remotes (copy), u154 (copy)
            return Remotes:InvokeServer(u154, false);
        end);
    else
        v156 = false;
        v157 = nil;
    end;

    local v158;

    if v156 and (type(v157) == "table" and v157.ok) then
        v158 = v157.fee or nil;
    else
        v158 = nil;
    end;

    local u159 = 0;

    local function _(u160, u161) -- Line: 1345
        -- upvalues: u159 (ref), makeChoiceButton (ref), u153 (copy)
        u159 = u159 + 1;
        local v162 = makeChoiceButton(u153.ChoicesFrame, u159 .. ". " .. u160, u159);
        v162.MouseButton1Click:Connect(function() -- Line: 1348
            -- upvalues: u153 (ref), u161 (copy), u160 (copy)
            if u153.IsOpen then
                u161(u160);
            end;
        end);

        return v162;
    end;

    if not v158 then
        u153:_addHistoryLine(string_upper_ret, "Your name\'s fine with us. Nothing to clear.", true);

        local function u163() -- Line: 1356
            -- upvalues: u153 (copy)
            u153:_returnToNpcMenu();
        end;

        u159 = u159 + 1;
        local u164 = "Right.";
        makeChoiceButton(u153.ChoicesFrame, u159 .. ". Right.", u159).MouseButton1Click:Connect(function() -- Line: 1348
            -- upvalues: u153 (copy), u163 (copy), u164 (copy)
            if u153.IsOpen then
                u163(u164);
            end;
        end);

        return;
    end;

    local v165 = u152[p155] or p155;
    local math_floor_ret = math.floor(v158);
    u153:_addHistoryLine(string_upper_ret, ("%s remember what you did. %s roubles and I\'ll put the word out that you\'re square."):format(v165, (tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))), true);
    local math_floor_ret2 = math.floor(v158);
    local u166 = ("Pay %s roubles."):format((tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));

    local function u168(p167) -- Line: 1363
        -- upvalues: u153 (copy), Remotes (copy), u154 (copy), string_upper_ret (copy)
        u153:_addHistoryLine("PLAYER", p167, false);
        u153:_clearChoicesUI();
        local success, result = pcall(function() -- Line: 1366
            -- upvalues: Remotes (ref), u154 (ref)
            return Remotes:InvokeServer(u154, true);
        end);

        if success and (type(result) == "table" and result.ok) then
            u153:_addHistoryLine(string_upper_ret, "Done. Word gets around. Keep your nose clean.", true);
        elseif success and (type(result) == "table" and result.error == "funds") then
            u153:_addHistoryLine(string_upper_ret, "You don\'t have it. Come back when you do.", true);
        else
            u153:_addHistoryLine(string_upper_ret, "Not now. Come back later.", true);
        end;

        task.delay(2.5, function() -- Line: 1374
            -- upvalues: u153 (ref)
            if u153.IsOpen then
                u153:_returnToNpcMenu();
            end;
        end);
    end;

    u159 = u159 + 1;
    local v169 = makeChoiceButton(u153.ChoicesFrame, u159 .. ". " .. u166, u159);
    v169.MouseButton1Click:Connect(function() -- Line: 1348
        -- upvalues: u153 (copy), u168 (copy), u166 (copy)
        if u153.IsOpen then
            u168(u166);
        end;
    end);
    v169.TextColor3 = Color3.fromRGB(255, 200, 90);

    local function u170() -- Line: 1377
        -- upvalues: u153 (copy)
        u153:_returnToNpcMenu();
    end;

    u159 = u159 + 1;
    local u171 = "Not today.";
    makeChoiceButton(u153.ChoicesFrame, u159 .. ". Not today.", u159).MouseButton1Click:Connect(function() -- Line: 1348
        -- upvalues: u153 (copy), u170 (copy), u171 (copy)
        if u153.IsOpen then
            u170(u171);
        end;
    end);
end;

function v6._findTutorialTask(p172) -- Line: 1381
    -- upvalues: ReplicatedStorage (copy)
    local success, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3));

    if not (success and result) then
        return nil, nil;
    end;

    for _, v in ipairs(result:GetActiveTasks() or {}) do
        if v.params and v.params.isTutorial then
            return v, result;
        end;
    end;

    return nil, result;
end;

function v6._runTutorialSellLesson(u173, p174) -- Line: 1394
    -- upvalues: makeChoiceButton (copy), ReplicatedStorage (copy)
    local string_upper_ret = string.upper(u173.CurrentProfile and u173.CurrentProfile.DisplayName or (p174.Name or "CROW"));
    u173:_clearChoicesUI();
    u173:_addHistoryLine(string_upper_ret, "That\'s a start. Nobody out here pays you for being brave. They pay you for what you carry back.", true);
    u173:_addHistoryLine(string_upper_ret, "Meat sells. Parts sell better, a tail or a leg if the animal gives you one. Loot sells. Guns sell if they still shoot.", true);
    u173:_addHistoryLine(string_upper_ret, "Traders post jobs too. Kill this, fetch that. Jobs pay best, if you live through them.", true);
    u173:_addHistoryLine(string_upper_ret, "Now sell me that meat. Open Trade, drag it onto my side, and confirm. Lost it? Butcher another kill.", true);
    makeChoiceButton(u173.ChoicesFrame, "1. Show me.", 1).MouseButton1Click:Connect(function() -- Line: 1402
        -- upvalues: u173 (copy), ReplicatedStorage (ref)
        if not u173.IsOpen then
            return;
        end;

        local CurrentNPC = u173.CurrentNPC;
        u173.IsOpen = false;
        u173.Gui.Enabled = false;
        u173._tree = nil;
        u173._currentNode = nil;
        u173._history = nil;
        u173:_clearHistoryUI();
        u173:_clearChoicesUI();
        u173.CurrentNPC = nil;
        u173.CurrentProfile = nil;
        local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

        if Remotes then
            Remotes = Remotes:FindFirstChild("OpenTraderFromMenu");
        end;

        if Remotes and CurrentNPC then
            Remotes:FireServer(CurrentNPC);
        end;
    end);
end;

function v6._runTutorialTurnIn(u175, p176) -- Line: 1426
    -- upvalues: makeChoiceButton (copy)
    local string_upper_ret = string.upper(u175.CurrentProfile and u175.CurrentProfile.DisplayName or (p176.Name or "CROW"));
    u175:_clearChoicesUI();
    u175:_addHistoryLine(string_upper_ret, "Clean work. That\'s how you eat out here. Kill, cut, carry, sell.", true);
    u175:_addHistoryLine(string_upper_ret, "One more thing, and listen close. When the sky turns red and the air starts to hum, that\'s an emission.", true);
    u175:_addHistoryLine(string_upper_ret, "You\'ll get a warning on your PDA. When it comes, get under a solid roof and stay there until it passes. Out in the open it kills you in seconds, and no armour stops it.", true);
    u175:_addHistoryLine(string_upper_ret, "Here\'s your pay. Now go make a living.", true);
    makeChoiceButton(u175.ChoicesFrame, "1. Understood.", 1).MouseButton1Click:Connect(function() -- Line: 1434
        -- upvalues: u175 (copy)
        if not u175.IsOpen then
            return;
        end;

        local v177, v178 = u175:_findTutorialTask();

        if v177 and v178 then
            u175:_onTurnInClicked(v177, v178, "Understood.");

            return;
        end;

        u175:Close();
    end);
end;

function v6._runSimpleTraderIntro(u179, p180) -- Line: 1454
    -- upvalues: makeChoiceButton (copy)
    local CurrentProfile = u179.CurrentProfile;
    local string_upper_ret = string.upper(CurrentProfile and CurrentProfile.DisplayName or (p180.Name or "TRADER"));
    local u181 = CurrentProfile and CurrentProfile.IntroLine or "(no intro configured)";
    u179:_clearChoicesUI();
    makeChoiceButton(u179.ChoicesFrame, "1. Who are you?", 1).MouseButton1Click:Connect(function() -- Line: 1461
        -- upvalues: u179 (copy), string_upper_ret (copy), u181 (copy), makeChoiceButton (ref)
        if not u179.IsOpen then
            return;
        end;

        u179:_addHistoryLine("PLAYER", "Who are you?", false);
        u179:_clearChoicesUI();
        u179:_addHistoryLine(string_upper_ret, u181, true);
        task.delay(0.6, function() -- Line: 1467
            -- upvalues: u179 (ref), makeChoiceButton (ref)
            if not u179.IsOpen then
                return;
            end;

            makeChoiceButton(u179.ChoicesFrame, "1. Understood.", 1).MouseButton1Click:Connect(function() -- Line: 1470
                -- upvalues: u179 (ref)
                if not u179.IsOpen then
                    return;
                end;

                u179:_addHistoryLine("PLAYER", "Understood.", false);
                u179:_clearChoicesUI();
                task.delay(0.4, function() -- Line: 1474
                    -- upvalues: u179 (ref)
                    if u179.IsOpen then
                        u179:Close();
                    end;
                end);
            end);
        end);
    end);
end;

function v6._runExtractDialog(u182, u183) -- Line: 1482
    -- upvalues: makeChoiceButton (copy), ReplicatedStorage (copy)
    local string_upper_ret = string.upper(u182.CurrentProfile and u182.CurrentProfile.DisplayName or (u183.Name or "GUIDE"));
    u182:_addHistoryLine(string_upper_ret, "Need a ride out of the Zone?", true);
    u182:_addHistoryLine(string_upper_ret, "I\'ll drop you back at the warehouse. Whatever you\'re carrying comes with you.", true);
    u182:_clearChoicesUI();
    local v184 = makeChoiceButton(u182.ChoicesFrame, "1. Get me out of here.", 1);
    v184.TextColor3 = Color3.fromRGB(150, 210, 140);
    v184.MouseButton1Click:Connect(function() -- Line: 1491
        -- upvalues: u182 (copy), ReplicatedStorage (ref), u183 (copy), string_upper_ret (copy)
        if not u182.IsOpen then
            return;
        end;

        u182:_addHistoryLine("PLAYER", "Get me out of here.", false);
        u182:_clearChoicesUI();
        local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5);

        if Remotes then
            Remotes = Remotes:FindFirstChild("RequestExtract");
        end;

        if Remotes then
            Remotes:FireServer(u183);
        end;

        u182:_addHistoryLine(string_upper_ret, "Saving your gear. Hold on.", true);
    end);
    local v185 = 2;
    local success, result = pcall(require, ReplicatedStorage:WaitForChild("PlaceConfig", 2));

    if success and (result and result.Id == "cordon") then
        local v186 = makeChoiceButton(u182.ChoicesFrame, v185 .. ". I need to get to the Swamps.", v185);
        v186.TextColor3 = Color3.fromRGB(255, 200, 90);
        v186.MouseButton1Click:Connect(function() -- Line: 1509
            -- upvalues: u182 (copy), u183 (copy), string_upper_ret (copy)
            if u182.IsOpen then
                u182:_runPassage(u183, string_upper_ret);
            end;
        end);
        v185 = v185 + 1;
    end;

    makeChoiceButton(u182.ChoicesFrame, v185 .. ". Maybe later.", v185).MouseButton1Click:Connect(function() -- Line: 1516
        -- upvalues: u182 (copy)
        if not u182.IsOpen then
            return;
        end;

        u182:_addHistoryLine("PLAYER", "Maybe later.", false);
        u182:_clearChoicesUI();
        task.delay(1, function() -- Line: 1520
            -- upvalues: u182 (ref)
            if u182.IsOpen then
                u182:Close();
            end;
        end);
    end);
end;

function v6._runPassage(u187, u188, u189) -- Line: 1529
    -- upvalues: ReplicatedStorage (copy), makeChoiceButton (copy)
    u187:_addHistoryLine("PLAYER", "I need to get to the Swamps.", false);
    u187:_clearChoicesUI();
    local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

    if Remotes then
        Remotes = Remotes:FindFirstChild("SwampsPassage");
    end;

    local v190, v191;

    if Remotes then
        v190, v191 = pcall(function() -- Line: 1535
            -- upvalues: Remotes (copy), u188 (copy)
            return Remotes:InvokeServer(u188, false);
        end);
    else
        v190 = false;
        v191 = nil;
    end;

    local function bye(p192) -- Line: 1537
        -- upvalues: u187 (copy), u189 (copy)
        u187:_addHistoryLine(u189, p192, true);
        task.delay(2.5, function() -- Line: 1539
            -- upvalues: u187 (ref)
            if u187.IsOpen then
                u187:Close();
            end;
        end);
    end;

    if not v190 or type(v191) ~= "table" then
        return bye("Not now. Come back later.");
    end;

    if not v191.ok then
        if v191.error == "tutorial" then
            return bye("Crow hasn\'t even finished with you yet. Go see him.");
        end;

        return bye("Not now. Come back later.");
    end;

    local math_floor_ret = math.floor(v191.fee);
    local u193 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    u187:_addHistoryLine(u189, "The Swamps? Already?", true);
    u187:_addHistoryLine(u189, "Fine. I know the road.", true);
    u187:_addHistoryLine(u189, ("%s roubles gets you to the entrance and keeps your hide intact on the way."):format(u193), true);
    u187:_addHistoryLine(u189, "Just you. No friends, no squad.", true);
    u187:_addHistoryLine(u189, "Once we get there, you\'re on your own.", true);
    local v194 = makeChoiceButton(u187.ChoicesFrame, ("1. Pay %s roubles."):format(u193), 1);
    v194.TextColor3 = Color3.fromRGB(255, 200, 90);
    v194.MouseButton1Click:Connect(function() -- Line: 1557
        -- upvalues: u187 (copy), u193 (copy), Remotes (copy), u188 (copy), u189 (copy)
        if not u187.IsOpen then
            return;
        end;

        u187:_addHistoryLine("PLAYER", ("Pay %s roubles."):format(u193), false);
        u187:_clearChoicesUI();
        local success, result = pcall(function() -- Line: 1561
            -- upvalues: Remotes (ref), u188 (ref)
            return Remotes:InvokeServer(u188, true);
        end);

        if success and (type(result) == "table" and result.ok) then
            u187:_addHistoryLine(u189, "Stay close. We\'re moving.", true);
            task.delay(2.5, function() -- Line: 1539
                -- upvalues: u187 (ref)
                if u187.IsOpen then
                    u187:Close();
                end;
            end);

            return;
        end;

        if success and (type(result) == "table" and result.error == "funds") then
            u187:_addHistoryLine(u189, "You don\'t have it. Come back when you do.", true);
            task.delay(2.5, function() -- Line: 1539
                -- upvalues: u187 (ref)
                if u187.IsOpen then
                    u187:Close();
                end;
            end);

            return;
        end;

        if success and (type(result) == "table" and result.error == "busy") then
            u187:_addHistoryLine(u189, "We\'re already going. Keep up.", true);
            task.delay(2.5, function() -- Line: 1539
                -- upvalues: u187 (ref)
                if u187.IsOpen then
                    u187:Close();
                end;
            end);

            return;
        end;

        u187:_addHistoryLine(u189, "Not now. Come back later.", true);
        task.delay(2.5, function() -- Line: 1539
            -- upvalues: u187 (ref)
            if u187.IsOpen then
                u187:Close();
            end;
        end);
    end);
    makeChoiceButton(u187.ChoicesFrame, "2. Not yet.", 2).MouseButton1Click:Connect(function() -- Line: 1573
        -- upvalues: u187 (copy), u189 (copy)
        if not u187.IsOpen then
            return;
        end;

        u187:_addHistoryLine("PLAYER", "Not yet.", false);
        u187:_clearChoicesUI();
        u187:_addHistoryLine(u189, "Then Crow\'s your man. He\'s cheaper, if you can stand him.", true);
        task.delay(2.5, function() -- Line: 1539
            -- upvalues: u187 (ref)
            if u187.IsOpen then
                u187:Close();
            end;
        end);
    end);
end;

function v6.Close(p195) -- Line: 1581
    -- upvalues: ReplicatedStorage (copy)
    if not p195.IsOpen then
        return;
    end;

    p195.IsOpen = false;
    p195.Gui.Enabled = false;
    p195.CurrentNPC = nil;
    p195.CurrentProfile = nil;
    p195._tree = nil;
    p195._currentNode = nil;
    p195._history = nil;
    p195._lastNpcFinishTime = 0;
    p195:_clearHistoryUI();
    p195:_clearChoicesUI();
    local success, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1));

    if success and (result and result.IsOpen) then
        result:Close();
    end;
end;

function v6._addRewardLine(u196, p197) -- Line: 1601
    -- upvalues: Font_new_ret2 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "RewardLine";
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.new(1, 0, 0, 18);
    Frame.AutomaticSize = Enum.AutomaticSize.Y;
    Frame.LayoutOrder = #u196.HistoryFrame:GetChildren();
    Frame.Parent = u196.HistoryFrame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, -16, 0, 18);
    TextLabel.Position = UDim2.fromOffset(16, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextColor3 = Color3.fromRGB(140, 200, 120);
    TextLabel.TextSize = 16;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextWrapped = true;
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel.Text = p197;
    TextLabel.Parent = Frame;
    task.defer(function() -- Line: 1621
        -- upvalues: u196 (copy)
        if u196.HistoryFrame and u196.HistoryFrame.Parent then
            u196.HistoryFrame.CanvasPosition = Vector2.new(0, u196.HistoryFrame.AbsoluteCanvasSize.Y);
        end;
    end);
end;

function v6._returnToNpcMenu(p198) -- Line: 1630
    -- upvalues: ReplicatedStorage (copy)
    p198.IsOpen = false;
    p198.Gui.Enabled = false;
    p198._tree = nil;
    p198._currentNode = nil;
    p198._history = nil;
    p198:_clearHistoryUI();
    p198:_clearChoicesUI();
    local CurrentNPC = p198.CurrentNPC;
    p198.CurrentNPC = nil;
    p198.CurrentProfile = nil;

    if not CurrentNPC then
        return;
    end;

    local success, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1));

    if success and (result and (result.IsOpen and (result.CurrentNPC == CurrentNPC and result.Gui))) then
        result.Gui.Enabled = true;
    end;
end;

function v6._performTake(p199, p200) -- Line: 1652
    -- upvalues: ReplicatedStorage (copy)
    local success, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3));

    if not (success and result) then
        return;
    end;

    local v201 = nil;
    local CurrentNPC = p199.CurrentNPC;
    local CurrentProfile = p199.CurrentProfile;
    local v202, v203;

    if type(p200.onTake) == "function" then
        v202, v203, v201 = p200.onTake();
    else
        v203 = result:AcceptOffer(p200.id);

        if v203 then
            v202 = v203.ok;
        else
            v202 = v203;
        end;

        if v203 then
            v203 = v203.error;
        end;
    end;

    if v202 then
        p199.IsOpen = false;
        p199.Gui.Enabled = false;
        p199._tree = nil;
        p199._currentNode = nil;
        p199._history = nil;
        p199:_clearHistoryUI();
        p199:_clearChoicesUI();
        p199.CurrentNPC = nil;
        p199.CurrentProfile = nil;
        local success2, result2 = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1));

        if success2 and (result2 and result2.IsOpen) then
            result2:Close();
        end;

        if type(v201) == "string" and v201 ~= "" then
            p199:SayLine(CurrentNPC, CurrentProfile, v201);
        end;
    else
        result:ShowToast(({
            no_package_space = "Not enough inventory space for the package",
            task_cap_reached = "Task limit reached",
            offer_expired = "That contract\'s already gone",
            locked = "Crow doesn\'t trust you with that yet",
            already_active = "Finish what you\'re already carrying first",
            already_done = "That\'s behind you now",
            wrong_place = "Not here. That\'s Zone business.",
            no_room = "No room for what he\'s handing you",
            unavailable = "Couldn\'t do that right now"
        })[v203 or "unknown"] or "Couldn\'t accept task");
        p199:_openWorkPanelHandoff();
    end;
end;

function v6._onBriefingChoice(p204, p205, p206, p207) -- Line: 1710
    p204:_addHistoryLine("PLAYER", p206, false);

    if p205 == "take" then
        p204:_performTake(p207);

        return;
    end;

    if p205 == "else" then
        p204:_openWorkPanelHandoff();

        return;
    end;

    if p205 == "pass" then
        p204:_returnToNpcMenu();
    end;
end;

function v6.SayLine(u208, p209, p210, p211, p212) -- Line: 1728
    -- upvalues: makeChoiceButton (copy)
    if u208.IsOpen then
        return false;
    end;

    if not p211 or p211 == "" then
        return false;
    end;

    u208.IsOpen = true;
    u208.CurrentNPC = p209;
    u208.CurrentProfile = p210;
    local string_upper_ret = string.upper(p210 and p210.DisplayName or (p209 and p209.Name or "NPC"));
    u208.NpcName.Text = string_upper_ret;
    u208._history = {};
    u208._lastNpcFinishTime = 0;
    u208._tree = nil;
    u208._currentNode = nil;
    u208:_clearHistoryUI();
    u208:_clearChoicesUI();
    u208.Gui.Enabled = true;
    u208:_addHistoryLine(string_upper_ret, p211, true);
    makeChoiceButton(u208.ChoicesFrame, "1. " .. (p212 or "Right."), 1).MouseButton1Click:Connect(function() -- Line: 1747
        -- upvalues: u208 (copy)
        if not u208.IsOpen then
            return;
        end;

        u208:_returnToNpcMenu();
    end);

    return true;
end;

function v6.OpenBriefingTopics(u213, p214, p215, u216) -- Line: 1779
    -- upvalues: topicReady (copy), makeChoiceButton (copy)
    if u213.IsOpen then
        return false;
    end;

    if not (u216 and u216.intro) then
        return false;
    end;

    u213.IsOpen = true;
    u213.CurrentNPC = p214;
    u213.CurrentProfile = p215;
    local string_upper_ret = string.upper(p215 and p215.DisplayName or (p214 and p214.Name or "NPC"));
    u213.NpcName.Text = string_upper_ret;
    u213._history = {};
    u213._lastNpcFinishTime = 0;
    u213._tree = nil;
    u213._currentNode = nil;
    u213:_clearHistoryUI();
    u213:_clearChoicesUI();
    u213.Gui.Enabled = true;
    u213:_addHistoryLine(string_upper_ret, u216.intro, true);
    local v217 = u216.rewards and (u216.rewards.money or 0) or 0;
    local v218 = u216.rewards and type(u216.rewards.rep) == "number" and (u216.rewards.rep or 0) or 0;

    if v217 > 0 then
        u213:_addRewardLine(string.format("Reward: %d₽", v217) .. (v218 > 0 and string.format(" + %d Loner rep", v218) or ""));
    end;

    local u219 = {};

    local function u223() -- Line: 1807
        -- upvalues: u213 (copy), u216 (copy), u219 (copy), topicReady (ref), makeChoiceButton (ref), string_upper_ret (copy), u223 (ref)
        u213:_clearChoicesUI();
        local v220 = 0;

        for _, v in ipairs(u216.topics or {}) do
            if not u219[v.id] and topicReady(v, u219) then
                v220 = v220 + 1;
                makeChoiceButton(u213.ChoicesFrame, v220 .. ". " .. v.ask, v220).MouseButton1Click:Connect(function() -- Line: 1815
                    -- upvalues: u213 (ref), u219 (ref), v (copy), string_upper_ret (ref), u223 (ref)
                    if not u213.IsOpen or u219[v.id] then
                        return;
                    end;

                    u219[v.id] = true;
                    u213:_addHistoryLine("PLAYER", v.ask, false);
                    u213:_addHistoryLine(string_upper_ret, v.say, true);
                    u223();
                end);
            end;
        end;

        local v221 = v220 + 1;
        makeChoiceButton(u213.ChoicesFrame, v221 .. ". " .. (u216.accept or "I\'ll take it."), v221).MouseButton1Click:Connect(function() -- Line: 1827
            -- upvalues: u213 (ref), u216 (ref)
            if not u213.IsOpen then
                return;
            end;

            u213:_addHistoryLine("PLAYER", u216.accept or "I\'ll take it.", false);
            u213:_performTake({
                id = u216.id,
                onTake = u216.onTake
            });
        end);
        local v222 = v221 + 1;
        makeChoiceButton(u213.ChoicesFrame, v222 .. ". " .. (u216.decline or "I\'ll pass."), v222).MouseButton1Click:Connect(function() -- Line: 1835
            -- upvalues: u213 (ref)
            if not u213.IsOpen then
                return;
            end;

            u213:_returnToNpcMenu();
        end);
    end;

    u223();

    return true;
end;

function v6.OpenTurnIn(u224, p225, p226, u227) -- Line: 1867
    -- upvalues: topicReady (copy), makeChoiceButton (copy), ReplicatedStorage (copy)
    if u224.IsOpen then
        return false;
    end;

    if not (u227 and (u227.intro and type(u227.onTurnIn) == "function")) then
        return false;
    end;

    u224.IsOpen = true;
    u224.CurrentNPC = p225;
    u224.CurrentProfile = p226;
    local string_upper_ret = string.upper(p226 and p226.DisplayName or (p225 and p225.Name or "NPC"));
    u224.NpcName.Text = string_upper_ret;
    u224._history = {};
    u224._lastNpcFinishTime = 0;
    u224._tree = nil;
    u224._currentNode = nil;
    u224:_clearHistoryUI();
    u224:_clearChoicesUI();
    u224.Gui.Enabled = true;
    local v228 = u227.rewards and (u227.rewards.money or 0) or 0;
    local u229 = {};
    local v230 = false;

    if type(u227.asked) == "table" then
        for i, v in pairs(u227.asked) do
            if v then
                u229[i] = true;
                v230 = true;
            end;
        end;
    end;

    local u231 = false;
    u224:_addHistoryLine(string_upper_ret, v230 and u227.resumeIntro or u227.intro, true);

    if v228 > 0 then
        u224:_addRewardLine(string.format("Reward: %d₽", v228));
    end;

    local function u252() -- Line: 1910
        -- upvalues: u224 (copy), u227 (copy), u229 (copy), topicReady (ref), makeChoiceButton (ref), u231 (ref), string_upper_ret (copy), u252 (ref), ReplicatedStorage (ref)
        u224:_clearChoicesUI();
        local v232 = 0;

        for _, v in ipairs(u227.topics or {}) do
            if not u229[v.id] and topicReady(v, u229) then
                v232 = v232 + 1;
                makeChoiceButton(u224.ChoicesFrame, v232 .. ". " .. v.ask, v232).MouseButton1Click:Connect(function() -- Line: 1918
                    -- upvalues: u224 (ref), u231 (ref), u229 (ref), v (copy), string_upper_ret (ref), u227 (ref), u252 (ref)
                    if not u224.IsOpen or (u231 or u229[v.id]) then
                        return;
                    end;

                    u229[v.id] = true;
                    u224:_addHistoryLine("PLAYER", v.ask, false);
                    u224:_addHistoryLine(string_upper_ret, v.say, true);

                    if type(u227.onAsk) == "function" then
                        pcall(u227.onAsk, v.id);
                    end;

                    u252();
                end);
            end;
        end;

        local v233 = true;

        for _, v in ipairs(u227.acceptRequires or {}) do
            if not u229[v] then
                v233 = false;
                break;
            end;
        end;

        if v233 then
            v232 = v232 + 1;
            local v234, v235, u236;

            if type(u227.resolveAccept) == "function" then
                v234, v235, u236 = u227.resolveAccept(u229);
            else
                v234 = nil;
                v235 = nil;
                u236 = nil;
            end;

            local v237 = v234 or (u227.accept or "Here.");
            local u238 = v235 or v237;
            u224:_setPriceTag(u236);
            makeChoiceButton(u224.ChoicesFrame, v232 .. ". " .. v237, v232).MouseButton1Click:Connect(function() -- Line: 1963
                -- upvalues: u224 (ref), u231 (ref), u238 (ref), u227 (ref), u236 (ref), ReplicatedStorage (ref), string_upper_ret (ref), makeChoiceButton (ref), u252 (ref)
                if not u224.IsOpen or u231 then
                    return;
                end;

                u231 = true;
                u224:_addHistoryLine("PLAYER", u238, false);
                u224:_clearChoicesUI();
                local v239, v240, v241, v242 = u227.onTurnIn();

                if not u224.IsOpen then
                    return;
                end;

                if not v239 then
                    local v243 = ({
                        missing_item = "You don\'t have what he\'s waiting for",
                        not_ready = "That\'s not finished yet",
                        wrong_place = "Not here. That\'s Zone business.",
                        no_active = "Nothing to hand over",
                        not_enough = "You don\'t have that kind of money"
                    })[v240 or "unknown"] or "Couldn\'t hand that over right now";
                    local success, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3));

                    if success and result then
                        result:ShowToast(v243);
                    end;

                    u231 = false;
                    u252();

                    return;
                end;

                local v244 = tonumber(v242) or u236;

                if v244 and v244 > 0 then
                    u224:_addTransactionLine(v244);
                    local success, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3));

                    if success and (result and result.ShowToast) then
                        local string_format = string.format;
                        local v245 = tonumber(v244) or 0;
                        local math_floor_ret = math.floor(v245);
                        result:ShowToast(string_format("Paid %s₽", (tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))));
                    end;
                end;

                if v241 and v241 ~= "" then
                    u224:_addHistoryLine(string_upper_ret, v241, true);
                end;

                local u246 = {};

                local function u249() -- Line: 2003
                    -- upvalues: u224 (ref), u227 (ref), u246 (copy), makeChoiceButton (ref), string_upper_ret (ref), u249 (ref)
                    u224:_clearChoicesUI();
                    local v247 = 0;

                    for _, v in ipairs(u227.afterTopics or {}) do
                        if not u246[v.id] then
                            v247 = v247 + 1;
                            makeChoiceButton(u224.ChoicesFrame, v247 .. ". " .. v.ask, v247).MouseButton1Click:Connect(function() -- Line: 2011
                                -- upvalues: u224 (ref), u246 (ref), v (copy), string_upper_ret (ref), u249 (ref)
                                if not u224.IsOpen or u246[v.id] then
                                    return;
                                end;

                                u246[v.id] = true;
                                u224:_addHistoryLine("PLAYER", v.ask, false);
                                u224:_addHistoryLine(string_upper_ret, v.say, true);
                                u249();
                            end);
                        end;
                    end;

                    local v248 = v247 + 1;
                    makeChoiceButton(u224.ChoicesFrame, v248 .. ". " .. (u227.close or "Right."), v248).MouseButton1Click:Connect(function() -- Line: 2022
                        -- upvalues: u224 (ref)
                        if not u224.IsOpen then
                            return;
                        end;

                        u224:_returnToNpcMenu();
                    end);
                end;

                u249();
            end);
        end;

        local v250 = v232 + 1;
        makeChoiceButton(u224.ChoicesFrame, v250 .. ". " .. (u227.decline or "Not yet."), v250).MouseButton1Click:Connect(function() -- Line: 2046
            -- upvalues: u224 (ref), u231 (ref)
            if not u224.IsOpen or u231 then
                return;
            end;

            u224:_returnToNpcMenu();
        end);

        if u227.breakOff then
            local v251 = v250 + 1;
            makeChoiceButton(u224.ChoicesFrame, v251 .. ". " .. u227.breakOff, v251).MouseButton1Click:Connect(function() -- Line: 2058
                -- upvalues: u224 (ref), u231 (ref), u227 (ref), string_upper_ret (ref), makeChoiceButton (ref)
                if not u224.IsOpen or u231 then
                    return;
                end;

                u231 = true;
                u224:_addHistoryLine("PLAYER", u227.breakOff, false);

                if u227.breakSay and u227.breakSay ~= "" then
                    u224:_addHistoryLine(string_upper_ret, u227.breakSay, true);
                end;

                if type(u227.onBreak) == "function" then
                    pcall(u227.onBreak);
                end;

                u224:_clearChoicesUI();
                makeChoiceButton(u224.ChoicesFrame, "1. " .. (u227.breakClose or "..."), 1).MouseButton1Click:Connect(function() -- Line: 2068
                    -- upvalues: u224 (ref)
                    if not u224.IsOpen then
                        return;
                    end;

                    u224:_returnToNpcMenu();
                end);
            end);
        end;
    end;

    u252();

    return true;
end;

function v6.OpenBriefing(u253, p254, p255, u256) -- Line: 2083
    -- upvalues: makeChoiceButton (copy)
    if u253.IsOpen then
        return;
    end;

    if not u256 then
        return;
    end;

    u253.IsOpen = true;
    u253.CurrentNPC = p254;
    u253.CurrentProfile = p255;
    local string_upper_ret = string.upper(p255 and p255.DisplayName or (p254 and p254.Name or "NPC"));
    u253.NpcName.Text = string_upper_ret;
    u253._history = {};
    u253._lastNpcFinishTime = 0;
    u253._tree = nil;
    u253._currentNode = nil;
    u253:_clearHistoryUI();
    u253:_clearChoicesUI();
    u253.Gui.Enabled = true;
    u253:_addHistoryLine(string_upper_ret, u256.briefing or (u256.description or "..."), true);
    local v257 = u256.rewards or {};
    local v258 = v257.rep and (v257.rep.amount or 0) or 0;
    local v259 = v257.rep and v257.rep.faction or "?";
    local string_format_ret = string.format("Reward: %d₽", v257.money or 0);

    if v258 > 0 then
        string_format_ret = string_format_ret .. string.format("  +%d %s rep", v258, v259);
    end;

    u253:_addRewardLine(string_format_ret);

    for i, v in ipairs({ {
            text = "I\'ll take it.",
            action = "take"
        }, {
            text = "Got anything else?",
            action = "else"
        }, {
            text = "I\'ll pass.",
            action = "pass"
        } }) do
        makeChoiceButton(u253.ChoicesFrame, tostring(i) .. ". " .. v.text, i).MouseButton1Click:Connect(function() -- Line: 2121
            -- upvalues: u253 (copy), v (copy), u256 (copy)
            if u253.IsOpen then
                u253:_onBriefingChoice(v.action, v.text, u256);
            end;
        end);
    end;
end;

return v6;