-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local u1 = {
    [68620354] = true,
    [184460696] = true,
    [102248765] = true
};

local function isAdmin(u2) -- Line: 31
    -- upvalues: u1 (copy)
    if u1[u2.UserId] then
        return true;
    end;

    local success, result = pcall(function() -- Line: 34
        -- upvalues: u2 (copy)
        return u2:GetRankInGroup(9949403);
    end);

    return (success and tonumber(result) or 0) >= 180;
end;

local LocalPlayer = Players.LocalPlayer;
local v3;

if u1[LocalPlayer.UserId] then
    v3 = true;
else
    local success, result = pcall(function() -- Line: 34
        -- upvalues: LocalPlayer (copy)
        return LocalPlayer:GetRankInGroup(9949403);
    end);
    v3 = (success and tonumber(result) or 0) >= 180;
end;

if not v3 then
    return;
end;

local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local AdminSpawnItem = Remotes:WaitForChild("AdminSpawnItem");
local AdminListItems = Remotes:WaitForChild("AdminListItems");
local AdminRunCommand = Remotes:WaitForChild("AdminRunCommand");
local v4 = AdminListItems:InvokeServer() or {};
local Color3_fromRGB_ret = Color3.fromRGB(16, 16, 18);
local Color3_fromRGB_ret2 = Color3.fromRGB(20, 20, 24);
local Color3_fromRGB_ret3 = Color3.fromRGB(28, 28, 32);
local Color3_fromRGB_ret4 = Color3.fromRGB(35, 35, 40);
local Color3_fromRGB_ret5 = Color3.fromRGB(80, 80, 90);
local Color3_fromRGB_ret6 = Color3.fromRGB(230, 230, 235);
local Color3_fromRGB_ret7 = Color3.fromRGB(160, 160, 170);
local Color3_fromRGB_ret8 = Color3.fromRGB(60, 90, 60);
local Color3_fromRGB_ret9 = Color3.fromRGB(230, 240, 230);
local Color3_fromRGB_ret10 = Color3.fromRGB(50, 60, 75);
local Color3_fromRGB_ret11 = Color3.fromRGB(230, 240, 250);
local Color3_fromRGB_ret12 = Color3.fromRGB(30, 30, 35);
local Color3_fromRGB_ret13 = Color3.fromRGB(155, 155, 165);
local Color3_fromRGB_ret14 = Color3.fromRGB(80, 40, 40);
local Color3_fromRGB_ret15 = Color3.fromRGB(230, 210, 210);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "AdminSpawner";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 1200;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local Frame = Instance.new("Frame");
Frame.Size = UDim2.new(0, 380, 0, 560);
Frame.Position = UDim2.new(1, -400, 0, 60);
Frame.BackgroundColor3 = Color3_fromRGB_ret2;
Frame.BorderSizePixel = 0;
Frame.Visible = false;
Frame.Parent = ScreenGui;
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6);
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3_fromRGB_ret5;
UIStroke.Thickness = 1;
UIStroke.Parent = Frame;
local TextLabel = Instance.new("TextLabel");
TextLabel.Size = UDim2.new(1, -16, 0, 28);
TextLabel.Position = UDim2.new(0, 8, 0, 8);
TextLabel.BackgroundTransparency = 1;
TextLabel.Text = "ADMIN PANEL  (F8 to toggle)";
TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel.Font = Enum.Font.GothamBold;
TextLabel.TextSize = 14;
TextLabel.TextColor3 = Color3_fromRGB_ret6;
TextLabel.Parent = Frame;
local TextButton = Instance.new("TextButton");
TextButton.Size = UDim2.new(0, 28, 0, 24);
TextButton.Position = UDim2.new(1, -36, 0, 10);
TextButton.BackgroundColor3 = Color3_fromRGB_ret14;
TextButton.BorderSizePixel = 0;
TextButton.Text = "X";
TextButton.Font = Enum.Font.GothamBold;
TextButton.TextSize = 12;
TextButton.TextColor3 = Color3_fromRGB_ret15;
TextButton.Parent = Frame;
Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 4);
local Frame2 = Instance.new("Frame");
Frame2.Size = UDim2.new(1, -16, 0, 32);
Frame2.Position = UDim2.new(0, 8, 0, 44);
Frame2.BackgroundTransparency = 1;
Frame2.Parent = Frame;
local u5 = "items";
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local TestingPane = script:FindFirstChild("TestingPane");
local v10 = TestingPane and 0.25 or 0.3333333333333333;
local v11 = TestingPane and 3 or 2;

local function styleTab(p12, p13) -- Line: 126
    -- upvalues: Color3_fromRGB_ret10 (copy), Color3_fromRGB_ret12 (copy), Color3_fromRGB_ret11 (copy), Color3_fromRGB_ret13 (copy)
    p12.BackgroundColor3 = p13 and Color3_fromRGB_ret10 or Color3_fromRGB_ret12;
    p12.TextColor3 = p13 and Color3_fromRGB_ret11 or Color3_fromRGB_ret13;
end;

local function setTab(p14) -- Line: 131
    -- upvalues: u5 (ref), u6 (ref), Color3_fromRGB_ret10 (copy), Color3_fromRGB_ret12 (copy), Color3_fromRGB_ret11 (copy), Color3_fromRGB_ret13 (copy), u7 (ref), u8 (ref), u9 (ref)
    u5 = p14;
    local v15 = u6;
    local v16 = p14 == "items";
    v15.BackgroundColor3 = v16 and Color3_fromRGB_ret10 or Color3_fromRGB_ret12;
    v15.TextColor3 = v16 and Color3_fromRGB_ret11 or Color3_fromRGB_ret13;
    local v17 = u7;
    local v18 = p14 == "cmds";
    v17.BackgroundColor3 = v18 and Color3_fromRGB_ret10 or Color3_fromRGB_ret12;
    v17.TextColor3 = v18 and Color3_fromRGB_ret11 or Color3_fromRGB_ret13;

    if u8 then
        local v19 = u8;
        local v20 = p14 == "testing";
        v19.BackgroundColor3 = v20 and Color3_fromRGB_ret10 or Color3_fromRGB_ret12;
        v19.TextColor3 = v20 and Color3_fromRGB_ret11 or Color3_fromRGB_ret13;
    end;

    local v21 = u9;
    local v22 = p14 == "codes";
    v21.BackgroundColor3 = v22 and Color3_fromRGB_ret10 or Color3_fromRGB_ret12;
    v21.TextColor3 = v22 and Color3_fromRGB_ret11 or Color3_fromRGB_ret13;

    if _G.__admin_setPane then
        _G.__admin_setPane(p14);
    end;
end;

u6 = Instance.new("TextButton");
u6.Size = UDim2.new(v10, -2, 1, 0);
u6.Position = UDim2.new(0, 0, 0, 0);
u6.BorderSizePixel = 0;
u6.Text = "ITEMS";
u6.Font = Enum.Font.GothamBold;
u6.TextSize = 12;
u6.Parent = Frame2;
Instance.new("UICorner", u6).CornerRadius = UDim.new(0, 4);
local v23 = u6;
v23.BackgroundColor3 = Color3_fromRGB_ret10 or Color3_fromRGB_ret12;
v23.TextColor3 = Color3_fromRGB_ret11 or Color3_fromRGB_ret13;
u6.MouseButton1Click:Connect(function() -- Line: 150
    -- upvalues: setTab (copy)
    setTab("items");
end);
u7 = Instance.new("TextButton");
u7.Size = UDim2.new(v10, -2, 1, 0);
u7.Position = UDim2.new(v10, 2, 0, 0);
u7.BorderSizePixel = 0;
u7.Text = "COMMANDS";
u7.Font = Enum.Font.GothamBold;
u7.TextSize = 12;
u7.Parent = Frame2;
Instance.new("UICorner", u7).CornerRadius = UDim.new(0, 4);
local v24 = u7;
v24.BackgroundColor3 = Color3_fromRGB_ret12;
v24.TextColor3 = Color3_fromRGB_ret13;
u7.MouseButton1Click:Connect(function() -- Line: 162
    -- upvalues: setTab (copy)
    setTab("cmds");
end);

