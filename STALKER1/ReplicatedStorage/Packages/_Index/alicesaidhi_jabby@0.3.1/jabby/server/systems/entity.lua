-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local jecs = require(script.Parent.Parent.Parent.Parent.jecs)
local lon = require(script.Parent.Parent.Parent.modules.lon)
local queue = require(script.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.modules.remotes)
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector)
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check)

require(script.Parent.Parent.Parent.modules.types)

local public = require(script.Parent.Parent.public)
local query_parser = require(script.Parent.Parent.query_parser)
local entity_index_try_get = jecs.entity_index_try_get
local IS_PAIR = jecs.IS_PAIR
local pair = jecs.pair
local pair_first = jecs.pair_first
local pair_second = jecs.pair_second
local t = {}

local function get_all_components(p1, p2) --[[ get_all_components | Line: 18 | Upvalues: entity_index_try_get (copy), t (copy) ]]
	local v1 = entity_index_try_get(p1.entity_index, p2)

	if not v1 then
		return t
	end

	local archetype = v1.archetype

	if not archetype then
		return t
	end

	local t2 = {}

	for v2, v3 in archetype.types do
		table.insert(t2, v3)
	end

	return t2
end

local function v1(p1, p2, p3) --[[ convert_component | Line: 32 | Upvalues: IS_PAIR (copy), v1 (copy), pair_first (copy), pair_second (copy) ]]
	if IS_PAIR(p3) then
		return ("(%*, %*)"):format(v1(p1, p2, pair_first(p1, p3)), (v1(p1, p2, pair_second(p1, p3))))
	end

	return p1:get(p3, p2) or ("$%*"):format((tostring(p3)))
end

local v2 = newproxy()
local v3 = newproxy()

local function get_component(p1, p2) --[[ get_component | Line: 47 | Upvalues: query_parser (copy), jecs (copy), pair (copy) ]]
	local function get_entity(p1) --[[ get_entity | Line: 49 | Upvalues: p2 (copy) ]]
		local value = p1.value

		if value.type == "Entity" then
			return value.entity
		end

		if value.type == "Name" then
			return p2[value.name]
		end

		error("bad")
	end

	local v1 = nil
	local v2 = query_parser(p1)[1]

	if v2.type == "Component" then
		local value = v2.value

		if value.type == "Entity" then
			return value.entity
		end

		if value.type == "Name" then
			return p2[value.name]
		end

		error("bad")
	end

	if v2.type == "Relationship" then
		local Wildcard = jecs.Wildcard
		local Wildcard2 = jecs.Wildcard

		if v2.left.type == "Component" then
			local value = v2.left.value

			if value.type == "Entity" then
				Wildcard = value.entity
			elseif value.type == "Name" then
				Wildcard = p2[value.name]
			else
				error("bad")
			end
		end

		if v2.right.type == "Component" then
			local value = v2.right.value

			if value.type == "Entity" then
				Wildcard2 = value.entity
			elseif value.type == "Name" then
				Wildcard2 = p2[value.name]
			else
				error("bad")
			end
		end

		v1 = pair(Wildcard, Wildcard2)
	end

	return v1
end

