-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	DisplayName = "Mercenary Quartermaster",
	BuybackMultiplier = 0.6,
	RefreshSeconds = 1800,
	PromptText = "Trade",
	PromptHoldTime = 0,
	BuysEverything = true,
	Buys = { "Weapon", "Gear", "Ammo", "Medical", "FoodAndDrink", "HighValue", "Barter" },
	Sells = {
		["M4A1 M68"] = {
			Price = 25000,
			StockCap = 2
		},
		MP5A3 = {
			Price = 12000,
			StockCap = 3
		},
		M17 = {
			Price = 5000,
			StockCap = 4
		},
		STANAG_30 = {
			Price = 800,
			StockCap = 50
		},
		M17_Magazine = {
			Price = 400,
			StockCap = 50
		},
		["5.56x45mm_Box"] = {
			Price = 600,
			StockCap = 40
		},
		["5.56x45mm_M995_Box"] = {
			Price = 1500,
			StockCap = 15
		},
		["5.56x45mm_HP_Box"] = {
			Price = 700,
			StockCap = 30
		},
		JPC2 = {
			Price = 30000,
			StockCap = 1
		},
		LBT6094Black = {
			Price = 35000,
			StockCap = 1
		},
		["AI-2 Medkit"] = {
			Price = 1500,
			StockCap = 10
		},
		["Field Dressing"] = {
			Price = 300,
			StockCap = 20
		}
	}
}