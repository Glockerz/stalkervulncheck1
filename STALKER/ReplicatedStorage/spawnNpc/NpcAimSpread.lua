-- Decompiled with Potassium's decompiler.

local v1 = {};

local function basis(p2) -- Line: 18
    local v3 = p2:Cross(Vector3.new(0, 1, 0));
    local v4 = v3.Magnitude < 0.0001 and Vector3.new(1, 0, 0) or v3.Unit;

    return v4, v4:Cross(p2).Unit;
end;

function v1.Offset(p5, p6, p7, p8) -- Line: 26
    local v9 = p6 - p5;

    if v9.Magnitude < 0.0001 then
        return Vector3.new(0, 0, 0);
    end;

    local Unit = v9.Unit;
    local v10 = Unit:Cross(Vector3.new(0, 1, 0));
    local v11 = v10.Magnitude < 0.0001 and Vector3.new(1, 0, 0) or v10.Unit;
    local Unit2 = v11:Cross(Unit).Unit;

    return v11 * p7 + Unit2 * p8;
end;

function v1.Jitter(p12, p13, p14) -- Line: 35
    local v15 = p14 or Random.new();
    local Unit = p12.Unit;
    local v16 = Unit:Cross(Vector3.new(0, 1, 0));
    local v17 = v16.Magnitude < 0.0001 and Vector3.new(1, 0, 0) or v16.Unit;
    local Unit2 = v17:Cross(Unit).Unit;

    return (p12 + v17 * v15:NextNumber(-p13, p13) + Unit2 * v15:NextNumber(-p13, p13)).Unit;
end;

return v1;