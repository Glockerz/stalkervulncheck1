-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

game:GetService("PhysicsService")

local Sounds = script.Parent.Parent:WaitForChild("Sounds")
local Gore_Resource = game:GetService("ReplicatedStorage"):WaitForChild("SPH_Assets").Gore_Resource
local Gibs = Gore_Resource.Gibs
local CollectionService = game:GetService("CollectionService")
local Utilities = require(script.Utilities)
local v1 = nil

game:GetService("Debris")

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")

local UnitHitbox = require(script.UnitHitbox)

function BloodSplat(p1, p2, p3) --[[ BloodSplat | Line: 18 | Upvalues: ReplicatedStorage (copy), CollectionService (copy), Debris (copy) ]]
	local BloodSplatterModules = ReplicatedStorage.SPH_Assets.Modules.HitFX.BloodSplatterModules

	if math.random(0, 100) > 50 then
		p3 = -p3
	end

	local v1 = CFrame.new(p1, p1 + p3)
	local Attachment = Instance.new("Attachment")

	Attachment.CFrame = v1
	Attachment.Parent = game.Workspace.Terrain

	local v2 = BloodSplatterModules.GibStuff.Drop3:Clone()

	v2.Parent = game.Workspace
	v2.CFrame = Attachment.CFrame
	v2.Orientation = Vector3.new(Attachment.Orientation.X + math.random(-50, 50), Attachment.Orientation.Y + math.random(-50, 50), Attachment.Orientation.Z + math.random(-50, 50))

	local BodyThrust = Instance.new("BodyThrust")

	BodyThrust.Force = Vector3.new(math.random(-2, 2) * 0.5, math.random(-2, 5) * 0.5, math.random(-57, -5) * 0.5)
	BodyThrust.Parent = v2
	task.delay(0.15, function() --[[ Line: 48 | Upvalues: BodyThrust (copy) ]]
		BodyThrust:Destroy()
	end)

	local GibStuff = BloodSplatterModules.GibStuff
	local RaycastHitboxV3 = require(BloodSplatterModules.RaycastHitboxV3)
	local DecalSurface = require(BloodSplatterModules.DecalSurface)
	local v12 = RaycastHitboxV3:Initialize(v2, { workspace.ignore, v2.owner.Value, v2 })
	local t = {
		"splat",
		"blood",
		"Drop",
		"Drop2",
		"Puddle",
		"Handle",
		"Splatter",
		"Torso",
		"HumanoidRootPart",
		"Left Arm",
		"Right Arm",
		"Left Leg",
		"Right Leg",
		"Head",
		"Collision",
		"Weight",
		"ColliderPart"
	}

	local function isBlacklisted(p1) --[[ isBlacklisted | Line: 60 | Upvalues: t (copy) ]]
		for k, v in pairs(t) do
			if p1.Name == v then
				return true
			end
		end

		return false
	end

	GibStuff.LightSplats:GetChildren()
	GibStuff.DenseSplatters:GetChildren()

	local v13 = false
	local v14 = nil

	delay(0.1, function() --[[ Line: 77 | Upvalues: v13 (ref) ]]
		v13 = true
	end)
	v12:PartMode(true)
	v12.OnHit:Connect(function(p1, p2, p3) --[[ Line: 82 | Upvalues: t (copy), CollectionService (ref), v13 (ref), v14 (ref), DecalSurface (copy), v12 (copy), v2 (copy) ]]
		local Position = p3.Position
		local Normal = p3.Normal

		if not p1 then
			return
		end

		local v1 = false

		for k, v in pairs(t) do
			if p1.Name == v then
				v1 = true

				break
			end
		end

		if v1 ~= false or (p1.Parent:IsA("Accessory") ~= false or (p1.Parent:IsA("Tool") ~= false or (p1.Parent:FindFirstChild("Humanoid") ~= nil or p1.CanCollide == false))) then
			return
		end

		if not (CollectionService:HasTag(p1, "Gibbed") or (CollectionService:HasTag(p1, "Gibs") or CollectionService:HasTag(p1, "Gore"))) then
			if v13 == false then
				v14 = "Big"
				DecalSurface.MakeDecalOnSurface("Blood", Normal, p1, Position, v14)
			elseif v13 == true then
				v14 = "Small"
				DecalSurface.MakeDecalOnSurface("Blood", Normal, p1, Position, v14)
			end
		end

		v12:HitStop()
		v2:Destroy()
	end)
	v12:HitStart()

	for k, v in pairs(BloodSplatterModules.BloodEffect:GetChildren()) do
		if v.ClassName == "ParticleEmitter" then
			local v15 = v:Clone()

			v15.Parent = Attachment

			local v16 = if v15:FindFirstChild("EmitCount") then v15.EmitCount.Value else 1

			task.delay(0.01, function() --[[ Line: 126 | Upvalues: v15 (copy), v16 (ref), Debris (ref) ]]
				v15:Emit(v16)
				Debris:AddItem(v15, v15.Lifetime.Max)
			end)
		end
	end

	Debris:AddItem(Attachment, 10)
