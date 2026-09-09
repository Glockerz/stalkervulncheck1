-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local PdaMapData = require(ReplicatedStorage:WaitForChild("PdaMapData"))
local LocalPlayer = Players.LocalPlayer
local t = {}

local function ensureAnchorsFolder() --[[ ensureAnchorsFolder | Line: 16 | Upvalues: Workspace (copy) ]]
	local PdaBlipAnchorsLocal = Workspace:FindFirstChild("PdaBlipAnchorsLocal")

	if not PdaBlipAnchorsLocal then
		local PdaBlipAnchorsLocal2 = Instance.new("Folder")

		PdaBlipAnchorsLocal2.Name = "PdaBlipAnchorsLocal"
		PdaBlipAnchorsLocal2.Parent = Workspace
		PdaBlipAnchorsLocal = PdaBlipAnchorsLocal2
	end

	return PdaBlipAnchorsLocal
end

local function ensureAnchor(p1, p2, p3) --[[ ensureAnchor | Line: 26 | Upvalues: Workspace (copy), CollectionService (copy) ]]
	local PdaBlipAnchorsLocal = Workspace:FindFirstChild("PdaBlipAnchorsLocal")

	if not PdaBlipAnchorsLocal then
		local PdaBlipAnchorsLocal2 = Instance.new("Folder")

		PdaBlipAnchorsLocal2.Name = "PdaBlipAnchorsLocal"
		PdaBlipAnchorsLocal2.Parent = Workspace
		PdaBlipAnchorsLocal = PdaBlipAnchorsLocal2
	end

	local v1 = p1 .. "_" .. p2
	local v2 = PdaBlipAnchorsLocal:FindFirstChild(v1)

	if not v2 then
		local Part = Instance.new("Part")

		Part.Name = v1
		Part.Anchored = true
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Transparency = 1
		Part.Size = Vector3.new(2, 2, 2)
		Part.Parent = PdaBlipAnchorsLocal
		v2 = Part
	end

	v2.Position = p3

	if CollectionService:HasTag(v2, p1) then
		return
	end

	CollectionService:AddTag(v2, p1)
end

local t2 = {}
local t3 = {}

function t.SetDepositTargets(p1) --[[ SetDepositTargets | Line: 54 | Upvalues: Workspace (copy), t3 (copy), CollectionService (copy) ]]
	local PdaBlipAnchorsLocal = Workspace:FindFirstChild("PdaBlipAnchorsLocal")

	if not PdaBlipAnchorsLocal then
		local PdaBlipAnchorsLocal2 = Instance.new("Folder")

		PdaBlipAnchorsLocal2.Name = "PdaBlipAnchorsLocal"
		PdaBlipAnchorsLocal2.Parent = Workspace
		PdaBlipAnchorsLocal = PdaBlipAnchorsLocal2
	end

	local v1 = PdaBlipAnchorsLocal

	for k, v in pairs(t3) do
		if not p1[k] then
			v:Destroy()
			t3[k] = nil
		end
	end

	for k, v in pairs(p1) do
		local v2 = t3[k]

		if not (v2 and v2.Parent) then
			local Part = Instance.new("Part")

			Part.Name = "Stash_dep_" .. tostring(k)
			Part.Anchored = true
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.Transparency = 1
			Part.Size = Vector3.new(2, 2, 2)
			Part.Parent = v1
			CollectionService:AddTag(Part, "Stash")
			t3[k] = Part
			v2 = Part
		end

		v2.Position = v.pos
	end
end
function t.SetExplorationTargets(p1) --[[ SetExplorationTargets | Line: 77 | Upvalues: Workspace (copy), t2 (copy), CollectionService (copy) ]]
	local PdaBlipAnchorsLocal = Workspace:FindFirstChild("PdaBlipAnchorsLocal")

	if not PdaBlipAnchorsLocal then
		local PdaBlipAnchorsLocal2 = Instance.new("Folder")

		PdaBlipAnchorsLocal2.Name = "PdaBlipAnchorsLocal"
		PdaBlipAnchorsLocal2.Parent = Workspace
		PdaBlipAnchorsLocal = PdaBlipAnchorsLocal2
	end

	local v1 = PdaBlipAnchorsLocal

	for k, v in pairs(t2) do
		if not p1[k] then
			v:Destroy()
			t2[k] = nil
		end
	end

	for k, v in pairs(p1) do
		local v2 = t2[k]

		if not (v2 and v2.Parent) then
			local Part = Instance.new("Part")

			Part.Name = "SearchHere_" .. tostring(k)
			Part.Anchored = true
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.Transparency = 1
			Part.Size = Vector3.new(2, 2, 2)
			Part.Parent = v1
			CollectionService:AddTag(Part, "SearchHere")
			t2[k] = Part
			v2 = Part
		end

		v2.Position = v.pos
	end
end
function t.Attach(p1) --[[ Attach | Line: 102 | Upvalues: LocalPlayer (copy), PdaMapData (copy), ensureAnchor (copy) ]]
	if not (p1 and p1:IsA("GuiObject")) then
		warn("[PdaMapBlipFactory] Attach called without a GuiObject")

		return
	end

	local v2 = PdaMapData.GetRegion(LocalPlayer:GetAttribute("Zone") or "Cordon")

	for v5, v6 in ipairs(v2.Traders or {}) do
		ensureAnchor("Trader", v6.Id, v6.WorldPos)
	end

	for v9, v10 in ipairs(v2.Doctors or {}) do
		ensureAnchor("Doctor", v10.Id, v10.WorldPos)
	end

	print(string.format("[PdaMapBlipFactory] Static anchors created+tagged: %d traders, %d doctors (stashes are dynamic)", #(v2.Traders or {}), #(v2.Doctors or {})))
end

return t