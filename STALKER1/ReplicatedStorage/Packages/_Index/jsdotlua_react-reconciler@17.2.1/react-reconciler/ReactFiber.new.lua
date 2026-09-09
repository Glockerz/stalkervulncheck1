-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Object = v1.Object
local Array = v1.Array
local inspect = v1.util.inspect
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactRootTags = require(script.Parent:WaitForChild("ReactRootTags"))
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"))
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))

require(script.Parent:WaitForChild("ReactFiberHostConfig"))
require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"))

local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local enableProfilerTimer = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableProfilerTimer
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local NoFlags = ReactFiberFlags.NoFlags
local Placement = ReactFiberFlags.Placement
local StaticMask = ReactFiberFlags.StaticMask
local ConcurrentRoot = ReactRootTags.ConcurrentRoot
local BlockingRoot = ReactRootTags.BlockingRoot
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local HostComponent = ReactWorkTags.HostComponent
local HostText = ReactWorkTags.HostText
local HostPortal = ReactWorkTags.HostPortal
local ForwardRef = ReactWorkTags.ForwardRef
local Fragment = ReactWorkTags.Fragment
local Mode = ReactWorkTags.Mode
local ContextProvider = ReactWorkTags.ContextProvider
local ContextConsumer = ReactWorkTags.ContextConsumer
local Profiler = ReactWorkTags.Profiler
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local DehydratedFragment = ReactWorkTags.DehydratedFragment
local FunctionComponent = ReactWorkTags.FunctionComponent
local MemoComponent = ReactWorkTags.MemoComponent
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local LazyComponent = ReactWorkTags.LazyComponent
local FundamentalComponent = ReactWorkTags.FundamentalComponent
local ScopeComponent = ReactWorkTags.ScopeComponent
local OffscreenComponent = ReactWorkTags.OffscreenComponent
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local isDevToolsPresent = require(script.Parent:WaitForChild("ReactFiberDevToolsHook.new")).isDevToolsPresent
local v2 = require(script.Parent:WaitForChild("ReactFiberHotReloading.new"))
local resolveClassForHotReloading = v2.resolveClassForHotReloading
local resolveFunctionForHotReloading = v2.resolveFunctionForHotReloading
local resolveForwardRefForHotReloading = v2.resolveForwardRefForHotReloading
local NoLanes = ReactFiberLane.NoLanes
local NoMode = ReactTypeOfMode.NoMode
local ConcurrentMode = ReactTypeOfMode.ConcurrentMode
local DebugTracingMode = ReactTypeOfMode.DebugTracingMode
local ProfileMode = ReactTypeOfMode.ProfileMode
local StrictMode = ReactTypeOfMode.StrictMode
local BlockingMode = ReactTypeOfMode.BlockingMode
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local REACT_DEBUG_TRACING_MODE_TYPE = ReactSymbols.REACT_DEBUG_TRACING_MODE_TYPE
local REACT_STRICT_MODE_TYPE = ReactSymbols.REACT_STRICT_MODE_TYPE
local REACT_PROFILER_TYPE = ReactSymbols.REACT_PROFILER_TYPE
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE
local REACT_OFFSCREEN_TYPE = ReactSymbols.REACT_OFFSCREEN_TYPE
local REACT_LEGACY_HIDDEN_TYPE = ReactSymbols.REACT_LEGACY_HIDDEN_TYPE
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = 1

local function createFiber(p1, p2, p3, p4, p5, p6, p7, p8) --[[ createFiber | Line: 164 | Upvalues: NoFlags (copy), NoLanes (copy), enableProfilerTimer (copy), __DEV__ (copy), v8 (ref) ]]
	local t = {
		index = 1,
		tag = p1,
		key = p3,
		elementType = p5,
		type = p6,
		stateNode = p7,
		pendingProps = p2,
		mode = p4,
		flags = NoFlags,
		subtreeFlags = NoFlags
	}

	t.lanes = if p8 then p8 else NoLanes
	t.childLanes = NoLanes

	if enableProfilerTimer then
		t.actualDuration = 0
		t.actualStartTime = -1
		t.selfBaseDuration = 0
		t.treeBaseDuration = 0
	end

	if __DEV__ then
		t._debugID = v8
		v8 = v8 + 1
		t._debugSource = nil
		t._debugOwner = nil
		t._debugNeedsRemount = false
		t._debugHookTypes = nil
	end

	return t
