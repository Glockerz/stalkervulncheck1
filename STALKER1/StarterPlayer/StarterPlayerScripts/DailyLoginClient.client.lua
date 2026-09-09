-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local DailyLoginReady = Remotes:WaitForChild("DailyLoginReady")
local DailyLoginClaim = Remotes:WaitForChild("DailyLoginClaim")
local DailyLoginRequest = Remotes:WaitForChild("DailyLoginRequest")
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))
local DailyLoginConfig = require(ReplicatedStorage:WaitForChild("DailyLoginConfig"))
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"))
local v1 = Color3.fromRGB(215, 175, 75)
local v2 = Color3.fromRGB(240, 200, 90)
local v3 = Color3.fromRGB(18, 18, 20)
local v4 = Color3.fromRGB(32, 32, 34)
local v5 = Color3.fromRGB(70, 70, 72)
local v6 = Color3.fromRGB(38, 32, 22)
local v7 = Color3.fromRGB(24, 32, 48)
local v8 = Color3.fromRGB(90, 110, 150)
local v9 = Color3.fromRGB(230, 230, 230)
local v10 = Color3.fromRGB(170, 170, 170)
local v11 = Color3.fromRGB(120, 120, 120)
local v12 = Color3.fromRGB(120, 30, 30)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local t = {}
local v19 = nil
local v20 = nil

local function iconFor(p1) --[[ iconFor | Line: 39 | Upvalues: ItemDatabase (copy) ]]
	local v1 = ItemDatabase[p1]

	return if v1 then v1.ImageID or (v1.Icon or "rbxassetid://0") else "rbxassetid://0"
end

local function applyIcon(p1, p2) --[[ applyIcon | Line: 46 | Upvalues: ItemDatabase (copy), ItemIconStyle (copy) ]]
	local v1 = ItemDatabase[p2]

	p1.Image = v1 and (v1.ImageID or v1.Icon) or "rbxassetid://0"
	p1.ScaleType = ItemIconStyle.ScaleTypeFor(ItemDatabase[p2])
end

local function displayNameFor(p1) --[[ displayNameFor | Line: 50 | Upvalues: ItemDatabase (copy) ]]
	local v1 = ItemDatabase[p1]

	return if v1 then v1.Name or (v1.DisplayName or p1) else p1
end

local function tierDescriptor(p1) --[[ tierDescriptor | Line: 55 ]]
	if p1 == "Small" then
		return "Small item"
	end

	if p1 == "Medium" then
		return "Medium item"
	end

	if p1 == "Finale" then
		return "Finale bundle"
	end

	return p1 .. " item"
end

local function fmtCountdown(p1) --[[ fmtCountdown | Line: 63 ]]
	local v2 = math.max(0, (math.floor(p1)))
	local v3 = math.floor(v2 / 3600)

	return string.format("%02d:%02d:%02d", v3, math.floor(v2 % 3600 / 60), v2 % 60)
end

local function secondsUntilNextUTCMidnight() --[[ secondsUntilNextUTCMidnight | Line: 75 ]]
	local v1 = os.time()

	return (math.floor(v1 / 86400) + 1) * 86400 - v1
end

