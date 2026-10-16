-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Planck = require(ReplicatedStorage.Packages.Planck);
local v1 = require(ReplicatedStorage.Packages["Planck-Jabby"]);
local Jabby = require(ReplicatedStorage.Packages.Jabby);
local Axis = require(ReplicatedStorage.Packages.Axis);
local world = require(ReplicatedStorage.Shared.world);
require(ReplicatedStorage.Shared.components);
local network = require(ReplicatedStorage.Shared.network);
local script_replicator = require(script.replicator);
local v2 = require(script.systems["replecs-client"]);
script_replicator:init();
local v3, v4 = script_replicator:verify_handshake((network.Handshake:InvokeServer()));

if not v3 then
    error("Handshake failed: " .. tostring(v4));
end;

network.FullState.OnClientEvent:Connect(function(p5, p6) -- Line: 28
    -- upvalues: script_replicator (copy)
    script_replicator:apply_full(p5, p6);
end);
network.ClientReady:FireServer();
Jabby.register({
    name = "Client World",
    applet = Jabby.applets.world,
    configuration = {
        world = world
    }
});
local u7 = RunService:IsStudio();
local u8 = Axis.input({ Enum.KeyCode.Y });
local u9 = false;
local Phase = Planck.Phase;
local v10 = Planck.Phase.new();
local v11 = Planck.Phase.new();

local function inputSystem() -- Line: 58
    -- upvalues: u7 (copy), u8 (copy), u9 (ref), Jabby (copy)
    if not u7 then
        return;
    end;

    u8:update();
    u9 = u8:pressed() and not u9;

    if u9 then
        local v12 = Jabby.obtain_client();
        v12.spawn_app(v12.apps.home);
    end;
end;

Planck.Scheduler.new():addPlugin(v1.new()):insert(Phase.Startup):insert(v10, RunService, "RenderStepped"):insert(v11, RunService, "Heartbeat"):addSystem(inputSystem, v10):addSystem(v2, v11);