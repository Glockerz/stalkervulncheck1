-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer
local v1 = 0
local v2 = 100
local t = { "rbxassetid://9116449749", "rbxassetid://9116449574" }
local RadiationContaminated = Instance.new("Sound")

RadiationContaminated.Name = "RadiationContaminated"
RadiationContaminated.SoundId = "rbxassetid://281066056"
RadiationContaminated.Volume = 0
RadiationContaminated.Looped = true
RadiationContaminated.Playing = true
RadiationContaminated.RollOffMode = Enum.RollOffMode.Inverse
RadiationContaminated.RollOffMaxDistance = 10

local function parentSounds(p1) --[[ parentSounds | Line: 32 | Upvalues: RadiationContaminated (copy) ]]
	local Head = p1:WaitForChild("Head", 5)

	if not Head then
		return
	end

	RadiationContaminated.Parent = Head
end

local Character = LocalPlayer.Character

if Character then
	local Head = Character:WaitForChild("Head", 5)

	if Head then
		RadiationContaminated.Parent = Head
	end
end

LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 41 | Upvalues: v1 (ref), RadiationContaminated (copy) ]]
	v1 = 0

	local Head = p1:WaitForChild("Head", 5)

	if not Head then
		return
	end

	RadiationContaminated.Parent = Head
end)

local SoundService = game:GetService("SoundService")
local RadiationHum = Instance.new("Sound")

RadiationHum.Name = "RadiationHum"
RadiationHum.SoundId = "rbxassetid://17541330396"
RadiationHum.Volume = 0
RadiationHum.Looped = true
RadiationHum.Playing = true
RadiationHum.Parent = SoundService

local function ensureZoneSound(p1) --[[ ensureZoneSound | Line: 60 ]]
	return nil
end

local function distanceToBboxEdge(p1, p2) --[[ distanceToBboxEdge | Line: 66 ]]
	local v1 = p1.CFrame:PointToObjectSpace(p2)
	local v2 = p1.Size * 0.5

	return (v1 - Vector3.new(math.clamp(v1.X, -v2.X, v2.X), math.clamp(v1.Y, -v2.Y, v2.Y), (math.clamp(v1.Z, -v2.Z, v2.Z)))).Magnitude
end

local t2 = {}

for i, v in ipairs(CollectionService:GetTagged("RadZone")) do
	local RadiationLoop = v:FindFirstChild("RadiationLoop")

	if RadiationLoop then
		RadiationLoop:Destroy()
	end
end

local t3 = {}

local function ensureSourceSound(p1) --[[ ensureSourceSound | Line: 83 | Upvalues: t3 (copy) ]]
	if t3[p1] then
		return t3[p1]
	end

	if p1:IsA("BasePart") then
		local v1 = p1:GetAttribute("RadRadius") or 30
		local RadiationLoop = Instance.new("Sound")

		RadiationLoop.Name = "RadiationLoop"
		RadiationLoop.SoundId = "rbxassetid://17541330396"
		RadiationLoop.Volume = 0
		RadiationLoop.Looped = true
		RadiationLoop.Playing = true
		RadiationLoop.RollOffMode = Enum.RollOffMode.Linear
		RadiationLoop.RollOffMinDistance = 0
		RadiationLoop.RollOffMaxDistance = v1
		RadiationLoop.Parent = p1
		t3[p1] = RadiationLoop

		return RadiationLoop
	end

	return nil
end

for i, v in ipairs(CollectionService:GetTagged("RadZone")) do

end

CollectionService:GetInstanceAddedSignal("RadZone"):Connect(function(p1) --[[ Line: 106 ]] end)
CollectionService:GetInstanceRemovedSignal("RadZone"):Connect(function(p1) --[[ Line: 109 | Upvalues: t2 (copy) ]]
	if not t2[p1] then
		return
	end

	t2[p1]:Destroy()
	t2[p1] = nil
end)

for i, v in ipairs(CollectionService:GetTagged("RadSource")) do
	ensureSourceSound(v)
end

CollectionService:GetInstanceAddedSignal("RadSource"):Connect(function(p1) --[[ Line: 120 | Upvalues: ensureSourceSound (copy) ]]
	ensureSourceSound(p1)
end)
CollectionService:GetInstanceRemovedSignal("RadSource"):Connect(function(p1) --[[ Line: 123 | Upvalues: t3 (copy) ]]
	if not t3[p1] then
		return
	end

	t3[p1]:Destroy()
	t3[p1] = nil
end)

local RadSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RadSync", 10)

