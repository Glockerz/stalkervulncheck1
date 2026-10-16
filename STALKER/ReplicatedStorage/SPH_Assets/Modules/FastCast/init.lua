-- Decompiled with Potassium's decompiler.

local u1 = {
    DebugLogging = false,
    VisualizeCasts = false
};
u1.__index = u1;
u1.__type = "FastCast";
u1.HighFidelityBehavior = {
    Default = 1,
    Always = 3
};
local script_ActiveCast = require(script.ActiveCast);
local script_Signal = require(script.Signal);
require(script.Table);
require(script.TypeDefinitions);
script_ActiveCast.SetStaticFastCastReference(u1);

function u1.new() -- Line: 107
    -- upvalues: script_Signal (copy), u1 (copy)
    local v2 = {
        LengthChanged = script_Signal.new("LengthChanged"),
        RayHit = script_Signal.new("RayHit"),
        RayPierced = script_Signal.new("RayPierced"),
        CastTerminating = script_Signal.new("CastTerminating"),
        WorldRoot = workspace
    };

    return setmetatable(v2, u1);
end;

function u1.newBehavior() -- Line: 119
    -- upvalues: u1 (copy)
    return {
        RaycastParams = nil,
        MaxDistance = 1000,
        CanPierceFunction = nil,
        HighFidelitySegmentSize = 0.5,
        CosmeticBulletTemplate = nil,
        CosmeticBulletProvider = nil,
        CosmeticBulletContainer = nil,
        AutoIgnoreContainer = true,
        Acceleration = Vector3.new(),
        HighFidelityBehavior = u1.HighFidelityBehavior.Default
    };
end;

local u3 = u1.newBehavior();

function u1.Fire(p4: table, p5: vector, p6: vector, p7: any, p8: any) -- Line: 136
    -- upvalues: u3 (copy), script_ActiveCast (copy)
    if p8 == nil then
        p8 = u3;
    end;

    local v9 = script_ActiveCast.new(p4, p5, p6, p7, p8);
    v9.RayInfo.WorldRoot = p4.WorldRoot;

    return v9;
end;

return u1;