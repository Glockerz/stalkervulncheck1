-- Decompiled with Potassium's decompiler.

local function unimplemented(p1: string) -- Line: 14
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring(p1));
    error("FIXME (roblox): " .. p1 .. " is unimplemented", 2);
end;

local _G___DEV__ = _G.__DEV__;
local _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ = _G.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__;
local _G___COMPAT_WARNINGS__ = _G.__COMPAT_WARNINGS__;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local v2 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Array = v2.Array;
local Object = v2.Object;
local inspect = v2.util.inspect;
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent.Parent:WaitForChild("react"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local v3 = require(script.Parent:WaitForChild("ReactFiberSuspenseContext.new"));
require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"));
local checkPropTypes = require(script.Parent.Parent:WaitForChild("shared")).checkPropTypes;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local FunctionComponent = ReactWorkTags.FunctionComponent;
local ClassComponent = ReactWorkTags.ClassComponent;
local HostRoot = ReactWorkTags.HostRoot;
local HostComponent = ReactWorkTags.HostComponent;
local HostText = ReactWorkTags.HostText;
local HostPortal = ReactWorkTags.HostPortal;
local ForwardRef = ReactWorkTags.ForwardRef;
local Fragment = ReactWorkTags.Fragment;
local Mode = ReactWorkTags.Mode;
local ContextProvider = ReactWorkTags.ContextProvider;
local ContextConsumer = ReactWorkTags.ContextConsumer;
local Profiler = ReactWorkTags.Profiler;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent;
local MemoComponent = ReactWorkTags.MemoComponent;
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent;
local LazyComponent = ReactWorkTags.LazyComponent;
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent;
local OffscreenComponent = ReactWorkTags.OffscreenComponent;
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local NoFlags = ReactFiberFlags.NoFlags;
local StaticMask = ReactFiberFlags.StaticMask;
local PerformedWork = ReactFiberFlags.PerformedWork;
local Placement = ReactFiberFlags.Placement;
local Hydrating = ReactFiberFlags.Hydrating;
local ContentReset = ReactFiberFlags.ContentReset;
local DidCapture = ReactFiberFlags.DidCapture;
local Ref = ReactFiberFlags.Ref;
local Deletion = ReactFiberFlags.Deletion;
local ForceUpdateForLegacySuspense = ReactFiberFlags.ForceUpdateForLegacySuspense;
local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local debugRenderPhaseSideEffectsForStrictMode = ReactFeatureFlags.debugRenderPhaseSideEffectsForStrictMode;
local disableLegacyContext = ReactFeatureFlags.disableLegacyContext;
local disableModulePatternComponents = ReactFeatureFlags.disableModulePatternComponents;
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer;
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing;
local enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer;
local warnAboutDefaultPropsOnFunctionComponents = ReactFeatureFlags.warnAboutDefaultPropsOnFunctionComponents;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
local shallowEqual = require(script.Parent.Parent:WaitForChild("shared")).shallowEqual;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols;
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE;
local _ = ReactSymbols.getIteratorFn;
local u4 = require(script.Parent:WaitForChild("ReactStrictModeWarnings.new"));
local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"));
local getCurrentFiberOwnerNameInDevOrNull = ReactCurrentFiber.getCurrentFiberOwnerNameInDevOrNull;
local setIsRendering = ReactCurrentFiber.setIsRendering;
local v5 = require(script.Parent:WaitForChild("ReactFiberHotReloading.new"));
local resolveFunctionForHotReloading = v5.resolveFunctionForHotReloading;
local resolveForwardRefForHotReloading = v5.resolveForwardRefForHotReloading;
local resolveClassForHotReloading = v5.resolveClassForHotReloading;
local v6 = require(script.Parent:WaitForChild("ReactChildFiber.new"));
local mountChildFibers = v6.mountChildFibers;
local reconcileChildFibers = v6.reconcileChildFibers;
local cloneChildFibers = v6.cloneChildFibers;
local v7 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"));
local processUpdateQueue = v7.processUpdateQueue;
local cloneUpdateQueue = v7.cloneUpdateQueue;
local initializeUpdateQueue = v7.initializeUpdateQueue;
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"));
local ConcurrentMode = ReactTypeOfMode.ConcurrentMode;
local NoMode = ReactTypeOfMode.NoMode;
local ProfileMode = ReactTypeOfMode.ProfileMode;
local StrictMode = ReactTypeOfMode.StrictMode;
local BlockingMode = ReactTypeOfMode.BlockingMode;
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
local shouldSetTextContent = ReactFiberHostConfig.shouldSetTextContent;
local isSuspenseInstancePending = ReactFiberHostConfig.isSuspenseInstancePending;
local isSuspenseInstanceFallback = ReactFiberHostConfig.isSuspenseInstanceFallback;
local registerSuspenseInstanceRetry = ReactFiberHostConfig.registerSuspenseInstanceRetry;
local supportsHydration = ReactFiberHostConfig.supportsHydration;
local v8 = require(script.Parent:WaitForChild("ReactFiberHostContext.new"));
local pushHostContext = v8.pushHostContext;
local pushHostContainer = v8.pushHostContainer;
local suspenseStackCursor = v3.suspenseStackCursor;
local hasSuspenseContext = v3.hasSuspenseContext;
local ForceSuspenseFallback = v3.ForceSuspenseFallback;
local addSubtreeSuspenseContext = v3.addSubtreeSuspenseContext;
local InvisibleParentSuspenseContext = v3.InvisibleParentSuspenseContext;
local pushSuspenseContext = v3.pushSuspenseContext;
local setDefaultShallowSuspenseContext = v3.setDefaultShallowSuspenseContext;
local v9 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"));
local propagateContextChange = v9.propagateContextChange;
local readContext = v9.readContext;
local calculateChangedBits = v9.calculateChangedBits;
local prepareToReadContext = v9.prepareToReadContext;
local pushProvider = v9.pushProvider;
local u10 = {
    renderWithHooksRef = nil,
    bailoutHooksRef = nil,
    shouldSuspendRef = nil
};

local function shouldSuspend(p11) -- Line: 185
    -- upvalues: u10 (copy)
    if not u10.shouldSuspendRef then
        u10.shouldSuspendRef = require(script.Parent:WaitForChild("ReactFiberReconciler")).shouldSuspend;
    end;

    return u10.shouldSuspendRef(p11);
end;

local function initReactFiberHooks() -- Line: 193
    -- upvalues: u10 (copy)
    local v12 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
    u10.renderWithHooksRef = v12.renderWithHooks;
    u10.bailoutHooksRef = v12.bailoutHooks;
end;

local function renderWithHooks(...) -- Line: 200
    -- upvalues: u10 (copy)
    if not u10.renderWithHooksRef then
        local v13 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
        u10.renderWithHooksRef = v13.renderWithHooks;
        u10.bailoutHooksRef = v13.bailoutHooks;
    end;

    return u10.renderWithHooksRef(...);
end;

local function bailoutHooks(...) -- Line: 208
    -- upvalues: u10 (copy)
    if not u10.bailoutHooksRef then
        local v14 = require(script.Parent:WaitForChild("ReactFiberHooks.new"));
        u10.renderWithHooksRef = v14.renderWithHooks;
        u10.bailoutHooksRef = v14.bailoutHooks;
    end;

    return u10.bailoutHooksRef(...);
end;

local stopProfilerTimerIfRunning = require(script.Parent:WaitForChild("ReactProfilerTimer.new")).stopProfilerTimerIfRunning;
local v15 = require(script.Parent:WaitForChild("ReactFiberContext.new"));
local getMaskedContext = v15.getMaskedContext;
local getUnmaskedContext = v15.getUnmaskedContext;
local hasContextChanged = v15.hasContextChanged;
local pushContextProvider = v15.pushContextProvider;
local isContextProvider = v15.isContextProvider;
local pushTopLevelContextObject = v15.pushTopLevelContextObject;
local invalidateContextProvider = v15.invalidateContextProvider;
local v16 = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new"));
local resetHydrationState = v16.resetHydrationState;
local enterHydrationState = v16.enterHydrationState;
local reenterHydrationStateFromDehydratedSuspenseInstance = v16.reenterHydrationStateFromDehydratedSuspenseInstance;
local tryToClaimNextHydratableInstance = v16.tryToClaimNextHydratableInstance;
local warnIfHydrating = v16.warnIfHydrating;
local v17 = require(script.Parent:WaitForChild("ReactFiberClassComponent.new"));
local adoptClassInstance = v17.adoptClassInstance;
local applyDerivedStateFromProps = v17.applyDerivedStateFromProps;
local constructClassInstance = v17.constructClassInstance;
local mountClassInstance = v17.mountClassInstance;
local resumeMountClassInstance = v17.resumeMountClassInstance;
local updateClassInstance = v17.updateClassInstance;
local resolveDefaultProps = require(script.Parent:WaitForChild("ReactFiberLazyComponent.new")).resolveDefaultProps;
local v18 = require(script.Parent:WaitForChild("ReactFiber.new"));
local resolveLazyComponentTag = v18.resolveLazyComponentTag;
local createFiberFromFragment = v18.createFiberFromFragment;
local createFiberFromOffscreen = v18.createFiberFromOffscreen;
local createFiberFromTypeAndProps = v18.createFiberFromTypeAndProps;
local isSimpleFunctionComponent = v18.isSimpleFunctionComponent;
local createWorkInProgress = v18.createWorkInProgress;
local v19 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
local pushRenderLanes = v19.pushRenderLanes;
local markSpawnedWork = v19.markSpawnedWork;
local retryDehydratedSuspenseBoundary = v19.retryDehydratedSuspenseBoundary;
local scheduleUpdateOnFiber = v19.scheduleUpdateOnFiber;
local renderDidSuspendDelayIfPossible = v19.renderDidSuspendDelayIfPossible;
local getWorkInProgressRoot = v19.getWorkInProgressRoot;
local getExecutionContext = v19.getExecutionContext;
local RetryAfterError = v19.RetryAfterError;
local NoContext = v19.NoContext;
local u20 = nil;
local setWorkInProgressVersion = require(script.Parent:WaitForChild("ReactMutableSource.new")).setWorkInProgressVersion;
local markSkippedUpdateLanes = require(script.Parent:WaitForChild("ReactFiberWorkInProgress")).markSkippedUpdateLanes;
local ConsolePatchingDev = require(script.Parent.Parent:WaitForChild("shared")).ConsolePatchingDev;
local disableLogs = ConsolePatchingDev.disableLogs;
local reenableLogs = ConsolePatchingDev.reenableLogs;
local ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner;
local u21 = {};
local u22 = nil;
local u23 = nil;
local u24 = false;
local u25 = {
    didWarnAboutBadClass = {},
    didWarnAboutModulePatternComponent = {},
    didWarnAboutContextTypeOnFunctionComponent = {},
    didWarnAboutGetDerivedStateOnFunctionComponent = {},
    didWarnAboutFunctionRefs = {},
    didWarnAboutDefaultPropsOnFunctionComponent = {}
};
local u26 = nil;

if _G___DEV__ then
    u25.didWarnAboutBadClass = {};
    u25.didWarnAboutModulePatternComponent = {};
    u25.didWarnAboutContextTypeOnFunctionComponent = {};
    u25.didWarnAboutGetDerivedStateOnFunctionComponent = {};
    u25.didWarnAboutFunctionRefs = {};
    u21.didWarnAboutReassigningProps = false;
    u25.didWarnAboutDefaultPropsOnFunctionComponent = {};
end;

local function reconcileChildren(p27, p28, p29, p30) -- Line: 307
    -- upvalues: mountChildFibers (copy), reconcileChildFibers (copy)
    if p27 == nil then
        p28.child = mountChildFibers(p28, nil, p29, p30);

        return;
    end;

    p28.child = reconcileChildFibers(p28, p27.child, p29, p30);
end;

local function forceUnmountCurrentAndReconcile(p31, p32, p33, p34) -- Line: 336
    -- upvalues: reconcileChildFibers (copy)
    p32.child = reconcileChildFibers(p32, p31.child, nil, p34);
    p32.child = reconcileChildFibers(p32, nil, p33, p34);
end;

local function updateForwardRef(p35, p36, p37, p38, p39) -- Line: 360
    -- upvalues: _G___DEV__ (copy), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), prepareToReadContext (copy), u21 (copy), ReactCurrentOwner (copy), setIsRendering (copy), renderWithHooks (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), u24 (ref), bailoutHooks (copy), u22 (ref), PerformedWork (copy), mountChildFibers (copy), reconcileChildFibers (copy)
    if (_G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p36.type ~= p36.elementType then
        local propTypes = p37.propTypes;
        local validateProps = p37.validateProps;

        if propTypes or validateProps then
            checkPropTypes(propTypes, validateProps, p38, "prop", getComponentName(p37));
        end;
    end;

    local render = p37.render;
    local ref = p36.ref;
    prepareToReadContext(p36, p39, u21.markWorkInProgressReceivedUpdate);
    local v40;

    if _G___DEV__ then
        ReactCurrentOwner.current = p36;
        setIsRendering(true);
        v40 = renderWithHooks(p35, p36, render, p38, ref, p39);

        if debugRenderPhaseSideEffectsForStrictMode and bit32.band(p36.mode, StrictMode) ~= 0 then
            disableLogs();
            local v41, v42 = xpcall(renderWithHooks, describeError, p35, p36, render, p38, ref, p39);

            if v41 then
                v40 = v42;
            end;

            reenableLogs();

            if not v41 then
                error(v42);
            end;
        end;

        setIsRendering(false);
    else
        v40 = renderWithHooks(p35, p36, render, p38, ref, p39);
    end;

    if p35 ~= nil and not u24 then
        bailoutHooks(p35, p36, p39);

        return u22(p35, p36, p39);
    end;

    p36.flags = bit32.bor(p36.flags, PerformedWork);

    if p35 == nil then
        p36.child = mountChildFibers(p36, nil, v40, p39);
    else
        p36.child = reconcileChildFibers(p36, p35.child, v40, p39);
    end;

    return p36.child;
end;

local function updateMemoComponent(p43, p44, p45, p46, p47, p48) -- Line: 447
    -- upvalues: isSimpleFunctionComponent (copy), _G___DEV__ (copy), resolveFunctionForHotReloading (copy), SimpleMemoComponent (copy), u26 (ref), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), createFiberFromTypeAndProps (copy), ReactFiberLane (copy), shallowEqual (copy), u22 (ref), PerformedWork (copy), createWorkInProgress (copy)
    if p43 == nil then
        local type2 = p45.type;

        if isSimpleFunctionComponent(type2) and (p45.compare == nil and p45.defaultProps == nil) then
            local v49;

            if _G___DEV__ then
                v49 = resolveFunctionForHotReloading(type2);
            else
                v49 = type2;
            end;

            p44.tag = SimpleMemoComponent;
            p44.type = v49;

            if _G___DEV__ then
                validateFunctionComponentInDev(p44, type2);
            end;

            return u26(p43, p44, v49, p46, p47, p48);
        end;

        if _G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
            local v50, v51;

            if type(type2) == "table" then
                v50 = type2.propTypes;
                v51 = type2.validateProps;
            else
                v50 = nil;
                v51 = nil;
            end;

            if v50 or v51 then
                checkPropTypes(v50, v51, p46, "prop", getComponentName(type2));
            end;
        end;

        local v52 = createFiberFromTypeAndProps(p45.type, nil, p46, p44, p44.mode, p48);
        v52.ref = p44.ref;
        v52.return_ = p44;
        p44.child = v52;

        return v52;
    end;

    if _G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        local type2 = p45.type;
        local v53, v54;

        if type(type2) == "table" then
            v53 = type2.propTypes;
            v54 = type2.validateProps;
        else
            v53 = nil;
            v54 = nil;
        end;

        if v53 or v54 then
            checkPropTypes(v53, v54, p46, "prop", getComponentName(type2));
        end;
    end;

    local child = p43.child;

    if not ReactFiberLane.includesSomeLane(p47, p48) then
        local compare = p45.compare;

        if compare == nil then
            compare = shallowEqual;
        end;

        if compare(child.memoizedProps, p46) and p43.ref == p44.ref then
            return u22(p43, p44, p48);
        end;
    end;

    p44.flags = bit32.bor(p44.flags, PerformedWork);
    local v55 = createWorkInProgress(child, p46);
    v55.ref = p44.ref;
    v55.return_ = p44;
    p44.child = v55;

    return v55;
