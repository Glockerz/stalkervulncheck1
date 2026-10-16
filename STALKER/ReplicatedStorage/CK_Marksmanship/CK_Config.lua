-- Decompiled with Potassium's decompiler.

local u1 = {
    OPTIC = {
        zoomFov = 20,
        sensitivityScale = 0.25,
        magMin = 4,
        magMax = 4,
        magStart = 4,
        magStep = 1,
        zoomLerp = 4,
        baseFov = 70,
        zoomExponent = 1.25,
        sensZoomPower = 2,
        sensZoomMin = 0.03,
        sensZoomMax = 1.4,
        sensMult = 0.35,
        dollyStartMag = 4,
        dollyMax = 0,
        dollyPower = 1.5,
        dollySmooth = 9,
        dollyMargin = 3,
        magStops = { 4 }
    },
    SPOTTER = {
        baseFov = 70,
        zoomFov = 20,
        magStops = { 4 },
        reticleOffset = Vector2.new(0, 0)
    }
};

function u1.opticFor(p2) -- Line: 113
    -- upvalues: u1 (copy)
    local v3 = {};

    for i, v in pairs(u1.OPTIC) do
        v3[i] = v;
    end;

    local CK_OpticDatabase = require(script.Parent:WaitForChild("CK_OpticDatabase"));
    local v4;

    if p2 then
        v4 = p2:GetAttribute("CK_OpticId");
    else
        v4 = p2;
    end;

    local v5 = v4 and CK_OpticDatabase[v4] or CK_OpticDatabase.DEFAULT;

    if v4 and not CK_OpticDatabase[v4] then
        local v6 = warn;
        local v7 = tostring(v4);

        if p2 then
            p2 = p2.Name;
        end;

        v6("[CK] unknown CK_OpticId \'" .. v7 .. "\' on " .. tostring(p2) .. "; using DEFAULT optic");
    end;

    if v5 then
        if v5.magStops and #v5.magStops > 0 then
            v3.magStops = v5.magStops;
            v3.magMin = v5.magStops[1];
            v3.magMax = v5.magStops[#v5.magStops];
        end;

        if v5.magMin or v5.magMax then
            v3.magMin = v5.magMin or v3.magMin;
            v3.magMax = v5.magMax or v3.magMax;

            if not v5.magStops then
                v3.magStops = nil;
            end;
        end;

        if v5.magStart then
            v3.magStart = v5.magStart;
        end;

        if v5.zoomFov then
            v3.zoomFov = v5.zoomFov;
        end;

        v3.reticles = v5.reticles;
        v3.profile = v5.profile;
        v3.displayName = v5.displayName;
        v3.magDecals = v5.magDecals;
        v3.ffp = v5.ffp;
        v3.milPerDot = v5.milPerDot;
        local v8 = nil;

        for _, v in ipairs(v5.reticles or {}) do
            if v.style == "image" and v.image then
                v8 = v.image;
                break;
            end;
        end;

        v3.reticleId = v8;
    end;

    return v3;
end;

return u1;