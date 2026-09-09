-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local Debris = game:GetService("Debris")
local t = {
	close = "BulletCrack",
	whiz = "BulletWhiz",
	far = "BulletWhizFar"
}
local t2 = {
	close = {
		min = 5,
		max = 60
	},
	whiz = {
		min = 10,
		max = 80
	},
	far = {
		min = 20,
		max = 120
	}
}
local LocalPlayer = Players.LocalPlayer
local CameraShaker = require(ReplicatedStorage:WaitForChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
local v1 = CameraShaker.new(Enum.RenderPriority.Camera.Value + 1, function(p1) --[[ Line: 44 ]]
	if not workspace.CurrentCamera then
		return
	end

	workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * p1
end)

v1:Start()

local t3 = {
	close = {
		magnitude = 0.8,
		roughness = 14,
		fadeIn = 0.02,
		fadeOut = 0.3
	},
	whiz = {
		magnitude = 0.3,
		roughness = 10,
		fadeIn = 0.02,
		fadeOut = 0.2
	}
}
local v2 = nil

local function getSoundsFolder() --[[ getSoundsFolder | Line: 58 | Upvalues: v2 (ref), ReplicatedStorage (copy) ]]
	if v2 and v2.Parent then
		return v2
	end

	local SPH_Assets = ReplicatedStorage:FindFirstChild("SPH_Assets")

	v2 = if SPH_Assets then SPH_Assets:FindFirstChild("Sounds") else SPH_Assets

	return v2
end

local function pickSound(p1) --[[ pickSound | Line: 65 | Upvalues: v2 (ref), ReplicatedStorage (copy) ]]
	if not (v2 and v2.Parent) then
		local SPH_Assets = ReplicatedStorage:FindFirstChild("SPH_Assets")

		v2 = if SPH_Assets then SPH_Assets:FindFirstChild("Sounds") else SPH_Assets
	end

	local v22 = v2

	if not v22 then
		return nil
	end

	local v3 = v22:FindFirstChild(p1)

	if not v3 or #v3:GetChildren() == 0 then
		return nil
	end

	local v4 = v3:GetChildren()

	for i = 1, 4 do
		local v5 = v4[math.random(1, #v4)]

		if v5 and v5:IsA("Sound") then
			return v5
		end
	end

	return nil
end

local function playFlyby(p1, p2) --[[ playFlyby | Line: 78 | Upvalues: t (copy), pickSound (copy), LocalPlayer (copy), t2 (copy), Debris (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	local v2 = pickSound(v1)

	if not v2 then
		return
	end

	local v3

	if p2 then
		v3 = p2
	else
		local Character = LocalPlayer.Character
		local v4 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

		if not v4 then
			return
		end

		v3 = v4.Position
	end

	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.Transparency = 1
	Part.Size = Vector3.new(0.1, 0.1, 0.1)
	Part.Position = v3
	Part.Parent = workspace

	local v5 = v2:Clone()

	v5.PlaybackSpeed = v2.PlaybackSpeed + math.random(-5, 5) / 100

	local v6 = t2[p1]

	if v6 then
		v5.RollOffMode = Enum.RollOffMode.Linear
		v5.RollOffMinDistance = v6.min
		v5.RollOffMaxDistance = v6.max
	end

	v5.Parent = Part
	v5:Play()

	local v7 = false

	local function cleanup() --[[ cleanup | Line: 116 | Upvalues: v7 (ref), Part (copy) ]]
		if v7 then
			return
		end

		v7 = true

		if not (Part and Part.Parent) then
			return
		end

		Part:Destroy()
	end

	v5.Ended:Once(cleanup)

	local v10, v11

	if v5.TimeLength > 0 then
		v10 = v5.TimeLength

		if v10 then
			v11 = Part
		else
			v10 = 3
			v11 = Part
		end
	else
		v10 = 3
		v11 = Part
	end

	Debris:AddItem(v11, (math.max(3, v10 + 2)))
end

local function applyShake(p1) --[[ applyShake | Line: 125 | Upvalues: t3 (copy), v1 (copy) ]]
	local v12 = t3[p1]

	if v12 then
		v1:ShakeOnce(v12.magnitude, v12.roughness, v12.fadeIn, v12.fadeOut)
	end
end

ReplicatedStorage:WaitForChild("miscEvents"):WaitForChild("bulletFlyby").OnClientEvent:Connect(function(p1, p2) --[[ Line: 132 | Upvalues: playFlyby (copy), t3 (copy), v1 (copy) ]]
	playFlyby(p1, p2)

	local v12 = t3[p1]

	if v12 then
		v1:ShakeOnce(v12.magnitude, v12.roughness, v12.fadeIn, v12.fadeOut)
	end
end)