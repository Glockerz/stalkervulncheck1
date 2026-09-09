-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1) --[[ Line: 5 ]]
	local count = 1
	local count2 = #p1

	while count < count2 do
		local v2 = p1[count]

		p1[count] = p1[count2]
		p1[count2] = v2
		count = count + 1
		count2 = count2 - 1
	end

	return p1
end