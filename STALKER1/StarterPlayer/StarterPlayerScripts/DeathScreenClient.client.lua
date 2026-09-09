-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))
local PlayDeathScreen = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayDeathScreen")
local RequestRespawn = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RequestRespawn")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local DeathScreen = PlayerGui:FindFirstChild("DeathScreen")
local v1, v2, v3, _, _2, Tinnitus, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22

if not DeathScreen then
	PlayerGui.ChildAdded:Connect(function(p13) --[[ Line: 31 ]]
		if p13.Name ~= "DeathScreen" then
			return
		end

		p13.Enabled = false
	end)
	v1 = false
	v2 = Workspace.CurrentCamera
	v3 = nil
	_ = function() --[[ startMouseOverride | Line: 48 | Upvalues: RunService (copy), UserInputService (copy) ]]
		RunService:BindToRenderStep("DeathScreenMouseFree", Enum.RenderPriority.Last.Value, function() --[[ Line: 49 | Upvalues: UserInputService (ref) ]]
			if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			if UserInputService.MouseIconEnabled then
				return
			end

			UserInputService.MouseIconEnabled = true
		end)
	end
	_2 = function() --[[ stopMouseOverride | Line: 58 | Upvalues: RunService (copy) ]]
		pcall(function() --[[ Line: 59 | Upvalues: RunService (ref) ]]
			RunService:UnbindFromRenderStep("DeathScreenMouseFree")
		end)
	end
	Tinnitus = Instance.new("Sound")
	Tinnitus.Name = "Tinnitus"
	Tinnitus.SoundId = "rbxassetid://4155293439"
	Tinnitus.Volume = 1.2
	Tinnitus.Looped = false
	Tinnitus.Parent = script
	v4 = {}
	v5 = { Workspace, SoundService }
	v6 = function() --[[ captureWorldVolumes | Line: 78 | Upvalues: v4 (copy), v5 (copy) ]]
		table.clear(v4)

		for i2, v in ipairs(v5) do
			for i22, v3 in ipairs(v:GetDescendants()) do
				if v3:IsA("Sound") and (v3.Volume > 0 and not v3:IsDescendantOf(script)) then
					v4[v3] = v3.Volume
				end
			end
		end
	end
	v7 = function(p13, p23) --[[ fadeWorldVolume | Line: 89 | Upvalues: v4 (copy), TweenService (copy) ]]
		for k2, v in pairs(v4) do
			if k2.Parent then
				TweenService:Create(k2, TweenInfo.new(p23), {
					Volume = v * p13
				}):Play()
			end
		end
	end
	v8 = function() --[[ restoreWorldVolume | Line: 98 | Upvalues: v4 (copy) ]]
		for k2, v in pairs(v4) do
			if k2.Parent then
				k2.Volume = v
			end
		end

		table.clear(v4)
	end
	v9 = nil
	v10 = nil
	v11 = nil
	v12 = nil
	v13 = nil
	v14 = nil
	v15 = nil
	v16 = nil
	v17 = nil
	v18 = nil
	v19 = function() --[[ buildGui | Line: 110 | Upvalues: v9 (ref), LocalPlayer (copy), v10 (ref), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v16 (ref), v17 (ref), v15 (ref), v18 (ref) ]]
		if not v9 then
			local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

			v9 = Instance.new("ScreenGui")
			v9.Name = "DeathScreen_New"
			v9.IgnoreGuiInset = true
			v9.ResetOnSpawn = false
			v9.DisplayOrder = 200
			v9.Enabled = false
			v9.Parent = PlayerGui
			v10 = Instance.new("Frame")
			v10.Name = "Black"
			v10.Size = UDim2.new(1, 0, 1, 0)
			v10.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
			v10.BackgroundTransparency = 1
			v10.BorderSizePixel = 0
			v10.Parent = v9
			v11 = Instance.new("TextLabel")
			v11.Name = "LostText"
			v11.Size = UDim2.new(0.6, 0, 0.08, 0)
			v11.AnchorPoint = Vector2.new(0.5, 0.5)
			v11.Position = UDim2.new(0.5, 0, 0.13, 0)
			v11.BackgroundTransparency = 1
			v11.Text = "Lost to the Zone"
			v11.Font = Enum.Font.RobotoCondensed
			v11.TextColor3 = Color3.fromRGB(245, 232, 210)
			v11.TextScaled = true
			v11.TextTransparency = 1
			v11.Parent = v9
			v12 = Instance.new("Frame")
			v12.Name = "Panel"
			v12.AnchorPoint = Vector2.new(0.5, 0.5)
			v12.Position = UDim2.new(0.5, 0, 0.56, 0)
			v12.Size = UDim2.new(0.36, 0, 0.6, 0)
			v12.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
			v12.BackgroundTransparency = 1
			v12.BorderSizePixel = 0
			v12.Parent = v9

			local UICorner = Instance.new("UICorner")

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = v12

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = Color3.fromRGB(85, 80, 72)
			UIStroke.Thickness = 1
			UIStroke.Transparency = 1
			UIStroke.Parent = v12

			local UIPadding = Instance.new("UIPadding")

			UIPadding.PaddingTop = UDim.new(0, 14)
			UIPadding.PaddingBottom = UDim.new(0, 14)
			UIPadding.PaddingLeft = UDim.new(0, 14)
			UIPadding.PaddingRight = UDim.new(0, 14)
			UIPadding.Parent = v12
			v13 = Instance.new("TextLabel")
			v13.Name = "Subheader"
			v13.Position = UDim2.fromOffset(0, 0)
			v13.Size = UDim2.new(1, 0, 0, 18)
			v13.BackgroundTransparency = 1
			v13.Text = "ITEMS LOST"
			v13.Font = Enum.Font.RobotoCondensed
			v13.TextColor3 = Color3.fromRGB(170, 160, 145)
			v13.TextSize = 15
			v13.TextXAlignment = Enum.TextXAlignment.Left
			v13.TextTransparency = 1
			v13.Parent = v12
			v14 = Instance.new("Frame")
			v14.Name = "TopDivider"
			v14.Position = UDim2.fromOffset(0, 24)
			v14.Size = UDim2.new(1, 0, 0, 1)
			v14.BackgroundColor3 = Color3.fromRGB(70, 65, 58)
			v14.BackgroundTransparency = 1
			v14.BorderSizePixel = 0
			v14.Parent = v12
			v16 = Instance.new("ScrollingFrame")
			v16.Name = "LostScroll"
			v16.Position = UDim2.fromOffset(0, 32)
			v16.Size = UDim2.new(1, 0, 1, -84)
			v16.BackgroundTransparency = 1
			v16.BorderSizePixel = 0
			v16.ScrollBarThickness = 4
			v16.ScrollBarImageColor3 = Color3.fromRGB(150, 140, 125)
			v16.CanvasSize = UDim2.fromScale(0, 0)
			v16.AutomaticCanvasSize = Enum.AutomaticSize.Y
			v16.Parent = v12

			local UIListLayout = Instance.new("UIListLayout")

			UIListLayout.FillDirection = Enum.FillDirection.Vertical
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 4)
			UIListLayout.Parent = v16
			v17 = Instance.new("TextLabel")
			v17.Name = "EmptyLabel"
			v17.AnchorPoint = Vector2.new(0.5, 0.5)
			v17.Position = UDim2.new(0.5, 0, 0.4, 0)
			v17.Size = UDim2.new(0.9, 0, 0, 24)
			v17.BackgroundTransparency = 1
			v17.Text = "Nothing lost"
			v17.Font = Enum.Font.RobotoCondensed
			v17.TextColor3 = Color3.fromRGB(150, 140, 125)
			v17.TextSize = 16
			v17.TextTransparency = 1
			v17.Parent = v12
			v15 = Instance.new("Frame")
			v15.Name = "BottomDivider"
			v15.AnchorPoint = Vector2.new(0, 1)
			v15.Position = UDim2.new(0, 0, 1, -44)
			v15.Size = UDim2.new(1, 0, 0, 1)
			v15.BackgroundColor3 = Color3.fromRGB(70, 65, 58)
			v15.BackgroundTransparency = 1
			v15.BorderSizePixel = 0
			v15.Parent = v12
			v18 = Instance.new("TextButton")
			v18.Name = "RespawnButton"
			v18.AnchorPoint = Vector2.new(0.5, 1)
			v18.Position = UDim2.new(0.5, 0, 1, 0)
			v18.Size = UDim2.new(0.7, 0, 0, 34)
			v18.BackgroundColor3 = Color3.fromRGB(35, 33, 30)
			v18.BackgroundTransparency = 1
			v18.Text = "RESPAWN"
			v18.Font = Enum.Font.RobotoCondensed
			v18.TextColor3 = Color3.fromRGB(245, 232, 210)
			v18.TextScaled = false
			v18.TextSize = 20
			v18.TextTransparency = 1
			v18.AutoButtonColor = false
			v18.BorderSizePixel = 0
			v18.Parent = v12

			local UICorner2 = Instance.new("UICorner")

			UICorner2.CornerRadius = UDim.new(0, 4)
			UICorner2.Parent = v18

			local UIStroke2 = Instance.new("UIStroke")

			UIStroke2.Color = Color3.fromRGB(180, 170, 150)
			UIStroke2.Thickness = 1
			UIStroke2.Transparency = 1
			UIStroke2.Parent = v18
		end
	end
	v20 = function() --[[ clearLostRows | Line: 259 | Upvalues: v16 (ref) ]]
		if not v16 then
			return
		end

		for i2, v in ipairs(v16:GetChildren()) do
			if v:IsA("Frame") then
				v:Destroy()
			end
		end
	end
	v21 = function(p13) --[[ renderLostList | Line: 266 | Upvalues: v16 (ref), v20 (copy), v17 (ref), ItemDatabase (copy) ]]
		if not v16 then
			return
		end

		v20()

		local v1 = p13 and #p13 or 0

		v16.Visible = if v1 > 0 then true else false
		v17.TextTransparency = if v1 == 0 then 0 else 1

		if v1 == 0 then
			return
		end

		for i2, v in ipairs(p13) do
			local v6, v7
			local v8 = ItemDatabase.GetItemData(v.id)

			v6 = v8 and (if type(v8.ImageID) == "string" then if v8.ImageID == "" then false else true else false)

			local Frame = Instance.new("Frame")

			Frame.Name = "Row" .. i2
			Frame.Size = UDim2.new(1, -6, 0, 34)
			Frame.BackgroundTransparency = 1
			Frame.BorderSizePixel = 0
			Frame.LayoutOrder = i2
			Frame.Parent = v16

			local Icon = Instance.new("ImageLabel")

			Icon.Name = "Icon"
			Icon.Size = UDim2.fromOffset(28, 28)
			Icon.Position = UDim2.fromOffset(2, 3)
			Icon.BorderSizePixel = 0

			if v6 then
				Icon.BackgroundTransparency = 1
				Icon.Image = v8.ImageID
			else
				Icon.Image = ""
				Icon.BackgroundColor3 = Color3.fromRGB(45, 43, 40)
				Icon.BackgroundTransparency = 0.5

				local UIStroke = Instance.new("UIStroke")

				UIStroke.Color = Color3.fromRGB(90, 85, 78)
				UIStroke.Thickness = 1
				UIStroke.Parent = Icon
			end

			Icon.Parent = Frame

			local Name = Instance.new("TextLabel")

			Name.Name = "Name"
			Name.Position = UDim2.fromOffset(38, 0)
			Name.Size = UDim2.new(1, -104, 1, 0)
			Name.BackgroundTransparency = 1
			Name.Font = Enum.Font.RobotoCondensed
			Name.TextColor3 = Color3.fromRGB(220, 210, 190)
			Name.TextSize = 18
			Name.TextXAlignment = Enum.TextXAlignment.Left
			Name.TextYAlignment = Enum.TextYAlignment.Center
			Name.TextTruncate = Enum.TextTruncate.AtEnd

			local v9

			if v8 then
				v7 = v8.Name

				if not v7 then
					v9 = v.id
					v7 = tostring(v9)
				end
			else
				v9 = v.id
				v7 = tostring(v9)
			end

			Name.Text = v7
			Name.Parent = Frame

			if (v.count or 1) > 1 then
				local Count = Instance.new("TextLabel")

				Count.Name = "Count"
				Count.AnchorPoint = Vector2.new(1, 0.5)
				Count.Position = UDim2.new(1, -2, 0.5, 0)
				Count.Size = UDim2.new(0, 60, 1, 0)
				Count.BackgroundTransparency = 1
				Count.Font = Enum.Font.RobotoCondensed
				Count.TextColor3 = Color3.fromRGB(180, 170, 150)
				Count.TextSize = 18
				Count.TextXAlignment = Enum.TextXAlignment.Right
				Count.TextYAlignment = Enum.TextYAlignment.Center
				Count.Text = "x" .. v.count
				Count.Parent = Frame
			end
		end
	end
	v22 = function() --[[ playInstantDeath | Line: 340 | Upvalues: v19 (copy), v9 (ref), RunService (copy), UserInputService (copy), v10 (ref), v6 (copy), v7 (copy), Tinnitus (copy), v21 (copy), v3 (ref), TweenService (copy), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), v18 (ref), v17 (ref) ]]
		v19()
		v9.Enabled = true
		RunService:BindToRenderStep("DeathScreenMouseFree", Enum.RenderPriority.Last.Value, function() --[[ Line: 49 | Upvalues: UserInputService (ref) ]]
			if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			if UserInputService.MouseIconEnabled then
				return
			end

			UserInputService.MouseIconEnabled = true
		end)
		v10.BackgroundTransparency = 0
		v6()
		v7(0, 0.15)
		Tinnitus:Play()
		v21(v3 or {})
		task.wait(0.2)

		local v4 = TweenInfo.new(0.3)

		TweenService:Create(v11, v4, {
			TextTransparency = 0
		}):Play()
		TweenService:Create(v12, v4, {
			BackgroundTransparency = 0.12
		}):Play()

		local UIStroke = v12:FindFirstChildOfClass("UIStroke")

		if UIStroke then
			TweenService:Create(UIStroke, v4, {
				Transparency = 0
			}):Play()
		end

		TweenService:Create(v13, v4, {
			TextTransparency = 0
		}):Play()
		TweenService:Create(v14, v4, {
			BackgroundTransparency = 0
		}):Play()
		TweenService:Create(v15, v4, {
			BackgroundTransparency = 0
		}):Play()
		TweenService:Create(v18, v4, {
			BackgroundTransparency = 0.2,
			TextTransparency = 0
		}):Play()

		local UIStroke2 = v18:FindFirstChildOfClass("UIStroke")

		if UIStroke2 then
			TweenService:Create(UIStroke2, v4, {
				Transparency = 0
			}):Play()
		end

		if not (if v3 == nil then true else #v3 == 0) then
			return
		end

		TweenService:Create(v17, v4, {
			TextTransparency = 0
		}):Play()
	end
	task.spawn(function() --[[ Line: 374 | Upvalues: v18 (ref), TweenService (copy), v11 (ref), v10 (ref), v9 (ref), RequestRespawn (copy) ]]
		while not v18 do
			task.wait(0.1)
		end

		v18.MouseButton1Click:Connect(function() --[[ Line: 376 | Upvalues: v18 (ref), TweenService (ref), v11 (ref), v10 (ref), v9 (ref), RequestRespawn (ref) ]]
			if v18.TextTransparency > 0 then
				return
			end

			v18.TextTransparency = 1

			local UIStroke = v18:FindFirstChildOfClass("UIStroke")

			if not UIStroke then
				TweenService:Create(v11, TweenInfo.new(0.5), {
					TextTransparency = 1
				}):Play()
				TweenService:Create(v10, TweenInfo.new(0.5), {
					BackgroundTransparency = 1
				}):Play()
				task.wait(0.5)
				v9.Enabled = false
				RequestRespawn:FireServer()

				return
			end

			UIStroke.Transparency = 1
			TweenService:Create(v11, TweenInfo.new(0.5), {
				TextTransparency = 1
			}):Play()
			TweenService:Create(v10, TweenInfo.new(0.5), {
				BackgroundTransparency = 1
			}):Play()
			task.wait(0.5)
			v9.Enabled = false
			RequestRespawn:FireServer()
		end)
		v18.MouseEnter:Connect(function() --[[ Line: 387 | Upvalues: v18 (ref) ]]
			local UIStroke = v18:FindFirstChildOfClass("UIStroke")

			if not UIStroke then
				return
			end

			UIStroke.Color = Color3.fromRGB(255, 245, 220)
		end)
		v18.MouseLeave:Connect(function() --[[ Line: 391 | Upvalues: v18 (ref) ]]
			local UIStroke = v18:FindFirstChildOfClass("UIStroke")

			if not UIStroke then
				return
			end

			UIStroke.Color = Color3.fromRGB(180, 170, 150)
		end)
	end)
	ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LostItems").OnClientEvent:Connect(function(p13) --[[ Line: 400 | Upvalues: v3 (ref), v9 (ref), v21 (copy) ]]
		v3 = p13

		if not (v9 and v9.Enabled) then
			return
		end

		v21(p13)
	end)
	PlayDeathScreen.OnClientEvent:Connect(function(p13) --[[ Line: 410 | Upvalues: v1 (ref), v22 (copy) ]]
		if v1 then
			return
		end

		v1 = true
		print(string.format("[DeathScreenClient] Death received: cause=%s", (tostring(if p13 then p13.cause else p13))))
		v22()
	end)
	LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 420 | Upvalues: v1 (ref), RunService (copy), v2 (copy), v3 (ref), v9 (ref), v10 (ref), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), v17 (ref), v18 (ref), v20 (copy), Tinnitus (copy), v7 (copy), v8 (copy) ]]
		v1 = false
		pcall(function() --[[ Line: 59 | Upvalues: RunService (ref) ]]
			RunService:UnbindFromRenderStep("DeathScreenMouseFree")
		end)
		v2.CameraType = Enum.CameraType.Custom
		v3 = nil

		if v9 then
			v9.Enabled = false
			v10.BackgroundTransparency = 1
			v11.TextTransparency = 1
			v12.BackgroundTransparency = 1

			local UIStroke = v12:FindFirstChildOfClass("UIStroke")

			if UIStroke then
				UIStroke.Transparency = 1
			end

			v13.TextTransparency = 1
			v14.BackgroundTransparency = 1
			v15.BackgroundTransparency = 1
			v17.TextTransparency = 1
			v18.BackgroundTransparency = 1
			v18.TextTransparency = 1

			local UIStroke2 = v18:FindFirstChildOfClass("UIStroke")

			if UIStroke2 then
				UIStroke2.Transparency = 1
			end

			v20()
		end

		if not Tinnitus.IsPlaying then
			v7(1, 0.5)
			task.delay(0.6, v8)

			return
		end

		Tinnitus:Stop()
		v7(1, 0.5)
		task.delay(0.6, v8)
	end)
	print("[DeathScreenClient] Initialized (dossier panel)")

	return
