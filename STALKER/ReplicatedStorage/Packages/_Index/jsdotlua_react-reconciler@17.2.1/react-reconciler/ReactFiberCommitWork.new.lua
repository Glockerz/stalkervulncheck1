-- Decompiled with Potassium's decompiler.

local function unimplemented(p1: string) -- Line: 11
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring(p1));
    error("FIXME (roblox): " .. p1 .. " is unimplemented", 2);
end;

local _G___DEV__ = _G.__DEV__;
local _G___YOLO__ = _G.__YOLO__;
local u2 = 0;

local function isCallable(p3) -- Line: 27
    if typeof(p3) == "function" then
        return true;
    end;

    if typeof(p3) == "table" then
        local v4 = getmetatable(p3);

        if v4 and rawget(v4, "__call") then
            return true;
        end;

        if p3._isMockFunction then
            return true;
        end;
    end;

    return false;
end;

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local v5 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Error = v5.Error;
local Set = v5.Set;
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local v6 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"));
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"));
local ReactHookEffectTags = require(script.Parent:WaitForChild("ReactHookEffectTags"));
local unstable_wrap = require(script.Parent.Parent:WaitForChild("scheduler")).tracing.unstable_wrap;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing;
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer;
local enableProfilerCommitHooks = ReactFeatureFlags.enableProfilerCommitHooks;
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback;
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local FunctionComponent = ReactWorkTags.FunctionComponent;
local ForwardRef = ReactWorkTags.ForwardRef;
local ClassComponent = ReactWorkTags.ClassComponent;
local HostRoot = ReactWorkTags.HostRoot;
local HostComponent = ReactWorkTags.HostComponent;
local HostText = ReactWorkTags.HostText;
local HostPortal = ReactWorkTags.HostPortal;
local Profiler = ReactWorkTags.Profiler;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local DehydratedFragment = ReactWorkTags.DehydratedFragment;
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent;
local MemoComponent = ReactWorkTags.MemoComponent;
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent;
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent;
local FundamentalComponent = ReactWorkTags.FundamentalComponent;
local ScopeComponent = ReactWorkTags.ScopeComponent;
local Block = ReactWorkTags.Block;
local OffscreenComponent = ReactWorkTags.OffscreenComponent;
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent;
local ReactErrorUtils = require(script.Parent.Parent:WaitForChild("shared")).ReactErrorUtils;
local invokeGuardedCallback = ReactErrorUtils.invokeGuardedCallback;
local hasCaughtError = ReactErrorUtils.hasCaughtError;
local clearCaughtError = ReactErrorUtils.clearCaughtError;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local NoFlags = ReactFiberFlags.NoFlags;
local ContentReset = ReactFiberFlags.ContentReset;
local Placement = ReactFiberFlags.Placement;
local Snapshot = ReactFiberFlags.Snapshot;
local Update = ReactFiberFlags.Update;
local Callback = ReactFiberFlags.Callback;
local LayoutMask = ReactFiberFlags.LayoutMask;
local PassiveMask = ReactFiberFlags.PassiveMask;
local Ref = ReactFiberFlags.Ref;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"));
local current = ReactCurrentFiber.current;
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber;
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber;
local onCommitUnmount = require(script.Parent:WaitForChild("ReactFiberDevToolsHook.new")).onCommitUnmount;
local resolveDefaultProps = require(script.Parent:WaitForChild("ReactFiberLazyComponent.new")).resolveDefaultProps;
local v7 = require(script.Parent:WaitForChild("ReactProfilerTimer.new"));
local startLayoutEffectTimer = v7.startLayoutEffectTimer;
local recordPassiveEffectDuration = v7.recordPassiveEffectDuration;
local recordLayoutEffectDuration = v7.recordLayoutEffectDuration;
local startPassiveEffectTimer = v7.startPassiveEffectTimer;
local getCommitTime = v7.getCommitTime;
local ProfileMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).ProfileMode;
local commitUpdateQueue = v6.commitUpdateQueue;
local getPublicInstance = ReactFiberHostConfig.getPublicInstance;
local supportsMutation = ReactFiberHostConfig.supportsMutation;
local supportsPersistence = ReactFiberHostConfig.supportsPersistence;
local supportsHydration = ReactFiberHostConfig.supportsHydration;
local commitMount = ReactFiberHostConfig.commitMount;
local commitUpdate = ReactFiberHostConfig.commitUpdate;
local resetTextContent = ReactFiberHostConfig.resetTextContent;
local commitTextUpdate = ReactFiberHostConfig.commitTextUpdate;
local appendChild = ReactFiberHostConfig.appendChild;
local appendChildToContainer = ReactFiberHostConfig.appendChildToContainer;
local insertBefore = ReactFiberHostConfig.insertBefore;
local insertInContainerBefore = ReactFiberHostConfig.insertInContainerBefore;
local removeChild = ReactFiberHostConfig.removeChild;
local removeChildFromContainer = ReactFiberHostConfig.removeChildFromContainer;
local hideInstance = ReactFiberHostConfig.hideInstance;
local hideTextInstance = ReactFiberHostConfig.hideTextInstance;
local unhideInstance = ReactFiberHostConfig.unhideInstance;
local unhideTextInstance = ReactFiberHostConfig.unhideTextInstance;
local commitHydratedSuspenseInstance = ReactFiberHostConfig.commitHydratedSuspenseInstance;
local clearContainer = ReactFiberHostConfig.clearContainer;
local u8 = nil;

local function resolveRetryWakeable(p9, p10) -- Line: 190
    -- upvalues: u8 (ref)
    if not u8 then
        u8 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
    end;

    u8.resolveRetryWakeable(p9, p10);
end;

local function markCommitTimeOfFallback() -- Line: 197
    -- upvalues: u8 (ref)
    if not u8 then
        u8 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
    end;

    u8.markCommitTimeOfFallback();
end;

local function schedulePassiveEffectCallback() -- Line: 205
    -- upvalues: console (copy)
    console.warn("ReactFiberCommitWork: schedulePassiveEffectCallback causes a dependency cycle\n" .. debug.traceback());
end;

local function captureCommitPhaseError(p11, p12, p13) -- Line: 213
    -- upvalues: console (copy)
    console.warn("ReactFiberCommitWork: captureCommitPhaseError causes a dependency cycle");
    error(p13);
end;

local NoFlags2 = ReactHookEffectTags.NoFlags;
local HasEffect = ReactHookEffectTags.HasEffect;
local Layout = ReactHookEffectTags.Layout;
local Passive = ReactHookEffectTags.Passive;
local u14 = nil;

local function u15() -- Line: 231
    -- upvalues: u14 (ref)
    if not u14 then
        u14 = require(script.Parent:WaitForChild("ReactFiberBeginWork.new")).didWarnAboutReassigningProps;
    end;

    return u14;
