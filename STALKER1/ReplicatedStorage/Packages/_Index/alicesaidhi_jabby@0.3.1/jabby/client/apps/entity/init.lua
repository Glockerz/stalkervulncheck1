-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local loop = require(script.Parent.Parent.Parent.modules.loop)
local widget = require(script.widget)
local source = vide.source
local cleanup = vide.cleanup
local t = {
	class_name = "app",
	name = "Entity"
}

local function generate_random_query_id() --[[ generate_random_query_id | Line: 22 ]]
	return math.random(2147483647)
end

function t.mount(p1, p2) --[[ mount | Line: 26 | Upvalues: source (copy), loop (copy), cleanup (copy), RunService (copy), widget (copy) ]]
	local v1 = source({})
	local v2 = source({})
	local v3 = source(true)
	local v4 = source(false)
	local v5 = source(false)
	local v6 = math.random(2147483647)
	local t = {
		host = p1.host,
		vm = p1.vm,
		id = p1.id,
		inspect_id = v6
	}

	t.entity = tonumber(p1.entity)
	t.keys = v1
	t.live_updates = v3
	t.changes = v2
	t.apply_changes = v4
	t.deleting = v5
	cleanup(RunService.Heartbeat:Connect((loop("app-client-entity", t, {
		i = 1
	}, script.systems.obtain_entity_data))))

	return widget({
		host = p1.host,
		vm = p1.vm,
		id = p1.id,
		inspect_id = v6,
		entity = p1.entity,
		components = v1,
		live_updates = v3,
		changes = v2,
		apply_changes = v4,
		delete = function() --[[ delete | Line: 72 | Upvalues: v5 (copy) ]]
			v5(true)
		end,
		destroy = p2
	})
end

return t