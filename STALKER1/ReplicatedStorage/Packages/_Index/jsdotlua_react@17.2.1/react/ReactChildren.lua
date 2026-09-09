-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("shared"))

local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols
local getIteratorFn = ReactSymbols.getIteratorFn
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE
local Array = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Array
local ReactElement = require(script.Parent:WaitForChild("ReactElement"))
local isValidElement = ReactElement.isValidElement
local cloneAndReplaceKey = ReactElement.cloneAndReplaceKey

local function escape(p1) --[[ escape | Line: 43 ]]
	return "$" .. string.gsub(string.gsub(p1, "=", "=0"), ":", "=2")
end

local function escapeUserProvidedKey(p1) --[[ escapeUserProvidedKey | Line: 58 ]]
	return p1
end

local function getElementKey(p1, p2) --[[ getElementKey | Line: 71 ]]
	if typeof(p1) == "table" and (p1 ~= nil and p1.key ~= nil) then
		return "$" .. string.gsub(string.gsub(tostring(p1.key), "=", "=0"), ":", "=2")
	end

	return tostring(p2)
end

local function v1(p1, p2, p3, p4, p5) --[[ mapIntoArray | Line: 84 | Upvalues: REACT_ELEMENT_TYPE (copy), REACT_PORTAL_TYPE (copy), Array (copy), v1 (copy), isValidElement (copy), cloneAndReplaceKey (copy), getIteratorFn (copy) ]]
	local v12 = typeof(p1)

	if v12 == "nil" or (v12 == "boolean" or v12 == "userdata") then
		p1 = nil
	end

	local v2 = false

	if p1 == nil or (v12 == "string" or v12 == "number") then
		v2 = true
	elseif v12 == "table" then
		local v3 = p1["$$typeof"]

		if v3 == REACT_ELEMENT_TYPE or v3 == REACT_PORTAL_TYPE then
			v2 = true
		end
	end

	if v2 then
		local v4 = p5(p1)
		local v5, v6

		if p4 == "" then
			local v8

			if typeof(p1) == "table" and (p1 ~= nil and p1.key ~= nil) then
				v8 = "$" .. string.gsub(string.gsub(tostring(p1.key), "=", "=0"), ":", "=2")
				v5 = p1
			else
				v5 = p1
				v8 = tostring(1)
			end

			v6 = "." .. v8
		else
			v6 = p4
			v5 = p1
		end

		if Array.isArray(v4) then
			v1(v4, p2, if v6 == nil then "" else v6 .. "/", "", function(p1) --[[ Line: 133 ]]
				return p1
			end)
		else
			if v4 == nil then
				return 1
			end

			if isValidElement(v4) then
				local key = v4.key
				local v13, v14, v15

				if key and (not v5 or v5.key ~= key) then
					v13 = tostring(key) .. "/"
					v14 = p3
					v15 = v4
				else
					v14 = p3
					v13 = ""
					v15 = v4
				end

				v4 = cloneAndReplaceKey(v15, v14 .. v13 .. v6)
			end

			table.insert(p2, v4)
		end

		return 1
	end

	local sum = 0
	local v17 = if p4 == "" then "." else p4 .. ":"

	if Array.isArray(p1) then
		for i = 1, #p1 do
			local v18, v19
			local v20 = p1[i]

			if typeof(v20) == "table" and (v20 ~= nil and v20.key ~= nil) then
				v18 = "$" .. string.gsub(string.gsub(tostring(v20.key), "=", "=0"), ":", "=2")
				v19 = v17
			else
				v19, v18 = v17, tostring(i)
			end

			sum = sum + v1(v20, p2, p3, v19 .. v18, p5)
		end
	else
		local v24 = getIteratorFn(p1)

		if typeof(v24) == "function" then
			local v25 = v24(p1)
			local v27, v28 = v25.next(), 1

			while not v27.done do
				local v29, v30
				local value = v27.value

				if typeof(value) == "table" and (value ~= nil and value.key ~= nil) then
					v29 = "$" .. string.gsub(string.gsub(tostring(value.key), "=", "=0"), ":", "=2")
					v30 = v17
				else
					v30, v29 = v17, tostring(v28)
				end

				sum = sum + v1(value, p2, p3, v30 .. v29, p5)
				v27, v28 = v25.next(), v28 + 1
			end
		end
	end

	return sum
end

local function mapChildren(p1, p2, p3) --[[ mapChildren | Line: 251 | Upvalues: v1 (copy) ]]
	if p1 == nil then
		return nil
	end

	local t = {}
	local v12 = 1

	v1(p1, t, "", "", function(p1) --[[ Line: 261 | Upvalues: p2 (copy), v12 (ref) ]]
		local v1 = p2(p1, v12)

		v12 = v12 + 1

		return v1
	end)

	return t
end

local function countChildren(p1) --[[ countChildren | Line: 279 | Upvalues: mapChildren (copy) ]]
	local v1 = 0

	mapChildren(p1, function() --[[ Line: 281 | Upvalues: v1 (ref) ]]
		v1 = v1 + 1
	end)

	return v1
end

local function forEachChildren(p1, p2, p3) --[[ forEachChildren | Line: 303 | Upvalues: mapChildren (copy) ]]
	mapChildren(p1, function(...) --[[ Line: 308 | Upvalues: p2 (copy) ]]
		p2(...)
	end, p3)
end

local function toArray(p1) --[[ toArray | Line: 322 | Upvalues: mapChildren (copy) ]]
	return mapChildren(p1, function(p1) --[[ Line: 323 ]]
		return p1
	end) or {}
end

return {
	forEach = forEachChildren,
	map = mapChildren,
	count = countChildren,
	only = function(p1) --[[ onlyChild | Line: 343 | Upvalues: invariant (copy), isValidElement (copy) ]]
		invariant(isValidElement(p1), "React.Children.only expected to receive a single React element child.")

		return p1
	end,
	toArray = toArray
}