-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Replecs = require(ReplicatedStorage.Packages.Replecs);
local world = require(ReplicatedStorage.Shared.world);

return Replecs.create(world);