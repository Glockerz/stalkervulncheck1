-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Packages = script.Parent.Packages

if Packages:FindFirstChild("Promise") then
	return require(Packages.Promise)
end

return nil