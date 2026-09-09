-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Random.new()
local t = {}

for k, v in pairs(table) do
	t[k] = v
end

function t.contains(p1, p2) --[[ Line: 30 | Upvalues: t (copy) ]]
	return t.indexOf(p1, p2) ~= nil
end
function t.indexOf(p1, p2) --[[ Line: 35 | Upvalues: t (copy) ]]
	local v1 = table.find(p1, p2)

	if v1 then
		return v1
	end

	return t.keyOf(p1, p2)
end
function t.keyOf(p1, p2) --[[ Line: 44 ]]
	for k, v in pairs(p1) do
		if v == p2 then
			return k
		end
	end

	return nil
end
function t.skip(p1, p2) --[[ Line: 54 ]]
	return table.move(p1, p2 + 1, #p1, 1, table.create(#p1 - p2))
end
function t.take(p1, p2) --[[ Line: 59 ]]
	return table.move(p1, 1, p2, 1, table.create(p2))
end
function t.range(p1, p2, p3) --[[ Line: 64 ]]
	return table.move(p1, p2, p3, 1, table.create(p3 - p2 + 1))
end
function t.skipAndTake(p1, p2, p3) --[[ Line: 69 ]]
	return table.move(p1, p2 + 1, p2 + p3, 1, table.create(p3))
end
function t.random(p1) --[[ Line: 74 | Upvalues: v1 (copy) ]]
	return p1[v1:NextInteger(1, #p1)]
end
function t.join(p1, p2) --[[ Line: 79 ]]
	local v1 = table.create(#p1 + #p2)

	table.move(p1, 1, #p1, 1, v1)

	return table.move(p2, 1, #p2, #p1 + 1, v1)
end
function t.removeObject(p1, p2) --[[ Line: 86 | Upvalues: t (copy) ]]
	local v1 = t.indexOf(p1, p2)

	if not v1 then
		return
	end

	table.remove(p1, v1)
end
function t.expand(p1, p2) --[[ Line: 95 ]]
	if p2 < 0 then
		error("Cannot expand a table by a negative amount of objects.")
	end

	local v1 = table.create(#p1 + p2)

	for i = 1, #p1 do
		v1[i] = p1[i]
	end

	return v1
end

return t