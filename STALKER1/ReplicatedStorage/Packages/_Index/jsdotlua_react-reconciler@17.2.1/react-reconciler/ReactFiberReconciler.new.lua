-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__

require(script.Parent.Parent:WaitForChild("shared"))

local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Array = v1.Array
local Object = v1.Object
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactRootTags = require(script.Parent:WaitForChild("ReactRootTags"))
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))

require(script.Parent:WaitForChild("ReactFiberHostConfig"))

local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local FundamentalComponent = ReactWorkTags.FundamentalComponent

require(script.Parent.Parent:WaitForChild("shared"))

local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))

require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"))

local ReactFiberTreeReflection = require(script.Parent:WaitForChild("ReactFiberTreeReflection"))
local findCurrentHostFiber = ReactFiberTreeReflection.findCurrentHostFiber
local findCurrentHostFiberWithNoPortals = ReactFiberTreeReflection.findCurrentHostFiberWithNoPortals
local get = require(script.Parent.Parent:WaitForChild("shared")).ReactInstanceMap.get
local HostComponent = ReactWorkTags.HostComponent
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError
local enableSchedulingProfiler = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSchedulingProfiler
local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals
local getPublicInstance = require(script.Parent:WaitForChild("ReactFiberHostConfig")).getPublicInstance
local v2 = require(script.Parent:WaitForChild("ReactFiberContext.new"))
local findCurrentUnmaskedContext = v2.findCurrentUnmaskedContext
local processChildContext = v2.processChildContext
local emptyContextObject = v2.emptyContextObject
local isContextProvider = v2.isContextProvider
local createFiberRoot = require(script.Parent:WaitForChild("ReactFiberRoot.new")).createFiberRoot
local v3 = require(script.Parent:WaitForChild("ReactFiberDevToolsHook.new"))
local injectInternals = v3.injectInternals
local onScheduleRoot = v3.onScheduleRoot
local v4 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
local requestEventTime = v4.requestEventTime
local requestUpdateLane = v4.requestUpdateLane
local scheduleUpdateOnFiber = v4.scheduleUpdateOnFiber
local flushRoot = v4.flushRoot
local flushSync = v4.flushSync
local warnIfNotScopedWithMatchingAct = v4.warnIfNotScopedWithMatchingAct
local warnIfUnmockedScheduler = v4.warnIfUnmockedScheduler
local v5 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"))
local createUpdate = v5.createUpdate
local enqueueUpdate = v5.enqueueUpdate
local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"))
local isRendering = ReactCurrentFiber.isRendering
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"))
local StrictMode = ReactTypeOfMode.StrictMode
local SyncLane = ReactFiberLane.SyncLane
local InputDiscreteHydrationLane = ReactFiberLane.InputDiscreteHydrationLane
local SelectiveHydrationLane = ReactFiberLane.SelectiveHydrationLane
local NoTimestamp = ReactFiberLane.NoTimestamp
local getHighestPriorityPendingLanes = ReactFiberLane.getHighestPriorityPendingLanes
local higherPriorityLane = ReactFiberLane.higherPriorityLane
local getCurrentUpdateLanePriority = ReactFiberLane.getCurrentUpdateLanePriority
local setCurrentUpdateLanePriority = ReactFiberLane.setCurrentUpdateLanePriority
local markRenderScheduled = require(script.Parent:WaitForChild("SchedulingProfiler")).markRenderScheduled
local t = {
	ReactRootTags = ReactRootTags,
	ReactWorkTags = ReactWorkTags,
	ReactTypeOfMode = ReactTypeOfMode,
	ReactFiberFlags = ReactFiberFlags,
	getNearestMountedFiber = ReactFiberTreeReflection.getNearestMountedFiber,
	findCurrentFiberUsingSlowPath = ReactFiberTreeReflection.findCurrentFiberUsingSlowPath,
	createPortal = require(script.Parent:WaitForChild("ReactPortal")).createPortal
}
local v6, v7

if __DEV__ then
	v6 = false
	v7 = {}
else
	v6 = nil
	v7 = nil
end

