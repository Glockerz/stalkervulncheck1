-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
require(script.Parent.Parent:WaitForChild("shared"));
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Array = v1.Array;
local Object = v1.Object;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactRootTags = require(script.Parent:WaitForChild("ReactRootTags"));
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
require(script.Parent:WaitForChild("ReactFiberHostConfig"));
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local FundamentalComponent = ReactWorkTags.FundamentalComponent;
require(script.Parent.Parent:WaitForChild("shared"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local ReactFiberTreeReflection = require(script.Parent:WaitForChild("ReactFiberTreeReflection"));
local findCurrentHostFiber = ReactFiberTreeReflection.findCurrentHostFiber;
local findCurrentHostFiberWithNoPortals = ReactFiberTreeReflection.findCurrentHostFiberWithNoPortals;
local get = require(script.Parent.Parent:WaitForChild("shared")).ReactInstanceMap.get;
local HostComponent = ReactWorkTags.HostComponent;
local ClassComponent = ReactWorkTags.ClassComponent;
local HostRoot = ReactWorkTags.HostRoot;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
local enableSchedulingProfiler = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSchedulingProfiler;
local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals;
local getPublicInstance = require(script.Parent:WaitForChild("ReactFiberHostConfig")).getPublicInstance;
local v2 = require(script.Parent:WaitForChild("ReactFiberContext.new"));
local findCurrentUnmaskedContext = v2.findCurrentUnmaskedContext;
local processChildContext = v2.processChildContext;
local emptyContextObject = v2.emptyContextObject;
local isContextProvider = v2.isContextProvider;
local createFiberRoot = require(script.Parent:WaitForChild("ReactFiberRoot.new")).createFiberRoot;
local v3 = require(script.Parent:WaitForChild("ReactFiberDevToolsHook.new"));
local injectInternals = v3.injectInternals;
local onScheduleRoot = v3.onScheduleRoot;
local v4 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
local requestEventTime = v4.requestEventTime;
local requestUpdateLane = v4.requestUpdateLane;
local scheduleUpdateOnFiber = v4.scheduleUpdateOnFiber;
local flushRoot = v4.flushRoot;
local batchedEventUpdates = v4.batchedEventUpdates;
local batchedUpdates = v4.batchedUpdates;
local unbatchedUpdates = v4.unbatchedUpdates;
local flushSync = v4.flushSync;
local flushControlled = v4.flushControlled;
local deferredUpdates = v4.deferredUpdates;
local discreteUpdates = v4.discreteUpdates;
local flushDiscreteUpdates = v4.flushDiscreteUpdates;
local flushPassiveEffects = v4.flushPassiveEffects;
local warnIfNotScopedWithMatchingAct = v4.warnIfNotScopedWithMatchingAct;
local warnIfUnmockedScheduler = v4.warnIfUnmockedScheduler;
local IsThisRendererActing = v4.IsThisRendererActing;
local act = v4.act;
local v5 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"));
local createUpdate = v5.createUpdate;
local enqueueUpdate = v5.enqueueUpdate;
local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"));
local isRendering = ReactCurrentFiber.isRendering;
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber;
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber;
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"));
local StrictMode = ReactTypeOfMode.StrictMode;
local SyncLane = ReactFiberLane.SyncLane;
local InputDiscreteHydrationLane = ReactFiberLane.InputDiscreteHydrationLane;
local SelectiveHydrationLane = ReactFiberLane.SelectiveHydrationLane;
local NoTimestamp = ReactFiberLane.NoTimestamp;
local getHighestPriorityPendingLanes = ReactFiberLane.getHighestPriorityPendingLanes;
local higherPriorityLane = ReactFiberLane.higherPriorityLane;
local getCurrentUpdateLanePriority = ReactFiberLane.getCurrentUpdateLanePriority;
local setCurrentUpdateLanePriority = ReactFiberLane.setCurrentUpdateLanePriority;
local markRenderScheduled = require(script.Parent:WaitForChild("SchedulingProfiler")).markRenderScheduled;
local v6 = {
    ReactRootTags = ReactRootTags,
    ReactWorkTags = ReactWorkTags,
    ReactTypeOfMode = ReactTypeOfMode,
    ReactFiberFlags = ReactFiberFlags,
    getNearestMountedFiber = ReactFiberTreeReflection.getNearestMountedFiber,
    findCurrentFiberUsingSlowPath = ReactFiberTreeReflection.findCurrentFiberUsingSlowPath,
    createPortal = require(script.Parent:WaitForChild("ReactPortal")).createPortal
};
local u7, u8;

if _G___DEV__ then
    u7 = {};
    u8 = false;
else
    u7 = nil;
    u8 = nil;
end;

local function getContextForSubtree(p9) -- Line: 176
    -- upvalues: emptyContextObject (copy), get (copy), findCurrentUnmaskedContext (copy), ClassComponent (copy), isContextProvider (copy), processChildContext (copy)
    if not p9 then
        return emptyContextObject;
    end;

    local v10 = get(p9);
    local v11 = findCurrentUnmaskedContext(v10);

    if v10.tag == ClassComponent then
        local type = v10.type;

        if isContextProvider(type) then
            return processChildContext(v10, type, v11);
        end;
    end;

    return v11;
end;

local function findHostInstance(p12: table) -- Line: 194
    -- upvalues: get (copy), invariant (copy), Object (copy), findCurrentHostFiber (copy)
    local v13 = get(p12);

    if v13 == nil then
        if typeof(p12.render) == "function" then
            invariant(false, "Unable to find node on an unmounted component.");
        else
            invariant(false, "Argument appears to not be a ReactComponent. Keys: %s", table.concat(Object.keys(p12)));
        end;
    end;

    local v14 = findCurrentHostFiber(v13);

    if v14 == nil then
        return nil;
    end;

    return v14.stateNode;
end;

local function findHostInstanceWithWarning(p15: table, u16: string) -- Line: 215
    -- upvalues: _G___DEV__ (copy), get (copy), invariant (copy), Object (copy), findCurrentHostFiber (copy), StrictMode (copy), getComponentName (copy), u7 (ref), ReactCurrentFiber (copy), setCurrentFiber (copy), console (copy), describeError (copy), resetCurrentFiber (copy), findHostInstance (copy)
    if not _G___DEV__ then
        return findHostInstance(p15);
    end;

    local u17 = get(p15);

    if u17 == nil then
        if typeof(p15.render) == "function" then
            invariant(false, "Unable to find node on an unmounted component.");
        else
            invariant(false, "Argument appears to not be a ReactComponent. Keys: %s", table.concat(Object.keys(p15)));
        end;
    end;

    local u18 = findCurrentHostFiber(u17);

    if u18 == nil then
        return nil;
    end;

    if bit32.band(u18.mode, StrictMode) ~= 0 then
        local u19 = getComponentName(u17.type) or "Component";

        if not u7[u19] then
            u7[u19] = true;
            local current = ReactCurrentFiber.current;
            local v20, v21 = xpcall(function() -- Line: 243
                -- upvalues: setCurrentFiber (ref), u18 (copy), u17 (copy), StrictMode (ref), console (ref), u16 (copy), u19 (copy)
                setCurrentFiber(u18);

                if bit32.band(u17.mode, StrictMode) == 0 then
                    console.error("%s is deprecated in StrictMode. %s was passed an instance of %s which renders StrictMode children. Instead, add a ref directly to the element you want to reference. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-find-node", u16, u16, u19);

                    return;
                end;

                console.error("%s is deprecated in StrictMode. %s was passed an instance of %s which is inside StrictMode. Instead, add a ref directly to the element you want to reference. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-find-node", u16, u16, u19);
            end, describeError);

            if current then
                setCurrentFiber(current);
            else
                resetCurrentFiber();
            end;

            if not v20 then
                error(v21);
            end;
        end;
    end;

    return u18.stateNode;
end;

function v6.createContainer(p22: any, p23: any, p24: boolean, p25: any) -- Line: 288
    -- upvalues: createFiberRoot (copy)
    return createFiberRoot(p22, p23, p24, p25);
end;

function v6.updateContainer(p26: any, p27: any, p28: any, p29: function?) -- Line: 297
    -- upvalues: _G___DEV__ (copy), onScheduleRoot (copy), requestEventTime (copy), warnIfUnmockedScheduler (copy), warnIfNotScopedWithMatchingAct (copy), requestUpdateLane (copy), enableSchedulingProfiler (copy), markRenderScheduled (copy), emptyContextObject (copy), get (copy), findCurrentUnmaskedContext (copy), ClassComponent (copy), isContextProvider (copy), processChildContext (copy), isRendering (copy), ReactCurrentFiber (copy), u8 (ref), console (copy), getComponentName (copy), createUpdate (copy), Object (copy), enqueueUpdate (copy), scheduleUpdateOnFiber (copy)
    if _G___DEV__ then
        onScheduleRoot(p27, p26);
    end;

    local current = p27.current;
    local v30 = requestEventTime();

    if _G___DEV__ and _G.__TESTEZ_RUNNING_TEST__ then
        warnIfUnmockedScheduler(current);
        warnIfNotScopedWithMatchingAct(current);
    end;

    local v31 = requestUpdateLane(current);

    if enableSchedulingProfiler then
        markRenderScheduled(v31);
    end;

    local v32;

    if p28 then
        local v33 = get(p28);
        v32 = findCurrentUnmaskedContext(v33);

        if v33.tag == ClassComponent then
            local type = v33.type;

            if isContextProvider(type) then
                v32 = processChildContext(v33, type, v32);
            end;
        end;
    else
        v32 = emptyContextObject;
    end;

    if p27.context == nil then
        p27.context = v32;
    else
        p27.pendingContext = v32;
    end;

    if _G___DEV__ and (isRendering and (ReactCurrentFiber.current ~= nil and not u8)) then
        u8 = true;
        console.error("Render methods should be a pure function of props and state; triggering nested component updates from render is not allowed. If necessary, trigger nested updates in componentDidUpdate.\n\nCheck the render method of %s.", getComponentName(ReactCurrentFiber.current.type) or "Unknown");
    end;

    local v34 = createUpdate(v30, v31);

    if p26 == nil then
        p26 = Object.None;
    end;

    v34.payload = {
        element = p26
    };

    if p29 ~= nil then
        if _G___DEV__ and typeof(p29) ~= "function" then
            console.error("render(...): Expected the last optional `callback` argument to be a function. Instead received: %s.", (tostring(p29)));
        end;

        v34.callback = p29;
    end;

    enqueueUpdate(current, v34);
    scheduleUpdateOnFiber(current, v31, v30);

    return v31;
end;

v6.batchedEventUpdates = batchedEventUpdates;
v6.batchedUpdates = batchedUpdates;
v6.unbatchedUpdates = unbatchedUpdates;
v6.deferredUpdates = deferredUpdates;
v6.discreteUpdates = discreteUpdates;
v6.flushDiscreteUpdates = flushDiscreteUpdates;
v6.flushControlled = flushControlled;
v6.flushSync = flushSync;
v6.flushPassiveEffects = flushPassiveEffects;
v6.IsThisRendererActing = IsThisRendererActing;
v6.act = act;

function v6.getPublicRootInstance(p35) -- Line: 393
    -- upvalues: HostComponent (copy), getPublicInstance (copy)
    local current = p35.current;

    if not current.child then
        return nil;
    end;

    if current.child.tag == HostComponent then
        return getPublicInstance(current.child.stateNode);
    end;

    return current.child.stateNode;
end;

local u36 = nil;

function v6.attemptSynchronousHydration(u37) -- Line: 408
    -- upvalues: HostRoot (copy), getHighestPriorityPendingLanes (copy), flushRoot (copy), SuspenseComponent (copy), requestEventTime (copy), flushSync (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), InputDiscreteHydrationLane (copy), u36 (ref)
    if u37.tag == HostRoot then
        local stateNode = u37.stateNode;

        if stateNode.hydrate then
            flushRoot(stateNode, (getHighestPriorityPendingLanes(stateNode)));
        end;
    elseif u37.tag == SuspenseComponent then
        local u38 = requestEventTime();
        flushSync(function() -- Line: 418
            -- upvalues: scheduleUpdateOnFiber (ref), u37 (copy), SyncLane (ref), u38 (copy)
            return scheduleUpdateOnFiber(u37, SyncLane, u38);
        end);
        u36(u37, InputDiscreteHydrationLane);
    end;
end;

local function markRetryLaneImpl(p39, p40) -- Line: 429
    -- upvalues: higherPriorityLane (copy)
    local memoizedState = p39.memoizedState;

    if memoizedState and (memoizedState ~= nil and memoizedState.dehydrated ~= nil) then
        memoizedState.retryLane = higherPriorityLane(memoizedState.retryLane, p40);
    end;
end;

u36 = function(p41, p42) -- Line: 440
    -- upvalues: higherPriorityLane (copy)
    local memoizedState = p41.memoizedState;

    if memoizedState and (memoizedState ~= nil and memoizedState.dehydrated ~= nil) then
        memoizedState.retryLane = higherPriorityLane(memoizedState.retryLane, p42);
    end;

    local alternate = p41.alternate;

    if alternate then
        local memoizedState2 = alternate.memoizedState;

        if memoizedState2 and (memoizedState2 ~= nil and memoizedState2.dehydrated ~= nil) then
            memoizedState2.retryLane = higherPriorityLane(memoizedState2.retryLane, p42);
        end;
    end;
end;

function v6.attemptUserBlockingHydration(p43) -- Line: 449
    -- upvalues: SuspenseComponent (copy), requestEventTime (copy), InputDiscreteHydrationLane (copy), scheduleUpdateOnFiber (copy), u36 (ref)
    if p43.tag ~= SuspenseComponent then
        return;
    end;

    local v44 = InputDiscreteHydrationLane;
    scheduleUpdateOnFiber(p43, v44, (requestEventTime()));
    u36(p43, v44);
end;

function v6.attemptContinuousHydration(p45) -- Line: 463
    -- upvalues: SuspenseComponent (copy), requestEventTime (copy), SelectiveHydrationLane (copy), scheduleUpdateOnFiber (copy), u36 (ref)
    if p45.tag ~= SuspenseComponent then
        return;
    end;

    local v46 = SelectiveHydrationLane;
    scheduleUpdateOnFiber(p45, v46, (requestEventTime()));
    u36(p45, v46);
end;

function v6.attemptHydrationAtCurrentPriority(p47) -- Line: 477
    -- upvalues: SuspenseComponent (copy), requestEventTime (copy), requestUpdateLane (copy), scheduleUpdateOnFiber (copy), u36 (ref)
    if p47.tag ~= SuspenseComponent then
        return;
    end;

    local v48 = requestEventTime();
    local v49 = requestUpdateLane(p47);
    scheduleUpdateOnFiber(p47, v49, v48);
    u36(p47, v49);
end;

function v6.runWithPriority(p50: any, p51: function) -- Line: 489
    -- upvalues: getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), describeError (copy)
    local v52 = getCurrentUpdateLanePriority();
    setCurrentUpdateLanePriority(p50);
    local v53, v54 = xpcall(p51, describeError);
    setCurrentUpdateLanePriority(v52);

    if not v53 then
        error(v54);
    end;

    return v54;
end;

v6.getCurrentUpdateLanePriority = getCurrentUpdateLanePriority;
v6.findHostInstance = findHostInstance;
v6.findHostInstanceWithWarning = findHostInstanceWithWarning;

function v6.findHostInstanceWithNoPortals(p55) -- Line: 507
    -- upvalues: findCurrentHostFiberWithNoPortals (copy), FundamentalComponent (copy)
    local v56 = findCurrentHostFiberWithNoPortals(p55);

    if v56 == nil then
        return nil;
    end;

    if v56.tag == FundamentalComponent then
        return v56.stateNode.instance;
    end;

    return v56.stateNode;
end;

local function shouldSuspendImpl(p57) -- Line: 518
    return false;
end;

function v6.shouldSuspend(p58) -- Line: 522
    -- upvalues: shouldSuspendImpl (ref)
    return shouldSuspendImpl(p58);
end;

local u59, u60, u61, u62, u63, u64, u65, u66;

if _G___DEV__ then
    local function copyWithDeleteImpl(p67: table, p68: table, p69: number) -- Line: 537
        -- upvalues: Array (copy), copyWithDeleteImpl (copy)
        local v70 = p68[p69];
        local v71;

        if Array.isArray(p67) then
            v71 = Array.slice(p67);
        else
            v71 = table.clone(p67);
        end;

        if p69 + 1 ~= #p68 then
            v71[v70] = copyWithDeleteImpl(p67[v70], p68, p69 + 1);

            return v71;
        end;

        if Array.isArray(v71) then
            Array.splice(v71, v70, 1);

            return v71;
        end;

        v71[v70] = nil;

        return v71;
    end;

    local function copyWithDelete(p72: table, p73: table) -- Line: 565
        -- upvalues: copyWithDeleteImpl (copy)
        return copyWithDeleteImpl(p72, p73, 0);
    end;

    local function copyWithRenameImpl(p74: table, p75: table, p76: table, p77: number) -- Line: 573
        -- upvalues: Array (copy), copyWithRenameImpl (copy)
        local v78 = p75[p77];
        local v79;

        if Array.isArray(p74) then
            v79 = Array.slice(p74);
        else
            v79 = table.clone(p74);
        end;

        if p77 + 1 ~= #p75 then
            v79[v78] = copyWithRenameImpl(p74[v78], p75, p76, p77 + 1);

            return v79;
        end;

        v79[p76[p77]] = v79[v78];

        if Array.isArray(v79) then
            Array.splice(v79, v78, 1);

            return v79;
        end;

        v79[v78] = nil;

        return v79;
    end;

    local function copyWithRename(p80: table, p81: table, p82: table) -- Line: 609
        -- upvalues: console (copy), copyWithRenameImpl (copy)
        if #p81 == #p82 then
            for i = 1, #p82 do
                if p81[i] ~= p82[i] then
                    console.warn("copyWithRename() expects paths to be the same except for the deepest key");

                    return nil;
                end;

                local _ = i;
            end;

            return copyWithRenameImpl(p80, p81, p82, 0);
        end;

        console.warn("copyWithRename() expects paths of the same length");

        return nil;
    end;

    local function copyWithSetImpl(p83: table, p84: table, p85: number, p86: any) -- Line: 631
        -- upvalues: Array (copy), copyWithSetImpl (copy)
        if #p84 + 1 <= p85 then
            return p86;
        end;

        local v87 = p84[p85];
        local v88;

        if Array.isArray(p83) then
            v88 = Array.slice(p83);
        else
            v88 = table.clone(p83);
        end;

        v88[v87] = copyWithSetImpl(p83[v87], p84, p85 + 2, p86);

        return v88;
    end;

    local function copyWithSet(p89: table, p90: table, p91: any) -- Line: 653
        -- upvalues: copyWithSetImpl (copy)
        return copyWithSetImpl(p89, p90, 1, p91);
    end;

    local function findHook(p92: any, p93: number) -- Line: 661
        local memoizedState = p92.memoizedState;

        while memoizedState ~= nil and p93 > 1 do
            memoizedState = memoizedState.next;
            p93 = p93 - 1;
        end;

        return memoizedState;
    end;

    u59 = function(p94: function) -- Line: 769
        -- upvalues: shouldSuspendImpl (ref)
        shouldSuspendImpl = p94;
    end;

    u60 = function(p95: any, p96: table, p97: any) -- Line: 733
        -- upvalues: copyWithSetImpl (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy)
        p95.pendingProps = copyWithSetImpl(p95.memoizedProps, p96, 1, p97);
        local alternate = p95.alternate;

        if alternate then
            alternate.pendingProps = p95.pendingProps;
        end;

        scheduleUpdateOnFiber(p95, SyncLane, NoTimestamp);
    end;

    u61 = function(p98: any, p99: table) -- Line: 742
        -- upvalues: copyWithDeleteImpl (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy)
        p98.pendingProps = copyWithDeleteImpl(p98.memoizedProps, p99, 0);
        local alternate = p98.alternate;

        if alternate then
            alternate.pendingProps = p98.pendingProps;
        end;

        scheduleUpdateOnFiber(p98, SyncLane, NoTimestamp);
    end;

    u62 = function(p100: any, p101: table, p102: table) -- Line: 751
        -- upvalues: copyWithRename (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy)
        p100.pendingProps = copyWithRename(p100.memoizedProps, p101, p102);
        local alternate = p100.alternate;

        if alternate then
            alternate.pendingProps = p100.pendingProps;
        end;

        scheduleUpdateOnFiber(p100, SyncLane, NoTimestamp);
    end;

    u63 = function(p103) -- Line: 765
        -- upvalues: scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy)
        scheduleUpdateOnFiber(p103, SyncLane, NoTimestamp);
    end;

    u64 = function(p104: any, p105: number, p106: table, p107: any) -- Line: 674
        -- upvalues: copyWithSetImpl (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy)
        local memoizedState = p104.memoizedState;

        while memoizedState ~= nil and p105 > 1 do
            memoizedState = memoizedState.next;
            p105 = p105 - 1;
        end;

        if memoizedState ~= nil then
            local v108 = copyWithSetImpl(memoizedState.memoizedState, p106, 1, p107);
            memoizedState.memoizedState = v108;
            memoizedState.baseState = v108;
            p104.memoizedProps = table.clone(p104.memoizedProps);
            scheduleUpdateOnFiber(p104, SyncLane, NoTimestamp);
        end;
    end;

    u65 = function(p109: any, p110: number, p111: table) -- Line: 692
        -- upvalues: copyWithDeleteImpl (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy)
        local memoizedState = p109.memoizedState;

        while memoizedState ~= nil and p110 > 1 do
            memoizedState = memoizedState.next;
            p110 = p110 - 1;
        end;

        if memoizedState ~= nil then
            local v112 = copyWithDeleteImpl(memoizedState.memoizedState, p111, 0);
            memoizedState.memoizedState = v112;
            memoizedState.baseState = v112;
            p109.memoizedProps = table.clone(p109.memoizedProps);
            scheduleUpdateOnFiber(p109, SyncLane, NoTimestamp);
        end;
    end;

    u66 = function(p113: any, p114: number, p115: table, p116: table) -- Line: 709
        -- upvalues: copyWithRename (copy), scheduleUpdateOnFiber (copy), SyncLane (copy), NoTimestamp (copy)
        local memoizedState = p113.memoizedState;

        while memoizedState ~= nil and p114 > 1 do
            memoizedState = memoizedState.next;
            p114 = p114 - 1;
        end;

        if memoizedState ~= nil then
            local v117 = copyWithRename(memoizedState.memoizedState, p115, p116);
            memoizedState.memoizedState = v117;
            memoizedState.baseState = v117;
            p113.memoizedProps = table.clone(p113.memoizedProps);
            scheduleUpdateOnFiber(p113, SyncLane, NoTimestamp);
        end;
    end;
