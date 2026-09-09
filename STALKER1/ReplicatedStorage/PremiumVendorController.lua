-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

game:GetService("RunService")

local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))
local SkinCatalog = require(ReplicatedStorage:WaitForChild("SkinCatalog"))
local LocalPlayer = Players.LocalPlayer
local t = {
	IsOpen = false,
	CurrentNPC = nil,
	CurrentTab = "SupporterPacks",
	SelectedProductID = nil,
	Products = {},
	_tileFrames = {},
	_tabButtons = {}
}
local v1 = Color3.fromRGB(14, 15, 17)
local v2 = Color3.fromRGB(22, 23, 26)
local v3 = Color3.fromRGB(32, 33, 37)
local v4 = Color3.fromRGB(44, 45, 50)
local v5 = Color3.fromRGB(230, 230, 230)
local v6 = Color3.fromRGB(155, 155, 155)
local v7 = Color3.fromRGB(100, 100, 105)
local v8 = Color3.fromRGB(215, 175, 75)
local v9 = Color3.fromRGB(145, 115, 45)
local v10 = Color3.fromRGB(20, 15, 5)
local v11 = Color3.fromRGB(110, 155, 145)
local v12 = Color3.fromRGB(15, 30, 28)
local v13 = Color3.fromRGB(55, 58, 62)
local v14 = Color3.fromRGB(215, 175, 75)
local t2 = {
	{
		id = "SupporterPacks",
		label = "SUPPORTER PACKS"
	},
	{
		id = "StashExpansion",
		label = "STASH EXPANSION"
	},
	{
		id = "Bundles",
		label = "BUNDLES"
	},
	{
		id = "FactionPacks",
		label = "FACTION UNIFORM PACKS"
	},
	{
		id = "IndividualSkins",
		label = "INDIVIDUAL SKINS"
	}
}
local t3 = { "DutySentinel", "ShadowOfTheZoneMercenary", "FreedomVanguard" }
local t4 = { "MercenaryFactionUniforms", "DutyFactionUniforms", "FreedomFactionUniforms" }

local function resolveModelName(p1) --[[ resolveModelName | Line: 62 | Upvalues: ItemDatabase (copy) ]]
	if not p1 then
		return nil
	end

	local v1 = ItemDatabase.GetItemData(p1)

	return if v1 then v1.Model or p1 else p1
end

local function resolveViewAngle(p1) --[[ resolveViewAngle | Line: 70 | Upvalues: ItemDatabase (copy) ]]
	if not p1 then
		return "headon"
	end

	local v1 = ItemDatabase.GetItemData(p1)

	if v1 and v1.ItemType == "Uniform" then
		return "angled"
	end

	return "headon"
end

local function findSourceModel(p1) --[[ findSourceModel | Line: 81 | Upvalues: ReplicatedStorage (copy) ]]
	if not p1 or p1 == "" then
		return nil
	end

	local ViewportFrameModels = ReplicatedStorage:FindFirstChild("ViewportFrameModels")

	if ViewportFrameModels then
		local v1 = ViewportFrameModels:FindFirstChild(p1)

		if v1 then
			return v1
		end
	end

	local Clothing = ReplicatedStorage:FindFirstChild("Clothing")

	if Clothing then
		for i, v in ipairs(Clothing:GetChildren()) do
			if v:IsA("Folder") then
				local v2 = v:FindFirstChild(p1)

				if v2 then
					return v2
				end
			end
		end
	end

	local PlayerItems = ReplicatedStorage:FindFirstChild("PlayerItems")

	if not PlayerItems then
		return nil
	end

	for i, v in ipairs(PlayerItems:GetChildren()) do
		if v:IsA("Folder") then
			local v3 = v:FindFirstChild(p1)

			if v3 then
				return v3
			end
		end
	end

	return nil
end

local function resolveSourceModel(p1) --[[ resolveSourceModel | Line: 111 | Upvalues: findSourceModel (copy) ]]
	if type(p1) == "string" then
		return findSourceModel(p1)
	end

	if type(p1) ~= "table" then
		return nil
	end

	for i, v in ipairs(p1) do
		local v1 = findSourceModel(v)

		if v1 then
			return v1
		end
	end

	return nil
end

local RunService = game:GetService("RunService")
local t5 = { Vector3.new(0, 0, 1.6), Vector3.new(-3, 0, -1.2), Vector3.new(3, 0, -1.2) }

