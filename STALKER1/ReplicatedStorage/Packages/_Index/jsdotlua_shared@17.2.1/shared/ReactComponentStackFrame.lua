-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("ReactElementType"))
require(script.Parent:WaitForChild("flowtypes.roblox"))

local ReactSymbols = require(script.Parent:WaitForChild("ReactSymbols"))
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE
local v1 = require(script.Parent:WaitForChild("ConsolePatchingDev.roblox"))
local disableLogs = v1.disableLogs
local reenableLogs = v1.reenableLogs
local ReactCurrentDispatcher = require(script.Parent:WaitForChild("ReactSharedInternals")).ReactCurrentDispatcher
local v2 = nil

local function describeOwner(p1) --[[ describeOwner | Line: 57 ]]
	if type(p1) == "function" then
		return debug.info(p1, "n")
	end

	if type(p1) == "table" then
		return tostring(p1)
	end

	return nil
end

local function describeBuiltInComponentFrame(p1, p2, p3) --[[ describeBuiltInComponentFrame | Line: 66 | Upvalues: v2 (ref) ]]
	return v2(p1, p2, if _G.__DEV__ and p3 then if type(p3) == "function" then debug.info(p3, "n") elseif type(p3) == "table" then tostring(p3) else nil else nil)
end

local v3 = false
local v4 = if _G.__DEV__ then setmetatable({}, {
	__mode = "k"
}) else nil

local function describeNativeComponentFrame(p1, p2) --[[ describeNativeComponentFrame | Line: 113 | Upvalues: v3 (ref), v4 (ref), ReactCurrentDispatcher (copy), disableLogs (copy), reenableLogs (copy), v2 (ref) ]]
	if not p1 or v3 then
		return ""
	end

	if _G.__DEV__ then
		local v1 = v4[p1]

		if v1 ~= nil then
			return v1
		end
	end

	local v22 = nil

	v3 = true

	local v32

	if _G.__DEV__ then
		v32 = ReactCurrentDispatcher.current
		ReactCurrentDispatcher.current = nil
		disableLogs()
	else
		v32 = nil
	end

	local v42 = nil
	local _, result = xpcall(function() --[[ Line: 153 | Upvalues: p2 (copy), v42 (ref), v22 (ref), p1 (copy) ]]
		if not p2 then
			local _, result = pcall(function() --[[ Line: 159 | Upvalues: v42 (ref) ]]
				v42 = debug.traceback()
				error({
					stack = v42
				})
			end)

			v22 = result
			p1()
		end
	end, function(p1) --[[ Line: 169 | Upvalues: v42 (ref) ]]
		return {
			message = p1,
			stack = v42
		}
	end)
	local v5 = nil
	local v6, v7, _2, v8

	if result and v22 and type(result.stack) == "string" then
		local v9 = string.split(result.stack, "\n")
		local v10 = string.split(v22.stack, "\n")
		local count = #v9 - 1
		local count2 = #v10 - 1

		while count >= 2 and (count2 >= 0 and v9[count] ~= v10[count2]) do
			count2 = count2 - 1
		end

		repeat
			if not (count >= 3 and count2 >= 1) then
				v3 = false

				if _G.__DEV__ then
					ReactCurrentDispatcher.current = v32
					reenableLogs()
				end

				if v5 ~= nil then
					return v5
				end

				v6 = if type(p1) == "function" then debug.info(p1, "n") elseif type(p1) == "table" then tostring(p1) else ""

				if v6 == nil or v6 == "" then
					v7 = ""
				else
					_2 = _G.__DEV__
					v8 = v2(v6, nil, nil)
					v7 = v8
				end

				if _G.__DEV__ then
					v4[p1] = v7
				end

				return v7
			end

			count = count - 1
			count2 = count2 - 1
		until v9[count] ~= v10[count2]

		if count ~= 1 or count2 ~= 1 then
			repeat
				count = count - 1
				count2 = count2 - 1

				if count2 < 0 or v9[count] ~= v10[count2] then
					local v11 = "\n" .. "    in " .. v9[count]

					if _G.__DEV__ then
						v4[p1] = v11
					end

					v5 = v11
				end
			until not (count >= 3 and count2 >= 1)
		end
	end

	v3 = false

	if _G.__DEV__ then
		ReactCurrentDispatcher.current = v32
		reenableLogs()
	end

	if v5 ~= nil then
		return v5
	end

	v6 = if type(p1) == "function" then debug.info(p1, "n") elseif type(p1) == "table" then tostring(p1) else ""

	if v6 == nil or v6 == "" then
		v7 = ""
	else
		_2 = _G.__DEV__
		v8 = v2(v6, nil, nil)
		v7 = v8
	end

	if _G.__DEV__ then
		v4[p1] = v7
	end

	return v7
