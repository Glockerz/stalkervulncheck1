-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2) --[[ Line: 5 ]]
	for i = 1, #p1 do
		if p2(p1[i], i, p1) then
			return i
		end
	end

	return -1
end