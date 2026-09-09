-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Random.new()
local v2 = table
local t = {}

function t.contains(p1, p2) --[[ Line: 27 | Upvalues: t (copy) ]]
	return t.indexOf(p1, p2) ~= nil
end
function t.indexOf(p1, p2) --[[ Line: 32 | Upvalues: t (copy) ]]
	local v1 = table.find(p1, p2)

	if v1 then
		return v1
	end

	return t.keyOf(p1, p2)
end
function t.keyOf(p1, p2) --[[ Line: 41 ]]
	for k, v in pairs(p1) do
		if v == p2 then
			return k
		end
	end

	return nil
end
function t.insertAndGetIndexOf(p1, p2) --[[ Line: 51 ]]
	p1[#p1 + 1] = p2

	return #p1
end
function t.skip(p1, p2) --[[ Line: 57 ]]
	return table.move(p1, p2 + 1, #p1, 1, table.create(#p1 - p2))
end
function t.take(p1, p2) --[[ Line: 62 ]]
	return table.move(p1, 1, p2, 1, table.create(p2))
end
function t.range(p1, p2, p3) --[[ Line: 67 ]]
	return table.move(p1, p2, p3, 1, table.create(p3 - p2 + 1))
end
function t.skipAndTake(p1, p2, p3) --[[ Line: 72 ]]
	return table.move(p1, p2 + 1, p2 + p3, 1, table.create(p3))
end
function t.random(p1) --[[ Line: 77 | Upvalues: v1 (copy) ]]
	return p1[v1:NextInteger(1, #p1)]
end
function t.join(p1, p2) --[[ Line: 82 ]]
	local v1 = table.create(#p1 + #p2)

	table.move(p1, 1, #p1, 1, v1)

	return table.move(p2, 1, #p2, #p1 + 1, v1)
end
function t.removeObject(p1, p2) --[[ Line: 89 | Upvalues: t (copy) ]]
	local v1 = t.indexOf(p1, p2)

	if not v1 then
		return
	end

	table.remove(p1, v1)
end

return setmetatable({}, {
	__index = function(p1, p2) --[[ __index | Line: 97 | Upvalues: t (copy), v2 (copy) ]]
		if t[p2] == nil then
			return v2[p2]
		end

		return t[p2]
	end,
	__newindex = function(p1, p2, p3) --[[ __newindex | Line: 105 ]]
		error("Add new table entries by editing the Module itself.")
	end
})