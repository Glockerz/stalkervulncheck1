-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function unimplemented(p1) --[[ unimplemented | Line: 11 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring(p1))
	error("FIXME (roblox): " .. p1 .. " is unimplemented", 2)
end

local __DEV__ = _G.__DEV__
local __YOLO__ = _G.__YOLO__
local v1 = 0

local function isCallable(p1) --[[ isCallable | Line: 27 ]]
	if typeof(p1) == "function" then
		return true
	end

	if typeof(p1) ~= "table" then
		return false
	end

	local v1 = getmetatable(p1)

	if v1 and rawget(v1, "__call") then
		return true
	end

	if p1._isMockFunction then
		return true
	end

	return false
end

local console = require(script.Parent.Parent:WaitForChild("shared")).console
local v2 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Error = v2.Error
local Set = v2.Set
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"))

require(script.Parent:WaitForChild("ReactInternalTypes"))
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"))

local v3 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"))

require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"))

local ReactHookEffectTags = require(script.Parent:WaitForChild("ReactHookEffectTags"))
local unstable_wrap = require(script.Parent.Parent:WaitForChild("scheduler")).tracing.unstable_wrap
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer
local enableProfilerCommitHooks = ReactFeatureFlags.enableProfilerCommitHooks
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local FunctionComponent = ReactWorkTags.FunctionComponent
local ForwardRef = ReactWorkTags.ForwardRef
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local HostComponent = ReactWorkTags.HostComponent
local HostText = ReactWorkTags.HostText
local HostPortal = ReactWorkTags.HostPortal
local Profiler = ReactWorkTags.Profiler
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local DehydratedFragment = ReactWorkTags.DehydratedFragment
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent
local MemoComponent = ReactWorkTags.MemoComponent
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local FundamentalComponent = ReactWorkTags.FundamentalComponent
local ScopeComponent = ReactWorkTags.ScopeComponent
local Block = ReactWorkTags.Block
local OffscreenComponent = ReactWorkTags.OffscreenComponent
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent
local ReactErrorUtils = require(script.Parent.Parent:WaitForChild("shared")).ReactErrorUtils
local invokeGuardedCallback = ReactErrorUtils.invokeGuardedCallback
local hasCaughtError = ReactErrorUtils.hasCaughtError
local clearCaughtError = ReactErrorUtils.clearCaughtError
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local NoFlags = ReactFiberFlags.NoFlags
local ContentReset = ReactFiberFlags.ContentReset
local Placement = ReactFiberFlags.Placement
local Snapshot = ReactFiberFlags.Snapshot
local Update = ReactFiberFlags.Update
local Callback = ReactFiberFlags.Callback
local LayoutMask = ReactFiberFlags.LayoutMask
local PassiveMask = ReactFiberFlags.PassiveMask
local Ref = ReactFiberFlags.Ref
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError
local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"))
local current = ReactCurrentFiber.current
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber
local onCommitUnmount = require(script.Parent:WaitForChild("ReactFiberDevToolsHook.new")).onCommitUnmount
local resolveDefaultProps = require(script.Parent:WaitForChild("ReactFiberLazyComponent.new")).resolveDefaultProps
local v4 = require(script.Parent:WaitForChild("ReactProfilerTimer.new"))
local startLayoutEffectTimer = v4.startLayoutEffectTimer
local recordPassiveEffectDuration = v4.recordPassiveEffectDuration
local recordLayoutEffectDuration = v4.recordLayoutEffectDuration
local startPassiveEffectTimer = v4.startPassiveEffectTimer
local getCommitTime = v4.getCommitTime
local ProfileMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).ProfileMode
local commitUpdateQueue = v3.commitUpdateQueue
local getPublicInstance = ReactFiberHostConfig.getPublicInstance
local supportsMutation = ReactFiberHostConfig.supportsMutation
local supportsPersistence = ReactFiberHostConfig.supportsPersistence
local supportsHydration = ReactFiberHostConfig.supportsHydration
local commitMount = ReactFiberHostConfig.commitMount
local commitUpdate = ReactFiberHostConfig.commitUpdate
local resetTextContent = ReactFiberHostConfig.resetTextContent
local commitTextUpdate = ReactFiberHostConfig.commitTextUpdate
local appendChild = ReactFiberHostConfig.appendChild
local appendChildToContainer = ReactFiberHostConfig.appendChildToContainer
local insertBefore = ReactFiberHostConfig.insertBefore
local insertInContainerBefore = ReactFiberHostConfig.insertInContainerBefore
local removeChild = ReactFiberHostConfig.removeChild
local removeChildFromContainer = ReactFiberHostConfig.removeChildFromContainer
local hideInstance = ReactFiberHostConfig.hideInstance
local hideTextInstance = ReactFiberHostConfig.hideTextInstance
local unhideInstance = ReactFiberHostConfig.unhideInstance
local unhideTextInstance = ReactFiberHostConfig.unhideTextInstance
local commitHydratedSuspenseInstance = ReactFiberHostConfig.commitHydratedSuspenseInstance
local clearContainer = ReactFiberHostConfig.clearContainer
local v5 = nil

local function resolveRetryWakeable(p1, p2) --[[ resolveRetryWakeable | Line: 190 | Upvalues: v5 (ref) ]]
	if v5 then
		v5.resolveRetryWakeable(p1, p2)

		return
	end

	v5 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
	v5.resolveRetryWakeable(p1, p2)
end

local function markCommitTimeOfFallback() --[[ markCommitTimeOfFallback | Line: 197 | Upvalues: v5 (ref) ]]
	if v5 then
		v5.markCommitTimeOfFallback()

		return
	end

	v5 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
	v5.markCommitTimeOfFallback()
end

local function schedulePassiveEffectCallback() --[[ schedulePassiveEffectCallback | Line: 205 | Upvalues: console (copy) ]]
	console.warn("ReactFiberCommitWork: schedulePassiveEffectCallback causes a dependency cycle\n" .. debug.traceback())
end

local function captureCommitPhaseError(p1, p2, p3) --[[ captureCommitPhaseError | Line: 213 | Upvalues: console (copy) ]]
	console.warn("ReactFiberCommitWork: captureCommitPhaseError causes a dependency cycle")
	error(p3)
end

local NoFlags2 = ReactHookEffectTags.NoFlags
local HasEffect = ReactHookEffectTags.HasEffect
local Layout = ReactHookEffectTags.Layout
local Passive = ReactHookEffectTags.Passive
local v6 = nil

local function f7() --[[ Line: 231 | Upvalues: v6 (ref) ]]
	if v6 then
		return v6
	end

	v6 = require(script.Parent:WaitForChild("ReactFiberBeginWork.new")).didWarnAboutReassigningProps

	return v6
end

local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil

local function callComponentWillUnmountWithTimer(p1, p2) --[[ callComponentWillUnmountWithTimer | Line: 256 | Upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), describeError (copy), recordLayoutEffectDuration (copy) ]]
	p2.props = p1.memoizedProps
	p2.state = p1.memoizedState

	if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(p1.mode, ProfileMode) ~= 0 then
		local ok, result = xpcall(function() --[[ Line: 265 | Upvalues: startLayoutEffectTimer (ref), p2 (copy) ]]
			startLayoutEffectTimer()
			p2:componentWillUnmount()
		end, describeError)

		recordLayoutEffectDuration(p1)

		if not ok then
			error(result)
		end

		return
	end

	p2:componentWillUnmount()
end

function safelyCallComponentWillUnmount(p1, p2, p3) --[[ safelyCallComponentWillUnmount | Line: 283 | Upvalues: callComponentWillUnmountWithTimer (copy), describeError (copy), captureCommitPhaseError (ref) ]]
	local ok, result = xpcall(callComponentWillUnmountWithTimer, describeError, p1, p2)

	if ok then
		return
	end

	captureCommitPhaseError(p1, p3, result)
end

local function safelyDetachRef(p1, p2) --[[ safelyDetachRef | Line: 297 | Upvalues: describeError (copy), captureCommitPhaseError (ref) ]]
	local ref = p1.ref

	if ref == nil then
		return
	end

	if typeof(ref) == "function" then
		local ok, result = xpcall(ref, describeError)

		if not ok then
			captureCommitPhaseError(p1, p2, result)
		end
	else
		ref.current = nil
	end
end

local function safelyCallDestroy(p1, p2, p3) --[[ safelyCallDestroy | Line: 313 | Upvalues: describeError (copy), captureCommitPhaseError (ref) ]]
	local ok, result = xpcall(p3, describeError)

	if ok then
		return
	end

	captureCommitPhaseError(p1, p2, result)
end

