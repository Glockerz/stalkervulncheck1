-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local NpcKnowledge = require(script.Parent:WaitForChild("NpcKnowledge"));
local NpcTelemetry = require(script.Parent:WaitForChild("NpcTelemetry"));
local NpcChatterLines = require(script.Parent:WaitForChild("NpcChatterLines"));
local StalkerNames = require(game:GetService("ReplicatedStorage"):WaitForChild("StalkerNames"));
local u1 = {
    RANGE = 250,
    SQUAD_RADIUS = 150,
    SQUAD_COOLDOWN = 15,
    NPC_COOLDOWN = 30,
    INTERRUPT_GAP = 1,
    PLAYER_GAP = 10,
    URGENT = 2,
    URGENT_PLAYER_GAP = 4,
    WHERE_STALE = 20,
    CLOSE = 25,
    HIGH = 12,
    NAME_TRIES = 8,
    ZONE_NEAR = 60,
    ZONE_RESCAN = 30,
    LINE_MEMORY = 6,
    RECENT_MAX = 40,
    CATEGORIES = {
        contact = {
            prio = 1,
            cooldown = 60,
            perTarget = true
        },
        ncontact = {
            prio = 1,
            cooldown = 60,
            perTarget = true,
            key = "contact"
        },
        ambush = {
            prio = 1,
            cooldown = 60,
            perTarget = true,
            key = "contact"
        },
        death = {
            prio = 2,
            cooldown = 15
        },
        deathBy = {
            prio = 2,
            cooldown = 15,
            key = "death"
        },
        pinned = {
            prio = 3,
            cooldown = 30
        },
        flee = {
            prio = 3,
            cooldown = 30
        },
        reload = {
            prio = 4,
            cooldown = 30,
            perTarget = true
        },
        heal = {
            prio = 4,
            cooldown = 30,
            perTarget = true
        },
        push = {
            prio = 5,
            cooldown = 40
        },
        flank = {
            prio = 5,
            cooldown = 40
        },
        cover = {
            prio = 5,
            cooldown = 40
        },
        supfire = {
            prio = 5,
            cooldown = 45
        },
        retreat = {
            prio = 5,
            cooldown = 40
        },
        search = {
            prio = 6,
            cooldown = 45,
            perTarget = true
        },
        giveup = {
            prio = 6,
            cooldown = 60,
            perTarget = true
        },
        found = {
            prio = 6,
            cooldown = 40,
            perTarget = true
        },
        heard = {
            prio = 6,
            cooldown = 90
        },
        mdistress = {
            prio = 1,
            cooldown = 120
        },
        mcasualty = {
            prio = 2,
            cooldown = 45
        },
        mclear = {
            prio = 5,
            cooldown = 120
        },
        mhurt = {
            prio = 6,
            cooldown = 40,
            gap = 4,
            personal = true
        }
    }
};
local u2 = 0;

for _, v in pairs(u1.CATEGORIES) do
    u2 = math.max(u2, v.cooldown);
end;

local u3 = { "north", "north-east", "east", "south-east", "south", "south-west", "west", "north-west" };
u1.trace = nil;

function u1.NewState() -- Line: 121
    return {
        recent = {},
        byNpc = setmetatable({}, {
            __mode = "k"
        })
    };
end;

