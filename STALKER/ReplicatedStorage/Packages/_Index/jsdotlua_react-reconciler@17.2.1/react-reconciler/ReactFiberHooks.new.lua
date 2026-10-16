-- Decompiled with Potassium's decompiler.

local function unimplemented(p1: string) -- Line: 12
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. p1);
    error("FIXME (roblox): " .. p1 .. " is unimplemented");
end;

local _G___DEV__ = _G.__DEV__;
local v2 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Array = v2.Array;
local Error = v2.Error;
local Object = v2.Object;
local createRef = require(script.Parent.Parent:WaitForChild("react")).createRef;
local createBinding = require(script.Parent.Parent:WaitForChild("react")).createBinding;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local ReactHookEffectTags = require(script.Parent:WaitForChild("ReactHookEffectTags"));
local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing;
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler;
local enableNewReconciler = ReactFeatureFlags.enableNewReconciler;
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects;
local DebugTracingMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).DebugTracingMode;
local NoLane = ReactFiberLane.NoLane;
local NoLanes = ReactFiberLane.NoLanes;
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes;
local mergeLanes = ReactFiberLane.mergeLanes;
local removeLanes = ReactFiberLane.removeLanes;
local markRootEntangled = ReactFiberLane.markRootEntangled;
local markRootMutableRead = ReactFiberLane.markRootMutableRead;
local readContext = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).readContext;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local Update = ReactFiberFlags.Update;
local Passive = ReactFiberFlags.Passive;
local PassiveStatic = ReactFiberFlags.PassiveStatic;
local MountLayoutDev = ReactFiberFlags.MountLayoutDev;
local MountPassiveDev = ReactFiberFlags.MountPassiveDev;
local HasEffect = ReactHookEffectTags.HasEffect;
local Layout = ReactHookEffectTags.Layout;
local Passive2 = ReactHookEffectTags.Passive;
local v3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
local warnIfNotCurrentlyActingUpdatesInDEV = v3.warnIfNotCurrentlyActingUpdatesInDEV;
local scheduleUpdateOnFiber = v3.scheduleUpdateOnFiber;
local warnIfNotScopedWithMatchingAct = v3.warnIfNotScopedWithMatchingAct;
local requestEventTime = v3.requestEventTime;
local requestUpdateLane = v3.requestUpdateLane;
local markSkippedUpdateLanes = v3.markSkippedUpdateLanes;
local getWorkInProgressRoot = v3.getWorkInProgressRoot;
local warnIfNotCurrentlyActingEffectsInDEV = v3.warnIfNotCurrentlyActingEffectsInDEV;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;

local function is(p4, p5) -- Line: 114
    local v6;

    if p4 == p5 and (p4 ~= 0 or 1 / p4 == 1 / p5) then
        v6 = true;
    elseif p4 == p4 then
        v6 = false;
    else
        v6 = p5 ~= p5;
    end;

    return v6;
end;

local markWorkInProgressReceivedUpdate = require(script.Parent:WaitForChild("ReactFiberBeginWork.new")).markWorkInProgressReceivedUpdate;
local getIsHydrating = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new")).getIsHydrating;
local makeClientId = require(script.Parent:WaitForChild("ReactFiberHostConfig")).makeClientId;
local v7 = require(script.Parent:WaitForChild("ReactMutableSource.new"));
local warnAboutMultipleRenderersDEV = v7.warnAboutMultipleRenderersDEV;
local getWorkInProgressVersion = v7.getWorkInProgressVersion;
local setWorkInProgressVersion = v7.setWorkInProgressVersion;
local markSourceAsDirty = v7.markSourceAsDirty;
local logStateUpdateScheduled = require(script.Parent:WaitForChild("DebugTracing")).logStateUpdateScheduled;
local markStateUpdateScheduled = require(script.Parent:WaitForChild("SchedulingProfiler")).markStateUpdateScheduled;
local ReactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher;
local u8 = _G___DEV__ and {} or nil;
local u9 = {};
local u10 = NoLanes;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = false;
local u15 = false;
local u16 = nil;
local u17 = nil;
local u18 = 0;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;

local function getHighestIndex(p26: table) -- Line: 256
    local v27 = 0;

    for i, _ in p26 do
        if v27 < i then
            v27 = i;
        end;
    end;

    return v27;
end;

local function isArrayOrSparseArray(p28) -- Line: 266
    if type(p28) ~= "table" then
        return false;
    end;

    for i, _ in p28 do
        if type(i) ~= "number" then
            return false;
        end;
    end;

    return true;
end;

local function mountHookTypesDev() -- Line: 278
    -- upvalues: _G___DEV__ (copy), u16 (ref), u17 (ref)
    if _G___DEV__ then
        local v29 = u16;

        if u17 == nil then
            u17 = { v29 };

            return;
        end;

        table.insert(u17, v29);
    end;
end;

function updateHookTypesDev()
    -- upvalues: _G___DEV__ (copy), u16 (ref), u17 (ref), u18 (ref)
    if _G___DEV__ then
        local v30 = u16;

        if u17 ~= nil then
            u18 = u18 + 1;

            if u17[u18] ~= v30 then
                warnOnHookMismatchInDev(v30);
            end;
        end;
    end;
end;

local function checkDepsAreArrayDev(p31) -- Line: 305
    -- upvalues: _G___DEV__ (copy), console (copy), u16 (ref)
    if _G___DEV__ and p31 ~= nil then
        local v32;

        if type(p31) == "table" then
            v32 = true;

            for i, _ in p31 do
                if type(i) ~= "number" then
                    v32 = false;
                    break;
                end;
            end;
        else
            v32 = false;
        end;

        if not v32 then
            console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p31)));
        end;
    end;
end;

function warnOnHookMismatchInDev(p33)
    -- upvalues: _G___DEV__ (copy), getComponentName (copy), u11 (ref), u8 (ref), u17 (ref), u18 (ref), console (copy)
    if _G___DEV__ then
        local v34 = getComponentName(u11.type) or "Component";

        if not u8[v34] then
            u8[v34] = true;

            if u17 ~= nil then
                local v35 = "";

                for i = 1, u18 do
                    local v36 = u17[i];
                    local v37;

                    if i == u18 then
                        v37 = p33;
                    else
                        v37 = v36;
                    end;

                    local v38 = tostring(i) .. ". " .. (v36 or "undefined");
                    local _ = i;

                    while string.len(v38) < 30 do
                        v38 = v38 .. " ";
                    end;

                    v35 = v35 .. v38 .. v37 .. "\n";
                end;

                console.error("React has detected a change in the order of Hooks called by %s. This will lead to bugs and errors if not fixed. For more information, read the Rules of Hooks: https://reactjs.org/link/rules-of-hooks\n\n   Previous render            Next render\n   ------------------------------------------------------\n%s   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n", v34, v35);
            end;
        end;
    end;
end;

local function throwInvalidHookError() -- Line: 372
    -- upvalues: Error (copy)
    error(Error.new("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem."));
end;

local function areHookInputsEqual(p39: table, p40: table) -- Line: 387
    -- upvalues: _G___DEV__ (copy), console (copy), u16 (ref)
    if p40 == nil then
        if _G___DEV__ then
            console.error("%s received a final argument during this render, but not during the previous render. Even though the final argument is optional, its type cannot change between renders.", u16);
        end;

        return false;
    end;

    local v41 = 0;

    for i, _ in p39 do
        if v41 < i then
            v41 = i;
        end;
    end;

    local v42 = 0;

    for i, _ in p40 do
        if v42 < i then
            v42 = i;
        end;
    end;

    if v41 ~= v42 then
        return false;
    end;

    for i = 1, math.min(v42, v41) do
        local v43 = p39[i];
        local v44 = p40[i];
        local v45;

        if v43 == v44 and (v43 ~= 0 or 1 / v43 == 1 / v44) then
            v45 = true;
        elseif v43 == v43 then
            v45 = false;
        else
            v45 = v44 ~= v44;
        end;

        if not v45 then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

function u9.bailoutHooks(p46, p47, p48) -- Line: 451
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), MountPassiveDev (copy), Passive (copy), MountLayoutDev (copy), Update (copy), removeLanes (copy)
    p47.updateQueue = p46.updateQueue;

    if _G___DEV__ and enableDoubleInvokingEffects then
        local flags = p47.flags;
        local bit32_bor_ret = bit32.bor(MountPassiveDev, Passive, MountLayoutDev, Update);
        local bit32_bnot_ret = bit32.bnot(bit32_bor_ret);
        p47.flags = bit32.band(flags, bit32_bnot_ret);
    else
        local flags = p47.flags;
        local bit32_bor_ret = bit32.bor(Passive, Update);
        local bit32_bnot_ret = bit32.bnot(bit32_bor_ret);
        p47.flags = bit32.band(flags, bit32_bnot_ret);
    end;

    p46.lanes = removeLanes(p46.lanes, p48);
end;

local u49 = false;

