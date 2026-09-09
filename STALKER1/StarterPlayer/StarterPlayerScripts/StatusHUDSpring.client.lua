-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local StatusContainer = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("StatusHUD"):WaitForChild("StatusContainer")

StatusContainer.Position = UDim2.new(1, -16, 1, -68)
StatusContainer.Size = UDim2.fromOffset(250, 64)

local UIListLayout = StatusContainer:FindFirstChildOfClass("UIListLayout")

if UIListLayout then
	UIListLayout.Padding = UDim.new(0, 6)
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
end

local UIPadding = StatusContainer:FindFirstChildOfClass("UIPadding")

if UIPadding then
	UIPadding.PaddingLeft = UDim.new(0, 0)
	UIPadding.PaddingRight = UDim.new(0, 0)
end

local t = {}

local function buildChip(p1) --[[ buildChip | Line: 31 | Upvalues: StatusContainer (copy), t (copy) ]]
	local v1 = StatusContainer:WaitForChild(p1)
	local Frame = Instance.new("Frame")

	Frame.Name = p1 .. "Chip"
	Frame.Size = UDim2.fromOffset(48, 56)
	Frame.LayoutOrder = v1.LayoutOrder
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.Parent = StatusContainer
	v1.Size = UDim2.fromOffset(34, 34)
	v1.Position = UDim2.new(0.5, 0, 0, 5)
	v1.AnchorPoint = Vector2.new(0.5, 0)
	v1.BackgroundTransparency = 1
	v1.Parent = Frame

	local BarTrack = Instance.new("Frame")

	BarTrack.Name = "BarTrack"
	BarTrack.AnchorPoint = Vector2.new(0.5, 1)
	BarTrack.Position = UDim2.new(0.5, 0, 1, -5)
	BarTrack.Size = UDim2.new(1, -12, 0, 6)
	BarTrack.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	BarTrack.BackgroundTransparency = 0.5
	BarTrack.BorderSizePixel = 0
	BarTrack.Parent = Frame

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = BarTrack

	local Fill = Instance.new("Frame")

	Fill.Name = "Fill"
	Fill.Size = UDim2.new(1, 0, 1, 0)
	Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Fill.BorderSizePixel = 0
	Fill.Parent = BarTrack

	local UICorner2 = Instance.new("UICorner")

	UICorner2.CornerRadius = UDim.new(1, 0)
	UICorner2.Parent = Fill
	t[p1] = {
		icon = v1,
		fill = Fill
	}
end

local Bleeding = Instance.new("ImageLabel")

Bleeding.Name = "Bleeding"
Bleeding.Image = "rbxassetid://100351074073995"
Bleeding.BackgroundTransparency = 1
Bleeding.Size = UDim2.fromOffset(34, 34)
Bleeding.ImageColor3 = Color3.fromRGB(200, 40, 40)
Bleeding.ImageTransparency = 1
Bleeding.LayoutOrder = -1
Bleeding.Parent = StatusContainer
buildChip("Bleeding")
buildChip("Blood")
buildChip("Food")
buildChip("Thirst")
buildChip("Radiation")

local BleedingChip = StatusContainer:FindFirstChild("BleedingChip")

if BleedingChip then
	BleedingChip.Visible = false
end

local function setFill(p1, p2, p3) --[[ setFill | Line: 96 ]]
	if p1 then
		p1.fill.Size = UDim2.new(math.clamp(p2 / 100, 0, 1), 0, 1, 0)
		p1.fill.BackgroundColor3 = p3
	end
end

local function getStatusColor(p1) --[[ getStatusColor | Line: 103 ]]
	if p1 >= 90 then
		return Color3.fromRGB(255, 255, 255)
	end

	if p1 >= 70 then
		local v1 = (p1 - 70) / 20

		return Color3.fromRGB(255, math.floor(255 * v1 + 200 * (1 - v1)), (math.floor(255 * v1 + 50 * (1 - v1))))
	end

	if p1 >= 40 then
		local v2 = (p1 - 40) / 30

		return Color3.fromRGB(255, math.floor(200 * v2 + 100 * (1 - v2)), (math.floor(50 * v2)))
	end

	local v3 = p1 / 40

	return Color3.fromRGB(math.floor(255 * v3 + 200 * (1 - v3)), math.floor(100 * v3 + 30 * (1 - v3)), (math.floor(30 * (1 - v3))))
end

local icon = t.Blood.icon