function u1.Decide(p4, p5) -- Line: 127
    -- upvalues: u1 (copy), u2 (ref)
    local u6 = u1.CATEGORIES[p5.cat];

    if not u6 then
        return false, "unknown";
    end;

    local now = p5.now;
    local recent = p4.recent;

    for i = #recent, 1, -1 do
        local v7;

        if u2 < now - recent[i].at then
            table.remove(recent, i);
            v7 = i;
        else
            v7 = i;
        end;
    end;

    local v8 = u6.key or p5.cat;

    local function mayCut(p9, p10) -- Line: 137
        -- upvalues: u6 (copy), u1 (ref), now (copy)
        local v11;

        if u6.prio < p9 or u6.prio <= u1.URGENT then
            v11 = now - p10 >= u1.INTERRUPT_GAP;
        else
            v11 = false;
        end;

        return v11;
    end;

    for _, v in ipairs(recent) do
        if v.faction == p5.faction and ((v.pos - p5.pos).Magnitude <= u1.SQUAD_RADIUS and (v.key == v8 and (not u6.perTarget or v.target == p5.target))) and now - v.at < u6.cooldown then
            return false, "category";
        end;
    end;

    for _, v in ipairs(recent) do
        if not (u6.personal or (v.faction ~= p5.faction or ((v.pos - p5.pos).Magnitude > u1.SQUAD_RADIUS or now - v.at >= u1.SQUAD_COOLDOWN))) then
            local at = v.at;
            local v12;

            if u6.prio < v.prio or u6.prio <= u1.URGENT then
                v12 = now - at >= u1.INTERRUPT_GAP;
            else
                v12 = false;
            end;

            if not v12 then
                return false, "squad";
            end;
        end;
    end;

    local v13 = p4.byNpc[p5.npc];

    if v13 and now - v13.at < u1.NPC_COOLDOWN then
        if v13.key == v8 then
            return false, "npc";
        end;

        if not u6.personal then
            local at = v13.at;
            local v14;

            if u6.prio < v13.prio or u6.prio <= u1.URGENT then
                v14 = now - at >= u1.INTERRUPT_GAP;
            else
                v14 = false;
            end;

            if not v14 then
                return false, "npc";
            end;
        end;
    end;

    table.insert(recent, {
        faction = p5.faction,
        pos = p5.pos,
        key = v8,
        target = p5.target,
        at = now,
        prio = u6.prio
    });

    if #recent > u1.RECENT_MAX then
        table.remove(recent, 1);
    end;

    p4.byNpc[p5.npc] = {
        at = now,
        prio = u6.prio,
        key = v8
    };

    return true;
end;

function u1.PickLine(p15, u16, p17, p18, p19) -- Line: 172
    -- upvalues: u1 (copy)
    local v20 = {};
    local v21 = {};

    for _, v in ipairs(p15) do
        local v22 = v;
        local v23 = true;

        for i in v:gmatch("{(%a+)}") do
            if u16[i] == nil then
                v23 = false;
                break;
            end;
        end;

        if v23 then
            table.insert(v20, v22);
        end;
    end;

    local v24;

    if p19 and u16[p19] ~= nil then
        v24 = {};

        for _, v in ipairs(v20) do
            if v:find("{" .. p19 .. "}", 1, true) then
                table.insert(v24, v);
            end;
        end;

        if #v24 <= 0 then
            v24 = v20;
        end;
    else
        v24 = v20;
    end;

    for _, v in ipairs(v24) do
        if not table.find(p17, v) then
            table.insert(v21, v);
        end;
    end;

    if #v21 > 0 then
        v24 = v21 or v24;
    end;

    if #v24 == 0 then
        return nil;
    end;

    local v25 = (p18 or math.random)() * #v24;
    local v26 = v24[math.floor(v25) + 1];
    table.insert(p17, v26);

    if #p17 > u1.LINE_MEMORY then
        table.remove(p17, 1);
    end;

    return v26:gsub("{(%a+)}", function(p27) -- Line: 198
        -- upvalues: u16 (copy)
        return u16[p27];
    end);
end;

function u1.Where(p28, p29, p30) -- Line: 204
    -- upvalues: u1 (copy), u3 (copy)
    local v31 = {};

    if not (p29 and p29.knownPos) then
        return v31;
    end;

    if p30 and (p29.knownAt and p30 - p29.knownAt > u1.WHERE_STALE) then
        return v31;
    end;

    local v32 = p29.knownPos - p28;
    local Vector3_new_ret = Vector3.new(v32.X, 0, v32.Z);
    local Magnitude = Vector3_new_ret.Magnitude;
    local v33 = p29.knownSource == "seen";

    if Magnitude > 3 and (v33 or (p29.knownError or 0) <= math.max(15, Magnitude * 0.35)) then
        local math_atan2_ret = math.atan2(Vector3_new_ret.X, -Vector3_new_ret.Z);
        local v34 = ((math.deg(math_atan2_ret) + 360) % 360 + 22.5) / 45;
        v31.dir = u3[math.floor(v34) % 8 + 1];
    end;

    if v33 and Magnitude <= u1.CLOSE then
        v31.near = "";
    end;

    if v33 and v32.Y >= u1.HIGH then
        v31.high = "";
    end;

    return v31;
