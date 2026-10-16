-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SocialService = game:GetService("SocialService");
local LocalPlayer = Players.LocalPlayer;
local ContactRemotes = ReplicatedStorage:WaitForChild("ContactRemotes");
local u1 = {
    _record = {
        schema_version = 1,
        contacts = {}
    },
    _listeners = {},
    _canInvite = false,
    _initialized = false
};

local function broadcast() -- Line: 15
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1._listeners) do
        task.spawn(v, u1._record);
    end;
end;

function u1.GetRecord(p2) -- Line: 21
    return p2._record;
end;

function u1.GetContacts(p3, p4) -- Line: 25
    local v5 = {};

    for _, v in pairs(p3._record.contacts) do
        if not p4 or v.type == p4 then
            table.insert(v5, v);
        end;
    end;

    table.sort(v5, function(p6, p7) -- Line: 33
        return (p6.lastSeenAt or p6.lastInteractedAt or (p6.addedAt or 0)) > (p7.lastSeenAt or p7.lastInteractedAt or (p7.addedAt or 0));
    end);

    return v5;
end;

function u1.GetContact(p8, p9) -- Line: 41
    return p8._record.contacts[p9];
end;

function u1.OnChanged(p10, p11) -- Line: 45
    table.insert(p10._listeners, p11);
    task.spawn(p11, p10._record);
end;

function u1.CanInviteFriends(p12) -- Line: 50
    return p12._canInvite;
end;

function u1.SetToastHandler(p13, p14) -- Line: 54
    p13._toastFn = p14;
end;

function u1.PromptInviteFriends(p15) -- Line: 58
    -- upvalues: SocialService (copy), LocalPlayer (copy)
    if not p15._canInvite then
        return;
    end;

    local success, result = pcall(function() -- Line: 60
        -- upvalues: SocialService (ref), LocalPlayer (ref)
        SocialService:PromptGameInvite(LocalPlayer);
    end);

    if not success then
        warn("[ContactController] PromptGameInvite failed: " .. tostring(result));
    end;
end;

local function refreshCanInvite() -- Line: 68
    -- upvalues: SocialService (copy), LocalPlayer (copy), u1 (copy)
    local success, result = pcall(function() -- Line: 69
        -- upvalues: SocialService (ref), LocalPlayer (ref)
        return SocialService:CanSendGameInviteAsync(LocalPlayer);
    end);

    if success then
        u1._canInvite = result and true or false;
    end;
end;

function u1.Init(u16) -- Line: 77
    -- upvalues: ContactRemotes (copy), broadcast (copy), SocialService (copy), LocalPlayer (copy), u1 (copy)
    if u16._initialized then
        return;
    end;

    u16._initialized = true;
    task.spawn(function() -- Line: 82
        -- upvalues: ContactRemotes (ref), u16 (copy), broadcast (ref)
        local success, result = pcall(function() -- Line: 83
            -- upvalues: ContactRemotes (ref)
            return ContactRemotes.RequestContactList:InvokeServer();
        end);

        if success and result then
            u16._record = result;
            broadcast();
        end;
    end);
    ContactRemotes.OnContactsUpdated.OnClientEvent:Connect(function(p17) -- Line: 93
        -- upvalues: u16 (copy), broadcast (ref)
        if p17 and p17._toast then
            if u16._toastFn then
                u16._toastFn(p17.text);
            end;

            return;
        end;

        if p17 then
            u16._record = p17;
            broadcast();
        end;
    end);
    task.spawn(function() -- Line: 105
        -- upvalues: SocialService (ref), LocalPlayer (ref), u1 (ref)
        local success, result = pcall(function() -- Line: 69
            -- upvalues: SocialService (ref), LocalPlayer (ref)
            return SocialService:CanSendGameInviteAsync(LocalPlayer);
        end);

        if success then
            u1._canInvite = result and true or false;
        end;

        while true do
            local v18, v19;

            repeat
                task.wait(60);
                v18, v19 = pcall(function() -- Line: 69
                    -- upvalues: SocialService (ref), LocalPlayer (ref)
                    return SocialService:CanSendGameInviteAsync(LocalPlayer);
                end);
            until v18;

            u1._canInvite = v19 and true or false;
        end;
    end);
end;

return u1;