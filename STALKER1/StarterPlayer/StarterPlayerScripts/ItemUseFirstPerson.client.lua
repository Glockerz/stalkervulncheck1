-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local v1 = false
local v2 = nil

local function showArms() --[[ showArms | Line: 9 | Upvalues: v1 (ref), LocalPlayer (copy), v2 (ref), RunService (copy) ]]
	v1 = true

	if LocalPlayer.Character then
		v2 = RunService.RenderStepped:Connect(function() --[[ Line: 15 | Upvalues: v1 (ref), LocalPlayer (ref) ]]
			if not v1 then
				return
			end

			local Character = LocalPlayer.Character

			if not Character then
				return
			end

			local v12 = Character:FindFirstChild("Right Arm")
			local v2 = Character:FindFirstChild("Left Arm")

			if v12 then
				v12.LocalTransparencyModifier = 0
			end

			if v2 then
				v2.LocalTransparencyModifier = 0
			end

			local Handle = Character:FindFirstChild("Handle")

			if not Handle then
				return
			end

			Handle.LocalTransparencyModifier = 0

			for v3, v4 in Handle:GetDescendants() do
				if v4:IsA("BasePart") then
					v4.LocalTransparencyModifier = 0
				end
			end
		end)
	end
end

local function hideArms() --[[ hideArms | Line: 39 | Upvalues: v1 (ref), v2 (ref) ]]
	v1 = false

	if not v2 then
		return
	end

	v2:Disconnect()
	v2 = nil
end

local ItemUseLoadingGui = Instance.new("ScreenGui")

ItemUseLoadingGui.Name = "ItemUseLoadingGui"
ItemUseLoadingGui.ResetOnSpawn = false
ItemUseLoadingGui.DisplayOrder = 10
ItemUseLoadingGui.Parent = LocalPlayer.PlayerGui

local LoadingContainer = Instance.new("Frame")

LoadingContainer.Name = "LoadingContainer"
LoadingContainer.Size = UDim2.new(0, 200, 0, 30)
LoadingContainer.Position = UDim2.new(0.5, 0, 0.75, 0)
LoadingContainer.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadingContainer.BackgroundTransparency = 0.5
LoadingContainer.BorderSizePixel = 0
LoadingContainer.Visible = false
LoadingContainer.Parent = ItemUseLoadingGui

local UICorner = Instance.new("UICorner")

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = LoadingContainer

local Fill = Instance.new("Frame")

Fill.Name = "Fill"
Fill.Size = UDim2.new(0, 0, 1, 0)
Fill.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
Fill.BackgroundTransparency = 0.3
Fill.BorderSizePixel = 0
Fill.Parent = LoadingContainer

local UICorner2 = Instance.new("UICorner")

UICorner2.CornerRadius = UDim.new(0, 4)
UICorner2.Parent = Fill

local ItemLabel = Instance.new("TextLabel")

ItemLabel.Name = "ItemLabel"
ItemLabel.Size = UDim2.new(1, 0, 0, 18)
ItemLabel.Position = UDim2.new(0, 0, -1, -2)
ItemLabel.BackgroundTransparency = 1
ItemLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
ItemLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
ItemLabel.TextSize = 30
ItemLabel.Text = ""
ItemLabel.Parent = LoadingContainer

local v3 = nil

