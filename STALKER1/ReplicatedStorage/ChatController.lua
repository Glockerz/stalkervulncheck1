-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ok, result = pcall(function() --[[ Line: 13 | Upvalues: ReplicatedStorage (copy) ]]
	return require(ReplicatedStorage:WaitForChild("SupporterCatalog", 5))
end)
local v1 = if ok then result else nil

local function getSupporterTag(p1) --[[ getSupporterTag | Line: 21 | Upvalues: v1 (ref) ]]
	if not (p1 and v1) then
		return nil
	end

	local v12 = p1:GetAttribute("_SupporterTier")

	if type(v12) ~= "string" or v12 == "" then
		return nil
	end

	local v2 = v1.Tiers and v1.Tiers[v12]

	if not v2 then
		return nil
	end

	local v3 = v2.ChatColor or Color3.fromRGB(230, 230, 230)

	return {
		prefix = v2.ChatPrefix,
		colorHex = string.format("#%02X%02X%02X", math.floor(v3.R * 255 + 0.5), math.floor(v3.G * 255 + 0.5), (math.floor(v3.B * 255 + 0.5)))
	}
end

local LocalPlayer = Players.LocalPlayer
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v4 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)

UDim2.fromScale(0.01, 0.55)

local t = {
	ZoneRadio = {
		displayName = "Zone Radio",
		faction = "PDA"
	},
	ZoneAlert = {
		displayName = "Zone Alert",
		faction = "PDA"
	},
	ZoneEvents = {
		displayName = "Zone Events",
		faction = "PDA"
	},
	ZoneLoner = {
		displayName = "Stalker",
		faction = "Loner"
	},
	ZoneBandit = {
		displayName = "Bandit",
		faction = "Bandit"
	}
}
local t2 = {
	_initialized = false,
	_transientGui = nil,
	_transientList = nil,
	_historyGui = nil,
	_historyList = nil,
	_allMessages = {},
	_inputBar = nil,
	_inputBox = nil
}

local function getFactionFor(p1) --[[ getFactionFor | Line: 80 ]]
	if p1 then
		return p1:GetAttribute("Faction") or "Loner"
	end

	return ""
end

local t3 = {
	"fuck",
	"shit",
	"bitch",
	"cunt",
	"faggot",
	"nigger",
	"nigga",
	"whore",
	"slut",
	"retard",
	"tranny",
	"dyke",
	"kike",
	"spic",
	"chink"
}