end;

local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;

local function callComponentWillUnmountWithTimer(p24, u25) -- Line: 256
    -- upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), describeError (copy), recordLayoutEffectDuration (copy)
    u25.props = p24.memoizedProps;
    u25.state = p24.memoizedState;

    if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p24.mode, ProfileMode) ~= 0) then
        local v26, v27 = xpcall(function() -- Line: 265
            -- upvalues: startLayoutEffectTimer (ref), u25 (copy)
            startLayoutEffectTimer();
            u25:componentWillUnmount();
        end, describeError);
        recordLayoutEffectDuration(p24);

        if not v26 then
            error(v27);
        end;
    else
        u25:componentWillUnmount();
    end;
end;

function safelyCallComponentWillUnmount(p28, p29, p30)
    -- upvalues: callComponentWillUnmountWithTimer (copy), describeError (copy), captureCommitPhaseError (ref)
    local v31, v32 = xpcall(callComponentWillUnmountWithTimer, describeError, p28, p29);

    if not v31 then
        captureCommitPhaseError(p28, p30, v32);
    end;
end;

local function safelyDetachRef(p33, p34) -- Line: 297
    -- upvalues: describeError (copy), captureCommitPhaseError (ref)
    local ref = p33.ref;

    if ref ~= nil then
        if typeof(ref) == "function" then
            local v35, v36 = xpcall(ref, describeError);

            if not v35 then
                captureCommitPhaseError(p33, p34, v36);
            end;
        else
            ref.current = nil;
        end;
    end;
end;

local function safelyCallDestroy(p37: any, p38: any, p39: function) -- Line: 313
    -- upvalues: describeError (copy), captureCommitPhaseError (ref)
    local v40, v41 = xpcall(p39, describeError);

    if not v40 then
        captureCommitPhaseError(p37, p38, v41);
    end;
end;

local function commitHookEffectListUnmount(p42, p43, p44) -- Line: 418
    -- upvalues: describeError (copy), captureCommitPhaseError (ref)
    local updateQueue = p43.updateQueue;
    local v45;

    if updateQueue == nil then
        v45 = nil;
    else
        v45 = updateQueue.lastEffect;
    end;

    if v45 ~= nil then
        local next = v45.next;

        repeat
            if bit32.band(next.tag, p42) == p42 then
                local destroy = next.destroy;
                next.destroy = nil;

                if destroy ~= nil then
                    local v46, v47 = xpcall(destroy, describeError);

                    if not v46 then
                        captureCommitPhaseError(p43, p44, v47);
                    end;
                end;
            end;

            next = next.next;
        until next == next;
    end;
end;

local function commitHookEffectListMount(p48, p49) -- Line: 446
    -- upvalues: _G___DEV__ (copy), console (copy)
    local updateQueue = p49.updateQueue;
    local v50;

    if updateQueue == nil then
        v50 = nil;
    else
        v50 = updateQueue.lastEffect;
    end;

    if v50 ~= nil then
        local next = v50.next;

        repeat
            if bit32.band(next.tag, p48) == p48 then
                next.destroy = next.create();

                if _G___DEV__ then
                    local destroy = next.destroy;

                    if destroy ~= nil and typeof(destroy) ~= "function" then
                        local v51 = destroy == nil and " You returned nil. If your effect does not require clean up, return nil (or nothing)." or (typeof(destroy.andThen) == "function" and "\n\nIt looks like you wrote useEffect(Promise.new(function() --[[...]] end) or returned a Promise. Instead, write the async function inside your effect and call it immediately:\n\nuseEffect(function()\n  function fetchData()\n    -- You can await here\n    local response = MyAPI.getData(someId):await()\n    -- ...\n  end\n  fetchData()\nend, {someId}) -- Or {} if effect doesn\'t need props or state\n\nLearn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching" or " You returned: " .. destroy);
                        console.error("An effect function must not return anything besides a function, which is used for clean-up.%s", v51);
                    end;
                end;
            end;

            next = next.next;
        until next == next;
    end;
end;

function commitProfilerPassiveEffect(p52, p53)
    -- upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), Profiler (copy), getCommitTime (copy), enableSchedulerTracing (copy)
    if enableProfilerTimer and (enableProfilerCommitHooks and p53.tag == Profiler) then
        local passiveEffectDuration = p53.stateNode.passiveEffectDuration;
        local id = p53.memoizedProps.id;
        local onPostCommit = p53.memoizedProps.onPostCommit;
        local v54 = getCommitTime();

        if typeof(onPostCommit) == "function" then
            if enableSchedulerTracing then
                onPostCommit(id, p53.alternate == nil and "mount" or "update", passiveEffectDuration, v54, p52.memoizedInteractions);

                return;
            end;

            onPostCommit(id, p53.alternate == nil and "mount" or "update", passiveEffectDuration, v54);
        end;
    end;
end;

