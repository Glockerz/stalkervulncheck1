-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local v1 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"));
require(script.Parent.Parent:WaitForChild("shared"));
local react = require(script.Parent.Parent:WaitForChild("react"));
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local Update = ReactFiberFlags.Update;
local Snapshot = ReactFiberFlags.Snapshot;
local MountLayoutDev = ReactFiberFlags.MountLayoutDev;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local debugRenderPhaseSideEffectsForStrictMode = ReactFeatureFlags.debugRenderPhaseSideEffectsForStrictMode;
local disableLegacyContext = ReactFeatureFlags.disableLegacyContext;
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing;
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler;
local warnAboutDeprecatedLifecycles = ReactFeatureFlags.warnAboutDeprecatedLifecycles;
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects;
local u2 = require(script.Parent:WaitForChild("ReactStrictModeWarnings.new"));
local isMounted = require(script.Parent:WaitForChild("ReactFiberTreeReflection")).isMounted;
local ReactInstanceMap = require(script.Parent.Parent:WaitForChild("shared")).ReactInstanceMap;
local get = ReactInstanceMap.get;
local set = ReactInstanceMap.set;
local shallowEqual = require(script.Parent.Parent:WaitForChild("shared")).shallowEqual;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local UninitializedState = require(script.Parent.Parent:WaitForChild("shared")).UninitializedState;
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols;
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE;
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE;
local resolveDefaultProps = require(script.Parent:WaitForChild("ReactFiberLazyComponent.new")).resolveDefaultProps;
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"));
local DebugTracingMode = ReactTypeOfMode.DebugTracingMode;
local StrictMode = ReactTypeOfMode.StrictMode;
local enqueueUpdate = v1.enqueueUpdate;
local processUpdateQueue = v1.processUpdateQueue;
local checkHasForceUpdateAfterProcessing = v1.checkHasForceUpdateAfterProcessing;
local resetHasForceUpdateBeforeProcessing = v1.resetHasForceUpdateBeforeProcessing;
local createUpdate = v1.createUpdate;
local ReplaceState = v1.ReplaceState;
local ForceUpdate = v1.ForceUpdate;
local initializeUpdateQueue = v1.initializeUpdateQueue;
local cloneUpdateQueue = v1.cloneUpdateQueue;
local NoLanes = ReactFiberLane.NoLanes;
local v3 = require(script.Parent:WaitForChild("ReactFiberContext.new"));
local cacheContext = v3.cacheContext;
local getMaskedContext = v3.getMaskedContext;
local getUnmaskedContext = v3.getUnmaskedContext;
local hasContextChanged = v3.hasContextChanged;
local emptyContextObject = v3.emptyContextObject;
local readContext = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).readContext;
local DebugTracing = require(script.Parent:WaitForChild("DebugTracing"));
local logForceUpdateScheduled = DebugTracing.logForceUpdateScheduled;
local logStateUpdateScheduled = DebugTracing.logStateUpdateScheduled;
local ConsolePatchingDev = require(script.Parent.Parent:WaitForChild("shared")).ConsolePatchingDev;
local disableLogs = ConsolePatchingDev.disableLogs;
local reenableLogs = ConsolePatchingDev.reenableLogs;
local SchedulingProfiler = require(script.Parent:WaitForChild("SchedulingProfiler"));
local markForceUpdateScheduled = SchedulingProfiler.markForceUpdateScheduled;
local markStateUpdateScheduled = SchedulingProfiler.markStateUpdateScheduled;
local u4 = {};
local __refs = react.Component:extend("").__refs;
local u5, u6, u7, u8, u9, u10, u11, u12, u13;

if _G___DEV__ then
    local u14 = {};
    u5 = {};
    u6 = {};
    u7 = {};
    u8 = {};
    u9 = {};
    u10 = {};

    u11 = function(p15, p16) -- Line: 153, Name: warnOnUndefinedDerivedState
    end;

    u12 = function(p17: any, p18: string) -- Line: 137, Name: warnOnInvalidCallback
        -- upvalues: u14 (copy), console (copy)
        if p17 == nil or type(p17) == "function" then
            return;
        end;

        local v19 = p18 .. "_" .. tostring(p17);

        if not u14[v19] then
            u14[v19] = true;
            console.error("%s(...): Expected the last optional `callback` argument to be a function. Instead received: %s.", p18, (tostring(p17)));
        end;
    end;

    u13 = {};
else
    u5 = nil;
    u6 = nil;
    u7 = nil;
    u8 = nil;
    u9 = nil;
    u10 = nil;
    u11 = nil;
    u12 = nil;
    u13 = nil;
end;

