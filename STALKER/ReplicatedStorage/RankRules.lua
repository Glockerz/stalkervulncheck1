-- Decompiled with Potassium's decompiler.

local u1 = {
    RANKS = { {
            name = "Rookie",
            rp = 0
        }, {
            name = "Experienced",
            rp = 500
        }, {
            name = "Professional",
            rp = 1750
        }, {
            name = "Veteran",
            rp = 4500
        }, {
            name = "Expert",
            rp = 9000
        }, {
            name = "Legend",
            rp = 18000
        } },
    KILL_DAILY_CAP = 60,
    TASK_DAILY_CAP = 260,
    EXTRACT_RP = 10,
    EXTRACT_DAILY_MAX = 3,
    DAILY_TASK_RP = 15,
    TUTORIAL_RP = 50,
    MAIN_STAGE_RP = 10,
    MAIN_TASK_RP = {
        lost_cargo = 150,
        valuable_intel = 200,
        trial_by_fire = 300,
        introduction = 400
    },
    ARRIVE_RP = {
        swamps = 100
    },
    DISCOVER_RP = 20,
    MUTANT_RP = {
        flesh = 1,
        blinddog = 1,
        boar = 3
    },
    NPC_RANK_RP = {
        Rookie = 1,
        Experienced = 2,
        Professional = 3,
        Veteran = 5,
        Expert = 8
    },
    MONOLITH_GUNNER_RP = 15,
    NO_KILL_RP = {
        Loner = true,
        ClearSky = true
    }
};

function u1.RankFor(p2: number) -- Line: 48
    -- upvalues: u1 (copy)
    local v3 = 1;

    for i, v in ipairs(u1.RANKS) do
        if v.rp <= p2 then
            v3 = i;
        end;
    end;

    return v3, u1.RANKS[v3].name;
end;

u1.RANK_SHORT = {
    Rookie = "ROOK",
    Experienced = "EXP",
    Professional = "PRO",
    Veteran = "VET",
    Expert = "EXPT",
    Legend = "LGND"
};
u1.RANK_COLORS = {
    Color3.fromRGB(190, 140, 100),
    Color3.fromRGB(180, 180, 180),
    Color3.fromRGB(220, 180, 90),
    Color3.fromRGB(160, 130, 210),
    Color3.fromRGB(225, 95, 95),
    Color3.fromRGB(225, 200, 90)
};
local Color3_fromRGB_ret = Color3.fromRGB(110, 110, 110);

function u1.ShortName(p4: string?) -- Line: 68
    -- upvalues: u1 (copy)
    return u1.RANK_SHORT[p4 or ""] or "--";
end;

function u1.ColorFor(p5: string?) -- Line: 72
    -- upvalues: u1 (copy), Color3_fromRGB_ret (copy)
    for i, v in ipairs(u1.RANKS) do
        if v.name == p5 then
            return u1.RANK_COLORS[i];
        end;
    end;

    return Color3_fromRGB_ret;
end;

function u1.Progress(p6: number) -- Line: 80
    -- upvalues: u1 (copy)
    local v7, v8 = u1.RankFor(p6);
    local rp = u1.RANKS[v7].rp;
    local v9 = u1.RANKS[v7 + 1];
    local v10 = {
        index = v7,
        name = v8,
        rp = p6,
        floor = rp
    };
    local v11;

    if v9 then
        v11 = v9.name or nil;
    else
        v11 = nil;
    end;

    v10.nextName = v11;
    local v12;

    if v9 then
        v12 = v9.rp or nil;
    else
        v12 = nil;
    end;

    v10.nextAt = v12;
    v10.fraction = v9 and math.clamp((p6 - rp) / (v9.rp - rp), 0, 1) or 1;

    return v10;
end;

local function num(p13: any, p14: number) -- Line: 95
    if type(p13) == "number" and (p13 == p13 and p13) then
        p14 = p13;
    end;

    return p14;
end;

