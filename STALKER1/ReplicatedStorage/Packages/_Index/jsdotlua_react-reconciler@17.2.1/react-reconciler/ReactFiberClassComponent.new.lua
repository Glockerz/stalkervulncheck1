-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))
local v1 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"))

require(script.Parent.Parent:WaitForChild("shared"))

local react = require(script.Parent.Parent:WaitForChild("react"))
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local Update = ReactFiberFlags.Update
local Snapshot = ReactFiberFlags.Snapshot
local MountLayoutDev = ReactFiberFlags.MountLayoutDev
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
local debugRenderPhaseSideEffectsForStrictMode = ReactFeatureFlags.debugRenderPhaseSideEffectsForStrictMode
local disableLegacyContext = ReactFeatureFlags.disableLegacyContext
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler
local warnAboutDeprecatedLifecycles = ReactFeatureFlags.warnAboutDeprecatedLifecycles
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects
local v2 = require(script.Parent:WaitForChild("ReactStrictModeWarnings.new"))
local isMounted = require(script.Parent:WaitForChild("ReactFiberTreeReflection")).isMounted
local ReactInstanceMap = require(script.Parent.Parent:WaitForChild("shared")).ReactInstanceMap
local get = ReactInstanceMap.get
local set = ReactInstanceMap.set
local shallowEqual = require(script.Parent.Parent:WaitForChild("shared")).shallowEqual
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local UninitializedState = require(script.Parent.Parent:WaitForChild("shared")).UninitializedState
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE
local resolveDefaultProps = require(script.Parent:WaitForChild("ReactFiberLazyComponent.new")).resolveDefaultProps
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"))
local DebugTracingMode = ReactTypeOfMode.DebugTracingMode
local StrictMode = ReactTypeOfMode.StrictMode
local enqueueUpdate = v1.enqueueUpdate
local processUpdateQueue = v1.processUpdateQueue
local checkHasForceUpdateAfterProcessing = v1.checkHasForceUpdateAfterProcessing
local resetHasForceUpdateBeforeProcessing = v1.resetHasForceUpdateBeforeProcessing
local createUpdate = v1.createUpdate
local ReplaceState = v1.ReplaceState
local ForceUpdate = v1.ForceUpdate
local initializeUpdateQueue = v1.initializeUpdateQueue
local cloneUpdateQueue = v1.cloneUpdateQueue
local NoLanes = ReactFiberLane.NoLanes
local v3 = require(script.Parent:WaitForChild("ReactFiberContext.new"))
local cacheContext = v3.cacheContext
local getMaskedContext = v3.getMaskedContext
local getUnmaskedContext = v3.getUnmaskedContext
local hasContextChanged = v3.hasContextChanged
local emptyContextObject = v3.emptyContextObject
local readContext = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).readContext
local DebugTracing = require(script.Parent:WaitForChild("DebugTracing"))
local logForceUpdateScheduled = DebugTracing.logForceUpdateScheduled
local logStateUpdateScheduled = DebugTracing.logStateUpdateScheduled
local ConsolePatchingDev = require(script.Parent.Parent:WaitForChild("shared")).ConsolePatchingDev
local disableLogs = ConsolePatchingDev.disableLogs
local reenableLogs = ConsolePatchingDev.reenableLogs
local SchedulingProfiler = require(script.Parent:WaitForChild("SchedulingProfiler"))
local markForceUpdateScheduled = SchedulingProfiler.markForceUpdateScheduled
local markStateUpdateScheduled = SchedulingProfiler.markStateUpdateScheduled
local t = {}
local __refs = react.Component:extend("").__refs
local v4, v5, v6, v7, v8, v9, v10, v11, v12

if __DEV__ then
	local t2 = {}

	v4 = function(p1, p2) --[[ warnOnInvalidCallback | Line: 137 | Upvalues: t2 (copy), console (copy) ]]
		if p1 == nil or type(p1) == "function" then
			return
		end

		local v1 = p2 .. "_" .. tostring(p1)

		if t2[v1] then
			return
		end

		t2[v1] = true
		console.error("%s(...): Expected the last optional `callback` argument to be a function. Instead received: %s.", p2, (tostring(p1)))
	end
	v5 = function(p1, p2) --[[ warnOnUndefinedDerivedState | Line: 153 ]] end
	v6 = {}
	v7 = {}
	v8 = {}
	v9 = {}
	v10 = {}
	v11 = {}
	v12 = {}
else
	v6 = nil
	v4 = nil
	v7 = nil
	v8 = nil
	v5 = nil
	v9 = nil
	v10 = nil
	v11 = nil
	v12 = nil
end

