-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"));
local v1 = {};
local u2 = nil;
local u3 = 0;
local u4 = 0;
local u5 = nil;
local u6 = nil;
local u7 = nil;

local function frameAlpha(p8, p9) -- Line: 35
    return 1 - (1 - p8) ^ (p9 * 60);
end;

local function lerpAngle(p10, p11, p12) -- Line: 40
    return p10 + ((p11 - p10 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p12;
end;

local function noise3(p13, p14, p15) -- Line: 46
    return math.noise(p13, p14, p15);
end;

local function flattenXZ(p16) -- Line: 48
    return Vector3.new(p16.X, 0, p16.Z);
end;

function v1.Enter(p17, p18) -- Line: 52
    -- upvalues: u2 (ref), u5 (ref), u6 (ref), u7 (ref), u3 (ref), u4 (ref)
    u2 = workspace.CurrentCamera;
    u5 = u2.CameraType;
    u6 = u2.CFrame;
    u7 = u2.FieldOfView;
    u2.CameraType = Enum.CameraType.Scriptable;
    local v19, v20, _ = u6:ToEulerAnglesYXZ();
    u3 = v20;
    u4 = math.clamp(v19, -1.5533430342749532, 1.5533430342749532);
    p18.cameraCFrame = u6;
    p18.smoothedCFrame = u6;
    p18.handheldTime = 0;
    u2.FieldOfView = p18.fov;
end;

function v1.Tick(p21, p22, p23) -- Line: 69
    -- upvalues: u2 (ref), Players (copy), u3 (ref), u4 (ref), CinematicCameraConfig (copy), noise3 (copy)
    if not u2 then
        return;
    end;

    local actions = p22.actions;

    if actions.resetRequested then
        local v24 = Players.LocalPlayer and Players.LocalPlayer.Character;

        if v24 then
            v24 = v24:FindFirstChild("HumanoidRootPart");
        end;

        local v25 = v24 and CFrame.new(v24.Position + Vector3.new(0, 3, 0)) or CFrame.new(0, 20, 0);
        u3 = 0;
        u4 = 0;
        p22.cameraCFrame = v25;
        p22.smoothedCFrame = v25;
        p22.fov = CinematicCameraConfig.Camera.DefaultFOV;
        actions.resetRequested = false;
    end;

    u3 = u3 + actions.look.X;
    u4 = math.clamp(u4 + actions.look.Y, -1.5533430342749532, 1.5533430342749532);

    if p22.lockTarget and (p22.lockTarget.Parent and (actions.look.Magnitude < 0.001 and (p22.lockTarget.Position - p22.cameraCFrame.Position).Magnitude > 0.0001)) then
        local v26, v27 = CFrame.lookAt(p22.cameraCFrame.Position, p22.lockTarget.Position):ToEulerAnglesYXZ();
        local v28 = 1 - (1 - CinematicCameraConfig.Smoothing.RotationAlpha) ^ (p23 * 60);
        local v29 = u3;
        u3 = v29 + ((v27 - v29 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v28;
        u4 = math.clamp(u4 + (v26 - u4) * v28, -1.5533430342749532, 1.5533430342749532);
    end;

    local speed = p22.speed;

    if actions.boost then
        speed = speed * CinematicCameraConfig.Speed.Boost;
    end;

    if actions.precise then
        speed = speed * CinematicCameraConfig.Speed.Precise;
    end;

    local cameraCFrame = p22.cameraCFrame;
    local LookVector = cameraCFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
    local RightVector = cameraCFrame.RightVector;
    local Vector3_new_ret2 = Vector3.new(RightVector.X, 0, RightVector.Z);

    if Vector3_new_ret.Magnitude > 0 then
        Vector3_new_ret = Vector3_new_ret.Unit;
    end;

    if Vector3_new_ret2.Magnitude > 0 then
        Vector3_new_ret2 = Vector3_new_ret2.Unit;
    end;

    local v30 = Vector3_new_ret * actions.move.Z + Vector3_new_ret2 * actions.move.X + Vector3.new(0, actions.move.Y, 0);
    local Position = cameraCFrame.Position;

    if v30.Magnitude > 0.001 then
        Position = Position + v30.Unit * speed * p23;
    end;

    local v31 = CFrame.new(Position) * CFrame.Angles(0, u3, 0) * CFrame.Angles(u4, 0, 0);
    p22.cameraCFrame = v31;

    if p22.mode == "Raw" then
        p22.smoothedCFrame = v31;
        u2.CFrame = v31;
    else
        local v32 = 1 - (1 - CinematicCameraConfig.Smoothing.RotationAlpha) ^ (p23 * 60);
        local smoothedCFrame = p22.smoothedCFrame;
        local v33 = smoothedCFrame.Position:Lerp(v31.Position, 1 - (1 - CinematicCameraConfig.Smoothing.PositionAlpha) ^ (p23 * 60));
        local v34 = (smoothedCFrame - smoothedCFrame.Position):Lerp(v31 - v31.Position, v32);
        local v35 = CFrame.new(v33) * v34;
        p22.smoothedCFrame = v35;

        if p22.mode == "Handheld" then
            p22.handheldTime = p22.handheldTime + p23 * CinematicCameraConfig.Handheld.Frequency;
            local handheldTime = p22.handheldTime;
            local PositionAmplitude = CinematicCameraConfig.Handheld.PositionAmplitude;
            local RotationAmplitude = CinematicCameraConfig.Handheld.RotationAmplitude;
            local math_noise_ret = math.noise(handheldTime, 0, 0);
            local math_noise_ret2 = math.noise(handheldTime, 100, 0);
            local v36 = Vector3.new(math_noise_ret, math_noise_ret2, noise3(handheldTime, 200, 0)) * PositionAmplitude;
            local math_noise_ret3 = math.noise(handheldTime, 300, 0);
            local math_noise_ret4 = math.noise(handheldTime, 400, 0);
            local v37 = Vector3.new(math_noise_ret3, math_noise_ret4, noise3(handheldTime, 500, 0)) * RotationAmplitude;
            u2.CFrame = v35 * CFrame.new(v36) * CFrame.Angles(v37.X, v37.Y, v37.Z);
        else
            u2.CFrame = v35;
        end;
    end;

    u2.FieldOfView = p22.fov;
end;

function v1.Exit(p38) -- Line: 165
    -- upvalues: u2 (ref), u5 (ref), u6 (ref), u7 (ref)
    if not u2 then
        return;
    end;

    u2.CameraType = u5 or Enum.CameraType.Custom;
    u2.CFrame = u6 or u2.CFrame;
    u2.FieldOfView = u7 or 70;
    u5 = nil;
    u6 = nil;
    u7 = nil;
end;

return v1;