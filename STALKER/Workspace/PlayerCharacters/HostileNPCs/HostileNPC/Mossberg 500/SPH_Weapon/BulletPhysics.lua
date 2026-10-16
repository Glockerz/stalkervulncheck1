-- Decompiled with Potassium's decompiler.

return {
    materialProperties = {
        Stone = {
            MinRicochetVelocity = 500,
            RicochetDeviation = 100,
            PenetrationDeviation = 150,
            RicochetAngle = { 70, 90 },
            VelocityMultiplier = { 50, 70 },
            PenetrationDepth = { 0.8, 1.2 },
            PenetrationVelocityDecrease = { 5, 15 }
        },
        Ground = {
            MinRicochetVelocity = 550,
            RicochetDeviation = 100,
            PenetrationDeviation = 250,
            RicochetAngle = { 100, 180 },
            VelocityMultiplier = { 40, 60 },
            PenetrationDepth = { 0.8, 1.2 },
            PenetrationVelocityDecrease = { 15, 35 }
        },
        Metal = {
            MinRicochetVelocity = 200,
            RicochetDeviation = 200,
            PenetrationDeviation = 50,
            RicochetAngle = { 50, 70 },
            VelocityMultiplier = { 70, 80 },
            PenetrationDepth = { 0.3, 0.6 },
            PenetrationVelocityDecrease = { 5, 15 }
        },
        Wood = {
            MinRicochetVelocity = 400,
            RicochetDeviation = 100,
            PenetrationDeviation = 150,
            RicochetAngle = { 70, 90 },
            VelocityMultiplier = { 40, 50 },
            PenetrationDepth = { 0.8, 1.2 },
            PenetrationVelocityDecrease = { 5, 15 }
        },
        Glass = {
            MinRicochetVelocity = 500,
            RicochetDeviation = 100,
            PenetrationDeviation = 150,
            RicochetAngle = { 100, 180 },
            VelocityMultiplier = { 70, 80 },
            PenetrationDepth = { 0, 0 },
            PenetrationVelocityDecrease = { 5, 15 }
        },
        Fabric = {
            MinRicochetVelocity = 550,
            RicochetDeviation = 100,
            PenetrationDeviation = 250,
            RicochetAngle = { 100, 180 },
            VelocityMultiplier = { 30, 40 },
            PenetrationDepth = { 0.5, 1 },
            PenetrationVelocityDecrease = { 15, 35 }
        },
        Water = {
            MinRicochetVelocity = 1000,
            RicochetDeviation = 100,
            PenetrationDeviation = 250,
            RicochetAngle = { 180, 360 },
            VelocityMultiplier = { 10, 30 },
            PenetrationDepth = { 1000, 1000 },
            PenetrationVelocityDecrease = { 15, 35 }
        }
    },
    armorPen = 5,
    armorDamage = 1
};