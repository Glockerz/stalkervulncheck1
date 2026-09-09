-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ lastIndexOf | Line: 1 ]]
	local v1 = string.len(p1)
	local v2 = if p3 then p3 else v1

	if p3 and p3 < 1 then
		v2 = 1
	end

	if p3 and v1 < p3 then
		v2 = v1
	end

	if p2 == "" then
		return v2
	end

	local v3 = nil
	local v4 = 0

	while true do
		local v5, v6 = string.find(p1, p2, v4 + 1, true)

		if v5 == nil or v2 < v5 then
			break
		end

		v3, v4 = v5, v6
	end

	if v3 == nil then
		return -1
	end

	return v3
end