if TestingPane then
    u8 = Instance.new("TextButton");
    u8.Size = UDim2.new(v10, -2, 1, 0);
    u8.Position = UDim2.new(v10 * 2, 4, 0, 0);
    u8.BorderSizePixel = 0;
    u8.Text = "TESTING";
    u8.Font = Enum.Font.GothamBold;
    u8.TextSize = 12;
    u8.Parent = Frame2;
    Instance.new("UICorner", u8).CornerRadius = UDim.new(0, 4);
    local v25 = u8;
    v25.BackgroundColor3 = Color3_fromRGB_ret12;
    v25.TextColor3 = Color3_fromRGB_ret13;
    u8.MouseButton1Click:Connect(function() -- Line: 175
        -- upvalues: setTab (copy)
        setTab("testing");
    end);
end;

u9 = Instance.new("TextButton");
u9.Size = UDim2.new(v10, -2, 1, 0);
u9.Position = UDim2.new(v10 * v11, v11 * 2, 0, 0);
u9.BorderSizePixel = 0;
u9.Text = "CODES";
u9.Font = Enum.Font.GothamBold;
u9.TextSize = 12;
u9.Parent = Frame2;
Instance.new("UICorner", u9).CornerRadius = UDim.new(0, 4);
local v26 = u9;
v26.BackgroundColor3 = Color3_fromRGB_ret12;
v26.TextColor3 = Color3_fromRGB_ret13;
u9.MouseButton1Click:Connect(function() -- Line: 189
    -- upvalues: setTab (copy)
    setTab("codes");
end);
local Frame3 = Instance.new("Frame");
Frame3.Size = UDim2.new(1, -16, 1, -92);
Frame3.Position = UDim2.new(0, 8, 0, 84);
Frame3.BackgroundTransparency = 1;
Frame3.Parent = Frame;
local Frame4 = Instance.new("Frame");
Frame4.Size = UDim2.fromScale(1, 1);
Frame4.BackgroundTransparency = 1;
Frame4.Parent = Frame3;
local TextBox = Instance.new("TextBox");
TextBox.Size = UDim2.new(1, 0, 0, 30);
TextBox.Position = UDim2.new(0, 0, 0, 0);
TextBox.BackgroundColor3 = Color3_fromRGB_ret4;
TextBox.BorderSizePixel = 0;
TextBox.PlaceholderText = "Search items...";
TextBox.Text = "";
TextBox.Font = Enum.Font.Gotham;
TextBox.TextSize = 13;
TextBox.TextColor3 = Color3_fromRGB_ret6;
TextBox.PlaceholderColor3 = Color3_fromRGB_ret7;
TextBox.ClearTextOnFocus = false;
TextBox.Parent = Frame4;
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 4);
local UIPadding = Instance.new("UIPadding");
UIPadding.PaddingLeft = UDim.new(0, 8);
UIPadding.Parent = TextBox;
local u27 = "inventory";
local Frame5 = Instance.new("Frame");
Frame5.Size = UDim2.new(1, 0, 0, 28);
Frame5.Position = UDim2.new(0, 0, 0, 38);
Frame5.BackgroundTransparency = 1;
Frame5.Parent = Frame4;

local function makeModeBtn(p28, u29, p30) -- Line: 225
    -- upvalues: Frame5 (copy), u27 (ref), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret7 (copy)
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Size = UDim2.new(0.5, -2, 1, 0);
    TextButton2.Position = UDim2.new(p30, p30 == 0 and 0 or 2, 0, 0);
    TextButton2.BorderSizePixel = 0;
    TextButton2.Text = p28;
    TextButton2.Font = Enum.Font.GothamBold;
    TextButton2.TextSize = 12;
    TextButton2.Parent = Frame5;
    Instance.new("UICorner", TextButton2).CornerRadius = UDim.new(0, 4);
    TextButton2:SetAttribute("Mode", u29);
    TextButton2.MouseButton1Click:Connect(function() -- Line: 236
        -- upvalues: u27 (ref), u29 (copy), Frame5 (ref), Color3_fromRGB_ret8 (ref), Color3_fromRGB_ret9 (ref), Color3_fromRGB_ret7 (ref)
        u27 = u29;

        for _, child in ipairs(Frame5:GetChildren()) do
            if child:IsA("TextButton") then
                local v31 = child:GetAttribute("Mode") == u27;
                child.BackgroundColor3 = v31 and Color3_fromRGB_ret8 or Color3.fromRGB(40, 40, 45);
                child.TextColor3 = v31 and Color3_fromRGB_ret9 or Color3_fromRGB_ret7;
            end;
        end;
    end);

    return TextButton2;
end;

local v32 = makeModeBtn("INVENTORY", "inventory", 0);
local v33 = makeModeBtn("WORLD DROP", "world", 0.5);
v32.BackgroundColor3 = Color3_fromRGB_ret8;
v32.TextColor3 = Color3_fromRGB_ret9;
v33.BackgroundColor3 = Color3.fromRGB(40, 40, 45);
v33.TextColor3 = Color3_fromRGB_ret7;
local ScrollingFrame = Instance.new("ScrollingFrame");
ScrollingFrame.Size = UDim2.new(1, 0, 1, -78);
ScrollingFrame.Position = UDim2.new(0, 0, 0, 74);
ScrollingFrame.BackgroundColor3 = Color3_fromRGB_ret;
ScrollingFrame.BorderSizePixel = 0;
ScrollingFrame.ScrollBarThickness = 6;
ScrollingFrame.ScrollBarImageColor3 = Color3_fromRGB_ret5;
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0);
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
ScrollingFrame.Parent = Frame4;
Instance.new("UICorner", ScrollingFrame).CornerRadius = UDim.new(0, 4);
local UIListLayout = Instance.new("UIListLayout");
UIListLayout.Padding = UDim.new(0, 2);
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout.Parent = ScrollingFrame;
local UIPadding2 = Instance.new("UIPadding");
UIPadding2.PaddingTop = UDim.new(0, 4);
UIPadding2.PaddingBottom = UDim.new(0, 4);
UIPadding2.PaddingLeft = UDim.new(0, 4);
UIPadding2.PaddingRight = UDim.new(0, 4);
UIPadding2.Parent = ScrollingFrame;
local u34 = {
    Primary = Color3.fromRGB(80, 60, 30),
    Sidearm = Color3.fromRGB(80, 60, 30),
    Ammo = Color3.fromRGB(70, 60, 30),
    AmmoPack = Color3.fromRGB(70, 60, 30),
    BodyGear = Color3.fromRGB(40, 60, 35),
    HeadGear = Color3.fromRGB(35, 45, 60),
    BeltGear = Color3.fromRGB(45, 45, 30),
    Backpack = Color3.fromRGB(50, 35, 30),
    Uniform = Color3.fromRGB(50, 40, 50),
    Medical = Color3.fromRGB(35, 60, 45),
    FoodAndDrink = Color3.fromRGB(45, 55, 30),
    FaceWear = Color3.fromRGB(40, 40, 40),
    EyeWear = Color3.fromRGB(40, 40, 40),
    NightOptical = Color3.fromRGB(30, 40, 50),
    Vial = Color3.fromRGB(45, 35, 50),
    Injector = Color3.fromRGB(45, 40, 60),
    Currency = Color3.fromRGB(60, 55, 30),
    HighValue = Color3.fromRGB(55, 35, 60),
    General = Color3.fromRGB(40, 40, 45)
};