ReplicatedStorage.Remotes.ItemUseStarted.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 94 | Upvalues: v1 (ref), LocalPlayer (copy), v2 (ref), RunService (copy), ReplicatedStorage (copy), ItemLabel (copy), Fill (copy), LoadingContainer (copy), v3 (ref) ]]
	v1 = true

	if LocalPlayer.Character then
		v2 = RunService.RenderStepped:Connect(function() --[[ Line: 15 | Upvalues: v1 (ref), LocalPlayer (ref) ]]
			if not v1 then
				return
			end

			local Character = LocalPlayer.Character

			if not Character then
				return
			end

			local v12 = Character:FindFirstChild("Right Arm")
			local v2 = Character:FindFirstChild("Left Arm")

			if v12 then
				v12.LocalTransparencyModifier = 0
			end

			if v2 then
				v2.LocalTransparencyModifier = 0
			end

			local Handle = Character:FindFirstChild("Handle")

			if not Handle then
				return
			end

			Handle.LocalTransparencyModifier = 0

			for v3, v4 in Handle:GetDescendants() do
				if v4:IsA("BasePart") then
					v4.LocalTransparencyModifier = 0
				end
			end
		end)
	end

	if LocalPlayer.Character then
		LocalPlayer.Character:SetAttribute("_UsingItem", true)
	end

	local InventoryController = require(ReplicatedStorage:FindFirstChild("InventoryController"))

	if InventoryController then
		InventoryController.IsUsingItem = true
	end

	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

	local TweenService = game:GetService("TweenService")

	ItemLabel.Text = string.upper(p3 or "USING...")
	Fill.Size = UDim2.new(0, 0, 1, 0)
	LoadingContainer.Visible = true
	v3 = TweenService:Create(Fill, TweenInfo.new(p2 or 3, Enum.EasingStyle.Linear), {
		Size = UDim2.new(1, 0, 1, 0)
	})
	v3:Play()

	local Lighting = game:GetService("Lighting")
	local HealEffect = Lighting:FindFirstChild("HealEffect")

	if not HealEffect then
		HealEffect = Instance.new("ColorCorrectionEffect")
		HealEffect.Name = "HealEffect"
		HealEffect.Brightness = 0
		HealEffect.Contrast = 0
		HealEffect.Saturation = 0
		HealEffect.TintColor = Color3.fromRGB(255, 255, 255)
		HealEffect.Parent = Lighting
	end

	task.delay(p1 or 0, function() --[[ Line: 146 | Upvalues: HealEffect (ref), TweenService (copy) ]]
		HealEffect.Brightness = 0.15
		HealEffect.Saturation = -0.2
		HealEffect.TintColor = Color3.fromRGB(230, 255, 230)
		TweenService:Create(HealEffect, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Brightness = 0,
			Saturation = 0,
			TintColor = Color3.fromRGB(255, 255, 255)
		}):Play()
	end)
end)
ReplicatedStorage.Remotes.ItemUseStopped.OnClientEvent:Connect(function() --[[ Line: 159 | Upvalues: v1 (ref), v2 (ref), LocalPlayer (copy), ReplicatedStorage (copy), LoadingContainer (copy), v3 (ref) ]]
	v1 = false

	if v2 then
		v2:Disconnect()
		v2 = nil
	end

	if LocalPlayer.Character then
		LocalPlayer.Character:SetAttribute("_UsingItem", false)
	end

	local InventoryController = require(ReplicatedStorage:FindFirstChild("InventoryController"))

	if InventoryController then
		InventoryController.IsUsingItem = false
	end

	LoadingContainer.Visible = false

	if not v3 then
		return
	end

	v3:Cancel()
	v3 = nil
end)

local function getActiveEffectsFrame() --[[ getActiveEffectsFrame | Line: 178 | Upvalues: LocalPlayer (copy) ]]
	local StatusHUD = LocalPlayer.PlayerGui:FindFirstChild("StatusHUD")

	if not StatusHUD then
		return nil
	end

	local ActiveEffects = StatusHUD:FindFirstChild("ActiveEffects")

	if not ActiveEffects then
		local ActiveEffects2 = Instance.new("Frame")

		ActiveEffects2.Name = "ActiveEffects"
		ActiveEffects2.Size = UDim2.new(0, 250, 0, 55)
		ActiveEffects2.Position = UDim2.new(1, -16, 1, -140)
		ActiveEffects2.AnchorPoint = Vector2.new(1, 1)
		ActiveEffects2.BackgroundTransparency = 1
		ActiveEffects2.Parent = StatusHUD

		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		UIListLayout.Padding = UDim.new(0, 8)
		UIListLayout.Parent = ActiveEffects2
		ActiveEffects = ActiveEffects2
	end

	return ActiveEffects
end

