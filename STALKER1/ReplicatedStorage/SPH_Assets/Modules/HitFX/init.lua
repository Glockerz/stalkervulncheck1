-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")
local GameConfig = require(script.Parent.Parent.GameConfig)
local WorldToGui = script:WaitForChild("WorldToGui")

if typeof(WorldToGui) == "Instance" then
	WorldToGui = require(WorldToGui)
end

local MaterialTypes = require(script.Parent.MaterialTypes)
local v1 = script:WaitForChild("EnablePartBasedBulletHoles").Value
local BulletHoles = script:WaitForChild("BulletHoles")
local v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13

if BulletHoles then
	v2 = {
		Stone = "rbxassetid://16872096336",
		Wood = "rbxassetid://114129020885295",
		Metal = "rbxassetid://132113206029212",
		Glass = "rbxassetid://108748702128763"
	}
	v3 = { "1565824613", "1565825075" }
	v4 = { "282954522", "282954538", "282954576", "1565756607", "1565756818" }
	v5 = { "1565830611", "1565831129", "1565831468", "1565832329" }
	v6 = { "287772625", "287772674", "287772718", "287772829", "287772902" }
	v7 = { "287769261", "287769348", "287769415", "287769483", "287769538" }
	v8 = { "363818432", "363818488", "363818567", "363818611", "363818653" }
	v9 = { "4459572527", "4459573786", "3739364168" }
	v10 = script
	v11 = {}
	function CheckColor(p13, p23) --[[ CheckColor | Line: 42 ]]
		local v1 = p13 + p23

		if v1 > 1 then
			return 1
		end

		if v1 < 0 then
			v1 = 0
		end

		return v1
	end
	function BloodSplat(p13, p23, p33) --[[ BloodSplat | Line: 53 | Upvalues: CollectionService (copy), v8 (copy), Debris (copy) ]]
		local BloodSplatterModules = script.BloodSplatterModules

		if math.random(0, 100) > 50 then
			p33 = -p33
		end

		local v1 = CFrame.new(p13, p13 + p33)
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
		task.delay(0.15, function() --[[ Line: 83 | Upvalues: BodyThrust (copy) ]]
			BodyThrust:Destroy()
		end)

		local GibStuff = BloodSplatterModules.GibStuff
		local RaycastHitboxV3 = require(BloodSplatterModules.RaycastHitboxV3)
		local DecalSurface = require(BloodSplatterModules.DecalSurface)
		local v122 = RaycastHitboxV3:Initialize(v2, { workspace.ignore, v2.owner.Value, v2 })
		local t2 = {
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

		local function isBlacklisted(p13) --[[ isBlacklisted | Line: 95 | Upvalues: t2 (copy) ]]
			for k2, v in pairs(t2) do
				if p13.Name == v then
					return true
				end
			end

			return false
		end

		GibStuff.LightSplats:GetChildren()
		GibStuff.DenseSplatters:GetChildren()

		local v13 = false
		local v14 = nil

		delay(0.1, function() --[[ Line: 112 | Upvalues: v13 (ref) ]]
			v13 = true
		end)
		v122:PartMode(true)
		v122.OnHit:Connect(function(p13, p23, p33) --[[ Line: 117 | Upvalues: t2 (copy), CollectionService (ref), v14 (ref), DecalSurface (copy), v122 (copy), v2 (copy) ]]
			local Position = p33.Position
			local Normal = p33.Normal

			if not p13 then
				return
			end

			local v1 = false

			for k2, v in pairs(t2) do
				if p13.Name == v then
					v1 = true

					break
				end
			end

			if v1 ~= false or (p13.Parent:IsA("Accessory") ~= false or (p13.Parent:IsA("Tool") ~= false or (p13.Parent:FindFirstChild("Humanoid") ~= nil or p13.CanCollide == false))) then
				return
			end

			if not (CollectionService:HasTag(p13, "Gibbed") or (CollectionService:HasTag(p13, "Gibs") or CollectionService:HasTag(p13, "Gore"))) then
				v14 = "Small"
				DecalSurface.MakeDecalOnSurface("Blood", Normal, p13, Position, v14)
			end

			v122:HitStop()
			v2:Destroy()
		end)
		v122:HitStart()

		local Sound = Instance.new("Sound")
		local v15 = v8

		Sound.Parent = Attachment
		Sound.Volume = math.random(5, 10) / 10
		Sound.MaxDistance = 500
		Sound.EmitterSize = 10
		Sound.PlaybackSpeed = math.random(34, 50) / 40
		Sound.SoundId = "rbxassetid://" .. v15[math.random(1, #v15)]
		Sound:Play()

		if Sound.TimeLength > 3 then
			local TimeLength = Sound.TimeLength
		end

		for k2, v in pairs(BloodSplatterModules.BloodEffect:GetChildren()) do
			if v.ClassName == "ParticleEmitter" then
				local v16 = v:Clone()

				v16.Parent = Attachment

				local v17 = if v16:FindFirstChild("EmitCount") then v16.EmitCount.Value else 1

				task.delay(0.01, function() --[[ Line: 172 | Upvalues: v16 (copy), v17 (ref), Debris (ref) ]]
					v16:Emit(v17)
					Debris:AddItem(v16, v16.Lifetime.Max)
				end)
			end
		end

		Debris:AddItem(Attachment, 10)
	end
	function CreateEffect(p13, p23, p33) --[[ CreateEffect | Line: 183 | Upvalues: v10 (copy), v7 (copy), v9 (copy), v8 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), Debris (copy) ]]
		local v1 = v10:FindFirstChild(p13) or v10.Stone
		local v32 = 3

		for k2, v in pairs(v1:GetChildren()[math.random(1, #v1:GetChildren())]:Clone():GetChildren()) do
			if not v:IsA("ParticleEmitter") then
				return
			end

			v.Parent = p23
			v.Enabled = false

			if p13 == "Sand" and p33 then
				local Color = p33.Color
				local v42 = if p33.Material == Enum.Material.Fabric then -0.2 else 0.3
				local v52 = Color3.new(CheckColor(Color.R, v42), CheckColor(Color.G, v42), CheckColor(Color.B, v42))

				v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v52), ColorSequenceKeypoint.new(1, v52) })
			end

			v:Emit(v.Rate > 10 and v.Rate / 10 or 1)

			if v32 < v.Lifetime.Max then
				v32 = v.Lifetime.Max
			end
		end

		local Sound = Instance.new("Sound")
		local v72 = v7

		if p13 == "Headshot" then
			v72 = v9
		elseif p13 == "Hit" then
			v72 = v8
		elseif p13 == "Glass" then
			v72 = v3
		elseif p13 == "Metal" then
			v72 = v4
		elseif p13 == "Ground" then
			v72 = v5
		elseif p13 == "Wood" then
			v72 = v6
		end

		Sound.Parent = p23
		Sound.Volume = math.random(5, 10) / 10
		Sound.MaxDistance = 500
		Sound.EmitterSize = 10
		Sound.PlaybackSpeed = math.random(34, 50) / 40
		Sound.SoundId = "rbxassetid://" .. v72[math.random(1, #v72)]
		Sound:Play()

		if v32 < Sound.TimeLength then
			v32 = Sound.TimeLength
		end

		Debris:AddItem(p23, v32)
	end
	v12 = function(p13, p23, p33) --[[ CreateSurfaceGuiBulletHole | Line: 243 | Upvalues: WorldToGui (ref), MaterialTypes (copy), v2 (copy), Debris (copy), GameConfig (copy) ]]
		local v1, _, _22, v22, v3 = WorldToGui:WorldPositionToGuiPosition(p13, p23)

		if not v1 then
			return
		end

		local v4 = MaterialTypes(p33)
		local v5 = string.format("BulletHoleGui_%s", v1.Name)
		local v6 = p13:FindFirstChild(v5)
		local v7

		if v6 then
			local Container = v6:WaitForChild("Container", 0.1)

			v7 = Container

			if not Container then
				warn("Existing BulletHoleGui found without Container for part:", p13, "face:", v1.Name)
				v6:Destroy()
				v6 = nil
			end
		else
			v7 = nil
		end

		if not v6 then
			local SurfaceGui = Instance.new("SurfaceGui")

			SurfaceGui.Name = v5
			SurfaceGui.Parent = p13
			SurfaceGui.Face = v1
			SurfaceGui.Adornee = p13
			SurfaceGui.CanvasSize = Vector2.new(2048, 2048)
			SurfaceGui.LightInfluence = 1
			SurfaceGui.AlwaysOnTop = false
			SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			SurfaceGui.ClipsDescendants = true
			SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
			SurfaceGui.PixelsPerStud = 50

			local Container = Instance.new("Frame")

			Container.Name = "Container"
			Container.Parent = SurfaceGui
			Container.BackgroundTransparency = 1
			Container.Size = UDim2.fromScale(1, 1)
			Container.ClipsDescendants = true
			v7 = Container
			v6 = SurfaceGui
		end

		local BulletHoleFrame = Instance.new("Frame")

		BulletHoleFrame.Name = "BulletHoleFrame"
		BulletHoleFrame.Parent = v7
		BulletHoleFrame.BackgroundTransparency = 1
		BulletHoleFrame.BorderSizePixel = 0
		BulletHoleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		BulletHoleFrame.Position = UDim2.new(v22, 0, v3, 0)
		BulletHoleFrame.Size = UDim2.new(0, 0.45 * v6.PixelsPerStud, 0, 0.45 * v6.PixelsPerStud)

		local BulletHoleImage = Instance.new("ImageLabel")

		BulletHoleImage.Name = "BulletHoleImage"
		BulletHoleImage.Parent = BulletHoleFrame
		BulletHoleImage.BackgroundTransparency = 1
		BulletHoleImage.ImageTransparency = 0
		BulletHoleImage.SizeConstraint = Enum.SizeConstraint.RelativeXY
		BulletHoleImage.Size = UDim2.fromScale(1, 1)
		BulletHoleImage.Position = UDim2.fromScale(0.5, 0.5)
		BulletHoleImage.AnchorPoint = Vector2.new(0.5, 0.5)
		BulletHoleImage.Image = v2[v4] or "rbxassetid://12769915043"
		Debris:AddItem(BulletHoleFrame, GameConfig.bulletHoleDespawnTime)
	end
	v13 = function(p13, p23, p33, p43) --[[ CreatePartBasedBulletHole | Line: 306 | Upvalues: MaterialTypes (copy), BulletHoles (copy), Debris (copy), GameConfig (copy) ]]
		local v1 = MaterialTypes(p43)
		local v2 = if BulletHoles then BulletHoles:FindFirstChild(v1) or BulletHoles:FindFirstChild("Default") else nil

		if v2 then
			local v4 = v2:Clone()

			v4.Anchored = false
			v4.CanCollide = false
			v4.CastShadow = false
			v4.CanCollide = false
			v4.CanQuery = false

			local v5 = CFrame.lookAt(p23, p23 + p33) * CFrame.Angles(-1.5707963267948966, 0, 0)

			v4.CFrame = CFrame.new(p23 + p33 * 0.01) * (v5 - v5.Position)
			v4.Parent = p13

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = p13
			WeldConstraint.Part1 = v4
			WeldConstraint.Parent = v4
			Debris:AddItem(v4, GameConfig.bulletHoleDespawnTime)
		end
	end
	function v11.HitEffect(p13, p23, p33) --[[ HitEffect | Line: 335 | Upvalues: GameConfig (copy), CollectionService (copy), v1 (copy), v13 (copy), v12 (copy) ]]
		local Material = p23.Material
		local Attachment = Instance.new("Attachment")

		Attachment.CFrame = CFrame.new(p13, p13 + p33)
		Attachment.Parent = workspace.Terrain

		if not p23 then
			return
		end

		local v14 = "Stone"
		local v2 = false

		if p23.Name == "Head" then
			v2 = true
			v14 = "Headshot"
		elseif p23:IsA("BasePart") then
			if p23.Parent:FindFirstChild("Humanoid") or p23.Parent.Parent and p23.Parent.Parent:FindFirstChild("Humanoid") or (p23.Parent.Parent and (p23.Parent.Parent.Parent and p23.Parent.Parent.Parent:FindFirstChild("Humanoid")) or p23.Parent:IsA("Accessory")) then
				v2 = true
				v14 = "Hit"
			elseif Material == Enum.Material.Wood or Material == Enum.Material.WoodPlanks then
				v14 = "Wood"
			elseif Material == Enum.Material.Metal or (Material == Enum.Material.CorrodedMetal or (Material == Enum.Material.DiamondPlate or (Material == Enum.Material.Neon or Material == Enum.Material.Salt))) then
				v14 = "Metal"
			elseif Material == Enum.Material.Grass or (Material == Enum.Material.Ground or (Material == Enum.Material.LeafyGrass or Material == Enum.Material.Mud)) then
				v14 = "Ground"
			elseif Material == Enum.Material.Sand or (Material == Enum.Material.Fabric or Material == Enum.Material.Snow) then
				v14 = "Sand"
			elseif Material == Enum.Material.Foil or (Material == Enum.Material.Ice or (Material == Enum.Material.Glass or Material == Enum.Material.ForceField)) then
				v14 = "Glass"
			elseif p23.Name == "Glass" then
				p23:Destroy()
				v14 = "Glass"
			end
		elseif p23.Parent:IsA("Accessory") then
			v2 = true
			v14 = "Hit"
		elseif Material == Enum.Material.Wood or Material == Enum.Material.WoodPlanks then
			v14 = "Wood"
		elseif Material == Enum.Material.Metal or (Material == Enum.Material.CorrodedMetal or (Material == Enum.Material.DiamondPlate or (Material == Enum.Material.Neon or Material == Enum.Material.Salt))) then
			v14 = "Metal"
		elseif Material == Enum.Material.Grass or (Material == Enum.Material.Ground or (Material == Enum.Material.LeafyGrass or Material == Enum.Material.Mud)) then
			v14 = "Ground"
		elseif Material == Enum.Material.Sand or (Material == Enum.Material.Fabric or Material == Enum.Material.Snow) then
			v14 = "Sand"
		elseif Material == Enum.Material.Foil or (Material == Enum.Material.Ice or (Material == Enum.Material.Glass or Material == Enum.Material.ForceField)) then
			v14 = "Glass"
		elseif p23.Name == "Glass" then
			p23:Destroy()
			v14 = "Glass"
		end

		if v2 == true then
			BloodSplat(p13, p23, p33)
		else
			CreateEffect(v14, Attachment, p23)
		end

		if not GameConfig.bulletHoles or (not (p23.Transparency < 1) or v2) then
			return
		end

		if GameConfig.glassShatter and (p23.Name == "Glass" or CollectionService:HasTag(p23, "BreakableGlass")) then
			return
		end

		if v1 then
			v13(p23, p13, p33, Material)

			return
		end

		v12(p23, p13, Material)
	end

	return v11
end

warn("BulletHoles folder not found as a child. Part-based bullet holes will use default.")
v2 = {
	Stone = "rbxassetid://16872096336",
	Wood = "rbxassetid://114129020885295",
	Metal = "rbxassetid://132113206029212",
	Glass = "rbxassetid://108748702128763"
}
v3 = { "1565824613", "1565825075" }
v4 = { "282954522", "282954538", "282954576", "1565756607", "1565756818" }
v5 = { "1565830611", "1565831129", "1565831468", "1565832329" }
v6 = { "287772625", "287772674", "287772718", "287772829", "287772902" }
v7 = { "287769261", "287769348", "287769415", "287769483", "287769538" }
v8 = { "363818432", "363818488", "363818567", "363818611", "363818653" }
v9 = { "4459572527", "4459573786", "3739364168" }
v10 = script
v11 = {}
function CheckColor(p13, p23) --[[ CheckColor | Line: 42 ]]
	local v1 = p13 + p23

	if v1 > 1 then
		return 1
	end

	if v1 < 0 then
		v1 = 0
	end

	return v1
end
function BloodSplat(p13, p23, p33) --[[ BloodSplat | Line: 53 | Upvalues: CollectionService (copy), v8 (copy), Debris (copy) ]]
	local BloodSplatterModules = script.BloodSplatterModules

	if math.random(0, 100) > 50 then
		p33 = -p33
	end

	local v1 = CFrame.new(p13, p13 + p33)
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
	task.delay(0.15, function() --[[ Line: 83 | Upvalues: BodyThrust (copy) ]]
		BodyThrust:Destroy()
	end)

	local GibStuff = BloodSplatterModules.GibStuff
	local RaycastHitboxV3 = require(BloodSplatterModules.RaycastHitboxV3)
	local DecalSurface = require(BloodSplatterModules.DecalSurface)
	local v122 = RaycastHitboxV3:Initialize(v2, { workspace.ignore, v2.owner.Value, v2 })
	local t2 = {
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

	local function isBlacklisted(p13) --[[ isBlacklisted | Line: 95 | Upvalues: t2 (copy) ]]
		for k2, v in pairs(t2) do
			if p13.Name == v then
				return true
			end
		end

		return false
	end

	GibStuff.LightSplats:GetChildren()
	GibStuff.DenseSplatters:GetChildren()

	local v13 = false
	local v14 = nil

	delay(0.1, function() --[[ Line: 112 | Upvalues: v13 (ref) ]]
		v13 = true
	end)
	v122:PartMode(true)
	v122.OnHit:Connect(function(p13, p23, p33) --[[ Line: 117 | Upvalues: t2 (copy), CollectionService (ref), v14 (ref), DecalSurface (copy), v122 (copy), v2 (copy) ]]
		local Position = p33.Position
		local Normal = p33.Normal

		if not p13 then
			return
		end

		local v1 = false

		for k2, v in pairs(t2) do
			if p13.Name == v then
				v1 = true

				break
			end
		end

		if v1 ~= false or (p13.Parent:IsA("Accessory") ~= false or (p13.Parent:IsA("Tool") ~= false or (p13.Parent:FindFirstChild("Humanoid") ~= nil or p13.CanCollide == false))) then
			return
		end

		if not (CollectionService:HasTag(p13, "Gibbed") or (CollectionService:HasTag(p13, "Gibs") or CollectionService:HasTag(p13, "Gore"))) then
			v14 = "Small"
			DecalSurface.MakeDecalOnSurface("Blood", Normal, p13, Position, v14)
		end

		v122:HitStop()
		v2:Destroy()
	end)
	v122:HitStart()

	local Sound = Instance.new("Sound")
	local v15 = v8

	Sound.Parent = Attachment
	Sound.Volume = math.random(5, 10) / 10
	Sound.MaxDistance = 500
	Sound.EmitterSize = 10
	Sound.PlaybackSpeed = math.random(34, 50) / 40
	Sound.SoundId = "rbxassetid://" .. v15[math.random(1, #v15)]
	Sound:Play()

	if Sound.TimeLength > 3 then
		local TimeLength = Sound.TimeLength
	end

	for k2, v in pairs(BloodSplatterModules.BloodEffect:GetChildren()) do
		if v.ClassName == "ParticleEmitter" then
			local v16 = v:Clone()

			v16.Parent = Attachment

			local v17 = if v16:FindFirstChild("EmitCount") then v16.EmitCount.Value else 1

			task.delay(0.01, function() --[[ Line: 172 | Upvalues: v16 (copy), v17 (ref), Debris (ref) ]]
				v16:Emit(v17)
				Debris:AddItem(v16, v16.Lifetime.Max)
			end)
		end
	end

	Debris:AddItem(Attachment, 10)
end
function CreateEffect(p13, p23, p33) --[[ CreateEffect | Line: 183 | Upvalues: v10 (copy), v7 (copy), v9 (copy), v8 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), Debris (copy) ]]
	local v1 = v10:FindFirstChild(p13) or v10.Stone
	local v32 = 3

	for k2, v in pairs(v1:GetChildren()[math.random(1, #v1:GetChildren())]:Clone():GetChildren()) do
		if not v:IsA("ParticleEmitter") then
			return
		end

		v.Parent = p23
		v.Enabled = false

		if p13 == "Sand" and p33 then
			local Color = p33.Color
			local v42 = if p33.Material == Enum.Material.Fabric then -0.2 else 0.3
			local v52 = Color3.new(CheckColor(Color.R, v42), CheckColor(Color.G, v42), CheckColor(Color.B, v42))

			v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v52), ColorSequenceKeypoint.new(1, v52) })
		end

		v:Emit(v.Rate > 10 and v.Rate / 10 or 1)

		if v32 < v.Lifetime.Max then
			v32 = v.Lifetime.Max
		end
	end

	local Sound = Instance.new("Sound")
	local v72 = v7

	if p13 == "Headshot" then
		v72 = v9
	elseif p13 == "Hit" then
		v72 = v8
	elseif p13 == "Glass" then
		v72 = v3
	elseif p13 == "Metal" then
		v72 = v4
	elseif p13 == "Ground" then
		v72 = v5
	elseif p13 == "Wood" then
		v72 = v6
	end

	Sound.Parent = p23
	Sound.Volume = math.random(5, 10) / 10
	Sound.MaxDistance = 500
	Sound.EmitterSize = 10
	Sound.PlaybackSpeed = math.random(34, 50) / 40
	Sound.SoundId = "rbxassetid://" .. v72[math.random(1, #v72)]
	Sound:Play()

	if v32 < Sound.TimeLength then
		v32 = Sound.TimeLength
	end

	Debris:AddItem(p23, v32)
end
v12 = function(p13, p23, p33) --[[ CreateSurfaceGuiBulletHole | Line: 243 | Upvalues: WorldToGui (ref), MaterialTypes (copy), v2 (copy), Debris (copy), GameConfig (copy) ]]
	local v1, _, _22, v22, v3 = WorldToGui:WorldPositionToGuiPosition(p13, p23)

	if not v1 then
		return
	end

	local v4 = MaterialTypes(p33)
	local v5 = string.format("BulletHoleGui_%s", v1.Name)
	local v6 = p13:FindFirstChild(v5)
	local v7

	if v6 then
		local Container = v6:WaitForChild("Container", 0.1)

		v7 = Container

		if not Container then
			warn("Existing BulletHoleGui found without Container for part:", p13, "face:", v1.Name)
			v6:Destroy()
			v6 = nil
		end
	else
		v7 = nil
	end

	if not v6 then
		local SurfaceGui = Instance.new("SurfaceGui")

		SurfaceGui.Name = v5
		SurfaceGui.Parent = p13
		SurfaceGui.Face = v1
		SurfaceGui.Adornee = p13
		SurfaceGui.CanvasSize = Vector2.new(2048, 2048)
		SurfaceGui.LightInfluence = 1
		SurfaceGui.AlwaysOnTop = false
		SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		SurfaceGui.ClipsDescendants = true
		SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
		SurfaceGui.PixelsPerStud = 50

		local Container = Instance.new("Frame")

		Container.Name = "Container"
		Container.Parent = SurfaceGui
		Container.BackgroundTransparency = 1
		Container.Size = UDim2.fromScale(1, 1)
		Container.ClipsDescendants = true
		v7 = Container
		v6 = SurfaceGui
	end

	local BulletHoleFrame = Instance.new("Frame")

	BulletHoleFrame.Name = "BulletHoleFrame"
	BulletHoleFrame.Parent = v7
	BulletHoleFrame.BackgroundTransparency = 1
	BulletHoleFrame.BorderSizePixel = 0
	BulletHoleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	BulletHoleFrame.Position = UDim2.new(v22, 0, v3, 0)
	BulletHoleFrame.Size = UDim2.new(0, 0.45 * v6.PixelsPerStud, 0, 0.45 * v6.PixelsPerStud)

	local BulletHoleImage = Instance.new("ImageLabel")

	BulletHoleImage.Name = "BulletHoleImage"
	BulletHoleImage.Parent = BulletHoleFrame
	BulletHoleImage.BackgroundTransparency = 1
	BulletHoleImage.ImageTransparency = 0
	BulletHoleImage.SizeConstraint = Enum.SizeConstraint.RelativeXY
	BulletHoleImage.Size = UDim2.fromScale(1, 1)
	BulletHoleImage.Position = UDim2.fromScale(0.5, 0.5)
	BulletHoleImage.AnchorPoint = Vector2.new(0.5, 0.5)
	BulletHoleImage.Image = v2[v4] or "rbxassetid://12769915043"
	Debris:AddItem(BulletHoleFrame, GameConfig.bulletHoleDespawnTime)
end
v13 = function(p13, p23, p33, p43) --[[ CreatePartBasedBulletHole | Line: 306 | Upvalues: MaterialTypes (copy), BulletHoles (copy), Debris (copy), GameConfig (copy) ]]
	local v1 = MaterialTypes(p43)
	local v2 = if BulletHoles then BulletHoles:FindFirstChild(v1) or BulletHoles:FindFirstChild("Default") else nil

	if v2 then
		local v4 = v2:Clone()

		v4.Anchored = false
		v4.CanCollide = false
		v4.CastShadow = false
		v4.CanCollide = false
		v4.CanQuery = false

		local v5 = CFrame.lookAt(p23, p23 + p33) * CFrame.Angles(-1.5707963267948966, 0, 0)

		v4.CFrame = CFrame.new(p23 + p33 * 0.01) * (v5 - v5.Position)
		v4.Parent = p13

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = p13
		WeldConstraint.Part1 = v4
		WeldConstraint.Parent = v4
		Debris:AddItem(v4, GameConfig.bulletHoleDespawnTime)
	end
end
function v11.HitEffect(p13, p23, p33) --[[ HitEffect | Line: 335 | Upvalues: GameConfig (copy), CollectionService (copy), v1 (copy), v13 (copy), v12 (copy) ]]
	local Material = p23.Material
	local Attachment = Instance.new("Attachment")

	Attachment.CFrame = CFrame.new(p13, p13 + p33)
	Attachment.Parent = workspace.Terrain

	if not p23 then
		return
	end

	local v14 = "Stone"
	local v2 = false

	if p23.Name == "Head" then
		v2 = true
		v14 = "Headshot"
	elseif p23:IsA("BasePart") then
		if p23.Parent:FindFirstChild("Humanoid") or p23.Parent.Parent and p23.Parent.Parent:FindFirstChild("Humanoid") or (p23.Parent.Parent and (p23.Parent.Parent.Parent and p23.Parent.Parent.Parent:FindFirstChild("Humanoid")) or p23.Parent:IsA("Accessory")) then
			v2 = true
			v14 = "Hit"
		elseif Material == Enum.Material.Wood or Material == Enum.Material.WoodPlanks then
			v14 = "Wood"
		elseif Material == Enum.Material.Metal or (Material == Enum.Material.CorrodedMetal or (Material == Enum.Material.DiamondPlate or (Material == Enum.Material.Neon or Material == Enum.Material.Salt))) then
			v14 = "Metal"
		elseif Material == Enum.Material.Grass or (Material == Enum.Material.Ground or (Material == Enum.Material.LeafyGrass or Material == Enum.Material.Mud)) then
			v14 = "Ground"
		elseif Material == Enum.Material.Sand or (Material == Enum.Material.Fabric or Material == Enum.Material.Snow) then
			v14 = "Sand"
		elseif Material == Enum.Material.Foil or (Material == Enum.Material.Ice or (Material == Enum.Material.Glass or Material == Enum.Material.ForceField)) then
			v14 = "Glass"
		elseif p23.Name == "Glass" then
			p23:Destroy()
			v14 = "Glass"
		end
	elseif p23.Parent:IsA("Accessory") then
		v2 = true
		v14 = "Hit"
	elseif Material == Enum.Material.Wood or Material == Enum.Material.WoodPlanks then
		v14 = "Wood"
	elseif Material == Enum.Material.Metal or (Material == Enum.Material.CorrodedMetal or (Material == Enum.Material.DiamondPlate or (Material == Enum.Material.Neon or Material == Enum.Material.Salt))) then
		v14 = "Metal"
	elseif Material == Enum.Material.Grass or (Material == Enum.Material.Ground or (Material == Enum.Material.LeafyGrass or Material == Enum.Material.Mud)) then
		v14 = "Ground"
	elseif Material == Enum.Material.Sand or (Material == Enum.Material.Fabric or Material == Enum.Material.Snow) then
		v14 = "Sand"
	elseif Material == Enum.Material.Foil or (Material == Enum.Material.Ice or (Material == Enum.Material.Glass or Material == Enum.Material.ForceField)) then
		v14 = "Glass"
	elseif p23.Name == "Glass" then
		p23:Destroy()
		v14 = "Glass"
	end

	if v2 == true then
		BloodSplat(p13, p23, p33)
	else
		CreateEffect(v14, Attachment, p23)
	end

	if not GameConfig.bulletHoles or (not (p23.Transparency < 1) or v2) then
		return
	end

	if GameConfig.glassShatter and (p23.Name == "Glass" or CollectionService:HasTag(p23, "BreakableGlass")) then
		return
	end

	if v1 then
		v13(p23, p13, p33, Material)

		return
	end

	v12(p23, p13, Material)
end

return v11