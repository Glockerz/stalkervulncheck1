-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local ok, result = pcall(function() --[[ Line: 29 | Upvalues: ReplicatedStorage (copy) ]]
	return require(ReplicatedStorage:WaitForChild("SupporterCatalog", 5))
end)
local v1 = if ok then result else nil
local v2 = Color3.fromRGB(22, 24, 22)
local v3 = Color3.fromRGB(60, 60, 60)
local v4 = Color3.fromRGB(30, 32, 30)
local v5 = Color3.fromRGB(240, 240, 240)
local v6 = Color3.fromRGB(150, 150, 150)

Color3.fromRGB(255, 255, 255)

local v7 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v8 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)

Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)

local t = {
	Loner = Color3.fromRGB(255, 255, 255),
	Bandit = Color3.fromRGB(255, 255, 255),
	Duty = Color3.fromRGB(255, 255, 255),
	Freedom = Color3.fromRGB(255, 255, 255),
	Mercenary = Color3.fromRGB(255, 255, 255),
	Military = Color3.fromRGB(255, 255, 255),
	Ecologist = Color3.fromRGB(255, 255, 255),
	Monolith = Color3.fromRGB(255, 255, 255),
	["Clear Sky"] = Color3.fromRGB(255, 255, 255)
}
local t2 = {
	Loner = "rbxassetid://112051392817144",
	Bandit = "rbxassetid://123458810719829",
	Duty = "rbxassetid://119785670350314",
	Freedom = "rbxassetid://88545577686491",
	Mercenary = "rbxassetid://136916313162119",
	Ecologist = "rbxassetid://81918419109899",
	Military = "rbxassetid://140564765009660",
	Monolith = "rbxassetid://71835978563903",
	["Clear Sky"] = "rbxassetid://95584079688060"
}

local function factionColor(p1) --[[ factionColor | Line: 89 | Upvalues: t (copy) ]]
	return t[p1] or t.Loner
end

local function factionIcon(p1) --[[ factionIcon | Line: 93 | Upvalues: t2 (copy) ]]
	return t2[p1] or "rbxassetid://112051392817144"
end

local t3 = {
	Drifter = {
		initial = "D",
		label = "DRIFTER",
		color = Color3.fromRGB(150, 165, 180)
	},
	Veteran = {
		initial = "V",
		label = "VETERAN",
		color = Color3.fromRGB(120, 200, 120)
	},
	MasterStalker = {
		initial = "M",
		label = "MASTER",
		color = Color3.fromRGB(220, 180, 60)
	}
}
local t4 = {
	Dev = {
		text = "DEV",
		color = Color3.fromRGB(225, 100, 175)
	},
	Admin = {
		text = "ADMIN",
		color = Color3.fromRGB(200, 80, 70)
	},
	Moderator = {
		text = "MOD",
		color = Color3.fromRGB(90, 150, 215)
	}
}
local t5 = {
	text = "PA",
	color = Color3.fromRGB(170, 130, 220)
}