end

function _shouldConstruct(p1) --[[ _shouldConstruct | Line: 264 ]]
	return if type(p1) == "function" then false else p1.isReactComponent and true or false
end

local function isSimpleFunctionComponent(p1) --[[ isSimpleFunctionComponent | Line: 271 ]]
	return type(p1) == "function"
end

local function resolveLazyComponentTag(p1) --[[ resolveLazyComponentTag | Line: 279 | Upvalues: FunctionComponent (copy), ClassComponent (copy), REACT_FORWARD_REF_TYPE (copy), ForwardRef (copy), REACT_MEMO_TYPE (copy), MemoComponent (copy), IndeterminateComponent (copy) ]]
	local v1 = typeof(p1)

	if v1 == "function" then
		return FunctionComponent
	end

	if v1 ~= "table" then
		return IndeterminateComponent
	end

	if p1.isReactComponent then
		return ClassComponent
	end

	local v2 = p1["$$typeof"]

	if v2 == REACT_FORWARD_REF_TYPE then
		return ForwardRef
	end

	if v2 == REACT_MEMO_TYPE then
		return MemoComponent
	end

	return IndeterminateComponent
end

local function createWorkInProgress(p1, p2) --[[ createWorkInProgress | Line: 302 | Upvalues: createFiber (copy), __DEV__ (copy), NoFlags (copy), enableProfilerTimer (copy), StaticMask (copy), IndeterminateComponent (copy), FunctionComponent (copy), SimpleMemoComponent (copy), resolveFunctionForHotReloading (copy), ClassComponent (copy), resolveClassForHotReloading (copy), ForwardRef (copy), resolveForwardRefForHotReloading (copy) ]]
	local alternate = p1.alternate

	if alternate == nil then
		local v1 = createFiber(p1.tag, p2, p1.key, p1.mode, p1.elementType, p1.type, p1.stateNode)

		if __DEV__ then
			v1._debugID = p1._debugID
			v1._debugSource = p1._debugSource
			v1._debugOwner = p1._debugOwner
			v1._debugHookTypes = p1._debugHookTypes
		end

		alternate = v1
		v1.alternate = p1
		p1.alternate = v1
	else
		alternate.pendingProps = p2
		alternate.type = p1.type
		alternate.flags = NoFlags
		alternate.subtreeFlags = NoFlags
		alternate.deletions = nil

		if enableProfilerTimer then
			alternate.actualDuration = 0
			alternate.actualStartTime = -1
		end
	end

	alternate.flags = bit32.band(p1.flags, StaticMask)
	alternate.childLanes = p1.childLanes
	alternate.lanes = p1.lanes
	alternate.child = p1.child
	alternate.memoizedProps = p1.memoizedProps
	alternate.memoizedState = p1.memoizedState
	alternate.updateQueue = p1.updateQueue

	local dependencies = p1.dependencies

	if dependencies == nil then
		alternate.dependencies = nil
	else
		alternate.dependencies = {
			lanes = dependencies.lanes,
			firstContext = dependencies.firstContext
		}
	end

	alternate.sibling = p1.sibling
	alternate.index = p1.index
	alternate.ref = p1.ref

	if enableProfilerTimer then
		alternate.selfBaseDuration = p1.selfBaseDuration
		alternate.treeBaseDuration = p1.treeBaseDuration
	end

	if __DEV__ then
		alternate._debugNeedsRemount = p1._debugNeedsRemount

		if alternate.tag == IndeterminateComponent or (alternate.tag == FunctionComponent or alternate.tag == SimpleMemoComponent) then
			alternate.type = resolveFunctionForHotReloading(p1.type)

			return alternate
		end

		if alternate.tag == ClassComponent then
			alternate.type = resolveClassForHotReloading(p1.type)

			return alternate
		end

		if alternate.tag == ForwardRef then
			alternate.type = resolveForwardRefForHotReloading(p1.type)
		end
	end

	return alternate