end;

function u1.ZoneEntry(p35) -- Line: 225
    local Attribute = p35:GetAttribute("LocationName");

    if type(Attribute) ~= "string" or Attribute == "" then
        Attribute = p35.Name;
    end;

    local v36 = Attribute:gsub("%s*%b()%s*$", "");
    local Attribute2 = p35:GetAttribute("RadioName");
    local v37 = {
        cf = p35.CFrame,
        size = p35.Size,
        name = v36
    };

    if type(Attribute2) ~= "string" or (Attribute2 == "" or not Attribute2) then
        Attribute2 = nil;
    end;

    v37.radio = Attribute2;

    return v37;
end;

function u1.ZoneName(p38, p39) -- Line: 235
    -- upvalues: u1 (copy)
    local ZONE_NEAR = u1.ZONE_NEAR;
    local v40 = nil;

    for _, v in ipairs(p39) do
        local v41 = v.cf:PointToObjectSpace(p38);
        local v42 = math.abs(v41.X) - v.size.X / 2;
        local math_max_ret = math.max(v42, 0);
        local v43 = math.abs(v41.Z) - v.size.Z / 2;
        local math_max_ret2 = math.max(v43, 0);
        local math_sqrt_ret = math.sqrt(math_max_ret * math_max_ret + math_max_ret2 * math_max_ret2);

        if math_sqrt_ret <= ZONE_NEAR then
            v40 = v;
            ZONE_NEAR = math_sqrt_ret;
        end;

        if math_sqrt_ret == 0 then
            break;
        end;
    end;

    if not v40 then
        return nil;
    end;

    if v40.radio then
        return v40.radio;
    end;

    if v40.name:lower():sub(1, 4) == "the " then
        return "the " .. v40.name:sub(5);
    end;

    return "the " .. v40.name;
end;

local u44 = {
    Loner = "a Loner",
    Bandit = "a bandit",
    Military = "a soldier",
    ClearSky = "Clear Sky",
    Monolith = "Monolith",
    Duty = "Duty",
    Freedom = "Freedom",
    Mercenaries = "a merc",
    Mercenary = "a merc"
};

function u1.EnemyWord(p45, p46, p47) -- Line: 257
    -- upvalues: u44 (copy)
    local v48 = p47 and p47:GetAttribute("Faction") or p45:GetAttribute("Faction");

    if v48 then
        v48 = u44[v48];
    end;

    return v48 or (p46 and "a stalker" or nil);
end;

local u49 = {
    Loner = "Loners",
    Bandit = "bandits",
    Military = "soldiers",
    ClearSky = "Clear Sky fighters",
    Monolith = "Monolith fighters",
    Duty = "Duty fighters",
    Freedom = "Freedom fighters",
    Mercenaries = "mercs"
};

function u1.GroupWord(p50) -- Line: 271
    -- upvalues: u49 (copy)
    return p50 and u49[p50] or nil;
end;

u1.AMBUSH_SECONDS = 6;

function u1.ContactCategory(p51, p52, p53, p54) -- Line: 281
    -- upvalues: u1 (copy)
    return (p52 or not u1.GroupWord(p51)) and "contact" or (p53 == p51 and (p54 and p54 <= u1.AMBUSH_SECONDS) and "ambush" or "ncontact");
end;

function u1.Side(p55, p56, p57) -- Line: 288
    local v58 = p56 - p55;
    local v59 = p57 - p55;

    return v58.Z * v59.X - v58.X * v59.Z < 0 and "right" or "left";
end;

local u60 = setmetatable({}, {
    __mode = "k"
});

function u1.Register(p61, p62) -- Line: 297
    -- upvalues: u60 (copy), u1 (copy), StalkerNames (copy)
    local Attribute = p61:GetAttribute("NpcName");
    local Attribute2 = p61:GetAttribute("ContractName");

    if type(Attribute) == "string" and (type(Attribute2) ~= "string" or Attribute2 == "") then
        local v63 = {};

        for i, v in pairs(u60) do
            local v64;

            if i == p61 then
                v64 = false;
            else
                v64 = v.Parent;

                if v64 then
                    if (v.Position - p62.Position).Magnitude <= u1.SQUAD_RADIUS then
                        v64 = i:GetAttribute("NpcName");
                    else
                        v64 = false;
                    end;
                end;
            end;

            if type(v64) == "string" then
                v63[v64:match("^(%S+)") or v64] = true;
            end;
        end;

        for i = 1, u1.NAME_TRIES do
            if not v63[Attribute:match("^(%S+)") or Attribute] then
                break;
            end;

            Attribute = StalkerNames.Random();
            local _ = i;
        end;

        p61:SetAttribute("NpcName", Attribute);
    end;

    u60[p61] = p62;
