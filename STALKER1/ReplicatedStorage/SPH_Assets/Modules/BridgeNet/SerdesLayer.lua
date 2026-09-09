-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = {}
local t2 = {}
local v1 = 0
local t3 = {}
local v2 = nil
local v3 = RunService:IsServer()

t3.NilIdentifier = "null"

local function fromHex(p1) --[[ fromHex | Line: 24 ]]
	return string.gsub(p1, "..", function(p13) --[[ Line: 25 ]]
		return string.char((tonumber(p13, 16)))
	end)
end

local function toHex(p1) --[[ toHex | Line: 30 ]]
	return string.gsub(p1, ".", function(p13) --[[ Line: 31 ]]
		return string.format("%02X", string.byte(p13))
	end)
end

function t3._start() --[[ _start | Line: 36 | Upvalues: RunService (copy), v2 (ref), ReplicatedStorage (copy), t2 (copy), t (copy) ]]
	if not RunService:IsClient() then
		v2 = Instance.new("Folder")
		v2.Name = "AutoSerde"
		v2.Parent = ReplicatedStorage

		return
	end

	v2 = ReplicatedStorage:WaitForChild("AutoSerde")

	for v1, v22 in v2:GetChildren() do
		t2[v22.Name] = v22.Value
		t[v22.Value] = v22.Name
	end

	v2.ChildAdded:Connect(function(p1) --[[ Line: 44 | Upvalues: t2 (ref), t (ref) ]]
		t2[p1.Name] = p1.Value
		t[p1.Value] = p1.Name
	end)
	v2.ChildRemoved:Connect(function(p1) --[[ Line: 49 | Upvalues: t2 (ref), t (ref) ]]
		t2[p1.Name] = nil
		t[p1.Value] = nil
	end)
end
function t3._destroy() --[[ _destroy | Line: 61 | Upvalues: v2 (ref) ]]
	v2:Destroy()
end
function t3.CreateIdentifier(p1) --[[ CreateIdentifier | Line: 78 | Upvalues: t2 (copy), v3 (copy), t3 (copy), v1 (ref), v2 (ref), t (copy) ]]
	assert(type(p1) == "string", "ID must be a string")

	if not (t2[p1] or v3) then
		return t3.WaitForIdentifier(p1)
	end

	if t2[p1] and not v3 then
		return t2[p1]
	end

	if v1 >= 65536 then
		error("Over the identification cap: " .. p1)
	end

	v1 = v1 + 1

	local v22 = Instance.new("StringValue")

	v22.Name = p1
	v22.Value = string.pack("H", v1)
	v22.Parent = v2
	t2[p1] = v22.Value
	t[v22.Value] = p1

	return v22.Value
end
function t3.WaitForIdentifier(p1) --[[ WaitForIdentifier | Line: 103 | Upvalues: t2 (copy) ]]
	while t2[p1] == nil do
		task.wait()
	end

	return t2[p1]
end
function t3.FromCompressed(p1) --[[ FromCompressed | Line: 122 | Upvalues: t (copy) ]]
	return t[p1]
end
function t3.FromIdentifier(p1) --[[ FromIdentifier | Line: 126 | Upvalues: t2 (copy) ]]
	return t2[p1]
end
function t3.DestroyIdentifier(p1) --[[ DestroyIdentifier | Line: 142 | Upvalues: v3 (copy), t (copy), t2 (copy), v1 (ref), v2 (ref) ]]
	assert(v3, "You cannot destroy identifiers on the client.")
	assert(type(p1) == "string", "ID must be a string")
	t[t2[p1]] = nil
	t2[p1] = nil
	v1 = v1 - 1
	v2:FindFirstChild(p1):Destroy()

	return nil
end
function t3.CreateUUID() --[[ CreateUUID | Line: 164 | Upvalues: HttpService (copy) ]]
	return string.gsub(HttpService:GenerateGUID(false), "-", "")
end
function t3.PackUUID(p1) --[[ PackUUID | Line: 178 ]]
	assert(typeof(p1) == "string", "[BridgeNet] uuid must be a string")

	return string.gsub(p1, "..", function(p13) --[[ Line: 25 ]]
		return string.char((tonumber(p13, 16)))
	end)
end
function t3.UnpackUUID(p1) --[[ UnpackUUID | Line: 193 ]]
	assert(typeof(p1) == "string", "[BridgeNet] uuid must be a string")

	return string.gsub(p1, ".", function(p13) --[[ Line: 31 ]]
		return string.format("%02X", string.byte(p13))
	end)
end
function t3.DictionaryToTable(p1) --[[ DictionaryToTable | Line: 211 ]]
	assert(typeof(p1) == "table", "[BridgeNet] dict must be a dictionary")
	assert(getmetatable(p1) == nil, "[BridgeNet] Passed dictionary may not have a metatable")

	local t = {}

	for v3, v4 in p1 do
		table.insert(t, v3)
	end

	table.sort(t, function(p1, p2) --[[ Line: 220 ]]
		return string.lower(p1) < string.lower(p2)
	end)

	local t2 = {}

	for v5, v6 in t do
		table.insert(t2, p1[v6])
	end

	return t2
end

return t3