-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplecsRemotes = ReplicatedStorage:FindFirstChild("ReplecsRemotes");

if not ReplecsRemotes then
    ReplecsRemotes = Instance.new("Folder");
    ReplecsRemotes.Name = "ReplecsRemotes";
    ReplecsRemotes.Parent = ReplicatedStorage;
end;

local function getOrCreate(p1: string, p2: string) -- Line: 11
    -- upvalues: ReplecsRemotes (ref)
    local v3 = ReplecsRemotes:FindFirstChild(p1);

    if v3 then
        return v3;
    end;

    local Instance_new_ret = Instance.new(p2);
    Instance_new_ret.Name = p1;
    Instance_new_ret.Parent = ReplecsRemotes;

    return Instance_new_ret;
end;

local v4 = {};
local Handshake = ReplecsRemotes:FindFirstChild("Handshake");

if not Handshake then
    Handshake = Instance.new("RemoteFunction");
    Handshake.Name = "Handshake";
    Handshake.Parent = ReplecsRemotes;
end;

v4.Handshake = Handshake;
local FullState = ReplecsRemotes:FindFirstChild("FullState");

if not FullState then
    FullState = Instance.new("RemoteEvent");
    FullState.Name = "FullState";
    FullState.Parent = ReplecsRemotes;
end;

v4.FullState = FullState;
local Updates = ReplecsRemotes:FindFirstChild("Updates");

if not Updates then
    Updates = Instance.new("RemoteEvent");
    Updates.Name = "Updates";
    Updates.Parent = ReplecsRemotes;
end;

v4.Updates = Updates;
local Unreliable = ReplecsRemotes:FindFirstChild("Unreliable");

if not Unreliable then
    Unreliable = Instance.new("UnreliableRemoteEvent");
    Unreliable.Name = "Unreliable";
    Unreliable.Parent = ReplecsRemotes;
end;

v4.Unreliable = Unreliable;
local ClientReady = ReplecsRemotes:FindFirstChild("ClientReady");

if not ClientReady then
    ClientReady = Instance.new("RemoteEvent");
    ClientReady.Name = "ClientReady";
    ClientReady.Parent = ReplecsRemotes;
end;

v4.ClientReady = ClientReady;

return v4;