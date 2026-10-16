-- Decompiled with Potassium's decompiler.

local NpcKnowledge = require(script.Parent:WaitForChild("NpcKnowledge"));
local u1 = {
    FULL_AGE = 1.5,
    MAX_AGE = 10,
    FRESH_FLOOR = 0.5,
    STOP_AGE = 12,
    REPEAT_GAP = 2.5,
    SQUAD_MAX_ERROR = 8,
    MAX_TIME = 3,
    MAX_TIME_CAP = 5,
    ROUNDS_PER_BURST = 4,
    SPREAD_MULT = 2,
    COVER_BONUS = 1.6,
    MAX_CHANCE = 0.95,
    DEFAULT_CHANCE = 0.45,
    DEFAULT_BURSTS = 2,
    AIM_LIFT = Vector3.new(0, 0.5, 0),
    OFFSETS = { 3, 4.5, 6 },
    TOP_LIFT = 2.5,
    MAX_OFFSET = 6,
    MAX_RAYS = 8,
    DELAY = {
        Rookie = 0.6,
        Experienced = 0.4,
        Professional = 0.3,
        Veteran = 0.2,
        Expert = 0.15
    },
    DEFAULT_DELAY = 0.35
};

function u1.Source(p2, p3) -- Line: 67
    -- upvalues: u1 (copy)
    if not p2 then
        return false, "unknown";
    end;

    if p2.visible then
        return false, "visible";
    end;

    if not (p2.knownAt and p2.knownPos) then
        return false, "unknown";
    end;

    if p3 - p2.knownAt > u1.MAX_AGE then
        return false, "old";
    end;

    if p2.knownSource == "seen" then
        return true, "seen";
    end;

    if p2.knownSource == "squad" and (p2.squadKind == "seen" and (p2.knownError or 0) <= u1.SQUAD_MAX_ERROR) then
        return true, "squad";
    end;

    return false, tostring(p2.knownSource);
end;

function u1.Chance(p4, p5, p6) -- Line: 81
    -- upvalues: u1 (copy)
    local v7 = p4 and p4.suppressChance or u1.DEFAULT_CHANCE;
    local v8;

    if u1.FULL_AGE < p5 then
        local math_clamp_ret = math.clamp((p5 - u1.FULL_AGE) / (u1.MAX_AGE - u1.FULL_AGE), 0, 1);
        v8 = 1 - (1 - u1.FRESH_FLOOR) * math_clamp_ret;
    else
        v8 = 1;
    end;

    return math.min(v7 * v8 * (p6 and u1.COVER_BONUS or 1), u1.MAX_CHANCE);
end;

function u1.PickPoint(u9, p10, u11) -- Line: 95
    -- upvalues: u1 (copy)
    local u12 = 0;

    local function try(p13) -- Line: 97
        -- upvalues: u12 (ref), u11 (copy), u9 (copy)
        u12 = u12 + 1;

        return u11(u9, p13);
    end;

    local v14 = p10 + u1.AIM_LIFT;
    u12 = u12 + 1;

    if u11(u9, v14) then
        return v14, u12;
    end;

    local Vector3_new_ret = Vector3.new(p10.X - u9.X, 0, p10.Z - u9.Z);
    local v15 = Vector3_new_ret.Magnitude > 0.001 and Vector3.new(-Vector3_new_ret.Z, 0, Vector3_new_ret.X).Unit or Vector3.new(1, 0, 0);
    local v16 = {};

    for i, v in ipairs(u1.OFFSETS) do
        if v <= u1.MAX_OFFSET then
            table.insert(v16, v14 + v15 * v);
            table.insert(v16, v14 - v15 * v);
        end;

        if i == 1 then
            local v17 = p10 + Vector3.new(0, u1.TOP_LIFT, 0);
            table.insert(v16, v17);
        end;
    end;

    for _, v in ipairs(v16) do
        if u1.MAX_RAYS <= u12 then
            break;
        end;

        u12 = u12 + 1;

        if u11(u9, v) then
            return v, u12;
        end;
    end;

    return nil, u12;
end;

function u1.MayDecide(p18, p19, p20, p21) -- Line: 122
    -- upvalues: u1 (copy)
    return p18 ~= p20 and true or p21 - p19 >= u1.REPEAT_GAP;
end;

function u1.MaxShots(p22) -- Line: 127
    -- upvalues: u1 (copy)
    return (p22 or u1.DEFAULT_BURSTS) * u1.ROUNDS_PER_BURST;
end;

function u1.ShouldStop(p23, p24) -- Line: 133
    -- upvalues: u1 (copy)
    return p24.hasLOS and "reacquired" or ((p24.age == nil or p24.age > u1.STOP_AGE) and "stale" or ((p24.tier or 0) >= 3 and "heavy" or (p24.reloading and "reload" or (p24.magEmpty and "ammo" or (p24.moving and "moving" or ((p24.tactic == "Retreat" or (p24.tactic == "Flee" or p24.tactic == "CoverReload")) and "retreat" or (p23.maxShots and (p23.shots or 0) >= p23.maxShots and "rounds" or (p24.now - p23.start > p23.maxTime and "time" or nil))))))));
end;

u1.stats = {
    episodes = 0,
    refusedSource = 0,
    refusedRoll = 0,
    refusedSlot = 0,
    refusedPoint = 0,
    shots = 0,
    ends = {}
};
u1.trace = nil;
local u25 = nil;

function u1.Enabled() -- Line: 155
    -- upvalues: u25 (ref), NpcKnowledge (copy)
    if u25 == nil then
        local success, result = pcall(function() -- Line: 157
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.SuppressFire == true;
            else
                success = false;
            end;
        end;

        u25 = success;
    end;

    local v26 = u25 and NpcKnowledge.Enabled();

    return v26;
end;

function u1.SetEnabled(p27) -- Line: 165
    -- upvalues: u25 (ref)
    u25 = p27 == true;
end;

return u1;