end;

u26 = function(p56, p57, p58, p59, p60, p61) -- Line: 568, Name: updateSimpleMemoComponent
    -- upvalues: _G___DEV__ (copy), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), REACT_LAZY_TYPE (copy), describeError (copy), checkPropTypes (copy), getComponentName (copy), shallowEqual (copy), u24 (ref), ReactFiberLane (copy), u22 (ref), ForceUpdateForLegacySuspense (copy), NoFlags (copy), u23 (ref)
    if (_G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p57.type ~= p57.elementType then
        local elementType = p57.elementType;

        if elementType["$$typeof"] == REACT_LAZY_TYPE then
            local v62, v63 = xpcall(elementType._init, describeError, elementType._payload);

            if not v62 then
                v63 = nil;
            end;

            local v64, v65;

            if v63 == nil or type(v63) ~= "table" then
                v64 = nil;
                v65 = nil;
            else
                v64 = v63.propTypes;
                v65 = v63.validateProps;
            end;

            if v64 or v65 then
                checkPropTypes(v64, v65, p59, "prop", getComponentName(v63));
            end;
        end;
    end;

    if p56 ~= nil then
        local v66 = not _G___DEV__ and true or p57.type == p56.type;

        if shallowEqual(p56.memoizedProps, p59) and (p56.ref == p57.ref and v66) then
            u24 = false;

            if not ReactFiberLane.includesSomeLane(p61, p60) then
                p57.lanes = p56.lanes;

                return u22(p56, p57, p61);
            end;

            if bit32.band(p56.flags, ForceUpdateForLegacySuspense) ~= NoFlags then
                u24 = true;
            end;
        end;
    end;

    return u23(p56, p57, p58, p59, p61);
end;

local function updateOffscreenComponent(p67, p68, p69) -- Line: 670
    -- upvalues: ConcurrentMode (copy), NoMode (copy), ReactFiberLane (copy), pushRenderLanes (copy), enableSchedulerTracing (copy), markSpawnedWork (copy), mountChildFibers (copy), reconcileChildFibers (copy)
    local pendingProps = p68.pendingProps;
    local children = pendingProps.children;
    local v70;

    if p67 == nil then
        v70 = nil;
    else
        v70 = p67.memoizedState;
    end;

    if pendingProps.mode == "hidden" or pendingProps.mode == "unstable-defer-without-hiding" then
        if bit32.band(p68.mode, ConcurrentMode) == NoMode then
            p68.memoizedState = {
                baseLanes = ReactFiberLane.NoLanes
            };
            pushRenderLanes(p68, p69);
        else
            if not ReactFiberLane.includesSomeLane(p69, ReactFiberLane.OffscreenLane) then
                if v70 ~= nil then
                    p69 = ReactFiberLane.mergeLanes(v70.baseLanes, p69);
                end;

                if enableSchedulerTracing then
                    markSpawnedWork(ReactFiberLane.OffscreenLane);
                end;

                p68.childLanes = ReactFiberLane.laneToLanes(ReactFiberLane.OffscreenLane);
                p68.lanes = p68.childLanes;
                p68.memoizedState = {
                    baseLanes = p69
                };
                pushRenderLanes(p68, p69);

                return nil;
            end;

            p68.memoizedState = {
                baseLanes = ReactFiberLane.NoLanes
            };
            local v71;

            if v70 == nil then
                v71 = p69;
            else
                v71 = v70.baseLanes;
            end;

            pushRenderLanes(p68, v71);
        end;
    else
        local v72;

        if v70 == nil then
            v72 = p69;
        else
            v72 = ReactFiberLane.mergeLanes(v70.baseLanes, p69);
            p68.memoizedState = nil;
        end;

        pushRenderLanes(p68, v72);
    end;

    if p67 == nil then
        p68.child = mountChildFibers(p68, nil, children, p69);
    else
        p68.child = reconcileChildFibers(p68, p67.child, children, p69);
    end;

    return p68.child;
end;

function updateFragment(p73, p74, p75)
    -- upvalues: mountChildFibers (copy), reconcileChildFibers (copy)
    local pendingProps = p74.pendingProps;

    if p73 == nil then
        p74.child = mountChildFibers(p74, nil, pendingProps, p75);
    else
        p74.child = reconcileChildFibers(p74, p73.child, pendingProps, p75);
    end;

    return p74.child;
end;

function updateMode(p76, p77, p78)
    -- upvalues: mountChildFibers (copy), reconcileChildFibers (copy)
    local children = p77.pendingProps.children;

    if p76 == nil then
        p77.child = mountChildFibers(p77, nil, children, p78);
    else
        p77.child = reconcileChildFibers(p77, p76.child, children, p78);
    end;

    return p77.child;
end;

function updateProfiler(p79, p80, p81)
    -- upvalues: enableProfilerTimer (copy), mountChildFibers (copy), reconcileChildFibers (copy)
    if enableProfilerTimer then
        local stateNode = p80.stateNode;
        stateNode.effectDuration = 0;
        stateNode.passiveEffectDuration = 0;
    end;

    local children = p80.pendingProps.children;

    if p79 == nil then
        p80.child = mountChildFibers(p80, nil, children, p81);
    else
        p80.child = reconcileChildFibers(p80, p79.child, children, p81);
    end;

    return p80.child;
end;

local function markRef(p82, p83) -- Line: 798
    -- upvalues: Ref (copy)
    local ref = p83.ref;

    if not ((p82 ~= nil or ref == nil) and (p82 == nil or p82.ref == ref)) then
        p83.flags = bit32.bor(p83.flags, Ref);
    end;
end;

u23 = function(p84, p85, p86, p87, p88) -- Line: 809, Name: updateFunctionComponent
    -- upvalues: _G___DEV__ (copy), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), prepareToReadContext (copy), u21 (copy), ReactCurrentOwner (copy), setIsRendering (copy), renderWithHooks (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), u24 (ref), bailoutHooks (copy), u22 (ref), PerformedWork (copy), mountChildFibers (copy), reconcileChildFibers (copy)
    if (_G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and (type(p86) ~= "function" and p85.type ~= p85.elementType) then
        local v89, v90;

        if type(p86) == "table" then
            v89 = p86.propTypes;
            v90 = p86.validateProps;
        else
            v89 = nil;
            v90 = nil;
        end;

        if v89 or v90 then
            checkPropTypes(v89, v90, p87, "prop", getComponentName(p86));
        end;
    end;

    local v91;

    if disableLegacyContext then
        v91 = nil;
    else
        v91 = getMaskedContext(p85, (getUnmaskedContext(p85, p86, true)));
    end;

    prepareToReadContext(p85, p88, u21.markWorkInProgressReceivedUpdate);
    local v92;

    if _G___DEV__ then
        ReactCurrentOwner.current = p85;
        setIsRendering(true);
        v92 = renderWithHooks(p84, p85, p86, p87, v91, p88);

        if debugRenderPhaseSideEffectsForStrictMode and bit32.band(p85.mode, StrictMode) ~= 0 then
            disableLogs();
            local v93, v94 = xpcall(renderWithHooks, describeError, p84, p85, p86, p87, v91, p88);
            reenableLogs();

            if v93 then
                v92 = v94;
            else
                error(v94);
            end;
        end;

        setIsRendering(false);
    else
        v92 = renderWithHooks(p84, p85, p86, p87, v91, p88);
    end;

    if p84 ~= nil and not u24 then
        bailoutHooks(p84, p85, p88);

        return u22(p84, p85, p88);
    end;

    p85.flags = bit32.bor(p85.flags, PerformedWork);

    if p84 == nil then
        p85.child = mountChildFibers(p85, nil, v92, p88);
    else
        p85.child = reconcileChildFibers(p85, p84.child, v92, p88);
    end;

    return p85.child;
end;

local function updateClassComponent(p95, p96, p97, p98, p99) -- Line: 988
    -- upvalues: _G___DEV__ (copy), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), isContextProvider (copy), pushContextProvider (copy), prepareToReadContext (copy), u21 (copy), Placement (copy), constructClassInstance (copy), mountClassInstance (copy), resumeMountClassInstance (copy), updateClassInstance (copy), console (copy)
    if (_G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p96.type ~= p96.elementType then
        local propTypes = p97.propTypes;
        local validateProps = p97.validateProps;

        if propTypes or validateProps then
            checkPropTypes(propTypes, validateProps, p98, "prop", getComponentName(p97));
        end;
    end;

    local v100;

    if isContextProvider(p97) then
        pushContextProvider(p96);
        v100 = true;
    else
        v100 = false;
    end;

    prepareToReadContext(p96, p99, u21.markWorkInProgressReceivedUpdate);
    local v101;

    if p96.stateNode == nil then
        if p95 ~= nil then
            p95.alternate = nil;
            p96.alternate = nil;
            p96.flags = bit32.bor(p96.flags, Placement);
        end;

        constructClassInstance(p96, p97, p98);
        mountClassInstance(p96, p97, p98, p99);
        v101 = true;
    elseif p95 == nil then
        v101 = resumeMountClassInstance(p96, p97, p98, p99);
    else
        v101 = updateClassInstance(p95, p96, p97, p98, p99);
    end;

    local v102 = finishClassComponent(p95, p96, p97, v101, v100, p99);

    if _G___DEV__ and (v101 and p96.stateNode.props ~= p98) then
        if not u21.didWarnAboutReassigningProps then
            console.error("It looks like %s is reassigning its own `this.props` while rendering. This is not supported and can lead to confusing bugs.", getComponentName(p96.type) or "a component");
        end;

        u21.didWarnAboutReassigningProps = true;
    end;

    return v102;
end;

function finishClassComponent(p103: any, p104: any, p105: any, p106: boolean, p107: boolean, p108: any)
    -- upvalues: Ref (copy), DidCapture (copy), NoFlags (copy), invalidateContextProvider (copy), u22 (ref), ReactCurrentOwner (copy), enableProfilerTimer (copy), stopProfilerTimerIfRunning (copy), _G___DEV__ (copy), setIsRendering (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), PerformedWork (copy), reconcileChildFibers (copy), mountChildFibers (copy)
    local ref = p104.ref;

    if not ((p103 ~= nil or ref == nil) and (p103 == nil or p103.ref == ref)) then
        p104.flags = bit32.bor(p104.flags, Ref);
    end;

    local v109 = bit32.band(p104.flags, DidCapture) ~= NoFlags;

    if not (p106 or v109) then
        if p107 then
            invalidateContextProvider(p104, p105, false);
        end;

        return u22(p103, p104, p108);
    end;

    local stateNode = p104.stateNode;
    ReactCurrentOwner.current = p104;
    local v110;

    if v109 and (p105.getDerivedStateFromError == nil or type(p105.getDerivedStateFromError) ~= "function") then
        v110 = nil;

        if enableProfilerTimer then
            stopProfilerTimerIfRunning(p104);
        end;
    elseif _G___DEV__ then
        setIsRendering(true);
        v110 = stateNode:render();

        if debugRenderPhaseSideEffectsForStrictMode and bit32.band(p104.mode, StrictMode) ~= 0 then
            disableLogs();
            local v111, v112 = xpcall(stateNode.render, describeError, stateNode);
            reenableLogs();

            if not v111 then
                error(v112);
            end;
        end;

        setIsRendering(false);
    else
        v110 = stateNode:render();
    end;

    p104.flags = bit32.bor(p104.flags, PerformedWork);

    if p103 == nil or not v109 then
        if p103 == nil then
            p104.child = mountChildFibers(p104, nil, v110, p108);
        else
            p104.child = reconcileChildFibers(p104, p103.child, v110, p108);
        end;
    else
        p104.child = reconcileChildFibers(p104, p103.child, nil, p108);
        p104.child = reconcileChildFibers(p104, nil, v110, p108);
    end;

    p104.memoizedState = stateNode.state;

    if p107 then
        invalidateContextProvider(p104, p105, true);
    end;

    return p104.child;
end;

local function pushHostRootContext(p113) -- Line: 1183
    -- upvalues: pushTopLevelContextObject (copy), pushHostContainer (copy)
    local stateNode = p113.stateNode;

    if stateNode.pendingContext then
        pushTopLevelContextObject(p113, stateNode.pendingContext, stateNode.pendingContext ~= stateNode.context);
    elseif stateNode.context then
        pushTopLevelContextObject(p113, stateNode.context, false);
    end;

    pushHostContainer(p113, stateNode.containerInfo);
end;

local function updateHostRoot(p114, p115, p116) -- Line: 1199
    -- upvalues: pushTopLevelContextObject (copy), pushHostContainer (copy), invariant (copy), cloneUpdateQueue (copy), processUpdateQueue (copy), resetHydrationState (copy), u22 (ref), enterHydrationState (copy), supportsHydration (copy), setWorkInProgressVersion (copy), mountChildFibers (copy), Placement (copy), Hydrating (copy), reconcileChildFibers (copy)
    local stateNode = p115.stateNode;

    if stateNode.pendingContext then
        pushTopLevelContextObject(p115, stateNode.pendingContext, stateNode.pendingContext ~= stateNode.context);
    elseif stateNode.context then
        pushTopLevelContextObject(p115, stateNode.context, false);
    end;

    pushHostContainer(p115, stateNode.containerInfo);
    local updateQueue = p115.updateQueue;
    local v117;

    if p114 == nil then
        v117 = false;
    else
        v117 = updateQueue ~= nil;
    end;

    invariant(v117, "If the root does not have an updateQueue, we should have already bailed out. This error is likely caused by a bug in React. Please file an issue.");
    local pendingProps = p115.pendingProps;
    local memoizedState = p115.memoizedState;
    local v118;

    if memoizedState == nil then
        v118 = nil;
    else
        v118 = memoizedState.element;
    end;

    cloneUpdateQueue(p114, p115);
    processUpdateQueue(p115, pendingProps, nil, p116);
    local element = p115.memoizedState.element;

    if element == v118 then
        resetHydrationState();

        return u22(p114, p115, p116);
    end;

    local stateNode2 = p115.stateNode;

    if stateNode2.hydrate and enterHydrationState(p115) then
        if supportsHydration then
            local mutableSourceEagerHydrationData = stateNode2.mutableSourceEagerHydrationData;

            if mutableSourceEagerHydrationData ~= nil then
                for i = 1, #mutableSourceEagerHydrationData, 2 do
                    setWorkInProgressVersion(mutableSourceEagerHydrationData[i], mutableSourceEagerHydrationData[i + 1]);
                    local _ = i;
                end;
            end;
        end;

        local v119 = mountChildFibers(p115, nil, element, p116);
        p115.child = v119;

        while v119 do
            local flags = v119.flags;
            local bit32_bnot_ret = bit32.bnot(Placement);
            local bit32_band_ret = bit32.band(flags, bit32_bnot_ret);
            v119.flags = bit32.bor(bit32_band_ret, Hydrating);
            v119 = v119.sibling;
        end;
    else
        if p114 == nil then
            p115.child = mountChildFibers(p115, nil, element, p116);
        else
            p115.child = reconcileChildFibers(p115, p114.child, element, p116);
        end;

        resetHydrationState();
    end;

    return p115.child;
end;

local function updateHostComponent(p120, p121, p122) -- Line: 1276
    -- upvalues: pushHostContext (copy), tryToClaimNextHydratableInstance (copy), shouldSetTextContent (copy), ContentReset (copy), PerformedWork (copy), Ref (copy), mountChildFibers (copy), reconcileChildFibers (copy)
    pushHostContext(p121);

    if p120 == nil then
        tryToClaimNextHydratableInstance(p121);
    end;

    local type2 = p121.type;
    local pendingProps = p121.pendingProps;
    local v123;

    if p120 == nil then
        v123 = nil;
    else
        v123 = p120.memoizedProps;
    end;

    local children = pendingProps.children;

    if shouldSetTextContent(type2, pendingProps) then
        children = nil;
    elseif v123 ~= nil and shouldSetTextContent(type2, v123) then
        p121.flags = bit32.bor(p121.flags, ContentReset);
    end;

    p121.flags = bit32.bor(p121.flags, PerformedWork);
    local ref = p121.ref;

    if not ((p120 ~= nil or ref == nil) and (p120 == nil or p120.ref == ref)) then
        p121.flags = bit32.bor(p121.flags, Ref);
    end;

    if p120 == nil then
        p121.child = mountChildFibers(p121, nil, children, p122);
    else
        p121.child = reconcileChildFibers(p121, p120.child, children, p122);
    end;

    return p121.child;
end;

local function updateHostText(p124, p125) -- Line: 1317
    -- upvalues: tryToClaimNextHydratableInstance (copy)
    if p124 == nil then
        tryToClaimNextHydratableInstance(p125);
    end;

    return nil;
end;

local function mountLazyComponent(p126, p127, p128, p129, p130) -- Line: 1326
    -- upvalues: Placement (copy), resolveLazyComponentTag (copy), resolveDefaultProps (copy), FunctionComponent (copy), _G___DEV__ (copy), resolveFunctionForHotReloading (copy), u23 (ref), ClassComponent (copy), resolveClassForHotReloading (copy), updateClassComponent (copy), ForwardRef (copy), resolveForwardRefForHotReloading (copy), updateForwardRef (copy), MemoComponent (copy), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), updateMemoComponent (copy), REACT_LAZY_TYPE (copy), inspect (copy), invariant (copy)
    if p126 ~= nil then
        p126.alternate = nil;
        p127.alternate = nil;
        p127.flags = bit32.bor(p127.flags, Placement);
    end;

    local pendingProps = p127.pendingProps;
    local v131 = p128._init(p128._payload);
    p127.type = v131;
    p127.tag = resolveLazyComponentTag(v131);
    local tag = p127.tag;
    local v132 = resolveDefaultProps(v131, pendingProps);

    if tag == FunctionComponent then
        if _G___DEV__ then
            validateFunctionComponentInDev(p127, v131);
            v131 = resolveFunctionForHotReloading(v131);
            p127.type = v131;
        end;

        return u23(nil, p127, v131, v132, p130);
    end;

    if tag == ClassComponent then
        if _G___DEV__ then
            v131 = resolveClassForHotReloading(v131);
            p127.type = v131;
        end;

        return updateClassComponent(nil, p127, v131, v132, p130);
    end;

    if tag == ForwardRef then
        if _G___DEV__ then
            v131 = resolveForwardRefForHotReloading(v131);
            p127.type = v131;
        end;

        return updateForwardRef(nil, p127, v131, v132, p130);
    end;

    if tag == MemoComponent then
        if (_G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p127.type ~= p127.elementType then
            local propTypes = v131.propTypes;
            local validateProps = v131.validateProps;

            if propTypes or validateProps then
                checkPropTypes(propTypes, validateProps, v132, "prop", getComponentName(v131));
            end;
        end;

        return updateMemoComponent(nil, p127, v131, resolveDefaultProps(v131.type, v132), p129, p130);
    end;

    local v133 = "";

    if _G___DEV__ then
        if v131 == nil or (type(v131) ~= "table" or v131["$$typeof"] ~= REACT_LAZY_TYPE) then
            if type(v131) == "table" and v131["$$typeof"] == nil then
                v133 = "\n" .. inspect(v131);
            end;
        else
            v133 = " Did you wrap a component in React.lazy() more than once?";
        end;
    end;

    invariant(false, "Element type is invalid. Received a promise that resolves to: %s. Lazy element type must resolve to a class or function.%s", tostring(v131), v133);

    return nil;
end;

function mountIncompleteClassComponent(p134, p135, p136, p137, p138)
    -- upvalues: Placement (copy), ClassComponent (copy), isContextProvider (copy), pushContextProvider (copy), prepareToReadContext (copy), u21 (copy), constructClassInstance (copy), mountClassInstance (copy)
    if p134 ~= nil then
        p134.alternate = nil;
        p135.alternate = nil;
        p135.flags = bit32.bor(p135.flags, Placement);
    end;

    p135.tag = ClassComponent;
    local v139;

    if isContextProvider(p136) then
        pushContextProvider(p135);
        v139 = true;
    else
        v139 = false;
    end;

    prepareToReadContext(p135, p138, u21.markWorkInProgressReceivedUpdate);
    constructClassInstance(p135, p136, p137);
    mountClassInstance(p135, p136, p137, p138);

    return finishClassComponent(nil, p135, p136, true, v139, p138);
end;

local function mountIndeterminateComponent(p140, p141, p142, p143) -- Line: 1509
    -- upvalues: Placement (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), prepareToReadContext (copy), u21 (copy), _G___DEV__ (copy), getComponentName (copy), u25 (copy), console (copy), StrictMode (copy), u4 (copy), setIsRendering (copy), ReactCurrentOwner (copy), renderWithHooks (copy), PerformedWork (copy), disableModulePatternComponents (copy), ClassComponent (copy), isContextProvider (copy), pushContextProvider (copy), initializeUpdateQueue (copy), applyDerivedStateFromProps (copy), adoptClassInstance (copy), mountClassInstance (copy), FunctionComponent (copy), debugRenderPhaseSideEffectsForStrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), mountChildFibers (copy)
    if p140 ~= nil then
        p140.alternate = nil;
        p141.alternate = nil;
        p141.flags = bit32.bor(p141.flags, Placement);
    end;

    local pendingProps = p141.pendingProps;
    local v144;

    if disableLegacyContext then
        v144 = nil;
    else
        v144 = getMaskedContext(p141, (getUnmaskedContext(p141, p142, false)));
    end;

    prepareToReadContext(p141, p143, u21.markWorkInProgressReceivedUpdate);
    local v145;

    if _G___DEV__ then
        if type(p142) == "table" and type(p142.render) == "function" then
            local v146 = getComponentName(p142) or "Unknown";

            if not u25.didWarnAboutBadClass[v146] then
                console.error("The <%s /> component appears to have a render method, but doesn\'t extend React.Component. This is likely to cause errors. Change %s to extend React.Component instead.", v146, v146);
                u25.didWarnAboutBadClass[v146] = true;
            end;
        end;

        if bit32.band(p141.mode, StrictMode) ~= 0 then
            u4.recordLegacyContextWarning(p141);
        end;

        setIsRendering(true);
        ReactCurrentOwner.current = p141;
        v145 = renderWithHooks(nil, p141, p142, pendingProps, v144, p143);
        setIsRendering(false);
    else
        v145 = renderWithHooks(nil, p141, p142, pendingProps, v144, p143);
    end;

    p141.flags = bit32.bor(p141.flags, PerformedWork);
    local v147 = type(v145);

    if _G___DEV__ and (v145 ~= nil and (v147 == "table" and (type(v145.render) == "function" and v145["$$typeof"] == nil))) then
        local v148 = getComponentName(p142) or "Unknown";

        if not u25.didWarnAboutModulePatternComponent[v148] then
            console.error("The <%s /> component appears to be a function component that returns a class instance. Change %s to a class that extends React.Component instead. ", v148, v148);
            u25.didWarnAboutModulePatternComponent[v148] = true;
        end;
    end;

    if disableModulePatternComponents or (v145 == nil or (v147 ~= "table" or (type(v145.render) ~= "function" or v145["$$typeof"] ~= nil))) then
        p141.tag = FunctionComponent;

        if _G___DEV__ then
            if disableLegacyContext and p142.contextTypes then
                console.error("%s uses the legacy contextTypes API which is no longer supported. Use React.createContext() with React.useContext() instead.", getComponentName(p142) or "Unknown");
            end;

            if debugRenderPhaseSideEffectsForStrictMode and bit32.band(p141.mode, StrictMode) ~= 0 then
                disableLogs();
                local v149, v150 = xpcall(renderWithHooks, describeError, nil, p141, p142, pendingProps, v144, p143);
                reenableLogs();

                if v149 then
                    v145 = v150;
                else
                    error(v150);
                end;
            end;
        end;

        p141.child = mountChildFibers(p141, nil, v145, p143);

        if _G___DEV__ then
            validateFunctionComponentInDev(p141, p142);
        end;

        return p141.child;
    end;

    if _G___DEV__ then
        local v151 = getComponentName(p142) or "Unknown";

        if not u25.didWarnAboutModulePatternComponent[v151] then
            console.error("The <%s /> component appears to be a function component that returns a class instance. " .. "Change %s to a class that extends React.Component instead. " .. v151, v151);
            u25.didWarnAboutModulePatternComponent[v151] = true;
        end;
    end;

    p141.tag = ClassComponent;
    p141.memoizedState = nil;
    p141.updateQueue = nil;
    local v152;

    if isContextProvider(p142) then
        pushContextProvider(p141);
        v152 = true;
    else
        v152 = false;
    end;

    p141.memoizedState = v145.state;
    initializeUpdateQueue(p141);
    local v153;

    if type(p142) == "function" then
        v153 = nil;
    else
        v153 = p142.getDerivedStateFromProps;
    end;

    if v153 ~= nil and type(v153) == "function" then
        applyDerivedStateFromProps(p141, p142, v153, pendingProps);
    end;

    adoptClassInstance(p141, v145);
    mountClassInstance(p141, p142, pendingProps, p143);

    return finishClassComponent(nil, p141, p142, true, v152, p143);
