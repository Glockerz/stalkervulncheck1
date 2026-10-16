-- Decompiled with Potassium's decompiler.

local v1 = {};
local Vector3_new_ret = Vector3.new();

function v1.Solve(p2: table, p3: table) -- Line: 11
    -- upvalues: Vector3_new_ret (copy)
    local v4 = p3.Instances[1].TransformedWorldCFrame.Position + p3.Instances[2];

    if not p3.LastPosition then
        p3.LastPosition = v4;
    end;

    local LastPosition = p3.LastPosition;
    local v5 = v4 - (p3.LastPosition or Vector3_new_ret);
    p3.WorldSpace = v4;

    return LastPosition, v5;
end;

function v1.UpdateToNextPosition(p6: table, p7: table) -- Line: 30
    return p7.WorldSpace;
end;

function v1.Visualize(p8: table, p9: table) -- Line: 34
    return CFrame.lookAt(p9.WorldSpace, p9.LastPosition);
end;

return v1;