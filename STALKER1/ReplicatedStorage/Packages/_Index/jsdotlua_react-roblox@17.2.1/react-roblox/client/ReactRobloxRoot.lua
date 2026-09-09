-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"))
require(script.Parent.Parent.Parent:WaitForChild("react-reconciler"))
require(script.Parent.Parent.Parent:WaitForChild("shared"))
require(script.Parent.Parent.Parent:WaitForChild("react-reconciler"))

local ReactRobloxComponentTree = require(script.Parent:WaitForChild("ReactRobloxComponentTree"))
local markContainerAsRoot = ReactRobloxComponentTree.markContainerAsRoot
local unmarkContainerAsRoot = ReactRobloxComponentTree.unmarkContainerAsRoot
local v1 = require(script.Parent.Parent:WaitForChild("ReactReconciler.roblox"))
local createContainer = v1.createContainer
local updateContainer = v1.updateContainer
local invariant = require(script.Parent.Parent.Parent:WaitForChild("shared")).invariant
local enableEagerRootListeners = require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableEagerRootListeners
local flushSync = v1.flushSync
local flushPassiveEffects = v1.flushPassiveEffects
local BlockingRoot = v1.ReactRootTags.BlockingRoot
local ConcurrentRoot = v1.ReactRootTags.ConcurrentRoot
local LegacyRoot = v1.ReactRootTags.LegacyRoot
local v2 = nil
local t = {}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 63 | Upvalues: t (copy), v2 (ref), ConcurrentRoot (copy) ]]
	local v22 = setmetatable({}, t)

	v22._internalRoot = v2(p1, ConcurrentRoot, p2)

	return v22
end

local function createBlockingRoot(p1, p2, p3) --[[ createBlockingRoot | Line: 70 | Upvalues: t (copy), v2 (ref) ]]
	local v22 = setmetatable({}, t)

	v22._internalRoot = v2(p1, p2, p3)

	return v22
end

function t.render(p1, p2) --[[ render | Line: 82 | Upvalues: updateContainer (copy) ]]
	updateContainer(p2, p1._internalRoot, nil)
end
function t.unmount(p1) --[[ unmount | Line: 110 | Upvalues: flushSync (copy), updateContainer (copy), unmarkContainerAsRoot (copy), flushPassiveEffects (copy) ]]
	local _internalRoot = p1._internalRoot
	local containerInfo = _internalRoot.containerInfo

	flushSync(function() --[[ Line: 123 | Upvalues: updateContainer (ref), _internalRoot (copy), unmarkContainerAsRoot (ref), containerInfo (copy) ]]
		updateContainer(nil, _internalRoot, nil, function() --[[ Line: 124 | Upvalues: unmarkContainerAsRoot (ref), containerInfo (ref) ]]
			unmarkContainerAsRoot(containerInfo)
		end)
	end)
	flushPassiveEffects()
end
v2 = function(p1, p2, p3) --[[ Line: 138 | Upvalues: createContainer (copy), markContainerAsRoot (copy), enableEagerRootListeners (copy) ]]
	local v1 = if p3 == nil then false elseif p3.hydrate == true then true else false
	local v2 = if p3 == nil then nil else p3.hydrationOptions
	local _ = p3 ~= nil and p3.hydrationOptions ~= nil and p3.hydrationOptions.mutableSources or nil
	local v3 = createContainer(p1, p2, v1, v2)

	markContainerAsRoot(v3.current, p1)

	return v3
end

local t2 = {
	isValidContainer = function(p1) --[[ isValidContainer | Line: 186 ]]
		return typeof(p1) == "Instance"
	end,
	createRoot = function(p1, p2) --[[ Line: 203 | Upvalues: invariant (copy), t (copy) ]]
		invariant(if typeof(p1) == "Instance" then true else false, "createRoot(...): Target container is not a Roblox Instance.")
		warnIfReactDOMContainerInDEV(p1)

		return t.new(p1, p2)
	end,
	createBlockingRoot = function(p1, p2) --[[ Line: 214 | Upvalues: invariant (copy), BlockingRoot (copy), t (copy), v2 (ref) ]]
		invariant(if typeof(p1) == "Instance" then true else false, "createRoot(...): Target container is not a Roblox Instance.")
		warnIfReactDOMContainerInDEV(p1)

		local v5 = setmetatable({}, t)

		v5._internalRoot = v2(p1, BlockingRoot, p2)

		return v5
	end,
	createLegacyRoot = function(p1, p2) --[[ Line: 224 | Upvalues: LegacyRoot (copy), t (copy), v2 (ref) ]]
		local v3 = setmetatable({}, t)

		v3._internalRoot = v2(p1, LegacyRoot, p2)

		return v3
	end
}

function warnIfReactDOMContainerInDEV(p1) --[[ warnIfReactDOMContainerInDEV | Line: 228 ]]
	local __DEV__ = _G.__DEV__
end

return t2