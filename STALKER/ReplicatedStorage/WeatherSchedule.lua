-- Decompiled with Potassium's decompiler.

local WeatherConfig = require(script.Parent:WaitForChild("WeatherConfig"));
local WeatherMath = require(script.Parent:WaitForChild("WeatherMath"));
local u1 = {};
local SCHEDULE_EPOCH = WeatherConfig.SCHEDULE_EPOCH;
local SCHEDULE_CYCLE_SECONDS = WeatherConfig.SCHEDULE_CYCLE_SECONDS;
local RAMP_SECONDS = WeatherConfig.RAMP_SECONDS;

function u1.Mix(...) -- Line: 37
    local v2 = 0;

    for i = 1, select("#", ...) do
        local v3 = select(i, ...);
        v2 = (v2 * 131 + v3 % 2147483647) % 2147483647;
        local _ = i;
    end;

    return v2;
end;

local u4 = {};
local u5 = 0;
local u6 = 0;

local function cycle(p7: number) -- Line: 51
    -- upvalues: u4 (copy), u6 (ref), u1 (copy), WeatherConfig (copy), SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy), WeatherMath (copy), u5 (ref)
    local v8 = u4[p7];

    if v8 then
        return v8;
    end;

    u6 = u6 + 1;
    local Random_new_ret = Random.new(u1.Mix(1, WeatherConfig.SCHEDULE_SEED, WeatherConfig.SCHEDULE_VERSION, p7));
    local v9 = SCHEDULE_EPOCH + p7 * SCHEDULE_CYCLE_SECONDS;
    local v10 = v9 + SCHEDULE_CYCLE_SECONDS;

    local function random() -- Line: 58
        -- upvalues: Random_new_ret (copy)
        return Random_new_ret:NextNumber();
    end;

    local v11 = nil;
    local v12 = {};

    while v9 < v10 do
        v11 = WeatherMath.PickState(random, v11);
        local v13 = WeatherMath.SpellSeconds(v11, random);
        local v14 = v9 + math.floor(v13);
        local math_min_ret = math.min(v14, v10);

        if math_min_ret <= v9 then
            error(("[WeatherSchedule] cycle %s cannot advance past t = %s"):format(tostring(p7), (tostring(v9))));
        end;

        if math_min_ret - v9 < WeatherConfig.SCHEDULE_MIN_SPELL_SECONDS and #v12 > 0 then
            v12[#v12].endsAt = v10;
            break;
        end;

        table.insert(v12, {
            state = v11,
            startsAt = v9,
            endsAt = math_min_ret,
            cycle = p7,
            spellIndex = #v12 + 1
        });
        v9 = math_min_ret;
    end;

    for _, v in ipairs(v12) do
        table.freeze(v);
    end;

    table.freeze(v12);

    if u5 >= 8 then
        local v15 = nil;

        for i in pairs(u4) do
            if v15 == nil or math.abs(i - p7) > math.abs(v15 - p7) then
                v15 = i;
            end;
        end;

        u4[v15] = nil;
        u5 = u5 - 1;
    end;

    u4[p7] = v12;
    u5 = u5 + 1;

    return v12;
end;

local function cycleOf(p16: number) -- Line: 108
    -- upvalues: SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy)
    return math.floor((p16 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS);
end;

local function pieceBefore(p17) -- Line: 112
    -- upvalues: cycle (copy)
    if p17.spellIndex > 1 then
        return cycle(p17.cycle)[p17.spellIndex - 1];
    end;

    local v18 = cycle(p17.cycle - 1);

    return v18[#v18];
end;

local function pieceAfter(p19) -- Line: 120
    -- upvalues: cycle (copy)
    local v20 = cycle(p19.cycle);

    if p19.spellIndex < #v20 then
        return v20[p19.spellIndex + 1];
    end;

    return cycle(p19.cycle + 1)[1];
end;

local function locate(p21: number) -- Line: 128
    -- upvalues: cycle (copy), SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy)
    local v22 = cycle((math.floor((p21 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS)));

    for _, v in ipairs(v22) do
        if p21 < v.endsAt then
            return v;
        end;
    end;

    return v22[#v22];
end;

local function spellAround(p23) -- Line: 141
    -- upvalues: cycle (copy)
    local v24;

    if p23.spellIndex == 1 then
        if p23.spellIndex > 1 then
            v24 = cycle(p23.cycle)[p23.spellIndex - 1];
        else
            local v25 = cycle(p23.cycle - 1);
            v24 = v25[#v25];
        end;

        if v24.state ~= p23.state then
            v24 = p23;
        end;
    else
        v24 = p23;
    end;

    local v26;

    if p23.spellIndex == #cycle(p23.cycle) then
        local v27 = cycle(p23.cycle);

        if p23.spellIndex < #v27 then
            v26 = v27[p23.spellIndex + 1];
        else
            v26 = cycle(p23.cycle + 1)[1];
        end;

        if v26.state ~= p23.state then
            v26 = p23;
        end;
    else
        v26 = p23;
    end;

    return v24, v26;
end;

function u1.Pieces(p28: number) -- Line: 158
    -- upvalues: cycle (copy)
    return cycle(p28);
end;

function u1.GeneratedCycles() -- Line: 162
    -- upvalues: u6 (ref)
    return u6;
end;

function u1.At(p29: number) -- Line: 166
    -- upvalues: cycle (copy), SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy), spellAround (copy), WeatherMath (copy), RAMP_SECONDS (copy)
    local v30 = cycle((math.floor((p29 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS)));
    local v31;

    for _, v in ipairs(v30) do
        if p29 < v.endsAt then
            v31 = v;
            break;
        end;
    end;

    v31 = v30[#v30];
    local v32, v33 = spellAround(v31);
    local v34;

    if v32.spellIndex > 1 then
        v34 = cycle(v32.cycle)[v32.spellIndex - 1];
    else
        local v35 = cycle(v32.cycle - 1);
        v34 = v35[#v35];
    end;

    local state = v34.state;
    local v36, v37 = WeatherMath.Levels(state);
    local v38, v39 = WeatherMath.Levels(v31.state);
    local math_clamp_ret = math.clamp((p29 - v32.startsAt) / RAMP_SECONDS, 0, 1);
    local v40 = {
        state = v31.state,
        startsAt = v32.startsAt,
        endsAt = v33.endsAt,
        previous = state
    };
    local v41 = cycle(v33.cycle);
    local v42;

    if v33.spellIndex < #v41 then
        v42 = v41[v33.spellIndex + 1];
    else
        v42 = cycle(v33.cycle + 1)[1];
    end;

    v40.next = v42.state;
    v40.nextStartsAt = v33.endsAt;
    v40.transitionSeconds = RAMP_SECONDS;
    v40.inTransition = p29 < v32.startsAt + RAMP_SECONDS;
    v40.rain = v36 * (1 - math_clamp_ret) + v38 * math_clamp_ret;
    v40.storm = v37 * (1 - math_clamp_ret) + v39 * math_clamp_ret;
    v40.cycle = v31.cycle;
    v40.spellIndex = v31.spellIndex;

    return v40;
end;

function u1.Transitions(p43: number, p44: number) -- Line: 192
    -- upvalues: SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy), cycle (copy)
    local v45 = {};

    if p43 >= p44 then
        return v45;
    end;

    for i = math.floor((p43 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS), math.floor((p44 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS) do
        local _ = i;

        for _, v in ipairs((cycle(i))) do
            if p43 <= v.startsAt and v.startsAt < p44 then
                local v46;

                if v.spellIndex > 1 then
                    v46 = cycle(v.cycle)[v.spellIndex - 1];
                else
                    local v47 = cycle(v.cycle - 1);
                    v46 = v47[#v47];
                end;

                if v46.state ~= v.state then
                    table.insert(v45, {
                        at = v.startsAt,
                        from = v46.state,
                        to = v.state,
                        cycle = v.cycle,
                        spellIndex = v.spellIndex
                    });
                end;
            end;
        end;
    end;

    return v45;
end;

local function strikesOf(p48) -- Line: 211
    -- upvalues: u1 (copy), WeatherConfig (copy), cycle (copy), RAMP_SECONDS (copy)
    local Random_new_ret = Random.new(u1.Mix(7331, WeatherConfig.SCHEDULE_SEED, WeatherConfig.SCHEDULE_VERSION, p48.cycle, p48.spellIndex));
    local startsAt = p48.startsAt;
    local v49;

    if p48.spellIndex > 1 then
        v49 = cycle(p48.cycle)[p48.spellIndex - 1];
    else
        local v50 = cycle(p48.cycle - 1);
        v49 = v50[#v50];
    end;

    if v49.state ~= p48.state then
        startsAt = startsAt + RAMP_SECONDS;
    end;

    local v51 = {};

    while true do
        local LIGHTNING_MIN_GAP_SECONDS = WeatherConfig.LIGHTNING_MIN_GAP_SECONDS;
        local v52 = 1 - Random_new_ret:NextNumber();
        startsAt = startsAt + (LIGHTNING_MIN_GAP_SECONDS + -math.log(v52) * WeatherConfig.LIGHTNING_MEAN_INTERVAL);

        if p48.endsAt <= startsAt then
            break;
        end;

        local v53 = {
            at = startsAt,
            seed = Random_new_ret:NextInteger(1, 2147483646)
        };
        table.insert(v51, v53);
    end;

    return v51;
end;

function u1.StrikesBetween(p54: number, p55: number) -- Line: 232
    -- upvalues: SCHEDULE_EPOCH (copy), SCHEDULE_CYCLE_SECONDS (copy), cycle (copy), strikesOf (copy)
    local v56 = {};

    if p54 >= p55 then
        return v56;
    end;

    for i = math.floor((p54 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS), math.floor((p55 - SCHEDULE_EPOCH) / SCHEDULE_CYCLE_SECONDS) do
        local _ = i;

        for _, v in ipairs((cycle(i))) do
            if v.state == "Storm" and (v.startsAt < p55 and p54 < v.endsAt) then
                for _, v2 in ipairs((strikesOf(v))) do
                    if p54 <= v2.at and v2.at < p55 then
                        table.insert(v56, v2);
                    end;
                end;
            end;
        end;
    end;

    return v56;
end;

return u1;