local function makeRow(u35, p36) -- Line: 286
    -- upvalues: u34 (copy), ScrollingFrame (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret9 (copy), AdminSpawnItem (copy), u27 (ref)
    local Frame6 = Instance.new("Frame");
    Frame6.Size = UDim2.new(1, -8, 0, 32);
    Frame6.BackgroundColor3 = u34[u35.ItemType] or Color3.fromRGB(40, 40, 45);
    Frame6.BorderSizePixel = 0;
    Frame6.LayoutOrder = p36;
    Frame6.Parent = ScrollingFrame;
    Instance.new("UICorner", Frame6).CornerRadius = UDim.new(0, 3);
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(0, 90, 1, 0);
    TextLabel2.Position = UDim2.new(0, 6, 0, 0);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = u35.ItemType;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Font = Enum.Font.GothamMedium;
    TextLabel2.TextSize = 10;
    TextLabel2.TextColor3 = Color3_fromRGB_ret7;
    TextLabel2.Parent = Frame6;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.new(1, -190, 1, 0);
    TextLabel3.Position = UDim2.new(0, 100, 0, 0);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.Text = u35.Name;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Font = Enum.Font.Gotham;
    TextLabel3.TextSize = 12;
    TextLabel3.TextColor3 = Color3_fromRGB_ret6;
    TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel3.Parent = Frame6;
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Size = UDim2.new(0, 80, 0, 24);
    TextButton2.Position = UDim2.new(1, -86, 0, 4);
    TextButton2.BackgroundColor3 = Color3_fromRGB_ret8;
    TextButton2.BorderSizePixel = 0;
    TextButton2.Text = "SPAWN";
    TextButton2.Font = Enum.Font.GothamBold;
    TextButton2.TextSize = 11;
    TextButton2.TextColor3 = Color3_fromRGB_ret9;
    TextButton2.Parent = Frame6;
    Instance.new("UICorner", TextButton2).CornerRadius = UDim.new(0, 3);
    TextButton2.MouseButton1Click:Connect(function() -- Line: 316
        -- upvalues: AdminSpawnItem (ref), u35 (copy), u27 (ref)
        AdminSpawnItem:FireServer(u35.ID, u27);
    end);

    return Frame6;
end;

local u37 = {};

for i, v in ipairs(v4) do
    local v38 = {
        row = makeRow(v, i),
        item = v
    };
    table.insert(u37, v38);
end;

TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 324, Name: applyFilter
    -- upvalues: TextBox (copy), u37 (copy)
    local string_lower_ret = string.lower(TextBox.Text);

    for _, v in ipairs(u37) do
        local v39 = string_lower_ret == "" and true or (string.find(string.lower(v.item.Name), string_lower_ret, 1, true) or (string.find(string.lower(v.item.ID), string_lower_ret, 1, true) or string.find(string.lower(v.item.ItemType), string_lower_ret, 1, true)));
        local v40;

        if v39 == nil then
            v40 = false;
        else
            v40 = v39 ~= false;
        end;

        v.row.Visible = v40;
    end;
end);
local Frame6 = Instance.new("Frame");
Frame6.Size = UDim2.fromScale(1, 1);
Frame6.BackgroundTransparency = 1;
Frame6.Visible = false;
Frame6.Parent = Frame3;
local ScrollingFrame2 = Instance.new("ScrollingFrame");
ScrollingFrame2.Size = UDim2.new(1, 0, 1, -46);
ScrollingFrame2.Position = UDim2.new(0, 0, 0, 0);
ScrollingFrame2.BackgroundColor3 = Color3_fromRGB_ret;
ScrollingFrame2.BorderSizePixel = 0;
ScrollingFrame2.ScrollBarThickness = 6;
ScrollingFrame2.ScrollBarImageColor3 = Color3_fromRGB_ret5;
ScrollingFrame2.CanvasSize = UDim2.new(0, 0, 0, 0);
ScrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.Y;
ScrollingFrame2.Parent = Frame6;
Instance.new("UICorner", ScrollingFrame2).CornerRadius = UDim.new(0, 4);
local UIListLayout2 = Instance.new("UIListLayout");
UIListLayout2.Padding = UDim.new(0, 4);
UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout2.Parent = ScrollingFrame2;
local UIPadding3 = Instance.new("UIPadding");
UIPadding3.PaddingTop = UDim.new(0, 6);
UIPadding3.PaddingBottom = UDim.new(0, 6);
UIPadding3.PaddingLeft = UDim.new(0, 6);
UIPadding3.PaddingRight = UDim.new(0, 6);
UIPadding3.Parent = ScrollingFrame2;

local function makeSectionHeader(p41, p42) -- Line: 360
    -- upvalues: ScrollingFrame2 (copy)
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(1, 0, 0, 20);
    TextLabel2.LayoutOrder = p42;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = p41;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Font = Enum.Font.GothamBold;
    TextLabel2.TextSize = 11;
    TextLabel2.TextColor3 = Color3.fromRGB(180, 175, 130);
    TextLabel2.Parent = ScrollingFrame2;
end;

local function makeCmdRow(p43) -- Line: 373
    -- upvalues: ScrollingFrame2 (copy)
    local Frame7 = Instance.new("Frame");
    Frame7.Size = UDim2.new(1, 0, 0, 30);
    Frame7.LayoutOrder = p43;
    Frame7.BackgroundTransparency = 1;
    Frame7.Parent = ScrollingFrame2;

    return Frame7;
end;

local function makeButton(p44, p45, p46, p47, p48, p49, p50) -- Line: 382
    -- upvalues: Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret6 (copy)
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Size = UDim2.new(p46, p47, 1, 0);
    TextButton2.Position = UDim2.new(p48, p48 == 0 and 0 or 4, 0, 0);
    TextButton2.BackgroundColor3 = p49 or Color3_fromRGB_ret3;
    TextButton2.BorderSizePixel = 0;
    TextButton2.Text = p45;
    TextButton2.Font = Enum.Font.GothamBold;
    TextButton2.TextSize = 11;
    TextButton2.TextColor3 = Color3_fromRGB_ret6;
    TextButton2.Parent = p44;
    Instance.new("UICorner", TextButton2).CornerRadius = UDim.new(0, 3);
    TextButton2.MouseButton1Click:Connect(p50);

    return TextButton2;
end;

local function run(p51, ...) -- Line: 398
    -- upvalues: AdminRunCommand (copy)
    AdminRunCommand:FireServer(p51, { ... });
end;

local u52 = 0;

local function nextOrder() -- Line: 403
    -- upvalues: u52 (ref)
    u52 = u52 + 1;

    return u52;
end;

