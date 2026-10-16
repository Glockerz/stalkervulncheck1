-- Decompiled with Potassium's decompiler.

return {
    DisplayName = "Zone Doctor",
    Faction = "Loner",
    BuybackMultiplier = 0.75,
    RefreshSeconds = 1800,
    PromptText = "Consult",
    PromptHoldTime = 0,
    BuysEverything = false,
    Buys = { "Medical" },
    Sells = {
        ["Field Dressing"] = {
            Price = 300,
            StockCap = 40
        },
        Brufen = {
            Price = 1200,
            StockCap = 25
        },
        Yadulin = {
            Price = 2000,
            StockCap = 20
        },
        ["AI-2 Medkit"] = {
            Price = 1500,
            StockCap = 15
        },
        ["AI-2 Military Medkit"] = {
            Price = 3500,
            StockCap = 8
        },
        ["AI-2 Scientific Medkit"] = {
            Price = 6000,
            StockCap = 4
        },
        Iodine = {
            Price = 550,
            StockCap = 8
        },
        Injector = {
            Price = 4000,
            StockCap = 5
        },
        Hercules = {
            Price = 2500,
            StockCap = 10
        },
        AntiRadVial = {
            Price = 5000,
            StockCap = 4
        },
        DmgResistVial = {
            Price = 5000,
            StockCap = 4
        }
    }
};