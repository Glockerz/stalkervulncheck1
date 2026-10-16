-- Decompiled with Potassium's decompiler.

local u1 = {
    HEAR_ERROR_DIVISOR = 15,
    HEAR_ERROR_MIN = 2,
    HEAR_ERROR_MAX = 15,
    SQUAD_ERROR_DIVISOR = 10,
    SQUAD_EXTRA_ERROR = 6,
    SQUAD_ERROR_MAX = 25,
    SQUAD_CERTAINTY = 0.7,
    CERTAINTY_HALF_LIFE = 10,
    FORGET_SECONDS = 180
};
local u2 = setmetatable({}, {
    __mode = "k"
});

local function board(p3, p4) -- Line: 42
    -- upvalues: u2 (copy)
    local v5 = u2[p3];

    if not v5 and p4 then
        v5 = setmetatable({}, {
            __mode = "k"
        });
        u2[p3] = v5;
    end;

    return v5;
end;

local function record(p6, p7, p8) -- Line: 51
    -- upvalues: board (copy)
    local v9 = board(p6, p8);

    if not v9 then
        return nil;
    end;

    local v10 = v9[p7];

    if not v10 and p8 then
        v10 = {
            visible = false
        };
        v9[p7] = v10;
    end;

    return v10;
end;

local function baseCertainty(p11, p12) -- Line: 63
    -- upvalues: u1 (copy)
    if p11 == "seen" then
        return 1;
    end;

    if p11 == "heard" then
        return 1 - math.min(p12 / u1.HEAR_ERROR_MAX, 1) * 0.5;
    end;

    return u1.SQUAD_CERTAINTY * (1 - math.min(p12 / u1.SQUAD_ERROR_MAX, 1) * 0.5);
end;

function u1.Certainty(p13, p14) -- Line: 69
    -- upvalues: u1 (copy)
    if p13.visible then
        return 1;
    end;

    if not p13.knownAt then
        return 0;
    end;

    local knownSource = p13.knownSource;
    local knownError = p13.knownError;
    local v15;

    if knownSource == "seen" then
        v15 = 1;
    elseif knownSource == "heard" then
        v15 = 1 - math.min(knownError / u1.HEAR_ERROR_MAX, 1) * 0.5;
    else
        v15 = u1.SQUAD_CERTAINTY * (1 - math.min(knownError / u1.SQUAD_ERROR_MAX, 1) * 0.5);
    end;

    return v15 * 0.5 ^ ((p14 - p13.knownAt) / u1.CERTAINTY_HALF_LIFE);
end;

local function offer(p16, p17, p18, p19, p20) -- Line: 78
    -- upvalues: u1 (copy)
    if p16.visible then
        return;
    end;

    if p16.knownAt then
        local v21;

        if p19 == "seen" then
            v21 = 1;
        elseif p19 == "heard" then
            v21 = 1 - math.min(p20 / u1.HEAR_ERROR_MAX, 1) * 0.5;
        else
            v21 = u1.SQUAD_CERTAINTY * (1 - math.min(p20 / u1.SQUAD_ERROR_MAX, 1) * 0.5);
        end;

        if v21 < u1.Certainty(p16, p18) then
            return;
        end;
    end;

    p16.knownPos = p17;
    p16.knownAt = p18;
    p16.knownSource = p19;
    p16.knownError = p20;
end;

u1.MIN_SCATTER_FRAC = 0.3;

local function scatter(p22, p23, p24) -- Line: 89
    -- upvalues: u1 (copy)
    local v25 = p24 or math.random;
    local v26 = v25() * 3.141592653589793 * 2;
    local MIN_SCATTER_FRAC = u1.MIN_SCATTER_FRAC;
    local v27 = 1 - u1.MIN_SCATTER_FRAC;
    local v28 = v25();
    local v29 = (MIN_SCATTER_FRAC + v27 * math.sqrt(v28)) * p23;
    local v30 = math.cos(v26) * v29;
    local v31 = math.sin(v26) * v29;

    return p22 + Vector3.new(v30, 0, v31);
end;

function u1.Seen(p32, p33, p34, p35) -- Line: 97
    -- upvalues: board (copy)
    local v36 = board(p32, true);
    local v37;

    if v36 then
        v37 = v36[p33];

        if not v37 then
            v37 = {
                visible = false
            };
            v36[p33] = v37;
        end;
    else
        v37 = nil;
    end;

    v37.visible = true;
    v37.seenPos = p34;
    v37.seenAt = p35;
    v37.notice = 1;
    v37.noticeAt = p35;
    v37.noticeIn = true;
    v37.knownPos = p34;
    v37.knownAt = p35;
    v37.knownSource = "seen";
    v37.knownError = 0;

    return v37;
end;

