-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Workspace = game:GetService("Workspace");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));
local ReportFormat = require(script:WaitForChild("ReportFormat"));
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"));
local PlayDeathScreen = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayDeathScreen");
local RequestRespawn = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RequestRespawn");
local LocalPlayer = Players.LocalPlayer;
local C = require(ReplicatedStorage:WaitForChild("InventoryController"):WaitForChild("UITheme")).C;
local DeathInsuranceUI = require(ReplicatedStorage:WaitForChild("DeathInsuranceUI"));
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local DeathScreen = PlayerGui:FindFirstChild("DeathScreen");

if DeathScreen then
    DeathScreen.Enabled = false;
end;

PlayerGui.ChildAdded:Connect(function(p1) -- Line: 59
    if p1.Name == "DeathScreen" then
        p1.Enabled = false;
    end;
end);
local u2 = false;
local CurrentCamera = Workspace.CurrentCamera;

local function freshDeath() -- Line: 71
    return {
        report = nil,
        stats = nil,
        items = nil,
        worn = nil,
        roubles = 0,
        shown = false
    };
end;

local u3 = {
    report = nil,
    stats = nil,
    items = nil,
    worn = nil,
    roubles = 0,
    shown = false
};

local function startMouseOverride() -- Line: 81
    -- upvalues: RunService (copy), UserInputService (copy)
    RunService:BindToRenderStep("DeathScreenMouseFree", Enum.RenderPriority.Last.Value, function() -- Line: 82
        -- upvalues: UserInputService (ref)
        if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        end;

        if not UserInputService.MouseIconEnabled then
            UserInputService.MouseIconEnabled = true;
        end;
    end);
end;

local function stopMouseOverride() -- Line: 91
    -- upvalues: RunService (copy)
    pcall(function() -- Line: 92
        -- upvalues: RunService (ref)
        RunService:UnbindFromRenderStep("DeathScreenMouseFree");
    end);
end;

local Sound = Instance.new("Sound");
Sound.Name = "Tinnitus";
Sound.SoundId = "rbxassetid://4155293439";
Sound.Volume = 1.2;
Sound.Looped = false;
Sound.Parent = script;
local u4 = {};
local u5 = { Workspace, SoundService };

local function captureWorldVolumes() -- Line: 111
    -- upvalues: u4 (copy), u5 (copy)
    table.clear(u4);

    for _, v in ipairs(u5) do
        for _, descendant in ipairs(v:GetDescendants()) do
            if descendant:IsA("Sound") and (descendant.Volume > 0 and not descendant:IsDescendantOf(script)) then
                u4[descendant] = descendant.Volume;
            end;
        end;
    end;
end;

local function fadeWorldVolume(p6, p7) -- Line: 122
    -- upvalues: u4 (copy), TweenService (copy)
    for i, v in pairs(u4) do
        if i.Parent then
            TweenService:Create(i, TweenInfo.new(p7), {
                Volume = v * p6
            }):Play();
        end;
    end;
end;

local function restoreWorldVolume() -- Line: 131
    -- upvalues: u4 (copy)
    for i, v in pairs(u4) do
        if i.Parent then
            i.Volume = v;
        end;
    end;

    table.clear(u4);
end;

local Vector2_new_ret = Vector2.new(1586, 992);
local Oswald = Enum.Font.Oswald;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = {};