function u9.resetHooksAfterThrow() -- Line: 476
    -- upvalues: ReactCurrentDispatcher (copy), u9 (copy), u14 (ref), u11 (ref), u10 (ref), NoLanes (copy), u12 (ref), u13 (ref), _G___DEV__ (copy), u17 (ref), u18 (ref), u16 (ref), u49 (ref), u15 (ref)
    ReactCurrentDispatcher.current = u9.ContextOnlyDispatcher;

    if u14 then
        local memoizedState = u11.memoizedState;

        while memoizedState ~= nil do
            local queue = memoizedState.queue;

            if queue ~= nil then
                queue.pending = nil;
            end;

            memoizedState = memoizedState.next;
        end;

        u14 = false;
    end;

    u10 = NoLanes;
    u11 = nil;
    u12 = nil;
    u13 = nil;

    if _G___DEV__ then
        u17 = nil;
        u18 = 0;
        u16 = nil;
        u49 = false;
    end;

    u15 = false;
end;

local function mountWorkInProgressHook() -- Line: 521
    -- upvalues: u13 (ref), u11 (ref)
    local v50 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v50;
        u13 = v50;
    else
        u13.next = v50;
        u13 = v50;
    end;

    return u13;
end;

local function updateWorkInProgressHook() -- Line: 544
    -- upvalues: u12 (ref), u11 (ref), u13 (ref), Error (copy)
    local v51;

    if u12 == nil then
        local alternate = u11.alternate;

        if alternate == nil then
            v51 = nil;
        else
            v51 = alternate.memoizedState;
        end;
    else
        v51 = u12.next;
    end;

    local v52;

    if u13 == nil then
        v52 = u11.memoizedState;
    else
        v52 = u13.next;
    end;

    if v52 == nil then
        if v51 == nil then
            error(Error.new("Rendered more hooks than during the previous render."));
        end;

        u12 = v51;
        local v53 = {
            next = nil,
            memoizedState = u12.memoizedState,
            baseState = u12.baseState,
            baseQueue = u12.baseQueue,
            queue = u12.queue
        };

        if u13 == nil then
            u13 = v53;
            u11.memoizedState = v53;
        else
            u13.next = v53;
            u13 = v53;
        end;
    else
        u13 = v52;
        local _ = u13.next;
        u12 = v51;
    end;

    return u13;
end;

function basicStateReducer(p54, p55)
    if type(p55) == "function" then
        return p55(p54);
    end;

    return p55;
end;

function mountReducer(p56: function, p57: any, p58: function?)
    -- upvalues: u13 (ref), u11 (ref)
    local v59 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v59;
        u13 = v59;
    else
        u13.next = v59;
        u13 = v59;
    end;

    local v60 = u13;

    if p58 ~= nil then
        p57 = p58(p57);
    end;

    v60.baseState = p57;
    v60.memoizedState = v60.baseState;
    local u61 = {
        pending = nil,
        dispatch = nil,
        lastRenderedReducer = p56,
        lastRenderedState = p57
    };
    v60.queue = u61;
    local u62 = u11;

    local function v64(p63, ...) -- Line: 655
        -- upvalues: u62 (copy), u61 (copy)
        dispatchAction(u62, u61, p63, ...);
    end;

    u61.dispatch = v64;

    return v60.memoizedState, v64;
end;

function updateReducer(p65: function, p66: any, p67: function?)
    -- upvalues: updateWorkInProgressHook (copy), u12 (ref), u10 (ref), u11 (ref), mergeLanes (copy), markSkippedUpdateLanes (copy), NoLane (copy), markWorkInProgressReceivedUpdate (copy)
    local v68 = updateWorkInProgressHook();
    local queue = v68.queue;
    assert(queue ~= nil, "Should have a queue. This is likely a bug in React. Please file an issue.");
    queue.lastRenderedReducer = p65;
    local v69 = u12;
    local baseQueue = v69.baseQueue;
    local pending = queue.pending;

    if pending == nil then
        pending = baseQueue;
    else
        if baseQueue ~= nil then
            local next = baseQueue.next;
            baseQueue.next = pending.next;
            pending.next = next;
        end;

        v69.baseQueue = pending;
        queue.pending = nil;
    end;

    if pending ~= nil then
        local next = pending.next;
        local baseState = v69.baseState;
        local v70 = nil;
        local v71 = nil;
        local v72 = nil;

        repeat
            if true then
                local lane = next.lane;

                if bit32.band(u10, lane) == lane then
                    if v70 ~= nil then
                        v70.next = {
                            next = nil,
                            lane = NoLane,
                            action = next.action,
                            eagerReducer = next.eagerReducer,
                            eagerState = next.eagerState
                        };
                        v70 = v70.next;
                    end;

                    if next.eagerReducer == p65 then
                        baseState = next.eagerState;
                    else
                        baseState = p65(baseState, next.action);
                    end;
                else
                    local v73 = {
                        next = nil,
                        lane = lane,
                        action = next.action,
                        eagerReducer = next.eagerReducer,
                        eagerState = next.eagerState
                    };

                    if v70 == nil then
                        v71 = v73;
                        v70 = v71;
                        v72 = baseState;
                        local v74 = v71;
                        v71 = v70;
                        v74 = v70;
                        v70 = v71;
                    else
                        v70.next = v73;
                        v70 = v70.next;
                    end;

                    u11.lanes = mergeLanes(u11.lanes, lane);
                    markSkippedUpdateLanes(lane);
                end;
            end;

            next = next.next;
        until next == nil or next == next;

        if v70 == nil then
            v72 = baseState;
        else
            v70.next = v71;
        end;

        local memoizedState = v68.memoizedState;
        local v75;

        if baseState == memoizedState and (baseState ~= 0 or 1 / baseState == 1 / memoizedState) then
            v75 = true;
        elseif baseState == baseState then
            v75 = false;
        else
            v75 = memoizedState ~= memoizedState;
        end;

        if not v75 then
            markWorkInProgressReceivedUpdate();
        end;

        v68.memoizedState = baseState;
        v68.baseState = v72;
        v68.baseQueue = v70;
        queue.lastRenderedState = baseState;
    end;

    return v68.memoizedState, queue.dispatch;
end;

function rerenderReducer(p76: function, p77: any, p78: function?)
    -- upvalues: updateWorkInProgressHook (copy), markWorkInProgressReceivedUpdate (copy)
    local v79 = updateWorkInProgressHook();
    local queue = v79.queue;
    assert(queue ~= nil, "Should have a queue. This is likely a bug in React. Please file an issue.");
    queue.lastRenderedReducer = p76;
    local dispatch = queue.dispatch;
    local pending = queue.pending;
    local memoizedState = v79.memoizedState;

    if pending ~= nil then
        queue.pending = nil;
        local next = pending.next;

        repeat
            memoizedState = p76(memoizedState, next.action);
            next = next.next;
        until next == next;

        local memoizedState2 = v79.memoizedState;
        local v80;

        if memoizedState == memoizedState2 and (memoizedState ~= 0 or 1 / memoizedState == 1 / memoizedState2) then
            v80 = true;
        elseif memoizedState == memoizedState then
            v80 = false;
        else
            v80 = memoizedState2 ~= memoizedState2;
        end;

        if not v80 then
            markWorkInProgressReceivedUpdate();
        end;

        v79.memoizedState = memoizedState;

        if v79.baseQueue == nil then
            v79.baseState = memoizedState;
        end;

        queue.lastRenderedState = memoizedState;
    end;

    return memoizedState, dispatch;
end;

function readFromUnsubcribedMutableSource(p81, p82, p83)
    -- upvalues: _G___DEV__ (copy), warnAboutMultipleRenderersDEV (copy), getWorkInProgressVersion (copy), isSubsetOfLanes (copy), u10 (ref), setWorkInProgressVersion (copy), console (copy), markSourceAsDirty (copy), Error (copy)
    if _G___DEV__ then
        warnAboutMultipleRenderersDEV(p82);
    end;

    local v84 = p82._getVersion(p82._source);
    local v85 = getWorkInProgressVersion(p82);
    local v86;

    if v85 == nil then
        v86 = isSubsetOfLanes(u10, p81.mutableReadLanes);

        if v86 then
            setWorkInProgressVersion(p82, v84);
        end;
    else
        v86 = v85 == v84;
    end;

    if v86 then
        local v87 = p83(p82._source);

        if _G___DEV__ and type(v87) == "function" then
            console.error("Mutable source should not return a function as the snapshot value. Functions may close over mutable values and cause tearing.");
        end;

        return v87;
    end;

    markSourceAsDirty(p82);
    error(Error.new("Cannot read from mutable source during the current render without tearing. This is a bug in React. Please file an issue."));
end;

