-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = nil;
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local ContainerVisibility = require(ReplicatedStorage:WaitForChild("ContainerVisibility"));
local ConditionValue = require(game:GetService("ReplicatedStorage"):WaitForChild("ConditionValue"));
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"));
local RepairPricing = require(ReplicatedStorage:WaitForChild("RepairPricing"));
local TechnicianRepair = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TechnicianRepair");
local UITheme = require(ReplicatedStorage:WaitForChild("InventoryController"):WaitForChild("UITheme"));
local C = UITheme.C;
local HEADER_FONT = UITheme.HEADER_FONT;
local BODY_FONT = UITheme.BODY_FONT;
local BODY_FONT_BOLD = UITheme.BODY_FONT_BOLD;
local Color3_fromRGB_ret = Color3.fromRGB(20, 18, 15);
local Color3_fromRGB_ret2 = Color3.fromRGB(96, 34, 28);
local Color3_fromRGB_ret3 = Color3.fromRGB(64, 26, 22);
local Color3_fromRGB_ret4 = Color3.fromRGB(120, 50, 44);
local Color3_fromRGB_ret5 = Color3.fromRGB(26, 33, 24);
local Color3_fromRGB_ret6 = Color3.fromRGB(62, 84, 52);
local Color3_fromRGB_ret7 = Color3.fromRGB(160, 210, 130);
local Layout = require(script:WaitForChild("Layout"));
local v2 = {};
v2.__index = v2;
local TraderCategories = require(ReplicatedStorage:WaitForChild("TraderCategories"));
local TABS = TraderCategories.TABS;
local u3 = { "Default", "Price: low to high", "Price: high to low", "Name" };
local UDim2_new_ret = UDim2.new(0.3333333333333333, -6, 0, 150);
local UDim2_fromOffset_ret = UDim2.fromOffset(8, 8);
local u4 = {
    BUY = "Click an item to add it to the cart.",
    SELL = "Click your items to put them up for sale.",
    REPAIR = "Each repair is paid for on its own card."
};
v2.Gui = nil;
v2.MainFrame = nil;
v2.ResScale = nil;
v2.IsOpen = false;
v2.CurrentTrader = nil;
v2.Stock = {};
v2.SelectedTab = "All";
v2.Mode = "BUY";
v2.SellQueue = {};
v2.SearchQuery = nil;
v2.SortMode = 1;
v2.ShowLocked = true;
v2._roubleBalance = 0;

function v2.Init(p5) -- Line: 106
    if p5.Gui then
        return;
    end;

    p5:_buildGui();
    p5:_wireResScale();
    p5:_wireRemotes();
    p5:_wireInput();
    p5:_wireSearch();
    p5:_wireDeathClose();
    p5.Gui.Enabled = false;
    print("[TraderController] initialized");
end;

local function newLabel(p6, p7, p8, p9, p10, p11, p12, p13) -- Line: 127
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p6;
    TextLabel.Size = p8;
    TextLabel.Position = p9;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = p10;
    TextLabel.TextSize = p11;
    TextLabel.TextColor3 = p12;
    TextLabel.TextXAlignment = p13 or Enum.TextXAlignment.Left;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Text = "";
    TextLabel.Parent = p7;

    return TextLabel;
end;