local function applyDerivedStateFromProps(p1, p2, p3, p4) --[[ applyDerivedStateFromProps | Line: 196 | Upvalues: __DEV__ (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), v5 (ref), Object (copy), NoLanes (copy) ]]
	local memoizedState = p1.memoizedState

	if __DEV__ and debugRenderPhaseSideEffectsForStrictMode and bit32.band(p1.mode, StrictMode) ~= 0 then
		disableLogs()

		local ok, result = xpcall(p3, describeError, p4, memoizedState)

		reenableLogs()

		if not ok then
			error(result)
		end
	end

	local v2 = p3(p4, memoizedState)

	if __DEV__ then
		v5(p2, v2)
	end

	local v3 = if v2 == nil then memoizedState else Object.assign({}, memoizedState, v2)

	p1.memoizedState = v3

	if p1.lanes ~= NoLanes then
		return
	end

	p1.updateQueue.baseState = v3
end

local v13 = nil

local function initializeClassComponentUpdater() --[[ initializeClassComponentUpdater | Line: 244 | Upvalues: v13 (ref), isMounted (copy), get (copy), createUpdate (copy), __DEV__ (copy), v4 (ref), enqueueUpdate (copy), enableDebugTracing (copy), DebugTracingMode (copy), getComponentName (copy), logStateUpdateScheduled (copy), enableSchedulingProfiler (copy), markStateUpdateScheduled (copy), ReplaceState (copy), ForceUpdate (copy), logForceUpdateScheduled (copy), markForceUpdateScheduled (copy) ]]
	local v1 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
	local requestEventTime = v1.requestEventTime
	local requestUpdateLane = v1.requestUpdateLane
	local scheduleUpdateOnFiber = v1.scheduleUpdateOnFiber

	v13 = {
		isMounted = isMounted,
		enqueueSetState = function(p1, p2, p3) --[[ enqueueSetState | Line: 252 | Upvalues: get (ref), requestEventTime (copy), requestUpdateLane (copy), createUpdate (ref), __DEV__ (ref), v4 (ref), enqueueUpdate (ref), scheduleUpdateOnFiber (copy), enableDebugTracing (ref), DebugTracingMode (ref), getComponentName (ref), logStateUpdateScheduled (ref), enableSchedulingProfiler (ref), markStateUpdateScheduled (ref) ]]
			local v1 = get(p1)
			local v2 = requestEventTime()
			local v3 = requestUpdateLane(v1)
			local v42 = createUpdate(v2, v3, p2, p3)

			if p3 ~= nil and __DEV__ then
				v4(p3, "setState")
			end

			enqueueUpdate(v1, v42)
			scheduleUpdateOnFiber(v1, v3, v2)

			if __DEV__ and enableDebugTracing and bit32.band(v1.mode, DebugTracingMode) ~= 0 then
				logStateUpdateScheduled(getComponentName(v1.type) or "Unknown", v3, p2)
			end

			if not enableSchedulingProfiler then
				return
			end

			markStateUpdateScheduled(v1, v3)
		end,
		enqueueReplaceState = function(p1, p2, p3) --[[ enqueueReplaceState | Line: 282 | Upvalues: get (ref), requestEventTime (copy), requestUpdateLane (copy), createUpdate (ref), ReplaceState (ref), __DEV__ (ref), v4 (ref), enqueueUpdate (ref), scheduleUpdateOnFiber (copy), enableDebugTracing (ref), DebugTracingMode (ref), getComponentName (ref), logStateUpdateScheduled (ref), enableSchedulingProfiler (ref), markStateUpdateScheduled (ref) ]]
			local v1 = get(p1)
			local v2 = requestEventTime()
			local v3 = requestUpdateLane(v1)
			local v42 = createUpdate(v2, v3, p2, p3)

			v42.tag = ReplaceState

			if p3 ~= nil and __DEV__ then
				v4(p3, "replaceState")
			end

			enqueueUpdate(v1, v42)
			scheduleUpdateOnFiber(v1, v3, v2)

			if __DEV__ and enableDebugTracing and bit32.band(v1.mode, DebugTracingMode) ~= 0 then
				logStateUpdateScheduled(getComponentName(v1.type) or "Unknown", v3, p2)
			end

			if not enableSchedulingProfiler then
				return
			end

			markStateUpdateScheduled(v1, v3)
		end,
		enqueueForceUpdate = function(p1, p2) --[[ enqueueForceUpdate | Line: 314 | Upvalues: get (ref), requestEventTime (copy), requestUpdateLane (copy), createUpdate (ref), ForceUpdate (ref), __DEV__ (ref), v4 (ref), enqueueUpdate (ref), scheduleUpdateOnFiber (copy), enableDebugTracing (ref), DebugTracingMode (ref), getComponentName (ref), logForceUpdateScheduled (ref), enableSchedulingProfiler (ref), markForceUpdateScheduled (ref) ]]
			local v1 = get(p1)
			local v2 = requestEventTime()
			local v3 = requestUpdateLane(v1)
			local v42 = createUpdate(v2, v3, nil, p2)

			v42.tag = ForceUpdate

			if p2 ~= nil and __DEV__ then
				v4(p2, "forceUpdate")
			end

			enqueueUpdate(v1, v42)
			scheduleUpdateOnFiber(v1, v3, v2)

			if __DEV__ and enableDebugTracing and bit32.band(v1.mode, DebugTracingMode) ~= 0 then
				logForceUpdateScheduled(getComponentName(v1.type) or "Unknown", v3)
			end

			if not enableSchedulingProfiler then
				return
			end

			markForceUpdateScheduled(v1, v3)
		end
	}
