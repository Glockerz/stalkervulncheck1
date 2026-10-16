-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Object = v1.Object;
local Array = v1.Array;
local inspect = v1.util.inspect;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactRootTags = require(script.Parent:WaitForChild("ReactRootTags"));
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
require(script.Parent:WaitForChild("ReactFiberHostConfig"));
require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"));
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local enableProfilerTimer = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableProfilerTimer;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local NoFlags = ReactFiberFlags.NoFlags;
local Placement = ReactFiberFlags.Placement;
local StaticMask = ReactFiberFlags.StaticMask;
local ConcurrentRoot = ReactRootTags.ConcurrentRoot;
local BlockingRoot = ReactRootTags.BlockingRoot;
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent;
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
local DehydratedFragment = ReactWorkTags.DehydratedFragment;
local FunctionComponent = ReactWorkTags.FunctionComponent;
local MemoComponent = ReactWorkTags.MemoComponent;
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent;
local LazyComponent = ReactWorkTags.LazyComponent;
local FundamentalComponent = ReactWorkTags.FundamentalComponent;
local ScopeComponent = ReactWorkTags.ScopeComponent;
local OffscreenComponent = ReactWorkTags.OffscreenComponent;
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local isDevToolsPresent = require(script.Parent:WaitForChild("ReactFiberDevToolsHook.new")).isDevToolsPresent;
local v2 = require(script.Parent:WaitForChild("ReactFiberHotReloading.new"));
local resolveClassForHotReloading = v2.resolveClassForHotReloading;
local resolveFunctionForHotReloading = v2.resolveFunctionForHotReloading;
local resolveForwardRefForHotReloading = v2.resolveForwardRefForHotReloading;
local NoLanes = ReactFiberLane.NoLanes;
local NoMode = ReactTypeOfMode.NoMode;
local ConcurrentMode = ReactTypeOfMode.ConcurrentMode;
local DebugTracingMode = ReactTypeOfMode.DebugTracingMode;
local ProfileMode = ReactTypeOfMode.ProfileMode;
local StrictMode = ReactTypeOfMode.StrictMode;
local BlockingMode = ReactTypeOfMode.BlockingMode;
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols;
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE;
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE;
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE;
local REACT_DEBUG_TRACING_MODE_TYPE = ReactSymbols.REACT_DEBUG_TRACING_MODE_TYPE;
local REACT_STRICT_MODE_TYPE = ReactSymbols.REACT_STRICT_MODE_TYPE;
local REACT_PROFILER_TYPE = ReactSymbols.REACT_PROFILER_TYPE;
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE;
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE;
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE;
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE;
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE;
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE;
local REACT_OFFSCREEN_TYPE = ReactSymbols.REACT_OFFSCREEN_TYPE;
local REACT_LEGACY_HIDDEN_TYPE = ReactSymbols.REACT_LEGACY_HIDDEN_TYPE;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = 1;

local function createFiber(p9, p10, p11, p12, p13, p14, p15, p16) -- Line: 164
    -- upvalues: NoFlags (copy), NoLanes (copy), enableProfilerTimer (copy), _G___DEV__ (copy), u8 (ref)
    local v17 = {
        index = 1,
        tag = p9,
        key = p11,
        elementType = p13,
        type = p14,
        stateNode = p15,
        pendingProps = p10,
        mode = p12,
        flags = NoFlags,
        subtreeFlags = NoFlags,
        lanes = p16 or NoLanes,
        childLanes = NoLanes
    };

    if enableProfilerTimer then
        v17.actualDuration = 0;
        v17.actualStartTime = -1;
        v17.selfBaseDuration = 0;
        v17.treeBaseDuration = 0;
    end;

    if _G___DEV__ then
        v17._debugID = u8;
        u8 = u8 + 1;
        v17._debugSource = nil;
        v17._debugOwner = nil;
        v17._debugNeedsRemount = false;
        v17._debugHookTypes = nil;
    end;

    return v17;
end;

