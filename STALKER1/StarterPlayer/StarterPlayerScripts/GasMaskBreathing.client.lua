-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local GasMaskVoiceConfig = require(ReplicatedStorage:WaitForChild("GasMaskVoiceConfig"))
local t = { "rbxassetid://97366561227121", "rbxassetid://126742845464284", "rbxassetid://105728541590146", "rbxassetid://71057343452580", "rbxassetid://80113917092811" }
local t2 = { "rbxassetid://121070979248151", "rbxassetid://87937341103243", "rbxassetid://80995660490663", "rbxassetid://135784478617027", "rbxassetid://97668581245908" }

local function isWearingGasMask() --[[ isWearingGasMask | Line: 37 | Upvalues: GasMaskVoiceConfig (copy), LocalPlayer (copy) ]]
	return GasMaskVoiceConfig.isWearingGasMask(LocalPlayer.Character)
end

local v1 = false
local v2 = nil
local v3 = nil
local v4 = 100
local v5 = 100
local StaminaSync = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("StaminaSync")

if StaminaSync then
	StaminaSync.OnClientEvent:Connect(function(p1, p2) --[[ Line: 51 | Upvalues: v4 (ref), v5 (ref) ]]
		v4 = p1
		v5 = p2 or 100
	end)
end

local function getBreathIntensity() --[[ getBreathIntensity | Line: 57 | Upvalues: LocalPlayer (copy), v4 (ref), v5 (ref) ]]
	local Character = LocalPlayer.Character
	local v2 = v4 / v5
	local v3 = if if Character then Character:GetAttribute("Sprinting") == true else Character then 0.6 else 0

	if v2 < 0.5 then
		v3 = math.max(v3, 1 - v2 / 0.5)
	end

	return math.clamp(v3, 0, 1)
end

local function playSound(p1, p2, p3, p4) --[[ playSound | Line: 78 | Upvalues: v3 (ref), v1 (ref) ]]
	local Sound = Instance.new("Sound")

	Sound.SoundId = p1
	Sound.Volume = p3 or 0.8
	Sound.PlaybackSpeed = p4 or 0.95 + math.random() * 0.1
	Sound.RollOffMaxDistance = 20
	Sound.Parent = p2
	v3 = Sound
	Sound:Play()

	local v2 = false
	local v32 = Sound.Ended:Connect(function() --[[ Line: 90 | Upvalues: v2 (ref) ]]
		v2 = true
	end)

	while not v2 and (v1 and Sound.Parent) do
		task.wait(0.05)
	end

	v32:Disconnect()

	if v3 == Sound then
		v3 = nil
	end

	if Sound.Parent then
		Sound:Destroy()
	end
end

local function breathingLoop() --[[ breathingLoop | Line: 99 | Upvalues: v1 (ref), LocalPlayer (copy), v4 (ref), v5 (ref), t (copy), playSound (copy), t2 (copy) ]]
	while v1 do
		local Character = LocalPlayer.Character

		if Character then
			local Head = Character:FindFirstChild("Head")

			if Head then
				local Character2 = LocalPlayer.Character
				local v2 = v4 / v5
				local v3 = if if Character2 then Character2:GetAttribute("Sprinting") == true else Character2 then 0.6 else 0

				if v2 < 0.5 then
					v3 = math.max(v3, 1 - v2 / 0.5)
				end

				local v52 = math.clamp(v3, 0, 1)
				local v6 = 0.6 + v52 * 0.6
				local v7 = 0.9 + v52 * 0.3 + (math.random() * 0.1 - 0.05)

				playSound(t[math.random(#t)], Head, v6, v7)
				task.wait((0.15 + math.random() * 0.2) * (1 - v52 * 0.5))

				if not v1 then
					break
				end

				playSound(t2[math.random(#t2)], Head, v6, v7)
				task.wait((0.4 + math.random() * 0.5) * (1 - v52 * 0.6))

				continue
			end

			task.wait(0.5)

			continue
		end

		task.wait(0.5)
	end
end

local function startBreathing() --[[ startBreathing | Line: 134 | Upvalues: v1 (ref), v2 (ref), breathingLoop (copy) ]]
	if not v1 then
		v1 = true
		v2 = task.spawn(breathingLoop)
	end
end

local function stopBreathing() --[[ stopBreathing | Line: 140 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
	v1 = false
	v2 = nil

	if not v3 then
		return
	end

	v3:Destroy()
	v3 = nil
end

task.spawn(function() --[[ Line: 150 | Upvalues: GasMaskVoiceConfig (copy), LocalPlayer (copy), v1 (ref), v2 (ref), breathingLoop (copy), v3 (ref) ]]
	while true do
		local v12 = GasMaskVoiceConfig.isWearingGasMask(LocalPlayer.Character)

		if v12 and not v1 then
			if not v1 then
				v1 = true
				v2 = task.spawn(breathingLoop)
			end
		elseif not v12 and v1 then
			v1 = false
			v2 = nil

			if v3 then
				v3:Destroy()
				v3 = nil
			end
		end

		task.wait(1)
	end
end)
print("[GasMaskBreathing] Initialized")