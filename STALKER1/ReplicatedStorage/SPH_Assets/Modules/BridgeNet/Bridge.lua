-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 9 ]]
	if p1 == nil then
		return {
			_isBridge = true
		}
	end

	return {
		_isBridge = true,
		inbound = p1.InboundMiddleware,
		outbound = p1.OutboundMiddleware,
		rate = p1.maxRatePerMinute,
		replicationrate = p1.ReplicationRate
	}
end