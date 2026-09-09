-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 6 ]]
	if typeof(p1) ~= "table" then
		error(string.format("Array.slice called on %s", (typeof(p1))))
	end

	local v1 = #p1
	local v2 = p2 or 1
	local v3 = if p3 == nil or v1 + 1 < p3 then v1 + 1 else p3

	if v1 + 1 < v2 then
		return {}
	end

	local t = {}

	if v2 < 1 then
		v2 = math.max(v1 - math.abs(v2), 1)
	end

	if v3 < 1 then
		v3 = math.max(v1 - math.abs(v3), 1)
	end

	local count, count2 = v2, 1

	while count < v3 do
		t[count2] = p1[count]
		count = count + 1
		count2 = count2 + 1
	end

	return t
end