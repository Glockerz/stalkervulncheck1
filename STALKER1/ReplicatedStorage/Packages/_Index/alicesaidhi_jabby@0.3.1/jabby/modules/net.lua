-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local signal = require(script.Parent.signal)
local vm_id = require(script.Parent.vm_id)
local traffic_check = require(script.Parent.traffic_check)

require(script.Parent.types)

local v1 = if RunService:IsServer() then "server" else Players.LocalPlayer

local function tincoming_connector(p1) --[[ tincoming_connector | Line: 26 ]]
	if typeof(p1) ~= "table" then
		return false
	end

	if p1.host ~= "server" and (typeof(p1.host) ~= "Instance" or not p1.host:IsA("Player")) then
		return false
	end

	if typeof(p1.from_vm) ~= "number" then
		return false
	end

	if p1.to_vm == nil then
		return true
	end

	if typeof(p1.to_vm) == "number" then
		return true
	end

	return false
end

local v2 = false
local JABBY_REMOTES

if RunService:IsServer() then
	local JABBY_REMOTES2 = ReplicatedStorage:FindFirstChild("JABBY_REMOTES")

	if JABBY_REMOTES2 then
		JABBY_REMOTES = JABBY_REMOTES2
	else
		warn("There\'s a bug with jabby that sometimes causes the JABBY_REMOTES folder to not replicate very rarely. Unfortunately, I still haven\'t thought of a fix yet -,- so please instead clone the JABBY_REMOTES folder into your game which should stop it. make sure to set archivable to true!")
		JABBY_REMOTES = Instance.new("Folder")
		JABBY_REMOTES.Name = "JABBY_REMOTES"
		JABBY_REMOTES.Archivable = false
		JABBY_REMOTES.Parent = ReplicatedStorage
		v2 = true
	end
else
	JABBY_REMOTES = ReplicatedStorage:WaitForChild("JABBY_REMOTES")
end

local function get_remote_event(p1, p2) --[[ get_remote_event | Line: 57 | Upvalues: RunService (copy), JABBY_REMOTES (ref), v2 (ref) ]]
	if not RunService:IsServer() then
		return JABBY_REMOTES:WaitForChild(p1)
	end

	local v1 = JABBY_REMOTES:FindFirstChild(p1)

	if not v1 then
		if not v2 then
			warn((("btw, you are missing %* from the JABBY_REMOTES folder"):format(p1)))
		end

		local v4 = Instance.new(if p2 then "UnreliableRemoteEvent" else "RemoteEvent")

		v4.Name = p1
		v4.Parent = JABBY_REMOTES

		local actor = Instance.new("BindableEvent")

		actor.Name = "actor"
		actor.Parent = v4

		local peer = Instance.new("RemoteEvent")

		peer.Name = "peer"
		peer.Parent = v4
		v1 = v4
	end

	return v1
end

return {
	create_event = function(p1, p2, p3) --[[ create_event | Line: 84 | Upvalues: get_remote_event (copy), signal (copy), traffic_check (copy), v1 (ref), vm_id (copy), RunService (copy), tincoming_connector (copy) ]]
		local v12 = get_remote_event(p1, p2)
		local v2, v3 = signal()
		local t = {
			type = "event",
			fire = function(p1, p2, ...) --[[ fire | Line: 91 | Upvalues: traffic_check (ref), v1 (ref), vm_id (ref), v3 (copy), v12 (copy) ]]
				if not traffic_check.check(v1, p2.host, true) then
					return
				end

				if p2.host == v1 and p2.to_vm == vm_id then
					v3({
						host = v1,
						from_vm = vm_id,
						to_vm = p2.to_vm
					}, ...)

					return
				end

				if p2.host == v1 and p2.to_vm ~= vm_id then
					v12.actor:Fire({
						host = v1,
						from_vm = vm_id,
						to_vm = p2.to_vm
					}, ...)

					return
				end

				if p2.host == "server" then
					v12:FireServer({
						host = "server",
						from_vm = vm_id,
						to_vm = p2.to_vm
					}, ...)

					return
				end

				if v1 == "server" then
					v12:FireClient(p2.host, {
						host = "server",
						from_vm = vm_id,
						to_vm = p2.to_vm
					}, ...)
				else
					v12:FireServer({
						host = p2.host,
						from_vm = vm_id,
						to_vm = p2.to_vm
					}, ...)
				end
			end,
			connect = function(p1, p2) --[[ connect | Line: 152 | Upvalues: v2 (copy) ]]
				return v2:connect(p2)
			end
		}

		if RunService:IsServer() then
			v12.OnServerEvent:Connect(function(p1, p2, ...) --[[ Line: 158 | Upvalues: p3 (copy), traffic_check (ref), tincoming_connector (ref), vm_id (ref), v3 (copy), v12 (copy) ]]
				if not (p3 or traffic_check.check(p1, p2.host)) then
					return
				end

				if not tincoming_connector(p2) then
					return
				end

				if p2.host == "server" and (p2.to_vm == vm_id or p2.to_vm == nil) then
					p2.host = p1
					v3(p2, ...)
				else
					if p2.host == "server" or vm_id ~= 0 then
						return
					end

					local host = p2.host

					p2.host = p1
					v12:FireClient(host, p2, ...)
				end
			end)
		else
			v12.OnClientEvent:Connect(function(p1, ...) --[[ Line: 181 | Upvalues: tincoming_connector (ref), vm_id (ref), traffic_check (ref), v1 (ref), v3 (copy) ]]
				if tincoming_connector(p1) == false then
					return
				end

				if p1.to_vm ~= vm_id and p1.to_vm ~= nil then
					return
				end

				traffic_check._whitelist(v1, p1.host)
				v3(p1, ...)
			end)
		end

		v12:WaitForChild("actor").Event:Connect(function(p1, ...) --[[ Line: 191 | Upvalues: vm_id (ref), v3 (copy) ]]
			if p1.to_vm ~= vm_id and p1.to_vm ~= nil then
				return
			end

			v3(p1, ...)
		end)

		return t
	end,
	local_host = v1
}