-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local common = require(script.Parent:WaitForChild("common"))

require(script.Parent:WaitForChild("types"))
require(script.Parent:WaitForChild("customid"))

local utils = require(script.Parent:WaitForChild("utils"))
local cursor = utils.cursor
local t = {}

t.__index = t

local t2 = {
	full = 1,
	entity = 2,
	updates = 3,
	unreliable = 4
}
local ecs_name = common.ecs_name
local wildcard = common.wildcard
local pair = common.pair
local iterate_all_relations = common.iterate_all_relations
local world_entity = common.world_entity
local world_add = common.world_add
local world_set = common.world_set
local world_remove = common.world_remove
local world_get = common.world_get
local world_has = common.world_has
local world_delete = common.world_delete
local hook_added = common.hook_added
local hook_changed = common.hook_changed
local hook_removed = common.hook_removed

local function QUERY_CURRENT_COMPONENTS(p1) --[[ QUERY_CURRENT_COMPONENTS | Line: 168 ]]
	for v1, v2 in p1.world:query(p1.components.serdes):iter() do
		p1.component_serdes[v1] = v2
	end
end

local function get_or_create_entity(p1, p2) --[[ get_or_create_entity | Line: 174 | Upvalues: world_entity (copy), world_add (copy) ]]
	local world = p1.world
	local v1 = p1.server_ids[p2]

	if v1 then
		return v1
	end

	local v2 = world_entity(world)

	world_add(world, v2, p1.components.__alive_tracking__)
	p1.server_ids[p2] = v2
	p1.client_ids[v2] = p2

	for v3, v4 in p1.addition_hooks do
		v4(v2)
	end

	return v2
end

local function get_or_create_command_buffer(p1, p2) --[[ get_or_create_command_buffer | Line: 195 ]]
	local command_buffers = p1.command_buffers

	if not command_buffers then
		error("attempted to use a command buffer without being active. (this should never happen)")
	end

	local v1 = command_buffers[p2]

	if not v1 then
		local t = {
			tags = {},
			components = {},
			unreliable_components = {},
			remove = {},
			pairs_add = {},
			pairs_set = {},
			pairs_unprocessed = {},
			pairs_remove = {},
			relations_clear = {}
		}

		command_buffers[p2] = t
		v1 = t
	end

	return v1
end

function t.entity_set(p1, p2, p3, p4, p5) --[[ entity_set | Line: 220 | Upvalues: get_or_create_command_buffer (copy), world_set (copy) ]]
	if p1.command_buffers_active then
		get_or_create_command_buffer(p1, p2).components[p3] = {
			value = p4
		}

		return
	end

	if not p5 then
		world_set(p1.world, p2, p3, p4)

		return
	end

	if not p5.overrides then
		world_set(p1.world, p2, p3, p4)
	end

	for v1, v2 in p5.callbacks do
		v2(p2, p3, p4)
	end
end
function t.entity_add(p1, p2, p3, p4) --[[ entity_add | Line: 244 | Upvalues: get_or_create_command_buffer (copy), world_add (copy) ]]
	if p1.command_buffers_active then
		get_or_create_command_buffer(p1, p2).tags[p3] = true

		return
	end

	if not p4 then
		world_add(p1.world, p2, p3)

		return
	end

	if not p4.overrides then
		world_add(p1.world, p2, p3)
	end

	for v1, v2 in p4.callbacks do
		v2(p2, p3)
	end
end
function t.entity_set_unreliable(p1, p2, p3, p4, p5) --[[ entity_set_unreliable | Line: 262 | Upvalues: get_or_create_command_buffer (copy), world_has (copy), t (copy) ]]
	if p1.command_buffers_active then
		get_or_create_command_buffer(p1, p2).unreliable_components[p3] = {
			value = p4
		}

		return
	end

	if not world_has(p1.world, p2, p3) then
		return
	end

	t.entity_set(p1, p2, p3, p4, p5)
end
function t.entity_set_pair(p1, p2, p3, p4, p5, p6) --[[ entity_set_pair | Line: 279 | Upvalues: get_or_create_command_buffer (copy), t (copy), pair (copy) ]]
	if not p1.command_buffers_active then
		t.entity_set(p1, p2, pair(p3, p4), p5, p6)

		return
	end

	local v1 = get_or_create_command_buffer(p1, p2)
	local v2 = v1.pairs_set[p3]

	if v2 then
		v2[p4] = {
			value = p5
		}
	else
		v1.pairs_set[p3] = {
			[p4] = {
				value = p5
			}
		}
	end
end
function t.entity_add_pair(p1, p2, p3, p4, p5) --[[ entity_add_pair | Line: 301 | Upvalues: get_or_create_command_buffer (copy), t (copy), pair (copy) ]]
	if not p1.command_buffers_active then
		t.entity_add(p1, p2, pair(p3, p4), p5)

		return
	end

	local v1 = get_or_create_command_buffer(p1, p2)
	local v2 = v1.pairs_add[p3]

	if v2 then
		v2[p4] = true
	else
		v1.pairs_add[p3] = {
			[p4] = true
		}
	end
end
function t.entity_set_postponed_pair(p1, p2, p3, p4, p5, p6) --[[ entity_set_postponed_pair | Line: 322 | Upvalues: get_or_create_command_buffer (copy), t (copy), world_set (copy) ]]
	if not p1.command_buffers_active then
		local v1, v2 = t.read_pair_value(p1, p3, p4, p5, p6)

		world_set(p1.world, p2, v1, v2)

		return v2
	end

	local pairs_unprocessed = get_or_create_command_buffer(p1, p2).pairs_unprocessed
	local v3 = pairs_unprocessed[p3]

	if v3 then
		v3[p4] = {
			cursor = p5,
			variants = p6
		}
	else
		pairs_unprocessed[p3] = {
			[p4] = {
				cursor = p5,
				variants = p6
			}
		}
	end

	return nil
