-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Error = v1.Error
local inspect = v1.util.inspect

return {
	__ERROR_DIVIDER = "\n------ Error caught by React ------\n",
	describeError = function(p1) --[[ describeError | Line: 33 | Upvalues: v1 (copy) ]]
		if typeof(p1) ~= "string" then
			return p1
		end

		local _, v12 = string.find(p1, ":[%d]+: ")
		local v3 = v1.Error.new(if v12 then string.sub(p1, v12 + 1) else p1)

		v3.stack = debug.traceback(nil, 2)

		return v3
	end,
	errorToString = function(p1) --[[ errorToString | Line: 53 | Upvalues: inspect (copy) ]]
		if typeof(p1) ~= "table" then
			return inspect(p1)
		end

		if p1.message and p1.stack then
			return "\n------ Error caught by React ------\n" .. p1.message .. "\n------ Error caught by React ------\n" .. tostring(p1.stack)
		end

		return inspect(p1)
	end,
	parseReactError = function(p1) --[[ parseReactError | Line: 79 | Upvalues: Error (copy) ]]
		local v1 = string.split(p1, "\n------ Error caught by React ------\n")

		if #v1 == 3 then
			local v2, v3, v4 = table.unpack(v1)
			local v5 = Error.new(v3)

			v5.stack = v4

			return v5, v2
		end

		local v6 = Error.new(p1)

		v6.stack = nil

		return v6, ""
	end
}