-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SerdesLayer = require(script.Parent.SerdesLayer);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};
u9.__index = u9;

function u9._start() -- Line: 34
    -- upvalues: u1 (ref), ReplicatedStorage (copy), u2 (ref), SerdesLayer (copy), u3 (ref), RunService (copy), u4 (ref), u8 (copy), u6 (copy), u5 (ref), u7 (copy)
    u1 = ReplicatedStorage:WaitForChild("RemoteEvent");
    u2 = SerdesLayer.FromIdentifier("Invoke");
    u3 = SerdesLayer.FromIdentifier("InvokeReply");
    local u10 = {};
    RunService.Heartbeat:Connect(function() -- Line: 42
        -- upvalues: u4 (ref), u10 (copy), u8 (ref), SerdesLayer (ref), u2 (ref), u6 (ref), u1 (ref), u5 (ref), u3 (ref), u7 (ref)
        debug.profilebegin("ClientBridge");
        local os_clock_ret = os.clock();
        local v11 = {};
        local v12 = {};
        local v13 = {};

        for i, v in v11 do
            if os_clock_ret - v12[v.replRate] <= 1 / v.replRate - 0.003 then
                table.insert(u4, v);
            else
                table.remove(v11, i);
            end;
        end;

        for _, v in u4 do
            local v14, v15, v16, v17, v18, v19, v20;

            if v12[v.replRate] and os_clock_ret - v12[v.replRate] <= 1 / v.replRate - 0.003 then
                u10[v.replRate] = true;

                if u10[v.replRate] then
                    if u8[v.replRate] == nil then
                        u8[v.replRate] = {};
                        v14 = v;
                    else
                        v14 = v;

                        for _, v2 in u8[v.replRate] do
                            task.spawn(v2);
                        end;
                    end;

                    v12[v14.replRate] = os_clock_ret;

                    for i = 1, #v14.args do
                        if v14.args[i] == nil then
                            v14.args[i] = SerdesLayer.NilIdentifier;
                            v15 = i;
                        else
                            v15 = i;
                        end;
                    end;

                    if v14.requestType == "invoke" then
                        v16 = { v14.remote, u2, v14.uuid };

                        for _, v2 in v14.args do
                            table.insert(v16, v2);
                        end;

                        table.insert(v13, v16);
                    elseif v14.requestType == "send" then
                        v17 = { v14.remote };
                        v18 = u6[SerdesLayer.FromCompressed(v14.remote)];

                        if not v18 then
                            return;
                        end;

                        if #v18._outboundMiddleware == 0 then
                            for _, v2 in v14.args do
                                table.insert(v17, v2);
                            end;
                        else
                            v19 = nil;

                            for _, v2 in v18._outboundMiddleware do
                                if v19 then
                                    v20 = { v2(table.unpack(v19)) };

                                    if #v20 ~= 0 then
                                        v19 = v20;
                                    end;
                                else
                                    v19 = { v2(table.unpack(v14.args)) };
                                end;
                            end;

                            if v19 == nil then
                                v19 = v14.args;
                            end;

                            for _, v2 in v19 do
                                table.insert(v17, v2);
                            end;
                        end;

                        table.insert(v13, v17);
                    end;
                else
                    table.insert(v11, v);
                end;
            else
                if u8[v.replRate] == nil then
                    u8[v.replRate] = {};
                    v14 = v;
                else
                    v14 = v;

                    for _, v2 in u8[v.replRate] do
                        task.spawn(v2);
                    end;
                end;

                v12[v14.replRate] = os_clock_ret;

                for i = 1, #v14.args do
                    if v14.args[i] == nil then
                        v14.args[i] = SerdesLayer.NilIdentifier;
                        v15 = i;
                    else
                        v15 = i;
                    end;
                end;

                if v14.requestType == "invoke" then
                    v16 = { v14.remote, u2, v14.uuid };

                    for _, v2 in v14.args do
                        table.insert(v16, v2);
                    end;

                    table.insert(v13, v16);
                elseif v14.requestType == "send" then
                    v17 = { v14.remote };
                    v18 = u6[SerdesLayer.FromCompressed(v14.remote)];

                    if not v18 then
                        return;
                    end;

                    if #v18._outboundMiddleware == 0 then
                        for _, v2 in v14.args do
                            table.insert(v17, v2);
                        end;
                    else
                        v19 = nil;

                        for _, v2 in v18._outboundMiddleware do
                            if v19 then
                                v20 = { v2(table.unpack(v19)) };

                                if #v20 ~= 0 then
                                    v19 = v20;
                                end;
                            else
                                v19 = { v2(table.unpack(v14.args)) };
                            end;
                        end;

                        if v19 == nil then
                            v19 = v14.args;
                        end;

                        for _, v2 in v19 do
                            table.insert(v17, v2);
                        end;
                    end;

                    table.insert(v13, v17);
                end;
            end;
        end;

        if #v13 ~= 0 then
            u1:FireServer(v13);
        end;

        u4 = v11;

        for _, v in u5 do
            local args = v.args;
            local v21 = #args;
            local u22 = u6[SerdesLayer.FromCompressed(v.remote)];

            if u22 ~= nil then
                local u23 = v;

                for i = 1, #args do
                    local v24;

                    if args[i] == SerdesLayer.NilIdentifier then
                        args[i] = nil;
                        v24 = i;
                    else
                        v24 = i;
                    end;
                end;

                if args[1] == u3 then
                    if args[1] == u3 then
                        local v25 = SerdesLayer.UnpackUUID(args[2]);
                        table.remove(args, 1);
                        table.remove(args, 1);
                        task.spawn(u7[v25], unpack(args, 1, v21 - 2));
                        u7[v25] = nil;
                    end;
                else
                    for _, v2 in u22._connections do
                        task.spawn(function() -- Line: 153
                            -- upvalues: u22 (copy), u23 (copy), v2 (copy)
                            if #u22._inboundMiddleware == 0 then
                                v2(table.unpack(u23.args));

                                return;
                            end;

                            local v26 = nil;

                            for _, v3 in u22._inboundMiddleware do
                                if v26 then
                                    local v27 = { v3(table.unpack(v26)) };

                                    if #v27 ~= 0 then
                                        v26 = v27;
                                    end;
                                else
                                    v26 = { v3(table.unpack(u23.args)) };
                                end;
                            end;

                            if v26 == nil then
                                v26 = u23.args;
                            end;

                            v2(table.unpack(v26));
                        end);
                    end;
                end;
            end;
        end;

        u5 = {};
        debug.profileend();
    end);
    u1.OnClientEvent:Connect(function(p28) -- Line: 193
        -- upvalues: u5 (ref)
        for _, v in p28 do
            local v29 = v[1];
            table.remove(v, 1);
            table.insert(u5, {
                remote = v29,
                args = v
            });
        end;
    end);
