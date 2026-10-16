-- Decompiled with Potassium's decompiler.

local NpcHearing = require(script.Parent:WaitForChild("NpcHearing"));
local u1 = {
    CLASS_POINTS = {
        pistol = 5,
        rifle = 7,
        marksman = 10,
        shotgun = 6,
        subsonic = 3
    },
    CLASS_RADIUS = {
        pistol = 4,
        rifle = 6,
        marksman = 8,
        shotgun = 5,
        subsonic = 3
    },
    NEAR_DIST = 1,
    EDGE_FRAC = 0.25,
    HIT_POINTS = 4,
    IMPACT_MULT = 0.6,
    MAX = 100,
    LIGHT = 5,
    MEDIUM = 35,
    HEAVY = 65,
    LIGHT_TIER = 1,
    MEDIUM_TIER = 2,
    HEAVY_TIER = 3,
    DECAY_DELAY = 1.5,
    DECAY_RATE = 10,
    HESITATE_SECONDS = 1.5,
    SHOOTER_BURST = 25,
    SHOOTER_RATE = 30,
    SAME_SHOT_GAP = 0.03,
    MAX_PATH = 1500,
    RANK_MULT = {
        Rookie = 1.12,
        Experienced = 1,
        Professional = 0.85,
        Veteran = 0.7,
        Expert = 0.6
    },
    FACTION_MULT = {
        Bandit = 1.15,
        Loner = 1,
        ClearSky = 1,
        Military = 0.8,
        Monolith = 0.5
    }
};

function u1.Points(p2, p3) -- Line: 81
    -- upvalues: u1 (copy)
    local v4 = u1.CLASS_POINTS[p2] or u1.CLASS_POINTS.rifle;
    local v5 = u1.CLASS_RADIUS[p2] or u1.CLASS_RADIUS.rifle;

    if v5 < p3 then
        return 0;
    end;

    if p3 <= u1.NEAR_DIST then
        return v4;
    end;

    return v4 * (1 - (1 - u1.EDGE_FRAC) * ((p3 - u1.NEAR_DIST) / (v5 - u1.NEAR_DIST)));
end;

function u1.Mult(p6, p7) -- Line: 90
    -- upvalues: u1 (copy)
    return (u1.RANK_MULT[p6 or ""] or 1) * (u1.FACTION_MULT[p7 or ""] or 1);
end;

local function npcMult(p8) -- Line: 96
    -- upvalues: u1 (copy)
    local Attribute = p8:GetAttribute("_SupResist");

    return u1.Mult(p8:GetAttribute("Rank"), p8:GetAttribute("Faction")) * (type(Attribute) == "number" and Attribute and Attribute or 1);
end;

function u1.TierOf(p9) -- Line: 101
    -- upvalues: u1 (copy)
    if u1.HEAVY <= p9 then
        return u1.HEAVY_TIER;
    end;

    if u1.MEDIUM <= p9 then
        return u1.MEDIUM_TIER;
    end;

    return u1.LIGHT > p9 and 0 or u1.LIGHT_TIER;
end;

function u1.NewMeter() -- Line: 108
    return {
        level = 0,
        at = 0
    };
end;

function u1.Level(p10, p11) -- Line: 112
    -- upvalues: u1 (copy)
    local v12 = p11 - p10.at;

    if v12 <= u1.DECAY_DELAY then
        return p10.level;
    end;

    return math.max(0, p10.level - (v12 - u1.DECAY_DELAY) * u1.DECAY_RATE);
end;

function u1.Add(p13, p14, p15) -- Line: 118
    -- upvalues: u1 (copy)
    local MAX = u1.MAX;
    local v16 = u1.Level(p13, p15) + p14;
    p13.level = math.min(MAX, v16);
    p13.at = p15;

    return p13.level;
end;

function u1.NewBudget() -- Line: 124
    -- upvalues: u1 (copy)
    return {
        at = (-1 / 0),
        left = u1.SHOOTER_BURST
    };
end;

function u1.Spend(p17, p18, p19) -- Line: 129
    -- upvalues: u1 (copy)
    p17.left = math.min(u1.SHOOTER_BURST, p17.left + (p19 - p17.at) * u1.SHOOTER_RATE);
    p17.at = p19;
    local math_min_ret = math.min(p18, p17.left);
    p17.left = p17.left - math_min_ret;

    return math_min_ret;
