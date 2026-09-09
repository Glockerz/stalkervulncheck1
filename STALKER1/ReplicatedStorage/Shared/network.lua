-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplecsRemotes = ReplicatedStorage:FindFirstChild("ReplecsRemotes")

if not ReplecsRemotes then
	ReplecsRemotes = Instance.new("Folder")
	ReplecsRemotes.Name = "ReplecsRemotes"
	ReplecsRemotes.Parent = ReplicatedStorage
end

local function getOrCreate(p1, p2) --[[ getOrCreate | Line: 11 | Upvalues: ReplecsRemotes (ref) ]]
	local v1 = ReplecsRemotes:FindFirstChild(p1)

	if v1 then
		return v1
	end

	local v2 = Instance.new(p2)

	v2.Name = p1
	v2.Parent = ReplecsRemotes

	return v2
end

local t = {}
local Handshake = ReplecsRemotes:FindFirstChild("Handshake")
local v1

if Handshake then
	v1 = Handshake
else
	local Handshake2 = Instance.new("RemoteFunction")

	Handshake2.Name = "Handshake"
	Handshake2.Parent = ReplecsRemotes
	v1 = Handshake2
end

t.Handshake = v1

local FullState = ReplecsRemotes:FindFirstChild("FullState")
local v2

if FullState then
	v2 = FullState
else
	local FullState2 = Instance.new("RemoteEvent")

	FullState2.Name = "FullState"
	FullState2.Parent = ReplecsRemotes
	v2 = FullState2
end

t.FullState = v2

local Updates = ReplecsRemotes:FindFirstChild("Updates")
local v3

if Updates then
	v3 = Updates
else
	local Updates2 = Instance.new("RemoteEvent")

	Updates2.Name = "Updates"
	Updates2.Parent = ReplecsRemotes
	v3 = Updates2
end

t.Updates = v3

local Unreliable = ReplecsRemotes:FindFirstChild("Unreliable")
local v4

if Unreliable then
	v4 = Unreliable
else
	local Unreliable2 = Instance.new("UnreliableRemoteEvent")

	Unreliable2.Name = "Unreliable"
	Unreliable2.Parent = ReplecsRemotes
	v4 = Unreliable2
end

t.Unreliable = v4

local ClientReady = ReplecsRemotes:FindFirstChild("ClientReady")
local v5

if ClientReady then
	v5 = ClientReady
else
	local ClientReady2 = Instance.new("RemoteEvent")

	ClientReady2.Name = "ClientReady"
	ClientReady2.Parent = ReplecsRemotes
	v5 = ClientReady2
end

t.ClientReady = v5

return t