local function applyDerivedStateFromProps(p20: any, p21: any, p22: function, p23: any) -- Line: 196
    -- upvalues: _G___DEV__ (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), u11 (ref), Object (copy), NoLanes (copy)
    local memoizedState = p20.memoizedState;

    if _G___DEV__ and (debugRenderPhaseSideEffectsForStrictMode and bit32.band(p20.mode, StrictMode) ~= 0) then
        disableLogs();
        local v24, v25 = xpcall(p22, describeError, p23, memoizedState);
        reenableLogs();

        if not v24 then
            error(v25);
        end;
    end;

    local v26 = p22(p23, memoizedState);

    if _G___DEV__ then
        u11(p21, v26);
    end;

    if v26 ~= nil then
        memoizedState = Object.assign({}, memoizedState, v26);
    end;

    p20.memoizedState = memoizedState;

    if p20.lanes == NoLanes then
        p20.updateQueue.baseState = memoizedState;
    end;
end;

local u27 = nil;

local function initializeClassComponentUpdater() -- Line: 244
    -- upvalues: u27 (ref), isMounted (copy), get (copy), createUpdate (copy), _G___DEV__ (copy), u12 (ref), enqueueUpdate (copy), enableDebugTracing (copy), DebugTracingMode (copy), getComponentName (copy), logStateUpdateScheduled (copy), enableSchedulingProfiler (copy), markStateUpdateScheduled (copy), ReplaceState (copy), ForceUpdate (copy), logForceUpdateScheduled (copy), markForceUpdateScheduled (copy)
    local v28 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
    local requestEventTime = v28.requestEventTime;
    local requestUpdateLane = v28.requestUpdateLane;
    local scheduleUpdateOnFiber = v28.scheduleUpdateOnFiber;
    u27 = {
        isMounted = isMounted,

        enqueueSetState = function(p29: any, p30: any, p31: function?) -- Line: 252, Name: enqueueSetState
            -- upvalues: get (ref), requestEventTime (copy), requestUpdateLane (copy), createUpdate (ref), _G___DEV__ (ref), u12 (ref), enqueueUpdate (ref), scheduleUpdateOnFiber (copy), enableDebugTracing (ref), DebugTracingMode (ref), getComponentName (ref), logStateUpdateScheduled (ref), enableSchedulingProfiler (ref), markStateUpdateScheduled (ref)
            local v32 = get(p29);
            local v33 = requestEventTime();
            local v34 = requestUpdateLane(v32);
            local v35 = createUpdate(v33, v34, p30, p31);

            if p31 ~= nil and _G___DEV__ then
                u12(p31, "setState");
            end;

            enqueueUpdate(v32, v35);
            scheduleUpdateOnFiber(v32, v34, v33);

            if _G___DEV__ and (enableDebugTracing and bit32.band(v32.mode, DebugTracingMode) ~= 0) then
                logStateUpdateScheduled(getComponentName(v32.type) or "Unknown", v34, p30);
            end;

            if enableSchedulingProfiler then
                markStateUpdateScheduled(v32, v34);
            end;
        end,

        enqueueReplaceState = function(p36, p37, p38) -- Line: 282, Name: enqueueReplaceState
            -- upvalues: get (ref), requestEventTime (copy), requestUpdateLane (copy), createUpdate (ref), ReplaceState (ref), _G___DEV__ (ref), u12 (ref), enqueueUpdate (ref), scheduleUpdateOnFiber (copy), enableDebugTracing (ref), DebugTracingMode (ref), getComponentName (ref), logStateUpdateScheduled (ref), enableSchedulingProfiler (ref), markStateUpdateScheduled (ref)
            local v39 = get(p36);
            local v40 = requestEventTime();
            local v41 = requestUpdateLane(v39);
            local v42 = createUpdate(v40, v41, p37, p38);
            v42.tag = ReplaceState;

            if p38 ~= nil and _G___DEV__ then
                u12(p38, "replaceState");
            end;

            enqueueUpdate(v39, v42);
            scheduleUpdateOnFiber(v39, v41, v40);

            if _G___DEV__ and (enableDebugTracing and bit32.band(v39.mode, DebugTracingMode) ~= 0) then
                logStateUpdateScheduled(getComponentName(v39.type) or "Unknown", v41, p37);
            end;

            if enableSchedulingProfiler then
                markStateUpdateScheduled(v39, v41);
            end;
        end,

        enqueueForceUpdate = function(p43, p44) -- Line: 314, Name: enqueueForceUpdate
            -- upvalues: get (ref), requestEventTime (copy), requestUpdateLane (copy), createUpdate (ref), ForceUpdate (ref), _G___DEV__ (ref), u12 (ref), enqueueUpdate (ref), scheduleUpdateOnFiber (copy), enableDebugTracing (ref), DebugTracingMode (ref), getComponentName (ref), logForceUpdateScheduled (ref), enableSchedulingProfiler (ref), markForceUpdateScheduled (ref)
            local v45 = get(p43);
            local v46 = requestEventTime();
            local v47 = requestUpdateLane(v45);
            local v48 = createUpdate(v46, v47, nil, p44);
            v48.tag = ForceUpdate;

            if p44 ~= nil and _G___DEV__ then
                u12(p44, "forceUpdate");
            end;

            enqueueUpdate(v45, v48);
            scheduleUpdateOnFiber(v45, v47, v46);

            if _G___DEV__ and (enableDebugTracing and bit32.band(v45.mode, DebugTracingMode) ~= 0) then
                logForceUpdateScheduled(getComponentName(v45.type) or "Unknown", v47);
            end;

            if enableSchedulingProfiler then
                markForceUpdateScheduled(v45, v47);
            end;
        end
    };