local function createEffectIndicator(p1, p2, p3) --[[ createEffectIndicator | Line: 207 | Upvalues: getActiveEffectsFrame (copy) ]]
	local v1 = getActiveEffectsFrame()

	if v1 then
		local Frame = Instance.new("Frame")

		Frame.Name = (p2 or "Effect") .. "_" .. tostring(tick())
		Frame.Size = UDim2.new(0, 55, 0, 65)
		Frame.BackgroundTransparency = 1
		Frame.LayoutOrder = #v1:GetChildren()
		Frame.Parent = v1

		local Icon = Instance.new("ImageLabel")

		Icon.Name = "Icon"
		Icon.Size = UDim2.new(0, 45, 0, 45)
		Icon.Position = UDim2.new(0.5, 0, 0, 0)
		Icon.AnchorPoint = Vector2.new(0.5, 0)
		Icon.BackgroundTransparency = 1
		Icon.Image = p1 or ""
		Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Icon.ImageTransparency = 0.4
		Icon.ScaleType = Enum.ScaleType.Fit
		Icon.Parent = Frame

		local Timer = Instance.new("TextLabel")

		Timer.Name = "Timer"
		Timer.Size = UDim2.new(1, 0, 0, 16)
		Timer.Position = UDim2.new(0, 0, 1, -16)
		Timer.BackgroundTransparency = 1
		Timer.TextColor3 = Color3.fromRGB(200, 200, 200)
		Timer.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		Timer.TextSize = 13
		Timer.Text = ""
		Timer.Parent = Frame
		task.spawn(function() --[[ Line: 242 | Upvalues: p3 (copy), Timer (copy), Frame (copy) ]]
			local count = p3

			while count > 0 do
				local v1 = math.floor(count / 60)
				local v2 = count % 60

				if v1 > 0 then
					Timer.Text = string.format("%d:%02d", v1, v2)
				else
					Timer.Text = tostring(v2) .. "s"
				end

				task.wait(1)
				count = count - 1
			end

			Frame:Destroy()
		end)
	end
end

local v4 = false
local v5 = nil

local function startAimJitter(p1) --[[ startAimJitter | Line: 263 | Upvalues: v4 (ref), v5 (ref), RunService (copy) ]]
	if not v4 then
		v4 = true

		local CurrentCamera = workspace.CurrentCamera
		local UserInputService = game:GetService("UserInputService")

		v5 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 270 | Upvalues: v4 (ref), UserInputService (copy), CurrentCamera (copy) ]]
			if not v4 then
				return
			end

			if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
				return
			end

			local v1 = (math.random() - 0.5) * 0.003

			CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.Angles(v1, (math.random() - 0.5) * 0.003, 0)
		end)
		task.delay(p1, function() --[[ Line: 280 | Upvalues: v4 (ref), v5 (ref) ]]
			v4 = false

			if not v5 then
				return
			end

			v5:Disconnect()
			v5 = nil
		end)
	end
end

ReplicatedStorage.Remotes.SideEffect.OnClientEvent:Connect(function(p1, p2, p3, p4, p5) --[[ Line: 290 | Upvalues: createEffectIndicator (copy), startAimJitter (copy) ]]
	createEffectIndicator(p3, p4, p2)

	if p5 then
		startAimJitter(p2)
	end

	local TweenService = game:GetService("TweenService")
	local Lighting = game:GetService("Lighting")

	if p1 == "Contrast" then
		local SideEffect = Lighting:FindFirstChild("SideEffect")

		if not SideEffect then
			SideEffect = Instance.new("ColorCorrectionEffect")
			SideEffect.Name = "SideEffect"
			SideEffect.Parent = Lighting
		end

		SideEffect.Contrast = 0
		TweenService:Create(SideEffect, TweenInfo.new(p2 * 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Contrast = 0.5
		}):Play()
		task.delay(p2 * 0.8, function() --[[ Line: 316 | Upvalues: TweenService (copy), SideEffect (ref), p2 (copy) ]]
			TweenService:Create(SideEffect, TweenInfo.new(p2 * 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Contrast = 0
			}):Play()
		end)
	else
		if p1 ~= "Desaturation" then
			return
		end

		local SideEffect = Lighting:FindFirstChild("SideEffect")

		if not SideEffect then
			SideEffect = Instance.new("ColorCorrectionEffect")
			SideEffect.Name = "SideEffect"
			SideEffect.Parent = Lighting
		end

		SideEffect.Saturation = 0
		TweenService:Create(SideEffect, TweenInfo.new(p2 * 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Saturation = -0.8
		}):Play()
		task.delay(p2 * 0.7, function() --[[ Line: 338 | Upvalues: TweenService (copy), SideEffect (ref), p2 (copy) ]]
			TweenService:Create(SideEffect, TweenInfo.new(p2 * 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Saturation = 0
			}):Play()
		end)
	end
end)

