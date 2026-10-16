-- Decompiled with Potassium's decompiler.

local v1 = require(script.Parent.Parent.Parent:WaitForChild("luau-polyfill"));
local Object = v1.Object;
local shared = require(script.Parent.Parent.Parent:WaitForChild("shared"));
local console = shared.console;
local errorToString = shared.errorToString;
local describeError = shared.describeError;
local setTimeout = v1.setTimeout;
local clearTimeout = v1.clearTimeout;
local u2 = false;
local u3 = nil;
local None = Object.None;
local u4 = 15;
local u5 = 0;

local function shouldYieldToHost() -- Line: 46
    -- upvalues: u5 (ref)
    return u5 <= os.clock() * 1000;
end;

local function forceFrameRate(p6) -- Line: 53
    -- upvalues: console (copy), u4 (ref)
    if p6 < 0 or p6 > 125 then
        console.warn("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported");

        return;
    end;

    if p6 > 0 then
        u4 = math.floor(1000 / p6);

        return;
    end;

    u4 = 5;
end;

local function performWorkUntilDeadline() -- Line: 69
    -- upvalues: u3 (ref), u5 (ref), u4 (ref), u2 (ref), performWorkUntilDeadline (ref), describeError (copy), errorToString (copy)
    if u3 == nil then
        u2 = false;
    else
        local u7 = os.clock() * 1000;
        u5 = u7 + u4;

        local function doWork() -- Line: 79
            -- upvalues: u3 (ref), u7 (copy), u2 (ref), performWorkUntilDeadline (ref)
            if u3(true, u7) then
                task.delay(0, performWorkUntilDeadline);
            else
                u2 = false;
                u3 = nil;
            end;

            return nil;
        end;

        local v8, v9;

        if _G.__YOLO__ then
            if u3(true, u7) then
                task.delay(0, performWorkUntilDeadline);
                v8 = true;
                v9 = nil;
            else
                u2 = false;
                u3 = nil;
                v8 = true;
                v9 = nil;
            end;
        else
            v8, v9 = xpcall(doWork, describeError);
        end;

        if not v8 then
            task.delay(0, performWorkUntilDeadline);
            error(errorToString(v9));
        end;
    end;
end;

local function wrapPerformWorkWithCoroutine(u10) -- Line: 124
    local coroutine_create_ret = coroutine.create(function() -- Line: 125
        -- upvalues: u10 (copy)
        while true do
            local coroutine_wrap_ret = coroutine.wrap(u10);
            local success, result = pcall(coroutine_wrap_ret);
            coroutine.yield(success, result);
        end;
    end);

    return function() -- Line: 135
        -- upvalues: coroutine_create_ret (copy)
        local _, v11, v12 = coroutine.resume(coroutine_create_ret);

        if not v11 then
            error(v12);
        end;
    end;
end;

local u13 = performWorkUntilDeadline;
local coroutine_create_ret = coroutine.create(function() -- Line: 125
    -- upvalues: u13 (copy)
    while true do
        local coroutine_wrap_ret = coroutine.wrap(u13);
        local success, result = pcall(coroutine_wrap_ret);
        coroutine.yield(success, result);
    end;
end);

performWorkUntilDeadline = function() -- Line: 135
    -- upvalues: coroutine_create_ret (copy)
    local _, v14, v15 = coroutine.resume(coroutine_create_ret);

    if not v14 then
        error(v15);
    end;
end;

return {
    requestHostCallback = function(p16) -- Line: 145, Name: requestHostCallback
        -- upvalues: u3 (ref), u2 (ref), performWorkUntilDeadline (ref)
        u3 = p16;

        if not u2 then
            u2 = true;
            task.delay(0, performWorkUntilDeadline);
        end;
    end,

    cancelHostCallback = function() -- Line: 154, Name: cancelHostCallback
        -- upvalues: u3 (ref)
        u3 = nil;
    end,

    requestHostTimeout = function(u17, p18) -- Line: 158, Name: requestHostTimeout
        -- upvalues: None (ref), setTimeout (copy)
        None = setTimeout(function() -- Line: 159
            -- upvalues: u17 (copy)
            u17(os.clock() * 1000);
        end, p18);
    end,

    cancelHostTimeout = function() -- Line: 164, Name: cancelHostTimeout
        -- upvalues: clearTimeout (copy), None (ref), Object (copy)
        clearTimeout(None);
        None = Object.None;
    end,

    shouldYieldToHost = shouldYieldToHost,

    requestPaint = function() -- Line: 51, Name: requestPaint
    end,

    getCurrentTime = function() -- Line: 19
        return os.clock() * 1000;
    end,

    forceFrameRate = forceFrameRate
};