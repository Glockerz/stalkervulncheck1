-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
local v3 = nil
local v4 = nil

local function turnInReward() --[[ turnInReward | Line: 31 | Upvalues: v4 (ref) ]]
	if v4 and v4.GetDailyTurnIn then
		local v1, _, v2 = v4:GetDailyTurnIn()

		return v1, v2 or 1
	end

	return nil, 1
end

return {
	IsOpen = false,
	CurrentNPC = nil,
	CurrentProfile = nil,
	_savedCamType = nil,
	_savedCamCFrame = nil,
	_savedCamFOV = nil,
	_activeTween = nil,
	_savedWalkSpeed = nil,
	_savedJumpPower = nil,
	_savedJumpHeight = nil,
	_sphCharacterClient = nil,
	_freezeBound = nil,
	_savedTransparencies = nil,
	_savedAutoRotate = nil,
	_lockedCameraCFrame = nil,
	_savedCamSubject = nil,
	_savedMouseBehavior = nil,
	_savedMouseIconEnabled = nil,
	_hiddenPrompts = nil,
	_savedCameraMode = nil,
	_savedCameraMinZoom = nil,
	_savedCameraMaxZoom = nil,
	_savedControls = nil,
	Init = function(p1) --[[ Init | Line: 62 ]]
		if not p1.Gui then
			p1:_buildGui()
			p1:_wireRemotes()
			p1:_wireInput()
			p1:_wireDeathClose()
			p1.Gui.Enabled = false
			print("[NpcInteractionController] initialized")
		end
	end,
	_buildGui = function(p1) --[[ _buildGui | Line: 72 | Upvalues: LocalPlayer (copy), v1 (copy), v2 (copy) ]]
		local NpcInteractionGui = Instance.new("ScreenGui")

		NpcInteractionGui.Name = "NpcInteractionGui"
		NpcInteractionGui.ResetOnSpawn = false
		NpcInteractionGui.IgnoreGuiInset = true
		NpcInteractionGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		NpcInteractionGui.DisplayOrder = 4
		NpcInteractionGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

		local MainFrame = Instance.new("Frame")

		MainFrame.Name = "MainFrame"
		MainFrame.Size = UDim2.fromScale(0.25, 0.2)
		MainFrame.AnchorPoint = Vector2.new(0.5, 1)
		MainFrame.Position = UDim2.fromScale(0.5, 0.85)
		MainFrame.BackgroundTransparency = 1
		MainFrame.BorderSizePixel = 0
		MainFrame.Parent = NpcInteractionGui

		local NpcName = Instance.new("TextLabel")

		NpcName.Name = "NpcName"
		NpcName.Size = UDim2.fromScale(1, 0.25)
		NpcName.Position = UDim2.fromScale(0, 0)
		NpcName.BackgroundTransparency = 1
		NpcName.TextColor3 = Color3.fromRGB(220, 220, 220)
		NpcName.TextScaled = false
		NpcName.TextSize = 22
		NpcName.FontFace = v1
		NpcName.TextXAlignment = Enum.TextXAlignment.Center
		NpcName.TextYAlignment = Enum.TextYAlignment.Center
		NpcName.Text = "NPC"
		NpcName.Parent = MainFrame

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = Color3.fromRGB(0, 0, 0)
		UIStroke.Transparency = 0.5
		UIStroke.Thickness = 1
		UIStroke.Parent = NpcName

		local ButtonRow = Instance.new("Frame")

		ButtonRow.Name = "ButtonRow"
		ButtonRow.Size = UDim2.fromScale(1, 0.35)
		ButtonRow.Position = UDim2.fromScale(0, 0.27)
		ButtonRow.BackgroundTransparency = 1
		ButtonRow.BorderSizePixel = 0
		ButtonRow.Parent = MainFrame

		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0.06, 0)
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Parent = ButtonRow

		local function makeButton(p1, p2, p3, p4, p5, p6, p7) --[[ makeButton | Line: 126 | Upvalues: ButtonRow (copy), v2 (ref) ]]
			local TextButton = Instance.new("TextButton")

			TextButton.Name = p1
			TextButton.Size = UDim2.fromScale(p6 or 0.47, 1)
			TextButton.BackgroundColor3 = Color3.fromRGB(25, 27, 24)
			TextButton.BackgroundTransparency = 0
			TextButton.BorderSizePixel = 0
			TextButton.Text = ""
			TextButton.AutoButtonColor = false
			TextButton.LayoutOrder = p3
			TextButton.Parent = if p5 then p5 else ButtonRow

			local UIGradient = Instance.new("UIGradient")

			UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) })
			UIGradient.Rotation = -90
			UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) })
			UIGradient.Parent = TextButton

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = Color3.fromRGB(48, 48, 48)
			UIStroke.Transparency = 0
			UIStroke.Thickness = 1
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = TextButton

			local Accent = Instance.new("Frame")

			Accent.Name = "Accent"
			Accent.Size = UDim2.new(1, 0, 0, 3)
			Accent.Position = UDim2.new(0, 0, 1, -3)
			Accent.BackgroundColor3 = p4
			Accent.BackgroundTransparency = 0
			Accent.BorderSizePixel = 0
			Accent.Parent = TextButton

			local Label = Instance.new("TextLabel")

			Label.Name = "Label"
			Label.Size = UDim2.fromScale(1, 1)
			Label.Position = UDim2.fromScale(0, 0)
			Label.BackgroundTransparency = 1
			Label.Text = p2
			Label.TextColor3 = if p7 then p7 else Color3.fromRGB(255, 255, 255)
			Label.TextSize = 22
			Label.FontFace = v2
			Label.TextXAlignment = Enum.TextXAlignment.Center
			Label.TextYAlignment = Enum.TextYAlignment.Center
			Label.Parent = TextButton

			local UIStroke2 = Instance.new("UIStroke")

			UIStroke2.Color = Color3.fromRGB(0, 0, 0)
			UIStroke2.Thickness = 1.5
			UIStroke2.Transparency = 0.3
			UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
			UIStroke2.Parent = Label

			local BackgroundColor3 = TextButton.BackgroundColor3

			TextButton.MouseEnter:Connect(function() --[[ Line: 181 | Upvalues: TextButton (copy), BackgroundColor3 (copy) ]]
				TextButton.BackgroundColor3 = BackgroundColor3:Lerp(Color3.fromRGB(255, 255, 255), 0.12)
			end)
			TextButton.MouseLeave:Connect(function() --[[ Line: 184 | Upvalues: TextButton (copy), BackgroundColor3 (copy) ]]
				TextButton.BackgroundColor3 = BackgroundColor3
			end)

			return TextButton
		end

		local v12 = makeButton("TalkButton", "TALK", 1, Color3.fromRGB(220, 220, 220))
		local v22 = makeButton("TradeButton", "TRADE", 2, Color3.fromRGB(255, 200, 90))
		local v3 = makeButton("WorkButton", "WORK", 3, Color3.fromRGB(140, 220, 120))

		v3.Visible = false

		local ExitRow = Instance.new("Frame")

		ExitRow.Name = "ExitRow"
		ExitRow.Size = UDim2.fromScale(1, 0.22)
		ExitRow.Position = UDim2.fromScale(0, 0.72)
		ExitRow.BackgroundTransparency = 1
		ExitRow.BorderSizePixel = 0
		ExitRow.Parent = MainFrame

		local v4 = makeButton("ExitButton", "EXIT", 1, Color3.fromRGB(200, 60, 60), ExitRow, 0.6, Color3.fromRGB(255, 100, 100))

		v4.AnchorPoint = Vector2.new(0.5, 0)
		v4.Position = UDim2.fromScale(0.5, 0)

		local WorkPanel = Instance.new("Frame")

		WorkPanel.Name = "WorkPanel"
		WorkPanel.Size = UDim2.fromScale(0.32, 0.55)
		WorkPanel.AnchorPoint = Vector2.new(0.5, 0.5)
		WorkPanel.Position = UDim2.fromScale(0.5, 0.45)
		WorkPanel.BackgroundColor3 = Color3.fromRGB(18, 20, 18)
		WorkPanel.BackgroundTransparency = 0
		WorkPanel.BorderSizePixel = 0
		WorkPanel.Visible = false
		WorkPanel.ZIndex = 10
		WorkPanel.Parent = NpcInteractionGui

		local UIGradient = Instance.new("UIGradient")

		UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 54, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 20, 18)) })
		UIGradient.Rotation = -90
		UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 0.25) })
		UIGradient.Parent = WorkPanel

		local UIStroke2 = Instance.new("UIStroke")

		UIStroke2.Color = Color3.fromRGB(70, 75, 70)
		UIStroke2.Thickness = 1.5
		UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke2.Parent = WorkPanel

		local UIPadding = Instance.new("UIPadding")

		UIPadding.PaddingTop = UDim.new(0, 8)
		UIPadding.PaddingBottom = UDim.new(0, 8)
		UIPadding.PaddingLeft = UDim.new(0, 10)
		UIPadding.PaddingRight = UDim.new(0, 10)
		UIPadding.Parent = WorkPanel

		local TitleRow = Instance.new("Frame")

		TitleRow.Name = "TitleRow"
		TitleRow.Size = UDim2.new(1, 0, 0, 28)
		TitleRow.Position = UDim2.fromOffset(0, 0)
		TitleRow.BackgroundTransparency = 1
		TitleRow.BorderSizePixel = 0
		TitleRow.ZIndex = 10
		TitleRow.Parent = WorkPanel

		local Title = Instance.new("TextLabel")

		Title.Name = "Title"
		Title.Size = UDim2.new(1, -36, 1, 0)
		Title.Position = UDim2.fromOffset(0, 0)
		Title.BackgroundTransparency = 1
		Title.Text = "AVAILABLE WORK"
		Title.TextColor3 = Color3.fromRGB(200, 200, 200)
		Title.TextSize = 16
		Title.FontFace = v1
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.TextYAlignment = Enum.TextYAlignment.Center
		Title.ZIndex = 10
		Title.Parent = TitleRow

		local CloseBtn = Instance.new("TextButton")

		CloseBtn.Name = "CloseBtn"
		CloseBtn.Size = UDim2.fromOffset(28, 22)
		CloseBtn.AnchorPoint = Vector2.new(1, 0)
		CloseBtn.Position = UDim2.new(1, 0, 0, 0)
		CloseBtn.BackgroundColor3 = Color3.fromRGB(160, 50, 50)
		CloseBtn.BackgroundTransparency = 0.2
		CloseBtn.BorderSizePixel = 0
		CloseBtn.Text = "X"
		CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		CloseBtn.TextSize = 14
		CloseBtn.FontFace = v1
		CloseBtn.ZIndex = 10
		CloseBtn.Parent = TitleRow

		local Divider = Instance.new("Frame")

		Divider.Name = "Divider"
		Divider.Size = UDim2.new(1, 0, 0, 1)
		Divider.Position = UDim2.fromOffset(0, 34)
		Divider.BackgroundColor3 = Color3.fromRGB(80, 85, 80)
		Divider.BackgroundTransparency = 0
		Divider.BorderSizePixel = 0
		Divider.ZIndex = 10
		Divider.Parent = WorkPanel

		local Tabs = Instance.new("Frame")

		Tabs.Name = "Tabs"
		Tabs.Size = UDim2.new(1, 0, 0, 26)
		Tabs.Position = UDim2.fromOffset(0, 40)
		Tabs.BackgroundTransparency = 1
		Tabs.ZIndex = 10
		Tabs.Parent = WorkPanel

		local UIListLayout2 = Instance.new("UIListLayout")

		UIListLayout2.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout2.Padding = UDim.new(0, 6)
		UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout2.Parent = Tabs

		local function makeTab(p1, p2, p3) --[[ makeTab | Line: 310 | Upvalues: v1 (ref), Tabs (copy) ]]
			local TextButton = Instance.new("TextButton")

			TextButton.Name = p1
			TextButton.Size = UDim2.fromOffset(104, 24)
			TextButton.LayoutOrder = p3
			TextButton.BackgroundColor3 = Color3.fromRGB(40, 44, 40)
			TextButton.BorderSizePixel = 0
			TextButton.AutoButtonColor = false
			TextButton.Text = p2
			TextButton.TextColor3 = Color3.fromRGB(170, 170, 170)
			TextButton.TextSize = 12
			TextButton.FontFace = v1
			TextButton.ZIndex = 11
			TextButton.Parent = Tabs

			return TextButton
		end

		local v5 = makeTab("TabContracts", "CONTRACTS", 1)
		local v6 = makeTab("TabStory", "STORY", 2)
		local OffersScroll = Instance.new("ScrollingFrame")

		OffersScroll.Name = "OffersScroll"
		OffersScroll.Size = UDim2.new(1, 0, 1, -74)
		OffersScroll.Position = UDim2.fromOffset(0, 70)
		OffersScroll.BackgroundTransparency = 1
		OffersScroll.BorderSizePixel = 0
		OffersScroll.ScrollBarThickness = 4
		OffersScroll.ScrollBarImageColor3 = Color3.fromRGB(140, 220, 120)
		OffersScroll.CanvasSize = UDim2.fromScale(0, 0)
		OffersScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		OffersScroll.ZIndex = 10
		OffersScroll.Parent = WorkPanel

		local UIListLayout3 = Instance.new("UIListLayout")

		UIListLayout3.FillDirection = Enum.FillDirection.Vertical
		UIListLayout3.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout3.Padding = UDim.new(0, 6)
		UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout3.Parent = OffersScroll

		local UIPadding2 = Instance.new("UIPadding")

		UIPadding2.PaddingTop = UDim.new(0, 4)
		UIPadding2.PaddingBottom = UDim.new(0, 4)
		UIPadding2.Parent = OffersScroll
		p1.Gui = NpcInteractionGui
		p1.MainFrame = MainFrame
		p1.NpcName = NpcName
		p1.TalkBtn = v12
		p1.TradeBtn = v22
		p1.WorkBtn = v3
		p1.ExitBtn = v4
		p1.WorkPanel = WorkPanel
		p1.WorkOffersScroll = OffersScroll
		p1.WorkTabContracts = v5
		p1.WorkTabStory = v6
		p1._workTab = "contracts"
		v5.MouseButton1Click:Connect(function() --[[ Line: 366 | Upvalues: p1 (copy) ]]
			p1._workTab = "contracts"
			p1:OpenWorkPanel()
		end)
		v6.MouseButton1Click:Connect(function() --[[ Line: 370 | Upvalues: p1 (copy) ]]
			p1._workTab = "story"
			p1:OpenWorkPanel()
		end)
		p1._wpCloseBtn = CloseBtn
	end,
	_wireRemotes = function(p1) --[[ _wireRemotes | Line: 377 | Upvalues: ReplicatedStorage (copy) ]]
		local Remotes = ReplicatedStorage:WaitForChild("Remotes")
		local NpcInteractionRequested = Remotes:WaitForChild("NpcInteractionRequested")
		local OpenTraderFromMenu = Remotes:WaitForChild("OpenTraderFromMenu")
		local TraderClosed = Remotes:WaitForChild("TraderClosed")

		NpcInteractionRequested.OnClientEvent:Connect(function(p12, p2) --[[ Line: 383 | Upvalues: p1 (copy) ]]
			p1:Open(p12, p2)
		end)
		TraderClosed.OnClientEvent:Connect(function() --[[ Line: 387 | Upvalues: p1 (copy) ]]
			if not p1.IsOpen then
				return
			end

			p1:Close()
		end)
		p1.TradeBtn.MouseButton1Click:Connect(function() --[[ Line: 393 | Upvalues: p1 (copy), OpenTraderFromMenu (copy) ]]
			if p1.IsOpen then
				OpenTraderFromMenu:FireServer(p1.CurrentNPC)
				p1.Gui.Enabled = false
			end
		end)
		p1.TalkBtn.MouseButton1Click:Connect(function() --[[ Line: 399 | Upvalues: p1 (copy), ReplicatedStorage (ref) ]]
			if not p1.IsOpen then
				return
			end

			local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1))

			if not (ok and result) then
				return
			end

			result:Open(p1.CurrentNPC, p1.CurrentProfile)
			p1.Gui.Enabled = false
		end)
		p1.ExitBtn.MouseButton1Click:Connect(function() --[[ Line: 408 | Upvalues: p1 (copy) ]]
			if p1.IsOpen then
				p1:Close()
			end
		end)
		p1.WorkBtn.MouseButton1Click:Connect(function() --[[ Line: 413 | Upvalues: p1 (copy) ]]
			if p1.IsOpen then
				p1:OpenWorkPanel()
			end
		end)
		p1._wpCloseBtn.MouseButton1Click:Connect(function() --[[ Line: 418 | Upvalues: p1 (copy) ]]
			if not p1.WorkPanel then
				return
			end

			p1.WorkPanel.Visible = false
		end)
	end,
	_wireInput = function(p1) --[[ _wireInput | Line: 425 ]] end,
	Open = function(p1, p2, p3) --[[ Open | Line: 428 | Upvalues: LocalPlayer (copy), UserInputService (copy), RunService (copy), CurrentCamera (copy), ContextActionService (copy) ]]
		if p1.IsOpen then
			return
		end

		p1.IsOpen = true

		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

		if v1 then
			p1._savedWalkSpeed = v1.WalkSpeed
			p1._savedJumpPower = v1.JumpPower
			p1._savedJumpHeight = v1.JumpHeight
			p1._savedAutoRotate = v1.AutoRotate
			v1.WalkSpeed = 0
			v1.JumpPower = 0
			v1.JumpHeight = 0
			v1.AutoRotate = false
		end

		local ok, result = pcall(function() --[[ Line: 450 | Upvalues: LocalPlayer (ref) ]]
			return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
		end)

		if ok and result then
			p1._savedControls = result
			result:Disable()
		end

		p1._savedMouseBehavior = UserInputService.MouseBehavior
		p1._savedMouseIconEnabled = UserInputService.MouseIconEnabled
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		UserInputService.MouseIconEnabled = true
		p1._savedCameraMode = LocalPlayer.CameraMode
		p1._savedCameraMinZoom = LocalPlayer.CameraMinZoomDistance
		p1._savedCameraMaxZoom = LocalPlayer.CameraMaxZoomDistance
		LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
		LocalPlayer.CameraMinZoomDistance = 0
		LocalPlayer.CameraMaxZoomDistance = 0

		local v2 = if Character then Character:FindFirstChild("CharacterClient", true) else Character

		if v2 then
			v2:SetAttribute("SpeedCap_Dialogue", 0)
			p1._sphCharacterClient = v2
		else
			warn("[NpcInteractionController] SPH CharacterClient not found; relying on RenderStepped freeze only")
		end

		if not p1._freezeBound then
			p1._freezeBound = "NpcInteractionFreeze"
			RunService:BindToRenderStep(p1._freezeBound, Enum.RenderPriority.Camera.Value + 100, function() --[[ Line: 483 | Upvalues: LocalPlayer (ref), CurrentCamera (ref), p1 (copy), UserInputService (ref) ]]
				local Character = LocalPlayer.Character

				if not Character then
					return
				end

				local Humanoid = Character:FindFirstChildOfClass("Humanoid")

				if Humanoid then
					Humanoid.WalkSpeed = 0
					Humanoid.JumpPower = 0
					Humanoid.JumpHeight = 0
					Humanoid.AutoRotate = false
				end

				for i, v in ipairs(Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.LocalTransparencyModifier = 1
					end
				end

				if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
					CurrentCamera.CameraType = Enum.CameraType.Scriptable
				end

				if p1._lockedCameraCFrame then
					CurrentCamera.CFrame = p1._lockedCameraCFrame
				end

				if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				end

				if UserInputService.MouseIconEnabled then
					return
				end

				UserInputService.MouseIconEnabled = true
			end)
		end

		if p2 then
			p1._hiddenPrompts = {}

			for i, v in ipairs(p2:GetDescendants()) do
				if v:IsA("ProximityPrompt") and v.Enabled then
					p1._hiddenPrompts[v] = true
					v.Enabled = false
				end
			end
		end

		p1.CurrentNPC = p2
		p1.CurrentProfile = p3

		local v3 = if p2 then if p2:GetAttribute("NpcType") == "Extractor" then true else false else p2
		local v4 = LocalPlayer:GetAttribute("_TutorialPending") and (not LocalPlayer:GetAttribute("_StarterPackGranted") and (if p2 then if p2.Name == "Crow" then true else false else p2))

		if p1.TradeBtn then
			p1.TradeBtn.Visible = not v3 and not v4
		end

		if p1.WorkBtn then
			p1.WorkBtn.Visible = false

			if not (v3 or v4) then
				task.spawn(function() --[[ Line: 549 | Upvalues: p2 (copy), p1 (copy) ]]
					local TaskController = require(game:GetService("ReplicatedStorage"):WaitForChild("TaskController"))
					local v1 = TaskController:RequestOffers(p2) or {}
					local v2 = v1.offers and (if #v1.offers > 0 then true else false)
					local v3 = if v1.cooldown_until == nil then false else true
					local v4 = false

					for i, v in ipairs(TaskController:GetActiveTasks()) do
						local v5

						v5 = if v.type == "delivery" then v.params and v.params.destination_npc == p2.Name else v.giver and v.giver.npcId == p2.Name

						if v5 then
							v4 = true

							break
						end
					end

					local v8 = if p2.Name == "Ecologist" then TaskController.GetDaily and (if TaskController:GetDaily() == nil then false else true) else false
					local v9 = false

					if p2.Name == "Ecologist" then
						local GetPendingRewards = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("GetPendingRewards")

						if GetPendingRewards then
							local ok, result = pcall(function() --[[ Line: 572 | Upvalues: GetPendingRewards (copy) ]]
								return GetPendingRewards:InvokeServer()
							end)

							if ok and (type(result) == "table" and #result > 0) then
								v9 = true
							end
						end
					end

					local v10 = false

					if TaskController.GetMain then
						local v11 = TaskController:GetMain()

						if v11 and v11.giver == p2.Name then
							local v12

							if v11.active == nil then
								v12 = true

								if not (#(v11.available or {}) > 0) then
									v12 = if v11.nextRequirement == nil then false else true
								end
							else
								v12 = true
							end

							v10 = v12
						end
					end

					if not (v2 or (v3 or (v4 or (v8 or (v9 or v10))))) or (p1.CurrentNPC ~= p2 or not p1.WorkBtn) then
						return
					end

					p1.WorkBtn.Visible = true
				end)
			end
		end

		if p1.WorkPanel then
			p1.WorkPanel.Visible = false
		end

		p1.NpcName.Text = string.upper(p3 and p3.DisplayName or (p2 and p2.Name or "NPC"))
		p1:_startCinematicCamera(p2)
		p1.Gui.Enabled = true
		ContextActionService:BindActionAtPriority("NpcInteractionClose", function(p12, p2) --[[ Line: 611 | Upvalues: p1 (copy) ]]
			if p2 == Enum.UserInputState.Begin then
				p1:Close()

				return Enum.ContextActionResult.Sink
			end

			return Enum.ContextActionResult.Pass
		end, false, 200, Enum.KeyCode.Q)
	end,
	_mainSig = function(p1, p2) --[[ _mainSig | Line: 634 | Upvalues: v4 (ref) ]]
		if not (v4 and v4.GetMain) then
			return "|mt:"
		end

		local v1 = v4:GetMain()

		if not v1 or v1.giver ~= p2 then
			return "|mt:"
		end

		local active = v1.active

		if active then
			if active.stageKind == "turn_in" then
				return "|mt:" .. tostring(active.id) .. ":t"
			end

			return "|mt:active"
		end

		local t = {}

		for v42, v5 in ipairs(v1.available or {}) do
			table.insert(t, (tostring(v5.id)))
		end

		table.sort(t)

		local v7 = table.concat(t, ",")

		return "|mt:" .. v7 .. ":o:" .. tostring(v1.sideDone or 0)
	end,
	_workOffersSig = function(p1) --[[ _workOffersSig | Line: 665 | Upvalues: v4 (ref) ]]
		if not v4 then
			return ""
		end

		local v1 = v4:RequestOffers(p1.CurrentNPC) or {}
		local t = {}

		for v42, v5 in ipairs(v1.offers or {}) do
			t[#t + 1] = tostring(v5.id)
		end

		table.sort(t)

		local v6 = table.concat(t, ",")
		local v9 = tostring(v1.refresh_at or "")

		return v6 .. "|rf:" .. v9 .. p1:_mainSig(p1.CurrentNPC and p1.CurrentNPC.Name)
	end,
	OpenWorkPanel = function(p1) --[[ OpenWorkPanel | Line: 675 | Upvalues: v4 (ref), ReplicatedStorage (copy), v1 (copy), v2 (copy) ]]
		local v12 = v4

		if not v12 then
			local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3))

			if ok and result then
				v12 = result
			else
				warn("[NpcInteractionController] TaskController not found")
				v12 = nil
			end
		end

		v4 = v12

		if not v4 then
			return
		end

		local WorkOffersScroll = p1.WorkOffersScroll

		if not WorkOffersScroll then
			return
		end

		for i, v in ipairs(WorkOffersScroll:GetChildren()) do
			if v:IsA("Frame") or v:IsA("TextLabel") then
				v:Destroy()
			end
		end

		p1.WorkPanel.Visible = true

		local CurrentNPC = p1.CurrentNPC
		local v22 = CurrentNPC and CurrentNPC.Name

		local function sectionLabel(p1) --[[ sectionLabel | Line: 699 | Upvalues: v1 (ref), WorkOffersScroll (copy) ]]
			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.new(1, 0, 0, 16)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = p1
			TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
			TextLabel.TextSize = 11
			TextLabel.FontFace = v1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.ZIndex = 11
			TextLabel.Parent = WorkOffersScroll
		end

		local function objectivesDone(p1) --[[ objectivesDone | Line: 713 ]]
			local v1 = ipairs

			for v3, v4 in v1(p1.objectives or {}) do
				if v4.id ~= "return" and (v4.id ~= "deliver" and not v4.complete) then
					return false
				end
			end

			return true
		end

		local function isForThisNpc(p1) --[[ isForThisNpc | Line: 721 | Upvalues: v22 (copy) ]]
			if p1.type == "delivery" then
				return p1.params and p1.params.destination_npc == v22
			end

			return p1.giver and p1.giver.npcId == v22
		end

		local list = {}

		for i, v in ipairs(v4:GetActiveTasks()) do
			local v3

			v3 = if v.type == "delivery" then v.params and v.params.destination_npc == v22 else v.giver and (if v.giver.npcId == v22 then true else false)

			if v3 and (objectivesDone(v) and not v.shared_from) then
				table.insert(list, v)
			end
		end

		local v42 = v4.GetMain and v4:GetMain() or nil
		local v5 = if v42 == nil then false elseif v42.giver == v22 then true else false
		local v6 = nil
		local v7 = nil
		local t = {}

		if v5 then
			local active = v42.active

			if active and active.stageKind == "turn_in" then
				v6 = active
			elseif not active then
				v7 = (v42.available or {})[1]

				local v9 = ipairs

				for v11, v122 in v9(v42.available or {}) do
					t[v122.id] = v122
				end
			end
		end

		local v13 = v42 and v42.sideDone or 0

		local function coolTime(p1) --[[ coolTime | Line: 778 ]]
			local v3 = math.max(0, (math.floor(tonumber(p1) or 0)))
			local v4 = math.floor(v3 / 3600)
			local v5 = math.floor(v3 % 3600 / 60)

			if v4 > 0 then
				return string.format("%dh %02dm", v4, v5)
			end

			if v5 > 0 then
				return string.format("%dm", v5)
			end

			return string.format("%ds", v3)
		end

		local function buildStoryCard(p12, p2) --[[ buildStoryCard | Line: 789 | Upvalues: WorkOffersScroll (copy), v1 (ref), coolTime (copy), v13 (copy), v2 (ref), ReplicatedStorage (ref), p1 (copy), v4 (ref) ]]
			local v12 = if p2 == "turnin" then true elseif p2 == "offer" then true else false
			local v22 = p2 == "offer" and p12.vouchedBy or nil
			local Frame = Instance.new("Frame")

			Frame.Size = UDim2.new(1, 0, 0, if v22 then 116 else 96)
			Frame.BackgroundColor3 = v12 and Color3.fromRGB(46, 42, 34) or Color3.fromRGB(34, 33, 30)
			Frame.BackgroundTransparency = if v12 then 0.15 else 0.45
			Frame.BorderSizePixel = 0
			Frame.ZIndex = 11
			Frame.Parent = WorkOffersScroll

			local Frame2 = Instance.new("Frame")

			Frame2.Size = UDim2.new(0, 3, 1, 0)
			Frame2.BackgroundColor3 = (p2 == "done" or (p2 == "cooldown" or p2 == "ready")) and Color3.fromRGB(120, 200, 110) or (v12 and Color3.fromRGB(230, 190, 90) or Color3.fromRGB(96, 92, 84))
			Frame2.BorderSizePixel = 0
			Frame2.ZIndex = 12
			Frame2.Parent = Frame

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.fromOffset(52, 16)
			TextLabel.Position = UDim2.fromOffset(12, 8)
			TextLabel.BackgroundColor3 = (p2 == "done" or (p2 == "cooldown" or p2 == "ready")) and Color3.fromRGB(120, 200, 110) or (v12 and Color3.fromRGB(230, 190, 90) or Color3.fromRGB(96, 92, 84))
			TextLabel.BorderSizePixel = 0
			TextLabel.Text = "STORY"
			TextLabel.TextColor3 = Color3.fromRGB(20, 18, 10)
			TextLabel.TextSize = 11
			TextLabel.FontFace = v1
			TextLabel.ZIndex = 12
			TextLabel.Parent = Frame

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Position = UDim2.fromOffset(12, 28)
			TextLabel2.Size = UDim2.new(1, -120, 0, 20)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.Text = p12.title or "Story task"
			TextLabel2.TextColor3 = v12 and Color3.fromRGB(235, 235, 230) or Color3.fromRGB(150, 147, 140)
			TextLabel2.TextSize = 15
			TextLabel2.FontFace = v1
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel2.ZIndex = 12
			TextLabel2.Parent = Frame

			local TextLabel3 = Instance.new("TextLabel")

			TextLabel3.Position = UDim2.fromOffset(12, 48)
			TextLabel3.Size = UDim2.new(1, -120, 0, if v22 then 60 else 40)
			TextLabel3.BackgroundTransparency = 1

			if p2 == "turnin" then
				TextLabel3.Text = "Crow is waiting on this."
			elseif p2 == "active" then
				TextLabel3.Text = "In progress."
			elseif p2 == "done" then
				TextLabel3.Text = "Done."
			elseif p2 == "cooldown" then
				TextLabel3.Text = "Crow has nothing new here.\nAgain in " .. coolTime(p12.cooldownLeft)
			elseif p2 == "ready" then
				TextLabel3.Text = "Ready to run again."
			elseif p2 == "locked" then
				TextLabel3.Text = string.format("Contracts for Crow: %d / %d", v13, p12.requiresSideTasks or 0)
			else
				TextLabel3.Text = (v22 and v22 .. " is working this one. Crow will hear you out.\n" or "") .. (p12.summary or "")
			end

			TextLabel3.TextColor3 = Color3.fromRGB(175, 172, 165)
			TextLabel3.TextSize = 13
			TextLabel3.FontFace = v2
			TextLabel3.TextWrapped = true
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel3.ZIndex = 12
			TextLabel3.Parent = Frame

			if not v12 then
				return
			end

			local TextButton = Instance.new("TextButton")

			TextButton.AnchorPoint = Vector2.new(1, 0.5)
			TextButton.Position = UDim2.new(1, -8, 0.5, 0)
			TextButton.Size = UDim2.fromOffset(92, 34)
			TextButton.BackgroundColor3 = p2 == "turnin" and Color3.fromRGB(120, 200, 110) or Color3.fromRGB(230, 190, 90)
			TextButton.BorderSizePixel = 0
			TextButton.Text = if p2 == "turnin" then "TURN IN" elseif p12.replay then "RUN AGAIN" else "ACCEPT"
			TextButton.TextColor3 = Color3.fromRGB(20, 28, 20)
			TextButton.TextSize = 14
			TextButton.FontFace = v1
			TextButton.ZIndex = 12
			TextButton.Parent = Frame
			TextButton.MouseButton1Click:Connect(function() --[[ Line: 887 | Upvalues: p2 (copy), ReplicatedStorage (ref), p12 (copy), p1 (ref), v4 (ref), TextButton (copy) ]]
				if p2 == "turnin" then
					local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1))

					if type(p12.turnIn) == "table" and (ok and (result and result.OpenTurnIn)) then
						p1.WorkPanel.Visible = false

						local t = {
							id = p12.id,
							intro = p12.turnIn.intro,
							topics = p12.turnIn.topics,
							accept = p12.turnIn.accept,
							decline = p12.turnIn.decline,
							afterTopics = p12.turnIn.afterTopics,
							close = p12.turnIn.close
						}
						local t2 = {}

						t2.money = if p12.reward then p12.reward.money or 0 else 0
						t.rewards = t2
						function t.onTurnIn() --[[ onTurnIn | Line: 906 | Upvalues: v4 (ref) ]]
							return v4:TurnInMain()
						end

						if result:OpenTurnIn(p1.CurrentNPC, p1.CurrentProfile, t) then
							return
						end

						p1:OpenWorkPanel()
					else
						TextButton.Active = false
						TextButton.Text = "..."

						local v2, v3, v42 = v4:TurnInMain()

						if v2 then
							local ok2, result2 = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1))

							if not (v42 and (ok2 and (result2 and result2.SayLine))) then
								p1:OpenWorkPanel()

								return
							end

							p1.WorkPanel.Visible = false

							if not result2:SayLine(p1.CurrentNPC, p1.CurrentProfile, v42) then
								p1:OpenWorkPanel()
							end
						else
							TextButton.Text = "TURN IN"
							TextButton.Active = true
							v4:ShowToast(({
								missing_item = "You don\'t have what Crow\'s waiting for",
								not_ready = "That\'s not finished yet",
								wrong_place = "Not here. That\'s Zone business."
							})[v3] or "Couldn\'t do that right now")
						end
					end
				else
					local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1))

					if ok and result then
						local v5 = if p12.reward then p12.reward.money or 0 else 0

						local function f6() --[[ Line: 954 | Upvalues: v4 (ref), p12 (ref) ]]
							return v4:AcceptMain(p12.id)
						end

						local briefing = p12.briefing

						if type(briefing) == "table" and result.OpenBriefingTopics then
							p1.WorkPanel.Visible = false
							result:OpenBriefingTopics(p1.CurrentNPC, p1.CurrentProfile, {
								id = p12.id,
								intro = p12.briefing.intro,
								topics = p12.briefing.topics,
								accept = p12.briefing.accept,
								decline = p12.briefing.decline,
								rewards = {
									money = v5
								},
								onTake = f6
							})

							return
						end

						if result.OpenBriefing then
							p1.WorkPanel.Visible = false

							local t = {
								id = p12.id
							}

							t.briefing = type(p12.briefing) == "string" and p12.briefing or p12.summary
							t.rewards = {
								money = v5
							}
							t.onTake = f6
							result:OpenBriefing(p1.CurrentNPC, p1.CurrentProfile, t)

							return
						end
					end

					TextButton.Active = false
					TextButton.Text = "..."

					local v8, v9 = v4:AcceptMain(p12.id)

					if v8 then
						p1:OpenWorkPanel()
					else
						TextButton.Text = "ACCEPT"
						TextButton.Active = true
						v4:ShowToast(({
							locked = "Crow doesn\'t trust you with that yet",
							already_active = "Finish what you\'re already carrying first",
							wrong_place = "Not here. That\'s Zone business."
						})[v9] or "Couldn\'t do that right now")
					end
				end
			end)
		end

		local v14 = v4:RequestOffers(CurrentNPC) or {}
		local v15 = v14.offers or {}
		local refresh_at = v14.refresh_at

		local function buildOfferCard(p12, p2) --[[ buildOfferCard | Line: 1007 | Upvalues: v1 (ref), v2 (ref), ReplicatedStorage (ref), p1 (copy), v4 (ref) ]]
			local Frame = Instance.new("Frame")

			Frame.Size = UDim2.new(1, 0, 0, 88)
			Frame.BackgroundColor3 = Color3.fromRGB(40, 42, 45)
			Frame.BackgroundTransparency = 0.2
			Frame.BorderSizePixel = 0
			Frame.ZIndex = 11
			Frame.Parent = p12

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = Color3.fromRGB(80, 80, 80)
			UIStroke.Thickness = 1
			UIStroke.Parent = Frame

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Position = UDim2.fromOffset(10, 4)
			TextLabel.Size = UDim2.new(1, -110, 0, 22)
			TextLabel.BackgroundTransparency = 1
			TextLabel.FontFace = v1
			TextLabel.TextSize = 14
			TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90)
			TextLabel.Text = p2.title or "Task"
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.ZIndex = 11
			TextLabel.Parent = Frame

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Position = UDim2.fromOffset(10, 26)
			TextLabel2.Size = UDim2.new(1, -110, 0, 26)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.FontFace = v2
			TextLabel2.TextSize = 12
			TextLabel2.TextColor3 = Color3.fromRGB(180, 180, 180)
			TextLabel2.Text = p2.description or ""
			TextLabel2.TextWrapped = true
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel2.ZIndex = 11
			TextLabel2.Parent = Frame

			local TextLabel3 = Instance.new("TextLabel")

			TextLabel3.Position = UDim2.fromOffset(10, 58)
			TextLabel3.Size = UDim2.new(1, -110, 0, 20)
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.FontFace = v2
			TextLabel3.TextSize = 12
			TextLabel3.TextColor3 = Color3.fromRGB(140, 200, 120)
			TextLabel3.Text = string.format("Reward: %d\226\130\189  +%d %s rep", p2.rewards and p2.rewards.money or 0, p2.rewards and p2.rewards.rep and p2.rewards.rep.amount or 0, p2.rewards and p2.rewards.rep and p2.rewards.rep.faction or "?")
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.ZIndex = 11
			TextLabel3.Parent = Frame

			local TextButton = Instance.new("TextButton")

			TextButton.AnchorPoint = Vector2.new(1, 0.5)
			TextButton.Position = UDim2.new(1, -8, 0.5, 0)
			TextButton.Size = UDim2.fromOffset(88, 34)
			TextButton.BackgroundColor3 = Color3.fromRGB(255, 200, 90)
			TextButton.BorderSizePixel = 0
			TextButton.Text = "INQUIRE"
			TextButton.FontFace = v1
			TextButton.TextSize = 14
			TextButton.TextColor3 = Color3.fromRGB(20, 20, 22)
			TextButton.AutoButtonColor = true
			TextButton.ZIndex = 11
			TextButton.Parent = Frame
			TextButton.MouseButton1Click:Connect(function() --[[ Line: 1076 | Upvalues: ReplicatedStorage (ref), p1 (ref), p2 (copy), v4 (ref) ]]
				local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1))

				if ok and (result and result.OpenBriefing) then
					p1.WorkPanel.Visible = false
					result:OpenBriefing(p1.CurrentNPC, p1.CurrentProfile, p2)
					p1.Gui.Enabled = false
				else
					v4:ShowToast("Can\'t open the briefing right now")
					warn("[NpcInteractionController] TalkController:OpenBriefing unavailable")
				end
			end)

			return Frame
		end

		local function buildTurnInCard(p12) --[[ buildTurnInCard | Line: 1093 | Upvalues: WorkOffersScroll (copy), v1 (ref), v2 (ref), v4 (ref), v22 (copy), p1 (copy) ]]
			local Frame = Instance.new("Frame")

			Frame.Size = UDim2.new(1, 0, 0, 88)
			Frame.BackgroundColor3 = Color3.fromRGB(34, 48, 34)
			Frame.BackgroundTransparency = 0.15
			Frame.BorderSizePixel = 0
			Frame.ZIndex = 11
			Frame.Parent = WorkOffersScroll

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = Color3.fromRGB(120, 200, 110)
			UIStroke.Thickness = 1
			UIStroke.Parent = Frame

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Position = UDim2.fromOffset(10, 4)
			TextLabel.Size = UDim2.new(1, -110, 0, 22)
			TextLabel.BackgroundTransparency = 1
			TextLabel.FontFace = v1
			TextLabel.TextSize = 14
			TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90)
			TextLabel.Text = p12.title or "Task"
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.ZIndex = 11
			TextLabel.Parent = Frame

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Position = UDim2.fromOffset(10, 28)
			TextLabel2.Size = UDim2.new(1, -110, 0, 26)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.FontFace = v2
			TextLabel2.TextSize = 12
			TextLabel2.TextColor3 = Color3.fromRGB(150, 210, 140)
			TextLabel2.Text = "Objectives complete \226\128\148 ready to turn in"
			TextLabel2.TextWrapped = true
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel2.ZIndex = 11
			TextLabel2.Parent = Frame

			local TextLabel3 = Instance.new("TextLabel")

			TextLabel3.Position = UDim2.fromOffset(10, 58)
			TextLabel3.Size = UDim2.new(1, -110, 0, 20)
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.FontFace = v2
			TextLabel3.TextSize = 12
			TextLabel3.TextColor3 = Color3.fromRGB(140, 200, 120)
			TextLabel3.Text = string.format("Reward: %d\226\130\189  +%d %s rep", p12.rewards and p12.rewards.money or 0, p12.rewards and p12.rewards.rep and p12.rewards.rep.amount or 0, p12.rewards and p12.rewards.rep and p12.rewards.rep.faction or "?")
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.ZIndex = 11
			TextLabel3.Parent = Frame

			local TextButton = Instance.new("TextButton")

			TextButton.AnchorPoint = Vector2.new(1, 0.5)
			TextButton.Position = UDim2.new(1, -8, 0.5, 0)
			TextButton.Size = UDim2.fromOffset(88, 34)
			TextButton.BackgroundColor3 = Color3.fromRGB(120, 200, 110)
			TextButton.BorderSizePixel = 0
			TextButton.Text = "TURN IN"
			TextButton.FontFace = v1
			TextButton.TextSize = 14
			TextButton.TextColor3 = Color3.fromRGB(20, 30, 20)
			TextButton.AutoButtonColor = true
			TextButton.ZIndex = 11
			TextButton.Parent = Frame
			TextButton.MouseButton1Click:Connect(function() --[[ Line: 1162 | Upvalues: TextButton (copy), v4 (ref), p12 (copy), v22 (ref), p1 (ref) ]]
				TextButton.Active = false
				TextButton.Text = "..."

				local v1 = v4:Handin(p12.id, v22)

				if v1 and v1.ok then
					p1:OpenWorkPanel()

					return
				end

				TextButton.Text = "TURN IN"
				TextButton.Active = true

				local v2 = if v1 then v1.error or "unknown" else "unknown"

				v4:ShowToast(if v2 == "missing_package" then "You no longer have the package" elseif v2 == "missing_items" then "You don\'t have the required items" else "Couldn\'t turn in")
				warn("[NpcInteractionController] Handin failed:", v2)
			end)
		end

		local function buildCooldownNotice(p12) --[[ buildCooldownNotice | Line: 1181 | Upvalues: WorkOffersScroll (copy), v1 (ref), p1 (copy), CurrentNPC (copy) ]]
			local Frame = Instance.new("Frame")

			Frame.Size = UDim2.new(1, 0, 0, 70)
			Frame.BackgroundTransparency = 1
			Frame.ZIndex = 11
			Frame.Parent = WorkOffersScroll

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.new(1, 0, 0, 20)
			TextLabel.Position = UDim2.fromOffset(0, 8)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = "NO CONTRACTS RIGHT NOW"
			TextLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
			TextLabel.TextSize = 13
			TextLabel.FontFace = v1
			TextLabel.ZIndex = 11
			TextLabel.Parent = Frame

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Size = UDim2.new(1, 0, 0, 26)
			TextLabel2.Position = UDim2.fromOffset(0, 30)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.TextColor3 = Color3.fromRGB(255, 200, 90)
			TextLabel2.TextSize = 20
			TextLabel2.FontFace = v1
			TextLabel2.ZIndex = 11
			TextLabel2.Parent = Frame
			task.spawn(function() --[[ Line: 1209 | Upvalues: TextLabel2 (copy), p1 (ref), p12 (copy), CurrentNPC (ref) ]]
				while TextLabel2.Parent and (p1.WorkPanel and p1.WorkPanel.Visible) do
					local v1 = p12 - os.time()

					if v1 <= 0 then
						if p1.WorkPanel and (p1.WorkPanel.Visible and p1.CurrentNPC == CurrentNPC) then
							p1:OpenWorkPanel()

							return
						end

						break
					end

					TextLabel2.Text = string.format("New contracts in %d:%02d", math.floor(v1 / 60), v1 % 60)
					task.wait(1)
				end
			end)
		end

		local function buildRefreshFooter(p12) --[[ buildRefreshFooter | Line: 1225 | Upvalues: v2 (ref), WorkOffersScroll (copy), p1 (copy), CurrentNPC (copy) ]]
			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.new(1, 0, 0, 18)
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
			TextLabel.TextSize = 12
			TextLabel.FontFace = v2
			TextLabel.TextXAlignment = Enum.TextXAlignment.Center
			TextLabel.ZIndex = 11
			TextLabel.LayoutOrder = 999
			TextLabel.Parent = WorkOffersScroll
			task.spawn(function() --[[ Line: 1236 | Upvalues: TextLabel (copy), p1 (ref), p12 (copy), CurrentNPC (ref) ]]
				while TextLabel.Parent and (p1.WorkPanel and p1.WorkPanel.Visible) do
					local v1 = p12 - os.time()

					if v1 <= 0 then
						if p1.WorkPanel and (p1.WorkPanel.Visible and p1.CurrentNPC == CurrentNPC) then
							p1:OpenWorkPanel()

							return
						end

						break
					end

					TextLabel.Text = string.format("\226\134\187 New contracts in %d:%02d", math.floor(v1 / 60), v1 % 60)
					task.wait(1)
				end
			end)
		end

		local v16 = false

		local function buildDailyCardFor(p12) --[[ buildDailyCardFor | Line: 1253 | Upvalues: WorkOffersScroll (copy), v1 (ref), v2 (ref), v4 (ref), p1 (copy) ]]
			local Frame = Instance.new("Frame")

			Frame.Size = UDim2.new(1, 0, 0, 110)
			Frame.BackgroundColor3 = Color3.fromRGB(40, 42, 45)
			Frame.BackgroundTransparency = 0.15
			Frame.BorderSizePixel = 0
			Frame.ZIndex = 11
			Frame.Parent = WorkOffersScroll

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = p12.completed and Color3.fromRGB(120, 200, 110) or Color3.fromRGB(100, 100, 100)
			UIStroke.Thickness = 1
			UIStroke.Parent = Frame

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Position = UDim2.fromOffset(10, 6)
			TextLabel.Size = UDim2.new(1, -20, 0, 22)
			TextLabel.BackgroundTransparency = 1
			TextLabel.FontFace = v1
			TextLabel.TextSize = 14
			TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90)
			TextLabel.Text = p12.objective or "Daily objective"
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.ZIndex = 11
			TextLabel.Parent = Frame

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Position = UDim2.fromOffset(10, 30)
			TextLabel2.Size = UDim2.new(1, -20, 0, 34)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.FontFace = v2
			TextLabel2.TextSize = 12
			TextLabel2.TextColor3 = Color3.fromRGB(200, 200, 200)
			TextLabel2.Text = p12.briefing or ""
			TextLabel2.TextWrapped = true
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel2.ZIndex = 11
			TextLabel2.Parent = Frame

			local TextLabel3 = Instance.new("TextLabel")

			TextLabel3.Position = UDim2.fromOffset(10, 66)
			TextLabel3.Size = UDim2.new(1, -120, 0, 40)
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.FontFace = v2
			TextLabel3.TextSize = 12
			TextLabel3.TextColor3 = Color3.fromRGB(140, 200, 120)

			local v22, v3

			if v4 and v4.GetDailyTurnIn then
				local v42, _, v5 = v4:GetDailyTurnIn()

				v22 = v42
				v3 = v5 or 1
			else
				v22 = nil
				v3 = 1
			end

			TextLabel3.Text = v22 and string.format("Reward: %s\226\130\189  +%d Ecologist Rep", v22, v3) or string.format("Reward: +%d Ecologist Rep", v3)
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel3.ZIndex = 11
			TextLabel3.Parent = Frame

			if p12.turned_in then
				local TextLabel4 = Instance.new("TextLabel")

				TextLabel4.AnchorPoint = Vector2.new(1, 0.5)
				TextLabel4.Position = UDim2.new(1, -10, 0.75, 0)
				TextLabel4.Size = UDim2.fromOffset(120, 34)
				TextLabel4.BackgroundTransparency = 1
				TextLabel4.FontFace = v1
				TextLabel4.TextSize = 13
				TextLabel4.TextColor3 = Color3.fromRGB(150, 150, 150)
				TextLabel4.Text = "TURNED IN"
				TextLabel4.TextXAlignment = Enum.TextXAlignment.Right
				TextLabel4.ZIndex = 11
				TextLabel4.Parent = Frame

				return
			end

			if p12.completed then
				local TextButton = Instance.new("TextButton")

				TextButton.AnchorPoint = Vector2.new(1, 0.5)
				TextButton.Position = UDim2.new(1, -10, 0.75, 0)
				TextButton.Size = UDim2.fromOffset(100, 36)
				TextButton.BackgroundColor3 = Color3.fromRGB(120, 200, 110)
				TextButton.BorderSizePixel = 0
				TextButton.Text = "TURN IN"
				TextButton.FontFace = v1
				TextButton.TextSize = 14
				TextButton.TextColor3 = Color3.fromRGB(20, 30, 20)
				TextButton.AutoButtonColor = true
				TextButton.ZIndex = 11
				TextButton.Parent = Frame
				TextButton.MouseButton1Click:Connect(function() --[[ Line: 1336 | Upvalues: TextButton (copy), v4 (ref), p12 (copy), p1 (ref) ]]
					TextButton.Active = false
					TextButton.Text = "..."

					local v1 = v4:TurnInDaily(p12.index)

					if v1 and v1.ok then
						v4:ShowToast(string.format("Daily complete \226\128\148 +%d\226\130\189 +%d rep", v1.roubles or 0, v1.rep or 0))
						p1:OpenWorkPanel()

						return
					end

					TextButton.Text = "TURN IN"
					TextButton.Active = true
					v4:ShowToast("Turn-in failed: " .. tostring(if v1 then v1.err or "?" else "?"))
				end)

				return
			end

			local TextLabel4 = Instance.new("TextLabel")

			TextLabel4.AnchorPoint = Vector2.new(1, 0.5)
			TextLabel4.Position = UDim2.new(1, -10, 0.75, 0)
			TextLabel4.Size = UDim2.fromOffset(120, 34)
			TextLabel4.BackgroundTransparency = 1
			TextLabel4.FontFace = v1
			TextLabel4.TextSize = 13
			TextLabel4.TextColor3 = Color3.fromRGB(180, 180, 180)
			TextLabel4.Text = string.format("%d / %d", p12.progress or 0, if p12.params then p12.params.target or 0 else 0)
			TextLabel4.TextXAlignment = Enum.TextXAlignment.Right
			TextLabel4.ZIndex = 11
			TextLabel4.Parent = Frame
		end

		if v22 == "Ecologist" and v4.GetDailyTasks then
			local v17 = v4:GetDailyTasks()

			if v17 and #v17 > 0 then
				sectionLabel("DAILY TASKS")
				v16 = true

				for i, v in ipairs(v17) do
					buildDailyCardFor(v)
				end
			end
		end

		local v18 = false

		if v22 == "Ecologist" then
			local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
			local GetPendingRewards = Remotes:FindFirstChild("GetPendingRewards")
			local CollectPendingRewards = Remotes:FindFirstChild("CollectPendingRewards")
			local list2 = {}

			if GetPendingRewards then
				local ok, result = pcall(function() --[[ Line: 1386 | Upvalues: GetPendingRewards (copy) ]]
					return GetPendingRewards:InvokeServer()
				end)

				if ok and type(result) == "table" then
					list2 = result
				end
			end

			if #list2 > 0 then
				sectionLabel("REWARDS WAITING")

				local ItemDatabase = require(game:GetService("ReplicatedStorage"):WaitForChild("ItemDatabase"))
				local Frame = Instance.new("Frame")

				Frame.Size = UDim2.new(1, 0, 0, #list2 * 30 + 40 + 44)
				Frame.BackgroundColor3 = Color3.fromRGB(40, 42, 45)
				Frame.BackgroundTransparency = 0.15
				Frame.BorderSizePixel = 0
				Frame.ZIndex = 11
				Frame.Parent = WorkOffersScroll

				local UIStroke = Instance.new("UIStroke")

				UIStroke.Color = Color3.fromRGB(120, 200, 110)
				UIStroke.Thickness = 1
				UIStroke.Parent = Frame

				local TextLabel = Instance.new("TextLabel")

				TextLabel.Position = UDim2.fromOffset(10, 4)
				TextLabel.Size = UDim2.new(1, -20, 0, 20)
				TextLabel.BackgroundTransparency = 1
				TextLabel.FontFace = v2
				TextLabel.TextSize = 12
				TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				TextLabel.Text = "I\'ve been holding these for you. Take what you can carry."
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel.ZIndex = 11
				TextLabel.Parent = Frame
				v18 = true

				for i, v in ipairs(list2) do
					local v19
					local TextLabel2 = Instance.new("TextLabel")

					TextLabel2.Position = UDim2.fromOffset(14, 24 + (i - 1) * 26)
					TextLabel2.Size = UDim2.new(1, -28, 0, 24)
					TextLabel2.BackgroundTransparency = 1
					TextLabel2.FontFace = v1
					TextLabel2.TextSize = 13
					TextLabel2.TextColor3 = Color3.fromRGB(255, 200, 90)

					local v20 = ItemDatabase[v.itemId]

					v19 = v20 and (v20.Name or v20.DisplayName) or v.itemId
					TextLabel2.Text = string.format("  \226\128\162  %d \195\151 %s   \226\128\148   %s", v.count or 1, v19, v.label or "reward")
					TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel2.ZIndex = 11
					TextLabel2.Parent = Frame
				end

				local TextButton = Instance.new("TextButton")

				TextButton.Size = UDim2.new(1, -20, 0, 34)
				TextButton.Position = UDim2.new(0, 10, 1, -40)
				TextButton.BackgroundColor3 = Color3.fromRGB(120, 200, 110)
				TextButton.BorderSizePixel = 0
				TextButton.Text = "COLLECT ALL"
				TextButton.FontFace = v1
				TextButton.TextSize = 14
				TextButton.TextColor3 = Color3.fromRGB(20, 30, 20)
				TextButton.AutoButtonColor = true
				TextButton.ZIndex = 11
				TextButton.Parent = Frame
				TextButton.MouseButton1Click:Connect(function() --[[ Line: 1447 | Upvalues: TextButton (copy), CollectPendingRewards (copy), v4 (ref), p1 (copy) ]]
					TextButton.Active = false
					TextButton.Text = "..."

					local ok, result = pcall(function() --[[ Line: 1450 | Upvalues: CollectPendingRewards (ref) ]]
						return CollectPendingRewards:InvokeServer()
					end)

					if not (ok and (result and result.ok)) then
						TextButton.Text = "COLLECT ALL"
						TextButton.Active = true
						v4:ShowToast("Collect failed.")

						return
					end

					if result.remaining > 0 then
						v4:ShowToast(string.format("Collected %d, %d still won\'t fit \226\128\148 make more room.", result.collected or 0, result.remaining))
					elseif result.collected > 0 then
						v4:ShowToast(string.format("Collected %d reward%s from the Ecologist.", result.collected, if result.collected == 1 then "" else "s"))
					else
						v4:ShowToast("Nothing to collect.")
					end

					p1:OpenWorkPanel()
				end)
			end
		end

		local v21 = p1._workTab or "contracts"

		if not v5 then
			v21 = "contracts"
		end

		if v21 == "contracts" and (#list == 0 and (#v15 == 0 and (v6 or v7))) then
			p1._workTab = "story"
			v21 = "story"
		end

		if p1.WorkTabStory then
			p1.WorkTabStory.Visible = v5
		end

		local function paintTab(p1, p2) --[[ paintTab | Line: 1479 ]]
			if not p1 then
				return
			end

			p1.BackgroundColor3 = p2 and Color3.fromRGB(70, 78, 68) or Color3.fromRGB(40, 44, 40)
			p1.TextColor3 = p2 and Color3.fromRGB(240, 240, 235) or Color3.fromRGB(170, 170, 170)
		end

		paintTab(p1.WorkTabContracts, if v21 == "contracts" then true else false)
		paintTab(p1.WorkTabStory, if v21 == "story" then true else false)

		local TitleRow = p1.WorkPanel:FindFirstChild("TitleRow")
		local v26 = if TitleRow then TitleRow:FindFirstChild("Title") else TitleRow

		if v26 then
			v26.Text = if v21 == "story" then "STORY" else "AVAILABLE WORK"
		end

		if v21 == "story" then
			local v28 = if v42 then v42.roster else v42

			if v28 and #v28 > 0 then
				for i, v in ipairs(v28) do
					if v6 and v.id == v6.id then
						buildStoryCard(v6, "turnin")

						continue
					end

					if t[v.id] then
						buildStoryCard(t[v.id], "offer")

						continue
					end

					buildStoryCard(v, v.state)
				end
			elseif v6 then
				buildStoryCard(v6, "turnin")
			elseif v7 then
				buildStoryCard(v7, "offer")
			else
				local v29 = if v42 and v42.active then "You\'re already carrying one.\nFinish it and come back." elseif v42 and v42.nextRequirement then string.format("Crow doesn\'t trust you with the real work yet.\n\nContracts completed for him: %d / %d", v42.sideDone or 0, v42.nextRequirement) else "Nothing more from Crow. For now."
				local TextLabel = Instance.new("TextLabel")

				TextLabel.Size = UDim2.new(1, 0, 0, 90)
				TextLabel.BackgroundTransparency = 1
				TextLabel.Text = v29
				TextLabel.TextColor3 = Color3.fromRGB(165, 162, 155)
				TextLabel.TextSize = 13
				TextLabel.FontFace = v2
				TextLabel.TextWrapped = true
				TextLabel.TextXAlignment = Enum.TextXAlignment.Center
				TextLabel.TextYAlignment = Enum.TextYAlignment.Center
				TextLabel.ZIndex = 11
				TextLabel.Parent = WorkOffersScroll
			end
		else
			if #list > 0 then
				sectionLabel("READY TO TURN IN")

				for i, v in ipairs(list) do
					buildTurnInCard(v)
				end
			end

			if #v15 > 0 then
				if #list > 0 then
					sectionLabel("AVAILABLE WORK")
				end

				for i, v in ipairs(v15) do
					if i > 5 then
						break
					end

					buildOfferCard(WorkOffersScroll, v)
				end

				if refresh_at then
					buildRefreshFooter(refresh_at)
				end
			elseif refresh_at then
				buildCooldownNotice(refresh_at)
			elseif #list == 0 and not (v16 or v18) then
				local TextLabel = Instance.new("TextLabel")

				TextLabel.Size = UDim2.new(1, 0, 0, 48)
				TextLabel.BackgroundTransparency = 1
				TextLabel.Text = "No tasks right now.\nCheck back later."
				TextLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
				TextLabel.TextSize = 13
				TextLabel.FontFace = v2
				TextLabel.TextWrapped = true
				TextLabel.TextXAlignment = Enum.TextXAlignment.Center
				TextLabel.TextYAlignment = Enum.TextYAlignment.Center
				TextLabel.ZIndex = 11
				TextLabel.Parent = WorkOffersScroll
			end
		end

		p1:_finishWorkPanel(CurrentNPC, v15, refresh_at, v22)
	end,
	_finishWorkPanel = function(p1, p2, p3, p4, p5) --[[ _finishWorkPanel | Line: 1576 ]]
		local t = {}

		for i, v in ipairs(p3) do
			t[#t + 1] = tostring(v.id)
		end

		table.sort(t)
		p1._workSig = table.concat(t, ",") .. "|rf:" .. tostring(p4 or "") .. p1:_mainSig(p5)

		local t2 = {}

		p1._workRefreshToken = t2
		task.spawn(function() --[[ Line: 1586 | Upvalues: p1 (copy), t2 (copy), p2 (copy) ]]
			repeat
				task.wait(3)

				if p1._workRefreshToken ~= t2 then
					return
				end

				if not p1.WorkPanel or (not p1.WorkPanel.Visible or p1.CurrentNPC ~= p2) then
					return
				end
			until p1:_workOffersSig() ~= p1._workSig

			p1:OpenWorkPanel()
		end)
	end,
	_wireDeathClose = function(p1) --[[ _wireDeathClose | Line: 1616 | Upvalues: LocalPlayer (copy) ]]
		local function hookCharacter(p12) --[[ hookCharacter | Line: 1617 | Upvalues: p1 (copy) ]]
			local v1 = p12:FindFirstChildOfClass("Humanoid") or p12:WaitForChild("Humanoid", 10)

			if v1 then
				v1.Died:Connect(function() --[[ Line: 1620 | Upvalues: p1 (ref) ]]
					if not p1.IsOpen then
						return
					end

					p1:Close()
				end)
			end
		end

		if LocalPlayer.Character then
			task.spawn(hookCharacter, LocalPlayer.Character)
		end

		LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 1625 | Upvalues: p1 (copy), hookCharacter (copy) ]]
			if not p1.IsOpen then
				hookCharacter(p12)

				return
			end

			p1:Close()
			hookCharacter(p12)
		end)
	end,
	Close = function(p1) --[[ Close | Line: 1631 | Upvalues: RunService (copy), LocalPlayer (copy), ContextActionService (copy), v3 (ref), ReplicatedStorage (copy), UserInputService (copy) ]]
		if not p1.IsOpen then
			return
		end

		p1.IsOpen = false

		if p1._savedControls then
			pcall(function() --[[ Line: 1640 | Upvalues: p1 (copy) ]]
				p1._savedControls:Enable()
			end)
			p1._savedControls = nil
		end

		if p1._freezeBound then
			pcall(function() --[[ Line: 1644 | Upvalues: RunService (ref), p1 (copy) ]]
				RunService:UnbindFromRenderStep(p1._freezeBound)
			end)
			p1._freezeBound = nil
		end

		if p1._sphCharacterClient then
			pcall(function() --[[ Line: 1648 | Upvalues: p1 (copy) ]]
				p1._sphCharacterClient:SetAttribute("SpeedCap_Dialogue", nil)
			end)
		end

		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

		if v1 then
			if p1._savedWalkSpeed then
				v1.WalkSpeed = p1._savedWalkSpeed
			end

			if p1._savedJumpPower then
				v1.JumpPower = p1._savedJumpPower
			end

			if p1._savedJumpHeight then
				v1.JumpHeight = p1._savedJumpHeight
			end

			if p1._savedAutoRotate ~= nil then
				v1.AutoRotate = p1._savedAutoRotate
			end
		end

		p1.Gui.Enabled = false

		if p1.WorkPanel then
			p1.WorkPanel.Visible = false
		end

		ContextActionService:UnbindAction("NpcInteractionClose")
		v3 = v3 or require(ReplicatedStorage:WaitForChild("TraderController"))

		if v3 and v3.IsOpen then
			v3:Close("npc-interaction-closed")

			local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
			local v32 = if Remotes then Remotes:FindFirstChild("CloseTrader") else Remotes

			if v32 then
				v32:FireServer()
			end
		end

		local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 1))

		if ok and (result and result.IsOpen) then
			if result.Gui then
				result.Gui.Enabled = false
			end

			result.IsOpen = false
			result._tree = nil
			result._currentNode = nil
			result._history = nil
			result.CurrentNPC = nil
			result.CurrentProfile = nil

			if result._clearHistoryUI then
				result:_clearHistoryUI()
			end

			if result._clearChoicesUI then
				result:_clearChoicesUI()
			end
		end

		if p1._freezeBound then
			RunService:UnbindFromRenderStep(p1._freezeBound)
			p1._freezeBound = nil
		end

		local Character2 = LocalPlayer.Character

		if Character2 then
			for i, v in ipairs(Character2:GetDescendants()) do
				if v:IsA("BasePart") then
					v.LocalTransparencyModifier = 0
				end
			end
		end

		p1._savedTransparencies = nil

		if p1._sphCharacterClient then
			p1._sphCharacterClient:SetAttribute("SpeedCap_Dialogue", nil)
		end

		p1._sphCharacterClient = nil

		if p1._savedControls then
			pcall(function() --[[ Line: 1712 | Upvalues: p1 (copy) ]]
				p1._savedControls:Enable()
			end)
			p1._savedControls = nil
		end

		local Character3 = LocalPlayer.Character
		local v4 = if Character3 then Character3:FindFirstChildOfClass("Humanoid") else Character3

		if v4 then
			if p1._savedWalkSpeed then
				v4.WalkSpeed = p1._savedWalkSpeed
			end

			if p1._savedJumpPower then
				v4.JumpPower = p1._savedJumpPower
			end

			if p1._savedJumpHeight then
				v4.JumpHeight = p1._savedJumpHeight
			end

			if p1._savedAutoRotate ~= nil then
				v4.AutoRotate = p1._savedAutoRotate
			end
		end

		p1._savedWalkSpeed = nil
		p1._savedJumpPower = nil
		p1._savedJumpHeight = nil
		p1._savedAutoRotate = nil

		if p1._hiddenPrompts then
			for k in pairs(p1._hiddenPrompts) do
				if k and k.Parent then
					k.Enabled = true
				end
			end

			p1._hiddenPrompts = nil
		end

		p1:_restoreCamera()

		if p1._savedMouseBehavior ~= nil then
			UserInputService.MouseBehavior = p1._savedMouseBehavior
		end

		if p1._savedMouseIconEnabled ~= nil then
			UserInputService.MouseIconEnabled = p1._savedMouseIconEnabled
		end

		p1._savedMouseBehavior = nil
		p1._savedMouseIconEnabled = nil

		if p1._savedCameraMode ~= nil then
			LocalPlayer.CameraMode = p1._savedCameraMode
		end

		if p1._savedCameraMinZoom ~= nil then
			LocalPlayer.CameraMinZoomDistance = p1._savedCameraMinZoom
		end

		if p1._savedCameraMaxZoom ~= nil then
			LocalPlayer.CameraMaxZoomDistance = p1._savedCameraMaxZoom
		end

		p1._savedCameraMode = nil
		p1._savedCameraMinZoom = nil
		p1._savedCameraMaxZoom = nil
		p1.CurrentNPC = nil
		p1.CurrentProfile = nil
	end,
	_startCinematicCamera = function(p1, p2) --[[ _startCinematicCamera | Line: 1766 | Upvalues: CurrentCamera (copy), LocalPlayer (copy), TweenService (copy) ]]
		p1._savedCamType = CurrentCamera.CameraType
		p1._savedCamCFrame = CurrentCamera.CFrame
		p1._savedCamFOV = CurrentCamera.FieldOfView
		p1._savedCamSubject = CurrentCamera.CameraSubject

		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChild("Head") or Character:FindFirstChild("HumanoidRootPart") else Character
		local v2 = if p2 then p2:FindFirstChild("Head", true) or p2:FindFirstChild("HumanoidRootPart", true) else p2

		if not (v1 and v2) then
			return
		end

		CurrentCamera.CameraType = Enum.CameraType.Scriptable

		local LookVector = (p2:FindFirstChild("HumanoidRootPart", true) or v2).CFrame.LookVector
		local v3 = Vector3.new(LookVector.X, 0, LookVector.Z)
		local v4 = v3.Magnitude > 0.001 and v3.Unit or Vector3.new(0, 0, -1)
		local Unit = v4:Cross(Vector3.new(0, 1, 0)).Unit
		local Position = v2.Position
		local v5 = CFrame.lookAt(Position + v4 * 5 + Unit * 0 + Vector3.new(0, 0, 0), Position)

		CurrentCamera.CFrame = CFrame.lookAt(v1.Position, v1.Position + CurrentCamera.CFrame.LookVector * 10)

		if p1._activeTween then
			p1._activeTween:Cancel()
			p1._activeTween = nil
		end

		p1._lockedCameraCFrame = nil

		local v6 = TweenService:Create(CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			FieldOfView = 55,
			CFrame = v5
		})

		p1._activeTween = v6
		v6.Completed:Once(function() --[[ Line: 1816 | Upvalues: p1 (copy), v5 (copy) ]]
			if not p1.IsOpen then
				return
			end

			p1._lockedCameraCFrame = v5
		end)
		v6:Play()
	end,
	_restoreCamera = function(p1) --[[ _restoreCamera | Line: 1824 | Upvalues: LocalPlayer (copy), CurrentCamera (copy) ]]
		p1._lockedCameraCFrame = nil

		if p1._activeTween then
			p1._activeTween:Cancel()
			p1._activeTween = nil
		end

		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

		CurrentCamera.CameraSubject = if v1 then v1 else p1._savedCamSubject or CurrentCamera.CameraSubject
		CurrentCamera.CameraType = p1._savedCamType or Enum.CameraType.Custom
		CurrentCamera.FieldOfView = p1._savedCamFOV or 70
		p1._savedCamType = nil
		p1._savedCamCFrame = nil
		p1._savedCamFOV = nil
		p1._savedCamSubject = nil
	end
}