-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local AnomalyDetector = Instance.new("Sound")

AnomalyDetector.Name = "AnomalyDetector"
AnomalyDetector.SoundId = "rbxassetid://1153680689"
AnomalyDetector.Looped = true
AnomalyDetector.Volume = 0
AnomalyDetector.PlaybackSpeed = 1
AnomalyDetector.Parent = SoundService

local t = {}

local function radiusOf(p1) --[[ radiusOf | Line: 67 ]]
	return p1:GetAttribute("ZoneRadius") or (p1:GetAttribute("FootprintRadius") or 5)
end

local function positionOf(p1) --[[ positionOf | Line: 75 ]]
	local ZoneCenter = p1:FindFirstChild("ZoneCenter")

	if ZoneCenter and ZoneCenter:IsA("BasePart") then
		return ZoneCenter.Position
	end

	local ok, result = pcall(function() --[[ Line: 78 | Upvalues: p1 (copy) ]]
		return p1:GetPivot()
	end)

	if ok then
		return result.Position
	end

	return nil
end

local function rebuildCache() --[[ rebuildCache | Line: 83 | Upvalues: CollectionService (copy), positionOf (copy), t (ref) ]]
	local t2 = {}

	for i, v in ipairs(CollectionService:GetTagged("Anomaly")) do
		if v:IsDescendantOf(workspace) then
			local v1 = positionOf(v)

			if v1 then
				local t3 = {
					pos = v1
				}

				t3.radius = v:GetAttribute("ZoneRadius") or v:GetAttribute("FootprintRadius") or 5
				t2[#t2 + 1] = t3
			end
		end
	end

	t = t2
end

rebuildCache()
CollectionService:GetInstanceAddedSignal("Anomaly"):Connect(rebuildCache)
CollectionService:GetInstanceRemovedSignal("Anomaly"):Connect(rebuildCache)

local v1 = 0
local v2 = 0
local v3 = 1

RunService.RenderStepped:Connect(function(p1) --[[ Line: 104 | Upvalues: AnomalyDetector (copy), v2 (ref), v3 (ref), v1 (ref), LocalPlayer (copy), t (ref) ]]
	local v12 = math.clamp(p1 * 6, 0, 1)

	AnomalyDetector.Volume = AnomalyDetector.Volume + (v2 - AnomalyDetector.Volume) * v12
	AnomalyDetector.PlaybackSpeed = AnomalyDetector.PlaybackSpeed + (v3 - AnomalyDetector.PlaybackSpeed) * v12

	if AnomalyDetector.Volume > 0.005 then
		if not AnomalyDetector.IsPlaying then
			AnomalyDetector:Play()
		end
	elseif AnomalyDetector.IsPlaying and v2 <= 0 then
		AnomalyDetector:Stop()
	end

	v1 = v1 + p1

	if v1 < 0.15 then
		return
	end

	v1 = 0

	local Character = LocalPlayer.Character
	local v22 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
	local v32 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	if not v22 or (not v32 or v32.Health <= 0) then
		v2 = 0
		v3 = 1

		return
	end

	local Position = v22.Position
	local v4 = (1 / 0)

	for i = 1, #t do
		local v5 = t[i]
		local v6 = (v5.pos - Position).Magnitude - v5.radius

		if v6 < v4 then
			v4 = v6
		end
	end

	if v4 >= 50 then
		v2 = 0
		v3 = 1
	else
		local v7 = (1 - math.max(v4, 0) / 50) ^ 1.6

		v2 = v7 * 0.9 + 0.1
		v3 = v7 * 0 + 1
	end
end)