end

local function resetWorkInProgress(p1, p2) --[[ resetWorkInProgress | Line: 406 | Upvalues: StaticMask (copy), Placement (copy), NoLanes (copy), NoFlags (copy), enableProfilerTimer (copy) ]]
	p1.flags = bit32.band(p1.flags, (bit32.bor(StaticMask, Placement)))

	local alternate = p1.alternate

	if alternate == nil then
		p1.childLanes = NoLanes
		p1.lanes = p2
		p1.child = nil
		p1.subtreeFlags = NoFlags
		p1.memoizedProps = nil
		p1.memoizedState = nil
		p1.updateQueue = nil
		p1.dependencies = nil
		p1.stateNode = nil

		if enableProfilerTimer then
			p1.selfBaseDuration = 0
			p1.treeBaseDuration = 0

			return p1
		end
	else
		p1.childLanes = alternate.childLanes
		p1.lanes = alternate.lanes
		p1.child = alternate.child
		p1.subtreeFlags = alternate.subtreeFlags
		p1.deletions = nil
		p1.memoizedProps = alternate.memoizedProps
		p1.memoizedState = alternate.memoizedState
		p1.updateQueue = alternate.updateQueue
		p1.type = alternate.type

		local dependencies = alternate.dependencies

		if dependencies == nil then
			p1.dependencies = nil
		else
			p1.dependencies = {
				lanes = dependencies.lanes,
				firstContext = dependencies.firstContext
			}
		end

		if enableProfilerTimer then
			p1.selfBaseDuration = alternate.selfBaseDuration
			p1.treeBaseDuration = alternate.treeBaseDuration
		end
	end

	return p1
end

local function createHostRootFiber(p1) --[[ createHostRootFiber | Line: 481 | Upvalues: ConcurrentRoot (copy), ConcurrentMode (copy), BlockingMode (copy), StrictMode (copy), BlockingRoot (copy), NoMode (copy), enableProfilerTimer (copy), isDevToolsPresent (copy), ProfileMode (copy), createFiber (copy), HostRoot (copy) ]]
	local v1 = if p1 == ConcurrentRoot then bit32.bor(ConcurrentMode, BlockingMode, StrictMode) elseif p1 == BlockingRoot then bit32.bor(BlockingMode, StrictMode) else NoMode

	if enableProfilerTimer and isDevToolsPresent() then
		v1 = bit32.bor(v1, ProfileMode)
	end

	return createFiber(HostRoot, nil, nil, v1)
end

