-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer
local Janitor = require(script.Internal.Janitor)
local TagName = script.GeneralSettings.TagName
local t = {}

for v1, v2 in script.Plugins:GetChildren() do
	if v2:IsA("ModuleScript") then
		local v3 = require(v2)

		if not v3.InitializationPriority then
			error(v2:GetFullName() .. " does not have a InitializationPriority property")
		end

		if v3.InitializeFrame and not v3.CleanupFrame then
			error(v2:GetFullName() .. " has a InitializeFrame function but not a CleanupFrame function")
		end

		table.insert(t, v3)
	end
end

table.sort(t, function(p1, p2) --[[ Line: 47 ]]
	return p1.InitializationPriority < p2.InitializationPriority
end)
print(t)

local t2 = {}

local function InstanceAdded(p1) --[[ InstanceAdded | Line: 54 | Upvalues: LocalPlayer (copy), t2 (copy), Janitor (copy), t (copy) ]]
	if not p1:IsA("GuiObject") then
		return
	end

	if not p1:IsDescendantOf(LocalPlayer) then
		return
	end

	t2[p1] = Janitor.new()

	local t3 = {
		Janitor = t2[p1]
	}

	for v1, v2 in t do
		if v2.InitializeFrame then
			v2.InitializeFrame(p1, t3, t2[p1])
		end
	end
end

local function InstanceRemoved(p1) --[[ InstanceRemoved | Line: 74 | Upvalues: t2 (copy), t (copy) ]]
	if not p1:IsA("GuiObject") then
		return
	end

	if t2[p1] then
		t2[p1]:Destroy()
		t2[p1] = nil
	end

	for v1, v2 in t do
		if v2.CleanupFrame then
			v2.CleanupFrame(p1)
		end
	end
end

CollectionService:GetInstanceAddedSignal(TagName.Value):Connect(InstanceAdded)

for v4, v5 in CollectionService:GetTagged(TagName.Value) do
	InstanceAdded(v5)
end

CollectionService:GetInstanceRemovedSignal(TagName.Value):Connect(InstanceRemoved)