-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if not require(ReplicatedStorage:WaitForChild("PlaceConfig")).IsLobby then
	return
end

local StarterGui = game:GetService("StarterGui")

local function tryDisable() --[[ tryDisable | Line: 20 | Upvalues: StarterGui (copy) ]]
	return pcall(function() --[[ Line: 21 | Upvalues: StarterGui (ref) ]]
		StarterGui:SetCore("ResetButtonCallback", false)
	end)
end

for i = 1, 30 do
	if pcall(function() --[[ Line: 21 | Upvalues: StarterGui (copy) ]]
		StarterGui:SetCore("ResetButtonCallback", false)
	end) then
		break
	end

	task.wait(0.1)
end