-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local script_HitboxCaster = require(script.HitboxCaster);
local script_Signal = require(script.Signal);
local u1 = {};
u1.__index = u1;
u1.__type = "RaycastHitboxModule";
u1.DetectionMode = {
    Default = 1,
    PartMode = 2,
    Bypass = 3
};

function u1.new(p2) -- Line: 185
    -- upvalues: CollectionService (copy), script_HitboxCaster (copy), u1 (copy), script_Signal (copy)
    if p2 and CollectionService:HasTag(p2, "_RaycastHitboxV4Managed") then
        return script_HitboxCaster:_FindHitbox(p2);
    end;

    local v3 = {
        RaycastParams = nil,
        HitboxPendingRemoval = false,
        HitboxStopTime = 0,
        HitboxActive = false,
        Visualizer = true,
        DebugLog = true,
        Tag = "_RaycastHitboxV4Managed",
        DetectionMode = u1.DetectionMode.Default,
        HitboxRaycastPoints = {},
        HitboxObject = p2,
        HitboxHitList = {},
        OnUpdate = script_Signal:Create(),
        OnHit = script_Signal:Create()
    };
    local v4 = setmetatable(v3, script_HitboxCaster);
    v4:_Init();

    return v4;
end;

function u1.GetHitbox(p5, p6) -- Line: 215
    -- upvalues: script_HitboxCaster (copy)
    if p6 then
        return script_HitboxCaster:_FindHitbox(p6);
    end;
end;

return u1;