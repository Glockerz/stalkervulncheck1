-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local common = require(script.Parent:WaitForChild("common"))
local utils = require(script.Parent:WaitForChild("utils"))
local mask_generator = require(script:WaitForChild("mask_generator"))
local t = {
	tag = 1,
	component = 2,
	pair_tag = 3,
	pair_component = 4,
	relation = 5,
	relation_component = 6,
	unreliable = 7,
	unreliable_pair = 8
}
local unreliable = t.unreliable
local t2 = {}

t2.__index = t2
function t2.get_clients_from_bitmask(p1, p2) --[[ get_clients_from_bitmask | Line: 164 ]]
	local t = {}

	for v1, v2 in p1.client_indexes do
		if p2:get(v2) then
			table.insert(t, v1)
		end
	end

	return t
end

local function get_usable_filter(p1) --[[ get_usable_filter | Line: 174 ]]
	if not p1 then
		return nil
	end

	if type(p1) == "table" then
		return p1
	end

	return {
		[p1] = true
	}
end

local function create_component_indexes() --[[ create_component_indexes | Line: 186 | Upvalues: unreliable (copy) ]]
	local t = {}

	for i = 1, unreliable do
		t[i] = {}
	end

	return t
end

local function create_entity_changes() --[[ create_entity_changes | Line: 194 | Upvalues: create_component_indexes (copy), t (copy) ]]
	local t2 = {}
	local t3 = {}
	local t4 = {}
	local t5 = {}
	local t6 = {}
	local t7 = {}
	local t8 = {}
	local t9 = {}
	local t10 = {}
	local t11 = {}
	local t12 = {}
	local t13 = {}
	local t14 = {}
	local t15 = {}
	local t16 = {}
	local t17 = {}
	local v1 = create_component_indexes()
	local v2 = create_component_indexes()

	v1[t.tag] = t10
	v1[t.component] = t11
	v1[t.unreliable] = t12
	v1[t.unreliable_pair] = t13
	v1[t.pair_tag] = t14
	v1[t.pair_component] = t15
	v1[t.relation] = t16
	v1[t.relation_component] = t17
	v2[t.tag] = t2
	v2[t.component] = t3
	v2[t.unreliable] = t4
	v2[t.unreliable_pair] = t5
	v2[t.pair_tag] = t6
	v2[t.pair_component] = t7
	v2[t.relation] = t8
	v2[t.relation_component] = t9

	return {
		removed = v2,
		changed = v1,
		tag_removed = t2,
		component_removed = t3,
		unreliable_removed = t4,
		unreliable_pair_removed = t5,
		pair_tag_removed = t6,
		pair_component_removed = t7,
		relation_tag_removed = t8,
		relation_component_removed = t9,
		tag_added = t10,
		component_changed = t11,
		unreliable_added = t12,
		unreliable_pair_added = t13,
		pair_tag_added = t14,
		pair_component_changed = t15,
		relation_tag_added = t16,
		relation_component_changed = t17
	}
end

function t2.create_new_storage(p1, p2, p3, p4) --[[ create_new_storage | Line: 264 ]]
	local t = {
		is_empty = true,
		active_count = 0,
		deletions_count = 0
	}
	local t2 = {
		bitmask = p2
	}

	t2.hash = if p3 then p3 else p2:tostring()
	t2.members = if p4 then p4 else p1:get_clients_from_bitmask(p2)
	t.mask = t2
	t.shared_with = {}
	t.changes = {
		added = {},
		added_components = {},
		changed = {}
	}
	t.active = {}
	t.deletions = {
		entities = {},
		components = {}
	}

	return t
end

local function is_include_filter(p1) --[[ is_include_filter | Line: 296 ]]
	for v1, v2 in p1 do
		return v2 and true or false
	end

	return true
end

local function create_new_active() --[[ create_new_active | Line: 306 | Upvalues: create_component_indexes (copy) ]]
	return {
		component_count = 0,
		is_entity_mask = false,
		components = create_component_indexes()
	}
end

local function get_component_index_entry(p1, p2, p3, p4) --[[ get_component_index_entry | Line: 314 ]]
	local v1 = p1[p2]

	if v1 == nil then
		return nil
	end

	local v2 = v1[p4]

	return if v2 then v2[p3] else v2
end

local function set_component_index_entry(p1, p2, p3, p4, p5) --[[ set_component_index_entry | Line: 329 | Upvalues: create_component_indexes (copy) ]]
	local v1 = p1[p2]

	if v1 == nil then
		local v2 = create_component_indexes()

		p1[p2] = v2
		v1 = v2
	end

	v1[p4][p3] = p5
end

local function remove_component_index_entry(p1, p2, p3, p4) --[[ remove_component_index_entry | Line: 344 ]]
	local v1 = p1[p2]

	if v1 ~= nil then
		v1[p4][p3] = nil
	end
end

local function get_bitmask_deltas(p1, p2) --[[ get_bitmask_deltas | Line: 357 ]]
	return p2:band(p1:bnot()), p1:band(p2:bnot())
end

local function merge_bitmask_deltas(p1, p2, p3, p4) --[[ merge_bitmask_deltas | Line: 363 ]]
	local v1 = p1:bor(p3)
	local v2 = p2:bor(p4)
	local v3 = v1:band(v2):bnot()

	return v1:band(v3), v2:band(v3)
end

t2.get_component_index_entry = get_component_index_entry
t2.set_component_index_entry = set_component_index_entry
t2.remove_component_index_entry = remove_component_index_entry
t2.get_bitmask_deltas = get_bitmask_deltas
t2.merge_bitmask_deltas = merge_bitmask_deltas

local function get_or_set_changed(p1, p2, p3) --[[ get_or_set_changed | Line: 379 | Upvalues: create_entity_changes (copy) ]]
	local v1 = p1.changes.changed[p2]

	if v1 == nil then
		local v2 = if p3 then p3 else create_entity_changes()

		p1.changes.changed[p2] = v2
		v1 = v2
	end

	return v1
end

