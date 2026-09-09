-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local Suppression = ReplicatedStorage:FindFirstChild("Suppression") or Instance.new("BindableEvent", ReplicatedStorage)

Suppression.Name = "Suppression"

local npcSuppression = ReplicatedStorage.miscEvents:WaitForChild("npcSuppression", 10)
local v1 = ReplicatedStorage.SPH_Assets.Sounds.BulletCrack:GetChildren()
local v2 = script.Parent

v2.ImageTransparency = 1

local function applySuppression(p1) --[[ applySuppression | Line: 14 | Upvalues: v1 (copy), Debris (copy), v2 (copy) ]]
	local v12 = v1[math.random(#v1)]:Clone()

	Instance.new("DistortionSoundEffect", v12)
	v12.Parent = script
	v12.Volume = p1
	v12:Play()
	Debris:AddItem(v12, v12.TimeLength)

	local v22 = v2

	v22.ImageTransparency = v22.ImageTransparency - p1 / 10
end

Suppression.Event:Connect(applySuppression)
npcSuppression.OnClientEvent:Connect(function(p1) --[[ Line: 27 | Upvalues: applySuppression (copy) ]]
	applySuppression(p1)
end)
RunService.Heartbeat:Connect(function(p1) --[[ Line: 31 | Upvalues: v2 (copy) ]]
	v2.ImageTransparency = v2.ImageTransparency + (1 - v2.ImageTransparency) * 0.003 * 60 * p1
end)