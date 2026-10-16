-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"));
local PdaController = require(ReplicatedStorage:WaitForChild("PdaController"));
local PdaTransitPage = require(ReplicatedStorage:WaitForChild("PdaTransitPage"));
local ServerRegistryRules = require(ReplicatedStorage:WaitForChild("ServerRegistryRules"));
local StoryRules = require(ReplicatedStorage:WaitForChild("StoryRules"));
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    swamps = {
        title = "GREAT SWAMPS",
        subtitle = "A flooded wasteland. Rot, radiation, and opportunity in equal measure.",
        art = ""
    },
    cordon = {
        title = "CORDON",
        subtitle = "Rookie country. Warehouses, the checkpoint, and the road south.",
        art = ""
    }
};
local v2 = {
    _initialized = false,
    _open = false,
    _destId = nil,
    _access = "open",
    _ready = {},
    _countdown = nil,
    _notice = nil,
    _view = nil,
    _servers = {},
    _pick = nil,
    _leaderPick = nil,
    _filter = "",
    _myGroup = nil,
    _fetchToken = 0,
    _suppressedArea = nil,
    _currentArea = nil,
    _openedArea = nil,
    _warnedArea = nil,
    OnTransit = nil,
    OnCancel = nil,
    OnReadyChanged = nil,
    OnCancelCountdown = nil,
    OnFetchServers = nil,
    OnPickChanged = nil
};

local function orderedMembers() -- Line: 101
    -- upvalues: SquadController (copy), LocalPlayer (copy)
    local Squad = SquadController:GetSquad();

    if not (Squad and Squad.members) then
        return {
            {
                isLeader = true,
                isMe = true,
                userId = LocalPlayer.UserId,
                name = LocalPlayer.DisplayName
            }
        };
    end;

    local v3 = tonumber(Squad.leader_id) or Squad.leader_id;
    local v4 = {};

    for i, v in pairs(Squad.members) do
        local v5 = tonumber(i) or i;
        local v6;

        if v then
            v6 = v.current_place;
        else
            v6 = v;
        end;

        if (v5 == LocalPlayer.UserId or v6 == nil) and true or v6 == game.PlaceId then
            table.insert(v4, {
                userId = v5,
                name = v and (v.display_name or "Stalker") or "Stalker",
                isLeader = v5 == v3,
                isMe = v5 == LocalPlayer.UserId,
                joinedAt = v and v.joined_at or 0
            });
        end;
    end;

    table.sort(v4, function(p7, p8) -- Line: 122
        if p7.isLeader ~= p8.isLeader then
            return p7.isLeader;
        end;

        if p7.joinedAt == p8.joinedAt then
            return tostring(p7.userId) < tostring(p8.userId);
        end;

        return p7.joinedAt < p8.joinedAt;
    end);

    return v4;
end;

local function isLeader() -- Line: 131
    -- upvalues: SquadController (copy)
    return not SquadController:IsInSquad() and true or (SquadController:IsLeader() and true or false);
end;

function v2.GetState(p9) -- Line: 136
    -- upvalues: orderedMembers (copy), LocalPlayer (copy), Players (copy), u1 (copy), SquadController (copy), StoryRules (copy)
    local v10 = orderedMembers();
    local v11 = LocalPlayer;

    for _, v in ipairs(v10) do
        if v.isLeader then
            v11 = Players:GetPlayerByUserId(v.userId) or LocalPlayer;
            break;
        end;
    end;

    local v12 = 0;

    for _, v in ipairs(v10) do
        v.ready = p9._ready[v.userId] == true;

        if v.ready then
            v12 = v12 + 1;
        end;
    end;

    local v13 = {
        slots = 4,
        destination = u1[p9._destId],
        destId = p9._destId,
        members = v10,
        isLeader = not SquadController:IsInSquad() and true or (SquadController:IsLeader() and true or false),
        readyCount = v12,
        access = p9._access,
        servers = p9:_visibleServers(),
        pick = (not SquadController:IsInSquad() and true or (SquadController:IsLeader() and true or false)) and p9._pick or p9._leaderPick,
        filter = p9._filter,
        countdown = p9._countdown,
        notice = p9._notice
    };
    local v14;

    if p9._destId == "swamps" then
        v14 = not StoryRules.PadAllowed(LocalPlayer:GetAttribute("_TutorialComplete"), v11:GetAttribute(StoryRules.ACCESS_ATTR), v11:GetAttribute(StoryRules.FOUND_ATTR));
    else
        v14 = false;
    end;

    v13.locked = v14;

    return v13;