local function getContextForSubtree(p1) --[[ getContextForSubtree | Line: 176 | Upvalues: emptyContextObject (copy), get (copy), findCurrentUnmaskedContext (copy), ClassComponent (copy), isContextProvider (copy), processChildContext (copy) ]]
	if not p1 then
		return emptyContextObject
	end

	local v1 = get(p1)
	local v2 = findCurrentUnmaskedContext(v1)

	if v1.tag ~= ClassComponent then
		return v2
	end

	local v3 = v1.type

	if isContextProvider(v3) then
		return processChildContext(v1, v3, v2)
	end

	return v2
end

local function findHostInstance(p1) --[[ findHostInstance | Line: 194 | Upvalues: get (copy), invariant (copy), Object (copy), findCurrentHostFiber (copy) ]]
	local v1 = get(p1)

	if v1 == nil and typeof(p1.render) == "function" then
		invariant(false, "Unable to find node on an unmounted component.")
	elseif v1 == nil then
		invariant(false, "Argument appears to not be a ReactComponent. Keys: %s", table.concat(Object.keys(p1)))
	end

	local v2 = findCurrentHostFiber(v1)

	if v2 == nil then
		return nil
	end

	return v2.stateNode
end

local function findHostInstanceWithWarning(p1, p2) --[[ findHostInstanceWithWarning | Line: 215 | Upvalues: __DEV__ (copy), get (copy), invariant (copy), Object (copy), findCurrentHostFiber (copy), StrictMode (copy), getComponentName (copy), v7 (ref), ReactCurrentFiber (copy), setCurrentFiber (copy), console (copy), describeError (copy), resetCurrentFiber (copy), findHostInstance (copy) ]]
	if not __DEV__ then
		return findHostInstance(p1)
	end

	local v1 = get(p1)

	if v1 == nil and typeof(p1.render) == "function" then
		invariant(false, "Unable to find node on an unmounted component.")
	elseif v1 == nil then
		invariant(false, "Argument appears to not be a ReactComponent. Keys: %s", table.concat(Object.keys(p1)))
	end

	local v2 = findCurrentHostFiber(v1)

	if v2 == nil then
		return nil
	end

	local v3 = StrictMode

	if bit32.band(v2.mode, v3) ~= 0 then
		local v4 = getComponentName(v1.type) or "Component"

		if not v7[v4] then
			v7[v4] = true

			local current = ReactCurrentFiber.current
			local ok, result = xpcall(function() --[[ Line: 243 | Upvalues: setCurrentFiber (ref), v2 (copy), v1 (copy), StrictMode (ref), console (ref), p2 (copy), v4 (copy) ]]
				setCurrentFiber(v2)

				if bit32.band(v1.mode, StrictMode) == 0 then
					console.error("%s is deprecated in StrictMode. %s was passed an instance of %s which renders StrictMode children. Instead, add a ref directly to the element you want to reference. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-find-node", p2, p2, v4)
				else
					console.error("%s is deprecated in StrictMode. %s was passed an instance of %s which is inside StrictMode. Instead, add a ref directly to the element you want to reference. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-find-node", p2, p2, v4)
				end
			end, describeError)

			if current then
				setCurrentFiber(current)
			else
				resetCurrentFiber()
			end

			if not ok then
				error(result)
			end
		end
	end

	return v2.stateNode
end

function t.createContainer(p1, p2, p3, p4) --[[ Line: 288 | Upvalues: createFiberRoot (copy) ]]
	return createFiberRoot(p1, p2, p3, p4)
