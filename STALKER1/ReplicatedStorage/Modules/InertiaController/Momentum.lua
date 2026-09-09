-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Config = {
		BaseAcceleration = 6,
		MoveAcceleration = 6,
		MovementCutoff = 0.001,
		SprintAcceleration = 4,
		ExhaustedAcceleration = 3,
		HeavyAcceleration = 2
	}
}
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer
local ControlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
local CurrentCamera = workspace.CurrentCamera
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = Vector3.new()
local v5 = Vector3.new()
local v6 = 100
local v7 = 0

local function lerp(p1, p2, p3) --[[ lerp | Line: 30 ]]
	return p1 + (p2 - p1) * p3
end

local function calculateAcceleration() --[[ calculateAcceleration | Line: 34 | Upvalues: t (copy), v7 (ref), v6 (ref), v2 (ref), v1 (ref) ]]
	local Config = t.Config
	local BaseAcceleration = Config.BaseAcceleration

	if v7 >= 1.2 then
		BaseAcceleration = Config.HeavyAcceleration
	elseif v7 >= 1 then
		local SprintAcceleration = Config.SprintAcceleration

		BaseAcceleration = SprintAcceleration + (Config.HeavyAcceleration - SprintAcceleration) * ((v7 - 1) / 0.2)
	elseif v7 >= 0.8 then
		local BaseAcceleration2 = Config.BaseAcceleration

		BaseAcceleration = BaseAcceleration2 + (Config.SprintAcceleration - BaseAcceleration2) * ((v7 - 0.8) / 0.2)
	end

	if v6 <= 10 then
		BaseAcceleration = math.min(BaseAcceleration, Config.ExhaustedAcceleration)
	elseif v6 <= 30 then
		local ExhaustedAcceleration = Config.ExhaustedAcceleration

		BaseAcceleration = math.min(BaseAcceleration, ExhaustedAcceleration + (Config.BaseAcceleration - ExhaustedAcceleration) * ((v6 - 10) / 20))
	end

	if v2 and v2.WalkSpeed > 12 then
		local v72 = v1 and v1:FindFirstChild("HumanoidRootPart")

		if v72 and v72.AssemblyLinearVelocity.Magnitude > 10 then
			BaseAcceleration = math.min(BaseAcceleration, Config.SprintAcceleration)
		end
	end

	return BaseAcceleration
end

local function updateMovement(p1) --[[ updateMovement | Line: 67 | Upvalues: CurrentCamera (copy), ControlModule (copy), v4 (ref), calculateAcceleration (copy), t (copy), v5 (ref), v2 (ref) ]]
	v4 = CurrentCamera.CFrame:VectorToWorldSpace(ControlModule:GetMoveVector())

	local v1 = calculateAcceleration()

	t.Config.MoveAcceleration = v1

	local v22 = v5

	v5 = v22 + (v4 - v22) * math.clamp(p1 * v1, 0, 1)

	if v5.Magnitude < t.Config.MovementCutoff and v4.Magnitude < t.Config.MovementCutoff then
		v5 = Vector3.new()
	end

	if not v2 then
		return
	end

	local v3 = v2.Parent

	if v3 and v3:GetAttribute("_vortexHeld") then
		return
	end

	v2:Move(v5)
end

function t.Initialize(p1) --[[ Initialize | Line: 93 | Upvalues: v1 (ref), LocalPlayer (copy), v2 (ref), ReplicatedStorage (copy), v6 (ref), v7 (ref), v3 (ref), RunService (copy), updateMovement (copy) ]]
	p1:Cleanup()
	v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	v2 = v1:WaitForChild("Humanoid")
	LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 99 | Upvalues: v1 (ref), v2 (ref) ]]
		v1 = p1
		v2 = p1:WaitForChild("Humanoid")
	end)

	local StaminaSync = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("StaminaSync")

	if StaminaSync then
		StaminaSync.OnClientEvent:Connect(function(p1, p2) --[[ Line: 107 | Upvalues: v6 (ref) ]]
			v6 = p1
		end)
	end

	local WeightSync = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("WeightSync")

	if not WeightSync then
		v3 = RunService.RenderStepped:Connect(updateMovement)

		return p1
	end

	WeightSync.OnClientEvent:Connect(function(p1, p2) --[[ Line: 115 | Upvalues: v7 (ref) ]]
		v7 = p1 / p2
	end)
	v3 = RunService.RenderStepped:Connect(updateMovement)

	return p1
end
function t.Cleanup(p1) --[[ Cleanup | Line: 125 | Upvalues: v3 (ref) ]]
	if not v3 then
		return
	end

	v3:Disconnect()
	v3 = nil
end
function t.GetVelocity(p1) --[[ GetVelocity | Line: 132 | Upvalues: v5 (ref) ]]
	return v5
end
function t.GetTargetVelocity(p1) --[[ GetTargetVelocity | Line: 136 | Upvalues: v4 (ref) ]]
	return v4
end
function t.GetAcceleration(p1) --[[ GetAcceleration | Line: 140 | Upvalues: t (copy) ]]
	return t.Config.MoveAcceleration
end

return t