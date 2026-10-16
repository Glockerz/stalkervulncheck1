-- Decompiled with Potassium's decompiler.

local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 220);
local Color3_fromRGB_ret3 = Color3.fromRGB(170, 170, 170);
local Color3_fromRGB_ret4 = Color3.fromRGB(120, 120, 120);
local Color3_fromRGB_ret5 = Color3.fromRGB(60, 70, 50);
local Color3_fromRGB_ret6 = Color3.fromRGB(140, 170, 90);
local Color3_fromRGB_ret7 = Color3.fromRGB(60, 60, 60);
local Color3_fromRGB_ret8 = Color3.fromRGB(28, 30, 28);
local Color3_fromRGB_ret9 = Color3.fromRGB(38, 40, 38);
local u1 = {
    friendly = Color3.fromRGB(140, 200, 120),
    neutral = Color3.fromRGB(225, 180, 90),
    unfriendly = Color3.fromRGB(235, 140, 80),
    hostile = Color3.fromRGB(225, 95, 95)
};
local u2 = {
    {
        key = "Loner",
        name = "LONERS",
        sub = "Independent Stalkers",
        standing = "neutral",
        rep = 0,
        image = "rbxassetid://112051392817144",
        icon = Color3.fromRGB(170, 160, 130)
    },
    {
        key = "ClearSky",
        name = "CLEAR SKY",
        sub = "Zone Research Militia",
        standing = "neutral",
        rep = 0,
        image = "rbxassetid://95584079688060",
        icon = Color3.fromRGB(110, 160, 200)
    },
    {
        key = "Ecologist",
        name = "ECOLOGISTS",
        sub = "Government Scientists",
        standing = "neutral",
        rep = 0,
        image = "rbxassetid://81918419109899",
        icon = Color3.fromRGB(180, 160, 90)
    },
    {
        key = "Mercenary",
        name = "MERCENARIES",
        sub = "Contracted Operators",
        standing = "neutral",
        rep = 0,
        image = "rbxassetid://136916313162119",
        icon = Color3.fromRGB(150, 150, 160)
    },
    {
        fixed = true,
        name = "DUTY",
        sub = "Anti-Zone Paramilitary",
        standing = "neutral",
        rep = 0,
        image = "rbxassetid://119785670350314",
        icon = Color3.fromRGB(180, 60, 60)
    },
    {
        fixed = true,
        name = "FREEDOM",
        sub = "Anarchist Militia",
        standing = "neutral",
        rep = 0,
        image = "rbxassetid://88545577686491",
        icon = Color3.fromRGB(80, 160, 80)
    },
    {
        fixed = true,
        name = "BANDITS",
        sub = "Criminal Raiders",
        standing = "hostile",
        rep = 0,
        image = "rbxassetid://123458810719829",
        icon = Color3.fromRGB(160, 90, 90)
    },
    {
        fixed = true,
        name = "MILITARY",
        sub = "Ukrainian Armed Forces",
        standing = "hostile",
        rep = 0,
        image = "rbxassetid://140564765009660",
        icon = Color3.fromRGB(80, 110, 160)
    },
    {
        fixed = true,
        name = "MONOLITH",
        sub = "Fanatical Zealots",
        standing = "hostile",
        rep = 0,
        image = "rbxassetid://71835978563903",
        icon = Color3.fromRGB(190, 190, 215)
    }
};
local RankRules = require(game:GetService("ReplicatedStorage"):WaitForChild("RankRules"));
local RANK_COLORS = RankRules.RANK_COLORS;

local function formatRp(p3) -- Line: 59
    local math_floor_ret = math.floor(p3);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local u4 = {};
local u5 = {
    hostile = "HOSTILE",
    neutral = "NEUTRAL"
};
local u6 = {
    friendly = "FRIENDLY",
    neutral = "NEUTRAL",
    unfriendly = "UNFRIENDLY",
    hostile = "HATED"
};
local u7 = { {
        upTo = -500,
        key = "hostile"
    }, {
        upTo = -100,
        key = "unfriendly"
    }, {
        upTo = 249,
        key = "neutral"
    }, {
        upTo = (1 / 0),
        key = "friendly"
    } };

