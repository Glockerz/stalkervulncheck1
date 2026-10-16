-- Decompiled with Potassium's decompiler.

local NpcRadioChatter = require(script.Parent:WaitForChild("NpcRadioChatter"));
local NpcMutants = require(script.Parent:WaitForChild("NpcMutants"));
local NpcTelemetry = require(script.Parent:WaitForChild("NpcTelemetry"));
local u1 = {
    DISTRESS_RANGE = 600,
    ENCOUNTER_RADIUS = 60,
    MERGE_RADIUS = 120,
    CLEAR_QUIET = 15,
    CLEAR_CHANCE = 0.6,
    MAX_AGE = 300,
    CHECK_EVERY = 3,
    PACK_SIZE = 3,
    DANGEROUS_PAIR = 2,
    BADLY_HURT = 0.4,
    HURT_MIN_FRACTION = 0.1
};

function u1.HurtWorthSaying(p2, p3, p4) -- Line: 43
    -- upvalues: u1 (copy)
    local v5;

    if (p4 or 0) > 0 then
        v5 = (p2 or 0) >= (p3 or 100) * u1.HURT_MIN_FRACTION;
    else
        v5 = false;
    end;

    return v5;
end;

u1.HURT_RETRY_SECONDS = 4.5;

function u1.RetryHurtAfter(p6, p7) -- Line: 52
    -- upvalues: u1 (copy)
    if p6 == "busy" and not p7 then
        return u1.HURT_RETRY_SECONDS;
    end;

    return nil;
end;

local u8 = {
    blinddog = "that dog",
    boar = "that boar",
    flesh = "that flesh"
};

function u1.Beast(p9) -- Line: 59
    -- upvalues: u8 (copy)
    return p9 and u8[p9] or nil;
end;

function u1.Meaningful(p10) -- Line: 64
    -- upvalues: u1 (copy)
    return (p10.casualties or 0) > 0 and true or ((p10.mutants or 0) >= u1.PACK_SIZE and true or ((p10.dangerous or 0) >= u1.DANGEROUS_PAIR and true or ((p10.mutants or 0) >= 2 and (p10.mutants or 0) >= (p10.humans or 0) and true or (p10.worstHealth or 1) <= u1.BADLY_HURT)));
end;

local u11 = {
    blinddog = { "a blind dog", "a pack of blind dogs" },
    boar = { "a boar", "boars" },
    flesh = { "a flesh", "flesh" }
};

function u1.Beasts(p12) -- Line: 75
    -- upvalues: u11 (copy)
    local v13 = 0;
    local v14 = nil;
    local v15 = 0;

    for i, v in pairs(p12) do
        if v > 0 then
            v13 = v13 + 1;
            v15 = v;
            v14 = i;
        end;
    end;

    return (v13 ~= 1 or not u11[v14]) and "mutants" or (v15 >= 2 and u11[v14][2] or u11[v14][1]);
end;

local u16 = nil;

