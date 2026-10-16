-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local u1 = {};
require(script.Parent:WaitForChild("SchedulerPriorities"));
local enableProfiling = require(script.Parent:WaitForChild("SchedulerFeatureFlags")).enableProfiling;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local u5 = nil;
local u6 = nil;
local u7 = 1;

local function logEvent(p8) -- Line: 45
    -- upvalues: u6 (ref), u7 (ref), u4 (ref), console (copy), u1 (copy), u5 (ref)
    if u6 ~= nil then
        u7 = u7 + #p8;

        if u4 < u7 + 1 then
            u4 = u4 * 2;

            if u4 > 524288 then
                console.error("Scheduler Profiling: Event log exceeded maximum size. Don\'t forget to call `stopLoggingProfilingEvents()`.");
                u1.stopLoggingProfilingEvents();

                return;
            end;

            local v9 = {};
            table.insert(v9, u6);
            u5 = v9;
            u6 = v9;
        end;

        table.insert(u6, p8);
    end;
end;

function u1.startLoggingProfilingEvents() -- Line: 69
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), u7 (ref)
    u4 = 131072;
    u5 = {};
    u6 = u5;
    u7 = 1;
end;

function u1.stopLoggingProfilingEvents() -- Line: 76
    -- upvalues: u5 (ref), u4 (ref), u6 (ref), u7 (ref)
    local v10 = u5;
    u4 = 0;
    u5 = nil;
    u6 = nil;
    u7 = 1;

    return v10;
end;

function u1.markTaskStart(p11: any, p12: number) -- Line: 86
    -- upvalues: enableProfiling (copy), u6 (ref), logEvent (copy)
    if enableProfiling and u6 ~= nil then
        logEvent({
            1,
            p12 * 1000,
            p11.id,
            p11.priorityLevel
        });
    end;
end;

function u1.markTaskCompleted(p13: any, p14: number) -- Line: 97
    -- upvalues: enableProfiling (copy), u6 (ref), logEvent (copy)
    if enableProfiling and u6 ~= nil then
        logEvent({ 2, p14 * 1000, p13.id });
    end;
end;

function u1.markTaskCanceled(p15: any, p16: number) -- Line: 108
    -- upvalues: enableProfiling (copy), u6 (ref), logEvent (copy)
    if enableProfiling and u6 ~= nil then
        logEvent({ 4, p16 * 1000, p15.id });
    end;
end;

function u1.markTaskErrored(p17: any, p18: number) -- Line: 116
    -- upvalues: enableProfiling (copy), u6 (ref), logEvent (copy)
    if enableProfiling and u6 ~= nil then
        logEvent({ 3, p18 * 1000, p17.id });
    end;
end;

function u1.markTaskRun(p19: any, p20: number) -- Line: 124
    -- upvalues: enableProfiling (copy), u2 (ref), u6 (ref), logEvent (copy)
    if enableProfiling then
        u2 = u2 + 1;

        if u6 ~= nil then
            logEvent({
                5,
                p20 * 1000,
                p19.id,
                u2
            });
        end;
    end;
end;

function u1.markTaskYield(p21: any, p22: number) -- Line: 134
    -- upvalues: enableProfiling (copy), u6 (ref), logEvent (copy), u2 (ref)
    if enableProfiling and u6 ~= nil then
        logEvent({
            6,
            p22 * 1000,
            p21.id,
            u2
        });
    end;
end;

function u1.markSchedulerSuspended(p23: number) -- Line: 142
    -- upvalues: enableProfiling (copy), u3 (ref), u6 (ref), logEvent (copy)
    if enableProfiling then
        u3 = u3 + 1;

        if u6 ~= nil then
            logEvent({ 7, p23 * 1000, u3 });
        end;
    end;
end;

function u1.markSchedulerUnsuspended(p24: number) -- Line: 152
    -- upvalues: enableProfiling (copy), u6 (ref), logEvent (copy), u3 (ref)
    if enableProfiling and u6 ~= nil then
        logEvent({ 8, p24 * 1000, u3 });
    end;
end;

return u1;