end;

local function getClassComponentUpdater() -- Line: 348
    -- upvalues: u27 (ref), initializeClassComponentUpdater (copy)
    if u27 == nil then
        initializeClassComponentUpdater();
    end;

    return u27;
end;

function checkShouldComponentUpdate(p49, p50, p51, p52, p53, p54, p55)
    -- upvalues: _G___DEV__ (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), console (copy), getComponentName (copy), shallowEqual (copy)
    local stateNode = p49.stateNode;

    if stateNode.shouldComponentUpdate == nil or type(stateNode.shouldComponentUpdate) ~= "function" then
        return (type(p50) ~= "table" or not p50.isPureReactComponent) and true or not (shallowEqual(p51, p52) and shallowEqual(p53, p54));
    end;

    if _G___DEV__ and (debugRenderPhaseSideEffectsForStrictMode and bit32.band(p49.mode, StrictMode) ~= 0) then
        disableLogs();
        local v56, v57 = xpcall(stateNode.shouldComponentUpdate, describeError, stateNode, p52, p54, p55);
        reenableLogs();

        if not v56 then
            error(v57);
        end;
    end;

    local v58 = stateNode:shouldComponentUpdate(p52, p54, p55);

    if _G___DEV__ and v58 == nil then
        console.error("%s.shouldComponentUpdate(): Returned nil instead of a boolean value. Make sure to return true or false.", getComponentName(p50) or "Component");
    end;

    return v58;
end;