local function label(p13, p14) -- Line: 155
    -- upvalues: C (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = p14.font or Enum.Font.RobotoCondensed;
    TextLabel.TextColor3 = p14.color or C.text;
    TextLabel.TextSize = p14.size or 16;
    TextLabel.TextXAlignment = p14.align or Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = p14.valign or Enum.TextYAlignment.Center;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Text = p14.text or "";
    TextLabel.Size = p14.sz or UDim2.new(1, 0, 0, (p14.size or 16) + 8);
    TextLabel.Position = p14.pos or UDim2.new();
    TextLabel.AnchorPoint = p14.anchor or Vector2.zero;
    TextLabel.LayoutOrder = p14.order or 0;
    TextLabel.Name = p14.name or "Label";
    TextLabel.ZIndex = p14.z or 2;
    TextLabel.Parent = p13;

    return TextLabel;
end;

local function box(p15, p16) -- Line: 175
    -- upvalues: C (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = p16.name or "Box";
    Frame.BackgroundColor3 = p16.color or C.panel;
    Frame.BackgroundTransparency = p16.transparency or 0;
    Frame.BorderSizePixel = 0;
    Frame.Size = p16.sz or UDim2.fromScale(1, 1);
    Frame.Position = p16.pos or UDim2.new();
    Frame.AnchorPoint = p16.anchor or Vector2.zero;
    Frame.LayoutOrder = p16.order or 0;
    Frame.ZIndex = p16.z or 1;

    if p16.stroke then
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = p16.stroke;
        UIStroke.Thickness = p16.strokeWidth or 1;
        UIStroke.Transparency = p16.strokeTransparency or 0;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = Frame;
    end;

    if p16.corner then
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, p16.corner);
    end;

    Frame.Parent = p15;

    return Frame;
end;

local function bracket(p17, p18, p19, p20, p21) -- Line: 200
    -- upvalues: box (copy)
    local v22 = p18 < 0 and 0 or 1;
    local v23 = p19 < 0 and 0 or 1;
    box(p17, {
        name = "BracketH",
        z = 3,
        color = p21,
        sz = UDim2.fromOffset(p20, 2),
        pos = UDim2.new(v22, 0, v23, 0),
        anchor = Vector2.new(v22, v23)
    });
    box(p17, {
        name = "BracketV",
        z = 3,
        color = p21,
        sz = UDim2.fromOffset(2, p20),
        pos = UDim2.new(v22, 0, v23, 0),
        anchor = Vector2.new(v22, v23)
    });
end;

local function panelFrame(p24, p25, p26, p27) -- Line: 209
    -- upvalues: box (copy), label (copy), C (copy), Oswald (copy)
    local v28 = box(box(p24, {
        transparency = 0.12,
        corner = 6,
        name = p26,
        color = Color3.fromRGB(12, 12, 13),
        sz = UDim2.fromOffset(724, 666),
        pos = UDim2.fromOffset(p25, 166),
        stroke = Color3.fromRGB(110, 102, 90)
    }), {
        name = "Inner",
        transparency = 1,
        corner = 3,
        sz = UDim2.new(1, -18, 1, -18),
        pos = UDim2.fromOffset(9, 9),
        stroke = Color3.fromRGB(58, 55, 50)
    });
    local v29 = box(v28, {
        name = "Header",
        transparency = 0.1,
        color = Color3.fromRGB(26, 26, 26),
        sz = UDim2.new(1, 0, 0, 48)
    });
    box(v29, {
        name = "Rule",
        color = Color3.fromRGB(58, 55, 50),
        sz = UDim2.new(1, 0, 0, 1),
        pos = UDim2.new(0, 0, 1, 0)
    });
    label(v29, {
        text = "////",
        size = 18,
        color = C.faint,
        font = Enum.Font.GothamBold,
        pos = UDim2.fromOffset(12, 0),
        sz = UDim2.new(0, 34, 1, 0)
    });
    label(v29, {
        size = 30,
        text = p26,
        color = C.paper,
        font = Oswald,
        pos = UDim2.fromOffset(52, 0),
        sz = UDim2.new(0.6, 0, 1, 0)
    });
    label(v29, {
        size = 10,
        text = p27,
        color = C.dim,
        font = Enum.Font.GothamBold,
        align = Enum.TextXAlignment.Right,
        pos = UDim2.new(1, -36, 0, 0),
        anchor = Vector2.new(1, 0),
        sz = UDim2.new(0.5, 0, 1, 0)
    });
    box(v29, {
        name = "Tick",
        color = C.blood,
        sz = UDim2.fromOffset(10, 3),
        pos = UDim2.new(1, -22, 0.5, -1)
    });

    return box(v28, {
        name = "Body",
        transparency = 1,
        sz = UDim2.new(1, 0, 1, -49),
        pos = UDim2.fromOffset(0, 49)
    });
end;

local function buildGui() -- Line: 230
    -- upvalues: u8 (ref), LocalPlayer (copy), u9 (ref), u10 (ref), box (copy), Vector2_new_ret (copy), label (copy), C (copy), Oswald (copy), panelFrame (copy), u12 (copy), bracket (copy), u11 (ref), DeathInsuranceUI (copy)
    if u8 then
        return;
    end;

    local PlayerGui2 = LocalPlayer:WaitForChild("PlayerGui");
    u8 = Instance.new("ScreenGui");
    u8.Name = "DeathScreen_New";
    u8.IgnoreGuiInset = true;
    u8.ResetOnSpawn = false;
    u8.DisplayOrder = 1500;
    u8.Enabled = false;
    u8.Parent = PlayerGui2;
    u9 = Instance.new("Frame");
    u9.Name = "Black";
    u9.Size = UDim2.new(1, 0, 1, 0);
    u9.BackgroundColor3 = Color3.new(0, 0, 0);
    u9.BackgroundTransparency = 1;
    u9.BorderSizePixel = 0;
    u9.Parent = u8;
    u10 = Instance.new("CanvasGroup");
    u10.Name = "Dossier";
    u10.Size = UDim2.fromScale(1, 1);
    u10.BackgroundTransparency = 1;
    u10.GroupTransparency = 1;
    u10.Parent = u8;
    local v30 = box(u10, {
        name = "Shade",
        transparency = 0,
        color = Color3.new(0, 0, 0)
    });
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = 90;
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.15),
        NumberSequenceKeypoint.new(0.3, 0.6),
        NumberSequenceKeypoint.new(0.7, 0.6),
        NumberSequenceKeypoint.new(1, 0.1)
    });
    UIGradient.Parent = v30;
    local Frame = Instance.new("Frame");
    Frame.Name = "Root";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromOffset(Vector2_new_ret.X, Vector2_new_ret.Y);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = u10;
    local UIScale = Instance.new("UIScale");
    UIScale.Parent = Frame;

    local function fit() -- Line: 290
        -- upvalues: u10 (ref), UIScale (copy), Vector2_new_ret (ref)
        local AbsoluteSize = u10.AbsoluteSize;

        if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
            UIScale.Scale = math.min(AbsoluteSize.X / Vector2_new_ret.X, AbsoluteSize.Y / Vector2_new_ret.Y);
        end;
    end;

    u10:GetPropertyChangedSignal("AbsoluteSize"):Connect(fit);
    local AbsoluteSize = u10.AbsoluteSize;

    if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
        UIScale.Scale = math.min(AbsoluteSize.X / Vector2_new_ret.X, AbsoluteSize.Y / Vector2_new_ret.Y);
    end;

    label(Frame, {
        text = "K . I . A .",
        size = 24,
        color = C.blood,
        font = Oswald,
        align = Enum.TextXAlignment.Center,
        pos = UDim2.fromOffset(0, 18),
        sz = UDim2.new(1, 0, 0, 30)
    });
    label(Frame, {
        text = "LOST TO THE ZONE",
        size = 72,
        color = C.paper,
        font = Oswald,
        align = Enum.TextXAlignment.Center,
        pos = UDim2.fromOffset(0, 46),
        sz = UDim2.new(1, 0, 0, 80)
    });
    box(Frame, {
        name = "RuleL",
        color = C.line,
        sz = UDim2.fromOffset(260, 1),
        pos = UDim2.fromOffset(503, 133)
    });
    box(Frame, {
        name = "RuleR",
        color = C.line,
        sz = UDim2.fromOffset(260, 1),
        pos = UDim2.fromOffset(823, 133)
    });
    label(Frame, {
        text = "+",
        size = 22,
        color = C.blood,
        font = Enum.Font.GothamBold,
        align = Enum.TextXAlignment.Center,
        pos = UDim2.fromOffset(778, 120),
        sz = UDim2.fromOffset(30, 26)
    });
    local u31 = panelFrame(Frame, 52, "DEATH REPORT", "S.T.A.L.K.E.R LOST");
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 0);
    UIListLayout.Parent = u31;
    local UIPadding = Instance.new("UIPadding");
    local UDim_new_ret = UDim.new(0, 38);
    local UDim_new_ret2 = UDim.new(0, 36);
    local UDim_new_ret3 = UDim.new(0, 38);
    UIPadding.PaddingLeft = UDim_new_ret;
    UIPadding.PaddingRight = UDim_new_ret2;
    UIPadding.PaddingTop = UDim_new_ret3;
    UIPadding.Parent = u31;
    local v32 = box(u31, {
        name = "Hero",
        transparency = 1,
        order = 1,
        sz = UDim2.new(1, 0, 0, 166)
    });
    u12.portrait = box(v32, {
        name = "Portrait",
        color = Color3.fromRGB(16, 16, 16),
        sz = UDim2.fromOffset(144, 144),
        stroke = Color3.fromRGB(110, 102, 90)
    });
    u12.verb = label(v32, {
        name = "Verb",
        size = 20,
        color = C.dim,
        pos = UDim2.fromOffset(180, 12),
        sz = UDim2.new(1, -180, 0, 28)
    });
    u12.who = label(v32, {
        name = "Who",
        size = 46,
        color = C.paper,
        font = Oswald,
        pos = UDim2.fromOffset(180, 38),
        sz = UDim2.new(1, -180, 0, 56)
    });
    u12.detail = label(v32, {
        name = "Detail",
        size = 25,
        color = C.text,
        pos = UDim2.fromOffset(180, 96),
        sz = UDim2.new(1, -180, 0, 32)
    });
    u12.weaponCard = box(u31, {
        name = "Weapon",
        transparency = 0.2,
        order = 2,
        color = Color3.fromRGB(16, 16, 16),
        sz = UDim2.new(1, 0, 0, 100),
        stroke = Color3.fromRGB(45, 43, 40)
    });
    local v33 = box(u12.weaponCard, {
        name = "ImgBg",
        color = Color3.fromRGB(24, 24, 24),
        sz = UDim2.new(0, 280, 1, -8),
        pos = UDim2.fromOffset(4, 4),
        stroke = Color3.fromRGB(52, 50, 46)
    });
    u12.weaponImg = Instance.new("ImageLabel");
    u12.weaponImg.BackgroundTransparency = 1;
    u12.weaponImg.Size = UDim2.new(1, -24, 1, -12);
    u12.weaponImg.Position = UDim2.fromOffset(12, 6);
    u12.weaponImg.ZIndex = 2;
    u12.weaponImg.Parent = v33;
    u12.weaponName = label(u12.weaponCard, {
        name = "Name",
        size = 28,
        color = C.text,
        pos = UDim2.fromOffset(304, 16),
        sz = UDim2.new(1, -320, 0, 36)
    });
    u12.weaponRange = label(u12.weaponCard, {
        name = "Range",
        size = 20,
        color = C.dim,
        pos = UDim2.fromOffset(304, 52),
        sz = UDim2.new(1, -320, 0, 28)
    });
    box(u31, {
        name = "Gap",
        transparency = 1,
        order = 3,
        sz = UDim2.new(1, 0, 0, 22)
    });

    local function fact(p34, p35, p36) -- Line: 338
        -- upvalues: box (ref), u31 (copy), C (ref), label (ref)
        local v37 = box(u31, {
            transparency = 1,
            name = p36,
            sz = UDim2.new(1, 0, 0, 62),
            order = p34
        });
        box(v37, {
            name = "Rule",
            color = C.line,
            sz = UDim2.new(1, 0, 0, 1)
        });
        box(v37, {
            name = "Sep",
            color = Color3.fromRGB(45, 43, 40),
            sz = UDim2.new(0, 1, 1, 0),
            pos = UDim2.new(0.4, 0, 0, 0)
        });

        if p35 == "clock" then
            local v38 = box(v37, {
                name = "Clock",
                transparency = 1,
                strokeWidth = 2,
                corner = 11,
                sz = UDim2.fromOffset(22, 22),
                pos = UDim2.new(0, 8, 0.5, -11),
                stroke = C.dim
            });
            box(v38, {
                name = "Hour",
                color = C.dim,
                sz = UDim2.fromOffset(2, 7),
                pos = UDim2.new(0.5, -1, 0.5, -7)
            });
            box(v38, {
                name = "Minute",
                color = C.dim,
                sz = UDim2.fromOffset(6, 2),
                pos = UDim2.new(0.5, 0, 0.5, -1)
            });
        elseif p35 == "skull" then
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Image = "rbxassetid://130059527035420";
            ImageLabel.ImageColor3 = C.dim;
            ImageLabel.Size = UDim2.fromOffset(26, 26);
            ImageLabel.Position = UDim2.new(0, 6, 0.5, -13);
            ImageLabel.Parent = v37;
        else
            label(v37, {
                size = 26,
                text = p35,
                color = C.dim,
                font = Enum.Font.GothamBold,
                align = Enum.TextXAlignment.Center,
                pos = UDim2.fromOffset(0, 0),
                sz = UDim2.new(0, 38, 1, 0)
            });
        end;

        label(v37, {
            size = 19,
            text = p36,
            color = C.dim,
            pos = UDim2.fromOffset(58, 0),
            sz = UDim2.new(0.4, -64, 1, 0)
        });

        return label(v37, {
            name = "Value",
            size = 23,
            color = C.paper,
            pos = UDim2.new(0.4, 28, 0, 0),
            sz = UDim2.new(0.6, -28, 1, 0)
        });
    end;

    u12.location = fact(4, "◎", "LOCATION");
    u12.alive = fact(5, "clock", "TIME ALIVE");
    u12.deaths = fact(6, "skull", "DEATHS");
    u12.wornHeader = box(u31, {
        name = "WornHeader",
        transparency = 1,
        order = 7,
        sz = UDim2.new(1, 0, 0, 40)
    });
    box(u12.wornHeader, {
        name = "Rule",
        color = C.line,
        sz = UDim2.new(1, 0, 0, 1)
    });
    label(u12.wornHeader, {
        text = "CONDITION LOST",
        size = 19,
        color = C.dim,
        pos = UDim2.fromOffset(58, 8),
        sz = UDim2.new(1, -58, 0, 28)
    });
    u12.wornList = box(u31, {
        name = "Worn",
        transparency = 1,
        order = 8,
        sz = UDim2.new(1, 0, 0, 0)
    });
    u12.wornList.AutomaticSize = Enum.AutomaticSize.Y;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Parent = u12.wornList;
    local v39 = panelFrame(Frame, 798, "LOOT LOST", "LEFT ON THE BODY");
    u12.lootCount = label(v39, {
        name = "Count",
        size = 16,
        color = C.faint,
        align = Enum.TextXAlignment.Right,
        pos = UDim2.new(1, -24, 0, 6),
        anchor = Vector2.new(1, 0),
        sz = UDim2.new(0.5, 0, 0, 22)
    });
    u12.scroll = Instance.new("ScrollingFrame");
    u12.scroll.Name = "Rows";
    u12.scroll.Position = UDim2.fromOffset(18, 32);
    u12.scroll.Size = UDim2.new(1, -36, 1, -212);
    u12.scroll.BackgroundTransparency = 1;
    u12.scroll.BorderSizePixel = 0;
    u12.scroll.ScrollBarThickness = 4;
    u12.scroll.ScrollBarImageColor3 = C.dim;
    u12.scroll.CanvasSize = UDim2.new();
    u12.scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    u12.scroll.Parent = v39;
    local UIListLayout3 = Instance.new("UIListLayout");
    UIListLayout3.Padding = UDim.new(0, 4);
    UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout3.Parent = u12.scroll;
    u12.empty = box(v39, {
        name = "Empty",
        transparency = 1,
        sz = UDim2.new(1, 0, 1, -200)
    });
    local v40 = box(u12.empty, {
        name = "Frame",
        transparency = 1,
        sz = UDim2.fromOffset(150, 120),
        pos = UDim2.new(0.5, 0, 0.5, -70),
        anchor = Vector2.new(0.5, 0.5)
    });

    for _, v in ipairs({ { -1, -1 }, { 1, -1 }, { -1, 1 }, { 1, 1 } }) do
        bracket(v40, v[1], v[2], 16, C.faint);
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://83295312821173";
    ImageLabel.ImageColor3 = Color3.fromRGB(110, 106, 98);
    ImageLabel.Size = UDim2.fromOffset(90, 90);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Parent = v40;
    label(u12.empty, {
        text = "NOTHING LOST",
        size = 30,
        color = C.dim,
        font = Oswald,
        align = Enum.TextXAlignment.Center,
        pos = UDim2.new(0, 0, 0.5, 6),
        sz = UDim2.new(1, 0, 0, 36)
    });
    label(u12.empty, {
        text = "You were carrying no loot.",
        size = 20,
        color = C.faint,
        align = Enum.TextXAlignment.Center,
        pos = UDim2.new(0, 0, 0.5, 44),
        sz = UDim2.new(1, 0, 0, 26)
    });
    local u41 = box(v39, {
        name = "Totals",
        transparency = 1,
        sz = UDim2.new(1, 0, 0, 178),
        pos = UDim2.new(0, 0, 1, 0),
        anchor = Vector2.new(0, 1)
    });
    box(u41, {
        name = "Rule",
        color = C.line,
        sz = UDim2.new(1, 0, 0, 1)
    });

    local function totalRow(p42, p43) -- Line: 417
        -- upvalues: label (ref), u41 (copy), C (ref), box (ref)
        label(u41, {
            size = 21,
            text = p43,
            color = C.text,
            pos = UDim2.fromOffset(34, p42),
            sz = UDim2.new(0.5, 0, 0, 30)
        });
        box(u41, {
            name = "Dots",
            color = Color3.fromRGB(45, 43, 40),
            sz = UDim2.new(1, -68, 0, 1),
            pos = UDim2.fromOffset(34, p42 + 32)
        });

        return label(u41, {
            size = 21,
            name = p43,
            color = C.paper,
            align = Enum.TextXAlignment.Right,
            pos = UDim2.new(1, -34, 0, p42),
            anchor = Vector2.new(1, 0),
            sz = UDim2.new(0.5, 0, 0, 30)
        });
    end;

    u12.itemsTotal = totalRow(16, "Items");
    u12.roublesTotal = totalRow(52, "Roubles dropped");
    local v44 = box(u41, {
        name = "TotalBar",
        color = Color3.fromRGB(30, 29, 27),
        sz = UDim2.new(1, -12, 0, 66),
        pos = UDim2.new(0, 6, 1, -6),
        anchor = Vector2.new(0, 1),
        stroke = Color3.fromRGB(70, 66, 58)
    });
    label(v44, {
        text = "TOTAL LOST",
        size = 32,
        color = C.paper,
        font = Oswald,
        pos = UDim2.fromOffset(28, 0),
        sz = UDim2.new(0.5, 0, 1, 0)
    });
    u12.grandTotal = label(v44, {
        name = "Grand",
        size = 46,
        color = C.money,
        font = Oswald,
        align = Enum.TextXAlignment.Right,
        pos = UDim2.new(1, -28, 0, 0),
        anchor = Vector2.new(1, 0),
        sz = UDim2.new(0.5, 0, 1, 0)
    });
    local v45 = box(Frame, {
        name = "RespawnHolder",
        transparency = 1,
        sz = UDim2.fromOffset(474, 98),
        pos = UDim2.fromOffset(556, 850)
    });

    for _, v in ipairs({ { -1, -1 }, { 1, -1 }, { -1, 1 }, { 1, 1 } }) do
        bracket(v45, v[1], v[2], 14, Color3.fromRGB(120, 112, 100));
    end;

    box(Frame, {
        name = "RuleL",
        color = C.line,
        sz = UDim2.fromOffset(470, 1),
        pos = UDim2.fromOffset(60, 898)
    });
    box(Frame, {
        name = "RuleR",
        color = C.line,
        sz = UDim2.fromOffset(470, 1),
        pos = UDim2.fromOffset(1056, 898)
    });
    u11 = Instance.new("TextButton");
    u11.Name = "RespawnButton";
    u11.AnchorPoint = Vector2.new(0.5, 0.5);
    u11.Position = UDim2.fromScale(0.5, 0.5);
    u11.Size = UDim2.new(1, -26, 1, -24);
    u11.BackgroundColor3 = Color3.fromRGB(150, 28, 24);
    u11.Text = "R E S P A W N";
    u11.Font = Oswald;
    u11.TextColor3 = Color3.fromRGB(240, 225, 215);
    u11.TextSize = 40;
    u11.AutoButtonColor = false;
    u11.BorderSizePixel = 0;
    u11.ZIndex = 2;
    u11.Parent = v45;
    Instance.new("UICorner", u11).CornerRadius = UDim.new(0, 3);
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Rotation = 90;
    UIGradient2.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 140, 140));
    UIGradient2.Parent = u11;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(230, 70, 50);
    UIStroke.Thickness = 2;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = u11;
    DeathInsuranceUI.Build(u12.scroll, Frame, {
        C = C,
        OSWALD = Oswald
    });
