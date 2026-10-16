-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).console;
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata) -- Line: 47
    -- upvalues: u1 (copy)
    return setmetatable({
        _status = "Disabled",
        _isResuming = false,
        _suspendedEventQueue = {},
        _connections = {},
        _listeners = {},
        _instance = p2
    }, u1);
end;

function u1.connectEvent(p3, p4, p5) -- Line: 75
    p3:_connect(p4, p3._instance[p4], p5);
end;

function u1.connectPropertyChange(p6, p7, p8) -- Line: 79
    local success, result = pcall(p6._instance.GetPropertyChangedSignal, p6._instance, p7);

    if not success then
        error(string.format("Cannot get changed signal on property %q: %s", tostring(p7), result), 0);
    end;

    p6:_connect("Change." .. p7, result, p8);
end;

function u1._connect(u9, u10, p11, p12) -- Line: 97
    if p12 == nil then
        if u9._connections[u10] ~= nil then
            u9._connections[u10]:Disconnect();
            u9._connections[u10] = nil;
        end;

        u9._listeners[u10] = nil;

        return;
    end;

    if u9._connections[u10] == nil then
        u9._connections[u10] = p11:Connect(function(...) -- Line: 108
            -- upvalues: u9 (copy), u10 (copy)
            if u9._status == "Enabled" then
                u9._listeners[u10](u9._instance, ...);

                return;
            end;

            if u9._status == "Suspended" then
                local v13 = { u10, select("#", ...), ... };
                table.insert(u9._suspendedEventQueue, v13);
            end;
        end);
    end;

    u9._listeners[u10] = p12;
end;

function u1.suspend(p14) -- Line: 128
    p14._status = "Suspended";
end;

function u1.resume(p15) -- Line: 132
    -- upvalues: console (copy)
    if p15._isResuming then
        return;
    end;

    p15._isResuming = true;

    for _, v in p15._suspendedEventQueue do
        local v16 = p15._listeners[v[1]];
        local v17 = v[2];

        if v16 ~= nil then
            local coroutine_create_ret = coroutine.create(v16);
            local coroutine_resume_ret, v18 = coroutine.resume(coroutine_create_ret, p15._instance, unpack(v, 3, 2 + v17));

            if not coroutine_resume_ret then
                console.warn("%s", v18);
            end;
        end;
    end;

    p15._isResuming = false;
    p15._status = "Enabled";
    table.clear(p15._suspendedEventQueue);
end;

return u1;