-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local GasMaskVoiceConfig = require(ReplicatedStorage:WaitForChild("GasMaskVoiceConfig"))
local LocalPlayer = Players.LocalPlayer
local AudioListener = Instance.new("AudioListener")

AudioListener.Parent = Workspace.CurrentCamera

local AudioDeviceOutput = Instance.new("AudioDeviceOutput")

AudioDeviceOutput.Parent = AudioListener

local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = false

local function setDirect() --[[ setDirect | Line: 20 | Upvalues: v3 (ref), v4 (ref), v2 (ref), v1 (ref), AudioListener (copy), AudioDeviceOutput (copy) ]]
	if v3 then
		v3:Destroy()
		v3 = nil
	end

	if v4 then
		v4:Destroy()
		v4 = nil
	end

	if v2 then
		v2:Destroy()
		v2 = nil
	end

	if v1 then
		return
	end

	v1 = Instance.new("Wire")
	v1.SourceInstance = AudioListener
	v1.TargetInstance = AudioDeviceOutput
	v1.Parent = AudioDeviceOutput
end

local function setMuffled() --[[ setMuffled | Line: 32 | Upvalues: v1 (ref), v2 (ref), GasMaskVoiceConfig (copy), AudioListener (copy), v3 (ref), v4 (ref), AudioDeviceOutput (copy) ]]
	if v1 then
		v1:Destroy()
		v1 = nil
	end

	if not v2 then
		v2 = Instance.new("AudioEqualizer")
		v2.LowGain = GasMaskVoiceConfig.ListenerEQ.LowGain
		v2.MidGain = GasMaskVoiceConfig.ListenerEQ.MidGain
		v2.HighGain = GasMaskVoiceConfig.ListenerEQ.HighGain
		v2.Parent = AudioListener
		v3 = Instance.new("Wire")
		v3.SourceInstance = AudioListener
		v3.TargetInstance = v2
		v3.Parent = v2
		v4 = Instance.new("Wire")
		v4.SourceInstance = v2
		v4.TargetInstance = AudioDeviceOutput
		v4.Parent = AudioDeviceOutput
	end
end

setDirect()
task.spawn(function() --[[ Line: 47 | Upvalues: Workspace (copy), AudioListener (copy), LocalPlayer (copy), GasMaskVoiceConfig (copy), v5 (ref), setMuffled (copy), setDirect (copy) ]]
	repeat
		local CurrentCamera = Workspace.CurrentCamera

		if CurrentCamera and AudioListener.Parent ~= CurrentCamera then
			AudioListener.Parent = CurrentCamera
		end

		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
		local v2 = if v1 then v1:FindFirstChildOfClass("AudioEmitter") else v1

		if v2 then
			v2.AudioInteractionGroup = if GasMaskVoiceConfig.SelfMonitor then "" else "__noself__"
		end

		local v4 = GasMaskVoiceConfig.isWearingGasMask(LocalPlayer.Character)

		if v4 ~= v5 then
			v5 = v4

			if v4 then
				setMuffled()
			else
				setDirect()
			end
		end

		task.wait(GasMaskVoiceConfig.PollInterval)
	until not v2
end)
print("[VoiceGraphClient] online")