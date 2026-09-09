-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ServerBridge = require(script.Parent.ServerBridge)
local ClientBridge = require(script.Parent.ClientBridge)

local function search(p1, p2) --[[ search | Line: 6 | Upvalues: RunService (copy), ServerBridge (copy), ClientBridge (copy) ]]
	local v1 = if RunService:IsServer() then ServerBridge.new(p1) else ClientBridge.new(p1)

	if p2.server and RunService:IsServer() then
		if p2.outboundmiddleware then
			v1:SetOutboundMiddleware(p2.outboundmiddleware)
		end

		if p2.inboundmiddleware then
			v1:SetInboundMiddleware(p2.inboundmiddleware)
		end
	end

	if p2.client and not RunService:IsServer() then
		if p2.outboundmiddleware then
			v1:SetOutboundMiddleware(p2.outboundmiddleware)
		end

		if p2.inboundmiddleware then
			v1:SetInboundMiddleware(p2.inboundmiddleware)
		end
	end

	if p2.replicationrate then
		v1:SetReplicationRate(p2.replicationrate)
	end

	return v1
end

local function v1(p1) --[[ recursiveSearch | Line: 39 | Upvalues: search (copy), v1 (copy) ]]
	local t = {}

	for v12, v2 in p1 do
		assert(if type(v2) == "table" then true else false, "Everything in BridgeNet.CreateBridgeTree must be a dictionary or BridgeNet.Bridge()")

		if v2._isBridge == true then
			t[v12] = search(v12, v2)

			continue
		end

		t[v12] = v1(v2)
	end

	return t
end

return v1