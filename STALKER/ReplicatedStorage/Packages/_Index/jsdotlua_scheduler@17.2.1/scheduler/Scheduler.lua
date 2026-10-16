-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 12
    local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
    local SchedulerFeatureFlags = require(script.Parent:WaitForChild("SchedulerFeatureFlags"));
    local enableSchedulerDebugging = SchedulerFeatureFlags.enableSchedulerDebugging;
    local enableProfiling = SchedulerFeatureFlags.enableProfiling;
    local v2 = p1 or require(script.Parent:WaitForChild("SchedulerHostConfig"));
    local requestHostCallback = v2.requestHostCallback;
    local requestHostTimeout = v2.requestHostTimeout;
    local cancelHostTimeout = v2.cancelHostTimeout;
    local shouldYieldToHost = v2.shouldYieldToHost;
    local getCurrentTime = v2.getCurrentTime;
    local forceFrameRate = v2.forceFrameRate;
    local requestPaint = v2.requestPaint;
    local u3 = nil;
    local u4 = nil;
    local u5 = nil;

    local function _(p6: table, p7: table) -- Line: 42
        -- upvalues: u4 (ref)
        local v8 = #p6 + 1;
        p6[v8] = p7;
        u4(p6, p7, v8);
    end;

    local function _(p9: table) -- Line: 49
        return p9[1];
    end;

    local function _(p10: table) -- Line: 53
        -- upvalues: u5 (ref)
        local v11 = p10[1];

        if v11 == nil then
            return nil;
        end;

        local v12 = p10[#p10];
        p10[#p10] = nil;

        if v12 ~= v11 then
            p10[1] = v12;
            u5(p10, v12, 1);
        end;

        return v11;
    end;

    u4 = function(p13: table, p14: table, p15: number) -- Line: 69
        -- upvalues: u3 (ref)
        while true do
            local math_floor_ret = math.floor(p15 / 2);
            local v16 = p13[math_floor_ret];

            if v16 == nil or u3(v16, p14) <= 0 then
                break;
            end;

            p13[math_floor_ret] = p14;
            p13[p15] = v16;
            p15 = math_floor_ret;
        end;
    end;

    u5 = function(p17: table, p18: table, p19: number) -- Line: 85
        -- upvalues: u3 (ref)
        while p19 < #p17 do
            local v20 = p19 * 2;
            local v21 = p17[v20];
            local v22 = v20 + 1;
            local v23 = p17[v22];

            if v21 == nil or u3(v21, p18) >= 0 then
                if v23 == nil or u3(v23, p18) >= 0 then
                    return;
                end;

                p17[p19] = v23;
                p17[v22] = p18;
            elseif v23 == nil or u3(v23, v21) >= 0 then
                p17[p19] = v21;
                p17[v20] = p18;
                v22 = v20;
            else
                p17[p19] = v23;
                p17[v22] = p18;
            end;

            p19 = v22;
        end;
    end;

    u3 = function(p24: table, p25: table) -- Line: 115
        local v26 = p24.sortIndex - p25.sortIndex;

        if v26 == 0 then
            return p24.id - p25.id;
        end;

        return v26;
    end;

    local SchedulerPriorities = require(script.Parent:WaitForChild("SchedulerPriorities"));
    local ImmediatePriority = SchedulerPriorities.ImmediatePriority;
    local UserBlockingPriority = SchedulerPriorities.UserBlockingPriority;
    local NormalPriority = SchedulerPriorities.NormalPriority;
    local LowPriority = SchedulerPriorities.LowPriority;
    local IdlePriority = SchedulerPriorities.IdlePriority;
    local SchedulerProfiling = require(script.Parent:WaitForChild("SchedulerProfiling"));
    local markTaskRun = SchedulerProfiling.markTaskRun;
    local markTaskYield = SchedulerProfiling.markTaskYield;
    local markTaskCompleted = SchedulerProfiling.markTaskCompleted;
    local markTaskCanceled = SchedulerProfiling.markTaskCanceled;
    local markTaskErrored = SchedulerProfiling.markTaskErrored;
    local markSchedulerSuspended = SchedulerProfiling.markSchedulerSuspended;
    local markSchedulerUnsuspended = SchedulerProfiling.markSchedulerUnsuspended;
    local markTaskStart = SchedulerProfiling.markTaskStart;
    local u27 = {};
    local u28 = {};
    local u29 = 1;
    local u30 = false;
    local u31 = nil;
    local u32 = NormalPriority;
    local u33 = false;
    local u34 = false;
    local u35 = false;
    local u36 = nil;
    local u37 = nil;

    local function advanceTimers(p38) -- Line: 182
        -- upvalues: u28 (copy), u5 (ref), u27 (copy), u4 (ref), enableProfiling (copy), markTaskStart (copy)
        local v39 = u28[1];

        while v39 ~= nil do
            if v39.callback == nil then
                local v40 = u28;
                local v41 = v40[1];

                if v41 ~= nil then
                    local v42 = v40[#v40];
                    v40[#v40] = nil;

                    if v42 ~= v41 then
                        v40[1] = v42;
                        u5(v40, v42, 1);
                    end;
                end;
            else
                if v39.startTime > p38 then
                    return;
                end;

                local v43 = u28;
                local v44 = v43[1];

                if v44 ~= nil then
                    local v45 = v43[#v43];
                    v43[#v43] = nil;

                    if v45 ~= v44 then
                        v43[1] = v45;
                        u5(v43, v45, 1);
                    end;
                end;

                v39.sortIndex = v39.expirationTime;
                local v46 = u27;
                local v47 = #v46 + 1;
                v46[v47] = v39;
                u4(v46, v39, v47);

                if enableProfiling then
                    markTaskStart(v39, p38);
                    v39.isQueued = true;
                end;
            end;

            v39 = u28[1];
        end;
    end;

    local function u50(p48) -- Line: 208
        -- upvalues: u35 (ref), advanceTimers (copy), u34 (ref), u27 (copy), requestHostCallback (copy), u36 (ref), u28 (copy), requestHostTimeout (copy), u50 (ref)
        u35 = false;
        advanceTimers(p48);

        if not u34 then
            if u27[1] ~= nil then
                u34 = true;
                requestHostCallback(u36);

                return;
            end;

            local v49 = u28[1];

            if v49 ~= nil then
                requestHostTimeout(u50, v49.startTime - p48);
            end;
        end;
    end;

    u36 = function(p51, p52) -- Line: 225
        -- upvalues: enableProfiling (copy), markSchedulerUnsuspended (copy), u34 (ref), u35 (ref), cancelHostTimeout (copy), u33 (ref), u32 (ref), u37 (ref), describeError (copy), u31 (ref), getCurrentTime (copy), markTaskErrored (copy), markSchedulerSuspended (copy)
        if enableProfiling then
            markSchedulerUnsuspended(p52);
        end;

        u34 = false;

        if u35 then
            u35 = false;
            cancelHostTimeout();
        end;

        u33 = true;
        local v53, v54;

        if _G.__YOLO__ then
            v53 = u37(p51, p52);
            v54 = true;
        elseif enableProfiling then
            v54, v53 = xpcall(u37, describeError, p51, p52);

            if not v54 and u31 ~= nil then
                markTaskErrored(u31, (getCurrentTime()));
                u31.isQueued = false;
            end;
        else
            v53 = u37(p51, p52);
            v54 = true;
        end;

        u31 = nil;
        u32 = u32;
        u33 = false;

        if enableProfiling then
            markSchedulerSuspended((getCurrentTime()));
        end;

        if not v54 then
            error(v53);
        end;

        return v53;
    end;

    u37 = function(p55, p56) -- Line: 282
        -- upvalues: advanceTimers (copy), u31 (ref), u27 (copy), enableSchedulerDebugging (copy), u30 (ref), shouldYieldToHost (copy), u32 (ref), markTaskRun (copy), getCurrentTime (copy), markTaskYield (copy), enableProfiling (copy), markTaskCompleted (copy), u5 (ref), u28 (copy), requestHostTimeout (copy), u50 (ref)
        advanceTimers(p56);
        u31 = u27[1];

        while not (u31 == nil or enableSchedulerDebugging and u30 or p56 < u31.expirationTime and (not p55 or shouldYieldToHost())) do
            local callback = u31.callback;

            if typeof(callback) == "function" then
                u31.callback = nil;
                u32 = u31.priorityLevel;
                local v57 = u31.expirationTime <= p56;
                markTaskRun(u31, p56);
                local v58 = callback(v57);
                p56 = getCurrentTime();

                if typeof(v58) == "function" then
                    u31.callback = v58;
                    markTaskYield(u31, p56);
                else
                    if enableProfiling then
                        markTaskCompleted(u31, p56);
                        u31.isQueued = false;
                    end;

                    if u31 == u27[1] then
                        local v59 = u27;
                        local v60 = v59[1];

                        if v60 ~= nil then
                            local v61 = v59[#v59];
                            v59[#v59] = nil;

                            if v61 ~= v60 then
                                v59[1] = v61;
                                u5(v59, v61, 1);
                            end;
                        end;
                    end;
                end;

                advanceTimers(p56);
            else
                local v62 = u27;
                local v63 = v62[1];

                if v63 ~= nil then
                    local v64 = v62[#v62];
                    v62[#v62] = nil;

                    if v64 ~= v63 then
                        v62[1] = v64;
                        u5(v62, v64, 1);
                    end;
                end;
            end;

            u31 = u27[1];
        end;

        if u31 ~= nil then
            return true;
        end;

        local v65 = u28[1];

        if v65 ~= nil then
            requestHostTimeout(u50, v65.startTime - p56);
        end;

        return false;
    end;

    return {
        unstable_ImmediatePriority = ImmediatePriority,
        unstable_UserBlockingPriority = UserBlockingPriority,
        unstable_NormalPriority = NormalPriority,
        unstable_IdlePriority = IdlePriority,
        unstable_LowPriority = LowPriority,

        unstable_runWithPriority = function(p66, p67) -- Line: 339, Name: unstable_runWithPriority
            -- upvalues: ImmediatePriority (copy), UserBlockingPriority (copy), NormalPriority (copy), LowPriority (copy), IdlePriority (copy), u32 (ref), describeError (copy)
            if p66 ~= ImmediatePriority and (p66 ~= UserBlockingPriority and (p66 ~= NormalPriority and (p66 ~= LowPriority and p66 ~= IdlePriority))) then
                p66 = NormalPriority;
            end;

            local v68 = u32;
            u32 = p66;
            local v69, v70;

            if _G.__YOLO__ then
                v69 = p67();
                v70 = true;
            else
                v70, v69 = xpcall(p67, describeError);
            end;

            u32 = v68;

            if not v70 then
                error(v69);
            end;

            return v69;
        end,

        unstable_next = function(p71) -- Line: 374, Name: unstable_next
            -- upvalues: u32 (ref), ImmediatePriority (copy), UserBlockingPriority (copy), NormalPriority (copy), describeError (copy)
            local v72;

            if u32 == ImmediatePriority or (u32 == UserBlockingPriority or u32 == NormalPriority) then
                v72 = NormalPriority;
            else
                v72 = u32;
            end;

            local v73 = u32;
            u32 = v72;
            local v74, v75;

            if _G.__YOLO__ then
                v74 = p71();
                v75 = true;
            else
                v75, v74 = xpcall(p71, describeError);
            end;

            u32 = v73;

            if not v75 then
                error(v74);
            end;

            return v74;
        end,

        unstable_scheduleCallback = function(p76, p77, p78) -- Line: 438, Name: unstable_scheduleCallback
            -- upvalues: getCurrentTime (copy), ImmediatePriority (copy), UserBlockingPriority (copy), IdlePriority (copy), LowPriority (copy), u29 (ref), enableProfiling (copy), u28 (copy), u4 (ref), u27 (copy), u35 (ref), cancelHostTimeout (copy), requestHostTimeout (copy), u50 (ref), markTaskStart (copy), u34 (ref), u33 (ref), requestHostCallback (copy), u36 (ref)
            local v79 = getCurrentTime();
            local v80;

            if typeof(p78) == "table" then
                local delay = p78.delay;

                if typeof(delay) == "number" and delay > 0 then
                    v80 = v79 + delay;
                else
                    v80 = v79;
                end;
            else
                v80 = v79;
            end;

            local v81 = v80 + (p76 == ImmediatePriority and -1 or (p76 == UserBlockingPriority and 250 or (p76 == IdlePriority and 1073741823 or (p76 == LowPriority and 10000 or 5000))));
            local v82 = {
                sortIndex = -1,
                id = u29,
                callback = p77,
                priorityLevel = p76,
                startTime = v80,
                expirationTime = v81
            };
            u29 = u29 + 1;

            if enableProfiling then
                v82.isQueued = false;
            end;

            if v79 < v80 then
                v82.sortIndex = v80;
                local v83 = u28;
                local v84 = #v83 + 1;
                v83[v84] = v82;
                u4(v83, v82, v84);

                if #u27 == 0 and v82 == u28[1] then
                    if u35 then
                        cancelHostTimeout();
                    else
                        u35 = true;
                    end;

                    requestHostTimeout(u50, v80 - v79);

                    return v82;
                end;
            else
                v82.sortIndex = v81;
                local v85 = u27;
                local v86 = #v85 + 1;
                v85[v86] = v82;
                u4(v85, v82, v86);

                if enableProfiling then
                    markTaskStart(v82, v79);
                    v82.isQueued = true;
                end;

                if not (u34 or u33) then
                    u34 = true;
                    requestHostCallback(u36);
                end;
            end;

            return v82;
        end,

        unstable_cancelCallback = function(p87) -- Line: 534, Name: unstable_cancelCallback
            -- upvalues: enableProfiling (copy), getCurrentTime (copy), markTaskCanceled (copy)
            if enableProfiling and p87.isQueued then
                markTaskCanceled(p87, (getCurrentTime()));
                p87.isQueued = false;
            end;

            p87.callback = nil;
        end,

        unstable_wrapCallback = function(u88) -- Line: 410, Name: unstable_wrapCallback
            -- upvalues: u32 (ref), describeError (copy)
            local u89 = u32;

            return function(...) -- Line: 413
                -- upvalues: u32 (ref), u89 (copy), u88 (copy), describeError (ref)
                local v90 = u32;
                u32 = u89;
                local v91, v92;

                if _G.__YOLO__ then
                    v91 = u88(...);
                    v92 = true;
                else
                    v92, v91 = xpcall(u88, describeError, ...);
                end;

                u32 = v90;

                if not v92 then
                    error(v91);
                end;

                return v91;
            end;
        end,

        unstable_getCurrentPriorityLevel = function() -- Line: 549, Name: unstable_getCurrentPriorityLevel
            -- upvalues: u32 (ref)
            return u32;
        end,

        unstable_shouldYield = shouldYieldToHost,
        unstable_requestPaint = requestPaint,

        unstable_continueExecution = function() -- Line: 522, Name: unstable_continueExecution
            -- upvalues: u30 (ref), u34 (ref), u33 (ref), requestHostCallback (copy), u36 (ref)
            u30 = false;

            if not (u34 or u33) then
                u34 = true;
                requestHostCallback(u36);
            end;
        end,

        unstable_pauseExecution = function() -- Line: 518, Name: unstable_pauseExecution
            -- upvalues: u30 (ref)
            u30 = true;
        end,

        unstable_getFirstCallbackNode = function() -- Line: 530, Name: unstable_getFirstCallbackNode
            -- upvalues: u27 (copy)
            return u27[1];
        end,

        unstable_now = getCurrentTime,
        unstable_forceFrameRate = forceFrameRate,
        unstable_Profiling = enableProfiling and {
            startLoggingProfilingEvents = SchedulerProfiling.startLoggingProfilingEvents,
            stopLoggingProfilingEvents = SchedulerProfiling.stopLoggingProfilingEvents
        } or nil
    };
end;