local function recursivelyCommitLayoutEffects(u55: any, p56: any, p57: function, p58: function) -- Line: 530
    -- upvalues: captureCommitPhaseError (ref), schedulePassiveEffectCallback (ref), Profiler (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), u23 (ref), LayoutMask (copy), NoFlags (copy), _G___DEV__ (copy), current (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), recursivelyCommitLayoutEffects (copy), hasCaughtError (copy), clearCaughtError (copy), resetCurrentFiber (copy), describeError (copy), Update (copy), Callback (copy), ReactCurrentFiber (copy), u2 (ref), _G___YOLO__ (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), ProfileMode (copy), startLayoutEffectTimer (copy), commitHookEffectListMount (copy), Layout (copy), HasEffect (copy), recordLayoutEffectDuration (copy), PassiveMask (copy), ClassComponent (copy), u21 (ref), HostRoot (copy), u19 (ref), HostComponent (copy), u20 (ref), SuspenseComponent (copy), FundamentalComponent (copy), HostPortal (copy), HostText (copy), IncompleteClassComponent (copy), LegacyHiddenComponent (copy), OffscreenComponent (copy), ScopeComponent (copy), SuspenseListComponent (copy), invariant (copy), Ref (copy)
    if p57 ~= nil then
        captureCommitPhaseError = p57;
    end;

    if p58 ~= nil then
        schedulePassiveEffectCallback = p58;
    end;

    local flags = u55.flags;
    local tag = u55.tag;

    if tag == Profiler then
        local v59;

        if enableProfilerTimer and enableProfilerCommitHooks then
            v59 = u23;
            u23 = u55;
        else
            v59 = nil;
        end;

        local child = u55.child;

        while child ~= nil do
            if bit32.band(u55.subtreeFlags, LayoutMask) ~= NoFlags then
                if _G___DEV__ then
                    local v60 = current;
                    setCurrentFiber(child);
                    invokeGuardedCallback(nil, recursivelyCommitLayoutEffects, nil, child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);

                    if hasCaughtError() then
                        captureCommitPhaseError(child, u55, (clearCaughtError()));
                    end;

                    if v60 == nil then
                        resetCurrentFiber();
                    else
                        setCurrentFiber(v60);
                    end;
                else
                    local v61, v62 = xpcall(recursivelyCommitLayoutEffects, describeError, child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);

                    if not v61 then
                        captureCommitPhaseError(child, u55, v62);
                    end;
                end;
            end;

            child = child.sibling;
        end;

        local bit32_bor_ret = bit32.bor(Update, Callback);

        if bit32.band(flags, bit32_bor_ret) ~= NoFlags and enableProfilerTimer then
            if _G___DEV__ then
                local v63 = current;
                setCurrentFiber(u55);
                invokeGuardedCallback(nil, commitLayoutEffectsForProfiler, nil, u55, p56);

                if hasCaughtError() then
                    local v64 = clearCaughtError();
                    captureCommitPhaseError(u55, u55.return_, v64);
                end;

                if v63 == nil then
                    resetCurrentFiber();
                else
                    setCurrentFiber(v63);
                end;
            else
                local v65, v66 = xpcall(commitLayoutEffectsForProfiler, describeError, u55, p56);

                if not v65 then
                    captureCommitPhaseError(u55, u55.return_, v66);
                end;
            end;
        end;

        if enableProfilerTimer and enableProfilerCommitHooks then
            if v59 ~= nil then
                local stateNode = v59.stateNode;
                stateNode.effectDuration = stateNode.effectDuration + u55.stateNode.effectDuration;
            end;

            u23 = v59;
        end;
    else
        local child = u55.child;

        while child ~= nil do
            if bit32.band(u55.subtreeFlags, LayoutMask) ~= NoFlags then
                if _G___DEV__ then
                    local current2 = ReactCurrentFiber.current;
                    setCurrentFiber(child);

                    if u2 < 20 then
                        u2 = u2 + 1;
                        invokeGuardedCallback(nil, recursivelyCommitLayoutEffects, nil, child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);
                        u2 = u2 - 1;

                        if hasCaughtError() then
                            captureCommitPhaseError(child, u55, (clearCaughtError()));
                        end;
                    else
                        recursivelyCommitLayoutEffects(child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);
                    end;

                    if current2 == nil then
                        resetCurrentFiber();
                    else
                        setCurrentFiber(current2);
                    end;
                else
                    local v67 = nil;
                    local v68;

                    if _G___YOLO__ or u2 >= 20 then
                        recursivelyCommitLayoutEffects(child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);
                        v68 = true;
                    else
                        u2 = u2 + 1;
                        v68, v67 = xpcall(recursivelyCommitLayoutEffects, describeError, child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);
                        u2 = u2 - 1;
                    end;

                    if not v68 then
                        captureCommitPhaseError(child, u55, v67);
                    end;
                end;
            end;

            child = child.sibling;
        end;

        local bit32_bor_ret = bit32.bor(Update, Callback);

        if bit32.band(flags, bit32_bor_ret) ~= NoFlags then
            if tag == FunctionComponent or (tag == ForwardRef or (tag == SimpleMemoComponent or tag == Block)) then
                if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(u55.mode, ProfileMode) ~= 0) then
                    local v69, v70 = xpcall(function() -- Line: 751
                        -- upvalues: startLayoutEffectTimer (ref), commitHookEffectListMount (ref), Layout (ref), HasEffect (ref), u55 (copy)
                        startLayoutEffectTimer();
                        commitHookEffectListMount(bit32.bor(Layout, HasEffect), u55);
                    end, describeError);
                    recordLayoutEffectDuration(u55);

                    if not v69 then
                        error(v70);
                    end;
                else
                    commitHookEffectListMount(bit32.bor(Layout, HasEffect), u55);
                end;

                if bit32.band(u55.subtreeFlags, PassiveMask) ~= NoFlags then
                    schedulePassiveEffectCallback();
                end;
            elseif tag == ClassComponent then
                u21(u55);
            elseif tag == HostRoot then
                u19(u55);
            elseif tag == HostComponent then
                u20(u55);
            elseif tag == SuspenseComponent then
                commitSuspenseHydrationCallbacks(p56, u55);
            elseif tag ~= FundamentalComponent and (tag ~= HostPortal and (tag ~= HostText and (tag ~= IncompleteClassComponent and (tag ~= LegacyHiddenComponent and (tag ~= OffscreenComponent and (tag ~= ScopeComponent and tag ~= SuspenseListComponent)))))) then
                invariant(
                    false,
                    "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue."
                );
            end;
        end;

        if bit32.band(flags, Ref) ~= 0 then
            commitAttachRef(u55);
        end;
    end;
end;

function commitLayoutEffectsForProfiler(p71, p72)
    -- upvalues: enableProfilerTimer (copy), getCommitTime (copy), Update (copy), Callback (copy), NoFlags (copy), enableSchedulerTracing (copy), enableProfilerCommitHooks (copy)
    if enableProfilerTimer then
        local flags = p71.flags;
        local alternate = p71.alternate;
        local onCommit = p71.memoizedProps.onCommit;
        local onRender = p71.memoizedProps.onRender;
        local effectDuration = p71.stateNode.effectDuration;
        local v73 = getCommitTime();

        if bit32.band(flags, Update) ~= NoFlags then
            local v74;

            if typeof(onRender) == "function" then
                v74 = true;
            elseif typeof(onRender) == "table" then
                local v75 = getmetatable(onRender);
                v74 = v75 and rawget(v75, "__call") and true or (onRender._isMockFunction and true or false);
            else
                v74 = false;
            end;

            if v74 then
                if enableSchedulerTracing then
                    onRender(p71.memoizedProps.id, alternate == nil and "mount" or "update", p71.actualDuration, p71.treeBaseDuration, p71.actualStartTime, v73, p72.memoizedInteractions);
                else
                    onRender(p71.memoizedProps.id, alternate == nil and "mount" or "update", p71.actualDuration, p71.treeBaseDuration, p71.actualStartTime, v73);
                end;
            end;
        end;

        if enableProfilerCommitHooks and bit32.band(flags, Callback) ~= NoFlags then
            local v76;

            if typeof(onCommit) == "function" then
                v76 = true;
            elseif typeof(onCommit) == "table" then
                local v77 = getmetatable(onCommit);
                v76 = v77 and rawget(v77, "__call") and true or (onCommit._isMockFunction and true or false);
            else
                v76 = false;
            end;

            if v76 then
                if enableSchedulerTracing then
                    onCommit(p71.memoizedProps.id, alternate == nil and "mount" or "update", effectDuration, v73, p72.memoizedInteractions);

                    return;
                end;

                onCommit(p71.memoizedProps.id, alternate == nil and "mount" or "update", effectDuration, v73);
            end;
        end;
    end;
