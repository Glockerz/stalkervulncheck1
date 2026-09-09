-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 2 ]]
	return if type(p1) == "number" and p1 ~= (1 / 0) then p1 == math.floor(p1) else false
end