end

local function getClassComponentUpdater() --[[ getClassComponentUpdater | Line: 348 | Upvalues: v13 (ref), initializeClassComponentUpdater (copy) ]]
	if v13 ~= nil then
		return v13
	end

	initializeClassComponentUpdater()

	return v13
end

function checkShouldComponentUpdate(p1, p2, p3, p4, p5, p6, p7) --[[ checkShouldComponentUpdate | Line: 355 | Upvalues: __DEV__ (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), console (copy), getComponentName (copy), shallowEqual (copy) ]]
	local stateNode = p1.stateNode

	if stateNode.shouldComponentUpdate ~= nil and type(stateNode.shouldComponentUpdate) == "function" then
		if __DEV__ and debugRenderPhaseSideEffectsForStrictMode and bit32.band(p1.mode, StrictMode) ~= 0 then
			disableLogs()

			local ok, result = xpcall(stateNode.shouldComponentUpdate, describeError, stateNode, p4, p6, p7)

			reenableLogs()

			if not ok then
				error(result)
			end
		end

		local v2 = stateNode:shouldComponentUpdate(p4, p6, p7)

		if __DEV__ and v2 == nil then
			console.error("%s.shouldComponentUpdate(): Returned nil instead of a boolean value. Make sure to return true or false.", getComponentName(p2) or "Component")
		end

		return v2
	end

	if type(p2) ~= "table" or not p2.isPureReactComponent then
		return true
	end

	return not shallowEqual(p3, p4) or not shallowEqual(p5, p6)
end

local function checkClassInstance(p1, p2, p3) --[[ checkClassInstance | Line: 420 | Upvalues: __DEV__ (copy), getComponentName (copy), console (copy), disableLegacyContext (copy), v6 (ref), v7 (ref) ]]
	local stateNode = p1.stateNode

	if not __DEV__ then
		return
	end

	local v1 = getComponentName(p2) or "Component"

	if not stateNode.render then
		if type(p2.render) == "function" then
			console.error("%s(...): No `render` method found on the returned component instance: did you accidentally return an object from the constructor?", v1)
		else
			console.error("%s(...): No `render` method found on the returned component instance: you may have forgotten to define `render`.", v1)
		end
	end

	if stateNode.getInitialState and not (stateNode.getInitialState.isReactClassApproved or stateNode.state) then
		console.error("getInitialState was defined on %s, a plain JavaScript class. This is only supported for classes created using React.createClass. Did you mean to define a state property instead?", v1)
	end

	if stateNode.getDefaultProps and not stateNode.getDefaultProps.isReactClassApproved then
		console.error("getDefaultProps was defined on %s, a plain JavaScript class. This is only supported for classes created using React.createClass. Use a static property to define defaultProps instead.", v1)
	end

	if stateNode.propTypes and not p2.propTypes then
		console.error("propTypes was defined as an instance property on %s. Use a static property to define propTypes instead.", v1)
	end

	if stateNode.contextType and not p2.contextType then
		console.error("contextType was defined as an instance property on %s. Use a static property to define contextType instead.", v1)
	end

	if disableLegacyContext then
		if p2.childContextTypes then
			console.error("%s uses the legacy childContextTypes API which is no longer supported. Use React.createContext() instead.", v1)
		end

		if p2.contextTypes then
			console.error("%s uses the legacy contextTypes API which is no longer supported. Use React.createContext() with static contextType instead.", v1)
		end
	else
		if stateNode.contextTypes and not p2.contextTypes then
			console.error("contextTypes was defined as an instance property on %s. Use a static property to define contextTypes instead.", v1)
		end

		if type(p2) == "table" and (p2.contextType and (p2.contextTypes and not v6[p2])) then
			v6[p2] = true
			console.error("%s declares both contextTypes and contextType static properties. The legacy contextTypes property will be ignored.", v1)
		end
	end

	if type(stateNode.componentShouldUpdate) == "function" then
		console.error("%s has a method called componentShouldUpdate(). Did you mean shouldComponentUpdate()? The name is phrased as a question because the function is expected to return a value.", v1)
	end

	if type(p2) == "table" and (p2.isPureReactComponent and stateNode.shouldComponentUpdate ~= nil) then
		console.error("%s has a method called shouldComponentUpdate(). shouldComponentUpdate should not be used when extending React.PureComponent. Please extend React.Component if shouldComponentUpdate is used.", getComponentName(p2) or "A pure component")
	end

	if type(stateNode.componentDidUnmount) == "function" then
		console.error("%s has a method called componentDidUnmount(). But there is no such lifecycle method. Did you mean componentWillUnmount()?", v1)
	end

	if type(stateNode.componentDidReceiveProps) == "function" then
		console.error("%s has a method called componentDidReceiveProps(). But there is no such lifecycle method. If you meant to update the state in response to changing props, use componentWillReceiveProps(). If you meant to fetch data or run side-effects or mutations after React has updated the UI, use componentDidUpdate().", v1)
	end

	if type(stateNode.componentWillRecieveProps) == "function" then
		console.error("%s has a method called componentWillRecieveProps(). Did you mean componentWillReceiveProps()?", v1)
	end

	if type(stateNode.UNSAFE_componentWillRecieveProps) == "function" then
		console.error("%s has a method called UNSAFE_componentWillRecieveProps(). Did you mean UNSAFE_componentWillReceiveProps()?", v1)
	end

	if stateNode.props ~= nil and (if stateNode.props == p3 then false else true) then
		console.error("%s(...): When calling super() in `%s`, make sure to pass up the same props that your component\'s constructor was passed.", v1, v1)
	end

	if rawget(stateNode, "defaultProps") then
		console.error("Setting defaultProps as an instance property on %s is not supported and will be ignored. Instead, define defaultProps as a static property on %s.", v1, v1)
	end

	if type(stateNode.getSnapshotBeforeUpdate) == "function" and (type(stateNode.componentDidUpdate) ~= "function" and not v7[p2]) then
		v7[p2] = true
		console.error("%s: getSnapshotBeforeUpdate() should be used with componentDidUpdate(). This component defines getSnapshotBeforeUpdate() only.", getComponentName(p2))
	end

	local state = stateNode.state

	if state ~= nil and type(state) ~= "table" then
		console.error("%s.state: must be set to an object or nil", v1)
	end

	if type(p2) ~= "table" then
		return
	end

	if type(stateNode.getChildContext) ~= "function" then
		return
	end

	if type(p2.childContextTypes) == "table" then
		return
	end

	console.error("%s.getChildContext(): childContextTypes must be defined in order to use getChildContext().", v1)
