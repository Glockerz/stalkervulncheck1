-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = {
    CLAIM_RADIUS = 4,
    ALLY_RADIUS = 60,
    FLANK_SLOT_MAX = 20
};
local u2 = setmetatable({}, {
    __mode = "k"
});
local u3 = setmetatable({}, {
    __mode = "k"
});
local u4 = setmetatable({}, {
    __mode = "k"
});
u1.SEARCH_RADIUS = 60;
u1.SEARCH_STALE = 2;
local u5 = setmetatable({}, {
    __mode = "k"
});

local function alive(p6) -- Line: 31
    local v7 = p6.Parent and p6:FindFirstChildOfClass("Humanoid");
    local v8;

    if v7 == nil then
        v8 = false;
    else
        v8 = v7.Health > 0;
    end;

    return v8;
end;

function u1.Register(p9, p10, p11) -- Line: 38
    -- upvalues: u2 (copy)
    u2[p9] = {
        getMorale = p10,
        root = p11
    };
end;

function u1.ClaimCover(p12, p13) -- Line: 42
    -- upvalues: u3 (copy)
    u3[p12] = p13;
end;

function u1.ReleaseCover(p14) -- Line: 46
    -- upvalues: u3 (copy)
    u3[p14] = nil;
end;

local function flat(p15) -- Line: 53
    return Vector3.new(p15.X, 0, p15.Z);
end;

function u1.IsClaimed(p16, p17) -- Line: 54
    -- upvalues: u3 (copy), u1 (copy)
    for i, v in pairs(u3) do
        if i ~= p17 then
            local v18 = v - p16;

            if Vector3.new(v18.X, 0, v18.Z).Magnitude < u1.CLAIM_RADIUS then
                local v19 = i.Parent and i:FindFirstChildOfClass("Humanoid");
                local v20;

                if v19 == nil then
                    v20 = false;
                else
                    v20 = v19.Health > 0;
                end;

                if v20 then
                    return true;
                end;
            end;
        end;
    end;

    return false;
end;

function u1.FlankFree(p21, p22, p23) -- Line: 61
    -- upvalues: u4 (copy), u1 (copy)
    local v24 = u4[p21];
    local v25;

    if v24 == nil or (v24.npc == p22 or p23 - v24.at > u1.FLANK_SLOT_MAX) then
        v25 = true;
    else
        local npc = v24.npc;
        local v26 = npc.Parent and npc:FindFirstChildOfClass("Humanoid");
        local v27;

        if v26 == nil then
            v27 = false;
        else
            v27 = v26.Health > 0;
        end;

        v25 = not v27;
    end;

    return v25;
end;

function u1.TryFlank(p28, p29, p30) -- Line: 66
    -- upvalues: u1 (copy), u4 (copy)
    if not u1.FlankFree(p29, p28, p30) then
        return false;
    end;

    u4[p29] = {
        npc = p28,
        at = p30
    };

    return true;
end;

function u1.ReleaseFlank(p31) -- Line: 72
    -- upvalues: u4 (copy)
    for i, v in pairs(u4) do
        if v.npc == p31 then
            u4[i] = nil;
        end;
    end;
end;

function u1.SearchRole(p32, p33, p34, p35) -- Line: 79
    -- upvalues: u5 (copy), u1 (copy)
    local v36 = u5[p33];

    if not v36 then
        v36 = setmetatable({}, {
            __mode = "k"
        });
        u5[p33] = v36;
    end;

    local v37 = v36[p32];

    if v37 and p35 - v37.at <= u1.SEARCH_STALE then
        v37.pos = p34;
        v37.at = p35;

        return "search";
    end;

    for i, v in pairs(v36) do
        if i ~= p32 and p35 - v.at <= u1.SEARCH_STALE then
            local v38 = i.Parent and i:FindFirstChildOfClass("Humanoid");
            local v39;

            if v38 == nil then
                v39 = false;
            else
                v39 = v38.Health > 0;
            end;

            if v39 and (v.pos - p34).Magnitude <= u1.SEARCH_RADIUS then
                return "hold";
            end;
        end;
    end;

    v36[p32] = {
        pos = p34,
        at = p35
    };

    return "search";
end;

function u1.ReleaseSearch(p40) -- Line: 99
    -- upvalues: u5 (copy)
    for _, v in pairs(u5) do
        v[p40] = nil;
    end;
end;

