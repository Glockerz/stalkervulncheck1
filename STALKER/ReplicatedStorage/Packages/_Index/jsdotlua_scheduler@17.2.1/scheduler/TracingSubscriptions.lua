-- Decompiled with Potassium's decompiler.

local v1 = {};
local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object;
local Tracing = require(script.Parent:WaitForChild("Tracing"));
local enableSchedulerTracing = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSchedulerTracing;
local __subscriberRef = Tracing.__subscriberRef;
local u2 = {};

function v1.unstable_subscribe(p3) -- Line: 29
    -- upvalues: enableSchedulerTracing (copy), u2 (ref), Object (copy), __subscriberRef (copy)
    if enableSchedulerTracing then
        u2[p3] = true;

        if #Object.keys(u2) == 1 then
            __subscriberRef.current = {
                onInteractionScheduledWorkCompleted = onInteractionScheduledWorkCompleted,
                onInteractionTraced = onInteractionTraced,
                onWorkCanceled = onWorkCanceled,
                onWorkScheduled = onWorkScheduled,
                onWorkStarted = onWorkStarted,
                onWorkStopped = onWorkStopped
            };
        end;
    end;
end;

function v1.unstable_unsubscribe(p4) -- Line: 46
    -- upvalues: enableSchedulerTracing (copy), u2 (ref), Object (copy), __subscriberRef (copy)
    if enableSchedulerTracing then
        u2[p4] = nil;

        if #Object.keys(u2) == 0 then
            __subscriberRef.current = nil;
        end;
    end;
end;

function onInteractionTraced(p5)
    -- upvalues: u2 (ref)
    local v6 = false;
    local v7 = nil;

    for i, _ in u2 do
        local success, result = pcall(i.onInteractionTraced, p5);

        if not (success or v6) then
            v7 = result;
            v6 = true;
        end;
    end;

    if v6 then
        error(v7);
    end;
end;

function onInteractionScheduledWorkCompleted(p8)
    -- upvalues: u2 (ref)
    local v9 = false;
    local v10 = nil;

    for i, _ in u2 do
        local success, result = pcall(i.onInteractionScheduledWorkCompleted, p8);

        if not (success or v9) then
            v10 = result;
            v9 = true;
        end;
    end;

    if v9 then
        error(v10);
    end;
end;

function onWorkScheduled(p11: table, p12: number)
    -- upvalues: u2 (ref)
    local v13 = false;
    local v14 = nil;

    for i, _ in u2 do
        local success, result = pcall(i.onWorkScheduled, p11, p12);

        if not (success or v13) then
            v14 = result;
            v13 = true;
        end;
    end;

    if v13 then
        error(v14);
    end;
end;

function onWorkStarted(p15: table, p16: number)
    -- upvalues: u2 (ref)
    local v17 = false;
    local v18 = nil;

    for i, _ in u2 do
        local success, result = pcall(i.onWorkStarted, p15, p16);

        if not (success or v17) then
            v18 = result;
            v17 = true;
        end;
    end;

    if v17 then
        error(v18);
    end;
end;

function onWorkStopped(p19: table, p20: number)
    -- upvalues: u2 (ref)
    local v21 = false;
    local v22 = nil;

    for i, _ in u2 do
        local success, result = pcall(i.onWorkStopped, p19, p20);

        if not (success or v21) then
            v22 = result;
            v21 = true;
        end;
    end;

    if v21 then
        error(v22);
    end;
end;

function onWorkCanceled(p23: table, p24: number)
    -- upvalues: u2 (ref)
    local v25 = false;
    local v26 = nil;

    for i, _ in u2 do
        local success, result = pcall(i.onWorkCanceled, p23, p24);

        if not (success or v25) then
            v26 = result;
            v25 = true;
        end;
    end;

    if v25 then
        error(v26);
    end;
end;

return v1;