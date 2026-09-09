-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local SetTutorialBanner = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SetTutorialBanner")
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v3 = Color3.fromRGB(24, 26, 24)
local v4 = Color3.fromRGB(255, 200, 90)
local v5 = Color3.fromRGB(235, 235, 235)
local v6 = nil
local v7 = nil
local v8 = nil

local function ensureGui() --[[ ensureGui | Line: 23 | Upvalues: v6 (ref), LocalPlayer (copy), v7 (ref), v3 (copy), v4 (copy), v1 (copy), v8 (ref), v2 (copy), v5 (copy) ]]
	if not (v6 and v6.Parent) then
		local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

		v6 = Instance.new("ScreenGui")
		v6.Name = "TutorialBanner"
		v6.ResetOnSpawn = false
		v6.IgnoreGuiInset = true
		v6.DisplayOrder = 55
		v6.Enabled = false
		v6.Parent = PlayerGui
		v7 = Instance.new("Frame")
		v7.Size = UDim2.fromOffset(500, 72)
		v7.AnchorPoint = Vector2.new(0.5, 0)
		v7.Position = UDim2.new(0.5, 0, 0, 140)
		v7.BackgroundColor3 = v3
		v7.BackgroundTransparency = 0.05
		v7.BorderSizePixel = 0
		v7.ZIndex = 55
		v7.Parent = v6

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = v7

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = v4
		UIStroke.Thickness = 1.5
		UIStroke.Transparency = 0.25
		UIStroke.Parent = v7

		local Frame = Instance.new("Frame")

		Frame.Size = UDim2.new(0, 5, 1, 0)
		Frame.BackgroundColor3 = v4
		Frame.BorderSizePixel = 0
		Frame.ZIndex = 56
		Frame.Parent = v7

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.fromOffset(46, 72)
		TextLabel.Position = UDim2.fromOffset(8, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v1
		TextLabel.TextSize = 28
		TextLabel.TextColor3 = v4
		TextLabel.Text = "?"
		TextLabel.ZIndex = 56
		TextLabel.Parent = v7
		v8 = Instance.new("TextLabel")
		v8.Position = UDim2.fromOffset(58, 6)
		v8.Size = UDim2.new(1, -70, 1, -12)
		v8.BackgroundTransparency = 1
		v8.FontFace = v2
		v8.TextSize = 16
		v8.TextColor3 = v5
		v8.TextXAlignment = Enum.TextXAlignment.Left
		v8.TextYAlignment = Enum.TextYAlignment.Center
		v8.TextWrapped = true
		v8.Text = ""
		v8.ZIndex = 56
		v8.Parent = v7
	end
end

local function show(p1) --[[ show | Line: 88 | Upvalues: ensureGui (copy), v8 (ref), v6 (ref) ]]
	ensureGui()
	v8.Text = tostring(p1 or "")
	v6.Enabled = true
end

local function hide() --[[ hide | Line: 94 | Upvalues: v6 (ref) ]]
	if not v6 then
		return
	end

	v6.Enabled = false
end

SetTutorialBanner.OnClientEvent:Connect(function(p1) --[[ Line: 98 | Upvalues: ensureGui (copy), v8 (ref), v6 (ref) ]]
	if p1 and p1 ~= "" then
		ensureGui()
		v8.Text = tostring(p1 or "")
		v6.Enabled = true

		return
	end

	if not v6 then
		return
	end

	v6.Enabled = false
end)