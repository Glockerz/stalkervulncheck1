-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local UITheme = require(script.Parent:WaitForChild("UITheme"));
local C = UITheme.C;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"));
local u1 = {};
local u2 = {
    CharacterFrame = true,
    InventoryFrame = true,
    ContainerFrame = true
};
local u3 = {
    RadDisplay = true,
    ArmorProtection = true,
    WeightDisplay = true,
    RoubleDisplay = true
};

local function seq(p4, p5) -- Line: 35
    return ColorSequence.new(p4, p5);
end;

local Color3_fromRGB_ret = Color3.fromRGB(36, 35, 33);
local ColorSequence_new_ret = ColorSequence.new(Color3_fromRGB_ret, C.header);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret3 = Color3.fromRGB(190, 186, 178);
local ColorSequence_new_ret2 = ColorSequence.new(Color3_fromRGB_ret2, Color3_fromRGB_ret3);
local NumberSequence_new_ret = NumberSequence.new(0.04, 0.12);

local function authoredStroke(p6) -- Line: 42
    local UIStroke = p6:FindFirstChild("UIStroke");

    if not (UIStroke and (UIStroke:IsA("UIStroke") and UIStroke)) then
        UIStroke = nil;
    end;

    return UIStroke;
end;

local function accent(p7, p8, p9) -- Line: 47
    if p7:FindFirstChild(p8) then
        return;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = p8;
    Frame.BorderSizePixel = 0;
    Frame.BackgroundColor3 = p9.color;
    Frame.AnchorPoint = p9.anchor;
    Frame.Position = p9.pos;
    Frame.Size = p9.size;
    Frame.ZIndex = (p7.ZIndex or 1) + 1;
    Frame.Parent = p7;
end;

local function styleTitle(p10, p11) -- Line: 61
    -- upvalues: ColorSequence_new_ret (copy), C (copy), UITheme (copy)
    local v12 = p10:FindFirstChildOfClass("UIGradient");

    if v12 then
        v12.Color = ColorSequence_new_ret;
    end;

    local UIStroke = p10:FindFirstChild("UIStroke");

    if not (UIStroke and (UIStroke:IsA("UIStroke") and UIStroke)) then
        UIStroke = nil;
    end;

    if UIStroke then
        UIStroke.Color = C.inner;
        UIStroke.Transparency = 0;
    end;

    local TextLabel = p10:FindFirstChild("TextLabel");

    if TextLabel and TextLabel:IsA("TextLabel") then
        TextLabel.FontFace = UITheme.HEADER_FONT;
        TextLabel.TextColor3 = p11 and C.paper or C.text;

        if not (p11 or TextLabel:FindFirstChildOfClass("UIPadding")) then
            local UIPadding = Instance.new("UIPadding");
            UIPadding.Name = "__SkinPad";
            UIPadding.PaddingLeft = UDim.new(0, 6);
            UIPadding.Parent = TextLabel;
        end;
    end;

    if not p11 then
        local v13 = {
            color = C.amber,
            anchor = Vector2.new(0, 0.5),
            pos = UDim2.new(0, 3, 0.5, 0),
            size = UDim2.new(0, 3, 0.6, 0)
        };

        if p10:FindFirstChild("__SkinMark") then
            return;
        end;

        local Frame = Instance.new("Frame");
        Frame.Name = "__SkinMark";
        Frame.BorderSizePixel = 0;
        Frame.BackgroundColor3 = v13.color;
        Frame.AnchorPoint = v13.anchor;
        Frame.Position = v13.pos;
        Frame.Size = v13.size;
        Frame.ZIndex = (p10.ZIndex or 1) + 1;
        Frame.Parent = p10;
    end;
end;

