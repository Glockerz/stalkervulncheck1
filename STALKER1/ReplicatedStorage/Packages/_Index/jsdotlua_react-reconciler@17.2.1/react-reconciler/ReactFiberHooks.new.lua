-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function unimplemented(p1) --[[ unimplemented | Line: 12 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. p1)
	error("FIXME (roblox): " .. p1 .. " is unimplemented")
end

local __DEV__ = _G.__DEV__
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Array = v1.Array
local Error = v1.Error
local Object = v1.Object
local createRef = require(script.Parent.Parent:WaitForChild("react")).createRef
local createBinding = require(script.Parent.Parent:WaitForChild("react")).createBinding
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))
local ReactHookEffectTags = require(script.Parent:WaitForChild("ReactHookEffectTags"))
local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler
local enableNewReconciler = ReactFeatureFlags.enableNewReconciler
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects
local DebugTracingMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).DebugTracingMode
local NoLane = ReactFiberLane.NoLane
local NoLanes = ReactFiberLane.NoLanes
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes
local mergeLanes = ReactFiberLane.mergeLanes
local removeLanes = ReactFiberLane.removeLanes
local markRootEntangled = ReactFiberLane.markRootEntangled
local markRootMutableRead = ReactFiberLane.markRootMutableRead
local readContext = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).readContext
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local Update = ReactFiberFlags.Update
local Passive = ReactFiberFlags.Passive
local PassiveStatic = ReactFiberFlags.PassiveStatic
local MountLayoutDev = ReactFiberFlags.MountLayoutDev
local MountPassiveDev = ReactFiberFlags.MountPassiveDev
local HasEffect = ReactHookEffectTags.HasEffect
local Layout = ReactHookEffectTags.Layout
local Passive2 = ReactHookEffectTags.Passive
local v2 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
local warnIfNotCurrentlyActingUpdatesInDEV = v2.warnIfNotCurrentlyActingUpdatesInDEV
local scheduleUpdateOnFiber = v2.scheduleUpdateOnFiber
local warnIfNotScopedWithMatchingAct = v2.warnIfNotScopedWithMatchingAct
local requestEventTime = v2.requestEventTime
local requestUpdateLane = v2.requestUpdateLane
local markSkippedUpdateLanes = v2.markSkippedUpdateLanes
local getWorkInProgressRoot = v2.getWorkInProgressRoot
local warnIfNotCurrentlyActingEffectsInDEV = v2.warnIfNotCurrentlyActingEffectsInDEV
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName

local function is(p1, p2) --[[ is | Line: 114 ]]
	return if p1 == p2 and (p1 ~= 0 or 1 / p1 == 1 / p2) then true elseif p1 == p1 then false else p2 ~= p2
end

local markWorkInProgressReceivedUpdate = require(script.Parent:WaitForChild("ReactFiberBeginWork.new")).markWorkInProgressReceivedUpdate
local getIsHydrating = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new")).getIsHydrating
local makeClientId = require(script.Parent:WaitForChild("ReactFiberHostConfig")).makeClientId
local v3 = require(script.Parent:WaitForChild("ReactMutableSource.new"))
local warnAboutMultipleRenderersDEV = v3.warnAboutMultipleRenderersDEV
local getWorkInProgressVersion = v3.getWorkInProgressVersion
local setWorkInProgressVersion = v3.setWorkInProgressVersion
local markSourceAsDirty = v3.markSourceAsDirty
local logStateUpdateScheduled = require(script.Parent:WaitForChild("DebugTracing")).logStateUpdateScheduled
local markStateUpdateScheduled = require(script.Parent:WaitForChild("SchedulingProfiler")).markStateUpdateScheduled
local ReactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher
local v4 = if __DEV__ then {} else nil
local t = {}
local v5 = NoLanes
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = false
local v10 = false
local v11 = nil
local v12 = nil
local v13 = 0
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil

local function getHighestIndex(p1) --[[ getHighestIndex | Line: 256 ]]
	local v1 = 0

	for v2, v3 in p1 do
		if v1 < v2 then
			v1 = v2
		end
	end

	return v1
end

local function isArrayOrSparseArray(p1) --[[ isArrayOrSparseArray | Line: 266 ]]
	if type(p1) ~= "table" then
		return false
	end

	for v1, v2 in p1 do
		if type(v1) ~= "number" then
			return false
		end
	end

	return true
end

local function mountHookTypesDev() --[[ mountHookTypesDev | Line: 278 | Upvalues: __DEV__ (copy), v11 (ref), v12 (ref) ]]
	if not __DEV__ then
		return
	end

	local v1 = v11

	if v12 == nil then
		v12 = { v1 }

		return
	end

	table.insert(v12, v1)
end

function updateHookTypesDev() --[[ updateHookTypesDev | Line: 291 | Upvalues: __DEV__ (copy), v11 (ref), v12 (ref), v13 (ref) ]]
	if not __DEV__ then
		return
	end

	local v1 = v11

	if v12 == nil then
		return
	end

	v13 = v13 + 1

	if v12[v13] == v1 then
		return
	end

	warnOnHookMismatchInDev(v1)
end

local function checkDepsAreArrayDev(p1) --[[ checkDepsAreArrayDev | Line: 305 | Upvalues: __DEV__ (copy), console (copy), v11 (ref) ]]
	if not __DEV__ or p1 == nil then
		return
	end

	local v1

	if type(p1) == "table" then
		v1 = true

		for v2, v3 in p1 do
			if type(v2) ~= "number" then
				v1 = false

				break
			end
		end
	else
		v1 = false
	end

	if v1 then
		return
	end

	console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", v11, (type(p1)))
end

function warnOnHookMismatchInDev(p1) --[[ warnOnHookMismatchInDev | Line: 320 | Upvalues: __DEV__ (copy), getComponentName (copy), v6 (ref), v4 (ref), v12 (ref), v13 (ref), console (copy) ]]
	if not __DEV__ then
		return
	end

	local v1 = getComponentName(v6.type) or "Component"

	if v4[v1] then
		return
	end

	v4[v1] = true

	if v12 == nil then
		return
	end

	local v2 = ""

	for i = 1, v13 do
		local v3 = v12[i]
		local v5 = tostring(i) .. ". " .. (v3 or "undefined")

		while string.len(v5) < 30 do
			v5 = v5 .. " "
		end

		v2 = v2 .. v5 .. (if i == v13 then p1 else v3) .. "\n"
	end

	console.error("React has detected a change in the order of Hooks called by %s. This will lead to bugs and errors if not fixed. For more information, read the Rules of Hooks: https://reactjs.org/link/rules-of-hooks\n\n   Previous render            Next render\n   ------------------------------------------------------\n%s   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n", v1, v2)
end

local function throwInvalidHookError() --[[ throwInvalidHookError | Line: 372 | Upvalues: Error (copy) ]]
	error(Error.new("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem."))
end

local function areHookInputsEqual(p1, p2) --[[ areHookInputsEqual | Line: 387 | Upvalues: __DEV__ (copy), console (copy), v11 (ref) ]]
	if p2 == nil then
		if not __DEV__ then
			return false
		end

		console.error("%s received a final argument during this render, but not during the previous render. Even though the final argument is optional, its type cannot change between renders.", v11)

		return false
	end

	local v1 = 0

	for v2, v3 in p1 do
		if v1 < v2 then
			v1 = v2
		end
	end

	v4 = 0
	v5 = v1

	for v6, v7 in p2 do
		if v4 < v6 then
			v4 = v6
		end
	end

	if v1 ~= v4 then
		return false
	end

	for i = 1, math.min(v4, v1) do
		local v8
		local v9 = p1[i]
		local v10 = p2[i]

		v8 = if v9 == v10 and (v9 ~= 0 or 1 / v9 == 1 / v10) then true elseif v9 == v9 then false elseif v10 == v10 then false else true

		if not v8 then
			return false
		end
	end

	return true
end

function t.bailoutHooks(p1, p2, p3) --[[ Line: 451 | Upvalues: __DEV__ (copy), enableDoubleInvokingEffects (copy), MountPassiveDev (copy), Passive (copy), MountLayoutDev (copy), Update (copy), removeLanes (copy) ]]
	p2.updateQueue = p1.updateQueue

	if __DEV__ and enableDoubleInvokingEffects then
		p2.flags = bit32.band(p2.flags, (bit32.bnot((bit32.bor(MountPassiveDev, Passive, MountLayoutDev, Update)))))
	else
		p2.flags = bit32.band(p2.flags, (bit32.bnot((bit32.bor(Passive, Update)))))
	end

	p1.lanes = removeLanes(p1.lanes, p3)
end

local v21 = false

