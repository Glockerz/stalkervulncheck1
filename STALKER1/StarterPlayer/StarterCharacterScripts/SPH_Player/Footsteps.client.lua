-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SPH_Assets = ReplicatedStorage.SPH_Assets
local GameConfig = require(SPH_Assets.GameConfig)
local BridgeNet = require(ReplicatedStorage.SPH_Assets.Modules.BridgeNet)
local WalkSounds = SPH_Assets.Sounds.WalkSounds
local LocalPlayer = game:GetService("Players").LocalPlayer
local v1 = BridgeNet.CreateBridge("ReplicateFootstep")
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = 0
local t = {
	Asphalt = "Concrete",
	Basalt = "Concrete",
	Brick = "Concrete",
	Cobblestone = "Concrete",
	Concrete = "Concrete",
	CorrodedMetal = "Metal",
	CrackedLava = "Concrete",
	DiamondPlate = "MetalPlate",
	Fabric = "Ground",
	ForceField = "Metal",
	Glacier = "Ground",
	Granite = "Concrete",
	Grass = "Grass",
	Ground = "Ground",
	Ice = "Concrete",
	LeafyGrass = "Grass",
	Limestone = "Concrete",
	Marble = "Concrete",
	Metal = "Metal",
	Mud = "Ground",
	Neon = "Metal",
	Pavement = "Concrete",
	Pebble = "Ground",
	Plastic = "Concrete",
	Rock = "Concrete",
	Salt = "Ground",
	Sand = "Ground",
	Sandstone = "Concrete",
	Slate = "Concrete",
	SmoothPlastic = "Concrete",
	Snow = "Ground",
	Wood = "Wood",
	WoodPlanks = "Wood"
}

local function GetMoveType() --[[ GetMoveType | Line: 56 | Upvalues: v6 (ref), GameConfig (copy) ]]
	if not v6 then
		return "Walk"
	end

	if v6.WalkSpeed <= GameConfig.proneSpeed + 1 then
		return "Prone"
	end

	if v6.WalkSpeed <= GameConfig.crouchSpeed + 1 then
		return "Crouch"
	end

	if v6.WalkSpeed > GameConfig.walkSpeed + 2 then
		return "Run"
	end

	return "Walk"
end