local function createFiberFromTypeAndProps(p1, p2, p3, p4, p5, p6) --[[ createFiberFromTypeAndProps | Line: 502 | Upvalues: IndeterminateComponent (copy), __DEV__ (copy), resolveFunctionForHotReloading (copy), ClassComponent (copy), resolveClassForHotReloading (copy), HostComponent (copy), REACT_FRAGMENT_TYPE (copy), v4 (ref), REACT_DEBUG_TRACING_MODE_TYPE (copy), Mode (copy), DebugTracingMode (copy), REACT_STRICT_MODE_TYPE (copy), StrictMode (copy), REACT_PROFILER_TYPE (copy), v3 (ref), REACT_SUSPENSE_TYPE (copy), v5 (ref), REACT_OFFSCREEN_TYPE (copy), v6 (ref), REACT_LEGACY_HIDDEN_TYPE (copy), v7 (ref), REACT_PROVIDER_TYPE (copy), ContextProvider (copy), REACT_CONTEXT_TYPE (copy), ContextConsumer (copy), REACT_FORWARD_REF_TYPE (copy), ForwardRef (copy), resolveForwardRefForHotReloading (copy), REACT_MEMO_TYPE (copy), MemoComponent (copy), REACT_LAZY_TYPE (copy), LazyComponent (copy), Object (copy), inspect (copy), getComponentName (copy), Array (copy), REACT_ELEMENT_TYPE (copy), invariant (copy), createFiber (copy) ]]
	local v1 = IndeterminateComponent
	local v2 = type(p1)
	local v32

	if v2 == "function" then
		v32 = if __DEV__ then resolveFunctionForHotReloading(p1) else p1
	elseif v2 == "table" and p1.isReactComponent then
		v1 = ClassComponent
		v32 = if __DEV__ then resolveClassForHotReloading(p1) else p1
	elseif v2 == "string" then
		v1 = HostComponent
		v32 = p1
	else
		if p1 == REACT_FRAGMENT_TYPE then
			return v4(p3.children, p5, p6, p2)
		end

		if p1 == REACT_DEBUG_TRACING_MODE_TYPE then
			v1 = Mode
			p5, p1, v32 = bit32.bor(p5, DebugTracingMode), p1, p1
		elseif p1 == REACT_STRICT_MODE_TYPE then
			v1 = Mode
			p5, p1, v32 = bit32.bor(p5, StrictMode), p1, p1
		else
			if p1 == REACT_PROFILER_TYPE then
				return v3(p3, p5, p6, p2)
			end

			if p1 == REACT_SUSPENSE_TYPE then
				return v5(p3, p5, p6, p2)
			end

			if p1 == REACT_OFFSCREEN_TYPE then
				return v6(p3, p5, p6, p2)
			end

			if p1 == REACT_LEGACY_HIDDEN_TYPE then
				return v7(p3, p5, p6, p2)
			end

			local v10 = false
			local v11

			if v2 == "table" then
				v11 = p1["$$typeof"]

				if v11 == REACT_PROVIDER_TYPE then
					v1 = ContextProvider
					v10 = true
					v32 = p1
				elseif v11 == REACT_CONTEXT_TYPE then
					v1 = ContextConsumer
					v10 = true
					v32 = p1
				elseif v11 == REACT_FORWARD_REF_TYPE then
					v1 = ForwardRef
					v32 = if __DEV__ then resolveForwardRefForHotReloading(p1) else p1
					v10 = true
				elseif v11 == REACT_MEMO_TYPE then
					v1 = MemoComponent
					v10 = true
					v32 = p1
				elseif v11 == REACT_LAZY_TYPE then
					v1 = LazyComponent
					v10 = true
					v32 = nil
				else
					v32 = p1
				end
			else
				v11 = nil
				v32 = p1
			end

			if not v10 then
				local v13 = ""

				if __DEV__ then
					if p1 == nil or v2 == "table" and #Object.keys(p1) == 0 then
						v13 = v13 .. " You likely forgot to export your component from the file it\'s defined in, or you might have mixed up default and named imports."
					elseif p1 ~= nil and v2 == "table" then
						v13 = v13 .. "\n" .. inspect(p1)
					end

					local v14 = if p4 then getComponentName(p4.type) else nil

					if v14 == nil or v14 == "" then
						if p4 then
							v13 = v13 .. "\n" .. inspect(p4)
						end
					else
						v13 = v13 .. "\n\nCheck the render method of `" .. v14 .. "`."
					end
				end

				local v16

				if p1 == nil then
					v16 = "nil"
				elseif Array.isArray(p1) then
					v16 = "array"
				elseif v2 == "table" and v11 == REACT_ELEMENT_TYPE then
					v16, v13 = string.format("<%s />", getComponentName(p1.type) or "Unknown"), " Did you accidentally export a JSX literal or Element instead of a component?"
				else
					v16 = v2
				end

				invariant(false, "Element type is invalid: expected a string (for built-in components) or a class/function (for composite components) but got: %s.%s", v16, v13)
			end
		end
	end

	local v18 = createFiber(v1, p3, p2, p5, p1, v32, nil, p6)

	if __DEV__ then
		v18._debugOwner = p4
	end

	return v18
