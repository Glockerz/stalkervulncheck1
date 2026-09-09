-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets
local GameConfig = require(SPH_Assets.GameConfig)
local Ammo = SPH_Assets.Ammo
local Shells = workspace:WaitForChild("SPH_Workspace"):FindFirstChild("Shells")
local t = {}

return {
	ejectShell = function(p1, p2, p3) --[[ Line: 12 | Upvalues: Ammo (copy), GameConfig (copy), Debris (copy), t (copy), Shells (copy) ]]
		local WeaponStats = require(p2.SPH_Weapon.WeaponStats)

		if not (p2 and (p3 and p3:FindFirstChild("Grip"))) then
			return
		end

		local Chamber = p3.Grip:FindFirstChild("Chamber")

		if not Chamber then
			warn(p2.Name .. " does not have a chamber! Add an attachment named \'Chamber\' to the gun\'s grip to resolve this issue.")

			return
		end

		local WorldCFrame = Chamber.WorldCFrame
		local v1 = p1:DistanceFromCharacter(WorldCFrame.Position)
		local v2 = Ammo:FindFirstChild(WeaponStats.ammoType) or Ammo.Default

		if not (v1 <= GameConfig.shellDistance) then
			return
		end

		local v3 = v2.Casing:Clone()

		v3.Anchored = false
		v3.CFrame = WorldCFrame
		v3.Name = p1.Name .. "_Casing_" .. p2.Name
		v3.CastShadow = false
		v3.CollisionGroup = "Casings"
		v3.CollisionGroup = "Casings"
		v3.Transparency = 1
		task.delay(0.01, function() --[[ Line: 31 | Upvalues: v3 (copy) ]]
			v3.Transparency = 0
		end)

		local v4 = v3.ForcePoint or Instance.new("Attachment", v3)
		local VectorForce = Instance.new("VectorForce", v3)

		VectorForce.Visible = false
		VectorForce.Force = WeaponStats.calcEjectionForce()
		VectorForce.Attachment0 = v4
		Debris:AddItem(v4, 0.001)
		table.insert(t, v3)

		if #t > GameConfig.shellMaxCount then
			table.remove(t, 1)
		end

		Debris:AddItem(v3, GameConfig.shellDespawn)
		v3.Parent = Shells

		local v6 = nil

		v6 = v3.Touched:Connect(function(p12) --[[ Line: 55 | Upvalues: v3 (copy), p1 (copy), p3 (copy), Debris (ref), v6 (ref) ]]
			if not (v3.AssemblyLinearVelocity.Magnitude > 20) or (p12:IsDescendantOf(p1.Character) or (p12:IsDescendantOf(p3) or not p12.CanCollide)) then
				return
			end

			local v1 = v3.Drop:Clone()

			v1.Parent = v3
			v1.PlaybackSpeed = math.random(30, 50) / 40
			v1:Play()
			v1.PlayOnRemove = true
			v1:Destroy()
			Debris:AddItem(v1, 2)
			v6:Disconnect()
		end)
	end
}