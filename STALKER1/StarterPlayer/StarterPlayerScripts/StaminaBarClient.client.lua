-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local StaminaBar = PlayerGui:WaitForChild("StaminaHUD"):WaitForChild("StaminaBar")
local Fill = StaminaBar:WaitForChild("Fill")
local v1 = nil
local v2 = 100
local RunService = game:GetService("RunService")
local ExhaustionBreathing = Instance.new("Sound")

ExhaustionBreathing.Name = "ExhaustionBreathing"
ExhaustionBreathing.SoundId = "rbxassetid://134336321560595"
ExhaustionBreathing.Volume = 0
ExhaustionBreathing.Looped = true
ExhaustionBreathing.Playing = true
task.defer(function() --[[ Line: 29 | Upvalues: LocalPlayer (copy), ExhaustionBreathing (copy) ]]
	local Head = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Head", 5)

	if Head then
		ExhaustionBreathing.Parent = Head
	end

	LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 34 | Upvalues: ExhaustionBreathing (ref) ]]
		local Head = p1:WaitForChild("Head", 5)

		if not Head then
			return
		end

		ExhaustionBreathing.Parent = Head
	end)
end)

local v3 = 100
local v4 = 100

RunService.RenderStepped:Connect(function() --[[ Line: 47 | Upvalues: LocalPlayer (copy), v3 (ref), v4 (ref), ExhaustionBreathing (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local CharacterClient = Character:FindFirstChild("CharacterClient", true)

	if not CharacterClient then
		return
	end

	local v1 = v3 / v4

	if v1 < 0.45 then
		local v2 = v1 / 0.45

		CharacterClient:SetAttribute("SpeedCap_Stamina", v2 * 4 + 6)

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if Humanoid then
			local Animator = Humanoid:FindFirstChildOfClass("Animator")

			if Animator then
				for v32, v42 in Animator:GetPlayingAnimationTracks() do
					if v42.Priority == Enum.AnimationPriority.Core or v42.Priority == Enum.AnimationPriority.Movement then
						v42:AdjustSpeed(v2 * 0.5 + 0.5)
					end
				end
			end
		end
	else
		CharacterClient:SetAttribute("SpeedCap_Stamina", nil)
	end

	ExhaustionBreathing.Volume = (1 - v1) * 0.8
end)

local UserInputService = game:GetService("UserInputService")
local v5 = false
local v6 = false
local SprintState = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("SprintState")

local function sendSprintState(p1) --[[ sendSprintState | Line: 93 | Upvalues: v6 (ref), v5 (ref), SprintState (copy) ]]
	if p1 == v6 then
		return
	end

	v6 = p1
	v5 = p1

	if not SprintState then
		return
	end

	SprintState:FireServer(p1)
end

UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 101 | Upvalues: UserInputService (copy), v6 (ref), v5 (ref), SprintState (copy) ]]
	if UserInputService:GetFocusedTextBox() then
		return
	end

	if p1.KeyCode ~= Enum.KeyCode.LeftShift and p1.KeyCode ~= Enum.KeyCode.ButtonL3 or v6 == true then
		return
	end

	v6 = true
	v5 = true

	if not SprintState then
		return
	end

	SprintState:FireServer(true)
end)
UserInputService.InputEnded:Connect(function(p1) --[[ Line: 118 | Upvalues: v6 (ref), v5 (ref), SprintState (copy) ]]
	if p1.KeyCode ~= Enum.KeyCode.LeftShift and p1.KeyCode ~= Enum.KeyCode.ButtonL3 or v6 == false then
		return
	end

	v6 = false
	v5 = false

	if not SprintState then
		return
	end

	SprintState:FireServer(false)
end)
task.spawn(function() --[[ Line: 125 | Upvalues: UserInputService (copy), v6 (ref), v5 (ref), SprintState (copy) ]]
	while true do
		repeat
			repeat
				task.wait(0.2)
			until not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and (v6 and v6 ~= false)

			v6 = false
			v5 = false
		until SprintState

		SprintState:FireServer(false)
	end
end)

