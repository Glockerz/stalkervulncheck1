-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SerdesLayer = require(script.Parent.SerdesLayer);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = nil;
local u6 = nil;
local u7 = nil;

local function deepCopy(p8) -- Line: 27
    -- upvalues: deepCopy (copy)
    local v9 = {};

    for i, v in p8 do
        if typeof(v) == "table" then
            v9[i] = deepCopy(v);
        elseif typeof(v) == "userdata" then
            warn("warning: copying userdata? you should never see this.");
            v9[i] = v;
        else
            v9[i] = v;
        end;
    end;

    return v9;
end;

local u10 = {};
u10.__index = u10;

function u10._start() -- Line: 55
    -- upvalues: u5 (ref), ReplicatedStorage (copy), u6 (ref), SerdesLayer (copy), u7 (ref), RunService (copy), u2 (copy), u4 (copy), u1 (copy), u3 (copy)
    u5 = Instance.new("RemoteEvent");
    u5.Name = "RemoteEvent";
    u5.Parent = ReplicatedStorage;
    u6 = SerdesLayer.CreateIdentifier("Invoke");
    u7 = SerdesLayer.CreateIdentifier("InvokeReply");
    local u11 = {};
    RunService.Heartbeat:Connect(function() -- Line: 65
        -- upvalues: u2 (ref), SerdesLayer (ref), u4 (ref), u6 (ref), u1 (ref), u11 (copy), u3 (ref), u7 (ref), u5 (ref)
        debug.profilebegin("ServerBridge");
        local os_clock_ret = os.clock();

        for _, v in u2 do
            local u12 = v;

            for i = 1, #v.args do
                local v13;

                if u12.args[i] == SerdesLayer.NilIdentifier then
                    u12.args[i] = nil;
                    v13 = i;
                else
                    v13 = i;
                end;
            end;

            local u14 = u4[SerdesLayer.FromCompressed(u12.remote)];

            if u14 ~= nil then
                if u12.args[1] == u6 then
                    if u14._onInvoke == nil then
                        local args = u12.args;
                        local v15 = args[2];
                        table.remove(args, 1);
                        table.remove(args, 1);
                        table.insert(u1, {
                            invokeReply = true,
                            replRate = 60,
                            plrs = u12.plr,
                            remote = u14._id,
                            uuid = v15,
                            args = { "err", "onInvoke has not yet been registered on the server for " .. u14._name }
                        });
                    else
                        task.spawn(function() -- Line: 92
                            -- upvalues: u12 (copy), u1 (ref), u14 (copy)
                            local args = u12.args;
                            local v16 = args[2];
                            table.remove(args, 1);
                            table.remove(args, 1);
                            local v17 = {
                                invokeReply = true,
                                replRate = 60,
                                plrs = u12.plr,
                                remote = u14._id,
                                uuid = v16,
                                args = { u14._onInvoke(u12.plr, unpack(u12.args)) }
                            };
                            table.insert(u1, v17);
                        end);
                    end;
                else
                    debug.profilebegin(string.format("connections_%s", u14._name));

                    for _, v2 in u14._connections do
                        task.spawn(function() -- Line: 129
                            -- upvalues: u14 (copy), u12 (copy), v2 (copy)
                            if #u14._inboundMiddleware == 0 then
                                v2(u12.plr, table.unpack(u12.args));

                                return;
                            end;

                            local v18 = nil;

                            for _, v3 in u14._inboundMiddleware do
                                if v18 then
                                    local v19 = { v3(table.unpack(v18)) };

                                    if #v19 ~= 0 then
                                        v18 = v19;
                                    end;
                                else
                                    v18 = { v3(table.unpack(u12.args)) };
                                end;
                            end;

                            if v18 == nil then
                                v18 = u12.args;
                            end;

                            v2(u12.plr, table.unpack(v18));
                        end);
                    end;

                    debug.profileend();
                end;
            end;
        end;

        table.clear(u2);
        local v20 = {};
        local v21 = {};
        local v22 = {};
        local v23 = {};

        for i, v in v20 do
            if os_clock_ret - u11[v.replRate] <= 1 / v.replRate - 0.003 then
                table.insert(u1, v);
            else
                table.remove(v20, i);
            end;
        end;

        for _, v in u1 do
            local v24, v25, v26, v27, v28, v29, v30;

            if u11[v.replRate] and os_clock_ret - u11[v.replRate] <= 1 / v.replRate - 0.003 then
                v21[v.replRate] = true;

                if v21[v.replRate] then
                    if u3[v.replRate] == nil then
                        u3[v.replRate] = {};
                        v24 = v;
                    else
                        v24 = v;

                        for _, v2 in u3[v.replRate] do
                            task.spawn(v2);
                        end;
                    end;

                    for i = 1, #v24.args do
                        if v24.args[i] == nil then
                            v24.args[i] = SerdesLayer.NilIdentifier;
                            v25 = i;
                        else
                            v25 = i;
                        end;
                    end;

                    if v24.invokeReply then
                        if v24.invokeReply then
                            if v22[v24.plrs] == nil then
                                v22[v24.plrs] = {};
                            end;

                            v26 = { v24.remote, u7, v24.uuid };

                            for _, v2 in v24.args do
                                table.insert(v26, v2);
                            end;

                            table.insert(v23, v26);
                        end;
                    else
                        v27 = { v24.remote };
                        v28 = u4[SerdesLayer.FromCompressed(v24.remote)];

                        if #v28._outboundMiddleware == 0 then
                            for _, v2 in v24.args do
                                table.insert(v27, v2);
                            end;
                        else
                            v29 = nil;

                            for _, v2 in v28._outboundMiddleware do
                                if v29 then
                                    v30 = { v2(table.unpack(v29)) };

                                    if #v30 ~= 0 then
                                        v29 = v30;
                                    end;
                                else
                                    v29 = { v2(table.unpack(v24.args)) };
                                end;
                            end;

                            if v29 == nil then
                                v29 = v24.args;
                            end;

                            for _, v2 in v29 do
                                table.insert(v27, v2);
                            end;
                        end;

                        if v24.plrs == "all" then
                            table.insert(v23, v27);
                        elseif typeof(v24.plrs) == "table" then
                            for _, v2 in v24.plrs do
                                if v22[v2] == nil then
                                    v22[v2] = {};
                                end;

                                table.insert(v22[v2], v27);
                            end;
                        elseif v22[v24.plrs] == nil then
                            v22[v24.plrs] = { v27 };
                        else
                            table.insert(v22[v24.plrs], v27);
                        end;
                    end;
                else
                    table.insert(v20, v);
                end;
            else
                if u3[v.replRate] == nil then
                    u3[v.replRate] = {};
                    v24 = v;
                else
                    v24 = v;

                    for _, v2 in u3[v.replRate] do
                        task.spawn(v2);
                    end;
                end;

                for i = 1, #v24.args do
                    if v24.args[i] == nil then
                        v24.args[i] = SerdesLayer.NilIdentifier;
                        v25 = i;
                    else
                        v25 = i;
                    end;
                end;

                if v24.invokeReply then
                    if v24.invokeReply then
                        if v22[v24.plrs] == nil then
                            v22[v24.plrs] = {};
                        end;

                        v26 = { v24.remote, u7, v24.uuid };

                        for _, v2 in v24.args do
                            table.insert(v26, v2);
                        end;

                        table.insert(v23, v26);
                    end;
                else
                    v27 = { v24.remote };
                    v28 = u4[SerdesLayer.FromCompressed(v24.remote)];

                    if #v28._outboundMiddleware == 0 then
                        for _, v2 in v24.args do
                            table.insert(v27, v2);
                        end;
                    else
                        v29 = nil;

                        for _, v2 in v28._outboundMiddleware do
                            if v29 then
                                v30 = { v2(table.unpack(v29)) };

                                if #v30 ~= 0 then
                                    v29 = v30;
                                end;
                            else
                                v29 = { v2(table.unpack(v24.args)) };
                            end;
                        end;

                        if v29 == nil then
                            v29 = v24.args;
                        end;

                        for _, v2 in v29 do
                            table.insert(v27, v2);
                        end;
                    end;

                    if v24.plrs == "all" then
                        table.insert(v23, v27);
                    elseif typeof(v24.plrs) == "table" then
                        for _, v2 in v24.plrs do
                            if v22[v2] == nil then
                                v22[v2] = {};
                            end;

                            table.insert(v22[v2], v27);
                        end;
                    elseif v22[v24.plrs] == nil then
                        v22[v24.plrs] = { v27 };
                    else
                        table.insert(v22[v24.plrs], v27);
                    end;
                end;
            end;
        end;

        if #v23 ~= 0 then
            u5:FireAllClients(v23);
        end;

        for i, v in v22 do
            u5:FireClient(i, v);
        end;

        table.clear(u1);

        for i, _ in v21 do
            v21[i] = false;
        end;

        debug.profileend();
    end);
    u5.OnServerEvent:Connect(function(p31, p32) -- Line: 279
        -- upvalues: u2 (ref)
        for _, v in p32 do
            local v33 = v[1];
            table.remove(v, 1);
            table.insert(u2, {
                remote = v33,
                plr = p31,
                args = v
            });
        end;
    end);

    return nil;