end

v2 = function(p1, p2, p3) --[[ describeComponentFrame | Line: 283 ]]
	local v1 = ""

	if _G.__DEV__ and p2 then
		local fileName = p2.fileName
		local v2 = string.gsub(fileName, "^(.*)[\\/]", "")

		if string.match(v2, "^init%.") then
			local v3 = string.match(fileName, "^(.*)[\\/]")

			if v3 and #v3 ~= 0 then
				v2 = string.gsub(v3, "^(.*)[\\/]", "") .. "/" .. v2
			end
		end

		v1 = " (at " .. v2 .. ":" .. p2.lineNumber .. ")"
	elseif p3 then
		v1 = " (created by " .. p3 .. ")"
	end

	return "\n    in " .. (p1 or "Unknown") .. v1
end

local function describeClassComponentFrame(p1, p2, p3) --[[ describeClassComponentFrame | Line: 316 | Upvalues: v2 (ref) ]]
	local v1 = tostring(p1)

	return v2(v1, p2, if _G.__DEV__ and p3 then if type(p3) == "function" then debug.info(p3, "n") elseif type(p3) == "table" then tostring(p3) else nil else nil)
end

local function describeFunctionComponentFrame(p1, p2, p3) --[[ describeFunctionComponentFrame | Line: 340 | Upvalues: v2 (ref) ]]
	if not p1 then
		return ""
	end

	local v1 = if type(p1) == "function" then debug.info(p1, "n") else tostring(p1)

	return v2(v1, p2, if _G.__DEV__ and p3 then if type(p3) == "function" then debug.info(p3, "n") elseif type(p3) == "table" then tostring(p3) else nil else nil)
end

local function v5(p1, p2, p3) --[[ describeUnknownElementTypeFrameInDEV | Line: 387 | Upvalues: describeClassComponentFrame (copy), describeFunctionComponentFrame (ref), describeBuiltInComponentFrame (copy), REACT_SUSPENSE_TYPE (copy), REACT_SUSPENSE_LIST_TYPE (copy), REACT_FORWARD_REF_TYPE (copy), REACT_MEMO_TYPE (copy), v5 (copy), REACT_BLOCK_TYPE (copy), REACT_LAZY_TYPE (copy) ]]
	if not _G.__DEV__ then
		return ""
	end

	if p1 == nil then
		return ""
	end

	if type(p1) == "table" and type(p1.__ctor) == "function" then
		return describeClassComponentFrame(p1, p2, p3)
	end

	if type(p1) == "function" then
		return describeFunctionComponentFrame(p1, p2, p3)
	end

	if type(p1) == "string" then
		return describeBuiltInComponentFrame(p1, p2, p3)
	end

	if p1 == REACT_SUSPENSE_TYPE then
		return describeBuiltInComponentFrame("Suspense", p2, p3)
	end

	if p1 == REACT_SUSPENSE_LIST_TYPE then
		return describeBuiltInComponentFrame("SuspenseList", p2, p3)
	end

	if type(p1) ~= "table" then
		return ""
	end

	local v1 = p1["$$typeof"]

	if v1 == REACT_FORWARD_REF_TYPE then
		return describeFunctionComponentFrame(p1.render, p2, p3)
	end

	if v1 == REACT_MEMO_TYPE then
		return v5(p1.type, p2, p3)
	end

	if v1 == REACT_BLOCK_TYPE then
		return describeFunctionComponentFrame(p1._render, p2, p3)
	end

	if v1 ~= REACT_LAZY_TYPE then
		return ""
	end

	local _payload = p1._payload
	local _init = p1._init
	local ok, result = pcall(function() --[[ Line: 446 | Upvalues: v5 (ref), _init (copy), _payload (copy), p2 (copy), p3 (copy) ]]
		v5(_init(_payload), p2, p3)
	end)

	if ok then
		return result
	end

	return ""
end

return {
	describeComponentFrame = v2,
	describeBuiltInComponentFrame = describeBuiltInComponentFrame,
	describeNativeComponentFrame = describeNativeComponentFrame,
	describeClassComponentFrame = describeClassComponentFrame,
	describeFunctionComponentFrame = describeFunctionComponentFrame,
	describeUnknownElementTypeFrameInDEV = v5
}