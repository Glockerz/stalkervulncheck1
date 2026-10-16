-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Color3_fromRGB_ret = Color3.fromRGB(220, 170, 55);
local Color3_fromRGB_ret2 = Color3.fromRGB(245, 240, 230);
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local LocationChanged = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LocationChanged");
local success, result = pcall(function() -- Line: 28
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("PdaSound"));
end);

local function playDiscoverySound() -- Line: 30
    -- upvalues: success (copy), result (copy)
    if success and result then
        result.Play("spot_discovered", 0.5);
    end;
end;

task.spawn(function() -- Line: 39
    -- upvalues: ReplicatedStorage (copy), PlayerGui (copy), success (copy), result (copy)
    local success2, result2 = pcall(function() -- Line: 40
        -- upvalues: ReplicatedStorage (ref)
        return require(ReplicatedStorage:WaitForChild("PlaceConfig"));
    end);

    if not success2 or result2.IsLobby then
        return;
    end;

    local os_clock_ret = os.clock();

    while PlayerGui:FindFirstChild("LoadingGui") and os.clock() - os_clock_ret < 60 do
        task.wait(0.25);
    end;

    if PlayerGui:FindFirstChild("LoadingGui") then
        return;
    end;

    task.wait(1);

    if success and result then
        result.Play("pda_welcome");
    end;
end);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "LocationHUD";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 50;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.Parent = PlayerGui;
local Frame = Instance.new("Frame");
Frame.AnchorPoint = Vector2.new(0.5, 0);
Frame.Position = UDim2.new(0.5, 0, 0, 130);
Frame.Size = UDim2.fromOffset(440, 78);
Frame.BackgroundTransparency = 1;
Frame.Parent = ScreenGui;
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Sub";
TextLabel.Size = UDim2.new(1, 0, 0, 24);
TextLabel.Position = UDim2.new(0, 0, 0, 0);
TextLabel.BackgroundTransparency = 1;
TextLabel.Text = "N O W   E N T E R I N G";
TextLabel.TextColor3 = Color3_fromRGB_ret;
TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
TextLabel.TextSize = 20;
TextLabel.TextTransparency = 1;
TextLabel.Parent = Frame;
local TextLabel2 = Instance.new("TextLabel");
TextLabel2.Name = "Name";
TextLabel2.Size = UDim2.new(1, 0, 0, 38);
TextLabel2.Position = UDim2.new(0, 0, 0, 30);
TextLabel2.BackgroundTransparency = 1;
TextLabel2.Text = "";
TextLabel2.TextColor3 = Color3_fromRGB_ret2;
TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
TextLabel2.TextSize = 30;
TextLabel2.TextTransparency = 1;
TextLabel2.TextStrokeTransparency = 0.6;
TextLabel2.TextStrokeColor3 = Color3.new(0, 0, 0);
TextLabel2.Parent = Frame;
local u1 = 0;

local function fade(p2, p3, p4) -- Line: 96
    -- upvalues: TweenService (copy)
    TweenService:Create(p2, TweenInfo.new(p4, Enum.EasingStyle.Sine), {
        TextTransparency = p3
    }):Play();
end;

local success2, result2 = pcall(function() -- Line: 100
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("ClientSettings", 5));
end);

local function showLocation(p5) -- Line: 102
    -- upvalues: u1 (ref), success (copy), result (copy), success2 (copy), result2 (copy), TextLabel2 (copy), fade (copy), TextLabel (copy)
    u1 = u1 + 1;

    if success and result then
        result.Play("spot_discovered", 0.5);
    end;

    if success2 and (result2 and result2.Get("locationBanner") == false) then
        return;
    end;

    TextLabel2.Text = string.upper(p5);
    fade(TextLabel, 0, 0.4);
    fade(TextLabel2, 0, 0.4);
    task.wait(4);

    if u1 ~= u1 then
        return;
    end;

    fade(TextLabel, 1, 0.8);
    fade(TextLabel2, 1, 0.8);
end;

LocationChanged.OnClientEvent:Connect(function(p6) -- Line: 122
    -- upvalues: showLocation (copy)
    task.spawn(showLocation, p6);
end);