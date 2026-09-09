-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")

local ContextActionService = game:GetService("ContextActionService")
local LocalPlayer = Players.LocalPlayer
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"))
local ToastUI = require(ReplicatedStorage:WaitForChild("ToastUI"))
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
local v4 = Color3.fromRGB(255, 200, 90)
local v5 = Color3.fromRGB(28, 30, 28)
local v6 = Color3.fromRGB(220, 220, 220)
local t = {
	_gui = nil,
	_inviteCard = nil,
	_shareCard = nil
}

local function destroyInviteCard() --[[ destroyInviteCard | Line: 29 | Upvalues: ContextActionService (copy), t (copy) ]]
	pcall(function() --[[ Line: 30 | Upvalues: ContextActionService (ref) ]]
		ContextActionService:UnbindAction("SquadInviteAccept")
	end)
	pcall(function() --[[ Line: 31 | Upvalues: ContextActionService (ref) ]]
		ContextActionService:UnbindAction("SquadInviteDecline")
	end)

	if not t._inviteCard then
		return
	end

	t._inviteCard:Destroy()
	t._inviteCard = nil
end

local function ensureGui() --[[ ensureGui | Line: 38 | Upvalues: t (copy), LocalPlayer (copy) ]]
	if t._gui then
		return t._gui
	end

	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local SquadToasts = PlayerGui:FindFirstChild("SquadToasts")
	local SquadToasts2

	if not SquadToasts then
		SquadToasts2 = Instance.new("ScreenGui")
		SquadToasts2.Name = "SquadToasts"
		SquadToasts2.ResetOnSpawn = false
		SquadToasts2.IgnoreGuiInset = true
		SquadToasts2.DisplayOrder = 50
		SquadToasts2.Parent = PlayerGui
		t._gui = SquadToasts2

		return SquadToasts2
	end

	SquadToasts:Destroy()
	SquadToasts2 = Instance.new("ScreenGui")
	SquadToasts2.Name = "SquadToasts"
	SquadToasts2.ResetOnSpawn = false
	SquadToasts2.IgnoreGuiInset = true
	SquadToasts2.DisplayOrder = 50
	SquadToasts2.Parent = PlayerGui
	t._gui = SquadToasts2

	return SquadToasts2
end

