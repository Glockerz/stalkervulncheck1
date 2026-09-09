-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local network = require(ReplicatedStorage.Shared.network)
local replicator = require(script.Parent.Parent.replicator)
local t = {}
local t2 = {}

network.Updates.OnClientEvent:Connect(function(p1, p2) --[[ Line: 10 | Upvalues: t (copy) ]]
	table.insert(t, { p1, p2 })
end)
network.Unreliable.OnClientEvent:Connect(function(p1, p2) --[[ Line: 14 | Upvalues: t2 (copy) ]]
	table.insert(t2, { p1, p2 })
end)

return function() --[[ replecsClient | Line: 18 | Upvalues: t (copy), replicator (copy), t2 (copy) ]]
	for v1, v2 in t do
		replicator:apply_updates(v2[1], v2[2])
	end

	table.clear(t)

	for v3, v4 in t2 do
		replicator:apply_unreliable(v4[1], v4[2])
	end

	table.clear(t2)
end