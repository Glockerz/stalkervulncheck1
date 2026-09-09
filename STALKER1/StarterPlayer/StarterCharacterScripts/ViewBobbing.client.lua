-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid")

LocalPlayer:GetMouse()

local CurrentCamera = workspace.CurrentCamera
local v2 = nil
local v3 = Vector3.new(0, 0, 0)
local v5 = math.clamp(Humanoid.WalkSpeed / 16, 0.5, 2)
local v6 = 0

local function lerp(p1, p2, p3) --[[ lerp | Line: 25 ]]
	return p1 + (p2 - p1) * p3
end

local function updateCamera(p1) --[[ updateCamera | Line: 29 | Upvalues: Humanoid (copy), v2 (ref), v6 (ref), UserInputService (copy), v3 (ref), v5 (copy), CurrentCamera (copy) ]]
	if Humanoid.Health <= 0 then
		v2:Disconnect()

		return
	end

	v6 = v6 + p1

	if v6 < 0.015384615384615385 then
		return
	end

	local v1 = v6

	v6 = 0

	local X = UserInputService:GetMouseDelta().X
	local v22 = v3

	v3 = v22 + (Vector3.new(math.clamp(X, -0.5, 0.5), math.random(-0.5, 0.5), math.random(-0.5, 0.5)) - v22) * (v1 * 0.25 * 60)

	local v62 = Humanoid.MoveDirection.Magnitude > 0.01 and Vector3.new(math.sin(time() * Humanoid.WalkSpeed * 0.5) * 0.02 * v5, math.sin(time() * Humanoid.WalkSpeed * 0.3) * 0.02 * v5, math.sin(time() * Humanoid.WalkSpeed * 0.7) * 0.02 * v5) or Vector3.new(0, 0, 0)
	local v17 = CurrentCamera.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(v62.X), math.rad(v62.Y), (math.rad(v62.Z)))

	CurrentCamera.CFrame = v17 * CFrame.fromEulerAnglesXYZ(0, 0, (math.rad(v3.X)))
end

v2 = RunService.RenderStepped:Connect(updateCamera)