local function censorText(p1) --[[ censorText | Line: 95 | Upvalues: t3 (copy) ]]
	if type(p1) == "string" and p1 ~= "" then
		return p1:gsub("%w+", function(p13) --[[ Line: 97 | Upvalues: t3 (ref) ]]
			local v1 = p13:lower()

			for i2, v in ipairs(t3) do
				if v1:find(v, 1, true) then
					return string.rep("*", #p13)
				end
			end
		end)
	end

	return p1
end

local function formatTimestamp(p1) --[[ formatTimestamp | Line: 107 ]]
	local v1 = math.floor(p1 / 3600 % 24)

	return string.format("%02d:%02d", v1, (math.floor(p1 / 60 % 60)))
end

function t2.Init(p1) --[[ Init | Line: 113 ]]
	if not p1._initialized then
		p1._initialized = true
		p1:_buildGui()
		p1:_wireChat()
		p1:_wireInput()
		p1:_wireInputBar()
		p1:_wireTraderChat()
		print("[ChatController] initialized")
	end
end
function t2._buildGui(p1) --[[ _buildGui | Line: 124 | Upvalues: LocalPlayer (copy), v4 (copy), v2 (copy) ]]
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local ChatGui = Instance.new("ScreenGui")

	ChatGui.Name = "ChatGui"
	ChatGui.ResetOnSpawn = false
	ChatGui.IgnoreGuiInset = true
	ChatGui.DisplayOrder = 5
	ChatGui.Parent = PlayerGui
	p1._transientGui = ChatGui

	local Transient = Instance.new("Frame")

	Transient.Name = "Transient"
	Transient.Size = UDim2.new(0.36, 0, 0, 500)
	Transient.AnchorPoint = Vector2.new(0, 0.5)
	Transient.Position = UDim2.new(0, 12, 0.5, 0)
	Transient.BackgroundTransparency = 1
	Transient.BorderSizePixel = 0
	Transient.Parent = ChatGui

	local InputBar = Instance.new("Frame")

	InputBar.Name = "InputBar"
	InputBar.Size = UDim2.new(0.36, 0, 0, 40)
	InputBar.AnchorPoint = Vector2.new(0, 0)
	InputBar.Position = UDim2.new(0, 12, 0.5, 260)
	InputBar.BackgroundColor3 = Color3.fromRGB(25, 27, 24)
	InputBar.BackgroundTransparency = 0
	InputBar.BorderSizePixel = 0
	InputBar.Visible = false
	InputBar.Parent = ChatGui

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(48, 48, 48)
	UIStroke.Thickness = 1
	UIStroke.Parent = InputBar

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) })
	UIGradient.Rotation = -90
	UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) })
	UIGradient.Parent = InputBar

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingLeft = UDim.new(0, 12)
	UIPadding.PaddingRight = UDim.new(0, 12)
	UIPadding.Parent = InputBar

	local Input = Instance.new("TextBox")

	Input.Name = "Input"
	Input.Size = UDim2.fromScale(1, 1)
	Input.BackgroundTransparency = 1
	Input.PlaceholderText = "Type message..."
	Input.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
	Input.Text = ""
	Input.ClearTextOnFocus = false
	Input.MultiLine = false
	Input.TextEditable = true
	Input.TextXAlignment = Enum.TextXAlignment.Left
	Input.TextYAlignment = Enum.TextYAlignment.Center
	Input.TextColor3 = Color3.fromRGB(240, 240, 240)
	Input.TextSize = 16
	Input.FontFace = v4
	Input.Parent = InputBar

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = Color3.fromRGB(0, 0, 0)
	UIStroke2.Thickness = 1.5
	UIStroke2.Transparency = 0.4
	UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke2.Parent = Input
	p1._inputBar = InputBar
	p1._inputBox = Input

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.Padding = UDim.new(0, 6)
	UIListLayout.Parent = Transient
	p1._transientList = Transient

	local History = Instance.new("Frame")

	History.Name = "History"
	History.Size = UDim2.fromScale(0.4, 0.7)
	History.Position = UDim2.fromScale(0.5, 0.5)
	History.AnchorPoint = Vector2.new(0.5, 0.5)
	History.BackgroundColor3 = Color3.fromRGB(25, 27, 24)
	History.BackgroundTransparency = 0
	History.Visible = false
	History.Parent = ChatGui

	local UIStroke3 = Instance.new("UIStroke")

	UIStroke3.Color = Color3.fromRGB(48, 48, 48)
	UIStroke3.Thickness = 1
	UIStroke3.Parent = History

	local UIGradient2 = Instance.new("UIGradient")

	UIGradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) })
	UIGradient2.Rotation = -90
	UIGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) })
	UIGradient2.Parent = History

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 32)
	TextLabel.Position = UDim2.fromOffset(0, 0)
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 0
	TextLabel.Text = "PDA MESSAGES"
	TextLabel.FontFace = v2
	TextLabel.TextSize = 24
	TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
	TextLabel.Parent = History

	local UIGradient3 = Instance.new("UIGradient")

	UIGradient3.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) })
	UIGradient3.Rotation = -90
	UIGradient3.Parent = TextLabel

	local List = Instance.new("ScrollingFrame")

	List.Name = "List"
	List.Size = UDim2.new(1, 0, 1, -32)
	List.Position = UDim2.fromOffset(0, 32)
	List.BackgroundTransparency = 1
	List.BorderSizePixel = 0
	List.AutomaticCanvasSize = Enum.AutomaticSize.Y
	List.CanvasSize = UDim2.new()
	List.ScrollBarThickness = 6
	List.Parent = History

	local UIListLayout2 = Instance.new("UIListLayout")

	UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout2.Padding = UDim.new(0, 6)
	UIListLayout2.Parent = List

	local UIPadding2 = Instance.new("UIPadding")

	UIPadding2.PaddingTop = UDim.new(0, 8)
	UIPadding2.PaddingBottom = UDim.new(0, 8)
	UIPadding2.PaddingLeft = UDim.new(0, 8)
	UIPadding2.PaddingRight = UDim.new(0, 8)
	UIPadding2.Parent = List
	p1._historyGui = History
	p1._historyList = List
