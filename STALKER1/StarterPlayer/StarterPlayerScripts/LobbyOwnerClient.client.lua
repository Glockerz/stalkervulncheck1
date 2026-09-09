-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local MapCatalog = require(ReplicatedStorage:WaitForChild("MapCatalog"))
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Lobby_StateChanged = Remotes:WaitForChild("Lobby_StateChanged")
local Lobby_Leave = Remotes:WaitForChild("Lobby_Leave")
local Lobby_Kick = Remotes:WaitForChild("Lobby_Kick")
local Lobby_SelectMap = Remotes:WaitForChild("Lobby_SelectMap")
local Lobby_SetAccess = Remotes:WaitForChild("Lobby_SetAccess")
local Lobby_Start = Remotes:WaitForChild("Lobby_Start")
local v1 = Color3.fromRGB(14, 15, 17)
local v2 = Color3.fromRGB(22, 23, 26)
local v3 = Color3.fromRGB(32, 33, 37)
local v4 = Color3.fromRGB(44, 45, 50)
local v5 = Color3.fromRGB(230, 230, 230)
local v6 = Color3.fromRGB(155, 155, 155)
local v7 = Color3.fromRGB(100, 100, 105)
local v8 = Color3.fromRGB(215, 175, 75)
local v9 = Color3.fromRGB(145, 115, 45)
local v10 = Color3.fromRGB(180, 60, 60)
local v11 = Color3.fromRGB(120, 190, 120)
local v12 = Color3.fromRGB(55, 58, 62)
local v13 = Color3.fromRGB(20, 15, 5)
local LobbyOwnerGui = Instance.new("ScreenGui")

LobbyOwnerGui.Name = "LobbyOwnerGui"
LobbyOwnerGui.ResetOnSpawn = false
LobbyOwnerGui.IgnoreGuiInset = false
LobbyOwnerGui.DisplayOrder = 15
LobbyOwnerGui.Enabled = false
LobbyOwnerGui.Parent = PlayerGui

local Panel = Instance.new("Frame")

Panel.Name = "Panel"
Panel.AnchorPoint = Vector2.new(1, 0.5)
Panel.Position = UDim2.new(1, -20, 0.5, 0)
Panel.Size = UDim2.fromOffset(340, 520)
Panel.BackgroundColor3 = v2
Panel.BorderSizePixel = 0
Panel.Parent = LobbyOwnerGui

local UIStroke = Instance.new("UIStroke")

UIStroke.Color = v12
UIStroke.Thickness = 1
UIStroke.Parent = Panel

local Frame = Instance.new("Frame")

Frame.Size = UDim2.new(1, 0, 0, 54)
Frame.BackgroundColor3 = v1
Frame.BorderSizePixel = 0
Frame.Parent = Panel

local Frame2 = Instance.new("Frame")

Frame2.Size = UDim2.new(1, 0, 0, 1)
Frame2.Position = UDim2.new(0, 0, 1, -1)
Frame2.BackgroundColor3 = v12
Frame2.BorderSizePixel = 0
Frame2.Parent = Frame

local TextLabel = Instance.new("TextLabel")

TextLabel.Size = UDim2.new(1, -20, 0, 20)
TextLabel.Position = UDim2.fromOffset(16, 6)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "YOUR LOBBY"
TextLabel.TextColor3 = v5
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 16
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Parent = Frame

local HostSubtitle = Instance.new("TextLabel")

HostSubtitle.Name = "HostSubtitle"
HostSubtitle.Size = UDim2.new(1, -20, 0, 14)
HostSubtitle.Position = UDim2.fromOffset(16, 28)
HostSubtitle.BackgroundTransparency = 1
HostSubtitle.Text = "HOST // \226\128\148"
HostSubtitle.TextColor3 = v8
HostSubtitle.Font = Enum.Font.GothamBold
HostSubtitle.TextSize = 10
HostSubtitle.TextXAlignment = Enum.TextXAlignment.Left
HostSubtitle.Parent = Frame

local MembersSection = Instance.new("Frame")

