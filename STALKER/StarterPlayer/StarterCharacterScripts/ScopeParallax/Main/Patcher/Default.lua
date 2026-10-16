-- Decompiled with Potassium's decompiler.

local v1 = {
    aimpartZOffset = 0.5
};
local workspace_CurrentCamera = workspace.CurrentCamera;

function v1.autoDetectMethod() -- Line: 7
    return false;
end;

function v1.modelDetectionPath() -- Line: 13
    -- upvalues: workspace_CurrentCamera (copy)
    return workspace_CurrentCamera;
end;

function v1.modelDetectionMethod(p2) -- Line: 17
    return p2:IsA("Model") and p2:FindFirstChildOfClass("Model") or nil;
end;

function v1.parentingMethod(p3: userdata) -- Line: 31
    p3.Parent = workspace;
end;

return v1;