local function buildInviteCard(p1) --[[ buildInviteCard | Line: 53 | Upvalues: ensureGui (copy), destroyInviteCard (copy), v5 (copy), v4 (copy), v1 (copy), v3 (copy), v6 (copy), v2 (copy), SquadController (copy), t (copy), ContextActionService (copy) ]]
	local v12 = ensureGui()

	destroyInviteCard()

	local InviteCard = Instance.new("Frame")

	InviteCard.Name = "InviteCard"
	InviteCard.AnchorPoint = Vector2.new(1, 0)
	InviteCard.Position = UDim2.new(1, -16, 0, 80)
	InviteCard.Size = UDim2.fromOffset(280, 110)
	InviteCard.BackgroundColor3 = v5
	InviteCard.BackgroundTransparency = 0.1
	InviteCard.BorderSizePixel = 0
	InviteCard.Parent = v12

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v4
	UIStroke.Thickness = 1
	UIStroke.Transparency = 0.4
	UIStroke.Parent = InviteCard

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(12, 8)
	TextLabel.Size = UDim2.new(1, -24, 0, 20)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = v4
	TextLabel.Text = "SQUAD INVITE"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = InviteCard

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(12, 30)
	TextLabel2.Size = UDim2.new(1, -24, 0, 36)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 15
	TextLabel2.TextColor3 = v6
	TextLabel2.TextWrapped = true
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.Text = (p1.fromName or "Someone") .. " invited you to their squad."
	TextLabel2.Parent = InviteCard

	local TextButton = Instance.new("TextButton")

	TextButton.Position = UDim2.new(0, 12, 1, -38)
	TextButton.Size = UDim2.fromOffset(110, 28)
	TextButton.BackgroundColor3 = v4
	TextButton.BackgroundTransparency = 0
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = true
	TextButton.FontFace = v2
	TextButton.TextSize = 14
	TextButton.TextColor3 = Color3.fromRGB(20, 20, 22)
	TextButton.Text = "[Y] ACCEPT"
	TextButton.Parent = InviteCard
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 108 | Upvalues: SquadController (ref) ]]
		SquadController:AcceptInvite()
	end)

	local TextButton2 = Instance.new("TextButton")

	TextButton2.AnchorPoint = Vector2.new(1, 0)
	TextButton2.Position = UDim2.new(1, -12, 1, -38)
	TextButton2.Size = UDim2.fromOffset(110, 28)
	TextButton2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	TextButton2.BackgroundTransparency = 0.2
	TextButton2.BorderSizePixel = 0
	TextButton2.AutoButtonColor = true
	TextButton2.FontFace = v2
	TextButton2.TextSize = 14
	TextButton2.TextColor3 = v6
	TextButton2.Text = "[N] DECLINE"
	TextButton2.Parent = InviteCard
	TextButton2.MouseButton1Click:Connect(function() --[[ Line: 125 | Upvalues: SquadController (ref) ]]
		SquadController:DeclineInvite()
	end)
	t._inviteCard = InviteCard
	ContextActionService:BindActionAtPriority("SquadInviteAccept", function(p1, p2) --[[ Line: 133 | Upvalues: SquadController (ref) ]]
		if p2 == Enum.UserInputState.Begin then
			SquadController:AcceptInvite()

			return Enum.ContextActionResult.Sink
		end

		return Enum.ContextActionResult.Pass
	end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Y)
	ContextActionService:BindActionAtPriority("SquadInviteDecline", function(p1, p2) --[[ Line: 146 | Upvalues: SquadController (ref) ]]
		if p2 == Enum.UserInputState.Begin then
			SquadController:DeclineInvite()

			return Enum.ContextActionResult.Sink
		end

		return Enum.ContextActionResult.Pass
	end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.N)
end

local function showToast(p1) --[[ showToast | Line: 162 | Upvalues: ToastUI (copy) ]]
	ToastUI.Show(p1, nil, "top-right")
end

local function destroyShareCard() --[[ destroyShareCard | Line: 166 | Upvalues: ContextActionService (copy), t (copy) ]]
	pcall(function() --[[ Line: 167 | Upvalues: ContextActionService (ref) ]]
		ContextActionService:UnbindAction("TaskShareAccept")
	end)
	pcall(function() --[[ Line: 168 | Upvalues: ContextActionService (ref) ]]
		ContextActionService:UnbindAction("TaskShareDecline")
	end)

	if not t._shareCard then
		return
	end

	t._shareCard:Destroy()
	t._shareCard = nil
end

