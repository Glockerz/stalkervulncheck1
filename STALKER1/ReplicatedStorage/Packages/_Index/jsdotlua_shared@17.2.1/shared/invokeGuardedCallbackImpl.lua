-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local describeError = require(script.Parent:WaitForChild("ErrorHandling.roblox")).describeError

local function invokeGuardedCallbackProd(p1, p2, p3, p4, ...) --[[ invokeGuardedCallbackProd | Line: 15 | Upvalues: describeError (copy) ]]
	local v1 = nil
	local v2

	if _G.__YOLO__ then
		v2 = true

		if p4 == nil then
			p3(...)
		else
			p3(p4, ...)
		end
	elseif p4 == nil then
		local ok, result = xpcall(p3, describeError, ...)

		v2 = ok
		v1 = result
	else
		local ok, result = xpcall(p3, describeError, p4, ...)

		v2 = ok
		v1 = result
	end

	if v2 then
		return
	end

	p1.onError(v1)
end

local __DEV__ = _G.__DEV__

return invokeGuardedCallbackProd