-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local loop = require(script.Parent.modules.loop)
local remotes = require(script.Parent.modules.remotes)
local traffic_check = require(script.Parent.modules.traffic_check)
local vm_id = require(script.Parent.modules.vm_id)

local function broadcast() --[[ broadcast | Line: 8 | Upvalues: Players (copy), traffic_check (copy), remotes (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		if traffic_check.can_use_jabby(v2) then
			remotes.new_server_registered:fire({
				host = v2
			})
		end
	end
end

task.delay(0, broadcast)

local systems = script.systems

RunService.PostSimulation:Connect((loop(("jabby-host:%*-vm:%*"):format(if RunService:IsServer() then "server" else "client", vm_id), nil, {
	i = 1
}, systems.ping, systems.replicate_core, systems.replicate_scheduler, systems.replicate_registry, systems.replicate_system_watch, systems.mouse_pointer, systems.entity)))

return {
	broadcast = broadcast
}