for i, v in ipairs(RankRules.RANKS) do
    local v8 = RankRules.RANKS[i + 1];
    local v9 = {
        name = string.upper(v.name)
    };
    local v10, v11;

    if v8 then
        local math_floor_ret = math.floor(v.rp);
        local v12 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        local math_floor_ret2 = math.floor(v8.rp - 1);
        v10 = v12 .. " – " .. tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " RP";

        if not v10 then
            v11 = math.floor(v.rp);
            v10 = tostring(v11):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. "+ RP";
        end;
    else
        v11 = math.floor(v.rp);
        v10 = tostring(v11):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. "+ RP";
    end;

    v9.range = v10;
    v9.color = RANK_COLORS[i];
    u4[i] = v9;
end;

local u13 = {
    name = "ROOKIE",
    rp = 0,
    next = 500,
    nextName = "Experienced",
    fraction = 0,
    color = RANK_COLORS[1]
};

local function refreshRank() -- Line: 77
    -- upvalues: u13 (copy), RankRules (copy), RANK_COLORS (copy), u4 (copy)
    local LocalPlayer = game:GetService("Players").LocalPlayer;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:GetAttribute("RankRP");
    end;

    u13.loading = LocalPlayer == nil;
    local v14 = tonumber(LocalPlayer) or 0;
    local v15 = RankRules.Progress(v14);
    u13.name = string.upper(v15.name);
    u13.rp = v14;
    u13.next = v15.nextAt;
    u13.nextName = v15.nextName;
    u13.fraction = v15.fraction;
    u13.color = RANK_COLORS[v15.index];

    for i, v in ipairs(u4) do
        v.selected = i == v15.index;
    end;
end;

local function formatNumber(p16) -- Line: 95
    local math_abs_ret = math.abs(p16);
    local v17 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

    if p16 < 0 then
        v17 = "-" .. v17;
    end;

    return v17;
end;