function _shouldConstruct(p18)
    local v19;

    if type(p18) == "function" then
        v19 = false;
    else
        v19 = p18.isReactComponent and true or false;
    end;

    return v19;
end;

local function createFiberFromTypeAndProps(p20: any, p21: string?, p22: any, p23: any, p24: any, p25: any) -- Line: 502
    -- upvalues: IndeterminateComponent (copy), _G___DEV__ (copy), resolveFunctionForHotReloading (copy), ClassComponent (copy), resolveClassForHotReloading (copy), HostComponent (copy), REACT_FRAGMENT_TYPE (copy), u4 (ref), REACT_DEBUG_TRACING_MODE_TYPE (copy), Mode (copy), DebugTracingMode (copy), REACT_STRICT_MODE_TYPE (copy), StrictMode (copy), REACT_PROFILER_TYPE (copy), u3 (ref), REACT_SUSPENSE_TYPE (copy), u5 (ref), REACT_OFFSCREEN_TYPE (copy), u6 (ref), REACT_LEGACY_HIDDEN_TYPE (copy), u7 (ref), REACT_PROVIDER_TYPE (copy), ContextProvider (copy), REACT_CONTEXT_TYPE (copy), ContextConsumer (copy), REACT_FORWARD_REF_TYPE (copy), ForwardRef (copy), resolveForwardRefForHotReloading (copy), REACT_MEMO_TYPE (copy), MemoComponent (copy), REACT_LAZY_TYPE (copy), LazyComponent (copy), Object (copy), inspect (copy), getComponentName (copy), Array (copy), REACT_ELEMENT_TYPE (copy), invariant (copy), createFiber (copy)
    local v26 = IndeterminateComponent;
    local v27 = type(p20);
    local v28;

    if v27 == "function" then
        if _G___DEV__ then
            v28 = resolveFunctionForHotReloading(p20);
        else
            v28 = p20;
        end;
    elseif v27 == "table" and p20.isReactComponent then
        v26 = ClassComponent;

        if _G___DEV__ then
            v28 = resolveClassForHotReloading(p20);
        else
            v28 = p20;
        end;
    elseif v27 == "string" then
        v26 = HostComponent;
        v28 = p20;
    else
        if p20 == REACT_FRAGMENT_TYPE then
            return u4(p22.children, p24, p25, p21);
        end;

        if p20 == REACT_DEBUG_TRACING_MODE_TYPE then
            v26 = Mode;
            p24 = bit32.bor(p24, DebugTracingMode);
            v28 = p20;
        elseif p20 == REACT_STRICT_MODE_TYPE then
            v26 = Mode;
            p24 = bit32.bor(p24, StrictMode);
            v28 = p20;
        else
            if p20 == REACT_PROFILER_TYPE then
                return u3(p22, p24, p25, p21);
            end;

            if p20 == REACT_SUSPENSE_TYPE then
                return u5(p22, p24, p25, p21);
            end;

            if p20 == REACT_OFFSCREEN_TYPE then
                return u6(p22, p24, p25, p21);
            end;

            if p20 == REACT_LEGACY_HIDDEN_TYPE then
                return u7(p22, p24, p25, p21);
            end;

            local v29 = false;
            local v30;

            if v27 == "table" then
                v30 = p20["$$typeof"];

                if v30 == REACT_PROVIDER_TYPE then
                    v26 = ContextProvider;
                    v28 = p20;
                    v29 = true;
                elseif v30 == REACT_CONTEXT_TYPE then
                    v26 = ContextConsumer;
                    v28 = p20;
                    v29 = true;
                elseif v30 == REACT_FORWARD_REF_TYPE then
                    v26 = ForwardRef;

                    if _G___DEV__ then
                        v28 = resolveForwardRefForHotReloading(p20);
                    else
                        v28 = p20;
                    end;

                    v29 = true;
                elseif v30 == REACT_MEMO_TYPE then
                    v26 = MemoComponent;
                    v28 = p20;
                    v29 = true;
                elseif v30 == REACT_LAZY_TYPE then
                    v26 = LazyComponent;
                    v29 = true;
                    v28 = nil;
                else
                    v28 = p20;
                end;
            else
                v28 = p20;
                v30 = nil;
            end;

            if not v29 then
                local v31 = "";

                if _G___DEV__ then
                    if p20 == nil or v27 == "table" and #Object.keys(p20) == 0 then
                        v31 = v31 .. " You likely forgot to export your component from the file it\'s defined in, or you might have mixed up default and named imports.";
                    elseif p20 ~= nil and v27 == "table" then
                        v31 = v31 .. "\n" .. inspect(p20);
                    end;

                    local v32;

                    if p23 then
                        v32 = getComponentName(p23.type);
                    else
                        v32 = nil;
                    end;

                    if v32 == nil or v32 == "" then
                        if p23 then
                            v31 = v31 .. "\n" .. inspect(p23);
                        end;
                    else
                        v31 = v31 .. "\n\nCheck the render method of `" .. v32 .. "`.";
                    end;
                end;

                if p20 == nil then
                    v27 = "nil";
                elseif Array.isArray(p20) then
                    v27 = "array";
                elseif v27 == "table" and v30 == REACT_ELEMENT_TYPE then
                    v27 = string.format("<%s />", getComponentName(p20.type) or "Unknown");
                    v31 = " Did you accidentally export a JSX literal or Element instead of a component?";
                end;

                invariant(false, "Element type is invalid: expected a string (for built-in components) or a class/function (for composite components) but got: %s.%s", v27, v31);
            end;
        end;
    end;

    local v33 = createFiber(v26, p22, p21, p24, p20, v28, nil, p25);

    if _G___DEV__ then
        v33._debugOwner = p23;
    end;

    return v33;
