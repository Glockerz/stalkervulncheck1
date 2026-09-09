-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 3 ]]
	if p1 == p2 then
		return if p1 == 0 then 1 / p1 == 1 / p2 else true
	end

	return if p1 == p1 then false else p2 ~= p2
end