end
function t.updateContainer(p1, p2, p3, p4) --[[ Line: 297 | Upvalues: __DEV__ (copy), onScheduleRoot (copy), requestEventTime (copy), warnIfUnmockedScheduler (copy), warnIfNotScopedWithMatchingAct (copy), requestUpdateLane (copy), enableSchedulingProfiler (copy), markRenderScheduled (copy), emptyContextObject (copy), get (copy), findCurrentUnmaskedContext (copy), ClassComponent (copy), isContextProvider (copy), processChildContext (copy), isRendering (copy), ReactCurrentFiber (copy), v6 (ref), console (copy), getComponentName (copy), createUpdate (copy), Object (copy), enqueueUpdate (copy), scheduleUpdateOnFiber (copy) ]]
	if __DEV__ then
		onScheduleRoot(p2, p1)
	end

	local current = p2.current
	local v1 = requestEventTime()

	if __DEV__ and _G.__TESTEZ_RUNNING_TEST__ then
		warnIfUnmockedScheduler(current)
		warnIfNotScopedWithMatchingAct(current)
	end

	local v2 = requestUpdateLane(current)

	if enableSchedulingProfiler then
		markRenderScheduled(v2)
	end

	local v3

	if p3 then
		local v4 = get(p3)
		local v5 = findCurrentUnmaskedContext(v4)

		if v4.tag == ClassComponent then
			local v62 = v4.type

			v3 = if isContextProvider(v62) then processChildContext(v4, v62, v5) else v5
		else
			v3 = v5
		end
	else
		v3 = emptyContextObject
	end

	if p2.context == nil then
		p2.context = v3
	else
		p2.pendingContext = v3
	end

	if __DEV__ and (isRendering and (ReactCurrentFiber.current ~= nil and not v6)) then
		v6 = true
		console.error("Render methods should be a pure function of props and state; triggering nested component updates from render is not allowed. If necessary, trigger nested updates in componentDidUpdate.\n\nCheck the render method of %s.", getComponentName(ReactCurrentFiber.current.type) or "Unknown")
	end

	local v8 = createUpdate(v1, v2)

	if p1 == nil then
		p1 = Object.None
	end

	v8.payload = {
		element = p1
	}

	if p4 ~= nil then
		if __DEV__ and typeof(p4) ~= "function" then
			console.error("render(...): Expected the last optional `callback` argument to be a function. Instead received: %s.", (tostring(p4)))
		end

		v8.callback = p4
	end

	enqueueUpdate(current, v8)
	scheduleUpdateOnFiber(current, v2, v1)

	return v2
end
t.batchedEventUpdates = v4.batchedEventUpdates
t.batchedUpdates = v4.batchedUpdates
t.unbatchedUpdates = v4.unbatchedUpdates
t.deferredUpdates = v4.deferredUpdates
t.discreteUpdates = v4.discreteUpdates
t.flushDiscreteUpdates = v4.flushDiscreteUpdates
t.flushControlled = v4.flushControlled
t.flushSync = flushSync
t.flushPassiveEffects = v4.flushPassiveEffects
t.IsThisRendererActing = v4.IsThisRendererActing
t.act = v4.act
function t.getPublicRootInstance(p1) --[[ Line: 393 | Upvalues: HostComponent (copy), getPublicInstance (copy) ]]
	local current = p1.current

	if not current.child then
		return nil
	end

	if current.child.tag == HostComponent then
		return getPublicInstance(current.child.stateNode)
	end

	return current.child.stateNode
end

local v8 = nil

function t.attemptSynchronousHydration(p1) --[[ Line: 408 | Upvalues: HostRoot (copy), getHighestPriorityPendingLanes (copy), flushRoot (copy), SuspenseComponent (copy), requestEventTime (copy), flushSync (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), InputDiscreteHydrationLane (copy), v8 (ref) ]]
	if p1.tag == HostRoot then
		local stateNode = p1.stateNode

		if stateNode.hydrate then
			flushRoot(stateNode, (getHighestPriorityPendingLanes(stateNode)))
		end
	else
		if p1.tag ~= SuspenseComponent then
			return
		end

		local v1 = requestEventTime()

		flushSync(function() --[[ Line: 418 | Upvalues: scheduleUpdateOnFiber (ref), p1 (copy), SyncLane (ref), v1 (copy) ]]
			return scheduleUpdateOnFiber(p1, SyncLane, v1)
		end)
		v8(p1, InputDiscreteHydrationLane)
	end
end

