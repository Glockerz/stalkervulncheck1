-- Decompiled with Potassium's decompiler.

local function unimplemented(p1: string) -- Line: 11
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring(p1));
    error("FIXME (roblox): " .. p1 .. " is unimplemented", 2);
end;

require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local OffscreenLane = ReactFiberLane.OffscreenLane;
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"));
local resetWorkInProgressVersions = require(script.Parent:WaitForChild("ReactMutableSource.new")).resetWorkInProgressVersions;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent;
local FunctionComponent = ReactWorkTags.FunctionComponent;
local ClassComponent = ReactWorkTags.ClassComponent;
local HostRoot = ReactWorkTags.HostRoot;
local HostComponent = ReactWorkTags.HostComponent;
local HostText = ReactWorkTags.HostText;
local HostPortal = ReactWorkTags.HostPortal;
local ContextProvider = ReactWorkTags.ContextProvider;
local ContextConsumer = ReactWorkTags.ContextConsumer;
local ForwardRef = ReactWorkTags.ForwardRef;
local Fragment = ReactWorkTags.Fragment;
local Mode = ReactWorkTags.Mode;
local Profiler = ReactWorkTags.Profiler;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent;
local MemoComponent = ReactWorkTags.MemoComponent;
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent;
local LazyComponent = ReactWorkTags.LazyComponent;
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent;
local FundamentalComponent = ReactWorkTags.FundamentalComponent;
local ScopeComponent = ReactWorkTags.ScopeComponent;
local Block = ReactWorkTags.Block;
local OffscreenComponent = ReactWorkTags.OffscreenComponent;
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent;
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"));
local NoMode = ReactTypeOfMode.NoMode;
local ConcurrentMode = ReactTypeOfMode.ConcurrentMode;
local BlockingMode = ReactTypeOfMode.BlockingMode;
local ProfileMode = ReactTypeOfMode.ProfileMode;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local Ref = ReactFiberFlags.Ref;
local Update = ReactFiberFlags.Update;
local Callback = ReactFiberFlags.Callback;
local Passive = ReactFiberFlags.Passive;
local Deletion = ReactFiberFlags.Deletion;
local NoFlags = ReactFiberFlags.NoFlags;
local DidCapture = ReactFiberFlags.DidCapture;
local Snapshot = ReactFiberFlags.Snapshot;
local MutationMask = ReactFiberFlags.MutationMask;
local LayoutMask = ReactFiberFlags.LayoutMask;
local PassiveMask = ReactFiberFlags.PassiveMask;
local StaticMask = ReactFiberFlags.StaticMask;
local PerformedWork = ReactFiberFlags.PerformedWork;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local createInstance = ReactFiberHostConfig.createInstance;
local createTextInstance = ReactFiberHostConfig.createTextInstance;
local appendInitialChild = ReactFiberHostConfig.appendInitialChild;
local finalizeInitialChildren = ReactFiberHostConfig.finalizeInitialChildren;
local prepareUpdate = ReactFiberHostConfig.prepareUpdate;
local supportsMutation = ReactFiberHostConfig.supportsMutation;
local supportsPersistence = ReactFiberHostConfig.supportsPersistence;
local createContainerChildSet = ReactFiberHostConfig.createContainerChildSet;
local finalizeContainerChildren = ReactFiberHostConfig.finalizeContainerChildren;
local preparePortalMount = ReactFiberHostConfig.preparePortalMount;
local v2 = require(script.Parent:WaitForChild("ReactFiberHostContext.new"));
local getRootHostContainer = v2.getRootHostContainer;
local popHostContext = v2.popHostContext;
local getHostContext = v2.getHostContext;
local popHostContainer = v2.popHostContainer;
local v3 = require(script.Parent:WaitForChild("ReactFiberSuspenseContext.new"));
local popSuspenseContext = v3.popSuspenseContext;
local suspenseStackCursor = v3.suspenseStackCursor;
local InvisibleParentSuspenseContext = v3.InvisibleParentSuspenseContext;
local hasSuspenseContext = v3.hasSuspenseContext;
local v4 = require(script.Parent:WaitForChild("ReactFiberContext.new"));
local isContextProvider = v4.isContextProvider;
local popContext = v4.popContext;
local popTopLevelContextObject = v4.popTopLevelContextObject;
local popProvider = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).popProvider;
local v5 = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new"));
local prepareToHydrateHostSuspenseInstance = v5.prepareToHydrateHostSuspenseInstance;
local popHydrationState = v5.popHydrationState;
local resetHydrationState = v5.resetHydrationState;
local prepareToHydrateHostInstance = v5.prepareToHydrateHostInstance;
local prepareToHydrateHostTextInstance = v5.prepareToHydrateHostTextInstance;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing;
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback;
local enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer;
local enableFundamentalAPI = ReactFeatureFlags.enableFundamentalAPI;
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer;
local u6 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
local popRenderLanes = u6.popRenderLanes;
local markSpawnedWork = u6.markSpawnedWork;
local renderDidSuspend = u6.renderDidSuspend;
local renderDidSuspendDelayIfPossible = u6.renderDidSuspendDelayIfPossible;
local NoLanes = ReactFiberLane.NoLanes;
local includesSomeLane = ReactFiberLane.includesSomeLane;
local mergeLanes = ReactFiberLane.mergeLanes;
local transferActualDuration = require(script.Parent:WaitForChild("ReactProfilerTimer.new")).transferActualDuration;

