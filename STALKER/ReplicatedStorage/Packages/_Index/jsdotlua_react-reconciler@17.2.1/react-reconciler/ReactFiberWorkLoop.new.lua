-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local _G___YOLO__ = _G.__YOLO__;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local Set = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Set;
local u1 = {};
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local scheduler = require(script.Parent.Parent:WaitForChild("scheduler"));
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local v2 = require(script.Parent:WaitForChild("ReactFiberStack.new"));
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing;
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler;
local skipUnmountedBoundaries = ReactFeatureFlags.skipUnmountedBoundaries;
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects;
local shared = require(script.Parent.Parent:WaitForChild("shared"));
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
local ReactSharedInternals = shared.ReactSharedInternals;
local invariant = shared.invariant;
local v3 = require(script.Parent:WaitForChild("SchedulerWithReactIntegration.new"));
local scheduleCallback = v3.scheduleCallback;
local cancelCallback = v3.cancelCallback;
local getCurrentPriorityLevel = v3.getCurrentPriorityLevel;
local runWithPriority = v3.runWithPriority;
local shouldYield = v3.shouldYield;
local requestPaint = v3.requestPaint;
local now = v3.now;
local NoPriority = v3.NoPriority;
local ImmediatePriority = v3.ImmediatePriority;
local UserBlockingPriority = v3.UserBlockingPriority;
local NormalPriority = v3.NormalPriority;
local flushSyncCallbackQueue = v3.flushSyncCallbackQueue;
local scheduleSyncCallback = v3.scheduleSyncCallback;
local DebugTracing = require(script.Parent:WaitForChild("DebugTracing"));
local SchedulingProfiler = require(script.Parent:WaitForChild("SchedulingProfiler"));
local tracing = require(script.Parent.Parent:WaitForChild("scheduler")).tracing;
local __interactionsRef = tracing.__interactionsRef;
local __subscriberRef = tracing.__subscriberRef;
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
local u4 = require(script.Parent:WaitForChild("ReactFiber.new"));
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"));
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local LegacyRoot = require(script.Parent:WaitForChild("ReactRootTags")).LegacyRoot;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local SyncLane = ReactFiberLane.SyncLane;
local SyncBatchedLane = ReactFiberLane.SyncBatchedLane;
local NoTimestamp = ReactFiberLane.NoTimestamp;
local findUpdateLane = ReactFiberLane.findUpdateLane;
local findTransitionLane = ReactFiberLane.findTransitionLane;
local findRetryLane = ReactFiberLane.findRetryLane;
local includesSomeLane = ReactFiberLane.includesSomeLane;
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes;
local mergeLanes = ReactFiberLane.mergeLanes;
local removeLanes = ReactFiberLane.removeLanes;
local pickArbitraryLane = ReactFiberLane.pickArbitraryLane;
local hasDiscreteLanes = ReactFiberLane.hasDiscreteLanes;
local includesNonIdleWork = ReactFiberLane.includesNonIdleWork;
local includesOnlyRetries = ReactFiberLane.includesOnlyRetries;
local includesOnlyTransitions = ReactFiberLane.includesOnlyTransitions;
local getNextLanes = ReactFiberLane.getNextLanes;
local returnNextLanesPriority = ReactFiberLane.returnNextLanesPriority;
local setCurrentUpdateLanePriority = ReactFiberLane.setCurrentUpdateLanePriority;
local getCurrentUpdateLanePriority = ReactFiberLane.getCurrentUpdateLanePriority;
local markStarvedLanesAsExpired = ReactFiberLane.markStarvedLanesAsExpired;
local getLanesToRetrySynchronouslyOnError = ReactFiberLane.getLanesToRetrySynchronouslyOnError;
local getMostRecentEventTime = ReactFiberLane.getMostRecentEventTime;
local markRootUpdated = ReactFiberLane.markRootUpdated;
local markRootSuspended = ReactFiberLane.markRootSuspended;
local markRootPinged = ReactFiberLane.markRootPinged;
local markRootExpired = ReactFiberLane.markRootExpired;
local markDiscreteUpdatesExpired = ReactFiberLane.markDiscreteUpdatesExpired;
local markRootFinished = ReactFiberLane.markRootFinished;
local schedulerPriorityToLanePriority = ReactFiberLane.schedulerPriorityToLanePriority;
local lanePriorityToSchedulerPriority = ReactFiberLane.lanePriorityToSchedulerPriority;
local ReactFiberTransition = require(script.Parent:WaitForChild("ReactFiberTransition"));
local v5 = require(script.Parent:WaitForChild("ReactFiberUnwindWork.new"));
local unwindWork = v5.unwindWork;
local unwindInterruptedWork = v5.unwindInterruptedWork;
local v6 = require(script.Parent:WaitForChild("ReactFiberThrow.new"));
local throwException = v6.throwException;
local createRootErrorUpdate = v6.createRootErrorUpdate;
local createClassErrorUpdate = v6.createClassErrorUpdate;
local u7 = require(script.Parent:WaitForChild("ReactFiberCommitWork.new"));
local commitBeforeMutationLifeCycles = u7.commitBeforeMutationLifeCycles;
local commitPlacement = u7.commitPlacement;
local commitWork = u7.commitWork;
local commitDeletion = u7.commitDeletion;
local commitPassiveUnmount = u7.commitPassiveUnmount;
local commitPassiveUnmountInsideDeletedTree = u7.commitPassiveUnmountInsideDeletedTree;
local commitPassiveMount = u7.commitPassiveMount;
local commitDetachRef = u7.commitDetachRef;
local invokeLayoutEffectMountInDEV = u7.invokeLayoutEffectMountInDEV;
local invokePassiveEffectMountInDEV = u7.invokePassiveEffectMountInDEV;
local invokeLayoutEffectUnmountInDEV = u7.invokeLayoutEffectUnmountInDEV;
local invokePassiveEffectUnmountInDEV = u7.invokePassiveEffectUnmountInDEV;
local recursivelyCommitLayoutEffects = u7.recursivelyCommitLayoutEffects;
local promise = require(script.Parent.Parent:WaitForChild("promise"));
local enqueueUpdate = require(script.Parent:WaitForChild("ReactUpdateQueue.new")).enqueueUpdate;
local resetContextDependencies = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).resetContextDependencies;
local RobloxReactProfiling = require(script.Parent.RobloxReactProfiling);
local u8 = nil;
local u9 = {
    resetHooksAfterThrowRef = nil,
    ContextOnlyDispatcherRef = nil,
    getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = nil,
    originalBeginWorkRef = nil,
    completeWorkRef = nil
};

local function u13(p10, p11, p12) -- Line: 240
    -- upvalues: u9 (copy)
    if not u9.originalBeginWorkRef then
        u9.originalBeginWorkRef = require(script.Parent:WaitForChild("ReactFiberBeginWork.new")).beginWork;
    end;

    return u9.originalBeginWorkRef(p10, p11, p12);
end;

local function _(p14, p15, p16) -- Line: 249
    -- upvalues: u9 (copy)
    if not u9.completeWorkRef then
        u9.completeWorkRef = require(script.Parent:WaitForChild("ReactFiberCompleteWork.new")).completeWork;
    end;

    return u9.completeWorkRef(p14, p15, p16);
end;

local u17 = nil;

local function initReactFiberHooks() -- Line: 259
    -- upvalues: u17 (ref), u9 (copy)
    u17 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
    u9.resetHooksAfterThrowRef = u17.resetHooksAfterThrow;
    u9.ContextOnlyDispatcherRef = u17.ContextOnlyDispatcher;
    u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = u17.getIsUpdatingOpaqueValueInRenderPhaseInDEV;
end;

local function _() -- Line: 268
    -- upvalues: u9 (copy), u17 (ref)
    if not u9.resetHooksAfterThrowRef then
        u17 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
        u9.resetHooksAfterThrowRef = u17.resetHooksAfterThrow;
        u9.ContextOnlyDispatcherRef = u17.ContextOnlyDispatcher;
        u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = u17.getIsUpdatingOpaqueValueInRenderPhaseInDEV;
    end;

    return u9.resetHooksAfterThrowRef();
end;

local function _() -- Line: 276
    -- upvalues: u9 (copy), u17 (ref)
    if not u9.ContextOnlyDispatcherRef then
        u17 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
        u9.resetHooksAfterThrowRef = u17.resetHooksAfterThrow;
        u9.ContextOnlyDispatcherRef = u17.ContextOnlyDispatcher;
        u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = u17.getIsUpdatingOpaqueValueInRenderPhaseInDEV;
    end;

    return u9.ContextOnlyDispatcherRef;
end;

local function _() -- Line: 284
    -- upvalues: u9 (copy), u17 (ref)
    if not u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef then
        u17 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
        u9.resetHooksAfterThrowRef = u17.resetHooksAfterThrow;
        u9.ContextOnlyDispatcherRef = u17.ContextOnlyDispatcher;
        u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = u17.getIsUpdatingOpaqueValueInRenderPhaseInDEV;
    end;

    return u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef();
end;

local createCapturedValue = require(script.Parent:WaitForChild("ReactCapturedValue")).createCapturedValue;
local push = v2.push;
local pop = v2.pop;
local createCursor = v2.createCursor;
local u18 = require(script.Parent:WaitForChild("ReactProfilerTimer.new"));
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local u19 = require(script.Parent:WaitForChild("ReactStrictModeWarnings.new"));
local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"));
local current = ReactCurrentFiber.current;
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber;
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber;
local ReactErrorUtils = require(script.Parent.Parent:WaitForChild("shared")).ReactErrorUtils;
local invokeGuardedCallback = ReactErrorUtils.invokeGuardedCallback;
local hasCaughtError = ReactErrorUtils.hasCaughtError;
local clearCaughtError = ReactErrorUtils.clearCaughtError;
local onCommitRoot = require(script.Parent:WaitForChild("ReactFiberDevToolsHook.new")).onCommitRoot;
local onCommitRoot2 = require(script.Parent:WaitForChild("ReactTestSelectors")).onCommitRoot;
local enqueueTask = require(script.Parent.Parent:WaitForChild("shared")).enqueueTask;
local doesFiberContain = require(script.Parent:WaitForChild("ReactFiberTreeReflection")).doesFiberContain;
local ReactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher;
local ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner;
local IsSomeRendererActing = ReactSharedInternals.IsSomeRendererActing;
local u20 = nil;
local u21 = {};
u1.NoContext = 0;
u1.RetryAfterError = 64;
local u22 = 0;
local u23 = nil;
local u24 = nil;
local NoLanes = ReactFiberLane.NoLanes;
u1.subtreeRenderLanes = ReactFiberLane.NoLanes;
local u25 = createCursor(ReactFiberLane.NoLanes);
local u26 = 0;
local u27 = nil;
local NoLanes2 = ReactFiberLane.NoLanes;
local ReactFiberWorkInProgress = require(script.Parent:WaitForChild("ReactFiberWorkInProgress"));
local workInProgressRootSkippedLanes = ReactFiberWorkInProgress.workInProgressRootSkippedLanes;
local NoLanes3 = ReactFiberLane.NoLanes;
local NoLanes4 = ReactFiberLane.NoLanes;
local u28 = nil;
local u29 = 0;
local u30 = (1 / 0);
local u31 = nil;

local function resetRenderTimer() -- Line: 419
    -- upvalues: u30 (ref), now (copy)
    u30 = now() + 500;
end;

function u1.getRenderTargetTime() -- Line: 423
    -- upvalues: u30 (ref)
    return u30;
end;

local u32 = false;
local u33 = nil;
local u34 = nil;
local u35 = false;
local u36 = nil;
local u37 = NoPriority;
local NoLanes5 = ReactFiberLane.NoLanes;
local u38 = nil;
local u39 = 0;
local u40 = nil;
local u41 = 0;
local u42 = nil;
local u43 = NoTimestamp;
local NoLanes6 = ReactFiberLane.NoLanes;
local NoLanes7 = ReactFiberLane.NoLanes;
local u44 = nil;
local u45 = false;

function u1.getWorkInProgressRoot() -- Line: 463
    -- upvalues: u23 (ref)
    return u23;
end;

function u1.requestEventTime() -- Line: 467
    -- upvalues: u22 (ref), now (copy), u43 (ref), NoTimestamp (copy)
    if bit32.band(u22, 48) ~= 0 then
        return now();
    end;

    if u43 ~= NoTimestamp then
        return u43;
    end;

    u43 = now();

    return u43;
end;

function u1.requestUpdateLane(p46) -- Line: 489
    -- upvalues: ReactTypeOfMode (copy), SyncLane (copy), getCurrentPriorityLevel (copy), ImmediatePriority (copy), SyncBatchedLane (copy), ReactFeatureFlags (copy), u22 (ref), NoLanes (ref), ReactFiberLane (copy), pickArbitraryLane (copy), NoLanes6 (ref), NoLanes2 (ref), ReactFiberTransition (copy), NoLanes7 (ref), u28 (ref), findTransitionLane (copy), UserBlockingPriority (copy), findUpdateLane (copy), schedulerPriorityToLanePriority (copy), getCurrentUpdateLanePriority (copy), _G___DEV__ (copy), console (copy)
    local mode = p46.mode;

    if bit32.band(mode, ReactTypeOfMode.BlockingMode) == ReactTypeOfMode.NoMode then
        return SyncLane;
    end;

    if bit32.band(mode, ReactTypeOfMode.ConcurrentMode) == ReactTypeOfMode.NoMode then
        if getCurrentPriorityLevel() == ImmediatePriority then
            return SyncLane;
        end;

        return SyncBatchedLane;
    end;

    if not (ReactFeatureFlags.deferRenderPhaseUpdateToNextBatch or (bit32.band(u22, 16) == 0 or NoLanes == ReactFiberLane.NoLanes)) then
        return pickArbitraryLane(NoLanes);
    end;

    if NoLanes6 == ReactFiberLane.NoLanes then
        NoLanes6 = NoLanes2;
    end;

    if ReactFiberTransition.requestCurrentTransition() ~= ReactFiberTransition.NoTransition then
        if NoLanes7 ~= ReactFiberLane.NoLanes then
            if u28 == nil then
                NoLanes7 = ReactFiberLane.NoLanes;
            else
                NoLanes7 = u28.pendingLanes;
            end;
        end;

        return findTransitionLane(NoLanes6, NoLanes7);
    end;

    local v47 = getCurrentPriorityLevel();

    if bit32.band(u22, 4) ~= 0 and v47 == UserBlockingPriority then
        return findUpdateLane(ReactFiberLane.InputDiscreteLanePriority, NoLanes6);
    end;

    local v48 = schedulerPriorityToLanePriority(v47);

    if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        local v49 = getCurrentUpdateLanePriority();

        if v48 ~= v49 and (v49 ~= ReactFiberLane.NoLanePriority and _G___DEV__) then
            console.error("Expected current scheduler lane priority %s to match current update lane priority %s", tostring(v48), (tostring(v49)));
        end;
    end;

    return findUpdateLane(v48, NoLanes6);
