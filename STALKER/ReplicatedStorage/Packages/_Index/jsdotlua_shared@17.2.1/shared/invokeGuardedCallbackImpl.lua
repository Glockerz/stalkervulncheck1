-- Decompiled with Potassium's decompiler.

local describeError = require(script.Parent:WaitForChild("ErrorHandling.roblox")).describeError;
local _ = _G.__DEV__;

return function(p1, p2, p3, p4, ...) -- Line: 15, Name: invokeGuardedCallbackProd
    -- upvalues: describeError (copy)
    local v5 = nil;
    local v6;

    if _G.__YOLO__ then
        v6 = true;

        if p4 == nil then
            p3(...);
        else
            p3(p4, ...);
        end;
    elseif p4 == nil then
        v6, v5 = xpcall(p3, describeError, ...);
    else
        v6, v5 = xpcall(p3, describeError, p4, ...);
    end;

    if not v6 then
        p1.onError(v5);
    end;
end;