end

local function adoptClassInstance(p1, p2) --[[ adoptClassInstance | Line: 654 | Upvalues: v13 (ref), initializeClassComponentUpdater (copy), set (copy), __DEV__ (copy), t (copy) ]]
	if v13 == nil then
		initializeClassComponentUpdater()
	end

	p2.__updater = v13
	p1.stateNode = p2
	set(p2, p1)

	if not __DEV__ then
		return
	end

	p2._reactInternalInstance = t
end

local function constructClassInstance(p1, p2, p3) --[[ constructClassInstance | Line: 665 | Upvalues: emptyContextObject (copy), __DEV__ (copy), REACT_CONTEXT_TYPE (copy), v9 (ref), REACT_PROVIDER_TYPE (copy), console (copy), getComponentName (copy), readContext (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), describeError (copy), reenableLogs (copy), v13 (ref), initializeClassComponentUpdater (copy), set (copy), t (copy), UninitializedState (copy), v10 (ref), v11 (ref), cacheContext (copy) ]]
	local v1 = false
	local v2 = emptyContextObject
	local v3 = emptyContextObject
	local contextType = p2.contextType

	if __DEV__ and p2.contextType ~= nil and not ((if contextType == nil then true elseif contextType["$$typeof"] == REACT_CONTEXT_TYPE then if contextType._context == nil then true else false else false) or v9[p2]) then
		v9[p2] = true

		local v5 = ""
		local v6

		if contextType == nil then
			v6 = " However, it is set to nil. This can be caused by a typo or by mixing up named and default imports. This can also happen due to a circular dependency, so try moving the createContext() call to a separate file."
		elseif type(contextType) == "table" then
			if contextType["$$typeof"] == REACT_PROVIDER_TYPE then
				v6 = " Did you accidentally pass the Context.Provider instead?"
			elseif contextType._context == nil then
				local v7 = v5 .. " However, it is set to an object with keys {"

				for v8, v92 in contextType do
					v7 = v7 .. v8 .. ", "
				end

				v6 = v7 .. "}."
			else
				v6 = " Did you accidentally pass the Context.Consumer instead?"
			end
		else
			v6 = " However, it is set to a " .. type(contextType) .. "."
		end

		console.error("%s defines an invalid contextType. contextType should point to the Context object returned by React.createContext().%s", getComponentName(p2) or "Component", v6)
	end

	if contextType == nil or type(contextType) ~= "table" then
		if not disableLegacyContext then
			local v102 = getUnmaskedContext(p1, p2, true)

			v1 = p2.contextTypes ~= nil

			local v112

			v2 = v102
			v112 = v1 and getMaskedContext(p1, v102) or emptyContextObject
			v3 = v112
		end
	else
		v3 = readContext(contextType)
	end

	if __DEV__ and debugRenderPhaseSideEffectsForStrictMode and bit32.band(p1.mode, StrictMode) ~= 0 then
		disableLogs()

		local ok, result = xpcall(p2.__ctor, describeError, p3, v3)

		reenableLogs()

		if not ok then
			error(result)
		end
	end

	local v14 = p2.__ctor(p3, v3)

	p1.memoizedState = v14.state

	local memoizedState = p1.memoizedState

	if v13 == nil then
		initializeClassComponentUpdater()
	end

	v14.__updater = v13
	p1.stateNode = v14
	set(v14, p1)

	if __DEV__ then
		v14._reactInternalInstance = t
	end

	if __DEV__ then
		if type(p2.getDerivedStateFromProps) == "function" and memoizedState == UninitializedState then
			local v15 = getComponentName(p2) or "Component"

			if not v10[v15] then
				v10[v15] = true
				console.error("`%s` uses `getDerivedStateFromProps` but its initial state has not been initialized. This is not recommended. Instead, define the initial state by passing an object to `self:setState` in the `init` method of `%s`. This ensures that `getDerivedStateFromProps` arguments have a consistent shape.", v15, v15)
			end
		end

		if type(p2.getDerivedStateFromProps) == "function" or type(v14.getSnapshotBeforeUpdate) == "function" then
			local v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30

			v16 = nil
			v17 = nil
			v18 = nil
			v19 = v14.componentWillMount

			if type(v19) == "function" then
				v16 = "componentWillMount"
			else
				v20 = v14.UNSAFE_componentWillMount

				if type(v20) == "function" then
					v16 = "UNSAFE_componentWillMount"
				end
			end

			v21 = v14.componentWillReceiveProps

			if type(v21) == "function" then
				v17 = "componentWillReceiveProps"
			else
				v22 = v14.UNSAFE_componentWillReceiveProps

				if type(v22) == "function" then
					v17 = "UNSAFE_componentWillReceiveProps"
				end
			end

			v23 = v14.componentWillUpdate

			if type(v23) == "function" then
				v18 = "componentWillUpdate"
			else
				v24 = v14.UNSAFE_componentWillUpdate

				if type(v24) == "function" then
					v18 = "UNSAFE_componentWillUpdate"
				end
			end

			if v16 ~= nil or (v17 ~= nil or v18 ~= nil) then
				v25 = getComponentName(p2) or "Component"
				v26 = p2.getDerivedStateFromProps
				v27 = if type(v26) == "function" then "getDerivedStateFromProps()" else "getSnapshotBeforeUpdate()"
				v28 = if v16 == nil then "" else "\n  " .. tostring(v16)
				v29 = if v17 == nil then "" else "\n  " .. tostring(v17)
				v30 = if v18 == nil then "" else "\n  " .. tostring(v18)

				if not v11[v25] then
					v11[v25] = true
					console.error("Unsafe legacy lifecycles will not be called for components using new component APIs.\n\n%s uses %s but also contains the following legacy lifecycles:%s%s%s\n\nThe above lifecycles should be removed. Learn more about this warning here:\nhttps://reactjs.org/link/unsafe-component-lifecycles", v25, v27, v28, v29, v30)
				end
			end
		end
	end

	if not v1 then
		return v14
	end

	cacheContext(p1, v2, v3)

	return v14
