-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"));
local PlayerTradeController = require(ReplicatedStorage:WaitForChild("PlayerTradeController"));
local v1 = {
    _initialized = false
};

local function shouldShowInvite(p2) -- Line: 18
    -- upvalues: LocalPlayer (copy), SquadController (copy)
    if p2 == LocalPlayer then
        return false;
    end;

    if not p2.Character then
        return false;
    end;

    local Squad = SquadController:GetSquad();

    if Squad and not SquadController:IsLeader() then
        return false;
    end;

    return not (Squad and (Squad.members[p2.UserId] or Squad.members[tostring(p2.UserId)]));
end;

local function shouldShowTrade(p3) -- Line: 33
    -- upvalues: LocalPlayer (copy)
    if p3 == LocalPlayer then
        return false;
    end;

    return p3.Character and true or false;
end;

local function getPromptAnchor(p4) -- Line: 39
    return p4:FindFirstChild("UpperTorso") or p4:FindFirstChild("Torso") or (p4:FindFirstChild("HumanoidRootPart") or p4.PrimaryPart);
end;

local function ensurePrompts(u5) -- Line: 46
    -- upvalues: LocalPlayer (copy), SquadController (copy), PlayerTradeController (copy)
    if not u5.Character then
        return;
    end;

    local Character = u5.Character;
    local v6 = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso") or (Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart);

    if not v6 then
        return;
    end;

    local SquadInvitePrompt = v6:FindFirstChild("SquadInvitePrompt");

    if SquadInvitePrompt then
        local v7;

        if u5 == LocalPlayer or not u5.Character then
            v7 = false;
        else
            local Squad = SquadController:GetSquad();

            if Squad and not SquadController:IsLeader() then
                v7 = false;
            else
                v7 = not (Squad and (Squad.members[u5.UserId] or Squad.members[tostring(u5.UserId)]));
            end;
        end;

        SquadInvitePrompt.Enabled = v7;
    else
        local ProximityPrompt = Instance.new("ProximityPrompt");
        ProximityPrompt.Name = "SquadInvitePrompt";
        ProximityPrompt.ActionText = "Invite to Squad";
        ProximityPrompt.ObjectText = u5.DisplayName;
        ProximityPrompt.HoldDuration = 0.3;
        ProximityPrompt.MaxActivationDistance = 6;
        ProximityPrompt.RequiresLineOfSight = false;
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
        ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.F;
        ProximityPrompt.UIOffset = Vector2.new(0, -15);
        local v8;

        if u5 == LocalPlayer or not u5.Character then
            v8 = false;
        else
            local Squad = SquadController:GetSquad();

            if Squad and not SquadController:IsLeader() then
                v8 = false;
            else
                v8 = not (Squad and (Squad.members[u5.UserId] or Squad.members[tostring(u5.UserId)]));
            end;
        end;

        ProximityPrompt.Enabled = v8;
        ProximityPrompt.Parent = v6;
        ProximityPrompt.Triggered:Connect(function(p9) -- Line: 69
            -- upvalues: LocalPlayer (ref), SquadController (ref), u5 (copy)
            if p9 ~= LocalPlayer then
                return;
            end;

            local v10 = SquadController:Invite(u5.UserId);

            if not (v10 and v10.ok) then
                if v10 then
                    v10 = v10.error;
                end;

                if v10 == "target_already_in_squad" then
                    SquadController:ShowToast(u5.DisplayName .. " is already in a squad.");

                    return;
                end;

                warn("[PlayerInteractionController] Invite failed: " .. tostring(v10));
            end;
        end);
    end;

    local PlayerTradePrompt = v6:FindFirstChild("PlayerTradePrompt");

    if PlayerTradePrompt then
        local v11;

        if u5 == LocalPlayer then
            v11 = false;
        else
            v11 = u5.Character and true or false;
        end;

        PlayerTradePrompt.Enabled = v11;

        return;
    end;

    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.Name = "PlayerTradePrompt";
    ProximityPrompt.ActionText = "Trade";
    ProximityPrompt.ObjectText = u5.DisplayName;
    ProximityPrompt.HoldDuration = 0.3;
    ProximityPrompt.MaxActivationDistance = 6;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.T;
    ProximityPrompt.UIOffset = Vector2.new(0, 15);
    local v12;

    if u5 == LocalPlayer then
        v12 = false;
    else
        v12 = u5.Character and true or false;
    end;

    ProximityPrompt.Enabled = v12;
    ProximityPrompt.Parent = v6;
    ProximityPrompt.Triggered:Connect(function(p13) -- Line: 101
        -- upvalues: LocalPlayer (ref), PlayerTradeController (ref), u5 (copy)
        if p13 ~= LocalPlayer then
            return;
        end;

        PlayerTradeController:Request(u5);
    end);
end;

local function removePrompts(p14) -- Line: 108
    if not p14.Character then
        return;
    end;

    local Character = p14.Character;
    local v15 = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso") or (Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart);

    if not v15 then
        return;
    end;

    local SquadInvitePrompt = v15:FindFirstChild("SquadInvitePrompt");

    if SquadInvitePrompt then
        SquadInvitePrompt:Destroy();
    end;

    local PlayerTradePrompt = v15:FindFirstChild("PlayerTradePrompt");

    if PlayerTradePrompt then
        PlayerTradePrompt:Destroy();
    end;
end;

local function refreshAll() -- Line: 118
    -- upvalues: Players (copy), LocalPlayer (copy), ensurePrompts (copy)
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            ensurePrompts(v);
        end;
    end;
end;

function v1.Init(p16) -- Line: 126
    -- upvalues: SquadController (copy), refreshAll (copy), Players (copy), ensurePrompts (copy), LocalPlayer (copy)
    if p16._initialized then
        return;
    end;

    p16._initialized = true;
    SquadController:OnChanged(refreshAll);
    Players.PlayerAdded:Connect(function(u17) -- Line: 132
        -- upvalues: ensurePrompts (ref)
        u17.CharacterAdded:Connect(function() -- Line: 133
            -- upvalues: ensurePrompts (ref), u17 (copy)
            ensurePrompts(u17);
        end);
    end);

    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            v.CharacterAdded:Connect(function() -- Line: 137
                -- upvalues: ensurePrompts (ref), v (copy)
                ensurePrompts(v);
            end);

            if v.Character then
                ensurePrompts(v);
            end;
        end;
    end;
end;

return v1;