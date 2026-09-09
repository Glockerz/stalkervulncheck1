-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
local v4 = Color3.fromRGB(255, 200, 90)
local v5 = Color3.fromRGB(220, 90, 80)
local v6 = Color3.fromRGB(220, 220, 220)
local v7 = Color3.fromRGB(170, 170, 170)
local v8 = Color3.fromRGB(120, 120, 120)
local v9 = Color3.fromRGB(60, 70, 50)

Color3.fromRGB(140, 170, 90)

local v10 = Color3.fromRGB(60, 60, 60)

Color3.fromRGB(28, 30, 28)

local v11 = Color3.fromRGB(40, 42, 45)
local v12 = Color3.fromRGB(45, 48, 42)

Color3.fromRGB(35, 42, 30)

local t = {
	online = Color3.fromRGB(140, 200, 120),
	away = Color3.fromRGB(235, 165, 75),
	offline = Color3.fromRGB(120, 120, 120)
}

local function makeAvatar(p1, p2, p3, p4) --[[ makeAvatar | Line: 29 | Upvalues: v12 (copy), v1 (copy), t (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromOffset(p2, p2)
	Frame.BackgroundColor3 = v12
	Frame.BorderSizePixel = 0
	Frame.Parent = p1

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(70, 70, 70)
	UIStroke.Thickness = 1
	UIStroke.Parent = Frame

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromScale(1, 1)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = math.floor(p2 * 0.5)
	TextLabel.TextColor3 = Color3.fromRGB(170, 175, 160)
	TextLabel.Text = string.sub(p3, 1, 1):upper()
	TextLabel.Parent = Frame

	if p4 then
		local Frame2 = Instance.new("Frame")

		Frame2.AnchorPoint = Vector2.new(1, 1)
		Frame2.Position = UDim2.new(1, -2, 1, -2)
		Frame2.Size = UDim2.fromOffset(8, 8)
		Frame2.BackgroundColor3 = t[p4]
		Frame2.BorderSizePixel = 0
		Frame2.Parent = Frame

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = Frame2
	end

	return Frame
end

local function buildContactEntry(p1, p2, p3, p4) --[[ buildContactEntry | Line: 66 | Upvalues: v9 (copy), makeAvatar (copy), t (copy), v2 (copy), v6 (copy), v3 (copy), v7 (copy), v8 (copy) ]]
	local TextButton = Instance.new("TextButton")
	local v22, v32

	if p2.type == "npc" then
		v22 = p2.npcId

		if not v22 then
			v32 = p2.userId
			v22 = tostring(v32)
		end
	else
		v32 = p2.userId
		v22 = tostring(v32)
	end

	TextButton.Name = "Contact_" .. v22
	TextButton.Size = UDim2.new(1, -4, 0, 64)
	TextButton.BackgroundColor3 = v9
	TextButton.BackgroundTransparency = 1
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = false
	TextButton.Text = ""
	TextButton.LayoutOrder = p3
	TextButton.Parent = p1

	local Frame = Instance.new("Frame")

	Frame.Position = UDim2.fromOffset(8, 8)
	Frame.Size = UDim2.fromOffset(48, 48)
	Frame.BackgroundTransparency = 1
	Frame.Parent = TextButton

	local v4 = p2.type == "npc" and p2.name or p2.displayName

	makeAvatar(Frame, 48, v4)

	local Players = game:GetService("Players")
	local v5 = if p2.type == "npc" then t.online else Players:GetPlayerByUserId(p2.userId) and t.online or t.offline
	local Frame2 = Instance.new("Frame")

	Frame2.AnchorPoint = Vector2.new(0, 0.5)
	Frame2.Position = UDim2.new(0, 64, 0, 17)
	Frame2.Size = UDim2.fromOffset(7, 7)
	Frame2.BackgroundColor3 = v5
	Frame2.BorderSizePixel = 0
	Frame2.Parent = TextButton

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame2

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(76, 6)
	TextLabel.Size = UDim2.new(1, -160, 0, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 17
	TextLabel.TextColor3 = v6
	TextLabel.Text = v4
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = TextButton

	local v72 = if p2.type == "npc" then p2.role elseif p2.addedVia == "squad" then "Squad" else "Friend"
	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(76, 26)
	TextLabel2.Size = UDim2.new(1, -160, 0, 18)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 13
	TextLabel2.TextColor3 = v7
	TextLabel2.Text = v72
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = TextButton

	local v92 = if p2.type == "npc" then p2.zone .. " (" .. p2.placeName .. ")" elseif Players:GetPlayerByUserId(p2.userId) then "Online" else "Offline"
	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Position = UDim2.fromOffset(76, 42)
	TextLabel3.Size = UDim2.new(1, -160, 0, 18)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v3
	TextLabel3.TextSize = 13
	TextLabel3.TextColor3 = v8
	TextLabel3.Text = v92
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Parent = TextButton

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.AnchorPoint = Vector2.new(1, 0)
	TextLabel4.Position = UDim2.new(1, -12, 0, 8)
	TextLabel4.Size = UDim2.fromOffset(80, 20)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v2
	TextLabel4.TextSize = 13
	TextLabel4.TextColor3 = v5
	TextLabel4.Text = if p2.type == "npc" then "AVAILABLE" elseif v5 == t.online then "ONLINE" else "OFFLINE"
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel4.Parent = TextButton

	if not p4 then
		return
	end

	TextButton.MouseButton1Click:Connect(function() --[[ Line: 164 | Upvalues: p4 (copy), p2 (copy) ]]
		p4(p2)
	end)
end

local function buildSidebar(p1, p2) --[[ buildSidebar | Line: 170 | Upvalues: v1 (copy), v6 (copy), v11 (copy), v2 (copy), v7 (copy), v10 (copy), v8 (copy), buildContactEntry (copy) ]]
	local ContactController = require(game:GetService("ReplicatedStorage"):WaitForChild("ContactController"))
	local Sidebar = Instance.new("Frame")

	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0.28, 0, 1, 0)
	Sidebar.BackgroundTransparency = 1
	Sidebar.Parent = p1

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(4, 0)
	TextLabel.Size = UDim2.new(1, -8, 0, 32)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 22
	TextLabel.TextColor3 = v6
	TextLabel.Text = "CONTACTS"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Sidebar

	local Frame = Instance.new("Frame")

	Frame.Position = UDim2.fromOffset(0, 36)
	Frame.Size = UDim2.new(1, 0, 0, 30)
	Frame.BackgroundTransparency = 1
	Frame.Parent = Sidebar

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.Parent = Frame

	local v12 = "player"
	local t = {}
	local v22 = nil

	local function makeTab(p1, p2, p3) --[[ makeTab | Line: 205 | Upvalues: v11 (ref), Frame (copy), v2 (ref), v7 (ref), t (copy), v12 (ref), v22 (ref), v6 (ref) ]]
		local TextButton = Instance.new("TextButton")

		TextButton.Size = UDim2.new(0.5, -2, 1, 0)
		TextButton.BackgroundColor3 = v11
		TextButton.BackgroundTransparency = 0.5
		TextButton.BorderSizePixel = 0
		TextButton.AutoButtonColor = true
		TextButton.Text = ""
		TextButton.LayoutOrder = p2
		TextButton.Parent = Frame

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = Color3.fromRGB(80, 80, 80)
		UIStroke.Thickness = 1
		UIStroke.Parent = TextButton

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.fromScale(1, 1)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v2
		TextLabel.TextSize = 13
		TextLabel.TextColor3 = v7
		TextLabel.Text = p1
		TextLabel.Parent = TextButton
		t[p3] = {
			frame = TextButton,
			label = TextLabel,
			stroke = UIStroke
		}
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 232 | Upvalues: v12 (ref), p3 (copy), v22 (ref), t (ref), v6 (ref), v7 (ref) ]]
			v12 = p3

			if v22 then
				v22()
			end

			for k, v in pairs(t) do
				local v1 = k == p3

				v.frame.BackgroundTransparency = if v1 then 0.2 else 0.5
				v.label.TextColor3 = v1 and v6 or v7
			end
		end)
	end

	makeTab("STALKERS", 1, "player")
	makeTab("TRADERS", 2, "npc")

	local TextButton = Instance.new("TextButton")

	TextButton.AnchorPoint = Vector2.new(0, 1)
	TextButton.Position = UDim2.new(0, 0, 1, 0)
	TextButton.Size = UDim2.new(1, 0, 0, 36)
	TextButton.BackgroundColor3 = v11
	TextButton.BackgroundTransparency = 0.5
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = true
	TextButton.Text = ""
	TextButton.Parent = Sidebar

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v10
	UIStroke.Thickness = 1
	UIStroke.Parent = TextButton

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.fromScale(1, 1)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v2
	TextLabel2.TextSize = 14
	TextLabel2.TextColor3 = v7
	TextLabel2.Text = "+  ADD CONTACT"
	TextLabel2.Parent = TextButton
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 271 | Upvalues: ContactController (copy) ]]
		ContactController:PromptInviteFriends()
	end)

	local function refreshAddBtn() --[[ refreshAddBtn | Line: 275 | Upvalues: ContactController (copy), TextLabel2 (copy), v6 (ref), UIStroke (copy), v8 (ref) ]]
		if ContactController:CanInviteFriends() then
			TextLabel2.TextColor3 = v6
			UIStroke.Transparency = 0
		else
			TextLabel2.TextColor3 = v8
			UIStroke.Transparency = 0.4
		end
	end

	if ContactController:CanInviteFriends() then
		TextLabel2.TextColor3 = v6
		UIStroke.Transparency = 0
	else
		TextLabel2.TextColor3 = v8
		UIStroke.Transparency = 0.4
	end

	task.spawn(function() --[[ Line: 285 | Upvalues: Sidebar (copy), ContactController (copy), TextLabel2 (copy), v6 (ref), UIStroke (copy), v8 (ref) ]]
		while Sidebar.Parent do
			task.wait(60)

			if ContactController:CanInviteFriends() then
				TextLabel2.TextColor3 = v6
				UIStroke.Transparency = 0

				continue
			end

			TextLabel2.TextColor3 = v8
			UIStroke.Transparency = 0.4
		end
	end)

	local ContactList = Instance.new("ScrollingFrame")

	ContactList.Name = "ContactList"
	ContactList.Position = UDim2.fromOffset(0, 72)
	ContactList.Size = UDim2.new(1, 0, 1, -114)
	ContactList.BackgroundTransparency = 1
	ContactList.BorderSizePixel = 0
	ContactList.ScrollBarThickness = 4
	ContactList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ContactList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ContactList.ScrollingDirection = Enum.ScrollingDirection.Y
	ContactList.Parent = Sidebar

	local UIListLayout2 = Instance.new("UIListLayout")

	UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout2.Padding = UDim.new(0, 4)
	UIListLayout2.Parent = ContactList
	v22 = function() --[[ Line: 309 | Upvalues: ContactList (copy), ContactController (copy), v12 (ref), buildContactEntry (ref), p2 (copy) ]]
		for i, v in ipairs(ContactList:GetChildren()) do
			if v:IsA("TextButton") or v:IsA("Frame") then
				v:Destroy()
			end
		end

		for i, v in ipairs((ContactController:GetContacts(v12))) do
			buildContactEntry(ContactList, v, i, p2)
		end
	end
	t.player.frame.BackgroundTransparency = 0.2
	t.player.label.TextColor3 = v6
	v22()
	ContactController:OnChanged(function() --[[ Line: 322 | Upvalues: v22 (ref) ]]
		v22()
	end)

	return Sidebar