function t.resetHooksAfterThrow() --[[ Line: 476 | Upvalues: ReactCurrentDispatcher (copy), t (copy), v9 (ref), v6 (ref), v5 (ref), NoLanes (copy), v7 (ref), v8 (ref), __DEV__ (copy), v12 (ref), v13 (ref), v11 (ref), v21 (ref), v10 (ref) ]]
	ReactCurrentDispatcher.current = t.ContextOnlyDispatcher

	if v9 then
		local memoizedState = v6.memoizedState

		while memoizedState ~= nil do
			local queue = memoizedState.queue

			if queue ~= nil then
				queue.pending = nil
			end

			memoizedState = memoizedState.next
		end

		v9 = false
	end

	v5 = NoLanes
	v6 = nil
	v7 = nil
	v8 = nil

	if __DEV__ then
		v12 = nil
		v13 = 0
		v11 = nil
		v21 = false
	end

	v10 = false
end

local function mountWorkInProgressHook() --[[ mountWorkInProgressHook | Line: 521 | Upvalues: v8 (ref), v6 (ref) ]]
	local t = {
		memoizedState = nil,
		baseState = nil,
		baseQueue = nil,
		queue = nil,
		next = nil
	}

	if v8 == nil then
		v6.memoizedState = t
	else
		v8.next = t
	end

	v8 = t

	return t
end

local function updateWorkInProgressHook() --[[ updateWorkInProgressHook | Line: 544 | Upvalues: v7 (ref), v6 (ref), v8 (ref), Error (copy) ]]
	local v1

	if v7 == nil then
		local alternate = v6.alternate

		v1 = if alternate == nil then nil else alternate.memoizedState
	else
		v1 = v7.next
	end

	local v2 = if v8 == nil then v6.memoizedState else v8.next

	v7 = v1

	if v2 == nil then
		if v1 == nil then
			error(Error.new("Rendered more hooks than during the previous render."))
		end

		local t = {
			next = nil,
			memoizedState = v1.memoizedState,
			baseState = v1.baseState,
			baseQueue = v1.baseQueue,
			queue = v1.queue
		}

		if v8 == nil then
			v8 = t
			v6.memoizedState = t
		else
			v8.next = t
			v8 = t
		end
	else
		v8 = v2

		local _ = v2.next
	end

	return v8
end

function basicStateReducer(p1, p2) --[[ basicStateReducer | Line: 619 ]]
	if type(p2) == "function" then
		return p2(p1)
	end

	return p2
end
function mountReducer(p1, p2, p3) --[[ mountReducer | Line: 628 | Upvalues: v8 (ref), v6 (ref) ]]
	local t = {
		memoizedState = nil,
		baseState = nil,
		baseQueue = nil,
		queue = nil,
		next = nil
	}

	if v8 == nil then
		v6.memoizedState = t
	else
		v8.next = t
	end

	v8 = t

	local v1 = t
	local v2 = if p3 == nil then p2 else p3(p2)

	v1.baseState = v2
	v1.memoizedState = v1.baseState

	local t2 = {
		pending = nil,
		dispatch = nil,
		lastRenderedReducer = p1,
		lastRenderedState = v2
	}

	v1.queue = t2

	local v4 = v6

	local function f5(p1, ...) --[[ Line: 655 | Upvalues: v4 (copy), t2 (copy) ]]
		dispatchAction(v4, t2, p1, ...)
	end

	t2.dispatch = f5

	return v1.memoizedState, f5
end
function updateReducer(p1, p2, p3) --[[ updateReducer | Line: 665 | Upvalues: updateWorkInProgressHook (copy), v7 (ref), v5 (ref), v6 (ref), mergeLanes (copy), markSkippedUpdateLanes (copy), NoLane (copy), markWorkInProgressReceivedUpdate (copy) ]]
	local v1 = updateWorkInProgressHook()
	local queue = v1.queue

	assert(if queue == nil then false else true, "Should have a queue. This is likely a bug in React. Please file an issue.")
	queue.lastRenderedReducer = p1

	local v3 = v7
	local baseQueue = v3.baseQueue
	local pending = queue.pending

	if pending ~= nil then
		if baseQueue ~= nil then
			local v4 = baseQueue.next

			baseQueue.next = pending.next
			pending.next = v4
		end

		v3.baseQueue = pending
		queue.pending = nil
		baseQueue = pending
	end

	if baseQueue ~= nil then
		local v52 = baseQueue.next
		local baseState = v3.baseState

		v62 = v52
		v72 = nil
		v8 = nil
		v9 = nil

		repeat
			local lane = v62.lane

			if bit32.band(v5, lane) == lane then
				if v72 ~= nil then
					v72.next = {
						next = nil,
						lane = NoLane,
						action = v62.action,
						eagerReducer = v62.eagerReducer,
						eagerState = v62.eagerState
					}
					v72 = v72.next
				end

				baseState = if v62.eagerReducer == p1 then v62.eagerState else p1(baseState, v62.action)
			else
				local t = {
					next = nil,
					lane = lane,
					action = v62.action,
					eagerReducer = v62.eagerReducer,
					eagerState = v62.eagerState
				}

				if v72 == nil then
					v8 = t
					v9 = baseState
					v72 = t
				else
					v72.next = t
					v72 = v72.next
				end

				v6.lanes = mergeLanes(v6.lanes, lane)
				markSkippedUpdateLanes(lane)
			end

			v62 = v62.next
		until v62 == nil or v62 == v52

		if v72 == nil then
			v9 = baseState
		else
			v72.next = v8
		end

		local memoizedState = v1.memoizedState
		local v12

		if baseState == memoizedState and (baseState ~= 0 or 1 / baseState == 1 / memoizedState) then
			v12 = true
		else
			local v13 = baseState

			v12 = if v13 == v13 then false elseif memoizedState == memoizedState then false else true
		end

		if not v12 then
			markWorkInProgressReceivedUpdate()
		end

		v1.memoizedState = baseState
		v1.baseState = v9
		v1.baseQueue = v72
		queue.lastRenderedState = baseState
	end

	return v1.memoizedState, queue.dispatch
end
function rerenderReducer(p1, p2, p3) --[[ rerenderReducer | Line: 806 | Upvalues: updateWorkInProgressHook (copy), markWorkInProgressReceivedUpdate (copy) ]]
	local v1 = updateWorkInProgressHook()
	local queue = v1.queue

	assert(if queue == nil then false else true, "Should have a queue. This is likely a bug in React. Please file an issue.")
	queue.lastRenderedReducer = p1

	local dispatch = queue.dispatch
	local pending = queue.pending
	local memoizedState = v1.memoizedState

	if pending ~= nil then
		queue.pending = nil

		local v3 = pending.next
		local v4 = v3
		local v5

		while true do
			v5 = p1(memoizedState, v4.action)
			v4 = v4.next

			if v4 == v3 then
				break
			end

			memoizedState = v5
		end

		local memoizedState2 = v1.memoizedState
		local v6

		if v5 == memoizedState2 and (v5 ~= 0 or 1 / v5 == 1 / memoizedState2) then
			v6 = true
			memoizedState = v5
		elseif v5 == v5 or memoizedState2 == memoizedState2 then
			v6 = false
			memoizedState = v5
		else
			v6 = true
			memoizedState = v5
		end

		if not v6 then
			markWorkInProgressReceivedUpdate()
		end

		v1.memoizedState = memoizedState

		if v1.baseQueue == nil then
			v1.baseState = memoizedState
		end

		queue.lastRenderedState = memoizedState
	end

	return memoizedState, dispatch
end
function readFromUnsubcribedMutableSource(p1, p2, p3) --[[ readFromUnsubcribedMutableSource | Line: 871 | Upvalues: __DEV__ (copy), warnAboutMultipleRenderersDEV (copy), getWorkInProgressVersion (copy), isSubsetOfLanes (copy), v5 (ref), setWorkInProgressVersion (copy), console (copy), markSourceAsDirty (copy), Error (copy) ]]
	if __DEV__ then
		warnAboutMultipleRenderersDEV(p2)
	end

	local v1 = p2._getVersion(p2._source)
	local v2 = getWorkInProgressVersion(p2)
	local v3

	if v2 == nil then
		local v4 = isSubsetOfLanes(v5, p1.mutableReadLanes)

		if v4 then
			setWorkInProgressVersion(p2, v1)
		end

		v3 = v4
	else
		v3 = v2 == v1
	end

	if not v3 then
		markSourceAsDirty(p2)
		error(Error.new("Cannot read from mutable source during the current render without tearing. This is a bug in React. Please file an issue."))
	end

	local v52 = p3(p2._source)

	if __DEV__ and type(v52) == "function" then
		console.error("Mutable source should not return a function as the snapshot value. Functions may close over mutable values and cause tearing.")
	end

	return v52
