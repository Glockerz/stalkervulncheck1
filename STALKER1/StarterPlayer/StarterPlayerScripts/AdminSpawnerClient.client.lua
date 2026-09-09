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

local function isAdmin(p1) --[[ isAdmin | Line: 31 | Upvalues: t (copy) ]]
	if t[p1.UserId] then
		return true
	end

	local ok, result = pcall(function() --[[ Line: 34 | Upvalues: p1 (copy) ]]
		return p1:GetRankInGroup(9949403)
	end)

	return (if ok then tonumber(result) or 0 else 0) >= 180
end

local LocalPlayer = Players.LocalPlayer
local v1

if t[LocalPlayer.UserId] then
	v1 = true
else
	local ok, result = pcall(function() --[[ Line: 34 | Upvalues: LocalPlayer (copy) ]]
		return LocalPlayer:GetRankInGroup(9949403)
	end)

	v1 = if (if ok then tonumber(result) or 0 else 0) >= 180 then true else false
end

if not v1 then
	return
end

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminSpawnItem = Remotes:WaitForChild("AdminSpawnItem")
local AdminListItems = Remotes:WaitForChild("AdminListItems")
local AdminRunCommand = Remotes:WaitForChild("AdminRunCommand")
local v3 = AdminListItems:InvokeServer() or {}
local v4 = Color3.fromRGB(16, 16, 18)
local v5 = Color3.fromRGB(20, 20, 24)
local v6 = Color3.fromRGB(28, 28, 32)
local v7 = Color3.fromRGB(35, 35, 40)
local v8 = Color3.fromRGB(80, 80, 90)
local v9 = Color3.fromRGB(230, 230, 235)
local v10 = Color3.fromRGB(160, 160, 170)
local v11 = Color3.fromRGB(60, 90, 60)
local v12 = Color3.fromRGB(230, 240, 230)
local v13 = Color3.fromRGB(50, 60, 75)
local v14 = Color3.fromRGB(230, 240, 250)
local v15 = Color3.fromRGB(30, 30, 35)
local v16 = Color3.fromRGB(155, 155, 165)
local v17 = Color3.fromRGB(80, 40, 40)
local v18 = Color3.fromRGB(230, 210, 210)
local AdminSpawner = Instance.new("ScreenGui")

AdminSpawner.Name = "AdminSpawner"
AdminSpawner.ResetOnSpawn = false
AdminSpawner.IgnoreGuiInset = true
AdminSpawner.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
AdminSpawner.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")

Frame.Size = UDim2.new(0, 380, 0, 560)
Frame.Position = UDim2.new(1, -400, 0, 60)
Frame.BackgroundColor3 = v5
Frame.BorderSizePixel = 0
Frame.Visible = false
Frame.Parent = AdminSpawner
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

local UIStroke = Instance.new("UIStroke")

UIStroke.Color = v8
UIStroke.Thickness = 1
UIStroke.Parent = Frame

local TextLabel = Instance.new("TextLabel")

TextLabel.Size = UDim2.new(1, -16, 0, 28)
TextLabel.Position = UDim2.new(0, 8, 0, 8)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "ADMIN PANEL  (F8 to toggle)"
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 14
TextLabel.TextColor3 = v9
TextLabel.Parent = Frame

local TextButton = Instance.new("TextButton")

TextButton.Size = UDim2.new(0, 28, 0, 24)
TextButton.Position = UDim2.new(1, -36, 0, 10)
TextButton.BackgroundColor3 = v17
TextButton.BorderSizePixel = 0
TextButton.Text = "X"
TextButton.Font = Enum.Font.GothamBold
TextButton.TextSize = 12
TextButton.TextColor3 = v18
TextButton.Parent = Frame
Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 4)

local Frame2 = Instance.new("Frame")

Frame2.Size = UDim2.new(1, -16, 0, 32)
Frame2.Position = UDim2.new(0, 8, 0, 44)
Frame2.BackgroundTransparency = 1
Frame2.Parent = Frame

local v19 = "items"
local v20 = nil
local v21 = nil

local function styleTab(p1, p2) --[[ styleTab | Line: 119 | Upvalues: v13 (copy), v15 (copy), v14 (copy), v16 (copy) ]]
	p1.BackgroundColor3 = p2 and v13 or v15
	p1.TextColor3 = p2 and v14 or v16
end

local function setTab(p1) --[[ setTab | Line: 124 | Upvalues: v19 (ref), v20 (ref), v13 (copy), v15 (copy), v14 (copy), v16 (copy), v21 (ref) ]]
	v19 = p1

	local v1 = v20
	local v2 = p1 == "items"

	v1.BackgroundColor3 = v2 and v13 or v15
	v1.TextColor3 = v2 and v14 or v16

	local v5 = v21
	local v6 = p1 == "cmds"

	v5.BackgroundColor3 = v6 and v13 or v15
	v5.TextColor3 = v6 and v14 or v16

	if not _G.__admin_setPane then
		return
	end

	_G.__admin_setPane(p1)
end

v20 = Instance.new("TextButton")
v20.Size = UDim2.new(0.5, -2, 1, 0)
v20.Position = UDim2.new(0, 0, 0, 0)
v20.BorderSizePixel = 0
v20.Text = "ITEMS"
v20.Font = Enum.Font.GothamBold
v20.TextSize = 12
v20.Parent = Frame2
Instance.new("UICorner", v20).CornerRadius = UDim.new(0, 4)

local v22 = v20

v22.BackgroundColor3 = v13 or v15
v22.TextColor3 = v14 or v16
v20.MouseButton1Click:Connect(function() --[[ Line: 142 | Upvalues: v19 (ref), v20 (ref), v13 (copy), v15 (copy), v14 (copy), v16 (copy), v21 (ref) ]]
	v19 = "items"

	local v1 = v20

	v1.BackgroundColor3 = v13 or v15
	v1.TextColor3 = v14 or v16

	local v4 = v21

	v4.BackgroundColor3 = v15
	v4.TextColor3 = v16

	if not _G.__admin_setPane then
		return
	end

	_G.__admin_setPane("items")
end)
v21 = Instance.new("TextButton")
v21.Size = UDim2.new(0.5, -2, 1, 0)
v21.Position = UDim2.new(0.5, 2, 0, 0)
v21.BorderSizePixel = 0
v21.Text = "COMMANDS"
v21.Font = Enum.Font.GothamBold
v21.TextSize = 12
v21.Parent = Frame2
Instance.new("UICorner", v21).CornerRadius = UDim.new(0, 4)