function useMutableSource(p88: table, u89: any, u90: any, u91: any)
    -- upvalues: getWorkInProgressRoot (copy), invariant (copy), ReactCurrentDispatcher (copy), u13 (ref), u11 (ref), _G___DEV__ (copy), console (copy), requestUpdateLane (copy), markRootMutableRead (copy), markRootEntangled (copy)
    local u92 = getWorkInProgressRoot();
    invariant(u92 ~= nil, "Expected a work-in-progress root. This is a bug in React. Please file an issue.");
    local _getVersion = u89._getVersion;
    local u93 = _getVersion(u89._source);
    local current = ReactCurrentDispatcher.current;
    assert(current ~= nil, "dispatcher was nil, this is a bug in React");
    local v94, u95 = current.useState(function() -- Line: 979
        -- upvalues: u92 (copy), u89 (copy), u90 (copy)
        return readFromUnsubcribedMutableSource(u92, u89, u90);
    end);
    local u96 = v94;
    local v97 = u13;
    local memoizedState = p88.memoizedState;

    if memoizedState.refs == nil then
        error((tostring(debug.traceback())));
    end;

    local refs = memoizedState.refs;
    local getSnapshot = refs.getSnapshot;
    local source = memoizedState.source;
    local subscribe = memoizedState.subscribe;
    local u98 = u11;
    p88.memoizedState = {
        refs = refs,
        source = u89,
        subscribe = u91
    };
    current.useEffect(function() -- Line: 1008
        -- upvalues: refs (copy), u90 (copy), u95 (ref), _getVersion (copy), u89 (copy), u93 (copy), _G___DEV__ (ref), console (ref), u96 (ref), requestUpdateLane (ref), u98 (copy), markRootMutableRead (ref), u92 (copy), markRootEntangled (ref)
        refs.getSnapshot = u90;
        refs.setSnapshot = u95;
        local v99 = _getVersion(u89._source);
        local v100 = u93;
        local v101;

        if v100 == v99 and (v100 ~= 0 or 1 / v100 == 1 / v99) then
            v101 = true;
        elseif v100 == v100 then
            v101 = false;
        else
            v101 = v99 ~= v99;
        end;

        if not v101 then
            local v102 = u90(u89._source);

            if _G___DEV__ and type(v102) == "function" then
                console.error("Mutable source should not return a function as the snapshot value. Functions may close over mutable values and cause tearing.");
            end;

            local v103 = u96;
            local v104;

            if v103 == v102 and (v103 ~= 0 or 1 / v103 == 1 / v102) then
                v104 = true;
            elseif v103 == v103 then
                v104 = false;
            else
                v104 = v102 ~= v102;
            end;

            if not v104 then
                u95(v102);
                markRootMutableRead(u92, (requestUpdateLane(u98)));
            end;

            markRootEntangled(u92, u92.mutableReadLanes);
        end;
    end, { u90, u89, u91 });
    current.useEffect(function() -- Line: 1046
        -- upvalues: refs (copy), u89 (copy), requestUpdateLane (ref), u98 (copy), markRootMutableRead (ref), u92 (copy), u91 (copy), _G___DEV__ (ref), console (ref)
        local v105 = u91(u89._source, function() -- Line: 1047
            -- upvalues: refs (ref), u89 (ref), requestUpdateLane (ref), u98 (ref), markRootMutableRead (ref), u92 (ref)
            local getSnapshot2 = refs.getSnapshot;
            local setSnapshot = refs.setSnapshot;
            local success, result = pcall(function() -- Line: 1052
                -- upvalues: setSnapshot (copy), getSnapshot2 (copy), u89 (ref), requestUpdateLane (ref), u98 (ref), markRootMutableRead (ref), u92 (ref)
                setSnapshot(getSnapshot2(u89._source));
                markRootMutableRead(u92, (requestUpdateLane(u98)));
            end);

            if not success then
                setSnapshot(function() -- Line: 1066
                    -- upvalues: result (copy)
                    error(result);
                end);
            end;
        end);

        if _G___DEV__ and type(v105) ~= "function" then
            console.error("Mutable source subscribe function must return an unsubscribe function.");
        end;

        return v105;
    end, { u89, u91 });
    local v106;

    if getSnapshot == u90 and (getSnapshot ~= 0 or 1 / getSnapshot == 1 / u90) then
        v106 = true;
    elseif getSnapshot == getSnapshot then
        v106 = false;
    else
        v106 = u90 ~= u90;
    end;

    local u107, u108;

    if v106 then
        local v109;

        if source == u89 and (source ~= 0 or 1 / source == 1 / u89) then
            v109 = true;
        elseif source == source then
            v109 = false;
        else
            v109 = u89 ~= u89;
        end;

        if v109 then
            local v110;

            if subscribe == u91 and (subscribe ~= 0 or 1 / subscribe == 1 / u91) then
                v110 = true;
            elseif subscribe == subscribe then
                v110 = false;
            else
                v110 = u91 ~= u91;
            end;

            if not v110 then
                u107 = {
                    pending = nil,
                    dispatch = nil,
                    lastRenderedReducer = basicStateReducer,
                    lastRenderedState = u96
                };
                u108 = u11;

                u95 = function(...) -- Line: 1115
                    -- upvalues: u108 (copy), u107 (copy)
                    dispatchAction(u108, u107, ...);
                end;

                u107.dispatch = u95;
                v97.queue = u107;
                v97.baseQueue = nil;
                u96 = readFromUnsubcribedMutableSource(u92, u89, u90);
                v97.baseState = u96;
                v97.memoizedState = v97.baseState;
            end;
        else
            u107 = {
                pending = nil,
                dispatch = nil,
                lastRenderedReducer = basicStateReducer,
                lastRenderedState = u96
            };
            u108 = u11;

            u95 = function(...) -- Line: 1115
                -- upvalues: u108 (copy), u107 (copy)
                dispatchAction(u108, u107, ...);
            end;

            u107.dispatch = u95;
            v97.queue = u107;
            v97.baseQueue = nil;
            u96 = readFromUnsubcribedMutableSource(u92, u89, u90);
            v97.baseState = u96;
            v97.memoizedState = v97.baseState;
        end;
    else
        u107 = {
            pending = nil,
            dispatch = nil,
            lastRenderedReducer = basicStateReducer,
            lastRenderedState = u96
        };
        u108 = u11;

        u95 = function(...) -- Line: 1115
            -- upvalues: u108 (copy), u107 (copy)
            dispatchAction(u108, u107, ...);
        end;

        u107.dispatch = u95;
        v97.queue = u107;
        v97.baseQueue = nil;
        u96 = readFromUnsubcribedMutableSource(u92, u89, u90);
        v97.baseState = u96;
        v97.memoizedState = v97.baseState;
    end;

    return u96;
end;

function mountMutableSource(p111, p112, p113)
    -- upvalues: u13 (ref), u11 (ref)
    local v114 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v114;
        u13 = v114;
    else
        u13.next = v114;
        u13 = v114;
    end;

    local v115 = u13;
    v115.memoizedState = {
        refs = {
            setSnapshot = nil,
            getSnapshot = p112
        },
        source = p111,
        subscribe = p113
    };

    return useMutableSource(v115, p111, p112, p113);
end;

function updateMutableSource(p116, p117, p118)
    -- upvalues: updateWorkInProgressHook (copy)
    local v119 = updateWorkInProgressHook();

    return useMutableSource(v119, p116, p117, p118);
end;

function mountState(p120)
    -- upvalues: u13 (ref), u11 (ref)
    local v121 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v121;
        u13 = v121;
    else
        u13.next = v121;
        u13 = v121;
    end;

    local v122 = u13;

    if type(p120) == "function" then
        p120 = p120();
    end;

    v122.baseState = p120;
    v122.memoizedState = v122.baseState;
    local u123 = {
        pending = nil,
        dispatch = nil,
        lastRenderedReducer = nil,
        lastRenderedState = p120,
        lastRenderedReducer = basicStateReducer
    };
    v122.queue = u123;
    local u124 = u11;

    local function v126(p125, ...) -- Line: 1189
        -- upvalues: u124 (copy), u123 (copy)
        dispatchAction(u124, u123, p125, ...);
    end;

    u123.dispatch = v126;

    return v122.memoizedState, v126;
end;

function updateState(p127)
    return updateReducer(basicStateReducer, p127);
end;

function rerenderState(p128)
    return rerenderReducer(basicStateReducer, p128);
end;

local function pushEffect(p129, p130, p131, p132) -- Line: 1206
    -- upvalues: u11 (ref)
    local v133 = {
        next = nil,
        tag = p129,
        create = p130,
        destroy = p131,
        deps = p132
    };
    local updateQueue = u11.updateQueue;

    if updateQueue == nil then
        local v134 = {
            lastEffect = nil
        };
        u11.updateQueue = v134;
        v133.next = v133;
        v134.lastEffect = v133;

        return v133;
    end;

    local lastEffect = updateQueue.lastEffect;

    if lastEffect == nil then
        updateQueue.lastEffect = v133;
        v133.next = v133;

        return v133;
    end;

    local next = lastEffect.next;
    lastEffect.next = v133;
    v133.next = next;
    updateQueue.lastEffect = v133;

    return v133;
end;

function mountBinding(p135)
    -- upvalues: u13 (ref), u11 (ref), createBinding (copy)
    local v136 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v136;
        u13 = v136;
    else
        u13.next = v136;
        u13 = v136;
    end;

    local v137, v138 = createBinding(p135);
    u13.memoizedState = { v137, v138 };

    return v137, v138;
end;

function updateBinding(p139)
    -- upvalues: updateWorkInProgressHook (copy)
    local memoizedState = updateWorkInProgressHook().memoizedState;

    return unpack(memoizedState);
end;

function mountRef(p140)
    -- upvalues: u13 (ref), u11 (ref), createRef (copy)
    local v141 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v141;
        u13 = v141;
    else
        u13.next = v141;
        u13 = v141;
    end;

    local v142 = createRef();
    v142.current = p140;
    u13.memoizedState = v142;

    return v142;
end;

function updateRef(p143)
    -- upvalues: updateWorkInProgressHook (copy)
    return updateWorkInProgressHook().memoizedState;
end;

local function mountEffectImpl(p144, p145, p146, p147) -- Line: 1273
    -- upvalues: u13 (ref), u11 (ref), pushEffect (copy), HasEffect (copy)
    local v148 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v148;
        u13 = v148;
    else
        u13.next = v148;
        u13 = v148;
    end;

    u11.flags = bit32.bor(u11.flags, p144);
    u13.memoizedState = pushEffect(bit32.bor(HasEffect, p145), p146, nil, p147);
