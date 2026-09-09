-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local invariant = require(script.Parent:WaitForChild("invariant"))
local invokeGuardedCallbackImpl = require(script.Parent:WaitForChild("invokeGuardedCallbackImpl"))
local v1 = nil
local v2 = false
local v3 = nil
local v4 = false
local v5 = nil
local t = {
	onError = function(p1) --[[ onError | Line: 25 | Upvalues: v2 (ref), v3 (ref) ]]
		v2 = true
		v3 = p1
	end
}
local t2 = {
	invokeGuardedCallback = function(...) --[[ Line: 45 | Upvalues: v2 (ref), v3 (ref), invokeGuardedCallbackImpl (copy), t (copy) ]]
		v2 = false
		v3 = nil
		invokeGuardedCallbackImpl(t, ...)
	end
}

function t2.invokeGuardedCallbackAndCatchFirstError(...) --[[ Line: 62 | Upvalues: t2 (copy), v2 (ref), v1 (ref), v4 (ref), v5 (ref) ]]
	t2.invokeGuardedCallback(...)

	if not v2 then
		return
	end

	local v12 = v1()

	if v4 then
		return
	end

	v4 = true
	v5 = v12
end
function t2.rethrowCaughtError() --[[ Line: 80 | Upvalues: v4 (ref), v5 (ref) ]]
	if not v4 then
		return
	end

	local v1 = v5

	v4 = false
	v5 = nil
	error(v1)
end
function t2.hasCaughtError() --[[ Line: 89 | Upvalues: v2 (ref) ]]
	return v2
end
v1 = function() --[[ Line: 93 | Upvalues: v2 (ref), v3 (ref), invariant (copy) ]]
	if v2 then
		local v1 = v3

		v2 = false
		v3 = nil

		return v1
	end

	invariant(false, "clearCaughtError was called but no error was captured. This error is likely caused by a bug in React. Please file an issue.")

	return nil
end
t2.clearCaughtError = v1

return t2