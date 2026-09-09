-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local isArray = require(script.Parent:WaitForChild("Array"):WaitForChild("isArray"))

require(script.Parent.Parent:WaitForChild("es7-types"))

local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil

local function inspect(p1, p2) --[[ inspect | Line: 34 | Upvalues: v1 (ref) ]]
	local v12 = if p2 then p2 else {
	depth = 2
}
	local v2 = v12.depth or 2

	v12.depth = if v2 >= 0 then v2 else 2

	return v1(p1, {}, v12)
end

local function isIndexKey(p1, p2) --[[ isIndexKey | Line: 41 ]]
	return if type(p1) == "number" and (p1 <= p2 and p1 >= 1) then math.floor(p1) == p1 else false
end

local function getTableLength(p1) --[[ getTableLength | Line: 48 ]]
	local count = 1
	local v1 = rawget(p1, count)

	while v1 ~= nil do
		count = count + 1
		v1 = rawget(p1, count)
	end

	return count - 1
end

local function sortKeysForPrinting(p1, p2) --[[ sortKeysForPrinting | Line: 58 ]]
	local v1 = type(p1)
	local v2 = type(p2)

	if v1 == v2 and (v1 == "number" or v1 == "string") then
		return p1 < p2
	end

	return v1 < v2
end

local function rawpairs(p1) --[[ rawpairs | Line: 71 ]]
	return next, p1, nil
end

local function getFragmentedKeys(p1) --[[ getFragmentedKeys | Line: 75 | Upvalues: sortKeysForPrinting (copy) ]]
	local count = 1
	local v1 = rawget(p1, count)
	local count2 = 0
	local t = {}

	while v1 ~= nil do
		count = count + 1
		v1 = rawget(p1, count)
	end

	local v3 = count - 1

	for v4, v5 in next, p1 do
		if not (if type(v4) == "number" and (v4 <= v3 and v4 >= 1) then if math.floor(v4) == v4 then true else false else false) then
			count2 = count2 + 1
			t[count2] = v4
		end
	end

	table.sort(t, sortKeysForPrinting)

	return t, count2, v3
end

v1 = function(p1, p2, p3) --[[ formatValue | Line: 89 | Upvalues: HttpService (copy), v2 (ref) ]]
	local v1 = typeof(p1)

	if v1 == "string" then
		return HttpService:JSONEncode(p1)
	end

	if v1 == "number" then
		if p1 ~= p1 then
			return "NaN"
		end

		if p1 == (1 / 0) then
			return "Infinity"
		end

		if p1 == (-1 / 0) then
			return "-Infinity"
		end

		return tostring(p1)
	end

	if v1 == "function" then
		local v22 = "[function"
		local v3 = debug.info(p1, "n")

		if v3 ~= nil and v3 ~= "" then
			v22 = v22 .. " " .. v3
		end

		return v22 .. "]"
	end

	if v1 == "table" then
		return v2(p1, p2, p3)
	end

	return tostring(p1)
end
v2 = function(p1, p2, p3) --[[ formatObjectValue | Line: 122 | Upvalues: v1 (ref), isArray (copy), v3 (ref), v4 (ref) ]]
	if table.find(p2, p1) ~= nil then
		return "[Circular]"
	end

	local t = { unpack(p2) }

	table.insert(t, p1)

	if typeof(p1.toJSON) == "function" then
		local v12 = p1:toJSON(p1)

		if v12 ~= p1 then
			if typeof(v12) == "string" then
				return v12
			end

			return v1(v12, t, p3)
		end
	elseif isArray(p1) then
		return v3(p1, t, p3)
	end

	return v4(p1, t, p3)
end
v4 = function(p1, p2, p3) --[[ formatObject | Line: 147 | Upvalues: getFragmentedKeys (copy), v5 (ref), v1 (ref) ]]
	local v12 = ""
	local v2 = getmetatable(p1)

	if v2 and rawget(v2, "__tostring") then
		return tostring(p1)
	end

	local v3, v4, v52 = getFragmentedKeys(p1)

	if v52 == 0 and v4 == 0 then
		return v12 .. "{}"
	end

	if #p2 > p3.depth then
		return v12 .. "[" .. v5(p1) .. "]"
	end

	local t = {}

	for i = 1, v52 do
		table.insert(t, (v1(p1[i], p2, p3)))
	end

	for j = 1, v4 do
		local v7 = v3[j]

		table.insert(t, v7 .. ": " .. v1(p1[v7], p2, p3))
	end

	return v12 .. "{ " .. table.concat(t, ", ") .. " }"
end
v3 = function(p1, p2, p3) --[[ formatArray | Line: 183 | Upvalues: v1 (ref) ]]
	local v12 = #p1

	if v12 == 0 then
		return "[]"
	end

	if #p2 > p3.depth then
		return "[Array]"
	end

	local v2 = math.min(10, v12)
	local t = {}
	local v3 = v12 - v2

	for i = 1, v2 do
		t[i] = v1(p1[i], p2, p3)
	end

	if v3 == 1 then
		table.insert(t, "... 1 more item")
	elseif v3 > 1 then
		table.insert(t, ("... %s more items"):format((tostring(v3))))
	end

	return "[" .. table.concat(t, ", ") .. "]"
end
v5 = function(p1) --[[ getObjectTag | Line: 209 ]]
	return "Object"
end

return inspect