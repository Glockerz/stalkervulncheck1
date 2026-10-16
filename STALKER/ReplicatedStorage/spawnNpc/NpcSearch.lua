-- Decompiled with Potassium's decompiler.

local NpcSight = require(game:GetService("ReplicatedStorage"):WaitForChild("NpcSight"));
local u1 = {
    RANK = {
        Rookie = {
            watch = 1,
            listen = 2,
            duration = 30,
            checks = 2
        },
        Experienced = {
            watch = 2,
            listen = 2.5,
            duration = 45,
            checks = 3
        },
        Professional = {
            watch = 2.5,
            listen = 3,
            duration = 55,
            checks = 3
        },
        Veteran = {
            watch = 3,
            listen = 3.5,
            duration = 65,
            checks = 4
        },
        Expert = {
            watch = 3.5,
            listen = 4,
            duration = 75,
            checks = 5
        }
    },
    MIN_SEARCH_FRAC = 0.75,
    DEFAULT_RANK = "Experienced"
};

function u1.Profile(p2, p3) -- Line: 47
    -- upvalues: u1 (copy)
    local v4 = u1.RANK[p2 or ""] or u1.RANK[u1.DEFAULT_RANK];
    local math_clamp_ret = math.clamp(p3 or 0.5, 0, 1);

    return {
        watch = v4.watch * (1.5 - math_clamp_ret),
        listen = v4.listen,
        duration = v4.duration,
        checks = v4.checks
    };
end;

u1.AREA_MIN = 4;
u1.AREA_AGE_GROWTH = 1.5;
u1.AREA_MAX = 40;
u1.PRECISE_AREA = 10;

function u1.Area(p5, p6) -- Line: 66
    -- upvalues: u1 (copy)
    local v7 = math.max(u1.AREA_MIN, p5 or 0) + math.max(p6 or 0, 0) * u1.AREA_AGE_GROWTH;

    return math.clamp(v7, u1.AREA_MIN, u1.AREA_MAX);
end;

function u1.Precise(p8) -- Line: 70
    -- upvalues: u1 (copy)
    return p8 <= u1.PRECISE_AREA;
end;

local function flat(p9) -- Line: 74
    return Vector3.new(p9.X, 0, p9.Z);
end;

function u1.ApproachGoal(p10, p11, p12) -- Line: 76
    -- upvalues: u1 (copy)
    if u1.Precise(p11) then
        return p10;
    end;

    local v13 = p12 - p10;
    local Vector3_new_ret = Vector3.new(v13.X, 0, v13.Z);

    if Vector3_new_ret.Magnitude < 1 then
        return p10;
    end;

    return p10 + Vector3_new_ret.Unit * math.min(p11 * 0.5, Vector3_new_ret.Magnitude);
end;

u1.SPRINT_MAX_AGE = 6;
u1.SPRINT_MIN_DIST = 25;

function u1.ShouldSprint(p14, p15, p16, p17) -- Line: 87
    -- upvalues: u1 (copy)
    local v18;

    if p17 == true and (p14 == "seen" and p15 <= u1.SPRINT_MAX_AGE) then
        v18 = u1.SPRINT_MIN_DIST <= p16;
    else
        v18 = false;
    end;

    return v18;
end;

u1.REDIRECT_DIST = 12;
u1.MAX_REDIRECTS = 3;
u1.MAX_FAILED_MOVES = 3;
u1.INSPECT_LOOK = 1;
u1.INSPECT_DIRS_PRECISE = 2;
u1.INSPECT_DIRS_VAGUE = 3;
u1.MOVE_TIMEOUT_BASE = 6;
u1.MOVE_TIMEOUT_SPEED = 6;
u1.SWEEP_STEP = 1;
local u19 = {};
u19.__index = u19;

function u1.New(p20, p21, p22, p23, p24) -- Line: 114
    -- upvalues: u19 (copy)
    local v25 = {
        phase = nil,
        listened = false,
        dirs = nil,
        lookAt = nil,
        moveDeadline = 0,
        world = p20,
        prof = p21,
        since = p22,
        startedAt = p22
    };
    local v26;

    if p23 then
        v26 = p23.pos or nil;
    else
        v26 = nil;
    end;

    v25.focus = v26;
    v25.infoAt = p23 and (p23.at or (-1 / 0)) or (-1 / 0);
    local v27;

    if p23 then
        v27 = p23.source or nil;
    else
        v27 = nil;
    end;

    v25.source = v27;
    v25.err = p23 and p23.err or 0;
    v25.checksLeft = p21.checks;
    v25.stats = {
        paths = 0,
        redirects = 0,
        rays = 0,
        phases = {},
        fails = {},
        npc = p24
    };
    local v28 = setmetatable(v25, u19);
    v28:enter("watch", p22);

    return v28;
