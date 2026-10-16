-- Decompiled with Potassium's decompiler.

local success, result = pcall(function() -- Line: 8
    return UserSettings():IsUserFeatureEnabled("UserVRVehicleCameraOrbital");
end);
local u1 = success and result;
local u2 = { 0, 30 };
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local VRService = game:GetService("VRService");
local Lighting = game:GetService("Lighting");
local LocalPlayer = Players.LocalPlayer;
local mapClamp = CameraUtils.mapClamp;
local VehicleCameraConfig = require(script.Parent:WaitForChild("VehicleCamera"):FindFirstChild("VehicleCameraConfig"));
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.IgnoreWater = true;

local function yawVelocity(p3: vector, p4) -- Line: 44
    local v5 = p4.YVector:Dot(p3);

    return math.abs(v5);
end;

local function computeCameraCFrame(p6, p7: vector, p8: number) -- Line: 48
    local math_atan2_ret = math.atan2(p7.X, p7.Z);

    return CFrame.new(p6.Position + p7 * p8) * CFrame.Angles(0, math_atan2_ret, 0);
end;

local function vrOccludeDisplace(p9, p10: vector, p11: number, p12: userdata?) -- Line: 53
    -- upvalues: LocalPlayer (copy), RaycastParams_new_ret (copy)
    local math_atan2_ret = math.atan2(p10.X, p10.Z);
    local v13 = CFrame.new(p9.Position + p10 * p11) * CFrame.Angles(0, math_atan2_ret, 0);
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return v13;
    end;

    local Position = p9.Position;
    local v14 = (v13.Position - Position) * Vector3.new(1, 0, 1);
    local Magnitude = v14.Magnitude;

    if Magnitude < 0.5 then
        return v13;
    end;

    local v15 = { workspace_CurrentCamera };

    if p12 then
        table.insert(v15, p12);
    end;

    local v16 = LocalPlayer and LocalPlayer.Character;

    if v16 then
        table.insert(v15, v16);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v15;
    local Unit = v14.Unit;
    local v17 = workspace:Raycast(Position, v14, RaycastParams_new_ret);

    if v17 and v17.Normal:Dot(Unit) < 0 then
        local v18 = (v17.Position - Position).Magnitude - 0.5;

        if v18 < Magnitude then
            local math_max_ret = math.max(v18, 0.5);

            return CFrame.new(p9.Position + Unit * math_max_ret) * v13.Rotation;
        end;
    end;

    return v13;
end;

local OverlapParams_new_ret = OverlapParams.new();
OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;

