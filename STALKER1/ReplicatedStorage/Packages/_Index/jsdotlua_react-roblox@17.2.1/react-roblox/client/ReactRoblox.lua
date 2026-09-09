-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("shared"))
require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"))

local ReactRobloxRoot = require(script.Parent:WaitForChild("ReactRobloxRoot"))
local isValidContainer = ReactRobloxRoot.isValidContainer
local v1 = require(script.Parent.Parent:WaitForChild("ReactReconciler.roblox"))
local createPortal = v1.createPortal
local ReactVersion = require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactVersion
local invariant = require(script.Parent.Parent.Parent:WaitForChild("shared")).invariant
local enableNewReconciler = require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableNewReconciler
local ReactRobloxComponentTree = require(script.Parent:WaitForChild("ReactRobloxComponentTree"))
local v2 = require(script.Parent.Parent.Parent:WaitForChild("shared")).Event
local Change = require(script.Parent.Parent.Parent:WaitForChild("shared")).Change
local Tag = require(script.Parent.Parent.Parent:WaitForChild("shared")).Tag
local t = {
	createPortal = function(p1, p2, p3) --[[ createPortal | Line: 122 | Upvalues: invariant (copy), isValidContainer (copy), createPortal (copy) ]]
		invariant(isValidContainer(p2), "Target container is not a Roblox Instance.")

		return createPortal(p1, p2, nil, p3)
	end,
	unstable_batchedUpdates = v1.batchedUpdates,
	flushSync = v1.flushSync,
	__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = {
		Events = {
			getInstanceFromNode = ReactRobloxComponentTree.getInstanceFromNode,
			getNodeFromInstance = ReactRobloxComponentTree.getNodeFromInstance,
			getFiberCurrentPropsFromNode = ReactRobloxComponentTree.getFiberCurrentPropsFromNode,
			flushPassiveEffects = v1.flushPassiveEffects,
			IsThisRendererActing = v1.IsThisRendererActing
		}
	},
	version = ReactVersion,
	createRoot = ReactRobloxRoot.createRoot,
	createBlockingRoot = ReactRobloxRoot.createBlockingRoot,
	createLegacyRoot = ReactRobloxRoot.createLegacyRoot,
	Event = v2,
	Change = Change,
	Tag = Tag,
	unstable_isNewReconciler = enableNewReconciler,
	act = function(p1) --[[ act | Line: 255 ]]
		error("ReactRoblox.act is only available in testing environments, not production. Enable the `__ROACT_17_MOCK_SCHEDULER__` global in your test configuration in order to use `act`.")
	end
}

if _G.__ROACT_17_MOCK_SCHEDULER__ then
	t.act = v1.act
end

local t2 = {
	rendererPackageName = "ReactRoblox",
	findFiberByHostInstance = ReactRobloxComponentTree.getClosestInstanceFromNode
}

t2.bundleType = if _G.__DEV__ then 1 else 0
t2.version = ReactVersion
v1.injectIntoDevTools(t2)

local __DEV__ = _G.__DEV__

t.robloxReactProfiling = v1.robloxReactProfiling

return t