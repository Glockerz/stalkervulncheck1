-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local public = require(script.Parent.public)

local function i_hook_onto(p1, p2) --[[ i_hook_onto | Line: 4 | Upvalues: public (copy) ]]
	local t = {}

	for i, v in ipairs(public) do
		local world = v.world

		if world then
			local v1 = world[p1]

			assert(if typeof(v1) == "function" then true else false, "can only hook onto functions")
			world[p1] = function(...) --[[ run_hook | Line: 16 | Upvalues: p2 (copy), v1 (copy) ]]
				for v12, v2 in p2 do
					v2(...)
				end

				return v1(...)
			end
			t[world] = v1
		end
	end

	return function() --[[ Line: 28 | Upvalues: t (copy), p1 (copy) ]]
		for v1, v2 in t do
			v1[p1] = v2
		end
	end
end

local t = {}

local function find_swap_pop(p1, p2) --[[ find_swap_pop | Line: 37 ]]
	local v1 = table.find(p1, p2)

	if v1 then
		p1[v1] = p1[#p1]
		p1[#p1] = nil
	end
end

return {
	hook_onto = function(p1, p2) --[[ hook_onto | Line: 44 | Upvalues: t (copy), i_hook_onto (copy) ]]
		if t[p1] == nil then
			local t2 = {}

			t[p1] = {
				cleanup = i_hook_onto(p1, t2),
				callbacks = t2
			}
		end

		local v1 = t[p1]
		local v2 = false

		table.insert(v1.callbacks, p2)

		return function() --[[ unhook | Line: 59 | Upvalues: v2 (ref), v1 (copy), p2 (copy), t (ref), p1 (copy) ]]
			if v2 then
				return
			end

			v2 = true

			local callbacks = v1.callbacks
			local v22 = table.find(callbacks, p2)

			if v22 then
				callbacks[v22] = callbacks[#callbacks]
				callbacks[#callbacks] = nil
			end

			if v1.callbacks[1] ~= nil then
				return
			end

			v1.cleanup()
			t[p1] = nil
		end
	end
}