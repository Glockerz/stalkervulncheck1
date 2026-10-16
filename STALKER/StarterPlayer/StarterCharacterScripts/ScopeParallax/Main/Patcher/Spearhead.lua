-- Decompiled with Potassium's decompiler.

local u1 = {
    aimpartZOffset = 0,
    _SPEARHEAD_FOLDER_NAME = "SPH_Assets"
};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local workspace_CurrentCamera = workspace.CurrentCamera;
local Default = require(script.Parent:WaitForChild("Default"));

function u1.autoDetectMethod() -- Line: 10
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    if ReplicatedStorage:FindFirstChild(u1._SPEARHEAD_FOLDER_NAME) then
        return script.Name;
    end;
end;

function u1.modelDetectionPath() -- Line: 18
    -- upvalues: workspace_CurrentCamera (copy)
    return workspace_CurrentCamera:WaitForChild("WeaponRig"):WaitForChild("Weapon");
end;

function u1.modelDetectionMethod(p2) -- Line: 24
    return p2;
end;

u1.parentingMethod = Default.parentingMethod;

return u1;