local function checkClassInstance(p59, p60, p61) -- Line: 420
    -- upvalues: _G___DEV__ (copy), getComponentName (copy), console (copy), disableLegacyContext (copy), u8 (ref), u13 (ref)
    local stateNode = p59.stateNode;

    if _G___DEV__ then
        local v62 = getComponentName(p60) or "Component";

        if not stateNode.render then
            if type(p60.render) == "function" then
                console.error("%s(...): No `render` method found on the returned component instance: did you accidentally return an object from the constructor?", v62);
            else
                console.error("%s(...): No `render` method found on the returned component instance: you may have forgotten to define `render`.", v62);
            end;
        end;

        if stateNode.getInitialState and not (stateNode.getInitialState.isReactClassApproved or stateNode.state) then
            console.error("getInitialState was defined on %s, a plain JavaScript class. This is only supported for classes created using React.createClass. Did you mean to define a state property instead?", v62);
        end;

        if stateNode.getDefaultProps and not stateNode.getDefaultProps.isReactClassApproved then
            console.error("getDefaultProps was defined on %s, a plain JavaScript class. This is only supported for classes created using React.createClass. Use a static property to define defaultProps instead.", v62);
        end;

        if stateNode.propTypes and not p60.propTypes then
            console.error("propTypes was defined as an instance property on %s. Use a static property to define propTypes instead.", v62);
        end;

        if stateNode.contextType and not p60.contextType then
            console.error("contextType was defined as an instance property on %s. Use a static property to define contextType instead.", v62);
        end;

        if disableLegacyContext then
            if p60.childContextTypes then
                console.error("%s uses the legacy childContextTypes API which is no longer supported. Use React.createContext() instead.", v62);
            end;

            if p60.contextTypes then
                console.error("%s uses the legacy contextTypes API which is no longer supported. Use React.createContext() with static contextType instead.", v62);
            end;
        else
            if stateNode.contextTypes and not p60.contextTypes then
                console.error("contextTypes was defined as an instance property on %s. Use a static property to define contextTypes instead.", v62);
            end;

            if type(p60) == "table" and (p60.contextType and (p60.contextTypes and not u8[p60])) then
                u8[p60] = true;
                console.error("%s declares both contextTypes and contextType static properties. The legacy contextTypes property will be ignored.", v62);
            end;
        end;

        if type(stateNode.componentShouldUpdate) == "function" then
            console.error("%s has a method called componentShouldUpdate(). Did you mean shouldComponentUpdate()? The name is phrased as a question because the function is expected to return a value.", v62);
        end;

        if type(p60) == "table" and (p60.isPureReactComponent and stateNode.shouldComponentUpdate ~= nil) then
            console.error("%s has a method called shouldComponentUpdate(). shouldComponentUpdate should not be used when extending React.PureComponent. Please extend React.Component if shouldComponentUpdate is used.", getComponentName(p60) or "A pure component");
        end;

        if type(stateNode.componentDidUnmount) == "function" then
            console.error("%s has a method called componentDidUnmount(). But there is no such lifecycle method. Did you mean componentWillUnmount()?", v62);
        end;

        if type(stateNode.componentDidReceiveProps) == "function" then
            console.error("%s has a method called componentDidReceiveProps(). But there is no such lifecycle method. If you meant to update the state in response to changing props, use componentWillReceiveProps(). If you meant to fetch data or run side-effects or mutations after React has updated the UI, use componentDidUpdate().", v62);
        end;

        if type(stateNode.componentWillRecieveProps) == "function" then
            console.error("%s has a method called componentWillRecieveProps(). Did you mean componentWillReceiveProps()?", v62);
        end;

        if type(stateNode.UNSAFE_componentWillRecieveProps) == "function" then
            console.error("%s has a method called UNSAFE_componentWillRecieveProps(). Did you mean UNSAFE_componentWillReceiveProps()?", v62);
        end;

        if stateNode.props ~= nil and stateNode.props ~= p61 then
            console.error("%s(...): When calling super() in `%s`, make sure to pass up the same props that your component\'s constructor was passed.", v62, v62);
        end;

        if rawget(stateNode, "defaultProps") then
            console.error("Setting defaultProps as an instance property on %s is not supported and will be ignored. Instead, define defaultProps as a static property on %s.", v62, v62);
        end;

        if type(stateNode.getSnapshotBeforeUpdate) == "function" and (type(stateNode.componentDidUpdate) ~= "function" and not u13[p60]) then
            u13[p60] = true;
            console.error("%s: getSnapshotBeforeUpdate() should be used with componentDidUpdate(). This component defines getSnapshotBeforeUpdate() only.", getComponentName(p60));
        end;

        local state = stateNode.state;

        if state ~= nil and type(state) ~= "table" then
            console.error("%s.state: must be set to an object or nil", v62);
        end;

        if type(p60) == "table" and (type(stateNode.getChildContext) == "function" and type(p60.childContextTypes) ~= "table") then
            console.error("%s.getChildContext(): childContextTypes must be defined in order to use getChildContext().", v62);
        end;
    end;
end;

local function adoptClassInstance(p63, p64) -- Line: 654
    -- upvalues: u27 (ref), initializeClassComponentUpdater (copy), set (copy), _G___DEV__ (copy), u4 (copy)
    if u27 == nil then
        initializeClassComponentUpdater();
    end;

    p64.__updater = u27;
    p63.stateNode = p64;
    set(p64, p63);

    if _G___DEV__ then
        p64._reactInternalInstance = u4;
    end;
end;