local function GetSound(p1) --[[ GetSound | Line: 70 | Upvalues: t (copy), v6 (ref), GameConfig (copy), WalkSounds (copy) ]]
	local v3 = WalkSounds:FindFirstChild(if v6 then if v6.WalkSpeed <= GameConfig.proneSpeed + 1 then "Prone" elseif v6.WalkSpeed <= GameConfig.crouchSpeed + 1 then "Crouch" elseif v6.WalkSpeed > GameConfig.walkSpeed + 2 then "Run" else "Walk" else "Walk")

	if not v3 then
		v3 = WalkSounds:FindFirstChild("Walk")
	end

	local v4 = if v3 then v3:FindFirstChild(t[p1] or "Concrete") else v3

	if not v4 or #v4:GetChildren() == 0 then
		v4 = if v3 then v3:FindFirstChild("Concrete") else v3
	end

	if not v4 or #v4:GetChildren() == 0 then
		v4 = WalkSounds.Walk.Concrete
	end

	local v62 = v4:GetChildren()

	if #v62 == 0 then
		return "", 1
	end

	local v7 = v62[math.random(#v62)]

	return v7.SoundId, v7.PlaybackSpeed
end

local function Footstep(p1, p2) --[[ Footstep | Line: 96 | Upvalues: GetSound (copy) ]]
	local v1, v2 = GetSound(p1.Name)

	if v1 == "" then
		return
	end

	local v3 = p2.Parent

	if v3 then
		local Sound = Instance.new("Sound")

		Sound.Name = p2.Name .. "_step"
		Sound.SoundId = v1
		Sound.PlaybackSpeed = v2 + math.random(-100, 100) / 1000
		Sound.Volume = p2.Volume
		Sound.RollOffMode = p2.RollOffMode
		Sound.RollOffMinDistance = p2.RollOffMinDistance
		Sound.RollOffMaxDistance = p2.RollOffMaxDistance
		Sound.Parent = v3
		Sound:Play()
		Sound.Ended:Connect(function() --[[ Line: 112 | Upvalues: Sound (copy) ]]
			Sound:Destroy()
		end)
		task.delay(2, function() --[[ Line: 114 | Upvalues: Sound (copy) ]]
			if not Sound.Parent then
				return
			end

			Sound:Destroy()
		end)
	end
end

local v9 = nil
local v10 = Vector3.new()
local v11 = false
local t2 = {
	Concrete = "Concrete",
	Asphalt = "Concrete",
	Brick = "Concrete",
	Grass = "Grass",
	LeafyGrass = "Grass",
	Ground = "Ground",
	Mud = "Ground",
	Sand = "Ground",
	Pebble = "Ground",
	Metal = "Metal",
	CorrodedMetal = "Metal",
	DiamondPlate = "Metal",
	Wood = "Wood",
	WoodPlanks = "Wood"
}

local function PlayTurnSound(p1) --[[ PlayTurnSound | Line: 132 | Upvalues: v11 (ref), v5 (ref), t2 (copy), WalkSounds (copy), v9 (ref) ]]
	if v11 then
		return
	end

	if not v5 then
		return
	end

	local Turn = WalkSounds:FindFirstChild("Turn")

	if not Turn then
		return
	end

	local v2 = Turn:FindFirstChild(t2[p1] or "Default") or Turn:FindFirstChild("Default")

	if not v2 or #v2:GetChildren() == 0 then
		return
	end

	local v3 = v2:GetChildren()
	local v4 = v3[math.random(#v3)]

	if v9 then
		v9.SoundId = v4.SoundId
		v9.PlaybackSpeed = v4.PlaybackSpeed + math.random(-50, 50) / 1000
		v9:Play()
		v11 = true
		task.delay(0.3, function() --[[ Line: 158 | Upvalues: v11 (ref) ]]
			v11 = false
		end)

		return
	end

	v9 = Instance.new("Sound")
	v9.Name = "TurnSound"
	v9.Volume = 0.3
	v9.Parent = v5
	v9.SoundId = v4.SoundId
	v9.PlaybackSpeed = v4.PlaybackSpeed + math.random(-50, 50) / 1000
	v9:Play()
	v11 = true
	task.delay(0.3, function() --[[ Line: 158 | Upvalues: v11 (ref) ]]
		v11 = false
	end)
end

local function SetupSoundsForCharacter(p1) --[[ SetupSoundsForCharacter | Line: 163 | Upvalues: v7 (ref), v6 (ref), v5 (ref), v2 (ref), v3 (ref), v4 (ref) ]]
	v7 = p1
	v6 = p1:WaitForChild("Humanoid", 10)

	if not v6 then
		return
	end

	v5 = p1:WaitForChild("HumanoidRootPart", 10)

	if not v5 then
		return
	end

	local Running = v5:FindFirstChild("Running")

	if Running then
		Running:Destroy()
	end

	v5.ChildAdded:Connect(function(p1) --[[ Line: 177 ]]
		if p1.Name ~= "Running" or not p1:IsA("Sound") then
			return
		end

		p1:Destroy()
	end)

	local FootstepSoundOrigin = v5:WaitForChild("FootstepSoundOrigin", 10)

	if not FootstepSoundOrigin then
		local FootstepSoundOrigin2 = Instance.new("Folder")

		FootstepSoundOrigin2.Name = "FootstepSoundOrigin"
		FootstepSoundOrigin2.Parent = v5

		local LeftFoot = Instance.new("Sound")

		LeftFoot.Name = "LeftFoot"
		LeftFoot.Parent = FootstepSoundOrigin2

		local RightFoot = Instance.new("Sound")

		RightFoot.Name = "RightFoot"
		RightFoot.Parent = FootstepSoundOrigin2
		FootstepSoundOrigin = FootstepSoundOrigin2
	end

	v2 = FootstepSoundOrigin:WaitForChild("LeftFoot", 5)
	v3 = FootstepSoundOrigin:WaitForChild("RightFoot", 5)
	v4 = true
end

LocalPlayer.CharacterAdded:Connect(SetupSoundsForCharacter)

if LocalPlayer.Character then
	task.spawn(function() --[[ Line: 209 | Upvalues: SetupSoundsForCharacter (copy), LocalPlayer (copy) ]]
		SetupSoundsForCharacter(LocalPlayer.Character)
	end)
end

v1:Connect(function(p1, p2, p3) --[[ Line: 214 | Upvalues: Footstep (copy) ]]
	p2.Volume = p3
	Footstep(p1, p2)
end)

if not GameConfig.footstepSounds then
	return
end

RunService.Heartbeat:Connect(function() --[[ Line: 220 | Upvalues: v6 (ref), v5 (ref), v2 (ref), v3 (ref), v10 (ref), PlayTurnSound (copy), v8 (ref), v4 (ref), Footstep (copy), v1 (copy) ]]
	if not (v6 and (v5 and (v2 and v3))) then
		return
	end

	if v6.Health <= 0 then
		return
	end

	if v6.FloorMaterial == Enum.Material.Air or v6.FloorMaterial == Enum.Material.Water then
		return
	end

	local AssemblyLinearVelocity = v5.AssemblyLinearVelocity
	local v12 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z)
	local Magnitude = v12.Magnitude

	if Magnitude > 3 and v10.Magnitude > 0.1 and math.acos((math.clamp(v12.Unit:Dot(v10), -1, 1))) > 0.4 then
		PlayTurnSound(v6.FloorMaterial.Name)
	end

	if Magnitude > 0.5 then
		v10 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Unit
	end

	local v42 = os.clock()

	if not (Magnitude > 1.5 and (v6.WalkSpeed / 2 < Magnitude and v8 <= v42)) then
		return
	end

	local v52 = v4 and v2 or v3

	v4 = not v4
	v52.Volume = 0.4 * (Magnitude / 10)
	Footstep(v6.FloorMaterial, v52, v52.Volume)
	v1:Fire(v6.FloorMaterial, v52, v52.Volume)

	local v62 = 0.5 * (1 / (Magnitude / 10))

	if v62 > 2 then
		v62 = 2
	end

	v8 = v42 + v62
end)