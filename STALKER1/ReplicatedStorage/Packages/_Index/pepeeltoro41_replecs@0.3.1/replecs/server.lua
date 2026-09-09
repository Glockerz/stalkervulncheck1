-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local utils = require(script.Parent:WaitForChild("utils"))
local common = require(script.Parent:WaitForChild("common"))

require(script.Parent:WaitForChild("types"))
require(script.Parent:WaitForChild("customid"))

local masking = require(script.Parent:WaitForChild("masking"))
local cursor = utils.cursor
local t = {}

t.__index = t

local v1 = newproxy()
local t2 = {
	tag = 1,
	component = 2,
	pair_tag = 3,
	pair_component = 4,
	relation = 5,
	relation_component = 6,
	unreliable = 7,
	unreliable_pair = 8
}
local relationships = common.relationships
local wildcard = common.wildcard
local ecs_name = common.ecs_name
local is_pair = common.is_pair
local pair = common.pair
local pair_first = common.pair_first
local pair_second = common.pair_second
local world_add = common.world_add
local world_has = common.world_has
local world_get = common.world_get
local world_target = common.world_target
local is_component = common.is_component
local listen_relation = common.listen_relation
local hook_added = common.hook_added
local hook_changed = common.hook_changed
local hook_removed = common.hook_removed

local function HOOK_PAIR_ADDED(p1, p2, p3) --[[ HOOK_PAIR_ADDED | Line: 177 | Upvalues: pair_first (copy), hook_added (copy) ]]
	return hook_added(p1, pair_first(p1, p2), function(p13, p23, p3) --[[ Line: 180 | Upvalues: p2 (copy), p3 (copy) ]]
		if p23 == p2 then
			p3(p13, p23, p3)
		end
	end)
end

local function HOOK_PAIR_CHANGED(p1, p2, p3) --[[ HOOK_PAIR_CHANGED | Line: 188 | Upvalues: pair_first (copy), hook_changed (copy) ]]
	return hook_changed(p1, pair_first(p1, p2), function(p13, p23, p3) --[[ Line: 191 | Upvalues: p2 (copy), p3 (copy) ]]
		if p23 == p2 then
			p3(p13, p23, p3)
		end
	end)
end

local function HOOK_PAIR_REMOVED(p1, p2, p3) --[[ HOOK_PAIR_REMOVED | Line: 199 | Upvalues: pair_first (copy), hook_removed (copy) ]]
	return hook_removed(p1, pair_first(p1, p2), function(p13, p23) --[[ Line: 202 | Upvalues: p2 (copy), p3 (copy) ]]
		if p23 == p2 then
			p3(p13, p23)
		end
	end)
end

local function QUERY_TRACKING_TYPE(p1, p2) --[[ QUERY_TRACKING_TYPE | Line: 210 | Upvalues: pair (copy), wildcard (copy), world_target (copy), world_get (copy) ]]
	local world = p1.world

	for v1 in world:query(pair(p2, wildcard)):iter() do
		local count = 0

		while true do
			local v2 = world_target(world, v1, p2, count)

			if not v2 then
				break
			end

			p1.set_reliable(p1, v1, v2, world_get(world, v1, pair(p2, v2)))
			count = count + 1
		end
	end
end

local function QUERY_CURRENT_NETWORKED(p1) --[[ QUERY_CURRENT_NETWORKED | Line: 225 | Upvalues: relationships (copy), QUERY_TRACKING_TYPE (copy) ]]
	for v1, v2 in p1.world:query(p1.components.networked):iter() do
		p1.set_networked(p1, v1, v2)
	end

	if not relationships then
		return
	end

	QUERY_TRACKING_TYPE(p1, p1.components.reliable)
	QUERY_TRACKING_TYPE(p1, p1.components.unreliable)
	QUERY_TRACKING_TYPE(p1, p1.components.relation)
end

local function QUERY_CURRENT_COMPONENTS(p1) --[[ QUERY_CURRENT_COMPONENTS | Line: 237 ]]
	for v1, v2 in p1.world:query(p1.components.serdes):iter() do
		p1.component_serdes[v1] = v2
	end

	for v3, v4 in p1.world:query(p1.components.global):iter() do
		p1.global_ids[v3] = v4
	end
end

local function track_entity_lifetime(p1, p2) --[[ track_entity_lifetime | Line: 246 | Upvalues: world_add (copy) ]]
	if not p1.alive_tracked[p2] then
		p1.alive_tracked[p2] = true
		world_add(p1.world, p2, p1.components.__alive_tracking__)
	end
end

local function get_or_set_entity_storage(p1, p2) --[[ get_or_set_entity_storage | Line: 254 ]]
	local v1 = p1.storage[p2]

	if not v1 then
		local t = {
			tags = {},
			components = {},
			pair_tags = {},
			pair_components = {},
			relations = {},
			relation_values = {}
		}

		p1.storage[p2] = t
		v1 = t
	end

	return v1
end

local function allocate_component_change(p1, p2, p3, p4) --[[ allocate_component_change | Line: 272 | Upvalues: get_or_set_entity_storage (copy), v1 (copy) ]]
	local v2 = if p4 == nil then v1 else p4

	get_or_set_entity_storage(p1, p2).components[p3] = v2

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_component_change(p2, p3, v2)
end

local function allocate_unreliable_addition(p1, p2, p3) --[[ allocate_unreliable_addition | Line: 283 ]]
	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_unreliable_addition(p2, p3)
end

local function allocate_tag_addition(p1, p2, p3) --[[ allocate_tag_addition | Line: 290 | Upvalues: get_or_set_entity_storage (copy) ]]
	get_or_set_entity_storage(p1, p2).tags[p3] = true

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_tag_addition(p2, p3)
end

local function allocate_pair_tag_addition(p1, p2, p3) --[[ allocate_pair_tag_addition | Line: 299 | Upvalues: get_or_set_entity_storage (copy) ]]
	get_or_set_entity_storage(p1, p2).pair_tags[p3] = true

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_pair_tag_addition(p2, p3)
end

local function allocate_pair_component_change(p1, p2, p3, p4) --[[ allocate_pair_component_change | Line: 308 | Upvalues: get_or_set_entity_storage (copy), v1 (copy) ]]
	local v2 = if p4 == nil then v1 else p4

	get_or_set_entity_storage(p1, p2).pair_components[p3] = v2

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_pair_component_change(p2, p3, v2)
end

local function allocate_relation_component_change(p1, p2, p3, p4, p5) --[[ allocate_relation_component_change | Line: 319 | Upvalues: get_or_set_entity_storage (copy), v1 (copy) ]]
	local v12 = get_or_set_entity_storage(p1, p2)
	local v2 = v12.relation_values[p3]

	if v2 == nil then
		v2 = {}
		v12.relation_values[p3] = v2
	end

	local v3 = if p5 == nil then v1 else p5

	v2[p4] = v3

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_relation_component_change(p2, p3, p4, v3)
end

local function allocate_relation_tag_addition(p1, p2, p3, p4) --[[ allocate_relation_tag_addition | Line: 342 | Upvalues: get_or_set_entity_storage (copy) ]]
	local v1 = get_or_set_entity_storage(p1, p2)
	local v2 = v1.relations[p3]

	if v2 == nil then
		v2 = {}
		v1.relations[p3] = v2
	end

	v2[p4] = true

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_relation_tag_addition(p2, p3, p4)
end

local function allocate_component_removal(p1, p2, p3) --[[ allocate_component_removal | Line: 356 | Upvalues: get_or_set_entity_storage (copy) ]]
	get_or_set_entity_storage(p1, p2).components[p3] = nil

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_component_removal(p2, p3)
end

local function allocate_unreliable_removal(p1, p2, p3) --[[ allocate_unreliable_removal | Line: 365 ]]
	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_unreliable_removal(p2, p3)
end

local function allocate_tag_removal(p1, p2, p3) --[[ allocate_tag_removal | Line: 371 | Upvalues: get_or_set_entity_storage (copy) ]]
	get_or_set_entity_storage(p1, p2).tags[p3] = nil

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_tag_removal(p2, p3)
end

local function allocate_pair_tag_removal(p1, p2, p3) --[[ allocate_pair_tag_removal | Line: 380 | Upvalues: get_or_set_entity_storage (copy) ]]
	get_or_set_entity_storage(p1, p2).pair_tags[p3] = nil

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_pair_tag_removal(p2, p3)
end

local function allocate_pair_component_removal(p1, p2, p3) --[[ allocate_pair_component_removal | Line: 389 | Upvalues: get_or_set_entity_storage (copy) ]]
	get_or_set_entity_storage(p1, p2).pair_components[p3] = nil

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_pair_component_removal(p2, p3)
end

local function allocate_relation_component_removal(p1, p2, p3, p4) --[[ allocate_relation_component_removal | Line: 398 | Upvalues: get_or_set_entity_storage (copy) ]]
	local v1 = get_or_set_entity_storage(p1, p2).relation_values[p3]

	if v1 then
		v1[p4] = nil
	end

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_relation_component_removal(p2, p3, p4)
end

local function allocate_relation_tag_removal(p1, p2, p3, p4) --[[ allocate_relation_tag_removal | Line: 410 | Upvalues: get_or_set_entity_storage (copy) ]]
	local v1 = get_or_set_entity_storage(p1, p2).relations[p3]

	if v1 then
		v1[p4] = nil
	end

	if p1.additions[p2] or not p1.track_info.networked[p2] then
		return
	end

	p1.masking:allocate_relation_tag_removal(p2, p3, p4)
end

