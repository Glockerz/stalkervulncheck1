-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local ShowWelcomePopup = Remotes:WaitForChild("ShowWelcomePopup");
local ReshowWelcomePopup = Remotes:WaitForChild("ReshowWelcomePopup");
local v1 = {
    {
        section = "Movement"
    },
    {
        key = "WASD",
        desc = "Move"
    },
    {
        key = "Shift",
        desc = "Sprint (forward only)"
    },
    {
        key = "Space",
        desc = "Jump"
    },
    {
        section = "Combat"
    },
    {
        key = "Left Click",
        desc = "Fire"
    },
    {
        key = "Right Click",
        desc = "Aim down sights"
    },
    {
        key = "R",
        desc = "Reload"
    },
    {
        key = "F",
        desc = "Chamber (manually chamber your gun)"
    },
    {
        key = "B",
        desc = "Switch fire mode (semi / auto)"
    },
    {
        section = "Interface"
    },
    {
        key = "P",
        desc = "PDA - map, contacts, tasks"
    },
    {
        key = "Tab",
        desc = "Inventory - drag, drop, reload, use items"
    },
    {
        key = "M",
        desc = "Hood up / down (uniforms with a hood)"
    },
    {
        key = "1-4",
        desc = "Draw weapon (Primary / Secondary / Sidearm / Melee)"
    },
    {
        key = "F1-F4",
        desc = "Use quick-consumable"
    },
    {
        key = "F5",
        desc = "Reopen this welcome menu"
    },
    {
        section = "HUD / Compass"
    },
    {
        key = "Yellow icon",
        desc = "Friendly stalker on the radial compass"
    },
    {
        key = "Red icon",
        desc = "Hostile stalker on the radial compass"
    },
    {
        key = "Red marker",
        desc = "Task objective - kill, clear, or hunt target"
    },
    {
        key = "Yellow marker",
        desc = "Task objective - return to trader to turn in"
    },
    {
        key = "Blue marker",
        desc = "Task objective - explore a zone or drop a deposit"
    }
};
local UITheme = require(ReplicatedStorage:WaitForChild("InventoryController"):WaitForChild("UITheme"));
local C = UITheme.C;
local HEADER_FONT = UITheme.HEADER_FONT;
local BODY_FONT = UITheme.BODY_FONT;
local BODY_FONT_BOLD = UITheme.BODY_FONT_BOLD;
local Color3_fromRGB_ret = Color3.fromRGB(20, 18, 15);
local Color3_fromRGB_ret2 = Color3.fromRGB(38, 31, 21);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "WelcomePopupGui";
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 200;
ScreenGui.Enabled = false;
ScreenGui.Parent = PlayerGui;
local Frame = Instance.new("Frame");
Frame.Name = "Dim";
Frame.Size = UDim2.fromScale(1, 1);
Frame.BackgroundColor3 = Color3.new(0, 0, 0);
Frame.BackgroundTransparency = 0.4;
Frame.BorderSizePixel = 0;
Frame.Parent = ScreenGui;
local Frame2 = Instance.new("Frame");
Frame2.Name = "Panel";
Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
Frame2.Position = UDim2.fromScale(0.5, 0.5);
Frame2.Size = UDim2.fromOffset(640, 640);
Frame2.BackgroundColor3 = C.panel;
Frame2.BorderSizePixel = 0;
Frame2.Parent = ScreenGui;
local UIScale = Instance.new("UIScale");
UIScale.Parent = Frame2;

local function fitPanel() -- Line: 103
    -- upvalues: UIScale (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    UIScale.Scale = math.clamp(((workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize.Y or 1080) - 40) / 640, 0.6, 1);
end;

local workspace_CurrentCamera = workspace.CurrentCamera;
UIScale.Scale = math.clamp(((workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize.Y or 1080) - 40) / 640, 0.6, 1);

if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fitPanel);
end;

local function stroke(p2, p3) -- Line: 113
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p3;
    UIStroke.Thickness = 1;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = p2;

    return UIStroke;
end;

local edge = C.edge;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = edge;
UIStroke.Thickness = 1;
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
UIStroke.Parent = Frame2;
local Frame3 = Instance.new("Frame");
Frame3.Name = "Inner";
Frame3.Position = UDim2.fromOffset(6, 6);
Frame3.Size = UDim2.new(1, -12, 1, -12);
Frame3.BackgroundTransparency = 1;
Frame3.BorderSizePixel = 0;
Frame3.Active = false;
Frame3.Parent = Frame2;
local inner = C.inner;
local UIStroke2 = Instance.new("UIStroke");
UIStroke2.Color = inner;
UIStroke2.Thickness = 1;
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
UIStroke2.Parent = Frame3;

