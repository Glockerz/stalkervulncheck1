-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local LocalPlayer = game.Players.LocalPlayer
local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAppearanceLoaded:Wait()):WaitForChild("Humanoid")
local TweenService = game:GetService("TweenService")
local v2 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local DamageColorCorrection = game.Lighting:FindFirstChild("DamageColorCorrection") or Instance.new("ColorCorrectionEffect", game.Lighting)

DamageColorCorrection.Name = "DamageColorCorrection"

local Heartbeat = script.Parent.Heartbeat

Heartbeat.Volume = 0
Heartbeat:Play()

local Damage2d = script.Parent.Damage2d

Damage2d.BackgroundTransparency = 1
Damage2d.ImageTransparency = 1

local Health = Humanoid.Health

if not require(game.ReplicatedStorage.SPH_Assets.GameConfig).lowHealthEffects then
	return
end

local function UpdateHealthFX() --[[ UpdateHealthFX | Line: 24 | Upvalues: Health (ref), Humanoid (copy), Damage2d (copy), TweenService (copy), v2 (copy), Heartbeat (copy), DamageColorCorrection (copy) ]]
	if Health - Humanoid.Health > 15 then
		Damage2d.ImageTransparency = 0
	end

	local Health2 = Humanoid.Health
	local v1 = Health2 / 70

	if v1 >= 1 or Health2 <= 0 then
		TweenService:Create(Damage2d, v2, {
			ImageTransparency = 1
		}):Play()
		TweenService:Create(Heartbeat, v2, {
			Volume = 0
		}):Play()
		TweenService:Create(DamageColorCorrection, v2, {
			Brightness = 0,
			Contrast = 0,
			Saturation = 0
		}):Play()
	else
		TweenService:Create(Damage2d, v2, {
			ImageTransparency = v1
		}):Play()
		TweenService:Create(Heartbeat, v2, {
			Volume = 1 - v1
		}):Play()
		TweenService:Create(DamageColorCorrection, v2, {
			Brightness = -0.2 + 0.2 * v1,
			Contrast = 0.2 - 0.2 * v1,
			Saturation = -1 + v1
		}):Play()
	end
end

Humanoid:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 62 | Upvalues: UpdateHealthFX (copy), Health (ref), Humanoid (copy) ]]
	UpdateHealthFX()
	Health = Humanoid.Health
end)
UpdateHealthFX()