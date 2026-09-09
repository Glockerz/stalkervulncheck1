-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	DisplayName = "Ecologist",
	IntroLine = "They call me the Ecologist. Bring me artifact scraps, radiation samples, salvaged instruments -- I pay well. And I can outfit you with medicine your bandit friends can\'t touch.",
	BuybackMultiplier = 0.55,
	RefreshSeconds = 1800,
	PromptText = "Trade",
	PromptHoldTime = 0,
	BuysEverything = true,
	Buys = { "Weapon", "Gear", "Ammo", "Medical", "FoodAndDrink", "HighValue", "Barter" },
	Sells = {
		["Field Dressing"] = {
			Price = 300,
			StockCap = 20,
			MinRep = 0
		},
		["AI-2 Medkit"] = {
			Price = 900,
			StockCap = 12,
			MinRep = 0
		},
		Iodine = {
			Price = 700,
			StockCap = 12,
			MinRep = 0
		},
		Brufen = {
			Price = 700,
			StockCap = 12,
			MinRep = 0
		},
		WaterBottle = {
			Price = 320,
			StockCap = 20,
			MinRep = 0
		},
		Bread = {
			Price = 220,
			StockCap = 20,
			MinRep = 0
		},
		["AI-2 Military Medkit"] = {
			Price = 2400,
			StockCap = 6,
			MinRep = 7
		},
		Yadulin = {
			Price = 1400,
			StockCap = 8,
			MinRep = 7
		},
		AntiRadVial = {
			Price = 3000,
			StockCap = 5,
			MinRep = 7
		},
		["AI-2 Scientific Medkit"] = {
			Price = 6800,
			StockCap = 3,
			MinRep = 20
		},
		DmgResistVial = {
			Price = 3200,
			StockCap = 3,
			MinRep = 20
		},
		EcologistGuardGorka = {
			Price = 22000,
			StockCap = 1,
			MinRep = 20
		}
	}
}