local function markRetryLaneImpl(p1, p2) --[[ markRetryLaneImpl | Line: 429 | Upvalues: higherPriorityLane (copy) ]]
	local memoizedState = p1.memoizedState

	if not memoizedState or (memoizedState == nil or memoizedState.dehydrated == nil) then
		return
	end

	memoizedState.retryLane = higherPriorityLane(memoizedState.retryLane, p2)
end

v8 = function(p1, p2) --[[ Line: 440 | Upvalues: higherPriorityLane (copy) ]]
	local memoizedState = p1.memoizedState

	if memoizedState and (memoizedState ~= nil and memoizedState.dehydrated ~= nil) then
		memoizedState.retryLane = higherPriorityLane(memoizedState.retryLane, p2)
	end

	local alternate = p1.alternate

	if not alternate then
		return
	end

	local memoizedState2 = alternate.memoizedState

	if not memoizedState2 or (memoizedState2 == nil or memoizedState2.dehydrated == nil) then
		return
	end

	memoizedState2.retryLane = higherPriorityLane(memoizedState2.retryLane, p2)
end
function t.attemptUserBlockingHydration(p1) --[[ Line: 449 | Upvalues: SuspenseComponent (copy), requestEventTime (copy), InputDiscreteHydrationLane (copy), scheduleUpdateOnFiber (copy), v8 (ref) ]]
	if p1.tag == SuspenseComponent then
		local v1 = InputDiscreteHydrationLane

		scheduleUpdateOnFiber(p1, v1, (requestEventTime()))
		v8(p1, v1)
	end
end
function t.attemptContinuousHydration(p1) --[[ Line: 463 | Upvalues: SuspenseComponent (copy), requestEventTime (copy), SelectiveHydrationLane (copy), scheduleUpdateOnFiber (copy), v8 (ref) ]]
	if p1.tag == SuspenseComponent then
		local v1 = SelectiveHydrationLane

		scheduleUpdateOnFiber(p1, v1, (requestEventTime()))
		v8(p1, v1)
	end
end
function t.attemptHydrationAtCurrentPriority(p1) --[[ Line: 477 | Upvalues: SuspenseComponent (copy), requestEventTime (copy), requestUpdateLane (copy), scheduleUpdateOnFiber (copy), v8 (ref) ]]
	if p1.tag == SuspenseComponent then
		local v1 = requestEventTime()
		local v2 = requestUpdateLane(p1)

		scheduleUpdateOnFiber(p1, v2, v1)
		v8(p1, v2)
	end
end
function t.runWithPriority(p1, p2) --[[ Line: 489 | Upvalues: getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), describeError (copy) ]]
	local v1 = getCurrentUpdateLanePriority()

	setCurrentUpdateLanePriority(p1)

	local ok, result = xpcall(p2, describeError)

	setCurrentUpdateLanePriority(v1)

	if not ok then
		error(result)
	end

	return result
end
t.getCurrentUpdateLanePriority = getCurrentUpdateLanePriority
t.findHostInstance = findHostInstance
t.findHostInstanceWithWarning = findHostInstanceWithWarning
function t.findHostInstanceWithNoPortals(p1) --[[ Line: 507 | Upvalues: findCurrentHostFiberWithNoPortals (copy), FundamentalComponent (copy) ]]
	local v1 = findCurrentHostFiberWithNoPortals(p1)

	if v1 == nil then
		return nil
	end

	if v1.tag == FundamentalComponent then
		return v1.stateNode.instance
	end

	return v1.stateNode
end

local function shouldSuspendImpl(p1) --[[ shouldSuspendImpl | Line: 518 ]]
	return false
end

function t.shouldSuspend(p1) --[[ Line: 522 | Upvalues: shouldSuspendImpl (ref) ]]
	return shouldSuspendImpl(p1)
end

local v9, v10, v11, v12, v13, v14, v15, v16

