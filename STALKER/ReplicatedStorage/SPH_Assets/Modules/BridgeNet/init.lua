-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local script_SerdesLayer = require(script.SerdesLayer);
local script_ServerBridge = require(script.ServerBridge);
local script_ClientBridge = require(script.ClientBridge);
local script_CreateBridgeTree = require(script.CreateBridgeTree);
local script_Bridge = require(script.Bridge);
local u1 = RunService:IsServer();
script.Destroying:Connect(function() -- Line: 118
    -- upvalues: script_SerdesLayer (copy), u1 (copy), script_ServerBridge (copy)
    script_SerdesLayer._destroy();

    if u1 then
        script_ServerBridge._destroy();
    end;
end);
script_SerdesLayer._start();

if u1 then
    script_ServerBridge._start();
else
    script_ClientBridge._start();
end;

return {
    CreateBridgeTree = script_CreateBridgeTree,
    Bridge = script_Bridge,

    Identifiers = function(p2: table) -- Line: 136, Name: Identifiers
        -- upvalues: script_SerdesLayer (copy)
        local v3 = {};

        for _, v in p2 do
            v3[v] = script_SerdesLayer.CreateIdentifier(v);
        end;

        return v3;
    end,

    CreateIdentifier = script_SerdesLayer.CreateIdentifier,
    DestroyIdentifier = script_SerdesLayer.DestroyIdentifier,
    CreateUUID = script_SerdesLayer.CreateUUID,
    PackUUID = script_SerdesLayer.PackUUID,
    UnpackUUID = script_SerdesLayer.UnpackUUID,
    DictionaryToTable = script_SerdesLayer.DictionaryToTable,

    ReplicationStep = function(p4: number, p5: function) -- Line: 163, Name: ReplicationStep
        -- upvalues: u1 (copy), script_ServerBridge (copy), script_ClientBridge (copy)
        if u1 then
            return script_ServerBridge._getReplicationStepSignal(p4, p5);
        end;

        return script_ClientBridge._getReplicationStepSignal(p4, p5);
    end,

    GetQueue = function() -- Line: 171, Name: GetQueue
        -- upvalues: u1 (copy), script_ServerBridge (copy), script_ClientBridge (copy)
        if u1 then
            local v6, v7 = script_ServerBridge._returnQueue();

            return v6, v7;
        end;

        local v8, v9 = script_ClientBridge._returnQueue();

        return v8, v9;
    end,

    CreateBridge = function(p10) -- Line: 181, Name: CreateBridge
        -- upvalues: u1 (copy), script_ServerBridge (copy), script_ClientBridge (copy)
        if u1 then
            return script_ServerBridge.new(p10);
        end;

        return script_ClientBridge.new(p10);
    end
};