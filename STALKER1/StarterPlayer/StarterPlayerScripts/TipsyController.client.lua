-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local TipsyUpdate = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TipsyUpdate")
local v1 = 0
local v2 = 0
local v3 = nil
local v4 = CFrame.new()
local TipsyBlur = Lighting:FindFirstChild("TipsyBlur")

if not TipsyBlur then
	TipsyBlur = Instance.new("BlurEffect")
	TipsyBlur.Name = "TipsyBlur"
	TipsyBlur.Size = 0
	TipsyBlur.Enabled = false
	TipsyBlur.Parent = Lighting
end

local function getHumanoid() --[[ getHumanoid | Line: 59 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	return if Character then Character:FindFirstChildOfClass("Humanoid") or nil else nil
end

local function clearTipsyVisuals() --[[ clearTipsyVisuals | Line: 64 | Upvalues: LocalPlayer (copy), TipsyBlur (ref) ]]
	local Character = LocalPlayer.Character
	local v1

	if Character then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		v1 = if Humanoid then Humanoid else nil
	else
		v1 = nil
	end

	if not v1 then
		TipsyBlur.Size = 0
		TipsyBlur.Enabled = false

		return
	end

	v1.CameraOffset = Vector3.new(0, 0, 0)
	TipsyBlur.Size = 0
	TipsyBlur.Enabled = false
end

local v5 = nil
local v6 = nil

local function calcTipsyWeight(p1) --[[ calcTipsyWeight | Line: 81 ]]
	return math.clamp(p1 / 5, 0, 1) * 0.7 + 0.3
end

local function setupTipsyTrack(p1) --[[ setupTipsyTrack | Line: 86 | Upvalues: v5 (ref), v6 (ref) ]]
	local Humanoid = p1:WaitForChild("Humanoid", 5)

	if not Humanoid then
		return
	end

	local Animator = Humanoid:WaitForChild("Animator", 5)

	if Animator then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = "rbxassetid://82617441301190"

		local v1 = Animator:LoadAnimation(Animation)

		v1.Priority = Enum.AnimationPriority.Movement
		v1.Looped = true
		v5 = v1
		v6 = p1
	end
end

local function updateTipsyTrack() --[[ updateTipsyTrack | Line: 101 | Upvalues: v5 (ref), v6 (ref), LocalPlayer (copy), v1 (ref) ]]
	local v12 = v5

	if not v12 or v6 ~= LocalPlayer.Character then
		return
	end

	local v2 = v1

	if v2 > 0.1 then
		local v3 = math.clamp(v2 / 5, 0, 1) * 0.7 + 0.3

		if v12.IsPlaying then
			v12:AdjustWeight(v3, 0.5)
		else
			v12:Play(0.5, v3)
		end
	else
		if not v12.IsPlaying then
			return
		end

		v12:Stop(0.5)
	end
end

TipsyUpdate.OnClientEvent:Connect(function(p1) --[[ Line: 120 | Upvalues: v1 (ref), LocalPlayer (copy), TipsyBlur (ref), updateTipsyTrack (copy) ]]
	v1 = math.max(0, p1 or 0)

	if not (v1 <= 0.01) then
		updateTipsyTrack()

		return
	end

	local Character = LocalPlayer.Character
	local v12

	if Character then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		v12 = if Humanoid then Humanoid else nil
	else
		v12 = nil
	end

	if v12 then
		v12.CameraOffset = Vector3.new(0, 0, 0)
	end

	TipsyBlur.Size = 0
	TipsyBlur.Enabled = false
	updateTipsyTrack()
end)
LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 126 | Upvalues: v5 (ref), v6 (ref), setupTipsyTrack (copy), updateTipsyTrack (copy), LocalPlayer (copy), TipsyBlur (ref) ]]
	v5 = nil
	v6 = nil
	task.spawn(function() --[[ Line: 130 | Upvalues: setupTipsyTrack (ref), p1 (copy), updateTipsyTrack (ref) ]]
		setupTipsyTrack(p1)
		updateTipsyTrack()
	end)
	task.wait(0.5)

	local Character = LocalPlayer.Character
	local v1

	if Character then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		v1 = if Humanoid then Humanoid else nil
	else
		v1 = nil
	end

	if not v1 then
		TipsyBlur.Size = 0
		TipsyBlur.Enabled = false

		return
	end

	v1.CameraOffset = Vector3.new(0, 0, 0)
	TipsyBlur.Size = 0
	TipsyBlur.Enabled = false
