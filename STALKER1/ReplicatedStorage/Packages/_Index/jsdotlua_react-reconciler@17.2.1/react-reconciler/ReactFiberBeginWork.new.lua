-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function unimplemented(p1) --[[ unimplemented | Line: 14 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring(p1))
	error("FIXME (roblox): " .. p1 .. " is unimplemented", 2)
end

local __DEV__ = _G.__DEV__
local __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ = _G.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__
local __COMPAT_WARNINGS__ = _G.__COMPAT_WARNINGS__
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Array = v1.Array
local Object = v1.Object
local inspect = v1.util.inspect

require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent.Parent:WaitForChild("react"))
require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))

require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"))

local checkPropTypes, ReactWorkTags, FunctionComponent, ClassComponent, HostRoot, HostComponent, HostText, HostPortal, ForwardRef, Fragment, Mode, ContextProvider, ContextConsumer, Profiler, SuspenseComponent, SuspenseListComponent, MemoComponent, SimpleMemoComponent, LazyComponent, IncompleteClassComponent, OffscreenComponent, LegacyHiddenComponent, NoFlags, StaticMask, PerformedWork, Placement, Hydrating, ContentReset, DidCapture, Ref, Deletion, ForceUpdateForLegacySuspense, debugRenderPhaseSideEffectsForStrictMode, disableLegacyContext, disableModulePatternComponents, enableProfilerTimer, enableSchedulerTracing, enableSuspenseServerRenderer, warnAboutDefaultPropsOnFunctionComponents, invariant, describeError, getComponentName, REACT_LAZY_TYPE, v3, getCurrentFiberOwnerNameInDevOrNull, setIsRendering, resolveFunctionForHotReloading, resolveForwardRefForHotReloading, resolveClassForHotReloading, mountChildFibers, reconcileChildFibers, cloneChildFibers, processUpdateQueue, cloneUpdateQueue, initializeUpdateQueue, NoMode, ProfileMode, StrictMode, BlockingMode, shouldSetTextContent, isSuspenseInstancePending, isSuspenseInstanceFallback, registerSuspenseInstanceRetry, supportsHydration, pushHostContext, pushHostContainer, suspenseStackCursor, hasSuspenseContext, ForceSuspenseFallback, addSubtreeSuspenseContext, InvisibleParentSuspenseContext, pushSuspenseContext, setDefaultShallowSuspenseContext, propagateContextChange, readContext, calculateChangedBits, prepareToReadContext, pushProvider, t, renderWithHooks, stopProfilerTimerIfRunning, getMaskedContext, getUnmaskedContext, hasContextChanged, pushContextProvider, isContextProvider, pushTopLevelContextObject, invalidateContextProvider, resetHydrationState, enterHydrationState, reenterHydrationStateFromDehydratedSuspenseInstance, tryToClaimNextHydratableInstance, warnIfHydrating, adoptClassInstance, applyDerivedStateFromProps, constructClassInstance, mountClassInstance, resumeMountClassInstance, updateClassInstance, resolveDefaultProps, resolveLazyComponentTag, createFiberFromFragment, createFiberFromOffscreen, createFiberFromTypeAndProps, createWorkInProgress, markSpawnedWork, retryDehydratedSuspenseBoundary, scheduleUpdateOnFiber, renderDidSuspendDelayIfPossible, getWorkInProgressRoot, getExecutionContext, RetryAfterError, NoContext, v14, setWorkInProgressVersion, markSkippedUpdateLanes, disableLogs, reenableLogs, ReactCurrentOwner, t2, v15, v17, t3, updateForwardRef, updateMemoComponent, updateSimpleMemoComponent, updateOffscreenComponent, updateFunctionComponent

