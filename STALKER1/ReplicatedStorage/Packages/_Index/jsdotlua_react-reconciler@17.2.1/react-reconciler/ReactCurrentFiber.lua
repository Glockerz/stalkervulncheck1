-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__

require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals
local getStackByFiberInDevAndProd = require(script.Parent:WaitForChild("ReactFiberComponentStack")).getStackByFiberInDevAndProd
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame
local t = {
	current = nil,
	isRendering = false
}

function t.getCurrentFiberOwnerNameInDevOrNull() --[[ Line: 36 | Upvalues: __DEV__ (copy), t (copy), getComponentName (copy) ]]
	if not __DEV__ then
		return nil
	end

	if t.current == nil then
		return nil
	end

	local _debugOwner = t.current._debugOwner

	if _debugOwner then
		return getComponentName(_debugOwner.type)
	end

	return nil
end

local function getCurrentFiberStackInDev() --[[ getCurrentFiberStackInDev | Line: 50 | Upvalues: __DEV__ (copy), t (copy), getStackByFiberInDevAndProd (copy) ]]
	if not __DEV__ then
		return ""
	end

	if t.current == nil then
		return ""
	end

	return getStackByFiberInDevAndProd(t.current)
end

function t.resetCurrentFiber() --[[ Line: 63 | Upvalues: __DEV__ (copy), ReactDebugCurrentFrame (copy), t (copy) ]]
	if not __DEV__ then
		return
	end

	ReactDebugCurrentFrame.getCurrentStack = nil
	t.current = nil
	t.isRendering = false
end
function t.setCurrentFiber(p1) --[[ Line: 72 | Upvalues: __DEV__ (copy), ReactDebugCurrentFrame (copy), getCurrentFiberStackInDev (copy), t (copy) ]]
	if not __DEV__ then
		return
	end

	ReactDebugCurrentFrame.getCurrentStack = getCurrentFiberStackInDev
	t.current = p1
	t.isRendering = false
end
function t.setIsRendering(p1) --[[ Line: 81 | Upvalues: __DEV__ (copy), t (copy) ]]
	if not __DEV__ then
		return
	end

	t.isRendering = p1
end
function t.getIsRendering() --[[ Line: 87 | Upvalues: __DEV__ (copy), t (copy) ]]
	if __DEV__ then
		return t.isRendering
	end

	return false
end

return t