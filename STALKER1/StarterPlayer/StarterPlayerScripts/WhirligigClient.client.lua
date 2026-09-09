-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local WhirligigExplosion = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("WhirligigExplosion")

local function shakeCamera() --[[ shakeCamera | Line: 32 | Upvalues: LocalPlayer (copy), RunService (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = Character and Character:FindFirstChildOfClass("Humanoid")

	if v1 then
		local v2 = os.clock()
		local v3 = nil

		v3 = RunService.RenderStepped:Connect(function() --[[ Line: 39 | Upvalues: v2 (copy), v1 (copy), v3 (ref) ]]
			local v12 = os.clock() - v2

			if not (v12 >= 0.8) and v1.Parent then
				local v22 = 1 * (1 - v12 / 0.8)

				v1.CameraOffset = Vector3.new((math.random() - 0.5) * 2 * v22, (math.random() - 0.5) * 2 * v22, (math.random() - 0.5) * 2 * v22)

				return
			end

			if v1.Parent then
				v1.CameraOffset = Vector3.new(0, 0, 0)
			end

			v3:Disconnect()
		end)
	end
end

local v1 = nil
local v2 = nil

local function ensureDarkenGui() --[[ ensureDarkenGui | Line: 65 | Upvalues: v1 (ref), LocalPlayer (copy), v2 (ref) ]]
	if not v1 then
		local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

		v1 = Instance.new("ScreenGui")
		v1.Name = "WhirligigDarken"
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

local function darkenScreen() --[[ darkenScreen | Line: 82 | Upvalues: ensureDarkenGui (copy), TweenService (copy), v2 (ref) ]]
	ensureDarkenGui()
	TweenService:Create(v2, TweenInfo.new(0.05), {
		BackgroundTransparency = 0.4
	}):Play()
	task.delay(0.2, function() --[[ Line: 86 | Upvalues: TweenService (ref), v2 (ref) ]]
		TweenService:Create(v2, TweenInfo.new(0.5), {
			BackgroundTransparency = 1
		}):Play()
	end)
end

local t = {}

local function computeDroneVolume(p1) --[[ computeDroneVolume | Line: 100 | Upvalues: LocalPlayer (copy) ]]
	local v1 = p1:GetAttribute("State")

	if v1 ~= "ACTIVE" and v1 ~= "CAPTURED" then
		return 0
	end

	local ZoneCenter = p1:FindFirstChild("ZoneCenter")

	if not ZoneCenter then
		return 0
	end

	local Character = LocalPlayer.Character
	local v2 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v2 then
		return 2
	end

	local v3 = (p1:GetAttribute("FootprintRadius") or 4) * 4
	local v4 = v2.Position.X - ZoneCenter.Position.X
	local v5 = v2.Position.Z - ZoneCenter.Position.Z
	local v6 = math.sqrt(v4 * v4 + v5 * v5)

	if v3 <= v6 then
		return 2
	end

	return 2 + 3 * (1 - v6 / v3)
end

local function syncDroneVolume(p1) --[[ syncDroneVolume | Line: 121 | Upvalues: computeDroneVolume (copy), TweenService (copy) ]]
	local ZoneCenter = p1:FindFirstChild("ZoneCenter")
	local v1 = if ZoneCenter then ZoneCenter:FindFirstChild("PullDrone") else ZoneCenter

	if not (v1 and v1:IsA("Sound")) then
		return
	end

	if not v1.Looped then
		v1.Looped = true
	end

	local v2 = computeDroneVolume(p1)

	if v2 > 0 and not v1.IsPlaying then
		v1:Play()
	end

	TweenService:Create(v1, TweenInfo.new(0.15), {
		Volume = v2
	}):Play()
end

local function watchAnomaly(p1) --[[ watchAnomaly | Line: 132 | Upvalues: t (copy), syncDroneVolume (copy) ]]
	if not p1:IsA("Model") then
		return
	end

	if p1:GetAttribute("AnomalyType") ~= "Whirligig" then
		return
	end

	if t[p1] then
		return
	end

	if p1:IsDescendantOf(workspace) then
		local t2 = {
			stopped = false
		}

		t[p1] = t2
		syncDroneVolume(p1)
		p1:GetAttributeChangedSignal("State"):Connect(function() --[[ Line: 142 | Upvalues: syncDroneVolume (ref), p1 (copy) ]]
			syncDroneVolume(p1)
		end)
		task.spawn(function() --[[ Line: 147 | Upvalues: t2 (copy), p1 (copy), syncDroneVolume (ref) ]]
			while not t2.stopped and p1.Parent do
				syncDroneVolume(p1)
				task.wait(0.15)
			end
		end)
	end
end

local function unwatchAnomaly(p1) --[[ unwatchAnomaly | Line: 155 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if v1 then
		v1.stopped = true
		t[p1] = nil
	end
end

for i, v in ipairs(CollectionService:GetTagged("Anomaly")) do
	watchAnomaly(v)
end

CollectionService:GetInstanceAddedSignal("Anomaly"):Connect(watchAnomaly)
CollectionService:GetInstanceRemovedSignal("Anomaly"):Connect(unwatchAnomaly)
WhirligigExplosion.OnClientEvent:Connect(function(p1) --[[ Line: 174 | Upvalues: LocalPlayer (copy), shakeCamera (copy), darkenScreen (copy) ]]
	if not (p1 and p1.model) then
		return
	end

	local model = p1.model

	if not model.Parent then
		return
	end

	local v1 = model:FindFirstChild("Apex") or model:FindFirstChild("ZoneCenter")
	local Character = LocalPlayer.Character
	local v2 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not (v2 and (v1 and (v2.Position - v1.Position).Magnitude < 35)) then
		return
	end

	shakeCamera()
	darkenScreen()
end)
print("[WhirligigClient] Initialized")