end

local function setPartToGroup(p1, p2) --[[ setPartToGroup | Line: 138 | Upvalues: CollectionService (copy) ]]
	if p1:IsA("BasePart") then
		CollectionService:AddTag(p1, "SPH_NoCollide")
	end

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			CollectionService:AddTag(v, "SPH_NoCollide")
		end
	end
end

local function RemoveItems(p1, p2) --[[ RemoveItems | Line: 152 | Upvalues: CollectionService (copy) ]]
	if p1.Name ~= "Head" then
		warn("error: Not a Head.")

		return
	end

	for k, v in pairs(p2:GetChildren()) do
		if v:IsA("Accessory") then
			for k2, v2 in pairs(v:GetChildren()) do
				if v2:IsA("BasePart") then
					CollectionService:AddTag(v2, "Gibbed")
					v2.Transparency = 1
				end
			end

			continue
		end

		warn("Error: Not a Head Accessory or visible decal")
	end

	for k, v in pairs(p1:GetChildren()) do
		if v:IsA("Decal") and v.Transparency == 0 then
			print(v)
			v.Transparency = 1
			CollectionService:AddTag(v, "Gibbed")
		end
	end
end

local function Shirt(p1, p2, p3) --[[ Shirt | Line: 179 ]]
	p1.Transparency = 1
	p3.skin.Color = p1.Color

	if not p2:FindFirstChildOfClass("Shirt") and (not p2:FindFirstChildOfClass("Pants") or p3.Name == "Head") then
		return
	end

	if string.find(p1.Name, "Leg") then
		p3.skin.Shirt.Texture = p2:FindFirstChildOfClass("Pants").PantsTemplate

		return
	end

	if not (string.find(p1.Name, "Arm") or string.find(p1.Name, "Torso")) then
		return
	end

	p3.skin.Shirt.Texture = p2:FindFirstChildOfClass("Shirt").ShirtTemplate
end