end;

local function renderPortrait(p46) -- Line: 468
    -- upvalues: u12 (copy)
    for _, child in ipairs(u12.portrait:GetChildren()) do
        if child:IsA("ViewportFrame") or child:IsA("ImageLabel") then
            child:Destroy();
        end;
    end;

    local u47 = type(p46) == "table" and p46.model or nil;
    local u48;

    if typeof(u47) == "Instance" then
        u48 = u47:FindFirstChild("Head") or u47:FindFirstChild("HumanoidRootPart");
    else
        u48 = false;
    end;

    if u48 and pcall(function() -- Line: 475
        -- upvalues: u12 (ref), u47 (copy), u48 (copy)
        local ViewportFrame = Instance.new("ViewportFrame");
        ViewportFrame.Size = UDim2.fromScale(1, 1);
        ViewportFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16);
        ViewportFrame.Ambient = Color3.fromRGB(150, 140, 130);
        ViewportFrame.LightColor = Color3.fromRGB(255, 235, 215);
        ViewportFrame.LightDirection = (Vector3.new(-0.4, -1, -0.6)).Unit;
        ViewportFrame.ZIndex = 2;
        ViewportFrame.Parent = u12.portrait;
        local WorldModel = Instance.new("WorldModel");
        WorldModel.Parent = ViewportFrame;

        local function arch(p49) -- Line: 486
            -- upvalues: arch (copy)
            p49.Archivable = true;

            for _, child in ipairs(p49:GetChildren()) do
                arch(child);
            end;
        end;

        local v50 = u47;
        v50.Archivable = true;

        for _, child in ipairs(v50:GetChildren()) do
            arch(child);
        end;

        local v51 = u47:Clone();

        for _, descendant in ipairs(v51:GetDescendants()) do
            if descendant:IsA("Script") or (descendant:IsA("LocalScript") or descendant:IsA("Sound")) then
                descendant:Destroy();
            elseif descendant:IsA("BasePart") then
                descendant.Anchored = true;
            end;
        end;

        v51.Parent = WorldModel;
        local v52 = v51:FindFirstChild(u48.Name);
        local v53 = v51:FindFirstChild("HumanoidRootPart") or v52;
        local ExtentsSize = v51:GetExtentsSize();
        local v54 = u48.Name == "Head" and 2.6 or math.max(ExtentsSize.X, ExtentsSize.Y, ExtentsSize.Z) * 0.9;
        local Camera = Instance.new("Camera");
        Camera.FieldOfView = 40;
        Camera.CFrame = CFrame.new(v52.Position + v53.CFrame.LookVector * v54, v52.Position);
        Camera.Parent = ViewportFrame;
        ViewportFrame.CurrentCamera = Camera;
    end) then
        return;
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://130059527035420";
    ImageLabel.ImageColor3 = Color3.fromRGB(200, 190, 175);
    ImageLabel.Size = UDim2.new(1, -24, 1, -24);
    ImageLabel.Position = UDim2.fromOffset(12, 12);
    ImageLabel.ZIndex = 2;
    ImageLabel.Parent = u12.portrait;
