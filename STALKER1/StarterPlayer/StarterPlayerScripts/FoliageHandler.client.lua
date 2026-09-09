-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = Random.new()
local v2 = require(script:WaitForChild("Octree")).new()
local Spring = require(script:WaitForChild("Spring"))
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local v3 = os.clock()
local v4 = ReplicatedStorage:GetAttribute("InfluenceMin") or -0.125
local v5 = ReplicatedStorage:GetAttribute("InfluenceMax") or 0.125
local v6 = ReplicatedStorage:GetAttribute("Power") or 0.65
local v7 = ReplicatedStorage:GetAttribute("Speed") or 17.5
local v8 = ReplicatedStorage:GetAttribute("Direction") or Vector3.new(0.65, 0, 0.65)
local v9 = true
local Sounds = script:WaitForChild("Sounds")
local t = {}

local function isPointInPart(p1, p2) --[[ isPointInPart | Line: 82 ]]
	local v1 = p2.CFrame:PointToObjectSpace(p1)

	return if math.abs(v1.X) < p2.Size.X * 0.5 then if math.abs(v1.Y) < p2.Size.Y * 0.5 then math.abs(v1.Z) < p2.Size.Z * 0.5 else false else false
end

local function playRandomSound(p1, p2) --[[ playRandomSound | Line: 88 | Upvalues: v1 (copy) ]]
	local v12 = p1[v1:NextInteger(1, #p1:GetChildren())]

	if not (v12 and v12:IsA("Sound")) then
		return
	end

	local v2 = v12:Clone()

	v2.PlayOnRemove = true
	v2.Parent = p2
	v2:Destroy()
end

local function addFoliageObject(p1) --[[ addFoliageObject | Line: 100 | Upvalues: t (copy), Spring (copy), Players (copy), v9 (ref), LocalPlayer (copy), isPointInPart (copy), v2 (copy), v1 (copy) ]]
	if typeof(p1) ~= "Instance" then
		warn("FoliageHandler - Object passed was not an instance!")

		return
	end

	local v12

	if p1:IsA("Model") and p1.PrimaryPart then
		v12 = p1.PrimaryPart
	else
		if not p1:IsA("BasePart") then
			warn("FoliageHandler - Specified object does not exist!")

			return
		end

		v12 = p1
	end

	if not t[v12] then
		local v22 = Spring.new(Vector3.new(0, 0, 0))

		v22.s = 17.5
		v22.d = 0.25
		v22.t = Vector3.new()

		local v3 = v12.Touched:Connect(function(p1) --[[ Line: 126 | Upvalues: t (ref), v12 (ref), Players (ref), v9 (ref), LocalPlayer (ref) ]]
			if not t[v12] then
				return
			end

			local v2 = p1.Parent

			if not (v2 and (v2:IsA("Model") and Players:GetPlayerFromCharacter(v2))) then
				return
			end

			if not v2.PrimaryPart or p1 ~= v2.PrimaryPart then
				return
			end

			local v3 = Players:GetPlayerFromCharacter(v2)

			if not v9 and v3 ~= LocalPlayer then
				return
			end

			t[v12].Touching[v3] = true
		end)
		local v4 = v12.TouchEnded:Connect(function(p1) --[[ Line: 148 | Upvalues: t (ref), v12 (ref), Players (ref), isPointInPart (ref), v9 (ref), LocalPlayer (ref) ]]
			if not t[v12] then
				return
			end

			local v2 = p1.Parent

			if not (v2 and (v2:IsA("Model") and Players:GetPlayerFromCharacter(v2))) then
				return
			end

			if not v2.PrimaryPart or (p1 ~= v2.PrimaryPart or isPointInPart(v12.Position, p1)) then
				return
			end

			local v3 = Players:GetPlayerFromCharacter(v2)

			if not v9 and v3 ~= LocalPlayer then
				return
			end

			t[v12].Touching[v3] = nil
		end)

		t[v12] = {
			LastComputeTime = 0,
			SoundCooldown = false,
			OctreeNode = v2:CreateNode(v12.Position, v12),
			OriginCFrame = v12.CFrame,
			CFrame = v12.CFrame,
			Goal = CFrame.new(),
			Seed = v1:NextNumber(0, 10000) * 0.01,
			MovementSpring = v22,
			TouchedEvent = v3,
			TouchEndedEvent = v4,
			Touching = {}
		}
	end
end

local function removeFoliageObject(p1) --[[ removeFoliageObject | Line: 185 | Upvalues: t (copy) ]]
	if typeof(p1) ~= "Instance" then
		warn("FoliageHandler - Object passed was not an instance!")

		return
	end

	local v1

	if p1:IsA("Model") and p1.PrimaryPart then
		v1 = p1.PrimaryPart
	else
		if not p1:IsA("BasePart") then
			warn("FoliageHandler - Specified object does not exist! If you are using StreamingEnabled make sure you tag PrimaryParts directly with the \'Foliage\' tag rather than the entire Model.")

			return
		end

		v1 = p1
	end

	if not t[v1] then
		return
	end

	v1.CFrame = t[v1].OriginCFrame
	t[v1].OctreeNode:Destroy()

	if t[v1].TouchedEvent then
		t[v1].TouchedEvent:Disconnect()
	end

	if t[v1].TouchEndedEvent then
		t[v1].TouchEndedEvent:Disconnect()
	end

	t[v1] = nil
end

local function updateFoliage() --[[ updateFoliage | Line: 218 | Upvalues: v3 (ref), CurrentCamera (copy), v2 (copy), t (copy), v6 (ref), v7 (ref), v8 (ref), playRandomSound (copy), Sounds (copy), v4 (ref), v5 (ref) ]]
	local v1 = os.clock()
	local v22 = v1 - v3

	if v22 < 0.025 then
		return
	end

	debug.profilebegin("FoliageUpdate")
	v3 = v1

	local v32 = CurrentCamera.CFrame
	local v42 = v2:RadiusSearch(v32.Position + v32.LookVector * 76.5, 85)
	local v52 = #v42

	if v52 <= 0 then
		return
	end

	local v62 = table.create(v52)

	debug.profilebegin("FoliageCalculation")

	for v72, v82 in v42 do
		local v9 = t[v82]
		local OriginCFrame = v9.OriginCFrame
		local v10 = v9.CFrame

		if if v1 - v9.LastComputeTime > 0.035 then true else false then
			local Seed = v9.Seed
			local v12 = v6 * 0.085
			local v13 = v1 * (v7 * 0.075)
			local v17 = Vector3.new(math.noise(v13, 0, Seed) * v12, math.noise(v13, 0, -Seed) * v12, math.noise(v13, 0, Seed + Seed) * v12)

			v9.Goal = (OriginCFrame * v82.PivotOffset * CFrame.Angles(v17.X, v17.Y, v17.Z) + v8 * ((0.4 + math.noise(v13, Seed, Seed)) * v12)) * v82.PivotOffset:Inverse()
			v9.LastComputeTime = v1
			debug.profilebegin("FoliagePlayerCollision")

			for v18, v19 in v9.Touching do
				if v19 and (v18.Character and v18.Character.PrimaryPart) then
					local AssemblyLinearVelocity = v18.Character.PrimaryPart.AssemblyLinearVelocity

					if not v9.SoundCooldown and AssemblyLinearVelocity.Magnitude >= 0.01 then
						v9.SoundCooldown = true
						task.delay(2, function() --[[ Line: 267 | Upvalues: v9 (copy) ]]
							v9.SoundCooldown = false
						end)
						playRandomSound(Sounds, v82)
					end

					v9.MovementSpring.t = Vector3.new(-math.clamp(AssemblyLinearVelocity.Z, v4, v5), 0, (math.clamp(AssemblyLinearVelocity.X, v4, v5)))
					v9.Goal = v9.Goal * CFrame.Angles(v9.MovementSpring.p.X, v9.MovementSpring.p.Y, v9.MovementSpring.p.Z)
				end
			end

			debug.profileend()
		end

		local v27 = v10:Lerp(v9.Goal, (math.min(1, v22 * 6)))

		v9.CFrame = v27
		v62[v72] = v27
	end

	debug.profileend()
	workspace:BulkMoveTo(v42, v62, Enum.BulkMoveMode.FireCFrameChanged)
	debug.profileend()
end

local function onPlayerRemoving(p1) --[[ onPlayerRemoving | Line: 292 | Upvalues: t (copy) ]]
	for v1, v2 in t do
		if v2.Touching[p1] then
			v2.Touching[p1] = nil
		end
	end
end

(function() --[[ initialize | Line: 300 | Upvalues: ReplicatedStorage (copy), v4 (ref), v5 (ref), v6 (ref), v7 (ref), t (copy), v8 (ref), v9 (ref), CollectionService (copy), addFoliageObject (copy), Players (copy), onPlayerRemoving (copy), removeFoliageObject (copy), RunService (copy), updateFoliage (copy) ]]
	ReplicatedStorage:GetAttributeChangedSignal("InfluenceMin"):Connect(function() --[[ Line: 301 | Upvalues: v4 (ref), ReplicatedStorage (ref) ]]
		v4 = ReplicatedStorage:GetAttribute("InfluenceMin")
	end)
	ReplicatedStorage:GetAttributeChangedSignal("InfluenceMax"):Connect(function() --[[ Line: 305 | Upvalues: v5 (ref), ReplicatedStorage (ref) ]]
		v5 = ReplicatedStorage:GetAttribute("InfluenceMax")
	end)
	ReplicatedStorage:GetAttributeChangedSignal("Power"):Connect(function() --[[ Line: 309 | Upvalues: v6 (ref), ReplicatedStorage (ref) ]]
		v6 = ReplicatedStorage:GetAttribute("Power")
	end)
	ReplicatedStorage:GetAttributeChangedSignal("Speed"):Connect(function() --[[ Line: 313 | Upvalues: v7 (ref), ReplicatedStorage (ref), t (ref) ]]
		v7 = ReplicatedStorage:GetAttribute("Speed")

		for v1, v2 in t do
			v2.MovementSpring.s = v7
		end
	end)
	ReplicatedStorage:GetAttributeChangedSignal("Direction"):Connect(function() --[[ Line: 321 | Upvalues: v8 (ref), ReplicatedStorage (ref) ]]
		v8 = ReplicatedStorage:GetAttribute("Direction")
	end)
	ReplicatedStorage:GetAttributeChangedSignal("Replicates"):Connect(function() --[[ Line: 325 | Upvalues: v9 (ref), ReplicatedStorage (ref) ]]
		v9 = ReplicatedStorage:GetAttribute("Replicates")
	end)
	task.spawn(function() --[[ Line: 329 | Upvalues: CollectionService (ref), addFoliageObject (ref) ]]
		for v1, v2 in CollectionService:GetTagged("Foliage") do
			if v2:IsA("Model") or v2:IsA("BasePart") then
				addFoliageObject(v2)
			end
		end
	end)
	Players.PlayerRemoving:Connect(onPlayerRemoving)
	CollectionService:GetInstanceAddedSignal("Foliage"):Connect(addFoliageObject)
	CollectionService:GetInstanceRemovedSignal("Foliage"):Connect(removeFoliageObject)
	RunService.Heartbeat:Connect(updateFoliage)
end)()