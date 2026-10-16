-- Decompiled with Potassium's decompiler.

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local UserFlag = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserFixOrbitalCameraAzimuth");
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local Players = game:GetService("Players");
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local u1 = setmetatable({}, BaseCamera);
u1.__index = u1;

function u1.new() -- Line: 46
    -- upvalues: BaseCamera (copy), u1 (copy)
    local v2 = BaseCamera.new();
    local v3 = setmetatable(v2, u1);
    v3.lastUpdate = tick();
    v3.changedSignalConnections = {};
    v3.refAzimuthRad = nil;
    v3.curAzimuthRad = nil;
    v3.minAzimuthAbsoluteRad = nil;
    v3.maxAzimuthAbsoluteRad = nil;
    v3.useAzimuthLimits = nil;
    v3.curElevationRad = nil;
    v3.minElevationRad = nil;
    v3.maxElevationRad = nil;
    v3.curDistance = nil;
    v3.minDistance = nil;
    v3.maxDistance = nil;
    v3.gamepadDollySpeedMultiplier = 1;
    v3.lastUserPanCamera = tick();
    v3.externalProperties = {};
    v3.externalProperties.InitialDistance = 25;
    v3.externalProperties.MinDistance = 10;
    v3.externalProperties.MaxDistance = 100;
    v3.externalProperties.InitialElevation = 35;
    v3.externalProperties.MinElevation = 35;
    v3.externalProperties.MaxElevation = 35;
    v3.externalProperties.ReferenceAzimuth = -45;
    v3.externalProperties.CWAzimuthTravel = 90;
    v3.externalProperties.CCWAzimuthTravel = 90;
    v3.externalProperties.UseAzimuthLimits = false;
    v3:LoadNumberValueParameters();

    return v3;
end;

function u1.LoadOrCreateNumberValueParameter(u4: table, u5: string, p6: any, u7: any) -- Line: 85
    local v8 = script:FindFirstChild(u5);

    if v8 and v8:IsA(p6) then
        u4.externalProperties[u5] = v8.Value;
    else
        if u4.externalProperties[u5] == nil then
            return;
        end;

        v8 = Instance.new(p6);
        v8.Name = u5;
        v8.Parent = script;
        v8.Value = u4.externalProperties[u5];
    end;

    if u7 then
        if u4.changedSignalConnections[u5] then
            u4.changedSignalConnections[u5]:Disconnect();
        end;

        u4.changedSignalConnections[u5] = v8.Changed:Connect(function(p9) -- Line: 105
            -- upvalues: u4 (copy), u5 (copy), u7 (copy)
            u4.externalProperties[u5] = p9;
            u7(u4);
        end);
    end;
end;

function u1.SetAndBoundsCheckAzimuthValues(p10) -- Line: 112
    local math_rad_ret = math.rad(p10.externalProperties.ReferenceAzimuth);
    local math_rad_ret2 = math.rad(p10.externalProperties.CWAzimuthTravel);
    p10.minAzimuthAbsoluteRad = math_rad_ret - math.abs(math_rad_ret2);
    local math_rad_ret3 = math.rad(p10.externalProperties.ReferenceAzimuth);
    local math_rad_ret4 = math.rad(p10.externalProperties.CCWAzimuthTravel);
    p10.maxAzimuthAbsoluteRad = math_rad_ret3 + math.abs(math_rad_ret4);
    p10.useAzimuthLimits = p10.externalProperties.UseAzimuthLimits;

    if p10.useAzimuthLimits then
        p10.curAzimuthRad = math.max(p10.curAzimuthRad, p10.minAzimuthAbsoluteRad);
        p10.curAzimuthRad = math.min(p10.curAzimuthRad, p10.maxAzimuthAbsoluteRad);
    end;
end;

function u1.SetAndBoundsCheckElevationValues(p11) -- Line: 122
    local math_max_ret = math.max(p11.externalProperties.MinElevation, -80);
    local math_min_ret = math.min(p11.externalProperties.MaxElevation, 80);
    local math_min_ret2 = math.min(math_max_ret, math_min_ret);
    p11.minElevationRad = math.rad(math_min_ret2);
    local math_max_ret2 = math.max(math_max_ret, math_min_ret);
    p11.maxElevationRad = math.rad(math_max_ret2);
    p11.curElevationRad = math.max(p11.curElevationRad, p11.minElevationRad);
    p11.curElevationRad = math.min(p11.curElevationRad, p11.maxElevationRad);
end;

function u1.SetAndBoundsCheckDistanceValues(p12) -- Line: 138
    p12.minDistance = p12.externalProperties.MinDistance;
    p12.maxDistance = p12.externalProperties.MaxDistance;
    p12.curDistance = math.max(p12.curDistance, p12.minDistance);
    p12.curDistance = math.min(p12.curDistance, p12.maxDistance);
end;

function u1.LoadNumberValueParameters(p13) -- Line: 146
    -- upvalues: UserFlag (copy)
    p13:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil);
    p13:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil);
    local v14;

    if UserFlag then
        v14 = p13.SetAndBoundsCheckAzimuthValues;
    else
        v14 = p13.SetAndBoundsCheckAzimuthValue;
    end;

    p13:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", v14);
    p13:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", p13.SetAndBoundsCheckAzimuthValues);
    p13:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", p13.SetAndBoundsCheckAzimuthValues);
    p13:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", p13.SetAndBoundsCheckElevationValues);
    p13:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", p13.SetAndBoundsCheckElevationValues);
    p13:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", p13.SetAndBoundsCheckDistanceValues);
    p13:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", p13.SetAndBoundsCheckDistanceValues);
    p13:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", p13.SetAndBoundsCheckAzimuthValues);
    p13.curAzimuthRad = math.rad(p13.externalProperties.ReferenceAzimuth);
    p13.curElevationRad = math.rad(p13.externalProperties.InitialElevation);
    p13.curDistance = p13.externalProperties.InitialDistance;
    p13:SetAndBoundsCheckAzimuthValues();
    p13:SetAndBoundsCheckElevationValues();
    p13:SetAndBoundsCheckDistanceValues();
