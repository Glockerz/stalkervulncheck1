-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("es7-types"))

local t = {}

t.__index = t
function t.new() --[[ new | Line: 19 | Upvalues: t (copy) ]]
	return setmetatable({
		_weakMap = setmetatable({}, {
			__mode = "k"
		})
	}, t)
end
function t.get(p1, p2) --[[ get | Line: 24 ]]
	return p1._weakMap[p2]
end
function t.set(p1, p2, p3) --[[ set | Line: 28 ]]
	p1._weakMap[p2] = p3

	return p1
end
function t.has(p1, p2) --[[ has | Line: 33 ]]
	return p1._weakMap[p2] ~= nil
end

return t