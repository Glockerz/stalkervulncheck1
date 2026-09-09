-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local function buildTintGui() --[[ buildTintGui | Line: 20 | Upvalues: LocalPlayer (copy) ]]
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local BurnerScreenTint = PlayerGui:FindFirstChild("BurnerScreenTint")

	if BurnerScreenTint then
		return BurnerScreenTint, BurnerScreenTint.TintFrame
	end

	local BurnerScreenTint2 = Instance.new("ScreenGui")

	BurnerScreenTint2.Name = "BurnerScreenTint"
	BurnerScreenTint2.IgnoreGuiInset = true
	BurnerScreenTint2.ResetOnSpawn = false
	BurnerScreenTint2.DisplayOrder = 100
	BurnerScreenTint2.Enabled = false
	BurnerScreenTint2.Parent = PlayerGui

	local TintFrame = Instance.new("Frame")

	TintFrame.Name = "TintFrame"
	TintFrame.Size = UDim2.new(1, 0, 1, 0)
	TintFrame.BackgroundColor3 = Color3.fromRGB(255, 80, 0)
	TintFrame.BackgroundTransparency = 0.6
	TintFrame.BorderSizePixel = 0
	TintFrame.Parent = BurnerScreenTint2

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.2),
		NumberSequenceKeypoint.new(0.45, 1),
		NumberSequenceKeypoint.new(0.55, 1),
		NumberSequenceKeypoint.new(1, 0.2)
	})
	UIGradient.Rotation = 90
	UIGradient.Parent = TintFrame

	return BurnerScreenTint2, TintFrame
end

local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil

local function applyBurning(p1) --[[ applyBurning | Line: 62 | Upvalues: v1 (ref), v2 (ref), buildTintGui (copy), v4 (ref), v3 (ref), TweenService (copy) ]]
	if not v1 then
		local v12, v22 = buildTintGui()

		v1 = v12
		v2 = v22
	end

	if p1 then
		if v4 then
			v4:Cancel()
			v4 = nil
		end

		if not v3 then
			v1.Enabled = true
			v2.BackgroundTransparency = 0.6
			v3 = TweenService:Create(v2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
				BackgroundTransparency = 0.4
			})
			v3:Play()

			return
		end

		v3:Cancel()
		v3 = nil
		v1.Enabled = true
		v2.BackgroundTransparency = 0.6
		v3 = TweenService:Create(v2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
			BackgroundTransparency = 0.4
		})
		v3:Play()
	else
		if v3 then
			v3:Cancel()
			v3 = nil
		end

		if not v1 then
			return
		end

		v4 = TweenService:Create(v2, TweenInfo.new(0.3), {
			BackgroundTransparency = 1
		})
		v4:Play()
		v4.Completed:Connect(function() --[[ Line: 87 | Upvalues: v1 (ref) ]]
			if not v1 then
				return
			end

			v1.Enabled = false
		end)
	end
end

local function bindCharacter(p1) --[[ bindCharacter | Line: 97 | Upvalues: applyBurning (copy) ]]
	local v1 = applyBurning

	v1(p1:GetAttribute("Burning") == true)
	p1:GetAttributeChangedSignal("Burning"):Connect(function() --[[ Line: 102 | Upvalues: applyBurning (ref), p1 (copy) ]]
		applyBurning(p1:GetAttribute("Burning") == true)
	end)
end

if LocalPlayer.Character then
	bindCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(bindCharacter)
print("[BurnerClient] Initialized")