local function get_or_set_active(p1, p2, p3) --[[ get_or_set_active | Line: 388 | Upvalues: create_component_indexes (copy) ]]
	local v1 = p1.active[p2]

	if v1 == nil then
		local v2 = if p3 then p3 else {
	component_count = 0,
	is_entity_mask = false,
	components = create_component_indexes()
}

		p1.active[p2] = v2
		p1.active_count = p1.active_count + 1
		v1 = v2
	end

	return v1
end

local function get_or_set_component_added(p1, p2, p3) --[[ get_or_set_component_added | Line: 398 | Upvalues: create_component_indexes (copy) ]]
	local v1 = p1.changes.added_components[p2]

	if v1 == nil then
		local v2 = if p3 then p3 else create_component_indexes()

		p1.changes.added_components[p2] = v2
		v1 = v2
	end

	return v1
end

local function remove_active(p1, p2) --[[ remove_active | Line: 411 | Upvalues: common (copy) ]]
	local v1 = p1.active[p2]

	if v1 then
		p1.active[p2] = nil
		p1.active_count = p1.active_count - 1

		return v1
	end

	return common.log_error("attempted to remove an entity that wasn\'t active")
end

local function set_component_active(p1, p2, p3) --[[ set_component_active | Line: 422 ]]
	local v1 = p1.components[p3]

	if v1[p2] ~= nil then
		return
	end

	v1[p2] = true
	p1.component_count = p1.component_count + 1
end

local function remove_component_active(p1, p2, p3, p4) --[[ remove_component_active | Line: 430 | Upvalues: common (copy) ]]
	local v1 = p1.active[p2]

	if not v1 then
		return
	end

	local v2 = v1.components[p4]

	if not v2[p3] then
		return
	end

	v2[p3] = nil
	v1.component_count = v1.component_count - 1

	if not (v1.component_count <= 0) or v1.is_entity_mask then
		return
	end

	if p1.active[p2] then
		p1.active[p2] = nil
		p1.active_count = p1.active_count - 1

		return
	end

	common.log_error("attempted to remove an entity that wasn\'t active")
end

function t2.get_or_create_storage_group(p1, p2) --[[ get_or_create_storage_group | Line: 452 ]]
	local v1 = p2:tostring()
	local v2 = p1.storages[v1]

	if not v2 then
		local v3 = p1:create_new_storage(p2, v1)

		p1.storages[v1] = v3
		v2 = v3
	end

	return v2
end
function t2.get_component_lookup(p1, p2, p3, p4) --[[ get_component_lookup | Line: 463 ]]
	local v1 = p1.lookups.entities[p2]

	if v1 then
		return v1.filtered_components[p4][p3], v1
	end

	return nil
end

local function dissect_component_actives(p1, p2, p3) --[[ dissect_component_actives | Line: 477 | Upvalues: create_component_indexes (copy), common (copy) ]]
	local v1 = nil

	for v2, v3 in p1.active[p2].components do
		for v4 in v3 do
			if p3[v2] and p3[v2][v4] then
				local v6 = if v1 then v1 else {
	component_count = 0,
	is_entity_mask = false,
	components = create_component_indexes()
}
				local v7 = v6.components[v2]

				if v7[v4] == nil then
					v7[v4] = true
					v6.component_count = v6.component_count + 1
				end

				local v8 = p1.active[p2]

				if v8 then
					local v9 = v8.components[v2]

					if v9[v4] then
						v9[v4] = nil
						v8.component_count = v8.component_count - 1

						if v8.component_count <= 0 and not v8.is_entity_mask then
							if p1.active[p2] then
								p1.active[p2] = nil
								p1.active_count = p1.active_count - 1
								v1 = v6

								continue
							end

							common.log_error("attempted to remove an entity that wasn\'t active")
							v1 = v6

							continue
						end

						v1 = v6

						continue
					end

					v1 = v6

					continue
				end

				v1 = v6
			end
		end
	end

	return v1
end

local function dissect_component_additions(p1, p2) --[[ dissect_component_additions | Line: 499 | Upvalues: create_component_indexes (copy) ]]
	local v1 = nil

	for v2, v3 in p1 do
		for v4 in v3 do
			if p2[v2] and p2[v2][v4] then
				local v6 = if v1 then v1 else create_component_indexes()

				v6[v2][v4] = true
				p1[v2][v4] = nil
				v1 = v6
			end
		end
	end

	return v1
end

local function dissect_component_changes(p1, p2) --[[ dissect_component_changes | Line: 515 | Upvalues: create_entity_changes (copy) ]]
	local v1 = nil
	local v2 = nil
	local v3 = nil

	for v4, v5 in p1.changed do
		local v6 = p2[v4]

		for v7, v8 in v5 do
			if if v6 then v6[v7] else v6 then
				if v1 then
					v1[v4][v7] = v8
					v5[v7] = nil

					continue
				end

				local v10 = create_entity_changes()

				v1 = v10.changed
				v2 = v10.removed
				v3 = v10
			end
		end
	end

	for v11, v12 in p1.removed do
		local v13 = p2[v11]

		for v14 in v12 do
			if if v13 then v13[v14] else v13 then
				if v2 then
					v2[v11][v14] = true
					v12[v14] = nil

					continue
				end

				local v16 = create_entity_changes()
				local changed = v16.changed

				v2 = v16.removed
				v3 = v16
			end
		end
	end

	return v3
end

local function merge_component_actives(p1, p2) --[[ merge_component_actives | Line: 561 ]]
	for v1, v2 in p1.components do
		for v3 in v2 do
			local v4 = p2.components[v1]

			if v4[v3] == nil then
				v4[v3] = true
				p2.component_count = p2.component_count + 1
			end
		end
	end
end

local function merge_component_additions(p1, p2) --[[ merge_component_additions | Line: 569 ]]
	for v1, v2 in p1 do
		for v3 in v2 do
			p2[v1][v3] = true
		end
	end
end

local function merge_component_changes(p1, p2) --[[ merge_component_changes | Line: 577 ]]
	local changed = p2.changed
	local removed = p2.removed

	for v1, v2 in p1.changed do
		local v3 = changed[v1]

		for v4, v5 in v2 do
			v3[v4] = v5
		end
	end

	for v6, v7 in p1.removed do
		local v8 = removed[v6]

		for v9, v10 in v7 do
			v8[v9] = v10
		end
	end
end