local function connectHealth(p1) --[[ connectHealth | Line: 121 | Upvalues: icon (copy), getStatusColor (copy), t (copy) ]]
	local Humanoid = p1:WaitForChild("Humanoid", 5)

	if not Humanoid then
		return
	end

	local function updateHealth() --[[ updateHealth | Line: 125 | Upvalues: Humanoid (copy), icon (ref), getStatusColor (ref), t (ref) ]]
		local v1 = Humanoid.Health / Humanoid.MaxHealth * 100

		icon.ImageColor3 = getStatusColor(v1)
		icon:SetAttribute("Value", (math.floor(v1)))

		local Blood = t.Blood
		local v2 = getStatusColor(v1)

		if Blood then
			Blood.fill.Size = UDim2.new(math.clamp(v1 / 100, 0, 1), 0, 1, 0)
			Blood.fill.BackgroundColor3 = v2
		end
	end

	Humanoid.HealthChanged:Connect(updateHealth)

	local v1 = Humanoid.Health / Humanoid.MaxHealth * 100

	icon.ImageColor3 = getStatusColor(v1)
	icon:SetAttribute("Value", (math.floor(v1)))

	local Blood = t.Blood
	local v2 = getStatusColor(v1)

	if Blood then
		Blood.fill.Size = UDim2.new(math.clamp(v1 / 100, 0, 1), 0, 1, 0)
		Blood.fill.BackgroundColor3 = v2
	end
end

if LocalPlayer.Character then
	local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid", 5)

	if Humanoid then
		local function updateHealth() --[[ updateHealth | Line: 125 | Upvalues: Humanoid (copy), icon (copy), getStatusColor (copy), t (copy) ]]
			local v1 = Humanoid.Health / Humanoid.MaxHealth * 100

			icon.ImageColor3 = getStatusColor(v1)
			icon:SetAttribute("Value", (math.floor(v1)))

			local Blood = t.Blood
			local v2 = getStatusColor(v1)

			if Blood then
				Blood.fill.Size = UDim2.new(math.clamp(v1 / 100, 0, 1), 0, 1, 0)
				Blood.fill.BackgroundColor3 = v2
			end
		end

		Humanoid.HealthChanged:Connect(updateHealth)

		local v1 = Humanoid.Health / Humanoid.MaxHealth * 100

		icon.ImageColor3 = getStatusColor(v1)
		icon:SetAttribute("Value", (math.floor(v1)))

		local Blood = t.Blood
		local v2 = getStatusColor(v1)

		if Blood then
			Blood.fill.Size = UDim2.new(math.clamp(v1 / 100, 0, 1), 0, 1, 0)
			Blood.fill.BackgroundColor3 = v2
		end
	end
end

LocalPlayer.CharacterAdded:Connect(connectHealth)

local icon2 = t.Food.icon
local icon3 = t.Thirst.icon
local SurvivalSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SurvivalSync", 10)
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local v3 = nil
local v4 = nil
local v5 = false
local v6 = nil

local function updateHungerEffects(p1) --[[ updateHungerEffects | Line: 154 | Upvalues: v3 (ref), Lighting (copy), TweenService (copy), LocalPlayer (copy) ]]
	if p1 <= 30 then
		if not v3 then
			v3 = Instance.new("BlurEffect")
			v3.Name = "HungerBlur"
			v3.Size = 0
			v3.Parent = Lighting
		end

		TweenService:Create(v3, TweenInfo.new(1), {
			Size = (1 - p1 / 30) * 8
		}):Play()
	elseif v3 then
		TweenService:Create(v3, TweenInfo.new(1), {
			Size = 0
		}):Play()
	end

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	if p1 <= 10 then
		Humanoid.WalkSpeed = math.max(8, Humanoid.WalkSpeed * 0.6)

		return
	end

	if not (p1 <= 30) then
		return
	end

	Humanoid.WalkSpeed = math.max(12, Humanoid.WalkSpeed * 0.85)
end

local function updateThirstEffects(p1) --[[ updateThirstEffects | Line: 187 | Upvalues: v4 (ref), Lighting (copy), TweenService (copy), v5 (ref), v6 (ref), RunService (copy), UserInputService (copy) ]]
	if p1 <= 30 then
		if not v4 then
			v4 = Instance.new("ColorCorrectionEffect")
			v4.Name = "ThirstDesat"
			v4.Parent = Lighting
		end

		TweenService:Create(v4, TweenInfo.new(1), {
			Saturation = (1 - p1 / 30) * -0.7
		}):Play()
	elseif v4 then
		TweenService:Create(v4, TweenInfo.new(1), {
			Saturation = 0
		}):Play()
	end

	if p1 <= 20 then
		if not v5 then
			v5 = true

			local CurrentCamera = workspace.CurrentCamera

			v6 = RunService.RenderStepped:Connect(function() --[[ Line: 208 | Upvalues: v5 (ref), UserInputService (ref), p1 (copy), CurrentCamera (copy) ]]
				if not v5 then
					return
				end

				if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
					return
				end

				local v1 = (1 - p1 / 20) * 0.004
				local v2 = (math.random() - 0.5) * v1

				CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.Angles(v2, (math.random() - 0.5) * v1, 0)
			end)
		end
	else
		if not v5 then
			return
		end

		v5 = false

		if not v6 then
			return
		end

		v6:Disconnect()
		v6 = nil
	end
end