end;

function u19.enter(p29, p30, p31) -- Line: 126
    -- upvalues: u1 (copy)
    p29.phase = p30;
    p29.since = p31;
    table.insert(p29.stats.phases, p30);

    if u1.trace then
        u1.trace(p29, p30, p31);
    end;
end;

function u19.radius(p32, p33) -- Line: 132
    -- upvalues: u1 (copy)
    return u1.Area(p32.err, p33 - p32.infoAt);
end;

function u19.watchPoint(p34, p35) -- Line: 136
    -- upvalues: u1 (copy)
    if not p34.focus then
        return nil;
    end;

    local v36 = p34:radius(p35);

    if u1.Precise(v36) then
        return p34.focus;
    end;

    local v37 = p34.focus - p34.world.pos();
    local Vector3_new_ret = Vector3.new(v37.X, 0, v37.Z);
    local v38 = Vector3_new_ret.Magnitude > 0.1 and Vector3.new(-Vector3_new_ret.Z, 0, Vector3_new_ret.X).Unit or Vector3.new(1, 0, 0);
    local v39 = math.floor((p35 - p34.startedAt) / u1.SWEEP_STEP) % 3;

    return p34.focus + v38 * (v36 * 0.5 * (v39 == 1 and 1 or (v39 == 2 and -1 or 0)));
end;

function u19.giveUp(p40, p41) -- Line: 147
    if p40.phase == "done" then
        return;
    end;

    p40.world.stop();
    p40:enter("giveup", p41);
    p40.phase = "done";
    p40.world.giveUp();
end;

function u19.outOfLeads(p42, p43) -- Line: 157
    -- upvalues: u1 (copy)
    if p43 - p42.startedAt >= p42.prof.duration * u1.MIN_SEARCH_FRAC then
        p42:giveUp(p43);

        return;
    end;

    p42.checksLeft = #p42.stats.fails <= u1.MAX_FAILED_MOVES and 1 or 0;
    p42.world.stop();
    p42:enter("listen", p43);
end;

function u19.startMove(p44, p45, p46, p47, p48) -- Line: 167
    -- upvalues: u1 (copy)
    p44.world.goTo(p45, p46);
    local stats = p44.stats;
    stats.paths = stats.paths + 1;
    local v49 = p48 + u1.MOVE_TIMEOUT_BASE;
    local v50 = p45 - p44.world.pos();
    p44.moveDeadline = v49 + Vector3.new(v50.X, 0, v50.Z).Magnitude / u1.MOVE_TIMEOUT_SPEED;
    p44:enter(p47, p48);
end;

function u19.startApproach(p51, p52) -- Line: 174
    -- upvalues: u1 (copy)
    local v53 = p51:radius(p52);
    local v54 = u1.ApproachGoal(p51.focus, v53, p51.world.pos());
    local v55;

    if p51.world.bold then
        v55 = p51.world.bold() or false;
    else
        v55 = false;
    end;

    local ShouldSprint = u1.ShouldSprint;
    local source = p51.source;
    local v56 = p52 - p51.infoAt;
    local v57 = v54 - p51.world.pos();
    p51:startMove(v54, ShouldSprint(source, v56, Vector3.new(v57.X, 0, v57.Z).Magnitude, v55), "approach", p52);
end;

function u19.startCheck(p58, p59) -- Line: 182
    p58.checksLeft = p58.checksLeft - 1;
    local v60 = p58.world.checkSpot(p58.focus, p58:radius(p59));

    if v60 then
        p58:startMove(v60, false, "check", p59);

        return;
    end;

    p58.checksLeft = 0;

    if p58.listened then
        p58:outOfLeads(p59);

        return;
    end;

    p58.world.stop();
    p58:enter("listen", p59);
end;

function u19.moveFailed(p61, p62, p63) -- Line: 194
    -- upvalues: u1 (copy)
    table.insert(p61.stats.fails, p63 or "?");

    if p61.phase == "check" and #p61.stats.fails <= u1.MAX_FAILED_MOVES then
        p61.checksLeft = p61.checksLeft + 1;
    end;

    if #p61.stats.fails > u1.MAX_FAILED_MOVES then
        p61.checksLeft = 0;
    end;

    if p61.checksLeft > 0 then
        p61:startCheck(p62);

        return;
    end;

    if p61.listened then
        p61:outOfLeads(p62);

        return;
    end;

    p61.world.stop();
    p61:enter("listen", p62);
