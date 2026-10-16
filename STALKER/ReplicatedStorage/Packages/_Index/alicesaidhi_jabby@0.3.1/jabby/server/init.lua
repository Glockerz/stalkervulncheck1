-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local loop = require(script.Parent.modules.loop);
local remotes = require(script.Parent.modules.remotes);
local traffic_check = require(script.Parent.modules.traffic_check);
local vm_id = require(script.Parent.modules.vm_id);

local function broadcast() -- Line: 8
    -- upvalues: Players (copy), traffic_check (copy), remotes (copy)
    for _, v in Players:GetPlayers() do
        if traffic_check.can_use_jabby(v) then
            remotes.new_server_registered:fire({
                host = v
            });
        end;
    end;
end;

task.delay(0, broadcast);
local script_systems = script.systems;
local v1 = loop(`jabby-host:{RunService:IsServer() and "server" or "client"}-vm:{vm_id}`, nil, {
    i = 1
}, script_systems.ping, script_systems.replicate_core, script_systems.replicate_scheduler, script_systems.replicate_registry, script_systems.replicate_system_watch, script_systems.mouse_pointer, script_systems.entity);
RunService.PostSimulation:Connect(v1);

return {
    broadcast = broadcast
};