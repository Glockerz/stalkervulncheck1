-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
local v4 = Color3.fromRGB(255, 200, 90)
local v5 = Color3.fromRGB(220, 220, 220)
local v6 = Color3.fromRGB(170, 170, 170)
local v7 = Color3.fromRGB(120, 120, 120)
local v8 = Color3.fromRGB(60, 70, 50)
local v9 = Color3.fromRGB(140, 170, 90)
local v10 = Color3.fromRGB(60, 60, 60)
local v11 = Color3.fromRGB(28, 30, 28)
local v12 = Color3.fromRGB(38, 40, 38)
local t = {
	friendly = Color3.fromRGB(140, 200, 120),
	neutral = Color3.fromRGB(225, 180, 90),
	unfriendly = Color3.fromRGB(235, 140, 80),
	hostile = Color3.fromRGB(225, 95, 95)
}
local t2 = {
	friendly = "FRIENDLY",
	neutral = "NEUTRAL",
	unfriendly = "UNFRIENDLY",
	hostile = "HOSTILE"
}
local t3 = {
	{
		name = "LONERS",
		sub = "Independent",
		standing = "friendly",
		rep = 620,
		icon = Color3.fromRGB(170, 160, 130)
	},
	{
		name = "DUTY",
		sub = "Military Faction",
		standing = "neutral",
		rep = 210,
		icon = Color3.fromRGB(180, 60, 60)
	},
	{
		name = "FREEDOM",
		sub = "Freedom Faction",
		standing = "unfriendly",
		rep = -80,
		icon = Color3.fromRGB(80, 160, 80)
	},
	{
		name = "BANDITS",
		sub = "Hostile",
		standing = "hostile",
		rep = -640,
		icon = Color3.fromRGB(160, 90, 90)
	},
	{
		name = "MILITARY",
		sub = "Ukrainian Armed Forces",
		standing = "neutral",
		rep = 150,
		icon = Color3.fromRGB(80, 110, 160)
	},
	{
		name = "ECOLOGISTS",
		sub = "Scientific Faction",
		standing = "friendly",
		rep = 480,
		icon = Color3.fromRGB(180, 160, 90)
	}
}
local t4 = {
	{
		name = "ROOKIE",
		range = "0 \226\128\147 499 RP",
		color = Color3.fromRGB(190, 140, 100)
	},
	{
		name = "EXPERIENCED",
		range = "500 \226\128\147 1,499 RP",
		color = Color3.fromRGB(180, 180, 180)
	},
	{
		name = "PROFESSIONAL",
		range = "1,500 \226\128\147 3,999 RP",
		selected = true,
		color = Color3.fromRGB(220, 180, 90)
	},
	{
		name = "VETERAN",
		range = "4,000 \226\128\147 7,499 RP",
		color = Color3.fromRGB(160, 130, 210)
	},
	{
		name = "EXPERT",
		range = "7,500 \226\128\147 11,999 RP",
		color = Color3.fromRGB(225, 95, 95)
	},
	{
		name = "LEGEND",
		range = "12,000+ RP",
		color = Color3.fromRGB(225, 200, 90)
	}
}
local t5 = {
	name = "PROFESSIONAL",
	rp = 2350,
	next = 4000,
	nextName = "Veteran",
	color = Color3.fromRGB(220, 180, 90)
}
local t6 = {
	{
		rank = 1,
		name = "Shadow",
		rp = 28560
	},
	{
		rank = 2,
		name = "Strelok",
		rp = 24810
	},
	{
		rank = 3,
		name = "Viper",
		rp = 19430
	},
	{
		rank = 4,
		name = "Ghost",
		rp = 17220
	},
	{
		rank = 5,
		name = "Scavenger",
		rp = 15780
	}
}
local t7 = {
	rank = 127,
	name = "You",
	rp = 2350,
	total = 8432
}

