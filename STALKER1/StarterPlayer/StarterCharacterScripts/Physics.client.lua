-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local v1 = script.Parent
local Humanoid = v1:WaitForChild("Humanoid")
local HumanoidRootPart = v1:WaitForChild("HumanoidRootPart")
local v2 = ReplicatedStorage:WaitForChild("RattleNoise"):GetChildren()
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))

local function isBackpackModel(p1) --[[ isBackpackModel | Line: 14 | Upvalues: ItemDatabase (copy) ]]
	for k, v in pairs(ItemDatabase) do
		if type(v) == "table" and (v.ItemType == "Backpack" and v.Model == p1) then
			return true
		end
	end

	return false
end

local t = {}

local function findWeldInModel(p1) --[[ findWeldInModel | Line: 30 ]]
	local HolsterWeld = p1:FindFirstChild("HolsterWeld")

	if HolsterWeld and HolsterWeld:IsA("Weld") then
		return HolsterWeld
	end

	local Middle = p1:FindFirstChild("Middle")

	if not Middle then
		return nil
	end

	for v1, v2 in Middle:GetChildren() do
		if v2:IsA("Weld") then
			return v2
		end
	end

	return nil
end

local function isValidPhysicsModel(p1) --[[ isValidPhysicsModel | Line: 44 | Upvalues: isBackpackModel (copy), findWeldInModel (copy) ]]
	if not p1:IsA("Model") then
		return false
	end

	if not (p1.Name:match("^Holster_") or isBackpackModel(p1.Name)) then
		return false
	end

	return findWeldInModel(p1) ~= nil
end

local function addPhysicsObject(p1) --[[ addPhysicsObject | Line: 53 | Upvalues: isBackpackModel (copy), findWeldInModel (copy), t (ref) ]]
	if not (if p1:IsA("Model") and (p1.Name:match("^Holster_") or isBackpackModel(p1.Name)) then findWeldInModel(p1) ~= nil else false) then
		return
	end

	local v2 = findWeldInModel(p1)

	table.insert(t, {
		springVelocityX = 0,
		springVelocityZ = 0,
		currentRotationX = 0,
		currentRotationZ = 0,
		wasInAir = false,
		lastVelocity = Vector3.new(0, 0, 0),
		Model = p1,
		Weld = v2,
		OriginalC1 = v2.C1,
		IsBackpack = isBackpackModel(p1.Name)
	})
end

local function removePhysicsObject(p1) --[[ removePhysicsObject | Line: 72 | Upvalues: t (ref) ]]
	for k, v in pairs(t) do
		if v.Model == p1 then
			if not (v.Weld and v.Weld.Parent) then
				table.remove(t, k)

				return
			end

			v.Weld.C1 = v.OriginalC1
			table.remove(t, k)

			return
		end
	end
end

local function initializePhysicsObjects() --[[ initializePhysicsObjects | Line: 85 | Upvalues: t (ref), v1 (copy), addPhysicsObject (copy) ]]
	t = {}

	for k, v in pairs(v1:GetChildren()) do
		addPhysicsObject(v)
	end
end

local function connectPhysicsEvents() --[[ connectPhysicsEvents | Line: 92 | Upvalues: v1 (copy), isBackpackModel (copy), findWeldInModel (copy), addPhysicsObject (copy), removePhysicsObject (copy) ]]
	v1.ChildAdded:Connect(function(p1) --[[ Line: 93 | Upvalues: isBackpackModel (ref), findWeldInModel (ref), addPhysicsObject (ref) ]]
		task.defer(function() --[[ Line: 94 | Upvalues: p1 (copy), isBackpackModel (ref), findWeldInModel (ref), addPhysicsObject (ref) ]]
			local v1 = p1

			if not (if v1:IsA("Model") and (v1.Name:match("^Holster_") or isBackpackModel(v1.Name)) then findWeldInModel(v1) ~= nil else false) then
				return
			end

			addPhysicsObject(p1)
		end)
	end)
	v1.ChildRemoved:Connect(function(p1) --[[ Line: 100 | Upvalues: removePhysicsObject (ref) ]]
		removePhysicsObject(p1)
	end)
end

local v3 = false
local v4 = false
local BackpackFoley = ReplicatedStorage:FindFirstChild("BackpackFoley")
local v5 = if BackpackFoley then BackpackFoley:GetChildren() or {} else {}