function u1.Enabled() -- Line: 85
    -- upvalues: u16 (ref), NpcRadioChatter (copy)
    if u16 == nil then
        local success, result = pcall(function() -- Line: 87
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.MutantDistress == true;
            else
                success = false;
            end;
        end;

        u16 = success;
    end;

    local v17 = u16 and NpcRadioChatter.Enabled();

    return v17;
end;

function u1.SetEnabled(p18) -- Line: 94
    -- upvalues: u16 (ref)
    u16 = p18 == true;
end;

local u19 = {};
u1.trace = nil;

local function rootOf(p20) -- Line: 99
    if p20 then
        p20 = p20:FindFirstChild("HumanoidRootPart");
    end;

    return p20;
end;

local function squadNear(p21, p22, p23) -- Line: 101
    local v24 = {};
    local PlayerCharacters = workspace:FindFirstChild("PlayerCharacters");

    if PlayerCharacters then
        PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
    end;

    if not PlayerCharacters then
        return v24;
    end;

    for _, child in ipairs(PlayerCharacters:GetChildren()) do
        if child:GetAttribute("Faction") == p21 then
            local v25;

            if child then
                v25 = child:FindFirstChild("HumanoidRootPart");
            else
                v25 = child;
            end;

            local v26 = child:FindFirstChildOfClass("Humanoid");

            if v25 and (v26 and (v26.Health > 0 and (v25.Position - p22).Magnitude <= p23)) then
                table.insert(v24, child);
            end;
        end;
    end;

    return v24;
end;

local function encounterFor(p27, p28, p29) -- Line: 115
    -- upvalues: u19 (copy), u1 (copy), NpcTelemetry (copy)
    local Attribute = p27:GetAttribute("Faction");

    if not Attribute then
        return nil;
    end;

    for _, v in ipairs(u19) do
        if v.faction == Attribute and (v.pos - p28).Magnitude <= u1.MERGE_RADIUS then
            return v;
        end;
    end;

    local v30 = {
        casualties = 0,
        distressAt = nil,
        casualtyCalls = 0,
        faction = Attribute,
        pos = p28,
        startedAt = p29,
        lastAt = p29,
        types = {},
        seen = setmetatable({}, {
            __mode = "k"
        })
    };
    table.insert(u19, v30);
    NpcTelemetry.Bump("distress.encounter");

    if u1.trace then
        u1.trace("open", v30);
    end;

    return v30;
end;

local function noteMutant(p31, p32) -- Line: 129
    if p32 and not p31.seen[p32] then
        p31.seen[p32] = true;
        local v33 = p32:GetAttribute("MutantType") or "mutant";
        p31.types[v33] = (p31.types[v33] or 0) + 1;
    end;
end;

local function snapshot(p34, p35, p36) -- Line: 137
    -- upvalues: squadNear (copy), u1 (copy), NpcMutants (copy)
    local v37 = squadNear(p34.faction, p35, u1.ENCOUNTER_RADIUS);
    local v38 = 0;
    local v39 = 0;

    for _, v in ipairs(NpcMutants.Live()) do
        if v.model:GetAttribute("Aggro") == true and (v.hrp.Position - p35).Magnitude <= u1.ENCOUNTER_RADIUS then
            v38 = v38 + 1;

            if v.type == "blinddog" or v.type == "boar" then
                v39 = v39 + 1;
            end;

            local model = v.model;

            if model and not p34.seen[model] then
                p34.seen[model] = true;
                local v40 = model:GetAttribute("MutantType") or "mutant";
                p34.types[v40] = (p34.types[v40] or 0) + 1;
            end;
        end;
    end;

    local v41 = 1;

    for _, v in ipairs(v37) do
        local v42 = v:FindFirstChildOfClass("Humanoid");

        if v42 and v42.MaxHealth > 0 then
            v41 = math.min(v41, v42.Health / v42.MaxHealth);
        end;
    end;

    return {
        mutants = v38,
        dangerous = v39,
        humans = #v37,
        worstHealth = v41,
        casualties = p34.casualties
    }, v37;
end;

local function speakerFor(p43, p44) -- Line: 156
    if p44 then
        local v45 = p44:FindFirstChildOfClass("Humanoid");

        if v45 and (v45.Health > 0 and p44.Parent) then
            return p44;
        end;
    end;

    return p43[1];
end;

local function say(p46, p47, p48, p49) -- Line: 164
    -- upvalues: u1 (copy), NpcRadioChatter (copy), NpcTelemetry (copy)
    if not p47 then
        return false;
    end;

    local v50 = p49 or {};
    v50.range = u1.DISTRESS_RANGE;
    v50.tokens = v50.tokens or {};
    v50.tokens.beasts = u1.Beasts(p46.types);
    local v51 = NpcRadioChatter.Event(p47, p48, nil, v50) == true;

    if v51 then
        NpcTelemetry.Bump("distress." .. p48);
    end;

    if u1.trace then
        u1.trace(p48, p46, v51);
    end;

    return v51;
end;

function u1.OnMutantHit(u52, p53, p54) -- Line: 177
    -- upvalues: u1 (copy), encounterFor (copy), snapshot (copy), say (copy), NpcRadioChatter (copy), NpcTelemetry (copy)
    if not u1.Enabled() then
        return;
    end;

    local v55;

    if u52 then
        v55 = u52:FindFirstChild("HumanoidRootPart");
    else
        v55 = u52;
    end;

    if not v55 then
        return;
    end;

    local os_clock_ret = os.clock();
    local u56 = encounterFor(u52, v55.Position, os_clock_ret);

    if not u56 then
        return;
    end;

    local Position = v55.Position;
    u56.lastAt = os_clock_ret;
    u56.pos = Position;

    if p53 and not u56.seen[p53] then
        u56.seen[p53] = true;
        local v57 = p53:GetAttribute("MutantType") or "mutant";
        u56.types[v57] = (u56.types[v57] or 0) + 1;
    end;

    if not u56.distressAt then
        local v58, v59 = snapshot(u56, v55.Position, u52);

        if u1.Meaningful(v58) then
            local v60;

            if u52 then
                local v61 = u52:FindFirstChildOfClass("Humanoid");

                if v61 and (v61.Health > 0 and u52.Parent) then
                    v60 = u52;
                else
                    v60 = v59[1];
                end;
            else
                v60 = v59[1];
            end;

            if say(u56, v60, "mdistress") then
                u56.distressAt = os_clock_ret;
            end;
        end;
    end;

    local v62 = u52:FindFirstChildOfClass("Humanoid");

    if v62 and u1.HurtWorthSaying(p54, v62.MaxHealth, v62.Health) then
        local u63 = {};
        local v64 = {};
        local Beast = u1.Beast;

        if p53 then
            p53 = p53:GetAttribute("MutantType");
        end;

        v64.beast = Beast(p53);
        u63.tokens = v64;
        local v65, v66 = NpcRadioChatter.Event(u52, "mhurt", nil, u63);
        local v67 = v65 == true;

        if v67 then
            NpcTelemetry.Bump("distress.mhurt");
        end;

        if u1.trace then
            u1.trace("mhurt", u56, v67);
        end;

        local v68 = not v67 and u1.RetryHurtAfter(v66, u56.hurtRetry);

        if v68 then
            u56.hurtRetry = true;
            task.delay(v68, function() -- Line: 202
                -- upvalues: u56 (copy), u52 (copy), NpcRadioChatter (ref), u63 (copy), NpcTelemetry (ref), u1 (ref)
                u56.hurtRetry = false;
                local v69 = u52.Parent and u52:FindFirstChildOfClass("Humanoid");

                if not v69 or v69.Health <= 0 then
                    return;
                end;

                local v70 = NpcRadioChatter.Event(u52, "mhurt", nil, u63) == true;

                if v70 then
                    NpcTelemetry.Bump("distress.mhurt");
                end;

                if u1.trace then
                    u1.trace("mhurt retry", u56, v70);
                end;
            end);
        end;
    end;
end;

function u1.OnNpcKilled(p71, p72) -- Line: 215
    -- upvalues: u1 (copy), encounterFor (copy), snapshot (copy), say (copy), NpcRadioChatter (copy)
    if not u1.Enabled() then
        return;
    end;

    local v73;

    if p71 then
        v73 = p71:FindFirstChild("HumanoidRootPart");
    else
        v73 = p71;
    end;

    if not v73 then
        return;
    end;

    local os_clock_ret = os.clock();
    local v74 = encounterFor(p71, v73.Position, os_clock_ret);

    if not v74 then
        return;
    end;

    v74.lastAt = os_clock_ret;
    v74.casualties = v74.casualties + 1;

    if p72 and not v74.seen[p72] then
        v74.seen[p72] = true;
        local v75 = p72:GetAttribute("MutantType") or "mutant";
        v74.types[v75] = (v74.types[v75] or 0) + 1;
    end;

    local v76, v77 = snapshot(v74, v73.Position, nil);
    local v78 = v77[1];

    if v74.distressAt then
        if v74.casualtyCalls < 2 and say(v74, v78, "mcasualty", {
            name = NpcRadioChatter.SpeakerName(p71)
        }) then
            v74.casualtyCalls = v74.casualtyCalls + 1;
        end;
    elseif u1.Meaningful(v76) and say(v74, v78, "mdistress") then
        v74.distressAt = os_clock_ret;
    end;
end;

local function check(p79) -- Line: 235
    -- upvalues: u19 (copy), u1 (copy), NpcMutants (copy), squadNear (copy), say (copy), NpcTelemetry (copy)
    for i = #u19, 1, -1 do
        local v80 = u19[i];
        local v81;

        if p79 - v80.lastAt >= u1.CLEAR_QUIET then
            v81 = NpcMutants.CountAggroNear(v80.pos, u1.ENCOUNTER_RADIUS, p79) == 0;
        else
            v81 = false;
        end;

        local v82;

        if v81 or p79 - v80.startedAt > u1.MAX_AGE then
            table.remove(u19, i);
            local v83 = squadNear(v80.faction, v80.pos, u1.ENCOUNTER_RADIUS * 1.5);

            if v81 and (v80.distressAt and (#v83 > 0 and math.random() < u1.CLEAR_CHANCE)) then
                say(v80, v83[1], "mclear");
            end;

            NpcTelemetry.Bump(#v83 == 0 and "distress.wiped" or "distress.ended");

            if u1.trace then
                u1.trace("close", v80, #v83);
                v82 = i;
            else
                v82 = i;
            end;
        else
            v82 = i;
        end;
    end;
end;

function u1.Open() -- Line: 251
    -- upvalues: u19 (copy)
    return u19;
end;

function u1.Reset() -- Line: 252
    -- upvalues: u19 (copy)
    table.clear(u19);
end;

local RunService = game:GetService("RunService");

if RunService:IsServer() and RunService:IsRunning() then
    task.spawn(function() -- Line: 256
        -- upvalues: u1 (copy), u19 (copy), check (copy)
        while true do
            repeat
                task.wait(u1.CHECK_EVERY);
            until #u19 > 0;

            pcall(check, os.clock());
        end;
    end);
end;

return u1;