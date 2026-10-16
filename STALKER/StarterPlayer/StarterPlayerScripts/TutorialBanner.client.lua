-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local SetTutorialBanner = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SetTutorialBanner", 10);

if not SetTutorialBanner then
    return;
end;

local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Color3_fromRGB_ret = Color3.fromRGB(24, 26, 24);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret3 = Color3.fromRGB(235, 235, 235);
local u1 = nil;
local u2 = nil;
local u3 = nil;

local function ensureGui() -- Line: 39
    -- upvalues: u1 (ref), LocalPlayer (copy), u2 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Font_new_ret (copy), u3 (ref), Font_new_ret2 (copy), Color3_fromRGB_ret3 (copy)
    if u1 and u1.Parent then
        return;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    u1 = Instance.new("ScreenGui");
    u1.Name = "TutorialBanner";
    u1.ResetOnSpawn = false;
    u1.IgnoreGuiInset = true;
    u1.DisplayOrder = 55;
    u1.Enabled = false;
    u1.Parent = PlayerGui;
    u2 = Instance.new("Frame");
    u2.Size = UDim2.fromOffset(500, 72);
    u2.AnchorPoint = Vector2.new(0.5, 0);
    u2.Position = UDim2.new(0.5, 0, 0, 140);
    u2.BackgroundColor3 = Color3_fromRGB_ret;
    u2.BackgroundTransparency = 0.05;
    u2.BorderSizePixel = 0;
    u2.ZIndex = 55;
    u2.Parent = u1;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 6);
    UICorner.Parent = u2;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret2;
    UIStroke.Thickness = 1.5;
    UIStroke.Transparency = 0.25;
    UIStroke.Parent = u2;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(0, 5, 1, 0);
    Frame.BackgroundColor3 = Color3_fromRGB_ret2;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 56;
    Frame.Parent = u2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromOffset(46, 72);
    TextLabel.Position = UDim2.fromOffset(8, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 28;
    TextLabel.TextColor3 = Color3_fromRGB_ret2;
    TextLabel.Text = "?";
    TextLabel.ZIndex = 56;
    TextLabel.Parent = u2;
    u3 = Instance.new("TextLabel");
    u3.Position = UDim2.fromOffset(58, 6);
    u3.Size = UDim2.new(1, -70, 1, -12);
    u3.BackgroundTransparency = 1;
    u3.FontFace = Font_new_ret2;
    u3.TextSize = 16;
    u3.TextColor3 = Color3_fromRGB_ret3;
    u3.TextXAlignment = Enum.TextXAlignment.Left;
    u3.TextYAlignment = Enum.TextYAlignment.Center;
    u3.TextWrapped = true;
    u3.Text = "";
    u3.ZIndex = 56;
    u3.Parent = u2;
end;

local function show(p4) -- Line: 104
    -- upvalues: ensureGui (copy), u3 (ref), u1 (ref)
    ensureGui();
    u3.Text = tostring(p4 or "");
    u1.Enabled = true;
end;

local function hide() -- Line: 110
    -- upvalues: u1 (ref)
    if u1 then
        u1.Enabled = false;
    end;
end;

SetTutorialBanner.OnClientEvent:Connect(function(p5) -- Line: 114
    -- upvalues: ensureGui (copy), u3 (ref), u1 (ref)
    if not p5 or p5 == "" then
        if u1 then
            u1.Enabled = false;
        end;

        return;
    end;

    ensureGui();
    u3.Text = tostring(p5 or "");
    u1.Enabled = true;
end);