local function label(p4, p5, p6, p7, p8) -- Line: 134
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = p5;
    TextLabel.TextSize = p6;
    TextLabel.TextColor3 = p7;
    TextLabel.Text = p8 or "";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = p4;

    return TextLabel;
end;

local function mark(p9, p10, p11, p12) -- Line: 146
    -- upvalues: C (copy)
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Mark";
    Frame4.Position = UDim2.fromOffset(p10, p11);
    Frame4.Size = UDim2.fromOffset(3, p12);
    Frame4.BackgroundColor3 = C.amber;
    Frame4.BorderSizePixel = 0;
    Frame4.Parent = p9;

    return Frame4;
end;

local Frame4 = Instance.new("Frame");
Frame4.Name = "Header";
Frame4.Position = UDim2.fromOffset(6, 6);
Frame4.Size = UDim2.new(1, -12, 0, 64);
Frame4.BackgroundColor3 = C.header;
Frame4.BorderSizePixel = 0;
Frame4.Parent = Frame2;
local Frame5 = Instance.new("Frame");
Frame5.Name = "Mark";
Frame5.Position = UDim2.fromOffset(16, 12);
Frame5.Size = UDim2.fromOffset(3, 38);
Frame5.BackgroundColor3 = C.amber;
Frame5.BorderSizePixel = 0;
Frame5.Parent = Frame4;
local paper = C.paper;
local string_upper_ret = string.upper("Welcome to the Zone");
local TextLabel = Instance.new("TextLabel");
TextLabel.BackgroundTransparency = 1;
TextLabel.FontFace = HEADER_FONT;
TextLabel.TextSize = 28;
TextLabel.TextColor3 = paper;
TextLabel.Text = string_upper_ret or "";
TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel.Parent = Frame4;
TextLabel.Position = UDim2.fromOffset(28, 8);
TextLabel.Size = UDim2.new(1, -40, 0, 32);
local dim = C.dim;
local TextLabel2 = Instance.new("TextLabel");
TextLabel2.BackgroundTransparency = 1;
TextLabel2.FontFace = BODY_FONT;
TextLabel2.TextSize = 14;
TextLabel2.TextColor3 = dim;
TextLabel2.Text = "Read it once. F5 brings it back any time.";
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel2.Parent = Frame4;
TextLabel2.Position = UDim2.fromOffset(28, 39);
TextLabel2.Size = UDim2.new(1, -40, 0, 18);
local ScrollingFrame = Instance.new("ScrollingFrame");
ScrollingFrame.Name = "Body";
ScrollingFrame.Position = UDim2.fromOffset(6, 70);
ScrollingFrame.Size = UDim2.new(1, -12, 1, -134);
ScrollingFrame.BackgroundTransparency = 1;
ScrollingFrame.BorderSizePixel = 0;
ScrollingFrame.ScrollBarThickness = 5;
ScrollingFrame.ScrollBarImageColor3 = C.edge;
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
ScrollingFrame.CanvasSize = UDim2.new();
ScrollingFrame.Parent = Frame2;
local UIListLayout = Instance.new("UIListLayout");
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout.Padding = UDim.new(0, 4);
UIListLayout.Parent = ScrollingFrame;
local UIPadding = Instance.new("UIPadding");
UIPadding.PaddingTop = UDim.new(0, 16);
UIPadding.PaddingBottom = UDim.new(0, 16);
UIPadding.PaddingLeft = UDim.new(0, 22);
UIPadding.PaddingRight = UDim.new(0, 22);
UIPadding.Parent = ScrollingFrame;
local u13 = 0;

local function nextOrder() -- Line: 200
    -- upvalues: u13 (ref)
    u13 = u13 + 1;

    return u13;
end;

local function paragraph(p14) -- Line: 202
    -- upvalues: ScrollingFrame (copy), BODY_FONT (copy), C (copy), u13 (ref)
    local text = C.text;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = BODY_FONT;
    TextLabel3.TextSize = 16;
    TextLabel3.TextColor3 = text;
    TextLabel3.Text = p14 or "";
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Parent = ScrollingFrame;
    TextLabel3.Size = UDim2.new(1, 0, 0, 0);
    TextLabel3.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel3.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel3.TextWrapped = true;
    TextLabel3.LineHeight = 1.1;
    u13 = u13 + 1;
    TextLabel3.LayoutOrder = u13;

    return TextLabel3;