end
function useMutableSource(p1, p2, p3, p4) --[[ useMutableSource | Line: 954 | Upvalues: getWorkInProgressRoot (copy), invariant (copy), ReactCurrentDispatcher (copy), v8 (ref), v6 (ref), __DEV__ (copy), console (copy), requestUpdateLane (copy), markRootMutableRead (copy), markRootEntangled (copy) ]]
	local v1 = getWorkInProgressRoot()

	invariant(if v1 == nil then false else true, "Expected a work-in-progress root. This is a bug in React. Please file an issue.")

	local _getVersion = p2._getVersion
	local v4 = _getVersion(p2._source)
	local current = ReactCurrentDispatcher.current

	assert(if current == nil then false else true, "dispatcher was nil, this is a bug in React")

	local v62, v7 = current.useState(function() --[[ Line: 979 | Upvalues: v1 (copy), p2 (copy), p3 (copy) ]]
		return readFromUnsubcribedMutableSource(v1, p2, p3)
	end)
	local v82 = v62
	local v9 = v8
	local memoizedState = p1.memoizedState

	if memoizedState.refs == nil then
		local v10 = error

		v10((tostring(debug.traceback())))
	end

	local refs = memoizedState.refs
	local getSnapshot = refs.getSnapshot
	local source = memoizedState.source
	local subscribe = memoizedState.subscribe
	local v11 = v6

	p1.memoizedState = {
		refs = refs,
		source = p2,
		subscribe = p4
	}
	current.useEffect(function() --[[ Line: 1008 | Upvalues: refs (copy), p3 (copy), v7 (ref), _getVersion (copy), p2 (copy), v4 (copy), __DEV__ (ref), console (ref), v82 (ref), requestUpdateLane (ref), v11 (copy), markRootMutableRead (ref), v1 (copy), markRootEntangled (ref) ]]
		refs.getSnapshot = p3
		refs.setSnapshot = v7

		local v12 = _getVersion(p2._source)
		local v2 = v4

		if if v2 == v12 and (v2 ~= 0 or 1 / v2 == 1 / v12) then true elseif v2 == v2 then false else v12 ~= v12 then
			return
		end

		local v42 = p3(p2._source)

		if __DEV__ and type(v42) == "function" then
			console.error("Mutable source should not return a function as the snapshot value. Functions may close over mutable values and cause tearing.")
		end

		local v5 = v82

		if not (if v5 == v42 and (v5 ~= 0 or 1 / v5 == 1 / v42) then true elseif v5 == v5 then false elseif v42 == v42 then false else true) then
			v7(v42)
			markRootMutableRead(v1, (requestUpdateLane(v11)))
		end

		markRootEntangled(v1, v1.mutableReadLanes)
	end, { p3, p2, p4 })
	current.useEffect(function() --[[ Line: 1046 | Upvalues: refs (copy), p2 (copy), requestUpdateLane (ref), v11 (copy), markRootMutableRead (ref), v1 (copy), p4 (copy), __DEV__ (ref), console (ref) ]]
		local function f1() --[[ Line: 1047 | Upvalues: refs (ref), p2 (ref), requestUpdateLane (ref), v11 (ref), markRootMutableRead (ref), v1 (ref) ]]
			local getSnapshot = refs.getSnapshot
			local setSnapshot = refs.setSnapshot
			local ok, result = pcall(function() --[[ Line: 1052 | Upvalues: setSnapshot (copy), getSnapshot (copy), p2 (ref), requestUpdateLane (ref), v11 (ref), markRootMutableRead (ref), v1 (ref) ]]
				setSnapshot(getSnapshot(p2._source))
				markRootMutableRead(v1, (requestUpdateLane(v11)))
			end)

			if ok then
				return
			end

			setSnapshot(function() --[[ Line: 1066 | Upvalues: result (copy) ]]
				error(result)
			end)
		end

		local v2 = p4(p2._source, f1)

		if __DEV__ and type(v2) ~= "function" then
			console.error("Mutable source subscribe function must return an unsubscribe function.")
		end

		return v2
	end, { p2, p4 })

	local v13, v14, v15

	if (if getSnapshot == p3 and (getSnapshot ~= 0 or 1 / getSnapshot == 1 / p3) then true elseif getSnapshot == getSnapshot then false elseif p3 == p3 then false else true) and (if source == p2 and (source ~= 0 or 1 / source == 1 / p2) then true elseif source == source then false elseif p2 == p2 then false else true) then
		if not (if subscribe == p4 and (subscribe ~= 0 or 1 / subscribe == 1 / p4) then true elseif subscribe == subscribe then false elseif p4 == p4 then false else true) then
			v13 = {
				pending = nil,
				dispatch = nil,
				lastRenderedReducer = basicStateReducer,
				lastRenderedState = v82
			}
			v14 = v6
			v15 = function(...) --[[ Line: 1115 | Upvalues: v14 (copy), v13 (copy) ]]
				dispatchAction(v14, v13, ...)
			end
			v13.dispatch = v15
			v9.queue = v13
			v9.baseQueue = nil
			v82 = readFromUnsubcribedMutableSource(v1, p2, p3)
			v9.baseState = v82
			v9.memoizedState = v9.baseState
		end
	else
		v13 = {
			pending = nil,
			dispatch = nil,
			lastRenderedReducer = basicStateReducer,
			lastRenderedState = v82
		}
		v14 = v6
		v15 = function(...) --[[ Line: 1115 | Upvalues: v14 (copy), v13 (copy) ]]
			dispatchAction(v14, v13, ...)
		end
		v13.dispatch = v15
		v9.queue = v13
		v9.baseQueue = nil
		v82 = readFromUnsubcribedMutableSource(v1, p2, p3)
		v9.baseState = v82
		v9.memoizedState = v9.baseState
	end

	return v82
end
function mountMutableSource(p1, p2, p3) --[[ mountMutableSource | Line: 1129 | Upvalues: v8 (ref), v6 (ref) ]]
	local t = {
		memoizedState = nil,
		baseState = nil,
		baseQueue = nil,
		queue = nil,
		next = nil
	}

	if v8 == nil then
		v6.memoizedState = t
	else
		v8.next = t
	end

	v8 = t

	local v1 = t

	v1.memoizedState = {
		refs = {
			setSnapshot = nil,
			getSnapshot = p2
		},
		source = p1,
		subscribe = p3
	}

	return useMutableSource(v1, p1, p2, p3)
end
function updateMutableSource(p1, p2, p3) --[[ updateMutableSource | Line: 1152 | Upvalues: updateWorkInProgressHook (copy) ]]
	return useMutableSource(updateWorkInProgressHook(), p1, p2, p3)
end
function mountState(p1) --[[ mountState | Line: 1167 | Upvalues: v8 (ref), v6 (ref) ]]
	local t = {
		memoizedState = nil,
		baseState = nil,
		baseQueue = nil,
		queue = nil,
		next = nil
	}

	if v8 == nil then
		v6.memoizedState = t
	else
		v8.next = t
	end

	v8 = t

	local v1 = t

	if type(p1) == "function" then
		p1 = p1()
	end

	v1.baseState = p1
	v1.memoizedState = v1.baseState

	local t2 = {
		pending = nil,
		dispatch = nil,
		lastRenderedReducer = nil,
		lastRenderedState = p1,
		lastRenderedReducer = basicStateReducer
	}

	v1.queue = t2

	local v3 = v6

	local function f4(p1, ...) --[[ Line: 1189 | Upvalues: v3 (copy), t2 (copy) ]]
		dispatchAction(v3, t2, p1, ...)
	end

	t2.dispatch = f4

	return v1.memoizedState, f4
end
function updateState(p1) --[[ updateState | Line: 1198 ]]
	return updateReducer(basicStateReducer, p1)
end
function rerenderState(p1) --[[ rerenderState | Line: 1202 ]]
	return rerenderReducer(basicStateReducer, p1)
end

local function pushEffect(p1, p2, p3, p4) --[[ pushEffect | Line: 1206 | Upvalues: v6 (ref) ]]
	local t = {
		next = nil,
		tag = p1,
		create = p2,
		destroy = p3,
		deps = p4
	}
	local updateQueue = v6.updateQueue

	if updateQueue == nil then
		local t2 = {
			lastEffect = nil
		}

		v6.updateQueue = t2
		t.next = t
		t2.lastEffect = t

		return t
	end

	local lastEffect = updateQueue.lastEffect

	if lastEffect == nil then
		updateQueue.lastEffect = t
		t.next = t
	else
		local v1 = lastEffect.next

		lastEffect.next = t
		t.next = v1
		updateQueue.lastEffect = t
	end

	return t
end

function mountBinding(p1) --[[ mountBinding | Line: 1242 | Upvalues: v8 (ref), v6 (ref), createBinding (copy) ]]
	local t = {
		memoizedState = nil,
		baseState = nil,
		baseQueue = nil,
		queue = nil,
		next = nil
	}

	if v8 == nil then
		v6.memoizedState = t
	else
		v8.next = t
	end

	v8 = t

	local v2, v3 = createBinding(p1)

	t.memoizedState = { v2, v3 }

	return v2, v3
end
function updateBinding(p1) --[[ updateBinding | Line: 1251 | Upvalues: updateWorkInProgressHook (copy) ]]
	local memoizedState = updateWorkInProgressHook().memoizedState

	return unpack(memoizedState)