end;

function u1.Release(p65) -- Line: 315
    -- upvalues: u60 (copy)
    u60[p65] = nil;
end;

local function rootOf(p66) -- Line: 319
    -- upvalues: u60 (copy)
    local v67 = u60[p66];

    if v67 and v67.Parent then
        return v67;
    end;

    return p66:FindFirstChild("HumanoidRootPart");
end;

function u1.SpeakerName(p68) -- Line: 328
    local Attribute = p68:GetAttribute("ContractName");

    if type(Attribute) ~= "string" or Attribute == "" then
        Attribute = p68:GetAttribute("NpcName");
    end;

    if type(Attribute) ~= "string" or Attribute == "" then
        return nil;
    end;

    local v69 = Attribute:match("^(%S+)") or Attribute;

    if p68:GetAttribute("Faction") == "Monolith" then
        return "Brother " .. v69;
    end;

    return v69;
end;

function u1.TargetKey(p70, p71) -- Line: 341
    if p70 == nil then
        return nil;
    end;

    if p71 then
        return p70;
    end;

    local Attribute = p70:GetAttribute("Faction");

    if Attribute then
        p70 = "faction:" .. Attribute or p70;
    end;

    return p70;
end;

function u1.Free(p72, p73, p74, p75, p76) -- Line: 351
    -- upvalues: u1 (copy)
    local v77 = p76 or (p75 <= u1.URGENT and u1.URGENT_PLAYER_GAP or u1.PLAYER_GAP);
    local v78 = {};

    for _, v in ipairs(p72) do
        local v79 = p73[v.player];

        if not v79 or p74 - v79 >= v77 then
            table.insert(v78, v);
        end;
    end;

    return v78;
end;

function u1.StartsGap(p80) -- Line: 364
    -- upvalues: u1 (copy)
    local v81 = u1.CATEGORIES[p80];

    if v81 then
        v81 = v81.personal;
    end;

    return not v81;
end;

function u1.Listeners(p82, p83, p84) -- Line: 370
    -- upvalues: u1 (copy)
    local v85 = p84 or u1.RANGE;
    local v86 = {};

    for _, v in ipairs(p83) do
        if v.pos and (not v.muted and (v.pos - p82).Magnitude <= v85) then
            table.insert(v86, v);
        end;
    end;

    return v86;
end;

local u87 = nil;