end)

if not LocalPlayer.Character then
	RunService:BindToRenderStep("TipsySway", Enum.RenderPriority.Camera.Value + 200, function(p13) --[[ Line: 146 | Upvalues: v2 (ref), v1 (ref), v3 (ref), v4 (ref), TipsyBlur (ref) ]]
		v2 = v2 + p13

		local CurrentCamera = workspace.CurrentCamera

		if not CurrentCamera then
			return
		end

		local v12 = v1

		if v12 <= 0.01 then
			v3 = nil
			v4 = CFrame.new()
			TipsyBlur.Size = 0
			TipsyBlur.Enabled = false

			return
		end

		local v22 = if v3 and CurrentCamera.CFrame == v3 then CurrentCamera.CFrame * v4:Inverse() else CurrentCamera.CFrame
		local v32 = v12 * 0.08 + 0.7
		local v42 = math.rad(v12 * 0.1)
		local v5 = math.rad(v12 * 0.08)
		local v6 = math.rad(v12 * 0.03)
		local v8 = math.sin(v2 * v32 * 0.6) * v42
		local v10 = math.sin(v2 * v32 * 0.8 + 0.4) * v5
		local v132 = CFrame.Angles(math.sin(v2 * v32 * 1.3 + 1.3) * v6, v8, v10)
		local v14 = v22 * v132

		CurrentCamera.CFrame = v14
		v3 = v14
		v4 = v132

		local v15 = v12 * 6

		TipsyBlur.Size = v15 * 1.25 * 0.5 + v15 * 0.75 * 0.5 * math.sin(v2 * 0.45 * math.pi * 2)
		TipsyBlur.Enabled = v12 > 0.5
	end)
	print("[TipsyController] Initialized")

	return
end

task.spawn(function() --[[ Line: 140 | Upvalues: setupTipsyTrack (copy), LocalPlayer (copy), updateTipsyTrack (copy) ]]
	setupTipsyTrack(LocalPlayer.Character)
	updateTipsyTrack()
end)
RunService:BindToRenderStep("TipsySway", Enum.RenderPriority.Camera.Value + 200, function(p13) --[[ Line: 146 | Upvalues: v2 (ref), v1 (ref), v3 (ref), v4 (ref), TipsyBlur (ref) ]]
	v2 = v2 + p13

	local CurrentCamera = workspace.CurrentCamera

	if not CurrentCamera then
		return
	end

	local v12 = v1

	if v12 <= 0.01 then
		v3 = nil
		v4 = CFrame.new()
		TipsyBlur.Size = 0
		TipsyBlur.Enabled = false

		return
	end

	local v22 = if v3 and CurrentCamera.CFrame == v3 then CurrentCamera.CFrame * v4:Inverse() else CurrentCamera.CFrame
	local v32 = v12 * 0.08 + 0.7
	local v42 = math.rad(v12 * 0.1)
	local v5 = math.rad(v12 * 0.08)
	local v6 = math.rad(v12 * 0.03)
	local v8 = math.sin(v2 * v32 * 0.6) * v42
	local v10 = math.sin(v2 * v32 * 0.8 + 0.4) * v5
	local v132 = CFrame.Angles(math.sin(v2 * v32 * 1.3 + 1.3) * v6, v8, v10)
	local v14 = v22 * v132

	CurrentCamera.CFrame = v14
	v3 = v14
	v4 = v132

	local v15 = v12 * 6

	TipsyBlur.Size = v15 * 1.25 * 0.5 + v15 * 0.75 * 0.5 * math.sin(v2 * 0.45 * math.pi * 2)
	TipsyBlur.Enabled = v12 > 0.5
end)
print("[TipsyController] Initialized")