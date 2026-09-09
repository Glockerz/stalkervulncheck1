-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local console, t, scheduler, describeError, promise, enqueueTask, IsSomeRendererActing, t3, v38, v39

do
	local __YOLO__ = _G.__YOLO__

	console = require(script.Parent.Parent:WaitForChild("shared")).console

	local Set = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Set

	t = {}
	require(script.Parent.Parent:WaitForChild("shared"))
	require(script.Parent:WaitForChild("ReactInternalTypes"))

	local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))

	scheduler = require(script.Parent.Parent:WaitForChild("scheduler"))
	require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"))

	local v1 = require(script.Parent:WaitForChild("ReactFiberStack.new"))
	local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
	local enableDebugTracing = ReactFeatureFlags.enableDebugTracing
	local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler
	local skipUnmountedBoundaries = ReactFeatureFlags.skipUnmountedBoundaries
	local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects
	local v2 = require(script.Parent.Parent:WaitForChild("shared"))

	describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError

	local ReactSharedInternals = v2.ReactSharedInternals
	local invariant = v2.invariant
	local v3 = require(script.Parent:WaitForChild("SchedulerWithReactIntegration.new"))
	local scheduleCallback = v3.scheduleCallback
	local cancelCallback = v3.cancelCallback
	local getCurrentPriorityLevel = v3.getCurrentPriorityLevel
	local runWithPriority = v3.runWithPriority
	local shouldYield = v3.shouldYield
	local requestPaint = v3.requestPaint
	local now = v3.now
	local NoPriority = v3.NoPriority
	local ImmediatePriority = v3.ImmediatePriority
	local UserBlockingPriority = v3.UserBlockingPriority
	local NormalPriority = v3.NormalPriority
	local flushSyncCallbackQueue = v3.flushSyncCallbackQueue
	local scheduleSyncCallback = v3.scheduleSyncCallback
	local DebugTracing = require(script.Parent:WaitForChild("DebugTracing"))
	local SchedulingProfiler = require(script.Parent:WaitForChild("SchedulingProfiler"))
	local tracing = require(script.Parent.Parent:WaitForChild("scheduler")).tracing
	local __interactionsRef = tracing.__interactionsRef
	local __subscriberRef = tracing.__subscriberRef
	local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"))
	local v4 = require(script.Parent:WaitForChild("ReactFiber.new"))
	local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"))
	local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
	local LegacyRoot = require(script.Parent:WaitForChild("ReactRootTags")).LegacyRoot
	local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
	local SyncLane = ReactFiberLane.SyncLane
	local SyncBatchedLane = ReactFiberLane.SyncBatchedLane
	local NoTimestamp = ReactFiberLane.NoTimestamp
	local findUpdateLane = ReactFiberLane.findUpdateLane
	local findTransitionLane = ReactFiberLane.findTransitionLane
	local findRetryLane = ReactFiberLane.findRetryLane
	local includesSomeLane = ReactFiberLane.includesSomeLane
	local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes
	local mergeLanes = ReactFiberLane.mergeLanes
	local removeLanes = ReactFiberLane.removeLanes
	local pickArbitraryLane = ReactFiberLane.pickArbitraryLane
	local hasDiscreteLanes = ReactFiberLane.hasDiscreteLanes
	local includesNonIdleWork = ReactFiberLane.includesNonIdleWork
	local includesOnlyRetries = ReactFiberLane.includesOnlyRetries
	local includesOnlyTransitions = ReactFiberLane.includesOnlyTransitions
	local getNextLanes = ReactFiberLane.getNextLanes
	local returnNextLanesPriority = ReactFiberLane.returnNextLanesPriority
	local setCurrentUpdateLanePriority = ReactFiberLane.setCurrentUpdateLanePriority
	local getCurrentUpdateLanePriority = ReactFiberLane.getCurrentUpdateLanePriority
	local markStarvedLanesAsExpired = ReactFiberLane.markStarvedLanesAsExpired
	local getLanesToRetrySynchronouslyOnError = ReactFiberLane.getLanesToRetrySynchronouslyOnError
	local getMostRecentEventTime = ReactFiberLane.getMostRecentEventTime
	local markRootUpdated = ReactFiberLane.markRootUpdated
	local markRootSuspended = ReactFiberLane.markRootSuspended
	local markRootPinged = ReactFiberLane.markRootPinged
	local markRootExpired = ReactFiberLane.markRootExpired
	local markDiscreteUpdatesExpired = ReactFiberLane.markDiscreteUpdatesExpired
	local markRootFinished = ReactFiberLane.markRootFinished
	local schedulerPriorityToLanePriority = ReactFiberLane.schedulerPriorityToLanePriority
	local lanePriorityToSchedulerPriority = ReactFiberLane.lanePriorityToSchedulerPriority
	local ReactFiberTransition = require(script.Parent:WaitForChild("ReactFiberTransition"))
	local v5 = require(script.Parent:WaitForChild("ReactFiberUnwindWork.new"))
	local unwindWork = v5.unwindWork
	local unwindInterruptedWork = v5.unwindInterruptedWork
	local v6 = require(script.Parent:WaitForChild("ReactFiberThrow.new"))
	local throwException = v6.throwException
	local createRootErrorUpdate = v6.createRootErrorUpdate
	local createClassErrorUpdate = v6.createClassErrorUpdate
	local v7 = require(script.Parent:WaitForChild("ReactFiberCommitWork.new"))
	local commitBeforeMutationLifeCycles = v7.commitBeforeMutationLifeCycles
	local commitPlacement = v7.commitPlacement
	local commitWork = v7.commitWork
	local commitDeletion = v7.commitDeletion
	local commitPassiveUnmount = v7.commitPassiveUnmount
	local commitPassiveUnmountInsideDeletedTree = v7.commitPassiveUnmountInsideDeletedTree
	local commitPassiveMount = v7.commitPassiveMount
	local commitDetachRef = v7.commitDetachRef
	local invokeLayoutEffectMountInDEV = v7.invokeLayoutEffectMountInDEV
	local invokePassiveEffectMountInDEV = v7.invokePassiveEffectMountInDEV
	local invokeLayoutEffectUnmountInDEV = v7.invokeLayoutEffectUnmountInDEV
	local invokePassiveEffectUnmountInDEV = v7.invokePassiveEffectUnmountInDEV
	local recursivelyCommitLayoutEffects = v7.recursivelyCommitLayoutEffects

	promise = require(script.Parent.Parent:WaitForChild("promise"))

	local enqueueUpdate = require(script.Parent:WaitForChild("ReactUpdateQueue.new")).enqueueUpdate
	local resetContextDependencies = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).resetContextDependencies
	local RobloxReactProfiling = require(script.Parent.RobloxReactProfiling)
	local v8 = nil
	local t2 = {
		resetHooksAfterThrowRef = nil,
		ContextOnlyDispatcherRef = nil,
		getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = nil,
		originalBeginWorkRef = nil,
		completeWorkRef = nil
	}

	local function f9(p1, p2, p3) --[[ Line: 240 | Upvalues: t2 (copy) ]]
		if t2.originalBeginWorkRef then
			return t2.originalBeginWorkRef(p1, p2, p3)
		end

		t2.originalBeginWorkRef = require(script.Parent:WaitForChild("ReactFiberBeginWork.new")).beginWork

		return t2.originalBeginWorkRef(p1, p2, p3)
	end

	local v10 = nil

	local function initReactFiberHooks() --[[ initReactFiberHooks | Line: 259 | Upvalues: v10 (ref), t2 (copy) ]]
		v10 = require(script.Parent:WaitForChild("ReactFiberHooks.new"))
		t2.resetHooksAfterThrowRef = v10.resetHooksAfterThrow
		t2.ContextOnlyDispatcherRef = v10.ContextOnlyDispatcher
		t2.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = v10.getIsUpdatingOpaqueValueInRenderPhaseInDEV
	end

	local createCapturedValue = require(script.Parent:WaitForChild("ReactCapturedValue")).createCapturedValue
	local push = v1.push
	local pop = v1.pop
	local v11 = require(script.Parent:WaitForChild("ReactProfilerTimer.new"))
	local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
	local v12 = require(script.Parent:WaitForChild("ReactStrictModeWarnings.new"))
	local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"))
	local current = ReactCurrentFiber.current
	local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber
	local setCurrentFiber = ReactCurrentFiber.setCurrentFiber
	local ReactErrorUtils = require(script.Parent.Parent:WaitForChild("shared")).ReactErrorUtils
	local invokeGuardedCallback = ReactErrorUtils.invokeGuardedCallback
	local hasCaughtError = ReactErrorUtils.hasCaughtError
	local clearCaughtError = ReactErrorUtils.clearCaughtError
	local onCommitRoot = require(script.Parent:WaitForChild("ReactFiberDevToolsHook.new")).onCommitRoot
	local onCommitRoot2 = require(script.Parent:WaitForChild("ReactTestSelectors")).onCommitRoot

	enqueueTask = require(script.Parent.Parent:WaitForChild("shared")).enqueueTask

	local doesFiberContain = require(script.Parent:WaitForChild("ReactFiberTreeReflection")).doesFiberContain
	local ReactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher
	local ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner

	IsSomeRendererActing = ReactSharedInternals.IsSomeRendererActing

	local v13 = nil

	t3 = {}
	t.NoContext = 0
	t.RetryAfterError = 64

	local v14 = 0
	local v15 = nil
	local v16 = nil
	local NoLanes = ReactFiberLane.NoLanes

	t.subtreeRenderLanes = ReactFiberLane.NoLanes

	local v17 = v1.createCursor(ReactFiberLane.NoLanes)
	local v18 = 0
	local v19 = nil
	local NoLanes2 = ReactFiberLane.NoLanes
	local ReactFiberWorkInProgress = require(script.Parent:WaitForChild("ReactFiberWorkInProgress"))
	local workInProgressRootSkippedLanes = ReactFiberWorkInProgress.workInProgressRootSkippedLanes
	local NoLanes3 = ReactFiberLane.NoLanes
	local NoLanes4 = ReactFiberLane.NoLanes
	local v20 = nil
	local v21 = 0
	local v22 = (1 / 0)
	local v23 = nil

	local function resetRenderTimer() --[[ resetRenderTimer | Line: 419 | Upvalues: v22 (ref), now (copy) ]]
		v22 = now() + 500
	end

	function t.getRenderTargetTime() --[[ Line: 423 | Upvalues: v22 (ref) ]]
		return v22
	end

	local v24 = false
	local v25 = nil
	local v26 = nil
	local v27 = false
	local v28 = nil
	local v29 = NoPriority
	local NoLanes5 = ReactFiberLane.NoLanes
	local v30 = nil
	local v31 = 0
	local v32 = nil
	local v33 = 0
	local v34 = nil
	local v35 = NoTimestamp
	local NoLanes6 = ReactFiberLane.NoLanes
	local NoLanes7 = ReactFiberLane.NoLanes
	local v36 = nil
	local v37 = false

	function t.getWorkInProgressRoot() --[[ Line: 463 | Upvalues: v15 (ref) ]]
		return v15
	end
	function t.requestEventTime() --[[ Line: 467 | Upvalues: v14 (ref), now (copy), v35 (ref), NoTimestamp (copy) ]]
		if bit32.band(v14, 48) ~= 0 then
			return now()
		end

		if v35 == NoTimestamp then
			v35 = now()
		end

		return v35
	end
	function t.requestUpdateLane(p1) --[[ Line: 489 | Upvalues: ReactTypeOfMode (copy), SyncLane (copy), getCurrentPriorityLevel (copy), ImmediatePriority (copy), SyncBatchedLane (copy), ReactFeatureFlags (copy), v14 (ref), NoLanes (ref), ReactFiberLane (copy), pickArbitraryLane (copy), NoLanes6 (ref), NoLanes2 (ref), ReactFiberTransition (copy), NoLanes7 (ref), v20 (ref), findTransitionLane (copy), UserBlockingPriority (copy), findUpdateLane (copy), schedulerPriorityToLanePriority (copy), getCurrentUpdateLanePriority (copy), __DEV__ (copy), console (copy) ]]
		local mode = p1.mode

		if bit32.band(mode, ReactTypeOfMode.BlockingMode) == ReactTypeOfMode.NoMode then
			return SyncLane
		end

		if bit32.band(mode, ReactTypeOfMode.ConcurrentMode) == ReactTypeOfMode.NoMode then
			if getCurrentPriorityLevel() == ImmediatePriority then
				return SyncLane
			end

			return SyncBatchedLane
		end

		if not ReactFeatureFlags.deferRenderPhaseUpdateToNextBatch and (bit32.band(v14, 16) ~= 0 and NoLanes ~= ReactFiberLane.NoLanes) then
			return pickArbitraryLane(NoLanes)
		end

		if NoLanes6 == ReactFiberLane.NoLanes then
			NoLanes6 = NoLanes2
		end

		local isNotNoTransition = ReactFiberTransition.requestCurrentTransition() ~= ReactFiberTransition.NoTransition

		if isNotNoTransition then
			if NoLanes7 == ReactFiberLane.NoLanes then
				return findTransitionLane(NoLanes6, NoLanes7)
			end

			NoLanes7 = if v20 == nil then ReactFiberLane.NoLanes else v20.pendingLanes

			return findTransitionLane(NoLanes6, NoLanes7)
		end

		local v2 = getCurrentPriorityLevel()

		if bit32.band(v14, 4) ~= 0 and v2 == UserBlockingPriority then
			return findUpdateLane(ReactFiberLane.InputDiscreteLanePriority, NoLanes6)
		end

		local v4 = schedulerPriorityToLanePriority(v2)

		if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
			local v5 = getCurrentUpdateLanePriority()

			if v4 ~= v5 and (v5 ~= ReactFiberLane.NoLanePriority and __DEV__) then
				console.error("Expected current scheduler lane priority %s to match current update lane priority %s", tostring(v4), (tostring(v5)))
			end
		end

		return findUpdateLane(v4, NoLanes6)
	end
	function requestRetryLane(p1) --[[ requestRetryLane | Line: 593 | Upvalues: ReactTypeOfMode (copy), SyncLane (copy), getCurrentPriorityLevel (copy), ImmediatePriority (copy), SyncBatchedLane (copy), NoLanes6 (ref), ReactFiberLane (copy), NoLanes2 (ref), findRetryLane (copy) ]]
		local mode = p1.mode

		if bit32.band(mode, ReactTypeOfMode.BlockingMode) == ReactTypeOfMode.NoMode then
			return SyncLane
		end

		if bit32.band(mode, ReactTypeOfMode.ConcurrentMode) == ReactTypeOfMode.NoMode then
			if getCurrentPriorityLevel() == ImmediatePriority then
				return SyncLane
			end

			return SyncBatchedLane
		end

		if NoLanes6 ~= ReactFiberLane.NoLanes then
			return findRetryLane(NoLanes6)
		end

		NoLanes6 = NoLanes2

		return findRetryLane(NoLanes2)
	end
	function t.scheduleUpdateOnFiber(p1, p2, p3) --[[ Line: 615 | Upvalues: t3 (copy), markRootUpdated (copy), v15 (ref), ReactFeatureFlags (copy), v14 (ref), NoLanes3 (ref), mergeLanes (copy), v18 (ref), NoLanes (ref), getCurrentPriorityLevel (copy), SyncLane (copy), v8 (ref), v22 (ref), now (copy), flushSyncCallbackQueue (copy), UserBlockingPriority (copy), ImmediatePriority (copy), v30 (ref), Set (copy), v20 (ref) ]]
		t3.checkForNestedUpdates()

		local v1 = t3.markUpdateLaneFromFiberToRoot(p1, p2)

		if v1 == nil then
			return nil
		end

		markRootUpdated(v1, p2, p3)

		if v1 == v15 then
			t3.warnAboutRenderPhaseUpdatesInDEV(p1)

			if ReactFeatureFlags.deferRenderPhaseUpdateToNextBatch or bit32.band(v14, 16) == 0 then
				NoLanes3 = mergeLanes(NoLanes3, p2)
			end

			if v18 == 4 then
				t3.markRootSuspended(v1, NoLanes)
			end
		end

		local v3 = getCurrentPriorityLevel()

		if p2 == SyncLane then
			if bit32.band(v14, 8) == 0 then
				v8(v1, p3)
				t3.schedulePendingInteractions(v1, p2)

				if v14 == 0 then
					v22 = now() + 500
					flushSyncCallbackQueue()
				end
			elseif bit32.band(v14, 48) == 0 then
				t3.schedulePendingInteractions(v1, p2)
				t3.performSyncWorkOnRoot(v1)
			else
				v8(v1, p3)
				t3.schedulePendingInteractions(v1, p2)

				if v14 == 0 then
					v22 = now() + 500
					flushSyncCallbackQueue()
				end
			end
		else
			if bit32.band(v14, 4) ~= 0 and (v3 == UserBlockingPriority or v3 == ImmediatePriority) then
				if v30 == nil then
					v30 = Set.new({ v1 })
				else
					v30:add(v1)
				end
			end

			v8(v1, p3)
			t3.schedulePendingInteractions(v1, p2)
		end

		v20 = v1

		return v1
	end
	function t3.markUpdateLaneFromFiberToRoot(p1, p2) --[[ Line: 725 | Upvalues: mergeLanes (copy), __DEV__ (copy), ReactFiberFlags (copy), t3 (copy), ReactWorkTags (copy) ]]
		p1.lanes = mergeLanes(p1.lanes, p2)

		local alternate = p1.alternate

		if alternate ~= nil then
			alternate.lanes = mergeLanes(alternate.lanes, p2)
		end

		if __DEV__ and alternate == nil and bit32.band(p1.flags, (bit32.bor(ReactFiberFlags.Placement, ReactFiberFlags.Hydrating))) ~= ReactFiberFlags.NoFlags then
			t3.warnAboutUpdateOnNotYetMountedFiberInDEV(p1)
		end

		local return_ = p1.return_
		local v2 = p1

		while return_ ~= nil do
			return_.childLanes = mergeLanes(return_.childLanes, p2)

			local alternate2 = return_.alternate

			if alternate2 == nil then
				if __DEV__ and bit32.band(return_.flags, (bit32.bor(ReactFiberFlags.Placement, ReactFiberFlags.Hydrating))) ~= ReactFiberFlags.NoFlags then
					t3.warnAboutUpdateOnNotYetMountedFiberInDEV(p1)
				end
			else
				alternate2.childLanes = mergeLanes(alternate2.childLanes, p2)
			end

			return_, v2 = return_.return_, return_
		end

		if v2.tag == ReactWorkTags.HostRoot then
			return v2.stateNode
		end

		return nil
	end
	v8 = function(p1, p2) --[[ Line: 780 | Upvalues: markStarvedLanesAsExpired (copy), v15 (ref), NoLanes (ref), ReactFiberLane (copy), getNextLanes (copy), returnNextLanesPriority (copy), cancelCallback (copy), scheduleSyncCallback (copy), RobloxReactProfiling (copy), t3 (copy), scheduleCallback (copy), ImmediatePriority (copy), lanePriorityToSchedulerPriority (copy) ]]
		local callbackNode = p1.callbackNode

		markStarvedLanesAsExpired(p1, p2)

		local v2 = getNextLanes(p1, if p1 == v15 then NoLanes else ReactFiberLane.NoLanes)
		local v3 = returnNextLanesPriority()

		if v2 == ReactFiberLane.NoLanes then
			if callbackNode == nil then
				return
			end

			cancelCallback(callbackNode)
			p1.callbackNode = nil
			p1.callbackPriority = ReactFiberLane.NoLanePriority
		else
			if callbackNode ~= nil then
				if p1.callbackPriority == v3 then
					return
				end

				cancelCallback(callbackNode)
			end

			local v4 = if v3 == ReactFiberLane.SyncLanePriority then scheduleSyncCallback(function() --[[ Line: 825 | Upvalues: RobloxReactProfiling (ref), p1 (copy), t3 (ref) ]]
	local v1 = RobloxReactProfiling.profileRootBeforeUnitOfWork(p1)
	local v2 = t3.performSyncWorkOnRoot(p1)

	RobloxReactProfiling.profileRootAfterYielding(v1)

	return v2
end) elseif v3 == ReactFiberLane.SyncBatchedLanePriority then scheduleCallback(ImmediatePriority, function() --[[ Line: 833 | Upvalues: RobloxReactProfiling (ref), p1 (copy), t3 (ref) ]]
	local v1 = RobloxReactProfiling.profileRootBeforeUnitOfWork(p1)
	local v2 = t3.performSyncWorkOnRoot(p1)

	RobloxReactProfiling.profileRootAfterYielding(v1)

	return v2
end) else scheduleCallback(lanePriorityToSchedulerPriority(v3), function() --[[ Line: 843 | Upvalues: RobloxReactProfiling (ref), p1 (copy), t3 (ref) ]]
	local v1 = RobloxReactProfiling.profileRootBeforeUnitOfWork(p1)
	local v2 = t3.performConcurrentWorkOnRoot(p1)

	RobloxReactProfiling.profileRootAfterYielding(v1)

	return v2
end)

			p1.callbackPriority = v3
			p1.callbackNode = v4
		end
	end
	function t3.performConcurrentWorkOnRoot(p1) --[[ Line: 859 | Upvalues: v35 (ref), NoTimestamp (copy), NoLanes6 (ref), ReactFiberLane (copy), NoLanes7 (ref), invariant (copy), v14 (ref), t (copy), getNextLanes (copy), v15 (ref), NoLanes (ref), t3 (copy), includesSomeLane (copy), NoLanes2 (ref), NoLanes3 (ref), ReactFiberHostConfig (copy), getLanesToRetrySynchronouslyOnError (copy), v19 (ref), v8 (ref), now (copy) ]]
		v35 = NoTimestamp
		NoLanes6 = ReactFiberLane.NoLanes
		NoLanes7 = ReactFiberLane.NoLanes
		invariant(if bit32.band(v14, 48) == 0 then true else false, "Should not already be working.")

		local callbackNode = p1.callbackNode

		if t.flushPassiveEffects() and p1.callbackNode ~= callbackNode then
			return nil
		end

		local v6 = getNextLanes(p1, if p1 == v15 then NoLanes else ReactFiberLane.NoLanes)

		if v6 == ReactFiberLane.NoLanes then
			return nil
		end

		local v7 = t3.renderRootConcurrent(p1, v6)

		if includesSomeLane(NoLanes2, NoLanes3) then
			t3.prepareFreshStack(p1, ReactFiberLane.NoLanes)
		elseif v7 ~= 0 then
			if v7 == 2 then
				v14 = bit32.bor(v14, 64)

				if p1.hydrate then
					p1.hydrate = false
					ReactFiberHostConfig.clearContainer(p1.containerInfo)
				end

				local v9 = getLanesToRetrySynchronouslyOnError(p1)

				if v9 == ReactFiberLane.NoLanes then
					v6 = v9
				else
					v7, v6 = t3.renderRootSync(p1, v9), v9
				end
			end

			if v7 == 1 then
				t3.prepareFreshStack(p1, ReactFiberLane.NoLanes)
				t3.markRootSuspended(p1, v6)
				v8(p1, now())
				error(v19)
			end

			p1.finishedWork = p1.current.alternate
			p1.finishedLanes = v6
			t3.finishConcurrentRender(p1, v7, v6)
		end

		v8(p1, now())

		if p1.callbackNode == callbackNode then
			return function() --[[ Line: 954 | Upvalues: t3 (ref), p1 (copy) ]]
				return t3.performConcurrentWorkOnRoot(p1)
			end
		end

		return nil
	end
	v38 = 0
	v39 = false
	function shouldForceFlushFallbacksInDEV() --[[ shouldForceFlushFallbacksInDEV | Line: 967 | Upvalues: __DEV__ (copy), v38 (ref) ]]
		return __DEV__ and v38 > 0
	end
	function t3.finishConcurrentRender(p1, p2, p3) --[[ Line: 972 | Upvalues: invariant (copy), t3 (copy), includesOnlyRetries (copy), v21 (ref), now (copy), getNextLanes (copy), ReactFiberLane (copy), isSubsetOfLanes (copy), t (copy), markRootPinged (copy), ReactFiberHostConfig (copy), includesOnlyTransitions (copy), getMostRecentEventTime (copy) ]]
		if p2 == 0 or p2 == 1 then
			invariant(false, "Root did not complete. This is a bug in React.")

			return
		end

		if p2 == 2 then
			t3.commitRoot(p1)

			return
		end

		if p2 == 3 then
			t3.markRootSuspended(p1, p3)

			if not includesOnlyRetries(p3) or shouldForceFlushFallbacksInDEV() then
				t3.commitRoot(p1)

				return
			end

			local v1 = v21 + 500 - now()

			if not (v1 > 10) then
				t3.commitRoot(p1)

				return
			end

			if getNextLanes(p1, ReactFiberLane.NoLanes) ~= ReactFiberLane.NoLanes then
				return
			end

			local suspendedLanes = p1.suspendedLanes

			if isSubsetOfLanes(suspendedLanes, p3) then
				p1.timeoutHandle = ReactFiberHostConfig.scheduleTimeout(function() --[[ Line: 1021 | Upvalues: t3 (ref), p1 (copy) ]]
					return t3.commitRoot(p1)
				end, v1)
			else
				markRootPinged(p1, suspendedLanes, (t.requestEventTime()))
			end
		elseif p2 == 4 then
			t3.markRootSuspended(p1, p3)

			if includesOnlyTransitions(p3) then
				return
			end

			if not shouldForceFlushFallbacksInDEV() then
				local v2 = getMostRecentEventTime(p1, p3)
				local v3 = now() - v2
				local v4 = jnd(v3) - v3

				if v4 > 10 then
					p1.timeoutHandle = ReactFiberHostConfig.scheduleTimeout(function() --[[ Line: 1056 | Upvalues: t3 (ref), p1 (copy) ]]
						return t3.commitRoot(p1)
					end, v4)

					return
				end
			end

			t3.commitRoot(p1)
		elseif p2 == 5 then
			t3.commitRoot(p1)
		else
			invariant(false, "Unknown root exit status.")
		end
	end
	function t3.markRootSuspended(p1, p2) --[[ Line: 1072 | Upvalues: removeLanes (copy), NoLanes4 (ref), NoLanes3 (ref), markRootSuspended (copy) ]]
		markRootSuspended(p1, (removeLanes(removeLanes(p2, NoLanes4), NoLanes3)))
	end
	function t3.performSyncWorkOnRoot(p1) --[[ Line: 1084 | Upvalues: invariant (copy), v14 (ref), t (copy), v15 (ref), includesSomeLane (copy), NoLanes (ref), t3 (copy), NoLanes2 (ref), NoLanes3 (ref), getNextLanes (copy), ReactFiberLane (copy), LegacyRoot (copy), ReactFiberHostConfig (copy), getLanesToRetrySynchronouslyOnError (copy), v19 (ref), v8 (ref), now (copy) ]]
		invariant(if bit32.band(v14, 48) == 0 then true else false, "Should not already be working.")
		t.flushPassiveEffects()

		local v4, v5

		if p1 == v15 and includesSomeLane(p1.expiredLanes, NoLanes) then
			v4 = NoLanes

			local v6 = t3.renderRootSync(p1, NoLanes)

			if includesSomeLane(NoLanes2, NoLanes3) then
				local v7 = getNextLanes(p1, NoLanes)

				v5, v4 = t3.renderRootSync(p1, v7), v7
			else
				v5 = v6
			end
		else
			local v9 = getNextLanes(p1, ReactFiberLane.NoLanes)

			v5, v4 = t3.renderRootSync(p1, v9), v9
		end

		if p1.tag ~= LegacyRoot and v5 == 2 then
			v14 = bit32.bor(v14, 64)

			if p1.hydrate then
				p1.hydrate = false
				ReactFiberHostConfig.clearContainer(p1.containerInfo)
			end

			local v12 = getLanesToRetrySynchronouslyOnError(p1)

			if v12 == ReactFiberLane.NoLanes then
				v4 = v12
			else
				v5, v4 = t3.renderRootSync(p1, v12), v12
			end
		end

		if v5 == 1 then
			t3.prepareFreshStack(p1, ReactFiberLane.NoLanes)
			t3.markRootSuspended(p1, v4)
			v8(p1, now())
			error(v19)
		end

		p1.finishedWork = p1.current.alternate
		p1.finishedLanes = v4
		t3.commitRoot(p1)
		v8(p1, now())

		return nil
	end
	function t.flushRoot(p1, p2) --[[ Line: 1166 | Upvalues: markRootExpired (copy), v8 (ref), now (copy), v14 (ref), v22 (ref), flushSyncCallbackQueue (copy) ]]
		markRootExpired(p1, p2)
		v8(p1, now())

		if bit32.band(v14, 48) ~= 0 then
			return
		end

		v22 = now() + 500
		flushSyncCallbackQueue()
	end
	function t.getExecutionContext() --[[ Line: 1178 | Upvalues: v14 (ref) ]]
		return v14
	end
	function t.flushDiscreteUpdates() --[[ Line: 1182 | Upvalues: v14 (ref), __DEV__ (copy), console (copy), t3 (copy), t (copy) ]]
		if bit32.band(v14, 49) == 0 then
			t3.flushPendingDiscreteUpdates()
			t.flushPassiveEffects()

			return
		end

		if not __DEV__ then
			return
		end

		if bit32.band(v14, 16) == 0 then
			return
		end

		console.error("unstable_flushDiscreteUpdates: Cannot flush updates when React is already rendering.")
	end
	function t.deferredUpdates(p1) --[[ Line: 1212 | Upvalues: ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), __YOLO__ (copy), setCurrentUpdateLanePriority (copy), ReactFiberLane (copy), runWithPriority (copy), describeError (copy), NormalPriority (copy) ]]
		if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
			return runWithPriority(NormalPriority, p1)
		end

		local v1 = getCurrentUpdateLanePriority()
		local v2, v3

		if __YOLO__ then
			setCurrentUpdateLanePriority(ReactFiberLane.DefaultLanePriority)
			v2, v3 = true, runWithPriority(NormalPriority, p1)
		else
			setCurrentUpdateLanePriority(ReactFiberLane.DefaultLanePriority)

			local ok, result = xpcall(runWithPriority, describeError, NormalPriority, p1)

			v2 = ok
			v3 = result
		end

		setCurrentUpdateLanePriority(v1)

		if v2 then
			return v3
		end

		error(v3)
	end
	function t3.flushPendingDiscreteUpdates() --[[ Line: 1241 | Upvalues: v30 (ref), markDiscreteUpdatesExpired (copy), v8 (ref), now (copy), flushSyncCallbackQueue (copy) ]]
		if v30 ~= nil then
			local v1 = v30

			v30 = nil
			v1:forEach(function(p1) --[[ Line: 1247 | Upvalues: markDiscreteUpdatesExpired (ref), v8 (ref), now (ref) ]]
				markDiscreteUpdatesExpired(p1)
				v8(p1, now())
			end)
		end

		flushSyncCallbackQueue()
	end
	function t.batchedUpdates(p1, p2) --[[ Line: 1256 | Upvalues: v14 (ref), __YOLO__ (copy), describeError (copy), v22 (ref), now (copy), flushSyncCallbackQueue (copy) ]]
		local v1 = v14

		v14 = bit32.bor(v14, 1)

		local v3, v4

		if __YOLO__ then
			v3, v4 = true, p1(p2)
		else
			local ok, result = xpcall(p1, describeError, p2)

			v3 = ok
			v4 = result
		end

		v14 = v1

		if v1 == 0 then
			v22 = now() + 500
			flushSyncCallbackQueue()
		end

		if v3 then
			return v4
		end

		error(v4)
	end
	function t.batchedEventUpdates(p1, p2) --[[ Line: 1284 | Upvalues: v14 (ref), __YOLO__ (copy), describeError (copy), v22 (ref), now (copy), flushSyncCallbackQueue (copy) ]]
		local v1 = v14

		v14 = bit32.bor(v14, 2)

		local v3, v4

		if __YOLO__ then
			v3, v4 = true, p1(p2)
		else
			local ok, result = xpcall(p1, describeError, p2)

			v3 = ok
			v4 = result
		end

		v14 = v1

		if v1 == 0 then
			v22 = now() + 500
			flushSyncCallbackQueue()
		end

		if v3 then
			return v4
		end

		error(v4)
	end
	function t.discreteUpdates(p1, p2, p3, p4, p5) --[[ Line: 1313 | Upvalues: v14 (ref), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), ReactFiberLane (copy), runWithPriority (copy), describeError (copy), UserBlockingPriority (copy), v22 (ref), now (copy), flushSyncCallbackQueue (copy) ]]
		local v1 = v14

		v14 = bit32.bor(v14, 4)

		if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
			local v3 = getCurrentUpdateLanePriority()

			setCurrentUpdateLanePriority(ReactFiberLane.InputDiscreteLanePriority)

			local ok, result = xpcall(runWithPriority, describeError, UserBlockingPriority, function() --[[ Line: 1325 | Upvalues: p1 (copy), p2 (copy), p3 (copy), p4 (copy), p5 (copy) ]]
				return p1(p2, p3, p4, p5)
			end)

			setCurrentUpdateLanePriority(v3)
			v14 = v1

			if v1 == 0 then
				v22 = now() + 500
				flushSyncCallbackQueue()
			end

			if ok then
				return result
			end

			error(result)
		end

		local ok, result = xpcall(runWithPriority, describeError, UserBlockingPriority, function() --[[ Line: 1349 | Upvalues: p1 (copy), p2 (copy), p3 (copy), p4 (copy), p5 (copy) ]]
			return p1(p2, p3, p4, p5)
		end)

		v14 = v1

		if v1 == 0 then
			v22 = now() + 500
			flushSyncCallbackQueue()
		end

		if ok then
			return result
		end

		error(result)
	end
	function t.unbatchedUpdates(p1, p2) --[[ Line: 1370 | Upvalues: v14 (ref), __YOLO__ (copy), describeError (copy), v22 (ref), now (copy), flushSyncCallbackQueue (copy) ]]
		local v1 = v14

		v14 = bit32.band(v14, 4294967294)
		v14 = bit32.bor(v14, 8)

		local v4, v5

		if __YOLO__ then
			v4, v5 = true, p1(p2)
		else
			local ok, result = xpcall(p1, describeError, p2)

			v4 = ok
			v5 = result
		end

		v14 = v1

		if v1 == 0 then
			v22 = now() + 500
			flushSyncCallbackQueue()
		end

		if v4 then
			return v5
		end

		error(v5)
	end
	function t.flushSync(p1, p2) --[[ Line: 1398 | Upvalues: v14 (ref), __DEV__ (copy), console (copy), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), ReactFiberLane (copy), __YOLO__ (copy), runWithPriority (copy), describeError (copy), ImmediatePriority (copy), flushSyncCallbackQueue (copy) ]]
		local v1 = v14

		if bit32.band(v1, 48) == 0 then
			v14 = bit32.bor(v14, 1)

			if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
				local v3 = getCurrentUpdateLanePriority()

				setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority)

				local v4, v5

				if __YOLO__ then
					v4 = true
					setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority)
					v5 = if p1 then runWithPriority(ImmediatePriority, function() --[[ Line: 1441 | Upvalues: p1 (copy), p2 (copy) ]]
	return p1(p2)
end) else nil
				elseif p1 then
					local ok, result = xpcall(runWithPriority, describeError, ImmediatePriority, function() --[[ Line: 1428 | Upvalues: p1 (copy), p2 (copy) ]]
						return p1(p2)
					end)

					v4 = ok
					v5 = result
				else
					v4 = true
					v5 = nil
				end

				setCurrentUpdateLanePriority(v3)
				v14 = v1
				flushSyncCallbackQueue()

				if not v4 then
					error(v5)
				end

				return v5
			end

			local v7, v8

			if __YOLO__ then
				v7 = true
				v8 = if p1 then runWithPriority(ImmediatePriority, function() --[[ Line: 1483 | Upvalues: p1 (copy), p2 (copy) ]]
	return p1(p2)
end) else nil
			elseif p1 then
				local ok, result = xpcall(runWithPriority, describeError, ImmediatePriority, function() --[[ Line: 1471 | Upvalues: p1 (copy), p2 (copy) ]]
					return p1(p2)
				end)

				v7 = ok
				v8 = result
			else
				v7 = true
				v8 = nil
			end

			v14 = v1
			flushSyncCallbackQueue()

			if not v7 then
				error(v8)
			end

			return v8
		end

		if not __DEV__ then
			return p1(p2)
		end

		console.error("flushSync was called from inside a lifecycle method. React cannot flush when React is already rendering. Consider moving this call to a scheduler task or micro task.")

		return p1(p2)
	end
	function t.flushControlled(p1) --[[ Line: 1504 | Upvalues: v14 (ref), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), ReactFiberLane (copy), runWithPriority (copy), describeError (copy), ImmediatePriority (copy), v22 (ref), now (copy), flushSyncCallbackQueue (copy) ]]
		local v1 = v14

		v14 = bit32.bor(v14, 1)

		if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
			local v3 = getCurrentUpdateLanePriority()

			setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority)

			local ok, result = xpcall(runWithPriority, describeError, ImmediatePriority, p1)

			setCurrentUpdateLanePriority(v3)
			v14 = v1

			if v1 == 0 then
				v22 = now() + 500
				flushSyncCallbackQueue()
			end

			if not ok then
				error(result)
			end
		else
			local ok, result = xpcall(runWithPriority, describeError, ImmediatePriority, p1)

			v14 = v1

			if v1 == 0 then
				v22 = now() + 500
				flushSyncCallbackQueue()
			end

			if ok then
				return
			end

			error(result)
		end
	end
	function t.pushRenderLanes(p1, p2) --[[ Line: 1544 | Upvalues: push (copy), v17 (copy), t (copy), mergeLanes (copy), NoLanes2 (ref) ]]
		push(v17, t.subtreeRenderLanes, p1)
		t.subtreeRenderLanes = mergeLanes(t.subtreeRenderLanes, p2)
		NoLanes2 = mergeLanes(NoLanes2, p2)
	end
	function t.popRenderLanes(p1) --[[ Line: 1550 | Upvalues: t (copy), v17 (copy), pop (copy) ]]
		t.subtreeRenderLanes = v17.current
		pop(v17, p1)
	end
	function t3.prepareFreshStack(p1, p2) --[[ Line: 1555 | Upvalues: ReactFiberLane (copy), ReactFiberHostConfig (copy), v16 (ref), unwindInterruptedWork (copy), v15 (ref), v4 (copy), NoLanes (ref), t (copy), NoLanes2 (ref), v18 (ref), v19 (ref), workInProgressRootSkippedLanes (copy), NoLanes3 (ref), NoLanes4 (ref), ReactFeatureFlags (copy), v34 (ref), __DEV__ (copy), v12 (copy) ]]
		p1.finishedWork = nil
		p1.finishedLanes = ReactFiberLane.NoLanes

		local timeoutHandle = p1.timeoutHandle

		if timeoutHandle ~= ReactFiberHostConfig.noTimeout then
			p1.timeoutHandle = ReactFiberHostConfig.noTimeout
			ReactFiberHostConfig.cancelTimeout(timeoutHandle)
		end

		if v16 ~= nil then
			local return_ = v16.return_

			while return_ ~= nil do
				unwindInterruptedWork(return_)
				return_ = return_.return_
			end
		end

		v15 = p1
		v16 = v4.createWorkInProgress(p1.current, nil)
		NoLanes = p2
		t.subtreeRenderLanes = p2
		NoLanes2 = p2
		v18 = 0
		v19 = nil
		workInProgressRootSkippedLanes(ReactFiberLane.NoLanes)
		NoLanes3 = ReactFiberLane.NoLanes
		NoLanes4 = ReactFiberLane.NoLanes

		if ReactFeatureFlags.enableSchedulerTracing then
			v34 = nil
		end

		if not __DEV__ then
			return
		end

		v12.discardPendingWarnings()
	end
	function t3.handleError(p1, p2) --[[ Line: 1595 | Upvalues: v16 (ref), resetContextDependencies (copy), t2 (copy), v10 (ref), resetCurrentFiber (copy), ReactCurrentOwner (copy), v18 (ref), v19 (ref), ReactFeatureFlags (copy), ReactTypeOfMode (copy), v11 (copy), throwException (copy), NoLanes (ref), t (copy), t3 (copy) ]]
		while true do
			local v1 = v16
			local ok, result = pcall(function() --[[ Line: 1599 | Upvalues: resetContextDependencies (ref), t2 (ref), v10 (ref), resetCurrentFiber (ref), ReactCurrentOwner (ref), v1 (ref), v18 (ref), v19 (ref), p2 (ref), v16 (ref), ReactFeatureFlags (ref), ReactTypeOfMode (ref), v11 (ref), throwException (ref), p1 (copy), NoLanes (ref), t (ref), t3 (ref) ]]
				resetContextDependencies()

				if not t2.resetHooksAfterThrowRef then
					v10 = require(script.Parent:WaitForChild("ReactFiberHooks.new"))
					t2.resetHooksAfterThrowRef = v10.resetHooksAfterThrow
					t2.ContextOnlyDispatcherRef = v10.ContextOnlyDispatcher
					t2.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = v10.getIsUpdatingOpaqueValueInRenderPhaseInDEV
				end

				t2.resetHooksAfterThrowRef()
				resetCurrentFiber()
				ReactCurrentOwner.current = nil

				if v1 == nil or v1.return_ == nil then
					v18 = 1
					v19 = p2
					v16 = nil

					return
				end

				if ReactFeatureFlags.enableProfilerTimer and bit32.band(v1.mode, ReactTypeOfMode.ProfileMode) ~= 0 then
					v11.stopProfilerTimerIfRunningAndRecordDelta(v1, true)
				end

				throwException(p1, v1.return_, v1, p2, NoLanes, t.onUncaughtError, t.renderDidError)
				t3.completeUnitOfWork(v1)
			end)

			if ok then
				break
			end

			p2 = result

			if v16 == v1 and v1 ~= nil then
				v1 = v1.return_
				v16 = v1
			else
				v1 = v16
			end
		end
	end
	function t3.pushDispatcher() --[[ Line: 1674 | Upvalues: ReactCurrentDispatcher (copy), t2 (copy), v10 (ref) ]]
		local current = ReactCurrentDispatcher.current

		if not t2.ContextOnlyDispatcherRef then
			v10 = require(script.Parent:WaitForChild("ReactFiberHooks.new"))
			t2.resetHooksAfterThrowRef = v10.resetHooksAfterThrow
			t2.ContextOnlyDispatcherRef = v10.ContextOnlyDispatcher
			t2.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = v10.getIsUpdatingOpaqueValueInRenderPhaseInDEV
		end

		ReactCurrentDispatcher.current = t2.ContextOnlyDispatcherRef

		if current ~= nil then
			return current
		end

		if t2.ContextOnlyDispatcherRef then
			return t2.ContextOnlyDispatcherRef
		end

		v10 = require(script.Parent:WaitForChild("ReactFiberHooks.new"))
		t2.resetHooksAfterThrowRef = v10.resetHooksAfterThrow
		t2.ContextOnlyDispatcherRef = v10.ContextOnlyDispatcher
		t2.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = v10.getIsUpdatingOpaqueValueInRenderPhaseInDEV

		return t2.ContextOnlyDispatcherRef
	end
	function t3.popDispatcher(p1) --[[ Line: 1691 | Upvalues: ReactCurrentDispatcher (copy) ]]
		ReactCurrentDispatcher.current = p1
	end
	function t3.pushInteractions(p1) --[[ Line: 1695 | Upvalues: ReactFeatureFlags (copy), __interactionsRef (copy) ]]
		if ReactFeatureFlags.enableSchedulerTracing then
			local current = __interactionsRef.current

			__interactionsRef.current = p1.memoizedInteractions

			return current
		end

		return nil
	end
	function t3.popInteractions(p1) --[[ Line: 1704 | Upvalues: ReactFeatureFlags (copy), __interactionsRef (copy) ]]
		if not ReactFeatureFlags.enableSchedulerTracing then
			return
		end

		__interactionsRef.current = p1
	end
	function t.markCommitTimeOfFallback() --[[ Line: 1710 | Upvalues: v21 (ref), now (copy) ]]
		v21 = now()
	end
	function t.markSkippedUpdateLanes(p1) --[[ Line: 1714 | Upvalues: ReactFiberWorkInProgress (copy) ]]
		ReactFiberWorkInProgress.markSkippedUpdateLanes(p1)
	end
	function t.renderDidSuspend() --[[ Line: 1718 | Upvalues: v18 (ref) ]]
		if v18 ~= 0 then
			return
		end

		v18 = 3
	end
	function t.renderDidSuspendDelayIfPossible() --[[ Line: 1724 | Upvalues: v18 (ref), v15 (ref), includesNonIdleWork (copy), workInProgressRootSkippedLanes (copy), NoLanes3 (ref), t3 (copy), NoLanes (ref) ]]
		if v18 == 0 or v18 == 3 then
			v18 = 4
		end

		if v15 == nil or not (includesNonIdleWork(workInProgressRootSkippedLanes()) or includesNonIdleWork(NoLanes3)) then
			return
		end

		t3.markRootSuspended(v15, NoLanes)
	end
	function t.renderDidError() --[[ Line: 1752 | Upvalues: v18 (ref) ]]
		if v18 == 5 then
			return
		end

		v18 = 2
	end
	function t.renderHasNotSuspendedYet() --[[ Line: 1760 | Upvalues: v18 (ref) ]]
		return v18 == 0
	end
	function t3.renderRootSync(p1, p2) --[[ Line: 1766 | Upvalues: v14 (ref), t3 (copy), v15 (ref), NoLanes (ref), __DEV__ (copy), enableDebugTracing (copy), DebugTracing (copy), enableSchedulingProfiler (copy), SchedulingProfiler (copy), __YOLO__ (copy), describeError (copy), resetContextDependencies (copy), ReactFeatureFlags (copy), v16 (ref), invariant (copy), ReactFiberLane (copy), v18 (ref) ]]
		local v1 = v14

		v14 = bit32.bor(v14, 16)

		local v3 = t3.pushDispatcher()

		if v15 ~= p1 or NoLanes ~= p2 then
			t3.prepareFreshStack(p1, p2)
			t3.startWorkOnPendingInteractions(p1, p2)
		end

		local v4 = t3.pushInteractions(p1)

		if __DEV__ and enableDebugTracing then
			DebugTracing.logRenderStarted(p2)
		end

		if enableSchedulingProfiler then
			SchedulingProfiler.markRenderStarted(p2)
		end

		while true do
			local v5
			local v6 = nil

			if __YOLO__ then
				t3.workLoopSync()
				v5 = true
			else
				local ok, result = xpcall(t3.workLoopSync, describeError)

				v5 = ok
				v6 = result
			end

			if v5 then
				resetContextDependencies()

				if ReactFeatureFlags.enableSchedulerTracing then
					t3.popInteractions(v4)
				end

				v14 = v1
				t3.popDispatcher(v3)

				if v16 ~= nil then
					invariant(false, "Cannot commit an incomplete root. This error is likely caused by a bug in React. Please file an issue.")
				end

				if __DEV__ and enableDebugTracing then
					DebugTracing.logRenderStopped()
				end

				if not enableSchedulingProfiler then
					v15 = nil
					NoLanes = ReactFiberLane.NoLanes

					return v18
				end

				SchedulingProfiler.markRenderStopped()
				v15 = nil
				NoLanes = ReactFiberLane.NoLanes

				return v18
			end

			t3.handleError(p1, v6)
		end
	end
	function t3.workLoopSync() --[[ Line: 1842 | Upvalues: v16 (ref), t3 (copy) ]]
		while v16 ~= nil do
			t3.performUnitOfWork(v16)
		end
	end
	function t3.renderRootConcurrent(p1, p2) --[[ Line: 1849 | Upvalues: v14 (ref), t3 (copy), v15 (ref), NoLanes (ref), v22 (ref), now (copy), __DEV__ (copy), enableDebugTracing (copy), DebugTracing (copy), enableSchedulingProfiler (copy), SchedulingProfiler (copy), __YOLO__ (copy), describeError (copy), resetContextDependencies (copy), ReactFeatureFlags (copy), v16 (ref), ReactFiberLane (copy), v18 (ref) ]]
		local v1 = v14

		v14 = bit32.bor(v14, 16)

		local v3 = t3.pushDispatcher()

		if v15 ~= p1 or NoLanes ~= p2 then
			v22 = now() + 500
			t3.prepareFreshStack(p1, p2)
			t3.startWorkOnPendingInteractions(p1, p2)
		end

		local v4 = t3.pushInteractions(p1)

		if __DEV__ and enableDebugTracing then
			DebugTracing.logRenderStarted(p2)
		end

		if enableSchedulingProfiler then
			SchedulingProfiler.markRenderStarted(p2)
		end

		while true do
			local v5, v6

			if __YOLO__ then
				t3.workLoopConcurrent()
				v5 = "break"
				v6 = true
			else
				local ok, result = xpcall(t3.workLoopConcurrent, describeError)

				if ok then
					v5 = "break"
					v6 = ok
				else
					v5 = result
					v6 = ok
				end
			end

			if v5 == "break" then
				resetContextDependencies()

				if ReactFeatureFlags.enableSchedulerTracing then
					t3.popInteractions(v4)
				end

				t3.popDispatcher(v3)
				v14 = v1

				if __DEV__ and enableDebugTracing then
					DebugTracing.logRenderStopped()
				end

				if v16 == nil then
					if not enableSchedulingProfiler then
						v15 = nil
						NoLanes = ReactFiberLane.NoLanes

						return v18
					end

					SchedulingProfiler.markRenderStopped()
					v15 = nil
					NoLanes = ReactFiberLane.NoLanes

					return v18
				end

				if not enableSchedulingProfiler then
					return 0
				end

				SchedulingProfiler.markRenderYielded()

				return 0
			elseif not v6 then
				t3.handleError(p1, v5)
			end
		end
	end
	function t3.workLoopConcurrent() --[[ Line: 1933 | Upvalues: v16 (ref), shouldYield (copy), t3 (copy) ]]
		while v16 ~= nil and not shouldYield() do
			t3.performUnitOfWork(v16)
		end
	end
	function t3.performUnitOfWork(p1) --[[ Line: 1940 | Upvalues: RobloxReactProfiling (copy), setCurrentFiber (copy), ReactFeatureFlags (copy), ReactTypeOfMode (copy), v11 (copy), t3 (copy), t (copy), resetCurrentFiber (copy), v16 (ref), ReactCurrentOwner (copy) ]]
		local v1 = RobloxReactProfiling.profileUnitOfWorkBefore(p1)
		local alternate = p1.alternate

		setCurrentFiber(p1)

		local v2, v3

		if ReactFeatureFlags.enableProfilerTimer then
			if bit32.band(p1.mode, ReactTypeOfMode.ProfileMode) == ReactTypeOfMode.NoMode then
				v2 = t3.beginWork(alternate, p1, t.subtreeRenderLanes)
				v3 = v2
			else
				v11.startProfilerTimer(p1)

				local v4 = t3.beginWork(alternate, p1, t.subtreeRenderLanes)

				v11.stopProfilerTimerIfRunningAndRecordDelta(p1, true)
				v3 = v4
			end
		else
			v2 = t3.beginWork(alternate, p1, t.subtreeRenderLanes)
			v3 = v2
		end

		resetCurrentFiber()
		p1.memoizedProps = p1.pendingProps

		if v3 == nil then
			t3.completeUnitOfWork(p1)
		else
			v16 = v3
		end

		ReactCurrentOwner.current = nil
		RobloxReactProfiling.profileUnitOfWorkAfter(v1)
	end
	function t3.completeUnitOfWork(p1) --[[ Line: 1978 | Upvalues: ReactFiberFlags (copy), setCurrentFiber (copy), ReactFeatureFlags (copy), ReactTypeOfMode (copy), t (copy), t2 (copy), v11 (copy), resetCurrentFiber (copy), v16 (ref), unwindWork (copy), v18 (ref) ]]
		local v1 = p1

		while true do
			local v2
			local alternate = v1.alternate
			local return_ = v1.return_

			if bit32.band(v1.flags, ReactFiberFlags.Incomplete) == ReactFiberFlags.NoFlags then
				setCurrentFiber(v1)

				local v3, v4

				if ReactFeatureFlags.enableProfilerTimer then
					if bit32.band(v1.mode, ReactTypeOfMode.ProfileMode) == ReactTypeOfMode.NoMode then
						v3 = t.subtreeRenderLanes

						if not t2.completeWorkRef then
							t2.completeWorkRef = require(script.Parent:WaitForChild("ReactFiberCompleteWork.new")).completeWork
						end

						v4 = t2.completeWorkRef(alternate, v1, v3)
						v2 = v4
					else
						v11.startProfilerTimer(v1)

						if not t2.completeWorkRef then
							t2.completeWorkRef = require(script.Parent:WaitForChild("ReactFiberCompleteWork.new")).completeWork
						end

						local v5 = t2.completeWorkRef(alternate, v1, t.subtreeRenderLanes)

						v11.stopProfilerTimerIfRunningAndRecordDelta(v1, false)
						v2 = v5
					end
				else
					v3 = t.subtreeRenderLanes

					if not t2.completeWorkRef then
						t2.completeWorkRef = require(script.Parent:WaitForChild("ReactFiberCompleteWork.new")).completeWork
					end

					v4 = t2.completeWorkRef(alternate, v1, v3)
					v2 = v4
				end

				resetCurrentFiber()

				if v2 ~= nil then
					v16 = v2

					return
				end
			else
				local v6 = unwindWork(v1, t.subtreeRenderLanes)

				if v6 ~= nil then
					v6.flags = bit32.band(v6.flags, ReactFiberFlags.HostEffectMask)
					v16 = v6

					return
				end

				if ReactFeatureFlags.enableProfilerTimer and bit32.band(v1.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
					v11.stopProfilerTimerIfRunningAndRecordDelta(v1, false)

					local sum = v1.actualDuration or 0
					local child = v1.child

					while child ~= nil do
						sum = sum + (child.actualDuration or 0)
						child = child.sibling
					end

					v1.actualDuration = sum
				end

				if return_ ~= nil then
					return_.flags = bit32.bor(return_.flags, ReactFiberFlags.Incomplete)
					return_.subtreeFlags = ReactFiberFlags.NoFlags
					return_.deletions = nil
				end
			end

			local sibling = v1.sibling

			if sibling ~= nil then
				v16 = sibling

				return
			end

			v16 = return_

			if return_ == nil then
				if v18 ~= 0 then
					return
				end

				v18 = 5

				return
			end

			v1 = return_
		end
	end
	function t3.commitRoot(p1) --[[ Line: 2086 | Upvalues: getCurrentPriorityLevel (copy), runWithPriority (copy), ImmediatePriority (copy), RobloxReactProfiling (copy), t3 (copy) ]]
		local v1 = getCurrentPriorityLevel()

		runWithPriority(ImmediatePriority, function() --[[ Line: 2088 | Upvalues: RobloxReactProfiling (ref), t3 (ref), p1 (copy), v1 (copy) ]]
			RobloxReactProfiling.profileCommitBefore()

			local v12 = t3.commitRootImpl(p1, v1)

			RobloxReactProfiling.profileCommitAfter()

			return v12
		end)

		return nil
	end
	function t3.commitRootImpl(p1, p2) --[[ Line: 2099 | Upvalues: t (copy), v28 (ref), invariant (copy), v14 (ref), __DEV__ (copy), enableDebugTracing (copy), DebugTracing (copy), enableSchedulingProfiler (copy), SchedulingProfiler (copy), ReactFiberLane (copy), mergeLanes (copy), markRootFinished (copy), v30 (ref), hasDiscreteLanes (copy), v15 (ref), v16 (ref), NoLanes (ref), ReactFiberFlags (copy), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), t3 (copy), ReactCurrentOwner (copy), v36 (ref), ReactFiberHostConfig (copy), v37 (ref), v11 (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), recursivelyCommitLayoutEffects (copy), hasCaughtError (copy), clearCaughtError (copy), v13 (ref), resetCurrentFiber (copy), __YOLO__ (copy), describeError (copy), v27 (ref), scheduleCallback (copy), NormalPriority (copy), requestPaint (copy), NoLanes5 (ref), v29 (ref), v34 (ref), v26 (ref), enableDoubleInvokingEffects (copy), SyncLane (copy), v32 (ref), v31 (ref), onCommitRoot (copy), onCommitRoot2 (copy), v8 (ref), now (copy), v24 (ref), v25 (ref), flushSyncCallbackQueue (copy) ]]
		repeat
			t.flushPassiveEffects()
		until v28 == nil

		flushRenderPhaseStrictModeWarningsInDEV()
		invariant(if bit32.band(v14, 48) == 0 then true else false, "Should not already be working.")

		local finishedWork = p1.finishedWork
		local finishedLanes = p1.finishedLanes

		if __DEV__ and enableDebugTracing then
			DebugTracing.logCommitStarted(finishedLanes)
		end

		if enableSchedulingProfiler then
			SchedulingProfiler.markCommitStarted(finishedLanes)
		end

		if finishedWork ~= nil then
			p1.finishedWork = nil
			p1.finishedLanes = ReactFiberLane.NoLanes
			invariant(if finishedWork == p1.current then false else true, "Cannot commit the same tree as before. This error is likely caused by a bug in React. Please file an issue.")
			p1.callbackNode = nil

			local v6 = mergeLanes(finishedWork.lanes, finishedWork.childLanes)

			markRootFinished(p1, v6)

			if v30 ~= nil and (not hasDiscreteLanes(v6) and v30:has(p1)) then
				v30:delete(p1)
			end

			if p1 == v15 then
				v15 = nil
				v16 = nil
				NoLanes = ReactFiberLane.NoLanes
			end

			local v82 = if bit32.band(finishedWork.subtreeFlags, (bit32.bor(ReactFiberFlags.BeforeMutationMask, ReactFiberFlags.MutationMask, ReactFiberFlags.LayoutMask, ReactFiberFlags.PassiveMask))) == ReactFiberFlags.NoFlags then false else true

			if v82 or (if bit32.band(finishedWork.flags, (bit32.bor(ReactFiberFlags.BeforeMutationMask, ReactFiberFlags.MutationMask, ReactFiberFlags.LayoutMask, ReactFiberFlags.PassiveMask))) == ReactFiberFlags.NoFlags then false else true) then
				local v112

				if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
					local v12 = getCurrentUpdateLanePriority()

					setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority)
					v112 = v12
				else
					v112 = nil
				end

				local v132 = v14

				v14 = bit32.bor(v14, 32)

				local v152 = t3.pushInteractions(p1)

				ReactCurrentOwner.current = nil
				v36 = ReactFiberHostConfig.prepareForCommit(p1.containerInfo)
				v37 = false
				t3.commitBeforeMutationEffects(finishedWork)
				v36 = nil

				if ReactFeatureFlags.enableProfilerTimer then
					v11.recordCommitTime()
				end

				t3.commitMutationEffects(finishedWork, p1, p2)

				if v37 then
					ReactFiberHostConfig.afterActiveInstanceBlur()
				end

				ReactFiberHostConfig.resetAfterCommit(p1.containerInfo)
				p1.current = finishedWork

				if __DEV__ and enableDebugTracing then
					DebugTracing.logLayoutEffectsStarted(finishedLanes)
				end

				if enableSchedulingProfiler then
					SchedulingProfiler.markLayoutEffectsStarted(finishedLanes)
				end

				if __DEV__ then
					setCurrentFiber(finishedWork)
					invokeGuardedCallback(nil, recursivelyCommitLayoutEffects, nil, finishedWork, p1, t.captureCommitPhaseError, t.schedulePassiveEffectCallback)

					if hasCaughtError() then
						v13(finishedWork, finishedWork, (clearCaughtError()))
					end

					resetCurrentFiber()
				else
					local v162 = nil
					local v17

					if __YOLO__ then
						recursivelyCommitLayoutEffects(finishedWork, p1, t.captureCommitPhaseError, t.schedulePassiveEffectCallback)
						v17 = true
					else
						local ok, result = xpcall(recursivelyCommitLayoutEffects, describeError, finishedWork, p1, t.captureCommitPhaseError, t.schedulePassiveEffectCallback)

						v17 = ok
						v162 = result
					end

					if not v17 then
						v13(finishedWork, finishedWork, v162)
					end
				end

				if __DEV__ and enableDebugTracing then
					DebugTracing.logLayoutEffectsStopped()
				end

				if enableSchedulingProfiler then
					SchedulingProfiler.markLayoutEffectsStopped()
				end

				if bit32.band(finishedWork.subtreeFlags, ReactFiberFlags.PassiveMask) == ReactFiberFlags.NoFlags then
					if bit32.band(finishedWork.flags, ReactFiberFlags.PassiveMask) ~= ReactFiberFlags.NoFlags and not v27 then
						v27 = true
						scheduleCallback(NormalPriority, function() --[[ Line: 2332 | Upvalues: t (ref) ]]
							t.flushPassiveEffects()

							return nil
						end)
					end
				elseif not v27 then
					v27 = true
					scheduleCallback(NormalPriority, function() --[[ Line: 2332 | Upvalues: t (ref) ]]
						t.flushPassiveEffects()

						return nil
					end)
				end

				requestPaint()

				if ReactFeatureFlags.enableSchedulerTracing then
					t3.popInteractions(v152)
				end

				v14 = v132

				if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler and v112 ~= nil then
					setCurrentUpdateLanePriority(v112)
				end
			else
				p1.current = finishedWork

				if ReactFeatureFlags.enableProfilerTimer then
					v11.recordCommitTime()
				end
			end

			local v18 = v27

			if v27 then
				v27 = false
				v28 = p1
				NoLanes5 = finishedLanes
				v29 = p2
			end

			local pendingLanes = p1.pendingLanes

			if pendingLanes == ReactFiberLane.NoLanes then
				v26 = nil
			elseif ReactFeatureFlags.enableSchedulerTracing then
				if v34 ~= nil then
					local v19 = v34

					v34 = nil

					for i = 1, #v19 do
						scheduleInteractions(p1, v19[i], p1.memoizedInteractions)
					end
				end

				t3.schedulePendingInteractions(p1, pendingLanes)
			end

			if __DEV__ and (enableDoubleInvokingEffects and not v18) then
				commitDoubleInvokeEffectsInDEV(p1.current, false)
			end

			if ReactFeatureFlags.enableSchedulerTracing and not v18 then
				t3.finishPendingInteractions(p1, finishedLanes)
			end

			if pendingLanes == SyncLane then
				if p1 == v32 then
					v31 = v31 + 1
				else
					v31 = 0
					v32 = p1
				end
			else
				v31 = 0
			end

			onCommitRoot(finishedWork.stateNode, p2)

			if __DEV__ then
				onCommitRoot2()
			end

			v8(p1, now())

			if v24 then
				v24 = false

				local v20 = v25

				v25 = nil
				error(v20)
			end

			if bit32.band(v14, 8) == 0 then
				flushSyncCallbackQueue()
			end
		end

		if __DEV__ and enableDebugTracing then
			DebugTracing.logCommitStopped()
		end

		if not enableSchedulingProfiler then
			return nil
		end

		SchedulingProfiler.markCommitStopped()

		return nil
	end
	function t3.commitBeforeMutationEffects(p1) --[[ Line: 2483 | Upvalues: t3 (copy), ReactFiberFlags (copy), __DEV__ (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), hasCaughtError (copy), clearCaughtError (copy), t (copy), resetCurrentFiber (copy), __YOLO__ (copy), describeError (copy) ]]
		local v1 = p1

		while v1 ~= nil do
			local v2

			if v1.deletions ~= nil then
				t3.commitBeforeMutationEffectsDeletions(v1.deletions)
			end

			if v1.child ~= nil and bit32.band(v1.subtreeFlags, ReactFiberFlags.BeforeMutationMask) ~= ReactFiberFlags.NoFlags then
				t3.commitBeforeMutationEffects(v1.child)
			end

			if __DEV__ then
				setCurrentFiber(v1)
				invokeGuardedCallback(nil, t3.commitBeforeMutationEffectsImpl, nil, v1)

				if hasCaughtError() then
					t.captureCommitPhaseError(v1, v1.return_, (clearCaughtError()))
				end

				resetCurrentFiber()
			else
				local v4 = nil

				if __YOLO__ then
					t3.commitBeforeMutationEffectsImpl(v1)
					v2 = true
				else
					local ok, result = xpcall(t3.commitBeforeMutationEffectsImpl, describeError, v1)

					v2 = ok
					v4 = result
				end

				if not v2 then
					t.captureCommitPhaseError(v1, v1.return_, v4)
				end
			end

			v1 = v1.sibling
		end
	end
	function t3.commitBeforeMutationEffectsImpl(p1) --[[ Line: 2526 | Upvalues: v37 (ref), v36 (ref), ReactWorkTags (copy), v7 (copy), doesFiberContain (copy), ReactFiberHostConfig (copy), ReactFiberFlags (copy), setCurrentFiber (copy), commitBeforeMutationLifeCycles (copy), resetCurrentFiber (copy), v27 (ref), scheduleCallback (copy), NormalPriority (copy), t (copy) ]]
		local alternate = p1.alternate
		local flags = p1.flags

		if not v37 and (v36 ~= nil and (p1.tag == ReactWorkTags.SuspenseComponent and (v7.isSuspenseBoundaryBeingHidden(alternate, p1) and doesFiberContain(p1, v36)))) then
			v37 = true
			ReactFiberHostConfig.beforeActiveInstanceBlur()
		end

		if bit32.band(flags, ReactFiberFlags.Snapshot) ~= ReactFiberFlags.NoFlags then
			setCurrentFiber(p1)
			commitBeforeMutationLifeCycles(alternate, p1)
			resetCurrentFiber()
		end

		if bit32.band(flags, ReactFiberFlags.Passive) == ReactFiberFlags.NoFlags or v27 then
			return
		end

		v27 = true
		scheduleCallback(NormalPriority, function() --[[ Line: 2554 | Upvalues: t (ref) ]]
			t.flushPassiveEffects()

			return nil
		end)
	end
	function t3.commitBeforeMutationEffectsDeletions(p1) --[[ Line: 2562 | Upvalues: doesFiberContain (copy), v36 (ref), v37 (ref), ReactFiberHostConfig (copy) ]]
		for i = 1, #p1 do
			if doesFiberContain(p1[i], v36) then
				v37 = true
				ReactFiberHostConfig.beforeActiveInstanceBlur()
			end
		end
	end
	function t3.commitMutationEffects(p1, p2, p3) --[[ Line: 2578 | Upvalues: commitDeletion (copy), describeError (copy), t (copy), ReactFiberFlags (copy), t3 (copy), __DEV__ (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), hasCaughtError (copy), clearCaughtError (copy), resetCurrentFiber (copy), __YOLO__ (copy) ]]
		local v1 = p1

		while v1 ~= nil do
			local v2
			local deletions = v1.deletions

			if deletions ~= nil then
				for v3, v4 in deletions do
					local ok, result = xpcall(commitDeletion, describeError, p2, v4, v1, p3)

					if not ok then
						t.captureCommitPhaseError(v4, v1, result)
					end
				end
			end

			if v1.child ~= nil and bit32.band(v1.subtreeFlags, ReactFiberFlags.MutationMask) ~= ReactFiberFlags.NoFlags then
				t3.commitMutationEffects(v1.child, p2, p3)
			end

			if __DEV__ then
				setCurrentFiber(v1)
				invokeGuardedCallback(nil, t3.commitMutationEffectsImpl, nil, v1, p2, p3)

				if hasCaughtError() then
					t.captureCommitPhaseError(v1, v1.return_, (clearCaughtError()))
				end

				resetCurrentFiber()
			else
				local v6 = nil

				if __YOLO__ then
					t3.commitMutationEffectsImpl(v1, p2, p3)
					v2 = true
				else
					local ok, result = xpcall(t3.commitMutationEffectsImpl, describeError, v1, p2, p3)

					v2 = ok
					v6 = result
				end

				if not v2 then
					t.captureCommitPhaseError(v1, v1.return_, v6)
				end
			end

			v1 = v1.sibling
		end
	end
	function t3.commitMutationEffectsImpl(p1, p2, p3) --[[ Line: 2648 | Upvalues: ReactFiberFlags (copy), commitDetachRef (copy), commitPlacement (copy), commitWork (copy) ]]
		local flags = p1.flags

		if bit32.band(flags, ReactFiberFlags.Ref) ~= 0 then
			local alternate = p1.alternate

			if alternate ~= nil then
				commitDetachRef(alternate)
			end
		end

		local v2 = bit32.band(flags, (bit32.bor(ReactFiberFlags.Placement, ReactFiberFlags.Update, ReactFiberFlags.Hydrating)))

		if v2 == ReactFiberFlags.Placement then
			commitPlacement(p1)
			p1.flags = bit32.band(p1.flags, (bit32.bnot(ReactFiberFlags.Placement)))

			return
		end

		if v2 == ReactFiberFlags.PlacementAndUpdate then
			commitPlacement(p1)
			p1.flags = bit32.band(p1.flags, (bit32.bnot(ReactFiberFlags.Placement)))
		elseif v2 ~= ReactFiberFlags.Update then
			return
		end

		commitWork(p1.alternate, p1)
	end
	function t3.commitMutationEffectsDeletions(p1, p2, p3, p4) --[[ Line: 2714 | Upvalues: commitDeletion (copy), describeError (copy), t (copy) ]]
		for v1, v2 in p1 do
			local ok, result = xpcall(commitDeletion, describeError, p3, v2, p2, p4)

			if not ok then
				t.captureCommitPhaseError(v2, p2, result)
			end
		end
	end
	function t.schedulePassiveEffectCallback() --[[ Line: 2732 | Upvalues: v27 (ref), scheduleCallback (copy), NormalPriority (copy), t (copy) ]]
		if v27 then
			return
		end

		v27 = true
		scheduleCallback(NormalPriority, function() --[[ Line: 2735 | Upvalues: t (ref) ]]
			t.flushPassiveEffects()

			return nil
		end)
	end

	local v40 = nil

	function t.flushPassiveEffects() --[[ Line: 2744 | Upvalues: v29 (ref), NoPriority (copy), NormalPriority (copy), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), schedulerPriorityToLanePriority (copy), __YOLO__ (copy), runWithPriority (copy), describeError (copy), v40 (ref) ]]
		if v29 == NoPriority then
			return false
		end

		local v1 = if NormalPriority < v29 then NormalPriority else v29

		v29 = NoPriority

		if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
			return runWithPriority(v1, v40)
		end

		local v2 = getCurrentUpdateLanePriority()

		setCurrentUpdateLanePriority(schedulerPriorityToLanePriority(v1))

		local v3, v4

		if __YOLO__ then
			setCurrentUpdateLanePriority(schedulerPriorityToLanePriority(v1))
			v3, v4 = true, runWithPriority(v1, v40)
		else
			local ok, result = xpcall(runWithPriority, describeError, v1, v40)

			v3 = ok
			v4 = result
		end

		setCurrentUpdateLanePriority(v2)

		if not v3 then
			error(v4)
		end

		return v4
	end

	local function v41(p1, p2) --[[ Line: 2788 | Upvalues: ReactFeatureFlags (copy), ReactWorkTags (copy), v23 (ref), ReactFiberFlags (copy), v41 (ref), __DEV__ (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), commitPassiveMount (copy), hasCaughtError (copy), clearCaughtError (copy), t (copy), resetCurrentFiber (copy), __YOLO__ (copy), describeError (copy) ]]
		local v1 = p2

		while v1 ~= nil do
			local v2, v3

			if ReactFeatureFlags.enableProfilerTimer and (ReactFeatureFlags.enableProfilerCommitHooks and v1.tag == ReactWorkTags.Profiler) then
				v2 = v23
				v23 = v1
			else
				v2 = nil
			end

			if v1.child ~= nil and bit32.band(v1.subtreeFlags, ReactFiberFlags.PassiveMask) ~= ReactFiberFlags.NoFlags then
				v41(p1, v1.child)
			end

			if bit32.band(v1.flags, ReactFiberFlags.Passive) ~= ReactFiberFlags.NoFlags then
				if __DEV__ then
					setCurrentFiber(v1)
					invokeGuardedCallback(nil, commitPassiveMount, nil, p1, v1)

					if hasCaughtError() then
						t.captureCommitPhaseError(v1, v1.return_, (clearCaughtError()))
					end

					resetCurrentFiber()
				else
					local v6 = nil

					if __YOLO__ then
						commitPassiveMount(p1, v1)
						v3 = true
					else
						local ok, result = xpcall(commitPassiveMount, describeError, p1, v1)

						v3 = ok
						v6 = result
					end

					if not v3 then
						t.captureCommitPhaseError(v1, v1.return_, v6)
					end
				end
			end

			if ReactFeatureFlags.enableProfilerTimer and (ReactFeatureFlags.enableProfilerCommitHooks and v1.tag == ReactWorkTags.Profiler) then
				if v2 ~= nil then
					local stateNode = v2.stateNode

					stateNode.passiveEffectDuration = stateNode.passiveEffectDuration + v1.stateNode.passiveEffectDuration
				end

				v23 = v2
			end

			v1 = v1.sibling
		end
	end

	local function v42(p1) --[[ flushPassiveUnmountEffects | Line: 2857 | Upvalues: t3 (copy), ReactFiberFlags (copy), v42 (copy), setCurrentFiber (copy), commitPassiveUnmount (copy), resetCurrentFiber (copy) ]]
		local v1 = p1

		while v1 ~= nil do
			local deletions = v1.deletions

			if deletions ~= nil then
				for i = 1, #deletions do
					local v2 = deletions[i]

					t3.flushPassiveUnmountEffectsInsideOfDeletedTree(v2, v1)
					t3.detachFiberAfterEffects(v2)
				end
			end

			local child = v1.child

			if child ~= nil and bit32.band(v1.subtreeFlags, ReactFiberFlags.PassiveMask) ~= ReactFiberFlags.NoFlags then
				v42(child)
			end

			if bit32.band(v1.flags, ReactFiberFlags.Passive) ~= ReactFiberFlags.NoFlags then
				setCurrentFiber(v1)
				commitPassiveUnmount(v1)
				resetCurrentFiber()
			end

			v1 = v1.sibling
		end
	end

	function t3.flushPassiveUnmountEffectsInsideOfDeletedTree(p1, p2) --[[ Line: 2897 | Upvalues: ReactFiberFlags (copy), t3 (copy), setCurrentFiber (copy), commitPassiveUnmountInsideDeletedTree (copy), resetCurrentFiber (copy) ]]
		if bit32.band(p1.subtreeFlags, ReactFiberFlags.PassiveStatic) ~= ReactFiberFlags.NoFlags then
			local child = p1.child

			while child ~= nil do
				t3.flushPassiveUnmountEffectsInsideOfDeletedTree(child, p2)
				child = child.sibling
			end
		end

		if bit32.band(p1.flags, ReactFiberFlags.PassiveStatic) == ReactFiberFlags.NoFlags then
			return
		end

		setCurrentFiber(p1)
		commitPassiveUnmountInsideDeletedTree(p1, p2)
		resetCurrentFiber()
	end
	v40 = function() --[[ Line: 2929 | Upvalues: v28 (ref), NoLanes5 (ref), ReactFiberLane (copy), invariant (copy), v14 (ref), __DEV__ (copy), enableDebugTracing (copy), DebugTracing (copy), enableSchedulingProfiler (copy), SchedulingProfiler (copy), t3 (copy), v42 (copy), v41 (ref), enableDoubleInvokingEffects (copy), ReactFeatureFlags (copy), flushSyncCallbackQueue (copy), v33 (ref) ]]
		if v28 == nil then
			return false
		end

		local v1 = v28
		local v2 = NoLanes5

		v28 = nil
		NoLanes5 = ReactFiberLane.NoLanes
		invariant(bit32.band(v14, 48) == 0, "Cannot flush passive effects while already rendering.")

		if __DEV__ and enableDebugTracing then
			DebugTracing.logPassiveEffectsStarted(v2)
		end

		if enableSchedulingProfiler then
			SchedulingProfiler.markPassiveEffectsStarted(v2)
		end

		local v6 = v14

		v14 = bit32.bor(v14, 32)

		local v8 = t3.pushInteractions(v1)

		v42(v1.current)
		v41(v1, v1.current)

		if __DEV__ and enableDebugTracing then
			DebugTracing.logPassiveEffectsStopped()
		end

		if enableSchedulingProfiler then
			SchedulingProfiler.markPassiveEffectsStopped()
		end

		if __DEV__ and enableDoubleInvokingEffects then
			commitDoubleInvokeEffectsInDEV(v1.current, true)
		end

		if ReactFeatureFlags.enableSchedulerTracing then
			t3.popInteractions(v8)
			t3.finishPendingInteractions(v1, v2)
		end

		v14 = v6
		flushSyncCallbackQueue()
		v33 = if v28 == nil then 0 else v33 + 1

		return true
	end
	function t.isAlreadyFailedLegacyErrorBoundary(p1) --[[ Line: 3002 | Upvalues: v26 (ref) ]]
		return if v26 == nil then false else v26:has(p1)
	end
	function t.markLegacyErrorBoundaryAsFailed(p1) --[[ Line: 3008 | Upvalues: v26 (ref), Set (copy) ]]
		if v26 == nil then
			v26 = Set.new({ p1 })
		else
			v26:add(p1)
		end
	end
	function t.onUncaughtError(p1) --[[ prepareToThrowUncaughtError | Line: 3017 | Upvalues: v24 (ref), v25 (ref) ]]
		if v24 then
			return
		end

		v24 = true
		v25 = p1
	end
	v13 = function(p1, p2, p3) --[[ Line: 3025 | Upvalues: createCapturedValue (copy), createRootErrorUpdate (copy), SyncLane (copy), t (copy), enqueueUpdate (copy), t3 (copy), markRootUpdated (copy), v8 (ref) ]]
		enqueueUpdate(p1, (createRootErrorUpdate(p1, createCapturedValue(p3, p2), SyncLane, t.onUncaughtError)))

		local v1 = t.requestEventTime()
		local v2 = t3.markUpdateLaneFromFiberToRoot(p1, SyncLane)

		if v2 == nil then
			return
		end

		markRootUpdated(v2, SyncLane, v1)
		v8(v2, v1)
		t3.schedulePendingInteractions(v2, SyncLane)
	end
	function t.captureCommitPhaseError(p1, p2, p3) --[[ Line: 3046 | Upvalues: ReactWorkTags (copy), v13 (ref), skipUnmountedBoundaries (copy), t (copy), createCapturedValue (copy), createClassErrorUpdate (copy), SyncLane (copy), enqueueUpdate (copy), t3 (copy), markRootUpdated (copy), v8 (ref) ]]
		if p1.tag == ReactWorkTags.HostRoot then
			v13(p1, p1, p3)

			return
		end

		local v1 = if skipUnmountedBoundaries then p2 else p1.return_

		while v1 ~= nil do
			if v1.tag == ReactWorkTags.HostRoot then
				v13(v1, p1, p3)

				return
			end

			if v1.tag == ReactWorkTags.ClassComponent then
				local stateNode = v1.stateNode

				if typeof(v1.type.getDerivedStateFromError) == "function" or typeof(stateNode.componentDidCatch) == "function" and not t.isAlreadyFailedLegacyErrorBoundary(stateNode) then
					local v3, v4

					enqueueUpdate(v1, (createClassErrorUpdate(v1, createCapturedValue(p3, p1), SyncLane)))
					v3 = t.requestEventTime()
					v4 = t3.markUpdateLaneFromFiberToRoot(v1, SyncLane)

					if v4 ~= nil then
						markRootUpdated(v4, SyncLane, v3)
						v8(v4, v3)
						t3.schedulePendingInteractions(v4, SyncLane)
					end

					return
				end
			end

			v1 = v1.return_
		end
	end
	function t.pingSuspendedRoot(p1, p2, p3) --[[ Line: 3095 | Upvalues: t (copy), markRootPinged (copy), v15 (ref), isSubsetOfLanes (copy), NoLanes (ref), v18 (ref), includesOnlyRetries (copy), now (copy), v21 (ref), t3 (copy), ReactFiberLane (copy), NoLanes4 (ref), mergeLanes (copy), v8 (ref) ]]
		local pingCache = p1.pingCache

		if pingCache ~= nil then
			pingCache[p2] = nil
		end

		local v1 = t.requestEventTime()

		markRootPinged(p1, p3, v1)

		if v15 == p1 and isSubsetOfLanes(NoLanes, p3) then
			if v18 == 4 or v18 == 3 and (includesOnlyRetries(NoLanes) and now() - v21 < 500) then
				t3.prepareFreshStack(p1, ReactFiberLane.NoLanes)
			else
				NoLanes4 = mergeLanes(NoLanes4, p3)
			end
		end

		v8(p1, v1)
		t3.schedulePendingInteractions(p1, p3)
	end
	function retryTimedOutBoundary(p1, p2) --[[ retryTimedOutBoundary | Line: 3139 | Upvalues: ReactFiberLane (copy), t (copy), t3 (copy), markRootUpdated (copy), v8 (ref) ]]
		if p2 == ReactFiberLane.NoLane then
			p2 = requestRetryLane(p1)
		end

		local v2 = t.requestEventTime()
		local v3 = t3.markUpdateLaneFromFiberToRoot(p1, p2)

		if v3 == nil then
			return
		end

		markRootUpdated(v3, p2, v2)
		v8(v3, v2)
		t3.schedulePendingInteractions(v3, p2)
	end
	function t.resolveRetryWakeable(p1, p2) --[[ Line: 3166 | Upvalues: ReactFiberLane (copy) ]]
		local NoLane = ReactFiberLane.NoLane
		local stateNode = p1.stateNode

		if stateNode == nil then
			retryTimedOutBoundary(p1, NoLane)

			return
		end

		stateNode:delete(p2)
		retryTimedOutBoundary(p1, NoLane)
	end
	function jnd(p1) --[[ jnd | Line: 3210 ]]
		if p1 < 120 then
			return 120
		end

		if p1 < 480 then
			return 480
		end

		if p1 < 1080 then
			return 1080
		end

		if p1 < 1920 then
			return 1920
		end

		if p1 < 3000 then
			return 3000
		end

		if p1 < 4320 then
			return 4320
		end

		return math.ceil(p1 / 1960) * 1960
	end
	function t3.checkForNestedUpdates() --[[ Line: 3228 | Upvalues: v31 (ref), v32 (ref), invariant (copy), __DEV__ (copy), v33 (ref), console (copy) ]]
		if v31 > 50 then
			v31 = 0
			v32 = nil
			invariant(false, "Maximum update depth exceeded. This can happen when a component repeatedly calls setState inside componentWillUpdate or componentDidUpdate. React limits the number of nested updates to prevent infinite loops.")
		end

		if not (__DEV__ and v33 > 50) then
			return
		end

		v33 = 0
		console.error("Maximum update depth exceeded. This can happen when a component calls setState inside useEffect, but useEffect either doesn\'t have a dependency array, or one of the dependencies changes on every render.")
	end
	function flushRenderPhaseStrictModeWarningsInDEV() --[[ flushRenderPhaseStrictModeWarningsInDEV | Line: 3254 | Upvalues: __DEV__ (copy), v12 (copy), ReactFeatureFlags (copy) ]]
		if not __DEV__ then
			return
		end

		v12.flushLegacyContextWarning()

		if not ReactFeatureFlags.warnAboutDeprecatedLifecycles then
			return
		end

		v12.flushPendingUnsafeLifecycleWarnings()
	end
	function commitDoubleInvokeEffectsInDEV(p1, p2) --[[ commitDoubleInvokeEffectsInDEV | Line: 3264 | Upvalues: __DEV__ (copy), enableDoubleInvokingEffects (copy), setCurrentFiber (copy), ReactFiberFlags (copy), invokeLayoutEffectUnmountInDEV (copy), invokePassiveEffectUnmountInDEV (copy), invokeLayoutEffectMountInDEV (copy), invokePassiveEffectMountInDEV (copy), resetCurrentFiber (copy) ]]
		if not (__DEV__ and enableDoubleInvokingEffects) then
			return
		end

		setCurrentFiber(p1)
		invokeEffectsInDev(p1, ReactFiberFlags.MountLayoutDev, invokeLayoutEffectUnmountInDEV)

		if p2 then
			invokeEffectsInDev(p1, ReactFiberFlags.MountPassiveDev, invokePassiveEffectUnmountInDEV)
		end

		invokeEffectsInDev(p1, ReactFiberFlags.MountLayoutDev, invokeLayoutEffectMountInDEV)

		if p2 then
			invokeEffectsInDev(p1, ReactFiberFlags.MountPassiveDev, invokePassiveEffectMountInDEV)
		end

		resetCurrentFiber()
	end
	function invokeEffectsInDev(p1, p2, p3) --[[ invokeEffectsInDev | Line: 3296 | Upvalues: __DEV__ (copy), enableDoubleInvokingEffects (copy), ReactFiberFlags (copy) ]]
		if not (__DEV__ and enableDoubleInvokingEffects) then
			return
		end

		local v1 = p1

		while v1 ~= nil do
			if v1.child ~= nil and bit32.band(v1.subtreeFlags, p2) ~= ReactFiberFlags.NoFlags then
				invokeEffectsInDev(v1.child, p2, p3)
			end

			if bit32.band(v1.flags, p2) ~= ReactFiberFlags.NoFlags then
				p3(v1)
			end

			v1 = v1.sibling
		end
	end

	local v43 = nil

	function t3.warnAboutUpdateOnNotYetMountedFiberInDEV(p1) --[[ Line: 3322 | Upvalues: __DEV__ (copy), v14 (ref), ReactTypeOfMode (copy), ReactWorkTags (copy), getComponentName (copy), v43 (ref), ReactCurrentFiber (copy), setCurrentFiber (copy), console (copy), resetCurrentFiber (copy) ]]
		if not __DEV__ then
			return
		end

		if bit32.band(v14, 16) ~= 0 then
			return
		end

		if bit32.band(p1.mode, (bit32.bor(ReactTypeOfMode.BlockingMode, ReactTypeOfMode.ConcurrentMode))) == 0 then
			return
		end

		local tag = p1.tag

		if tag ~= ReactWorkTags.IndeterminateComponent and (tag ~= ReactWorkTags.HostRoot and (tag ~= ReactWorkTags.ClassComponent and (tag ~= ReactWorkTags.FunctionComponent and (tag ~= ReactWorkTags.ForwardRef and (tag ~= ReactWorkTags.MemoComponent and (tag ~= ReactWorkTags.SimpleMemoComponent and tag ~= ReactWorkTags.Block)))))) then
			return
		end

		local v3 = getComponentName(p1.type) or "ReactComponent"

		if v43 == nil then
			v43 = {
				[v3] = true
			}
		else
			if v43[v3] then
				return
			end

			v43[v3] = true
		end

		local ok, result = pcall(function() --[[ Line: 3367 | Upvalues: setCurrentFiber (ref), p1 (copy), console (ref) ]]
			setCurrentFiber(p1)
			console.error("Can\'t perform a React state update on a component that hasn\'t mounted yet. This indicates that you have a side-effect in your render function that asynchronously later calls tries to update the component. Move this work to useEffect instead.")
		end)

		if ReactCurrentFiber.current then
			setCurrentFiber(p1)
		else
			resetCurrentFiber()
		end

		if ok then
			return
		end

		error(result)
	end

	if __DEV__ and ReactFeatureFlags.replayFailedUnitOfWorkWithInvokeGuardedCallback then
		function t3.beginWork(p1, p2, p3) --[[ Line: 3393 | Upvalues: v4 (copy), f9 (copy), describeError (copy), resetContextDependencies (copy), t2 (copy), v10 (ref), unwindInterruptedWork (copy), ReactFeatureFlags (copy), ReactTypeOfMode (copy), v11 (copy), invokeGuardedCallback (copy), hasCaughtError (copy), clearCaughtError (copy) ]]
			local v1 = v4.assignFiberPropertiesInDEV(nil, p2)
			local ok, result = xpcall(f9, describeError, p1, p2, p3)

			if not ok then
				if result ~= nil and typeof(result) == "table" and typeof(result.andThen) == "function" then
					error(result)
				end

				resetContextDependencies()

				if not t2.resetHooksAfterThrowRef then
					v10 = require(script.Parent:WaitForChild("ReactFiberHooks.new"))
					t2.resetHooksAfterThrowRef = v10.resetHooksAfterThrow
					t2.ContextOnlyDispatcherRef = v10.ContextOnlyDispatcher
					t2.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = v10.getIsUpdatingOpaqueValueInRenderPhaseInDEV
				end

				t2.resetHooksAfterThrowRef()
				unwindInterruptedWork(p2)
				v4.assignFiberPropertiesInDEV(p2, v1)

				if ReactFeatureFlags.enableProfilerTimer and bit32.band(p2.mode, ReactTypeOfMode.ProfileMode) ~= 0 then
					v11.startProfilerTimer(p2)
				end

				invokeGuardedCallback(nil, f9, nil, p1, p2, p3)

				if hasCaughtError() then
					error((clearCaughtError()))
				end

				error(result)
			end

			return result
		end
	else
		t3.beginWork = f9
	end

	local v44 = false
	local v45 = if __DEV__ then {} else nil

	function t3.warnAboutRenderPhaseUpdatesInDEV(p1) --[[ Line: 3463 | Upvalues: __DEV__ (copy), ReactCurrentFiber (copy), v14 (ref), t2 (copy), v10 (ref), ReactWorkTags (copy), v16 (ref), getComponentName (copy), v45 (ref), console (copy), v44 (ref) ]]
		if not (__DEV__ and ReactCurrentFiber.isRendering) then
			return
		end

		if bit32.band(v14, 16) == 0 then
			return
		end

		if not t2.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef then
			v10 = require(script.Parent:WaitForChild("ReactFiberHooks.new"))
			t2.resetHooksAfterThrowRef = v10.resetHooksAfterThrow
			t2.ContextOnlyDispatcherRef = v10.ContextOnlyDispatcher
			t2.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = v10.getIsUpdatingOpaqueValueInRenderPhaseInDEV
		end

		if t2.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef() then
			return
		end

		if p1.tag == ReactWorkTags.FunctionComponent or (p1.tag == ReactWorkTags.ForwardRef or p1.tag == ReactWorkTags.SimpleMemoComponent) then
			local v2 = if v16 == nil then "Unknown" else getComponentName(v16.type)

			if v45[v2] == nil then
				v45[v2] = true
				console.error("Cannot update a component (`%s`) while rendering a different component (`%s`). To locate the bad setState() call inside `%s`, follow the stack trace as described in https://reactjs.org/link/setstate-in-render", getComponentName(p1.type) or "Unknown", v2, v2)
			end
		else
			if p1.tag ~= ReactWorkTags.ClassComponent or v44 then
				return
			end

			console.error("Cannot update during an existing state transition (such as within `render`). Render methods should be a pure function of props and state.")
			v44 = true
		end
	end
	t.IsThisRendererActing = {
		current = false
	}
	function t.warnIfNotScopedWithMatchingAct(p1) --[[ Line: 3515 | Upvalues: __DEV__ (copy), ReactFiberHostConfig (copy), IsSomeRendererActing (copy), t (copy), ReactCurrentFiber (copy), setCurrentFiber (copy), console (copy), resetCurrentFiber (copy) ]]
		if not __DEV__ or (ReactFiberHostConfig.warnsIfNotActing ~= true or (IsSomeRendererActing.current ~= true or t.IsThisRendererActing.current == true)) then
			return
		end

		local ok, result = pcall(function() --[[ Line: 3523 | Upvalues: setCurrentFiber (ref), p1 (copy), console (ref) ]]
			setCurrentFiber(p1)
			console.error("It looks like you\'re using the wrong act() around your test interactions.\nBe sure to use the matching version of act() corresponding to your renderer:\n\n-- for react-roblox:\nlocal React = require(Packages.React)\n-- ...\nReact.TestUtils.act(function() ... end)\n\n-- for react-test-renderer:\nlocal TestRenderer = require(Packages.ReactTestRenderer)\n-- ...\nTestRenderer.act(function() ... end)")
		end)

		if ReactCurrentFiber.current then
			setCurrentFiber(p1)
		else
			resetCurrentFiber()
		end

		if ok then
			return
		end

		error(result)
	end
	function t.warnIfNotCurrentlyActingEffectsInDEV(p1) --[[ Line: 3559 | Upvalues: __DEV__ (copy), ReactFiberHostConfig (copy), ReactTypeOfMode (copy), IsSomeRendererActing (copy), t (copy), console (copy), getComponentName (copy) ]]
		if not __DEV__ or ReactFiberHostConfig.warnsIfNotActing ~= true then
			return
		end

		if bit32.band(p1.mode, ReactTypeOfMode.StrictMode) == ReactTypeOfMode.NoMode or (IsSomeRendererActing.current ~= false or t.IsThisRendererActing.current ~= false) then
			return
		end

		console.error("An update to %s ran an effect, but was not wrapped in act(...).\n\nWhen testing, code that causes React state updates should be wrapped into act(...):\n\nact(function()\n  --[[ fire events that update state ]]\nend)\n--[[ assert on the output ]]\n\nThis ensures that you\'re testing the behavior the user would see in the real client. Learn more at https://reactjs.org/link/wrap-tests-with-act", getComponentName(p1.type))
	end
	function t.warnIfNotCurrentlyActingUpdatesInDEV(p1) --[[ Line: 3585 | Upvalues: __DEV__ (copy), ReactFiberHostConfig (copy), v14 (ref), IsSomeRendererActing (copy), t (copy), current (copy), setCurrentFiber (copy), console (copy), getComponentName (copy), resetCurrentFiber (copy) ]]
		if not __DEV__ or (ReactFiberHostConfig.warnsIfNotActing ~= true or (v14 ~= 0 or (IsSomeRendererActing.current ~= false or t.IsThisRendererActing.current ~= false))) then
			return
		end

		local ok, result = pcall(function() --[[ Line: 3594 | Upvalues: setCurrentFiber (ref), p1 (copy), console (ref), getComponentName (ref) ]]
			setCurrentFiber(p1)
			console.error("An update to %s inside a test was not wrapped in act(...).\n\nWhen testing, code that causes React state updates should be wrapped into act(...):\n\nact(function()\n  --[[ fire events that update state ]]\nend)\n--[[ assert on the output ]]\n\nThis ensures that you\'re testing the behavior the user would see in the client application. Learn more at https://reactjs.org/link/wrap-tests-with-act", getComponentName(p1.type))
		end)

		if current then
			setCurrentFiber(p1)
		else
			resetCurrentFiber()
		end

		if ok then
			return result
		end
	end

	local v46 = false

	function t.warnIfUnmockedScheduler(p1) --[[ Line: 3635 | Upvalues: __DEV__ (copy), v46 (ref), scheduler (copy), ReactTypeOfMode (copy), console (copy), ReactFeatureFlags (copy) ]]
		if not __DEV__ or (v46 ~= false or scheduler.unstable_flushAllWithoutAsserting ~= nil) then
			return
		end

		if bit32.band(p1.mode, ReactTypeOfMode.BlockingMode) ~= 0 then
			v46 = true
			console.error("In Concurrent or Sync modes, the \'scheduler\' module needs to be mocked to guarantee consistent behaviour across tests and client application. For example, with Jest: \njest.mock(\'scheduler\', function() return require(@pkg/scheduler).unstable_mock end)\n\nFor more info, visit https://reactjs.org/link/mock-scheduler")

			return
		end

		if bit32.band(p1.mode, ReactTypeOfMode.ConcurrentMode) ~= 0 then
			v46 = true
			console.error("In Concurrent or Sync modes, the \'scheduler\' module needs to be mocked to guarantee consistent behaviour across tests and client application. For example, with Jest: \njest.mock(\'scheduler\', function() return require(@pkg/scheduler).unstable_mock end)\n\nFor more info, visit https://reactjs.org/link/mock-scheduler")

			return
		end

		if ReactFeatureFlags.warnAboutUnmockedScheduler ~= true then
			return
		end

		v46 = true
		console.error("Starting from React v18, the \'scheduler\' module will need to be mocked to guarantee consistent behaviour across tests and client applications. For example, with Jest: \njest.mock(\'scheduler\', function() return require(@pkg/scheduler).unstable_mock end)\n\nFor more info, visit https://reactjs.org/link/mock-scheduler")
	end
	function computeThreadID(p1, p2) --[[ computeThreadID | Line: 3678 ]]
		return p2 * 1000 + p1.interactionThreadID
	end
	function t.markSpawnedWork(p1) --[[ Line: 3686 | Upvalues: ReactFeatureFlags (copy), v34 (ref) ]]
		if not ReactFeatureFlags.enableSchedulerTracing then
			return
		end

		if v34 == nil then
			v34 = { p1 }
		else
			table.insert(v34, p1)
		end
	end
	function scheduleInteractions(p1, p2, p3) --[[ scheduleInteractions | Line: 3698 | Upvalues: ReactFeatureFlags (copy), Set (copy), __subscriberRef (copy) ]]
		if not ReactFeatureFlags.enableSchedulerTracing then
			return
		end

		if not (p3.size > 0) then
			return
		end

		local pendingInteractionMap = p1.pendingInteractionMap
		local v1 = pendingInteractionMap:get(p2)

		if v1 == nil then
			pendingInteractionMap:set(p2, Set.new(p3))

			for v2, v3 in p3 do
				v3.__count = v3.__count + 1
			end
		else
			p3:forEach(function(p1) --[[ Line: 3711 | Upvalues: v1 (copy) ]]
				if not v1:has(p1) then
					p1.__count = p1.__count + 1
				end

				v1:add(p1)
			end)
		end

		local current = __subscriberRef.current

		if current == nil then
			return
		end

		current.onWorkScheduled(p3, (computeThreadID(p1, p2)))
	end
	function t3.schedulePendingInteractions(p1, p2) --[[ Line: 3736 | Upvalues: ReactFeatureFlags (copy), __interactionsRef (copy) ]]
		if ReactFeatureFlags.enableSchedulerTracing then
			scheduleInteractions(p1, p2, __interactionsRef.current)
		end
	end
	function t3.startWorkOnPendingInteractions(p1, p2) --[[ Line: 3747 | Upvalues: ReactFeatureFlags (copy), Set (copy), includesSomeLane (copy), __subscriberRef (copy), describeError (copy), scheduleCallback (copy), ImmediatePriority (copy) ]]
		if not ReactFeatureFlags.enableSchedulerTracing then
			return
		end

		local v1 = Set.new()

		p1.pendingInteractionMap:forEach(function(p1, p22) --[[ Line: 3757 | Upvalues: includesSomeLane (ref), p2 (copy), v1 (copy) ]]
			if not includesSomeLane(p2, p22) then
				return
			end

			p1:forEach(function(p1) --[[ Line: 3759 | Upvalues: v1 (ref) ]]
				v1:add(p1)
			end)
		end)
		p1.memoizedInteractions = v1

		if not (v1.size > 0) then
			return
		end

		local current = __subscriberRef.current

		if current == nil then
			return
		end

		local ok, result = xpcall(current.onWorkStarted, describeError, v1, (computeThreadID(p1, p2)))

		if ok then
			return
		end

		scheduleCallback(ImmediatePriority, function() --[[ Line: 3781 | Upvalues: result (copy) ]]
			error(result)
		end)
	end
	function t3.finishPendingInteractions(p1, p2) --[[ Line: 3789 | Upvalues: ReactFeatureFlags (copy), __subscriberRef (copy), describeError (copy), includesSomeLane (copy), scheduleCallback (copy), ImmediatePriority (copy) ]]
		if not ReactFeatureFlags.enableSchedulerTracing then
			return
		end

		local pendingLanes = p1.pendingLanes
		local v1 = nil
		local v2, v3

		if v1 == nil or not (p1.memoizedInteractions.size > 0) then
			v2 = nil
			v3 = true
		else
			local v4 = computeThreadID(p1, p2)

			v1 = __subscriberRef.current

			local ok, result = xpcall(v1.onWorkStopped, describeError, p1.memoizedInteractions, v4)

			v2 = result
			v3 = ok
		end

		local pendingInteractionMap = p1.pendingInteractionMap

		pendingInteractionMap:forEach(function(p1, p2) --[[ Line: 3820 | Upvalues: includesSomeLane (ref), pendingLanes (copy), pendingInteractionMap (copy), v1 (ref), describeError (ref), scheduleCallback (ref), ImmediatePriority (ref) ]]
			if includesSomeLane(pendingLanes, p2) then
				return
			end

			pendingInteractionMap:delete(p2)
			p1:forEach(function(p1) --[[ Line: 3826 | Upvalues: v1 (ref), describeError (ref), scheduleCallback (ref), ImmediatePriority (ref) ]]
				p1.__count = p1.__count - 1

				if v1 == nil or p1.__count ~= 0 then
					return
				end

				local ok, result = xpcall(v1.onInteractionScheduledWorkCompleted, describeError, p1)

				if ok then
					return
				end

				scheduleCallback(ImmediatePriority, function() --[[ Line: 3837 | Upvalues: result (copy) ]]
					error(result)
				end)
			end)
		end)

		if v3 then
			return
		end

		scheduleCallback(ImmediatePriority, function() --[[ Line: 3849 | Upvalues: v2 (ref) ]]
			error(v2)
		end)
	end