end
function t2._wireChat(p1) --[[ _wireChat | Line: 285 | Upvalues: TextChatService (copy), Players (copy), getSupporterTag (copy), ReplicatedStorage (copy) ]]
	local ChatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")

	if ChatWindowConfiguration then
		ChatWindowConfiguration.Enabled = false
	end

	local ChatInputBarConfiguration = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

	if ChatInputBarConfiguration then
		ChatInputBarConfiguration.Enabled = false
	end

	TextChatService.OnIncomingMessage = nil

	local function handleMessage(p12) --[[ handleMessage | Line: 301 | Upvalues: p1 (copy), Players (ref), getSupporterTag (ref), ReplicatedStorage (ref) ]]
		if not (p12 and p12.TextSource) then
			return
		end

		local v1 = p1

		v1._seenMessageIds = p1._seenMessageIds or {}

		local MessageId = p12.MessageId

		if MessageId then
			if p1._seenMessageIds[MessageId] then
				return
			end

			p1._seenMessageIds[MessageId] = true
		end

		local v3 = Players:GetPlayerByUserId(p12.TextSource.UserId)
		local v4 = Players:GetPlayerByUserId(p12.TextSource.UserId) and v3.DisplayName or "Unknown"
		local v5 = v3 and v3.UserId or 0
		local v6 = if v3 then v3:GetAttribute("Faction") or "Loner" else ""
		local v7 = getSupporterTag(v3)
		local Status = p12.Status

		if Status == Enum.TextChatMessageStatus.InvalidTextChannelPermissions or (Status == Enum.TextChatMessageStatus.TextFilterFailed or Status == Enum.TextChatMessageStatus.Floodchecked) then
			return
		end

		local Text = p12.Text

		if not Text or Text == "" then
			return
		end

		local function f9(p12) --[[ Line: 334 | Upvalues: p1 (ref), v4 (copy), v5 (copy), v6 (copy), v7 (copy) ]]
			local t = {
				sender = v4,
				userId = v5,
				text = p12,
				faction = v6,
				time = os.time()
			}

			t.supporterPrefix = v7 and v7.prefix
			t.supporterColorHex = v7 and v7.colorHex
			p1:_addMessage(t)
		end

		if if v3 == Players.LocalPlayer then true else false then
			task.spawn(function() --[[ Line: 346 | Upvalues: ReplicatedStorage (ref), Text (copy), f9 (copy) ]]
				local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
				local v1 = Remotes and Remotes:FindFirstChild("FilterSelfChat")
				local v2 = Text

				if v1 then
					local ok, result = pcall(function() --[[ Line: 351 | Upvalues: v1 (copy), Text (ref) ]]
						return v1:InvokeServer(Text)
					end)

					if ok and typeof(result) == "string" and result ~= "" then
						v2 = result
					end
				end

				f9(v2)
			end)
		else
			f9(Text)
		end
	end

	local function hookChannel(p1) --[[ hookChannel | Line: 365 | Upvalues: handleMessage (copy) ]]
		if not p1:IsA("TextChannel") or p1.Name ~= "RBXGeneral" and p1.Name ~= "RBXGeneralChannel" then
			return
		end

		p1.MessageReceived:Connect(handleMessage)
	end

	local TextChannels = TextChatService:WaitForChild("TextChannels")

	for i, v in ipairs(TextChannels:GetChildren()) do
		if v:IsA("TextChannel") and (v.Name == "RBXGeneral" or v.Name == "RBXGeneralChannel") then
			v.MessageReceived:Connect(handleMessage)
		end
	end

	TextChannels.ChildAdded:Connect(hookChannel)
end
function t2._wireTraderChat(p1) --[[ _wireTraderChat | Line: 375 | Upvalues: ReplicatedStorage (copy), t (copy), Workspace (copy) ]]
	local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
	local v1 = if Remotes then Remotes:FindFirstChild("TraderChatMessage") else Remotes

	if not v1 then
		return
	end

	local ok, result = pcall(require, ReplicatedStorage:WaitForChild("PdaSound"))

	if not ok then
		result = nil
	end

	v1.OnClientEvent:Connect(function(p12, p2, p3, p4) --[[ Line: 387 | Upvalues: t (ref), Workspace (ref), p1 (copy), result (ref) ]]
		if typeof(p12) ~= "string" or typeof(p2) ~= "string" then
			return
		end

		local v1 = t[p12]
		local v2, v3

		if v1 then
			v2 = v1.displayName
			v3 = v1.faction or "PDA"
		else
			local NPCs = Workspace:FindFirstChild("NPCs")
			local v4 = (if NPCs then NPCs:FindFirstChild("Traders") else NPCs) and v4:FindFirstChild(p12)

			v2, v3 = v4 and v4:GetAttribute("TraderID") or p12, "Trader"
		end

		if typeof(p3) == "string" and p3 ~= "" then
			v2 = p3
		end

		p1:_addMessage({
			userId = 0,
			sender = v2,
			npcId = p12,
			look = p4,
			text = p2,
			faction = v3,
			time = os.time()
		})

		if not result then
			return
		end

		result.Play("pda_notify")
	end)