local function build() --[[ build | Line: 82 | Upvalues: v14 (ref), t (ref), PlayerGui (copy), v3 (copy), v1 (copy), v2 (copy), v9 (copy), v10 (copy), v12 (copy), v7 (copy), v4 (copy), v8 (copy), v5 (copy), ItemIconStyle (copy), v17 (ref), v18 (ref), v15 (ref), v16 (ref), v11 (copy), v13 (ref), DailyLoginClaim (copy), v20 (ref), v19 (ref), RunService (copy) ]]
	if v14 then
		v14:Destroy()
	end

	t = {}
	v14 = Instance.new("ScreenGui")
	v14.Name = "DailyLoginPopup"
	v14.ResetOnSpawn = false
	v14.IgnoreGuiInset = true
	v14.Enabled = false
	v14.DisplayOrder = 50
	v14.Parent = PlayerGui

	local Dim = Instance.new("Frame")

	Dim.Name = "Dim"
	Dim.Size = UDim2.fromScale(1, 1)
	Dim.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	Dim.BackgroundTransparency = 0.4
	Dim.BorderSizePixel = 0
	Dim.Parent = v14

	local Panel = Instance.new("Frame")

	Panel.Name = "Panel"
	Panel.AnchorPoint = Vector2.new(0.5, 0.5)
	Panel.Position = UDim2.fromScale(0.5, 0.5)
	Panel.Size = UDim2.fromOffset(1250, 700)
	Panel.BackgroundColor3 = v3
	Panel.BorderSizePixel = 0
	Panel.Parent = v14

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v1
	UIStroke.Thickness = 2
	UIStroke.Transparency = 0.15
	UIStroke.Parent = Panel

	local HazIcon = Instance.new("TextLabel")

	HazIcon.Name = "HazIcon"
	HazIcon.Size = UDim2.fromOffset(80, 80)
	HazIcon.Position = UDim2.fromOffset(28, 26)
	HazIcon.BackgroundTransparency = 1
	HazIcon.Font = Enum.Font.GothamBlack
	HazIcon.TextSize = 60
	HazIcon.TextColor3 = v2
	HazIcon.Text = "\226\152\162"
	HazIcon.TextXAlignment = Enum.TextXAlignment.Center
	HazIcon.TextYAlignment = Enum.TextYAlignment.Center
	HazIcon.Parent = Panel

	local Title = Instance.new("TextLabel")

	Title.Name = "Title"
	Title.Font = Enum.Font.GothamBlack
	Title.TextSize = 38
	Title.TextColor3 = v9
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0.6, 0, 0, 44)
	Title.Position = UDim2.fromOffset(120, 30)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextYAlignment = Enum.TextYAlignment.Center
	Title.Text = "DAILY LOGIN"
	Title.Parent = Panel

	local Subtitle = Instance.new("TextLabel")

	Subtitle.Name = "Subtitle"
	Subtitle.Font = Enum.Font.Gotham
	Subtitle.TextSize = 16
	Subtitle.TextColor3 = v10
	Subtitle.BackgroundTransparency = 1
	Subtitle.Size = UDim2.new(0.6, 0, 0, 22)
	Subtitle.Position = UDim2.fromOffset(120, 74)
	Subtitle.TextXAlignment = Enum.TextXAlignment.Left
	Subtitle.Text = "Log in every day to claim better rewards."
	Subtitle.Parent = Panel

	local Close = Instance.new("TextButton")

	Close.Name = "Close"
	Close.Text = "X"
	Close.Font = Enum.Font.GothamBlack
	Close.TextSize = 22
	Close.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Close.BackgroundColor3 = v12
	Close.Size = UDim2.fromOffset(40, 40)
	Close.Position = UDim2.new(1, -60, 0, 26)
	Close.BorderSizePixel = 0
	Close.Parent = Panel
	Close.Activated:Connect(function() --[[ Line: 166 | Upvalues: v14 (ref) ]]
		v14.Enabled = false
	end)

	local SlotRow = Instance.new("Frame")

	SlotRow.Name = "SlotRow"
	SlotRow.BackgroundTransparency = 1
	SlotRow.Size = UDim2.new(1, -56, 0, 380)
	SlotRow.Position = UDim2.fromOffset(28, 120)
	SlotRow.Parent = Panel

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = SlotRow

	for i = 1, 7 do
		local Frame = Instance.new("Frame")

		Frame.Name = "Day" .. i
		Frame.LayoutOrder = i
		Frame.Size = UDim2.new(0, 158, 1, 0)
		Frame.BackgroundColor3 = i == 7 and v7 or v4
		Frame.BorderSizePixel = 0
		Frame.Parent = SlotRow

		local UIStroke2 = Instance.new("UIStroke")

		UIStroke2.Color = i == 7 and v8 or v5
		UIStroke2.Thickness = 1
		UIStroke2.Transparency = 0.5
		UIStroke2.Parent = Frame

		local DayLabel = Instance.new("TextLabel")

		DayLabel.Name = "DayLabel"
		DayLabel.Text = "DAY " .. i
		DayLabel.Font = Enum.Font.GothamBold
		DayLabel.TextSize = 15
		DayLabel.TextColor3 = v10
		DayLabel.BackgroundTransparency = 1
		DayLabel.Size = UDim2.new(1, 0, 0, 20)
		DayLabel.Position = UDim2.fromOffset(0, 16)
		DayLabel.Parent = Frame

		if i == 7 then
			local TextLabel = Instance.new("TextLabel")

			TextLabel.Text = "FINALE"
			TextLabel.Font = Enum.Font.GothamBlack
			TextLabel.TextSize = 15
			TextLabel.TextColor3 = v2
			TextLabel.BackgroundTransparency = 1
			TextLabel.Size = UDim2.new(1, 0, 0, 18)
			TextLabel.Position = UDim2.fromOffset(0, 36)
			TextLabel.Parent = Frame
			DayLabel.TextColor3 = v9
		end

		local IconBg = Instance.new("Frame")

		IconBg.Name = "IconBg"
		IconBg.Size = UDim2.fromOffset(114, 114)
		IconBg.Position = UDim2.new(0.5, -57, 0, 66)
		IconBg.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
		IconBg.BorderSizePixel = 0
		IconBg.Parent = Frame

		local UIStroke3 = Instance.new("UIStroke")

		UIStroke3.Color = Color3.fromRGB(50, 50, 55)
		UIStroke3.Thickness = 1
		UIStroke3.Transparency = 0.6
		UIStroke3.Parent = IconBg

		local Icon = Instance.new("ImageLabel")

		Icon.Name = "Icon"
		Icon.BackgroundTransparency = 1
		Icon.Size = UDim2.fromScale(1, 1)
		Icon.ScaleType = ItemIconStyle.ScaleTypeFor(nil)
		Icon.Image = ""
		Icon.Parent = IconBg

		local Roubles = Instance.new("TextLabel")

		Roubles.Name = "Roubles"
		Roubles.Font = Enum.Font.GothamBlack
		Roubles.TextSize = 28
		Roubles.TextColor3 = v9
		Roubles.BackgroundTransparency = 1
		Roubles.Size = UDim2.new(1, 0, 0, 34)
		Roubles.Position = UDim2.new(0, 0, 0, 210)
		Roubles.Text = ""
		Roubles.Parent = Frame

		local Desc = Instance.new("TextLabel")

		Desc.Name = "Desc"
		Desc.Font = Enum.Font.Gotham
		Desc.TextSize = 13
		Desc.TextColor3 = v10
		Desc.BackgroundTransparency = 1
		Desc.Size = UDim2.new(1, -16, 0, 20)
		Desc.Position = UDim2.new(0, 8, 0, 250)
		Desc.TextWrapped = false
		Desc.TextTruncate = Enum.TextTruncate.AtEnd
		Desc.Text = ""
		Desc.Parent = Frame

		local TodayBadge = Instance.new("Frame")

		TodayBadge.Name = "TodayBadge"
		TodayBadge.Size = UDim2.new(1, -16, 0, 26)
		TodayBadge.Position = UDim2.new(0, 8, 1, -36)
		TodayBadge.BackgroundColor3 = v2
		TodayBadge.BorderSizePixel = 0
		TodayBadge.Visible = false
		TodayBadge.Parent = Frame

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.fromScale(1, 1)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Font = Enum.Font.GothamBlack
		TextLabel.TextSize = 14
		TextLabel.TextColor3 = Color3.fromRGB(20, 20, 20)
		TextLabel.Text = "TODAY"
		TextLabel.Parent = TodayBadge

		local ClaimedTag = Instance.new("TextLabel")

		ClaimedTag.Name = "ClaimedTag"
		ClaimedTag.Size = UDim2.new(1, -16, 0, 22)
		ClaimedTag.Position = UDim2.new(0, 8, 1, -32)
		ClaimedTag.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
		ClaimedTag.BorderSizePixel = 0
		ClaimedTag.Font = Enum.Font.GothamBlack
		ClaimedTag.TextSize = 12
		ClaimedTag.TextColor3 = Color3.fromRGB(230, 240, 220)
		ClaimedTag.Text = "CLAIMED"
		ClaimedTag.Visible = false
		ClaimedTag.Parent = Frame
		t[i] = Frame
	end

	local InfoBar = Instance.new("Frame")

	InfoBar.Name = "InfoBar"
	InfoBar.Size = UDim2.new(1, -56, 0, 64)
	InfoBar.Position = UDim2.fromOffset(28, 512)
	InfoBar.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
	InfoBar.BorderSizePixel = 0
	InfoBar.Parent = Panel

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = Color3.fromRGB(60, 60, 62)
	UIStroke2.Thickness = 1
	UIStroke2.Transparency = 0.5
	UIStroke2.Parent = InfoBar

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromOffset(40, 40)
	TextLabel.Position = UDim2.fromOffset(20, 12)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Font = Enum.Font.GothamBlack
	TextLabel.TextSize = 28
	TextLabel.TextColor3 = v1
	TextLabel.Text = "\226\151\134"
	TextLabel.Parent = InfoBar

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(0.5, -80, 0, 18)
	TextLabel2.Position = UDim2.fromOffset(70, 10)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Font = Enum.Font.GothamBold
	TextLabel2.TextSize = 12
	TextLabel2.TextColor3 = v1
	TextLabel2.Text = "TODAY\'S REWARD"
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = InfoBar
	v17 = Instance.new("TextLabel")
	v17.Size = UDim2.new(0.5, -80, 0, 24)
	v17.Position = UDim2.fromOffset(70, 30)
	v17.BackgroundTransparency = 1
	v17.Font = Enum.Font.GothamBold
	v17.TextSize = 18
	v17.TextColor3 = v9
	v17.Text = "-"
	v17.TextXAlignment = Enum.TextXAlignment.Left
	v17.Parent = InfoBar

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(0, 1, 0.6, 0)
	Frame.Position = UDim2.new(0.5, 0, 0.2, 0)
	Frame.BackgroundColor3 = Color3.fromRGB(70, 70, 72)
	Frame.BorderSizePixel = 0
	Frame.Parent = InfoBar

	local CountdownIcon = Instance.new("Frame")

	CountdownIcon.Name = "CountdownIcon"
	CountdownIcon.Size = UDim2.fromOffset(26, 26)
	CountdownIcon.Position = UDim2.new(0.5, 27, 0, 19)
	CountdownIcon.BackgroundTransparency = 1
	CountdownIcon.Parent = InfoBar

	local Face = Instance.new("Frame")

	Face.Name = "Face"
	Face.Size = UDim2.fromScale(1, 1)
	Face.BackgroundTransparency = 1
	Face.Parent = CountdownIcon

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0.5, 0)
	UICorner.Parent = Face

	local UIStroke3 = Instance.new("UIStroke")

	UIStroke3.Color = v1
	UIStroke3.Thickness = 2
	UIStroke3.Parent = Face

	local function clockHand(p1, p2) --[[ clockHand | Line: 384 | Upvalues: v1 (ref), Face (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.AnchorPoint = Vector2.new(0.5, 1)
		Frame.Position = UDim2.fromScale(0.5, 0.5)
		Frame.Size = UDim2.new(0, 2, p1, 0)
		Frame.BackgroundColor3 = v1
		Frame.BorderSizePixel = 0
		Frame.Rotation = p2
		Frame.Parent = Face
	end

	clockHand(0.26, -60)
	clockHand(0.36, 60)

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(0.5, -80, 0, 18)
	TextLabel3.Position = UDim2.new(0.5, 70, 0, 10)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.Font = Enum.Font.GothamBold
	TextLabel3.TextSize = 12
	TextLabel3.TextColor3 = v1
	TextLabel3.Text = "NEXT REWARD IN"
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Parent = InfoBar
	v18 = Instance.new("TextLabel")
	v18.Size = UDim2.new(0.5, -80, 0, 24)
	v18.Position = UDim2.new(0.5, 70, 0, 30)
	v18.BackgroundTransparency = 1
	v18.Font = Enum.Font.GothamBold
	v18.TextSize = 18
	v18.TextColor3 = v2
	v18.Text = "--:--:--"
	v18.TextXAlignment = Enum.TextXAlignment.Left
	v18.Parent = InfoBar
	v15 = Instance.new("TextButton")
	v15.Name = "Claim"
	v15.Size = UDim2.new(0, 620, 0, 64)
	v15.Position = UDim2.new(0.5, -310, 0, 596)
	v15.BackgroundColor3 = v2
	v15.BorderSizePixel = 0
	v15.Font = Enum.Font.GothamBlack
	v15.TextSize = 26
	v15.TextColor3 = Color3.fromRGB(20, 20, 20)
	v15.Text = "CLAIM"
	v15.AutoButtonColor = true
	v15.Parent = Panel

	local UIStroke4 = Instance.new("UIStroke")

	UIStroke4.Color = v1
	UIStroke4.Thickness = 1
	UIStroke4.Parent = v15
	v16 = Instance.new("TextLabel")
	v16.Size = UDim2.new(1, 0, 0, 18)
	v16.Position = UDim2.new(0, 0, 1, -22)
	v16.BackgroundTransparency = 1
	v16.Font = Enum.Font.Gotham
	v16.TextSize = 12
	v16.TextColor3 = v11
	v16.Text = "Rewards reset daily at 00:00 UTC"
	v16.TextXAlignment = Enum.TextXAlignment.Center
	v16.Parent = Panel
	v15.Activated:Connect(function() --[[ Line: 449 | Upvalues: v13 (ref), v15 (ref), DailyLoginClaim (ref), v16 (ref), v20 (ref) ]]
		if not v13 or v13.state ~= "ready" then
			return
		end

		v15.AutoButtonColor = false
		v15.Text = "..."

		local ok, result = pcall(function() --[[ Line: 453 | Upvalues: DailyLoginClaim (ref) ]]
			return DailyLoginClaim:InvokeServer()
		end)

		if ok and (result and result.ok) then
			local delivery = result.delivery

			if not delivery then
				v13.state = "already_claimed"
				v20(v13)

				return
			end

			local t = {}

			if delivery.pockets > 0 then
				local format = string.format

				table.insert(t, format("%d to inventory", delivery.pockets))
			end

			if delivery.stash > 0 then
				local format = string.format

				table.insert(t, format("%d to stash", delivery.stash))
			end

			if delivery.ecologist > 0 then
				local format = string.format

				table.insert(t, format("%d held by Ecologist (no room)", delivery.ecologist))
			end

			if not (#t > 0) then
				v13.state = "already_claimed"
				v20(v13)

				return
			end

			v16.Text = "Claimed. " .. table.concat(t, "; ") .. "."

			if not (delivery.ecologist > 0) then
				v13.state = "already_claimed"
				v20(v13)

				return
			end

			v16.TextColor3 = Color3.fromRGB(255, 200, 90)
			v13.state = "already_claimed"
			v20(v13)
		else
			v16.Text = "Claim failed: " .. tostring(if result then result.err or ok else ok)
			v15.Text = "CLAIM"
			v15.AutoButtonColor = true
		end
	end)

	local v32

	if v19 then
		v19:Disconnect()
	end

	v32 = 0
	v19 = RunService.Heartbeat:Connect(function() --[[ Line: 483 | Upvalues: v14 (ref), v32 (ref), v18 (ref) ]]
		if not (v14 and v14.Enabled) then
			return
		end

		local v1 = os.clock()

		if v1 < v32 then
			return
		end

		v32 = v1 + 1

		if not v18 then
			return
		end

		local v3 = os.time()
		local v6 = math.max(0, (math.floor((math.floor(v3 / 86400) + 1) * 86400 - v3)))

		v18.Text = string.format("%02d:%02d:%02d", math.floor(v6 / 3600), math.floor(v6 % 3600 / 60), v6 % 60)
	end)
end

v20 = function(p1) --[[ Line: 494 | Upvalues: v14 (ref), build (copy), v13 (ref), t (ref), DailyLoginConfig (copy), v7 (copy), v4 (copy), ItemDatabase (copy), ItemIconStyle (copy), v2 (copy), v11 (copy), v10 (copy), v6 (copy), v9 (copy), v17 (ref), v15 (ref), v16 (ref), v18 (ref) ]]
	if not v14 then
		build()
	end

	v13 = p1

	if p1 and p1.state == "unavailable" then
		v14.Enabled = false

		return
	end

	local v1 = p1.day or 0

	for i = 1, 7 do
		local v22
		local v3 = t[i]
		local v42 = DailyLoginConfig.Rewards[i]

		v3.BackgroundColor3 = i == 7 and v7 or v4
		v3.Roubles.Text = string.format("%d  \226\130\189", v42.roubles)
		v3.TodayBadge.Visible = false
		v3.ClaimedTag.Visible = false

		local v62 = if i < v1 then true else false
		local v72 = if v1 < i then true else false

		if i == 7 then
			local Icon = v3.IconBg.Icon
			local FinalePreviewItemId = DailyLoginConfig.FinalePreviewItemId
			local v8 = ItemDatabase[FinalePreviewItemId]

			v22 = v8 and (v8.ImageID or v8.Icon) or "rbxassetid://0"
			Icon.Image = v22
			Icon.ScaleType = ItemIconStyle.ScaleTypeFor(ItemDatabase[FinalePreviewItemId])
			v3.Desc.Text = "Guaranteed gear"
			v3.Desc.TextColor3 = v2
		elseif v72 then
			v3.IconBg.Icon.Image = ""
			v3.Desc.Text = "???"
			v3.Desc.TextColor3 = v11
		elseif v62 then
			v3.IconBg.Icon.Image = ""

			local itemTier = v42.itemTier

			v3.Desc.Text = if itemTier == "Small" then "Small item" elseif itemTier == "Medium" then "Medium item" elseif itemTier == "Finale" then "Finale bundle" else itemTier .. " item"
			v3.Desc.TextColor3 = v11
		else
			v3.IconBg.Icon.Image = ""

			local itemTier = v42.itemTier

			v3.Desc.Text = if itemTier == "Small" then "Small item" elseif itemTier == "Medium" then "Medium item" elseif itemTier == "Finale" then "Finale bundle" else itemTier .. " item"
			v3.Desc.TextColor3 = v10
		end

		local Mystery = v3.IconBg:FindFirstChild("Mystery")

		if not Mystery then
			local Mystery2 = Instance.new("TextLabel")

			Mystery2.Name = "Mystery"
			Mystery2.Size = UDim2.fromScale(1, 1)
			Mystery2.BackgroundTransparency = 1
			Mystery2.Font = Enum.Font.GothamBlack
			Mystery2.TextSize = 62
			Mystery2.TextColor3 = Color3.fromRGB(80, 80, 82)
			Mystery2.Text = "?"
			Mystery2.Parent = v3.IconBg
			Mystery = Mystery2
		end

		Mystery.Visible = if v72 then if i == 7 then false else true else v72
	end

	local v12 = p1.day or 0

	for j = 1, v12 - 1 do
		t[j].ClaimedTag.Visible = true

		for i, v in ipairs(t[j]:GetDescendants()) do
			if v:IsA("TextLabel") then
				v.TextTransparency = 0.4

				continue
			end

			if v:IsA("ImageLabel") then
				v.ImageTransparency = 0.4
			end
		end
	end

	if t[v12] then
		local v132 = t[v12]

		if v12 ~= 7 then
			v132.BackgroundColor3 = v6
		end

		local UIStroke = v132:FindFirstChildOfClass("UIStroke")

		if UIStroke then
			UIStroke.Color = v2
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0
		end

		v132.DayLabel.TextColor3 = v2
		v132.TodayBadge.Visible = true

		if p1.items and p1.items[1] then
			local v142 = p1.items[1]
			local Icon = v132.IconBg.Icon
			local itemId = v142.itemId
			local v152 = ItemDatabase[itemId]

			Icon.Image = if v152 then v152.ImageID or (v152.Icon or "rbxassetid://0") else "rbxassetid://0"
			Icon.ScaleType = ItemIconStyle.ScaleTypeFor(ItemDatabase[itemId])

			local format = string.format
			local itemId2 = v142.itemId
			local v182 = ItemDatabase[itemId2]

			v132.Desc.Text = format("%dx %s", v142.count, v182 and (v182.Name or v182.DisplayName) or itemId2)
			v132.Desc.TextColor3 = v9

			local Mystery = v132.IconBg:FindFirstChild("Mystery")

			if Mystery then
				Mystery.Visible = false
			end
		end
	end

	local v21, v222, v23, v24, v25, v26

	if p1.state == "already_claimed" then
		local v20
		local t2 = {}

		for v31, v32 in ipairs(p1.items or {}) do
			local v29, v30
			local itemId = v32.itemId
			local v34 = ItemDatabase[itemId]

			if v34 then
				v29 = v34.Name

				if v29 then
					v30 = t2
				else
					v29 = v34.DisplayName

					if v29 then
						v30 = t2
					else
						v30 = t2
						v29 = itemId
					end
				end
			else
				v30 = t2
				v29 = itemId
			end

			table.insert(v30, ("%dx %s"):format(v32.count, v29))
		end

		if p1.roubles or #t2 > 0 then
			local v35 = p1.roubles and tostring(p1.roubles) .. " \226\130\189" or ""

			if #t2 > 0 then
				v35 = (if v35 == "" then "" else v35 .. "  +  " or "") .. table.concat(t2, ", ")
			end

			v17.Text = v35
		else
			v17.Text = "-"
		end

		v15.Text = "CLAIMED"
		v15.BackgroundColor3 = Color3.fromRGB(90, 130, 80)
		v15.AutoButtonColor = false
		v16.Text = "Come back tomorrow. Rewards reset at 00:00 UTC."

		if not t[v12] then
			v20 = v18
			v21 = os.time()
			v222 = (math.floor(v21 / 86400) + 1) * 86400 - v21
			v23 = math.floor(v222)
			v24 = math.max(0, v23)
			v25 = math.floor(v24 / 3600)
			v26 = math.floor(v24 % 3600 / 60)
			v18.Text = string.format("%02d:%02d:%02d", v25, v26, v24 % 60)
			v14.Enabled = true

			return
		end

		t[v12].ClaimedTag.Visible = true
	else
		local t2 = {}

		for v41, v42 in ipairs(p1.items or {}) do
			local v39, v40
			local itemId = v42.itemId
			local v44 = ItemDatabase[itemId]

			if v44 then
				v39 = v44.Name

				if v39 then
					v40 = t2
				else
					v39 = v44.DisplayName

					if v39 then
						v40 = t2
					else
						v40 = t2
						v39 = itemId
					end
				end
			else
				v40 = t2
				v39 = itemId
			end

			table.insert(v40, ("%dx %s"):format(v42.count, v39))
		end

		local v46 = tostring(p1.roubles or 0) .. " \226\130\189"

		if #t2 > 0 then
			v46 = v46 .. "  +  " .. table.concat(t2, ", ")
		end

		v17.Text = v46
		v15.Text = "CLAIM"
		v15.BackgroundColor3 = v2
		v15.AutoButtonColor = true
		v16.Text = "Rewards reset daily at 00:00 UTC"
	end

	v21 = os.time()
	v222 = (math.floor(v21 / 86400) + 1) * 86400 - v21
	v23 = math.floor(v222)
	v24 = math.max(0, v23)
	v25 = math.floor(v24 / 3600)
	v26 = math.floor(v24 % 3600 / 60)
	v18.Text = string.format("%02d:%02d:%02d", v25, v26, v24 % 60)
	v14.Enabled = true
end
DailyLoginReady.OnClientEvent:Connect(v20)
task.spawn(function() --[[ Line: 696 | Upvalues: v13 (ref), DailyLoginRequest (copy), v20 (ref) ]]
	for i = 1, 4 do
		if v13 and v13.state ~= "unavailable" then
			return
		end

		local ok, result = pcall(function() --[[ Line: 699 | Upvalues: DailyLoginRequest (ref) ]]
			return DailyLoginRequest:InvokeServer()
		end)

		if ok and (result and result.state ~= "unavailable") then
			v20(result)

			return
		end

		if i < 4 then
			task.wait(i * 3)
		end
	end

	warn("[DailyLoginClient] no offer after " .. 4 .. " attempts")
end)