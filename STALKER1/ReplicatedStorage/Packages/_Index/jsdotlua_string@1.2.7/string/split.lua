-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local findOr = require(script.Parent:WaitForChild("findOr"))
local slice = require(script.Parent:WaitForChild("slice"))

require(script.Parent.Parent:WaitForChild("es7-types"))

local MAX_SAFE_INTEGER = require(script.Parent.Parent:WaitForChild("number")).MAX_SAFE_INTEGER

return function(p1, p2, p3) --[[ split | Line: 10 | Upvalues: MAX_SAFE_INTEGER (copy), findOr (copy), slice (copy) ]]
	if p2 == nil then
		return { p1 }
	end

	if p3 == 0 then
		return {}
	end

	local v2

	if typeof(p2) == "string" then
		if p2 == "" then
			local t = {}

			for v3 in p1:gmatch(".") do
				table.insert(t, v3)
			end

			return t
		end

		v2 = { p2 }
	else
		v2 = p2
	end

	local v4 = 1
	local t = {}
	local v5 = nil
	local v6, v7 = utf8.len(p1)

	assert(if v6 == nil then false else true, ("string `%s` has an invalid byte at position %s"):format(p1, (tostring(v7))))

	repeat
		local v10 = findOr(p1, v2, v4)

		if v10 == nil then
			table.insert(t, slice(p1, v4, nil))
		else
			table.insert(t, slice(p1, v4, v10.index))
			v4 = v10.index + utf8.len(v10.match)
		end

		if v10 ~= nil then
			v5 = v10
		end
	until v10 == nil or (v6 < v4 or (if p3 == nil or p3 < 0 then MAX_SAFE_INTEGER else p3) <= #t)

	if v5 ~= nil then
		local v14, v15 = utf8.len(v5.match)

		assert(if v14 == nil then false else true, ("string `%s` has an invalid byte at position %s"):format(v5.match, (tostring(v15))))

		if v5.index + v14 == v6 + 1 then
			table.insert(t, "")
		end
	end

	return t
end