local function buildFactionRow(p18, p19, p20) -- Line: 103
    -- upvalues: Font_new_ret (copy), Color3_fromRGB_ret2 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret2 (copy), u1 (copy), u5 (copy), u6 (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret4 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Faction_" .. p19.name;
    Frame.Size = UDim2.new(1, -8, 0, 76);
    Frame.BackgroundTransparency = 1;
    Frame.LayoutOrder = p20;
    Frame.Parent = p18;
    local Frame2 = Instance.new("Frame");
    Frame2.Position = UDim2.fromOffset(4, 8);
    Frame2.Size = UDim2.fromOffset(40, 40);
    Frame2.BackgroundColor3 = Color3.fromRGB(45, 48, 42);
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p19.icon;
    UIStroke.Thickness = 1.5;
    UIStroke.Parent = Frame2;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(0.85, 0.85);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Image = p19.image;
    ImageLabel.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(56, 4);
    TextLabel.Size = UDim2.new(1, -200, 0, 22);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 16;
    TextLabel.TextColor3 = Color3_fromRGB_ret2;
    TextLabel.Text = p19.name;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(56, 27);
    TextLabel2.Size = UDim2.new(1, -200, 0, 18);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 13;
    TextLabel2.TextColor3 = Color3_fromRGB_ret3;
    TextLabel2.Text = p19.sub;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Parent = Frame;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.AnchorPoint = Vector2.new(1, 0);
    TextLabel3.Position = UDim2.new(1, -8, 0, 4);
    TextLabel3.Size = UDim2.fromOffset(120, 20);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret2;
    TextLabel3.TextSize = 14;
    TextLabel3.TextColor3 = u1[p19.standing];
    TextLabel3.Text = p19.fixed and u5[p19.standing] or u6[p19.standing];
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel3.Parent = Frame;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.AnchorPoint = Vector2.new(1, 0);
    TextLabel4.Position = UDim2.new(1, -8, 0, 24);
    TextLabel4.Size = UDim2.fromOffset(100, 22);
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = Font_new_ret;
    TextLabel4.TextSize = 17;
    TextLabel4.TextColor3 = u1[p19.standing];
    local v21;

    if p19.fixed then
        v21 = "";
    else
        local v22 = p19.rep >= 0 and "+" or "";
        local rep = p19.rep;
        local math_abs_ret = math.abs(rep);
        local v23 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

        if rep < 0 then
            v23 = "-" .. v23;
        end;

        v21 = v22 .. v23;
    end;

    TextLabel4.Text = v21;
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel4.Parent = Frame;
    local Frame3 = Instance.new("Frame");
    Frame3.Position = UDim2.fromOffset(56, 52);
    Frame3.Size = UDim2.new(1, -64, 0, 4);
    Frame3.BackgroundColor3 = Color3_fromRGB_ret9;
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = Frame;
    local Frame4 = Instance.new("Frame");
    local v24 = math.abs(p19.rep) / 1000;
    local math_clamp_ret = math.clamp(v24, 0, 1);
    Frame4.Size = UDim2.new(p19.fixed and (p19.standing == "hostile" and 1 or 0) or math_clamp_ret, 0, 1, 0);
    Frame4.BackgroundColor3 = u1[p19.standing];
    Frame4.BorderSizePixel = 0;
    Frame4.Parent = Frame3;
    local TextLabel5 = Instance.new("TextLabel");
    TextLabel5.AnchorPoint = Vector2.new(1, 0);
    TextLabel5.Position = UDim2.new(1, -8, 0, 57);
    TextLabel5.Size = UDim2.fromOffset(160, 16);
    TextLabel5.BackgroundTransparency = 1;
    TextLabel5.FontFace = Font_new_ret3;
    TextLabel5.TextSize = 11;
    TextLabel5.TextColor3 = Color3_fromRGB_ret4;
    local v25;

    if p19.fixed then
        v25 = p19.standing == "hostile" and "Always hostile" or "No dealings yet";
    else
        local rep = p19.rep;
        local math_abs_ret = math.abs(rep);
        local v26 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

        if rep < 0 then
            v26 = "-" .. v26;
        end;

        v25 = v26 .. " / 1000";
    end;

    TextLabel5.Text = v25;
    TextLabel5.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel5.Parent = Frame;
end;

local function buildFactionPanel(p27) -- Line: 207
    -- upvalues: Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret7 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy), u2 (copy), buildFactionRow (copy), Font_new_ret3 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "FactionPanel";
    Frame.Size = UDim2.new(0.5, -8, 1, 0);
    Frame.BackgroundColor3 = Color3_fromRGB_ret8;
    Frame.BackgroundTransparency = 0.4;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p27;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret7;
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 12);
    UIPadding.PaddingBottom = UDim.new(0, 8);
    UIPadding.PaddingLeft = UDim.new(0, 14);
    UIPadding.PaddingRight = UDim.new(0, 14);
    UIPadding.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 22);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 14;
    TextLabel.TextColor3 = Color3_fromRGB_ret4;
    TextLabel.Text = "FACTION STANDING";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "FactionList";
    ScrollingFrame.Position = UDim2.fromOffset(0, 30);
    ScrollingFrame.Size = UDim2.new(1, 0, 1, -82);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.Parent = ScrollingFrame;

    for i, v in ipairs(u2) do
        buildFactionRow(ScrollingFrame, v, i);
    end;

    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.AnchorPoint = Vector2.new(0, 1);
    TextLabel2.Position = UDim2.new(0, 0, 1, -4);
    TextLabel2.Size = UDim2.new(1, 0, 0, 44);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 12;
    TextLabel2.TextColor3 = Color3_fromRGB_ret4;
    TextLabel2.TextWrapped = true;
    TextLabel2.Text = "Your standing with each faction affects prices, available quests, and how they respond to you in the Zone.";
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Bottom;
    TextLabel2.Parent = Frame;
end;

