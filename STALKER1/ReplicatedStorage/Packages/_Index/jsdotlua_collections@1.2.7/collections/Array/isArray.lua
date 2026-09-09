-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	if typeof(p1) ~= "table" then
		return false
	end

	if next(p1) == nil then
		return true
	end

	if #p1 == 0 then
		return false
	end

	local count = 0
	local sum = 0

	for k in pairs(p1) do
		if typeof(k) ~= "number" then
			return false
		end

		if k % 1 ~= 0 or k < 1 then
			return false
		end

		count = count + 1
		sum = sum + k
	end

	return sum == count * (count + 1) / 2
end