-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent.Parent:WaitForChild("luau-polyfill"))

local t = {}

local function isCallable(p1) --[[ isCallable | Line: 27 ]]
	if typeof(p1) == "function" then
		return true
	end

	if typeof(p1) ~= "table" then
		return false
	end

	local v1 = getmetatable(p1)

	if v1 and rawget(v1, "__call") then
		return true
	end

	if p1._isMockFunction then
		return true
	end

	return false
end

local enableProfilerTimer = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableProfilerTimer

require(script.Parent:WaitForChild("ReactInternalTypes"))
require(script.Parent.Parent:WaitForChild("shared"))

local DidCapture = require(script.Parent:WaitForChild("ReactFiberFlags")).DidCapture
local v1 = nil
local v2 = nil
local v3 = false

function t.isDevToolsPresent() --[[ Line: 63 ]]
	return _G.__REACT_DEVTOOLS_GLOBAL_HOOK__ ~= nil
end
function t.injectInternals(p1) --[[ Line: 67 | Upvalues: console (copy), v1 (ref), v2 (ref) ]]
	if _G.__REACT_DEVTOOLS_GLOBAL_HOOK__ == nil then
		return false
	end

	local __REACT_DEVTOOLS_GLOBAL_HOOK__ = _G.__REACT_DEVTOOLS_GLOBAL_HOOK__

	if __REACT_DEVTOOLS_GLOBAL_HOOK__.isDisabled then
		return true
	end

	if __REACT_DEVTOOLS_GLOBAL_HOOK__.supportsFiber then
		local ok, result = pcall(function() --[[ Line: 90 | Upvalues: v1 (ref), __REACT_DEVTOOLS_GLOBAL_HOOK__ (copy), p1 (copy), v2 (ref) ]]
			v1 = __REACT_DEVTOOLS_GLOBAL_HOOK__.inject(p1)
			v2 = __REACT_DEVTOOLS_GLOBAL_HOOK__
		end)

		if ok or not _G.__DEV__ then
			return true
		end

		console.error("React instrumentation encountered an error: %s.", result)
	else
		if not _G.__DEV__ then
			return true
		end

		console.error("The installed version of React DevTools is too old and will not work with the current version of React. Please update React DevTools. https://reactjs.org/link/react-devtools")
	end

	return true
end
function t.onScheduleRoot(p1, p2) --[[ Line: 106 | Upvalues: v2 (ref), v1 (ref), v3 (ref), console (copy) ]]
	if not (_G.__DEV__ and v2) then
		return
	end

	local onScheduleFiberRoot = v2.onScheduleFiberRoot
	local v12

	if typeof(onScheduleFiberRoot) == "function" then
		v12 = true
	elseif typeof(onScheduleFiberRoot) == "table" then
		local v22 = getmetatable(onScheduleFiberRoot)

		v12 = (v22 and rawget(v22, "__call") or onScheduleFiberRoot._isMockFunction) and true or false
	else
		v12 = false
	end

	if not v12 then
		return
	end

	local ok, result = pcall(v2.onScheduleFiberRoot, v1, p1, p2)

	if ok or (not _G.__DEV__ or v3) then
		return
	end

	v3 = true
	console.error("React instrumentation encountered an error: %s", result)
end
function t.onCommitRoot(p1, p2) --[[ Line: 126 | Upvalues: v2 (ref), DidCapture (copy), enableProfilerTimer (copy), v1 (ref), v3 (ref), console (copy) ]]
	if not v2 then
		return
	end

	local onCommitFiberRoot = v2.onCommitFiberRoot
	local v12

	if typeof(onCommitFiberRoot) == "function" then
		v12 = true
	elseif typeof(onCommitFiberRoot) == "table" then
		local v22 = getmetatable(onCommitFiberRoot)

		v12 = (v22 and rawget(v22, "__call") or onCommitFiberRoot._isMockFunction) and true or false
	else
		v12 = false
	end

	if not v12 then
		return
	end

	local ok, result = pcall(function() --[[ Line: 132 | Upvalues: p1 (copy), DidCapture (ref), enableProfilerTimer (ref), v2 (ref), v1 (ref), p2 (copy) ]]
		local v22 = bit32.band(p1.current.flags, DidCapture) == DidCapture

		if enableProfilerTimer then
			v2.onCommitFiberRoot(v1, p1, p2, v22)
		else
			v2.onCommitFiberRoot(v1, p1, nil, v22)
		end
	end)

	if ok or (not _G.__DEV__ or v3) then
		return
	end

	v3 = true
	console.error("React instrumentation encountered an error: %s", result)
end
function t.onCommitUnmount(p1) --[[ Line: 151 | Upvalues: v2 (ref), v1 (ref), v3 (ref), console (copy) ]]
	if not v2 then
		return
	end

	local onCommitFiberUnmount = v2.onCommitFiberUnmount
	local v12

	if typeof(onCommitFiberUnmount) == "function" then
		v12 = true
	elseif typeof(onCommitFiberUnmount) == "table" then
		local v22 = getmetatable(onCommitFiberUnmount)

		v12 = (v22 and rawget(v22, "__call") or onCommitFiberUnmount._isMockFunction) and true or false
	else
		v12 = false
	end

	if not v12 then
		return
	end

	local ok, result = pcall(v2.onCommitFiberUnmount, v1, p1)

	if ok or (not _G.__DEV__ or v3) then
		return
	end

	v3 = true
	console.error("React instrumentation encountered an error: %s", result)
end

return t