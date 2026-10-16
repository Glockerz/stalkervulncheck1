-- Decompiled with Potassium's decompiler.

return {
    SUSAT_4 = {
        tubeScale = 0.88,
        vignette = 0.82,
        eyebox = 0.55,
        fringe = 0.7,
        cleanView = false,
        showAmmo = false,
        showBreath = false,
        showSolution = false,
        tint = Color3.fromRGB(6, 8, 12),
        reticleColor = Color3.fromRGB(255, 196, 120),
        magStops = { 4 }
    },
    ELCAN_4 = {
        tubeScale = 1,
        vignette = 0.94,
        fringe = 0.88,
        shadow = 0.15,
        reticleScale = 1.45,
        cleanView = false,
        showAmmo = false,
        showBreath = false,
        showSolution = false,
        tint = Color3.fromRGB(4, 6, 10),
        reticleColor = Color3.fromRGB(255, 78, 58),
        magStops = { 4 }
    },
    PU_35 = {
        tubeScale = 0.8,
        vignette = 0.64,
        eyebox = 0.38,
        fringe = 0.5,
        cleanView = false,
        showAmmo = false,
        showBreath = false,
        showSolution = false,
        tint = Color3.fromRGB(10, 13, 13),
        reticleColor = Color3.fromRGB(226, 226, 220),
        magStops = { 4 }
    },
    PSO_1 = {
        tubeScale = 0.84,
        vignette = 0.7,
        eyebox = 0.42,
        fringe = 0.55,
        reticleScale = 0.94,
        cleanView = false,
        showAmmo = false,
        showBreath = false,
        showSolution = false,
        tint = Color3.fromRGB(8, 12, 14),
        reticleColor = Color3.fromRGB(224, 60, 44),
        magStops = { 4 }
    },
    ["1P29"] = {
        tubeScale = 0.92,
        vignette = 0.86,
        eyebox = 0.78,
        fringe = 0.72,
        cleanView = false,
        showAmmo = false,
        showBreath = false,
        showSolution = false,
        tint = Color3.fromRGB(7, 10, 12),
        reticleColor = Color3.fromRGB(232, 236, 238),
        magStops = { 4 }
    },
    ACOG_4 = {
        tubeScale = 0.94,
        vignette = 0.88,
        eyebox = 0.6,
        fringe = 0.8,
        reticleScale = 1.08,
        cleanView = false,
        showAmmo = false,
        showBreath = false,
        showSolution = false,
        tint = Color3.fromRGB(5, 7, 11),
        reticleColor = Color3.fromRGB(255, 108, 54),
        magStops = { 4 }
    },
    Sniper = {
        reticleStyle = "image",
        reticle = "rbxassetid://130656674088173",
        showAmmo = true,
        showBreath = true,
        cleanView = false,
        showSolution = false,
        magStops = { 4, 8, 16, 32 }
    },
    Spotter = {
        reticleStyle = "center",
        showAmmo = false,
        showBreath = false,
        cleanView = true,
        showSolution = true,
        reticles = { {
                style = "center"
            }, {
                style = "image",
                image = "rbxassetid://112355647865823"
            }, {
                style = "image",
                image = "rbxassetid://112270898141989"
            } },
        magStops = { 6, 15, 25, 40 }
    },
    DEFAULT = "SUSAT_4"
};