-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))

require(script.Parent:WaitForChild("ReactCapturedValue"))

local v1 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"))

require(script.Parent.Parent:WaitForChild("shared"))

local v2 = require(script.Parent:WaitForChild("ReactFiberSuspenseContext.new"))
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local DidCapture = ReactFiberFlags.DidCapture
local Incomplete = ReactFiberFlags.Incomplete
local NoFlags = ReactFiberFlags.NoFlags
local ShouldCapture = ReactFiberFlags.ShouldCapture
local LifecycleEffectMask = ReactFiberFlags.LifecycleEffectMask
local ForceUpdateForLegacySuspense = ReactFiberFlags.ForceUpdateForLegacySuspense
local shouldCaptureSuspense = require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new")).shouldCaptureSuspense
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"))
local NoMode = ReactTypeOfMode.NoMode
local BlockingMode = ReactTypeOfMode.BlockingMode
local DebugTracingMode = ReactTypeOfMode.DebugTracingMode
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler
local createCapturedValue = require(script.Parent:WaitForChild("ReactCapturedValue")).createCapturedValue
local enqueueCapturedUpdate = v1.enqueueCapturedUpdate
local createUpdate = v1.createUpdate
local CaptureUpdate = v1.CaptureUpdate
local ForceUpdate = v1.ForceUpdate
local enqueueUpdate = v1.enqueueUpdate
local markFailedErrorBoundaryForHotReloading = require(script.Parent["ReactFiberHotReloading.new"]).markFailedErrorBoundaryForHotReloading
local hasSuspenseContext = v2.hasSuspenseContext
local InvisibleParentSuspenseContext = v2.InvisibleParentSuspenseContext
local suspenseStackCursor = v2.suspenseStackCursor
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil

local function f7(...) --[[ Line: 87 | Upvalues: v4 (ref), v3 (ref) ]]
	if v4 then
		return v4(...)
	end

	v3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
	v4 = v3.markLegacyErrorBoundaryAsFailed

	return v4(...)
end

local function f8(...) --[[ Line: 102 | Upvalues: v3 (ref), v6 (ref) ]]
	if v3 ~= nil then
		v6 = v3.pingSuspendedRoot

		return v6(...)
	end

	v3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
	v6 = v3.pingSuspendedRoot

	return v6(...)
end

local function f9(...) --[[ Line: 109 | Upvalues: v3 (ref), v5 (ref) ]]
	if v3 ~= nil then
		v5 = v3.isAlreadyFailedLegacyErrorBoundary

		return v5(...)
	end

	v3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
	v5 = v3.isAlreadyFailedLegacyErrorBoundary

	return v5(...)
end

local logCapturedError = require(script.Parent:WaitForChild("ReactFiberErrorLogger")).logCapturedError
local logComponentSuspended = require(script.Parent:WaitForChild("DebugTracing")).logComponentSuspended
local markComponentSuspended = require(script.Parent:WaitForChild("SchedulingProfiler")).markComponentSuspended
local SyncLane = ReactFiberLane.SyncLane
local NoTimestamp = ReactFiberLane.NoTimestamp
local includesSomeLane = ReactFiberLane.includesSomeLane
local mergeLanes = ReactFiberLane.mergeLanes
local pickArbitraryLane = ReactFiberLane.pickArbitraryLane

function createRootErrorUpdate(p1, p2, p3, p4) --[[ createRootErrorUpdate | Line: 130 | Upvalues: createUpdate (copy), NoTimestamp (copy), CaptureUpdate (copy), Object (copy), logCapturedError (copy) ]]
	local v1 = createUpdate(NoTimestamp, p3)

	v1.tag = CaptureUpdate
	v1.payload = {
		element = Object.None
	}

	local value = p2.value

	function v1.callback() --[[ Line: 144 | Upvalues: p4 (copy), value (copy), logCapturedError (ref), p1 (copy), p2 (copy) ]]
		if p4 == nil then
			logCapturedError(p1, p2)

			return
		end

		p4(value)
		logCapturedError(p1, p2)
	end

	return v1