do
	local v2 = require(script.Parent:WaitForChild("ReactFiberSuspenseContext.new"))

	require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"))
	checkPropTypes = require(script.Parent.Parent:WaitForChild("shared")).checkPropTypes
	ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
	FunctionComponent = ReactWorkTags.FunctionComponent
	ClassComponent = ReactWorkTags.ClassComponent
	HostRoot = ReactWorkTags.HostRoot
	HostComponent = ReactWorkTags.HostComponent
	HostText = ReactWorkTags.HostText
	HostPortal = ReactWorkTags.HostPortal
	ForwardRef = ReactWorkTags.ForwardRef
	Fragment = ReactWorkTags.Fragment
	Mode = ReactWorkTags.Mode
	ContextProvider = ReactWorkTags.ContextProvider
	ContextConsumer = ReactWorkTags.ContextConsumer
	Profiler = ReactWorkTags.Profiler
	SuspenseComponent = ReactWorkTags.SuspenseComponent
	SuspenseListComponent = ReactWorkTags.SuspenseListComponent
	MemoComponent = ReactWorkTags.MemoComponent
	SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
	LazyComponent = ReactWorkTags.LazyComponent
	IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent
	OffscreenComponent = ReactWorkTags.OffscreenComponent
	LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent

	local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))

	NoFlags = ReactFiberFlags.NoFlags
	StaticMask = ReactFiberFlags.StaticMask
	PerformedWork = ReactFiberFlags.PerformedWork
	Placement = ReactFiberFlags.Placement
	Hydrating = ReactFiberFlags.Hydrating
	ContentReset = ReactFiberFlags.ContentReset
	DidCapture = ReactFiberFlags.DidCapture
	Ref = ReactFiberFlags.Ref
	Deletion = ReactFiberFlags.Deletion
	ForceUpdateForLegacySuspense = ReactFiberFlags.ForceUpdateForLegacySuspense

	local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals
	local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags

	debugRenderPhaseSideEffectsForStrictMode = ReactFeatureFlags.debugRenderPhaseSideEffectsForStrictMode
	disableLegacyContext = ReactFeatureFlags.disableLegacyContext
	disableModulePatternComponents = ReactFeatureFlags.disableModulePatternComponents
	enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer
	enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing
	enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer
	warnAboutDefaultPropsOnFunctionComponents = ReactFeatureFlags.warnAboutDefaultPropsOnFunctionComponents
	invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
	describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError

	local shallowEqual = require(script.Parent.Parent:WaitForChild("shared")).shallowEqual

	getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName

	local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols

	REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE

	local getIteratorFn = ReactSymbols.getIteratorFn

	v3 = require(script.Parent:WaitForChild("ReactStrictModeWarnings.new"))

	local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"))

	getCurrentFiberOwnerNameInDevOrNull = ReactCurrentFiber.getCurrentFiberOwnerNameInDevOrNull
	setIsRendering = ReactCurrentFiber.setIsRendering

	local v4 = require(script.Parent:WaitForChild("ReactFiberHotReloading.new"))

	resolveFunctionForHotReloading = v4.resolveFunctionForHotReloading
	resolveForwardRefForHotReloading = v4.resolveForwardRefForHotReloading
	resolveClassForHotReloading = v4.resolveClassForHotReloading

	local v5 = require(script.Parent:WaitForChild("ReactChildFiber.new"))

	mountChildFibers = v5.mountChildFibers
	reconcileChildFibers = v5.reconcileChildFibers
	cloneChildFibers = v5.cloneChildFibers

	local v6 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"))

	processUpdateQueue = v6.processUpdateQueue
	cloneUpdateQueue = v6.cloneUpdateQueue
	initializeUpdateQueue = v6.initializeUpdateQueue

	local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"))
	local ConcurrentMode = ReactTypeOfMode.ConcurrentMode

	NoMode = ReactTypeOfMode.NoMode
	ProfileMode = ReactTypeOfMode.ProfileMode
	StrictMode = ReactTypeOfMode.StrictMode
	BlockingMode = ReactTypeOfMode.BlockingMode

	local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"))

	shouldSetTextContent = ReactFiberHostConfig.shouldSetTextContent
	isSuspenseInstancePending = ReactFiberHostConfig.isSuspenseInstancePending
	isSuspenseInstanceFallback = ReactFiberHostConfig.isSuspenseInstanceFallback
	registerSuspenseInstanceRetry = ReactFiberHostConfig.registerSuspenseInstanceRetry
	supportsHydration = ReactFiberHostConfig.supportsHydration

	local v7 = require(script.Parent:WaitForChild("ReactFiberHostContext.new"))

	pushHostContext = v7.pushHostContext
	pushHostContainer = v7.pushHostContainer
	suspenseStackCursor = v2.suspenseStackCursor
	hasSuspenseContext = v2.hasSuspenseContext
	ForceSuspenseFallback = v2.ForceSuspenseFallback
	addSubtreeSuspenseContext = v2.addSubtreeSuspenseContext
	InvisibleParentSuspenseContext = v2.InvisibleParentSuspenseContext
	pushSuspenseContext = v2.pushSuspenseContext
	setDefaultShallowSuspenseContext = v2.setDefaultShallowSuspenseContext

	local v8 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"))

	propagateContextChange = v8.propagateContextChange
	readContext = v8.readContext
	calculateChangedBits = v8.calculateChangedBits
	prepareToReadContext = v8.prepareToReadContext
	pushProvider = v8.pushProvider
	t = {
		renderWithHooksRef = nil,
		bailoutHooksRef = nil,
		shouldSuspendRef = nil
	}

	local function shouldSuspend(p1) --[[ shouldSuspend | Line: 185 | Upvalues: t (copy) ]]
		if t.shouldSuspendRef then
			return t.shouldSuspendRef(p1)
		end

		t.shouldSuspendRef = require(script.Parent:WaitForChild("ReactFiberReconciler")).shouldSuspend

		return t.shouldSuspendRef(p1)
	end

	local function initReactFiberHooks() --[[ initReactFiberHooks | Line: 193 | Upvalues: t (copy) ]]
		local v1 = require(script.Parent:WaitForChild("ReactFiberHooks.new"))

		t.renderWithHooksRef = v1.renderWithHooks
		t.bailoutHooksRef = v1.bailoutHooks
	end

	renderWithHooks = function(...) --[[ renderWithHooks | Line: 200 | Upvalues: t (copy) ]]
		if t.renderWithHooksRef then
			return t.renderWithHooksRef(...)
		end

		local v1 = require(script.Parent:WaitForChild("ReactFiberHooks.new"))

		t.renderWithHooksRef = v1.renderWithHooks
		t.bailoutHooksRef = v1.bailoutHooks

		return t.renderWithHooksRef(...)
	end

	local function bailoutHooks(...) --[[ bailoutHooks | Line: 208 | Upvalues: t (copy) ]]
		if t.bailoutHooksRef then
			return t.bailoutHooksRef(...)
		end

		local v1 = require(script.Parent:WaitForChild("ReactFiberHooks.new"))

		t.renderWithHooksRef = v1.renderWithHooks
		t.bailoutHooksRef = v1.bailoutHooks

		return t.bailoutHooksRef(...)
	end

	stopProfilerTimerIfRunning = require(script.Parent:WaitForChild("ReactProfilerTimer.new")).stopProfilerTimerIfRunning

	local v9 = require(script.Parent:WaitForChild("ReactFiberContext.new"))

	getMaskedContext = v9.getMaskedContext
	getUnmaskedContext = v9.getUnmaskedContext
	hasContextChanged = v9.hasContextChanged
	pushContextProvider = v9.pushContextProvider
	isContextProvider = v9.isContextProvider
	pushTopLevelContextObject = v9.pushTopLevelContextObject
	invalidateContextProvider = v9.invalidateContextProvider

	local v10 = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new"))

	resetHydrationState = v10.resetHydrationState
	enterHydrationState = v10.enterHydrationState
	reenterHydrationStateFromDehydratedSuspenseInstance = v10.reenterHydrationStateFromDehydratedSuspenseInstance
	tryToClaimNextHydratableInstance = v10.tryToClaimNextHydratableInstance
	warnIfHydrating = v10.warnIfHydrating

	local v11 = require(script.Parent:WaitForChild("ReactFiberClassComponent.new"))

	adoptClassInstance = v11.adoptClassInstance
	applyDerivedStateFromProps = v11.applyDerivedStateFromProps
	constructClassInstance = v11.constructClassInstance
	mountClassInstance = v11.mountClassInstance
	resumeMountClassInstance = v11.resumeMountClassInstance
	updateClassInstance = v11.updateClassInstance
	resolveDefaultProps = require(script.Parent:WaitForChild("ReactFiberLazyComponent.new")).resolveDefaultProps

	local v12 = require(script.Parent:WaitForChild("ReactFiber.new"))

	resolveLazyComponentTag = v12.resolveLazyComponentTag
	createFiberFromFragment = v12.createFiberFromFragment
	createFiberFromOffscreen = v12.createFiberFromOffscreen
	createFiberFromTypeAndProps = v12.createFiberFromTypeAndProps

	local isSimpleFunctionComponent = v12.isSimpleFunctionComponent

	createWorkInProgress = v12.createWorkInProgress

	local v13 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
	local pushRenderLanes = v13.pushRenderLanes

	markSpawnedWork = v13.markSpawnedWork
	retryDehydratedSuspenseBoundary = v13.retryDehydratedSuspenseBoundary
	scheduleUpdateOnFiber = v13.scheduleUpdateOnFiber
	renderDidSuspendDelayIfPossible = v13.renderDidSuspendDelayIfPossible
	getWorkInProgressRoot = v13.getWorkInProgressRoot
	getExecutionContext = v13.getExecutionContext
	RetryAfterError = v13.RetryAfterError
	NoContext = v13.NoContext
	v14 = nil
	setWorkInProgressVersion = require(script.Parent:WaitForChild("ReactMutableSource.new")).setWorkInProgressVersion
	markSkippedUpdateLanes = require(script.Parent:WaitForChild("ReactFiberWorkInProgress")).markSkippedUpdateLanes

	local ConsolePatchingDev = require(script.Parent.Parent:WaitForChild("shared")).ConsolePatchingDev

	disableLogs = ConsolePatchingDev.disableLogs
	reenableLogs = ConsolePatchingDev.reenableLogs
	ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner
	t2 = {}
	v15 = nil

	local v16 = nil

	v17 = false
	t3 = {
		didWarnAboutBadClass = {},
		didWarnAboutModulePatternComponent = {},
		didWarnAboutContextTypeOnFunctionComponent = {},
		didWarnAboutGetDerivedStateOnFunctionComponent = {},
		didWarnAboutFunctionRefs = {},
		didWarnAboutDefaultPropsOnFunctionComponent = {}
	}

	local v18 = nil

	if __DEV__ then
		t3.didWarnAboutBadClass = {}
		t3.didWarnAboutModulePatternComponent = {}
		t3.didWarnAboutContextTypeOnFunctionComponent = {}
		t3.didWarnAboutGetDerivedStateOnFunctionComponent = {}
		t3.didWarnAboutFunctionRefs = {}
		t2.didWarnAboutReassigningProps = false
		t3.didWarnAboutDefaultPropsOnFunctionComponent = {}
	end

	local function reconcileChildren(p1, p2, p3, p4) --[[ reconcileChildren | Line: 307 | Upvalues: mountChildFibers (copy), reconcileChildFibers (copy) ]]
		if p1 == nil then
			p2.child = mountChildFibers(p2, nil, p3, p4)
		else
			p2.child = reconcileChildFibers(p2, p1.child, p3, p4)
		end
	end

	local function forceUnmountCurrentAndReconcile(p1, p2, p3, p4) --[[ forceUnmountCurrentAndReconcile | Line: 336 | Upvalues: reconcileChildFibers (copy) ]]
		p2.child = reconcileChildFibers(p2, p1.child, nil, p4)
		p2.child = reconcileChildFibers(p2, nil, p3, p4)
	end

	updateForwardRef = function(p1, p2, p3, p4, p5) --[[ updateForwardRef | Line: 360 | Upvalues: __DEV__ (copy), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), prepareToReadContext (copy), t2 (copy), ReactCurrentOwner (copy), setIsRendering (copy), renderWithHooks (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), v17 (ref), bailoutHooks (copy), v15 (ref), PerformedWork (copy), mountChildFibers (copy), reconcileChildFibers (copy) ]]
		if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p2.type ~= p2.elementType then
			local propTypes = p3.propTypes
			local validateProps = p3.validateProps

			if propTypes or validateProps then
				checkPropTypes(propTypes, validateProps, p4, "prop", getComponentName(p3))
			end
		end

		local render = p3.render
		local ref = p2.ref

		prepareToReadContext(p2, p5, t2.markWorkInProgressReceivedUpdate)

		local v1

		if __DEV__ then
			ReactCurrentOwner.current = p2
			setIsRendering(true)

			local v2 = renderWithHooks(p1, p2, render, p4, ref, p5)

			if debugRenderPhaseSideEffectsForStrictMode then
				if bit32.band(p2.mode, StrictMode) == 0 then
					v1 = v2
				else
					disableLogs()

					local ok, result = xpcall(renderWithHooks, describeError, p1, p2, render, p4, ref, p5)

					v1 = if ok then result else v2
					reenableLogs()

					if not ok then
						error(result)
					end
				end
			else
				v1 = v2
			end

			setIsRendering(false)
		else
			v1 = renderWithHooks(p1, p2, render, p4, ref, p5)
		end

		if p1 ~= nil and not v17 then
			bailoutHooks(p1, p2, p5)

			return v15(p1, p2, p5)
		end

		p2.flags = bit32.bor(p2.flags, PerformedWork)

		if p1 == nil then
			p2.child = mountChildFibers(p2, nil, v1, p5)
		else
			p2.child = reconcileChildFibers(p2, p1.child, v1, p5)
		end

		return p2.child
	end
	updateMemoComponent = function(p1, p2, p3, p4, p5, p6) --[[ updateMemoComponent | Line: 447 | Upvalues: isSimpleFunctionComponent (copy), __DEV__ (copy), resolveFunctionForHotReloading (copy), SimpleMemoComponent (copy), v18 (ref), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), createFiberFromTypeAndProps (copy), ReactFiberLane (copy), shallowEqual (copy), v15 (ref), PerformedWork (copy), createWorkInProgress (copy) ]]
		if p1 == nil then
			local v1 = p3.type

			if isSimpleFunctionComponent(v1) and (p3.compare == nil and p3.defaultProps == nil) then
				local v2 = if __DEV__ then resolveFunctionForHotReloading(v1) else v1

				p2.tag = SimpleMemoComponent
				p2.type = v2

				if __DEV__ then
					validateFunctionComponentInDev(p2, v1)
				end

				return v18(p1, p2, v2, p4, p5, p6)
			end

			if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
				local v4, v5

				if type(v1) == "table" then
					v4 = v1.propTypes
					v5 = v1.validateProps
				else
					v4 = nil
					v5 = nil
				end

				if v4 or v5 then
					checkPropTypes(v4, v5, p4, "prop", getComponentName(v1))
				end
			end

			local v6 = createFiberFromTypeAndProps(p3.type, nil, p4, p2, p2.mode, p6)

			v6.ref = p2.ref
			v6.return_ = p2
			p2.child = v6

			return v6
		end

		if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
			local v7 = p3.type
			local v8, v9

			if type(v7) == "table" then
				v8 = v7.propTypes
				v9 = v7.validateProps
			else
				v8 = nil
				v9 = nil
			end

			if v8 or v9 then
				checkPropTypes(v8, v9, p4, "prop", getComponentName(v7))
			end
		end

		local child = p1.child

		if not ReactFiberLane.includesSomeLane(p5, p6) then
			local compare = p3.compare

			if compare == nil then
				compare = shallowEqual
			end

			if compare(child.memoizedProps, p4) and p1.ref == p2.ref then
				return v15(p1, p2, p6)
			end
		end

		p2.flags = bit32.bor(p2.flags, PerformedWork)

		local v11 = createWorkInProgress(child, p4)

		v11.ref = p2.ref
		v11.return_ = p2
		p2.child = v11

		return v11
	end
	updateSimpleMemoComponent = function(p1, p2, p3, p4, p5, p6) --[[ updateSimpleMemoComponent | Line: 568 | Upvalues: __DEV__ (copy), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), REACT_LAZY_TYPE (copy), describeError (copy), checkPropTypes (copy), getComponentName (copy), shallowEqual (copy), v17 (ref), ReactFiberLane (copy), v15 (ref), ForceUpdateForLegacySuspense (copy), NoFlags (copy), v16 (ref) ]]
		if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p2.type ~= p2.elementType then
			local elementType = p2.elementType

			if elementType["$$typeof"] == REACT_LAZY_TYPE then
				local ok, result = xpcall(elementType._init, describeError, elementType._payload)
				local v1 = if ok then result else nil
				local v2, v3

				if v1 == nil or type(v1) ~= "table" then
					v2 = nil
					v3 = nil
				else
					v2 = v1.propTypes
					v3 = v1.validateProps
				end

				if v2 or v3 then
					checkPropTypes(v2, v3, p4, "prop", getComponentName(v1))
				end
			end
		end

		if p1 ~= nil then
			local v4 = if __DEV__ then if p2.type == p1.type then true else false else true

			if shallowEqual(p1.memoizedProps, p4) and (p1.ref == p2.ref and v4) then
				v17 = false

				if not ReactFiberLane.includesSomeLane(p6, p5) then
					p2.lanes = p1.lanes

					return v15(p1, p2, p6)
				end

				if bit32.band(p1.flags, ForceUpdateForLegacySuspense) ~= NoFlags then
					v17 = true
				end
			end
		end

		return v16(p1, p2, p3, p4, p6)
	end
	updateOffscreenComponent = function(p1, p2, p3) --[[ updateOffscreenComponent | Line: 670 | Upvalues: ConcurrentMode (copy), NoMode (copy), ReactFiberLane (copy), pushRenderLanes (copy), enableSchedulerTracing (copy), markSpawnedWork (copy), mountChildFibers (copy), reconcileChildFibers (copy) ]]
		local pendingProps = p2.pendingProps
		local children = pendingProps.children
		local v1 = if p1 == nil then nil else p1.memoizedState

		if pendingProps.mode == "hidden" or pendingProps.mode == "unstable-defer-without-hiding" then
			if bit32.band(p2.mode, ConcurrentMode) == NoMode then
				p2.memoizedState = {
					baseLanes = ReactFiberLane.NoLanes
				}
				pushRenderLanes(p2, p3)
			elseif ReactFiberLane.includesSomeLane(p3, ReactFiberLane.OffscreenLane) then
				p2.memoizedState = {
					baseLanes = ReactFiberLane.NoLanes
				}
				pushRenderLanes(p2, if v1 == nil then p3 else v1.baseLanes)
			else
				local v4 = if v1 == nil then p3 else ReactFiberLane.mergeLanes(v1.baseLanes, p3)

				if not enableSchedulerTracing then
					p2.childLanes = ReactFiberLane.laneToLanes(ReactFiberLane.OffscreenLane)
					p2.lanes = p2.childLanes
					p2.memoizedState = {
						baseLanes = v4
					}
					pushRenderLanes(p2, v4)

					return nil
				end

				markSpawnedWork(ReactFiberLane.OffscreenLane)
				p2.childLanes = ReactFiberLane.laneToLanes(ReactFiberLane.OffscreenLane)
				p2.lanes = p2.childLanes
				p2.memoizedState = {
					baseLanes = v4
				}
				pushRenderLanes(p2, v4)

				return nil
			end
		else
			local v6

			if v1 == nil then
				v6 = p3
			else
				local v7 = ReactFiberLane.mergeLanes(v1.baseLanes, p3)

				p2.memoizedState = nil
				v6 = v7
			end

			pushRenderLanes(p2, v6)
		end

		if p1 == nil then
			p2.child = mountChildFibers(p2, nil, children, p3)
		else
			p2.child = reconcileChildFibers(p2, p1.child, children, p3)
		end

		return p2.child
	end
	function updateFragment(p1, p2, p3) --[[ updateFragment | Line: 772 | Upvalues: mountChildFibers (copy), reconcileChildFibers (copy) ]]
		local pendingProps = p2.pendingProps

		if p1 == nil then
			p2.child = mountChildFibers(p2, nil, pendingProps, p3)
		else
			p2.child = reconcileChildFibers(p2, p1.child, pendingProps, p3)
		end

		return p2.child
	end
	function updateMode(p1, p2, p3) --[[ updateMode | Line: 778 | Upvalues: mountChildFibers (copy), reconcileChildFibers (copy) ]]
		local children = p2.pendingProps.children

		if p1 == nil then
			p2.child = mountChildFibers(p2, nil, children, p3)
		else
			p2.child = reconcileChildFibers(p2, p1.child, children, p3)
		end

		return p2.child
	end
	function updateProfiler(p1, p2, p3) --[[ updateProfiler | Line: 784 | Upvalues: enableProfilerTimer (copy), mountChildFibers (copy), reconcileChildFibers (copy) ]]
		if enableProfilerTimer then
			local stateNode = p2.stateNode

			stateNode.effectDuration = 0
			stateNode.passiveEffectDuration = 0
		end

		local children = p2.pendingProps.children

		if p1 == nil then
			p2.child = mountChildFibers(p2, nil, children, p3)
		else
			p2.child = reconcileChildFibers(p2, p1.child, children, p3)
		end

		return p2.child
	end

	local function markRef(p1, p2) --[[ markRef | Line: 798 | Upvalues: Ref (copy) ]]
		local ref = p2.ref

		if (p1 ~= nil or ref == nil) and (p1 == nil or p1.ref == ref) then
			return
		end

		p2.flags = bit32.bor(p2.flags, Ref)
	end

	updateFunctionComponent = function(p1, p2, p3, p4, p5) --[[ updateFunctionComponent | Line: 809 | Upvalues: __DEV__ (copy), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), prepareToReadContext (copy), t2 (copy), ReactCurrentOwner (copy), setIsRendering (copy), renderWithHooks (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), v17 (ref), bailoutHooks (copy), v15 (ref), PerformedWork (copy), mountChildFibers (copy), reconcileChildFibers (copy) ]]
		if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and (type(p3) ~= "function" and p2.type ~= p2.elementType) then
			local v1, v2

			if type(p3) == "table" then
				v1 = p3.propTypes
				v2 = p3.validateProps
			else
				v1 = nil
				v2 = nil
			end

			if v1 or v2 then
				checkPropTypes(v1, v2, p4, "prop", getComponentName(p3))
			end
		end

		local v3 = if disableLegacyContext then nil else getMaskedContext(p2, (getUnmaskedContext(p2, p3, true)))

		prepareToReadContext(p2, p5, t2.markWorkInProgressReceivedUpdate)

		local v5

		if __DEV__ then
			ReactCurrentOwner.current = p2
			setIsRendering(true)

			local v6 = renderWithHooks(p1, p2, p3, p4, v3, p5)

			if debugRenderPhaseSideEffectsForStrictMode then
				if bit32.band(p2.mode, StrictMode) == 0 then
					v5 = v6
				else
					disableLogs()

					local ok, result = xpcall(renderWithHooks, describeError, p1, p2, p3, p4, v3, p5)

					reenableLogs()

					if ok then
						v5 = result
					else
						error(result)
					end
				end
			else
				v5 = v6
			end

			setIsRendering(false)
		else
			v5 = renderWithHooks(p1, p2, p3, p4, v3, p5)
		end

		if p1 ~= nil and not v17 then
			bailoutHooks(p1, p2, p5)

			return v15(p1, p2, p5)
		end

		p2.flags = bit32.bor(p2.flags, PerformedWork)

		if p1 == nil then
			p2.child = mountChildFibers(p2, nil, v5, p5)
		else
			p2.child = reconcileChildFibers(p2, p1.child, v5, p5)
		end

		return p2.child
	end
