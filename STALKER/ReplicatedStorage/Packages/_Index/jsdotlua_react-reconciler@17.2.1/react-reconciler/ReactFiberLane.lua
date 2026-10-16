-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("ReactInternalTypes"));
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local v1 = require(script.Parent:WaitForChild("ReactFiberSchedulerPriorities.roblox"));
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local ImmediatePriority = v1.ImmediatePriority;
local UserBlockingPriority = v1.UserBlockingPriority;
local NormalPriority = v1.NormalPriority;
local LowPriority = v1.LowPriority;
local IdlePriority = v1.IdlePriority;
local NoPriority = v1.NoPriority;
local v2 = {
    SyncLanePriority = 15,
    SyncBatchedLanePriority = 14,
    InputDiscreteLanePriority = 12,
    InputContinuousLanePriority = 10,
    DefaultLanePriority = 8,
    TransitionPriority = 6,
    NoLanePriority = 0,
    NoLanes = 0,
    NoLane = 0,
    SyncLane = 1,
    SyncBatchedLane = 2,
    InputDiscreteHydrationLane = 4,
    DefaultHydrationLane = 256,
    DefaultLanes = 3584,
    RetryLanes = 62914560,
    SomeRetryLane = 33554432,
    SelectiveHydrationLane = 67108864,
    IdleHydrationLane = 134217728,
    OffscreenLane = 1073741824,
    NoTimestamp = -1
};
local NoLanePriority = v2.NoLanePriority;

function v2.getCurrentUpdateLanePriority() -- Line: 141
    -- upvalues: NoLanePriority (ref)
    return NoLanePriority;
end;

function v2.setCurrentUpdateLanePriority(p3) -- Line: 145
    -- upvalues: NoLanePriority (ref)
    NoLanePriority = p3;
end;

local DefaultLanePriority = v2.DefaultLanePriority;

local function getHighestPriorityLanes(p4) -- Line: 153
    -- upvalues: DefaultLanePriority (ref), console (copy)
    if bit32.band(1, p4) ~= 0 then
        DefaultLanePriority = 15;

        return 1;
    end;

    if bit32.band(2, p4) ~= 0 then
        DefaultLanePriority = 14;

        return 2;
    end;

    if bit32.band(4, p4) ~= 0 then
        DefaultLanePriority = 13;

        return 4;
    end;

    local bit32_band_ret = bit32.band(24, p4);

    if bit32_band_ret ~= 0 then
        DefaultLanePriority = 12;

        return bit32_band_ret;
    end;

    if bit32.band(p4, 32) ~= 0 then
        DefaultLanePriority = 11;

        return 32;
    end;

    local bit32_band_ret2 = bit32.band(192, p4);

    if bit32_band_ret2 ~= 0 then
        DefaultLanePriority = 10;

        return bit32_band_ret2;
    end;

    if bit32.band(p4, 256) ~= 0 then
        DefaultLanePriority = 9;

        return 256;
    end;

    local bit32_band_ret3 = bit32.band(3584, p4);

    if bit32_band_ret3 ~= 0 then
        DefaultLanePriority = 8;

        return bit32_band_ret3;
    end;

    if bit32.band(p4, 4096) ~= 0 then
        DefaultLanePriority = 7;

        return 4096;
    end;

    local bit32_band_ret4 = bit32.band(4186112, p4);

    if bit32_band_ret4 ~= 0 then
        DefaultLanePriority = 6;

        return bit32_band_ret4;
    end;

    local bit32_band_ret5 = bit32.band(62914560, p4);

    if bit32_band_ret5 ~= 0 then
        DefaultLanePriority = 5;

        return bit32_band_ret5;
    end;

    if bit32.band(p4, 67108864) ~= 0 then
        DefaultLanePriority = 4;

        return 67108864;
    end;

    if bit32.band(p4, 134217728) ~= 0 then
        DefaultLanePriority = 3;

        return 134217728;
    end;

    local bit32_band_ret6 = bit32.band(805306368, p4);

    if bit32_band_ret6 ~= 0 then
        DefaultLanePriority = 2;

        return bit32_band_ret6;
    end;

    if bit32.band(1073741824, p4) ~= 0 then
        DefaultLanePriority = 1;

        return 1073741824;
    end;

    if _G.__DEV__ then
        console.error("Should have found matching lanes. This is a bug in React.");
    end;

    DefaultLanePriority = 8;

    return p4;