local DebugSpeedUI = PlayerGui:WaitForChild("DebugSpeedUI", 5)

if DebugSpeedUI then
	local SpeedLabel = DebugSpeedUI:FindFirstChild("SpeedLabel")

	RunService.Heartbeat:Connect(function() --[[ Line: 139 | Upvalues: LocalPlayer (copy), SpeedLabel (copy) ]]
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not (Humanoid and (HumanoidRootPart and SpeedLabel)) then
			return
		end

		SpeedLabel.Text = string.format("WalkSpeed: %d | Vel: %.1f", Humanoid.WalkSpeed, HumanoidRootPart.AssemblyLinearVelocity.Magnitude)
	end)
end

local v7 = 0
local WeightSync = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("WeightSync")

if WeightSync then
	WeightSync.OnClientEvent:Connect(function(p1, p2) --[[ Line: 156 | Upvalues: v7 (ref) ]]
		if not (p1 and (p2 and p2 > 0)) then
			return
		end

		v7 = p1 / p2
		updateBarVisibility()
	end)
end

function updateBarVisibility() --[[ updateBarVisibility | Line: 165 | Upvalues: v7 (ref), v3 (ref), v2 (ref), StaminaBar (copy), Fill (copy), TweenService (copy), v1 (ref) ]]
	if (if v3 < v2 then true else false) or v7 >= 0.85 then
		if not StaminaBar.Visible then
			StaminaBar.Visible = true
			StaminaBar.BackgroundTransparency = 1
			Fill.BackgroundTransparency = 1
			TweenService:Create(StaminaBar, TweenInfo.new(0.3), {
				BackgroundTransparency = 0.5
			}):Play()
			TweenService:Create(Fill, TweenInfo.new(0.3), {
				BackgroundTransparency = 0.2
			}):Play()
		end

		if v1 then
			task.cancel(v1)
			v1 = nil
		end

		StaminaBar.BackgroundTransparency = 0.5
		Fill.BackgroundTransparency = 0.2
	else
		if v1 then
			return
		end

		v1 = task.delay(1, function() --[[ Line: 186 | Upvalues: TweenService (ref), StaminaBar (ref), Fill (ref), v1 (ref) ]]
			TweenService:Create(StaminaBar, TweenInfo.new(0.8), {
				BackgroundTransparency = 1
			}):Play()
			TweenService:Create(Fill, TweenInfo.new(0.8), {
				BackgroundTransparency = 1
			}):Play()
			task.delay(0.8, function() --[[ Line: 189 | Upvalues: StaminaBar (ref) ]]
				StaminaBar.Visible = false
			end)
			v1 = nil
		end)
	end
end
ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("StaminaSync").OnClientEvent:Connect(function(p1, p2) --[[ Line: 198 | Upvalues: v2 (ref), v4 (ref), v3 (ref), TweenService (copy), Fill (copy) ]]
	v2 = p2 or 100
	v4 = v2
	v3 = p1

	local v1 = p1 / v2

	TweenService:Create(Fill, TweenInfo.new(0.15), {
		Size = UDim2.new(v1, 0, 1, 0)
	}):Play()

	if v1 >= 0.5 then
		Fill.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
	elseif v1 >= 0.2 then
		Fill.BackgroundColor3 = Color3.fromRGB(220, 180, 50)
	else
		Fill.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
	end

	updateBarVisibility()
end)

local function _() --[[ Unreferenced function | Line: 226 | Upvalues: v1 (ref) ]]
	UNNAMED_105078964283048.Visible = false
end

local function _() --[[ Unreferenced function | Upvalues: v2 (ref), v3 (ref), v4 (ref), v5 (ref) ]]
	v2:Create(v3, TweenInfo.new(0.8), {
		BackgroundTransparency = 1
	}):Play()
	v2:Create(v4, TweenInfo.new(0.8), {
		BackgroundTransparency = 1
	}):Play()
	task.delay(0.8, function() --[[ Line: 226 | Upvalues: v3 (ref) ]]
		v3.Visible = false
	end)
	v5 = nil
end