end;

local function weaponData(p55) -- Line: 517
    -- upvalues: ItemDatabase (copy)
    if type(p55) ~= "string" then
        return nil;
    end;

    local v56 = rawget(ItemDatabase, p55);

    if type(v56) == "table" and v56.Name then
        return v56;
    end;

    for _, v in pairs(ItemDatabase) do
        if type(v) == "table" and (v.Name == p55 and v.ImageID) then
            return v;
        end;
    end;

    return nil;
end;

local function renderReport() -- Line: 529
    -- upvalues: u12 (copy), u3 (ref), ReportFormat (copy), renderPortrait (copy), weaponData (copy), ItemIconStyle (copy)
    if not u12.verb then
        return;
    end;

    local v57 = u3.report or {};
    local killer = v57.killer;
    local v58 = ReportFormat.Headline(v57.key, killer);
    u12.verb.Text = v58.name and (v58.verb or "") or "";
    u12.who.Text = v58.name or v58.verb;
    u12.detail.Text = v58.detail or "";
    renderPortrait(killer);
    local v59;

    if type(killer) == "table" then
        v59 = killer.weapon or nil;
    else
        v59 = nil;
    end;

    u12.weaponCard.Visible = v59 ~= nil;

    if v59 then
        local v60 = weaponData(v59);

        if v60 then
            v59 = v60.Name or v59;
        end;

        u12.weaponName.Text = v59;
        u12.weaponImg.Image = v60 and type(v60.ImageID) == "string" and (v60.ImageID or "") or "";
        u12.weaponImg.ScaleType = ItemIconStyle.ScaleTypeFor(v60);
        u12.weaponRange.Text = type(killer.distance) == "number" and (("%d m away"):format((math.floor(killer.distance + 0.5))) or "") or "";
    end;

    u12.location.Text = v57.location or "The Zone";
    u12.alive.Text = v57.aliveSeconds and ReportFormat.Duration(v57.aliveSeconds) or "-";
