-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = "([" .. ("$%^()-[].?"):gsub("(.)", "%%%1") .. "])"

return function(p1, p2, p3) --[[ Line: 7 | Upvalues: v1 (copy) ]]
	local v12 = #p1
	local v2 = if p3 == nil then 1 elseif p3 < 1 then 1 else p3

	if #p2 == 0 then
		if v12 < v2 then
			return v12
		end

		return v2
	end

	if v12 < v2 then
		return -1
	end

	local v3 = p2:gsub(v1, "%%%1")

	v4 = #v3
	v5 = v3

	for i = v2, v12 do
		if string.sub(p1, i, i + v4 - 1) == v3 then
			return i
		end
	end

	return -1
end