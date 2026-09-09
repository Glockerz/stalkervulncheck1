-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local SerdesLayer = require(script.SerdesLayer)
local ServerBridge = require(script.ServerBridge)
local ClientBridge = require(script.ClientBridge)
local CreateBridgeTree = require(script.CreateBridgeTree)
local Bridge = require(script.Bridge)
local v1 = RunService:IsServer()

script.Destroying:Connect(function() --[[ Line: 118 | Upvalues: SerdesLayer (copy), v1 (copy), ServerBridge (copy) ]]
	SerdesLayer._destroy()

	if not v1 then
		return
	end

	ServerBridge._destroy()
end)
SerdesLayer._start()

if v1 then
	ServerBridge._start()
else
	ClientBridge._start()
end

return {
	CreateBridgeTree = CreateBridgeTree,
	Bridge = Bridge,
	Identifiers = function(p1) --[[ Identifiers | Line: 136 | Upvalues: SerdesLayer (copy) ]]
		local t = {}

		for v1, v2 in p1 do
			t[v2] = SerdesLayer.CreateIdentifier(v2)
		end

		return t
	end,
	CreateIdentifier = SerdesLayer.CreateIdentifier,
	DestroyIdentifier = SerdesLayer.DestroyIdentifier,
	CreateUUID = SerdesLayer.CreateUUID,
	PackUUID = SerdesLayer.PackUUID,
	UnpackUUID = SerdesLayer.UnpackUUID,
	DictionaryToTable = SerdesLayer.DictionaryToTable,
	ReplicationStep = function(p1, p2) --[[ ReplicationStep | Line: 163 | Upvalues: v1 (copy), ServerBridge (copy), ClientBridge (copy) ]]
		if v1 then
			return ServerBridge._getReplicationStepSignal(p1, p2)
		end

		return ClientBridge._getReplicationStepSignal(p1, p2)
	end,
	GetQueue = function() --[[ GetQueue | Line: 171 | Upvalues: v1 (copy), ServerBridge (copy), ClientBridge (copy) ]]
		if v1 then
			local v12, v2 = ServerBridge._returnQueue()

			return v12, v2
		end

		local v3, v4 = ClientBridge._returnQueue()

		return v3, v4
	end,
	CreateBridge = function(p1) --[[ CreateBridge | Line: 181 | Upvalues: v1 (copy), ServerBridge (copy), ClientBridge (copy) ]]
		if v1 then
			return ServerBridge.new(p1)
		end

		return ClientBridge.new(p1)
	end
}