end;

function v2.schedulerPriorityToLanePriority(p5) -- Line: 228
    -- upvalues: ImmediatePriority (copy), UserBlockingPriority (copy), NormalPriority (copy), LowPriority (copy), IdlePriority (copy)
    return p5 == ImmediatePriority and 15 or (p5 == UserBlockingPriority and 10 or ((p5 == NormalPriority or p5 == LowPriority) and 8 or (p5 == IdlePriority and 2 or 0)));
end;

function v2.lanePriorityToSchedulerPriority(p6) -- Line: 249
    -- upvalues: ImmediatePriority (copy), UserBlockingPriority (copy), NormalPriority (copy), IdlePriority (copy), NoPriority (copy), invariant (copy)
    if p6 == 15 or p6 == 14 then
        return ImmediatePriority;
    end;

    if p6 == 13 or (p6 == 12 or (p6 == 11 or p6 == 10)) then
        return UserBlockingPriority;
    end;

    if p6 == 9 or (p6 == 8 or (p6 == 7 or (p6 == 6 or (p6 == 4 or p6 == 5)))) then
        return NormalPriority;
    end;

    if p6 == 3 or (p6 == 2 or p6 == 1) then
        return IdlePriority;
    end;

    if p6 == 0 then
        return NoPriority;
    end;

    invariant(false, "Invalid update priority: %s. This is a bug in React.", p6);
    error("unreachable");
end;

local u7 = nil;
local u8 = nil;

function v2.getNextLanes(p9, p10) -- Line: 293
    -- upvalues: DefaultLanePriority (ref), getHighestPriorityLanes (copy), u8 (ref), u7 (ref)
    local pendingLanes = p9.pendingLanes;

    if pendingLanes == 0 then
        DefaultLanePriority = 0;

        return 0;
    end;

    local v11 = 0;
    local v12 = 0;
    local expiredLanes = p9.expiredLanes;
    local suspendedLanes = p9.suspendedLanes;
    local pingedLanes = p9.pingedLanes;

    if expiredLanes == 0 then
        local bit32_band_ret = bit32.band(pendingLanes, 134217727);

        if bit32_band_ret == 0 then
            local bit32_bnot_ret = bit32.bnot(suspendedLanes);
            local bit32_band_ret2 = bit32.band(pendingLanes, bit32_bnot_ret);

            if bit32_band_ret2 == 0 then
                if pingedLanes ~= 0 then
                    v11 = getHighestPriorityLanes(pingedLanes);
                    v12 = DefaultLanePriority;
                end;
            else
                v11 = getHighestPriorityLanes(bit32_band_ret2);
                v12 = DefaultLanePriority;
            end;
        else
            local bit32_bnot_ret = bit32.bnot(suspendedLanes);
            local bit32_band_ret2 = bit32.band(bit32_band_ret, bit32_bnot_ret);

            if bit32_band_ret2 == 0 then
                local bit32_band_ret3 = bit32.band(bit32_band_ret, pingedLanes);

                if bit32_band_ret3 ~= 0 then
                    v11 = getHighestPriorityLanes(bit32_band_ret3);
                    v12 = DefaultLanePriority;
                end;
            else
                v11 = getHighestPriorityLanes(bit32_band_ret2);
                v12 = DefaultLanePriority;
            end;
        end;
    else
        DefaultLanePriority = 15;
        v11 = expiredLanes;
        v12 = 15;
    end;

    if v11 == 0 then
        return 0;
    end;

    local v13 = u8(v11);
    local v14 = bit32.lshift(v13, 1) - 1;
    local bit32_band_ret = bit32.band(pendingLanes, v14);

    if p10 ~= 0 and (p10 ~= bit32_band_ret and bit32.band(p10, suspendedLanes) == 0) then
        getHighestPriorityLanes(p10);

        if v12 <= DefaultLanePriority then
            return p10;
        end;

        DefaultLanePriority = v12;
    end;

    local entangledLanes = p9.entangledLanes;

    if entangledLanes ~= 0 then
        local entanglements = p9.entanglements;
        local bit32_band_ret2 = bit32.band(bit32_band_ret, entangledLanes);

        while bit32_band_ret2 > 0 do
            local v15 = u7(bit32_band_ret2);
            local bit32_lshift_ret = bit32.lshift(1, v15);
            bit32_band_ret = bit32.bor(bit32_band_ret, entanglements[v15]);
            local bit32_bnot_ret = bit32.bnot(bit32_lshift_ret);
            bit32_band_ret2 = bit32.band(bit32_band_ret2, bit32_bnot_ret);
        end;
    end;

    return bit32_band_ret;
