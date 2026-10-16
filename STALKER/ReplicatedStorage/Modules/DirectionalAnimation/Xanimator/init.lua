-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local script_Anim = require(script.Anim);
local BlendData = script_Anim.Enums.BlendData;
local u1 = {};
u1.__index = u1;
u1.ClassName = script.Name;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    return setmetatable({
        StepCount = 0,
        Animator = p2,
        Anims = {},
        QueuedBlends = {},
        QueuedCBlends = {}
    }, u1);
end;

function u1.Load(p3, p4, p5) -- Line: 21
    -- upvalues: script_Anim (copy)
    p3.Anims[p4] = script_Anim.new(p5, p4, p3);

    return p3.Anims[p4];
end;

function u1.Remove(p6, p7) -- Line: 26
    p6.Anims[p7] = p6.Anims[p7]:Destroy();
end;

function u1.Update(p8, p9) -- Line: 30
    -- upvalues: BlendData (copy), TweenService (copy), script_Anim (copy)
    for i, v in p8.QueuedBlends do
        local v10 = p8.Anims[v];
        local _Blend = v10._Blend;
        _Blend[BlendData.Progress] = math.min(_Blend[BlendData.Progress] + p9, _Blend[BlendData.Duration]);
        local Track = v10.Track;
        local math_lerp_ret = math.lerp(_Blend[BlendData.Start], _Blend[BlendData.Target], TweenService:GetValue(_Blend[BlendData.Progress] / _Blend[BlendData.Duration], _Blend[BlendData.Style], _Blend[BlendData.Direction]));
        Track:AdjustWeight(math.max(0.0001, math_lerp_ret), 0);

        if _Blend[BlendData.Progress] == _Blend[BlendData.Duration] then
            table.remove(p8.QueuedBlends, i);
            v10._Blend = nil;
        end;
    end;

    for _, v in p8.QueuedCBlends do
        local v11 = p8.Anims[v];
        local _Blend = script_Anim._Blend;
        v11.Track:AdjustWeight(math.lerp(v11.Track.WeightTarget, _Blend[BlendData.Target], p9 * _Blend[BlendData.Speed]), 0);
    end;

    p8.StepCount = p8.StepCount + 1;
end;

function u1.Destroy(p12) -- Line: 59
    for i, _ in p12.Anims do
        p12:Remove(i);
    end;
end;

return u1;