local function makeDropdown(p53, p54, u55) -- Line: 411
    -- upvalues: makeSectionHeader (copy), u52 (ref), ScrollingFrame2 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret6 (copy)
    u52 = u52 + 1;
    makeSectionHeader(p53, u52);
    u52 = u52 + 1;
    local Frame7 = Instance.new("Frame");
    Frame7.Size = UDim2.new(1, 0, 0, 30);
    Frame7.LayoutOrder = u52;
    Frame7.BackgroundTransparency = 1;
    Frame7.Parent = ScrollingFrame2;
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Size = UDim2.new(0.72, -3, 1, 0);
    TextButton2.BackgroundColor3 = Color3_fromRGB_ret4;
    TextButton2.BorderSizePixel = 0;
    TextButton2.Font = Enum.Font.Gotham;
    TextButton2.TextSize = 11;
    TextButton2.TextColor3 = Color3_fromRGB_ret7;
    TextButton2.TextXAlignment = Enum.TextXAlignment.Left;
    TextButton2.TextTruncate = Enum.TextTruncate.AtEnd;
    TextButton2.Text = ("  select... (%d)"):format(#p54);
    TextButton2.Parent = Frame7;
    Instance.new("UICorner", TextButton2).CornerRadius = UDim.new(0, 3);
    local TextButton3 = Instance.new("TextButton");
    TextButton3.Size = UDim2.new(0.28, -3, 1, 0);
    TextButton3.Position = UDim2.new(0.72, 4, 0, 0);
    TextButton3.BackgroundColor3 = Color3_fromRGB_ret8;
    TextButton3.BorderSizePixel = 0;
    TextButton3.Text = "GRANT";
    TextButton3.Font = Enum.Font.GothamBold;
    TextButton3.TextSize = 11;
    TextButton3.TextColor3 = Color3_fromRGB_ret9;
    TextButton3.Parent = Frame7;
    Instance.new("UICorner", TextButton3).CornerRadius = UDim.new(0, 3);
    local ScrollingFrame3 = Instance.new("ScrollingFrame");
    ScrollingFrame3.Size = UDim2.new(1, 0, 0, 150);
    u52 = u52 + 1;
    ScrollingFrame3.LayoutOrder = u52;
    ScrollingFrame3.BackgroundColor3 = Color3_fromRGB_ret;
    ScrollingFrame3.BorderSizePixel = 0;
    ScrollingFrame3.ScrollBarThickness = 5;
    ScrollingFrame3.ScrollBarImageColor3 = Color3_fromRGB_ret5;
    ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, 0);
    ScrollingFrame3.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame3.Visible = false;
    ScrollingFrame3.Parent = ScrollingFrame2;
    Instance.new("UICorner", ScrollingFrame3).CornerRadius = UDim.new(0, 3);
    local UIListLayout3 = Instance.new("UIListLayout");
    UIListLayout3.Padding = UDim.new(0, 2);
    UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout3.Parent = ScrollingFrame3;
    local UIPadding4 = Instance.new("UIPadding");
    UIPadding4.PaddingTop = UDim.new(0, 3);
    UIPadding4.PaddingBottom = UDim.new(0, 3);
    UIPadding4.PaddingLeft = UDim.new(0, 3);
    UIPadding4.PaddingRight = UDim.new(0, 3);
    UIPadding4.Parent = ScrollingFrame3;
    local u56 = nil;

    for i, v in ipairs(p54) do
        local TextButton4 = Instance.new("TextButton");
        TextButton4.Size = UDim2.new(1, 0, 0, 22);
        TextButton4.LayoutOrder = i;
        TextButton4.BackgroundColor3 = Color3_fromRGB_ret3;
        TextButton4.BorderSizePixel = 0;
        TextButton4.Font = Enum.Font.Gotham;
        TextButton4.TextSize = 11;
        TextButton4.TextColor3 = Color3_fromRGB_ret6;
        TextButton4.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton4.TextTruncate = Enum.TextTruncate.AtEnd;
        TextButton4.Text = "  " .. v.text;
        TextButton4.Parent = ScrollingFrame3;
        Instance.new("UICorner", TextButton4).CornerRadius = UDim.new(0, 2);
        TextButton4.MouseButton1Click:Connect(function() -- Line: 475
            -- upvalues: u56 (ref), v (copy), TextButton2 (copy), Color3_fromRGB_ret6 (ref), ScrollingFrame3 (copy)
            u56 = v.value;
            TextButton2.Text = "  " .. v.text;
            TextButton2.TextColor3 = Color3_fromRGB_ret6;
            ScrollingFrame3.Visible = false;
        end);
    end;

    TextButton2.MouseButton1Click:Connect(function() -- Line: 483
        -- upvalues: ScrollingFrame3 (copy)
        ScrollingFrame3.Visible = not ScrollingFrame3.Visible;
    end);
    TextButton3.MouseButton1Click:Connect(function() -- Line: 486
        -- upvalues: u56 (ref), ScrollingFrame3 (copy), u55 (copy)
        if u56 then
            u55(u56);

            return;
        end;

        ScrollingFrame3.Visible = true;
    end);
end;

u52 = u52 + 1;
makeSectionHeader("SUPPORTER TIERS", u52);
u52 = u52 + 1;
local Frame7 = Instance.new("Frame");
Frame7.Size = UDim2.new(1, 0, 0, 30);
Frame7.LayoutOrder = u52;
Frame7.BackgroundTransparency = 1;
Frame7.Parent = ScrollingFrame2;
Frame7.Size = UDim2.new(1, 0, 0, 28);
local TextBox2 = Instance.new("TextBox");
TextBox2.Size = UDim2.new(1, 0, 1, 0);
TextBox2.BackgroundColor3 = Color3_fromRGB_ret4;
TextBox2.BorderSizePixel = 0;
TextBox2.PlaceholderText = "Target player (empty = self) — applies to grant/pack/skin";
TextBox2.Text = "";
TextBox2.Font = Enum.Font.Gotham;
TextBox2.TextSize = 12;
TextBox2.TextColor3 = Color3_fromRGB_ret6;
TextBox2.PlaceholderColor3 = Color3_fromRGB_ret7;
TextBox2.ClearTextOnFocus = false;
TextBox2.Parent = Frame7;
Instance.new("UICorner", TextBox2).CornerRadius = UDim.new(0, 3);
local UIPadding4 = Instance.new("UIPadding");
UIPadding4.PaddingLeft = UDim.new(0, 8);
UIPadding4.Parent = TextBox2;

local function runGrant(p57) -- Line: 511
    -- upvalues: TextBox2 (copy), run (copy)
    if TextBox2.Text == "" then
        run("grant", p57);

        return;
    end;

    run("grant", p57, TextBox2.Text);
end;

