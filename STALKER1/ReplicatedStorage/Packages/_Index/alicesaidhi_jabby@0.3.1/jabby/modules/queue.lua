-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new() --[[ new | Line: 25 | Upvalues: t (copy) ]]
	local v2 = setmetatable({
		size = 0,
		columns = {}
	}, t)

	setmetatable(v2.columns, {
		__index = function(p1, p2) --[[ __index | Line: 32 ]]
			p1[p2] = {}

			return p1[p2]
		end
	})

	return v2
end
function t.add(p1, ...) --[[ add | Line: 41 ]]
	assert(if ... == nil then false else true, "first argument cannot be nil")

	local columns = p1.columns
	local v2 = p1.size + 1

	p1.size = v2

	for i = 1, select("#", ...) do
		columns[i][v2] = select(i, ...)
	end
end
function t.clear(p1) --[[ clear | Line: 54 ]]
	p1.size = 0

	for v1, v2 in next, p1.columns do
		table.clear(v2)
	end
end

local function iter(p1) --[[ iter | Line: 61 ]]
	local columns = p1.columns
	local size = p1.size
	local v1 = 0

	if #columns <= 1 then
		local v2 = columns[1]

		return function() --[[ Line: 68 | Upvalues: v1 (ref), v2 (copy), size (copy), p1 (copy) ]]
			v1 = v1 + 1

			local v12 = v2[v1]

			if v1 ~= size then
				return v12
			end

			p1:clear()

			return v12
		end
	end

	local v3 = table.create(#columns)

	return function() --[[ Line: 76 | Upvalues: v1 (ref), columns (copy), v3 (copy), size (copy), p1 (copy) ]]
		v1 = v1 + 1

		for v12, v2 in next, columns do
			v3[v12] = v2[v1]
		end

		if v1 ~= size then
			local v32

			v32 = v3

			return unpack(v3)
		end

		p1:clear()

		return unpack(v3)
	end
end

t.iter = iter
t.__iter = iter
function t.__len(p1) --[[ __len | Line: 90 ]]
	return p1.size
end

return function(p1) --[[ Line: 101 | Upvalues: t (copy) ]]
	local v1 = t.new()

	if p1 then
		local v2 = p1.connect or p1.Connect

		assert(v2, "signal has no member `connect()`")
		v2(p1, function(...) --[[ Line: 107 | Upvalues: v1 (copy) ]]
			v1:add(...)
		end)
	end

	return v1
end