end
function mountRef(p1) --[[ mountRef | Line: 1256 | Upvalues: v8 (ref), v6 (ref), createRef (copy) ]]
	local t = {
		memoizedState = nil,
		baseState = nil,
		baseQueue = nil,
		queue = nil,
		next = nil
	}

	if v8 == nil then
		v6.memoizedState = t
	else
		v8.next = t
	end

	v8 = t

	local v2 = createRef()

	v2.current = p1
	t.memoizedState = v2

	return v2
end
function updateRef(p1) --[[ updateRef | Line: 1268 | Upvalues: updateWorkInProgressHook (copy) ]]
	return updateWorkInProgressHook().memoizedState
end

local function mountEffectImpl(p1, p2, p3, p4) --[[ mountEffectImpl | Line: 1273 | Upvalues: v8 (ref), v6 (ref), pushEffect (copy), HasEffect (copy) ]]
	local t = {
		memoizedState = nil,
		baseState = nil,
		baseQueue = nil,
		queue = nil,
		next = nil
	}

	if v8 == nil then
		v6.memoizedState = t
	else
		v8.next = t
	end

	v8 = t
	v6.flags = bit32.bor(v6.flags, p1)
	t.memoizedState = pushEffect(bit32.bor(HasEffect, p2), p3, nil, p4)
end

function updateEffectImpl(p1, p2, p3, p4) --[[ updateEffectImpl | Line: 1285 | Upvalues: updateWorkInProgressHook (copy), v7 (ref), areHookInputsEqual (copy), pushEffect (copy), v6 (ref), HasEffect (copy) ]]
	local v1 = updateWorkInProgressHook()
	local v2

	if v7 == nil then
		v2 = nil
	else
		local memoizedState = v7.memoizedState

		v2 = memoizedState.destroy

		if p4 ~= nil and areHookInputsEqual(p4, memoizedState.deps) then
			v1.memoizedState = pushEffect(p2, p3, v2, p4)

			return
		end
	end

	v6.flags = bit32.bor(v6.flags, p1)
	v1.memoizedState = pushEffect(bit32.bor(HasEffect, p2), p3, v2, p4)
end

local function mountEffect(p1, p2) --[[ mountEffect | Line: 1311 | Upvalues: __DEV__ (copy), warnIfNotCurrentlyActingEffectsInDEV (copy), v6 (ref), enableDoubleInvokingEffects (copy), MountPassiveDev (copy), Passive (copy), PassiveStatic (copy), Passive2 (copy), v8 (ref), pushEffect (copy), HasEffect (copy) ]]
	if __DEV__ and (type(_G.jest) ~= "nil" or _G.__TESTEZ_RUNNING_TEST__) then
		warnIfNotCurrentlyActingEffectsInDEV(v6)
	end

	if __DEV__ and enableDoubleInvokingEffects then
		local v4 = bit32.bor(MountPassiveDev, Passive, PassiveStatic)
		local t = {
			memoizedState = nil,
			baseState = nil,
			baseQueue = nil,
			queue = nil,
			next = nil
		}

		if v8 == nil then
			v6.memoizedState = t
		else
			v8.next = t
		end

		v8 = t
		v6.flags = bit32.bor(v6.flags, v4)
		t.memoizedState = pushEffect(bit32.bor(HasEffect, Passive2), p1, nil, p2)
	else
		local v11 = bit32.bor(Passive, PassiveStatic)
		local t = {
			memoizedState = nil,
			baseState = nil,
			baseQueue = nil,
			queue = nil,
			next = nil
		}

		if v8 == nil then
			v6.memoizedState = t
		else
			v8.next = t
		end

		v8 = t
		v6.flags = bit32.bor(v6.flags, v11)
		t.memoizedState = pushEffect(bit32.bor(HasEffect, Passive2), p1, nil, p2)
	end
end

local function updateEffect(p1, p2) --[[ updateEffect | Line: 1341 | Upvalues: __DEV__ (copy), warnIfNotCurrentlyActingEffectsInDEV (copy), v6 (ref), Passive (copy), Passive2 (copy) ]]
	if __DEV__ and (type(_G.jest) ~= "nil" or _G.__TESTEZ_RUNNING_TEST__) then
		warnIfNotCurrentlyActingEffectsInDEV(v6)
	end

	updateEffectImpl(Passive, Passive2, p1, p2)
end

local function mountLayoutEffect(p1, p2) --[[ mountLayoutEffect | Line: 1356 | Upvalues: __DEV__ (copy), enableDoubleInvokingEffects (copy), MountLayoutDev (copy), Update (copy), Layout (copy), v8 (ref), v6 (ref), pushEffect (copy), HasEffect (copy) ]]
	if __DEV__ and enableDoubleInvokingEffects then
		local v3 = bit32.bor(MountLayoutDev, Update)
		local t = {
			memoizedState = nil,
			baseState = nil,
			baseQueue = nil,
			queue = nil,
			next = nil
		}

		if v8 == nil then
			v6.memoizedState = t
		else
			v8.next = t
		end

		v8 = t
		v6.flags = bit32.bor(v6.flags, v3)
		t.memoizedState = pushEffect(bit32.bor(HasEffect, Layout), p1, nil, p2)
	else
		local t = {
			memoizedState = nil,
			baseState = nil,
			baseQueue = nil,
			queue = nil,
			next = nil
		}

		if v8 == nil then
			v6.memoizedState = t
		else
			v8.next = t
		end

		v8 = t
		v6.flags = bit32.bor(v6.flags, Update)
		t.memoizedState = pushEffect(bit32.bor(HasEffect, Layout), p1, nil, p2)
	end
end

local function updateLayoutEffect(p1, p2) --[[ updateLayoutEffect | Line: 1373 | Upvalues: Update (copy), Layout (copy) ]]
	updateEffectImpl(Update, Layout, p1, p2)
end

