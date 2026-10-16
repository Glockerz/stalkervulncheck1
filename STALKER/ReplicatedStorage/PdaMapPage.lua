-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Workspace");
local PdaMapData = require(ReplicatedStorage:WaitForChild("PdaMapData"));
local PdaMapBlipFactory = require(ReplicatedStorage:WaitForChild("PdaMapBlipFactory"));
local TaskTargetResolver = require(ReplicatedStorage:WaitForChild("TaskTargetResolver"));
local SquadMapResolver = require(ReplicatedStorage:WaitForChild("SquadMapResolver"));
local DeathMarkerResolver = require(ReplicatedStorage:WaitForChild("DeathMarkerResolver"));
local SquadMarkerResolver = require(ReplicatedStorage:WaitForChild("SquadMarkerResolver"));
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));
local v1 = nil;
local PatrolSightingResolver = ReplicatedStorage:FindFirstChild("PatrolSightingResolver");
local u2;

if PatrolSightingResolver then
    local v3;
    v3, u2 = pcall(require, PatrolSightingResolver);

    if not v3 then
        u2 = v1;
    end;
else
    u2 = v1;
end;

local LocalPlayer = Players.LocalPlayer;
local v4 = {};
local u5 = {
    bandit = "rbxassetid://90929298556934",
    mutant = "rbxassetid://98949484501928",
    default = "rbxassetid://128212304073017"
};

local function plumsRoot() -- Line: 80
    -- upvalues: LocalPlayer (copy)
    local v6 = LocalPlayer and LocalPlayer:FindFirstChild("PlayerScripts");
    local v7 = v6 and v6:FindFirstChild("PlumsMinimapV2");

    if v7 then
        return v7;
    end;

    local StarterPlayerScripts = game:GetService("StarterPlayer"):FindFirstChild("StarterPlayerScripts");

    if StarterPlayerScripts then
        return StarterPlayerScripts:FindFirstChild("PlumsMinimapV2");
    end;

    return nil;
end;

local function applyPlumsSettings(p8) -- Line: 91
    -- upvalues: plumsRoot (copy)
    if not p8 then
        return;
    end;

    local v9 = plumsRoot();

    if not v9 then
        return;
    end;

    local GeneralSettings = v9:FindFirstChild("GeneralSettings");

    if not GeneralSettings then
        return;
    end;

    GeneralSettings.DontRotate.Value = true;
    GeneralSettings.OpenFullMapWithClick.Value = false;
    GeneralSettings.Zoom.Value = p8.DefaultZoom;
    local Maps = v9:FindFirstChild("Maps");

    if Maps then
        Maps = Maps:FindFirstChild(p8.PlumsMap);
    end;

    if Maps then
        GeneralSettings.CurrentMap.Value = Maps;
    end;
end;

local function computeMDN(p10) -- Line: 109
    local v11 = 2048;

    for _, child in ipairs(p10:GetChildren()) do
        local Size = child:FindFirstChild("Size");

        if Size and Size:IsA("Vector3Value") then
            v11 = math.max(v11, Size.Value.X, Size.Value.Z);
        end;
    end;

    return math.max(1, v11 / 2048);
end;

local function computeBounds(p12) -- Line: 126
    local v13 = (1 / 0);
    local v14 = (-1 / 0);
    local v15 = (1 / 0);
    local v16 = (-1 / 0);

    for _, child in ipairs(p12:GetChildren()) do
        local Position = child:FindFirstChild("Position");
        local Size = child:FindFirstChild("Size");

        if Position and (Position:IsA("Vector3Value") and (Size and Size:IsA("Vector3Value"))) then
            local v17 = Size.Value.X / 2;
            local v18 = Size.Value.Z / 2;
            v13 = math.min(v13, Position.Value.X - v17);
            v14 = math.max(v14, Position.Value.X + v17);
            v15 = math.min(v15, Position.Value.Z - v18);
            v16 = math.max(v16, Position.Value.Z + v18);
        end;
    end;

    return {
        minX = v13 - 400,
        maxX = v14 + 400,
        minZ = v15 - 400,
        maxZ = v16 + 400
    };
end;

local function buildControls(p19, p20) -- Line: 147
    local Frame = Instance.new("Frame");
    Frame.Name = "MapControls";
    Frame.AnchorPoint = Vector2.new(0, 1);
    Frame.Position = UDim2.new(0, 8, 1, -8);
    Frame.Size = UDim2.fromOffset(132, 40);
    Frame.BackgroundColor3 = Color3.fromRGB(20, 22, 20);
    Frame.BackgroundTransparency = 0.25;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 1200;
    Frame.Parent = p19;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 4);
    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(85, 80, 72);
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 0.2;
    UIStroke.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 6);
    UIPadding.PaddingRight = UDim.new(0, 6);
    UIPadding.Parent = Frame;

    local function makeButton(p21, p22, p23) -- Line: 177
        -- upvalues: Frame (copy)
        local TextButton = Instance.new("TextButton");
        TextButton.Size = UDim2.fromOffset(32, 32);
        TextButton.BackgroundColor3 = Color3.fromRGB(40, 42, 40);
        TextButton.BackgroundTransparency = 0.1;
        TextButton.BorderSizePixel = 0;
        TextButton.Text = p21;
        TextButton.TextSize = 22;
        TextButton.TextColor3 = Color3.fromRGB(220, 220, 220);
        TextButton.Font = Enum.Font.SourceSansBold;
        TextButton.AutoButtonColor = true;
        TextButton.LayoutOrder = p22;
        TextButton.ZIndex = 1201;
        TextButton.Parent = Frame;
        local UICorner2 = Instance.new("UICorner");
        UICorner2.CornerRadius = UDim.new(0, 3);
        UICorner2.Parent = TextButton;
        TextButton.MouseButton1Click:Connect(p23);

        return TextButton;
    end;

    makeButton("−", 1, p20.zoomOut);
    makeButton("+", 2, p20.zoomIn);
    makeButton("◉", 3, p20.recenter);
