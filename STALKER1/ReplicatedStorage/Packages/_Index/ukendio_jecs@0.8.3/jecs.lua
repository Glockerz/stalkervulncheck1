-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = table.freeze({})
local v2 = newproxy(false)

local function ecs_assert(p1, p2) --[[ ecs_assert | Line: 227 ]]
	if p1 then
		return
	end

	error(p2)
end

local t = {}
local v3 = 0
local v4 = 271

local function ECS_COMPONENT() --[[ ECS_COMPONENT | Line: 237 | Upvalues: v3 (ref) ]]
	v3 = v3 + 1

	if not (v3 > 256) then
		return v3
	end

	error("Too many components")
end

local function ECS_TAG() --[[ ECS_TAG | Line: 245 | Upvalues: v4 (ref) ]]
	v4 = v4 + 1

	return v4
end

local function ECS_META(p1, p2, p3) --[[ ECS_META | Line: 250 | Upvalues: t (ref), v2 (copy) ]]
	local v1 = t[p1]

	if v1 == nil then
		v1 = {}
		t[p1] = v1
	end

	v1[p2] = if p3 == nil then v2 else p3
end

local function ECS_META_RESET() --[[ ECS_META_RESET | Line: 259 | Upvalues: t (ref), v3 (ref), v4 (ref) ]]
	t = {}
	v3 = 0
	v4 = 271
end

local function ECS_COMBINE(p1, p2) --[[ ECS_COMBINE | Line: 265 ]]
	return p1 + p2 * 16777216
end

local function ECS_IS_PAIR(p1) --[[ ECS_IS_PAIR | Line: 269 ]]
	return p1 > 281474976710656
end

local function ECS_GENERATION_INC(p1) --[[ ECS_GENERATION_INC | Line: 273 ]]
	if not (p1 > 16777216) then
		return p1 + 16777216
	end

	local v1 = p1 % 16777216
	local v2 = p1 // 16777216 + 1

	if v2 >= 65536 then
		return v1
	end

	return v1 + v2 * 16777216
end

local function ECS_ENTITY_T_LO(p1) --[[ ECS_ENTITY_T_LO | Line: 288 ]]
	return p1 % 16777216
end

local function ECS_ID(p1) --[[ ECS_ID | Line: 292 ]]
	return p1 % 16777216
end

local function ECS_GENERATION(p1) --[[ ECS_GENERATION | Line: 296 ]]
	return p1 // 16777216
end

local function ECS_ENTITY_T_HI(p1) --[[ ECS_ENTITY_T_HI | Line: 300 ]]
	return p1 // 16777216
end

local function ECS_PAIR(p1, p2) --[[ ECS_PAIR | Line: 304 ]]
	return p2 % 16777216 + p1 % 16777216 * 16777216 + 281474976710656
end

local function ECS_PAIR_FIRST(p1) --[[ ECS_PAIR_FIRST | Line: 311 ]]
	return (p1 - 281474976710656) // 16777216
end

local function ECS_PAIR_SECOND(p1) --[[ ECS_PAIR_SECOND | Line: 315 ]]
	return (p1 - 281474976710656) % 16777216
end

local function entity_index_try_get_any(p1, p2) --[[ entity_index_try_get_any | Line: 319 ]]
	local v1 = p1.sparse_array[p2 % 16777216]

	if v1 and v1.dense ~= 0 then
		return v1
	end

	return nil
end

local function entity_index_try_get(p1, p2) --[[ entity_index_try_get | Line: 332 ]]
	local v1 = p1.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil

	if v2 then
		local dense = v2.dense

		if p1.alive_count < dense then
			return nil
		end

		if p1.dense_array[dense] ~= p2 then
			return nil
		end
	end

	return v2
end

local function entity_index_try_get_fast(p1, p2) --[[ entity_index_try_get_fast | Line: 346 ]]
	local v1 = p1.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil

	if v2 and p1.dense_array[v2.dense] ~= p2 then
		return nil
	end

	return v2
end

local function entity_index_is_alive(p1, p2) --[[ entity_index_is_alive | Line: 360 ]]
	local v1 = p1.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil
	local v3

	if v2 then
		local dense = v2.dense

		v3 = if p1.alive_count < dense or p1.dense_array[dense] ~= p2 then nil else v2
	else
		v3 = v2
	end

	return v3 ~= nil
end

local function entity_index_get_alive(p1, p2) --[[ entity_index_get_alive | Line: 364 ]]
	local v1 = p1.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil

	if v2 then
		return p1.dense_array[v2.dense]
	end

	return nil
end

local function ecs_get_alive(p1, p2) --[[ ecs_get_alive | Line: 372 ]]
	if p2 == 0 then
		return 0
	end

	local entity_index = p1.entity_index
	local v1 = entity_index.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil
	local v3

	if v2 then
		local dense = v2.dense

		v3 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= p2 then nil else v2
	else
		v3 = v2
	end

	if if v3 == nil then false else true then
		return p2
	end

	if p2 > 16777216 then
		return 0
	end

	local v5 = entity_index.sparse_array[p2 % 16777216]
	local v6 = if v5 and v5.dense ~= 0 then v5 else nil
	local v7 = if v6 then entity_index.dense_array[v6.dense] else nil

	if not v7 then
		return 0
	end

	local v8 = entity_index.sparse_array[v7 % 16777216]
	local v9 = if v8 and v8.dense ~= 0 then v8 else nil
	local v10

	if v9 then
		local dense = v9.dense

		v10 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v7 then nil else v9
	else
		v10 = v9
	end

	if if v10 == nil then false else true then
		return v7
	end

	return 0
end

local function entity_index_new_id(p1) --[[ entity_index_new_id | Line: 397 ]]
	local dense_array = p1.dense_array
	local alive_count = p1.alive_count
	local sparse_array = p1.sparse_array
	local max_id = p1.max_id

	if alive_count < max_id then
		local v1 = alive_count + 1

		p1.alive_count = v1

		return dense_array[v1]
	end

	local v2 = max_id + 1
	local range_end = p1.range_end

	if if range_end == nil then true elseif v2 < range_end then true else false then
		local v4

		p1.max_id = v2
		v4 = alive_count + 1
		p1.alive_count = v4
		dense_array[v4] = v2
		sparse_array[v2] = {
			dense = v4
		}

		return v2
	end

	error("Entity is outside range")
end

local function ecs_pair_first(p1, p2) --[[ ecs_pair_first | Line: 423 ]]
	local v1 = (p2 - 281474976710656) // 16777216

	if v1 == 0 then
		return 0
	end

	local entity_index = p1.entity_index
	local v2 = entity_index.sparse_array[v1 % 16777216]
	local v3 = if v2 and v2.dense ~= 0 then v2 else nil
	local v4

	if v3 then
		local dense = v3.dense

		v4 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v1 then nil else v3
	else
		v4 = v3
	end

	if if v4 == nil then false else true then
		return v1
	end

	if v1 > 16777216 then
		return 0
	end

	local v6 = entity_index.sparse_array[v1 % 16777216]
	local v7 = if v6 and v6.dense ~= 0 then v6 else nil
	local v8 = if v7 then entity_index.dense_array[v7.dense] else nil

	if not v8 then
		return 0
	end

	local v9 = entity_index.sparse_array[v8 % 16777216]
	local v10 = if v9 and v9.dense ~= 0 then v9 else nil
	local v11

	if v10 then
		local dense = v10.dense

		v11 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v8 then nil else v10
	else
		v11 = v10
	end

	if if v11 == nil then false else true then
		return v8
	end

	return 0
end

local function ecs_pair_second(p1, p2) --[[ ecs_pair_second | Line: 428 ]]
	local v1 = (p2 - 281474976710656) % 16777216

	if v1 == 0 then
		return 0
	end

	local entity_index = p1.entity_index
	local v2 = entity_index.sparse_array[v1 % 16777216]
	local v3 = if v2 and v2.dense ~= 0 then v2 else nil
	local v4

	if v3 then
		local dense = v3.dense

		v4 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v1 then nil else v3
	else
		v4 = v3
	end

	if if v4 == nil then false else true then
		return v1
	end

	if v1 > 16777216 then
		return 0
	end

	local v6 = entity_index.sparse_array[v1 % 16777216]
	local v7 = if v6 and v6.dense ~= 0 then v6 else nil
	local v8 = if v7 then entity_index.dense_array[v7.dense] else nil

	if not v8 then
		return 0
	end

	local v9 = entity_index.sparse_array[v8 % 16777216]
	local v10 = if v9 and v9.dense ~= 0 then v9 else nil
	local v11

	if v10 then
		local dense = v10.dense

		v11 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v8 then nil else v10
	else
		v11 = v10
	end

	if if v11 == nil then false else true then
		return v8
	end

	return 0
end

local function query_match(p1, p2) --[[ query_match | Line: 433 ]]
	local columns_map = p2.columns_map

	for v1, v2 in p1.filter_with do
		if not columns_map[v2] then
			return false
		end
	end

	local filter_without = p1.filter_without

	if not filter_without then
		return true
	end

	for v3, v4 in filter_without do
		if columns_map[v4] then
			return false
		end
	end

	return true
end

local function find_observers(p1, p2, p3) --[[ find_observers | Line: 455 ]]
	local v1 = p1.observable[p2]

	if v1 then
		return v1[p3]
	end

	return nil
end

local function archetype_move(p1, p2, p3, p4, p5, p6) --[[ archetype_move | Line: 463 | Upvalues: v1 (copy) ]]
	local columns = p5.columns
	local entities2 = p5.entities
	local v12 = #entities2
	local types = p5.types
	local columns_map = p3.columns_map

	if p6 == v12 then
		for v2, v3 in columns do
			if v3 ~= v1 then
				local v4 = columns_map[types[v2]]

				if v4 then
					v4[p4] = v3[p6]
				end

				v3[v12] = nil
			end
		end
	else
		for v5, v6 in columns do
			if v6 ~= v1 then
				local v7 = columns_map[types[v5]]

				if v7 then
					v7[p4] = v6[p6]
				end

				v6[p6] = v6[v12]
				v6[v12] = nil
			end
		end

		local v8 = entities2[v12]

		entities2[p6] = v8
		p1.sparse_array[v8 % 16777216].row = p6
	end

	entities2[v12] = nil
	p3.entities[p4] = p2
end

local function archetype_append(p1, p2) --[[ archetype_append | Line: 533 ]]
	local entities = p2.entities
	local v1 = #entities + 1

	entities[v1] = p1

	return v1
end

local function new_entity(p1, p2, p3) --[[ new_entity | Line: 543 ]]
	local entities = p3.entities
	local v1 = #entities + 1

	entities[v1] = p1
	p2.archetype = p3
	p2.row = v1

	return p2
end

local function entity_move(p1, p2, p3, p4) --[[ entity_move | Line: 554 | Upvalues: archetype_move (copy) ]]
	local entities = p4.entities
	local v1 = #entities + 1

	entities[v1] = p2
	archetype_move(p1, p2, p4, v1, p3.archetype, p3.row)
	p3.archetype = p4
	p3.row = v1
end

local function hash(p1) --[[ hash | Line: 568 ]]
	return table.concat(p1, "_")
end

local function fetch(p1, p2, p3) --[[ fetch | Line: 572 ]]
	local v1 = p2[p1]

	if v1 then
		return v1[p3]
	end

	return nil
end

local function world_get(p1, p2, p3, p4, p5, p6, p7) --[[ world_get | Line: 582 ]]
	local entity_index = p1.entity_index
	local v1 = entity_index.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil
	local v3

	if v2 then
		local dense = v2.dense

		v3 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= p2 then nil else v2
	else
		v3 = v2
	end

	if not v3 then
		return nil
	end

	local archetype = v3.archetype

	if not archetype then
		return nil
	end

	local columns_map = archetype.columns_map
	local row = v3.row
	local v4 = columns_map[p3]
	local v5 = if v4 then v4[row] else nil

	if not p4 then
		return v5
	end

	if p5 then
		if p6 then
			if p7 then
				error("args exceeded")
			end

			local v6 = columns_map[p4]
			local v7 = if v6 then v6[row] else nil
			local v8 = columns_map[p5]
			local v9 = if v8 then v8[row] else nil
			local v11 = columns_map[p6]

			if v11 then
				return v5, v7, v9, v11[row]
			end

			return v5, v7, v9, nil
		end

		local v12 = columns_map[p4]
		local v13 = if v12 then v12[row] else nil
		local v14 = columns_map[p5]

		if v14 then
			return v5, v13, v14[row]
		end

		return v5, v13, nil
	end

	local v15 = columns_map[p4]

	if v15 then
		return v5, v15[row]
	end

	return v5, nil
end

local function world_has_one_inline(p1, p2, p3) --[[ world_has_one_inline | Line: 612 ]]
	local entity_index = p1.entity_index
	local v1 = entity_index.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil
	local v3

	if v2 then
		local dense = v2.dense

		v3 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= p2 then nil else v2
	else
		v3 = v2
	end

	if not v3 then
		return false
	end

	local archetype = v3.archetype

	if not archetype then
		return false
	end

	return archetype.columns_map[p3] ~= nil
end

local function world_target(p1, p2, p3, p4) --[[ world_target | Line: 626 ]]
	local entity_index = p1.entity_index
	local v1 = entity_index.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil
	local v3

	if v2 then
		local dense = v2.dense

		v3 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= p2 then nil else v2
	else
		v3 = v2
	end

	if not v3 then
		return nil
	end

	local archetype = v3.archetype

	if not archetype then
		return nil
	end

	local v4 = p1.component_index[260 + p3 % 16777216 * 16777216 + 281474976710656]

	if not v4 then
		return nil
	end

	local id = archetype.id
	local v5 = v4.counts[id]

	if not v5 then
		return nil
	end

	local v6 = p4 or 0

	if v5 <= v6 then
		v6 = v6 + v5 + 1
	end

	local v7 = archetype.types[v6 + v4.records[id]]

	if not v7 then
		return nil
	end

	local v8 = entity_index.sparse_array[(v7 - 281474976710656) % 16777216 % 16777216]
	local v9 = if v8 and v8.dense ~= 0 then v8 else nil

	if v9 then
		return entity_index.dense_array[v9.dense]
	end

	return nil
