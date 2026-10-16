-- Decompiled with Potassium's decompiler.

return function(p1: table?) -- Line: 9
    return p1 == nil and {
        _isBridge = true
    } or {
        _isBridge = true,
        inbound = p1.InboundMiddleware,
        outbound = p1.OutboundMiddleware,
        rate = p1.maxRatePerMinute,
        replicationrate = p1.ReplicationRate
    };
end;