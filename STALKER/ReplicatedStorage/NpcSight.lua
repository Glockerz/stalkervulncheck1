-- Decompiled with Potassium's decompiler.

local u1 = {
    CONCEAL_PREFIXES = { "SM_Grass_" },
    MAX_CONCEAL_LAYERS = 4,
    CONCEAL_RANGE_STEP = 0.3,
    CONCEAL_RANGE_FLOOR = 0.25
};

function u1.IsConcealing(p2: userdata) -- Line: 62
    -- upvalues: u1 (copy)
    if not p2:IsA("BasePart") or p2.CanCollide then
        return false;
    end;

    local Name = p2.Name;

    for _, v in ipairs(u1.CONCEAL_PREFIXES) do
        if string.sub(Name, 1, #v) == v then
            return true;
        end;
    end;

    return false;
end;

u1.CONCEAL_SPREAD_PER_LAYER = 0.5;
u1.CONCEAL_SPREAD_MAX_LAYERS = 3;

function u1.ConcealSpreadMult(p3: number?) -- Line: 77
    -- upvalues: u1 (copy)
    return 1 + u1.CONCEAL_SPREAD_PER_LAYER * math.clamp(p3 or 0, 0, u1.CONCEAL_SPREAD_MAX_LAYERS);
end;

function u1.ConcealRangeMult(p4: number?) -- Line: 82
    -- upvalues: u1 (copy)
    return math.max(u1.CONCEAL_RANGE_FLOOR, 1 - u1.CONCEAL_RANGE_STEP * (p4 or 0));
end;

function u1.IsGhost(p5: userdata) -- Line: 86
    local v6 = p5:IsA("BasePart") and not p5.CanCollide and p5.Transparency >= 0.95;

    return v6;
end;

function u1.Cast(p7: vector, p8: vector, p9: userdata) -- Line: 96
    -- upvalues: u1 (copy)
    local v10 = workspace:Raycast(p7, p8, p9);

    if not v10 then
        return nil, 0;
    end;

    local v11 = u1.IsGhost(v10.Instance);

    if not (v11 or u1.IsConcealing(v10.Instance)) then
        return v10, 0;
    end;

    local FilterDescendantsInstances = p9.FilterDescendantsInstances;
    local table_clone_ret = table.clone(FilterDescendantsInstances);
    local v12 = 0;
    local v13 = 0;

    while true do
        if v11 then
            v12 = v12 + 1;

            if v12 > 8 then
                p9.FilterDescendantsInstances = FilterDescendantsInstances;

                return nil, v13;
            end;
        else
            v13 = v13 + 1;

            if u1.MAX_CONCEAL_LAYERS < v13 then
                p9.FilterDescendantsInstances = FilterDescendantsInstances;

                return v10, v13;
            end;
        end;

        table.insert(table_clone_ret, v10.Instance);
        p9.FilterDescendantsInstances = table_clone_ret;
        v10 = workspace:Raycast(p7, p8, p9);

        if not v10 then
            p9.FilterDescendantsInstances = FilterDescendantsInstances;

            return nil, v13;
        end;

        v11 = u1.IsGhost(v10.Instance);

        if not (v11 or u1.IsConcealing(v10.Instance)) then
            p9.FilterDescendantsInstances = FilterDescendantsInstances;

            return v10, v13;
        end;
    end;
end;

return u1;