local function markUpdate(p7) -- Line: 185
    -- upvalues: Update (copy)
    p7.flags = bit32.bor(p7.flags, Update);
end;

local function markRef(p8) -- Line: 191
    -- upvalues: Ref (copy)
    p8.flags = bit32.bor(p8.flags, Ref);
end;

local function hadNoMutationsEffects(p9, p10) -- Line: 197
    -- upvalues: MutationMask (copy), NoFlags (copy)
    local v11;

    if p9 == nil then
        v11 = false;
    else
        v11 = p9.child == p10.child;
    end;

    if v11 then
        return true;
    end;

    local child = p10.child;

    while child ~= nil do
        if bit32.band(child.flags, MutationMask) ~= NoFlags then
            return false;
        end;

        if bit32.band(child.subtreeFlags, MutationMask) ~= NoFlags then
            return false;
        end;

        child = child.sibling;
    end;

    return true;
end;

local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15;

if supportsMutation then
    u15 = function(p16, p17) -- Line: 261
    end;

    u12 = function(p18: any, p19: any, p20: boolean, p21: boolean) -- Line: 223
        -- upvalues: HostComponent (copy), HostText (copy), appendInitialChild (copy), enableFundamentalAPI (copy), FundamentalComponent (copy), HostPortal (copy)
        local child = p19.child;

        while true do
            while true do
                if child == nil then
                    return;
                end;

                if child.tag == HostComponent or child.tag == HostText then
                    break;
                end;

                if enableFundamentalAPI and child.tag == FundamentalComponent then
                    appendInitialChild(p18, child.stateNode.instance);

                    if child == p19 then
                        return;
                    end;

                    while child.sibling == nil do
                        if child.return_ == nil or child.return_ == p19 then
                            return;
                        end;

                        child = child.return_;
                    end;

                    child.sibling.return_ = child.return_;
                    child = child.sibling;
                end;

                if child.tag == HostPortal or child.child == nil then
                    if child == p19 then
                        return;
                    end;

                    while child.sibling == nil do
                        if child.return_ == nil or child.return_ == p19 then
                            return;
                        end;

                        child = child.return_;
                    end;

                    child.sibling.return_ = child.return_;
                    child = child.sibling;
                end;

                child.child.return_ = child;
                child = child.child;
            end;

            appendInitialChild(p18, child.stateNode);

            if child == p19 then
                return;
            end;

            while child.sibling == nil do
                if child.return_ == nil or child.return_ == p19 then
                    return;
                end;

                child = child.return_;
            end;

            child.sibling.return_ = child.return_;
            child = child.sibling;
        end;
    end;

    u13 = function(p22, p23, p24, p25, p26) -- Line: 264, Name: updateHostComponent
        -- upvalues: getHostContext (copy), prepareUpdate (copy), Update (copy)
        local memoizedProps = p22.memoizedProps;

        if memoizedProps == p25 then
            return;
        end;

        local v27 = prepareUpdate(p23.stateNode, p24, memoizedProps, p25, p26, (getHostContext()));
        p23.updateQueue = v27;

        if v27 then
            p23.flags = bit32.bor(p23.flags, Update);
        end;
    end;

    u14 = function(p28: any, p29: any, p30: string, p31: string) -- Line: 305, Name: updateHostText
        -- upvalues: Update (copy)
        if p30 ~= p31 then
            p29.flags = bit32.bor(p29.flags, Update);
        end;
    end;