local TweenService = game:GetService("TweenService")
local v6 = nil

local function ensureVignette() --[[ ensureVignette | Line: 352 | Upvalues: v6 (ref), LocalPlayer (copy) ]]
	if v6 and v6.Parent then
		return v6
	end

	local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
	local v1 = if PlayerGui then PlayerGui:FindFirstChild("SPH_UI") else PlayerGui
	local v2 = if v1 then v1:FindFirstChild("DamageUI") else v1
	local v3 = if v2 then v2:FindFirstChild("Damage2d") else v2

	if not v3 then
		return nil
	end

	local BleedVignette = v2:FindFirstChild("BleedVignette")

	if not BleedVignette then
		local BleedVignette2 = Instance.new("ImageLabel")

		BleedVignette2.Name = "BleedVignette"
		BleedVignette2.Image = v3.Image
		BleedVignette2.BackgroundTransparency = 1
		BleedVignette2.Size = v3.Size
		BleedVignette2.Position = v3.Position
		BleedVignette2.AnchorPoint = v3.AnchorPoint
		BleedVignette2.ScaleType = v3.ScaleType
		BleedVignette2.ImageColor3 = v3.ImageColor3
		BleedVignette2.ImageTransparency = 1
		BleedVignette2.ZIndex = math.max(1, (v3.ZIndex or 1) - 1)
		BleedVignette2.Parent = v2
		BleedVignette = BleedVignette2
	end

	v6 = BleedVignette

	return BleedVignette
end

ReplicatedStorage.Remotes:WaitForChild("BleedSync").OnClientEvent:Connect(function(p1, p2) --[[ Line: 378 | Upvalues: ensureVignette (copy), TweenService (copy) ]]
	local v1 = ensureVignette()

	if not v1 then
		return
	end

	local v2 = math.clamp((p1 or 0) / (p2 or 1), 0, 1)

	TweenService:Create(v1, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		ImageTransparency = if v2 > 0 then v2 * -0.39999999999999997 + 0.85 or 1 else 1
	}):Play()
end)

local function clearAllEffects() --[[ clearAllEffects | Line: 398 | Upvalues: v1 (ref), v2 (ref), v4 (ref), v5 (ref), LocalPlayer (copy), LoadingContainer (copy), v3 (ref) ]]
	v1 = false

	if v2 then
		v2:Disconnect()
		v2 = nil
	end

	v4 = false

	if v5 then
		v5:Disconnect()
		v5 = nil
	end

	local Lighting = game:GetService("Lighting")

	for i, v in ipairs({ "SideEffect", "HealEffect" }) do
		local v12 = Lighting:FindFirstChild(v)

		if v12 and v12:IsA("ColorCorrectionEffect") then
			v12.Brightness = 0
			v12.Contrast = 0
			v12.Saturation = 0
			v12.TintColor = Color3.fromRGB(255, 255, 255)
		end
	end

	local v22 = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("StatusHUD")
	local v32 = if v22 then v22:FindFirstChild("ActiveEffects") else v22

	if v32 then
		for i, v in ipairs(v32:GetChildren()) do
			if v:IsA("Frame") then
				v:Destroy()
			end
		end
	end

	LoadingContainer.Visible = false

	if not v3 then
		return
	end

	v3:Cancel()
	v3 = nil
end

LocalPlayer.CharacterAdded:Connect(clearAllEffects)

if LocalPlayer.Character then
	local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		Humanoid.Died:Connect(clearAllEffects)
	end
end

LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 434 | Upvalues: clearAllEffects (copy) ]]
	local Humanoid = p1:WaitForChild("Humanoid", 10)

	if not Humanoid then
		return
	end

	Humanoid.Died:Connect(clearAllEffects)
end)