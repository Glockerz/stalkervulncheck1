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
local v11 = Color3.fromRGB(40, 42, 45)
local t = {
	{
		name = "ZONE WIDE",
		sub = "All stalkers in the Zone",
		count = 31,
		selected = true
	},
	{
		name = "CORDON",
		sub = "Cordon Region",
		count = 12
	},
	{
		name = "DARK VALLEY",
		sub = "Dark Valley Region",
		count = 8
	},
	{
		name = "SWAMPS",
		sub = "Swamps Region",
		count = 7
	},
	{
		name = "ROOKIE VILLAGE",
		sub = "Local Channel",
		count = 5
	},
	{
		name = "TRADE",
		sub = "Trade and Services",
		count = 15
	},
	{
		name = "FACTION \226\128\148 LONERS",
		sub = "Loners Private",
		count = 15
	},
	{
		name = "FACTION \226\128\148 DUTY",
		sub = "Duty Private",
		count = 9
	},
	{
		name = "FACTION \226\128\148 FREEDOM",
		sub = "Freedom Private",
		count = 9
	},
	{
		name = "HELP",
		sub = "New Stalkers Help",
		count = 3
	}
}
local t2 = {
	{
		speaker = "Scavenger",
		time = "15:45",
		text = "Anyone near the Army Warehouses?",
		color = Color3.fromRGB(210, 210, 210)
	},
	{
		speaker = "Ghost",
		time = "15:45",
		text = "Just saw a controller near the Train Yard.\nStay sharp.",
		color = Color3.fromRGB(120, 180, 235)
	},
	{
		speaker = "Raven",
		time = "15:46",
		text = "Emission coming. Check your detectors.",
		color = Color3.fromRGB(225, 95, 95)
	},
	{
		speaker = "Patch",
		time = "15:46",
		text = "WTS: 5.45 BP ammo x120, Medkit, Water\nMeet at the Rookie Village.",
		color = Color3.fromRGB(235, 165, 75)
	},
	{
		speaker = "Viper",
		time = "15:47",
		text = "Bandits setting up roadblock on the southern road.\nAvoid if you can.",
		color = Color3.fromRGB(110, 215, 215)
	},
	{
		speaker = "You",
		time = "15:47",
		text = "Anyone heading north? Need backup for a run.",
		color = Color3.fromRGB(245, 245, 245)
	}
}