local function createViewportForModel(p1, p2, p3, p4) --[[ createViewportForModel | Line: 144 | Upvalues: v4 (copy), t5 (copy), findSourceModel (copy), RunService (copy) ]]
	local ItemViewport = Instance.new("ViewportFrame")

	ItemViewport.Name = "ItemViewport"
	ItemViewport.Size = UDim2.fromScale(1, 1)
	ItemViewport.BackgroundColor3 = v4
	ItemViewport.BorderSizePixel = 0
	ItemViewport.LightColor = Color3.fromRGB(220, 210, 180)
	ItemViewport.LightDirection = (Vector3.new(-0.4, -1, -0.3)).Unit
	ItemViewport.Ambient = Color3.fromRGB(90, 90, 95)
	ItemViewport.Parent = p1

	local Camera = Instance.new("Camera")

	Camera.FieldOfView = 40
	ItemViewport.CurrentCamera = Camera
	Camera.Parent = ItemViewport

	local v1 = Vector3.new(0, 0, 0)
	local v2 = Vector3.new(0, 0, 5)

	local function prep(p1) --[[ prep | Line: 165 | Upvalues: ItemViewport (copy) ]]
		local v1 = p1:Clone()

		for i, v in ipairs(v1:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Anchored = true
				v.CanCollide = false
			end
		end

		v1.Parent = ItemViewport

		local v2 = nil
		local v3 = nil

		if v1:IsA("Model") then
			local v4, v5 = v1:GetBoundingBox()

			return v1, v4, v5
		end

		local v6 = v1:FindFirstChildWhichIsA("BasePart", true)

		if v6 then
			v2 = v6.CFrame
			v3 = v6.Size
		end

		return v1, v2, v3
	end

	local v3 = if p4 and #p4 > 0 then p4 else nil
	local v42 = false

	if v3 then
		local list = {}

		for i, v in ipairs(v3) do
			if #t5 < i then
				break
			end

			local v5 = findSourceModel(v)

			if v5 then
				local v6, v7, v8 = prep(v5)

				if v7 then
					v6:PivotTo(CFrame.new(t5[i]))

					if v8 then
						table.insert(list, {
							pos = t5[i],
							size = v8
						})
					end

					v42 = true
				end
			end
		end

		if v42 then
			local v9 = Vector3.new(inf, inf, inf)
			local v10 = Vector3.new(-inf, -inf, -inf)

			for i, v in ipairs(list) do
				local v11 = v.size / 2

				v9 = Vector3.new(math.min(v9.X, v.pos.X - v11.X), math.min(v9.Y, v.pos.Y - v11.Y), (math.min(v9.Z, v.pos.Z - v11.Z)))
				v10 = Vector3.new(math.max(v10.X, v.pos.X + v11.X), math.max(v10.Y, v.pos.Y + v11.Y), (math.max(v10.Z, v.pos.Z + v11.Z)))
			end

			local v25 = v10 - v9

			v2 = Vector3.new(0, 0, math.max(v25.X, v25.Y, v25.Z, 1) * 1.35)
			v1 = (v9 + v10) / 2
		end
	else
		local list = {}

		if type(p2) == "string" then
			table.insert(list, p2)
		elseif type(p2) == "table" then
			for i, v in ipairs(p2) do
				table.insert(list, v)
			end
		end

		for i, v in ipairs(list) do
			local v27 = findSourceModel(v)

			if v27 then
				local _, v28, v29 = prep(v27)

				if v28 and v29 then
					local v30 = math.max(v29.X, v29.Y, v29.Z, 1)

					v1 = v28.Position
					v2 = Vector3.new(0, 0, v30 * 1.35)
				end

				v42 = true

				break
			end
		end
	end

	if v42 then
		local v31 = 0
		local v32 = nil

		v32 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 248 | Upvalues: ItemViewport (copy), v32 (ref), v31 (ref), v2 (ref), Camera (copy), v1 (ref) ]]
			if ItemViewport.Parent then
				v31 = v31 + 0.6108652381980153 * p1
				Camera.CFrame = CFrame.new(v1 + CFrame.Angles(0, v31, 0) * v2, v1)
			else
				v32:Disconnect()
			end
		end)
	else
		Camera.CFrame = CFrame.new(0, 0, 5)
	end

	return ItemViewport
end

