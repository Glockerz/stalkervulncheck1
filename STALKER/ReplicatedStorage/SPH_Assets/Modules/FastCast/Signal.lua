-- Decompiled with Potassium's decompiler.

require(script.Parent.TypeDefinitions);
local TestService = game:GetService("TestService");
local Table = require(script.Parent.Table);
local u1 = {};
u1.__index = u1;
u1.__type = "Signal";
local u2 = {};
u2.__index = u2;
u2.__type = "SignalConnection";

function u1.new(p3: string) -- Line: 44
    -- upvalues: u1 (copy)
    return setmetatable({
        Name = p3,
        Connections = {},
        YieldingThreads = {}
    }, u1);
end;

local function NewConnection(p4: table, p5: any) -- Line: 53
    -- upvalues: u2 (copy)
    return setmetatable({
        Index = -1,
        Signal = p4,
        Delegate = p5
    }, u2);
end;

local function ThreadAndReportError(u6: any, u7: any, p8: string) -- Line: 62
    -- upvalues: TestService (copy)
    local coroutine_create_ret = coroutine.create(function() -- Line: 63
        -- upvalues: u6 (copy), u7 (copy)
        u6(unpack(u7));
    end);
    local coroutine_resume_ret, v9 = coroutine.resume(coroutine_create_ret);

    if not coroutine_resume_ret then
        TestService:Error(string.format("Exception thrown in your %s event handler: %s", p8, v9));
        TestService:Checkpoint(debug.traceback(coroutine_create_ret));
    end;
end;

function u1.Connect(p10, p11) -- Line: 75
    -- upvalues: u1 (copy), u2 (copy), Table (copy)
    local v12 = getmetatable(p10) == u1;
    assert(v12, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Connect", "Signal.new()"));
    local v13 = setmetatable({
        Index = -1,
        Signal = p10,
        Delegate = p11
    }, u2);
    v13.Index = #p10.Connections + 1;
    Table.insert(p10.Connections, v13.Index, v13);

    return v13;
end;

function u1.Fire(p14, ...) -- Line: 83
    -- upvalues: u1 (copy), Table (copy), ThreadAndReportError (copy)
    local v15 = getmetatable(p14) == u1;
    assert(v15, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Fire", "Signal.new()"));
    local v16 = Table.pack(...);
    local Connections = p14.Connections;
    local YieldingThreads = p14.YieldingThreads;

    for i = 1, #Connections do
        local v17 = Connections[i];
        local v18;

        if v17.Delegate == nil then
            v18 = i;
        else
            ThreadAndReportError(v17.Delegate, v16, v17.Signal.Name);
            v18 = i;
        end;
    end;

    for i = 1, #YieldingThreads do
        local v19 = YieldingThreads[i];
        local v20;

        if v19 == nil then
            v20 = i;
        else
            coroutine.resume(v19, ...);
            v20 = i;
        end;
    end;
end;

function u1.FireSync(p21, ...) -- Line: 103
    -- upvalues: u1 (copy), Table (copy)
    local v22 = getmetatable(p21) == u1;
    assert(v22, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("FireSync", "Signal.new()"));
    local v23 = Table.pack(...);
    local Connections = p21.Connections;
    local YieldingThreads = p21.YieldingThreads;

    for i = 1, #Connections do
        local v24 = Connections[i];
        local v25;

        if v24.Delegate == nil then
            v25 = i;
        else
            v24.Delegate(unpack(v23));
            v25 = i;
        end;
    end;

    for i = 1, #YieldingThreads do
        local v26 = YieldingThreads[i];
        local v27;

        if v26 == nil then
            v27 = i;
        else
            coroutine.resume(v26, ...);
            v27 = i;
        end;
    end;
end;

function u1.Wait(p28) -- Line: 123
    -- upvalues: u1 (copy), Table (copy)
    local v29 = getmetatable(p28) == u1;
    assert(v29, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Wait", "Signal.new()"));
    local coroutine_running_ret = coroutine.running();
    Table.insert(p28.YieldingThreads, coroutine_running_ret);
    local v30 = { coroutine.yield() };
    Table.removeObject(p28.YieldingThreads, coroutine_running_ret);

    return unpack(v30);
end;

function u1.Dispose(p31) -- Line: 133
    -- upvalues: u1 (copy)
    local v32 = getmetatable(p31) == u1;
    assert(v32, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "Signal.new()"));
    local Connections = p31.Connections;

    for i = 1, #Connections do
        Connections[i]:Disconnect();
        local _ = i;
    end;

    p31.Connections = {};
    setmetatable(p31, nil);
end;

function u2.Disconnect(p33) -- Line: 143
    -- upvalues: u2 (copy), Table (copy)
    local v34 = getmetatable(p33) == u2;
    assert(v34, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Disconnect", "private function NewConnection()"));
    Table.remove(p33.Signal.Connections, p33.Index);
    p33.SignalStatic = nil;
    p33.Delegate = nil;
    p33.YieldingThreads = {};
    p33.Index = -1;
    setmetatable(p33, nil);
end;

return u1;