end;

function requestRetryLane(p50)
    -- upvalues: ReactTypeOfMode (copy), SyncLane (copy), getCurrentPriorityLevel (copy), ImmediatePriority (copy), SyncBatchedLane (copy), NoLanes6 (ref), ReactFiberLane (copy), NoLanes2 (ref), findRetryLane (copy)
    local mode = p50.mode;

    if bit32.band(mode, ReactTypeOfMode.BlockingMode) == ReactTypeOfMode.NoMode then
        return SyncLane;
    end;

    if bit32.band(mode, ReactTypeOfMode.ConcurrentMode) == ReactTypeOfMode.NoMode then
        if getCurrentPriorityLevel() == ImmediatePriority then
            return SyncLane;
        end;

        return SyncBatchedLane;
    end;

    if NoLanes6 == ReactFiberLane.NoLanes then
        NoLanes6 = NoLanes2;
    end;

    return findRetryLane(NoLanes6);
end;

function u1.scheduleUpdateOnFiber(p51: any, p52: any, p53: number) -- Line: 615
    -- upvalues: u21 (copy), markRootUpdated (copy), u23 (ref), ReactFeatureFlags (copy), u22 (ref), NoLanes3 (ref), mergeLanes (copy), u26 (ref), NoLanes (ref), getCurrentPriorityLevel (copy), SyncLane (copy), u8 (ref), u30 (ref), now (copy), flushSyncCallbackQueue (copy), UserBlockingPriority (copy), ImmediatePriority (copy), u38 (ref), Set (copy), u28 (ref)
    u21.checkForNestedUpdates();
    local v54 = u21.markUpdateLaneFromFiberToRoot(p51, p52);

    if v54 == nil then
        return nil;
    end;

    markRootUpdated(v54, p52, p53);

    if v54 == u23 then
        u21.warnAboutRenderPhaseUpdatesInDEV(p51);

        if ReactFeatureFlags.deferRenderPhaseUpdateToNextBatch or bit32.band(u22, 16) == 0 then
            NoLanes3 = mergeLanes(NoLanes3, p52);
        end;

        if u26 == 4 then
            u21.markRootSuspended(v54, NoLanes);
        end;
    end;

    local v55 = getCurrentPriorityLevel();

    if p52 == SyncLane then
        if bit32.band(u22, 8) == 0 or bit32.band(u22, 48) ~= 0 then
            u8(v54, p53);
            u21.schedulePendingInteractions(v54, p52);

            if u22 == 0 then
                u30 = now() + 500;
                flushSyncCallbackQueue();
            end;
        else
            u21.schedulePendingInteractions(v54, p52);
            u21.performSyncWorkOnRoot(v54);
        end;
    else
        if bit32.band(u22, 4) ~= 0 and (v55 == UserBlockingPriority or v55 == ImmediatePriority) then
            if u38 == nil then
                u38 = Set.new({ v54 });
            else
                u38:add(v54);
            end;
        end;

        u8(v54, p53);
        u21.schedulePendingInteractions(v54, p52);
    end;

    u28 = v54;

    return v54;
end;

function u21.markUpdateLaneFromFiberToRoot(p56, p57) -- Line: 725
    -- upvalues: mergeLanes (copy), _G___DEV__ (copy), ReactFiberFlags (copy), u21 (copy), ReactWorkTags (copy)
    p56.lanes = mergeLanes(p56.lanes, p57);
    local alternate = p56.alternate;

    if alternate ~= nil then
        alternate.lanes = mergeLanes(alternate.lanes, p57);
    end;

    if _G___DEV__ and alternate == nil then
        local flags = p56.flags;
        local bit32_bor_ret = bit32.bor(ReactFiberFlags.Placement, ReactFiberFlags.Hydrating);

        if bit32.band(flags, bit32_bor_ret) ~= ReactFiberFlags.NoFlags then
            u21.warnAboutUpdateOnNotYetMountedFiberInDEV(p56);
        end;
    end;

    local return_ = p56.return_;
    local v58 = p56;

    while return_ ~= nil do
        return_.childLanes = mergeLanes(return_.childLanes, p57);
        local alternate2 = return_.alternate;

        if alternate2 == nil then
            if _G___DEV__ then
                local flags = return_.flags;
                local bit32_bor_ret = bit32.bor(ReactFiberFlags.Placement, ReactFiberFlags.Hydrating);

                if bit32.band(flags, bit32_bor_ret) ~= ReactFiberFlags.NoFlags then
                    u21.warnAboutUpdateOnNotYetMountedFiberInDEV(v58);
                end;
            end;
        else
            alternate2.childLanes = mergeLanes(alternate2.childLanes, p57);
        end;

        p56 = return_;
        return_ = return_.return_;
    end;

    if p56.tag == ReactWorkTags.HostRoot then
        return p56.stateNode;
    end;

    return nil;
end;

u8 = function(u59: any, p60: number) -- Line: 780
    -- upvalues: markStarvedLanesAsExpired (copy), u23 (ref), NoLanes (ref), ReactFiberLane (copy), getNextLanes (copy), returnNextLanesPriority (copy), cancelCallback (copy), scheduleSyncCallback (copy), RobloxReactProfiling (copy), u21 (copy), scheduleCallback (copy), ImmediatePriority (copy), lanePriorityToSchedulerPriority (copy)
    local callbackNode = u59.callbackNode;
    markStarvedLanesAsExpired(u59, p60);
    local v61;

    if u59 == u23 then
        v61 = NoLanes;
    else
        v61 = ReactFiberLane.NoLanes;
    end;

    local v62 = getNextLanes(u59, v61);
    local v63 = returnNextLanesPriority();

    if v62 == ReactFiberLane.NoLanes then
        if callbackNode ~= nil then
            cancelCallback(callbackNode);
            u59.callbackNode = nil;
            u59.callbackPriority = ReactFiberLane.NoLanePriority;
        end;

        return;
    end;

    if callbackNode ~= nil then
        if u59.callbackPriority == v63 then
            return;
        end;

        cancelCallback(callbackNode);
    end;

    local v64;

    if v63 == ReactFiberLane.SyncLanePriority then
        v64 = scheduleSyncCallback(function() -- Line: 825
            -- upvalues: RobloxReactProfiling (ref), u59 (copy), u21 (ref)
            local v65 = RobloxReactProfiling.profileRootBeforeUnitOfWork(u59);
            local v66 = u21.performSyncWorkOnRoot(u59);
            RobloxReactProfiling.profileRootAfterYielding(v65);

            return v66;
        end);
    elseif v63 == ReactFiberLane.SyncBatchedLanePriority then
        v64 = scheduleCallback(ImmediatePriority, function() -- Line: 833
            -- upvalues: RobloxReactProfiling (ref), u59 (copy), u21 (ref)
            local v67 = RobloxReactProfiling.profileRootBeforeUnitOfWork(u59);
            local v68 = u21.performSyncWorkOnRoot(u59);
            RobloxReactProfiling.profileRootAfterYielding(v67);

            return v68;
        end);
    else
        v64 = scheduleCallback(lanePriorityToSchedulerPriority(v63), function() -- Line: 843
            -- upvalues: RobloxReactProfiling (ref), u59 (copy), u21 (ref)
            local v69 = RobloxReactProfiling.profileRootBeforeUnitOfWork(u59);
            local v70 = u21.performConcurrentWorkOnRoot(u59);
            RobloxReactProfiling.profileRootAfterYielding(v69);

            return v70;
        end);
    end;

    u59.callbackPriority = v63;
    u59.callbackNode = v64;
end;

function u21.performConcurrentWorkOnRoot(u71) -- Line: 859
    -- upvalues: u43 (ref), NoTimestamp (copy), NoLanes6 (ref), ReactFiberLane (copy), NoLanes7 (ref), invariant (copy), u22 (ref), u1 (copy), getNextLanes (copy), u23 (ref), NoLanes (ref), u21 (copy), includesSomeLane (copy), NoLanes2 (ref), NoLanes3 (ref), ReactFiberHostConfig (copy), getLanesToRetrySynchronouslyOnError (copy), u27 (ref), u8 (ref), now (copy)
    u43 = NoTimestamp;
    NoLanes6 = ReactFiberLane.NoLanes;
    NoLanes7 = ReactFiberLane.NoLanes;
    invariant(bit32.band(u22, 48) == 0, "Should not already be working.");
    local callbackNode = u71.callbackNode;

    if u1.flushPassiveEffects() and u71.callbackNode ~= callbackNode then
        return nil;
    end;

    local v72;

    if u71 == u23 then
        v72 = NoLanes;
    else
        v72 = ReactFiberLane.NoLanes;
    end;

    local v73 = getNextLanes(u71, v72);

    if v73 == ReactFiberLane.NoLanes then
        return nil;
    end;

    local v74 = u21.renderRootConcurrent(u71, v73);

    if includesSomeLane(NoLanes2, NoLanes3) then
        u21.prepareFreshStack(u71, ReactFiberLane.NoLanes);
    elseif v74 ~= 0 then
        if v74 == 2 then
            u22 = bit32.bor(u22, 64);

            if u71.hydrate then
                u71.hydrate = false;
                ReactFiberHostConfig.clearContainer(u71.containerInfo);
            end;

            v73 = getLanesToRetrySynchronouslyOnError(u71);

            if v73 ~= ReactFiberLane.NoLanes then
                v74 = u21.renderRootSync(u71, v73);
            end;
        end;

        if v74 == 1 then
            u21.prepareFreshStack(u71, ReactFiberLane.NoLanes);
            u21.markRootSuspended(u71, v73);
            u8(u71, now());
            error(u27);
        end;

        u71.finishedWork = u71.current.alternate;
        u71.finishedLanes = v73;
        u21.finishConcurrentRender(u71, v74, v73);
    end;

    u8(u71, now());

    return u71.callbackNode == callbackNode and function() -- Line: 954
        -- upvalues: u21 (ref), u71 (copy)
        return u21.performConcurrentWorkOnRoot(u71);
    end or nil;
end;

local u75 = 0;
local u76 = false;

function shouldForceFlushFallbacksInDEV()
    -- upvalues: _G___DEV__ (copy), u75 (ref)
    return _G___DEV__ and u75 > 0;
end;

function u21.finishConcurrentRender(u77, p78, p79) -- Line: 972
    -- upvalues: invariant (copy), u21 (copy), includesOnlyRetries (copy), u29 (ref), now (copy), getNextLanes (copy), ReactFiberLane (copy), isSubsetOfLanes (copy), u1 (copy), markRootPinged (copy), ReactFiberHostConfig (copy), includesOnlyTransitions (copy), getMostRecentEventTime (copy)
    if p78 == 0 or p78 == 1 then
        invariant(false, "Root did not complete. This is a bug in React.");

        return;
    end;

    if p78 == 2 then
        u21.commitRoot(u77);

        return;
    end;

    if p78 == 3 then
        u21.markRootSuspended(u77, p79);

        if includesOnlyRetries(p79) and not shouldForceFlushFallbacksInDEV() then
            local v80 = u29 + 500 - now();

            if v80 > 10 then
                if getNextLanes(u77, ReactFiberLane.NoLanes) ~= ReactFiberLane.NoLanes then
                    return;
                end;

                local suspendedLanes = u77.suspendedLanes;

                if isSubsetOfLanes(suspendedLanes, p79) then
                    u77.timeoutHandle = ReactFiberHostConfig.scheduleTimeout(function() -- Line: 1021
                        -- upvalues: u21 (ref), u77 (copy)
                        return u21.commitRoot(u77);
                    end, v80);

                    return;
                end;

                markRootPinged(u77, suspendedLanes, (u1.requestEventTime()));

                return;
            end;
        end;

        u21.commitRoot(u77);

        return;
    end;

    if p78 ~= 4 then
        if p78 == 5 then
            u21.commitRoot(u77);

            return;
        end;

        invariant(false, "Unknown root exit status.");

        return;
    end;

    u21.markRootSuspended(u77, p79);

    if includesOnlyTransitions(p79) then
        return;
    end;

    if not shouldForceFlushFallbacksInDEV() then
        local v81 = getMostRecentEventTime(u77, p79);
        local v82 = now() - v81;
        local v83 = jnd(v82) - v82;

        if v83 > 10 then
            u77.timeoutHandle = ReactFiberHostConfig.scheduleTimeout(function() -- Line: 1056
                -- upvalues: u21 (ref), u77 (copy)
                return u21.commitRoot(u77);
            end, v83);

            return;
        end;
    end;

    u21.commitRoot(u77);
end;

function u21.markRootSuspended(p84, p85) -- Line: 1072
    -- upvalues: removeLanes (copy), NoLanes4 (ref), NoLanes3 (ref), markRootSuspended (copy)
    markRootSuspended(p84, (removeLanes(removeLanes(p85, NoLanes4), NoLanes3)));
