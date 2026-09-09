-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local hash_connector = require(script.Parent.Parent.Parent.modules.hash_connector)
local queue = require(script.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.modules.remotes)
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector)
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check)

require(script.Parent.Parent.Parent.modules.types)

local public = require(script.Parent.Parent.public)

return function() --[[ Line: 10 | Upvalues: queue (copy), remotes (copy), traffic_check (copy), public (copy), reverse_connector (copy), hash_connector (copy) ]]
	local t = {}
	local v1 = queue(remotes.request_scheduler)
	local v2 = queue(remotes.disconnect_scheduler)
	local v3 = queue(remotes.scheduler_system_pause)

	return function() --[[ Line: 18 | Upvalues: v1 (copy), traffic_check (ref), public (ref), reverse_connector (ref), t (copy), remotes (ref), v2 (copy), v3 (copy), hash_connector (ref) ]]
		for v12, v22 in v1:iter() do
			if traffic_check.check_no_wl(v12.host) then
				local v32 = public[v22]

				if v32.class_name == "Scheduler" and v32 ~= nil then
					local v4 = reverse_connector(v12)

					t[v22] = t[v22] or {}
					table.insert(t[v22], v4)

					for v8, v9 in v32.system_data do
						remotes.scheduler_system_static_update:fire(v4, v22, v8, v9)
					end

					for v10, v11 in v32.system_frames do
						local v122 = v11[1]

						if v122 then
							remotes.scheduler_system_update:fire(v4, v22, v10, v122.i, v122.s)
						end
					end
				end
			end
		end

		for v13, v14 in v2:iter() do
			if traffic_check.check_no_wl(v13.host) and t[v14] then
				local v15 = t[v14]

				for i = #v15, 1, -1 do
					local v16 = v15[i]

					if v16.host == v13.host and v16.to_vm == v13.from_vm then
						v15[i] = v15[#v15]
						v15[#v15] = nil

						break
					end
				end
			end
		end

		for v17, v18, v19, v20 in v3:iter() do
			if traffic_check.check_no_wl(v17.host) then
				local v21 = public[v18]

				if not v21 then
					return
				end

				v21:set_system_data(v19, {
					paused = v20
				})
			end
		end

		for v22, v23 in t do
			local v24 = public[v22]

			if #v23 ~= 0 then
				for v25 in v24.system_data_updated do
					local v26 = v24.system_data[v25]
					local t2 = {}

					for v27, v28 in v23 do
						if not t2[hash_connector(v28)] then
							t2[hash_connector(v28)] = true
							remotes.scheduler_system_static_update:fire(v28, v22, v25, v26)
						end
					end

					v24.system_data_updated[v25] = nil
				end

				for v29, v30 in v24.system_frames_updated do
					local t2 = {}

					for v31 in v30 do
						for v32, v33 in v23 do
							if not t2[hash_connector(v33)] then
								t2[hash_connector(v33)] = true
								remotes.scheduler_system_update:fire(v33, v22, v29, v31.i, v31.s)
							end
						end
					end

					table.clear(v30)
				end
			end
		end
	end
end