-- Decompiled with Potassium's decompiler.

local TacticsRules = require(script.Parent:WaitForChild("TacticsRules"));
local u1 = {
    COVER = {
        Cautious = {
            cover = 0.7,
            exploit = 0,
            exploitPinned = 0
        },
        Balanced = {
            cover = 0.55,
            exploit = 0.25,
            exploitPinned = 0
        },
        Aggressive = {
            cover = 0.35,
            exploit = 0.6,
            exploitPinned = 0.35
        },
        Disciplined = {
            cover = 0.85,
            exploit = 0.15,
            exploitPinned = 0
        },
        Fanatic = {
            cover = 0.45,
            exploit = 0.5,
            exploitPinned = 0.3
        }
    },
    SUPPRESS = {
        Cautious = {
            chance = 0.2,
            bursts = 1,
            time = 0.8
        },
        Balanced = {
            chance = 0.45,
            bursts = 2,
            time = 1
        },
        Aggressive = {
            chance = 0.6,
            bursts = 2,
            time = 1
        },
        Disciplined = {
            chance = 0.75,
            bursts = 2,
            time = 1
        },
        Fanatic = {
            chance = 0.65,
            bursts = 3,
            time = 1.5
        }
    },
    OPPORTUNITY = {
        Cautious = {
            reload = 0.15,
            heal = 0.15,
            retreat = 0.1
        },
        Balanced = {
            reload = 0.5,
            heal = 0.5,
            retreat = 0.4
        },
        Aggressive = {
            reload = 1,
            heal = 1,
            retreat = 0.9
        },
        Disciplined = {
            reload = 0.8,
            heal = 0.8,
            retreat = 0.2
        },
        Fanatic = {
            reload = 1,
            heal = 1,
            retreat = 0.8
        }
    },
    ARCHETYPES = {
        Cautious = {
            push = 0.4,
            flank = 0.6,
            sprint = 0.5,
            mediumBold = 0.15,
            retreat = 1.3,
            flee = 1.4,
            sup = 1.15,
            coverHold = 1.3,
            reposition = 0.8,
            watch = 1.5,
            duration = 0.85,
            flankCooldown = 1.5,
            pushOdds = 1.25,
            pushMorale = 1.1
        },
        Balanced = {
            push = 1,
            flank = 1,
            sprint = 1,
            mediumBold = 0.35,
            retreat = 1,
            flee = 1,
            sup = 1,
            coverHold = 1,
            reposition = 1,
            watch = 1,
            duration = 1,
            flankCooldown = 1,
            pushOdds = 1,
            pushMorale = 1
        },
        Aggressive = {
            push = 1.6,
            flank = 1.4,
            sprint = 1.6,
            mediumBold = 0.5,
            retreat = 0.8,
            flee = 0.8,
            sup = 0.95,
            coverHold = 0.7,
            reposition = 1.2,
            watch = 0.6,
            duration = 1.15,
            flankCooldown = 0.7,
            pushOdds = 0.85,
            pushMorale = 0.75
        },
        Disciplined = {
            push = 0.7,
            flank = 0.8,
            sprint = 0.8,
            mediumBold = 0.4,
            retreat = 0.85,
            flee = 0.7,
            sup = 0.75,
            coverHold = 1.4,
            reposition = 0.6,
            watch = 1.2,
            duration = 1.1,
            flankCooldown = 1.3,
            pushOdds = 1.2,
            pushMorale = 1
        },
        Fanatic = {
            push = 1.5,
            flank = 1.2,
            sprint = 1.4,
            mediumBold = 0.8,
            retreat = 0.3,
            flee = 0,
            sup = 0.6,
            coverHold = 0.9,
            reposition = 1,
            watch = 0.7,
            duration = 1.4,
            flankCooldown = 0.8,
            pushOdds = 0.9,
            pushMorale = 0.75
        }
    },
    DEFAULT = "Balanced",
    ORDER = { "Cautious", "Balanced", "Aggressive", "Disciplined", "Fanatic" },
    RANK = {
        Rookie = {
            intentHold = 2.2,
            flankUnseen = 2,
            pushOdds = 1.6,
            reloadCover = 0.15,
            callout = 0.6,
            jitter = 0.25,
            coverRely = 0.6,
            supRely = 0.55,
            oppRely = 0.6
        },
        Experienced = {
            intentHold = 2.7,
            flankUnseen = 2.6,
            pushOdds = 1.8,
            reloadCover = 0.2,
            callout = 0.8,
            jitter = 0.2,
            coverRely = 0.8,
            supRely = 0.75,
            oppRely = 0.75
        },
        Professional = {
            intentHold = 3,
            flankUnseen = 3,
            pushOdds = 2,
            reloadCover = 0.25,
            callout = 0.9,
            jitter = 0.15,
            coverRely = 0.9,
            supRely = 0.9,
            oppRely = 0.9
        },
        Veteran = {
            intentHold = 3.4,
            flankUnseen = 3.4,
            pushOdds = 2.3,
            reloadCover = 0.28,
            callout = 1,
            jitter = 0.12,
            coverRely = 1,
            supRely = 1,
            oppRely = 1
        },
        Expert = {
            intentHold = 3.6,
            flankUnseen = 3.6,
            pushOdds = 2.5,
            reloadCover = 0.3,
            callout = 1,
            jitter = 0.1,
            coverRely = 1,
            supRely = 1,
            oppRely = 1
        }
    },
    DEFAULT_RANK = "Experienced",
    WEIGHTS = {
        Bandit = {
            Balanced = 35,
            Aggressive = 30,
            Cautious = 25,
            Disciplined = 10,
            Fanatic = 0
        },
        Loner = {
            Balanced = 40,
            Cautious = 35,
            Aggressive = 15,
            Disciplined = 10,
            Fanatic = 0
        },
        ClearSky = {
            Balanced = 40,
            Disciplined = 30,
            Cautious = 20,
            Aggressive = 10,
            Fanatic = 0
        },
        Military = {
            Disciplined = 45,
            Balanced = 35,
            Aggressive = 12,
            Cautious = 8,
            Fanatic = 0
        },
        Monolith = {
            Fanatic = 55,
            Disciplined = 30,
            Aggressive = 15,
            Cautious = 0,
            Balanced = 0
        }
    },
    DEFAULT_WEIGHTS = {
        Balanced = 50,
        Cautious = 20,
        Aggressive = 20,
        Disciplined = 10,
        Fanatic = 0
    },
    RANK_WEIGHT = {
        Rookie = {
            Cautious = 1.6,
            Disciplined = 0.4
        },
        Experienced = {},
        Professional = {
            Disciplined = 1.2,
            Cautious = 0.8
        },
        Veteran = {
            Disciplined = 1.7,
            Cautious = 0.5
        },
        Expert = {
            Disciplined = 2,
            Cautious = 0.35
        }
    },
    MIN_INTENT_HOLD = 1.5,
    MAX_WATCH_MULT = 2.2,
    MAX_DURATION_MULT = 1.6,
    MAX_COVER_HOLD_MULT = 1.6,
    MIN_REPOSITION_MULT = 0.4,
    MIN_RETREAT_GAP = 10,
    MIN_PUSH_MORALE = 40
};