local function constructClassInstance(p65, p66, p67) -- Line: 665
    -- upvalues: emptyContextObject (copy), _G___DEV__ (copy), REACT_CONTEXT_TYPE (copy), u5 (ref), REACT_PROVIDER_TYPE (copy), console (copy), getComponentName (copy), readContext (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), u27 (ref), initializeClassComponentUpdater (copy), set (copy), u4 (copy), UninitializedState (copy), u6 (ref), u7 (ref), cacheContext (copy)
    local v68 = false;
    local v69 = emptyContextObject;
    local v70 = emptyContextObject;
    local contextType = p66.contextType;

    if _G___DEV__ and p66.contextType ~= nil then
        local v71;

        if contextType == nil then
            v71 = true;
        elseif contextType["$$typeof"] == REACT_CONTEXT_TYPE then
            v71 = contextType._context == nil;
        else
            v71 = false;
        end;

        if not (v71 or u5[p66]) then
            u5[p66] = true;
            local v72 = "";
            local v73;

            if contextType == nil then
                v73 = " However, it is set to nil. This can be caused by a typo or by mixing up named and default imports. This can also happen due to a circular dependency, so try moving the createContext() call to a separate file.";
            elseif type(contextType) == "table" then
                if contextType["$$typeof"] == REACT_PROVIDER_TYPE then
                    v73 = " Did you accidentally pass the Context.Provider instead?";
                elseif contextType._context == nil then
                    local v74 = v72 .. " However, it is set to an object with keys {";

                    for i, _ in contextType do
                        v74 = v74 .. i .. ", ";
                    end;

                    v73 = v74 .. "}.";
                else
                    v73 = " Did you accidentally pass the Context.Consumer instead?";
                end;
            else
                v73 = " However, it is set to a " .. type(contextType) .. ".";
            end;

            console.error("%s defines an invalid contextType. contextType should point to the Context object returned by React.createContext().%s", getComponentName(p66) or "Component", v73);
        end;
    end;

    if contextType == nil or type(contextType) ~= "table" then
        if not disableLegacyContext then
            v69 = getUnmaskedContext(p65, p66, true);
            v68 = p66.contextTypes ~= nil;
            v70 = v68 and getMaskedContext(p65, v69) or emptyContextObject;
        end;
    else
        v70 = readContext(contextType);
    end;

    if _G___DEV__ and (debugRenderPhaseSideEffectsForStrictMode and bit32.band(p65.mode, StrictMode) ~= 0) then
        disableLogs();
        local v75, v76 = xpcall(p66.__ctor, describeError, p67, v70);
        reenableLogs();

        if not v75 then
            error(v76);
        end;
    end;

    local v77 = p66.__ctor(p67, v70);
    p65.memoizedState = v77.state;
    local memoizedState = p65.memoizedState;

    if u27 == nil then
        initializeClassComponentUpdater();
    end;

    v77.__updater = u27;
    p65.stateNode = v77;
    set(v77, p65);

    if _G___DEV__ then
        v77._reactInternalInstance = u4;
    end;

    if _G___DEV__ then
        if type(p66.getDerivedStateFromProps) == "function" and memoizedState == UninitializedState then
            local v78 = getComponentName(p66) or "Component";

            if not u6[v78] then
                u6[v78] = true;
                console.error("`%s` uses `getDerivedStateFromProps` but its initial state has not been initialized. This is not recommended. Instead, define the initial state by passing an object to `self:setState` in the `init` method of `%s`. This ensures that `getDerivedStateFromProps` arguments have a consistent shape.", v78, v78);
            end;
        end;

        if type(p66.getDerivedStateFromProps) == "function" or type(v77.getSnapshotBeforeUpdate) == "function" then
            local v79 = type(v77.componentWillMount) == "function" and "componentWillMount" or (type(v77.UNSAFE_componentWillMount) == "function" and "UNSAFE_componentWillMount" or nil);
            local v80 = type(v77.componentWillReceiveProps) == "function" and "componentWillReceiveProps" or (type(v77.UNSAFE_componentWillReceiveProps) == "function" and "UNSAFE_componentWillReceiveProps" or nil);
            local v81 = type(v77.componentWillUpdate) == "function" and "componentWillUpdate" or (type(v77.UNSAFE_componentWillUpdate) == "function" and "UNSAFE_componentWillUpdate" or nil);

            if v79 ~= nil or (v80 ~= nil or v81 ~= nil) then
                local v82 = getComponentName(p66) or "Component";
                local v83 = type(p66.getDerivedStateFromProps) == "function" and "getDerivedStateFromProps()" or "getSnapshotBeforeUpdate()";
                local v84 = v79 == nil and "" or "\n  " .. tostring(v79);
                local v85 = v80 == nil and "" or "\n  " .. tostring(v80);
                local v86 = v81 == nil and "" or "\n  " .. tostring(v81);

                if not u7[v82] then
                    u7[v82] = true;
                    console.error("Unsafe legacy lifecycles will not be called for components using new component APIs.\n\n%s uses %s but also contains the following legacy lifecycles:%s%s%s\n\nThe above lifecycles should be removed. Learn more about this warning here:\nhttps://reactjs.org/link/unsafe-component-lifecycles", v82, v83, v84, v85, v86);
                end;
            end;
        end;
    end;

    if v68 then
        cacheContext(p65, v69, v70);
    end;

    return v77;
end;

local function callComponentWillMount(p87, p88) -- Line: 880
    -- upvalues: _G___DEV__ (copy), console (copy), getComponentName (copy), u27 (ref), initializeClassComponentUpdater (copy)
    local state = p88.state;

    if p88.componentWillMount ~= nil and type(p88.componentWillMount) == "function" then
        p88:componentWillMount();
    end;

    if p88.UNSAFE_componentWillMount ~= nil and type(p88.UNSAFE_componentWillMount) == "function" then
        p88:UNSAFE_componentWillMount();
    end;

    if state ~= p88.state then
        if _G___DEV__ then
            console.error("%s.componentWillMount(): Assigning directly to this.state is deprecated (except inside a component\'s constructor). Use setState instead.", getComponentName(p87.type) or "Component");
        end;

        if u27 == nil then
            initializeClassComponentUpdater();
        end;

        u27.enqueueReplaceState(p88, p88.state);
    end;