end;

function u1.GetModuleName(p15) -- Line: 172
    return "OrbitalCamera";
end;

function u1.SetInitialOrientation(p16: table, p17: userdata) -- Line: 176
    -- upvalues: CameraUtils (copy)
    if not (p17 and p17.RootPart) then
        warn("OrbitalCamera could not set initial orientation due to missing humanoid");

        return;
    end;

    assert(p17.RootPart, "");
    local Unit = (p17.RootPart.CFrame.LookVector - Vector3.new(0, 0.23, 0)).Unit;
    local AngleBetweenXZVectors = CameraUtils.GetAngleBetweenXZVectors(Unit, p16:GetCameraLookVector());
    local Y = p16:GetCameraLookVector().Y;
    local v18 = math.asin(Y) - math.asin(Unit.Y);
    CameraUtils.IsFinite(AngleBetweenXZVectors);
    CameraUtils.IsFinite(v18);
end;

function u1.GetCameraToSubjectDistance(p19) -- Line: 194
    return p19.curDistance;
end;

function u1.SetCameraToSubjectDistance(p20, p21) -- Line: 198
    -- upvalues: Players (copy)
    if Players.LocalPlayer then
        p20.currentSubjectDistance = math.clamp(p21, p20.minDistance, p20.maxDistance);
        p20.currentSubjectDistance = math.max(p20.currentSubjectDistance, p20.FIRST_PERSON_DISTANCE_THRESHOLD);
    end;

    p20.inFirstPerson = false;
    p20:UpdateMouseBehavior();

    return p20.currentSubjectDistance;
end;

function u1.CalculateNewLookVector(p22: table, p23: vector, p24) -- Line: 211
    local v25 = p23 or p22:GetCameraLookVector();
    local math_asin_ret = math.asin(v25.Y);
    local math_clamp_ret = math.clamp(p24.Y, math_asin_ret - 1.3962634015954636, math_asin_ret - -1.3962634015954636);
    local Vector2_new_ret = Vector2.new(p24.X, math_clamp_ret);
    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), v25);

    return (CFrame.Angles(0, -Vector2_new_ret.X, 0) * CFrame_new_ret * CFrame.Angles(-Vector2_new_ret.Y, 0, 0)).LookVector;
end;

function u1.Update(p26: table, p27: number) -- Line: 222
    -- upvalues: CameraInput (copy), Players (copy)
    local v28 = tick();
    local v29 = v28 - p26.lastUpdate;
    local v30 = CameraInput.getRotation(p27) ~= Vector2.new();
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local Focus = workspace_CurrentCamera.Focus;
    local LocalPlayer = Players.LocalPlayer;
    local v31;

    if workspace_CurrentCamera then
        v31 = workspace_CurrentCamera.CameraSubject;
    else
        v31 = workspace_CurrentCamera;
    end;

    local v32;

    if v31 then
        v32 = v31:IsA("VehicleSeat");
    else
        v32 = v31;
    end;

    local v33;

    if v31 then
        v33 = v31:IsA("SkateboardPlatform");
    else
        v33 = v31;
    end;

    if p26.lastUpdate == nil or v29 > 1 then
        p26.lastCameraTransform = nil;
    end;

    if v30 then
        p26.lastUserPanCamera = tick();
    end;

    local SubjectPosition = p26:GetSubjectPosition();

    if SubjectPosition and (LocalPlayer and workspace_CurrentCamera) then
        if p26.gamepadDollySpeedMultiplier ~= 1 then
            p26:SetCameraToSubjectDistance(p26.currentSubjectDistance * p26.gamepadDollySpeedMultiplier);
        end;

        Focus = CFrame.new(SubjectPosition);
        local Rotation = CameraInput.getRotation(p27);
        p26.curAzimuthRad = p26.curAzimuthRad - Rotation.X;

        if p26.useAzimuthLimits then
            p26.curAzimuthRad = math.clamp(p26.curAzimuthRad, p26.minAzimuthAbsoluteRad, p26.maxAzimuthAbsoluteRad);
        else
            p26.curAzimuthRad = p26.curAzimuthRad == 0 and 0 or (math.sign(p26.curAzimuthRad) * (math.abs(p26.curAzimuthRad) % 6.283185307179586) or 0);
        end;

        p26.curElevationRad = math.clamp(p26.curElevationRad + Rotation.Y, p26.minElevationRad, p26.maxElevationRad);
        local v34 = SubjectPosition + p26.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-p26.curElevationRad, p26.curAzimuthRad, 0) * Vector3.new(0, 0, 1));
        CFrame2 = CFrame.new(v34, SubjectPosition);
        p26.lastCameraTransform = CFrame2;
        p26.lastCameraFocus = Focus;

        if (v32 or v33) and v31:IsA("BasePart") then
            p26.lastSubjectCFrame = v31.CFrame;
        else
            p26.lastSubjectCFrame = nil;
        end;
    end;

    p26.lastUpdate = v28;

    return CFrame2, Focus;
end;

return u1;