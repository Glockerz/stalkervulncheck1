-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local net = require(script.Parent.Parent.Parent.modules.net)
local queue = require(script.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.modules.remotes)
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector)
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check)

return function() --[[ Line: 10 | Upvalues: queue (copy), remotes (copy), Players (copy), traffic_check (copy), net (copy), reverse_connector (copy) ]]
	local v1 = queue(remotes.ping)

	for v2, v3 in Players:GetPlayers() do
		if traffic_check.communication_is_allowed(net.local_host, v3, true) then
			remotes.new_server_registered:fire({
				host = v3
			})
		end
	end

	return function() --[[ Line: 22 | Upvalues: v1 (copy), reverse_connector (ref), remotes (ref) ]]
		for v12 in v1:iter() do
			remotes.new_server_registered:fire((reverse_connector(v12)))
		end
	end
end