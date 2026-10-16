-- Decompiled with Potassium's decompiler.

local NpcSight = require(game:GetService("ReplicatedStorage"):WaitForChild("NpcSight"));
local u1 = {
    ROOT_HEIGHT = 3,
    CROUCH_CHEST = -0.5,
    STAND_HEAD = 1.4,
    LEAN_OFFSET = 0.9,
    COVER_NEAR = 6,
    MAX_STEP = 6,
    MAX_RAYS = 60,
    RINGS = { 6, 12, 18, 25 },
    RING_STEPS = 8,
    RELOAD_RADIUS = 15,
    RETREAT_GAIN = 8,
    PUSH_GAIN = 8,
    FLEE_RINGS = { 30, 45, 60 },
    FLEE_GAIN = 15,
    FLANK_ANGLES = { 60, 75, 90, 105, 120 },
    FLANK_MAX_RADIUS = 50,
    PUSH_MIN_GAP = 8,
    WALK_SAMPLES = 4
};

local function flat(p2) -- Line: 50
    return Vector3.new(p2.X, 0, p2.Z);
end;

local function sightParams(p3) -- Line: 52
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = p3;

    return RaycastParams_new_ret;
end;

function u1.IsCovered(p4, p5, p6) -- Line: 60
    -- upvalues: u1 (copy), NpcSight (copy)
    local v7 = p4 + Vector3.new(0, u1.CROUCH_CHEST, 0);
    local Cast = NpcSight.Cast;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = p6;
    local v8 = Cast(p5, v7 - p5, RaycastParams_new_ret);
    local v9;

    if v8 == nil then
        v9 = false;
    else
        v9 = (v8.Position - v7).Magnitude <= u1.COVER_NEAR;
    end;

    return v9;
end;

