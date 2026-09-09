-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2) --[[ Line: 5 ]]
	for i = 1, #p1 do
		local v1 = p1[i]

		if p2(v1, i, p1) then
			return v1
		end
	end

	return nil
end