end;

function updateEffectImpl(p149: any, p150: any, p151: any, p152: table?)
    -- upvalues: updateWorkInProgressHook (copy), u12 (ref), areHookInputsEqual (copy), pushEffect (copy), u11 (ref), HasEffect (copy)
    local v153 = updateWorkInProgressHook();
    local v154;

    if u12 == nil then
        v154 = nil;
    else
        local memoizedState = u12.memoizedState;
        v154 = memoizedState.destroy;

        if p152 ~= nil and areHookInputsEqual(p152, memoizedState.deps) then
            v153.memoizedState = pushEffect(p150, p151, v154, p152);

            return;
        end;
    end;

    u11.flags = bit32.bor(u11.flags, p149);
    v153.memoizedState = pushEffect(bit32.bor(HasEffect, p150), p151, v154, p152);
end;

local function mountEffect(p155: function, p156: table?) -- Line: 1311
    -- upvalues: _G___DEV__ (copy), warnIfNotCurrentlyActingEffectsInDEV (copy), u11 (ref), enableDoubleInvokingEffects (copy), MountPassiveDev (copy), Passive (copy), PassiveStatic (copy), Passive2 (copy), u13 (ref), pushEffect (copy), HasEffect (copy)
    if _G___DEV__ and (type(_G.jest) ~= "nil" or _G.__TESTEZ_RUNNING_TEST__) then
        warnIfNotCurrentlyActingEffectsInDEV(u11);
    end;

    if _G___DEV__ and enableDoubleInvokingEffects then
        local bit32_bor_ret = bit32.bor(MountPassiveDev, Passive, PassiveStatic);
        local v157 = {
            memoizedState = nil,
            baseState = nil,
            baseQueue = nil,
            queue = nil,
            next = nil
        };

        if u13 == nil then
            u11.memoizedState = v157;
            u13 = v157;
        else
            u13.next = v157;
            u13 = v157;
        end;

        u11.flags = bit32.bor(u11.flags, bit32_bor_ret);
        u13.memoizedState = pushEffect(bit32.bor(HasEffect, Passive2), p155, nil, p156);

        return;
    end;

    local bit32_bor_ret = bit32.bor(Passive, PassiveStatic);
    local v158 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v158;
        u13 = v158;
    else
        u13.next = v158;
        u13 = v158;
    end;

    u11.flags = bit32.bor(u11.flags, bit32_bor_ret);
    u13.memoizedState = pushEffect(bit32.bor(HasEffect, Passive2), p155, nil, p156);
end;

local function updateEffect(p159: function, p160: table?) -- Line: 1341
    -- upvalues: _G___DEV__ (copy), warnIfNotCurrentlyActingEffectsInDEV (copy), u11 (ref), Passive (copy), Passive2 (copy)
    if _G___DEV__ and (type(_G.jest) ~= "nil" or _G.__TESTEZ_RUNNING_TEST__) then
        warnIfNotCurrentlyActingEffectsInDEV(u11);
    end;

    updateEffectImpl(Passive, Passive2, p159, p160);
end;

local function mountLayoutEffect(p161: function, p162: table?) -- Line: 1356
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), MountLayoutDev (copy), Update (copy), Layout (copy), u13 (ref), u11 (ref), pushEffect (copy), HasEffect (copy)
    if _G___DEV__ and enableDoubleInvokingEffects then
        local bit32_bor_ret = bit32.bor(MountLayoutDev, Update);
        local v163 = {
            memoizedState = nil,
            baseState = nil,
            baseQueue = nil,
            queue = nil,
            next = nil
        };

        if u13 == nil then
            u11.memoizedState = v163;
            u13 = v163;
        else
            u13.next = v163;
            u13 = v163;
        end;

        u11.flags = bit32.bor(u11.flags, bit32_bor_ret);
        u13.memoizedState = pushEffect(bit32.bor(HasEffect, Layout), p161, nil, p162);

        return;
    end;

    local v164 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v164;
        u13 = v164;
    else
        u13.next = v164;
        u13 = v164;
    end;

    u11.flags = bit32.bor(u11.flags, Update);
    u13.memoizedState = pushEffect(bit32.bor(HasEffect, Layout), p161, nil, p162);
end;

local function updateLayoutEffect(p165: function, p166: table?) -- Line: 1373
    -- upvalues: Update (copy), Layout (copy)
    updateEffectImpl(Update, Layout, p165, p166);
end;

function imperativeHandleEffect(p167: function, u168: any)
    -- upvalues: _G___DEV__ (copy), Object (copy), console (copy), Array (copy)
    if u168 ~= nil and type(u168) == "function" then
        u168((p167()));

        return function() -- Line: 1390
            -- upvalues: u168 (copy)
            return u168(nil);
        end;
    end;

    if u168 == nil then
        return nil;
    end;

    if _G___DEV__ then
        local v169;

        if getmetatable(u168) == nil then
            v169 = false;
        else
            v169 = #Object.keys(u168) == 0;
        end;

        if not v169 then
            console.error("Expected useImperativeHandle() first argument to either be a ref callback or React.createRef() object. Instead received: %s.", "an object with keys {" .. Array.join(Object.keys(u168), ", ") .. "}");
        end;
    end;

    u168.current = p167();

    return function() -- Line: 1415
        -- upvalues: u168 (copy)
        u168.current = nil;
    end;
end;

function mountImperativeHandle(u170: any, u171: function, p172: table?)
    -- upvalues: _G___DEV__ (copy), console (copy), Array (copy), enableDoubleInvokingEffects (copy), mountEffectImpl (copy), MountLayoutDev (copy), Update (copy), Layout (copy)
    if _G___DEV__ and type(u171) ~= "function" then
        console.error("Expected useImperativeHandle() second argument to be a function that creates a handle. Instead received: %s.", u171 == nil and "nil" or type(u171));
    end;

    local v173;

    if p172 == nil then
        v173 = nil;
    else
        v173 = Array.concat(p172, { u170 });
    end;

    if _G___DEV__ and enableDoubleInvokingEffects then
        return mountEffectImpl(bit32.bor(MountLayoutDev, Update), Layout, function() -- Line: 1447
            -- upvalues: u171 (copy), u170 (copy)
            return imperativeHandleEffect(u171, u170);
        end, v173);
    end;

    return mountEffectImpl(Update, Layout, function() -- Line: 1453
        -- upvalues: u171 (copy), u170 (copy)
        return imperativeHandleEffect(u171, u170);
    end, v173);
end;

function updateImperativeHandle(u174: any, u175: function, p176: table?)
    -- upvalues: _G___DEV__ (copy), console (copy), Update (copy), Layout (copy)
    if _G___DEV__ and type(u175) ~= "function" then
        local v177 = not u175 and "nil" or type(u175);
        console.error("Expected useImperativeHandle() second argument to be a function that creates a handle. Instead received: %s.", v177);
    end;

    local v178;

    if p176 == nil then
        v178 = nil;
    else
        v178 = table.clone(p176);
        table.insert(v178, u174);
    end;

    return updateEffectImpl(Update, Layout, function() -- Line: 1486
        -- upvalues: u175 (copy), u174 (copy)
        return imperativeHandleEffect(u175, u174);
    end, v178);
end;

function mountDebugValue(p179: any, p180: function?)
end;

local u181 = mountDebugValue;

function mountCallback(p182: any, p183: table?)
    -- upvalues: u13 (ref), u11 (ref)
    local v184 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v184;
        u13 = v184;
    else
        u13.next = v184;
        u13 = v184;
    end;

    u13.memoizedState = { p182, p183 };

    return p182;
end;

function updateCallback(p185: any, p186: table?)
    -- upvalues: updateWorkInProgressHook (copy), areHookInputsEqual (copy)
    local v187 = updateWorkInProgressHook();
    local memoizedState = v187.memoizedState;

    if memoizedState ~= nil and (p186 ~= nil and areHookInputsEqual(p186, memoizedState[2])) then
        return memoizedState[1];
    end;

    v187.memoizedState = { p185, p186 };

    return p185;
end;

function mountMemo(p188: function, p189: table?)
    -- upvalues: u13 (ref), u11 (ref)
    local v190 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v190;
        u13 = v190;
    else
        u13.next = v190;
        u13 = v190;
    end;

    local v191 = { p188() };
    u13.memoizedState = { v191, p189 };

    return unpack(v191);
end;

function updateMemo(p192: function, p193: table?)
    -- upvalues: updateWorkInProgressHook (copy), areHookInputsEqual (copy)
    local v194 = updateWorkInProgressHook();
    local memoizedState = v194.memoizedState;

    if memoizedState ~= nil and (p193 ~= nil and areHookInputsEqual(p193, memoizedState[2])) then
        return unpack(memoizedState[1]);
    end;

    local v195 = { p192() };
    v194.memoizedState = { v195, p193 };

    return unpack(v195);
end;

function u9.getIsUpdatingOpaqueValueInRenderPhaseInDEV() -- Line: 1688
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        return false;
    end;

    return nil;
end;