if SurvivalSync then
	SurvivalSync.OnClientEvent:Connect(function(p1, p2) --[[ Line: 230 | Upvalues: icon2 (copy), getStatusColor (copy), icon3 (copy), t (copy), updateHungerEffects (copy), updateThirstEffects (copy) ]]
		icon2.ImageColor3 = getStatusColor(p1)
		icon2:SetAttribute("Value", (math.floor(p1)))
		icon3.ImageColor3 = getStatusColor(p2)
		icon3:SetAttribute("Value", (math.floor(p2)))

		local Food = t.Food
		local v1 = getStatusColor(p1)

		if Food then
			Food.fill.Size = UDim2.new(math.clamp(p1 / 100, 0, 1), 0, 1, 0)
			Food.fill.BackgroundColor3 = v1
		end

		local Thirst = t.Thirst
		local v2 = getStatusColor(p2)

		if Thirst then
			Thirst.fill.Size = UDim2.new(math.clamp(p2 / 100, 0, 1), 0, 1, 0)
			Thirst.fill.BackgroundColor3 = v2
		end

		updateHungerEffects(p1)
		updateThirstEffects(p2)
	end)
end

local icon4 = t.Radiation.icon
local RadSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RadSync", 10)

local function getRadColor(p1) --[[ getRadColor | Line: 248 | Upvalues: getStatusColor (copy) ]]
	return getStatusColor(100 - p1)
end

if RadSync and icon4 then
	icon4.ImageTransparency = 0
	RadSync.OnClientEvent:Connect(function(p1, p2) --[[ Line: 257 | Upvalues: icon4 (copy), getStatusColor (copy), t (copy) ]]
		local v1 = p1 / p2 * 100

		icon4.ImageColor3 = getStatusColor(100 - v1)
		icon4:SetAttribute("Value", (math.floor(v1)))

		local Radiation = t.Radiation
		local v2 = getStatusColor(100 - v1)

		if Radiation then
			Radiation.fill.Size = UDim2.new(math.clamp(v1 / 100, 0, 1), 0, 1, 0)
			Radiation.fill.BackgroundColor3 = v2
		end
	end)
end

local Bleeding2 = t.Bleeding
local BleedingChip2 = StatusContainer:FindFirstChild("BleedingChip")
local BleedSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BleedSync", 10)
local v7 = nil

local function setBleedPulse(p1) --[[ setBleedPulse | Line: 271 | Upvalues: v7 (ref), RunService (copy), Bleeding2 (copy) ]]
	if p1 and not v7 then
		local v1 = os.clock()

		v7 = RunService.RenderStepped:Connect(function() --[[ Line: 274 | Upvalues: Bleeding2 (ref), v1 (copy) ]]
			if Bleeding2 and Bleeding2.icon then
				Bleeding2.icon.ImageTransparency = 1 - (math.abs((math.sin((os.clock() - v1) * 4))) * 0.45 + 0.55)
			end
		end)

		return
	end

	if p1 or not v7 then
		return
	end

	v7:Disconnect()
	v7 = nil

	if not (Bleeding2 and Bleeding2.icon) then
		return
	end

	Bleeding2.icon.ImageTransparency = 1
end

if not (BleedSync and Bleeding2) then
	return
end

BleedSync.OnClientEvent:Connect(function(p1, p2) --[[ Line: 287 | Upvalues: BleedingChip2 (copy), Bleeding2 (copy), v7 (ref), RunService (copy) ]]
	local v1 = math.clamp((p1 or 0) / (p2 or 1), 0, 1)

	if v1 > 0 then
		if BleedingChip2 then
			BleedingChip2.Visible = true
		end

		Bleeding2.icon.ImageColor3 = Color3.fromRGB(255, math.floor((1 - v1) * 110), (math.floor((1 - v1) * 110)))

		local v2 = Bleeding2
		local v3 = v1 * 100
		local v4 = Color3.fromRGB(200, 40, 40)

		if v2 then
			v2.fill.Size = UDim2.new(math.clamp(v3 / 100, 0, 1), 0, 1, 0)
			v2.fill.BackgroundColor3 = v4
		end

		if not v7 then
			local v5 = os.clock()

			v7 = RunService.RenderStepped:Connect(function() --[[ Line: 274 | Upvalues: Bleeding2 (ref), v5 (copy) ]]
				if Bleeding2 and Bleeding2.icon then
					Bleeding2.icon.ImageTransparency = 1 - (math.abs((math.sin((os.clock() - v5) * 4))) * 0.45 + 0.55)
				end
			end)
		end
	else
		if v7 then
			v7:Disconnect()
			v7 = nil

			if Bleeding2 and Bleeding2.icon then
				Bleeding2.icon.ImageTransparency = 1
			end
		end

		local v6 = Bleeding2
		local v72 = Color3.fromRGB(200, 40, 40)

		if v6 then
			v6.fill.Size = UDim2.new(0, 0, 1, 0)
			v6.fill.BackgroundColor3 = v72
		end

		if not BleedingChip2 then
			return
		end

		BleedingChip2.Visible = false
	end
end)