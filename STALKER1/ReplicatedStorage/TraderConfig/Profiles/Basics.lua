-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	DisplayName = "Basics",
	IntroLine = "They call me Basics... I didn\'t really get to choose that name but you can buy your basic gear from me before you venture into the Zone or sell me whatever you bring back.",
	BuybackMultiplier = 0.6,
	RefreshSeconds = 1800,
	PromptText = "Trade",
	PromptHoldTime = 0,
	BuysEverything = true,
	Buys = { "Weapon", "Gear", "Ammo", "Medical", "FoodAndDrink", "HighValue", "Barter" },
	Sells = {
		Bread = {
			Price = 210,
			StockCap = 25
		},
		WaterBottle = {
			Price = 300,
			StockCap = 25
		},
		["AI-2 Medkit"] = {
			Price = 500,
			StockCap = 20
		},
		["Field Dressing"] = {
			Price = 300,
			StockCap = 30
		},
		["9x18mm_FMJ_Box"] = {
			Price = 250,
			StockCap = 40
		},
		PM_Magazine_8 = {
			Price = 200,
			StockCap = 40
		},
		TanCHICOM = {
			Price = 4000,
			StockCap = 40
		},
		["2 Hole Balaclava"] = {
			Price = 800,
			StockCap = 6
		},
		["3 Hole Balaclava"] = {
			Price = 800,
			StockCap = 6
		},
		Balaclava = {
			Price = 800,
			StockCap = 6
		},
		["Black Bandana"] = {
			Price = 500,
			StockCap = 6
		},
		["Narrow Balaclava"] = {
			Price = 800,
			StockCap = 6
		},
		["Neck Gaiter"] = {
			Price = 500,
			StockCap = 6
		},
		["Red Bandana"] = {
			Price = 500,
			StockCap = 6
		},
		["Wide Balaclava"] = {
			Price = 800,
			StockCap = 6
		},
		["Paint Respirator"] = {
			Price = 3500,
			StockCap = 4
		},
		["HalfMask Respirator"] = {
			Price = 4000,
			StockCap = 4
		},
		ZoneBrew = {
			Price = 500,
			StockCap = 25
		},
		Sausage = {
			Price = 250,
			StockCap = 25
		},
		EnergyDrink = {
			Price = 650,
			StockCap = 25
		},
		CannedFood = {
			Price = 420,
			StockCap = 25
		},
		Voda = {
			Price = 290,
			StockCap = 25
		},
		Canteen = {
			Price = 400,
			StockCap = 25
		}
	}
}