local v25 = v21

v25.BackgroundColor3 = v15
v25.TextColor3 = v16
v21.MouseButton1Click:Connect(function() --[[ Line: 154 | Upvalues: v19 (ref), v20 (ref), v15 (copy), v16 (copy), v21 (ref), v13 (copy), v14 (copy) ]]
	v19 = "cmds"

	local v1 = v20

	v1.BackgroundColor3 = v15
	v1.TextColor3 = v16

	local v2 = v21

	v2.BackgroundColor3 = v13 or v15
	v2.TextColor3 = v14 or v16

	if not _G.__admin_setPane then
		return
	end

	_G.__admin_setPane("cmds")
end)

local Frame3 = Instance.new("Frame")

Frame3.Size = UDim2.new(1, -16, 1, -92)
Frame3.Position = UDim2.new(0, 8, 0, 84)
Frame3.BackgroundTransparency = 1
Frame3.Parent = Frame

local Frame4 = Instance.new("Frame")

Frame4.Size = UDim2.fromScale(1, 1)
Frame4.BackgroundTransparency = 1
Frame4.Parent = Frame3

local TextBox = Instance.new("TextBox")

TextBox.Size = UDim2.new(1, 0, 0, 30)
TextBox.Position = UDim2.new(0, 0, 0, 0)
TextBox.BackgroundColor3 = v7
TextBox.BorderSizePixel = 0
TextBox.PlaceholderText = "Search items..."
TextBox.Text = ""
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 13
TextBox.TextColor3 = v9
TextBox.PlaceholderColor3 = v10
TextBox.ClearTextOnFocus = false
TextBox.Parent = Frame4
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 4)

local UIPadding = Instance.new("UIPadding")

UIPadding.PaddingLeft = UDim.new(0, 8)
UIPadding.Parent = TextBox

local v26 = "inventory"
local Frame5 = Instance.new("Frame")

Frame5.Size = UDim2.new(1, 0, 0, 28)
Frame5.Position = UDim2.new(0, 0, 0, 38)
Frame5.BackgroundTransparency = 1
Frame5.Parent = Frame4

local function makeModeBtn(p1, p2, p3) --[[ makeModeBtn | Line: 194 | Upvalues: Frame5 (copy), v26 (ref), v11 (copy), v12 (copy), v10 (copy) ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(0.5, -2, 1, 0)
	TextButton.Position = UDim2.new(p3, if p3 == 0 then 0 else 2, 0, 0)
	TextButton.BorderSizePixel = 0
	TextButton.Text = p1
	TextButton.Font = Enum.Font.GothamBold
	TextButton.TextSize = 12
	TextButton.Parent = Frame5
	Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 4)
	TextButton:SetAttribute("Mode", p2)
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 205 | Upvalues: v26 (ref), p2 (copy), Frame5 (ref), v11 (ref), v12 (ref), v10 (ref) ]]
		v26 = p2

		for i, v in ipairs(Frame5:GetChildren()) do
			if v:IsA("TextButton") then
				local v1 = v:GetAttribute("Mode") == p2

				v.BackgroundColor3 = v1 and v11 or Color3.fromRGB(40, 40, 45)
				v.TextColor3 = v1 and v12 or v10
			end
		end
	end)

	return TextButton
end

local v27 = makeModeBtn("INVENTORY", "inventory", 0)
local v28 = makeModeBtn("WORLD DROP", "world", 0.5)

v27.BackgroundColor3 = v11
v27.TextColor3 = v12
v28.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
v28.TextColor3 = v10

local ScrollingFrame = Instance.new("ScrollingFrame")

ScrollingFrame.Size = UDim2.new(1, 0, 1, -78)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 74)
ScrollingFrame.BackgroundColor3 = v4
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarImageColor3 = v8
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.Parent = Frame4
Instance.new("UICorner", ScrollingFrame).CornerRadius = UDim.new(0, 4)

local UIListLayout = Instance.new("UIListLayout")

UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollingFrame

local UIPadding2 = Instance.new("UIPadding")

UIPadding2.PaddingTop = UDim.new(0, 4)
UIPadding2.PaddingBottom = UDim.new(0, 4)
UIPadding2.PaddingLeft = UDim.new(0, 4)
UIPadding2.PaddingRight = UDim.new(0, 4)
UIPadding2.Parent = ScrollingFrame

local t2 = {
	Primary = Color3.fromRGB(80, 60, 30),
	Sidearm = Color3.fromRGB(80, 60, 30),
	Ammo = Color3.fromRGB(70, 60, 30),
	AmmoPack = Color3.fromRGB(70, 60, 30),
	BodyGear = Color3.fromRGB(40, 60, 35),
	HeadGear = Color3.fromRGB(35, 45, 60),
	BeltGear = Color3.fromRGB(45, 45, 30),
	Backpack = Color3.fromRGB(50, 35, 30),
	Uniform = Color3.fromRGB(50, 40, 50),
	Medical = Color3.fromRGB(35, 60, 45),
	FoodAndDrink = Color3.fromRGB(45, 55, 30),
	FaceWear = Color3.fromRGB(40, 40, 40),
	EyeWear = Color3.fromRGB(40, 40, 40),
	NightOptical = Color3.fromRGB(30, 40, 50),
	Vial = Color3.fromRGB(45, 35, 50),
	Injector = Color3.fromRGB(45, 40, 60),
	Currency = Color3.fromRGB(60, 55, 30),
	HighValue = Color3.fromRGB(55, 35, 60),
	General = Color3.fromRGB(40, 40, 45)
}