end;

function v2._visibleServers(p15) -- Line: 176
    -- upvalues: ServerRegistryRules (copy)
    local v16 = ServerRegistryRules.Sort(p15._servers, p15._myGroup);
    local string_upper_ret = string.upper(p15._filter or "");

    if string_upper_ret == "" then
        return v16;
    end;

    local v17 = {};

    for _, v in ipairs(v16) do
        if string.find(string.upper(v.code), string_upper_ret, 1, true) then
            table.insert(v17, v);
        end;
    end;

    return v17;
end;

function v2.SelectServer(p18, p19) -- Line: 187
    -- upvalues: SquadController (copy)
    if SquadController:IsInSquad() and not SquadController:IsLeader() or p18._countdown then
        return;
    end;

    p18._pick = p19;

    if p18.OnPickChanged then
        task.spawn(p18.OnPickChanged, p19);
    end;

    p18:_render();
end;

function v2._announcePick(p20) -- Line: 197
    -- upvalues: SquadController (copy)
    if not ((not SquadController:IsInSquad() or SquadController:IsLeader()) and p20.OnPickChanged) then
        return;
    end;

    local v21;

    if p20._access == "open" then
        v21 = p20._pick or nil;
    else
        v21 = nil;
    end;

    task.spawn(p20.OnPickChanged, v21);
end;

function v2.SetFilter(p22, p23) -- Line: 202
    p22._filter = type(p23) == "string" and (p23:sub(1, 8) or "") or "";
    p22:_render();
end;

function v2.SetLeaderPick(p24, p25, p26) -- Line: 208
    -- upvalues: SquadController (copy)
    local Squad = SquadController:GetSquad();

    if Squad then
        Squad = tonumber(Squad.leader_id) or Squad.leader_id;
    end;

    if Squad ~= p25 then
        return;
    end;

    p24._leaderPick = type(p26) == "string" and p26 and p26 or nil;
    p24:_render();
end;

function v2._startServerRefresh(u27) -- Line: 217
    u27._fetchToken = u27._fetchToken + 1;
    local _fetchToken = u27._fetchToken;
    task.spawn(function() -- Line: 220
        -- upvalues: u27 (copy), _fetchToken (copy)
        while u27._open and u27._fetchToken == _fetchToken do
            if u27.OnFetchServers and u27._access == "open" then
                local success, result = pcall(u27.OnFetchServers, u27._destId);

                if u27._fetchToken ~= _fetchToken then
                    return;
                end;

                if success and type(result) == "table" then
                    u27._servers = result;
                    u27:_render();
                end;
            end;

            task.wait(10);
        end;
    end);
end;

function v2._render(p28) -- Line: 235
    if p28._view then
        p28._view.Render(p28:GetState());
    end;
end;

function v2.PrimaryPressed(p29) -- Line: 239
    -- upvalues: SquadController (copy), LocalPlayer (copy)
    if p29:GetState().locked then
        return;
    end;

    if p29._countdown then
        if (not SquadController:IsInSquad() and true or (SquadController:IsLeader() and true or false)) and p29.OnCancelCountdown then
            task.spawn(p29.OnCancelCountdown);
        end;

        return;
    end;

    p29._notice = nil;

    if not SquadController:IsInSquad() and true or (SquadController:IsLeader() and true or false) then
        local State = p29:GetState();

        if State.readyCount < #State.members then
            return;
        end;

        if p29.OnTransit then
            local task_spawn = task.spawn;
            local OnTransit = p29.OnTransit;
            local v30 = {
                destination = p29._destId,
                access = p29._access
            };
            local v31;

            if p29._access == "open" then
                v31 = p29._pick or nil;
            else
                v31 = nil;
            end;

            v30.server = v31;
            task_spawn(OnTransit, v30);
        end;
    else
        local UserId = LocalPlayer.UserId;
        local v32 = not p29._ready[UserId];
        p29._ready[UserId] = v32 or nil;

        if p29.OnReadyChanged then
            task.spawn(p29.OnReadyChanged, v32);
        end;
    end;

    p29:_render();
