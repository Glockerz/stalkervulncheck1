-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RequestReload = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RequestReload")

local function inventoryOpen() --[[ inventoryOpen | Line: 11 | Upvalues: Players (copy) ]]
	local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

	if not PlayerGui then
		return false
	end

	local InventoryGui = PlayerGui:FindFirstChild("InventoryGui")

	return if InventoryGui then InventoryGui.Enabled == true else InventoryGui
end

UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 19 | Upvalues: UserInputService (copy), Players (copy), RequestReload (copy) ]]
	if UserInputService:GetFocusedTextBox() then
		return
	end

	if p1.KeyCode ~= Enum.KeyCode.R then
		return
	end

	local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
	local v1

	if PlayerGui then
		local InventoryGui = PlayerGui:FindFirstChild("InventoryGui")

		v1 = if InventoryGui then InventoryGui.Enabled == true else InventoryGui
	else
		v1 = false
	end

	if v1 then
		return
	end

	local Character = Players.LocalPlayer.Character

	if not Character then
		return
	end

	local v2 = Character:FindFirstChildWhichIsA("Tool")

	if not (v2 and v2:FindFirstChild("SPH_Weapon")) then
		return
	end

	RequestReload:FireServer()
end)

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

PlayerGui.DescendantAdded:Connect(function(p1) --[[ Line: 50 ]]
	if p1.Name ~= "Ammo" or (not p1:IsA("Frame") or (not p1.Parent or p1.Parent.Name ~= "Ammo")) then
		return
	end

	p1.Visible = false
end)
task.spawn(function() --[[ Line: 60 | Upvalues: PlayerGui (copy) ]]
	for k, v in pairs(PlayerGui:GetDescendants()) do
		if v.Name == "Ammo" and (v:IsA("Frame") and (v.Parent and v.Parent.Name == "Ammo")) then
			v.Visible = false
		end
	end
end)
print("[MagazineClient] Initialized")