function u1.Roll(p2, p3, p4, p5) -- Line: 141
    -- upvalues: u1 (copy)
    local v6 = p5 or math.random;
    local v7 = p4 and p4[p2 or ""] or (u1.WEIGHTS[p2 or ""] or u1.DEFAULT_WEIGHTS);
    local v8 = u1.RANK_WEIGHT[p3 or ""] or {};
    local v9 = {};
    local v10 = 0;

    for _, v in ipairs(u1.ORDER) do
        local math_max_ret = math.max(0, (v7[v] or 0) * (v8[v] or 1));
        v9[v] = math_max_ret;
        v10 = v10 + math_max_ret;
    end;

    if v10 <= 0 then
        return u1.DEFAULT;
    end;

    local v11 = v6() * v10;

    for _, v in ipairs(u1.ORDER) do
        v11 = v11 - v9[v];

        if v11 < 0 and v9[v] > 0 then
            return v;
        end;
    end;

    return u1.DEFAULT;
end;

function u1.Build(p12, p13, p14, u15) -- Line: 163
    -- upvalues: u1 (copy), TacticsRules (copy)
    local v16 = u1.ARCHETYPES[p14 or ""] or u1.ARCHETYPES[u1.DEFAULT];
    local v17 = u1.RANK[p13 or ""] or u1.RANK[u1.DEFAULT_RANK];
    local u18 = u15 and (v17.jitter or 0) or 0;

    local function vary(p19) -- Line: 167
        -- upvalues: u18 (copy), u15 (copy)
        if u18 == 0 then
            return p19;
        end;

        return p19 * (1 + (u15() * 2 - 1) * u18);
    end;

    local v20 = p12.Aggression or 0.5;
    local v21 = p12.Bravery or 70;
    local v22 = (p12.RetreatAt or 35) * v16.retreat;

    if u18 ~= 0 then
        v22 = v22 * (1 + (u15() * 2 - 1) * u18);
    end;

    local math_max_ret = math.max(0, v21 - u1.MIN_RETREAT_GAP);
    local math_clamp_ret = math.clamp(v22, 0, math_max_ret);
    local v23 = (p12.FleeAt or 15) * v16.flee;

    if u18 ~= 0 then
        v23 = v23 * (1 + (u15() * 2 - 1) * u18);
    end;

    local math_clamp_ret2 = math.clamp(v23, 0, math_clamp_ret);
    local v24 = {
        personality = u1.ARCHETYPES[p14 or ""] and p14 and p14 or u1.DEFAULT,
        rank = u1.RANK[p13 or ""] and p13 and p13 or u1.DEFAULT_RANK
    };
    local v25 = v20 * v16.push;

    if u18 ~= 0 then
        v25 = v25 * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.pushWill = math.clamp(v25, 0, 1);
    local v26 = v20 * v16.flank;

    if u18 ~= 0 then
        v26 = v26 * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.flankWill = math.clamp(v26, 0, 1);
    local v27 = v20 * v16.sprint;

    if u18 ~= 0 then
        v27 = v27 * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.sprintWill = math.clamp(v27, 0, 1);
    local mediumBold = v16.mediumBold;

    if u18 ~= 0 then
        mediumBold = mediumBold * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.mediumBold = math.clamp(mediumBold, 0, 1);
    v24.retreatAt = math_clamp_ret;
    v24.fleeAt = math_clamp_ret2;
    local sup = v16.sup;

    if u18 ~= 0 then
        sup = sup * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.supMult = sup;
    local coverHold = v16.coverHold;

    if u18 ~= 0 then
        coverHold = coverHold * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.coverHoldMult = math.min(coverHold, u1.MAX_COVER_HOLD_MULT);
    local reposition = v16.reposition;

    if u18 ~= 0 then
        reposition = reposition * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.repositionMult = math.max(reposition, u1.MIN_REPOSITION_MULT);
    local watch = v16.watch;

    if u18 ~= 0 then
        watch = watch * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.watchMult = math.min(watch, u1.MAX_WATCH_MULT);
    local duration = v16.duration;

    if u18 ~= 0 then
        duration = duration * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.durationMult = math.min(duration, u1.MAX_DURATION_MULT);
    local v28 = TacticsRules.FLANK_COOLDOWN * v16.flankCooldown;

    if u18 ~= 0 then
        v28 = v28 * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.flankCooldown = v28;
    local intentHold = v17.intentHold;

    if u18 ~= 0 then
        intentHold = intentHold * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.intentHold = math.max(intentHold, u1.MIN_INTENT_HOLD);
    local flankUnseen = v17.flankUnseen;

    if u18 ~= 0 then
        flankUnseen = flankUnseen * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.flankUnseen = flankUnseen;
    local v29 = v17.pushOdds * v16.pushOdds;

    if u18 ~= 0 then
        v29 = v29 * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.pushOdds = v29;
    local v30 = TacticsRules.PUSH_MORALE * (v16.pushMorale or 1);

    if u18 ~= 0 then
        v30 = v30 * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.pushMorale = math.max(v30, u1.MIN_PUSH_MORALE);
    local reloadCover = v17.reloadCover;

    if u18 ~= 0 then
        reloadCover = reloadCover * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.reloadCoverFrac = math.clamp(reloadCover, 0.05, 0.5);
    v24.calloutChance = math.clamp(v17.callout, 0, 1);
    local v31 = (u1.COVER[p14 or ""] or u1.COVER[u1.DEFAULT]).cover * (v17.coverRely or 1);

    if u18 ~= 0 then
        v31 = v31 * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.coverChance = math.clamp(v31, 0, 1);
    v24.exploit = (u1.COVER[p14 or ""] or u1.COVER[u1.DEFAULT]).exploit;
    v24.exploitPinned = (u1.COVER[p14 or ""] or u1.COVER[u1.DEFAULT]).exploitPinned;
    local v32 = (u1.SUPPRESS[p14 or ""] or u1.SUPPRESS[u1.DEFAULT]).chance * (v17.supRely or 1);

    if u18 ~= 0 then
        v32 = v32 * (1 + (u15() * 2 - 1) * u18);
    end;

    v24.suppressChance = math.clamp(v32, 0, 1);
    v24.suppressBursts = (u1.SUPPRESS[p14 or ""] or u1.SUPPRESS[u1.DEFAULT]).bursts;
    v24.suppressTimeMult = (u1.SUPPRESS[p14 or ""] or u1.SUPPRESS[u1.DEFAULT]).time;
    v24.oppResponse = u1.OPPORTUNITY[p14 or ""] or u1.OPPORTUNITY[u1.DEFAULT];
    v24.oppRely = v17.oppRely or 0.9;

    return v24;
