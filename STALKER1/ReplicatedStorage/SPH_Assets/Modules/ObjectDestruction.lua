-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage.SPH_Assets.GameConfig)
local Destruction = ReplicatedStorage.SPH_Assets.Sounds.Destruction
local t = {}

local function PlaySoundAtLocation(p1, p2) --[[ PlaySoundAtLocation | Line: 6 | Upvalues: Destruction (copy) ]]
	local v1 = Destruction:FindFirstChild(p2)

	if not v1 then
		return
	end

	local TempDestructionSound = Instance.new("Attachment", workspace.Terrain)

	TempDestructionSound.Name = "TempDestructionSound"
	TempDestructionSound.WorldPosition = p1

	local v2 = v1:Clone()

	v2.Parent = TempDestructionSound
	v2:Play()
	task.delay(v2.TimeLength, function() --[[ Line: 17 | Upvalues: TempDestructionSound (copy) ]]
		TempDestructionSound:Destroy()
	end)
end

function t.DestroyObject(p1, p2) --[[ Line: 23 | Upvalues: PlaySoundAtLocation (copy), ReplicatedStorage (copy), GameConfig (copy) ]]
	p1:SetAttribute("Destroyed", true)

	local v1 = p1:GetAttribute("DestructionType")
	local v2 = p1:IsA("Model")
	local v3 = p1:GetAttribute("DestructionSound")

	if v2 then
		for v4, v5 in p1:GetDescendants() do
			if v5:IsA("BasePart") then
				v5.Anchored = false
				v5.CollisionGroup = "Debris"

				for v6, v7 in v5:GetJoints() do
					v7.Enabled = false
				end

				for v8, v9 in v5:GetChildren() do
					if v9:IsA("Constraint") then
						v9.Enabled = false
					end
				end

				if p2 then
					v5:SetNetworkOwner(p2)
				end

				continue
			end

			if v5:IsA("Constraint") or v5:IsA("JointInstance") then
				v5.Enabled = false
			end
		end

		if v3 then
			PlaySoundAtLocation(if p1.PrimaryPart then p1.PrimaryPart.Position else p1.WorldPivot.Position, v3)
		end
	else
		p1.Anchored = false
		p1.CollisionGroup = "Debris"

		for v11, v12 in p1:GetJoints() do
			v12.Enabled = false
		end

		for v13, v14 in p1:GetChildren() do
			if v14:IsA("Constraint") then
				v14.Enabled = false
			end
		end

		if p2 then
			p1:SetNetworkOwner(p2)
		end

		if v3 then
			PlaySoundAtLocation(p1.Position, v3)
		end
	end

	if v1 == "Instant" then
		p1:Destroy()

		return
	end

	if v1 ~= "Explosion" then
		task.delay(GameConfig.destructibleDespawnTime, function() --[[ Line: 99 | Upvalues: p1 (copy) ]]
			p1:Destroy()
		end)

		return
	end

	local v15 = p1:GetAttribute("ExplosionType") or "Default"
	local v16 = p1:IsA("Model") and p1:GetPivot().Position or p1.Position
	local v17 = p1:GetAttribute("ExplosionRadius") or 20
	local ExplosionFX = require(ReplicatedStorage.SPH_Assets.Modules.ExplosionFX)

	p1:Destroy()
	ExplosionFX(v16, v17, v15, p2)
end

return t