local function cleanup_entity(p1, p2) --[[ cleanup_entity | Line: 422 ]]
	p1.alive_tracked[p2] = nil
	p1.storage[p2] = nil
	p1.global_ids[p2] = nil
	p1.custom_ids[p2] = nil
	p1.additions[p2] = nil
	p1.masking:cleanup_entity(p2)

	local v1 = p1.track_info.entities[p2]

	if not v1 then
		return
	end

	for v2 in v1.components do
		local v3 = p1.track_info.components[v2]

		if v3 then
			v3[p2] = nil
		end
	end

	for v4 in v1.pairs do
		local v5 = p1.track_info.pairs[v4]

		if v5 then
			v5[p2] = nil
		end
	end

	p1.track_info.entities[p2] = nil
end

local function hook_pair(p1, p2) --[[ hook_pair | Line: 448 | Upvalues: common (copy), pair_second (copy), get_or_set_entity_storage (copy), v1 (copy), pair_first (copy), hook_added (copy), hook_changed (copy), hook_removed (copy) ]]
	local world = p1.world

	if p1.track_info.pairs[p2] then
		error((("attemped to track a pair twice: %*"):format((common.log_component(p1.world, pair_second(world, p2))))))
	end

	local t = {}

	p1.track_info.pairs[p2] = t

	local function hook(p12) --[[ hook | Line: 458 | Upvalues: p1 (copy) ]]
		table.insert(p1.hooked, p12)
	end

	local function f1(p12, p2, p3) --[[ Line: 462 | Upvalues: t (copy), p1 (copy), get_or_set_entity_storage (ref), v1 (ref) ]]
		local v12 = t[p12]

		if not v12 then
			return
		end

		if v12 == 4 then
			local v2 = p1
			local v4 = if p3 == nil then v1 else p3

			get_or_set_entity_storage(v2, p12).pair_components[p2] = v4

			if not v2.additions[p12] and v2.track_info.networked[p12] then
				v2.masking:allocate_pair_component_change(p12, p2, v4)
			end
		else
			local v5 = p1

			get_or_set_entity_storage(v5, p12).pair_tags[p2] = true

			if v5.additions[p12] or not v5.track_info.networked[p12] then
				return
			end

			v5.masking:allocate_pair_tag_addition(p12, p2)
		end
	end

	local v2 = hook_added(world, pair_first(world, p2), function(p13, p23, p3) --[[ Line: 180 | Upvalues: p2 (copy), f1 (copy) ]]
		if p23 == p2 then
			f1(p13, p23, p3)
		end
	end)

	table.insert(p1.hooked, v2)

	local function f3(p12, p2, p3) --[[ Line: 474 | Upvalues: t (copy), p1 (copy), get_or_set_entity_storage (ref), v1 (ref) ]]
		if not t[p12] then
			return
		end

		local v12 = p1
		local v3 = if p3 == nil then v1 else p3

		get_or_set_entity_storage(v12, p12).pair_components[p2] = v3

		if v12.additions[p12] or not v12.track_info.networked[p12] then
			return
		end

		v12.masking:allocate_pair_component_change(p12, p2, v3)
	end

	local v4 = hook_changed(world, pair_first(world, p2), function(p13, p23, p3) --[[ Line: 191 | Upvalues: p2 (copy), f3 (copy) ]]
		if p23 == p2 then
			f3(p13, p23, p3)
		end
	end)

	table.insert(p1.hooked, v4)

	local function f5(p12, p2) --[[ Line: 482 | Upvalues: t (copy), p1 (copy), get_or_set_entity_storage (ref) ]]
		local v1 = t[p12]

		if not v1 then
			return
		end

		if v1 == 4 then
			local v2 = p1

			get_or_set_entity_storage(v2, p12).pair_components[p2] = nil

			if not v2.additions[p12] and v2.track_info.networked[p12] then
				v2.masking:allocate_pair_component_removal(p12, p2)
			end
		else
			local v3 = p1

			get_or_set_entity_storage(v3, p12).pair_tags[p2] = nil

			if v3.additions[p12] or not v3.track_info.networked[p12] then
				return
			end

			v3.masking:allocate_pair_tag_removal(p12, p2)
		end
	end

	local v6 = hook_removed(world, pair_first(world, p2), function(p13, p23) --[[ Line: 202 | Upvalues: p2 (copy), f5 (copy) ]]
		if p23 == p2 then
			f5(p13, p23)
		end
	end)

	table.insert(p1.hooked, v6)

	return t
end

local function hook_component(p1, p2) --[[ hook_component | Line: 498 | Upvalues: common (copy), hook_added (copy), get_or_set_entity_storage (copy), v1 (copy), is_pair (copy), allocate_relation_tag_addition (copy), pair_second (copy), allocate_relation_component_change (copy), hook_changed (copy), hook_removed (copy) ]]
	local world = p1.world

	if p1.track_info.components[p2] then
		error((("attemped to track a component twice: %*"):format((common.log_component(p1.world, p2)))))
	end

	local t = {}

	p1.track_info.components[p2] = t

	local function hook(p12) --[[ hook | Line: 508 | Upvalues: p1 (copy) ]]
		table.insert(p1.hooked, p12)
	end

	local v12 = hook_added(world, p2, function(p12, p22, p3) --[[ Line: 512 | Upvalues: t (copy), p1 (copy), p2 (copy), get_or_set_entity_storage (ref), v1 (ref), is_pair (ref), allocate_relation_tag_addition (ref), pair_second (ref), world (copy), allocate_relation_component_change (ref) ]]
		local v12 = t[p12]

		if not v12 then
			return
		end

		if v12 == 2 then
			local v2 = p1
			local v3 = p2
			local v5 = if p3 == nil then v1 else p3

			get_or_set_entity_storage(v2, p12).components[v3] = v5

			if not v2.additions[p12] and v2.track_info.networked[p12] then
				v2.masking:allocate_component_change(p12, v3, v5)
			end
		elseif v12 == 1 then
			local v6 = p1
			local v7 = p2

			get_or_set_entity_storage(v6, p12).tags[v7] = true

			if not v6.additions[p12] and v6.track_info.networked[p12] then
				v6.masking:allocate_tag_addition(p12, v7)
			end
		else
			if v12 == 5 then
				if is_pair(p22) then
					allocate_relation_tag_addition(p1, p12, p2, pair_second(world, p22))
				end

				return
			end

			if v12 == 6 then
				if is_pair(p22) then
					allocate_relation_component_change(p1, p12, p2, pair_second(world, p22), p3)
				end

				return
			end

			if v12 ~= 7 then
				return
			end

			local v8 = p1

			if v8.additions[p12] or not v8.track_info.networked[p12] then
				return
			end

			v8.masking:allocate_unreliable_addition(p12, p2)
		end
	end)

	table.insert(p1.hooked, v12)

	local v2 = hook_changed(world, p2, function(p12, p22, p3) --[[ Line: 536 | Upvalues: t (copy), p1 (copy), p2 (copy), get_or_set_entity_storage (ref), v1 (ref), is_pair (ref), allocate_relation_component_change (ref), pair_second (ref), world (copy) ]]
		local v12 = t[p12]

		if not v12 then
			return
		end

		if v12 == 2 then
			local v2 = p1
			local v3 = p2
			local v5 = if p3 == nil then v1 else p3

			get_or_set_entity_storage(v2, p12).components[v3] = v5

			if not v2.additions[p12] and v2.track_info.networked[p12] then
				v2.masking:allocate_component_change(p12, v3, v5)
			end
		else
			if v12 ~= 6 then
				return
			end

			if not is_pair(p22) then
				return
			end

			allocate_relation_component_change(p1, p12, p2, pair_second(world, p22), p3)
		end
	end)

	table.insert(p1.hooked, v2)

	local v3 = hook_removed(world, p2, function(p12, p22) --[[ Line: 550 | Upvalues: t (copy), p1 (copy), p2 (copy), get_or_set_entity_storage (ref), is_pair (ref), pair_second (ref), world (copy) ]]
		local v1 = t[p12]

		if not v1 then
			return
		end

		if v1 == 2 then
			local v2 = p1
			local v3 = p2

			get_or_set_entity_storage(v2, p12).components[v3] = nil

			if not v2.additions[p12] and v2.track_info.networked[p12] then
				v2.masking:allocate_component_removal(p12, v3)
			end
		elseif v1 == 1 then
			local v4 = p1
			local v5 = p2

			get_or_set_entity_storage(v4, p12).tags[v5] = nil

			if not v4.additions[p12] and v4.track_info.networked[p12] then
				v4.masking:allocate_tag_removal(p12, v5)
			end
		elseif v1 == 5 then
			if not is_pair(p22) then
				return
			end

			local v6 = p1
			local v7 = p2
			local v8 = pair_second(world, p22)
			local v9 = get_or_set_entity_storage(v6, p12).relations[v7]

			if v9 then
				v9[v8] = nil
			end

			if not v6.additions[p12] and v6.track_info.networked[p12] then
				v6.masking:allocate_relation_tag_removal(p12, v7, v8)
			end
		elseif v1 == 6 then
			if not is_pair(p22) then
				return
			end

			local v10 = p1
			local v11 = p2
			local v12 = pair_second(world, p22)
			local v13 = get_or_set_entity_storage(v10, p12).relation_values[v11]

			if v13 then
				v13[v12] = nil
			end

			if not v10.additions[p12] and v10.track_info.networked[p12] then
				v10.masking:allocate_relation_component_removal(p12, v11, v12)
			end
		else
			if v1 ~= 7 then
				return
			end

			local v14 = p1

			if v14.additions[p12] or not v14.track_info.networked[p12] then
				return
			end

			v14.masking:allocate_unreliable_removal(p12, p2)
		end
	end)

	table.insert(p1.hooked, v3)

	return t
end

