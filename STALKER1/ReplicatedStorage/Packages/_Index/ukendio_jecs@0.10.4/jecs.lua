-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = table.freeze({})
local v2 = newproxy(false)

local function ecs_assert(p1, p2) --[[ ecs_assert | Line: 396 ]]
	if p1 then
		return
	end

	error(p2)
end

local t = {}
local v3 = 0
local v4 = 271

local function ECS_COMPONENT() --[[ ECS_COMPONENT | Line: 406 | Upvalues: v3 (ref) ]]
	v3 = v3 + 1

	if not (v3 > 256) then
		return v3
	end

	error("Too many components")
end

local function ECS_TAG() --[[ ECS_TAG | Line: 414 | Upvalues: v4 (ref) ]]
	v4 = v4 + 1

	return v4
end

local function ECS_META(p1, p2, p3) --[[ ECS_META | Line: 419 | Upvalues: t (ref), v2 (copy) ]]
	local v1 = t[p1]

	if v1 == nil then
		v1 = {}
		t[p1] = v1
	end

	v1[p2] = if p3 == nil then v2 else p3
end

local function ECS_META_RESET() --[[ ECS_META_RESET | Line: 428 | Upvalues: t (ref), v3 (ref), v4 (ref) ]]
	t = {}
	v3 = 0
	v4 = 271
end

local function ECS_COMBINE(p1, p2) --[[ ECS_COMBINE | Line: 434 ]]
	return p1 + p2 * 16777216
end

local function ECS_IS_PAIR(p1) --[[ ECS_IS_PAIR | Line: 438 ]]
	return p1 > 281474976710656
end

local function ECS_GENERATION_INC(p1) --[[ ECS_GENERATION_INC | Line: 442 ]]
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

local function ECS_ENTITY_T_LO(p1) --[[ ECS_ENTITY_T_LO | Line: 457 ]]
	return p1 % 16777216
end

local function ECS_ID(p1) --[[ ECS_ID | Line: 461 ]]
	return p1 % 16777216
end

local function ECS_GENERATION(p1) --[[ ECS_GENERATION | Line: 465 ]]
	return p1 // 16777216
end

local function ECS_ENTITY_T_HI(p1) --[[ ECS_ENTITY_T_HI | Line: 469 ]]
	return p1 // 16777216
end

local function ECS_PAIR(p1, p2) --[[ ECS_PAIR | Line: 473 ]]
	return p2 % 16777216 + p1 % 16777216 * 16777216 + 281474976710656
end

local function ECS_PAIR_FIRST(p1) --[[ ECS_PAIR_FIRST | Line: 480 ]]
	return (p1 - 281474976710656) // 16777216
end

local function ECS_PAIR_SECOND(p1) --[[ ECS_PAIR_SECOND | Line: 484 ]]
	return (p1 - 281474976710656) % 16777216
end

local function entity_index_try_get_any(p1, p2) --[[ entity_index_try_get_any | Line: 488 ]]
	local v1 = p1.sparse_array[p2 % 16777216]

	if v1 and v1.dense ~= 0 then
		return v1
	end

	return nil
end

local function entity_index_try_get(p1, p2) --[[ entity_index_try_get | Line: 501 ]]
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

local function entity_index_try_get_fast(p1, p2) --[[ entity_index_try_get_fast | Line: 515 ]]
	local v1 = p1.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil

	if v2 and p1.dense_array[v2.dense] ~= p2 then
		return nil
	end

	return v2
end

local function entity_index_is_alive(p1, p2) --[[ entity_index_is_alive | Line: 529 ]]
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

local function entity_index_get_alive(p1, p2) --[[ entity_index_get_alive | Line: 533 ]]
	local v1 = p1.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil

	if not v2 then
		return nil
	end

	local dense = v2.dense

	if p1.alive_count < dense then
		return nil
	end

	return p1.dense_array[dense]
end

local function ecs_get_alive(p1, p2) --[[ ecs_get_alive | Line: 545 ]]
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
	local v7

	if v6 then
		local dense = v6.dense

		v7 = if entity_index.alive_count < dense then nil else entity_index.dense_array[dense]
	else
		v7 = nil
	end

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

local function ENTITY_INDEX_NEW_ID(p1) --[[ ENTITY_INDEX_NEW_ID | Line: 570 ]]
	local dense_array = p1.dense_array
	local alive_count = p1.alive_count
	local sparse_array = p1.sparse_array
	local max_id = p1.max_id
	local v1 = alive_count + 1

	if alive_count < max_id then
		local v2 = dense_array[v1]

		if v2 then
			p1.alive_count = v1

			return v2
		end
	end

	local v3 = max_id + 1
	local range_end = p1.range_end

	if if range_end == nil then true elseif v3 < range_end then true else false then
		p1.max_id = v3
		p1.alive_count = v1
		dense_array[v1] = v3
		sparse_array[v3] = {
			dense = v1
		}

		return v3
	end

	error("Entity is outside range")
end

local function ecs_pair_first(p1, p2) --[[ ecs_pair_first | Line: 597 ]]
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
	local v8

	if v7 then
		local dense = v7.dense

		v8 = if entity_index.alive_count < dense then nil else entity_index.dense_array[dense]
	else
		v8 = nil
	end

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

local function ecs_pair_second(p1, p2) --[[ ecs_pair_second | Line: 602 ]]
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
	local v8

	if v7 then
		local dense = v7.dense

		v8 = if entity_index.alive_count < dense then nil else entity_index.dense_array[dense]
	else
		v8 = nil
	end

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

local function query_match(p1, p2) --[[ query_match | Line: 607 ]]
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

local function find_observers(p1, p2, p3) --[[ find_observers | Line: 629 ]]
	local v1 = p1.observable[p2]

	if v1 then
		return v1[p3]
	end

	return nil
end

local function archetype_move(p1, p2, p3, p4, p5, p6) --[[ archetype_move | Line: 637 | Upvalues: v1 (copy) ]]
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

local function archetype_append(p1, p2) --[[ archetype_append | Line: 707 ]]
	local entities = p2.entities
	local v1 = #entities + 1

	entities[v1] = p1

	return v1
end

local function new_entity(p1, p2, p3) --[[ new_entity | Line: 717 ]]
	local entities = p3.entities
	local v1 = #entities + 1

	entities[v1] = p1
	p2.archetype = p3
	p2.row = v1

	return p2
end

local function entity_move(p1, p2, p3, p4) --[[ entity_move | Line: 728 | Upvalues: archetype_move (copy) ]]
	local entities = p4.entities
	local v1 = #entities + 1

	entities[v1] = p2
	archetype_move(p1, p2, p4, v1, p3.archetype, p3.row)
	p3.archetype = p4
	p3.row = v1
end

local function hash(p1) --[[ hash | Line: 742 ]]
	return table.concat(p1, "_")
end

local function fetch(p1, p2, p3) --[[ fetch | Line: 746 ]]
	local v1 = p2[p1]

	if v1 then
		return v1[p3]
	end

	return nil
end

local function WORLD_GET(p1, p2, p3, p4, p5, p6, p7) --[[ WORLD_GET | Line: 756 ]]
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

local function WORLD_HAS(p1, p2, p3) --[[ WORLD_HAS | Line: 786 ]]
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

local function WORLD_TARGET(p1, p2, p3, p4) --[[ WORLD_TARGET | Line: 800 ]]
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
		return nil
	end

	local v7 = archetype.types[v6 + v4.records[id]]

	if not v7 then
		return nil
	end

	local v8 = entity_index.sparse_array[(v7 - 281474976710656) % 16777216 % 16777216]
	local v9 = if v8 and v8.dense ~= 0 then v8 else nil

	if not v9 then
		return nil
	end

	local dense = v9.dense

	if entity_index.alive_count < dense then
		return nil
	end

	return entity_index.dense_array[dense]
end

local function ECS_ID_IS_WILDCARD(p1) --[[ ECS_ID_IS_WILDCARD | Line: 841 ]]
	return if p1 // 16777216 == 260 then true else p1 % 16777216 == 260
end

local function id_record_get(p1, p2) --[[ id_record_get | Line: 847 ]]
	local v1 = p1.component_index[p2]

	if v1 then
		return v1
	end

	return nil
end