end;

u21 = function(p78) -- Line: 882, Name: commitLayoutEffectsForClassComponent
    -- upvalues: Update (copy), _G___DEV__ (copy), u15 (copy), console (copy), getComponentName (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), describeError (copy), recordLayoutEffectDuration (copy), resolveDefaultProps (copy), commitUpdateQueue (copy)
    local stateNode = p78.stateNode;
    local alternate = p78.alternate;

    if bit32.band(p78.flags, Update) ~= 0 then
        if alternate == nil then
            if _G___DEV__ and (p78.type == p78.elementType and not u15) then
                if stateNode.props ~= p78.memoizedProps then
                    console.error("Expected %s props to match memoized props before componentDidMount. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p78.type) or "instance");
                end;

                if stateNode.state ~= p78.memoizedState then
                    console.error("Expected %s state to match memoized state before componentDidMount. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p78.type) or "instance");
                end;
            end;

            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p78.mode, ProfileMode) ~= 0) then
                local v79, v80 = xpcall(function() -- Line: 914
                    -- upvalues: startLayoutEffectTimer (ref), stateNode (copy)
                    startLayoutEffectTimer();
                    stateNode:componentDidMount();
                end, describeError);
                recordLayoutEffectDuration(p78);

                if not v79 then
                    error(v80);
                end;
            else
                stateNode:componentDidMount();
            end;
        else
            local u81 = p78.elementType == p78.type and alternate.memoizedProps or resolveDefaultProps(p78.type, alternate.memoizedProps);
            local memoizedState = alternate.memoizedState;

            if _G___DEV__ and (p78.type == p78.elementType and not u15) then
                if stateNode.props ~= p78.memoizedProps then
                    console.error("Expected %s props to match memoized props before componentDidUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p78.type) or "instance");
                end;

                if stateNode.state ~= p78.memoizedState then
                    console.error("Expected %s state to match memoized state before componentDidUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p78.type) or "instance");
                end;
            end;

            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p78.mode, ProfileMode) ~= 0) then
                local v82, v83 = xpcall(function() -- Line: 968
                    -- upvalues: startLayoutEffectTimer (ref), stateNode (copy), u81 (copy), memoizedState (copy)
                    startLayoutEffectTimer();
                    stateNode:componentDidUpdate(u81, memoizedState, stateNode.__reactInternalSnapshotBeforeUpdate);
                end, describeError);
                recordLayoutEffectDuration(p78);

                if not v82 then
                    error(v83);
                end;
            else
                stateNode:componentDidUpdate(u81, memoizedState, stateNode.__reactInternalSnapshotBeforeUpdate);
            end;
        end;
    end;

    local updateQueue = p78.updateQueue;

    if updateQueue ~= nil then
        if _G___DEV__ and (p78.type == p78.elementType and not u15) then
            if stateNode.props ~= p78.memoizedProps then
                console.error("Expected %s props to match memoized props before processing the update queue. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p78.type) or "instance");
            end;

            if stateNode.state ~= p78.memoizedState then
                console.error("Expected %s state to match memoized state before processing the update queue. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p78.type) or "instance");
            end;
        end;

        commitUpdateQueue(p78, updateQueue, stateNode);
    end;
end;

u19 = function(p84) -- Line: 1031, Name: commitLayoutEffectsForHostRoot
    -- upvalues: HostComponent (copy), getPublicInstance (copy), ClassComponent (copy), commitUpdateQueue (copy)
    local updateQueue = p84.updateQueue;

    if updateQueue ~= nil then
        local v85 = nil;

        if p84.child ~= nil then
            local child = p84.child;

            if child.tag == HostComponent then
                v85 = getPublicInstance(child.stateNode);
            elseif child.tag == ClassComponent then
                v85 = child.stateNode;
            end;
        end;

        commitUpdateQueue(p84, updateQueue, v85);
    end;
end;

u20 = function(p86) -- Line: 1050, Name: commitLayoutEffectsForHostComponent
    -- upvalues: Update (copy), commitMount (copy)
    local stateNode = p86.stateNode;

    if p86.alternate == nil and bit32.band(p86.flags, Update) ~= 0 then
        commitMount(stateNode, p86.type, p86.memoizedProps, p86);
    end;
end;

local function hideOrUnhideAllChildren(p87, p88) -- Line: 1065
    -- upvalues: supportsMutation (copy), HostComponent (copy), hideInstance (copy), unhideInstance (copy), HostText (copy), hideTextInstance (copy), unhideTextInstance (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy)
    if not supportsMutation then
        return;
    end;

    local v89 = p87;

    while true do
        while p87.tag == HostComponent do
            local stateNode = p87.stateNode;

            if p88 then
                hideInstance(stateNode);
            else
                unhideInstance(p87.stateNode, p87.memoizedProps);
            end;

            if p87 == v89 then
                return;
            end;

            while p87.sibling == nil do
                if p87.return_ == nil or p87.return_ == v89 then
                    return;
                end;

                p87 = p87.return_;
            end;

            p87.sibling.return_ = p87.return_;
            p87 = p87.sibling;
        end;

        if p87.tag == HostText then
            local stateNode = p87.stateNode;

            if p88 then
                hideTextInstance(stateNode);
            else
                unhideTextInstance(stateNode, p87.memoizedProps);
            end;

            if p87 == v89 then
                return;
            end;

            while p87.sibling == nil do
                if p87.return_ == nil or p87.return_ == v89 then
                    return;
                end;

                p87 = p87.return_;
            end;

            p87.sibling.return_ = p87.return_;
            p87 = p87.sibling;
        end;

        if not (p87.tag ~= OffscreenComponent and p87.tag ~= LegacyHiddenComponent or (p87.memoizedState == nil or p87 == v89)) or p87.child == nil then
            if p87 == v89 then
                return;
            end;

            while p87.sibling == nil do
                if p87.return_ == nil or p87.return_ == v89 then
                    return;
                end;

                p87 = p87.return_;
            end;

            p87.sibling.return_ = p87.return_;
            p87 = p87.sibling;
        end;

        p87.child.return_ = p87;
        p87 = p87.child;
    end;
end;

function commitAttachRef(p90)
    -- upvalues: HostComponent (copy), getPublicInstance (copy), _G___DEV__ (copy), console (copy), getComponentName (copy)
    local ref = p90.ref;

    if ref ~= nil then
        local stateNode = p90.stateNode;

        if p90.tag == HostComponent then
            stateNode = getPublicInstance(stateNode);
        end;

        if typeof(ref) == "function" then
            ref(stateNode);

            return;
        end;

        if _G___DEV__ and typeof(ref) ~= "table" then
            console.error("Unexpected ref object provided for %s. Use either a ref-setter function or React.createRef().", getComponentName(p90.type) or "instance");

            return;
        end;

        ref.current = stateNode;
    end;
end;

function commitDetachRef(p91)
    local ref = p91.ref;

    if ref ~= nil then
        if typeof(ref) == "function" then
            ref(nil);

            return;
        end;

        ref.current = nil;
    end;
end;

local function commitUnmount(p92, p93, p94, p95) -- Line: 1168
    -- upvalues: onCommitUnmount (copy), FunctionComponent (copy), ForwardRef (copy), MemoComponent (copy), SimpleMemoComponent (copy), Block (copy), Layout (copy), NoFlags2 (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), describeError (copy), captureCommitPhaseError (ref), recordLayoutEffectDuration (copy), ClassComponent (copy), HostComponent (copy), HostPortal (copy), supportsMutation (copy), u22 (ref), supportsPersistence (copy), unimplemented (copy)
    onCommitUnmount(p93);

    if p93.tag ~= FunctionComponent and (p93.tag ~= ForwardRef and (p93.tag ~= MemoComponent and (p93.tag ~= SimpleMemoComponent and p93.tag ~= Block))) then
        if p93.tag == ClassComponent then
            local ref = p93.ref;

            if ref ~= nil then
                if typeof(ref) == "function" then
                    local v96, v97 = xpcall(ref, describeError);

                    if not v96 then
                        captureCommitPhaseError(p93, p94, v97);
                    end;
                else
                    ref.current = nil;
                end;
            end;

            local stateNode = p93.stateNode;

            if typeof(stateNode.componentWillUnmount) == "function" then
                safelyCallComponentWillUnmount(p93, stateNode, p94);
            end;

            return;
        end;

        if p93.tag == HostComponent then
            local ref = p93.ref;

            if ref ~= nil then
                if typeof(ref) == "function" then
                    local v98, v99 = xpcall(ref, describeError);

                    if not v98 then
                        captureCommitPhaseError(p93, p94, v99);

                        return;
                    end;
                else
                    ref.current = nil;
                end;
            end;

            return;
        end;

        if p93.tag ~= HostPortal then
            return;
        end;

        if supportsMutation then
            u22(p92, p93, p94, p95);

            return;
        end;

        if supportsPersistence then
            unimplemented("emptyPortalContainer");
        end;

        return;
    end;

    local updateQueue = p93.updateQueue;

    if updateQueue ~= nil then
        local lastEffect = updateQueue.lastEffect;

        if lastEffect ~= nil then
            local next = lastEffect.next;

            repeat
                if next.destroy ~= nil and bit32.band(next.tag, Layout) ~= NoFlags2 then
                    if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p93.mode, ProfileMode) ~= 0) then
                        startLayoutEffectTimer();
                        local v100, v101 = xpcall(next.destroy, describeError);

                        if not v100 then
                            captureCommitPhaseError(p93, p94, v101);
                        end;

                        recordLayoutEffectDuration(p93);
                    else
                        local v102, v103 = xpcall(next.destroy, describeError);

                        if not v102 then
                            captureCommitPhaseError(p93, p94, v103);
                        end;
                    end;
                end;

                next = next.next;
            until next == next;
        end;
    end;