end;

function v2.SetAccess(p33, p34, p35) -- Line: 265
    -- upvalues: SquadController (copy)
    if p34 ~= "open" and p34 ~= "private" then
        return;
    end;

    if p35 and (SquadController:IsInSquad() and not SquadController:IsLeader() or p33._countdown) then
        return;
    end;

    local _access = p33._access;
    p33._access = p34;

    if p34 == "open" and (_access ~= "open" and p33._open) then
        p33:_startServerRefresh();
    end;

    if p35 then
        p33:_announcePick();
    end;

    p33:_render();
end;

function v2.SetReady(p36, p37, p38) -- Line: 276
    p36._ready[p37] = p38 and true or nil;
    p36:_render();
end;

function v2.SetCountdown(p39, p40) -- Line: 282
    if type(p40) ~= "table" then
        return;
    end;

    if p40.state == "start" and type(p40.endsAt) == "number" then
        p39._countdown = {
            endsAt = p40.endsAt
        };
        p39._notice = nil;
    elseif p40.state == "cancel" then
        p39._countdown = nil;
        p39._notice = type(p40.text) == "string" and (p40.text or "Transit cancelled.") or "Transit cancelled.";
    elseif p40.state == "done" then
        p39._countdown = nil;
        p39._notice = "Moving out. This can take up to a minute.";
    end;

    p39:_render();
end;

function v2.IsOpen(p41) -- Line: 297
    return p41._open;
end;

function v2.Open(u42, p43) -- Line: 301
    -- upvalues: SquadController (copy), LocalPlayer (copy), PdaController (copy), PdaTransitPage (copy)
    local v44 = u42._destId ~= p43 and true or not u42._open;

    if v44 then
        u42._servers = {};
        u42._pick = nil;
        u42._leaderPick = nil;
        u42._filter = "";
    end;

    u42._destId = p43;
    u42._notice = nil;

    if not SquadController:IsInSquad() and true or (SquadController:IsLeader() and true or false) then
        u42._ready[LocalPlayer.UserId] = true;
    end;

    if u42._open then
        u42:_render();

        return;
    end;

    u42._open = true;
    u42:_startServerRefresh();

    if v44 then
        if not SquadController:IsInSquad() and true or (SquadController:IsLeader() and true or false) then
            u42:_announcePick();
        elseif u42.OnReadyChanged then
            task.spawn(u42.OnReadyChanged, u42._ready[LocalPlayer.UserId] == true);
        end;
    end;

    task.spawn(function() -- Line: 321
        -- upvalues: PdaController (ref), PdaTransitPage (ref), u42 (copy)
        PdaController:ShowTakeover(function(p45) -- Line: 322
            -- upvalues: PdaTransitPage (ref), u42 (ref)
            local u46 = PdaTransitPage.Build(p45, u42);
            u42._view = u46;
            p45.Destroying:Connect(function() -- Line: 325
                -- upvalues: u42 (ref), u46 (copy)
                if u42._view == u46 then
                    u42._view = nil;
                end;
            end);
            u42:_render();
        end);
    end);
end;

function v2._withdraw(p47) -- Line: 338
    -- upvalues: SquadController (copy), LocalPlayer (copy)
    local v48 = p47._countdown ~= nil;
    p47._countdown = nil;

    if not SquadController:IsInSquad() and true or (SquadController:IsLeader() and true or false) then
        if v48 and p47.OnCancelCountdown then
            task.spawn(p47.OnCancelCountdown);
        end;
    elseif p47._ready[LocalPlayer.UserId] then
        p47._ready[LocalPlayer.UserId] = nil;

        if p47.OnReadyChanged then
            task.spawn(p47.OnReadyChanged, false);
        end;
    end;
end;