end
function t.entity_remove(p1, p2, p3, p4) --[[ entity_remove | Line: 356 | Upvalues: get_or_create_command_buffer (copy), world_remove (copy) ]]
	if p1.command_buffers_active then
		get_or_create_command_buffer(p1, p2).remove[p3] = true

		return
	end

	if p4 then
		for v1, v2 in p4.callbacks do
			v2(p2, p3)
		end

		if not p4.overrides then
			world_remove(p1.world, p2, p3)
		end
	else
		world_remove(p1.world, p2, p3)
	end
end
function t.entity_remove_pair(p1, p2, p3, p4, p5) --[[ entity_remove_pair | Line: 374 | Upvalues: get_or_create_command_buffer (copy), t (copy), pair (copy) ]]
	if not p1.command_buffers_active then
		t.entity_remove(p1, p2, pair(p3, p4), p5)

		return
	end

	local v1 = get_or_create_command_buffer(p1, p2)
	local v2 = v1.pairs_remove[p3]

	if v2 then
		v2[p4] = true
	else
		v1.pairs_remove[p3] = {
			[p4] = true
		}
	end
end
function t.entity_clear_relation(p1, p2, p3, p4) --[[ entity_clear_relation | Line: 395 | Upvalues: get_or_create_command_buffer (copy), iterate_all_relations (copy), world_remove (copy) ]]
	if p1.command_buffers_active then
		get_or_create_command_buffer(p1, p2).relations_clear[p3] = true

		return
	end

	local world = p1.world

	if p4 then
		iterate_all_relations(world, p2, p3, function(p1) --[[ Line: 407 | Upvalues: p4 (copy), p2 (copy), world_remove (ref), world (copy) ]]
			for v1, v2 in p4.callbacks do
				v2(p2, p1)
			end

			if p4.overrides then
				return
			end

			world_remove(world, p2, p1)
		end)
	else
		iterate_all_relations(world, p2, p3, function(p1) --[[ Line: 416 | Upvalues: world_remove (ref), world (copy), p2 (copy) ]]
			world_remove(world, p2, p1)
		end)
	end
end

local function read_variant_value(p1, p2, p3) --[[ read_variant_value | Line: 423 | Upvalues: cursor (copy) ]]
	if p2 then
		local v2 = cursor.read_buffer(p1, p2.bytespan or cursor.read_vlq(p1))
		local v3 = nil

		if p2.includes_variants then
			local v4 = cursor.read_vlq(p1)

			if v4 > 0 then
				v3 = table.move(p3, v4, v4 + cursor.read_vlq(p1) - 1, 1, {})
			end
		end

		return p2.deserialize(v2, v3)
	end

	local v7 = cursor.read_vlq(p1)

	if v7 == 0 then
		return nil
	end

	return p3[v7]
end

function t.read_pair_value(p1, p2, p3, p4, p5) --[[ read_pair_value | Line: 451 | Upvalues: pair (copy), wildcard (copy), read_variant_value (copy) ]]
	local v1 = pair(p2, p3)

	return v1, read_variant_value(p4, p1.component_serdes[v1] or p1.component_serdes[pair(p2, wildcard)], p5)
end
function t.read_component_value(p1, p2, p3, p4) --[[ read_component_value | Line: 465 | Upvalues: cursor (copy) ]]
	local v1 = p1.shared.serdes[p2]

	if v1 then
		local v3 = cursor.read_buffer(p3, v1.bytespan or cursor.read_vlq(p3))
		local v4 = nil

		if v1.includes_variants then
			local v5 = cursor.read_vlq(p3)

			if v5 > 0 then
				v4 = table.move(p4, v5, v5 + cursor.read_vlq(p3) - 1, 1, {})
			end
		end

		return v1.deserialize(v3, v4)
	end

	local v8 = cursor.read_vlq(p3)

	if v8 == 0 then
		return nil
	end

	return p4[v8]
