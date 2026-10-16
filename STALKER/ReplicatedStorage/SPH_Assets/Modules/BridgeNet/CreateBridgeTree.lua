-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local ServerBridge = require(script.Parent.ServerBridge);
local ClientBridge = require(script.Parent.ClientBridge);

local function search(p1, p2) -- Line: 6
    -- upvalues: RunService (copy), ServerBridge (copy), ClientBridge (copy)
    local v3;

    if RunService:IsServer() then
        v3 = ServerBridge.new(p1);
    else
        v3 = ClientBridge.new(p1);
    end;

    if p2.server and RunService:IsServer() then
        if p2.outboundmiddleware then
            v3:SetOutboundMiddleware(p2.outboundmiddleware);
        end;

        if p2.inboundmiddleware then
            v3:SetInboundMiddleware(p2.inboundmiddleware);
        end;
    end;

    if p2.client and not RunService:IsServer() then
        if p2.outboundmiddleware then
            v3:SetOutboundMiddleware(p2.outboundmiddleware);
        end;

        if p2.inboundmiddleware then
            v3:SetInboundMiddleware(p2.inboundmiddleware);
        end;
    end;

    if p2.replicationrate then
        v3:SetReplicationRate(p2.replicationrate);
    end;

    return v3;
end;

local function recursiveSearch(p4) -- Line: 39
    -- upvalues: search (copy), recursiveSearch (copy)
    local v5 = {};

    for i, v in p4 do
        local v6 = type(v) == "table";
        assert(v6, "Everything in BridgeNet.CreateBridgeTree must be a dictionary or BridgeNet.Bridge()");

        if v._isBridge == true then
            v5[i] = search(i, v);
        else
            v5[i] = recursiveSearch(v);
        end;
    end;

    return v5;
end;

return recursiveSearch;