end;

function u21.performSyncWorkOnRoot(p86) -- Line: 1084
    -- upvalues: invariant (copy), u22 (ref), u1 (copy), u23 (ref), includesSomeLane (copy), NoLanes (ref), u21 (copy), NoLanes2 (ref), NoLanes3 (ref), getNextLanes (copy), ReactFiberLane (copy), LegacyRoot (copy), ReactFiberHostConfig (copy), getLanesToRetrySynchronouslyOnError (copy), u27 (ref), u8 (ref), now (copy)
    invariant(bit32.band(u22, 48) == 0, "Should not already be working.");
    u1.flushPassiveEffects();
    local v87, v88;

    if p86 == u23 and includesSomeLane(p86.expiredLanes, NoLanes) then
        v87 = NoLanes;
        v88 = u21.renderRootSync(p86, v87);

        if includesSomeLane(NoLanes2, NoLanes3) then
            v87 = getNextLanes(p86, v87);
            v88 = u21.renderRootSync(p86, v87);
        end;
    else
        v87 = getNextLanes(p86, ReactFiberLane.NoLanes);
        v88 = u21.renderRootSync(p86, v87);
    end;

    if p86.tag ~= LegacyRoot and v88 == 2 then
        u22 = bit32.bor(u22, 64);

        if p86.hydrate then
            p86.hydrate = false;
            ReactFiberHostConfig.clearContainer(p86.containerInfo);
        end;

        v87 = getLanesToRetrySynchronouslyOnError(p86);

        if v87 ~= ReactFiberLane.NoLanes then
            v88 = u21.renderRootSync(p86, v87);
        end;
    end;

    if v88 == 1 then
        u21.prepareFreshStack(p86, ReactFiberLane.NoLanes);
        u21.markRootSuspended(p86, v87);
        u8(p86, now());
        error(u27);
    end;

    p86.finishedWork = p86.current.alternate;
    p86.finishedLanes = v87;
    u21.commitRoot(p86);
    u8(p86, now());

    return nil;
end;

function u1.flushRoot(p89, p90) -- Line: 1166
    -- upvalues: markRootExpired (copy), u8 (ref), now (copy), u22 (ref), u30 (ref), flushSyncCallbackQueue (copy)
    markRootExpired(p89, p90);
    u8(p89, now());

    if bit32.band(u22, 48) == 0 then
        u30 = now() + 500;
        flushSyncCallbackQueue();
    end;
end;

function u1.getExecutionContext() -- Line: 1178
    -- upvalues: u22 (ref)
    return u22;
end;

function u1.flushDiscreteUpdates() -- Line: 1182
    -- upvalues: u22 (ref), _G___DEV__ (copy), console (copy), u21 (copy), u1 (copy)
    if bit32.band(u22, 49) ~= 0 then
        if _G___DEV__ and bit32.band(u22, 16) ~= 0 then
            console.error("unstable_flushDiscreteUpdates: Cannot flush updates when React is already rendering.");
        end;

        return;
    end;

    u21.flushPendingDiscreteUpdates();
    u1.flushPassiveEffects();
end;

function u1.deferredUpdates(p91: function) -- Line: 1212
    -- upvalues: ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), _G___YOLO__ (copy), setCurrentUpdateLanePriority (copy), ReactFiberLane (copy), runWithPriority (copy), describeError (copy), NormalPriority (copy)
    if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        return runWithPriority(NormalPriority, p91);
    end;

    local v92 = getCurrentUpdateLanePriority();
    local v93, v94;

    if _G___YOLO__ then
        setCurrentUpdateLanePriority(ReactFiberLane.DefaultLanePriority);
        v93 = runWithPriority(NormalPriority, p91);
        v94 = true;
    else
        setCurrentUpdateLanePriority(ReactFiberLane.DefaultLanePriority);
        v94, v93 = xpcall(runWithPriority, describeError, NormalPriority, p91);
    end;

    setCurrentUpdateLanePriority(v92);

    if v94 then
        return v93;
    end;

    error(v93);
end;

function u21.flushPendingDiscreteUpdates() -- Line: 1241
    -- upvalues: u38 (ref), markDiscreteUpdatesExpired (copy), u8 (ref), now (copy), flushSyncCallbackQueue (copy)
    if u38 ~= nil then
        local v95 = u38;
        u38 = nil;
        v95:forEach(function(p96) -- Line: 1247
            -- upvalues: markDiscreteUpdatesExpired (ref), u8 (ref), now (ref)
            markDiscreteUpdatesExpired(p96);
            u8(p96, now());
        end);
    end;

    flushSyncCallbackQueue();
end;

function u1.batchedUpdates(p97: function, p98: any) -- Line: 1256
    -- upvalues: u22 (ref), _G___YOLO__ (copy), describeError (copy), u30 (ref), now (copy), flushSyncCallbackQueue (copy)
    local v99 = u22;
    u22 = bit32.bor(u22, 1);
    local v100, v101;

    if _G___YOLO__ then
        v100 = p97(p98);
        v101 = true;
    else
        v101, v100 = xpcall(p97, describeError, p98);
    end;

    u22 = v99;

    if u22 == 0 then
        u30 = now() + 500;
        flushSyncCallbackQueue();
    end;

    if v101 then
        return v100;
    end;

    error(v100);
end;

function u1.batchedEventUpdates(p102: function, p103: any) -- Line: 1284
    -- upvalues: u22 (ref), _G___YOLO__ (copy), describeError (copy), u30 (ref), now (copy), flushSyncCallbackQueue (copy)
    local v104 = u22;
    u22 = bit32.bor(u22, 2);
    local v105, v106;

    if _G___YOLO__ then
        v105 = p102(p103);
        v106 = true;
    else
        v106, v105 = xpcall(p102, describeError, p103);
    end;

    u22 = v104;

    if u22 == 0 then
        u30 = now() + 500;
        flushSyncCallbackQueue();
    end;

    if v106 then
        return v105;
    end;

    error(v105);
end;

function u1.discreteUpdates(u107: function, u108: any, u109: any, u110: any, u111: any) -- Line: 1313
    -- upvalues: u22 (ref), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), ReactFiberLane (copy), runWithPriority (copy), describeError (copy), UserBlockingPriority (copy), u30 (ref), now (copy), flushSyncCallbackQueue (copy)
    local v112 = u22;
    u22 = bit32.bor(u22, 4);

    if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        local v113, v114 = xpcall(runWithPriority, describeError, UserBlockingPriority, function() -- Line: 1349
            -- upvalues: u107 (copy), u108 (copy), u109 (copy), u110 (copy), u111 (copy)
            return u107(u108, u109, u110, u111);
        end);
        u22 = v112;

        if u22 == 0 then
            u30 = now() + 500;
            flushSyncCallbackQueue();
        end;

        if v113 then
            return v114;
        end;

        error(v114);

        return;
    end;

    local v115 = getCurrentUpdateLanePriority();
    setCurrentUpdateLanePriority(ReactFiberLane.InputDiscreteLanePriority);
    local v116, v117 = xpcall(runWithPriority, describeError, UserBlockingPriority, function() -- Line: 1325
        -- upvalues: u107 (copy), u108 (copy), u109 (copy), u110 (copy), u111 (copy)
        return u107(u108, u109, u110, u111);
    end);
    setCurrentUpdateLanePriority(v115);
    u22 = v112;

    if u22 == 0 then
        u30 = now() + 500;
        flushSyncCallbackQueue();
    end;

    if v116 then
        return v117;
    end;

    error(v117);
end;

function u1.unbatchedUpdates(p118: function, p119: any) -- Line: 1370
    -- upvalues: u22 (ref), _G___YOLO__ (copy), describeError (copy), u30 (ref), now (copy), flushSyncCallbackQueue (copy)
    local v120 = u22;
    u22 = bit32.band(u22, 4294967294);
    u22 = bit32.bor(u22, 8);
    local v121, v122;

    if _G___YOLO__ then
        v121 = p118(p119);
        v122 = true;
    else
        v122, v121 = xpcall(p118, describeError, p119);
    end;

    u22 = v120;

    if u22 == 0 then
        u30 = now() + 500;
        flushSyncCallbackQueue();
    end;

    if v122 then
        return v121;
    end;

    error(v121);
end;

function u1.flushSync(u123: function, u124: any) -- Line: 1398
    -- upvalues: u22 (ref), _G___DEV__ (copy), console (copy), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), ReactFiberLane (copy), _G___YOLO__ (copy), runWithPriority (copy), describeError (copy), ImmediatePriority (copy), flushSyncCallbackQueue (copy)
    local v125 = u22;

    if bit32.band(v125, 48) ~= 0 then
        if _G___DEV__ then
            console.error("flushSync was called from inside a lifecycle method. React cannot flush when React is already rendering. Consider moving this call to a scheduler task or micro task.");
        end;

        return u123(u124);
    end;

    u22 = bit32.bor(u22, 1);

    if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        local v126, v127;

        if _G___YOLO__ then
            v126 = true;

            if u123 then
                v127 = runWithPriority(ImmediatePriority, function() -- Line: 1483
                    -- upvalues: u123 (copy), u124 (copy)
                    return u123(u124);
                end);
            else
                v127 = nil;
            end;
        elseif u123 then
            v126, v127 = xpcall(runWithPriority, describeError, ImmediatePriority, function() -- Line: 1471
                -- upvalues: u123 (copy), u124 (copy)
                return u123(u124);
            end);
        else
            v126 = true;
            v127 = nil;
        end;

        u22 = v125;
        flushSyncCallbackQueue();

        if not v126 then
            error(v127);
        end;

        return v127;
    end;

    local v128 = getCurrentUpdateLanePriority();
    setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority);
    local v129, v130;

    if _G___YOLO__ then
        v129 = true;
        setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority);

        if u123 then
            v130 = runWithPriority(ImmediatePriority, function() -- Line: 1441
                -- upvalues: u123 (copy), u124 (copy)
                return u123(u124);
            end);
        else
            v130 = nil;
        end;
    elseif u123 then
        v129, v130 = xpcall(runWithPriority, describeError, ImmediatePriority, function() -- Line: 1428
            -- upvalues: u123 (copy), u124 (copy)
            return u123(u124);
        end);
    else
        v129 = true;
        v130 = nil;
    end;

    setCurrentUpdateLanePriority(v128);
    u22 = v125;
    flushSyncCallbackQueue();

    if not v129 then
        error(v130);
    end;

    return v130;
end;

function u1.flushControlled(p131: function) -- Line: 1504
    -- upvalues: u22 (ref), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), ReactFiberLane (copy), runWithPriority (copy), describeError (copy), ImmediatePriority (copy), u30 (ref), now (copy), flushSyncCallbackQueue (copy)
    local v132 = u22;
    u22 = bit32.bor(u22, 1);

    if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        local v133 = getCurrentUpdateLanePriority();
        setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority);
        local v134, v135 = xpcall(runWithPriority, describeError, ImmediatePriority, p131);
        setCurrentUpdateLanePriority(v133);
        u22 = v132;

        if u22 == 0 then
            u30 = now() + 500;
            flushSyncCallbackQueue();
        end;

        if not v134 then
            error(v135);
        end;
    else
        local v136, v137 = xpcall(runWithPriority, describeError, ImmediatePriority, p131);
        u22 = v132;

        if u22 == 0 then
            u30 = now() + 500;
            flushSyncCallbackQueue();
        end;

        if not v136 then
            error(v137);
        end;
    end;
end;

function u1.pushRenderLanes(p138, p139) -- Line: 1544
    -- upvalues: push (copy), u25 (copy), u1 (copy), mergeLanes (copy), NoLanes2 (ref)
    push(u25, u1.subtreeRenderLanes, p138);
    u1.subtreeRenderLanes = mergeLanes(u1.subtreeRenderLanes, p139);
    NoLanes2 = mergeLanes(NoLanes2, p139);
end;

function u1.popRenderLanes(p140) -- Line: 1550
    -- upvalues: u1 (copy), u25 (copy), pop (copy)
    u1.subtreeRenderLanes = u25.current;
    pop(u25, p140);
end;

function u21.prepareFreshStack(p141, p142) -- Line: 1555
    -- upvalues: ReactFiberLane (copy), ReactFiberHostConfig (copy), u24 (ref), unwindInterruptedWork (copy), u23 (ref), u4 (copy), NoLanes (ref), u1 (copy), NoLanes2 (ref), u26 (ref), u27 (ref), workInProgressRootSkippedLanes (copy), NoLanes3 (ref), NoLanes4 (ref), ReactFeatureFlags (copy), u42 (ref), _G___DEV__ (copy), u19 (copy)
    p141.finishedWork = nil;
    p141.finishedLanes = ReactFiberLane.NoLanes;
    local timeoutHandle = p141.timeoutHandle;

    if timeoutHandle ~= ReactFiberHostConfig.noTimeout then
        p141.timeoutHandle = ReactFiberHostConfig.noTimeout;
        ReactFiberHostConfig.cancelTimeout(timeoutHandle);
    end;

    if u24 ~= nil then
        local return_ = u24.return_;

        while return_ ~= nil do
            unwindInterruptedWork(return_);
            return_ = return_.return_;
        end;
    end;

    u23 = p141;
    u24 = u4.createWorkInProgress(p141.current, nil);
    NoLanes = p142;
    u1.subtreeRenderLanes = p142;
    NoLanes2 = p142;
    u26 = 0;
    u27 = nil;
    workInProgressRootSkippedLanes(ReactFiberLane.NoLanes);
    NoLanes3 = ReactFiberLane.NoLanes;
    NoLanes4 = ReactFiberLane.NoLanes;

    if ReactFeatureFlags.enableSchedulerTracing then
        u42 = nil;
    end;

    if _G___DEV__ then
        u19.discardPendingWarnings();
    end;
end;