end;

function validateFunctionComponentInDev(p154, p155)
    -- upvalues: _G___DEV__ (copy), getCurrentFiberOwnerNameInDevOrNull (copy), u25 (copy), console (copy), warnAboutDefaultPropsOnFunctionComponents (copy), getComponentName (copy)
    if _G___DEV__ then
        if p154.ref ~= nil then
            local v156 = "";
            local v157 = getCurrentFiberOwnerNameInDevOrNull();

            if v157 then
                v156 = v156 .. "\n\nCheck the render method of `" .. v157 .. "`.";
            end;

            local v158 = v157 or (p154._debugID or "");
            local _debugSource = p154._debugSource;

            if _debugSource then
                v158 = _debugSource.fileName .. ":" .. _debugSource.lineNumber;
            end;

            if not u25.didWarnAboutFunctionRefs[v158] then
                u25.didWarnAboutFunctionRefs[v158] = true;
                console.error("Function components cannot be given refs. Attempts to access this ref will fail. Did you mean to use React.forwardRef()?%s", v156);
            end;
        end;

        if warnAboutDefaultPropsOnFunctionComponents and (type(p155) ~= "function" and p155.defaultProps ~= nil) then
            local v159 = getComponentName(p155) or "Unknown";

            if not u25.didWarnAboutDefaultPropsOnFunctionComponent[v159] then
                console.error("%s: Support for defaultProps will be removed from function components in a future major release.", v159);
                u25.didWarnAboutDefaultPropsOnFunctionComponent[v159] = true;
            end;
        end;

        if type(p155) ~= "function" and (p155.getDerivedStateFromProps ~= nil and type(p155.getDerivedStateFromProps) == "function") then
            local v160 = getComponentName(p155) or "Unknown";

            if not u25.didWarnAboutGetDerivedStateOnFunctionComponent[v160] then
                console.error("%s: Function components do not support getDerivedStateFromProps.", v160);
                u25.didWarnAboutGetDerivedStateOnFunctionComponent[v160] = true;
            end;
        end;

        if type(p155) ~= "function" and (p155.contextType ~= nil and type(p155.contextType) == "table") then
            local v161 = getComponentName(p155) or "Unknown";

            if not u25.didWarnAboutContextTypeOnFunctionComponent[v161] then
                console.error("%s: Function components do not support contextType.", v161);
                u25.didWarnAboutContextTypeOnFunctionComponent[v161] = true;
            end;
        end;
    end;
