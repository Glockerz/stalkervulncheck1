-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.Create(p2) -- Line: 6
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;

function u1.Connect(p3, p4) -- Line: 10
    p3[1] = p4;
end;

function u1.Fire(p5, ...) -- Line: 14
    if not p5[1] then
        return;
    end;

    local coroutine_create_ret = coroutine.create(p5[1]);
    coroutine.resume(coroutine_create_ret, ...);
end;

function u1.Destroy(p6) -- Line: 21
    p6[1] = nil;
end;

return u1;