end

local function callComponentWillMount(p1, p2) --[[ callComponentWillMount | Line: 880 | Upvalues: __DEV__ (copy), console (copy), getComponentName (copy), v13 (ref), initializeClassComponentUpdater (copy) ]]
	if p2.componentWillMount ~= nil and type(p2.componentWillMount) == "function" then
		p2:componentWillMount()
	end

	if p2.UNSAFE_componentWillMount ~= nil and type(p2.UNSAFE_componentWillMount) == "function" then
		p2:UNSAFE_componentWillMount()
	end

	if p2.state == p2.state then
		return
	end

	if __DEV__ then
		console.error("%s.componentWillMount(): Assigning directly to this.state is deprecated (except inside a component\'s constructor). Use setState instead.", getComponentName(p1.type) or "Component")
	end

	if v13 == nil then
		initializeClassComponentUpdater()
	end

	v13.enqueueReplaceState(p2, p2.state)
end

function callComponentWillReceiveProps(p1, p2, p3, p4) --[[ callComponentWillReceiveProps | Line: 910 | Upvalues: __DEV__ (copy), getComponentName (copy), v8 (ref), console (copy), v13 (ref), initializeClassComponentUpdater (copy) ]]
	if p2.componentWillReceiveProps ~= nil and type(p2.componentWillReceiveProps) == "function" then
		p2:componentWillReceiveProps(p3, p4)
	end

	if p2.UNSAFE_componentWillReceiveProps ~= nil and type(p2.UNSAFE_componentWillReceiveProps) == "function" then
		p2:UNSAFE_componentWillReceiveProps(p3, p4)
	end

	if p2.state == p2.state then
		return
	end

	if __DEV__ then
		local v1 = getComponentName(p1.type) or "Component"

		if not v8[v1] then
			v8[v1] = true
			console.error("%s.componentWillReceiveProps(): Assigning directly to this.state is deprecated (except inside a component\'s constructor). Use setState instead.", v1)
		end
	end

	if v13 == nil then
		initializeClassComponentUpdater()
	end

	v13.enqueueReplaceState(p2, p2.state)