end
function t.read_component_id(p1, p2) --[[ read_component_id | Line: 500 | Upvalues: cursor (copy) ]]
	local components = p1.shared.components
	local nonsharedcomponent = cursor.read_span(p2, #components.keys)
	local v1 = components.indexes[nonsharedcomponent]

	if v1 then
		return v1
	end

	print("NON SHARED COMPONENT", nonsharedcomponent, p1.shared.components)
	error("received a non shared component")
end
function t.resolve_global(p1, p2) --[[ resolve_global | Line: 511 ]]
	if p1.global_handler then
		return p1.global_handler(p2)
	end

	error("global id parser not set, consider using client:handle_global()")
end
function t.read_entity_id(p1, p2) --[[ read_entity_id | Line: 520 | Upvalues: cursor (copy), t (copy) ]]
	local v1 = cursor.readu8(p2)

	if not (v1 <= 10) then
		return t.resolve_global(p1, v1 - 10), nil, v1
	end

	if v1 == 1 or (v1 == 3 or v1 == 2) then
		local v2 = cursor.readu40(p2)

		return p1.server_ids[v2], v2, v1
	end

	if v1 == 4 then
		return t.read_component_id(p1, p2), nil, v1
	end

	error(("malformed entity type %* "):format(v1) .. cursor.readu32(p2))
end

local function read_vlq_bitmask(p1, p2, p3) --[[ read_vlq_bitmask | Line: 540 | Upvalues: utils (copy), cursor (copy) ]]
	if utils.checkbit(p2, p3) then
		return cursor.read_vlq(p1)
	end

	return 0
end

function t.process_entity_id(p1, p2, p3, p4) --[[ process_entity_id | Line: 548 | Upvalues: t (copy), cursor (copy), common (copy), get_or_create_entity (copy) ]]
	local v1, v2, v3 = t.read_entity_id(p1, p2)

	if v1 then
		if v3 == 3 then
			t.read_component_id(p1, p2)
		elseif v3 == 2 then
			cursor.readu8(p2)
		end

		return p4(v1)
	end

	if v3 ~= 3 and v3 ~= 2 then
		p4((get_or_create_entity(p1, v2)))

		return
	end

	if v3 == 3 then
		p3[v2] = t.read_component_id(p1, p2)
	elseif v3 == 2 then
		local v5 = p1.shared.custom_ids.indexes[cursor.readu8(p2)]

		if not v5 then
			common.log_error("attempted to use a custom id that wasn\'t registered")
		end

		p3[v2] = v5
	end

	if p1.command_buffers_active then
		p4(-v2)
	else
		p1.command_buffers_active = true
		p4(-v2)
		p1.command_buffers_active = false
	end
end
function t.process_entity_relations(p1, p2, p3, p4) --[[ process_entity_relations | Line: 596 | Upvalues: t (copy), cursor (copy), pair (copy) ]]
	local v1 = t.read_component_id(p1, p3)
	local v2 = cursor.read_vlq(p3)
	local v3 = p1.network_hooks.changed[pair(p1.components.relation, v1)]

	for i = 1, v2 do
		t.process_entity_id(p1, p3, p4, function(p12) --[[ Line: 603 | Upvalues: t (ref), p1 (copy), p2 (copy), v1 (copy), v3 (copy) ]]
			t.entity_add_pair(p1, p2, v1, p12, v3)
		end)
	end
end
function t.process_entity_relation_values(p1, p2, p3, p4, p5) --[[ process_entity_relation_values | Line: 609 | Upvalues: t (copy), cursor (copy), pair (copy) ]]
	local v1 = t.read_component_id(p1, p3)
	local v2 = cursor.read_vlq(p3)
	local v3 = p1.network_hooks.changed[pair(p1.components.relation, v1)]

	for i = 1, v2 do
		local v4 = t.read_component_value(p1, v1, p3, p5)

		t.process_entity_id(p1, p3, p4, function(p12) --[[ Line: 623 | Upvalues: t (ref), p1 (copy), p2 (copy), v1 (copy), v4 (copy), v3 (copy) ]]
			t.entity_set_pair(p1, p2, v1, p12, v4, v3)
		end)
	end
end
function t.process_entity_pair_value(p1, p2, p3, p4, p5) --[[ process_entity_pair_value | Line: 629 | Upvalues: t (copy), cursor (copy) ]]
	local v1 = t.read_component_id(p1, p3)

	t.process_entity_id(p1, p3, p4, function(p12) --[[ Line: 637 | Upvalues: cursor (ref), p3 (copy), t (ref), p1 (copy), v1 (copy), p5 (copy), p2 (copy) ]]
		if p12 > 0 then
			local v2 = p3.offset - cursor.read_vlq(p3)
			local _, v3 = t.read_pair_value(p1, v1, p12, p3, p5)

			t.entity_set_pair(p1, p2, v1, p12, v3)
			p3.offset = v2
		else
			local v4 = cursor.from_offset(p3.buffer, p3.offset)
			local v6 = p3

			v6.offset = v6.offset - cursor.read_vlq(p3)
			t.entity_set_postponed_pair(p1, p2, v1, p12, v4, p5)
		end
	end)
end
function t.process_entity_pair(p1, p2, p3, p4) --[[ process_entity_pair | Line: 657 | Upvalues: t (copy) ]]
	local v1 = t.read_component_id(p1, p3)

	t.process_entity_id(p1, p3, p4, function(p12) --[[ Line: 659 | Upvalues: t (ref), p1 (copy), p2 (copy), v1 (copy) ]]
		t.entity_add_pair(p1, p2, v1, p12)
	end)
end
function t.process_entity(p1, p2, p3, p4, p5) --[[ process_entity | Line: 665 | Upvalues: cursor (copy), utils (copy), t (copy), pair (copy) ]]
	local v1 = cursor.readu8(p3)
	local changed = p1.network_hooks.changed
	local components = p1.components

	for i = 1, if utils.checkbit(v1, 0) then cursor.read_vlq(p3) else 0 do
		local v3 = t.read_component_id(p1, p3)

		t.entity_add(p1, p2, v3, changed[pair(components.reliable, v3)])
	end

	for j = 1, if utils.checkbit(v1, 1) then cursor.read_vlq(p3) else 0 do
		local v6 = t.read_component_id(p1, p3)
		local v7 = t.read_component_value(p1, v6, p3, p5)

		t.entity_set(p1, p2, v6, v7, changed[pair(components.reliable, v6)])
	end

	for k = 1, if utils.checkbit(v1, 2) then cursor.read_vlq(p3) else 0 do
		t.process_entity_pair(p1, p2, p3, p4)
	end

	for n = 1, if utils.checkbit(v1, 3) then cursor.read_vlq(p3) else 0 do
		t.process_entity_pair_value(p1, p2, p3, p4, p5)
	end

	for m = 1, if utils.checkbit(v1, 4) then cursor.read_vlq(p3) else 0 do
		t.process_entity_relations(p1, p2, p3, p4)
	end

	for i = 1, if utils.checkbit(v1, 5) then cursor.read_vlq(p3) else 0 do
		t.process_entity_relation_values(p1, p2, p3, p4, p5)
	end
end
function t.finish_replication(p1) --[[ finish_replication | Line: 712 ]]
	p1.is_replicating = false

	for v1, v2 in p1.after_replication_callbacks do
		v2()
	end

	table.clear(p1.after_replication_callbacks)
end
function t.resolve_dirty(p1) --[[ resolve_dirty | Line: 720 | Upvalues: utils (copy) ]]
	if not p1.is_shared_dirty then
		return
	end

	p1.shared = utils.resolved_shared(p1.world, p1.components, p1.registered_custom_ids, p1.component_serdes)
	p1.is_shared_dirty = false
end

local function check_packet_type(p1, p2) --[[ check_packet_type | Line: 733 | Upvalues: cursor (copy), t2 (copy), common (copy) ]]
	local v1 = cursor.readu8(p1)

	if v1 == p2 then
		return
	end

	local v2 = nil
	local v3 = nil

	for v4, v5 in t2 do
		if v5 == v1 then
			v3 = v4

			continue
		end

		if v5 == p2 then
			v2 = v4
		end
	end

	common.log_error((("packet type mismatch, expected: %* got: %* instead"):format(v2 or "(unknown)", v3 or "(unknown)")))
end

function t.apply_command_buffer(p1, p2, p3, p4) --[[ apply_command_buffer | Line: 752 | Upvalues: pair (copy), t (copy) ]]
	local components = p1.components

	for v1 in p3.tags do
		t.entity_add(p1, p2, v1, p1.network_hooks.changed[pair(components.reliable, v1)])
	end

	for v3, v4 in p3.components do
		t.entity_set(p1, p2, v3, v4.value, p1.network_hooks.changed[pair(components.reliable, v3)])
	end

	for v6, v7 in p3.unreliable_components do
		t.entity_set(p1, p2, v6, v7.value, p1.network_hooks.changed[pair(components.unreliable, v6)])
	end

	for v9 in p3.remove do
		t.entity_remove(p1, p2, v9, p1.network_hooks.removed[pair(components.reliable, v9)])
	end

	for v11, v12 in p3.pairs_add do
		local v13 = p1.network_hooks.changed[pair(components.relation, v11)]

		for v14 in v12 do
			local v15 = p4(v14)

			if v15 then
				t.entity_add_pair(p1, p2, v11, v15, v13)
			end
		end
	end

	for v16, v17 in p3.pairs_set do
		local v18 = p1.network_hooks.changed[pair(components.relation, v16)]

		for v19, v20 in v17 do
			local v21 = p4(v19)

			if v21 then
				t.entity_set_pair(p1, p2, v16, v21, v20.value, v18)
			end
		end
	end

	for v22, v23 in p3.pairs_unprocessed do
		for v24, v25 in v23 do
			local v26 = p4(v24)

			if v26 then
				local processed_value = v25.processed_value

				if processed_value then
					t.entity_set_pair(p1, p2, v22, v26, processed_value.value)

					continue
				end

				v25.processed_value = {
					value = t.entity_set_postponed_pair(p1, p2, v22, v26, v25.cursor, v25.variants)
				}
			end
		end
	end

	for v27, v28 in p3.pairs_remove do
		local v29 = p1.network_hooks.removed[pair(components.relation, v27)]

		for v30 in v28 do
			local v31 = p4(v30)

			if v31 then
				t.entity_remove_pair(p1, p2, v27, v31, v29)
			end
		end
	end

	for v32 in p3.relations_clear do
		t.entity_clear_relation(p1, p2, v32, p1.network_hooks.removed[pair(components.relation, v32)])
	end
end
function t.find_component_in_buffer(p1, p2) --[[ find_component_in_buffer | Line: 832 ]]
	return p1.components[p2] or p1.unreliable_components[p2]
end
function t.find_has_in_buffer(p1, p2) --[[ find_has_in_buffer | Line: 836 ]]
	return if p1.tags[p2] == nil and p1.components[p2] == nil then p1.unreliable_components[p2] ~= nil else true
end
function t.find_pair_in_buffer(p1, p2, p3, p4) --[[ find_pair_in_buffer | Line: 842 ]]
	local v1 = p1.pairs_set[p2]

	if v1 then
		for v2, v3 in v1 do
			if p4(v2) == p3 then
				return true, v3.value
			end
		end
	end

	local v4 = p1.pairs_add[p2]

	if v4 then
		for v5 in v4 do
			if p4(v5) == p3 then
				return true, nil
			end
		end
	end

	local v6 = p1.pairs_unprocessed[p2]

	if not v6 then
		return false, nil
	end

	for v7, v8 in v6 do
		if p4(v7) == p3 then
			local processed_value = v8.processed_value

			return true, if processed_value then processed_value.value else processed_value
		end
	end

	return false, nil
end
function t.find_target_in_buffer(p1, p2, p3) --[[ find_target_in_buffer | Line: 882 ]]
	local count = 0
	local v1 = p1.pairs_add[p2]

	if v1 then
		for v2 in v1 do
			if count == (p3 or 0) then
				return v2
			end

			count = count + 1
		end
	end

	local v3 = p1.pairs_set[p2]

	if v3 then
		for v4 in v3 do
			if count == (p3 or 0) then
				return v4
			end

			count = count + 1
		end
	end

	local v5 = p1.pairs_unprocessed[p2]

	if not v5 then
		return nil
	end

	for v6 in v5 do
		if count == (p3 or 0) then
			return v6
		end

		count = count + 1
	end

	return nil
end
function t.finish_custom_ids(p1, p2, p3) --[[ finish_custom_ids | Line: 922 | Upvalues: world_get (copy), common (copy), t (copy), world_add (copy) ]]
	local world = p1.world
	local t2 = {}
	local t3 = {}

	local function find(p12) --[[ find | Line: 931 | Upvalues: p1 (copy) ]]
		if p12 > 0 then
			return p12, p12
		end

		local v1 = -p12
		local v2 = p1.server_ids[v1]

		if v2 then
			return v2, v1
		end

		return nil, v1
	end

	local function v1(p12, p22) --[[ process | Line: 944 | Upvalues: p1 (copy), t3 (copy), p3 (copy), p2 (copy), world_get (ref), world (copy), common (ref), t (ref), t2 (copy), world_add (ref), v1 (copy) ]]
		local v12, v2

		if p12 > 0 then
			v12 = p12
			v2 = p12
		else
			local v3 = -p12
			local v4 = p1.server_ids[v3]

			if v4 then
				v12 = v4
				v2 = v3
			else
				v12 = nil
				v2 = v3
			end
		end

		if v12 then
			return v12
		end

		if t3[v2] then
			return nil
		end

		local v5 = p3[p12]
		local v6 = if p22 then p22 else p2[v2]
		local v7

		if type(v6) == "number" then
			local v8 = world_get(world, v6, p1.components.custom_handler)

			if not v8 then
				return common.log_error((("received a custom id for a non custom component, consider adding custom_handler to component: %*"):format((common.log_component(world, v6)))))
			end

			if v5 then
				local v9 = t.find_component_in_buffer(v5, v6)

				if v9 then
					v7 = v8(v9.value)
				else
					common.log_warn((("No component found for custom id handler: %*"):format((common.log_component(world, v6)))))
					v7 = v8(nil)
				end
			else
				common.log_warn((("No component found for custom id handler: %*"):format((common.log_component(world, v6)))))
				v7 = v8(nil)
			end
		else
			local handle_callback = v6.handle_callback

			if not handle_callback then
				return common.log_error("no handler callback was set for custom id:", v6.identifier)
			end

			v7 = handle_callback(t2.create_context(p12))
		end

		if v7 then
			world_add(world, v7, p1.components.__alive_tracking__)
			p1.server_ids[v2] = v7
			p1.client_ids[v7] = v2

			if v5 then
				t.apply_command_buffer(p1, v7, v5, v1)
				p3[p12] = nil
			end
		end

		t3[v2] = true

		return v7
	end

	function t2.create_context(p1) --[[ create_context | Line: 1009 | Upvalues: p3 (copy), t (ref), v1 (copy), find (copy) ]]
		local v12 = p3[p1]

		local function component(p1) --[[ component | Line: 1012 | Upvalues: v12 (copy), t (ref) ]]
			if not v12 then
				return nil
			end

			local v1 = t.find_component_in_buffer(v12, p1)

			return if v1 then v1.value else v1
		end

		local function target(p1, p2) --[[ target | Line: 1019 | Upvalues: v12 (copy), t (ref), v1 (ref) ]]
			if not v12 then
				return nil
			end

			local v13 = t.find_target_in_buffer(v12, p1, p2)

			if v13 then
				return v1(v13)
			end

			return nil
		end

		local function pair_value(p1, p2) --[[ pair_value | Line: 1029 | Upvalues: v12 (copy), t (ref), find (ref) ]]
			if v12 then
				local _, v1 = t.find_pair_in_buffer(v12, p1, p2, find)

				return v1
			end

			return nil
		end

		local function has_pair(p1, p2) --[[ has_pair | Line: 1036 | Upvalues: v12 (copy), t (ref), find (ref) ]]
			if v12 then
				return t.find_pair_in_buffer(v12, p1, p2, find)
			end

			return nil
		end

		local function has(p1) --[[ has | Line: 1043 | Upvalues: v12 (copy), t (ref) ]]
			if v12 then
				return t.find_has_in_buffer(v12, p1)
			end

			return nil
		end

		local function entity(p1) --[[ entity | Line: 1049 | Upvalues: v1 (ref) ]]
			return v1(-p1)
		end

		return {
			entity_id = math.abs(p1),
			has = has,
			component = component,
			target = target,
			pair_value = pair_value,
			has_pair = has_pair,
			entity = entity
		}
	end

	for v2, v3 in p2 do
		v1(-v2, v3)
	end

	for v4, v5 in p3 do
		if not (v4 < 0) then
			t.apply_command_buffer(p1, v4, v5, v1)
		end
	end
end
function t.apply_full(p1, p2, p3) --[[ apply_full | Line: 1079 | Upvalues: t (copy), cursor (copy), check_packet_type (copy), t2 (copy) ]]
	t.resolve_dirty(p1)
	p1.is_replicating = true

	local v1 = cursor.from(p2)

	check_packet_type(v1, t2.full)

	local v2 = cursor.read_vlq(v1)
	local v3 = if p3 then #p3 + 1 else p3
	local t3 = {}

	p1.command_buffers = t3

	local t4 = {}

	for i = 1, v2 do
		local v4 = cursor.read_vlq(v1)
		local v5 = p3 and p3[v3 - i]

		for j = 1, v4 do
			t.process_entity_id(p1, v1, t4, function(p12) --[[ Line: 1099 | Upvalues: t (ref), p1 (copy), v1 (copy), t4 (copy), v5 (copy) ]]
				t.process_entity(p1, p12, v1, t4, v5)
			end)
		end
	end

	t.finish_custom_ids(p1, t4, t3)
	t.finish_replication(p1)
end
function t.apply_entity(p1, p2, p3) --[[ apply_entity | Line: 1109 | Upvalues: t (copy), cursor (copy), check_packet_type (copy), t2 (copy) ]]
	t.resolve_dirty(p1)
	p1.is_replicating = true

	local v1 = cursor.from(p2)

	check_packet_type(v1, t2.entity)

	local v2 = cursor.read_vlq(v1)
	local v3 = if p3 then #p3 + 1 else p3
	local t3 = {}

	p1.command_buffers = t3

	local t4 = {}

	for i = 1, v2 do
		local v4 = p3 and p3[v3 - i]

		t.process_entity_id(p1, v1, t4, function(p12) --[[ Line: 1127 | Upvalues: t (ref), p1 (copy), v1 (copy), t4 (copy), v4 (copy) ]]
			t.process_entity(p1, p12, v1, t4, v4)
		end)
	end

	t.finish_custom_ids(p1, t4, t3)
	t.finish_replication(p1)
end
function t.apply_updates(p1, p2, p3) --[[ apply_updates | Line: 1136 | Upvalues: t (copy), cursor (copy), check_packet_type (copy), t2 (copy), utils (copy), pair (copy), world_delete (copy) ]]
	t.resolve_dirty(p1)
	p1.is_replicating = true

	local v1 = cursor.from(p2)

	check_packet_type(v1, t2.updates)

	local world = p1.world
	local components = p1.components
	local v2 = cursor.read_vlq(v1)
	local v3 = if p3 then #p3 + 1 else p3
	local changed = p1.network_hooks.changed
	local removed = p1.network_hooks.removed
	local deleted = p1.network_hooks.deleted
	local t3 = {}

	p1.command_buffers = t3

	local t4 = {}

	for i = 1, v2 do
		local v4 = p3 and p3[v3 - i]
		local v5 = cursor.readu8(v1)
		local v6 = if utils.checkbit(v5, 0) then cursor.read_vlq(v1) else 0

		for j = 1, v6 do
			t.process_entity_id(p1, v1, t4, function(p12) --[[ Line: 1162 | Upvalues: t (ref), p1 (copy), v1 (copy), t4 (copy), v4 (copy) ]]
				t.process_entity(p1, p12, v1, t4, v4)
			end)
		end

		local v7 = if utils.checkbit(v5, 1) then cursor.read_vlq(v1) else 0

		for k = 1, v7 do
			t.process_entity_id(p1, v1, t4, function(p12) --[[ Line: 1169 | Upvalues: cursor (ref), v1 (copy), utils (ref), t (ref), p1 (copy), changed (copy), pair (ref), components (copy), v4 (copy), t4 (copy) ]]
				local v12 = cursor.readu8(v1)

				for i = 1, if utils.checkbit(v12, 0) then cursor.read_vlq(v1) else 0 do
					local v5 = t.read_component_id(p1, v1)

					t.entity_add(p1, p12, v5, changed[pair(components.reliable, v5)])
				end

				for j = 1, if utils.checkbit(v12, 1) then cursor.read_vlq(v1) else 0 do
					local v10 = t.read_component_id(p1, v1)
					local v11 = t.read_component_value(p1, v10, v1, v4)

					t.entity_set(p1, p12, v10, v11, changed[pair(components.reliable, v10)])
				end

				for k = 1, if utils.checkbit(v12, 2) then cursor.read_vlq(v1) else 0 do
					t.process_entity_pair(p1, p12, v1, t4)
				end

				for n = 1, if utils.checkbit(v12, 3) then cursor.read_vlq(v1) else 0 do
					t.process_entity_pair_value(p1, p12, v1, t4, v4)
				end

				for m = 1, if utils.checkbit(v12, 4) then cursor.read_vlq(v1) else 0 do
					t.process_entity_relations(p1, p12, v1, t4)
				end

				for i = 1, if utils.checkbit(v12, 5) then cursor.read_vlq(v1) else 0 do
					t.process_entity_relation_values(p1, p12, v1, t4, v4)
				end
			end)
		end

		local v8 = if utils.checkbit(v5, 2) then cursor.read_vlq(v1) else 0

		for n = 1, v8 do
			t.process_entity_id(p1, v1, t4, function(p12) --[[ Line: 1211 | Upvalues: cursor (ref), v1 (copy), utils (ref), t (ref), p1 (copy), changed (copy), pair (ref), components (copy), v4 (copy), removed (copy), t4 (copy) ]]
				local v12 = cursor.readu8(v1)

				for i = 1, if utils.checkbit(v12, 0) then cursor.read_vlq(v1) else 0 do
					local v5 = t.read_component_id(p1, v1)

					t.entity_add(p1, p12, v5, changed[pair(components.reliable, v5)])
				end

				for j = 1, if utils.checkbit(v12, 1) then cursor.read_vlq(v1) else 0 do
					local v10 = t.read_component_id(p1, v1)
					local v11 = t.read_component_value(p1, v10, v1, v4)

					t.entity_set(p1, p12, v10, v11, changed[pair(components.reliable, v10)])
				end

				for k = 1, if utils.checkbit(v12, 2) then cursor.read_vlq(v1) else 0 do
					local v16 = t.read_component_id(p1, v1)

					t.entity_remove(p1, p12, v16, removed[pair(components.reliable, v16)])
				end

				for n = 1, if utils.checkbit(v12, 3) then cursor.read_vlq(v1) else 0 do
					t.process_entity_pair(p1, p12, v1, t4)
				end

				for m = 1, if utils.checkbit(v12, 4) then cursor.read_vlq(v1) else 0 do
					t.process_entity_pair_value(p1, p12, v1, t4, v4)
				end

				for i = 1, if utils.checkbit(v12, 5) then cursor.read_vlq(v1) else 0 do
					local v27 = t.read_component_id(p1, v1)

					t.process_entity_id(p1, v1, t4, function(p13) --[[ Line: 1249 | Upvalues: t (ref), p1 (ref), p12 (copy), v27 (copy) ]]
						t.entity_remove_pair(p1, p12, v27, p13)
					end)
				end

				for i = 1, if utils.checkbit(v12, 6) then cursor.read_vlq(v1) else 0 do
					local v31 = t.read_component_id(p1, v1)
					local v32 = cursor.read_vlq(v1)
					local v33 = changed[pair(components.relation, v31)]

					for i2 = 1, v32 do
						t.process_entity_id(p1, v1, t4, function(p13) --[[ Line: 1262 | Upvalues: t (ref), p1 (ref), p12 (copy), v31 (copy), v33 (copy) ]]
							t.entity_add_pair(p1, p12, v31, p13, v33)
						end)
					end
				end

				for i = 1, if utils.checkbit(v12, 7) then cursor.read_vlq(v1) else 0 do
					local v37 = t.read_component_id(p1, v1)
					local v38 = cursor.read_vlq(v1)
					local v39 = changed[pair(components.relation, v37)]

					for i2 = 1, v38 do
						local v40 = t.read_component_value(p1, v37, v1, v4)

						t.process_entity_id(p1, v1, t4, function(p13) --[[ Line: 1276 | Upvalues: t (ref), p1 (ref), p12 (copy), v37 (copy), v40 (copy), v39 (copy) ]]
							t.entity_set_pair(p1, p12, v37, p13, v40, v39)
						end)
					end
				end

				for i = 1, cursor.read_vlq(v1) do
					local v41 = t.read_component_id(p1, v1)
					local v42 = cursor.read_vlq(v1)
					local v43 = removed[pair(components.relation, v41)]

					for i2 = 1, v42 do
						t.process_entity_id(p1, v1, t4, function(p13) --[[ Line: 1291 | Upvalues: t (ref), p1 (ref), p12 (copy), v41 (copy), v43 (copy) ]]
							t.entity_remove_pair(p1, p12, v41, p13, v43)
						end)
					end
				end
			end)
		end

		local v9 = if utils.checkbit(v5, 3) then cursor.read_vlq(v1) else 0

		for m = 1, v9 do
			t.process_entity_id(p1, v1, t4, function(p12) --[[ Line: 1301 | Upvalues: cursor (ref), v1 (copy), t (ref), p1 (copy), removed (copy), pair (ref), components (copy), t4 (copy) ]]
				for i = 1, cursor.read_vlq(v1) do
					local v12 = t.read_component_id(p1, v1)

					t.entity_remove(p1, p12, v12, removed[pair(components.reliable, v12)])
				end

				for j = 1, cursor.read_vlq(v1) do
					local v3 = t.read_component_id(p1, v1)

					t.process_entity_id(p1, v1, t4, function(p13) --[[ Line: 1312 | Upvalues: t (ref), p1 (ref), p12 (copy), v3 (copy) ]]
						t.entity_remove_pair(p1, p12, v3, p13)
					end)
				end

				for k = 1, cursor.read_vlq(v1) do
					local v4 = t.read_component_id(p1, v1)

					t.entity_clear_relation(p1, p12, v4, removed[pair(components.relation, v4)])
				end
			end)
		end

		local v10 = if utils.checkbit(v5, 4) then cursor.read_vlq(v1) else 0

		for i2 = 1, v10 do
			local v11, v12 = t.read_entity_id(p1, v1)

			if v11 then
				local v13 = deleted[v11]

				if v13 then
					for v14, v15 in v13.callbacks do
						v15(v11)
					end

					if not v13.overrides then
						world_delete(world, v11)
					end
				else
					world_delete(world, v11)
				end
			end

			if v12 then
				p1.server_ids[v12] = nil
			end
		end
	end

	t.finish_custom_ids(p1, t4, t3)
	t.finish_replication(p1)
end
function t.apply_unreliable(p1, p2, p3) --[[ apply_unreliable | Line: 1353 | Upvalues: t (copy), cursor (copy), check_packet_type (copy), t2 (copy), pair (copy) ]]
	t.resolve_dirty(p1)
	p1.is_replicating = true

	local v1 = cursor.from(p2)

	check_packet_type(v1, t2.unreliable)

	local components = p1.components
	local v2 = cursor.read_vlq(v1)
	local v3 = if p3 then #p3 + 1 else p3
	local changed = p1.network_hooks.changed

	for i = 1, v2 do
		local v4 = cursor.read_vlq(v1)
		local v5 = if p3 then p3[v3 - i] else p3

		for j = 1, v4 do
			local v6 = t.read_entity_id(p1, v1)
			local v7 = cursor.read_vlq(v1)

			if v6 then
				for k = 1, v7 do
					local v8 = t.read_component_id(p1, v1)
					local v9 = t.read_component_value(p1, v8, v1, v5)

					t.entity_set_unreliable(p1, v6, v8, v9, changed[pair(components.unreliable, v8)])
				end

				continue
			end

			for n = 1, v7 do
				t.read_component_value(p1, t.read_component_id(p1, v1), v1, v5)
			end
		end
	end

	t.finish_replication(p1)
end
function t.set_serdes(p1, p2, p3) --[[ set_serdes | Line: 1395 ]]
	p1.component_serdes[p2] = p3
	p1.is_shared_dirty = true
end
function t.remove_serdes(p1, p2) --[[ remove_serdes | Line: 1400 ]]
	p1.component_serdes[p2] = nil
	p1.is_shared_dirty = true
end
function t.init(p1, p2) --[[ init | Line: 1407 | Upvalues: utils (copy), common (copy), hook_removed (copy), hook_added (copy), t (copy), hook_changed (copy) ]]
	if p1.inited == true then
		return warn("attempted to init a client twice")
	end

	if p1.inited == nil then
		return warn("attempted to re-init a destroyed client")
	end

	p1.inited = true

	local v1 = p2 or p1.world

	p1.world = v1

	if not v1 then
		error("Providing a world is required to start replecs")
	end

	if not p1.components then
		p1.components = utils.create_components(utils.tag_factory(v1), utils.component_factory(v1))
		utils.add_component_names(p1.components, function(p1, p2) --[[ Line: 1425 | Upvalues: common (ref), v1 (copy) ]]
			common.add_name(v1, p1, p2)
		end)
	end

	local components = p1.components

	local function hook(p12) --[[ hook | Line: 1432 | Upvalues: p1 (copy) ]]
		table.insert(p1.hooked, p12)
	end

	local v2 = hook_removed(v1, components.__alive_tracking__, function(p12) --[[ Line: 1436 | Upvalues: p1 (copy) ]]
		local v1 = p1.client_ids[p12]

		if v1 then
			p1.server_ids[v1] = nil
			p1.client_ids[p12] = nil
		end

		p1.network_hooks.deleted[p12] = nil
	end)

	table.insert(p1.hooked, v2)

	local v3 = hook_added(v1, components.serdes, function(p12, p2, p3) --[[ Line: 1445 | Upvalues: t (ref), p1 (copy) ]]
		t.set_serdes(p1, p12, p3)
	end)

	table.insert(p1.hooked, v3)

	local v4 = hook_changed(v1, components.serdes, function(p12, p2, p3) --[[ Line: 1448 | Upvalues: t (ref), p1 (copy) ]]
		t.set_serdes(p1, p12, p3)
	end)

	table.insert(p1.hooked, v4)

	local v5 = hook_removed(v1, components.serdes, function(p12) --[[ Line: 1451 | Upvalues: t (ref), p1 (copy) ]]
		t.remove_serdes(p1, p12)
	end)

	table.insert(p1.hooked, v5)

	for v6, v7 in p1.requires_shared_lookup do
		local v8 = hook_added(v1, v7, function() --[[ Line: 1456 | Upvalues: p1 (copy) ]]
			p1.is_shared_dirty = true
		end)

		table.insert(p1.hooked, v8)

		local v9 = hook_removed(v1, v7, function() --[[ Line: 1459 | Upvalues: p1 (copy) ]]
			p1.is_shared_dirty = true
		end)

		table.insert(p1.hooked, v9)
	end

	for v10, v11 in p1.world:query(p1.components.serdes):iter() do
		p1.component_serdes[v10] = v11
	end

	p1.shared = utils.resolved_shared(v1, components, p1.registered_custom_ids, p1.component_serdes)
end
function t.after_replication(p1, p2) --[[ after_replication | Line: 1469 ]]
	if p1.is_replicating then
		table.insert(p1.after_replication_callbacks, p2)
	else
		p2()
	end
end
function t.added(p1, p2) --[[ added | Line: 1477 ]]
	table.insert(p1.addition_hooks, p2)

	return function() --[[ Line: 1479 | Upvalues: p1 (copy), p2 (copy) ]]
		local v1 = table.find(p1.addition_hooks, p2)

		if not v1 then
			return
		end

		table.remove(p1.addition_hooks, v1)
	end
end

local function add_hook_entry(p1, p2, ...) --[[ add_hook_entry | Line: 1487 ]]
	if p2 == "changed" or p2 == "removed" then
		local v1 = select(1, ...)
		local v2 = select(2, ...)
		local v3 = p2 == "changed" and p1.network_hooks.changed or p1.network_hooks.removed
		local v4 = v3[v1]

		if not v4 then
			v4 = {
				overrides = false,
				callbacks = {}
			}
			v3[v1] = v4
		end

		local callbacks = v4.callbacks

		table.insert(callbacks, v2)

		return v4, function() --[[ disconnect | Line: 1503 | Upvalues: v4 (ref), v2 (copy), v3 (copy), v1 (copy) ]]
			local callbacks = v4.callbacks
			local v12 = table.find(callbacks, v2)

			if not v12 then
				return
			end

			table.remove(callbacks, v12)

			if #callbacks ~= 0 then
				return
			end

			v3[v1] = nil
		end
	end

	if p2 ~= "deleted" then
		error("invalid hook action: " .. p2)
	end

	local v5 = select(1, ...)
	local v6 = select(2, ...)
	local deleted = p1.network_hooks.deleted
	local v7 = deleted[v5]

	if not v7 then
		v7 = {
			overrides = false,
			callbacks = {}
		}
		deleted[v5] = v7
	end

	local callbacks = v7.callbacks

	table.insert(callbacks, v6)

	return v7, function() --[[ disconnect | Line: 1529 | Upvalues: v7 (ref), v6 (copy), deleted (copy), v5 (copy) ]]
		local callbacks = v7.callbacks
		local v1 = table.find(callbacks, v6)

		if not v1 then
			return
		end

		table.remove(callbacks, v1)

		if #callbacks ~= 0 then
			return
		end

		deleted[v5] = nil
	end
end

function t.hook(p1, p2, ...) --[[ hook | Line: 1545 | Upvalues: add_hook_entry (copy) ]]
	local v1, v2 = add_hook_entry(p1, p2, ...)

	v1.overrides = false

	return v2
end
function t.override(p1, p2, ...) --[[ override | Line: 1550 | Upvalues: add_hook_entry (copy) ]]
	local v1, v2 = add_hook_entry(p1, p2, ...)

	v1.overrides = true

	return v2
end
function t.encode_component(p1, p2) --[[ encode_component | Line: 1556 | Upvalues: t (copy), common (copy) ]]
	t.resolve_dirty(p1)

	local v1 = p1.shared.components.members[p2]

	if v1 then
		return v1
	end

	common.log_error("attempted to encode a non-shared component ", common.log_component(p1.world, p2))

	return 0
end
function t.decode_component(p1, p2) --[[ decode_component | Line: 1566 | Upvalues: t (copy) ]]
	t.resolve_dirty(p1)

	local v1 = p1.shared.components.indexes[p2]

	if v1 then
		return v1
	end

	print("NON SHARED COMPONENT", p2, p1.shared.components)
	error("attemped to decode a non shared component")
end
function t.get_shared_count(p1) --[[ get_shared_count | Line: 1576 | Upvalues: t (copy) ]]
	t.resolve_dirty(p1)

	return #p1.shared.components.keys
end
function t.get_server_entity(p1, p2) --[[ get_server_entity | Line: 1581 ]]
	return p1.client_ids[p2]
end
function t.get_client_entity(p1, p2) --[[ get_client_entity | Line: 1585 ]]
	return p1.server_ids[p2]
end
function t.register_entity(p1, p2, p3) --[[ register_entity | Line: 1589 | Upvalues: world_add (copy) ]]
	p1.server_ids[p3] = p2
	p1.client_ids[p2] = p3
	world_add(p1.world, p2, p1.components.__alive_tracking__)
end
function t.unregister_entity(p1, p2) --[[ unregister_entity | Line: 1595 ]]
	local v1 = p1.client_ids[p2]

	if not v1 then
		return
	end

	p1.server_ids[v1] = nil
	p1.client_ids[p2] = nil
end
function t.register_custom_id(p1, p2) --[[ register_custom_id | Line: 1603 ]]
	p1.registered_custom_ids[p2] = true
	p1.is_shared_dirty = true
end
function t.generate_handshake(p1) --[[ generate_handshake | Line: 1608 | Upvalues: t (copy), utils (copy) ]]
	t.resolve_dirty(p1)

	return utils.generate_handshake(p1.shared)
end
function t.verify_handshake(p1, p2) --[[ verify_handshake | Line: 1613 | Upvalues: t (copy), utils (copy) ]]
	t.resolve_dirty(p1)

	return utils.verify_handshake(p1.shared, p2, "server", "client")
end
function t.destroy(p1) --[[ destroy | Line: 1618 ]]
	if p1.inited == nil then
		return warn("attempted to destroy a client twice")
	end

	p1.inited = nil

	for v1, v2 in p1.hooked do
		v2()
	end
end
function t.handle_global(p1, p2) --[[ handle_global | Line: 1628 ]]
	p1.global_handler = p2
end

return {
	create = function(p1, p2) --[[ create | Line: 1632 | Upvalues: utils (copy), common (copy), ecs_name (copy), t (copy) ]]
		local t2 = {}

		if p2 then
			t2.components = p2
		elseif p1 then
			t2.components = utils.create_components(utils.tag_factory(p1), utils.component_factory(p1))
			utils.add_component_names(t2.components, function(p12, p2) --[[ Line: 1639 | Upvalues: common (ref), p1 (copy) ]]
				common.add_name(p1, p12, p2)
			end)
		end

		t2.server_ids = {}
		t2.client_ids = {}
		t2.is_shared_dirty = false
		t2.component_serdes = {}
		t2.requires_shared_lookup = { t2.components.shared, ecs_name }
		t2.global_handler = nil
		t2.world = p1
		t2.inited = false
		t2.is_replicating = false
		t2.hooked = {}
		t2.registered_custom_ids = {}
		t2.addition_hooks = {}
		t2.network_hooks = {
			deleted = {},
			changed = {},
			removed = {}
		}
		t2.after_replication_callbacks = {}

		return setmetatable(t2, t)
	end,
	client_replicator = t
}