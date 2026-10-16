-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local u1 = {};
local u2 = {};
local u3 = 0;
local u4 = {};
local u5 = nil;
local u6 = RunService:IsServer();
u4.NilIdentifier = "null";

local function fromHex(p7: string) -- Line: 24
    return string.gsub(p7, "..", function(p8) -- Line: 25
        local v9 = tonumber(p8, 16);

        return string.char(v9);
    end);
end;

local function toHex(p10: string) -- Line: 30
    return string.gsub(p10, ".", function(p11) -- Line: 31
        return string.format("%02X", string.byte(p11));
    end);
end;

function u4._start() -- Line: 36
    -- upvalues: RunService (copy), u5 (ref), ReplicatedStorage (copy), u2 (copy), u1 (copy)
    if not RunService:IsClient() then
        u5 = Instance.new("Folder");
        u5.Name = "AutoSerde";
        u5.Parent = ReplicatedStorage;

        return;
    end;

    u5 = ReplicatedStorage:WaitForChild("AutoSerde");

    for _, child in u5:GetChildren() do
        u2[child.Name] = child.Value;
        u1[child.Value] = child.Name;
    end;

    u5.ChildAdded:Connect(function(p12: userdata) -- Line: 44
        -- upvalues: u2 (ref), u1 (ref)
        u2[p12.Name] = p12.Value;
        u1[p12.Value] = p12.Name;
    end);
    u5.ChildRemoved:Connect(function(p13: userdata) -- Line: 49
        -- upvalues: u2 (ref), u1 (ref)
        u2[p13.Name] = nil;
        u1[p13.Value] = nil;
    end);
end;

function u4._destroy() -- Line: 61
    -- upvalues: u5 (ref)
    u5:Destroy();
end;

function u4.CreateIdentifier(p14: string) -- Line: 78
    -- upvalues: u2 (copy), u6 (copy), u4 (copy), u3 (ref), u5 (ref), u1 (copy)
    local v15 = type(p14) == "string";
    assert(v15, "ID must be a string");

    if not (u2[p14] or u6) then
        return u4.WaitForIdentifier(p14);
    end;

    if u2[p14] and not u6 then
        return u2[p14];
    end;

    if u3 >= 65536 then
        error("Over the identification cap: " .. p14);
    end;

    u3 = u3 + 1;
    local StringValue = Instance.new("StringValue");
    StringValue.Name = p14;
    StringValue.Value = string.pack("H", u3);
    StringValue.Parent = u5;
    u2[p14] = StringValue.Value;
    u1[StringValue.Value] = p14;

    return StringValue.Value;
end;

function u4.WaitForIdentifier(p16: string) -- Line: 103
    -- upvalues: u2 (copy)
    while u2[p16] == nil do
        task.wait();
    end;

    return u2[p16];
end;

function u4.FromCompressed(p17: string) -- Line: 122
    -- upvalues: u1 (copy)
    return u1[p17];
end;

function u4.FromIdentifier(p18: string) -- Line: 126
    -- upvalues: u2 (copy)
    return u2[p18];
end;

function u4.DestroyIdentifier(p19: string) -- Line: 142
    -- upvalues: u6 (copy), u1 (copy), u2 (copy), u3 (ref), u5 (ref)
    assert(u6, "You cannot destroy identifiers on the client.");
    local v20 = type(p19) == "string";
    assert(v20, "ID must be a string");
    u1[u2[p19]] = nil;
    u2[p19] = nil;
    u3 = u3 - 1;
    u5:FindFirstChild(p19):Destroy();

    return nil;
end;

function u4.CreateUUID() -- Line: 164
    -- upvalues: HttpService (copy)
    return string.gsub(HttpService:GenerateGUID(false), "-", "");
end;

function u4.PackUUID(p21: string) -- Line: 178
    local v22 = typeof(p21) == "string";
    assert(v22, "[BridgeNet] uuid must be a string");

    return string.gsub(p21, "..", function(p23) -- Line: 25
        local v24 = tonumber(p23, 16);

        return string.char(v24);
    end);
end;

function u4.UnpackUUID(p25: string) -- Line: 193
    local v26 = typeof(p25) == "string";
    assert(v26, "[BridgeNet] uuid must be a string");

    return string.gsub(p25, ".", function(p27) -- Line: 31
        return string.format("%02X", string.byte(p27));
    end);
end;

function u4.DictionaryToTable(p28: table) -- Line: 211
    local v29 = typeof(p28) == "table";
    assert(v29, "[BridgeNet] dict must be a dictionary");
    local v30 = getmetatable(p28) == nil;
    assert(v30, "[BridgeNet] Passed dictionary may not have a metatable");
    local v31 = {};

    for i, _ in p28 do
        table.insert(v31, i);
    end;

    table.sort(v31, function(p32, p33) -- Line: 220
        return string.lower(p32) < string.lower(p33);
    end);
    local v34 = {};

    for _, v in v31 do
        table.insert(v34, p28[v]);
    end;

    return v34;
end;

return u4;