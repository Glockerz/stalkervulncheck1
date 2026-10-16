-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local RankRules = require(ReplicatedStorage:WaitForChild("RankRules"));
local success, result = pcall(function() -- Line: 33
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("SupporterCatalog", 5));
end);

if not success then
    result = nil;
end;

local Color3_fromRGB_ret = Color3.fromRGB(22, 24, 22);
local Color3_fromRGB_ret2 = Color3.fromRGB(60, 60, 60);
local Color3_fromRGB_ret3 = Color3.fromRGB(30, 32, 30);
local Color3_fromRGB_ret4 = Color3.fromRGB(240, 240, 240);
local Color3_fromRGB_ret5 = Color3.fromRGB(150, 150, 150);
Color3.fromRGB(255, 255, 255);
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local u1 = {
    Loner = Color3.fromRGB(255, 255, 255),
    Bandit = Color3.fromRGB(255, 255, 255),
    Duty = Color3.fromRGB(255, 255, 255),
    Freedom = Color3.fromRGB(255, 255, 255),
    Mercenary = Color3.fromRGB(255, 255, 255),
    Military = Color3.fromRGB(255, 255, 255),
    Ecologist = Color3.fromRGB(255, 255, 255),
    Monolith = Color3.fromRGB(255, 255, 255),
    ["Clear Sky"] = Color3.fromRGB(255, 255, 255)
};
local u2 = {
    Loner = "rbxassetid://112051392817144",
    Bandit = "rbxassetid://123458810719829",
    Duty = "rbxassetid://119785670350314",
    Freedom = "rbxassetid://88545577686491",
    Mercenary = "rbxassetid://136916313162119",
    Ecologist = "rbxassetid://81918419109899",
    Military = "rbxassetid://140564765009660",
    Monolith = "rbxassetid://71835978563903",
    ["Clear Sky"] = "rbxassetid://95584079688060"
};

local function factionColor(p3) -- Line: 93
    -- upvalues: u1 (copy)
    return u1[p3] or u1.Loner;
end;

local function factionIcon(p4) -- Line: 97
    -- upvalues: u2 (copy)
    return u2[p4] or "rbxassetid://112051392817144";
end;

local u5 = {
    Drifter = {
        initial = "D",
        label = "DRIFTER",
        color = Color3.fromRGB(150, 165, 180)
    },
    Veteran = {
        initial = "V",
        label = "VETERAN",
        color = Color3.fromRGB(120, 200, 120)
    },
    MasterStalker = {
        initial = "M",
        label = "MASTER",
        color = Color3.fromRGB(220, 180, 60)
    }
};
local u6 = {
    Dev = {
        text = "DEV",
        color = Color3.fromRGB(225, 100, 175)
    },
    Admin = {
        text = "ADMIN",
        color = Color3.fromRGB(200, 80, 70)
    },
    Moderator = {
        text = "MOD",
        color = Color3.fromRGB(90, 150, 215)
    }
};
local u7 = {
    text = "PA",
    color = Color3.fromRGB(170, 130, 220)
};

local function makeChip(p8, p9, p10, p11, p12) -- Line: 127
    -- upvalues: Font_new_ret (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(p9, 0.9);
    Frame.BackgroundTransparency = 1;
    Frame.LayoutOrder = p10;
    Frame.Parent = p8;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.fromScale(1, 0.62);
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.Position = UDim2.fromScale(0.5, 0.5);
    Frame2.BackgroundColor3 = p12;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.25, 0);
    UICorner.Parent = Frame2;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 0.55;
    UIStroke.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromScale(0.86, 0.8);
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.5);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = p11;
    TextLabel.TextColor3 = Color3.fromRGB(18, 20, 18);
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextScaled = true;
    TextLabel.Parent = Frame2;

    return Frame;
end;

local function supporterInfo(p13) -- Line: 157
    -- upvalues: result (ref), u5 (copy)
    if type(p13) ~= "string" or p13 == "" then
        return nil;
    end;

    if not (result and (result.Tiers and result.Tiers[p13])) then
        return u5[p13];
    end;

    local v14 = result.Tiers[p13];
    local v15 = v14.DisplayName or p13;

    return {
        initial = p13:sub(1, 1):upper(),
        label = v15:upper(),
        color = v14.ChatColor or Color3.fromRGB(220, 180, 60)
    };
end;

local IsLobby = require(game:GetService("ReplicatedStorage"):WaitForChild("PlaceConfig")).IsLobby;
local u16 = IsLobby;
local u17 = {};

local function refreshVisibility() -- Line: 191
    -- upvalues: u17 (copy), u16 (ref)
    for _, v in pairs(u17) do
        if v.gui and v.gui.Parent then
            v.gui.Enabled = u16;
        end;
    end;
end;

if not IsLobby then
    task.spawn(function() -- Line: 200
        -- upvalues: ReplicatedStorage (copy), u16 (ref), refreshVisibility (copy)
        local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10);

        if Remotes then
            Remotes = Remotes:WaitForChild("SafezoneChanged", 10);
        end;

        if not Remotes then
            return;
        end;

        Remotes.OnClientEvent:Connect(function(p18) -- Line: 204
            -- upvalues: u16 (ref), refreshVisibility (ref)
            local v19 = p18 == "Full" and true or p18 == "TraderOnly";

            if v19 ~= u16 then
                u16 = v19;
                refreshVisibility();
            end;
        end);
    end);