function u1.LostSight(p38, p39, p40) -- Line: 108
    -- upvalues: board (copy)
    local v41 = board(p38, false);
    local v42;

    if v41 then
        v42 = v41[p39];
    else
        v42 = nil;
    end;

    if v42 and v42.visible then
        v42.visible = false;
        v42.lostAt = p40;
    end;
end;

function u1.Heard(p43, p44, p45, p46, p47, p48, p49) -- Line: 119
    -- upvalues: board (copy), u1 (copy), scatter (copy)
    local v50 = board(p43, true);
    local v51;

    if v50 then
        v51 = v50[p44];

        if not v51 then
            v51 = {
                visible = false
            };
            v50[p44] = v51;
        end;
    else
        v51 = nil;
    end;

    local v52 = p49 or math.clamp((p45 - p46).Magnitude / u1.HEAR_ERROR_DIVISOR, u1.HEAR_ERROR_MIN, u1.HEAR_ERROR_MAX);
    local v53 = scatter(p45, v52, p48);
    v51.heardPos = v53;
    v51.heardAt = p47;
    v51.heardError = v52;

    if v51.visible then
        return v51;
    end;

    if v51.knownAt and 1 - math.min(v52 / u1.HEAR_ERROR_MAX, 1) * 0.5 < u1.Certainty(v51, p47) then
        return v51;
    end;

    v51.knownPos = v53;
    v51.knownAt = p47;
    v51.knownSource = "heard";
    v51.knownError = v52;

    return v51;
end;

function u1.Reported(p54, p55, p56, p57, p58, p59) -- Line: 130
    -- upvalues: board (copy), u1 (copy), scatter (copy)
    local v60 = board(p54, true);
    local v61;

    if v60 then
        v61 = v60[p55];

        if not v61 then
            v61 = {
                visible = false
            };
            v60[p55] = v61;
        end;
    else
        v61 = nil;
    end;

    local math_clamp_ret = math.clamp((p56 - p57).Magnitude / u1.SQUAD_ERROR_DIVISOR + u1.SQUAD_EXTRA_ERROR, u1.HEAR_ERROR_MIN, u1.SQUAD_ERROR_MAX);
    local v62 = scatter(p56, math_clamp_ret, p59);
    v61.squadPos = v62;
    v61.squadAt = p58;
    v61.squadError = math_clamp_ret;

    if v61.visible then
        return v61;
    end;

    if v61.knownAt and u1.SQUAD_CERTAINTY * (1 - math.min(math_clamp_ret / u1.SQUAD_ERROR_MAX, 1) * 0.5) < u1.Certainty(v61, p58) then
        return v61;
    end;

    v61.knownPos = v62;
    v61.knownAt = p58;
    v61.knownSource = "squad";
    v61.knownError = math_clamp_ret;

    return v61;
end;

function u1.Relayed(p63, p64, p65, p66, p67, p68, p69) -- Line: 146
    -- upvalues: board (copy), u1 (copy), scatter (copy)
    local v70 = board(p63, true);
    local v71;

    if v70 then
        v71 = v70[p64];

        if not v71 then
            v71 = {
                visible = false
            };
            v70[p64] = v71;
        end;
    else
        v71 = nil;
    end;

    local math_clamp_ret = math.clamp((p66 or 0) + u1.SQUAD_EXTRA_ERROR, u1.HEAR_ERROR_MIN, u1.SQUAD_ERROR_MAX);
    local v72 = scatter(p65, math_clamp_ret, p68);
    v71.squadPos = v72;
    v71.squadAt = p67;
    v71.squadError = math_clamp_ret;
    v71.squadKind = p69;

    if v71.visible then
        return v71;
    end;

    if v71.knownAt and u1.SQUAD_CERTAINTY * (1 - math.min(math_clamp_ret / u1.SQUAD_ERROR_MAX, 1) * 0.5) < u1.Certainty(v71, p67) then
        return v71;
    end;

    v71.knownPos = v72;
    v71.knownAt = p67;
    v71.knownSource = "squad";
    v71.knownError = math_clamp_ret;

    return v71;
end;

u1.NOTICE_DECAY = 0.5;
u1.NOTICE_CONTINUITY = 1.1;
u1.NOTICE_FORGET_SECONDS = 30;

function u1.Notice(p73, p74, p75, p76, p77) -- Line: 173
    -- upvalues: board (copy), u1 (copy), u2 (copy)
    local v78 = board(p73, p75);
    local v79;

    if v78 then
        v79 = v78[p74];

        if not v79 and p75 then
            v79 = {
                visible = false
            };
            v78[p74] = v79;
        end;
    else
        v79 = nil;
    end;

    if not v79 then
        return 0;
    end;

    local v80 = p77 - (v79.noticeAt or p77);
    v79.noticeAt = p77;
    local v81 = v79.notice or 0;
    local v82;

    if p75 and (v79.noticeIn and v80 <= u1.NOTICE_CONTINUITY) then
        v82 = math.min(1, v81 + v80 / p76);
    else
        v82 = math.max(0, v81 - v80 * u1.NOTICE_DECAY);
    end;

    v79.noticeIn = p75;
    v79.notice = v82;

    if not (p75 or (v82 > 0 or v79.knownAt)) then
        u2[p73][p74] = nil;
    end;

    return v82;
