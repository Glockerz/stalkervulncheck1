-- Decompiled with Potassium's decompiler.

return {
    DisplayName = "Bartender",
    Faction = "Loner",
    PromptText = "Trade",
    PromptHoldTime = 0,
    IntroLine = "Sit down, take the weight off. I have got bread that is only mostly stale, water that has been through a filter, and something in a green can that I do not ask questions about. Out here a hot meal is worth more than a good rifle. You can carry the rifle hungry. You cannot carry the hunger.",
    BuybackMultiplier = 0.65,
    RefreshSeconds = 1800,
    BuysEverything = false,
    Buys = { "FoodAndDrink" },
    BuysItems = { "DogTail", "FleshEye", "BoarLeg" },
    Sells = {
        EnergyDrink = {
            Price = 780,
            StockCap = 25
        },
        ZoneBrew = {
            Price = 600,
            StockCap = 25
        },
        CannedFood = {
            Price = 500,
            StockCap = 25
        },
        Canteen = {
            Price = 480,
            StockCap = 25
        },
        WaterBottle = {
            Price = 360,
            StockCap = 25
        },
        Voda = {
            Price = 350,
            StockCap = 25
        },
        Sausage = {
            Price = 300,
            StockCap = 25
        },
        Bread = {
            Price = 250,
            StockCap = 25
        }
    }
};