local function id_record_create(p1, p2, p3) --[[ id_record_create | Line: 858 | Upvalues: WORLD_TARGET (copy) ]]
	local entity_index = p1.entity_index
	local v1 = 0
	local v2 = 0
	local v3 = if p3 > 281474976710656 then true else false
	local v4 = false
	local v5 = false
	local v6

	if v3 then
		local v7 = entity_index.sparse_array[(p3 - 281474976710656) // 16777216 % 16777216]
		local v8 = if v7 and v7.dense ~= 0 then v7 else nil

		if v8 then
			local dense = v8.dense

			v6 = if entity_index.alive_count < dense then nil else entity_index.dense_array[dense]
		else
			v6 = nil
		end

		local v9

		if v6 then
			local v10 = entity_index.sparse_array[v6 % 16777216]
			local v11, v12

			if v10 and v10.dense ~= 0 then
				v11 = v10
				v12 = v6
			else
				v11 = nil
				v12 = v6
			end

			local v13

			if v11 then
				local dense = v11.dense

				v13 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v12 then nil else v11
			else
				v13 = v11
			end

			v9 = if v13 == nil then false else true
		else
			v9 = v6
		end

		if not v9 then
			error("\tYou tried passing a pair that has invalid entities that are either unalive\n\tor non-existing entities. You can enable DEBUG mode by passing in true to\n\tjecs.world(true) and try doing it again in order to get better assertions so\n\tthat you can understand what went wrong.\n")
		end

		local v14 = entity_index.sparse_array[(p3 - 281474976710656) % 16777216 % 16777216]
		local v15 = if v14 and v14.dense ~= 0 then v14 else nil

		if v15 then
			local dense = v15.dense

			v2 = if entity_index.alive_count < dense then nil else entity_index.dense_array[dense]
		else
			v2 = nil
		end

		local v16

		if v2 then
			local v17 = entity_index.sparse_array[v2 % 16777216]
			local v18, v19

			if v17 and v17.dense ~= 0 then
				v18 = v17
				v19 = v2
			else
				v18 = nil
				v19 = v2
			end

			local v20

			if v18 then
				local dense = v18.dense

				v20 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v19 then nil else v18
			else
				v20 = v18
			end

			v16 = if v20 == nil then false else true
		else
			v16 = v2
		end

		if not v16 then
			error("\tYou tried passing a pair that has invalid entities that are either unalive\n\tor non-existing entities. You can enable DEBUG mode by passing in true to\n\tjecs.world(true) and try doing it again in order to get better assertions so\n\tthat you can understand what went wrong.\n")
		end

		if WORLD_TARGET(p1, v6, 264, 0) == 265 then
			v4 = true
		end

		local entity_index2 = p1.entity_index
		local v21 = entity_index2.sparse_array[v6 % 16777216]
		local v22, v23

		if v21 and v21.dense ~= 0 then
			v22 = v21
			v23 = v6
		else
			v22 = nil
			v23 = v6
		end

		local v24

		if v22 then
			local dense = v22.dense

			v24 = if entity_index2.alive_count < dense or entity_index2.dense_array[dense] ~= v23 then nil else v22
		else
			v24 = v22
		end

		local v25

		if v24 then
			local archetype = v24.archetype

			v25 = if archetype then if archetype.columns_map[270] == nil then false else true else false
		else
			v25 = false
		end

		if v25 then
			v5 = true
		end
	else
		v6 = p3
	end

	if WORLD_TARGET(p1, v6, 263, 0) == 265 then
		v4 = true
	end

	local entity_index2 = p1.entity_index
	local v26 = entity_index2.sparse_array[v6 % 16777216]
	local v27, v28

	if v26 and v26.dense ~= 0 then
		v27 = v26
		v28 = v6
	else
		v27 = nil
		v28 = v6
	end

	local v29

	if v27 then
		local dense = v27.dense

		v29 = if entity_index2.alive_count < dense or entity_index2.dense_array[dense] ~= v28 then nil else v27
	else
		v29 = v27
	end

	local v30, v31, v32

	if v29 then
		local archetype = v29.archetype

		if archetype then
			local columns_map = archetype.columns_map
			local row = v29.row
			local v33 = columns_map[257]
			local v34 = if v33 then v33[row] else nil
			local v35 = columns_map[259]

			v30 = if v35 then v35[row] else nil

			local v36 = columns_map[258]

			if v36 then
				v31 = v36[row]
				v32 = v34
			else
				v31 = nil
				v32 = v34
			end
		else
			v31 = nil
			v32 = nil
			v30 = nil
		end
	else
		v31 = nil
		v32 = nil
		v30 = nil
	end

	local entity_index3 = p1.entity_index
	local v37 = entity_index3.sparse_array[v6 % 16777216]
	local v38, v39

	if v37 and v37.dense ~= 0 then
		v38 = v37
		v39 = v6
	else
		v38 = nil
		v39 = v6
	end

	local v40

	if v38 then
		local dense = v38.dense

		v40 = if entity_index3.alive_count < dense or entity_index3.dense_array[dense] ~= v39 then nil else v38
	else
		v40 = v38
	end

	local v41

	if v40 then
		local archetype = v40.archetype

		v41 = if archetype then if archetype.columns_map[262] == nil then false else true else false
	else
		v41 = false
	end

	local v42 = not v41

	if v42 and v3 then
		local entity_index4 = p1.entity_index
		local v43 = entity_index4.sparse_array[v2 % 16777216]
		local v44, v45

		if v43 and v43.dense ~= 0 then
			v44 = v43
			v45 = v2
		else
			v44 = nil
			v45 = v2
		end

		local v46

		if v44 then
			local dense = v44.dense

			v46 = if entity_index4.alive_count < dense or entity_index4.dense_array[dense] ~= v45 then nil else v44
		else
			v46 = v44
		end

		local v47

		if v46 then
			local archetype = v46.archetype

			v47 = if archetype then if archetype.columns_map[262] == nil then false else true else false
		else
			v47 = false
		end

		v42 = not v47
	end

	local v49, v50

	if v42 then
		v49 = v1
		v50 = 2
	else
		v49 = v1
		v50 = 0
	end

	local t = {
		size = 0,
		records = {},
		counts = {},
		flags = bit32.bor(v49, if v4 then 1 else 0, v50, if v5 then 4 else 0),
		on_add = v32,
		on_change = v30,
		on_remove = v31
	}

	p2[p3] = t

	return t
end

local function id_record_ensure(p1, p2) --[[ id_record_ensure | Line: 930 | Upvalues: id_record_create (copy) ]]
	local component_index = p1.component_index
	local v1 = component_index[p2]

	if v1 then
		return v1
	end

	return id_record_create(p1, component_index, p2)
end

local function archetype_append_to_records(p1, p2, p3, p4, p5, p6) --[[ archetype_append_to_records | Line: 941 ]]
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

local function archetype_create(p1, p2, p3, p4) --[[ archetype_create | Line: 962 | Upvalues: id_record_create (copy), v1 (copy) ]]
	-- structuring failed for function 40; please report this in our discord https://discord.gg/y63m4zUYa4
end

local function world_range(p1, p2, p3) --[[ world_range | Line: 1032 ]]
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

	entity_index.max_id = p2
	entity_index.alive_count = p2
end

local function archetype_ensure(p1, p2) --[[ archetype_ensure | Line: 1055 | Upvalues: archetype_create (copy) ]]
	if #p2 < 1 then
		return p1.ROOT_ARCHETYPE
	end

	local v1 = table.concat(p2, "_")
	local v2 = p1.archetype_index[v1]

	if v2 then
		return v2
	end

	return archetype_create(p1, p2, v1)
end

local function find_insert(p1, p2) --[[ find_insert | Line: 1069 ]]
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

local function find_archetype_without(p1, p2, p3) --[[ find_archetype_without | Line: 1081 | Upvalues: archetype_create (copy) ]]
	local types = p2.types
	local v1 = table.find(types, p3)
	local v2 = table.clone(types)

	table.remove(v2, v1)

	if #v2 < 1 then
		return p1.ROOT_ARCHETYPE
	end

	local v3 = table.concat(v2, "_")
	local v4 = p1.archetype_index[v3]

	if v4 then
		return v4
	end

	return archetype_create(p1, v2, v3)
end

local function create_edge_for_remove(p1, p2, p3, p4) --[[ create_edge_for_remove | Line: 1096 | Upvalues: archetype_create (copy) ]]
	local types = p2.types
	local v1 = table.find(types, p4)
	local v2 = table.clone(types)

	table.remove(v2, v1)

	local v3

	if #v2 < 1 then
		v3 = p1.ROOT_ARCHETYPE
	else
		local v4 = table.concat(v2, "_")

		v3 = p1.archetype_index[v4] or archetype_create(p1, v2, v4)
	end

	local archetype_edges = p1.archetype_edges

	archetype_edges[p2.id][p4] = v3
	archetype_edges[v3.id][p4] = p2

	return v3
end

local function archetype_traverse_remove(p1, p2, p3) --[[ archetype_traverse_remove | Line: 1110 | Upvalues: archetype_create (copy) ]]
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

			v2 = p1.archetype_index[v5] or archetype_create(p1, v4, v5)
		end

		v1[p2] = v2
		archetype_edges[v2.id][p2] = p3
	end

	return v2
end

local function find_archetype_with(p1, p2, p3) --[[ find_archetype_with | Line: 1128 | Upvalues: archetype_create (copy) ]]
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

	if v6 then
		return v6
	end

	return archetype_create(p1, v1, v5)
end

local function archetype_traverse_add(p1, p2, p3) --[[ archetype_traverse_add | Line: 1143 | Upvalues: archetype_create (copy) ]]
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

			v3 = p1.archetype_index[v9] or archetype_create(p1, v4, v9)
		end

		v2[p2] = v3
		archetype_edges[v3.id][p2] = v1
	end

	return v3
end

local function archetype_fast_delete_last(p1, p2) --[[ archetype_fast_delete_last | Line: 1165 | Upvalues: v1 (copy) ]]
	for v12, v2 in p1 do
		if v2 ~= v1 then
			v2[p2] = nil
		end
	end
end

local function archetype_fast_delete(p1, p2, p3) --[[ archetype_fast_delete | Line: 1173 | Upvalues: v1 (copy) ]]
	for v12, v2 in p1 do
		if v2 ~= v1 then
			v2[p3] = v2[p2]
			v2[p2] = nil
		end
	end
end

local function archetype_delete(p1, p2, p3) --[[ archetype_delete | Line: 1182 | Upvalues: v1 (copy) ]]
	local entity_index = p1.entity_index
	local columns = p2.columns
	local entities = p2.entities
	local v12 = #entities
	local v2 = #entities
	local v3 = entities[v2]

	if p3 ~= v2 then
		local v4 = entity_index.sparse_array[v3 % 16777216]
		local v5 = if v4 and v4.dense ~= 0 then v4 else nil

		if v5 then
			v5.row = p3
		end

		entities[p3] = v3
	end

	entities[v2] = nil

	if p3 == v2 then
		for v6, v7 in columns do
			if v7 ~= v1 then
				v7[v12] = nil
			end
		end
	else
		for v8, v9 in columns do
			if v9 ~= v1 then
				v9[p3] = v9[v12]
				v9[v12] = nil
			end
		end
	end
end

local function archetype_destroy(p1, p2) --[[ archetype_destroy | Line: 1210 ]]
	-- structuring failed for function 52; please report this in our discord https://discord.gg/y63m4zUYa4
end

local function NOOP() --[[ NOOP | Line: 1248 ]] end

local function query_archetypes(p1, p2) --[[ query_archetypes | Line: 1250 ]]
	local compatible_archetypes = p1.compatible_archetypes

	if not compatible_archetypes or p2 then
		compatible_archetypes = {}
		p1.compatible_archetypes = compatible_archetypes

		local world = p1.world
		local archetypes = world.archetypes
		local component_index = world.component_index
		local filter_with = p1.filter_with
		local v1 = nil

		for v2, v3 in filter_with do
			local v4 = component_index[v3]

			if v4 and (v1 == nil or v4.size < v1.size) then
				v1 = v4
			end
		end

		if v1 == nil then
			return compatible_archetypes
		end

		local filter_without = p1.filter_without

		for v5 in v1.records do
			local v6 = archetypes[v5]
			local columns_map = v6.columns_map
			local v7 = false

			for v8, v9 in filter_with do
				if not columns_map[v9] then
					v7 = true

					break
				end
			end

			if not v7 then
				if filter_without then
					for v10, v11 in filter_without do
						if columns_map[v11] then
							v7 = true

							break
						end
					end
				end

				if not v7 then
					table.insert(compatible_archetypes, v6)
				end
			end
		end
	end

	return compatible_archetypes
end

local function query_with(p1, ...) --[[ query_with | Line: 1312 ]]
	local ids = p1.ids
	local t = { ... }

	table.move(ids, 1, #ids, #t + 1, t)
	p1.filter_with = t

	return p1
end

local function query_without(p1, ...) --[[ query_without | Line: 1320 ]]
	p1.filter_without = { ... }

	return p1
end

local function query_iter_init(p1) --[[ query_iter_init | Line: 1326 | Upvalues: query_archetypes (copy), NOOP (copy) ]]
	local v1 = query_archetypes(p1)
	local v2 = 1
	local v3 = v1[1]

	if not v3 then
		return NOOP
	end

	local entities = v3.entities
	local v4 = #entities
	local columns_map = v3.columns_map
	local ids = p1.ids
	local v5, v6, v7, v8, v9, v10, v11, v12, v13 = unpack(ids)
	local v14 = nil
	local v15 = nil
	local v16 = nil
	local v17 = nil
	local v18 = nil
	local v19 = nil
	local v20 = nil

	if not v5 then
		local function world_query_iter_next() --[[ world_query_iter_next | Line: 1345 | Upvalues: entities (ref), v4 (ref), v2 (ref), v1 (copy), v3 (ref) ]]
			local v12 = entities[v4]

			while v12 == nil do
				v2 = v2 + 1

				local v22 = v1[v2]

				v3 = v22

				if not v22 then
					return nil
				end

				local entities2 = v22.entities

				v4 = #entities2

				if v4 ~= 0 then
					v12 = entities2[v4]
					entities = entities2
				end
			end

			v4 = v4 - 1

			return v12
		end

		p1.next = world_query_iter_next

		return world_query_iter_next
	end

	local v21

	if v6 then
		if v7 then
			if v8 then
				if v9 then
					if v10 then
						if v11 then
							if v12 then
								v21 = columns_map[v5]
								v14 = columns_map[v6]
								v15 = columns_map[v7]
								v16 = columns_map[v8]
								v17 = columns_map[v9]
								v18 = columns_map[v10]
								v19 = columns_map[v11]
								v20 = columns_map[v12]
							else
								v21 = columns_map[v5]
								v14 = columns_map[v6]
								v15 = columns_map[v7]
								v16 = columns_map[v8]
								v17 = columns_map[v9]
								v18 = columns_map[v10]
								v19 = columns_map[v11]
							end
						else
							v21 = columns_map[v5]
							v14 = columns_map[v6]
							v15 = columns_map[v7]
							v16 = columns_map[v8]
							v17 = columns_map[v9]
							v18 = columns_map[v10]
						end
					else
						v21 = columns_map[v5]
						v14 = columns_map[v6]
						v15 = columns_map[v7]
						v16 = columns_map[v8]
						v17 = columns_map[v9]
					end
				else
					v21 = columns_map[v5]
					v14 = columns_map[v6]
					v15 = columns_map[v7]
					v16 = columns_map[v8]
				end
			else
				v21 = columns_map[v5]
				v14 = columns_map[v6]
				v15 = columns_map[v7]
			end
		else
			v21 = columns_map[v5]
			v14 = columns_map[v6]
		end
	else
		v21 = columns_map[v5]
	end

	local v22

	if v6 then
		if v7 then
			if v8 then
				if v9 then
					if v10 then
						if v11 then
							if v12 then
								if v13 then
									local t = {}
									local v23 = #ids

									v22 = function() --[[ world_query_iter_next | Line: 1768 | Upvalues: entities (ref), v4 (ref), v21 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), v20 (ref), ids (copy), columns_map (ref), v2 (ref), v1 (copy), v3 (ref), v5 (copy), v6 (copy), v7 (copy), v8 (copy), v9 (copy), v10 (copy), v11 (copy), v12 (copy), v23 (copy), t (copy) ]]
										local v13 = entities[v4]
										local v22 = v21
										local v32 = v14
										local v42 = v15
										local v52 = v16
										local v62 = v17
										local v72 = v18
										local v82 = v19
										local v92 = v20
										local v102 = ids
										local v112 = columns_map

										while v13 == nil do
											v2 = v2 + 1

											local v122 = v1[v2]

											v3 = v122

											if not v122 then
												return nil
											end

											local entities2 = v122.entities

											v4 = #entities2

											if v4 ~= 0 then
												v13 = entities2[v4]
												entities = entities2
												v112 = v122.columns_map
												columns_map = v112
												v22 = v112[v5]
												v32 = v112[v6]
												v42 = v112[v7]
												v52 = v112[v8]
												v62 = v112[v9]
												v72 = v112[v10]
												v82 = v112[v11]
												v92 = v112[v12]
												v21 = v22
												v14 = v32
												v15 = v42
												v16 = v52
												v17 = v62
												v18 = v72
												v19 = v82
												v20 = v92
											end
										end

										local v132 = v4

										v4 = v4 - 1

										for i = 9, v23 do
											t[i - 8] = v112[v102[i]][v132]
										end

										return v13, v22[v132], v32[v132], v42[v132], v52[v132], v62[v132], v72[v132], v82[v132], v92[v132], unpack(t)
									end
								else
									v22 = function() --[[ world_query_iter_next | Line: 1712 | Upvalues: entities (ref), v4 (ref), v21 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), v20 (ref), v2 (ref), v1 (copy), v3 (ref), columns_map (ref), v5 (copy), v6 (copy), v7 (copy), v8 (copy), v9 (copy), v10 (copy), v11 (copy), v12 (copy) ]]
										local v13 = entities[v4]
										local v22 = v21
										local v32 = v14
										local v42 = v15
										local v52 = v16
										local v62 = v17
										local v72 = v18
										local v82 = v19
										local v92 = v20

										while v13 == nil do
											v2 = v2 + 1

											local v102 = v1[v2]

											v3 = v102

											if not v102 then
												return nil
											end

											local entities2 = v102.entities

											v4 = #entities2

											if v4 ~= 0 then
												v13 = entities2[v4]
												entities = entities2

												local columns_map2 = v102.columns_map

												columns_map = columns_map2
												v22 = columns_map2[v5]
												v32 = columns_map2[v6]
												v42 = columns_map2[v7]
												v52 = columns_map2[v8]
												v62 = columns_map2[v9]
												v72 = columns_map2[v10]
												v82 = columns_map2[v11]
												v92 = columns_map2[v12]
												v21 = v22
												v14 = v32
												v15 = v42
												v16 = v52
												v17 = v62
												v18 = v72
												v19 = v82
												v20 = v92
											end
										end

										local v112 = v4

										v4 = v4 - 1

										return v13, v22[v112], v32[v112], v42[v112], v52[v112], v62[v112], v72[v112], v82[v112], v92[v112]
									end
								end
							else
								v22 = function() --[[ world_query_iter_next | Line: 1661 | Upvalues: entities (ref), v4 (ref), v21 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), v2 (ref), v1 (copy), v3 (ref), columns_map (ref), v5 (copy), v6 (copy), v7 (copy), v8 (copy), v9 (copy), v10 (copy), v11 (copy) ]]
									local v12 = entities[v4]
									local v22 = v21
									local v32 = v14
									local v42 = v15
									local v52 = v16
									local v62 = v17
									local v72 = v18
									local v82 = v19

									while v12 == nil do
										v2 = v2 + 1

										local v92 = v1[v2]

										v3 = v92

										if not v92 then
											return nil
										end

										local entities2 = v92.entities

										v4 = #entities2

										if v4 ~= 0 then
											v12 = entities2[v4]
											entities = entities2

											local columns_map2 = v92.columns_map

											columns_map = columns_map2
											v22 = columns_map2[v5]
											v32 = columns_map2[v6]
											v42 = columns_map2[v7]
											v52 = columns_map2[v8]
											v62 = columns_map2[v9]
											v72 = columns_map2[v10]
											v82 = columns_map2[v11]
											v21 = v22
											v14 = v32
											v15 = v42
											v16 = v52
											v17 = v62
											v18 = v72
											v19 = v82
										end
									end

									local v102 = v4

									v4 = v4 - 1

									return v12, v22[v102], v32[v102], v42[v102], v52[v102], v62[v102], v72[v102], v82[v102]
								end
							end
						else
							v22 = function() --[[ world_query_iter_next | Line: 1613 | Upvalues: entities (ref), v4 (ref), v21 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v2 (ref), v1 (copy), v3 (ref), columns_map (ref), v5 (copy), v6 (copy), v7 (copy), v8 (copy), v9 (copy), v10 (copy) ]]
								local v12 = entities[v4]
								local v22 = v21
								local v32 = v14
								local v42 = v15
								local v52 = v16
								local v62 = v17
								local v72 = v18

								while v12 == nil do
									v2 = v2 + 1

									local v82 = v1[v2]

									v3 = v82

									if not v82 then
										return nil
									end

									local entities2 = v82.entities

									v4 = #entities2

									if v4 ~= 0 then
										v12 = entities2[v4]
										entities = entities2

										local columns_map2 = v82.columns_map

										columns_map = columns_map2
										v22 = columns_map2[v5]
										v32 = columns_map2[v6]
										v42 = columns_map2[v7]
										v52 = columns_map2[v8]
										v62 = columns_map2[v9]
										v72 = columns_map2[v10]
										v21 = v22
										v14 = v32
										v15 = v42
										v16 = v52
										v17 = v62
										v18 = v72
									end
								end

								local v92 = v4

								v4 = v4 - 1

								return v12, v22[v92], v32[v92], v42[v92], v52[v92], v62[v92], v72[v92]
							end
						end
					else
						v22 = function() --[[ world_query_iter_next | Line: 1568 | Upvalues: entities (ref), v4 (ref), v21 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v2 (ref), v1 (copy), v3 (ref), columns_map (ref), v5 (copy), v6 (copy), v7 (copy), v8 (copy), v9 (copy) ]]
							local v12 = entities[v4]
							local v22 = v21
							local v32 = v14
							local v42 = v15
							local v52 = v16
							local v62 = v17

							while v12 == nil do
								v2 = v2 + 1

								local v72 = v1[v2]

								v3 = v72

								if not v72 then
									return nil
								end

								local entities2 = v72.entities

								v4 = #entities2

								if v4 ~= 0 then
									v12 = entities2[v4]
									entities = entities2

									local columns_map2 = v72.columns_map

									columns_map = columns_map2
									v22 = columns_map2[v5]
									v32 = columns_map2[v6]
									v42 = columns_map2[v7]
									v52 = columns_map2[v8]
									v62 = columns_map2[v9]
									v21 = v22
									v14 = v32
									v15 = v42
									v16 = v52
									v17 = v62
								end
							end

							local v82 = v4

							v4 = v4 - 1

							return v12, v22[v82], v32[v82], v42[v82], v52[v82], v62[v82]
						end
					end
				else
					v22 = function() --[[ world_query_iter_next | Line: 1526 | Upvalues: entities (ref), v4 (ref), v21 (ref), v14 (ref), v15 (ref), v16 (ref), v2 (ref), v1 (copy), v3 (ref), columns_map (ref), v5 (copy), v6 (copy), v7 (copy), v8 (copy) ]]
						local v12 = entities[v4]
						local v22 = v21
						local v32 = v14
						local v42 = v15
						local v52 = v16

						while v12 == nil do
							v2 = v2 + 1

							local v62 = v1[v2]

							v3 = v62

							if not v62 then
								return nil
							end

							local entities2 = v62.entities

							v4 = #entities2

							if v4 ~= 0 then
								v12 = entities2[v4]
								entities = entities2

								local columns_map2 = v62.columns_map

								columns_map = columns_map2
								v22 = columns_map2[v5]
								v32 = columns_map2[v6]
								v42 = columns_map2[v7]
								v52 = columns_map2[v8]
								v21 = v22
								v14 = v32
								v15 = v42
								v16 = v52
							end
						end

						local v72 = v4

						v4 = v4 - 1

						return v12, v22[v72], v32[v72], v42[v72], v52[v72]
					end
				end
			else
				v22 = function() --[[ world_query_iter_next | Line: 1487 | Upvalues: entities (ref), v4 (ref), v21 (ref), v14 (ref), v15 (ref), v2 (ref), v1 (copy), v3 (ref), columns_map (ref), v5 (copy), v6 (copy), v7 (copy) ]]
					local v12 = entities[v4]
					local v22 = v21
					local v32 = v14
					local v42 = v15

					while v12 == nil do
						v2 = v2 + 1

						local v52 = v1[v2]

						v3 = v52

						if not v52 then
							return nil
						end

						local entities2 = v52.entities

						v4 = #entities2

						if v4 ~= 0 then
							v12 = entities2[v4]
							entities = entities2

							local columns_map2 = v52.columns_map

							columns_map = columns_map2
							v22 = columns_map2[v5]
							v32 = columns_map2[v6]
							v42 = columns_map2[v7]
							v21 = v22
							v14 = v32
							v15 = v42
						end
					end

					local v62 = v4

					v4 = v4 - 1

					return v12, v22[v62], v32[v62], v42[v62]
				end
			end
		else
			v22 = function() --[[ world_query_iter_next | Line: 1451 | Upvalues: entities (ref), v4 (ref), v21 (ref), v14 (ref), v2 (ref), v1 (copy), v3 (ref), columns_map (ref), v5 (copy), v6 (copy) ]]
				local v12 = entities[v4]
				local v22 = v21
				local v32 = v14

				while v12 == nil do
					v2 = v2 + 1

					local v42 = v1[v2]

					v3 = v42

					if not v42 then
						return nil
					end

					local entities2 = v42.entities

					v4 = #entities2

					if v4 ~= 0 then
						v12 = entities2[v4]
						entities = entities2

						local columns_map2 = v42.columns_map

						columns_map = columns_map2
						v22 = columns_map2[v5]
						v32 = columns_map2[v6]
						v21 = v22
						v14 = v32
					end
				end

				local v52 = v4

				v4 = v4 - 1

				return v12, v22[v52], v32[v52]
			end
		end
	else
		v22 = function() --[[ world_query_iter_next | Line: 1418 | Upvalues: entities (ref), v4 (ref), v21 (ref), v2 (ref), v1 (copy), v3 (ref), columns_map (ref), v5 (copy) ]]
			local v12 = entities[v4]
			local v22 = v21

			while v12 == nil do
				v2 = v2 + 1

				local v32 = v1[v2]

				v3 = v32

				if not v32 then
					return nil
				end

				local entities2 = v32.entities

				v4 = #entities2

				if v4 ~= 0 then
					v12 = entities2[v4]
					entities = entities2

					local columns_map2 = v32.columns_map

					columns_map = columns_map2
					v22 = columns_map2[v5]
					v21 = v22
				end
			end

			local v42 = v4

			v4 = v4 - 1

			return v12, v22[v42]
		end
	end

	p1.next = v22

	return v22
