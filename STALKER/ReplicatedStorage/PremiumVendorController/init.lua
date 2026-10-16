-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local SkinCatalog = require(ReplicatedStorage:WaitForChild("SkinCatalog"));
local VendorCatalog = require(ReplicatedStorage:WaitForChild("VendorCatalog"));
local RegionalPrices = require(ReplicatedStorage:WaitForChild("RegionalPrices"));
local VendorPreview = require(script:WaitForChild("VendorPreview"));
local GiftPicker = script:WaitForChild("GiftPicker", 5);
local u1 = GiftPicker and require(GiftPicker) or nil;

if not u1 then
    warn("[PremiumVendor] GiftPicker is missing from this place; GIFT is hidden. Re-sync and republish.");
end;

local ToastUI = require(ReplicatedStorage:WaitForChild("ToastUI"));
local LocalPlayer = Players.LocalPlayer;
local v2 = {
    IsOpen = false,
    CurrentNPC = nil,
    CurrentTab = VendorCatalog.TABS[1].id,
    SelectedProductID = nil,
    Products = {},
    Featured = nil,
    _tiles = {},
    _tabs = {}
};
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Color3_fromRGB_ret = Color3.fromRGB(10, 11, 10);
local Color3_fromRGB_ret2 = Color3.fromRGB(25, 27, 24);
local Color3_fromRGB_ret3 = Color3.fromRGB(22, 24, 21);
local Color3_fromRGB_ret4 = Color3.fromRGB(48, 48, 48);
local Color3_fromRGB_ret5 = Color3.fromRGB(197, 197, 197);
local Color3_fromRGB_ret6 = Color3.fromRGB(140, 140, 135);
local Color3_fromRGB_ret7 = Color3.fromRGB(215, 175, 75);
local Color3_fromRGB_ret8 = Color3.fromRGB(42, 38, 24);
local Color3_fromRGB_ret9 = Color3.fromRGB(110, 190, 90);
local Color3_fromRGB_ret10 = Color3.fromRGB(58, 74, 50);
local Color3_fromRGB_ret11 = Color3.fromRGB(96, 120, 82);
local Color3_fromRGB_ret12 = Color3.fromRGB(44, 47, 42);
local Color3_fromRGB_ret13 = Color3.fromRGB(29, 31, 28);
local Vector2_new_ret = Vector2.new(1080, 640);

