-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local WeldMod = require(script.Parent.WeldMod)
local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets
local Mods = require(SPH_Assets.Mods)
local Arms = SPH_Assets.Arms

return {
	RigModel = function(p1, p2, p3) --[[ Line: 8 | Upvalues: Arms (copy), Mods (copy), WeldMod (copy) ]]
		local v1

		if p2 then
			local v2 = p3.Parent:FindFirstChildWhichIsA("Humanoid")

			v1 = if v2 and (v2.RigType ~= Enum.HumanoidRigType.R15 and Arms:FindFirstChild("R6_Arms")) then Arms.R6_Arms.WeaponRig else Arms.Default.WeaponRig
		else
			v1 = if p1.Neutral or not (p1.Team and Arms:FindFirstChild(p1.Team.Name)) then Arms.Default.WeaponRig else Arms[p1.Team.Name].WeaponRig
		end

		if not p2 and Mods.viewmodelOverride then
			local v3 = Mods.viewmodelOverride(p1, v1)

			if v3 and v3:FindFirstChild("AnimBase") then
				v1 = v3
			end
		end

		local v4 = v1:Clone()
		local AnimBase = v4.AnimBase
		local v5 = v4["Left Arm"]
		local v6 = v4

		for i, v in ipairs(v5:GetChildren()) do
			if v:IsA("BasePart") then
				WeldMod.Weld(v5, v)
				v.CanCollide = false
				v.CanQuery = false
			end
		end

		local v7 = v6["Right Arm"]

		for i, v in ipairs(v7:GetChildren()) do
			if v:IsA("BasePart") then
				WeldMod.Weld(v7, v)
				v.CanCollide = false
				v.CanQuery = false
			end
		end

		WeldMod.M6D(v6.AnimBase, v5).Name = "LeftJoint"
		WeldMod.M6D(v6.AnimBase, v7).Name = "RightJoint"
		AnimBase.Transparency = 1
		AnimBase.CanCollide = false
		AnimBase.CanQuery = false
		AnimBase.CanTouch = false
		AnimBase.CastShadow = false
		v5.CanCollide = false
		v5.CanQuery = false
		v5.CanTouch = false
		v5.CastShadow = true
		v7.CanCollide = false
		v7.CanQuery = false
		v7.CanTouch = false
		v7.CastShadow = true

		if p3 then
			local BaseWeld = WeldMod.BlankWeld(p3, v6.AnimBase)

			BaseWeld.Name = "BaseWeld"
			BaseWeld.Parent = v6
		end

		Instance.new("Folder", v6).Name = "Weapon"

		return v6
	end
}