local function add_entity_component_tracked(p1, p2, p3, p4) --[[ add_entity_component_tracked | Line: 578 ]]
	local v1 = p1.track_info.entities[p2]

	if v1 == nil then
		p1.track_info.entities[p2] = {
			components = {
				[p3] = p4
			},
			pairs = {}
		}
	else
		v1.components[p3] = p4
	end
end

local function add_entity_pair_tracked(p1, p2, p3, p4) --[[ add_entity_pair_tracked | Line: 591 ]]
	local v1 = p1.track_info.entities[p2]

	if v1 == nil then
		p1.track_info.entities[p2] = {
			components = {},
			pairs = {
				[p3] = p4
			}
		}
	else
		v1.pairs[p3] = p4
	end
end

local function remove_entity_component_tracked(p1, p2, p3) --[[ remove_entity_component_tracked | Line: 604 ]]
	local v1 = p1.track_info.entities[p2]

	if not v1 then
		return
	end

	v1.components[p3] = nil
end

local function remove_entity_pair_tracked(p1, p2, p3) --[[ remove_entity_pair_tracked | Line: 611 ]]
	local v1 = p1.track_info.entities[p2]

	if not v1 then
		return
	end

	v1.pairs[p3] = nil
end

local function track_entity_unreliable(p1, p2, p3) --[[ track_entity_unreliable | Line: 618 | Upvalues: hook_component (copy), add_entity_component_tracked (copy) ]]
	local v1 = p1.track_info.components[p3]

	if not v1 then
		v1 = hook_component(p1, p3)
	end

	v1[p2] = 7
	add_entity_component_tracked(p1, p2, p3, 7)
end

local function track_entity_component(p1, p2, p3) --[[ track_entity_component | Line: 628 | Upvalues: hook_component (copy), get_or_set_entity_storage (copy), is_component (copy), world_has (copy), world_get (copy), v1 (copy), add_entity_component_tracked (copy) ]]
	local world = p1.world
	local v12 = p1.track_info.components[p3]

	if not v12 then
		v12 = hook_component(p1, p3)
	end

	local v3 = get_or_set_entity_storage(p1, p2)

	if is_component(world, p3) then
		if world_has(world, p2, p3) then
			local v4 = world_get(world, p2, p3)

			if v4 == nil then
				v3.components[p3] = v1
			else
				v3.components[p3] = v4
			end
		end

		v12[p2] = 2
		add_entity_component_tracked(p1, p2, p3, 2)

		return 2
	end

	if world_has(world, p2, p3) then
		v3.tags[p3] = true
	end

	v12[p2] = 1
	add_entity_component_tracked(p1, p2, p3, 1)

	return 1
end

local function track_entity_pair(p1, p2, p3) --[[ track_entity_pair | Line: 664 | Upvalues: hook_pair (copy), get_or_set_entity_storage (copy), is_component (copy), world_has (copy), world_get (copy), v1 (copy), add_entity_pair_tracked (copy) ]]
	local world = p1.world
	local v12 = p1.track_info.pairs[p3]

	if not v12 then
		v12 = hook_pair(p1, p3)
	end

	local v3 = get_or_set_entity_storage(p1, p2)

	if is_component(world, p3) then
		if world_has(world, p2, p3) then
			local v4 = world_get(world, p2, p3)

			if v4 == nil then
				v3.pair_components[p3] = v1
			else
				v3.pair_components[p3] = v4
			end
		end

		v12[p2] = 4
		add_entity_pair_tracked(p1, p2, p3, 4)

		return 4
	end

	if world_has(world, p2, p3) then
		v3.pair_tags[p3] = true
	end

	v12[p2] = 3
	add_entity_pair_tracked(p1, p2, p3, 3)

	return 3
end

local function track_entity_relation(p1, p2, p3) --[[ track_entity_relation | Line: 700 | Upvalues: hook_component (copy), get_or_set_entity_storage (copy), is_component (copy), world_target (copy), world_get (copy), pair (copy), v1 (copy), add_entity_component_tracked (copy) ]]
	local world = p1.world
	local v12 = p1.track_info.components[p3]

	if not v12 then
		v12 = hook_component(p1, p3)
	end

	local v3 = get_or_set_entity_storage(p1, p2)

	if is_component(world, p3) then
		local count = 0
		local t = {}

		while true do
			local v4 = world_target(world, p2, p3, count)

			if not v4 then
				break
			end

			count = count + 1

			local v5 = world_get(world, p2, pair(p3, v4))

			t[v4] = if v5 == nil then v1 else v5
		end

		v3.relation_values[p3] = t
		v12[p2] = 6
		add_entity_component_tracked(p1, p2, p3, 6)

		return 6
	end

	local count = 0
	local t = {}

	while true do
		local v7 = world_target(world, p2, p3, count)

		if not v7 then
			break
		end

		t[v7] = true
		count = count + 1
	end

	v3.relations[p3] = t
	v12[p2] = 5
	add_entity_component_tracked(p1, p2, p3, 5)

	return 5
end

local function untrack_entity_component(p1, p2, p3) --[[ untrack_entity_component | Line: 749 ]]
	local v1 = p1.track_info.components[p3]

	if not v1 then
		return nil
	end

	local v2 = v1[p2]

	v1[p2] = nil

	local v3 = p1.storage[p2]

	if v3 then
		v3.components[p3] = nil
		v3.tags[p3] = nil
	end

	local v4 = p1.track_info.entities[p2]

	if not v4 then
		return v2
	end

	v4.components[p3] = nil

	return v2
end

local function untrack_entity_pair(p1, p2, p3) --[[ untrack_entity_pair | Line: 767 ]]
	local v1 = p1.track_info.pairs[p3]

	if not v1 then
		return nil
	end

	local v2 = v1[p2]

	v1[p2] = nil

	local v3 = p1.storage[p2]

	if v3 then
		v3.pair_tags[p3] = nil
		v3.pair_components[p3] = nil
	end

	local v4 = p1.track_info.entities[p2]

	if not v4 then
		return v2
	end

	v4.pairs[p3] = nil

	return v2
end

local function untrack_entity_relation(p1, p2, p3) --[[ untrack_entity_relation | Line: 785 ]]
	local v1 = p1.track_info.components[p3]

	if not v1 then
		return nil
	end

	local v2 = v1[p2]

	v1[p2] = nil

	local v3 = p1.storage[p2]

	if v3 then
		v3.relations[p3] = nil
		v3.relation_values[p3] = nil
	end

	local v4 = p1.track_info.entities[p2]

	if not v4 then
		return v2
	end

	v4.components[p3] = nil

	return v2
end

local function write_vlq_bitmask(p1, p2, p3, p4) --[[ write_vlq_bitmask | Line: 803 | Upvalues: cursor (copy), utils (copy) ]]
	if p2 > 0 then
		cursor.write_vlq(p1, p2)

		return utils.setbit(p3, p4)
	end

	return p3
end