function u21.handleError(u143, u144) -- Line: 1595
    -- upvalues: u24 (ref), resetContextDependencies (copy), u9 (copy), u17 (ref), resetCurrentFiber (copy), ReactCurrentOwner (copy), u26 (ref), u27 (ref), ReactFeatureFlags (copy), ReactTypeOfMode (copy), u18 (copy), throwException (copy), NoLanes (ref), u1 (copy), u21 (copy)
    while true do
        local u145 = u24;
        local success, result = pcall(function() -- Line: 1599
            -- upvalues: resetContextDependencies (ref), u9 (ref), u17 (ref), resetCurrentFiber (ref), ReactCurrentOwner (ref), u145 (ref), u26 (ref), u27 (ref), u144 (ref), u24 (ref), ReactFeatureFlags (ref), ReactTypeOfMode (ref), u18 (ref), throwException (ref), u143 (copy), NoLanes (ref), u1 (ref), u21 (ref)
            resetContextDependencies();

            if not u9.resetHooksAfterThrowRef then
                u17 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
                u9.resetHooksAfterThrowRef = u17.resetHooksAfterThrow;
                u9.ContextOnlyDispatcherRef = u17.ContextOnlyDispatcher;
                u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = u17.getIsUpdatingOpaqueValueInRenderPhaseInDEV;
            end;

            u9.resetHooksAfterThrowRef();
            resetCurrentFiber();
            ReactCurrentOwner.current = nil;

            if u145 == nil or u145.return_ == nil then
                u26 = 1;
                u27 = u144;
                u24 = nil;

                return;
            end;

            if ReactFeatureFlags.enableProfilerTimer and bit32.band(u145.mode, ReactTypeOfMode.ProfileMode) ~= 0 then
                u18.stopProfilerTimerIfRunningAndRecordDelta(u145, true);
            end;

            throwException(u143, u145.return_, u145, u144, NoLanes, u1.onUncaughtError, u1.renderDidError);
            u21.completeUnitOfWork(u145);
        end);

        if success then
            break;
        end;

        u144 = result;

        if u24 == u145 and u145 ~= nil then
            u145 = u145.return_;
            u24 = u145;
        else
            u145 = u24;
        end;
    end;
end;

function u21.pushDispatcher() -- Line: 1674
    -- upvalues: ReactCurrentDispatcher (copy), u9 (copy), u17 (ref)
    local current2 = ReactCurrentDispatcher.current;

    if not u9.ContextOnlyDispatcherRef then
        u17 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
        u9.resetHooksAfterThrowRef = u17.resetHooksAfterThrow;
        u9.ContextOnlyDispatcherRef = u17.ContextOnlyDispatcher;
        u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = u17.getIsUpdatingOpaqueValueInRenderPhaseInDEV;
    end;

    ReactCurrentDispatcher.current = u9.ContextOnlyDispatcherRef;

    if current2 ~= nil then
        return current2;
    end;

    if not u9.ContextOnlyDispatcherRef then
        u17 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
        u9.resetHooksAfterThrowRef = u17.resetHooksAfterThrow;
        u9.ContextOnlyDispatcherRef = u17.ContextOnlyDispatcher;
        u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = u17.getIsUpdatingOpaqueValueInRenderPhaseInDEV;
    end;

    return u9.ContextOnlyDispatcherRef;
end;

function u21.popDispatcher(p146) -- Line: 1691
    -- upvalues: ReactCurrentDispatcher (copy)
    ReactCurrentDispatcher.current = p146;
end;

function u21.pushInteractions(p147) -- Line: 1695
    -- upvalues: ReactFeatureFlags (copy), __interactionsRef (copy)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return nil;
    end;

    local current2 = __interactionsRef.current;
    __interactionsRef.current = p147.memoizedInteractions;

    return current2;
end;

function u21.popInteractions(p148) -- Line: 1704
    -- upvalues: ReactFeatureFlags (copy), __interactionsRef (copy)
    if ReactFeatureFlags.enableSchedulerTracing then
        __interactionsRef.current = p148;
    end;
end;

function u1.markCommitTimeOfFallback() -- Line: 1710
    -- upvalues: u29 (ref), now (copy)
    u29 = now();
end;

function u1.markSkippedUpdateLanes(p149) -- Line: 1714
    -- upvalues: ReactFiberWorkInProgress (copy)
    ReactFiberWorkInProgress.markSkippedUpdateLanes(p149);
end;

function u1.renderDidSuspend() -- Line: 1718
    -- upvalues: u26 (ref)
    if u26 == 0 then
        u26 = 3;
    end;
end;

function u1.renderDidSuspendDelayIfPossible() -- Line: 1724
    -- upvalues: u26 (ref), u23 (ref), includesNonIdleWork (copy), workInProgressRootSkippedLanes (copy), NoLanes3 (ref), u21 (copy), NoLanes (ref)
    if u26 == 0 or u26 == 3 then
        u26 = 4;
    end;

    if u23 ~= nil and (includesNonIdleWork(workInProgressRootSkippedLanes()) or includesNonIdleWork(NoLanes3)) then
        u21.markRootSuspended(u23, NoLanes);
    end;
end;

function u1.renderDidError() -- Line: 1752
    -- upvalues: u26 (ref)
    if u26 ~= 5 then
        u26 = 2;
    end;
end;

function u1.renderHasNotSuspendedYet() -- Line: 1760
    -- upvalues: u26 (ref)
    return u26 == 0;
end;

function u21.renderRootSync(p150, p151) -- Line: 1766
    -- upvalues: u22 (ref), u21 (copy), u23 (ref), NoLanes (ref), _G___DEV__ (copy), enableDebugTracing (copy), DebugTracing (copy), enableSchedulingProfiler (copy), SchedulingProfiler (copy), _G___YOLO__ (copy), describeError (copy), resetContextDependencies (copy), ReactFeatureFlags (copy), u24 (ref), invariant (copy), ReactFiberLane (copy), u26 (ref)
    local v152 = u22;
    u22 = bit32.bor(u22, 16);
    local v153 = u21.pushDispatcher();

    if u23 ~= p150 or NoLanes ~= p151 then
        u21.prepareFreshStack(p150, p151);
        u21.startWorkOnPendingInteractions(p150, p151);
    end;

    local v154 = u21.pushInteractions(p150);

    if _G___DEV__ and enableDebugTracing then
        DebugTracing.logRenderStarted(p151);
    end;

    if enableSchedulingProfiler then
        SchedulingProfiler.markRenderStarted(p151);
    end;

    while true do
        local v155 = nil;
        local v156;

        if _G___YOLO__ then
            u21.workLoopSync();
            v156 = true;
        else
            v156, v155 = xpcall(u21.workLoopSync, describeError);
        end;

        if v156 then
            resetContextDependencies();

            if ReactFeatureFlags.enableSchedulerTracing then
                u21.popInteractions(v154);
            end;

            u22 = v152;
            u21.popDispatcher(v153);

            if u24 ~= nil then
                invariant(
                    false,
                    "Cannot commit an incomplete root. This error is likely caused by a bug in React. Please file an issue."
                );
            end;

            if _G___DEV__ and enableDebugTracing then
                DebugTracing.logRenderStopped();
            end;

            if enableSchedulingProfiler then
                SchedulingProfiler.markRenderStopped();
            end;

            u23 = nil;
            NoLanes = ReactFiberLane.NoLanes;

            return u26;
        end;

        u21.handleError(p150, v155);
    end;
end;

function u21.workLoopSync() -- Line: 1842
    -- upvalues: u24 (ref), u21 (copy)
    while u24 ~= nil do
        u21.performUnitOfWork(u24);
    end;
end;

function u21.renderRootConcurrent(p157, p158) -- Line: 1849
    -- upvalues: u22 (ref), u21 (copy), u23 (ref), NoLanes (ref), u30 (ref), now (copy), _G___DEV__ (copy), enableDebugTracing (copy), DebugTracing (copy), enableSchedulingProfiler (copy), SchedulingProfiler (copy), _G___YOLO__ (copy), describeError (copy), resetContextDependencies (copy), ReactFeatureFlags (copy), u24 (ref), ReactFiberLane (copy), u26 (ref)
    local v159 = u22;
    u22 = bit32.bor(u22, 16);
    local v160 = u21.pushDispatcher();

    if u23 ~= p157 or NoLanes ~= p158 then
        u30 = now() + 500;
        u21.prepareFreshStack(p157, p158);
        u21.startWorkOnPendingInteractions(p157, p158);
    end;

    local v161 = u21.pushInteractions(p157);

    if _G___DEV__ and enableDebugTracing then
        DebugTracing.logRenderStarted(p158);
    end;

    if enableSchedulingProfiler then
        SchedulingProfiler.markRenderStarted(p158);
    end;

    while true do
        local v162, v163;

        if _G___YOLO__ then
            u21.workLoopConcurrent();
            v162 = "break";
            v163 = true;
        else
            v163, v162 = xpcall(u21.workLoopConcurrent, describeError);

            if v163 then
                v162 = "break";
            end;
        end;

        if v162 == "break" then
            resetContextDependencies();

            if ReactFeatureFlags.enableSchedulerTracing then
                u21.popInteractions(v161);
            end;

            u21.popDispatcher(v160);
            u22 = v159;

            if _G___DEV__ and enableDebugTracing then
                DebugTracing.logRenderStopped();
            end;

            if u24 ~= nil then
                if enableSchedulingProfiler then
                    SchedulingProfiler.markRenderYielded();
                end;

                return 0;
            end;

            if enableSchedulingProfiler then
                SchedulingProfiler.markRenderStopped();
            end;

            u23 = nil;
            NoLanes = ReactFiberLane.NoLanes;

            return u26;
        end;

        if not v163 then
            u21.handleError(p157, v162);
        end;
    end;
end;

function u21.workLoopConcurrent() -- Line: 1933
    -- upvalues: u24 (ref), shouldYield (copy), u21 (copy)
    while u24 ~= nil and not shouldYield() do
        u21.performUnitOfWork(u24);
    end;
end;

