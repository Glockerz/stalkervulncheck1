-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local jecs = require(script.Parent.Parent:WaitForChild("jecs"))
local t = {}
local Wildcard = jecs.Wildcard
local v1 = jecs.Name

function LOGERROR(...) --[[ LOGERROR | Line: 18 ]]
	error("REPLECS ERROR - " .. table.concat({ ... }, " "))
end
function LOGWARN(...) --[[ LOGWARN | Line: 21 ]]
	warn("REPLECS WARN - " .. table.concat({ ... }, " "))
end
function LOG_COMPONENT(p1, p2) --[[ LOG_COMPONENT | Line: 25 | Upvalues: v1 (copy) ]]
	return (" name: %*, id: %*"):format(p1:get(p2, v1) or "(no name)", p2)
end

local function IS_PAIR(p1) --[[ IS_PAIR | Line: 29 | Upvalues: jecs (copy) ]]
	return jecs.IS_PAIR(p1)
end

local function PAIR(p1, p2) --[[ PAIR | Line: 33 | Upvalues: jecs (copy) ]]
	return jecs.pair(p1, p2)
end

local function PAIR_FIRST(p1, p2) --[[ PAIR_FIRST | Line: 37 | Upvalues: jecs (copy) ]]
	if not jecs.IS_PAIR(p2) then
		LOGERROR((("expected a pair, got: %*"):format((LOG_COMPONENT(p1, p2)))))
	end

	return jecs.pair_first(p1, p2)
end

local function PAIR_SECOND(p1, p2) --[[ PAIR_SECOND | Line: 44 | Upvalues: jecs (copy) ]]
	if not jecs.IS_PAIR(p2) then
		LOGERROR((("expected a pair, got: %*"):format((LOG_COMPONENT(p1, p2)))))
	end

	return jecs.pair_second(p1, p2)
end

local function LISTEN_RELATION(p1) --[[ LISTEN_RELATION | Line: 51 ]]
	return p1
end

local function ADD_NAME(p1, p2, p3) --[[ ADD_NAME | Line: 55 | Upvalues: v1 (copy) ]]
	p1:set(p2, v1, p3)
end

local function ADD_PREREGISTERED_NAME(p1, p2) --[[ ADD_PREREGISTERED_NAME | Line: 59 | Upvalues: jecs (copy), v1 (copy) ]]
	jecs.meta(p1, v1, p2)
end

local function ITERATE_ALL_RELATIONS(p1, p2, p3, p4) --[[ ITERATE_ALL_RELATIONS | Line: 63 | Upvalues: jecs (copy), Wildcard (copy) ]]
	local v1 = jecs.entity_index_try_get_fast(p1.entity_index, p2)

	if not v1 then
		return
	end

	local archetype = v1.archetype
	local v4 = p1.component_index[jecs.pair(p3, Wildcard)]

	if not v4 then
		return
	end

	local id = archetype.id
	local v5 = v4.counts[id]

	if not v5 then
		return
	end

	local v6 = v4.records[id]

	if not v6 then
		return
	end

	for i = v6, v6 + v5 - 1 do
		p4(archetype.types[i])
	end
end

local function WORLD_ADD(p1, p2, p3) --[[ WORLD_ADD | Line: 92 ]]
	p1:add(p2, p3)
end

local function WORLD_SET(p1, p2, p3, p4) --[[ WORLD_SET | Line: 96 ]]
	p1:set(p2, p3, p4)
end

local function WORLD_REMOVE(p1, p2, p3) --[[ WORLD_REMOVE | Line: 100 ]]
	p1:remove(p2, p3)
end

local function WORLD_DELETE(p1, p2) --[[ WORLD_DELETE | Line: 104 ]]
	p1:delete(p2)
end

local function WORLD_GET(p1, p2, p3) --[[ WORLD_GET | Line: 108 ]]
	return p1:get(p2, p3)
end

local function WORLD_TARGET(p1, p2, p3, p4) --[[ WORLD_TARGET | Line: 112 ]]
	return p1:target(p2, p3, p4)
end

local function WORLD_HAS(p1, p2, p3) --[[ WORLD_HAS | Line: 116 ]]
	return p1:has(p2, p3)
end

local function WORLD_ENTITY(p1) --[[ WORLD_ENTITY | Line: 120 ]]
	return p1:entity()
end

local function WORLD_TAG(p1) --[[ WORLD_TAG | Line: 124 ]]
	return p1:entity()
end

local function WORLD_COMPONENT(p1) --[[ WORLD_COMPONENT | Line: 127 ]]
	return p1:component()
end

local function IS_COMPONENT(p1, p2) --[[ IS_COMPONENT | Line: 134 | Upvalues: jecs (copy) ]]
	return not jecs.is_tag(p1, p2)
end

local function HOOK_ADDED(p1, p2, p3) --[[ HOOK_ADDED | Line: 138 ]]
	return p1:added(p2, p3)
end

local function HOOK_CHANGED(p1, p2, p3) --[[ HOOK_CHANGED | Line: 142 ]]
	return p1:changed(p2, p3)
end

local function HOOK_REMOVED(p1, p2, p3) --[[ HOOK_REMOVED | Line: 150 ]]
	return p1:removed(p2, p3)
end

t.preregistration = true
t.relationships = true
t.wildcard = Wildcard
t.ecs_name = v1
t.implicitly_shared = {
	["jecs.ChildOf"] = jecs.ChildOf
}
t.is_pair = IS_PAIR
t.pair = PAIR
t.pair_first = PAIR_FIRST
t.pair_second = PAIR_SECOND
t.add_name = ADD_NAME
t.add_preregistered_name = ADD_PREREGISTERED_NAME
t.iterate_all_relations = ITERATE_ALL_RELATIONS
t.world_set = WORLD_SET
t.world_remove = WORLD_REMOVE
t.world_delete = WORLD_DELETE
t.world_add = WORLD_ADD
t.world_get = WORLD_GET
t.world_target = WORLD_TARGET
t.world_has = WORLD_HAS
t.world_entity = WORLD_ENTITY
t.world_tag = WORLD_TAG
t.world_component = WORLD_COMPONENT
t.preregister_component = jecs.component
t.preregister_tag = jecs.tag
t.is_component = IS_COMPONENT
t.listen_relation = LISTEN_RELATION
t.hook_added = HOOK_ADDED
t.hook_changed = HOOK_CHANGED
t.hook_removed = HOOK_REMOVED
t.log_error = LOGERROR
t.log_warn = LOGWARN
t.log_component = LOG_COMPONENT

return t