end;

local u33 = nil;

local function config() -- Line: 208
    -- upvalues: u33 (ref)
    if u33 == nil then
        local success, result = pcall(function() -- Line: 210
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if not (success and (type(result) == "table" and result)) then
            result = false;
        end;

        u33 = result;
    end;

    return u33 or nil;
end;

function u1.ConfigWeights() -- Line: 219
    -- upvalues: u33 (ref)
    if u33 == nil then
        local success, result = pcall(function() -- Line: 210
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if not (success and (type(result) == "table" and result)) then
            result = false;
        end;

        u33 = result;
    end;

    local v34 = u33 or nil;

    return v34 and (type(v34.PersonalityWeights) == "table" and v34.PersonalityWeights) or nil;
end;

local u35 = nil;

function u1.Enabled() -- Line: 226
    -- upvalues: u35 (ref), u33 (ref)
    if u35 == nil then
        if u33 == nil then
            local success, result = pcall(function() -- Line: 210
                return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
            end);

            if not (success and (type(result) == "table" and result)) then
                result = false;
            end;

            u33 = result;
        end;

        local v36 = u33 or nil;
        local v37;

        if v36 == nil or type(v36.AI) ~= "table" then
            v37 = false;
        else
            v37 = v36.AI.Personality == true;
        end;

        u35 = v37;
    end;

    return u35;
end;

function u1.SetEnabled(p38) -- Line: 234
    -- upvalues: u35 (ref)
    u35 = p38 == true;
end;

return u1;