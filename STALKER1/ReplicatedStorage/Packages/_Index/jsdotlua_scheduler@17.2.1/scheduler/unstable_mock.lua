-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Tracing = require(script.Parent:WaitForChild("Tracing"))
local TracingSubscriptions = require(script.Parent:WaitForChild("TracingSubscriptions"))
local Scheduler = require(script.Parent:WaitForChild("Scheduler"))
local v1 = require(script.Parent:WaitForChild("forks"):WaitForChild("SchedulerHostConfig.mock"))
local v2 = Scheduler(v1)
local t = {
	tracing = {}
}

for v3, v4 in v2 do
	t[v3] = v4
end

for v5, v6 in Tracing do
	t.tracing[v5] = v6
end

for v7, v8 in TracingSubscriptions do
	t.tracing[v7] = v8
end

t.unstable_flushAllWithoutAsserting = v1.unstable_flushAllWithoutAsserting
t.unstable_flushNumberOfYields = v1.unstable_flushNumberOfYields
t.unstable_flushExpired = v1.unstable_flushExpired
t.unstable_clearYields = v1.unstable_clearYields
t.unstable_flushUntilNextPaint = v1.unstable_flushUntilNextPaint
t.unstable_flushAll = v1.unstable_flushAll
t.unstable_yieldValue = v1.unstable_yieldValue
t.unstable_advanceTime = v1.unstable_advanceTime
t.unstable_Profiling = v2.unstable_Profiling

return t