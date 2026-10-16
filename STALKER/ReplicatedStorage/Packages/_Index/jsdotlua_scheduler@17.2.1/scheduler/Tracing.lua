-- Decompiled with Potassium's decompiler.

local Set = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Set;
local v1 = {};
local enableSchedulerTracing = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSchedulerTracing;
local u2 = 0;
local u3 = 0;
local u4, u5;

if enableSchedulerTracing then
    u4 = {
        current = Set.new()
    };
    u5 = {
        current = nil
    };
else
    u4 = nil;
    u5 = nil;
end;

v1.__interactionsRef = u4;
v1.__subscriberRef = u5;

function v1.unstable_clear(p6: function) -- Line: 91
    -- upvalues: enableSchedulerTracing (copy), u4 (ref), Set (copy)
    if not enableSchedulerTracing then
        return p6();
    end;

    local current = u4.current;
    u4.current = Set.new();
    local success, result = pcall(p6);
    u4.current = current;

    if not success then
        error(result);
    end;

    return result;
end;

function v1.unstable_getCurrent() -- Line: 111
    -- upvalues: enableSchedulerTracing (copy), u4 (ref)
    if enableSchedulerTracing then
        return u4.current;
    end;

    return nil;
end;

function v1.unstable_getThreadID() -- Line: 119
    -- upvalues: u3 (ref)
    u3 = u3 + 1;

    return u3;
end;

function v1.unstable_trace(p7: string, p8: number, u9: function, p10: number?) -- Line: 125
    -- upvalues: enableSchedulerTracing (copy), u2 (ref), u4 (ref), Set (copy), u5 (ref)
    local u11 = p10 == nil and 0 or p10;

    if not enableSchedulerTracing then
        return u9();
    end;

    local u12 = {
        __count = 1,
        id = u2,
        name = p7,
        timestamp = p8
    };
    u2 = u2 + 1;
    local current = u4.current;
    local u13 = Set.new(current);
    u13:add(u12);
    u4.current = u13;
    local current2 = u5.current;
    local u14 = nil;
    local success, result = pcall(function() -- Line: 154
        -- upvalues: current2 (copy), u12 (copy)
        if current2 ~= nil then
            current2.onInteractionTraced(u12);
        end;
    end);
    local success2, result2 = pcall(function() -- Line: 161
        -- upvalues: current2 (copy), u13 (copy), u11 (copy)
        if current2 ~= nil then
            current2.onWorkStarted(u13, u11);
        end;
    end);
    local success3, result3 = pcall(function() -- Line: 169
        -- upvalues: u14 (ref), u9 (copy)
        u14 = u9();
    end);
    u4.current = current;
    local success4, result4 = pcall(function() -- Line: 175
        -- upvalues: current2 (copy), u13 (copy), u11 (copy)
        if current2 ~= nil then
            current2.onWorkStopped(u13, u11);
        end;
    end);
    u12.__count = u12.__count - 1;

    if current2 ~= nil and u12.__count == 0 then
        current2.onInteractionScheduledWorkCompleted(u12);
    end;

    if not success4 then
        error(result4);
    end;

    if not success3 then
        error(result3);
    end;

    if not success2 then
        error(result2);
    end;

    if not success then
        error(result);
    end;

    return u14;
end;

function v1.unstable_wrap(u15: function, p16: number) -- Line: 208
    -- upvalues: enableSchedulerTracing (copy), u4 (ref), u5 (ref)
    local u17 = p16 == nil and 0 or p16;

    if not enableSchedulerTracing then
        return u15;
    end;

    local current = u4.current;
    local current2 = u5.current;

    if current2 ~= nil then
        current2.onWorkScheduled(current, u17);
    end;

    for _, v in current do
        v.__count = v.__count + 1;
    end;

    local u18 = false;

    local function v19() -- Line: 301
        -- upvalues: current2 (ref), u5 (ref), current (copy), u17 (ref)
        current2 = u5.current;
        local success, result = pcall(function() -- Line: 304
            -- upvalues: current2 (ref), current (ref), u17 (ref)
            if current2 ~= nil then
                current2.onWorkCanceled(current, u17);
            end;
        end);

        for _, v in current do
            v.__count = v.__count - 1;

            if current2 ~= nil and v.__count == 0 then
                current2.onInteractionScheduledWorkCompleted(v);
            end;
        end;

        if not success then
            error(result);
        end;
    end;

    local v20 = {};
    setmetatable(v20, {
        __call = function(p21, ...) -- Line: 236, Name: _wrapped
            -- upvalues: u4 (ref), current (copy), current2 (ref), u5 (ref), u17 (ref), u15 (copy), u18 (ref)
            local current3 = u4.current;
            u4.current = current;
            current2 = u5.current;
            local success, result = pcall(function(...) -- Line: 243
                -- upvalues: current2 (ref), current (ref), u17 (ref), u15 (ref), u4 (ref), current3 (copy)
                local u22 = nil;
                local success, result = pcall(function() -- Line: 247
                    -- upvalues: current2 (ref), current (ref), u17 (ref)
                    if current2 ~= nil then
                        current2.onWorkStarted(current, u17);
                    end;
                end);
                local success2, result2 = pcall(function(...) -- Line: 254
                    -- upvalues: u22 (ref), u15 (ref)
                    u22 = u15(...);
                end, ...);
                u4.current = current3;

                if current2 ~= nil then
                    current2.onWorkStopped(current, u17);
                end;

                if not success2 then
                    error(result2);
                end;

                if not success then
                    error(result);
                end;

                return u22;
            end, ...);

            if not u18 then
                u18 = true;

                for _, v in current do
                    v.__count = v.__count - 1;

                    if current2 ~= nil and v.__count == 0 then
                        current2.onInteractionScheduledWorkCompleted(v);
                    end;
                end;
            end;

            if not success then
                error(result);
            end;

            return result;
        end
    });
    v20.cancel = v19;

    return v20;
end;

return v1;