local function Debris2(p1, p2) --[[ Debris | Line: 196 | Upvalues: Gore_Resource (copy), Gibs (copy), Shirt (copy), CollectionService (copy), setPartToGroup (copy), UnitHitbox (copy) ]]
	local v1 = nil
	local v2 = nil

	if p1.Name == "Head" then
		v1 = Gore_Resource.Debris.Bits[p1.Name].Brainmatter
	elseif string.find(p1.Name, "Leg") or string.find(p1.Name, "Arm") then
		v1 = Gore_Resource.Debris.Bits.Arm_Leg.Flesh
		v2 = Gibs.Debris[p1.Name]
	end

	local v3 = RaycastParams.new()

	v3.FilterType = Enum.RaycastFilterType.Exclude
	v3.RespectCanCollide = true
	v3.IgnoreWater = true
	v3.FilterDescendantsInstances = { workspace.Debris }

	if v2 then
		local v4 = v2:Clone()

		v4.Parent = workspace.Debris.chunks
		v4.CFrame = p1.CFrame

		local BodyVelocity = Instance.new("BodyVelocity")
		local v5 = Random.new():NextNumber(-2, 5)
		local v6 = Random.new():NextNumber(2, 5)

		BodyVelocity.Velocity = Vector3.new(v5, v6, Random.new():NextNumber(-2, 5))
		BodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
		BodyVelocity.Parent = v4
		game:GetService("Debris"):AddItem(BodyVelocity, 0.01)
		Shirt(p1, p1.Parent, v4)
		CollectionService:AddTag(v4, "Gibs")
		setPartToGroup(v4, "Players")

		local v8 = workspace:Raycast(v4.Position, Vector3.new(0, -3, 0), v3)

		if v8 then
			print("blood splat")
			BloodSplat(v8.Position, v8.Instance, v8.Normal)
		end

		game:GetService("Debris"):AddItem(v4, 30)
	end

	if not v1 then
		return
	end

	for i = 1, p2 do
		local v9 = v1:Clone()

		v9.Parent = workspace.Debris.chunks
		v9.CollisionGroup = "Guns"
		v9.CFrame = CFrame.new(p1.Position)

		local BodyVelocity = Instance.new("BodyVelocity")
		local v10 = Random.new():NextNumber(-2, 5)
		local v11 = Random.new():NextNumber(2, 5)

		BodyVelocity.Velocity = Vector3.new(v10, v11, Random.new():NextNumber(-2, 5))
		BodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
		v9.CanCollide = true
		v9.Anchored = false

		local v13 = UnitHitbox.new(v9, 10, v3)

		v13:HitStart()
		BodyVelocity.Parent = v9
		game:GetService("Debris"):AddItem(BodyVelocity, 0.01)
		CollectionService:AddTag(v9, "NotHit")
		CollectionService:AddTag(v9, "Gibs")
		v13.onHit:Connect(function(p1) --[[ Line: 258 | Upvalues: v13 (copy), CollectionService (ref), v9 (copy) ]]
			v13:HitStop()

			if p1.Instance.Parent:FindFirstChildOfClass("Humanoid") and (CollectionService:HasTag(v9, "NotHit") and not CollectionService:HasTag(v9, "Hit")) then
				game:GetService("Debris"):AddItem(v9, 0.3)

				return
			end

			local v1 = v9
			local v2 = CFrame.new(p1.Position)

			v1.CFrame = v2 * CFrame.Angles(math.rad((math.random(-180, 180))), math.rad((math.random(-180, 180))), (math.rad((math.random(-180, 180)))))
			CollectionService:AddTag(v9, "Hit")
			game:GetService("Debris"):AddItem(v9, 30)
			task.delay(6, function() --[[ Line: 267 | Upvalues: v9 (ref) ]]
				v9.Anchored = true
				v9.CanCollide = false
			end)

			if not (math.random() < 0.5) then
				return
			end

			BloodSplat(p1.Position, p1.Instance, p1.Normal)
		end)
		task.wait()
	end
end

function t.gore(p1, p2, p3) --[[ gore | Line: 285 | Upvalues: CollectionService (copy), v1 (ref), Sounds (copy), Utilities (copy), Shirt (copy), RemoveItems (copy), Gore_Resource (copy), Debris2 (copy) ]]
	if CollectionService:HasTag(p1, "Gibbed") and p1.Name == "HumanoidRootPart" then
		return
	end

	if CollectionService:HasTag(p1, "Gibbed") then
		return
	end

	p1.Transparency = 1
	p1.CanCollide = false
	v1 = p3:Clone()
	v1.Transparency = 1

	local v12 = Sounds:GetChildren()[math.random(1, #Sounds:GetChildren())]:Clone()

	v12.Parent = v1
	v12:Play()
	CollectionService:AddTag(p1, "Gibbed")
	CollectionService:AddTag(v1, "Gore")
	v1.Parent = p1
	v1.CFrame = p1.CFrame
	Utilities.Weld(v1, p1, p2, p1.Name .. "Gibbed")
	Shirt(p1, p2, v1)
	RemoveItems(p1, p2)
	Gore_Resource.Debris.Bits.Head:GetChildren()
	Debris2(p1, 5)
end

return t