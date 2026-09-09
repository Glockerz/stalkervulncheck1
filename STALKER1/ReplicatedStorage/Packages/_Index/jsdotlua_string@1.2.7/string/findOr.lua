-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = "([" .. ("$%^()-[].?"):gsub("(.)", "%%%1") .. "])"

return function(p1, p2, p3) --[[ findOr | Line: 9 | Upvalues: v1 (copy) ]]
	local v12 = utf8.offset(p1, p3 or 1)
	local t = {}

	for v2, v3 in p2 do
		local v5, v6 = string.find(p1, v3:gsub(v1, "%%%1"), v12)

		if v5 then
			local v7 = string.sub(p1, 1, v5 - 1)
			local v8, v9 = utf8.len(v7)

			if v8 == nil then
				error(("string `%s` has an invalid byte at position %s"):format(v7, (tostring(v9))))
			end

			table.insert(t, {
				index = v8 + 1,
				match = string.sub(p1, v5, v6)
			})
		end
	end

	if #t == 0 then
		return nil
	end

	local v10 = nil

	for v11, v122 in t do
		if v10 == nil then
			v10 = v122
		end

		if v122.index < v10.index then
			v10 = v122
		end
	end

	return v10
end