end

local v47 = false
local v48 = false
local unstable_flushAllWithoutAsserting = scheduler.unstable_flushAllWithoutAsserting
local v49 = if typeof(unstable_flushAllWithoutAsserting) == "function" then true else false

local function flushActWork() --[[ flushActWork | Line: 3868 | Upvalues: unstable_flushAllWithoutAsserting (copy), v47 (ref), describeError (copy), t (copy) ]]
	if unstable_flushAllWithoutAsserting == nil then
		local v1 = v47

		v47 = true

		local ok, result = xpcall(function() --[[ Line: 3888 | Upvalues: t (ref) ]]
			local v1 = false

			while t.flushPassiveEffects() do
				v1 = true
			end

			return v1
		end, describeError)

		v47 = v1

		if ok then
			return result
		end

		error(result)
	end

	local v2 = v47

	v47 = true

	local ok, result = xpcall(unstable_flushAllWithoutAsserting, describeError)

	v47 = v2

	if ok then
		return result
	end

	error(result)
end

local function v50(p1) --[[ flushWorkAndMicroTasks | Line: 3907 | Upvalues: flushActWork (copy), describeError (copy), enqueueTask (copy), v50 (copy) ]]
	local ok, result = xpcall(flushActWork, describeError)

	if ok then
		local ok2, result2 = xpcall(enqueueTask, describeError, function() --[[ Line: 3911 | Upvalues: flushActWork (ref), v50 (ref), p1 (copy) ]]
			if flushActWork() then
				v50(p1)
			else
				p1()
			end
		end)

		ok = ok2
		result = result2
	end

	if ok then
		return
	end

	p1(result)
