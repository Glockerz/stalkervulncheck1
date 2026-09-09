-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Set = v1.Set
local Map = v1.Map

require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactRootTags = require(script.Parent:WaitForChild("ReactRootTags"))
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"))
local noTimeout = ReactFiberHostConfig.noTimeout
local supportsHydration = ReactFiberHostConfig.supportsHydration
local createHostRootFiber = require(script.Parent:WaitForChild("ReactFiber.new")).createHostRootFiber
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))
local NoLanes = ReactFiberLane.NoLanes
local NoLanePriority = ReactFiberLane.NoLanePriority
local NoTimestamp = ReactFiberLane.NoTimestamp
local createLaneMap = ReactFiberLane.createLaneMap
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback
local unstable_getThreadID = require(script.Parent.Parent:WaitForChild("scheduler")).tracing.unstable_getThreadID
local initializeUpdateQueue = require(script.Parent:WaitForChild("ReactUpdateQueue.new")).initializeUpdateQueue
local LegacyRoot = ReactRootTags.LegacyRoot
local BlockingRoot = ReactRootTags.BlockingRoot
local ConcurrentRoot = ReactRootTags.ConcurrentRoot
local t = {}

local function FiberRootNode(p1, p2, p3) --[[ FiberRootNode | Line: 47 | Upvalues: noTimeout (copy), NoLanePriority (copy), createLaneMap (copy), NoLanes (copy), NoTimestamp (copy), supportsHydration (copy), enableSchedulerTracing (copy), unstable_getThreadID (copy), Set (copy), Map (copy), enableSuspenseCallback (copy), BlockingRoot (copy), ConcurrentRoot (copy), LegacyRoot (copy) ]]
	local t = {
		pendingChildren = nil,
		current = nil,
		pingCache = nil,
		finishedWork = nil,
		context = nil,
		pendingContext = nil,
		callbackNode = nil,
		tag = p2,
		containerInfo = p1,
		timeoutHandle = noTimeout,
		hydrate = p3,
		callbackPriority = NoLanePriority,
		eventTimes = createLaneMap(NoLanes),
		expirationTimes = createLaneMap(NoTimestamp),
		pendingLanes = NoLanes,
		suspendedLanes = NoLanes,
		pingedLanes = NoLanes,
		expiredLanes = NoLanes,
		mutableReadLanes = NoLanes,
		finishedLanes = NoLanes,
		entangledLanes = NoLanes,
		entanglements = createLaneMap(NoLanes)
	}

	if supportsHydration then
		t.mutableSourceEagerHydrationData = nil
	end

	if enableSchedulerTracing then
		t.interactionThreadID = unstable_getThreadID()
		t.memoizedInteractions = Set.new()
		t.pendingInteractionMap = Map.new()
	end

	if enableSuspenseCallback then
		t.hydrationCallbacks = nil
	end

	if _G.__DEV__ then
		if p2 == BlockingRoot then
			t._debugRootType = "createBlockingRoot()"

			return t
		end

		if p2 == ConcurrentRoot then
			t._debugRootType = "createRoot()"

			return t
		end

		if p2 == LegacyRoot then
			t._debugRootType = "createLegacyRoot()"
		end
	end

	return t
end

function t.createFiberRoot(p1, p2, p3, p4) --[[ Line: 103 | Upvalues: FiberRootNode (copy), enableSuspenseCallback (copy), createHostRootFiber (copy), initializeUpdateQueue (copy) ]]
	local v1 = FiberRootNode(p1, p2, p3)

	if enableSuspenseCallback then
		v1.hydrationCallbacks = p4
	end

	local v2 = createHostRootFiber(p2)

	v1.current = v2
	v2.stateNode = v1
	initializeUpdateQueue(v2)

	return v1
end

return t