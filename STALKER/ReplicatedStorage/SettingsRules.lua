-- Decompiled with Potassium's decompiler.

local u1 = {
    DEFAULTS = {
        pdaVolume = 1,
        npcRadio = true,
        shadows = true,
        screenRain = true,
        inventoryBlur = true,
        locationBanner = true,
        toastPosition = "default"
    },
    TOAST_POSITIONS = { "default", "top-right", "bottom-center" }
};

function u1.Defaults() -- Line: 26
    -- upvalues: u1 (copy)
    return table.clone(u1.DEFAULTS);
end;

local function validToastPosition(p2) -- Line: 30
    -- upvalues: u1 (copy)
    return table.find(u1.TOAST_POSITIONS, p2) ~= nil;
end;

function u1.Sanitize(p3) -- Line: 36
    -- upvalues: u1 (copy)
    local v4 = u1.Defaults();

    if type(p3) ~= "table" then
        return v4;
    end;

    for i, v in pairs(u1.DEFAULTS) do
        local v5 = p3[i];

        if i == "pdaVolume" then
            if type(v5) == "number" and v5 == v5 then
                local v6 = math.clamp(v5, 0, 1) * 100 + 0.5;
                v4[i] = math.floor(v6) / 100;
            end;
        elseif i == "toastPosition" then
            if table.find(u1.TOAST_POSITIONS, v5) ~= nil then
                v4[i] = v5;
            end;
        elseif type(v5) == type(v) then
            v4[i] = v5;
        end;
    end;

    return v4;
end;

return u1;