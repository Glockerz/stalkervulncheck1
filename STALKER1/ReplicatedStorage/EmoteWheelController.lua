-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EmoteConfig = require(ReplicatedStorage:WaitForChild("EmoteConfig"))
local LocalPlayer = Players.LocalPlayer
local v1 = Color3.fromRGB(28, 30, 32)
local v2 = Color3.fromRGB(70, 150, 185)
local t = {
	_started = false,
	_open = false,
	_emotes = {},
	_wedges = {},
	_selection = nil,
	_tracks = {},
	_emoteConns = {}
}

local function wedgeAngle(p1) --[[ wedgeAngle | Line: 39 ]]
	return 360 / math.max(p1, 1)
end

local function angleForIndex(p1, p2) --[[ angleForIndex | Line: 43 ]]
	return (p1 - 1) * (360 / math.max(p2, 1))
end

local function indexForAngle(p1, p2) --[[ indexForAngle | Line: 47 ]]
	local v1 = 360 / math.max(p2, 1)

	return math.floor((p1 + v1 / 2) % 360 / v1) + 1
end

local function validateEmotes(p1) --[[ validateEmotes | Line: 54 | Upvalues: EmoteConfig (copy) ]]
	local t = {}

	for v4, v5 in ipairs(if p1 then p1 else {}) do
		local v3

		v3 = if type(v5) == "table" then if type(v5.name) == "string" and v5.name ~= "" then if type(v5.animId) == "string" then not v5.animId:match("^rbxassetid://%d+$") else true else true else true

		if v3 then
			warn(("[EmoteWheel] skipping entry %d: missing or malformed name/animId"):format(v4))

			continue
		end

		if #t >= EmoteConfig.MaxEmotes then
			local v6 = warn

			v6(("[EmoteWheel] skipping entry %d (%s): over MaxEmotes (%d)"):format(v4, tostring(v5.name), EmoteConfig.MaxEmotes))

			continue
		end

		t[#t + 1] = v5
	end

	return t
end

function t._buildGui(p1) --[[ _buildGui | Line: 75 | Upvalues: LocalPlayer (copy), EmoteConfig (copy), v1 (copy) ]]
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local v12 = PlayerGui:FindFirstChild(EmoteConfig.GuiName)

	if v12 then
		v12:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")

	ScreenGui.Name = EmoteConfig.GuiName
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.DisplayOrder = 30
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Enabled = false

	local Dimmer = Instance.new("Frame")

	Dimmer.Name = "Dimmer"
	Dimmer.Size = UDim2.fromScale(1, 1)
	Dimmer.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	Dimmer.BackgroundTransparency = 0.65
	Dimmer.BorderSizePixel = 0
	Dimmer.ZIndex = 1
	Dimmer.Parent = ScreenGui

	local Wheel = Instance.new("Frame")

	Wheel.Name = "Wheel"
	Wheel.AnchorPoint = Vector2.new(0.5, 0.5)
	Wheel.Position = UDim2.fromScale(0.5, 0.5)
	Wheel.Size = UDim2.fromScale(EmoteConfig.WheelScale, EmoteConfig.WheelScale)
	Wheel.BackgroundTransparency = 1
	Wheel.ZIndex = 2
	Wheel.Parent = ScreenGui

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

	UIAspectRatioConstraint.AspectRatio = 1
	UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint.Parent = Wheel

	local Centre = Instance.new("TextLabel")

	Centre.Name = "Centre"
	Centre.AnchorPoint = Vector2.new(0.5, 0.5)
	Centre.Position = UDim2.fromScale(0.5, 0.5)
	Centre.Size = UDim2.fromScale(EmoteConfig.DeadZoneScale, 0.14)
	Centre.BackgroundTransparency = 1
	Centre.Font = Enum.Font.GothamMedium
	Centre.TextScaled = true
	Centre.TextColor3 = Color3.fromRGB(200, 200, 200)
	Centre.Text = "Cancel"
	Centre.ZIndex = 5
	Centre.Parent = Wheel

	local v2 = #p1._emotes

	for i, v in ipairs(p1._emotes) do
		local v4 = math.rad((i - 1) * (360 / math.max(v2, 1)))
		local v5 = 0.5 * EmoteConfig.ButtonRadius
		local Frame = Instance.new("Frame")

		Frame.Name = "Wedge_" .. i
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.Position = UDim2.fromScale(0.5 + v5 * math.sin(v4), 0.5 - v5 * math.cos(v4))
		Frame.Size = UDim2.fromScale(0.26, 0.26)
		Frame.BackgroundColor3 = v1
		Frame.BackgroundTransparency = 0.2
		Frame.BorderSizePixel = 0
		Frame.ZIndex = 3
		Frame.Parent = Wheel

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0.5, 0)
		UICorner.Parent = Frame

		local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")

		UIAspectRatioConstraint2.AspectRatio = 1
		UIAspectRatioConstraint2.Parent = Frame

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = Color3.fromRGB(90, 90, 90)
		UIStroke.Thickness = 2
		UIStroke.Parent = Frame

		if v.icon then
			local Icon = Instance.new("ImageLabel")

			Icon.Name = "Icon"
			Icon.AnchorPoint = Vector2.new(0.5, 0.5)
			Icon.Position = UDim2.fromScale(0.5, 0.5)
			Icon.Size = UDim2.fromScale(0.6, 0.6)
			Icon.BackgroundTransparency = 1
			Icon.Image = v.icon
			Icon.ZIndex = 4
			Icon.Parent = Frame
		else
			local Label = Instance.new("TextLabel")

			Label.Name = "Label"
			Label.AnchorPoint = Vector2.new(0.5, 0.5)
			Label.Position = UDim2.fromScale(0.5, 0.5)
			Label.Size = UDim2.fromScale(0.82, 0.34)
			Label.BackgroundTransparency = 1
			Label.Font = Enum.Font.GothamMedium
			Label.TextScaled = true
			Label.TextColor3 = Color3.fromRGB(235, 235, 235)
			Label.Text = v.name
			Label.ZIndex = 4
			Label.Parent = Frame
		end

		p1._wedges[i] = {
			frame = Frame,
			stroke = UIStroke
		}
	end

	ScreenGui.Parent = PlayerGui
	p1._gui = ScreenGui
	p1._wheel = Wheel
	p1._centre = Centre
