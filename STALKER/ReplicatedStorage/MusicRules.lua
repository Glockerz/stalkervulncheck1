-- Decompiled with Potassium's decompiler.

local MusicConfig = require(script.Parent:WaitForChild("MusicConfig"));
local u1 = {};
local u2 = {
    off = true,
    all = true,
    one = true
};

local function isInt(p3) -- Line: 14
    local v4;

    if type(p3) == "number" and (p3 == p3 and (p3 == math.floor(p3) and p3 > (-1 / 0))) then
        v4 = p3 < (1 / 0);
    else
        v4 = false;
    end;

    return v4;
end;

function u1.Defaults() -- Line: 18
    -- upvalues: MusicConfig (copy)
    return {
        shuffle = false,
        repeatMode = "off",
        speaker = false,
        hearOthers = true,
        volume = MusicConfig.VOLUME_DEFAULT,
        custom = {}
    };
end;

function u1.Sanitize(p5) -- Line: 29
    -- upvalues: u1 (copy), MusicConfig (copy), u2 (copy)
    local v6 = u1.Defaults();

    if type(p5) ~= "table" then
        return v6;
    end;

    local volume = p5.volume;

    if type(volume) == "number" and volume == volume then
        v6.volume = math.clamp(volume, 0, MusicConfig.VOLUME_MAX);
    end;

    if type(p5.shuffle) == "boolean" then
        v6.shuffle = p5.shuffle;
    end;

    if type(p5.repeatMode) == "string" and u2[p5.repeatMode] then
        v6.repeatMode = p5.repeatMode;
    end;

    if type(p5.speaker) == "boolean" then
        v6.speaker = p5.speaker;
    end;

    if type(p5.hearOthers) == "boolean" then
        v6.hearOthers = p5.hearOthers;
    end;

    if type(p5.custom) == "table" then
        local v7 = {};

        for _, v in ipairs(p5.custom) do
            if #v6.custom >= MusicConfig.CUSTOM_MAX then
                break;
            end;

            local v8;

            if type(v) == "number" and (v == v and (v == math.floor(v) and v > (-1 / 0))) then
                v8 = v < (1 / 0);
            else
                v8 = false;
            end;

            if v8 and (v > 0 and (v < 9007199254740992 and not v7[v])) then
                v7[v] = true;
                table.insert(v6.custom, v);
            end;
        end;
    end;

    return v6;
end;

function u1.ParseCustomId(p9) -- Line: 53
    if type(p9) ~= "string" then
        return nil;
    end;

    local v10 = p9:gsub("^%s+", ""):gsub("%s+$", ""):gsub("^rbxassetid://", "");

    if not v10:match("^%d+$") or #v10 > 16 then
        return nil;
    end;

    local v11 = tonumber(v10);

    if v11 and v11 > 0 then
        return v11;
    end;

    return nil;
end;

function u1.SpeakerAllowed(p12: any, p13: number) -- Line: 63
    local v14;

    if type(p12) == "number" and (p12 == p12 and (p12 == math.floor(p12) and p12 > (-1 / 0))) then
        v14 = p12 < (1 / 0);
    else
        v14 = false;
    end;

    if v14 then
        if p12 >= 1 then
            v14 = p12 <= p13;
        else
            v14 = false;
        end;
    end;

    return v14;
end;

function u1.BuildOrder(p15: number, p16: boolean, p17: number, p18: userdata?) -- Line: 67
    local v19 = {};

    if p15 <= 0 then
        return v19;
    end;

    local math_clamp_ret = math.clamp(p17, 1, p15);

    if not p16 then
        for i = 0, p15 - 1 do
            table.insert(v19, (math_clamp_ret - 1 + i) % p15 + 1);
            local _ = i;
        end;

        return v19;
    end;

    local v20 = p18 or Random.new();

    for i = 1, p15 do
        local v21;

        if i == math_clamp_ret then
            v21 = i;
        else
            table.insert(v19, i);
            v21 = i;
        end;
    end;

    for i = #v19, 2, -1 do
        local v22 = v20:NextInteger(1, i);
        local v23 = v19[i];
        v19[i] = v19[v22];
        v19[v22] = v23;
        local _ = i;
    end;

    table.insert(v19, 1, math_clamp_ret);

    return v19;
end;

function u1.NextPos(p24: number, p25: number, p26: string) -- Line: 89
    if p24 <= 0 then
        return nil;
    end;

    if p26 == "one" then
        return p25;
    end;

    if p25 < p24 then
        return p25 + 1;
    end;

    return p26 == "all" and 1 or nil;
end;

function u1.PrevPos(p27: number, p28: number, p29: string, p30: number) -- Line: 97
    -- upvalues: MusicConfig (copy)
    if MusicConfig.PREV_RESTART_AFTER < p30 or p27 <= 0 then
        return p28;
    end;

    if p28 > 1 then
        return p28 - 1;
    end;

    if p29 == "all" then
        return p27;
    end;

    return p28;
end;

function u1.NextAfterFailure(p31: number, p32: number, p33: number, p34: string) -- Line: 108
    if p31 <= 0 or p31 <= p33 then
        return nil;
    end;

    if p31 <= p32 then
        return p34 == "all" and 1 or nil;
    end;

    return p32 + 1;
end;

function u1.ClampSeek(p35: number, p36: number) -- Line: 116
    if type(p35) ~= "number" or p35 ~= p35 then
        return 0;
    end;

    local math_max_ret = math.max(0, p36 - 0.1);

    return math.clamp(p35, 0, math_max_ret);
end;

function u1.CycleRepeat(p37: string) -- Line: 121
    return p37 == "off" and "all" or (p37 == "all" and "one" or "off");
end;

function u1.FormatTime(p38: number) -- Line: 127
    local math_floor_ret = math.floor(p38 or 0);
    local math_max_ret = math.max(0, math_floor_ret);

    return string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
end;

return u1;