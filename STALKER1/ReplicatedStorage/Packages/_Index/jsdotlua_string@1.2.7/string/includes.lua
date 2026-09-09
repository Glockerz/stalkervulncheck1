-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = "([" .. ("$%^()-[].?"):gsub("(.)", "%%%1") .. "])"

return function(p1, p2, p3) --[[ includes | Line: 4 | Upvalues: v1 (copy) ]]
	local v12, v2 = utf8.len(p1)

	assert(if v12 == nil then false else true, ("string `%s` has an invalid byte at position %s"):format(p1, (tostring(v2))))

	if v12 == 0 then
		return false
	end

	if #p2 == 0 then
		return true
	end

	local v5

	if p3 == nil then
		v5 = 1
	else
		v5 = tonumber(p3) or 1

		if v12 < v5 then
			return false
		end
	end

	if v5 < 1 then
		v5 = 1
	end

	local v6 = utf8.offset(p1, v5)
	local v8, _ = string.find(p1, p2:gsub(v1, "%%%1"), v6)

	return v8 ~= nil
end