local function makeChip(p1, p2, p3, p4, p5) --[[ makeChip | Line: 123 | Upvalues: v7 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromScale(p2, 0.9)
	Frame.BackgroundTransparency = 1
	Frame.LayoutOrder = p3
	Frame.Parent = p1

	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.fromScale(1, 0.62)
	Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame2.Position = UDim2.fromScale(0.5, 0.5)
	Frame2.BackgroundColor3 = p5
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Frame

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0.25, 0)
	UICorner.Parent = Frame2

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(0, 0, 0)
	UIStroke.Thickness = 1
	UIStroke.Transparency = 0.55
	UIStroke.Parent = Frame2

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromScale(0.86, 0.8)
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel.Position = UDim2.fromScale(0.5, 0.5)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = p4
	TextLabel.TextColor3 = Color3.fromRGB(18, 20, 18)
	TextLabel.FontFace = v7
	TextLabel.TextScaled = true
	TextLabel.Parent = Frame2

	return Frame
end

local function supporterInfo(p1) --[[ supporterInfo | Line: 153 | Upvalues: v1 (ref), t3 (copy) ]]
	if type(p1) ~= "string" or p1 == "" then
		return nil
	end

	if v1 and (v1.Tiers and v1.Tiers[p1]) then
		local v12 = v1.Tiers[p1]
		local t = {
			initial = p1:sub(1, 1):upper(),
			label = (v12.DisplayName or p1):upper()
		}

		t.color = v12.ChatColor or Color3.fromRGB(220, 180, 60)

		return t
	end

	return t3[p1]
end

local IsLobby = require(game:GetService("ReplicatedStorage"):WaitForChild("PlaceConfig")).IsLobby
local v9 = IsLobby
local t6 = {}

local function refreshVisibility() --[[ refreshVisibility | Line: 187 | Upvalues: t6 (copy), v9 (ref) ]]
	for k, v in pairs(t6) do
		if v.gui and v.gui.Parent then
			v.gui.Enabled = v9
		end
	end
end

if not IsLobby then
	task.spawn(function() --[[ Line: 196 | Upvalues: ReplicatedStorage (copy), v9 (ref), refreshVisibility (copy) ]]
		local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
		local v1 = if Remotes then Remotes:WaitForChild("SafezoneChanged", 10) else Remotes

		if v1 then
			v1.OnClientEvent:Connect(function(p1) --[[ Line: 200 | Upvalues: v9 (ref), refreshVisibility (ref) ]]
				local v1 = if p1 == "Full" then true else p1 == "TraderOnly"

				if v1 == v9 then
					return
				end

				v9 = v1
				refreshVisibility()
			end)
		end
	end)
end

local function destroyNameplate(p1) --[[ destroyNameplate | Line: 210 | Upvalues: t6 (copy) ]]
	local v1 = t6[p1]

	if not v1 then
		return
	end

	for i, v in ipairs(v1.attributeConns) do
		pcall(function() --[[ Line: 214 | Upvalues: v (copy) ]]
			v:Disconnect()
		end)
	end

	if not (v1.gui and v1.gui.Parent) then
		t6[p1] = nil

		return
	end

	v1.gui:Destroy()
	t6[p1] = nil
end

local function paintPlate(p1, p2) --[[ paintPlate | Line: 222 | Upvalues: supporterInfo (copy), t4 (copy), v4 (copy), v5 (copy), v7 (copy), v6 (copy), v8 (copy), t (copy), t2 (copy), makeChip (copy), t5 (copy) ]]
	for i, v in ipairs(p1:GetChildren()) do
		if not (v:IsA("UIListLayout") or (v:IsA("UIPadding") or (v:IsA("UICorner") or v:IsA("UIStroke")))) then
			v:Destroy()
		end
	end

	local v1 = p2:GetAttribute("_Level")
	local v2 = type(v1) == "number" and v1 > 0 and tostring(v1) or "00"
	local v3 = p2:GetAttribute("Faction") or "Loner"
	local v42 = supporterInfo((p2:GetAttribute("_SupporterTier")))
	local v52 = t4[p2:GetAttribute("_Staff")]
	local v62 = if p2:GetAttribute("_PreAlpha") == true then true else false
	local v72 = if v52 then 0.12 else 0
	local v82 = if v62 then 0.1 else 0
	local v9 = if v42 then 0.18 else 0
	local LevelChip = Instance.new("Frame")

	LevelChip.Name = "LevelChip"
	LevelChip.Size = UDim2.fromScale(0.13, 0.9)
	LevelChip.BackgroundColor3 = v4
	LevelChip.BorderSizePixel = 0
	LevelChip.LayoutOrder = 1
	LevelChip.Parent = p1

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0.15, 0)
	UICorner.Parent = LevelChip

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromScale(1, 0.62)
	TextLabel.Position = UDim2.fromScale(0, 0.02)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = v2
	TextLabel.TextColor3 = v5
	TextLabel.FontFace = v7
	TextLabel.TextScaled = true
	TextLabel.TextXAlignment = Enum.TextXAlignment.Center
	TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
	TextLabel.Parent = LevelChip

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.fromScale(1, 0.3)
	TextLabel2.Position = UDim2.fromScale(0, 0.68)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Text = "LVL"
	TextLabel2.TextColor3 = v6
	TextLabel2.FontFace = v8
	TextLabel2.TextScaled = true
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Center
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.Parent = LevelChip

	local NameCol = Instance.new("Frame")

	NameCol.Name = "NameCol"
	NameCol.Size = UDim2.fromScale(0.87 - v72 - v82 - v9 - 0.04, 0.9)
	NameCol.BackgroundTransparency = 1
	NameCol.LayoutOrder = 2
	NameCol.Parent = p1

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.fromScale(1, 0.55)
	TextLabel3.Position = UDim2.fromScale(0, 0)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.Text = p2.DisplayName
	TextLabel3.TextColor3 = v5
	TextLabel3.FontFace = v7
	TextLabel3.TextScaled = true
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.TextYAlignment = Enum.TextYAlignment.Bottom
	TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel3.Parent = NameCol

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromScale(1, 0.42)
	Frame.Position = UDim2.fromScale(0, 0.57)
	Frame.BackgroundTransparency = 1
	Frame.Parent = NameCol

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0.02, 0)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = Frame

	local v10 = t[v3] or t.Loner
	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.fromScale(0.08, 1)
	Frame2.BackgroundTransparency = 1
	Frame2.LayoutOrder = 1
	Frame2.Parent = Frame

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

	UIAspectRatioConstraint.AspectRatio = 1
	UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint.Parent = Frame2

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Size = UDim2.fromScale(1, 1)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Image = t2[v3] or t2.Loner
	ImageLabel.ImageColor3 = v10
	ImageLabel.ScaleType = Enum.ScaleType.Fit
	ImageLabel.Parent = Frame2

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.Size = UDim2.fromScale(0.88, 1)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.Text = string.upper(v3)
	TextLabel4.TextColor3 = v10
	TextLabel4.FontFace = v8
	TextLabel4.TextScaled = true
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel4.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel4.LayoutOrder = 2
	TextLabel4.Parent = Frame

	if v52 then
		makeChip(p1, v72, 3, v52.text, v52.color).Name = "StaffChip"
	end

	if v62 then
		makeChip(p1, v82, 4, t5.text, t5.color).Name = "PreAlphaChip"
	end

	if not v42 then
		return
	end

	local SupporterChip = Instance.new("Frame")

	SupporterChip.Name = "SupporterChip"
	SupporterChip.Size = UDim2.fromScale(v9, 0.9)
	SupporterChip.BackgroundTransparency = 1
	SupporterChip.LayoutOrder = 5
	SupporterChip.Parent = p1

	local Frame3 = Instance.new("Frame")

	Frame3.Size = UDim2.fromScale(0.7, 0.75)
	Frame3.AnchorPoint = Vector2.new(0.5, 0)
	Frame3.Position = UDim2.fromScale(0.5, 0)
	Frame3.BackgroundColor3 = v42.color
	Frame3.BorderSizePixel = 0
	Frame3.Parent = SupporterChip

	local UICorner2 = Instance.new("UICorner")

	UICorner2.CornerRadius = UDim.new(0.2, 0)
	UICorner2.Parent = Frame3

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(0, 0, 0)
	UIStroke.Thickness = 1
	UIStroke.Transparency = 0.5
	UIStroke.Parent = Frame3

	local TextLabel5 = Instance.new("TextLabel")

	TextLabel5.Size = UDim2.fromScale(1, 1)
	TextLabel5.BackgroundTransparency = 1
	TextLabel5.Text = v42.initial
	TextLabel5.TextColor3 = Color3.fromRGB(20, 22, 20)
	TextLabel5.FontFace = v7
	TextLabel5.TextScaled = true
	TextLabel5.TextXAlignment = Enum.TextXAlignment.Center
	TextLabel5.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel5.Parent = Frame3

	local TextLabel6 = Instance.new("TextLabel")

	TextLabel6.Size = UDim2.fromScale(1, 0.22)
	TextLabel6.Position = UDim2.fromScale(0, 0.78)
	TextLabel6.BackgroundTransparency = 1
	TextLabel6.Text = v42.label
	TextLabel6.TextColor3 = v42.color
	TextLabel6.FontFace = v8
	TextLabel6.TextScaled = true
	TextLabel6.TextXAlignment = Enum.TextXAlignment.Center
	TextLabel6.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel6.Parent = SupporterChip