end;

function v2.getMostRecentEventTime(p16, p17) -- Line: 412
    -- upvalues: u7 (ref)
    local eventTimes = p16.eventTimes;
    local v18 = -1;

    while p17 > 0 do
        local v19 = u7(p17);
        local bit32_lshift_ret = bit32.lshift(1, v19);
        local v20 = eventTimes[v19];

        if v18 >= v20 then
            v20 = v18;
        end;

        local bit32_bnot_ret = bit32.bnot(bit32_lshift_ret);
        p17 = bit32.band(p17, bit32_bnot_ret);
        v18 = v20;
    end;

    return v18;
end;

function v2.computeExpirationTime(p21: any, p22: number) -- Line: 432
    -- upvalues: getHighestPriorityLanes (copy), DefaultLanePriority (ref)
    getHighestPriorityLanes(p21);
    local v23 = DefaultLanePriority;

    if v23 >= 10 then
        return p22 + 250;
    end;

    return v23 < 6 and -1 or p22 + 5000;
end;

function v2.markStarvedLanesAsExpired(p24: any, p25: number) -- Line: 462
    -- upvalues: u7 (ref), getHighestPriorityLanes (copy), DefaultLanePriority (ref)
    local pendingLanes = p24.pendingLanes;
    local suspendedLanes = p24.suspendedLanes;
    local pingedLanes = p24.pingedLanes;
    local expirationTimes = p24.expirationTimes;

    while pendingLanes > 0 do
        local v26 = u7(pendingLanes);
        local bit32_lshift_ret = bit32.lshift(1, v26);
        local v27 = expirationTimes[v26];

        if v27 == -1 then
            if bit32.band(bit32_lshift_ret, suspendedLanes) == 0 or bit32.band(bit32_lshift_ret, pingedLanes) ~= 0 then
                getHighestPriorityLanes(bit32_lshift_ret);
                local v28 = DefaultLanePriority;
                local v29;

                if v28 >= 10 then
                    v29 = p25 + 250;
                else
                    v29 = v28 < 6 and -1 or p25 + 5000;
                end;

                expirationTimes[v26] = v29;
            end;
        elseif v27 <= p25 then
            p24.expiredLanes = bit32.bor(p24.expiredLanes, bit32_lshift_ret);
        end;

        local bit32_bnot_ret = bit32.bnot(bit32_lshift_ret);
        pendingLanes = bit32.band(pendingLanes, bit32_bnot_ret);
    end;
end;

function v2.getHighestPriorityPendingLanes(p30) -- Line: 504
    -- upvalues: getHighestPriorityLanes (copy)
    return getHighestPriorityLanes(p30.pendingLanes);
end;