local function stylePanel(p14) -- Line: 88
    -- upvalues: C (copy), ColorSequence_new_ret2 (copy), NumberSequence_new_ret (copy)
    p14.BackgroundColor3 = C.panel;
    local v15 = p14:FindFirstChildOfClass("UIGradient");

    if v15 then
        v15.Color = ColorSequence_new_ret2;
        v15.Transparency = NumberSequence_new_ret;
    end;

    if not p14:FindFirstChild("__SkinInner") then
        local Frame = Instance.new("Frame");
        Frame.Name = "__SkinInner";
        Frame.BackgroundTransparency = 1;
        Frame.BorderSizePixel = 0;
        Frame.Active = false;
        Frame.Position = UDim2.fromOffset(6, 6);
        Frame.Size = UDim2.new(1, -12, 1, -12);
        Frame.ZIndex = p14.ZIndex;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Name = "__SkinInnerStroke";
        UIStroke.Color = C.inner;
        UIStroke.Thickness = 1;
        UIStroke.Parent = Frame;
        Frame.Parent = p14;
    end;

    local UIStroke = p14:FindFirstChild("UIStroke");

    if not (UIStroke and (UIStroke:IsA("UIStroke") and UIStroke)) then
        UIStroke = nil;
    end;

    if UIStroke then
        UIStroke.Color = C.edge;
        UIStroke.Transparency = 0;
    end;
end;

local function styleWell(p16) -- Line: 116
    -- upvalues: C (copy)
    p16.BackgroundColor3 = C.slot;
    p16.BackgroundTransparency = 0.2;
    local UIStroke = p16:FindFirstChild("UIStroke");

    if not (UIStroke and (UIStroke:IsA("UIStroke") and UIStroke)) then
        UIStroke = nil;
    end;

    if UIStroke then
        UIStroke.Color = C.inner;
        UIStroke.Transparency = 0;
    end;
end;