end;

local u162 = {
    dehydrated = nil,
    retryLane = ReactFiberLane.NoLane
};

local function mountSuspenseOffscreenState(p163) -- Line: 1823
    return {
        baseLanes = p163
    };
end;

local function updateSuspenseOffscreenState(p164, p165) -- Line: 1829
    -- upvalues: ReactFiberLane (copy)
    return {
        baseLanes = ReactFiberLane.mergeLanes(p164.baseLanes, p165)
    };
end;

local function shouldRemainOnFallback(p166, p167, p168, p169) -- Line: 1839
    -- upvalues: hasSuspenseContext (copy), ForceSuspenseFallback (copy)
    if p167 == nil or p167.memoizedState ~= nil then
        return hasSuspenseContext(p166, ForceSuspenseFallback);
    end;

    return false;
end;

local function getRemainingWorkInPrimaryTree(p170, p171) -- Line: 1863
    -- upvalues: ReactFiberLane (copy)
    return ReactFiberLane.removeLanes(p170.childLanes, p171);
end;

local u172 = nil;
local u173 = nil;
local u174 = nil;
local u175 = nil;
local u176 = nil;

local function updateSuspenseComponent(p177, p178, p179) -- Line: 1875
    -- upvalues: _G___DEV__ (copy), u10 (copy), DidCapture (copy), suspenseStackCursor (copy), NoFlags (copy), hasSuspenseContext (copy), ForceSuspenseFallback (copy), addSubtreeSuspenseContext (copy), InvisibleParentSuspenseContext (copy), setDefaultShallowSuspenseContext (copy), pushSuspenseContext (copy), tryToClaimNextHydratableInstance (copy), enableSuspenseServerRenderer (copy), u173 (ref), u162 (copy), ReactFiberLane (copy), enableSchedulerTracing (copy), markSpawnedWork (copy), u174 (ref), u176 (ref), u175 (ref), u172 (ref)
    local pendingProps = p178.pendingProps;

    if _G___DEV__ then
        if not u10.shouldSuspendRef then
            u10.shouldSuspendRef = require(script.Parent:WaitForChild("ReactFiberReconciler")).shouldSuspend;
        end;

        if u10.shouldSuspendRef(p178) then
            p178.flags = bit32.bor(p178.flags, DidCapture);
        end;
    end;

    local current = suspenseStackCursor.current;
    local v180 = false;
    local v181 = bit32.band(p178.flags, DidCapture) ~= NoFlags;
    local v182, v183;

    if v181 then
        v182 = p178.flags;
        v183 = bit32.bnot(DidCapture);
        p178.flags = bit32.band(v182, v183);
        v180 = true;
    else
        local v184;

        if p177 == nil or p177.memoizedState ~= nil then
            v184 = hasSuspenseContext(current, ForceSuspenseFallback);
        else
            v184 = false;
        end;

        if v184 then
            v182 = p178.flags;
            v183 = bit32.bnot(DidCapture);
            p178.flags = bit32.band(v182, v183);
            v180 = true;
        elseif not (p177 ~= nil and p177.memoizedState == nil or (pendingProps.fallback == nil or pendingProps.unstable_avoidThisFallback == true)) then
            current = addSubtreeSuspenseContext(current, InvisibleParentSuspenseContext);
        end;
    end;

    pushSuspenseContext(p178, (setDefaultShallowSuspenseContext(current)));

    if p177 == nil then
        if pendingProps.fallback ~= nil then
            tryToClaimNextHydratableInstance(p178);

            if enableSuspenseServerRenderer then
                local memoizedState = p178.memoizedState;

                if memoizedState ~= nil then
                    local dehydrated = memoizedState.dehydrated;

                    if dehydrated ~= nil then
                        return u173(p178, dehydrated, p179);
                    end;
                end;
            end;
        end;

        local children = pendingProps.children;
        local fallback = pendingProps.fallback;

        if v180 then
            local v185 = mountSuspenseFallbackChildren(p178, children, fallback, p179);
            p178.child.memoizedState = {
                baseLanes = p179
            };
            p178.memoizedState = u162;

            return v185;
        end;

        if pendingProps.unstable_expectedLoadTime == nil or type(pendingProps.unstable_expectedLoadTime) ~= "number" then
            return u174(p178, children, p179);
        end;

        local v186 = mountSuspenseFallbackChildren(p178, children, fallback, p179);
        p178.child.memoizedState = {
            baseLanes = p179
        };
        p178.memoizedState = u162;
        p178.lanes = ReactFiberLane.SomeRetryLane;

        if enableSchedulerTracing then
            markSpawnedWork(ReactFiberLane.SomeRetryLane);
        end;

        return v186;
    end;

    local memoizedState = p177.memoizedState;

    if memoizedState == nil then
        if not v180 then
            local v187 = u172(p177, p178, pendingProps.children, p179);
            p178.memoizedState = nil;

            return v187;
        end;

        local v188 = u175(p177, p178, pendingProps.children, pendingProps.fallback, p179);
        local child = p178.child;
        local memoizedState2 = p177.child.memoizedState;

        if memoizedState2 == nil then
            child.memoizedState = {
                baseLanes = p179
            };
        else
            child.memoizedState = {
                baseLanes = ReactFiberLane.mergeLanes(memoizedState2.baseLanes, p179)
            };
        end;

        child.childLanes = ReactFiberLane.removeLanes(p177.childLanes, p179);
        p178.memoizedState = u162;

        return v188;
    end;

    if enableSuspenseServerRenderer then
        local dehydrated = memoizedState.dehydrated;

        if dehydrated ~= nil then
            if not v181 then
                return u176(p177, p178, dehydrated, memoizedState, p179);
            end;

            if p178.memoizedState ~= nil then
                p178.child = p177.child;
                p178.flags = bit32.bor(p178.flags, DidCapture);

                return nil;
            end;

            local v189 = mountSuspenseFallbackAfterRetryWithoutHydrating(p177, p178, pendingProps.children, pendingProps.fallback, p179);
            p178.child.memoizedState = {
                baseLanes = p179
            };
            p178.memoizedState = u162;

            return v189;
        end;
    end;

    if not v180 then
        local v190 = u172(p177, p178, pendingProps.children, p179);
        p178.memoizedState = nil;

        return v190;
    end;

    local v191 = u175(p177, p178, pendingProps.children, pendingProps.fallback, p179);
    local child = p178.child;
    local memoizedState2 = p177.child.memoizedState;

    if memoizedState2 == nil then
        child.memoizedState = {
            baseLanes = p179
        };
    else
        child.memoizedState = {
            baseLanes = ReactFiberLane.mergeLanes(memoizedState2.baseLanes, p179)
        };
    end;

    child.childLanes = ReactFiberLane.removeLanes(p177.childLanes, p179);
    p178.memoizedState = u162;

    return v191;