end;

function u1.SecondsUntilBelow(p20, p21, p22) -- Line: 138
    -- upvalues: u1 (copy)
    local v23 = u1.Level(p20, p21);

    return v23 < p22 and 0 or math.max(0, u1.DECAY_DELAY - (p21 - p20.at)) + (v23 - p22) / u1.DECAY_RATE;
end;

local u24 = setmetatable({}, {
    __mode = "k"
});

local function board(p25) -- Line: 148
    -- upvalues: u24 (copy), u1 (copy)
    local v26 = u24[p25];

    if not v26 then
        v26 = {
            lastAt = (-1 / 0),
            meter = u1.NewMeter(),
            shooters = setmetatable({}, {
                __mode = "k"
            })
        };
        u24[p25] = v26;
    end;

    return v26;
end;

function u1.Get(p27, p28) -- Line: 158
    -- upvalues: u24 (copy), u1 (copy)
    local v29 = u24[p27];

    if not v29 then
        return 0, 0;
    end;

    local v30 = u1.Level(v29.meter, p28);

    return v30, u1.TierOf(v30);
end;

function u1.Tier(p31, p32) -- Line: 165
    -- upvalues: u1 (copy)
    local _, v33 = u1.Get(p31, p32);

    return v33;
end;

function u1.Hesitating(p34, p35) -- Line: 171
    -- upvalues: u24 (copy), u1 (copy)
    local v36 = u24[p34];

    if not v36 then
        return false;
    end;

    local v37 = p35 - v36.lastAt;
    local HESITATE_SECONDS = u1.HESITATE_SECONDS;
    local Attribute = p34:GetAttribute("_SupResist");

    return v37 < HESITATE_SECONDS * (u1.Mult(p34:GetAttribute("Rank"), p34:GetAttribute("Faction")) * (type(Attribute) == "number" and Attribute and Attribute or 1));
end;

function u1.Suppress(p38, p39, p40) -- Line: 179
    -- upvalues: board (copy), u1 (copy)
    local v41 = board(p38);
    local Add = u1.Add;
    local meter = v41.meter;
    local Attribute = p38:GetAttribute("_SupResist");
    local v42 = Add(meter, p39 * (u1.Mult(p38:GetAttribute("Rank"), p38:GetAttribute("Faction")) * (type(Attribute) == "number" and Attribute and Attribute or 1)), p40);
    v41.lastAt = p40;

    if u1.LIGHT <= v42 then
        local v43 = p40 + u1.SecondsUntilBelow(v41.meter, p40, u1.LIGHT);
        local Attribute2 = p38:GetAttribute("_SuppressedUntil");

        if type(Attribute2) ~= "number" or Attribute2 < v43 then
            p38:SetAttribute("_SuppressedUntil", v43);
        end;
    end;

    if u1.trace then
        u1.trace(p38, v42, p39, p40);
    end;

    return v42;
end;

u1.counters = {};

function u1.Count(p44) -- Line: 195
    -- upvalues: u1 (copy)
    u1.counters[p44] = (u1.counters[p44] or 0) + 1;
end;

function u1.Release(p45) -- Line: 199
    -- upvalues: u24 (copy)
    u24[p45] = nil;
end;

function u1.CountBoards() -- Line: 204
    -- upvalues: u24 (copy)
    local v46 = 0;

    for _ in pairs(u24) do
        v46 = v46 + 1;
    end;

    return v46;
end;

local u47 = {};
local u48 = true;
local u49 = (-1 / 0);
local u50 = nil;
local OverlapParams_new_ret = OverlapParams.new();
OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
OverlapParams_new_ret.MaxParts = 64;

local function refreshHeads(p51, p52) -- Line: 221
    -- upvalues: u50 (ref), u48 (ref), u49 (ref), u47 (copy), OverlapParams_new_ret (copy)
    if u50 ~= p51 then
        u50 = p51;
        p51.ChildAdded:Connect(function() -- Line: 224
            -- upvalues: u48 (ref)
            u48 = true;
        end);
        p51.ChildRemoved:Connect(function() -- Line: 225
            -- upvalues: u48 (ref)
            u48 = true;
        end);
        u48 = true;
    end;

    if not u48 and p52 - u49 < 5 then
        return;
    end;

    table.clear(u47);

    for _, child in ipairs(p51:GetChildren()) do
        local Head = child:FindFirstChild("Head");

        if Head and Head:IsA("BasePart") then
            table.insert(u47, Head);
        end;
    end;

    OverlapParams_new_ret.FilterDescendantsInstances = u47;
    u48 = false;
    u49 = p52;