function t2.merge_component_filter(p1, p2, p3, p4) --[[ merge_component_filter | Line: 597 | Upvalues: common (copy) ]]
	local v1, v2 = p1:get_component_lookup(p2, p3, p4)

	if not v2 then
		common.log_error("attempted to merge a component filter to an unactive entity")
	end

	if v1 == nil then
		local v3 = v2.storage_group.active[p2]
		local v4 = v3.components[p4]

		if v4[p3] == nil then
			v4[p3] = true
			v3.component_count = v3.component_count + 1
		end
	else
		local v5 = p1:move_component_storage(p2, p3, p4, v1.storage_group, v2.generator.result)

		v2.filtered_components[p4][p3] = nil

		local v6 = v5.shared_with[p2]

		if v6 ~= nil then
			v6[p4][p3] = nil
		end
	end

	v2.components[p4][p3] = true
end
function t2.move_entity_storage(p1, p2, p3, p4) --[[ move_entity_storage | Line: 624 | Upvalues: create_component_indexes (copy), dissect_component_actives (copy), common (copy), merge_component_actives (copy), dissect_component_additions (copy), merge_component_additions (copy), create_entity_changes (copy), dissect_component_changes (copy), merge_component_changes (copy) ]]
	local v1 = p1:get_or_create_storage_group(p4)

	if v1 == p3 then
		return p3
	end

	local v2 = p3.shared_with[p2]
	local v3 = p3.active[p2]
	local v4 = v1.active[p2]

	if v4 == nil then
		local v5 = if v3 then v3 else {
	component_count = 0,
	is_entity_mask = false,
	components = create_component_indexes()
}

		v1.active[p2] = v5
		v1.active_count = v1.active_count + 1
		v4 = v5
	end

	v4.is_entity_mask = true

	if v2 then
		local v6 = dissect_component_actives(p3, p2, v2)

		if v6 then
			p3.active[p2] = v6
		elseif p3.active[p2] then
			p3.active[p2] = nil
			p3.active_count = p3.active_count - 1
		else
			common.log_error("attempted to remove an entity that wasn\'t active")
		end
	elseif p3.active[p2] then
		p3.active[p2] = nil
		p3.active_count = p3.active_count - 1
	else
		common.log_error("attempted to remove an entity that wasn\'t active")
	end

	if v3 ~= v4 then
		merge_component_actives(v3, v4)
	end

	local v7 = p3.changes.added_components[p2]

	if v7 then
		local v8 = v1.changes.added_components[p2]

		if v8 == nil then
			local v9 = if v7 then v7 else create_component_indexes()

			v1.changes.added_components[p2] = v9
			v8 = v9
		end

		if v2 then
			local v10 = dissect_component_additions(v7, v2)

			if v10 then
				p3.changes.added_components[p2] = v10
			else
				p3.changes.added_components[p2] = nil
			end
		end

		if v7 ~= v8 then
			merge_component_additions(v7, v8)
		end
	end

	local v11 = p3.changes.changed[p2]

	if v11 then
		local v12 = v1.changes.changed[p2]

		if v12 == nil then
			local v13 = if v11 then v11 else create_entity_changes()

			v1.changes.changed[p2] = v13
			v12 = v13
		end

		if v2 then
			local v14 = dissect_component_changes(v11, v2)

			if v14 then
				p3.changes.changed[p2] = v14
			else
				p3.changes.changed[p2] = nil
			end
		end

		if v11 ~= v12 then
			merge_component_changes(v11, v12)
		end
	end

	if p3.changes.added[p2] then
		v1.changes.added[p2] = true
		p3.changes.added[p2] = nil
	end

	return v1