end;

u174 = function(p192, p193, p194) -- Line: 2160, Name: mountSuspensePrimaryChildren
    -- upvalues: createFiberFromOffscreen (copy)
    local v195 = createFiberFromOffscreen({
        mode = "visible",
        children = p193
    }, p192.mode, p194, nil);
    v195.return_ = p192;
    p192.child = v195;

    return v195;
end;

function mountSuspenseFallbackChildren(p196, p197, p198, p199)
    -- upvalues: BlockingMode (copy), NoMode (copy), ReactFiberLane (copy), enableProfilerTimer (copy), ProfileMode (copy), createFiberFromFragment (copy), createFiberFromOffscreen (copy)
    local mode = p196.mode;
    local child = p196.child;
    local v200 = {
        mode = "hidden",
        children = p197
    };
    local v201;

    if bit32.band(mode, BlockingMode) == NoMode and child ~= nil then
        child.childLanes = ReactFiberLane.NoLanes;
        child.pendingProps = v200;

        if enableProfilerTimer and bit32.band(p196.mode, ProfileMode) ~= 0 then
            child.actualDuration = 0;
            child.actualStartTime = -1;
            child.selfBaseDuration = 0;
            child.treeBaseDuration = 0;
        end;

        v201 = createFiberFromFragment(p198, mode, p199, nil);
    else
        child = createFiberFromOffscreen(v200, mode, ReactFiberLane.NoLanes, nil);
        v201 = createFiberFromFragment(p198, mode, p199, nil);
    end;

    child.return_ = p196;
    v201.return_ = p196;
    child.sibling = v201;
    p196.child = child;

    return v201;
