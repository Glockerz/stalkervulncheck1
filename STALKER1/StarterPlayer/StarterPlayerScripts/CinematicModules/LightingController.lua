-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"))

local t = {}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil

function t.Enter(p1, p2) --[[ Enter | Line: 27 | Upvalues: v5 (ref), Lighting (copy), v1 (ref), v4 (ref), v2 (ref), v3 (ref) ]]
	v5 = Lighting.ExposureCompensation
	v1 = Instance.new("DepthOfFieldEffect")
	v1.Name = "CinematicDOF"
	v1.Enabled = false
	v1.FarIntensity = p2.lighting.dof.farIntensity
	v1.InFocusRadius = p2.lighting.dof.inFocusRadius
	v1.NearIntensity = p2.lighting.dof.nearIntensity
	v1.Parent = Lighting
	v4 = Instance.new("BlurEffect")
	v4.Name = "CinematicBlur"
	v4.Enabled = false
	v4.Size = p2.lighting.blur.size
	v4.Parent = Lighting
	v2 = Instance.new("BloomEffect")
	v2.Name = "CinematicBloom"
	v2.Enabled = false
	v2.Intensity = p2.lighting.bloom.intensity
	v2.Threshold = p2.lighting.bloom.threshold
	v2.Size = p2.lighting.bloom.size
	v2.Parent = Lighting
	v3 = Instance.new("ColorCorrectionEffect")
	v3.Name = "CinematicColorCorrection"
	v3.Enabled = false
	v3.Brightness = p2.lighting.colorCorrection.brightness
	v3.Contrast = p2.lighting.colorCorrection.contrast
	v3.Saturation = p2.lighting.colorCorrection.saturation
	v3.TintColor = p2.lighting.colorCorrection.tint
	v3.Parent = Lighting
end
function t.Tick(p1, p2, p3) --[[ Tick | Line: 62 | Upvalues: Lighting (copy), v1 (ref), v4 (ref), v2 (ref), v3 (ref) ]]
	Lighting.ExposureCompensation = p2.lighting.exposure

	if p2.focus.locked and p2.focus.target then
		v1.Enabled = true
		v1.FocusDistance = p2.focus.distance + p2.focus.distanceOffset
	elseif p2.lighting.dof.on then
		v1.Enabled = true
		v1.FocusDistance = p2.lighting.dof.focusDistance
	else
		v1.Enabled = false
	end

	v1.FarIntensity = p2.lighting.dof.farIntensity
	v1.InFocusRadius = p2.lighting.dof.inFocusRadius
	v1.NearIntensity = p2.lighting.dof.nearIntensity
	v4.Enabled = p2.lighting.blur.on
	v4.Size = p2.lighting.blur.size
	v2.Enabled = p2.lighting.bloom.on
	v2.Intensity = p2.lighting.bloom.intensity
	v2.Threshold = p2.lighting.bloom.threshold
	v2.Size = p2.lighting.bloom.size
	v3.Enabled = p2.lighting.colorCorrection.on
	v3.Brightness = p2.lighting.colorCorrection.brightness
	v3.Contrast = p2.lighting.colorCorrection.contrast
	v3.Saturation = p2.lighting.colorCorrection.saturation
	v3.TintColor = p2.lighting.colorCorrection.tint
end
function t.Exit(p1) --[[ Exit | Line: 100 | Upvalues: Lighting (copy), v5 (ref), v1 (ref), v2 (ref), v3 (ref), v4 (ref) ]]
	Lighting.ExposureCompensation = v5 or 0

	if v1 then
		v1:Destroy()
		v1 = nil
	end

	if v2 then
		v2:Destroy()
		v2 = nil
	end

	if v3 then
		v3:Destroy()
		v3 = nil
	end

	if v4 then
		v4:Destroy()
		v4 = nil
	end

	v5 = nil
end

return t