end

local function updateClassComponent(p1, p2, p3, p4, p5) --[[ updateClassComponent | Line: 988 | Upvalues: __DEV__ (copy), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), isContextProvider (copy), pushContextProvider (copy), prepareToReadContext (copy), t2 (copy), Placement (copy), constructClassInstance (copy), mountClassInstance (copy), resumeMountClassInstance (copy), updateClassInstance (copy), console (copy) ]]
	if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p2.type ~= p2.elementType then
		local propTypes = p3.propTypes
		local validateProps = p3.validateProps

		if propTypes or validateProps then
			checkPropTypes(propTypes, validateProps, p4, "prop", getComponentName(p3))
		end
	end

	local v1

	if isContextProvider(p3) then
		pushContextProvider(p2)
		v1 = true
	else
		v1 = false
	end

	prepareToReadContext(p2, p5, t2.markWorkInProgressReceivedUpdate)

	local v2

	if p2.stateNode == nil then
		if p1 ~= nil then
			p1.alternate = nil
			p2.alternate = nil
			p2.flags = bit32.bor(p2.flags, Placement)
		end

		constructClassInstance(p2, p3, p4)
		mountClassInstance(p2, p3, p4, p5)
		v2 = true
	else
		v2 = if p1 == nil then resumeMountClassInstance(p2, p3, p4, p5) else updateClassInstance(p1, p2, p3, p4, p5)
	end

	local v6 = finishClassComponent(p1, p2, p3, v2, v1, p5)

	if __DEV__ and (v2 and p2.stateNode.props ~= p4) then
		if not t2.didWarnAboutReassigningProps then
			console.error("It looks like %s is reassigning its own `this.props` while rendering. This is not supported and can lead to confusing bugs.", getComponentName(p2.type) or "a component")
		end

		t2.didWarnAboutReassigningProps = true
	end

	return v6
end

function finishClassComponent(p1, p2, p3, p4, p5, p6) --[[ finishClassComponent | Line: 1085 | Upvalues: Ref (copy), DidCapture (copy), NoFlags (copy), invalidateContextProvider (copy), v15 (ref), ReactCurrentOwner (copy), enableProfilerTimer (copy), stopProfilerTimerIfRunning (copy), __DEV__ (copy), setIsRendering (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), PerformedWork (copy), reconcileChildFibers (copy), mountChildFibers (copy) ]]
	local ref = p2.ref

	if p1 == nil and ref ~= nil or p1 ~= nil and p1.ref ~= ref then
		p2.flags = bit32.bor(p2.flags, Ref)
	end

	local v3 = if bit32.band(p2.flags, DidCapture) == NoFlags then false else true

	if p4 or v3 then
		local stateNode = p2.stateNode

		ReactCurrentOwner.current = p2

		local v4, v5, v6, v7, v8, v9, v10

		if v3 then
			if p3.getDerivedStateFromError == nil then
				v4 = nil

				if enableProfilerTimer then
					stopProfilerTimerIfRunning(p2)
				end
			elseif type(p3.getDerivedStateFromError) == "function" then
				if __DEV__ then
					setIsRendering(true)
					v5 = stateNode:render()

					if debugRenderPhaseSideEffectsForStrictMode then
						v6 = p2.mode
						v7 = StrictMode

						if bit32.band(v6, StrictMode) ~= 0 then
							disableLogs()
							v8, v9 = xpcall(stateNode.render, describeError, stateNode)
							reenableLogs()

							if not v8 then
								error(v9)
							end
						end
					end

					setIsRendering(false)
					v4 = v5
				else
					v10 = stateNode:render()
					v4 = v10
				end
			else
				v4 = nil

				if enableProfilerTimer then
					stopProfilerTimerIfRunning(p2)
				end
			end
		elseif __DEV__ then
			setIsRendering(true)
			v5 = stateNode:render()

			if debugRenderPhaseSideEffectsForStrictMode then
				v6 = p2.mode
				v7 = StrictMode

				if bit32.band(v6, StrictMode) ~= 0 then
					disableLogs()
					v8, v9 = xpcall(stateNode.render, describeError, stateNode)
					reenableLogs()

					if not v8 then
						error(v9)
					end
				end
			end

			setIsRendering(false)
			v4 = v5
		else
			v10 = stateNode:render()
			v4 = v10
		end

		p2.flags = bit32.bor(p2.flags, PerformedWork)

		if p1 == nil or not v3 then
			if p1 == nil then
				p2.child = mountChildFibers(p2, nil, v4, p6)
			else
				p2.child = reconcileChildFibers(p2, p1.child, v4, p6)
			end
		else
			p2.child = reconcileChildFibers(p2, p1.child, nil, p6)
			p2.child = reconcileChildFibers(p2, nil, v4, p6)
		end

		p2.memoizedState = stateNode.state

		if p5 then
			invalidateContextProvider(p2, p3, true)
		end

		return p2.child
	end

	if p5 then
		invalidateContextProvider(p2, p3, false)
	end

	return v15(p1, p2, p6)