end

local function mountClassInstance(p1, p2, p3, p4) --[[ mountClassInstance | Line: 945 | Upvalues: __DEV__ (copy), checkClassInstance (copy), __refs (copy), initializeUpdateQueue (copy), readContext (copy), disableLegacyContext (copy), emptyContextObject (copy), getUnmaskedContext (copy), getMaskedContext (copy), getComponentName (copy), v12 (ref), console (copy), StrictMode (copy), v2 (copy), warnAboutDeprecatedLifecycles (copy), processUpdateQueue (copy), applyDerivedStateFromProps (copy), callComponentWillMount (copy), enableDoubleInvokingEffects (copy), MountLayoutDev (copy), Update (copy) ]]
	if __DEV__ then
		checkClassInstance(p1, p2, p3)
	end

	local stateNode = p1.stateNode

	stateNode.props = p3
	stateNode.state = p1.memoizedState
	stateNode.__refs = __refs
	initializeUpdateQueue(p1)

	local v1 = if type(p2) == "table" then p2.contextType else nil

	if v1 == nil or type(v1) ~= "table" then
		if disableLegacyContext then
			stateNode.context = emptyContextObject
		else
			stateNode.context = getMaskedContext(p1, (getUnmaskedContext(p1, p2, true)))
		end
	else
		stateNode.context = readContext(v1)
	end

	if __DEV__ then
		if stateNode.state == p3 then
			local v22 = getComponentName(p2) or "Component"

			if not v12[v22] then
				v12[v22] = true
				console.error("%s: It is not recommended to assign props directly to state because updates to props won\'t be reflected in state. In most cases, it is better to use props directly.", v22)
			end
		end

		if bit32.band(p1.mode, StrictMode) ~= 0 then
			v2.recordLegacyContextWarning(p1, stateNode)
		end

		if warnAboutDeprecatedLifecycles then
			v2.recordUnsafeLifecycleWarnings(p1, stateNode)
		end
	end

	processUpdateQueue(p1, p3, stateNode, p4)
	stateNode.state = p1.memoizedState

	local v4 = type(p2)
	local v5 = if type(p2) == "table" then p2.getDerivedStateFromProps else nil

	if v5 ~= nil and type(v5) == "function" then
		applyDerivedStateFromProps(p1, p2, v5, p3)
		stateNode.state = p1.memoizedState
	end

	if v4 == "table" and (type(p2.getDerivedStateFromProps) ~= "function" and (type(stateNode.getSnapshotBeforeUpdate) ~= "function" and (type(stateNode.UNSAFE_componentWillMount) == "function" or type(stateNode.componentWillMount) == "function"))) then
		callComponentWillMount(p1, stateNode)
		processUpdateQueue(p1, p3, stateNode, p4)
		stateNode.state = p1.memoizedState
	end

	if type(stateNode.componentDidMount) ~= "function" then
		return
	end

	if __DEV__ and enableDoubleInvokingEffects then
		p1.flags = bit32.bor(p1.flags, (bit32.bor(MountLayoutDev, Update)))

		return
	end

	p1.flags = bit32.bor(p1.flags, Update)
end

