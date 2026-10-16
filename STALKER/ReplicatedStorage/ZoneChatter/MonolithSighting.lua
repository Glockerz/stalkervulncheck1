-- Decompiled with Potassium's decompiler.

local u1 = {
    RADIUS = 150,
    OFFSET_FRAC = 0.6,
    SECONDS = 300,
    NEAR_STUDS = 120,
    FAR_STUDS = 1500
};
local u2 = { "north", "north-east", "east", "south-east", "south", "south-west", "west", "north-west" };

local function said(p3: table) -- Line: 28
    if p3.radio then
        return p3.radio;
    end;

    if p3.name:lower():sub(1, 4) == "the " then
        return "the " .. p3.name:sub(5);
    end;

    return "the " .. p3.name;
end;

function u1.Area(p4: vector, p5: table) -- Line: 35
    -- upvalues: u1 (copy), u2 (copy)
    local v6 = (1 / 0);
    local v7 = nil;

    for _, v in ipairs(p5 or {}) do
        local v8 = v.cf:PointToObjectSpace(p4);
        local v9 = math.abs(v8.X) - v.size.X / 2;
        local math_max_ret = math.max(v9, 0);
        local v10 = math.abs(v8.Z) - v.size.Z / 2;
        local math_max_ret2 = math.max(v10, 0);
        local math_sqrt_ret = math.sqrt(math_max_ret * math_max_ret + math_max_ret2 * math_max_ret2);

        if math_sqrt_ret < v6 then
            v7 = v;
            v6 = math_sqrt_ret;
        end;
    end;

    if not v7 or u1.FAR_STUDS < v6 then
        return nil;
    end;

    if v6 <= u1.NEAR_STUDS then
        local v11;

        if v7.radio then
            v11 = v7.radio;
        elseif v7.name:lower():sub(1, 4) == "the " then
            v11 = "the " .. v7.name:sub(5);
        else
            v11 = "the " .. v7.name;
        end;

        return "near " .. v11;
    end;

    local v12 = p4 - v7.cf.Position;
    local math_atan2_ret = math.atan2(v12.X, -v12.Z);
    local v13 = (math.deg(math_atan2_ret) + 360) % 360;
    local v14 = u2[math.floor((v13 + 22.5) / 45) % 8 + 1];
    local v15;

    if v7.radio then
        v15 = v7.radio;
    elseif v7.name:lower():sub(1, 4) == "the " then
        v15 = "the " .. v7.name:sub(5);
    else
        v15 = "the " .. v7.name;
    end;

    return v14 .. " of " .. v15;
end;

function u1.Center(p16: vector, p17: userdata?) -- Line: 53
    -- upvalues: u1 (copy)
    local v18 = p17 or Random.new();
    local v19 = v18:NextNumber() * 3.141592653589793 * 2;
    local v20 = v18:NextNumber();
    local v21 = math.sqrt(v20) * u1.RADIUS * u1.OFFSET_FRAC;
    local v22 = p16.X + math.cos(v19) * v21;
    local Y = p16.Y;
    local v23 = p16.Z + math.sin(v19) * v21;

    return Vector3.new(v22, Y, v23);
end;

local u24 = {
    Monolith = {
        label = "MONOLITH SIGHTING",
        color = Color3.fromRGB(235, 235, 245)
    },
    Military = {
        label = "MILITARY PATROL",
        color = Color3.fromRGB(150, 195, 110)
    }
};
local u25 = {
    label = "SIGHTING",
    color = Color3.fromRGB(230, 200, 120)
};

function u1.Style(p26: string?) -- Line: 68
    -- upvalues: u24 (copy), u25 (copy)
    return p26 and u24[p26] or u25;
end;

function u1.Live(p27: table, p28: number) -- Line: 72
    local v29;

    if type(p27) == "table" and type(p27.expiresAt) == "number" then
        v29 = p28 < p27.expiresAt;
    else
        v29 = false;
    end;

    return v29;
end;

return u1;