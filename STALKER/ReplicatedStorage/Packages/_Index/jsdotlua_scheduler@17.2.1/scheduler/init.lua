-- Decompiled with Potassium's decompiler.

local function onlyInTestError(u1: string) -- Line: 14
    return function() -- Line: 15
        -- upvalues: u1 (copy)
        error(u1 .. " is only available in tests, not in production");
    end;
end;

local v2 = require(script:WaitForChild("Scheduler"))(nil);
local Tracing = require(script:WaitForChild("Tracing"));
local TracingSubscriptions = require(script:WaitForChild("TracingSubscriptions"));

if _G.__ROACT_17_MOCK_SCHEDULER__ then
    return require(script:WaitForChild("unstable_mock"));
end;

local v3 = {
    unstable_ImmediatePriority = v2.unstable_ImmediatePriority,
    unstable_UserBlockingPriority = v2.unstable_UserBlockingPriority,
    unstable_NormalPriority = v2.unstable_NormalPriority,
    unstable_IdlePriority = v2.unstable_IdlePriority,
    unstable_LowPriority = v2.unstable_LowPriority,
    unstable_runWithPriority = v2.unstable_runWithPriority,
    unstable_next = v2.unstable_next,
    unstable_scheduleCallback = v2.unstable_scheduleCallback,
    unstable_cancelCallback = v2.unstable_cancelCallback,
    unstable_wrapCallback = v2.unstable_wrapCallback,
    unstable_getCurrentPriorityLevel = v2.unstable_getCurrentPriorityLevel,
    unstable_shouldYield = v2.unstable_shouldYield,
    unstable_requestPaint = v2.unstable_requestPaint,
    unstable_continueExecution = v2.unstable_continueExecution,
    unstable_pauseExecution = v2.unstable_pauseExecution,
    unstable_getFirstCallbackNode = v2.unstable_getFirstCallbackNode,
    unstable_now = v2.unstable_now,
    unstable_forceFrameRate = v2.unstable_forceFrameRate
};
local u4 = "unstable_flushAllWithoutAsserting";

function v3.unstable_flushAllWithoutAsserting() -- Line: 15
    -- upvalues: u4 (copy)
    error(u4 .. " is only available in tests, not in production");
end;

local u5 = "unstable_flushAll";

function v3.unstable_flushAll() -- Line: 15
    -- upvalues: u5 (copy)
    error(u5 .. " is only available in tests, not in production");
end;

local u6 = "unstable_flushNumberOfYields";

function v3.unstable_flushNumberOfYields() -- Line: 15
    -- upvalues: u6 (copy)
    error(u6 .. " is only available in tests, not in production");
end;

local u7 = "unstable_clearYields";

function v3.unstable_clearYields() -- Line: 15
    -- upvalues: u7 (copy)
    error(u7 .. " is only available in tests, not in production");
end;

local u8 = "unstable_clearYields";

function v3.unstable_flushUntilNextPaint() -- Line: 15
    -- upvalues: u8 (copy)
    error(u8 .. " is only available in tests, not in production");
end;

local u9 = "unstable_advanceTime";

function v3.unstable_advanceTime() -- Line: 15
    -- upvalues: u9 (copy)
    error(u9 .. " is only available in tests, not in production");
end;

local u10 = "unstable_flushExpired";

function v3.unstable_flushExpired() -- Line: 15
    -- upvalues: u10 (copy)
    error(u10 .. " is only available in tests, not in production");
end;

local u11 = "unstable_yieldValue";

function v3.unstable_yieldValue() -- Line: 15
    -- upvalues: u11 (copy)
    error(u11 .. " is only available in tests, not in production");
end;

local v12 = {};
local u13 = "unstable_wrap";

function v12.unstable_wrap() -- Line: 15
    -- upvalues: u13 (copy)
    error(u13 .. " is only available in tests, not in production");
end;

v12.__interactionsRef = {};
v12.__subscriberRef = {};
v3.tracing = v12;

for i, v in Tracing do
    v3.tracing[i] = v;
end;

for i, v in TracingSubscriptions do
    v3.tracing[i] = v;
end;

return v3;