function u1.Enabled() -- Line: 380
    -- upvalues: u87 (ref)
    if u87 == nil then
        local success, result = pcall(function() -- Line: 382
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.RadioChatter == true;
            else
                success = false;
            end;
        end;

        u87 = success;
    end;

    return u87;
end;

function u1.SetEnabled(p88) -- Line: 389
    -- upvalues: u87 (ref)
    u87 = p88 == true;
end;

local u89 = u1.NewState();
local u90 = {};
local u91 = setmetatable({}, {
    __mode = "k"
});
local u92 = nil;

function u1.ResetState() -- Line: 398
    -- upvalues: u89 (ref), u1 (copy), u90 (copy), u91 (copy)
    u89 = u1.NewState();
    table.clear(u90);
    table.clear(u91);
end;

local u93 = {};
local u94 = (-1 / 0);

local function liveZones(p95) -- Line: 405
    -- upvalues: u94 (ref), u1 (copy), u93 (ref)
    if p95 - u94 > u1.ZONE_RESCAN then
        u94 = p95;
        u93 = {};
        local LocationZones = workspace:FindFirstChild("LocationZones");

        if LocationZones then
            for _, child in ipairs(LocationZones:GetChildren()) do
                if child:IsA("BasePart") then
                    table.insert(u93, u1.ZoneEntry(child));
                end;
            end;
        end;
    end;

    return u93;
end;

local function escape(p96) -- Line: 419
    return p96:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
end;

local function listenersNear(p97, p98) -- Line: 423
    -- upvalues: Players (copy), u1 (copy)
    local v99 = {};

    for _, v in ipairs(Players:GetPlayers()) do
        local Character = v.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        local v100 = {
            player = v,
            pos = Character and Character.Position or nil,
            muted = v:GetAttribute("NpcRadioMuted") == true
        };
        table.insert(v99, v100);
    end;

    return u1.Listeners(p97, v99, p98);
end;

local u101 = {
    contact = true,
    ncontact = true,
    ambush = true,
    found = true,
    search = true,
    giveup = true,
    reload = true,
    heal = true,
    supfire = true,
    push = true,
    flank = true,
    heard = true
};

function u1.Event(p102, p103, p104, p105) -- Line: 446
    -- upvalues: u1 (copy), u101 (copy), NpcChatterLines (copy), u60 (copy), listenersNear (copy), u91 (copy), Players (copy), u89 (ref), NpcTelemetry (copy), NpcKnowledge (copy), liveZones (copy), u90 (copy), u92 (ref), ReplicatedStorage (copy)
    if not u1.Enabled() then
        return;
    end;

    if p104 and (u101[p103] and p104:GetAttribute("MutantType")) then
        return;
    end;

    local Attribute = p102:GetAttribute("Faction");
    local v106 = NpcChatterLines[Attribute] and NpcChatterLines[Attribute][p103];

    if not v106 then
        return;
    end;

    local v107 = p102:FindFirstChildOfClass("Humanoid");
    local v108 = u60[p102];

    if not (v108 and v108.Parent) then
        v108 = p102:FindFirstChild("HumanoidRootPart");
    end;

    if not (v108 and (v107 and v107.Health > 0)) then
        return;
    end;

    local v109;

    if p105 then
        v109 = p105.range;
    else
        v109 = p105;
    end;

    local v110 = listenersNear(v108.Position, v109);

    if #v110 == 0 then
        if u1.trace then
            u1.trace(p102, p103, nil, "unheard");
        end;

        return;
    end;

    local os_clock_ret = os.clock();
    local v111 = u1.Free(v110, u91, os_clock_ret, u1.CATEGORIES[p103] and (u1.CATEGORIES[p103].prio or 99) or 99, u1.CATEGORIES[p103] and u1.CATEGORIES[p103].gap);

    if #v111 == 0 then
        if u1.trace then
            u1.trace(p102, p103, nil, "busy");
        end;

        return false, "busy";
    end;

    local v112;

    if p104 then
        v112 = Players:GetPlayerFromCharacter(p104) or nil;
    else
        v112 = nil;
    end;

    local v113 = u1.TargetKey(p104, v112 ~= nil);
    local v114, v115 = u1.Decide(u89, {
        npc = p102,
        faction = Attribute,
        pos = v108.Position,
        cat = p103,
        target = v113,
        now = os_clock_ret
    });

    if not v114 then
        NpcTelemetry.Bump("radio.drop." .. v115);

        if u1.trace then
            u1.trace(p102, p103, nil, v115);
        end;

        return;
    end;

    local v116;

    if p104 then
        v116 = NpcKnowledge.Get(p102, p104, os_clock_ret) or nil;
    else
        v116 = nil;
    end;

    local v117 = u1.Where(v108.Position, v116, os_clock_ret);
    v117.zone = u1.ZoneName(v108.Position, (liveZones(os_clock_ret)));

    if v116 and v116.knownSource == "seen" then
        v117.enemy = u1.EnemyWord(p104, v112 ~= nil, v112);
    end;

    if p104 and not v112 then
        v117.group = u1.GroupWord(p104:GetAttribute("Faction"));
    end;

    if p105 then
        if p105.name then
            v117.name = p105.name;
        end;

        if p105.mate and p105.mate:GetAttribute("Faction") == Attribute then
            v117.name = u1.SpeakerName(p105.mate);
        end;

        if p105.spot and (v116 and v116.knownPos) then
            v117.side = u1.Side(v108.Position, v116.knownPos, p105.spot);
        end;

        if p105.tokens then
            for i, v in pairs(p105.tokens) do
                v117[i] = v;
            end;
        end;
    end;

    u90[Attribute] = u90[Attribute] or {};
    local v118 = u1.PickLine(v106, v117, u90[Attribute], nil, (p103 == "contact" or p103 == "mdistress") and "zone" or nil);
    local v119 = u1.SpeakerName(p102);

    if not (v118 and v119) then
        return;
    end;

    local v120 = u92 or ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("TraderChatMessage");
    u92 = v120;

    if u92 then
        local v121 = u1.StartsGap(p103);
        local v122 = 0;

        for _, v in ipairs(v111) do
            if v121 then
                u91[v.player] = os_clock_ret;
            end;

            u92:FireClient(v.player, "Radio" .. Attribute, v118, v119:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"), {
                npc = p102
            });
            v122 = v122 + 1;
        end;

        NpcTelemetry.Bump("radio.sent");
        NpcTelemetry.Bump("radio.cat." .. p103);

        if u1.trace then
            u1.trace(p102, p103, v118, v122);
        end;

        return v122 > 0;
    end;