local function build() --[[ build | Line: 261 | Upvalues: LocalPlayer (copy), v2 (copy), v13 (copy), v1 (copy), v5 (copy), v8 (copy), v7 (copy) ]]
	local PremiumVendorGui = Instance.new("ScreenGui")

	PremiumVendorGui.Name = "PremiumVendorGui"
	PremiumVendorGui.ResetOnSpawn = false
	PremiumVendorGui.IgnoreGuiInset = true
	PremiumVendorGui.DisplayOrder = 20
	PremiumVendorGui.Enabled = false
	PremiumVendorGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	local Dim = Instance.new("Frame")

	Dim.Name = "Dim"
	Dim.Size = UDim2.fromScale(1, 1)
	Dim.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	Dim.BackgroundTransparency = 0.4
	Dim.BorderSizePixel = 0
	Dim.Parent = PremiumVendorGui

	local Panel = Instance.new("Frame")

	Panel.Name = "Panel"
	Panel.AnchorPoint = Vector2.new(0.5, 0.5)
	Panel.Position = UDim2.fromScale(0.5, 0.5)
	Panel.Size = UDim2.fromOffset(1080, 620)
	Panel.BackgroundColor3 = v2
	Panel.BorderSizePixel = 0
	Panel.ClipsDescendants = true
	Panel.Parent = PremiumVendorGui

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v13
	UIStroke.Thickness = 1
	UIStroke.Parent = Panel

	local Header = Instance.new("Frame")

	Header.Name = "Header"
	Header.Size = UDim2.new(1, 0, 0, 60)
	Header.Position = UDim2.fromOffset(0, 0)
	Header.BackgroundColor3 = v1
	Header.BorderSizePixel = 0
	Header.Parent = Panel

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 1)
	Frame.Position = UDim2.new(0, 0, 1, -1)
	Frame.BackgroundColor3 = v13
	Frame.BorderSizePixel = 0
	Frame.Parent = Header

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(0, 500, 0, 26)
	TextLabel.Position = UDim2.fromOffset(20, 8)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = "PREMIUM VENDOR"
	TextLabel.TextColor3 = v5
	TextLabel.TextSize = 20
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Header

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(0, 500, 0, 16)
	TextLabel2.Position = UDim2.fromOffset(20, 34)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Text = "QUARTERMASTER // SUPPORTER GOODS"
	TextLabel2.TextColor3 = v8
	TextLabel2.TextSize = 11
	TextLabel2.Font = Enum.Font.GothamBold
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = Header

	local Close = Instance.new("TextButton")

	Close.Name = "Close"
	Close.Size = UDim2.fromOffset(32, 32)
	Close.AnchorPoint = Vector2.new(1, 0.5)
	Close.Position = UDim2.new(1, -14, 0.5, 0)
	Close.BackgroundColor3 = Color3.fromRGB(155, 50, 50)
	Close.BackgroundTransparency = 0
	Close.BorderSizePixel = 0
	Close.Text = "X"
	Close.TextColor3 = Color3.fromRGB(240, 230, 225)
	Close.TextSize = 16
	Close.Font = Enum.Font.GothamBold
	Close.AutoButtonColor = true
	Close.Parent = Header

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = Color3.fromRGB(90, 25, 25)
	UIStroke2.Thickness = 1
	UIStroke2.Parent = Close

	local Footer = Instance.new("Frame")

	Footer.Name = "Footer"
	Footer.Size = UDim2.new(1, 0, 0, 26)
	Footer.Position = UDim2.new(0, 0, 1, -26)
	Footer.BackgroundColor3 = v1
	Footer.BorderSizePixel = 0
	Footer.Parent = Panel

	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.new(1, 0, 0, 1)
	Frame2.Position = UDim2.new(0, 0, 0, 0)
	Frame2.BackgroundColor3 = v13
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Footer

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(0, 400, 1, 0)
	TextLabel3.Position = UDim2.fromOffset(16, 0)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.Text = "ZONE STALKER // PREMIUM ACCESS"
	TextLabel3.TextColor3 = v7
	TextLabel3.TextSize = 10
	TextLabel3.Font = Enum.Font.GothamBold
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Parent = Footer

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.Size = UDim2.new(0, 400, 1, 0)
	TextLabel4.AnchorPoint = Vector2.new(1, 0)
	TextLabel4.Position = UDim2.new(1, -16, 0, 0)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.Text = "SECURE TRANSACTION VIA ROBLOX"
	TextLabel4.TextColor3 = v7
	TextLabel4.TextSize = 10
	TextLabel4.Font = Enum.Font.Gotham
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel4.Parent = Footer

	local Sidebar = Instance.new("Frame")

	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.fromOffset(220, 534)
	Sidebar.Position = UDim2.fromOffset(0, 60)
	Sidebar.BackgroundColor3 = v1
	Sidebar.BorderSizePixel = 0
	Sidebar.Parent = Panel

	local SidebarBorder = Instance.new("Frame")

	SidebarBorder.Name = "SidebarBorder"
	SidebarBorder.Size = UDim2.fromOffset(1, 534)
	SidebarBorder.Position = UDim2.fromOffset(219, 60)
	SidebarBorder.BackgroundColor3 = v13
	SidebarBorder.BorderSizePixel = 0
	SidebarBorder.Parent = Panel

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	UIListLayout.Parent = Sidebar

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingTop = UDim.new(0, 16)
	UIPadding.PaddingLeft = UDim.new(0, 10)
	UIPadding.PaddingRight = UDim.new(0, 10)
	UIPadding.Parent = Sidebar

	local GridArea = Instance.new("Frame")

	GridArea.Name = "GridArea"
	GridArea.Size = UDim2.fromOffset(560, 534)
	GridArea.Position = UDim2.fromOffset(220, 60)
	GridArea.BackgroundColor3 = v2
	GridArea.BorderSizePixel = 0
	GridArea.Parent = Panel

	local GridTitle = Instance.new("TextLabel")

	GridTitle.Name = "GridTitle"
	GridTitle.Size = UDim2.new(1, -32, 0, 22)
	GridTitle.Position = UDim2.fromOffset(16, 12)
	GridTitle.BackgroundTransparency = 1
	GridTitle.Text = "SUPPORTER PACKS"
	GridTitle.TextColor3 = v8
	GridTitle.TextSize = 13
	GridTitle.Font = Enum.Font.GothamBold
	GridTitle.TextXAlignment = Enum.TextXAlignment.Left
	GridTitle.Parent = GridArea

	local Grid = Instance.new("ScrollingFrame")

	Grid.Name = "Grid"
	Grid.Size = UDim2.new(1, 0, 1, -44)
	Grid.Position = UDim2.fromOffset(0, 44)
	Grid.BackgroundTransparency = 1
	Grid.BorderSizePixel = 0
	Grid.ScrollBarThickness = 6
	Grid.ScrollBarImageColor3 = v13
	Grid.CanvasSize = UDim2.fromScale(0, 0)
	Grid.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Grid.Parent = GridArea

	local UIGridLayout = Instance.new("UIGridLayout")

	UIGridLayout.CellSize = UDim2.fromOffset(148, 176)
	UIGridLayout.CellPadding = UDim2.fromOffset(10, 10)
	UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.Parent = Grid

	local UIPadding2 = Instance.new("UIPadding")

	UIPadding2.PaddingTop = UDim.new(0, 4)
	UIPadding2.PaddingBottom = UDim.new(0, 12)
	UIPadding2.PaddingLeft = UDim.new(0, 16)
	UIPadding2.PaddingRight = UDim.new(0, 16)
	UIPadding2.Parent = Grid

	local Detail = Instance.new("Frame")

	Detail.Name = "Detail"
	Detail.Size = UDim2.fromOffset(300, 534)
	Detail.Position = UDim2.fromOffset(780, 60)
	Detail.BackgroundColor3 = v1
	Detail.BorderSizePixel = 0
	Detail.Parent = Panel

	local Frame3 = Instance.new("Frame")

	Frame3.Size = UDim2.new(0, 1, 1, 0)
	Frame3.Position = UDim2.new(0, 0, 0, 0)
	Frame3.BackgroundColor3 = v13
	Frame3.BorderSizePixel = 0
	Frame3.Parent = Detail

	return PremiumVendorGui, Panel, Sidebar, GridTitle, Grid, Detail, Close
end

