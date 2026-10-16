-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local u1 = {
    [68620354] = true,
    [184460696] = true,
    [102248765] = true
};
local LocalPlayer = Players.LocalPlayer;

local function isStaff(u2) -- Line: 43
    -- upvalues: u1 (copy)
    if u1[u2.UserId] then
        return true;
    end;

    local success, result = pcall(function() -- Line: 45
        -- upvalues: u2 (copy)
        return u2:GetRankInGroup(9949403);
    end);

    return (success and tonumber(result) or 0) >= 165;
end;

local v3;

if u1[LocalPlayer.UserId] then
    v3 = true;
else
    local success, result = pcall(function() -- Line: 45
        -- upvalues: LocalPlayer (copy)
        return LocalPlayer:GetRankInGroup(9949403);
    end);
    v3 = (success and tonumber(result) or 0) >= 165;
end;

if not v3 then
    return;
end;

local AdminRunCommand = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AdminRunCommand");
local Color3_fromRGB_ret = Color3.fromRGB(16, 16, 18);
local Color3_fromRGB_ret2 = Color3.fromRGB(22, 22, 26);
local Color3_fromRGB_ret3 = Color3.fromRGB(35, 35, 40);
local Color3_fromRGB_ret4 = Color3.fromRGB(70, 70, 78);
local Color3_fromRGB_ret5 = Color3.fromRGB(225, 225, 230);
local Color3_fromRGB_ret6 = Color3.fromRGB(150, 150, 158);
local Color3_fromRGB_ret7 = Color3.fromRGB(196, 154, 46);
local Color3_fromRGB_ret8 = Color3.fromRGB(176, 58, 46);
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "ModeratorPanel";
ScreenGui.ResetOnSpawn = false;
ScreenGui.Enabled = false;
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local Frame = Instance.new("Frame");
Frame.Size = UDim2.fromOffset(330, 372);
Frame.Position = UDim2.new(0, 24, 0.5, -186);
Frame.BackgroundColor3 = Color3_fromRGB_ret;
Frame.BorderSizePixel = 0;
Frame.Active = true;
Frame.Draggable = true;
Frame.Parent = ScreenGui;
Instance.new("UICorner").Parent = Frame;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3_fromRGB_ret4;
UIStroke.Thickness = 1;
UIStroke.Parent = Frame;
local TextLabel = Instance.new("TextLabel");
TextLabel.Size = UDim2.new(1, 0, 0, 30);
TextLabel.BackgroundColor3 = Color3_fromRGB_ret2;
TextLabel.BorderSizePixel = 0;
TextLabel.Text = "  MODERATION";
TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel.FontFace = Font_new_ret;
TextLabel.TextSize = 15;
TextLabel.TextColor3 = Color3_fromRGB_ret7;
TextLabel.Parent = Frame;
local u4 = 38;

local function makeField(p5, p6) -- Line: 95
    -- upvalues: u4 (ref), Font_new_ret2 (copy), Color3_fromRGB_ret6 (copy), Frame (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret5 (copy)
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(12, u4);
    TextLabel2.Size = UDim2.fromOffset(72, 24);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = p5;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.FontFace = Font_new_ret2;
    TextLabel2.TextSize = 13;
    TextLabel2.TextColor3 = Color3_fromRGB_ret6;
    TextLabel2.Parent = Frame;
    local TextBox = Instance.new("TextBox");
    TextBox.Position = UDim2.fromOffset(86, u4);
    TextBox.Size = UDim2.fromOffset(230, 24);
    TextBox.BackgroundColor3 = Color3_fromRGB_ret3;
    TextBox.BorderSizePixel = 0;
    TextBox.Text = "";
    TextBox.PlaceholderText = p6;
    TextBox.ClearTextOnFocus = false;
    TextBox.FontFace = Font_new_ret2;
    TextBox.TextSize = 13;
    TextBox.TextColor3 = Color3_fromRGB_ret5;
    TextBox.Parent = Frame;
    Instance.new("UICorner").Parent = TextBox;
    u4 = u4 + 30;

    return TextBox;
end;

local u7 = makeField("Target", "name or UserId");
local u8 = makeField("Duration", "30m / 2h / 7d / perm");
local u9 = makeField("Reason", "shown to the player");
u4 = u4 + 6;
local v10 = {
    { "FIND", "find", false, false, nil },
    { "INSPECT", "inspect", false, false, nil },
    { "FREEZE", "freeze", false, false, nil },
    { "UNFREEZE", "unfreeze", false, false, nil },
    {
        "MUTE",
        "mute",
        true,
        true,
        Color3_fromRGB_ret7
    },
    { "UNMUTE", "unmute", false, false, nil },
    {
        "KICK",
        "kick",
        false,
        true,
        Color3_fromRGB_ret7
    },
    {
        "BAN",
        "ban",
        true,
        true,
        Color3_fromRGB_ret8
    },
    { "UNBAN", "unban", false, false, nil }
};

local function run(p11, p12, p13) -- Line: 131
    -- upvalues: u7 (copy), u8 (copy), u9 (copy), AdminRunCommand (copy)
    local Text = u7.Text;

    if Text == "" then
        return;
    end;

    local v14 = { Text };

    if p12 then
        table.insert(v14, u8.Text == "" and "perm" or (u8.Text or "perm"));
    end;

    if p13 and u9.Text ~= "" then
        table.insert(v14, u9.Text);
    end;

    AdminRunCommand:FireServer(p11, v14);
end;

for i, v in ipairs(v10) do
    local math_floor_ret = math.floor((i - 1) / 3);
    local TextButton = Instance.new("TextButton");
    TextButton.Position = UDim2.fromOffset(12 + (i - 1) % 3 * 104, u4 + math_floor_ret * 34);
    TextButton.Size = UDim2.fromOffset(96, 28);
    TextButton.BackgroundColor3 = v[5] or Color3_fromRGB_ret3;
    TextButton.BorderSizePixel = 0;
    TextButton.Text = v[1];
    TextButton.FontFace = Font_new_ret;
    TextButton.TextSize = 12;
    local v15;

    if v[5] then
        v15 = Color3.fromRGB(18, 18, 20) or Color3_fromRGB_ret5;
    else
        v15 = Color3_fromRGB_ret5;
    end;

    TextButton.TextColor3 = v15;
    TextButton.Parent = Frame;
    Instance.new("UICorner").Parent = TextButton;
    TextButton.MouseButton1Click:Connect(function() -- Line: 168
        -- upvalues: run (copy), v (copy)
        run(v[2], v[3], v[4]);
    end);
end;

local TextLabel2 = Instance.new("TextLabel");
TextLabel2.Position = UDim2.fromOffset(12, u4 + math.ceil(#v10 / 3) * 34 + 8);
TextLabel2.Size = UDim2.fromOffset(306, 46);
TextLabel2.BackgroundTransparency = 1;
TextLabel2.Text = "Results arrive as a toast. Bans and inspections are logged to the mod channel. Ban accepts a UserId, so an offline player can still be actioned.";
TextLabel2.TextWrapped = true;
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
TextLabel2.FontFace = Font_new_ret2;
TextLabel2.TextSize = 11;
TextLabel2.TextColor3 = Color3_fromRGB_ret6;
TextLabel2.Parent = Frame;
UserInputService.InputBegan:Connect(function(p16, p17) -- Line: 186
    -- upvalues: ScreenGui (copy)
    if p17 then
        return;
    end;

    if p16.KeyCode == Enum.KeyCode.F6 then
        ScreenGui.Enabled = not ScreenGui.Enabled;
    end;
end);
print("[ModeratorPanelClient] F6 to toggle");