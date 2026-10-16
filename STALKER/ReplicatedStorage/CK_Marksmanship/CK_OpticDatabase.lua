-- Decompiled with Potassium's decompiler.

local v1 = {
    SUSAT_4 = {
        displayName = "SUSAT L9A1 4x",
        profile = "SUSAT_4",
        magStart = 4,
        zoomFov = 14.11,
        milPerDot = 1,
        reticles = { {
                style = "image",
                image = "rbxassetid://5989686308"
            }, {
                style = "center"
            } },
        magStops = { 4 }
    },
    ELCAN_4 = {
        displayName = "ELCAN SpecterOS 1-4x",
        profile = "ELCAN_4",
        magStart = 4,
        magMin = 1,
        magMax = 4,
        zoomFov = 14.11,
        milPerDot = 1,
        reticles = { {
                style = "image",
                image = "rbxassetid://93659823525623"
            }, {
                style = "center"
            } },
        magStops = { 1, 4 }
    },
    PU_35 = {
        displayName = "PU 4x",
        profile = "PU_35",
        magStart = 4,
        zoomFov = 14.11,
        milPerDot = 1,
        reticles = { {
                style = "image",
                image = "rbxassetid://139892008257986"
            }, {
                style = "center"
            } },
        magStops = { 4 }
    },
    PSO_1 = {
        displayName = "PSO-1 4x",
        profile = "PSO_1",
        magStart = 4,
        zoomFov = 14.11,
        milPerDot = 1,
        reticles = { {
                style = "image",
                image = "rbxassetid://3242432719"
            }, {
                style = "center"
            } },
        magStops = { 4 }
    },
    ["1P29"] = {
        displayName = "1P29 4x",
        profile = "1P29",
        magStart = 4,
        zoomFov = 14.11,
        milPerDot = 1,
        reticles = { {
                style = "center"
            } },
        magStops = { 4 }
    },
    ACOG_4 = {
        displayName = "ACOG TA31 4x",
        profile = "ACOG_4",
        magStart = 4,
        zoomFov = 14.11,
        milPerDot = 1,
        reticles = { {
                style = "center"
            } },
        magStops = { 4 }
    }
};
v1.DEFAULT = v1.SUSAT_4;

return v1;