end;

local function commitNestedUnmounts(p104, p105, p106, p107) -- Line: 1275
    -- upvalues: commitUnmount (ref), supportsMutation (copy), HostPortal (copy)
    local v108 = p105;

    while true do
        while true do
            commitUnmount(p104, p105, p106, p107);

            if p105.child ~= nil and (not supportsMutation or p105.tag ~= HostPortal) then
                break;
            end;

            if p105 == v108 then
                return;
            end;

            while p105.sibling == nil do
                if p105.return_ == nil or p105.return_ == v108 then
                    return;
                end;

                p105 = p105.return_;
            end;

            p105.sibling.return_ = p105.return_;
            p105 = p105.sibling;
        end;

        p105.child.return_ = p105;
        p105 = p105.child;
    end;
end;

local function detachFiberMutation(p109) -- Line: 1315
    local alternate = p109.alternate;

    if alternate ~= nil then
        alternate.return_ = nil;
        p109.alternate = nil;
    end;

    p109.return_ = nil;
end;

local function getHostParentFiber(p110) -- Line: 1382
    -- upvalues: u16 (ref), Error (copy)
    local return_ = p110.return_;

    while return_ ~= nil do
        if u16(return_) then
            return return_;
        end;

        return_ = return_.return_;
    end;

    error(Error.new("Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue."));
end;

u16 = function(p111) -- Line: 1400, Name: isHostParent
    -- upvalues: HostComponent (copy), HostRoot (copy), HostPortal (copy)
    return (p111.tag == HostComponent or p111.tag == HostRoot) and true or p111.tag == HostPortal;
end;

local function getHostSibling(p112) -- Line: 1404
    -- upvalues: u16 (ref), HostComponent (copy), HostText (copy), DehydratedFragment (copy), Placement (copy), HostPortal (copy)
    while true do
        local v113 = false;

        while p112.sibling == nil do
            if p112.return_ == nil or u16(p112.return_) then
                return nil;
            end;

            p112 = p112.return_;
        end;

        p112.sibling.return_ = p112.return_;
        p112 = p112.sibling;

        while p112.tag ~= HostComponent and (p112.tag ~= HostText and p112.tag ~= DehydratedFragment) do
            if bit32.band(p112.flags, Placement) ~= 0 or (p112.child == nil or p112.tag == HostPortal) then
                v113 = true;
                break;
            end;

            p112.child.return_ = p112;
            p112 = p112.child;
        end;

        if not v113 and bit32.band(p112.flags, Placement) == 0 then
            return p112.stateNode;
        end;
    end;
end;

local function commitPlacement(p114) -- Line: 1458
    -- upvalues: supportsMutation (copy), getHostParentFiber (copy), HostComponent (copy), HostRoot (copy), HostPortal (copy), invariant (copy), ContentReset (copy), resetTextContent (copy), getHostSibling (ref), u18 (ref), u17 (ref)
    if not supportsMutation then
        return;
    end;

    local v115 = getHostParentFiber(p114);
    local v116 = nil;
    local v117 = nil;
    local stateNode = v115.stateNode;

    if v115.tag == HostComponent then
        v116 = stateNode;
        v117 = false;
    elseif v115.tag == HostRoot then
        v116 = stateNode.containerInfo;
        v117 = true;
    elseif v115.tag == HostPortal then
        v116 = stateNode.containerInfo;
        v117 = true;
    else
        invariant(
            false,
            "Invalid host parent fiber. This error is likely caused by a bug in React. Please file an issue."
        );
    end;

    if bit32.band(v115.flags, ContentReset) ~= 0 then
        resetTextContent(v116);
        local flags = v115.flags;
        local bit32_bnot_ret = bit32.bnot(ContentReset);
        v115.flags = bit32.band(flags, bit32_bnot_ret);
    end;

    local v118 = getHostSibling(p114);

    if v117 then
        u18(p114, v118, v116);

        return;
    end;

    u17(p114, v118, v116);
