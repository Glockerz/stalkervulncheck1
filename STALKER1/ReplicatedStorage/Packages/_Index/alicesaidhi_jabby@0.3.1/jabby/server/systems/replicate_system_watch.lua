-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local jecs = require(script.Parent.Parent.Parent.Parent.jecs)
local hash_connector = require(script.Parent.Parent.Parent.modules.hash_connector)
local lon = require(script.Parent.Parent.Parent.modules.lon)
local queue = require(script.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.modules.remotes)
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector)

require(script.Parent.Parent.Parent.modules.types)

local public = require(script.Parent.Parent.public)
local NIL = require(script.Parent.Parent.watch).NIL

return function() --[[ Line: 33 | Upvalues: remotes (copy), public (copy), jecs (copy), NIL (copy), lon (copy), hash_connector (copy), queue (copy), reverse_connector (copy) ]]
	local t = {}
	local t2 = {}

	local function create_watch_for_id(p1, p2, p3) --[[ create_watch_for_id | Line: 38 | Upvalues: t (copy) ]]
		t[p3] = p1:create_watch_for_system(p2)
	end

	local function send_watch_data_to(p1, p2, p3) --[[ send_watch_data_to | Line: 47 | Upvalues: t (copy), remotes (ref), public (ref), jecs (ref), NIL (ref), lon (ref) ]]
		local t2 = {}
		local v1 = t[p2].watch.frames[p3]

		if not v1 then
			remotes.update_watch_data:fire(p1, p2, p3, nil)

			return
		end

		for i, v in ipairs(public) do
			if v.world ~= nil then
				t2[v.world] = jecs.Name
			end
		end

		local t3 = {
			types = v1.types,
			entities = v1.entities,
			component = table.clone(v1.component),
			values = table.clone(v1.values)
		}

		for v2, v3 in t3.component do
			local v4 = v1.worlds[v2]

			t3.component[v2] = v4:get(v3, t2[v4]) or v3
		end

		for v5, v6 in t3.values do
			if v6 == NIL then
				t3.values[v5] = ""
			end

			t3.values[v5] = lon.output(v6, false)
		end

		remotes.update_watch_data:fire(p1, p2, p3, t3)
	end

	local function remove_watch_id(p1) --[[ remove_watch_id | Line: 83 | Upvalues: t (copy), t2 (copy) ]]
		if t[p1] then
			t[p1].untrack()
			t[p1] = nil
			t2[p1] = nil
		end
	end

	local function start_record_watch(p1) --[[ start_record_watch | Line: 90 | Upvalues: t (copy) ]]
		t[p1].active = true
	end

	local function stop_record_watch(p1) --[[ stop_record_watch | Line: 95 | Upvalues: t (copy) ]]
		t[p1].active = false
	end

	local function connect_watch(p1, p2) --[[ connect_watch | Line: 100 | Upvalues: t2 (copy), hash_connector (ref), t (copy), remotes (ref) ]]
		t2[p2] = t2[p2] or {}
		t2[p2][hash_connector(p1)] = p1

		for v3, v4 in t[p2].watch.frames do
			remotes.update_overview:fire(p1, p2, v3, #v4.types)
		end
	end

	local function disconnect_watch(p1, p2) --[[ disconnect_watch | Line: 110 | Upvalues: t2 (copy), hash_connector (ref) ]]
		if t2[p2] then
			t2[p2][hash_connector(p1)] = nil
		end
	end

	local v1 = queue(remotes.create_watch)
	local v2 = queue(remotes.remove_watch)
	local v3 = queue(remotes.request_watch_data)
	local v4 = queue(remotes.stop_watch)
	local v5 = queue(remotes.start_record_watch)
	local v6 = queue(remotes.connect_watch)
	local v7 = queue(remotes.disconnect_watch)

	return function() --[[ Line: 124 | Upvalues: v1 (copy), public (ref), t (copy), v4 (copy), v2 (copy), t2 (copy), v3 (copy), send_watch_data_to (copy), reverse_connector (ref), v5 (copy), v6 (copy), connect_watch (copy), v7 (copy), hash_connector (ref), remotes (ref) ]]
		for v12, v22, v32, v42 in v1:iter() do
			local v52 = public[v22]

			if v52.class_name == "Scheduler" and v52 ~= nil then
				t[v42] = v52:create_watch_for_system(v32)
			end
		end

		for v62, v72 in v4:iter() do
			t[v72].active = false
		end

		for v8, v9 in v2:iter() do
			if t[v9] then
				t[v9].untrack()
				t[v9] = nil
				t2[v9] = nil
			end
		end

		for v10, v11, v12 in v3:iter() do
			send_watch_data_to(reverse_connector(v10), v11, v12)
		end

		for v13, v14 in v5:iter() do
			t[v14].active = true
		end

		for v15, v16 in v6:iter() do
			connect_watch(reverse_connector(v15), v16)
		end

		for v17, v18 in v7:iter() do
			if t2[v18] then
				t2[v18][hash_connector(v17)] = nil
			end
		end

		for v19, v20 in t2 do
			local v21 = t[v19]
			local frame = v21.watch.frame
			local v23 = #(v21.watch.frames[frame] or {
				types = {}
			}).types

			for v24, v25 in v20 do
				remotes.update_overview:fire(v25, v19, frame, v23)
			end
		end
	end
end