function resumeMountClassInstance(p1, p2, p3, p4) --[[ resumeMountClassInstance | Line: 1056 | Upvalues: emptyContextObject (copy), readContext (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), resetHasForceUpdateBeforeProcessing (copy), processUpdateQueue (copy), hasContextChanged (copy), checkHasForceUpdateAfterProcessing (copy), __DEV__ (copy), enableDoubleInvokingEffects (copy), MountLayoutDev (copy), Update (copy), applyDerivedStateFromProps (copy) ]]
	local stateNode = p1.stateNode
	local memoizedProps = p1.memoizedProps

	stateNode.props = memoizedProps

	local context = stateNode.context
	local contextType = p2.contextType
	local v1 = emptyContextObject

	if contextType == nil or type(contextType) ~= "table" then
		if not disableLegacyContext then
			v1 = getMaskedContext(p1, (getUnmaskedContext(p1, p2, true)))
		end
	else
		v1 = readContext(contextType)
	end

	local getDerivedStateFromProps = p2.getDerivedStateFromProps
	local v4 = if type(getDerivedStateFromProps) == "function" then true elseif type(stateNode.getSnapshotBeforeUpdate) == "function" then true else false

	if not v4 and type(stateNode.UNSAFE_componentWillReceiveProps) == "function" then
		if memoizedProps ~= p3 or context ~= v1 then
			callComponentWillReceiveProps(p1, stateNode, p3, v1)
		end
	elseif not v4 and (type(stateNode.componentWillReceiveProps) == "function" and (memoizedProps ~= p3 or context ~= v1)) then
		callComponentWillReceiveProps(p1, stateNode, p3, v1)
	end

	resetHasForceUpdateBeforeProcessing()

	local memoizedState = p1.memoizedState

	stateNode.state = memoizedState
	processUpdateQueue(p1, p3, stateNode, p4)

	local memoizedState2 = p1.memoizedState

	if memoizedProps == p3 and (memoizedState == memoizedState2 and not (hasContextChanged() or checkHasForceUpdateAfterProcessing())) then
		if type(stateNode.componentDidMount) ~= "function" then
			return false
		end

		if __DEV__ and enableDoubleInvokingEffects then
			p1.flags = bit32.bor(p1.flags, MountLayoutDev, Update)
		else
			p1.flags = bit32.bor(p1.flags, Update)
		end

		return false
	end

	if getDerivedStateFromProps ~= nil and type(getDerivedStateFromProps) == "function" then
		applyDerivedStateFromProps(p1, p2, getDerivedStateFromProps, p3)
		memoizedState2 = p1.memoizedState
	end

	local v8 = checkHasForceUpdateAfterProcessing() or checkShouldComponentUpdate(p1, p2, memoizedProps, p3, memoizedState, memoizedState2, v1)

	if v8 then
		if not v4 and (type(stateNode.UNSAFE_componentWillMount) == "function" or type(stateNode.componentWillMount) == "function") then
			local v9, v10

			v9 = stateNode.componentWillMount

			if type(v9) == "function" then
				stateNode:componentWillMount()
			end

			v10 = stateNode.UNSAFE_componentWillMount

			if type(v10) == "function" then
				stateNode:UNSAFE_componentWillMount()
			end
		end

		if type(stateNode.componentDidMount) == "function" then
			if __DEV__ and enableDoubleInvokingEffects then
				p1.flags = bit32.bor(p1.flags, MountLayoutDev, Update)
			else
				p1.flags = bit32.bor(p1.flags, Update)
			end
		end
	else
		if type(stateNode.componentDidMount) == "function" then
			if __DEV__ and enableDoubleInvokingEffects then
				p1.flags = bit32.bor(p1.flags, MountLayoutDev, Update)
			else
				p1.flags = bit32.bor(p1.flags, Update)
			end
		end

		p1.memoizedProps = p3
		p1.memoizedState = memoizedState2
	end

	stateNode.props = p3
	stateNode.state = memoizedState2
	stateNode.context = v1

	return v8
end

