-- Decompiled with Potassium's decompiler.

local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
require(script.Parent:WaitForChild("ReactCapturedValue"));
local v1 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"));
require(script.Parent.Parent:WaitForChild("shared"));
local v2 = require(script.Parent:WaitForChild("ReactFiberSuspenseContext.new"));
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local ClassComponent = ReactWorkTags.ClassComponent;
local HostRoot = ReactWorkTags.HostRoot;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local DidCapture = ReactFiberFlags.DidCapture;
local Incomplete = ReactFiberFlags.Incomplete;
local NoFlags = ReactFiberFlags.NoFlags;
local ShouldCapture = ReactFiberFlags.ShouldCapture;
local LifecycleEffectMask = ReactFiberFlags.LifecycleEffectMask;
local ForceUpdateForLegacySuspense = ReactFiberFlags.ForceUpdateForLegacySuspense;
local shouldCaptureSuspense = require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new")).shouldCaptureSuspense;
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"));
local NoMode = ReactTypeOfMode.NoMode;
local BlockingMode = ReactTypeOfMode.BlockingMode;
local DebugTracingMode = ReactTypeOfMode.DebugTracingMode;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing;
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler;
local createCapturedValue = require(script.Parent:WaitForChild("ReactCapturedValue")).createCapturedValue;
local enqueueCapturedUpdate = v1.enqueueCapturedUpdate;
local createUpdate = v1.createUpdate;
local CaptureUpdate = v1.CaptureUpdate;
local ForceUpdate = v1.ForceUpdate;
local enqueueUpdate = v1.enqueueUpdate;
local markFailedErrorBoundaryForHotReloading = require(script.Parent["ReactFiberHotReloading.new"]).markFailedErrorBoundaryForHotReloading;
local hasSuspenseContext = v2.hasSuspenseContext;
local InvisibleParentSuspenseContext = v2.InvisibleParentSuspenseContext;
local suspenseStackCursor = v2.suspenseStackCursor;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;

local function u7(...) -- Line: 87
    -- upvalues: u4 (ref), u3 (ref)
    if not u4 then
        u3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
        u4 = u3.markLegacyErrorBoundaryAsFailed;
    end;

    return u4(...);
end;

local function u8(...) -- Line: 102
    -- upvalues: u3 (ref), u6 (ref)
    if u3 == nil then
        u3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
    end;

    u6 = u3.pingSuspendedRoot;

    return u6(...);
end;

local function u9(...) -- Line: 109
    -- upvalues: u3 (ref), u5 (ref)
    if u3 == nil then
        u3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
    end;

    u5 = u3.isAlreadyFailedLegacyErrorBoundary;

    return u5(...);
end;

local logCapturedError = require(script.Parent:WaitForChild("ReactFiberErrorLogger")).logCapturedError;
local logComponentSuspended = require(script.Parent:WaitForChild("DebugTracing")).logComponentSuspended;
local markComponentSuspended = require(script.Parent:WaitForChild("SchedulingProfiler")).markComponentSuspended;
local SyncLane = ReactFiberLane.SyncLane;
local NoTimestamp = ReactFiberLane.NoTimestamp;
local includesSomeLane = ReactFiberLane.includesSomeLane;
local mergeLanes = ReactFiberLane.mergeLanes;
local pickArbitraryLane = ReactFiberLane.pickArbitraryLane;

function createRootErrorUpdate(u10, u11, p12, u13)
    -- upvalues: createUpdate (copy), NoTimestamp (copy), CaptureUpdate (copy), Object (copy), logCapturedError (copy)
    local v14 = createUpdate(NoTimestamp, p12);
    v14.tag = CaptureUpdate;
    v14.payload = {
        element = Object.None
    };
    local value = u11.value;

    function v14.callback() -- Line: 144
        -- upvalues: u13 (copy), value (copy), logCapturedError (ref), u10 (copy), u11 (copy)
        if u13 ~= nil then
            u13(value);
        end;

        logCapturedError(u10, u11);
    end;

    return v14;
end;