local function styleReadout(p17) -- Line: 123
    -- upvalues: ColorSequence_new_ret (copy), C (copy), UITheme (copy)
    local v18 = p17:FindFirstChildOfClass("UIGradient");

    if v18 then
        v18.Color = ColorSequence_new_ret;
    end;

    local UIStroke = p17:FindFirstChild("UIStroke");

    if not (UIStroke and (UIStroke:IsA("UIStroke") and UIStroke)) then
        UIStroke = nil;
    end;

    if UIStroke then
        UIStroke.Color = C.inner;
        UIStroke.Transparency = 0;
    end;

    for _, child in ipairs(p17:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            child.FontFace = UITheme.BODY_FONT_BOLD;
        end;
    end;
end;

local function styleMenu(p19) -- Line: 134
    -- upvalues: C (copy), UITheme (copy)
    p19.BackgroundColor3 = C.panel;
    local UIStroke = p19:FindFirstChild("UIStroke");

    if not (UIStroke and (UIStroke:IsA("UIStroke") and UIStroke)) then
        UIStroke = nil;
    end;

    if UIStroke then
        UIStroke.Color = C.edge;
        UIStroke.Transparency = 0;
    end;

    for _, child in ipairs(p19:GetChildren()) do
        if child:IsA("TextButton") then
            child.FontFace = UITheme.BODY_FONT;

            if child.Name ~= "DropButton" then
                child.BackgroundColor3 = C.row;
                child.TextColor3 = C.text;
            end;
        elseif child.Name == "HeaderLabel" and child:IsA("TextLabel") then
            child.FontFace = UITheme.HEADER_FONT;
            child.TextColor3 = C.dim;
        elseif child.Name == "DropSeparator" and child:IsA("Frame") then
            child.BackgroundColor3 = C.line;
        end;
    end;
end;

local function styleDetails(u20) -- Line: 155
    -- upvalues: C (copy), UITheme (copy)
    u20.BackgroundColor3 = C.panel;
    local UIStroke = u20:FindFirstChild("UIStroke");

    if not (UIStroke and (UIStroke:IsA("UIStroke") and UIStroke)) then
        UIStroke = nil;
    end;

    if UIStroke then
        UIStroke.Color = C.edge;
        UIStroke.Transparency = 0;
    end;

    local function lbl(p21, p22, p23) -- Line: 159
        -- upvalues: u20 (copy)
        local v24 = u20:FindFirstChild(p21);

        if v24 and v24:IsA("TextLabel") then
            v24.FontFace = p22;
            v24.TextColor3 = p23;
        end;
    end;

    local HEADER_FONT = UITheme.HEADER_FONT;
    local paper = C.paper;
    local ItemName = u20:FindFirstChild("ItemName");

    if ItemName and ItemName:IsA("TextLabel") then
        ItemName.FontFace = HEADER_FONT;
        ItemName.TextColor3 = paper;
    end;

    local BODY_FONT = UITheme.BODY_FONT;
    local dim = C.dim;
    local ItemType = u20:FindFirstChild("ItemType");

    if ItemType and ItemType:IsA("TextLabel") then
        ItemType.FontFace = BODY_FONT;
        ItemType.TextColor3 = dim;
    end;

    local BODY_FONT2 = UITheme.BODY_FONT;
    local text = C.text;
    local Description = u20:FindFirstChild("Description");

    if Description and Description:IsA("TextLabel") then
        Description.FontFace = BODY_FONT2;
        Description.TextColor3 = text;
    end;

    for _, v in ipairs({ "Divider1", "Divider2" }) do
        local v25 = u20:FindFirstChild(v);

        if v25 and v25:IsA("Frame") then
            v25.BackgroundColor3 = C.line;
        end;
    end;
end;

u1.GHOSTS = {
    FaceWearFrame = "GP-5 Gasmask",
    HeadGearFrame = "ALTYN Black",
    NightOpticalFrame = "PVS-31",
    EyeWearFrame = "Shooting Glasses",
    BodyGearFrame = "JPC 2.0 (Black)",
    PrimaryFrame = "AKM",
    SecondaryFrame = "AKMN PSO-1M2",
    SidearmFrame = "Glock 19",
    MeleeFrame = "AK Bayonet",
    BackpackFrame = "Tourist Backpack",
    BattleBeltFrame = "CRYE AVS LPB BELT"
};
u1.GHOSTS.ChestRigFrame = u1.GHOSTS.BodyGearFrame;
u1.GHOST_TRANSPARENCY = 0.35;
local Color3_new_ret = Color3.new(0, 0, 0);
u1.GHOST_SIZE = 0.93;

local function addGhost(u26) -- Line: 195
    -- upvalues: u1 (copy), ItemDatabase (copy), Color3_new_ret (copy), ItemIconStyle (copy)
    local v27 = u1.GHOSTS[u26.Name];

    if not v27 or u26:FindFirstChild("__SkinGhost") then
        return;
    end;

    local v28 = rawget(ItemDatabase, v27);

    if type(v28) ~= "table" or (type(v28.ImageID) ~= "string" or v28.ImageID == "") then
        return;
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "__SkinGhost";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Active = false;
    ImageLabel.Image = v28.ImageID;
    ImageLabel.ImageColor3 = Color3_new_ret;
    ImageLabel.ImageTransparency = u1.GHOST_TRANSPARENCY;
    ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(v28);
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(u1.GHOST_SIZE, u1.GHOST_SIZE);
    ImageLabel.ZIndex = 2;
    ImageLabel.Parent = u26;
    local u29;

    if u26.Name == "ChestRigFrame" then
        u29 = u26:FindFirstChild("Pattern") or nil;
    else
        u29 = nil;
    end;

    local function refresh() -- Line: 218
        -- upvalues: ImageLabel (copy), u26 (copy), u29 (copy)
        local v30;

        if u26:FindFirstChild("Item") == nil then
            v30 = not (u29 and u29.Visible);
        else
            v30 = false;
        end;

        ImageLabel.Visible = v30;
    end;

    u26.ChildAdded:Connect(refresh);
    u26.ChildRemoved:Connect(refresh);

    if u29 then
        u29:GetPropertyChangedSignal("Visible"):Connect(refresh);
    end;

    local v31;

    if u26:FindFirstChild("Item") == nil then
        if u29 then
            u29 = u29.Visible;
        end;

        v31 = not u29;
    else
        v31 = false;
    end;

    ImageLabel.Visible = v31;
end;

u1.SEGMENTS = 10;
local Color3_fromRGB_ret4 = Color3.fromRGB(222, 180, 58);
local Color3_fromRGB_ret5 = Color3.fromRGB(40, 38, 34);
local u32 = {
    RadDisplay = "RadLabel",
    ArmorProtection = "RadLabel",
    WeightDisplay = "WeightLabel"
};

function u1.Readout(p33, p34) -- Line: 238
    if type(p34) ~= "string" then
        return nil;
    end;

    if p33 == "RadDisplay" then
        local v35 = tonumber(p34:match("(%-?[%d%.]+)%s*%%"));

        return v35 and {
            caption = "RADIATION PROTECTION",
            over = false,
            value = p34:match("(%-?[%d%.]+)%s*%%") .. "%",
            fraction = math.clamp(v35 / 100, 0, 1)
        } or nil;
    end;

    local v36, v37 = p34:match("([%d%.]+)%s*/%s*([%d%.]+)");
    local v38 = tonumber(v36);
    local v39 = tonumber(v37);

    if not (v38 and v39) then
        return nil;
    end;

    local v40 = v39 > 0 and (v38 / v39 or 0) or 0;

    if p33 == "ArmorProtection" then
        return {
            caption = "DURABILITY",
            over = false,
            value = v36 .. " / " .. v37,
            fraction = math.clamp(v40, 0, 1)
        };
    end;

    if p33 ~= "WeightDisplay" then
        return nil;
    end;

    local v41 = {
        caption = "WEIGHT (KG)",
        value = v36 .. " / " .. v37,
        fraction = math.clamp(v40, 0, 1)
    };
    local v42;

    if v39 > 0 then
        v42 = v39 < v38;
    else
        v42 = false;
    end;

    v41.over = v42;

    return v41;
end;

function u1.Segments(p43, p44) -- Line: 260
    local v45 = math.clamp(p43 or 0, 0, 1) * p44;
    local v46 = {};

    for i = 1, p44 do
        v46[i] = math.clamp(v45 - (i - 1), 0, 1);
        local _ = i;
    end;

    return v46;
end;

local function addBar(u47) -- Line: 267
    -- upvalues: u32 (copy), UITheme (copy), C (copy), u1 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret4 (copy)
    local u48 = u32[u47.Name];

    if u48 then
        u48 = u47:FindFirstChild(u48);
    end;

    if not (u48 and (u48:IsA("TextLabel") and not u47:FindFirstChild("__SkinBar"))) then
        return;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "__SkinBar";
    Frame.BackgroundTransparency = 1;
    Frame.Active = false;
    Frame.Position = UDim2.new(0, 28, 0, 1);
    Frame.Size = UDim2.new(1, -32, 1, -3);
    Frame.ZIndex = u48.ZIndex + 1;
    Frame.Parent = u47;

    local function text(p49, p50, p51, p52, p53) -- Line: 279
        -- upvalues: UITheme (ref), Frame (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p49;
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Position = UDim2.fromScale(p50, 0);
        TextLabel.Size = UDim2.fromScale(p51, 0.58);
        TextLabel.FontFace = UITheme.BODY_FONT_BOLD;
        TextLabel.TextScaled = true;
        TextLabel.TextColor3 = p53;
        TextLabel.TextXAlignment = p52;
        TextLabel.ZIndex = Frame.ZIndex;
        TextLabel.Parent = Frame;

        return TextLabel;
    end;

    local u54 = text("Caption", 0, 0.7, Enum.TextXAlignment.Left, C.text);
    local u55 = text("Value", 0.7, 0.3, Enum.TextXAlignment.Right, C.paper);
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Track";
    Frame2.BackgroundTransparency = 1;
    Frame2.Position = UDim2.fromScale(0, 0.7);
    Frame2.Size = UDim2.fromScale(1, 0.26);
    Frame2.ZIndex = Frame.ZIndex;
    Frame2.Parent = Frame;
    local u56 = {};

    for i = 1, u1.SEGMENTS do
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "Seg" .. i;
        Frame3.BorderSizePixel = 0;
        Frame3.BackgroundColor3 = Color3_fromRGB_ret5;
        Frame3.Position = UDim2.new((i - 1) / u1.SEGMENTS, 1, 0, 0);
        Frame3.Size = UDim2.new(1 / u1.SEGMENTS, -2, 1, 0);
        Frame3.ZIndex = Frame.ZIndex;
        Frame3.Parent = Frame2;
        local Frame4 = Instance.new("Frame");
        Frame4.Name = "Fill";
        Frame4.BorderSizePixel = 0;
        Frame4.BackgroundColor3 = Color3_fromRGB_ret4;
        Frame4.Size = UDim2.fromScale(0, 1);
        Frame4.ZIndex = Frame.ZIndex + 1;
        Frame4.Parent = Frame3;
        u56[i] = Frame4;
        local _ = i;
    end;

    local TextStrokeTransparency = u48.TextStrokeTransparency;

    local function update() -- Line: 322
        -- upvalues: u1 (ref), u47 (copy), u48 (copy), Frame (copy), TextStrokeTransparency (copy), u54 (copy), u55 (copy), C (ref), u56 (copy), Color3_fromRGB_ret4 (ref)
        local v57 = u1.Readout(u47.Name, u48.Text);
        Frame.Visible = v57 ~= nil;
        u48.TextTransparency = v57 and 1 or 0;
        u48.TextStrokeTransparency = v57 and 1 or TextStrokeTransparency;

        if not v57 then
            return;
        end;

        u54.Text = v57.caption;
        u55.Text = v57.value;
        u55.TextColor3 = v57.over and C.blood or C.paper;

        for i, v in ipairs(u1.Segments(v57.fraction, u1.SEGMENTS)) do
            u56[i].Size = UDim2.fromScale(v, 1);
            u56[i].BackgroundColor3 = v57.over and C.blood or Color3_fromRGB_ret4;
        end;
    end;

    u48:GetPropertyChangedSignal("Text"):Connect(update);
    update();
end;

function u1.Apply(p58) -- Line: 342
    -- upvalues: u2 (copy), stylePanel (copy), styleTitle (copy), C (copy), addGhost (copy), u3 (copy), styleReadout (copy), addBar (copy), styleMenu (copy), styleDetails (copy)
    local MainFrame = p58:FindFirstChild("MainFrame");

    if MainFrame then
        for i in pairs(u2) do
            local v59 = MainFrame:FindFirstChild(i);

            if v59 then
                stylePanel(v59);
            end;
        end;

        for _, descendant in ipairs(MainFrame:GetDescendants()) do
            if descendant.Name == "Title" and (descendant:IsA("Frame") and descendant:FindFirstChild("TextLabel")) then
                styleTitle(descendant, u2[descendant.Parent.Name] == true);
                local Parent = descendant.Parent;

                if not u2[Parent.Name] and Parent:IsA("Frame") then
                    Parent.BackgroundColor3 = C.slot;
                    Parent.BackgroundTransparency = 0.2;
                    local UIStroke = Parent:FindFirstChild("UIStroke");

                    if not (UIStroke and (UIStroke:IsA("UIStroke") and UIStroke)) then
                        UIStroke = nil;
                    end;

                    if UIStroke then
                        UIStroke.Color = C.inner;
                        UIStroke.Transparency = 0;
                    end;

                    addGhost(Parent);
                end;
            elseif u3[descendant.Name] and descendant:IsA("Frame") then
                styleReadout(descendant);
                addBar(descendant);
            end;
        end;
    end;

    local ContextMenu = p58:FindFirstChild("ContextMenu");

    if ContextMenu then
        styleMenu(ContextMenu);
    end;

    local DetailsPanel = p58:FindFirstChild("DetailsPanel");

    if DetailsPanel then
        styleDetails(DetailsPanel);
    end;
end;

function u1.Start() -- Line: 368
    -- upvalues: UITheme (copy), Players (copy), u1 (copy)
    if not UITheme.SKIN_ENABLED then
        return;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if not LocalPlayer then
        return;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local InventoryGui = PlayerGui:WaitForChild("InventoryGui", 30);

    if InventoryGui then
        pcall(u1.Apply, InventoryGui);
    end;

    PlayerGui.ChildAdded:Connect(function(p60) -- Line: 375
        -- upvalues: u1 (ref)
        if p60.Name == "InventoryGui" then
            pcall(u1.Apply, p60);
        end;
    end);
end;

return u1;