function v2.getLanesToRetrySynchronouslyOnError(p31) -- Line: 509
    local bit32_band_ret = bit32.band(p31.pendingLanes, 3221225471);

    return bit32_band_ret == 0 and (bit32.band(bit32_band_ret, 1073741824) == 0 and 0 or 1073741824) or bit32_band_ret;
end;

function v2.returnNextLanesPriority() -- Line: 522
    -- upvalues: DefaultLanePriority (ref)
    return DefaultLanePriority;
end;

function v2.includesNonIdleWork(p32) -- Line: 527
    return bit32.band(p32, 134217727) ~= 0;
end;

function v2.includesOnlyRetries(p33) -- Line: 532
    return bit32.band(p33, 62914560) == p33;
end;

function v2.includesOnlyTransitions(p34) -- Line: 537
    return bit32.band(p34, 4186112) == p34;
end;

local u35 = nil;

local function findUpdateLane(p36, p37) -- Line: 547
    -- upvalues: u35 (ref), findUpdateLane (copy), invariant (copy)
    if p36 ~= 0 then
        if p36 == 15 then
            return 1;
        end;

        if p36 == 14 then
            return 2;
        end;

        if p36 == 12 then
            local bit32_bnot_ret = bit32.bnot(p37);
            local v38 = u35((bit32.band(24, bit32_bnot_ret)));

            if v38 == 0 then
                return findUpdateLane(10, p37);
            end;

            return v38;
        end;

        if p36 == 10 then
            local bit32_bnot_ret = bit32.bnot(p37);
            local v39 = u35((bit32.band(192, bit32_bnot_ret)));

            if v39 == 0 then
                return findUpdateLane(8, p37);
            end;

            return v39;
        end;

        if p36 == 8 then
            local bit32_bnot_ret = bit32.bnot(p37);
            local v40 = u35((bit32.band(3584, bit32_bnot_ret)));

            if v40 == 0 then
                local bit32_bnot_ret2 = bit32.bnot(p37);
                v40 = u35((bit32.band(4186112, bit32_bnot_ret2)));

                if v40 == 0 then
                    v40 = u35(3584);
                end;
            end;

            return v40;
        end;

        if p36 ~= 6 and (p36 ~= 5 and p36 == 2) then
            local bit32_bnot_ret = bit32.bnot(p37);
            local v41 = u35((bit32.band(805306368, bit32_bnot_ret)));

            if v41 == 0 then
                v41 = u35(805306368);
            end;

            return v41;
        end;
    end;

    invariant(false, "Invalid update priority: %s. This is a bug in React.", p36);
    error("unreachable");
end;

v2.findUpdateLane = findUpdateLane;

function v2.findTransitionLane(p42, p43) -- Line: 606
    -- upvalues: u35 (ref)
    local bit32_bnot_ret = bit32.bnot(p43);
    local v44 = u35((bit32.band(4186112, bit32_bnot_ret)));

    if v44 == 0 then
        local bit32_bnot_ret2 = bit32.bnot(p42);
        v44 = u35((bit32.band(4186112, bit32_bnot_ret2)));

        if v44 == 0 then
            v44 = u35(4186112);
        end;
    end;

    return v44;
end;

function v2.findRetryLane(p45) -- Line: 626
    -- upvalues: u35 (ref)
    local bit32_bnot_ret = bit32.bnot(p45);
    local v46 = u35((bit32.band(62914560, bit32_bnot_ret)));

    if v46 == 0 then
        v46 = u35(62914560);
    end;

    return v46;
end;

local function getHighestPriorityLane(p47) -- Line: 638
    return bit32.band(p47, -p47);
end;

u8 = function(p48) -- Line: 642, Name: getLowestPriorityLane
    local v49 = 31 - bit32.countlz(p48);

    return v49 < 0 and 0 or bit32.lshift(1, v49);
end;

local function getEqualOrHigherPriorityLanes(p50) -- Line: 652
    -- upvalues: u8 (ref)
    local v51 = u8(p50);

    return bit32.lshift(v51, 1) - 1;