function mountOpaqueIdentifier()
    -- upvalues: _G___DEV__ (copy), console (copy), makeClientId (copy), getIsHydrating (copy)
    local v196 = nil;

    if _G___DEV__ then
        console.warn("!!! unimplemented: warnOnOpaqueIdentifierAccessInDEV");
    else
        v196 = makeClientId;
    end;

    if not getIsHydrating() then
        local v197 = v196();
        mountState(v197);

        return v197;
    end;

    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: ReactFiberHooks: getIsHydrating() true");
    error("FIXME (roblox): ReactFiberHooks: getIsHydrating() true is unimplemented");

    return nil;
end;

function updateOpaqueIdentifier()
    local v198, _ = updateState(nil);

    return v198;
end;

function rerenderOpaqueIdentifier()
    local v199, _ = rerenderState(nil);

    return v199;
end;

function dispatchAction(p200: any, p201: table, p202: any, ...)
    -- upvalues: _G___DEV__ (copy), console (copy), requestEventTime (copy), requestUpdateLane (copy), u11 (ref), u14 (ref), u15 (ref), NoLanes (copy), ReactCurrentDispatcher (copy), u24 (ref), warnIfNotScopedWithMatchingAct (copy), warnIfNotCurrentlyActingUpdatesInDEV (copy), scheduleUpdateOnFiber (copy), enableDebugTracing (copy), DebugTracingMode (copy), getComponentName (copy), logStateUpdateScheduled (copy), enableSchedulingProfiler (copy), markStateUpdateScheduled (copy)
    if _G___DEV__ then
        local v203;

        if select("#", ...) == 1 then
            v203 = select(1, ...);
        else
            v203 = nil;
        end;

        if type(v203) == "function" then
            console.error("State updates from the useState() and useReducer() Hooks don\'t support the second callback argument. To execute a side effect after rendering, declare it in the component body with useEffect().");
        end;
    end;

    local v204 = requestEventTime();
    local v205 = requestUpdateLane(p200);
    local v206 = {
        eagerReducer = nil,
        eagerState = nil,
        next = nil,
        lane = v205,
        action = p202
    };
    local pending = p201.pending;

    if pending == nil then
        v206.next = v206;
    else
        v206.next = pending.next;
        pending.next = v206;
    end;

    p201.pending = v206;
    local alternate = p200.alternate;

    if p200 == u11 or alternate ~= nil and alternate == u11 then
        u14 = true;
        u15 = true;
    else
        if p200.lanes == NoLanes and (alternate == nil or alternate.lanes == NoLanes) then
            local lastRenderedReducer = p201.lastRenderedReducer;

            if lastRenderedReducer ~= nil then
                local v207;

                if _G___DEV__ then
                    v207 = ReactCurrentDispatcher.current;
                    ReactCurrentDispatcher.current = u24;
                else
                    v207 = nil;
                end;

                local lastRenderedState = p201.lastRenderedState;
                local success, result = pcall(lastRenderedReducer, lastRenderedState, p202);

                if success then
                    v206.eagerReducer = lastRenderedReducer;
                    v206.eagerState = result;
                end;

                if _G___DEV__ then
                    ReactCurrentDispatcher.current = v207;
                end;

                local v208;

                if result == lastRenderedState and (result ~= 0 or 1 / result == 1 / lastRenderedState) then
                    v208 = true;
                elseif result == result then
                    v208 = false;
                else
                    v208 = lastRenderedState ~= lastRenderedState;
                end;

                if v208 then
                    return;
                end;
            end;
        end;

        if _G___DEV__ and (type(_G.jest) ~= "nil" or _G.__TESTEZ_RUNNING_TEST__) then
            warnIfNotScopedWithMatchingAct(p200);
            warnIfNotCurrentlyActingUpdatesInDEV(p200);
        end;

        scheduleUpdateOnFiber(p200, v205, v204);
    end;

    if _G___DEV__ and (enableDebugTracing and bit32.band(p200.mode, DebugTracingMode) ~= 0) then
        logStateUpdateScheduled(getComponentName(p200.type) or "Unknown", v205, p202);
    end;

    if enableSchedulingProfiler then
        markStateUpdateScheduled(p200, v205);
    end;
end;

local u209 = {
    readContext = readContext,
    useCallback = throwInvalidHookError,
    useContext = throwInvalidHookError,
    useEffect = throwInvalidHookError,
    useImperativeHandle = throwInvalidHookError,
    useLayoutEffect = throwInvalidHookError,
    useMemo = throwInvalidHookError,
    useReducer = throwInvalidHookError,
    useRef = throwInvalidHookError,
    useBinding = throwInvalidHookError,
    useState = throwInvalidHookError,
    useDebugValue = throwInvalidHookError,
    useMutableSource = throwInvalidHookError,
    useOpaqueIdentifier = throwInvalidHookError,
    unstable_isNewReconciler = enableNewReconciler
};
u9.ContextOnlyDispatcher = u209;
local u210 = {
    readContext = readContext,
    useCallback = mountCallback,
    useContext = readContext,
    useEffect = mountEffect,
    useImperativeHandle = mountImperativeHandle,
    useLayoutEffect = mountLayoutEffect,
    useMemo = mountMemo,
    useReducer = mountReducer,
    useRef = mountRef,
    useBinding = mountBinding,
    useState = mountState,
    useDebugValue = mountDebugValue,
    useMutableSource = mountMutableSource,
    useOpaqueIdentifier = mountOpaqueIdentifier,
    unstable_isNewReconciler = enableNewReconciler
};
local u211 = {
    readContext = readContext,
    useCallback = updateCallback,
    useContext = readContext,
    useEffect = updateEffect,
    useImperativeHandle = updateImperativeHandle,
    useLayoutEffect = updateLayoutEffect,
    useMemo = updateMemo,
    useReducer = updateReducer,
    useRef = updateRef,
    useBinding = updateBinding,
    useState = updateState,
    useDebugValue = u181,
    useMutableSource = updateMutableSource,
    useOpaqueIdentifier = updateOpaqueIdentifier,
    unstable_isNewReconciler = enableNewReconciler
};
local u212 = {
    readContext = readContext,
    useCallback = updateCallback,
    useContext = readContext,
    useEffect = updateEffect,
    useImperativeHandle = updateImperativeHandle,
    useLayoutEffect = updateLayoutEffect,
    useMemo = updateMemo,
    useReducer = rerenderReducer,
    useRef = updateRef,
    useBinding = updateBinding,
    useState = rerenderState,
    useDebugValue = u181,
    useMutableSource = updateMutableSource,
    useOpaqueIdentifier = rerenderOpaqueIdentifier,
    unstable_isNewReconciler = enableNewReconciler
};