end

local function pushHostRootContext(p1) --[[ pushHostRootContext | Line: 1183 | Upvalues: pushTopLevelContextObject (copy), pushHostContainer (copy) ]]
	local stateNode = p1.stateNode

	if stateNode.pendingContext then
		pushTopLevelContextObject(p1, stateNode.pendingContext, stateNode.pendingContext ~= stateNode.context)
	elseif stateNode.context then
		pushTopLevelContextObject(p1, stateNode.context, false)
	end

	pushHostContainer(p1, stateNode.containerInfo)
end

local function updateHostRoot(p1, p2, p3) --[[ updateHostRoot | Line: 1199 | Upvalues: pushTopLevelContextObject (copy), pushHostContainer (copy), invariant (copy), cloneUpdateQueue (copy), processUpdateQueue (copy), resetHydrationState (copy), v15 (ref), enterHydrationState (copy), supportsHydration (copy), setWorkInProgressVersion (copy), mountChildFibers (copy), Placement (copy), Hydrating (copy), reconcileChildFibers (copy) ]]
	local stateNode = p2.stateNode

	if stateNode.pendingContext then
		pushTopLevelContextObject(p2, stateNode.pendingContext, if stateNode.pendingContext == stateNode.context then false else true)
	elseif stateNode.context then
		pushTopLevelContextObject(p2, stateNode.context, false)
	end

	pushHostContainer(p2, stateNode.containerInfo)
	invariant(if p1 == nil then false else p2.updateQueue ~= nil, "If the root does not have an updateQueue, we should have already bailed out. This error is likely caused by a bug in React. Please file an issue.")

	local memoizedState = p2.memoizedState
	local v5 = if memoizedState == nil then nil else memoizedState.element

	cloneUpdateQueue(p1, p2)
	processUpdateQueue(p2, p2.pendingProps, nil, p3)

	local element = p2.memoizedState.element

	if element == v5 then
		resetHydrationState()

		return v15(p1, p2, p3)
	end

	local stateNode2 = p2.stateNode

	if stateNode2.hydrate and enterHydrationState(p2) then
		if supportsHydration then
			local mutableSourceEagerHydrationData = stateNode2.mutableSourceEagerHydrationData

			if mutableSourceEagerHydrationData ~= nil then
				for i = 1, #mutableSourceEagerHydrationData, 2 do
					setWorkInProgressVersion(mutableSourceEagerHydrationData[i], mutableSourceEagerHydrationData[i + 1])
				end
			end
		end

		local v6 = mountChildFibers(p2, nil, element, p3)

		p2.child = v6

		local v7 = v6

		while v7 do
			v7.flags = bit32.bor(bit32.band(v7.flags, (bit32.bnot(Placement))), Hydrating)
			v7 = v7.sibling
		end
	else
		if p1 == nil then
			p2.child = mountChildFibers(p2, nil, element, p3)
		else
			p2.child = reconcileChildFibers(p2, p1.child, element, p3)
		end

		resetHydrationState()
	end

	return p2.child
end

local function updateHostComponent(p1, p2, p3) --[[ updateHostComponent | Line: 1276 | Upvalues: pushHostContext (copy), tryToClaimNextHydratableInstance (copy), shouldSetTextContent (copy), ContentReset (copy), PerformedWork (copy), Ref (copy), mountChildFibers (copy), reconcileChildFibers (copy) ]]
	pushHostContext(p2)

	if p1 == nil then
		tryToClaimNextHydratableInstance(p2)
	end

	local v1 = p2.type
	local pendingProps = p2.pendingProps
	local v2 = if p1 == nil then nil else p1.memoizedProps
	local children = pendingProps.children

	if shouldSetTextContent(v1, pendingProps) then
		children = nil
	elseif v2 ~= nil and shouldSetTextContent(v1, v2) then
		p2.flags = bit32.bor(p2.flags, ContentReset)
	end

	p2.flags = bit32.bor(p2.flags, PerformedWork)

	local ref = p2.ref

	if p1 == nil and ref ~= nil or p1 ~= nil and p1.ref ~= ref then
		p2.flags = bit32.bor(p2.flags, Ref)
	end

	if p1 == nil then
		p2.child = mountChildFibers(p2, nil, children, p3)
	else
		p2.child = reconcileChildFibers(p2, p1.child, children, p3)
	end

	return p2.child
end

local function updateHostText(p1, p2) --[[ updateHostText | Line: 1317 | Upvalues: tryToClaimNextHydratableInstance (copy) ]]
	if p1 ~= nil then
		return nil
	end

	tryToClaimNextHydratableInstance(p2)

	return nil
end

local function mountLazyComponent(p1, p2, p3, p4, p5) --[[ mountLazyComponent | Line: 1326 | Upvalues: Placement (copy), resolveLazyComponentTag (copy), resolveDefaultProps (copy), FunctionComponent (copy), __DEV__ (copy), resolveFunctionForHotReloading (copy), updateFunctionComponent (ref), ClassComponent (copy), resolveClassForHotReloading (copy), updateClassComponent (copy), ForwardRef (copy), resolveForwardRefForHotReloading (copy), updateForwardRef (copy), MemoComponent (copy), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), updateMemoComponent (copy), REACT_LAZY_TYPE (copy), inspect (copy), invariant (copy) ]]
	if p1 ~= nil then
		p1.alternate = nil
		p2.alternate = nil
		p2.flags = bit32.bor(p2.flags, Placement)
	end

	local pendingProps = p2.pendingProps
	local v2 = p3._init(p3._payload)

	p2.type = v2
	p2.tag = resolveLazyComponentTag(v2)

	local tag = p2.tag
	local v3 = resolveDefaultProps(v2, pendingProps)

	if tag == FunctionComponent then
		if __DEV__ then
			validateFunctionComponentInDev(p2, v2)

			local v4 = resolveFunctionForHotReloading(v2)

			p2.type = v4
			v2 = v4
		end

		return updateFunctionComponent(nil, p2, v2, v3, p5)
	end

	if tag == ClassComponent then
		if __DEV__ then
			local v5 = resolveClassForHotReloading(v2)

			p2.type = v5
			v2 = v5
		end

		return updateClassComponent(nil, p2, v2, v3, p5)
	end

	if tag == ForwardRef then
		if __DEV__ then
			local v6 = resolveForwardRefForHotReloading(v2)

			p2.type = v6
			v2 = v6
		end

		return updateForwardRef(nil, p2, v2, v3, p5)
	end

	if tag == MemoComponent then
		if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p2.type ~= p2.elementType then
			local propTypes = v2.propTypes
			local validateProps = v2.validateProps

			if propTypes or validateProps then
				checkPropTypes(propTypes, validateProps, v3, "prop", getComponentName(v2))
			end
		end

		return updateMemoComponent(nil, p2, v2, resolveDefaultProps(v2.type, v3), p4, p5)
	end

	local v7 = ""

	if __DEV__ and (v2 == nil or (type(v2) ~= "table" or v2["$$typeof"] ~= REACT_LAZY_TYPE)) then
		if type(v2) == "table" and v2["$$typeof"] == nil then
			v7 = "\n" .. inspect(v2)
		end
	elseif __DEV__ then
		v7 = " Did you wrap a component in React.lazy() more than once?"
	end

	invariant(false, "Element type is invalid. Received a promise that resolves to: %s. Lazy element type must resolve to a class or function.%s", tostring(v2), v7)

	return nil
end

function mountIncompleteClassComponent(p1, p2, p3, p4, p5) --[[ mountIncompleteClassComponent | Line: 1457 | Upvalues: Placement (copy), ClassComponent (copy), isContextProvider (copy), pushContextProvider (copy), prepareToReadContext (copy), t2 (copy), constructClassInstance (copy), mountClassInstance (copy) ]]
	if p1 ~= nil then
		p1.alternate = nil
		p2.alternate = nil
		p2.flags = bit32.bor(p2.flags, Placement)
	end

	p2.tag = ClassComponent

	local v2

	if isContextProvider(p3) then
		pushContextProvider(p2)
		v2 = true
	else
		v2 = false
	end

	prepareToReadContext(p2, p5, t2.markWorkInProgressReceivedUpdate)
	constructClassInstance(p2, p3, p4)
	mountClassInstance(p2, p3, p4, p5)

	return finishClassComponent(nil, p2, p3, true, v2, p5)
end

