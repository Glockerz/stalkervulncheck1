-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local t = {
	[68620354] = true,
	[184460696] = true,
	[102248765] = true
}
local LocalPlayer = Players.LocalPlayer

local function isStaff(p1) --[[ isStaff | Line: 43 | Upvalues: t (copy) ]]
	if t[p1.UserId] then
		return true
	end

	local ok, result = pcall(function() --[[ Line: 45 | Upvalues: p1 (copy) ]]
		return p1:GetRankInGroup(9949403)
	end)

	return (if ok then tonumber(result) or 0 else 0) >= 165
end

local v1

if t[LocalPlayer.UserId] then
	v1 = true
else
	local ok, result = pcall(function() --[[ Line: 45 | Upvalues: LocalPlayer (copy) ]]
		return LocalPlayer:GetRankInGroup(9949403)
	end)

	v1 = if (if ok then tonumber(result) or 0 else 0) >= 165 then true else false
end

if not v1 then
	return
end

local AdminRunCommand = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AdminRunCommand")
local v3 = Color3.fromRGB(16, 16, 18)
local v4 = Color3.fromRGB(22, 22, 26)
local v5 = Color3.fromRGB(35, 35, 40)
local v6 = Color3.fromRGB(70, 70, 78)
local v7 = Color3.fromRGB(225, 225, 230)
local v8 = Color3.fromRGB(150, 150, 158)
local v9 = Color3.fromRGB(196, 154, 46)
local v10 = Color3.fromRGB(176, 58, 46)
local v11 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v12 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
local ModeratorPanel = Instance.new("ScreenGui")

ModeratorPanel.Name = "ModeratorPanel"
ModeratorPanel.ResetOnSpawn = false
ModeratorPanel.Enabled = false
ModeratorPanel.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ModeratorPanel.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")

Frame.Size = UDim2.fromOffset(330, 372)
Frame.Position = UDim2.new(0, 24, 0.5, -186)
Frame.BackgroundColor3 = v3
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ModeratorPanel
Instance.new("UICorner").Parent = Frame

local UIStroke = Instance.new("UIStroke")

UIStroke.Color = v6
UIStroke.Thickness = 1
UIStroke.Parent = Frame

local TextLabel = Instance.new("TextLabel")

TextLabel.Size = UDim2.new(1, 0, 0, 30)
TextLabel.BackgroundColor3 = v4
TextLabel.BorderSizePixel = 0
TextLabel.Text = "  MODERATION"
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.FontFace = v11
TextLabel.TextSize = 15
TextLabel.TextColor3 = v9
TextLabel.Parent = Frame

local sum = 38

local function makeField(p1, p2) --[[ makeField | Line: 95 | Upvalues: sum (ref), v12 (copy), v8 (copy), Frame (copy), v5 (copy), v7 (copy) ]]
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(12, sum)
	TextLabel.Size = UDim2.fromOffset(72, 24)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = p1
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.FontFace = v12
	TextLabel.TextSize = 13
	TextLabel.TextColor3 = v8
	TextLabel.Parent = Frame

	local TextBox = Instance.new("TextBox")

	TextBox.Position = UDim2.fromOffset(86, sum)
	TextBox.Size = UDim2.fromOffset(230, 24)
	TextBox.BackgroundColor3 = v5
	TextBox.BorderSizePixel = 0
	TextBox.Text = ""
	TextBox.PlaceholderText = p2
	TextBox.ClearTextOnFocus = false
	TextBox.FontFace = v12
	TextBox.TextSize = 13
	TextBox.TextColor3 = v7
	TextBox.Parent = Frame
	Instance.new("UICorner").Parent = TextBox
	sum = sum + 30

	return TextBox
end

local v13 = makeField("Target", "name or UserId")
local v14 = makeField("Duration", "30m / 2h / 7d / perm")
local v15 = makeField("Reason", "shown to the player")

sum = sum + 6

local function run(p1, p2, p3) --[[ run | Line: 131 | Upvalues: v13 (copy), v14 (copy), v15 (copy), AdminRunCommand (copy) ]]
	local Text = v13.Text

	if Text == "" then
		return
	end

	local t = { Text }

	if p2 then
		table.insert(t, if v14.Text == "" then "perm" else v14.Text or "perm")
	end

	if p3 and v15.Text ~= "" then
		table.insert(t, v15.Text)
	end

	AdminRunCommand:FireServer(p1, t)
end

local list = {
	{ "FIND", "find", false, false, nil },
	{ "INSPECT", "inspect", false, false, nil },
	{ "FREEZE", "freeze", false, false, nil },
	{ "UNFREEZE", "unfreeze", false, false, nil },
	{ "MUTE", "mute", true, true, v9 },
	{ "UNMUTE", "unmute", false, false, nil },
	{ "KICK", "kick", false, true, v9 },
	{ "BAN", "ban", true, true, v10 },
	{ "UNBAN", "unban", false, false, nil }
}

for i, v in ipairs(list) do
	local v16 = math.floor((i - 1) / 3)
	local TextButton = Instance.new("TextButton")

	TextButton.Position = UDim2.fromOffset(12 + (i - 1) % 3 * 104, sum + v16 * 34)
	TextButton.Size = UDim2.fromOffset(96, 28)
	TextButton.BackgroundColor3 = v[5] or v5
	TextButton.BorderSizePixel = 0
	TextButton.Text = v[1]
	TextButton.FontFace = v11
	TextButton.TextSize = 12
	TextButton.TextColor3 = v[5] and Color3.fromRGB(18, 18, 20) or v7
	TextButton.Parent = Frame
	Instance.new("UICorner").Parent = TextButton
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 168 | Upvalues: run (copy), v (copy) ]]
		run(v[2], v[3], v[4])
	end)
end

local TextLabel2 = Instance.new("TextLabel")

TextLabel2.Position = UDim2.fromOffset(12, sum + math.ceil(#list / 3) * 34 + 8)
TextLabel2.Size = UDim2.fromOffset(306, 46)
TextLabel2.BackgroundTransparency = 1
TextLabel2.Text = "Results arrive as a toast. Bans and inspections are logged to the mod channel. Ban accepts a UserId, so an offline player can still be actioned."
TextLabel2.TextWrapped = true
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
TextLabel2.FontFace = v12
TextLabel2.TextSize = 11
TextLabel2.TextColor3 = v8
TextLabel2.Parent = Frame
UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 186 | Upvalues: ModeratorPanel (copy) ]]
	if p2 then
		return
	end

	if p1.KeyCode ~= Enum.KeyCode.F6 then
		return
	end

	ModeratorPanel.Enabled = not ModeratorPanel.Enabled
end)
print("[ModeratorPanelClient] F6 to toggle")