end;

function u10._getReplicationStepSignal(p34: number, p35: function) -- Line: 296
    -- upvalues: u3 (copy)
    if u3[p34] == nil then
        u3[p34] = { p35 };

        return;
    end;

    table.insert(u3[p34], p35);
end;

function u10._returnQueue() -- Line: 306
    -- upvalues: u1 (copy), u2 (copy)
    return u1, u2;
end;

function u10._destroy() -- Line: 327
    -- upvalues: u5 (ref)
    u5:Destroy();
end;

function u10.new(p36: string) -- Line: 331
    -- upvalues: u10 (copy), SerdesLayer (copy), u4 (copy)
    local v37 = type(p36) == "string";
    assert(v37, "[BridgeNet] Remote name must be a string");
    local v38 = u10.from(p36);

    if v38 ~= nil then
        return v38;
    end;

    local v39 = setmetatable({}, u10);
    v39._name = p36;
    v39._onInvoke = nil;
    v39._connections = {};
    v39._replRate = 60;
    v39._rateLimit = nil;
    v39._rateHandler = nil;
    v39._rateInThisMinute = {
        num = 0,
        min = 0
    };
    v39._id = SerdesLayer.CreateIdentifier(p36);
    v39._outboundMiddleware = {};
    v39._inboundMiddleware = {};
    u4[v39._name] = v39;

    return v39;
