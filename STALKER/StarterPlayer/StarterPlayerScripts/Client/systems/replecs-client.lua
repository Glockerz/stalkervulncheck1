-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local network = require(ReplicatedStorage.Shared.network);
local replicator = require(script.Parent.Parent.replicator);
local u1 = {};
local u2 = {};
network.Updates.OnClientEvent:Connect(function(p3, p4) -- Line: 10
    -- upvalues: u1 (copy)
    table.insert(u1, { p3, p4 });
end);
network.Unreliable.OnClientEvent:Connect(function(p5, p6) -- Line: 14
    -- upvalues: u2 (copy)
    table.insert(u2, { p5, p6 });
end);

return function() -- Line: 18, Name: replecsClient
    -- upvalues: u1 (copy), replicator (copy), u2 (copy)
    for _, v in u1 do
        replicator:apply_updates(v[1], v[2]);
    end;

    table.clear(u1);

    for _, v in u2 do
        replicator:apply_unreliable(v[1], v[2]);
    end;

    table.clear(u2);
end;