end

local function query_iter(p1) --[[ query_iter | Line: 1833 | Upvalues: query_iter_init (copy) ]]
	local v1 = p1.next

	if not v1 then
		v1 = query_iter_init(p1)
	end

	return v1
end

local function query_cached(p1) --[[ query_cached | Line: 1841 | Upvalues: query_archetypes (copy), NOOP (copy) ]]
	local ids = p1.ids
	local v1, v2, v3, v4, v5, v6, v7, v8, v9 = unpack(ids)

	if not v1 then
		v1 = p1.filter_with[1]
	end

	local v10 = query_archetypes(p1)
	local t = {}

	p1.archetypes_map = t

	local v11 = nil
	local v12 = nil
	local v13 = nil
	local v14 = nil
	local v15 = nil
	local v16 = nil
	local v17 = nil
	local v18 = nil
	local v19 = nil

	for v20, v21 in v10 do
		t[v21.id] = v20
	end

	local v22 = v10
	local v23 = 1
	local v24 = v22[1]
	local v25, v26, v27

	if v24 then
		v25 = v24.entities
		v26 = v24.columns_map
		v27 = #v25
	else
		v26 = {}
		v25 = {}
		v27 = 0
	end

	local world = p1.world
	local observable = world.observable
	local v28 = observable[268]

	if not v28 then
		v28 = {}
		observable[268] = v28
	end

	local v29 = v28[v1]

	if not v29 then
		v29 = {}
		v28[v1] = v29
	end

	local v30 = observable[269]

	if not v30 then
		v30 = {}
		observable[269] = v30
	end

	local v31 = v30[v1]

	if not v31 then
		v31 = {}
		v30[v1] = v31
	end

	local t2 = {
		query = p1,
		callback = function(p1) --[[ on_create_callback | Line: 1902 | Upvalues: v10 (copy), t (copy) ]]
			local v1 = #v10 + 1

			v10[v1] = p1
			t[p1.id] = v1
		end
	}
	local t3 = {
		query = p1,
		callback = function(p1) --[[ on_delete_callback | Line: 1908 | Upvalues: v10 (copy), t (copy) ]]
			local v1 = #v10
			local v2 = v10[v1]
			local id = p1.id
			local v3 = t[id]

			v10[v3] = v2
			v10[v1] = nil
			t[id] = nil
			t[v2.id] = v3
		end
	}

	table.insert(v29, t2)
	table.insert(v31, t3)

	local function cached_query_iter() --[[ cached_query_iter | Line: 1927 | Upvalues: v23 (ref), v22 (ref), v24 (ref), NOOP (ref), v25 (ref), v27 (ref), v26 (ref), v1 (ref), v2 (copy), v12 (ref), v3 (copy), v14 (ref), v4 (copy), v15 (ref), v5 (copy), v17 (ref), v6 (copy), v18 (ref), v7 (copy), v16 (ref), v8 (copy), v19 (ref), v13 (ref), v11 (ref) ]]
		v23 = 1
		v24 = v22[v23]

		if not v24 then
			return NOOP
		end

		v25 = v24.entities
		v27 = #v25
		v26 = v24.columns_map

		if not v1 then
			return v11
		end

		if v2 then
			if v3 then
				if v4 then
					if v5 then
						if v6 then
							if v7 then
								if v8 then
									v12 = v26[v1]
									v14 = v26[v2]
									v15 = v26[v3]
									v17 = v26[v4]
									v18 = v26[v5]
									v16 = v26[v6]
									v19 = v26[v7]
									v13 = v26[v8]
								else
									v12 = v26[v1]
									v14 = v26[v2]
									v15 = v26[v3]
									v17 = v26[v4]
									v18 = v26[v5]
									v16 = v26[v6]
									v19 = v26[v7]
								end
							else
								v12 = v26[v1]
								v14 = v26[v2]
								v15 = v26[v3]
								v17 = v26[v4]
								v18 = v26[v5]
								v16 = v26[v6]
							end
						else
							v12 = v26[v1]
							v14 = v26[v2]
							v15 = v26[v3]
							v17 = v26[v4]
							v18 = v26[v5]
						end
					else
						v12 = v26[v1]
						v14 = v26[v2]
						v15 = v26[v3]
						v17 = v26[v4]
					end
				else
					v12 = v26[v1]
					v14 = v26[v2]
					v15 = v26[v3]
				end
			else
				v12 = v26[v1]
				v14 = v26[v2]
			end
		else
			v12 = v26[v1]
		end

		return v11
	end

	if v1 then
		if v2 then
			if v3 then
				if v4 then
					if v5 then
						if v6 then
							if v7 then
								if v8 then
									if v9 then
										local t4 = {}
										local v32 = #ids

										_ = function() --[[ world_query_iter_next | Line: 2363 | Upvalues: v25 (ref), v27 (ref), v12 (ref), v14 (ref), v15 (ref), v17 (ref), v18 (ref), v16 (ref), v19 (ref), v13 (ref), ids (copy), v26 (ref), v23 (ref), v22 (ref), v24 (ref), v1 (ref), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), v7 (copy), v8 (copy), v32 (copy), t4 (copy) ]]
											local v110 = v25[v27]
											local v28 = v12
											local v33 = v14
											local v42 = v15
											local v52 = v17
											local v62 = v18
											local v72 = v16
											local v82 = v19
											local v9 = v13
											local v10 = ids
											local v11 = v26

											while v110 == nil do
												v23 = v23 + 1

												local v122 = v22[v23]

												v24 = v122

												if not v122 then
													return nil
												end

												local entities = v122.entities

												v27 = #entities

												if v27 ~= 0 then
													v110 = entities[v27]
													v25 = entities
													v11 = v122.columns_map
													v26 = v11
													v28 = v11[v1]
													v33 = v11[v2]
													v42 = v11[v3]
													v52 = v11[v4]
													v62 = v11[v5]
													v72 = v11[v6]
													v82 = v11[v7]
													v9 = v11[v8]
													v12 = v28
													v14 = v33
													v15 = v42
													v17 = v52
													v18 = v62
													v16 = v72
													v19 = v82
													v13 = v9
												end
											end

											local v132 = v27

											v27 = v27 - 1

											for i = 9, v32 do
												t4[i - 8] = v11[v10[i]][v132]
											end

											return v110, v28[v132], v33[v132], v42[v132], v52[v132], v62[v132], v72[v132], v82[v132], v9[v132], unpack(t4)
										end
									else
										_ = function() --[[ world_query_iter_next | Line: 2307 | Upvalues: v25 (ref), v27 (ref), v12 (ref), v14 (ref), v15 (ref), v17 (ref), v18 (ref), v16 (ref), v19 (ref), v13 (ref), v23 (ref), v22 (ref), v24 (ref), v26 (ref), v1 (ref), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), v7 (copy), v8 (copy) ]]
											local v110 = v25[v27]
											local v28 = v12
											local v32 = v14
											local v42 = v15
											local v52 = v17
											local v62 = v18
											local v72 = v16
											local v82 = v19
											local v9 = v13

											while v110 == nil do
												v23 = v23 + 1

												local v10 = v22[v23]

												v24 = v10

												if not v10 then
													return nil
												end

												local entities = v10.entities

												v27 = #entities

												if v27 ~= 0 then
													v110 = entities[v27]
													v25 = entities

													local columns_map = v10.columns_map

													v26 = columns_map
													v28 = columns_map[v1]
													v32 = columns_map[v2]
													v42 = columns_map[v3]
													v52 = columns_map[v4]
													v62 = columns_map[v5]
													v72 = columns_map[v6]
													v82 = columns_map[v7]
													v9 = columns_map[v8]
													v12 = v28
													v14 = v32
													v15 = v42
													v17 = v52
													v18 = v62
													v16 = v72
													v19 = v82
													v13 = v9
												end
											end

											local v11 = v27

											v27 = v27 - 1

											return v110, v28[v11], v32[v11], v42[v11], v52[v11], v62[v11], v72[v11], v82[v11], v9[v11]
										end
									end
								else
									_ = function() --[[ world_query_iter_next | Line: 2256 | Upvalues: v25 (ref), v27 (ref), v12 (ref), v14 (ref), v15 (ref), v17 (ref), v18 (ref), v16 (ref), v19 (ref), v23 (ref), v22 (ref), v24 (ref), v26 (ref), v1 (ref), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), v7 (copy) ]]
										local v13 = v25[v27]
										local v28 = v12
										local v32 = v14
										local v42 = v15
										local v52 = v17
										local v62 = v18
										local v72 = v16
										local v8 = v19

										while v13 == nil do
											v23 = v23 + 1

											local v9 = v22[v23]

											v24 = v9

											if not v9 then
												return nil
											end

											local entities = v9.entities

											v27 = #entities

											if v27 ~= 0 then
												v13 = entities[v27]
												v25 = entities

												local columns_map = v9.columns_map

												v26 = columns_map
												v28 = columns_map[v1]
												v32 = columns_map[v2]
												v42 = columns_map[v3]
												v52 = columns_map[v4]
												v62 = columns_map[v5]
												v72 = columns_map[v6]
												v8 = columns_map[v7]
												v12 = v28
												v14 = v32
												v15 = v42
												v17 = v52
												v18 = v62
												v16 = v72
												v19 = v8
											end
										end

										local v10 = v27

										v27 = v27 - 1

										return v13, v28[v10], v32[v10], v42[v10], v52[v10], v62[v10], v72[v10], v8[v10]
									end
								end
							else
								_ = function() --[[ world_query_iter_next | Line: 2208 | Upvalues: v25 (ref), v27 (ref), v12 (ref), v14 (ref), v15 (ref), v17 (ref), v18 (ref), v16 (ref), v23 (ref), v22 (ref), v24 (ref), v26 (ref), v1 (ref), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy) ]]
									local v13 = v25[v27]
									local v28 = v12
									local v32 = v14
									local v42 = v15
									local v52 = v17
									local v62 = v18
									local v7 = v16

									while v13 == nil do
										v23 = v23 + 1

										local v8 = v22[v23]

										v24 = v8

										if not v8 then
											return nil
										end

										local entities = v8.entities

										v27 = #entities

										if v27 ~= 0 then
											v13 = entities[v27]
											v25 = entities

											local columns_map = v8.columns_map

											v26 = columns_map
											v28 = columns_map[v1]
											v32 = columns_map[v2]
											v42 = columns_map[v3]
											v52 = columns_map[v4]
											v62 = columns_map[v5]
											v7 = columns_map[v6]
											v12 = v28
											v14 = v32
											v15 = v42
											v17 = v52
											v18 = v62
											v16 = v7
										end
									end

									local v9 = v27

									v27 = v27 - 1

									return v13, v28[v9], v32[v9], v42[v9], v52[v9], v62[v9], v7[v9]
								end
							end
						else
							_ = function() --[[ world_query_iter_next | Line: 2163 | Upvalues: v25 (ref), v27 (ref), v12 (ref), v14 (ref), v15 (ref), v17 (ref), v18 (ref), v23 (ref), v22 (ref), v24 (ref), v26 (ref), v1 (ref), v2 (copy), v3 (copy), v4 (copy), v5 (copy) ]]
								local v13 = v25[v27]
								local v28 = v12
								local v32 = v14
								local v42 = v15
								local v52 = v17
								local v6 = v18

								while v13 == nil do
									v23 = v23 + 1

									local v7 = v22[v23]

									v24 = v7

									if not v7 then
										return nil
									end

									local entities = v7.entities

									v27 = #entities

									if v27 ~= 0 then
										v13 = entities[v27]
										v25 = entities

										local columns_map = v7.columns_map

										v26 = columns_map
										v28 = columns_map[v1]
										v32 = columns_map[v2]
										v42 = columns_map[v3]
										v52 = columns_map[v4]
										v6 = columns_map[v5]
										v12 = v28
										v14 = v32
										v15 = v42
										v17 = v52
										v18 = v6
									end
								end

								local v8 = v27

								v27 = v27 - 1

								return v13, v28[v8], v32[v8], v42[v8], v52[v8], v6[v8]
							end
						end
					else
						_ = function() --[[ world_query_iter_next | Line: 2121 | Upvalues: v25 (ref), v27 (ref), v12 (ref), v14 (ref), v15 (ref), v17 (ref), v23 (ref), v22 (ref), v24 (ref), v26 (ref), v1 (ref), v2 (copy), v3 (copy), v4 (copy) ]]
							local v13 = v25[v27]
							local v28 = v12
							local v32 = v14
							local v42 = v15
							local v5 = v17

							while v13 == nil do
								v23 = v23 + 1

								local v6 = v22[v23]

								v24 = v6

								if not v6 then
									return nil
								end

								local entities = v6.entities

								v27 = #entities

								if v27 ~= 0 then
									v13 = entities[v27]
									v25 = entities

									local columns_map = v6.columns_map

									v26 = columns_map
									v28 = columns_map[v1]
									v32 = columns_map[v2]
									v42 = columns_map[v3]
									v5 = columns_map[v4]
									v12 = v28
									v14 = v32
									v15 = v42
									v17 = v5
								end
							end

							local v7 = v27

							v27 = v27 - 1

							return v13, v28[v7], v32[v7], v42[v7], v5[v7]
						end
					end
				else
					_ = function() --[[ world_query_iter_next | Line: 2082 | Upvalues: v25 (ref), v27 (ref), v12 (ref), v14 (ref), v15 (ref), v23 (ref), v22 (ref), v24 (ref), v26 (ref), v1 (ref), v2 (copy), v3 (copy) ]]
						local v13 = v25[v27]
						local v28 = v12
						local v32 = v14
						local v4 = v15

						while v13 == nil do
							v23 = v23 + 1

							local v5 = v22[v23]

							v24 = v5

							if not v5 then
								return nil
							end

							local entities = v5.entities

							v27 = #entities

							if v27 ~= 0 then
								v13 = entities[v27]
								v25 = entities

								local columns_map = v5.columns_map

								v26 = columns_map
								v28 = columns_map[v1]
								v32 = columns_map[v2]
								v4 = columns_map[v3]
								v12 = v28
								v14 = v32
								v15 = v4
							end
						end

						local v6 = v27

						v27 = v27 - 1

						return v13, v28[v6], v32[v6], v4[v6]
					end
				end
			else
				_ = function() --[[ world_query_iter_next | Line: 2046 | Upvalues: v25 (ref), v27 (ref), v12 (ref), v14 (ref), v23 (ref), v22 (ref), v24 (ref), v26 (ref), v1 (ref), v2 (copy) ]]
					local v13 = v25[v27]
					local v28 = v12
					local v3 = v14

					while v13 == nil do
						v23 = v23 + 1

						local v4 = v22[v23]

						v24 = v4

						if not v4 then
							return nil
						end

						local entities = v4.entities

						v27 = #entities

						if v27 ~= 0 then
							v13 = entities[v27]
							v25 = entities

							local columns_map = v4.columns_map

							v26 = columns_map
							v28 = columns_map[v1]
							v3 = columns_map[v2]
							v12 = v28
							v14 = v3
						end
					end

					local v5 = v27

					v27 = v27 - 1

					return v13, v28[v5], v3[v5]
				end
			end
		else
			_ = function() --[[ world_query_iter_next | Line: 2013 | Upvalues: v25 (ref), v27 (ref), v12 (ref), v23 (ref), v22 (ref), v24 (ref), v26 (ref), v1 (ref) ]]
				local v13 = v25[v27]
				local v2 = v12

				while v13 == nil do
					v23 = v23 + 1

					local v3 = v22[v23]

					v24 = v3

					if not v3 then
						return nil
					end

					local entities = v3.entities

					v27 = #entities

					if v27 ~= 0 then
						v13 = entities[v27]
						v25 = entities

						local columns_map = v3.columns_map

						v26 = columns_map
						v2 = columns_map[v1]
						v12 = v2
					end
				end

				local v4 = v27

				v27 = v27 - 1

				return v13, v2[v4]
			end
		end
	else
		_ = function() --[[ world_query_iter_next | Line: 1988 | Upvalues: v25 (ref), v27 (ref), v23 (ref), v22 (ref), v24 (ref) ]]
			local v1 = v25[v27]

			while v1 == nil do
				v23 = v23 + 1

				local v2 = v22[v23]

				v24 = v2

				if not v2 then
					return nil
				end

				local entities = v2.entities

				v27 = #entities

				if v27 ~= 0 then
					v1 = entities[v27]
					v25 = entities
				end
			end

			v27 = v27 - 1

			return v1
		end
	end

	local entity_index = world.entity_index

	local function cached_query_has(p1, p2) --[[ cached_query_has | Line: 2426 | Upvalues: entity_index (copy), t (copy) ]]
		local v1 = entity_index
		local v2 = v1.sparse_array[p2 % 16777216]
		local v3 = if v2 and v2.dense ~= 0 then v2 else nil
		local v4 = v3 and (if v1.dense_array[v3.dense] == p2 then v3 else nil)

		if not v4 then
			return false
		end

		local archetype = v4.archetype

		if not archetype then
			return false
		end

		return t[archetype.id] ~= nil
	end

	local function cached_query_fini() --[[ cached_query_fini | Line: 2440 | Upvalues: v29 (ref), t2 (copy), v31 (ref), t3 (copy), v22 (ref) ]]
		local v1 = table.find(v29, t2)

		if v1 then
			table.remove(v29, v1)
		end

		local v2 = table.find(v31, t3)

		if v2 then
			table.remove(v31, v2)
		end

		v22 = nil
	end

	p1.archetypes = query_archetypes
	p1.__iter = cached_query_iter
	p1.iter = cached_query_iter
	p1.has = cached_query_has
	p1.fini = cached_query_fini
	setmetatable(p1, p1)

	return p1