local function makeRow(p1, p2) --[[ makeRow | Line: 255 | Upvalues: t2 (copy), ScrollingFrame (copy), v10 (copy), v9 (copy), v11 (copy), v12 (copy), AdminSpawnItem (copy), v26 (ref) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, -8, 0, 32)
	Frame.BackgroundColor3 = t2[p1.ItemType] or Color3.fromRGB(40, 40, 45)
	Frame.BorderSizePixel = 0
	Frame.LayoutOrder = p2
	Frame.Parent = ScrollingFrame
	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 3)

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(0, 90, 1, 0)
	TextLabel.Position = UDim2.new(0, 6, 0, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = p1.ItemType
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Font = Enum.Font.GothamMedium
	TextLabel.TextSize = 10
	TextLabel.TextColor3 = v10
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, -190, 1, 0)
	TextLabel2.Position = UDim2.new(0, 100, 0, 0)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Text = p1.Name
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Font = Enum.Font.Gotham
	TextLabel2.TextSize = 12
	TextLabel2.TextColor3 = v9
	TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel2.Parent = Frame

	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(0, 80, 0, 24)
	TextButton.Position = UDim2.new(1, -86, 0, 4)
	TextButton.BackgroundColor3 = v11
	TextButton.BorderSizePixel = 0
	TextButton.Text = "SPAWN"
	TextButton.Font = Enum.Font.GothamBold
	TextButton.TextSize = 11
	TextButton.TextColor3 = v12
	TextButton.Parent = Frame
	Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 3)
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 285 | Upvalues: AdminSpawnItem (ref), p1 (copy), v26 (ref) ]]
		AdminSpawnItem:FireServer(p1.ID, v26)
	end)

	return Frame
end

local t3 = {}

for i, v in ipairs(v3) do
	table.insert(t3, {
		row = makeRow(v, i),
		item = v
	})
end

local function applyFilter() --[[ applyFilter | Line: 293 | Upvalues: TextBox (copy), t3 (copy) ]]
	local v1 = string.lower(TextBox.Text)

	for i, v in ipairs(t3) do
		local v2 = if v1 == "" then true else string.find(string.lower(v.item.Name), v1, 1, true) or (string.find(string.lower(v.item.ID), v1, 1, true) or string.find(string.lower(v.item.ItemType), v1, 1, true))

		v.row.Visible = if v2 == nil then false else v2 ~= false
	end
end

TextBox:GetPropertyChangedSignal("Text"):Connect(applyFilter)

local Frame6 = Instance.new("Frame")

Frame6.Size = UDim2.fromScale(1, 1)
Frame6.BackgroundTransparency = 1
Frame6.Visible = false
Frame6.Parent = Frame3

local ScrollingFrame2 = Instance.new("ScrollingFrame")

ScrollingFrame2.Size = UDim2.new(1, 0, 1, -46)
ScrollingFrame2.Position = UDim2.new(0, 0, 0, 0)
ScrollingFrame2.BackgroundColor3 = v4
ScrollingFrame2.BorderSizePixel = 0
ScrollingFrame2.ScrollBarThickness = 6
ScrollingFrame2.ScrollBarImageColor3 = v8
ScrollingFrame2.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame2.Parent = Frame6
Instance.new("UICorner", ScrollingFrame2).CornerRadius = UDim.new(0, 4)

local UIListLayout2 = Instance.new("UIListLayout")

UIListLayout2.Padding = UDim.new(0, 4)
UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout2.Parent = ScrollingFrame2

local UIPadding3 = Instance.new("UIPadding")

UIPadding3.PaddingTop = UDim.new(0, 6)
UIPadding3.PaddingBottom = UDim.new(0, 6)
UIPadding3.PaddingLeft = UDim.new(0, 6)
UIPadding3.PaddingRight = UDim.new(0, 6)
UIPadding3.Parent = ScrollingFrame2

local function makeSectionHeader(p1, p2) --[[ makeSectionHeader | Line: 332 | Upvalues: ScrollingFrame2 (copy) ]]
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 20)
	TextLabel.LayoutOrder = p2
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = p1
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.TextSize = 11
	TextLabel.TextColor3 = Color3.fromRGB(180, 175, 130)
	TextLabel.Parent = ScrollingFrame2
end

