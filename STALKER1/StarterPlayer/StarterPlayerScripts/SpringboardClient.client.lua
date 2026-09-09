-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local SpringboardRingPulse = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SpringboardRingPulse")
local v1 = nil
local v2 = nil

local function ensureDarkenGui() --[[ ensureDarkenGui | Line: 34 | Upvalues: v1 (ref), LocalPlayer (copy), v2 (ref) ]]
	if not v1 then
		local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

		v1 = Instance.new("ScreenGui")
		v1.Name = "SpringboardDarken"
		v1.IgnoreGuiInset = true
		v1.ResetOnSpawn = false
		v1.DisplayOrder = 50
		v1.Parent = PlayerGui
		v2 = Instance.new("Frame")
		v2.Size = UDim2.new(1, 0, 1, 0)
		v2.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
		v2.BackgroundTransparency = 1
		v2.BorderSizePixel = 0
		v2.Parent = v1
	end
end

local function darkenScreen() --[[ darkenScreen | Line: 51 | Upvalues: ensureDarkenGui (copy), TweenService (copy), v2 (ref) ]]
	ensureDarkenGui()
	TweenService:Create(v2, TweenInfo.new(0.05), {
		BackgroundTransparency = 0.5
	}):Play()
	task.delay(0.15000000000000002, function() --[[ Line: 56 | Upvalues: TweenService (ref), v2 (ref) ]]
		TweenService:Create(v2, TweenInfo.new(0.4), {
			BackgroundTransparency = 1
		}):Play()
	end)
end

local function shakeCamera() --[[ shakeCamera | Line: 62 | Upvalues: LocalPlayer (copy), RunService (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = Character and Character:FindFirstChildOfClass("Humanoid")

	if v1 then
		local v2 = os.clock()
		local v3 = nil

		v3 = RunService.RenderStepped:Connect(function() --[[ Line: 69 | Upvalues: v2 (copy), v1 (copy), v3 (ref) ]]
			local v12 = os.clock() - v2

			if not (v12 >= 0.5) and v1.Parent then
				local v22 = 0.5 * (1 - v12 / 0.5)

				v1.CameraOffset = Vector3.new((math.random() - 0.5) * 2 * v22, (math.random() - 0.5) * 2 * v22, (math.random() - 0.5) * 2 * v22)

				return
			end

			if not v1.Parent then
				v3:Disconnect()

				return
			end

			v1.CameraOffset = Vector3.new(0, 0, 0)
			v3:Disconnect()
		end)
	end
end

SpringboardRingPulse.OnClientEvent:Connect(function(p1) --[[ Line: 88 | Upvalues: LocalPlayer (copy), shakeCamera (copy), darkenScreen (copy) ]]
	if not (p1 and p1.model) then
		return
	end

	local model = p1.model

	if not model.Parent then
		return
	end

	local v1 = model:FindFirstChild("BubbleOrigin") or model:FindFirstChild("ZoneCenter")

	if not v1 then
		return
	end

	local Character = LocalPlayer.Character
	local v2 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not (v2 and (v2.Position - v1.Position).Magnitude < 12) then
		return
	end

	shakeCamera()
	darkenScreen()
end)
print("[SpringboardClient] Initialized")