local function buildShareCard(p1) --[[ buildShareCard | Line: 177 | Upvalues: ensureGui (copy), destroyShareCard (copy), v5 (copy), v1 (copy), v3 (copy), v6 (copy), v2 (copy), ReplicatedStorage (copy), ContextActionService (copy), t (copy) ]]
	local v12 = ensureGui()

	destroyShareCard()

	local v22 = p1.task and p1.task.id
	local v32 = Color3.fromRGB(140, 200, 120)
	local ShareCard = Instance.new("Frame")

	ShareCard.Name = "ShareCard"
	ShareCard.AnchorPoint = Vector2.new(1, 0)
	ShareCard.Position = UDim2.new(1, -16, 0, 200)
	ShareCard.Size = UDim2.fromOffset(280, 110)
	ShareCard.BackgroundColor3 = v5
	ShareCard.BackgroundTransparency = 0.1
	ShareCard.BorderSizePixel = 0
	ShareCard.Parent = v12

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v32
	UIStroke.Thickness = 1
	UIStroke.Transparency = 0.4
	UIStroke.Parent = ShareCard

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(12, 8)
	TextLabel.Size = UDim2.new(1, -24, 0, 20)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = v32
	TextLabel.Text = "TASK SHARED"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = ShareCard

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(12, 30)
	TextLabel2.Size = UDim2.new(1, -24, 0, 36)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 15
	TextLabel2.TextColor3 = v6
	TextLabel2.TextWrapped = true
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.Text = (p1.fromName or "Squadmate") .. " shared: " .. (p1.task and p1.task.title or "a task")
	TextLabel2.Parent = ShareCard

	local TextButton = Instance.new("TextButton")

	TextButton.Position = UDim2.new(0, 12, 1, -38)
	TextButton.Size = UDim2.fromOffset(110, 28)
	TextButton.BackgroundColor3 = v32
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = true
	TextButton.FontFace = v2
	TextButton.TextSize = 14
	TextButton.TextColor3 = Color3.fromRGB(20, 22, 20)
	TextButton.Text = "[Y] ACCEPT"
	TextButton.Parent = ShareCard
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 234 | Upvalues: ReplicatedStorage (ref), destroyShareCard (ref), v22 (copy) ]]
		local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))

		destroyShareCard()
		TaskController:AcceptShare(v22)
	end)

	local TextButton2 = Instance.new("TextButton")

	TextButton2.AnchorPoint = Vector2.new(1, 0)
	TextButton2.Position = UDim2.new(1, -12, 1, -38)
	TextButton2.Size = UDim2.fromOffset(110, 28)
	TextButton2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	TextButton2.BackgroundTransparency = 0.2
	TextButton2.BorderSizePixel = 0
	TextButton2.AutoButtonColor = true
	TextButton2.FontFace = v2
	TextButton2.TextSize = 14
	TextButton2.TextColor3 = v6
	TextButton2.Text = "[N] DECLINE"
	TextButton2.Parent = ShareCard
	TextButton2.MouseButton1Click:Connect(function() --[[ Line: 253 | Upvalues: ReplicatedStorage (ref), destroyShareCard (ref), v22 (copy) ]]
		local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))

		destroyShareCard()
		TaskController:DeclineShare(v22)
	end)
	ContextActionService:BindActionAtPriority("TaskShareAccept", function(p1, p2) --[[ Line: 261 | Upvalues: destroyShareCard (ref), ReplicatedStorage (ref), v22 (copy) ]]
		if p2 == Enum.UserInputState.Begin then
			destroyShareCard()
			require(ReplicatedStorage:WaitForChild("TaskController")):AcceptShare(v22)

			return Enum.ContextActionResult.Sink
		end

		return Enum.ContextActionResult.Pass
	end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Y)
	ContextActionService:BindActionAtPriority("TaskShareDecline", function(p1, p2) --[[ Line: 275 | Upvalues: destroyShareCard (ref), ReplicatedStorage (ref), v22 (copy) ]]
		if p2 == Enum.UserInputState.Begin then
			destroyShareCard()
			require(ReplicatedStorage:WaitForChild("TaskController")):DeclineShare(v22)

			return Enum.ContextActionResult.Sink
		end

		return Enum.ContextActionResult.Pass
	end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.N)
	t._shareCard = ShareCard
	task.delay(20, function() --[[ Line: 293 | Upvalues: t (ref), ShareCard (copy), destroyShareCard (ref) ]]
		if t._shareCard ~= ShareCard then
			return
		end

		destroyShareCard()
	end)
end

function t.Init(p1) --[[ Init | Line: 300 | Upvalues: ensureGui (copy), SquadController (copy), buildInviteCard (copy), destroyInviteCard (copy), showToast (copy), ReplicatedStorage (copy), buildShareCard (copy) ]]
	ensureGui()
	SquadController:OnInviteChanged(function(p1) --[[ Line: 302 | Upvalues: buildInviteCard (ref), destroyInviteCard (ref) ]]
		if p1 then
			buildInviteCard(p1)
		else
			destroyInviteCard()
		end
	end)
	SquadController:SetToastHandler(showToast)
	require(ReplicatedStorage:WaitForChild("ContactController")):SetToastHandler(showToast)

	local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))

	TaskController:SetToastHandler(showToast)
	TaskController:OnShareToast(function(p1) --[[ Line: 321 | Upvalues: buildShareCard (ref) ]]
		if not p1 then
			return
		end

		buildShareCard(p1)
	end)
end

return t