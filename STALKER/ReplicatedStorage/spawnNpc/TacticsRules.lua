-- Decompiled with Potassium's decompiler.

local u1 = {
    INTENT_MIN_HOLD = 3,
    RELOAD_COVER_FRACTION = 0.25,
    PUSH_MORALE = 70,
    PUSH_ODDS = 2,
    TARGET_HURT = 0.5,
    PUSH_MIN_GAP = 8,
    FLANK_UNSEEN = 3,
    FLANK_COOLDOWN = 15,
    MEDIUM_BOLD_MULT = 0.35,
    DEFAULTS = {
        Bravery = 70,
        RetreatAt = 35,
        FleeAt = 15,
        Aggression = 0.5,
        SprintSpeed = 14
    },
    MOVE_MODE = {
        Flee = "Flee",
        Retreat = "Retreat",
        CoverReload = "CoverReload",
        Reposition = "Hold",
        Flank = "Flank",
        Push = "Push"
    },
    MATE_MOVING_DAMP = 0.25,
    OPP_GAIN = 1,
    OPP_PUSH_GATE = 0.5
};

local function want(p2) -- Line: 80
    -- upvalues: u1 (copy)
    if p2.fleeAt > 0 and (p2.morale < p2.fleeAt and not p2.fightBack) then
        return "Flee";
    end;

    if p2.morale < p2.retreatAt and not p2.retreated then
        return "Retreat";
    end;

    if p2.ammoFrac <= (p2.reloadCoverFrac or u1.RELOAD_COVER_FRACTION) and not p2.inCover then
        return "CoverReload";
    end;

    local v3 = p2.suppression or 0;

    if v3 >= 3 and not p2.inCover then
        return "Reposition";
    end;

    if p2.inCover and not p2.coverValid or (not p2.inCover and p2.underFire or p2.repositionDue and not (p2.covering or v3 >= 3 and p2.inCover)) then
        return "Reposition";
    end;

    if p2.covering then
        return "Hold";
    end;

    if p2.vsMutant then
        return "Hold";
    end;

    local v4 = v3 >= 3 and 0 or (v3 >= 2 and (p2.mediumBold or (u1.MEDIUM_BOLD_MULT or 1)) or 1);

    if v4 > 0 then
        if p2.matePressure then
            v4 = v4 * (1 + (p2.exploit or 0));
        end;

        if p2.matePinned then
            v4 = v4 * (1 + (p2.exploitPinned or 0));
        end;

        if p2.mateMoving then
            v4 = v4 * u1.MATE_MOVING_DAMP;
        end;

        if p2.opportunity then
            v4 = v4 * (1 + u1.OPP_GAIN * p2.opportunity);
        end;
    end;

    return p2.boldness < (p2.flankWill or p2.aggression) * v4 * (p2.weaponFlank or 1) and not p2.hasLOS and (p2.unseenFor >= (p2.flankUnseen or u1.FLANK_UNSEEN) and (p2.flankReady and p2.flankFree)) and "Flank" or (p2.boldness < (p2.pushWill or p2.aggression) * v4 * (p2.weaponPush or 1) and p2.hasLOS and (p2.morale >= (p2.pushMorale or u1.PUSH_MORALE) and (p2.targetHealthFrac < u1.TARGET_HURT or (p2.odds >= (p2.pushOdds or u1.PUSH_ODDS) or (p2.opportunity or 0) >= u1.OPP_PUSH_GATE))) and p2.dist > p2.tooClose + u1.PUSH_MIN_GAP and "Push" or "Hold");
end;

function u1.Pick(p5) -- Line: 123
    -- upvalues: want (copy), u1 (copy)
    local v6 = want(p5);
    local v7;

    if (p5.suppression or 0) >= 3 then
        if p5.current == "Push" or p5.current == "Flank" then
            v7 = true;
        else
            v7 = v6 == "Reposition" and not p5.inCover or p5.vsMutant and (p5.current == "Push" and true or p5.current == "Flank");
        end;
    else
        v7 = p5.vsMutant and (p5.current == "Push" and true or p5.current == "Flank");
    end;

    if v6 == p5.current or (v6 == "Flee" or (v6 == "Retreat" or v7)) or p5.now - p5.currentSince >= (p5.intentHold or u1.INTENT_MIN_HOLD) then
        return v6;
    end;

    return p5.current;
end;

return u1;