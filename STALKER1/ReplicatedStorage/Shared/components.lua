-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local Replecs = require(ReplicatedStorage.Packages.Replecs)
local world = require(ReplicatedStorage.Shared.world)
local t = {}
local t2 = {}

for v1, v2 in t do
	world:add(v2, Replecs.shared)
	world:set(v2, Jecs.Name, v1)
end

for v3, v4 in t do
	t2[v3] = v4
end

return t2