end

function t.act(p1) --[[ Line: 3925 | Upvalues: __DEV__ (copy), v39 (ref), console (copy), v38 (ref), IsSomeRendererActing (copy), t (copy), v48 (ref), describeError (copy), promise (copy), v49 (copy), v50 (copy), flushActWork (copy) ]]
	if not __DEV__ and (not _G.__ROACT_17_MOCK_SCHEDULER__ and v39 == false) then
		v39 = true
		console.error("act(...) is not supported in production builds of React, and might not behave as expected.")
	end

	local v1 = v38

	v38 = v38 + 1

	local current = IsSomeRendererActing.current
	local current2 = t.IsThisRendererActing.current
	local v2 = v48

	IsSomeRendererActing.current = true
	t.IsThisRendererActing.current = true
	v48 = true

	local function onDone() --[[ onDone | Line: 3950 | Upvalues: v38 (ref), IsSomeRendererActing (ref), current (copy), t (ref), current2 (copy), v48 (ref), v2 (copy), __DEV__ (ref), v1 (copy), console (ref) ]]
		v38 = v38 - 1
		IsSomeRendererActing.current = current
		t.IsThisRendererActing.current = current2
		v48 = v2

		if not (__DEV__ and v1 < v38) then
			return
		end

		console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ")
	end

	local ok, result = xpcall(t.batchedUpdates, describeError, p1)

	if not ok then
		v38 = v38 - 1
		IsSomeRendererActing.current = current
		t.IsThisRendererActing.current = current2
		v48 = v2

		if __DEV__ and v1 < v38 then
			console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ")
		end

		error(result)
	end

	if result ~= nil and typeof(result) == "table" and typeof(result.andThen) == "function" then
		local v3 = false

		if __DEV__ and typeof(promise) ~= nil then
			promise.resolve():andThen(function() --[[ Line: 3983 ]] end):andThen(function() --[[ Line: 3983 | Upvalues: v3 (ref), console (ref) ]]
				if v3 ~= false then
					return
				end

				console.error("You called act(Promise.new(function() --[[ ... ]] end)) without :await() or :expect(). This could lead to unexpected testing behaviour, interleaving multiple act calls and mixing their scopes. You should - act(function() Promise.new(function() --[[ ... ]] end):await() end);")
			end)
		end

		return {
			andThen = function(p1, p2, p3) --[[ andThen | Line: 4002 | Upvalues: v3 (ref), result (copy), v38 (ref), v49 (ref), current (copy), IsSomeRendererActing (ref), t (ref), current2 (copy), v48 (ref), v2 (copy), __DEV__ (ref), v1 (copy), console (ref), v50 (ref) ]]
				v3 = true

				return result:andThen(function() --[[ Line: 4004 | Upvalues: v38 (ref), v49 (ref), current (ref), IsSomeRendererActing (ref), t (ref), current2 (ref), v48 (ref), v2 (ref), __DEV__ (ref), v1 (ref), console (ref), p2 (copy), v50 (ref), p3 (copy) ]]
					if not (v38 > 1) and (v49 ~= true or current ~= true) then
						v50(function(p1) --[[ Line: 4018 | Upvalues: v38 (ref), IsSomeRendererActing (ref), current (ref), t (ref), current2 (ref), v48 (ref), v2 (ref), __DEV__ (ref), v1 (ref), console (ref), p3 (ref), p2 (ref) ]]
							v38 = v38 - 1
							IsSomeRendererActing.current = current
							t.IsThisRendererActing.current = current2
							v48 = v2

							if __DEV__ and v1 < v38 then
								console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ")
							end

							if p1 then
								p3(p1)
							else
								p2()
							end
						end)

						return
					end

					v38 = v38 - 1
					IsSomeRendererActing.current = current
					t.IsThisRendererActing.current = current2
					v48 = v2

					if __DEV__ and v1 < v38 then
						console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ")
					end

					p2()
				end, function(p1) --[[ Line: 4026 | Upvalues: v38 (ref), IsSomeRendererActing (ref), current (ref), t (ref), current2 (ref), v48 (ref), v2 (ref), __DEV__ (ref), v1 (ref), console (ref), p3 (copy) ]]
					v38 = v38 - 1
					IsSomeRendererActing.current = current
					t.IsThisRendererActing.current = current2
					v48 = v2

					if __DEV__ and v1 < v38 then
						console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ")
					end

					p3(p1)
				end)
			end
		}
	end

	if __DEV__ and result ~= nil then
		console.error("The callback passed to act(...) function must return nil, or a Promise. You returned %s", (tostring(result)))
	end

	local ok2, result2 = xpcall(function() --[[ Line: 4045 | Upvalues: v38 (ref), v49 (ref), current (copy), flushActWork (ref), IsSomeRendererActing (ref), t (ref), current2 (copy), v48 (ref), v2 (copy), __DEV__ (ref), v1 (copy), console (ref) ]]
		if v38 == 1 and (v49 == false or current == false) then
			flushActWork()
		end

		v38 = v38 - 1
		IsSomeRendererActing.current = current
		t.IsThisRendererActing.current = current2
		v48 = v2

		if not (__DEV__ and v1 < v38) then
			return
		end

		console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ")
	end, describeError)

	if ok2 then
		return {
			andThen = function(p13, p23, p33) --[[ andThen | Line: 4065 | Upvalues: __DEV__ (ref), console (ref) ]]
				if __DEV__ then
					console.error("Do not await the result of calling act(...) with sync logic, it is not a Promise.")
				end

				p23()
			end
		}
	end

	v38 = v38 - 1
	IsSomeRendererActing.current = current
	t.IsThisRendererActing.current = current2
	v48 = v2

	if __DEV__ and v1 < v38 then
		console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ")
	end

	error(result2)
end
function t3.detachFiberAfterEffects(p1) --[[ Line: 4077 | Upvalues: __DEV__ (copy) ]]
	p1.child = nil
	p1.deletions = nil
	p1.dependencies = nil
	p1.memoizedProps = nil
	p1.memoizedState = nil
	p1.pendingProps = nil
	p1.sibling = nil
	p1.stateNode = nil
	p1.updateQueue = nil

	if not __DEV__ then
		return
	end

	p1._debugOwner = nil
end

return t