function createClassErrorUpdate(u15, u16, p17)
    -- upvalues: createUpdate (copy), NoTimestamp (copy), CaptureUpdate (copy), logCapturedError (copy), markFailedErrorBoundaryForHotReloading (copy), u7 (copy), includesSomeLane (copy), SyncLane (copy), console (copy), getComponentName (copy)
    local v18 = createUpdate(NoTimestamp, p17);
    v18.tag = CaptureUpdate;
    local getDerivedStateFromError = u15.type.getDerivedStateFromError;

    if typeof(getDerivedStateFromError) == "function" then
        local value = u16.value;

        function v18.payload() -- Line: 163
            -- upvalues: logCapturedError (ref), u15 (copy), u16 (copy), getDerivedStateFromError (copy), value (copy)
            logCapturedError(u15, u16);

            return getDerivedStateFromError(value);
        end;
    end;

    local stateNode = u15.stateNode;

    if stateNode == nil or typeof(stateNode.componentDidCatch) ~= "function" then
        if _G.__DEV__ then
            function v18.callback() -- Line: 209
                -- upvalues: markFailedErrorBoundaryForHotReloading (ref), u15 (copy)
                markFailedErrorBoundaryForHotReloading(u15);
            end;
        end;

        return v18;
    end;

    function v18.callback() -- Line: 171
        -- upvalues: markFailedErrorBoundaryForHotReloading (ref), u15 (copy), getDerivedStateFromError (copy), u7 (ref), stateNode (copy), logCapturedError (ref), u16 (copy), includesSomeLane (ref), SyncLane (ref), console (ref), getComponentName (ref)
        if _G.__DEV__ then
            markFailedErrorBoundaryForHotReloading(u15);
        end;

        if typeof(getDerivedStateFromError) ~= "function" then
            u7(stateNode);
            logCapturedError(u15, u16);
        end;

        stateNode:componentDidCatch(u16.value, {
            componentStack = u16.stack or ""
        });

        if _G.__DEV__ and (typeof(getDerivedStateFromError) ~= "function" and not includesSomeLane(u15.lanes, SyncLane)) then
            console.error("%s: Error boundaries should implement getDerivedStateFromError(). In that method, return a state update to display an error message or fallback UI.", getComponentName(u15.type) or "Unknown");
        end;
    end;

    return v18;
end;

local function attachPingListener(u19, u20, u21) -- Line: 216
    -- upvalues: u8 (copy)
    local pingCache = u19.pingCache;
    local v22;

    if pingCache == nil then
        v22 = {};
        u19.pingCache = {
            [u20] = v22
        };
        local _ = u19.pingCache;
    else
        v22 = pingCache[u20];

        if v22 == nil then
            v22 = {};
            pingCache[u20] = v22;
        end;
    end;

    if not v22[u21] then
        v22[u21] = true;

        local function v23() -- Line: 244
            -- upvalues: u8 (ref), u19 (copy), u20 (copy), u21 (copy)
            return u8(u19, u20, u21);
        end;

        u20:andThen(v23, v23);
    end;
end;