u52 = u52 + 1;
local Frame8 = Instance.new("Frame");
Frame8.Size = UDim2.new(1, 0, 0, 30);
Frame8.LayoutOrder = u52;
Frame8.BackgroundTransparency = 1;
Frame8.Parent = ScrollingFrame2;
makeButton(Frame8, "GRANT DRIFTER", 0.3333333333333333, -3, 0, Color3.fromRGB(50, 60, 75), function() -- Line: 520
    -- upvalues: TextBox2 (copy), run (copy)
    if TextBox2.Text == "" then
        run("grant", "drifter");

        return;
    end;

    run("grant", "drifter", TextBox2.Text);
end);
makeButton(Frame8, "GRANT VETERAN", 0.3333333333333333, -3, 0.3333333333333333, Color3.fromRGB(50, 75, 55), function() -- Line: 521
    -- upvalues: TextBox2 (copy), run (copy)
    if TextBox2.Text == "" then
        run("grant", "veteran");

        return;
    end;

    run("grant", "veteran", TextBox2.Text);
end);
makeButton(Frame8, "GRANT MASTER", 0.3333333333333333, -3, 0.6666666666666666, Color3.fromRGB(80, 65, 30), function() -- Line: 522
    -- upvalues: TextBox2 (copy), run (copy)
    if TextBox2.Text == "" then
        run("grant", "master");

        return;
    end;

    run("grant", "master", TextBox2.Text);
end);
u52 = u52 + 1;
local Frame9 = Instance.new("Frame");
Frame9.Size = UDim2.new(1, 0, 0, 30);
Frame9.LayoutOrder = u52;
Frame9.BackgroundTransparency = 1;
Frame9.Parent = ScrollingFrame2;
makeButton(Frame9, "RESET TIER ATTR", 0.5, -3, 0, Color3.fromRGB(60, 50, 35), function() -- Line: 525
    -- upvalues: run (copy)
    run("reset");
end);
makeButton(Frame9, "CLEAR SKINS DS", 0.5, -3, 0.5, Color3.fromRGB(65, 45, 45), function() -- Line: 526
    -- upvalues: run (copy)
    run("clearskins");
end);

local function safeRequire(u58) -- Line: 531
    -- upvalues: ReplicatedStorage (copy)
    local success, result = pcall(function() -- Line: 532
        -- upvalues: ReplicatedStorage (ref), u58 (copy)
        return require(ReplicatedStorage:WaitForChild(u58, 5));
    end);

    return success and result and result or nil;
end;

local u59 = "SkinCatalog";
local success, result = pcall(function() -- Line: 532
    -- upvalues: ReplicatedStorage (copy), u59 (copy)
    return require(ReplicatedStorage:WaitForChild(u59, 5));
end);
local v60 = success and result and result or nil;
local u61 = "SupporterCatalog";
local success2, result2 = pcall(function() -- Line: 532
    -- upvalues: ReplicatedStorage (copy), u61 (copy)
    return require(ReplicatedStorage:WaitForChild(u61, 5));
end);
local v62 = success2 and result2 and result2 or nil;
local u63 = "ItemDatabase";
local success3, result3 = pcall(function() -- Line: 532
    -- upvalues: ReplicatedStorage (copy), u63 (copy)
    return require(ReplicatedStorage:WaitForChild(u63, 5));
end);
local u64 = success3 and result3 and result3 or nil;

local function prettyName(p65) -- Line: 539
    -- upvalues: u64 (copy)
    local v66 = u64 and rawget(u64, p65);

    if v66 then
        v66 = v66.Name;
    end;

    if v66 and v66 ~= p65 then
        return v66 .. "  ·  " .. p65;
    end;

    return p65;
end;

local v67 = {};
local v68 = {};

if v60 and v60.Skins then
    for i in pairs(v60.Skins) do
        v68[i] = "catalog";
    end;
end;

if v62 and v62.Tiers then
    for _, v in pairs(v62.Tiers) do
        for _, v2 in ipairs(v.ExclusiveSkins or {}) do
            if not v68[v2] then
                v68[v2] = "tier";
            end;
        end;
    end;
end;