local function formatNumber(p1) --[[ formatNumber | Line: 61 ]]
	local v2 = tostring((math.abs(p1))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

	return if p1 < 0 then "-" .. v2 else v2
end

local function buildFactionRow(p1, p2, p3) --[[ buildFactionRow | Line: 69 | Upvalues: v1 (copy), v5 (copy), v3 (copy), v6 (copy), v2 (copy), t (copy), t2 (copy), v12 (copy), v7 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Name = "Faction_" .. p2.name
	Frame.Size = UDim2.new(1, 0, 0, 66)
	Frame.BackgroundTransparency = 1
	Frame.LayoutOrder = p3
	Frame.Parent = p1

	local Frame2 = Instance.new("Frame")

	Frame2.Position = UDim2.fromOffset(4, 8)
	Frame2.Size = UDim2.fromOffset(40, 40)
	Frame2.BackgroundColor3 = Color3.fromRGB(45, 48, 42)
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Frame

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = p2.icon
	UIStroke.Thickness = 1.5
	UIStroke.Parent = Frame2

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromScale(1, 1)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 20
	TextLabel.TextColor3 = p2.icon
	TextLabel.Text = string.sub(p2.name, 1, 1)
	TextLabel.Parent = Frame2

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(56, 4)
	TextLabel2.Size = UDim2.new(1, -200, 0, 22)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v1
	TextLabel2.TextSize = 16
	TextLabel2.TextColor3 = v5
	TextLabel2.Text = p2.name
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = Frame

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Position = UDim2.fromOffset(56, 24)
	TextLabel3.Size = UDim2.new(1, -200, 0, 18)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v3
	TextLabel3.TextSize = 13
	TextLabel3.TextColor3 = v6
	TextLabel3.Text = p2.sub
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Parent = Frame

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.AnchorPoint = Vector2.new(1, 0)
	TextLabel4.Position = UDim2.new(1, -8, 0, 4)
	TextLabel4.Size = UDim2.fromOffset(120, 20)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v2
	TextLabel4.TextSize = 14
	TextLabel4.TextColor3 = t[p2.standing]
	TextLabel4.Text = t2[p2.standing]
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel4.Parent = Frame

	local TextLabel5 = Instance.new("TextLabel")

	TextLabel5.AnchorPoint = Vector2.new(1, 0)
	TextLabel5.Position = UDim2.new(1, -8, 0, 24)
	TextLabel5.Size = UDim2.fromOffset(100, 22)
	TextLabel5.BackgroundTransparency = 1
	TextLabel5.FontFace = v1
	TextLabel5.TextSize = 17
	TextLabel5.TextColor3 = t[p2.standing]

	local v13 = if p2.rep >= 0 then "+" else ""
	local rep = p2.rep
	local v32 = tostring((math.abs(rep))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

	TextLabel5.Text = v13 .. (if rep < 0 then "-" .. v32 else v32)
	TextLabel5.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel5.Parent = Frame

	local Frame3 = Instance.new("Frame")

	Frame3.Position = UDim2.fromOffset(56, 46)
	Frame3.Size = UDim2.new(1, -64, 0, 4)
	Frame3.BackgroundColor3 = v12
	Frame3.BorderSizePixel = 0
	Frame3.Parent = Frame

	local Frame4 = Instance.new("Frame")

	Frame4.Size = UDim2.new(math.clamp(math.abs(p2.rep) / 1000, 0, 1), 0, 1, 0)
	Frame4.BackgroundColor3 = t[p2.standing]
	Frame4.BorderSizePixel = 0
	Frame4.Parent = Frame3

	local TextLabel6 = Instance.new("TextLabel")

	TextLabel6.AnchorPoint = Vector2.new(1, 0)
	TextLabel6.Position = UDim2.new(1, -8, 0, 52)
	TextLabel6.Size = UDim2.fromOffset(140, 12)
	TextLabel6.BackgroundTransparency = 1
	TextLabel6.FontFace = v3
	TextLabel6.TextSize = 11
	TextLabel6.TextColor3 = v7

	local rep3 = p2.rep
	local v8 = tostring((math.abs(rep3))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

	TextLabel6.Text = (if rep3 < 0 then "-" .. v8 else v8) .. " / 1000"
	TextLabel6.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel6.Parent = Frame
end

local function buildFactionPanel(p1) --[[ buildFactionPanel | Line: 170 | Upvalues: v11 (copy), v10 (copy), v2 (copy), v7 (copy), t3 (copy), buildFactionRow (copy), v3 (copy) ]]
	local FactionPanel = Instance.new("Frame")

	FactionPanel.Name = "FactionPanel"
	FactionPanel.Size = UDim2.new(0.5, -8, 1, 0)
	FactionPanel.BackgroundColor3 = v11
	FactionPanel.BackgroundTransparency = 0.4
	FactionPanel.BorderSizePixel = 0
	FactionPanel.Parent = p1

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v10
	UIStroke.Thickness = 1
	UIStroke.Parent = FactionPanel

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingTop = UDim.new(0, 12)
	UIPadding.PaddingBottom = UDim.new(0, 8)
	UIPadding.PaddingLeft = UDim.new(0, 14)
	UIPadding.PaddingRight = UDim.new(0, 14)
	UIPadding.Parent = FactionPanel

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = v7
	TextLabel.Text = "FACTION STANDING"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = FactionPanel

	local Frame = Instance.new("Frame")

	Frame.Position = UDim2.fromOffset(0, 28)
	Frame.Size = UDim2.new(1, 0, 1, -68)
	Frame.BackgroundTransparency = 1
	Frame.Parent = FactionPanel

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.Parent = Frame

	for i, v in ipairs(t3) do
		buildFactionRow(Frame, v, i)
	end

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.AnchorPoint = Vector2.new(0, 1)
	TextLabel2.Position = UDim2.new(0, 0, 1, -4)
	TextLabel2.Size = UDim2.new(1, 0, 0, 30)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 12
	TextLabel2.TextColor3 = v7
	TextLabel2.TextWrapped = true
	TextLabel2.Text = "Your standing with each faction affects prices, available quests, and how they respond to you in the Zone."
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Bottom
	TextLabel2.Parent = FactionPanel
end

local function buildCurrentRank(p1) --[[ buildCurrentRank | Line: 231 | Upvalues: v10 (copy), v2 (copy), v7 (copy), t5 (copy), v1 (copy), v5 (copy), v12 (copy), t (copy), v3 (copy), v6 (copy) ]]
	local CurrentRank = Instance.new("Frame")

	CurrentRank.Name = "CurrentRank"
	CurrentRank.Position = UDim2.fromOffset(0, 0)
	CurrentRank.Size = UDim2.new(0.48, -4, 0, 226)
	CurrentRank.BackgroundColor3 = Color3.fromRGB(34, 36, 32)
	CurrentRank.BackgroundTransparency = 0.2
	CurrentRank.BorderSizePixel = 0
	CurrentRank.Parent = p1

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v10
	UIStroke.Thickness = 1
	UIStroke.Parent = CurrentRank

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(12, 8)
	TextLabel.Size = UDim2.new(1, -24, 0, 18)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 12
	TextLabel.TextColor3 = v7
	TextLabel.Text = "YOUR CURRENT RANK"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = CurrentRank

	local Frame = Instance.new("Frame")

	Frame.AnchorPoint = Vector2.new(0.5, 0)
	Frame.Position = UDim2.new(0.5, 0, 0, 30)
	Frame.Size = UDim2.fromOffset(68, 68)
	Frame.BackgroundTransparency = 1
	Frame.Parent = CurrentRank

	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.fromScale(1, 1)
	Frame2.BackgroundColor3 = Color3.fromRGB(40, 42, 38)
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Frame

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame2

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = t5.color
	UIStroke2.Thickness = 1.5
	UIStroke2.Parent = Frame2

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.fromScale(1, 1)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v1
	TextLabel2.TextSize = 32
	TextLabel2.TextColor3 = t5.color
	TextLabel2.Text = string.sub(t5.name, 1, 1)
	TextLabel2.Parent = Frame2

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Position = UDim2.fromOffset(0, 104)
	TextLabel3.Size = UDim2.new(1, 0, 0, 28)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v1
	TextLabel3.TextSize = 20
	TextLabel3.TextColor3 = v5
	TextLabel3.Text = t5.name
	TextLabel3.Parent = CurrentRank

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.Position = UDim2.fromOffset(0, 130)
	TextLabel4.Size = UDim2.new(1, 0, 0, 24)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v2
	TextLabel4.TextSize = 18
	TextLabel4.TextColor3 = t5.color

	local rp = t5.rp
	local v22 = tostring((math.abs(rp))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

	TextLabel4.Text = (if rp < 0 then "-" .. v22 else v22) .. " RP"
	TextLabel4.Parent = CurrentRank

	local Frame3 = Instance.new("Frame")

	Frame3.Position = UDim2.fromOffset(14, 162)
	Frame3.Size = UDim2.new(1, -28, 0, 5)
	Frame3.BackgroundColor3 = v12
	Frame3.BorderSizePixel = 0
	Frame3.Parent = CurrentRank

	local Frame4 = Instance.new("Frame")

	Frame4.Size = UDim2.new(math.clamp(t5.rp / t5.next, 0, 1), 0, 1, 0)
	Frame4.BackgroundColor3 = t.friendly
	Frame4.BorderSizePixel = 0
	Frame4.Parent = Frame3

	local TextLabel5 = Instance.new("TextLabel")

	TextLabel5.Position = UDim2.fromOffset(0, 170)
	TextLabel5.Size = UDim2.new(1, 0, 0, 18)
	TextLabel5.BackgroundTransparency = 1
	TextLabel5.FontFace = v3
	TextLabel5.TextSize = 12
	TextLabel5.TextColor3 = v6

	local format = string.format
	local rp2 = t5.rp
	local v8 = tostring((math.abs(rp2))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	local v102 = t5.next
	local v122 = tostring((math.abs(v102))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

	TextLabel5.Text = format("%s / %s RP", if rp2 < 0 then "-" .. v8 else v8, if v102 < 0 then "-" .. v122 else v122)
	TextLabel5.Parent = CurrentRank

	local TextLabel6 = Instance.new("TextLabel")

	TextLabel6.Position = UDim2.fromOffset(0, 190)
	TextLabel6.Size = UDim2.new(1, 0, 0, 18)
	TextLabel6.BackgroundTransparency = 1
	TextLabel6.FontFace = v3
	TextLabel6.TextSize = 12
	TextLabel6.TextColor3 = v7
	TextLabel6.Text = "Next Rank: " .. t5.nextName
	TextLabel6.Parent = CurrentRank
end

local function buildRankTier(p1, p2, p3) --[[ buildRankTier | Line: 339 | Upvalues: v8 (copy), v9 (copy), v1 (copy), v2 (copy), v5 (copy), v6 (copy), v3 (copy), v7 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 32)
	Frame.BackgroundColor3 = v8
	Frame.BackgroundTransparency = if p2.selected then 0.25 else 1
	Frame.BorderSizePixel = 0
	Frame.LayoutOrder = p3
	Frame.Parent = p1

	if p2.selected then
		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = v9
		UIStroke.Thickness = 1
		UIStroke.Transparency = 0.4
		UIStroke.Parent = Frame
	end

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(8, 0)
	TextLabel.Size = UDim2.fromOffset(20, 32)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 16
	TextLabel.TextColor3 = p2.color
	TextLabel.Text = "\226\150\178"
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(34, 1)
	TextLabel2.Size = UDim2.new(1, -42, 0, 16)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v2
	TextLabel2.TextSize = 13
	TextLabel2.TextColor3 = p2.selected and v5 or v6
	TextLabel2.Text = p2.name
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = Frame

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Position = UDim2.fromOffset(34, 16)
	TextLabel3.Size = UDim2.new(1, -42, 0, 14)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v3
	TextLabel3.TextSize = 11
	TextLabel3.TextColor3 = v7
	TextLabel3.Text = p2.range
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Parent = Frame
end

local function buildRanks(p1) --[[ buildRanks | Line: 389 | Upvalues: t4 (copy), buildRankTier (copy) ]]
	local Ranks = Instance.new("Frame")

	Ranks.Name = "Ranks"
	Ranks.AnchorPoint = Vector2.new(1, 0)
	Ranks.Position = UDim2.new(1, 0, 0, 0)
	Ranks.Size = UDim2.new(0.52, -4, 0, 226)
	Ranks.BackgroundTransparency = 1
	Ranks.Parent = p1

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.Parent = Ranks

	for i, v in ipairs(t4) do
		buildRankTier(Ranks, v, i)
	end
end

local function buildLeaderRow(p1, p2, p3, p4) --[[ buildLeaderRow | Line: 408 | Upvalues: v8 (copy), v2 (copy), v4 (copy), v6 (copy), v1 (copy), v3 (copy), v5 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 22)
	Frame.BackgroundColor3 = v8
	Frame.BackgroundTransparency = if p4 then 0.25 else 1
	Frame.BorderSizePixel = 0
	Frame.LayoutOrder = p3
	Frame.Parent = p1

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(8, 0)
	TextLabel.Size = UDim2.fromOffset(40, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 13
	TextLabel.TextColor3 = p4 and v4 or v6
	TextLabel.Text = tostring(p2.rank)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(48, 0)
	TextLabel2.Size = UDim2.new(1, -148, 1, 0)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = p4 and v1 or v3
	TextLabel2.TextSize = 13
	TextLabel2.TextColor3 = p4 and v5 or v5
	TextLabel2.Text = p2.name
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = Frame

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.AnchorPoint = Vector2.new(1, 0)
	TextLabel3.Position = UDim2.new(1, -10, 0, 0)
	TextLabel3.Size = UDim2.fromOffset(120, 22)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v2
	TextLabel3.TextSize = 13
	TextLabel3.TextColor3 = p4 and v4 or v5

	local rp = p2.rp
	local v7 = tostring((math.abs(rp))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

	TextLabel3.Text = (if rp < 0 then "-" .. v7 else v7) .. " RP"
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel3.Parent = Frame
end

local function buildTop(p1) --[[ buildTop | Line: 452 | Upvalues: v10 (copy), v2 (copy), v7 (copy), v4 (copy), t7 (copy), t6 (copy), buildLeaderRow (copy), v3 (copy), v5 (copy) ]]
	local Top = Instance.new("Frame")

	Top.Name = "Top"
	Top.Position = UDim2.fromOffset(0, 302)
	Top.Size = UDim2.new(1, 0, 1, -302)
	Top.BackgroundColor3 = Color3.fromRGB(34, 36, 32)
	Top.BackgroundTransparency = 0.2
	Top.BorderSizePixel = 0
	Top.Parent = p1

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v10
	UIStroke.Thickness = 1
	UIStroke.Parent = Top

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingTop = UDim.new(0, 8)
	UIPadding.PaddingBottom = UDim.new(0, 8)
	UIPadding.PaddingLeft = UDim.new(0, 12)
	UIPadding.PaddingRight = UDim.new(0, 12)
	UIPadding.Parent = Top

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 22)
	Frame.BackgroundTransparency = 1
	Frame.Parent = Top

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(0.5, 0, 1, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 13
	TextLabel.TextColor3 = v7
	TextLabel.Text = "TOP STALKERS"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.AnchorPoint = Vector2.new(1, 0)
	TextLabel2.Position = UDim2.new(1, 0, 0, 0)
	TextLabel2.Size = UDim2.new(0.6, 0, 1, 0)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v2
	TextLabel2.TextSize = 13
	TextLabel2.TextColor3 = v4

	local format = string.format
	local rank = t7.rank
	local v32 = tostring((math.abs(rank))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	local total = t7.total
	local v6 = tostring((math.abs(total))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

	TextLabel2.Text = format("YOUR RANK  #%s OF %s", if rank < 0 then "-" .. v32 else v32, if total < 0 then "-" .. v6 else v6)
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel2.Parent = Frame

	local ScrollingFrame = Instance.new("ScrollingFrame")

	ScrollingFrame.Position = UDim2.fromOffset(0, 26)
	ScrollingFrame.Size = UDim2.new(1, 0, 1, -60)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.ScrollBarThickness = 4
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
	ScrollingFrame.Parent = Top

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 2)
	UIListLayout.Parent = ScrollingFrame

	for i, v in ipairs(t6) do
		buildLeaderRow(ScrollingFrame, v, i, false)
	end

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(1, 0, 0, 12)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v3
	TextLabel3.TextSize = 12
	TextLabel3.TextColor3 = v7
	TextLabel3.Text = "\226\139\175"
	TextLabel3.LayoutOrder = #t6 + 1
	TextLabel3.Parent = ScrollingFrame
	buildLeaderRow(ScrollingFrame, t7, #t6 + 2, true)

	local Frame2 = Instance.new("Frame")

	Frame2.AnchorPoint = Vector2.new(0, 1)
	Frame2.Position = UDim2.new(0, 0, 1, 0)
	Frame2.Size = UDim2.new(0, 220, 0, 28)
	Frame2.BackgroundColor3 = Color3.fromRGB(40, 42, 45)
	Frame2.BackgroundTransparency = 0.2
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Top

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = Color3.fromRGB(80, 80, 80)
	UIStroke2.Thickness = 1
	UIStroke2.Parent = Frame2

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.Size = UDim2.fromScale(1, 1)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v2
	TextLabel4.TextSize = 13
	TextLabel4.TextColor3 = v5
	TextLabel4.Text = "VIEW FULL LEADERBOARD  \194\187"
	TextLabel4.Parent = Frame2
end

local function buildLeaderboardPanel(p1) --[[ buildLeaderboardPanel | Line: 555 | Upvalues: v11 (copy), v10 (copy), v2 (copy), v7 (copy), v3 (copy), v6 (copy), buildCurrentRank (copy), buildRanks (copy), buildTop (copy) ]]
	local LeaderboardPanel = Instance.new("Frame")

	LeaderboardPanel.Name = "LeaderboardPanel"
	LeaderboardPanel.AnchorPoint = Vector2.new(1, 0)
	LeaderboardPanel.Position = UDim2.new(1, 0, 0, 0)
	LeaderboardPanel.Size = UDim2.new(0.5, -8, 1, 0)
	LeaderboardPanel.BackgroundColor3 = v11
	LeaderboardPanel.BackgroundTransparency = 0.4
	LeaderboardPanel.BorderSizePixel = 0
	LeaderboardPanel.Parent = p1

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v10
	UIStroke.Thickness = 1
	UIStroke.Parent = LeaderboardPanel

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingTop = UDim.new(0, 12)
	UIPadding.PaddingBottom = UDim.new(0, 12)
	UIPadding.PaddingLeft = UDim.new(0, 14)
	UIPadding.PaddingRight = UDim.new(0, 14)
	UIPadding.Parent = LeaderboardPanel

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = v7
	TextLabel.Text = "LEADERBOARD REPUTATION"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = LeaderboardPanel

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(0, 24)
	TextLabel2.Size = UDim2.new(1, 0, 0, 32)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 12
	TextLabel2.TextColor3 = v6
	TextLabel2.TextWrapped = true
	TextLabel2.Text = "Compete with stalkers across the Zone. Earn reputation by completing missions, surviving, and helping others."
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.Parent = LeaderboardPanel

	local Frame = Instance.new("Frame")

	Frame.Position = UDim2.fromOffset(0, 64)
	Frame.Size = UDim2.new(1, 0, 0, 226)
	Frame.BackgroundTransparency = 1
	Frame.Parent = LeaderboardPanel
	buildCurrentRank(Frame)
	buildRanks(Frame)
	buildTop(LeaderboardPanel)
end

local t8 = {}

local function ecologistTier(p1) --[[ ecologistTier | Line: 617 ]]
	if p1 >= 20 then
		return "Respected", "friendly"
	end

	if p1 >= 7 then
		return "Trusted", "friendly"
	end

	return "Novice", "neutral"
end

local function refreshEcologistRow() --[[ refreshEcologistRow | Line: 623 | Upvalues: t3 (copy) ]]
	local ok, result = pcall(function() --[[ Line: 624 ]]
		return require(game:GetService("ReplicatedStorage"):WaitForChild("TaskController"))
	end)
	local v1 = if ok and (result and result.GetEcologistRep) then result:GetEcologistRep() or 0 else 0

	for i, v in ipairs(t3) do
		local v2, v3

		if v.name == "ECOLOGISTS" then
			if v1 >= 20 then
				v2 = "friendly"
				v3 = "Respected"
			elseif v1 >= 7 then
				v2 = "friendly"
				v3 = "Trusted"
			else
				v2 = "neutral"
				v3 = "Novice"
			end

			v.rep = v1
			v.standing = v2
			v.sub = "Scientific Faction \226\128\148 " .. v3

			return
		end
	end
end

function t8.Build(p1) --[[ Build | Line: 638 | Upvalues: refreshEcologistRow (copy), v1 (copy), v5 (copy), buildFactionPanel (copy), buildLeaderboardPanel (copy) ]]
	refreshEcologistRow()

	local PageTitle = Instance.new("TextLabel")

	PageTitle.Name = "PageTitle"
	PageTitle.Position = UDim2.fromOffset(16, 4)
	PageTitle.Size = UDim2.fromOffset(220, 30)
	PageTitle.BackgroundTransparency = 1
	PageTitle.FontFace = v1
	PageTitle.TextSize = 24
	PageTitle.TextColor3 = v5
	PageTitle.Text = "REPUTATION"
	PageTitle.TextXAlignment = Enum.TextXAlignment.Left
	PageTitle.Parent = p1

	local Body = Instance.new("Frame")

	Body.Name = "Body"
	Body.Position = UDim2.fromOffset(16, 40)
	Body.Size = UDim2.new(1, -32, 1, -48)
	Body.BackgroundTransparency = 1
	Body.Parent = p1
	buildFactionPanel(Body)
	buildLeaderboardPanel(Body)

	local ok, result = pcall(function() --[[ Line: 664 ]]
		return require(game:GetService("ReplicatedStorage"):WaitForChild("TaskController"))
	end)

	if not (ok and (result and result.OnDailyChanged)) then
		return
	end

	result:OnDailyChanged(function() --[[ Line: 666 | Upvalues: Body (copy), refreshEcologistRow (ref), buildFactionPanel (ref), buildLeaderboardPanel (ref) ]]
		if not Body.Parent then
			return
		end

		refreshEcologistRow()

		for i, v in ipairs(Body:GetChildren()) do
			v:Destroy()
		end

		buildFactionPanel(Body)
		buildLeaderboardPanel(Body)
	end)
end

return t8