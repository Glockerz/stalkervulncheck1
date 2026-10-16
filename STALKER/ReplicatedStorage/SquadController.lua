-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local SquadRemotes = ReplicatedStorage:WaitForChild("SquadRemotes");
local u1 = {
    _squad = nil,
    _listeners = {},
    _invite = nil,
    _inviteListeners = {},
    _initialized = false
};

local function broadcast() -- Line: 15
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1._listeners) do
        task.spawn(v, u1._squad);
    end;
end;

local function broadcastInvite() -- Line: 20
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1._inviteListeners) do
        task.spawn(v, u1._invite);
    end;
end;

function u1.GetSquad(p2) -- Line: 26
    return p2._squad;
end;

function u1.IsLeader(p3) -- Line: 29
    -- upvalues: LocalPlayer (copy)
    return p3._squad and p3._squad.leader_id == LocalPlayer.UserId;
end;

function u1.IsInSquad(p4) -- Line: 32
    return p4._squad ~= nil;
end;

function u1.GetMemberIds(p5) -- Line: 35
    if not p5._squad then
        return {};
    end;

    local v6 = {};

    for i in pairs(p5._squad.members) do
        table.insert(v6, i);
    end;

    return v6;
end;

function u1.GetMembersInSamePlace(p7) -- Line: 43
    if not p7._squad then
        return {};
    end;

    local v8 = {};

    for i, v in pairs(p7._squad.members) do
        if v.current_place == game.PlaceId then
            table.insert(v8, i);
        end;
    end;

    return v8;
end;

function u1.OnChanged(p9, p10) -- Line: 53
    table.insert(p9._listeners, p10);
    task.spawn(p10, p9._squad);
end;

function u1.GetPendingInvite(p11) -- Line: 57
    return p11._invite;
end;

function u1.OnInviteChanged(p12, p13) -- Line: 60
    table.insert(p12._inviteListeners, p13);
    task.spawn(p13, p12._invite);
end;

function u1.Invite(p14, p15) -- Line: 66
    -- upvalues: SquadRemotes (copy)
    return SquadRemotes.Invite:InvokeServer(p15);
end;

function u1.AcceptInvite(p16) -- Line: 69
    -- upvalues: SquadRemotes (copy), broadcastInvite (copy)
    if not p16._invite then
        return {
            ok = false,
            error = "no_invite"
        };
    end;

    local v17 = SquadRemotes.AcceptInvite:InvokeServer(p16._invite.squadId);

    if v17 and v17.ok then
        p16._invite = nil;
        broadcastInvite();
    end;

    return v17;
end;

function u1.DeclineInvite(p18) -- Line: 79
    -- upvalues: SquadRemotes (copy), broadcastInvite (copy)
    if not p18._invite then
        return;
    end;

    SquadRemotes.DeclineInvite:FireServer();
    p18._invite = nil;
    broadcastInvite();
end;

function u1.Leave(p19) -- Line: 85
    -- upvalues: SquadRemotes (copy)
    return SquadRemotes.Leave:InvokeServer();
end;

function u1.Kick(p20, p21) -- Line: 88
    -- upvalues: SquadRemotes (copy)
    return SquadRemotes.Kick:InvokeServer(p21);
end;

function u1.Init(u22) -- Line: 92
    -- upvalues: SquadRemotes (copy), broadcast (copy), u1 (copy), broadcastInvite (copy), LocalPlayer (copy)
    if u22._initialized then
        return;
    end;

    u22._initialized = true;
    SquadRemotes.OnSquadUpdated.OnClientEvent:Connect(function(p23) -- Line: 96
        -- upvalues: u22 (copy), broadcast (ref), u1 (ref)
        if p23 and p23._cleared then
            u22._squad = nil;
            broadcast();

            if p23._toast and u1._toastFn then
                u1._toastFn(p23.text);
            end;
        elseif p23 and p23._toast then
            if u1._toastFn then
                u1._toastFn(p23.text);
            end;
        else
            u22._squad = p23;
            broadcast();
        end;
    end);
    SquadRemotes.OnInviteOffered.OnClientEvent:Connect(function(p24) -- Line: 113
        -- upvalues: u22 (copy), broadcastInvite (ref)
        u22._invite = {
            squadId = p24.id,
            squadIdRaw = p24.id,
            fromName = p24.fromName or (p24.leaderName or "Someone"),
            leaderName = p24.leaderName,
            memberCount = p24.memberCount,
            maxMembers = p24.maxMembers,
            expires_at = os.time() + 60
        };
        broadcastInvite();
        local _invite = u22._invite;
        task.delay(60, function() -- Line: 126
            -- upvalues: u22 (ref), _invite (copy), broadcastInvite (ref)
            if u22._invite == _invite then
                u22._invite = nil;
                broadcastInvite();
            end;
        end);
    end);
    SquadRemotes.OnMemberPlaceChanged.OnClientEvent:Connect(function(p25, p26) -- Line: 134
        -- upvalues: u22 (copy), broadcast (ref)
        if u22._squad and u22._squad.members[p25] then
            u22._squad.members[p25].current_place = p26;
            broadcast();
        end;
    end);
    task.spawn(function() -- Line: 142
        -- upvalues: SquadRemotes (ref), u22 (copy), broadcast (ref)
        local v27 = SquadRemotes.RequestSquadState:InvokeServer();

        if v27 then
            u22._squad = v27.squad;
            broadcast();
        end;
    end);
    task.spawn(function() -- Line: 151
        -- upvalues: SquadRemotes (ref), u22 (copy), broadcast (ref)
        while true do
            task.wait(60);
            pcall(function() -- Line: 154
                -- upvalues: SquadRemotes (ref), u22 (ref), broadcast (ref)
                local v28 = SquadRemotes.RequestSquadState:InvokeServer();

                if v28 then
                    u22._squad = v28.squad;
                    broadcast();
                end;
            end);
        end;
    end);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 165
        -- upvalues: SquadRemotes (ref), u22 (copy), broadcast (ref)
        task.spawn(function() -- Line: 166
            -- upvalues: SquadRemotes (ref), u22 (ref), broadcast (ref)
            local v29 = SquadRemotes.RequestSquadState:InvokeServer();

            if v29 then
                u22._squad = v29.squad;
                broadcast();
            end;
        end);
    end);
end;

function u1.SetToastHandler(p30, p31) -- Line: 177
    -- upvalues: u1 (copy)
    u1._toastFn = p31;
end;

function u1.ShowToast(p32, p33) -- Line: 181
    -- upvalues: u1 (copy)
    if u1._toastFn then
        u1._toastFn(p33);
    end;
end;

return u1;