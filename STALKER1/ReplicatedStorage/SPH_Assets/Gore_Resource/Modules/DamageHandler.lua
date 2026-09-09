-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local SPH_Assets = game.ReplicatedStorage.SPH_Assets
local Gore_Resource = SPH_Assets.Gore_Resource
local GoreHandler = require(Gore_Resource.Modules.GoreHandler)
local GameConfig = require(SPH_Assets.GameConfig)

return {
	ApplyDamage = function(p1, p2, p3) --[[ ApplyDamage | Line: 11 | Upvalues: GameConfig (copy), Gore_Resource (copy), GoreHandler (copy) ]]
		if not GameConfig.gibbing then
			return
		end

		local LimbHealth = p1.Parent:FindFirstChild("LimbHealth")

		if not LimbHealth then
			return
		end

		if p2.Name == "HumanoidRootPart" then
			p2 = p1.Parent:WaitForChild("Torso")
		end

		local v1 = Gore_Resource.Gibs.GunGibs[p2.Name]:GetChildren()
		local v2 = v1[math.random(#v1)][p2.Name]
		local v3 = LimbHealth[p2.Name]

		if v3.Value > 0 then
			v3.Value = math.max(v3.Value - p3 / 1.5, 0)
		end

		if v3.Value ~= 0 then
			return
		end

		p2.Parent:WaitForChild("Torso").Velocity = p1.Parent.Torso.CFrame.LookVector * 18
		GoreHandler.gore(p2, p1.Parent, v2)
	end
}