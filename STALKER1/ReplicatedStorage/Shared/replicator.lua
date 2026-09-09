-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Replecs = require(ReplicatedStorage.Packages.Replecs)
local world = require(ReplicatedStorage.Shared.world)

return Replecs.create(world)