-- Decompiled with Potassium's decompiler.

local Tracing = require(script.Parent:WaitForChild("Tracing"));
local TracingSubscriptions = require(script.Parent:WaitForChild("TracingSubscriptions"));
local Scheduler = require(script.Parent:WaitForChild("Scheduler"));
local v1 = require(script.Parent:WaitForChild("forks"):WaitForChild("SchedulerHostConfig.mock"));
local v2 = Scheduler(v1);
local v3 = {
    tracing = {}
};

for i, v in v2 do
    v3[i] = v;
end;

for i, v in Tracing do
    v3.tracing[i] = v;
end;

for i, v in TracingSubscriptions do
    v3.tracing[i] = v;
end;

v3.unstable_flushAllWithoutAsserting = v1.unstable_flushAllWithoutAsserting;
v3.unstable_flushNumberOfYields = v1.unstable_flushNumberOfYields;
v3.unstable_flushExpired = v1.unstable_flushExpired;
v3.unstable_clearYields = v1.unstable_clearYields;
v3.unstable_flushUntilNextPaint = v1.unstable_flushUntilNextPaint;
v3.unstable_flushAll = v1.unstable_flushAll;
v3.unstable_yieldValue = v1.unstable_yieldValue;
v3.unstable_advanceTime = v1.unstable_advanceTime;
v3.unstable_Profiling = v2.unstable_Profiling;

return v3;