function v2.Close(p49) -- Line: 349
    -- upvalues: PdaController (copy)
    if not p49._open then
        return;
    end;

    p49._open = false;
    p49._openedArea = nil;
    p49:_withdraw();
    PdaController:HideTakeover();
end;

function v2._dismiss(p50) -- Line: 358
    p50._suppressedArea = p50._currentArea;
    p50._open = false;
    p50._openedArea = nil;
    p50:_withdraw();
end;

local function insideArea(p51, p52) -- Line: 366
    local v53 = p51.CFrame:PointToObjectSpace(p52);
    local v54 = p51.Size * 0.5;
    local v55;

    if math.abs(v53.X) <= v54.X and math.abs(v53.Y) <= v54.Y + 6 then
        v55 = math.abs(v53.Z) <= v54.Z;
    else
        v55 = false;
    end;

    return v55;
end;

function v2._poll(p56) -- Line: 374
    -- upvalues: LocalPlayer (copy), CollectionService (copy), u1 (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        if p56._open then
            p56:Close();
        end;

        p56._currentArea = nil;
        p56._suppressedArea = nil;

        return;
    end;

    local v57 = nil;
    local v58 = nil;

    for _, v in ipairs(CollectionService:GetTagged("TransitArea")) do
        if v:IsA("BasePart") then
            local v59 = v.CFrame:PointToObjectSpace(Character.Position);
            local v60 = v.Size * 0.5;
            local v61;

            if math.abs(v59.X) <= v60.X and math.abs(v59.Y) <= v60.Y + 6 then
                v61 = math.abs(v59.Z) <= v60.Z;
            else
                v61 = false;
            end;

            if v61 then
                v58 = v:GetAttribute("Destination");
                v57 = v;
                break;
            end;
        end;
    end;

    p56._currentArea = v57;

    if v57 == nil then
        p56._suppressedArea = nil;
        p56._warnedArea = nil;

        if p56._open then
            p56:Close();
        end;

        return;
    end;

    if p56._suppressedArea == v57 then
        return;
    end;

    if p56._open and p56._openedArea == v57 then
        return;
    end;

    if type(v58) ~= "string" or u1[v58] == nil then
        if p56._warnedArea ~= v57 then
            p56._warnedArea = v57;
            warn(string.format("[TransitController] %s is tagged %s but %s is %q; expected one of: swamps, cordon", v57:GetFullName(), "TransitArea", "Destination", (tostring(v58))));
        end;

        return;
    end;

    p56._openedArea = v57;
    p56:Open(v58);
end;

function v2.Init(u62) -- Line: 417
    -- upvalues: PdaController (copy), LocalPlayer (copy), ServerRegistryRules (copy), SquadController (copy), CollectionService (copy), RunService (copy)
    if u62._initialized then
        return;
    end;

    u62._initialized = true;

    function PdaController.OnTakeoverDismissed() -- Line: 421
        -- upvalues: u62 (copy)
        u62:_dismiss();
    end;

    task.spawn(function() -- Line: 424
        -- upvalues: LocalPlayer (ref), u62 (copy), ServerRegistryRules (ref)
        local success, result = pcall(function() -- Line: 425
            -- upvalues: LocalPlayer (ref)
            return game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(LocalPlayer);
        end);

        if success then
            u62._myGroup = ServerRegistryRules.GroupForCountry(result);
        end;
    end);
    SquadController:OnChanged(function() -- Line: 430
        -- upvalues: u62 (copy)
        u62:_render();
    end);

    if #CollectionService:GetTagged("TransitArea") == 0 then
        print(string.format(
            "[TransitController] no parts tagged %s in this place. Tag a part and give it a %s attribute (\"swamps\") to open the screen.",
            "TransitArea",
            "Destination"
        ));
    end;

    local u63 = 0;
    RunService.Heartbeat:Connect(function(p64) -- Line: 438
        -- upvalues: u63 (ref), u62 (copy)
        u63 = u63 + p64;

        if u63 < 0.25 then
            return;
        end;

        u63 = 0;
        local success, result = pcall(function() -- Line: 442
            -- upvalues: u62 (ref)
            u62:_poll();
        end);

        if not success then
            warn("[TransitController] area poll failed: " .. tostring(result));
        end;
    end);
end;

return v2;