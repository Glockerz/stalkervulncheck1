-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
game:GetService("Players")

local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = require(ReplicatedStorage.SPH_Assets.Modules.BridgeNet).CreateBridge("SystemMessage")
local isLegacyChatService = game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.LegacyChatService
local GameConfig = require(ReplicatedStorage.SPH_Assets.GameConfig)

task.wait(2)

if not (GameConfig.systemChat and isLegacyChatService) then
	return
end

v1:Connect(function(p1, p2) --[[ Line: 17 | Upvalues: isLegacyChatService (copy), StarterGui (copy) ]]
	if isLegacyChatService then
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = p1,
			Color = p2
		})
	end
end)