end
function t2._wireInput(p1) --[[ _wireInput | Line: 421 | Upvalues: UserInputService (copy) ]]
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 422 | Upvalues: p1 (copy) ]]
		if p2 then
			return
		end

		if p12.KeyCode ~= Enum.KeyCode.Y then
			return
		end

		p1:_toggleHistory()
	end)
end
function t2._wireInputBar(p1) --[[ _wireInputBar | Line: 430 | Upvalues: UserInputService (copy), TextChatService (copy) ]]
	local _inputBox = p1._inputBox
	local _inputBar = p1._inputBar

	UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 434 | Upvalues: _inputBar (copy), _inputBox (copy) ]]
		if p2 then
			return
		end

		if p1.KeyCode ~= Enum.KeyCode.Slash then
			return
		end

		_inputBar.Visible = true
		task.defer(function() --[[ Line: 438 | Upvalues: _inputBox (ref) ]]
			_inputBox:CaptureFocus()
			task.wait()

			if _inputBox.Text ~= "/" then
				return
			end

			_inputBox.Text = ""
		end)
	end)
	_inputBox.FocusLost:Connect(function(p1) --[[ Line: 450 | Upvalues: _inputBox (copy), _inputBar (copy), TextChatService (ref) ]]
		local v1 = if p1 then _inputBox.Text or nil else nil

		_inputBox.Text = ""
		_inputBar.Visible = false

		if not v1 or v1 == "" then
			return
		end

		local TextChannels = TextChatService:FindFirstChild("TextChannels")
		local v2 = TextChannels and (TextChannels:FindFirstChild("RBXGeneralChannel") or TextChannels:FindFirstChild("RBXGeneral"))

		if not v2 then
			return
		end

		pcall(function() --[[ Line: 463 | Upvalues: v2 (copy), v1 (copy) ]]
			v2:SendAsync(v1)
		end)
	end)
end
function t2._toggleHistory(p1) --[[ _toggleHistory | Line: 469 ]]
	if not p1._historyGui then
		return
	end

	local v1 = not p1._historyGui.Visible

	p1._historyGui.Visible = v1

	if not v1 then
		return
	end

	task.defer(function() --[[ Line: 474 | Upvalues: p1 (copy) ]]
		if not p1._historyList then
			return
		end

		p1._historyList.CanvasPosition = Vector2.new(0, p1._historyList.AbsoluteCanvasSize.Y)
	end)
end

local function assembleRig(p1) --[[ assembleRig | Line: 496 ]]
	local list = {}

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("Motor6D") and (v.Part0 and v.Part1) then
			table.insert(list, v)
		end
	end

	for i = 1, 4 do
		for i2, v in ipairs(list) do
			v.Part1.CFrame = v.Part0.CFrame * v.C0 * v.C1:Inverse()
		end
	end
end

local function isRigAssembled(p1) --[[ isRigAssembled | Line: 512 ]]
	local Head = p1:FindFirstChild("Head")
	local v1 = p1:FindFirstChild("Torso") or p1:FindFirstChild("UpperTorso")

	if not (Head and v1) then
		return true
	end

	return (Head.Position - v1.Position).Magnitude < 8
end

local t4 = {
	ZoneLoner = "Loner",
	ZoneBandit = "Bandit"
}
local t5 = {
	Loner = "LonerOutfit",
	Bandit = "BanditLCSuit"
}
local t6 = {
	Head = true,
	Torso = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true,
	HumanoidRootPart = true
}