local function makeCmdRow(p1) --[[ makeCmdRow | Line: 345 | Upvalues: ScrollingFrame2 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 30)
	Frame.LayoutOrder = p1
	Frame.BackgroundTransparency = 1
	Frame.Parent = ScrollingFrame2

	return Frame
end

local function makeButton(p1, p2, p3, p4, p5, p6, p7) --[[ makeButton | Line: 354 | Upvalues: v6 (copy), v9 (copy) ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(p3, p4, 1, 0)
	TextButton.Position = UDim2.new(p5, if p5 == 0 then 0 else 4, 0, 0)
	TextButton.BackgroundColor3 = if p6 then p6 else v6
	TextButton.BorderSizePixel = 0
	TextButton.Text = p2
	TextButton.Font = Enum.Font.GothamBold
	TextButton.TextSize = 11
	TextButton.TextColor3 = v9
	TextButton.Parent = p1
	Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 3)
	TextButton.MouseButton1Click:Connect(p7)

	return TextButton
end

local function run(p1, ...) --[[ run | Line: 370 | Upvalues: AdminRunCommand (copy) ]]
	AdminRunCommand:FireServer(p1, { ... })
end

local count = 0

local function nextOrder() --[[ nextOrder | Line: 375 | Upvalues: count (ref) ]]
	count = count + 1

	return count
end

local function makeDropdown(p1, p2, p3) --[[ makeDropdown | Line: 383 | Upvalues: makeSectionHeader (copy), count (ref), ScrollingFrame2 (copy), v7 (copy), v10 (copy), v11 (copy), v12 (copy), v4 (copy), v8 (copy), v6 (copy), v9 (copy) ]]
	count = count + 1
	makeSectionHeader(p1, count)
	count = count + 1

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 30)
	Frame.LayoutOrder = count
	Frame.BackgroundTransparency = 1
	Frame.Parent = ScrollingFrame2

	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(0.72, -3, 1, 0)
	TextButton.BackgroundColor3 = v7
	TextButton.BorderSizePixel = 0
	TextButton.Font = Enum.Font.Gotham
	TextButton.TextSize = 11
	TextButton.TextColor3 = v10
	TextButton.TextXAlignment = Enum.TextXAlignment.Left
	TextButton.TextTruncate = Enum.TextTruncate.AtEnd
	TextButton.Text = ("  select... (%d)"):format(#p2)
	TextButton.Parent = Frame
	Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 3)

	local TextButton2 = Instance.new("TextButton")

	TextButton2.Size = UDim2.new(0.28, -3, 1, 0)
	TextButton2.Position = UDim2.new(0.72, 4, 0, 0)
	TextButton2.BackgroundColor3 = v11
	TextButton2.BorderSizePixel = 0
	TextButton2.Text = "GRANT"
	TextButton2.Font = Enum.Font.GothamBold
	TextButton2.TextSize = 11
	TextButton2.TextColor3 = v12
	TextButton2.Parent = Frame
	Instance.new("UICorner", TextButton2).CornerRadius = UDim.new(0, 3)

	local ScrollingFrame = Instance.new("ScrollingFrame")

	ScrollingFrame.Size = UDim2.new(1, 0, 0, 150)
	count = count + 1
	ScrollingFrame.LayoutOrder = count
	ScrollingFrame.BackgroundColor3 = v4
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.ScrollBarThickness = 5
	ScrollingFrame.ScrollBarImageColor3 = v8
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ScrollingFrame.Visible = false
	ScrollingFrame.Parent = ScrollingFrame2
	Instance.new("UICorner", ScrollingFrame).CornerRadius = UDim.new(0, 3)

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.Padding = UDim.new(0, 2)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = ScrollingFrame

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingTop = UDim.new(0, 3)
	UIPadding.PaddingBottom = UDim.new(0, 3)
	UIPadding.PaddingLeft = UDim.new(0, 3)
	UIPadding.PaddingRight = UDim.new(0, 3)
	UIPadding.Parent = ScrollingFrame

	local v3 = nil

	for i, v in ipairs(p2) do
		local TextButton3 = Instance.new("TextButton")

		TextButton3.Size = UDim2.new(1, 0, 0, 22)
		TextButton3.LayoutOrder = i
		TextButton3.BackgroundColor3 = v6
		TextButton3.BorderSizePixel = 0
		TextButton3.Font = Enum.Font.Gotham
		TextButton3.TextSize = 11
		TextButton3.TextColor3 = v9
		TextButton3.TextXAlignment = Enum.TextXAlignment.Left
		TextButton3.TextTruncate = Enum.TextTruncate.AtEnd
		TextButton3.Text = "  " .. v.text
		TextButton3.Parent = ScrollingFrame
		Instance.new("UICorner", TextButton3).CornerRadius = UDim.new(0, 2)
		TextButton3.MouseButton1Click:Connect(function() --[[ Line: 447 | Upvalues: v3 (ref), v (copy), TextButton (copy), v9 (ref), ScrollingFrame (copy) ]]
			v3 = v.value
			TextButton.Text = "  " .. v.text
			TextButton.TextColor3 = v9
			ScrollingFrame.Visible = false
		end)
	end

	TextButton.MouseButton1Click:Connect(function() --[[ Line: 455 | Upvalues: ScrollingFrame (copy) ]]
		ScrollingFrame.Visible = not ScrollingFrame.Visible
	end)
	TextButton2.MouseButton1Click:Connect(function() --[[ Line: 458 | Upvalues: v3 (ref), ScrollingFrame (copy), p3 (copy) ]]
		if v3 then
			p3(v3)
		else
			ScrollingFrame.Visible = true
		end
	end)
end

count = count + 1
makeSectionHeader("SUPPORTER TIERS", count)
count = count + 1

local v29 = count
local Frame7 = Instance.new("Frame")

Frame7.Size = UDim2.new(1, 0, 0, 30)
Frame7.LayoutOrder = v29
Frame7.BackgroundTransparency = 1
Frame7.Parent = ScrollingFrame2
Frame7.Size = UDim2.new(1, 0, 0, 28)

local TextBox2 = Instance.new("TextBox")

TextBox2.Size = UDim2.new(1, 0, 1, 0)
TextBox2.BackgroundColor3 = v7
TextBox2.BorderSizePixel = 0
TextBox2.PlaceholderText = "Target player (empty = self) \226\128\148 applies to grant/pack/skin"
TextBox2.Text = ""
TextBox2.Font = Enum.Font.Gotham
TextBox2.TextSize = 12
TextBox2.TextColor3 = v9
TextBox2.PlaceholderColor3 = v10
TextBox2.ClearTextOnFocus = false
TextBox2.Parent = Frame7
Instance.new("UICorner", TextBox2).CornerRadius = UDim.new(0, 3)

local UIPadding4 = Instance.new("UIPadding")

UIPadding4.PaddingLeft = UDim.new(0, 8)
UIPadding4.Parent = TextBox2

local function runGrant(p1) --[[ runGrant | Line: 484 | Upvalues: TextBox2 (copy), run (copy) ]]
	if TextBox2.Text == "" then
		run("grant", p1)
	else
		run("grant", p1, TextBox2.Text)
	end
end

count = count + 1

local v30 = count
local Frame8 = Instance.new("Frame")

Frame8.Size = UDim2.new(1, 0, 0, 30)
Frame8.LayoutOrder = v30
Frame8.BackgroundTransparency = 1
Frame8.Parent = ScrollingFrame2
makeButton(Frame8, "GRANT DRIFTER", 0.3333333333333333, -3, 0, Color3.fromRGB(50, 60, 75), function() --[[ Line: 493 | Upvalues: TextBox2 (copy), run (copy) ]]
	if TextBox2.Text == "" then
		run("grant", "drifter")
	else
		run("grant", "drifter", TextBox2.Text)
	end
end)
makeButton(Frame8, "GRANT VETERAN", 0.3333333333333333, -3, 0.3333333333333333, Color3.fromRGB(50, 75, 55), function() --[[ Line: 494 | Upvalues: TextBox2 (copy), run (copy) ]]
	if TextBox2.Text == "" then
		run("grant", "veteran")
	else
		run("grant", "veteran", TextBox2.Text)
	end
end)
makeButton(Frame8, "GRANT MASTER", 0.3333333333333333, -3, 0.6666666666666666, Color3.fromRGB(80, 65, 30), function() --[[ Line: 495 | Upvalues: TextBox2 (copy), run (copy) ]]
	if TextBox2.Text == "" then
		run("grant", "master")
	else
		run("grant", "master", TextBox2.Text)
	end
end)
count = count + 1

local v31 = count
local Frame9 = Instance.new("Frame")

Frame9.Size = UDim2.new(1, 0, 0, 30)
Frame9.LayoutOrder = v31
Frame9.BackgroundTransparency = 1
Frame9.Parent = ScrollingFrame2
makeButton(Frame9, "RESET TIER ATTR", 0.5, -3, 0, Color3.fromRGB(60, 50, 35), function() --[[ Line: 498 | Upvalues: run (copy) ]]
	run("reset")
end)
makeButton(Frame9, "CLEAR SKINS DS", 0.5, -3, 0.5, Color3.fromRGB(65, 45, 45), function() --[[ Line: 499 | Upvalues: run (copy) ]]
	run("clearskins")
end)

local function safeRequire(p1) --[[ safeRequire | Line: 504 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 505 | Upvalues: ReplicatedStorage (ref), p1 (copy) ]]
		return require(ReplicatedStorage:WaitForChild(p1, 5))
	end)

	return if ok and result then result else nil
