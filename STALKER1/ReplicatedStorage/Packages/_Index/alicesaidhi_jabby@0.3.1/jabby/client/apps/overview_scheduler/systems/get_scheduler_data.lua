-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide)
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes)

require(script.Parent.Parent.Parent.Parent.Parent.modules.types)

local batch = vide.batch
local cleanup = vide.cleanup

return function(p1) --[[ Line: 25 | Upvalues: remotes (copy), queue (copy), cleanup (copy), batch (copy) ]]
	local t = {
		host = p1.host,
		to_vm = p1.vm
	}

	remotes.request_scheduler:fire(t, p1.id)

	local v1 = queue(remotes.scheduler_system_static_update)
	local v2 = queue(remotes.scheduler_system_update)

	cleanup(function() --[[ Line: 36 | Upvalues: remotes (ref), t (copy), p1 (copy) ]]
		remotes.disconnect_scheduler:fire(t, p1.id)
	end)

	return function() --[[ Line: 40 | Upvalues: batch (ref), v1 (copy), p1 (copy), v2 (copy) ]]
		batch(function() --[[ Line: 42 | Upvalues: v1 (ref), p1 (ref), v2 (ref) ]]
			for v12, v22, v3, v4 in v1:iter() do
				if v12.host == p1.host and (v12.from_vm == p1.vm and v22 == p1.id) then
					if v4 == nil then
						p1.system_ids()[v3] = nil
						p1.system_data()[v3] = nil
						p1.system_frames()[v3] = nil
						p1.system_ids(p1.system_ids())
						p1.system_data(p1.system_data())
						p1.system_frames(p1.system_frames())

						continue
					end

					p1.system_ids()[v3] = true
					p1.system_data()[v3] = v4
					p1.system_frames()[v3] = p1.system_frames()[v3] or {}
					p1.system_ids(p1.system_ids())
					p1.system_data(p1.system_data())
					p1.system_frames(p1.system_frames())
				end
			end

			for v7, v8, v9, v10, v11 in v2:iter() do
				if v7.host == p1.host and (v7.from_vm == p1.vm and (v8 == p1.id and p1.system_frames()[v9] ~= nil)) then
					local v12 = p1.system_frames()[v9]
					local t = {
						i = v10,
						s = v11
					}
					local v13 = false

					for v14, v15 in v12 do
						if v15.i == v10 then
							v12[v14] = t

							continue
						end

						if not (v10 < v15.i) then
							table.insert(v12, v14, t)
							table.remove(v12, 51)
							v13 = true

							break
						end
					end

					if #v12 <= 50 and v13 == false then
						table.insert(v12, t)
					end

					p1.system_frames(p1.system_frames())
				end
			end
		end)
	end
end