function u1.TaskRP(p15) -- Line: 100
    local v16;

    if p15 then
        v16 = p15.type;
    else
        v16 = p15;
    end;

    local v17 = p15 and (p15.params or {}) or {};

    if v16 == "delivery" then
        return v17.cross_place and 15 or 10;
    end;

    if v16 == "deposit" then
        return 10;
    end;

    if v16 == "fetching" then
        local count = v17.count;
        local v18 = (type(count) ~= "number" or (count ~= count or not count)) and 1 or count;
        local math_floor_ret = math.floor(v18);
        local v19 = math.clamp(math_floor_ret, 1, 8) / 2;

        return math.floor(v19) + 5;
    end;

    if v16 == "exploration" then
        return 12;
    end;

    if v16 == "mutant_hunting" then
        local count = v17.count;
        local v20 = (type(count) ~= "number" or (count ~= count or not count)) and 3 or count;
        local math_floor_ret = math.floor(v20);

        return math.clamp(math_floor_ret, 1, 10) * 3 + 5;
    end;

    if v16 ~= "clearing" then
        return v16 == "kill_contract" and 25 or 0;
    end;

    local v21 = p15.rewards and p15.rewards.rep and p15.rewards.rep.amount;
    local v22 = v17.threat or type(v21) == "number" and v21 / 8 or 2;
    local v23 = (type(v22) ~= "number" or (v22 ~= v22 or not v22)) and 2 or v22;
    local math_floor_ret = math.floor(v23);

    return math.clamp(math_floor_ret, 1, 5) * 6;
end;

function u1.KillRP(p24: string?, p25: string?, p26: string?) -- Line: 121
    -- upvalues: u1 (copy)
    return p24 == "Mutant" and (u1.MUTANT_RP[string.lower(p25 or "")] or 1) or ((p24 == nil or u1.NO_KILL_RP[p24]) and 0 or ((p24 ~= "Monolith" or p26 ~= "Expert") and (u1.NPC_RANK_RP[p26 or ""] or 1) or u1.MONOLITH_GUNNER_RP));
end;

function u1.NewRecord() -- Line: 128
    return {
        rp = 0,
        playSeconds = 0,
        bySource = {},
        once = {},
        daily = {
            day = 0,
            killRp = 0,
            extractions = 0,
            taskRp = 0
        }
    };
end;

function u1.Sanitize(p27) -- Line: 133
    -- upvalues: u1 (copy)
    local v28 = u1.NewRecord();

    if type(p27) ~= "table" then
        return v28;
    end;

    local rp = p27.rp;
    local v29 = (type(rp) ~= "number" or (rp ~= rp or not rp)) and 0 or rp;
    local math_floor_ret = math.floor(v29);
    v28.rp = math.max(0, math_floor_ret);
    local playSeconds = p27.playSeconds;
    local v30 = (type(playSeconds) ~= "number" or (playSeconds ~= playSeconds or not playSeconds)) and 0 or playSeconds;
    v28.playSeconds = math.max(0, v30);

    if type(p27.bySource) == "table" then
        for i, v in pairs(p27.bySource) do
            if type(i) == "string" and (type(v) == "number" and (v == v and v > 0)) then
                v28.bySource[i] = v;
            end;
        end;
    end;

    if type(p27.once) == "table" then
        for i, v in pairs(p27.once) do
            if type(i) == "string" and v == true then
                v28.once[i] = true;
            end;
        end;
    end;

    if type(p27.daily) == "table" then
        local daily = v28.daily;
        local day = p27.daily.day;
        local v31 = (type(day) ~= "number" or (day ~= day or not day)) and 0 or day;
        daily.day = math.floor(v31);
        local daily2 = v28.daily;
        local killRp = p27.daily.killRp;
        local v32 = (type(killRp) ~= "number" or (killRp ~= killRp or not killRp)) and 0 or killRp;
        daily2.killRp = math.max(0, v32);
        local daily3 = v28.daily;
        local extractions = p27.daily.extractions;
        local v33 = (type(extractions) ~= "number" or (extractions ~= extractions or not extractions)) and 0 or extractions;
        daily3.extractions = math.max(0, v33);
        local daily4 = v28.daily;
        local taskRp = p27.daily.taskRp;
        local v34 = (type(taskRp) ~= "number" or (taskRp ~= taskRp or not taskRp)) and 0 or taskRp;
        daily4.taskRp = math.max(0, v34);
    end;

    return v28;
end;