end;

function u10.from(p40: string) -- Line: 364
    -- upvalues: u4 (copy)
    return u4[p40];
end;

function u10.waitForBridge(p41: string) -- Line: 368
    -- upvalues: u4 (copy)
    local v42;

    while true do
        v42 = u4[p41];

        if v42 then
            break;
        end;

        task.wait();
    end;

    return v42;
end;

function u10.FireTo(p43: table, p44: userdata, ...) -- Line: 390
    -- upvalues: u1 (copy)
    table.insert(u1, {
        plrs = p44,
        remote = p43._id,
        args = { ... },
        replRate = p43._replRate
    });
end;

function u10.OnInvoke(p45: table, u46: function) -- Line: 417
    function p45._onInvoke(...) -- Line: 418
        -- upvalues: u46 (copy)
        local success, result = pcall(function(...) -- Line: 419
            -- upvalues: u46 (ref)
            return table.pack(u46(...));
        end, ...);

        if success == true then
            return table.unpack(result);
        end;

        return "err", result;
    end;
end;

function u10.FireToAllExcept(p47, p48, ...) -- Line: 446
    -- upvalues: Players (copy), u1 (copy)
    local v49 = {};

    for _, v in Players:GetPlayers() do
        if typeof(p48) == "table" then
            if not table.find(p48, v) then
                table.insert(v49, v);
            end;
        elseif p48 ~= v then
            table.insert(v49, v);
        end;
    end;

    table.insert(u1, {
        plrs = v49,
        remote = p47._id,
        args = { ... },
        replRate = p47._replRate
    });

    return v49;