end

local function createFiberFromElement(p1, p2, p3) --[[ createFiberFromElement | Line: 656 | Upvalues: __DEV__ (copy), createFiberFromTypeAndProps (copy) ]]
	local v2 = createFiberFromTypeAndProps(p1.type, p1.key, p1.props, if __DEV__ then p1._owner else nil, p2, p3)

	if __DEV__ then
		v2._debugSource = p1._source
		v2._debugOwner = p1._owner
	end

	return v2
end

v4 = function(p1, p2, p3, p4) --[[ createFiberFromFragment | Line: 684 | Upvalues: createFiber (copy), Fragment (copy) ]]
	return createFiber(Fragment, p1, p4, p2, nil, nil, nil, p3)
end

local function createFiberFromFundamental(p1, p2, p3, p4, p5) --[[ createFiberFromFundamental | Line: 697 | Upvalues: createFiber (copy), FundamentalComponent (copy) ]]
	return createFiber(FundamentalComponent, p2, p5, p3, p1, p1, nil, p4)
end

local function createFiberFromScope(p1, p2, p3, p4, p5) --[[ createFiberFromScope | Line: 722 | Upvalues: createFiber (copy), ScopeComponent (copy) ]]
	return createFiber(ScopeComponent, p2, p5, p3, p1, p1, nil, p4)
end

v3 = function(p1, p2, p3, p4) --[[ createFiberFromProfiler | Line: 739 | Upvalues: __DEV__ (copy), console (copy), createFiber (copy), Profiler (copy), ProfileMode (copy), REACT_PROFILER_TYPE (copy), enableProfilerTimer (copy) ]]
	if __DEV__ and typeof(p1.id) ~= "string" then
		console.error("Profiler must specify an \"id\" as a prop")
	end

	return createFiber(Profiler, p1, p4, bit32.bor(p2, ProfileMode), REACT_PROFILER_TYPE, REACT_PROFILER_TYPE, if enableProfilerTimer then {
	effectDuration = 0,
	passiveEffectDuration = 0
} else nil, p3)
end
v5 = function(p1, p2, p3, p4) --[[ createFiberFromSuspense | Line: 783 | Upvalues: createFiber (copy), SuspenseComponent (copy), REACT_SUSPENSE_TYPE (copy) ]]
	return createFiber(SuspenseComponent, p1, p4, p2, REACT_SUSPENSE_TYPE, REACT_SUSPENSE_TYPE, nil, p3)
end

local function createFiberFromSuspenseList(p1, p2, p3, p4) --[[ createFiberFromSuspenseList | Line: 812 | Upvalues: createFiber (copy), SuspenseListComponent (copy), REACT_SUSPENSE_LIST_TYPE (copy), __DEV__ (copy) ]]
	return createFiber(SuspenseListComponent, p1, p4, p2, REACT_SUSPENSE_LIST_TYPE, if __DEV__ then REACT_SUSPENSE_LIST_TYPE else nil, nil, p3)
end

v6 = function(p1, p2, p3, p4) --[[ createFiberFromOffscreen | Line: 841 | Upvalues: createFiber (copy), OffscreenComponent (copy), REACT_OFFSCREEN_TYPE (copy), __DEV__ (copy) ]]
	return createFiber(OffscreenComponent, p1, p4, p2, REACT_OFFSCREEN_TYPE, if __DEV__ then REACT_OFFSCREEN_TYPE else nil, nil, p3)
end
v7 = function(p1, p2, p3, p4) --[[ createFiberFromLegacyHidden | Line: 870 | Upvalues: createFiber (copy), LegacyHiddenComponent (copy), REACT_LEGACY_HIDDEN_TYPE (copy), __DEV__ (copy) ]]
	return createFiber(LegacyHiddenComponent, p1, p4, p2, REACT_LEGACY_HIDDEN_TYPE, if __DEV__ then REACT_LEGACY_HIDDEN_TYPE else nil, nil, p3)
