-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ToggleHood = Remotes:WaitForChild("ToggleHood")
local ShowToast = Remotes:WaitForChild("ShowToast")

UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 12 | Upvalues: ToggleHood (copy) ]]
	if p2 then
		return
	end

	if p1.KeyCode ~= Enum.KeyCode.M then
		return
	end

	ToggleHood:FireServer()
end)
ShowToast.OnClientEvent:Connect(function(p1) --[[ Line: 20 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 21 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage:WaitForChild("InventoryController"))
	end)

	if not (ok and result) then
		warn("[Toast] " .. tostring(p1))

		return
	end

	if type(result.ShowToast) == "function" then
		result:ShowToast(p1)
	else
		warn("[Toast] " .. tostring(p1))
	end
end)