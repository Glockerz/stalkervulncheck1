-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local debug_profilebegin = debug.profilebegin;
local debug_profileend = debug.profileend;
local CFrame_new = CFrame.new;
local CFrame_Angles = CFrame.Angles;
local math_rad = math.rad;
local Vector3_new_ret = Vector3.new();
local script_CameraShakeInstance = require(script.CameraShakeInstance);
local CameraShakeState = script_CameraShakeInstance.CameraShakeState;
u1.CameraShakeInstance = script_CameraShakeInstance;
u1.Presets = require(script.CameraShakePresets);

function u1.new(p2, p3, p4) -- Line: 92
    -- upvalues: Vector3_new_ret (copy), u1 (copy)
    local v5 = type(p2) == "number";
    assert(v5, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)");
    local v6 = type(p3) == "function";
    assert(v6, "Callback must be a function");
    local v7 = p4 == nil and true or type(p4) == "string";
    assert(v7, "RenderName must be a string");

    return setmetatable({
        _running = false,
        _renderName = p4 or "CameraShaker",
        _renderPriority = p2,
        _posAddShake = Vector3_new_ret,
        _rotAddShake = Vector3_new_ret,
        _camShakeInstances = {},
        _removeInstances = {},
        _callback = p3
    }, u1);
end;

function u1.Start(u8) -- Line: 114
    -- upvalues: debug_profilebegin (copy), debug_profileend (copy)
    if u8._running then
        return;
    end;

    u8._running = true;
    local _callback = u8._callback;
    game:GetService("RunService"):BindToRenderStep(u8._renderName, u8._renderPriority, function(p9) -- Line: 118
        -- upvalues: debug_profilebegin (ref), u8 (copy), debug_profileend (ref), _callback (copy)
        debug_profilebegin("CameraShakerUpdate");
        local v10 = u8:Update(p9);
        debug_profileend();
        _callback(v10);
    end);
end;

function u1.Stop(p11) -- Line: 127
    if not p11._running then
        return;
    end;

    game:GetService("RunService"):UnbindFromRenderStep(p11._renderName);
    p11._running = false;
end;

function u1.StopSustained(p12, p13) -- Line: 134
    for _, v in pairs(p12._camShakeInstances) do
        if v.fadeOutDuration == 0 then
            v:StartFadeOut(p13 or v.fadeInDuration);
        end;
    end;
end;

function u1.Update(p14, p15) -- Line: 143
    -- upvalues: Vector3_new_ret (copy), CameraShakeState (copy), CFrame_new (copy), CFrame_Angles (copy), math_rad (copy)
    local v16 = Vector3_new_ret;
    local v17 = Vector3_new_ret;
    local _camShakeInstances = p14._camShakeInstances;

    for i = 1, #_camShakeInstances do
        local v18 = _camShakeInstances[i];
        local State = v18:GetState();
        local v19;

        if State == CameraShakeState.Inactive and v18.DeleteOnInactive then
            p14._removeInstances[#p14._removeInstances + 1] = i;
            v19 = i;
        elseif State == CameraShakeState.Inactive then
            v19 = i;
        else
            local v20 = v18:UpdateShake(p15);
            v16 = v16 + v20 * v18.PositionInfluence;
            v17 = v17 + v20 * v18.RotationInfluence;
            v19 = i;
        end;
    end;

    for i = #p14._removeInstances, 1, -1 do
        table.remove(_camShakeInstances, p14._removeInstances[i]);
        p14._removeInstances[i] = nil;
        local _ = i;
    end;

    return CFrame_new(v16) * CFrame_Angles(0, math_rad(v17.Y), 0) * CFrame_Angles(math_rad(v17.X), 0, (math_rad(v17.Z)));
end;

function u1.Shake(p21, p22) -- Line: 180
    local v23;

    if type(p22) == "table" then
        v23 = p22._camShakeInstance;
    else
        v23 = false;
    end;

    assert(v23, "ShakeInstance must be of type CameraShakeInstance");
    p21._camShakeInstances[#p21._camShakeInstances + 1] = p22;

    return p22;
end;

function u1.ShakeSustain(p24, p25) -- Line: 187
    local v26;

    if type(p25) == "table" then
        v26 = p25._camShakeInstance;
    else
        v26 = false;
    end;

    assert(v26, "ShakeInstance must be of type CameraShakeInstance");
    p24._camShakeInstances[#p24._camShakeInstances + 1] = p25;
    p25:StartFadeIn(p25.fadeInDuration);

    return p25;
end;

function u1.ShakeOnce(p27, p28, p29, p30, p31, p32, p33) -- Line: 195
    -- upvalues: script_CameraShakeInstance (copy)
    local v34 = script_CameraShakeInstance.new(p28, p29, p30, p31);
    v34.PositionInfluence = typeof(p32) == "Vector3" and p32 and p32 or Vector3.new(0.15, 0.15, 0.15);
    v34.RotationInfluence = typeof(p33) == "Vector3" and p33 and p33 or Vector3.new(1, 1, 1);
    p27._camShakeInstances[#p27._camShakeInstances + 1] = v34;

    return v34;
end;

function u1.StartShake(p35, p36, p37, p38, p39, p40) -- Line: 204
    -- upvalues: script_CameraShakeInstance (copy)
    local v41 = script_CameraShakeInstance.new(p36, p37, p38);
    v41.PositionInfluence = typeof(p39) == "Vector3" and p39 and p39 or Vector3.new(0.15, 0.15, 0.15);
    v41.RotationInfluence = typeof(p40) == "Vector3" and p40 and p40 or Vector3.new(1, 1, 1);
    v41:StartFadeIn(p38);
    p35._camShakeInstances[#p35._camShakeInstances + 1] = v41;

    return v41;
end;

return u1;