function v2._buildGui(p14) -- Line: 143
    -- upvalues: LocalPlayer (copy), C (copy), HEADER_FONT (copy), BODY_FONT (copy), BODY_FONT_BOLD (copy), Color3_fromRGB_ret2 (copy), TABS (copy), u3 (copy), UDim2_new_ret (copy), UDim2_fromOffset_ret (copy), Color3_fromRGB_ret (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "TraderGui";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.DisplayOrder = 5;
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
    local Frame = Instance.new("Frame");
    Frame.Name = "MainFrame";
    Frame.Size = UDim2.fromScale(0.315, 0.8);
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.8395, 0.5);
    Frame.BackgroundColor3 = C.panel;
    Frame.BackgroundTransparency = 0;
    Frame.BorderSizePixel = 0;
    Frame.Parent = ScreenGui;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = C.edge;
    UIStroke.Transparency = 0;
    UIStroke.Thickness = 1;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = Frame;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 186, 178)) });
    UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.04), NumberSequenceKeypoint.new(1, 0.12) });
    UIGradient.Rotation = -90;
    UIGradient.Parent = Frame;
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "ResScale";
    UIScale.Scale = 1;
    UIScale.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Header";
    Frame2.Size = UDim2.new(1, 0, 0, 64);
    Frame2.BackgroundColor3 = C.header;
    Frame2.BackgroundTransparency = 0;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = C.inner;
    UIStroke2.Transparency = 0;
    UIStroke2.Thickness = 1;
    UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke2.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Mark";
    Frame3.Size = UDim2.fromOffset(3, 26);
    Frame3.Position = UDim2.fromOffset(10, 9);
    Frame3.BackgroundColor3 = C.amber;
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = Frame2;
    local UDim2_new_ret2 = UDim2.new(1, -250, 0, 30);
    local UDim2_fromOffset_ret2 = UDim2.fromOffset(20, 6);
    local paper = C.paper;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "TraderName";
    TextLabel.Size = UDim2_new_ret2;
    TextLabel.Position = UDim2_fromOffset_ret2;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = HEADER_FONT;
    TextLabel.TextSize = 26;
    TextLabel.TextColor3 = paper;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Text = "";
    TextLabel.Parent = Frame2;
    TextLabel.Text = "TRADER";
    local UDim2_new_ret3 = UDim2.new(1, -250, 0, 18);
    local UDim2_fromOffset_ret3 = UDim2.fromOffset(20, 38);
    local dim = C.dim;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "TraderSub";
    TextLabel2.Size = UDim2_new_ret3;
    TextLabel2.Position = UDim2_fromOffset_ret3;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = BODY_FONT;
    TextLabel2.TextSize = 14;
    TextLabel2.TextColor3 = dim;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel2.Text = "";
    TextLabel2.Parent = Frame2;
    local UDim2_fromOffset_ret4 = UDim2.fromOffset(170, 14);
    local UDim2_new_ret4 = UDim2.new(1, -228, 0, 12);
    local faint = C.faint;
    local Right = Enum.TextXAlignment.Right;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Name = "BalanceCaption";
    TextLabel3.Size = UDim2_fromOffset_ret4;
    TextLabel3.Position = UDim2_new_ret4;
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = BODY_FONT_BOLD;
    TextLabel3.TextSize = 12;
    TextLabel3.TextColor3 = faint;
    TextLabel3.TextXAlignment = Right or Enum.TextXAlignment.Left;
    TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel3.Text = "";
    TextLabel3.Parent = Frame2;
    TextLabel3.Text = "YOUR ROUBLES";
    local UDim2_fromOffset_ret5 = UDim2.fromOffset(170, 26);
    local UDim2_new_ret5 = UDim2.new(1, -228, 0, 27);
    local money = C.money;
    local Right2 = Enum.TextXAlignment.Right;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.Name = "BalanceValue";
    TextLabel4.Size = UDim2_fromOffset_ret5;
    TextLabel4.Position = UDim2_new_ret5;
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = HEADER_FONT;
    TextLabel4.TextSize = 22;
    TextLabel4.TextColor3 = money;
    TextLabel4.TextXAlignment = Right2 or Enum.TextXAlignment.Left;
    TextLabel4.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel4.Text = "";
    TextLabel4.Parent = Frame2;
    TextLabel4.Text = "₽0";
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "CloseButton";
    TextButton.Size = UDim2.fromOffset(36, 36);
    TextButton.Position = UDim2.new(1, -48, 0.5, -18);
    TextButton.Text = "X";
    TextButton.TextColor3 = C.paper;
    TextButton.TextSize = 20;
    TextButton.FontFace = BODY_FONT_BOLD;
    TextButton.BackgroundColor3 = Color3_fromRGB_ret2;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = true;
    TextButton.Parent = Frame2;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "ToggleHolder";
    Frame4.Size = UDim2.new(1, 0, 0, 40);
    Frame4.Position = UDim2.fromOffset(0, 64);
    Frame4.BackgroundColor3 = C.slot;
    Frame4.BackgroundTransparency = 0;
    Frame4.BorderSizePixel = 0;
    Frame4.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 6);
    UIListLayout.Parent = Frame4;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 5);
    UIPadding.PaddingBottom = UDim.new(0, 5);
    UIPadding.PaddingLeft = UDim.new(0, 6);
    UIPadding.PaddingRight = UDim.new(0, 6);
    UIPadding.Parent = Frame4;

    local function makeToggle(p15, p16, p17) -- Line: 271
        -- upvalues: C (ref), HEADER_FONT (ref), Frame4 (copy)
        local TextButton2 = Instance.new("TextButton");
        TextButton2.Name = p15;
        TextButton2.Size = UDim2.new(0.3333333333333333, 0, 1, 0);
        TextButton2.LayoutOrder = p17;
        TextButton2.Text = p16;
        TextButton2.TextColor3 = C.dim;
        TextButton2.TextSize = 17;
        TextButton2.FontFace = HEADER_FONT;
        TextButton2.BackgroundColor3 = C.row;
        TextButton2.BackgroundTransparency = 0;
        TextButton2.BorderSizePixel = 0;
        TextButton2.AutoButtonColor = false;
        TextButton2.Parent = Frame4;
        local UIStroke3 = Instance.new("UIStroke");
        UIStroke3.Name = "Edge";
        UIStroke3.Color = C.inner;
        UIStroke3.Thickness = 1;
        UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke3.Parent = TextButton2;
        local Frame5 = Instance.new("Frame");
        Frame5.Name = "Underline";
        Frame5.AnchorPoint = Vector2.new(0.5, 1);
        Frame5.Size = UDim2.new(1, -24, 0, 2);
        Frame5.Position = UDim2.fromScale(0.5, 1);
        Frame5.BackgroundColor3 = C.amber;
        Frame5.BorderSizePixel = 0;
        Frame5.Visible = false;
        Frame5.Parent = TextButton2;

        return TextButton2;
    end;

    local v18 = makeToggle("BuyToggle", "BUY", 1);
    local v19 = makeToggle("SellToggle", "SELL", 2);
    local v20 = makeToggle("RepairToggle", "REPAIR", 3);
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "Body";
    Frame5.Size = UDim2.new(1, 0, 1, -272);
    Frame5.Position = UDim2.fromOffset(0, 104);
    Frame5.BackgroundTransparency = 1;
    Frame5.Parent = Frame;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "TabsCol";
    ScrollingFrame.Size = UDim2.new(0, 150, 1, 0);
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.BackgroundColor3 = C.slot;
    ScrollingFrame.BackgroundTransparency = 0.1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Parent = Frame5;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = C.inner;
    UIStroke3.Transparency = 0;
    UIStroke3.Thickness = 1;
    UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke3.Parent = ScrollingFrame;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Padding = UDim.new(0, 2);
    UIListLayout2.Parent = ScrollingFrame;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.PaddingTop = UDim.new(0, 4);
    UIPadding2.Parent = ScrollingFrame;

    for i, v in ipairs(TABS) do
        local TextButton2 = Instance.new("TextButton");
        TextButton2.Name = "Tab_" .. v;
        TextButton2.Size = UDim2.new(1, 0, 0, 36);
        TextButton2.LayoutOrder = i;
        TextButton2.Text = "";
        TextButton2.BackgroundColor3 = C.row;
        TextButton2.BackgroundTransparency = 0.5;
        TextButton2.BorderSizePixel = 0;
        TextButton2.AutoButtonColor = false;
        TextButton2.Parent = ScrollingFrame;
        local UDim2_new_ret6 = UDim2.new(1, -56, 1, 0);
        local UDim2_fromOffset_ret6 = UDim2.fromOffset(14, 0);
        local dim2 = C.dim;
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.Name = "Label";
        TextLabel5.Size = UDim2_new_ret6;
        TextLabel5.Position = UDim2_fromOffset_ret6;
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.FontFace = BODY_FONT_BOLD;
        TextLabel5.TextSize = 15;
        TextLabel5.TextColor3 = dim2;
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel5.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel5.Text = "";
        TextLabel5.Parent = TextButton2;
        TextLabel5.Text = v;
        local UDim2_new_ret7 = UDim2.new(0, 36, 1, 0);
        local UDim2_new_ret8 = UDim2.new(1, -44, 0, 0);
        local faint2 = C.faint;
        local Right3 = Enum.TextXAlignment.Right;
        local TextLabel6 = Instance.new("TextLabel");
        TextLabel6.Name = "Count";
        TextLabel6.Size = UDim2_new_ret7;
        TextLabel6.Position = UDim2_new_ret8;
        TextLabel6.BackgroundTransparency = 1;
        TextLabel6.FontFace = BODY_FONT;
        TextLabel6.TextSize = 13;
        TextLabel6.TextColor3 = faint2;
        TextLabel6.TextXAlignment = Right3 or Enum.TextXAlignment.Left;
        TextLabel6.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel6.Text = "";
        TextLabel6.Parent = TextButton2;
        local Frame6 = Instance.new("Frame");
        Frame6.Name = "Bar";
        Frame6.Size = UDim2.new(0, 3, 1, -10);
        Frame6.Position = UDim2.fromOffset(0, 5);
        Frame6.BackgroundColor3 = C.amber;
        Frame6.BorderSizePixel = 0;
        Frame6.Visible = false;
        Frame6.Parent = TextButton2;
    end;

    local Frame6 = Instance.new("Frame");
    Frame6.Name = "SearchRow";
    Frame6.Size = UDim2.new(1, -150, 0, 40);
    Frame6.Position = UDim2.fromOffset(150, 0);
    Frame6.BackgroundColor3 = C.slot;
    Frame6.BackgroundTransparency = 0.1;
    Frame6.BorderSizePixel = 0;
    Frame6.Parent = Frame5;
    local TextBox = Instance.new("TextBox");
    TextBox.Name = "SearchBox";
    TextBox.Size = UDim2.new(1, -240, 0, 30);
    TextBox.Position = UDim2.fromOffset(8, 5);
    TextBox.BackgroundColor3 = C.panel;
    TextBox.BackgroundTransparency = 0;
    TextBox.BorderSizePixel = 0;
    TextBox.ClearTextOnFocus = false;
    TextBox.Text = "";
    TextBox.PlaceholderText = "Search items or caliber";
    TextBox.PlaceholderColor3 = C.faint;
    TextBox.TextColor3 = C.text;
    TextBox.TextSize = 16;
    TextBox.TextXAlignment = Enum.TextXAlignment.Left;
    TextBox.FontFace = BODY_FONT;
    TextBox.ClipsDescendants = true;
    TextBox.TextTruncate = Enum.TextTruncate.AtEnd;
    TextBox.Parent = Frame6;
    local UIPadding3 = Instance.new("UIPadding");
    UIPadding3.PaddingLeft = UDim.new(0, 8);
    UIPadding3.PaddingRight = UDim.new(0, 8);
    UIPadding3.Parent = TextBox;
    local UIStroke4 = Instance.new("UIStroke");
    UIStroke4.Color = C.line;
    UIStroke4.Thickness = 1;
    UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke4.Parent = TextBox;
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Name = "SortButton";
    TextButton2.Size = UDim2.fromOffset(122, 30);
    TextButton2.Position = UDim2.new(1, -126, 0, 5);
    TextButton2.BackgroundColor3 = C.row;
    TextButton2.BackgroundTransparency = 0;
    TextButton2.BorderSizePixel = 0;
    TextButton2.AutoButtonColor = true;
    TextButton2.TextColor3 = C.text;
    TextButton2.TextSize = 14;
    TextButton2.TextTruncate = Enum.TextTruncate.AtEnd;
    TextButton2.FontFace = BODY_FONT_BOLD;
    TextButton2.Text = "Sort: " .. u3[1];
    TextButton2.Parent = Frame6;
    local TextButton3 = Instance.new("TextButton");
    TextButton3.Name = "LockedToggle";
    TextButton3.Size = UDim2.fromOffset(98, 30);
    TextButton3.Position = UDim2.new(1, -228, 0, 5);
    TextButton3.BackgroundColor3 = C.row;
    TextButton3.BackgroundTransparency = 0;
    TextButton3.BorderSizePixel = 0;
    TextButton3.AutoButtonColor = true;
    TextButton3.TextColor3 = C.text;
    TextButton3.TextSize = 14;
    TextButton3.TextTruncate = Enum.TextTruncate.AtEnd;
    TextButton3.FontFace = BODY_FONT_BOLD;
    TextButton3.Text = "Locked: Shown";
    TextButton3.Visible = false;
    TextButton3.Parent = Frame6;
    local ScrollingFrame2 = Instance.new("ScrollingFrame");
    ScrollingFrame2.Name = "ItemGrid";
    ScrollingFrame2.Size = UDim2.new(1, -150, 1, -40);
    ScrollingFrame2.Position = UDim2.fromOffset(150, 40);
    ScrollingFrame2.BackgroundColor3 = C.slot;
    ScrollingFrame2.BackgroundTransparency = 0.1;
    ScrollingFrame2.BorderSizePixel = 0;
    ScrollingFrame2.ScrollBarThickness = 8;
    ScrollingFrame2.CanvasSize = UDim2.fromScale(0, 0);
    ScrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame2.Parent = Frame5;
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "ItemContent";
    Frame7.Size = UDim2.new(1, -16, 0, 0);
    Frame7.Position = UDim2.fromOffset(6, 6);
    Frame7.AutomaticSize = Enum.AutomaticSize.Y;
    Frame7.BackgroundTransparency = 1;
    Frame7.Parent = ScrollingFrame2;
    local UIGridLayout = Instance.new("UIGridLayout");
    UIGridLayout.CellSize = UDim2_new_ret;
    UIGridLayout.CellPadding = UDim2_fromOffset_ret;
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIGridLayout.Parent = Frame7;
    local TextLabel5 = Instance.new("TextLabel");
    TextLabel5.Name = "NoMatch";
    TextLabel5.Size = UDim2.new(1, -16, 0, 40);
    TextLabel5.Position = UDim2.fromOffset(8, 8);
    TextLabel5.BackgroundTransparency = 1;
    TextLabel5.TextColor3 = C.dim;
    TextLabel5.TextSize = 16;
    TextLabel5.FontFace = BODY_FONT;
    TextLabel5.Text = "No items match";
    TextLabel5.Visible = false;
    TextLabel5.Parent = ScrollingFrame2;
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "Footer";
    Frame8.Size = UDim2.new(1, 0, 0, 168);
    Frame8.Position = UDim2.new(0, 0, 1, -168);
    Frame8.BackgroundColor3 = C.header;
    Frame8.BackgroundTransparency = 0.1;
    Frame8.BorderSizePixel = 0;
    Frame8.Parent = Frame;
    local UIStroke5 = Instance.new("UIStroke");
    UIStroke5.Color = C.inner;
    UIStroke5.Transparency = 0;
    UIStroke5.Thickness = 1;
    UIStroke5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke5.Parent = Frame8;
    local UDim2_new_ret6 = UDim2.new(1, -262, 0, 20);
    local UDim2_fromOffset_ret6 = UDim2.fromOffset(14, 8);
    local paper2 = C.paper;
    local TextLabel6 = Instance.new("TextLabel");
    TextLabel6.Name = "CartTitle";
    TextLabel6.Size = UDim2_new_ret6;
    TextLabel6.Position = UDim2_fromOffset_ret6;
    TextLabel6.BackgroundTransparency = 1;
    TextLabel6.FontFace = HEADER_FONT;
    TextLabel6.TextSize = 16;
    TextLabel6.TextColor3 = paper2;
    TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel6.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel6.Text = "";
    TextLabel6.Parent = Frame8;
    TextLabel6.Text = "CART (0)";
    local ScrollingFrame3 = Instance.new("ScrollingFrame");
    ScrollingFrame3.Name = "CartList";
    ScrollingFrame3.Size = UDim2.new(1, -262, 1, -40);
    ScrollingFrame3.Position = UDim2.fromOffset(10, 32);
    ScrollingFrame3.BackgroundTransparency = 1;
    ScrollingFrame3.BorderSizePixel = 0;
    ScrollingFrame3.ScrollBarThickness = 4;
    ScrollingFrame3.CanvasSize = UDim2.fromScale(0, 0);
    ScrollingFrame3.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame3.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame3.Parent = Frame8;
    local UIListLayout3 = Instance.new("UIListLayout");
    UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout3.Padding = UDim.new(0, 3);
    UIListLayout3.Parent = ScrollingFrame3;
    local UDim2_new_ret7 = UDim2.new(1, -262, 0, 40);
    local UDim2_fromOffset_ret7 = UDim2.fromOffset(14, 34);
    local faint2 = C.faint;
    local TextLabel7 = Instance.new("TextLabel");
    TextLabel7.Name = "CartEmpty";
    TextLabel7.Size = UDim2_new_ret7;
    TextLabel7.Position = UDim2_fromOffset_ret7;
    TextLabel7.BackgroundTransparency = 1;
    TextLabel7.FontFace = BODY_FONT;
    TextLabel7.TextSize = 14;
    TextLabel7.TextColor3 = faint2;
    TextLabel7.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel7.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel7.Text = "";
    TextLabel7.Parent = Frame8;
    TextLabel7.TextWrapped = true;
    TextLabel7.TextYAlignment = Enum.TextYAlignment.Top;
    local Frame9 = Instance.new("Frame");
    Frame9.Name = "Summary";
    Frame9.Size = UDim2.new(0, 236, 1, -16);
    Frame9.Position = UDim2.new(1, -244, 0, 8);
    Frame9.BackgroundColor3 = C.slot;
    Frame9.BackgroundTransparency = 0;
    Frame9.BorderSizePixel = 0;
    Frame9.Parent = Frame8;
    local UIStroke6 = Instance.new("UIStroke");
    UIStroke6.Color = C.inner;
    UIStroke6.Thickness = 1;
    UIStroke6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke6.Parent = Frame9;

    local function sumRow(p21, p22, p23) -- Line: 549
        -- upvalues: Frame9 (copy), BODY_FONT (ref), C (ref), BODY_FONT_BOLD (ref)
        local UDim2_new_ret8 = UDim2.new(0.5, -10, 0, 20);
        local UDim2_fromOffset_ret8 = UDim2.fromOffset(10, p23);
        local dim2 = C.dim;
        local TextLabel8 = Instance.new("TextLabel");
        TextLabel8.Name = p21 .. "Caption";
        TextLabel8.Size = UDim2_new_ret8;
        TextLabel8.Position = UDim2_fromOffset_ret8;
        TextLabel8.BackgroundTransparency = 1;
        TextLabel8.FontFace = BODY_FONT;
        TextLabel8.TextSize = 14;
        TextLabel8.TextColor3 = dim2;
        TextLabel8.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel8.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel8.Text = "";
        TextLabel8.Parent = Frame9;
        TextLabel8.Text = p22;
        local UDim2_new_ret9 = UDim2.new(0.5, -10, 0, 20);
        local UDim2_new_ret10 = UDim2.new(0.5, 0, 0, p23);
        local paper3 = C.paper;
        local Right3 = Enum.TextXAlignment.Right;
        local TextLabel9 = Instance.new("TextLabel");
        TextLabel9.Name = p21;
        TextLabel9.Size = UDim2_new_ret9;
        TextLabel9.Position = UDim2_new_ret10;
        TextLabel9.BackgroundTransparency = 1;
        TextLabel9.FontFace = BODY_FONT_BOLD;
        TextLabel9.TextSize = 15;
        TextLabel9.TextColor3 = paper3;
        TextLabel9.TextXAlignment = Right3 or Enum.TextXAlignment.Left;
        TextLabel9.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel9.Text = "";
        TextLabel9.Parent = Frame9;

        return TextLabel9;
    end;

    local v24 = sumRow("SumTotal", "Total", 6);
    local v25 = sumRow("SumBalance", "Balance", 28);
    local Frame10 = Instance.new("Frame");
    Frame10.Name = "Rule";
    Frame10.Size = UDim2.new(1, -20, 0, 1);
    Frame10.Position = UDim2.fromOffset(10, 52);
    Frame10.BackgroundColor3 = C.line;
    Frame10.BorderSizePixel = 0;
    Frame10.Parent = Frame9;
    local v26 = sumRow("SumAfter", "After", 56);
    local TextButton4 = Instance.new("TextButton");
    TextButton4.Name = "ClearCart";
    TextButton4.Size = UDim2.fromOffset(74, 34);
    TextButton4.Position = UDim2.new(0, 10, 1, -44);
    TextButton4.Text = "CLEAR";
    TextButton4.TextColor3 = C.paper;
    TextButton4.TextSize = 14;
    TextButton4.FontFace = BODY_FONT_BOLD;
    TextButton4.BackgroundColor3 = Color3_fromRGB_ret2;
    TextButton4.BorderSizePixel = 0;
    TextButton4.Parent = Frame9;
    local TextButton5 = Instance.new("TextButton");
    TextButton5.Name = "Confirm";
    TextButton5.Size = UDim2.new(1, -102, 0, 34);
    TextButton5.Position = UDim2.new(0, 92, 1, -44);
    TextButton5.Text = "CONFIRM";
    TextButton5.TextColor3 = Color3_fromRGB_ret;
    TextButton5.TextSize = 17;
    TextButton5.FontFace = HEADER_FONT;
    TextButton5.BackgroundColor3 = C.amber;
    TextButton5.BorderSizePixel = 0;
    TextButton5.Parent = Frame9;
    local ScreenGui2 = Instance.new("ScreenGui");
    ScreenGui2.Name = "TraderToastGui";
    ScreenGui2.ResetOnSpawn = false;
    ScreenGui2.IgnoreGuiInset = true;
    ScreenGui2.DisplayOrder = 1100;
    ScreenGui2.Parent = ScreenGui.Parent;
    local TextLabel8 = Instance.new("TextLabel");
    TextLabel8.Name = "ConfirmFailureToast";
    TextLabel8.Size = UDim2.fromOffset(360, 36);
    TextLabel8.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel8.TextWrapped = true;
    TextLabel8.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel8.Position = UDim2.new(Frame.Position.X.Scale, 0, Frame.Position.Y.Scale - Frame.Size.Y.Scale / 2, 60);
    TextLabel8.BackgroundColor3 = Color3.fromRGB(120, 40, 40);
    TextLabel8.BorderSizePixel = 0;
    TextLabel8.TextColor3 = C.paper;
    TextLabel8.TextSize = 16;
    TextLabel8.FontFace = BODY_FONT_BOLD;
    TextLabel8.Text = "";
    TextLabel8.Visible = false;
    TextLabel8.ZIndex = 10;
    local UIPadding4 = Instance.new("UIPadding");
    UIPadding4.PaddingTop = UDim.new(0, 8);
    UIPadding4.PaddingBottom = UDim.new(0, 8);
    UIPadding4.PaddingLeft = UDim.new(0, 10);
    UIPadding4.PaddingRight = UDim.new(0, 10);
    UIPadding4.Parent = TextLabel8;
    TextLabel8.Parent = ScreenGui2;
    p14.Gui = ScreenGui;
    p14.MainFrame = Frame;
    p14.ResScale = UIScale;
    p14.Header = Frame2;
    p14.TabsCol = ScrollingFrame;
    p14.ItemGrid = ScrollingFrame2;
    p14.ItemContent = Frame7;
    p14.SearchBox = TextBox;
    p14.SortButton = TextButton2;
    p14.LockedToggle = TextButton3;
    p14.NoMatch = TextLabel5;
    p14.Footer = Frame8;
    p14.CartList = ScrollingFrame3;
    p14.TraderSub = TextLabel2;
    p14.BalanceValue = TextLabel4;
    p14.CartTitle = TextLabel6;
    p14.CartEmpty = TextLabel7;
    p14.SumTotal = v24;
    p14.SumBalance = v25;
    p14.SumAfter = v26;
    p14.ConfirmBtn = TextButton5;
    p14.ClearBtn = TextButton4;
    p14.CloseBtn = TextButton;
    p14.BuyToggle = v18;
    p14.SellToggle = v19;
    p14.RepairToggle = v20;
    p14.ToggleHolder = Frame4;
    p14.Toast = TextLabel8;
