-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ is | Line: 16 ]]
	return if p1 == p2 and (p1 ~= 0 or 1 / p1 == 1 / p2) then true elseif p1 == p1 then false else p2 ~= p2
end