local function makeSidebarTab(p1, p2, p3, p4) --[[ makeSidebarTab | Line: 492 | Upvalues: v3 (copy), v6 (copy), v8 (copy) ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Name = "Tab_" .. p3.id
	TextButton.LayoutOrder = p2
	TextButton.Size = UDim2.new(1, 0, 0, 38)
	TextButton.BackgroundColor3 = v3
	TextButton.BorderSizePixel = 0
	TextButton.Text = ""
	TextButton.AutoButtonColor = false
	TextButton.Parent = p1

	local Label = Instance.new("TextLabel")

	Label.Name = "Label"
	Label.Size = UDim2.new(1, -20, 1, 0)
	Label.Position = UDim2.fromOffset(12, 0)
	Label.BackgroundTransparency = 1
	Label.Text = p3.label
	Label.TextColor3 = v6
	Label.TextSize = 11
	Label.Font = Enum.Font.GothamBold
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = TextButton

	local AccentBar = Instance.new("Frame")

	AccentBar.Name = "AccentBar"
	AccentBar.Size = UDim2.new(0, 3, 1, 0)
	AccentBar.BackgroundColor3 = v8
	AccentBar.BorderSizePixel = 0
	AccentBar.Visible = false
	AccentBar.Parent = TextButton
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 523 | Upvalues: p4 (copy), p3 (copy) ]]
		p4(p3.id)
	end)

	return TextButton, Label, AccentBar
end

local function makeTile(p1, p2, p3, p4, p5) --[[ makeTile | Line: 528 | Upvalues: v3 (copy), v14 (copy), v13 (copy), v4 (copy), createViewportForModel (copy), v5 (copy), v6 (copy), v11 (copy), v9 (copy), v12 (copy) ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Name = "Tile_" .. p3.id
	TextButton.LayoutOrder = p2
	TextButton.BackgroundColor3 = v3
	TextButton.BorderSizePixel = 0
	TextButton.Text = ""
	TextButton.AutoButtonColor = false
	TextButton.Parent = p1

	local SelectionStroke = Instance.new("UIStroke")

	SelectionStroke.Name = "SelectionStroke"
	SelectionStroke.Color = p4 and v14 or v13
	SelectionStroke.Thickness = if p4 then 2 else 1
	SelectionStroke.Parent = TextButton

	local IconWrap = Instance.new("Frame")

	IconWrap.Name = "IconWrap"
	IconWrap.Size = UDim2.new(1, -14, 0, 76)
	IconWrap.Position = UDim2.fromOffset(7, 8)
	IconWrap.BackgroundColor3 = v4
	IconWrap.BorderSizePixel = 0
	IconWrap.ClipsDescendants = true
	IconWrap.Parent = TextButton
	createViewportForModel(IconWrap, p3.modelName, p3.viewAngle, p3.wedgeModels)

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, -14, 0, 16)
	TextLabel.Position = UDim2.fromOffset(7, 90)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = string.upper(p3.name or "?")
	TextLabel.TextColor3 = v5
	TextLabel.TextSize = 11
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel.Parent = TextButton

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, -14, 0, 32)
	TextLabel2.Position = UDim2.fromOffset(7, 108)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Text = p3.shortDesc or ""
	TextLabel2.TextColor3 = v6
	TextLabel2.TextSize = 10
	TextLabel2.Font = Enum.Font.Gotham
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.TextWrapped = true
	TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel2.Parent = TextButton

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, -14, 0, 24)
	Frame.Position = UDim2.new(0, 7, 1, -32)
	Frame.BackgroundColor3 = p3.isOwned and v11 or v9
	Frame.BorderSizePixel = 0
	Frame.Parent = TextButton

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.fromScale(1, 1)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.Font = Enum.Font.GothamBold
	TextLabel3.TextSize = 11

	if p3.isOwned then
		TextLabel3.Text = p3.ownedLabel or "OWNED"
		TextLabel3.TextColor3 = v12
	else
		if p3.priceRobux and p3.priceRobux > 0 then
			TextLabel3.Text = string.format("\238\128\130 %d", p3.priceRobux)
		else
			TextLabel3.Text = "VIEW"
		end

		TextLabel3.TextColor3 = v5
	end

	TextLabel3.Parent = Frame
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 605 | Upvalues: p5 (copy), p3 (copy) ]]
		p5(p3.id)
	end)

	return TextButton
end