function u1.CountNear(p41, p42, p43, p44, p45) -- Line: 106
    -- upvalues: u2 (copy), Players (copy)
    local v46 = 0;
    local v47 = 0;

    for i, v in pairs(u2) do
        if i ~= p41 and ((v.root.Position - p42).Magnitude <= p43 and v.root.Parent) then
            local v48 = i.Parent and i:FindFirstChildOfClass("Humanoid");
            local v49;

            if v48 == nil then
                v49 = false;
            else
                v49 = v48.Health > 0;
            end;

            if v49 and not i:GetAttribute("_Dormant") then
                if p44(i) then
                    v47 = v47 + 1;
                elseif p45(i) then
                    v46 = v46 + 1;
                end;
            end;
        end;
    end;

    for _, v in ipairs(Players:GetPlayers()) do
        local Character = v.Character;
        local v50;

        if Character then
            v50 = Character:FindFirstChild("HumanoidRootPart");
        else
            v50 = Character;
        end;

        if v50 then
            local v51 = Character.Parent and Character:FindFirstChildOfClass("Humanoid");
            local v52;

            if v51 == nil then
                v52 = false;
            else
                v52 = v51.Health > 0;
            end;

            if v52 and ((v50.Position - p42).Magnitude <= p43 and p45(Character)) then
                v46 = v46 + 1;
            end;
        end;
    end;

    return v47, v46;
end;

u1.COVER_RADIUS = 60;
u1.MAX_COVERERS = 2;
u1.PRESSURE_FRESH = 1.5;
u1.DEFAULT_COVER_CHANCE = 0.5;
local u53 = setmetatable({}, {
    __mode = "k"
});
local u54 = setmetatable({}, {
    __mode = "k"
});
local u55 = setmetatable({}, {
    __mode = "k"
});

local function within(p56, p57, p58) -- Line: 150
    -- upvalues: u2 (copy)
    local v59 = u2[p56];
    local v60 = u2[p57];
    local v61;

    if v59 == nil or v60 == nil then
        v61 = false;
    else
        v61 = (v59.root.Position - v60.root.Position).Magnitude <= p58;
    end;

    return v61;
end;

function u1.Announce(p62, p63, p64, p65, p66) -- Line: 156
    -- upvalues: u53 (copy)
    u53[p62] = {
        kind = p63,
        target = p64,
        untilAt = p65 + p66
    };
end;

function u1.EndMove(p67) -- Line: 161
    -- upvalues: u53 (copy), u54 (copy)
    u53[p67] = nil;

    for i, v in pairs(u54) do
        if v.mover == p67 then
            u54[i] = nil;
        end;
    end;
end;

function u1.Pressure(p68, p69, p70) -- Line: 168
    -- upvalues: u55 (copy)
    u55[p68] = {
        target = p69,
        at = p70
    };
end;

function u1.Mates(p71, p72, p73, p74, p75) -- Line: 174
    -- upvalues: u53 (copy), u1 (copy), u2 (copy), u55 (copy)
    local v76 = {
        moving = nil,
        movingKind = nil,
        pinned = nil,
        pressure = false
    };

    if p73 == nil then
        return v76;
    end;

    for i, v in pairs(u53) do
        if i ~= p71 and (v.target == p73 and p74 <= v.untilAt) then
            local v77 = i.Parent and i:FindFirstChildOfClass("Humanoid");
            local v78;

            if v77 == nil then
                v78 = false;
            else
                v78 = v77.Health > 0;
            end;

            if v78 then
                local COVER_RADIUS = u1.COVER_RADIUS;
                local v79 = u2[p71];
                local v80 = u2[i];
                local v81;

                if v79 == nil or v80 == nil then
                    v81 = false;
                else
                    v81 = (v79.root.Position - v80.root.Position).Magnitude <= COVER_RADIUS;
                end;

                if v81 and p75(i) then
                    if v.kind == "Pinned" then
                        v76.pinned = v76.pinned or i;
                    elseif not v76.moving then
                        local kind = v.kind;
                        v76.moving = i;
                        v76.movingKind = kind;
                    end;
                end;
            end;
        end;
    end;

    for i, v in pairs(u55) do
        if i ~= p71 and (v.target == p73 and p74 - v.at <= u1.PRESSURE_FRESH) then
            local v82 = i.Parent and i:FindFirstChildOfClass("Humanoid");
            local v83;

            if v82 == nil then
                v83 = false;
            else
                v83 = v82.Health > 0;
            end;

            if v83 then
                local COVER_RADIUS = u1.COVER_RADIUS;
                local v84 = u2[p71];
                local v85 = u2[i];
                local v86;

                if v84 == nil or v85 == nil then
                    v86 = false;
                else
                    v86 = (v84.root.Position - v85.root.Position).Magnitude <= COVER_RADIUS;
                end;

                if v86 and p75(i) then
                    v76.pressure = true;

                    return v76;
                end;
            end;
        end;
    end;

    return v76;
