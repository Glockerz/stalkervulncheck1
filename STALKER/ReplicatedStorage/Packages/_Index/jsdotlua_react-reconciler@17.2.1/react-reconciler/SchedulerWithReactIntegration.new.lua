-- Decompiled with Potassium's decompiler.

local Array = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Array;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local scheduler = require(script.Parent.Parent:WaitForChild("scheduler"));
local decoupleUpdatePriorityFromScheduler = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.decoupleUpdatePriorityFromScheduler;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local SyncLanePriority = ReactFiberLane.SyncLanePriority;
local getCurrentUpdateLanePriority = ReactFiberLane.getCurrentUpdateLanePriority;
local setCurrentUpdateLanePriority = ReactFiberLane.setCurrentUpdateLanePriority;
local unstable_runWithPriority = scheduler.unstable_runWithPriority;
local unstable_scheduleCallback = scheduler.unstable_scheduleCallback;
local unstable_cancelCallback = scheduler.unstable_cancelCallback;
local unstable_shouldYield = scheduler.unstable_shouldYield;
local unstable_requestPaint = scheduler.unstable_requestPaint;
local unstable_now = scheduler.unstable_now;
local unstable_getCurrentPriorityLevel = scheduler.unstable_getCurrentPriorityLevel;
local unstable_ImmediatePriority = scheduler.unstable_ImmediatePriority;
local unstable_UserBlockingPriority = scheduler.unstable_UserBlockingPriority;
local unstable_NormalPriority = scheduler.unstable_NormalPriority;
local unstable_LowPriority = scheduler.unstable_LowPriority;
local unstable_IdlePriority = scheduler.unstable_IdlePriority;
local v1 = require(script.Parent:WaitForChild("ReactFiberSchedulerPriorities.roblox"));
local ImmediatePriority = v1.ImmediatePriority;
local UserBlockingPriority = v1.UserBlockingPriority;
local NormalPriority = v1.NormalPriority;
local LowPriority = v1.LowPriority;
local IdlePriority = v1.IdlePriority;
local NoPriority = v1.NoPriority;
local u2 = nil;
local u3 = {};
local v4 = unstable_requestPaint == nil and function() -- Line: 92
end or unstable_requestPaint;
local u5 = nil;
local u6 = nil;
local u7 = false;
local u8 = unstable_now();

function reactPriorityToSchedulerPriority(p9)
    -- upvalues: ImmediatePriority (copy), unstable_ImmediatePriority (copy), UserBlockingPriority (copy), unstable_UserBlockingPriority (copy), NormalPriority (copy), unstable_NormalPriority (copy), LowPriority (copy), unstable_LowPriority (copy), IdlePriority (copy), unstable_IdlePriority (copy), invariant (copy)
    if p9 == ImmediatePriority then
        return unstable_ImmediatePriority;
    end;

    if p9 == UserBlockingPriority then
        return unstable_UserBlockingPriority;
    end;

    if p9 == NormalPriority then
        return unstable_NormalPriority;
    end;

    if p9 == LowPriority then
        return unstable_LowPriority;
    end;

    if p9 == IdlePriority then
        return unstable_IdlePriority;
    end;

    invariant(false, "Unknown priority level.");

    return nil;
end;

local function runWithPriority(p10: any, p11: function) -- Line: 158
    -- upvalues: unstable_runWithPriority (copy)
    return unstable_runWithPriority(reactPriorityToSchedulerPriority(p10), p11);
end;

local function scheduleSyncCallback(p12: function) -- Line: 175
    -- upvalues: u5 (ref), u6 (ref), unstable_scheduleCallback (copy), unstable_ImmediatePriority (copy), u2 (ref), u3 (copy)
    if u5 == nil then
        u5 = { p12 };
        u6 = unstable_scheduleCallback(unstable_ImmediatePriority, u2);
    else
        table.insert(u5, p12);
    end;

    return u3;
end;

local function flushSyncCallbackQueue() -- Line: 200
    -- upvalues: u6 (ref), unstable_cancelCallback (copy), u2 (ref)
    if u6 ~= nil then
        local v13 = u6;
        u6 = nil;
        unstable_cancelCallback(v13);
    end;

    return u2();
end;