end

local function query_has(p1, p2) --[[ query_has | Line: 2468 ]]
	local entity_index = p1.world.entity_index
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

	local columns_map = archetype.columns_map

	for v4, v5 in p1.filter_with do
		if not columns_map[v5] then
			return false
		end
	end

	local filter_without = p1.filter_without

	if not filter_without then
		return true
	end

	for v6, v7 in filter_without do
		if columns_map[v7] then
			return false
		end
	end

	return true
end

local t2 = {}

t2.__index = t2
t2.__iter = query_iter
t2.iter = query_iter_init
t2.without = query_without
t2.with = query_with
t2.archetypes = query_archetypes
t2.cached = query_cached
t2.has = query_has

local function world_query(p1, ...) --[[ world_query | Line: 2508 | Upvalues: t2 (copy) ]]
	local t = { ... }

	return setmetatable({
		ids = t,
		filter_with = t,
		world = p1
	}, t2)
end

local function world_each(p1, p2) --[[ world_each | Line: 2519 | Upvalues: NOOP (copy) ]]
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

		return function() --[[ Line: 2536 | Upvalues: entities (ref), v4 (ref), v2 (ref), records (copy), v3 (ref), archetypes (copy) ]]
			local v1 = entities[v4]

			while not v1 do
				v2 = next(records, v2)

				if not v2 then
					return nil
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

