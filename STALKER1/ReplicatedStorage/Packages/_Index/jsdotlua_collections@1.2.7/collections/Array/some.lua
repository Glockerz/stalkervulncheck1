-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 11 ]]
	if typeof(p1) ~= "table" then
		error(string.format("Array.some called on %s", (typeof(p1))))
	end

	if typeof(p2) ~= "function" then
		error("callback is not a function")
	end

	for v1, v2 in p1 do
		if p3 == nil then
			if v2 ~= nil and p2(v2, v1, p1) then
				return true
			end

			continue
		end

		if v2 ~= nil and p2(p3, v2, v1, p1) then
			return true
		end
	end

	return false
end