-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ endsWith | Line: 1 ]]
	local v1 = p2:len()

	if v1 == 0 then
		return true
	end

	local v2 = p1:len()
	local v3 = p3 or v2

	if v2 < v3 then
		v3 = v2
	end

	if v3 < 1 then
		return false
	end

	local v4 = v3 - v1 + 1

	return p1:find(p2, v4, true) == v4
end