end;

local function buildLocationOverlay(p24, p25) -- Line: 205
    local Frame = Instance.new("Frame");
    Frame.Name = "LocationOverlay";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 400;
    Frame.ClipsDescendants = true;
    Frame.Parent = p24;
    local v26 = {};

    for _, v in ipairs(p25.Locations or {}) do
        local Frame2 = Instance.new("Frame");
        Frame2.Name = v.Name;
        Frame2.BackgroundTransparency = 1;
        Frame2.BorderSizePixel = 0;
        Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame2.ZIndex = 400;
        Frame2.Parent = Frame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0.5, 0);
        UICorner.Parent = Frame2;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(255, 200, 90);
        UIStroke.Thickness = 2;
        UIStroke.Transparency = 0.2;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = Frame2;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "Label";
        TextLabel.BackgroundTransparency = 1;
        TextLabel.AnchorPoint = Vector2.new(0.5, 0);
        TextLabel.Position = UDim2.new(0.5, 0, 1, 2);
        TextLabel.Size = UDim2.fromOffset(180, 14);
        TextLabel.TextSize = 12;
        TextLabel.TextColor3 = Color3.fromRGB(255, 220, 160);
        TextLabel.TextStrokeTransparency = 0.3;
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
        TextLabel.Font = Enum.Font.SourceSansSemibold;
        TextLabel.Text = string.upper(v.Name);
        TextLabel.ZIndex = 401;
        TextLabel.Parent = Frame2;
        table.insert(v26, {
            ring = Frame2,
            entry = v,
            label = TextLabel
        });
    end;

    return Frame, v26;
end;

local function buildSightingOverlay(p27) -- Line: 256
    local Frame = Instance.new("Frame");
    Frame.Name = "PatrolSightingOverlay";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 450;
    Frame.ClipsDescendants = true;
    Frame.Parent = p27;
    local v28 = {};

    for i = 1, 4 do
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "Sighting" .. i;
        Frame2.BackgroundColor3 = Color3.fromRGB(235, 235, 245);
        Frame2.BackgroundTransparency = 0.88;
        Frame2.BorderSizePixel = 0;
        Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame2.ZIndex = 450;
        Frame2.Visible = false;
        Frame2.Parent = Frame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0.5, 0);
        UICorner.Parent = Frame2;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(235, 235, 245);
        UIStroke.Thickness = 2;
        UIStroke.Transparency = 0.15;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = Frame2;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "Label";
        TextLabel.BackgroundTransparency = 1;
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.Position = UDim2.fromScale(0.5, 0.5);
        TextLabel.Size = UDim2.fromOffset(180, 14);
        TextLabel.TextSize = 12;
        TextLabel.TextColor3 = Color3.fromRGB(245, 245, 250);
        TextLabel.TextStrokeTransparency = 0.3;
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
        TextLabel.Font = Enum.Font.SourceSansBold;
        TextLabel.Text = "";
        TextLabel.ZIndex = 451;
        TextLabel.Parent = Frame2;
        table.insert(v28, {
            ring = Frame2,
            stroke = UIStroke,
            label = TextLabel
        });
        local _ = i;
    end;

    return Frame, v28;
end;

