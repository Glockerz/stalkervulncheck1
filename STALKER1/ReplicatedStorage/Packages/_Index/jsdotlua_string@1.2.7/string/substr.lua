-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ Line: 1 ]]
	if p3 and p3 <= 0 then
		return ""
	end

	return string.sub(p1, p2, p3 and p2 + p3 - 1 or nil)
end