-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v3 = require(script.Parent:FindFirstChild("jecs") or script.Parent:FindFirstChild("Jecs"))

local function duplicate(p1) --[[ duplicate | Line: 7 ]]
	local v1 = p1.world:query()

	v1.filter_with = table.clone(p1.filter_with)

	if p1.filter_without then
		v1.filter_without = p1.filter_without
	end

	return v1:cached()
end

local function observers_new(p1, p2) --[[ observers_new | Line: 27 | Upvalues: v3 (copy) ]]
	local v1 = p1.world:query()

	v1.filter_with = table.clone(p1.filter_with)

	if p1.filter_without then
		v1.filter_without = p1.filter_without
	end

	local v2 = v1:cached()
	local world = v2.world
	local archetypes_map = v2.archetypes_map
	local entity_index = world.entity_index

	local function emplaced(p1, p22, p3, p4) --[[ emplaced | Line: 41 | Upvalues: entity_index (copy), v3 (ref), archetypes_map (copy), p2 (ref) ]]
		if not archetypes_map[entity_index.sparse_array[v3.ECS_ID(p1)].archetype.id] then
			return
		end

		p2(p1)
	end

	local t = {}

	for v32, v4 in p1.filter_with do
		if v3.IS_PAIR(v4) then
			local v5 = v3.ECS_PAIR_FIRST(v4)
			local v6 = if v3.ECS_PAIR_SECOND(v4) == v3.w then true else false

			local function emplaced_w_pair(p1, p22, p3, p4) --[[ emplaced_w_pair | Line: 64 | Upvalues: v6 (copy), v4 (copy), v3 (ref), world (copy), archetypes_map (copy), p2 (ref) ]]
				if not v6 and p22 ~= v4 then
					return
				end

				if not archetypes_map[v3.record(world, p1).archetype.id] then
					return
				end

				p2(p1)
			end

			local v7 = world:added(v5, emplaced_w_pair)
			local v8 = world:changed(v5, emplaced_w_pair)

			table.insert(t, v7)
			table.insert(t, v8)

			continue
		end

		local v9 = world:added(v4, emplaced)
		local v10 = world:changed(v4, emplaced)

		table.insert(t, v9)
		table.insert(t, v10)
	end

	local filter_without = p1.filter_without

	if filter_without then
		for v11, v12 in filter_without do
			if v3.IS_PAIR(v12) then
				local v13 = v3.ECS_PAIR_FIRST(v12)
				local v14 = if v3.ECS_PAIR_SECOND(v12) == v3.w then true else false
				local v15 = world:removed(v13, function(p1, p22, p3) --[[ Line: 93 | Upvalues: v14 (copy), v12 (copy), v3 (ref), world (copy), archetypes_map (copy), p2 (ref) ]]
					if p3 then
						return
					end

					if not v14 and p22 ~= v12 then
						return
					end

					local archetype = v3.record(world, p1).archetype

					if not (archetype and archetypes_map[v3.archetype_traverse_remove(world, p22, archetype).id]) then
						return
					end

					p2(p1)
				end)

				table.insert(t, v15)

				continue
			end

			local v16 = world:removed(v12, function(p1, p22, p3) --[[ Line: 112 | Upvalues: v3 (ref), world (copy), archetypes_map (copy), p2 (ref) ]]
				if p3 then
					return
				end

				local archetype = v3.record(world, p1).archetype

				if not (archetype and archetypes_map[v3.archetype_traverse_remove(world, p22, archetype).id]) then
					return
				end

				p2(p1)
			end)

			table.insert(t, v16)
		end
	end

	return {
		disconnect = function() --[[ disconnect | Line: 131 | Upvalues: t (copy) ]]
			for v1, v2 in t do
				v2()
			end
		end
	}
end

