-- Decompiled with Potassium's decompiler.

local WeatherConfig = require(script.Parent:WaitForChild("WeatherConfig"));
local WeatherSchedule = require(script.Parent:WaitForChild("WeatherSchedule"));
local EmissionConfig = require(script.Parent:WaitForChild("EmissionConfig"));
local u1 = {};
local SCHEDULE_EPOCH = WeatherConfig.SCHEDULE_EPOCH;
local SCHEDULE_CYCLE_SECONDS = WeatherConfig.SCHEDULE_CYCLE_SECONDS;
local PHASE = EmissionConfig.PHASE;

local function cycleOf(p2: number) -- Line: 34
    -- upvalues: SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy)
    return math.floor((p2 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS);
end;

function u1.CycleOf(p3: number) -- Line: 40
    -- upvalues: SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy)
    return math.floor((p3 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS);
end;

function u1.OnsetOf(p4: number) -- Line: 45
    -- upvalues: WeatherSchedule (copy), EmissionConfig (copy), WeatherConfig (copy), SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy)
    local Random_new_ret = Random.new(WeatherSchedule.Mix(EmissionConfig.SALT, WeatherConfig.SCHEDULE_SEED, WeatherConfig.SCHEDULE_VERSION, p4));

    return SCHEDULE_EPOCH + p4 * SCHEDULE_CYCLE_SECONDS + Random_new_ret:NextInteger(EmissionConfig.PLACEMENT_START, SCHEDULE_CYCLE_SECONDS - EmissionConfig.CLEAR_END);
end;

local function timeline(p5: number) -- Line: 52
    -- upvalues: EmissionConfig (copy)
    return {
        onset = p5,
        warningAt = p5 - EmissionConfig.WARNING_LEAD,
        omenAt = p5 - EmissionConfig.OMEN_LEAD,
        apexAt = p5 + EmissionConfig.SURGE_END,
        killAt = p5 + EmissionConfig.APEX_END,
        endsAt = p5 + EmissionConfig.CLEAR_END
    };
end;

local function describe(p6: number) -- Line: 63
    -- upvalues: u1 (copy), EmissionConfig (copy)
    local v7 = u1.OnsetOf(p6);

    return {
        onset = v7,
        warningAt = v7 - EmissionConfig.WARNING_LEAD,
        omenAt = v7 - EmissionConfig.OMEN_LEAD,
        apexAt = v7 + EmissionConfig.SURGE_END,
        killAt = v7 + EmissionConfig.APEX_END,
        endsAt = v7 + EmissionConfig.CLEAR_END,
        cycle = p6
    };
end;

function u1.Forced(p8: number) -- Line: 72
    -- upvalues: EmissionConfig (copy)
    return {
        onset = p8,
        warningAt = p8 - EmissionConfig.WARNING_LEAD,
        omenAt = p8 - EmissionConfig.OMEN_LEAD,
        apexAt = p8 + EmissionConfig.SURGE_END,
        killAt = p8 + EmissionConfig.APEX_END,
        endsAt = p8 + EmissionConfig.CLEAR_END,
        forced = true
    };
end;

function u1.PhaseLevel(p9: number) -- Line: 82
    -- upvalues: EmissionConfig (copy), PHASE (copy)
    if p9 < -EmissionConfig.OMEN_LEAD or EmissionConfig.CLEAR_END <= p9 then
        return PHASE.None, 0;
    end;

    if p9 < 0 then
        return PHASE.Omen, 0;
    end;

    if p9 < EmissionConfig.BUILDUP_END then
        return PHASE.Buildup, EmissionConfig.BUILDUP_LEVEL * (p9 / EmissionConfig.BUILDUP_END);
    end;

    if p9 < EmissionConfig.SURGE_END then
        local v10 = (p9 - EmissionConfig.BUILDUP_END) / (EmissionConfig.SURGE_END - EmissionConfig.BUILDUP_END);

        return PHASE.Surge, EmissionConfig.BUILDUP_LEVEL * (1 - v10) + v10;
    end;

    if p9 < EmissionConfig.APEX_END then
        return PHASE.Apex, 1;
    end;

    return PHASE.Clearing, 1 - (p9 - EmissionConfig.APEX_END) / (EmissionConfig.CLEAR_END - EmissionConfig.APEX_END);
end;