end;

u18 = function(p119, p120, p121) -- Line: 1509, Name: insertOrAppendPlacementNodeIntoContainer
    -- upvalues: HostComponent (copy), HostText (copy), insertInContainerBefore (copy), appendChildToContainer (copy), HostPortal (copy), u18 (ref)
    local tag = p119.tag;

    if tag == HostComponent and true or tag == HostText then
        local stateNode = p119.stateNode;

        if p120 then
            insertInContainerBefore(p121, stateNode, p120);

            return;
        end;

        appendChildToContainer(p121, stateNode);

        return;
    end;

    if tag == HostPortal then
        return;
    end;

    local child = p119.child;

    if child ~= nil then
        u18(child, p120, p121);
        local sibling = child.sibling;

        while sibling ~= nil do
            u18(sibling, p120, p121);
            sibling = sibling.sibling;
        end;
    end;
end;

u17 = function(p122, p123, p124) -- Line: 1541, Name: insertOrAppendPlacementNode
    -- upvalues: HostComponent (copy), HostText (copy), insertBefore (copy), appendChild (copy), HostPortal (copy), u17 (ref)
    local tag = p122.tag;

    if tag == HostComponent and true or tag == HostText then
        local stateNode = p122.stateNode;

        if p123 then
            insertBefore(p124, stateNode, p123);

            return;
        end;

        appendChild(p124, stateNode);

        return;
    end;

    if tag == HostPortal then
        return;
    end;

    local child = p122.child;

    if child ~= nil then
        u17(child, p123, p124);
        local sibling = child.sibling;

        while sibling ~= nil do
            u17(sibling, p123, p124);
            sibling = sibling.sibling;
        end;
    end;
end;

u22 = function(p125, p126, p127, p128) -- Line: 1569, Name: unmountHostComponents
    -- upvalues: Error (copy), HostComponent (copy), HostRoot (copy), HostPortal (copy), HostText (copy), commitNestedUnmounts (ref), removeChildFromContainer (copy), removeChild (copy), commitUnmount (ref)
    local v129 = p126;
    local v130 = false;
    local v131 = nil;
    local v132 = nil;

    while v130 do
        local v133 = 0;

        while true do
            if v133 == 0 then
                v133 = -1;

                if p126.tag == HostComponent or p126.tag == HostText then
                    commitNestedUnmounts(p125, p126, p127, p128);

                    if v131 then
                        removeChildFromContainer(v132, p126.stateNode);
                    else
                        removeChild(v132, p126.stateNode);
                    end;

                    if p126 == v129 then
                        return;
                    end;

                    while p126.sibling == nil do
                        if p126.return_ == nil or p126.return_ == v129 then
                            return;
                        end;

                        p126 = p126.return_;

                        if p126.tag == HostPortal then
                            v130 = false;
                        end;
                    end;

                    p126.sibling.return_ = p126.return_;
                    p126 = p126.sibling;
                elseif p126.tag == HostPortal then
                    if p126.child == nil then
                        goto l0;
                    end;

                    v132 = p126.stateNode.containerInfo;
                    p126.child.return_ = p126;
                    p126 = p126.child;
                    v131 = true;
                else
                    commitUnmount(p125, p126, p127, p128);

                    if p126.child == nil then
                        goto l0;
                    end;

                    p126.child.return_ = p126;
                    p126 = p126.child;
                end;

                break;
            else
                break;
            end;
        end;
    end;

    local return_ = p126.return_;

    while true do
        if return_ == nil then
            error(Error.new("Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue."));
        end;

        v132 = return_.stateNode;

        if return_.tag == HostComponent then
            v131 = false;
            break;
        end;

        if return_.tag == HostRoot then
            v132 = v132.containerInfo;
            v131 = true;
            break;
        end;

        if return_.tag == HostPortal then
            v132 = v132.containerInfo;
            v131 = true;
            break;
        end;

        return_ = return_.return_;
    end;

    v130 = true;
    goto l1;
end;

local function commitDeletion(p134, p135, p136, p137) -- Line: 1747
    -- upvalues: u22 (ref)
    u22(p134, p135, p136, p137);
    local alternate = p135.alternate;
    local alternate2 = p135.alternate;

    if alternate2 ~= nil then
        alternate2.return_ = nil;
        p135.alternate = nil;
    end;

    p135.return_ = nil;

    if alternate ~= nil then
        local alternate3 = alternate.alternate;

        if alternate3 ~= nil then
            alternate3.return_ = nil;
            alternate.alternate = nil;
        end;

        alternate.return_ = nil;
    end;
end;

function commitSuspenseComponent(p138)
    -- upvalues: u8 (ref), supportsMutation (copy), hideOrUnhideAllChildren (copy), enableSuspenseCallback (copy), _G___DEV__ (copy), console (copy)
    local memoizedState = p138.memoizedState;

    if memoizedState ~= nil then
        if not u8 then
            u8 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
        end;

        u8.markCommitTimeOfFallback();

        if supportsMutation then
            hideOrUnhideAllChildren(p138.child, true);
        end;
    end;

    if enableSuspenseCallback and memoizedState ~= nil then
        local suspenseCallback = p138.memoizedProps.suspenseCallback;

        if typeof(suspenseCallback) == "function" then
            local updateQueue = p138.updateQueue;

            if updateQueue ~= nil then
                suspenseCallback(table.clone(updateQueue));
            end;
        elseif _G___DEV__ and suspenseCallback ~= nil then
            console.error("Unexpected type for suspenseCallback: %s", (tostring(suspenseCallback)));
        end;
    end;
end;

function commitSuspenseHydrationCallbacks(p139, p140)
    -- upvalues: supportsHydration (copy), commitHydratedSuspenseInstance (copy), enableSuspenseCallback (copy)
    if not supportsHydration then
        return;
    end;

    if p140.memoizedState == nil then
        local alternate = p140.alternate;

        if alternate ~= nil then
            local memoizedState = alternate.memoizedState;

            if memoizedState ~= nil then
                local dehydrated = memoizedState.dehydrated;

                if dehydrated ~= nil then
                    commitHydratedSuspenseInstance(dehydrated);

                    if enableSuspenseCallback then
                        local hydrationCallbacks = p139.hydrationCallbacks;
                        local v141 = hydrationCallbacks ~= nil and hydrationCallbacks.onHydrated;

                        if v141 then
                            v141(dehydrated);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