local function renderDetail(p1, p2, p3) --[[ renderDetail | Line: 610 | Upvalues: v7 (copy), v13 (copy), v5 (copy), v8 (copy), v4 (copy), createViewportForModel (copy), v6 (copy), v11 (copy), v12 (copy), v10 (copy) ]]
	for i, v in ipairs(p1:GetChildren()) do
		if (not v:IsA("Frame") or v.Name ~= "DetailBorder") and v.Name ~= "DetailBorder" then
			v:Destroy()
		end
	end

	if not p2 then
		local EmptyState = Instance.new("TextLabel")

		EmptyState.Name = "EmptyState"
		EmptyState.AnchorPoint = Vector2.new(0.5, 0.5)
		EmptyState.Position = UDim2.fromScale(0.5, 0.5)
		EmptyState.Size = UDim2.new(1, -32, 0, 60)
		EmptyState.BackgroundTransparency = 1
		EmptyState.Text = "SELECT AN ITEM"
		EmptyState.TextColor3 = v7
		EmptyState.TextSize = 11
		EmptyState.Font = Enum.Font.GothamBold
		EmptyState.Parent = p1

		return
	end

	local DetailScroll = Instance.new("ScrollingFrame")

	DetailScroll.Name = "DetailScroll"
	DetailScroll.Size = UDim2.new(1, 0, 1, -74)
	DetailScroll.BackgroundTransparency = 1
	DetailScroll.BorderSizePixel = 0
	DetailScroll.ScrollBarThickness = 4
	DetailScroll.ScrollBarImageColor3 = v13
	DetailScroll.CanvasSize = UDim2.fromScale(0, 0)
	DetailScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	DetailScroll.Parent = p1

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.Parent = DetailScroll

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingTop = UDim.new(0, 18)
	UIPadding.PaddingLeft = UDim.new(0, 18)
	UIPadding.PaddingRight = UDim.new(0, 18)
	UIPadding.PaddingBottom = UDim.new(0, 12)
	UIPadding.Parent = DetailScroll

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = string.upper(p2.name or "?")
	TextLabel.TextColor3 = v5
	TextLabel.TextSize = 17
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.LayoutOrder = 1
	TextLabel.Parent = DetailScroll

	if p2.subtitle then
		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Size = UDim2.new(1, 0, 0, 13)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.Text = p2.subtitle
		TextLabel2.TextColor3 = v8
		TextLabel2.TextSize = 10
		TextLabel2.Font = Enum.Font.GothamBold
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.LayoutOrder = 2
		TextLabel2.Parent = DetailScroll
	end

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 160)
	Frame.BackgroundColor3 = v4
	Frame.BorderSizePixel = 0
	Frame.ClipsDescendants = true
	Frame.LayoutOrder = 3
	Frame.Parent = DetailScroll
	createViewportForModel(Frame, p2.modelName, p2.viewAngle, p2.wedgeModels)

	if p2.longDesc and p2.longDesc ~= "" then
		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Size = UDim2.new(1, 0, 0, 0)
		TextLabel2.AutomaticSize = Enum.AutomaticSize.Y
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.Text = p2.longDesc
		TextLabel2.TextColor3 = v6
		TextLabel2.TextSize = 11
		TextLabel2.Font = Enum.Font.Gotham
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel2.TextWrapped = true
		TextLabel2.LayoutOrder = 4
		TextLabel2.Parent = DetailScroll
	end

	if p2.bullets and #p2.bullets > 0 then
		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Size = UDim2.new(1, 0, 0, 14)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.Text = "INCLUDES"
		TextLabel2.TextColor3 = v8
		TextLabel2.TextSize = 10
		TextLabel2.Font = Enum.Font.GothamBold
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.LayoutOrder = 5
		TextLabel2.Parent = DetailScroll

		for i, v in ipairs(p2.bullets) do
			local TextLabel3 = Instance.new("TextLabel")

			TextLabel3.Size = UDim2.new(1, 0, 0, 0)
			TextLabel3.AutomaticSize = Enum.AutomaticSize.Y
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.Text = "  \226\128\162  " .. v
			TextLabel3.TextColor3 = v5
			TextLabel3.TextSize = 11
			TextLabel3.Font = Enum.Font.Gotham
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel3.TextWrapped = true
			TextLabel3.LayoutOrder = 5 + i
			TextLabel3.Parent = DetailScroll
		end
	end

	local PurchaseBtn = Instance.new("TextButton")

	PurchaseBtn.Name = "PurchaseBtn"
	PurchaseBtn.AnchorPoint = Vector2.new(0.5, 1)
	PurchaseBtn.Position = UDim2.new(0.5, 0, 1, -14)
	PurchaseBtn.Size = UDim2.new(1, -32, 0, 42)
	PurchaseBtn.BorderSizePixel = 0
	PurchaseBtn.Font = Enum.Font.GothamBold
	PurchaseBtn.TextSize = 13
	PurchaseBtn.AutoButtonColor = not p2.isOwned
	PurchaseBtn.Parent = p1

	if p2.isOwned then
		PurchaseBtn.BackgroundColor3 = v11
		PurchaseBtn.Text = p2.ownedLabel or "OWNED"
		PurchaseBtn.TextColor3 = v12
		PurchaseBtn.Active = false
	else
		PurchaseBtn.BackgroundColor3 = v8

		if p2.priceRobux and p2.priceRobux > 0 then
			PurchaseBtn.Text = string.format("PURCHASE  \238\128\130 %d", p2.priceRobux)
		else
			PurchaseBtn.Text = "PURCHASE"
		end

		PurchaseBtn.TextColor3 = v10
		PurchaseBtn.MouseButton1Click:Connect(function() --[[ Line: 757 | Upvalues: p3 (copy), p2 (copy) ]]
			p3(p2)
		end)
	end

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v13
	UIStroke.Thickness = 1
	UIStroke.Parent = PurchaseBtn
end