end;

local function spacer(p15) -- Line: 213
    -- upvalues: u13 (ref), ScrollingFrame (copy)
    local Frame6 = Instance.new("Frame");
    Frame6.Size = UDim2.new(1, 0, 0, p15);
    Frame6.BackgroundTransparency = 1;
    u13 = u13 + 1;
    Frame6.LayoutOrder = u13;
    Frame6.Parent = ScrollingFrame;
end;

local function callout(p16, p17) -- Line: 222
    -- upvalues: Color3_fromRGB_ret2 (copy), u13 (ref), ScrollingFrame (copy), C (copy), HEADER_FONT (copy), BODY_FONT (copy)
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "Callout";
    Frame6.Size = UDim2.new(1, 0, 0, 0);
    Frame6.AutomaticSize = Enum.AutomaticSize.Y;
    Frame6.BackgroundColor3 = Color3_fromRGB_ret2;
    Frame6.BorderSizePixel = 0;
    u13 = u13 + 1;
    Frame6.LayoutOrder = u13;
    Frame6.Parent = ScrollingFrame;
    local Color3_fromRGB_ret3 = Color3.fromRGB(90, 68, 38);
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = Color3_fromRGB_ret3;
    UIStroke3.Thickness = 1;
    UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke3.Parent = Frame6;
    local Frame7 = Instance.new("Frame");
    Frame7.Size = UDim2.new(0, 3, 1, 0);
    Frame7.BackgroundColor3 = C.amber;
    Frame7.BorderSizePixel = 0;
    Frame7.Parent = Frame6;
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "Content";
    Frame8.Size = UDim2.new(1, 0, 0, 0);
    Frame8.AutomaticSize = Enum.AutomaticSize.Y;
    Frame8.BackgroundTransparency = 1;
    Frame8.Parent = Frame6;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.PaddingTop = UDim.new(0, 10);
    UIPadding2.PaddingBottom = UDim.new(0, 10);
    UIPadding2.PaddingLeft = UDim.new(0, 16);
    UIPadding2.PaddingRight = UDim.new(0, 12);
    UIPadding2.Parent = Frame8;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Padding = UDim.new(0, 2);
    UIListLayout2.Parent = Frame8;
    local amber = C.amber;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = HEADER_FONT;
    TextLabel3.TextSize = 16;
    TextLabel3.TextColor3 = amber;
    TextLabel3.Text = p16 or "";
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Parent = Frame8;
    TextLabel3.Size = UDim2.new(1, 0, 0, 20);
    TextLabel3.LayoutOrder = 1;
    local text = C.text;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = BODY_FONT;
    TextLabel4.TextSize = 15;
    TextLabel4.TextColor3 = text;
    TextLabel4.Text = p17 or "";
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel4.Parent = Frame8;
    TextLabel4.Size = UDim2.new(1, 0, 0, 0);
    TextLabel4.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel4.TextWrapped = true;
    TextLabel4.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel4.LayoutOrder = 2;
end;

local function sectionHeader(p18) -- Line: 271
    -- upvalues: u13 (ref), ScrollingFrame (copy), C (copy), HEADER_FONT (copy)
    local Frame6 = Instance.new("Frame");
    Frame6.Size = UDim2.new(1, 0, 0, 8);
    Frame6.BackgroundTransparency = 1;
    u13 = u13 + 1;
    Frame6.LayoutOrder = u13;
    Frame6.Parent = ScrollingFrame;
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "Section";
    Frame7.Size = UDim2.new(1, 0, 0, 26);
    Frame7.BackgroundTransparency = 1;
    u13 = u13 + 1;
    Frame7.LayoutOrder = u13;
    Frame7.Parent = ScrollingFrame;
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "Mark";
    Frame8.Position = UDim2.fromOffset(0, 4);
    Frame8.Size = UDim2.fromOffset(3, 18);
    Frame8.BackgroundColor3 = C.amber;
    Frame8.BorderSizePixel = 0;
    Frame8.Parent = Frame7;
    local paper2 = C.paper;
    local string_upper_ret2 = string.upper(p18);
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = HEADER_FONT;
    TextLabel3.TextSize = 17;
    TextLabel3.TextColor3 = paper2;
    TextLabel3.Text = string_upper_ret2 or "";
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Parent = Frame7;
    TextLabel3.Position = UDim2.fromOffset(10, 0);
    TextLabel3.Size = UDim2.new(1, -10, 1, 0);
    local Frame9 = Instance.new("Frame");
    Frame9.Size = UDim2.new(1, 0, 0, 1);
    Frame9.Position = UDim2.new(0, 0, 1, -1);
    Frame9.BackgroundColor3 = C.line;
    Frame9.BorderSizePixel = 0;
    Frame9.Parent = Frame7;