end

local function ECS_ID_IS_WILDCARD(p1) --[[ ECS_ID_IS_WILDCARD | Line: 667 ]]
	return if p1 // 16777216 == 260 then true else p1 % 16777216 == 260
end

local function id_record_get(p1, p2) --[[ id_record_get | Line: 673 ]]
	local v1 = p1.component_index[p2]

	if v1 then
		return v1
	end

	return nil
end

local function id_record_ensure(p1, p2) --[[ id_record_ensure | Line: 684 | Upvalues: world_target (copy) ]]
	local component_index = p1.component_index
	local entity_index = p1.entity_index
	local v1 = component_index[p2]

	if v1 then
		return v1
	end

	local v2 = 0
	local v3 = 0
	local v4 = p2 > 281474976710656
	local v5 = false
	local v6 = false
	local v7

	if v4 then
		local v8 = entity_index.sparse_array[(p2 - 281474976710656) // 16777216 % 16777216]
		local v9 = if v8 and v8.dense ~= 0 then v8 else nil

		v7 = if v9 then entity_index.dense_array[v9.dense] else nil

		local v10

		if v7 then
			local v11 = entity_index.sparse_array[v7 % 16777216]
			local v12, v13

			if v11 and v11.dense ~= 0 then
				v12 = v11
				v13 = v7
			else
				v12 = nil
				v13 = v7
			end

			local v14

			if v12 then
				local dense = v12.dense

				v14 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v13 then nil else v12
			else
				v14 = v12
			end

			v10 = if v14 == nil then false else true
		else
			v10 = v7
		end

		if not v10 then
			error("\tThis is an internal error, please file a bug report via the following link:\n\n\thttps://github.com/Ukendio/jecs/issues/new?template=BUG-REPORT.md\n")
		end

		local v15 = entity_index.sparse_array[(p2 - 281474976710656) % 16777216 % 16777216]
		local v16 = if v15 and v15.dense ~= 0 then v15 else nil

		v3 = if v16 then entity_index.dense_array[v16.dense] else nil

		local v17

		if v3 then
			local v18 = entity_index.sparse_array[v3 % 16777216]
			local v19, v20

			if v18 and v18.dense ~= 0 then
				v19 = v18
				v20 = v3
			else
				v19 = nil
				v20 = v3
			end

			local v21

			if v19 then
				local dense = v19.dense

				v21 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v20 then nil else v19
			else
				v21 = v19
			end

			v17 = if v21 == nil then false else true
		else
			v17 = v3
		end

		if not v17 then
			error("\tThis is an internal error, please file a bug report via the following link:\n\n\thttps://github.com/Ukendio/jecs/issues/new?template=BUG-REPORT.md\n")
		end

		if world_target(p1, v7, 264, 0) == 265 then
			v5 = true
		end

		local entity_index2 = p1.entity_index
		local v22 = entity_index2.sparse_array[v7 % 16777216]
		local v23, v24

		if v22 and v22.dense ~= 0 then
			v23 = v22
			v24 = v7
		else
			v23 = nil
			v24 = v7
		end

		local v25

		if v23 then
			local dense = v23.dense

			v25 = if entity_index2.alive_count < dense or entity_index2.dense_array[dense] ~= v24 then nil else v23
		else
			v25 = v23
		end

		local v26

		if v25 then
			local archetype = v25.archetype

			v26 = if archetype then if archetype.columns_map[270] == nil then false else true else false
		else
			v26 = false
		end

		if v26 then
			v6 = true
		end
	elseif world_target(p1, p2, 263, 0) == 265 then
		v7 = p2
		v5 = true
	else
		v7 = p2
	end

	local entity_index2 = p1.entity_index
	local v27 = entity_index2.sparse_array[v7 % 16777216]
	local v28, v29

	if v27 and v27.dense ~= 0 then
		v28 = v27
		v29 = v7
	else
		v28 = nil
		v29 = v7
	end

	local v30

	if v28 then
		local dense = v28.dense

		v30 = if entity_index2.alive_count < dense or entity_index2.dense_array[dense] ~= v29 then nil else v28
	else
		v30 = v28
	end

	local v31, v32, v33

	if v30 then
		local archetype = v30.archetype

		if archetype then
			local columns_map = archetype.columns_map
			local row = v30.row
			local v34 = columns_map[257]
			local v35 = if v34 then v34[row] else nil
			local v36 = columns_map[259]

			v31 = if v36 then v36[row] else nil

			local v37 = columns_map[258]

			if v37 then
				v32 = v37[row]
				v33 = v35
			else
				v32 = nil
				v33 = v35
			end
		else
			v32 = nil
			v33 = nil
			v31 = nil
		end
	else
		v32 = nil
		v33 = nil
		v31 = nil
	end

	local entity_index3 = p1.entity_index
	local v38 = entity_index3.sparse_array[v7 % 16777216]
	local v39, v40

	if v38 and v38.dense ~= 0 then
		v39 = v38
		v40 = v7
	else
		v39 = nil
		v40 = v7
	end

	local v41

	if v39 then
		local dense = v39.dense

		v41 = if entity_index3.alive_count < dense or entity_index3.dense_array[dense] ~= v40 then nil else v39
	else
		v41 = v39
	end

	local v42

	if v41 then
		local archetype = v41.archetype

		v42 = if archetype then if archetype.columns_map[262] == nil then false else true else false
	else
		v42 = false
	end

	local v43 = not v42

	if v43 and v4 then
		local entity_index4 = p1.entity_index
		local v44 = entity_index4.sparse_array[v3 % 16777216]
		local v45, v46

		if v44 and v44.dense ~= 0 then
			v45 = v44
			v46 = v3
		else
			v45 = nil
			v46 = v3
		end

		local v47

		if v45 then
			local dense = v45.dense

			v47 = if entity_index4.alive_count < dense or entity_index4.dense_array[dense] ~= v46 then nil else v45
		else
			v47 = v45
		end

		local v48

		if v47 then
			local archetype = v47.archetype

			v48 = if archetype then if archetype.columns_map[262] == nil then false else true else false
		else
			v48 = false
		end

		v43 = not v48
	end

	local v50, v51

	if v43 then
		v50 = v2
		v51 = 2
	else
		v50 = v2
		v51 = 0
	end

	local t = {
		size = 0,
		records = {},
		counts = {},
		flags = bit32.bor(v50, if v5 then 1 else 0, v51, if v6 then 4 else 0),
		on_add = v33,
		on_change = v31,
		on_remove = v32
	}

	component_index[p2] = t

	return t
end

local function archetype_append_to_records(p1, p2, p3, p4, p5, p6) --[[ archetype_append_to_records | Line: 759 ]]
	local records = p1.records
	local counts = p1.counts

	if records[p2] then
		counts[p2] = counts[p2] + 1
	else
		records[p2] = p5
		counts[p2] = 1
		p3[p4] = p6
	end
end

local function archetype_register(p1, p2) --[[ archetype_register | Line: 780 | Upvalues: id_record_ensure (copy), v1 (copy) ]]
	local id = p2.id
	local columns_map = p2.columns_map
	local columns = p2.columns

	for v12, v2 in p2.types do
		local v3 = id_record_ensure(p1, v2)
		local v4 = if bit32.btest(v3.flags, 2) then v1 else {}

		columns[v12] = v4

		local records = v3.records
		local counts = v3.counts

		if records[id] then
			counts[id] = counts[id] + 1
		else
			records[id] = v12
			counts[id] = 1
			columns_map[v2] = v4
		end

		if if v2 > 281474976710656 then true else false then
			local v7 = 260 + (v2 - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656
			local v8 = id_record_ensure(p1, v7)
			local records2 = v8.records
			local counts2 = v8.counts

			if records2[id] then
				counts2[id] = counts2[id] + 1
			else
				records2[id] = v12
				counts2[id] = 1
				columns_map[v7] = v4
			end

			local v9 = (v2 - 281474976710656) % 16777216 % 16777216 + 4362076160 + 281474976710656
			local v10 = id_record_ensure(p1, v9)
			local records3 = v10.records
			local counts3 = v10.counts

			if records3[id] then
				counts3[id] = counts3[id] + 1

				continue
			end

			records3[id] = v12
			counts3[id] = 1
			columns_map[v9] = v4
		end
	end

	p1.archetype_index[p2.type] = p2
	p1.archetypes[id] = p2
	p1.archetype_edges[p2.id] = {}
end

local function archetype_create(p1, p2, p3, p4) --[[ archetype_create | Line: 813 | Upvalues: archetype_register (copy) ]]
	-- structuring failed for function 40; please report this in our discord https://discord.gg/y63m4zUYa4
end

local function world_range(p1, p2, p3) --[[ world_range | Line: 850 ]]
	local entity_index = p1.entity_index

	entity_index.range_begin = p2
	entity_index.range_end = p3

	local max_id = entity_index.max_id

	if not (max_id < p2) then
		return
	end

	local dense_array = entity_index.dense_array
	local sparse_array = entity_index.sparse_array

	for i = max_id + 1, p2 do
		dense_array[i] = i
		sparse_array[i] = {
			dense = 0
		}
	end

	entity_index.max_id = p2 - 1
	entity_index.alive_count = p2 - 1
end

local function archetype_ensure(p1, p2) --[[ archetype_ensure | Line: 873 | Upvalues: archetype_register (copy), archetype_create (copy) ]]
	if #p2 < 1 then
		return p1.ROOT_ARCHETYPE
	end

	local v1 = table.concat(p2, "_")
	local v2 = p1.archetype_index[v1]

	if not v2 then
		return archetype_create(p1, p2, v1)
	end

	if v2.dead then
		archetype_register(p1, v2)
		v2.dead = false
	end

	return v2
end

local function find_insert(p1, p2) --[[ find_insert | Line: 891 ]]
	for v1, v2 in p1 do
		if v2 == p2 then
			return -1
		end

		if p2 < v2 then
			return v1
		end
	end

	return #p1 + 1
end

local function find_archetype_without(p1, p2, p3) --[[ find_archetype_without | Line: 903 | Upvalues: archetype_register (copy), archetype_create (copy) ]]
	local types = p2.types
	local v1 = table.find(types, p3)
	local v2 = table.clone(types)

	table.remove(v2, v1)

	if #v2 < 1 then
		return p1.ROOT_ARCHETYPE
	end

	local v3 = table.concat(v2, "_")
	local v4 = p1.archetype_index[v3]

	if not v4 then
		return archetype_create(p1, v2, v3)
	end

	if v4.dead then
		archetype_register(p1, v4)
		v4.dead = false
	end

	return v4
end

local function create_edge_for_remove(p1, p2, p3, p4) --[[ create_edge_for_remove | Line: 918 | Upvalues: archetype_register (copy), archetype_create (copy) ]]
	local types = p2.types
	local v1 = table.find(types, p4)
	local v2 = table.clone(types)

	table.remove(v2, v1)

	local v3

	if #v2 < 1 then
		v3 = p1.ROOT_ARCHETYPE
	else
		local v4 = table.concat(v2, "_")
		local v5 = p1.archetype_index[v4]

		if v5 then
			if v5.dead then
				archetype_register(p1, v5)
				v5.dead = false
			end

			v3 = v5
		else
			v3 = archetype_create(p1, v2, v4)
		end
	end

	local archetype_edges = p1.archetype_edges

	archetype_edges[p2.id][p4] = v3
	archetype_edges[v3.id][p4] = p2

	return v3
end

local function archetype_traverse_remove(p1, p2, p3) --[[ archetype_traverse_remove | Line: 932 | Upvalues: archetype_register (copy), archetype_create (copy) ]]
	local archetype_edges = p1.archetype_edges
	local v1 = archetype_edges[p3.id]
	local v2 = v1[p2]

	if v2 == nil then
		local types = p3.types
		local v3 = table.find(types, p2)
		local v4 = table.clone(types)

		table.remove(v4, v3)

		if #v4 < 1 then
			v2 = p1.ROOT_ARCHETYPE
		else
			local v5 = table.concat(v4, "_")
			local v6 = p1.archetype_index[v5]

			if v6 then
				if v6.dead then
					archetype_register(p1, v6)
					v6.dead = false
				end

				v2 = v6
			else
				v2 = archetype_create(p1, v4, v5)
			end
		end

		v1[p2] = v2
		archetype_edges[v2.id][p2] = p3
	end

	return v2
end

local function find_archetype_with(p1, p2, p3) --[[ find_archetype_with | Line: 950 | Upvalues: archetype_register (copy), archetype_create (copy) ]]
	local types = p3.types
	local v1 = table.clone(types)
	local v2

	do
		local __inline_returned = false

		for v3, v4 in types do
			if v4 == p2 then
				v2 = -1
				__inline_returned = true

				break
			elseif p2 < v4 then
				v2 = v3
				__inline_returned = true

				break
			end
		end

		if not __inline_returned then
			v2 = #types + 1
		end
	end

	table.insert(v1, v2, p2)

	if #v1 < 1 then
		return p1.ROOT_ARCHETYPE
	end

	local v5 = table.concat(v1, "_")
	local v6 = p1.archetype_index[v5]

	if not v6 then
		return archetype_create(p1, v1, v5)
	end

	if v6.dead then
		archetype_register(p1, v6)
		v6.dead = false
	end

	return v6
end

local function archetype_traverse_add(p1, p2, p3) --[[ archetype_traverse_add | Line: 961 | Upvalues: archetype_register (copy), archetype_create (copy) ]]
	local v1 = if p3 then p3 else p1.ROOT_ARCHETYPE

	if v1.columns_map[p2] then
		return v1
	end

	local archetype_edges = p1.archetype_edges
	local v2 = archetype_edges[v1.id]
	local v3 = v2[p2]

	if not v3 then
		local types = v1.types
		local v4 = table.clone(types)
		local v6

		do
			local __inline_returned = false

			for v7, v8 in types do
				if v8 == p2 then
					v6 = -1
					__inline_returned = true

					break
				elseif p2 < v8 then
					v6 = v7
					__inline_returned = true

					break
				end
			end

			if not __inline_returned then
				v6 = #types + 1
			end
		end

		table.insert(v4, v6, p2)

		if #v4 < 1 then
			v3 = p1.ROOT_ARCHETYPE
		else
			local v9 = table.concat(v4, "_")
			local v10 = p1.archetype_index[v9]

			if v10 then
				if v10.dead then
					archetype_register(p1, v10)
					v10.dead = false
				end

				v3 = v10
			else
				v3 = archetype_create(p1, v4, v9)
			end
		end

		v2[p2] = v3
		archetype_edges[v3.id][p2] = v1
	end

	return v3
end

local function world_component(p1) --[[ world_component | Line: 979 ]]
	local v1 = p1.max_component_id + 1

	if not (v1 > 256) then
		p1.max_component_id = v1

		return v1
	end

	error("Too many components, consider using world:entity() instead to create components.")
end

local function archetype_fast_delete_last(p1, p2) --[[ archetype_fast_delete_last | Line: 991 | Upvalues: v1 (copy) ]]
	for v12, v2 in p1 do
		if v2 ~= v1 then
			v2[p2] = nil
		end
	end
end

local function archetype_fast_delete(p1, p2, p3) --[[ archetype_fast_delete | Line: 999 | Upvalues: v1 (copy) ]]
	for v12, v2 in p1 do
		if v2 ~= v1 then
			v2[p3] = v2[p2]
			v2[p2] = nil
		end
	end
end

local function archetype_delete(p1, p2, p3) --[[ archetype_delete | Line: 1008 | Upvalues: v1 (copy) ]]
	local entity_index = p1.entity_index
	local component_index = p1.component_index
	local columns = p2.columns
	local entities = p2.entities
	local v12 = #entities
	local v2 = #entities
	local v3 = entities[v2]
	local v4

	if p3 == v2 then
		v4 = v3
	else
		local v5 = entity_index.sparse_array[v3 % 16777216]
		local v6 = if v5 and v5.dense ~= 0 then v5 else nil

		if v6 then
			v6.row = p3
		end

		v4 = entities[p3]
		entities[p3] = v3
	end

	for v7, v8 in p2.types do
		local on_remove = component_index[v8].on_remove

		if on_remove then
			on_remove(v4, v8)
		end
	end

	entities[v2] = nil

	if p3 == v2 then
		for v9, v10 in columns do
			if v10 ~= v1 then
				v10[v12] = nil
			end
		end
	else
		for v11, v122 in columns do
			if v122 ~= v1 then
				v122[p3] = v122[v12]
				v122[v12] = nil
			end
		end
	end
end

local function archetype_destroy(p1, p2) --[[ archetype_destroy | Line: 1048 ]]
	-- structuring failed for function 53; please report this in our discord https://discord.gg/y63m4zUYa4
end

local function NOOP() --[[ NOOP | Line: 1087 ]] end

local function query_iter_init(p1) --[[ query_iter_init | Line: 1090 | Upvalues: NOOP (copy) ]]
	local compatible_archetypes = p1.compatible_archetypes
	local v1 = 1
	local v2 = compatible_archetypes[1]

	if not v2 then
		return NOOP
	end

	local entities = v2.entities
	local v3 = #entities
	local columns_map = v2.columns_map
	local ids = p1.ids
	local v4, v5, v6, v7, v8, v9, v10, v11, v12 = unpack(ids)
	local v13 = nil
	local v14 = nil
	local v15 = nil
	local v16 = nil
	local v17 = nil
	local v18 = nil
	local v19 = nil
	local v20

	if v5 then
		if v6 then
			if v7 then
				if v8 then
					if v9 then
						if v10 then
							if v11 then
								v20 = columns_map[v4]
								v13 = columns_map[v5]
								v14 = columns_map[v6]
								v15 = columns_map[v7]
								v16 = columns_map[v8]
								v17 = columns_map[v9]
								v18 = columns_map[v10]
								v19 = columns_map[v11]
							else
								v20 = columns_map[v4]
								v13 = columns_map[v5]
								v14 = columns_map[v6]
								v15 = columns_map[v7]
								v16 = columns_map[v8]
								v17 = columns_map[v9]
								v18 = columns_map[v10]
							end
						else
							v20 = columns_map[v4]
							v13 = columns_map[v5]
							v14 = columns_map[v6]
							v15 = columns_map[v7]
							v16 = columns_map[v8]
							v17 = columns_map[v9]
						end
					else
						v20 = columns_map[v4]
						v13 = columns_map[v5]
						v14 = columns_map[v6]
						v15 = columns_map[v7]
						v16 = columns_map[v8]
					end
				else
					v20 = columns_map[v4]
					v13 = columns_map[v5]
					v14 = columns_map[v6]
					v15 = columns_map[v7]
				end
			else
				v20 = columns_map[v4]
				v13 = columns_map[v5]
				v14 = columns_map[v6]
			end
		else
			v20 = columns_map[v4]
			v13 = columns_map[v5]
		end
	else
		v20 = columns_map[v4]
	end

	local v21

	if v5 then
		if v6 then
			if v7 then
				if v8 then
					if v9 then
						if v10 then
							if v11 then
								if v12 then
									local t = {}
									local v22 = #ids

									v21 = function() --[[ world_query_iter_next | Line: 1385 | Upvalues: entities (ref), v3 (ref), v1 (ref), v2 (ref), compatible_archetypes (copy), columns_map (ref), v20 (ref), v4 (copy), v13 (ref), v5 (copy), v14 (ref), v6 (copy), v15 (ref), v7 (copy), v16 (ref), v8 (copy), v17 (ref), v9 (copy), v18 (ref), v10 (copy), v19 (ref), v11 (copy), v22 (copy), t (copy) ]]
										local v12 = entities[v3]

										while v12 == nil do
											v1 = v1 + 1
											v2 = compatible_archetypes[v1]

											if not v2 then
												return nil
											end

											entities = v2.entities
											v3 = #entities

											if v3 ~= 0 then
												v12 = entities[v3]
												columns_map = v2.columns_map
												v20 = columns_map[v4]
												v13 = columns_map[v5]
												v14 = columns_map[v6]
												v15 = columns_map[v7]
												v16 = columns_map[v8]
												v17 = columns_map[v9]
												v18 = columns_map[v10]
												v19 = columns_map[v11]
											end
										end

										local v23 = v3

										v3 = v3 - 1

										for i = 9, v22 do
											t[i - 8] = columns_map[i][v23]
										end

										return v12, v20[v23], v13[v23], v14[v23], v15[v23], v16[v23], v17[v23], v18[v23], v19[v23], unpack(t)
									end
								else
									v21 = function() --[[ world_query_iter_next | Line: 1351 | Upvalues: entities (ref), v3 (ref), v1 (ref), v2 (ref), compatible_archetypes (copy), columns_map (ref), v20 (ref), v4 (copy), v13 (ref), v5 (copy), v14 (ref), v6 (copy), v15 (ref), v7 (copy), v16 (ref), v8 (copy), v17 (ref), v9 (copy), v18 (ref), v10 (copy), v19 (ref), v11 (copy) ]]
										local v12 = entities[v3]

										while v12 == nil do
											v1 = v1 + 1
											v2 = compatible_archetypes[v1]

											if not v2 then
												return nil
											end

											entities = v2.entities
											v3 = #entities

											if v3 ~= 0 then
												v12 = entities[v3]
												columns_map = v2.columns_map
												v20 = columns_map[v4]
												v13 = columns_map[v5]
												v14 = columns_map[v6]
												v15 = columns_map[v7]
												v16 = columns_map[v8]
												v17 = columns_map[v9]
												v18 = columns_map[v10]
												v19 = columns_map[v11]
											end
										end

										local v22 = v3

										v3 = v3 - 1

										return v12, v20[v22], v13[v22], v14[v22], v15[v22], v16[v22], v17[v22], v18[v22], v19[v22]
									end
								end
							else
								v21 = function() --[[ world_query_iter_next | Line: 1320 | Upvalues: entities (ref), v3 (ref), v1 (ref), v2 (ref), compatible_archetypes (copy), columns_map (ref), v20 (ref), v4 (copy), v13 (ref), v5 (copy), v14 (ref), v6 (copy), v15 (ref), v7 (copy), v16 (ref), v8 (copy), v17 (ref), v9 (copy), v18 (ref), v10 (copy) ]]
									local v12 = entities[v3]

									while v12 == nil do
										v1 = v1 + 1
										v2 = compatible_archetypes[v1]

										if not v2 then
											return nil
										end

										entities = v2.entities
										v3 = #entities

										if v3 ~= 0 then
											v12 = entities[v3]
											columns_map = v2.columns_map
											v20 = columns_map[v4]
											v13 = columns_map[v5]
											v14 = columns_map[v6]
											v15 = columns_map[v7]
											v16 = columns_map[v8]
											v17 = columns_map[v9]
											v18 = columns_map[v10]
										end
									end

									local v22 = v3

									v3 = v3 - 1

									return v12, v20[v22], v13[v22], v14[v22], v15[v22], v16[v22], v17[v22], v18[v22]
								end
							end
						else
							v21 = function() --[[ world_query_iter_next | Line: 1290 | Upvalues: entities (ref), v3 (ref), v1 (ref), v2 (ref), compatible_archetypes (copy), columns_map (ref), v20 (ref), v4 (copy), v13 (ref), v5 (copy), v14 (ref), v6 (copy), v15 (ref), v7 (copy), v16 (ref), v8 (copy), v17 (ref), v9 (copy) ]]
								local v12 = entities[v3]

								while v12 == nil do
									v1 = v1 + 1
									v2 = compatible_archetypes[v1]

									if not v2 then
										return nil
									end

									entities = v2.entities
									v3 = #entities

									if v3 ~= 0 then
										v12 = entities[v3]
										columns_map = v2.columns_map
										v20 = columns_map[v4]
										v13 = columns_map[v5]
										v14 = columns_map[v6]
										v15 = columns_map[v7]
										v16 = columns_map[v8]
										v17 = columns_map[v9]
									end
								end

								local v22 = v3

								v3 = v3 - 1

								return v12, v20[v22], v13[v22], v14[v22], v15[v22], v16[v22], v17[v22]
							end
						end
					else
						v21 = function() --[[ world_query_iter_next | Line: 1261 | Upvalues: entities (ref), v3 (ref), v1 (ref), v2 (ref), compatible_archetypes (copy), columns_map (ref), v20 (ref), v4 (copy), v13 (ref), v5 (copy), v14 (ref), v6 (copy), v15 (ref), v7 (copy), v16 (ref), v8 (copy) ]]
							local v12 = entities[v3]

							while v12 == nil do
								v1 = v1 + 1
								v2 = compatible_archetypes[v1]

								if not v2 then
									return nil
								end

								entities = v2.entities
								v3 = #entities

								if v3 ~= 0 then
									v12 = entities[v3]
									columns_map = v2.columns_map
									v20 = columns_map[v4]
									v13 = columns_map[v5]
									v14 = columns_map[v6]
									v15 = columns_map[v7]
									v16 = columns_map[v8]
								end
							end

							local v22 = v3

							v3 = v3 - 1

							return v12, v20[v22], v13[v22], v14[v22], v15[v22], v16[v22]
						end
					end
				else
					v21 = function() --[[ world_query_iter_next | Line: 1233 | Upvalues: entities (ref), v3 (ref), v1 (ref), v2 (ref), compatible_archetypes (copy), columns_map (ref), v20 (ref), v4 (copy), v13 (ref), v5 (copy), v14 (ref), v6 (copy), v15 (ref), v7 (copy) ]]
						local v12 = entities[v3]

						while v12 == nil do
							v1 = v1 + 1
							v2 = compatible_archetypes[v1]

							if not v2 then
								return nil
							end

							entities = v2.entities
							v3 = #entities

							if v3 ~= 0 then
								v12 = entities[v3]
								columns_map = v2.columns_map
								v20 = columns_map[v4]
								v13 = columns_map[v5]
								v14 = columns_map[v6]
								v15 = columns_map[v7]
							end
						end

						local v22 = v3

						v3 = v3 - 1

						return v12, v20[v22], v13[v22], v14[v22], v15[v22]
					end
				end
			else
				v21 = function() --[[ world_query_iter_next | Line: 1206 | Upvalues: entities (ref), v3 (ref), v1 (ref), v2 (ref), compatible_archetypes (copy), columns_map (ref), v20 (ref), v4 (copy), v13 (ref), v5 (copy), v14 (ref), v6 (copy) ]]
					local v12 = entities[v3]

					while v12 == nil do
						v1 = v1 + 1
						v2 = compatible_archetypes[v1]

						if not v2 then
							return nil
						end

						entities = v2.entities
						v3 = #entities

						if v3 ~= 0 then
							v12 = entities[v3]
							columns_map = v2.columns_map
							v20 = columns_map[v4]
							v13 = columns_map[v5]
							v14 = columns_map[v6]
						end
					end

					local v22 = v3

					v3 = v3 - 1

					return v12, v20[v22], v13[v22], v14[v22]
				end
			end
		else
			v21 = function() --[[ world_query_iter_next | Line: 1180 | Upvalues: entities (ref), v3 (ref), v1 (ref), v2 (ref), compatible_archetypes (copy), columns_map (ref), v20 (ref), v4 (copy), v13 (ref), v5 (copy) ]]
				local v12 = entities[v3]

				while v12 == nil do
					v1 = v1 + 1
					v2 = compatible_archetypes[v1]

					if not v2 then
						return nil
					end

					entities = v2.entities
					v3 = #entities

					if v3 ~= 0 then
						v12 = entities[v3]
						columns_map = v2.columns_map
						v20 = columns_map[v4]
						v13 = columns_map[v5]
					end
				end

				local v22 = v3

				v3 = v3 - 1

				return v12, v20[v22], v13[v22]
			end
		end
	else
		v21 = function() --[[ world_query_iter_next | Line: 1155 | Upvalues: entities (ref), v3 (ref), v1 (ref), v2 (ref), compatible_archetypes (copy), columns_map (ref), v20 (ref), v4 (copy) ]]
			local v12 = entities[v3]

			while v12 == nil do
				v1 = v1 + 1
				v2 = compatible_archetypes[v1]

				if not v2 then
					return nil
				end

				entities = v2.entities
				v3 = #entities

				if v3 ~= 0 then
					v12 = entities[v3]
					columns_map = v2.columns_map
					v20 = columns_map[v4]
				end
			end

			local v22 = v3

			v3 = v3 - 1

			return v12, v20[v22]
		end
	end

	p1.next = v21

	return v21
end

local function query_iter(p1) --[[ query_iter | Line: 1426 | Upvalues: query_iter_init (copy) ]]
	local v1 = p1.next

	if not v1 then
		v1 = query_iter_init(p1)
	end

	return v1
end

local function query_without(p1, ...) --[[ query_without | Line: 1434 ]]
	local t = { ... }

	p1.filter_without = t

	local compatible_archetypes = p1.compatible_archetypes

	for i = #compatible_archetypes, 1, -1 do
		local columns_map = compatible_archetypes[i].columns_map
		local v1 = true

		for v2, v3 in t do
			if columns_map[v3] then
				v1 = false

				break
			end
		end

		if not v1 then
			local v4 = #compatible_archetypes

			if v4 ~= i then
				compatible_archetypes[i] = compatible_archetypes[v4]
			end

			compatible_archetypes[v4] = nil
		end
	end

	return p1
end

local function query_with(p1, ...) --[[ query_with | Line: 1464 ]]
	local compatible_archetypes = p1.compatible_archetypes
	local t = { ... }

	p1.filter_with = t

	for i = #compatible_archetypes, 1, -1 do
		local columns_map = compatible_archetypes[i].columns_map
		local v1 = true

		for v2, v3 in t do
			if not columns_map[v3] then
				v1 = false

				break
			end
		end

		if not v1 then
			local v4 = #compatible_archetypes

			if v4 ~= i then
				compatible_archetypes[i] = compatible_archetypes[v4]
			end

			compatible_archetypes[v4] = nil
		end
	end

	return p1
end

local function query_archetypes(p1) --[[ query_archetypes | Line: 1498 ]]
	return p1.compatible_archetypes
end

local function query_cached(p1) --[[ query_cached | Line: 1502 | Upvalues: NOOP (copy), query_archetypes (copy) ]]
	local filter_with = p1.filter_with
	local ids = p1.ids

	if filter_with then
		table.move(ids, 1, #ids, #filter_with + 1, filter_with)
	else
		p1.filter_with = ids
	end

	local compatible_archetypes = p1.compatible_archetypes
	local v1 = 1
	local v2, v3, v4, v5, v6, v7, v8, v9, v10 = unpack(ids)
	local v11 = nil
	local v12 = nil
	local v13 = nil
	local v14 = nil
	local v15 = nil
	local v16 = nil
	local v17 = nil
	local v18 = nil
	local v19 = nil
	local v20 = nil
	local v21 = nil
	local v22 = nil
	local v23 = nil
	local compatible_archetypes2 = p1.compatible_archetypes
	local observable = p1.world.observable
	local v24 = observable[268]

	if not v24 then
		v24 = {}
		observable[268] = v24
	end

	local v25 = v24[v2]

	if not v25 then
		v25 = {}
		v24[v2] = v25
	end

	local v26 = observable[269]

	if not v26 then
		v26 = {}
		observable[269] = v26
	end

	local v27 = v26[v2]

	if not v27 then
		v27 = {}
		v26[v2] = v27
	end

	local function on_create_callback(p1) --[[ on_create_callback | Line: 1551 | Upvalues: compatible_archetypes2 (copy) ]]
		table.insert(compatible_archetypes2, p1)
	end

	local t = {
		query = p1,
		callback = function(p1) --[[ on_delete_callback | Line: 1555 | Upvalues: compatible_archetypes2 (copy) ]]
			local v1 = table.find(compatible_archetypes2, p1)

			if v1 ~= nil then
				local v2 = #compatible_archetypes2

				compatible_archetypes2[v1] = compatible_archetypes2[v2]
				compatible_archetypes2[v2] = nil
			end
		end
	}

	table.insert(v25, {
		query = p1,
		callback = on_create_callback
	})
	table.insert(v27, t)

	local function cached_query_iter() --[[ cached_query_iter | Line: 1571 | Upvalues: v1 (ref), v22 (ref), compatible_archetypes (copy), NOOP (ref), v20 (ref), v21 (ref), v23 (ref), v3 (copy), v11 (ref), v2 (copy), v4 (copy), v12 (ref), v5 (copy), v13 (ref), v6 (copy), v14 (ref), v7 (copy), v15 (ref), v8 (copy), v16 (ref), v9 (copy), v17 (ref), v18 (ref), v19 (ref) ]]
		v1 = 1
		v22 = compatible_archetypes[v1]

		if not v22 then
			return NOOP
		end

		v20 = v22.entities
		v21 = #v20
		v23 = v22.columns_map

		if v3 then
			if v4 then
				if v5 then
					if v6 then
						if v7 then
							if v8 then
								if v9 then
									v11 = v23[v2]
									v12 = v23[v3]
									v13 = v23[v4]
									v14 = v23[v5]
									v15 = v23[v6]
									v16 = v23[v7]
									v17 = v23[v8]
									v18 = v23[v9]
								else
									v11 = v23[v2]
									v12 = v23[v3]
									v13 = v23[v4]
									v14 = v23[v5]
									v15 = v23[v6]
									v16 = v23[v7]
									v17 = v23[v8]
								end
							else
								v11 = v23[v2]
								v12 = v23[v3]
								v13 = v23[v4]
								v14 = v23[v5]
								v15 = v23[v6]
								v16 = v23[v7]
							end
						else
							v11 = v23[v2]
							v12 = v23[v3]
							v13 = v23[v4]
							v14 = v23[v5]
							v15 = v23[v6]
						end
					else
						v11 = v23[v2]
						v12 = v23[v3]
						v13 = v23[v4]
						v14 = v23[v5]
					end
				else
					v11 = v23[v2]
					v12 = v23[v3]
					v13 = v23[v4]
				end
			else
				v11 = v23[v2]
				v12 = v23[v3]
			end
		else
			v11 = v23[v2]
		end

		return v19
	end

	if v3 then
		if v4 then
			if v5 then
				if v6 then
					if v7 then
						if v8 then
							if v9 then
								if v10 then
									local t2 = {}
									local v28 = #ids

									_ = function() --[[ world_query_iter_next | Line: 1860 | Upvalues: v20 (ref), v21 (ref), v1 (ref), v22 (ref), compatible_archetypes (copy), v23 (ref), v11 (ref), v2 (copy), v12 (ref), v3 (copy), v13 (ref), v4 (copy), v14 (ref), v5 (copy), v15 (ref), v6 (copy), v16 (ref), v7 (copy), v17 (ref), v8 (copy), v18 (ref), v9 (copy), v28 (copy), t2 (copy) ]]
										local v19 = v20[v21]

										while v19 == nil do
											v1 = v1 + 1
											v22 = compatible_archetypes[v1]

											if not v22 then
												return nil
											end

											v20 = v22.entities
											v21 = #v20

											if v21 ~= 0 then
												v19 = v20[v21]
												v23 = v22.columns_map
												v11 = v23[v2]
												v12 = v23[v3]
												v13 = v23[v4]
												v14 = v23[v5]
												v15 = v23[v6]
												v16 = v23[v7]
												v17 = v23[v8]
												v18 = v23[v9]
											end
										end

										local v24 = v21

										v21 = v21 - 1

										for i = 9, v28 do
											t2[i - 8] = v23[i][v24]
										end

										return v19, v11[v24], v12[v24], v13[v24], v14[v24], v15[v24], v16[v24], v17[v24], unpack(t2)
									end
								else
									_ = function() --[[ world_query_iter_next | Line: 1826 | Upvalues: v20 (ref), v21 (ref), v1 (ref), v22 (ref), compatible_archetypes (copy), v23 (ref), v11 (ref), v2 (copy), v12 (ref), v3 (copy), v13 (ref), v4 (copy), v14 (ref), v5 (copy), v15 (ref), v6 (copy), v16 (ref), v7 (copy), v17 (ref), v8 (copy), v18 (ref), v9 (copy) ]]
										local v19 = v20[v21]

										while v19 == nil do
											v1 = v1 + 1
											v22 = compatible_archetypes[v1]

											if not v22 then
												return nil
											end

											v20 = v22.entities
											v21 = #v20

											if v21 ~= 0 then
												v19 = v20[v21]
												v23 = v22.columns_map
												v11 = v23[v2]
												v12 = v23[v3]
												v13 = v23[v4]
												v14 = v23[v5]
												v15 = v23[v6]
												v16 = v23[v7]
												v17 = v23[v8]
												v18 = v23[v9]
											end
										end

										local v24 = v21

										v21 = v21 - 1

										return v19, v11[v24], v12[v24], v13[v24], v14[v24], v15[v24], v16[v24], v17[v24], v18[v24]
									end
								end
							else
								_ = function() --[[ world_query_iter_next | Line: 1795 | Upvalues: v20 (ref), v21 (ref), v1 (ref), v22 (ref), compatible_archetypes (copy), v23 (ref), v11 (ref), v2 (copy), v12 (ref), v3 (copy), v13 (ref), v4 (copy), v14 (ref), v5 (copy), v15 (ref), v6 (copy), v16 (ref), v7 (copy), v17 (ref), v8 (copy) ]]
									local v18 = v20[v21]

									while v18 == nil do
										v1 = v1 + 1
										v22 = compatible_archetypes[v1]

										if not v22 then
											return nil
										end

										v20 = v22.entities
										v21 = #v20

										if v21 ~= 0 then
											v18 = v20[v21]
											v23 = v22.columns_map
											v11 = v23[v2]
											v12 = v23[v3]
											v13 = v23[v4]
											v14 = v23[v5]
											v15 = v23[v6]
											v16 = v23[v7]
											v17 = v23[v8]
										end
									end

									local v24 = v21

									v21 = v21 - 1

									return v18, v11[v24], v12[v24], v13[v24], v14[v24], v15[v24], v16[v24], v17[v24]
								end
							end
						else
							_ = function() --[[ world_query_iter_next | Line: 1765 | Upvalues: v20 (ref), v21 (ref), v1 (ref), v22 (ref), compatible_archetypes (copy), v23 (ref), v11 (ref), v2 (copy), v12 (ref), v3 (copy), v13 (ref), v4 (copy), v14 (ref), v5 (copy), v15 (ref), v6 (copy), v16 (ref), v7 (copy) ]]
								local v17 = v20[v21]

								while v17 == nil do
									v1 = v1 + 1
									v22 = compatible_archetypes[v1]

									if not v22 then
										return nil
									end

									v20 = v22.entities
									v21 = #v20

									if v21 ~= 0 then
										v17 = v20[v21]
										v23 = v22.columns_map
										v11 = v23[v2]
										v12 = v23[v3]
										v13 = v23[v4]
										v14 = v23[v5]
										v15 = v23[v6]
										v16 = v23[v7]
									end
								end

								local v24 = v21

								v21 = v21 - 1

								return v17, v11[v24], v12[v24], v13[v24], v14[v24], v15[v24], v16[v24]
							end
						end
					else
						_ = function() --[[ world_query_iter_next | Line: 1736 | Upvalues: v20 (ref), v21 (ref), v1 (ref), v22 (ref), compatible_archetypes (copy), v23 (ref), v11 (ref), v2 (copy), v12 (ref), v3 (copy), v13 (ref), v4 (copy), v14 (ref), v5 (copy), v15 (ref), v6 (copy) ]]
							local v16 = v20[v21]

							while v16 == nil do
								v1 = v1 + 1
								v22 = compatible_archetypes[v1]

								if not v22 then
									return nil
								end

								v20 = v22.entities
								v21 = #v20

								if v21 ~= 0 then
									v16 = v20[v21]
									v23 = v22.columns_map
									v11 = v23[v2]
									v12 = v23[v3]
									v13 = v23[v4]
									v14 = v23[v5]
									v15 = v23[v6]
								end
							end

							local v24 = v21

							v21 = v21 - 1

							return v16, v11[v24], v12[v24], v13[v24], v14[v24], v15[v24]
						end
					end
				else
					_ = function() --[[ world_query_iter_next | Line: 1708 | Upvalues: v20 (ref), v21 (ref), v1 (ref), v22 (ref), compatible_archetypes (copy), v23 (ref), v11 (ref), v2 (copy), v12 (ref), v3 (copy), v13 (ref), v4 (copy), v14 (ref), v5 (copy) ]]
						local v15 = v20[v21]

						while v15 == nil do
							v1 = v1 + 1
							v22 = compatible_archetypes[v1]

							if not v22 then
								return nil
							end

							v20 = v22.entities
							v21 = #v20

							if v21 ~= 0 then
								v15 = v20[v21]
								v23 = v22.columns_map
								v11 = v23[v2]
								v12 = v23[v3]
								v13 = v23[v4]
								v14 = v23[v5]
							end
						end

						local v24 = v21

						v21 = v21 - 1

						return v15, v11[v24], v12[v24], v13[v24], v14[v24]
					end
				end
			else
				_ = function() --[[ world_query_iter_next | Line: 1681 | Upvalues: v20 (ref), v21 (ref), v1 (ref), v22 (ref), compatible_archetypes (copy), v23 (ref), v11 (ref), v2 (copy), v12 (ref), v3 (copy), v13 (ref), v4 (copy) ]]
					local v14 = v20[v21]

					while v14 == nil do
						v1 = v1 + 1
						v22 = compatible_archetypes[v1]

						if not v22 then
							return nil
						end

						v20 = v22.entities
						v21 = #v20

						if v21 ~= 0 then
							v14 = v20[v21]
							v23 = v22.columns_map
							v11 = v23[v2]
							v12 = v23[v3]
							v13 = v23[v4]
						end
					end

					local v24 = v21

					v21 = v21 - 1

					return v14, v11[v24], v12[v24], v13[v24]
				end
			end
		else
			_ = function() --[[ world_query_iter_next | Line: 1655 | Upvalues: v20 (ref), v21 (ref), v1 (ref), v22 (ref), compatible_archetypes (copy), v23 (ref), v11 (ref), v2 (copy), v12 (ref), v3 (copy) ]]
				local v13 = v20[v21]

				while v13 == nil do
					v1 = v1 + 1
					v22 = compatible_archetypes[v1]

					if not v22 then
						return nil
					end

					v20 = v22.entities
					v21 = #v20

					if v21 ~= 0 then
						v13 = v20[v21]
						v23 = v22.columns_map
						v11 = v23[v2]
						v12 = v23[v3]
					end
				end

				local v24 = v21

				v21 = v21 - 1

				return v13, v11[v24], v12[v24]
			end
		end
	else
		_ = function() --[[ world_query_iter_next | Line: 1630 | Upvalues: v20 (ref), v21 (ref), v1 (ref), v22 (ref), compatible_archetypes (copy), v23 (ref), v11 (ref), v2 (copy) ]]
			local v12 = v20[v21]

			while v12 == nil do
				v1 = v1 + 1
				v22 = compatible_archetypes[v1]

				if not v22 then
					return nil
				end

				v20 = v22.entities
				v21 = #v20

				if v21 ~= 0 then
					v12 = v20[v21]
					v23 = v22.columns_map
					v11 = v23[v2]
				end
			end

			local v24 = v21

			v21 = v21 - 1

			return v12, v11[v24]
		end
	end

	p1.archetypes = query_archetypes
	p1.__iter = cached_query_iter
	p1.iter = cached_query_iter
	setmetatable(p1, p1)

	return p1
end

local t2 = {}

t2.__index = t2
t2.__iter = query_iter
t2.iter = query_iter_init
t2.without = query_without
t2.with = query_with
t2.archetypes = query_archetypes
t2.cached = query_cached

local function world_query(p1, ...) --[[ world_query | Line: 1914 | Upvalues: t2 (copy) ]]
	local t = {}
	local t3 = { ... }
	local archetypes = p1.archetypes
	local component_index = p1.component_index
	local v2 = setmetatable({
		ids = t3,
		compatible_archetypes = t,
		world = p1
	}, t2)
	local v3 = nil
	local count = 0

	for v4, v5 in t3 do
		local v6 = component_index[v5]

		if not v6 then
			return v2
		end

		if v3 == nil or v6.size < v3.size then
			v3 = v6
		end
	end

	if v3 == nil then
		return v2
	end

	for v7 in v3.records do
		local v8 = archetypes[v7]

		if #v8.entities ~= 0 then
			local columns_map = v8.columns_map
			local v9 = false

			for v10, v11 in t3 do
				if not columns_map[v11] then
					v9 = true

					break
				end
			end

			if not v9 then
				count = count + 1
				t[count] = v8
			end
		end
	end

	return v2
end

local function world_each(p1, p2) --[[ world_each | Line: 1974 | Upvalues: NOOP (copy) ]]
	local v1 = p1.component_index[p2]

	if not v1 then
		return NOOP
	end

	local records = v1.records
	local archetypes = p1.archetypes
	local v2 = next(records, nil)
	local v3 = archetypes[v2]

	if v3 then
		local entities = v3.entities
		local v4 = #entities

		return function() --[[ Line: 1991 | Upvalues: entities (ref), v4 (ref), v2 (ref), records (copy), v3 (ref), archetypes (copy) ]]
			local v1 = entities[v4]

			while not v1 do
				v2 = next(records, v2)

				if not v2 then
					return
				end

				v3 = archetypes[v2]
				entities = v3.entities
				v4 = #entities
				v1 = entities[v4]
			end

			v4 = v4 - 1

			return v1
		end
	end

	return NOOP
end

local function world_children(p1, p2) --[[ world_children | Line: 2008 | Upvalues: NOOP (copy) ]]
	local v1 = p1.component_index[p2 % 16777216 + 4378853376 + 281474976710656]

	if not v1 then
		return NOOP
	end

	local records = v1.records
	local archetypes = p1.archetypes
	local v2 = next(records, nil)
	local v3 = archetypes[v2]

	if v3 then
		local entities = v3.entities
		local v4 = #entities

		return function() --[[ Line: 1991 | Upvalues: entities (ref), v4 (ref), v2 (ref), records (copy), v3 (ref), archetypes (copy) ]]
			local v1 = entities[v4]

			while not v1 do
				v2 = next(records, v2)

				if not v2 then
					return
				end

				v3 = archetypes[v2]
				entities = v3.entities
				v4 = #entities
				v1 = entities[v4]
			end

			v4 = v4 - 1

			return v1
		end
	end

	return NOOP
end

local function ecs_bulk_insert(p1, p2, p3, p4) --[[ ecs_bulk_insert | Line: 2012 | Upvalues: archetype_register (copy), archetype_create (copy), archetype_move (copy) ]]
	local entity_index = p1.entity_index
	local v1 = entity_index.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil
	local v3

	if v2 then
		local dense = v2.dense

		v3 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= p2 then nil else v2
	else
		v3 = v2
	end

	if not v3 then
		return
	end

	local archetype = v3.archetype
	local component_index = p1.component_index

	if archetype then
		local v4 = table.clone(archetype.types)
		local t = {}

		for v6, v7 in p3 do
			local v5

			do
				local __inline_returned = false

				for v8, v9 in v4 do
					if v9 == v7 then
						v5 = -1
						__inline_returned = true

						break
					elseif v7 < v9 then
						v5 = v8
						__inline_returned = true

						break
					end
				end

				if not __inline_returned then
					v5 = #v4 + 1
				end
			end

			if v5 == -1 then
				t[v6] = true

				continue
			end

			t[v6] = false
			table.insert(v4, v5, v7)
		end

		local v10

		if #v4 < 1 then
			v10 = p1.ROOT_ARCHETYPE
		else
			local v11 = table.concat(v4, "_")
			local v12 = p1.archetype_index[v11]

			if v12 then
				if v12.dead then
					archetype_register(p1, v12)
					v12.dead = false
				end

				v10 = v12
			else
				v10 = archetype_create(p1, v4, v11)
			end
		end

		local columns_map = v10.columns_map

		if archetype ~= v10 then
			local entities = v10.entities
			local v14 = #entities + 1

			entities[v14] = p2
			archetype_move(entity_index, p2, v10, v14, v3.archetype, v3.row)
			v3.archetype = v10
			v3.row = v14
		end

		local row = v3.row

		for v15, v16 in t do
			local v17 = p3[v15]
			local v18 = component_index[v17]
			local v19 = p4[v15]
			local on_add = v18.on_add

			if v19 == nil then
				if on_add then
					on_add(p2, v17)
				end

				continue
			end

			columns_map[v17][row] = v19

			local v20 = if v16 then v18.on_change else on_add

			if v20 then
				v20(p2, v17, v19)
			end
		end
	else
		local v21

		if #p3 < 1 then
			v21 = p1.ROOT_ARCHETYPE
		else
			local v22 = table.concat(p3, "_")
			local v23 = p1.archetype_index[v22]

			if v23 then
				if v23.dead then
					archetype_register(p1, v23)
					v23.dead = false
				end

				v21 = v23
			else
				v21 = archetype_create(p1, p3, v22)
			end
		end

		local entities = v21.entities
		local v25 = #entities + 1

		entities[v25] = p2
		v3.archetype = v21
		v3.row = v25

		local row = v3.row
		local columns_map = v21.columns_map

		for v26, v27 in p3 do
			local v28 = p4[v26]
			local on_add = component_index[v27].on_add

			if v28 then
				columns_map[v27][row] = v28

				if on_add then
					on_add(p2, v27, v28)
				end

				continue
			end

			if on_add then
				on_add(p2, v27)
			end
		end
	end
end

local function ecs_bulk_remove(p1, p2, p3) --[[ ecs_bulk_remove | Line: 2090 | Upvalues: archetype_register (copy), archetype_create (copy), archetype_move (copy) ]]
	local entity_index = p1.entity_index
	local v1 = entity_index.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil
	local v3

	if v2 then
		local dense = v2.dense

		v3 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= p2 then nil else v2
	else
		v3 = v2
	end

	if not v3 then
		return
	end

	local archetype = v3.archetype
	local component_index = p1.component_index

	if not archetype then
		return
	end

	local columns_map = archetype.columns_map
	local t = {}

	for v4, v5 in p3 do
		if columns_map[v5] then
			t[v5] = true

			local on_remove = component_index[v5].on_remove

			if on_remove then
				on_remove(p2, v5)
			end
		end
	end

	local archetype2 = v3.archetype

	if archetype ~= archetype2 then
		archetype = archetype2
	end

	local v6 = table.clone(archetype.types)

	for v7 in t do
		table.remove(v6, (table.find(v6, v7)))
	end

	local v9

	if #v6 < 1 then
		v9 = p1.ROOT_ARCHETYPE
	else
		local v10 = table.concat(v6, "_")
		local v11 = p1.archetype_index[v10]

		if v11 then
			if v11.dead then
				archetype_register(p1, v11)
				v11.dead = false
			end

			v9 = v11
		else
			v9 = archetype_create(p1, v6, v10)
		end
	end

	if archetype == v9 then
		return
	end

	local entities = v9.entities
	local v13 = #entities + 1

	entities[v13] = p2
	archetype_move(entity_index, p2, v9, v13, v3.archetype, v3.row)
	v3.archetype = v9
	v3.row = v13
end

return {
	world = function() --[[ world_new | Line: 2138 | Upvalues: v3 (ref), archetype_create (copy), v1 (copy), archetype_register (copy), entity_index_new_id (copy), archetype_delete (copy), archetype_destroy (copy), archetype_move (copy), world_query (copy), world_component (copy), world_each (copy), world_children (copy), world_range (copy), v4 (ref), t (ref), v2 (copy) ]]
		local t2 = {}
		local t3 = {}
		local t4 = {
			alive_count = 0,
			max_id = 0,
			dense_array = t2,
			sparse_array = t3
		}
		local t5 = {}
		local t6 = {}
		local t7 = {}
		local t8 = {}
		local t9 = {
			ROOT_ARCHETYPE = nil,
			max_archetype_id = 0,
			archetype_edges = t8,
			component_index = t5,
			entity_index = t4,
			archetypes = t7,
			archetype_index = t6,
			max_component_id = v3,
			observable = {}
		}
		local v12 = archetype_create(t9, {}, "")

		t9.ROOT_ARCHETYPE = v12

		local function inner_entity_index_try_get_any(p1) --[[ inner_entity_index_try_get_any | Line: 2178 | Upvalues: t3 (copy) ]]
			local v1 = t3[p1 % 16777216]

			if v1 and v1.dense ~= 0 then
				return v1
			end

			return nil
		end

		local function inner_archetype_move(p1, p2, p3, p4, p5) --[[ inner_archetype_move | Line: 2188 | Upvalues: v1 (ref), t3 (copy) ]]
			local columns = p4.columns
			local entities2 = p4.entities
			local v12 = #entities2
			local types = p4.types
			local columns_map = p2.columns_map

			if p5 == v12 then
				for v2, v3 in columns do
					if v3 ~= v1 then
						local v4 = columns_map[types[v2]]

						if v4 then
							v4[p3] = v3[p5]
						end

						v3[v12] = nil
					end
				end
			else
				for v5, v6 in columns do
					if v6 ~= v1 then
						local v7 = columns_map[types[v5]]

						if v7 then
							v7[p3] = v6[p5]
						end

						v6[p5] = v6[v12]
						v6[v12] = nil
					end
				end

				local v8 = entities2[v12]

				entities2[p5] = v8
				t3[v8 % 16777216].row = p5
			end

			entities2[v12] = nil
			p2.entities[p3] = p1
		end

		local function inner_entity_move(p1, p2, p3, p4) --[[ inner_entity_move | Line: 2244 | Upvalues: inner_archetype_move (copy) ]]
			local entities = p4.entities
			local v1 = #entities + 1

			entities[v1] = p2
			inner_archetype_move(p2, p4, v1, p3.archetype, p3.row)
			p3.archetype = p4
			p3.row = v1
		end

		local function inner_entity_index_try_get_unsafe(p1) --[[ inner_entity_index_try_get_unsafe | Line: 2272 | Upvalues: t3 (copy), t2 (copy) ]]
			local v1 = t3[p1 % 16777216]
			local v2 = if v1 and v1.dense ~= 0 then v1 else nil

			if v2 and t2[v2.dense] ~= p1 then
				return nil
			end

			return v2
		end

		local function inner_world_add(p1, p2, p3) --[[ inner_world_add | Line: 2286 | Upvalues: t3 (copy), t2 (copy), v12 (copy), t8 (copy), t5 (copy), archetype_register (ref), archetype_create (ref), inner_archetype_move (copy) ]]
			local entity_index = p1.entity_index
			local v1 = t3[p2 % 16777216]
			local v2 = if v1 and v1.dense ~= 0 then v1 else nil
			local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

			if not v3 then
				return
			end

			local archetype = v3.archetype

			if if p3 > 281474976710656 then true else false then
				local v5 = if archetype then archetype else v12
				local v6 = t8[v5.id]
				local v7 = v6[p3]
				local v8

				if v7 then
					if v7.dead then
						archetype_register(p1, v7)
						v7.dead = false
					end

					v8 = t5[p3]
				else
					v8 = t5[260 + (p3 - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656]

					local v9, v10, v11, v122, v13, v14

					if v8 then
						if bit32.btest(v8.flags, 4) then
							local v15 = v8.records[v5.id]

							if v15 then
								local on_remove = v8.on_remove
								local types = v5.types

								if on_remove then
									on_remove(p2, types[v15])

									local archetype2 = v3.archetype

									types = archetype2.types
									v15 = v8.records[archetype2.id]
								end

								local v16 = table.clone(types)

								v16[v15] = p3

								if #v16 < 1 then
									v7 = p1.ROOT_ARCHETYPE
								else
									local v17 = table.concat(v16, "_")
									local v18 = p1.archetype_index[v17]

									if v18 then
										if v18.dead then
											archetype_register(p1, v18)
											v18.dead = false
										end

										v7 = v18
									else
										v7 = archetype_create(p1, v16, v17)
									end
								end
							else
								local types = v5.types
								local v20 = table.clone(types)
								local v21

								do
									local __inline_returned = false

									for v22, v23 in types do
										if v23 == p3 then
											v21 = -1
											__inline_returned = true

											break
										elseif p3 < v23 then
											v21 = v22
											__inline_returned = true

											break
										end
									end

									if not __inline_returned then
										v21 = #types + 1
									end
								end

								table.insert(v20, v21, p3)

								if #v20 < 1 then
									v7 = p1.ROOT_ARCHETYPE
								else
									local v24 = table.concat(v20, "_")
									local v25 = p1.archetype_index[v24]

									if v25 then
										if v25.dead then
											archetype_register(p1, v25)
											v25.dead = false
										end

										v7 = v25
									else
										v7 = archetype_create(p1, v20, v24)
									end
								end

								v8 = t5[p3]
							end
						else
							v9 = v5.types
							v10 = table.clone(v9)

							do
								local __inline_returned = false

								for v27, v28 in v9 do
									if v28 == p3 then
										v11 = -1
										__inline_returned = true

										break
									elseif p3 < v28 then
										v11 = v27
										__inline_returned = true

										break
									end
								end

								if not __inline_returned then
									v11 = #v9 + 1
								end
							end

							table.insert(v10, v11, p3)

							if #v10 < 1 then
								v7 = p1.ROOT_ARCHETYPE
							else
								v122 = table.concat(v10, "_")
								v13 = p1.archetype_index[v122]

								if v13 then
									if v13.dead then
										archetype_register(p1, v13)
										v13.dead = false
									end

									v7 = v13
								else
									v14 = archetype_create(p1, v10, v122)
									v7 = v14
								end
							end

							v8 = t5[p3]
						end
					else
						v9 = v5.types
						v10 = table.clone(v9)

						do
							local __inline_returned = false

							for v27, v28 in v9 do
								if v28 == p3 then
									v11 = -1
									__inline_returned = true

									break
								elseif p3 < v28 then
									v11 = v27
									__inline_returned = true

									break
								end
							end

							if not __inline_returned then
								v11 = #v9 + 1
							end
						end

						table.insert(v10, v11, p3)

						if #v10 < 1 then
							v7 = p1.ROOT_ARCHETYPE
						else
							v122 = table.concat(v10, "_")
							v13 = p1.archetype_index[v122]

							if v13 then
								if v13.dead then
									archetype_register(p1, v13)
									v13.dead = false
								end

								v7 = v13
							else
								v14 = archetype_create(p1, v10, v122)
								v7 = v14
							end
						end

						v8 = t5[p3]
					end

					v6[p3] = v7
				end

				if archetype == v7 then
					return
				end

				if archetype then
					local entities = v7.entities
					local v29 = #entities + 1

					entities[v29] = p2
					inner_archetype_move(p2, v7, v29, v3.archetype, v3.row)
					v3.archetype = v7
					v3.row = v29
				elseif #v7.types > 0 then
					local entities = v7.entities
					local v30 = #entities + 1

					entities[v30] = p2
					v3.archetype = v7
					v3.row = v30
				end

				local on_add = v8.on_add

				if not on_add then
					return
				end

				on_add(p2, p3)
			else
				local v31 = if archetype then archetype else p1.ROOT_ARCHETYPE
				local v32

				if v31.columns_map[p3] then
					v32 = v31
				else
					local archetype_edges = p1.archetype_edges
					local v33 = archetype_edges[v31.id]
					local v34 = v33[p3]

					if not v34 then
						local types = v31.types
						local v35 = table.clone(types)
						local v37

						do
							local __inline_returned = false

							for v38, v39 in types do
								if v39 == p3 then
									v37 = -1
									__inline_returned = true

									break
								elseif p3 < v39 then
									v37 = v38
									__inline_returned = true

									break
								end
							end

							if not __inline_returned then
								v37 = #types + 1
							end
						end

						table.insert(v35, v37, p3)

						if #v35 < 1 then
							v34 = p1.ROOT_ARCHETYPE
						else
							local v40 = table.concat(v35, "_")
							local v41 = p1.archetype_index[v40]

							if v41 then
								if v41.dead then
									archetype_register(p1, v41)
									v41.dead = false
								end

								v34 = v41
							else
								v34 = archetype_create(p1, v35, v40)
							end
						end

						v33[p3] = v34
						archetype_edges[v34.id][p3] = v31
					end

					v32 = v34
				end

				if archetype == v32 then
					return
				end

				if archetype then
					local entities = v32.entities
					local v43 = #entities + 1

					entities[v43] = p2
					inner_archetype_move(p2, v32, v43, v3.archetype, v3.row)
					v3.archetype = v32
					v3.row = v43
				elseif #v32.types > 0 then
					local entities = v32.entities
					local v44 = #entities + 1

					entities[v44] = p2
					v3.archetype = v32
					v3.row = v44
				end

				local on_add = t5[p3].on_add

				if not on_add then
					return
				end

				on_add(p2, p3)
			end
		end

		local function inner_world_get(p1, p2, p3, p4, p5, p6, p7) --[[ inner_world_get | Line: 2376 | Upvalues: t3 (copy), t2 (copy) ]]
			local v1 = t3[p2 % 16777216]
			local v2 = if v1 and v1.dense ~= 0 then v1 else nil
			local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

			if not v3 then
				return nil
			end

			local archetype = v3.archetype

			if not archetype then
				return nil
			end

			local columns_map = archetype.columns_map
			local row = v3.row
			local v4 = columns_map[p3]
			local v5 = if v4 then v4[row] else nil

			if not p4 then
				return v5
			end

			if p5 then
				if p6 then
					if p7 then
						error("args exceeded")
					end

					local v6 = columns_map[p4]
					local v7 = if v6 then v6[row] else nil
					local v8 = columns_map[p5]
					local v9 = if v8 then v8[row] else nil
					local v11 = columns_map[p6]

					if v11 then
						return v5, v7, v9, v11[row]
					end

					return v5, v7, v9, nil
				end

				local v12 = columns_map[p4]
				local v13 = if v12 then v12[row] else nil
				local v14 = columns_map[p5]

				if v14 then
					return v5, v13, v14[row]
				end

				return v5, v13, nil
			end

			local v15 = columns_map[p4]

			if v15 then
				return v5, v15[row]
			end

			return v5, nil
		end

		local function inner_world_has(p1, p2, p3, p4, p5, p6, p7) --[[ inner_world_has | Line: 2406 | Upvalues: t3 (copy), t2 (copy) ]]
			local v1 = t3[p2 % 16777216]
			local v2 = if v1 and v1.dense ~= 0 then v1 else nil
			local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

			if not v3 then
				return false
			end

			local archetype = v3.archetype

			if not archetype then
				return false
			end

			local columns_map = archetype.columns_map

			return if columns_map[p3] == nil or p4 ~= nil and columns_map[p4] == nil then false elseif p5 == nil or columns_map[p5] ~= nil then if p6 == nil or columns_map[p6] ~= nil then if p7 == nil then true else error("args exceeded") else false else false
		end

		local function inner_world_target(p1, p2, p3, p4) --[[ inner_world_target | Line: 2428 | Upvalues: t3 (copy), t2 (copy) ]]
			local v1 = t3[p2 % 16777216]
			local v2 = if v1 and v1.dense ~= 0 then v1 else nil
			local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

			if not v3 then
				return nil
			end

			local archetype = v3.archetype

			if not archetype then
				return nil
			end

			local v4 = p1.component_index[260 + p3 % 16777216 * 16777216 + 281474976710656]

			if not v4 then
				return nil
			end

			local id = archetype.id
			local v5 = v4.counts[id]

			if not v5 then
				return nil
			end

			local v6 = p4 or 0

			if v5 <= v6 then
				v6 = v6 + v5 + 1
			end

			local v7 = archetype.types[v6 + v4.records[id]]

			if not v7 then
				return nil
			end

			local entity_index = p1.entity_index
			local v8 = entity_index.sparse_array[(v7 - 281474976710656) % 16777216 % 16777216]
			local v9 = if v8 and v8.dense ~= 0 then v8 else nil

			if v9 then
				return entity_index.dense_array[v9.dense]
			end

			return nil
		end

		local function inner_world_parent(p1, p2) --[[ inner_world_parent | Line: 2468 | Upvalues: inner_world_target (copy) ]]
			return inner_world_target(p1, p2, 261, 0)
		end

		local function inner_archetype_traverse_add(p1, p2) --[[ inner_archetype_traverse_add | Line: 2472 | Upvalues: v12 (copy), t8 (copy), t9 (copy), archetype_register (ref), archetype_create (ref) ]]
			local v1 = if p2 then p2 else v12

			if v1.columns_map[p1] then
				return v1
			end

			local v2 = t8
			local v3 = v2[v1.id]
			local v4 = v3[p1]

			if not v4 then
				local v5 = t9
				local types = v1.types
				local v6 = table.clone(types)
				local v8

				do
					local __inline_returned = false

					for v9, v10 in types do
						if v10 == p1 then
							v8 = -1
							__inline_returned = true

							break
						elseif p1 < v10 then
							v8 = v9
							__inline_returned = true

							break
						end
					end

					if not __inline_returned then
						v8 = #types + 1
					end
				end

				table.insert(v6, v8, p1)

				if #v6 < 1 then
					v4 = v5.ROOT_ARCHETYPE
				else
					local v11 = table.concat(v6, "_")
					local v122 = v5.archetype_index[v11]

					if v122 then
						if v122.dead then
							archetype_register(v5, v122)
							v122.dead = false
						end

						v4 = v122
					else
						v4 = archetype_create(v5, v6, v11)
					end
				end

				v3[p1] = v4
				v2[v4.id][p1] = v1
			end

			return v4
		end

		local function inner_world_set(p1, p2, p3, p4) --[[ inner_world_set | Line: 2490 | Upvalues: t3 (copy), t2 (copy), v12 (copy), t5 (copy), t8 (copy), archetype_register (ref), archetype_create (ref), t9 (copy), t4 (copy), inner_archetype_move (copy) ]]
			local v1 = t3[p2 % 16777216]
			local v2 = if v1 and v1.dense ~= 0 then v1 else nil
			local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

			if not v3 then
				return
			end

			local archetype = v3.archetype
			local v4 = if archetype then archetype else v12
			local v5 = v4.columns_map[p3]

			if v5 then
				v5[v3.row] = p4

				local on_change = t5[p3].on_change

				if on_change then
					on_change(p2, p3, p4)
				end
			else
				local v8, v9

				if if p3 > 281474976710656 then true else false then
					local v10 = t8[v4.id]

					v8 = v10[p3]

					if v8 then
						v9 = t5[p3]
					else
						v9 = t5[260 + (p3 - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656]

						local v11, v122, v13, v14, v15, v16

						if v9 then
							if bit32.btest(v9.flags, 4) then
								local v17 = v9.records[v4.id]

								if v17 then
									local on_remove = v9.on_remove
									local types = v4.types

									if on_remove then
										on_remove(p2, types[v17])

										local archetype2 = v3.archetype

										types = archetype2.types
										v17 = v9.records[archetype2.id]
									end

									local v18 = table.clone(types)

									v18[v17] = p3

									if #v18 < 1 then
										v8 = p1.ROOT_ARCHETYPE
									else
										local v19 = table.concat(v18, "_")
										local v20 = p1.archetype_index[v19]

										if v20 then
											if v20.dead then
												archetype_register(p1, v20)
												v20.dead = false
											end

											v8 = v20
										else
											v8 = archetype_create(p1, v18, v19)
										end
									end
								else
									local types = v4.types
									local v22 = table.clone(types)
									local v23

									do
										local __inline_returned = false

										for v24, v25 in types do
											if v25 == p3 then
												v23 = -1
												__inline_returned = true

												break
											elseif p3 < v25 then
												v23 = v24
												__inline_returned = true

												break
											end
										end

										if not __inline_returned then
											v23 = #types + 1
										end
									end

									table.insert(v22, v23, p3)

									if #v22 < 1 then
										v8 = p1.ROOT_ARCHETYPE
									else
										local v26 = table.concat(v22, "_")
										local v27 = p1.archetype_index[v26]

										if v27 then
											if v27.dead then
												archetype_register(p1, v27)
												v27.dead = false
											end

											v8 = v27
										else
											v8 = archetype_create(p1, v22, v26)
										end
									end

									v9 = t5[p3]
								end
							else
								v11 = v4.types
								v122 = table.clone(v11)

								do
									local __inline_returned = false

									for v29, v30 in v11 do
										if v30 == p3 then
											v13 = -1
											__inline_returned = true

											break
										elseif p3 < v30 then
											v13 = v29
											__inline_returned = true

											break
										end
									end

									if not __inline_returned then
										v13 = #v11 + 1
									end
								end

								table.insert(v122, v13, p3)

								if #v122 < 1 then
									v8 = p1.ROOT_ARCHETYPE
								else
									v14 = table.concat(v122, "_")
									v15 = p1.archetype_index[v14]

									if v15 then
										if v15.dead then
											archetype_register(p1, v15)
											v15.dead = false
										end

										v8 = v15
									else
										v16 = archetype_create(p1, v122, v14)
										v8 = v16
									end
								end

								v9 = t5[p3]
							end
						else
							v11 = v4.types
							v122 = table.clone(v11)

							do
								local __inline_returned = false

								for v29, v30 in v11 do
									if v30 == p3 then
										v13 = -1
										__inline_returned = true

										break
									elseif p3 < v30 then
										v13 = v29
										__inline_returned = true

										break
									end
								end

								if not __inline_returned then
									v13 = #v11 + 1
								end
							end

							table.insert(v122, v13, p3)

							if #v122 < 1 then
								v8 = p1.ROOT_ARCHETYPE
							else
								v14 = table.concat(v122, "_")
								v15 = p1.archetype_index[v14]

								if v15 then
									if v15.dead then
										archetype_register(p1, v15)
										v15.dead = false
									end

									v8 = v15
								else
									v16 = archetype_create(p1, v122, v14)
									v8 = v16
								end
							end

							v9 = t5[p3]
						end

						v10[p3] = v8
					end
				else
					local v31 = if archetype then archetype else v12

					if v31.columns_map[p3] then
						v8 = v31
					else
						local v32 = t8
						local v33 = v32[v31.id]
						local v34 = v33[p3]

						if not v34 then
							local v35 = t9
							local types = v31.types
							local v36 = table.clone(types)
							local v38

							do
								local __inline_returned = false

								for v39, v40 in types do
									if v40 == p3 then
										v38 = -1
										__inline_returned = true

										break
									elseif p3 < v40 then
										v38 = v39
										__inline_returned = true

										break
									end
								end

								if not __inline_returned then
									v38 = #types + 1
								end
							end

							table.insert(v36, v38, p3)

							if #v36 < 1 then
								v34 = v35.ROOT_ARCHETYPE
							else
								local v41 = table.concat(v36, "_")
								local v42 = v35.archetype_index[v41]

								if v42 then
									if v42.dead then
										archetype_register(v35, v42)
										v42.dead = false
									end

									v34 = v42
								else
									v34 = archetype_create(v35, v36, v41)
								end
							end

							v33[p3] = v34
							v32[v34.id][p3] = v31
						end

						v8 = v34
					end

					v9 = t5[p3]
				end

				if archetype then
					local entities = v8.entities
					local v44 = #entities + 1

					entities[v44] = p2
					inner_archetype_move(p2, v8, v44, v3.archetype, v3.row)
					v3.archetype = v8
					v3.row = v44
				else
					local entities = v8.entities
					local v45 = #entities + 1

					entities[v45] = p2
					v3.archetype = v8
					v3.row = v45
				end

				v8.columns_map[p3][v3.row] = p4

				local on_add = v9.on_add

				if not on_add then
					return
				end

				on_add(p2, p3, p4)
			end
		end

		local function inner_world_entity(p1, p2) --[[ inner_world_entity | Line: 2567 | Upvalues: t4 (copy), t3 (copy), t2 (copy), entity_index_new_id (ref) ]]
			if not p2 then
				return entity_index_new_id(t4)
			end

			local v1 = p2 % 16777216
			local alive_count = t4.alive_count
			local v2 = t3[v1]

			if v2 then
				local dense = v2.dense

				if dense and v2.dense ~= 0 then
					if t2[dense] ~= p2 and alive_count <= dense then
						local v3 = t2[dense]
						local v4 = t3[v3 % 16777216];

						(if v4 and v4.dense ~= 0 then v4 else nil).dense = dense

						local v6 = alive_count + 1

						t4.alive_count = v6
						v2.dense = v6
						t2[dense] = v3
						t2[v6] = p2
					end
				else
					v2.dense = v1

					if t2[v1] == p2 then
						local v7 = t2[v1]
						local v8 = t3[v7 % 16777216]
						local v9, v10

						if v8 and v8.dense ~= 0 then
							v9 = v8
							v10 = v1
						else
							v9 = nil
							v10 = v1
						end

						v9.dense = v10

						local v11 = alive_count + 1

						t4.alive_count = v11
						v2.dense = v11
						t2[v10] = v7
						t2[v11] = p2
					end
				end
			else
				for i = 1, v1 do
					t3[i] = {
						dense = i
					}
					t2[i] = i
				end

				t4.max_id = v1
				t3[alive_count].dense = v1

				local v13 = alive_count + 1

				t4.alive_count = v13

				local v14 = t3[v1]

				v14.dense = v13
				t3[v1] = v14
				t2[v1] = t2[alive_count]
				t2[v13] = p2
			end

			return p2
		end

		local function inner_world_remove(p1, p2, p3) --[[ inner_world_remove | Line: 2640 | Upvalues: t3 (copy), t2 (copy), archetype_register (ref), archetype_create (ref), t4 (copy), inner_archetype_move (copy) ]]
			local v1 = t3[p2 % 16777216]
			local v2 = if v1 and v1.dense ~= 0 then v1 else nil
			local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

			if not v3 then
				return
			end

			local archetype = v3.archetype

			if not archetype then
				return
			end

			if not archetype.columns_map[p3] then
				return
			end

			local on_remove = p1.component_index[p3].on_remove

			if on_remove then
				on_remove(p2, p3)
			end

			local archetype2 = v3.archetype
			local archetype_edges = p1.archetype_edges
			local v4 = archetype_edges[archetype2.id]
			local v5 = v4[p3]

			if v5 == nil then
				local types = archetype2.types
				local v6 = table.find(types, p3)
				local v7 = table.clone(types)

				table.remove(v7, v6)

				if #v7 < 1 then
					v5 = p1.ROOT_ARCHETYPE
				else
					local v8 = table.concat(v7, "_")
					local v9 = p1.archetype_index[v8]

					if v9 then
						if v9.dead then
							archetype_register(p1, v9)
							v9.dead = false
						end

						v5 = v9
					else
						v5 = archetype_create(p1, v7, v8)
					end
				end

				v4[p3] = v5
				archetype_edges[v5.id][p3] = archetype2
			end

			local entities = v5.entities
			local v11 = #entities + 1

			entities[v11] = p2
			inner_archetype_move(p2, v5, v11, v3.archetype, v3.row)
			v3.archetype = v5
			v3.row = v11
		end

		local function inner_world_clear(p1, p2) --[[ inner_world_clear | Line: 2664 | Upvalues: t5 (copy), t7 (ref), inner_world_remove (copy), t4 (copy), archetype_register (ref), archetype_create (ref), t3 (copy), t2 (copy), inner_archetype_move (copy) ]]
			local v1 = t5[p2 % 16777216 + 4362076160 + 281474976710656]
			local v2 = t5[p2]
			local v3 = t5[260 + p2 % 16777216 * 16777216 + 281474976710656]

			if v2 then
				local sum = 0
				local t = {}

				for v4 in v2.records do
					local entities = t7[v4].entities
					local v5 = #entities

					table.move(entities, 1, v5, sum + 1, t)
					sum = sum + v5
				end

				for v6, v7 in t do
					inner_world_remove(p1, v7, p2)
				end
			end

			if v1 then
				for v8 in v1.records do
					local v9 = t7[v8]
					local entities = v9.entities
					local v10 = v9

					for v12, v13 in v9.types do
						local v11

						if if v13 > 281474976710656 then true else false then
							local v15 = t4
							local v16 = v15.sparse_array[(v13 - 281474976710656) % 16777216 % 16777216]
							local v17 = if v16 and v16.dense ~= 0 then v16 else nil

							if (if v17 then v15.dense_array[v17.dense] else nil) == p2 then
								local archetype_edges = p1.archetype_edges
								local v19 = archetype_edges[v10.id]
								local v20 = v19[v13]

								if v20 == nil then
									local types2 = v10.types
									local v21 = table.find(types2, v13)
									local v22 = table.clone(types2)

									table.remove(v22, v21)

									if #v22 < 1 then
										v20 = p1.ROOT_ARCHETYPE
										v11 = v10
									else
										local v23 = table.concat(v22, "_")
										local v24 = p1.archetype_index[v23]

										if v24 then
											if v24.dead then
												archetype_register(p1, v24)
												v24.dead = false
											end

											v20 = v24
											v11 = v10
										else
											v20, v11 = archetype_create(p1, v22, v23), v10
										end
									end

									v19[v13] = v20
									archetype_edges[v20.id][v13] = v11
								end

								local on_remove = t5[v13].on_remove

								if on_remove then
									v10 = v20

									for v26, v27 in entities do
										on_remove(v27, v13)
									end

									continue
								end

								v10 = v20
							end
						end
					end

					for i = #entities, 1, -1 do
						local v28
						local v29 = entities[i]
						local v30 = t3[v29 % 16777216]
						local v31 = if v30 and v30.dense ~= 0 then v30 else nil

						v28 = if v31 and t2[v31.dense] ~= v29 then nil else v31

						local entities2 = v10.entities
						local v32 = #entities2 + 1

						entities2[v32] = v29
						inner_archetype_move(v29, v10, v32, v28.archetype, v28.row)
						v28.archetype = v10
						v28.row = v32
					end
				end
			end

			if not v3 then
				return
			end

			local records2 = v3.records
			local counts = v3.counts

			for v33 in v3.records do
				local v34 = t7[v33]
				local entities = v34.entities
				local v35 = records2[v33]
				local types = v34.types
				local v37 = v34

				for j = v35, v35 + counts[v33] - 1 do
					local v38 = types[j]
					local archetype_edges = p1.archetype_edges
					local v39 = archetype_edges[v34.id]
					local v40 = v39[v38]

					if v40 == nil then
						local types2 = v34.types
						local v41 = table.find(types2, v38)
						local v42 = table.clone(types2)

						table.remove(v42, v41)

						if #v42 < 1 then
							v40 = p1.ROOT_ARCHETYPE
						else
							local v43 = table.concat(v42, "_")
							local v44 = p1.archetype_index[v43]

							if v44 then
								if v44.dead then
									archetype_register(p1, v44)
									v44.dead = false
								end

								v40 = v44
							else
								v40 = archetype_create(p1, v42, v43)
							end
						end

						v39[v38] = v40
						archetype_edges[v40.id][v38] = v34
					end

					local on_remove = t5[v38].on_remove

					if on_remove then
						v37 = v40

						for v46, v47 in entities do
							on_remove(v47, v38)
						end

						continue
					end

					v37 = v40
				end

				for k = #entities, 1, -1 do
					local v48
					local v49 = entities[k]
					local v50 = t3[v49 % 16777216]
					local v51 = if v50 and v50.dense ~= 0 then v50 else nil

					v48 = if v51 and t2[v51.dense] ~= v49 then nil else v51

					local entities2 = v37.entities
					local v52 = #entities2 + 1

					entities2[v52] = v49
					inner_archetype_move(v49, v37, v52, v48.archetype, v48.row)
					v48.archetype = v37
					v48.row = v52
				end
			end
		end

		local function v22(p1, p2) --[[ inner_world_delete | Line: 2751 | Upvalues: t3 (copy), t2 (copy), archetype_delete (ref), v22 (copy), archetype_destroy (ref), archetype_register (ref), archetype_create (ref), t4 (copy), inner_archetype_move (copy), archetype_move (ref) ]]
			local v1 = t3[p2 % 16777216]
			local v2 = if v1 and v1.dense ~= 0 then v1 else nil
			local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

			if not v3 then
				return
			end

			local archetype = v3.archetype
			local row = v3.row

			if archetype then
				archetype_delete(p1, archetype, row)
			end

			local component_index = p1.component_index
			local archetypes = p1.archetypes
			local v4 = component_index[p2 % 16777216 + 4362076160 + 281474976710656]
			local v5 = component_index[p2]
			local v6 = component_index[260 + p2 % 16777216 * 16777216 + 281474976710656]

			if v5 and bit32.btest(v5.flags, 1) then
				for v7 in v5.records do
					local v8 = archetypes[v7]
					local entities = v8.entities

					for i = #entities, 1, -1 do
						v22(p1, entities[i])
					end

					archetype_destroy(p1, v8)
				end
			elseif v5 then
				local on_remove = v5.on_remove

				if on_remove then
					for v9 in v5.records do
						local v10 = archetypes[v9]
						local archetype_edges = p1.archetype_edges
						local v11 = archetype_edges[v10.id]
						local v12 = v11[p2]

						if v12 == nil then
							local types = v10.types
							local v13 = table.find(types, p2)
							local v14 = table.clone(types)

							table.remove(v14, v13)

							if #v14 < 1 then
								v12 = p1.ROOT_ARCHETYPE
							else
								local v15 = table.concat(v14, "_")
								local v16 = p1.archetype_index[v15]

								if v16 then
									if v16.dead then
										archetype_register(p1, v16)
										v16.dead = false
									end

									v12 = v16
								else
									v12 = archetype_create(p1, v14, v15)
								end
							end

							v11[p2] = v12
							archetype_edges[v12.id][p2] = v10
						end

						local entities = v10.entities
						local v18 = v12

						for j = #entities, 1, -1 do
							local v19 = entities[j]

							on_remove(v19, p2)

							local v20 = t3[v19 % 16777216]
							local archetype2 = v20.archetype

							if archetype2 ~= v10 then
								local archetype_edges2 = p1.archetype_edges
								local v21 = archetype_edges2[archetype2.id]
								local v222 = v21[p2]

								if v222 == nil then
									local types = archetype2.types
									local v23 = table.find(types, p2)
									local v24 = table.clone(types)

									table.remove(v24, v23)

									if #v24 < 1 then
										v222 = p1.ROOT_ARCHETYPE
									else
										local v25 = table.concat(v24, "_")
										local v26 = p1.archetype_index[v25]

										if v26 then
											if v26.dead then
												archetype_register(p1, v26)
												v26.dead = false
											end

											v222 = v26
										else
											v222 = archetype_create(p1, v24, v25)
										end
									end

									v21[p2] = v222
									archetype_edges2[v222.id][p2] = archetype2
								end

								v18 = v222
							end

							local entities2 = v18.entities
							local v28 = #entities2 + 1

							entities2[v28] = v19
							inner_archetype_move(v19, v18, v28, v20.archetype, v20.row)
							v20.archetype = v18
							v20.row = v28
						end

						archetype_destroy(p1, v10)
					end
				else
					for v29 in v5.records do
						local v30 = archetypes[v29]
						local archetype_edges = p1.archetype_edges
						local v31 = archetype_edges[v30.id]
						local v32 = v31[p2]

						if v32 == nil then
							local types = v30.types
							local v33 = table.find(types, p2)
							local v34 = table.clone(types)

							table.remove(v34, v33)

							if #v34 < 1 then
								v32 = p1.ROOT_ARCHETYPE
							else
								local v35 = table.concat(v34, "_")
								local v36 = p1.archetype_index[v35]

								if v36 then
									if v36.dead then
										archetype_register(p1, v36)
										v36.dead = false
									end

									v32 = v36
								else
									v32 = archetype_create(p1, v34, v35)
								end
							end

							v31[p2] = v32
							archetype_edges[v32.id][p2] = v30
						end

						local entities = v30.entities
						local v38 = v32

						for k = #entities, 1, -1 do
							local v39 = entities[k]
							local v41 = t3[v39 % 16777216]
							local entities2 = v38.entities
							local v42 = #entities2 + 1

							entities2[v42] = v39
							archetype_move(t4, v39, v38, v42, v41.archetype, v41.row)
							v41.archetype = v38
							v41.row = v42
						end

						archetype_destroy(p1, v30)
					end
				end
			end

			if v4 then
				local records = v4.records

				for v43 in records do
					local v44 = archetypes[v43]
					local entities = v44.entities
					local v45, v46 = v44, false

					for v48, v49 in v44.types do
						local v47

						if if v49 > 281474976710656 then true else false then
							local v51 = t4
							local v52 = v51.sparse_array[(v49 - 281474976710656) % 16777216 % 16777216]
							local v53 = if v52 and v52.dense ~= 0 then v52 else nil

							if (if v53 then v51.dense_array[v53.dense] else nil) == p2 then
								if bit32.btest(component_index[v49].flags, 1) then
									for n = #entities, 1, -1 do
										v22(p1, entities[n])
									end

									v46 = true

									break
								end

								local archetype_edges = p1.archetype_edges
								local v55 = archetype_edges[v45.id]
								local v56 = v55[v49]

								if v56 == nil then
									local types2 = v45.types
									local v57 = table.find(types2, v49)
									local v58 = table.clone(types2)

									table.remove(v58, v57)

									if #v58 < 1 then
										v56 = p1.ROOT_ARCHETYPE
										v47 = v45
									else
										local v59 = table.concat(v58, "_")
										local v60 = p1.archetype_index[v59]

										if v60 then
											if v60.dead then
												archetype_register(p1, v60)
												v60.dead = false
											end

											v56 = v60
											v47 = v45
										else
											v56, v47 = archetype_create(p1, v58, v59), v45
										end
									end

									v55[v49] = v56
									archetype_edges[v56.id][v49] = v47
								end

								local on_remove = component_index[v49].on_remove

								if on_remove then
									v45 = v56

									for v62, v63 in entities do
										on_remove(v63, v49)
									end

									continue
								end

								v45 = v56
							end
						end
					end

					if not v46 then
						for m = #entities, 1, -1 do
							local v64
							local v65 = entities[m]
							local v66 = t3[v65 % 16777216]
							local v67 = if v66 and v66.dense ~= 0 then v66 else nil

							v64 = if v67 and t2[v67.dense] ~= v65 then nil else v67

							local entities2 = v45.entities
							local v68 = #entities2 + 1

							entities2[v68] = v65
							inner_archetype_move(v65, v45, v68, v64.archetype, v64.row)
							v64.archetype = v45
							v64.row = v68
						end
					end
				end

				for v69 in records do
					archetype_destroy(p1, archetypes[v69])
				end
			end

			if v6 then
				local records = v6.records

				if bit32.btest(v6.flags, 1) then
					for v70 in records do
						local v71 = archetypes[v70]
						local entities = v71.entities

						for i = #entities, 1, -1 do
							v22(p1, entities[i])
						end

						archetype_destroy(p1, v71)
					end
				else
					local counts = v6.counts
					local records2 = v6.records

					for v72 in records do
						local v73 = archetypes[v72]
						local entities = v73.entities
						local v74 = records2[v72]
						local types = v73.types
						local v76 = v73

						for i = v74, v74 + counts[v72] - 1 do
							local v77
							local v78 = types[i]
							local archetype_edges = p1.archetype_edges
							local v79 = archetype_edges[v76.id]
							local v80 = v79[v78]

							if v80 == nil then
								local types2 = v76.types
								local v81 = table.find(types2, v78)
								local v82 = table.clone(types2)

								table.remove(v82, v81)

								if #v82 < 1 then
									v80 = p1.ROOT_ARCHETYPE
									v77 = v76
								else
									local v83 = table.concat(v82, "_")
									local v84 = p1.archetype_index[v83]

									if v84 then
										if v84.dead then
											archetype_register(p1, v84)
											v84.dead = false
										end

										v80 = v84
										v77 = v76
									else
										v80, v77 = archetype_create(p1, v82, v83), v76
									end
								end

								v79[v78] = v80
								archetype_edges[v80.id][v78] = v77
							end

							local on_remove = component_index[v78].on_remove

							if on_remove then
								v76 = v80

								for v86, v87 in entities do
									on_remove(v87, v78)
								end

								continue
							end

							v76 = v80
						end

						for i = #entities, 1, -1 do
							local v88
							local v89 = entities[i]
							local v90 = t3[v89 % 16777216]
							local v91 = if v90 and v90.dense ~= 0 then v90 else nil

							v88 = if v91 and t2[v91.dense] ~= v89 then nil else v91

							local entities2 = v76.entities
							local v92 = #entities2 + 1

							entities2[v92] = v89
							inner_archetype_move(v89, v76, v92, v88.archetype, v88.row)
							v88.archetype = v76
							v88.row = v92
						end
					end

					for v93 in records do
						archetype_destroy(p1, archetypes[v93])
					end
				end
			end

			local dense = v3.dense
			local alive_count = t4.alive_count

			t4.alive_count = alive_count - 1

			local v94 = t2[alive_count]
			local v95 = t3[v94 % 16777216];

			(if v95 and v95.dense ~= 0 then v95 else nil).dense = dense
			v3.archetype = nil
			v3.row = nil
			v3.dense = alive_count
			t2[dense] = v94

			local v98

			if p2 > 16777216 then
				local v99 = p2 % 16777216
				local v100 = p2 // 16777216 + 1

				v98 = if v100 >= 65536 then v99 else v99 + v100 * 16777216
			else
				v98 = p2 + 16777216
			end

			t2[alive_count] = v98
		end

		local function inner_world_exists(p1, p2) --[[ inner_world_exists | Line: 2942 | Upvalues: t3 (copy) ]]
			local v1 = t3[p2 % 16777216]

			return (if v1 and v1.dense ~= 0 then v1 else nil) ~= nil
		end

		local function inner_world_contains(p1, p2) --[[ inner_world_contains | Line: 2946 ]]
			local entity_index = p1.entity_index
			local v1 = entity_index.sparse_array[p2 % 16777216]
			local v2 = if v1 and v1.dense ~= 0 then v1 else nil
			local v3

			if v2 then
				local dense = v2.dense

				v3 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= p2 then nil else v2
			else
				v3 = v2
			end

			return v3 ~= nil
		end

		local function inner_world_cleanup(p1) --[[ inner_world_cleanup | Line: 2950 | Upvalues: t7 (ref), archetype_destroy (ref), t6 (ref) ]]
			for v1, v2 in t7 do
				if #v2.entities == 0 then
					archetype_destroy(p1, v2)
				end
			end

			local t = {}
			local t2 = {}

			for v3, v4 in t7 do
				t[v3] = v4
				t2[v4.type] = v4
			end

			t7 = t
			t6 = t2
			p1.archetypes = t
			p1.archetype_index = t2
		end

		t9.entity = inner_world_entity
		t9.query = world_query
		t9.remove = inner_world_remove
		t9.clear = inner_world_clear
		t9.delete = v22
		t9.component = world_component
		t9.add = inner_world_add
		t9.set = inner_world_set
		t9.get = inner_world_get
		t9.has = inner_world_has
		t9.target = inner_world_target
		t9.parent = inner_world_parent
		t9.contains = inner_world_contains
		t9.exists = inner_world_exists
		t9.cleanup = inner_world_cleanup
		t9.each = world_each
		t9.children = world_children
		t9.range = world_range

		for i = 1, 256 do
			inner_world_add(t9, entity_index_new_id(t4), 262)
		end

		for j = 257, 271 do
			entity_index_new_id(t4)
		end

		inner_world_add(t9, 267, 262)
		inner_world_add(t9, 259, 262)
		inner_world_add(t9, 257, 262)
		inner_world_add(t9, 258, 262)
		inner_world_add(t9, 260, 262)
		inner_world_add(t9, 271, 262)
		inner_world_set(t9, 257, 267, "jecs.OnAdd")
		inner_world_set(t9, 258, 267, "jecs.OnRemove")
		inner_world_set(t9, 259, 267, "jecs.OnChange")
		inner_world_set(t9, 260, 267, "jecs.Wildcard")
		inner_world_set(t9, 261, 267, "jecs.ChildOf")
		inner_world_set(t9, 262, 267, "jecs.Component")
		inner_world_set(t9, 263, 267, "jecs.OnDelete")
		inner_world_set(t9, 264, 267, "jecs.OnDeleteTarget")
		inner_world_set(t9, 265, 267, "jecs.Delete")
		inner_world_set(t9, 266, 267, "jecs.Remove")
		inner_world_set(t9, 267, 267, "jecs.Name")
		inner_world_set(t9, 271, 271, "jecs.Rest")
		inner_world_add(t9, 261, 281479405895945)
		inner_world_add(t9, 261, 270)

		for k = 272, v4 do
			entity_index_new_id(t4)
		end

		for v32, v42 in t do
			for v5, v6 in v42 do
				if v6 == v2 then
					inner_world_add(t9, v32, v5)

					continue
				end

				inner_world_set(t9, v32, v5, v6)
			end
		end

		return t9
	end,
	component = ECS_COMPONENT,
	tag = ECS_TAG,
	meta = ECS_META,
	is_tag = function(p1, p2) --[[ ecs_is_tag | Line: 3059 ]]
		local v1 = p1.component_index[p2]

		if v1 then
			return bit32.btest(v1.flags, 2)
		end

		local entity_index = p1.entity_index
		local v2 = entity_index.sparse_array[p2 % 16777216]
		local v3 = if v2 and v2.dense ~= 0 then v2 else nil
		local v4

		if v3 then
			local dense = v3.dense

			v4 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= p2 then nil else v3
		else
			v4 = v3
		end

		local v5

		if v4 then
			local archetype = v4.archetype

			v5 = if archetype then archetype.columns_map[262] ~= nil else false
		else
			v5 = false
		end

		return not v5
	end,
	OnAdd = 257,
	OnRemove = 258,
	OnChange = 259,
	ChildOf = 261,
	Component = 262,
	Wildcard = 260,
	w = 260,
	OnDelete = 263,
	OnDeleteTarget = 264,
	Delete = 265,
	Remove = 266,
	Name = 267,
	Exclusive = 270,
	ArchetypeCreate = 268,
	ArchetypeDelete = 269,
	Rest = 271,
	pair = ECS_PAIR,
	ECS_ID = ECS_ENTITY_T_LO,
	ECS_GENERATION_INC = ECS_GENERATION_INC,
	ECS_GENERATION = ECS_GENERATION,
	ECS_ID_IS_WILDCARD = ECS_ID_IS_WILDCARD,
	ECS_ID_DELETE = 1,
	ECS_META_RESET = ECS_META_RESET,
	IS_PAIR = ECS_IS_PAIR,
	ECS_PAIR_FIRST = ECS_PAIR_FIRST,
	ECS_PAIR_SECOND = ECS_PAIR_SECOND,
	pair_first = ecs_pair_first,
	pair_second = ecs_pair_second,
	entity_index_get_alive = entity_index_get_alive,
	archetype_append_to_records = archetype_append_to_records,
	id_record_ensure = id_record_ensure,
	component_record = id_record_get,
	archetype_create = archetype_create,
	archetype_ensure = archetype_ensure,
	find_insert = find_insert,
	find_archetype_with = find_archetype_with,
	find_archetype_without = find_archetype_without,
	create_edge_for_remove = create_edge_for_remove,
	archetype_traverse_add = archetype_traverse_add,
	archetype_traverse_remove = archetype_traverse_remove,
	bulk_insert = ecs_bulk_insert,
	bulk_remove = ecs_bulk_remove,
	entity_move = entity_move,
	entity_index_try_get = entity_index_try_get,
	entity_index_try_get_fast = entity_index_try_get_fast,
	entity_index_try_get_any = entity_index_try_get_any,
	entity_index_is_alive = entity_index_is_alive,
	entity_index_new_id = entity_index_new_id,
	query_iter = query_iter,
	query_iter_init = query_iter_init,
	query_with = query_with,
	query_without = query_without,
	query_archetypes = query_archetypes,
	query_match = query_match,
	find_observers = find_observers
}