end;

function u1.Get(p83, p84, p85) -- Line: 193
    -- upvalues: u2 (copy), u1 (copy)
    local v86 = u2[p83];
    local v87;

    if v86 then
        v87 = v86[p84];
    else
        v87 = v86;
    end;

    if not v87 then
        return nil;
    end;

    if not (v87.visible or (not v87.knownAt or p85 - v87.knownAt <= u1.FORGET_SECONDS)) then
        v86[p84] = nil;

        return nil;
    end;

    if v87.visible or (v87.knownAt or (not v87.noticeAt or p85 - v87.noticeAt <= u1.NOTICE_FORGET_SECONDS)) then
        return v87;
    end;

    v86[p84] = nil;

    return nil;
end;

function u1.BestEstimate(p88, p89, p90) -- Line: 210
    -- upvalues: u1 (copy)
    local v91 = u1.Get(p88, p89, p90);

    if v91 and v91.knownPos then
        return v91.knownPos, u1.Certainty(v91, p90), v91.knownSource, v91.knownError;
    end;

    return nil;
end;

function u1.MarkSearched(p92, p93) -- Line: 219
    -- upvalues: board (copy)
    local v94 = board(p92, false);
    local v95;

    if v94 then
        v95 = v94[p93];
    else
        v95 = nil;
    end;

    if v95 then
        v95.searchedAt = v95.knownAt or 0;
    end;
end;

function u1.Strongest(p96, p97, p98) -- Line: 227
    -- upvalues: u2 (copy), u1 (copy)
    local v99 = u2[p96];

    if not v99 then
        return nil;
    end;

    local v100 = 0;
    local v101 = nil;
    local v102 = nil;

    for i, _ in pairs(v99) do
        local v103 = u1.Get(p96, i, p97);

        if v103 and (v103.knownAt and (not v103.searchedAt or v103.knownAt > v103.searchedAt)) then
            local v104 = u1.Certainty(v103, p97);

            if v100 < v104 and (p98 == nil or p98(i)) then
                v102 = v103;
                v101 = i;
                v100 = v104;
            end;
        end;
    end;

    return v101, v102;
end;

function u1.Forget(p105, p106) -- Line: 243
    -- upvalues: u2 (copy)
    local v107 = u2[p105];

    if v107 then
        v107[p106] = nil;
    end;
end;

function u1.Release(p108) -- Line: 249
    -- upvalues: u2 (copy)
    u2[p108] = nil;
end;

function u1.ForgetEnemy(p109) -- Line: 254
    -- upvalues: u2 (copy)
    for _, v in pairs(u2) do
        v[p109] = nil;
    end;
end;

function u1.Count() -- Line: 261
    -- upvalues: u2 (copy)
    local v110 = 0;
    local v111 = 0;

    for _, v in pairs(u2) do
        v110 = v110 + 1;

        for _ in pairs(v) do
            v111 = v111 + 1;
        end;
    end;

    return v110, v111;
end;

local u112 = nil;

function u1.Enabled() -- Line: 273
    -- upvalues: u112 (ref)
    if u112 == nil then
        local success, result = pcall(function() -- Line: 275
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.Knowledge == true;
            else
                success = false;
            end;
        end;

        u112 = success;
    end;

    return u112;
end;

function u1.SetEnabled(p113) -- Line: 285
    -- upvalues: u112 (ref)
    u112 = p113 == true;
end;

if game:GetService("RunService"):IsServer() then
    local Players = game:GetService("Players");
    Players.PlayerAdded:Connect(function(p114) -- Line: 295, Name: watch
        -- upvalues: u1 (copy)
        p114.CharacterRemoving:Connect(function(p115) -- Line: 296
            -- upvalues: u1 (ref)
            u1.ForgetEnemy(p115);
        end);
    end);

    for _, v in ipairs(Players:GetPlayers()) do
        v.CharacterRemoving:Connect(function(p116) -- Line: 296
            -- upvalues: u1 (copy)
            u1.ForgetEnemy(p116);
        end);
    end;

    Players.PlayerRemoving:Connect(function(p117) -- Line: 300
        -- upvalues: u1 (copy)
        if p117.Character then
            u1.ForgetEnemy(p117.Character);
        end;
    end);
end;

return u1;