end

local function buildNameplate(p1) --[[ buildNameplate | Line: 411 | Upvalues: LocalPlayer (copy), destroyNameplate (copy), v9 (ref), v2 (copy), v3 (copy), paintPlate (copy), t6 (copy) ]]
	if p1 == LocalPlayer then
		return
	end

	destroyNameplate(p1)

	local Character = p1.Character

	if not Character then
		return
	end

	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10)

	if not HumanoidRootPart or HumanoidRootPart.Parent ~= Character then
		return
	end

	local PlayerNameplate = Instance.new("BillboardGui")

	PlayerNameplate.Name = "PlayerNameplate"
	PlayerNameplate.Adornee = HumanoidRootPart
	PlayerNameplate.Size = UDim2.fromScale(2.5, 0.5)
	PlayerNameplate.StudsOffset = Vector3.new(0, 3.4, 0)
	PlayerNameplate.AlwaysOnTop = false
	PlayerNameplate.LightInfluence = 0
	PlayerNameplate.ClipsDescendants = false
	PlayerNameplate.ResetOnSpawn = false
	PlayerNameplate.MaxDistance = 100
	PlayerNameplate.Enabled = v9
	PlayerNameplate.Parent = HumanoidRootPart

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromScale(1, 1)
	Frame.BackgroundColor3 = v2
	Frame.BackgroundTransparency = 0.15
	Frame.BorderSizePixel = 0
	Frame.Parent = PlayerNameplate

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Frame

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v3
	UIStroke.Thickness = 1
	UIStroke.Transparency = 0.3
	UIStroke.Parent = Frame

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingLeft = UDim.new(0.015, 0)
	UIPadding.PaddingRight = UDim.new(0.015, 0)
	UIPadding.PaddingTop = UDim.new(0.05, 0)
	UIPadding.PaddingBottom = UDim.new(0.05, 0)
	UIPadding.Parent = Frame

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIListLayout.Padding = UDim.new(0.015, 0)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = Frame
	paintPlate(Frame, p1)

	local function repaint() --[[ repaint | Line: 463 | Upvalues: Frame (copy), paintPlate (ref), p1 (copy) ]]
		if not Frame.Parent then
			return
		end

		paintPlate(Frame, p1)
	end

	local t = {}

	for i, v in ipairs({ "_Level", "Faction", "_SupporterTier", "_Staff", "_PreAlpha" }) do
		table.insert(t, p1:GetAttributeChangedSignal(v):Connect(repaint))
	end

	table.insert(t, p1:GetPropertyChangedSignal("DisplayName"):Connect(repaint))
	t6[p1] = {
		gui = PlayerNameplate,
		attributeConns = t
	}
end

local function hookPlayer(p1) --[[ hookPlayer | Line: 473 | Upvalues: buildNameplate (copy), destroyNameplate (copy) ]]
	if p1.Character then
		task.spawn(buildNameplate, p1)
	end

	p1.CharacterAdded:Connect(function(p12) --[[ Line: 479 | Upvalues: buildNameplate (ref), p1 (copy) ]]
		p12:WaitForChild("HumanoidRootPart", 10)
		buildNameplate(p1)
	end)
	p1.CharacterRemoving:Connect(function() --[[ Line: 483 | Upvalues: destroyNameplate (ref), p1 (copy) ]]
		destroyNameplate(p1)
	end)
end

for i, v in ipairs(Players:GetPlayers()) do
	hookPlayer(v)
end

Players.PlayerAdded:Connect(hookPlayer)
Players.PlayerRemoving:Connect(destroyNameplate)
print("[PlayerNameplate] initialized")