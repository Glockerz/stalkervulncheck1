-- Decompiled with Potassium's decompiler.

local WeatherConfig = require(script.Parent:WaitForChild("WeatherConfig"));
local v15 = {
    PickState = function(p1: function, p2: string?) -- Line: 17, Name: PickState
        -- upvalues: WeatherConfig (copy)
        local v3 = 0;

        for _, v in ipairs(WeatherConfig.STATE_ORDER) do
            if v ~= p2 then
                v3 = v3 + WeatherConfig.STATES[v].Weight;
            end;
        end;

        local v4 = p1() * v3;
        local v5 = WeatherConfig.STATE_ORDER[#WeatherConfig.STATE_ORDER];

        for _, v in ipairs(WeatherConfig.STATE_ORDER) do
            if v ~= p2 then
                v4 = v4 - WeatherConfig.STATES[v].Weight;

                if v4 < 0 then
                    return v;
                end;

                v5 = v;
            end;
        end;

        return v5;
    end,

    SpellSeconds = function(p6: string, p7: function) -- Line: 39, Name: SpellSeconds
        -- upvalues: WeatherConfig (copy)
        local v8 = WeatherConfig.STATES[p6];

        return v8.SpellMin + p7() * (v8.SpellMax - v8.SpellMin);
    end,

    Levels = function(p9: string) -- Line: 44, Name: Levels
        -- upvalues: WeatherConfig (copy)
        local v10 = WeatherConfig.STATES[p9];

        return v10.Rain, v10.Storm;
    end,

    RainLayers = function(p11: number) -- Line: 55, Name: RainLayers
        local math_clamp_ret = math.clamp(p11, 0, 3);
        local v12;

        if math_clamp_ret <= 1 then
            v12 = math_clamp_ret;
        else
            v12 = math_clamp_ret > 2 and 0 or 2 - math_clamp_ret;
        end;

        local v13;

        if math_clamp_ret <= 1 then
            v13 = 0;
        elseif math_clamp_ret <= 2 then
            v13 = math_clamp_ret - 1;
        else
            v13 = 3 - math_clamp_ret;
        end;

        if math_clamp_ret <= 2 then
            return v12, v13, 0;
        end;

        return v12, v13, math_clamp_ret - 2;
    end,

    GridSize = function(p14) -- Line: 64, Name: GridSize
        -- upvalues: WeatherConfig (copy)
        if typeof(p14) == "EnumItem" then
            p14 = p14.Value;
        end;

        if type(p14) ~= "number" or p14 <= 0 then
            return WeatherConfig.GRID_AUTOMATIC;
        end;

        for _, v in ipairs(WeatherConfig.GRID_BANDS) do
            if p14 <= v.MaxLevel then
                return v.Size;
            end;
        end;

        return WeatherConfig.GRID_BANDS[#WeatherConfig.GRID_BANDS].Size;
    end
};
local table_freeze_ret = table.freeze({
    Identity = true,
    DensityAdd = 0,
    HazeAdd = 0,
    BrightnessMul = 1,
    ExposureAdd = 0,
    SaturationAdd = 0
});

function v15.LightingAdjustment(p16: number?, p17: number?) -- Line: 87
    -- upvalues: table_freeze_ret (copy), WeatherConfig (copy)
    if type(p16) ~= "number" or type(p17) ~= "number" then
        return table_freeze_ret;
    end;

    local v18 = math.clamp(p16, 0, 3) / 3;
    local math_clamp_ret = math.clamp(p17, 0, 1);

    if v18 == 0 and math_clamp_ret == 0 then
        return table_freeze_ret;
    end;

    local LIGHTING_RAIN = WeatherConfig.LIGHTING_RAIN;
    local LIGHTING_STORM = WeatherConfig.LIGHTING_STORM;

    return {
        Identity = false,
        DensityAdd = v18 * LIGHTING_RAIN.DensityAdd + math_clamp_ret * LIGHTING_STORM.DensityAdd,
        HazeAdd = v18 * LIGHTING_RAIN.HazeAdd + math_clamp_ret * LIGHTING_STORM.HazeAdd,
        BrightnessMul = (1 - v18 * (1 - LIGHTING_RAIN.BrightnessMul)) * (1 - math_clamp_ret * (1 - LIGHTING_STORM.BrightnessMul)),
        ExposureAdd = v18 * LIGHTING_RAIN.ExposureAdd + math_clamp_ret * LIGHTING_STORM.ExposureAdd,
        SaturationAdd = v18 * LIGHTING_RAIN.SaturationAdd + math_clamp_ret * LIGHTING_STORM.SaturationAdd
    };
end;

function v15.GustScale(p19: number?) -- Line: 110
    -- upvalues: WeatherConfig (copy)
    if type(p19) ~= "number" or p19 <= 0 then
        return 1, 1;
    end;

    local math_clamp_ret = math.clamp(p19, 0, 1);

    return 1 + math_clamp_ret * (WeatherConfig.STORM_GUST_FREQUENCY_MUL - 1), 1 + math_clamp_ret * (WeatherConfig.STORM_GUST_PEAK_MUL - 1);
end;

function v15.ScreenRainAllowed(p20) -- Line: 122
    -- upvalues: WeatherConfig (copy)
    if typeof(p20) == "EnumItem" then
        p20 = p20.Value;
    end;

    if type(p20) == "number" then
        return p20 == 0 and true or WeatherConfig.SCREEN_RAIN_MIN_QUALITY <= p20;
    end;

    return false;
end;

function v15.ThunderSet(p21: number) -- Line: 131
    -- upvalues: WeatherConfig (copy)
    return p21 < WeatherConfig.THUNDER_CLOSE_DISTANCE and "close" or "far";
end;

function v15.FlashEnvelope(p22: number) -- Line: 139
    -- upvalues: WeatherConfig (copy)
    local FLASH_RISE_SECONDS = WeatherConfig.FLASH_RISE_SECONDS;
    local FLASH_DECAY_SECONDS = WeatherConfig.FLASH_DECAY_SECONDS;

    if p22 < 0 or FLASH_RISE_SECONDS + FLASH_DECAY_SECONDS <= p22 then
        return 0;
    end;

    if p22 < FLASH_RISE_SECONDS then
        local v23 = p22 / FLASH_RISE_SECONDS;

        return v23 * v23 * (3 - 2 * v23);
    end;

    local v24 = (p22 - FLASH_RISE_SECONDS) / FLASH_DECAY_SECONDS;

    return (1 - v24) * (1 - v24);
end;

return v15;