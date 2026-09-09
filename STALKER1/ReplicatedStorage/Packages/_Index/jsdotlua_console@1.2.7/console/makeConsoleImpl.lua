-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local inspect = require(script.Parent.Parent:WaitForChild("collections")).inspect

return function() --[[ Line: 5 | Upvalues: inspect (copy) ]]
	local t = {}
	local v1 = 0

	local function indent() --[[ indent | Line: 9 | Upvalues: v1 (ref) ]]
		return string.rep("  ", v1)
	end

	function t.log(p1, ...) --[[ log | Line: 13 | Upvalues: inspect (ref), v1 (ref) ]]
		local v12 = if typeof(p1) == "string" then string.format(p1, ...) else inspect(p1)

		print(string.rep("  ", v1) .. v12)
	end
	function t.debug(p1, ...) --[[ debug | Line: 23 | Upvalues: inspect (ref), v1 (ref) ]]
		local v12 = if typeof(p1) == "string" then string.format(p1, ...) else inspect(p1)

		print(string.rep("  ", v1) .. v12)
	end
	function t.info(p1, ...) --[[ info | Line: 33 | Upvalues: inspect (ref), v1 (ref) ]]
		local v12 = if typeof(p1) == "string" then string.format(p1, ...) else inspect(p1)

		print(string.rep("  ", v1) .. v12)
	end
	function t.warn(p1, ...) --[[ warn | Line: 43 | Upvalues: inspect (ref), v1 (ref) ]]
		local v12 = if typeof(p1) == "string" then string.format(p1, ...) else inspect(p1)

		warn(string.rep("  ", v1) .. v12)
	end
	function t.error(p1, ...) --[[ error | Line: 53 | Upvalues: inspect (ref), v1 (ref) ]]
		local v12 = if typeof(p1) == "string" then string.format(p1, ...) else inspect(p1)

		warn(string.rep("  ", v1) .. v12)
	end
	function t.group(p1, ...) --[[ group | Line: 65 | Upvalues: inspect (ref), v1 (ref) ]]
		local v12 = if typeof(p1) == "string" then string.format(p1, ...) else inspect(p1)

		print(string.rep("  ", v1) .. v12)
		v1 = v1 + 1
	end
	function t.groupCollapsed(p1, ...) --[[ groupCollapsed | Line: 76 | Upvalues: inspect (ref), v1 (ref) ]]
		local v12 = if typeof(p1) == "string" then string.format(p1, ...) else inspect(p1)

		print(string.rep("  ", v1) .. v12)
		v1 = v1 + 1
	end
	function t.groupEnd() --[[ groupEnd | Line: 88 | Upvalues: v1 (ref) ]]
		if not (v1 > 0) then
			return
		end

		v1 = v1 - 1
	end

	return t
end