if _G___DEV__ then
    local function _() -- Line: 2002
        -- upvalues: console (copy)
        console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().");
    end;

    local function _() -- Line: 2011
        -- upvalues: console (copy)
        console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
    end;

    u19 = {
        readContext = function(p213, p214) -- Line: 2021, Name: readContext
            -- upvalues: readContext (copy)
            return readContext(p213, p214);
        end,

        useCallback = function(p215: any, p216: table?) -- Line: 2024, Name: useCallback
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy)
            u16 = "useCallback";

            if _G___DEV__ then
                local v217 = u16;

                if u17 == nil then
                    u17 = { v217 };
                else
                    table.insert(u17, v217);
                end;
            end;

            if _G___DEV__ and p216 ~= nil then
                local v218;

                if type(p216) == "table" then
                    v218 = true;

                    for i, _ in p216 do
                        if type(i) ~= "number" then
                            v218 = false;
                            break;
                        end;
                    end;
                else
                    v218 = false;
                end;

                if not v218 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p216)));
                end;
            end;

            return mountCallback(p215, p216);
        end,

        useContext = function(p219, p220) -- Line: 2030, Name: useContext
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), readContext (copy)
            u16 = "useContext";

            if _G___DEV__ then
                local v221 = u16;

                if u17 == nil then
                    u17 = { v221 };
                else
                    table.insert(u17, v221);
                end;
            end;

            return readContext(p219, p220);
        end,

        useEffect = function(p222: function, p223: table?) -- Line: 2035, Name: useEffect
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy), mountEffect (copy)
            u16 = "useEffect";

            if _G___DEV__ then
                local v224 = u16;

                if u17 == nil then
                    u17 = { v224 };
                else
                    table.insert(u17, v224);
                end;
            end;

            if _G___DEV__ and p223 ~= nil then
                local v225;

                if type(p223) == "table" then
                    v225 = true;

                    for i, _ in p223 do
                        if type(i) ~= "number" then
                            v225 = false;
                            break;
                        end;
                    end;
                else
                    v225 = false;
                end;

                if not v225 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p223)));
                end;
            end;

            return mountEffect(p222, p223);
        end,

        useImperativeHandle = function(p226: any, p227: function, p228: table?) -- Line: 2045, Name: useImperativeHandle
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy)
            u16 = "useImperativeHandle";

            if _G___DEV__ then
                local v229 = u16;

                if u17 == nil then
                    u17 = { v229 };
                else
                    table.insert(u17, v229);
                end;
            end;

            if _G___DEV__ and p228 ~= nil then
                local v230;

                if type(p228) == "table" then
                    v230 = true;

                    for i, _ in p228 do
                        if type(i) ~= "number" then
                            v230 = false;
                            break;
                        end;
                    end;
                else
                    v230 = false;
                end;

                if not v230 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p228)));
                end;
            end;

            return mountImperativeHandle(p226, p227, p228);
        end,

        useLayoutEffect = function(p231: function, p232: table?) -- Line: 2055, Name: useLayoutEffect
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy), mountLayoutEffect (copy)
            u16 = "useLayoutEffect";

            if _G___DEV__ then
                local v233 = u16;

                if u17 == nil then
                    u17 = { v233 };
                else
                    table.insert(u17, v233);
                end;
            end;

            if _G___DEV__ and p232 ~= nil then
                local v234;

                if type(p232) == "table" then
                    v234 = true;

                    for i, _ in p232 do
                        if type(i) ~= "number" then
                            v234 = false;
                            break;
                        end;
                    end;
                else
                    v234 = false;
                end;

                if not v234 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p232)));
                end;
            end;

            return mountLayoutEffect(p231, p232);
        end,

        useMemo = function(p235: function, p236: table?) -- Line: 2066
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useMemo";

            if _G___DEV__ then
                local v237 = u16;

                if u17 == nil then
                    u17 = { v237 };
                else
                    table.insert(u17, v237);
                end;
            end;

            if _G___DEV__ and p236 ~= nil then
                local v238;

                if type(p236) == "table" then
                    v238 = true;

                    for i, _ in p236 do
                        if type(i) ~= "number" then
                            v238 = false;
                            break;
                        end;
                    end;
                else
                    v238 = false;
                end;

                if not v238 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p236)));
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v239 = { pcall(mountMemo, p235, p236) };
            ReactCurrentDispatcher.current = current;

            if not v239[1] then
                error(v239[2]);
            end;

            return unpack(v239, 2);
        end,

        useReducer = function(p240: function, p241: any, p242: function?) -- Line: 2084, Name: useReducer
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useReducer";

            if _G___DEV__ then
                local v243 = u16;

                if u17 == nil then
                    u17 = { v243 };
                else
                    table.insert(u17, v243);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v244, v245, v246 = pcall(mountReducer, p240, p241, p242);
            ReactCurrentDispatcher.current = current;

            if not v244 then
                error(v245);
            end;

            return v245, v246;
        end,

        useRef = function(p247) -- Line: 2102, Name: useRef
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useRef";

            if _G___DEV__ then
                local v248 = u16;

                if u17 == nil then
                    u17 = { v248 };
                else
                    table.insert(u17, v248);
                end;
            end;

            return mountRef(p247);
        end,

        useBinding = function(p249) -- Line: 2108, Name: useBinding
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useBinding";

            if _G___DEV__ then
                local v250 = u16;

                if u17 == nil then
                    u17 = { v250 };
                else
                    table.insert(u17, v250);
                end;
            end;

            return mountBinding(p249);
        end,

        useState = function(p251) -- Line: 2113, Name: useState
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useState";

            if _G___DEV__ then
                local v252 = u16;

                if u17 == nil then
                    u17 = { v252 };
                else
                    table.insert(u17, v252);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v253, v254, v255 = pcall(mountState, p251);
            ReactCurrentDispatcher.current = current;

            if not v253 then
                error(v254);
            end;

            return v254, v255;
        end,

        useDebugValue = function(p256: any, p257: function?) -- Line: 2127, Name: useDebugValue
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useDebugValue";

            if _G___DEV__ then
                local v258 = u16;

                if u17 == nil then
                    u17 = { v258 };
                else
                    table.insert(u17, v258);
                end;
            end;

            return mountDebugValue(p256, p257);
        end,

        useMutableSource = function(p259, p260, p261) -- Line: 2142, Name: useMutableSource
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useMutableSource";

            if _G___DEV__ then
                local v262 = u16;

                if u17 == nil then
                    u17 = { v262 };
                else
                    table.insert(u17, v262);
                end;
            end;

            return mountMutableSource(p259, p260, p261);
        end,

        useOpaqueIdentifier = function() -- Line: 2157, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useOpaqueIdentifier";

            if _G___DEV__ then
                local v263 = u16;

                if u17 == nil then
                    u17 = { v263 };
                else
                    table.insert(u17, v263);
                end;
            end;

            return mountOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u20 = {
        readContext = function(p264, p265) -- Line: 2167, Name: readContext
            -- upvalues: readContext (copy)
            return readContext(p264, p265);
        end,

        useCallback = function(p266: any, p267: table?) -- Line: 2170, Name: useCallback
            -- upvalues: u16 (ref), _G___DEV__ (copy), console (copy)
            u16 = "useCallback";
            updateHookTypesDev();

            if _G___DEV__ and p267 ~= nil then
                local v268;

                if type(p267) == "table" then
                    v268 = true;

                    for i, _ in p267 do
                        if type(i) ~= "number" then
                            v268 = false;
                            break;
                        end;
                    end;
                else
                    v268 = false;
                end;

                if not v268 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p267)));
                end;
            end;

            return mountCallback(p266, p267);
        end,

        useContext = function(p269, p270) -- Line: 2176, Name: useContext
            -- upvalues: u16 (ref), readContext (copy)
            u16 = "useContext";
            updateHookTypesDev();

            return readContext(p269, p270);
        end,

        useEffect = function(p271: function, p272: table?) -- Line: 2181, Name: useEffect
            -- upvalues: u16 (ref), mountEffect (copy)
            u16 = "useEffect";
            updateHookTypesDev();

            return mountEffect(p271, p272);
        end,

        useImperativeHandle = function(p273: any, p274: function, p275: table?) -- Line: 2190, Name: useImperativeHandle
            -- upvalues: u16 (ref)
            u16 = "useImperativeHandle";
            updateHookTypesDev();

            return mountImperativeHandle(p273, p274, p275);
        end,

        useLayoutEffect = function(p276: function, p277: table?) -- Line: 2199, Name: useLayoutEffect
            -- upvalues: u16 (ref), mountLayoutEffect (copy)
            u16 = "useLayoutEffect";
            updateHookTypesDev();

            return mountLayoutEffect(p276, p277);
        end,

        useMemo = function(p278: function, p279: table?) -- Line: 2209
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useMemo";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v280 = { pcall(mountMemo, p278, p279) };
            ReactCurrentDispatcher.current = current;

            if not v280[1] then
                error(v280[2]);
            end;

            return unpack(v280, 2);
        end,

        useReducer = function(p281: function, p282: any, p283: function?) -- Line: 2225, Name: useReducer
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useReducer";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v284, v285, v286 = pcall(mountReducer, p281, p282, p283);
            ReactCurrentDispatcher.current = current;

            if not v284 then
                error(v285);
            end;

            return v285, v286;
        end,

        useRef = function(p287) -- Line: 2243, Name: useRef
            -- upvalues: u16 (ref)
            u16 = "useRef";
            updateHookTypesDev();

            return mountRef(p287);
        end,

        useBinding = function(p288) -- Line: 2249, Name: useBinding
            -- upvalues: u16 (ref)
            u16 = "useBinding";
            updateHookTypesDev();

            return mountBinding(p288);
        end,

        useState = function(p289) -- Line: 2254, Name: useState
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useState";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v290, v291, v292 = pcall(mountState, p289);
            ReactCurrentDispatcher.current = current;

            if not v290 then
                error(v291);
            end;

            return v291, v292;
        end,

        useDebugValue = function(p293: any, p294: function?) -- Line: 2268, Name: useDebugValue
            -- upvalues: u16 (ref)
            u16 = "useDebugValue";
            updateHookTypesDev();

            return mountDebugValue(p293, p294);
        end,

        useMutableSource = function(p295, p296, p297) -- Line: 2283, Name: useMutableSource
            -- upvalues: u16 (ref)
            u16 = "useMutableSource";
            updateHookTypesDev();

            return mountMutableSource(p295, p296, p297);
        end,

        useOpaqueIdentifier = function() -- Line: 2298, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref)
            u16 = "useOpaqueIdentifier";
            updateHookTypesDev();

            return mountOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u21 = {
        readContext = function(p298, p299) -- Line: 2308, Name: readContext
            -- upvalues: readContext (copy)
            return readContext(p298, p299);
        end,

        useCallback = function(p300: any, p301: table?) -- Line: 2311, Name: useCallback
            -- upvalues: u16 (ref)
            u16 = "useCallback";
            updateHookTypesDev();

            return updateCallback(p300, p301);
        end,

        useContext = function(p302, p303) -- Line: 2316, Name: useContext
            -- upvalues: u16 (ref), readContext (copy)
            u16 = "useContext";
            updateHookTypesDev();

            return readContext(p302, p303);
        end,

        useEffect = function(p304: function, p305: table?) -- Line: 2321, Name: useEffect
            -- upvalues: u16 (ref), updateEffect (copy)
            u16 = "useEffect";
            updateHookTypesDev();

            return updateEffect(p304, p305);
        end,

        useImperativeHandle = function(p306: any, p307: function, p308: table?) -- Line: 2330, Name: useImperativeHandle
            -- upvalues: u16 (ref)
            u16 = "useImperativeHandle";
            updateHookTypesDev();

            return updateImperativeHandle(p306, p307, p308);
        end,

        useLayoutEffect = function(p309: function, p310: table?) -- Line: 2339, Name: useLayoutEffect
            -- upvalues: u16 (ref), updateLayoutEffect (copy)
            u16 = "useLayoutEffect";
            updateHookTypesDev();

            return updateLayoutEffect(p309, p310);
        end,

        useMemo = function(p311: function, p312: table?) -- Line: 2349
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useMemo";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v313 = { pcall(updateMemo, p311, p312) };
            ReactCurrentDispatcher.current = current;

            if not v313[1] then
                error(v313[2]);
            end;

            return unpack(v313, 2);
        end,

        useReducer = function(p314: function, p315: any, p316: function?) -- Line: 2365, Name: useReducer
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useReducer";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v317, v318, v319 = pcall(updateReducer, p314, p315, p316);
            ReactCurrentDispatcher.current = current;

            if not v317 then
                error(v318);
            end;

            return v318, v319;
        end,

        useRef = function(p320) -- Line: 2383, Name: useRef
            -- upvalues: u16 (ref)
            u16 = "useRef";
            updateHookTypesDev();

            return updateRef(p320);
        end,

        useBinding = function(p321) -- Line: 2389, Name: useBinding
            -- upvalues: u16 (ref)
            u16 = "useBinding";
            updateHookTypesDev();

            return updateBinding(p321);
        end,

        useState = function(p322) -- Line: 2394, Name: useState
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useState";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v323, v324, v325 = pcall(updateState, p322);
            ReactCurrentDispatcher.current = current;

            if not v323 then
                error(v324);
            end;

            return v324, v325;
        end,

        useDebugValue = function(p326: any, p327: function?) -- Line: 2408, Name: useDebugValue
            -- upvalues: u16 (ref), u181 (copy)
            u16 = "useDebugValue";
            updateHookTypesDev();

            return u181(p326, p327);
        end,

        useMutableSource = function(p328, p329, p330) -- Line: 2423, Name: useMutableSource
            -- upvalues: u16 (ref)
            u16 = "useMutableSource";
            updateHookTypesDev();

            return updateMutableSource(p328, p329, p330);
        end,

        useOpaqueIdentifier = function() -- Line: 2438, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref)
            u16 = "useOpaqueIdentifier";
            updateHookTypesDev();

            return updateOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u22 = {
        readContext = function(p331, p332) -- Line: 2448, Name: readContext
            -- upvalues: readContext (copy)
            return readContext(p331, p332);
        end,

        useCallback = function(p333: any, p334: table?) -- Line: 2451, Name: useCallback
            -- upvalues: u16 (ref)
            u16 = "useCallback";
            updateHookTypesDev();

            return mountCallback(p333, p334);
        end,

        useContext = function(p335, p336) -- Line: 2456, Name: useContext
            -- upvalues: u16 (ref), readContext (copy)
            u16 = "useContext";
            updateHookTypesDev();

            return readContext(p335, p336);
        end,

        useEffect = function(p337: function, p338: table?) -- Line: 2461, Name: useEffect
            -- upvalues: u16 (ref), updateEffect (copy)
            u16 = "useEffect";
            updateHookTypesDev();

            return updateEffect(p337, p338);
        end,

        useImperativeHandle = function(p339: any, p340: function, p341: table?) -- Line: 2470, Name: useImperativeHandle
            -- upvalues: u16 (ref)
            u16 = "useImperativeHandle";
            updateHookTypesDev();

            return updateImperativeHandle(p339, p340, p341);
        end,

        useLayoutEffect = function(p342: function, p343: table?) -- Line: 2479, Name: useLayoutEffect
            -- upvalues: u16 (ref), updateLayoutEffect (copy)
            u16 = "useLayoutEffect";
            updateHookTypesDev();

            return updateLayoutEffect(p342, p343);
        end,

        useMemo = function(p344: function, p345: table?) -- Line: 2489
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u25 (ref)
            u16 = "useMemo";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u25;
            local v346 = { pcall(updateMemo, p344, p345) };
            ReactCurrentDispatcher.current = current;

            if not v346[1] then
                error(v346[2]);
            end;

            return unpack(v346, 2);
        end,

        useReducer = function(p347: function, p348: any, p349: function?) -- Line: 2505, Name: useReducer
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u25 (ref)
            u16 = "useReducer";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u25;
            local v350, v351, v352 = pcall(rerenderReducer, p347, p348, p349);
            ReactCurrentDispatcher.current = current;

            if not v350 then
                error(v351);
            end;

            return v351, v352;
        end,

        useRef = function(p353) -- Line: 2524, Name: useRef
            -- upvalues: u16 (ref)
            u16 = "useRef";
            updateHookTypesDev();

            return updateRef(p353);
        end,

        useBinding = function(p354) -- Line: 2530, Name: useBinding
            -- upvalues: u16 (ref)
            u16 = "useBinding";
            updateHookTypesDev();

            return updateBinding(p354);
        end,

        useState = function(p355) -- Line: 2535, Name: useState
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u25 (ref)
            u16 = "useState";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u25;
            local v356, v357, v358 = pcall(rerenderState, p355);
            ReactCurrentDispatcher.current = current;

            if not v356 then
                error(v357);
            end;

            return v357, v358;
        end,

        useDebugValue = function(p359: any, p360: function?) -- Line: 2549, Name: useDebugValue
            -- upvalues: u16 (ref), u181 (copy)
            u16 = "useDebugValue";
            updateHookTypesDev();

            return u181(p359, p360);
        end,

        useMutableSource = function(p361, p362, p363) -- Line: 2564, Name: useMutableSource
            -- upvalues: u16 (ref)
            u16 = "useMutableSource";
            updateHookTypesDev();

            return updateMutableSource(p361, p362, p363);
        end,

        useOpaqueIdentifier = function() -- Line: 2579, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref)
            u16 = "useOpaqueIdentifier";
            updateHookTypesDev();

            return rerenderOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u23 = {
        readContext = function(p364, p365) -- Line: 2589, Name: readContext
            -- upvalues: console (copy), readContext (copy)
            console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().");

            return readContext(p364, p365);
        end,

        useCallback = function(p366: any, p367: table?) -- Line: 2593, Name: useCallback
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useCallback";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v368 = u16;

                if u17 == nil then
                    u17 = { v368 };
                else
                    table.insert(u17, v368);
                end;
            end;

            return mountCallback(p366, p367);
        end,

        useContext = function(p369, p370) -- Line: 2599, Name: useContext
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), readContext (copy)
            u16 = "useContext";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v371 = u16;

                if u17 == nil then
                    u17 = { v371 };
                else
                    table.insert(u17, v371);
                end;
            end;

            return readContext(p369, p370);
        end,

        useEffect = function(p372: function, p373: table?) -- Line: 2605, Name: useEffect
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), mountEffect (copy)
            u16 = "useEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v374 = u16;

                if u17 == nil then
                    u17 = { v374 };
                else
                    table.insert(u17, v374);
                end;
            end;

            return mountEffect(p372, p373);
        end,

        useImperativeHandle = function(p375: any, p376: function, p377: table?) -- Line: 2615, Name: useImperativeHandle
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useImperativeHandle";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v378 = u16;

                if u17 == nil then
                    u17 = { v378 };
                else
                    table.insert(u17, v378);
                end;
            end;

            return mountImperativeHandle(p375, p376, p377);
        end,

        useLayoutEffect = function(p379: function, p380: table?) -- Line: 2625, Name: useLayoutEffect
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), mountLayoutEffect (copy)
            u16 = "useLayoutEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v381 = u16;

                if u17 == nil then
                    u17 = { v381 };
                else
                    table.insert(u17, v381);
                end;
            end;

            return mountLayoutEffect(p379, p380);
        end,

        useMemo = function(p382: function, p383: table?) -- Line: 2636
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useMemo";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v384 = u16;

                if u17 == nil then
                    u17 = { v384 };
                else
                    table.insert(u17, v384);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v385 = { pcall(mountMemo, p382, p383) };
            ReactCurrentDispatcher.current = current;

            if not v385[1] then
                error(v385[2]);
            end;

            return unpack(v385, 2);
        end,

        useReducer = function(p386: function, p387: any, p388: function?) -- Line: 2653, Name: useReducer
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useReducer";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v389 = u16;

                if u17 == nil then
                    u17 = { v389 };
                else
                    table.insert(u17, v389);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v390, v391, v392 = pcall(mountReducer, p386, p387, p388);
            ReactCurrentDispatcher.current = current;

            if not v390 then
                error(v391);
            end;

            return v391, v392;
        end,

        useRef = function(p393) -- Line: 2672, Name: useRef
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useRef";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v394 = u16;

                if u17 == nil then
                    u17 = { v394 };
                else
                    table.insert(u17, v394);
                end;
            end;

            return mountRef(p393);
        end,

        useBinding = function(p395) -- Line: 2679, Name: useBinding
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useBinding";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v396 = u16;

                if u17 == nil then
                    u17 = { v396 };
                else
                    table.insert(u17, v396);
                end;
            end;

            return mountBinding(p395);
        end,

        useState = function(p397) -- Line: 2685, Name: useState
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useState";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v398 = u16;

                if u17 == nil then
                    u17 = { v398 };
                else
                    table.insert(u17, v398);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v399, v400, v401 = pcall(mountState, p397);
            ReactCurrentDispatcher.current = current;

            if not v399 then
                error(v400);
            end;

            return v400, v401;
        end,

        useDebugValue = function(p402: any, p403: function?) -- Line: 2700, Name: useDebugValue
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useDebugValue";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v404 = u16;

                if u17 == nil then
                    u17 = { v404 };
                else
                    table.insert(u17, v404);
                end;
            end;

            return mountDebugValue(p402, p403);
        end,

        useMutableSource = function(p405, p406, p407) -- Line: 2718, Name: useMutableSource
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useMutableSource";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v408 = u16;

                if u17 == nil then
                    u17 = { v408 };
                else
                    table.insert(u17, v408);
                end;
            end;

            return mountMutableSource(p405, p406, p407);
        end,

        useOpaqueIdentifier = function() -- Line: 2734, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useOpaqueIdentifier";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v409 = u16;

                if u17 == nil then
                    u17 = { v409 };
                else
                    table.insert(u17, v409);
                end;
            end;

            return mountOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u24 = {
        readContext = function(p410, p411) -- Line: 2745, Name: readContext
            -- upvalues: console (copy), readContext (copy)
            console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().");

            return readContext(p410, p411);
        end,

        useCallback = function(p412: any, p413: table?) -- Line: 2749, Name: useCallback
            -- upvalues: u16 (ref), console (copy)
            u16 = "useCallback";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return mountCallback(p412, p413);
        end,

        useContext = function(p414, p415) -- Line: 2755, Name: useContext
            -- upvalues: u16 (ref), console (copy), readContext (copy)
            u16 = "useContext";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return readContext(p414, p415);
        end,

        useEffect = function(p416: function, p417: table?) -- Line: 2761, Name: useEffect
            -- upvalues: u16 (ref), console (copy), updateEffect (copy)
            u16 = "useEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateEffect(p416, p417);
        end,

        useImperativeHandle = function(p418: any, p419: function, p420: table?) -- Line: 2771, Name: useImperativeHandle
            -- upvalues: u16 (ref), console (copy)
            u16 = "useImperativeHandle";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateImperativeHandle(p418, p419, p420);
        end,

        useLayoutEffect = function(p421: function, p422: table?) -- Line: 2781, Name: useLayoutEffect
            -- upvalues: u16 (ref), console (copy), updateLayoutEffect (copy)
            u16 = "useLayoutEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateLayoutEffect(p421, p422);
        end,

        useMemo = function(p423: function, p424: table?) -- Line: 2792
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useMemo";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v425 = { pcall(updateMemo, p423, p424) };
            ReactCurrentDispatcher.current = current;

            if not v425[1] then
                error(v425[2]);
            end;

            return unpack(v425, 2);
        end,

        useReducer = function(p426: function, p427: any, p428: function?) -- Line: 2809, Name: useReducer
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useReducer";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v429, v430, v431 = pcall(updateReducer, p426, p427, p428);
            ReactCurrentDispatcher.current = current;

            if not v429 then
                error(v430);
            end;

            return v430, v431;
        end,

        useRef = function(p432) -- Line: 2829, Name: useRef
            -- upvalues: u16 (ref), console (copy)
            u16 = "useRef";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateRef(p432);
        end,

        useBinding = function(p433) -- Line: 2836, Name: useBinding
            -- upvalues: u16 (ref), console (copy)
            u16 = "useBinding";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateBinding(p433);
        end,

        useState = function(p434) -- Line: 2842, Name: useState
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useState";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v435, v436, v437 = pcall(updateState, p434);
            ReactCurrentDispatcher.current = current;

            if not v435 then
                error(v436);
            end;

            return v436, v437;
        end,

        useDebugValue = function(p438: any, p439: function?) -- Line: 2857, Name: useDebugValue
            -- upvalues: u16 (ref), console (copy), u181 (copy)
            u16 = "useDebugValue";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return u181(p438, p439);
        end,

        useMutableSource = function(p440, p441, p442) -- Line: 2875, Name: useMutableSource
            -- upvalues: u16 (ref), console (copy)
            u16 = "useMutableSource";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateMutableSource(p440, p441, p442);
        end,

        useOpaqueIdentifier = function() -- Line: 2891, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref), console (copy)
            u16 = "useOpaqueIdentifier";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u25 = {
        readContext = function(p443, p444) -- Line: 2902, Name: readContext
            -- upvalues: console (copy), readContext (copy)
            console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().");

            return readContext(p443, p444);
        end,

        useCallback = function(p445: any, p446: table?) -- Line: 2906, Name: useCallback
            -- upvalues: u16 (ref), console (copy)
            u16 = "useCallback";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateCallback(p445, p446);
        end,

        useContext = function(p447, p448) -- Line: 2912, Name: useContext
            -- upvalues: u16 (ref), console (copy), readContext (copy)
            u16 = "useContext";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return readContext(p447, p448);
        end,

        useEffect = function(p449: function, p450: table?) -- Line: 2918, Name: useEffect
            -- upvalues: u16 (ref), console (copy), updateEffect (copy)
            u16 = "useEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateEffect(p449, p450);
        end,

        useImperativeHandle = function(p451: any, p452: function, p453: table?) -- Line: 2928, Name: useImperativeHandle
            -- upvalues: u16 (ref), console (copy)
            u16 = "useImperativeHandle";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateImperativeHandle(p451, p452, p453);
        end,

        useLayoutEffect = function(p454: function, p455: table?) -- Line: 2938, Name: useLayoutEffect
            -- upvalues: u16 (ref), console (copy), updateLayoutEffect (copy)
            u16 = "useLayoutEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateLayoutEffect(p454, p455);
        end,

        useMemo = function(p456: function, p457: table?) -- Line: 2949
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useMemo";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v458 = { pcall(updateMemo, p456, p457) };
            ReactCurrentDispatcher.current = current;

            if not v458[1] then
                error(v458[2]);
            end;

            return unpack(v458, 2);
        end,

        useReducer = function(p459: function, p460: any, p461: function?) -- Line: 2966, Name: useReducer
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useReducer";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v462, v463, v464 = pcall(rerenderReducer, p459, p460, p461);
            ReactCurrentDispatcher.current = current;

            if not v462 then
                error(v463);
            end;

            return v463, v464;
        end,

        useRef = function(p465) -- Line: 2986, Name: useRef
            -- upvalues: u16 (ref), console (copy)
            u16 = "useRef";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateRef(p465);
        end,

        useBinding = function(p466) -- Line: 2993, Name: useBinding
            -- upvalues: u16 (ref), console (copy)
            u16 = "useBinding";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateBinding(p466);
        end,

        useState = function(p467) -- Line: 2999, Name: useState
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useState";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v468, v469, v470 = pcall(rerenderState, p467);
            ReactCurrentDispatcher.current = current;

            if not v468 then
                error(v469);
            end;

            return v469, v470;
        end,

        useDebugValue = function(p471: any, p472: function?) -- Line: 3014, Name: useDebugValue
            -- upvalues: u16 (ref), console (copy), u181 (copy)
            u16 = "useDebugValue";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return u181(p471, p472);
        end,

        useMutableSource = function(p473, p474, p475) -- Line: 3032, Name: useMutableSource
            -- upvalues: u16 (ref), console (copy)
            u16 = "useMutableSource";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateMutableSource(p473, p474, p475);
        end,

        useOpaqueIdentifier = function() -- Line: 3048, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref), console (copy)
            u16 = "useOpaqueIdentifier";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return rerenderOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
