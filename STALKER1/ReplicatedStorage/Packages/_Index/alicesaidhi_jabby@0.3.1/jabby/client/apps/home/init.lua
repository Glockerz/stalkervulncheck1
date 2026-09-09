-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local loop = require(script.Parent.Parent.Parent.modules.loop)
local widget = require(script.widget)
local cleanup = vide.cleanup

return {
	class_name = "app",
	name = "Home",
	mount = function(p1, p2) --[[ mount | Line: 14 | Upvalues: vide (copy), loop (copy), cleanup (copy), RunService (copy), widget (copy) ]]
		local v1 = vide.source({})

		cleanup(RunService.Heartbeat:Connect((loop("app-client-home", v1, {
			i = 1
		}, script.systems.get_core_data))))

		return widget({
			servers = v1,
			destroy = p2
		})
	end
}