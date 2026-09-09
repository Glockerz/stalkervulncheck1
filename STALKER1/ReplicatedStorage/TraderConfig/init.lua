-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

for i, v in ipairs(script.Profiles:GetChildren()) do
	if v:IsA("ModuleScript") then
		t[v.Name] = require(v)
	end
end

return {
	Roubles = {
		DeathLossPercent = 0.05,
		DeathLossCap = 1000,
		DropModelName = "Roubles",
		StartingBalance = 10000,
		SurvivorStipend = 500,
		DropKeybind = Enum.KeyCode.R,
		DropKeybindModifier = Enum.KeyCode.LeftShift
	},
	Traders = t
}