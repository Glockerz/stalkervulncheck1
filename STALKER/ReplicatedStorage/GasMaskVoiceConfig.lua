-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local u1 = {
    SelfMonitor = false,
    DistanceAttenuation = {
        [0] = 1,
        [25] = 0.85,
        [55] = 0.4,
        [90] = 0
    },
    Filter = {
        Type = "Lowpass24dB",
        Frequency = 2000,
        Q = 1
    },
    EQ = {
        LowGain = 3,
        MidGain = -3,
        HighGain = -8
    },
    Compressor = {
        Threshold = -18,
        Ratio = 3,
        Attack = 0.04,
        Release = 0.18,
        MakeupGain = 8
    },
    Volume = 2.5,
    Limiter = {
        MaxLevel = -1,
        Release = 0.05
    },
    ListenerEQ = {
        LowGain = 2,
        MidGain = -3,
        HighGain = -12
    },
    PollInterval = 1,
    AVATAR_ADMITTED_ATTR = "ZS_AvatarAdmitted"
};

function u1.isZoneGear(p2) -- Line: 62
    -- upvalues: u1 (copy)
    if p2:GetAttribute(u1.AVATAR_ADMITTED_ATTR) == nil then
        return p2:IsA("Model");
    end;

    return false;
end;

function u1.wearsFaceWear(p3, p4) -- Line: 72
    -- upvalues: u1 (copy), ItemDatabase (copy)
    if not p3 then
        return false;
    end;

    for _, child in p3:GetChildren() do
        if u1.isZoneGear(child) then
            local v5 = child;

            for i, v in pairs(ItemDatabase) do
                if type(v) == "table" and (v.ItemType == "FaceWear" and (p4(v) and v5.Name == (v.Model or i))) then
                    return true;
                end;
            end;
        end;
    end;

    return false;
end;

function u1.isWearingGasMask(p6) -- Line: 87
    -- upvalues: u1 (copy)
    return u1.wearsFaceWear(p6, function(p7) -- Line: 88
        local v8;

        if p7.RadResist == nil then
            v8 = false;
        else
            v8 = p7.RadResist > 0;
        end;

        return v8;
    end);
end;

function u1.isWearingVisorMask(p9) -- Line: 97
    -- upvalues: u1 (copy)
    return u1.wearsFaceWear(p9, function(p10) -- Line: 98
        return p10.HasVisor == true;
    end);
end;

return u1;