end;

local u19 = 0;

local function controlRow(p20, p21) -- Line: 293
    -- upvalues: u19 (ref), C (copy), u13 (ref), ScrollingFrame (copy), BODY_FONT_BOLD (copy), BODY_FONT (copy)
    u19 = u19 + 1;
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "Row";
    Frame6.Size = UDim2.new(1, 0, 0, 28);
    Frame6.AutomaticSize = Enum.AutomaticSize.Y;
    Frame6.BackgroundColor3 = C.row;
    Frame6.BackgroundTransparency = u19 % 2 == 0 and 0.55 or 1;
    Frame6.BorderSizePixel = 0;
    u13 = u13 + 1;
    Frame6.LayoutOrder = u13;
    Frame6.Parent = ScrollingFrame;
    local paper2 = C.paper;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = BODY_FONT_BOLD;
    TextLabel3.TextSize = 14;
    TextLabel3.TextColor3 = paper2;
    TextLabel3.Text = p20 or "";
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Parent = Frame6;
    TextLabel3.Name = "Key";
    TextLabel3.Position = UDim2.fromOffset(4, 4);
    TextLabel3.Size = UDim2.fromOffset(0, 20);
    TextLabel3.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel3.BackgroundTransparency = 0;
    TextLabel3.BackgroundColor3 = C.header;
    local edge2 = C.edge;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = edge2;
    UIStroke3.Thickness = 1;
    UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke3.Parent = TextLabel3;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.PaddingLeft = UDim.new(0, 8);
    UIPadding2.PaddingRight = UDim.new(0, 8);
    UIPadding2.Parent = TextLabel3;
    local UISizeConstraint = Instance.new("UISizeConstraint");
    UISizeConstraint.MaxSize = Vector2.new(138, 28);
    UISizeConstraint.Parent = TextLabel3;
    local text = C.text;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = BODY_FONT;
    TextLabel4.TextSize = 15;
    TextLabel4.TextColor3 = text;
    TextLabel4.Text = p21 or "";
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel4.Parent = Frame6;
    TextLabel4.Name = "Desc";
    TextLabel4.Position = UDim2.fromOffset(150, 0);
    TextLabel4.Size = UDim2.new(1, -154, 0, 28);
    TextLabel4.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel4.TextWrapped = true;
    TextLabel4.TextYAlignment = Enum.TextYAlignment.Center;
    local UIPadding3 = Instance.new("UIPadding");
    UIPadding3.PaddingTop = UDim.new(0, 5);
    UIPadding3.PaddingBottom = UDim.new(0, 5);
    UIPadding3.Parent = TextLabel4;
end;

paragraph("Zone STALKER is a hardcore atmospheric extraction survival game set inside a hostile, abandoned Zone. Scavenge for supplies, complete tasks, survive anomalies, fight mutants and enemies, then return to safety with your loot before death takes it all.");
local Frame6 = Instance.new("Frame");
Frame6.Size = UDim2.new(1, 0, 0, 6);
Frame6.BackgroundTransparency = 1;
u13 = u13 + 1;
Frame6.LayoutOrder = u13;
Frame6.Parent = ScrollingFrame;
callout(
    "PRE-ALPHA",
    "This game is in early pre-alpha and only represents a small part of the planned experience. Expect bugs, missing features, balance changes, wipes, and frequent updates."
);

for _, v in ipairs(v1) do
    if v.section then
        u19 = 0;
        sectionHeader(v.section);
    else
        controlRow(v.key, v.desc);
    end;
end;

