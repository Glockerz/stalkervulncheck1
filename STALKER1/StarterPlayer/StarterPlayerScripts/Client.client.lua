-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Planck = require(ReplicatedStorage.Packages.Planck)
local v1 = require(ReplicatedStorage.Packages["Planck-Jabby"])
local Jabby = require(ReplicatedStorage.Packages.Jabby)
local Axis = require(ReplicatedStorage.Packages.Axis)
local world = require(ReplicatedStorage.Shared.world)

require(ReplicatedStorage.Shared.components)

local network = require(ReplicatedStorage.Shared.network)
local replicator = require(script.replicator)
local v2 = require(script.systems["replecs-client"])

replicator:init()

local v3, v4 = replicator:verify_handshake((network.Handshake:InvokeServer()))

if v3 then
	local v5, v6, v7, v8, v9, v10, v11

	network.FullState.OnClientEvent:Connect(function(p13, p23) --[[ Line: 28 | Upvalues: replicator (copy) ]]
		replicator:apply_full(p13, p23)
	end)
	network.ClientReady:FireServer()
	Jabby.register({
		name = "Client World",
		applet = Jabby.applets.world,
		configuration = {
			world = world
		}
	})
	v5 = RunService:IsStudio()
	v6 = Axis.input({ Enum.KeyCode.Y })
	v7 = false
	v8 = Planck.Phase
	v9 = Planck.Phase.new()
	v10 = Planck.Phase.new()
	v11 = function() --[[ inputSystem | Line: 58 | Upvalues: v5 (copy), v6 (copy), v7 (ref), Jabby (copy) ]]
		if not v5 then
			return
		end

		v6:update()

		if not v6:pressed() then
			return
		end

		v7 = not v7

		if not v7 then
			return
		end

		local v1 = Jabby.obtain_client()

		v1.spawn_app(v1.apps.home)
	end
	Planck.Scheduler.new():addPlugin(v1.new()):insert(v8.Startup):insert(v9, RunService, "RenderStepped"):insert(v10, RunService, "Heartbeat"):addSystem(v11, v9):addSystem(v2, v10)

	return
end

error("Handshake failed: " .. tostring(v4))