return {
	monitor = function(p1) --[[ monitors_new | Line: 144 | Upvalues: v3 (copy) ]]
		local v1 = p1.world:query()

		v1.filter_with = table.clone(p1.filter_with)

		if p1.filter_without then
			v1.filter_without = p1.filter_without
		end

		local v2 = v1:cached()
		local world = v2.world
		local archetypes_map = v2.archetypes_map
		local entity_index = world.entity_index
		local v32 = nil
		local v4 = nil
		local v5 = nil
		local v6 = nil

		local function emplaced(p1, p2, p3, p4) --[[ emplaced | Line: 160 | Upvalues: v32 (ref), v3 (ref), entity_index (copy), archetypes_map (copy), v5 (ref), v6 (ref) ]]
			if v32 == nil then
				return
			end

			if archetypes_map[p4.id] or not archetypes_map[v3.entity_index_try_get_fast(entity_index, p1).archetype.id] then
				v5 = nil
				v6 = nil

				return
			end

			if v5 == p4 and v6 == p1 then
				return
			end

			v5 = p4
			v6 = p1
			v32(p1)
		end

		local function removed(p1, p2, p3) --[[ removed | Line: 186 | Upvalues: v4 (ref), v3 (ref), world (copy), archetypes_map (copy), v6 (ref), v5 (ref) ]]
			if v4 == nil then
				return
			end

			local v1 = v3.record(world, p1)

			if not v1 then
				return
			end

			local archetype = v1.archetype

			if not archetype then
				return
			end

			if not archetypes_map[archetype.id] then
				return
			end

			if v6 == p1 and v5 == archetype then
				return
			end

			v6 = p1
			v5 = archetype
			v4(p1)
		end

		local t = {}

		for v7, v8 in v2.filter_with do
			if v3.IS_PAIR(v8) then
				local v9 = v3.ECS_PAIR_FIRST(v8)
				local v10 = if v3.ECS_PAIR_SECOND(v8) == v3.w then true else false
				local v11 = world:added(v9, function(p1, p2, p3, p4) --[[ Line: 216 | Upvalues: v32 (ref), v10 (copy), v8 (copy), v3 (ref), entity_index (copy), archetypes_map (copy), v5 (ref), v6 (ref) ]]
					if v32 == nil then
						return
					end

					if not v10 and p2 ~= v8 then
						return
					end

					if archetypes_map[p4.id] or not archetypes_map[v3.entity_index_try_get_fast(entity_index, p1).archetype.id] then
						v5 = nil
						v6 = nil

						return
					end

					if v5 == p4 and v6 == p1 then
						return
					end

					v5 = p4
					v6 = p1
					v32(p1)
				end)
				local v12 = world:removed(v9, function(p1, p2, p3) --[[ Line: 241 | Upvalues: v4 (ref), v10 (copy), v8 (copy), v3 (ref), world (copy), v6 (ref), v5 (ref), archetypes_map (copy) ]]
					if v4 == nil then
						return
					end

					if not v10 and p2 ~= v8 then
						return
					end

					local archetype = v3.record(world, p1).archetype

					if v6 == p1 and v5 == archetype then
						return
					end

					if archetypes_map[archetype.id] then
						v6 = p1
						v5 = archetype
						v4(p1)
					end
				end)

				table.insert(t, v11)
				table.insert(t, v12)

				continue
			end

			local v13 = world:added(v8, emplaced)
			local v14 = world:removed(v8, removed)

			table.insert(t, v13)
			table.insert(t, v14)
		end

		local filter_without = p1.filter_without

		if filter_without then
			for v15, v16 in filter_without do
				if v3.IS_PAIR(v16) then
					local v17 = v3.ECS_PAIR_FIRST(v16)
					local v18 = if v3.ECS_PAIR_SECOND(v16) == v3.w then true else false
					local v19 = world:added(v17, function(p1, p2, p3, p4) --[[ Line: 279 | Upvalues: v4 (ref), v18 (copy), v16 (copy), v3 (ref), world (copy), archetypes_map (copy), v5 (ref) ]]
						if v4 == nil then
							return
						end

						if not v18 and p2 ~= v16 then
							return
						end

						local archetype = v3.record(world, p1).archetype

						if not archetype then
							return
						end

						if not archetypes_map[p4.id] or archetypes_map[archetype.id] then
							return
						end

						v5 = nil
						v4(p1)
					end)
					local v20 = world:removed(v17, function(p1, p2, p3) --[[ Line: 297 | Upvalues: v32 (ref), v18 (copy), v16 (copy), v3 (ref), world (copy), v5 (ref), archetypes_map (copy) ]]
						if p3 then
							return
						end

						if v32 == nil then
							return
						end

						if not v18 and p2 ~= v16 then
							return
						end

						local archetype = v3.record(world, p1).archetype

						if not archetype then
							return
						end

						if v5 == archetype then
							return
						end

						if not archetypes_map[v3.archetype_traverse_remove(world, p2, archetype).id] then
							return
						end

						v5 = archetype
						v32(p1)
					end)

					table.insert(t, v19)
					table.insert(t, v20)

					continue
				end

				local v21 = world:added(v16, function(p1, p2, p3, p4) --[[ Line: 327 | Upvalues: v4 (ref), v3 (ref), world (copy), archetypes_map (copy) ]]
					if v4 == nil then
						return
					end

					local archetype = v3.record(world, p1).archetype

					if not archetype then
						return
					end

					if not archetypes_map[p4.id] or archetypes_map[archetype.id] then
						return
					end

					v4(p1)
				end)
				local v22 = world:removed(v16, function(p1, p2, p3) --[[ Line: 341 | Upvalues: v32 (ref), v3 (ref), world (copy), archetypes_map (copy) ]]
					if p3 then
						return
					end

					if v32 == nil then
						return
					end

					local archetype = v3.record(world, p1).archetype

					if not archetype then
						return
					end

					if not archetypes_map[v3.archetype_traverse_remove(world, p2, archetype).id] then
						return
					end

					v32(p1)
				end)

				table.insert(t, v21)
				table.insert(t, v22)
			end
		end

		return {
			disconnect = function() --[[ disconnect | Line: 365 | Upvalues: t (copy) ]]
				for v1, v2 in t do
					v2()
				end
			end,
			added = function(p1) --[[ monitor_added | Line: 371 | Upvalues: v32 (ref) ]]
				v32 = p1
			end,
			removed = function(p1) --[[ monitor_removed | Line: 375 | Upvalues: v4 (ref) ]]
				v4 = p1
			end
		}
	end,
	observer = observers_new
}