end;

local function renderStats() -- Line: 551
    -- upvalues: u12 (copy), u3 (ref)
    if not u12.deaths then
        return;
    end;

    local stats = u3.stats;

    if not stats then
        u12.deaths.Text = "-";

        return;
    end;

    if stats.wipe then
        u12.deaths.Text = ("%d this wipe   /   %d all time"):format(stats.wipe, stats.life);

        return;
    end;

    u12.deaths.Text = ("%d all time"):format(stats.life);
end;

local function renderWorn() -- Line: 562
    -- upvalues: u12 (copy), u3 (ref), box (copy), label (copy), C (copy), ItemDatabase (copy), ReportFormat (copy)
    if not u12.wornList then
        return;
    end;

    for _, child in ipairs(u12.wornList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    local v61 = u3.worn or {};
    u12.wornHeader.Visible = #v61 > 0;

    for i, v in ipairs(v61) do
        if i > 3 then
            label(box(u12.wornList, {
                name = "More",
                transparency = 1,
                sz = UDim2.new(1, 0, 0, 26),
                order = i
            }), {
                size = 18,
                text = ("+%d more"):format(#v61 - 3),
                color = C.faint,
                pos = UDim2.fromOffset(58, 0),
                sz = UDim2.new(1, -58, 1, 0)
            });

            return;
        end;

        local ItemData = ItemDatabase.GetItemData(v.id);
        local v62 = box(u12.wornList, {
            transparency = 1,
            name = "Worn" .. i,
            sz = UDim2.new(1, 0, 0, 30),
            order = i
        });
        label(v62, {
            size = 20,
            text = ItemData and ItemData.Name or tostring(v.id),
            color = C.text,
            pos = UDim2.fromOffset(58, 0),
            sz = UDim2.new(0.6, -58, 1, 0)
        });
        label(v62, {
            size = 20,
            text = ReportFormat.Condition(v.before, v.after),
            color = C.blood,
            align = Enum.TextXAlignment.Right,
            pos = UDim2.new(1, 0, 0, 0),
            anchor = Vector2.new(1, 0),
            sz = UDim2.new(0.4, 0, 1, 0)
        });
    end;
end;

local u63 = 0;
local u64 = 0;

local function setTotals(u65, u66, p67) -- Line: 588
    -- upvalues: u63 (ref), u64 (ref), u12 (copy), ReportFormat (copy), RunService (copy)
    local u68 = u63;
    local u69 = u64;
    u63 = u65;
    u64 = u66;

    local function paint(p70, p71) -- Line: 591
        -- upvalues: u12 (ref), ReportFormat (ref)
        u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(p70);
        u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(p71);
        u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(p70 + p71);
    end;

    if p67 then
        local os_clock_ret = os.clock();
        task.spawn(function() -- Line: 598
            -- upvalues: os_clock_ret (copy), u68 (copy), u65 (copy), u69 (copy), u66 (copy), u12 (ref), ReportFormat (ref), RunService (ref)
            while true do
                local v72 = (os.clock() - os_clock_ret) / 0.35;
                local math_clamp_ret = math.clamp(v72, 0, 1);
                local v73 = u68 + (u65 - u68) * math_clamp_ret;
                local v74 = u69 + (u66 - u69) * math_clamp_ret;
                u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(v73);
                u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(v74);
                u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(v73 + v74);

                if math_clamp_ret >= 1 then
                    break;
                end;

                RunService.RenderStepped:Wait();
            end;
        end);

        return;
    end;

    u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(u65);
    u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(u66);
    u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(u65 + u66);
end;

local function stampTotal() -- Line: 608
    -- upvalues: u12 (copy), TweenService (copy)
    local TextSize = u12.grandTotal.TextSize;
    u12.grandTotal.TextSize = math.floor(TextSize * 1.2);
    TweenService:Create(u12.grandTotal, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
        TextSize = TextSize
    }):Play();
end;

local u75 = 0;

local function renderLoot() -- Line: 616
    -- upvalues: u12 (copy), u75 (ref), u3 (ref), u63 (ref), u64 (ref), ReportFormat (copy), ItemDatabase (copy), box (copy), C (copy), ItemIconStyle (copy), label (copy), RunService (copy), stampTotal (copy)
    if not u12.scroll then
        return;
    end;

    u75 = u75 + 1;
    local u76 = u75;

    for _, child in ipairs(u12.scroll:GetChildren()) do
        if child:IsA("Frame") and child.Name ~= "InsuranceContract" then
            child:Destroy();
        end;
    end;

    local table_clone_ret = table.clone(u3.items or {});
    table.sort(table_clone_ret, function(p77, p78) -- Line: 625
        return (p77.value or 0) > (p78.value or 0);
    end);
    u12.empty.Visible = #table_clone_ret == 0;
    local v79 = 0;

    for _, v in ipairs(table_clone_ret) do
        v79 = v79 + (v.count or 1);
    end;

    u12.lootCount.Text = v79 > 0 and (("%d item%s"):format(v79, v79 == 1 and "" or "s") or "") or "";
    u63 = 0;
    local roubles = u3.roubles;
    u63 = 0;
    u64 = roubles;

    local function _(p80, p81) -- Line: 591
        -- upvalues: u12 (ref), ReportFormat (ref)
        u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(p80);
        u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(p81);
        u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(p80 + p81);
    end;

    u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(0);
    u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(roubles);
    u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(0 + roubles);
    local u82 = #table_clone_ret > 0 and (math.min(0.11, 2.4 / #table_clone_ret) or 0) or 0;
    task.spawn(function() -- Line: 633
        -- upvalues: table_clone_ret (copy), u76 (copy), u75 (ref), ItemDatabase (ref), box (ref), u12 (ref), C (ref), ItemIconStyle (ref), label (ref), ReportFormat (ref), u3 (ref), u63 (ref), u64 (ref), RunService (ref), u82 (copy), stampTotal (ref)
        local u83 = 0;

        for i, v in ipairs(table_clone_ret) do
            if u76 ~= u75 then
                return;
            end;

            local ItemData = ItemDatabase.GetItemData(v.id);
            local v84 = box(u12.scroll, {
                transparency = 0.3,
                corner = 3,
                name = "Row" .. i,
                color = C.row,
                sz = UDim2.new(1, -8, 0, 44),
                order = i
            });
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Size = UDim2.fromOffset(36, 36);
            ImageLabel.Position = UDim2.fromOffset(6, 4);
            ImageLabel.BorderSizePixel = 0;
            ImageLabel.ZIndex = 2;

            if ItemData and (type(ItemData.ImageID) == "string" and ItemData.ImageID ~= "") then
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Image = ItemData.ImageID;
                ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(ItemData);
            else
                ImageLabel.BackgroundColor3 = Color3.fromRGB(45, 43, 40);
                ImageLabel.BackgroundTransparency = 0.5;
            end;

            ImageLabel.Parent = v84;
            label(v84, {
                size = 21,
                text = (ItemData and ItemData.Name or tostring(v.id)) .. ((v.count or 1) > 1 and ("  x" .. v.count or "") or ""),
                color = C.text,
                pos = UDim2.fromOffset(54, 0),
                sz = UDim2.new(1, -200, 1, 0)
            });
            label(v84, {
                size = 21,
                text = (v.value or 0) > 0 and ("₽" .. " " .. ReportFormat.Money(v.value) or "-") or "-",
                color = C.money,
                align = Enum.TextXAlignment.Right,
                pos = UDim2.new(1, -12, 0, 0),
                anchor = Vector2.new(1, 0),
                sz = UDim2.new(0, 140, 1, 0)
            });
            u83 = u83 + (v.value or 0);
            local roubles2 = u3.roubles;
            local u85 = u63;
            local u86 = u64;
            u63 = u83;
            u64 = roubles2;

            local function _(p87, p88) -- Line: 591
                -- upvalues: u12 (ref), ReportFormat (ref)
                u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(p87);
                u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(p88);
                u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(p87 + p88);
            end;

            local os_clock_ret = os.clock();
            task.spawn(function() -- Line: 598
                -- upvalues: os_clock_ret (copy), u85 (copy), u83 (copy), u86 (copy), roubles2 (copy), u12 (ref), ReportFormat (ref), RunService (ref)
                while true do
                    local v89 = (os.clock() - os_clock_ret) / 0.35;
                    local math_clamp_ret = math.clamp(v89, 0, 1);
                    local v90 = u85 + (u83 - u85) * math_clamp_ret;
                    local v91 = u86 + (roubles2 - u86) * math_clamp_ret;
                    u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(v90);
                    u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(v91);
                    u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(v90 + v91);

                    if math_clamp_ret >= 1 then
                        break;
                    end;

                    RunService.RenderStepped:Wait();
                end;
            end);
            task.wait(u82);
        end;

        if u76 == u75 then
            stampTotal();
        end;
    end);
end;

local function playInstantDeath() -- Line: 666
    -- upvalues: buildGui (copy), u8 (ref), RunService (copy), UserInputService (copy), u9 (ref), captureWorldVolumes (copy), fadeWorldVolume (copy), Sound (copy), renderReport (copy), u12 (copy), u3 (ref), renderWorn (copy), renderLoot (copy), u63 (ref), u64 (ref), ReportFormat (copy), TweenService (copy), u10 (ref)
    buildGui();
    u8.Enabled = true;
    RunService:BindToRenderStep("DeathScreenMouseFree", Enum.RenderPriority.Last.Value, function() -- Line: 82
        -- upvalues: UserInputService (ref)
        if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        end;

        if not UserInputService.MouseIconEnabled then
            UserInputService.MouseIconEnabled = true;
        end;
    end);
    u9.BackgroundTransparency = 0;
    captureWorldVolumes();
    fadeWorldVolume(0, 0.15);
    Sound:Play();
    renderReport();

    if u12.deaths then
        local stats = u3.stats;

        if stats then
            if stats.wipe then
                u12.deaths.Text = ("%d this wipe   /   %d all time"):format(stats.wipe, stats.life);
            else
                u12.deaths.Text = ("%d all time"):format(stats.life);
            end;
        else
            u12.deaths.Text = "-";
        end;
    end;

    renderWorn();

    if u3.items then
        renderLoot();
    else
        local roubles = u3.roubles;
        u63 = 0;
        u64 = roubles;

        local function _(p92, p93) -- Line: 591
            -- upvalues: u12 (ref), ReportFormat (ref)
            u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(p92);
            u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(p93);
            u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(p92 + p93);
        end;

        u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(0);
        u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(roubles);
        u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(0 + roubles);
        u12.empty.Visible = false;
    end;

    u3.shown = true;
    task.wait(0.2);

    if u12.scroll then
        u12.scroll.CanvasPosition = Vector2.zero;
    end;

    TweenService:Create(u10, TweenInfo.new(0.35), {
        GroupTransparency = 0
    }):Play();
    TweenService:Create(u9, TweenInfo.new(1.2), {
        BackgroundTransparency = 0.3
    }):Play();
end;

local u94 = { 0, 40, 80 };
local u95 = false;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Terrain };