end;

function u10.FireAllInRangeExcept(p50: table, p51: any, p52: vector, p53: number, ...) -- Line: 496
    -- upvalues: Players (copy), u1 (copy)
    local v54 = {};

    for _, v in Players:GetPlayers() do
        if v:DistanceFromCharacter(p52) <= p53 then
            if typeof(p51) == "table" then
                if not table.find(p51, v) then
                    table.insert(v54, v);
                end;
            elseif p51 ~= v then
                table.insert(v54, v);
            end;
        end;
    end;

    table.insert(u1, {
        plrs = v54,
        remote = p50._id,
        args = { ... },
        replRate = p50._replRate
    });

    return v54;
end;

function u10.FireAllInRange(p55: table, p56: vector, p57: number, ...) -- Line: 551
    -- upvalues: Players (copy), u1 (copy)
    local v58 = typeof(p56) == "Vector3";
    assert(v58, "[BridgeNet] point must be a Vector3");
    local v59 = typeof(p57) == "number";
    assert(v59, "[BridgeNet] range must be a number");
    local v60 = {};

    for _, v in Players:GetPlayers() do
        if v:DistanceFromCharacter(p56) <= p57 then
            table.insert(v60, v);
        end;
    end;

    table.insert(u1, {
        plrs = v60,
        remote = p55._id,
        args = { ... },
        replRate = p55._replRate
    });

    return v60;
end;

function u10.FireAll(p61, ...) -- Line: 584
    -- upvalues: u1 (copy)
    table.insert(u1, {
        plrs = "all",
        remote = p61._id,
        args = { ... },
        replRate = p61._replRate
    });

    return nil;
end;

function u10.FireToMultiple(p62: table, p63: table, ...) -- Line: 608
    -- upvalues: u1 (copy)
    local v64 = type(p63) == "table";
    assert(v64, "[BridgeNet] First argument must be a table!");
    table.insert(u1, {
        plrs = p63,
        remote = p62._id,
        args = { ... },
        replRate = p62._replRate
    });

    return nil;
end;

function u10.SetInboundMiddleware(p65: table, p66: table) -- Line: 647
    local v67 = typeof(p66) == "table";
    assert(v67, "[BridgeNet] middlewareTable must be a table");
    p65._inboundMiddleware = p66 or {};
end;

function u10.SetOutboundMiddleware(p68: table, p69: table) -- Line: 675
    local v70 = typeof(p69) == "table";
    assert(v70, "[BridgeNet] middlewareTable must be a table");
    p68._outboundMiddleware = p69 or {};
end;

function u10.Once(p71: table, u72: function) -- Line: 698
    local u73 = nil;
    u73 = p71:Connect(function(...) -- Line: 700
        -- upvalues: u73 (ref), u72 (copy)
        u73:Disconnect();
        u72(...);
    end);
end;

function u10.Connect(u74: table, p75: function) -- Line: 719
    -- upvalues: SerdesLayer (copy)
    local v76 = type(p75) == "function";
    assert(v76, "[BridgeNet] attempt to connect non-function to a Bridge");
    local u77 = SerdesLayer.CreateUUID();
    u74._connections[u77] = p75;

    return {
        Disconnect = function() -- Line: 726, Name: Disconnect
            -- upvalues: u74 (copy), u77 (ref)
            u74._connections[u77] = nil;
            u77 = nil;
        end
    };
end;

function u10.GetName(p78) -- Line: 745
    return p78._name;
end;

function u10.SetReplicationRate(p79, p80) -- Line: 754
    p79._replRate = p80;
end;

function u10.Destroy(p81) -- Line: 770
    -- upvalues: u4 (copy), SerdesLayer (copy)
    u4[p81._name] = nil;
    SerdesLayer.DestroyIdentifier(p81.Name);

    for i, v in p81 do
        if v.Destroy == nil then
            p81[i] = nil;
        else
            v:Destroy();
        end;
    end;

    setmetatable(p81, nil);
end;

return u10;