local function dressRig(p1, p2, p3) --[[ dressRig | Line: 560 | Upvalues: t5 (copy), ReplicatedStorage (copy), t6 (copy) ]]
	local v1 = p3 and p3.uniform or t5[p2]

	if v1 then
		local ok, result = pcall(require, ReplicatedStorage:FindFirstChild("ItemDatabase"))

		if ok and result then
			local v2 = result.GetItemData(v1)

			if v2 then
				local Shirt = p1:FindFirstChildOfClass("Shirt")
				local Pants = p1:FindFirstChildOfClass("Pants")

				if Shirt and v2.ShirtID then
					Shirt.ShirtTemplate = v2.ShirtID
				end

				if Pants and v2.PantsID then
					Pants.PantsTemplate = v2.PantsID
				end
			end
		end
	end

	local v3 = if p3 then p3.skin else p3

	if not v3 then
		return
	end

	local ok, result = pcall(require, ReplicatedStorage:FindFirstChild("StalkerVoice"))

	if not (ok and result) then
		return
	end

	local v4 = result.SKIN_TONES and result.SKIN_TONES[v3]

	if not v4 then
		return
	end

	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("BasePart") and t6[v.Name] then
			v.Color = v4
			v.Material = Enum.Material.SmoothPlastic
		end
	end
end