local function buildTaskOverlay(p29) -- Line: 307
    -- upvalues: TaskTargetResolver (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "TaskTargetOverlay";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ClipsDescendants = true;
    Frame.ZIndex = 700;
    Frame.Parent = p29;
    local v30 = {};

    for i = 1, 32 do
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "TaskMarker" .. i;
        ImageLabel.Size = UDim2.fromOffset(18, 18);
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://128212304073017";
        ImageLabel.ImageColor3 = TaskTargetResolver.COLOR_KILL;
        ImageLabel.ScaleType = Enum.ScaleType.Fit;
        ImageLabel.BorderSizePixel = 0;
        ImageLabel.Visible = false;
        ImageLabel.ZIndex = 700;
        ImageLabel.Parent = Frame;
        v30[i] = ImageLabel;
        local _ = i;
    end;

    return Frame, v30;
end;

local function buildSquadOverlay(p31) -- Line: 339
    local Frame = Instance.new("Frame");
    Frame.Name = "SquadOverlay";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ClipsDescendants = true;
    Frame.ZIndex = 800;
    Frame.Parent = p31;
    local v32 = {};

    for i = 1, 8 do
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "SquadMarker" .. i;
        ImageLabel.Size = UDim2.fromOffset(18, 18);
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://99845298560940";
        ImageLabel.ScaleType = Enum.ScaleType.Fit;
        ImageLabel.BorderSizePixel = 0;
        ImageLabel.Visible = false;
        ImageLabel.ZIndex = 800;
        ImageLabel.Parent = Frame;
        v32[i] = ImageLabel;
        local _ = i;
    end;

    return Frame, v32;
end;

local function buildDeathOverlay(p33) -- Line: 373
    -- upvalues: DeathMarkerResolver (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "DeathOverlay";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ClipsDescendants = true;
    Frame.ZIndex = 750;
    Frame.Parent = p33;
    local v34 = {};

    for i = 1, 8 do
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "DeathMarker" .. i;
        Frame2.Size = UDim2.fromOffset(18, 18);
        Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame2.BackgroundTransparency = 1;
        Frame2.Visible = false;
        Frame2.ZIndex = 750;
        Frame2.Parent = Frame;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Icon";
        ImageLabel.Size = UDim2.fromScale(1, 1);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://130059527035420";
        ImageLabel.ImageColor3 = DeathMarkerResolver.COLOR;
        ImageLabel.ScaleType = Enum.ScaleType.Fit;
        ImageLabel.ZIndex = 750;
        ImageLabel.Parent = Frame2;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "Time";
        TextLabel.AnchorPoint = Vector2.new(0.5, 0);
        TextLabel.Position = UDim2.new(0.5, 0, 1, 1);
        TextLabel.Size = UDim2.fromOffset(44, 14);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.TextSize = 12;
        TextLabel.Font = Enum.Font.SourceSansSemibold;
        TextLabel.TextColor3 = DeathMarkerResolver.COLOR;
        TextLabel.TextStrokeTransparency = 0.3;
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
        TextLabel.ZIndex = 751;
        TextLabel.Parent = Frame2;
        v34[i] = Frame2;
        local _ = i;
    end;

    return Frame, v34;
end;

local function buildSquadMarkOverlay(p35) -- Line: 436
    local Frame = Instance.new("Frame");
    Frame.Name = "SquadMarkOverlay";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ClipsDescendants = true;
    Frame.ZIndex = 760;
    Frame.Parent = p35;
    local v36 = {};

    for i = 1, 4 do
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "SquadMark" .. i;
        TextLabel.Size = UDim2.fromOffset(16, 16);
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = "◆";
        TextLabel.TextScaled = true;
        TextLabel.Font = Enum.Font.GothamBold;
        TextLabel.TextStrokeTransparency = 0.2;
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
        TextLabel.Visible = false;
        TextLabel.ZIndex = 760;
        TextLabel.Parent = Frame;
        v36[i] = TextLabel;
        local _ = i;
    end;

    return Frame, v36;
end;

local u37 = false;
local u38 = nil;

function v4.IsPointerOverMap() -- Line: 469
    -- upvalues: u37 (ref), u38 (ref)
    local v39 = u37;

    if v39 then
        if u38 == nil or u38.Parent == nil then
            v39 = false;
        else
            v39 = u38.Parent:IsA("GuiObject") and u38.Parent.Visible;
        end;
    end;

    return v39;
end;

function v4.Build(p40) -- Line: 474
    -- upvalues: LocalPlayer (copy), PdaMapData (copy), PlaceConfig (copy), applyPlumsSettings (copy), CollectionService (copy), PdaMapBlipFactory (copy), plumsRoot (copy), computeMDN (copy), computeBounds (copy), buildLocationOverlay (copy), buildSightingOverlay (copy), buildTaskOverlay (copy), buildSquadOverlay (copy), buildDeathOverlay (copy), buildSquadMarkOverlay (copy), u38 (ref), u37 (ref), SquadMarkerResolver (copy), UserInputService (copy), buildControls (copy), RunService (copy), u2 (ref), ReplicatedStorage (copy), TaskTargetResolver (copy), u5 (copy), SquadMapResolver (copy), DeathMarkerResolver (copy)
    if not (p40 and p40:IsA("GuiObject")) then
        return;
    end;

    if p40:FindFirstChild("MapHost") then
        return;
    end;

    local v41 = LocalPlayer:GetAttribute("Zone") or PdaMapData.CurrentZone();
    local Region = PdaMapData.GetRegion(v41);

    if not (PlaceConfig.HasMapData and Region) then
        local Frame = Instance.new("Frame");
        Frame.Name = "MapHost";
        Frame.Size = UDim2.fromScale(1, 1);
        Frame.BackgroundColor3 = Color3.fromRGB(18, 20, 18);
        Frame.BorderSizePixel = 0;
        Frame.Parent = p40;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "NoDataLabel";
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.Position = UDim2.fromScale(0.5, 0.48);
        TextLabel.Size = UDim2.fromOffset(360, 80);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = "NO DATA";
        TextLabel.TextColor3 = Color3.fromRGB(180, 180, 180);
        TextLabel.Font = Enum.Font.Code;
        TextLabel.TextSize = 64;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
        TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel.Parent = Frame;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = "SubLabel";
        TextLabel2.AnchorPoint = Vector2.new(0.5, 0);
        TextLabel2.Position = UDim2.fromScale(0.5, 0.58);
        TextLabel2.Size = UDim2.fromOffset(500, 22);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.Text = PlaceConfig.HasMapData and "NO BAKED MAP DATA FOR THIS ZONE" or "MAP UNAVAILABLE IN STAGING AREA";
        TextLabel2.TextColor3 = Color3.fromRGB(110, 110, 110);
        TextLabel2.Font = Enum.Font.Gotham;
        TextLabel2.TextSize = 14;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Center;
        TextLabel2.Parent = Frame;

        return;
    end;

    applyPlumsSettings(Region);
    local Frame = Instance.new("Frame");
    Frame.Name = "MapHost";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.fromRGB(18, 20, 18);
    Frame.BackgroundTransparency = 0;
    Frame.BorderSizePixel = 0;
    Frame.Active = true;
    Frame.Parent = p40;
    CollectionService:AddTag(Frame, "Minimap");
    PdaMapBlipFactory.Attach(Frame);
    local v42 = plumsRoot();
    local v43;

    if v42 then
        v43 = v42:WaitForChild("Maps", 5):WaitForChild(Region.PlumsMap, 5);
    else
        v43 = v42;
    end;

    local u44 = v43 and (computeMDN(v43) or 1) or 1;
    local u45 = v43 and computeBounds(v43) or nil;
    local _, u46 = buildLocationOverlay(Frame, Region);
    local _, u47 = buildSightingOverlay(Frame);
    local _, u48 = buildTaskOverlay(Frame);
    local _, u49 = buildSquadOverlay(Frame);
    local _, u50 = buildDeathOverlay(Frame);
    local _, u51 = buildSquadMarkOverlay(Frame);
    u38 = Frame;
    Frame.MouseEnter:Connect(function() -- Line: 565
        -- upvalues: u37 (ref)
        u37 = true;
    end);
    Frame.MouseLeave:Connect(function() -- Line: 566
        -- upvalues: u37 (ref)
        u37 = false;
    end);
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "MarkMenu";
    Frame2.BackgroundColor3 = Color3.fromRGB(20, 24, 20);
    Frame2.BackgroundTransparency = 0.1;
    Frame2.BorderSizePixel = 0;
    Frame2.Visible = false;
    Frame2.ZIndex = 1300;
    Frame2.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(120, 140, 110);
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame2;
    local u52 = nil;

    local function closeMarkMenu() -- Line: 580
        -- upvalues: Frame2 (copy), u52 (ref)
        Frame2.Visible = false;
        u52 = nil;
    end;

    local u53 = {};

    local function addRow(p54, u55) -- Line: 585
        -- upvalues: Frame2 (copy), u52 (ref), u53 (copy)
        local TextButton = Instance.new("TextButton");
        TextButton.Name = p54;
        TextButton.Size = UDim2.new(1, 0, 0, 26);
        TextButton.BackgroundTransparency = 1;
        TextButton.Text = p54;
        TextButton.TextSize = 14;
        TextButton.Font = Enum.Font.SourceSansSemibold;
        TextButton.TextColor3 = Color3.fromRGB(220, 230, 210);
        TextButton.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton.ZIndex = 1301;
        local UIPadding = Instance.new("UIPadding");
        UIPadding.PaddingLeft = UDim.new(0, 10);
        UIPadding.Parent = TextButton;
        TextButton.MouseButton1Click:Connect(function() -- Line: 599
            -- upvalues: u55 (copy), Frame2 (ref), u52 (ref)
            u55();
            Frame2.Visible = false;
            u52 = nil;
        end);
        TextButton.Parent = Frame2;
        u53[p54] = TextButton;
    end;

    addRow("Mark here", function() -- Line: 606
        -- upvalues: u52 (ref), SquadMarkerResolver (ref)
        if u52 then
            SquadMarkerResolver.Place(u52.X, u52.Z);
        end;
    end);
    addRow("Remove my marker", function() -- Line: 609
        -- upvalues: SquadMarkerResolver (ref)
        SquadMarkerResolver.Remove();
    end);
    addRow("Cancel", function() -- Line: 612
    end);

    local function openMarkMenu(p56, p57) -- Line: 613
        -- upvalues: u52 (ref), SquadMarkerResolver (ref), u53 (copy), Frame (copy), Frame2 (copy)
        u52 = p57;
        local v58 = SquadMarkerResolver.GetMine() ~= nil;
        u53["Remove my marker"].Visible = v58;
        local v59 = 0;

        for _, v in ipairs({ "Mark here", "Remove my marker", "Cancel" }) do
            local v60 = u53[v];

            if v60.Visible then
                v60.Position = UDim2.fromOffset(0, v59);
                v59 = v59 + 26;
            end;
        end;

        local AbsoluteSize = Frame.AbsoluteSize;
        Frame2.Size = UDim2.fromOffset(150, v59);
        local v61 = Frame:FindFirstAncestor("MainFrame");
        local v62 = v61 and tonumber(v61:GetAttribute("RenderScale")) or 1;
        local v63 = p56.X / v62;
        local math_max_ret = math.max(0, AbsoluteSize.X / v62 - 150);
        local math_clamp_ret = math.clamp(v63, 0, math_max_ret);
        local v64 = p56.Y / v62;
        local math_max_ret2 = math.max(0, AbsoluteSize.Y / v62 - v59);
        local math_clamp_ret2 = math.clamp(v64, 0, math_max_ret2);
        Frame2.Position = UDim2.fromOffset(math_clamp_ret, math_clamp_ret2);
        Frame2.Visible = true;
    end;

    local u65 = nil;

    local function getCurrentFocus() -- Line: 641
        -- upvalues: u65 (ref), LocalPlayer (ref)
        if u65 then
            return u65;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        return Character and Character.Position or Vector3.new(0, 0, 0);
    end;

    local function getZoom() -- Line: 647
        -- upvalues: Frame (copy), Region (copy)
        return Frame:GetAttribute("Zoom") or Region.DefaultZoom;
    end;

    local function clampFocus(p66) -- Line: 653
        -- upvalues: u45 (copy), Frame (copy), Region (copy), u44 (copy)
        if not u45 then
            return p66;
        end;

        local AbsoluteSize = Frame.AbsoluteSize;

        if AbsoluteSize.Y < 1 then
            return p66;
        end;

        local v67 = (Frame:GetAttribute("Zoom") or Region.DefaultZoom) * 0.7002075382097097 * u44;
        local v68 = v67 * (AbsoluteSize.X / AbsoluteSize.Y);
        local v69 = (u45.minX + u45.maxX) / 2;
        local v70 = (u45.minZ + u45.maxZ) / 2;
        local X = p66.X;

        if u45.maxX - v68 >= u45.minX + v68 then
            v69 = math.clamp(X, u45.minX + v68, u45.maxX - v68);
        end;

        local Z = p66.Z;

        if u45.maxZ - v67 >= u45.minZ + v67 then
            v70 = math.clamp(Z, u45.minZ + v67, u45.maxZ - v67);
        end;

        return Vector3.new(v69, p66.Y, v70);
    end;

    local function setFocus(p71) -- Line: 675
        -- upvalues: clampFocus (copy), u65 (ref), Frame (copy)
        if not p71 then
            u65 = nil;
            Frame:SetAttribute("FocusPoint", nil);

            return;
        end;

        local v72 = clampFocus(p71);
        u65 = v72;
        Frame:SetAttribute("FocusPoint", v72);
    end;

    local function setZoom(p73) -- Line: 685
        -- upvalues: Frame (copy), u65 (ref), clampFocus (copy)
        Frame:SetAttribute("Zoom", (math.clamp(p73, 100, 500)));

        if u65 then
            local v74 = u65;

            if v74 then
                local v75 = clampFocus(v74);
                u65 = v75;
                Frame:SetAttribute("FocusPoint", v75);

                return;
            end;

            u65 = nil;
            Frame:SetAttribute("FocusPoint", nil);
        end;
    end;

    Frame:SetAttribute("Zoom", (math.clamp(Region.DefaultZoom, 100, 500)));

    if u65 then
        local v76 = u65;

        if v76 then
            local v77 = clampFocus(v76);
            u65 = v77;
            Frame:SetAttribute("FocusPoint", v77);
        else
            u65 = nil;
            Frame:SetAttribute("FocusPoint", nil);
        end;
    end;

    local u78 = v42 and v42:WaitForChild("Internal", 5) and v42.Internal:WaitForChild("CameraUtils", 5);

    if u78 then
        u78 = require(u78);
    end;

    local u79 = false;
    local Vector2_zero = Vector2.zero;
    local u80 = false;
    Frame.InputBegan:Connect(function(p81) -- Line: 709
        -- upvalues: u79 (ref), u80 (ref), Frame2 (copy), u52 (ref), Frame (copy), u78 (copy), openMarkMenu (copy), u44 (copy)
        if p81.UserInputType == Enum.UserInputType.MouseButton1 then
            u79 = true;
            u80 = true;

            if Frame2.Visible then
                local Vector2_new_ret = Vector2.new(p81.Position.X, p81.Position.Y);
                local AbsolutePosition = Frame2.AbsolutePosition;
                local AbsoluteSize = Frame2.AbsoluteSize;

                if Vector2_new_ret.X < AbsolutePosition.X or (Vector2_new_ret.Y < AbsolutePosition.Y or (Vector2_new_ret.X > AbsolutePosition.X + AbsoluteSize.X or Vector2_new_ret.Y > AbsolutePosition.Y + AbsoluteSize.Y)) then
                    Frame2.Visible = false;
                    u52 = nil;
                end;
            end;
        elseif p81.UserInputType == Enum.UserInputType.MouseButton2 then
            local v82 = Frame:FindFirstChildWhichIsA("ViewportFrame", true);

            if v82 then
                v82 = v82:FindFirstChildOfClass("Camera");
            end;

            local AbsoluteSize = Frame.AbsoluteSize;

            if not (v82 and (u78 and (AbsoluteSize.X > 0 and AbsoluteSize.Y > 0))) then
                return;
            end;

            local v83 = Vector2.new(p81.Position.X, p81.Position.Y) - Frame.AbsolutePosition;
            local v84 = u78.ViewportPointToPlanePoint(v82.CFrame, 70, v83, AbsoluteSize, 0);
            openMarkMenu(v83, (Vector3.new(v84.X * u44, 0, v84.Z * u44)));
        end;
    end);
    Frame.InputEnded:Connect(function(p85) -- Line: 734
        -- upvalues: u79 (ref)
        if p85.UserInputType == Enum.UserInputType.MouseButton1 then
            u79 = false;
        end;
    end);
    UserInputService.InputChanged:Connect(function(p86, p87) -- Line: 739
        -- upvalues: Frame (copy), u79 (ref), u80 (ref), Vector2_zero (ref), u78 (copy), u44 (copy), u65 (ref), LocalPlayer (ref), clampFocus (copy)
        if not (Frame.Parent and u79) then
            return;
        end;

        if p86.UserInputType ~= Enum.UserInputType.MouseMovement then
            return;
        end;

        local Vector2_new_ret = Vector2.new(p86.Position.X, p86.Position.Y);

        if u80 then
            u80 = false;
            Vector2_zero = Vector2_new_ret;

            return;
        end;

        local v88 = Frame:FindFirstChildWhichIsA("ViewportFrame", true);

        if v88 then
            v88 = v88:FindFirstChildOfClass("Camera");
        end;

        local AbsoluteSize = Frame.AbsoluteSize;

        if not (v88 and (u78 and (AbsoluteSize.X > 0 and AbsoluteSize.Y > 0))) then
            Vector2_zero = Vector2_new_ret;

            return;
        end;

        local AbsolutePosition = Frame.AbsolutePosition;
        local CFrame = v88.CFrame;
        local v89 = u78.ViewportPointToPlanePoint(CFrame, 70, Vector2_zero - AbsolutePosition, AbsoluteSize, 0);
        local v90 = u78.ViewportPointToPlanePoint(CFrame, 70, Vector2_new_ret - AbsolutePosition, AbsoluteSize, 0);
        local v91 = Vector3.new(v89.X * u44, 0, v89.Z * u44) - Vector3.new(v90.X * u44, 0, v90.Z * u44);
        local v92;

        if u65 then
            v92 = u65;
        else
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            v92 = Character and Character.Position or Vector3.new(0, 0, 0);
        end;

        local v93 = v92 + v91;

        if v93 then
            local v94 = clampFocus(v93);
            u65 = v94;
            Frame:SetAttribute("FocusPoint", v94);
        else
            u65 = nil;
            Frame:SetAttribute("FocusPoint", nil);
        end;

        Vector2_zero = Vector2_new_ret;
    end);
    Frame.MouseWheelForward:Connect(function() -- Line: 768
        -- upvalues: Frame (copy), Region (copy), u65 (ref), clampFocus (copy)
        local v95 = Frame:GetAttribute("Zoom") or Region.DefaultZoom;
        Frame:SetAttribute("Zoom", (math.clamp(v95 - 75, 100, 500)));

        if u65 then
            local v96 = u65;

            if v96 then
                local v97 = clampFocus(v96);
                u65 = v97;
                Frame:SetAttribute("FocusPoint", v97);

                return;
            end;

            u65 = nil;
            Frame:SetAttribute("FocusPoint", nil);
        end;
    end);
    Frame.MouseWheelBackward:Connect(function() -- Line: 769
        -- upvalues: Frame (copy), Region (copy), u65 (ref), clampFocus (copy)
        local v98 = Frame:GetAttribute("Zoom") or Region.DefaultZoom;
        Frame:SetAttribute("Zoom", (math.clamp(v98 + 75, 100, 500)));

        if u65 then
            local v99 = u65;

            if v99 then
                local v100 = clampFocus(v99);
                u65 = v100;
                Frame:SetAttribute("FocusPoint", v100);

                return;
            end;

            u65 = nil;
            Frame:SetAttribute("FocusPoint", nil);
        end;
    end);
    buildControls(Frame, {
        zoomIn = function() -- Line: 773, Name: zoomIn
            -- upvalues: Frame (copy), Region (copy), u65 (ref), clampFocus (copy)
            local v101 = Frame:GetAttribute("Zoom") or Region.DefaultZoom;
            Frame:SetAttribute("Zoom", (math.clamp(v101 - 150, 100, 500)));

            if u65 then
                local v102 = u65;

                if v102 then
                    local v103 = clampFocus(v102);
                    u65 = v103;
                    Frame:SetAttribute("FocusPoint", v103);

                    return;
                end;

                u65 = nil;
                Frame:SetAttribute("FocusPoint", nil);
            end;
        end,

        zoomOut = function() -- Line: 774, Name: zoomOut
            -- upvalues: Frame (copy), Region (copy), u65 (ref), clampFocus (copy)
            local v104 = Frame:GetAttribute("Zoom") or Region.DefaultZoom;
            Frame:SetAttribute("Zoom", (math.clamp(v104 + 150, 100, 500)));

            if u65 then
                local v105 = u65;

                if v105 then
                    local v106 = clampFocus(v105);
                    u65 = v106;
                    Frame:SetAttribute("FocusPoint", v106);

                    return;
                end;

                u65 = nil;
                Frame:SetAttribute("FocusPoint", nil);
            end;
        end,

        recenter = function() -- Line: 775, Name: recenter
            -- upvalues: u65 (ref), Frame (copy)
            u65 = nil;
            Frame:SetAttribute("FocusPoint", nil);
        end
    });
    local u107 = nil;
    u107 = RunService.RenderStepped:Connect(function() -- Line: 783
        -- upvalues: Frame (copy), u107 (ref), u78 (copy), Region (copy), u44 (copy), u46 (copy), u2 (ref), u47 (copy), ReplicatedStorage (ref), TaskTargetResolver (ref), PdaMapBlipFactory (ref), u48 (copy), u5 (ref), SquadMapResolver (ref), u49 (copy), DeathMarkerResolver (ref), u50 (copy), Frame2 (copy), UserInputService (ref), u52 (ref), SquadMarkerResolver (ref), u51 (copy)
        if not Frame.Parent then
            if u107 then
                u107:Disconnect();
            end;

            return;
        end;

        local v108 = Frame:FindFirstChildWhichIsA("ViewportFrame", true);
        local v109;

        if v108 then
            v109 = v108:FindFirstChildOfClass("Camera");
        else
            v109 = v108;
        end;

        if not (v108 and (v109 and u78)) then
            return;
        end;

        local AbsoluteSize = Frame.AbsoluteSize;

        if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
            return;
        end;

        local CFrame = v109.CFrame;
        local v110 = 2 * (Frame:GetAttribute("Zoom") or Region.DefaultZoom) * 0.7002075382097097 * u44;

        for _, v in ipairs(u46) do
            local WorldPos = v.entry.WorldPos;
            local Vector3_new_ret = Vector3.new(WorldPos.X / u44, 0, WorldPos.Z / u44);
            local v111 = u78.PointToViewport(CFrame, 70, Vector3_new_ret, AbsoluteSize);
            local v112 = v111.X / AbsoluteSize.X;
            local v113 = v111.Y / AbsoluteSize.Y;
            v.ring.Position = UDim2.fromScale(v112, v113);
            local v114 = math.max(v.entry.Size.X, v.entry.Size.Z) / v110 * AbsoluteSize.Y;
            local math_max_ret = math.max(v114, 28);
            v.ring.Size = UDim2.fromOffset(math_max_ret, math_max_ret);
            local v115;

            if v112 > -1 and (v112 < 2 and v113 > -1) then
                v115 = v113 < 2;
            else
                v115 = false;
            end;

            v.ring.Visible = v115;
        end;

        local v116 = u2 and u2.Resolve() or {};

        for i, v in ipairs(u47) do
            local v117 = v116[i];

            if v117 then
                local Vector3_new_ret = Vector3.new(v117.center.X / u44, 0, v117.center.Z / u44);
                local v118 = u78.PointToViewport(CFrame, 70, Vector3_new_ret, AbsoluteSize);
                local v119 = v118.X / AbsoluteSize.X;
                local v120 = v118.Y / AbsoluteSize.Y;
                local math_max_ret = math.max(v117.radius * 2 / v110 * AbsoluteSize.Y, 36);
                v.ring.Position = UDim2.fromScale(v119, v120);
                v.ring.Size = UDim2.fromOffset(math_max_ret, math_max_ret);
                v.label.Text = v117.label;
                v.stroke.Color = v117.color;
                v.ring.BackgroundColor3 = v117.color;
                v.ring.BackgroundTransparency = 1 - 0.12 * v117.alpha;
                v.stroke.Transparency = 1 - 0.85 * v117.alpha;
                v.label.TextTransparency = 1 - v117.alpha;
                v.label.TextStrokeTransparency = 1 - 0.7 * v117.alpha;
                local v121;

                if v119 > -1 and (v119 < 2 and v120 > -1) then
                    v121 = v120 < 2;
                else
                    v121 = false;
                end;

                v.ring.Visible = v121;
            else
                v.ring.Visible = false;
            end;
        end;

        local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
        local TrackedTask = TaskTargetResolver.GetTrackedTask();
        local v122 = {};

        if TrackedTask then
            for _, v in ipairs(TaskTargetResolver.Resolve(TrackedTask)) do
                v.transparency = 0;
                v122[#v122 + 1] = v;
            end;
        end;

        local v123 = TaskController:GetActiveTasks() or {};

        for _, v in ipairs(v123) do
            if v ~= TrackedTask then
                for _, v2 in ipairs(TaskTargetResolver.Resolve(v)) do
                    v2.transparency = 0.65;
                    v122[#v122 + 1] = v2;
                end;
            end;
        end;

        local v124 = {};
        local v125 = {};

        for _, v in ipairs(v122) do
            if v.kind == "turnin" and v.npcId then
                v124[v.npcId] = true;
            end;
        end;

        for _, v in ipairs(v123) do
            if v.type == "exploration" and v.state == "active" then
                local v126 = v;
                local v127 = false;

                for _, v2 in ipairs(v.objectives or {}) do
                    if v2.id == "visit" and v2.complete then
                        v127 = true;
                        break;
                    end;
                end;

                if not v127 and (v126.params and v126.params.location_name) then
                    for _, v2 in ipairs(Region.Locations or {}) do
                        if v2.Name == v126.params.location_name then
                            v125[v126.id] = {
                                pos = v2.WorldPos,
                                locationName = v2.Name
                            };
                            break;
                        end;
                    end;
                end;
            end;
        end;

        PdaMapBlipFactory.SetExplorationTargets(v125);
        local v128 = {};

        for _, v in ipairs(v123) do
            if v.type == "deposit" and v.state == "active" then
                local v129 = v;
                local v130 = false;

                for _, v2 in ipairs(v.objectives or {}) do
                    if v2.id == "deposit" and v2.complete then
                        v130 = true;
                        break;
                    end;
                end;

                local v131 = v129.params and v129.params.target_stash_pos;

                if not v130 and v131 then
                    v128[v129.id] = {
                        pos = Vector3.new(v131.X or 0, v131.Y or 0, v131.Z or 0)
                    };
                end;
            end;
        end;

        PdaMapBlipFactory.SetDepositTargets(v128);

        for i = 1, 32 do
            local v132 = v122[i];
            local v133 = u48[i];
            local v134;

            if v132 and (v132.kind ~= "turnin" and (v132.kind ~= "explore" and v132.kind ~= "deposit")) then
                local Vector3_new_ret = Vector3.new(v132.pos.X / u44, 0, v132.pos.Z / u44);
                local v135 = u78.PointToViewport(CFrame, 70, Vector3_new_ret, AbsoluteSize);
                local v136 = v135.X / AbsoluteSize.X;
                local v137 = v135.Y / AbsoluteSize.Y;

                if v136 >= 0 and (v136 <= 1 and (v137 >= 0 and v137 <= 1)) then
                    v133.Position = UDim2.fromScale(v136, v137);
                    local v138 = u5[v132.subject] or "rbxassetid://128212304073017";

                    if v133.Image ~= v138 then
                        v133.Image = v138;
                    end;

                    if v133.ImageColor3 ~= v132.color then
                        v133.ImageColor3 = v132.color;
                    end;

                    if v133.ImageTransparency ~= v132.transparency then
                        v133.ImageTransparency = v132.transparency;
                    end;

                    if v133.Visible then
                        v134 = i;
                    else
                        v133.Visible = true;
                        v134 = i;
                    end;
                elseif v133.Visible then
                    v133.Visible = false;
                    v134 = i;
                else
                    v134 = i;
                end;
            elseif v133.Visible then
                v133.Visible = false;
                v134 = i;
            else
                v134 = i;
            end;
        end;

        local COLOR_TURN_IN = TaskTargetResolver.COLOR_TURN_IN;
        local Color3_new_ret = Color3.new(1, 1, 1);
        local v139 = next(v124) ~= nil;
        local v140 = os.clock() * 3.141592653589793 * 4;
        local v141 = COLOR_TURN_IN:Lerp(Color3_new_ret, (math.sin(v140) + 1) * 0.5 * 0.5);

        for _, descendant in ipairs(Frame:GetDescendants()) do
            if descendant:IsA("ImageLabel") then
                local Attribute = descendant:GetAttribute("AnchorName");

                if Attribute then
                    local v142 = Attribute:find("_");
                    local v143 = v142 and Attribute:sub(v142 + 1) or nil;

                    if v139 and (v143 and v124[v143]) then
                        descendant.ImageColor3 = v141;
                    elseif descendant.ImageColor3 ~= Color3_new_ret then
                        descendant.ImageColor3 = Color3_new_ret;
                    end;
                end;
            end;
        end;

        local v144 = SquadMapResolver.Resolve();

        for i = 1, 8 do
            local v145 = v144[i];
            local v146 = u49[i];
            local v147;

            if v145 then
                local Vector3_new_ret = Vector3.new(v145.pos.X / u44, 0, v145.pos.Z / u44);
                local v148 = u78.PointToViewport(CFrame, 70, Vector3_new_ret, AbsoluteSize);
                local v149 = v148.X / AbsoluteSize.X;
                local v150 = v148.Y / AbsoluteSize.Y;

                if v149 >= 0 and (v149 <= 1 and (v150 >= 0 and v150 <= 1)) then
                    v146.Position = UDim2.fromScale(v149, v150);

                    if v146.Visible then
                        v147 = i;
                    else
                        v146.Visible = true;
                        v147 = i;
                    end;
                elseif v146.Visible then
                    v146.Visible = false;
                    v147 = i;
                else
                    v147 = i;
                end;
            elseif v146.Visible then
                v146.Visible = false;
                v147 = i;
            else
                v147 = i;
            end;
        end;

        local v151 = DeathMarkerResolver.Resolve();

        for i = 1, 8 do
            local v152 = v151[i];
            local v153 = u50[i];
            local v154;

            if v152 then
                local Vector3_new_ret = Vector3.new(v152.pos.X / u44, 0, v152.pos.Z / u44);
                local v155 = u78.PointToViewport(CFrame, 70, Vector3_new_ret, AbsoluteSize);
                local v156 = v155.X / AbsoluteSize.X;
                local v157 = v155.Y / AbsoluteSize.Y;

                if v156 >= 0 and (v156 <= 1 and (v157 >= 0 and v157 <= 1)) then
                    v153.Position = UDim2.fromScale(v156, v157);
                    local Time = v153:FindFirstChild("Time");

                    if Time then
                        Time.Text = DeathMarkerResolver.FormatTime(v152.secondsLeft);
                        local v158 = v152.secondsLeft <= DeathMarkerResolver.URGENT_SECONDS and DeathMarkerResolver.COLOR_URGENT or DeathMarkerResolver.COLOR;

                        if Time.TextColor3 ~= v158 then
                            Time.TextColor3 = v158;
                        end;
                    end;

                    if v153.Visible then
                        v154 = i;
                    else
                        v153.Visible = true;
                        v154 = i;
                    end;
                elseif v153.Visible then
                    v153.Visible = false;
                    v154 = i;
                else
                    v154 = i;
                end;
            elseif v153.Visible then
                v153.Visible = false;
                v154 = i;
            else
                v154 = i;
            end;
        end;

        if Frame2.Visible and (not Frame.Parent.Visible or UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter) then
            Frame2.Visible = false;
            u52 = nil;
        end;

        local v159 = SquadMarkerResolver.Resolve();

        for i = 1, 4 do
            local v160 = v159[i];
            local v161 = u51[i];
            local v162;

            if v160 then
                local Vector3_new_ret = Vector3.new(v160.pos.X / u44, 0, v160.pos.Z / u44);
                local v163 = u78.PointToViewport(CFrame, 70, Vector3_new_ret, AbsoluteSize);
                local v164 = v163.X / AbsoluteSize.X;
                local v165 = v163.Y / AbsoluteSize.Y;

                if v164 >= 0 and (v164 <= 1 and (v165 >= 0 and v165 <= 1)) then
                    v161.Position = UDim2.fromScale(v164, v165);
                    local math_floor_ret = math.floor(16 * (1 + 0.8 * v160.pulse) + 0.5);
                    v161.Size = UDim2.fromOffset(math_floor_ret, math_floor_ret);

                    if v161.TextColor3 ~= v160.color then
                        v161.TextColor3 = v160.color;
                    end;

                    if v161.Visible then
                        v162 = i;
                    else
                        v161.Visible = true;
                        v162 = i;
                    end;
                elseif v161.Visible then
                    v161.Visible = false;
                    v162 = i;
                else
                    v162 = i;
                end;
            elseif v161.Visible then
                v161.Visible = false;
                v162 = i;
            else
                v162 = i;
            end;
        end;
    end);
    local u166 = nil;
    u166 = LocalPlayer:GetAttributeChangedSignal("Zone"):Connect(function() -- Line: 1039
        -- upvalues: Frame (copy), u166 (ref), applyPlumsSettings (ref), PdaMapData (ref), LocalPlayer (ref)
        if Frame and Frame.Parent then
            applyPlumsSettings(PdaMapData.GetRegion(LocalPlayer:GetAttribute("Zone") or PdaMapData.CurrentZone()));

            return;
        end;

        if u166 then
            u166:Disconnect();
        end;
    end);
end;

return v4;