local function buildProducts(p1) --[[ buildProducts | Line: 766 | Upvalues: ItemDatabase (copy), t3 (copy), SkinCatalog (copy), t4 (copy) ]]
	local t = {}

	if p1.SupporterCatalog and p1.SupporterCatalog.Tiers then
		for v5, v6 in ipairs(p1.SupporterCatalog.TierOrder or {}) do
			local v3, v4
			local v7 = p1.SupporterCatalog.Tiers[v6]

			if v7 then
				local v8 = if p1.currentSupporterTierKey == v6 then true else false
				local t2 = { string.format("Stash +%d tiers", v7.StashTierBonus or 0), "Respawn insurance kit" }

				if v7.ChatPrefix and v7.ChatPrefix ~= "" then
					table.insert(t2, v7.ChatPrefix .. " chat prefix")
				end

				if v7.UniformPacks and #v7.UniformPacks > 0 then
					table.insert(t2, #v7.UniformPacks .. " faction uniform pack(s)")
				elseif v6 == "Veteran" then
					table.insert(t2, "1 faction pack (your choice)")
				end

				if v7.ExclusiveSkins and #v7.ExclusiveSkins > 0 then
					table.insert(t2, #v7.ExclusiveSkins .. " exclusive skin(s)")
				end

				if v7.BadgeID and v7.BadgeID ~= 0 then
					table.insert(t2, "Supporter badge")
				end

				local v12 = v7.ExclusiveSkins and v7.ExclusiveSkins[#v7.ExclusiveSkins]
				local t5 = {
					tab = "SupporterPacks",
					subtitle = "SUPPORTER TIER",
					longDesc = "Layered value stack for long-term supporters. All perks stack on top of the base game \226\128\148 no gameplay advantage granted.",
					icon = "",
					priceRobux = 0,
					priceType = "gamepass",
					ownedLabel = "OWNED",
					id = "sup:" .. v6,
					name = v7.DisplayName or v6,
					shortDesc = string.format("Stash +%d, kit, chat identity.", v7.StashTierBonus or 0),
					bullets = t2
				}
				local t6 = {}

				if v12 then
					local v14 = ItemDatabase.GetItemData(v12)

					v3 = if v14 then v14.Model or v12 else v12
				else
					v3 = nil
				end

				t6[1] = v6 .. "Pack"
				t6[2] = v3
				t5.modelName = t6

				if v12 then
					local v15 = ItemDatabase.GetItemData(v12)

					v4 = if v15 and v15.ItemType == "Uniform" then "angled" else "headon"
				else
					v4 = "headon"
				end

				t5.viewAngle = v4
				t5.gamepassID = v7.GamepassID or 0
				t5.isOwned = v8
				table.insert(t, t5)
			end
		end
	end

	local v16 = if p1.currentPremiumTier >= p1.MAX_TIER then true else false
	local t2 = { string.format("Current tier: %d / %d", p1.currentPremiumTier, p1.MAX_TIER) }

	if p1.StashTierConfig and p1.StashTierConfig.GetNextPremiumSize then
		local v17 = p1.StashTierConfig.GetNextPremiumSize(p1.currentPremiumTier)

		if v17 then
			table.insert(t2, string.format("Next size: %dx%d", v17.X, v17.Y))
		end
	end

	table.insert(t2, "Persists across wipes")
	table.insert(t2, "Account-bound")

	local t5 = {
		id = "stash",
		tab = "StashExpansion",
		name = "Stash Expansion +1 Row",
		subtitle = "DEV PRODUCT",
		shortDesc = "+1 row of stash storage. Permanent.",
		longDesc = "Adds one row to your personal stash. Permanent upgrade, persists across wipes, account-bound.",
		icon = "",
		priceRobux = 199,
		priceType = "devproduct",
		ownedLabel = "MAX TIER",
		bullets = t2
	}

	t5.devProductID = p1.StashTierConfig and p1.StashTierConfig.PremiumStashDevProductId or 0
	t5.isOwned = v16
	table.insert(t, t5)

	for i, v in ipairs(t3) do
		local v19, v20
		local v21 = SkinCatalog.Packs and SkinCatalog.Packs[v]

		if v21 then
			local v22 = true

			for v25, v26 in ipairs(v21.Skins or {}) do
				if not p1.ownedSet[v26] then
					v22 = false

					break
				end
			end

			local t6 = {}

			for v29, v30 in ipairs(v21.Skins or {}) do
				local v31 = ItemDatabase.GetItemData(v30)

				table.insert(t6, ItemDatabase.GetItemData(v30) and v31.Name or v30)
			end

			local v33 = v21.Skins and v21.Skins[1]
			local t7 = {
				tab = "Bundles",
				subtitle = "LOADOUT BUNDLE",
				shortDesc = "Uniform + armor + helmet + facewear.",
				longDesc = "Themed set that unlocks the listed skins as a bundle. Applies as cosmetic skins over equipped gear.",
				icon = "",
				priceRobux = 0,
				priceType = "gamepass",
				ownedLabel = "OWNED",
				id = "loadout:" .. v,
				name = v21.DisplayName or v,
				bullets = t6
			}
			local t8 = {}

			if v33 then
				local v35 = ItemDatabase.GetItemData(v33)

				v19 = if v35 then v35.Model or v33 else v33
			else
				v19 = nil
			end

			t8[1] = v .. "Pack"
			t8[2] = v19
			t7.modelName = t8

			if v33 then
				local v36 = ItemDatabase.GetItemData(v33)

				v20 = if v36 and v36.ItemType == "Uniform" then "angled" else "headon"
			else
				v20 = "headon"
			end

			t7.viewAngle = v20
			t7.gamepassID = v21.GamepassID or 0
			t7.isOwned = v22
			table.insert(t, t7)
		end
	end

	for i, v in ipairs(t4) do
		local v37, v38
		local v39 = SkinCatalog.Packs and SkinCatalog.Packs[v]

		if v39 then
			local v40 = true
			local v41 = ipairs

			for v43, v44 in v41(v39.Skins or {}) do
				if not p1.ownedSet[v44] then
					v40 = false

					break
				end
			end

			local t6 = {}
			local v45 = ipairs

			for v47, v48 in v45(v39.Skins or {}) do
				local v49 = ItemDatabase.GetItemData(v48)

				table.insert(t6, ItemDatabase.GetItemData(v48) and v49.Name or v48)
			end

			local v51 = v39.Skins and v39.Skins[1]
			local t7 = {
				tab = "FactionPacks",
				subtitle = "FACTION PACK",
				shortDesc = "Iconic faction uniforms bundle.",
				longDesc = "Unlocks every uniform in this faction\'s set as a cosmetic skin. Applies over any equipped uniform.",
				icon = "",
				priceRobux = 0,
				priceType = "gamepass",
				ownedLabel = "OWNED",
				id = "faction:" .. v,
				name = v39.DisplayName or v,
				bullets = t6
			}
			local t8 = {}

			if v51 then
				local v53 = ItemDatabase.GetItemData(v51)

				v37 = if v53 then v53.Model or v51 else v51
			else
				v37 = nil
			end

			t8[1] = v .. "Pack"
			t8[2] = v37
			t7.modelName = t8

			local t9 = {}
			local v54 = ipairs

			for v57, v58 in v54(v39.Skins or {}) do
				local v56

				if v58 then
					local v59 = ItemDatabase.GetItemData(v58)

					v56 = if v59 then v59.Model or v58 else v58
				else
					v56 = nil
				end

				if v56 then
					table.insert(t9, v56)
				end
			end

			t7.wedgeModels = t9

			if v51 then
				local v60 = ItemDatabase.GetItemData(v51)

				v38 = if v60 and v60.ItemType == "Uniform" then "angled" else "headon"
			else
				v38 = "headon"
			end

			t7.viewAngle = v38
			t7.gamepassID = v39.GamepassID or 0
			t7.isOwned = v40
			table.insert(t, t7)
		end
	end

	local list = {}

	for k in pairs(SkinCatalog.Skins) do
		table.insert(list, k)
	end

	table.sort(list)

	for i, v in ipairs(list) do
		local v61, v62
		local v63 = SkinCatalog.Skins[v]
		local v64 = ItemDatabase.GetItemData(v)
		local v65 = if p1.ownedSet[v] == true then true else false
		local t6 = {
			tab = "IndividualSkins",
			priceType = "devproduct",
			ownedLabel = "OWNED",
			id = "skin:" .. v
		}

		t6.name = v64 and v64.Name or v
		t6.subtitle = string.upper(v64 and v64.ItemType or "SKIN")
		t6.shortDesc = v64 and v64.Description or "Cosmetic skin."
		t6.longDesc = v64 and v64.Description or "Cosmetic skin."

		local t7 = {}

		t7[1] = v64 and v64.ItemType or "Skin"
		t6.bullets = t7
		t6.icon = v64 and v64.ImageID or ""

		if v then
			local v72 = ItemDatabase.GetItemData(v)

			v61 = if v72 then v72.Model or v else v
		else
			v61 = nil
		end

		t6.modelName = v61

		if v then
			local v73 = ItemDatabase.GetItemData(v)

			v62 = if v73 and v73.ItemType == "Uniform" then "angled" else "headon"
		else
			v62 = "headon"
		end

		t6.viewAngle = v62
		t6.priceRobux = v63.PriceRobux or 0
		t6.devProductID = v63.DevProductID or 0
		t6.isOwned = v65
		table.insert(t, t6)
	end

	return t
end

local function freezeInput() --[[ freezeInput | Line: 953 | Upvalues: LocalPlayer (copy), UserInputService (copy), RunService (copy) ]]
	local ok, result = pcall(function() --[[ Line: 954 | Upvalues: LocalPlayer (ref) ]]
		return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
	end)

	if ok and (result and result.GetControls) then
		local v1 = result:GetControls()

		if v1 and v1.Disable then
			v1:Disable()
		end
	end

	UserInputService.MouseIconEnabled = true
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	pcall(function() --[[ Line: 963 | Upvalues: RunService (ref), UserInputService (ref) ]]
		RunService:BindToRenderStep("PremiumVendorMouseKeeper", Enum.RenderPriority.Camera.Value + 100, function() --[[ Line: 964 | Upvalues: UserInputService (ref) ]]
			if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			if UserInputService.MouseIconEnabled then
				return
			end

			UserInputService.MouseIconEnabled = true
		end)
	end)
end

local function unfreezeInput() --[[ unfreezeInput | Line: 977 | Upvalues: RunService (copy), LocalPlayer (copy) ]]
	pcall(function() --[[ Line: 978 | Upvalues: RunService (ref) ]]
		RunService:UnbindFromRenderStep("PremiumVendorMouseKeeper")
	end)

	local ok, result = pcall(function() --[[ Line: 979 | Upvalues: LocalPlayer (ref) ]]
		return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
	end)

	if not (ok and (result and result.GetControls)) then
		return
	end

	local v1 = result:GetControls()

	if not (v1 and v1.Enable) then
		return
	end

	v1:Enable()
end

local function purchaseProduct(p1) --[[ purchaseProduct | Line: 988 | Upvalues: MarketplaceService (copy), LocalPlayer (copy) ]]
	if not p1 or p1.isOwned then
		return
	end

	if p1.priceType == "gamepass" and (p1.gamepassID and p1.gamepassID > 0) then
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, p1.gamepassID)

		return
	end

	if p1.priceType == "devproduct" and (p1.devProductID and p1.devProductID > 0) then
		MarketplaceService:PromptProductPurchase(LocalPlayer, p1.devProductID)

		return
	end

	local v1 = warn

	v1("[PremiumVendor] no purchase target configured for " .. tostring(p1.id))
end

function t._currentTabLabel(p1) --[[ _currentTabLabel | Line: 999 | Upvalues: t2 (copy) ]]
	for i, v in ipairs(t2) do
		if v.id == p1.CurrentTab then
			return v.label
		end
	end

	return "?"
end
function t._renderSidebar(p1) --[[ _renderSidebar | Line: 1006 | Upvalues: v4 (copy), v3 (copy), v5 (copy), v6 (copy) ]]
	for k, v in pairs(p1._tabButtons) do
		local isCurrentTab = k == p1.CurrentTab

		v.BackgroundColor3 = isCurrentTab and v4 or v3

		local Label = v:FindFirstChild("Label")
		local AccentBar = v:FindFirstChild("AccentBar")

		if Label then
			Label.TextColor3 = isCurrentTab and v5 or v6
		end

		if AccentBar then
			AccentBar.Visible = isCurrentTab
		end
	end
end
function t._renderGrid(p1) --[[ _renderGrid | Line: 1017 | Upvalues: makeTile (copy) ]]
	for i, v in ipairs(p1.Grid:GetChildren()) do
		if v:IsA("TextButton") and v.Name:sub(1, 5) == "Tile_" then
			v:Destroy()
		end
	end

	table.clear(p1._tileFrames)
	p1.GridTitle.Text = p1:_currentTabLabel()

	local count = 0
	local v1 = nil

	for i, v in ipairs(p1.Products) do
		if v.tab == p1.CurrentTab then
			count = count + 1
			p1._tileFrames[v.id] = makeTile(p1.Grid, count, v, if p1.SelectedProductID == v.id then true else false, function(p12) --[[ Line: 1033 | Upvalues: p1 (copy) ]]
				p1:_selectProduct(p12)
			end)

			if not v1 then
				v1 = v
			end
		end
	end

	local v4 = false

	if p1.SelectedProductID then
		for i, v in ipairs(p1.Products) do
			if v.id == p1.SelectedProductID and v.tab == p1.CurrentTab then
				v4 = true

				break
			end
		end
	end

	if v4 then
		return
	end

	p1.SelectedProductID = v1 and v1.id or nil
	p1:_renderDetail()
	p1:_updateTileSelectionHighlight()
end
function t._updateTileSelectionHighlight(p1) --[[ _updateTileSelectionHighlight | Line: 1054 | Upvalues: v14 (copy), v13 (copy) ]]
	for k, v in pairs(p1._tileFrames) do
		local SelectionStroke = v:FindFirstChild("SelectionStroke")

		if SelectionStroke then
			if k == p1.SelectedProductID then
				SelectionStroke.Color = v14
				SelectionStroke.Thickness = 2

				continue
			end

			SelectionStroke.Color = v13
			SelectionStroke.Thickness = 1
		end
	end
end
function t._currentProduct(p1) --[[ _currentProduct | Line: 1069 ]]
	for i, v in ipairs(p1.Products) do
		if v.id == p1.SelectedProductID then
			return v
		end
	end

	return nil
end
function t._renderDetail(p1) --[[ _renderDetail | Line: 1076 | Upvalues: renderDetail (copy), purchaseProduct (copy) ]]
	renderDetail(p1.Detail, p1:_currentProduct(), function(p1) --[[ Line: 1078 | Upvalues: purchaseProduct (ref) ]]
		purchaseProduct(p1)
	end)
end
function t._selectProduct(p1, p2) --[[ _selectProduct | Line: 1081 ]]
	p1.SelectedProductID = p2
	p1:_updateTileSelectionHighlight()
	p1:_renderDetail()
end
function t._switchTab(p1, p2) --[[ _switchTab | Line: 1087 ]]
	p1.CurrentTab = p2
	p1:_renderSidebar()
	p1:_renderGrid()
end
function t.Refresh(p1) --[[ Refresh | Line: 1093 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), buildProducts (copy) ]]
	if not p1.Gui then
		return
	end

	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	local t = {}
	local GetUnlockedSkins = Remotes:FindFirstChild("GetUnlockedSkins")

	if GetUnlockedSkins then
		local ok, result = pcall(function() --[[ Line: 1101 | Upvalues: GetUnlockedSkins (copy) ]]
			return GetUnlockedSkins:InvokeServer()
		end)

		if ok and type(result) == "table" then
			for i, v in ipairs(result) do
				t[v] = true
			end
		end
	end

	local v1 = LocalPlayer:GetAttribute("_SupporterTier")
	local v2 = 0
	local GetStashInventory = Remotes:FindFirstChild("GetStashInventory")

	if GetStashInventory then
		local ok, result = pcall(function() --[[ Line: 1112 | Upvalues: GetStashInventory (copy) ]]
			return GetStashInventory:InvokeServer()
		end)

		if ok and type(result) == "table" then
			v2 = result.PremiumTier or 0
		end
	end

	local ok, result = pcall(require, ReplicatedStorage:WaitForChild("StashTierConfig", 3))

	if not ok then
		result = nil
	end

	local ok2, result2 = pcall(require, ReplicatedStorage:WaitForChild("SupporterCatalog", 3))

	if not ok2 then
		result2 = nil
	end

	p1.Products = buildProducts({
		ownedSet = t,
		currentSupporterTierKey = v1,
		currentPremiumTier = v2,
		MAX_TIER = result and result.MAX_TIER or 7,
		StashTierConfig = result,
		SupporterCatalog = result2
	})
	p1:_renderSidebar()
	p1:_renderGrid()
end
function t.Open(p1, p2) --[[ Open | Line: 1138 | Upvalues: build (copy), t2 (copy), makeSidebarTab (copy), freezeInput (copy) ]]
	if p1.IsOpen then
		return
	end

	p1.IsOpen = true
	p1.CurrentNPC = p2

	if not p1.Gui then
		local v1, v2, v3, v4, v5, v6, v7 = build()

		p1.Gui = v1
		p1.Panel = v2
		p1.Sidebar = v3
		p1.GridTitle = v4
		p1.Grid = v5
		p1.Detail = v6
		p1.CloseBtn = v7

		for i, v in ipairs(t2) do
			p1._tabButtons[v.id] = makeSidebarTab(p1.Sidebar, i, v, function(p12) --[[ Line: 1153 | Upvalues: p1 (copy) ]]
				p1:_switchTab(p12)
			end)
		end

		v7.MouseButton1Click:Connect(function() --[[ Line: 1157 | Upvalues: p1 (copy) ]]
			p1:Close()
		end)
	end

	p1:Refresh()
	p1.Gui.Enabled = true
	freezeInput()
end
function t.Close(p1) --[[ Close | Line: 1164 | Upvalues: unfreezeInput (copy) ]]
	if not p1.IsOpen then
		return
	end

	p1.IsOpen = false
	p1.CurrentNPC = nil

	if p1.Gui then
		p1.Gui.Enabled = false
	end

	unfreezeInput()
end
function t.Init(p1) --[[ Init | Line: 1172 | Upvalues: ReplicatedStorage (copy), UserInputService (copy) ]]
	if p1._inited then
		return
	end

	p1._inited = true

	local Remotes = ReplicatedStorage:WaitForChild("Remotes")

	Remotes:WaitForChild("OpenPremiumVendor").OnClientEvent:Connect(function(p12) --[[ Line: 1178 | Upvalues: p1 (copy) ]]
		p1:Open(p12)
	end)

	local UnlockedSkinsChanged = Remotes:FindFirstChild("UnlockedSkinsChanged")

	if UnlockedSkinsChanged then
		UnlockedSkinsChanged.OnClientEvent:Connect(function() --[[ Line: 1184 | Upvalues: p1 (copy) ]]
			if not p1.IsOpen then
				return
			end

			p1:Refresh()
		end)
	end

	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 1189 | Upvalues: p1 (copy) ]]
		if p2 or not p1.IsOpen then
			return
		end

		if p12.KeyCode ~= Enum.KeyCode.Q then
			return
		end

		p1:Close()
	end)
	print("[PremiumVendorController v3] initialized")
end

return t