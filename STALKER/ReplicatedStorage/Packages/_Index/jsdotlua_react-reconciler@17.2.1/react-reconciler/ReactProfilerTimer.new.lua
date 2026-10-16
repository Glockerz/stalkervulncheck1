-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer;
local enableProfilerCommitHooks = ReactFeatureFlags.enableProfilerCommitHooks;
local Profiler = require(script.Parent:WaitForChild("ReactWorkTags")).Profiler;
local unstable_now = require(script.Parent.Parent:WaitForChild("scheduler")).unstable_now;
local u1 = 0;
local u2 = -1;
local u3 = -1;
local u4 = -1;

function getCommitTime()
    -- upvalues: u1 (ref)
    return u1;
end;

function recordCommitTime()
    -- upvalues: enableProfilerTimer (copy), u1 (ref), unstable_now (copy)
    if not enableProfilerTimer then
        return;
    end;

    u1 = unstable_now();
end;

function startProfilerTimer(p5)
    -- upvalues: enableProfilerTimer (copy), u3 (ref), unstable_now (copy)
    if not enableProfilerTimer then
        return;
    end;

    u3 = unstable_now();

    if p5.actualStartTime ~= nil and p5.actualStartTime < 0 then
        p5.actualStartTime = unstable_now();
    end;
end;

function stopProfilerTimerIfRunning(p6)
    -- upvalues: enableProfilerTimer (copy), u3 (ref)
    if not enableProfilerTimer then
        return;
    end;

    u3 = -1;
end;

function stopProfilerTimerIfRunningAndRecordDelta(p7: any, p8: boolean)
    -- upvalues: enableProfilerTimer (copy), u3 (ref), unstable_now (copy)
    if not enableProfilerTimer then
        return;
    end;

    if u3 >= 0 then
        local v9 = unstable_now() - u3;
        p7.actualDuration = p7.actualDuration + v9;

        if p8 then
            p7.selfBaseDuration = v9;
        end;

        u3 = -1;
    end;
end;

function recordLayoutEffectDuration(p10)
    -- upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), u2 (ref), unstable_now (copy), Profiler (copy)
    if not (enableProfilerTimer and enableProfilerCommitHooks) then
        return;
    end;

    if u2 >= 0 then
        local v11 = unstable_now() - u2;
        u2 = -1;
        local return_ = p10.return_;

        while return_ ~= nil do
            if return_.tag == Profiler then
                local stateNode = return_.stateNode;
                stateNode.effectDuration = stateNode.effectDuration + v11;

                return;
            end;

            return_ = return_.return_;
        end;
    end;
end;

function recordPassiveEffectDuration(p12)
    -- upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), u4 (ref), unstable_now (copy), Profiler (copy)
    if not (enableProfilerTimer and enableProfilerCommitHooks) then
        return;
    end;

    if u4 >= 0 then
        local v13 = unstable_now() - u4;
        u4 = -1;
        local return_ = p12.return_;

        while return_ ~= nil do
            if return_.tag == Profiler then
                local stateNode = return_.stateNode;

                if stateNode ~= nil then
                    stateNode.passiveEffectDuration = stateNode.passiveEffectDuration + v13;

                    return;
                end;

                break;
            end;

            return_ = return_.return_;
        end;
    end;
end;

function startLayoutEffectTimer()
    -- upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), u2 (ref), unstable_now (copy)
    if not (enableProfilerTimer and enableProfilerCommitHooks) then
        return;
    end;

    u2 = unstable_now();
end;

function startPassiveEffectTimer()
    -- upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), u4 (ref), unstable_now (copy)
    if not (enableProfilerTimer and enableProfilerCommitHooks) then
        return;
    end;

    u4 = unstable_now();
end;

function transferActualDuration(p14)
    local child = p14.child;

    while child do
        p14.actualDuration = p14.actualDuration + child.actualDuration;
        child = child.sibling;
    end;
end;

return {
    getCommitTime = getCommitTime,
    recordCommitTime = recordCommitTime,
    recordLayoutEffectDuration = recordLayoutEffectDuration,
    recordPassiveEffectDuration = recordPassiveEffectDuration,
    startLayoutEffectTimer = startLayoutEffectTimer,
    startPassiveEffectTimer = startPassiveEffectTimer,
    startProfilerTimer = startProfilerTimer,
    stopProfilerTimerIfRunning = stopProfilerTimerIfRunning,
    stopProfilerTimerIfRunningAndRecordDelta = stopProfilerTimerIfRunningAndRecordDelta,
    transferActualDuration = transferActualDuration
};