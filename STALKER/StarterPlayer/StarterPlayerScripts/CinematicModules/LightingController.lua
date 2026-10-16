-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"));
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;

function v1.Enter(p7, p8) -- Line: 27
    -- upvalues: u6 (ref), Lighting (copy), u2 (ref), u5 (ref), u3 (ref), u4 (ref)
    u6 = Lighting.ExposureCompensation;
    u2 = Instance.new("DepthOfFieldEffect");
    u2.Name = "CinematicDOF";
    u2.Enabled = false;
    u2.FarIntensity = p8.lighting.dof.farIntensity;
    u2.InFocusRadius = p8.lighting.dof.inFocusRadius;
    u2.NearIntensity = p8.lighting.dof.nearIntensity;
    u2.Parent = Lighting;
    u5 = Instance.new("BlurEffect");
    u5.Name = "CinematicBlur";
    u5.Enabled = false;
    u5.Size = p8.lighting.blur.size;
    u5.Parent = Lighting;
    u3 = Instance.new("BloomEffect");
    u3.Name = "CinematicBloom";
    u3.Enabled = false;
    u3.Intensity = p8.lighting.bloom.intensity;
    u3.Threshold = p8.lighting.bloom.threshold;
    u3.Size = p8.lighting.bloom.size;
    u3.Parent = Lighting;
    u4 = Instance.new("ColorCorrectionEffect");
    u4.Name = "CinematicColorCorrection";
    u4.Enabled = false;
    u4.Brightness = p8.lighting.colorCorrection.brightness;
    u4.Contrast = p8.lighting.colorCorrection.contrast;
    u4.Saturation = p8.lighting.colorCorrection.saturation;
    u4.TintColor = p8.lighting.colorCorrection.tint;
    u4.Parent = Lighting;
end;

function v1.Tick(p9, p10, p11) -- Line: 62
    -- upvalues: Lighting (copy), u2 (ref), u5 (ref), u3 (ref), u4 (ref)
    Lighting.ExposureCompensation = p10.lighting.exposure;

    if p10.focus.locked and p10.focus.target then
        u2.Enabled = true;
        u2.FocusDistance = p10.focus.distance + p10.focus.distanceOffset;
    elseif p10.lighting.dof.on then
        u2.Enabled = true;
        u2.FocusDistance = p10.lighting.dof.focusDistance;
    else
        u2.Enabled = false;
    end;

    u2.FarIntensity = p10.lighting.dof.farIntensity;
    u2.InFocusRadius = p10.lighting.dof.inFocusRadius;
    u2.NearIntensity = p10.lighting.dof.nearIntensity;
    u5.Enabled = p10.lighting.blur.on;
    u5.Size = p10.lighting.blur.size;
    u3.Enabled = p10.lighting.bloom.on;
    u3.Intensity = p10.lighting.bloom.intensity;
    u3.Threshold = p10.lighting.bloom.threshold;
    u3.Size = p10.lighting.bloom.size;
    u4.Enabled = p10.lighting.colorCorrection.on;
    u4.Brightness = p10.lighting.colorCorrection.brightness;
    u4.Contrast = p10.lighting.colorCorrection.contrast;
    u4.Saturation = p10.lighting.colorCorrection.saturation;
    u4.TintColor = p10.lighting.colorCorrection.tint;
end;

function v1.Exit(p12) -- Line: 100
    -- upvalues: Lighting (copy), u6 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref)
    Lighting.ExposureCompensation = u6 or 0;

    if u2 then
        u2:Destroy();
        u2 = nil;
    end;

    if u3 then
        u3:Destroy();
        u3 = nil;
    end;

    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    if u5 then
        u5:Destroy();
        u5 = nil;
    end;

    u6 = nil;
end;

return v1;