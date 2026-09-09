-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"))
local t = {}
local v1 = nil
local v2 = 0
local v3 = 0
local v4 = nil
local v5 = nil
local v6 = nil

local function frameAlpha(p1, p2) --[[ frameAlpha | Line: 35 ]]
	return 1 - (1 - p1) ^ (p2 * 60)
end

local function lerpAngle(p1, p2, p3) --[[ lerpAngle | Line: 40 ]]
	return p1 + ((p2 - p1 + math.pi) % 6.283185307179586 - math.pi) * p3
end

local function noise3(p1, p2, p3) --[[ noise3 | Line: 46 ]]
	return math.noise(p1, p2, p3)
end

local function flattenXZ(p1) --[[ flattenXZ | Line: 48 ]]
	return Vector3.new(p1.X, 0, p1.Z)
end

function t.Enter(p1, p2) --[[ Enter | Line: 52 | Upvalues: v1 (ref), v4 (ref), v5 (ref), v6 (ref), v2 (ref), v3 (ref) ]]
	v1 = workspace.CurrentCamera
	v4 = v1.CameraType
	v5 = v1.CFrame
	v6 = v1.FieldOfView
	v1.CameraType = Enum.CameraType.Scriptable

	local v12, v22, _ = v5:ToEulerAnglesYXZ()

	v2 = v22
	v3 = math.clamp(v12, -1.5533430342749532, 1.5533430342749532)
	p2.cameraCFrame = v5
	p2.smoothedCFrame = v5
	p2.handheldTime = 0
	v1.FieldOfView = p2.fov
end
function t.Tick(p1, p2, p3) --[[ Tick | Line: 69 | Upvalues: v1 (ref), Players (copy), v2 (ref), v3 (ref), CinematicCameraConfig (copy), noise3 (copy) ]]
	if not v1 then
		return
	end

	local actions = p2.actions

	if actions.resetRequested then
		local v12 = Players.LocalPlayer and Players.LocalPlayer.Character
		local v22 = if v12 then v12:FindFirstChild("HumanoidRootPart") else v12
		local v32 = v22 and CFrame.new(v22.Position + Vector3.new(0, 3, 0)) or CFrame.new(0, 20, 0)

		v2 = 0
		v3 = 0
		p2.cameraCFrame = v32
		p2.smoothedCFrame = v32
		p2.fov = CinematicCameraConfig.Camera.DefaultFOV
		actions.resetRequested = false
	end

	v2 = v2 + actions.look.X
	v3 = math.clamp(v3 + actions.look.Y, -1.5533430342749532, 1.5533430342749532)

	if p2.lockTarget and (p2.lockTarget.Parent and (actions.look.Magnitude < 0.001 and (p2.lockTarget.Position - p2.cameraCFrame.Position).Magnitude > 0.0001)) then
		local v5, v6 = CFrame.lookAt(p2.cameraCFrame.Position, p2.lockTarget.Position):ToEulerAnglesYXZ()
		local v7 = 1 - (1 - CinematicCameraConfig.Smoothing.RotationAlpha) ^ (p3 * 60)
		local v8 = v2

		v2 = v8 + ((v6 - v8 + math.pi) % 6.283185307179586 - math.pi) * v7
		v3 = math.clamp(v3 + (v5 - v3) * v7, -1.5533430342749532, 1.5533430342749532)
	end

	local speed = p2.speed

	if actions.boost then
		speed = speed * CinematicCameraConfig.Speed.Boost
	end

	if actions.precise then
		speed = speed * CinematicCameraConfig.Speed.Precise
	end

	local cameraCFrame = p2.cameraCFrame
	local LookVector = cameraCFrame.LookVector
	local v10 = Vector3.new(LookVector.X, 0, LookVector.Z)
	local RightVector = cameraCFrame.RightVector
	local v11 = Vector3.new(RightVector.X, 0, RightVector.Z)
	local v14 = (if v10.Magnitude > 0 then v10.Unit else v10) * actions.move.Z + (if v11.Magnitude > 0 then v11.Unit else v11) * actions.move.X
	local v15 = v14 + Vector3.new(0, actions.move.Y, 0)
	local Position = cameraCFrame.Position

	if v15.Magnitude > 0.001 then
		Position = Position + v15.Unit * speed * p3
	end

	local v16 = CFrame.new(Position) * CFrame.Angles(0, v2, 0) * CFrame.Angles(v3, 0, 0)

	p2.cameraCFrame = v16

	if p2.mode == "Raw" then
		p2.smoothedCFrame = v16
		v1.CFrame = v16
	else
		local smoothedCFrame = p2.smoothedCFrame
		local v19 = smoothedCFrame.Position:Lerp(v16.Position, 1 - (1 - CinematicCameraConfig.Smoothing.PositionAlpha) ^ (p3 * 60))
		local v20 = (smoothedCFrame - smoothedCFrame.Position):Lerp(v16 - v16.Position, 1 - (1 - CinematicCameraConfig.Smoothing.RotationAlpha) ^ (p3 * 60))
		local v21 = CFrame.new(v19) * v20

		p2.smoothedCFrame = v21

		if p2.mode == "Handheld" then
			p2.handheldTime = p2.handheldTime + p3 * CinematicCameraConfig.Handheld.Frequency

			local handheldTime = p2.handheldTime
			local v25 = Vector3.new(math.noise(handheldTime, 0, 0), math.noise(handheldTime, 100, 0), noise3(handheldTime, 200, 0)) * CinematicCameraConfig.Handheld.PositionAmplitude
			local v29 = Vector3.new(math.noise(handheldTime, 300, 0), math.noise(handheldTime, 400, 0), noise3(handheldTime, 500, 0)) * CinematicCameraConfig.Handheld.RotationAmplitude

			v1.CFrame = v21 * CFrame.new(v25) * CFrame.Angles(v29.X, v29.Y, v29.Z)
		else
			v1.CFrame = v21
		end
	end

	v1.FieldOfView = p2.fov
end
function t.Exit(p1) --[[ Exit | Line: 165 | Upvalues: v1 (ref), v4 (ref), v5 (ref), v6 (ref) ]]
	if not v1 then
		return
	end

	v1.CameraType = v4 or Enum.CameraType.Custom
	v1.CFrame = v5 or v1.CFrame
	v1.FieldOfView = v6 or 70
	v4 = nil
	v5 = nil
	v6 = nil
end

return t