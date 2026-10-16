-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local ContainerVisibility = require(ReplicatedStorage:WaitForChild("ContainerVisibility"));
local u1 = {};
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Color3_fromRGB_ret = Color3.fromRGB(197, 197, 197);
local Color3_fromRGB_ret2 = Color3.fromRGB(140, 140, 135);
local Color3_fromRGB_ret3 = Color3.fromRGB(22, 24, 21);
local Color3_fromRGB_ret4 = Color3.fromRGB(48, 48, 48);
local Color3_fromRGB_ret5 = Color3.fromRGB(110, 190, 90);
local Color3_fromRGB_ret6 = Color3.fromRGB(30, 32, 29);
local Color3_fromRGB_ret7 = Color3.fromRGB(58, 74, 50);
local Color3_fromRGB_ret8 = Color3.fromRGB(96, 120, 82);
local Vector2_new_ret = Vector2.new(360, 130);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = {};
local u8 = {
    mine = nil,
    theirs = nil
};
local u9 = {
    mine = nil,
    theirs = nil
};
local u10 = nil;
local u11 = "Both players must be ready to complete trade.";
local u12 = nil;
local u13 = false;
local u14 = "offer";
local Color3_fromRGB_ret9 = Color3.fromRGB(58, 61, 56);

local function make(p15, p16, p17) -- Line: 69
    local Instance_new_ret = Instance.new(p15);

    for i, v in pairs(p16) do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p17;

    return Instance_new_ret;
end;

