-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Error = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Error

return function(p1, p2, ...) --[[ invariant | Line: 24 | Upvalues: Error (copy) ]]
	if p1 then
		return
	end

	error(Error(string.format(p2, ...)))
end