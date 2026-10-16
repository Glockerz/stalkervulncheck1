-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {
    speed = 1,
    drain = 1,
    regen = 1,
    partChance = 1
};

local function num(p3) -- Line: 23
    local v4 = tonumber(p3);

    if v4 == nil or v4 ~= v4 then
        return nil;
    end;

    return v4;
end;

function u1.For(p5) -- Line: 29
    -- upvalues: u2 (copy)
    if type(p5) ~= "table" or p5.ItemType ~= "Backpack" then
        return u2;
    end;

    local v6 = {};
    local v7 = tonumber(p5.MoveSpeedMult);

    if v7 == nil or v7 ~= v7 then
        v7 = nil;
    end;

    v6.speed = math.clamp(v7 or 1, 0.1, 1);
    local v8 = tonumber(p5.StaminaDrainMult);

    if v8 == nil or v8 ~= v8 then
        v8 = nil;
    end;

    v6.drain = math.max(1, v8 or 1);
    local v9 = tonumber(p5.StaminaRegenMult);

    if v9 == nil or v9 ~= v9 then
        v9 = nil;
    end;

    v6.regen = math.clamp(v9 or 1, 0, 1);
    local v10 = tonumber(p5.ButcherPartChanceMult);

    if v10 == nil or v10 ~= v10 then
        v10 = nil;
    end;

    v6.partChance = math.max(1, v10 or 1);

    return v6;
end;

local function pct(p11: number) -- Line: 39
    local v12 = math.abs(p11) * 100 + 0.5;

    return math.floor(v12);
end;

function u1.Rows(p13) -- Line: 44
    -- upvalues: u1 (copy)
    local v14 = u1.For(p13);
    local v15 = {};

    if v14.speed < 1 then
        local v16 = {};
        local v17 = math.abs(1 - v14.speed) * 100 + 0.5;
        v16[1], v16[2], v16[3] = "Movement", ("-%d%%"):format((math.floor(v17))), false;
        table.insert(v15, v16);
    end;

    if v14.drain > 1 then
        local v18 = {};
        local v19 = math.abs(v14.drain - 1) * 100 + 0.5;
        v18[1], v18[2], v18[3] = "Sprint stamina", ("+%d%%"):format((math.floor(v19))), false;
        table.insert(v15, v18);
    end;

    if v14.regen < 1 then
        local v20 = {};
        local v21 = math.abs(1 - v14.regen) * 100 + 0.5;
        v20[1], v20[2], v20[3] = "Stamina recovery", ("-%d%%"):format((math.floor(v21))), false;
        table.insert(v15, v20);
    end;

    if v14.partChance > 1 then
        local v22 = { "Butchering", ("trophy part chance x%s"):format((tostring(v14.partChance))), true };
        table.insert(v15, v22);
    end;

    return v15;
end;

function u1.Lines(p23) -- Line: 57
    -- upvalues: u1 (copy)
    local v24 = {};

    for _, v in ipairs(u1.Rows(p23)) do
        table.insert(v24, v[1] .. " " .. v[2]);
    end;

    return v24;
end;

return u1;