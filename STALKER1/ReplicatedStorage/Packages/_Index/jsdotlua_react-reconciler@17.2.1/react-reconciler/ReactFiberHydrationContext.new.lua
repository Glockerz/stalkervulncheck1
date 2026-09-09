-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console

local function unimplemented(p1) --[[ unimplemented | Line: 16 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. p1)
	error("FIXME (roblox): " .. p1 .. " is unimplemented", 2)
end

require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"))

require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"))

local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local HostComponent = ReactWorkTags.HostComponent
local HostText = ReactWorkTags.HostText
local HostRoot = ReactWorkTags.HostRoot
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local Placement = ReactFiberFlags.Placement
local Hydrating = ReactFiberFlags.Hydrating
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local createFiberFromDehydratedFragment = require(script.Parent:WaitForChild("ReactFiber.new")).createFiberFromDehydratedFragment
local supportsHydration = ReactFiberHostConfig.supportsHydration
local getNextHydratableSibling = ReactFiberHostConfig.getNextHydratableSibling
local getFirstHydratableChild = ReactFiberHostConfig.getFirstHydratableChild
local canHydrateInstance = ReactFiberHostConfig.canHydrateInstance
local canHydrateTextInstance = ReactFiberHostConfig.canHydrateTextInstance
local canHydrateSuspenseInstance = ReactFiberHostConfig.canHydrateSuspenseInstance
local hydrateInstance = ReactFiberHostConfig.hydrateInstance
local hydrateTextInstance = ReactFiberHostConfig.hydrateTextInstance
local hydrateSuspenseInstance = ReactFiberHostConfig.hydrateSuspenseInstance
local getNextHydratableInstanceAfterSuspenseInstance = ReactFiberHostConfig.getNextHydratableInstanceAfterSuspenseInstance
local didNotMatchHydratedContainerTextInstance = ReactFiberHostConfig.didNotMatchHydratedContainerTextInstance
local didNotMatchHydratedTextInstance = ReactFiberHostConfig.didNotMatchHydratedTextInstance
local shouldSetTextContent = ReactFiberHostConfig.shouldSetTextContent
local enableSuspenseServerRenderer = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSuspenseServerRenderer
local OffscreenLane = require(script.Parent:WaitForChild("ReactFiberLane")).OffscreenLane
local v1 = nil
local v2 = nil
local v3 = false

function warnIfHydrating() --[[ warnIfHydrating | Line: 89 | Upvalues: v3 (ref), console (copy) ]]
	if not (_G.__DEV__ and v3) then
		return
	end

	console.error("We should not be hydrating here. This is a bug in React. Please file a bug.")
end
function enterHydrationState(p1) --[[ enterHydrationState | Line: 99 | Upvalues: supportsHydration (copy), v2 (ref), getFirstHydratableChild (copy), v1 (ref), v3 (ref) ]]
	if supportsHydration then
		v2 = getFirstHydratableChild(p1.stateNode.containerInfo)
		v1 = p1
		v3 = true

		return true
	end

	return false
end
function reenterHydrationStateFromDehydratedSuspenseInstance(p1, p2) --[[ reenterHydrationStateFromDehydratedSuspenseInstance | Line: 111 | Upvalues: supportsHydration (copy), v2 (ref), getNextHydratableSibling (copy), v3 (ref) ]]
	if supportsHydration then
		v2 = getNextHydratableSibling(p2)
		popToNextHostParent(p1)
		v3 = true

		return true
	end

	return false
end
function deleteHydratableInstance(p1, p2) --[[ deleteHydratableInstance | Line: 125 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: deleteHydratableInstance")
	error("FIXME (roblox): deleteHydratableInstance is unimplemented", 2)
end
function insertNonHydratedInstance(p1, p2) --[[ insertNonHydratedInstance | Line: 160 | Upvalues: Hydrating (copy), Placement (copy) ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: insertNonHydratedInstance")
	error("FIXME (roblox): insertNonHydratedInstance is unimplemented", 2)
end
function tryHydrate(p1, p2) --[[ tryHydrate | Line: 224 | Upvalues: HostComponent (copy), canHydrateInstance (copy), HostText (copy), canHydrateTextInstance (copy), SuspenseComponent (copy), enableSuspenseServerRenderer (copy), canHydrateSuspenseInstance (copy), OffscreenLane (copy), createFiberFromDehydratedFragment (copy) ]]
	if p1.tag == HostComponent then
		local v1 = canHydrateInstance(p2, p1.type, p1.pendingProps)

		if v1 == nil then
			return false
		end

		p1.stateNode = v1

		return true
	end

	if p1.tag == HostText then
		local v2 = canHydrateTextInstance(p2, p1.pendingProps)

		if v2 == nil then
			return false
		end

		p1.stateNode = v2

		return true
	end

	if p1.tag ~= SuspenseComponent then
		return false
	end

	if not enableSuspenseServerRenderer then
		return false
	end

	local v3 = canHydrateSuspenseInstance(p2)

	if v3 == nil then
		return false
	end

	p1.memoizedState = {
		dehydrated = v3,
		retryLane = OffscreenLane
	}

	local v4 = createFiberFromDehydratedFragment(v3)

	v4.return_ = p1
	p1.child = v4

	return true
end
function tryToClaimNextHydratableInstance(p1) --[[ tryToClaimNextHydratableInstance | Line: 269 | Upvalues: v3 (ref), v2 (ref), v1 (ref), getNextHydratableSibling (copy), getFirstHydratableChild (copy) ]]
	if not v3 then
		return
	end

	local v12 = v2

	if not v12 then
		insertNonHydratedInstance(v1, p1)
		v3 = false
		v1 = p1

		return
	end

	if not tryHydrate(p1, v12) then
		local v22 = getNextHydratableSibling(v12)

		if v22 and tryHydrate(p1, v22) then
			deleteHydratableInstance(v1, v12)
			v12 = v22
		else
			insertNonHydratedInstance(v1, p1)
			v3 = false
			v1 = p1

			return
		end
	end

	v1 = p1
	v2 = getFirstHydratableChild(v12)
end
function prepareToHydrateHostInstance(p1, p2, p3) --[[ prepareToHydrateHostInstance | Line: 305 | Upvalues: supportsHydration (copy), invariant (copy), hydrateInstance (copy) ]]
	local v1

	if supportsHydration then
		v1 = hydrateInstance(p1.stateNode, p1.type, p1.memoizedProps, p2, p3, p1)
		p1.updateQueue = v1

		return v1 ~= nil
	end

	invariant(false, "Expected prepareToHydrateHostInstance() to never be called. This error is likely caused by a bug in React. Please file an issue.")
	v1 = hydrateInstance(p1.stateNode, p1.type, p1.memoizedProps, p2, p3, p1)
	p1.updateQueue = v1

	return v1 ~= nil
end
function prepareToHydrateHostTextInstance(p1) --[[ prepareToHydrateHostTextInstance | Line: 337 | Upvalues: supportsHydration (copy), invariant (copy), hydrateTextInstance (copy), v1 (ref), HostRoot (copy), didNotMatchHydratedContainerTextInstance (copy), HostComponent (copy), didNotMatchHydratedTextInstance (copy) ]]
	if not supportsHydration then
		invariant(false, "Expected prepareToHydrateHostTextInstance() to never be called. This error is likely caused by a bug in React. Please file an issue.")
	end

	local stateNode = p1.stateNode
	local memoizedProps = p1.memoizedProps
	local v12 = hydrateTextInstance(stateNode, memoizedProps, p1)

	if _G.__DEV__ and v12 then
		local v2 = v1

		if v2 ~= nil then
			if v2.tag == HostRoot then
				didNotMatchHydratedContainerTextInstance(v2.stateNode.containerInfo, stateNode, memoizedProps)

				return v12
			end

			if v2.tag == HostComponent then
				didNotMatchHydratedTextInstance(v2.type, v2.memoizedProps, v2.stateNode, stateNode, memoizedProps)
			end
		end
	end

	return v12
end
function prepareToHydrateHostSuspenseInstance(p1) --[[ prepareToHydrateHostSuspenseInstance | Line: 380 | Upvalues: supportsHydration (copy), invariant (copy), hydrateSuspenseInstance (copy) ]]
	if not supportsHydration then
		invariant(false, "Expected prepareToHydrateHostSuspenseInstance() to never be called. This error is likely caused by a bug in React. Please file an issue.")
	end

	local memoizedState = p1.memoizedState
	local v1 = if memoizedState == nil then nil else memoizedState.dehydrated

	invariant(v1, "Expected to have a hydrated suspense instance. This error is likely caused by a bug in React. Please file an issue.")
	hydrateSuspenseInstance(v1, p1)
end
function skipPastDehydratedSuspenseInstance(p1) --[[ skipPastDehydratedSuspenseInstance | Line: 405 | Upvalues: supportsHydration (copy), invariant (copy), getNextHydratableInstanceAfterSuspenseInstance (copy) ]]
	if not supportsHydration then
		invariant(false, "Expected skipPastDehydratedSuspenseInstance() to never be called. This error is likely caused by a bug in React. Please file an issue.")
	end

	local memoizedState = p1.memoizedState
	local v1 = if memoizedState == nil then nil else memoizedState.dehydrated

	invariant(v1, "Expected to have a hydrated suspense instance. This error is likely caused by a bug in React. Please file an issue.")

	return getNextHydratableInstanceAfterSuspenseInstance(v1)
end
function popToNextHostParent(p1) --[[ popToNextHostParent | Line: 428 | Upvalues: HostComponent (copy), HostRoot (copy), SuspenseComponent (copy), v1 (ref) ]]
	local return_ = p1.return_

	while return_ ~= nil and (return_.tag ~= HostComponent and (return_.tag ~= HostRoot and return_.tag ~= SuspenseComponent)) do
		return_ = return_.return_
	end

	v1 = return_
end
function popHydrationState(p1) --[[ popHydrationState | Line: 441 | Upvalues: supportsHydration (copy), v1 (ref), v3 (ref), HostComponent (copy), shouldSetTextContent (copy), v2 (ref), getNextHydratableSibling (copy), SuspenseComponent (copy) ]]
	if not supportsHydration then
		return false
	end

	if p1 ~= v1 then
		return false
	end

	if not v3 then
		popToNextHostParent(p1)
		v3 = true

		return false
	end

	local v12 = p1.type

	if p1.tag ~= HostComponent or v12 ~= "head" and (v12 ~= "body" and not shouldSetTextContent(v12, p1.memoizedProps)) then
		local v22 = v2

		while v22 do
			deleteHydratableInstance(p1, v22)
			v22 = getNextHydratableSibling(v22)
		end
	end

	popToNextHostParent(p1)
	v2 = if p1.tag == SuspenseComponent then skipPastDehydratedSuspenseInstance(p1) elseif v1 then getNextHydratableSibling(p1.stateNode) else nil

	return true
end
function resetHydrationState() --[[ resetHydrationState | Line: 494 | Upvalues: supportsHydration (copy), v1 (ref), v2 (ref), v3 (ref) ]]
	if supportsHydration then
		v1 = nil
		v2 = nil
		v3 = false
	end
end
function getIsHydrating() --[[ getIsHydrating | Line: 504 | Upvalues: v3 (ref) ]]
	return v3
end

return {
	warnIfHydrating = warnIfHydrating,
	enterHydrationState = enterHydrationState,
	getIsHydrating = getIsHydrating,
	reenterHydrationStateFromDehydratedSuspenseInstance = reenterHydrationStateFromDehydratedSuspenseInstance,
	resetHydrationState = resetHydrationState,
	tryToClaimNextHydratableInstance = tryToClaimNextHydratableInstance,
	prepareToHydrateHostInstance = prepareToHydrateHostInstance,
	prepareToHydrateHostTextInstance = prepareToHydrateHostTextInstance,
	prepareToHydrateHostSuspenseInstance = prepareToHydrateHostSuspenseInstance,
	popHydrationState = popHydrationState
}