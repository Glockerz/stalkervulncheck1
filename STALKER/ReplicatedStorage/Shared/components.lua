-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Jecs = require(ReplicatedStorage.Packages.Jecs);
local Replecs = require(ReplicatedStorage.Packages.Replecs);
local world = require(ReplicatedStorage.Shared.world);
local v1 = {};
local v2 = {};

for i, v in v1 do
    world:add(v, Replecs.shared);
    world:set(v, Jecs.Name, i);
end;

for i, v in v1 do
    v2[i] = v;
end;

return v2;