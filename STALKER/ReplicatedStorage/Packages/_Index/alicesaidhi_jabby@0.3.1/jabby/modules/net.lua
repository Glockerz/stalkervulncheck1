-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local signal = require(script.Parent.signal);
local vm_id = require(script.Parent.vm_id);
local traffic_check = require(script.Parent.traffic_check);
require(script.Parent.types);
local u1 = RunService:IsServer() and "server" or Players.LocalPlayer;

local function tincoming_connector(p2) -- Line: 26
    if typeof(p2) ~= "table" then
        return false;
    end;

    if p2.host ~= "server" and (typeof(p2.host) ~= "Instance" or not p2.host:IsA("Player")) then
        return false;
    end;

    if typeof(p2.from_vm) == "number" then
        return p2.to_vm == nil or typeof(p2.to_vm) == "number";
    end;

    return false;
end;

local u3 = false;
local u4;

if RunService:IsServer() then
    u4 = ReplicatedStorage:FindFirstChild("JABBY_REMOTES");

    if not u4 then
        warn("There\'s a bug with jabby that sometimes causes the JABBY_REMOTES folder to not replicate very rarely. Unfortunately, I still haven\'t thought of a fix yet -,- so please instead clone the JABBY_REMOTES folder into your game which should stop it. make sure to set archivable to true!");
        u4 = Instance.new("Folder");
        u4.Name = "JABBY_REMOTES";
        u4.Archivable = false;
        u4.Parent = ReplicatedStorage;
        u3 = true;
    end;
else
    u4 = ReplicatedStorage:WaitForChild("JABBY_REMOTES");
end;

local function get_remote_event(p5: string, p6: boolean?) -- Line: 57
    -- upvalues: RunService (copy), u4 (ref), u3 (ref)
    if not RunService:IsServer() then
        return u4:WaitForChild(p5);
    end;

    local v7 = u4:FindFirstChild(p5);

    if not v7 then
        if not u3 then
            warn((`btw, you are missing {p5} from the JABBY_REMOTES folder`));
        end;

        v7 = Instance.new(p6 and "UnreliableRemoteEvent" or "RemoteEvent");
        v7.Name = p5;
        v7.Parent = u4;
        local BindableEvent = Instance.new("BindableEvent");
        BindableEvent.Name = "actor";
        BindableEvent.Parent = v7;
        local RemoteEvent = Instance.new("RemoteEvent");
        RemoteEvent.Name = "peer";
        RemoteEvent.Parent = v7;
    end;

    return v7;
end;

return {
    create_event = function(p8: string, p9: boolean?, u10: boolean?) -- Line: 84, Name: create_event
        -- upvalues: get_remote_event (copy), signal (copy), traffic_check (copy), u1 (ref), vm_id (copy), RunService (copy), tincoming_connector (copy)
        local u11 = get_remote_event(p8, p9);
        local u12, u13 = signal();
        local v18 = {
            type = "event",

            fire = function(p14, p15, ...) -- Line: 91, Name: fire
                -- upvalues: traffic_check (ref), u1 (ref), vm_id (ref), u13 (copy), u11 (copy)
                if not traffic_check.check(u1, p15.host, true) then
                    return;
                end;

                if p15.host == u1 and p15.to_vm == vm_id then
                    u13({
                        host = u1,
                        from_vm = vm_id,
                        to_vm = p15.to_vm
                    }, ...);

                    return;
                end;

                if p15.host == u1 and p15.to_vm ~= vm_id then
                    u11.actor:Fire({
                        host = u1,
                        from_vm = vm_id,
                        to_vm = p15.to_vm
                    }, ...);

                    return;
                end;

                if p15.host == "server" then
                    u11:FireServer({
                        host = "server",
                        from_vm = vm_id,
                        to_vm = p15.to_vm
                    }, ...);

                    return;
                end;

                if u1 == "server" then
                    u11:FireClient(p15.host, {
                        host = "server",
                        from_vm = vm_id,
                        to_vm = p15.to_vm
                    }, ...);

                    return;
                end;

                u11:FireServer({
                    host = p15.host,
                    from_vm = vm_id,
                    to_vm = p15.to_vm
                }, ...);
            end,

            connect = function(p16: any, p17: function) -- Line: 152, Name: connect
                -- upvalues: u12 (copy)
                return u12:connect(p17);
            end
        };

        if RunService:IsServer() then
            u11.OnServerEvent:Connect(function(p19, p20, ...) -- Line: 158
                -- upvalues: u10 (copy), traffic_check (ref), tincoming_connector (ref), vm_id (ref), u13 (copy), u11 (copy)
                if not (u10 or traffic_check.check(p19, p20.host)) then
                    return;
                end;

                if not tincoming_connector(p20) then
                    return;
                end;

                if p20.host ~= "server" or p20.to_vm ~= vm_id and p20.to_vm ~= nil then
                    if p20.host ~= "server" and vm_id == 0 then
                        local host = p20.host;
                        p20.host = p19;
                        u11:FireClient(host, p20, ...);
                    end;

                    return;
                end;

                p20.host = p19;
                u13(p20, ...);
            end);
        else
            u11.OnClientEvent:Connect(function(p21, ...) -- Line: 181
                -- upvalues: tincoming_connector (ref), vm_id (ref), traffic_check (ref), u1 (ref), u13 (copy)
                if tincoming_connector(p21) == false then
                    return;
                end;

                if p21.to_vm ~= vm_id and p21.to_vm ~= nil then
                    return;
                end;

                traffic_check._whitelist(u1, p21.host);
                u13(p21, ...);
            end);
        end;

        u11:WaitForChild("actor").Event:Connect(function(p22, ...) -- Line: 191
            -- upvalues: vm_id (ref), u13 (copy)
            if p22.to_vm ~= vm_id and p22.to_vm ~= nil then
                return;
            end;

            u13(p22, ...);
        end);

        return v18;
    end,

    local_host = u1
};