local function world_children(p1, p2) --[[ world_children | Line: 2553 | Upvalues: NOOP (copy) ]]
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

		return function() --[[ Line: 2536 | Upvalues: entities (ref), v4 (ref), v2 (ref), records (copy), v3 (ref), archetypes (copy) ]]
			local v1 = entities[v4]

			while not v1 do
				v2 = next(records, v2)

				if not v2 then
					return nil
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

local function ecs_bulk_insert(p1, p2, p3, p4) --[[ ecs_bulk_insert | Line: 2557 | Upvalues: archetype_create (copy), archetype_move (copy) ]]
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

			v10 = p1.archetype_index[v11] or archetype_create(p1, v4, v11)
		end

		if archetype == v10 then
			for v14, v15 in p3 do
				local v16 = p4[v14]
				local on_change = component_index[v15].on_change

				if on_change then
					on_change(p2, v15, v16, archetype)
				end

				if v16 ~= nil then
					v3.archetype.columns_map[v15][v3.row] = v16
				end
			end
		else
			local entities = v10.entities
			local v17 = #entities + 1

			entities[v17] = p2
			archetype_move(entity_index, p2, v10, v17, v3.archetype, v3.row)
			v3.archetype = v10
			v3.row = v17

			for v18, v19 in p3 do
				local v20 = p4[v18]

				if v20 ~= nil then
					v3.archetype.columns_map[v19][v3.row] = v20
				end
			end

			for v21, v22 in t do
				local v23 = p4[v21]
				local v24 = p3[v21]
				local v25 = component_index[v24]

				if v22 then
					local on_change = v25.on_change

					if on_change then
						on_change(p2, v24, v23, archetype)
					end

					continue
				end

				local on_add = v25.on_add

				if on_add then
					on_add(p2, v24, v23, archetype)
				end
			end
		end
	else
		local v26 = table.clone(p3)

		table.sort(v26)

		local v27

		if #v26 < 1 then
			v27 = p1.ROOT_ARCHETYPE
		else
			local v28 = table.concat(v26, "_")

			v27 = p1.archetype_index[v28] or archetype_create(p1, v26, v28)
		end

		local entities = v27.entities
		local v31 = #entities + 1

		entities[v31] = p2
		v3.archetype = v27
		v3.row = v31

		local ROOT_ARCHETYPE = p1.ROOT_ARCHETYPE

		for v32, v33 in p3 do
			local v34 = p4[v32]

			if v34 then
				v3.archetype.columns_map[v33][v3.row] = v34
			end
		end

		for v35, v36 in p3 do
			local on_add = component_index[v36].on_add

			if on_add then
				on_add(p2, v36, p4[v35], ROOT_ARCHETYPE)
			end
		end
	end
end

local function ecs_bulk_remove(p1, p2, p3) --[[ ecs_bulk_remove | Line: 2653 | Upvalues: archetype_create (copy), archetype_move (copy) ]]
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

		v9 = p1.archetype_index[v10] or archetype_create(p1, v6, v10)
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