end;

local function createWorkInProgressOffscreenFiber(p202, p203) -- Line: 2223
    -- upvalues: createWorkInProgress (copy)
    return createWorkInProgress(p202, p203);
end;

u172 = function(p204, p205, p206, p207) -- Line: 2232, Name: updateSuspensePrimaryChildren
    -- upvalues: createWorkInProgress (copy), BlockingMode (copy), NoMode (copy), Deletion (copy)
    local child = p204.child;
    local sibling = child.sibling;
    local v208 = createWorkInProgress(child, {
        mode = "visible",
        children = p206
    });

    if bit32.band(p205.mode, BlockingMode) == NoMode then
        v208.lanes = p207;
    end;

    v208.return_ = p205;
    v208.sibling = nil;

    if sibling ~= nil then
        local deletions = p205.deletions;

        if deletions == nil then
            p205.deletions = { sibling };
            p205.flags = bit32.bor(p205.flags, Deletion);
        else
            table.insert(deletions, sibling);
        end;
    end;

    p205.child = v208;

    return v208;
end;

u175 = function(p209, p210, p211, p212, p213) -- Line: 2267, Name: updateSuspenseFallbackChildren
    -- upvalues: BlockingMode (copy), NoMode (copy), ReactFiberLane (copy), enableProfilerTimer (copy), ProfileMode (copy), createWorkInProgress (copy), StaticMask (copy), createFiberFromFragment (copy), Placement (copy)
    local mode = p210.mode;
    local child = p209.child;
    local sibling = child.sibling;
    local v214 = {
        mode = "hidden",
        children = p211
    };
    local v215;

    if bit32.band(mode, BlockingMode) == NoMode and p210.child ~= child then
        v215 = p210.child;
        v215.childLanes = ReactFiberLane.NoLanes;
        v215.pendingProps = v214;

        if enableProfilerTimer and bit32.band(p210.mode, ProfileMode) ~= 0 then
            v215.actualDuration = 0;
            v215.actualStartTime = -1;
            v215.selfBaseDuration = child.selfBaseDuration;
            v215.treeBaseDuration = child.treeBaseDuration;
        end;

        p210.deletions = nil;
    else
        v215 = createWorkInProgress(child, v214);
        v215.subtreeFlags = bit32.band(child.subtreeFlags, StaticMask);
    end;

    local v216;

    if sibling == nil then
        v216 = createFiberFromFragment(p212, mode, p213, nil);
        v216.flags = bit32.bor(v216.flags, Placement);
    else
        v216 = createWorkInProgress(sibling, p212);
    end;

    v216.return_ = p210;
    v215.return_ = p210;
    v215.sibling = v216;
    p210.child = v215;

    return v216;
end;

local function retrySuspenseComponentWithoutHydrating(p217, p218, p219) -- Line: 2350
    -- upvalues: reconcileChildFibers (copy), u174 (ref), Placement (copy)
    reconcileChildFibers(p218, p217.child, nil, p219);
    local v220 = u174(p218, p218.pendingProps.children, p219);
    v220.flags = bit32.bor(v220.flags, Placement);
    p218.memoizedState = nil;

    return v220;
end;

function mountSuspenseFallbackAfterRetryWithoutHydrating(p221, p222, p223, p224, p225)
    -- upvalues: createFiberFromOffscreen (copy), ReactFiberLane (copy), createFiberFromFragment (copy), Placement (copy), BlockingMode (copy), NoMode (copy), reconcileChildFibers (copy)
    local mode = p222.mode;
    local v226 = createFiberFromOffscreen(p223, mode, ReactFiberLane.NoLanes, nil);
    local v227 = createFiberFromFragment(p224, mode, p225, nil);
    v227.flags = bit32.bor(v227.flags, Placement);
    v226.return_ = p222;
    v227.return_ = p222;
    v226.sibling = v227;
    p222.child = v226;

    if bit32.band(p222.mode, BlockingMode) ~= NoMode then
        reconcileChildFibers(p222, p221.child, nil, p225);
    end;

    return v227;
end;

u173 = function(p228, p229, p230) -- Line: 2401, Name: mountDehydratedSuspenseComponent
    -- upvalues: BlockingMode (copy), NoMode (copy), _G___DEV__ (copy), console (copy), ReactFiberLane (copy), isSuspenseInstanceFallback (copy), enableSchedulerTracing (copy), markSpawnedWork (copy)
    if bit32.band(p228.mode, BlockingMode) == NoMode then
        if _G___DEV__ then
            console.error("Cannot hydrate Suspense in legacy mode. Switch fromReactDOM.hydrate(element, container) to ReactDOM.createBlockingRoot(container, { hydrate: true }).render(element) or remove the Suspense componentsthe server rendered components.");
        end;

        p228.lanes = ReactFiberLane.laneToLanes(ReactFiberLane.SyncLane);
    elseif isSuspenseInstanceFallback(p229) then
        if enableSchedulerTracing then
            markSpawnedWork(ReactFiberLane.DefaultHydrationLane);
        end;

        p228.lanes = ReactFiberLane.laneToLanes(ReactFiberLane.DefaultHydrationLane);
    else
        p228.lanes = ReactFiberLane.laneToLanes(ReactFiberLane.OffscreenLane);

        if enableSchedulerTracing then
            markSpawnedWork(ReactFiberLane.OffscreenLane);
        end;
    end;

    return nil;
end;