MembersSection.Name = "MembersSection"
MembersSection.Size = UDim2.new(1, -24, 0, 96)
MembersSection.Position = UDim2.fromOffset(12, 64)
MembersSection.BackgroundTransparency = 1
MembersSection.Parent = Panel

local TextLabel2 = Instance.new("TextLabel")

TextLabel2.Size = UDim2.new(1, 0, 0, 14)
TextLabel2.BackgroundTransparency = 1
TextLabel2.Text = "PARTY"
TextLabel2.TextColor3 = v8
TextLabel2.Font = Enum.Font.GothamBold
TextLabel2.TextSize = 10
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
TextLabel2.Parent = MembersSection

local MemberList = Instance.new("Frame")

MemberList.Name = "MemberList"
MemberList.Size = UDim2.new(1, 0, 1, -18)
MemberList.Position = UDim2.fromOffset(0, 18)
MemberList.BackgroundTransparency = 1
MemberList.Parent = MembersSection

local UIListLayout = Instance.new("UIListLayout")

UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)
UIListLayout.Parent = MemberList

local MapSection = Instance.new("Frame")

MapSection.Name = "MapSection"
MapSection.Size = UDim2.new(1, -24, 0, 130)
MapSection.Position = UDim2.fromOffset(12, 172)
MapSection.BackgroundTransparency = 1
MapSection.Parent = Panel

local TextLabel3 = Instance.new("TextLabel")

TextLabel3.Size = UDim2.new(1, 0, 0, 14)
TextLabel3.BackgroundTransparency = 1
TextLabel3.Text = "MAP"
TextLabel3.TextColor3 = v8
TextLabel3.Font = Enum.Font.GothamBold
TextLabel3.TextSize = 10
TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
TextLabel3.Parent = MapSection

local Frame3 = Instance.new("Frame")

Frame3.Size = UDim2.new(1, 0, 1, -18)
Frame3.Position = UDim2.fromOffset(0, 18)
Frame3.BackgroundTransparency = 1
Frame3.Parent = MapSection

local UIGridLayout = Instance.new("UIGridLayout")

UIGridLayout.CellSize = UDim2.new(0.5, -3, 0, 50)
UIGridLayout.CellPadding = UDim2.fromOffset(6, 6)
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.Parent = Frame3

local Frame4 = Instance.new("Frame")

Frame4.Size = UDim2.new(1, -24, 0, 60)
Frame4.Position = UDim2.fromOffset(12, 316)
Frame4.BackgroundTransparency = 1
Frame4.Parent = Panel

local TextLabel4 = Instance.new("TextLabel")

TextLabel4.Size = UDim2.new(1, 0, 0, 14)
TextLabel4.BackgroundTransparency = 1
TextLabel4.Text = "ACCESS"
TextLabel4.TextColor3 = v8
TextLabel4.Font = Enum.Font.GothamBold
TextLabel4.TextSize = 10
TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
TextLabel4.Parent = Frame4

local Frame5 = Instance.new("Frame")

Frame5.Size = UDim2.new(1, 0, 0, 38)
Frame5.Position = UDim2.fromOffset(0, 18)
Frame5.BackgroundTransparency = 1
Frame5.Parent = Frame4