end;

function v2._wireResScale(u27) -- Line: 668
    -- upvalues: workspace_CurrentCamera (ref)
    local function apply() -- Line: 669
        -- upvalues: workspace_CurrentCamera (ref), u27 (copy)
        local math_clamp_ret = math.clamp(workspace_CurrentCamera.ViewportSize.Y / 1080, 0.85, 1);
        u27.ResScale.Scale = math_clamp_ret;
    end;

    local math_clamp_ret = math.clamp(workspace_CurrentCamera.ViewportSize.Y / 1080, 0.85, 1);
    u27.ResScale.Scale = math_clamp_ret;
    workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(apply);
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 676
        -- upvalues: workspace_CurrentCamera (ref), u27 (copy), apply (copy)
        workspace_CurrentCamera = workspace.CurrentCamera;
        local math_clamp_ret2 = math.clamp(workspace_CurrentCamera.ViewportSize.Y / 1080, 0.85, 1);
        u27.ResScale.Scale = math_clamp_ret2;
        workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(apply);
    end);
end;

function v2._wireRemotes(u28) -- Line: 682
    -- upvalues: ReplicatedStorage (copy), u1 (ref)
    local Remotes = ReplicatedStorage:WaitForChild("Remotes");
    local TraderInventoryOpened = Remotes:WaitForChild("TraderInventoryOpened");
    local TraderRosterRefreshed = Remotes:WaitForChild("TraderRosterRefreshed");
    local TraderClosed = Remotes:WaitForChild("TraderClosed");
    local TraderError = Remotes:WaitForChild("TraderError");
    TraderInventoryOpened.OnClientEvent:Connect(function(p29, p30, p31, p32) -- Line: 689
        -- upvalues: u28 (copy)
        u28:Open(p29, p30, p31);
    end);
    TraderRosterRefreshed.OnClientEvent:Connect(function(p33, p34, p35) -- Line: 693
        -- upvalues: u28 (copy)
        if not u28.IsOpen then
            return;
        end;

        u28.Stock = p34 or {};
        u28:_renderItems();
    end);
    TraderClosed.OnClientEvent:Connect(function() -- Line: 699
        -- upvalues: u28 (copy)
        u28:Close("server-closed");
    end);
    TraderError.OnClientEvent:Connect(function(p36) -- Line: 703
        -- upvalues: u28 (copy)
        u28:_showToast("Trader error: " .. tostring(p36));
    end);
    local BalanceChanged = Remotes:WaitForChild("BalanceChanged");
    local RequestBalance = Remotes:WaitForChild("RequestBalance");
    BalanceChanged.OnClientEvent:Connect(function(p37) -- Line: 709
        -- upvalues: u28 (copy)
        u28._balanceKnown = true;
        u28._roubleBalance = p37 or 0;

        if u28.IsOpen then
            u28:_renderItems();
            u28:_renderCart();
        end;
    end);
    task.spawn(function() -- Line: 721
        -- upvalues: RequestBalance (copy), u28 (copy)
        local v38;

        while true do
            local v39;
            v39, v38 = pcall(function() -- Line: 723
                -- upvalues: RequestBalance (ref)
                return RequestBalance:InvokeServer();
            end);

            if v39 and type(v38) == "number" then
                break;
            end;

            if u28._balanceKnown then
                return;
            end;

            task.wait(1);
        end;

        u28._roubleBalance = v38;

        if u28.IsOpen then
            u28:_renderItems();
            u28:_renderCart();
        end;
    end);
    u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));
    u1.InventorySettled:Connect(function() -- Line: 759
        -- upvalues: u28 (copy)
        if u28.IsOpen then
            u28:_renderItems();
        end;
    end);
    u28.CloseBtn.MouseButton1Click:Connect(function() -- Line: 765
        -- upvalues: u28 (copy), Remotes (copy)
        u28:Close("user-closed");
        local CloseTrader = Remotes:FindFirstChild("CloseTrader");

        if CloseTrader then
            CloseTrader:FireServer();
        end;
    end);
    u28.ClearBtn.MouseButton1Click:Connect(function() -- Line: 771
        -- upvalues: u28 (copy), u1 (ref), ReplicatedStorage (ref)
        if u28.Mode == "REPAIR" then
            return;
        end;

        u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

        if u28.Mode == "BUY" then
            if u1.BuyCart then
                table.clear(u1.BuyCart);
            end;

            if u1.RefreshCartGhosts then
                u1:RefreshCartGhosts();
            end;
        else
            for _, v in ipairs(u28.SellQueue) do
                u28:_setSellHighlight(v, false);
            end;

            table.clear(u28.SellQueue);
        end;

        u28:_renderItems();
        u28:_renderCart();
    end);
    u28.ConfirmBtn.MouseButton1Click:Connect(function() -- Line: 797
        -- upvalues: u28 (copy)
        if not u28.ConfirmBtn.Active then
            return;
        end;

        if u28.Mode == "REPAIR" then
            return;
        end;

        if u28.Mode == "BUY" then
            u28:_confirmBuy();

            return;
        end;

        u28:_confirmSell();
    end);
end;

