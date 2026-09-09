-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

local t = {}

t.__index = t
function t.__tostring(p1) --[[ Line: 12 | Upvalues: t (copy) ]]
	return getmetatable(t).__tostring(p1)
end

local function __createError(p1) --[[ __createError | Line: 18 | Upvalues: t (copy) ]]
	local v2 = setmetatable({
		name = "Error",
		message = p1 or ""
	}, t)

	t.__captureStackTrace(v2, 4)

	return v2
end

function t.new(p1) --[[ new | Line: 27 | Upvalues: t (copy) ]]
	local v2 = setmetatable({
		name = "Error",
		message = p1 or ""
	}, t)

	t.__captureStackTrace(v2, 4)

	return v2
end
function t.captureStackTrace(p1, p2) --[[ captureStackTrace | Line: 31 | Upvalues: t (copy) ]]
	t.__captureStackTrace(p1, 3, p2)
end
function t.__captureStackTrace(p1, p2, p3) --[[ __captureStackTrace | Line: 35 | Upvalues: t (copy) ]]
	if typeof(p3) == "function" then
		local v1 = debug.traceback(nil, p2)
		local v2 = debug.info(p3, "n")
		local v5 = string.find(v1, string.gsub(debug.info(p3, "s"), "([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1") .. ":%d* function " .. v2)
		local v6

		if v5 == nil then
			v6 = nil
		else
			local _, v7 = string.find(v1, "\n", v5 + 1)

			v6 = v7
		end

		if v6 ~= nil then
			v1 = string.sub(v1, v6 + 1)
		end

		p1.__stack = v1
	else
		p1.__stack = debug.traceback(nil, p2)
	end

	t.__recalculateStacktrace(p1)
end
function t.__recalculateStacktrace(p1) --[[ __recalculateStacktrace | Line: 59 ]]
	local message = p1.message

	p1.stack = ((p1.name or "Error") .. (if message == nil or message == "" then "" else ": " .. message)) .. "\n" .. (if p1.__stack then p1.__stack else "")
end

return setmetatable(t, {
	__call = function(p1, ...) --[[ __call | Line: 71 | Upvalues: t (copy) ]]
		local v2 = setmetatable({
			name = "Error",
			message = ... or ""
		}, t)

		t.__captureStackTrace(v2, 4)

		return v2
	end,
	__tostring = function(p1) --[[ __tostring | Line: 74 ]]
		if p1.name == nil then
			return tostring("Error")
		end

		if p1.message and p1.message ~= "" then
			return string.format("%s: %s", tostring(p1.name), (tostring(p1.message)))
		end

		return tostring(p1.name)
	end
})