function attachSuspenseRetryListeners(u142)
    -- upvalues: Set (copy), resolveRetryWakeable (copy), enableSchedulerTracing (copy), unstable_wrap (copy)
    local updateQueue = u142.updateQueue;

    if updateQueue ~= nil then
        u142.updateQueue = nil;
        local stateNode = u142.stateNode;

        if stateNode == nil then
            u142.stateNode = Set.new();
            stateNode = u142.stateNode;
        end;

        for i, _ in updateQueue do
            local function u143() -- Line: 2075
                -- upvalues: resolveRetryWakeable (ref), u142 (copy), i (copy)
                return resolveRetryWakeable(u142, i);
            end;

            if not stateNode:has(i) then
                if enableSchedulerTracing and i.__reactDoNotTraceInteractions ~= true then
                    u143 = unstable_wrap(u143);
                end;

                stateNode:add(i);
                i:andThen(function() -- Line: 2086
                    -- upvalues: u143 (ref)
                    return u143();
                end, function() -- Line: 2088
                    -- upvalues: u143 (ref)
                    return u143();
                end);
            end;
        end;
    end;
end;

function isSuspenseBoundaryBeingHidden(p144, p145)
    if p144 ~= nil then
        local memoizedState = p144.memoizedState;

        if memoizedState == nil or memoizedState.dehydrated ~= nil then
            local memoizedState2 = p145.memoizedState;
            local v146;

            if memoizedState2 == nil then
                v146 = false;
            else
                v146 = memoizedState2.dehydrated == nil;
            end;

            return v146;
        end;
    end;

    return false;
end;

function commitResetTextContent(p147)
    -- upvalues: supportsMutation (copy), resetTextContent (copy)
    if not supportsMutation then
        return;
    end;

    resetTextContent(p147.stateNode);
end;

function invokeLayoutEffectMountInDEV(p148)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListMount (copy), Layout (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref), ClassComponent (copy)
    if _G___DEV__ and enableDoubleInvokingEffects then
        if p148.tag == FunctionComponent or (p148.tag == ForwardRef or (p148.tag == SimpleMemoComponent or p148.tag == Block)) then
            invokeGuardedCallback(nil, commitHookEffectListMount, nil, bit32.bor(Layout, HasEffect), p148);

            if hasCaughtError() then
                local v149 = clearCaughtError();
                captureCommitPhaseError(p148, p148.return_, v149);
            end;
        end;
    elseif p148.tag == ClassComponent then
        local stateNode = p148.stateNode;
        invokeGuardedCallback(nil, stateNode.componentDidMount, stateNode);

        if hasCaughtError() then
            local v150 = clearCaughtError();
            captureCommitPhaseError(p148, p148.return_, v150);
        end;
    end;
end;

function invokePassiveEffectMountInDEV(p151)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListMount (copy), Passive (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref)
    if not (_G___DEV__ and (enableDoubleInvokingEffects and (p151.tag == FunctionComponent or (p151.tag == ForwardRef or (p151.tag == SimpleMemoComponent or p151.tag == Block))))) then
        return;
    end;

    invokeGuardedCallback(nil, commitHookEffectListMount, nil, bit32.bor(Passive, HasEffect), p151);

    if hasCaughtError() then
        local v152 = clearCaughtError();
        captureCommitPhaseError(p151, p151.return_, v152);
    end;
end;

function invokeLayoutEffectUnmountInDEV(p153)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListUnmount (copy), Layout (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref), ClassComponent (copy)
    if _G___DEV__ and enableDoubleInvokingEffects then
        if p153.tag == FunctionComponent or (p153.tag == ForwardRef or (p153.tag == SimpleMemoComponent or p153.tag == Block)) then
            invokeGuardedCallback(nil, commitHookEffectListUnmount, nil, bit32.bor(Layout, HasEffect), p153, p153.return_);

            if hasCaughtError() then
                local v154 = clearCaughtError();
                captureCommitPhaseError(p153, p153.return_, v154);
            end;
        end;
    elseif p153.tag == ClassComponent then
        local stateNode = p153.stateNode;

        if typeof(stateNode.componentWillUnmount) == "function" then
            safelyCallComponentWillUnmount(p153, stateNode, p153.return_);
        end;
    end;
end;

function invokePassiveEffectUnmountInDEV(p155)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListUnmount (copy), Passive (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref)
    if not (_G___DEV__ and (enableDoubleInvokingEffects and (p155.tag == FunctionComponent or (p155.tag == ForwardRef or (p155.tag == SimpleMemoComponent or p155.tag == Block))))) then
        return;
    end;

    invokeGuardedCallback(nil, commitHookEffectListUnmount, nil, bit32.bor(Passive, HasEffect), p155, p155.return_);

    if hasCaughtError() then
        local v156 = clearCaughtError();
        captureCommitPhaseError(p155, p155.return_, v156);
    end;
end;

