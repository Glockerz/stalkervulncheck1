-- Decompiled with Potassium's decompiler.

local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local u1 = {
    CALM_HALF_ANGLE_DAY = 75,
    CALM_HALF_ANGLE_NIGHT = 55,
    ALERT_HALF_ANGLE = 110,
    CLOSE_AWARE = 3,
    CLOSE_AWARE_MULT = 2,
    RANK_REACTION = {
        Rookie = 0.9,
        Experienced = 0.7,
        Professional = 0.55,
        Veteran = 0.45,
        Expert = 0.35
    },
    DEFAULT_REACTION = 0.7,
    DIST_BASE = 0.6,
    DIST_PER = 0.02,
    DIST_MAX = 5,
    CENTER_DEG = 20,
    EDGE_MULT = 2.5,
    SPRINT_SPEED = 14.5,
    SPRINT_MULT = 0.6,
    WALK_SPEED = 2,
    WALK_MULT = 0.85,
    STILL_MULT = 1.15,
    PRONE_MULT = 1.75,
    CROUCH_MULT = 1.3,
    NIGHT_MULT = 1.6,
    ALERT_MULT = 0.5,
    NEAR_KNOWN_FULL = 3,
    NEAR_KNOWN_NONE = 25,
    NEAR_KNOWN_MULT = 0.15,
    MIN_REACTION = 0.05
};

local function flat(p2) -- Line: 70
    return Vector3.new(p2.X, 0, p2.Z);
end;

function u1.InCone(p3, p4, p5) -- Line: 73
    local Vector3_new_ret = Vector3.new(p3.X, 0, p3.Z);
    local Vector3_new_ret2 = Vector3.new(p4.X, 0, p4.Z);

    if Vector3_new_ret2.Magnitude < 0.001 then
        return true, 0;
    end;

    if Vector3_new_ret.Magnitude < 0.001 then
        return false, 180;
    end;

    local v6 = Vector3_new_ret.Unit:Dot(Vector3_new_ret2.Unit);
    local math_clamp_ret = math.clamp(v6, -1, 1);
    local math_acos_ret = math.acos(math_clamp_ret);
    local math_deg_ret = math.deg(math_acos_ret);

    return math_deg_ret <= p5, math_deg_ret;
end;

function u1.HalfAngle(p7, p8) -- Line: 81
    -- upvalues: u1 (copy)
    if p7 then
        return u1.ALERT_HALF_ANGLE;
    end;

    return u1.CALM_HALF_ANGLE_DAY + (u1.CALM_HALF_ANGLE_NIGHT - u1.CALM_HALF_ANGLE_DAY) * p8;
end;

function u1.Darkness(p9) -- Line: 88
    if p9 >= 6 and p9 < 19 then
        return 0;
    end;

    if p9 >= 22 or p9 < 5 then
        return 1;
    end;

    if p9 >= 19 then
        return (p9 - 19) / 3;
    end;

    return 1 - (p9 - 5);
end;

function u1.ReactionTime(p10) -- Line: 98
    -- upvalues: u1 (copy)
    local v11 = (u1.RANK_REACTION[p10.rank or ""] or u1.DEFAULT_REACTION) * math.clamp(u1.DIST_BASE + p10.dist * u1.DIST_PER, u1.DIST_BASE, u1.DIST_MAX);

    if p10.angle > u1.CENTER_DEG and p10.halfAngle > u1.CENTER_DEG then
        v11 = v11 * (1 + (u1.EDGE_MULT - 1) * math.min((p10.angle - u1.CENTER_DEG) / (p10.halfAngle - u1.CENTER_DEG), 1));
    end;

    local v12;

    if p10.speed > u1.SPRINT_SPEED then
        v12 = v11 * u1.SPRINT_MULT;
    elseif p10.speed > u1.WALK_SPEED then
        v12 = v11 * u1.WALK_MULT;
    else
        v12 = v11 * u1.STILL_MULT;
    end;

    if p10.prone then
        v12 = v12 * u1.PRONE_MULT;
    elseif p10.crouch then
        v12 = v12 * u1.CROUCH_MULT;
    end;

    local v13;

    if p10.alerted then
        v13 = v12 * u1.ALERT_MULT;

        if p10.distToKnown then
            local math_clamp_ret = math.clamp((p10.distToKnown - u1.NEAR_KNOWN_FULL) / (u1.NEAR_KNOWN_NONE - u1.NEAR_KNOWN_FULL), 0, 1);
            v13 = v13 * (u1.NEAR_KNOWN_MULT + (1 - u1.NEAR_KNOWN_MULT) * math_clamp_ret);
        end;
    else
        v13 = v12 * (1 + (u1.NIGHT_MULT - 1) * (p10.darkness or 0));
    end;

    return math.max(v13, u1.MIN_REACTION);
