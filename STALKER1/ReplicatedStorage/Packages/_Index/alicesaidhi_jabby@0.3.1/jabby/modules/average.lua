-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ average | Line: 3 ]]
	local sum = 0

	for v1, v2 in p1 do
		sum = sum + v2
	end

	return sum / #p1
end