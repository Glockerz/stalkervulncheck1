-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local v1 = {};
local u2 = nil;
require(script.Parent:WaitForChild("ReactFiberLane"));
local enableDebugTracing = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableDebugTracing;
local u3 = nil;
local u4 = {};
local u5 = 0;

function decimalToBinaryString(p6: number)
    local v7 = "";

    repeat
        local v8;
        p6, v8 = math.modf(p6 / 2);
        v7 = math.ceil(v8) .. v7;
    until p6 == 0;

    local v9 = 31 - string.len(v7);

    return string.rep("0", v9) .. v7;
end;

local function formatLanes(p10) -- Line: 52
    return "0b" .. decimalToBinaryString(p10);
end;

local function group(...) -- Line: 58
    -- upvalues: u4 (copy), u3 (ref), console (copy), u2 (ref)
    for _, v in { ... } do
        table.insert(u4, v);
    end;

    if u3 == nil then
        u3 = console.log;
        console.log = u2;
    end;
end;

local function groupEnd() -- Line: 68
    -- upvalues: u4 (copy), u5 (ref), console (copy), u3 (ref)
    table.remove(u4, 1);

    while u5 > #u4 do
        console.groupEnd();
        u5 = u5 - 1;
    end;

    if #u4 == 0 then
        console.log = u3;
        u3 = nil;
    end;
end;

u2 = function(...) -- Line: 80, Name: log
    -- upvalues: u5 (ref), u4 (copy), console (copy), u3 (ref)
    if u5 < #u4 then
        for i = u5 + 1, #u4 do
            console.group(u4[i]);
            local _ = i;
        end;

        u5 = #u4;
    end;

    if typeof(u3) == "function" then
        u3(...);

        return;
    end;

    console.log(...);
end;

function v1.logCommitStarted(p11) -- Line: 98
    -- upvalues: enableDebugTracing (copy), group (copy)
    if _G.__DEV__ and enableDebugTracing then
        group(string.format("* commit (%s)", "0b" .. decimalToBinaryString(p11)), "", "", "");
    end;
end;

function v1.logCommitStopped() -- Line: 113
    -- upvalues: enableDebugTracing (copy), groupEnd (copy)
    if _G.__DEV__ and enableDebugTracing then
        groupEnd();
    end;
end;

function v1.logComponentSuspended(u12: string, p13: any) -- Line: 141
    -- upvalues: enableDebugTracing (copy), u2 (ref)
    if _G.__DEV__ and enableDebugTracing then
        u2(string.format("* %s suspended", u12));
        p13:andThen(function() -- Line: 155
            -- upvalues: u2 (ref), u12 (copy)
            u2(string.format("* %s resolved", u12));
        end, function() -- Line: 164
            -- upvalues: u2 (ref), u12 (copy)
            u2(string.format("* %s rejected", u12));
        end);
    end;
end;

function v1.logLayoutEffectsStarted(p14) -- Line: 179
    -- upvalues: enableDebugTracing (copy), group (copy)
    if _G.__DEV__ and enableDebugTracing then
        group(string.format("* layout effects (%s)", "0b" .. decimalToBinaryString(p14)));
    end;
end;

function v1.logLayoutEffectsStopped() -- Line: 194
    -- upvalues: enableDebugTracing (copy), groupEnd (copy)
    if _G.__DEV__ and enableDebugTracing then
        groupEnd();
    end;
end;

function v1.logPassiveEffectsStarted(p15) -- Line: 203
    -- upvalues: enableDebugTracing (copy), group (copy)
    if _G.__DEV__ and enableDebugTracing then
        group(string.format("* passive effects (%s)", "0b" .. decimalToBinaryString(p15)));
    end;
end;

function v1.logPassiveEffectsStopped() -- Line: 218
    -- upvalues: enableDebugTracing (copy), groupEnd (copy)
    if _G.__DEV__ and enableDebugTracing then
        groupEnd();
    end;
end;

function v1.logRenderStarted(p16) -- Line: 227
    -- upvalues: enableDebugTracing (copy), group (copy)
    if _G.__DEV__ and enableDebugTracing then
        group(string.format("* render (%s)", "0b" .. decimalToBinaryString(p16)));
    end;
end;

function v1.logRenderStopped() -- Line: 242
    -- upvalues: enableDebugTracing (copy), groupEnd (copy)
    if _G.__DEV__ and enableDebugTracing then
        groupEnd();
    end;
end;

function v1.logForceUpdateScheduled(p17: string, p18: any) -- Line: 251
    -- upvalues: enableDebugTracing (copy), u2 (ref)
    if _G.__DEV__ and enableDebugTracing then
        u2(string.format("* %s forced update (%s)", p17, "0b" .. decimalToBinaryString(p18)));
    end;
end;

function v1.logStateUpdateScheduled(p19: string, p20: any, p21: any) -- Line: 266
    -- upvalues: enableDebugTracing (copy), u2 (ref)
    if _G.__DEV__ and enableDebugTracing then
        u2(string.format("* %s updated state (%s)", p19, "0b" .. decimalToBinaryString(p20)));
    end;
end;

return v1;