local function mountIndeterminateComponent(p1, p2, p3, p4) --[[ mountIndeterminateComponent | Line: 1509 | Upvalues: Placement (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), prepareToReadContext (copy), t2 (copy), __DEV__ (copy), getComponentName (copy), t3 (copy), console (copy), StrictMode (copy), v3 (copy), setIsRendering (copy), ReactCurrentOwner (copy), renderWithHooks (copy), PerformedWork (copy), disableModulePatternComponents (copy), ClassComponent (copy), isContextProvider (copy), pushContextProvider (copy), initializeUpdateQueue (copy), applyDerivedStateFromProps (copy), adoptClassInstance (copy), mountClassInstance (copy), FunctionComponent (copy), debugRenderPhaseSideEffectsForStrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), mountChildFibers (copy) ]]
	if p1 ~= nil then
		p1.alternate = nil
		p2.alternate = nil
		p2.flags = bit32.bor(p2.flags, Placement)
	end

	local pendingProps = p2.pendingProps
	local v2 = if disableLegacyContext then nil else getMaskedContext(p2, (getUnmaskedContext(p2, p3, false)))

	prepareToReadContext(p2, p4, t2.markWorkInProgressReceivedUpdate)

	local v4

	if __DEV__ then
		if type(p3) == "table" and type(p3.render) == "function" then
			local v5 = getComponentName(p3) or "Unknown"

			if not t3.didWarnAboutBadClass[v5] then
				console.error("The <%s /> component appears to have a render method, but doesn\'t extend React.Component. This is likely to cause errors. Change %s to extend React.Component instead.", v5, v5)
				t3.didWarnAboutBadClass[v5] = true
			end
		end

		if bit32.band(p2.mode, StrictMode) ~= 0 then
			v3.recordLegacyContextWarning(p2)
		end

		setIsRendering(true)
		ReactCurrentOwner.current = p2

		local v7 = renderWithHooks(nil, p2, p3, pendingProps, v2, p4)

		setIsRendering(false)
		v4 = v7
	else
		v4 = renderWithHooks(nil, p2, p3, pendingProps, v2, p4)
	end

	p2.flags = bit32.bor(p2.flags, PerformedWork)

	local v10 = type(v4)

	if __DEV__ and (v4 ~= nil and v10 == "table") and (type(v4.render) == "function" and v4["$$typeof"] == nil) then
		local v11 = getComponentName(p3) or "Unknown"

		if not t3.didWarnAboutModulePatternComponent[v11] then
			console.error("The <%s /> component appears to be a function component that returns a class instance. Change %s to a class that extends React.Component instead. ", v11, v11)
			t3.didWarnAboutModulePatternComponent[v11] = true
		end
	end

	if not disableModulePatternComponents and (v4 ~= nil and v10 == "table") and (type(v4.render) == "function" and v4["$$typeof"] == nil) then
		if __DEV__ then
			local v12 = getComponentName(p3) or "Unknown"

			if not t3.didWarnAboutModulePatternComponent[v12] then
				console.error("The <%s /> component appears to be a function component that returns a class instance. " .. "Change %s to a class that extends React.Component instead. " .. v12, v12)
				t3.didWarnAboutModulePatternComponent[v12] = true
			end
		end

		p2.tag = ClassComponent
		p2.memoizedState = nil
		p2.updateQueue = nil

		local v13

		if isContextProvider(p3) then
			pushContextProvider(p2)
			v13 = true
		else
			v13 = false
		end

		p2.memoizedState = v4.state
		initializeUpdateQueue(p2)

		local v14 = if type(p3) == "function" then nil else p3.getDerivedStateFromProps

		if v14 ~= nil and type(v14) == "function" then
			applyDerivedStateFromProps(p2, p3, v14, pendingProps)
		end

		adoptClassInstance(p2, v4)
		mountClassInstance(p2, p3, pendingProps, p4)

		return finishClassComponent(nil, p2, p3, true, v13, p4)
	end

	p2.tag = FunctionComponent

	if __DEV__ then
		if disableLegacyContext and p3.contextTypes then
			console.error("%s uses the legacy contextTypes API which is no longer supported. Use React.createContext() with React.useContext() instead.", getComponentName(p3) or "Unknown")
		end

		if debugRenderPhaseSideEffectsForStrictMode and bit32.band(p2.mode, StrictMode) ~= 0 then
			disableLogs()

			local ok, result = xpcall(renderWithHooks, describeError, nil, p2, p3, pendingProps, v2, p4)

			reenableLogs()

			if ok then
				v4 = result
			else
				error(result)
			end
		end
	end

	p2.child = mountChildFibers(p2, nil, v4, p4)

	if __DEV__ then
		validateFunctionComponentInDev(p2, p3)
	end

	return p2.child
end

function validateFunctionComponentInDev(p1, p2) --[[ validateFunctionComponentInDev | Line: 1726 | Upvalues: __DEV__ (copy), getCurrentFiberOwnerNameInDevOrNull (copy), t3 (copy), console (copy), warnAboutDefaultPropsOnFunctionComponents (copy), getComponentName (copy) ]]
	if not __DEV__ then
		return
	end

	if p1.ref ~= nil then
		local v1 = ""
		local v2 = getCurrentFiberOwnerNameInDevOrNull()

		if v2 then
			v1 = v1 .. "\n\nCheck the render method of `" .. v2 .. "`."
		end

		local v3 = if v2 then v2 else p1._debugID or ""
		local _debugSource = p1._debugSource

		if _debugSource then
			v3 = _debugSource.fileName .. ":" .. _debugSource.lineNumber
		end

		if not t3.didWarnAboutFunctionRefs[v3] then
			t3.didWarnAboutFunctionRefs[v3] = true
			console.error("Function components cannot be given refs. Attempts to access this ref will fail. Did you mean to use React.forwardRef()?%s", v1)
		end
	end

	if warnAboutDefaultPropsOnFunctionComponents and (type(p2) ~= "function" and p2.defaultProps ~= nil) then
		local v4 = getComponentName(p2) or "Unknown"

		if not t3.didWarnAboutDefaultPropsOnFunctionComponent[v4] then
			console.error("%s: Support for defaultProps will be removed from function components in a future major release.", v4)
			t3.didWarnAboutDefaultPropsOnFunctionComponent[v4] = true
		end
	end

	if type(p2) ~= "function" and p2.getDerivedStateFromProps ~= nil and type(p2.getDerivedStateFromProps) == "function" then
		local v5 = getComponentName(p2) or "Unknown"

		if not t3.didWarnAboutGetDerivedStateOnFunctionComponent[v5] then
			console.error("%s: Function components do not support getDerivedStateFromProps.", v5)
			t3.didWarnAboutGetDerivedStateOnFunctionComponent[v5] = true
		end
	end

	if type(p2) == "function" or p2.contextType == nil then
		return
	end

	if type(p2.contextType) ~= "table" then
		return
	end

	local v6 = getComponentName(p2) or "Unknown"

	if t3.didWarnAboutContextTypeOnFunctionComponent[v6] then
		return
	end

	console.error("%s: Function components do not support contextType.", v6)
	t3.didWarnAboutContextTypeOnFunctionComponent[v6] = true
end

local t4 = {
	dehydrated = nil,
	retryLane = ReactFiberLane.NoLane
}

local function mountSuspenseOffscreenState(p1) --[[ mountSuspenseOffscreenState | Line: 1823 ]]
	return {
		baseLanes = p1
	}
end

local function updateSuspenseOffscreenState(p1, p2) --[[ updateSuspenseOffscreenState | Line: 1829 | Upvalues: ReactFiberLane (copy) ]]
	return {
		baseLanes = ReactFiberLane.mergeLanes(p1.baseLanes, p2)
	}
end

local function shouldRemainOnFallback(p1, p2, p3, p4) --[[ shouldRemainOnFallback | Line: 1839 | Upvalues: hasSuspenseContext (copy), ForceSuspenseFallback (copy) ]]
	if p2 == nil or p2.memoizedState ~= nil then
		return hasSuspenseContext(p1, ForceSuspenseFallback)
	end

	return false
end

local function getRemainingWorkInPrimaryTree(p1, p2) --[[ getRemainingWorkInPrimaryTree | Line: 1863 | Upvalues: ReactFiberLane (copy) ]]
	return ReactFiberLane.removeLanes(p1.childLanes, p2)
end

local v19 = nil
local v20 = nil
local v21 = nil
local v22 = nil
local v23 = nil

local function updateSuspenseComponent(p1, p2, p3) --[[ updateSuspenseComponent | Line: 1875 | Upvalues: __DEV__ (copy), t (copy), DidCapture (copy), suspenseStackCursor (copy), NoFlags (copy), hasSuspenseContext (copy), ForceSuspenseFallback (copy), addSubtreeSuspenseContext (copy), InvisibleParentSuspenseContext (copy), setDefaultShallowSuspenseContext (copy), pushSuspenseContext (copy), tryToClaimNextHydratableInstance (copy), enableSuspenseServerRenderer (copy), v20 (ref), t4 (copy), ReactFiberLane (copy), enableSchedulerTracing (copy), markSpawnedWork (copy), v21 (ref), v23 (ref), v22 (ref), v19 (ref) ]]
	local pendingProps = p2.pendingProps

	if __DEV__ then
		if not t.shouldSuspendRef then
			t.shouldSuspendRef = require(script.Parent:WaitForChild("ReactFiberReconciler")).shouldSuspend
		end

		if t.shouldSuspendRef(p2) then
			p2.flags = bit32.bor(p2.flags, DidCapture)
		end
	end

	local current = suspenseStackCursor.current
	local v2 = false
	local v4 = if bit32.band(p2.flags, DidCapture) == NoFlags then false else true

	if v4 or (if p1 == nil or p1.memoizedState ~= nil then hasSuspenseContext(current, ForceSuspenseFallback) else false) then
		local v5, v6, v7

		v5 = p2.flags
		v6 = DidCapture
		v7 = bit32.bnot(DidCapture)
		p2.flags = bit32.band(v5, v7)
		v2 = true
	elseif (p1 == nil or p1.memoizedState ~= nil) and (pendingProps.fallback ~= nil and pendingProps.unstable_avoidThisFallback ~= true) then
		current = addSubtreeSuspenseContext(current, InvisibleParentSuspenseContext)
	end

	pushSuspenseContext(p2, (setDefaultShallowSuspenseContext(current)))

	if p1 == nil then
		if pendingProps.fallback ~= nil then
			tryToClaimNextHydratableInstance(p2)

			if enableSuspenseServerRenderer then
				local memoizedState = p2.memoizedState

				if memoizedState ~= nil then
					local dehydrated = memoizedState.dehydrated

					if dehydrated ~= nil then
						return v20(p2, dehydrated, p3)
					end
				end
			end
		end

		local children = pendingProps.children
		local fallback = pendingProps.fallback

		if v2 then
			local v11 = mountSuspenseFallbackChildren(p2, children, fallback, p3)

			p2.child.memoizedState = {
				baseLanes = p3
			}
			p2.memoizedState = t4

			return v11
		end

		if pendingProps.unstable_expectedLoadTime == nil then
			return v21(p2, children, p3)
		end

		if type(pendingProps.unstable_expectedLoadTime) ~= "number" then
			return v21(p2, children, p3)
		end

		local v12 = mountSuspenseFallbackChildren(p2, children, fallback, p3)

		p2.child.memoizedState = {
			baseLanes = p3
		}
		p2.memoizedState = t4
		p2.lanes = ReactFiberLane.SomeRetryLane

		if not enableSchedulerTracing then
			return v12
		end

		markSpawnedWork(ReactFiberLane.SomeRetryLane)

		return v12
	end

	local memoizedState = p1.memoizedState

	if memoizedState == nil then
		if not v2 then
			local v13 = v19(p1, p2, pendingProps.children, p3)

			p2.memoizedState = nil

			return v13
		end

		local v14 = v22(p1, p2, pendingProps.children, pendingProps.fallback, p3)
		local child = p2.child
		local memoizedState2 = p1.child.memoizedState

		if memoizedState2 == nil then
			child.memoizedState = {
				baseLanes = p3
			}
		else
			child.memoizedState = {
				baseLanes = ReactFiberLane.mergeLanes(memoizedState2.baseLanes, p3)
			}
		end

		child.childLanes = ReactFiberLane.removeLanes(p1.childLanes, p3)
		p2.memoizedState = t4

		return v14
	end

	if enableSuspenseServerRenderer then
		local dehydrated = memoizedState.dehydrated

		if dehydrated ~= nil then
			if not v4 then
				return v23(p1, p2, dehydrated, memoizedState, p3)
			end

			if p2.memoizedState == nil then
				local v15 = mountSuspenseFallbackAfterRetryWithoutHydrating(p1, p2, pendingProps.children, pendingProps.fallback, p3)

				p2.child.memoizedState = {
					baseLanes = p3
				}
				p2.memoizedState = t4

				return v15
			end

			p2.child = p1.child
			p2.flags = bit32.bor(p2.flags, DidCapture)

			return nil
		end
	end

	if not v2 then
		local v17 = v19(p1, p2, pendingProps.children, p3)

		p2.memoizedState = nil

		return v17
	end

	local v18 = v22(p1, p2, pendingProps.children, pendingProps.fallback, p3)
	local child = p2.child
	local memoizedState2 = p1.child.memoizedState

	if memoizedState2 == nil then
		child.memoizedState = {
			baseLanes = p3
		}
	else
		child.memoizedState = {
			baseLanes = ReactFiberLane.mergeLanes(memoizedState2.baseLanes, p3)
		}
	end

	child.childLanes = ReactFiberLane.removeLanes(p1.childLanes, p3)
	p2.memoizedState = t4

	return v18
