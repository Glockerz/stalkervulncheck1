-- Decompiled with Potassium's decompiler.

local u1 = {
    AGGRO_MUTANT_WEIGHT = 0.8,
    CALM_RANGE = 20,
    CALM_MUTANT_WEIGHT = 1.5,
    MUTANT_RANGE = 120,
    STICK = 0.7
};

function u1.Effective(p2, p3) -- Line: 26
    -- upvalues: u1 (copy)
    local v4;

    if p3.kind == "mutant" then
        if u1.MUTANT_RANGE < p2 then
            return nil;
        end;

        if p3.aggro then
            v4 = u1.AGGRO_MUTANT_WEIGHT;
        else
            if p2 > u1.CALM_RANGE then
                return nil;
            end;

            v4 = u1.CALM_MUTANT_WEIGHT;
        end;
    else
        v4 = 1;
    end;

    if p3.current then
        v4 = v4 * u1.STICK;
    end;

    return p2 * v4;
end;

return u1;