return function() --[[ Line: 81 | Upvalues: queue (copy), remotes (copy), public (copy), reverse_connector (copy), traffic_check (copy), jecs (copy), get_component (copy), lon (copy), v2 (copy), get_all_components (copy), v1 (copy), v3 (copy) ]]
	local v12 = queue(remotes.inspect_entity)
	local v22 = queue(remotes.update_inspect_settings)
	local v32 = queue(remotes.stop_inspect_entity)
	local v4 = queue(remotes.update_entity)
	local v5 = queue(remotes.delete_entity)
	local v6 = queue(remotes.get_component)
	local v7 = queue(remotes.validate_entity_component)
	local t = {}

	return function() --[[ Line: 94 | Upvalues: v7 (copy), public (ref), reverse_connector (ref), traffic_check (ref), jecs (ref), get_component (ref), remotes (ref), v12 (copy), t (copy), v32 (copy), v5 (copy), v22 (copy), v6 (copy), lon (ref), v4 (copy), v2 (ref), get_all_components (ref), v1 (ref), v3 (ref) ]]
		for v62, v72, v8 in v7:iter() do
			local v13, v23, v33, v42, v52
			local v9 = public[v72]
			local v10 = reverse_connector(v62)

			if traffic_check.check_no_wl(v62.host) and (v9 and v9.class_name == "World") then
				local t2 = {}

				for v11, v122 in v9.world:query(jecs.Name):iter() do
					t2[v122] = v11
				end

				local ok, result = pcall(get_component, v8, t2)

				if ok or not result then
					v13 = v10
					v23 = v72
					v33 = v8
					v42 = ok
					v52 = nil
				else
					v13 = v10
					v23 = v72
					v33 = v8
					v42 = ok
					v52 = result
				end

				remotes.validate_entity_component_result:fire(v13, v23, v33, v42, v52)
			end
		end

		for v132, v14, v15, v16 in v12:iter() do
			local v17 = public[v14]
			local v18 = reverse_connector(v132)

			if traffic_check.check_no_wl(v132.host) and (v17 and v17.class_name == "World") then
				t[v16] = {
					paused = false,
					outgoing = v18,
					world = v17,
					entity = v15,
					new_values = {},
					old_values = {}
				}
			end
		end

		for v19, v20 in v32:iter() do
			if traffic_check.check_no_wl(v19.host) then
				t[v20] = nil
			end
		end

		for v21, v222 in v5:iter() do
			if traffic_check.check_no_wl(v21.host) then
				local v232 = t[v222]

				v232.world.world:delete(v232.entity)
			end
		end

		for v24, v25, v26 in v22:iter() do
			if traffic_check.check_no_wl(v24.host) then
				local v27 = t[v25]

				if v27 then
					v27.paused = v26.paused
				end
			end
		end

		for v28, v29, v30 in v6:iter() do
			if traffic_check.check_no_wl(v28.host) then
				local v31 = t[v29]
				local world = v31.world.world
				local entity = v31.entity
				local v322 = reverse_connector(v28)
				local t2 = {}

				for v332, v34 in world:query(jecs.Name):iter() do
					t2[v34] = v332
				end

				local ok, result = pcall(get_component, v30, t2)

				if result and ok then
					remotes.return_component:fire(v322, v29, result, lon.output(world:get(entity, result), true, false))

					continue
				end

				remotes.return_component:fire(v322, v29, result, "nil")
			end
		end

		for v35, v36, v37 in v4:iter() do
			if traffic_check.check_no_wl(v35.host) then
				local v38 = t[v36]
				local world = v38.world.world
				local entity = v38.entity
				local t2 = {}

				for v39, v40 in world:query(jecs.Name):iter() do
					t2[v40] = v39
				end

				for v41, v422 in v37 do
					local ok, result = pcall(get_component, v41, t2)
					local v43 = world:get(entity, result)

					if ok then
						local ok2, result2 = pcall(lon.parse, v422)

						if ok2 then
							local ok3, result3 = pcall(lon.compile, result2, {
								tag = v2,
								old = v43
							})

							if ok3 then
								if result3 == nil then
									world:remove(entity, result)

									continue
								end

								if result3 == v2 then
									world:add(entity, result)

									continue
								end

								world:set(entity, result, result3)

								continue
							end

							warn("attempted to set", v41, "to", v422)
							warn(result3)

							continue
						end

						warn("attempted to set", v41, "to", v422)
						warn(result2)

						continue
					end

					warn("attempted to set", v41, "to", v422)
					warn(result)
				end
			end
		end

		for v44, v45 in t do
			local world = v45.world.world
			local entity = v45.entity

			if not v45.paused and world:contains(entity) ~= false then
				local new_values = v45.new_values
				local old_values = v45.old_values
				local v46 = get_all_components(world, entity)

				local function is_tag(p1) --[[ is_tag | Line: 245 | Upvalues: jecs (ref), world (copy) ]]
					return jecs.is_tag(world, p1)
				end

				for v47, v48 in v46 do
					local v49 = v1(world, jecs.Name, v48)

					if jecs.is_tag(world, v48) then
						new_values[v49] = v2

						continue
					end

					local v50 = world:get(entity, v48)

					new_values[v49] = if v50 == nil then v3 else v50
				end

				for v522, v53 in new_values do
					if old_values[v522] ~= v53 or typeof(v53) == "table" then
						remotes.inspect_entity_update:fire(v45.outgoing, v44, v522, if v53 == v2 then "tag" elseif v53 == v3 then "nil (not allowed)" else lon.output(v53, true, true))
					end
				end

				for v55, v56 in old_values do
					if new_values[v55] == nil then
						remotes.inspect_entity_update:fire(v45.outgoing, v44, v55, nil)
					end
				end

				table.clear(old_values)
				v45.new_values = old_values
				v45.old_values = new_values
			end
		end
	end
end