end

v21 = function(p1, p2, p3) --[[ mountSuspensePrimaryChildren | Line: 2160 | Upvalues: createFiberFromOffscreen (copy) ]]
	local v1 = createFiberFromOffscreen({
		mode = "visible",
		children = p2
	}, p1.mode, p3, nil)

	v1.return_ = p1
	p1.child = v1

	return v1
end
function mountSuspenseFallbackChildren(p1, p2, p3, p4) --[[ mountSuspenseFallbackChildren | Line: 2173 | Upvalues: BlockingMode (copy), NoMode (copy), ReactFiberLane (copy), enableProfilerTimer (copy), ProfileMode (copy), createFiberFromFragment (copy), createFiberFromOffscreen (copy) ]]
	local mode = p1.mode
	local child = p1.child
	local t = {
		mode = "hidden",
		children = p2
	}
	local v2, v3

	if bit32.band(mode, BlockingMode) == NoMode and child ~= nil then
		child.childLanes = ReactFiberLane.NoLanes
		child.pendingProps = t

		if enableProfilerTimer and bit32.band(p1.mode, ProfileMode) ~= 0 then
			child.actualDuration = 0
			child.actualStartTime = -1
			child.selfBaseDuration = 0
			child.treeBaseDuration = 0
		end

		v2 = child
		v3 = createFiberFromFragment(p3, mode, p4, nil)
	else
		local v6 = createFiberFromOffscreen(t, mode, ReactFiberLane.NoLanes, nil)

		v2, v3 = v6, createFiberFromFragment(p3, mode, p4, nil)
	end

	v2.return_ = p1
	v3.return_ = p1
	v2.sibling = v3
	p1.child = v2

	return v3
end

local function createWorkInProgressOffscreenFiber(p1, p2) --[[ createWorkInProgressOffscreenFiber | Line: 2223 | Upvalues: createWorkInProgress (copy) ]]
	return createWorkInProgress(p1, p2)
end

v19 = function(p1, p2, p3, p4) --[[ updateSuspensePrimaryChildren | Line: 2232 | Upvalues: createWorkInProgress (copy), BlockingMode (copy), NoMode (copy), Deletion (copy) ]]
	local child = p1.child
	local sibling = child.sibling
	local v1 = createWorkInProgress(child, {
		mode = "visible",
		children = p3
	})

	if bit32.band(p2.mode, BlockingMode) == NoMode then
		v1.lanes = p4
	end

	local v3 = v1

	v3.return_ = p2
	v3.sibling = nil

	if sibling ~= nil then
		local deletions = p2.deletions

		if deletions == nil then
			p2.deletions = { sibling }
			p2.flags = bit32.bor(p2.flags, Deletion)
		else
			table.insert(deletions, sibling)
		end
	end

	p2.child = v3

	return v3
end
v22 = function(p1, p2, p3, p4, p5) --[[ updateSuspenseFallbackChildren | Line: 2267 | Upvalues: BlockingMode (copy), NoMode (copy), ReactFiberLane (copy), enableProfilerTimer (copy), ProfileMode (copy), createWorkInProgress (copy), StaticMask (copy), createFiberFromFragment (copy), Placement (copy) ]]
	local mode = p2.mode
	local child = p1.child
	local sibling = child.sibling
	local t = {
		mode = "hidden",
		children = p3
	}
	local v2

	if bit32.band(mode, BlockingMode) == NoMode and p2.child ~= child then
		local child2 = p2.child

		child2.childLanes = ReactFiberLane.NoLanes
		child2.pendingProps = t

		if enableProfilerTimer and bit32.band(p2.mode, ProfileMode) ~= 0 then
			child2.actualDuration = 0
			child2.actualStartTime = -1
			child2.selfBaseDuration = child.selfBaseDuration
			child2.treeBaseDuration = child.treeBaseDuration
		end

		v2 = child2
		p2.deletions = nil
	else
		v2 = createWorkInProgress(child, t)
		v2.subtreeFlags = bit32.band(child.subtreeFlags, StaticMask)
	end

	local v5

	if sibling == nil then
		local v6 = createFiberFromFragment(p4, mode, p5, nil)

		v6.flags = bit32.bor(v6.flags, Placement)
		v5 = v6
	else
		v5 = createWorkInProgress(sibling, p4)
	end

	v5.return_ = p2
	v2.return_ = p2
	v2.sibling = v5
	p2.child = v2

	return v5
end

local function retrySuspenseComponentWithoutHydrating(p1, p2, p3) --[[ retrySuspenseComponentWithoutHydrating | Line: 2350 | Upvalues: reconcileChildFibers (copy), v21 (ref), Placement (copy) ]]
	reconcileChildFibers(p2, p1.child, nil, p3)

	local v1 = v21(p2, p2.pendingProps.children, p3)

	v1.flags = bit32.bor(v1.flags, Placement)
	p2.memoizedState = nil

	return v1
end

function mountSuspenseFallbackAfterRetryWithoutHydrating(p1, p2, p3, p4, p5) --[[ mountSuspenseFallbackAfterRetryWithoutHydrating | Line: 2371 | Upvalues: createFiberFromOffscreen (copy), ReactFiberLane (copy), createFiberFromFragment (copy), Placement (copy), BlockingMode (copy), NoMode (copy), reconcileChildFibers (copy) ]]
	local mode = p2.mode
	local v1 = createFiberFromOffscreen(p3, mode, ReactFiberLane.NoLanes, nil)
	local v2 = createFiberFromFragment(p4, mode, p5, nil)

	v2.flags = bit32.bor(v2.flags, Placement)
	v1.return_ = p2
	v2.return_ = p2
	v1.sibling = v2
	p2.child = v1

	if bit32.band(p2.mode, BlockingMode) == NoMode then
		return v2
	end

	reconcileChildFibers(p2, p1.child, nil, p5)

	return v2
end
v20 = function(p1, p2, p3) --[[ mountDehydratedSuspenseComponent | Line: 2401 | Upvalues: BlockingMode (copy), NoMode (copy), __DEV__ (copy), console (copy), ReactFiberLane (copy), isSuspenseInstanceFallback (copy), enableSchedulerTracing (copy), markSpawnedWork (copy) ]]
	if bit32.band(p1.mode, BlockingMode) == NoMode then
		if __DEV__ then
			console.error("Cannot hydrate Suspense in legacy mode. Switch fromReactDOM.hydrate(element, container) to ReactDOM.createBlockingRoot(container, { hydrate: true }).render(element) or remove the Suspense componentsthe server rendered components.")
		end

		p1.lanes = ReactFiberLane.laneToLanes(ReactFiberLane.SyncLane)
	elseif isSuspenseInstanceFallback(p2) then
		if enableSchedulerTracing then
			markSpawnedWork(ReactFiberLane.DefaultHydrationLane)
		end

		p1.lanes = ReactFiberLane.laneToLanes(ReactFiberLane.DefaultHydrationLane)
	else
		p1.lanes = ReactFiberLane.laneToLanes(ReactFiberLane.OffscreenLane)

		if not enableSchedulerTracing then
			return nil
		end

		markSpawnedWork(ReactFiberLane.OffscreenLane)
	end

	return nil
end
v23 = function(p1, p2, p3, p4, p5) --[[ updateDehydratedSuspenseComponent | Line: 2448 | Upvalues: warnIfHydrating (copy), getExecutionContext (copy), RetryAfterError (copy), NoContext (copy), reconcileChildFibers (copy), v21 (ref), Placement (copy), BlockingMode (copy), NoMode (copy), isSuspenseInstanceFallback (copy), ReactFiberLane (copy), v17 (ref), getWorkInProgressRoot (copy), scheduleUpdateOnFiber (copy), renderDidSuspendDelayIfPossible (copy), isSuspenseInstancePending (copy), DidCapture (copy), retryDehydratedSuspenseBoundary (copy), enableSchedulerTracing (copy), v14 (ref), registerSuspenseInstanceRetry (copy), reenterHydrationStateFromDehydratedSuspenseInstance (copy), Hydrating (copy) ]]
	warnIfHydrating()

	if bit32.band(getExecutionContext(), RetryAfterError) ~= NoContext then
		reconcileChildFibers(p2, p1.child, nil, p5)

		local v3 = v21(p2, p2.pendingProps.children, p5)

		v3.flags = bit32.bor(v3.flags, Placement)
		p2.memoizedState = nil

		return v3
	end

	if bit32.band(p2.mode, BlockingMode) == NoMode then
		reconcileChildFibers(p2, p1.child, nil, p5)

		local v6 = v21(p2, p2.pendingProps.children, p5)

		v6.flags = bit32.bor(v6.flags, Placement)
		p2.memoizedState = nil

		return v6
	end

	if isSuspenseInstanceFallback(p3) then
		reconcileChildFibers(p2, p1.child, nil, p5)

		local v8 = v21(p2, p2.pendingProps.children, p5)

		v8.flags = bit32.bor(v8.flags, Placement)
		p2.memoizedState = nil

		return v8
	end

	if v17 or ReactFiberLane.includesSomeLane(p5, p1.childLanes) then
		local v10 = getWorkInProgressRoot()

		if v10 ~= nil then
			local v11 = ReactFiberLane.getBumpedLaneForHydration(v10, p5)

			if v11 ~= ReactFiberLane.NoLane and v11 ~= p4.retryLane then
				p4.retryLane = v11
				scheduleUpdateOnFiber(p1, v11, ReactFiberLane.NoTimestamp)
			end
		end

		renderDidSuspendDelayIfPossible()
		reconcileChildFibers(p2, p1.child, nil, p5)

		local v12 = v21(p2, p2.pendingProps.children, p5)

		v12.flags = bit32.bor(v12.flags, Placement)
		p2.memoizedState = nil

		return v12
	end

	if not isSuspenseInstancePending(p3) then
		reenterHydrationStateFromDehydratedSuspenseInstance(p2, p3)

		local v142 = v21(p2, p2.pendingProps.children, p5)

		v142.flags = bit32.bor(v142.flags, Hydrating)

		return v142
	end

	p2.flags = bit32.bor(p2.flags, DidCapture)
	p2.child = p1.child

	local function f17() --[[ Line: 2544 | Upvalues: retryDehydratedSuspenseBoundary (ref), p1 (copy) ]]
		return retryDehydratedSuspenseBoundary(p1)
	end

	if enableSchedulerTracing then
		if v14 == nil then
			v14 = require(script.Parent.Parent:WaitForChild("scheduler")).tracing.unstable_wrap
		end

		f17 = v14(f17)
	end

	registerSuspenseInstanceRetry(p3, f17)

	return nil
