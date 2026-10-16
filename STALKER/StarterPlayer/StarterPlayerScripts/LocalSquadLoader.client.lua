-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage:WaitForChild("SquadController")):Init();
require(ReplicatedStorage:WaitForChild("SquadToastController")):Init();
require(ReplicatedStorage:WaitForChild("RecentEncountersController")):Init();
require(ReplicatedStorage:WaitForChild("SquadNametagController")):Init();
require(ReplicatedStorage:WaitForChild("PlayerInteractionController")):Init();
require(ReplicatedStorage:WaitForChild("ContactController")):Init();
require(ReplicatedStorage:WaitForChild("TaskController")):Init();
require(ReplicatedStorage:WaitForChild("TaskTrackerController")):Init();
require(ReplicatedStorage:WaitForChild("MainTaskPromptController")):Init();
require(ReplicatedStorage:WaitForChild("HotbarController")):Init();
require(ReplicatedStorage:WaitForChild("AmmoHudController")):Init();
local TransitController = require(ReplicatedStorage:WaitForChild("TransitController"));
TransitController:Init();
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10);
local u1;

if Remotes then
    u1 = Remotes:WaitForChild("TransitRequest", 10);
else
    u1 = Remotes;
end;

local u2;

if u1 then
    u2 = Remotes:WaitForChild("TransitReady", 10);
else
    u2 = u1;
end;

local v3;

if u2 then
    v3 = Remotes:WaitForChild("TransitReadyState", 10);
else
    v3 = u2;
end;

if u1 and (u2 and v3) then
    function TransitController.OnTransit(p4) -- Line: 54
        -- upvalues: u1 (copy)
        u1:FireServer({
            destination = p4.destination,
            access = p4.access,
            server = p4.server
        });
    end;

    function TransitController.OnReadyChanged(p5) -- Line: 57
        -- upvalues: u2 (copy)
        u2:FireServer(p5 == true);
    end;

    function TransitController.OnCancel() -- Line: 60
        -- upvalues: u2 (copy)
        u2:FireServer(false);
    end;

    v3.OnClientEvent:Connect(function(p6, p7, p8) -- Line: 63
        -- upvalues: TransitController (copy)
        TransitController:SetReady(p6, p7);
        TransitController:SetLeaderPick(p6, p8);
    end);
    local TransitServers = Remotes:WaitForChild("TransitServers", 10);

    function TransitController.OnFetchServers(u9) -- Line: 70
        -- upvalues: TransitServers (copy)
        if not TransitServers then
            return nil;
        end;

        local success, result = pcall(function() -- Line: 73
            -- upvalues: TransitServers (ref), u9 (copy)
            return TransitServers:InvokeServer(u9);
        end);

        if not (success and (type(result) == "table" and result)) then
            result = nil;
        end;

        return result;
    end;

    function TransitController.OnPickChanged(p10) -- Line: 76
        -- upvalues: u2 (copy)
        u2:FireServer(true, p10);
    end;

    local TransitCountdown = Remotes:WaitForChild("TransitCountdown", 10);
    local TransitCancel = Remotes:WaitForChild("TransitCancel", 10);

    if TransitCountdown then
        TransitCountdown.OnClientEvent:Connect(function(p11) -- Line: 83
            -- upvalues: TransitController (copy)
            TransitController:SetCountdown(p11);
        end);
    end;

    function TransitController.OnCancelCountdown() -- Line: 87
        -- upvalues: TransitCancel (copy)
        if TransitCancel then
            TransitCancel:FireServer();
        end;
    end;

    local TransitTeleportFailed = Remotes:WaitForChild("TransitTeleportFailed", 10);
    game:GetService("TeleportService").TeleportInitFailed:Connect(function(p12, p13, p14, p15) -- Line: 94
        -- upvalues: TransitTeleportFailed (copy)
        warn(string.format("[Transit] teleport to %s failed: %s %s", tostring(p15), tostring(p13), (tostring(p14))));

        if TransitTeleportFailed then
            TransitTeleportFailed:FireServer(p13.Name, (tostring(p14)));
        end;
    end);
end;