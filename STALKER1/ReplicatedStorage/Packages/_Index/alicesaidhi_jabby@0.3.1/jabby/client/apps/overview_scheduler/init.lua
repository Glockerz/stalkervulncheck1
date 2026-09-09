-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local loop = require(script.Parent.Parent.Parent.modules.loop)
local remotes = require(script.Parent.Parent.Parent.modules.remotes)
local widget = require(script.widget)
local source = vide.source
local cleanup = vide.cleanup

return {
	class_name = "app",
	name = "Scheduler",
	mount = function(p1, p2) --[[ mount | Line: 22 | Upvalues: source (copy), loop (copy), cleanup (copy), RunService (copy), widget (copy), remotes (copy) ]]
		local v1 = source({})
		local v2 = source({})
		local v3 = source({})

		cleanup(RunService.Heartbeat:Connect((loop("app-client-scheduler", {
			host = p1.host,
			vm = p1.vm,
			id = p1.id,
			system_ids = v3,
			system_data = v1,
			system_frames = v2
		}, {
			i = 1
		}, script.systems.get_scheduler_data))))

		return widget({
			host = p1.host,
			vm = p1.vm,
			id = p1.id,
			system_ids = v3,
			system_data = v1,
			system_frames = v2,
			pause_system = function(p12) --[[ pause_system | Line: 56 | Upvalues: remotes (ref), p1 (copy), v1 (copy) ]]
				remotes.scheduler_system_pause:fire({
					host = p1.host,
					to_vm = p1.vm
				}, p1.id, p12, not v1()[p12].paused)
			end,
			destroy = p2
		})
	end
}