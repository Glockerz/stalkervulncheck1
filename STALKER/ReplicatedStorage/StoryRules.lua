-- Decompiled with Potassium's decompiler.

local u5 = {
    INTRO_TASK_ID = "introduction",
    INTRO_ADVANCE = 25000,
    GUIDE_PASSAGE_FEE = 55000,
    CLEAR_SKY_ZONE = "Clear Sky Hidden Base (Safezone)",
    CLEAR_SKY_REP = 50,
    DEFAULT_GIVER = "Crow",
    ACCESS_ATTR = "SwampsAccess",
    FOUND_ATTR = "ClearSkyFound",
    TRANSITION_SPAWN = "TransitionSpawn",
    LOCKED_NOTICE = "The road to the Swamps isn\'t open to you yet. Don\'t want to pay the Guide? Ask Crow, he might tell you something useful.",

    PadAllowed = function(p1, p2, p3) -- Line: 50, Name: PadAllowed
        local v4;

        if p1 == true then
            v4 = p2 == true and true or p3 == true;
        else
            v4 = false;
        end;

        return v4;
    end
};

function u5.GiverOf(p6) -- Line: 54
    -- upvalues: u5 (copy)
    return type(p6) == "table" and (type(p6.giver) == "string" and p6.giver) or u5.DEFAULT_GIVER;
end;

function u5.GiverMatches(p7, p8) -- Line: 58
    -- upvalues: u5 (copy)
    local v9;

    if type(p8) == "string" then
        v9 = p8 == u5.GiverOf(p7);
    else
        v9 = false;
    end;

    return v9;
end;

function u5.TurnInHere(p10, p11) -- Line: 64
    if type(p10) ~= "table" or type(p11) ~= "string" then
        return false;
    end;

    local active = p10.active;

    if type(active) == "table" and active.stageKind == "turn_in" then
        return (active.turnInGiver or p10.giver) == p11;
    end;

    return false;
end;

function u5.StoryRole(p12, p13) -- Line: 73
    -- upvalues: u5 (copy)
    if type(p12) == "table" and type(p13) == "string" then
        return p12.giver == p13 and "ladder" or (u5.TurnInHere(p12, p13) and "handin" or nil);
    end;

    return nil;
end;

u5.SWAMPS_ADVICE = {
    notyet = "The Swamps? You? Not yet. I don\'t send people down there blind. Keep taking my contracts.",
    notyetCount = "You\'re at %d of %d. I\'ll have something proper for you after that.",
    offer = "Start with what I\'ve got for you now. %s. Everything about the Swamps runs through it.",
    active = "Finish %s first. Then we\'ll talk.",
    intro_offer = "Funny you should ask. Sit down.",
    intro_active = "You\'ve got my PDA. Get it to Solokov.",
    known = "You already know the path. Don\'t waste my time."
};

function u5.SwampsAdvice(p14, p15) -- Line: 97
    -- upvalues: u5 (copy)
    if type(p14) ~= "table" then
        return {
            kind = "notyet"
        };
    end;

    local v16;

    if type(p14.active) == "table" then
        v16 = p14.active or nil;
    else
        v16 = nil;
    end;

    if v16 and v16.id == u5.INTRO_TASK_ID then
        return {
            kind = "intro_active"
        };
    end;

    if p15 == true then
        return {
            kind = "known"
        };
    end;

    if v16 then
        return {
            kind = "active",
            title = v16.title
        };
    end;

    local v17 = type(p14.available) == "table" and (p14.available or {}) or {};

    for _, v in ipairs(v17) do
        if v.id == u5.INTRO_TASK_ID then
            return {
                kind = "intro_offer"
            };
        end;
    end;

    return v17[1] and {
        kind = "offer",
        title = v17[1].title
    } or {
        kind = "notyet",
        done = p14.sideDone,
        need = p14.nextRequirement
    };
end;

u5.DEPLOY_CLEARSKY = "clearsky";
u5.RIDE_ATTR = "_SwampsRide";
u5.RIDE_OWNER_GRACE = 30;
u5.DEPLOY_NEEDS_BASE = "Reach Clear Sky Base to deploy here.";
u5.DEPLOY_NEEDS_TUTORIAL = "%s hasn\'t finished Crow\'s tutorial.";

function u5.LobbyDeployBlocker(p18: any, p19: table) -- Line: 122
    -- upvalues: u5 (copy)
    if p18 ~= true then
        return u5.DEPLOY_NEEDS_BASE;
    end;

    for _, v in ipairs(p19 or {}) do
        if type(v) ~= "table" or v.tutorial ~= true then
            return u5.DEPLOY_NEEDS_TUTORIAL:format(type(v) == "table" and (tostring(v.name) or "Someone") or "Someone");
        end;
    end;

    return nil;
end;

function u5.RespawnPool(p20, p21, p22) -- Line: 134
    return p20 == true and "base" or (p21 == true and p22 == true and "base" or "transition");
end;

function u5.FormatRoubles(p23: number) -- Line: 140
    local math_floor_ret = math.floor(p23);
    local v24 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse();

    if v24:sub(1, 1) == "," then
        v24 = v24:sub(2);
    end;

    return v24;
end;

return u5;