end
function t._paintSelection(p1) --[[ _paintSelection | Line: 196 | Upvalues: v2 (copy), v1 (copy) ]]
	for i, v in ipairs(p1._wedges) do
		local is_selection = i == p1._selection

		v.frame.BackgroundColor3 = is_selection and v2 or v1
		v.frame.BackgroundTransparency = if is_selection then 0.05 else 0.2
		v.stroke.Color = is_selection and Color3.fromRGB(150, 220, 245) or Color3.fromRGB(90, 90, 90)
		v.stroke.Thickness = if is_selection then 3 else 2
	end

	local v5 = p1._selection and p1._emotes[p1._selection]

	p1._centre.Text = if v5 then v5.name or "Cancel" else "Cancel"
end
function t._updateSelection(p1) --[[ _updateSelection | Line: 210 | Upvalues: GuiService (copy), UserInputService (copy), EmoteConfig (copy) ]]
	local _wheel = p1._wheel
	local v1 = #p1._emotes

	if not _wheel or v1 == 0 then
		return
	end

	local v2 = GuiService:GetGuiInset()
	local v6 = UserInputService:GetMouseLocation() + v2 - (_wheel.AbsolutePosition + _wheel.AbsoluteSize / 2)
	local v7

	if v6.Magnitude >= _wheel.AbsoluteSize.Y / 2 * EmoteConfig.DeadZoneScale then
		local v10 = math.deg((math.atan2(v6.X, -v6.Y))) % 360
		local v11 = 360 / math.max(v1, 1)

		v7 = math.floor((v10 + v11 / 2) % 360 / v11) + 1
	else
		v7 = nil
	end

	if v7 ~= p1._selection then
		p1._selection = v7
		p1:_paintSelection()
	end