end;

function u9.new(p30: string) -- Line: 206
    -- upvalues: u9 (copy), SerdesLayer (copy), u6 (copy)
    local v31 = type(p30) == "string";
    assert(v31, "[BridgeNet] remote name must be a string");
    local v32 = u9.from(p30);

    if v32 ~= nil then
        return v32;
    end;

    local u33 = setmetatable({}, u9);
    u33._name = p30;
    u33._connections = {};
    u33._replRate = 60;
    u33._inboundMiddleware = {};
    u33._outboundMiddleware = {};
    u33._id = SerdesLayer.FromIdentifier(u33._name);

    if u33._id == nil then
        task.spawn(function() -- Line: 226
            -- upvalues: u33 (copy), SerdesLayer (ref)
            local v34 = 0;
            local v35 = v34 + 0.1;

            while true do
                v34 = v34 + task.wait();
                u33._id = SerdesLayer.FromIdentifier(u33._name);

                if v35 < v34 then
                    v35 = v35 + 0.1;
                    print("[BridgeNet] waiting for (" .. u33._name .. ") to be replicated to the client");
                end;

                if u33._id ~= nil or v34 >= 10 then
                    return;
                end;
            end;
        end);
    end;

    u6[u33._name] = u33;

    return u33;
end;

function u9._getReplicationStepSignal(p36: number, p37: function) -- Line: 244
    -- upvalues: u8 (copy)
    if u8[p36] == nil then
        u8[p36] = { p37 };

        return;
    end;

    table.insert(u8[p36], p37);