end;

function u1.OnBulletPath(p53, p54, p55, p56, p57, p58) -- Line: 240
    -- upvalues: u1 (copy), refreshHeads (copy), NpcHearing (copy), OverlapParams_new_ret (copy), board (copy)
    if not u1.Enabled() then
        return 0;
    end;

    if typeof(p53) ~= "Instance" or (typeof(p56) ~= "Vector3" or typeof(p57) ~= "Vector3") then
        return 0;
    end;

    local PlayerCharacters = workspace:FindFirstChild("PlayerCharacters");

    if PlayerCharacters then
        PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
    end;

    if not PlayerCharacters then
        return 0;
    end;

    local v59 = p57 - p56;
    local Magnitude = v59.Magnitude;

    if Magnitude < 0.5 then
        return 0;
    end;

    local v60 = v59 / Magnitude;
    local v61 = u1.MAX_PATH < Magnitude;

    if v61 then
        Magnitude = u1.MAX_PATH;
        p57 = p56 + v60 * Magnitude;
    end;

    local os_clock_ret = os.clock();
    refreshHeads(PlayerCharacters, os_clock_ret);
    local ClassOf = NpcHearing.ClassOf;
    local v62;

    if typeof(p55) == "Instance" then
        v62 = p55.Name or nil;
    else
        v62 = nil;
    end;

    local v63 = ClassOf(p54, v62, p53);
    local v64 = u1.CLASS_RADIUS[v63] or u1.CLASS_RADIUS.rifle;
    local CFrame_lookAt_ret = CFrame.lookAt(p56 + v60 * (Magnitude / 2), p57);
    local Vector3_new_ret = Vector3.new(v64 * 2 + 2, v64 * 2 + 2, Magnitude + v64 * 2);
    local v65 = 0;

    for _, v in ipairs(workspace:GetPartBoundsInBox(CFrame_lookAt_ret, Vector3_new_ret, OverlapParams_new_ret)) do
        local Parent = v.Parent;

        if Parent and (Parent ~= p53 and (Parent.Parent == PlayerCharacters and not Parent:GetAttribute("_Dormant"))) then
            local v66 = Parent:FindFirstChildOfClass("Humanoid");

            if v66 and (v66.Health > 0 and not NpcHearing.IsAlly(Parent, p53)) then
                local Position = v.Position;
                local v67 = (Position - p56):Dot(v60);

                if v67 > 0 then
                    local v68;

                    if typeof(p58) == "Instance" then
                        v68 = p58:IsDescendantOf(Parent);
                    else
                        v68 = false;
                    end;

                    local v69 = not (v68 or v61) and Magnitude <= v67;
                    local v70 = v68 and 0 or (Position - (p56 + v60 * math.min(v67, Magnitude))).Magnitude;
                    local v71 = u1.Points(v63, v70);

                    if v71 > 0 then
                        local v72 = board(Parent);
                        local v73 = v72.shooters[p53];

                        if not v73 then
                            v73 = {
                                lastAt = (-1 / 0),
                                budget = u1.NewBudget()
                            };
                            v72.shooters[p53] = v73;
                        end;

                        if os_clock_ret - v73.lastAt >= u1.SAME_SHOT_GAP then
                            v73.lastAt = os_clock_ret;

                            if v69 then
                                v71 = v71 * u1.IMPACT_MULT;
                            end;

                            if v68 then
                                v71 = v71 + u1.HIT_POINTS;
                            end;

                            u1.Suppress(Parent, u1.Spend(v73.budget, v71, os_clock_ret), os_clock_ret);
                            v65 = v65 + 1;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v65;
end;

u1.trace = nil;
local u74 = nil;

function u1.Enabled() -- Line: 302
    -- upvalues: u74 (ref)
    if u74 == nil then
        local success, result = pcall(function() -- Line: 304
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.Suppression == true;
            else
                success = false;
            end;
        end;

        u74 = success;
    end;

    return u74;
end;

function u1.SetEnabled(p75) -- Line: 312
    -- upvalues: u74 (ref)
    u74 = p75 == true;
end;

return u1;