-- Decompiled with Potassium's decompiler.

local NpcKnowledge = require(script.Parent:WaitForChild("NpcKnowledge"));
local u1 = {
    RELOAD_WINDOW = 2.5,
    RELOAD_HEAR_RANGE = 25,
    HEAL_WINDOW = 1.5,
    HEAL_HEAR_RANGE = 20,
    RETREAT_SPEED = 3,
    RETREAT_MIN_DT = 0.4,
    QUALITY = {
        reload = 1,
        heal = 1,
        retreat = 0.6
    },
    ASSUMED_HP = 100,
    HURT_HOLD = 10,
    HURT_DECAY = 3
};

function u1.ReloadPerceived(p2, p3, p4, p5) -- Line: 39
    -- upvalues: u1 (copy)
    if type(p3) ~= "number" or (p2 - p3 > u1.RELOAD_WINDOW or p2 < p3 - 0.1) then
        return false;
    end;

    if not p4 then
        if p5 == nil then
            p4 = false;
        else
            p4 = p5 <= u1.RELOAD_HEAR_RANGE;
        end;
    end;

    return p4;
end;

function u1.HealPerceived(p6, p7, p8, p9, p10) -- Line: 46
    -- upvalues: u1 (copy)
    if type(p7) ~= "number" or p7 + u1.HEAL_WINDOW < p6 then
        return false;
    end;

    if not p8 then
        if p10 == true and p9 ~= nil then
            p8 = p9 <= u1.HEAL_HEAR_RANGE;
        else
            p8 = false;
        end;
    end;

    return p8;
end;

function u1.Retreating(p11, p12, p13, p14, p15) -- Line: 52
    -- upvalues: u1 (copy)
    if not (p11 and (p13 and (p12 and (p14 and p14 - p12 >= u1.RETREAT_MIN_DT)))) then
        return false;
    end;

    local Magnitude = Vector3.new(p11.X - p15.X, 0, p11.Z - p15.Z).Magnitude;

    return (Vector3.new(p13.X - p15.X, 0, p13.Z - p15.Z).Magnitude - Magnitude) / (p14 - p12) >= u1.RETREAT_SPEED;
end;

function u1.NewHealthWatch() -- Line: 62
    return {
        seen = 0,
        last = nil,
        hitAt = (-1 / 0)
    };
end;

local function current(p16, p17) -- Line: 65
    -- upvalues: u1 (copy)
    local v18 = math.max(0, p17 - p16.hitAt - u1.HURT_HOLD) * u1.HURT_DECAY;

    return math.max(0, p16.seen - v18);
end;

function u1.Observe(p19, p20, p21, p22) -- Line: 69
    -- upvalues: u1 (copy)
    if not p21 then
        p19.last = nil;

        return;
    end;

    if p19.last and p20 ~= p19.last then
        local v23 = math.max(0, p22 - p19.hitAt - u1.HURT_HOLD) * u1.HURT_DECAY;
        local math_max_ret = math.max(0, p19.seen - v23);
        local v24 = p19.last - p20;
        p19.seen = math.clamp(math_max_ret + v24, 0, u1.ASSUMED_HP);

        if v24 > 0 then
            p19.hitAt = p22;
        end;
    end;

    p19.last = p20;
end;

function u1.HurtFrac(p25, p26) -- Line: 82
    -- upvalues: u1 (copy)
    local v27 = math.max(0, p26 - p25.hitAt - u1.HURT_HOLD) * u1.HURT_DECAY;

    return 1 - math.max(0, p25.seen - v27) / u1.ASSUMED_HP;
end;

u1.DEFAULT_RESPONSE = {
    reload = 0.5,
    heal = 0.5,
    retreat = 0.4
};

function u1.Strength(p28, p29) -- Line: 89
    -- upvalues: u1 (copy)
    local v30 = p29 and p29.oppResponse or u1.DEFAULT_RESPONSE;
    local v31 = p29 and p29.oppRely or 0.9;
    local v32 = 0;

    for i, v in pairs(p28) do
        if v then
            v32 = math.max(v32, (u1.QUALITY[i] or 0) * (v30[i] or 0));
        end;
    end;

    return math.clamp(v32 * v31, 0, 1);
end;

local u33 = nil;

function u1.Enabled() -- Line: 101
    -- upvalues: u33 (ref), NpcKnowledge (copy)
    if u33 == nil then
        local success, result = pcall(function() -- Line: 103
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.Opportunity == true;
            else
                success = false;
            end;
        end;

        u33 = success;
    end;

    local v34 = u33 and NpcKnowledge.Enabled();

    return v34;
end;

function u1.SetEnabled(p35) -- Line: 111
    -- upvalues: u33 (ref)
    u33 = p35 == true;
end;

return u1;