function u21.performUnitOfWork(p164) -- Line: 1940
    -- upvalues: RobloxReactProfiling (copy), setCurrentFiber (copy), ReactFeatureFlags (copy), ReactTypeOfMode (copy), u18 (copy), u21 (copy), u1 (copy), resetCurrentFiber (copy), u24 (ref), ReactCurrentOwner (copy)
    local v165 = RobloxReactProfiling.profileUnitOfWorkBefore(p164);
    local alternate = p164.alternate;
    setCurrentFiber(p164);
    local v166;

    if ReactFeatureFlags.enableProfilerTimer and bit32.band(p164.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
        u18.startProfilerTimer(p164);
        v166 = u21.beginWork(alternate, p164, u1.subtreeRenderLanes);
        u18.stopProfilerTimerIfRunningAndRecordDelta(p164, true);
    else
        v166 = u21.beginWork(alternate, p164, u1.subtreeRenderLanes);
    end;

    resetCurrentFiber();
    p164.memoizedProps = p164.pendingProps;

    if v166 == nil then
        u21.completeUnitOfWork(p164);
    else
        u24 = v166;
    end;

    ReactCurrentOwner.current = nil;
    RobloxReactProfiling.profileUnitOfWorkAfter(v165);
end;

function u21.completeUnitOfWork(p167) -- Line: 1978
    -- upvalues: ReactFiberFlags (copy), setCurrentFiber (copy), ReactFeatureFlags (copy), ReactTypeOfMode (copy), u1 (copy), u9 (copy), u18 (copy), resetCurrentFiber (copy), u24 (ref), unwindWork (copy), u26 (ref)
    while true do
        local alternate = p167.alternate;
        local return_ = p167.return_;

        if bit32.band(p167.flags, ReactFiberFlags.Incomplete) == ReactFiberFlags.NoFlags then
            setCurrentFiber(p167);
            local v168;

            if ReactFeatureFlags.enableProfilerTimer and bit32.band(p167.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
                u18.startProfilerTimer(p167);
                local subtreeRenderLanes = u1.subtreeRenderLanes;

                if not u9.completeWorkRef then
                    u9.completeWorkRef = require(script.Parent:WaitForChild("ReactFiberCompleteWork.new")).completeWork;
                end;

                v168 = u9.completeWorkRef(alternate, p167, subtreeRenderLanes);
                u18.stopProfilerTimerIfRunningAndRecordDelta(p167, false);
            else
                local subtreeRenderLanes = u1.subtreeRenderLanes;

                if not u9.completeWorkRef then
                    u9.completeWorkRef = require(script.Parent:WaitForChild("ReactFiberCompleteWork.new")).completeWork;
                end;

                v168 = u9.completeWorkRef(alternate, p167, subtreeRenderLanes);
            end;

            resetCurrentFiber();

            if v168 ~= nil then
                u24 = v168;

                return;
            end;
        else
            local v169 = unwindWork(p167, u1.subtreeRenderLanes);

            if v169 ~= nil then
                v169.flags = bit32.band(v169.flags, ReactFiberFlags.HostEffectMask);
                u24 = v169;

                return;
            end;

            if ReactFeatureFlags.enableProfilerTimer and bit32.band(p167.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
                u18.stopProfilerTimerIfRunningAndRecordDelta(p167, false);
                local v170 = p167.actualDuration or 0;
                local child = p167.child;

                while child ~= nil do
                    v170 = v170 + (child.actualDuration or 0);
                    child = child.sibling;
                end;

                p167.actualDuration = v170;
            end;

            if return_ ~= nil then
                return_.flags = bit32.bor(return_.flags, ReactFiberFlags.Incomplete);
                return_.subtreeFlags = ReactFiberFlags.NoFlags;
                return_.deletions = nil;
            end;
        end;

        local sibling = p167.sibling;

        if sibling ~= nil then
            u24 = sibling;

            return;
        end;

        u24 = return_;

        if return_ == nil then
            if u26 == 0 then
                u26 = 5;
            end;

            return;
        end;

        p167 = return_;
    end;
end;

function u21.commitRoot(u171) -- Line: 2086
    -- upvalues: getCurrentPriorityLevel (copy), runWithPriority (copy), ImmediatePriority (copy), RobloxReactProfiling (copy), u21 (copy)
    local u172 = getCurrentPriorityLevel();
    runWithPriority(ImmediatePriority, function() -- Line: 2088
        -- upvalues: RobloxReactProfiling (ref), u21 (ref), u171 (copy), u172 (copy)
        RobloxReactProfiling.profileCommitBefore();
        local v173 = u21.commitRootImpl(u171, u172);
        RobloxReactProfiling.profileCommitAfter();

        return v173;
    end);

    return nil;
end;

function u21.commitRootImpl(p174, p175) -- Line: 2099
    -- upvalues: u1 (copy), u36 (ref), invariant (copy), u22 (ref), _G___DEV__ (copy), enableDebugTracing (copy), DebugTracing (copy), enableSchedulingProfiler (copy), SchedulingProfiler (copy), ReactFiberLane (copy), mergeLanes (copy), markRootFinished (copy), u38 (ref), hasDiscreteLanes (copy), u23 (ref), u24 (ref), NoLanes (ref), ReactFiberFlags (copy), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), u21 (copy), ReactCurrentOwner (copy), u44 (ref), ReactFiberHostConfig (copy), u45 (ref), u18 (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), recursivelyCommitLayoutEffects (copy), hasCaughtError (copy), clearCaughtError (copy), u20 (ref), resetCurrentFiber (copy), _G___YOLO__ (copy), describeError (copy), u35 (ref), scheduleCallback (copy), NormalPriority (copy), requestPaint (copy), NoLanes5 (ref), u37 (ref), u42 (ref), u34 (ref), enableDoubleInvokingEffects (copy), SyncLane (copy), u40 (ref), u39 (ref), onCommitRoot (copy), onCommitRoot2 (copy), u8 (ref), now (copy), u32 (ref), u33 (ref), flushSyncCallbackQueue (copy)
    repeat
        u1.flushPassiveEffects();
    until u36 == nil;

    flushRenderPhaseStrictModeWarningsInDEV();
    invariant(bit32.band(u22, 48) == 0, "Should not already be working.");
    local finishedWork = p174.finishedWork;
    local finishedLanes = p174.finishedLanes;

    if _G___DEV__ and enableDebugTracing then
        DebugTracing.logCommitStarted(finishedLanes);
    end;

    if enableSchedulingProfiler then
        SchedulingProfiler.markCommitStarted(finishedLanes);
    end;

    if finishedWork == nil then
        if _G___DEV__ and enableDebugTracing then
            DebugTracing.logCommitStopped();
        end;

        if enableSchedulingProfiler then
            SchedulingProfiler.markCommitStopped();
        end;

        return nil;
    end;

    p174.finishedWork = nil;
    p174.finishedLanes = ReactFiberLane.NoLanes;
    invariant(finishedWork ~= p174.current, "Cannot commit the same tree as before. This error is likely caused by a bug in React. Please file an issue.");
    p174.callbackNode = nil;
    local v176 = mergeLanes(finishedWork.lanes, finishedWork.childLanes);
    markRootFinished(p174, v176);

    if u38 ~= nil and (not hasDiscreteLanes(v176) and u38:has(p174)) then
        u38:delete(p174);
    end;

    if p174 == u23 then
        u23 = nil;
        u24 = nil;
        NoLanes = ReactFiberLane.NoLanes;
    end;

    local subtreeFlags = finishedWork.subtreeFlags;
    local bit32_bor_ret = bit32.bor(ReactFiberFlags.BeforeMutationMask, ReactFiberFlags.MutationMask, ReactFiberFlags.LayoutMask, ReactFiberFlags.PassiveMask);
    local v177 = bit32.band(subtreeFlags, bit32_bor_ret) ~= ReactFiberFlags.NoFlags;
    local flags = finishedWork.flags;
    local bit32_bor_ret2 = bit32.bor(ReactFiberFlags.BeforeMutationMask, ReactFiberFlags.MutationMask, ReactFiberFlags.LayoutMask, ReactFiberFlags.PassiveMask);

    if v177 or bit32.band(flags, bit32_bor_ret2) ~= ReactFiberFlags.NoFlags then
        local v178;

        if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
            v178 = getCurrentUpdateLanePriority();
            setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority);
        else
            v178 = nil;
        end;

        local v179 = u22;
        u22 = bit32.bor(u22, 32);
        local v180 = u21.pushInteractions(p174);
        ReactCurrentOwner.current = nil;
        u44 = ReactFiberHostConfig.prepareForCommit(p174.containerInfo);
        u45 = false;
        u21.commitBeforeMutationEffects(finishedWork);
        u44 = nil;

        if ReactFeatureFlags.enableProfilerTimer then
            u18.recordCommitTime();
        end;

        u21.commitMutationEffects(finishedWork, p174, p175);

        if u45 then
            ReactFiberHostConfig.afterActiveInstanceBlur();
        end;

        ReactFiberHostConfig.resetAfterCommit(p174.containerInfo);
        p174.current = finishedWork;

        if _G___DEV__ and enableDebugTracing then
            DebugTracing.logLayoutEffectsStarted(finishedLanes);
        end;

        if enableSchedulingProfiler then
            SchedulingProfiler.markLayoutEffectsStarted(finishedLanes);
        end;

        if _G___DEV__ then
            setCurrentFiber(finishedWork);
            invokeGuardedCallback(nil, recursivelyCommitLayoutEffects, nil, finishedWork, p174, u1.captureCommitPhaseError, u1.schedulePassiveEffectCallback);

            if hasCaughtError() then
                u20(finishedWork, finishedWork, (clearCaughtError()));
            end;

            resetCurrentFiber();
        else
            local v181 = nil;
            local v182;

            if _G___YOLO__ then
                recursivelyCommitLayoutEffects(finishedWork, p174, u1.captureCommitPhaseError, u1.schedulePassiveEffectCallback);
                v182 = true;
            else
                v182, v181 = xpcall(recursivelyCommitLayoutEffects, describeError, finishedWork, p174, u1.captureCommitPhaseError, u1.schedulePassiveEffectCallback);
            end;

            if not v182 then
                u20(finishedWork, finishedWork, v181);
            end;
        end;

        if _G___DEV__ and enableDebugTracing then
            DebugTracing.logLayoutEffectsStopped();
        end;

        if enableSchedulingProfiler then
            SchedulingProfiler.markLayoutEffectsStopped();
        end;

        if not (bit32.band(finishedWork.subtreeFlags, ReactFiberFlags.PassiveMask) == ReactFiberFlags.NoFlags and bit32.band(finishedWork.flags, ReactFiberFlags.PassiveMask) == ReactFiberFlags.NoFlags or u35) then
            u35 = true;
            scheduleCallback(NormalPriority, function() -- Line: 2332
                -- upvalues: u1 (ref)
                u1.flushPassiveEffects();

                return nil;
            end);
        end;

        requestPaint();

        if ReactFeatureFlags.enableSchedulerTracing then
            u21.popInteractions(v180);
        end;

        u22 = v179;

        if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler and v178 ~= nil then
            setCurrentUpdateLanePriority(v178);
        end;
    else
        p174.current = finishedWork;

        if ReactFeatureFlags.enableProfilerTimer then
            u18.recordCommitTime();
        end;
    end;

    local v183 = u35;

    if u35 then
        u35 = false;
        u36 = p174;
        NoLanes5 = finishedLanes;
        u37 = p175;
    end;

    local pendingLanes = p174.pendingLanes;

    if pendingLanes == ReactFiberLane.NoLanes then
        u34 = nil;
    elseif ReactFeatureFlags.enableSchedulerTracing then
        if u42 ~= nil then
            local v184 = u42;
            u42 = nil;

            for i = 1, #v184 do
                scheduleInteractions(p174, v184[i], p174.memoizedInteractions);
                local _ = i;
            end;
        end;

        u21.schedulePendingInteractions(p174, pendingLanes);
    end;

    if _G___DEV__ and (enableDoubleInvokingEffects and not v183) then
        commitDoubleInvokeEffectsInDEV(p174.current, false);
    end;

    if ReactFeatureFlags.enableSchedulerTracing and not v183 then
        u21.finishPendingInteractions(p174, finishedLanes);
    end;

    if pendingLanes == SyncLane then
        if p174 == u40 then
            u39 = u39 + 1;
        else
            u39 = 0;
            u40 = p174;
        end;
    else
        u39 = 0;
    end;

    onCommitRoot(finishedWork.stateNode, p175);

    if _G___DEV__ then
        onCommitRoot2();
    end;

    u8(p174, now());

    if u32 then
        u32 = false;
        local v185 = u33;
        u33 = nil;
        error(v185);
    end;

    if bit32.band(u22, 8) ~= 0 then
        if _G___DEV__ and enableDebugTracing then
            DebugTracing.logCommitStopped();
        end;

        if enableSchedulingProfiler then
            SchedulingProfiler.markCommitStopped();
        end;

        return nil;
    end;

    flushSyncCallbackQueue();

    if _G___DEV__ and enableDebugTracing then
        DebugTracing.logCommitStopped();
    end;

    if enableSchedulingProfiler then
        SchedulingProfiler.markCommitStopped();
    end;

    return nil;
end;

function u21.commitBeforeMutationEffects(p186) -- Line: 2483
    -- upvalues: u21 (copy), ReactFiberFlags (copy), _G___DEV__ (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), hasCaughtError (copy), clearCaughtError (copy), u1 (copy), resetCurrentFiber (copy), _G___YOLO__ (copy), describeError (copy)
    while p186 ~= nil do
        if p186.deletions ~= nil then
            u21.commitBeforeMutationEffectsDeletions(p186.deletions);
        end;

        if p186.child ~= nil and bit32.band(p186.subtreeFlags, ReactFiberFlags.BeforeMutationMask) ~= ReactFiberFlags.NoFlags then
            u21.commitBeforeMutationEffects(p186.child);
        end;

        if _G___DEV__ then
            setCurrentFiber(p186);
            invokeGuardedCallback(nil, u21.commitBeforeMutationEffectsImpl, nil, p186);

            if hasCaughtError() then
                local v187 = clearCaughtError();
                u1.captureCommitPhaseError(p186, p186.return_, v187);
            end;

            resetCurrentFiber();
        else
            local v188 = nil;
            local v189;

            if _G___YOLO__ then
                u21.commitBeforeMutationEffectsImpl(p186);
                v189 = true;
            else
                v189, v188 = xpcall(u21.commitBeforeMutationEffectsImpl, describeError, p186);
            end;

            if not v189 then
                u1.captureCommitPhaseError(p186, p186.return_, v188);
            end;
        end;

        p186 = p186.sibling;
    end;
end;

function u21.commitBeforeMutationEffectsImpl(p190) -- Line: 2526
    -- upvalues: u45 (ref), u44 (ref), ReactWorkTags (copy), u7 (copy), doesFiberContain (copy), ReactFiberHostConfig (copy), ReactFiberFlags (copy), setCurrentFiber (copy), commitBeforeMutationLifeCycles (copy), resetCurrentFiber (copy), u35 (ref), scheduleCallback (copy), NormalPriority (copy), u1 (copy)
    local alternate = p190.alternate;
    local flags = p190.flags;

    if not (u45 or (u44 == nil or (p190.tag ~= ReactWorkTags.SuspenseComponent or not (u7.isSuspenseBoundaryBeingHidden(alternate, p190) and doesFiberContain(p190, u44))))) then
        u45 = true;
        ReactFiberHostConfig.beforeActiveInstanceBlur();
    end;

    if bit32.band(flags, ReactFiberFlags.Snapshot) ~= ReactFiberFlags.NoFlags then
        setCurrentFiber(p190);
        commitBeforeMutationLifeCycles(alternate, p190);
        resetCurrentFiber();
    end;

    if bit32.band(flags, ReactFiberFlags.Passive) ~= ReactFiberFlags.NoFlags and not u35 then
        u35 = true;
        scheduleCallback(NormalPriority, function() -- Line: 2554
            -- upvalues: u1 (ref)
            u1.flushPassiveEffects();

            return nil;
        end);
    end;
end;

function u21.commitBeforeMutationEffectsDeletions(p191) -- Line: 2562
    -- upvalues: doesFiberContain (copy), u44 (ref), u45 (ref), ReactFiberHostConfig (copy)
    for i = 1, #p191 do
        local v192;

        if doesFiberContain(p191[i], u44) then
            u45 = true;
            ReactFiberHostConfig.beforeActiveInstanceBlur();
            v192 = i;
        else
            v192 = i;
        end;
    end;
end;

function u21.commitMutationEffects(p193, p194, p195) -- Line: 2578
    -- upvalues: commitDeletion (copy), describeError (copy), u1 (copy), ReactFiberFlags (copy), u21 (copy), _G___DEV__ (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), hasCaughtError (copy), clearCaughtError (copy), resetCurrentFiber (copy), _G___YOLO__ (copy)
    while p193 ~= nil do
        local deletions = p193.deletions;

        if deletions ~= nil then
            for _, v in deletions do
                local v196, v197 = xpcall(commitDeletion, describeError, p194, v, p193, p195);

                if not v196 then
                    u1.captureCommitPhaseError(v, p193, v197);
                end;
            end;
        end;

        if p193.child ~= nil and bit32.band(p193.subtreeFlags, ReactFiberFlags.MutationMask) ~= ReactFiberFlags.NoFlags then
            u21.commitMutationEffects(p193.child, p194, p195);
        end;

        if _G___DEV__ then
            setCurrentFiber(p193);
            invokeGuardedCallback(nil, u21.commitMutationEffectsImpl, nil, p193, p194, p195);

            if hasCaughtError() then
                local v198 = clearCaughtError();
                u1.captureCommitPhaseError(p193, p193.return_, v198);
            end;

            resetCurrentFiber();
        else
            local v199 = nil;
            local v200;

            if _G___YOLO__ then
                u21.commitMutationEffectsImpl(p193, p194, p195);
                v200 = true;
            else
                v200, v199 = xpcall(u21.commitMutationEffectsImpl, describeError, p193, p194, p195);
            end;

            if not v200 then
                u1.captureCommitPhaseError(p193, p193.return_, v199);
            end;
        end;

        p193 = p193.sibling;
    end;
end;

function u21.commitMutationEffectsImpl(p201, p202, p203) -- Line: 2648
    -- upvalues: ReactFiberFlags (copy), commitDetachRef (copy), commitPlacement (copy), commitWork (copy)
    local flags = p201.flags;

    if bit32.band(flags, ReactFiberFlags.Ref) ~= 0 then
        local alternate = p201.alternate;

        if alternate ~= nil then
            commitDetachRef(alternate);
        end;
    end;

    local bit32_bor_ret = bit32.bor(ReactFiberFlags.Placement, ReactFiberFlags.Update, ReactFiberFlags.Hydrating);
    local bit32_band_ret = bit32.band(flags, bit32_bor_ret);

    if bit32_band_ret == ReactFiberFlags.Placement then
        commitPlacement(p201);
        local flags2 = p201.flags;
        local bit32_bnot_ret = bit32.bnot(ReactFiberFlags.Placement);
        p201.flags = bit32.band(flags2, bit32_bnot_ret);

        return;
    end;

    if bit32_band_ret ~= ReactFiberFlags.PlacementAndUpdate then
        if bit32_band_ret == ReactFiberFlags.Update then
            commitWork(p201.alternate, p201);
        end;

        return;
    end;

    commitPlacement(p201);
    local flags2 = p201.flags;
    local bit32_bnot_ret = bit32.bnot(ReactFiberFlags.Placement);
    p201.flags = bit32.band(flags2, bit32_bnot_ret);
    commitWork(p201.alternate, p201);
end;

function u21.commitMutationEffectsDeletions(p204, p205, p206, p207) -- Line: 2714
    -- upvalues: commitDeletion (copy), describeError (copy), u1 (copy)
    for _, v in p204 do
        local v208, v209 = xpcall(commitDeletion, describeError, p206, v, p205, p207);

        if not v208 then
            u1.captureCommitPhaseError(v, p205, v209);
        end;
    end;
end;

function u1.schedulePassiveEffectCallback() -- Line: 2732
    -- upvalues: u35 (ref), scheduleCallback (copy), NormalPriority (copy), u1 (copy)
    if not u35 then
        u35 = true;
        scheduleCallback(NormalPriority, function() -- Line: 2735
            -- upvalues: u1 (ref)
            u1.flushPassiveEffects();

            return nil;
        end);
    end;
end;

local u210 = nil;

function u1.flushPassiveEffects() -- Line: 2744
    -- upvalues: u37 (ref), NoPriority (copy), NormalPriority (copy), ReactFeatureFlags (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), schedulerPriorityToLanePriority (copy), _G___YOLO__ (copy), runWithPriority (copy), describeError (copy), u210 (ref)
    if u37 == NoPriority then
        return false;
    end;

    local v211;

    if NormalPriority < u37 then
        v211 = NormalPriority;
    else
        v211 = u37;
    end;

    u37 = NoPriority;

    if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        return runWithPriority(v211, u210);
    end;

    local v212 = getCurrentUpdateLanePriority();
    setCurrentUpdateLanePriority(schedulerPriorityToLanePriority(v211));
    local v213, v214;

    if _G___YOLO__ then
        setCurrentUpdateLanePriority(schedulerPriorityToLanePriority(v211));
        v213 = runWithPriority(v211, u210);
        v214 = true;
    else
        v214, v213 = xpcall(runWithPriority, describeError, v211, u210);
    end;

    setCurrentUpdateLanePriority(v212);

    if not v214 then
        error(v213);
    end;

    return v213;
end;

local function u221(p215, p216) -- Line: 2788
    -- upvalues: ReactFeatureFlags (copy), ReactWorkTags (copy), u31 (ref), ReactFiberFlags (copy), u221 (ref), _G___DEV__ (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), commitPassiveMount (copy), hasCaughtError (copy), clearCaughtError (copy), u1 (copy), resetCurrentFiber (copy), _G___YOLO__ (copy), describeError (copy)
    while p216 ~= nil do
        local v217;

        if ReactFeatureFlags.enableProfilerTimer and (ReactFeatureFlags.enableProfilerCommitHooks and p216.tag == ReactWorkTags.Profiler) then
            v217 = u31;
            u31 = p216;
        else
            v217 = nil;
        end;

        local bit32_band_ret = bit32.band(p216.subtreeFlags, ReactFiberFlags.PassiveMask);

        if p216.child ~= nil and bit32_band_ret ~= ReactFiberFlags.NoFlags then
            u221(p215, p216.child);
        end;

        if bit32.band(p216.flags, ReactFiberFlags.Passive) ~= ReactFiberFlags.NoFlags then
            if _G___DEV__ then
                setCurrentFiber(p216);
                invokeGuardedCallback(nil, commitPassiveMount, nil, p215, p216);

                if hasCaughtError() then
                    local v218 = clearCaughtError();
                    u1.captureCommitPhaseError(p216, p216.return_, v218);
                end;

                resetCurrentFiber();
            else
                local v219 = nil;
                local v220;

                if _G___YOLO__ then
                    commitPassiveMount(p215, p216);
                    v220 = true;
                else
                    v220, v219 = xpcall(commitPassiveMount, describeError, p215, p216);
                end;

                if not v220 then
                    u1.captureCommitPhaseError(p216, p216.return_, v219);
                end;
            end;
        end;

        if ReactFeatureFlags.enableProfilerTimer and (ReactFeatureFlags.enableProfilerCommitHooks and p216.tag == ReactWorkTags.Profiler) then
            if v217 ~= nil then
                local stateNode = v217.stateNode;
                stateNode.passiveEffectDuration = stateNode.passiveEffectDuration + p216.stateNode.passiveEffectDuration;
            end;

            u31 = v217;
        end;

        p216 = p216.sibling;
    end;
end;

local function flushPassiveUnmountEffects(p222) -- Line: 2857
    -- upvalues: u21 (copy), ReactFiberFlags (copy), flushPassiveUnmountEffects (copy), setCurrentFiber (copy), commitPassiveUnmount (copy), resetCurrentFiber (copy)
    while p222 ~= nil do
        local deletions = p222.deletions;

        if deletions ~= nil then
            for i = 1, #deletions do
                local v223 = deletions[i];
                u21.flushPassiveUnmountEffectsInsideOfDeletedTree(v223, p222);
                u21.detachFiberAfterEffects(v223);
                local _ = i;
            end;
        end;

        local child = p222.child;

        if child ~= nil and bit32.band(p222.subtreeFlags, ReactFiberFlags.PassiveMask) ~= ReactFiberFlags.NoFlags then
            flushPassiveUnmountEffects(child);
        end;

        if bit32.band(p222.flags, ReactFiberFlags.Passive) ~= ReactFiberFlags.NoFlags then
            setCurrentFiber(p222);
            commitPassiveUnmount(p222);
            resetCurrentFiber();
        end;

        p222 = p222.sibling;
    end;
end;

function u21.flushPassiveUnmountEffectsInsideOfDeletedTree(p224, p225) -- Line: 2897
    -- upvalues: ReactFiberFlags (copy), u21 (copy), setCurrentFiber (copy), commitPassiveUnmountInsideDeletedTree (copy), resetCurrentFiber (copy)
    if bit32.band(p224.subtreeFlags, ReactFiberFlags.PassiveStatic) ~= ReactFiberFlags.NoFlags then
        local child = p224.child;

        while child ~= nil do
            u21.flushPassiveUnmountEffectsInsideOfDeletedTree(child, p225);
            child = child.sibling;
        end;
    end;

    if bit32.band(p224.flags, ReactFiberFlags.PassiveStatic) ~= ReactFiberFlags.NoFlags then
        setCurrentFiber(p224);
        commitPassiveUnmountInsideDeletedTree(p224, p225);
        resetCurrentFiber();
    end;
end;

u210 = function() -- Line: 2929
    -- upvalues: u36 (ref), NoLanes5 (ref), ReactFiberLane (copy), invariant (copy), u22 (ref), _G___DEV__ (copy), enableDebugTracing (copy), DebugTracing (copy), enableSchedulingProfiler (copy), SchedulingProfiler (copy), u21 (copy), flushPassiveUnmountEffects (copy), u221 (ref), enableDoubleInvokingEffects (copy), ReactFeatureFlags (copy), flushSyncCallbackQueue (copy), u41 (ref)
    if u36 == nil then
        return false;
    end;

    local v226 = u36;
    local v227 = NoLanes5;
    u36 = nil;
    NoLanes5 = ReactFiberLane.NoLanes;
    invariant(bit32.band(u22, 48) == 0, "Cannot flush passive effects while already rendering.");

    if _G___DEV__ and enableDebugTracing then
        DebugTracing.logPassiveEffectsStarted(v227);
    end;

    if enableSchedulingProfiler then
        SchedulingProfiler.markPassiveEffectsStarted(v227);
    end;

    local v228 = u22;
    u22 = bit32.bor(u22, 32);
    local v229 = u21.pushInteractions(v226);
    flushPassiveUnmountEffects(v226.current);
    u221(v226, v226.current);

    if _G___DEV__ and enableDebugTracing then
        DebugTracing.logPassiveEffectsStopped();
    end;

    if enableSchedulingProfiler then
        SchedulingProfiler.markPassiveEffectsStopped();
    end;

    if _G___DEV__ and enableDoubleInvokingEffects then
        commitDoubleInvokeEffectsInDEV(v226.current, true);
    end;

    if ReactFeatureFlags.enableSchedulerTracing then
        u21.popInteractions(v229);
        u21.finishPendingInteractions(v226, v227);
    end;

    u22 = v228;
    flushSyncCallbackQueue();

    if u36 == nil then
        u41 = 0;
    else
        u41 = u41 + 1;
    end;

    return true;
end;

function u1.isAlreadyFailedLegacyErrorBoundary(p230) -- Line: 3002
    -- upvalues: u34 (ref)
    local v231;

    if u34 == nil then
        v231 = false;
    else
        v231 = u34:has(p230);
    end;

    return v231;
end;

function u1.markLegacyErrorBoundaryAsFailed(p232) -- Line: 3008
    -- upvalues: u34 (ref), Set (copy)
    if u34 == nil then
        u34 = Set.new({ p232 });

        return;
    end;

    u34:add(p232);
end;

function u1.onUncaughtError(p233) -- Line: 3017
    -- upvalues: u32 (ref), u33 (ref)
    if not u32 then
        u32 = true;
        u33 = p233;
    end;
end;

u20 = function(p234, p235, p236) -- Line: 3025
    -- upvalues: createCapturedValue (copy), createRootErrorUpdate (copy), SyncLane (copy), u1 (copy), enqueueUpdate (copy), u21 (copy), markRootUpdated (copy), u8 (ref)
    enqueueUpdate(p234, (createRootErrorUpdate(p234, createCapturedValue(p236, p235), SyncLane, u1.onUncaughtError)));
    local v237 = u1.requestEventTime();
    local v238 = u21.markUpdateLaneFromFiberToRoot(p234, SyncLane);

    if v238 ~= nil then
        markRootUpdated(v238, SyncLane, v237);
        u8(v238, v237);
        u21.schedulePendingInteractions(v238, SyncLane);
    end;
end;

function u1.captureCommitPhaseError(p239, p240, p241) -- Line: 3046
    -- upvalues: ReactWorkTags (copy), u20 (ref), skipUnmountedBoundaries (copy), u1 (copy), createCapturedValue (copy), createClassErrorUpdate (copy), SyncLane (copy), enqueueUpdate (copy), u21 (copy), markRootUpdated (copy), u8 (ref)
    if p239.tag == ReactWorkTags.HostRoot then
        u20(p239, p239, p241);

        return;
    end;

    if not skipUnmountedBoundaries then
        p240 = p239.return_;
    end;

    while p240 ~= nil do
        if p240.tag == ReactWorkTags.HostRoot then
            u20(p240, p239, p241);

            return;
        end;

        if p240.tag == ReactWorkTags.ClassComponent then
            local stateNode = p240.stateNode;

            if typeof(p240.type.getDerivedStateFromError) == "function" or typeof(stateNode.componentDidCatch) == "function" and not u1.isAlreadyFailedLegacyErrorBoundary(stateNode) then
                enqueueUpdate(p240, (createClassErrorUpdate(p240, createCapturedValue(p241, p239), SyncLane)));
                local v242 = u1.requestEventTime();
                local v243 = u21.markUpdateLaneFromFiberToRoot(p240, SyncLane);

                if v243 ~= nil then
                    markRootUpdated(v243, SyncLane, v242);
                    u8(v243, v242);
                    u21.schedulePendingInteractions(v243, SyncLane);
                end;

                return;
            end;
        end;

        p240 = p240.return_;
    end;
end;

function u1.pingSuspendedRoot(p244, p245, p246) -- Line: 3095
    -- upvalues: u1 (copy), markRootPinged (copy), u23 (ref), isSubsetOfLanes (copy), NoLanes (ref), u26 (ref), includesOnlyRetries (copy), now (copy), u29 (ref), u21 (copy), ReactFiberLane (copy), NoLanes4 (ref), mergeLanes (copy), u8 (ref)
    local pingCache = p244.pingCache;

    if pingCache ~= nil then
        pingCache[p245] = nil;
    end;

    local v247 = u1.requestEventTime();
    markRootPinged(p244, p246, v247);

    if u23 == p244 and isSubsetOfLanes(NoLanes, p246) then
        if u26 == 4 or u26 == 3 and (includesOnlyRetries(NoLanes) and now() - u29 < 500) then
            u21.prepareFreshStack(p244, ReactFiberLane.NoLanes);
        else
            NoLanes4 = mergeLanes(NoLanes4, p246);
        end;
    end;

    u8(p244, v247);
    u21.schedulePendingInteractions(p244, p246);
end;

function retryTimedOutBoundary(p248, p249)
    -- upvalues: ReactFiberLane (copy), u1 (copy), u21 (copy), markRootUpdated (copy), u8 (ref)
    if p249 == ReactFiberLane.NoLane then
        p249 = requestRetryLane(p248);
    end;

    local v250 = u1.requestEventTime();
    local v251 = u21.markUpdateLaneFromFiberToRoot(p248, p249);

    if v251 ~= nil then
        markRootUpdated(v251, p249, v250);
        u8(v251, v250);
        u21.schedulePendingInteractions(v251, p249);
    end;
end;

function u1.resolveRetryWakeable(p252, p253) -- Line: 3166
    -- upvalues: ReactFiberLane (copy)
    local NoLane = ReactFiberLane.NoLane;
    local stateNode = p252.stateNode;

    if stateNode ~= nil then
        stateNode:delete(p253);
    end;

    retryTimedOutBoundary(p252, NoLane);
end;

function jnd(p254: number)
    return p254 < 120 and 120 or (p254 < 480 and 480 or (p254 < 1080 and 1080 or (p254 < 1920 and 1920 or (p254 < 3000 and 3000 or (p254 < 4320 and 4320 or math.ceil(p254 / 1960) * 1960)))));
end;

function u21.checkForNestedUpdates() -- Line: 3228
    -- upvalues: u39 (ref), u40 (ref), invariant (copy), _G___DEV__ (copy), u41 (ref), console (copy)
    if u39 > 50 then
        u39 = 0;
        u40 = nil;
        invariant(
            false,
            "Maximum update depth exceeded. This can happen when a component repeatedly calls setState inside componentWillUpdate or componentDidUpdate. React limits the number of nested updates to prevent infinite loops."
        );
    end;

    if _G___DEV__ and u41 > 50 then
        u41 = 0;
        console.error("Maximum update depth exceeded. This can happen when a component calls setState inside useEffect, but useEffect either doesn\'t have a dependency array, or one of the dependencies changes on every render.");
    end;
end;

function flushRenderPhaseStrictModeWarningsInDEV()
    -- upvalues: _G___DEV__ (copy), u19 (copy), ReactFeatureFlags (copy)
    if _G___DEV__ then
        u19.flushLegacyContextWarning();

        if ReactFeatureFlags.warnAboutDeprecatedLifecycles then
            u19.flushPendingUnsafeLifecycleWarnings();
        end;
    end;
end;

function commitDoubleInvokeEffectsInDEV(p255: any, p256: boolean)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), setCurrentFiber (copy), ReactFiberFlags (copy), invokeLayoutEffectUnmountInDEV (copy), invokePassiveEffectUnmountInDEV (copy), invokeLayoutEffectMountInDEV (copy), invokePassiveEffectMountInDEV (copy), resetCurrentFiber (copy)
    if _G___DEV__ and enableDoubleInvokingEffects then
        setCurrentFiber(p255);
        invokeEffectsInDev(p255, ReactFiberFlags.MountLayoutDev, invokeLayoutEffectUnmountInDEV);

        if p256 then
            invokeEffectsInDev(p255, ReactFiberFlags.MountPassiveDev, invokePassiveEffectUnmountInDEV);
        end;

        invokeEffectsInDev(p255, ReactFiberFlags.MountLayoutDev, invokeLayoutEffectMountInDEV);

        if p256 then
            invokeEffectsInDev(p255, ReactFiberFlags.MountPassiveDev, invokePassiveEffectMountInDEV);
        end;

        resetCurrentFiber();
    end;
