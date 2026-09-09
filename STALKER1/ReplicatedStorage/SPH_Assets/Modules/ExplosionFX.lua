-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")

game:GetService("Players")

local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig)
local v1 = OverlapParams.new()

v1.MaxParts = 500
v1.RespectCanCollide = true

local v2 = RaycastParams.new()

v2.IgnoreWater = true
v2.RespectCanCollide = true

local t = { 287390459, 287390954, 287391087, 287391197, 287391361, 287391499, 287391567, 8226406520 }
local DamageHandler = require(game.ReplicatedStorage.SPH_Assets:WaitForChild("Gore_Resource").Modules.DamageHandler)

return function(p1, p2, p3) --[[ Explode | Line: 22 | Upvalues: Debris (copy), t (copy), v1 (copy), v2 (copy), GameConfig (copy), DamageHandler (copy) ]]
	local v12 = script:FindFirstChild(p3)

	if not v12 then
		return
	end

	local v22 = v12:GetChildren()
	local Explosion = Instance.new("Attachment", workspace.Terrain)

	Explosion.Name = "Explosion"
	Explosion.WorldPosition = p1

	local v3 = 10

	for i, v in ipairs(v22) do
		local v4 = v:Clone()

		v4.Parent = Explosion

		if v4:IsA("ParticleEmitter") then
			if v4:FindFirstChild("Count") then
				v4:Emit(v4.Count.Value)
			else
				v4:Emit(1)
			end

			if v3 < v4.Lifetime.Max then
				v3 = v4.Lifetime.Max
			end

			continue
		end

		if v4:IsA("Light") then
			v4.Enabled = true
			Debris:AddItem(v4, 0.1)
		end
	end

	local Sound = Instance.new("Sound", Explosion)

	Sound.SoundId = "rbxassetid://" .. t[math.random(#t)]
	Sound.Volume = 4
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.RollOffMaxDistance = 10000
	Sound.PlayOnRemove = true
	Sound:Destroy()

	local t2 = {}

	for i, v in ipairs((workspace:GetPartBoundsInRadius(p1, p2 * 2, v1))) do
		local Humanoid = v.Parent:FindFirstChild("Humanoid")
		local HumanoidRootPart = v.Parent:FindFirstChild("HumanoidRootPart")

		if HumanoidRootPart and (Humanoid and not table.find(t2, Humanoid)) then
			local v6 = workspace:Raycast(p1 + Vector3.new(0, 1, 0), (HumanoidRootPart.Position - p1).Unit * p2, v2)

			if not GameConfig.explosionRaycast or v6 and (v6.Instance and v6.Instance:IsDescendantOf(Humanoid.Parent)) then
				table.insert(t2, Humanoid)

				local Magnitude = (p1 - v.Position).Magnitude

				Humanoid:TakeDamage(p2 / 1.5 / Magnitude * 100)

				local LimbHealth = Humanoid.Parent:FindFirstChild("LimbHealth")

				if LimbHealth then
					task.spawn(function() --[[ Line: 75 | Upvalues: p2 (copy), Magnitude (copy), LimbHealth (copy), DamageHandler (ref), Humanoid (copy) ]]
						local v2 = math.floor(p2 / 1.5 / Magnitude * 100)

						for i, v in ipairs(LimbHealth:GetChildren()) do
							local v3 = math.random(0, v2)

							DamageHandler.ApplyDamage(Humanoid, Humanoid.Parent:FindFirstChild(v.Name), v3)
						end
					end)
				end
			end
		end

		if not v.Anchored then
			local ExplosionForce = Instance.new("Attachment", v)

			ExplosionForce.Name = "ExplosionForce"

			local VectorForce = Instance.new("VectorForce", ExplosionForce)

			VectorForce.Attachment0 = ExplosionForce
			VectorForce.Force = (p1 - v.Position).Unit * -2000
			Debris:AddItem(ExplosionForce, 0.1)
		end
	end

	Debris:AddItem(Explosion, v3)
end