if RadSync then
	RadSync.OnClientEvent:Connect(function(p1, p2) --[[ Line: 133 | Upvalues: v1 (ref), v2 (ref), LocalPlayer (copy) ]]
		v1 = p1
		v2 = p2 or 100

		local DebugRadUI = LocalPlayer.PlayerGui:FindFirstChild("DebugRadUI")

		if not DebugRadUI then
			return
		end

		local RadLabel = DebugRadUI:FindFirstChild("RadLabel")

		if not RadLabel then
			return
		end

		RadLabel.Text = string.format("RAD: %.1f / %d", p1, p2)
	end)
end

local v3 = 0
local v4 = math.random(5, 15)

local function playCough() --[[ playCough | Line: 154 | Upvalues: LocalPlayer (copy), t (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Head = Character:FindFirstChild("Head")

	if Head then
		local v1 = t[math.random(#t)]
		local Sound = Instance.new("Sound")

		Sound.SoundId = v1
		Sound.Volume = 1.5
		Sound.PlaybackSpeed = 0.9 + math.random() * 0.2
		Sound.RollOffMaxDistance = 30
		Sound.Parent = Head
		Sound:Play()
		Sound.Ended:Connect(function() --[[ Line: 168 | Upvalues: Sound (copy) ]]
			Sound:Destroy()
		end)
	end
end

local function getProximityIntensity() --[[ getProximityIntensity | Line: 172 | Upvalues: LocalPlayer (copy), CollectionService (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return 0
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return 0
	end

	local v2 = 0

	for i, v in ipairs((CollectionService:GetTagged("RadZone"))) do
		local v3

		if v:IsA("BasePart") then
			local v4 = v:GetAttribute("RadLevel") or 1
			local Magnitude = (HumanoidRootPart.Position - v.Position).Magnitude
			local v5 = v.Size.Magnitude * 0.5
			local v6 = v:GetAttribute("RadProximityRange") or 80
			local v7 = v.CFrame:PointToObjectSpace(HumanoidRootPart.Position)
			local v8 = v.Size * 0.5

			v3 = if math.abs(v7.X) <= v8.X then if math.abs(v7.Y) <= v8.Y then math.abs(v7.Z) <= v8.Z else false else false

			local v9 = 0

			if v3 then
				v9 = v4 / 10
			else
				local v10 = math.max(0, Magnitude - v5)

				if v10 < v6 then
					v9 = v4 / 10 * (1 - v10 / v6)
				end
			end

			if v2 < v9 then
				v2 = v9
			end
		end
	end

	return math.clamp(v2, 0, 1)
end

local v5 = 0

RunService.Heartbeat:Connect(function(p1) --[[ Line: 214 | Upvalues: v5 (ref), LocalPlayer (copy), CollectionService (copy), distanceToBboxEdge (copy), RadiationHum (copy), t3 (copy), v1 (ref), v2 (ref), RadiationContaminated (copy), v3 (ref), v4 (ref), playCough (copy) ]]
	v5 = v5 + p1

	local Character = LocalPlayer.Character
	local v12 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
	local v22 = 0

	if v12 then
		local Position = v12.Position

		for i, v in ipairs(CollectionService:GetTagged("RadZone")) do
			if v:IsA("BasePart") then
				local v32 = v:GetAttribute("RadProximityRange") or 80
				local v42 = distanceToBboxEdge(v, Position)

				if v42 < v32 then
					local v6 = math.clamp((v:GetAttribute("RadLevel") or 1) / 10, 0, 1) * (1 - v42 / v32)

					if v22 < v6 then
						v22 = v6
					end
				end
			end
		end
	end

	RadiationHum.Volume = RadiationHum.Volume + (v22 - RadiationHum.Volume) * math.min(1, p1 * 4)

	for k, v in pairs(t3) do
		local v7 = k:GetAttribute("RadIntensity") or 5
		local v8 = k:GetAttribute("RadRadius") or 30

		if v.RollOffMaxDistance ~= v8 then
			v.RollOffMaxDistance = v8
		end

		local v9 = math.clamp(v7 / 10, 0.1, 1)

		v.Volume = v.Volume + (v9 - v.Volume) * math.min(1, p1 * 2)
	end

	local v10 = v1 / v2
	local v11 = if v10 > 0.01 then math.clamp(v10 * 0.6, 0.05, 0.6) else 0

	RadiationContaminated.Volume = RadiationContaminated.Volume + (v11 - RadiationContaminated.Volume) * math.min(1, p1 * 2)

	if v1 >= 40 then
		v3 = v3 + p1

		if not (v4 <= v3) then
			return
		end

		playCough()
		v3 = 0
		v4 = if v1 >= 70 then math.random(3, 7) else math.random(5, 15)

		return
	end

	v3 = 0
end)
print("[RadiationAudio] Initialized")