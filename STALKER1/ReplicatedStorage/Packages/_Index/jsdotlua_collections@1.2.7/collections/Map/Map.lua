-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local forEach = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("forEach"))
local map = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("map"))
local isArray = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("isArray"))
local v1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

local t = {}

function t.new(p1) --[[ new | Line: 22 | Upvalues: isArray (copy), __DEV__ (copy), v1 (copy), t (copy) ]]
	local v12 = nil
	local v2 = nil

	if p1 == nil then
		v12 = {}
		v2 = {}
	elseif isArray(p1) then
		if __DEV__ and #p1 > 0 and typeof(p1[1]) ~= "table" then
			local v4 = error

			v4("Value `" .. typeof(p1[1]) .. "` is not an entry object.\n Cannot create Map from {K, V} form, it must be { {K, V}... }")
		end

		v2, v12 = {}, table.create(#p1)

		for v7, v8 in p1 do
			local v9 = v8[1]

			if __DEV__ and v9 == nil then
				error("cannot create Map from a table that isn\'t an array.")
			end

			if v2[v9] == nil then
				table.insert(v12, v9)
			end

			v2[v9] = v8[2]
		end
	elseif v1(p1, t) then
		local v11 = table.clone(p1._array)

		v12, v2 = v11, table.clone(p1._map)
	else
		error(("`%s` `%s` is not iterable, cannot make Map using it"):format(typeof(p1), (tostring(p1))))
	end

	return setmetatable({
		size = #v12,
		_map = v2,
		_array = v12
	}, t)
end
function t.set(p1, p2, p3) --[[ set | Line: 71 ]]
	if p1._map[p2] == nil then
		p1.size = p1.size + 1
		table.insert(p1._array, p2)
	end

	p1._map[p2] = p3

	return p1
end
function t.get(p1, p2) --[[ get | Line: 83 ]]
	return p1._map[p2]
end
function t.clear(p1) --[[ clear | Line: 87 ]]
	local v1 = table

	p1.size = 0
	v1.clear(p1._map)
	v1.clear(p1._array)
end
function t.delete(p1, p2) --[[ delete | Line: 94 ]]
	if p1._map[p2] == nil then
		return false
	end

	p1.size = p1.size - 1
	p1._map[p2] = nil

	local v1 = table.find(p1._array, p2)

	if not v1 then
		return true
	end

	table.remove(p1._array, v1)

	return true
end
function t.forEach(p1, p2, p3) --[[ forEach | Line: 110 | Upvalues: __DEV__ (copy), forEach (copy) ]]
	if __DEV__ and typeof(p2) ~= "function" then
		error("callback is not a function")
	end

	forEach(p1._array, function(p12) --[[ Line: 117 | Upvalues: p1 (copy), p3 (copy), p2 (copy) ]]
		local v1 = p1._map[p12]

		if p3 == nil then
			p2(v1, p12, p1)
		else
			p2(p3, v1, p12, p1)
		end
	end)
end
function t.has(p1, p2) --[[ has | Line: 128 ]]
	return p1._map[p2] ~= nil
end
function t.keys(p1) --[[ keys | Line: 132 ]]
	return p1._array
end
function t.values(p1) --[[ values | Line: 136 | Upvalues: map (copy) ]]
	return map(p1._array, function(p12) --[[ Line: 137 | Upvalues: p1 (copy) ]]
		return p1._map[p12]
	end)
end
function t.entries(p1) --[[ entries | Line: 142 | Upvalues: map (copy) ]]
	return map(p1._array, function(p12) --[[ Line: 143 | Upvalues: p1 (copy) ]]
		return { p12, p1._map[p12] }
	end)
end
function t.ipairs(p1) --[[ ipairs | Line: 148 | Upvalues: __DEV__ (copy) ]]
	if not __DEV__ then
		return ipairs(p1:entries())
	end

	warn(debug.traceback("`for _,_ in myMap:ipairs() do` is deprecated and will be removed in a future release, please use `for _,_ in myMap do` instead\n", 2))

	return ipairs(p1:entries())
end
function t.__iter(p1) --[[ __iter | Line: 160 ]]
	return next, p1:entries()
end
function t.__index(p1, p2) --[[ __index | Line: 164 | Upvalues: t (copy), __DEV__ (copy) ]]
	local v2 = rawget(t, p2)

	if v2 ~= nil then
		return v2
	end

	if __DEV__ then
		assert(rawget(p1, "_map"), "Map has been corrupted, and is missing private state! Did you accidentally call table.clear() instead of map:clear()?")
	end

	return t.get(p1, p2)
end
function t.__newindex(p1, p2, p3) --[[ __newindex | Line: 180 ]]
	p1:set(p2, p3)
end

return t