function v2.Open(u40, p41, p42, p43) -- Line: 812
    -- upvalues: Layout (copy), ReplicatedStorage (copy), u1 (ref), LocalPlayer (copy), ContainerVisibility (copy)
    u40.CurrentTrader = p42;
    u40.CurrentNPC = p41;
    u40.Stock = p43 or {};
    u40.IsOpen = true;
    u40.SelectedTab = u40:_firstNonEmptyTab();
    u40.Mode = "BUY";
    u40.SearchQuery = nil;

    if u40.SearchBox then
        u40.SearchBox.Text = "";
    end;

    u40.Header.TraderName.Text = string.upper(p42.DisplayName or "Trader");
    u40.TraderSub.Text = Layout.Subline(p42);
    u40.Gui.Enabled = true;
    task.spawn(function() -- Line: 829
        -- upvalues: ReplicatedStorage (ref), u40 (copy)
        local success, result = pcall(function() -- Line: 830
            -- upvalues: ReplicatedStorage (ref)
            return ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RequestBalance"):InvokeServer();
        end);

        if success and type(result) == "number" then
            u40._roubleBalance = result;

            if u40.IsOpen then
                u40:_renderItems();
                u40:_renderCart();
            end;
        end;
    end);
    u40:_renderModeToggle();
    u40:_renderItems();
    u40:_renderCart();
    u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));
    local InventoryGui = LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");
    u40._wasInventoryOpen = InventoryGui and InventoryGui.Enabled or false;

    if not u40._wasInventoryOpen then
        u1:OpenInventoryUI();
    end;

    ContainerVisibility.Hide("trader");

    if u1 and u1.CloseStoragePanel then
        u1:CloseStoragePanel();
    end;
end;

function v2.Close(p44, p45) -- Line: 873
    -- upvalues: u1 (ref), ReplicatedStorage (copy), ContainerVisibility (copy)
    if not p44.IsOpen then
        return;
    end;

    p44.IsOpen = false;
    p44.CurrentTrader = nil;
    p44.CurrentNPC = nil;
    p44.Stock = {};
    p44.Gui.Enabled = false;

    if p44.Toast then
        p44.Toast.Visible = false;
    end;

    u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

    if u1._destroyCartGhosts then
        u1:_destroyCartGhosts();
    end;

    if u1.BuyCart then
        table.clear(u1.BuyCart);
    end;

    if p44.SellQueue then
        for _, v in ipairs(p44.SellQueue) do
            p44:_setSellHighlight(v, false);
        end;

        table.clear(p44.SellQueue);
    end;

    ContainerVisibility.Show("trader");

    if p44._wasInventoryOpen == false then
        u1:CloseInventoryUI();
    end;

    p44._wasInventoryOpen = nil;
    local success, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1));

    if success and (result and result.IsOpen) then
        result:Close();
    end;
end;

function v2._firstNonEmptyTab(p46) -- Line: 908
    -- upvalues: TABS (copy)
    if #p46.Stock > 0 then
        return "All";
    end;

    for _, v in ipairs(TABS) do
        if v ~= "All" then
            local v47 = v;

            for _, v3 in ipairs(p46.Stock) do
                if v3.Category == v47 then
                    return v47;
                end;
            end;
        end;
    end;

    return TABS[1];
end;

function v2._wireDeathClose(u48) -- Line: 937
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy)
    local function hookCharacter(p49) -- Line: 938
        -- upvalues: u48 (copy), ReplicatedStorage (ref)
        local v50 = p49:FindFirstChildOfClass("Humanoid") or p49:WaitForChild("Humanoid", 10);

        if not v50 then
            return;
        end;

        v50.Died:Connect(function() -- Line: 941
            -- upvalues: u48 (ref), ReplicatedStorage (ref)
            if not u48.IsOpen then
                return;
            end;

            u48:Close("died");
            local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

            if Remotes then
                Remotes = Remotes:FindFirstChild("CloseTrader");
            end;

            if Remotes then
                Remotes:FireServer();
            end;
        end);
    end;

    if LocalPlayer.Character then
        task.spawn(hookCharacter, LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(hookCharacter);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 956
        -- upvalues: u48 (copy)
        if u48.IsOpen then
            u48:Close("respawned");
        end;
    end);
end;

function v2._wireInput(u51) -- Line: 961
    -- upvalues: UserInputService (copy), ReplicatedStorage (copy)
    UserInputService.InputBegan:Connect(function(p52, p53) -- Line: 962
        -- upvalues: u51 (copy), ReplicatedStorage (ref)
        if p53 then
            return;
        end;

        if not u51.IsOpen then
            return;
        end;

        if p52.KeyCode == Enum.KeyCode.Tab then
            u51:Close("user-key");
            local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

            if Remotes then
                Remotes = Remotes:FindFirstChild("CloseTrader");
            end;

            if Remotes then
                Remotes:FireServer();
            end;
        end;
    end);
end;

function v2._renderTabs(u54, p55) -- Line: 976
    -- upvalues: Layout (copy), TABS (copy), C (copy)
    local v56 = p55 or Layout.Counts(u54:_modeRows());
    local v57 = u54.SearchQuery and "All" or u54.SelectedTab;

    for _, v in ipairs(TABS) do
        local v58 = u54.TabsCol:FindFirstChild("Tab_" .. v);

        if v58 then
            local v59 = v == v57;
            local v60 = v56[v];
            v58.Visible = Layout.TabVisible(v, v60, v59);
            v58.Count.Text = v60 and (v60 > 0 and tostring(v60)) or "";
            v58.Bar.Visible = v59;

            if v59 then
                v58.BackgroundColor3 = C.hover;
                v58.BackgroundTransparency = 0;
                v58.Label.TextColor3 = C.amber;
                v58.Count.TextColor3 = C.text;
            else
                v58.BackgroundColor3 = C.row;
                v58.BackgroundTransparency = 0.5;
                v58.Label.TextColor3 = C.dim;
                v58.Count.TextColor3 = C.faint;
            end;

            if not v58:GetAttribute("__wired") then
                v58:SetAttribute("__wired", true);
                v58.MouseButton1Click:Connect(function() -- Line: 1003
                    -- upvalues: u54 (copy), v (copy)
                    u54.SelectedTab = v;

                    if u54.SearchBox and u54.SearchBox.Text ~= "" then
                        u54.SearchBox.Text = "";
                    end;

                    u54.SearchQuery = nil;
                    u54:_renderItems();
                end);
            end;
        end;
    end;
end;

function v2._modeRows(p61) -- Line: 1021
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if p61.Mode ~= "BUY" then
        u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

        if p61.Mode == "REPAIR" then
            return p61:_getRepairableInventory(u1);
        end;

        return p61:_getSellableInventory(u1);
    end;

    if p61.ShowLocked then
        return p61.Stock;
    end;

    local v62 = {};

    for _, v in ipairs(p61.Stock) do
        if not v.Locked then
            table.insert(v62, v);
        end;
    end;

    return v62;
end;

function v2._categoryOf(p63, p64) -- Line: 1039
    -- upvalues: TraderCategories (copy)
    return TraderCategories.CategoryOf(p64);
end;

v2._lootCatCache = {};

function v2._lootCategoryOf(p65, p66) -- Line: 1044
    -- upvalues: ItemDatabase (copy), ReplicatedStorage (copy)
    if p65._lootCatCache[p66] ~= nil then
        return p65._lootCatCache[p66];
    end;

    local ItemData = ItemDatabase.GetItemData(p66);

    if ItemData and (ItemData.LootCategory and ItemData.LootCategory ~= "") then
        p65._lootCatCache[p66] = ItemData.LootCategory;

        return ItemData.LootCategory;
    end;

    local PlayerItems = ReplicatedStorage:FindFirstChild("PlayerItems");

    if PlayerItems then
        PlayerItems = PlayerItems:FindFirstChild(p66, true);
    end;

    if PlayerItems then
        PlayerItems = PlayerItems:GetAttribute("LootCategory");
    end;

    p65._lootCatCache[p66] = PlayerItems or false;

    return PlayerItems;
end;

function v2._collectPlayerItems(p67, p68) -- Line: 1073
    local v69 = {};

    local function tiedOf(p70) -- Line: 1079
        return p70 and p70.Metadata and p70.Metadata.TiedInstance;
    end;

    local v71 = {};
    local v72 = {
        key = "Pockets",
        grid = p68.LocalInventory
    };
    local LocalInventory = p68.LocalInventory;
    v72.tied = LocalInventory and LocalInventory.Metadata and LocalInventory.Metadata.TiedInstance;
    local v73 = {
        key = "ChestRig",
        grid = p68.ChestRigInventory
    };
    local ChestRigInventory = p68.ChestRigInventory;
    v73.tied = ChestRigInventory and ChestRigInventory.Metadata and ChestRigInventory.Metadata.TiedInstance;
    local v74 = {
        key = "BattleBelt",
        grid = p68.BattleBeltInventory
    };
    local BattleBeltInventory = p68.BattleBeltInventory;
    v74.tied = BattleBeltInventory and BattleBeltInventory.Metadata and BattleBeltInventory.Metadata.TiedInstance;
    local v75 = {
        key = "Backpack",
        grid = p68.MainInventory
    };
    local MainInventory = p68.MainInventory;
    v75.tied = MainInventory and MainInventory.Metadata and MainInventory.Metadata.TiedInstance;
    v71[1], v71[2], v71[3], v71[4] = v72, v73, v74, v75;

    for _, v in ipairs(v71) do
        local grid = v.grid;

        if grid and grid.Items then
            local v76 = v;

            for _, v3 in pairs(grid.Items) do
                if v3 and (v3.Metadata and (v3.Metadata.ID and v76.tied ~= nil)) then
                    local ID = v3.Metadata.ID;
                    local v77 = {
                        slotKey = nil,
                        itemID = ID,
                        tile = v3,
                        sourceInv = v76.tied,
                        sourceKey = v76.key,
                        itemIndex = v3.Metadata.ItemIndex,
                        position = v3.Position,
                        Category = p67:_categoryOf(ID)
                    };
                    table.insert(v69, v77);
                end;
            end;
        end;
    end;

    for _, v in ipairs({
        {
            slotKey = "Head",
            ref = p68.HeadSlot
        },
        {
            slotKey = "FaceWear",
            ref = p68.FaceWearSlot
        },
        {
            slotKey = "EyeWear",
            ref = p68.EyeWearSlot
        },
        {
            slotKey = "Body",
            ref = p68.BodySlot
        },
        {
            slotKey = "BeltGear",
            ref = p68.BeltGearSlot
        },
        {
            slotKey = "Primary",
            ref = p68.PrimarySlot
        },
        {
            slotKey = "Secondary",
            ref = p68.SecondarySlot
        },
        {
            slotKey = "Sidearm",
            ref = p68.SidearmSlot
        },
        {
            slotKey = "Melee",
            ref = p68.MeleeSlot
        },
        {
            slotKey = "Uniform",
            ref = p68.UniformSlot
        },
        {
            slotKey = "Backpack",
            ref = p68.BackpackSlot
        },
        {
            slotKey = "NightOptical",
            ref = p68.NightOpticalSlot
        }
    }) do
        local ref = v.ref;
        local v78 = ref and ref.Metadata and ref.Metadata.TiedInstance;

        if ref then
            ref = ref.Item;
        end;

        if ref and (v78 ~= nil and (ref.Metadata and ref.Metadata.ID)) then
            local ID = ref.Metadata.ID;
            local v79 = {
                position = nil,
                itemID = ID,
                tile = ref,
                sourceInv = v78,
                sourceKey = "Equip:" .. v.slotKey,
                itemIndex = ref.Metadata.ItemIndex,
                slotKey = v.slotKey,
                Category = p67:_categoryOf(ID)
            };
            table.insert(v69, v79);
        end;
    end;

    return v69;
end;

