-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent:WaitForChild("ReactInternalTypes"))

local t = {}
local t2 = {}
local v1 = if _G.__DEV__ then {} else nil
local v2 = 0

return {
	createCursor = function(p1) --[[ createCursor | Line: 34 ]]
		return {
			current = p1
		}
	end,
	isEmpty = function() --[[ isEmpty | Line: 40 | Upvalues: v2 (ref) ]]
		return v2 == 0
	end,
	pop = function(p1, p2) --[[ pop | Line: 44 | Upvalues: v2 (ref), console (copy), v1 (ref), t2 (copy), t (copy) ]]
		if v2 < 1 then
			if not _G.__DEV__ then
				return
			end

			console.error("Unexpected pop.")
		else
			if _G.__DEV__ and p2 ~= v1[v2] then
				console.error("Unexpected Fiber popped.")
			end

			local v12 = t2[v2]

			if v12 == t then
				p1.current = nil
			else
				p1.current = v12
			end

			t2[v2] = nil

			if _G.__DEV__ then
				v1[v2] = nil
			end

			v2 = v2 - 1
		end
	end,
	push = function(p1, p2, p3) --[[ push | Line: 76 | Upvalues: v2 (ref), t2 (copy), t (copy), v1 (ref) ]]
		v2 = v2 + 1

		local current = p1.current

		if current == nil then
			t2[v2] = t
		else
			t2[v2] = current
		end

		if not _G.__DEV__ then
			p1.current = p2

			return
		end

		v1[v2] = p3
		p1.current = p2
	end,
	checkThatStackIsEmpty = function() --[[ checkThatStackIsEmpty | Line: 93 | Upvalues: v2 (ref), console (copy) ]]
		if not _G.__DEV__ or v2 == 0 then
			return
		end

		console.error("Expected an empty stack. Something was not reset properly.")
	end,
	resetStackAfterFatalErrorInDev = function() --[[ resetStackAfterFatalErrorInDev | Line: 101 | Upvalues: v2 (ref), t2 (copy), v1 (ref) ]]
		if not _G.__DEV__ then
			return
		end

		v2 = 0
		table.clear(t2)
		table.clear(v1)
	end
}