else
    u60 = nil;
    u61 = nil;
    u62 = nil;
    u59 = nil;
    u63 = nil;
    u64 = nil;
    u65 = nil;
    u66 = nil;
end;

function findHostInstanceByFiber(p118)
    -- upvalues: findCurrentHostFiber (copy)
    local v119 = findCurrentHostFiber(p118);

    if v119 == nil then
        return nil;
    end;

    return v119.stateNode;
end;

function emptyFindFiberByHostInstance(p120)
    return nil;
end;

function getCurrentFiberForDevTools()
    -- upvalues: ReactCurrentFiber (copy)
    return ReactCurrentFiber.current;
end;

function v6.injectIntoDevTools(p121: table) -- Line: 790
    -- upvalues: ReactSharedInternals (copy), _G___DEV__ (copy), injectInternals (copy), u64 (ref), u65 (ref), u66 (ref), u60 (ref), u61 (ref), u62 (ref), u59 (ref), u63 (ref)
    local v122;

    if _G___DEV__ then
        v122 = getCurrentFiberForDevTools;
    else
        v122 = nil;
    end;

    return injectInternals({
        bundleType = p121.bundleType,
        version = p121.version,
        rendererPackageName = p121.rendererPackageName,
        rendererConfig = p121.rendererConfig,
        overrideHookState = u64,
        overrideHookStateDeletePath = u65,
        overrideHookStateRenamePath = u66,
        overrideProps = u60,
        overridePropsDeletePath = u61,
        overridePropsRenamePath = u62,
        setSuspenseHandler = u59,
        scheduleUpdate = u63,
        currentDispatcherRef = ReactSharedInternals.ReactCurrentDispatcher,
        findHostInstanceByFiber = findHostInstanceByFiber,
        findFiberByHostInstance = p121.findFiberByHostInstance or emptyFindFiberByHostInstance,
        getCurrentFiber = v122
    });
end;

v6.robloxReactProfiling = require(script.Parent.RobloxReactProfiling);

return v6;