if __DEV__ then
	local function v17(p1, p2, p3) --[[ copyWithDeleteImpl | Line: 537 | Upvalues: Array (copy), v17 (copy) ]]
		local v1 = p2[p3]
		local v2 = if Array.isArray(p1) then Array.slice(p1) else table.clone(p1)

		if p3 + 1 ~= #p2 then
			v2[v1] = v17(p1[v1], p2, p3 + 1)

			return v2
		end

		if Array.isArray(v2) then
			Array.splice(v2, v1, 1)
		else
			v2[v1] = nil
		end

		return v2
	end

	local function copyWithDelete(p1, p2) --[[ copyWithDelete | Line: 565 | Upvalues: v17 (copy) ]]
		return v17(p1, p2, 0)
	end

	local function v18(p1, p2, p3, p4) --[[ copyWithRenameImpl | Line: 573 | Upvalues: Array (copy), v18 (copy) ]]
		local v1 = p2[p4]
		local v2 = if Array.isArray(p1) then Array.slice(p1) else table.clone(p1)

		if p4 + 1 ~= #p2 then
			v2[v1] = v18(p1[v1], p2, p3, p4 + 1)

			return v2
		end

		v2[p3[p4]] = v2[v1]

		if Array.isArray(v2) then
			Array.splice(v2, v1, 1)
		else
			v2[v1] = nil
		end

		return v2
	end

	local function copyWithRename(p1, p2, p3) --[[ copyWithRename | Line: 609 | Upvalues: console (copy), v18 (copy) ]]
		if #p2 ~= #p3 then
			console.warn("copyWithRename() expects paths of the same length")

			return nil
		end

		for i = 1, #p3 do
			if p2[i] ~= p3[i] then
				console.warn("copyWithRename() expects paths to be the same except for the deepest key")

				return nil
			end
		end

		return v18(p1, p2, p3, 0)
	end

	local function v19(p1, p2, p3, p4) --[[ copyWithSetImpl | Line: 631 | Upvalues: Array (copy), v19 (copy) ]]
		if #p2 + 1 <= p3 then
			return p4
		end

		local v1 = p2[p3]
		local v2 = if Array.isArray(p1) then Array.slice(p1) else table.clone(p1)

		v2[v1] = v19(p1[v1], p2, p3 + 2, p4)

		return v2
	end

	local function copyWithSet(p1, p2, p3) --[[ copyWithSet | Line: 653 | Upvalues: v19 (copy) ]]
		return v19(p1, p2, 1, p3)
	end

	local function findHook(p1, p2) --[[ findHook | Line: 661 ]]
		local memoizedState = p1.memoizedState

		while memoizedState ~= nil and p2 > 1 do
			memoizedState = memoizedState.next
			p2 = p2 - 1
		end

		return memoizedState
	end

	v9 = function(p1) --[[ Line: 769 | Upvalues: shouldSuspendImpl (ref) ]]
		shouldSuspendImpl = p1
	end
	v10 = function(p1, p2, p3) --[[ Line: 733 | Upvalues: v19 (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy) ]]
		p1.pendingProps = v19(p1.memoizedProps, p2, 1, p3)

		local alternate = p1.alternate

		if alternate then
			alternate.pendingProps = p1.pendingProps
		end

		scheduleUpdateOnFiber(p1, SyncLane, NoTimestamp)
	end
	v11 = function(p1, p2) --[[ Line: 742 | Upvalues: v17 (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy) ]]
		p1.pendingProps = v17(p1.memoizedProps, p2, 0)

		local alternate = p1.alternate

		if alternate then
			alternate.pendingProps = p1.pendingProps
		end

		scheduleUpdateOnFiber(p1, SyncLane, NoTimestamp)
	end
	v12 = function(p1, p2, p3) --[[ Line: 751 | Upvalues: copyWithRename (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy) ]]
		p1.pendingProps = copyWithRename(p1.memoizedProps, p2, p3)

		local alternate = p1.alternate

		if alternate then
			alternate.pendingProps = p1.pendingProps
		end

		scheduleUpdateOnFiber(p1, SyncLane, NoTimestamp)
	end
	v13 = function(p1) --[[ Line: 765 | Upvalues: scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy) ]]
		scheduleUpdateOnFiber(p1, SyncLane, NoTimestamp)
	end
	v14 = function(p1, p2, p3, p4) --[[ Line: 674 | Upvalues: v19 (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy) ]]
		local memoizedState = p1.memoizedState
		local count = p2

		while memoizedState ~= nil and count > 1 do
			memoizedState = memoizedState.next
			count = count - 1
		end

		if memoizedState == nil then
			return
		end

		local v1 = v19(memoizedState.memoizedState, p3, 1, p4)

		memoizedState.memoizedState = v1
		memoizedState.baseState = v1
		p1.memoizedProps = table.clone(p1.memoizedProps)
		scheduleUpdateOnFiber(p1, SyncLane, NoTimestamp)
	end
	v15 = function(p1, p2, p3) --[[ Line: 692 | Upvalues: v17 (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy) ]]
		local memoizedState = p1.memoizedState
		local count = p2

		while memoizedState ~= nil and count > 1 do
			memoizedState = memoizedState.next
			count = count - 1
		end

		if memoizedState == nil then
			return
		end

		local v1 = v17(memoizedState.memoizedState, p3, 0)

		memoizedState.memoizedState = v1
		memoizedState.baseState = v1
		p1.memoizedProps = table.clone(p1.memoizedProps)
		scheduleUpdateOnFiber(p1, SyncLane, NoTimestamp)
	end
	v16 = function(p1, p2, p3, p4) --[[ Line: 709 | Upvalues: copyWithRename (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy) ]]
		local memoizedState = p1.memoizedState
		local count = p2

		while memoizedState ~= nil and count > 1 do
			memoizedState = memoizedState.next
			count = count - 1
		end

		if memoizedState == nil then
			return
		end

		local v1 = copyWithRename(memoizedState.memoizedState, p3, p4)

		memoizedState.memoizedState = v1
		memoizedState.baseState = v1
		p1.memoizedProps = table.clone(p1.memoizedProps)
		scheduleUpdateOnFiber(p1, SyncLane, NoTimestamp)
	end