for i, v in pairs(v68) do
    local v69 = {
        value = i
    };
    local v70;

    if u64 then
        v70 = rawget(u64, i);
    else
        v70 = u64;
    end;

    if v70 then
        v70 = v70.Name;
    end;

    local v71;

    if v70 and v70 ~= i then
        v71 = v70 .. "  ·  " .. i;
    else
        v71 = i;
    end;

    v69.text = v71 .. (v == "tier" and "   [tier-only]" or "");
    v67[#v67 + 1] = v69;
end;

table.sort(v67, function(p72, p73) -- Line: 568
    return p72.text < p73.text;
end);
local v74 = {};

if v60 and v60.Packs then
    for i, v in pairs(v60.Packs) do
        v74[#v74 + 1] = {
            value = i,
            text = ("%s  (%d)"):format(v.DisplayName or i, #(v.Skins or {}))
        };
    end;

    table.sort(v74, function(p75, p76) -- Line: 579
        return p75.text < p76.text;
    end);
end;

local function withTarget(u77) -- Line: 582
    -- upvalues: TextBox2 (copy), run (copy)
    return function(p78) -- Line: 583
        -- upvalues: TextBox2 (ref), run (ref), u77 (copy)
        if TextBox2.Text == "" then
            run(u77, p78);

            return;
        end;

        run(u77, p78, TextBox2.Text);
    end;
end;

if #v67 > 0 then
    local u79 = "skin";
    makeDropdown(("GRANT SKIN  (%d)"):format(#v67), v67, function(p80) -- Line: 583
        -- upvalues: TextBox2 (copy), run (copy), u79 (copy)
        if TextBox2.Text == "" then
            run(u79, p80);

            return;
        end;

        run(u79, p80, TextBox2.Text);
    end);
end;

if #v74 > 0 then
    local u81 = "pack";
    makeDropdown(("GRANT SKIN PACK / BUNDLE  (%d)"):format(#v74), v74, function(p82) -- Line: 583
        -- upvalues: TextBox2 (copy), run (copy), u81 (copy)
        if TextBox2.Text == "" then
            run(u81, p82);

            return;
        end;

        run(u81, p82, TextBox2.Text);
    end);
end;

u52 = u52 + 1;
makeSectionHeader("ROUBLES", u52);
u52 = u52 + 1;
local Frame10 = Instance.new("Frame");
Frame10.Size = UDim2.new(1, 0, 0, 30);
Frame10.LayoutOrder = u52;
Frame10.BackgroundTransparency = 1;
Frame10.Parent = ScrollingFrame2;
makeButton(Frame10, "+10K", 0.25, -3, 0, Color3_fromRGB_ret8, function() -- Line: 601
    -- upvalues: run (copy)
    run("addroubles", "10000");
end);
makeButton(Frame10, "+100K", 0.25, -3, 0.25, Color3_fromRGB_ret8, function() -- Line: 602
    -- upvalues: run (copy)
    run("addroubles", "100000");
end);
makeButton(Frame10, "+1M", 0.25, -3, 0.5, Color3_fromRGB_ret8, function() -- Line: 603
    -- upvalues: run (copy)
    run("addroubles", "1000000");
end);
makeButton(Frame10, "SET 0", 0.25, -3, 0.75, Color3_fromRGB_ret14, function() -- Line: 604
    -- upvalues: run (copy)
    run("roubles", "0");
end);
u52 = u52 + 1;
makeSectionHeader("STASH PREMIUM TIER", u52);
u52 = u52 + 1;
local Frame11 = Instance.new("Frame");
Frame11.Size = UDim2.new(1, 0, 0, 30);
Frame11.LayoutOrder = u52;
Frame11.BackgroundTransparency = 1;
Frame11.Parent = ScrollingFrame2;

for i = 0, 3 do
    makeButton(Frame11, "T" .. tostring(i), 0.25, -3, i / 4, Color3_fromRGB_ret3, function() -- Line: 610
        -- upvalues: run (copy), i (copy)
        run("stash", (tostring(i)));
    end);
    local _ = i;
end;

u52 = u52 + 1;
local Frame12 = Instance.new("Frame");
Frame12.Size = UDim2.new(1, 0, 0, 30);
Frame12.LayoutOrder = u52;
Frame12.BackgroundTransparency = 1;
Frame12.Parent = ScrollingFrame2;

for i = 4, 7 do
    makeButton(Frame12, "T" .. tostring(i), 0.25, -3, (i - 4) / 4, Color3_fromRGB_ret3, function() -- Line: 615
        -- upvalues: run (copy), i (copy)
        run("stash", (tostring(i)));
    end);
    local _ = i;
end;

u52 = u52 + 1;
makeSectionHeader("CHARACTER", u52);
u52 = u52 + 1;
local Frame13 = Instance.new("Frame");
Frame13.Size = UDim2.new(1, 0, 0, 30);
Frame13.LayoutOrder = u52;
Frame13.BackgroundTransparency = 1;
Frame13.Parent = ScrollingFrame2;
makeButton(Frame13, "HEAL", 0.5, -3, 0, Color3_fromRGB_ret8, function() -- Line: 620
    -- upvalues: run (copy)
    run("heal");
end);
makeButton(Frame13, "GOD TOGGLE", 0.5, -3, 0.5, Color3.fromRGB(80, 65, 30), function() -- Line: 621
    -- upvalues: run (copy)
    run("god");
end);
u52 = u52 + 1;
makeSectionHeader("MOVE (TP TO / BRING)", u52);
u52 = u52 + 1;
local Frame14 = Instance.new("Frame");
Frame14.Size = UDim2.new(1, 0, 0, 30);
Frame14.LayoutOrder = u52;
Frame14.BackgroundTransparency = 1;
Frame14.Parent = ScrollingFrame2;
Frame14.Size = UDim2.new(1, 0, 0, 32);
local TextBox3 = Instance.new("TextBox");
TextBox3.Size = UDim2.new(0.5, -6, 1, 0);
TextBox3.BackgroundColor3 = Color3_fromRGB_ret4;
TextBox3.BorderSizePixel = 0;
TextBox3.PlaceholderText = "Player name";
TextBox3.Text = "";
TextBox3.Font = Enum.Font.Gotham;
TextBox3.TextSize = 12;
TextBox3.TextColor3 = Color3_fromRGB_ret6;
TextBox3.PlaceholderColor3 = Color3_fromRGB_ret7;
TextBox3.ClearTextOnFocus = false;
TextBox3.Parent = Frame14;
Instance.new("UICorner", TextBox3).CornerRadius = UDim.new(0, 3);
local UIPadding5 = Instance.new("UIPadding");
UIPadding5.PaddingLeft = UDim.new(0, 8);
UIPadding5.Parent = TextBox3;
makeButton(Frame14, "TP TO", 0.25, -3, 0.5, Color3.fromRGB(50, 65, 75), function() -- Line: 638
    -- upvalues: TextBox3 (copy), run (copy)
    if TextBox3.Text ~= "" then
        run("tp", TextBox3.Text);
    end;
end);
makeButton(Frame14, "BRING", 0.25, -3, 0.75, Color3.fromRGB(75, 65, 50), function() -- Line: 641
    -- upvalues: TextBox3 (copy), run (copy)
    if TextBox3.Text ~= "" then
        run("bring", TextBox3.Text);
    end;
end);
u52 = u52 + 1;
makeSectionHeader("TIME OF DAY", u52);
u52 = u52 + 1;
local Frame15 = Instance.new("Frame");
Frame15.Size = UDim2.new(1, 0, 0, 30);
Frame15.LayoutOrder = u52;
Frame15.BackgroundTransparency = 1;
Frame15.Parent = ScrollingFrame2;
makeButton(Frame15, "DAWN 6", 0.25, -3, 0, Color3.fromRGB(72, 62, 42), function() -- Line: 647
    -- upvalues: run (copy)
    run("time", "6");
end);
makeButton(Frame15, "NOON 12", 0.25, -3, 0.25, Color3.fromRGB(78, 72, 46), function() -- Line: 648
    -- upvalues: run (copy)
    run("time", "12");
end);
makeButton(Frame15, "DUSK 19", 0.25, -3, 0.5, Color3.fromRGB(72, 50, 40), function() -- Line: 649
    -- upvalues: run (copy)
    run("time", "19");
end);
makeButton(Frame15, "NIGHT 0", 0.25, -3, 0.75, Color3.fromRGB(40, 46, 66), function() -- Line: 650
    -- upvalues: run (copy)
    run("time", "0");
end);
u52 = u52 + 1;
local Frame16 = Instance.new("Frame");
Frame16.Size = UDim2.new(1, 0, 0, 30);
Frame16.LayoutOrder = u52;
Frame16.BackgroundTransparency = 1;
Frame16.Parent = ScrollingFrame2;
makeButton(Frame16, "PAUSE TIME", 0.5, -3, 0, Color3_fromRGB_ret3, function() -- Line: 652
    -- upvalues: run (copy)
    run("time", "pause");
end);
makeButton(Frame16, "RESUME TIME", 0.5, -3, 0.5, Color3_fromRGB_ret3, function() -- Line: 653
    -- upvalues: run (copy)
    run("time", "resume");
end);
u52 = u52 + 1;
makeSectionHeader("STASH BARTER TIER (wipe-bound)", u52);
u52 = u52 + 1;
local Frame17 = Instance.new("Frame");
Frame17.Size = UDim2.new(1, 0, 0, 30);
Frame17.LayoutOrder = u52;
Frame17.BackgroundTransparency = 1;
Frame17.Parent = ScrollingFrame2;
makeButton(Frame17, "BARTER -1", 0.3333333333333333, -3, 0, Color3_fromRGB_ret3, function() -- Line: 657
    -- upvalues: run (copy)
    run("barter", "-");
end);
makeButton(Frame17, "BARTER +1", 0.3333333333333333, -3, 0.3333333333333333, Color3_fromRGB_ret3, function() -- Line: 658
    -- upvalues: run (copy)
    run("barter", "+");
end);
makeButton(Frame17, "RESET POOL", 0.3333333333333333, -3, 0.6666666666666666, Color3.fromRGB(65, 45, 45), function() -- Line: 659
    -- upvalues: run (copy)
    run("barter", "reset");
end);
u52 = u52 + 1;
makeSectionHeader("TESTING", u52);
u52 = u52 + 1;
local Frame18 = Instance.new("Frame");
Frame18.Size = UDim2.new(1, 0, 0, 30);
Frame18.LayoutOrder = u52;
Frame18.BackgroundTransparency = 1;
Frame18.Parent = ScrollingFrame2;
makeButton(Frame18, "RESET TUTORIAL", 0.3333333333333333, -3, 0, Color3.fromRGB(65, 45, 45), function() -- Line: 663
    -- upvalues: run (copy)
    run("tutorial", "reset");
end);
makeButton(Frame18, "SPAWN FLESH", 0.3333333333333333, -3, 0.3333333333333333, Color3.fromRGB(72, 44, 44), function() -- Line: 664
    -- upvalues: run (copy)
    run("mutant", "Flesh");
end);
makeButton(Frame18, "WHERE AM I", 0.3333333333333333, -3, 0.6666666666666666, Color3.fromRGB(50, 65, 75), function() -- Line: 665
    -- upvalues: run (copy)
    run("where");
end);
u52 = u52 + 1;
local Frame19 = Instance.new("Frame");
Frame19.Size = UDim2.new(1, 0, 0, 30);
Frame19.LayoutOrder = u52;
Frame19.BackgroundTransparency = 1;
Frame19.Parent = ScrollingFrame2;
makeButton(Frame19, "ROLL DAILY", 0.5, -3, 0, Color3.fromRGB(50, 60, 75), function() -- Line: 667
    -- upvalues: run (copy)
    run("daily", "roll");
end);
makeButton(Frame19, "REFIRE DAILY", 0.5, -3, 0.5, Color3.fromRGB(50, 60, 75), function() -- Line: 668
    -- upvalues: run (copy)
    run("daily", "refire");
end);
u52 = u52 + 1;
local Frame20 = Instance.new("Frame");
Frame20.Size = UDim2.new(1, 0, 0, 30);
Frame20.LayoutOrder = u52;
Frame20.BackgroundTransparency = 1;
Frame20.Parent = ScrollingFrame2;
makeButton(Frame20, "TEST SUPPORTER LOG", 0.6, -3, 0, Color3.fromRGB(55, 70, 55), function() -- Line: 670
    -- upvalues: run (copy)
    run("supporterlog", "test");
end);
makeButton(Frame20, "RESET ANNOUNCE", 0.4, -3, 0.6, Color3.fromRGB(65, 45, 45), function() -- Line: 671
    -- upvalues: run (copy)
    run("supporterlog", "reset");
end);
u52 = u52 + 1;
local Frame21 = Instance.new("Frame");
Frame21.Size = UDim2.new(1, 0, 0, 30);
Frame21.LayoutOrder = u52;
Frame21.BackgroundTransparency = 1;
Frame21.Parent = ScrollingFrame2;
makeButton(Frame21, "TEST PDA BROADCAST", 1, -3, 0, Color3.fromRGB(55, 70, 55), function() -- Line: 673
    -- upvalues: run (copy)
    run("pdatest");
end);
local success4, result4 = pcall(function() -- Line: 677
    -- upvalues: ReplicatedStorage (copy), ScrollingFrame2 (copy), nextOrder (copy), Remotes (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret14 (copy)
    local AdminBannerSection = ReplicatedStorage:WaitForChild("AdminBannerSection", 10);

    if not AdminBannerSection then
        error("AdminBannerSection missing");
    end;

    require(AdminBannerSection).Build({
        parent = ScrollingFrame2,
        nextOrder = nextOrder,
        Remotes = Remotes,
        colours = {
            BG_ROW = Color3_fromRGB_ret3,
            BG_INPUT = Color3_fromRGB_ret4,
            TEXT = Color3_fromRGB_ret6,
            TEXT_DIM = Color3_fromRGB_ret7,
            ACCENT_G = Color3_fromRGB_ret8,
            DANGER = Color3_fromRGB_ret14
        }
    });
end);

if not success4 then
    warn("[AdminSpawner] BANNER section failed to build: " .. tostring(result4));
end;

local success5, result5 = pcall(function() -- Line: 691
    -- upvalues: ReplicatedStorage (copy), ScrollingFrame2 (copy), nextOrder (copy), Remotes (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret14 (copy)
    local AdminCinematicSection = ReplicatedStorage:WaitForChild("AdminCinematicSection", 10);

    if not AdminCinematicSection then
        error("AdminCinematicSection missing");
    end;

    require(AdminCinematicSection).Build({
        parent = ScrollingFrame2,
        nextOrder = nextOrder,
        Remotes = Remotes,
        colours = {
            BG_ROW = Color3_fromRGB_ret3,
            BG_INPUT = Color3_fromRGB_ret4,
            TEXT = Color3_fromRGB_ret6,
            TEXT_DIM = Color3_fromRGB_ret7,
            ACCENT_G = Color3_fromRGB_ret8,
            DANGER = Color3_fromRGB_ret14
        }
    });
end);

if not success5 then
    warn("[AdminSpawner] CINEMATIC CAMERA section failed to build: " .. tostring(result5));
end;

u52 = u52 + 1;
makeSectionHeader("CUSTOM (/help for list)", u52);
u52 = u52 + 1;
local Frame22 = Instance.new("Frame");
Frame22.Size = UDim2.new(1, 0, 0, 30);
Frame22.LayoutOrder = u52;
Frame22.BackgroundTransparency = 1;
Frame22.Parent = ScrollingFrame2;
Frame22.Size = UDim2.new(1, 0, 0, 32);
local TextBox4 = Instance.new("TextBox");
TextBox4.Size = UDim2.new(0.7, -6, 1, 0);
TextBox4.BackgroundColor3 = Color3_fromRGB_ret4;
TextBox4.BorderSizePixel = 0;
TextBox4.PlaceholderText = "time speed 60 | barter 4 | mutant Flesh | mapcapture begin | wipe 60";
TextBox4.Text = "";
TextBox4.Font = Enum.Font.Gotham;
TextBox4.TextSize = 12;
TextBox4.TextColor3 = Color3_fromRGB_ret6;
TextBox4.PlaceholderColor3 = Color3_fromRGB_ret7;
TextBox4.ClearTextOnFocus = false;
TextBox4.Parent = Frame22;
Instance.new("UICorner", TextBox4).CornerRadius = UDim.new(0, 3);
local UIPadding6 = Instance.new("UIPadding");
UIPadding6.PaddingLeft = UDim.new(0, 8);
UIPadding6.Parent = TextBox4;
makeButton(Frame22, "RUN", 0.3, -3, 0.7, Color3_fromRGB_ret8, function() -- Line: 718
    -- upvalues: TextBox4 (copy), AdminRunCommand (copy)
    local Text = TextBox4.Text;

    if Text == "" then
        return;
    end;

    if Text:sub(1, 1) == "/" then
        Text = Text:sub(2);
    end;

    local string_split_ret = string.split(Text, " ");
    local v83 = string_split_ret[1];
    table.remove(string_split_ret, 1);
    AdminRunCommand:FireServer(v83, string_split_ret);
end);
local u84 = nil;

if TestingPane then
    local success6, result6 = pcall(function() -- Line: 731
        -- upvalues: TestingPane (copy), Frame3 (copy), run (copy), LocalPlayer (copy), Remotes (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret10 (copy), Color3_fromRGB_ret11 (copy), Color3_fromRGB_ret14 (copy)
        return require(TestingPane).Build({
            content = Frame3,
            run = run,
            player = LocalPlayer,
            Remotes = Remotes,
            colours = {
                BG_DEEP = Color3_fromRGB_ret,
                BG_ROW = Color3_fromRGB_ret3,
                BG_INPUT = Color3_fromRGB_ret4,
                STROKE = Color3_fromRGB_ret5,
                TEXT = Color3_fromRGB_ret6,
                TEXT_DIM = Color3_fromRGB_ret7,
                ACCENT_G = Color3_fromRGB_ret8,
                TAB_ACTIVE = Color3_fromRGB_ret10,
                TAB_TEXT_A = Color3_fromRGB_ret11,
                DANGER = Color3_fromRGB_ret14
            }
        });
    end);

    if success6 then
        u84 = result6;
    else
        warn("[AdminSpawner] TESTING tab failed to build: " .. tostring(result6));
    end;
end;

local u85 = nil;
local success6, result6 = pcall(function() -- Line: 747
    -- upvalues: ReplicatedStorage (copy), Frame3 (copy), LocalPlayer (copy), Remotes (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret10 (copy), Color3_fromRGB_ret11 (copy), Color3_fromRGB_ret14 (copy)
    return require(ReplicatedStorage:WaitForChild("AdminPromoPane")).Build({
        content = Frame3,
        player = LocalPlayer,
        Remotes = Remotes,
        colours = {
            BG_DEEP = Color3_fromRGB_ret,
            BG_ROW = Color3_fromRGB_ret3,
            BG_INPUT = Color3_fromRGB_ret4,
            STROKE = Color3_fromRGB_ret5,
            TEXT = Color3_fromRGB_ret6,
            TEXT_DIM = Color3_fromRGB_ret7,
            ACCENT_G = Color3_fromRGB_ret8,
            TAB_ACTIVE = Color3_fromRGB_ret10,
            TAB_TEXT_A = Color3_fromRGB_ret11,
            DANGER = Color3_fromRGB_ret14
        }
    });
end);

if success6 then
    u85 = result6;
else
    warn("[AdminSpawner] CODES tab failed to build: " .. tostring(result6));
end;

function _G.__admin_setPane(p86) -- Line: 760
    -- upvalues: Frame4 (copy), Frame6 (copy), u84 (ref), u85 (ref)
    Frame4.Visible = p86 == "items";
    Frame6.Visible = p86 == "cmds";

    if u84 then
        u84.Visible = p86 == "testing";
    end;

    if u85 then
        u85.Visible = p86 == "codes";
    end;
end;

TextButton.MouseButton1Click:Connect(function() -- Line: 767
    -- upvalues: Frame (copy)
    Frame.Visible = false;
end);
UserInputService.InputBegan:Connect(function(p87, p88) -- Line: 768
    -- upvalues: Frame (copy)
    if p88 then
        return;
    end;

    if p87.KeyCode == Enum.KeyCode.F8 then
        Frame.Visible = not Frame.Visible;
    end;
end);
local AdminWipeRequest = Remotes:WaitForChild("AdminWipeRequest");
local ScreenGui2 = Instance.new("ScreenGui");
ScreenGui2.Name = "AdminWipePanel";
ScreenGui2.ResetOnSpawn = false;
ScreenGui2.IgnoreGuiInset = true;
ScreenGui2.DisplayOrder = 50;
ScreenGui2.Parent = LocalPlayer:WaitForChild("PlayerGui");
local Frame23 = Instance.new("Frame");
Frame23.Size = UDim2.new(0, 340, 0, 300);
Frame23.Position = UDim2.new(0.5, -170, 0.5, -150);
Frame23.BackgroundColor3 = Color3_fromRGB_ret;
Frame23.BorderSizePixel = 0;
Frame23.Visible = false;
Frame23.Parent = ScreenGui2;
Instance.new("UICorner", Frame23).CornerRadius = UDim.new(0, 6);
local UIStroke2 = Instance.new("UIStroke");
UIStroke2.Color = Color3.fromRGB(150, 50, 50);
UIStroke2.Thickness = 2;
UIStroke2.Parent = Frame23;
local UIPadding7 = Instance.new("UIPadding");
UIPadding7.PaddingTop = UDim.new(0, 12);
UIPadding7.PaddingBottom = UDim.new(0, 12);
UIPadding7.PaddingLeft = UDim.new(0, 12);
UIPadding7.PaddingRight = UDim.new(0, 12);
UIPadding7.Parent = Frame23;
local UIListLayout3 = Instance.new("UIListLayout");
UIListLayout3.Padding = UDim.new(0, 8);
UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout3.Parent = Frame23;

local function wLabel(p89, p90, p91, p92) -- Line: 819
    -- upvalues: Color3_fromRGB_ret7 (copy), Frame23 (copy)
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(1, 0, 0, p92 or 18);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Font = Enum.Font.Code;
    TextLabel2.TextSize = p92 and 14 or 12;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextWrapped = true;
    TextLabel2.TextColor3 = p91 or Color3_fromRGB_ret7;
    TextLabel2.Text = p89;
    TextLabel2.LayoutOrder = p90;
    TextLabel2.Parent = Frame23;

    return TextLabel2;
end;

local function wInput(p93, p94, p95) -- Line: 834
    -- upvalues: Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret6 (copy), Frame23 (copy)
    local TextBox5 = Instance.new("TextBox");
    TextBox5.Size = UDim2.new(1, 0, 0, 30);
    TextBox5.BackgroundColor3 = Color3_fromRGB_ret4;
    TextBox5.BorderSizePixel = 0;
    TextBox5.Font = Enum.Font.Code;
    TextBox5.TextSize = 14;
    TextBox5.TextColor3 = Color3_fromRGB_ret6;
    TextBox5.PlaceholderText = p93;
    TextBox5.Text = "";
    TextBox5.ClearTextOnFocus = false;
    TextBox5.LayoutOrder = p94;
    TextBox5.Parent = Frame23;

    if p95 then
        TextBox5.TextEditable = true;
    end;

    Instance.new("UICorner", TextBox5).CornerRadius = UDim.new(0, 4);

    return TextBox5;
end;

wLabel("GAMEWIDE WIPE", 1, Color3.fromRGB(235, 120, 120), 20);
wLabel(
    "Wipes EVERY player in EVERY server, then kicks them. There is no undo and no cancel once scheduled.",
    2
);
local u96 = wInput("wipe password", 3);
local u97 = wInput("delay in minutes (0 = immediate)", 4);
local u98 = wInput("type WIPE to confirm", 5);
local u99 = wLabel("", 6, Color3.fromRGB(200, 170, 120));
local Frame24 = Instance.new("Frame");
Frame24.Size = UDim2.new(1, 0, 0, 34);
Frame24.BackgroundTransparency = 1;
Frame24.LayoutOrder = 7;
Frame24.Parent = Frame23;
makeButton(Frame24, "CANCEL", 0.5, -3, 0, Color3_fromRGB_ret3, function() -- Line: 865
    -- upvalues: u96 (copy), u97 (copy), u98 (copy), u99 (copy), Frame23 (copy)
    u96.Text = "";
    u97.Text = "";
    u98.Text = "";
    u99.Text = "";
    Frame23.Visible = false;
end);
makeButton(Frame24, "EXECUTE WIPE", 0.5, -3, 0.5, Color3.fromRGB(120, 35, 35), function() -- Line: 870
    -- upvalues: u98 (copy), u99 (copy), u97 (copy), AdminWipeRequest (copy), u96 (copy)
    if u98.Text ~= "WIPE" then
        u99.Text = "Type WIPE (all caps) in the confirm box.";

        return;
    end;

    if not tonumber(u97.Text) then
        u99.Text = "Delay must be a number of minutes.";

        return;
    end;

    u99.Text = "Sent. Watch for the server toast.";
    AdminWipeRequest:FireServer(u96.Text, tonumber(u97.Text), u98.Text);
    u96.Text = "";
    u98.Text = "";
end);
UserInputService.InputBegan:Connect(function(p100, p101) -- Line: 885
    -- upvalues: UserInputService (copy), Frame23 (copy), u96 (copy), u98 (copy), u99 (copy)
    if p101 then
        return;
    end;

    if p100.KeyCode == Enum.KeyCode.F8 and (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) then
        Frame23.Visible = not Frame23.Visible;

        if not Frame23.Visible then
            u96.Text = "";
            u98.Text = "";
            u99.Text = "";
        end;
    end;
end);
print(("[AdminSpawner] Client ready - F8 to toggle (%d items, cmds tab available); Ctrl+Shift+F8 = WIPE panel"):format(#v4));