end;

function callComponentWillReceiveProps(p89, p90, p91, p92)
    -- upvalues: _G___DEV__ (copy), getComponentName (copy), u9 (ref), console (copy), u27 (ref), initializeClassComponentUpdater (copy)
    local state = p90.state;

    if p90.componentWillReceiveProps ~= nil and type(p90.componentWillReceiveProps) == "function" then
        p90:componentWillReceiveProps(p91, p92);
    end;

    if p90.UNSAFE_componentWillReceiveProps ~= nil and type(p90.UNSAFE_componentWillReceiveProps) == "function" then
        p90:UNSAFE_componentWillReceiveProps(p91, p92);
    end;

    if p90.state ~= state then
        if _G___DEV__ then
            local v93 = getComponentName(p89.type) or "Component";

            if not u9[v93] then
                u9[v93] = true;
                console.error("%s.componentWillReceiveProps(): Assigning directly to this.state is deprecated (except inside a component\'s constructor). Use setState instead.", v93);
            end;
        end;

        if u27 == nil then
            initializeClassComponentUpdater();
        end;

        u27.enqueueReplaceState(p90, p90.state);
    end;
end;

local function mountClassInstance(p94, p95, p96, p97) -- Line: 945
    -- upvalues: _G___DEV__ (copy), checkClassInstance (copy), __refs (copy), initializeUpdateQueue (copy), readContext (copy), disableLegacyContext (copy), emptyContextObject (copy), getUnmaskedContext (copy), getMaskedContext (copy), getComponentName (copy), u10 (ref), console (copy), StrictMode (copy), u2 (copy), warnAboutDeprecatedLifecycles (copy), processUpdateQueue (copy), applyDerivedStateFromProps (copy), callComponentWillMount (copy), enableDoubleInvokingEffects (copy), MountLayoutDev (copy), Update (copy)
    if _G___DEV__ then
        checkClassInstance(p94, p95, p96);
    end;

    local stateNode = p94.stateNode;
    stateNode.props = p96;
    stateNode.state = p94.memoizedState;
    stateNode.__refs = __refs;
    initializeUpdateQueue(p94);
    local v98;

    if type(p95) == "table" then
        v98 = p95.contextType;
    else
        v98 = nil;
    end;

    if v98 == nil or type(v98) ~= "table" then
        if disableLegacyContext then
            stateNode.context = emptyContextObject;
        else
            stateNode.context = getMaskedContext(p94, (getUnmaskedContext(p94, p95, true)));
        end;
    else
        stateNode.context = readContext(v98);
    end;

    if _G___DEV__ then
        if stateNode.state == p96 then
            local v99 = getComponentName(p95) or "Component";

            if not u10[v99] then
                u10[v99] = true;
                console.error("%s: It is not recommended to assign props directly to state because updates to props won\'t be reflected in state. In most cases, it is better to use props directly.", v99);
            end;
        end;

        if bit32.band(p94.mode, StrictMode) ~= 0 then
            u2.recordLegacyContextWarning(p94, stateNode);
        end;

        if warnAboutDeprecatedLifecycles then
            u2.recordUnsafeLifecycleWarnings(p94, stateNode);
        end;
    end;

    processUpdateQueue(p94, p96, stateNode, p97);
    stateNode.state = p94.memoizedState;
    local v100 = type(p95);
    local v101;

    if type(p95) == "table" then
        v101 = p95.getDerivedStateFromProps;
    else
        v101 = nil;
    end;

    if v101 ~= nil and type(v101) == "function" then
        applyDerivedStateFromProps(p94, p95, v101, p96);
        stateNode.state = p94.memoizedState;
    end;

    if v100 == "table" and (type(p95.getDerivedStateFromProps) ~= "function" and (type(stateNode.getSnapshotBeforeUpdate) ~= "function" and (type(stateNode.UNSAFE_componentWillMount) == "function" or type(stateNode.componentWillMount) == "function"))) then
        callComponentWillMount(p94, stateNode);
        processUpdateQueue(p94, p96, stateNode, p97);
        stateNode.state = p94.memoizedState;
    end;

    if type(stateNode.componentDidMount) == "function" then
        if _G___DEV__ and enableDoubleInvokingEffects then
            local flags = p94.flags;
            local bit32_bor_ret = bit32.bor(MountLayoutDev, Update);
            p94.flags = bit32.bor(flags, bit32_bor_ret);

            return;
        end;

        p94.flags = bit32.bor(p94.flags, Update);
    end;
end;