local function terrainLoadedAround(p96) -- Line: 744
    -- upvalues: u94 (copy), RaycastParams_new_ret (copy)
    local v97 = 0;
    local v98 = 0;

    for _, v in ipairs(u94) do
        local v99 = v == 0 and 1 or 8;
        local v100 = v;

        for i = 1, v99 do
            local v101 = i / v99 * 3.141592653589793 * 2;
            local v102 = math.cos(v101) * v100;
            local v103 = math.sin(v101) * v100;
            local v104 = p96 + Vector3.new(v102, 150, v103);
            v97 = v97 + 1;
            local v105;

            if workspace:Raycast(v104, Vector3.new(0, -400, 0), RaycastParams_new_ret) then
                v98 = v98 + 1;
                v105 = i;
            else
                v105 = i;
            end;
        end;
    end;

    return v98 / v97 >= 0.85;
end;

local function hasGroundUnder(p106) -- Line: 763
    -- upvalues: PlaceConfig (copy), terrainLoadedAround (copy)
    local v107;

    if p106 then
        v107 = p106:FindFirstChild("HumanoidRootPart");
    else
        v107 = p106;
    end;

    if not v107 then
        return false;
    end;

    if PlaceConfig.SpawnOnTerrain then
        return terrainLoadedAround(v107.Position);
    end;

    local RaycastParams_new_ret2 = RaycastParams.new();
    RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret2.FilterDescendantsInstances = { p106 };

    return workspace:Raycast(v107.Position + Vector3.new(0, 3, 0), Vector3.new(0, -40, 0), RaycastParams_new_ret2) ~= nil;