end
function t._grabCursor(p1) --[[ _grabCursor | Line: 245 | Upvalues: LocalPlayer (copy), RunService (copy), UserInputService (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChild("CustomShiftLock") else Character
	local v2 = if v1 then v1:FindFirstChild("SmoothShiftLock") else v1
	local v3 = if v2 then v2:FindFirstChild("ToggleShiftLock") else v2

	p1._shiftLockWasEnabled = if LocalPlayer:GetAttribute("ShiftLockEnabled") == true then true else false

	if p1._shiftLockWasEnabled and v3 then
		v3:Fire(false)
	end

	local ok, result = pcall(function() --[[ Line: 256 | Upvalues: LocalPlayer (ref) ]]
		return require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
	end)

	if ok and result then
		p1._controls = result:GetControls()
		p1._controls:Disable()
	end

	p1._savedCameraMode = LocalPlayer.CameraMode
	LocalPlayer.CameraMode = Enum.CameraMode.Classic
	p1._mouseUnlockConn = RunService.RenderStepped:Connect(function() --[[ Line: 267 | Upvalues: UserInputService (ref) ]]
		if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end

		if UserInputService.MouseIconEnabled then
			return
		end

		UserInputService.MouseIconEnabled = true
	end)
end
function t._releaseCursor(p1) --[[ _releaseCursor | Line: 277 | Upvalues: LocalPlayer (copy), UserInputService (copy) ]]
	if p1._mouseUnlockConn then
		p1._mouseUnlockConn:Disconnect()
		p1._mouseUnlockConn = nil
	end

	if p1._savedCameraMode then
		LocalPlayer.CameraMode = p1._savedCameraMode
		p1._savedCameraMode = nil
	end

	if p1._controls then
		p1._controls:Enable()
		p1._controls = nil
	end

	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChild("CustomShiftLock") else Character
	local v2 = if v1 then v1:FindFirstChild("SmoothShiftLock") else v1
	local v3 = if v2 then v2:FindFirstChild("ToggleShiftLock") else v2

	if p1._shiftLockWasEnabled and v3 then
		v3:Fire(true)
	end

	p1._shiftLockWasEnabled = nil
	UserInputService.MouseIconEnabled = false
end
function t._canOpen(p1) --[[ _canOpen | Line: 307 | Upvalues: LocalPlayer (copy) ]]
	if p1._open then
		return false
	end

	if #p1._emotes == 0 then
		return false
	end

	if LocalPlayer:GetAttribute("UIInputLocked") == true then
		return false
	end

	local Character = LocalPlayer.Character

	if not Character then
		return false
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if Humanoid and not (Humanoid.Health <= 0) then
		local v1 = Character:GetAttribute("Stance")

		return v1 == nil or v1 == 0
	end

	return false
end
function t.Open(p1) --[[ Open | Line: 327 | Upvalues: RunService (copy) ]]
	if p1:_canOpen() then
		p1._open = true
		p1._selection = nil
		p1._gui.Enabled = true
		p1:_grabCursor()
		p1:_paintSelection()
		p1._selectionConn = RunService.RenderStepped:Connect(function() --[[ Line: 341 | Upvalues: p1 (copy) ]]
			p1:_updateSelection()
		end)
	end
end
function t.Close(p1, p2) --[[ Close | Line: 348 ]]
	if not p1._open then
		return
	end

	p1._open = false

	local v1 = p2 and p1._selection or nil

	p1._selection = nil

	if p1._selectionConn then
		p1._selectionConn:Disconnect()
		p1._selectionConn = nil
	end

	p1._gui.Enabled = false
	p1:_releaseCursor()

	if not v1 then
		return
	end

	p1:PlayEmote(v1)
end
function t.StopEmote(p1) --[[ StopEmote | Line: 371 | Upvalues: EmoteConfig (copy) ]]
	for i, v in ipairs(p1._emoteConns) do
		v:Disconnect()
	end

	table.clear(p1._emoteConns)

	if not p1._activeTrack then
		return
	end

	p1._activeTrack:Stop(EmoteConfig.BlendTime)
	p1._activeTrack = nil
end
function t._bindCancels(p1, p2) --[[ _bindCancels | Line: 385 | Upvalues: LocalPlayer (copy), EmoteConfig (copy), RunService (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = Character and Character:FindFirstChildOfClass("Humanoid")

	if not v1 then
		return
	end

	local _emoteConns = p1._emoteConns

	local function add(p1) --[[ add | Line: 391 | Upvalues: _emoteConns (copy) ]]
		_emoteConns[#_emoteConns + 1] = p1
	end

	local v2 = os.clock() + EmoteConfig.MoveCancelGrace

	_emoteConns[#_emoteConns + 1] = RunService.Heartbeat:Connect(function() --[[ Line: 397 | Upvalues: v2 (copy), v1 (copy), p1 (copy) ]]
		if os.clock() < v2 then
			return
		end

		if not (v1.MoveDirection.Magnitude > 0.05) then
			return
		end

		p1:StopEmote()
	end)
	_emoteConns[#_emoteConns + 1] = v1.StateChanged:Connect(function(p12, p2) --[[ Line: 404 | Upvalues: p1 (copy) ]]
		if p2 ~= Enum.HumanoidStateType.Jumping and p2 ~= Enum.HumanoidStateType.Freefall then
			return
		end

		p1:StopEmote()
	end)

	local Health = v1.Health

	_emoteConns[#_emoteConns + 1] = v1.HealthChanged:Connect(function(p12) --[[ Line: 412 | Upvalues: Health (ref), p1 (copy) ]]
		local v1 = p12 < Health

		Health = p12

		if not v1 then
			return
		end

		p1:StopEmote()
	end)
	_emoteConns[#_emoteConns + 1] = v1.Died:Connect(function() --[[ Line: 418 | Upvalues: p1 (copy) ]]
		p1:StopEmote()
	end)
	_emoteConns[#_emoteConns + 1] = Character.ChildAdded:Connect(function(p12) --[[ Line: 423 | Upvalues: p1 (copy) ]]
		if not p12:IsA("Tool") then
			return
		end

		p1:StopEmote()
	end)

	if p2.Looped then
		return
	end

	_emoteConns[#_emoteConns + 1] = p2.Stopped:Connect(function() --[[ Line: 435 | Upvalues: p1 (copy) ]]
		p1:StopEmote()
	end)
end
function t.PlayEmote(p1, p2) --[[ PlayEmote | Line: 441 | Upvalues: LocalPlayer (copy), EmoteConfig (copy) ]]
	local v1 = p1._emotes[p2]

	if not v1 then
		return
	end

	local Character = LocalPlayer.Character
	local v2 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
	local v3 = v2 and v2:FindFirstChildOfClass("Animator")

	if not v3 then
		return
	end

	p1:StopEmote()

	local v4 = p1._tracks[v1.animId]

	if not v4 then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = v1.animId

		local ok, result = pcall(function() --[[ Line: 456 | Upvalues: v3 (copy), Animation (copy) ]]
			return v3:LoadAnimation(Animation)
		end)

		if not (ok and result) then
			warn(("[EmoteWheel] failed to load %s (%s)"):format(v1.name, v1.animId))

			return
		end

		p1._tracks[v1.animId] = result
		v4 = result
	end

	v4.Priority = Enum.AnimationPriority.Action3
	v4.Looped = if v1.loop == true then true else false
	v4:Play(EmoteConfig.BlendTime, 1, v1.speed or 1)
	p1._activeTrack = v4
	p1:_bindCancels(v4)
end
function t.Init(p1) --[[ Init | Line: 485 | Upvalues: validateEmotes (copy), EmoteConfig (copy), UserInputService (copy), LocalPlayer (copy) ]]
	if p1._started then
		return
	end

	p1._started = true
	p1._emotes = validateEmotes(EmoteConfig.Emotes)

	if #p1._emotes == 0 then
		warn("[EmoteWheel] no valid emotes in EmoteConfig -- wheel disabled")

		return
	end

	p1:_buildGui()
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 497 | Upvalues: EmoteConfig (ref), p1 (copy) ]]
		if p2 then
			return
		end

		if p12.KeyCode ~= EmoteConfig.OpenKey then
			return
		end

		if p1._activeTrack then
			p1:StopEmote()
		else
			p1:Open()
		end
	end)
	UserInputService.InputEnded:Connect(function(p12) --[[ Line: 509 | Upvalues: EmoteConfig (ref), p1 (copy) ]]
		if p12.KeyCode == EmoteConfig.OpenKey then
			p1:Close(true)
		end
	end)

	local function hookCharacter(p12) --[[ hookCharacter | Line: 517 | Upvalues: p1 (copy) ]]
		local Humanoid = p12:WaitForChild("Humanoid", 10)

		if Humanoid then
			Humanoid.Died:Connect(function() --[[ Line: 520 | Upvalues: p1 (ref) ]]
				p1:Close(false)
				p1:StopEmote()
			end)
		end
	end

	if LocalPlayer.Character then
		task.spawn(hookCharacter, LocalPlayer.Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 530 | Upvalues: p1 (copy), hookCharacter (copy) ]]
		p1:Close(false)
		p1:StopEmote()
		table.clear(p1._tracks)
		p1._activeTrack = nil
		task.spawn(hookCharacter, p12)
	end)
	print(("[EmoteWheel] ready with %d emotes"):format(#p1._emotes))
end

return t