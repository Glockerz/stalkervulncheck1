-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Array = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Array

require(script.Parent:WaitForChild("ReactInternalTypes"))

local scheduler = require(script.Parent.Parent:WaitForChild("scheduler"))
local decoupleUpdatePriorityFromScheduler = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.decoupleUpdatePriorityFromScheduler
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))
local SyncLanePriority = ReactFiberLane.SyncLanePriority
local getCurrentUpdateLanePriority = ReactFiberLane.getCurrentUpdateLanePriority
local setCurrentUpdateLanePriority = ReactFiberLane.setCurrentUpdateLanePriority
local unstable_runWithPriority = scheduler.unstable_runWithPriority
local unstable_scheduleCallback = scheduler.unstable_scheduleCallback
local unstable_cancelCallback = scheduler.unstable_cancelCallback
local unstable_requestPaint = scheduler.unstable_requestPaint
local unstable_now = scheduler.unstable_now
local unstable_getCurrentPriorityLevel = scheduler.unstable_getCurrentPriorityLevel
local unstable_ImmediatePriority = scheduler.unstable_ImmediatePriority
local unstable_UserBlockingPriority = scheduler.unstable_UserBlockingPriority
local unstable_NormalPriority = scheduler.unstable_NormalPriority
local unstable_LowPriority = scheduler.unstable_LowPriority
local unstable_IdlePriority = scheduler.unstable_IdlePriority
local v1 = require(script.Parent:WaitForChild("ReactFiberSchedulerPriorities.roblox"))
local ImmediatePriority = v1.ImmediatePriority
local UserBlockingPriority = v1.UserBlockingPriority
local NormalPriority = v1.NormalPriority
local LowPriority = v1.LowPriority
local IdlePriority = v1.IdlePriority
local NoPriority = v1.NoPriority
local v2 = nil
local t = {}
local v4 = nil
local v5 = nil
local v6 = false
local v7 = unstable_now()

local function now() --[[ now | Line: 116 | Upvalues: unstable_now (copy), v7 (copy) ]]
	return unstable_now() - v7
end

local function getCurrentPriorityLevel() --[[ getCurrentPriorityLevel | Line: 120 | Upvalues: unstable_getCurrentPriorityLevel (copy), unstable_ImmediatePriority (copy), ImmediatePriority (copy), unstable_UserBlockingPriority (copy), UserBlockingPriority (copy), unstable_NormalPriority (copy), NormalPriority (copy), unstable_LowPriority (copy), LowPriority (copy), unstable_IdlePriority (copy), IdlePriority (copy), invariant (copy), NoPriority (copy) ]]
	local v1 = unstable_getCurrentPriorityLevel()

	if v1 == unstable_ImmediatePriority then
		return ImmediatePriority
	end

	if v1 == unstable_UserBlockingPriority then
		return UserBlockingPriority
	end

	if v1 == unstable_NormalPriority then
		return NormalPriority
	end

	if v1 == unstable_LowPriority then
		return LowPriority
	end

	if v1 == unstable_IdlePriority then
		return IdlePriority
	end

	invariant(false, "Unknown priority level.")

	return NoPriority
end

function reactPriorityToSchedulerPriority(p1) --[[ reactPriorityToSchedulerPriority | Line: 139 | Upvalues: ImmediatePriority (copy), unstable_ImmediatePriority (copy), UserBlockingPriority (copy), unstable_UserBlockingPriority (copy), NormalPriority (copy), unstable_NormalPriority (copy), LowPriority (copy), unstable_LowPriority (copy), IdlePriority (copy), unstable_IdlePriority (copy), invariant (copy) ]]
	if p1 == ImmediatePriority then
		return unstable_ImmediatePriority
	end

	if p1 == UserBlockingPriority then
		return unstable_UserBlockingPriority
	end

	if p1 == NormalPriority then
		return unstable_NormalPriority
	end

	if p1 == LowPriority then
		return unstable_LowPriority
	end

	if p1 == IdlePriority then
		return unstable_IdlePriority
	end

	invariant(false, "Unknown priority level.")

	return nil
end

local function runWithPriority(p1, p2) --[[ runWithPriority | Line: 158 | Upvalues: unstable_runWithPriority (copy) ]]
	return unstable_runWithPriority(reactPriorityToSchedulerPriority(p1), p2)
end

local function scheduleCallback(p1, p2, p3) --[[ scheduleCallback | Line: 166 | Upvalues: unstable_scheduleCallback (copy) ]]
	return unstable_scheduleCallback(reactPriorityToSchedulerPriority(p1), p2, p3)
end

local function scheduleSyncCallback(p1) --[[ scheduleSyncCallback | Line: 175 | Upvalues: v4 (ref), v5 (ref), unstable_scheduleCallback (copy), unstable_ImmediatePriority (copy), v2 (ref), t (copy) ]]
	if v4 == nil then
		v4 = { p1 }
		v5 = unstable_scheduleCallback(unstable_ImmediatePriority, v2)
	else
		table.insert(v4, p1)
	end

	return t
end

local function cancelCallback(p1) --[[ cancelCallback | Line: 194 | Upvalues: t (copy), unstable_cancelCallback (copy) ]]
	if p1 == t then
		return
	end

	unstable_cancelCallback(p1)
end

local function flushSyncCallbackQueue() --[[ flushSyncCallbackQueue | Line: 200 | Upvalues: v5 (ref), unstable_cancelCallback (copy), v2 (ref) ]]
	if v5 == nil then
		return v2()
	end

	local v1 = v5

	v5 = nil
	unstable_cancelCallback(v1)

	return v2()
end

return {
	ImmediatePriority = ImmediatePriority,
	UserBlockingPriority = UserBlockingPriority,
	NormalPriority = NormalPriority,
	LowPriority = LowPriority,
	IdlePriority = IdlePriority,
	NoPriority = NoPriority,
	getCurrentPriorityLevel = getCurrentPriorityLevel,
	flushSyncCallbackQueue = flushSyncCallbackQueue,
	runWithPriority = runWithPriority,
	scheduleCallback = scheduleCallback,
	scheduleSyncCallback = scheduleSyncCallback,
	cancelCallback = cancelCallback,
	now = now,
	requestPaint = if unstable_requestPaint == nil then function() --[[ Line: 92 ]] end else unstable_requestPaint,
	shouldYield = scheduler.unstable_shouldYield
}