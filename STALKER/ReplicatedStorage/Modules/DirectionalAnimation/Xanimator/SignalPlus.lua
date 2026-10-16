-- Decompiled with Potassium's decompiler.

local function callbackThread(p1, p2) -- Line: 4
    repeat
        p2(coroutine.yield());
    until not p1.Thread;
end;

local u3 = {};
u3.__index = u3;

function u3.Disconnect(p4) -- Line: 14
    local Thread = p4.Thread;

    if not Thread then
        return;
    end;

    if coroutine.status(Thread) == "suspended" then
        coroutine.close(Thread);
    end;

    p4.Thread = nil;
    local Signal = p4.Signal;
    local v5 = #Signal;
    local Index = p4.Index;

    if Index == v5 then
        Signal[v5] = nil;

        return;
    end;

    local v6 = Signal[v5];
    v6.Index = Index;
    Signal[Index] = v6;
    Signal[v5] = nil;
end;

local u7 = {};
u7.__index = u7;

function u7.Connect(p8, p9) -- Line: 37
    -- upvalues: callbackThread (copy), u3 (copy)
    local v10 = {
        Signal = p8,
        Index = #p8 + 1
    };
    v10.Thread = task.spawn(callbackThread, v10, p9);
    table.insert(p8, v10);

    return setmetatable(v10, u3);
end;

function u7.Once(u11, u12) -- Line: 43
    -- upvalues: callbackThread (copy), u3 (copy)
    local u13 = {
        Signal = u11,
        Index = #u11 + 1
    };
    u13.Thread = task.spawn(callbackThread, u13, function(...) -- Line: 45
        -- upvalues: u13 (copy), u11 (copy), u12 (copy)
        u13.Thread = nil;
        local v14 = #u11;
        local Index = u13.Index;

        if Index == v14 then
            u11[v14] = nil;
        else
            local v15 = u11[v14];
            v15.Index = Index;
            u11[Index] = v15;
            u11[v14] = nil;
        end;

        u12(...);
    end);
    table.insert(u11, u13);

    return setmetatable(u13, u3);
end;

function u7.Wait(u16) -- Line: 62
    -- upvalues: callbackThread (copy)
    local coroutine_running_ret = coroutine.running();
    local u17 = {
        Signal = u16,
        Index = #u16 + 1
    };
    u17.Thread = task.spawn(callbackThread, u17, function(...) -- Line: 65
        -- upvalues: u17 (copy), u16 (copy), coroutine_running_ret (copy)
        u17.Thread = nil;
        local v18 = #u16;
        local Index = u17.Index;

        if Index == v18 then
            u16[v18] = nil;
        else
            local v19 = u16[v18];
            v19.Index = Index;
            u16[Index] = v19;
            u16[v18] = nil;
        end;

        if coroutine.status(coroutine_running_ret) == "suspended" then
            local _, v20 = coroutine.resume(coroutine_running_ret, ...);

            if v20 then
                error(v20, 2);
            end;
        end;
    end);
    table.insert(u16, u17);

    return coroutine.yield();
end;

function u7.Fire(p21, ...) -- Line: 86
    for i = #p21, 1, -1 do
        local Thread = p21[i].Thread;
        local v22;

        if Thread then
            local _, v23 = coroutine.resume(Thread, ...);

            if v23 then
                error(v23, 3);
                v22 = i;
            else
                v22 = i;
            end;
        else
            v22 = i;
        end;
    end;
end;

function u7.DisconnectAll(p24) -- Line: 95
    for _, v in p24 do
        local Thread = v.Thread;

        if coroutine.status(Thread) == "suspended" then
            coroutine.close(Thread);
        end;

        v.Thread = nil;
    end;

    table.clear(p24);
end;

function u7.Destroy(p25) -- Line: 105
    for _, v in p25 do
        local Thread = v.Thread;

        if coroutine.status(Thread) == "suspended" then
            coroutine.close(Thread);
        end;

        v.Thread = nil;
    end;

    table.clear(p25);
    setmetatable(p25, nil);
end;

return function() -- Line: 117
    -- upvalues: u7 (copy)
    return setmetatable({}, u7);
end;