function throwException(p24, p25, p26, p27, p28, p29, p30)
    -- upvalues: Incomplete (copy), enableDebugTracing (copy), DebugTracingMode (copy), getComponentName (copy), logComponentSuspended (copy), enableSchedulingProfiler (copy), markComponentSuspended (copy), BlockingMode (copy), NoMode (copy), hasSuspenseContext (copy), suspenseStackCursor (copy), InvisibleParentSuspenseContext (copy), SuspenseComponent (copy), shouldCaptureSuspense (copy), DidCapture (copy), ForceUpdateForLegacySuspense (copy), LifecycleEffectMask (copy), ClassComponent (copy), IncompleteClassComponent (copy), createUpdate (copy), NoTimestamp (copy), SyncLane (copy), ForceUpdate (copy), enqueueUpdate (copy), mergeLanes (copy), attachPingListener (copy), ShouldCapture (copy), createCapturedValue (copy), HostRoot (copy), pickArbitraryLane (copy), enqueueCapturedUpdate (copy), NoFlags (copy), u9 (copy)
    p26.flags = bit32.bor(p26.flags, Incomplete);

    if p27 ~= nil and (typeof(p27) == "table" and typeof(p27.andThen) == "function") then
        if _G.__DEV__ and (enableDebugTracing and bit32.band(p26.mode, DebugTracingMode) ~= 0) then
            logComponentSuspended(getComponentName(p26.type) or "Unknown", p27);
        end;

        if enableSchedulingProfiler then
            markComponentSuspended(p26, p27);
        end;

        if bit32.band(p26.mode, BlockingMode) == NoMode then
            local alternate = p26.alternate;

            if alternate then
                p26.updateQueue = alternate.updateQueue;
                p26.memoizedState = alternate.memoizedState;
                p26.lanes = alternate.lanes;
            else
                p26.updateQueue = nil;
                p26.memoizedState = nil;
            end;
        end;

        local v31 = hasSuspenseContext(suspenseStackCursor.current, InvisibleParentSuspenseContext);
        local v32 = p25;

        repeat
            if v32.tag == SuspenseComponent and shouldCaptureSuspense(v32, v31) then
                local updateQueue = v32.updateQueue;

                if updateQueue == nil then
                    v32.updateQueue = {
                        [p27] = true
                    };
                else
                    updateQueue[p27] = true;
                end;

                if bit32.band(v32.mode, BlockingMode) ~= NoMode then
                    attachPingListener(p24, p27, p28);
                    v32.flags = bit32.bor(v32.flags, ShouldCapture);
                    v32.lanes = p28;

                    return;
                end;

                v32.flags = bit32.bor(v32.flags, DidCapture);
                p26.flags = bit32.bor(p26.flags, ForceUpdateForLegacySuspense);
                local flags = p26.flags;
                local bit32_bor_ret = bit32.bor(LifecycleEffectMask, Incomplete);
                local bit32_bnot_ret = bit32.bnot(bit32_bor_ret);
                p26.flags = bit32.band(flags, bit32_bnot_ret);

                if p26.tag == ClassComponent then
                    if p26.alternate == nil then
                        p26.tag = IncompleteClassComponent;
                    else
                        local v33 = createUpdate(NoTimestamp, SyncLane);
                        v33.tag = ForceUpdate;
                        enqueueUpdate(p26, v33);
                    end;
                end;

                p26.lanes = mergeLanes(p26.lanes, SyncLane);

                return;
            end;

            v32 = v32.return_;
        until v32 == nil;

        p27 = (getComponentName(p26.type) or "A React component") .. " suspended while rendering, but no fallback UI was specified.\n\nAdd a <Suspense fallback=...> component higher in the tree to provide a loading indicator or placeholder to display.";
    end;

    p30();
    local v34 = createCapturedValue(p27, p26);

    while p25.tag ~= HostRoot do
        if p25.tag == ClassComponent then
            local type = p25.type;
            local stateNode = p25.stateNode;

            if bit32.band(p25.flags, DidCapture) == NoFlags and (typeof(type.getDerivedStateFromError) == "function" or stateNode ~= nil and (typeof(stateNode.componentDidCatch) == "function" and not u9(stateNode))) then
                p25.flags = bit32.bor(p25.flags, ShouldCapture);
                local v35 = pickArbitraryLane(p28);
                p25.lanes = mergeLanes(p25.lanes, v35);
                enqueueCapturedUpdate(p25, (createClassErrorUpdate(p25, v34, v35)));

                return;
            end;
        end;

        p25 = p25.return_;

        if p25 == nil then
            return;
        end;
    end;

    p25.flags = bit32.bor(p25.flags, ShouldCapture);
    local v36 = pickArbitraryLane(p28);
    p25.lanes = mergeLanes(p25.lanes, v36);
    enqueueCapturedUpdate(p25, (createRootErrorUpdate(p25, v34, v36, p29)));
end;

return {
    throwException = throwException,
    createRootErrorUpdate = createRootErrorUpdate,
    createClassErrorUpdate = createClassErrorUpdate
};