-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = game:GetService("Players").LocalPlayer

ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PromptGamePassPurchase").OnClientEvent:Connect(function(p1) --[[ Line: 14 | Upvalues: MarketplaceService (copy), LocalPlayer (copy) ]]
	if type(p1) == "number" and not (p1 <= 0) then
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, p1)
	end
end)
print("[LocalSkinPackPromptHandler] initialized")