end
function t2.move_component_storage(p1, p2, p3, p4, p5, p6) --[[ move_component_storage | Line: 700 | Upvalues: create_component_indexes (copy), common (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_or_create_storage_group(p6)

	if v1 == p5 then
		return p5
	end

	local v2 = v1.active[p2]

	if v2 == nil then
		v2 = {
			component_count = 0,
			is_entity_mask = false,
			components = create_component_indexes()
		}
		v1.active[p2] = v2
		v1.active_count = v1.active_count + 1
	end

	local v3 = p5.active[p2]

	if v3 then
		local v4 = v3.components[p4]

		if v4[p3] then
			v4[p3] = nil
			v3.component_count = v3.component_count - 1

			if v3.component_count <= 0 and not v3.is_entity_mask then
				if p5.active[p2] then
					p5.active[p2] = nil
					p5.active_count = p5.active_count - 1
				else
					common.log_error("attempted to remove an entity that wasn\'t active")
				end
			end
		end
	end

	local v5 = v2.components[p4]

	if v5[p3] == nil then
		v5[p3] = true
		v2.component_count = v2.component_count + 1
	end

	local shared_with = v1.shared_with
	local v6 = shared_with[p2]

	if v6 == nil then
		local v7 = create_component_indexes()

		shared_with[p2] = v7
		v6 = v7
	end

	v6[p4][p3] = true

	local v8 = p5.shared_with[p2]

	if v8 ~= nil then
		v8[p4][p3] = nil
	end

	local v9 = p5.changes.added_components[p2]
	local v10

	if v9 == nil then
		v10 = nil
	else
		local v11 = v9[p4]

		v10 = if v11 then v11[p3] else v11
	end

	if v10 then
		local v12 = p5.changes.added_components[p2]

		if v12 ~= nil then
			v12[p4][p3] = nil
		end

		local added_components = v1.changes.added_components
		local v13 = added_components[p2]

		if v13 == nil then
			local v14 = create_component_indexes()

			added_components[p2] = v14
			v13 = v14
		end

		v13[p4][p3] = true
	end

	local v15 = p5.changes.changed[p2]

	if v15 then
		local v16 = v1.changes.changed[p2]

		if v16 == nil then
			local v17 = create_entity_changes()

			v1.changes.changed[p2] = v17
			v16 = v17
		end

		v16.changed[p4][p3] = v15.changed[p4][p3]
		v16.removed[p4][p3] = v15.removed[p4][p3]
		v15.changed[p4][p3] = nil
		v15.removed[p4][p3] = nil
	end

	return v1
end
function t2.bind_component_generator(p1, p2, p3, p4, p5) --[[ bind_component_generator | Line: 741 | Upvalues: mask_generator (copy) ]]
	local v1, v2 = p1:get_component_lookup(p2, p3, p4)
	local v3 = mask_generator.create(nil, function() --[[ Line: 749 | Upvalues: v2 (copy), p5 (copy) ]]
		return v2.generator.result:band(p5.result)
	end)

	local function subscribed() --[[ subscribed | Line: 753 | Upvalues: v1 (ref), v2 (copy), p4 (copy), p3 (copy), p1 (copy), p2 (copy), v3 (copy) ]]
		if not v1 then
			v1 = v2.filtered_components[p4][p3]
		end

		v1.storage_group = p1:move_component_storage(p2, p3, p4, v1.storage_group, v3.result)
	end

	v3:track(p5)
	v3:track(p1.active_members_generator)
	v3.subscribed = subscribed

	return v3
end
function t2.rebind_component_generators(p1, p2) --[[ rebind_component_generators | Line: 772 ]]
	local v1 = p1.lookups.entities[p2]

	if not v1 then
		return
	end

	for v2, v3 in v1.filtered_components do
		for v4, v5 in v3 do
			v5.band_generator:destroy()

			local v6 = p1:bind_component_generator(p2, v4, v2, v5.generator)

			v5.band_generator = v6
			v6:run_subscribed()
		end
	end
end
function t2.get_or_postpone_entity_lookup(p1, p2, p3, p4, p5) --[[ get_or_postpone_entity_lookup | Line: 788 | Upvalues: create_component_indexes (copy) ]]
	local v1 = p1.lookups.entities[p2]

	if v1 then
		return v1
	end

	if p5 == nil then
		local postponed = p1.lookups.postponed
		local v2 = postponed[p2]

		if v2 == nil then
			local v3 = create_component_indexes()

			postponed[p2] = v3
			v2 = v3
		end

		v2[p4][p3] = {
			filter = nil
		}
	else
		local postponed = p1.lookups.postponed
		local v4 = postponed[p2]

		if v4 == nil then
			local v5 = create_component_indexes()

			postponed[p2] = v5
			v4 = v5
		end

		v4[p4][p3] = {
			filter = p5
		}
	end

	return nil
end
function t2.update_entity_filter(p1, p2, p3) --[[ update_entity_filter | Line: 809 | Upvalues: mask_generator (copy) ]]
	local v1 = if p3 then p1:create_generator_from_filter(p3) else mask_generator.follow(p1.active_members_generator)
	local v2 = p1.lookups.entities[p2]

	function v1.subscribed() --[[ subscribed | Line: 823 | Upvalues: v2 (ref), p1 (copy), p2 (copy), v1 (ref) ]]
		if not v2 then
			v2 = p1.lookups.entities[p2]
		end

		v2.storage_group = p1:move_entity_storage(p2, v2.storage_group, v1.result)
	end

	return v1
end
function t2.start_entity(p1, p2, p3) --[[ start_entity | Line: 836 | Upvalues: create_component_indexes (copy) ]]
	local v1 = if p3 then if type(p3) == "table" then p3 else {
	[p3] = true
} else nil
	local v2 = p1:update_entity_filter(p2, v1)
	local v3 = p1:get_or_create_storage_group(v2.result)
	local v4 = v3.active[p2]

	if v4 == nil then
		v4 = {
			component_count = 0,
			is_entity_mask = false,
			components = create_component_indexes()
		}
		v3.active[p2] = v4
		v3.active_count = v3.active_count + 1
	end

	v4.is_entity_mask = true
	p1.lookups.entities[p2] = {
		generator = v2,
		filter = v1,
		storage_group = v3,
		filtered_components = create_component_indexes(),
		components = create_component_indexes()
	}

	local v5 = p1.lookups.postponed[p2]

	if not v5 then
		return
	end

	for v6, v7 in v5 do
		for v8, v9 in v7 do
			p1:start_component(p2, v8, v6, v9.filter)
		end
	end

	p1.lookups.postponed[p2] = nil
end
function t2.set_entity(p1, p2, p3) --[[ set_entity | Line: 864 | Upvalues: common (copy) ]]
	local v1 = if p3 then if type(p3) == "table" then p3 else {
	[p3] = true
} else nil
	local v2 = p1.lookups.entities[p2]
	local v3

	if not v2 then
		common.log_error("attempted to modify the filter of an unactive entity")
	end

	v2.generator:destroy()
	v3 = p1:update_entity_filter(p2, v1)
	v2.generator = v3
	v2.filter = v1
	v3:run_subscribed()
	p1:rebind_component_generators(p2)
end
function t2.stop_entity(p1, p2) --[[ stop_entity | Line: 881 | Upvalues: common (copy), create_component_indexes (copy) ]]
	local v1 = p1.lookups.entities[p2]

	if not v1 then
		common.log_error("attemped to stop an unactive entity")
	end

	local v2 = p1.lookups.postponed[p2]

	for v3, v4 in v1.filtered_components do
		for v5, v6 in v4 do
			v6.band_generator:destroy()
			v6.generator:destroy()

			local storage_group = v6.storage_group
			local v7 = storage_group.active[p2]

			if v7 then
				local v8 = v7.components[v3]

				if v8[v5] then
					v8[v5] = nil
					v7.component_count = v7.component_count - 1

					if v7.component_count <= 0 and not v7.is_entity_mask then
						if storage_group.active[p2] then
							storage_group.active[p2] = nil
							storage_group.active_count = storage_group.active_count - 1
						else
							common.log_error("attempted to remove an entity that wasn\'t active")
						end
					end
				end
			end

			local storage_group2 = v6.storage_group

			storage_group2.shared_with[p2] = nil
			storage_group2.changes.added[p2] = nil
			storage_group2.changes.changed[p2] = nil
			storage_group2.changes.added_components[p2] = nil

			if v2 == nil then
				local v9 = create_component_indexes()

				p1.lookups.postponed[p2] = v9
				v2 = v9
			end

			v2[v3][v5] = {
				filter = v6.filter
			}
		end
	end

	for v10, v11 in v1.components do
		for v12 in v11 do
			if v2 == nil then
				local v13 = create_component_indexes()

				p1.lookups.postponed[p2] = v13
				v2 = v13
			end

			v2[v10][v12] = {
				filter = nil
			}
		end
	end

	v1.generator:destroy()

	local storage_group = v1.storage_group

	if storage_group.active[p2] then
		storage_group.active[p2] = nil
		storage_group.active_count = storage_group.active_count - 1
	else
		common.log_error("attempted to remove an entity that wasn\'t active")
	end

	v1.storage_group.changes.added[p2] = nil
	v1.storage_group.changes.changed[p2] = nil
	v1.storage_group.changes.added_components[p2] = nil
	p1.lookups.entities[p2] = nil
end
function t2.cleanup_entity(p1, p2) --[[ cleanup_entity | Line: 927 ]]
	p1.lookups.entities[p2] = nil
	p1.lookups.postponed[p2] = nil
	p1.lookups.deletions.entities[p2] = nil
	p1.lookups.deletions.components[p2] = nil
end
function t2.update_component_filter(p1, p2, p3, p4, p5) --[[ update_component_filter | Line: 934 ]]
	local v1 = p1:create_generator_from_filter(p5)

	return v1, p1:bind_component_generator(p2, p3, p4, v1)
end
function t2.start_component(p1, p2, p3, p4, p5) --[[ start_component | Line: 946 | Upvalues: create_component_indexes (copy) ]]
	local v1 = if p5 then if type(p5) == "table" then p5 else {
	[p5] = true
} else nil
	local v2 = p1:get_or_postpone_entity_lookup(p2, p3, p4, v1)

	if v2 == nil then
		return
	end

	if v1 == nil then
		v2.components[p4][p3] = true

		local v3 = v2.storage_group.active[p2]
		local v4 = v3.components[p4]

		if v4[p3] ~= nil then
			return
		end

		v4[p3] = true
		v3.component_count = v3.component_count + 1
	else
		local v5, v6 = p1:update_component_filter(p2, p3, p4, v1)
		local v7 = p1:get_or_create_storage_group(v6.result)
		local v8 = v7.active[p2]

		if v8 == nil then
			v8 = {
				component_count = 0,
				is_entity_mask = false,
				components = create_component_indexes()
			}
			v7.active[p2] = v8
			v7.active_count = v7.active_count + 1
		end

		local v9 = v8.components[p4]

		if v9[p3] == nil then
			v9[p3] = true
			v8.component_count = v8.component_count + 1
		end

		local shared_with = v7.shared_with
		local v10 = shared_with[p2]

		if v10 == nil then
			local v11 = create_component_indexes()

			shared_with[p2] = v11
			v10 = v11
		end

		v10[p4][p3] = true
		v2.filtered_components[p4][p3] = {
			generator = v5,
			band_generator = v6,
			filter = v1,
			storage_group = v7
		}
	end
end
function t2.set_component(p1, p2, p3, p4, p5) --[[ set_component | Line: 981 | Upvalues: create_component_indexes (copy) ]]
	local v1 = if p5 then if type(p5) == "table" then p5 else {
	[p5] = true
} else nil
	local v2 = p1:get_or_postpone_entity_lookup(p2, p3, p4, v1)

	if v2 == nil then
		return
	end

	local v3 = v2.filtered_components[p4][p3]

	if v1 == nil then
		if v3 == nil then
			return
		end

		v3.band_generator:destroy()
		v3.generator:destroy()
		p1:merge_component_filter(p2, p3, p4)
	else
		local v4, v5 = p1:update_component_filter(p2, p3, p4, v1)

		if v3 ~= nil then
			v3.band_generator:destroy()
			v3.generator:destroy()
			v3.band_generator = v5
			v3.generator = v4
			v3.filter = v1
			v5:run_subscribed()

			return
		end

		local v6 = p1:get_or_create_storage_group(v5.result)
		local v7

		if v6 and v6 == v2.storage_group then
			v7 = v2.storage_group

			local shared_with = v6.shared_with
			local v8 = shared_with[p2]

			if v8 == nil then
				local v9 = create_component_indexes()

				shared_with[p2] = v9
				v8 = v9
			end

			v8[p4][p3] = true
		else
			v7 = p1:move_component_storage(p2, p3, p4, v2.storage_group, v5.result)
		end

		v2.filtered_components[p4][p3] = {
			generator = v4,
			band_generator = v5,
			filter = v1,
			storage_group = v7
		}
		v2.components[p4][p3] = nil
	end
end
function t2.stop_component(p1, p2, p3, p4) --[[ stop_component | Line: 1043 | Upvalues: common (copy) ]]
	local v1, v2 = p1:get_component_lookup(p2, p3, p4)

	if v1 == nil then
		if v2 then
			local storage_group = v2.storage_group
			local v3 = storage_group.active[p2]

			if v3 then
				local v4 = v3.components[p4]

				if v4[p3] then
					v4[p3] = nil
					v3.component_count = v3.component_count - 1

					if v3.component_count <= 0 and not v3.is_entity_mask then
						if storage_group.active[p2] then
							storage_group.active[p2] = nil
							storage_group.active_count = storage_group.active_count - 1
						else
							common.log_error("attempted to remove an entity that wasn\'t active")
						end
					end
				end
			end

			v2.components[p4][p3] = nil
		else
			local v5 = p1.lookups.postponed[p2]

			if v5 ~= nil then
				v5[p4][p3] = nil
			end
		end
	else
		v1.band_generator:destroy()
		v1.generator:destroy()

		local storage_group = v1.storage_group
		local v6 = storage_group.active[p2]

		if v6 then
			local v7 = v6.components[p4]

			if v7[p3] then
				v7[p3] = nil
				v6.component_count = v6.component_count - 1

				if v6.component_count <= 0 and not v6.is_entity_mask then
					if storage_group.active[p2] then
						storage_group.active[p2] = nil
						storage_group.active_count = storage_group.active_count - 1
					else
						common.log_error("attempted to remove an entity that wasn\'t active")
					end
				end
			end
		end

		local v8 = v1.storage_group.shared_with[p2]

		if v8 ~= nil then
			v8[p4][p3] = nil
		end

		v2.filtered_components[p4][p3] = nil
	end
end
function t2.get_component_storage_group(p1, p2, p3, p4) --[[ get_component_storage_group | Line: 1067 ]]
	local v1, v2 = p1:get_component_lookup(p2, p3, p4)

	if v1 ~= nil then
		return v1.storage_group
	end

	if v2 then
		return v2.storage_group
	end

	error("attempted to use an entity that is not active")
end
function t2.allocate_propagated_entity_start(p1, p2) --[[ allocate_propagated_entity_start | Line: 1084 ]]
	local v1 = p1.lookups.entities[p2]

	if not v1 then
		return
	end

	v1.storage_group.changes.added[p2] = true

	for v2, v3 in v1.filtered_components do
		for v4, v5 in v3 do
			v5.storage_group.changes.added[p2] = true
		end
	end
end
function t2.allocate_shared_entity_start(p1, p2, p3, p4) --[[ allocate_shared_entity_start | Line: 1097 ]]
	local v1 = p1:get_component_lookup(p2, p3, p4)

	if v1 == nil then
		return
	end

	v1.storage_group.changes.added[p2] = true
end
function t2.allocate_entity_stop(p1, p2) --[[ allocate_entity_stop | Line: 1109 ]]
	local v1 = p1.lookups.entities[p2]

	if not v1 then
		return
	end

	local storage_group = v1.storage_group

	if not storage_group.deletions.entities[p2] then
		storage_group.deletions.entities[p2] = true
	end
end
function t2.allocate_component_start(p1, p2, p3, p4) --[[ allocate_component_start | Line: 1122 | Upvalues: create_component_indexes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, p4)
	local v2 = v1.changes.added_components[p2]

	if v2 == nil then
		local v3 = create_component_indexes()

		v1.changes.added_components[p2] = v3
		v2 = v3
	end

	v2[p4][p3] = true
end
function t2.allocate_component_stop(p1, p2, p3, p4) --[[ allocate_component_stop | Line: 1133 | Upvalues: create_component_indexes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, p4)

	if not v1 then
		return
	end

	local v2 = v1.deletions.components[p2]

	if v2 == nil then
		local v3 = create_component_indexes()

		v3[p4][p3] = true
		v1.deletions.components[p2] = v3
	else
		v2[p4][p3] = true
	end
end
function t2.deallocate_entity_stop(p1, p2) --[[ deallocate_entity_stop | Line: 1154 ]]
	local v1 = p1.lookups.deletions.entities[p2]

	if not v1 then
		return
	end

	local storage_group = v1.storage_group

	if not storage_group.deletions.entities[p2] then
		return
	end

	storage_group.deletions.entities[p2] = nil
	storage_group.deletions_count = storage_group.deletions_count - 1
end
function t2.deallocate_component_start(p1, p2, p3, p4) --[[ deallocate_component_start | Line: 1167 ]]
	local v1 = p1:get_component_storage_group(p2, p3, p4).changes.added_components[p2]

	if not v1 then
		return
	end

	v1[p4][p3] = nil
end
function t2.deallocate_component_stop(p1, p2, p3, p4) --[[ deallocate_component_stop | Line: 1180 ]]
	local v1 = p1.lookups.deletions.components[p2]
	local v2

	if v1 == nil then
		v2 = nil
	else
		local v3 = v1[p4]

		v2 = if v3 then v3[p3] else v3
	end

	if v2 == nil then
		return
	end

	local v4 = v2.storage_group.deletions.components[p2]

	if not (v4 and v4[p4][p3]) then
		return
	end

	v4[p4][p3] = nil
end
function t2.allocate_tag_addition(p1, p2, p3) --[[ allocate_tag_addition | Line: 1201 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.tag)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.tag_added[p3] = true
	v2.tag_removed[p3] = nil
end
function t2.allocate_component_change(p1, p2, p3, p4) --[[ allocate_component_change | Line: 1209 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.component)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.component_changed[p3] = p4
	v2.component_removed[p3] = nil
end
function t2.allocate_unreliable_addition(p1, p2, p3) --[[ allocate_unreliable_addition | Line: 1222 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.unreliable)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.unreliable_added[p3] = true
	v2.unreliable_removed[p3] = nil
end
function t2.allocate_pair_tag_addition(p1, p2, p3) --[[ allocate_pair_tag_addition | Line: 1234 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.pair_tag)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.pair_tag_added[p3] = true
	v2.pair_tag_removed[p3] = nil
end
function t2.allocate_pair_component_change(p1, p2, p3, p4) --[[ allocate_pair_component_change | Line: 1242 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.pair_component)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.pair_component_changed[p3] = p4
	v2.pair_component_removed[p3] = nil
end
function t2.allocate_relation_component_change(p1, p2, p3, p4, p5) --[[ allocate_relation_component_change | Line: 1255 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.relation_component)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	local v4 = v2.relation_component_changed[p3]

	if v4 == nil then
		v4 = {}
		v2.relation_component_changed[p3] = v4
	end

	v4[p4] = p5

	local v6 = v2.relation_component_removed[p3]

	if v6 == nil then
		return
	end

	v6[p4] = nil
end
function t2.allocate_relation_tag_addition(p1, p2, p3, p4) --[[ allocate_relation_tag_addition | Line: 1277 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.relation)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	local v4 = v2.relation_tag_added[p3]

	if v4 == nil then
		v4 = {}
		v2.relation_tag_added[p3] = v4
	end

	v4[p4] = true

	local v6 = v2.relation_tag_removed[p3]

	if not v6 then
		return
	end

	v6[p4] = nil
end
function t2.allocate_tag_removal(p1, p2, p3) --[[ allocate_tag_removal | Line: 1298 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.tag)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.tag_added[p3] = nil
	v2.tag_removed[p3] = true
end
function t2.allocate_component_removal(p1, p2, p3) --[[ allocate_component_removal | Line: 1306 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.component)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.component_changed[p3] = nil
	v2.component_removed[p3] = true
end
function t2.allocate_unreliable_removal(p1, p2, p3) --[[ allocate_unreliable_removal | Line: 1314 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.unreliable)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.unreliable_added[p3] = nil
	v2.unreliable_removed[p3] = true
end
function t2.allocate_pair_tag_removal(p1, p2, p3) --[[ allocate_pair_tag_removal | Line: 1326 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.pair_tag)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.pair_tag_added[p3] = nil
	v2.pair_tag_removed[p3] = true
end
function t2.allocate_pair_component_removal(p1, p2, p3) --[[ allocate_pair_component_removal | Line: 1334 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.pair_component)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	v2.pair_component_changed[p3] = nil
	v2.pair_component_removed[p3] = true
end
function t2.allocate_relation_tag_removal(p1, p2, p3, p4) --[[ allocate_relation_tag_removal | Line: 1342 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.relation)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	local v4 = v2.relation_tag_removed[p3]

	if v4 == nil then
		v4 = {}
		v2.relation_tag_removed[p3] = v4
	end

	v4[p4] = true

	local v6 = v2.relation_tag_added[p3]

	if not v6 then
		return
	end

	v6[p4] = nil
end
function t2.allocate_relation_component_removal(p1, p2, p3, p4) --[[ allocate_relation_component_removal | Line: 1363 | Upvalues: t (copy), create_entity_changes (copy) ]]
	local v1 = p1:get_component_storage_group(p2, p3, t.relation_component)
	local v2 = v1.changes.changed[p2]

	if v2 == nil then
		local v3 = create_entity_changes()

		v1.changes.changed[p2] = v3
		v2 = v3
	end

	local v4 = v2.relation_component_removed[p3]

	if v4 == nil then
		v4 = {}
		v2.relation_component_removed[p3] = v4
	end

	v4[p4] = true

	local v6 = v2.relation_component_changed[p3]

	if not v6 then
		return
	end

	v6[p4] = nil
end

local function remap_bitmask(p1, p2, p3, p4) --[[ remap_bitmask | Line: 1384 | Upvalues: utils (copy) ]]
	local v1 = utils.bitmask.create(p4)

	for v2, v3 in p3 do
		local v4 = p2[v2]

		if v4 then
			local v5 = p1:get(v4)

			if v5 then
				v1:set(v3, v5)

				continue
			end

			v1:clear(v3)
		end
	end

	return v1
end

local function bitmask_from_set(p1, p2) --[[ bitmask_from_set | Line: 1405 | Upvalues: utils (copy), t2 (copy) ]]
	local v1 = utils.bitmask.create(p1.member_count)

	for v2 in p2 do
		local v3 = p1.client_indexes[v2]

		if not v3 then
			local v4 = p1.client_indexes[p1.client_aliases[v2]]

			if v4 then
				if utils.is_client_valid(v4) then
					v3 = v4
				end
			elseif utils.is_client_valid(v2) then
				t2.register_client(p1, v2)
				v3 = p1.client_indexes[v2]
			end
		end

		if v3 then
			v1:set(v3)
		end
	end

	return v1
end

function t2.merge_storages(p1, p2, p3) --[[ merge_storages | Line: 1427 | Upvalues: create_component_indexes (copy), merge_component_actives (copy), merge_component_additions (copy), create_entity_changes (copy), merge_component_changes (copy) ]]
	if p3 == p2 then
		return
	end

	for v1, v2 in p2.active do
		local v3 = p3.active[v1]

		if v3 == nil then
			v3 = {
				component_count = 0,
				is_entity_mask = false,
				components = create_component_indexes()
			}
			p3.active[v1] = v3
			p3.active_count = p3.active_count + 1
		end

		merge_component_actives(v2, v3)

		if v2.is_entity_mask then
			p1.lookups.entities[v1].storage_group = p3
			v3.is_entity_mask = true
		end
	end

	for v4, v5 in p2.shared_with do
		for v6, v7 in v5 do
			for v8 in v7 do
				local shared_with = p3.shared_with
				local v9 = shared_with[v4]

				if v9 == nil then
					local v10 = create_component_indexes()

					shared_with[v4] = v10
					v9 = v10
				end

				v9[v6][v8] = true

				local v11 = p1:get_component_lookup(v4, v8, v6)

				if v11 ~= nil then
					v11.storage_group = p3
				end
			end
		end
	end

	for v12, v13 in p2.changes.added_components do
		local v14 = p3.changes.added_components[v12]

		if v14 == nil then
			local v15 = create_component_indexes()

			p3.changes.added_components[v12] = v15
			v14 = v15
		end

		merge_component_additions(v14, v13)
	end

	for v16, v17 in p2.changes.changed do
		local v18 = p3.changes.changed[v16]

		if v18 == nil then
			local v19 = create_entity_changes()

			p3.changes.changed[v16] = v19
			v18 = v19
		end

		merge_component_changes(v18, v17)
	end

	for v20 in p2.changes.added do
		p3.changes.added[v20] = true
	end

	for v21 in p2.deletions.entities do
		p3.deletions.entities[v21] = true
	end

	for v22, v23 in p2.deletions.components do
		for v24, v25 in v23 do
			for v26 in v25 do
				local components = p3.deletions.components
				local v27 = components[v22]

				if v27 == nil then
					local v28 = create_component_indexes()

					components[v22] = v28
					v27 = v28
				end

				v27[v24][v26] = true
			end
		end
	end
end
function t2.compact_members(p1) --[[ compact_members | Line: 1480 | Upvalues: remap_bitmask (copy) ]]
	local client_indexes = p1.client_indexes
	local t = {}
	local count = 0

	for v1 in client_indexes do
		t[v1] = count
		count = count + 1
	end

	p1.client_indexes = t
	p1.member_count = count

	for v2, v3 in p1.lookups.entities do
		local generator = v3.generator
		local bitmask = generator.bitmask

		if bitmask then
			generator.bitmask = remap_bitmask(bitmask, client_indexes, t, count)
		end

		generator.result = remap_bitmask(generator.result, client_indexes, t, count)

		for v4, v5 in v3.filtered_components do
			for v6, v7 in v5 do
				local generator2 = v7.generator
				local bitmask2 = generator2.bitmask

				if bitmask2 then
					generator2.bitmask = remap_bitmask(bitmask2, client_indexes, t, count)
				end

				generator2.result = remap_bitmask(generator2.result, client_indexes, t, count)

				local band_generator = v7.band_generator
				local bitmask3 = band_generator.bitmask

				if bitmask3 then
					band_generator.bitmask = remap_bitmask(bitmask3, client_indexes, t, count)
				end

				band_generator.result = remap_bitmask(band_generator.result, client_indexes, t, count)
			end
		end
	end

	local all_members_generator = p1.all_members_generator
	local unactive_members_generator = p1.unactive_members_generator
	local active_members_generator = p1.active_members_generator

	all_members_generator.bitmask = remap_bitmask(all_members_generator.bitmask, client_indexes, t, count)
	all_members_generator.result = all_members_generator.bitmask
	unactive_members_generator.bitmask = remap_bitmask(unactive_members_generator.bitmask, client_indexes, t, count)
	unactive_members_generator.result = unactive_members_generator.bitmask
	active_members_generator.result = remap_bitmask(active_members_generator.result, client_indexes, t, count)

	local t2 = {}

	for v8, v9 in p1.storages do
		local v10 = remap_bitmask(v9.mask.bitmask, client_indexes, t, count)

		v9.mask.bitmask = v10

		local v11 = v10:tostring()

		v9.mask.hash = v11
		v9.mask.members = p1:get_clients_from_bitmask(v10)

		local v12 = t2[v11]

		if v12 then
			p1:merge_storages(v9, v12)

			continue
		end

		t2[v11] = v9
	end

	p1.storages = t2
end
function t2.create_generator_from_filter(p1, p2) --[[ create_generator_from_filter | Line: 1551 ]]
	local v1 = true

	for v2, v3 in p2 do
		v1 = if v3 then true else false

		break
	end

	if v1 then
		return p1:create_include_generator(p2)
	end

	return p1:create_exclude_generator(p2)
end
function t2.create_exclude_generator(p1, p2) --[[ create_exclude_generator | Line: 1563 | Upvalues: bitmask_from_set (copy), mask_generator (copy) ]]
	local v1 = bitmask_from_set(p1, p2)
	local active_members_generator = p1.active_members_generator
	local v2 = mask_generator.create(v1, function(p1) --[[ Line: 1567 | Upvalues: active_members_generator (copy) ]]
		return active_members_generator.result:band(p1.bitmask:bnot())
	end)

	v2:track(active_members_generator)

	return v2
end
function t2.create_include_generator(p1, p2) --[[ create_include_generator | Line: 1577 | Upvalues: bitmask_from_set (copy), mask_generator (copy) ]]
	local v1 = bitmask_from_set(p1, p2)
	local active_members_generator = p1.active_members_generator
	local v2 = mask_generator.create(v1, function(p1) --[[ Line: 1581 | Upvalues: active_members_generator (copy) ]]
		return p1.bitmask:band(active_members_generator.result)
	end)

	v2:track(active_members_generator)

	return v2
end
function t2.create_all_members_generator(p1) --[[ create_all_members_generator | Line: 1590 | Upvalues: utils (copy), mask_generator (copy) ]]
	local t = {}

	for v1 in p1.client_indexes do
		t[v1] = true
	end

	return mask_generator.create((utils.bitmask.from_set(p1.client_indexes, t, p1.member_count)))
end
function t2.create_unactive_generator(p1) --[[ create_unactive_generator | Line: 1598 | Upvalues: utils (copy), mask_generator (copy) ]]
	return mask_generator.create((utils.bitmask.from_set(p1.client_indexes, p1.unreplicated, p1.member_count)))
end
function t2.create_active_generator(p1) --[[ create_active_generator | Line: 1602 | Upvalues: mask_generator (copy) ]]
	local all_members_generator = p1.all_members_generator
	local unactive_members_generator = p1.unactive_members_generator
	local v1 = mask_generator.create(nil, function() --[[ Line: 1606 | Upvalues: all_members_generator (copy), unactive_members_generator (copy) ]]
		return all_members_generator.result:band(unactive_members_generator.result:bnot())
	end)

	v1:track(all_members_generator)
	v1:track(unactive_members_generator)

	return v1
end
function t2.register_client(p1, p2) --[[ register_client | Line: 1619 ]]
	if p1.client_indexes[p2] then
		return
	end

	local member_count = p1.member_count

	p1.client_indexes[p2] = member_count
	p1.member_count = p1.member_count + 1
	p1.unreplicated[p2] = true
	p1.unactive_members_generator.bitmask:set(member_count)
	p1.all_members_generator.bitmask:set(member_count)
	p1.active_members_generator:compute()

	if not (p1.member_count >= p1.compact_count) then
		return
	end

	p1:compact_members()
end
function t2.unregister_client(p1, p2) --[[ unregister_client | Line: 1638 ]]
	local v1 = p1.client_indexes[p2]

	if v1 ~= nil then
		p1.client_indexes[p2] = nil
		p1.all_members_generator.bitmask:clear(v1)
		p1.active_members_generator:compute()
	end
end
function t2.activate_client(p1, p2) --[[ activate_client | Line: 1648 ]]
	p1.unreplicated[p2] = nil
	p1.unactive_members_generator.bitmask:clear(p1.client_indexes[p2])
	p1.active_members_generator:compute()
end
function t2.member_is_active(p1, p2) --[[ member_is_active | Line: 1656 ]]
	local v1 = p1.client_indexes[p2]

	if v1 == nil then
		return false
	end

	return p1.active_members_generator.result:get(v1)
end

return {
	create = function() --[[ create | Line: 1665 | Upvalues: t2 (copy) ]]
		local t = {
			client_indexes = {},
			group_indexes = {},
			client_aliases = {},
			member_count = 0,
			compact_count = 100,
			storages = {},
			lookups = {
				entities = {},
				components = {},
				deletions = {
					entities = {},
					components = {}
				},
				filter_deltas = {
					entities = {},
					components = {}
				},
				postponed = {}
			},
			unreplicated = {}
		}

		t.all_members_generator = t2.create_all_members_generator(t)
		t.unactive_members_generator = t2.create_unactive_generator(t)
		t.active_members_generator = t2.create_active_generator(t)

		return setmetatable(t, t2)
	end,
	masking_controller = t2,
	COMPONENT_TYPES = t
}