function v2._getSellableInventory(p80, p81) -- Line: 1150
    -- upvalues: ItemDatabase (copy), ConditionValue (copy)
    local v82 = {};
    local CurrentTrader = p80.CurrentTrader;

    if not CurrentTrader then
        return v82;
    end;

    local v83 = CurrentTrader.Buys or {};
    local u84 = CurrentTrader.BuysEverything == true;
    local v85 = CurrentTrader.BuybackMultiplier or 0.5;
    local u86 = {};

    for _, v in ipairs(v83) do
        u86[v] = true;
    end;

    local u87 = {};

    for _, v in ipairs(CurrentTrader.BuysItems or {}) do
        u87[v] = true;
    end;

    local function traderAccepts(p88, p89) -- Line: 1169
        -- upvalues: u84 (copy), u86 (copy), u87 (copy)
        if u84 then
            return true;
        end;

        if u86[p88] == true then
            return true;
        end;

        local v90;

        if p89 == nil then
            v90 = false;
        else
            v90 = u87[p89] == true;
        end;

        return v90;
    end;

    local v91 = {};

    for _, v in ipairs(p80.SellQueue or {}) do
        local v92 = tostring(v.sourceKey or v.sourceInv);
        v91[tostring(v.itemID) .. "|" .. v92 .. "|" .. tostring(v.itemIndex)] = true;
    end;

    for _, v in ipairs(p80:_collectPlayerItems(p81)) do
        local tile = v.tile;
        local itemID = v.itemID;
        local ItemData = ItemDatabase.GetItemData(itemID);

        if ItemData then
            local BaseSellValue = ItemData.BaseSellValue;

            if BaseSellValue and BaseSellValue > 0 then
                local v93 = p80:_lootCategoryOf(itemID);
                local v94 = tostring(itemID) .. "|" .. v.sourceKey .. "|" .. tostring(v.itemIndex);
                local v95;

                if u84 or u86[v93] == true then
                    v95 = true;
                elseif itemID == nil then
                    v95 = false;
                else
                    v95 = u87[itemID] == true;
                end;

                if v95 and not v91[v94] then
                    if v.slotKey then
                        local v96 = {
                            qty = 1,
                            kind = "equipment",
                            itemID = itemID,
                            name = ItemData.Name or itemID
                        };
                        local v97 = BaseSellValue * v85 * ConditionValue.Multiplier(tile, ItemData, ItemDatabase);
                        v96.price = math.floor(v97);
                        v96.category = v.Category;
                        v96.Category = v.Category;
                        v96.sourceInv = v.sourceInv;
                        v96.sourceKey = v.sourceKey;
                        v96.slotKey = v.slotKey;
                        v96.itemType = tile.Metadata.ItemType;
                        v96.position = v.position;
                        v96.itemIndex = v.itemIndex;
                        v96.tied = v.sourceInv;
                        table.insert(v82, v96);
                    else
                        local v98 = {
                            qty = 1,
                            itemID = itemID,
                            name = ItemData.Name or itemID
                        };
                        local v99 = BaseSellValue * v85 * ConditionValue.Multiplier(tile, ItemData, ItemDatabase);
                        v98.price = math.floor(v99);
                        v98.category = v.Category;
                        v98.Category = v.Category;
                        v98.sourceInv = v.sourceInv;
                        v98.sourceKey = v.sourceKey;
                        v98.position = v.position;
                        v98.itemIndex = v.itemIndex;
                        table.insert(v82, v98);
                    end;
                end;
            end;
        end;
    end;

    return v82;
end;

function v2._getRepairableInventory(p100, p101) -- Line: 1252
    -- upvalues: ItemDatabase (copy), RepairPricing (copy)
    local v102 = {};

    for _, v in ipairs(p100:_collectPlayerItems(p101)) do
        local ItemData = ItemDatabase.GetItemData(v.itemID);

        if ItemData then
            local Metadata = v.tile.Metadata;
            local v103 = ItemData.ToolName and ItemData.ToolName ~= "" and {
                CurrentDurability = p101:_displayCondition(v.tile, ItemData)
            } or Metadata;
            local v104 = RepairPricing.Quote(v103, ItemData, ItemDatabase);

            if v104 then
                v.quote = v104;
                v.name = ItemData.Name or v.itemID;
                table.insert(v102, v);
            end;
        end;
    end;

    return v102;
end;

function v2._addToSellQueue(p105, p106) -- Line: 1308
    local function _(p107) -- Line: 1310
        return tostring(p107.sourceKey or p107.sourceInv);
    end;

    local v108 = tostring(p106.itemID) .. "|" .. tostring(p106.sourceKey or p106.sourceInv) .. "|" .. tostring(p106.itemIndex);

    for _, v in ipairs(p105.SellQueue) do
        if tostring(v.itemID) .. "|" .. tostring(v.sourceKey or v.sourceInv) .. "|" .. tostring(v.itemIndex) == v108 then
            return;
        end;
    end;

    table.insert(p105.SellQueue, p106);
    p105:_setSellHighlight(p106, true);
    p105:_renderItems();
    p105:_renderCart();
end;

function v2._setSellHighlight(p109, p110, p111) -- Line: 1322
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));
    local v112 = nil;

    for _, v in ipairs({
        u1.LocalInventory,
        u1.ChestRigInventory,
        u1.BattleBeltInventory,
        u1.MainInventory,
        u1.HeadSlot,
        u1.FaceWearSlot,
        u1.EyeWearSlot,
        u1.BodySlot,
        u1.BeltGearSlot,
        u1.PrimarySlot,
        u1.SecondarySlot,
        u1.SidearmSlot,
        u1.MeleeSlot,
        u1.UniformSlot,
        u1.BackpackSlot,
        u1.NightOpticalSlot
    }) do
        if v and (v.Metadata and v.Metadata.TiedInstance == p110.sourceInv) then
            v112 = v;
            break;
        end;
    end;

    if not (v112 and v112.Items) then
        return;
    end;

    local v113 = nil;

    for _, v in pairs(v112.Items) do
        if v and (v.Metadata and v.Metadata.ItemIndex == p110.itemIndex) then
            v113 = v;
            break;
        end;
    end;

    if not (v113 and v113.ItemElement) then
        return;
    end;

    local ItemElement = v113.ItemElement;
    local __SellHighlight = ItemElement:FindFirstChild("__SellHighlight");

    if p111 then
        if not __SellHighlight then
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Name = "__SellHighlight";
            UIStroke.Color = Color3.fromRGB(80, 220, 80);
            UIStroke.Thickness = 2;
            UIStroke.Transparency = 0;
            UIStroke.Parent = ItemElement;
        end;
    elseif __SellHighlight then
        __SellHighlight:Destroy();
    end;
end;