end;

local function destroyNameplate(p20) -- Line: 214
    -- upvalues: u17 (copy)
    local v21 = u17[p20];

    if not v21 then
        return;
    end;

    for _, v in ipairs(v21.attributeConns) do
        pcall(function() -- Line: 218
            -- upvalues: v (copy)
            v:Disconnect();
        end);
    end;

    if v21.gui and v21.gui.Parent then
        v21.gui:Destroy();
    end;

    u17[p20] = nil;
end;

local function paintPlate(p22, p23) -- Line: 226
    -- upvalues: supporterInfo (copy), u6 (copy), RankRules (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy), u1 (copy), u2 (copy), makeChip (copy), u7 (copy)
    for _, child in ipairs(p22:GetChildren()) do
        if not (child:IsA("UIListLayout") or (child:IsA("UIPadding") or (child:IsA("UICorner") or child:IsA("UIStroke")))) then
            child:Destroy();
        end;
    end;

    local Attribute = p23:GetAttribute("PlayerRank");
    local v24;

    if type(Attribute) == "string" then
        v24 = Attribute ~= "";
    else
        v24 = false;
    end;

    local v25 = p23:GetAttribute("Faction") or "Loner";
    local v26 = supporterInfo((p23:GetAttribute("_SupporterTier")));
    local v27 = u6[p23:GetAttribute("_Staff")];
    local v28 = p23:GetAttribute("_PreAlpha") == true;
    local v29 = v27 and 0.12 or 0;
    local v30 = v28 and 0.1 or 0;
    local v31 = v26 and 0.18 or 0;
    local v32 = v24 and RankRules.ColorFor(Attribute) or Color3_fromRGB_ret5;
    local Frame = Instance.new("Frame");
    Frame.Name = "RankChip";
    Frame.Size = UDim2.fromScale(0.13, 0.9);
    Frame.BackgroundColor3 = Color3_fromRGB_ret3;
    Frame.BorderSizePixel = 0;
    Frame.LayoutOrder = 1;
    Frame.Parent = p22;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.15, 0);
    UICorner.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromScale(1, 0.56);
    TextLabel.Position = UDim2.fromScale(0, 0.06);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = v24 and "▲" or "--";
    TextLabel.TextColor3 = v32;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextScaled = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.fromScale(1, 0.3);
    TextLabel2.Position = UDim2.fromScale(0, 0.66);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = v24 and RankRules.ShortName(Attribute) or "";
    TextLabel2.TextColor3 = v32;
    TextLabel2.FontFace = Font_new_ret2;
    TextLabel2.TextScaled = true;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "NameCol";
    Frame2.Size = UDim2.fromScale(0.87 - v29 - v30 - v31 - 0.04, 0.9);
    Frame2.BackgroundTransparency = 1;
    Frame2.LayoutOrder = 2;
    Frame2.Parent = p22;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.fromScale(1, 0.55);
    TextLabel3.Position = UDim2.fromScale(0, 0);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.Text = p23.DisplayName;
    TextLabel3.TextColor3 = Color3_fromRGB_ret4;
    TextLabel3.FontFace = Font_new_ret;
    TextLabel3.TextScaled = true;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.TextYAlignment = Enum.TextYAlignment.Bottom;
    TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel3.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.Size = UDim2.fromScale(1, 0.42);
    Frame3.Position = UDim2.fromScale(0, 0.57);
    Frame3.BackgroundTransparency = 1;
    Frame3.Parent = Frame2;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.Padding = UDim.new(0.02, 0);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = Frame3;
    local v33 = u1[v25] or u1.Loner;
    local Frame4 = Instance.new("Frame");
    Frame4.Size = UDim2.fromScale(0.08, 1);
    Frame4.BackgroundTransparency = 1;
    Frame4.LayoutOrder = 1;
    Frame4.Parent = Frame3;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = 1;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height;
    UIAspectRatioConstraint.Parent = Frame4;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = u2[v25] or u2.Loner;
    ImageLabel.ImageColor3 = v33;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Parent = Frame4;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.Size = UDim2.fromScale(0.88, 1);
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.Text = string.upper(v25);
    TextLabel4.TextColor3 = v33;
    TextLabel4.FontFace = Font_new_ret2;
    TextLabel4.TextScaled = true;
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel4.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel4.LayoutOrder = 2;
    TextLabel4.Parent = Frame3;

    if v27 then
        makeChip(p22, v29, 3, v27.text, v27.color).Name = "StaffChip";
    end;

    if v28 then
        makeChip(p22, v30, 4, u7.text, u7.color).Name = "PreAlphaChip";
    end;

    if v26 then
        local Frame5 = Instance.new("Frame");
        Frame5.Name = "SupporterChip";
        Frame5.Size = UDim2.fromScale(v31, 0.9);
        Frame5.BackgroundTransparency = 1;
        Frame5.LayoutOrder = 5;
        Frame5.Parent = p22;
        local Frame6 = Instance.new("Frame");
        Frame6.Size = UDim2.fromScale(0.7, 0.75);
        Frame6.AnchorPoint = Vector2.new(0.5, 0);
        Frame6.Position = UDim2.fromScale(0.5, 0);
        Frame6.BackgroundColor3 = v26.color;
        Frame6.BorderSizePixel = 0;
        Frame6.Parent = Frame5;
        local UICorner2 = Instance.new("UICorner");
        UICorner2.CornerRadius = UDim.new(0.2, 0);
        UICorner2.Parent = Frame6;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(0, 0, 0);
        UIStroke.Thickness = 1;
        UIStroke.Transparency = 0.5;
        UIStroke.Parent = Frame6;
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.Size = UDim2.fromScale(1, 1);
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.Text = v26.initial;
        TextLabel5.TextColor3 = Color3.fromRGB(20, 22, 20);
        TextLabel5.FontFace = Font_new_ret;
        TextLabel5.TextScaled = true;
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Center;
        TextLabel5.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel5.Parent = Frame6;
        local TextLabel6 = Instance.new("TextLabel");
        TextLabel6.Size = UDim2.fromScale(1, 0.22);
        TextLabel6.Position = UDim2.fromScale(0, 0.78);
        TextLabel6.BackgroundTransparency = 1;
        TextLabel6.Text = v26.label;
        TextLabel6.TextColor3 = v26.color;
        TextLabel6.FontFace = Font_new_ret2;
        TextLabel6.TextScaled = true;
        TextLabel6.TextXAlignment = Enum.TextXAlignment.Center;
        TextLabel6.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel6.Parent = Frame5;
    end;
