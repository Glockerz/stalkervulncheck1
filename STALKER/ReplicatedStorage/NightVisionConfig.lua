-- Decompiled with Potassium's decompiler.

local u1 = {
    TOGGLE_KEY = Enum.KeyCode.K,
    FIRST_PERSON_MAX_DISTANCE = 1.5,
    SHEET_DISTANCE = 0.2,
    GRAIN_IMAGE = "rbxassetid://95161230430908",
    GRAIN_TILE_JITTER = 0.05,
    GRAIN_JITTER_PIXELS = 3,
    TUBE_DISPLAY_ORDER = -11,
    ATTR = "NightVisionGen",
    GEN_ORDER = { "Gen1", "Gen2", "Gen3" },
    GENS = {
        Gen1 = {
            Plane = "Gen1NODS",
            TubeImage = "rbxassetid://93586787397502",
            TintTransparency = 0.9,
            GrainTransparency = 0.75,
            GrainFrames = 3,
            GainBrightness = 0.25,
            GainContrast = 1,
            IrRange = 60,
            Tint = Color3.fromRGB(0, 255, 0),
            IrColor = Color3.fromRGB(128, 255, 89),
            Amp = {
                DensityMul = 0.65,
                HazeMul = 0.6,
                ExposureAdd = 0.5,
                FogFloor = Color3.fromRGB(70, 70, 70),
                AmbientFloor = Color3.fromRGB(70, 70, 70),
                OutdoorFloor = Color3.fromRGB(55, 55, 55)
            }
        },
        Gen2 = {
            Plane = "Gen2NODS",
            TubeImage = "rbxassetid://140060078539595",
            TintTransparency = 0.92,
            GrainTransparency = 0.85,
            GrainFrames = 4,
            GainBrightness = 0.25,
            GainContrast = 1,
            IrRange = 80,
            Tint = Color3.fromRGB(2, 188, 255),
            IrColor = Color3.fromRGB(148, 164, 255),
            Amp = {
                DensityMul = 0.5,
                HazeMul = 0.45,
                ExposureAdd = 0.7,
                FogFloor = Color3.fromRGB(85, 85, 85),
                AmbientFloor = Color3.fromRGB(85, 85, 85),
                OutdoorFloor = Color3.fromRGB(75, 75, 75)
            }
        },
        Gen3 = {
            Plane = "Gen3NODS",
            TubeImage = "rbxassetid://105564308107072",
            TintTransparency = 0.94,
            GrainTransparency = 0.92,
            GrainFrames = 6,
            GainBrightness = 0.25,
            GainContrast = 1,
            IrRange = 120,
            Tint = Color3.fromRGB(2, 188, 255),
            IrColor = Color3.fromRGB(148, 164, 255),
            Amp = {
                DensityMul = 0.35,
                HazeMul = 0.3,
                ExposureAdd = 0.9,
                FogFloor = Color3.fromRGB(100, 100, 100),
                AmbientFloor = Color3.fromRGB(95, 95, 95),
                OutdoorFloor = Color3.fromRGB(95, 95, 95)
            }
        }
    },
    SHEET_MATERIAL = Enum.Material.Neon,
    GAIN_UP_KEY = Enum.KeyCode.Equals,
    GAIN_DOWN_KEY = Enum.KeyCode.Minus,
    GAIN_STEPS = { 0.5, 0.75, 1, 1.5, 2 },
    GAIN_START_STEP = 3,
    DOF_FAR_INTENSITY = 0,
    DOF_FOCUS_DISTANCE = 54.54,
    DOF_IN_FOCUS_RADIUS = 46.365,
    DOF_NEAR_INTENSITY = 0.35,
    IR_KEY = Enum.KeyCode.Z,
    IR_ATTR = "IRIlluminatorOn",
    IR_BRIGHTNESS = 3,
    IR_ANGLE = 108,
    IR_POLL_SECONDS = 0.25,
    IR_SHADOWS = true,
    HIGHLIGHT_FILL = Color3.new(0.0588, -0.0039, 0.0588),
    HIGHLIGHT_FILL_TRANSPARENCY = 100
};

