-- Decompiled with Potassium's decompiler.

local u1 = {
    MAX_TIER = 7,
    MAX_TOTAL_TIER = 7,
    BASELINE = Vector2.new(4, 4),
    MAX_WIDTH = 7,
    TierLadder = {
        [0] = Vector2.new(4, 4),
        [1] = Vector2.new(5, 5),
        [2] = Vector2.new(6, 6),
        [3] = Vector2.new(7, 7),
        [4] = Vector2.new(7, 9),
        [5] = Vector2.new(7, 10),
        [6] = Vector2.new(7, 11),
        [7] = Vector2.new(7, 12),
        [8] = Vector2.new(7, 13),
        [9] = Vector2.new(7, 15),
        [10] = Vector2.new(7, 16),
        [11] = Vector2.new(7, 17),
        [12] = Vector2.new(7, 19),
        [13] = Vector2.new(7, 20),
        [14] = Vector2.new(7, 21)
    },
    PremiumStashDevProductId = 3606126687,
    PremiumGamepasses = {},
    BarterRequirements = {
        { {
                id = "Bolts",
                quantity = 8
            }, {
                id = "Nuts",
                quantity = 6
            }, {
                id = "ElectricalTape",
                quantity = 3
            }, {
                id = "ClothFabric",
                quantity = 2
            }, {
                id = "Roubles",
                quantity = 5000,
                isCurrency = true
            } },
        { {
                id = "Bolts",
                quantity = 10
            }, {
                id = "Nuts",
                quantity = 8
            }, {
                id = "ElectricalTape",
                quantity = 4
            }, {
                id = "ClothFabric",
                quantity = 3
            }, {
                id = "Roubles",
                quantity = 6250,
                isCurrency = true
            } },
        { {
                id = "Pliers",
                quantity = 6
            }, {
                id = "ElectronicCable",
                quantity = 4
            }, {
                id = "AramidFabrics",
                quantity = 3
            }, {
                id = "Wrench",
                quantity = 3
            }, {
                id = "Roubles",
                quantity = 8000,
                isCurrency = true
            } },
        { {
                id = "Pliers",
                quantity = 8
            }, {
                id = "ElectronicCable",
                quantity = 5
            }, {
                id = "AramidFabrics",
                quantity = 4
            }, {
                id = "Wrench",
                quantity = 4
            }, {
                id = "Roubles",
                quantity = 10000,
                isCurrency = true
            } },
        { {
                id = "Capacitors",
                quantity = 3
            }, {
                id = "Gunpowder",
                quantity = 2
            }, {
                id = "MedicalTools",
                quantity = 2
            }, {
                id = "BrokenRadio",
                quantity = 2
            }, {
                id = "Roubles",
                quantity = 12500,
                isCurrency = true
            } },
        { {
                id = "Capacitors",
                quantity = 4
            }, {
                id = "Gunpowder",
                quantity = 3
            }, {
                id = "MedicalTools",
                quantity = 2
            }, {
                id = "BrokenRadio",
                quantity = 3
            }, {
                id = "Roubles",
                quantity = 15600,
                isCurrency = true
            } },
        { {
                id = "GunsmithingTools",
                quantity = 2
            }, {
                id = "CarBattery",
                quantity = 1
            }, {
                id = "HardDrive",
                quantity = 2
            }, {
                id = "Toolset",
                quantity = 1
            }, {
                id = "Roubles",
                quantity = 20000,
                isCurrency = true
            } }
    }
};

function u1.GetSizeForTier(p2) -- Line: 139
    -- upvalues: u1 (copy)
    local math_clamp_ret = math.clamp(p2 or 0, 0, u1.MAX_TIER * 2);

    return u1.TierLadder[math_clamp_ret] or u1.BASELINE;
end;

function u1.GetNextPremiumSize(p3) -- Line: 146
    -- upvalues: u1 (copy)
    if (p3 or 0) >= u1.MAX_TIER then
        return nil;
    end;

    return u1.TierLadder[(p3 or 0) + 1];
end;

function u1.GetBarterRequirements(p4) -- Line: 153
    -- upvalues: u1 (copy)
    local v5 = (p4 or 0) + 1;

    if u1.MAX_TIER < v5 then
        return nil;
    end;

    return u1.BarterRequirements[v5];
end;

return u1;