local function buildCurrentRank(p28) -- Line: 274
    -- upvalues: Color3_fromRGB_ret7 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy), u13 (copy), Font_new_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret9 (copy), u1 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret3 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "CurrentRank";
    Frame.Position = UDim2.fromOffset(0, 0);
    Frame.Size = UDim2.new(0.48, -4, 0, 226);
    Frame.BackgroundColor3 = Color3.fromRGB(34, 36, 32);
    Frame.BackgroundTransparency = 0.2;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p28;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret7;
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(12, 8);
    TextLabel.Size = UDim2.new(1, -24, 0, 18);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 12;
    TextLabel.TextColor3 = Color3_fromRGB_ret4;
    TextLabel.Text = "YOUR CURRENT RANK";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.AnchorPoint = Vector2.new(0.5, 0);
    Frame2.Position = UDim2.new(0.5, 0, 0, 30);
    Frame2.Size = UDim2.fromOffset(68, 68);
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    local Frame3 = Instance.new("Frame");
    Frame3.Size = UDim2.fromScale(1, 1);
    Frame3.BackgroundColor3 = Color3.fromRGB(40, 42, 38);
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = Frame2;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame3;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = u13.color;
    UIStroke2.Thickness = 1.5;
    UIStroke2.Parent = Frame3;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.fromScale(1, 1);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret;
    TextLabel2.TextSize = 32;
    TextLabel2.TextColor3 = u13.color;
    TextLabel2.Text = string.sub(u13.name, 1, 1);
    TextLabel2.Parent = Frame3;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Position = UDim2.fromOffset(0, 104);
    TextLabel3.Size = UDim2.new(1, 0, 0, 28);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret;
    TextLabel3.TextSize = 20;
    TextLabel3.TextColor3 = Color3_fromRGB_ret2;
    TextLabel3.Text = u13.loading and "LOADING" or u13.name;
    TextLabel3.Parent = Frame;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.Position = UDim2.fromOffset(0, 130);
    TextLabel4.Size = UDim2.new(1, 0, 0, 24);
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = Font_new_ret2;
    TextLabel4.TextSize = 18;
    TextLabel4.TextColor3 = u13.color;
    local v29;

    if u13.loading then
        v29 = "-- RP";
    else
        local rp = u13.rp;
        local math_abs_ret = math.abs(rp);
        local v30 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

        if rp < 0 then
            v30 = "-" .. v30;
        end;

        v29 = v30 .. " RP";
    end;

    TextLabel4.Text = v29;
    TextLabel4.Parent = Frame;
    local Frame4 = Instance.new("Frame");
    Frame4.Position = UDim2.fromOffset(14, 162);
    Frame4.Size = UDim2.new(1, -28, 0, 5);
    Frame4.BackgroundColor3 = Color3_fromRGB_ret9;
    Frame4.BorderSizePixel = 0;
    Frame4.Parent = Frame;
    local Frame5 = Instance.new("Frame");
    Frame5.Size = UDim2.new(u13.fraction, 0, 1, 0);
    Frame5.BackgroundColor3 = u1.friendly;
    Frame5.BorderSizePixel = 0;
    Frame5.Parent = Frame4;
    local TextLabel5 = Instance.new("TextLabel");
    TextLabel5.Position = UDim2.fromOffset(0, 170);
    TextLabel5.Size = UDim2.new(1, 0, 0, 18);
    TextLabel5.BackgroundTransparency = 1;
    TextLabel5.FontFace = Font_new_ret3;
    TextLabel5.TextSize = 12;
    TextLabel5.TextColor3 = Color3_fromRGB_ret3;
    local v31;

    if u13.loading then
        v31 = "";
    else
        local v32, v33, v34;

        if u13.next then
            local string_format = string.format;
            local rp = u13.rp;
            local math_abs_ret = math.abs(rp);
            local v35 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

            if rp < 0 then
                v35 = "-" .. v35;
            end;

            local next = u13.next;
            local math_abs_ret2 = math.abs(next);
            local v36 = tostring(math_abs_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

            if next < 0 then
                v36 = "-" .. v36;
            end;

            v31 = string_format("%s / %s RP", v35, v36);

            if not v31 then
                v32 = u13.rp;
                v33 = math.abs(v32);
                v34 = tostring(v33):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

                if v32 < 0 then
                    v34 = "-" .. v34;
                end;

                v31 = v34 .. " RP";
            end;
        else
            v32 = u13.rp;
            v33 = math.abs(v32);
            v34 = tostring(v33):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

            if v32 < 0 then
                v34 = "-" .. v34;
            end;

            v31 = v34 .. " RP";
        end;
    end;

    TextLabel5.Text = v31;
    TextLabel5.Parent = Frame;
    local TextLabel6 = Instance.new("TextLabel");
    TextLabel6.Position = UDim2.fromOffset(0, 190);
    TextLabel6.Size = UDim2.new(1, 0, 0, 18);
    TextLabel6.BackgroundTransparency = 1;
    TextLabel6.FontFace = Font_new_ret3;
    TextLabel6.TextSize = 12;
    TextLabel6.TextColor3 = Color3_fromRGB_ret4;
    TextLabel6.Text = u13.loading and "Your rank is loading" or (u13.nextName and "Next Rank: " .. u13.nextName or "Highest rank reached");
    TextLabel6.Parent = Frame;
end;

local function buildRankTier(p37, p38, p39) -- Line: 383
    -- upvalues: Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy), Font_new_ret (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret4 (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 0, 32);
    Frame.BackgroundColor3 = Color3_fromRGB_ret5;
    Frame.BackgroundTransparency = p38.selected and 0.25 or 1;
    Frame.BorderSizePixel = 0;
    Frame.LayoutOrder = p39;
    Frame.Parent = p37;

    if p38.selected then
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3_fromRGB_ret6;
        UIStroke.Thickness = 1;
        UIStroke.Transparency = 0.4;
        UIStroke.Parent = Frame;
    end;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(8, 0);
    TextLabel.Size = UDim2.fromOffset(20, 32);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 16;
    TextLabel.TextColor3 = p38.color;
    TextLabel.Text = "▲";
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(34, 1);
    TextLabel2.Size = UDim2.new(1, -42, 0, 16);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret2;
    TextLabel2.TextSize = 13;
    TextLabel2.TextColor3 = p38.selected and Color3_fromRGB_ret2 or Color3_fromRGB_ret3;
    TextLabel2.Text = p38.name;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Parent = Frame;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Position = UDim2.fromOffset(34, 16);
    TextLabel3.Size = UDim2.new(1, -42, 0, 14);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret3;
    TextLabel3.TextSize = 11;
    TextLabel3.TextColor3 = Color3_fromRGB_ret4;
    TextLabel3.Text = p38.range;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Parent = Frame;
end;

local function buildRanks(p40) -- Line: 433
    -- upvalues: u4 (copy), buildRankTier (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Ranks";
    Frame.AnchorPoint = Vector2.new(1, 0);
    Frame.Position = UDim2.new(1, 0, 0, 0);
    Frame.Size = UDim2.new(0.52, -4, 0, 226);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p40;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.Parent = Frame;

    for i, v in ipairs(u4) do
        buildRankTier(Frame, v, i);
    end;
end;

local function buildLeaderRow(p41, p42, p43, p44) -- Line: 452
    -- upvalues: Color3_fromRGB_ret5 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), Font_new_ret (copy), Font_new_ret3 (copy), Color3_fromRGB_ret2 (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 0, 22);
    Frame.BackgroundColor3 = Color3_fromRGB_ret5;
    Frame.BackgroundTransparency = p44 and 0.25 or 1;
    Frame.BorderSizePixel = 0;
    Frame.LayoutOrder = p43;
    Frame.Parent = p41;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(8, 0);
    TextLabel.Size = UDim2.fromOffset(40, 22);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 13;
    TextLabel.TextColor3 = p44 and Color3_fromRGB_ret or Color3_fromRGB_ret3;
    TextLabel.Text = tostring(p42.rank);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(48, 0);
    TextLabel2.Size = UDim2.new(1, -148, 1, 0);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = p44 and Font_new_ret or Font_new_ret3;
    TextLabel2.TextSize = 13;
    TextLabel2.TextColor3 = p44 and Color3_fromRGB_ret2 or Color3_fromRGB_ret2;
    TextLabel2.Text = p42.name;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel2.Parent = Frame;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.AnchorPoint = Vector2.new(1, 0);
    TextLabel3.Position = UDim2.new(1, -10, 0, 0);
    TextLabel3.Size = UDim2.fromOffset(120, 22);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret2;
    TextLabel3.TextSize = 13;
    TextLabel3.TextColor3 = p44 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
    local rp = p42.rp;
    local math_abs_ret = math.abs(rp);
    local v45 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

    if rp < 0 then
        v45 = "-" .. v45;
    end;

    TextLabel3.Text = v45 .. " RP";
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel3.Parent = Frame;
end;

local u46 = nil;
local u47 = nil;

local function fetchBoard(p48) -- Line: 505
    -- upvalues: u47 (ref), u46 (ref)
    if u47 then
        table.insert(u47, p48);

        return;
    end;

    u47 = { p48 };
    task.spawn(function() -- Line: 511
        -- upvalues: u46 (ref), u47 (ref)
        local Remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes");

        if Remotes then
            Remotes = Remotes:WaitForChild("RankLeaderboardGet", 5);
        end;

        local v49 = nil;

        for i = 1, 2 do
            if not Remotes then
                break;
            end;

            local success, result = pcall(function() -- Line: 517
                -- upvalues: Remotes (copy)
                return Remotes:InvokeServer();
            end);

            if success and type(result) == "table" then
                v49 = result;
                break;
            end;

            local v50;

            if i == 1 then
                task.wait(2.2);
                v50 = i;
            else
                v50 = i;
            end;
        end;

        if v49 and v49.ok then
            u46 = {
                at = os.clock(),
                data = v49
            };
        end;

        if not (v49 and v49.ok) and u46 then
            v49 = u46.data;
        end;

        local v51 = u47;
        u47 = nil;

        for _, v in ipairs(v51) do
            task.spawn(v, v49);
        end;
    end);
end;

local function buildTop(p52) -- Line: 531
    -- upvalues: Color3_fromRGB_ret7 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret (copy), Font_new_ret3 (copy), buildLeaderRow (copy), u46 (ref), fetchBoard (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Top";
    Frame.Position = UDim2.fromOffset(0, 302);
    Frame.Size = UDim2.new(1, 0, 1, -302);
    Frame.BackgroundColor3 = Color3.fromRGB(34, 36, 32);
    Frame.BackgroundTransparency = 0.2;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p52;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret7;
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 8);
    UIPadding.PaddingBottom = UDim.new(0, 8);
    UIPadding.PaddingLeft = UDim.new(0, 12);
    UIPadding.PaddingRight = UDim.new(0, 12);
    UIPadding.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.new(1, 0, 0, 22);
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(0.5, 0, 1, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 13;
    TextLabel.TextColor3 = Color3_fromRGB_ret4;
    TextLabel.Text = "TOP STALKERS";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame2;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.AnchorPoint = Vector2.new(1, 0);
    TextLabel2.Position = UDim2.new(1, 0, 0, 0);
    TextLabel2.Size = UDim2.new(0.6, 0, 1, 0);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret2;
    TextLabel2.TextSize = 13;
    TextLabel2.TextColor3 = Color3_fromRGB_ret;
    TextLabel2.Text = "";
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel2.Parent = Frame2;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Position = UDim2.fromOffset(0, 26);
    ScrollingFrame.Size = UDim2.new(1, 0, 1, -26);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 2);
    UIListLayout.Parent = ScrollingFrame;

    local function note(p53, p54) -- Line: 599
        -- upvalues: Font_new_ret3 (ref), Color3_fromRGB_ret4 (ref), ScrollingFrame (copy)
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.Size = UDim2.new(1, 0, 0, 20);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = Font_new_ret3;
        TextLabel3.TextSize = 12;
        TextLabel3.TextColor3 = Color3_fromRGB_ret4;
        TextLabel3.Text = p53;
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.LayoutOrder = p54;
        TextLabel3.Parent = ScrollingFrame;
    end;

    local function fill(p55) -- Line: 612
        -- upvalues: ScrollingFrame (copy), TextLabel2 (copy), Font_new_ret3 (ref), Color3_fromRGB_ret4 (ref), buildLeaderRow (ref)
        if not ScrollingFrame.Parent then
            return;
        end;

        for _, child in ipairs(ScrollingFrame:GetChildren()) do
            if not child:IsA("UIListLayout") then
                child:Destroy();
            end;
        end;

        if type(p55) == "table" and p55.ok then
            local v56 = p55.me or {};
            local v57 = p55.track or 1000;
            local v58 = p55.minRp or 100;

            if v56.rank then
                local rank = v56.rank;
                local math_abs_ret = math.abs(rank);
                local v59 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

                if rank < 0 then
                    v59 = "-" .. v59;
                end;

                TextLabel2.Text = "YOUR RANK  #" .. v59;
            elseif v56.loading then
                TextLabel2.Text = "YOUR RANK: LOADING";
            elseif (v56.rp or 0) < v58 then
                TextLabel2.Text = "YOUR RANK: UNRANKED";
            else
                local math_abs_ret = math.abs(v57);
                local v60 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

                if v57 < 0 then
                    v60 = "-" .. v60;
                end;

                TextLabel2.Text = "YOUR RANK: OUTSIDE TOP " .. v60;
            end;

            local v61 = p55.top or {};

            if #v61 == 0 then
                local v62 = p55.minRp or 100;
                local math_abs_ret = math.abs(v62);
                local v63 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

                if v62 < 0 then
                    v63 = "-" .. v63;
                end;

                local v64 = ("No stalkers ranked yet. Earn %s RP to appear."):format(v63);
                local TextLabel3 = Instance.new("TextLabel");
                TextLabel3.Size = UDim2.new(1, 0, 0, 20);
                TextLabel3.BackgroundTransparency = 1;
                TextLabel3.FontFace = Font_new_ret3;
                TextLabel3.TextSize = 12;
                TextLabel3.TextColor3 = Color3_fromRGB_ret4;
                TextLabel3.Text = v64;
                TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel3.LayoutOrder = 1;
                TextLabel3.Parent = ScrollingFrame;
            end;

            local v65 = false;

            for i, v in ipairs(v61) do
                buildLeaderRow(ScrollingFrame, {
                    rank = i,
                    name = v.name,
                    rp = v.rp
                }, i, v.isMe);

                if v.isMe then
                    v65 = true;
                end;
            end;

            if not (v65 or v56.loading) then
                local TextLabel3 = Instance.new("TextLabel");
                TextLabel3.Size = UDim2.new(1, 0, 0, 12);
                TextLabel3.BackgroundTransparency = 1;
                TextLabel3.FontFace = Font_new_ret3;
                TextLabel3.TextSize = 12;
                TextLabel3.TextColor3 = Color3_fromRGB_ret4;
                TextLabel3.Text = "⋯";
                TextLabel3.LayoutOrder = #v61 + 1;
                TextLabel3.Parent = ScrollingFrame;
                local LocalPlayer = game:GetService("Players").LocalPlayer;
                local v66 = {};
                local v67;

                if v56.rank then
                    local rank = v56.rank;
                    local math_abs_ret = math.abs(rank);
                    local v68 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

                    if rank < 0 then
                        v68 = "-" .. v68;
                    end;

                    v67 = v68 or "-";
                else
                    v67 = "-";
                end;

                v66.rank = v67;
                v66.name = LocalPlayer and LocalPlayer.Name or "You";
                v66.rp = v56.rp or 0;
                buildLeaderRow(ScrollingFrame, v66, #v61 + 2, true);

                if not v56.rank and (v56.rp or 0) < (p55.minRp or 100) then
                    local v69 = p55.minRp or 100;
                    local math_abs_ret = math.abs(v69);
                    local v70 = tostring(math_abs_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

                    if v69 < 0 then
                        v70 = "-" .. v70;
                    end;

                    local v71 = ("Earn %s RP to appear on the board."):format(v70);
                    local TextLabel4 = Instance.new("TextLabel");
                    TextLabel4.Size = UDim2.new(1, 0, 0, 20);
                    TextLabel4.BackgroundTransparency = 1;
                    TextLabel4.FontFace = Font_new_ret3;
                    TextLabel4.TextSize = 12;
                    TextLabel4.TextColor3 = Color3_fromRGB_ret4;
                    TextLabel4.Text = v71;
                    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
                    TextLabel4.LayoutOrder = #v61 + 3;
                    TextLabel4.Parent = ScrollingFrame;
                end;
            end;

            return;
        end;

        TextLabel2.Text = "";
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.Size = UDim2.new(1, 0, 0, 20);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = Font_new_ret3;
        TextLabel3.TextSize = 12;
        TextLabel3.TextColor3 = Color3_fromRGB_ret4;
        TextLabel3.Text = "Leaderboard unavailable. Try again in a few minutes.";
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.LayoutOrder = 1;
        TextLabel3.Parent = ScrollingFrame;
    end;

    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.new(1, 0, 0, 20);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret3;
    TextLabel3.TextSize = 12;
    TextLabel3.TextColor3 = Color3_fromRGB_ret4;
    TextLabel3.Text = "Loading...";
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.LayoutOrder = 1;
    TextLabel3.Parent = ScrollingFrame;
    local LocalPlayer = game:GetService("Players").LocalPlayer;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:GetAttribute("RankRP");
    end;

    if u46 and (os.clock() - u46.at < 10 and (LocalPlayer == nil or u46.data.me.rp == LocalPlayer)) then
        fill(u46.data);

        return;
    end;

    fetchBoard(fill);
end;

local function buildLeaderboardPanel(p72) -- Line: 676
    -- upvalues: Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret7 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret3 (copy), buildCurrentRank (copy), buildRanks (copy), buildTop (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "LeaderboardPanel";
    Frame.AnchorPoint = Vector2.new(1, 0);
    Frame.Position = UDim2.new(1, 0, 0, 0);
    Frame.Size = UDim2.new(0.5, -8, 1, 0);
    Frame.BackgroundColor3 = Color3_fromRGB_ret8;
    Frame.BackgroundTransparency = 0.4;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p72;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret7;
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 12);
    UIPadding.PaddingBottom = UDim.new(0, 12);
    UIPadding.PaddingLeft = UDim.new(0, 14);
    UIPadding.PaddingRight = UDim.new(0, 14);
    UIPadding.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 22);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 14;
    TextLabel.TextColor3 = Color3_fromRGB_ret4;
    TextLabel.Text = "PLAYER RANK";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(0, 24);
    TextLabel2.Size = UDim2.new(1, 0, 0, 32);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 12;
    TextLabel2.TextColor3 = Color3_fromRGB_ret3;
    TextLabel2.TextWrapped = true;
    TextLabel2.Text = "Your career in the Zone. Earned through tasks, exploration and the story, and never lost.";
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Position = UDim2.fromOffset(0, 64);
    Frame2.Size = UDim2.new(1, 0, 0, 226);
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    buildCurrentRank(Frame2);
    buildRanks(Frame2);
    buildTop(Frame);
end;

local v73 = {};

local function refreshFactions() -- Line: 738
    -- upvalues: u2 (copy), u7 (copy)
    local LocalPlayer = game:GetService("Players").LocalPlayer;

    for _, v in ipairs(u2) do
        if not v.fixed then
            local v74;

            if LocalPlayer then
                v74 = LocalPlayer:GetAttribute("FRep_" .. v.key);
            else
                v74 = LocalPlayer;
            end;

            local v75 = tonumber(v74) or 0;
            v.rep = v75;
            local v76 = v;

            for _, v2 in ipairs(u7) do
                if v75 <= v2.upTo then
                    v76.standing = v2.key;
                    break;
                end;
            end;
        end;
    end;
end;

function v73.Build(p77) -- Line: 750
    -- upvalues: refreshFactions (copy), refreshRank (copy), Font_new_ret (copy), Color3_fromRGB_ret2 (copy), buildFactionPanel (copy), buildLeaderboardPanel (copy)
    refreshFactions();
    refreshRank();
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "PageTitle";
    TextLabel.Position = UDim2.fromOffset(16, 4);
    TextLabel.Size = UDim2.fromOffset(220, 30);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 24;
    TextLabel.TextColor3 = Color3_fromRGB_ret2;
    TextLabel.Text = "REPUTATION";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = p77;
    local Frame = Instance.new("Frame");
    Frame.Name = "Body";
    Frame.Position = UDim2.fromOffset(16, 40);
    Frame.Size = UDim2.new(1, -32, 1, -48);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p77;
    buildFactionPanel(Frame);
    buildLeaderboardPanel(Frame);
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local u78 = false;

    if LocalPlayer then
        LocalPlayer.AttributeChanged:Connect(function(p79) -- Line: 781
            -- upvalues: u78 (ref), Frame (copy), refreshFactions (ref), refreshRank (ref), buildFactionPanel (ref), buildLeaderboardPanel (ref)
            if p79:sub(1, 5) ~= "FRep_" and p79 ~= "RankRP" or u78 then
                return;
            end;

            u78 = true;
            task.defer(function() -- Line: 784
                -- upvalues: u78 (ref), Frame (ref), refreshFactions (ref), refreshRank (ref), buildFactionPanel (ref), buildLeaderboardPanel (ref)
                u78 = false;

                if not Frame.Parent then
                    return;
                end;

                refreshFactions();
                refreshRank();

                for _, child in ipairs(Frame:GetChildren()) do
                    child:Destroy();
                end;

                buildFactionPanel(Frame);
                buildLeaderboardPanel(Frame);
            end);
        end);
    end;
end;

return v73;