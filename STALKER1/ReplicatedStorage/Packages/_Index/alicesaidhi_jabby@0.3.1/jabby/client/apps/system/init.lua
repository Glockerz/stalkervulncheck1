-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local loop = require(script.Parent.Parent.Parent.modules.loop)
local remotes = require(script.Parent.Parent.Parent.modules.remotes)

require(script.Parent.Parent.Parent.modules.types)

local widget = require(script.widget)
local cleanup = vide.cleanup

return {
	class_name = "app",
	name = "System",
	mount = function(p1, p2) --[[ mount | Line: 26 | Upvalues: vide (copy), loop (copy), remotes (copy), cleanup (copy), RunService (copy), widget (copy) ]]
		local v1 = math.random(2147483647)
		local v2 = vide.source(false)
		local v3 = vide.source(0)
		local v4 = vide.source({})
		local t = {
			watch_id = v1,
			host = p1.host,
			vm = p1.vm,
			scheduler = p1.scheduler,
			system = p1.system,
			name = p1.name,
			changes = vide.source({
				component = {},
				entities = {},
				types = {},
				values = {}
			}),
			recording = v2,
			per_frame_data = v4,
			watching_frame = v3,
			destroy = p2
		}
		local v6 = loop("app-client-system", t, {
			i = 1
		}, script.systems.replicate)
		local t2 = {
			host = t.host,
			to_vm = t.vm
		}

		remotes.create_watch:fire(t2, p1.scheduler, p1.system, v1)
		remotes.connect_watch:fire(t2, v1)
		cleanup(RunService.Heartbeat:Connect(v6))
		cleanup(function() --[[ Line: 71 | Upvalues: remotes (ref), t2 (copy), v1 (copy) ]]
			remotes.disconnect_watch:fire(t2, v1)
			remotes.stop_watch:fire(t2, v1)
			remotes.remove_watch:fire(t2, v1)
		end)

		return widget(t)
	end
}