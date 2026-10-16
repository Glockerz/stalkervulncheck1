-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = nil;

function u1.setExtraStackFrame(p3: string?) -- Line: 16
    -- upvalues: u2 (ref)
    if _G.__DEV__ then
        u2 = p3;
    end;
end;

if _G.__DEV__ then
    u1.getCurrentStack = nil;

    function u1.getStackAddendum() -- Line: 33
        -- upvalues: u2 (ref), u1 (copy)
        local v4 = "";

        if u2 then
            v4 = v4 .. u2;
        end;

        local getCurrentStack = u1.getCurrentStack;

        if getCurrentStack then
            v4 = v4 .. (getCurrentStack() or "");
        end;

        return v4;
    end;
end;

return u1;