end

return {
	isSimpleFunctionComponent = isSimpleFunctionComponent,
	resolveLazyComponentTag = resolveLazyComponentTag,
	createWorkInProgress = createWorkInProgress,
	resetWorkInProgress = resetWorkInProgress,
	createHostRootFiber = createHostRootFiber,
	createFiberFromTypeAndProps = createFiberFromTypeAndProps,
	createFiberFromElement = createFiberFromElement,
	createFiberFromFragment = v4,
	createFiberFromFundamental = createFiberFromFundamental,
	createFiberFromSuspense = v5,
	createFiberFromSuspenseList = createFiberFromSuspenseList,
	createFiberFromOffscreen = v6,
	createFiberFromLegacyHidden = v7,
	createFiberFromText = function(p1, p2, p3) --[[ createFiberFromText | Line: 899 | Upvalues: createFiber (copy), HostText (copy) ]]
		return createFiber(HostText, p1, nil, p2, nil, nil, nil, p3)
	end,
	createFiberFromHostInstanceForDeletion = function() --[[ createFiberFromHostInstanceForDeletion | Line: 907 | Upvalues: createFiber (copy), HostComponent (copy), NoMode (copy) ]]
		return createFiber(HostComponent, nil, nil, NoMode, "DELETED", "DELETED")
	end,
	createFiberFromDehydratedFragment = function(p1) --[[ createFiberFromDehydratedFragment | Line: 917 | Upvalues: createFiber (copy), DehydratedFragment (copy), NoMode (copy) ]]
		return createFiber(DehydratedFragment, nil, nil, NoMode, nil, nil, p1)
	end,
	createFiberFromPortal = function(p1, p2, p3) --[[ createFiberFromPortal | Line: 926 | Upvalues: createFiber (copy), HostPortal (copy) ]]
		return createFiber(HostPortal, if p1.children == nil then {} else p1.children, p1.key, p2, nil, nil, {
			pendingChildren = nil,
			containerInfo = p1.containerInfo,
			implementation = p1.implementation
		}, p3)
	end,
	assignFiberPropertiesInDEV = function(p1, p2) --[[ assignFiberPropertiesInDEV | Line: 950 | Upvalues: createFiber (copy), IndeterminateComponent (copy), NoMode (copy), enableProfilerTimer (copy) ]]
		if p1 == nil then
			p1 = createFiber(IndeterminateComponent, nil, nil, NoMode)
		end

		p1.tag = p2.tag
		p1.key = p2.key
		p1.elementType = p2.elementType
		p1.type = p2.type
		p1.stateNode = p2.stateNode
		p1.return_ = p2.return_
		p1.child = p2.child
		p1.sibling = p2.sibling
		p1.index = p2.index
		p1.ref = p2.ref
		p1.pendingProps = p2.pendingProps
		p1.memoizedProps = p2.memoizedProps
		p1.updateQueue = p2.updateQueue
		p1.memoizedState = p2.memoizedState
		p1.dependencies = p2.dependencies
		p1.mode = p2.mode
		p1.flags = p2.flags
		p1.subtreeFlags = p2.subtreeFlags
		p1.deletions = p2.deletions
		p1.lanes = p2.lanes
		p1.childLanes = p2.childLanes
		p1.alternate = p2.alternate

		if enableProfilerTimer then
			p1.actualDuration = p2.actualDuration
			p1.actualStartTime = p2.actualStartTime
			p1.selfBaseDuration = p2.selfBaseDuration
			p1.treeBaseDuration = p2.treeBaseDuration
		end

		p1._debugID = p2._debugID
		p1._debugSource = p2._debugSource
		p1._debugOwner = p2._debugOwner
		p1._debugNeedsRemount = p2._debugNeedsRemount
		p1._debugHookTypes = p2._debugHookTypes

		return p1
	end
}