function u1.AtOf(p11: any, p12: number) -- Line: 106
    -- upvalues: u1 (copy)
    local table_clone_ret = table.clone(p11);
    local v13, v14 = u1.PhaseLevel(p12 - p11.onset);
    table_clone_ret.phase = v13;
    table_clone_ret.level = v14;

    return table_clone_ret;
end;

function u1.At(p15: number) -- Line: 112
    -- upvalues: u1 (copy), SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy), EmissionConfig (copy)
    local AtOf = u1.AtOf;
    local math_floor_ret = math.floor((p15 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS);
    local v16 = u1.OnsetOf(math_floor_ret);

    return AtOf({
        onset = v16,
        warningAt = v16 - EmissionConfig.WARNING_LEAD,
        omenAt = v16 - EmissionConfig.OMEN_LEAD,
        apexAt = v16 + EmissionConfig.SURGE_END,
        killAt = v16 + EmissionConfig.APEX_END,
        endsAt = v16 + EmissionConfig.CLEAR_END,
        cycle = math_floor_ret
    }, p15);
end;

function u1.Next(p17: number) -- Line: 117
    -- upvalues: SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy), u1 (copy), EmissionConfig (copy)
    local math_floor_ret = math.floor((p17 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS);
    local v18 = u1.OnsetOf(math_floor_ret);
    local v19 = {
        onset = v18,
        warningAt = v18 - EmissionConfig.WARNING_LEAD,
        omenAt = v18 - EmissionConfig.OMEN_LEAD,
        apexAt = v18 + EmissionConfig.SURGE_END,
        killAt = v18 + EmissionConfig.APEX_END,
        endsAt = v18 + EmissionConfig.CLEAR_END,
        cycle = math_floor_ret
    };

    if v19.onset < p17 then
        local v20 = math_floor_ret + 1;
        local v21 = u1.OnsetOf(v20);
        v19 = {
            onset = v21,
            warningAt = v21 - EmissionConfig.WARNING_LEAD,
            omenAt = v21 - EmissionConfig.OMEN_LEAD,
            apexAt = v21 + EmissionConfig.SURGE_END,
            killAt = v21 + EmissionConfig.APEX_END,
            endsAt = v21 + EmissionConfig.CLEAR_END,
            cycle = v20
        };
    end;

    return v19;
end;

function u1.Weather(p22: number) -- Line: 129
    -- upvalues: EmissionConfig (copy)
    local math_clamp_ret = math.clamp(p22, 0, 1);

    return EmissionConfig.EMISSION_RAIN_MAX * math_clamp_ret, math.clamp((math_clamp_ret - EmissionConfig.BUILDUP_LEVEL) / (1 - EmissionConfig.BUILDUP_LEVEL), 0, 1);
end;

local function strikesOf(p23) -- Line: 139
    -- upvalues: WeatherSchedule (copy), EmissionConfig (copy), WeatherConfig (copy)
    local cycle = p23.cycle;
    local v24;

    if p23.forced then
        cycle = p23.onset;
        v24 = 3;
    else
        v24 = 2;
    end;

    local Random_new_ret = Random.new(WeatherSchedule.Mix(EmissionConfig.SALT, WeatherConfig.SCHEDULE_SEED, WeatherConfig.SCHEDULE_VERSION, cycle, v24));
    local onset = p23.onset;
    local v25 = {};

    while true do
        local v26;

        if onset - p23.onset < EmissionConfig.BUILDUP_END then
            v26 = EmissionConfig.BUILDUP_STRIKE_MEAN;
        else
            v26 = EmissionConfig.SURGE_STRIKE_MEAN;
        end;

        local STRIKE_MIN_GAP = EmissionConfig.STRIKE_MIN_GAP;
        local v27 = 1 - Random_new_ret:NextNumber();
        onset = onset + (STRIKE_MIN_GAP + -math.log(v27) * v26);

        if p23.killAt <= onset then
            return v25;
        end;

        local v28 = onset - p23.onset >= EmissionConfig.BUILDUP_END;
        local v29 = {
            at = onset,
            seed = Random_new_ret:NextInteger(1, 1073741823) * 2 + (v28 and 1 or 0)
        };
        table.insert(v25, v29);
    end;
end;

function u1.StrikesOf(p30: any, p31: number, p32: number) -- Line: 160
    -- upvalues: strikesOf (copy)
    local v33 = {};

    if p31 >= p32 or (p30.onset >= p32 or p31 >= p30.killAt) then
        return v33;
    end;

    for _, v in ipairs((strikesOf(p30))) do
        if p31 <= v.at and v.at < p32 then
            table.insert(v33, v);
        end;
    end;

    return v33;
end;

function u1.StrikesBetween(p34: number, p35: number) -- Line: 173
    -- upvalues: SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy), u1 (copy), EmissionConfig (copy)
    local v36 = {};

    if p34 >= p35 then
        return v36;
    end;

    for i = math.floor((p34 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS), math.floor((p35 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS) do
        local v37 = ipairs;
        local StrikesOf = u1.StrikesOf;
        local v38 = u1.OnsetOf(i);
        local _ = i;

        for _, v in v37(StrikesOf({
            onset = v38,
            warningAt = v38 - EmissionConfig.WARNING_LEAD,
            omenAt = v38 - EmissionConfig.OMEN_LEAD,
            apexAt = v38 + EmissionConfig.SURGE_END,
            killAt = v38 + EmissionConfig.APEX_END,
            endsAt = v38 + EmissionConfig.CLEAR_END,
            cycle = i
        }, p34, p35)) do
            table.insert(v36, v);
        end;
    end;

    return v36;
end;

function u1.Nudge(p39: number) -- Line: 189
    if p39 + 2 > 2147483647 then
        return p39 + 2 - 2147483646;
    end;

    return p39 + 2;
end;

function u1.DamageFractionOf(p40: any, p41: number) -- Line: 207
    -- upvalues: EmissionConfig (copy)
    if p40.killAt <= p41 then
        return 0;
    end;

    local v42 = p40.onset + EmissionConfig.BUILDUP_END;

    if p41 < v42 then
        return 0;
    end;

    if p41 < p40.apexAt then
        local math_clamp_ret = math.clamp((p41 - v42) / (EmissionConfig.SURGE_END - EmissionConfig.BUILDUP_END), 0, 1);

        return EmissionConfig.SURGE_DAMAGE_START_FRACTION * (1 - math_clamp_ret) + EmissionConfig.SURGE_DAMAGE_END_FRACTION * math_clamp_ret;
    end;

    local math_clamp_ret = math.clamp((p41 - p40.apexAt) / EmissionConfig.DAMAGE_RAMP_SECONDS, 0, 1);

    return EmissionConfig.DAMAGE_START_FRACTION * (1 - math_clamp_ret) + EmissionConfig.DAMAGE_END_FRACTION * math_clamp_ret;
end;

function u1.DamageFraction(p43: number) -- Line: 226
    -- upvalues: u1 (copy), SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy), EmissionConfig (copy)
    local DamageFractionOf = u1.DamageFractionOf;
    local math_floor_ret = math.floor((p43 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS);
    local v44 = u1.OnsetOf(math_floor_ret);

    return DamageFractionOf({
        onset = v44,
        warningAt = v44 - EmissionConfig.WARNING_LEAD,
        omenAt = v44 - EmissionConfig.OMEN_LEAD,
        apexAt = v44 + EmissionConfig.SURGE_END,
        killAt = v44 + EmissionConfig.APEX_END,
        endsAt = v44 + EmissionConfig.CLEAR_END,
        cycle = math_floor_ret
    }, p43);
end;

function u1.IsKillTickOf(p45: any, p46: number) -- Line: 232
    -- upvalues: EmissionConfig (copy)
    local v47;

    if p45.killAt <= p46 then
        v47 = p46 < p45.killAt + EmissionConfig.KILL_WINDOW_SECONDS;
    else
        v47 = false;
    end;

    return v47;
end;

function u1.IsKillTick(p48: number) -- Line: 237
    -- upvalues: u1 (copy), SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy), EmissionConfig (copy)
    local IsKillTickOf = u1.IsKillTickOf;
    local math_floor_ret = math.floor((p48 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS);
    local v49 = u1.OnsetOf(math_floor_ret);

    return IsKillTickOf({
        onset = v49,
        warningAt = v49 - EmissionConfig.WARNING_LEAD,
        omenAt = v49 - EmissionConfig.OMEN_LEAD,
        apexAt = v49 + EmissionConfig.SURGE_END,
        killAt = v49 + EmissionConfig.APEX_END,
        endsAt = v49 + EmissionConfig.CLEAR_END,
        cycle = math_floor_ret
    }, p48);
end;

return u1;