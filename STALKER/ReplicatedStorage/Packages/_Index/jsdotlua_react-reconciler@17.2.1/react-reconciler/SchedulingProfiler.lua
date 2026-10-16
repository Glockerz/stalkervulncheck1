-- Decompiled with Potassium's decompiler.

local v1 = {};
local WeakMap = require(script.Parent.Parent:WaitForChild("luau-polyfill")).WeakMap;
require(script.Parent:WaitForChild("ReactFiberLane"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
require(script.Parent.Parent:WaitForChild("shared"));
local enableSchedulingProfiler = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSchedulingProfiler;
local ReactVersion = require(script.Parent.Parent:WaitForChild("shared")).ReactVersion;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local u2 = _G.performance ~= nil;
local u4 = _G.performance or {
    mark = function(p3) -- Line: 39, Name: mark
        debug.profilebegin(p3);
        debug.profileend();
    end
};

function formatLanes(p5)
    return tostring(p5);
end;

if enableSchedulingProfiler and u2 then
    u4.mark("--react-init-" .. tostring(ReactVersion));
end;

function v1.markCommitStarted(p6) -- Line: 56
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--commit-start-" .. formatLanes(p6));
    end;
end;

function v1.markCommitStopped() -- Line: 64
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--commit-stop");
    end;
end;

local u7 = WeakMap.new();
local u8 = 0;

function getWakeableID(p9)
    -- upvalues: u7 (copy), u8 (ref)
    if not u7:has(p9) then
        u7:set(p9, u8);
        u8 = u8 + 1;
    end;

    return u7:get(p9);
end;

function v1.markComponentSuspended(p10, p11) -- Line: 86
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), getComponentName (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        local u12 = getWakeableID(p11);
        local u13 = getComponentName(p10.type) or "Unknown";
        u4.mark("--suspense-suspend-" .. tostring(u12) .. "-" .. u13);
        p11:andThen(function() -- Line: 95
            -- upvalues: u4 (ref), u12 (copy), u13 (copy)
            u4.mark("--suspense-resolved-" .. tostring(u12) .. "-" .. u13);
        end, function() -- Line: 99
            -- upvalues: u4 (ref), u12 (copy), u13 (copy)
            u4.mark("--suspense-rejected-" .. tostring(u12) .. "-" .. u13);
        end);
    end;
end;

function v1.markLayoutEffectsStarted(p14) -- Line: 108
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--layout-effects-start-" .. formatLanes(p14));
    end;
end;

function v1.markLayoutEffectsStopped() -- Line: 116
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--layout-effects-stop");
    end;
end;

function v1.markPassiveEffectsStarted(p15) -- Line: 124
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--passive-effects-start-" .. formatLanes(p15));
    end;
end;

function v1.markPassiveEffectsStopped() -- Line: 132
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--passive-effects-stop");
    end;
end;

function v1.markRenderStarted(p16) -- Line: 140
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--render-start-" .. formatLanes(p16));
    end;
end;

function v1.markRenderYielded() -- Line: 148
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--render-yield");
    end;
end;

function v1.markRenderStopped() -- Line: 156
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--render-stop");
    end;
end;

function v1.markRenderScheduled(p17) -- Line: 164
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        u4.mark("--schedule-render-" .. formatLanes(p17));
    end;
end;

function v1.markForceUpdateScheduled(p18, p19) -- Line: 172
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), getComponentName (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        local v20 = getComponentName(p18.type) or "Unknown";
        u4.mark("--schedule-forced-update-" .. formatLanes(p19) .. "-" .. v20);
    end;
end;

function v1.markStateUpdateScheduled(p21, p22) -- Line: 184
    -- upvalues: enableSchedulingProfiler (copy), u2 (copy), getComponentName (copy), u4 (copy)
    if enableSchedulingProfiler and u2 then
        local v23 = getComponentName(p21.type) or "Unknown";
        u4.mark("--schedule-state-update-" .. formatLanes(p22) .. "-" .. v23);
    end;
end;

return v1;