return {
    safelyCallDestroy = safelyCallDestroy,

    commitBeforeMutationLifeCycles = function(p157, p158) -- Line: 325, Name: commitBeforeMutationLifeCycles
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), ClassComponent (copy), Snapshot (copy), _G___DEV__ (copy), u15 (copy), console (copy), getComponentName (copy), resolveDefaultProps (copy), HostRoot (copy), supportsMutation (copy), clearContainer (copy), HostComponent (copy), HostText (copy), HostPortal (copy), IncompleteClassComponent (copy), invariant (copy)
        if p158.tag == FunctionComponent or (p158.tag == ForwardRef or (p158.tag == SimpleMemoComponent or p158.tag == Block)) then
            return;
        end;

        if p158.tag == ClassComponent then
            if bit32.band(p158.flags, Snapshot) ~= 0 and p157 ~= nil then
                local memoizedProps = p157.memoizedProps;
                local memoizedState = p157.memoizedState;
                local stateNode = p158.stateNode;

                if _G___DEV__ and (p158.type == p158.elementType and not u15) then
                    if stateNode.props ~= p158.memoizedProps then
                        console.error("Expected %s props to match memoized props before getSnapshotBeforeUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p158.type) or "instance");
                    end;

                    if stateNode.state ~= p158.memoizedState then
                        console.error("Expected %s state to match memoized state before getSnapshotBeforeUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p158.type) or "instance");
                    end;
                end;

                stateNode.__reactInternalSnapshotBeforeUpdate = stateNode:getSnapshotBeforeUpdate(p158.elementType == p158.type and memoizedProps and memoizedProps or resolveDefaultProps(p158.type, memoizedProps), memoizedState);
            end;

            return;
        end;

        if p158.tag == HostRoot then
            if supportsMutation and bit32.band(p158.flags, Snapshot) ~= 0 then
                clearContainer(p158.stateNode.containerInfo);
            end;

            return;
        end;

        if p158.tag == HostComponent or (p158.tag == HostText or (p158.tag == HostPortal or p158.tag == IncompleteClassComponent)) then
            return;
        end;

        invariant(
            false,
            "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue."
        );
    end,

    commitResetTextContent = commitResetTextContent,
    commitPlacement = commitPlacement,
    commitDeletion = commitDeletion,

    commitWork = function(p159, u160) -- Line: 1779, Name: commitWork
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), MemoComponent (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), commitHookEffectListUnmount (copy), Layout (copy), HasEffect (copy), describeError (copy), recordLayoutEffectDuration (copy), ClassComponent (copy), HostComponent (copy), commitUpdate (copy), HostText (copy), invariant (copy), commitTextUpdate (copy), HostRoot (copy), supportsHydration (copy), unimplemented (copy), Profiler (copy), SuspenseComponent (copy), SuspenseListComponent (copy), IncompleteClassComponent (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy), hideOrUnhideAllChildren (copy)
        if u160.tag == FunctionComponent or (u160.tag == ForwardRef or (u160.tag == MemoComponent or (u160.tag == SimpleMemoComponent or u160.tag == Block))) then
            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(u160.mode, ProfileMode) ~= 0) then
                local v161, v162 = xpcall(function() -- Line: 1868
                    -- upvalues: startLayoutEffectTimer (ref), commitHookEffectListUnmount (ref), Layout (ref), HasEffect (ref), u160 (copy)
                    startLayoutEffectTimer();
                    commitHookEffectListUnmount(bit32.bor(Layout, HasEffect), u160, u160.return_);
                end, describeError);
                recordLayoutEffectDuration(u160);

                if not v161 then
                    error(v162);

                    return;
                end;
            else
                commitHookEffectListUnmount(bit32.bor(Layout, HasEffect), u160, u160.return_);
            end;

            return;
        end;

        if u160.tag == ClassComponent then
            return;
        end;

        if u160.tag == HostComponent then
            local stateNode = u160.stateNode;

            if stateNode ~= nil then
                local memoizedProps = u160.memoizedProps;
                local v163;

                if p159 then
                    v163 = p159.memoizedProps;
                else
                    v163 = memoizedProps;
                end;

                local type = u160.type;
                local updateQueue = u160.updateQueue;
                u160.updateQueue = nil;

                if updateQueue ~= nil then
                    commitUpdate(stateNode, updateQueue, type, v163, memoizedProps, u160);
                end;
            end;

            return;
        end;

        if u160.tag == HostText then
            invariant(u160.stateNode ~= nil, "This should have a text node initialized. This error is likely caused by a bug in React. Please file an issue.");
            local memoizedProps = u160.memoizedProps;
            local v164;

            if p159 == nil then
                v164 = nil;
            else
                local _ = p159.memoizedProps;
                v164 = memoizedProps;
            end;

            commitTextUpdate(u160.stateNode, v164, memoizedProps);

            return;
        end;

        if u160.tag == HostRoot then
            if supportsHydration then
                local stateNode = u160.stateNode;

                if stateNode.hydrate then
                    stateNode.hydrate = false;
                    unimplemented("commitWork: HostRoot: commitHydratedContainer");
                end;
            end;

            return;
        end;

        if u160.tag == Profiler then
            return;
        end;

        if u160.tag == SuspenseComponent then
            commitSuspenseComponent(u160);
            attachSuspenseRetryListeners(u160);

            return;
        end;

        if u160.tag == SuspenseListComponent then
            unimplemented("commitWork: SuspenseListComponent");
        else
            if u160.tag == IncompleteClassComponent then
                return;
            end;

            if u160.tag == OffscreenComponent or u160.tag == LegacyHiddenComponent then
                hideOrUnhideAllChildren(u160, u160.memoizedState ~= nil);

                return;
            end;
        end;

        invariant(
            false,
            "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue."
        );
    end,

    commitAttachRef = commitAttachRef,
    commitDetachRef = commitDetachRef,

    commitPassiveUnmount = function(p165) -- Line: 2118, Name: commitPassiveUnmount
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startPassiveEffectTimer (copy), commitHookEffectListUnmount (copy), Passive (copy), HasEffect (copy), recordPassiveEffectDuration (copy)
        if p165.tag == FunctionComponent or (p165.tag == ForwardRef or (p165.tag == SimpleMemoComponent or p165.tag == Block)) then
            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p165.mode, ProfileMode) ~= 0) then
                startPassiveEffectTimer();
                commitHookEffectListUnmount(bit32.bor(Passive, HasEffect), p165, p165.return_);
                recordPassiveEffectDuration(p165);

                return;
            end;

            commitHookEffectListUnmount(bit32.bor(Passive, HasEffect), p165, p165.return_);
        end;
    end,

    commitPassiveUnmountInsideDeletedTree = function(p166, p167) -- Line: 2147, Name: commitPassiveUnmountInsideDeletedTree
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startPassiveEffectTimer (copy), commitHookEffectListUnmount (copy), Passive (copy), recordPassiveEffectDuration (copy)
        if p166.tag == FunctionComponent or (p166.tag == ForwardRef or (p166.tag == SimpleMemoComponent or p166.tag == Block)) then
            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p166.mode, ProfileMode) ~= 0) then
                startPassiveEffectTimer();
                commitHookEffectListUnmount(Passive, p166, p167);
                recordPassiveEffectDuration(p166);

                return;
            end;

            commitHookEffectListUnmount(Passive, p166, p167);
        end;
    end,

    commitPassiveMount = function(p168, p169) -- Line: 2171, Name: commitPassiveMount
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startPassiveEffectTimer (copy), commitHookEffectListMount (copy), describeError (copy), Passive (copy), HasEffect (copy), recordPassiveEffectDuration (copy), Profiler (copy)
        if p169.tag == FunctionComponent or (p169.tag == ForwardRef or (p169.tag == SimpleMemoComponent or p169.tag == Block)) then
            if not (enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p169.mode, ProfileMode) ~= 0)) then
                commitHookEffectListMount(bit32.bor(Passive, HasEffect), p169);

                return;
            end;

            startPassiveEffectTimer();
            local v170, v171 = xpcall(commitHookEffectListMount, describeError, bit32.bor(Passive, HasEffect), p169);
            recordPassiveEffectDuration(p169);

            if not v170 then
                error(v171);
            end;
        elseif p169.tag == Profiler then
            commitProfilerPassiveEffect(p168, p169);
        end;
    end,

    invokeLayoutEffectMountInDEV = invokeLayoutEffectMountInDEV,
    invokeLayoutEffectUnmountInDEV = invokeLayoutEffectUnmountInDEV,
    invokePassiveEffectMountInDEV = invokePassiveEffectMountInDEV,
    invokePassiveEffectUnmountInDEV = invokePassiveEffectUnmountInDEV,
    isSuspenseBoundaryBeingHidden = isSuspenseBoundaryBeingHidden,
    recursivelyCommitLayoutEffects = recursivelyCommitLayoutEffects
};