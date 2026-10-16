-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = 0;
local u3 = nil;
local u4 = nil;
local u5 = -1;
local u6 = nil;
local u7 = -1;
local u8 = false;
local u9 = false;
local u10 = false;
local u11 = false;
local console = require(script.Parent.Parent.Parent:WaitForChild("shared")).console;
local disabledLog = require(script.Parent.Parent.Parent:WaitForChild("shared")).ConsolePatchingDev.disabledLog;

function u1.requestHostCallback(p12: function) -- Line: 27
    -- upvalues: u3 (ref)
    u3 = p12;
end;

function u1.cancelHostCallback() -- Line: 31
    -- upvalues: u3 (ref)
    u3 = nil;
end;

function u1.requestHostTimeout(p13: function, p14: number) -- Line: 35
    -- upvalues: u4 (ref), u5 (ref), u2 (ref)
    u4 = p13;
    u5 = u2 + p14;
end;

function u1.cancelHostTimeout() -- Line: 40
    -- upvalues: u4 (ref), u5 (ref)
    u4 = nil;
    u5 = -1;
end;

function u1.shouldYieldToHost() -- Line: 45
    -- upvalues: u6 (ref), u7 (ref), u11 (ref), u10 (ref), u8 (ref)
    local v15 = u6;

    if not (u7 ~= -1 and (v15 ~= nil and u7 <= #v15) or u11 and u10) then
        return false;
    end;

    u8 = true;

    return true;
end;

function u1.getCurrentTime() -- Line: 64
    -- upvalues: u2 (ref)
    return u2;
end;

function u1.forceFrameRate() -- Line: 68
end;

function u1.reset() -- Line: 72
    -- upvalues: u9 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u10 (ref)
    if u9 then
        error("Cannot reset while already flushing work.");
    end;

    u2 = 0;
    u3 = nil;
    u4 = nil;
    u5 = -1;
    u6 = nil;
    u7 = -1;
    u8 = false;
    u9 = false;
    u10 = false;
end;

function u1.unstable_flushNumberOfYields(p16: number) -- Line: 89
    -- upvalues: u9 (ref), u3 (ref), u7 (ref), u2 (ref), u8 (ref)
    if u9 then
        error("Already flushing work.");
    end;

    if u3 ~= nil then
        local u17 = u3;
        u7 = p16;
        u9 = true;
        local success, result = pcall(function() -- Line: 99
            -- upvalues: u17 (copy), u2 (ref), u8 (ref), u3 (ref)
            local v18;

            repeat
                v18 = u17(true, u2);
            until not v18 or u8;

            if not v18 then
                u3 = nil;
            end;
        end);
        u7 = -1;
        u8 = false;
        u9 = false;

        if not success then
            error(result);
        end;
    end;
end;

function u1.unstable_flushUntilNextPaint() -- Line: 120
    -- upvalues: u9 (ref), u3 (ref), u11 (ref), u10 (ref), u2 (ref), u8 (ref)
    if u9 then
        error("Already flushing work.");
    end;

    if u3 ~= nil then
        local u19 = u3;
        u11 = true;
        u10 = false;
        u9 = true;
        local success, result = pcall(function() -- Line: 131
            -- upvalues: u19 (copy), u2 (ref), u8 (ref), u3 (ref)
            local v20;

            repeat
                v20 = u19(true, u2);
            until not v20 or u8;

            if not v20 then
                u3 = nil;
            end;
        end);
        u11 = false;
        u8 = false;
        u9 = false;

        if not success then
            error(result);
        end;
    end;
end;

function u1.unstable_flushExpired() -- Line: 153
    -- upvalues: u9 (ref), u3 (ref), u2 (ref)
    if u9 then
        error("Already flushing work.");
    end;

    if u3 ~= nil then
        u9 = true;
        local success, result = pcall(function() -- Line: 159
            -- upvalues: u3 (ref), u2 (ref)
            if not u3(false, u2) then
                u3 = nil;
            end;
        end);
        u9 = false;

        if not success then
            error(result);
        end;
    end;
end;

function u1.unstable_flushAllWithoutAsserting() -- Line: 177
    -- upvalues: u9 (ref), u3 (ref), u2 (ref)
    if u9 then
        error("Already flushing work.");
    end;

    if u3 == nil then
        return false;
    end;

    local u21 = u3;
    u9 = true;
    local success, result = pcall(function() -- Line: 185
        -- upvalues: u21 (copy), u2 (ref), u3 (ref)
        local v22;

        repeat
            v22 = u21(true, u2);
        until not v22;

        if not v22 then
            u3 = nil;
        end;
    end);
    u9 = false;

    if not success then
        error(result);
    end;

    return true;
end;

function u1.unstable_clearYields() -- Line: 208
    -- upvalues: u6 (ref)
    if u6 == nil then
        return {};
    end;

    local v23 = u6;
    u6 = nil;

    return v23;
end;

function u1.unstable_flushAll() -- Line: 217
    -- upvalues: u6 (ref), u1 (copy)
    if u6 ~= nil then
        error("Log is not empty. Assert on the log of yielded values before flushing additional work.");
    end;

    u1.unstable_flushAllWithoutAsserting();

    if u6 ~= nil then
        error("While flushing work, something yielded a value. Use an assertion helper to assert on the log of yielded values, e.g. expect(Scheduler).toFlushAndYield([...])");
    end;
end;

function u1.unstable_yieldValue(p24) -- Line: 234
    -- upvalues: console (copy), disabledLog (copy), u6 (ref)
    if console.log == disabledLog then
        return;
    end;

    if u6 == nil then
        u6 = { p24 };

        return;
    end;

    table.insert(u6, p24);
end;

function u1.unstable_advanceTime(p25: number) -- Line: 251
    -- upvalues: console (copy), disabledLog (copy), u2 (ref), u4 (ref), u5 (ref)
    if console.log == disabledLog then
        return;
    end;

    u2 = u2 + p25;

    if u4 ~= nil and u5 <= u2 then
        u4(u2);
        u5 = -1;
        u4 = nil;
    end;
end;

function u1.requestPaint() -- Line: 270
    -- upvalues: u10 (ref)
    u10 = true;
end;

return u1;