function resumeMountClassInstance(p102, p103, p104, p105)
    -- upvalues: emptyContextObject (copy), readContext (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), resetHasForceUpdateBeforeProcessing (copy), processUpdateQueue (copy), hasContextChanged (copy), checkHasForceUpdateAfterProcessing (copy), _G___DEV__ (copy), enableDoubleInvokingEffects (copy), MountLayoutDev (copy), Update (copy), applyDerivedStateFromProps (copy)
    local stateNode = p102.stateNode;
    local memoizedProps = p102.memoizedProps;
    stateNode.props = memoizedProps;
    local context = stateNode.context;
    local contextType = p103.contextType;
    local v106 = emptyContextObject;

    if contextType == nil or type(contextType) ~= "table" then
        if not disableLegacyContext then
            v106 = getMaskedContext(p102, (getUnmaskedContext(p102, p103, true)));
        end;
    else
        v106 = readContext(contextType);
    end;

    local getDerivedStateFromProps = p103.getDerivedStateFromProps;
    local v107 = type(getDerivedStateFromProps) == "function" and true or type(stateNode.getSnapshotBeforeUpdate) == "function";

    if not (v107 or type(stateNode.UNSAFE_componentWillReceiveProps) ~= "function" and type(stateNode.componentWillReceiveProps) ~= "function" or memoizedProps == p104 and context == v106) then
        callComponentWillReceiveProps(p102, stateNode, p104, v106);
    end;

    resetHasForceUpdateBeforeProcessing();
    local memoizedState = p102.memoizedState;
    stateNode.state = memoizedState;
    processUpdateQueue(p102, p104, stateNode, p105);
    local memoizedState2 = p102.memoizedState;

    if memoizedProps == p104 and (memoizedState == memoizedState2 and not (hasContextChanged() or checkHasForceUpdateAfterProcessing())) then
        if type(stateNode.componentDidMount) == "function" then
            if _G___DEV__ and enableDoubleInvokingEffects then
                p102.flags = bit32.bor(p102.flags, MountLayoutDev, Update);
            else
                p102.flags = bit32.bor(p102.flags, Update);
            end;
        end;

        return false;
    end;

    if getDerivedStateFromProps ~= nil and type(getDerivedStateFromProps) == "function" then
        applyDerivedStateFromProps(p102, p103, getDerivedStateFromProps, p104);
        memoizedState2 = p102.memoizedState;
    end;

    local v108 = checkHasForceUpdateAfterProcessing() or checkShouldComponentUpdate(p102, p103, memoizedProps, p104, memoizedState, memoizedState2, v106);

    if v108 then
        if not (v107 or type(stateNode.UNSAFE_componentWillMount) ~= "function" and type(stateNode.componentWillMount) ~= "function") then
            if type(stateNode.componentWillMount) == "function" then
                stateNode:componentWillMount();
            end;

            if type(stateNode.UNSAFE_componentWillMount) == "function" then
                stateNode:UNSAFE_componentWillMount();
            end;
        end;

        if type(stateNode.componentDidMount) == "function" then
            if _G___DEV__ and enableDoubleInvokingEffects then
                p102.flags = bit32.bor(p102.flags, MountLayoutDev, Update);
            else
                p102.flags = bit32.bor(p102.flags, Update);
            end;
        end;
    else
        if type(stateNode.componentDidMount) == "function" then
            if _G___DEV__ and enableDoubleInvokingEffects then
                p102.flags = bit32.bor(p102.flags, MountLayoutDev, Update);
            else
                p102.flags = bit32.bor(p102.flags, Update);
            end;
        end;

        p102.memoizedProps = p104;
        p102.memoizedState = memoizedState2;
    end;

    stateNode.props = p104;
    stateNode.state = memoizedState2;
    stateNode.context = v106;

    return v108;
end;

