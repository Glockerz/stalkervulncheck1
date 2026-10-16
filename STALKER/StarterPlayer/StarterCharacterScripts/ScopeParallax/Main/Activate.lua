-- Decompiled with Potassium's decompiler.

local v1 = {};
local RunService = game:GetService("RunService");
game:GetService("ReplicatedStorage");
game:GetService("StarterPlayer"):WaitForChild("StarterCharacterScripts");
local workspace_CurrentCamera = workspace.CurrentCamera;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = 3.75;
local u9 = 3.45;
local u10 = 0;
local u11 = nil;

local function updateFocus() -- Line: 33
    -- upvalues: u5 (ref), u3 (ref), u4 (ref), workspace_CurrentCamera (copy), u10 (ref), u9 (ref), u8 (ref), u2 (ref), u6 (ref), u11 (ref)
    local v12 = u5[1];

    if u3.Parent == nil or not v12 then
        u4:Disconnect();

        return;
    end;

    local v13 = u3.AimPart.CFrame:ToObjectSpace(v12.CFrame);
    local CFrame_new_ret = CFrame.new(v13.Position.X, -v13.Position.Y, 0);
    local v14 = v12.CFrame * CFrame.new(-v12.Size.X / 2, 0, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
    local v15 = v12.CFrame * CFrame.new(v12.Size.X / 2, 0, 0) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame_new_ret;
    local v16 = workspace_CurrentCamera.CFrame:ToObjectSpace(v15);
    local v17 = v14:ToObjectSpace(workspace_CurrentCamera.CFrame);
    local v18 = 1 / u10 * u9;
    local v19 = 1 / u10 * u8;
    local v20 = u10 * 2 + v16.Position.Z;
    local v21 = v12.Size.Y * v20 * v19;
    local v22 = v12.Size.Y * 0.5 * (v20 * v19 - 1);
    local v23 = math.tan(-v16.Position.X * u2.focusSensitivity) / u2.eyeboxCurve;
    local v24 = math.tan(v16.Position.Y * u2.focusSensitivity) / u2.eyeboxCurve;
    local v25 = v23 + v22;
    local v26 = v24 + v22;
    local v27 = -v16.Position.Z;
    local v28 = v12.Size.Y * v27 * v18;
    local v29 = v12.Size.Y * 0.5 * (v27 * v18 - 1);
    local v30 = v29 + v17.Position.X;
    local v31 = v29 + v17.Position.Y;
    local v32 = -math.abs(v23 + v24);
    local v33 = -math.abs(u10 - v27);
    u6[1].OffsetStudsU = v25;
    u6[1].OffsetStudsV = v26;
    u6[1].StudsPerTileU = v21;
    u6[1].StudsPerTileV = v21;
    u6[2].OffsetStudsU = v30;
    u6[2].OffsetStudsV = v31;
    u6[2].StudsPerTileU = v28;
    u6[2].StudsPerTileV = v28;
    u6[3].Transparency = 1 + v32 * u2.lightSensitivity + u2.lightDeadzone;
    u6[4].OffsetStudsU = v25;
    u6[4].OffsetStudsV = v26;
    u6[4].StudsPerTileU = v21;
    u6[4].StudsPerTileV = v21;
    u6[4].Transparency = math.max(0, 1 + v32 * u2.ocularCASensitivity + v33 + u2.ocularCADeadzone);
    u6[5].OffsetStudsU = v30;
    u6[5].OffsetStudsV = v31;
    u6[5].StudsPerTileU = v28;
    u6[5].StudsPerTileV = v28;
    u6[5].Transparency = 1 + v32 * u2.objectiveCASensitivity + v33 + u2.objectiveCADeadzone;

    if u11 then
        u11.CFrame = v12.CFrame * CFrame.new(v12.Size.X / 2 - u2.glassOffset, 0, 0);
        local Y = v12.Size.Y;
        local Y2 = v16.Position.Y;

        if Y < math.abs(-v16.Position.X) or Y < math.abs(Y2) then
            u11.Transparency = 1;

            return;
        end;

        u11.Transparency = u2.glassTransparency;
    end;
end;

function v1.start(p34: userdata, p35: table) -- Line: 119
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u3 (ref), u2 (ref), u10 (ref), u11 (ref), u4 (ref), RunService (copy), updateFocus (copy)
    u5 = {};
    u6 = {};
    u7 = {};
    u8 = 3.75;
    u9 = 3.45;
    u3 = p34;
    local Position = (u3.AimPart.CFrame * CFrame.new(0, 0, p35.aimpartZOffset)).Position;
    local v36 = {};

    for _, descendant in u3:GetDescendants() do
        if descendant.Name == "SCOPE_FOCUS" and descendant:IsA("BasePart") then
            u2 = require(descendant:FindFirstChildWhichIsA("ModuleScript"));
            u5[1] = descendant;
            u6[1] = descendant.OcularLens;
            u6[2] = descendant.ObjectiveLens;
            u6[3] = descendant.Light;
            u6[4] = descendant.OcularCA;
            u6[5] = descendant.ObjectiveCA;
            u6[1].Transparency = 0;
            u6[2].Transparency = 0;
            descendant.Transparency = 1;
            u8 = u8 + u2.eyeReliefOffset;
            u9 = u9 - u2.eyeReliefOffset;
            u8 = u8 * u2.ocularLensScale;
            u9 = u9 * u2.objectiveLensScale;
            u10 = (Position - (descendant.CFrame * CFrame.new(descendant.Size.X / 2, 0, 0)).Position).Magnitude;
            p35.parentingMethod(descendant);

            if u2.useGlassEffect then
                u11 = Instance.new("Part");
                local SpecialMesh = Instance.new("SpecialMesh", u11);
                u11.CFrame = descendant.CFrame * CFrame.new(descendant.Size.X / 2 - u2.glassOffset, 0, 0);
                u11.Material = Enum.Material.Glass;
                u11.Color = u2.glassColor;
                u11.Transparency = u2.glassTransparency;
                u11.CanCollide = false;
                SpecialMesh.MeshType = Enum.MeshType.Sphere;
                local Position2 = (descendant.CFrame * CFrame.new(descendant.Size.X / 2, 0, 0)).Position;
                local v37 = descendant.Size.Z * ((Position - u11.Position).Magnitude / (Position - Position2).Magnitude);
                u11.Size = Vector3.new(u2.glassZoomFactor * (1 + (u11.Position - Position2).Magnitude ^ 2), v37, v37);
                u11.Parent = u3;
            end;

            u4 = RunService.PreRender:Connect(updateFocus);
            table.insert(v36, descendant);
        end;
    end;

    return v36;
end;

return v1;