function u1.Amplify(p2, p3, p4) -- Line: 166
    -- upvalues: u1 (copy)
    local v5 = u1.GENS[p3];

    if v5 then
        v5 = v5.Amp;
    end;

    if type(p2) ~= "table" or type(v5) ~= "table" then
        return nil;
    end;

    local v6 = tonumber(p4) or 1;

    local function floored(p7, p8, p9) -- Line: 171
        if typeof(p7) ~= "Color3" then
            return nil;
        end;

        local Color3_new = Color3.new;
        local R = p7.R;
        local math_min_ret = math.min(1, p8.R * p9);
        local math_max_ret = math.max(R, math_min_ret);
        local G = p7.G;
        local math_min_ret2 = math.min(1, p8.G * p9);
        local math_max_ret2 = math.max(G, math_min_ret2);
        local B = p7.B;
        local math_min_ret3 = math.min(1, p8.B * p9);

        return Color3_new(math_max_ret, math_max_ret2, (math.max(B, math_min_ret3)));
    end;

    local v10 = {
        Ambient = floored(p2.Ambient, v5.AmbientFloor, v6),
        OutdoorAmbient = floored(p2.OutdoorAmbient, v5.OutdoorFloor, v6),
        Color = floored(p2.Color, v5.FogFloor, 1),
        Decay = floored(p2.Decay, v5.FogFloor, 1)
    };

    if type(p2.ExposureCompensation) == "number" then
        v10.ExposureCompensation = math.min(3, p2.ExposureCompensation + v5.ExposureAdd * v6);
    end;

    if type(p2.Density) == "number" then
        v10.Density = p2.Density * v5.DensityMul;
    end;

    if type(p2.Haze) == "number" then
        v10.Haze = p2.Haze * v5.HazeMul;
    end;

    return v10;
end;

function u1.Next(p11, p12) -- Line: 200
    -- upvalues: u1 (copy)
    if type(p12) ~= "string" or u1.GENS[p12] == nil then
        return nil;
    end;

    if p11 == nil then
        return p12;
    end;

    return nil;
end;

u1.FACE_ATTR = "FaceNightVisionGen";
u1.DOWN_ATTR = "NVGogglesDown";
u1.SOUNDS = {
    Button = "rbxassetid://125043525599051",
    On = "rbxassetid://90181779209278",
    Off = "rbxassetid://79003354998655"
};
u1.SOUND_RANGE = 25;
u1.SOUND_VOLUME = 0.75;

local function rank(p13) -- Line: 256
    -- upvalues: u1 (copy)
    for i, v in ipairs(u1.GEN_ORDER) do
        if v == p13 then
            return i;
        end;
    end;

    return nil;
end;

function u1.Pick(p14, p15) -- Line: 275
    -- upvalues: u1 (copy)
    local v16;

    if type(p14) == "string" and u1.GENS[p14] ~= nil then
        v16 = nil;

        for i, v in ipairs(u1.GEN_ORDER) do
            if v == p14 then
                v16 = i;
                break;
            end;
        end;

        if not v16 then
            v16 = nil;
        end;
    else
        v16 = nil;
    end;

    local v17;

    if type(p15) == "string" and u1.GENS[p15] ~= nil then
        v17 = nil;

        for i, v in ipairs(u1.GEN_ORDER) do
            if v == p15 then
                v17 = i;
                break;
            end;
        end;

        if not v17 then
            v17 = nil;
        end;
    else
        v17 = nil;
    end;

    if v16 == nil and v17 == nil then
        return nil, false;
    end;

    if v17 == nil or v16 ~= nil and v16 >= v17 then
        return p14, true;
    end;

    return p15, false;
end;

function u1.Worn(p18) -- Line: 288
    -- upvalues: u1 (copy)
    if p18 then
        return u1.Pick(p18:GetAttribute(u1.ATTR), p18:GetAttribute(u1.FACE_ATTR));
    end;

    return nil, false;
end;

return u1;