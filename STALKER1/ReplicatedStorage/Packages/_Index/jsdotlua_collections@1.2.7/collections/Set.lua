-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local inspect = require(script.Parent:WaitForChild("inspect"))
local isArray = require(script.Parent:WaitForChild("Array"):WaitForChild("isArray"))
local forEach = require(script.Parent:WaitForChild("Array"):WaitForChild("forEach"))
local fromString = require(script.Parent:WaitForChild("Array"):WaitForChild("from"):WaitForChild("fromString"))

require(script.Parent.Parent:WaitForChild("es7-types"))

local t = {
	__iter = function(p1) --[[ __iter | Line: 23 ]]
		return next, p1._array
	end,
	__tostring = function(p1) --[[ __tostring | Line: 26 | Upvalues: inspect (copy) ]]
		local v1 = "Set "

		if #p1._array > 0 then
			v1 = v1 .. "(" .. tostring(#p1._array) .. ") "
		end

		return v1 .. inspect(p1._array)
	end
}

t.__index = t
function t.new(p1) --[[ new | Line: 38 | Upvalues: isArray (copy), __DEV__ (copy), fromString (copy), t (copy) ]]
	local t2 = {}
	local v1

	if p1 == nil then
		v1 = {}
	else
		local v2 = nil

		if typeof(p1) == "table" then
			if isArray(p1) then
				v2 = table.clone(p1)
			else
				local v4 = getmetatable(p1)

				if v4 and rawget(v4, "__iter") then
					v2 = p1
				elseif __DEV__ then
					error("cannot create array from an object-like table")
				end
			end
		elseif typeof(p1) == "string" then
			v2 = fromString(p1)
		else
			error(("cannot create array from value of type `%s`"):format((typeof(p1))))
		end

		if v2 then
			v1 = table.create(#v2)

			for v7, v8 in v2 do
				if not t2[v8] then
					t2[v8] = true
					table.insert(v1, v8)
				end
			end
		else
			v1 = {}
		end
	end

	return setmetatable({
		size = #v1,
		_map = t2,
		_array = v1
	}, t)
end
function t.add(p1, p2) --[[ add | Line: 84 ]]
	if not p1._map[p2] then
		p1.size = p1.size + 1
		p1._map[p2] = true
		table.insert(p1._array, p2)
	end

	return p1
end
function t.clear(p1) --[[ clear | Line: 94 ]]
	p1.size = 0
	table.clear(p1._map)
	table.clear(p1._array)
end
function t.delete(p1, p2) --[[ delete | Line: 100 ]]
	if not p1._map[p2] then
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
function t.forEach(p1, p2, p3) --[[ forEach | Line: 116 | Upvalues: forEach (copy) ]]
	if typeof(p2) == "function" then
		forEach(p1._array, function(p13) --[[ Line: 122 | Upvalues: p3 (copy), p2 (copy), p1 (copy) ]]
			if p3 == nil then
				p2(p13, p13, p1)
			else
				p2(p3, p13, p13, p1)
			end
		end)

		return
	end

	error("callback is not a function")
end
function t.has(p1, p2) --[[ has | Line: 131 ]]
	return p1._map[p2] ~= nil
end
function t.ipairs(p1) --[[ ipairs | Line: 135 | Upvalues: __DEV__ (copy) ]]
	if not __DEV__ then
		return ipairs(p1._array)
	end

	warn(debug.traceback("`for _,_ in mySet:ipairs() do` is deprecated and will be removed in a future release, please use `for _,_ in mySet do` instead\n", 2))

	return ipairs(p1._array)
end

return t