end;

function u19.AllowsTacticMove(p64) -- Line: 213
    return p64.phase == "watch" and true or p64.phase == "hold";
end;

function u19.Moved(p65, p66) -- Line: 219
    if p65.phase == "done" then
        return;
    end;

    p65.dirs = nil;
    p65:enter("inspect", p66);
end;

function u19.Tick(p67, p68, p69) -- Line: 226
    -- upvalues: u1 (copy)
    if p67.phase == "done" then
        return;
    end;

    if p69 and (p69.pos and p69.at > p67.infoAt + 1e-6) then
        local v70 = p67.focus and ((p69.pos - p67.focus).Magnitude or (1 / 0)) or (1 / 0);
        local math_max_ret = math.max(u1.REDIRECT_DIST, p67:radius(p68));
        local source = p69.source;
        local v71 = p69.err or 0;
        p67.infoAt = p69.at;
        p67.source = source;
        p67.err = v71;

        if math_max_ret < v70 and (p67.phase ~= "watch" and p67.phase ~= "hold") then
            if p67.stats.redirects < u1.MAX_REDIRECTS then
                p67.focus = p69.pos;
                local stats = p67.stats;
                stats.redirects = stats.redirects + 1;
                p67:startApproach(p68);

                return;
            end;
        else
            p67.focus = p69.pos;
        end;
    end;

    if not p67.focus then
        p67:giveUp(p68);

        return;
    end;

    if p68 - p67.startedAt >= p67.prof.duration then
        p67:giveUp(p68);

        return;
    end;

    local world = p67.world;
    local phase = p67.phase;
    local v72 = p68 - p67.since;
    local v73 = world.squadRole();

    if phase == "watch" or phase == "hold" then
        p67.lookAt = p67:watchPoint(p68);
        world.face(p67.lookAt);

        if phase == "watch" and p67.prof.watch <= v72 then
            if v73 == "hold" then
                p67:enter("hold", p68);

                return;
            end;

            p67:startApproach(p68);

            return;
        end;

        if phase == "hold" and v73 == "search" then
            p67:startApproach(p68);
        end;
    elseif phase == "approach" or phase == "check" then
        p67.lookAt = p67.focus;
        local v74 = world.moveStatus();

        if v74 == "arrived" then
            p67.dirs = nil;
            p67:enter("inspect", p68);

            return p67:Tick(p68, nil);
        end;

        if v74 == "failed" or (v74 == "none" or p67.moveDeadline < p68) then
            p67:moveFailed(p68, p67.moveDeadline < p68 and "timeout" or v74);
        end;
    else
        if phase == "inspect" then
            if not p67.dirs then
                world.stop();
                p67.dirs = world.openDirections(u1.Precise(p67:radius(p68)) and u1.INSPECT_DIRS_PRECISE or u1.INSPECT_DIRS_VAGUE);

                if p67.focus then
                    local v75 = p67.focus - world.pos();

                    if Vector3.new(v75.X, 0, v75.Z).Magnitude > 3 then
                        table.insert(p67.dirs, 1, p67.focus);
                    end;
                end;
            end;

            local v76 = math.floor(v72 / u1.INSPECT_LOOK) + 1;

            if #p67.dirs < v76 then
                p67.listened = true;
                p67:enter("listen", p68);

                return;
            end;

            p67.lookAt = p67.dirs[v76];
            world.face(p67.lookAt);

            return;
        end;

        if phase == "listen" then
            p67.listened = true;
            p67.lookAt = p67:watchPoint(p68);
            world.face(p67.lookAt);

            if p67.prof.listen <= v72 then
                if p67.checksLeft > 0 then
                    p67:startCheck(p68);

                    return;
                end;

                p67:outOfLeads(p68);
            end;
        end;
    end;
end;

u1.INSPECT_RAYS = 8;
u1.INSPECT_RANGE = 40;
u1.INSPECT_LOOK_DIST = 20;

