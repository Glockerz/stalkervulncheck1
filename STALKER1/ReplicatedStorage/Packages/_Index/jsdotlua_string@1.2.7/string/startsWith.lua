-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ startsWith | Line: 1 ]]
	if string.len(p2) == 0 then
		return true
	end

	local v1 = if p3 == nil or p3 < 1 then 1 else p3

	if string.len(p1) < v1 then
		return false
	end

	return p1:find(p2, v1, true) == v1
end