return {
    adoptClassInstance = adoptClassInstance,
    constructClassInstance = constructClassInstance,
    mountClassInstance = mountClassInstance,
    resumeMountClassInstance = resumeMountClassInstance,

    updateClassInstance = function(p109, p110, p111, p112, p113) -- Line: 1204, Name: updateClassInstance
        -- upvalues: cloneUpdateQueue (copy), resolveDefaultProps (copy), emptyContextObject (copy), readContext (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), resetHasForceUpdateBeforeProcessing (copy), processUpdateQueue (copy), hasContextChanged (copy), checkHasForceUpdateAfterProcessing (copy), Update (copy), Snapshot (copy), applyDerivedStateFromProps (copy)
        local stateNode = p110.stateNode;
        cloneUpdateQueue(p109, p110);
        local memoizedProps = p110.memoizedProps;
        local v114;

        if p110.type == p110.elementType then
            v114 = memoizedProps;
        else
            v114 = resolveDefaultProps(p110.type, memoizedProps);
        end;

        stateNode.props = v114;
        local pendingProps = p110.pendingProps;
        local context = stateNode.context;
        local v115, v116;

        if type(p111) == "table" then
            v115 = p111.contextType;
            v116 = p111.getDerivedStateFromProps;
        else
            v115 = nil;
            v116 = nil;
        end;

        local v117 = emptyContextObject;

        if type(v115) == "table" then
            v117 = readContext(v115);
        elseif not disableLegacyContext then
            v117 = getMaskedContext(p110, (getUnmaskedContext(p110, p111, true)));
        end;

        local v118;

        if v116 == nil or type(v116) ~= "function" then
            if stateNode.getSnapshotBeforeUpdate == nil then
                v118 = false;
            else
                v118 = type(stateNode.getSnapshotBeforeUpdate) == "function";
            end;
        else
            v118 = true;
        end;

        if not (v118 or (stateNode.UNSAFE_componentWillReceiveProps == nil or type(stateNode.UNSAFE_componentWillReceiveProps) ~= "function") and (stateNode.componentWillReceiveProps == nil or type(stateNode.componentWillReceiveProps) ~= "function") or memoizedProps == pendingProps and context == v117) then
            callComponentWillReceiveProps(p110, stateNode, p112, v117);
        end;

        resetHasForceUpdateBeforeProcessing();
        local memoizedState = p110.memoizedState;
        stateNode.state = memoizedState;
        local _ = stateNode.state;
        processUpdateQueue(p110, p112, stateNode, p113);
        local memoizedState2 = p110.memoizedState;

        if memoizedProps == pendingProps and (memoizedState == memoizedState2 and not (hasContextChanged() or checkHasForceUpdateAfterProcessing())) then
            if stateNode.componentDidUpdate ~= nil and (type(stateNode.componentDidUpdate) == "function" and (memoizedProps ~= p109.memoizedProps or memoizedState ~= p109.memoizedState)) then
                p110.flags = bit32.bor(p110.flags, Update);
            end;

            if stateNode.getSnapshotBeforeUpdate ~= nil and (type(stateNode.getSnapshotBeforeUpdate) == "function" and (memoizedProps ~= p109.memoizedProps or memoizedState ~= p109.memoizedState)) then
                p110.flags = bit32.bor(p110.flags, Snapshot);
            end;

            return false;
        end;

        if v116 ~= nil and type(v116) == "function" then
            applyDerivedStateFromProps(p110, p111, v116, p112);
            memoizedState2 = p110.memoizedState;
        end;

        local v119 = checkHasForceUpdateAfterProcessing() or checkShouldComponentUpdate(p110, p111, v114, p112, memoizedState, memoizedState2, v117);

        if v119 then
            if not (v118 or (stateNode.UNSAFE_componentWillUpdate == nil or type(stateNode.UNSAFE_componentWillUpdate) ~= "function") and (stateNode.componentWillUpdate == nil or type(stateNode.componentWillUpdate) ~= "function")) then
                if stateNode.componentWillUpdate ~= nil and type(stateNode.componentWillUpdate) == "function" then
                    stateNode:componentWillUpdate(p112, memoizedState2, v117);
                end;

                if stateNode.UNSAFE_componentWillUpdate ~= nil and type(stateNode.UNSAFE_componentWillUpdate) == "function" then
                    stateNode:UNSAFE_componentWillUpdate(p112, memoizedState2, v117);
                end;
            end;

            if stateNode.componentDidUpdate ~= nil and type(stateNode.componentDidUpdate) == "function" then
                p110.flags = bit32.bor(p110.flags, Update);
            end;

            if stateNode.getSnapshotBeforeUpdate ~= nil and type(stateNode.getSnapshotBeforeUpdate) == "function" then
                p110.flags = bit32.bor(p110.flags, Snapshot);
            end;
        else
            if stateNode.componentDidUpdate ~= nil and (type(stateNode.componentDidUpdate) == "function" and (memoizedProps ~= p109.memoizedProps or memoizedState ~= p109.memoizedState)) then
                p110.flags = bit32.bor(p110.flags, Update);
            end;

            if stateNode.getSnapshotBeforeUpdate ~= nil and (type(stateNode.getSnapshotBeforeUpdate) == "function" and (memoizedProps ~= p109.memoizedProps or memoizedState ~= p109.memoizedState)) then
                p110.flags = bit32.bor(p110.flags, Snapshot);
            end;

            p110.memoizedProps = p112;
            p110.memoizedState = memoizedState2;
        end;

        stateNode.props = p112;
        stateNode.state = memoizedState2;
        stateNode.context = v117;

        return v119;
    end,

    applyDerivedStateFromProps = applyDerivedStateFromProps,
    emptyRefsObject = __refs
};