function v2._renderModeToggle(u114) -- Line: 1373
    -- upvalues: C (copy)
    local function paint(p115, p116) -- Line: 1375
        -- upvalues: C (ref)
        p115.BackgroundColor3 = p116 and C.hover or C.row;
        p115.BackgroundTransparency = 0;
        p115.TextColor3 = p116 and C.amber or C.dim;
        p115.Edge.Color = p116 and C.edge or C.inner;
        p115.Underline.Visible = p116;
    end;

    local BuyToggle = u114.BuyToggle;
    local v117 = u114.Mode == "BUY";
    BuyToggle.BackgroundColor3 = v117 and C.hover or C.row;
    BuyToggle.BackgroundTransparency = 0;
    BuyToggle.TextColor3 = v117 and C.amber or C.dim;
    BuyToggle.Edge.Color = v117 and C.edge or C.inner;
    BuyToggle.Underline.Visible = v117;
    local SellToggle = u114.SellToggle;
    local v118 = u114.Mode == "SELL";
    SellToggle.BackgroundColor3 = v118 and C.hover or C.row;
    SellToggle.BackgroundTransparency = 0;
    SellToggle.TextColor3 = v118 and C.amber or C.dim;
    SellToggle.Edge.Color = v118 and C.edge or C.inner;
    SellToggle.Underline.Visible = v118;
    local RepairToggle = u114.RepairToggle;
    local v119 = u114.Mode == "REPAIR";
    RepairToggle.BackgroundColor3 = v119 and C.hover or C.row;
    RepairToggle.BackgroundTransparency = 0;
    RepairToggle.TextColor3 = v119 and C.amber or C.dim;
    RepairToggle.Edge.Color = v119 and C.edge or C.inner;
    RepairToggle.Underline.Visible = v119;
    u114.SellToggle.Visible = not u114:_tradersBuysNothing();
    u114.RepairToggle.Visible = u114:_traderRepairs();
    local v120 = {};

    for _, v in ipairs({ u114.BuyToggle, u114.SellToggle, u114.RepairToggle }) do
        if v.Visible then
            table.insert(v120, v);
        end;
    end;

    local v121 = (#v120 - 1) * 6 / math.max(#v120, 1);

    for _, v in ipairs(v120) do
        v.Size = UDim2.new(1 / #v120, -v121, 1, 0);
    end;

    local function wire(p122, u123) -- Line: 1417
        -- upvalues: u114 (copy)
        if p122:GetAttribute("__wired") then
            return;
        end;

        p122:SetAttribute("__wired", true);
        p122.MouseButton1Click:Connect(function() -- Line: 1420
            -- upvalues: u114 (ref), u123 (copy)
            if u114.Mode == u123 then
                return;
            end;

            u114.Mode = u123;
            u114.SelectedTab = u114:_firstNonEmptyTab();
            u114:_renderModeToggle();
            u114:_renderItems();
            u114:_renderCart();
        end);
    end;

    local BuyToggle2 = u114.BuyToggle;

    if not BuyToggle2:GetAttribute("__wired") then
        BuyToggle2:SetAttribute("__wired", true);
        local u124 = "BUY";
        BuyToggle2.MouseButton1Click:Connect(function() -- Line: 1420
            -- upvalues: u114 (copy), u124 (copy)
            if u114.Mode == u124 then
                return;
            end;

            u114.Mode = u124;
            u114.SelectedTab = u114:_firstNonEmptyTab();
            u114:_renderModeToggle();
            u114:_renderItems();
            u114:_renderCart();
        end);
    end;

    local SellToggle2 = u114.SellToggle;

    if not SellToggle2:GetAttribute("__wired") then
        SellToggle2:SetAttribute("__wired", true);
        local u125 = "SELL";
        SellToggle2.MouseButton1Click:Connect(function() -- Line: 1420
            -- upvalues: u114 (copy), u125 (copy)
            if u114.Mode == u125 then
                return;
            end;

            u114.Mode = u125;
            u114.SelectedTab = u114:_firstNonEmptyTab();
            u114:_renderModeToggle();
            u114:_renderItems();
            u114:_renderCart();
        end);
    end;

    local RepairToggle2 = u114.RepairToggle;

    if RepairToggle2:GetAttribute("__wired") then
        return;
    end;

    RepairToggle2:SetAttribute("__wired", true);
    local u126 = "REPAIR";
    RepairToggle2.MouseButton1Click:Connect(function() -- Line: 1420
        -- upvalues: u114 (copy), u126 (copy)
        if u114.Mode == u126 then
            return;
        end;

        u114.Mode = u126;
        u114.SelectedTab = u114:_firstNonEmptyTab();
        u114:_renderModeToggle();
        u114:_renderItems();
        u114:_renderCart();
    end);
end;

function v2._traderRepairs(p127) -- Line: 1441
    local CurrentTrader = p127.CurrentTrader;
    local v128;

    if CurrentTrader == nil then
        v128 = false;
    else
        v128 = CurrentTrader.DisplayName == "Technician";
    end;

    return v128;
end;

function v2._tradersBuysNothing(p129) -- Line: 1446
    local CurrentTrader = p129.CurrentTrader;

    if not CurrentTrader then
        return false;
    end;

    if CurrentTrader.BuysEverything then
        return false;
    end;

    return type(CurrentTrader.Buys) ~= "table" and true or #CurrentTrader.Buys == 0;
end;

function v2._renderItems(u130) -- Line: 1456
    -- upvalues: ItemDatabase (copy), u1 (ref), ReplicatedStorage (copy), Layout (copy), TraderCategories (copy), u3 (copy)
    for _, child in ipairs(u130.ItemContent:GetChildren()) do
        if (child:IsA("TextButton") or child:IsA("Frame")) and child.Name:sub(1, 5) == "Card_" then
            child:Destroy();
        end;
    end;

    local v131 = {};

    if u130.LockedToggle then
        local v132 = false;

        for _, v in ipairs(u130.Stock) do
            if v.Locked then
                v132 = true;
                break;
            end;
        end;

        if u130.Mode ~= "BUY" then
            v132 = false;
        end;

        u130.LockedToggle.Visible = v132;
        u130.LockedToggle.Text = u130.ShowLocked and "Locked: Shown" or "Locked: Hidden";
        u130.SearchBox.Size = UDim2.new(1, u130.LockedToggle.Visible and -240 or -138, 0, 30);
    end;

    if u130.Mode == "BUY" then
        for _, v in ipairs(u130.Stock) do
            if u130.ShowLocked or not v.Locked then
                local ItemData = ItemDatabase.GetItemData(v.ID);
                table.insert(v131, {
                    item = v,
                    id = v.ID,
                    price = v.Price or 0,
                    name = ItemData and ItemData.Name or v.ID,

                    render = function() -- Line: 1484, Name: render
                        -- upvalues: u130 (copy), v (copy)
                        u130:_renderBuyCard(v);
                    end
                });
            end;
        end;
    elseif u130.Mode == "REPAIR" then
        u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

        for _, v in ipairs(u130:_getRepairableInventory(u1)) do
            table.insert(v131, {
                item = v,
                id = v.itemID,
                price = v.quote and (v.quote.cost or 0) or 0,
                name = v.name or v.itemID,

                render = function() -- Line: 1495, Name: render
                    -- upvalues: u130 (copy), v (copy), u1 (ref)
                    u130:_renderRepairCard(v, u1);
                end
            });
        end;
    else
        u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

        for _, v in ipairs(u130:_getSellableInventory(u1)) do
            table.insert(v131, {
                item = v,
                id = v.itemID,
                price = v.price or 0,
                name = v.name or v.itemID,

                render = function() -- Line: 1505, Name: render
                    -- upvalues: u130 (copy), v (copy), u1 (ref)
                    u130:_renderSellCard(v, u1);
                end
            });
        end;
    end;

    local table_create_ret = table.create(#v131);

    for _, v in ipairs(v131) do
        table.insert(table_create_ret, v.item);
    end;

    u130:_renderTabs(Layout.Counts(table_create_ret));
    local SearchQuery = u130.SearchQuery;
    local v133 = u130.SelectedTab == "All";
    local v134 = {};

    for i, v in ipairs(v131) do
        local v135;

        if SearchQuery then
            v135 = TraderCategories.Matches(v.id, SearchQuery);
        else
            v135 = v133 or v.item.Category == u130.SelectedTab;
        end;

        if v135 then
            v.index = i;
            table.insert(v134, v);
        end;
    end;

    local u136 = u3[u130.SortMode] or u3[1];

    if u136 ~= "Default" then
        table.sort(v134, function(p137, p138) -- Line: 1535
            -- upvalues: u136 (copy)
            if u136 == "Name" then
                local string_lower_ret = string.lower(p137.name);
                local string_lower_ret2 = string.lower(p138.name);

                if string_lower_ret ~= string_lower_ret2 then
                    return string_lower_ret < string_lower_ret2;
                end;
            elseif u136 == "Price: low to high" then
                if p137.price ~= p138.price then
                    return p137.price < p138.price;
                end;
            elseif p137.price ~= p138.price then
                return p137.price > p138.price;
            end;

            return p137.index < p138.index;
        end);
    end;

    for i, v in ipairs(v134) do
        u130._nextLayoutOrder = i;
        v.render();
    end;

    u130._nextLayoutOrder = nil;

    if u130.NoMatch then
        local v139;

        if SearchQuery == nil then
            v139 = false;
        else
            v139 = #v134 == 0;
        end;

        u130.NoMatch.Visible = v139;
    end;
end;

function v2._wireSearch(u140) -- Line: 1564
    -- upvalues: u3 (copy)
    u140.SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 1565
        -- upvalues: u140 (copy)
        local v141 = u140.SearchBox.Text:match("^%s*(.-)%s*$");

        if v141 == "" or not v141 then
            v141 = nil;
        end;

        if v141 == u140.SearchQuery then
            return;
        end;

        u140.SearchQuery = v141;

        if not u140.IsOpen then
            return;
        end;

        u140:_renderItems();
    end);
    u140.SortButton.MouseButton1Click:Connect(function() -- Line: 1573
        -- upvalues: u140 (copy), u3 (ref)
        u140.SortMode = u140.SortMode % #u3 + 1;
        u140.SortButton.Text = "Sort: " .. u3[u140.SortMode];

        if u140.IsOpen then
            u140:_renderItems();
        end;
    end);
    u140.LockedToggle.MouseButton1Click:Connect(function() -- Line: 1578
        -- upvalues: u140 (copy)
        u140.ShowLocked = not u140.ShowLocked;

        if u140.IsOpen then
            u140:_renderItems();
        end;
    end);
end;

function v2._cardParts(p142, p143, u144, p145, p146) -- Line: 1587
    -- upvalues: C (copy), BODY_FONT_BOLD (copy), ItemIconStyle (copy), u1 (ref), ReplicatedStorage (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "NameBar";
    Frame.Size = UDim2.new(1, 0, 0, 22);
    Frame.BackgroundColor3 = C.header;
    Frame.BackgroundTransparency = 0.15;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p143;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Mark";
    Frame2.Size = UDim2.new(0, 2, 1, -8);
    Frame2.Position = UDim2.fromOffset(5, 4);
    Frame2.BackgroundColor3 = C.amber;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local UDim2_new_ret2 = UDim2.new(1, -16, 1, 0);
    local UDim2_fromOffset_ret2 = UDim2.fromOffset(12, 0);
    local paper = C.paper;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Name";
    TextLabel.Size = UDim2_new_ret2;
    TextLabel.Position = UDim2_fromOffset_ret2;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = BODY_FONT_BOLD;
    TextLabel.TextSize = 13;
    TextLabel.TextColor3 = paper;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Text = "";
    TextLabel.Parent = Frame;
    TextLabel.Text = p145;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Icon";
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0);
    ImageLabel.Size = UDim2.new(1, -20, 1, -(30 + p146));
    ImageLabel.Position = UDim2.new(0.5, 0, 0, 26);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = u144.ImageID or "";
    ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(u144);
    ImageLabel.Parent = p143;

    if (not u144.ImageID or u144.ImageID == "") and u144.Model then
        local u147 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));
        u1 = u147;
        pcall(function() -- Line: 1623
            -- upvalues: u147 (copy), ImageLabel (copy), u144 (copy)
            u147:AttachViewportIcon(ImageLabel, u144.Model, u144.ItemType);
        end);
    end;

    return ImageLabel;
end;