end;

local u14 = setmetatable({}, {
    __mode = "k"
});
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;

local function isProne(p15, p16, p17) -- Line: 131
    -- upvalues: u14 (copy), RaycastParams_new_ret (copy)
    local v18 = u14[p15];

    if v18 and p17 - v18.at < 0.5 then
        return v18.value;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = { p15 };
    local v19 = workspace:Raycast(p16.Position, Vector3.new(0, -6, 0), RaycastParams_new_ret);
    local v20;

    if v19 == nil then
        v20 = false;
    else
        v20 = p16.Position.Y - v19.Position.Y < 1.8;
    end;

    u14[p15] = {
        at = p17,
        value = v20
    };

    return v20;
end;

function u1.Sample(p21, p22, p23, p24, p25) -- Line: 144
    -- upvalues: u1 (copy), Lighting (copy), Players (copy), isProne (copy)
    local HumanoidRootPart = p21:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = p22:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart2) then
        return false, nil;
    end;

    local v26 = HumanoidRootPart2.Position - HumanoidRootPart.Position;
    local Magnitude = v26.Magnitude;
    local v27 = u1.Darkness(Lighting.ClockTime);
    local v28 = u1.HalfAngle(p23, v27);
    local LookVector = HumanoidRootPart.CFrame.LookVector;

    if p24 then
        local v29 = p24 - HumanoidRootPart.Position;

        if Vector3.new(v29.X, 0, v29.Z).Magnitude > 1 then
            LookVector = p24 - HumanoidRootPart.Position;
        end;
    end;

    local v30, v31 = u1.InCone(LookVector, v26, v28);
    local v32 = Magnitude <= u1.CLOSE_AWARE;

    if not (v30 or v32) then
        if u1.trace then
            u1.lastInfo = {
                close = false,
                center = LookVector,
                angle = v31,
                half = v28,
                dist = Magnitude,
                distToKnown = p24 and (HumanoidRootPart2.Position - p24).Magnitude or nil
            };
        end;

        return false, nil;
    end;

    local AssemblyLinearVelocity = HumanoidRootPart2.AssemblyLinearVelocity;
    local v33 = Players:GetPlayerFromCharacter(p22) ~= nil;
    local ReactionTime = u1.ReactionTime;
    local v34 = {
        rank = p21:GetAttribute("Rank"),
        dist = Magnitude,
        angle = v30 and v31 and v31 or v28,
        halfAngle = v28,
        speed = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude
    };
    local v35;

    if v33 then
        v35 = isProne(p22, HumanoidRootPart2, p25) or false;
    else
        v35 = false;
    end;

    v34.prone = v35;
    local v36 = not v33 and p22:GetAttribute("Stance") == "Crouch";
    v34.crouch = v36;
    v34.darkness = v27;
    v34.alerted = p23;
    local v37;

    if p24 then
        v37 = (HumanoidRootPart2.Position - p24).Magnitude or nil;
    else
        v37 = nil;
    end;

    v34.distToKnown = v37;
    local v38 = ReactionTime(v34);

    if v32 and not v30 then
        v38 = v38 * u1.CLOSE_AWARE_MULT;
    end;

    if u1.trace then
        local v39 = {
            center = LookVector,
            angle = v31,
            half = v28,
            dist = Magnitude
        };

        if v32 then
            v32 = not v30;
        end;

        v39.close = v32;
        v39.distToKnown = p24 and (HumanoidRootPart2.Position - p24).Magnitude or nil;
        v39.reaction = v38;
        u1.lastInfo = v39;
    end;

    return true, v38;
end;

u1.trace = nil;
u1.lastInfo = nil;
local u40 = nil;

function u1.Enabled(p41) -- Line: 198
    -- upvalues: u40 (ref)
    if u40 == nil then
        local success, result = pcall(function() -- Line: 200
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.FieldOfView == true;
            else
                success = false;
            end;
        end;

        u40 = success;
    end;

    local v42 = u40 and p41.Enabled();

    return v42;
end;

function u1.SetEnabled(p43) -- Line: 208
    -- upvalues: u40 (ref)
    u40 = p43 == true;
end;

return u1;