end;

u4 = function(p34: any, p35: any, p36: any, p37: string?) -- Line: 684, Name: createFiberFromFragment
    -- upvalues: createFiber (copy), Fragment (copy)
    return createFiber(Fragment, p34, p37, p35, nil, nil, nil, p36);
end;

local function createFiberFromScope(p38: any, p39: any, p40: any, p41: any, p42: string?) -- Line: 722
    -- upvalues: createFiber (copy), ScopeComponent (copy)
    return createFiber(ScopeComponent, p39, p42, p40, p38, p38, nil, p41);
end;

u3 = function(p43: any, p44: any, p45: any, p46: string?) -- Line: 739, Name: createFiberFromProfiler
    -- upvalues: _G___DEV__ (copy), console (copy), createFiber (copy), Profiler (copy), ProfileMode (copy), REACT_PROFILER_TYPE (copy), enableProfilerTimer (copy)
    if _G___DEV__ and typeof(p43.id) ~= "string" then
        console.error("Profiler must specify an \"id\" as a prop");
    end;

    return createFiber(Profiler, p43, p46, bit32.bor(p44, ProfileMode), REACT_PROFILER_TYPE, REACT_PROFILER_TYPE, enableProfilerTimer and {
        effectDuration = 0,
        passiveEffectDuration = 0
    } or nil, p45);
end;

u5 = function(p47: any, p48: any, p49: any, p50: string?) -- Line: 783, Name: createFiberFromSuspense
    -- upvalues: createFiber (copy), SuspenseComponent (copy), REACT_SUSPENSE_TYPE (copy)
    return createFiber(SuspenseComponent, p47, p50, p48, REACT_SUSPENSE_TYPE, REACT_SUSPENSE_TYPE, nil, p49);
end;

u6 = function(p51: any, p52: any, p53: any, p54: string?) -- Line: 841, Name: createFiberFromOffscreen
    -- upvalues: createFiber (copy), OffscreenComponent (copy), REACT_OFFSCREEN_TYPE (copy), _G___DEV__ (copy)
    local v55;

    if _G___DEV__ then
        v55 = REACT_OFFSCREEN_TYPE;
    else
        v55 = nil;
    end;

    return createFiber(OffscreenComponent, p51, p54, p52, REACT_OFFSCREEN_TYPE, v55, nil, p53);
end;