function v2._priceBar(p148, p149) -- Line: 1629
    -- upvalues: C (copy), BODY_FONT_BOLD (copy), BODY_FONT (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "PriceBar";
    Frame.Size = UDim2.new(1, 0, 0, 24);
    Frame.Position = UDim2.new(0, 0, 1, -24);
    Frame.BackgroundColor3 = C.panel;
    Frame.BackgroundTransparency = 0.35;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p149;
    local UDim2_new_ret2 = UDim2.new(0.62, -8, 1, 0);
    local UDim2_fromOffset_ret2 = UDim2.fromOffset(8, 0);
    local money = C.money;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Price";
    TextLabel.Size = UDim2_new_ret2;
    TextLabel.Position = UDim2_fromOffset_ret2;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = BODY_FONT_BOLD;
    TextLabel.TextSize = 15;
    TextLabel.TextColor3 = money;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Text = "";
    TextLabel.Parent = Frame;
    local UDim2_new_ret3 = UDim2.new(0.38, -8, 1, 0);
    local UDim2_new_ret4 = UDim2.new(0.62, 0, 0, 0);
    local dim = C.dim;
    local Right = Enum.TextXAlignment.Right;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "Qty";
    TextLabel2.Size = UDim2_new_ret3;
    TextLabel2.Position = UDim2_new_ret4;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = BODY_FONT;
    TextLabel2.TextSize = 13;
    TextLabel2.TextColor3 = dim;
    TextLabel2.TextXAlignment = Right or Enum.TextXAlignment.Left;
    TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel2.Text = "";
    TextLabel2.Parent = Frame;

    return TextLabel, TextLabel2;
end;

function v2._renderBuyCard(u150, u151) -- Line: 1645
    -- upvalues: ItemDatabase (copy), C (copy), u1 (ref), ReplicatedStorage (copy)
    local ItemData = ItemDatabase.GetItemData(u151.ID);

    if not ItemData then
        return;
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Card_" .. u151.ID;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.BackgroundColor3 = ItemData.BackgroundColor or C.row;
    TextButton.BackgroundTransparency = ItemData.BackgroundTransparency or 0.2;
    TextButton.BorderSizePixel = 0;
    TextButton.Parent = u150.ItemContent;
    TextButton.LayoutOrder = u150._nextLayoutOrder or 0;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Thickness = 1;
    UIStroke.Color = C.inner;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = TextButton;
    u150:_cardParts(TextButton, ItemData, ItemData.Name or u151.ID, 24);
    local v152, v153 = u150:_priceBar(TextButton);
    v152.Text = "₽" .. u150:_formatNumber(u151.Price);

    if u151.Locked then
        v152.Text = "REP " .. u150:_formatNumber(u151.RequiredRep or 0);
        v152.TextColor3 = C.faint;
    end;

    v153.Text = u151.Locked and "LOCKED" or "x" .. tostring(u151.Quantity or 1);
    u150:_applyCardState(TextButton, u151, ItemData);
    TextButton.MouseButton1Click:Connect(function() -- Line: 1680
        -- upvalues: u150 (copy), u151 (copy), ItemData (copy)
        u150:_onBuyCardClicked(u151, ItemData);
    end);

    if (u151.Quantity or 0) > 0 and not u151.Locked then
        local R = TextButton.BackgroundColor3.R;
        local G = TextButton.BackgroundColor3.G;
        local B = TextButton.BackgroundColor3.B;
        TextButton:SetAttribute("__BaseR", R);
        TextButton:SetAttribute("__BaseG", G);
        TextButton:SetAttribute("__BaseB", B);
        TextButton.MouseEnter:Connect(function() -- Line: 1689
            -- upvalues: TextButton (copy), R (copy), G (copy), B (copy)
            local v154 = TextButton:GetAttribute("__BaseR") or R;
            local v155 = TextButton:GetAttribute("__BaseG") or G;
            local v156 = TextButton:GetAttribute("__BaseB") or B;
            TextButton.BackgroundColor3 = Color3.new(v154, v155, v156):Lerp(Color3.new(1, 1, 1), 0.12);
        end);
        TextButton.MouseLeave:Connect(function() -- Line: 1695
            -- upvalues: TextButton (copy), R (copy), G (copy), B (copy)
            local v157 = TextButton:GetAttribute("__BaseR") or R;
            local v158 = TextButton:GetAttribute("__BaseG") or G;
            local v159 = TextButton:GetAttribute("__BaseB") or B;
            TextButton.BackgroundColor3 = Color3.new(v157, v158, v159);
        end);
    end;

    TextButton.MouseButton2Click:Connect(function() -- Line: 1703
        -- upvalues: u1 (ref), ReplicatedStorage (ref), u151 (copy)
        u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

        if u1.ShowDetailsPanel then
            u1:ShowDetailsPanel(u151.ID, {
                Metadata = {
                    ID = u151.ID
                }
            });
        end;
    end);
end;

function v2._applyCardState(p160, p161, p162, p163) -- Line: 1711
    -- upvalues: C (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), u1 (ref), ReplicatedStorage (copy)
    local v164 = p160:_getPlayerRoubles();
    local v165 = p161:FindFirstChildOfClass("UIStroke");

    if (p162.Quantity or 0) <= 0 or p162.Locked then
        p161.BackgroundColor3 = C.slot;
        p161.BackgroundTransparency = 0.4;

        if v165 then
            v165.Color = C.line;
        end;
    elseif v164 < p162.Price then
        p161.BackgroundColor3 = Color3_fromRGB_ret3;

        if v165 then
            v165.Color = Color3_fromRGB_ret4;
        end;
    end;

    u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

    if u1.BuyCart then
        for _, v in ipairs(u1.BuyCart) do
            if v.itemID == p162.ID then
                if v165 then
                    v165.Color = C.amber;
                    v165.Thickness = 2;

                    return;
                end;

                break;
            end;
        end;
    end;
end;

function v2._formatNumber(p166, p167) -- Line: 1737
    local math_floor_ret = math.floor(p167);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

function v2._getPlayerRoubles(p168) -- Line: 1742
    return p168._roubleBalance or 0;
end;

function v2._renderSellCard(u169, u170, p171) -- Line: 1746
    -- upvalues: ItemDatabase (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), u1 (ref), ReplicatedStorage (copy)
    local ItemData = ItemDatabase.GetItemData(u170.itemID);

    if not ItemData then
        return;
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Card_Sell_" .. tostring(u170.itemID) .. "_" .. tostring(u170.sourceKey or (u170.sourceInv or "")) .. "_" .. tostring(u170.itemIndex or "");
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.BackgroundColor3 = Color3_fromRGB_ret5;
    TextButton.BackgroundTransparency = 0.2;
    TextButton.BorderSizePixel = 0;
    TextButton.Parent = u169.ItemContent;
    TextButton.LayoutOrder = u169._nextLayoutOrder or 0;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Thickness = 1;
    UIStroke.Color = Color3_fromRGB_ret6;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = TextButton;
    u169:_cardParts(TextButton, ItemData, ItemData.Name or u170.itemID, 24);
    local v172, v173 = u169:_priceBar(TextButton);
    v172.TextColor3 = Color3_fromRGB_ret7;
    v172.Text = "+" .. "₽" .. u169:_formatNumber(u170.price or 0);
    v173.Text = (u170.qty or 1) > 1 and ("x" .. tostring(u170.qty) or "") or "";
    TextButton.MouseButton1Click:Connect(function() -- Line: 1772
        -- upvalues: u169 (copy), u170 (copy)
        u169:_addToSellQueue(u170);
    end);
    local R = TextButton.BackgroundColor3.R;
    local G = TextButton.BackgroundColor3.G;
    local B = TextButton.BackgroundColor3.B;
    TextButton:SetAttribute("__BaseR", R);
    TextButton:SetAttribute("__BaseG", G);
    TextButton:SetAttribute("__BaseB", B);
    TextButton.MouseEnter:Connect(function() -- Line: 1780
        -- upvalues: TextButton (copy), R (copy), G (copy), B (copy)
        local v174 = TextButton:GetAttribute("__BaseR") or R;
        local v175 = TextButton:GetAttribute("__BaseG") or G;
        local v176 = TextButton:GetAttribute("__BaseB") or B;
        TextButton.BackgroundColor3 = Color3.new(v174, v175, v176):Lerp(Color3.new(1, 1, 1), 0.12);
    end);
    TextButton.MouseLeave:Connect(function() -- Line: 1786
        -- upvalues: TextButton (copy), R (copy), G (copy), B (copy)
        local v177 = TextButton:GetAttribute("__BaseR") or R;
        local v178 = TextButton:GetAttribute("__BaseG") or G;
        local v179 = TextButton:GetAttribute("__BaseB") or B;
        TextButton.BackgroundColor3 = Color3.new(v177, v178, v179);
    end);
    TextButton.MouseButton2Click:Connect(function() -- Line: 1793
        -- upvalues: u1 (ref), ReplicatedStorage (ref), u170 (copy)
        u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

        if not u1.ShowDetailsPanel then
            return;
        end;

        local v180 = nil;

        for _, v in ipairs({
            u1.LocalInventory,
            u1.ChestRigInventory,
            u1.BattleBeltInventory,
            u1.MainInventory
        }) do
            if v and (v.Metadata and v.Metadata.TiedInstance == u170.sourceInv) then
                v180 = v;
                break;
            end;
        end;

        local v181 = nil;

        if v180 and v180.Items then
            for _, v in pairs(v180.Items) do
                if v and (v.Metadata and v.Metadata.ItemIndex == u170.itemIndex) then
                    v181 = v;
                    break;
                end;
            end;
        end;

        u1:ShowDetailsPanel(u170.itemID, v181 or {
            Metadata = {
                ID = u170.itemID
            }
        });
    end);
end;

function v2._renderRepairCard(u182, u183, p184) -- Line: 1825
    -- upvalues: ItemDatabase (copy), C (copy), BODY_FONT (copy), BODY_FONT_BOLD (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), TechnicianRepair (copy), u1 (ref), ReplicatedStorage (copy)
    local ItemData = ItemDatabase.GetItemData(u183.itemID);

    if not ItemData then
        return;
    end;

    local quote = u183.quote;

    if not quote then
        return;
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Card_" .. u183.itemID;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.BackgroundColor3 = ItemData.BackgroundColor or C.row;
    TextButton.BackgroundTransparency = ItemData.BackgroundTransparency or 0.2;
    TextButton.BorderSizePixel = 0;
    TextButton.Parent = u182.ItemContent;
    TextButton.LayoutOrder = u182._nextLayoutOrder or 0;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Thickness = 1;
    UIStroke.Color = C.inner;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = TextButton;
    u182:_cardParts(TextButton, ItemData, u183.name or (ItemData.Name or u183.itemID), 70);
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, -12, 0, 14);
    TextLabel.Position = UDim2.new(0, 6, 1, -66);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = BODY_FONT;
    TextLabel.TextSize = 12;
    TextLabel.TextScaled = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextColor3 = C.dim;
    TextLabel.Text = ("Cond %d%% -> 100%%"):format(quote.percent);
    TextLabel.Parent = TextButton;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(1, -12, 0, 14);
    TextLabel2.Position = UDim2.new(0, 6, 1, -50);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = BODY_FONT_BOLD;
    TextLabel2.TextSize = 12;
    TextLabel2.TextScaled = true;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextColor3 = C.amber;
    TextLabel2.Text = "-" .. "₽" .. u182:_formatNumber(quote.cost);
    TextLabel2.Visible = quote.needed;
    TextLabel2.Parent = TextButton;
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Size = UDim2.new(1, -12, 0, 24);
    TextButton2.Position = UDim2.new(0, 6, 1, -30);
    TextButton2.FontFace = BODY_FONT_BOLD;
    TextButton2.TextSize = 12;
    TextButton2.TextScaled = true;
    TextButton2.BorderSizePixel = 0;
    TextButton2.Parent = TextButton;
    local v185 = u182:_getPlayerRoubles();

    if quote.needed then
        if v185 < quote.cost then
            TextButton2.Text = "INSUFFICIENT ROUBLES";
            TextButton2.Active = false;
            TextButton2.BackgroundColor3 = Color3_fromRGB_ret3;
            TextButton2.TextColor3 = Color3.fromRGB(200, 140, 140);
        else
            TextButton2.Text = "REPAIR";
            TextButton2.BackgroundColor3 = C.amber;
            TextButton2.TextColor3 = Color3_fromRGB_ret;
            TextButton2.MouseButton1Click:Connect(function() -- Line: 1927
                -- upvalues: TechnicianRepair (ref), u182 (copy), u183 (copy), quote (copy)
                TechnicianRepair:FireServer(u182.CurrentNPC, u183.sourceInv, u183.itemIndex, u183.itemID, quote.cost);
            end);
        end;
    else
        TextButton2.Text = "NO REPAIR NEEDED";
        TextButton2.Active = false;
        TextButton2.BackgroundColor3 = C.row;
        TextButton2.TextColor3 = C.faint;
    end;

    local R = TextButton.BackgroundColor3.R;
    local G = TextButton.BackgroundColor3.G;
    local B = TextButton.BackgroundColor3.B;
    TextButton:SetAttribute("__BaseR", R);
    TextButton:SetAttribute("__BaseG", G);
    TextButton:SetAttribute("__BaseB", B);
    TextButton.MouseEnter:Connect(function() -- Line: 1940
        -- upvalues: TextButton (copy), R (copy), G (copy), B (copy)
        local v186 = TextButton:GetAttribute("__BaseR") or R;
        local v187 = TextButton:GetAttribute("__BaseG") or G;
        local v188 = TextButton:GetAttribute("__BaseB") or B;
        TextButton.BackgroundColor3 = Color3.new(v186, v187, v188):Lerp(Color3.new(1, 1, 1), 0.12);
    end);
    TextButton.MouseLeave:Connect(function() -- Line: 1946
        -- upvalues: TextButton (copy), R (copy), G (copy), B (copy)
        local v189 = TextButton:GetAttribute("__BaseR") or R;
        local v190 = TextButton:GetAttribute("__BaseG") or G;
        local v191 = TextButton:GetAttribute("__BaseB") or B;
        TextButton.BackgroundColor3 = Color3.new(v189, v190, v191);
    end);
    TextButton.MouseButton2Click:Connect(function() -- Line: 1956
        -- upvalues: u1 (ref), ReplicatedStorage (ref), u183 (copy)
        local v192 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));
        u1 = v192;

        if not v192.ShowDetailsPanel then
            return;
        end;

        v192:ShowDetailsPanel(u183.itemID, u183.tile or {
            Metadata = {
                ID = u183.itemID
            }
        });
    end);
end;

function v2._onBuyCardClicked(p193, u194, p195) -- Line: 1964
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if (u194.Quantity or 0) <= 0 then
        return;
    end;

    if u194.Locked then
        p193:_showToast(("Reach %s %s reputation to buy this"):format(p193:_formatNumber(u194.RequiredRep or 0), (tostring(u194.RepFaction or "faction"))));

        return;
    end;

    if p193:_getPlayerRoubles() < u194.Price then
        p193:_showToast("Insufficient funds");

        return;
    end;

    u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

    local function totalQtyForItem() -- Line: 1979
        -- upvalues: u1 (ref), u194 (copy)
        local v196 = 0;

        if not u1.BuyCart then
            return 0;
        end;

        for _, v in ipairs(u1.BuyCart) do
            if v.itemID == u194.ID then
                v196 = v196 + (v.qty or 1);
            end;
        end;

        return v196;
    end;

    local v197 = totalQtyForItem();
    local v198, v199;

    if u1.AddToBuyCart then
        v198, v199 = pcall(function() -- Line: 1994
            -- upvalues: u1 (ref), u194 (copy)
            u1:AddToBuyCart(u194.ID, u194.Price, nil, nil);
        end);
    else
        v198 = false;
        v199 = "AddToBuyCart not exposed on InventoryController";
    end;

    if not v198 then
        p193:_showToast("Cannot add: " .. tostring(v199));

        return;
    end;

    if totalQtyForItem() <= v197 then
        p193:_showToast("No inventory space");

        return;
    end;

    if u1.RefreshCartGhosts then
        u1:RefreshCartGhosts();
    end;

    p193:_renderItems();
    p193:_renderCart();