end

DeathScreen.Enabled = false
PlayerGui.ChildAdded:Connect(function(p13) --[[ Line: 31 ]]
	if p13.Name ~= "DeathScreen" then
		return
	end

	p13.Enabled = false
end)
v1 = false
v2 = Workspace.CurrentCamera
v3 = nil
_ = function() --[[ startMouseOverride | Line: 48 | Upvalues: RunService (copy), UserInputService (copy) ]]
	RunService:BindToRenderStep("DeathScreenMouseFree", Enum.RenderPriority.Last.Value, function() --[[ Line: 49 | Upvalues: UserInputService (ref) ]]
		if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end

		if UserInputService.MouseIconEnabled then
			return
		end

		UserInputService.MouseIconEnabled = true
	end)
end
_2 = function() --[[ stopMouseOverride | Line: 58 | Upvalues: RunService (copy) ]]
	pcall(function() --[[ Line: 59 | Upvalues: RunService (ref) ]]
		RunService:UnbindFromRenderStep("DeathScreenMouseFree")
	end)
end
Tinnitus = Instance.new("Sound")
Tinnitus.Name = "Tinnitus"
Tinnitus.SoundId = "rbxassetid://4155293439"
Tinnitus.Volume = 1.2
Tinnitus.Looped = false
Tinnitus.Parent = script
v4 = {}
v5 = { Workspace, SoundService }
v6 = function() --[[ captureWorldVolumes | Line: 78 | Upvalues: v4 (copy), v5 (copy) ]]
	table.clear(v4)

	for i2, v in ipairs(v5) do
		for i22, v3 in ipairs(v:GetDescendants()) do
			if v3:IsA("Sound") and (v3.Volume > 0 and not v3:IsDescendantOf(script)) then
				v4[v3] = v3.Volume
			end
		end
	end
