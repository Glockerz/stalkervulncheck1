-- Decompiled with Potassium's decompiler.

local invariant = require(script.Parent:WaitForChild("invariant"));
local invokeGuardedCallbackImpl = require(script.Parent:WaitForChild("invokeGuardedCallbackImpl"));
local u1 = nil;
local u2 = false;
local u3 = nil;
local u4 = false;
local u5 = nil;
local u7 = {
    onError = function(p6) -- Line: 25, Name: onError
        -- upvalues: u2 (ref), u3 (ref)
        u2 = true;
        u3 = p6;
    end
};
local u8 = {
    invokeGuardedCallback = function(...) -- Line: 45
        -- upvalues: u2 (ref), u3 (ref), invokeGuardedCallbackImpl (copy), u7 (copy)
        u2 = false;
        u3 = nil;
        invokeGuardedCallbackImpl(u7, ...);
    end
};

function u8.invokeGuardedCallbackAndCatchFirstError(...) -- Line: 62
    -- upvalues: u8 (copy), u2 (ref), u1 (ref), u4 (ref), u5 (ref)
    u8.invokeGuardedCallback(...);

    if u2 then
        local v9 = u1();

        if not u4 then
            u4 = true;
            u5 = v9;
        end;
    end;
end;

function u8.rethrowCaughtError() -- Line: 80
    -- upvalues: u4 (ref), u5 (ref)
    if u4 then
        local v10 = u5;
        u4 = false;
        u5 = nil;
        error(v10);
    end;
end;

function u8.hasCaughtError() -- Line: 89
    -- upvalues: u2 (ref)
    return u2;
end;

u1 = function() -- Line: 93
    -- upvalues: u2 (ref), u3 (ref), invariant (copy)
    if not u2 then
        invariant(
            false,
            "clearCaughtError was called but no error was captured. This error is likely caused by a bug in React. Please file an issue."
        );

        return nil;
    end;

    local v11 = u3;
    u2 = false;
    u3 = nil;

    return v11;
end;

u8.clearCaughtError = u1;

return u8;