end;

local function waitForGround(p108) -- Line: 777
    -- upvalues: hasGroundUnder (copy), LocalPlayer (copy)
    local v109 = os.clock() + 20;
    local v110 = os.clock() + 3;

    while not hasGroundUnder(p108) do
        if v109 <= os.clock() or p108.Parent == nil then
            warn("[DeathScreenClient] no ground under the new body after " .. 20 .. "s; lifting anyway");

            return;
        end;

        if v110 <= os.clock() then
            v110 = os.clock() + 3;
            local HumanoidRootPart = p108:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                task.spawn(function() -- Line: 789
                    -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy)
                    pcall(function() -- Line: 790
                        -- upvalues: LocalPlayer (ref), HumanoidRootPart (ref)
                        LocalPlayer:RequestStreamAroundAsync(HumanoidRootPart.Position, 5);
                    end);
                end);
            end;
        end;

        task.wait(0.25);
    end;
end;

local function hideDossier() -- Line: 800
    -- upvalues: u10 (ref), u75 (ref)
    if not u10 then
        return;
    end;

    u75 = u75 + 1;
    u10.GroupTransparency = 1;
end;

task.spawn(function() -- Line: 809
    -- upvalues: u11 (ref), u10 (ref), u95 (ref), DeathInsuranceUI (copy), u75 (ref), TweenService (copy), u9 (ref), RequestRespawn (copy)
    while not u11 do
        task.wait(0.1);
    end;

    u11.MouseButton1Click:Connect(function() -- Line: 811
        -- upvalues: u10 (ref), u95 (ref), DeathInsuranceUI (ref), u75 (ref), TweenService (ref), u9 (ref), RequestRespawn (ref)
        if u10.GroupTransparency > 0.5 then
            return;
        end;

        if u95 then
            return;
        end;

        u95 = true;

        if DeathInsuranceUI.PurchasePending() then
            DeathInsuranceUI.ShowError("Finishing your purchase. Try again in a moment.");
            u95 = false;

            return;
        end;

        if DeathInsuranceUI.HasSelection() then
            local v111, v112 = DeathInsuranceUI.Commit();

            if not v111 then
                u95 = false;
                DeathInsuranceUI.ShowError(v112 or "Could not insure those items.");

                return;
            end;
        end;

        if u10 then
            u75 = u75 + 1;
            u10.GroupTransparency = 1;
        end;

        TweenService:Create(u9, TweenInfo.new(0.35), {
            BackgroundTransparency = 0
        }):Play();
        RequestRespawn:FireServer();
        local os_clock_ret = os.clock();
        task.delay(20, function() -- Line: 841
            -- upvalues: u95 (ref), os_clock_ret (copy), u10 (ref)
            if u95 and os.clock() - os_clock_ret >= 19.9 then
                u95 = false;
                u10.GroupTransparency = 0;
                warn("[DeathScreenClient] no character after " .. 20 .. "s; RESPAWN re-enabled");
            end;
        end);
    end);
    DeathInsuranceUI.OnChanged(function() -- Line: 850
        -- upvalues: DeathInsuranceUI (ref), u11 (ref)
        if DeathInsuranceUI.HasSelection() then
            u11.Text = "INSURE AND RESPAWN  " .. tostring(DeathInsuranceUI.Total()):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " ₽";
            u11.TextSize = 30;

            return;
        end;

        u11.Text = "R E S P A W N";
        u11.TextSize = 40;
    end);
    local u113 = u11:FindFirstChildOfClass("UIStroke");
    u11.MouseEnter:Connect(function() -- Line: 861
        -- upvalues: u113 (copy), u11 (ref)
        if u113 then
            u113.Color = Color3.fromRGB(255, 245, 220);
        end;

        u11.BackgroundColor3 = Color3.fromRGB(55, 50, 44);
    end);
    u11.MouseLeave:Connect(function() -- Line: 865
        -- upvalues: u113 (copy), u11 (ref)
        if u113 then
            u113.Color = Color3.fromRGB(180, 170, 150);
        end;

        u11.BackgroundColor3 = Color3.fromRGB(35, 33, 30);
    end);
end);
ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LostItems").OnClientEvent:Connect(function(p114) -- Line: 874
    -- upvalues: u3 (ref), u63 (ref), u64 (ref), u12 (copy), ReportFormat (copy), RunService (copy), DeathInsuranceUI (copy), renderLoot (copy), renderWorn (copy)
    if type(p114) ~= "table" then
        return;
    end;

    if p114.roubles ~= nil and (p114.items == nil and p114[1] == nil) then
        u3.roubles = tonumber(p114.roubles) or 0;

        if u3.shown then
            local u115 = u63;
            local roubles = u3.roubles;
            local u116 = u63;
            local u117 = u64;
            u63 = u115;
            u64 = roubles;

            local function _(p118, p119) -- Line: 591
                -- upvalues: u12 (ref), ReportFormat (ref)
                u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(p118);
                u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(p119);
                u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(p118 + p119);
            end;

            local os_clock_ret = os.clock();
            task.spawn(function() -- Line: 598
                -- upvalues: os_clock_ret (copy), u116 (copy), u115 (copy), u117 (copy), roubles (copy), u12 (ref), ReportFormat (ref), RunService (ref)
                while true do
                    local v120 = (os.clock() - os_clock_ret) / 0.35;
                    local math_clamp_ret = math.clamp(v120, 0, 1);
                    local v121 = u116 + (u115 - u116) * math_clamp_ret;
                    local v122 = u117 + (roubles - u117) * math_clamp_ret;
                    u12.itemsTotal.Text = "₽" .. " " .. ReportFormat.Money(v121);
                    u12.roublesTotal.Text = "₽" .. " " .. ReportFormat.Money(v122);
                    u12.grandTotal.Text = "₽" .. " " .. ReportFormat.Money(v121 + v122);

                    if math_clamp_ret >= 1 then
                        break;
                    end;

                    RunService.RenderStepped:Wait();
                end;
            end);
        end;

        return;
    end;

    u3.items = p114.items or p114;
    u3.worn = p114.worn or {};

    if p114.insurance then
        DeathInsuranceUI.SetOffer(p114.insurance);
    end;

    if u3.shown then
        renderLoot();
        renderWorn();
    end;
