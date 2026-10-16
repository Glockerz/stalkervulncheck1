-- Decompiled with Potassium's decompiler.

local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Set = v1.Set;
local Map = v1.Map;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactRootTags = require(script.Parent:WaitForChild("ReactRootTags"));
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
local noTimeout = ReactFiberHostConfig.noTimeout;
local supportsHydration = ReactFiberHostConfig.supportsHydration;
local createHostRootFiber = require(script.Parent:WaitForChild("ReactFiber.new")).createHostRootFiber;
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local NoLanes = ReactFiberLane.NoLanes;
local NoLanePriority = ReactFiberLane.NoLanePriority;
local NoTimestamp = ReactFiberLane.NoTimestamp;
local createLaneMap = ReactFiberLane.createLaneMap;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing;
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback;
local unstable_getThreadID = require(script.Parent.Parent:WaitForChild("scheduler")).tracing.unstable_getThreadID;
local initializeUpdateQueue = require(script.Parent:WaitForChild("ReactUpdateQueue.new")).initializeUpdateQueue;
local LegacyRoot = ReactRootTags.LegacyRoot;
local BlockingRoot = ReactRootTags.BlockingRoot;
local ConcurrentRoot = ReactRootTags.ConcurrentRoot;
local v2 = {};

local function FiberRootNode(p3, p4, p5) -- Line: 47
    -- upvalues: noTimeout (copy), NoLanePriority (copy), createLaneMap (copy), NoLanes (copy), NoTimestamp (copy), supportsHydration (copy), enableSchedulerTracing (copy), unstable_getThreadID (copy), Set (copy), Map (copy), enableSuspenseCallback (copy), BlockingRoot (copy), ConcurrentRoot (copy), LegacyRoot (copy)
    local v6 = {
        pendingChildren = nil,
        current = nil,
        pingCache = nil,
        finishedWork = nil,
        context = nil,
        pendingContext = nil,
        callbackNode = nil,
        tag = p4,
        containerInfo = p3,
        timeoutHandle = noTimeout,
        hydrate = p5,
        callbackPriority = NoLanePriority,
        eventTimes = createLaneMap(NoLanes),
        expirationTimes = createLaneMap(NoTimestamp),
        pendingLanes = NoLanes,
        suspendedLanes = NoLanes,
        pingedLanes = NoLanes,
        expiredLanes = NoLanes,
        mutableReadLanes = NoLanes,
        finishedLanes = NoLanes,
        entangledLanes = NoLanes,
        entanglements = createLaneMap(NoLanes)
    };

    if supportsHydration then
        v6.mutableSourceEagerHydrationData = nil;
    end;

    if enableSchedulerTracing then
        v6.interactionThreadID = unstable_getThreadID();
        v6.memoizedInteractions = Set.new();
        v6.pendingInteractionMap = Map.new();
    end;

    if enableSuspenseCallback then
        v6.hydrationCallbacks = nil;
    end;

    if _G.__DEV__ then
        if p4 == BlockingRoot then
            v6._debugRootType = "createBlockingRoot()";

            return v6;
        end;

        if p4 == ConcurrentRoot then
            v6._debugRootType = "createRoot()";

            return v6;
        end;

        if p4 == LegacyRoot then
            v6._debugRootType = "createLegacyRoot()";
        end;
    end;

    return v6;
end;

function v2.createFiberRoot(p7: any, p8: any, p9: boolean, p10: any) -- Line: 103
    -- upvalues: FiberRootNode (copy), enableSuspenseCallback (copy), createHostRootFiber (copy), initializeUpdateQueue (copy)
    local v11 = FiberRootNode(p7, p8, p9);

    if enableSuspenseCallback then
        v11.hydrationCallbacks = p10;
    end;

    local v12 = createHostRootFiber(p8);
    v11.current = v12;
    v12.stateNode = v11;
    initializeUpdateQueue(v12);

    return v11;
end;

return v2;