end;

function invokeEffectsInDev(p257: any, p258: any, p259: function)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), ReactFiberFlags (copy)
    if _G___DEV__ and enableDoubleInvokingEffects then
        while p257 ~= nil do
            if p257.child ~= nil and bit32.band(p257.subtreeFlags, p258) ~= ReactFiberFlags.NoFlags then
                invokeEffectsInDev(p257.child, p258, p259);
            end;

            if bit32.band(p257.flags, p258) ~= ReactFiberFlags.NoFlags then
                p259(p257);
            end;

            p257 = p257.sibling;
        end;
    end;
end;

local u260 = nil;

function u21.warnAboutUpdateOnNotYetMountedFiberInDEV(u261) -- Line: 3322
    -- upvalues: _G___DEV__ (copy), u22 (ref), ReactTypeOfMode (copy), ReactWorkTags (copy), getComponentName (copy), u260 (ref), ReactCurrentFiber (copy), setCurrentFiber (copy), console (copy), resetCurrentFiber (copy)
    if _G___DEV__ then
        if bit32.band(u22, 16) ~= 0 then
            return;
        end;

        local mode = u261.mode;
        local bit32_bor_ret = bit32.bor(ReactTypeOfMode.BlockingMode, ReactTypeOfMode.ConcurrentMode);

        if bit32.band(mode, bit32_bor_ret) == 0 then
            return;
        end;

        local tag = u261.tag;

        if tag ~= ReactWorkTags.IndeterminateComponent and (tag ~= ReactWorkTags.HostRoot and (tag ~= ReactWorkTags.ClassComponent and (tag ~= ReactWorkTags.FunctionComponent and (tag ~= ReactWorkTags.ForwardRef and (tag ~= ReactWorkTags.MemoComponent and (tag ~= ReactWorkTags.SimpleMemoComponent and tag ~= ReactWorkTags.Block)))))) then
            return;
        end;

        local v262 = getComponentName(u261.type) or "ReactComponent";

        if u260 == nil then
            u260 = {
                [v262] = true
            };
        else
            if u260[v262] then
                return;
            end;

            u260[v262] = true;
        end;

        local current2 = ReactCurrentFiber.current;
        local success, result = pcall(function() -- Line: 3367
            -- upvalues: setCurrentFiber (ref), u261 (copy), console (ref)
            setCurrentFiber(u261);
            console.error("Can\'t perform a React state update on a component that hasn\'t mounted yet. This indicates that you have a side-effect in your render function that asynchronously later calls tries to update the component. Move this work to useEffect instead.");
        end);

        if current2 then
            setCurrentFiber(u261);
        else
            resetCurrentFiber();
        end;

        if not success then
            error(result);
        end;
    end;
