-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.types)

return function(p1) --[[ Line: 3 ]]
	return ("%*\0%*"):format(p1.host, p1.from_vm or p1.to_vm)
end