end
v7 = function(p13, p23) --[[ fadeWorldVolume | Line: 89 | Upvalues: v4 (copy), TweenService (copy) ]]
	for k2, v in pairs(v4) do
		if k2.Parent then
			TweenService:Create(k2, TweenInfo.new(p23), {
				Volume = v * p13
			}):Play()
		end
	end
end
v8 = function() --[[ restoreWorldVolume | Line: 98 | Upvalues: v4 (copy) ]]
	for k2, v in pairs(v4) do
		if k2.Parent then
			k2.Volume = v
		end
	end

	table.clear(v4)
end
v9 = nil
v10 = nil
v11 = nil
v12 = nil
v13 = nil
v14 = nil
v15 = nil
v16 = nil
v17 = nil
v18 = nil
v19 = function() --[[ buildGui | Line: 110 | Upvalues: v9 (ref), LocalPlayer (copy), v10 (ref), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v16 (ref), v17 (ref), v15 (ref), v18 (ref) ]]
	if not v9 then
		local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

		v9 = Instance.new("ScreenGui")
		v9.Name = "DeathScreen_New"
		v9.IgnoreGuiInset = true
		v9.ResetOnSpawn = false
		v9.DisplayOrder = 200
		v9.Enabled = false
		v9.Parent = PlayerGui
		v10 = Instance.new("Frame")
		v10.Name = "Black"
		v10.Size = UDim2.new(1, 0, 1, 0)
		v10.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
		v10.BackgroundTransparency = 1
		v10.BorderSizePixel = 0
		v10.Parent = v9
		v11 = Instance.new("TextLabel")
		v11.Name = "LostText"
		v11.Size = UDim2.new(0.6, 0, 0.08, 0)
		v11.AnchorPoint = Vector2.new(0.5, 0.5)
		v11.Position = UDim2.new(0.5, 0, 0.13, 0)
		v11.BackgroundTransparency = 1
		v11.Text = "Lost to the Zone"
		v11.Font = Enum.Font.RobotoCondensed
		v11.TextColor3 = Color3.fromRGB(245, 232, 210)
		v11.TextScaled = true
		v11.TextTransparency = 1
		v11.Parent = v9
		v12 = Instance.new("Frame")
		v12.Name = "Panel"
		v12.AnchorPoint = Vector2.new(0.5, 0.5)
		v12.Position = UDim2.new(0.5, 0, 0.56, 0)
		v12.Size = UDim2.new(0.36, 0, 0.6, 0)
		v12.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
		v12.BackgroundTransparency = 1
		v12.BorderSizePixel = 0
		v12.Parent = v9

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = v12

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = Color3.fromRGB(85, 80, 72)
		UIStroke.Thickness = 1
		UIStroke.Transparency = 1
		UIStroke.Parent = v12

		local UIPadding = Instance.new("UIPadding")

		UIPadding.PaddingTop = UDim.new(0, 14)
		UIPadding.PaddingBottom = UDim.new(0, 14)
		UIPadding.PaddingLeft = UDim.new(0, 14)
		UIPadding.PaddingRight = UDim.new(0, 14)
		UIPadding.Parent = v12
		v13 = Instance.new("TextLabel")
		v13.Name = "Subheader"
		v13.Position = UDim2.fromOffset(0, 0)
		v13.Size = UDim2.new(1, 0, 0, 18)
		v13.BackgroundTransparency = 1
		v13.Text = "ITEMS LOST"
		v13.Font = Enum.Font.RobotoCondensed
		v13.TextColor3 = Color3.fromRGB(170, 160, 145)
		v13.TextSize = 15
		v13.TextXAlignment = Enum.TextXAlignment.Left
		v13.TextTransparency = 1
		v13.Parent = v12
		v14 = Instance.new("Frame")
		v14.Name = "TopDivider"
		v14.Position = UDim2.fromOffset(0, 24)
		v14.Size = UDim2.new(1, 0, 0, 1)
		v14.BackgroundColor3 = Color3.fromRGB(70, 65, 58)
		v14.BackgroundTransparency = 1
		v14.BorderSizePixel = 0
		v14.Parent = v12
		v16 = Instance.new("ScrollingFrame")
		v16.Name = "LostScroll"
		v16.Position = UDim2.fromOffset(0, 32)
		v16.Size = UDim2.new(1, 0, 1, -84)
		v16.BackgroundTransparency = 1
		v16.BorderSizePixel = 0
		v16.ScrollBarThickness = 4
		v16.ScrollBarImageColor3 = Color3.fromRGB(150, 140, 125)
		v16.CanvasSize = UDim2.fromScale(0, 0)
		v16.AutomaticCanvasSize = Enum.AutomaticSize.Y
		v16.Parent = v12

		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout.FillDirection = Enum.FillDirection.Vertical
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 4)
		UIListLayout.Parent = v16
		v17 = Instance.new("TextLabel")
		v17.Name = "EmptyLabel"
		v17.AnchorPoint = Vector2.new(0.5, 0.5)
		v17.Position = UDim2.new(0.5, 0, 0.4, 0)
		v17.Size = UDim2.new(0.9, 0, 0, 24)
		v17.BackgroundTransparency = 1
		v17.Text = "Nothing lost"
		v17.Font = Enum.Font.RobotoCondensed
		v17.TextColor3 = Color3.fromRGB(150, 140, 125)
		v17.TextSize = 16
		v17.TextTransparency = 1
		v17.Parent = v12
		v15 = Instance.new("Frame")
		v15.Name = "BottomDivider"
		v15.AnchorPoint = Vector2.new(0, 1)
		v15.Position = UDim2.new(0, 0, 1, -44)
		v15.Size = UDim2.new(1, 0, 0, 1)
		v15.BackgroundColor3 = Color3.fromRGB(70, 65, 58)
		v15.BackgroundTransparency = 1
		v15.BorderSizePixel = 0
		v15.Parent = v12
		v18 = Instance.new("TextButton")
		v18.Name = "RespawnButton"
		v18.AnchorPoint = Vector2.new(0.5, 1)
		v18.Position = UDim2.new(0.5, 0, 1, 0)
		v18.Size = UDim2.new(0.7, 0, 0, 34)
		v18.BackgroundColor3 = Color3.fromRGB(35, 33, 30)
		v18.BackgroundTransparency = 1
		v18.Text = "RESPAWN"
		v18.Font = Enum.Font.RobotoCondensed
		v18.TextColor3 = Color3.fromRGB(245, 232, 210)
		v18.TextScaled = false
		v18.TextSize = 20
		v18.TextTransparency = 1
		v18.AutoButtonColor = false
		v18.BorderSizePixel = 0
		v18.Parent = v12

		local UICorner2 = Instance.new("UICorner")

		UICorner2.CornerRadius = UDim.new(0, 4)
		UICorner2.Parent = v18

		local UIStroke2 = Instance.new("UIStroke")

		UIStroke2.Color = Color3.fromRGB(180, 170, 150)
		UIStroke2.Thickness = 1
		UIStroke2.Transparency = 1
		UIStroke2.Parent = v18
	end