end;

if _G___DEV__ and ReactFeatureFlags.replayFailedUnitOfWorkWithInvokeGuardedCallback then
    function u21.beginWork(p263, p264, p265) -- Line: 3393
        -- upvalues: u4 (copy), u13 (copy), describeError (copy), resetContextDependencies (copy), u9 (copy), u17 (ref), unwindInterruptedWork (copy), ReactFeatureFlags (copy), ReactTypeOfMode (copy), u18 (copy), invokeGuardedCallback (copy), hasCaughtError (copy), clearCaughtError (copy)
        local v266 = u4.assignFiberPropertiesInDEV(nil, p264);
        local v267, v268 = xpcall(u13, describeError, p263, p264, p265);

        if not v267 then
            if v268 ~= nil and (typeof(v268) == "table" and typeof(v268.andThen) == "function") then
                error(v268);
            end;

            resetContextDependencies();

            if not u9.resetHooksAfterThrowRef then
                u17 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
                u9.resetHooksAfterThrowRef = u17.resetHooksAfterThrow;
                u9.ContextOnlyDispatcherRef = u17.ContextOnlyDispatcher;
                u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = u17.getIsUpdatingOpaqueValueInRenderPhaseInDEV;
            end;

            u9.resetHooksAfterThrowRef();
            unwindInterruptedWork(p264);
            u4.assignFiberPropertiesInDEV(p264, v266);

            if ReactFeatureFlags.enableProfilerTimer and bit32.band(p264.mode, ReactTypeOfMode.ProfileMode) ~= 0 then
                u18.startProfilerTimer(p264);
            end;

            invokeGuardedCallback(nil, u13, nil, p263, p264, p265);

            if hasCaughtError() then
                local v269 = clearCaughtError();
                error(v269);

                return v268;
            end;

            error(v268);
        end;

        return v268;
    end;
else
    u21.beginWork = u13;
end;

local u270 = false;
local u271 = _G___DEV__ and {} or nil;

function u21.warnAboutRenderPhaseUpdatesInDEV(p272) -- Line: 3463
    -- upvalues: _G___DEV__ (copy), ReactCurrentFiber (copy), u22 (ref), u9 (copy), u17 (ref), ReactWorkTags (copy), u24 (ref), getComponentName (copy), u271 (ref), console (copy), u270 (ref)
    if _G___DEV__ and (ReactCurrentFiber.isRendering and bit32.band(u22, 16) ~= 0) then
        if not u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef then
            u17 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
            u9.resetHooksAfterThrowRef = u17.resetHooksAfterThrow;
            u9.ContextOnlyDispatcherRef = u17.ContextOnlyDispatcher;
            u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = u17.getIsUpdatingOpaqueValueInRenderPhaseInDEV;
        end;

        if not u9.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef() then
            if p272.tag == ReactWorkTags.FunctionComponent or (p272.tag == ReactWorkTags.ForwardRef or p272.tag == ReactWorkTags.SimpleMemoComponent) then
                local v273 = u24 == nil and "Unknown" or getComponentName(u24.type);

                if u271[v273] == nil then
                    u271[v273] = true;
                    local v274 = getComponentName(p272.type) or "Unknown";
                    console.error("Cannot update a component (`%s`) while rendering a different component (`%s`). To locate the bad setState() call inside `%s`, follow the stack trace as described in https://reactjs.org/link/setstate-in-render", v274, v273, v273);
                end;
            elseif p272.tag == ReactWorkTags.ClassComponent and not u270 then
                console.error("Cannot update during an existing state transition (such as within `render`). Render methods should be a pure function of props and state.");
                u270 = true;
            end;
        end;
    end;
end;

u1.IsThisRendererActing = {
    current = false
};

function u1.warnIfNotScopedWithMatchingAct(u275) -- Line: 3515
    -- upvalues: _G___DEV__ (copy), ReactFiberHostConfig (copy), IsSomeRendererActing (copy), u1 (copy), ReactCurrentFiber (copy), setCurrentFiber (copy), console (copy), resetCurrentFiber (copy)
    if _G___DEV__ and (ReactFiberHostConfig.warnsIfNotActing == true and (IsSomeRendererActing.current == true and u1.IsThisRendererActing.current ~= true)) then
        local current2 = ReactCurrentFiber.current;
        local success, result = pcall(function() -- Line: 3523
            -- upvalues: setCurrentFiber (ref), u275 (copy), console (ref)
            setCurrentFiber(u275);
            console.error("It looks like you\'re using the wrong act() around your test interactions.\nBe sure to use the matching version of act() corresponding to your renderer:\n\n-- for react-roblox:\nlocal React = require(Packages.React)\n-- ...\nReact.TestUtils.act(function() ... end)\n\n-- for react-test-renderer:\nlocal TestRenderer = require(Packages.ReactTestRenderer)\n-- ...\nTestRenderer.act(function() ... end)");
        end);

        if current2 then
            setCurrentFiber(u275);
        else
            resetCurrentFiber();
        end;

        if not success then
            error(result);
        end;
    end;
end;

function u1.warnIfNotCurrentlyActingEffectsInDEV(p276) -- Line: 3559
    -- upvalues: _G___DEV__ (copy), ReactFiberHostConfig (copy), ReactTypeOfMode (copy), IsSomeRendererActing (copy), u1 (copy), console (copy), getComponentName (copy)
    if _G___DEV__ and (ReactFiberHostConfig.warnsIfNotActing == true and (bit32.band(p276.mode, ReactTypeOfMode.StrictMode) ~= ReactTypeOfMode.NoMode and (IsSomeRendererActing.current == false and u1.IsThisRendererActing.current == false))) then
        console.error("An update to %s ran an effect, but was not wrapped in act(...).\n\nWhen testing, code that causes React state updates should be wrapped into act(...):\n\nact(function()\n  --[[ fire events that update state ]]\nend)\n--[[ assert on the output ]]\n\nThis ensures that you\'re testing the behavior the user would see in the real client. Learn more at https://reactjs.org/link/wrap-tests-with-act", getComponentName(p276.type));
    end;
end;

function u1.warnIfNotCurrentlyActingUpdatesInDEV(u277) -- Line: 3585
    -- upvalues: _G___DEV__ (copy), ReactFiberHostConfig (copy), u22 (ref), IsSomeRendererActing (copy), u1 (copy), current (copy), setCurrentFiber (copy), console (copy), getComponentName (copy), resetCurrentFiber (copy)
    if _G___DEV__ and (ReactFiberHostConfig.warnsIfNotActing == true and (u22 == 0 and (IsSomeRendererActing.current == false and u1.IsThisRendererActing.current == false))) then
        local success, result = pcall(function() -- Line: 3594
            -- upvalues: setCurrentFiber (ref), u277 (copy), console (ref), getComponentName (ref)
            setCurrentFiber(u277);
            console.error("An update to %s inside a test was not wrapped in act(...).\n\nWhen testing, code that causes React state updates should be wrapped into act(...):\n\nact(function()\n  --[[ fire events that update state ]]\nend)\n--[[ assert on the output ]]\n\nThis ensures that you\'re testing the behavior the user would see in the client application. Learn more at https://reactjs.org/link/wrap-tests-with-act", getComponentName(u277.type));
        end);

        if current then
            setCurrentFiber(u277);
        else
            resetCurrentFiber();
        end;

        if success then
            return result;
        end;
    end;
end;

local u278 = false;