u7 = function(p56: any, p57: any, p58: any, p59: string?) -- Line: 870, Name: createFiberFromLegacyHidden
    -- upvalues: createFiber (copy), LegacyHiddenComponent (copy), REACT_LEGACY_HIDDEN_TYPE (copy), _G___DEV__ (copy)
    local v60;

    if _G___DEV__ then
        v60 = REACT_LEGACY_HIDDEN_TYPE;
    else
        v60 = nil;
    end;

    return createFiber(LegacyHiddenComponent, p56, p59, p57, REACT_LEGACY_HIDDEN_TYPE, v60, nil, p58);
end;

return {
    isSimpleFunctionComponent = function(p61) -- Line: 271, Name: isSimpleFunctionComponent
        return type(p61) == "function";
    end,

    resolveLazyComponentTag = function(p62) -- Line: 279, Name: resolveLazyComponentTag
        -- upvalues: FunctionComponent (copy), ClassComponent (copy), REACT_FORWARD_REF_TYPE (copy), ForwardRef (copy), REACT_MEMO_TYPE (copy), MemoComponent (copy), IndeterminateComponent (copy)
        local v63 = typeof(p62);

        if v63 == "function" then
            return FunctionComponent;
        end;

        if v63 == "table" then
            if p62.isReactComponent then
                return ClassComponent;
            end;

            local v64 = p62["$$typeof"];

            if v64 == REACT_FORWARD_REF_TYPE then
                return ForwardRef;
            end;

            if v64 == REACT_MEMO_TYPE then
                return MemoComponent;
            end;
        end;

        return IndeterminateComponent;
    end,

    createWorkInProgress = function(p65, p66) -- Line: 302, Name: createWorkInProgress
        -- upvalues: createFiber (copy), _G___DEV__ (copy), NoFlags (copy), enableProfilerTimer (copy), StaticMask (copy), IndeterminateComponent (copy), FunctionComponent (copy), SimpleMemoComponent (copy), resolveFunctionForHotReloading (copy), ClassComponent (copy), resolveClassForHotReloading (copy), ForwardRef (copy), resolveForwardRefForHotReloading (copy)
        local alternate = p65.alternate;

        if alternate == nil then
            alternate = createFiber(p65.tag, p66, p65.key, p65.mode, p65.elementType, p65.type, p65.stateNode);

            if _G___DEV__ then
                alternate._debugID = p65._debugID;
                alternate._debugSource = p65._debugSource;
                alternate._debugOwner = p65._debugOwner;
                alternate._debugHookTypes = p65._debugHookTypes;
            end;

            alternate.alternate = p65;
            p65.alternate = alternate;
        else
            alternate.pendingProps = p66;
            alternate.type = p65.type;
            alternate.flags = NoFlags;
            alternate.subtreeFlags = NoFlags;
            alternate.deletions = nil;

            if enableProfilerTimer then
                alternate.actualDuration = 0;
                alternate.actualStartTime = -1;
            end;
        end;

        alternate.flags = bit32.band(p65.flags, StaticMask);
        alternate.childLanes = p65.childLanes;
        alternate.lanes = p65.lanes;
        alternate.child = p65.child;
        alternate.memoizedProps = p65.memoizedProps;
        alternate.memoizedState = p65.memoizedState;
        alternate.updateQueue = p65.updateQueue;
        local dependencies = p65.dependencies;

        if dependencies == nil then
            alternate.dependencies = nil;
        else
            alternate.dependencies = {
                lanes = dependencies.lanes,
                firstContext = dependencies.firstContext
            };
        end;

        alternate.sibling = p65.sibling;
        alternate.index = p65.index;
        alternate.ref = p65.ref;

        if enableProfilerTimer then
            alternate.selfBaseDuration = p65.selfBaseDuration;
            alternate.treeBaseDuration = p65.treeBaseDuration;
        end;

        if _G___DEV__ then
            alternate._debugNeedsRemount = p65._debugNeedsRemount;

            if alternate.tag == IndeterminateComponent or (alternate.tag == FunctionComponent or alternate.tag == SimpleMemoComponent) then
                alternate.type = resolveFunctionForHotReloading(p65.type);

                return alternate;
            end;

            if alternate.tag == ClassComponent then
                alternate.type = resolveClassForHotReloading(p65.type);

                return alternate;
            end;

            if alternate.tag == ForwardRef then
                alternate.type = resolveForwardRefForHotReloading(p65.type);
            end;
        end;

        return alternate;
    end,

    resetWorkInProgress = function(p67, p68) -- Line: 406, Name: resetWorkInProgress
        -- upvalues: StaticMask (copy), Placement (copy), NoLanes (copy), NoFlags (copy), enableProfilerTimer (copy)
        local flags = p67.flags;
        local bit32_bor_ret = bit32.bor(StaticMask, Placement);
        p67.flags = bit32.band(flags, bit32_bor_ret);
        local alternate = p67.alternate;

        if alternate == nil then
            p67.childLanes = NoLanes;
            p67.lanes = p68;
            p67.child = nil;
            p67.subtreeFlags = NoFlags;
            p67.memoizedProps = nil;
            p67.memoizedState = nil;
            p67.updateQueue = nil;
            p67.dependencies = nil;
            p67.stateNode = nil;

            if enableProfilerTimer then
                p67.selfBaseDuration = 0;
                p67.treeBaseDuration = 0;

                return p67;
            end;
        else
            p67.childLanes = alternate.childLanes;
            p67.lanes = alternate.lanes;
            p67.child = alternate.child;
            p67.subtreeFlags = alternate.subtreeFlags;
            p67.deletions = nil;
            p67.memoizedProps = alternate.memoizedProps;
            p67.memoizedState = alternate.memoizedState;
            p67.updateQueue = alternate.updateQueue;
            p67.type = alternate.type;
            local dependencies = alternate.dependencies;

            if dependencies == nil then
                p67.dependencies = nil;
            else
                p67.dependencies = {
                    lanes = dependencies.lanes,
                    firstContext = dependencies.firstContext
                };
            end;

            if enableProfilerTimer then
                p67.selfBaseDuration = alternate.selfBaseDuration;
                p67.treeBaseDuration = alternate.treeBaseDuration;
            end;
        end;

        return p67;
    end,

    createHostRootFiber = function(p69) -- Line: 481, Name: createHostRootFiber
        -- upvalues: ConcurrentRoot (copy), ConcurrentMode (copy), BlockingMode (copy), StrictMode (copy), BlockingRoot (copy), NoMode (copy), enableProfilerTimer (copy), isDevToolsPresent (copy), ProfileMode (copy), createFiber (copy), HostRoot (copy)
        local v70;

        if p69 == ConcurrentRoot then
            v70 = bit32.bor(ConcurrentMode, BlockingMode, StrictMode);
        elseif p69 == BlockingRoot then
            v70 = bit32.bor(BlockingMode, StrictMode);
        else
            v70 = NoMode;
        end;

        if enableProfilerTimer and isDevToolsPresent() then
            v70 = bit32.bor(v70, ProfileMode);
        end;

        return createFiber(HostRoot, nil, nil, v70);
    end,

    createFiberFromTypeAndProps = createFiberFromTypeAndProps,

    createFiberFromElement = function(p71, p72, p73) -- Line: 656, Name: createFiberFromElement
        -- upvalues: _G___DEV__ (copy), createFiberFromTypeAndProps (copy)
        local v74;

        if _G___DEV__ then
            v74 = p71._owner;
        else
            v74 = nil;
        end;

        local v75 = createFiberFromTypeAndProps(p71.type, p71.key, p71.props, v74, p72, p73);

        if _G___DEV__ then
            v75._debugSource = p71._source;
            v75._debugOwner = p71._owner;
        end;

        return v75;
    end,

    createFiberFromFragment = u4,

    createFiberFromFundamental = function(p76: any, p77: any, p78: any, p79: any, p80: string?) -- Line: 697, Name: createFiberFromFundamental
        -- upvalues: createFiber (copy), FundamentalComponent (copy)
        return createFiber(FundamentalComponent, p77, p80, p78, p76, p76, nil, p79);
    end,

    createFiberFromSuspense = u5,

    createFiberFromSuspenseList = function(p81: any, p82: any, p83: any, p84: string?) -- Line: 812, Name: createFiberFromSuspenseList
        -- upvalues: createFiber (copy), SuspenseListComponent (copy), REACT_SUSPENSE_LIST_TYPE (copy), _G___DEV__ (copy)
        local v85;

        if _G___DEV__ then
            v85 = REACT_SUSPENSE_LIST_TYPE;
        else
            v85 = nil;
        end;

        return createFiber(SuspenseListComponent, p81, p84, p82, REACT_SUSPENSE_LIST_TYPE, v85, nil, p83);
    end,

    createFiberFromOffscreen = u6,
    createFiberFromLegacyHidden = u7,

    createFiberFromText = function(p86: string, p87: any, p88: any) -- Line: 899, Name: createFiberFromText
        -- upvalues: createFiber (copy), HostText (copy)
        return createFiber(HostText, p86, nil, p87, nil, nil, nil, p88);
    end,

    createFiberFromHostInstanceForDeletion = function() -- Line: 907, Name: createFiberFromHostInstanceForDeletion
        -- upvalues: createFiber (copy), HostComponent (copy), NoMode (copy)
        return createFiber(HostComponent, nil, nil, NoMode, "DELETED", "DELETED");
    end,

    createFiberFromDehydratedFragment = function(p89) -- Line: 917, Name: createFiberFromDehydratedFragment
        -- upvalues: createFiber (copy), DehydratedFragment (copy), NoMode (copy)
        return createFiber(DehydratedFragment, nil, nil, NoMode, nil, nil, p89);
    end,

    createFiberFromPortal = function(p90, p91, p92) -- Line: 926, Name: createFiberFromPortal
        -- upvalues: createFiber (copy), HostPortal (copy)
        return createFiber(HostPortal, p90.children == nil and {} or p90.children, p90.key, p91, nil, nil, {
            pendingChildren = nil,
            containerInfo = p90.containerInfo,
            implementation = p90.implementation
        }, p92);
    end,

    assignFiberPropertiesInDEV = function(p93, p94) -- Line: 950, Name: assignFiberPropertiesInDEV
        -- upvalues: createFiber (copy), IndeterminateComponent (copy), NoMode (copy), enableProfilerTimer (copy)
        if p93 == nil then
            p93 = createFiber(IndeterminateComponent, nil, nil, NoMode);
        end;

        p93.tag = p94.tag;
        p93.key = p94.key;
        p93.elementType = p94.elementType;
        p93.type = p94.type;
        p93.stateNode = p94.stateNode;
        p93.return_ = p94.return_;
        p93.child = p94.child;
        p93.sibling = p94.sibling;
        p93.index = p94.index;
        p93.ref = p94.ref;
        p93.pendingProps = p94.pendingProps;
        p93.memoizedProps = p94.memoizedProps;
        p93.updateQueue = p94.updateQueue;
        p93.memoizedState = p94.memoizedState;
        p93.dependencies = p94.dependencies;
        p93.mode = p94.mode;
        p93.flags = p94.flags;
        p93.subtreeFlags = p94.subtreeFlags;
        p93.deletions = p94.deletions;
        p93.lanes = p94.lanes;
        p93.childLanes = p94.childLanes;
        p93.alternate = p94.alternate;

        if enableProfilerTimer then
            p93.actualDuration = p94.actualDuration;
            p93.actualStartTime = p94.actualStartTime;
            p93.selfBaseDuration = p94.selfBaseDuration;
            p93.treeBaseDuration = p94.treeBaseDuration;
        end;

        p93._debugID = p94._debugID;
        p93._debugSource = p94._debugSource;
        p93._debugOwner = p94._debugOwner;
        p93._debugNeedsRemount = p94._debugNeedsRemount;
        p93._debugHookTypes = p94._debugHookTypes;

        return p93;
    end
};