end
function createClassErrorUpdate(p1, p2, p3) --[[ createClassErrorUpdate | Line: 153 | Upvalues: createUpdate (copy), NoTimestamp (copy), CaptureUpdate (copy), logCapturedError (copy), markFailedErrorBoundaryForHotReloading (copy), f7 (copy), includesSomeLane (copy), SyncLane (copy), console (copy), getComponentName (copy) ]]
	local v1 = createUpdate(NoTimestamp, p3)

	v1.tag = CaptureUpdate

	local getDerivedStateFromError = p1.type.getDerivedStateFromError

	if typeof(getDerivedStateFromError) == "function" then
		local value = p2.value

		function v1.payload() --[[ Line: 163 | Upvalues: logCapturedError (ref), p1 (copy), p2 (copy), getDerivedStateFromError (copy), value (copy) ]]
			logCapturedError(p1, p2)

			return getDerivedStateFromError(value)
		end
	end

	local stateNode = p1.stateNode

	if stateNode ~= nil and typeof(stateNode.componentDidCatch) == "function" then
		function v1.callback() --[[ Line: 171 | Upvalues: markFailedErrorBoundaryForHotReloading (ref), p1 (copy), getDerivedStateFromError (copy), f7 (ref), stateNode (copy), logCapturedError (ref), p2 (copy), includesSomeLane (ref), SyncLane (ref), console (ref), getComponentName (ref) ]]
			if _G.__DEV__ then
				markFailedErrorBoundaryForHotReloading(p1)
			end

			if typeof(getDerivedStateFromError) ~= "function" then
				f7(stateNode)
				logCapturedError(p1, p2)
			end

			stateNode:componentDidCatch(p2.value, {
				componentStack = p2.stack or ""
			})

			if not _G.__DEV__ then
				return
			end

			if typeof(getDerivedStateFromError) == "function" or includesSomeLane(p1.lanes, SyncLane) then
				return
			end

			console.error("%s: Error boundaries should implement getDerivedStateFromError(). In that method, return a state update to display an error message or fallback UI.", getComponentName(p1.type) or "Unknown")
		end

		return v1
	end

	if _G.__DEV__ then
		function v1.callback() --[[ Line: 209 | Upvalues: markFailedErrorBoundaryForHotReloading (ref), p1 (copy) ]]
			markFailedErrorBoundaryForHotReloading(p1)
		end
	end

	return v1
end

local function attachPingListener(p1, p2, p3) --[[ attachPingListener | Line: 216 | Upvalues: f8 (copy) ]]
	local pingCache = p1.pingCache
	local v1

	if pingCache == nil then
		v1 = {}
		p1.pingCache = {
			[p2] = v1
		}

		local pingCache2 = p1.pingCache
	else
		v1 = pingCache[p2]

		if v1 == nil then
			v1 = {}
			pingCache[p2] = v1
		end
	end

	if v1[p3] then
		return
	end

	v1[p3] = true

	local function f2() --[[ Line: 244 | Upvalues: f8 (ref), p1 (copy), p2 (copy), p3 (copy) ]]
		return f8(p1, p2, p3)
	end

	p2:andThen(f2, f2)
end