local Frame7 = Instance.new("Frame");
Frame7.Name = "Footer";
Frame7.Position = UDim2.new(0, 6, 1, -64);
Frame7.Size = UDim2.new(1, -12, 0, 58);
Frame7.BackgroundColor3 = C.header;
Frame7.BorderSizePixel = 0;
Frame7.Parent = Frame2;
local faint = C.faint;
local TextLabel3 = Instance.new("TextLabel");
TextLabel3.BackgroundTransparency = 1;
TextLabel3.FontFace = BODY_FONT;
TextLabel3.TextSize = 14;
TextLabel3.TextColor3 = faint;
TextLabel3.Text = "ESC to close  /  F5 to reopen";
TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel3.Parent = Frame7;
TextLabel3.Position = UDim2.fromOffset(20, 0);
TextLabel3.Size = UDim2.new(1, -240, 1, 0);
local TextButton = Instance.new("TextButton");
TextButton.Name = "GotItButton";
TextButton.AnchorPoint = Vector2.new(1, 0.5);
TextButton.Position = UDim2.new(1, -16, 0.5, 0);
TextButton.Size = UDim2.fromOffset(190, 38);
TextButton.BackgroundColor3 = C.amber;
TextButton.BorderSizePixel = 0;
TextButton.AutoButtonColor = false;
TextButton.FontFace = HEADER_FONT;
TextButton.Text = "GOT IT";
TextButton.TextColor3 = Color3_fromRGB_ret;
TextButton.TextSize = 19;
TextButton.Parent = Frame7;
local u22 = C.amber:Lerp(Color3.new(1, 1, 1), 0.15);
local TweenInfo_new_ret = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
TextButton.MouseEnter:Connect(function() -- Line: 378
    -- upvalues: TweenService (copy), TextButton (copy), TweenInfo_new_ret (copy), u22 (copy)
    TweenService:Create(TextButton, TweenInfo_new_ret, {
        BackgroundColor3 = u22
    }):Play();
end);
TextButton.MouseLeave:Connect(function() -- Line: 381
    -- upvalues: TweenService (copy), TextButton (copy), TweenInfo_new_ret (copy), C (copy)
    TweenService:Create(TextButton, TweenInfo_new_ret, {
        BackgroundColor3 = C.amber
    }):Play();
end);

local function freeMouseTick() -- Line: 390
    -- upvalues: UserInputService (copy)
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    UserInputService.MouseIconEnabled = true;
end;

TextButton.MouseButton1Click:Connect(function() -- Line: 402, Name: hide
    -- upvalues: ScreenGui (copy), RunService (copy)
    ScreenGui.Enabled = false;
    pcall(function() -- Line: 404
        -- upvalues: RunService (ref)
        RunService:UnbindFromRenderStep("WelcomePopup_FreeMouse");
    end);
end);
ContextActionService:BindAction("WelcomePopup_Dismiss", function(p23, p24) -- Line: 410
    -- upvalues: ScreenGui (copy), RunService (copy)
    if p24 ~= Enum.UserInputState.Begin or not ScreenGui.Enabled then
        return Enum.ContextActionResult.Pass;
    end;

    ScreenGui.Enabled = false;
    pcall(function() -- Line: 404
        -- upvalues: RunService (ref)
        RunService:UnbindFromRenderStep("WelcomePopup_FreeMouse");
    end);

    return Enum.ContextActionResult.Sink;
end, false, Enum.KeyCode.Escape);
ContextActionService:BindAction("WelcomePopup_Reopen", function(p25, p26) -- Line: 421
    -- upvalues: ScreenGui (copy), ReshowWelcomePopup (copy)
    if p26 ~= Enum.UserInputState.Begin or ScreenGui.Enabled then
        return Enum.ContextActionResult.Pass;
    end;

    ReshowWelcomePopup:FireServer();

    return Enum.ContextActionResult.Sink;
end, false, Enum.KeyCode.F5);
ShowWelcomePopup.OnClientEvent:Connect(function() -- Line: 395, Name: show
    -- upvalues: ScreenGui (copy), ScrollingFrame (copy), RunService (copy), freeMouseTick (copy)
    ScreenGui.Enabled = true;
    ScrollingFrame.CanvasPosition = Vector2.new(0, 0);
    pcall(function() -- Line: 398
        -- upvalues: RunService (ref)
        RunService:UnbindFromRenderStep("WelcomePopup_FreeMouse");
    end);
    RunService:BindToRenderStep("WelcomePopup_FreeMouse", Enum.RenderPriority.Last.Value + 1, freeMouseTick);
end);
print("[WelcomePopupClient] ready");