end;

function v2._renderCart(u200) -- Line: 2018
    -- upvalues: u1 (ref), ReplicatedStorage (copy), C (copy), BODY_FONT (copy), BODY_FONT_BOLD (copy), Color3_fromRGB_ret7 (copy), Layout (copy), u4 (copy), Color3_fromRGB_ret (copy)
    for _, child in ipairs(u200.CartList:GetChildren()) do
        if child:IsA("Frame") and child.Name:sub(1, 4) == "Row_" then
            child:Destroy();
        end;
    end;

    u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));
    local v201;

    if u200.Mode == "BUY" then
        v201 = u1.BuyCart or {};
    else
        v201 = u200.Mode == "REPAIR" and {} or (u200.SellQueue or {});
    end;

    local v202 = u200.Mode == "SELL";
    local v203 = 0;

    for i, v in ipairs(v201) do
        local v204 = v.qty or 1;
        local v205 = (v.price or 0) * v204;
        local Frame = Instance.new("Frame");
        Frame.Name = "Row_" .. i;
        Frame.Size = UDim2.new(1, -6, 0, 26);
        Frame.LayoutOrder = i;
        Frame.BackgroundColor3 = C.row;
        Frame.BorderSizePixel = 0;
        Frame.Parent = u200.CartList;
        local UDim2_new_ret2 = UDim2.new(1, -144, 1, 0);
        local UDim2_fromOffset_ret2 = UDim2.fromOffset(10, 0);
        local text = C.text;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "Name";
        TextLabel.Size = UDim2_new_ret2;
        TextLabel.Position = UDim2_fromOffset_ret2;
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = BODY_FONT;
        TextLabel.TextSize = 14;
        TextLabel.TextColor3 = text;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel.Text = "";
        TextLabel.Parent = Frame;
        TextLabel.Text = tostring(v.name or v.itemID) .. (v204 > 1 and "  x" .. v204 or "");
        local UDim2_fromOffset_ret3 = UDim2.fromOffset(100, 26);
        local UDim2_new_ret3 = UDim2.new(1, -132, 0, 0);
        local v206 = v202 and Color3_fromRGB_ret7 or C.money;
        local Right = Enum.TextXAlignment.Right;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = "Price";
        TextLabel2.Size = UDim2_fromOffset_ret3;
        TextLabel2.Position = UDim2_new_ret3;
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = BODY_FONT_BOLD;
        TextLabel2.TextSize = 14;
        TextLabel2.TextColor3 = v206;
        TextLabel2.TextXAlignment = Right or Enum.TextXAlignment.Left;
        TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel2.Text = "";
        TextLabel2.Parent = Frame;
        TextLabel2.Text = (v202 and "+" or "") .. "₽" .. u200:_formatNumber(v205);
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "Remove";
        TextButton.Size = UDim2.fromOffset(26, 26);
        TextButton.Position = UDim2.new(1, -26, 0, 0);
        TextButton.BackgroundTransparency = 1;
        TextButton.Text = "X";
        TextButton.TextColor3 = C.blood;
        TextButton.TextSize = 15;
        TextButton.FontFace = BODY_FONT_BOLD;
        TextButton.Parent = Frame;
        TextButton.MouseButton1Click:Connect(function() -- Line: 2072
            -- upvalues: u200 (copy), i (copy)
            u200:_removeCartEntry(i);
        end);
        v203 = v203 + v205;
    end;

    local v207 = u200:_getPlayerRoubles();
    local v208 = Layout.Summary(u200.Mode, #v201, v203, v207);
    u200.BalanceValue.Text = "₽" .. u200:_formatNumber(v207);
    u200.CartTitle.Text = v208.title;
    u200.CartEmpty.Text = u4[u200.Mode] or "";
    u200.CartEmpty.Visible = #v201 == 0;
    u200.SumTotal.Text = (v202 and "+" or "") .. "₽" .. u200:_formatNumber(v203);
    u200.SumBalance.Text = "₽" .. u200:_formatNumber(v207);
    u200.SumAfter.Text = (v208.after < 0 and "-" or "") .. "₽" .. u200:_formatNumber((math.abs(v208.after)));
    u200.SumAfter.TextColor3 = v208.short and C.blood or (v202 and (#v201 > 0 and Color3_fromRGB_ret7) or C.paper);
    local enabled = v208.enabled;
    u200.ConfirmBtn.Text = v208.confirm;
    u200.ConfirmBtn.Visible = u200.Mode ~= "REPAIR";
    u200.ClearBtn.Visible = u200.Mode ~= "REPAIR";
    u200.ConfirmBtn.Active = enabled;
    u200.ConfirmBtn.AutoButtonColor = enabled;
    u200.ConfirmBtn.BackgroundColor3 = enabled and C.amber or C.row;
    u200.ConfirmBtn.TextColor3 = enabled and Color3_fromRGB_ret or C.faint;
end;

function v2._removeCartEntry(p209, p210) -- Line: 2107
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if p209.Mode == "BUY" then
        u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));

        if not u1.BuyCart then
            return;
        end;

        table.remove(u1.BuyCart, p210);

        if u1.RefreshCartGhosts then
            u1:RefreshCartGhosts();
        end;
    else
        local table_remove_ret = table.remove(p209.SellQueue, p210);

        if table_remove_ret then
            p209:_setSellHighlight(table_remove_ret, false);
        end;
    end;

    p209:_renderItems();
    p209:_renderCart();
end;

function v2._confirmBuy(u211) -- Line: 2125
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = u1 or require(ReplicatedStorage:WaitForChild("InventoryController"));
    local v212 = u1.BuyCart or {};

    if #v212 == 0 then
        return;
    end;

    local BuyBulk = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyBulk");
    local u213 = {};

    for _, v in ipairs(v212) do
        local v214 = {
            itemID = v.itemID,
            qty = v.qty or 1
        };

        if v.preferredGrid and (v.preferredPos and (v.preferredGrid.Metadata and v.preferredGrid.Metadata.TiedInstance)) then
            v214.preferredTied = v.preferredGrid.Metadata.TiedInstance;
            v214.preferredPos = {
                X = v.preferredPos.X,
                Y = v.preferredPos.Y
            };
        end;

        table.insert(u213, v214);
    end;

    local success, result = pcall(function() -- Line: 2146
        -- upvalues: BuyBulk (copy), u211 (copy), u213 (copy)
        return BuyBulk:InvokeServer(u211.CurrentNPC, u213);
    end);

    if not success then
        u211:_showToast("Server error");

        return;
    end;

    if not (result and (result.bought and result.bought ~= 0)) then
        return;
    end;

    if not result.rejected or #result.rejected <= 0 then
        table.clear(v212);

        if u1.RefreshCartGhosts then
            u1:RefreshCartGhosts();
        end;

        u211:_renderItems();
        u211:_renderCart();

        if type(result.notice) == "string" and result.notice ~= "" then
            u211:_showToast(result.notice, "info");
        end;

        return;
    end;

    local v215 = result.rejected[1];
    local v216 = type(v215) == "table" and (v215.reason or "rejected") or "rejected";

    if result.items then
        for _, v in ipairs(result.items) do
            local v217 = v;

            for i = 1, #v212 do
                if v212[i] and v212[i].itemID == v217 then
                    table.remove(v212, i);
                    break;
                end;

                local _ = i;
            end;
        end;

        if u1.RefreshCartGhosts then
            u1:RefreshCartGhosts();
        end;
    end;

    local string_format_ret = string.format("Bought %d, %d failed: %s", result.bought, #result.rejected, (tostring(v216)));

    if type(result.notice) == "string" then
        string_format_ret = string_format_ret .. ". " .. result.notice;
    end;

    u211:_showToast(string_format_ret);
    u211:_renderItems();
    u211:_renderCart();
end;

function v2._confirmSell(u218) -- Line: 2213
    -- upvalues: ReplicatedStorage (copy), u1 (ref)
    if #u218.SellQueue == 0 then
        return;
    end;

    local TraderConfirmSell = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TraderConfirmSell");
    local u219 = {};

    for _, v in ipairs(u218.SellQueue) do
        table.insert(u219, {
            itemID = v.itemID,
            qty = v.qty or 1,
            sourceInv = v.sourceInv,
            position = v.position,
            itemIndex = v.itemIndex,
            kind = v.kind,
            slotKey = v.slotKey,
            itemType = v.itemType
        });
    end;

    local success, result = pcall(function() -- Line: 2238
        -- upvalues: TraderConfirmSell (copy), u218 (copy), u219 (copy)
        return TraderConfirmSell:InvokeServer(u218.CurrentNPC, u219);
    end);

    if not success then
        u218:_showToast("Server error");

        return;
    end;

    if not result or (result.sold or 0) == 0 then
        if result and (result.rejected and #result.rejected > 0) then
            local v220 = result.rejected[1];
            local v221 = type(v220) == "table" and (v220.reason or "rejected") or "rejected";
            u218:_showToast("Failed: " .. tostring(v221));
        end;

        return;
    end;

    if result.rejected and #result.rejected > 0 then
        local v222 = result.rejected[1];
        local v223 = type(v222) == "table" and (v222.reason or "rejected") or "rejected";
        u218:_showToast(string.format("Sold %d (+%s%d), %d rejected: %s", result.sold, "₽", result.totalPayout or 0, #result.rejected, (tostring(v223))));
    else
        u218:_showToast(string.format("Sold %d items (+%s%d)", result.sold, "₽", result.totalPayout or 0));
    end;

    for _, v in ipairs(u218.SellQueue) do
        u218:_setSellHighlight(v, false);
    end;

    table.clear(u218.SellQueue);

    if u1.RefreshAllPlayerInventories then
        u1:RefreshAllPlayerInventories();
    end;

    u218:_renderItems();
    u218:_renderCart();
end;

local u224 = {
    error = Color3.fromRGB(120, 40, 40),
    info = Color3.fromRGB(70, 70, 50)
};

function v2._showToast(u225, p226, p227) -- Line: 2290
    -- upvalues: u224 (copy)
    local v228 = tostring(p226);
    u225.Toast.Text = v228;
    u225.Toast.BackgroundColor3 = u224[p227] or u224.error;
    u225.Toast.Visible = true;
    local os_clock_ret = os.clock();
    u225.Toast:SetAttribute("__shownAt", os_clock_ret);
    local math_max_ret = math.max(3, #v228 / 20);
    task.delay(math_max_ret, function() -- Line: 2298
        -- upvalues: u225 (copy), os_clock_ret (copy)
        if u225.Toast:GetAttribute("__shownAt") == os_clock_ret then
            u225.Toast.Visible = false;
        end;
    end);
end;

return v2;