elseif supportsPersistence then
    local function appendAllChildrenToContainer(p32: any, p33: any, p34: boolean, p35: boolean) -- Line: 413
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("UNIMPLEMENTED ERROR: " .. tostring("appendAllChildrenToContainer"));
        error("FIXME (roblox): appendAllChildrenToContainer is unimplemented", 2);
    end;

    u15 = function(p36, p37) -- Line: 507, Name: updateHostContainer
        -- upvalues: hadNoMutationsEffects (copy), createContainerChildSet (copy), Update (copy), finalizeContainerChildren (copy)
        local stateNode = p37.stateNode;

        if hadNoMutationsEffects(p36, p37) then
            return;
        end;

        local containerInfo = stateNode.containerInfo;
        local v38 = createContainerChildSet(containerInfo);
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("UNIMPLEMENTED ERROR: " .. tostring("appendAllChildrenToContainer"));
        error("FIXME (roblox): appendAllChildrenToContainer is unimplemented", 2);
        stateNode.pendingChildren = v38;
        p37.flags = bit32.bor(p37.flags, Update);
        finalizeContainerChildren(containerInfo, v38);
    end;

    u12 = function(p39: any, p40: any, p41: boolean, p42: boolean) -- Line: 318
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("UNIMPLEMENTED ERROR: " .. tostring("appendAllChildren"));
        error("FIXME (roblox): appendAllChildren is unimplemented", 2);
    end;
else
    u15 = function(p43, p44) -- Line: 623
    end;
end;

local function bubbleProperties(p45) -- Line: 716
    -- upvalues: NoLanes (copy), NoFlags (copy), enableProfilerTimer (copy), ProfileMode (copy), NoMode (copy), mergeLanes (copy), StaticMask (copy)
    local v46;

    if p45.alternate == nil then
        v46 = false;
    else
        v46 = p45.alternate.child == p45.child;
    end;

    local v47 = NoLanes;
    local v48 = NoFlags;

    if v46 then
        if enableProfilerTimer and bit32.band(p45.mode, ProfileMode) ~= NoMode then
            local selfBaseDuration = p45.selfBaseDuration;
            local child = p45.child;

            while child ~= nil do
                v47 = mergeLanes(v47, mergeLanes(child.lanes, child.childLanes));
                local bit32_band_ret = bit32.band(child.subtreeFlags, StaticMask);
                local bit32_bor_ret = bit32.bor(v48, bit32_band_ret);
                local bit32_band_ret2 = bit32.band(child.flags, StaticMask);
                v48 = bit32.bor(bit32_bor_ret, bit32_band_ret2);
                selfBaseDuration = selfBaseDuration + child.treeBaseDuration;
                child = child.sibling;
            end;

            p45.treeBaseDuration = selfBaseDuration;
        else
            local child = p45.child;

            while child ~= nil do
                local bit32_bor_ret = bit32.bor(child.lanes, child.childLanes);
                v47 = bit32.bor(v47, bit32_bor_ret);
                local bit32_band_ret = bit32.band(child.subtreeFlags, StaticMask);
                local bit32_bor_ret2 = bit32.bor(v48, bit32_band_ret);
                local bit32_band_ret2 = bit32.band(child.flags, StaticMask);
                v48 = bit32.bor(bit32_bor_ret2, bit32_band_ret2);
                child.return_ = p45;
                child = child.sibling;
            end;
        end;

        p45.subtreeFlags = bit32.bor(p45.subtreeFlags, v48);
    else
        if enableProfilerTimer and bit32.band(p45.mode, ProfileMode) ~= NoMode then
            local actualDuration = p45.actualDuration;
            local selfBaseDuration = p45.selfBaseDuration;
            local child = p45.child;

            while child ~= nil do
                v47 = mergeLanes(v47, mergeLanes(child.lanes, child.childLanes));
                local bit32_bor_ret = bit32.bor(v48, child.subtreeFlags);
                v48 = bit32.bor(bit32_bor_ret, child.flags);
                actualDuration = actualDuration + child.actualDuration;
                selfBaseDuration = selfBaseDuration + child.treeBaseDuration;
                child = child.sibling;
            end;

            p45.actualDuration = actualDuration;
            p45.treeBaseDuration = selfBaseDuration;
        else
            local child = p45.child;

            while child ~= nil do
                local bit32_bor_ret = bit32.bor(child.lanes, child.childLanes);
                v47 = bit32.bor(v47, bit32_bor_ret);
                local bit32_bor_ret2 = bit32.bor(v48, child.subtreeFlags);
                v48 = bit32.bor(bit32_bor_ret2, child.flags);
                child.return_ = p45;
                child = child.sibling;
            end;
        end;

        p45.subtreeFlags = bit32.bor(p45.subtreeFlags, v48);
    end;

    p45.childLanes = v47;

    return v46;
