-- Decompiled with Potassium's decompiler.

local u1 = {
    MODEL_NAME = "PETZL HeadLamp",
    LIGHT_PART = "HeadLampLight"
};

local function isEffect(p2: userdata) -- Line: 28
    return p2:IsA("Light") or p2:IsA("Beam") or (p2:IsA("ParticleEmitter") or p2:IsA("BillboardGui"));
end;

function u1.Effects(p3: userdata) -- Line: 33
    -- upvalues: u1 (copy)
    local v4 = {};
    local v5 = p3:FindFirstChild(u1.LIGHT_PART);

    if not v5 then
        return v4;
    end;

    for _, descendant in ipairs(v5:GetDescendants()) do
        if descendant:IsA("Light") or descendant:IsA("Beam") or (descendant:IsA("ParticleEmitter") or descendant:IsA("BillboardGui")) then
            table.insert(v4, descendant);
        end;
    end;

    return v4;
end;

function u1.SetLit(p6: userdata, p7: boolean) -- Line: 47
    -- upvalues: u1 (copy)
    local v8 = p6:FindFirstChild(u1.LIGHT_PART);

    if not v8 then
        return;
    end;

    for _, v in ipairs(u1.Effects(p6)) do
        v.Enabled = p7;
    end;

    local Cone = v8:FindFirstChild("Cone");

    if Cone and Cone:IsA("BasePart") then
        Cone.Transparency = p7 and 0.98 or 1;
    end;
end;

return u1;