end;

local u123 = nil;

function u1.Contact(p124, p125) -- Line: 518
    -- upvalues: u123 (ref), u1 (copy), Players (copy)
    if p125 then
        local Attribute = p124:GetAttribute("_LastHitAt");
        local v126, v127;

        if type(Attribute) == "number" then
            if u123 == nil then
                local NPCAttackerRegistry = game:GetService("ServerScriptService"):FindFirstChild("NPCAttackerRegistry");
                local success, result = pcall(function() -- Line: 525
                    -- upvalues: NPCAttackerRegistry (copy)
                    local v128 = NPCAttackerRegistry and require(NPCAttackerRegistry);

                    return v128;
                end);
                u123 = success and result and result or false;
            end;

            local v129;

            if u123 then
                v129 = u123.GetAttacker(p124) or nil;
            else
                v129 = nil;
            end;

            if typeof(v129) == "Instance" then
                v126 = v129:GetAttribute("Faction") or nil;
            else
                v126 = nil;
            end;

            v127 = os.clock() - Attribute;
        else
            v126 = nil;
            v127 = nil;
        end;

        local v130 = u1.ContactCategory(p125:GetAttribute("Faction"), Players:GetPlayerFromCharacter(p125) ~= nil, v126, v127);

        return u1.Event(p124, v130, p125);
    end;
end;

function u1.AllyDown(p131, p132) -- Line: 538
    -- upvalues: u1 (copy), u60 (copy), NpcChatterLines (copy), NpcKnowledge (copy)
    if not u1.Enabled() then
        return;
    end;

    local Attribute = p131:GetAttribute("Faction");
    local v133 = u60[p131];

    if not (v133 and v133.Parent) then
        v133 = p131:FindFirstChild("HumanoidRootPart");
    end;

    if not (Attribute and (NpcChatterLines[Attribute] and v133)) then
        return;
    end;

    local SQUAD_RADIUS = u1.SQUAD_RADIUS;
    local v134 = nil;

    for i, v in pairs(u60) do
        if i ~= p131 and (v.Parent and i:GetAttribute("Faction") == Attribute) then
            local Magnitude = (v.Position - v133.Position).Magnitude;
            local v135;

            if Magnitude <= SQUAD_RADIUS then
                v135 = i:FindFirstChildOfClass("Humanoid");
            else
                v135 = false;
            end;

            if v135 and v135.Health > 0 then
                v134 = i;
                SQUAD_RADIUS = Magnitude;
            end;
        end;
    end;

    if not v134 then
        return;
    end;

    local v136;

    if p132 == nil then
        v136 = false;
    else
        v136 = not p132:GetAttribute("MutantType") and NpcKnowledge.Get(v134, p132, os.clock()) ~= nil;
    end;

    u1.Event(v134, v136 and "deathBy" or "death", nil, {
        name = u1.SpeakerName(p131)
    });
end;

function u1.Heard(p137, p138) -- Line: 560
    -- upvalues: u1 (copy)
    local Target = p137:FindFirstChild("Target");

    if Target and Target.Value ~= nil then
        return;
    end;

    u1.Event(p137, "heard", p138);
end;

return u1;