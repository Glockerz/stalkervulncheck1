-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera
local ok, result = pcall(function() --[[ Line: 17 | Upvalues: ReplicatedStorage (copy) ]]
	return require(ReplicatedStorage:WaitForChild("PdaSound", 5))
end)

local function sfx(p1) --[[ sfx | Line: 20 | Upvalues: ok (copy), result (copy) ]]
	if not (ok and result) then
		return
	end

	result.Play(p1)
end

local function click() --[[ click | Line: 23 | Upvalues: ok (copy), result (copy) ]]
	if not (ok and result) then
		return
	end

	result.PlayClick(5)
end

local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)

CFrame.new()

local t = { "Map", "Tasks", "Radio", "Contacts", "Reputation" }

local function findScreenPart(p1) --[[ findScreenPart | Line: 40 ]]
	local Screen = p1:FindFirstChild("Screen")

	if Screen and Screen:IsA("BasePart") then
		return Screen
	end

	if p1.PrimaryPart then
		return p1.PrimaryPart
	end

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			return v
		end
	end

	return nil
end

local function findMountPoint(p1) --[[ findMountPoint | Line: 50 ]]
	return p1:FindFirstChild("RightHand") or p1:FindFirstChild("Right Arm")
end

return {
	IsOpen = false,
	_initialized = false,
	_pdaModel = nil,
	_pdaMountPart = nil,
	_surfaceGui = nil,
	_currentTab = nil,
	_renderStepBound = nil,
	_tabButtons = nil,
	_pageFrames = nil,
	_clockLabel = nil,
	_clockTask = nil,
	_savedCamType = nil,
	_savedCamCFrame = nil,
	_savedCamFOV = nil,
	_savedCamSubject = nil,
	_savedCameraMode = nil,
	_savedCameraMinZoom = nil,
	_savedCameraMaxZoom = nil,
	_savedMouseBehavior = nil,
	_savedMouseIconEnabled = nil,
	_savedWalkSpeed = nil,
	_savedJumpPower = nil,
	_savedJumpHeight = nil,
	_savedAutoRotate = nil,
	_sphCharacterClient = nil,
	_animTrack = nil,
	_zoomedIn = false,
	_mb1Action = nil,
	_mb2Action = nil,
	_buildModel = function(p1) --[[ _buildModel | Line: 86 | Upvalues: LocalPlayer (copy), ReplicatedStorage (copy) ]]
		local Character = LocalPlayer.Character

		if not Character then
			return false
		end

		local v1 = Character:FindFirstChild("RightHand") or Character:FindFirstChild("Right Arm")

		if not v1 then
			warn("[PdaController] Player has no RightHand / Right Arm")

			return false
		end

		ReplicatedStorage:WaitForChild("PdaRemotes").OpenPda:FireServer()

		local PDA = Character:WaitForChild("PDA", 3)

		if not PDA then
			warn("[PdaController] PDA model didn\'t appear after OpenPda fire")

			return false
		end

		if PDA:WaitForChild("Screen", 3) then
			return PDA, v1
		end

		warn("[PdaController] PDA Screen didn\'t replicate after model arrived")

		return false
	end,
	_destroyModel = function(p1) --[[ _destroyModel | Line: 124 | Upvalues: ReplicatedStorage (copy) ]]
		local PdaRemotes = ReplicatedStorage:FindFirstChild("PdaRemotes")

		if not (PdaRemotes and PdaRemotes:FindFirstChild("ClosePda")) then
			p1._pdaModel = nil
			p1._pdaMountPart = nil

			return
		end

		PdaRemotes.ClosePda:FireServer()
		p1._pdaModel = nil
		p1._pdaMountPart = nil
	end,
	_buildGui = function(p1) --[[ _buildGui | Line: 136 | Upvalues: findScreenPart (copy), LocalPlayer (copy), v1 (copy), v2 (copy), t (copy), ok (copy), result (copy), ReplicatedStorage (copy), v3 (copy) ]]
		if not p1._pdaModel then
			return
		end

		local v12 = findScreenPart(p1._pdaModel)

		if not v12 then
			warn("[PdaController] No screen part found on PDA model")

			return
		end

		local PdaScreen = Instance.new("SurfaceGui")

		PdaScreen.Name = "PdaScreen"
		PdaScreen.Adornee = v12
		PdaScreen.Face = Enum.NormalId.Front
		PdaScreen.PixelsPerStud = 1562
		PdaScreen.LightInfluence = 0
		PdaScreen.ClipsDescendants = true
		PdaScreen.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
		PdaScreen.AlwaysOnTop = true
		PdaScreen.Parent = LocalPlayer.PlayerGui

		local MainFrame = Instance.new("Frame")

		MainFrame.Name = "MainFrame"
		MainFrame.Size = UDim2.fromScale(1, 1)
		MainFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 24)
		MainFrame.BackgroundTransparency = 0
		MainFrame.BorderSizePixel = 0
		MainFrame.Parent = PdaScreen

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = Color3.fromRGB(48, 48, 48)
		UIStroke.Thickness = 1
		UIStroke.Parent = MainFrame

		local UIGradient = Instance.new("UIGradient")

		UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) })
		UIGradient.Rotation = -90
		UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) })
		UIGradient.Parent = MainFrame

		local HeaderBar = Instance.new("Frame")

		HeaderBar.Name = "HeaderBar"
		HeaderBar.Size = UDim2.fromScale(1, 0.1)
		HeaderBar.Position = UDim2.fromScale(0, 0)
		HeaderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		HeaderBar.BorderSizePixel = 0
		HeaderBar.Parent = MainFrame

		local UIGradient2 = Instance.new("UIGradient")

		UIGradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) })
		UIGradient2.Rotation = -90
		UIGradient2.Parent = HeaderBar

		local UIStroke2 = Instance.new("UIStroke")

		UIStroke2.Color = Color3.fromRGB(48, 48, 48)
		UIStroke2.Thickness = 1
		UIStroke2.Parent = HeaderBar

		local Zone = Instance.new("TextLabel")

		Zone.Name = "Zone"
		Zone.Size = UDim2.fromScale(0.5, 1)
		Zone.Position = UDim2.fromOffset(22, 0)
		Zone.BackgroundTransparency = 1
		Zone.FontFace = v1
		Zone.TextSize = 36
		Zone.TextColor3 = Color3.fromRGB(220, 220, 220)
		Zone.TextXAlignment = Enum.TextXAlignment.Left
		Zone.TextYAlignment = Enum.TextYAlignment.Center
		Zone.Text = string.upper(LocalPlayer:GetAttribute("Zone") or "Cordon")
		Zone.Parent = HeaderBar

		local StatusGroup = Instance.new("Frame")

		StatusGroup.Name = "StatusGroup"
		StatusGroup.AnchorPoint = Vector2.new(1, 0)
		StatusGroup.Position = UDim2.new(1, -22, 0, 0)
		StatusGroup.Size = UDim2.fromScale(0.5, 1)
		StatusGroup.BackgroundTransparency = 1
		StatusGroup.Parent = HeaderBar

		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 22)
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Parent = StatusGroup

		local function makeBatteryIcon(p1) --[[ makeBatteryIcon | Line: 231 | Upvalues: StatusGroup (copy) ]]
			local Battery = Instance.new("Frame")

			Battery.Name = "Battery"
			Battery.Size = UDim2.fromOffset(50, 22)
			Battery.BackgroundTransparency = 1
			Battery.LayoutOrder = p1
			Battery.Parent = StatusGroup

			local Frame = Instance.new("Frame")

			Frame.Size = UDim2.fromOffset(42, 22)
			Frame.Position = UDim2.fromOffset(0, 0)
			Frame.BackgroundTransparency = 1
			Frame.BorderSizePixel = 0
			Frame.Parent = Battery

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = Color3.fromRGB(200, 230, 200)
			UIStroke.Thickness = 2
			UIStroke.Parent = Frame

			local Frame2 = Instance.new("Frame")

			Frame2.Size = UDim2.fromOffset(5, 11)
			Frame2.Position = UDim2.new(0, 43, 0.5, -5.5)
			Frame2.BackgroundColor3 = Color3.fromRGB(200, 230, 200)
			Frame2.BorderSizePixel = 0
			Frame2.Parent = Battery

			for i = 1, 3 do
				local Frame3 = Instance.new("Frame")

				Frame3.Size = UDim2.fromOffset(10, 13)
				Frame3.Position = UDim2.fromOffset((i - 1) * 12 + 3, 5)
				Frame3.BackgroundColor3 = Color3.fromRGB(200, 230, 200)
				Frame3.BorderSizePixel = 0
				Frame3.Parent = Frame
			end
		end

		local function makeSignalIcon(p1) --[[ makeSignalIcon | Line: 268 | Upvalues: StatusGroup (copy) ]]
			local Signal = Instance.new("Frame")

			Signal.Name = "Signal"
			Signal.Size = UDim2.fromOffset(44, 22)
			Signal.BackgroundTransparency = 1
			Signal.LayoutOrder = p1
			Signal.Parent = StatusGroup

			for i = 1, 4 do
				local Frame = Instance.new("Frame")

				Frame.Size = UDim2.fromOffset(8, i * 3 + 6)
				Frame.AnchorPoint = Vector2.new(0, 1)
				Frame.Position = UDim2.new(0, (i - 1) * 11, 1, -1)
				Frame.BackgroundColor3 = Color3.fromRGB(200, 230, 200)
				Frame.BorderSizePixel = 0
				Frame.Parent = Signal
			end
		end

		makeBatteryIcon(1)
		makeSignalIcon(2)

		local Clock = Instance.new("TextLabel")

		Clock.Name = "Clock"
		Clock.Size = UDim2.fromOffset(100, 36)
		Clock.BackgroundTransparency = 1
		Clock.LayoutOrder = 3
		Clock.FontFace = v2
		Clock.TextSize = 32
		Clock.TextColor3 = Color3.fromRGB(220, 220, 220)
		Clock.TextXAlignment = Enum.TextXAlignment.Right
		Clock.TextYAlignment = Enum.TextYAlignment.Center
		Clock.Parent = StatusGroup

		local v32 = os.time()

		Clock.Text = string.format("%02d:%02d", math.floor(v32 / 3600 % 24), (math.floor(v32 / 60 % 60)))
		p1._clockLabel = Clock

		local TabBar = Instance.new("Frame")

		TabBar.Name = "TabBar"
		TabBar.Size = UDim2.fromScale(1, 0.07)
		TabBar.Position = UDim2.fromScale(0, 0.1)
		TabBar.BackgroundTransparency = 1
		TabBar.Parent = MainFrame

		local UIListLayout2 = Instance.new("UIListLayout")

		UIListLayout2.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout2.Padding = UDim.new(0, 4)
		UIListLayout2.Parent = TabBar
		p1._tabButtons = {}

		for i, v in ipairs(t) do
			local TextButton = Instance.new("TextButton")

			TextButton.Name = "Tab_" .. v
			TextButton.Size = UDim2.new(1 / #t, -4, 1, 0)
			TextButton.LayoutOrder = i
			TextButton.AutoButtonColor = false
			TextButton.BackgroundColor3 = Color3.fromRGB(40, 42, 45)
			TextButton.BackgroundTransparency = 0.2
			TextButton.BorderSizePixel = 0
			TextButton.Text = string.upper(v)
			TextButton.FontFace = v2
			TextButton.TextSize = 24
			TextButton.TextColor3 = Color3.fromRGB(170, 170, 170)
			TextButton.Parent = TabBar

			local UIStroke3 = Instance.new("UIStroke")

			UIStroke3.Color = Color3.fromRGB(48, 48, 48)
			UIStroke3.Thickness = 1
			UIStroke3.Parent = TextButton
			p1._tabButtons[v] = TextButton
			TextButton.MouseButton1Click:Connect(function() --[[ Line: 341 | Upvalues: ok (ref), result (ref), p1 (copy), v (copy) ]]
				if not (ok and result) then
					p1:_setTab(v)

					return
				end

				result.PlayClick(5)
				p1:_setTab(v)
			end)
		end

		local function refreshTasksBadge() --[[ refreshTasksBadge | Line: 351 | Upvalues: p1 (copy), ReplicatedStorage (ref) ]]
			local v1 = p1._tabButtons and p1._tabButtons.Tasks

			if not v1 then
				return
			end

			local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3))
			local count = 0
			local v2

			if ok and (result and result.GetActiveTasks) then
				local v3 = result:GetActiveTasks() or {}

				v2 = #v3

				for i, v in ipairs(v3) do
					local v4 = v.objectives or {}
					local v5 = if #v4 > 0 then true else false
					local v6 = false

					for i2, v7 in ipairs(v4) do
						if v7.id == "return" or v7.id == "deliver" then
							if not v7.complete then
								v6 = true
							end

							continue
						end

						if not v7.complete then
							v5 = false
						end
					end

					local v7 = false

					for i2, v8 in ipairs(v4) do
						if v8.id == "return" or v8.id == "deliver" then
							v7 = true

							break
						end
					end

					if v5 and (v6 or not v7) then
						count = count + 1
					end
				end
			else
				v2 = 0
			end

			local v8 = if count > 0 then "! " else ""

			if v2 > 0 then
				v1.Text = string.format("%sTASKS (%d)", v8, v2)
			else
				v1.Text = "TASKS"
			end

			v1.TextColor3 = count > 0 and Color3.fromRGB(255, 220, 130) or Color3.fromRGB(170, 170, 170)
		end

		task.spawn(function() --[[ Line: 390 | Upvalues: ReplicatedStorage (ref), refreshTasksBadge (copy) ]]
			local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 5))

			if not (ok and result) then
				return
			end

			if not result.OnChanged then
				refreshTasksBadge()

				return
			end

			result:OnChanged(refreshTasksBadge)
			refreshTasksBadge()
		end)

		local ContentArea = Instance.new("Frame")

		ContentArea.Name = "ContentArea"
		ContentArea.Size = UDim2.fromScale(1, 0.83)
		ContentArea.Position = UDim2.fromScale(0, 0.17)
		ContentArea.BackgroundTransparency = 1
		ContentArea.Parent = MainFrame

		local PdaTasksPage = require(ReplicatedStorage:WaitForChild("PdaTasksPage"))
		local PdaRadioPage = require(ReplicatedStorage:WaitForChild("PdaRadioPage"))
		local PdaContactsPage = require(ReplicatedStorage:WaitForChild("PdaContactsPage"))
		local PdaReputationPage = require(ReplicatedStorage:WaitForChild("PdaReputationPage"))

		p1._pageFrames = {}

		for i, v in ipairs(t) do
			local Frame = Instance.new("Frame")

			Frame.Name = "Page_" .. v
			Frame.Size = UDim2.fromScale(1, 1)
			Frame.BackgroundTransparency = 1
			Frame.Visible = false
			Frame.Parent = ContentArea

			if v == "Tasks" then
				PdaTasksPage.Build(Frame)
			elseif v == "Radio" then
				PdaRadioPage.Build(Frame)
			elseif v == "Contacts" then
				PdaContactsPage.Build(Frame)
			elseif v == "Reputation" then
				PdaReputationPage.Build(Frame)
			elseif v == "Map" then
				require(ReplicatedStorage:WaitForChild("PdaMapPage")).Build(Frame)
			else
				local TextLabel = Instance.new("TextLabel")

				TextLabel.Size = UDim2.fromScale(1, 1)
				TextLabel.BackgroundTransparency = 1
				TextLabel.FontFace = v3
				TextLabel.TextSize = 32
				TextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
				TextLabel.Text = v .. " coming soon"
				TextLabel.Parent = Frame
			end

			p1._pageFrames[v] = Frame
		end

		p1._contentArea = ContentArea
		p1._clockTask = task.spawn(function() --[[ Line: 445 | Upvalues: p1 (copy) ]]
			while p1._clockLabel and p1._clockLabel.Parent do
				local v1 = os.time()

				p1._clockLabel.Text = string.format("%02d:%02d", math.floor(v1 / 3600 % 24), (math.floor(v1 / 60 % 60)))
				task.wait(20)
			end
		end)
		p1._surfaceGui = PdaScreen
		p1:_setTab("Map")
	end,
	_destroyGui = function(p1) --[[ _destroyGui | Line: 457 ]]
		if p1._clockTask then
			task.cancel(p1._clockTask)
			p1._clockTask = nil
		end

		p1._clockLabel = nil

		if p1._surfaceGui then
			p1._surfaceGui:Destroy()
			p1._surfaceGui = nil
		end

		p1._tabButtons = nil
		p1._contentArea = nil
		p1._pageFrames = nil
		p1._currentTab = nil
	end,
	_setTab = function(p1, p2) --[[ _setTab | Line: 470 ]]
		if not (p1._pageFrames and p1._tabButtons) then
			return
		end

		p1._currentTab = p2

		for k, v in pairs(p1._pageFrames) do
			v.Visible = k == p2
		end

		for k, v in pairs(p1._tabButtons) do
			if k == p2 then
				v.BackgroundColor3 = Color3.fromRGB(255, 200, 90)
				v.BackgroundTransparency = 0
				v.TextColor3 = Color3.fromRGB(20, 20, 22)

				continue
			end

			v.BackgroundColor3 = Color3.fromRGB(40, 42, 45)
			v.BackgroundTransparency = 0.2
			v.TextColor3 = Color3.fromRGB(170, 170, 170)
		end
	end,
	Open = function(p1) --[[ Open | Line: 491 | Upvalues: ok (copy), result (copy), LocalPlayer (copy), CurrentCamera (copy), UserInputService (copy), RunService (copy), ContextActionService (copy) ]]
		if p1.IsOpen then
			return
		end

		p1.IsOpen = true
		p1._openAt = tick()
		p1._epoch = (p1._epoch or 0) + 1

		local _epoch = p1._epoch

		if ok and result then
			result.Play("pda_draw")
		end

		local Character = LocalPlayer.Character
		local v1 = Character and Character:FindFirstChildOfClass("Humanoid")

		p1._savedCamType = CurrentCamera.CameraType
		p1._savedCamCFrame = CurrentCamera.CFrame
		p1._savedCamFOV = CurrentCamera.FieldOfView
		p1._savedCamSubject = CurrentCamera.CameraSubject
		p1._savedCameraMode = LocalPlayer.CameraMode
		p1._savedCameraMinZoom = LocalPlayer.CameraMinZoomDistance
		p1._savedCameraMaxZoom = LocalPlayer.CameraMaxZoomDistance
		p1._savedMouseBehavior = UserInputService.MouseBehavior
		p1._savedMouseIconEnabled = UserInputService.MouseIconEnabled

		if v1 then
			p1._savedWalkSpeed = v1.WalkSpeed
			p1._savedJumpPower = v1.JumpPower
			p1._savedJumpHeight = v1.JumpHeight
			p1._savedAutoRotate = v1.AutoRotate
		end

		local v2 = if Character then Character:FindFirstChild("CharacterClient", true) else Character

		if v2 then
			p1._sphCharacterClient = v2
		end

		LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
		LocalPlayer.CameraMinZoomDistance = 0
		LocalPlayer.CameraMaxZoomDistance = 0
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		UserInputService.MouseIconEnabled = false

		local v3, v4 = p1:_buildModel()

		if p1._epoch == _epoch then
			p1._pdaModel = v3 or nil
			p1._pdaMountPart = v4
			p1:_buildGui()

			if p1._epoch == _epoch then
				local v5 = if v1 then v1:FindFirstChildOfClass("Animator") else v1

				if v5 then
					if p1._animTrack then
						p1._animTrack:Stop()
						p1._animTrack:Destroy()
						p1._animTrack = nil
					end

					local Animation = Instance.new("Animation")

					Animation.AnimationId = "rbxassetid://95242444549536"
					p1._animTrack = v5:LoadAnimation(Animation)
					p1._animTrack.Looped = true
					p1._animTrack.Priority = Enum.AnimationPriority.Action4
					p1._animTrack:Play()
				end

				if not p1._renderStepBound then
					p1._renderStepBound = "PdaFreeze"
					RunService:BindToRenderStep(p1._renderStepBound, Enum.RenderPriority.Camera.Value + 100, function() --[[ Line: 579 | Upvalues: LocalPlayer (ref), p1 (copy), UserInputService (ref), CurrentCamera (ref) ]]
						if not LocalPlayer.Character then
							return
						end

						if p1._pdaModel then
							for i, v in ipairs(p1._pdaModel:GetDescendants()) do
								if v:IsA("BasePart") then
									v.LocalTransparencyModifier = 0
								end
							end
						end

						if LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
							LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
						end

						if p1._zoomedIn then
							if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
								UserInputService.MouseBehavior = Enum.MouseBehavior.Default
							end

							if not UserInputService.MouseIconEnabled then
								UserInputService.MouseIconEnabled = true
							end

							if p1._pdaModel and p1._pdaModel.PrimaryPart then
								local PrimaryPart = p1._pdaModel.PrimaryPart

								CurrentCamera.CFrame = CFrame.lookAt(PrimaryPart.Position + PrimaryPart.CFrame.LookVector * 0.6, PrimaryPart.Position, PrimaryPart.CFrame.UpVector)
							end
						else
							if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
								UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
							end

							if not UserInputService.MouseIconEnabled then
								return
							end

							UserInputService.MouseIconEnabled = false
						end
					end)
				end

				p1._mb1Action = "PdaZoomIn"
				ContextActionService:BindActionAtPriority(p1._mb1Action, function(p12, p2) --[[ Line: 619 | Upvalues: p1 (copy) ]]
					if p2 ~= Enum.UserInputState.Begin then
						return Enum.ContextActionResult.Pass
					end

					if not p1.IsOpen then
						return Enum.ContextActionResult.Pass
					end

					if p1._zoomedIn then
						return Enum.ContextActionResult.Pass
					end

					p1:_enterZoom()

					return Enum.ContextActionResult.Sink
				end, false, 250, Enum.UserInputType.MouseButton1)
				p1._mb2Action = "PdaZoomOut"
				ContextActionService:BindActionAtPriority(p1._mb2Action, function(p12, p2) --[[ Line: 630 | Upvalues: p1 (copy) ]]
					if p2 ~= Enum.UserInputState.Begin then
						return Enum.ContextActionResult.Pass
					end

					if p1.IsOpen and p1._zoomedIn then
						p1:_exitZoom()

						return Enum.ContextActionResult.Sink
					end

					return Enum.ContextActionResult.Pass
				end, false, 250, Enum.UserInputType.MouseButton2)

				if not v1 then
					return
				end

				pcall(function() --[[ Line: 642 | Upvalues: v1 (copy) ]]
					v1:UnequipTools()
				end)
			else
				if p1.IsOpen then
					return
				end

				p1:_destroyGui()
				p1:_destroyModel()
			end
		else
			if p1.IsOpen then
				return
			end

			p1:_destroyModel()
		end
	end,
	_enterZoom = function(p1) --[[ _enterZoom | Line: 646 | Upvalues: CurrentCamera (copy), LocalPlayer (copy) ]]
		if not p1.IsOpen or p1._zoomedIn then
			return
		end

		if not (p1._pdaModel and p1._pdaModel.PrimaryPart) then
			return
		end

		p1._zoomedIn = true
		CurrentCamera.CameraType = Enum.CameraType.Scriptable

		local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

		if v1 then
			v1.AutoRotate = false
		end

		if not p1._sphCharacterClient then
			return
		end

		p1._sphCharacterClient:SetAttribute("SpeedCap_Pda", 8)
	end,
	_exitZoom = function(p1) --[[ _exitZoom | Line: 664 | Upvalues: CurrentCamera (copy), LocalPlayer (copy) ]]
		if not (p1.IsOpen and p1._zoomedIn) then
			return
		end

		p1._zoomedIn = false
		CurrentCamera.CameraType = Enum.CameraType.Custom

		local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

		if v1 then
			v1.AutoRotate = true
		end

		if not p1._sphCharacterClient then
			return
		end

		p1._sphCharacterClient:SetAttribute("SpeedCap_Pda", nil)
	end,
	Close = function(p1) --[[ Close | Line: 680 | Upvalues: ok (copy), result (copy), ContextActionService (copy), RunService (copy), LocalPlayer (copy), UserInputService (copy), CurrentCamera (copy) ]]
		if not p1.IsOpen then
			return
		end

		p1._epoch = (p1._epoch or 0) + 1

		if ok and result then
			result.Play("pda_holster")
		end

		if p1._mb1Action then
			ContextActionService:UnbindAction(p1._mb1Action)
			p1._mb1Action = nil
		end

		if p1._mb2Action then
			ContextActionService:UnbindAction(p1._mb2Action)
			p1._mb2Action = nil
		end

		if p1._zoomedIn then
			p1:_exitZoom()
		end

		p1.IsOpen = false

		if p1._renderStepBound then
			RunService:UnbindFromRenderStep(p1._renderStepBound)
			p1._renderStepBound = nil
		end

		if p1._animTrack then
			p1._animTrack:Stop()
			p1._animTrack:Destroy()
			p1._animTrack = nil
		end

		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
		local v2 = if v1 then v1:FindFirstChildOfClass("Animator") else v1

		if v2 then
			for i, v in ipairs(v2:GetPlayingAnimationTracks()) do
				if v.Animation and v.Animation.AnimationId == "rbxassetid://95242444549536" then
					v:Stop(0.1)
				end
			end
		end

		p1:_destroyModel()
		p1:_destroyGui()

		if p1._sphCharacterClient then
			p1._sphCharacterClient:SetAttribute("SpeedCap_Pda", nil)
		end

		p1._sphCharacterClient = nil

		local Character2 = LocalPlayer.Character
		local v3 = if Character2 then Character2:FindFirstChildOfClass("Humanoid") else Character2

		if v3 then
			if p1._savedWalkSpeed ~= nil then
				v3.WalkSpeed = p1._savedWalkSpeed
			end

			if p1._savedJumpPower ~= nil then
				v3.JumpPower = p1._savedJumpPower
			end

			if p1._savedJumpHeight ~= nil then
				v3.JumpHeight = p1._savedJumpHeight
			end

			if p1._savedAutoRotate ~= nil then
				local Character3 = LocalPlayer.Character

				if (if Character3 then Character3:FindFirstChildOfClass("Tool") ~= nil else Character3) or p1._savedAutoRotate ~= false then
					v3.AutoRotate = p1._savedAutoRotate
				else
					v3.AutoRotate = true
				end
			end
		end

		p1._savedWalkSpeed = nil
		p1._savedJumpPower = nil
		p1._savedJumpHeight = nil
		p1._savedAutoRotate = nil

		if p1._savedMouseBehavior ~= nil then
			UserInputService.MouseBehavior = p1._savedMouseBehavior
		end

		if p1._savedMouseIconEnabled ~= nil then
			UserInputService.MouseIconEnabled = p1._savedMouseIconEnabled
		end

		p1._savedMouseBehavior = nil
		p1._savedMouseIconEnabled = nil

		local Character3 = LocalPlayer.Character

		if p1._savedCameraMode == Enum.CameraMode.LockFirstPerson and not (if Character3 then Character3:FindFirstChildOfClass("Tool") ~= nil else Character3) then
			LocalPlayer.CameraMode = Enum.CameraMode.Classic
			LocalPlayer.CameraMinZoomDistance = 0.5
			LocalPlayer.CameraMaxZoomDistance = 8
		else
			if p1._savedCameraMode ~= nil then
				LocalPlayer.CameraMode = p1._savedCameraMode
			end

			if p1._savedCameraMinZoom ~= nil then
				LocalPlayer.CameraMinZoomDistance = p1._savedCameraMinZoom
			end

			if p1._savedCameraMaxZoom ~= nil then
				LocalPlayer.CameraMaxZoomDistance = p1._savedCameraMaxZoom
			end
		end

		p1._savedCameraMode = nil
		p1._savedCameraMinZoom = nil
		p1._savedCameraMaxZoom = nil

		if v3 then
			CurrentCamera.CameraSubject = v3
		elseif p1._savedCamSubject then
			CurrentCamera.CameraSubject = p1._savedCamSubject
		end

		if p1._savedCamType ~= nil then
			CurrentCamera.CameraType = p1._savedCamType
		end

		if p1._savedCamFOV ~= nil then
			CurrentCamera.FieldOfView = p1._savedCamFOV
		end

		p1._savedCamType = nil
		p1._savedCamCFrame = nil
		p1._savedCamFOV = nil
		p1._savedCamSubject = nil
	end,
	_wireInput = function(p1) --[[ _wireInput | Line: 794 | Upvalues: ContextActionService (copy), ReplicatedStorage (copy) ]]
		ContextActionService:BindActionAtPriority("PdaToggle", function(p12, p2) --[[ Line: 797 | Upvalues: ReplicatedStorage (ref), p1 (copy) ]]
			if p2 ~= Enum.UserInputState.Begin then
				return Enum.ContextActionResult.Pass
			end

			local ok, result = pcall(require, ReplicatedStorage:FindFirstChild("NpcInteractionController"))

			if ok and (result and result.IsOpen) then
				return Enum.ContextActionResult.Pass
			end

			local ok2, result2 = pcall(require, ReplicatedStorage:FindFirstChild("TalkController"))

			if ok2 and (result2 and result2.IsOpen) then
				return Enum.ContextActionResult.Pass
			end

			if p1.IsOpen then
				p1:Close()
			else
				p1:Open()
			end

			return Enum.ContextActionResult.Sink
		end, false, 200, Enum.KeyCode.P)
	end,
	Init = function(p1) --[[ Init | Line: 822 | Upvalues: LocalPlayer (copy), ReplicatedStorage (copy) ]]
		if p1._initialized then
			return
		end

		p1._initialized = true
		p1:_wireInput()

		local function watchCharacter(p12) --[[ watchCharacter | Line: 826 | Upvalues: p1 (copy) ]]
			if p1.IsOpen then
				p1:Close()
			end

			p12.ChildAdded:Connect(function(p12) --[[ Line: 830 | Upvalues: p1 (ref) ]]
				if not (p12:IsA("Tool") and p1.IsOpen) then
					return
				end

				if p1._openAt and tick() - p1._openAt < 0.6 then
					return
				end

				p1:Close()
			end)

			local Humanoid = p12:FindFirstChildOfClass("Humanoid")

			if not Humanoid then
				return
			end

			Humanoid.Died:Connect(function() --[[ Line: 841 | Upvalues: p1 (ref) ]]
				if not p1.IsOpen then
					return
				end

				p1:Close()
			end)
		end

		if LocalPlayer.Character then
			watchCharacter(LocalPlayer.Character)
		end

		LocalPlayer.CharacterAdded:Connect(watchCharacter)
		task.spawn(function() --[[ Line: 852 | Upvalues: ReplicatedStorage (ref), p1 (copy) ]]
			local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10)

			if not Remotes then
				return
			end

			local NpcInteractionRequested = Remotes:WaitForChild("NpcInteractionRequested", 10)

			if NpcInteractionRequested then
				NpcInteractionRequested.OnClientEvent:Connect(function() --[[ Line: 857 | Upvalues: p1 (ref) ]]
					if not p1.IsOpen then
						return
					end

					p1:Close()
				end)
			end
		end)
		print("[PdaController] initialized")
	end
}