end;

function u9.from(p38: string) -- Line: 254
    -- upvalues: u6 (copy)
    local v39 = type(p38) == "string";
    assert(v39, "[BridgeNet] Remote name must be a string");

    return u6[p38];
end;

function u9.waitForBridge(p40: string) -- Line: 259
    -- upvalues: u6 (copy)
    while not u6[p40] do
        task.wait();
    end;

    return u6[p40];
end;

function u9._returnQueue() -- Line: 266
    -- upvalues: u4 (ref), u5 (ref)
    return u4, u5;
end;

function u9.Fire(p41, ...) -- Line: 281
    -- upvalues: SerdesLayer (copy), u4 (ref)
    if p41._id == nil then
        p41._id = SerdesLayer.FromIdentifier(p41._name);
    end;

    table.insert(u4, {
        requestType = "send",
        remote = p41._id,
        args = { ... },
        replRate = p41._replRate
    });
end;

function u9.InvokeServerAsync(p42, ...) -- Line: 306
    -- upvalues: SerdesLayer (copy), u7 (copy), u4 (ref)
    if p42._id == nil then
        p42._id = SerdesLayer.FromIdentifier(p42._name);
    end;

    local coroutine_running_ret = coroutine.running();
    local v43 = SerdesLayer.CreateUUID();
    u7[v43] = coroutine_running_ret;
    local v44 = {
        requestType = "invoke",
        remote = p42._id,
        uuid = SerdesLayer.PackUUID(v43),
        args = { ... },
        replRate = p42._replRate
    };
    table.insert(u4, v44);
    local v45 = { coroutine.yield() };

    if v45[1] == "err" then
        error(v45[2], 2);
    end;

    return table.unpack(v45);
end;

function u9.Connect(u46: table, p47: function) -- Line: 346
    -- upvalues: SerdesLayer (copy)
    local v48 = type(p47) == "function";
    assert(v48, "[BridgeNet] Attempt to connect non-function to a Bridge");
    local u49 = SerdesLayer.CreateUUID();
    u46._connections[u49] = p47;

    return {
        Disconnect = function() -- Line: 353, Name: Disconnect
            -- upvalues: u46 (copy), u49 (ref)
            u46._connections[u49] = nil;
            u49 = nil;
        end
    };
end;

function u9.GetName(p50) -- Line: 372
    return p50._name;
end;

function u9.Once(p51: table, u52: function) -- Line: 394
    local u53 = nil;
    u53 = p51:Connect(function(...) -- Line: 396
        -- upvalues: u53 (ref), u52 (copy)
        u53:Disconnect();
        u52(...);
    end);
end;

function u9.SetReplicationRate(p54: table, p55: number) -- Line: 408
    local v56 = typeof(p55) == "number";
    assert(v56, "[BridgeNet] replication rate must be a number");
    p54._replRate = p55;
end;

function u9.SetOutboundMiddleware(p57: table, p58: table) -- Line: 413
    local v59 = typeof(p58) == "table";
    assert(v59, "[BridgeNet] outbound middleware must be a table");
    p57._outboundMiddleware = p58;
end;

function u9.SetInboundMiddleware(p60: table, p61: table) -- Line: 418
    local v62 = typeof(p61) == "table";
    assert(v62, "[BridgeNet] inbound middleware must be a table");
    p60._inboundMiddleware = p61;
end;

function u9.Destroy(p63) -- Line: 436
    -- upvalues: u6 (copy)
    u6[p63._name] = nil;

    for i, v in p63 do
        if type(v) == "number" or type(v) == "string" then
            p63[i] = nil;
        elseif v.Destroy == nil then
            p63[i] = nil;
        else
            v:Destroy();
        end;
    end;

    setmetatable(p63, nil);
end;

return u9;