local function playBackpackFoley() --[[ playBackpackFoley | Line: 110 | Upvalues: v4 (ref), v5 (copy), v1 (copy) ]]
	if v4 or #v5 == 0 then
		return
	end

	local v12 = v5[math.random(#v5)]

	if v12:IsA("Sound") and v12.SoundId ~= "" then
		v4 = true

		local v2 = v12:Clone()

		v2.Parent = v1.PrimaryPart
		v2.PlaybackSpeed = 0.9 + math.random() * 0.2
		v2.RollOffMaxDistance = 20
		v2.RollOffMinDistance = 5
		v2:Play()
		v2.Ended:Connect(function() --[[ Line: 121 | Upvalues: v2 (copy) ]]
			v2:Destroy()
		end)
		task.delay(0.8 + math.random() * 0.5, function() --[[ Line: 124 | Upvalues: v4 (ref) ]]
			v4 = false
		end)
	end
end

local function playRattleSound() --[[ playRattleSound | Line: 129 | Upvalues: v3 (ref), v2 (copy), v1 (copy) ]]
	if v3 or not (#v2 > 0) then
		return
	end

	v3 = true

	local v12 = v2[math.random(1, #v2)]:Clone()

	v12.Parent = v1.PrimaryPart
	v12:Play()
	v12.RollOffMaxDistance = 15
	v12.RollOffMinDistance = 5
	v12.Ended:Connect(function() --[[ Line: 137 | Upvalues: v12 (copy), v3 (ref) ]]
		v12:Destroy()
		v3 = false
	end)
end

local function updateSpring(p1, p2) --[[ updateSpring | Line: 148 | Upvalues: Humanoid (copy), HumanoidRootPart (copy), playBackpackFoley (copy), playRattleSound (copy) ]]
	local v1 = Humanoid:GetState()
	local v2 = if v1 == Enum.HumanoidStateType.Jumping then true elseif v1 == Enum.HumanoidStateType.Freefall then true else false
	local v3 = if v1 == Enum.HumanoidStateType.Landed then true else v1 == Enum.HumanoidStateType.Running
	local v4 = HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)
	local Magnitude = v4.Magnitude
	local v5 = if p2.IsBackpack then 150 else 200
	local v6 = if p2.IsBackpack then 3 else 2
	local v7 = if p2.IsBackpack then 0.08726646259971647 else 0.12217304763960307
	local v8, sum

	if Magnitude > 0.1 then
		local v9 = HumanoidRootPart.CFrame:VectorToObjectSpace(v4)

		v8 = math.clamp(v9.X / 15, -1, 1) * v7
		sum = math.clamp(-v9.Z / 15, -1, 1) * v7

		if p2.IsBackpack then
			if Magnitude > 5 and math.random() < 0.03 then
				playBackpackFoley()
			end
		else
			playRattleSound()
		end
	else
		sum = 0
		v8 = 0
	end

	if v2 and not p2.wasInAir then
		sum = sum - (if p2.IsBackpack then 3.490658503988659 else 5.235987755982989)

		if not p2.IsBackpack then
			playRattleSound()
		end
	elseif v3 and p2.wasInAir then
		sum = sum + (if p2.IsBackpack then 4.363323129985824 else 6.981317007977318)

		if not p2.IsBackpack then
			playRattleSound()
		end
	end

	p2.wasInAir = v2
	p2.springVelocityX = p2.springVelocityX + (v5 * (v8 - p2.currentRotationX) - p2.springVelocityX * v6) * p1
	p2.currentRotationX = p2.currentRotationX + p2.springVelocityX * p1
	p2.currentRotationX = math.clamp(p2.currentRotationX, -v7, v7)
	p2.springVelocityZ = p2.springVelocityZ + (v5 * (sum - p2.currentRotationZ) - p2.springVelocityZ * v6) * p1
	p2.currentRotationZ = p2.currentRotationZ + p2.springVelocityZ * p1
	p2.currentRotationZ = math.clamp(p2.currentRotationZ, -v7, v7)

	local v16 = if p2.IsBackpack then CFrame.Angles(p2.currentRotationZ, p2.currentRotationX, 0) else CFrame.Angles(0, p2.currentRotationX, p2.currentRotationZ)

	p2.Weld.C1 = CFrame.new(p2.OriginalC1.Position) * v16
	p2.lastVelocity = v4
end

RunService.RenderStepped:Connect(function(p1) --[[ Line: 208 | Upvalues: t (ref), updateSpring (copy) ]]
	for k, v in pairs(t) do
		if v.Weld and v.Weld.Parent then
			updateSpring(p1, v)
		end
	end
end)
initializePhysicsObjects()
connectPhysicsEvents()