end
function updatePortalComponent(p1, p2, p3) --[[ updatePortalComponent | Line: 2958 | Upvalues: pushHostContainer (copy), reconcileChildFibers (copy), mountChildFibers (copy) ]]
	pushHostContainer(p2, p2.stateNode.containerInfo)

	local pendingProps = p2.pendingProps

	if p1 == nil then
		p2.child = reconcileChildFibers(p2, nil, pendingProps, p3)
	elseif p1 == nil then
		p2.child = mountChildFibers(p2, nil, pendingProps, p3)
	else
		p2.child = reconcileChildFibers(p2, p1.child, pendingProps, p3)
	end

	return p2.child
end

local v24 = false

local function updateContextProvider(p1, p2, p3) --[[ updateContextProvider | Line: 2981 | Upvalues: __DEV__ (copy), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), Array (copy), Object (copy), v24 (ref), console (copy), checkPropTypes (copy), pushProvider (copy), calculateChangedBits (copy), hasContextChanged (copy), v15 (ref), propagateContextChange (copy), mountChildFibers (copy), reconcileChildFibers (copy) ]]
	local _context = p2.type._context
	local pendingProps = p2.pendingProps
	local memoizedProps = p2.memoizedProps
	local value = pendingProps.value

	if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
		if Array.indexOf(Object.keys(pendingProps), "value") < 1 and not v24 then
			v24 = true
			console.error("The `value` prop is required for the `<Context.Provider>`. Did you misspell it or forget to pass it?")
		end

		local propTypes = p2.type.propTypes
		local validateProps = p2.type.validateProps

		if propTypes or validateProps then
			checkPropTypes(propTypes, validateProps, pendingProps, "prop", "Context.Provider")
		end
	end

	pushProvider(p2, value)

	if memoizedProps ~= nil then
		local v1 = calculateChangedBits(_context, value, memoizedProps.value)

		if v1 == 0 then
			if memoizedProps.children == pendingProps.children and not hasContextChanged() then
				return v15(p1, p2, p3)
			end
		else
			propagateContextChange(p2, _context, v1, p3)
		end
	end

	local children = pendingProps.children

	if p1 == nil then
		p2.child = mountChildFibers(p2, nil, children, p3)
	else
		p2.child = reconcileChildFibers(p2, p1.child, children, p3)
	end

	return p2.child
end

local t5 = {
	usingContextAsConsumer = false,
	usingLegacyConsumer = false
}

function updateContextConsumer(p1, p2, p3) --[[ updateContextConsumer | Line: 3049 | Upvalues: __DEV__ (copy), t5 (copy), console (copy), __COMPAT_WARNINGS__ (copy), prepareToReadContext (copy), t2 (copy), readContext (copy), ReactCurrentOwner (copy), setIsRendering (copy), PerformedWork (copy), mountChildFibers (copy), reconcileChildFibers (copy) ]]
	local v1 = p2.type

	if __DEV__ and v1._context == nil then
		if v1 ~= v1.Consumer and not t5.usingContextAsConsumer then
			t5.usingContextAsConsumer = true
			console.error("Rendering <Context> directly is not supported and will be removed in a future major release. Did you mean to render <Context.Consumer> instead?")
		end
	elseif __DEV__ then
		v1 = v1._context
	end

	local pendingProps = p2.pendingProps
	local v2

	if pendingProps.render then
		if __DEV__ and (__COMPAT_WARNINGS__ and not t5.usingLegacyConsumer) then
			t5.usingLegacyConsumer = true
			console.warn("Your Context.Consumer component is using legacy Roact syntax, which won\'t be supported in future versions of Roact. \nPlease provide no props and supply the \'render\' function as a child (the 3rd argument of createElement). For example: \n       createElement(ContextConsumer, {render = function(...) end})\nbecomes:\n       createElement(ContextConsumer, nil, function(...) end)\nFor more info, reference the React documentation here: \nhttps://reactjs.org/docs/context.html#contextconsumer")
		end

		v2 = pendingProps.render
	else
		v2 = pendingProps.children
	end

	if __DEV__ and type(v2) ~= "function" then
		console.error("A context consumer was rendered with multiple children, or a child that isn\'t a function. A context consumer expects a single child that is a function. If you did pass a function, make sure there is no trailing or leading whitespace around it.")
	end

	prepareToReadContext(p2, p3, t2.markWorkInProgressReceivedUpdate)

	local v3 = readContext(v1, pendingProps.unstable_observedBits)
	local v4

	if __DEV__ then
		ReactCurrentOwner.current = p2
		setIsRendering(true)

		local v5 = v2(v3)

		setIsRendering(false)
		v4 = v5
	else
		v4 = v2(v3)
	end

	p2.flags = bit32.bor(p2.flags, PerformedWork)

	if p1 == nil then
		p2.child = mountChildFibers(p2, nil, v4, p3)
	else
		p2.child = reconcileChildFibers(p2, p1.child, v4, p3)
	end

	return p2.child
end
function t2.markWorkInProgressReceivedUpdate() --[[ Line: 3159 | Upvalues: v17 (ref) ]]
	v17 = true
end

local function bailoutOnAlreadyFinishedWork(p1, p2, p3) --[[ bailoutOnAlreadyFinishedWork | Line: 3163 | Upvalues: enableProfilerTimer (copy), stopProfilerTimerIfRunning (copy), markSkippedUpdateLanes (copy), ReactFiberLane (copy), cloneChildFibers (copy) ]]
	if p1 then
		p2.dependencies = p1.dependencies
	end

	if enableProfilerTimer then
		stopProfilerTimerIfRunning(p2)
	end

	markSkippedUpdateLanes(p2.lanes)

	if ReactFiberLane.includesSomeLane(p3, p2.childLanes) then
		cloneChildFibers(p1, p2)

		return p2.child
	end

	return nil
end

function remountFiber(p1, p2, p3) --[[ remountFiber | Line: 3194 | Upvalues: __DEV__ (copy), Deletion (copy), Placement (copy) ]]
	if not __DEV__ then
		error("Did not expect this call in production. This is a bug in React. Please file an issue.")
	end

	local return_ = p2.return_

	if return_ == nil then
		error("Cannot swap the root fiber.")
	end

	assert(if return_ == nil then false else true, "returnFiber was nil in remountFiber")
	p1.alternate = nil
	p2.alternate = nil
	p3.index = p2.index
	p3.sibling = p2.sibling
	p3.return_ = p2.return_
	p3.ref = p2.ref

	if p2 == return_.child then
		return_.child = p3
	else
		local child = return_.child

		if child == nil then
			error("Expected parent to have a child.")
		end

		assert(if child == nil then false else true, "prevSibling was nil in remountFiber")

		while child.sibling ~= p2 do
			child = child.sibling

			if child == nil then
				error("Expected to find the previous sibling.")
			end
		end

		child.sibling = p3
	end

	local deletions = return_.deletions

	if deletions == nil then
		return_.deletions = { p1 }
		return_.flags = bit32.bor(return_.flags, Deletion)
	else
		table.insert(deletions, p1)
	end

	p3.flags = bit32.bor(p3.flags, Placement)

	return p3
