-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local jecs = require(script.Parent.Parent.Parent.Parent.jecs)
local queue = require(script.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.modules.remotes)
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector)
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check)

require(script.Parent.Parent.Parent.modules.types)

local public = require(script.Parent.Parent.public)
local query_parser = require(script.Parent.Parent.query_parser)
local v1 = newproxy()

local function clear_columns(p1) --[[ clear_columns | Line: 35 ]]
	for v1, v2 in p1 do
		local v3 = v2[1]

		table.clear(v2)
		v2[1] = v3
		assert(v2[1] == v3)
	end

	return p1
end

local function reverse_columns(p1, p2) --[[ reverse_columns | Line: 45 ]]
	for v1, v2 in p1 do
		for i = 0, p2 // 2 - 1 do
			local v4 = v2[i + 2]

			v2[i + 2] = v2[p2 + 1 - i]
			v2[p2 + 1 - i] = v4
		end
	end

	return p1
end

return function() --[[ Line: 54 | Upvalues: queue (copy), remotes (copy), query_parser (copy), jecs (copy), traffic_check (copy), public (copy), reverse_connector (copy), v1 (copy), clear_columns (copy) ]]
	local t = {}
	local v12 = queue(remotes.validate_query)
	local v2 = queue(remotes.request_query)
	local v3 = queue(remotes.disconnect_query)
	local v4 = queue(remotes.advance_query_page)
	local v5 = queue(remotes.pause_query)
	local v6 = queue(remotes.refresh_results)

	local function check_if_query_valid(p1, p2) --[[ check_if_query_valid | Line: 65 | Upvalues: query_parser (ref), jecs (ref) ]]
		local t = {}
		local ok, result = pcall(query_parser, p2)

		if not ok then
			return ok, result
		end

		for v1, v2 in p1.world:query(jecs.Name):iter() do
			t[v2] = v1
		end

		local count = 0

		for v3, v4 in result do
			if not ok then
				break
			end

			if v4.query and not v4.exclude then
				count = count + 1
			end

			if v4.type == "Component" then
				if v4.value.type == "Entity" then
					if not p1.world:contains(v4.value.entity) then
						return false, "entity does not exist"
					end

					continue
				end

				if v4.value.type ~= "Name" then
					return false, "what"
				end

				if not t[v4.value.name] then
					return false, ("unknown component called %*"):format(v4.value.name)
				end

				continue
			end

			if v4.type == "Relationship" then
				if if v4.left.type == "Wildcard" then if v4.right.type == "Wildcard" then true else false else false then
					return false, "(*, *) is not a valid relationship"
				end

				local left = v4.left
				local right = v4.right

				if left.type == "Component" then
					if left.value.type == "Entity" then
						if not p1.world:contains(left.value.entity) then
							return false, "entity does not exist"
						end

						continue
					end

					if left.value.type ~= "Name" then
						return false, "what"
					end

					if not t[left.value.name] then
						return false, ("unknown component called %*"):format(left.value.name)
					end

					continue
				end

				if right.type == "Component" then
					if right.value.type == "Entity" then
						if not p1.world:contains(right.value.entity) then
							return false, "entity does not exist"
						end

						continue
					end

					if right.value.type ~= "Name" then
						return false, "what"
					end

					if not t[right.value.name] then
						return false, ("unknown component called %*"):format(right.value.name)
					end
				end
			end
		end

		if count > 26 then
			warn("attempting to observe too many values")

			return false, "attempting to observe too many entities"
		end

		return ok, nil
	end

	local function check_if_still_valid(p1, p2) --[[ check_if_still_valid | Line: 141 | Upvalues: jecs (ref) ]]
		for v1, v2 in p2 do
			if jecs.IS_PAIR(v2) then
				if not p1:contains(jecs.pair_first(p1, v2) and jecs.pair_second(p1, v2)) then
					return false
				end

				continue
			end

			if not p1:contains(v2) then
				return false
			end
		end

		return true
	end

	local function get_terms(p1, p2) --[[ get_terms | Line: 154 | Upvalues: query_parser (ref), jecs (ref) ]]
		local v1 = query_parser(p1)
		local t = {}
		local t2 = {}
		local t3 = {}
		local t4 = {}
		local t5 = {}

		for v2, v3 in p2:query(jecs.Name):iter() do
			t[v3] = v2
		end

		local function get_entity(p1) --[[ get_entity | Line: 166 | Upvalues: t (copy) ]]
			local value = p1.value

			if value.type == "Entity" then
				return value.entity
			end

			if value.type == "Name" then
				return t[value.name]
			end

			error("bad")
		end

		for v5, v6 in v1 do
			local v4

			if v6.type == "Component" then
				local value = v6.value

				if value.type == "Entity" then
					v4 = value.entity
				elseif value.type == "Name" then
					v4 = t[value.name]
				else
					error("bad")
				end

				t2[v6] = v4

				continue
			end

			if v6.type == "Relationship" then
				local Wildcard = jecs.Wildcard
				local Wildcard2 = jecs.Wildcard

				if v6.left.type == "Component" then
					local value = v6.left.value

					if value.type == "Entity" then
						Wildcard = value.entity
					elseif value.type == "Name" then
						Wildcard = t[value.name]
					else
						error("bad")
					end
				end

				if v6.right.type == "Component" then
					local value = v6.right.value

					if value.type == "Entity" then
						Wildcard2 = value.entity
					elseif value.type == "Name" then
						Wildcard2 = t[value.name]
					else
						error("bad")
					end
				end

				t2[v6] = jecs.pair(Wildcard, Wildcard2)
			end
		end

		for v7, v8 in v1 do
			local v9 = t2[v8]

			if v8.exclude then
				table.insert(t3, v9)

				continue
			end

			if v8.query then
				table.insert(t4, v9)

				continue
			end

			table.insert(t5, v9)
		end

		return t4, t3, t5
	end

	return function() --[[ Line: 211 | Upvalues: v12 (copy), traffic_check (ref), public (ref), reverse_connector (ref), remotes (ref), check_if_query_valid (copy), get_terms (copy), v3 (copy), t (copy), v2 (copy), v6 (copy), v5 (copy), v4 (copy), jecs (ref), check_if_still_valid (copy), v1 (ref), clear_columns (ref) ]]
		for v42, v52, v62 in v12:iter() do
			local v13, v22, v32

			if traffic_check.check_no_wl(v42.host) then
				local v7 = public[v52]
				local v8 = reverse_connector(v42)

				if v7 and v7.class_name == "World" then
					local v9, v10 = check_if_query_valid(v7, v62)

					if v9 then
						local v11, v122, v132 = get_terms(v62, v7.world)

						v13 = v11
						v22 = v122
						v32 = v132
					else
						v13 = nil
						v22 = nil
						v32 = nil
					end

					remotes.validate_result:fire(v8, v52, v62, if v9 then {
	include = v13,
	exclude = v22,
	with = v32
} else v9, v9, v10)

					continue
				end

				remotes.validate_result:fire(v8, v52, v62, nil, false, "world does not exist")
			end
		end

		for v15, v16 in v3:iter() do
			t[v16] = nil
		end

		for v17, v18, v19, v20 in v2:iter() do
			if traffic_check.check_no_wl(v17.host) then
				local v21 = public[v18]
				local v222 = reverse_connector(v17)

				if v21 and (v21.class_name == "World" and check_if_query_valid(v21, v20)) then
					local v23, v24, v25 = get_terms(v20, v21.world)
					local t2 = {}
					local t3 = {}

					table.insert(t2, {})
					table.insert(t3, {})

					for v26, v27 in v23 do
						table.insert(t2, {})
						table.insert(t3, {})
					end

					if t[v19] then
						local v28 = t[v19]

						v28.outgoing = v222
						v28.query_id = v19
						v28.world = v21
						v28.refresh = true
						v28.include = v23
						v28.exclude = v24
						v28.with = v25
						v28.new_columns = t2
						v28.old_columns = t3
						v28.from = 1
						v28.upto = 25

						continue
					end

					t[v19] = {
						frame = 0,
						paused = false,
						refresh = false,
						from = 1,
						upto = 25,
						outgoing = v222,
						query_id = v19,
						world = v21,
						include = v23,
						exclude = v24,
						with = v25,
						new_columns = t2,
						old_columns = t3
					}
				end
			end
		end

		for v29, v30 in v6:iter() do
			if traffic_check.check_no_wl(v29.host) then
				local v31 = t[v30]

				if v31 then
					v31.refresh = true
				end
			end
		end

		for v322, v33, v34 in v5:iter() do
			if traffic_check.check_no_wl(v322.host) then
				local v35 = t[v33]

				if v35 then
					v35.paused = v34
				end
			end
		end

		for v36, v37, v38, v39 in v4:iter() do
			if traffic_check.check_no_wl(v36.host) then
				local v40 = t[v37]

				if v40 then
					v40.refresh = true
					v40.from = v38
					v40.upto = v39
				end
			end
		end

		for v42, v43 in t do
			local v41

			if not v43.paused or v43.refresh == true then
				debug.profilebegin("process query")
				v43.refresh = false

				local world = v43.world.world
				local v44 = jecs.Name

				if check_if_still_valid(world, v43.include) and (check_if_still_valid(world, v43.exclude) and check_if_still_valid(world, v43.with)) then
					local v45 = world:query(unpack(v43.include))

					if #v43.exclude > 0 then
						v45 = v45:without(unpack(v43.exclude))
					end

					if #v43.with > 0 then
						v45 = v45:with(unpack(v43.with))
					end

					local upto = v43.upto
					local new_columns = v43.new_columns
					local old_columns = v43.old_columns

					v41 = function(p1) --[[ get_name | Line: 367 | Upvalues: jecs (ref), world (copy), v41 (copy), v44 (copy) ]]
						if jecs.IS_PAIR(p1) then
							local v1 = jecs.pair_first(world, p1)
							local v2 = jecs.pair_second(world, p1)

							return ("(%*, %*)"):format(v41(v1), (v41(v2)))
						end

						if p1 == jecs.Wildcard then
							return "*"
						end

						if world:has(p1, v44) then
							return world:get(p1, v44)
						end

						return ("$%*"):format(p1)
					end

					for v48, v49 in new_columns do
						local v50 = v43.include[v48 - 1]

						if v50 then
							v49[1] = v41(v50)

							continue
						end

						v49[1] = "id"
					end

					local v51 = v45:archetypes()
					local sum = 0

					for v52, v53 in v51 do
						sum = sum + #v53.entities
					end

					local v54 = table.create(sum)
					local count = 1

					for v55, v56 in v51 do
						for i = #v56.entities, 1, -1 do
							table.insert(v54, v56.entities[i])
						end
					end

					table.sort(v54)

					for j = v43.from, upto do
						count = count + 1

						local v58 = v54[j]

						if v58 then
							new_columns[1][count] = v58

							for v59, v60 in v43.include do
								local v61 = world:get(v58, v60)

								new_columns[v59 + 1][count] = if v61 == nil then v1 else v61
							end
						end
					end

					remotes.count_total_entities:fire(v43.outgoing, v42, sum)

					for k = 1, math.max(#new_columns, #old_columns) do
						for n = 1, upto do
							local v64
							local v65 = new_columns[k][n]

							if v65 ~= old_columns[k][n] or typeof(v65) == "table" then
								if typeof(v65) == "string" then
									v64 = ("\"%*\""):format((string.sub(v65, 1, 748)))
								elseif typeof(v65) == "table" then
									local t2 = {}

									for v67, v68 in v65 do
										if #t2 > 0 then
											table.insert(t2, "; ")
										end

										local v70 = ("%*: %*"):format(v67, if type(v68) == "string" then ("\"%*\""):format(v68) else tostring(v68))

										if #v70 + 0 + 2 > 750 then
											table.insert(t2, "...")

											break
										end

										table.insert(t2, v70)
									end

									v64 = ("{%*}"):format((table.concat(t2)))
								else
									v64 = if v65 == v1 then "" elseif v65 == nil then nil else string.sub(tostring(v65), 1, 748)
								end

								if n == 1 then
									v64 = v65
								end

								remotes.update_query_result:fire(v43.outgoing, v42, v43.frame, k, n, v64)
							end
						end
					end

					v43.new_columns = clear_columns(old_columns)
					v43.old_columns = new_columns
					v43.frame = v43.frame + 1
					debug.profileend()

					continue
				end

				debug.profileend()
			end
		end
	end
end