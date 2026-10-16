-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};

function u1.Weld(p3, p4, p5, p6, p7) -- Line: 4
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p3;
    WeldConstraint.Part1 = p4;
    WeldConstraint.Name = p6 or WeldConstraint.Name;
    WeldConstraint.Parent = p5 or p3;
end;

function u1.LoadAnimation(p8: string, p9: userdata) -- Line: 12
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p8;

    return p9:LoadAnimation(Animation);
end;

function u1.PlayAnimation(p10: userdata, p11: userdata) -- Line: 19
    -- upvalues: u2 (copy)
    p10:Play();
    p10.Priority = p11.AnimationPriority;
    p10:AdjustSpeed(p11.AnimationSpeed);
    p10.Looped = p11.Looped;

    if not u2[p10] then
        u2[p10] = true;

        for _, v in pairs(p11.AnimationEvents) do
            p10:GetPropertyChangedSignal(v.AnimationEventName):Connect(function() -- Line: 27
                -- upvalues: v (copy)
                v.Function();
            end);
        end;
    end;
end;

function u1.Random(p12, p13) -- Line: 33
    return Random.new():NextNumber(p12, p13);
end;

function u1.ReturnRandom(p14: userdata) -- Line: 36
    return p14[math.random(#p14)];
end;

function u1.ReturnChildren(p15) -- Line: 39
    return p15:GetChildren();
end;

function u1.ReturnFolderChild(p16) -- Line: 42
    -- upvalues: u1 (copy)
    return u1.ReturnRandom(u1.ReturnChildren(p16));
end;

function u1.PlaySound(p17: userdata, p18: userdata?) -- Line: 45
    local u19 = p17:Clone();
    u19.Parent = p18;
    u19:Play();
    u19.Ended:Connect(function() -- Line: 49
        -- upvalues: u19 (copy)
        u19:Destroy();
    end);
end;

return u1;