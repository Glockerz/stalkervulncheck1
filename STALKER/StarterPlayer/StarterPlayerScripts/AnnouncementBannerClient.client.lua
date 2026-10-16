-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local UITheme = require(ReplicatedStorage:WaitForChild("InventoryController"):WaitForChild("UITheme"));
local C = UITheme.C;
local success, result = pcall(function() -- Line: 18
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("PdaSound"));
end);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local AnnouncementShow = Remotes:WaitForChild("AnnouncementShow");
local AnnouncementGet = Remotes:WaitForChild("AnnouncementGet");
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "AnnouncementBanner";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 900;
ScreenGui.IgnoreGuiInset = false;
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local Frame = Instance.new("Frame");
Frame.Name = "Banner";
Frame.AnchorPoint = Vector2.new(0.5, 0);
Frame.Position = UDim2.new(0.5, 0, 0, 132);
Frame.Size = UDim2.new(0.9, 0, 0, 0);
Frame.AutomaticSize = Enum.AutomaticSize.Y;
Frame.BackgroundColor3 = C.panel;
Frame.BackgroundTransparency = 0.06;
Frame.BorderSizePixel = 0;
Frame.Visible = false;
Frame.Parent = ScreenGui;
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 2);
local UISizeConstraint = Instance.new("UISizeConstraint");
UISizeConstraint.MaxSize = Vector2.new(720, (1 / 0));
UISizeConstraint.Parent = Frame;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = C.edge;
UIStroke.Thickness = 1;
UIStroke.Parent = Frame;
local Frame2 = Instance.new("Frame");
Frame2.BackgroundTransparency = 1;
Frame2.Size = UDim2.new(1, 0, 0, 0);
Frame2.AutomaticSize = Enum.AutomaticSize.Y;
Frame2.Parent = Frame;
local UIPadding = Instance.new("UIPadding");
local UDim_new_ret = UDim.new(0, 9);
local UDim_new_ret2 = UDim.new(0, 10);
UIPadding.PaddingTop = UDim_new_ret;
UIPadding.PaddingBottom = UDim_new_ret2;
local UDim_new_ret3 = UDim.new(0, 18);
local UDim_new_ret4 = UDim.new(0, 40);
UIPadding.PaddingLeft = UDim_new_ret3;
UIPadding.PaddingRight = UDim_new_ret4;
UIPadding.Parent = Frame2;
local UIListLayout = Instance.new("UIListLayout");
UIListLayout.Padding = UDim.new(0, 2);
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout.Parent = Frame2;
local Frame3 = Instance.new("Frame");
Frame3.BackgroundColor3 = C.amber;
Frame3.BorderSizePixel = 0;
Frame3.Position = UDim2.fromOffset(6, 9);
Frame3.Size = UDim2.new(0, 3, 1, -18);
Frame3.Parent = Frame;
local TextLabel = Instance.new("TextLabel");
TextLabel.LayoutOrder = 1;
TextLabel.BackgroundTransparency = 1;
TextLabel.Size = UDim2.new(1, 0, 0, 18);
TextLabel.FontFace = UITheme.HEADER_FONT;
TextLabel.TextSize = 16;
TextLabel.TextColor3 = C.amber;
TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel.Text = "ANNOUNCEMENT";
TextLabel.Parent = Frame2;
local TextLabel2 = Instance.new("TextLabel");
TextLabel2.LayoutOrder = 2;
TextLabel2.BackgroundTransparency = 1;
TextLabel2.Size = UDim2.new(1, 0, 0, 0);
TextLabel2.AutomaticSize = Enum.AutomaticSize.Y;
TextLabel2.FontFace = UITheme.BODY_FONT;
TextLabel2.TextSize = 19;
TextLabel2.TextColor3 = C.paper;
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel2.TextWrapped = true;
TextLabel2.Text = "";
TextLabel2.Parent = Frame2;
local TextButton = Instance.new("TextButton");
TextButton.Name = "Close";
TextButton.AnchorPoint = Vector2.new(1, 0);
TextButton.Position = UDim2.new(1, -8, 0, 6);
TextButton.Size = UDim2.fromOffset(24, 24);
TextButton.BackgroundTransparency = 1;
TextButton.FontFace = UITheme.HEADER_FONT;
TextButton.TextSize = 18;
TextButton.TextColor3 = C.dim;
TextButton.Text = "X";
TextButton.Parent = Frame;
TextButton.MouseEnter:Connect(function() -- Line: 117
    -- upvalues: TextButton (copy), C (copy)
    TextButton.TextColor3 = C.paper;
end);
TextButton.MouseLeave:Connect(function() -- Line: 118
    -- upvalues: TextButton (copy), C (copy)
    TextButton.TextColor3 = C.dim;
end);
local u1 = {};
local u2 = nil;
local u3 = 0;

local function hide() -- Line: 124
    -- upvalues: u3 (ref), u2 (ref), Frame (copy), TweenService (copy), UIStroke (copy)
    u3 = u3 + 1;
    u2 = nil;

    if not Frame.Visible then
        return;
    end;

    local u4 = u3;
    TweenService:Create(Frame, TweenInfo.new(0.25), {
        BackgroundTransparency = 1
    }):Play();
    TweenService:Create(UIStroke, TweenInfo.new(0.25), {
        Transparency = 1
    }):Play();
    task.delay(0.25, function() -- Line: 131
        -- upvalues: u3 (ref), u4 (copy), Frame (ref)
        if u3 == u4 then
            Frame.Visible = false;
        end;
    end);
end;

local function show(p5) -- Line: 134
    -- upvalues: hide (copy), u1 (copy), u3 (ref), u2 (ref), TextLabel2 (copy), Frame (copy), UIStroke (copy), TweenService (copy), success (copy), result (copy)
    if type(p5) ~= "table" or (type(p5.id) ~= "string" or type(p5.text) ~= "string") then
        hide();

        return;
    end;

    local v6 = tonumber(p5.remaining) or 0;

    if v6 <= 0 or u1[p5.id] then
        hide();

        return;
    end;

    u3 = u3 + 1;
    local u7 = u3;
    local v8 = u2 ~= p5.id;
    u2 = p5.id;
    TextLabel2.Text = p5.text;
    Frame.BackgroundTransparency = 1;
    UIStroke.Transparency = 1;
    Frame.Visible = true;
    TweenService:Create(Frame, TweenInfo.new(0.25), {
        BackgroundTransparency = 0.06
    }):Play();
    TweenService:Create(UIStroke, TweenInfo.new(0.25), {
        Transparency = 0
    }):Play();

    if v8 and (success and result) then
        result.Play("pda_notify", 0.6);
    end;

    task.delay(v6, function() -- Line: 149
        -- upvalues: u3 (ref), u7 (copy), hide (ref)
        if u3 == u7 then
            hide();
        end;
    end);
end;

TextButton.MouseButton1Click:Connect(function() -- Line: 152
    -- upvalues: u2 (ref), u1 (copy), hide (copy)
    if u2 then
        u1[u2] = true;
    end;

    hide();
end);
AnnouncementShow.OnClientEvent:Connect(show);
task.spawn(function() -- Line: 158
    -- upvalues: AnnouncementGet (copy), u2 (ref), show (copy)
    local success2, result2 = pcall(function() -- Line: 159
        -- upvalues: AnnouncementGet (ref)
        return AnnouncementGet:InvokeServer();
    end);

    if success2 and (result2 and not u2) then
        show(result2);
    end;
end);