end);
PlayDeathScreen.OnClientEvent:Connect(function(p123) -- Line: 892
    -- upvalues: u3 (ref), u12 (copy), u2 (ref), playInstantDeath (copy)
    local v124 = type(p123) == "table" and p123 and p123 or {};

    if v124.stats then
        u3.stats = v124.stats;

        if u3.shown then
            if not u12.deaths then
                return;
            end;

            local stats = u3.stats;

            if not stats then
                u12.deaths.Text = "-";

                return;
            end;

            if stats.wipe then
                u12.deaths.Text = ("%d this wipe   /   %d all time"):format(stats.wipe, stats.life);

                return;
            end;

            u12.deaths.Text = ("%d all time"):format(stats.life);
        end;

        return;
    end;

    if u2 then
        return;
    end;

    u2 = true;
    u3.report = v124.report;
    print(string.format("[DeathScreenClient] Death received: cause=%s", (tostring(v124.cause))));
    playInstantDeath();
end);
LocalPlayer.CharacterAdded:Connect(function() -- Line: 909
    -- upvalues: u2 (ref), RunService (copy), CurrentCamera (copy), u3 (ref), DeathInsuranceUI (copy), u95 (ref), u8 (ref), u10 (ref), u75 (ref), LocalPlayer (copy), waitForGround (copy), TweenService (copy), u9 (ref), Sound (copy), fadeWorldVolume (copy), restoreWorldVolume (copy)
    u2 = false;
    pcall(function() -- Line: 92
        -- upvalues: RunService (ref)
        RunService:UnbindFromRenderStep("DeathScreenMouseFree");
    end);
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u3 = {
        report = nil,
        stats = nil,
        items = nil,
        worn = nil,
        roubles = 0,
        shown = false
    };
    DeathInsuranceUI.Clear();
    local v125 = u95;
    u95 = false;

    if u8 then
        if u10 then
            u75 = u75 + 1;
            u10.GroupTransparency = 1;
        end;

        if v125 and u8.Enabled then
            task.spawn(function(p126) -- Line: 923
                -- upvalues: LocalPlayer (ref), waitForGround (ref), TweenService (ref), u9 (ref), u2 (ref), u8 (ref)
                local u127;

                if p126 then
                    u127 = p126:WaitForChild("HumanoidRootPart", 5);
                else
                    u127 = p126;
                end;

                if u127 and workspace.StreamingEnabled then
                    local success, result = pcall(function() -- Line: 928
                        -- upvalues: LocalPlayer (ref), u127 (copy)
                        LocalPlayer:RequestStreamAroundAsync(u127.Position, 15);
                    end);

                    if not success then
                        warn("[DeathScreenClient] respawn stream failed, lifting anyway: " .. tostring(result));
                    end;

                    waitForGround(p126);
                end;

                task.wait(0.25);
                local v128 = TweenService:Create(u9, TweenInfo.new(0.6), {
                    BackgroundTransparency = 1
                });
                v128:Play();
                v128.Completed:Wait();

                if not u2 then
                    u8.Enabled = false;
                end;
            end, LocalPlayer.Character);
        else
            u8.Enabled = false;
            u9.BackgroundTransparency = 1;
        end;
    end;

    if Sound.IsPlaying then
        Sound:Stop();
    end;

    fadeWorldVolume(1, 0.5);
    task.delay(0.6, restoreWorldVolume);
end);
print("[DeathScreenClient] Initialized (after-action report)");