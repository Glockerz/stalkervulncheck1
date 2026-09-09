-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local t = {
	InventoryGui = true,
	TraderGui = true,
	PremiumVendorGui = true,
	PdaGui = true,
	NpcInteractionGui = true,
	TalkGui = true,
	EmoteWheelGui = true
}
local InventoryController = require(ReplicatedStorage:WaitForChild("InventoryController"))
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local t2 = {}
local v1 = nil

local function anyBlockingGuiOpen() --[[ anyBlockingGuiOpen | Line: 50 | Upvalues: t (copy), PlayerGui (copy) ]]
	for k in pairs(t) do
		local v1 = PlayerGui:FindFirstChild(k)

		if v1 and (v1:IsA("ScreenGui") and v1.Enabled) then
			return true
		end
	end

	return false
end

local function apply(p1) --[[ apply | Line: 63 | Upvalues: anyBlockingGuiOpen (copy), v1 (ref), InventoryController (copy) ]]
	local v12 = anyBlockingGuiOpen()

	if v12 ~= v1 or p1 then
		v1 = v12
		InventoryController:_setUIInputLock(v12)
	end
end

local function watch(p1) --[[ watch | Line: 70 | Upvalues: t2 (copy), t (copy), anyBlockingGuiOpen (copy), v1 (ref), InventoryController (copy) ]]
	if t2[p1] then
		return
	end

	if not (p1:IsA("ScreenGui") and t[p1.Name]) then
		return
	end

	t2[p1] = true
	p1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 74 | Upvalues: anyBlockingGuiOpen (ref), v1 (ref), InventoryController (ref) ]]
		local v12 = anyBlockingGuiOpen()

		if v12 ~= v1 then
			v1 = v12
			InventoryController:_setUIInputLock(v12)
		end
	end)

	local v12 = anyBlockingGuiOpen()

	if v12 ~= v1 then
		v1 = v12
		InventoryController:_setUIInputLock(v12)
	end
end

for i, v in ipairs(PlayerGui:GetChildren()) do
	watch(v)
end

PlayerGui.ChildAdded:Connect(watch)
PlayerGui.ChildRemoved:Connect(function(p1) --[[ Line: 82 | Upvalues: t2 (copy), anyBlockingGuiOpen (copy), v1 (ref), InventoryController (copy) ]]
	if not t2[p1] then
		return
	end

	t2[p1] = nil

	local v12 = anyBlockingGuiOpen()

	if v12 == v1 then
		return
	end

	v1 = v12
	InventoryController:_setUIInputLock(v12)
end)
LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 89 | Upvalues: v1 (ref), anyBlockingGuiOpen (copy), InventoryController (copy) ]]
	v1 = nil
	task.defer(function() --[[ Line: 91 | Upvalues: anyBlockingGuiOpen (ref), v1 (ref), InventoryController (ref) ]]
		local v12 = anyBlockingGuiOpen()

		v1 = v12
		InventoryController:_setUIInputLock(v12)
	end)
end)

local v2 = anyBlockingGuiOpen()

v1 = v2
InventoryController:_setUIInputLock(v2)