end;

u35 = function(p52) -- Line: 656, Name: pickArbitraryLane
    return bit32.band(p52, -p52);
end;

v2.pickArbitraryLane = u35;

u7 = function(p53) -- Line: 665, Name: pickArbitraryLaneIndex
    return 31 - bit32.countlz(p53);
end;

function v2.includesSomeLane(p54, p55) -- Line: 674
    return bit32.band(p54, p55) ~= 0;
end;

function v2.isSubsetOfLanes(p56, p57) -- Line: 679
    return bit32.band(p56, p57) == p57;
end;

function v2.mergeLanes(p58, p59) -- Line: 684
    return bit32.bor(p58, p59);
end;

function v2.removeLanes(p60, p61) -- Line: 689
    local bit32_bnot_ret = bit32.bnot(p61);

    return bit32.band(p60, bit32_bnot_ret);
end;

function v2.laneToLanes(p62) -- Line: 696
    return p62;
end;

function v2.higherPriorityLane(p63, p64) -- Line: 701
    if p63 == 0 or p64 == 0 then
        if p63 == 0 then
            return p64;
        end;

        return p63;
    end;

    if p63 < p64 then
        return p63;
    end;

    return p64;
end;

function v2.higherLanePriority(p65, p66) -- Line: 717
    if p65 == 0 or p66 >= p65 then
        return p66;
    end;

    return p65;
end;

function v2.createLaneMap(p67) -- Line: 728
    return {
        [0] = p67,
        [1] = p67,
        [2] = p67,
        [3] = p67,
        [4] = p67,
        [5] = p67,
        [6] = p67,
        [7] = p67,
        [8] = p67,
        [9] = p67,
        [10] = p67,
        [11] = p67,
        [12] = p67,
        [13] = p67,
        [14] = p67,
        [15] = p67,
        [16] = p67,
        [17] = p67,
        [18] = p67,
        [19] = p67,
        [20] = p67,
        [21] = p67,
        [22] = p67,
        [23] = p67,
        [24] = p67,
        [25] = p67,
        [26] = p67,
        [27] = p67,
        [28] = p67,
        [29] = p67,
        [30] = p67,
        [31] = p67
    };
end;

function v2.markRootUpdated(p68: any, p69: any, p70: number) -- Line: 772
    p68.pendingLanes = bit32.bor(p68.pendingLanes, p69);
    local v71 = p69 - 1;
    p68.suspendedLanes = bit32.band(p68.suspendedLanes, v71);
    p68.pingedLanes = bit32.band(p68.pingedLanes, v71);
    p68.eventTimes[31 - bit32.countlz(p69)] = p70;
end;

function v2.markRootSuspended(p72, p73) -- Line: 801
    -- upvalues: u7 (ref)
    p72.suspendedLanes = bit32.bor(p72.suspendedLanes, p73);
    local pingedLanes = p72.pingedLanes;
    local bit32_bnot_ret = bit32.bnot(p73);
    p72.pingedLanes = bit32.band(pingedLanes, bit32_bnot_ret);
    local expirationTimes = p72.expirationTimes;

    while p73 > 0 do
        local v74 = u7(p73);
        local bit32_lshift_ret = bit32.lshift(1, v74);
        expirationTimes[v74] = -1;
        local bit32_bnot_ret2 = bit32.bnot(bit32_lshift_ret);
        p73 = bit32.band(p73, bit32_bnot_ret2);
    end;
end;

function v2.markRootPinged(p75: any, p76: any, p77: number) -- Line: 819
    local pingedLanes = p75.pingedLanes;
    local bit32_band_ret = bit32.band(p75.suspendedLanes, p76);
    p75.pingedLanes = bit32.bor(pingedLanes, bit32_band_ret);
end;

function v2.markRootExpired(p78, p79) -- Line: 825
    local expiredLanes = p78.expiredLanes;
    local bit32_band_ret = bit32.band(p79, p78.pendingLanes);
    p78.expiredLanes = bit32.bor(expiredLanes, bit32_band_ret);
