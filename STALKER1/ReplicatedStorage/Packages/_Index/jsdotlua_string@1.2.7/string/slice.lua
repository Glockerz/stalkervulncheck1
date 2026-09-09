-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ slice | Line: 1 ]]
	local v1, v2 = utf8.len(p1)

	assert(if v1 == nil then false else true, ("string `%s` has an invalid byte at position %s"):format(p1, (tostring(v2))))

	local v5 = tonumber(p2)

	assert(if typeof(v5) == "number" then true else false, "startIndexStr should be a number")

	if v5 + v1 < 0 then
		v5 = 1
	end

	if v1 < v5 then
		return ""
	end

	local v7 = if p3 == nil then v1 + 1 else tonumber(p3) or (0 / 0)

	assert(if typeof(v7) == "number" then true else false, "lastIndexStr should convert to number")

	if v1 < v7 then
		v7 = v1 + 1
	end

	return string.sub(p1, utf8.offset(p1, v5), utf8.offset(p1, v7) - 1)
end