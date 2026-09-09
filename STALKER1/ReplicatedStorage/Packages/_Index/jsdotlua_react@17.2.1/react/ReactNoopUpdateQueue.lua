-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local t = {}

local function warnNoop(p1, p2) --[[ warnNoop | Line: 14 | Upvalues: t (copy), console (copy) ]]
	if not _G.__DEV__ then
		return
	end

	local v1 = p1.__componentName or "ReactClass"
	local v2 = v1 .. "." .. p2

	if t[v2] then
		return
	end

	console.error("Can\'t call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component\'s `init` method.", p2, v1)
	t[v2] = true
end

return {
	isMounted = function(p1) --[[ isMounted | Line: 49 ]]
		return false
	end,
	enqueueForceUpdate = function(p1, p2, p3) --[[ enqueueForceUpdate | Line: 67 | Upvalues: t (copy), console (copy) ]]
		if not _G.__DEV__ then
			return
		end

		local v1 = p1.__componentName or "ReactClass"
		local v2 = v1 .. ".forceUpdate"

		if t[v2] then
			return
		end

		console.error("Can\'t call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component\'s `init` method.", "forceUpdate", v1)
		t[v2] = true
	end,
	enqueueReplaceState = function(p1, p2, p3, p4) --[[ enqueueReplaceState | Line: 83 | Upvalues: t (copy), console (copy) ]]
		if not _G.__DEV__ then
			return
		end

		local v1 = p1.__componentName or "ReactClass"
		local v2 = v1 .. ".replaceState"

		if t[v2] then
			return
		end

		console.error("Can\'t call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component\'s `init` method.", "replaceState", v1)
		t[v2] = true
	end,
	enqueueSetState = function(p1, p2, p3, p4) --[[ enqueueSetState | Line: 98 | Upvalues: t (copy), console (copy) ]]
		if not _G.__DEV__ then
			return
		end

		local v1 = p1.__componentName or "ReactClass"
		local v2 = v1 .. ".setState"

		if t[v2] then
			return
		end

		console.error("Can\'t call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component\'s `init` method.", "setState", v1)
		t[v2] = true
	end
}