end;

function u9.renderWithHooks(p476: any, p477: any, p478: function, p479: any, p480: any, p481: any) -- Line: 3059
    -- upvalues: u10 (ref), u11 (ref), _G___DEV__ (copy), u17 (ref), u18 (ref), NoLanes (copy), ReactCurrentDispatcher (copy), u21 (ref), u20 (ref), u19 (ref), u210 (copy), u211 (copy), u15 (ref), Error (copy), u12 (ref), u13 (ref), u22 (ref), u212 (copy), u209 (copy), u16 (ref), u14 (ref)
    u10 = p481;
    u11 = p477;

    if _G___DEV__ then
        local v482;

        if p476 == nil then
            v482 = nil;
        else
            v482 = p476._debugHookTypes;
        end;

        u17 = v482;
        u18 = 0;
    end;

    p477.memoizedState = nil;
    p477.updateQueue = nil;
    p477.lanes = NoLanes;

    if _G___DEV__ then
        if p476 == nil or p476.memoizedState == nil then
            if u17 == nil then
                ReactCurrentDispatcher.current = u19;
            else
                ReactCurrentDispatcher.current = u20;
            end;
        else
            ReactCurrentDispatcher.current = u21;
        end;
    else
        ReactCurrentDispatcher.current = (p476 == nil or p476.memoizedState == nil) and u210 or u211;
    end;

    local v483 = p478(p479, p480);

    if u15 then
        local v484 = 0;

        repeat
            u15 = false;

            if v484 >= 25 then
                error(Error.new("Too many re-renders. React limits the number of renders to prevent an infinite loop."));
            end;

            v484 = v484 + 1;
            u12 = nil;
            u13 = nil;
            p477.updateQueue = nil;

            if _G___DEV__ then
                u18 = 0;
            end;

            ReactCurrentDispatcher.current = _G___DEV__ and u22 or u212;
            v483 = p478(p479, p480);
        until not u15;
    end;

    ReactCurrentDispatcher.current = u209;

    if _G___DEV__ then
        p477._debugHookTypes = u17;
    end;

    local v485;

    if u12 == nil then
        v485 = false;
    else
        v485 = u12.next ~= nil;
    end;

    u10 = NoLanes;
    u11 = nil;
    u12 = nil;
    u13 = nil;

    if _G___DEV__ then
        u16 = nil;
        u17 = nil;
        u18 = 0;
    end;

    u14 = false;

    if v485 then
        error(Error.new("Rendered fewer hooks than expected. This may be caused by an accidental early return statement."));
    end;

    return v483;
end;

return u9;