u176 = function(u231, p232, p233, p234, p235) -- Line: 2448, Name: updateDehydratedSuspenseComponent
    -- upvalues: warnIfHydrating (copy), getExecutionContext (copy), RetryAfterError (copy), NoContext (copy), reconcileChildFibers (copy), u174 (ref), Placement (copy), BlockingMode (copy), NoMode (copy), isSuspenseInstanceFallback (copy), ReactFiberLane (copy), u24 (ref), getWorkInProgressRoot (copy), scheduleUpdateOnFiber (copy), renderDidSuspendDelayIfPossible (copy), isSuspenseInstancePending (copy), DidCapture (copy), retryDehydratedSuspenseBoundary (copy), enableSchedulerTracing (copy), u20 (ref), registerSuspenseInstanceRetry (copy), reenterHydrationStateFromDehydratedSuspenseInstance (copy), Hydrating (copy)
    warnIfHydrating();
    local v236 = getExecutionContext();

    if bit32.band(v236, RetryAfterError) ~= NoContext then
        reconcileChildFibers(p232, u231.child, nil, p235);
        local v237 = u174(p232, p232.pendingProps.children, p235);
        v237.flags = bit32.bor(v237.flags, Placement);
        p232.memoizedState = nil;

        return v237;
    end;

    if bit32.band(p232.mode, BlockingMode) == NoMode then
        reconcileChildFibers(p232, u231.child, nil, p235);
        local v238 = u174(p232, p232.pendingProps.children, p235);
        v238.flags = bit32.bor(v238.flags, Placement);
        p232.memoizedState = nil;

        return v238;
    end;

    if isSuspenseInstanceFallback(p233) then
        reconcileChildFibers(p232, u231.child, nil, p235);
        local v239 = u174(p232, p232.pendingProps.children, p235);
        v239.flags = bit32.bor(v239.flags, Placement);
        p232.memoizedState = nil;

        return v239;
    end;

    if not (u24 or ReactFiberLane.includesSomeLane(p235, u231.childLanes)) then
        if not isSuspenseInstancePending(p233) then
            reenterHydrationStateFromDehydratedSuspenseInstance(p232, p233);
            local v240 = u174(p232, p232.pendingProps.children, p235);
            v240.flags = bit32.bor(v240.flags, Hydrating);

            return v240;
        end;

        p232.flags = bit32.bor(p232.flags, DidCapture);
        p232.child = u231.child;

        local function v241() -- Line: 2544
            -- upvalues: retryDehydratedSuspenseBoundary (ref), u231 (copy)
            return retryDehydratedSuspenseBoundary(u231);
        end;

        if enableSchedulerTracing then
            if u20 == nil then
                u20 = require(script.Parent.Parent:WaitForChild("scheduler")).tracing.unstable_wrap;
            end;

            v241 = u20(v241);
        end;

        registerSuspenseInstanceRetry(p233, v241);

        return nil;
    end;

    local v242 = getWorkInProgressRoot();

    if v242 ~= nil then
        local BumpedLaneForHydration = ReactFiberLane.getBumpedLaneForHydration(v242, p235);

        if BumpedLaneForHydration ~= ReactFiberLane.NoLane and BumpedLaneForHydration ~= p234.retryLane then
            p234.retryLane = BumpedLaneForHydration;
            scheduleUpdateOnFiber(u231, BumpedLaneForHydration, ReactFiberLane.NoTimestamp);
        end;
    end;

    renderDidSuspendDelayIfPossible();
    reconcileChildFibers(p232, u231.child, nil, p235);
    local v243 = u174(p232, p232.pendingProps.children, p235);
    v243.flags = bit32.bor(v243.flags, Placement);
    p232.memoizedState = nil;

    return v243;
end;

function updatePortalComponent(p244, p245, p246)
    -- upvalues: pushHostContainer (copy), reconcileChildFibers (copy), mountChildFibers (copy)
    pushHostContainer(p245, p245.stateNode.containerInfo);
    local pendingProps = p245.pendingProps;

    if p244 == nil then
        p245.child = reconcileChildFibers(p245, nil, pendingProps, p246);
    elseif p244 == nil then
        p245.child = mountChildFibers(p245, nil, pendingProps, p246);
    else
        p245.child = reconcileChildFibers(p245, p244.child, pendingProps, p246);
    end;

    return p245.child;
end;

local u247 = false;

local function updateContextProvider(p248, p249, p250) -- Line: 2981
    -- upvalues: _G___DEV__ (copy), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), Array (copy), Object (copy), u247 (ref), console (copy), checkPropTypes (copy), pushProvider (copy), calculateChangedBits (copy), hasContextChanged (copy), u22 (ref), propagateContextChange (copy), mountChildFibers (copy), reconcileChildFibers (copy)
    local _context = p249.type._context;
    local pendingProps = p249.pendingProps;
    local memoizedProps = p249.memoizedProps;
    local value = pendingProps.value;

    if _G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        if Array.indexOf(Object.keys(pendingProps), "value") < 1 and not u247 then
            u247 = true;
            console.error("The `value` prop is required for the `<Context.Provider>`. Did you misspell it or forget to pass it?");
        end;

        local propTypes = p249.type.propTypes;
        local validateProps = p249.type.validateProps;

        if propTypes or validateProps then
            checkPropTypes(propTypes, validateProps, pendingProps, "prop", "Context.Provider");
        end;
    end;

    pushProvider(p249, value);

    if memoizedProps ~= nil then
        local v251 = calculateChangedBits(_context, value, memoizedProps.value);

        if v251 == 0 then
            if memoizedProps.children == pendingProps.children and not hasContextChanged() then
                return u22(p248, p249, p250);
            end;
        else
            propagateContextChange(p249, _context, v251, p250);
        end;
    end;

    local children = pendingProps.children;

    if p248 == nil then
        p249.child = mountChildFibers(p249, nil, children, p250);
    else
        p249.child = reconcileChildFibers(p249, p248.child, children, p250);
    end;

    return p249.child;
end;

local u252 = {
    usingContextAsConsumer = false,
    usingLegacyConsumer = false
};

function updateContextConsumer(p253, p254, p255)
    -- upvalues: _G___DEV__ (copy), u252 (copy), console (copy), _G___COMPAT_WARNINGS__ (copy), prepareToReadContext (copy), u21 (copy), readContext (copy), ReactCurrentOwner (copy), setIsRendering (copy), PerformedWork (copy), mountChildFibers (copy), reconcileChildFibers (copy)
    local type2 = p254.type;

    if _G___DEV__ then
        if type2._context == nil then
            if type2 ~= type2.Consumer and not u252.usingContextAsConsumer then
                u252.usingContextAsConsumer = true;
                console.error("Rendering <Context> directly is not supported and will be removed in a future major release. Did you mean to render <Context.Consumer> instead?");
            end;
        else
            type2 = type2._context;
        end;
    end;

    local pendingProps = p254.pendingProps;
    local v256;

    if pendingProps.render then
        if _G___DEV__ and (_G___COMPAT_WARNINGS__ and not u252.usingLegacyConsumer) then
            u252.usingLegacyConsumer = true;
            console.warn("Your Context.Consumer component is using legacy Roact syntax, which won\'t be supported in future versions of Roact. \nPlease provide no props and supply the \'render\' function as a child (the 3rd argument of createElement). For example: \n       createElement(ContextConsumer, {render = function(...) end})\nbecomes:\n       createElement(ContextConsumer, nil, function(...) end)\nFor more info, reference the React documentation here: \nhttps://reactjs.org/docs/context.html#contextconsumer");
        end;

        v256 = pendingProps.render;
    else
        v256 = pendingProps.children;
    end;

    if _G___DEV__ and type(v256) ~= "function" then
        console.error("A context consumer was rendered with multiple children, or a child that isn\'t a function. A context consumer expects a single child that is a function. If you did pass a function, make sure there is no trailing or leading whitespace around it.");
    end;

    prepareToReadContext(p254, p255, u21.markWorkInProgressReceivedUpdate);
    local v257 = readContext(type2, pendingProps.unstable_observedBits);
    local v258;

    if _G___DEV__ then
        ReactCurrentOwner.current = p254;
        setIsRendering(true);
        v258 = v256(v257);
        setIsRendering(false);
    else
        v258 = v256(v257);
    end;

    p254.flags = bit32.bor(p254.flags, PerformedWork);

    if p253 == nil then
        p254.child = mountChildFibers(p254, nil, v258, p255);
    else
        p254.child = reconcileChildFibers(p254, p253.child, v258, p255);
    end;

    return p254.child;
end;

function u21.markWorkInProgressReceivedUpdate() -- Line: 3159
    -- upvalues: u24 (ref)
    u24 = true;
end;

u22 = function(p259, p260, p261) -- Line: 3163, Name: bailoutOnAlreadyFinishedWork
    -- upvalues: enableProfilerTimer (copy), stopProfilerTimerIfRunning (copy), markSkippedUpdateLanes (copy), ReactFiberLane (copy), cloneChildFibers (copy)
    if p259 then
        p260.dependencies = p259.dependencies;
    end;

    if enableProfilerTimer then
        stopProfilerTimerIfRunning(p260);
    end;

    markSkippedUpdateLanes(p260.lanes);

    if not ReactFiberLane.includesSomeLane(p261, p260.childLanes) then
        return nil;
    end;

    cloneChildFibers(p259, p260);

    return p260.child;
end;

