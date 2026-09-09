-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local queue = require(script.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.modules.remotes)
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector)
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check)
local public = require(script.Parent.Parent.public)

return function() --[[ Line: 7 | Upvalues: queue (copy), remotes (copy), reverse_connector (copy), traffic_check (copy), public (copy) ]]
	local t = {}
	local v1 = queue(remotes.bind_to_server_core)

	return function() --[[ Line: 13 | Upvalues: v1 (copy), reverse_connector (ref), traffic_check (ref), t (copy), public (ref), remotes (ref) ]]
		for v12 in v1:iter() do
			local v2 = reverse_connector(v12)

			if traffic_check.check_no_wl(v12.host) then
				table.insert(t, v2)

				local t2 = {}
				local t3 = {}

				for i, v in ipairs(public) do
					if v.class_name == "Scheduler" then
						table.insert(t3, {
							name = v.name,
							id = i
						})

						continue
					end

					if v.class_name == "World" then
						table.insert(t2, {
							name = v.name,
							id = i
						})
					end
				end

				remotes.update_server_data:fire(v2, {
					schedulers = t3,
					worlds = t2
				})
			end
		end

		if public.updated == false then
			return
		end

		public.updated = false

		local t2 = {}
		local t3 = {}

		for i, v in ipairs(public) do
			if v.class_name == "Scheduler" then
				table.insert(t3, {
					name = v.name,
					id = i
				})

				continue
			end

			if v.class_name == "World" then
				table.insert(t2, {
					name = v.name,
					id = i
				})
			end
		end

		local t4 = {}

		for v4, v5 in t do
			if t4[v5] then
				break
			end

			t4[v5] = true
			remotes.update_server_data:fire(v5, {
				schedulers = t3,
				worlds = t2
			})
		end
	end
end