local function updateClassInstance(p1, p2, p3, p4, p5) --[[ updateClassInstance | Line: 1204 | Upvalues: cloneUpdateQueue (copy), resolveDefaultProps (copy), emptyContextObject (copy), readContext (copy), disableLegacyContext (copy), getUnmaskedContext (copy), getMaskedContext (copy), resetHasForceUpdateBeforeProcessing (copy), processUpdateQueue (copy), hasContextChanged (copy), checkHasForceUpdateAfterProcessing (copy), Update (copy), Snapshot (copy), applyDerivedStateFromProps (copy) ]]
	local stateNode = p2.stateNode

	cloneUpdateQueue(p1, p2)

	local memoizedProps = p2.memoizedProps
	local v1 = if p2.type == p2.elementType then memoizedProps else resolveDefaultProps(p2.type, memoizedProps)

	stateNode.props = v1

	local pendingProps = p2.pendingProps
	local context = stateNode.context
	local v2, v3

	if type(p3) == "table" then
		v2 = p3.contextType
		v3 = p3.getDerivedStateFromProps
	else
		v2 = nil
		v3 = nil
	end

	local v4 = emptyContextObject

	if type(v2) == "table" then
		v4 = readContext(v2)
	elseif not disableLegacyContext then
		v4 = getMaskedContext(p2, (getUnmaskedContext(p2, p3, true)))
	end

	local v7 = if v3 == nil or type(v3) ~= "function" then if stateNode.getSnapshotBeforeUpdate == nil then false elseif type(stateNode.getSnapshotBeforeUpdate) == "function" then true else false else true

	if not v7 then
		local v8

		if stateNode.UNSAFE_componentWillReceiveProps == nil then
			if stateNode.componentWillReceiveProps ~= nil then
				v8 = stateNode.componentWillReceiveProps

				if type(v8) == "function" and (memoizedProps ~= pendingProps or context ~= v4) then
					callComponentWillReceiveProps(p2, stateNode, p4, v4)
				end
			end
		elseif type(stateNode.UNSAFE_componentWillReceiveProps) == "function" then
			if memoizedProps ~= pendingProps or context ~= v4 then
				callComponentWillReceiveProps(p2, stateNode, p4, v4)
			end
		elseif stateNode.componentWillReceiveProps ~= nil then
			v8 = stateNode.componentWillReceiveProps

			if type(v8) == "function" and (memoizedProps ~= pendingProps or context ~= v4) then
				callComponentWillReceiveProps(p2, stateNode, p4, v4)
			end
		end
	end

	resetHasForceUpdateBeforeProcessing()

	local memoizedState = p2.memoizedState

	stateNode.state = memoizedState

	local state = stateNode.state

	processUpdateQueue(p2, p4, stateNode, p5)

	local memoizedState2 = p2.memoizedState

	if memoizedProps == pendingProps and (memoizedState == memoizedState2 and not (hasContextChanged() or checkHasForceUpdateAfterProcessing())) then
		if stateNode.componentDidUpdate ~= nil and (type(stateNode.componentDidUpdate) == "function" and (memoizedProps ~= p1.memoizedProps or memoizedState ~= p1.memoizedState)) then
			p2.flags = bit32.bor(p2.flags, Update)
		end

		if stateNode.getSnapshotBeforeUpdate == nil then
			return false
		end

		if type(stateNode.getSnapshotBeforeUpdate) ~= "function" or memoizedProps == p1.memoizedProps and memoizedState == p1.memoizedState then
			return false
		end

		p2.flags = bit32.bor(p2.flags, Snapshot)

		return false
	end

	if v3 ~= nil and type(v3) == "function" then
		applyDerivedStateFromProps(p2, p3, v3, p4)
		memoizedState2 = p2.memoizedState
	end

	local v11 = checkHasForceUpdateAfterProcessing() or checkShouldComponentUpdate(p2, p3, v1, p4, memoizedState, memoizedState2, v4)

	if v11 then
		if not v7 then
			local v12, v13, v14

			if stateNode.UNSAFE_componentWillUpdate == nil then
				if stateNode.componentWillUpdate ~= nil then
					v12 = stateNode.componentWillUpdate

					if type(v12) == "function" then
						if stateNode.componentWillUpdate ~= nil then
							v13 = stateNode.componentWillUpdate

							if type(v13) == "function" then
								stateNode:componentWillUpdate(p4, memoizedState2, v4)
							end
						end

						if stateNode.UNSAFE_componentWillUpdate ~= nil then
							v14 = stateNode.UNSAFE_componentWillUpdate

							if type(v14) == "function" then
								stateNode:UNSAFE_componentWillUpdate(p4, memoizedState2, v4)
							end
						end
					end
				end
			elseif type(stateNode.UNSAFE_componentWillUpdate) == "function" then
				if stateNode.componentWillUpdate ~= nil then
					v13 = stateNode.componentWillUpdate

					if type(v13) == "function" then
						stateNode:componentWillUpdate(p4, memoizedState2, v4)
					end
				end

				if stateNode.UNSAFE_componentWillUpdate ~= nil then
					v14 = stateNode.UNSAFE_componentWillUpdate

					if type(v14) == "function" then
						stateNode:UNSAFE_componentWillUpdate(p4, memoizedState2, v4)
					end
				end
			elseif stateNode.componentWillUpdate ~= nil then
				v12 = stateNode.componentWillUpdate

				if type(v12) == "function" then
					if stateNode.componentWillUpdate ~= nil then
						v13 = stateNode.componentWillUpdate

						if type(v13) == "function" then
							stateNode:componentWillUpdate(p4, memoizedState2, v4)
						end
					end

					if stateNode.UNSAFE_componentWillUpdate ~= nil then
						v14 = stateNode.UNSAFE_componentWillUpdate

						if type(v14) == "function" then
							stateNode:UNSAFE_componentWillUpdate(p4, memoizedState2, v4)
						end
					end
				end
			end
		end

		if stateNode.componentDidUpdate ~= nil and type(stateNode.componentDidUpdate) == "function" then
			p2.flags = bit32.bor(p2.flags, Update)
		end

		if stateNode.getSnapshotBeforeUpdate ~= nil and type(stateNode.getSnapshotBeforeUpdate) == "function" then
			p2.flags = bit32.bor(p2.flags, Snapshot)
		end
	else
		if stateNode.componentDidUpdate ~= nil and (type(stateNode.componentDidUpdate) == "function" and (memoizedProps ~= p1.memoizedProps or memoizedState ~= p1.memoizedState)) then
			p2.flags = bit32.bor(p2.flags, Update)
		end

		if stateNode.getSnapshotBeforeUpdate ~= nil and (type(stateNode.getSnapshotBeforeUpdate) == "function" and (memoizedProps ~= p1.memoizedProps or memoizedState ~= p1.memoizedState)) then
			p2.flags = bit32.bor(p2.flags, Snapshot)
		end

		p2.memoizedProps = p4
		p2.memoizedState = memoizedState2
	end

	stateNode.props = p4
	stateNode.state = memoizedState2
	stateNode.context = v4

	return v11
end

return {
	adoptClassInstance = adoptClassInstance,
	constructClassInstance = constructClassInstance,
	mountClassInstance = mountClassInstance,
	resumeMountClassInstance = resumeMountClassInstance,
	updateClassInstance = updateClassInstance,
	applyDerivedStateFromProps = applyDerivedStateFromProps,
	emptyRefsObject = __refs
}