function remountFiber(p262, p263, p264)
    -- upvalues: _G___DEV__ (copy), Deletion (copy), Placement (copy)
    if _G___DEV__ then
        local return_ = p263.return_;

        if return_ == nil then
            error("Cannot swap the root fiber.");
        end;

        assert(return_ ~= nil, "returnFiber was nil in remountFiber");
        p262.alternate = nil;
        p263.alternate = nil;
        p264.index = p263.index;
        p264.sibling = p263.sibling;
        p264.return_ = p263.return_;
        p264.ref = p263.ref;

        if p263 == return_.child then
            return_.child = p264;
        else
            local child = return_.child;

            if child == nil then
                error("Expected parent to have a child.");
            end;

            assert(child ~= nil, "prevSibling was nil in remountFiber");

            while child.sibling ~= p263 do
                child = child.sibling;

                if child == nil then
                    error("Expected to find the previous sibling.");
                end;
            end;

            child.sibling = p264;
        end;

        local deletions = return_.deletions;

        if deletions == nil then
            return_.deletions = { p262 };
            return_.flags = bit32.bor(return_.flags, Deletion);
        else
            table.insert(deletions, p262);
        end;

        p264.flags = bit32.bor(p264.flags, Placement);

        return p264;
    end;

    error("Did not expect this call in production. This is a bug in React. Please file an issue.");
end;

function u21.beginWork(p265, p266, p267) -- Line: 3263
    -- upvalues: _G___DEV__ (copy), createFiberFromTypeAndProps (copy), hasContextChanged (copy), u24 (ref), ReactFiberLane (copy), HostRoot (copy), pushTopLevelContextObject (copy), pushHostContainer (copy), resetHydrationState (copy), HostComponent (copy), pushHostContext (copy), ClassComponent (copy), isContextProvider (copy), pushContextProvider (copy), HostPortal (copy), ContextProvider (copy), pushProvider (copy), Profiler (copy), enableProfilerTimer (copy), SuspenseComponent (copy), enableSuspenseServerRenderer (copy), pushSuspenseContext (copy), setDefaultShallowSuspenseContext (copy), suspenseStackCursor (copy), DidCapture (copy), updateSuspenseComponent (copy), u22 (ref), SuspenseListComponent (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy), updateOffscreenComponent (copy), ForceUpdateForLegacySuspense (copy), NoFlags (copy), ReactWorkTags (copy), mountIndeterminateComponent (copy), LazyComponent (copy), mountLazyComponent (copy), FunctionComponent (copy), resolveDefaultProps (copy), u23 (ref), updateClassComponent (copy), updateHostRoot (copy), updateHostComponent (copy), HostText (copy), tryToClaimNextHydratableInstance (copy), ForwardRef (copy), updateForwardRef (copy), Fragment (copy), Mode (copy), updateContextProvider (copy), ContextConsumer (copy), MemoComponent (copy), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), getComponentName (copy), updateMemoComponent (copy), SimpleMemoComponent (copy), u26 (ref), IncompleteClassComponent (copy), updateOffscreenComponent (copy), invariant (copy)
    local lanes = p266.lanes;

    if _G___DEV__ and (p266._debugNeedsRemount and p265 ~= nil) then
        return remountFiber(p265, p266, createFiberFromTypeAndProps(p266.type, p266.key, p266.pendingProps, p266._debugOwner or nil, p266.mode, p266.lanes));
    end;

    if p265 == nil then
        u24 = false;
    elseif p265.memoizedProps == p266.pendingProps and not hasContextChanged() then
        local v268;

        if _G___DEV__ then
            v268 = p266.type ~= p265.type;
        else
            v268 = false;
        end;

        if v268 then
            u24 = true;
        else
            if not ReactFiberLane.includesSomeLane(p267, lanes) then
                u24 = false;

                if p266.tag == HostRoot then
                    local stateNode = p266.stateNode;

                    if stateNode.pendingContext then
                        pushTopLevelContextObject(p266, stateNode.pendingContext, stateNode.pendingContext ~= stateNode.context);
                    elseif stateNode.context then
                        pushTopLevelContextObject(p266, stateNode.context, false);
                    end;

                    pushHostContainer(p266, stateNode.containerInfo);
                    resetHydrationState();
                elseif p266.tag == HostComponent then
                    pushHostContext(p266);
                elseif p266.tag == ClassComponent then
                    if isContextProvider(p266.type) then
                        pushContextProvider(p266);
                    end;
                elseif p266.tag == HostPortal then
                    pushHostContainer(p266, p266.stateNode.containerInfo);
                elseif p266.tag == ContextProvider then
                    pushProvider(p266, p266.memoizedProps.value);
                elseif p266.tag == Profiler then
                    if enableProfilerTimer then
                        local stateNode = p266.stateNode;
                        stateNode.effectDuration = 0;
                        stateNode.passiveEffectDuration = 0;
                    end;
                elseif p266.tag == SuspenseComponent then
                    local memoizedState = p266.memoizedState;

                    if memoizedState ~= nil then
                        if enableSuspenseServerRenderer and memoizedState.dehydrated ~= nil then
                            pushSuspenseContext(p266, setDefaultShallowSuspenseContext(suspenseStackCursor.current));
                            p266.flags = bit32.bor(p266.flags, DidCapture);

                            return nil;
                        end;

                        if ReactFiberLane.includesSomeLane(p267, p266.child.childLanes) then
                            return updateSuspenseComponent(p265, p266, p267);
                        end;

                        pushSuspenseContext(p266, setDefaultShallowSuspenseContext(suspenseStackCursor.current));
                        local v269 = u22(p265, p266, p267);

                        if v269 == nil then
                            return nil;
                        end;

                        return v269.sibling;
                    end;

                    pushSuspenseContext(p266, setDefaultShallowSuspenseContext(suspenseStackCursor.current));
                elseif p266.tag == SuspenseListComponent then
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("UNIMPLEMENTED ERROR: " .. tostring("beginWork: SuspenseListComponent"));
                    error("FIXME (roblox): beginWork: SuspenseListComponent is unimplemented", 2);
                elseif p266.tag == OffscreenComponent or p266.tag == LegacyHiddenComponent then
                    p266.lanes = ReactFiberLane.NoLanes;

                    return updateOffscreenComponent(p265, p266, p267);
                end;

                return u22(p265, p266, p267);
            end;

            if bit32.band(p265.flags, ForceUpdateForLegacySuspense) == NoFlags then
                u24 = false;
            else
                u24 = true;
            end;
        end;
    else
        u24 = true;
    end;

    p266.lanes = ReactFiberLane.NoLanes;

    if p266.tag == ReactWorkTags.IndeterminateComponent then
        return mountIndeterminateComponent(p265, p266, p266.type, p267);
    end;

    if p266.tag == LazyComponent then
        return mountLazyComponent(p265, p266, p266.elementType, lanes, p267);
    end;

    if p266.tag == FunctionComponent then
        local type2 = p266.type;
        local pendingProps = p266.pendingProps;

        if p266.elementType ~= type2 then
            pendingProps = resolveDefaultProps(type2, pendingProps);
        end;

        return u23(p265, p266, type2, pendingProps, p267);
    end;

    if p266.tag == ClassComponent then
        local type2 = p266.type;
        local pendingProps = p266.pendingProps;

        return updateClassComponent(p265, p266, type2, p266.elementType == type2 and pendingProps and pendingProps or resolveDefaultProps(type2, pendingProps), p267);
    end;

    if p266.tag == HostRoot then
        return updateHostRoot(p265, p266, p267);
    end;

    if p266.tag == HostComponent then
        return updateHostComponent(p265, p266, p267);
    end;

    if p266.tag == HostText then
        if p265 == nil then
            tryToClaimNextHydratableInstance(p266);
        end;

        return nil;
    end;

    if p266.tag == SuspenseComponent then
        return updateSuspenseComponent(p265, p266, p267);
    end;

    if p266.tag == HostPortal then
        return updatePortalComponent(p265, p266, p267);
    end;

    if p266.tag == ForwardRef then
        local type2 = p266.type;
        local pendingProps = p266.pendingProps;

        if p266.elementType ~= type2 then
            pendingProps = resolveDefaultProps(type2, pendingProps);
        end;

        return updateForwardRef(p265, p266, type2, pendingProps, p267);
    end;

    if p266.tag == Fragment then
        return updateFragment(p265, p266, p267);
    end;

    if p266.tag == Mode then
        return updateMode(p265, p266, p267);
    end;

    if p266.tag == Profiler then
        return updateProfiler(p265, p266, p267);
    end;

    if p266.tag == ContextProvider then
        return updateContextProvider(p265, p266, p267);
    end;

    if p266.tag == ContextConsumer then
        return updateContextConsumer(p265, p266, p267);
    end;

    if p266.tag == MemoComponent then
        local type2 = p266.type;
        local v270 = resolveDefaultProps(type2, p266.pendingProps);

        if (_G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and p266.type ~= p266.elementType then
            local v271, v272;

            if type(type2) == "table" then
                v271 = type2.propTypes;
                v272 = type2.validateProps;
            else
                v271 = nil;
                v272 = nil;
            end;

            if v271 or v272 then
                checkPropTypes(v271, v272, v270, "prop", getComponentName(type2));
            end;
        end;

        return updateMemoComponent(p265, p266, type2, resolveDefaultProps(type2.type, v270), lanes, p267);
    end;

    if p266.tag == SimpleMemoComponent then
        return u26(p265, p266, p266.type, p266.pendingProps, lanes, p267);
    end;

    if p266.tag == IncompleteClassComponent then
        local type2 = p266.type;
        local pendingProps = p266.pendingProps;
        local v273 = p266.elementType == type2 and pendingProps and pendingProps or resolveDefaultProps(type2, pendingProps);

        return mountIncompleteClassComponent(p265, p266, type2, v273, p267);
    end;

    if p266.tag == OffscreenComponent then
        return updateOffscreenComponent(p265, p266, p267);
    end;

    if p266.tag == LegacyHiddenComponent then
        return updateOffscreenComponent(p265, p266, p267);
    end;

    invariant(false, "Unknown unit of work tag (%s). This error is likely caused by a bug in React. Please file an issue.", (tostring(p266.tag)));

    return nil;
end;

return u21;