end;

return {
    completeWork = function(p49, p50, p51) -- Line: 855, Name: completeWork
        -- upvalues: IndeterminateComponent (copy), LazyComponent (copy), SimpleMemoComponent (copy), FunctionComponent (copy), ForwardRef (copy), Fragment (copy), Mode (copy), ContextConsumer (copy), MemoComponent (copy), bubbleProperties (copy), ClassComponent (copy), isContextProvider (copy), popContext (copy), HostRoot (copy), popHostContainer (copy), popTopLevelContextObject (copy), resetWorkInProgressVersions (copy), popHydrationState (copy), Update (copy), Snapshot (copy), u15 (ref), HostComponent (copy), popHostContext (copy), getRootHostContainer (copy), u13 (ref), Ref (copy), invariant (copy), getHostContext (copy), prepareToHydrateHostInstance (copy), createInstance (copy), u12 (ref), finalizeInitialChildren (copy), HostText (copy), u14 (ref), prepareToHydrateHostTextInstance (copy), createTextInstance (copy), Profiler (copy), Callback (copy), Passive (copy), PerformedWork (copy), NoFlags (copy), LayoutMask (copy), Deletion (copy), PassiveMask (copy), SuspenseComponent (copy), popSuspenseContext (copy), enableSuspenseServerRenderer (copy), prepareToHydrateHostSuspenseInstance (copy), enableSchedulerTracing (copy), markSpawnedWork (copy), OffscreenLane (copy), enableProfilerTimer (copy), ProfileMode (copy), NoMode (copy), resetHydrationState (copy), DidCapture (copy), transferActualDuration (copy), BlockingMode (copy), hasSuspenseContext (copy), suspenseStackCursor (copy), InvisibleParentSuspenseContext (copy), renderDidSuspend (copy), renderDidSuspendDelayIfPossible (copy), supportsPersistence (copy), supportsMutation (copy), enableSuspenseCallback (copy), HostPortal (copy), preparePortalMount (copy), ContextProvider (copy), popProvider (copy), IncompleteClassComponent (copy), SuspenseListComponent (copy), FundamentalComponent (copy), ScopeComponent (copy), Block (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy), popRenderLanes (copy), includesSomeLane (copy), u6 (copy), ConcurrentMode (copy)
        local pendingProps = p50.pendingProps;

        if p50.tag == IndeterminateComponent or (p50.tag == LazyComponent or (p50.tag == SimpleMemoComponent or (p50.tag == FunctionComponent or (p50.tag == ForwardRef or (p50.tag == Fragment or (p50.tag == Mode or (p50.tag == ContextConsumer or p50.tag == MemoComponent))))))) then
            bubbleProperties(p50);

            return nil;
        end;

        if p50.tag == ClassComponent then
            if isContextProvider(p50.type) then
                popContext(p50);
            end;

            bubbleProperties(p50);

            return nil;
        end;

        if p50.tag == HostRoot then
            popHostContainer(p50);
            popTopLevelContextObject(p50);
            resetWorkInProgressVersions();
            local stateNode = p50.stateNode;

            if stateNode.pendingContext then
                stateNode.context = stateNode.pendingContext;
                stateNode.pendingContext = nil;
            end;

            if p49 == nil or p49.child == nil then
                if popHydrationState(p50) then
                    p50.flags = bit32.bor(p50.flags, Update);
                elseif not stateNode.hydrate then
                    p50.flags = bit32.bor(p50.flags, Snapshot);
                end;
            end;

            u15(p49, p50);
            bubbleProperties(p50);

            return nil;
        end;

        if p50.tag == HostComponent then
            popHostContext(p50);
            local v52 = getRootHostContainer();
            local type = p50.type;

            if p49 == nil or p50.stateNode == nil then
                if not pendingProps then
                    invariant(p50.stateNode ~= nil, "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue.");
                    bubbleProperties(p50);

                    return nil;
                end;

                local v53 = getHostContext();

                if popHydrationState(p50) then
                    if prepareToHydrateHostInstance(p50, v52, v53) then
                        p50.flags = bit32.bor(p50.flags, Update);
                    end;
                else
                    local v54 = createInstance(type, pendingProps, v52, v53, p50);
                    u12(v54, p50, false, false);
                    p50.stateNode = v54;

                    if finalizeInitialChildren(v54, type, pendingProps, v52, v53) then
                        p50.flags = bit32.bor(p50.flags, Update);
                    end;
                end;

                if p50.ref ~= nil then
                    p50.flags = bit32.bor(p50.flags, Ref);
                end;
            else
                u13(p49, p50, type, pendingProps, v52);

                if p49.ref ~= p50.ref then
                    p50.flags = bit32.bor(p50.flags, Ref);
                end;
            end;

            bubbleProperties(p50);

            return nil;
        end;

        if p50.tag == HostText then
            if p49 and p50.stateNode ~= nil then
                u14(p49, p50, p49.memoizedProps, pendingProps);
            else
                if typeof(pendingProps) ~= "string" then
                    invariant(p50.stateNode ~= nil, "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue.");
                end;

                local v55 = getRootHostContainer();
                local v56 = getHostContext();

                if popHydrationState(p50) then
                    if prepareToHydrateHostTextInstance(p50) then
                        p50.flags = bit32.bor(p50.flags, Update);
                    end;
                else
                    p50.stateNode = createTextInstance(pendingProps, v55, v56, p50);
                end;
            end;

            bubbleProperties(p50);

            return nil;
        end;

        if p50.tag ~= Profiler then
            if p50.tag ~= SuspenseComponent then
                if p50.tag == HostPortal then
                    popHostContainer(p50);
                    u15(p49, p50);

                    if p49 == nil then
                        preparePortalMount(p50.stateNode.containerInfo);
                    end;

                    bubbleProperties(p50);

                    return nil;
                end;

                if p50.tag == ContextProvider then
                    popProvider(p50);
                    bubbleProperties(p50);

                    return nil;
                end;

                if p50.tag == IncompleteClassComponent then
                    if isContextProvider(p50.type) then
                        popContext(p50);
                    end;

                    bubbleProperties(p50);

                    return nil;
                end;

                if p50.tag == SuspenseListComponent then
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("UNIMPLEMENTED ERROR: " .. tostring("SuspenseListComponent"));
                    error("FIXME (roblox): SuspenseListComponent is unimplemented", 2);
                elseif p50.tag == FundamentalComponent then
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("UNIMPLEMENTED ERROR: " .. tostring("FundamentalComponent"));
                    error("FIXME (roblox): FundamentalComponent is unimplemented", 2);
                elseif p50.tag == ScopeComponent then
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("UNIMPLEMENTED ERROR: " .. tostring("ScopeComponent"));
                    error("FIXME (roblox): ScopeComponent is unimplemented", 2);
                elseif p50.tag == Block then
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("UNIMPLEMENTED ERROR: " .. tostring("Block"));
                    error("FIXME (roblox): Block is unimplemented", 2);
                elseif p50.tag == OffscreenComponent or p50.tag == LegacyHiddenComponent then
                    popRenderLanes(p50);
                    local v57 = p50.memoizedState ~= nil;

                    if p49 ~= nil and (p49.memoizedState ~= nil ~= v57 and pendingProps.mode ~= "unstable-defer-without-hiding") then
                        p50.flags = bit32.bor(p50.flags, Update);
                    end;

                    if not (v57 and (not includesSomeLane(u6.subtreeRenderLanes, OffscreenLane) and bit32.band(p50.mode, ConcurrentMode) ~= NoMode)) then
                        bubbleProperties(p50);
                    end;

                    return nil;
                end;

                invariant(false, "Unknown unit of work tag (%s). This error is likely caused by a bug in React. Please file an issue.", (tostring(p50.tag)));

                return nil;
            end;

            popSuspenseContext(p50);
            local memoizedState = p50.memoizedState;

            if enableSuspenseServerRenderer and (memoizedState ~= nil and memoizedState.dehydrated ~= nil) then
                if p49 == nil then
                    invariant(popHydrationState(p50), "A dehydrated suspense component was completed without a hydrated node. This is probably a bug in React.");
                    prepareToHydrateHostSuspenseInstance(p50);

                    if enableSchedulerTracing then
                        markSpawnedWork(OffscreenLane);
                    end;

                    bubbleProperties(p50);

                    if enableProfilerTimer and bit32.band(p50.mode, ProfileMode) ~= NoMode and memoizedState ~= nil then
                        local child = p50.child;

                        if child ~= nil then
                            p50.treeBaseDuration = child.treeBaseDuration;
                        end;
                    end;

                    return nil;
                end;

                resetHydrationState();

                if bit32.band(p50.flags, DidCapture) == NoFlags then
                    p50.memoizedState = nil;
                end;

                p50.flags = bit32.bor(p50.flags, Update);
                bubbleProperties(p50);

                if enableProfilerTimer and bit32.band(p50.mode, ProfileMode) ~= NoMode and memoizedState ~= nil then
                    local child = p50.child;

                    if child ~= nil then
                        p50.treeBaseDuration = p50.treeBaseDuration - child.treeBaseDuration;
                    end;
                end;

                return nil;
            end;

            if bit32.band(p50.flags, DidCapture) ~= NoFlags then
                p50.lanes = p51;

                if enableProfilerTimer and bit32.band(p50.mode, ProfileMode) ~= NoMode then
                    transferActualDuration(p50);
                end;

                return p50;
            end;

            local v58 = memoizedState ~= nil;
            local v59 = false;

            if p49 == nil then
                if p50.memoizedProps.fallback ~= nil then
                    popHydrationState(p50);
                end;
            else
                v59 = p49.memoizedState ~= nil;
            end;

            if v58 and (not v59 and bit32.band(p50.mode, BlockingMode) ~= NoMode) then
                local v60;

                if p49 == nil then
                    v60 = p50.memoizedProps.unstable_avoidThisFallback ~= true;
                else
                    v60 = false;
                end;

                if v60 or hasSuspenseContext(suspenseStackCursor.current, InvisibleParentSuspenseContext) then
                    renderDidSuspend();
                else
                    renderDidSuspendDelayIfPossible();
                end;
            end;

            if supportsPersistence and v58 then
                p50.flags = bit32.bor(p50.flags, Update);
            end;

            if supportsMutation and (v58 or v59) then
                p50.flags = bit32.bor(p50.flags, Update);
            end;

            if enableSuspenseCallback and (p50.updateQueue ~= nil and p50.memoizedProps.suspenseCallback ~= nil) then
                p50.flags = bit32.bor(p50.flags, Update);
            end;

            bubbleProperties(p50);

            if enableProfilerTimer and (bit32.band(p50.mode, ProfileMode) ~= NoMode and v58) then
                local child = p50.child;

                if child ~= nil then
                    p50.treeBaseDuration = p50.treeBaseDuration - child.treeBaseDuration;
                end;
            end;

            return nil;
        end;

        if not bubbleProperties(p50) then
            local v61 = Update;
            local v62 = Callback;
            local v63 = Passive;
            local subtreeFlags = p50.subtreeFlags;
            local flags = p50.flags;
            local v64;

            if bit32.band(flags, PerformedWork) == NoFlags and bit32.band(subtreeFlags, PerformedWork) == NoFlags then
                v64 = flags;
            else
                v64 = bit32.bor(flags, v61);
            end;

            local bit32_bor_ret = bit32.bor(LayoutMask, Deletion);

            if bit32.band(flags, bit32_bor_ret) == NoFlags then
                local bit32_bor_ret2 = bit32.bor(LayoutMask, Deletion);

                if bit32.band(subtreeFlags, bit32_bor_ret2) ~= NoFlags then
                    v64 = bit32.bor(v64, v62);
                end;
            else
                v64 = bit32.bor(v64, v62);
            end;

            if bit32.band(flags, PassiveMask) ~= NoFlags or bit32.band(subtreeFlags, PassiveMask) ~= NoFlags then
                v64 = bit32.bor(v64, v63);
            end;

            p50.flags = v64;
        end;

        return nil;
    end
};