function imperativeHandleEffect(p1, p2) --[[ imperativeHandleEffect | Line: 1381 | Upvalues: __DEV__ (copy), Object (copy), console (copy), Array (copy) ]]
	if p2 ~= nil and type(p2) == "function" then
		p2((p1()))

		return function() --[[ Line: 1390 | Upvalues: p2 (copy) ]]
			return p2(nil)
		end
	end

	if p2 == nil then
		return nil
	end

	if __DEV__ and not (if getmetatable(p2) == nil then false elseif #Object.keys(p2) == 0 then true else false) then
		console.error("Expected useImperativeHandle() first argument to either be a ref callback or React.createRef() object. Instead received: %s.", "an object with keys {" .. Array.join(Object.keys(p2), ", ") .. "}")
	end

	p2.current = p1()

	return function() --[[ Line: 1415 | Upvalues: p2 (copy) ]]
		p2.current = nil
	end
end
function mountImperativeHandle(p1, p2, p3) --[[ mountImperativeHandle | Line: 1424 | Upvalues: __DEV__ (copy), console (copy), Array (copy), enableDoubleInvokingEffects (copy), mountEffectImpl (copy), MountLayoutDev (copy), Update (copy), Layout (copy) ]]
	if __DEV__ and type(p2) ~= "function" then
		console.error("Expected useImperativeHandle() second argument to be a function that creates a handle. Instead received: %s.", if p2 == nil then "nil" else type(p2))
	end

	local v4 = if p3 == nil then nil else Array.concat(p3, { p1 })

	if __DEV__ and enableDoubleInvokingEffects then
		return mountEffectImpl(bit32.bor(MountLayoutDev, Update), Layout, function() --[[ Line: 1447 | Upvalues: p2 (copy), p1 (copy) ]]
			return imperativeHandleEffect(p2, p1)
		end, v4)
	end

	return mountEffectImpl(Update, Layout, function() --[[ Line: 1453 | Upvalues: p2 (copy), p1 (copy) ]]
		return imperativeHandleEffect(p2, p1)
	end, v4)
end
function updateImperativeHandle(p1, p2, p3) --[[ updateImperativeHandle | Line: 1459 | Upvalues: __DEV__ (copy), console (copy), Update (copy), Layout (copy) ]]
	if __DEV__ and type(p2) ~= "function" then
		console.error("Expected useImperativeHandle() second argument to be a function that creates a handle. Instead received: %s.", if p2 then type(p2) else "nil")
	end

	local v3

	if p3 == nil then
		v3 = nil
	else
		local v4 = table.clone(p3)

		table.insert(v4, p1)
		v3 = v4
	end

	return updateEffectImpl(Update, Layout, function() --[[ Line: 1486 | Upvalues: p2 (copy), p1 (copy) ]]
		return imperativeHandleEffect(p2, p1)
	end, v3)
end
function mountDebugValue(p1, p2) --[[ mountDebugValue | Line: 1491 ]] end

local v22 = mountDebugValue

function mountCallback(p1, p2) --[[ mountCallback | Line: 1499 | Upvalues: v8 (ref), v6 (ref) ]]
	local t = {
		memoizedState = nil,
		baseState = nil,
		baseQueue = nil,
		queue = nil,
		next = nil
	}

	if v8 == nil then
		v6.memoizedState = t
	else
		v8.next = t
	end

	v8 = t
	t.memoizedState = { p1, p2 }

	return p1
end
function updateCallback(p1, p2) --[[ updateCallback | Line: 1507 | Upvalues: updateWorkInProgressHook (copy), areHookInputsEqual (copy) ]]
	local v1 = updateWorkInProgressHook()
	local memoizedState = v1.memoizedState

	if memoizedState ~= nil and (p2 ~= nil and areHookInputsEqual(p2, memoizedState[2])) then
		return memoizedState[1]
	end

	v1.memoizedState = { p1, p2 }

	return p1
end
function mountMemo(p1, p2) --[[ mountMemo | Line: 1526 | Upvalues: v8 (ref), v6 (ref) ]]
	local t = {
		memoizedState = nil,
		baseState = nil,
		baseQueue = nil,
		queue = nil,
		next = nil
	}

	if v8 == nil then
		v6.memoizedState = t
	else
		v8.next = t
	end

	v8 = t

	local t2 = { p1() }

	t.memoizedState = { t2, p2 }

	return unpack(t2)
end
function updateMemo(p1, p2) --[[ updateMemo | Line: 1538 | Upvalues: updateWorkInProgressHook (copy), areHookInputsEqual (copy) ]]
	local v1 = updateWorkInProgressHook()
	local memoizedState = v1.memoizedState

	if memoizedState ~= nil and (p2 ~= nil and areHookInputsEqual(p2, memoizedState[2])) then
		return unpack(memoizedState[1])
	end

	local t = { p1() }

	v1.memoizedState = { t, p2 }

	return unpack(t)
end
function t.getIsUpdatingOpaqueValueInRenderPhaseInDEV() --[[ Line: 1688 | Upvalues: __DEV__ (copy) ]]
	if __DEV__ then
		return false
	end

	return nil
end
function mountOpaqueIdentifier() --[[ mountOpaqueIdentifier | Line: 1710 | Upvalues: __DEV__ (copy), console (copy), makeClientId (copy), getIsHydrating (copy) ]]
	local v1 = nil

	if __DEV__ then
		console.warn("!!! unimplemented: warnOnOpaqueIdentifierAccessInDEV")
	else
		v1 = makeClientId
	end

	if getIsHydrating() then
		print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		print("UNIMPLEMENTED ERROR: ReactFiberHooks: getIsHydrating() true")
		error("FIXME (roblox): ReactFiberHooks: getIsHydrating() true is unimplemented")
	end

	local v2 = v1()

	mountState(v2)

	return v2
end
function updateOpaqueIdentifier() --[[ updateOpaqueIdentifier | Line: 1777 ]]
	local v1, _ = updateState(nil)

	return v1
end
function rerenderOpaqueIdentifier() --[[ rerenderOpaqueIdentifier | Line: 1782 ]]
	local v1, _ = rerenderState(nil)

	return v1
end
function dispatchAction(p1, p2, p3, ...) --[[ dispatchAction | Line: 1787 | Upvalues: __DEV__ (copy), console (copy), requestEventTime (copy), requestUpdateLane (copy), v6 (ref), v9 (ref), v10 (ref), NoLanes (copy), ReactCurrentDispatcher (copy), v19 (ref), warnIfNotScopedWithMatchingAct (copy), warnIfNotCurrentlyActingUpdatesInDEV (copy), scheduleUpdateOnFiber (copy), enableDebugTracing (copy), DebugTracingMode (copy), getComponentName (copy), logStateUpdateScheduled (copy), enableSchedulingProfiler (copy), markStateUpdateScheduled (copy) ]]
	if __DEV__ and type(if select("#", ...) == 1 then select(1, ...) else nil) == "function" then
		console.error("State updates from the useState() and useReducer() Hooks don\'t support the second callback argument. To execute a side effect after rendering, declare it in the component body with useEffect().")
	end

	local v3 = requestEventTime()
	local v4 = requestUpdateLane(p1)
	local t = {
		eagerReducer = nil,
		eagerState = nil,
		next = nil,
		lane = v4,
		action = p3
	}
	local pending = p2.pending

	if pending == nil then
		t.next = t
	else
		t.next = pending.next
		pending.next = t
	end

	p2.pending = t

	local alternate = p1.alternate

	if p1 == v6 or alternate ~= nil and alternate == v6 then
		v9 = true
		v10 = true
	else
		if p1.lanes == NoLanes and (alternate == nil or alternate.lanes == NoLanes) then
			local lastRenderedReducer = p2.lastRenderedReducer

			if lastRenderedReducer ~= nil then
				local v5

				if __DEV__ then
					v5 = ReactCurrentDispatcher.current
					ReactCurrentDispatcher.current = v19
				else
					v5 = nil
				end

				local lastRenderedState = p2.lastRenderedState
				local ok, result = pcall(lastRenderedReducer, lastRenderedState, p3)

				if ok then
					t.eagerReducer = lastRenderedReducer
					t.eagerState = result
				end

				if __DEV__ then
					ReactCurrentDispatcher.current = v5
				end

				if if result == lastRenderedState and (result ~= 0 or 1 / result == 1 / lastRenderedState) then true elseif result == result then false elseif lastRenderedState == lastRenderedState then false else true then
					return
				end
			end
		end

		if __DEV__ and (type(_G.jest) ~= "nil" or _G.__TESTEZ_RUNNING_TEST__) then
			warnIfNotScopedWithMatchingAct(p1)
			warnIfNotCurrentlyActingUpdatesInDEV(p1)
		end

		scheduleUpdateOnFiber(p1, v4, v3)
	end

	if __DEV__ and enableDebugTracing and bit32.band(p1.mode, DebugTracingMode) ~= 0 then
		logStateUpdateScheduled(getComponentName(p1.type) or "Unknown", v4, p3)
	end

	if not enableSchedulingProfiler then
		return
	end

	markStateUpdateScheduled(p1, v4)
end

local t2 = {
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
}

t.ContextOnlyDispatcher = t2

local t3 = {
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
}
local t4 = {
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
	useDebugValue = v22,
	useMutableSource = updateMutableSource,
	useOpaqueIdentifier = updateOpaqueIdentifier,
	unstable_isNewReconciler = enableNewReconciler
}
local t5 = {
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
	useDebugValue = v22,
	useMutableSource = updateMutableSource,
	useOpaqueIdentifier = rerenderOpaqueIdentifier,
	unstable_isNewReconciler = enableNewReconciler
}

if __DEV__ then
	v14 = {
		readContext = function(p1, p2) --[[ readContext | Line: 2021 | Upvalues: readContext (copy) ]]
			return readContext(p1, p2)
		end,
		useCallback = function(p1, p2) --[[ useCallback | Line: 2024 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref), console (copy) ]]
			v11 = "useCallback"

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			if __DEV__ and p2 ~= nil then
				local v3

				if type(p2) == "table" then
					v3 = true

					for v4, v5 in p2 do
						if type(v4) ~= "number" then
							v3 = false

							break
						end
					end
				else
					v3 = false
				end

				if not v3 then
					console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", v11, (type(p2)))
				end
			end

			return mountCallback(p1, p2)
		end,
		useContext = function(p1, p2) --[[ useContext | Line: 2030 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref), readContext (copy) ]]
			v11 = "useContext"

			if not __DEV__ then
				return readContext(p1, p2)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return readContext(p1, p2)
		end,
		useEffect = function(p1, p2) --[[ useEffect | Line: 2035 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref), console (copy), mountEffect (copy) ]]
			v11 = "useEffect"

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			if __DEV__ and p2 ~= nil then
				local v3

				if type(p2) == "table" then
					v3 = true

					for v4, v5 in p2 do
						if type(v4) ~= "number" then
							v3 = false

							break
						end
					end
				else
					v3 = false
				end

				if not v3 then
					console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", v11, (type(p2)))
				end
			end

			return mountEffect(p1, p2)
		end,
		useImperativeHandle = function(p1, p2, p3) --[[ useImperativeHandle | Line: 2045 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref), console (copy) ]]
			v11 = "useImperativeHandle"

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			if __DEV__ and p3 ~= nil then
				local v3

				if type(p3) == "table" then
					v3 = true

					for v4, v5 in p3 do
						if type(v4) ~= "number" then
							v3 = false

							break
						end
					end
				else
					v3 = false
				end

				if not v3 then
					console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", v11, (type(p3)))
				end
			end

			return mountImperativeHandle(p1, p2, p3)
		end,
		useLayoutEffect = function(p1, p2) --[[ useLayoutEffect | Line: 2055 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref), console (copy), mountLayoutEffect (copy) ]]
			v11 = "useLayoutEffect"

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			if __DEV__ and p2 ~= nil then
				local v3

				if type(p2) == "table" then
					v3 = true

					for v4, v5 in p2 do
						if type(v4) ~= "number" then
							v3 = false

							break
						end
					end
				else
					v3 = false
				end

				if not v3 then
					console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", v11, (type(p2)))
				end
			end

			return mountLayoutEffect(p1, p2)
		end,
		useMemo = function(p1, p2) --[[ Line: 2066 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref), console (copy), ReactCurrentDispatcher (copy), v18 (ref) ]]
			v11 = "useMemo"

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			if __DEV__ and p2 ~= nil then
				local v3

				if type(p2) == "table" then
					v3 = true

					for v4, v5 in p2 do
						if type(v4) ~= "number" then
							v3 = false

							break
						end
					end
				else
					v3 = false
				end

				if not v3 then
					console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", v11, (type(p2)))
				end
			end

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v18

			local t = { pcall(mountMemo, p1, p2) }

			ReactCurrentDispatcher.current = current

			if not t[1] then
				error(t[2])
			end

			return unpack(t, 2)
		end,
		useReducer = function(p1, p2, p3) --[[ useReducer | Line: 2084 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref), ReactCurrentDispatcher (copy), v18 (ref) ]]
			v11 = "useReducer"

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v18

			local ok, result, result2 = pcall(mountReducer, p1, p2, p3)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useRef = function(p1) --[[ useRef | Line: 2102 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref) ]]
			v11 = "useRef"

			if not __DEV__ then
				return mountRef(p1)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountRef(p1)
		end,
		useBinding = function(p1) --[[ useBinding | Line: 2108 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref) ]]
			v11 = "useBinding"

			if not __DEV__ then
				return mountBinding(p1)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountBinding(p1)
		end,
		useState = function(p1) --[[ useState | Line: 2113 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref), ReactCurrentDispatcher (copy), v18 (ref) ]]
			v11 = "useState"

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v18

			local ok, result, result2 = pcall(mountState, p1)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useDebugValue = function(p1, p2) --[[ useDebugValue | Line: 2127 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref) ]]
			v11 = "useDebugValue"

			if not __DEV__ then
				return mountDebugValue(p1, p2)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountDebugValue(p1, p2)
		end,
		useMutableSource = function(p1, p2, p3) --[[ useMutableSource | Line: 2142 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref) ]]
			v11 = "useMutableSource"

			if not __DEV__ then
				return mountMutableSource(p1, p2, p3)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountMutableSource(p1, p2, p3)
		end,
		useOpaqueIdentifier = function() --[[ useOpaqueIdentifier | Line: 2157 | Upvalues: v11 (ref), __DEV__ (copy), v12 (ref) ]]
			v11 = "useOpaqueIdentifier"

			if not __DEV__ then
				return mountOpaqueIdentifier()
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountOpaqueIdentifier()
		end,
		unstable_isNewReconciler = enableNewReconciler
	}
	v15 = {
		readContext = function(p1, p2) --[[ readContext | Line: 2167 | Upvalues: readContext (copy) ]]
			return readContext(p1, p2)
		end,
		useCallback = function(p1, p2) --[[ useCallback | Line: 2170 | Upvalues: v11 (ref), __DEV__ (copy), console (copy) ]]
			v11 = "useCallback"
			updateHookTypesDev()

			if __DEV__ and p2 ~= nil then
				local v1

				if type(p2) == "table" then
					v1 = true

					for v2, v3 in p2 do
						if type(v2) ~= "number" then
							v1 = false

							break
						end
					end
				else
					v1 = false
				end

				if not v1 then
					console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", v11, (type(p2)))
				end
			end

			return mountCallback(p1, p2)
		end,
		useContext = function(p1, p2) --[[ useContext | Line: 2176 | Upvalues: v11 (ref), readContext (copy) ]]
			v11 = "useContext"
			updateHookTypesDev()

			return readContext(p1, p2)
		end,
		useEffect = function(p1, p2) --[[ useEffect | Line: 2181 | Upvalues: v11 (ref), mountEffect (copy) ]]
			v11 = "useEffect"
			updateHookTypesDev()

			return mountEffect(p1, p2)
		end,
		useImperativeHandle = function(p1, p2, p3) --[[ useImperativeHandle | Line: 2190 | Upvalues: v11 (ref) ]]
			v11 = "useImperativeHandle"
			updateHookTypesDev()

			return mountImperativeHandle(p1, p2, p3)
		end,
		useLayoutEffect = function(p1, p2) --[[ useLayoutEffect | Line: 2199 | Upvalues: v11 (ref), mountLayoutEffect (copy) ]]
			v11 = "useLayoutEffect"
			updateHookTypesDev()

			return mountLayoutEffect(p1, p2)
		end,
		useMemo = function(p1, p2) --[[ Line: 2209 | Upvalues: v11 (ref), ReactCurrentDispatcher (copy), v18 (ref) ]]
			v11 = "useMemo"
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v18

			local t = { pcall(mountMemo, p1, p2) }

			ReactCurrentDispatcher.current = current

			if not t[1] then
				error(t[2])
			end

			return unpack(t, 2)
		end,
		useReducer = function(p1, p2, p3) --[[ useReducer | Line: 2225 | Upvalues: v11 (ref), ReactCurrentDispatcher (copy), v18 (ref) ]]
			v11 = "useReducer"
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v18

			local ok, result, result2 = pcall(mountReducer, p1, p2, p3)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useRef = function(p1) --[[ useRef | Line: 2243 | Upvalues: v11 (ref) ]]
			v11 = "useRef"
			updateHookTypesDev()

			return mountRef(p1)
		end,
		useBinding = function(p1) --[[ useBinding | Line: 2249 | Upvalues: v11 (ref) ]]
			v11 = "useBinding"
			updateHookTypesDev()

			return mountBinding(p1)
		end,
		useState = function(p1) --[[ useState | Line: 2254 | Upvalues: v11 (ref), ReactCurrentDispatcher (copy), v18 (ref) ]]
			v11 = "useState"
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v18

			local ok, result, result2 = pcall(mountState, p1)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useDebugValue = function(p1, p2) --[[ useDebugValue | Line: 2268 | Upvalues: v11 (ref) ]]
			v11 = "useDebugValue"
			updateHookTypesDev()

			return mountDebugValue(p1, p2)
		end,
		useMutableSource = function(p1, p2, p3) --[[ useMutableSource | Line: 2283 | Upvalues: v11 (ref) ]]
			v11 = "useMutableSource"
			updateHookTypesDev()

			return mountMutableSource(p1, p2, p3)
		end,
		useOpaqueIdentifier = function() --[[ useOpaqueIdentifier | Line: 2298 | Upvalues: v11 (ref) ]]
			v11 = "useOpaqueIdentifier"
			updateHookTypesDev()

			return mountOpaqueIdentifier()
		end,
		unstable_isNewReconciler = enableNewReconciler
	}
	v16 = {
		readContext = function(p1, p2) --[[ readContext | Line: 2308 | Upvalues: readContext (copy) ]]
			return readContext(p1, p2)
		end,
		useCallback = function(p1, p2) --[[ useCallback | Line: 2311 | Upvalues: v11 (ref) ]]
			v11 = "useCallback"
			updateHookTypesDev()

			return updateCallback(p1, p2)
		end,
		useContext = function(p1, p2) --[[ useContext | Line: 2316 | Upvalues: v11 (ref), readContext (copy) ]]
			v11 = "useContext"
			updateHookTypesDev()

			return readContext(p1, p2)
		end,
		useEffect = function(p1, p2) --[[ useEffect | Line: 2321 | Upvalues: v11 (ref), updateEffect (copy) ]]
			v11 = "useEffect"
			updateHookTypesDev()

			return updateEffect(p1, p2)
		end,
		useImperativeHandle = function(p1, p2, p3) --[[ useImperativeHandle | Line: 2330 | Upvalues: v11 (ref) ]]
			v11 = "useImperativeHandle"
			updateHookTypesDev()

			return updateImperativeHandle(p1, p2, p3)
		end,
		useLayoutEffect = function(p1, p2) --[[ useLayoutEffect | Line: 2339 | Upvalues: v11 (ref), updateLayoutEffect (copy) ]]
			v11 = "useLayoutEffect"
			updateHookTypesDev()

			return updateLayoutEffect(p1, p2)
		end,
		useMemo = function(p1, p2) --[[ Line: 2349 | Upvalues: v11 (ref), ReactCurrentDispatcher (copy), v19 (ref) ]]
			v11 = "useMemo"
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v19

			local t = { pcall(updateMemo, p1, p2) }

			ReactCurrentDispatcher.current = current

			if not t[1] then
				error(t[2])
			end

			return unpack(t, 2)
		end,
		useReducer = function(p1, p2, p3) --[[ useReducer | Line: 2365 | Upvalues: v11 (ref), ReactCurrentDispatcher (copy), v19 (ref) ]]
			v11 = "useReducer"
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v19

			local ok, result, result2 = pcall(updateReducer, p1, p2, p3)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useRef = function(p1) --[[ useRef | Line: 2383 | Upvalues: v11 (ref) ]]
			v11 = "useRef"
			updateHookTypesDev()

			return updateRef(p1)
		end,
		useBinding = function(p1) --[[ useBinding | Line: 2389 | Upvalues: v11 (ref) ]]
			v11 = "useBinding"
			updateHookTypesDev()

			return updateBinding(p1)
		end,
		useState = function(p1) --[[ useState | Line: 2394 | Upvalues: v11 (ref), ReactCurrentDispatcher (copy), v19 (ref) ]]
			v11 = "useState"
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v19

			local ok, result, result2 = pcall(updateState, p1)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useDebugValue = function(p1, p2) --[[ useDebugValue | Line: 2408 | Upvalues: v11 (ref), v22 (copy) ]]
			v11 = "useDebugValue"
			updateHookTypesDev()

			return v22(p1, p2)
		end,
		useMutableSource = function(p1, p2, p3) --[[ useMutableSource | Line: 2423 | Upvalues: v11 (ref) ]]
			v11 = "useMutableSource"
			updateHookTypesDev()

			return updateMutableSource(p1, p2, p3)
		end,
		useOpaqueIdentifier = function() --[[ useOpaqueIdentifier | Line: 2438 | Upvalues: v11 (ref) ]]
			v11 = "useOpaqueIdentifier"
			updateHookTypesDev()

			return updateOpaqueIdentifier()
		end,
		unstable_isNewReconciler = enableNewReconciler
	}
	v17 = {
		readContext = function(p1, p2) --[[ readContext | Line: 2448 | Upvalues: readContext (copy) ]]
			return readContext(p1, p2)
		end,
		useCallback = function(p1, p2) --[[ useCallback | Line: 2451 | Upvalues: v11 (ref) ]]
			v11 = "useCallback"
			updateHookTypesDev()

			return mountCallback(p1, p2)
		end,
		useContext = function(p1, p2) --[[ useContext | Line: 2456 | Upvalues: v11 (ref), readContext (copy) ]]
			v11 = "useContext"
			updateHookTypesDev()

			return readContext(p1, p2)
		end,
		useEffect = function(p1, p2) --[[ useEffect | Line: 2461 | Upvalues: v11 (ref), updateEffect (copy) ]]
			v11 = "useEffect"
			updateHookTypesDev()

			return updateEffect(p1, p2)
		end,
		useImperativeHandle = function(p1, p2, p3) --[[ useImperativeHandle | Line: 2470 | Upvalues: v11 (ref) ]]
			v11 = "useImperativeHandle"
			updateHookTypesDev()

			return updateImperativeHandle(p1, p2, p3)
		end,
		useLayoutEffect = function(p1, p2) --[[ useLayoutEffect | Line: 2479 | Upvalues: v11 (ref), updateLayoutEffect (copy) ]]
			v11 = "useLayoutEffect"
			updateHookTypesDev()

			return updateLayoutEffect(p1, p2)
		end,
		useMemo = function(p1, p2) --[[ Line: 2489 | Upvalues: v11 (ref), ReactCurrentDispatcher (copy), v20 (ref) ]]
			v11 = "useMemo"
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v20

			local t = { pcall(updateMemo, p1, p2) }

			ReactCurrentDispatcher.current = current

			if not t[1] then
				error(t[2])
			end

			return unpack(t, 2)
		end,
		useReducer = function(p1, p2, p3) --[[ useReducer | Line: 2505 | Upvalues: v11 (ref), ReactCurrentDispatcher (copy), v20 (ref) ]]
			v11 = "useReducer"
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v20

			local ok, result, result2 = pcall(rerenderReducer, p1, p2, p3)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useRef = function(p1) --[[ useRef | Line: 2524 | Upvalues: v11 (ref) ]]
			v11 = "useRef"
			updateHookTypesDev()

			return updateRef(p1)
		end,
		useBinding = function(p1) --[[ useBinding | Line: 2530 | Upvalues: v11 (ref) ]]
			v11 = "useBinding"
			updateHookTypesDev()

			return updateBinding(p1)
		end,
		useState = function(p1) --[[ useState | Line: 2535 | Upvalues: v11 (ref), ReactCurrentDispatcher (copy), v20 (ref) ]]
			v11 = "useState"
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v20

			local ok, result, result2 = pcall(rerenderState, p1)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useDebugValue = function(p1, p2) --[[ useDebugValue | Line: 2549 | Upvalues: v11 (ref), v22 (copy) ]]
			v11 = "useDebugValue"
			updateHookTypesDev()

			return v22(p1, p2)
		end,
		useMutableSource = function(p1, p2, p3) --[[ useMutableSource | Line: 2564 | Upvalues: v11 (ref) ]]
			v11 = "useMutableSource"
			updateHookTypesDev()

			return updateMutableSource(p1, p2, p3)
		end,
		useOpaqueIdentifier = function() --[[ useOpaqueIdentifier | Line: 2579 | Upvalues: v11 (ref) ]]
			v11 = "useOpaqueIdentifier"
			updateHookTypesDev()

			return rerenderOpaqueIdentifier()
		end,
		unstable_isNewReconciler = enableNewReconciler
	}

	local _ = {
		readContext = function(p1, p2) --[[ readContext | Line: 2589 | Upvalues: console (copy), readContext (copy) ]]
			console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().")

			return readContext(p1, p2)
		end,
		useCallback = function(p1, p2) --[[ useCallback | Line: 2593 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref) ]]
			v11 = "useCallback"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return mountCallback(p1, p2)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountCallback(p1, p2)
		end,
		useContext = function(p1, p2) --[[ useContext | Line: 2599 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref), readContext (copy) ]]
			v11 = "useContext"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return readContext(p1, p2)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return readContext(p1, p2)
		end,
		useEffect = function(p1, p2) --[[ useEffect | Line: 2605 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref), mountEffect (copy) ]]
			v11 = "useEffect"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return mountEffect(p1, p2)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountEffect(p1, p2)
		end,
		useImperativeHandle = function(p1, p2, p3) --[[ useImperativeHandle | Line: 2615 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref) ]]
			v11 = "useImperativeHandle"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return mountImperativeHandle(p1, p2, p3)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountImperativeHandle(p1, p2, p3)
		end,
		useLayoutEffect = function(p1, p2) --[[ useLayoutEffect | Line: 2625 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref), mountLayoutEffect (copy) ]]
			v11 = "useLayoutEffect"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return mountLayoutEffect(p1, p2)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountLayoutEffect(p1, p2)
		end,
		useMemo = function(p1, p2) --[[ Line: 2636 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref), ReactCurrentDispatcher (copy), v18 (ref) ]]
			v11 = "useMemo"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v18

			local t = { pcall(mountMemo, p1, p2) }

			ReactCurrentDispatcher.current = current

			if not t[1] then
				error(t[2])
			end

			return unpack(t, 2)
		end,
		useReducer = function(p1, p2, p3) --[[ useReducer | Line: 2653 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref), ReactCurrentDispatcher (copy), v18 (ref) ]]
			v11 = "useReducer"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v18

			local ok, result, result2 = pcall(mountReducer, p1, p2, p3)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useRef = function(p1) --[[ useRef | Line: 2672 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref) ]]
			v11 = "useRef"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return mountRef(p1)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountRef(p1)
		end,
		useBinding = function(p1) --[[ useBinding | Line: 2679 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref) ]]
			v11 = "useBinding"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return mountBinding(p1)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountBinding(p1)
		end,
		useState = function(p1) --[[ useState | Line: 2685 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref), ReactCurrentDispatcher (copy), v18 (ref) ]]
			v11 = "useState"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if __DEV__ then
				local v1 = v11

				if v12 == nil then
					v12 = { v1 }
				else
					table.insert(v12, v1)
				end
			end

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v18

			local ok, result, result2 = pcall(mountState, p1)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useDebugValue = function(p1, p2) --[[ useDebugValue | Line: 2700 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref) ]]
			v11 = "useDebugValue"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return mountDebugValue(p1, p2)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountDebugValue(p1, p2)
		end,
		useMutableSource = function(p1, p2, p3) --[[ useMutableSource | Line: 2718 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref) ]]
			v11 = "useMutableSource"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return mountMutableSource(p1, p2, p3)
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountMutableSource(p1, p2, p3)
		end,
		useOpaqueIdentifier = function() --[[ useOpaqueIdentifier | Line: 2734 | Upvalues: v11 (ref), console (copy), __DEV__ (copy), v12 (ref) ]]
			v11 = "useOpaqueIdentifier"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")

			if not __DEV__ then
				return mountOpaqueIdentifier()
			end

			local v1 = v11

			if v12 == nil then
				v12 = { v1 }
			else
				table.insert(v12, v1)
			end

			return mountOpaqueIdentifier()
		end,
		unstable_isNewReconciler = enableNewReconciler
	}

	v19 = {
		readContext = function(p1, p2) --[[ readContext | Line: 2745 | Upvalues: console (copy), readContext (copy) ]]
			console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().")

			return readContext(p1, p2)
		end,
		useCallback = function(p1, p2) --[[ useCallback | Line: 2749 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useCallback"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return mountCallback(p1, p2)
		end,
		useContext = function(p1, p2) --[[ useContext | Line: 2755 | Upvalues: v11 (ref), console (copy), readContext (copy) ]]
			v11 = "useContext"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return readContext(p1, p2)
		end,
		useEffect = function(p1, p2) --[[ useEffect | Line: 2761 | Upvalues: v11 (ref), console (copy), updateEffect (copy) ]]
			v11 = "useEffect"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateEffect(p1, p2)
		end,
		useImperativeHandle = function(p1, p2, p3) --[[ useImperativeHandle | Line: 2771 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useImperativeHandle"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateImperativeHandle(p1, p2, p3)
		end,
		useLayoutEffect = function(p1, p2) --[[ useLayoutEffect | Line: 2781 | Upvalues: v11 (ref), console (copy), updateLayoutEffect (copy) ]]
			v11 = "useLayoutEffect"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateLayoutEffect(p1, p2)
		end,
		useMemo = function(p1, p2) --[[ Line: 2792 | Upvalues: v11 (ref), console (copy), ReactCurrentDispatcher (copy), v19 (ref) ]]
			v11 = "useMemo"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v19

			local t = { pcall(updateMemo, p1, p2) }

			ReactCurrentDispatcher.current = current

			if not t[1] then
				error(t[2])
			end

			return unpack(t, 2)
		end,
		useReducer = function(p1, p2, p3) --[[ useReducer | Line: 2809 | Upvalues: v11 (ref), console (copy), ReactCurrentDispatcher (copy), v19 (ref) ]]
			v11 = "useReducer"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v19

			local ok, result, result2 = pcall(updateReducer, p1, p2, p3)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useRef = function(p1) --[[ useRef | Line: 2829 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useRef"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateRef(p1)
		end,
		useBinding = function(p1) --[[ useBinding | Line: 2836 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useBinding"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateBinding(p1)
		end,
		useState = function(p1) --[[ useState | Line: 2842 | Upvalues: v11 (ref), console (copy), ReactCurrentDispatcher (copy), v19 (ref) ]]
			v11 = "useState"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v19

			local ok, result, result2 = pcall(updateState, p1)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useDebugValue = function(p1, p2) --[[ useDebugValue | Line: 2857 | Upvalues: v11 (ref), console (copy), v22 (copy) ]]
			v11 = "useDebugValue"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return v22(p1, p2)
		end,
		useMutableSource = function(p1, p2, p3) --[[ useMutableSource | Line: 2875 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useMutableSource"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateMutableSource(p1, p2, p3)
		end,
		useOpaqueIdentifier = function() --[[ useOpaqueIdentifier | Line: 2891 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useOpaqueIdentifier"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateOpaqueIdentifier()
		end,
		unstable_isNewReconciler = enableNewReconciler
	}

	local _2 = {
		readContext = function(p1, p2) --[[ readContext | Line: 2902 | Upvalues: console (copy), readContext (copy) ]]
			console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().")

			return readContext(p1, p2)
		end,
		useCallback = function(p1, p2) --[[ useCallback | Line: 2906 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useCallback"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateCallback(p1, p2)
		end,
		useContext = function(p1, p2) --[[ useContext | Line: 2912 | Upvalues: v11 (ref), console (copy), readContext (copy) ]]
			v11 = "useContext"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return readContext(p1, p2)
		end,
		useEffect = function(p1, p2) --[[ useEffect | Line: 2918 | Upvalues: v11 (ref), console (copy), updateEffect (copy) ]]
			v11 = "useEffect"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateEffect(p1, p2)
		end,
		useImperativeHandle = function(p1, p2, p3) --[[ useImperativeHandle | Line: 2928 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useImperativeHandle"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateImperativeHandle(p1, p2, p3)
		end,
		useLayoutEffect = function(p1, p2) --[[ useLayoutEffect | Line: 2938 | Upvalues: v11 (ref), console (copy), updateLayoutEffect (copy) ]]
			v11 = "useLayoutEffect"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateLayoutEffect(p1, p2)
		end,
		useMemo = function(p1, p2) --[[ Line: 2949 | Upvalues: v11 (ref), console (copy), ReactCurrentDispatcher (copy), v19 (ref) ]]
			v11 = "useMemo"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v19

			local t = { pcall(updateMemo, p1, p2) }

			ReactCurrentDispatcher.current = current

			if not t[1] then
				error(t[2])
			end

			return unpack(t, 2)
		end,
		useReducer = function(p1, p2, p3) --[[ useReducer | Line: 2966 | Upvalues: v11 (ref), console (copy), ReactCurrentDispatcher (copy), v19 (ref) ]]
			v11 = "useReducer"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v19

			local ok, result, result2 = pcall(rerenderReducer, p1, p2, p3)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useRef = function(p1) --[[ useRef | Line: 2986 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useRef"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateRef(p1)
		end,
		useBinding = function(p1) --[[ useBinding | Line: 2993 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useBinding"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateBinding(p1)
		end,
		useState = function(p1) --[[ useState | Line: 2999 | Upvalues: v11 (ref), console (copy), ReactCurrentDispatcher (copy), v19 (ref) ]]
			v11 = "useState"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			local current = ReactCurrentDispatcher.current

			ReactCurrentDispatcher.current = v19

			local ok, result, result2 = pcall(rerenderState, p1)

			ReactCurrentDispatcher.current = current

			if not ok then
				error(result)
			end

			return result, result2
		end,
		useDebugValue = function(p1, p2) --[[ useDebugValue | Line: 3014 | Upvalues: v11 (ref), console (copy), v22 (copy) ]]
			v11 = "useDebugValue"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return v22(p1, p2)
		end,
		useMutableSource = function(p1, p2, p3) --[[ useMutableSource | Line: 3032 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useMutableSource"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return updateMutableSource(p1, p2, p3)
		end,
		useOpaqueIdentifier = function() --[[ useOpaqueIdentifier | Line: 3048 | Upvalues: v11 (ref), console (copy) ]]
			v11 = "useOpaqueIdentifier"
			console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks")
			updateHookTypesDev()

			return rerenderOpaqueIdentifier()
		end,
		unstable_isNewReconciler = enableNewReconciler
	}
end

function t.renderWithHooks(p1, p2, p3, p4, p5, p6) --[[ renderWithHooks | Line: 3059 | Upvalues: v5 (ref), v6 (ref), __DEV__ (copy), v12 (ref), v13 (ref), NoLanes (copy), ReactCurrentDispatcher (copy), v16 (ref), v15 (ref), v14 (ref), t3 (copy), t4 (copy), v10 (ref), Error (copy), v7 (ref), v8 (ref), v17 (ref), t5 (copy), t2 (copy), v11 (ref), v9 (ref) ]]
	v5 = p6
	v6 = p2

	if __DEV__ then
		v12 = if p1 == nil then nil else p1._debugHookTypes
		v13 = 0
	end

	p2.memoizedState = nil
	p2.updateQueue = nil
	p2.lanes = NoLanes

	if __DEV__ then
		if p1 == nil or p1.memoizedState == nil then
			if v12 == nil then
				ReactCurrentDispatcher.current = v14
			else
				ReactCurrentDispatcher.current = v15
			end
		else
			ReactCurrentDispatcher.current = v16
		end
	else
		ReactCurrentDispatcher.current = (p1 == nil or p1.memoizedState == nil) and t3 or t4
	end

	local v4 = p3(p4, p5)

	if v10 then
		local count = 0
		local v52

		repeat
			v10 = false

			if count >= 25 then
				error(Error.new("Too many re-renders. React limits the number of renders to prevent an infinite loop."))
			end

			count = count + 1
			v7 = nil
			v8 = nil
			p2.updateQueue = nil

			if __DEV__ then
				v13 = 0
			end

			ReactCurrentDispatcher.current = __DEV__ and v17 or t5
			v52 = p3(p4, p5)
		until not v10

		v4 = v52
	end

	ReactCurrentDispatcher.current = t2

	if __DEV__ then
		p2._debugHookTypes = v12
	end

	local v82 = if v7 == nil then false else v7.next ~= nil

	v5 = NoLanes
	v6 = nil
	v7 = nil
	v8 = nil

	if __DEV__ then
		v11 = nil
		v12 = nil
		v13 = 0
	end

	v9 = false

	if not v82 then
		return v4
	end

	error(Error.new("Rendered fewer hooks than expected. This may be caused by an accidental early return statement."))
end

return t