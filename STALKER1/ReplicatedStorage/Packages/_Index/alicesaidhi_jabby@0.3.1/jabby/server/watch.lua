-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.modules.types)

local world_hook = require(script.Parent.world_hook)
local v1 = newproxy()

local function create_changes() --[[ create_changes | Line: 19 ]]
	return {
		types = {},
		entities = {},
		component = {},
		values = {},
		worlds = {}
	}
end

local function step_watch(p1) --[[ step_watch | Line: 29 | Upvalues: create_changes (copy) ]]
	p1.frame = p1.frame + 1
	p1.frames[p1.frame] = create_changes()
end

local function track_watch(p1) --[[ track_watch | Line: 34 | Upvalues: world_hook (copy), v1 (copy) ]]
	local t = {
		world_hook.hook_onto("remove", function(p12, p2, p3) --[[ Line: 38 | Upvalues: p1 (copy), v1 (ref) ]]
			local v12 = p1.frames[p1.frame]

			table.insert(v12.types, "remove")
			table.insert(v12.entities, p2)
			table.insert(v12.component, p3)
			table.insert(v12.values, v1)
			table.insert(v12.worlds, p12)
		end),
		world_hook.hook_onto("clear", function(p12, p2) --[[ Line: 48 | Upvalues: p1 (copy), v1 (ref) ]]
			local v12 = p1.frames[p1.frame]

			table.insert(v12.types, "clear")
			table.insert(v12.entities, p2)
			table.insert(v12.component, v1)
			table.insert(v12.values, v1)
			table.insert(v12.worlds, p12)
		end),
		world_hook.hook_onto("delete", function(p12, p2) --[[ Line: 58 | Upvalues: p1 (copy), v1 (ref) ]]
			local v12 = p1.frames[p1.frame]

			table.insert(v12.types, "delete")
			table.insert(v12.entities, p2)
			table.insert(v12.component, v1)
			table.insert(v12.values, v1)
			table.insert(v12.worlds, p12)
		end),
		world_hook.hook_onto("add", function(p12, p2, p3) --[[ Line: 68 | Upvalues: p1 (copy), v1 (ref) ]]
			local v12 = p1.frames[p1.frame]

			table.insert(v12.types, "add")
			table.insert(v12.entities, p2)
			table.insert(v12.component, p3)
			table.insert(v12.values, v1)
			table.insert(v12.worlds, p12)
		end),
		world_hook.hook_onto("set", function(p12, p2, p3, p4) --[[ Line: 78 | Upvalues: p1 (copy) ]]
			if p12:has(p2, p3) then
				local v1 = p1.frames[p1.frame]

				table.insert(v1.types, "change")
				table.insert(v1.entities, p2)
				table.insert(v1.component, p3)
				table.insert(v1.values, p4)
				table.insert(v1.worlds, p12)
			else
				local v2 = p1.frames[p1.frame]

				table.insert(v2.types, "move")
				table.insert(v2.entities, p2)
				table.insert(v2.component, p3)
				table.insert(v2.values, p4)
				table.insert(v2.worlds, p12)
			end
		end)
	}

	return function() --[[ stop_hook | Line: 101 | Upvalues: t (copy) ]]
		for v1, v2 in t do
			v2()
		end
	end
end

return {
	create_watch = function() --[[ create_watch | Line: 110 ]]
		return {
			enable_lon = false,
			frame = 0,
			frames = {}
		}
	end,
	track_watch = track_watch,
	step_watch = step_watch,
	NIL = v1
}