-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Scheduler = require(script:WaitForChild("Scheduler"))

local function onlyInTestError(p1) --[[ onlyInTestError | Line: 14 ]]
	return function() --[[ Line: 15 | Upvalues: p1 (copy) ]]
		error(p1 .. " is only available in tests, not in production")
	end
end

local v1 = Scheduler(nil)
local Tracing = require(script:WaitForChild("Tracing"))
local TracingSubscriptions = require(script:WaitForChild("TracingSubscriptions"))

if _G.__ROACT_17_MOCK_SCHEDULER__ then
	return require(script:WaitForChild("unstable_mock"))
end

local t = {
	unstable_ImmediatePriority = v1.unstable_ImmediatePriority,
	unstable_UserBlockingPriority = v1.unstable_UserBlockingPriority,
	unstable_NormalPriority = v1.unstable_NormalPriority,
	unstable_IdlePriority = v1.unstable_IdlePriority,
	unstable_LowPriority = v1.unstable_LowPriority,
	unstable_runWithPriority = v1.unstable_runWithPriority,
	unstable_next = v1.unstable_next,
	unstable_scheduleCallback = v1.unstable_scheduleCallback,
	unstable_cancelCallback = v1.unstable_cancelCallback,
	unstable_wrapCallback = v1.unstable_wrapCallback,
	unstable_getCurrentPriorityLevel = v1.unstable_getCurrentPriorityLevel,
	unstable_shouldYield = v1.unstable_shouldYield,
	unstable_requestPaint = v1.unstable_requestPaint,
	unstable_continueExecution = v1.unstable_continueExecution,
	unstable_pauseExecution = v1.unstable_pauseExecution,
	unstable_getFirstCallbackNode = v1.unstable_getFirstCallbackNode,
	unstable_now = v1.unstable_now,
	unstable_forceFrameRate = v1.unstable_forceFrameRate
}
local v2 = "unstable_flushAllWithoutAsserting"

function t.unstable_flushAllWithoutAsserting() --[[ Line: 15 | Upvalues: v2 (copy) ]]
	error(v2 .. " is only available in tests, not in production")
end

local v3 = "unstable_flushAll"

function t.unstable_flushAll() --[[ Line: 15 | Upvalues: v3 (copy) ]]
	error(v3 .. " is only available in tests, not in production")
end

local v4 = "unstable_flushNumberOfYields"

function t.unstable_flushNumberOfYields() --[[ Line: 15 | Upvalues: v4 (copy) ]]
	error(v4 .. " is only available in tests, not in production")
end

local v5 = "unstable_clearYields"

function t.unstable_clearYields() --[[ Line: 15 | Upvalues: v5 (copy) ]]
	error(v5 .. " is only available in tests, not in production")
end

local v6 = "unstable_clearYields"

function t.unstable_flushUntilNextPaint() --[[ Line: 15 | Upvalues: v6 (copy) ]]
	error(v6 .. " is only available in tests, not in production")
end

local v7 = "unstable_advanceTime"

function t.unstable_advanceTime() --[[ Line: 15 | Upvalues: v7 (copy) ]]
	error(v7 .. " is only available in tests, not in production")
end

local v8 = "unstable_flushExpired"

function t.unstable_flushExpired() --[[ Line: 15 | Upvalues: v8 (copy) ]]
	error(v8 .. " is only available in tests, not in production")
end

local v9 = "unstable_yieldValue"

function t.unstable_yieldValue() --[[ Line: 15 | Upvalues: v9 (copy) ]]
	error(v9 .. " is only available in tests, not in production")
end

local t2 = {}
local v10 = "unstable_wrap"

function t2.unstable_wrap() --[[ Line: 15 | Upvalues: v10 (copy) ]]
	error(v10 .. " is only available in tests, not in production")
end
t2.__interactionsRef = {}
t2.__subscriberRef = {}
t.tracing = t2

for v11, v12 in Tracing do
	t.tracing[v11] = v12
end

for v13, v14 in TracingSubscriptions do
	t.tracing[v13] = v14
end

return t