local function findObstructions(p19, p20, p21: number, p22: userdata?) -- Line: 89
    -- upvalues: VRService (copy), LocalPlayer (copy), RaycastParams_new_ret (copy), OverlapParams_new_ret (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return 0, {};
    end;

    local Position = p20.Position;
    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local v23 = p19 * (CFrame.new(UserCFrame.Position * workspace_CurrentCamera.HeadScale) * UserCFrame.Rotation);
    local v24 = v23.Position - Position;
    local Magnitude = v24.Magnitude;

    if Magnitude < 0.5 then
        return 0, {};
    end;

    local v25 = { workspace_CurrentCamera };

    if p22 then
        table.insert(v25, p22);
    end;

    local v26 = LocalPlayer and LocalPlayer.Character;

    if v26 then
        table.insert(v25, v26);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v25;
    local v27 = workspace:Raycast(Position, v24, RaycastParams_new_ret);

    if v27 then
        local Magnitude2 = (v27.Position - Position).Magnitude;

        if Magnitude2 < Magnitude then
            local v28 = (1 - -v24.Unit:Dot(v23.LookVector)) / 0.1339745962155613;
            local math_clamp_ret = math.clamp(v28, 0, 1);
            local math_max_ret = math.max(math_clamp_ret, 1 - Magnitude2 / p21, 0.15);
            local Position2 = v27.Position;
            local Position3 = v23.Position;
            local Vector3_new_ret = Vector3.new(2, 2, (Position3 - Position2).Magnitude);
            local CFrame_lookAt_ret = CFrame.lookAt((Position2 + Position3) / 2, Position3);
            OverlapParams_new_ret.FilterDescendantsInstances = v25;

            return math_max_ret, workspace:GetPartBoundsInBox(CFrame_lookAt_ret, Vector3_new_ret, OverlapParams_new_ret);
        end;
    end;

    return 0, {};
end;

local u29 = 0.016666666666666666;
local u30 = setmetatable({}, VRBaseCamera);
u30.__index = u30;

function u30.new() -- Line: 141
    -- upvalues: u1 (ref), VRBaseCamera (copy), u30 (copy), RunService (copy), u29 (ref)
    if not u1 then
        return require(script.Parent:WaitForChild("VRVehicleCameraDeprecated")).new();
    end;

    local v31 = VRBaseCamera.new();
    local v32 = setmetatable(v31, u30);
    v32.skipOcclusion = true;
    v32:Reset();

    if v32.thirdPersonOptionChanged then
        v32.thirdPersonOptionChanged:Disconnect();
        v32.thirdPersonOptionChanged = nil;
    end;

    RunService.Stepped:Connect(function(p33: number, p34: number) -- Line: 156
        -- upvalues: u29 (ref)
        u29 = p34;
    end);

    return v32;
end;

function u30.Reset(p35) -- Line: 163
    -- upvalues: CameraUtils (copy), u2 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v36;

    if workspace_CurrentCamera then
        v36 = workspace_CurrentCamera.CameraSubject;
    else
        v36 = workspace_CurrentCamera;
    end;

    assert(workspace_CurrentCamera, "VRVehicleCamera initialization error");
    assert(v36);
    assert(v36:IsA("VehicleSeat"));
    p35.lastOrbitalDir = nil;
    p35.wasInFirstPerson = nil;
    local ConnectedParts = v36:GetConnectedParts(true);
    table.insert(ConnectedParts, v36);
    local LooseBoundingSphere, v37 = CameraUtils.getLooseBoundingSphere(ConnectedParts);
    p35.vehicleModel = v36:FindFirstAncestorOfClass("Model") or v36.Parent;
    p35.assemblyRadius = math.max(v37, 5);
    p35.assemblyOffset = v36.CFrame:Inverse() * LooseBoundingSphere;
    p35.gamepadZoomLevels = {};

    for _, v in u2 do
        table.insert(p35.gamepadZoomLevels, v * p35.headScale * p35.assemblyRadius / 10);
    end;

    p35.lastCameraFocus = nil;

    if not p35:IsInFirstPerson() then
        p35:SetCameraToSubjectDistance(p35.gamepadZoomLevels[#p35.gamepadZoomLevels]);
    end;

    p35.needsReset = false;
end;

function u30._getThirdPersonLocalOffset(p38) -- Line: 197
    -- upvalues: VehicleCameraConfig (copy)
    return p38.assemblyOffset + Vector3.new(0, p38.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0);
end;

function u30._getFirstPersonLocalOffset(p39: table, p40) -- Line: 201
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character and Character.Parent then
        local Head = Character:FindFirstChild("Head");

        if Head and Head:IsA("BasePart") then
            return p40:Inverse() * Head.Position;
        end;
    end;

    return p39:_getThirdPersonLocalOffset();
end;

function u30._vrOccludeVignette(p41: table, p42, p43: vector, p44: number) -- Line: 215
    -- upvalues: findObstructions (copy), Lighting (copy), LocalPlayer (copy)
    local math_atan2_ret = math.atan2(p43.X, p43.Z);
    local v45 = CFrame.new(p42.Position + p43 * p44) * CFrame.Angles(0, math_atan2_ret, 0);
    local v46, v47 = findObstructions(v45, p42, p44, p41.vehicleModel);
    local VRFade = Lighting:FindFirstChild("VRFade");

    if not VRFade then
        VRFade = Instance.new("ColorCorrectionEffect");
        VRFade.Name = "VRFade";
        VRFade.Parent = Lighting;
    end;

    VRFade.Brightness = -v46;

    if p41.lastOccludedParts then
        for _, v in p41.lastOccludedParts do
            v.LocalTransparencyModifier = 0;
        end;
    end;

    if #v47 > 0 then
        for _, v in v47 do
            v.LocalTransparencyModifier = 1;
        end;

        p41:StartVREdgeBlur(LocalPlayer, true);
    end;

    p41.lastOccludedParts = v47;

    return v45;
end;

function u30.Update(p48) -- Line: 242
    -- upvalues: u29 (ref), LocalPlayer (copy)
    local v49 = u29;
    u29 = 0;
    p48:UpdateFadeFromBlack(v49);
    p48:UpdateEdgeBlur(LocalPlayer, v49);
    local v50, v51 = p48:_updateStepRotation(v49);

    return v50, v51;
end;

function u30._updateStepRotation(p52: table, p53: number) -- Line: 254
    -- upvalues: mapClamp (copy), CameraInput (copy), VehicleCameraConfig (copy), vrOccludeDisplace (copy)
    local SubjectCFrame = p52:GetSubjectCFrame();
    local CameraToSubjectDistance = p52:GetCameraToSubjectDistance();
    local v54 = mapClamp(CameraToSubjectDistance, 0.5, p52.assemblyRadius, 1, 0);
    local v55 = SubjectCFrame * p52:_getThirdPersonLocalOffset():Lerp(p52:_getFirstPersonLocalOffset(SubjectCFrame), v54);
    local CFrame_new = CFrame.new;
    local CameraHeight = p52:GetCameraHeight();
    local v56 = CFrame_new(v55 + Vector3.new(0, CameraHeight, 0));

    if p52.needsReset or p52.recentered then
        p52.lastOrbitalDir = nil;
        p52.needsReset = false;
        p52.recentered = false;
    end;

    local lastOrbitalDir = p52.lastOrbitalDir;

    if not lastOrbitalDir then
        lastOrbitalDir = (SubjectCFrame.LookVector * Vector3.new(-1, 0, -1)).Unit;
        p52:StartFadeFromBlack();
    end;

    local v57 = (p52:GetSubjectVelocity() * Vector3.new(1, 0, 1)).Magnitude > 2;

    if v57 then
        CameraInput.getRotation(p53);
    else
        local Rotation = p52:getRotation(p53);

        if math.abs(Rotation) > 0 then
            lastOrbitalDir = (CFrame.Angles(0, -Rotation, 0) * CFrame.new(lastOrbitalDir)).Position.Unit;
            p52.lastRotateTime = os.clock();
        end;
    end;

    local v58;

    if p52:IsInFirstPerson() then
        if not p52.wasInFirstPerson or v57 then
            lastOrbitalDir = (SubjectCFrame.LookVector * Vector3.new(-1, 0, -1)).Unit;
            p52.wasInFirstPerson = true;
        end;

        local math_atan2_ret = math.atan2(-SubjectCFrame.LookVector.X, -SubjectCFrame.LookVector.Z);

        if p52.lastVehicleYaw then
            local v59 = (math_atan2_ret - p52.lastVehicleYaw + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;

            if math.abs(v59) > 0.001 then
                lastOrbitalDir = (CFrame.Angles(0, v59, 0) * CFrame.new(lastOrbitalDir)).Position.Unit;
            end;
        end;

        p52.lastVehicleYaw = math_atan2_ret;
        local math_atan2_ret2 = math.atan2(lastOrbitalDir.X, lastOrbitalDir.Z);
        v58 = CFrame.new(v56.Position + lastOrbitalDir * CameraToSubjectDistance) * CFrame.Angles(0, math_atan2_ret2, 0);
    else
        p52.wasInFirstPerson = false;
        p52.lastVehicleYaw = nil;
        local v60 = p52.lastRotateTime and os.clock() - p52.lastRotateTime < VehicleCameraConfig.autocorrectDelay;

        if v57 and not v60 then
            local Unit = (SubjectCFrame.LookVector * Vector3.new(-1, 0, -1)).Unit;
            local v61 = lastOrbitalDir:Dot(Unit);
            local math_clamp_ret = math.clamp(v61, -1, 1);
            local math_acos_ret = math.acos(math_clamp_ret);
            local SubjectRotVelocity = p52:GetSubjectRotVelocity();
            local v62 = SubjectCFrame.YVector:Dot(SubjectRotVelocity);
            local math_abs_ret = math.abs(v62);
            lastOrbitalDir = lastOrbitalDir:Lerp(Unit, (math.min(0.01 + math_acos_ret / 3.141592653589793 * 0.05 + math_abs_ret * 0.02, 0.15)));
        end;

        v58 = vrOccludeDisplace(v56, lastOrbitalDir, CameraToSubjectDistance, p52.vehicleModel);
    end;

    p52.lastOrbitalDir = lastOrbitalDir;

    return v58, v58 * CFrame.new(0, 0, -CameraToSubjectDistance);
end;

return u30;