end

local v32 = "SkinCatalog"
local ok, result = pcall(function() --[[ Line: 505 | Upvalues: ReplicatedStorage (copy), v32 (copy) ]]
	return require(ReplicatedStorage:WaitForChild(v32, 5))
end)
local v33 = if ok and result then result else nil
local v34 = "SupporterCatalog"
local ok2, result2 = pcall(function() --[[ Line: 505 | Upvalues: ReplicatedStorage (copy), v34 (copy) ]]
	return require(ReplicatedStorage:WaitForChild(v34, 5))
end)
local v35 = if ok2 and result2 then result2 else nil
local v36 = "ItemDatabase"
local ok3, result3 = pcall(function() --[[ Line: 505 | Upvalues: ReplicatedStorage (copy), v36 (copy) ]]
	return require(ReplicatedStorage:WaitForChild(v36, 5))
end)
local v37 = ok3 and result3 or nil

local function prettyName(p1) --[[ prettyName | Line: 512 | Upvalues: v37 (copy) ]]
	local v1 = v37

	if v1 then
		v1 = rawget(v37, p1)
	end

	local v3 = if v1 then v1.Name else v1

	if v3 and v3 ~= p1 then
		return v3 .. "  \194\183  " .. p1
	end

	return p1
end

local t4 = {}
local tbl = {}

if v33 and v33.Skins then
	for k in pairs(v33.Skins) do
		tbl[k] = "catalog"
	end
end

if v35 and v35.Tiers then
	for k, v in pairs(v35.Tiers) do
		local v38 = ipairs

		for v40, v41 in v38(v.ExclusiveSkins or {}) do
			if not tbl[v41] then
				tbl[v41] = "tier"
			end
		end
	end
end

