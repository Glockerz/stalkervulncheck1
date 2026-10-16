-- Decompiled with Potassium's decompiler.

local v1 = {};
local Vector3_new_ret = Vector3.new();

function v1.Solve(p2: table, p3: table) -- Line: 11
    -- upvalues: Vector3_new_ret (copy)
    local v4 = p3.Instances[1];
    local v5 = v4.Position + v4.CFrame:VectorToWorldSpace(p3.Instances[2]);

    if not p3.LastPosition then
        p3.LastPosition = v5;
    end;

    local LastPosition = p3.LastPosition;
    local v6 = v5 - (p3.LastPosition or Vector3_new_ret);
    p3.WorldSpace = v5;

    return LastPosition, v6;
end;

function v1.UpdateToNextPosition(p7: table, p8: table) -- Line: 30
    return p8.WorldSpace;
end;

function v1.Visualize(p9: table, p10: table) -- Line: 34
    return CFrame.lookAt(p10.WorldSpace, p10.LastPosition);
end;

return v1;