function u1.warnIfUnmockedScheduler(p279) -- Line: 3635
    -- upvalues: _G___DEV__ (copy), u278 (ref), scheduler (copy), ReactTypeOfMode (copy), console (copy), ReactFeatureFlags (copy)
    if _G___DEV__ and (u278 == false and scheduler.unstable_flushAllWithoutAsserting == nil) then
        if bit32.band(p279.mode, ReactTypeOfMode.BlockingMode) ~= 0 or bit32.band(p279.mode, ReactTypeOfMode.ConcurrentMode) ~= 0 then
            u278 = true;
            console.error("In Concurrent or Sync modes, the \'scheduler\' module needs to be mocked to guarantee consistent behaviour across tests and client application. For example, with Jest: \njest.mock(\'scheduler\', function() return require(@pkg/scheduler).unstable_mock end)\n\nFor more info, visit https://reactjs.org/link/mock-scheduler");

            return;
        end;

        if ReactFeatureFlags.warnAboutUnmockedScheduler == true then
            u278 = true;
            console.error("Starting from React v18, the \'scheduler\' module will need to be mocked to guarantee consistent behaviour across tests and client applications. For example, with Jest: \njest.mock(\'scheduler\', function() return require(@pkg/scheduler).unstable_mock end)\n\nFor more info, visit https://reactjs.org/link/mock-scheduler");
        end;
    end;
end;

function computeThreadID(p280, p281)
    return p281 * 1000 + p280.interactionThreadID;
end;

function u1.markSpawnedWork(p282) -- Line: 3686
    -- upvalues: ReactFeatureFlags (copy), u42 (ref)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return;
    end;

    if u42 == nil then
        u42 = { p282 };

        return;
    end;

    table.insert(u42, p282);
end;

function scheduleInteractions(p283, p284, p285)
    -- upvalues: ReactFeatureFlags (copy), Set (copy), __subscriberRef (copy)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return;
    end;

    if p285.size > 0 then
        local pendingInteractionMap = p283.pendingInteractionMap;
        local u286 = pendingInteractionMap:get(p284);

        if u286 == nil then
            pendingInteractionMap:set(p284, Set.new(p285));

            for _, v in p285 do
                v.__count = v.__count + 1;
            end;
        else
            p285:forEach(function(p287) -- Line: 3711
                -- upvalues: u286 (copy)
                if not u286:has(p287) then
                    p287.__count = p287.__count + 1;
                end;

                u286:add(p287);
            end);
        end;

        local current2 = __subscriberRef.current;

        if current2 ~= nil then
            local v288 = computeThreadID(p283, p284);
            current2.onWorkScheduled(p285, v288);
        end;
    end;
end;

function u21.schedulePendingInteractions(p289, p290) -- Line: 3736
    -- upvalues: ReactFeatureFlags (copy), __interactionsRef (copy)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return;
    end;

    scheduleInteractions(p289, p290, __interactionsRef.current);
end;

function u21.startWorkOnPendingInteractions(p291, u292) -- Line: 3747
    -- upvalues: ReactFeatureFlags (copy), Set (copy), includesSomeLane (copy), __subscriberRef (copy), describeError (copy), scheduleCallback (copy), ImmediatePriority (copy)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return;
    end;

    local u293 = Set.new();
    p291.pendingInteractionMap:forEach(function(p294, p295) -- Line: 3757
        -- upvalues: includesSomeLane (ref), u292 (copy), u293 (copy)
        if includesSomeLane(u292, p295) then
            p294:forEach(function(p296) -- Line: 3759
                -- upvalues: u293 (ref)
                u293:add(p296);
            end);
        end;
    end);
    p291.memoizedInteractions = u293;

    if u293.size > 0 then
        local current2 = __subscriberRef.current;

        if current2 ~= nil then
            local v297 = computeThreadID(p291, u292);
            local v298, u299 = xpcall(current2.onWorkStarted, describeError, u293, v297);

            if not v298 then
                scheduleCallback(ImmediatePriority, function() -- Line: 3781
                    -- upvalues: u299 (copy)
                    error(u299);
                end);
            end;
        end;
    end;
end;

function u21.finishPendingInteractions(p300, p301) -- Line: 3789
    -- upvalues: ReactFeatureFlags (copy), __subscriberRef (copy), describeError (copy), includesSomeLane (copy), scheduleCallback (copy), ImmediatePriority (copy)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return;
    end;

    local pendingLanes = p300.pendingLanes;
    local u302 = nil;
    local u303, v304;

    if u302 == nil or p300.memoizedInteractions.size <= 0 then
        u303 = nil;
        v304 = true;
    else
        local v305 = computeThreadID(p300, p301);
        u302 = __subscriberRef.current;
        v304, u303 = xpcall(u302.onWorkStopped, describeError, p300.memoizedInteractions, v305);
    end;

    local pendingInteractionMap = p300.pendingInteractionMap;
    pendingInteractionMap:forEach(function(p306, p307) -- Line: 3820
        -- upvalues: includesSomeLane (ref), pendingLanes (copy), pendingInteractionMap (copy), u302 (ref), describeError (ref), scheduleCallback (ref), ImmediatePriority (ref)
        if not includesSomeLane(pendingLanes, p307) then
            pendingInteractionMap:delete(p307);
            p306:forEach(function(p308) -- Line: 3826
                -- upvalues: u302 (ref), describeError (ref), scheduleCallback (ref), ImmediatePriority (ref)
                p308.__count = p308.__count - 1;

                if u302 ~= nil and p308.__count == 0 then
                    local v309, u310 = xpcall(u302.onInteractionScheduledWorkCompleted, describeError, p308);

                    if not v309 then
                        scheduleCallback(ImmediatePriority, function() -- Line: 3837
                            -- upvalues: u310 (copy)
                            error(u310);
                        end);
                    end;
                end;
            end);
        end;
    end);

    if not v304 then
        scheduleCallback(ImmediatePriority, function() -- Line: 3849
            -- upvalues: u303 (ref)
            error(u303);
        end);
    end;
end;

local u311 = false;
local u312 = false;
local unstable_flushAllWithoutAsserting = scheduler.unstable_flushAllWithoutAsserting;
local u313 = typeof(unstable_flushAllWithoutAsserting) == "function";

local function flushActWork() -- Line: 3868
    -- upvalues: unstable_flushAllWithoutAsserting (copy), u311 (ref), describeError (copy), u1 (copy)
    if unstable_flushAllWithoutAsserting == nil then
        local v314 = u311;
        u311 = true;
        local v316, v317 = xpcall(function() -- Line: 3888
            -- upvalues: u1 (ref)
            local v315 = false;

            while u1.flushPassiveEffects() do
                v315 = true;
            end;

            return v315;
        end, describeError);
        u311 = v314;

        if v316 then
            return v317;
        end;

        error(v317);

        return;
    end;

    local v318 = u311;
    u311 = true;
    local v319, v320 = xpcall(unstable_flushAllWithoutAsserting, describeError);
    u311 = v318;

    if v319 then
        return v320;
    end;

    error(v320);
end;

local function flushWorkAndMicroTasks(u321: function) -- Line: 3907
    -- upvalues: flushActWork (copy), describeError (copy), enqueueTask (copy), flushWorkAndMicroTasks (copy)
    local v322, v323 = xpcall(flushActWork, describeError);

    if v322 then
        v322, v323 = xpcall(enqueueTask, describeError, function() -- Line: 3911
            -- upvalues: flushActWork (ref), flushWorkAndMicroTasks (ref), u321 (copy)
            if flushActWork() then
                flushWorkAndMicroTasks(u321);

                return;
            end;

            u321();
        end);
    end;

    if not v322 then
        u321(v323);
    end;
end;

function u1.act(p324: function) -- Line: 3925
    -- upvalues: _G___DEV__ (copy), u76 (ref), console (copy), u75 (ref), IsSomeRendererActing (copy), u1 (copy), u312 (ref), describeError (copy), promise (copy), u313 (copy), flushWorkAndMicroTasks (copy), flushActWork (copy)
    if not (_G___DEV__ or (_G.__ROACT_17_MOCK_SCHEDULER__ or u76 ~= false)) then
        u76 = true;
        console.error("act(...) is not supported in production builds of React, and might not behave as expected.");
    end;

    local u325 = u75;
    u75 = u75 + 1;
    local current2 = IsSomeRendererActing.current;
    local current3 = u1.IsThisRendererActing.current;
    local u326 = u312;
    IsSomeRendererActing.current = true;
    u1.IsThisRendererActing.current = true;
    u312 = true;

    local function onDone() -- Line: 3950
        -- upvalues: u75 (ref), IsSomeRendererActing (ref), current2 (copy), u1 (ref), current3 (copy), u312 (ref), u326 (copy), _G___DEV__ (ref), u325 (copy), console (ref)
        u75 = u75 - 1;
        IsSomeRendererActing.current = current2;
        u1.IsThisRendererActing.current = current3;
        u312 = u326;

        if _G___DEV__ and u325 < u75 then
            console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ");
        end;
    end;

    local v327, u328 = xpcall(u1.batchedUpdates, describeError, p324);

    if not v327 then
        u75 = u75 - 1;
        IsSomeRendererActing.current = current2;
        u1.IsThisRendererActing.current = current3;
        u312 = u326;

        if _G___DEV__ and u325 < u75 then
            console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ");
        end;

        error(u328);
    end;

    if u328 ~= nil and (typeof(u328) == "table" and typeof(u328.andThen) == "function") then
        local u329 = false;

        if _G___DEV__ and typeof(promise) ~= nil then
            promise.resolve():andThen(function() -- Line: 3983
            end):andThen(function() -- Line: 3983
                -- upvalues: u329 (ref), console (ref)
                if u329 == false then
                    console.error("You called act(Promise.new(function() --[[ ... ]] end)) without :await() or :expect(). This could lead to unexpected testing behaviour, interleaving multiple act calls and mixing their scopes. You should - act(function() Promise.new(function() --[[ ... ]] end):await() end);");
                end;
            end);
        end;

        return {
            andThen = function(p330, u331, u332) -- Line: 4002, Name: andThen
                -- upvalues: u329 (ref), u328 (copy), u75 (ref), u313 (ref), current2 (copy), IsSomeRendererActing (ref), u1 (ref), current3 (copy), u312 (ref), u326 (copy), _G___DEV__ (ref), u325 (copy), console (ref), flushWorkAndMicroTasks (ref)
                u329 = true;

                return u328:andThen(function() -- Line: 4004
                    -- upvalues: u75 (ref), u313 (ref), current2 (ref), IsSomeRendererActing (ref), u1 (ref), current3 (ref), u312 (ref), u326 (ref), _G___DEV__ (ref), u325 (ref), console (ref), u331 (copy), flushWorkAndMicroTasks (ref), u332 (copy)
                    if u75 <= 1 and (u313 ~= true or current2 ~= true) then
                        flushWorkAndMicroTasks(function(p333) -- Line: 4018
                            -- upvalues: u75 (ref), IsSomeRendererActing (ref), current2 (ref), u1 (ref), current3 (ref), u312 (ref), u326 (ref), _G___DEV__ (ref), u325 (ref), console (ref), u332 (ref), u331 (ref)
                            u75 = u75 - 1;
                            IsSomeRendererActing.current = current2;
                            u1.IsThisRendererActing.current = current3;
                            u312 = u326;

                            if _G___DEV__ and u325 < u75 then
                                console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ");
                            end;

                            if p333 then
                                u332(p333);

                                return;
                            end;

                            u331();
                        end);

                        return;
                    end;

                    u75 = u75 - 1;
                    IsSomeRendererActing.current = current2;
                    u1.IsThisRendererActing.current = current3;
                    u312 = u326;

                    if _G___DEV__ and u325 < u75 then
                        console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ");
                    end;

                    u331();
                end, function(p334) -- Line: 4026
                    -- upvalues: u75 (ref), IsSomeRendererActing (ref), current2 (ref), u1 (ref), current3 (ref), u312 (ref), u326 (ref), _G___DEV__ (ref), u325 (ref), console (ref), u332 (copy)
                    u75 = u75 - 1;
                    IsSomeRendererActing.current = current2;
                    u1.IsThisRendererActing.current = current3;
                    u312 = u326;

                    if _G___DEV__ and u325 < u75 then
                        console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ");
                    end;

                    u332(p334);
                end);
            end
        };
    end;

    if _G___DEV__ and u328 ~= nil then
        console.error("The callback passed to act(...) function must return nil, or a Promise. You returned %s", (tostring(u328)));
    end;

    local v335, v336 = xpcall(function() -- Line: 4045
        -- upvalues: u75 (ref), u313 (ref), current2 (copy), flushActWork (ref), IsSomeRendererActing (ref), u1 (ref), current3 (copy), u312 (ref), u326 (copy), _G___DEV__ (ref), u325 (copy), console (ref)
        if u75 == 1 and (u313 == false or current2 == false) then
            flushActWork();
        end;

        u75 = u75 - 1;
        IsSomeRendererActing.current = current2;
        u1.IsThisRendererActing.current = current3;
        u312 = u326;

        if _G___DEV__ and u325 < u75 then
            console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ");
        end;
    end, describeError);

    if not v335 then
        u75 = u75 - 1;
        IsSomeRendererActing.current = current2;
        u1.IsThisRendererActing.current = current3;
        u312 = u326;

        if _G___DEV__ and u325 < u75 then
            console.error("You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. ");
        end;

        error(v336);
    end;

    return {
        andThen = function(p337, p338, p339) -- Line: 4065, Name: andThen
            -- upvalues: _G___DEV__ (ref), console (ref)
            if _G___DEV__ then
                console.error("Do not await the result of calling act(...) with sync logic, it is not a Promise.");
            end;

            p338();
        end
    };
end;

function u21.detachFiberAfterEffects(p340) -- Line: 4077
    -- upvalues: _G___DEV__ (copy)
    p340.child = nil;
    p340.deletions = nil;
    p340.dependencies = nil;
    p340.memoizedProps = nil;
    p340.memoizedState = nil;
    p340.pendingProps = nil;
    p340.sibling = nil;
    p340.stateNode = nil;
    p340.updateQueue = nil;

    if _G___DEV__ then
        p340._debugOwner = nil;
    end;
end;

return u1;