for k, v in pairs(tbl) do
	local v42
	local t5 = {
		value = k
	}
	local v44 = if v37 then rawget(v37, k) else v37
	local v45 = if v44 then v44.Name else v44

	v42 = if v45 and v45 ~= k then v45 .. "  \194\183  " .. k else k
	t5.text = v42 .. (if v == "tier" then "   [tier-only]" else "")
	t4[#t4 + 1] = t5
end

table.sort(t4, function(p1, p2) --[[ Line: 541 ]]
	return p1.text < p2.text
end)

local t5 = {}

if v33 and v33.Packs then
	for k, v in pairs(v33.Packs) do
		local t6 = {
			value = k
		}

		t6.text = ("%s  (%d)"):format(v.DisplayName or k, #(v.Skins or {}))
		t5[#t5 + 1] = t6
	end

	table.sort(t5, function(p1, p2) --[[ Line: 552 ]]
		return p1.text < p2.text
	end)
end

local function withTarget(p1) --[[ withTarget | Line: 555 | Upvalues: TextBox2 (copy), run (copy) ]]
	return function(p13) --[[ Line: 556 | Upvalues: TextBox2 (ref), run (ref), p1 (copy) ]]
		if TextBox2.Text == "" then
			run(p1, p13)
		else
			run(p1, p13, TextBox2.Text)
		end
	end
end

if #t4 > 0 then
	local v51 = "skin"

	makeDropdown(("GRANT SKIN  (%d)"):format(#t4), t4, function(p13) --[[ Line: 556 | Upvalues: TextBox2 (copy), run (copy), v51 (copy) ]]
		if TextBox2.Text == "" then
			run(v51, p13)
		else
			run(v51, p13, TextBox2.Text)
		end
	end)
end

if #t5 > 0 then
	local v52 = "pack"

	makeDropdown(("GRANT SKIN PACK / BUNDLE  (%d)"):format(#t5), t5, function(p13) --[[ Line: 556 | Upvalues: TextBox2 (copy), run (copy), v52 (copy) ]]
		if TextBox2.Text == "" then
			run(v52, p13)
		else
			run(v52, p13, TextBox2.Text)
		end
	end)
end

count = count + 1
makeSectionHeader("ROUBLES", count)
count = count + 1

local v53 = count
local Frame10 = Instance.new("Frame")

Frame10.Size = UDim2.new(1, 0, 0, 30)
Frame10.LayoutOrder = v53
Frame10.BackgroundTransparency = 1
Frame10.Parent = ScrollingFrame2
makeButton(Frame10, "+10K", 0.25, -3, 0, v11, function() --[[ Line: 575 | Upvalues: run (copy) ]]
	run("addroubles", "10000")
end)
makeButton(Frame10, "+100K", 0.25, -3, 0.25, v11, function() --[[ Line: 576 | Upvalues: run (copy) ]]
	run("addroubles", "100000")
end)
makeButton(Frame10, "+1M", 0.25, -3, 0.5, v11, function() --[[ Line: 577 | Upvalues: run (copy) ]]
	run("addroubles", "1000000")
end)
makeButton(Frame10, "SET 0", 0.25, -3, 0.75, v17, function() --[[ Line: 578 | Upvalues: run (copy) ]]
	run("roubles", "0")
end)
count = count + 1
makeSectionHeader("STASH PREMIUM TIER", count)
count = count + 1

local v54 = count
local Frame11 = Instance.new("Frame")

Frame11.Size = UDim2.new(1, 0, 0, 30)
Frame11.LayoutOrder = v54
Frame11.BackgroundTransparency = 1
Frame11.Parent = ScrollingFrame2

local v55 = Frame11

for i = 0, 3 do
	makeButton(v55, "T" .. tostring(i), 0.25, -3, i / 4, v6, function() --[[ Line: 585 | Upvalues: run (copy), i (copy) ]]
		run("stash", (tostring(i)))
	end)
end

count = count + 1

local v56 = count
local Frame12 = Instance.new("Frame")

Frame12.Size = UDim2.new(1, 0, 0, 30)
Frame12.LayoutOrder = v56
Frame12.BackgroundTransparency = 1
Frame12.Parent = ScrollingFrame2

local v57 = Frame12

for j = 4, 7 do
	makeButton(v57, "T" .. tostring(j), 0.25, -3, (j - 4) / 4, v6, function() --[[ Line: 590 | Upvalues: run (copy), j (copy) ]]
		run("stash", (tostring(j)))
	end)
end

count = count + 1
makeSectionHeader("CHARACTER", count)
count = count + 1

local v58 = count
local Frame13 = Instance.new("Frame")

Frame13.Size = UDim2.new(1, 0, 0, 30)
Frame13.LayoutOrder = v58
Frame13.BackgroundTransparency = 1
Frame13.Parent = ScrollingFrame2
makeButton(Frame13, "HEAL", 0.5, -3, 0, v11, function() --[[ Line: 596 | Upvalues: run (copy) ]]
	run("heal")
end)
makeButton(Frame13, "GOD TOGGLE", 0.5, -3, 0.5, Color3.fromRGB(80, 65, 30), function() --[[ Line: 597 | Upvalues: run (copy) ]]
	run("god")
end)
count = count + 1
makeSectionHeader("MOVE (TP TO / BRING)", count)
count = count + 1

local v59 = count
local Frame14 = Instance.new("Frame")

Frame14.Size = UDim2.new(1, 0, 0, 30)
Frame14.LayoutOrder = v59
Frame14.BackgroundTransparency = 1
Frame14.Parent = ScrollingFrame2

local v60 = Frame14

v60.Size = UDim2.new(1, 0, 0, 32)

local TextBox3 = Instance.new("TextBox")

TextBox3.Size = UDim2.new(0.5, -6, 1, 0)
TextBox3.BackgroundColor3 = v7
TextBox3.BorderSizePixel = 0
TextBox3.PlaceholderText = "Player name"
TextBox3.Text = ""
TextBox3.Font = Enum.Font.Gotham
TextBox3.TextSize = 12
TextBox3.TextColor3 = v9
TextBox3.PlaceholderColor3 = v10
TextBox3.ClearTextOnFocus = false
TextBox3.Parent = v60
Instance.new("UICorner", TextBox3).CornerRadius = UDim.new(0, 3)

local UIPadding5 = Instance.new("UIPadding")

UIPadding5.PaddingLeft = UDim.new(0, 8)
UIPadding5.Parent = TextBox3
makeButton(v60, "TP TO", 0.25, -3, 0.5, Color3.fromRGB(50, 65, 75), function() --[[ Line: 615 | Upvalues: TextBox3 (copy), run (copy) ]]
	if TextBox3.Text == "" then
		return
	end

	run("tp", TextBox3.Text)
end)
makeButton(v60, "BRING", 0.25, -3, 0.75, Color3.fromRGB(75, 65, 50), function() --[[ Line: 618 | Upvalues: TextBox3 (copy), run (copy) ]]
	if TextBox3.Text == "" then
		return
	end

	run("bring", TextBox3.Text)
end)
count = count + 1
makeSectionHeader("TIME OF DAY", count)
count = count + 1

local v61 = count
local Frame15 = Instance.new("Frame")

Frame15.Size = UDim2.new(1, 0, 0, 30)
Frame15.LayoutOrder = v61
Frame15.BackgroundTransparency = 1
Frame15.Parent = ScrollingFrame2
makeButton(Frame15, "DAWN 6", 0.25, -3, 0, Color3.fromRGB(72, 62, 42), function() --[[ Line: 625 | Upvalues: run (copy) ]]
	run("time", "6")
end)
makeButton(Frame15, "NOON 12", 0.25, -3, 0.25, Color3.fromRGB(78, 72, 46), function() --[[ Line: 626 | Upvalues: run (copy) ]]
	run("time", "12")
end)
makeButton(Frame15, "DUSK 19", 0.25, -3, 0.5, Color3.fromRGB(72, 50, 40), function() --[[ Line: 627 | Upvalues: run (copy) ]]
	run("time", "19")
end)
makeButton(Frame15, "NIGHT 0", 0.25, -3, 0.75, Color3.fromRGB(40, 46, 66), function() --[[ Line: 628 | Upvalues: run (copy) ]]
	run("time", "0")
end)
count = count + 1

local v62 = count
local Frame16 = Instance.new("Frame")

Frame16.Size = UDim2.new(1, 0, 0, 30)
Frame16.LayoutOrder = v62
Frame16.BackgroundTransparency = 1
Frame16.Parent = ScrollingFrame2
makeButton(Frame16, "PAUSE TIME", 0.5, -3, 0, v6, function() --[[ Line: 630 | Upvalues: run (copy) ]]
	run("time", "pause")
end)
makeButton(Frame16, "RESUME TIME", 0.5, -3, 0.5, v6, function() --[[ Line: 631 | Upvalues: run (copy) ]]
	run("time", "resume")
end)
count = count + 1
makeSectionHeader("STASH BARTER TIER (wipe-bound)", count)
count = count + 1

local v63 = count
local Frame17 = Instance.new("Frame")

Frame17.Size = UDim2.new(1, 0, 0, 30)
Frame17.LayoutOrder = v63
Frame17.BackgroundTransparency = 1
Frame17.Parent = ScrollingFrame2
makeButton(Frame17, "BARTER -1", 0.3333333333333333, -3, 0, v6, function() --[[ Line: 635 | Upvalues: run (copy) ]]
	run("barter", "-")
end)
makeButton(Frame17, "BARTER +1", 0.3333333333333333, -3, 0.3333333333333333, v6, function() --[[ Line: 636 | Upvalues: run (copy) ]]
	run("barter", "+")
end)
makeButton(Frame17, "RESET POOL", 0.3333333333333333, -3, 0.6666666666666666, Color3.fromRGB(65, 45, 45), function() --[[ Line: 637 | Upvalues: run (copy) ]]
	run("barter", "reset")
end)
count = count + 1
makeSectionHeader("TESTING", count)
count = count + 1

local v64 = count
local Frame18 = Instance.new("Frame")

Frame18.Size = UDim2.new(1, 0, 0, 30)
Frame18.LayoutOrder = v64
Frame18.BackgroundTransparency = 1
Frame18.Parent = ScrollingFrame2
makeButton(Frame18, "RESET TUTORIAL", 0.3333333333333333, -3, 0, Color3.fromRGB(65, 45, 45), function() --[[ Line: 641 | Upvalues: run (copy) ]]
	run("tutorial", "reset")
end)
makeButton(Frame18, "SPAWN FLESH", 0.3333333333333333, -3, 0.3333333333333333, Color3.fromRGB(72, 44, 44), function() --[[ Line: 642 | Upvalues: run (copy) ]]
	run("mutant", "Flesh")
end)
makeButton(Frame18, "WHERE AM I", 0.3333333333333333, -3, 0.6666666666666666, Color3.fromRGB(50, 65, 75), function() --[[ Line: 643 | Upvalues: run (copy) ]]
	run("where")
end)
count = count + 1

local v65 = count
local Frame19 = Instance.new("Frame")

Frame19.Size = UDim2.new(1, 0, 0, 30)
Frame19.LayoutOrder = v65
Frame19.BackgroundTransparency = 1
Frame19.Parent = ScrollingFrame2
makeButton(Frame19, "ROLL DAILY", 0.5, -3, 0, Color3.fromRGB(50, 60, 75), function() --[[ Line: 645 | Upvalues: run (copy) ]]
	run("daily", "roll")
end)
makeButton(Frame19, "REFIRE DAILY", 0.5, -3, 0.5, Color3.fromRGB(50, 60, 75), function() --[[ Line: 646 | Upvalues: run (copy) ]]
	run("daily", "refire")
end)
count = count + 1

local v66 = count
local Frame20 = Instance.new("Frame")

Frame20.Size = UDim2.new(1, 0, 0, 30)
Frame20.LayoutOrder = v66
Frame20.BackgroundTransparency = 1
Frame20.Parent = ScrollingFrame2
makeButton(Frame20, "TEST SUPPORTER LOG", 0.6, -3, 0, Color3.fromRGB(55, 70, 55), function() --[[ Line: 648 | Upvalues: run (copy) ]]
	run("supporterlog", "test")
end)
makeButton(Frame20, "RESET ANNOUNCE", 0.4, -3, 0.6, Color3.fromRGB(65, 45, 45), function() --[[ Line: 649 | Upvalues: run (copy) ]]
	run("supporterlog", "reset")
end)
count = count + 1

local v67 = count
local Frame21 = Instance.new("Frame")

Frame21.Size = UDim2.new(1, 0, 0, 30)
Frame21.LayoutOrder = v67
Frame21.BackgroundTransparency = 1
Frame21.Parent = ScrollingFrame2
makeButton(Frame21, "TEST PDA BROADCAST", 1, -3, 0, Color3.fromRGB(55, 70, 55), function() --[[ Line: 651 | Upvalues: run (copy) ]]
	run("pdatest")
end)
count = count + 1
makeSectionHeader("CUSTOM (/help for list)", count)
count = count + 1

local v68 = count
local Frame22 = Instance.new("Frame")

Frame22.Size = UDim2.new(1, 0, 0, 30)
Frame22.LayoutOrder = v68
Frame22.BackgroundTransparency = 1
Frame22.Parent = ScrollingFrame2
Frame22.Size = UDim2.new(1, 0, 0, 32)

local TextBox4 = Instance.new("TextBox")

TextBox4.Size = UDim2.new(0.7, -6, 1, 0)
TextBox4.BackgroundColor3 = v7
TextBox4.BorderSizePixel = 0
TextBox4.PlaceholderText = "time speed 60 | barter 4 | mutant Flesh | mapcapture begin | wipe 60"
TextBox4.Text = ""
TextBox4.Font = Enum.Font.Gotham
TextBox4.TextSize = 12
TextBox4.TextColor3 = v9
TextBox4.PlaceholderColor3 = v10
TextBox4.ClearTextOnFocus = false
TextBox4.Parent = Frame22
Instance.new("UICorner", TextBox4).CornerRadius = UDim.new(0, 3)

local UIPadding6 = Instance.new("UIPadding")

UIPadding6.PaddingLeft = UDim.new(0, 8)
UIPadding6.Parent = TextBox4
makeButton(Frame22, "RUN", 0.3, -3, 0.7, v11, function() --[[ Line: 668 | Upvalues: TextBox4 (copy), AdminRunCommand (copy) ]]
	local Text = TextBox4.Text

	if Text == "" then
		return
	end

	if Text:sub(1, 1) == "/" then
		Text = Text:sub(2)
	end

	local v2 = string.split(Text, " ")

	table.remove(v2, 1)
	AdminRunCommand:FireServer(v2[1], v2)
end)
function _G.__admin_setPane(p1) --[[ Line: 681 | Upvalues: Frame4 (copy), Frame6 (copy) ]]
	Frame4.Visible = p1 == "items"
	Frame6.Visible = p1 == "cmds"
end
TextButton.MouseButton1Click:Connect(function() --[[ Line: 686 | Upvalues: Frame (copy) ]]
	Frame.Visible = false
end)
UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 687 | Upvalues: Frame (copy) ]]
	if p2 then
		return
	end

	if p1.KeyCode ~= Enum.KeyCode.F8 then
		return
	end

	Frame.Visible = not Frame.Visible
end)

local AdminWipeRequest = Remotes:WaitForChild("AdminWipeRequest")
local AdminWipePanel = Instance.new("ScreenGui")

AdminWipePanel.Name = "AdminWipePanel"
AdminWipePanel.ResetOnSpawn = false
AdminWipePanel.IgnoreGuiInset = true
AdminWipePanel.DisplayOrder = 50
AdminWipePanel.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame23 = Instance.new("Frame")

Frame23.Size = UDim2.new(0, 340, 0, 300)
Frame23.Position = UDim2.new(0.5, -170, 0.5, -150)
Frame23.BackgroundColor3 = v4
Frame23.BorderSizePixel = 0
Frame23.Visible = false
Frame23.Parent = AdminWipePanel
Instance.new("UICorner", Frame23).CornerRadius = UDim.new(0, 6)

local UIStroke2 = Instance.new("UIStroke")

UIStroke2.Color = Color3.fromRGB(150, 50, 50)
UIStroke2.Thickness = 2
UIStroke2.Parent = Frame23

local UIPadding7 = Instance.new("UIPadding")

UIPadding7.PaddingTop = UDim.new(0, 12)
UIPadding7.PaddingBottom = UDim.new(0, 12)
UIPadding7.PaddingLeft = UDim.new(0, 12)
UIPadding7.PaddingRight = UDim.new(0, 12)
UIPadding7.Parent = Frame23

local UIListLayout3 = Instance.new("UIListLayout")

UIListLayout3.Padding = UDim.new(0, 8)
UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout3.Parent = Frame23

local function wLabel(p1, p2, p3, p4) --[[ wLabel | Line: 738 | Upvalues: v10 (copy), Frame23 (copy) ]]
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, p4 or 18)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Font = Enum.Font.Code
	TextLabel.TextSize = if p4 then 14 else 12
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextWrapped = true
	TextLabel.TextColor3 = if p3 then p3 else v10
	TextLabel.Text = p1
	TextLabel.LayoutOrder = p2
	TextLabel.Parent = Frame23

	return TextLabel
end

local function wInput(p1, p2) --[[ wInput | Line: 753 | Upvalues: v7 (copy), v9 (copy), Frame23 (copy) ]]
	local TextBox = Instance.new("TextBox")

	TextBox.Size = UDim2.new(1, 0, 0, 30)
	TextBox.BackgroundColor3 = v7
	TextBox.BorderSizePixel = 0
	TextBox.Font = Enum.Font.Code
	TextBox.TextSize = 14
	TextBox.TextColor3 = v9
	TextBox.PlaceholderText = p1
	TextBox.Text = ""
	TextBox.ClearTextOnFocus = false
	TextBox.LayoutOrder = p2
	TextBox.Parent = Frame23
	Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 4)

	return TextBox