end;

function u1.CoverersOf(p87, p88) -- Line: 199
    -- upvalues: u54 (copy)
    local v89 = 0;

    for _, v in pairs(u54) do
        if v.mover == p87 and p88 <= v.untilAt then
            v89 = v89 + 1;
        end;
    end;

    return v89;
end;

function u1.TryCover(p90, p91, p92, p93) -- Line: 208
    -- upvalues: u1 (copy), u54 (copy)
    if u1.CoverersOf(p91, p92) >= u1.MAX_COVERERS then
        return false;
    end;

    u54[p90] = {
        mover = p91,
        untilAt = p93
    };

    return true;
end;

function u1.Covering(p94, p95) -- Line: 215
    -- upvalues: u54 (copy), u53 (copy)
    local v96 = u54[p94];

    if not v96 then
        return nil;
    end;

    if v96.untilAt >= p95 and u53[v96.mover] ~= nil then
        local mover = v96.mover;
        local v97 = mover.Parent and mover:FindFirstChildOfClass("Humanoid");
        local v98;

        if v97 == nil then
            v98 = false;
        else
            v98 = v97.Health > 0;
        end;

        if v98 then
            return v96.mover;
        end;
    end;

    u54[p94] = nil;

    return nil;
end;

function u1.StopCovering(p99) -- Line: 225
    -- upvalues: u54 (copy)
    u54[p99] = nil;
end;

u1.MAX_SUPPRESSORS = 2;
local u100 = setmetatable({}, {
    __mode = "k"
});

function u1.TrySuppress(p101, p102, p103, p104) -- Line: 234
    -- upvalues: u100 (copy), u1 (copy)
    local v105 = 0;

    for i, v in pairs(u100) do
        if i ~= p101 and (v.target == p102 and p103 <= v.untilAt) then
            local v106 = i.Parent and i:FindFirstChildOfClass("Humanoid");
            local v107;

            if v106 == nil then
                v107 = false;
            else
                v107 = v106.Health > 0;
            end;

            if v107 then
                v105 = v105 + 1;
            end;
        end;
    end;

    if u1.MAX_SUPPRESSORS <= v105 then
        return false;
    end;

    u100[p101] = {
        target = p102,
        untilAt = p104
    };

    return true;
end;

function u1.ReleaseSuppress(p108) -- Line: 243
    -- upvalues: u100 (copy)
    u100[p108] = nil;
end;

local u109 = nil;

function u1.CoverEnabled() -- Line: 248
    -- upvalues: u109 (ref)
    if u109 == nil then
        local success, result = pcall(function() -- Line: 250
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);
        u109 = success and (type(result) == "table" and (type(result.AI) == "table" and result.AI.SquadCover == true)) and true or false;
    end;

    return u109;
end;

function u1.SetCoverEnabled(p110) -- Line: 257
    -- upvalues: u109 (ref)
    u109 = p110 == true;
end;

function u1.OnDeath(p111) -- Line: 262
    -- upvalues: u2 (copy), u1 (copy)
    local v112 = u2[p111];
    local Attribute = p111:GetAttribute("Faction");

    if not (v112 and Attribute) then
        return;
    end;

    local Position = v112.root.Position;

    for i, v in pairs(u2) do
        if i ~= p111 and i:GetAttribute("Faction") == Attribute then
            local v113 = i.Parent and i:FindFirstChildOfClass("Humanoid");
            local v114;

            if v113 == nil then
                v114 = false;
            else
                v114 = v113.Health > 0;
            end;

            if v114 and (v.root.Parent and (v.root.Position - Position).Magnitude <= u1.ALLY_RADIUS) then
                v.getMorale():AllyDied();
            end;
        end;
    end;
end;

function u1.Release(p115) -- Line: 276
    -- upvalues: u2 (copy), u3 (copy), u1 (copy), u54 (copy), u55 (copy)
    u2[p115] = nil;
    u3[p115] = nil;
    u1.ReleaseFlank(p115);
    u1.ReleaseSearch(p115);
    u1.EndMove(p115);
    u54[p115] = nil;
    u55[p115] = nil;
    u1.ReleaseSuppress(p115);
end;

return u1;