local function findNpcCharacter(p1) --[[ findNpcCharacter | Line: 591 | Upvalues: Workspace (copy), ReplicatedStorage (copy) ]]
	local PlayerCharacters = Workspace:FindFirstChild("PlayerCharacters")
	local v1 = if PlayerCharacters then PlayerCharacters:FindFirstChild("HostileNPCs") else PlayerCharacters

	if not v1 then
		return ReplicatedStorage:FindFirstChild("HostileNPC"), true
	end

	local t = {}

	for i, v in ipairs(v1:GetChildren()) do
		if v:IsA("Model") and (v:GetAttribute("Faction") == p1 and (v:FindFirstChild("Head") and v:FindFirstChild("HumanoidRootPart"))) then
			local Humanoid = v:FindFirstChildOfClass("Humanoid")

			if Humanoid and Humanoid.Health > 0 then
				table.insert(t, v)
			end
		end
	end

	if #t > 0 then
		return t[math.random(1, #t)], false
	end

	return ReplicatedStorage:FindFirstChild("HostileNPC"), true
end

local function makePortrait(p1, p2, p3, p4) --[[ makePortrait | Line: 613 | Upvalues: t4 (copy), ReplicatedStorage (copy), findNpcCharacter (copy), Players (copy), assembleRig (copy), dressRig (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromOffset(p2, p2)
	Frame.BackgroundColor3 = Color3.fromRGB(20, 22, 20)
	Frame.BorderSizePixel = 0

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(48, 48, 48)
	UIStroke.Thickness = 1
	UIStroke.Parent = Frame

	local function drawIcon() --[[ drawIcon | Line: 630 | Upvalues: Frame (copy) ]]
		local ImageLabel = Instance.new("ImageLabel")

		ImageLabel.Size = UDim2.fromScale(1, 1)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Image = "rbxassetid://70595759053813"
		ImageLabel.Parent = Frame

		return Frame
	end

	local v1 = nil
	local v2 = nil
	local v3

	if p3 then
		v1 = t4[p3]

		if not v1 then
			local ImageLabel = Instance.new("ImageLabel")

			ImageLabel.Size = UDim2.fromScale(1, 1)
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.Image = "rbxassetid://70595759053813"
			ImageLabel.Parent = Frame

			return Frame
		end

		if p4 and p4.model then
			local MainTaskNpcs = ReplicatedStorage:FindFirstChild("MainTaskNpcs")
			local v4 = if MainTaskNpcs then MainTaskNpcs:FindFirstChild(p4.model) else MainTaskNpcs

			if v4 and v4:IsA("Model") then
				v3 = v4
				v2 = false
			else
				local HostileNPC = ReplicatedStorage:FindFirstChild("HostileNPC")

				v3 = HostileNPC
				v2 = true
			end
		elseif p4 then
			local HostileNPC = ReplicatedStorage:FindFirstChild("HostileNPC")

			v3 = HostileNPC
			v2 = true
		else
			local v5, v6 = findNpcCharacter(v1)

			v3 = v5
			v2 = v6
		end

		if not v3 then
			local ImageLabel = Instance.new("ImageLabel")

			ImageLabel.Size = UDim2.fromScale(1, 1)
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.Image = "rbxassetid://70595759053813"
			ImageLabel.Parent = Frame

			return Frame
		end
	else
		if not p1 then
			return Frame
		end

		v3 = p1.Character
	end

	local v7 = if v3 then v3:FindFirstChild("Head") else v3
	local v8 = if v3 then v3:FindFirstChild("HumanoidRootPart") else v3

	if v3 and (v7 and v8) then
		local ViewportFrame = Instance.new("ViewportFrame")

		ViewportFrame.Size = UDim2.fromScale(1, 1)
		ViewportFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 20)
		ViewportFrame.BackgroundTransparency = 0
		ViewportFrame.BorderSizePixel = 0
		ViewportFrame.Ambient = Color3.fromRGB(180, 180, 180)
		ViewportFrame.LightColor = Color3.fromRGB(255, 255, 255)
		ViewportFrame.LightDirection = (Vector3.new(-0.3, -1, -0.5)).Unit
		ViewportFrame.Parent = Frame

		local WorldModel = Instance.new("WorldModel")

		WorldModel.Parent = ViewportFrame

		local function v9(p1) --[[ makeArchivable | Line: 706 | Upvalues: v9 (copy) ]]
			if not p1.Archivable then
				p1.Archivable = true
			end

			for i, v in ipairs(p1:GetChildren()) do
				v9(v)
			end
		end

		if not v3.Archivable then
			v3.Archivable = true
		end

		for i, v in ipairs(v3:GetChildren()) do
			v9(v)
		end

		local v11 = v3:Clone()

		for i, v in ipairs(v11:GetDescendants()) do
			if v:IsA("Script") or v:IsA("LocalScript") then
				v:Destroy()
			end
		end

		v11.Parent = WorldModel

		local Head = v11:FindFirstChild("Head")
		local v12 = v11:FindFirstChild("Torso") or v11:FindFirstChild("UpperTorso")

		if not (if Head and v12 then if (Head.Position - v12.Position).Magnitude < 8 then true else false else true) then
			assembleRig(v11)
		end

		if v2 then
			dressRig(v11, v1, p4)
		end

		for i, v in ipairs(v11:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Anchored = true
			end
		end

		local v14 = v11:FindFirstChild("Head") or v7
		local v15 = v11:FindFirstChild("HumanoidRootPart") or v8
		local Position = v14.Position
		local Camera = Instance.new("Camera")

		Camera.FieldOfView = 40
		Camera.CFrame = CFrame.new(Position + v15.CFrame.LookVector * 2.5, Position)
		Camera.Parent = ViewportFrame
		ViewportFrame.CurrentCamera = Camera
	elseif p3 then
		local ImageLabel = Instance.new("ImageLabel")

		ImageLabel.Size = UDim2.fromScale(1, 1)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Image = "rbxassetid://70595759053813"
		ImageLabel.Parent = Frame
	else
		local ImageLabel = Instance.new("ImageLabel")

		ImageLabel.Size = UDim2.fromScale(1, 1)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Parent = Frame
		task.spawn(function() --[[ Line: 682 | Upvalues: Players (ref), p1 (copy), ImageLabel (copy) ]]
			local ok, result = pcall(function() --[[ Line: 683 | Upvalues: Players (ref), p1 (ref) ]]
				return Players:GetUserThumbnailAsync(p1.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60)
			end)

			if not (ok and ImageLabel.Parent) then
				return
			end

			ImageLabel.Image = result
		end)
	end

	return Frame
end

function t2._makeEntry(p1, p2, p3, p4) --[[ _makeEntry | Line: 745 | Upvalues: makePortrait (copy), Players (copy), v3 (copy), v4 (copy) ]]
	local Msg = Instance.new("Frame")

	Msg.Name = "Msg"
	Msg.Size = UDim2.new(1, 0, 0, 68)
	Msg.AutomaticSize = Enum.AutomaticSize.Y
	Msg.BackgroundTransparency = 1
	Msg.LayoutOrder = p4 and #p1._allMessages or os.clock()
	Msg.Parent = p2

	local v2 = makePortrait(Players:GetPlayerByUserId(p3.userId or 0), 60, p3.npcId, p3.look)

	v2.Position = UDim2.fromOffset(0, 0)
	v2.Parent = Msg

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, -70, 0, 18)
	TextLabel.Position = UDim2.fromOffset(68, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v3
	TextLabel.TextSize = 15
	TextLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.RichText = true

	local sender = p3.sender

	if p3.supporterColorHex then
		sender = string.format("<font color=\"%s\">%s</font>", p3.supporterColorHex, p3.sender)
	end

	if p3.supporterPrefix and p3.supporterPrefix ~= "" then
		sender = string.format("<font color=\"%s\">%s</font> %s", p3.supporterColorHex or "#DCB43C", p3.supporterPrefix, sender)
	end

	local format = string.format
	local v5 = p3.time

	TextLabel.Text = format("%s  %s, %s", string.format("%02d:%02d", math.floor(v5 / 3600 % 24), (math.floor(v5 / 60 % 60))), sender, p3.faction)
	TextLabel.Parent = Msg

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Transparency = 0.4
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.Parent = TextLabel

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, -70, 0, 0)
	TextLabel2.Position = UDim2.fromOffset(68, 20)
	TextLabel2.AutomaticSize = Enum.AutomaticSize.Y
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v4
	TextLabel2.TextSize = 18
	TextLabel2.TextColor3 = Color3.fromRGB(230, 230, 230)
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.TextWrapped = true
	TextLabel2.Text = p3.text
	TextLabel2.Parent = Msg

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = Color3.fromRGB(0, 0, 0)
	UIStroke2.Thickness = 1.5
	UIStroke2.Transparency = 0.4
	UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke2.Parent = TextLabel2

	return Msg, v2, TextLabel, TextLabel2
end
function t2._addMessage(p1, p2) --[[ _addMessage | Line: 812 | Upvalues: t3 (copy), TweenService (copy) ]]
	if p2 and p2.text then
		local text = p2.text

		p2.text = if type(text) == "string" and text ~= "" then text:gsub("%w+", function(p13) --[[ Line: 97 | Upvalues: t3 (ref) ]]
	local v1 = p13:lower()

	for i2, v in ipairs(t3) do
		if v1:find(v, 1, true) then
			return string.rep("*", #p13)
		end
	end
end) else text
	end

	table.insert(p1._allMessages, p2)
	p1:_makeEntry(p1._historyList, p2, true)

	local v2, _, _2, _3 = p1:_makeEntry(p1._transientList, p2, false)
	local t = {}

	for i, v in ipairs(p1._transientList:GetChildren()) do
		if v:IsA("Frame") then
			table.insert(t, v)
		end
	end

	while #t > 8 do
		t[1]:Destroy()
		table.remove(t, 1)
	end

	task.delay(18, function() --[[ Line: 834 | Upvalues: v2 (copy), TweenService (ref) ]]
		if not v2.Parent then
			return
		end

		local v1 = TweenInfo.new(1.5, Enum.EasingStyle.Linear)
		local list = {}

		for i, v in ipairs(v2:GetDescendants()) do
			if v:IsA("ViewportFrame") then
				table.insert(list, TweenService:Create(v, v1, {
					ImageTransparency = 1,
					BackgroundTransparency = 1
				}))

				continue
			end

			if v:IsA("Frame") then
				if v.BackgroundTransparency < 1 then
					table.insert(list, TweenService:Create(v, v1, {
						BackgroundTransparency = 1
					}))
				end

				continue
			end

			if v:IsA("ImageLabel") then
				table.insert(list, TweenService:Create(v, v1, {
					ImageTransparency = 1,
					BackgroundTransparency = 1
				}))

				continue
			end

			if v:IsA("TextLabel") then
				table.insert(list, TweenService:Create(v, v1, {
					TextTransparency = 1,
					BackgroundTransparency = 1,
					TextStrokeTransparency = 1
				}))

				local UIStroke = v:FindFirstChildOfClass("UIStroke")

				if UIStroke then
					table.insert(list, TweenService:Create(UIStroke, v1, {
						Transparency = 1
					}))
				end

				continue
			end

			if v:IsA("UIStroke") then
				table.insert(list, TweenService:Create(v, v1, {
					Transparency = 1
				}))
			end
		end

		for i, v in ipairs(list) do
			v:Play()
		end

		task.delay(1.6, function() --[[ Line: 858 | Upvalues: v2 (ref) ]]
			if not v2.Parent then
				return
			end

			v2:Destroy()
		end)
	end)
end

return t2