local function label(p3, p4, p5) -- Line: 93
    -- upvalues: Font_new_ret (copy), Color3_fromRGB_ret5 (copy)
    local v6 = {
        BackgroundTransparency = 1,
        TextSize = 13,
        Text = p4,
        FontFace = Font_new_ret,
        TextColor3 = Color3_fromRGB_ret5,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in pairs(v6) do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p3;

    for i, v in pairs(p5 or {}) do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function gradientBar(p7, p8, p9) -- Line: 103
    -- upvalues: Color3_fromRGB_ret12 (copy), Color3_fromRGB_ret13 (copy), Color3_fromRGB_ret4 (copy), label (copy), Font_new_ret2 (copy)
    local v10 = {
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in pairs(v10) do
        Frame[i] = v;
    end;

    Frame.Parent = p7;
    local v11 = {
        Color = ColorSequence.new(Color3_fromRGB_ret12, Color3_fromRGB_ret13)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in pairs(v11) do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v12 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in pairs(v12) do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v13 = label(Frame, p8, {
        TextSize = 13,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -20, 1, 0),
        FontFace = Font_new_ret2
    });

    for i, v in pairs(p9 or {}) do
        Frame[i] = v;
    end;

    return Frame, v13;
end;

local u20 = {
    FONT = Font_new_ret,
    FONT_BOLD = Font_new_ret2,
    PANEL = Color3_fromRGB_ret2,
    BOX = Color3_fromRGB_ret3,
    STROKE = Color3_fromRGB_ret4,
    TEXT = Color3_fromRGB_ret5,
    DIM = Color3_fromRGB_ret6,
    GOLD = Color3_fromRGB_ret7,
    GREEN = Color3_fromRGB_ret9,
    BUY_BG = Color3_fromRGB_ret10,
    BUY_STROKE = Color3_fromRGB_ret11,

    make = function(p14, p15, p16) -- Line: 82, Name: make
        local Instance_new_ret = Instance.new(p14);

        for i, v in pairs(p15) do
            Instance_new_ret[i] = v;
        end;

        Instance_new_ret.Parent = p16;

        return Instance_new_ret;
    end,

    outline = function(p17, p18) -- Line: 89, Name: outline
        -- upvalues: Color3_fromRGB_ret4 (copy)
        local v19 = {
            Thickness = 1,
            Color = p18 or Color3_fromRGB_ret4,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in pairs(v19) do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = p17;

        return UIStroke;
    end,

    label = label,
    gradientBar = gradientBar
};

local function priceText(p21) -- Line: 119
    -- upvalues: Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret6 (copy), RegionalPrices (copy), Color3_fromRGB_ret7 (copy)
    if p21.isOwned then
        return p21.ownedLabel or "OWNED", false, Color3_fromRGB_ret9;
    end;

    if p21.blocked then
        return p21.blocked, false, Color3_fromRGB_ret6;
    end;

    local v22, v23 = RegionalPrices.Label(RegionalPrices.Get(p21.kind, p21.robloxId));

    return v22, v23, Color3_fromRGB_ret7;
end;

local function giftPriceText(p24) -- Line: 129
    -- upvalues: RegionalPrices (copy)
    return RegionalPrices.Label(RegionalPrices.Get("product", p24.giftId));
end;

local function build() -- Line: 135
    -- upvalues: LocalPlayer (copy), Color3_fromRGB_ret (copy), Vector2_new_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret4 (copy), gradientBar (copy), label (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret7 (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local ScreenGui = Instance.new("ScreenGui");
    local v25 = {};

    for i, v in pairs({
        Name = "PremiumVendorGui",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 20,
        Enabled = false
    }) do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = PlayerGui;
    v25.gui = ScreenGui;
    local v26 = {
        Name = "Shade",
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local gui = v25.gui;
    local Frame = Instance.new("Frame");

    for i, v in pairs(v26) do
        Frame[i] = v;
    end;

    Frame.Parent = gui;
    local v27 = {
        Name = "Panel",
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(Vector2_new_ret.X, Vector2_new_ret.Y),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local gui2 = v25.gui;
    local Frame2 = Instance.new("Frame");

    for i, v in pairs(v27) do
        Frame2[i] = v;
    end;

    Frame2.Parent = gui2;
    local v28 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in pairs(v28) do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame2;
    v25.panel = Frame2;
    local UIScale = Instance.new("UIScale");

    for i, v in pairs({}) do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame2;

    local function fit() -- Line: 147
        -- upvalues: UIScale (copy), Vector2_new_ret (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v29 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1920, 1080);
        UIScale.Scale = math.min(v29.X * 0.88 / Vector2_new_ret.X, v29.Y * 0.88 / Vector2_new_ret.Y);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v30 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1920, 1080);
    UIScale.Scale = math.min(v30.X * 0.88 / Vector2_new_ret.X, v30.Y * 0.88 / Vector2_new_ret.Y);

    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit);
    end;

    local v31, v32 = gradientBar(Frame2, "PREMIUM VENDOR", {
        Size = UDim2.new(1, 0, 0, 44)
    });
    v32.TextSize = 16;
    v25.npcLbl = label(v31, "", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.new(0.4, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextColor3 = Color3_fromRGB_ret6
    });
    local v33 = {
        BorderSizePixel = 0,
        Text = "Q  CLOSE",
        TextSize = 12,
        AutoButtonColor = true,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.fromOffset(110, 26),
        BackgroundColor3 = Color3_fromRGB_ret3,
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret6
    };
    local TextButton = Instance.new("TextButton");

    for i, v in pairs(v33) do
        TextButton[i] = v;
    end;

    TextButton.Parent = v31;
    v25.closeBtn = TextButton;
    local closeBtn = v25.closeBtn;
    local v34 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in pairs(v34) do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = closeBtn;
    local v35 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.new(1, 0, 0, 28)
    };
    local Frame3 = Instance.new("Frame");

    for i, v in pairs(v35) do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    local v36 = {
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Color3_fromRGB_ret4
    };
    local Frame4 = Instance.new("Frame");

    for i, v in pairs(v36) do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame3;
    label(Frame3, "Purchases stay through wipes. Prices are shown for your region.", {
        TextSize = 12,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -24, 1, 0),
        TextColor3 = Color3_fromRGB_ret6
    });
    local v37 = {
        Name = "Left",
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 44),
        Size = UDim2.new(1, -310, 1, -72)
    };
    local Frame5 = Instance.new("Frame");

    for i, v in pairs(v37) do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame2;
    local v38 = {
        PaddingTop = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12)
    };
    local UIPadding = Instance.new("UIPadding");

    for i, v in pairs(v38) do
        UIPadding[i] = v;
    end;

    UIPadding.Parent = Frame5;
    local v39 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8)
    };
    local UIListLayout = Instance.new("UIListLayout");

    for i, v in pairs(v39) do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = Frame5;
    local v40 = {
        Name = "Banner",
        LayoutOrder = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Visible = false,
        Size = UDim2.new(1, 0, 0, 160),
        BackgroundColor3 = Color3_fromRGB_ret8
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in pairs(v40) do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame5;
    v25.banner = TextButton2;
    local banner = v25.banner;
    local v41 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret7 or Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in pairs(v41) do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = banner;
    local v42 = {
        Name = "Art",
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Size = UDim2.new(0.5, 0, 1, 0)
    };
    local banner2 = v25.banner;
    local Frame6 = Instance.new("Frame");

    for i, v in pairs(v42) do
        Frame6[i] = v;
    end;

    Frame6.Parent = banner2;
    v25.bannerArt = Frame6;
    local v43 = label(v25.banner, "FEATURED", {
        BackgroundTransparency = 0,
        TextSize = 11,
        Position = UDim2.new(0.52, 0, 0, 14),
        Size = UDim2.fromOffset(84, 18),
        BackgroundColor3 = Color3_fromRGB_ret8,
        TextColor3 = Color3_fromRGB_ret7,
        FontFace = Font_new_ret2,
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local v44 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret7 or Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in pairs(v44) do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = v43;
    v25.bannerName = label(v25.banner, "", {
        TextSize = 22,
        Position = UDim2.new(0.52, 0, 0, 38),
        Size = UDim2.new(0.46, 0, 0, 28),
        FontFace = Font_new_ret2
    });
    v25.bannerBlurb = label(v25.banner, "", {
        TextSize = 13,
        TextWrapped = true,
        Position = UDim2.new(0.52, 0, 0, 70),
        Size = UDim2.new(0.46, 0, 0, 44),
        TextColor3 = Color3_fromRGB_ret6,
        TextTruncate = Enum.TextTruncate.None,
        TextYAlignment = Enum.TextYAlignment.Top
    });
    v25.bannerPrice = label(v25.banner, "", {
        TextSize = 18,
        Position = UDim2.new(0.52, 0, 1, -36),
        Size = UDim2.new(0.46, 0, 0, 24),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret7
    });
    local v45 = {
        Name = "Tabs",
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 30)
    };
    local Frame7 = Instance.new("Frame");

    for i, v in pairs(v45) do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame5;
    v25.tabsRow = Frame7;
    local v46 = {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local tabsRow = v25.tabsRow;
    local UIListLayout2 = Instance.new("UIListLayout");

    for i, v in pairs(v46) do
        UIListLayout2[i] = v;
    end;

    UIListLayout2.Parent = tabsRow;
    local v47 = {
        Name = "Grid",
        LayoutOrder = 3,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        Size = UDim2.new(1, 0, 1, -38),
        ScrollBarImageColor3 = Color3_fromRGB_ret4,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    };
    local ScrollingFrame = Instance.new("ScrollingFrame");

    for i, v in pairs(v47) do
        ScrollingFrame[i] = v;
    end;

    ScrollingFrame.Parent = Frame5;
    v25.grid = ScrollingFrame;
    local v48 = {
        PaddingRight = UDim.new(0, 6)
    };
    local grid = v25.grid;
    local UIPadding2 = Instance.new("UIPadding");

    for i, v in pairs(v48) do
        UIPadding2[i] = v;
    end;

    UIPadding2.Parent = grid;
    local v49 = {
        CellSize = UDim2.new(0.3333333333333333, -6, 0, 150),
        CellPadding = UDim2.fromOffset(8, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local grid2 = v25.grid;
    local UIGridLayout = Instance.new("UIGridLayout");

    for i, v in pairs(v49) do
        UIGridLayout[i] = v;
    end;

    UIGridLayout.Parent = grid2;
    local v50 = {
        Name = "Detail",
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 44),
        Size = UDim2.new(0, 310, 1, -72),
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local Frame8 = Instance.new("Frame");

    for i, v in pairs(v50) do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame2;
    v25.detail = Frame8;
    local v51 = {
        Name = "Edge",
        BorderSizePixel = 0,
        Size = UDim2.new(0, 1, 1, 0),
        BackgroundColor3 = Color3_fromRGB_ret4
    };
    local detail = v25.detail;
    local Frame9 = Instance.new("Frame");

    for i, v in pairs(v51) do
        Frame9[i] = v;
    end;

    Frame9.Parent = detail;

    return v25;
end;

local function makeTile(p52, p53, u54, p55, u56) -- Line: 220
    -- upvalues: Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret2 (copy), VendorPreview (copy), ItemDatabase (copy), label (copy), Color3_fromRGB_ret8 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret6 (copy), RegionalPrices (copy)
    local v57 = {
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Name = "Tile_" .. u54.id,
        LayoutOrder = p53,
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local TextButton = Instance.new("TextButton");

    for i, v in pairs(v57) do
        TextButton[i] = v;
    end;

    TextButton.Parent = p52;
    local v58 = {
        Thickness = 1,
        Color = p55 and Color3_fromRGB_ret7 or Color3_fromRGB_ret4 or Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in pairs(v58) do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton;
    local v59 = {
        Name = "Art",
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.fromOffset(1, 1),
        Size = UDim2.new(1, -2, 1, -34),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame = Instance.new("Frame");

    for i, v in pairs(v59) do
        Frame[i] = v;
    end;

    Frame.Parent = TextButton;
    VendorPreview.Mount(Frame, u54, ItemDatabase);

    if u54.chip then
        local v60 = label(TextButton, u54.chip, {
            BackgroundTransparency = 0,
            TextSize = 11,
            ZIndex = 3,
            Position = UDim2.fromOffset(6, 6),
            Size = UDim2.fromOffset(72, 16),
            BackgroundColor3 = Color3_fromRGB_ret8,
            TextColor3 = Color3_fromRGB_ret7,
            FontFace = Font_new_ret2,
            TextXAlignment = Enum.TextXAlignment.Center
        });
        local v61 = {
            Thickness = 1,
            Color = Color3_fromRGB_ret7 or Color3_fromRGB_ret4,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke2 = Instance.new("UIStroke");

        for i, v in pairs(v61) do
            UIStroke2[i] = v;
        end;

        UIStroke2.Parent = v60;
    end;

    local v62 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.new(1, 0, 0, 32)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in pairs(v62) do
        Frame2[i] = v;
    end;

    Frame2.Parent = TextButton;
    local v63 = {
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Color3_fromRGB_ret4
    };
    local Frame3 = Instance.new("Frame");

    for i, v in pairs(v63) do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    label(Frame2, string.upper(u54.name), {
        TextSize = 12,
        Position = UDim2.fromOffset(8, 0),
        Size = UDim2.new(0.62, -8, 1, 0),
        FontFace = Font_new_ret2
    });
    local v64, v65;

    if u54.isOwned then
        v64 = u54.ownedLabel or "OWNED";
        v65 = Color3_fromRGB_ret9;
    elseif u54.blocked then
        v64 = u54.blocked;
        v65 = Color3_fromRGB_ret6;
    else
        local v66;
        v64, v66 = RegionalPrices.Label(RegionalPrices.Get(u54.kind, u54.robloxId));
        v65 = Color3_fromRGB_ret7;
    end;

    local v67 = label(Frame2, v64, {
        TextSize = 13,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -8, 0, 0),
        Size = UDim2.new(0.38, -8, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right,
        FontFace = Font_new_ret2,
        TextColor3 = v65
    });
    TextButton.Activated:Connect(function() -- Line: 241
        -- upvalues: u56 (copy), u54 (copy)
        u56(u54.id);
    end);

    return {
        tile = TextButton,
        stroke = UIStroke,
        price = v67
    };
end;

local function freezeInput() -- Line: 247
    -- upvalues: LocalPlayer (copy), UserInputService (copy), RunService (copy)
    local success, result = pcall(function() -- Line: 248
        -- upvalues: LocalPlayer (ref)
        return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"));
    end);

    if success and (result and result.GetControls) then
        local Controls = result:GetControls();

        if Controls and Controls.Disable then
            Controls:Disable();
        end;
    end;

    UserInputService.MouseIconEnabled = true;
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    pcall(function() -- Line: 257
        -- upvalues: RunService (ref), UserInputService (ref)
        RunService:BindToRenderStep("PremiumVendorMouseKeeper", Enum.RenderPriority.Camera.Value + 100, function() -- Line: 258
            -- upvalues: UserInputService (ref)
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            end;

            if not UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = true;
            end;
        end);
    end);
end;

local function unfreezeInput() -- Line: 268
    -- upvalues: RunService (copy), LocalPlayer (copy)
    pcall(function() -- Line: 269
        -- upvalues: RunService (ref)
        RunService:UnbindFromRenderStep("PremiumVendorMouseKeeper");
    end);
    local success, result = pcall(function() -- Line: 270
        -- upvalues: LocalPlayer (ref)
        return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"));
    end);

    if success and (result and result.GetControls) then
        local Controls = result:GetControls();

        if Controls and Controls.Enable then
            Controls:Enable();
        end;
    end;
end;

function v2._product(p68, p69) -- Line: 281
    for _, v in ipairs(p68.Products) do
        if v.id == p69 then
            return v;
        end;
    end;

    return nil;
end;

function v2._paintTabs(p70) -- Line: 288
    -- upvalues: Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret4 (copy)
    for i, v in pairs(p70._tabs) do
        local v71 = i == p70.CurrentTab;
        v.button.BackgroundColor3 = v71 and Color3_fromRGB_ret8 or Color3_fromRGB_ret3;
        v.button.TextColor3 = v71 and Color3_fromRGB_ret7 or Color3_fromRGB_ret6;
        v.stroke.Color = v71 and Color3_fromRGB_ret7 or Color3_fromRGB_ret4;
    end;
end;

function v2._paintSelection(p72) -- Line: 297
    -- upvalues: Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret4 (copy)
    for i, v in pairs(p72._tiles) do
        v.stroke.Color = i == p72.SelectedProductID and Color3_fromRGB_ret7 or Color3_fromRGB_ret4;
    end;
end;

function v2._paintBuy(p73) -- Line: 303
    -- upvalues: RegionalPrices (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret10 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret11 (copy)
    local _buyBtn = p73._buyBtn;
    local _buyFor = p73._buyFor;

    if not (_buyBtn and (_buyBtn.Parent and _buyFor)) then
        return;
    end;

    local v74, v75;

    if _buyFor.isOwned then
        v74 = _buyFor.ownedLabel or "OWNED";
        v75 = false;
    elseif _buyFor.blocked then
        v74 = _buyFor.blocked;
        v75 = false;
    else
        v74, v75 = RegionalPrices.Label(RegionalPrices.Get(_buyFor.kind, _buyFor.robloxId));
    end;

    if _buyFor.isOwned then
        _buyBtn.Text = v74;
        _buyBtn.BackgroundColor3 = Color3_fromRGB_ret3;
        _buyBtn.TextColor3 = Color3_fromRGB_ret9;
        _buyBtn.AutoButtonColor = false;
        p73._buyStroke.Color = Color3_fromRGB_ret9;
    elseif v75 then
        _buyBtn.Text = (v74 == "" or v74 == "...") and "PURCHASE" or ("PURCHASE   " .. v74 or "PURCHASE");
        _buyBtn.BackgroundColor3 = Color3_fromRGB_ret10;
        _buyBtn.TextColor3 = Color3_fromRGB_ret5;
        _buyBtn.AutoButtonColor = true;
        p73._buyStroke.Color = Color3_fromRGB_ret11;
    else
        _buyBtn.Text = v74;
        _buyBtn.BackgroundColor3 = Color3_fromRGB_ret3;
        _buyBtn.TextColor3 = Color3_fromRGB_ret6;
        _buyBtn.AutoButtonColor = false;
        p73._buyStroke.Color = Color3_fromRGB_ret4;
    end;

    local _giftBtn = p73._giftBtn;

    if _giftBtn and (_giftBtn.Parent and _buyFor.giftId ~= 0) then
        local v76 = RegionalPrices.Label(RegionalPrices.Get("product", _buyFor.giftId));
        _giftBtn.Text = (v76 == "" or v76 == "...") and "GIFT" or ("GIFT   " .. v76 or "GIFT");
    end;
end;

function v2._paintBannerPrice(p77) -- Line: 325
    -- upvalues: Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret6 (copy), RegionalPrices (copy), Color3_fromRGB_ret7 (copy)
    local Featured = p77.Featured;

    if not (Featured and p77.UI) then
        return;
    end;

    local v78, v79;

    if Featured.isOwned then
        v78 = Featured.ownedLabel or "OWNED";
        v79 = Color3_fromRGB_ret9;
    elseif Featured.blocked then
        v78 = Featured.blocked;
        v79 = Color3_fromRGB_ret6;
    else
        local v80;
        v78, v80 = RegionalPrices.Label(RegionalPrices.Get(Featured.kind, Featured.robloxId));
        v79 = Color3_fromRGB_ret7;
    end;

    p77.UI.bannerPrice.Text = v78;
    p77.UI.bannerPrice.TextColor3 = v79;
end;

function v2._paintPrices(p81) -- Line: 334
    -- upvalues: Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret6 (copy), RegionalPrices (copy), Color3_fromRGB_ret7 (copy)
    if not p81.IsOpen then
        return;
    end;

    for i, v in pairs(p81._tiles) do
        local v82 = p81:_product(i);

        if v82 and v.price.Parent then
            local v83, v84;

            if v82.isOwned then
                v83 = v82.ownedLabel or "OWNED";
                v84 = Color3_fromRGB_ret9;
            elseif v82.blocked then
                v83 = v82.blocked;
                v84 = Color3_fromRGB_ret6;
            else
                local v85;
                v83, v85 = RegionalPrices.Label(RegionalPrices.Get(v82.kind, v82.robloxId));
                v84 = Color3_fromRGB_ret7;
            end;

            local price = v.price;
            v.price.Text = v83;
            price.TextColor3 = v84;
        end;
    end;

    p81:_paintBannerPrice();
    p81:_paintBuy();
end;

function v2._renderDetail(u86) -- Line: 347
    -- upvalues: label (copy), Color3_fromRGB_ret6 (copy), Font_new_ret2 (copy), gradientBar (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret4 (copy), VendorPreview (copy), ItemDatabase (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret5 (copy), u1 (copy), Color3_fromRGB_ret8 (copy), u20 (copy)
    local detail = u86.UI.detail;

    for _, child in ipairs(detail:GetChildren()) do
        if child.Name ~= "Edge" then
            child:Destroy();
        end;
    end;

    u86._buyBtn = nil;
    u86._buyStroke = nil;
    u86._buyFor = nil;
    local u87 = u86:_product(u86.SelectedProductID);

    if not u87 then
        label(detail, "SELECT AN ITEM", {
            Size = UDim2.fromScale(1, 1),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextColor3 = Color3_fromRGB_ret6,
            FontFace = Font_new_ret2
        });

        return;
    end;

    gradientBar(detail, string.upper(u87.name), {
        Position = UDim2.fromOffset(12, 12),
        Size = UDim2.new(1, -24, 0, 30)
    });
    local v88 = {
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.fromOffset(12, 50),
        Size = UDim2.new(1, -24, 0, 190),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame = Instance.new("Frame");

    for i, v in pairs(v88) do
        Frame[i] = v;
    end;

    Frame.Parent = detail;
    local v89 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in pairs(v89) do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    VendorPreview.Mount(Frame, u87, ItemDatabase);
    local v90 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        Position = UDim2.fromOffset(12, 248),
        Size = UDim2.new(1, -24, 1, -344),
        ScrollBarImageColor3 = Color3_fromRGB_ret4,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    };
    local ScrollingFrame = Instance.new("ScrollingFrame");

    for i, v in pairs(v90) do
        ScrollingFrame[i] = v;
    end;

    ScrollingFrame.Parent = detail;
    local v91 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
    };
    local UIListLayout = Instance.new("UIListLayout");

    for i, v in pairs(v91) do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = ScrollingFrame;
    label(ScrollingFrame, u87.subtitle or "", {
        LayoutOrder = 1,
        TextSize = 12,
        Size = UDim2.new(1, 0, 0, 16),
        TextColor3 = Color3_fromRGB_ret7,
        FontFace = Font_new_ret2
    });
    label(ScrollingFrame, u87.blurb or "", {
        LayoutOrder = 2,
        TextWrapped = true,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextColor3 = Color3_fromRGB_ret6,
        TextTruncate = Enum.TextTruncate.None
    });

    for i, v in ipairs(u87.bullets or {}) do
        label(ScrollingFrame, "+  " .. v, {
            TextWrapped = true,
            LayoutOrder = 2 + i,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextTruncate = Enum.TextTruncate.None,
            TextColor3 = v == "Included with Master Stalker" and Color3_fromRGB_ret7 or Color3_fromRGB_ret5
        });
    end;

    local v92;

    if u1 == nil then
        v92 = false;
    else
        v92 = (u87.giftId or 0) ~= 0;
    end;

    local v93 = v92 and UDim2.new(0.5, -15, 0, 44) or UDim2.new(1, -24, 0, 44);
    local v94 = {
        Name = "PurchaseBtn",
        BorderSizePixel = 0,
        Text = "",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 12, 1, -34),
        Size = v93,
        FontFace = Font_new_ret2,
        TextSize = v92 and 13 or 16
    };
    local TextButton = Instance.new("TextButton");

    for i, v in pairs(v94) do
        TextButton[i] = v;
    end;

    TextButton.Parent = detail;
    local v95 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in pairs(v95) do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton;
    label(detail, "Price shown for your region.", {
        TextSize = 12,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 12, 1, -12),
        Size = UDim2.new(1, -24, 0, 16),
        TextColor3 = Color3_fromRGB_ret6,
        TextXAlignment = Enum.TextXAlignment.Center
    });
    TextButton.Activated:Connect(function() -- Line: 393
        -- upvalues: u86 (copy), u87 (copy)
        u86:_purchase(u87);
    end);
    u86._buyBtn = TextButton;
    u86._buyStroke = UIStroke2;
    u86._buyFor = u87;
    u86._giftBtn = nil;

    if v92 then
        local v96 = {
            Name = "GiftBtn",
            BorderSizePixel = 0,
            TextSize = 13,
            Text = "",
            AutoButtonColor = true,
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -12, 1, -34),
            Size = v93,
            FontFace = Font_new_ret2,
            BackgroundColor3 = Color3_fromRGB_ret8,
            TextColor3 = Color3_fromRGB_ret7
        };
        local TextButton2 = Instance.new("TextButton");

        for i, v in pairs(v96) do
            TextButton2[i] = v;
        end;

        TextButton2.Parent = detail;
        local v97 = {
            Thickness = 1,
            Color = Color3_fromRGB_ret7 or Color3_fromRGB_ret4,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke3 = Instance.new("UIStroke");

        for i, v in pairs(v97) do
            UIStroke3[i] = v;
        end;

        UIStroke3.Parent = TextButton2;
        TextButton2.Activated:Connect(function() -- Line: 403
            -- upvalues: u86 (copy), u87 (copy), u1 (ref), u20 (ref)
            local v98 = u86:_product(u87.id);

            if v98 and (v98.giftId or 0) ~= 0 then
                u1.Open(u86.UI.panel, v98, u20);
            end;
        end);
        u86._giftBtn = TextButton2;
    end;

    u86:_paintBuy();
end;

function v2._select(p99, p100) -- Line: 412
    p99.SelectedProductID = p100;
    p99:_paintSelection();
    p99:_renderDetail();
end;

function v2._renderGrid(u101) -- Line: 418
    -- upvalues: makeTile (copy)
    for _, child in ipairs(u101.UI.grid:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy();
        end;
    end;

    table.clear(u101._tiles);
    local v102 = 0;
    local v103 = nil;
    local v104 = false;

    for _, v in ipairs(u101.Products) do
        if v.tab == u101.CurrentTab then
            v102 = v102 + 1;
            u101._tiles[v.id] = makeTile(u101.UI.grid, v102, v, v.id == u101.SelectedProductID, function(p105) -- Line: 427
                -- upvalues: u101 (copy)
                u101:_select(p105);
            end);
            v103 = v103 or v;

            if v.id == u101.SelectedProductID then
                v104 = true;
            end;
        end;
    end;

    local v106 = v104 and u101.SelectedProductID;

    if v106 then
        v103 = v106;
    elseif v103 then
        v103 = v103.id;
    end;

    u101:_select(v103);
end;

function v2._switchTab(p107, p108) -- Line: 438
    p107.CurrentTab = p108;
    p107:_paintTabs();
    p107:_renderGrid();
end;

function v2._renderBanner(p109) -- Line: 444
    -- upvalues: VendorPreview (copy), ItemDatabase (copy)
    local UI = p109.UI;
    local Featured = p109.Featured;
    UI.banner.Visible = Featured ~= nil;
    UI.grid.Size = UDim2.new(1, 0, 1, -(38 + (Featured and 168 or 0)));

    for _, child in ipairs(UI.bannerArt:GetChildren()) do
        child:Destroy();
    end;

    if not Featured then
        return;
    end;

    VendorPreview.Mount(UI.bannerArt, Featured, ItemDatabase);
    UI.bannerName.Text = string.upper(Featured.name);
    UI.bannerBlurb.Text = Featured.blurb or "";
    p109:_paintBannerPrice();
end;

function v2._purchase(p110, p111) -- Line: 458
    -- upvalues: RegionalPrices (copy), MarketplaceService (copy), LocalPlayer (copy)
    if p111 then
        p111 = p111.id;
    end;

    local v112 = p110:_product(p111);

    if not v112 or v112.isOwned then
        return;
    end;

    local v113;

    if v112.isOwned then
        local _ = v112.ownedLabel or "OWNED";
        v113 = false;
    elseif v112.blocked then
        local _ = v112.blocked;
        v113 = false;
    else
        local v114;
        v114, v113 = RegionalPrices.Label(RegionalPrices.Get(v112.kind, v112.robloxId));
    end;

    if not v113 then
        return;
    end;

    if type(v112.robloxId) ~= "number" or v112.robloxId <= 0 then
        warn("[PremiumVendor] no Roblox id configured for " .. tostring(v112.id));

        return;
    end;

    if v112.kind == "pass" then
        MarketplaceService:PromptGamePassPurchase(LocalPlayer, v112.robloxId);

        return;
    end;

    MarketplaceService:PromptProductPurchase(LocalPlayer, v112.robloxId);
end;

function v2.Refresh(u115) -- Line: 475
    -- upvalues: ReplicatedStorage (copy), VendorCatalog (copy), SkinCatalog (copy), ItemDatabase (copy), LocalPlayer (copy), RegionalPrices (copy)
    if not u115.UI then
        return;
    end;

    local Remotes = ReplicatedStorage:WaitForChild("Remotes");
    local v116 = {};
    local GetUnlockedSkins = Remotes:FindFirstChild("GetUnlockedSkins");

    if GetUnlockedSkins then
        local success, result = pcall(function() -- Line: 482
            -- upvalues: GetUnlockedSkins (copy)
            return GetUnlockedSkins:InvokeServer();
        end);

        if success and type(result) == "table" then
            for _, v in ipairs(result) do
                v116[v] = true;
            end;
        end;
    end;

    local v117 = 0;
    local v118 = 0;
    local v119 = false;
    local GetStashInventory = Remotes:FindFirstChild("GetStashInventory");

    if GetStashInventory then
        local success, result = pcall(function() -- Line: 493
            -- upvalues: GetStashInventory (copy)
            return GetStashInventory:InvokeServer();
        end);

        if success and type(result) == "table" then
            v117 = result.PremiumTier or 0;
            v118 = result.BarterTier or 0;
            v119 = true;
        end;
    end;

    local success, result = pcall(require, ReplicatedStorage:WaitForChild("StashTierConfig", 3));
    local success2, result2 = pcall(require, ReplicatedStorage:WaitForChild("SupporterCatalog", 3));
    local v120, v121 = VendorCatalog.Build({
        SupporterCatalog = success2 and result2 and result2 or {
            Tiers = {},
            TierOrder = {}
        },
        SkinCatalog = SkinCatalog,
        StashTierConfig = success and result and result or nil,
        ItemDatabase = ItemDatabase,
        ownedSet = v116,
        tierKey = LocalPlayer:GetAttribute("_SupporterTier"),
        premiumTier = v117,
        barterTier = v118,
        stashKnown = v119
    });
    u115.Products = v120;
    u115.Featured = v121;
    u115:_renderBanner();
    u115:_paintTabs();
    u115:_renderGrid();
    local v122 = {};

    for _, v in ipairs(u115.Products) do
        if not v.isOwned then
            table.insert(v122, {
                kind = v.kind,
                id = v.robloxId
            });
        end;

        if (v.giftId or 0) ~= 0 then
            table.insert(v122, {
                kind = "product",
                id = v.giftId
            });
        end;
    end;

    RegionalPrices.Prefetch(v122, function() -- Line: 524
        -- upvalues: u115 (copy)
        u115:_paintPrices();
    end);
end;

function v2.Open(u123, p124) -- Line: 527
    -- upvalues: build (copy), VendorCatalog (copy), Color3_fromRGB_ret3 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret4 (copy), freezeInput (copy)
    if u123.IsOpen then
        return;
    end;

    u123.IsOpen = true;
    u123.CurrentNPC = p124;

    if not u123.UI then
        u123.UI = build();

        for i, v in ipairs(VendorCatalog.TABS) do
            local v125 = {
                BorderSizePixel = 0,
                TextSize = 13,
                AutoButtonColor = true,
                Name = "Tab_" .. v.id,
                LayoutOrder = i,
                Size = UDim2.new(0, 0, 1, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = Color3_fromRGB_ret3,
                Text = v.label,
                FontFace = Font_new_ret2,
                TextColor3 = Color3_fromRGB_ret6
            };
            local tabsRow = u123.UI.tabsRow;
            local TextButton = Instance.new("TextButton");
            local v126 = v;

            for i2, v3 in pairs(v125) do
                TextButton[i2] = v3;
            end;

            TextButton.Parent = tabsRow;
            local v127 = {
                PaddingLeft = UDim.new(0, 14),
                PaddingRight = UDim.new(0, 14)
            };
            local UIPadding = Instance.new("UIPadding");

            for i2, v3 in pairs(v127) do
                UIPadding[i2] = v3;
            end;

            UIPadding.Parent = TextButton;
            local v128 = {
                Thickness = 1,
                Color = Color3_fromRGB_ret4,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            };
            local UIStroke = Instance.new("UIStroke");

            for i2, v3 in pairs(v128) do
                UIStroke[i2] = v3;
            end;

            UIStroke.Parent = TextButton;
            local id = v126.id;
            TextButton.Activated:Connect(function() -- Line: 542
                -- upvalues: u123 (copy), id (copy)
                u123:_switchTab(id);
            end);
            u123._tabs[v126.id] = {
                button = TextButton,
                stroke = UIStroke
            };
        end;

        u123.UI.closeBtn.Activated:Connect(function() -- Line: 545
            -- upvalues: u123 (copy)
            u123:Close();
        end);
        u123.UI.banner.Activated:Connect(function() -- Line: 546
            -- upvalues: u123 (copy)
            local Featured = u123.Featured;

            if Featured then
                u123:_switchTab(Featured.tab);
                u123:_select(Featured.id);
            end;
        end);
    end;

    local v129 = typeof(p124) == "Instance" and (p124:GetAttribute("DisplayName") or (p124.Name or "")) or "";
    u123.UI.npcLbl.Text = string.upper((tostring(v129)));
    u123.UI.gui.Enabled = true;
    freezeInput();
    u123:Refresh();
end;

function v2.Close(p130) -- Line: 561
    -- upvalues: u1 (copy), unfreezeInput (copy)
    if not p130.IsOpen then
        return;
    end;

    if u1 then
        u1.Close();
    end;

    p130.IsOpen = false;
    p130.CurrentNPC = nil;

    if p130.UI then
        p130.UI.gui.Enabled = false;
    end;

    unfreezeInput();
end;

function v2.Init(u131) -- Line: 570
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), MarketplaceService (copy), UserInputService (copy), u1 (copy), ToastUI (copy)
    if u131._inited then
        return;
    end;

    u131._inited = true;
    local Remotes = ReplicatedStorage:WaitForChild("Remotes");
    Remotes:WaitForChild("OpenPremiumVendor").OnClientEvent:Connect(function(p132) -- Line: 574
        -- upvalues: u131 (copy)
        u131:Open(p132);
    end);
    local UnlockedSkinsChanged = Remotes:FindFirstChild("UnlockedSkinsChanged");

    if UnlockedSkinsChanged then
        UnlockedSkinsChanged.OnClientEvent:Connect(function() -- Line: 577
            -- upvalues: u131 (copy)
            if u131.IsOpen then
                u131:Refresh();
            end;
        end);
    end;

    LocalPlayer:GetAttributeChangedSignal("_SupporterTier"):Connect(function() -- Line: 579
        -- upvalues: u131 (copy)
        if u131.IsOpen then
            u131:Refresh();
        end;
    end);
    MarketplaceService.PromptProductPurchaseFinished:Connect(function(p133, p134, p135) -- Line: 583
        -- upvalues: LocalPlayer (ref), u131 (copy)
        if p135 and (p133 == LocalPlayer.UserId and u131.IsOpen) then
            task.delay(1.5, function() -- Line: 585
                -- upvalues: u131 (ref)
                if u131.IsOpen then
                    u131:Refresh();
                end;
            end);
        end;
    end);
    UserInputService.InputBegan:Connect(function(p136, p137) -- Line: 588
        -- upvalues: u131 (copy), u1 (ref)
        if p137 or not u131.IsOpen then
            return;
        end;

        if p136.KeyCode == Enum.KeyCode.Q then
            if u1 and u1.IsOpen() then
                u1.Close();

                return;
            end;

            u131:Close();
        end;
    end);
    local Gift_Notice = Remotes:WaitForChild("Gift_Notice", 10);

    if Gift_Notice then
        Gift_Notice.OnClientEvent:Connect(function(p138) -- Line: 598
            -- upvalues: ToastUI (ref)
            if type(p138) == "table" and type(p138.text) == "string" then
                ToastUI.Show(p138.text, p138.kind == "success" and "success" or "info");
            end;
        end);
    end;

    print("[PremiumVendorController v4] initialized");
end;

return v2;