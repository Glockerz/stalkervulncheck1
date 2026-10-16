-- Decompiled with Potassium's decompiler.

local console = require(script.Parent:WaitForChild("console"));
local u1 = 0;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;

local function u9() -- Line: 31
end;

return {
    disabledLog = u9,

    disableLogs = function() -- Line: 40
        -- upvalues: u1 (ref), u2 (ref), console (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (copy)
        if _G.__DEV__ then
            if u1 == 0 then
                u2 = console.log;
                u3 = console.info;
                u4 = console.warn;
                u5 = console.error;
                u6 = console.group;
                u7 = console.groupCollapsed;
                u8 = console.groupEnd;
                console.info = u9;
                console.log = u9;
                console.warn = u9;
                console.error = u9;
                console.group = u9;
                console.groupCollapsed = u9;
                console.groupEnd = u9;
            end;

            u1 = u1 + 1;
        end;
    end,

    reenableLogs = function() -- Line: 64
        -- upvalues: u1 (ref), console (copy), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref)
        if _G.__DEV__ then
            u1 = u1 - 1;

            if u1 == 0 then
                console.log = u2;
                console.info = u3;
                console.warn = u4;
                console.error = u5;
                console.group = u6;
                console.groupCollapsed = u7;
                console.groupEnd = u8;
            end;

            if u1 < 0 then
                console.error("disabledDepth fell below zero. This is a bug in React. Please file an issue.");
            end;
        end;
    end
};