function u1.OpenDirections(p77, p78, p79, p80) -- Line: 309
    -- upvalues: u1 (copy), NpcSight (copy)
    local v81 = {};

    for i = 0, u1.INSPECT_RAYS - 1 do
        local v82 = i / u1.INSPECT_RAYS * 3.141592653589793 * 2;
        local math_cos_ret = math.cos(v82);
        local math_sin_ret = math.sin(v82);
        local Vector3_new_ret = Vector3.new(math_cos_ret, 0, math_sin_ret);
        local v83 = NpcSight.Cast(p77, Vector3_new_ret * u1.INSPECT_RANGE, p79);

        if p80 then
            p80.rays = p80.rays + 1;
        end;

        table.insert(v81, {
            dir = Vector3_new_ret,
            clear = v83 and (v83.Position - p77).Magnitude or u1.INSPECT_RANGE
        });
        local _ = i;
    end;

    table.sort(v81, function(p84, p85) -- Line: 318
        return p84.clear > p85.clear;
    end);
    local v86 = {};

    for _, v in ipairs(v81) do
        local v87 = v;
        local v88 = true;

        for _, v2 in ipairs(v86) do
            if v2.dir:Dot(v87.dir) > 0.5 then
                v88 = false;
                break;
            end;
        end;

        if v88 then
            local v89 = {
                dir = v87.dir,
                point = p77 + v87.dir * math.min(v87.clear, u1.INSPECT_LOOK_DIST)
            };
            table.insert(v86, v89);

            if p78 <= #v86 then
                break;
            end;
        end;
    end;

    local v90 = {};

    for i, v in ipairs(v86) do
        v90[i] = v.point;
    end;

    return v90;
end;

u1.CHECK_DIRS = 8;
u1.CHECK_MIN = 8;
u1.CHECK_MAX = 30;
u1.CHECK_MAX_STEP = 8;
u1.CHECK_TRIED_RADIUS = 6;

function u1.CheckSpot(p91, p92, u93, p94, p95, p96) -- Line: 345
    -- upvalues: u1 (copy), NpcSight (copy)
    local math_clamp_ret = math.clamp(p92 * 0.8, u1.CHECK_MIN, u1.CHECK_MAX);
    local v97 = {};
    local v98 = {};

    for i = 0, u1.CHECK_DIRS - 1 do
        local v99 = i / u1.CHECK_DIRS * 3.141592653589793 * 2 + 0.3;
        local v100 = math.cos(v99) * math_clamp_ret;
        local v101 = math.sin(v99) * math_clamp_ret;
        local v102 = p91 + Vector3.new(v100, 0, v101);
        local _ = i;
        local v103 = false;

        for _, v in ipairs(p94) do
            local v104 = v - v102;

            if Vector3.new(v104.X, 0, v104.Z).Magnitude < u1.CHECK_TRIED_RADIUS then
                v103 = true;
                break;
            end;
        end;

        if not v103 then
            local v105 = math.max(v102.Y, u93.Y) + 8;
            local v106 = workspace;
            local Vector3_new_ret = Vector3.new(v102.X, v105, v102.Z);
            local v107 = -(v105 - math.min(v102.Y, u93.Y) + 20);
            local v108 = v106:Raycast(Vector3_new_ret, Vector3.new(0, v107, 0), p95);

            if p96 then
                p96.rays = p96.rays + 1;
            end;

            if v108 then
                local v109 = v108.Position + Vector3.new(0, 3, 0);

                if math.abs(v109.Y - (u93.Y - 1.5)) <= u1.CHECK_MAX_STEP then
                    local v110 = NpcSight.Cast(u93, v109 + Vector3.new(0, 1.5, 0) - u93, p95);

                    if p96 then
                        p96.rays = p96.rays + 1;
                    end;

                    table.insert(v110 and v98 and v98 or v97, v109);
                end;
            end;
        end;
    end;

    if #v98 > 0 then
        v97 = v98 or v97;
    end;

    table.sort(v97, function(p111, p112) -- Line: 370
        -- upvalues: u93 (copy)
        local v113 = p111 - u93;
        local Magnitude = Vector3.new(v113.X, 0, v113.Z).Magnitude;
        local v114 = p112 - u93;

        return Magnitude < Vector3.new(v114.X, 0, v114.Z).Magnitude;
    end);
    local v115 = v97[1];

    if v115 then
        table.insert(p94, v115);
    end;

    return v115;
end;

u1.trace = nil;
local u116 = nil;

function u1.Enabled(p117) -- Line: 381
    -- upvalues: u116 (ref)
    if u116 == nil then
        local success, result = pcall(function() -- Line: 383
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.Search == true;
            else
                success = false;
            end;
        end;

        u116 = success;
    end;

    local v118 = u116 and p117.Enabled();

    return v118;
end;

function u1.SetEnabled(p119) -- Line: 391
    -- upvalues: u116 (ref)
    u116 = p119 == true;
end;

return u1;