function u1.Find(p10) -- Line: 66
    -- upvalues: NpcSight (copy), u1 (copy)
    local u11 = 0;
    local from = p10.from;
    local threat = p10.threat;
    local mode = p10.mode;
    local exclude = p10.exclude;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = exclude;
    local RaycastParams_new_ret2 = RaycastParams.new();
    RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret2.FilterDescendantsInstances = p10.exclude;
    RaycastParams_new_ret2.RespectCanCollide = true;

    local function cast(p12, p13) -- Line: 74
        -- upvalues: u11 (ref), RaycastParams_new_ret2 (copy)
        u11 = u11 + 1;

        return workspace:Raycast(p12, p13, RaycastParams_new_ret2);
    end;

    local function look(p14, p15) -- Line: 78
        -- upvalues: u11 (ref), NpcSight (ref), RaycastParams_new_ret (copy)
        u11 = u11 + 1;

        return NpcSight.Cast(p14, p15, RaycastParams_new_ret);
    end;

    local v16 = from - threat;
    local Magnitude = Vector3.new(v16.X, 0, v16.Z).Magnitude;
    local v17 = {};

    if mode == "Flank" then
        local v18 = from - threat;
        local Vector3_new_ret = Vector3.new(v18.X, 0, v18.Z);
        local v19 = Vector3_new_ret.Magnitude > 0.01 and Vector3_new_ret.Unit or Vector3.new(1, 0, 0);
        local math_min_ret = math.min(Magnitude, u1.FLANK_MAX_RADIUS);
        local math_max_ret = math.max(math_min_ret, p10.tooClose + u1.PUSH_MIN_GAP);

        for _, v in ipairs(u1.FLANK_ANGLES) do
            local v20 = v;

            for _, v2 in ipairs({ 1, -1 }) do
                local v21 = CFrame.Angles(0, math.rad(v20 * v2), 0):VectorToWorldSpace(v19);
                local v22 = Vector3.new(threat.X, from.Y, threat.Z) + v21 * math_max_ret;
                table.insert(v17, v22);
            end;
        end;
    else
        for _, v in ipairs(mode == "Flee" and u1.FLEE_RINGS or u1.RINGS) do
            if mode == "CoverReload" and u1.RELOAD_RADIUS < v then
                break;
            end;

            local v23 = v;

            for i = 0, u1.RING_STEPS - 1 do
                local v24 = i / u1.RING_STEPS * 3.141592653589793 * 2;
                local v25 = math.cos(v24) * v23;
                local v26 = math.sin(v24) * v23;
                local v27 = from + Vector3.new(v25, 0, v26);
                table.insert(v17, v27);
                local _ = i;
            end;
        end;
    end;

    local v28 = {};

    for _, v in ipairs(v17) do
        local v29 = v - threat;
        local Magnitude2 = Vector3.new(v29.X, 0, v29.Z).Magnitude;
        local v30 = v - from;
        local Magnitude3 = Vector3.new(v30.X, 0, v30.Z).Magnitude;
        local v31 = true;

        if mode == "Retreat" then
            v31 = Magnitude + u1.RETREAT_GAIN <= Magnitude2;
        elseif mode == "Push" then
            if Magnitude2 <= Magnitude - u1.PUSH_GAIN then
                v31 = p10.tooClose + u1.PUSH_MIN_GAP <= Magnitude2;
            else
                v31 = false;
            end;

            Magnitude3 = Magnitude2;
        elseif mode == "Flee" then
            v31 = Magnitude + u1.FLEE_GAIN <= Magnitude2;
            Magnitude3 = -Magnitude2;
        elseif mode == "Hold" then
            Magnitude3 = math.abs(Magnitude2 - p10.preferredDist) + 0.5 * Magnitude3;
        end;

        if v31 then
            table.insert(v28, {
                pos = v,
                score = Magnitude3
            });
        end;
    end;

    table.sort(v28, function(p32, p33) -- Line: 124
        return p32.score < p33.score;
    end);

    for _, v in ipairs(v28) do
        if u1.MAX_RAYS <= u11 then
            break;
        end;

        local pos = v.pos;
        local v34 = math.max(from.Y, pos.Y) + 8;
        local Vector3_new_ret = Vector3.new(pos.X, v34, pos.Z);
        local v35 = -(v34 - math.min(from.Y, pos.Y) + 20);
        local Vector3_new_ret2 = Vector3.new(0, v35, 0);
        u11 = u11 + 1;
        local v36 = workspace:Raycast(Vector3_new_ret, Vector3_new_ret2, RaycastParams_new_ret2);

        if v36 then
            local v37 = v36.Position + Vector3.new(0, u1.ROOT_HEIGHT, 0);

            if math.abs(v37.Y - from.Y) <= u1.MAX_STEP and not p10.isClaimed(v37) then
                local v38 = v37 + Vector3.new(0, u1.CROUCH_CHEST, 0);
                u11 = u11 + 1;
                local v39 = NpcSight.Cast(threat, v38 - threat, RaycastParams_new_ret);

                if v39 and (v39.Position - v38).Magnitude <= u1.COVER_NEAR then
                    local v40 = v37 + Vector3.new(0, u1.STAND_HEAD, 0);
                    local v41, v42, v43, v44, v45;

                    if mode == "Flee" then
                        u11 = u11 + 1;

                        if NpcSight.Cast(threat, v40 - threat, RaycastParams_new_ret) ~= nil then
                            v41 = v37 - from;
                            u11 = u11 + 1;

                            if not workspace:Raycast(from, v41, RaycastParams_new_ret2) then
                                v42 = true;

                                for i = 1, u1.WALK_SAMPLES do
                                    v43 = from + (v37 - from) * (i / (u1.WALK_SAMPLES + 1));
                                    v44 = Vector3.new(0, -(u1.ROOT_HEIGHT + u1.MAX_STEP + 1), 0);
                                    u11 = u11 + 1;

                                    if not workspace:Raycast(v43, v44, RaycastParams_new_ret2) then
                                        v42 = false;
                                        break;
                                    end;

                                    v45 = i;
                                end;

                                if v42 and not p10.isCrowded(v37) then
                                    return v37, u11;
                                end;
                            end;
                        end;
                    else
                        local v46 = threat - v37;
                        local Vector3_new_ret3 = Vector3.new(v46.X, 0, v46.Z);
                        local v47 = Vector3_new_ret3.Magnitude > 0.01 and Vector3.new(-Vector3_new_ret3.Z, 0, Vector3_new_ret3.X).Unit or Vector3.new(1, 0, 0);
                        local v48 = false;

                        for _, v2 in ipairs({ Vector3.new(0, 0, 0), v47 * u1.LEAN_OFFSET, -v47 * u1.LEAN_OFFSET }) do
                            local v49 = v40 + v2;
                            u11 = u11 + 1;

                            if NpcSight.Cast(v49, threat - v49, RaycastParams_new_ret) == nil then
                                v48 = true;
                                break;
                            end;
                        end;

                        if v48 then
                            v41 = v37 - from;
                            u11 = u11 + 1;

                            if not workspace:Raycast(from, v41, RaycastParams_new_ret2) then
                                v42 = true;

                                for i = 1, u1.WALK_SAMPLES do
                                    v43 = from + (v37 - from) * (i / (u1.WALK_SAMPLES + 1));
                                    v44 = Vector3.new(0, -(u1.ROOT_HEIGHT + u1.MAX_STEP + 1), 0);
                                    u11 = u11 + 1;

                                    if not workspace:Raycast(v43, v44, RaycastParams_new_ret2) then
                                        v42 = false;
                                        break;
                                    end;

                                    v45 = i;
                                end;

                                if v42 and not p10.isCrowded(v37) then
                                    return v37, u11;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return nil, u11;
end;

return u1;