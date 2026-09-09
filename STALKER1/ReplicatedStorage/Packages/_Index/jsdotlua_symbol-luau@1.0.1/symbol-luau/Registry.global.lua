-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Symbol = require(script.Parent:WaitForChild("Symbol"))
local t = {}

return {
	getOrInit = function(p1) --[[ getOrInit | Line: 6 | Upvalues: t (ref), Symbol (copy) ]]
		if t[p1] == nil then
			t[p1] = Symbol.new(p1)
		end

		return t[p1]
	end,
	__clear = function() --[[ __clear | Line: 14 | Upvalues: t (ref) ]]
		t = {}
	end
}