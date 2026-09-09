-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	return if typeof(p1) == "number" and (p1 == p1 and p1 ~= (1 / 0)) then p1 ~= (-1 / 0) else false
end