else
	v10 = nil
	v11 = nil
	v12 = nil
	v9 = nil
	v13 = nil
	v14 = nil
	v15 = nil
	v16 = nil
end

function findHostInstanceByFiber(p1) --[[ findHostInstanceByFiber | Line: 774 | Upvalues: findCurrentHostFiber (copy) ]]
	local v1 = findCurrentHostFiber(p1)

	if v1 == nil then
		return nil
	end

	return v1.stateNode
end
function emptyFindFiberByHostInstance(p1) --[[ emptyFindFiberByHostInstance | Line: 782 ]]
	return nil
end
function getCurrentFiberForDevTools() --[[ getCurrentFiberForDevTools | Line: 786 | Upvalues: ReactCurrentFiber (copy) ]]
	return ReactCurrentFiber.current
end
function t.injectIntoDevTools(p1) --[[ Line: 790 | Upvalues: ReactSharedInternals (copy), __DEV__ (copy), injectInternals (copy), v14 (ref), v15 (ref), v16 (ref), v10 (ref), v11 (ref), v12 (ref), v9 (ref), v13 (ref) ]]
	local findFiberByHostInstance = p1.findFiberByHostInstance
	local v1 = if __DEV__ then getCurrentFiberForDevTools else nil
	local t = {
		bundleType = p1.bundleType,
		version = p1.version,
		rendererPackageName = p1.rendererPackageName,
		rendererConfig = p1.rendererConfig,
		overrideHookState = v14,
		overrideHookStateDeletePath = v15,
		overrideHookStateRenamePath = v16,
		overrideProps = v10,
		overridePropsDeletePath = v11,
		overridePropsRenamePath = v12,
		setSuspenseHandler = v9,
		scheduleUpdate = v13,
		currentDispatcherRef = ReactSharedInternals.ReactCurrentDispatcher,
		findHostInstanceByFiber = findHostInstanceByFiber
	}

	t.findFiberByHostInstance = if findFiberByHostInstance then findFiberByHostInstance else emptyFindFiberByHostInstance
	t.getCurrentFiber = v1

	return injectInternals(t)
end
t.robloxReactProfiling = require(script.Parent.RobloxReactProfiling)

return t