end;

local function buildNameplate(u34) -- Line: 418
    -- upvalues: LocalPlayer (copy), destroyNameplate (copy), u16 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), paintPlate (copy), u17 (copy)
    if u34 == LocalPlayer then
        return;
    end;

    destroyNameplate(u34);
    local Character = u34.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10);

    if not HumanoidRootPart or HumanoidRootPart.Parent ~= Character then
        return;
    end;

    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "PlayerNameplate";
    BillboardGui.Adornee = HumanoidRootPart;
    BillboardGui.Size = UDim2.fromScale(2.5, 0.5);
    BillboardGui.StudsOffset = Vector3.new(0, 3.4, 0);
    BillboardGui.AlwaysOnTop = false;
    BillboardGui.LightInfluence = 0;
    BillboardGui.ClipsDescendants = false;
    BillboardGui.ResetOnSpawn = false;
    BillboardGui.MaxDistance = 100;
    BillboardGui.Enabled = u16;
    BillboardGui.Parent = HumanoidRootPart;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3_fromRGB_ret;
    Frame.BackgroundTransparency = 0.15;
    Frame.BorderSizePixel = 0;
    Frame.Parent = BillboardGui;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 6);
    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret2;
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 0.3;
    UIStroke.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0.015, 0);
    UIPadding.PaddingRight = UDim.new(0.015, 0);
    UIPadding.PaddingTop = UDim.new(0.05, 0);
    UIPadding.PaddingBottom = UDim.new(0.05, 0);
    UIPadding.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.Padding = UDim.new(0.015, 0);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = Frame;
    paintPlate(Frame, u34);

    local function repaint() -- Line: 470
        -- upvalues: Frame (copy), paintPlate (ref), u34 (copy)
        if Frame.Parent then
            paintPlate(Frame, u34);
        end;
    end;

    local v35 = {};

    for _, v in ipairs({ "PlayerRank", "Faction", "_SupporterTier", "_Staff", "_PreAlpha" }) do
        local AttributeChangedSignal = u34:GetAttributeChangedSignal(v);
        table.insert(v35, AttributeChangedSignal:Connect(repaint));
    end;

    local PropertyChangedSignal = u34:GetPropertyChangedSignal("DisplayName");
    table.insert(v35, PropertyChangedSignal:Connect(repaint));
    u17[u34] = {
        gui = BillboardGui,
        attributeConns = v35
    };
end;

local function hookPlayer(u36) -- Line: 480
    -- upvalues: buildNameplate (copy), destroyNameplate (copy)
    if u36.Character then
        task.spawn(buildNameplate, u36);
    end;

    u36.CharacterAdded:Connect(function(p37) -- Line: 486
        -- upvalues: buildNameplate (ref), u36 (copy)
        p37:WaitForChild("HumanoidRootPart", 10);
        buildNameplate(u36);
    end);
    u36.CharacterRemoving:Connect(function() -- Line: 490
        -- upvalues: destroyNameplate (ref), u36 (copy)
        destroyNameplate(u36);
    end);
end;

for _, v in ipairs(Players:GetPlayers()) do
    hookPlayer(v);
end;

Players.PlayerAdded:Connect(hookPlayer);
Players.PlayerRemoving:Connect(destroyNameplate);
print("[PlayerNameplate] initialized");