function u1.Apply(p35: any, p36: any, p37: number) -- Line: 160
    -- upvalues: u1 (copy)
    local v38;

    if p36 then
        v38 = p36.amount;
    else
        v38 = p36;
    end;

    if type(v38) ~= "number" or (v38 ~= v38 or (v38 <= 0 or v38 == (1 / 0))) then
        return 0;
    end;

    local math_floor_ret = math.floor(v38);

    if math_floor_ret <= 0 then
        return 0;
    end;

    if p36.once and p35.once[p36.once] then
        return 0;
    end;

    if p35.daily.day ~= p37 then
        p35.daily = {
            killRp = 0,
            extractions = 0,
            taskRp = 0,
            day = p37
        };
    end;

    if p36.kind == "kill" then
        local math_max_ret = math.max(0, u1.KILL_DAILY_CAP - p35.daily.killRp);
        math_floor_ret = math.min(math_floor_ret, math_max_ret);
    elseif p36.kind == "task" then
        local math_max_ret = math.max(0, u1.TASK_DAILY_CAP - (p35.daily.taskRp or 0));
        math_floor_ret = math.min(math_floor_ret, math_max_ret);
    elseif p36.kind == "extract" and p35.daily.extractions >= u1.EXTRACT_DAILY_MAX then
        return 0;
    end;

    if math_floor_ret <= 0 then
        return 0;
    end;

    if p36.once then
        p35.once[p36.once] = true;
    end;

    if p36.kind == "kill" then
        local daily = p35.daily;
        daily.killRp = daily.killRp + math_floor_ret;
    elseif p36.kind == "task" then
        p35.daily.taskRp = (p35.daily.taskRp or 0) + math_floor_ret;
    elseif p36.kind == "extract" then
        local daily = p35.daily;
        daily.extractions = daily.extractions + 1;
    end;

    local v39 = type(p36.source) == "string" and (p36.source or "other") or "other";
    p35.rp = p35.rp + math_floor_ret;
    p35.bySource[v39] = (p35.bySource[v39] or 0) + math_floor_ret;

    return math_floor_ret;
end;

function u1.Merge(p40, p41, p42) -- Line: 191
    -- upvalues: u1 (copy)
    local v43 = u1.Sanitize(p40);
    local rp = v43.rp;
    local rp2 = p41.rp;
    local v44 = (type(rp2) ~= "number" or (rp2 ~= rp2 or not rp2)) and 0 or rp2;
    v43.rp = rp + math.max(0, v44);
    local playSeconds = v43.playSeconds;
    local playSeconds2 = p41.playSeconds;
    local v45 = (type(playSeconds2) ~= "number" or (playSeconds2 ~= playSeconds2 or not playSeconds2)) and 0 or playSeconds2;
    v43.playSeconds = playSeconds + math.max(0, v45);

    for i, v in pairs(p41.bySource or {}) do
        v43.bySource[i] = (v43.bySource[i] or 0) + v;
    end;

    for i in pairs(p41.once or {}) do
        v43.once[i] = true;
    end;

    if p42 then
        if p42.day > v43.daily.day then
            local v46 = {
                day = p42.day,
                killRp = p42.killRp,
                extractions = p42.extractions
            };
            local taskRp = p42.taskRp;
            v46.taskRp = (type(taskRp) ~= "number" or (taskRp ~= taskRp or not taskRp)) and 0 or taskRp;
            v43.daily = v46;

            return v43;
        end;

        if p42.day == v43.daily.day then
            v43.daily.killRp = math.max(v43.daily.killRp, p42.killRp);
            v43.daily.extractions = math.max(v43.daily.extractions, p42.extractions);
            local daily = v43.daily;
            local v47 = v43.daily.taskRp or 0;
            local taskRp = p42.taskRp;
            local v48 = (type(taskRp) ~= "number" or (taskRp ~= taskRp or not taskRp)) and 0 or taskRp;
            daily.taskRp = math.max(v47, v48);
        end;
    end;

    return v43;
end;

local u49 = {
    MIN_RP = 100,
    SHOW = 100,
    TRACK = 1000,
    REFRESH = 300
};

local function sortEntries(p50) -- Line: 224
    table.sort(p50, function(p51, p52) -- Line: 225
        if p51.rp == p52.rp then
            return p51.userId < p52.userId;
        end;

        return p51.rp > p52.rp;
    end);
end;

function u49.Merge(p53: any, p54: number, p55: number) -- Line: 233
    -- upvalues: u49 (copy)
    local v56 = {};

    for _, v in ipairs(p53) do
        if v.userId ~= p54 then
            table.insert(v56, {
                userId = v.userId,
                rp = v.rp
            });
        end;
    end;

    if type(p55) == "number" and u49.MIN_RP <= p55 then
        table.insert(v56, {
            userId = p54,
            rp = p55
        });
    end;

    table.sort(v56, function(p57, p58) -- Line: 225
        if p57.rp == p58.rp then
            return p57.userId < p58.userId;
        end;

        return p57.rp > p58.rp;
    end);

    while #v56 > u49.TRACK do
        table.remove(v56);
    end;

    return v56;
end;

function u49.Position(p59: any, p60: number) -- Line: 244
    for i, v in ipairs(p59) do
        if v.userId == p60 then
            return i;
        end;
    end;

    return nil;
end;

u1.Leaderboard = u49;

return u1;