end
v20 = function() --[[ clearLostRows | Line: 259 | Upvalues: v16 (ref) ]]
	if not v16 then
		return
	end

	for i2, v in ipairs(v16:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
end
v21 = function(p13) --[[ renderLostList | Line: 266 | Upvalues: v16 (ref), v20 (copy), v17 (ref), ItemDatabase (copy) ]]
	if not v16 then
		return
	end

	v20()

	local v1 = p13 and #p13 or 0

	v16.Visible = if v1 > 0 then true else false
	v17.TextTransparency = if v1 == 0 then 0 else 1

	if v1 == 0 then
		return
	end

	for i2, v in ipairs(p13) do
		local v6, v7
		local v8 = ItemDatabase.GetItemData(v.id)

		v6 = v8 and (if type(v8.ImageID) == "string" then if v8.ImageID == "" then false else true else false)

		local Frame = Instance.new("Frame")

		Frame.Name = "Row" .. i2
		Frame.Size = UDim2.new(1, -6, 0, 34)
		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.LayoutOrder = i2
		Frame.Parent = v16

		local Icon = Instance.new("ImageLabel")

		Icon.Name = "Icon"
		Icon.Size = UDim2.fromOffset(28, 28)
		Icon.Position = UDim2.fromOffset(2, 3)
		Icon.BorderSizePixel = 0

		if v6 then
			Icon.BackgroundTransparency = 1
			Icon.Image = v8.ImageID
		else
			Icon.Image = ""
			Icon.BackgroundColor3 = Color3.fromRGB(45, 43, 40)
			Icon.BackgroundTransparency = 0.5

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = Color3.fromRGB(90, 85, 78)
			UIStroke.Thickness = 1
			UIStroke.Parent = Icon
		end

		Icon.Parent = Frame

		local Name = Instance.new("TextLabel")

		Name.Name = "Name"
		Name.Position = UDim2.fromOffset(38, 0)
		Name.Size = UDim2.new(1, -104, 1, 0)
		Name.BackgroundTransparency = 1
		Name.Font = Enum.Font.RobotoCondensed
		Name.TextColor3 = Color3.fromRGB(220, 210, 190)
		Name.TextSize = 18
		Name.TextXAlignment = Enum.TextXAlignment.Left
		Name.TextYAlignment = Enum.TextYAlignment.Center
		Name.TextTruncate = Enum.TextTruncate.AtEnd

		local v9

		if v8 then
			v7 = v8.Name

			if not v7 then
				v9 = v.id
				v7 = tostring(v9)
			end
		else
			v9 = v.id
			v7 = tostring(v9)
		end

		Name.Text = v7
		Name.Parent = Frame

		if (v.count or 1) > 1 then
			local Count = Instance.new("TextLabel")

			Count.Name = "Count"
			Count.AnchorPoint = Vector2.new(1, 0.5)
			Count.Position = UDim2.new(1, -2, 0.5, 0)
			Count.Size = UDim2.new(0, 60, 1, 0)
			Count.BackgroundTransparency = 1
			Count.Font = Enum.Font.RobotoCondensed
			Count.TextColor3 = Color3.fromRGB(180, 170, 150)
			Count.TextSize = 18
			Count.TextXAlignment = Enum.TextXAlignment.Right
			Count.TextYAlignment = Enum.TextYAlignment.Center
			Count.Text = "x" .. v.count
			Count.Parent = Frame
		end
	end
end
v22 = function() --[[ playInstantDeath | Line: 340 | Upvalues: v19 (copy), v9 (ref), RunService (copy), UserInputService (copy), v10 (ref), v6 (copy), v7 (copy), Tinnitus (copy), v21 (copy), v3 (ref), TweenService (copy), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), v18 (ref), v17 (ref) ]]
	v19()
	v9.Enabled = true
	RunService:BindToRenderStep("DeathScreenMouseFree", Enum.RenderPriority.Last.Value, function() --[[ Line: 49 | Upvalues: UserInputService (ref) ]]
		if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end

		if UserInputService.MouseIconEnabled then
			return
		end

		UserInputService.MouseIconEnabled = true
	end)
	v10.BackgroundTransparency = 0
	v6()
	v7(0, 0.15)
	Tinnitus:Play()
	v21(v3 or {})
	task.wait(0.2)

	local v4 = TweenInfo.new(0.3)

	TweenService:Create(v11, v4, {
		TextTransparency = 0
	}):Play()
	TweenService:Create(v12, v4, {
		BackgroundTransparency = 0.12
	}):Play()

	local UIStroke = v12:FindFirstChildOfClass("UIStroke")

	if UIStroke then
		TweenService:Create(UIStroke, v4, {
			Transparency = 0
		}):Play()
	end

	TweenService:Create(v13, v4, {
		TextTransparency = 0
	}):Play()
	TweenService:Create(v14, v4, {
		BackgroundTransparency = 0
	}):Play()
	TweenService:Create(v15, v4, {
		BackgroundTransparency = 0
	}):Play()
	TweenService:Create(v18, v4, {
		BackgroundTransparency = 0.2,
		TextTransparency = 0
	}):Play()

	local UIStroke2 = v18:FindFirstChildOfClass("UIStroke")

	if UIStroke2 then
		TweenService:Create(UIStroke2, v4, {
			Transparency = 0
		}):Play()
	end

	if not (if v3 == nil then true else #v3 == 0) then
		return
	end

	TweenService:Create(v17, v4, {
		TextTransparency = 0
	}):Play()
end
task.spawn(function() --[[ Line: 374 | Upvalues: v18 (ref), TweenService (copy), v11 (ref), v10 (ref), v9 (ref), RequestRespawn (copy) ]]
	while not v18 do
		task.wait(0.1)
	end

	v18.MouseButton1Click:Connect(function() --[[ Line: 376 | Upvalues: v18 (ref), TweenService (ref), v11 (ref), v10 (ref), v9 (ref), RequestRespawn (ref) ]]
		if v18.TextTransparency > 0 then
			return
		end

		v18.TextTransparency = 1

		local UIStroke = v18:FindFirstChildOfClass("UIStroke")

		if not UIStroke then
			TweenService:Create(v11, TweenInfo.new(0.5), {
				TextTransparency = 1
			}):Play()
			TweenService:Create(v10, TweenInfo.new(0.5), {
				BackgroundTransparency = 1
			}):Play()
			task.wait(0.5)
			v9.Enabled = false
			RequestRespawn:FireServer()

			return
		end

		UIStroke.Transparency = 1
		TweenService:Create(v11, TweenInfo.new(0.5), {
			TextTransparency = 1
		}):Play()
		TweenService:Create(v10, TweenInfo.new(0.5), {
			BackgroundTransparency = 1
		}):Play()
		task.wait(0.5)
		v9.Enabled = false
		RequestRespawn:FireServer()
	end)
	v18.MouseEnter:Connect(function() --[[ Line: 387 | Upvalues: v18 (ref) ]]
		local UIStroke = v18:FindFirstChildOfClass("UIStroke")

		if not UIStroke then
			return
		end

		UIStroke.Color = Color3.fromRGB(255, 245, 220)
	end)
	v18.MouseLeave:Connect(function() --[[ Line: 391 | Upvalues: v18 (ref) ]]
		local UIStroke = v18:FindFirstChildOfClass("UIStroke")

		if not UIStroke then
			return
		end

		UIStroke.Color = Color3.fromRGB(180, 170, 150)
	end)
end)
ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LostItems").OnClientEvent:Connect(function(p13) --[[ Line: 400 | Upvalues: v3 (ref), v9 (ref), v21 (copy) ]]
	v3 = p13

	if not (v9 and v9.Enabled) then
		return
	end

	v21(p13)
end)
PlayDeathScreen.OnClientEvent:Connect(function(p13) --[[ Line: 410 | Upvalues: v1 (ref), v22 (copy) ]]
	if v1 then
		return
	end

	v1 = true
	print(string.format("[DeathScreenClient] Death received: cause=%s", (tostring(if p13 then p13.cause else p13))))
	v22()
end)
LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 420 | Upvalues: v1 (ref), RunService (copy), v2 (copy), v3 (ref), v9 (ref), v10 (ref), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), v17 (ref), v18 (ref), v20 (copy), Tinnitus (copy), v7 (copy), v8 (copy) ]]
	v1 = false
	pcall(function() --[[ Line: 59 | Upvalues: RunService (ref) ]]
		RunService:UnbindFromRenderStep("DeathScreenMouseFree")
	end)
	v2.CameraType = Enum.CameraType.Custom
	v3 = nil

	if v9 then
		v9.Enabled = false
		v10.BackgroundTransparency = 1
		v11.TextTransparency = 1
		v12.BackgroundTransparency = 1

		local UIStroke = v12:FindFirstChildOfClass("UIStroke")

		if UIStroke then
			UIStroke.Transparency = 1
		end

		v13.TextTransparency = 1
		v14.BackgroundTransparency = 1
		v15.BackgroundTransparency = 1
		v17.TextTransparency = 1
		v18.BackgroundTransparency = 1
		v18.TextTransparency = 1

		local UIStroke2 = v18:FindFirstChildOfClass("UIStroke")

		if UIStroke2 then
			UIStroke2.Transparency = 1
		end

		v20()
	end

	if not Tinnitus.IsPlaying then
		v7(1, 0.5)
		task.delay(0.6, v8)

		return
	end

	Tinnitus:Stop()
	v7(1, 0.5)
	task.delay(0.6, v8)
end)
print("[DeathScreenClient] Initialized (dossier panel)")