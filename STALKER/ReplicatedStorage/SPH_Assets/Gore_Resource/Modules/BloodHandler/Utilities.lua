-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};

function u1.Weld(p3, p4, p5, p6, p7) -- Line: 4
    local v8;

    if p7 then
        v8 = Instance.new("WeldConstraint");
    else
        v8 = Instance.new("Weld");
    end;

    v8.Part0 = p3;
    v8.Part1 = p4;
    v8.Name = p6 or v8.Name;
    v8.Parent = p5 or p3;
end;

function u1.LoadAnimation(p9: string, p10: userdata) -- Line: 16
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p9;

    return p10:LoadAnimation(Animation);
end;

function u1.PlayAnimation(p11: userdata, p12: userdata) -- Line: 23
    -- upvalues: u2 (copy)
    p11:Play();
    p11.Priority = p12.AnimationPriority;
    p11:AdjustSpeed(p12.AnimationSpeed);
    p11.Looped = p12.Looped;

    if not u2[p11] then
        u2[p11] = true;

        for _, v in pairs(p12.AnimationEvents) do
            p11:GetPropertyChangedSignal(v.AnimationEventName):Connect(function() -- Line: 31
                -- upvalues: v (copy)
                v.Function();
            end);
        end;
    end;
end;

function u1.Random(p13, p14) -- Line: 37
    return Random.new():NextNumber(p13, p14);
end;

function u1.ReturnRandom(p15: userdata) -- Line: 40
    return p15[math.random(#p15)];
end;

function u1.ReturnChildren(p16) -- Line: 43
    return p16:GetChildren();
end;

function u1.ReturnFolderChild(p17) -- Line: 46
    -- upvalues: u1 (copy)
    return u1.ReturnRandom(u1.ReturnChildren(p17));
end;

function u1.PlaySound(p18: userdata, p19: userdata?) -- Line: 49
    local u20 = p18:Clone();
    u20.Parent = p19;
    u20:Play();
    u20.Ended:Connect(function() -- Line: 53
        -- upvalues: u20 (copy)
        u20:Destroy();
    end);
end;

return u1;