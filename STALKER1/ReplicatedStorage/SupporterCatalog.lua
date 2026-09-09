-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Tiers = {
		Drifter = {
			DisplayName = "Drifter",
			GamepassID = 1871565088,
			Level = 1,
			StashTierBonus = 1,
			LoadoutKey = "Drifter",
			ChatPrefix = "[Drifter]",
			BadgeID = 1875456323784792,
			ChatColor = Color3.fromRGB(150, 165, 180),
			UniformPacks = {},
			ExclusiveSkins = { "SunriseSuitTan" }
		},
		Veteran = {
			DisplayName = "Veteran",
			GamepassID = 1873054736,
			Level = 2,
			StashTierBonus = 3,
			LoadoutKey = "Veteran",
			ChatPrefix = "[Veteran]",
			BadgeID = 2379116457665635,
			ChatColor = Color3.fromRGB(120, 200, 120),
			UniformPacks = {},
			ExclusiveSkins = { "SunriseSuitTan", "Gorka" }
		},
		MasterStalker = {
			DisplayName = "Master Stalker",
			GamepassID = 1871547103,
			Level = 3,
			StashTierBonus = 7,
			LoadoutKey = "MasterStalker",
			ChatPrefix = "[Master]",
			BadgeID = 1900204236856768,
			ChatColor = Color3.fromRGB(220, 180, 60),
			UniformPacks = { "MercenaryFactionUniforms", "DutyFactionUniforms", "FreedomFactionUniforms" },
			ExclusiveSkins = { "SunriseSuitTan", "Gorka", "SlicksterODGreen", "SEVASuit" }
		}
	},
	TierOrder = { "Drifter", "Veteran", "MasterStalker" }
}