end;

function v2.markDiscreteUpdatesExpired(p80) -- Line: 831
    local expiredLanes = p80.expiredLanes;
    local bit32_band_ret = bit32.band(24, p80.pendingLanes);
    p80.expiredLanes = bit32.bor(expiredLanes, bit32_band_ret);
end;

function v2.hasDiscreteLanes(p81) -- Line: 837
    return bit32.band(p81, 24) ~= 0;
end;

function v2.markRootMutableRead(p82, p83) -- Line: 842
    local mutableReadLanes = p82.mutableReadLanes;
    local bit32_band_ret = bit32.band(p83, p82.pendingLanes);
    p82.mutableReadLanes = bit32.bor(mutableReadLanes, bit32_band_ret);
end;

function v2.markRootFinished(p84, p85) -- Line: 848
    -- upvalues: u7 (ref)
    local pendingLanes = p84.pendingLanes;
    local bit32_bnot_ret = bit32.bnot(p85);
    local bit32_band_ret = bit32.band(pendingLanes, bit32_bnot_ret);
    p84.pendingLanes = p85;
    p84.suspendedLanes = 0;
    p84.pingedLanes = 0;
    p84.expiredLanes = bit32.band(p84.expiredLanes, p85);
    p84.mutableReadLanes = bit32.band(p84.mutableReadLanes, p85);
    p84.entangledLanes = bit32.band(p84.entangledLanes, p85);
    local entanglements = p84.entanglements;
    local eventTimes = p84.eventTimes;
    local expirationTimes = p84.expirationTimes;

    while bit32_band_ret > 0 do
        local v86 = u7(bit32_band_ret);
        local bit32_lshift_ret = bit32.lshift(1, v86);
        entanglements[v86] = 0;
        eventTimes[v86] = -1;
        expirationTimes[v86] = -1;
        local bit32_bnot_ret2 = bit32.bnot(bit32_lshift_ret);
        bit32_band_ret = bit32.band(bit32_band_ret, bit32_bnot_ret2);
    end;
end;

function v2.markRootEntangled(p87, p88) -- Line: 881
    -- upvalues: u7 (ref)
    p87.entangledLanes = bit32.bor(p87.entangledLanes, p88);
    local entanglements = p87.entanglements;
    local v89 = p88;

    while p88 > 0 do
        local v90 = u7(p88);
        local bit32_lshift_ret = bit32.lshift(1, v90);
        entanglements[v90] = bit32.bor(entanglements[v90], v89);
        local bit32_bnot_ret = bit32.bnot(bit32_lshift_ret);
        p88 = bit32.band(p88, bit32_bnot_ret);
    end;
end;

function v2.getBumpedLaneForHydration(p91, p92) -- Line: 897
    -- upvalues: getHighestPriorityLanes (copy), DefaultLanePriority (ref), invariant (copy)
    getHighestPriorityLanes(p92);
    local v93 = DefaultLanePriority;
    local v94 = nil;

    if v93 == 15 or v93 == 14 then
        v94 = 0;
    elseif v93 == 13 or v93 == 12 then
        v94 = 4;
    elseif v93 == 11 or v93 == 10 then
        v94 = 32;
    elseif v93 == 9 or v93 == 8 then
        v94 = 256;
    elseif v93 == 7 or v93 == 6 or v93 == 5 then
        v94 = 4096;
    elseif v93 == 4 then
        v94 = 67108864;
    elseif v93 == 3 or v93 == 2 then
        v94 = 134217728;
    elseif v93 == 1 or v93 == 0 then
        v94 = 0;
    else
        invariant(false, "Invalid lane: %s. This is a bug in React.", (tostring(v94)));
    end;

    local bit32_bor_ret = bit32.bor(p91.suspendedLanes, p92);

    return bit32.band(v94, bit32_bor_ret) ~= 0 and 0 or v94;
end;

return v2;