end

local function makeActionButton(p1, p2, p3, p4) --[[ makeActionButton | Line: 327 | Upvalues: v11 (copy), v2 (copy), v5 (copy), v6 (copy) ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(1, 0, 0, 38)
	TextButton.BackgroundColor3 = p4 and Color3.fromRGB(60, 30, 28) or v11
	TextButton.BackgroundTransparency = 0.2
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = true
	TextButton.Text = ""
	TextButton.LayoutOrder = p3
	TextButton.Parent = p1

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = p4 and Color3.fromRGB(160, 60, 50) or Color3.fromRGB(80, 80, 80)
	UIStroke.Thickness = 1
	UIStroke.Parent = TextButton

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromScale(1, 1)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = p4 and v5 or v6
	TextLabel.Text = p2
	TextLabel.Parent = TextButton

	return TextButton
end

local function buildActions(p1, p2, p3, p4) --[[ buildActions | Line: 355 | Upvalues: makeActionButton (copy) ]]
	local Actions = Instance.new("Frame")

	Actions.Name = "Actions"
	Actions.AnchorPoint = Vector2.new(1, 0)
	Actions.Position = UDim2.new(1, 0, 0, 0)
	Actions.Size = UDim2.fromOffset(170, 180)
	Actions.BackgroundTransparency = 1
	Actions.Parent = p1

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.Parent = Actions
	makeActionButton(Actions, "SEND MESSAGE", 1, false)
	makeActionButton(Actions, "MARK ON MAP", 2, false)

	local v1 = makeActionButton(Actions, "INVITE TO SQUAD", 3, false)
	local v2 = makeActionButton(Actions, "KICK FROM SQUAD", 4, true)
	local v3 = makeActionButton(Actions, "LEAVE SQUAD", 5, true)
	local SquadController = require(game:GetService("ReplicatedStorage"):WaitForChild("SquadController"))
	local LocalPlayer = game:GetService("Players").LocalPlayer

	local function refresh() --[[ refresh | Line: 379 | Upvalues: SquadController (copy), p2 (copy), LocalPlayer (copy), p3 (copy), p4 (copy), v1 (copy), v2 (copy), v3 (copy) ]]
		local v12 = SquadController:GetSquad()
		local v22 = SquadController:IsLeader()
		local isDisplayName = p2 == LocalPlayer.DisplayName
		local v32 = if v12 and p3 then if v12.members[p3] == nil then if v12.members[tostring(p3)] == nil then false else true else true else false

		if p4 then
			v1.Visible = false
			v2.Visible = false
			v3.Visible = false

			return
		end

		v1.Visible = not isDisplayName and not v32 and (not v12 or v22)
		v2.Visible = if v32 then not isDisplayName and v22 else v32
		v3.Visible = if isDisplayName then v12 ~= nil else isDisplayName
	end

	refresh()
	SquadController:OnChanged(refresh)
	v1.MouseButton1Click:Connect(function() --[[ Line: 405 | Upvalues: p3 (copy), SquadController (copy) ]]
		if not p3 then
			return
		end

		local v1 = SquadController:Invite(p3)

		if v1 and v1.ok then
			return
		end

		warn("[PdaContactsPage] Invite failed: " .. tostring(if v1 then v1.error else v1))
	end)
	v2.MouseButton1Click:Connect(function() --[[ Line: 412 | Upvalues: p3 (copy), SquadController (copy) ]]
		if p3 then
			SquadController:Kick(p3)
		end
	end)
	v3.MouseButton1Click:Connect(function() --[[ Line: 416 | Upvalues: SquadController (copy) ]]
		SquadController:Leave()
	end)
end

local function buildSquadTile(p1, p2, p3, p4) --[[ buildSquadTile | Line: 421 | Upvalues: v12 (copy), v1 (copy), v8 (copy), v2 (copy), makeAvatar (copy), t (copy), v4 (copy), v6 (copy), v3 (copy), v7 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromOffset(108, 64)
	Frame.BackgroundColor3 = v12
	Frame.BackgroundTransparency = if p4 then 1 else 0.4
	Frame.BorderSizePixel = 0
	Frame.LayoutOrder = p3
	Frame.Parent = p1

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(70, 70, 70)
	UIStroke.Thickness = 1

	if p4 then
		UIStroke.Transparency = 0.4
	end

	UIStroke.Parent = Frame

	if p4 then
		local TextLabel = Instance.new("TextLabel")

		TextLabel.AnchorPoint = Vector2.new(0, 0.5)
		TextLabel.Position = UDim2.new(0, 8, 0.5, 0)
		TextLabel.Size = UDim2.fromOffset(40, 40)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v1
		TextLabel.TextSize = 28
		TextLabel.TextColor3 = v8
		TextLabel.Text = "+"
		TextLabel.Parent = Frame

		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Position = UDim2.fromOffset(50, 0)
		TextLabel2.Size = UDim2.new(1, -55, 1, 0)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.FontFace = v2
		TextLabel2.TextSize = 14
		TextLabel2.TextColor3 = v8
		TextLabel2.Text = "Open Slot"
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.Parent = Frame

		return
	end

	local Frame2 = Instance.new("Frame")

	Frame2.Position = UDim2.fromOffset(6, 8)
	Frame2.Size = UDim2.fromOffset(48, 48)
	Frame2.BackgroundTransparency = 1
	Frame2.Parent = Frame
	makeAvatar(Frame2, 48, p2.name)

	local Frame3 = Instance.new("Frame")

	Frame3.Position = UDim2.fromOffset(60, 10)
	Frame3.Size = UDim2.fromOffset(7, 7)
	Frame3.BackgroundColor3 = t.online
	Frame3.BorderSizePixel = 0
	Frame3.Parent = Frame

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame3

	local isRole = p2.role == "Leader"
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(68, 6)
	TextLabel.Size = UDim2.fromOffset(40, 20)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = isRole and v4 or v6
	TextLabel.Text = p2.name
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(60, 28)
	TextLabel2.Size = UDim2.fromOffset(48, 18)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 12
	TextLabel2.TextColor3 = isRole and v4 or v7
	TextLabel2.Text = p2.role
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = Frame

	if not isRole then
		return
	end

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.AnchorPoint = Vector2.new(1, 0)
	TextLabel3.Position = UDim2.new(1, -4, 0, 2)
	TextLabel3.Size = UDim2.fromOffset(18, 18)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v1
	TextLabel3.TextSize = 16
	TextLabel3.TextColor3 = v4
	TextLabel3.Text = "\226\153\155"
	TextLabel3.Parent = Frame
end

local function buildDetail(p1) --[[ buildDetail | Line: 518 | Upvalues: buildActions (copy), makeAvatar (copy), v1 (copy), v6 (copy), v3 (copy), v7 (copy), v2 (copy), v8 (copy), t (copy), v10 (copy), buildSquadTile (copy) ]]
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local SquadController = require(game:GetService("ReplicatedStorage"):WaitForChild("SquadController"))
	local Detail = Instance.new("Frame")

	Detail.Name = "Detail"
	Detail.Position = UDim2.new(0.28, 16, 0, 0)
	Detail.Size = UDim2.new(0.72, -16, 1, 0)
	Detail.BackgroundTransparency = 1
	Detail.Parent = p1

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromScale(1, 1)
	Frame.BackgroundTransparency = 1
	Frame.Parent = Detail

	local function clearBody() --[[ clearBody | Line: 535 | Upvalues: Frame (copy) ]]
		for i, v in ipairs(Frame:GetChildren()) do
			v:Destroy()
		end
	end

	local function renderContact(p1) --[[ renderContact | Line: 541 | Upvalues: Frame (copy), LocalPlayer (copy), Players (copy), buildActions (ref), makeAvatar (ref), v1 (ref), v6 (ref), v3 (ref), v7 (ref), v2 (ref), v8 (ref), t (ref), v10 (ref), SquadController (copy), buildSquadTile (ref) ]]
		for i, v in ipairs(Frame:GetChildren()) do
			v:Destroy()
		end

		local v12 = if p1 then if p1.type == "npc" then true else false else p1
		local v22, v32, v4, v5, v62, v72, v82

		if p1 then
			if v12 then
				v22 = p1.name
				v32 = p1.role
				v4 = p1.faction
				v5 = p1.zone
				v62 = nil
				v72 = "\226\128\148"
				v82 = "Available"
			else
				v22 = p1.displayName

				local v9 = if p1.addedVia == "squad" then "Squadmate" else "Friend"

				v4 = "\226\128\148"
				v5 = "Unknown"

				local v102 = if Players:GetPlayerByUserId(p1.userId) then "Online" else "Offline"

				v62 = p1.userId
				v72 = "\226\128\148"
				v32 = v9
				v82 = v102
			end
		else
			v22 = LocalPlayer.DisplayName
			v5 = LocalPlayer:GetAttribute("Zone") or "Cordon"
			v62 = LocalPlayer.UserId
			v72 = "\226\128\148"
			v32 = ""
			v4 = "\226\128\148"
			v82 = "Online"
		end

		buildActions(Frame, v22, v62, v12)

		local Header = Instance.new("Frame")

		Header.Name = "Header"
		Header.Size = UDim2.new(1, -190, 0, 140)
		Header.BackgroundTransparency = 1
		Header.Parent = Frame

		local Frame2 = Instance.new("Frame")

		Frame2.Position = UDim2.fromOffset(0, 8)
		Frame2.Size = UDim2.fromOffset(110, 110)
		Frame2.BackgroundTransparency = 1
		Frame2.Parent = Header
		makeAvatar(Frame2, 110, v22)

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Position = UDim2.fromOffset(124, 8)
		TextLabel.Size = UDim2.new(1, -124, 0, 32)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v1
		TextLabel.TextSize = 26
		TextLabel.TextColor3 = v6
		TextLabel.Text = v22
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.Parent = Header

		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Position = UDim2.fromOffset(124, 38)
		TextLabel2.Size = UDim2.new(1, -124, 0, 22)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.FontFace = v3
		TextLabel2.TextSize = 16
		TextLabel2.TextColor3 = v7
		TextLabel2.Text = v32
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.Parent = Header

		local list = {
			{ "FACTION", v4 },
			{ "LOCATION", v5 },
			{ "STATUS", v82 }
		}

		if not v12 then
			table.insert(list, { "DISTANCE", v72 })
		end

		for i, v in ipairs(list) do
			local v11 = 70 + (i - 1) * 18
			local TextLabel3 = Instance.new("TextLabel")

			TextLabel3.Position = UDim2.fromOffset(124, v11)
			TextLabel3.Size = UDim2.fromOffset(96, 18)
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.FontFace = v2
			TextLabel3.TextSize = 13
			TextLabel3.TextColor3 = v8
			TextLabel3.Text = v[1]
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.Parent = Header

			local TextLabel4 = Instance.new("TextLabel")

			TextLabel4.Position = UDim2.fromOffset(220, v11)
			TextLabel4.Size = UDim2.new(1, -220, 0, 18)
			TextLabel4.BackgroundTransparency = 1
			TextLabel4.FontFace = v2
			TextLabel4.TextSize = 14
			TextLabel4.TextColor3 = v[1] == "STATUS" and t.online or v6
			TextLabel4.Text = v[2]
			TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel4.Parent = Header
		end

		local TextLabel3 = Instance.new("TextLabel")

		TextLabel3.Position = UDim2.fromOffset(0, 148)
		TextLabel3.Size = UDim2.fromOffset(120, 18)
		TextLabel3.BackgroundTransparency = 1
		TextLabel3.FontFace = v2
		TextLabel3.TextSize = 13
		TextLabel3.TextColor3 = v8
		TextLabel3.Text = "NOTES"
		TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel3.Parent = Frame

		local TextLabel4 = Instance.new("TextLabel")

		TextLabel4.Position = UDim2.fromOffset(0, 168)
		TextLabel4.Size = UDim2.new(1, 0, 0, 24)
		TextLabel4.BackgroundTransparency = 1
		TextLabel4.FontFace = v3
		TextLabel4.TextSize = 14
		TextLabel4.TextColor3 = v6

		if v12 then
			local v13 = p1.interactionCount or 1

			TextLabel4.Text = "Met " .. v13 .. " time" .. (if v13 > 1 then "s" else "")
		else
			TextLabel4.Text = ""
		end

		TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel4.Parent = Frame

		local Frame3 = Instance.new("Frame")

		Frame3.Position = UDim2.fromOffset(0, 198)
		Frame3.Size = UDim2.new(1, 0, 0, 1)
		Frame3.BackgroundColor3 = v10
		Frame3.BorderSizePixel = 0
		Frame3.Parent = Frame

		local TextLabel5 = Instance.new("TextLabel")

		TextLabel5.Position = UDim2.fromOffset(0, 210)
		TextLabel5.Size = UDim2.fromOffset(120, 18)
		TextLabel5.BackgroundTransparency = 1
		TextLabel5.FontFace = v2
		TextLabel5.TextSize = 13
		TextLabel5.TextColor3 = v8
		TextLabel5.Text = "SQUAD"
		TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel5.Parent = Frame

		local Frame4 = Instance.new("Frame")

		Frame4.Position = UDim2.fromOffset(0, 230)
		Frame4.Size = UDim2.new(1, 0, 0, 66)
		Frame4.BackgroundTransparency = 1
		Frame4.Parent = Frame

		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 6)
		UIListLayout.Parent = Frame4

		local function renderSquadTiles() --[[ renderSquadTiles | Line: 704 | Upvalues: Frame4 (copy), SquadController (ref), buildSquadTile (ref) ]]
			for i, v in ipairs(Frame4:GetChildren()) do
				if v:IsA("Frame") then
					v:Destroy()
				end
			end

			local v1 = SquadController:GetSquad()
			local t = {}

			if v1 then
				local v2 = tostring(v1.leader_id)
				local list = {}

				for k, v in pairs(v1.members) do
					table.insert(list, {
						uid = k,
						key = tostring(k),
						mem = v
					})
				end

				table.sort(list, function(p1, p2) --[[ Line: 719 | Upvalues: v2 (copy) ]]
					if p1.key == v2 then
						return true
					end

					if p2.key == v2 then
						return false
					end

					return (p1.mem.joined_at or 0) < (p2.mem.joined_at or 0)
				end)

				for i, v in ipairs(list) do
					local t2 = {
						name = v.mem.display_name
					}

					t2.role = if v.key == v2 then "Leader" else "Member"
					table.insert(t, t2)
				end
			end

			for i = 1, 4 do
				local v4 = t[i]

				if v4 then
					buildSquadTile(Frame4, v4, i, false)

					continue
				end

				buildSquadTile(Frame4, nil, i, true)
			end
		end

		renderSquadTiles()
		SquadController:OnChanged(function() --[[ Line: 741 | Upvalues: renderSquadTiles (copy) ]]
			renderSquadTiles()
		end)
	end

	renderContact(nil)

	return {
		frame = Detail,
		SelectContact = renderContact
	}
end

return {
	Build = function(p1) --[[ Build | Line: 756 | Upvalues: buildDetail (copy), buildSidebar (copy) ]]
		local Body = Instance.new("Frame")

		Body.Name = "Body"
		Body.Position = UDim2.fromOffset(16, 8)
		Body.Size = UDim2.new(1, -32, 1, -16)
		Body.BackgroundTransparency = 1
		Body.Parent = p1

		local v1 = buildDetail(Body)

		buildSidebar(Body, function(p1) --[[ Line: 765 | Upvalues: v1 (copy) ]]
			v1.SelectContact(p1)
		end)
	end
}