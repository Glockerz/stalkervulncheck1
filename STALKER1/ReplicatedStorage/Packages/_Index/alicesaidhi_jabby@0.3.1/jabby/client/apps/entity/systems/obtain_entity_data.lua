-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide)
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes)
local effect = vide.effect
local cleanup = vide.cleanup
local batch = vide.batch

return function(p1) --[[ Line: 24 | Upvalues: queue (copy), remotes (copy), effect (copy), cleanup (copy), batch (copy) ]]
	local v1 = queue(remotes.inspect_entity_update)
	local inspect_id = p1.inspect_id
	local t = {
		host = p1.host,
		to_vm = p1.vm
	}

	remotes.inspect_entity:fire(t, p1.id, p1.entity, inspect_id)

	local v2 = false

	effect(function() --[[ Line: 43 | Upvalues: p1 (copy), v2 (ref) ]]
		p1.live_updates()
		v2 = true
	end)
	cleanup(function() --[[ Line: 48 | Upvalues: remotes (ref), t (copy), inspect_id (copy) ]]
		remotes.stop_inspect_entity:fire(t, inspect_id)
	end)

	return function() --[[ Line: 55 | Upvalues: p1 (copy), remotes (ref), t (copy), inspect_id (copy), v2 (ref), batch (ref), v1 (copy) ]]
		if p1.apply_changes() then
			remotes.update_entity:fire(t, inspect_id, p1.changes())
			p1.apply_changes(false)
			p1.changes({})
		end

		if p1.deleting() then
			remotes.delete_entity:fire(t, inspect_id)
		end

		if not v2 then
			batch(function() --[[ Line: 76 | Upvalues: v1 (ref), inspect_id (ref), p1 (ref) ]]
				for v12, v2, v3, v4 in v1:iter() do
					if v2 == inspect_id then
						p1.keys()[v3] = v4
						p1.keys(p1.keys())
					end
				end
			end)

			return
		end

		remotes.update_inspect_settings:fire(t, inspect_id, {
			paused = not p1.live_updates()
		})
		v2 = false
		batch(function() --[[ Line: 76 | Upvalues: v1 (ref), inspect_id (ref), p1 (ref) ]]
			for v12, v2, v3, v4 in v1:iter() do
				if v2 == inspect_id then
					p1.keys()[v3] = v4
					p1.keys(p1.keys())
				end
			end
		end)
	end
end