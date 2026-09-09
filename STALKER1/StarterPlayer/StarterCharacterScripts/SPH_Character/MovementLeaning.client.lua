-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig)
local RunService = game:GetService("RunService")
local v1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
local maxLeanAngle = GameConfig.maxLeanAngle

if not GameConfig.movementLeaning then
	return
end

local function UpdateCharacterTilt(p1, p2) --[[ UpdateCharacterTilt | Line: 12 | Upvalues: v1 (copy), maxLeanAngle (copy) ]]
	local Humanoid = p1:FindFirstChild("Humanoid")
	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
	local v12 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("RootJoint") else HumanoidRootPart

	if not Humanoid or (Humanoid.Health <= 0 or not (HumanoidRootPart and v12)) then
		return
	end

	local v2 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection)
	local v3 = v1:Inverse() * v12.C0
	local v7 = CFrame.Angles(math.rad(-v2.Z) * maxLeanAngle, math.rad(-v2.X) * maxLeanAngle, 0)

	if Humanoid.Sit or (Humanoid.Health <= 0 or (script:GetAttribute("DisableLean") or p1:GetAttribute("SeatAnim"))) then
		v7 = CFrame.new()
	end

	v12.C0 = v1 * v3:Lerp(v7, 0.2 ^ (1 / (p2 * 60)))
end

RunService.RenderStepped:Connect(function(p1) --[[ Line: 27 | Upvalues: UpdateCharacterTilt (copy), Players (copy), GameConfig (copy) ]]
	UpdateCharacterTilt(Players.LocalPlayer.Character, p1)

	if not GameConfig.replicateMovementLeaning then
		return
	end

	for i, v in ipairs(Players:GetPlayers()) do
		if v ~= Players.LocalPlayer and v.Character then
			UpdateCharacterTilt(v.Character, p1)
		end
	end
end)