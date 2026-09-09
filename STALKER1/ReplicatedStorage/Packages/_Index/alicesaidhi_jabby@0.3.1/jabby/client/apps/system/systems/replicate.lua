-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide)
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes)

require(script.Parent.Parent.Parent.Parent.Parent.modules.types)

local batch = vide.batch

return function(p1) --[[ Line: 23 | Upvalues: vide (copy), queue (copy), remotes (copy), batch (copy) ]]
	local watch_id = p1.watch_id
	local t = {
		host = p1.host,
		to_vm = p1.vm
	}
	local v1 = false
	local v2 = false

	vide.effect(function() --[[ Line: 34 | Upvalues: v1 (ref), v2 (ref), p1 (copy) ]]
		v1 = true
		v2 = p1.recording()
	end)

	local v3 = false
	local v4 = 1

	vide.effect(function() --[[ Line: 41 | Upvalues: v3 (ref), v4 (ref), p1 (copy) ]]
		v3 = true
		v4 = p1.watching_frame()
	end)

	local v5 = queue(remotes.update_watch_data)
	local v6 = queue(remotes.update_overview)

	return function() --[[ Line: 49 | Upvalues: v1 (ref), v2 (ref), remotes (ref), t (copy), watch_id (copy), v3 (ref), v4 (ref), batch (ref), v5 (copy), p1 (copy), v6 (copy) ]]
		if v1 and v2 then
			remotes.start_record_watch:fire(t, watch_id)
			v1 = false
		elseif v1 and not v2 then
			remotes.stop_watch:fire(t, watch_id)
			v1 = false
		end

		if v3 then
			remotes.request_watch_data:fire(t, watch_id, v4)
			v3 = false
		end

		debug.profilebegin("receive update data")
		batch(function() --[[ Line: 65 | Upvalues: v5 (ref), watch_id (ref), v4 (ref), p1 (ref) ]]
			for v1, v2, v3, v42 in v5:iter() do
				if v2 == watch_id and v3 == v4 then
					if v42 == nil then
						p1.changes({
							types = {},
							entities = {},
							component = {},
							values = {},
							worlds = {}
						})

						continue
					end

					p1.changes(v42)
				end
			end
		end)
		debug.profileend()
		debug.profilebegin("receive overview")
		batch(function() --[[ Line: 85 | Upvalues: v6 (ref), watch_id (ref), p1 (ref) ]]
			for v1, v2, v3, v4 in v6:iter() do
				if v2 == watch_id then
					local v5 = p1.per_frame_data()

					if v5[v3] ~= v4 then
						v5[v3] = v4
						p1.per_frame_data(v5)
					end
				end
			end
		end)
		debug.profileend()
	end
end