function throwException(p1, p2, p3, p4, p5, p6, p7) --[[ throwException | Line: 251 | Upvalues: Incomplete (copy), enableDebugTracing (copy), DebugTracingMode (copy), getComponentName (copy), logComponentSuspended (copy), enableSchedulingProfiler (copy), markComponentSuspended (copy), BlockingMode (copy), NoMode (copy), hasSuspenseContext (copy), suspenseStackCursor (copy), InvisibleParentSuspenseContext (copy), SuspenseComponent (copy), shouldCaptureSuspense (copy), DidCapture (copy), ForceUpdateForLegacySuspense (copy), LifecycleEffectMask (copy), ClassComponent (copy), IncompleteClassComponent (copy), createUpdate (copy), NoTimestamp (copy), SyncLane (copy), ForceUpdate (copy), enqueueUpdate (copy), mergeLanes (copy), attachPingListener (copy), ShouldCapture (copy), createCapturedValue (copy), HostRoot (copy), pickArbitraryLane (copy), enqueueCapturedUpdate (copy), NoFlags (copy), f9 (copy) ]]
	p3.flags = bit32.bor(p3.flags, Incomplete)

	if p4 ~= nil and typeof(p4) == "table" and typeof(p4.andThen) == "function" then
		if _G.__DEV__ and enableDebugTracing and bit32.band(p3.mode, DebugTracingMode) ~= 0 then
			logComponentSuspended(getComponentName(p3.type) or "Unknown", p4)
		end

		local v3 = p4

		if enableSchedulingProfiler then
			markComponentSuspended(p3, v3)
		end

		if bit32.band(p3.mode, BlockingMode) == NoMode then
			local alternate = p3.alternate

			if alternate then
				p3.updateQueue = alternate.updateQueue
				p3.memoizedState = alternate.memoizedState
				p3.lanes = alternate.lanes
			else
				p3.updateQueue = nil
				p3.memoizedState = nil
			end
		end

		local v5 = hasSuspenseContext(suspenseStackCursor.current, InvisibleParentSuspenseContext)
		local v6 = p2

		repeat
			if v6.tag == SuspenseComponent and shouldCaptureSuspense(v6, v5) then
				local updateQueue = v6.updateQueue

				if updateQueue == nil then
					v6.updateQueue = {
						[v3] = true
					}
				else
					updateQueue[v3] = true
				end

				if bit32.band(v6.mode, BlockingMode) ~= NoMode then
					attachPingListener(p1, v3, p5)
					v6.flags = bit32.bor(v6.flags, ShouldCapture)
					v6.lanes = p5

					return
				end

				v6.flags = bit32.bor(v6.flags, DidCapture)
				p3.flags = bit32.bor(p3.flags, ForceUpdateForLegacySuspense)
				p3.flags = bit32.band(p3.flags, (bit32.bnot((bit32.bor(LifecycleEffectMask, Incomplete)))))

				if p3.tag == ClassComponent then
					if p3.alternate == nil then
						p3.tag = IncompleteClassComponent
					else
						local v15 = createUpdate(NoTimestamp, SyncLane)

						v15.tag = ForceUpdate
						enqueueUpdate(p3, v15)
					end
				end

				p3.lanes = mergeLanes(p3.lanes, SyncLane)

				return
			end

			v6 = v6.return_
		until v6 == nil

		p4 = (getComponentName(p3.type) or "A React component") .. " suspended while rendering, but no fallback UI was specified.\n\nAdd a <Suspense fallback=...> component higher in the tree to provide a loading indicator or placeholder to display."
	end

	p7()

	local v17, v18 = p2, createCapturedValue(p4, p3)

	repeat
		if v17.tag == HostRoot then
			v17.flags = bit32.bor(v17.flags, ShouldCapture)

			local v20 = pickArbitraryLane(p5)

			v17.lanes = mergeLanes(v17.lanes, v20)
			enqueueCapturedUpdate(v17, (createRootErrorUpdate(v17, v18, v20, p6)))

			return
		end

		if v17.tag == ClassComponent then
			local v21 = v17.type
			local stateNode = v17.stateNode

			if bit32.band(v17.flags, DidCapture) == NoFlags then
				local v23, v24, v25

				if typeof(v21.getDerivedStateFromError) == "function" then
					v23 = v17.flags
					v24 = ShouldCapture
					v17.flags = bit32.bor(v23, ShouldCapture)
					v25 = pickArbitraryLane(p5)
					v17.lanes = mergeLanes(v17.lanes, v25)
					enqueueCapturedUpdate(v17, (createClassErrorUpdate(v17, v18, v25)))

					return
				end

				if stateNode ~= nil and (typeof(stateNode.componentDidCatch) == "function" and not f9(stateNode)) then
					v23 = v17.flags
					v24 = ShouldCapture
					v17.flags = bit32.bor(v23, ShouldCapture)
					v25 = pickArbitraryLane(p5)
					v17.lanes = mergeLanes(v17.lanes, v25)
					enqueueCapturedUpdate(v17, (createClassErrorUpdate(v17, v18, v25)))

					return
				end
			end
		end

		v17 = v17.return_
	until v17 == nil
end

return {
	throwException = throwException,
	createRootErrorUpdate = createRootErrorUpdate,
	createClassErrorUpdate = createClassErrorUpdate
}