local function outline(p18, p19) -- Line: 76
    -- upvalues: Color3_fromRGB_ret4 (copy)
    local v20 = {
        Thickness = 1,
        Color = p19 or Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in pairs(v20) do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p18;

    return UIStroke;
end;

local function label(p21, p22, p23) -- Line: 80
    -- upvalues: Font_new_ret (copy), Color3_fromRGB_ret (copy)
    local v24 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        Text = p22,
        FontFace = Font_new_ret,
        TextColor3 = Color3_fromRGB_ret,
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in pairs(v24) do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p21;

    for i, v in pairs(p23 or {}) do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function commas(p25) -- Line: 89
    local math_floor_ret = math.floor(p25 or 0);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function bar(p26, p27, p28) -- Line: 95
    -- upvalues: Color3_fromRGB_ret4 (copy), label (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local v29;

    if p27 then
        v29 = p27:Clone();
        v29.Position = UDim2.new();
        local v30 = v29:FindFirstChildWhichIsA("TextLabel");

        if v30 then
            v30.Text = p28;
            v30.Size = UDim2.new(0.6, 0, 0.8, 0);
        end;
    else
        local v31 = {
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(34, 36, 33)
        };
        v29 = Instance.new("Frame");

        for i, v in pairs(v31) do
            v29[i] = v;
        end;

        v29.Parent = nil;
        local v32 = {
            Thickness = 1,
            Color = Color3_fromRGB_ret4,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in pairs(v32) do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = v29;
        label(v29, p28, {
            Size = UDim2.new(0.6, 0, 0.8, 0),
            Position = UDim2.new(0.02, 0, 0.1, 0)
        });
    end;

    v29.Name = "Bar";
    v29.Parent = p26;
    local v33 = label(v29, "NOT READY", {
        Name = "Status",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(0.98, 0, 0.5, 0),
        Size = UDim2.new(0.3, 0, 0.6, 0),
        TextXAlignment = Enum.TextXAlignment.Right,
        TextColor3 = Color3_fromRGB_ret2
    });
    local v34 = {
        Name = "Dot",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(0.68, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 12),
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local Frame = Instance.new("Frame");

    for i, v in pairs(v34) do
        Frame[i] = v;
    end;

    Frame.Parent = v29;
    local v35 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in pairs(v35) do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v36 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret2 or Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in pairs(v36) do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;

    return v29, v33, Frame;
end;

local function setReady(p37, p38, p39) -- Line: 122
    -- upvalues: Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret2 (copy)
    p37.Text = p39 and "READY" or "NOT READY";
    p37.TextColor3 = p39 and Color3_fromRGB_ret5 or Color3_fromRGB_ret2;
    p38.BackgroundTransparency = p39 and 0 or 1;
    p38.BackgroundColor3 = Color3_fromRGB_ret5;
    p38:FindFirstChildWhichIsA("UIStroke").Color = p39 and Color3_fromRGB_ret5 or Color3_fromRGB_ret2;
    p38.Position = UDim2.new(0.98 - (p39 and 0.17 or 0.25), 0, 0.5, 0);
end;

local function roublesRow(p40, p41, u42) -- Line: 133
    -- upvalues: label (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), Font_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), u2 (ref)
    local Frame = Instance.new("Frame");

    for i, v in pairs({
        BackgroundTransparency = 1
    }) do
        Frame[i] = v;
    end;

    Frame.Parent = p40;
    label(Frame, p41, {
        Size = UDim2.new(0.5, 0, 0.55, 0),
        Position = UDim2.new(0, 0, 0.225, 0)
    });
    local v43 = {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0.42, 0, 1, 0),
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local Frame2 = Instance.new("Frame");

    for i, v in pairs(v43) do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v44 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in pairs(v44) do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame2;
    local u45;

    if u42 then
        local v46 = {
            BackgroundTransparency = 1,
            Text = "0",
            PlaceholderText = "0",
            ClearTextOnFocus = false,
            TextScaled = true,
            Position = UDim2.new(0.06, 0, 0.2, 0),
            Size = UDim2.new(0.7, 0, 0.6, 0),
            FontFace = Font_new_ret,
            TextColor3 = Color3_fromRGB_ret,
            TextXAlignment = Enum.TextXAlignment.Left
        };
        u45 = Instance.new("TextBox");

        for i, v in pairs(v46) do
            u45[i] = v;
        end;

        u45.Parent = Frame2;
    else
        u45 = label(Frame2, "0", {
            Position = UDim2.new(0.06, 0, 0.2, 0),
            Size = UDim2.new(0.7, 0, 0.6, 0)
        });
    end;

    local function arrow(p47, p48, u49) -- Line: 151
        -- upvalues: Font_new_ret (ref), u42 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), Frame2 (copy), u45 (ref), u2 (ref)
        local v50 = {
            BackgroundTransparency = 1,
            TextScaled = true,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(0.97, 0, p48, 0),
            Size = UDim2.new(0.14, 0, 0.42, 0),
            Text = p47,
            FontFace = Font_new_ret,
            TextColor3 = u42 and Color3_fromRGB_ret or Color3_fromRGB_ret2,
            AutoButtonColor = u42
        };
        local TextButton = Instance.new("TextButton");

        for i, v in pairs(v50) do
            TextButton[i] = v;
        end;

        TextButton.Parent = Frame2;

        if u42 then
            TextButton.Activated:Connect(function() -- Line: 158
                -- upvalues: u45 (ref), u2 (ref), u49 (copy)
                local v51 = u45.Text:gsub("[^%d]", "");
                local v52 = tonumber(v51) or 0;
                u2.onRoubles((math.max(0, v52 + u49)));
            end);
        end;
    end;

    arrow(utf8.char(9650), 0.06, 1000);
    arrow(utf8.char(9660), 0.52, -1000);

    return Frame, u45;
end;

local function button(p53, p54, p55, p56, p57) -- Line: 169
    -- upvalues: Font_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy)
    local v58 = {
        BorderSizePixel = 0,
        TextScaled = true,
        AutoButtonColor = true,
        Text = p54,
        BackgroundColor3 = p55,
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret
    };
    local TextButton = Instance.new("TextButton");

    for i, v in pairs(v58) do
        TextButton[i] = v;
    end;

    TextButton.Parent = p53;
    local v59 = {
        Thickness = 1,
        Color = p56 or Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in pairs(v59) do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton;
    local v60 = {
        PaddingTop = UDim.new(0.28, 0),
        PaddingBottom = UDim.new(0.28, 0)
    };
    local UIPadding = Instance.new("UIPadding");

    for i, v in pairs(v60) do
        UIPadding[i] = v;
    end;

    UIPadding.Parent = TextButton;
    TextButton.Activated:Connect(p57);

    return TextButton;
end;

local function layout() -- Line: 181
    -- upvalues: u4 (ref), u7 (copy), u9 (copy)
    if not (u4 and u7.myBar) then
        return;
    end;

    local X = u4.AbsoluteSize.X;
    local Y = u4.AbsoluteSize.Y;

    if X <= 0 or Y <= 0 then
        return;
    end;

    local math_floor_ret = math.floor(X * 0.035);
    local u61 = X - math_floor_ret * 2;
    local math_floor_ret2 = math.floor(u61 / 8);
    local v62 = math_floor_ret2 * 8;
    local u63 = math_floor_ret;

    local function place(p64, p65, p66) -- Line: 190
        -- upvalues: math_floor_ret (copy), u63 (ref), u61 (copy), Y (copy)
        p64.Position = UDim2.fromOffset(math_floor_ret, u63);
        p64.Size = UDim2.fromOffset(p66 or u61, p65);
        u63 = u63 + (p65 + math.floor(Y * 0.012));
    end;

    local myBar = u7.myBar;
    local math_floor_ret3 = math.floor(Y * 0.045);
    myBar.Position = UDim2.fromOffset(math_floor_ret, u63);
    myBar.Size = UDim2.fromOffset(u61, math_floor_ret3);
    u63 = u63 + (math_floor_ret3 + math.floor(Y * 0.012));
    local myBox = u7.myBox;
    local v67 = math_floor_ret2 * 4;
    myBox.Position = UDim2.fromOffset(math_floor_ret, u63);
    myBox.Size = UDim2.fromOffset(v62 or u61, v67);
    u63 = u63 + (v67 + math.floor(Y * 0.012));
    local myRow = u7.myRow;
    local math_floor_ret4 = math.floor(Y * 0.05);
    myRow.Position = UDim2.fromOffset(math_floor_ret, u63);
    myRow.Size = UDim2.fromOffset(u61, math_floor_ret4);
    u63 = u63 + (math_floor_ret4 + math.floor(Y * 0.012));
    local theirBar = u7.theirBar;
    local math_floor_ret5 = math.floor(Y * 0.045);
    theirBar.Position = UDim2.fromOffset(math_floor_ret, u63);
    theirBar.Size = UDim2.fromOffset(u61, math_floor_ret5);
    u63 = u63 + (math_floor_ret5 + math.floor(Y * 0.012));
    local theirBox = u7.theirBox;
    local v68 = math_floor_ret2 * 3;
    theirBox.Position = UDim2.fromOffset(math_floor_ret, u63);
    theirBox.Size = UDim2.fromOffset(v62 or u61, v68);
    u63 = u63 + (v68 + math.floor(Y * 0.012));
    local theirRow = u7.theirRow;
    local math_floor_ret6 = math.floor(Y * 0.05);
    theirRow.Position = UDim2.fromOffset(math_floor_ret, u63);
    theirRow.Size = UDim2.fromOffset(u61, math_floor_ret6);
    u63 = u63 + (math_floor_ret6 + math.floor(Y * 0.012));
    local footer = u7.footer;
    local math_floor_ret7 = math.floor(Y * 0.035);
    footer.Position = UDim2.fromOffset(math_floor_ret, u63);
    footer.Size = UDim2.fromOffset(u61, math_floor_ret7);
    u63 = u63 + (math_floor_ret7 + math.floor(Y * 0.012));
    local math_floor_ret8 = math.floor(Y * 0.06);
    local math_floor_ret9 = math.floor((u61 - math_floor_ret) / 2);
    u7.cancel.Position = UDim2.fromOffset(math_floor_ret, u63);
    u7.cancel.Size = UDim2.fromOffset(math_floor_ret9, math_floor_ret8);
    u7.ready.Position = UDim2.fromOffset(math_floor_ret + math_floor_ret9 + math_floor_ret, u63);
    u7.ready.Size = UDim2.fromOffset(u61 - math_floor_ret9 - math_floor_ret, math_floor_ret8);
    u7.cell = math_floor_ret2;
    u9.mine = nil;
    u9.theirs = nil;
end;

local function setTab(p69) -- Line: 217
    -- upvalues: u4 (ref), u5 (ref), u14 (ref), u7 (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret6 (copy), ContainerVisibility (copy), u6 (ref)
    if not (u4 and u5) then
        return;
    end;

    u14 = p69;

    if u7.offerTab then
        u7.offerTab.BackgroundColor3 = p69 == "offer" and Color3_fromRGB_ret9 or Color3_fromRGB_ret6;
        u7.stashTab.BackgroundColor3 = p69 == "stash" and Color3_fromRGB_ret9 or Color3_fromRGB_ret6;
    end;

    if p69 == "stash" then
        u4.Visible = false;
        ContainerVisibility.Show("trade");
        pcall(function() -- Line: 227
            -- upvalues: u6 (ref)
            u6:LoadVicinity();
        end);

        return;
    end;

    pcall(function() -- Line: 229
        -- upvalues: u6 (ref)
        u6:CloseStoragePanel();
    end);
    ContainerVisibility.Hide("trade");
    u4.Visible = true;
end;

local function buildTabs() -- Line: 235
    -- upvalues: u5 (ref), u7 (copy), Color3_fromRGB_ret6 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), setTab (copy)
    local Position = u5.Position;
    local Size = u5.Size;
    local Title = u5:FindFirstChild("Title");
    local v70 = Title and Title.Size.Y.Scale or 0.032;
    local v71 = {
        Name = "TradeTabs",
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 5,
        Position = UDim2.new(Position.X.Scale - Size.X.Scale * u5.AnchorPoint.X + Size.X.Scale * 0.31, 0, Position.Y.Scale - Size.Y.Scale * u5.AnchorPoint.Y + Size.Y.Scale * (Title and (Title.Position.Y.Scale or -0.036) or -0.036), 0),
        Size = UDim2.new(Size.X.Scale * 0.34, 0, Size.Y.Scale * v70, 0)
    };
    local Parent = u5.Parent;
    local Frame = Instance.new("Frame");

    for i, v in pairs(v71) do
        Frame[i] = v;
    end;

    Frame.Parent = Parent;
    u7.tabs = Frame;

    local function tabButton(p72, p73, u74) -- Line: 248
        -- upvalues: Color3_fromRGB_ret6 (ref), Font_new_ret2 (ref), Color3_fromRGB_ret (ref), u7 (ref), Color3_fromRGB_ret4 (ref), setTab (ref)
        local v75 = {
            BorderSizePixel = 0,
            TextScaled = true,
            AutoButtonColor = true,
            ZIndex = 5,
            Text = p72,
            Position = UDim2.new(p73, 0, 0, 0),
            Size = UDim2.new(0.48, 0, 1, 0),
            BackgroundColor3 = Color3_fromRGB_ret6,
            FontFace = Font_new_ret2,
            TextColor3 = Color3_fromRGB_ret
        };
        local tabs = u7.tabs;
        local TextButton = Instance.new("TextButton");

        for i, v in pairs(v75) do
            TextButton[i] = v;
        end;

        TextButton.Parent = tabs;
        local v76 = {
            Thickness = 1,
            Color = Color3_fromRGB_ret4,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in pairs(v76) do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = TextButton;
        local v77 = {
            PaddingTop = UDim.new(0.15, 0),
            PaddingBottom = UDim.new(0.15, 0)
        };
        local UIPadding = Instance.new("UIPadding");

        for i, v in pairs(v77) do
            UIPadding[i] = v;
        end;

        UIPadding.Parent = TextButton;
        TextButton.Activated:Connect(function() -- Line: 256
            -- upvalues: setTab (ref), u74 (copy)
            setTab(u74);
        end);

        return TextButton;
    end;

    u7.offerTab = tabButton("OFFER", 0, "offer");
    u7.stashTab = tabButton("STASH", 0.52, "stash");
end;

local function ensureShell(u78) -- Line: 263
    -- upvalues: u4 (ref), u5 (ref), u7 (copy), label (copy), Color3_fromRGB_ret (copy), bar (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), roublesRow (copy), u2 (ref), Color3_fromRGB_ret2 (copy), Font_new_ret2 (copy), buildTabs (copy), button (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret8 (copy), layout (copy), u1 (copy), u6 (ref)
    if u4 and u4.Parent then
        return true;
    end;

    local v79;

    if u78 then
        v79 = u78:FindFirstChild("MainFrame");
    else
        v79 = u78;
    end;

    if v79 then
        v79 = v79:FindFirstChild("ContainerFrame");
    end;

    u5 = v79;

    if not u5 then
        return false;
    end;

    u4 = u5:Clone();
    u4.Name = "TradeFrame";
    u4.Visible = false;

    for _, child in ipairs(u4:GetChildren()) do
        if not (child:IsA("UIStroke") or (child:IsA("UIGradient") or (child:IsA("UIAspectRatioConstraint") or child.Name == "Title"))) then
            child:Destroy();
        end;
    end;

    local Title = u4:FindFirstChild("Title");
    local v80;

    if Title then
        v80 = Title:FindFirstChildWhichIsA("TextLabel");
    else
        v80 = Title;
    end;

    if v80 then
        v80.Text = "TRADE";
    end;

    u4.Parent = u5.Parent;
    u7.with = label(u4, "TRADING WITH: ", {
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -8, Title and (Title.Position.Y.Scale or -0.036) or -0.036, 0),
        Size = UDim2.new(0.6, 0, Title and Title.Size.Y.Scale or 0.032, 0),
        TextXAlignment = Enum.TextXAlignment.Right,
        TextColor3 = Color3_fromRGB_ret
    });

    if v80 then
        u7.with.FontFace = v80.FontFace;
    end;

    local CrateFrame = u5:FindFirstChild("CrateFrame");

    if CrateFrame then
        CrateFrame = CrateFrame:FindFirstChild("Title");
    end;

    local v81, v82, v83 = bar(u4, CrateFrame, "YOUR OFFER");
    u7.myBar = v81;
    u7.myStatus = v82;
    u7.myDot = v83;
    local v84, v85, v86 = bar(u4, CrateFrame, "THEIR OFFER");
    u7.theirBar = v84;
    u7.theirStatus = v85;
    u7.theirDot = v86;

    local function gridBox() -- Line: 296
        -- upvalues: Color3_fromRGB_ret3 (ref), u4 (ref), Color3_fromRGB_ret4 (ref)
        local v87 = {
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            BackgroundColor3 = Color3_fromRGB_ret3,
            CanvasSize = UDim2.new(),
            ScrollingDirection = Enum.ScrollingDirection.Y
        };
        local ScrollingFrame = Instance.new("ScrollingFrame");

        for i, v in pairs(v87) do
            ScrollingFrame[i] = v;
        end;

        ScrollingFrame.Parent = u4;
        local v88 = {
            Thickness = 1,
            Color = Color3_fromRGB_ret4,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in pairs(v88) do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = ScrollingFrame;

        return ScrollingFrame;
    end;

    u7.myBox = gridBox();
    u7.theirBox = gridBox();
    local v89, v90 = roublesRow(u4, "RUBLES (YOU OFFER)", true);
    u7.myRow = v89;
    u7.roubles = v90;
    local v91, v92 = roublesRow(u4, "RUBLES (THEY OFFER)", false);
    u7.theirRow = v91;
    u7.theirRoubles = v92;
    u7.roubles.FocusLost:Connect(function() -- Line: 309
        -- upvalues: u2 (ref), u7 (ref)
        local onRoubles = u2.onRoubles;
        local v93 = u7.roubles.Text:gsub("[^%d]", "");
        onRoubles(tonumber(v93) or 0);
    end);
    local Frame = Instance.new("Frame");

    for i, v in pairs({
        BackgroundTransparency = 1
    }) do
        Frame[i] = v;
    end;

    Frame.Parent = u4;
    u7.footer = Frame;
    local v94 = {
        Text = "!",
        TextScaled = true,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0.17, 0, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
        BackgroundColor3 = Color3_fromRGB_ret2,
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret3
    };
    local footer = u7.footer;
    local TextLabel = Instance.new("TextLabel");

    for i, v in pairs(v94) do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = footer;
    local v95 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in pairs(v95) do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextLabel;
    u7.footerText = label(u7.footer, "Both players must be ready to complete trade.", {
        Position = UDim2.new(0.17, 22, 0.1, 0),
        Size = UDim2.new(0.8, -22, 0.8, 0),
        TextColor3 = Color3_fromRGB_ret2
    });
    buildTabs();
    u7.cancel = button(u4, "CANCEL", Color3_fromRGB_ret6, Color3_fromRGB_ret4, function() -- Line: 324
        -- upvalues: u2 (ref)
        u2.onCancel();
    end);
    u7.ready = button(u4, "READY", Color3_fromRGB_ret7, Color3_fromRGB_ret8, function() -- Line: 325
        -- upvalues: u2 (ref), u7 (ref)
        u2.onReady(not u7.isReady);
    end);
    u4:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 327
        -- upvalues: layout (ref), u7 (ref), u1 (ref), u78 (copy), u6 (ref)
        layout();

        if u7.lastState then
            u1.Show(u7.lastState, u78, u6);
        end;
    end);
    layout();

    return true;
end;

local function pack(p96) -- Line: 338
    -- upvalues: ItemDatabase (copy)
    local u97 = {};
    local v98 = 1;
    local v99 = {};

    local function free(p100, p101, p102, p103) -- Line: 340
        -- upvalues: u97 (copy)
        for i = p101, p101 + p103 - 1 do
            local v104 = u97[i];
            local v105;

            if v104 then
                v105 = i;

                for i2 = p100, p100 + p102 - 1 do
                    if v104[i2] then
                        return false;
                    end;

                    local _ = i2;
                end;
            else
                v105 = i;
            end;
        end;

        return true;
    end;

    for i, v in ipairs(p96) do
        local ItemData = ItemDatabase.GetItemData(v.item.ID);
        local X = ItemData.Size.X;
        local Y = ItemData.Size.Y;
        local v106 = i;
        local v107 = v;
        local v108 = nil;

        for i2 = 0, 200 do
            local v109 = i2;

            for _, v2 in ipairs({ 0, 1 }) do
                local v110, v111;

                if v2 == 1 then
                    v110 = X;
                    v111 = Y;
                else
                    v110 = Y;
                    v111 = X;
                end;

                if v111 <= 8 then
                    local v112 = v2;

                    for i3 = 0, 8 - v111 do
                        if free(i3, v109, v111, v110) then
                            v108 = {
                                x = i3,
                                y = v109,
                                w = v111,
                                h = v110,
                                rot = v112
                            };
                            break;
                        end;

                        local _ = i3;
                    end;
                end;

                if v108 then
                    break;
                end;
            end;

            if v108 then
                break;
            end;
        end;

        if v108 then
            for i2 = v108.y, v108.y + v108.h - 1 do
                u97[i2] = u97[i2] or {};
                local v113 = i2;

                for i3 = v108.x, v108.x + v108.w - 1 do
                    u97[v113][i3] = true;
                    local _ = i3;
                end;
            end;

            v98 = math.max(v98, v108.y + v108.h);
            local table_clone_ret = table.clone(v107.item);
            table_clone_ret.Position = Vector2.new(v108.x, v108.y);
            table_clone_ret.Rotation = v108.rot;
            v99[v106] = table_clone_ret;
        end;
    end;

    return v99, v98;
end;

local function signature(p114) -- Line: 384
    local v115 = {};

    for _, v in ipairs(p114) do
        local item = v.item;
        local v116 = tostring(v.key);
        local v117 = tostring(v.index);
        local v118 = tostring(item.ID);
        local v119 = tostring(item.CurrentDurability);
        local v120 = tostring(item.CurrentRounds);
        local v121 = tostring(item.Uses);
        table.insert(v115, ("%s#%s#%s#%s#%s#%s"):format(v116, v117, v118, v119, v120, v121));
    end;

    return table.concat(v115, "|");
end;

local function paint(p122, p123, p124) -- Line: 395
    -- upvalues: signature (copy), u7 (copy), u9 (copy), u8 (copy), u6 (ref), pack (copy)
    local v125 = signature(p123) .. "@" .. tostring(u7.cell);

    if u9[p122] == v125 then
        return;
    end;

    u9[p122] = v125;
    local v126 = p122 == "mine" and u7.myBox or u7.theirBox;

    if u8[p122] then
        u6:DestroyTradeGrid(u8[p122]);
        u8[p122] = nil;
    end;

    for _, child in ipairs(v126:GetChildren()) do
        if child.Name == "Holder" then
            child:Destroy();
        end;
    end;

    local v127, v128 = pack(p123);
    local math_max_ret = math.max(v128, p124);
    local v129 = u7.cell or 40;
    v126.CanvasSize = UDim2.fromOffset(0, v129 * math_max_ret);
    local v130 = {
        Name = "Holder",
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(v129, v129)
    };
    local Frame = Instance.new("Frame");

    for i, v in pairs(v130) do
        Frame[i] = v;
    end;

    Frame.Parent = v126;
    local v131 = u6:CreateTradeGrid(Frame, Vector2.new(8, math_max_ret), p122 == "mine");
    u8[p122] = v131;
    u6:LoadInventory(v131, {
        GridSize = Vector2.new(8, math_max_ret),
        Items = v127
    });
end;

function u1.Build(p132) -- Line: 417
    -- upvalues: u2 (ref), u3 (ref), Players (copy), RunService (copy), u10 (ref), u4 (ref), u13 (ref), u7 (copy)
    u2 = p132;
    local v133 = {
        Name = "PlayerTradeGui",
        ResetOnSpawn = false,
        DisplayOrder = 1000,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in pairs(v133) do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = PlayerGui;
    u3 = ScreenGui;
    RunService.RenderStepped:Connect(function() -- Line: 423
        -- upvalues: u10 (ref), u4 (ref), u13 (ref), u7 (ref)
        if u10 and (u4 and u13) then
            local v134 = u10 - os.clock();
            local math_ceil_ret = math.ceil(v134);
            u7.footerText.Text = math_ceil_ret > 0 and "Trading in " .. math_ceil_ret .. "..." or "Trading...";
        end;
    end);
end;

function u1.Show(p135, p136, p137) -- Line: 431
    -- upvalues: u6 (ref), ensureShell (copy), u7 (copy), u13 (ref), layout (copy), u4 (ref), u5 (ref), u14 (ref), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret6 (copy), ContainerVisibility (copy), paint (copy), setReady (copy), u10 (ref), u11 (ref)
    u6 = p137;

    if not ensureShell(p136) then
        return;
    end;

    u7.lastState = p135;

    if not u13 then
        u13 = true;
        layout();

        if u4 and u5 then
            u14 = "offer";

            if u7.offerTab then
                u7.offerTab.BackgroundColor3 = Color3_fromRGB_ret9 or Color3_fromRGB_ret6;
                u7.stashTab.BackgroundColor3 = Color3_fromRGB_ret6;
            end;

            pcall(function() -- Line: 229
                -- upvalues: u6 (ref)
                u6:CloseStoragePanel();
            end);
            ContainerVisibility.Hide("trade");
            u4.Visible = true;
        end;
    end;

    u7.tabs.Visible = p135.stash == true;

    if u14 == "stash" and (not p135.stash and (u4 and u5)) then
        u14 = "offer";

        if u7.offerTab then
            u7.offerTab.BackgroundColor3 = Color3_fromRGB_ret9 or Color3_fromRGB_ret6;
            u7.stashTab.BackgroundColor3 = Color3_fromRGB_ret6;
        end;

        pcall(function() -- Line: 229
            -- upvalues: u6 (ref)
            u6:CloseStoragePanel();
        end);
        ContainerVisibility.Hide("trade");
        u4.Visible = true;
    end;

    u7.with.Text = "TRADING WITH: " .. string.upper(p135.partner or "");
    paint("mine", p135.mine.items, 4);
    paint("theirs", p135.theirs.items, 3);

    if not u7.roubles:IsFocused() then
        u7.roubles.Text = tostring(p135.mine.roubles);
    end;

    local theirRoubles = u7.theirRoubles;
    local math_floor_ret = math.floor(p135.theirs.roubles or 0);
    theirRoubles.Text = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    setReady(u7.myStatus, u7.myDot, p135.mine.ready);
    setReady(u7.theirStatus, u7.theirDot, p135.theirs.ready);
    u7.isReady = p135.mine.ready;
    u7.ready.Text = p135.mine.ready and "UNREADY" or "READY";
    local v138;

    if p135.countdown then
        v138 = os.clock() + p135.countdown or nil;
    else
        v138 = nil;
    end;

    u10 = v138;
    u11 = p135.note or "Both players must be ready to complete trade.";

    if not u10 then
        u7.footerText.Text = u11;
    end;
end;

function u1.Hide() -- Line: 457
    -- upvalues: u10 (ref), u7 (copy), u8 (copy), u6 (ref), u9 (copy), u13 (ref), u14 (ref), u4 (ref), ContainerVisibility (copy)
    u10 = nil;
    u7.lastState = nil;

    for i, v in pairs(u8) do
        if v and u6 then
            u6:DestroyTradeGrid(v);
        end;

        u8[i] = nil;
    end;

    u9.mine = nil;
    u9.theirs = nil;
    u13 = false;
    u14 = "offer";

    if u7.tabs then
        u7.tabs.Visible = false;
    end;

    if u4 then
        u4.Visible = false;
    end;

    ContainerVisibility.Show("trade");
end;

function u1.ShowRequest(p139, p140, u141) -- Line: 476
    -- upvalues: u12 (ref), Vector2_new_ret (copy), u3 (ref), Color3_fromRGB_ret4 (copy), label (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), button (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret8 (copy), UserInputService (copy)
    if u12 then
        u12(nil);
    end;

    local v142 = {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0.1, 0),
        Size = UDim2.fromOffset(Vector2_new_ret.X, Vector2_new_ret.Y),
        BackgroundColor3 = Color3.fromRGB(25, 27, 24)
    };
    local Frame = Instance.new("Frame");

    for i, v in pairs(v142) do
        Frame[i] = v;
    end;

    Frame.Parent = u3;
    local v143 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in pairs(v143) do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    label(Frame, "TRADE REQUEST", {
        Position = UDim2.new(0, 14, 0, 10),
        Size = UDim2.new(1, -28, 0, 18),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret2
    });
    label(Frame, p139 .. " wants to trade", {
        Position = UDim2.new(0, 14, 0, 32),
        Size = UDim2.new(1, -28, 0, 24)
    });
    local u144 = label(Frame, "", {
        Position = UDim2.new(0, 14, 0, 58),
        Size = UDim2.new(1, -28, 0, 14),
        TextColor3 = Color3_fromRGB_ret2
    });
    local u145 = false;
    local u146 = nil;

    local function finish(p147) -- Line: 492
        -- upvalues: u145 (ref), u146 (ref), u12 (ref), finish (copy), Frame (copy), u141 (copy)
        if u145 then
            return;
        end;

        u145 = true;

        if u146 then
            u146:Disconnect();
        end;

        if u12 == finish then
            u12 = nil;
        end;

        Frame:Destroy();

        if p147 ~= nil then
            u141(p147);
        end;
    end;

    u12 = finish;
    local v148 = button(Frame, "DECLINE [N]", Color3_fromRGB_ret6, Color3_fromRGB_ret4, function() -- Line: 501
        -- upvalues: u145 (ref), u146 (ref), u12 (ref), finish (copy), Frame (copy), u141 (copy)
        if u145 then
            return;
        end;

        u145 = true;

        if u146 then
            u146:Disconnect();
        end;

        if u12 == finish then
            u12 = nil;
        end;

        Frame:Destroy();
        u141(false);
    end);
    v148.Position = UDim2.new(0, 14, 1, -46);
    v148.Size = UDim2.new(0.5, -21, 0, 34);
    local v149 = button(Frame, "ACCEPT [U]", Color3_fromRGB_ret7, Color3_fromRGB_ret8, function() -- Line: 504
        -- upvalues: u145 (ref), u146 (ref), u12 (ref), finish (copy), Frame (copy), u141 (copy)
        if u145 then
            return;
        end;

        u145 = true;

        if u146 then
            u146:Disconnect();
        end;

        if u12 == finish then
            u12 = nil;
        end;

        Frame:Destroy();
        u141(true);
    end);
    v149.Position = UDim2.new(0.5, 7, 1, -46);
    v149.Size = UDim2.new(0.5, -21, 0, 34);
    u146 = UserInputService.InputBegan:Connect(function(p150, p151) -- Line: 507
        -- upvalues: u145 (ref), u146 (ref), u12 (ref), finish (copy), Frame (copy), u141 (copy)
        if p151 then
            return;
        end;

        if p150.KeyCode ~= Enum.KeyCode.U then
            if p150.KeyCode == Enum.KeyCode.N then
                if u145 then
                    return;
                end;

                u145 = true;

                if u146 then
                    u146:Disconnect();
                end;

                if u12 == finish then
                    u12 = nil;
                end;

                Frame:Destroy();
                u141(false);
            end;

            return;
        end;

        if u145 then
            return;
        end;

        u145 = true;

        if u146 then
            u146:Disconnect();
        end;

        if u12 == finish then
            u12 = nil;
        end;

        Frame:Destroy();
        u141(true);
    end);
    local u152 = os.clock() + p140;
    task.spawn(function() -- Line: 515
        -- upvalues: u145 (ref), u152 (copy), finish (copy), u144 (copy)
        while not u145 do
            local v153 = u152 - os.clock();
            local math_ceil_ret = math.ceil(v153);

            if math_ceil_ret <= 0 then
                return finish(nil);
            end;

            u144.Text = ("Expires in %ds"):format(math_ceil_ret);
            task.wait(0.25);
        end;
    end);
end;

return u1;