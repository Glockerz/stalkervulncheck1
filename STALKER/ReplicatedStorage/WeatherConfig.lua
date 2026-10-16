-- Decompiled with Potassium's decompiler.

return {
    ATTR = {
        State = "WeatherState",
        Rain = "WeatherRain",
        Storm = "WeatherStorm",
        Lightning = "WeatherLightning"
    },
    STATE_ORDER = { "Clear", "Drizzle", "Rain", "Storm" },
    STATES = {
        Clear = {
            Weight = 55,
            SpellMin = 3000,
            SpellMax = 5400,
            Rain = 0,
            Storm = 0
        },
        Drizzle = {
            Weight = 25,
            SpellMin = 600,
            SpellMax = 1200,
            Rain = 0.8,
            Storm = 0
        },
        Rain = {
            Weight = 14,
            SpellMin = 720,
            SpellMax = 1500,
            Rain = 2,
            Storm = 0
        },
        Storm = {
            Weight = 6,
            SpellMin = 480,
            SpellMax = 900,
            Rain = 3,
            Storm = 1
        }
    },
    RAMP_SECONDS = 90,
    PUBLISH_HZ = 2,
    SCHEDULE_EPOCH = 1789257600,
    SCHEDULE_CYCLE_SECONDS = 7200,
    SCHEDULE_SEED = 1913,
    SCHEDULE_VERSION = 1,
    SCHEDULE_MIN_SPELL_SECONDS = 300,
    LIGHTNING_MEAN_INTERVAL = 20,
    LIGHTNING_MIN_GAP_SECONDS = 1.5,
    LIGHTNING_REPLAY_GRACE = 2,
    FORECAST_LEAD_15 = 900,
    FORECAST_LEAD_5 = 300,
    FORECAST_LEAD_NOW = 30,
    FORECAST_SPACING_SECONDS = 240,
    FORECAST_LATE_GRACE_SECONDS = 10,
    FORECAST_DELIVERED_TTL_SECONDS = 3600,
    FORECAST_TICK_SECONDS = 1,
    GRID_BANDS = { {
            MaxLevel = 3,
            Size = 6
        }, {
            MaxLevel = 7,
            Size = 8
        }, {
            MaxLevel = 10,
            Size = 10
        } },
    GRID_AUTOMATIC = 8,
    RAIN_AREA = 48,
    RAIN_VERTICAL_OFFSET = 36,
    RAIN_CHECK_RANGE = 64,
    RAIN_SAFETY_RANGE = 64,
    INDOOR_CHECK_RANGE = 5,
    RAIN_UPDATE_HZ = 12,
    RAINDROP_LIFETIME_SCALE = 0.9,
    RAINDROP_FALLBACK_LIFETIME = 2.5,
    INDOOR_SMOOTHING = 0.1,
    FRAME_COMPENSATION_MAX = 4,
    WEATHER_GROUP_VOLUME = 1,
    LIGHTING_RAIN = {
        DensityAdd = 0.15,
        HazeAdd = 1.5,
        BrightnessMul = 0.75,
        ExposureAdd = -0.3,
        SaturationAdd = -0.15
    },
    LIGHTING_STORM = {
        DensityAdd = 0.1,
        HazeAdd = 1,
        BrightnessMul = 0.85,
        ExposureAdd = -0.2,
        SaturationAdd = -0.1
    },
    STORM_GUST_FREQUENCY_MUL = 2.5,
    STORM_GUST_PEAK_MUL = 1.4,
    FLASH_MAX_BRIGHTNESS = 0.12,
    FLASH_FAR_STRENGTH = 0.5,
    FLASH_RISE_SECONDS = 0.15,
    FLASH_DECAY_SECONDS = 1,
    FLASH_MIN_INTERVAL = 1.2,
    THUNDER_MIN_DISTANCE = 128,
    THUNDER_MAX_DISTANCE = 512,
    THUNDER_ELEVATION_MIN_DEG = 10,
    THUNDER_ELEVATION_MAX_DEG = 30,
    THUNDER_CLEANUP_TIMEOUT_SECONDS = 30,
    THUNDER_CLOSE_DISTANCE = 256,
    THUNDER_ROLLOFF_MIN_DISTANCE = 1024,
    THUNDER_VOLUME_SCALE = 1,
    SCREEN_RAIN_RATE_MAX = 5,
    SCREEN_RAIN_SIZE = 0.08,
    SCREEN_RAIN_FADE = 1.5,
    SCREEN_RAIN_TINT = Color3.fromRGB(226, 244, 255),
    SCREEN_RAIN_UPDATE_HZ = 45,
    SCREEN_RAIN_MIN_QUALITY = 8,
    SCREEN_RAIN_MAX_LOOK_DOWN = -0.4,
    SCREEN_RAIN_COVER_RANGE = 120,
    RAIN_HELM_VOLUME = 1,
    HEAD_COVER_HARD_ATTR = "HeadCoverHard",
    FACE_COVER_VISORED_ATTR = "FaceCoverVisored"
};