local function makeAccessBtn(p1, p2, p3) --[[ makeAccessBtn | Line: 176 | Upvalues: v3 (copy), v6 (copy), Frame5 (copy), v12 (copy) ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(p2, p3, 1, 0)
	TextButton.BackgroundColor3 = v3
	TextButton.BorderSizePixel = 0
	TextButton.Text = p1
	TextButton.TextColor3 = v6
	TextButton.Font = Enum.Font.GothamBold
	TextButton.TextSize = 12
	TextButton.AutoButtonColor = false
	TextButton.Parent = Frame5

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v12
	UIStroke.Thickness = 1
	UIStroke.Parent = TextButton

	return TextButton, UIStroke
end

local v14, v15 = makeAccessBtn("OPEN", 0.5, -3)

v14.AnchorPoint = Vector2.new(0, 0)
v14.Position = UDim2.new(0, 0, 0, 0)

local v16, v17 = makeAccessBtn("FRIENDS ONLY", 0.5, -3)

v16.AnchorPoint = Vector2.new(1, 0)
v16.Position = UDim2.new(1, 0, 0, 0)
v14.MouseButton1Click:Connect(function() --[[ Line: 201 | Upvalues: Lobby_SetAccess (copy) ]]
	Lobby_SetAccess:FireServer("open")
end)
v16.MouseButton1Click:Connect(function() --[[ Line: 202 | Upvalues: Lobby_SetAccess (copy) ]]
	Lobby_SetAccess:FireServer("friends_only")
end)

local StartBtn = Instance.new("TextButton")

StartBtn.Name = "StartBtn"
StartBtn.Size = UDim2.new(1, -24, 0, 50)
StartBtn.Position = UDim2.new(0, 12, 1, -110)
StartBtn.BackgroundColor3 = v8
StartBtn.BorderSizePixel = 0
StartBtn.Text = "START"
StartBtn.TextColor3 = v13
StartBtn.Font = Enum.Font.GothamBold
StartBtn.TextSize = 18
StartBtn.AutoButtonColor = true
StartBtn.Parent = Panel

local UIStroke2 = Instance.new("UIStroke")

UIStroke2.Color = v12
UIStroke2.Thickness = 1
UIStroke2.Parent = StartBtn
StartBtn.MouseButton1Click:Connect(function() --[[ Line: 222 | Upvalues: Lobby_Start (copy) ]]
	Lobby_Start:FireServer()
end)

local LeaveBtn = Instance.new("TextButton")

LeaveBtn.Name = "LeaveBtn"
LeaveBtn.Size = UDim2.new(1, -24, 0, 38)
LeaveBtn.Position = UDim2.new(0, 12, 1, -52)
LeaveBtn.BackgroundColor3 = v3
LeaveBtn.BorderSizePixel = 0
LeaveBtn.Text = "LEAVE"
LeaveBtn.TextColor3 = v6
LeaveBtn.Font = Enum.Font.GothamBold
LeaveBtn.TextSize = 13
LeaveBtn.AutoButtonColor = true
LeaveBtn.Parent = Panel

local UIStroke3 = Instance.new("UIStroke")

UIStroke3.Color = v12
UIStroke3.Thickness = 1
UIStroke3.Parent = LeaveBtn
LeaveBtn.MouseButton1Click:Connect(function() --[[ Line: 242 | Upvalues: Lobby_Leave (copy) ]]
	Lobby_Leave:FireServer()
end)

local v18 = nil

local function renderMembers() --[[ renderMembers | Line: 246 | Upvalues: MemberList (copy), v18 (ref), v4 (copy), v3 (copy), v8 (copy), v5 (copy), v10 (copy), Lobby_Kick (copy) ]]
	for i, v in ipairs(MemberList:GetChildren()) do
		if v:IsA("Frame") and v.Name:sub(1, 4) == "Row_" then
			v:Destroy()
		end
	end

	if not v18 then
		return
	end

	for i, v in ipairs(v18.members) do
		local Frame = Instance.new("Frame")

		Frame.Name = "Row_" .. tostring(v.userId)
		Frame.LayoutOrder = i
		Frame.Size = UDim2.new(1, 0, 0, 24)
		Frame.BackgroundColor3 = v.isOwner and v4 or v3
		Frame.BorderSizePixel = 0
		Frame.Parent = MemberList

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.fromOffset(38, 24)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = if v.isOwner then "HOST" else ""
		TextLabel.TextColor3 = v8
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.TextSize = 9
		TextLabel.Parent = Frame

		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Size = UDim2.new(1, -80, 1, 0)
		TextLabel2.Position = UDim2.fromOffset(40, 0)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.Text = v.name
		TextLabel2.TextColor3 = v5
		TextLabel2.Font = Enum.Font.GothamBold
		TextLabel2.TextSize = 12
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd
		TextLabel2.Parent = Frame

		if not v.isOwner then
			local TextButton = Instance.new("TextButton")

			TextButton.Size = UDim2.fromOffset(36, 20)
			TextButton.AnchorPoint = Vector2.new(1, 0.5)
			TextButton.Position = UDim2.new(1, -4, 0.5, 0)
			TextButton.BackgroundColor3 = v10
			TextButton.BorderSizePixel = 0
			TextButton.Text = "KICK"
			TextButton.TextColor3 = Color3.fromRGB(240, 230, 225)
			TextButton.Font = Enum.Font.GothamBold
			TextButton.TextSize = 10
			TextButton.AutoButtonColor = true
			TextButton.Parent = Frame

			local userId2 = v.userId

			TextButton.MouseButton1Click:Connect(function() --[[ Line: 295 | Upvalues: Lobby_Kick (ref), userId2 (copy) ]]
				Lobby_Kick:FireServer(userId2)
			end)
		end
	end
end

local t = {}

local function ensureMapTiles() --[[ ensureMapTiles | Line: 302 | Upvalues: t (copy), MapCatalog (copy), v3 (copy), Frame3 (copy), v12 (copy), v5 (copy), v7 (copy), v6 (copy), v9 (copy), Lobby_SelectMap (copy) ]]
	if next(t) then
		return
	end

	for i, v in ipairs(MapCatalog.Maps) do
		local TextButton = Instance.new("TextButton")

		TextButton.Name = "Map_" .. v.id
		TextButton.LayoutOrder = i
		TextButton.BackgroundColor3 = v3
		TextButton.BorderSizePixel = 0
		TextButton.Text = ""
		TextButton.AutoButtonColor = v.available
		TextButton.Parent = Frame3

		local Stroke = Instance.new("UIStroke")

		Stroke.Name = "Stroke"
		Stroke.Color = v12
		Stroke.Thickness = 1
		Stroke.Parent = TextButton

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.new(1, -12, 0, 18)
		TextLabel.Position = UDim2.fromOffset(6, 6)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = v.name:upper()
		TextLabel.TextColor3 = v.available and v5 or v7
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.TextSize = 12
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.Parent = TextButton

		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Size = UDim2.new(1, -12, 0, 22)
		TextLabel2.Position = UDim2.fromOffset(6, 24)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.Text = if v.available then v.difficulty or "" else "COMING SOON"
		TextLabel2.TextColor3 = v.available and v6 or v9
		TextLabel2.Font = Enum.Font.Gotham
		TextLabel2.TextSize = 10
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel2.TextWrapped = true
		TextLabel2.Parent = TextButton

		if v.available then
			TextButton.MouseButton1Click:Connect(function() --[[ Line: 345 | Upvalues: Lobby_SelectMap (ref), v (copy) ]]
				Lobby_SelectMap:FireServer(v.id)
			end)
		end

		t[v.id] = {
			tile = TextButton,
			stroke = Stroke
		}
	end
end

local function renderMapSelection() --[[ renderMapSelection | Line: 352 | Upvalues: ensureMapTiles (copy), v18 (ref), t (copy), v8 (copy), v12 (copy) ]]
	ensureMapTiles()

	local v1 = v18 and v18.selectedMapId

	for k, v in pairs(t) do
		if k == v1 then
			v.stroke.Color = v8
			v.stroke.Thickness = 2

			continue
		end

		v.stroke.Color = v12
		v.stroke.Thickness = 1
	end
end

local function renderAccess() --[[ renderAccess | Line: 366 | Upvalues: v18 (ref), v14 (copy), v11 (copy), v3 (copy), v13 (copy), v6 (copy), v15 (copy), v12 (copy), v16 (copy), v10 (copy), v17 (copy) ]]
	local v1 = v18 and v18.accessType == "open"
	local v2 = v18 and v18.accessType == "friends_only"

	v14.BackgroundColor3 = v1 and v11 or v3
	v14.TextColor3 = v1 and v13 or v6
	v15.Color = v1 and v11 or v12
	v16.BackgroundColor3 = v2 and v10 or v3
	v16.TextColor3 = v2 and Color3.fromRGB(240, 230, 225) or v6
	v17.Color = v2 and v10 or v12
end

local function renderStartBtn() --[[ renderStartBtn | Line: 379 | Upvalues: v18 (ref), StartBtn (copy), v9 (copy), v8 (copy) ]]
	if v18 and v18.teleporting then
		StartBtn.Text = "TELEPORTING\226\128\166"
		StartBtn.BackgroundColor3 = v9
		StartBtn.AutoButtonColor = false
		StartBtn.Active = false

		return
	end

	if v18 and v18.countdownEndsAt ~= nil then
		StartBtn.Text = string.format("STARTING IN %d\226\128\166", (math.ceil((math.max(0, v18.countdownEndsAt - workspace:GetServerTimeNow())))))
		StartBtn.BackgroundColor3 = v9
		StartBtn.AutoButtonColor = false
		StartBtn.Active = false
	else
		StartBtn.Text = "START"
		StartBtn.BackgroundColor3 = v8
		StartBtn.AutoButtonColor = true
		StartBtn.Active = true
	end
end

local v19 = nil

local function syncMouseWithPanel(p1) --[[ syncMouseWithPanel | Line: 406 | Upvalues: v19 (ref), UserInputService (copy) ]]
	if p1 then
		if v19 ~= nil then
			UserInputService.MouseIconEnabled = true

			return
		end

		v19 = UserInputService.MouseIconEnabled
		UserInputService.MouseIconEnabled = true
	else
		if v19 == nil then
			return
		end

		UserInputService.MouseIconEnabled = v19
		v19 = nil
	end
end

local function render() --[[ render | Line: 418 | Upvalues: v18 (ref), LobbyOwnerGui (copy), v19 (ref), UserInputService (copy), TextLabel (copy), HostSubtitle (copy), LocalPlayer (copy), renderMembers (copy), renderMapSelection (copy), renderAccess (copy), renderStartBtn (copy) ]]
	if v18 then
		LobbyOwnerGui.Enabled = true

		if v19 ~= nil then
			UserInputService.MouseIconEnabled = true
			TextLabel.Text = "YOUR LOBBY \226\128\148 " .. v18.displayName:upper()
			HostSubtitle.Text = string.format("HOST // %s   \226\128\162   %d / %d", LocalPlayer.Name, #v18.members, v18.limit)
			renderMembers()
			renderMapSelection()
			renderAccess()
			renderStartBtn()

			return
		end

		v19 = UserInputService.MouseIconEnabled
		UserInputService.MouseIconEnabled = true
		TextLabel.Text = "YOUR LOBBY \226\128\148 " .. v18.displayName:upper()
		HostSubtitle.Text = string.format("HOST // %s   \226\128\162   %d / %d", LocalPlayer.Name, #v18.members, v18.limit)
		renderMembers()
		renderMapSelection()
		renderAccess()
		renderStartBtn()
	else
		LobbyOwnerGui.Enabled = false

		if v19 == nil then
			return
		end

		UserInputService.MouseIconEnabled = v19
		v19 = nil
	end
end

RunService.Heartbeat:Connect(function() --[[ Line: 434 | Upvalues: v18 (ref), renderStartBtn (copy) ]]
	if not (v18 and v18.countdownEndsAt) then
		return
	end

	renderStartBtn()
end)

local v20 = nil

Lobby_StateChanged.OnClientEvent:Connect(function(p1) --[[ Line: 442 | Upvalues: LocalPlayer (copy), v20 (ref), v18 (ref), render (copy), LobbyOwnerGui (copy), v19 (ref), UserInputService (copy) ]]
	if not (p1 and p1.lobbyId) then
		return
	end

	if p1.owner and (if p1.owner.userId == LocalPlayer.UserId then true else false) then
		v20 = p1.lobbyId
		v18 = p1
		render()

		return
	end

	if p1.lobbyId ~= v20 then
		return
	end

	v20 = nil
	v18 = nil
	LobbyOwnerGui.Enabled = false

	if v19 == nil then
		return
	end

	UserInputService.MouseIconEnabled = v19
	v19 = nil
end)
print("[LobbyOwnerClient] ready")