-- Decompiled with Potassium's decompiler.

local SignalPlus = require(script.Parent.SignalPlus);
local u1 = {};
u1.__index = u1;
u1.ClassName = u1;
u1.Enums = table.freeze({
    BlendData = table.freeze({
        Start = 0,
        Target = 1,
        Duration = 2,
        Style = 3,
        Direction = 4,
        Progress = 5,
        Speed = 6
    })
});
local BlendData = u1.Enums.BlendData;
u1.DEFAULT_STYLE = Enum.EasingStyle.Sine;
u1.DEFAULT_DIRECTION = Enum.EasingDirection.Out;
u1.DEFAULT_FADE = 0.5;

function u1.new(p2, p3, p4) -- Line: 25
    -- upvalues: SignalPlus (copy), u1 (copy)
    local v5 = {
        FadeOut = nil,
        _Blend = nil,
        IsPaused = false,
        Speed = 1,
        Name = p3,
        Parent = p4,
        Track = p4.Animator:LoadAnimation(p2),
        Finished = SignalPlus(),
        Transitioned = SignalPlus()
    };

    return setmetatable(v5, u1);
end;

function u1.SetWeight(p6, p7) -- Line: 40
    p6.Track:AdjustWeight(math.max(0.0001, p7), 0);
end;

function u1.SetSpeed(p8, p9) -- Line: 44
    p8.Speed = p9;

    if p8.IsPaused or p8.IsReversed then
        return;
    end;

    p8.Track:AdjustSpeed(p9);
end;

function u1.Blend(p10, p11, p12, p13, p14) -- Line: 50
    -- upvalues: BlendData (copy)
    if p10._Blend then
        p10.__Blend = nil;
        p10._Blend = {};
        table.remove(p10.Parent.QueuedBlends, table.find(p10.Parent.QueuedBlends, p10.Name));
    else
        p10._Blend = {};
    end;

    if p10.FadeOut then
        p10.FadeOut:Disconnect();
    end;

    local _Blend = p10._Blend;
    table.insert(_Blend, BlendData.Progress, 0);
    table.insert(_Blend, BlendData.Duration, p12);
    table.insert(_Blend, BlendData.Target, p11);
    table.insert(_Blend, BlendData.Start, p10.Track.WeightTarget);
    table.insert(_Blend, BlendData.Style, p13);
    table.insert(_Blend, BlendData.Direction, p14);
    table.insert(p10.Parent.QueuedBlends, p10.Name);
end;

function u1.Between(p15, p16, p17, p18, p19, p20) -- Line: 74
    p15:Blend(1 - p17, p18, p19, p20);
    p16:Blend(p17, p18, p19, p20);
end;

function u1.CBlend(p21, p22, p23) -- Line: 79
    -- upvalues: BlendData (copy)
    if p21._Blend then
        table.clear(p21._Blend);
    else
        p21._Blend = {};
    end;

    local _Blend = p21._Blend;
    table.insert(_Blend, BlendData.Speed, p23);
    table.insert(_Blend, BlendData.Target, p22);
end;

function u1.RetargetCBlend(p24, p25) -- Line: 90
    -- upvalues: BlendData (copy)
    table.remove(p24.Blend, BlendData.Target);
    table.insert(p24.Blend, BlendData.Target, p25);
end;

function u1.Play(u26, u27, u28, u29) -- Line: 95
    local Track = u26.Track;

    if u27 then
        u26.FadeOut = Track.Stopped:Once(function() -- Line: 98
            -- upvalues: Track (copy), u26 (copy), u27 (copy), u28 (copy), u29 (copy)
            Track:Play(0, Track.WeightCurrent, 0);
            Track.TimePosition = Track.Length;
            u26:Blend(0, u27, u28, u29);
            u26.Finished:Fire();
        end);
    end;

    Track:Play(0, Track.WeightTarget, u26.Speed);
end;

function u1.Pause(p30) -- Line: 108
    p30.Track:AdjustSpeed(0);
    p30.IsPaused = true;
end;

function u1.Resume(p31) -- Line: 113
    p31.Track:AdjustSpeed(p31.Speed);
    p31.IsPaused = false;
end;

function u1.Reverse(p32) -- Line: 118
    p32:SetSpeed(-p32.Speed);
end;

function u1.Stop(p33, p34, p35, p36, p37) -- Line: 122
    if p33.FadeOut then
        p33.FadeOut:Disconnect();
    end;

    p33.Track:AdjustSpeed(0);
    p33:Blend(0, p34, p35, p36);
end;

function u1.Destroy(p38) -- Line: 130
    p38.Track:Destroy();
    p38.Finished:Destroy();
    p38.Transitioned:Destroy();
end;

return u1;