function t.write_component_id(p1, p2, p3) --[[ write_component_id | Line: 812 | Upvalues: common (copy), cursor (copy) ]]
	local components = p1.shared.components
	local v1 = components.members[p3]

	if v1 then
		cursor.write_span(p2, v1, #components.keys)
	else
		common.log_error("attempted to replicate a non-shared component ", common.log_component(p1.world, p3))
	end
end
function t.write_variant_value(p1, p2, p3, p4, p5, p6) --[[ write_variant_value | Line: 822 | Upvalues: v1 (copy), cursor (copy), common (copy) ]]
	if p4 then
		local v2, v3 = p4.serialize(if p5 == v1 then nil else p5)

		if p4.includes_variants then
			if v3 == nil then
				cursor.writeu8(p2, 128)
			else
				if #v3 > 0 then
					table.move(v3, 1, #v3, #p6 + 1, p6)
				end

				cursor.write_vlq(p2, #v3)
				cursor.write_vlq(p2, #p6 + 1)
			end
		elseif v3 ~= nil then
			common.log_error("serdes: serializer provided variants yet includes_variants is not set to true for component: ", common.log_component(p1.world, p3))
		end

		local bytespan = p4.bytespan

		cursor.write_buffer(p2, v2)

		if not bytespan then
			cursor.write_vlq(p2, (buffer.len(v2)))

			return
		end

		if bytespan ~= buffer.len(v2) then
			common.log_error(("bytespan: %* mismatch for buffer lenght: %* in component: "):format(bytespan, (buffer.len(v2))), common.log_component(p1.world, p3))
		end
	else
		if p5 == nil or p5 == v1 then
			cursor.writeu8(p2, 128)

			return
		end

		table.insert(p6, p5)
		cursor.write_vlq(p2, #p6)
	end
end
function t.write_component_value(p1, p2, p3, p4, p5) --[[ write_component_value | Line: 876 | Upvalues: t (copy) ]]
	t.write_variant_value(p1, p2, p3, p1.shared.serdes[p3], p4, p5)
end
function t.write_pair_value(p1, p2, p3, p4, p5, p6) --[[ write_pair_value | Line: 887 | Upvalues: pair (copy), wildcard (copy), t (copy) ]]
	t.write_variant_value(p1, p2, p3, p1.shared.serdes[p4] or p1.shared.serdes[pair(p3, wildcard)], p5, p6)
end
function t.write_entity_id(p1, p2, p3) --[[ write_entity_id | Line: 899 | Upvalues: cursor (copy), t (copy) ]]
	local v1 = p1.custom_ids[p3]
	local v2 = p1.global_ids[p3]

	if v2 then
		cursor.writeu8(p2, v2 + 10)

		return
	end

	if v1 then
		if type(v1) == "number" then
			t.write_component_id(p1, p2, v1)
			cursor.writeu40(p2, p3)
			cursor.writeu8(p2, 3)
		else
			cursor.writeu8(p2, p1.shared.custom_ids.members[v1])
			cursor.writeu40(p2, p3)
			cursor.writeu8(p2, 2)
		end
	else
		local v3 = p1.shared.components.members[p3]

		if v3 then
			cursor.writeu8(p2, v3)
			cursor.writeu8(p2, 4)
		else
			cursor.writeu40(p2, p3)
			cursor.writeu8(p2, 1, p3)
		end
	end
end
function t.write_entity_relations(p1, p2, p3, p4) --[[ write_entity_relations | Line: 927 | Upvalues: t (copy), cursor (copy) ]]
	local count = 0

	for v1 in p2.relations[p4] do
		t.write_entity_id(p1, p3, v1)
		count = count + 1
	end

	cursor.write_vlq(p3, count)
	t.write_component_id(p1, p3, p4)
end
function t.write_entity_relations_values(p1, p2, p3, p4, p5) --[[ write_entity_relations_values | Line: 939 | Upvalues: t (copy), cursor (copy) ]]
	local count = 0

	for v1, v2 in p2.relation_values[p4] do
		t.write_entity_id(p1, p3, v1)
		t.write_component_value(p1, p3, p4, v2, p5)
		count = count + 1
	end

	cursor.write_vlq(p3, count)
	t.write_component_id(p1, p3, p4)
end
function t.write_entity_pair_value(p1, p2, p3, p4, p5, p6) --[[ write_entity_pair_value | Line: 958 | Upvalues: pair_first (copy), pair_second (copy), t (copy), cursor (copy) ]]
	local v1 = pair_first(p2, p4)
	local v2 = pair_second(p2, p4)

	t.write_pair_value(p1, p3, v1, p4, p5, p6)
	cursor.write_vlq(p3, p3.offset - p3.offset)
	t.write_entity_id(p1, p3, v2)
	t.write_component_id(p1, p3, v1)
end
function t.write_entity_pair(p1, p2, p3, p4) --[[ write_entity_pair | Line: 980 | Upvalues: pair_first (copy), pair_second (copy), t (copy) ]]
	local v1 = pair_first(p2, p4)

	t.write_entity_id(p1, p3, (pair_second(p2, p4)))
	t.write_component_id(p1, p3, v1)
end
function t.write_entity(p1, p2, p3, p4, p5) --[[ write_entity | Line: 987 | Upvalues: t (copy), cursor (copy), utils (copy), world_has (copy), world_get (copy) ]]
	local world = p1.world
	local v1 = p1.storage[p3]
	local count = 0
	local v2 = 0

	for v3 in p4.components[6] do
		t.write_entity_relations_values(p1, v1, p2, v3, p5)
		count = count + 1
	end

	if count > 0 then
		cursor.write_vlq(p2, count)
		v2 = utils.setbit(v2, 5)
	end

	local count2 = 0

	for v5 in p4.components[5] do
		t.write_entity_relations(p1, v1, p2, v5)
		count2 = count2 + 1
	end

	if count2 > 0 then
		cursor.write_vlq(p2, count2)
		v2 = utils.setbit(v2, 4)
	end

	local count3 = 0

	for v7 in p4.components[4] do
		local v8 = v1.pair_components[v7]

		if v8 ~= nil then
			t.write_entity_pair_value(p1, world, p2, v7, v8, p5)
			count3 = count3 + 1
		end
	end

	if count3 > 0 then
		cursor.write_vlq(p2, count3)
		v2 = utils.setbit(v2, 3)
	end

	local count4 = 0

	for v10 in p4.components[3] do
		if v1.pair_tags[v10] then
			t.write_entity_pair(p1, world, p2, v10)
			count4 = count4 + 1
		end
	end

	if count4 > 0 then
		cursor.write_vlq(p2, count4)
		v2 = utils.setbit(v2, 2)
	end

	local count5 = 0

	for v12 in p4.components[2] do
		local v13 = v1.components[v12]

		if v13 ~= nil then
			t.write_component_value(p1, p2, v12, v13, p5)
			t.write_component_id(p1, p2, v12)
			count5 = count5 + 1
		end
	end

	for v14 in p4.components[7] do
		if world_has(world, p3, v14) then
			t.write_component_value(p1, p2, v14, world_get(world, p3, v14), p5)
			t.write_component_id(p1, p2, v14)
			count5 = count5 + 1
		end
	end

	if count5 > 0 then
		cursor.write_vlq(p2, count5)
		v2 = utils.setbit(v2, 1)
	end

	local count6 = 0

	for v17 in p4.components[1] do
		if v1.tags[v17] then
			t.write_component_id(p1, p2, v17)
			count6 = count6 + 1
		end
	end

	if count6 > 0 then
		cursor.write_vlq(p2, count6)
		v2 = utils.setbit(v2, 0)
	end

	cursor.writeu8(p2, v2)
end
function t.resolve_dirty(p1) --[[ resolve_dirty | Line: 1071 | Upvalues: utils (copy) ]]
	if not p1.is_shared_dirty then
		return
	end

	p1.shared = utils.resolved_shared(p1.world, p1.components, p1.registered_custom_ids, p1.component_serdes)
	p1.is_shared_dirty = false
end

local function append_packet(p1, p2, p3, p4) --[[ append_packet | Line: 1094 | Upvalues: utils (copy) ]]
	local v1 = buffer.len(p3)

	for v2, v3 in p2 do
		if utils.is_client_valid(v3) then
			local v4 = p1[v3]

			if v4 then
				table.insert(v4.packets, {
					buffer = p3,
					variants = p4
				})
				v4.total_size = v4.total_size + v1

				continue
			end

			p1[v3] = {
				packets = {
					{
						buffer = p3,
						variants = p4
					}
				},
				total_size = v1
			}
		end
	end
end

local function combine_packet_outputs(p1, p2, p3) --[[ combine_packet_outputs | Line: 1122 | Upvalues: utils (copy), cursor (copy) ]]
	local v1 = buffer.create(p2 + utils.vlq_span(#p1) + 1)
	local v2 = table.create(#p1)
	local sum = 0

	for v3, v4 in p1 do
		buffer.copy(v1, sum, v4.buffer)
		sum = sum + buffer.len(v4.buffer)
		table.insert(v2, v4.variants)
	end

	cursor.write_vlq({
		offset = sum,
		buffer = v1
	}, #p1)
	buffer.writeu8(v1, buffer.len(v1) - 1, p3)

	return v1, v2
end

local function create_packet_iterator(p1, p2) --[[ create_packet_iterator | Line: 1143 | Upvalues: utils (copy), combine_packet_outputs (copy) ]]
	local v1 = nil

	return function() --[[ iterator | Line: 1145 | Upvalues: p1 (copy), v1 (ref), utils (ref), combine_packet_outputs (ref), p2 (copy) ]]
		local v12, v2 = next(p1, v1)

		while not utils.is_client_valid(v12) and (v12 or v2) do
			local v3, v4 = next(p1, v12)

			v12, v2 = v3, v4
		end

		if v12 then
			v1 = v12

			local v5, v6 = combine_packet_outputs(v2.packets, v2.total_size, p2)

			return v12, v5, v6
		end

		return nil
	end
end

local function create_unreliable_packet_iterator(p1) --[[ create_unreliable_packet_iterator | Line: 1164 | Upvalues: utils (copy), combine_packet_outputs (copy) ]]
	return coroutine.wrap(function() --[[ Line: 1165 | Upvalues: p1 (copy), utils (ref), combine_packet_outputs (ref) ]]
		for v1, v2 in p1 do
			if utils.is_client_valid(v1) then
				table.sort(v2.packets, function(p13, p23) --[[ Line: 1171 ]]
					return buffer.len(p13.buffer) < buffer.len(p23.buffer)
				end)

				local v3 = #v2.packets
				local count2 = 1

				while count2 <= v3 do
					local sum2 = 0
					local t3 = {}

					repeat
						if not (count2 <= v3) then
							break
						end

						local v4 = v2.packets[count2]
						local v5 = buffer.len(v4.buffer)

						if sum2 + v5 > 900 and #t3 > 0 then
							break
						end

						table.insert(t3, v4)
						sum2 = sum2 + v5
						count2 = count2 + 1
					until sum2 >= 900

					if #t3 > 0 then
						coroutine.yield(v1, combine_packet_outputs(t3, sum2, 4))
					end
				end
			end
		end
	end)
end

function t.get_full(p1, p2) --[[ get_full | Line: 1206 | Upvalues: t (copy), common (copy), cursor (copy), combine_packet_outputs (copy) ]]
	t.resolve_dirty(p1)

	local v1 = p1.masking.client_indexes[p2]

	if v1 == nil then
		common.log_error("attempted to replicate for a non registered client")
	end

	local t2 = {}
	local sum = 0

	for v2, v3 in p1.masking.storages do
		if v3.active_count ~= 0 and v3.mask.bitmask:get(v1) then
			local v4 = cursor.new()
			local t3 = {}
			local count = 0

			for v5, v6 in v3.active do
				t.write_entity(p1, v4, v5, v6, t3)
				t.write_entity_id(p1, v4, v5)
				count = count + 1
			end

			cursor.write_vlq(v4, count)

			local v7 = cursor.close(v4)

			table.insert(t2, {
				buffer = v7,
				variants = t3
			})
			sum = sum + buffer.len(v7)
		end
	end

	return combine_packet_outputs(t2, sum, 1)
end
function t.collect_entity(p1, p2) --[[ collect_entity | Line: 1246 | Upvalues: t (copy), cursor (copy), append_packet (copy), utils (copy), combine_packet_outputs (copy) ]]
	t.resolve_dirty(p1)

	local t2 = {}
	local t3 = {}
	local v1 = p1.masking.lookups.entities[p2]
	local storage_group = v1.storage_group
	local v2 = cursor.new()
	local t4 = {}

	t.write_entity(p1, v2, p2, storage_group.active[p2], t4)
	t.write_entity_id(p1, v2, p2)
	append_packet(t2, storage_group.mask.members, cursor.close(v2), t4)
	t3[storage_group] = true

	for v3, v4 in v1.filtered_components do
		for v5, v6 in v4 do
			local storage_group2 = v6.storage_group

			if not t3[storage_group2] then
				local v7 = cursor.new()
				local t5 = {}

				t.write_entity(p1, v7, p2, storage_group2.active[p2], t5)
				t.write_entity_id(p1, v7, p2)
				append_packet(t2, storage_group2.mask.members, cursor.close(v7), t5)
				t3[storage_group2] = true
			end
		end
	end

	local v8 = nil
	local v9 = 2

	return function() --[[ iterator | Line: 1145 | Upvalues: t2 (copy), v8 (ref), utils (ref), combine_packet_outputs (ref), v9 (copy) ]]
		local v12, v2 = next(t2, v8)

		while not utils.is_client_valid(v12) and (v12 or v2) do
			local v3, v4 = next(t2, v12)

			v12, v2 = v3, v4
		end

		if v12 then
			v8 = v12

			local v5, v6 = combine_packet_outputs(v2.packets, v2.total_size, v9)

			return v12, v5, v6
		end

		return nil
	end
end
function t.collect_updates(p1) --[[ collect_updates | Line: 1282 | Upvalues: t (copy), cursor (copy), utils (copy), world_get (copy), append_packet (copy), combine_packet_outputs (copy) ]]
	t.resolve_dirty(p1)

	local world = p1.world
	local t2 = {}

	for v1, v2 in p1.masking.storages do
		local v3 = cursor.new()
		local entities = v2.deletions.entities
		local count = 0
		local v4 = 0
		local t3 = {}

		for v5 in entities do
			t.write_entity_id(p1, v3, v5)
			count = count + 1
		end

		table.clear(entities)

		if count > 0 then
			cursor.write_vlq(v3, count)
			v4 = utils.setbit(v4, 4)
		end

		local components = v2.deletions.components
		local count2 = 0

		for v7, v8 in components do
			local count3 = 0

			for v9 in v8[6] do
				t.write_component_id(p1, v3, v9)
				count3 = count3 + 1
			end

			for v10 in v8[5] do
				t.write_component_id(p1, v3, v10)
				count3 = count3 + 1
			end

			cursor.write_vlq(v3, count3)

			local count4 = 0

			for v11 in v8[4] do
				t.write_entity_pair(p1, world, v3, v11)
				count4 = count4 + 1
			end

			for v12 in v8[3] do
				t.write_entity_pair(p1, world, v3, v12)
				count4 = count4 + 1
			end

			cursor.write_vlq(v3, count4)

			local count5 = 0

			for v13 in v8[2] do
				t.write_component_id(p1, v3, v13)
				count5 = count5 + 1
			end

			for v14 in v8[7] do
				t.write_component_id(p1, v3, v14)
				count5 = count5 + 1
			end

			for v15 in v8[1] do
				t.write_component_id(p1, v3, v15)
				count5 = count5 + 1
			end

			cursor.write_vlq(v3, count5)
			t.write_entity_id(p1, v3, v7)
			count2 = count2 + 1
		end

		table.clear(components)

		if count2 > 0 then
			cursor.write_vlq(v3, count2)
			v4 = utils.setbit(v4, 3)
		end

		local changes = v2.changes
		local count3 = 0

		for v17, v18 in changes.changed do
			local count4 = 0

			for v19, v20 in v18.relation_component_removed do
				local count5 = 0

				for v21 in v20 do
					t.write_entity_id(p1, v3, v21)
					count5 = count5 + 1
				end

				cursor.write_vlq(v3, count5)
				t.write_component_id(p1, v3, v19)
				count4 = count4 + 1
			end

			for v22, v23 in v18.relation_tag_removed do
				local count5 = 0

				for v24 in v23 do
					t.write_entity_id(p1, v3, v24)
					count5 = count5 + 1
				end

				cursor.write_vlq(v3, count5)
				t.write_component_id(p1, v3, v22)
				count4 = count4 + 1
			end

			cursor.write_vlq(v3, count4)

			local count5 = 0
			local v25 = 0

			for v26, v27 in v18.relation_component_changed do
				local count6 = 0

				for v28, v29 in v27 do
					t.write_entity_id(p1, v3, v28)
					t.write_component_value(p1, v3, v26, v29, t3)
					count6 = count6 + 1
				end

				cursor.write_vlq(v3, count6)
				t.write_component_id(p1, v3, v26)
				count5 = count5 + 1
			end

			if count5 > 0 then
				cursor.write_vlq(v3, count5)
				v25 = utils.setbit(v25, 7)
			end

			local count6 = 0

			for v31, v32 in v18.relation_tag_added do
				local count7 = 0

				for v33 in v32 do
					t.write_entity_id(p1, v3, v33)
					count7 = count7 + 1
				end

				cursor.write_vlq(v3, count7)
				t.write_component_id(p1, v3, v31)
				count6 = count6 + 1
			end

			if count6 > 0 then
				cursor.write_vlq(v3, count6)
				v25 = utils.setbit(v25, 6)
			end

			local count7 = 0

			for v35 in v18.pair_component_removed do
				t.write_entity_pair(p1, world, v3, v35)
				count7 = count7 + 1
			end

			for v36 in v18.pair_tag_removed do
				t.write_entity_pair(p1, world, v3, v36)
				count7 = count7 + 1
			end

			if count7 > 0 then
				cursor.write_vlq(v3, count7)
				v25 = utils.setbit(v25, 5)
			end

			local count8 = 0

			for v38, v39 in v18.pair_component_changed do
				t.write_entity_pair_value(p1, world, v3, v38, v39, t3)
				count8 = count8 + 1
			end

			if count8 > 0 then
				cursor.write_vlq(v3, count8)
				v25 = utils.setbit(v25, 4)
			end

			local count9 = 0

			for v41 in v18.pair_tag_added do
				t.write_entity_pair(p1, world, v3, v41)
				count9 = count9 + 1
			end

			if count9 > 0 then
				cursor.write_vlq(v3, count9)
				v25 = utils.setbit(v25, 3)
			end

			local count10 = 0

			for v43 in v18.component_removed do
				t.write_component_id(p1, v3, v43)
				count10 = count10 + 1
			end

			for v44 in v18.unreliable_removed do
				t.write_component_id(p1, v3, v44)
				count10 = count10 + 1
			end

			for v45 in v18.tag_removed do
				t.write_component_id(p1, v3, v45)
				count10 = count10 + 1
			end

			if count10 > 0 then
				cursor.write_vlq(v3, count10)
				v25 = utils.setbit(v25, 2)
			end

			local count11 = 0

			for v47, v48 in v18.component_changed do
				t.write_component_value(p1, v3, v47, v48, t3)
				t.write_component_id(p1, v3, v47)
				count11 = count11 + 1
			end

			for v49 in v18.unreliable_added do
				t.write_component_value(p1, v3, v49, world_get(world, v17, v49), t3)
				t.write_component_id(p1, v3, v49)
				count11 = count11 + 1
			end

			if count11 > 0 then
				cursor.write_vlq(v3, count11)
				v25 = utils.setbit(v25, 1)
			end

			local count12 = 0

			for v52 in v18.tag_added do
				t.write_component_id(p1, v3, v52)
				count12 = count12 + 1
			end

			if count12 > 0 then
				cursor.write_vlq(v3, count12)
				v25 = utils.setbit(v25, 0)
			end

			if v25 + count4 ~= 0 then
				cursor.writeu8(v3, v25)
				t.write_entity_id(p1, v3, v17)
				count3 = count3 + 1
			end
		end

		table.clear(changes.changed)

		if count3 > 0 then
			cursor.write_vlq(v3, count3)
			v4 = utils.setbit(v4, 2)
		end

		local count4 = 0

		for v55, v56 in changes.added_components do
			local v57 = p1.storage[v55]
			local count5 = 0
			local v58 = 0

			for v59 in v56[6] do
				t.write_entity_relations_values(p1, v57, v3, v59, t3)
				count5 = count5 + 1
			end

			if count5 > 0 then
				cursor.write_vlq(v3, count5)
				v58 = utils.setbit(v58, 5)
			end

			local count6 = 0

			for v61 in v56[5] do
				t.write_entity_relations(p1, v57, v3, v61)
				count6 = count6 + 1
			end

			if count6 > 0 then
				cursor.write_vlq(v3, count6)
				v58 = utils.setbit(v58, 4)
			end

			local count7 = 0

			for v63 in v56[4] do
				t.write_entity_pair_value(p1, world, v3, v63, v57.pair_components[v63], t3)
				count7 = count7 + 1
			end

			if count7 > 0 then
				cursor.write_vlq(v3, count7)
				v58 = utils.setbit(v58, 3)
			end

			local count8 = 0

			for v66 in v56[3] do
				t.write_entity_pair(p1, world, v3, v66)
				count8 = count8 + 1
			end

			if count8 > 0 then
				cursor.write_vlq(v3, count8)
				v58 = utils.setbit(v58, 2)
			end

			local count9 = 0

			for v68 in v56[2] do
				t.write_component_value(p1, v3, v68, v57.components[v68], t3)
				t.write_component_id(p1, v3, v68)
				count9 = count9 + 1
			end

			for v70 in v56[7] do
				t.write_component_value(p1, v3, v70, world_get(world, v55, v70), t3)
				t.write_component_id(p1, v3, v70)
				count9 = count9 + 1
			end

			if count9 > 0 then
				cursor.write_vlq(v3, count9)
				v58 = utils.setbit(v58, 1)
			end

			local count10 = 0

			for v73 in v56[1] do
				if v57.tags[v73] then
					t.write_component_id(p1, v3, v73)
					count10 = count10 + 1
				end
			end

			if count10 > 0 then
				cursor.write_vlq(v3, count10)
				v58 = utils.setbit(v58, 0)
			end

			if v58 ~= 0 then
				cursor.writeu8(v3, v58)
				t.write_entity_id(p1, v3, v55)
				count4 = count4 + 1
			end
		end

		table.clear(changes.added_components)

		if count4 > 0 then
			cursor.write_vlq(v3, count4)
			v4 = utils.setbit(v4, 1)
		end

		local count5 = 0

		for v76 in changes.added do
			local v77 = v2.active[v76]

			if v77 then
				t.write_entity(p1, v3, v76, v77, t3)
				t.write_entity_id(p1, v3, v76)
				count5 = count5 + 1
			end
		end

		table.clear(changes.added)

		if count5 > 0 then
			cursor.write_vlq(v3, count5)
			v4 = utils.setbit(v4, 0)
		end

		if v4 ~= 0 then
			cursor.writeu8(v3, v4)
			append_packet(t2, v2.mask.members, cursor.close(v3), t3)
		end
	end

	table.clear(p1.additions)

	local v80 = nil
	local v81 = 3

	return function() --[[ iterator | Line: 1145 | Upvalues: t2 (copy), v80 (ref), utils (ref), combine_packet_outputs (ref), v81 (copy) ]]
		local v12, v2 = next(t2, v80)

		while not utils.is_client_valid(v12) and (v12 or v2) do
			local v3, v4 = next(t2, v12)

			v12, v2 = v3, v4
		end

		if v12 then
			v80 = v12

			local v5, v6 = combine_packet_outputs(v2.packets, v2.total_size, v81)

			return v12, v5, v6
		end

		return nil
	end
end
function t.collect_unreliable(p1) --[[ collect_unreliable | Line: 1588 | Upvalues: t (copy), cursor (copy), append_packet (copy), world_has (copy), world_get (copy), utils (copy), combine_packet_outputs (copy) ]]
	t.resolve_dirty(p1)

	local world = p1.world
	local t2 = {}

	for v1, v2 in p1.masking.storages do
		if v2.active_count ~= 0 then
			local v3 = cursor.new()
			local t3 = {}
			local count = 0
			local v4 = 0
			local v5 = 0
			local v6 = 0

			local function create_checkpoint() --[[ create_checkpoint | Line: 1607 | Upvalues: v4 (ref), v3 (ref), v5 (ref), t3 (ref), v6 (ref), count (ref) ]]
				v4 = v3.offset
				v5 = #t3
				v6 = count
			end

			local function rollback_checkpoint() --[[ rollback_checkpoint | Line: 1613 | Upvalues: cursor (ref), v3 (ref), v4 (ref), t3 (ref), v5 (ref), count (ref), v6 (ref) ]]
				local v1 = cursor.new()

				cursor.write_buffer(v1, v3.buffer, v4, v3.offset - v4)
				v3.offset = v4
				v3 = v1

				local t = {}

				for i = #t3, v5 + 1, -1 do
					table.insert(t, 1, (table.remove(t3)))
				end

				t3 = t
				count = count - v6
			end

			local function commit_checkpoint(p1, p2, p3) --[[ commit_checkpoint | Line: 1628 | Upvalues: cursor (ref), append_packet (ref), t2 (copy), v2 (copy) ]]
				if not (p3 <= 0) then
					cursor.write_vlq(p1, p3)
					append_packet(t2, v2.mask.members, cursor.close(p1), p2)
				end
			end

			for v7, v8 in v2.active do
				v4 = v3.offset
				v5 = #t3
				v6 = count

				local count2 = 0

				for v9 in v8.components[7] do
					if world_has(world, v7, v9) then
						t.write_component_value(p1, v3, v9, world_get(world, v7, v9), t3)
						t.write_component_id(p1, v3, v9)
						count2 = count2 + 1
					end
				end

				if not (count2 <= 0) then
					count = count + 1
					cursor.write_vlq(v3, count2)
					t.write_entity_id(p1, v3, v7)

					if v3.offset > 900 then
						local v11 = v3
						local v12 = t3

						rollback_checkpoint()

						local v13 = v6

						if not (v13 <= 0) then
							cursor.write_vlq(v11, v13)
							append_packet(t2, v2.mask.members, cursor.close(v11), v12)
						end
					end
				end
			end

			local v15 = v3
			local v16 = t3
			local v17 = count

			if not (v17 <= 0) then
				cursor.write_vlq(v15, v17)
				append_packet(t2, v2.mask.members, cursor.close(v15), v16)
			end
		end
	end

	return coroutine.wrap(function() --[[ Line: 1165 | Upvalues: t2 (copy), utils (ref), combine_packet_outputs (ref) ]]
		for v1, v2 in t2 do
			if utils.is_client_valid(v1) then
				table.sort(v2.packets, function(p13, p23) --[[ Line: 1171 ]]
					return buffer.len(p13.buffer) < buffer.len(p23.buffer)
				end)

				local v3 = #v2.packets
				local count2 = 1

				while count2 <= v3 do
					local sum2 = 0
					local t3 = {}

					repeat
						if not (count2 <= v3) then
							break
						end

						local v4 = v2.packets[count2]
						local v5 = buffer.len(v4.buffer)

						if sum2 + v5 > 900 and #t3 > 0 then
							break
						end

						table.insert(t3, v4)
						sum2 = sum2 + v5
						count2 = count2 + 1
					until sum2 >= 900

					if #t3 > 0 then
						coroutine.yield(v1, combine_packet_outputs(t3, sum2, 4))
					end
				end
			end
		end
	end)
end
function t.start_networked(p1, p2, p3) --[[ start_networked | Line: 1676 | Upvalues: world_add (copy) ]]
	local masking = p1.masking

	masking:deallocate_entity_stop(p2)
	masking:start_entity(p2, p3)
	masking:allocate_propagated_entity_start(p2)
	p1.additions[p2] = true
	p1.track_info.networked[p2] = true

	if not p1.alive_tracked[p2] then
		p1.alive_tracked[p2] = true
		world_add(p1.world, p2, p1.components.__alive_tracking__)
	end
end
function t.start_reliable(p1, p2, p3, p4) --[[ start_reliable | Line: 1688 | Upvalues: track_entity_component (copy) ]]
	local masking = p1.masking
	local v1 = track_entity_component(p1, p2, p3)

	masking:deallocate_component_stop(p2, p3, v1)
	masking:start_component(p2, p3, v1, p4)

	if p1.additions[p2] then
		masking:allocate_shared_entity_start(p2, p3, v1)

		return
	end

	if not p1.track_info.networked[p2] then
		return
	end

	masking:allocate_component_start(p2, p3, v1)
end
function t.start_unreliable(p1, p2, p3, p4) --[[ start_unreliable | Line: 1702 | Upvalues: hook_component (copy), t2 (copy), add_entity_component_tracked (copy) ]]
	local masking = p1.masking
	local v1 = p1.track_info.components[p3]

	if not v1 then
		v1 = hook_component(p1, p3)
	end

	v1[p2] = t2.unreliable
	add_entity_component_tracked(p1, p2, p3, t2.unreliable)
	masking:deallocate_component_stop(p2, p3, 7)
	masking:start_component(p2, p3, 7, p4)

	if p1.additions[p2] then
		masking:allocate_shared_entity_start(p2, p3, 7)

		return
	end

	if not p1.track_info.networked[p2] then
		return
	end

	masking:allocate_component_start(p2, p3, 7)
end
function t.start_pair(p1, p2, p3, p4) --[[ start_pair | Line: 1717 | Upvalues: track_entity_pair (copy) ]]
	local masking = p1.masking
	local v1 = track_entity_pair(p1, p2, p3)

	masking:deallocate_component_stop(p2, p3, v1)
	masking:start_component(p2, p3, v1, p4)

	if p1.additions[p2] then
		masking:allocate_shared_entity_start(p2, p3, v1)

		return
	end

	if not p1.track_info.networked[p2] then
		return
	end

	masking:allocate_component_start(p2, p3, v1)
end
function t.start_relation(p1, p2, p3, p4) --[[ start_relation | Line: 1731 | Upvalues: track_entity_relation (copy) ]]
	local masking = p1.masking
	local v1 = track_entity_relation(p1, p2, p3)

	masking:deallocate_component_stop(p2, p3, v1)
	masking:start_component(p2, p3, v1, p4)

	if p1.additions[p2] then
		masking:allocate_shared_entity_start(p2, p3, v1)

		return
	end

	if not p1.track_info.networked[p2] then
		return
	end

	masking:allocate_component_start(p2, p3, v1)
end
function t.change_networked(p1, p2, p3) --[[ change_networked | Line: 1745 ]]
	p1.masking:set_entity(p2, p3)
end
function t.change_reliable(p1, p2, p3, p4) --[[ change_reliable | Line: 1750 | Upvalues: is_component (copy) ]]
	local masking = p1.masking

	if is_component(p1.world, p3) then
		masking:set_component(p2, p3, 2, p4)
	else
		masking:set_component(p2, p3, 1, p4)
	end
end
function t.change_unreliable(p1, p2, p3, p4) --[[ change_unreliable | Line: 1761 ]]
	p1.masking:set_component(p2, p3, 7, p4)
end
function t.change_pair(p1, p2, p3, p4) --[[ change_pair | Line: 1766 | Upvalues: is_component (copy) ]]
	local masking = p1.masking

	if is_component(p1.world, p3) then
		masking:set_component(p2, p3, 4, p4)
	else
		masking:set_component(p2, p3, 3, p4)
	end
end
function t.change_relation(p1, p2, p3, p4) --[[ change_relation | Line: 1777 | Upvalues: is_component (copy) ]]
	local masking = p1.masking

	if is_component(p1.world, p3) then
		masking:set_component(p2, p3, 6, p4)
	else
		masking:set_component(p2, p3, 5, p4)
	end
end

local function stop_tracked_component(p1, p2, p3, p4, p5) --[[ stop_tracked_component | Line: 1788 ]]
	local masking = p1.masking

	if p1.track_info.networked[p2] then
		masking:deallocate_component_start(p2, p3, p4)

		if not p5 then
			masking:allocate_component_stop(p2, p3, p4)
		end
	end

	masking:stop_component(p2, p3, p4)
end

function t.stop_networked(p1, p2, p3) --[[ stop_networked | Line: 1805 ]]
	if not p1.track_info.networked[p2] then
		return
	end

	local masking = p1.masking

	if not p3 then
		masking:allocate_entity_stop(p2)
	end

	masking:stop_entity(p2)
	p1.additions[p2] = nil
	p1.track_info.networked[p2] = nil
end
function t.stop_reliable(p1, p2, p3, p4) --[[ stop_reliable | Line: 1820 | Upvalues: stop_tracked_component (copy) ]]
	if not p1.track_info.entities[p2] then
		return
	end

	local v1 = p1.track_info.components[p3]
	local v2

	if v1 then
		local v3 = v1[p2]

		v1[p2] = nil

		local v4 = p1.storage[p2]

		if v4 then
			v4.components[p3] = nil
			v4.tags[p3] = nil
		end

		local v5 = p1.track_info.entities[p2]

		if v5 then
			v5.components[p3] = nil
		end

		v2 = v3
	else
		v2 = nil
	end

	if v2 then
		stop_tracked_component(p1, p2, p3, v2, p4)
	end
end
function t.stop_unreliable(p1, p2, p3, p4) --[[ stop_unreliable | Line: 1833 | Upvalues: stop_tracked_component (copy) ]]
	if not p1.track_info.entities[p2] then
		return
	end

	local v1 = p1.track_info.components[p3]
	local v2

	if v1 then
		local v3 = v1[p2]

		v1[p2] = nil

		local v4 = p1.storage[p2]

		if v4 then
			v4.components[p3] = nil
			v4.tags[p3] = nil
		end

		local v5 = p1.track_info.entities[p2]

		if v5 then
			v5.components[p3] = nil
		end

		v2 = v3
	else
		v2 = nil
	end

	if v2 then
		stop_tracked_component(p1, p2, p3, 7, p4)
	end
end
function t.stop_pair(p1, p2, p3, p4) --[[ stop_pair | Line: 1846 | Upvalues: stop_tracked_component (copy) ]]
	if not p1.track_info.entities[p2] then
		return
	end

	local v1 = p1.track_info.pairs[p3]
	local v2

	if v1 then
		local v3 = v1[p2]

		v1[p2] = nil

		local v4 = p1.storage[p2]

		if v4 then
			v4.pair_tags[p3] = nil
			v4.pair_components[p3] = nil
		end

		local v5 = p1.track_info.entities[p2]

		if v5 then
			v5.pairs[p3] = nil
		end

		v2 = v3
	else
		v2 = nil
	end

	if v2 then
		stop_tracked_component(p1, p2, p3, v2, p4)
	end
end
function t.stop_relation(p1, p2, p3, p4) --[[ stop_relation | Line: 1859 | Upvalues: stop_tracked_component (copy) ]]
	if not p1.track_info.entities[p2] then
		return
	end

	local v1 = p1.track_info.components[p3]
	local v2

	if v1 then
		local v3 = v1[p2]

		v1[p2] = nil

		local v4 = p1.storage[p2]

		if v4 then
			v4.relations[p3] = nil
			v4.relation_values[p3] = nil
		end

		local v5 = p1.track_info.entities[p2]

		if v5 then
			v5.components[p3] = nil
		end

		v2 = v3
	else
		v2 = nil
	end

	if v2 then
		stop_tracked_component(p1, p2, p3, v2, p4)
	end
end
function t.set_networked(p1, p2, p3) --[[ set_networked | Line: 1872 | Upvalues: t (copy) ]]
	if p1.track_info.networked[p2] then
		t.change_networked(p1, p2, p3)
	else
		t.start_networked(p1, p2, p3)
	end
end
function t.set_reliable(p1, p2, p3, p4) --[[ set_reliable | Line: 1880 | Upvalues: t (copy) ]]
	local v1 = p1.track_info.entities[p2]

	if v1 and v1.components[p3] then
		t.change_reliable(p1, p2, p3, p4)

		return
	end

	t.start_reliable(p1, p2, p3, p4)
end
function t.set_unreliable(p1, p2, p3, p4) --[[ set_unreliable | Line: 1889 | Upvalues: t (copy) ]]
	local v1 = p1.track_info.entities[p2]

	if v1 and v1.components[p3] then
		t.change_unreliable(p1, p2, p3, p4)

		return
	end

	t.start_unreliable(p1, p2, p3, p4)
end
function t.set_pair(p1, p2, p3, p4) --[[ set_pair | Line: 1898 | Upvalues: t (copy) ]]
	local v1 = p1.track_info.entities[p2]

	if v1 and v1.pairs[p3] then
		t.change_pair(p1, p2, p3, p4)

		return
	end

	t.start_pair(p1, p2, p3, p4)
end
function t.set_relation(p1, p2, p3, p4) --[[ set_relation | Line: 1907 | Upvalues: t (copy) ]]
	local v1 = p1.track_info.entities[p2]

	if v1 and v1.components[p3] then
		t.change_relation(p1, p2, p3, p4)

		return
	end

	t.start_relation(p1, p2, p3, p4)
end
function t.set_custom(p1, p2, p3) --[[ set_custom | Line: 1916 | Upvalues: common (copy) ]]
	if p1.custom_ids[p2] then
		common.log_warn("attempted to register a custom_id twice for the same entity", debug.traceback())
	else
		p1.custom_ids[p2] = p3
	end
end
function t.remove_custom(p1, p2) --[[ remove_custom | Line: 1924 ]]
	p1.custom_ids[p2] = nil
end
function t.set_serdes(p1, p2, p3) --[[ set_serdes | Line: 1928 ]]
	p1.component_serdes[p2] = p3
	p1.is_shared_dirty = true
end
function t.remove_serdes(p1, p2) --[[ remove_serdes | Line: 1933 ]]
	p1.component_serdes[p2] = nil
	p1.is_shared_dirty = true
end

local function check_created(p1) --[[ check_created | Line: 1938 ]]
	if p1.inited == true then
		warn("attempted to init a server twice")

		return false
	end

	if p1.inited == nil then
		warn("attempted to init a destroyed server")

		return false
	end

	return true
end

function t.init(p1, p2) --[[ init | Line: 1950 | Upvalues: utils (copy), common (copy), hook_added (copy), t (copy), hook_changed (copy), hook_removed (copy), relationships (copy), listen_relation (copy), pair_second (copy), is_pair (copy), cleanup_entity (copy), QUERY_CURRENT_COMPONENTS (copy), QUERY_CURRENT_NETWORKED (copy) ]]
	local v1

	if p1.inited == true then
		warn("attempted to init a server twice")
		v1 = false
	elseif p1.inited == nil then
		warn("attempted to init a destroyed server")
		v1 = false
	else
		v1 = true
	end

	if not v1 then
		return
	end

	p1.inited = true

	local v2 = p2 or p1.world

	p1.world = v2

	if not v2 then
		error("Providing a world is required to start replecs")
	end

	if not p1.components then
		p1.components = utils.create_components(utils.tag_factory(v2), utils.component_factory(v2))
		utils.add_component_names(p1.components, function(p1, p2) --[[ Line: 1965 | Upvalues: common (ref), v2 (copy) ]]
			common.add_name(v2, p1, p2)
		end)
	end

	local components = p1.components

	local function hook(p12) --[[ hook | Line: 1972 | Upvalues: p1 (copy) ]]
		table.insert(p1.hooked, p12)
	end

	local v3 = hook_added(v2, components.networked, function(p12, p2, p3) --[[ Line: 1976 | Upvalues: t (ref), p1 (copy) ]]
		t.start_networked(p1, p12, p3)
	end)

	table.insert(p1.hooked, v3)

	local v4 = hook_changed(v2, components.networked, function(p12, p2, p3) --[[ Line: 1979 | Upvalues: t (ref), p1 (copy) ]]
		t.change_networked(p1, p12, p3)
	end)

	table.insert(p1.hooked, v4)

	local v5 = hook_removed(v2, components.networked, function(p12) --[[ Line: 1982 | Upvalues: t (ref), p1 (copy) ]]
		t.stop_networked(p1, p12)
	end)

	table.insert(p1.hooked, v5)

	if relationships then
		local v6 = hook_added(v2, listen_relation(components.reliable), function(p12, p2, p3) --[[ Line: 1987 | Upvalues: pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			t.start_reliable(p1, p12, pair_second(v2, p2), p3)
		end)

		table.insert(p1.hooked, v6)

		local v7 = hook_changed(v2, listen_relation(components.reliable), function(p12, p2, p3) --[[ Line: 1991 | Upvalues: pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			t.change_reliable(p1, p12, pair_second(v2, p2), p3)
		end)

		table.insert(p1.hooked, v7)

		local v8 = hook_removed(v2, listen_relation(components.reliable), function(p12, p2) --[[ Line: 1995 | Upvalues: pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			t.stop_reliable(p1, p12, (pair_second(v2, p2)))
		end)

		table.insert(p1.hooked, v8)

		local v9 = hook_added(v2, listen_relation(components.relation), function(p12, p2, p3) --[[ Line: 2000 | Upvalues: pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			t.start_relation(p1, p12, pair_second(v2, p2), p3)
		end)

		table.insert(p1.hooked, v9)

		local v10 = hook_changed(v2, listen_relation(components.relation), function(p12, p2, p3) --[[ Line: 2004 | Upvalues: pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			t.change_relation(p1, p12, pair_second(v2, p2), p3)
		end)

		table.insert(p1.hooked, v10)

		local v11 = hook_removed(v2, listen_relation(components.relation), function(p12, p2) --[[ Line: 2008 | Upvalues: pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			t.stop_relation(p1, p12, (pair_second(v2, p2)))
		end)

		table.insert(p1.hooked, v11)

		local v12 = hook_added(v2, listen_relation(components.unreliable), function(p12, p2, p3) --[[ Line: 2013 | Upvalues: pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			t.start_unreliable(p1, p12, pair_second(v2, p2), p3)
		end)

		table.insert(p1.hooked, v12)

		local v13 = hook_changed(v2, listen_relation(components.unreliable), function(p12, p2, p3) --[[ Line: 2017 | Upvalues: pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			t.change_unreliable(p1, p12, pair_second(v2, p2), p3)
		end)

		table.insert(p1.hooked, v13)

		local v14 = hook_removed(v2, listen_relation(components.unreliable), function(p12, p2) --[[ Line: 2021 | Upvalues: pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			t.stop_unreliable(p1, p12, (pair_second(v2, p2)))
		end)

		table.insert(p1.hooked, v14)

		local v15 = hook_added(v2, listen_relation(components.custom), function(p12, p2) --[[ Line: 2026 | Upvalues: is_pair (ref), common (ref), pair_second (ref), v2 (copy), t (ref), p1 (copy) ]]
			local v1

			if not is_pair(p2) then
				common.log_error("replecs.custom should be used with a relationship in the server")
			end

			v1 = pair_second(v2, p2)
			t.set_custom(p1, p12, v1)
		end)

		table.insert(p1.hooked, v15)

		local v16 = hook_removed(v2, listen_relation(components.custom), function(p12) --[[ Line: 2033 | Upvalues: t (ref), p1 (copy) ]]
			t.remove_custom(p1, p12)
		end)

		table.insert(p1.hooked, v16)
	end

	local v17 = hook_added(v2, components.global, function(p12, p2, p3) --[[ Line: 2037 | Upvalues: common (ref), p1 (copy) ]]
		if not (p3 > 245) then
			p1.global_ids[p12] = p3

			return
		end

		common.log_error("global id size exceeded, max is 245")
		p1.global_ids[p12] = p3
	end)

	table.insert(p1.hooked, v17)

	local v18 = hook_changed(v2, components.global, function(p12, p2, p3) --[[ Line: 2044 | Upvalues: common (ref), p1 (copy) ]]
		if p3 > 245 then
			common.log_error("global id size exceeded, max is 245")
		end

		p1.global_ids[p12] = p3
	end)

	table.insert(p1.hooked, v18)
	table.insert(p1.hooked, (hook_removed(v2, components.global, function(p12) --[[ Line: 2050 | Upvalues: p1 (copy) ]]
		p1.global_ids[p12] = nil
	end)))

	local v20 = hook_added(v2, components.serdes, function(p12, p2, p3) --[[ Line: 2054 | Upvalues: t (ref), p1 (copy) ]]
		t.set_serdes(p1, p12, p3)
	end)

	table.insert(p1.hooked, v20)

	local v21 = hook_changed(v2, components.serdes, function(p12, p2, p3) --[[ Line: 2057 | Upvalues: t (ref), p1 (copy) ]]
		t.set_serdes(p1, p12, p3)
	end)

	table.insert(p1.hooked, v21)

	local v22 = hook_removed(v2, components.serdes, function(p12) --[[ Line: 2060 | Upvalues: t (ref), p1 (copy) ]]
		t.remove_serdes(p1, p12)
	end)

	table.insert(p1.hooked, v22)

	local v23 = hook_removed(v2, components.__alive_tracking__, function(p12) --[[ Line: 2064 | Upvalues: p1 (copy), t (ref), cleanup_entity (ref) ]]
		if p1.track_info.networked[p12] then
			t.stop_networked(p1, p12)
		end

		cleanup_entity(p1, p12)
	end)

	table.insert(p1.hooked, v23)

	for v24, v25 in p1.requires_shared_lookup do
		local v26 = hook_added(v2, v25, function() --[[ Line: 2072 | Upvalues: p1 (copy) ]]
			p1.is_shared_dirty = true
		end)

		table.insert(p1.hooked, v26)

		local v27 = hook_changed(v2, v25, function() --[[ Line: 2075 | Upvalues: p1 (copy) ]]
			p1.is_shared_dirty = true
		end)

		table.insert(p1.hooked, v27)

		local v28 = hook_removed(v2, v25, function() --[[ Line: 2078 | Upvalues: p1 (copy) ]]
			p1.is_shared_dirty = true
		end)

		table.insert(p1.hooked, v28)
	end

	QUERY_CURRENT_COMPONENTS(p1)
	QUERY_CURRENT_NETWORKED(p1)
	p1.shared = utils.resolved_shared(v2, components, p1.registered_custom_ids, p1.component_serdes)

	if not (game and game:GetService("RunService"):IsServer()) then
		return
	end

	local Players = game:GetService("Players")
	local v29 = Players.PlayerAdded:Connect(function(p12) --[[ Line: 2091 | Upvalues: p1 (copy) ]]
		p1.masking:register_client(p12)
	end)
	local v30 = Players.PlayerRemoving:Connect(function(p12) --[[ Line: 2094 | Upvalues: p1 (copy) ]]
		p1.masking:unregister_client(p12)
	end)

	for v31, v32 in Players:GetPlayers() do
		p1.masking:register_client(v32)
	end

	table.insert(p1.connections, v29)
	table.insert(p1.connections, v30)
end
function t.encode_component(p1, p2) --[[ encode_component | Line: 2106 | Upvalues: t (copy), common (copy) ]]
	t.resolve_dirty(p1)

	local v1 = p1.shared.components.members[p2]

	if v1 then
		return v1
	end

	common.log_error("attempted to encode a non-shared component ", common.log_component(p1.world, p2))

	return 0
end
function t.decode_component(p1, p2) --[[ decode_component | Line: 2116 | Upvalues: t (copy) ]]
	t.resolve_dirty(p1)

	return p1.shared.components.indexes[p2]
end
function t.get_shared_count(p1) --[[ get_shared_count | Line: 2122 | Upvalues: t (copy) ]]
	t.resolve_dirty(p1)

	return #p1.shared.components.keys
end
function t.mark_player_ready(p1, p2) --[[ mark_player_ready | Line: 2127 ]]
	p1.masking:activate_client(p2)
end
function t.is_player_ready(p1, p2) --[[ is_player_ready | Line: 2131 ]]
	return p1.masking:member_is_active(p2)
end
function t.add_player_alias(p1, p2, p3) --[[ add_player_alias | Line: 2135 ]]
	p1.masking.client_aliases[p3] = p2
end
function t.remove_player_alias(p1, p2) --[[ remove_player_alias | Line: 2139 ]]
	p1.masking.client_aliases[p2] = nil
end
function t.register_custom_id(p1, p2) --[[ register_custom_id | Line: 2143 ]]
	p1.registered_custom_ids[p2] = true
	p1.is_shared_dirty = true
end
function t.generate_handshake(p1) --[[ generate_handshake | Line: 2148 | Upvalues: t (copy), utils (copy) ]]
	t.resolve_dirty(p1)

	return utils.generate_handshake(p1.shared)
end
function t.verify_handshake(p1, p2) --[[ verify_handshake | Line: 2153 | Upvalues: t (copy), utils (copy) ]]
	t.resolve_dirty(p1)

	return utils.verify_handshake(p1.shared, p2, "client", "server")
end
function t.destroy(p1) --[[ destroy | Line: 2158 ]]
	if p1.inited == nil then
		return warn("attempted to destroy a server twice")
	end

	p1.inited = nil

	for v1, v2 in p1.hooked do
		v2()
	end

	for v3, v4 in p1.connections do
		v4:Disconnect()
	end
end

return {
	create = function(p1, p2) --[[ create | Line: 2172 | Upvalues: utils (copy), common (copy), masking (copy), ecs_name (copy), t (copy) ]]
		local t2 = {}

		if p2 then
			t2.components = p2
		elseif p1 then
			t2.components = utils.create_components(utils.tag_factory(p1), utils.component_factory(p1))
			utils.add_component_names(t2.components, function(p12, p2) --[[ Line: 2179 | Upvalues: common (ref), p1 (copy) ]]
				common.add_name(p1, p12, p2)
			end)
		end

		t2.shared = {}
		t2.world = p1
		t2.additions = {}
		t2.storage = {}
		t2.hooked = {}
		t2.is_shared_dirty = false
		t2.global_ids = {}
		t2.pending_cleanups = {}
		t2.track_info = {
			networked = {},
			entities = {},
			components = {},
			pairs = {}
		}
		t2.connections = {}
		t2.inited = false
		t2.masking = masking.create()
		t2.alive_tracked = {}
		t2.custom_ids = {}
		t2.registered_custom_ids = {}
		t2.component_serdes = {}
		t2.requires_shared_lookup = { t2.components.shared, ecs_name }

		return setmetatable(t2, t)
	end,
	server_replicator = t
}