local function commitBeforeMutationLifeCycles(p1, p2) --[[ commitBeforeMutationLifeCycles | Line: 325 | Upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), ClassComponent (copy), Snapshot (copy), __DEV__ (copy), f7 (copy), console (copy), getComponentName (copy), resolveDefaultProps (copy), HostRoot (copy), supportsMutation (copy), clearContainer (copy), HostComponent (copy), HostText (copy), HostPortal (copy), IncompleteClassComponent (copy), invariant (copy) ]]
	if p2.tag == FunctionComponent or (p2.tag == ForwardRef or (p2.tag == SimpleMemoComponent or p2.tag == Block)) then
		return
	end

	if p2.tag == ClassComponent then
		if bit32.band(p2.flags, Snapshot) == 0 or p1 == nil then
			return
		end

		local memoizedProps = p1.memoizedProps
		local stateNode = p2.stateNode

		if __DEV__ and (p2.type == p2.elementType and not f7) then
			if stateNode.props ~= p2.memoizedProps then
				console.error("Expected %s props to match memoized props before getSnapshotBeforeUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p2.type) or "instance")
			end

			if stateNode.state ~= p2.memoizedState then
				console.error("Expected %s state to match memoized state before getSnapshotBeforeUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p2.type) or "instance")
			end
		end

		stateNode.__reactInternalSnapshotBeforeUpdate = stateNode:getSnapshotBeforeUpdate(if p2.elementType == p2.type and memoizedProps then memoizedProps else resolveDefaultProps(p2.type, memoizedProps), p1.memoizedState)
	elseif p2.tag == HostRoot then
		if not supportsMutation then
			return
		end

		if bit32.band(p2.flags, Snapshot) == 0 then
			return
		end

		clearContainer(p2.stateNode.containerInfo)
	elseif p2.tag ~= HostComponent and (p2.tag ~= HostText and (p2.tag ~= HostPortal and p2.tag ~= IncompleteClassComponent)) then
		invariant(false, "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue.")
	end
end

local function commitHookEffectListUnmount(p1, p2, p3) --[[ commitHookEffectListUnmount | Line: 418 | Upvalues: describeError (copy), captureCommitPhaseError (ref) ]]
	local updateQueue = p2.updateQueue
	local v1 = if updateQueue == nil then nil else updateQueue.lastEffect

	if v1 == nil then
		return
	end

	local v2 = v1.next
	local v3 = v2

	repeat
		if bit32.band(v3.tag, p1) == p1 then
			local destroy = v3.destroy

			v3.destroy = nil

			if destroy ~= nil then
				local ok, result = xpcall(destroy, describeError)

				if not ok then
					captureCommitPhaseError(p2, p3, result)
				end
			end
		end

		v3 = v3.next
	until v3 == v2
end

local function commitHookEffectListMount(p1, p2) --[[ commitHookEffectListMount | Line: 446 | Upvalues: __DEV__ (copy), console (copy) ]]
	local updateQueue = p2.updateQueue
	local v1 = if updateQueue == nil then nil else updateQueue.lastEffect

	if v1 == nil then
		return
	end

	local v2 = v1.next
	local v3 = v2

	repeat
		local v4

		if bit32.band(v3.tag, p1) == p1 then
			v3.destroy = v3.create()

			if __DEV__ then
				local destroy = v3.destroy

				if destroy ~= nil and typeof(destroy) ~= "function" then
					v4 = if destroy == nil then " You returned nil. If your effect does not require clean up, return nil (or nothing)." elseif typeof(destroy.andThen) == "function" then "\n\nIt looks like you wrote useEffect(Promise.new(function() --[[...]] end) or returned a Promise. Instead, write the async function inside your effect and call it immediately:\n\nuseEffect(function()\n  function fetchData()\n    -- You can await here\n    local response = MyAPI.getData(someId):await()\n    -- ...\n  end\n  fetchData()\nend, {someId}) -- Or {} if effect doesn\'t need props or state\n\nLearn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching" else " You returned: " .. destroy
					console.error("An effect function must not return anything besides a function, which is used for clean-up.%s", v4)
				end
			end
		end

		v3 = v3.next
	until v3 == v2
end

function commitProfilerPassiveEffect(p1, p2) --[[ commitProfilerPassiveEffect | Line: 497 | Upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), Profiler (copy), getCommitTime (copy), enableSchedulerTracing (copy) ]]
	if not enableProfilerTimer or (not enableProfilerCommitHooks or p2.tag ~= Profiler) then
		return
	end

	local passiveEffectDuration = p2.stateNode.passiveEffectDuration
	local id = p2.memoizedProps.id
	local onPostCommit = p2.memoizedProps.onPostCommit
	local v1 = getCommitTime()

	if typeof(onPostCommit) ~= "function" then
		return
	end

	if enableSchedulerTracing then
		onPostCommit(id, if p2.alternate == nil then "mount" else "update", passiveEffectDuration, v1, p1.memoizedInteractions)
	else
		onPostCommit(id, if p2.alternate == nil then "mount" else "update", passiveEffectDuration, v1)
	end
end

local function v16(p1, p2, p3, p4) --[[ recursivelyCommitLayoutEffects | Line: 530 | Upvalues: captureCommitPhaseError (ref), schedulePassiveEffectCallback (ref), Profiler (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), v15 (ref), LayoutMask (copy), NoFlags (copy), __DEV__ (copy), current (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), v16 (copy), hasCaughtError (copy), clearCaughtError (copy), resetCurrentFiber (copy), describeError (copy), Update (copy), Callback (copy), ReactCurrentFiber (copy), v1 (ref), __YOLO__ (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), ProfileMode (copy), startLayoutEffectTimer (copy), commitHookEffectListMount (copy), Layout (copy), HasEffect (copy), recordLayoutEffectDuration (copy), PassiveMask (copy), ClassComponent (copy), v13 (ref), HostRoot (copy), v11 (ref), HostComponent (copy), v12 (ref), SuspenseComponent (copy), FundamentalComponent (copy), HostPortal (copy), HostText (copy), IncompleteClassComponent (copy), LegacyHiddenComponent (copy), OffscreenComponent (copy), ScopeComponent (copy), SuspenseListComponent (copy), invariant (copy), Ref (copy) ]]
	if p3 ~= nil then
		captureCommitPhaseError = p3
	end

	if p4 ~= nil then
		schedulePassiveEffectCallback = p4
	end

	local flags = p1.flags
	local tag = p1.tag

	if tag == Profiler then
		local v14

		if enableProfilerTimer and enableProfilerCommitHooks then
			v14 = v15
			v15 = p1
		else
			v14 = nil
		end

		local child = p1.child

		while child ~= nil do
			if bit32.band(p1.subtreeFlags, LayoutMask) ~= NoFlags then
				if __DEV__ then
					local v3 = current

					setCurrentFiber(child)
					invokeGuardedCallback(nil, v16, nil, child, p2, captureCommitPhaseError, schedulePassiveEffectCallback)

					if hasCaughtError() then
						captureCommitPhaseError(child, p1, (clearCaughtError()))
					end

					if v3 == nil then
						resetCurrentFiber()
					else
						setCurrentFiber(v3)
					end
				else
					local ok, result = xpcall(v16, describeError, child, p2, captureCommitPhaseError, schedulePassiveEffectCallback)

					if not ok then
						captureCommitPhaseError(child, p1, result)
					end
				end
			end

			child = child.sibling
		end

		if bit32.band(flags, (bit32.bor(Update, Callback))) ~= NoFlags and enableProfilerTimer then
			if __DEV__ then
				local v7 = current

				setCurrentFiber(p1)
				invokeGuardedCallback(nil, commitLayoutEffectsForProfiler, nil, p1, p2)

				if hasCaughtError() then
					captureCommitPhaseError(p1, p1.return_, (clearCaughtError()))
				end

				if v7 == nil then
					resetCurrentFiber()
				else
					setCurrentFiber(v7)
				end
			else
				local ok, result = xpcall(commitLayoutEffectsForProfiler, describeError, p1, p2)

				if not ok then
					captureCommitPhaseError(p1, p1.return_, result)
				end
			end
		end

		if not (enableProfilerTimer and enableProfilerCommitHooks) then
			return
		end

		if v14 ~= nil then
			local stateNode = v14.stateNode

			stateNode.effectDuration = stateNode.effectDuration + p1.stateNode.effectDuration
		end

		v15 = v14

		return
	end

	local child = p1.child

	while child ~= nil do
		local v9

		if bit32.band(p1.subtreeFlags, LayoutMask) ~= NoFlags then
			if __DEV__ then
				local current2 = ReactCurrentFiber.current

				setCurrentFiber(child)

				if v1 < 20 then
					v1 = v1 + 1
					invokeGuardedCallback(nil, v16, nil, child, p2, captureCommitPhaseError, schedulePassiveEffectCallback)
					v1 = v1 - 1

					if hasCaughtError() then
						captureCommitPhaseError(child, p1, (clearCaughtError()))
					end
				else
					v16(child, p2, captureCommitPhaseError, schedulePassiveEffectCallback)
				end

				if current2 == nil then
					resetCurrentFiber()
				else
					setCurrentFiber(current2)
				end
			else
				local v112 = nil

				if __YOLO__ or not (v1 < 20) then
					v16(child, p2, captureCommitPhaseError, schedulePassiveEffectCallback)
					v9 = true
				else
					v1 = v1 + 1

					local ok, result = xpcall(v16, describeError, child, p2, captureCommitPhaseError, schedulePassiveEffectCallback)

					v1 = v1 - 1
					v9 = ok
					v112 = result
				end

				if not v9 then
					captureCommitPhaseError(child, p1, v112)
				end
			end
		end

		child = child.sibling
	end

	if bit32.band(flags, (bit32.bor(Update, Callback))) ~= NoFlags then
		if tag == FunctionComponent or (tag == ForwardRef or (tag == SimpleMemoComponent or tag == Block)) then
			local v152, v162

			if enableProfilerTimer and enableProfilerCommitHooks then
				if bit32.band(p1.mode, ProfileMode) == 0 then
					v152 = Layout
					v162 = HasEffect
					commitHookEffectListMount(bit32.bor(Layout, HasEffect), p1)
				else
					local ok, result = xpcall(function() --[[ Line: 751 | Upvalues: startLayoutEffectTimer (ref), commitHookEffectListMount (ref), Layout (ref), HasEffect (ref), p1 (copy) ]]
						startLayoutEffectTimer()
						commitHookEffectListMount(bit32.bor(Layout, HasEffect), p1)
					end, describeError)

					recordLayoutEffectDuration(p1)

					if not ok then
						error(result)
					end
				end
			else
				v152 = Layout
				v162 = HasEffect
				commitHookEffectListMount(bit32.bor(Layout, HasEffect), p1)
			end

			if bit32.band(p1.subtreeFlags, PassiveMask) ~= NoFlags then
				schedulePassiveEffectCallback()
			end
		elseif tag == ClassComponent then
			v13(p1)
		elseif tag == HostRoot then
			v11(p1)
		elseif tag == HostComponent then
			v12(p1)
		elseif tag == SuspenseComponent then
			commitSuspenseHydrationCallbacks(p2, p1)
		elseif tag ~= FundamentalComponent and (tag ~= HostPortal and (tag ~= HostText and (tag ~= IncompleteClassComponent and (tag ~= LegacyHiddenComponent and (tag ~= OffscreenComponent and (tag ~= ScopeComponent and tag ~= SuspenseListComponent)))))) then
			invariant(false, "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue.")
		end
	end

	if bit32.band(flags, Ref) == 0 then
		return
	end

	commitAttachRef(p1)
end

function commitLayoutEffectsForProfiler(p1, p2) --[[ commitLayoutEffectsForProfiler | Line: 814 | Upvalues: enableProfilerTimer (copy), getCommitTime (copy), Update (copy), Callback (copy), NoFlags (copy), enableSchedulerTracing (copy), enableProfilerCommitHooks (copy) ]]
	if not enableProfilerTimer then
		return
	end

	local flags = p1.flags
	local alternate = p1.alternate
	local onCommit = p1.memoizedProps.onCommit
	local onRender = p1.memoizedProps.onRender
	local effectDuration = p1.stateNode.effectDuration
	local v1 = getCommitTime()

	if bit32.band(flags, Update) ~= NoFlags then
		local v4

		if typeof(onRender) == "function" then
			v4 = true
		elseif typeof(onRender) == "table" then
			local v5 = getmetatable(onRender)

			v4 = (v5 and rawget(v5, "__call") or onRender._isMockFunction) and true or false
		else
			v4 = false
		end

		if v4 and enableSchedulerTracing then
			onRender(p1.memoizedProps.id, if alternate == nil then "mount" else "update", p1.actualDuration, p1.treeBaseDuration, p1.actualStartTime, v1, p2.memoizedInteractions)
		elseif v4 then
			onRender(p1.memoizedProps.id, if alternate == nil then "mount" else "update", p1.actualDuration, p1.treeBaseDuration, p1.actualStartTime, v1)
		end
	end

	if not enableProfilerCommitHooks or bit32.band(flags, Callback) == NoFlags then
		return
	end

	local v8

	if typeof(onCommit) == "function" then
		v8 = true
	elseif typeof(onCommit) == "table" then
		local v9 = getmetatable(onCommit)

		v8 = (v9 and rawget(v9, "__call") or onCommit._isMockFunction) and true or false
	else
		v8 = false
	end

	if not v8 then
		return
	end

	if enableSchedulerTracing then
		onCommit(p1.memoizedProps.id, if alternate == nil then "mount" else "update", effectDuration, v1, p2.memoizedInteractions)
	else
		onCommit(p1.memoizedProps.id, if alternate == nil then "mount" else "update", effectDuration, v1)
	end
end
v13 = function(p1) --[[ commitLayoutEffectsForClassComponent | Line: 882 | Upvalues: Update (copy), __DEV__ (copy), f7 (copy), console (copy), getComponentName (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), describeError (copy), recordLayoutEffectDuration (copy), resolveDefaultProps (copy), commitUpdateQueue (copy) ]]
	local stateNode = p1.stateNode
	local alternate = p1.alternate

	if bit32.band(p1.flags, Update) ~= 0 then
		if alternate == nil then
			if __DEV__ and (p1.type == p1.elementType and not f7) then
				if stateNode.props ~= p1.memoizedProps then
					console.error("Expected %s props to match memoized props before componentDidMount. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p1.type) or "instance")
				end

				if stateNode.state ~= p1.memoizedState then
					console.error("Expected %s state to match memoized state before componentDidMount. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p1.type) or "instance")
				end
			end

			if enableProfilerTimer and enableProfilerCommitHooks then
				if bit32.band(p1.mode, ProfileMode) == 0 then
					stateNode:componentDidMount()
				else
					local ok, result = xpcall(function() --[[ Line: 914 | Upvalues: startLayoutEffectTimer (ref), stateNode (copy) ]]
						startLayoutEffectTimer()
						stateNode:componentDidMount()
					end, describeError)

					recordLayoutEffectDuration(p1)

					if not ok then
						error(result)
					end
				end
			else
				stateNode:componentDidMount()
			end
		else
			local v3 = p1.elementType == p1.type and alternate.memoizedProps or resolveDefaultProps(p1.type, alternate.memoizedProps)
			local memoizedState = alternate.memoizedState

			if __DEV__ and (p1.type == p1.elementType and not f7) then
				if stateNode.props ~= p1.memoizedProps then
					console.error("Expected %s props to match memoized props before componentDidUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p1.type) or "instance")
				end

				if stateNode.state ~= p1.memoizedState then
					console.error("Expected %s state to match memoized state before componentDidUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p1.type) or "instance")
				end
			end

			if enableProfilerTimer and enableProfilerCommitHooks then
				if bit32.band(p1.mode, ProfileMode) == 0 then
					stateNode:componentDidUpdate(v3, memoizedState, stateNode.__reactInternalSnapshotBeforeUpdate)
				else
					local ok, result = xpcall(function() --[[ Line: 968 | Upvalues: startLayoutEffectTimer (ref), stateNode (copy), v3 (copy), memoizedState (copy) ]]
						startLayoutEffectTimer()
						stateNode:componentDidUpdate(v3, memoizedState, stateNode.__reactInternalSnapshotBeforeUpdate)
					end, describeError)

					recordLayoutEffectDuration(p1)

					if not ok then
						error(result)
					end
				end
			else
				stateNode:componentDidUpdate(v3, memoizedState, stateNode.__reactInternalSnapshotBeforeUpdate)
			end
		end
	end

	local updateQueue = p1.updateQueue

	if updateQueue == nil then
		return
	end

	if __DEV__ and (p1.type == p1.elementType and not f7) then
		if stateNode.props ~= p1.memoizedProps then
			console.error("Expected %s props to match memoized props before processing the update queue. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p1.type) or "instance")
		end

		if stateNode.state ~= p1.memoizedState then
			console.error("Expected %s state to match memoized state before processing the update queue. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p1.type) or "instance")
		end
	end

	commitUpdateQueue(p1, updateQueue, stateNode)
end
v11 = function(p1) --[[ commitLayoutEffectsForHostRoot | Line: 1031 | Upvalues: HostComponent (copy), getPublicInstance (copy), ClassComponent (copy), commitUpdateQueue (copy) ]]
	local updateQueue = p1.updateQueue

	if updateQueue == nil then
		return
	end

	local v1 = nil

	if p1.child ~= nil then
		local child = p1.child

		if child.tag == HostComponent then
			v1 = getPublicInstance(child.stateNode)
		elseif child.tag == ClassComponent then
			v1 = child.stateNode
		end
	end

	commitUpdateQueue(p1, updateQueue, v1)
end
v12 = function(p1) --[[ commitLayoutEffectsForHostComponent | Line: 1050 | Upvalues: Update (copy), commitMount (copy) ]]
	if p1.alternate ~= nil then
		return
	end

	if bit32.band(p1.flags, Update) == 0 then
		return
	end

	commitMount(p1.stateNode, p1.type, p1.memoizedProps, p1)
end

local function hideOrUnhideAllChildren(p1, p2) --[[ hideOrUnhideAllChildren | Line: 1065 | Upvalues: supportsMutation (copy), HostComponent (copy), hideInstance (copy), unhideInstance (copy), HostText (copy), hideTextInstance (copy), unhideTextInstance (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy) ]]
	if not supportsMutation then
		return
	end

	local v1 = p1

	while true do
		if v1.tag == HostComponent then
			local stateNode = v1.stateNode

			if p2 then
				hideInstance(stateNode)
			else
				unhideInstance(v1.stateNode, v1.memoizedProps)
			end
		elseif v1.tag == HostText then
			local stateNode = v1.stateNode

			if p2 then
				hideTextInstance(stateNode)
			else
				unhideTextInstance(stateNode, v1.memoizedProps)
			end
		elseif v1.tag == OffscreenComponent or v1.tag == LegacyHiddenComponent then
			if (v1.memoizedState == nil or v1 == p1) and v1.child ~= nil then
				v1.child.return_ = v1
				v1 = v1.child

				continue
			end
		elseif v1.child ~= nil then
			v1.child.return_ = v1
			v1 = v1.child

			continue
		end

		if v1 == p1 then
			break
		end

		while v1.sibling == nil do
			if v1.return_ == nil or v1.return_ == p1 then
				return
			end

			v1 = v1.return_
		end

		v1.sibling.return_ = v1.return_
		v1 = v1.sibling
	end
end

function commitAttachRef(p1) --[[ commitAttachRef | Line: 1115 | Upvalues: HostComponent (copy), getPublicInstance (copy), __DEV__ (copy), console (copy), getComponentName (copy) ]]
	local ref = p1.ref

	if ref == nil then
		return
	end

	local stateNode = p1.stateNode
	local v1 = if p1.tag == HostComponent then getPublicInstance(stateNode) else stateNode

	if typeof(ref) == "function" then
		ref(v1)

		return
	end

	if __DEV__ and typeof(ref) ~= "table" then
		console.error("Unexpected ref object provided for %s. Use either a ref-setter function or React.createRef().", getComponentName(p1.type) or "instance")

		return
	end

	ref.current = v1
end
function commitDetachRef(p1) --[[ commitDetachRef | Line: 1154 ]]
	local ref = p1.ref

	if ref == nil then
		return
	end

	if typeof(ref) == "function" then
		ref(nil)

		return
	end

	ref.current = nil
end

local function commitUnmount(p1, p2, p3, p4) --[[ commitUnmount | Line: 1168 | Upvalues: onCommitUnmount (copy), FunctionComponent (copy), ForwardRef (copy), MemoComponent (copy), SimpleMemoComponent (copy), Block (copy), Layout (copy), NoFlags2 (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), describeError (copy), captureCommitPhaseError (ref), recordLayoutEffectDuration (copy), ClassComponent (copy), HostComponent (copy), HostPortal (copy), supportsMutation (copy), v14 (ref), supportsPersistence (copy), unimplemented (copy) ]]
	onCommitUnmount(p2)

	if p2.tag == FunctionComponent or (p2.tag == ForwardRef or (p2.tag == MemoComponent or (p2.tag == SimpleMemoComponent or p2.tag == Block))) then
		local updateQueue = p2.updateQueue

		if updateQueue == nil then
			return
		end

		local lastEffect = updateQueue.lastEffect

		if lastEffect == nil then
			return
		end

		local v1 = lastEffect.next
		local v2 = v1

		repeat
			if v2.destroy ~= nil and bit32.band(v2.tag, Layout) ~= NoFlags2 then
				local v4, v5, v6

				if enableProfilerTimer and enableProfilerCommitHooks then
					if bit32.band(p2.mode, ProfileMode) == 0 then
						v4 = v2.destroy
						v5, v6 = xpcall(v4, describeError)

						if not v5 then
							captureCommitPhaseError(p2, p3, v6)
						end
					else
						startLayoutEffectTimer()

						local ok, result = xpcall(v2.destroy, describeError)

						if not ok then
							captureCommitPhaseError(p2, p3, result)
						end

						recordLayoutEffectDuration(p2)
					end
				else
					v4 = v2.destroy
					v5, v6 = xpcall(v4, describeError)

					if not v5 then
						captureCommitPhaseError(p2, p3, v6)
					end
				end
			end

			v2 = v2.next
		until v2 == v1
	elseif p2.tag == ClassComponent then
		local ref = p2.ref

		if ref ~= nil and typeof(ref) == "function" then
			local ok, result = xpcall(ref, describeError)

			if not ok then
				captureCommitPhaseError(p2, p3, result)
			end
		elseif ref ~= nil then
			ref.current = nil
		end

		local stateNode = p2.stateNode

		if typeof(stateNode.componentWillUnmount) ~= "function" then
			return
		end

		safelyCallComponentWillUnmount(p2, stateNode, p3)
	elseif p2.tag == HostComponent then
		local ref = p2.ref

		if ref == nil then
			return
		end

		if typeof(ref) == "function" then
			local ok, result = xpcall(ref, describeError)

			if not ok then
				captureCommitPhaseError(p2, p3, result)
			end
		else
			ref.current = nil
		end
	else
		if p2.tag ~= HostPortal then
			return
		end

		if supportsMutation then
			v14(p1, p2, p3, p4)

			return
		end

		if not supportsPersistence then
			return
		end

		unimplemented("emptyPortalContainer")
	end
end

local function commitNestedUnmounts(p1, p2, p3, p4) --[[ commitNestedUnmounts | Line: 1275 | Upvalues: commitUnmount (ref), supportsMutation (copy), HostPortal (copy) ]]
	local v1 = p2

	while true do
		commitUnmount(p1, v1, p3, p4)

		if v1.child == nil or supportsMutation and v1.tag == HostPortal then
			if v1 == p2 then
				break
			end

			while v1.sibling == nil do
				if v1.return_ == nil or v1.return_ == p2 then
					return
				end

				v1 = v1.return_
			end

			v1.sibling.return_ = v1.return_
			v1 = v1.sibling
		else
			v1.child.return_ = v1
			v1 = v1.child
		end
	end
end

local function detachFiberMutation(p1) --[[ detachFiberMutation | Line: 1315 ]]
	local alternate = p1.alternate

	if alternate ~= nil then
		alternate.return_ = nil
		p1.alternate = nil
	end

	p1.return_ = nil
end

local function getHostParentFiber(p1) --[[ getHostParentFiber | Line: 1382 | Upvalues: v8 (ref), Error (copy) ]]
	local return_ = p1.return_

	while return_ ~= nil do
		if v8(return_) then
			return return_
		end

		return_ = return_.return_
	end

	error(Error.new("Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue."))
end

v8 = function(p1) --[[ isHostParent | Line: 1400 | Upvalues: HostComponent (copy), HostRoot (copy), HostPortal (copy) ]]
	return if p1.tag == HostComponent or p1.tag == HostRoot then true else p1.tag == HostPortal
end

local function getHostSibling(p1) --[[ getHostSibling | Line: 1404 | Upvalues: v8 (ref), HostComponent (copy), HostText (copy), DehydratedFragment (copy), Placement (copy), HostPortal (copy) ]]
	local v1 = p1

	while true do
		local v2 = false

		while v1.sibling == nil do
			if v1.return_ == nil or v8(v1.return_) then
				return nil
			end

			v1 = v1.return_
		end

		v1.sibling.return_ = v1.return_
		v1 = v1.sibling

		while v1.tag ~= HostComponent and (v1.tag ~= HostText and v1.tag ~= DehydratedFragment) do
			if bit32.band(v1.flags, Placement) == 0 then
				if v1.child == nil or v1.tag == HostPortal then
					v2 = true

					break
				end

				v1.child.return_ = v1
				v1 = v1.child
			else
				v2 = true

				break
			end
		end

		if not v2 then
			if bit32.band(v1.flags, Placement) == 0 then
				return v1.stateNode
			end

			break
		end
	end
end

local function commitPlacement(p1) --[[ commitPlacement | Line: 1458 | Upvalues: supportsMutation (copy), getHostParentFiber (copy), HostComponent (copy), HostRoot (copy), HostPortal (copy), invariant (copy), ContentReset (copy), resetTextContent (copy), getHostSibling (ref), v10 (ref), v9 (ref) ]]
	if not supportsMutation then
		return
	end

	local v1 = getHostParentFiber(p1)
	local v2 = nil
	local v3 = nil
	local stateNode = v1.stateNode

	if v1.tag == HostComponent then
		v2 = stateNode
		v3 = false
	elseif v1.tag == HostRoot or v1.tag == HostPortal then
		v2 = stateNode.containerInfo
		v3 = true
	else
		invariant(false, "Invalid host parent fiber. This error is likely caused by a bug in React. Please file an issue.")
	end

	if bit32.band(v1.flags, ContentReset) ~= 0 then
		resetTextContent(v2)
		v1.flags = bit32.band(v1.flags, (bit32.bnot(ContentReset)))
	end

	local v7 = getHostSibling(p1)

	if v3 then
		v10(p1, v7, v2)
	else
		v9(p1, v7, v2)
	end
end

v10 = function(p1, p2, p3) --[[ insertOrAppendPlacementNodeIntoContainer | Line: 1509 | Upvalues: HostComponent (copy), HostText (copy), insertInContainerBefore (copy), appendChildToContainer (copy), HostPortal (copy), v10 (ref) ]]
	local tag = p1.tag

	if if tag == HostComponent then true elseif tag == HostText then true else false then
		local stateNode = p1.stateNode

		if p2 then
			insertInContainerBefore(p3, stateNode, p2)
		else
			appendChildToContainer(p3, stateNode)
		end
	else
		if tag == HostPortal then
			return
		end

		local child = p1.child

		if child == nil then
			return
		end

		v10(child, p2, p3)

		local sibling = child.sibling

		while sibling ~= nil do
			v10(sibling, p2, p3)
			sibling = sibling.sibling
		end
	end
end
v9 = function(p1, p2, p3) --[[ insertOrAppendPlacementNode | Line: 1541 | Upvalues: HostComponent (copy), HostText (copy), insertBefore (copy), appendChild (copy), HostPortal (copy), v9 (ref) ]]
	local tag = p1.tag

	if if tag == HostComponent then true elseif tag == HostText then true else false then
		local stateNode = p1.stateNode

		if p2 then
			insertBefore(p3, stateNode, p2)
		else
			appendChild(p3, stateNode)
		end
	else
		if tag == HostPortal then
			return
		end

		local child = p1.child

		if child == nil then
			return
		end

		v9(child, p2, p3)

		local sibling = child.sibling

		while sibling ~= nil do
			v9(sibling, p2, p3)
			sibling = sibling.sibling
		end
	end
end
v14 = function(p1, p2, p3, p4) --[[ unmountHostComponents | Line: 1569 | Upvalues: Error (copy), HostComponent (copy), HostRoot (copy), HostPortal (copy), HostText (copy), commitNestedUnmounts (ref), removeChildFromContainer (copy), removeChild (copy), commitUnmount (ref) ]]
	local v1, v2, v3, v4 = false, p2, nil, nil

	while true do
		if not v1 then
			local return_ = v2.return_

			while true do
				if return_ == nil then
					error(Error.new("Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue."))
				end

				local stateNode = return_.stateNode

				if return_.tag == HostComponent then
					v3 = false
					v4 = stateNode

					break
				end

				if return_.tag == HostRoot or return_.tag == HostPortal then
					v4 = stateNode.containerInfo
					v3 = true

					break
				end

				return_ = return_.return_
			end

			v1 = true
		end

		if v2.tag == HostComponent or v2.tag == HostText then
			commitNestedUnmounts(p1, v2, p3, p4)

			if v3 then
				removeChildFromContainer(v4, v2.stateNode)
			else
				removeChild(v4, v2.stateNode)
			end
		elseif v2.tag == HostPortal then
			if v2.child ~= nil then
				v4 = v2.stateNode.containerInfo
				v2.child.return_ = v2
				v2 = v2.child
				v3 = true

				continue
			end
		else
			commitUnmount(p1, v2, p3, p4)

			if v2.child ~= nil then
				v2.child.return_ = v2
				v2 = v2.child

				continue
			end
		end

		if v2 == p2 then
			break
		end

		while v2.sibling == nil do
			if v2.return_ == nil or v2.return_ == p2 then
				return
			end

			v2 = v2.return_

			if v2.tag == HostPortal then
				v1 = false
			end
		end

		v2.sibling.return_ = v2.return_
		v2 = v2.sibling
	end
end

local function commitDeletion(p1, p2, p3, p4) --[[ commitDeletion | Line: 1747 | Upvalues: v14 (ref) ]]
	v14(p1, p2, p3, p4)

	local alternate = p2.alternate
	local alternate2 = p2.alternate

	if alternate2 ~= nil then
		alternate2.return_ = nil
		p2.alternate = nil
	end

	p2.return_ = nil

	if alternate == nil then
		return
	end

	local alternate3 = alternate.alternate

	if alternate3 ~= nil then
		alternate3.return_ = nil
		alternate.alternate = nil
	end

	alternate.return_ = nil
end

local function commitWork(p1, p2) --[[ commitWork | Line: 1779 | Upvalues: FunctionComponent (copy), ForwardRef (copy), MemoComponent (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), commitHookEffectListUnmount (copy), Layout (copy), HasEffect (copy), describeError (copy), recordLayoutEffectDuration (copy), ClassComponent (copy), HostComponent (copy), commitUpdate (copy), HostText (copy), invariant (copy), commitTextUpdate (copy), HostRoot (copy), supportsHydration (copy), unimplemented (copy), Profiler (copy), SuspenseComponent (copy), SuspenseListComponent (copy), IncompleteClassComponent (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy), hideOrUnhideAllChildren (copy) ]]
	if p2.tag == FunctionComponent or (p2.tag == ForwardRef or (p2.tag == MemoComponent or (p2.tag == SimpleMemoComponent or p2.tag == Block))) then
		if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(p2.mode, ProfileMode) ~= 0 then
			local ok, result = xpcall(function() --[[ Line: 1868 | Upvalues: startLayoutEffectTimer (ref), commitHookEffectListUnmount (ref), Layout (ref), HasEffect (ref), p2 (copy) ]]
				startLayoutEffectTimer()
				commitHookEffectListUnmount(bit32.bor(Layout, HasEffect), p2, p2.return_)
			end, describeError)

			recordLayoutEffectDuration(p2)

			if not ok then
				error(result)
			end

			return
		end

		local v2 = Layout
		local v3 = HasEffect

		commitHookEffectListUnmount(bit32.bor(v2, v3), p2, p2.return_)
	else
		if p2.tag == ClassComponent then
			return
		end

		if p2.tag == HostComponent then
			local stateNode = p2.stateNode

			if stateNode == nil then
				return
			end

			local memoizedProps = p2.memoizedProps
			local v4 = if p1 then p1.memoizedProps else memoizedProps
			local v5 = p2.type
			local updateQueue = p2.updateQueue

			p2.updateQueue = nil

			if updateQueue == nil then
				return
			end

			commitUpdate(stateNode, updateQueue, v5, v4, memoizedProps, p2)
		elseif p2.tag == HostText then
			invariant(p2.stateNode ~= nil, "This should have a text node initialized. This error is likely caused by a bug in React. Please file an issue.")

			local memoizedProps = p2.memoizedProps
			local v7

			if p1 == nil then
				v7 = nil
			else
				local memoizedProps2 = p1.memoizedProps

				v7 = memoizedProps
			end

			commitTextUpdate(p2.stateNode, v7, memoizedProps)
		elseif p2.tag == HostRoot then
			if not supportsHydration then
				return
			end

			local stateNode = p2.stateNode

			if not stateNode.hydrate then
				return
			end

			stateNode.hydrate = false
			unimplemented("commitWork: HostRoot: commitHydratedContainer")
		else
			if p2.tag == Profiler then
				return
			end

			if p2.tag == SuspenseComponent then
				commitSuspenseComponent(p2)
				attachSuspenseRetryListeners(p2)

				return
			end

			if p2.tag == SuspenseListComponent then
				unimplemented("commitWork: SuspenseListComponent")
			else
				if p2.tag == IncompleteClassComponent then
					return
				end

				if p2.tag ~= OffscreenComponent and p2.tag ~= LegacyHiddenComponent then
					invariant(false, "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue.")

					return
				end

				hideOrUnhideAllChildren(p2, p2.memoizedState ~= nil)

				return
			end

			invariant(false, "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue.")
		end
	end
end

function commitSuspenseComponent(p1) --[[ commitSuspenseComponent | Line: 1994 | Upvalues: v5 (ref), supportsMutation (copy), hideOrUnhideAllChildren (copy), enableSuspenseCallback (copy), __DEV__ (copy), console (copy) ]]
	local memoizedState = p1.memoizedState

	if memoizedState ~= nil then
		if not v5 then
			v5 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
		end

		v5.markCommitTimeOfFallback()

		if supportsMutation then
			hideOrUnhideAllChildren(p1.child, true)
		end
	end

	if not enableSuspenseCallback or memoizedState == nil then
		return
	end

	local suspenseCallback = p1.memoizedProps.suspenseCallback

	if typeof(suspenseCallback) == "function" then
		local updateQueue = p1.updateQueue

		if updateQueue ~= nil then
			suspenseCallback(table.clone(updateQueue))
		end
	else
		if not __DEV__ or suspenseCallback == nil then
			return
		end

		console.error("Unexpected type for suspenseCallback: %s", (tostring(suspenseCallback)))
	end
end
function commitSuspenseHydrationCallbacks(p1, p2) --[[ commitSuspenseHydrationCallbacks | Line: 2033 | Upvalues: supportsHydration (copy), commitHydratedSuspenseInstance (copy), enableSuspenseCallback (copy) ]]
	if not supportsHydration then
		return
	end

	if p2.memoizedState ~= nil then
		return
	end

	local alternate = p2.alternate

	if alternate == nil then
		return
	end

	local memoizedState = alternate.memoizedState

	if memoizedState == nil then
		return
	end

	local dehydrated = memoizedState.dehydrated

	if dehydrated == nil then
		return
	end

	commitHydratedSuspenseInstance(dehydrated)

	if not enableSuspenseCallback then
		return
	end

	local hydrationCallbacks = p1.hydrationCallbacks

	if hydrationCallbacks == nil then
		return
	end

	local onHydrated = hydrationCallbacks.onHydrated

	if not onHydrated then
		return
	end

	onHydrated(dehydrated)
end
function attachSuspenseRetryListeners(p1) --[[ attachSuspenseRetryListeners | Line: 2061 | Upvalues: Set (copy), resolveRetryWakeable (copy), enableSchedulerTracing (copy), unstable_wrap (copy) ]]
	local updateQueue = p1.updateQueue

	if updateQueue == nil then
		return
	end

	p1.updateQueue = nil

	local stateNode = p1.stateNode

	if stateNode == nil then
		p1.stateNode = Set.new()
		stateNode = p1.stateNode
	end

	for v1, v2 in updateQueue do
		local function f3() --[[ Line: 2075 | Upvalues: resolveRetryWakeable (ref), p1 (copy), v1 (copy) ]]
			return resolveRetryWakeable(p1, v1)
		end

		if not stateNode:has(v1) then
			if enableSchedulerTracing and v1.__reactDoNotTraceInteractions ~= true then
				f3 = unstable_wrap(f3)
			end

			stateNode:add(v1)
			v1:andThen(function() --[[ Line: 2086 | Upvalues: f3 (ref) ]]
				return f3()
			end, function() --[[ Line: 2088 | Upvalues: f3 (ref) ]]
				return f3()
			end)
		end
	end
end
function isSuspenseBoundaryBeingHidden(p1, p2) --[[ isSuspenseBoundaryBeingHidden | Line: 2099 ]]
	if p1 == nil then
		return false
	end

	local memoizedState = p1.memoizedState

	if memoizedState ~= nil and memoizedState.dehydrated == nil then
		return false
	end

	local memoizedState2 = p2.memoizedState

	return if memoizedState2 == nil then false else memoizedState2.dehydrated == nil
end
function commitResetTextContent(p1) --[[ commitResetTextContent | Line: 2111 | Upvalues: supportsMutation (copy), resetTextContent (copy) ]]
	if supportsMutation then
		resetTextContent(p1.stateNode)
	end
end

local function commitPassiveUnmount(p1) --[[ commitPassiveUnmount | Line: 2118 | Upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startPassiveEffectTimer (copy), commitHookEffectListUnmount (copy), Passive (copy), HasEffect (copy), recordPassiveEffectDuration (copy) ]]
	if p1.tag ~= FunctionComponent and (p1.tag ~= ForwardRef and (p1.tag ~= SimpleMemoComponent and p1.tag ~= Block)) then
		return
	end

	if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(p1.mode, ProfileMode) ~= 0 then
		startPassiveEffectTimer()
		commitHookEffectListUnmount(bit32.bor(Passive, HasEffect), p1, p1.return_)
		recordPassiveEffectDuration(p1)

		return
	end

	commitHookEffectListUnmount(bit32.bor(Passive, HasEffect), p1, p1.return_)
end

local function commitPassiveUnmountInsideDeletedTree(p1, p2) --[[ commitPassiveUnmountInsideDeletedTree | Line: 2147 | Upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startPassiveEffectTimer (copy), commitHookEffectListUnmount (copy), Passive (copy), recordPassiveEffectDuration (copy) ]]
	if p1.tag ~= FunctionComponent and (p1.tag ~= ForwardRef and (p1.tag ~= SimpleMemoComponent and p1.tag ~= Block)) then
		return
	end

	if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(p1.mode, ProfileMode) ~= 0 then
		startPassiveEffectTimer()
		commitHookEffectListUnmount(Passive, p1, p2)
		recordPassiveEffectDuration(p1)

		return
	end

	commitHookEffectListUnmount(Passive, p1, p2)
end

local function commitPassiveMount(p1, p2) --[[ commitPassiveMount | Line: 2171 | Upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startPassiveEffectTimer (copy), commitHookEffectListMount (copy), describeError (copy), Passive (copy), HasEffect (copy), recordPassiveEffectDuration (copy), Profiler (copy) ]]
	if p2.tag == FunctionComponent or (p2.tag == ForwardRef or (p2.tag == SimpleMemoComponent or p2.tag == Block)) then
		if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(p2.mode, ProfileMode) ~= 0 then
			startPassiveEffectTimer()

			local ok, result = xpcall(commitHookEffectListMount, describeError, bit32.bor(Passive, HasEffect), p2)

			recordPassiveEffectDuration(p2)

			if not ok then
				error(result)
			end

			return
		end

		commitHookEffectListMount(bit32.bor(Passive, HasEffect), p2)

		return
	end

	if p2.tag ~= Profiler then
		return
	end

	commitProfilerPassiveEffect(p1, p2)
end

function invokeLayoutEffectMountInDEV(p1) --[[ invokeLayoutEffectMountInDEV | Line: 2204 | Upvalues: __DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListMount (copy), Layout (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref), ClassComponent (copy) ]]
	if __DEV__ and enableDoubleInvokingEffects then
		if p1.tag ~= FunctionComponent and (p1.tag ~= ForwardRef and (p1.tag ~= SimpleMemoComponent and p1.tag ~= Block)) then
			return
		end

		invokeGuardedCallback(nil, commitHookEffectListMount, nil, bit32.bor(Layout, HasEffect), p1)

		if not hasCaughtError() then
			return
		end

		captureCommitPhaseError(p1, p1.return_, (clearCaughtError()))
	else
		if p1.tag ~= ClassComponent then
			return
		end

		local stateNode = p1.stateNode

		invokeGuardedCallback(nil, stateNode.componentDidMount, stateNode)

		if not hasCaughtError() then
			return
		end

		captureCommitPhaseError(p1, p1.return_, (clearCaughtError()))
	end
end
function invokePassiveEffectMountInDEV(p1) --[[ invokePassiveEffectMountInDEV | Line: 2236 | Upvalues: __DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListMount (copy), Passive (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref) ]]
	if not __DEV__ or (not enableDoubleInvokingEffects or p1.tag ~= FunctionComponent and (p1.tag ~= ForwardRef and (p1.tag ~= SimpleMemoComponent and p1.tag ~= Block))) then
		return
	end

	invokeGuardedCallback(nil, commitHookEffectListMount, nil, bit32.bor(Passive, HasEffect), p1)

	if not hasCaughtError() then
		return
	end

	captureCommitPhaseError(p1, p1.return_, (clearCaughtError()))
end
function invokeLayoutEffectUnmountInDEV(p1) --[[ invokeLayoutEffectUnmountInDEV | Line: 2260 | Upvalues: __DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListUnmount (copy), Layout (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref), ClassComponent (copy) ]]
	if __DEV__ and enableDoubleInvokingEffects then
		if p1.tag ~= FunctionComponent and (p1.tag ~= ForwardRef and (p1.tag ~= SimpleMemoComponent and p1.tag ~= Block)) then
			return
		end

		invokeGuardedCallback(nil, commitHookEffectListUnmount, nil, bit32.bor(Layout, HasEffect), p1, p1.return_)

		if not hasCaughtError() then
			return
		end

		captureCommitPhaseError(p1, p1.return_, (clearCaughtError()))
	else
		if p1.tag ~= ClassComponent then
			return
		end

		local stateNode = p1.stateNode

		if typeof(stateNode.componentWillUnmount) ~= "function" then
			return
		end

		safelyCallComponentWillUnmount(p1, stateNode, p1.return_)
	end
end
function invokePassiveEffectUnmountInDEV(p1) --[[ invokePassiveEffectUnmountInDEV | Line: 2291 | Upvalues: __DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListUnmount (copy), Passive (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref) ]]
	if not __DEV__ or (not enableDoubleInvokingEffects or p1.tag ~= FunctionComponent and (p1.tag ~= ForwardRef and (p1.tag ~= SimpleMemoComponent and p1.tag ~= Block))) then
		return
	end

	invokeGuardedCallback(nil, commitHookEffectListUnmount, nil, bit32.bor(Passive, HasEffect), p1, p1.return_)

	if not hasCaughtError() then
		return
	end

	captureCommitPhaseError(p1, p1.return_, (clearCaughtError()))
end

return {
	safelyCallDestroy = safelyCallDestroy,
	commitBeforeMutationLifeCycles = commitBeforeMutationLifeCycles,
	commitResetTextContent = commitResetTextContent,
	commitPlacement = commitPlacement,
	commitDeletion = commitDeletion,
	commitWork = commitWork,
	commitAttachRef = commitAttachRef,
	commitDetachRef = commitDetachRef,
	commitPassiveUnmount = commitPassiveUnmount,
	commitPassiveUnmountInsideDeletedTree = commitPassiveUnmountInsideDeletedTree,
	commitPassiveMount = commitPassiveMount,
	invokeLayoutEffectMountInDEV = invokeLayoutEffectMountInDEV,
	invokeLayoutEffectUnmountInDEV = invokeLayoutEffectUnmountInDEV,
	invokePassiveEffectMountInDEV = invokePassiveEffectMountInDEV,
	invokePassiveEffectUnmountInDEV = invokePassiveEffectUnmountInDEV,
	isSuspenseBoundaryBeingHidden = isSuspenseBoundaryBeingHidden,
	recursivelyCommitLayoutEffects = v16
}