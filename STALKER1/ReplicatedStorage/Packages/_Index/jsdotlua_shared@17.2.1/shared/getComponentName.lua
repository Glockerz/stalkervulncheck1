-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent:WaitForChild("console"))
local ReactSymbols = require(script.Parent:WaitForChild("ReactSymbols"))
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_PROFILER_TYPE = ReactSymbols.REACT_PROFILER_TYPE
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE
local REACT_STRICT_MODE_TYPE = ReactSymbols.REACT_STRICT_MODE_TYPE
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE
local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE

require(script.Parent:WaitForChild("ReactTypes"))

local describeError = require(script.Parent:WaitForChild("ErrorHandling.roblox")).describeError

local function getWrappedName(p1, p2, p3) --[[ getWrappedName | Line: 40 ]]
	local v1 = if typeof(p2) == "table" then p2.displayName or (p2.name or "") else "<function>"

	return p1.displayName or (v1 ~= "" and string.format("%s(%s)", p3, v1) or p3)
end

local function getContextName(p1) --[[ getContextName | Line: 53 ]]
	return p1.displayName or "Context"
end

local function v1(p1) --[[ getComponentName | Line: 57 | Upvalues: console (copy), REACT_FRAGMENT_TYPE (copy), REACT_PORTAL_TYPE (copy), REACT_PROFILER_TYPE (copy), REACT_STRICT_MODE_TYPE (copy), REACT_SUSPENSE_TYPE (copy), REACT_SUSPENSE_LIST_TYPE (copy), REACT_CONTEXT_TYPE (copy), REACT_PROVIDER_TYPE (copy), REACT_FORWARD_REF_TYPE (copy), REACT_MEMO_TYPE (copy), v1 (copy), REACT_BLOCK_TYPE (copy), REACT_LAZY_TYPE (copy), describeError (copy) ]]
	if p1 == nil then
		return nil
	end

	local v12 = typeof(p1)

	if _G.__DEV__ and v12 == "table" and typeof(p1.tag) == "number" then
		console.warn("Received an unexpected object in getComponentName(). This is likely a bug in React. Please file an issue.")
	end

	if v12 == "function" then
		local v2 = debug.info(p1, "n")

		if v2 and string.len(v2) > 0 then
			return v2
		end

		return nil
	end

	if v12 == "string" then
		return p1
	end

	if p1 == REACT_FRAGMENT_TYPE then
		return "Fragment"
	end

	if p1 == REACT_PORTAL_TYPE then
		return "Portal"
	end

	if p1 == REACT_PROFILER_TYPE then
		return "Profiler"
	end

	if p1 == REACT_STRICT_MODE_TYPE then
		return "StrictMode"
	end

	if p1 == REACT_SUSPENSE_TYPE then
		return "Suspense"
	end

	if p1 == REACT_SUSPENSE_LIST_TYPE then
		return "SuspenseList"
	end

	if v12 ~= "table" then
		return nil
	end

	local v3 = p1["$$typeof"]

	if v3 == REACT_CONTEXT_TYPE then
		return (p1.displayName or "Context") .. ".Consumer"
	end

	if v3 == REACT_PROVIDER_TYPE then
		return (p1._context.displayName or "Context") .. ".Provider"
	end

	if v3 == REACT_FORWARD_REF_TYPE then
		local render = p1.render
		local v4 = if typeof(render) == "table" then render.displayName or (render.name or "") else "<function>"
		local displayName = p1.displayName

		if not displayName and v4 == "" then
			displayName = "ForwardRef"
		elseif not displayName then
			local v6 = string.format("%s(%s)", "ForwardRef", v4)

			displayName = if v6 then v6 else "ForwardRef"
		end

		return displayName
	end

	if v3 == REACT_MEMO_TYPE then
		return v1(p1.type)
	end

	if v3 == REACT_BLOCK_TYPE then
		return v1(p1._render)
	end

	if v3 == REACT_LAZY_TYPE then
		local ok, result = xpcall(p1._init, describeError, p1._payload)

		if ok then
			return v1(result)
		end

		return nil
	end

	if p1.displayName then
		return p1.displayName
	end

	if p1.name then
		return p1.name
	end

	local v7 = getmetatable(p1)

	if v7 and rawget(v7, "__tostring") then
		return tostring(p1)
	end

	return nil
end

return v1