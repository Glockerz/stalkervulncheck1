-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Color3_fromRGB_ret = Color3.fromRGB(25, 27, 24);
local Color3_fromRGB_ret2 = Color3.fromRGB(48, 48, 48);
local Color3_fromRGB_ret3 = Color3.fromRGB(190, 190, 190);
local Color3_fromRGB_ret4 = Color3.fromRGB(210, 200, 150);
local Color3_fromRGB_ret5 = Color3.fromRGB(230, 150, 70);
local Color3_fromRGB_ret6 = Color3.fromRGB(220, 90, 90);
local Color3_fromRGB_ret7 = Color3.fromRGB(150, 190, 220);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "TruceHud";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 56;
ScreenGui.Enabled = false;
ScreenGui.Parent = PlayerGui;
local Frame = Instance.new("Frame");
Frame.Name = "Card";
Frame.Size = UDim2.fromOffset(190, 46);
Frame.AnchorPoint = Vector2.new(0.5, 0);
Frame.Position = UDim2.new(0.5, 0, 0, 214);
Frame.BackgroundColor3 = Color3_fromRGB_ret;
Frame.BackgroundTransparency = 0.25;
Frame.BorderSizePixel = 0;
Frame.Parent = ScreenGui;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3_fromRGB_ret2;
UIStroke.Thickness = 1;
UIStroke.Parent = Frame;
local Frame2 = Instance.new("Frame");
Frame2.Name = "Bar";
Frame2.Size = UDim2.new(0, 4, 1, 0);
Frame2.BackgroundColor3 = Color3_fromRGB_ret4;
Frame2.BorderSizePixel = 0;
Frame2.Parent = Frame;
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Caption";
TextLabel.BackgroundTransparency = 1;
TextLabel.Position = UDim2.fromOffset(14, 5);
TextLabel.Size = UDim2.new(1, -20, 0, 14);
TextLabel.FontFace = Font_new_ret2;
TextLabel.TextSize = 13;
TextLabel.TextColor3 = Color3_fromRGB_ret3;
TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel.Text = "CEASEFIRE";
TextLabel.Parent = Frame;
local TextLabel2 = Instance.new("TextLabel");
TextLabel2.Name = "Clock";
TextLabel2.BackgroundTransparency = 1;
TextLabel2.Position = UDim2.fromOffset(14, 18);
TextLabel2.Size = UDim2.new(1, -20, 0, 24);
TextLabel2.FontFace = Font_new_ret;
TextLabel2.TextSize = 22;
TextLabel2.TextColor3 = Color3_fromRGB_ret4;
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel2.Text = "0:00";
TextLabel2.Parent = Frame;

local function mmss(p1) -- Line: 88
    local math_floor_ret = math.floor(p1);
    local math_max_ret = math.max(0, math_floor_ret);

    return string.format("%d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60);
end;

local u2 = 0;

local function refresh(p3) -- Line: 97
    -- upvalues: LocalPlayer (copy), ScreenGui (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret4 (copy), TextLabel2 (copy), Frame2 (copy), TextLabel (copy), u2 (ref), Frame (copy)
    local v4 = tonumber(LocalPlayer:GetAttribute("MT_TruceUntil"));
    local v5 = tonumber(LocalPlayer:GetAttribute("MT_TrucePaused"));

    if not v4 then
        ScreenGui.Enabled = false;

        return;
    end;

    local v6 = v5 or v4 - os.time();

    if v6 <= 0 and not v5 then
        ScreenGui.Enabled = false;

        return;
    end;

    ScreenGui.Enabled = true;
    local v7, v8;

    if v5 then
        v7 = Color3_fromRGB_ret7;
        v8 = "CEASEFIRE  (HELD)";
    else
        v7 = v6 <= 15 and Color3_fromRGB_ret6 or (v6 <= 60 and Color3_fromRGB_ret5 or Color3_fromRGB_ret4);
        v8 = "CEASEFIRE";
    end;

    local math_floor_ret = math.floor(v6);
    local math_max_ret = math.max(0, math_floor_ret);
    TextLabel2.Text = string.format("%d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60);
    TextLabel2.TextColor3 = v7;
    Frame2.BackgroundColor3 = v7;
    TextLabel.Text = v8;

    if v5 or v6 > 15 then
        u2 = 0;
        Frame.BackgroundTransparency = 0.25;

        return;
    end;

    u2 = u2 + (p3 or 0);
    local math_sin_ret = math.sin(u2 * 3);
    Frame.BackgroundTransparency = math.abs(math_sin_ret) * 0.2 + 0.25;
end;

RunService.RenderStepped:Connect(refresh);
LocalPlayer:GetAttributeChangedSignal("MT_TruceUntil"):Connect(function() -- Line: 140
    -- upvalues: refresh (copy)
    refresh(0);
end);
LocalPlayer:GetAttributeChangedSignal("MT_TrucePaused"):Connect(function() -- Line: 141
    -- upvalues: refresh (copy)
    refresh(0);
end);
refresh(0);