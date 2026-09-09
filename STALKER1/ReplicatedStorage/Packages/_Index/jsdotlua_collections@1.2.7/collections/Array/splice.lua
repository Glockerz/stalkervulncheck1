-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3, ...) --[[ Line: 7 ]]
	if #p1 < p2 then
		for i = 1, select("#", ...) do
			table.insert(p1, (select(i, ...)))
		end

		return {}
	end

	local v2 = #p1

	if p2 < 1 then
		p2 = math.max(v2 - math.abs(p2), 1)
	end

	local t = {}
	local v5 = p3 or v2

	if v5 > 0 then
		for j = p2, math.min(v2, p2 + math.max(0, v5 - 1)) do
			table.insert(t, (table.remove(p1, p2)))
		end
	end

	for k = select("#", ...), 1, -1 do
		table.insert(p1, p2, (select(k, ...)))
	end

	return t
end