local function buildChannelEntry(p1, p2, p3) --[[ buildChannelEntry | Line: 50 | Upvalues: v8 (copy), v9 (copy), v1 (copy), v4 (copy), v6 (copy), v2 (copy), v5 (copy), v3 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Name = "Channel_" .. p2.name
	Frame.Size = UDim2.new(1, -4, 0, 56)
	Frame.BackgroundColor3 = v8
	Frame.BackgroundTransparency = if p2.selected then 0.25 else 1
	Frame.BorderSizePixel = 0
	Frame.LayoutOrder = p3
	Frame.Parent = p1

	if p2.selected then
		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = v9
		UIStroke.Thickness = 1
		UIStroke.Transparency = 0.3
		UIStroke.Parent = Frame
	end

	local TextLabel = Instance.new("TextLabel")

	TextLabel.AnchorPoint = Vector2.new(0, 0.5)
	TextLabel.Position = UDim2.new(0, 14, 0.5, 0)
	TextLabel.Size = UDim2.fromOffset(20, 20)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 18
	TextLabel.TextColor3 = p2.selected and v4 or v6
	TextLabel.Text = "\226\167\150"
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(42, 8)
	TextLabel2.Size = UDim2.new(1, -90, 0, 22)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v2
	TextLabel2.TextSize = 17
	TextLabel2.TextColor3 = v5
	TextLabel2.Text = p2.name
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = Frame

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Position = UDim2.fromOffset(42, 30)
	TextLabel3.Size = UDim2.new(1, -90, 0, 18)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v3
	TextLabel3.TextSize = 13
	TextLabel3.TextColor3 = v6
	TextLabel3.Text = p2.sub
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Parent = Frame

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.AnchorPoint = Vector2.new(1, 0.5)
	TextLabel4.Position = UDim2.new(1, -14, 0.5, 0)
	TextLabel4.Size = UDim2.fromOffset(40, 22)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v2
	TextLabel4.TextSize = 16
	TextLabel4.TextColor3 = p2.selected and v4 or v6
	TextLabel4.Text = string.format("%02d", p2.count)
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel4.Parent = Frame
end

local function buildSidebar(p1) --[[ buildSidebar | Line: 114 | Upvalues: v1 (copy), v5 (copy), v11 (copy), v2 (copy), v6 (copy), t (copy), buildChannelEntry (copy) ]]
	local Sidebar = Instance.new("Frame")

	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0.28, 0, 1, 0)
	Sidebar.BackgroundTransparency = 1
	Sidebar.Parent = p1

	local Header = Instance.new("Frame")

	Header.Name = "Header"
	Header.Size = UDim2.new(1, 0, 0, 30)
	Header.BackgroundTransparency = 1
	Header.Parent = Sidebar

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(4, 0)
	TextLabel.Size = UDim2.fromOffset(20, 28)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 18
	TextLabel.TextColor3 = v5
	TextLabel.Text = "\226\167\150"
	TextLabel.Parent = Header

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(28, 0)
	TextLabel2.Size = UDim2.new(1, -28, 1, 0)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v1
	TextLabel2.TextSize = 22
	TextLabel2.TextColor3 = v5
	TextLabel2.Text = "RADIO"
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = Header

	local Frame = Instance.new("Frame")

	Frame.Position = UDim2.fromOffset(0, 36)
	Frame.Size = UDim2.new(1, 0, 0, 32)
	Frame.BackgroundTransparency = 1
	Frame.Parent = Sidebar

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.Parent = Frame

	local function makeTab(p1, p2, p3) --[[ makeTab | Line: 159 | Upvalues: v11 (ref), Frame (copy), v2 (ref), v5 (ref), v6 (ref) ]]
		local Frame2 = Instance.new("Frame")

		Frame2.Size = UDim2.new(0.5, -2, 1, 0)
		Frame2.BackgroundColor3 = v11
		Frame2.BackgroundTransparency = if p3 then 0.2 else 0.5
		Frame2.BorderSizePixel = 0
		Frame2.LayoutOrder = p2
		Frame2.Parent = Frame

		if p3 then
			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = Color3.fromRGB(80, 80, 80)
			UIStroke.Thickness = 1
			UIStroke.Parent = Frame2
		end

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.fromScale(1, 1)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v2
		TextLabel.TextSize = 14
		TextLabel.TextColor3 = p3 and v5 or v6
		TextLabel.Text = p1
		TextLabel.Parent = Frame2
	end

	makeTab("CHANNELS", 1, true)
	makeTab("CONTACTS", 2, false)

	local ChannelList = Instance.new("ScrollingFrame")

	ChannelList.Name = "ChannelList"
	ChannelList.Position = UDim2.fromOffset(0, 76)
	ChannelList.Size = UDim2.new(1, 0, 1, -76)
	ChannelList.BackgroundTransparency = 1
	ChannelList.BorderSizePixel = 0
	ChannelList.ScrollBarThickness = 4
	ChannelList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ChannelList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ChannelList.ScrollingDirection = Enum.ScrollingDirection.Y
	ChannelList.Parent = Sidebar

	local UIListLayout2 = Instance.new("UIListLayout")

	UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout2.Padding = UDim.new(0, 4)
	UIListLayout2.Parent = ChannelList

	for i, v in ipairs(t) do
		buildChannelEntry(ChannelList, v, i)
	end
end

local function buildMessageEntry(p1, p2, p3) --[[ buildMessageEntry | Line: 207 | Upvalues: v1 (copy), v3 (copy), v7 (copy), v5 (copy), v10 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Name = "Msg_" .. p2.speaker
	Frame.AutomaticSize = Enum.AutomaticSize.Y
	Frame.Size = UDim2.new(1, 0, 0, 0)
	Frame.BackgroundTransparency = 1
	Frame.LayoutOrder = p3
	Frame.Parent = p1

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(0, 0)
	TextLabel.Size = UDim2.new(0.7, 0, 0, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 18
	TextLabel.TextColor3 = p2.color
	TextLabel.Text = p2.speaker
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.AnchorPoint = Vector2.new(1, 0)
	TextLabel2.Position = UDim2.new(1, 0, 0, 0)
	TextLabel2.Size = UDim2.fromOffset(60, 22)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 14
	TextLabel2.TextColor3 = v7
	TextLabel2.Text = p2.time
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel2.Parent = Frame

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Position = UDim2.fromOffset(0, 24)
	TextLabel3.Size = UDim2.new(1, 0, 0, 0)
	TextLabel3.AutomaticSize = Enum.AutomaticSize.Y
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v3
	TextLabel3.TextSize = 16
	TextLabel3.TextColor3 = v5
	TextLabel3.Text = p2.text
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel3.TextWrapped = true
	TextLabel3.Parent = Frame

	local BottomPad = Instance.new("Frame")

	BottomPad.Name = "BottomPad"
	BottomPad.Size = UDim2.new(1, 0, 0, 14)
	BottomPad.Position = UDim2.new(0, 0, 1, 0)
	BottomPad.AnchorPoint = Vector2.new(0, 1)
	BottomPad.BackgroundTransparency = 1
	BottomPad.Parent = Frame

	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.new(1, 0, 0, 1)
	Frame2.AnchorPoint = Vector2.new(0, 1)
	Frame2.Position = UDim2.new(0, 0, 1, 0)
	Frame2.BackgroundColor3 = v10
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Frame
end

local function buildWaveform(p1) --[[ buildWaveform | Line: 270 | Upvalues: v2 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromOffset(180, 28)
	Frame.BackgroundTransparency = 1
	Frame.Parent = p1

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 2)
	UIListLayout.Parent = Frame

	for i, v in ipairs({
		6,
		14,
		22,
		10,
		18,
		26,
		8,
		14,
		20,
		6,
		12,
		22,
		16,
		10,
		18,
		24,
		12,
		8,
		14,
		20,
		6,
		12,
		18
	}) do
		local Frame2 = Instance.new("Frame")

		Frame2.Size = UDim2.fromOffset(3, v)
		Frame2.BackgroundColor3 = Color3.fromRGB(180, 220, 130)
		Frame2.BorderSizePixel = 0
		Frame2.LayoutOrder = i
		Frame2.Parent = Frame
	end

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromOffset(28, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 16
	TextLabel.TextColor3 = Color3.fromRGB(180, 220, 130)
	TextLabel.Text = tostring(31)
	TextLabel.LayoutOrder = 999
	TextLabel.Parent = Frame
end

local function buildChat(p1) --[[ buildChat | Line: 304 | Upvalues: v1 (copy), v5 (copy), buildWaveform (copy), v8 (copy), v2 (copy), v7 (copy), v3 (copy), v6 (copy), t2 (copy), buildMessageEntry (copy), v10 (copy), v11 (copy) ]]
	local Chat = Instance.new("Frame")

	Chat.Name = "Chat"
	Chat.Position = UDim2.new(0.28, 16, 0, 0)
	Chat.Size = UDim2.new(0.72, -16, 1, 0)
	Chat.BackgroundTransparency = 1
	Chat.Parent = p1

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 32)
	Frame.BackgroundTransparency = 1
	Frame.Parent = Chat

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(0, 0)
	TextLabel.Size = UDim2.fromOffset(180, 32)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 24
	TextLabel.TextColor3 = v5
	TextLabel.Text = "ZONE WIDE"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Frame

	local Frame2 = Instance.new("Frame")

	Frame2.Position = UDim2.fromOffset(190, 2)
	Frame2.Size = UDim2.fromOffset(220, 28)
	Frame2.BackgroundTransparency = 1
	Frame2.Parent = Frame
	buildWaveform(Frame2)

	local Frame3 = Instance.new("Frame")

	Frame3.AnchorPoint = Vector2.new(1, 0)
	Frame3.Position = UDim2.new(1, 0, 0, 0)
	Frame3.Size = UDim2.fromOffset(180, 50)
	Frame3.BackgroundColor3 = v8
	Frame3.BackgroundTransparency = 0.4
	Frame3.BorderSizePixel = 0
	Frame3.Parent = Chat

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(70, 80, 60)
	UIStroke.Thickness = 1
	UIStroke.Parent = Frame3

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(12, 4)
	TextLabel2.Size = UDim2.fromOffset(80, 18)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v2
	TextLabel2.TextSize = 12
	TextLabel2.TextColor3 = v7
	TextLabel2.Text = "ONLINE"
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = Frame3

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Position = UDim2.fromOffset(12, 20)
	TextLabel3.Size = UDim2.fromOffset(50, 26)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v1
	TextLabel3.TextSize = 22
	TextLabel3.TextColor3 = v5
	TextLabel3.Text = tostring(24)
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Parent = Frame3

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.Position = UDim2.fromOffset(68, 22)
	TextLabel4.Size = UDim2.fromOffset(100, 22)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v3
	TextLabel4.TextSize = 14
	TextLabel4.TextColor3 = v6
	TextLabel4.Text = "Stalkers"
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel4.Parent = Frame3

	local TextLabel5 = Instance.new("TextLabel")

	TextLabel5.Position = UDim2.fromOffset(0, 36)
	TextLabel5.Size = UDim2.new(1, -200, 0, 22)
	TextLabel5.BackgroundTransparency = 1
	TextLabel5.FontFace = v3
	TextLabel5.TextSize = 14
	TextLabel5.TextColor3 = v6
	TextLabel5.Text = "Open channel. All stalkers in the Zone can hear and speak."
	TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel5.Parent = Chat

	local Feed = Instance.new("ScrollingFrame")

	Feed.Name = "Feed"
	Feed.Position = UDim2.fromOffset(0, 66)
	Feed.Size = UDim2.new(1, 0, 1, -118)
	Feed.BackgroundTransparency = 1
	Feed.BorderSizePixel = 0
	Feed.ScrollBarThickness = 4
	Feed.CanvasSize = UDim2.new(0, 0, 0, 0)
	Feed.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Feed.ScrollingDirection = Enum.ScrollingDirection.Y
	Feed.Parent = Chat

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 0)
	UIListLayout.Parent = Feed

	for i, v in ipairs(t2) do
		buildMessageEntry(Feed, v, i)
	end

	local Frame4 = Instance.new("Frame")

	Frame4.AnchorPoint = Vector2.new(0, 1)
	Frame4.Position = UDim2.new(0, 0, 1, 0)
	Frame4.Size = UDim2.new(1, 0, 0, 44)
	Frame4.BackgroundColor3 = Color3.fromRGB(28, 30, 28)
	Frame4.BorderSizePixel = 0
	Frame4.Parent = Chat

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = v10
	UIStroke2.Thickness = 1
	UIStroke2.Parent = Frame4

	local TextLabel6 = Instance.new("TextLabel")

	TextLabel6.Position = UDim2.fromOffset(14, 0)
	TextLabel6.Size = UDim2.new(1, -110, 1, 0)
	TextLabel6.BackgroundTransparency = 1
	TextLabel6.FontFace = v3
	TextLabel6.TextSize = 15
	TextLabel6.TextColor3 = v7
	TextLabel6.Text = "Press [T] to talk or type your message..."
	TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel6.Parent = Frame4

	local Frame5 = Instance.new("Frame")

	Frame5.AnchorPoint = Vector2.new(1, 0.5)
	Frame5.Position = UDim2.new(1, -8, 0.5, 0)
	Frame5.Size = UDim2.fromOffset(80, 30)
	Frame5.BackgroundColor3 = v11
	Frame5.BackgroundTransparency = 0.2
	Frame5.BorderSizePixel = 0
	Frame5.Parent = Frame4

	local UIStroke3 = Instance.new("UIStroke")

	UIStroke3.Color = Color3.fromRGB(80, 80, 80)
	UIStroke3.Thickness = 1
	UIStroke3.Parent = Frame5

	local TextLabel7 = Instance.new("TextLabel")

	TextLabel7.Size = UDim2.fromScale(1, 1)
	TextLabel7.BackgroundTransparency = 1
	TextLabel7.FontFace = v2
	TextLabel7.TextSize = 14
	TextLabel7.TextColor3 = v5
	TextLabel7.Text = "SEND"
	TextLabel7.Parent = Frame5
end

return {
	Build = function(p1) --[[ Build | Line: 462 | Upvalues: buildSidebar (copy), buildChat (copy) ]]
		local Body = Instance.new("Frame")

		Body.Name = "Body"
		Body.Position = UDim2.fromOffset(16, 8)
		Body.Size = UDim2.new(1, -32, 1, -16)
		Body.BackgroundTransparency = 1
		Body.Parent = p1
		buildSidebar(Body)
		buildChat(Body)
	end
}