end

wLabel("GAMEWIDE WIPE", 1, Color3.fromRGB(235, 120, 120), 20)
wLabel("Wipes EVERY player in EVERY server, then kicks them. There is no undo and no cancel once scheduled.", 2)

local v69 = wInput("wipe password", 3)
local v70 = wInput("delay in minutes (0 = immediate)", 4)
local v71 = wInput("type WIPE to confirm", 5)
local v72 = wLabel("", 6, Color3.fromRGB(200, 170, 120))
local Frame24 = Instance.new("Frame")

Frame24.Size = UDim2.new(1, 0, 0, 34)
Frame24.BackgroundTransparency = 1
Frame24.LayoutOrder = 7
Frame24.Parent = Frame23
makeButton(Frame24, "CANCEL", 0.5, -3, 0, v6, function() --[[ Line: 783 | Upvalues: v69 (copy), v70 (copy), v71 (copy), v72 (copy), Frame23 (copy) ]]
	v69.Text = ""
	v70.Text = ""
	v71.Text = ""
	v72.Text = ""
	Frame23.Visible = false
end)
makeButton(Frame24, "EXECUTE WIPE", 0.5, -3, 0.5, Color3.fromRGB(120, 35, 35), function() --[[ Line: 788 | Upvalues: v71 (copy), v72 (copy), v70 (copy), AdminWipeRequest (copy), v69 (copy) ]]
	if v71.Text ~= "WIPE" then
		v72.Text = "Type WIPE (all caps) in the confirm box."

		return
	end

	if tonumber(v70.Text) then
		v72.Text = "Sent. Watch for the server toast."
		AdminWipeRequest:FireServer(v69.Text, tonumber(v70.Text), v71.Text)
		v69.Text = ""
		v71.Text = ""
	else
		v72.Text = "Delay must be a number of minutes."
	end
end)
UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 803 | Upvalues: UserInputService (copy), Frame23 (copy), v69 (copy), v71 (copy), v72 (copy) ]]
	if p2 then
		return
	end

	if p1.KeyCode ~= Enum.KeyCode.F8 or not (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) then
		return
	end

	Frame23.Visible = not Frame23.Visible

	if Frame23.Visible then
		return
	end

	v69.Text = ""
	v71.Text = ""
	v72.Text = ""
end)
print(("[AdminSpawner] Client ready - F8 to toggle (%d items, cmds tab available)"):format(#v3))