local function world_new(p1) --[[ world_new | Line: 2702 | Upvalues: v3 (ref), archetype_create (copy), v1 (copy), archetype_delete (copy), archetype_destroy (copy), archetype_move (copy), world_query (copy), world_each (copy), world_children (copy), world_range (copy), ECS_ID (copy), ENTITY_INDEX_NEW_ID (copy), v4 (ref), t (ref), v2 (copy) ]]
	local t2 = {}
	local t3 = {}
	local t4 = {
		alive_count = 0,
		max_id = 0,
		dense_array = t2,
		sparse_array = t3
	}
	local v12 = table.create(271)
	local t5 = {}
	local t6 = {}
	local t7 = {}
	local t8 = {
		added = {},
		changed = {},
		removed = {}
	}
	local v22 = v3
	local t9 = {
		ROOT_ARCHETYPE = nil,
		max_archetype_id = 0,
		archetype_edges = t7,
		component_index = v12,
		entity_index = t4,
		archetypes = t6,
		archetype_index = t5,
		max_component_id = v3,
		observable = {},
		signals = t8
	}
	local v32 = archetype_create(t9, {}, "")

	t9.ROOT_ARCHETYPE = v32

	local function entity_index_try_get_any(p1) --[[ entity_index_try_get_any | Line: 2754 | Upvalues: t3 (copy) ]]
		return t3[p1 % 16777216]
	end

	local function inner_archetype_move(p1, p2, p3, p4, p5) --[[ inner_archetype_move | Line: 2759 | Upvalues: v1 (ref), t3 (copy) ]]
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

	local function inner_entity_move(p1, p2, p3) --[[ inner_entity_move | Line: 2815 | Upvalues: inner_archetype_move (copy) ]]
		local entities = p3.entities
		local v1 = #entities + 1

		entities[v1] = p1
		inner_archetype_move(p1, p3, v1, p2.archetype, p2.row)
		p2.archetype = p3
		p2.row = v1
	end

	local function entity_index_try_get_unsafe(p1) --[[ entity_index_try_get_unsafe | Line: 2842 | Upvalues: t3 (copy), t2 (copy) ]]
		local v2 = t3[p1 % 16777216]

		if v2 and t2[v2.dense] ~= p1 then
			return nil
		end

		return v2
	end

	local function exclusive_traverse_add(p1, p2, p3) --[[ exclusive_traverse_add | Line: 2858 | Upvalues: t7 (copy), t9 (copy), archetype_create (ref) ]]
		local v1 = t7[p1.id]
		local v2 = v1[p3]

		if not v2 then
			local v3 = table.clone(p1.types)

			v3[p2] = p3

			local v4 = t9

			if #v3 < 1 then
				v2 = v4.ROOT_ARCHETYPE
			else
				local v5 = table.concat(v3, "_")

				v2 = v4.archetype_index[v5] or archetype_create(v4, v3, v5)
			end

			v1[p3] = v2
		end

		return v2
	end

	local function world_set(p1, p2, p3, p4) --[[ world_set | Line: 2874 | Upvalues: t3 (copy), t2 (copy), v32 (copy), v12 (copy), t7 (copy), t9 (copy), archetype_create (ref), inner_archetype_move (copy) ]]
		local v2 = t3[p2 % 16777216]
		local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

		if not v3 then
			return
		end

		local archetype = v3.archetype
		local v4 = archetype or v32
		local v5 = v4.columns_map[p3]

		if v5 then
			v5[v3.row] = p4

			local on_change = v12[p3].on_change

			if on_change then
				on_change(p2, p3, p4, v4)
			end
		else
			local v8, v9

			if if p3 > 281474976710656 then true else false then
				local v10 = 260 + (p3 - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656

				v8 = v12[v10]

				local v11 = t7[v4.id]

				v9 = v11[p3]

				if v9 == nil then
					if v8 and bit32.btest(v8.flags, 4) == true then
						local v122 = v8.records[v4.id]

						if v122 then
							local on_remove = v8.on_remove
							local types = v4.types

							if on_remove then
								on_remove(p2, types[v122])
								v4 = v3.archetype

								local types2 = v4.types

								v122 = v8.records[v4.id]
							end

							local v13 = t7[v4.id]
							local v14 = v13[p3]

							if not v14 then
								local v15 = table.clone(v4.types)

								v15[v122] = p3

								local v16 = t9

								if #v15 < 1 then
									v14 = v16.ROOT_ARCHETYPE
								else
									local v17 = table.concat(v15, "_")

									v14 = v16.archetype_index[v17] or archetype_create(v16, v15, v17)
								end

								v13[p3] = v14
							end

							v9 = v14
						end
					end

					if not v9 then
						local types = v4.types
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
							v9 = p1.ROOT_ARCHETYPE
						else
							local v24 = table.concat(v20, "_")

							v9 = p1.archetype_index[v24] or archetype_create(p1, v20, v24)
						end

						if not v8 then
							v8 = v12[v10]
						end

						v11[p3] = v9
						t7[v9.id][p3] = v4
					end
				elseif bit32.btest(v8.flags, 4) then
					local on_remove = v8.on_remove

					if on_remove then
						local v27 = v8.records[v4.id]

						if v27 then
							on_remove(p2, v4.types[v27])

							local archetype2 = v3.archetype

							if v4 ~= archetype2 then
								local types = archetype2.types
								local v28 = v8.records[archetype2.id]
								local v29 = t7[archetype2.id]
								local v30 = v29[p3]

								if not v30 then
									local v31 = table.clone(archetype2.types)

									v31[v28] = p3

									local v322 = t9

									if #v31 < 1 then
										v30 = v322.ROOT_ARCHETYPE
									else
										local v33 = table.concat(v31, "_")

										v30 = v322.archetype_index[v33] or archetype_create(v322, v31, v33)
									end

									v29[p3] = v30
								end

								v9 = v30
							end
						end
					end
				end
			else
				local v36 = t7
				local v37 = v36[v4.id]

				v9 = v37[p3]

				if not v9 then
					local types = v4.types
					local v38 = table.clone(types)
					local v39

					do
						local __inline_returned = false

						for v40, v41 in types do
							if v41 == p3 then
								v39 = -1
								__inline_returned = true

								break
							elseif p3 < v41 then
								v39 = v40
								__inline_returned = true

								break
							end
						end

						if not __inline_returned then
							v39 = #types + 1
						end
					end

					table.insert(v38, v39, p3)

					if #v38 < 1 then
						v9 = p1.ROOT_ARCHETYPE
					else
						local v42 = table.concat(v38, "_")

						v9 = p1.archetype_index[v42] or archetype_create(p1, v38, v42)
					end

					v37[p3] = v9
					v36[v9.id][p3] = v4
				end

				v8 = v12[p3]
			end

			if archetype then
				local entities = v9.entities
				local v45 = #entities + 1

				entities[v45] = p2
				inner_archetype_move(p2, v9, v45, v3.archetype, v3.row)
				v3.archetype = v9
				v3.row = v45
			else
				local entities = v9.entities
				local v46 = #entities + 1

				entities[v46] = p2
				v3.archetype = v9
				v3.row = v46
			end

			v9.columns_map[p3][v3.row] = p4

			local on_add = v8.on_add

			if not on_add then
				return
			end

			on_add(p2, p3, p4, v4)
		end
	end

	local function world_add(p1, p2, p3) --[[ world_add | Line: 2977 | Upvalues: t3 (copy), t2 (copy), v32 (copy), v12 (copy), t7 (copy), t9 (copy), archetype_create (ref), inner_archetype_move (copy) ]]
		local v2 = t3[p2 % 16777216]
		local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

		if not v3 then
			return
		end

		local archetype = v3.archetype
		local v4 = archetype or v32

		if v4.columns_map[p3] then
			return
		end

		local v6, v7

		if if p3 > 281474976710656 then true else false then
			local v8 = 260 + (p3 - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656

			v6 = v12[v8]

			local v9 = t7[v4.id]

			v7 = v9[p3]

			if v7 == nil then
				if v6 and bit32.btest(v6.flags, 4) == true then
					local v10 = v6.records[v4.id]

					if v10 then
						local on_remove = v6.on_remove
						local types = v4.types

						if on_remove then
							on_remove(p2, types[v10])
							v4 = v3.archetype

							local types2 = v4.types

							v10 = v6.records[v4.id]
						end

						local v11 = t7[v4.id]
						local v122 = v11[p3]

						if not v122 then
							local v13 = table.clone(v4.types)

							v13[v10] = p3

							local v14 = t9

							if #v13 < 1 then
								v122 = v14.ROOT_ARCHETYPE
							else
								local v15 = table.concat(v13, "_")

								v122 = v14.archetype_index[v15] or archetype_create(v14, v13, v15)
							end

							v11[p3] = v122
						end

						v7 = v122
					end
				end

				if not v7 then
					local types = v4.types
					local v18 = table.clone(types)
					local v19

					do
						local __inline_returned = false

						for v20, v21 in types do
							if v21 == p3 then
								v19 = -1
								__inline_returned = true

								break
							elseif p3 < v21 then
								v19 = v20
								__inline_returned = true

								break
							end
						end

						if not __inline_returned then
							v19 = #types + 1
						end
					end

					table.insert(v18, v19, p3)

					if #v18 < 1 then
						v7 = p1.ROOT_ARCHETYPE
					else
						local v22 = table.concat(v18, "_")

						v7 = p1.archetype_index[v22] or archetype_create(p1, v18, v22)
					end

					if not v6 then
						v6 = v12[v8]
					end

					v9[p3] = v7
					t7[v7.id][p3] = v4
				end
			elseif bit32.btest(v6.flags, 4) then
				local on_remove = v6.on_remove

				if on_remove then
					local v25 = v6.records[v4.id]

					if v25 then
						on_remove(p2, v4.types[v25])

						local archetype2 = v3.archetype

						if v4 ~= archetype2 then
							local types = archetype2.types
							local v26 = v6.records[archetype2.id]
							local v27 = t7[archetype2.id]
							local v28 = v27[p3]

							if not v28 then
								local v29 = table.clone(archetype2.types)

								v29[v26] = p3

								local v30 = t9

								if #v29 < 1 then
									v28 = v30.ROOT_ARCHETYPE
								else
									local v31 = table.concat(v29, "_")

									v28 = v30.archetype_index[v31] or archetype_create(v30, v29, v31)
								end

								v27[p3] = v28
							end

							v7 = v28
						end
					end
				end
			end
		else
			local v34 = t7
			local v35 = v34[v4.id]

			v7 = v35[p3]

			if not v7 then
				local types = v4.types
				local v36 = table.clone(types)
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

				table.insert(v36, v37, p3)

				if #v36 < 1 then
					v7 = p1.ROOT_ARCHETYPE
				else
					local v40 = table.concat(v36, "_")

					v7 = p1.archetype_index[v40] or archetype_create(p1, v36, v40)
				end

				v35[p3] = v7
				v34[v7.id][p3] = v4
			end

			v6 = v12[p3]
		end

		if archetype then
			local entities = v7.entities
			local v43 = #entities + 1

			entities[v43] = p2
			inner_archetype_move(p2, v7, v43, v3.archetype, v3.row)
			v3.archetype = v7
			v3.row = v43
		elseif #v7.types > 0 then
			local entities = v7.entities
			local v44 = #entities + 1

			entities[v44] = p2
			v3.archetype = v7
			v3.row = v44
		end

		local on_add = v6.on_add

		if not on_add then
			return
		end

		on_add(p2, p3, nil, v4)
	end

	local function world_get(p1, p2, p3, p4, p5, p6, p7) --[[ world_get | Line: 3075 | Upvalues: t3 (copy), t2 (copy) ]]
		local v2 = t3[p2 % 16777216]
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

	function t9.added(p1, p2, p3) --[[ Line: 3109 | Upvalues: t8 (copy), t9 (copy), t3 (copy), t2 (copy), v12 (copy), world_set (copy) ]]
		local v1 = t8.added[p2]

		if not v1 then
			v1 = {}
			t8.added[p2] = v1

			local function on_add(p1, p2, p3, p4) --[[ on_add | Line: 3115 | Upvalues: v1 (ref) ]]
				for v12, v2 in v1 do
					v2(p1, p2, p3, p4)
				end
			end

			local v3 = t3[p2 % 16777216]
			local v4 = if v3 and t2[v3.dense] ~= p2 then nil else v3
			local v5

			if v4 then
				local archetype = v4.archetype

				if archetype then
					local v6 = archetype.columns_map[257]

					v5 = if v6 then v6[v4.row] else nil
				else
					v5 = nil
				end
			else
				v5 = nil
			end

			if v5 then
				table.insert(v1, v5)
			end

			local v8 = v12[260 + p2 % 16777216 * 16777216 + 281474976710656]

			if v8 then
				for v9, v10 in v8.wildcard_pairs do
					v10.on_add = on_add
				end

				v8.on_add = on_add
			else
				local v11 = v12[p2]

				if v11 then
					v11.on_add = on_add
				end
			end

			world_set(t9, p2, 257, on_add)
		end

		local v122 = v1

		table.insert(v122, p3)

		return function() --[[ Line: 3141 | Upvalues: v1 (ref), p3 (copy) ]]
			local v12 = #v1

			v1[table.find(v1, p3)] = v1[v12]
			v1[v12] = nil
		end
	end
	function t9.changed(p1, p2, p3) --[[ Line: 3149 | Upvalues: t8 (copy), t9 (copy), t3 (copy), t2 (copy), v12 (copy), world_set (copy) ]]
		local v1 = t8.changed[p2]

		if not v1 then
			v1 = {}
			t8.changed[p2] = v1

			local function on_change(p1, p2, p3, p4) --[[ on_change | Line: 3158 | Upvalues: v1 (ref) ]]
				for v12, v2 in v1 do
					v2(p1, p2, p3, p4)
				end
			end

			local v3 = t3[p2 % 16777216]
			local v4 = if v3 and t2[v3.dense] ~= p2 then nil else v3
			local v5

			if v4 then
				local archetype = v4.archetype

				if archetype then
					local v6 = archetype.columns_map[259]

					v5 = if v6 then v6[v4.row] else nil
				else
					v5 = nil
				end
			else
				v5 = nil
			end

			if v5 then
				table.insert(v1, v5)
			end

			local v8 = v12[260 + p2 % 16777216 * 16777216 + 281474976710656]

			if v8 then
				for v9, v10 in v8.wildcard_pairs do
					v10.on_change = on_change
				end

				v8.on_change = on_change
			else
				local v11 = v12[p2]

				if v11 then
					v11.on_change = on_change
				end
			end

			world_set(t9, p2, 259, on_change)
		end

		local v122 = v1

		table.insert(v122, p3)

		return function() --[[ Line: 3186 | Upvalues: v1 (ref), p3 (copy) ]]
			local v12 = #v1

			v1[table.find(v1, p3)] = v1[v12]
			v1[v12] = nil
		end
	end
	function t9.removed(p1, p2, p3) --[[ Line: 3194 | Upvalues: t8 (copy), t9 (copy), t3 (copy), t2 (copy), v12 (copy), world_set (copy) ]]
		local v1 = t8.removed[p2]

		if not v1 then
			v1 = {}
			t8.removed[p2] = v1

			local function on_remove(p1, p2, p3) --[[ on_remove | Line: 3199 | Upvalues: v1 (ref) ]]
				for v12, v2 in v1 do
					v2(p1, p2, p3)
				end
			end

			local v3 = t3[p2 % 16777216]
			local v4 = if v3 and t2[v3.dense] ~= p2 then nil else v3
			local v5

			if v4 then
				local archetype = v4.archetype

				if archetype then
					local v6 = archetype.columns_map[258]

					v5 = if v6 then v6[v4.row] else nil
				else
					v5 = nil
				end
			else
				v5 = nil
			end

			if v5 then
				table.insert(v1, v5)
			end

			local v8 = v12[260 + p2 % 16777216 * 16777216 + 281474976710656]

			if v8 then
				for v9, v10 in v8.wildcard_pairs do
					v10.on_remove = on_remove
				end

				v8.on_remove = on_remove
			else
				local v11 = v12[p2]

				if v11 then
					v11.on_remove = on_remove
				end
			end

			world_set(t9, p2, 258, on_remove)
		end

		local v122 = v1

		table.insert(v122, p3)

		return function() --[[ Line: 3230 | Upvalues: v1 (ref), p3 (copy) ]]
			local v12 = #v1

			v1[table.find(v1, p3)] = v1[v12]
			v1[v12] = nil
		end
	end

	local function world_has(p1, p2, p3, p4, p5, p6, p7) --[[ world_has | Line: 3238 | Upvalues: t3 (copy), t2 (copy) ]]
		local v2 = t3[p2 % 16777216]
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

	local function world_target(p1, p2, p3, p4) --[[ world_target | Line: 3260 | Upvalues: t3 (copy), t2 (copy) ]]
		local v2 = t3[p2 % 16777216]
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
			return nil
		end

		local v7 = archetype.types[v6 + v4.records[id]]

		if not v7 then
			return nil
		end

		local entity_index = p1.entity_index
		local v8 = entity_index.sparse_array[(v7 - 281474976710656) % 16777216 % 16777216]
		local v9 = if v8 and v8.dense ~= 0 then v8 else nil

		if not v9 then
			return nil
		end

		local dense = v9.dense

		if entity_index.alive_count < dense then
			return nil
		end

		return entity_index.dense_array[dense]
	end

	local function world_parent(p1, p2) --[[ world_parent | Line: 3300 | Upvalues: world_target (copy) ]]
		return world_target(p1, p2, 261, 0)
	end

	local function world_entity(p1, p2) --[[ world_entity | Line: 3304 | Upvalues: t3 (copy), t2 (copy), t4 (copy) ]]
		local v1 = t3
		local v2 = t2

		if p2 then
			local v3 = p2 % 16777216
			local alive_count = t4.alive_count
			local v4 = v1[v3]

			if v4 then
				local dense = v4.dense

				if dense == 0 then
					local v5 = alive_count + 1

					t4.alive_count = v5
					v4.dense = v5
					v2[v5] = p2

					return p2
				end

				local v6 = v2[dense]

				if v6 and v6 ~= p2 then
					local v7 = alive_count + 1

					t4.alive_count = v7
					v4.dense = v7
					v2[v7] = p2

					return p2
				end
			else
				local max_id = t4.max_id

				if max_id < v3 then
					for i = max_id + 1, v3 - 1 do
						v1[i] = {
							dense = 0
						}
					end

					t4.max_id = v3
				end

				local v8 = alive_count + 1

				t4.alive_count = v8
				v2[v8] = p2
				v1[v3] = {
					dense = v8
				}
			end

			return p2
		end

		local alive_count = t4.alive_count
		local max_id = t4.max_id
		local v9 = alive_count + 1

		if alive_count < max_id then
			local v10 = v2[v9]

			if v10 then
				t4.alive_count = v9

				return v10
			end
		end

		local v11 = max_id + 1
		local range_end = t4.range_end

		if if range_end == nil then true elseif v11 < range_end then true else false then
			t4.max_id = v11
			t4.alive_count = v9
			v2[v9] = v11
			v1[v11] = {
				dense = v9
			}

			return v11
		end

		error("Entity is outside range")
	end

	local function world_remove(p1, p2, p3) --[[ world_remove | Line: 3384 | Upvalues: t3 (copy), t2 (copy), archetype_create (ref), inner_archetype_move (copy) ]]
		local v2 = t3[p2 % 16777216]
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

				v5 = p1.archetype_index[v8] or archetype_create(p1, v7, v8)
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

	local function v42(p1, p2) --[[ world_delete | Line: 3409 | Upvalues: t3 (copy), t2 (copy), v12 (copy), archetype_delete (ref), v42 (ref), archetype_destroy (ref), archetype_create (ref), inner_archetype_move (copy), t4 (copy), archetype_move (ref) ]]
		local v2 = t3[p2 % 16777216]
		local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

		if not v3 then
			return
		end

		local archetype = v3.archetype

		if archetype then
			for v4, v5 in archetype.types do
				local on_remove = v12[v5].on_remove

				if on_remove then
					on_remove(p2, v5, true)
				end
			end

			archetype_delete(p1, v3.archetype, v3.row)
		end

		local component_index = p1.component_index
		local archetypes = p1.archetypes
		local v6 = component_index[p2 % 16777216 + 4362076160 + 281474976710656]
		local v7 = component_index[p2]
		local v8 = component_index[260 + p2 % 16777216 * 16777216 + 281474976710656]

		if v7 and bit32.btest(v7.flags, 1) == true then
			for v9 in v7.records do
				local v10 = archetypes[v9]
				local entities = v10.entities

				for i = #entities, 1, -1 do
					v42(p1, entities[i])
				end

				archetype_destroy(p1, v10)
			end
		elseif v7 then
			local on_remove = v7.on_remove

			if on_remove then
				for v11 in v7.records do
					local v122 = archetypes[v11]
					local archetype_edges = p1.archetype_edges
					local v13 = archetype_edges[v122.id]
					local v14 = v13[p2]

					if v14 == nil then
						local types = v122.types
						local v15 = table.find(types, p2)
						local v16 = table.clone(types)

						table.remove(v16, v15)

						if #v16 < 1 then
							v14 = p1.ROOT_ARCHETYPE
						else
							local v17 = table.concat(v16, "_")

							v14 = p1.archetype_index[v17] or archetype_create(p1, v16, v17)
						end

						v13[p2] = v14
						archetype_edges[v14.id][p2] = v122
					end

					local entities = v122.entities
					local v20 = v14

					for j = #entities, 1, -1 do
						local v21 = entities[j]

						on_remove(v21, p2)

						local v22 = t3[v21 % 16777216]
						local archetype2 = v22.archetype

						if archetype2 ~= v122 then
							local archetype_edges2 = p1.archetype_edges
							local v23 = archetype_edges2[archetype2.id]
							local v24 = v23[p2]

							if v24 == nil then
								local types = archetype2.types
								local v25 = table.find(types, p2)
								local v26 = table.clone(types)

								table.remove(v26, v25)

								if #v26 < 1 then
									v24 = p1.ROOT_ARCHETYPE
								else
									local v27 = table.concat(v26, "_")

									v24 = p1.archetype_index[v27] or archetype_create(p1, v26, v27)
								end

								v23[p2] = v24
								archetype_edges2[v24.id][p2] = archetype2
							end

							v20 = v24
						end

						local entities2 = v20.entities
						local v30 = #entities2 + 1

						entities2[v30] = v21
						inner_archetype_move(v21, v20, v30, v22.archetype, v22.row)
						v22.archetype = v20
						v22.row = v30
					end

					archetype_destroy(p1, v122)
				end
			else
				for v31 in v7.records do
					local v32 = archetypes[v31]
					local archetype_edges = p1.archetype_edges
					local v33 = archetype_edges[v32.id]
					local v34 = v33[p2]

					if v34 == nil then
						local types = v32.types
						local v35 = table.find(types, p2)
						local v36 = table.clone(types)

						table.remove(v36, v35)

						if #v36 < 1 then
							v34 = p1.ROOT_ARCHETYPE
						else
							local v37 = table.concat(v36, "_")

							v34 = p1.archetype_index[v37] or archetype_create(p1, v36, v37)
						end

						v33[p2] = v34
						archetype_edges[v34.id][p2] = v32
					end

					local entities = v32.entities
					local v40 = v34

					for k = #entities, 1, -1 do
						local v41 = entities[k]
						local v43 = t3[v41 % 16777216]
						local entities2 = v40.entities
						local v44 = #entities2 + 1

						entities2[v44] = v41
						archetype_move(t4, v41, v40, v44, v43.archetype, v43.row)
						v43.archetype = v40
						v43.row = v44
					end

					archetype_destroy(p1, v32)
				end
			end
		end

		if v6 then
			local records = v6.records
			local t = {}
			local v45 = false

			for v46 in records do
				local v47 = archetypes[v46]

				if v47 then
					local types = v47.types
					local entities = v47.entities
					local v48 = false
					local count = 0

					for v50, v51 in types do
						local v49

						if if v51 > 281474976710656 then true else false then
							local v53 = t4
							local v54 = v53.sparse_array[(v51 - 281474976710656) % 16777216 % 16777216]
							local v55 = if v54 and v54.dense ~= 0 then v54 else nil

							if v55 then
								local dense = v55.dense

								v49 = if v53.alive_count < dense then nil else v53.dense_array[dense]
							else
								v49 = nil
							end

							if v49 == p2 then
								local v56 = component_index[v51]

								if bit32.btest(v56.flags, 1) then
									for n = #entities, 1, -1 do
										v42(p1, entities[n])
									end

									v48 = true

									break
								end

								t[v51] = v56
								count = count + 1
							end
						end
					end

					if v48 then
						v45 = true

						continue
					end

					if count == 1 then
						local v57, v58 = next(t)
						local archetype_edges = p1.archetype_edges
						local v59 = archetype_edges[v47.id]
						local v60 = v59[v57]

						if v60 == nil then
							local types2 = v47.types
							local v61 = table.find(types2, v57)
							local v62 = table.clone(types2)

							table.remove(v62, v61)

							if #v62 < 1 then
								v60 = p1.ROOT_ARCHETYPE
							else
								local v63 = table.concat(v62, "_")

								v60 = p1.archetype_index[v63] or archetype_create(p1, v62, v63)
							end

							v59[v57] = v60
							archetype_edges[v60.id][v57] = v47
						end

						local on_remove = v58.on_remove
						local v66 = v60

						for m = #entities, 1, -1 do
							local v67, v68
							local v69 = entities[m]
							local v71 = t3[v69 % 16777216]

							v67 = if v71 and t2[v71.dense] ~= v69 then nil else v71

							if on_remove then
								on_remove(v69, v57)

								local archetype2 = v67.archetype

								if archetype2 == v47 then
									v68 = v66
								else
									local archetype_edges2 = p1.archetype_edges
									local v72 = archetype_edges2[archetype2.id]
									local v73 = v72[v57]

									if v73 == nil then
										local types2 = archetype2.types
										local v74 = table.find(types2, v57)
										local v75 = table.clone(types2)

										table.remove(v75, v74)

										if #v75 < 1 then
											v73 = p1.ROOT_ARCHETYPE
										else
											local v76 = table.concat(v75, "_")

											v73 = p1.archetype_index[v76] or archetype_create(p1, v75, v76)
										end

										v72[v57] = v73
										archetype_edges2[v73.id][v57] = archetype2
									end

									v68 = v73
								end
							else
								v68 = v66
							end

							local entities2 = v68.entities
							local v79 = #entities2 + 1

							entities2[v79] = v69
							inner_archetype_move(v69, v68, v79, v67.archetype, v67.row)
							v67.archetype = v68
							v67.row = v79
						end
					elseif count > 1 then
						local v80 = table.clone(types)

						for v81, v82 in t do
							table.remove(v80, table.find(v80, v81))
						end

						local v83

						if #v80 < 1 then
							v83 = p1.ROOT_ARCHETYPE
						else
							local v84 = table.concat(v80, "_")

							v83 = p1.archetype_index[v84] or archetype_create(p1, v80, v84)
						end

						for i = #entities, 1, -1 do
							local v87
							local v88 = entities[i]
							local v90 = t3[v88 % 16777216]

							v87 = if v90 and t2[v90.dense] ~= v88 then nil else v90

							local v91 = v83

							for v92, v93 in t do
								local on_remove = v93.on_remove

								if on_remove then
									on_remove(v88, v92)

									local archetype2 = v87.archetype

									if archetype2 ~= v47 then
										local archetype_edges = p1.archetype_edges
										local v94 = archetype_edges[archetype2.id]
										local v95 = v94[v92]

										if v95 == nil then
											local types2 = archetype2.types
											local v96 = table.find(types2, v92)
											local v97 = table.clone(types2)

											table.remove(v97, v96)

											if #v97 < 1 then
												v95 = p1.ROOT_ARCHETYPE
											else
												local v98 = table.concat(v97, "_")

												v95 = p1.archetype_index[v98] or archetype_create(p1, v97, v98)
											end

											v94[v92] = v95
											archetype_edges[v95.id][v92] = archetype2
										end

										v91 = v95
									end
								end
							end

							local entities2 = v91.entities
							local v101 = #entities2 + 1

							entities2[v101] = v88
							inner_archetype_move(v88, v91, v101, v87.archetype, v87.row)
							v87.archetype = v91
							v87.row = v101
						end
					end

					table.clear(t)
					archetype_destroy(p1, v47)
				end
			end

			if v45 then
				for v102 in records do
					local v103 = archetypes[v102]

					if v103 then
						local entities = v103.entities

						for i = #entities, 1, -1 do
							v42(p1, entities[i])
						end

						archetype_destroy(p1, v103)
					end
				end
			end
		end

		if v8 then
			local records = v8.records

			if bit32.btest(v8.flags, 1) then
				for v104 in records do
					local v105 = archetypes[v104]
					local entities = v105.entities

					for i = #entities, 1, -1 do
						v42(p1, entities[i])
					end

					archetype_destroy(p1, v105)
				end
			else
				local counts = v8.counts
				local records2 = v8.records

				for v106 in records do
					local v107 = archetypes[v106]
					local entities = v107.entities
					local v108 = records2[v106]
					local types = v107.types
					local v110 = table.clone(types)

					for i = v108, v108 + counts[v106] - 1 do
						local v111 = types[i]
						local v112 = table.find(v110, v111)

						if v112 then
							table.remove(v110, v112)
						end

						local on_remove = component_index[v111].on_remove

						if on_remove then
							for v113, v114 in entities do
								on_remove(v114, v111)
							end
						end
					end

					local v115

					if #v110 < 1 then
						v115 = p1.ROOT_ARCHETYPE
					else
						local v116 = table.concat(v110, "_")

						v115 = p1.archetype_index[v116] or archetype_create(p1, v110, v116)
					end

					for i = #entities, 1, -1 do
						local v119
						local v120 = entities[i]
						local v122 = t3[v120 % 16777216]

						v119 = if v122 and t2[v122.dense] ~= v120 then nil else v122

						local entities2 = v115.entities
						local v123 = #entities2 + 1

						entities2[v123] = v120
						inner_archetype_move(v120, v115, v123, v119.archetype, v119.row)
						v119.archetype = v115
						v119.row = v123
					end

					archetype_destroy(p1, v107)
				end
			end
		end

		local dense = v3.dense
		local alive_count = t4.alive_count

		t4.alive_count = alive_count - 1

		local v124 = t2[alive_count]

		t3[v124 % 16777216].dense = dense
		v3.archetype = nil
		v3.row = nil
		v3.dense = alive_count
		t2[dense] = v124

		local v126

		if p2 > 16777216 then
			local v127 = p2 % 16777216
			local v128 = p2 // 16777216 + 1

			v126 = if v128 >= 65536 then v127 else v127 + v128 * 16777216
		else
			v126 = p2 + 16777216
		end

		t2[alive_count] = v126
	end

	local function world_clear(p1, p2) --[[ world_clear | Line: 3698 | Upvalues: t3 (copy), t2 (copy), v12 (copy), archetype_delete (ref) ]]
		local v2 = t3[p2 % 16777216]
		local v3 = if v2 and t2[v2.dense] ~= p2 then nil else v2

		if not v3 then
			return
		end

		for v4, v5 in v3.archetype.types do
			local on_remove = v12[v5].on_remove

			if on_remove then
				on_remove(p2, v5)
			end
		end

		archetype_delete(p1, v3.archetype, v3.row)
		v3.archetype = nil
		v3.row = nil
	end

	local function world_exists(p1, p2) --[[ world_exists | Line: 3717 | Upvalues: t3 (copy) ]]
		local v1 = t3[p2 % 16777216]

		return v1 and v1.dense ~= 0 and true or false
	end

	local function world_contains(p1, p2) --[[ world_contains | Line: 3725 | Upvalues: t4 (copy) ]]
		local v1 = t4
		local v2 = v1.sparse_array[p2 % 16777216]
		local v3 = if v2 and v2.dense ~= 0 then v2 else nil
		local v4

		if v3 then
			local dense = v3.dense

			v4 = if v1.alive_count < dense or v1.dense_array[dense] ~= p2 then nil else v3
		else
			v4 = v3
		end

		return v4 ~= nil
	end

	local function world_cleanup(p1) --[[ world_cleanup | Line: 3729 | Upvalues: t6 (ref), archetype_destroy (ref), t5 (ref) ]]
		for v1, v2 in t6 do
			if #v2.entities == 0 then
				archetype_destroy(p1, v2)
			end
		end

		local t = {}
		local t2 = {}

		for v3, v4 in t6 do
			t[v3] = v4
			t2[v4.type] = v4
		end

		t6 = t
		t5 = t2
		p1.archetypes = t
		p1.archetype_index = t2
	end

	local function world_component(p1) --[[ world_component | Line: 3751 | Upvalues: v22 (ref), world_add (copy) ]]
		if not (v22 + 1 > 256) then
			v22 = v22 + 1
			p1.max_component_id = v22
			world_add(p1, v22, 262)

			return v22
		end

		error("Too many components, consider using world:entity() instead to create components.")
	end

	t9.entity = world_entity
	t9.query = world_query
	t9.remove = world_remove
	t9.clear = world_clear
	t9.delete = v42
	t9.component = world_component
	t9.add = world_add
	t9.set = world_set
	t9.get = world_get
	t9.has = world_has
	t9.target = world_target
	t9.parent = world_parent
	t9.contains = world_contains
	t9.exists = world_exists
	t9.cleanup = world_cleanup
	t9.each = world_each
	t9.children = world_children
	t9.range = world_range

	if p1 then
		local v5 = nil

		local function DEBUG_IS_DELETING_ENTITY(p1) --[[ DEBUG_IS_DELETING_ENTITY | Line: 3790 | Upvalues: v5 (ref) ]]
			if v5 ~= p1 then
				return
			end

			error("\t\t\t\t\tTried to make structural changes while the entity is in process\n\t\t\t\t\tof being deleted. You called this function inside of the\n\t\t\t\t\tOnRemove hook, but the entity is going to remove all of its\n\t\t\t\t\tcomponents making this operation moot.\n\t\t\t\t", 2)
		end

		local function DEBUG_IS_INVALID_ENTITY(p1) --[[ DEBUG_IS_INVALID_ENTITY | Line: 3801 | Upvalues: t3 (copy), t2 (copy) ]]
			if t2[t3[p1 % 16777216].dense] == p1 then
				return
			end

			error("\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t", 2)
		end

		local function DEBUG_ID_IS_INVALID(p1) --[[ DEBUG_ID_IS_INVALID | Line: 3814 | Upvalues: t9 (copy), ECS_ID (ref) ]]
			if not (p1 > 281474976710656) then
				assert(t9:contains(p1), "The component in your parameters is invalid because it is not alive in the entity index. You might be holding onto an outdated handle or may have forward declared ids via jecs.component() and jecs.tag(). In the latter case, ensure that their calls precede jecs.world() or otherwise they will not register correctly")

				return
			end

			if if p1 // 16777216 == 260 then true else p1 % 16777216 == 260 then
				error("\t\t\t\t\t\tYou tried to pass in a wildcard pair. This is strictly\n\t\t\t\t\t\tforbidden. You probably want to iterate the targets and\n\t\t\t\t\t\tremove them one by one. You can also populate a list of\n\t\t\t\t\t\ttargets to remove and use jecs.bulk_remove.\n\t\t\t\t\t", 2)
			end

			local v5 = t9
			local v6 = (p1 - 281474976710656) // 16777216
			local v7

			if v6 == 0 then
				v7 = 0
			else
				local entity_index = v5.entity_index
				local v8 = entity_index.sparse_array[ECS_ID(v6)]
				local v9 = if v8 and v8.dense ~= 0 then v8 else nil
				local v10

				if v9 then
					local dense = v9.dense

					v10 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v6 then nil else v9
				else
					v10 = v9
				end

				if if v10 == nil then false else true then
					v7 = v6
				elseif v6 > 16777216 then
					v7 = 0
				else
					local v12 = entity_index.sparse_array[v6 % 16777216]
					local v13 = if v12 and v12.dense ~= 0 then v12 else nil
					local v14

					if v13 then
						local dense = v13.dense

						v14 = if entity_index.alive_count < dense then nil else entity_index.dense_array[dense]
					else
						v14 = nil
					end

					if v14 then
						local v15 = entity_index.sparse_array[ECS_ID(v14)]
						local v16 = if v15 and v15.dense ~= 0 then v15 else nil
						local v17

						if v16 then
							local dense = v16.dense

							v17 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v14 then nil else v16
						else
							v17 = v16
						end

						v7 = if if v17 == nil then false else true then v14 else 0
					else
						v7 = 0
					end
				end
			end

			local v19 = t9
			local v20 = (p1 - 281474976710656) % 16777216
			local v21

			if v20 == 0 then
				v21 = 0
			else
				local entity_index = v19.entity_index
				local v22 = entity_index.sparse_array[ECS_ID(v20)]
				local v23 = if v22 and v22.dense ~= 0 then v22 else nil
				local v24

				if v23 then
					local dense = v23.dense

					v24 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v20 then nil else v23
				else
					v24 = v23
				end

				if if v24 == nil then false else true then
					v21 = v20
				elseif v20 > 16777216 then
					v21 = 0
				else
					local v26 = entity_index.sparse_array[v20 % 16777216]
					local v27 = if v26 and v26.dense ~= 0 then v26 else nil
					local v28

					if v27 then
						local dense = v27.dense

						v28 = if entity_index.alive_count < dense then nil else entity_index.dense_array[dense]
					else
						v28 = nil
					end

					if v28 then
						local v29 = entity_index.sparse_array[ECS_ID(v28)]
						local v30 = if v29 and v29.dense ~= 0 then v29 else nil
						local v31

						if v30 then
							local dense = v30.dense

							v31 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v28 then nil else v30
						else
							v31 = v30
						end

						v21 = if if v31 == nil then false else true then v28 else 0
					else
						v21 = 0
					end
				end
			end

			assert(t9:contains(v7), "The first element of the pair is invalid because it is not alive in the entity index. You might be holding onto an outdated handle or may have forward declared ids via jecs.component() and jecs.tag(). In the latter case, ensure that their calls precede jecs.world() or otherwise they will not register correctly")
			assert(t9:contains(v21), "The second element of the pair is invalid because it is not alive in the entity index. You might be holding onto an outdated handle or may have forward declared ids via jecs.component() and jecs.tag(). In the latter case, ensure that their calls precede jecs.world() or otherwise they will not register correctly")
		end

		local v6 = v42

		v42 = function(p1, p2) --[[ world_delete_checked | Line: 3838 | Upvalues: v5 (ref), t3 (copy), t2 (copy), v6 (copy) ]]
			v5 = p2

			if t2[t3[p2 % 16777216].dense] ~= p2 then
				error("\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t", 2)
			end

			v6(p1, p2)
			v5 = nil
		end

		local function world_remove_checked(p1, p2, p3) --[[ world_remove_checked | Line: 3846 | Upvalues: v5 (ref), t3 (copy), t2 (copy), DEBUG_ID_IS_INVALID (copy), world_remove (copy) ]]
			if v5 == p2 then
				error("\t\t\t\t\tTried to make structural changes while the entity is in process\n\t\t\t\t\tof being deleted. You called this function inside of the\n\t\t\t\t\tOnRemove hook, but the entity is going to remove all of its\n\t\t\t\t\tcomponents making this operation moot.\n\t\t\t\t", 2)
			end

			if t2[t3[p2 % 16777216].dense] ~= p2 then
				error("\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t", 2)
			end

			DEBUG_ID_IS_INVALID(p3)
			world_remove(p1, p2, p3)
		end

		local function world_add_checked(p1, p2, p3) --[[ world_add_checked | Line: 3853 | Upvalues: v5 (ref), t3 (copy), t2 (copy), DEBUG_ID_IS_INVALID (copy), world_add (copy) ]]
			if v5 == p2 then
				error("\t\t\t\t\tTried to make structural changes while the entity is in process\n\t\t\t\t\tof being deleted. You called this function inside of the\n\t\t\t\t\tOnRemove hook, but the entity is going to remove all of its\n\t\t\t\t\tcomponents making this operation moot.\n\t\t\t\t", 2)
			end

			if t2[t3[p2 % 16777216].dense] ~= p2 then
				error("\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t", 2)
			end

			DEBUG_ID_IS_INVALID(p3)
			world_add(p1, p2, p3)
		end

		local function world_set_checked(p1, p2, p3, p4) --[[ world_set_checked | Line: 3860 | Upvalues: v5 (ref), t3 (copy), t2 (copy), DEBUG_ID_IS_INVALID (copy), world_set (copy) ]]
			if v5 == p2 then
				error("\t\t\t\t\tTried to make structural changes while the entity is in process\n\t\t\t\t\tof being deleted. You called this function inside of the\n\t\t\t\t\tOnRemove hook, but the entity is going to remove all of its\n\t\t\t\t\tcomponents making this operation moot.\n\t\t\t\t", 2)
			end

			if t2[t3[p2 % 16777216].dense] ~= p2 then
				error("\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t", 2)
			end

			DEBUG_ID_IS_INVALID(p3)
			world_set(p1, p2, p3, p4)
		end

		t9.remove = world_remove_checked
		t9.add = world_add_checked
		t9.set = world_set_checked
	end

	for i = 1, 271 do
		ENTITY_INDEX_NEW_ID(t4)
	end

	for j = 1, v22 do
		world_add(t9, j, 262)
	end

	world_add(t9, 267, 262)
	world_add(t9, 259, 262)
	world_add(t9, 257, 262)
	world_add(t9, 258, 262)
	world_add(t9, 260, 262)
	world_add(t9, 271, 262)
	world_set(t9, 257, 267, "jecs.OnAdd")
	world_set(t9, 258, 267, "jecs.OnRemove")
	world_set(t9, 259, 267, "jecs.OnChange")
	world_set(t9, 260, 267, "jecs.Wildcard")
	world_set(t9, 261, 267, "jecs.ChildOf")
	world_set(t9, 262, 267, "jecs.Component")
	world_set(t9, 263, 267, "jecs.OnDelete")
	world_set(t9, 264, 267, "jecs.OnDeleteTarget")
	world_set(t9, 265, 267, "jecs.Delete")
	world_set(t9, 266, 267, "jecs.Remove")
	world_set(t9, 267, 267, "jecs.Name")
	world_set(t9, 271, 271, "jecs.Rest")
	world_add(t9, 261, 281479405895945)
	world_add(t9, 261, 270)
	world_add(t9, 263, 270)
	world_add(t9, 264, 270)

	for k = 272, v4 do
		ENTITY_INDEX_NEW_ID(t4)
	end

	for v7, v8 in t do
		for v9, v10 in v8 do
			if v10 == v2 then
				world_add(t9, v7, v9)

				continue
			end

			world_set(t9, v7, v9, v10)
		end
	end

	return t9
end

local function v5(p1, p2) --[[ ecs_is_tag | Line: 3925 | Upvalues: v5 (copy), ECS_ID (copy) ]]
	if if p2 > 281474976710656 then true else false then
		local v3 = (p2 - 281474976710656) // 16777216
		local v4, v52

		if v3 == 0 then
			v4 = p1
			v52 = 0
		else
			local entity_index = p1.entity_index
			local v6 = entity_index.sparse_array[ECS_ID(v3)]
			local v7

			if v6 and v6.dense ~= 0 then
				v7 = v6
				v4 = p1
			else
				v7 = nil
				v4 = p1
			end

			local v8

			if v7 then
				local dense = v7.dense

				v8 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v3 then nil else v7
			else
				v8 = v7
			end

			if if v8 == nil then false else true then
				v52 = v3
			elseif v3 > 16777216 then
				v52 = 0
			else
				local v10 = entity_index.sparse_array[v3 % 16777216]
				local v11 = if v10 and v10.dense ~= 0 then v10 else nil
				local v12

				if v11 then
					local dense = v11.dense

					v12 = if entity_index.alive_count < dense then nil else entity_index.dense_array[dense]
				else
					v12 = nil
				end

				if v12 then
					local v13 = entity_index.sparse_array[ECS_ID(v12)]
					local v14 = if v13 and v13.dense ~= 0 then v13 else nil
					local v15

					if v14 then
						local dense = v14.dense

						v15 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v12 then nil else v14
					else
						v15 = v14
					end

					v52 = if if v15 == nil then false else true then v12 else 0
				else
					v52 = 0
				end
			end
		end

		local v17 = v5(v4, v52)

		if v17 then
			local v19 = (p2 - 281474976710656) % 16777216
			local v20, v21

			if v19 == 0 then
				v20 = p1
				v21 = 0
			else
				local entity_index = p1.entity_index
				local v22 = entity_index.sparse_array[ECS_ID(v19)]
				local v23

				if v22 and v22.dense ~= 0 then
					v23 = v22
					v20 = p1
				else
					v23 = nil
					v20 = p1
				end

				local v24

				if v23 then
					local dense = v23.dense

					v24 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v19 then nil else v23
				else
					v24 = v23
				end

				if if v24 == nil then false else true then
					v21 = v19
				elseif v19 > 16777216 then
					v21 = 0
				else
					local v26 = entity_index.sparse_array[v19 % 16777216]
					local v27 = if v26 and v26.dense ~= 0 then v26 else nil
					local v28

					if v27 then
						local dense = v27.dense

						v28 = if entity_index.alive_count < dense then nil else entity_index.dense_array[dense]
					else
						v28 = nil
					end

					if v28 then
						local v29 = entity_index.sparse_array[ECS_ID(v28)]
						local v30 = if v29 and v29.dense ~= 0 then v29 else nil
						local v31

						if v30 then
							local dense = v30.dense

							v31 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= v28 then nil else v30
						else
							v31 = v30
						end

						v21 = if if v31 == nil then false else true then v28 else 0
					else
						v21 = 0
					end
				end
			end

			v17 = v5(v20, v21)
		end

		return v17
	end

	local v33 = p1.component_index[p2]

	if v33 then
		return bit32.btest(v33.flags, 2)
	end

	local entity_index = p1.entity_index
	local v34 = entity_index.sparse_array[p2 % 16777216]
	local v35 = if v34 and v34.dense ~= 0 then v34 else nil
	local v36

	if v35 then
		local dense = v35.dense

		v36 = if entity_index.alive_count < dense or entity_index.dense_array[dense] ~= p2 then nil else v35
	else
		v36 = v35
	end

	local v37

	if v36 then
		local archetype = v36.archetype

		v37 = if archetype then archetype.columns_map[262] ~= nil else false
	else
		v37 = false
	end

	return not v37
end

local function ecs_entity_record(p1, p2) --[[ ecs_entity_record | Line: 3936 ]]
	local entity_index = p1.entity_index
	local v1 = entity_index.sparse_array[p2 % 16777216]
	local v2 = if v1 and v1.dense ~= 0 then v1 else nil

	if v2 then
		local dense = v2.dense

		if entity_index.alive_count < dense then
			return nil
		end

		if entity_index.dense_array[dense] ~= p2 then
			return nil
		end
	end

	return v2
end

local function entity_index_ensure(p1, p2) --[[ entity_index_ensure | Line: 3940 ]]
	local sparse_array = p1.sparse_array
	local dense_array = p1.dense_array
	local v1 = p2 % 16777216
	local alive_count = p1.alive_count
	local v2 = sparse_array[v1]

	if v2 then
		local dense = v2.dense

		if dense == 0 then
			local v3 = alive_count + 1

			p1.alive_count = v3
			v2.dense = v3
			dense_array[v3] = p2

			return p2
		end

		local v4 = dense_array[dense]

		if v4 and v4 ~= p2 then
			local v5 = alive_count + 1

			p1.alive_count = v5
			v2.dense = v5
			dense_array[v5] = p2

			return p2
		end
	else
		local max_id = p1.max_id

		if max_id < v1 then
			for i = max_id + 1, v1 - 1 do
				local _ = sparse_array[i]

				sparse_array[i] = {
					dense = 0
				}
			end

			p1.max_id = v1
		end

		local v6 = alive_count + 1

		p1.alive_count = v6
		dense_array[v6] = p2
		sparse_array[v1] = {
			dense = v6
		}
	end

	return p2
end

local function new(p1) --[[ new | Line: 3995 | Upvalues: ENTITY_INDEX_NEW_ID (copy) ]]
	return ENTITY_INDEX_NEW_ID(p1.entity_index)
end

local function new_low_id(p1) --[[ new_low_id | Line: 4000 | Upvalues: ENTITY_INDEX_NEW_ID (copy), entity_index_ensure (copy) ]]
	local entity_index = p1.entity_index
	local v1

	if p1.max_component_id < 256 then
		repeat
			p1.max_component_id = p1.max_component_id + 1
			v1 = p1.max_component_id

			local v2 = entity_index.sparse_array[v1 % 16777216]
		until (if v2 and v2.dense ~= 0 then v2 else nil) == nil or not (v1 <= 256)
	else
		v1 = 0
	end

	if v1 == 0 or v1 >= 256 then
		return ENTITY_INDEX_NEW_ID(entity_index)
	end

	entity_index_ensure(entity_index, v1)

	return v1
end

return {
	new = new,
	new_w_id = function(p1, p2) --[[ new_w_id | Line: 4021 | Upvalues: ENTITY_INDEX_NEW_ID (copy) ]]
		local v1 = ENTITY_INDEX_NEW_ID(p1.entity_index)

		p1.add(p1, v1, p2)

		return v1
	end,
	new_low_id = new_low_id,
	world = world_new,
	World = {
		new = world_new
	},
	component = ECS_COMPONENT,
	tag = ECS_TAG,
	meta = ECS_META,
	is_tag = v5,
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
	IS_PAIR = ECS_IS_PAIR,
	ECS_PAIR_FIRST = ECS_PAIR_FIRST,
	ECS_PAIR_SECOND = ECS_PAIR_SECOND,
	pair_first = ecs_pair_first,
	pair_second = ecs_pair_second,
	entity_index_get_alive = entity_index_get_alive,
	archetype_append_to_records = archetype_append_to_records,
	id_record_ensure = id_record_ensure,
	component_record = id_record_get,
	record = ecs_entity_record,
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
	entity_index_new_id = ENTITY_INDEX_NEW_ID,
	entity_index_ensure = entity_index_ensure,
	Query = t2,
	query_iter = query_iter,
	query_iter_init = query_iter_init,
	query_with = query_with,
	query_without = query_without,
	query_archetypes = query_archetypes,
	query_match = query_match,
	find_observers = find_observers,
	ECS_ID = ECS_ENTITY_T_LO,
	ECS_GENERATION_INC = ECS_GENERATION_INC,
	ECS_GENERATION = ECS_GENERATION,
	ECS_ID_IS_WILDCARD = ECS_ID_IS_WILDCARD,
	ECS_ID_IS_EXCLUSIVE = 4,
	ECS_ID_DELETE = 1,
	ECS_META_RESET = ECS_META_RESET,
	ECS_COMBINE = ECS_COMBINE,
	ECS_ENTITY_MASK = 16777216
}