end
function t2.beginWork(p1, p2, p3) --[[ beginWork | Line: 3263 | Upvalues: __DEV__ (copy), createFiberFromTypeAndProps (copy), hasContextChanged (copy), v17 (ref), ReactFiberLane (copy), HostRoot (copy), pushTopLevelContextObject (copy), pushHostContainer (copy), resetHydrationState (copy), HostComponent (copy), pushHostContext (copy), ClassComponent (copy), isContextProvider (copy), pushContextProvider (copy), HostPortal (copy), ContextProvider (copy), pushProvider (copy), Profiler (copy), enableProfilerTimer (copy), SuspenseComponent (copy), enableSuspenseServerRenderer (copy), pushSuspenseContext (copy), setDefaultShallowSuspenseContext (copy), suspenseStackCursor (copy), DidCapture (copy), updateSuspenseComponent (copy), bailoutOnAlreadyFinishedWork (ref), SuspenseListComponent (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy), updateOffscreenComponent (copy), ForceUpdateForLegacySuspense (copy), NoFlags (copy), ReactWorkTags (copy), mountIndeterminateComponent (copy), LazyComponent (copy), mountLazyComponent (copy), FunctionComponent (copy), resolveDefaultProps (copy), updateFunctionComponent (ref), updateClassComponent (copy), updateHostRoot (copy), updateHostComponent (copy), HostText (copy), tryToClaimNextHydratableInstance (copy), ForwardRef (copy), updateForwardRef (copy), Fragment (copy), Mode (copy), updateContextProvider (copy), ContextConsumer (copy), MemoComponent (copy), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), updateMemoComponent (copy), SimpleMemoComponent (copy), updateSimpleMemoComponent (ref), IncompleteClassComponent (copy), updateOffscreenComponent (copy), invariant (copy) ]]
	local lanes = p2.lanes

	if __DEV__ and (p2._debugNeedsRemount and p1 ~= nil) then
		return remountFiber(p1, p2, createFiberFromTypeAndProps(p2.type, p2.key, p2.pendingProps, p2._debugOwner or nil, p2.mode, p2.lanes))
	end

	local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v172, v18, v20

	if p1 == nil then
		v17 = false
	else
		local v19

		if p1.memoizedProps == p2.pendingProps and not hasContextChanged() and not (if __DEV__ then p2.type ~= p1.type else false) then
			if ReactFiberLane.includesSomeLane(p3, lanes) then
				v17 = if bit32.band(p1.flags, ForceUpdateForLegacySuspense) == NoFlags then false else true
				p2.lanes = ReactFiberLane.NoLanes

				if p2.tag == ReactWorkTags.IndeterminateComponent then
					return mountIndeterminateComponent(p1, p2, p2.type, p3)
				end

				if p2.tag == LazyComponent then
					return mountLazyComponent(p1, p2, p2.elementType, lanes, p3)
				end

				if p2.tag == FunctionComponent then
					v1 = p2.type
					v2 = p2.pendingProps

					if p2.elementType == v1 then
						v3 = v2
					else
						v4 = resolveDefaultProps(v1, v2)
						v3 = v4
					end

					return updateFunctionComponent(p1, p2, v1, v3, p3)
				end

				if p2.tag == ClassComponent then
					v5 = p2.type
					v6 = p2.pendingProps
					v7 = if p2.elementType == v5 and v6 then v6 else resolveDefaultProps(v5, v6)

					return updateClassComponent(p1, p2, v5, v7, p3)
				end

				if p2.tag == HostRoot then
					return updateHostRoot(p1, p2, p3)
				end

				if p2.tag == HostComponent then
					return updateHostComponent(p1, p2, p3)
				end

				if p2.tag == HostText then
					if p1 ~= nil then
						return nil
					end

					tryToClaimNextHydratableInstance(p2)

					return nil
				end

				if p2.tag == SuspenseComponent then
					return updateSuspenseComponent(p1, p2, p3)
				end

				if p2.tag == HostPortal then
					return updatePortalComponent(p1, p2, p3)
				end

				if p2.tag == ForwardRef then
					v8 = p2.type
					v9 = p2.pendingProps

					if p2.elementType == v8 then
						v10 = v9
					else
						v11 = resolveDefaultProps(v8, v9)
						v10 = v11
					end

					return updateForwardRef(p1, p2, v8, v10, p3)
				end

				if p2.tag == Fragment then
					return updateFragment(p1, p2, p3)
				end

				if p2.tag == Mode then
					return updateMode(p1, p2, p3)
				end

				if p2.tag == Profiler then
					return updateProfiler(p1, p2, p3)
				end

				if p2.tag == ContextProvider then
					return updateContextProvider(p1, p2, p3)
				end

				if p2.tag == ContextConsumer then
					return updateContextConsumer(p1, p2, p3)
				end

				if p2.tag == MemoComponent then
					v12 = p2.type
					v13 = resolveDefaultProps(v12, p2.pendingProps)

					if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p2.type ~= p2.elementType then
						if type(v12) == "table" then
							v14 = v12.propTypes
							v15 = v12.validateProps
						else
							v14 = nil
							v15 = nil
						end

						if v14 or v15 then
							checkPropTypes(v14, v15, v13, "prop", getComponentName(v12))
						end
					end

					return updateMemoComponent(p1, p2, v12, resolveDefaultProps(v12.type, v13), lanes, p3)
				end

				if p2.tag == SimpleMemoComponent then
					return updateSimpleMemoComponent(p1, p2, p2.type, p2.pendingProps, lanes, p3)
				end

				if p2.tag == IncompleteClassComponent then
					v16 = p2.type
					v172 = p2.pendingProps
					v18 = if p2.elementType == v16 and v172 then v172 else resolveDefaultProps(v16, v172)

					return mountIncompleteClassComponent(p1, p2, v16, v18, p3)
				end

				if p2.tag == OffscreenComponent then
					return updateOffscreenComponent(p1, p2, p3)
				end

				if p2.tag == LegacyHiddenComponent then
					return updateOffscreenComponent(p1, p2, p3)
				end

				v19 = invariant
				v20 = p2.tag
				invariant(false, "Unknown unit of work tag (%s). This error is likely caused by a bug in React. Please file an issue.", (tostring(v20)))

				return nil
			end

			v17 = false

			if p2.tag == HostRoot then
				local stateNode = p2.stateNode

				if stateNode.pendingContext then
					pushTopLevelContextObject(p2, stateNode.pendingContext, stateNode.pendingContext ~= stateNode.context)
				elseif stateNode.context then
					pushTopLevelContextObject(p2, stateNode.context, false)
				end

				pushHostContainer(p2, stateNode.containerInfo)
				resetHydrationState()
			elseif p2.tag == HostComponent then
				pushHostContext(p2)
			elseif p2.tag == ClassComponent then
				if isContextProvider(p2.type) then
					pushContextProvider(p2)
				end
			elseif p2.tag == HostPortal then
				pushHostContainer(p2, p2.stateNode.containerInfo)
			elseif p2.tag == ContextProvider then
				pushProvider(p2, p2.memoizedProps.value)
			elseif p2.tag == Profiler then
				if enableProfilerTimer then
					local stateNode = p2.stateNode

					stateNode.effectDuration = 0
					stateNode.passiveEffectDuration = 0
				end
			elseif p2.tag == SuspenseComponent then
				local memoizedState = p2.memoizedState

				if memoizedState == nil then
					pushSuspenseContext(p2, setDefaultShallowSuspenseContext(suspenseStackCursor.current))
				else
					if enableSuspenseServerRenderer and memoizedState.dehydrated ~= nil then
						pushSuspenseContext(p2, setDefaultShallowSuspenseContext(suspenseStackCursor.current))
						p2.flags = bit32.bor(p2.flags, DidCapture)

						return nil
					end

					if ReactFiberLane.includesSomeLane(p3, p2.child.childLanes) then
						return updateSuspenseComponent(p1, p2, p3)
					end

					pushSuspenseContext(p2, setDefaultShallowSuspenseContext(suspenseStackCursor.current))

					local v25 = bailoutOnAlreadyFinishedWork(p1, p2, p3)

					if v25 == nil then
						return nil
					end

					return v25.sibling
				end
			elseif p2.tag == SuspenseListComponent then
				print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
				print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
				print("UNIMPLEMENTED ERROR: " .. tostring("beginWork: SuspenseListComponent"))
				error("FIXME (roblox): beginWork: SuspenseListComponent is unimplemented", 2)
			elseif p2.tag == OffscreenComponent or p2.tag == LegacyHiddenComponent then
				p2.lanes = ReactFiberLane.NoLanes

				return updateOffscreenComponent(p1, p2, p3)
			end

			return bailoutOnAlreadyFinishedWork(p1, p2, p3)
		end

		v17 = true
	end

	p2.lanes = ReactFiberLane.NoLanes

	if p2.tag == ReactWorkTags.IndeterminateComponent then
		return mountIndeterminateComponent(p1, p2, p2.type, p3)
	end

	if p2.tag == LazyComponent then
		return mountLazyComponent(p1, p2, p2.elementType, lanes, p3)
	end

	if p2.tag == FunctionComponent then
		v1 = p2.type
		v2 = p2.pendingProps

		if p2.elementType == v1 then
			v3 = v2
		else
			v4 = resolveDefaultProps(v1, v2)
			v3 = v4
		end

		return updateFunctionComponent(p1, p2, v1, v3, p3)
	end

	if p2.tag == ClassComponent then
		v5 = p2.type
		v6 = p2.pendingProps
		v7 = if p2.elementType == v5 and v6 then v6 else resolveDefaultProps(v5, v6)

		return updateClassComponent(p1, p2, v5, v7, p3)
	end

	if p2.tag == HostRoot then
		return updateHostRoot(p1, p2, p3)
	end

	if p2.tag == HostComponent then
		return updateHostComponent(p1, p2, p3)
	end

	if p2.tag == HostText then
		if p1 ~= nil then
			return nil
		end

		tryToClaimNextHydratableInstance(p2)

		return nil
	end

	if p2.tag == SuspenseComponent then
		return updateSuspenseComponent(p1, p2, p3)
	end

	if p2.tag == HostPortal then
		return updatePortalComponent(p1, p2, p3)
	end

	if p2.tag == ForwardRef then
		v8 = p2.type
		v9 = p2.pendingProps

		if p2.elementType == v8 then
			v10 = v9
		else
			v11 = resolveDefaultProps(v8, v9)
			v10 = v11
		end

		return updateForwardRef(p1, p2, v8, v10, p3)
	end

	if p2.tag == Fragment then
		return updateFragment(p1, p2, p3)
	end

	if p2.tag == Mode then
		return updateMode(p1, p2, p3)
	end

	if p2.tag == Profiler then
		return updateProfiler(p1, p2, p3)
	end

	if p2.tag == ContextProvider then
		return updateContextProvider(p1, p2, p3)
	end

	if p2.tag == ContextConsumer then
		return updateContextConsumer(p1, p2, p3)
	end

	if p2.tag == MemoComponent then
		v12 = p2.type
		v13 = resolveDefaultProps(v12, p2.pendingProps)

		if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p2.type ~= p2.elementType then
			if type(v12) == "table" then
				v14 = v12.propTypes
				v15 = v12.validateProps
			else
				v14 = nil
				v15 = nil
			end

			if v14 or v15 then
				checkPropTypes(v14, v15, v13, "prop", getComponentName(v12))
			end
		end

		return updateMemoComponent(p1, p2, v12, resolveDefaultProps(v12.type, v13), lanes, p3)
	end

	if p2.tag == SimpleMemoComponent then
		return updateSimpleMemoComponent(p1, p2, p2.type, p2.pendingProps, lanes, p3)
	end

	if p2.tag == IncompleteClassComponent then
		v16 = p2.type
		v172 = p2.pendingProps
		v18 = if p2.elementType == v16 and v172 then v172 else resolveDefaultProps(v16, v172)

		return mountIncompleteClassComponent(p1, p2, v16, v18, p3)
	end

	if p2.tag == OffscreenComponent then
		return updateOffscreenComponent(p1, p2, p3)
	end

	if p2.tag == LegacyHiddenComponent then
		return updateOffscreenComponent(p1, p2, p3)
	end

	v20 = p2.tag
	invariant(false, "Unknown unit of work tag (%s). This error is likely caused by a bug in React. Please file an issue.", (tostring(v20)))

	return nil
end

return t2