u2 = function() -- Line: 209
    -- upvalues: u7 (ref), u5 (ref), decoupleUpdatePriorityFromScheduler (copy), getCurrentUpdateLanePriority (copy), setCurrentUpdateLanePriority (copy), SyncLanePriority (copy), runWithPriority (copy), describeError (copy), ImmediatePriority (copy), unstable_runWithPriority (copy), Array (copy), unstable_scheduleCallback (copy), unstable_ImmediatePriority (copy), flushSyncCallbackQueue (copy)
    if u7 or u5 == nil then
        return false;
    end;

    u7 = true;
    local u14 = 1;

    if decoupleUpdatePriorityFromScheduler then
        local v15 = getCurrentUpdateLanePriority();
        local v16 = nil;
        local v17;

        if _G.__YOLO__ then
            v17 = true;
            local u18 = u5;
            setCurrentUpdateLanePriority(SyncLanePriority);

            local function v20() -- Line: 248
                -- upvalues: u18 (copy), u14 (ref)
                for i, v in u18 do
                    u14 = i;
                    local v19 = v;

                    repeat
                        v19 = v19(true);
                    until v19 == nil;

                    u14 = u14 + 1;
                end;
            end;

            unstable_runWithPriority(reactPriorityToSchedulerPriority(ImmediatePriority), v20);
            u5 = nil;
        else
            local u21 = u5;
            setCurrentUpdateLanePriority(SyncLanePriority);
            v17, v16 = xpcall(runWithPriority, describeError, ImmediatePriority, function() -- Line: 230
                -- upvalues: u21 (copy), u14 (ref)
                for i, v in u21 do
                    u14 = i;
                    local v22 = v;

                    repeat
                        v22 = v22(true);
                    until v22 == nil;
                end;
            end);
            u5 = nil;
        end;

        setCurrentUpdateLanePriority(v15);
        u7 = false;

        if not v17 then
            if u5 ~= nil then
                u5 = Array.slice(u5, u14 + 1);
            end;

            unstable_scheduleCallback(unstable_ImmediatePriority, flushSyncCallbackQueue);
            error(v16);
        end;
    else
        local v23 = nil;
        local v24;

        if _G.__YOLO__ then
            v24 = true;
            local u25 = u5;

            local function v27() -- Line: 306
                -- upvalues: u25 (copy), u14 (ref)
                for i, v in u25 do
                    u14 = i;
                    local v26 = v;

                    repeat
                        v26 = v26(true);
                    until v26 == nil;
                end;
            end;

            unstable_runWithPriority(reactPriorityToSchedulerPriority(ImmediatePriority), v27);
            u5 = nil;
        else
            local u28 = u5;
            v24, v23 = xpcall(runWithPriority, describeError, ImmediatePriority, function() -- Line: 290
                -- upvalues: u28 (copy), u14 (ref)
                for i, v in u28 do
                    u14 = i;
                    local v29 = v;

                    repeat
                        v29 = v29(true);
                    until v29 == nil;
                end;
            end);
            u5 = nil;
        end;

        u7 = false;

        if not v24 then
            if u5 ~= nil then
                u5 = Array.slice(u5, u14 + 1);
            end;

            unstable_scheduleCallback(unstable_ImmediatePriority, flushSyncCallbackQueue);
            error(v23);
        end;
    end;

    return true;
end;

return {
    ImmediatePriority = ImmediatePriority,
    UserBlockingPriority = UserBlockingPriority,
    NormalPriority = NormalPriority,
    LowPriority = LowPriority,
    IdlePriority = IdlePriority,
    NoPriority = NoPriority,

    getCurrentPriorityLevel = function() -- Line: 120, Name: getCurrentPriorityLevel
        -- upvalues: unstable_getCurrentPriorityLevel (copy), unstable_ImmediatePriority (copy), ImmediatePriority (copy), unstable_UserBlockingPriority (copy), UserBlockingPriority (copy), unstable_NormalPriority (copy), NormalPriority (copy), unstable_LowPriority (copy), LowPriority (copy), unstable_IdlePriority (copy), IdlePriority (copy), invariant (copy), NoPriority (copy)
        local v30 = unstable_getCurrentPriorityLevel();

        if v30 == unstable_ImmediatePriority then
            return ImmediatePriority;
        end;

        if v30 == unstable_UserBlockingPriority then
            return UserBlockingPriority;
        end;

        if v30 == unstable_NormalPriority then
            return NormalPriority;
        end;

        if v30 == unstable_LowPriority then
            return LowPriority;
        end;

        if v30 == unstable_IdlePriority then
            return IdlePriority;
        end;

        invariant(false, "Unknown priority level.");

        return NoPriority;
    end,

    flushSyncCallbackQueue = flushSyncCallbackQueue,
    runWithPriority = runWithPriority,

    scheduleCallback = function(p31: any, p32: function, p33: table?) -- Line: 166, Name: scheduleCallback
        -- upvalues: unstable_scheduleCallback (copy)
        return unstable_scheduleCallback(reactPriorityToSchedulerPriority(p31), p32, p33);
    end,

    scheduleSyncCallback = scheduleSyncCallback,

    cancelCallback = function(p34) -- Line: 194, Name: cancelCallback
        -- upvalues: u3 (copy), unstable_cancelCallback (copy)
        if p34 ~= u3 then
            unstable_cancelCallback(p34);
        end;
    end,

    now = function() -- Line: 116, Name: now
        -- upvalues: unstable_now (copy), u8 (copy)
        return unstable_now() - u8;
    end,

    requestPaint = v4,
    shouldYield = unstable_shouldYield
};