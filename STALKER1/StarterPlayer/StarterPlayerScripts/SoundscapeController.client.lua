-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function dbg(...) --[[ dbg | Line: 24 ]] end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local SoundscapeConfig = require(ReplicatedStorage:WaitForChild("SoundscapeConfig"))
local SoundscapeAssets = ReplicatedStorage:WaitForChild("SoundscapeAssets", 10)

if not SoundscapeAssets then
	warn("[Soundscape] SoundscapeAssets folder missing -- nothing will play")
end

local LocalPlayer = Players.LocalPlayer

local function ensureChild(p1, p2, p3) --[[ ensureChild | Line: 44 ]]
	local v1 = p1:FindFirstChild(p2)

	if v1 and v1:IsA(p3) then
		return v1
	end

	local v2

	if not v1 then
		v2 = Instance.new(p3)
		v2.Name = p2
		v2.Parent = p1

		return v2
	end

	v1:Destroy()
	v2 = Instance.new(p3)
	v2.Name = p2
	v2.Parent = p1

	return v2
end

local Soundscape = SoundService:FindFirstChild("Soundscape")
local v1

if Soundscape and Soundscape:IsA("Folder") then
	v1 = Soundscape
else
	if Soundscape then
		Soundscape:Destroy()
	end

	local Soundscape2 = Instance.new("Folder")

	Soundscape2.Name = "Soundscape"
	Soundscape2.Parent = SoundService
	v1 = Soundscape2
end

local Bed = v1:FindFirstChild("Bed")
local v2

if Bed and Bed:IsA("SoundGroup") then
	v2 = Bed
else
	if Bed then
		Bed:Destroy()
	end

	local Bed2 = Instance.new("SoundGroup")

	Bed2.Name = "Bed"
	Bed2.Parent = v1
	v2 = Bed2
end

local Environmental = v1:FindFirstChild("Environmental")
local v3

if Environmental and Environmental:IsA("SoundGroup") then
	v3 = Environmental
else
	if Environmental then
		Environmental:Destroy()
	end

	local Environmental2 = Instance.new("SoundGroup")

	Environmental2.Name = "Environmental"
	Environmental2.Parent = v1
	v3 = Environmental2
end

local OneShots = v1:FindFirstChild("OneShots")
local v4

if OneShots and OneShots:IsA("SoundGroup") then
	v4 = OneShots
else
	if OneShots then
		OneShots:Destroy()
	end

	local OneShots2 = Instance.new("SoundGroup")

	OneShots2.Name = "OneShots"
	OneShots2.Parent = v1
	v4 = OneShots2
end

v2.Volume = 1.5
v3.Volume = 1.5
v4.Volume = 1.8

local t = {}

local function resolvePath(p1) --[[ resolvePath | Line: 72 | Upvalues: SoundscapeAssets (copy) ]]
	if not SoundscapeAssets then
		return nil
	end

	local v1 = SoundscapeAssets

	for i, v in ipairs(p1) do
		local v2 = v1:FindFirstChild(v)

		if not v2 then
			return nil
		end

		v1 = v2
	end

	if v1:IsA("Sound") then
		return v1
	end

	return nil
end

local function cloneAsset(p1, p2) --[[ cloneAsset | Line: 83 | Upvalues: resolvePath (copy), t (copy) ]]
	local v1 = resolvePath(p1)

	if v1 then
		local v2 = v1:Clone()

		v2.SoundGroup = p2

		return v2
	end

	local v3 = table.concat(p1, "/")

	if t[v3] then
		return nil
	end

	warn("[Soundscape] Asset not found:", v3)
	t[v3] = true

	return nil
end

local function pathKey(p1) --[[ pathKey | Line: 98 ]]
	return table.concat(p1, "/")
end

local t2 = {}

for i, v in ipairs(SoundscapeConfig.Bed.Layers) do
	local v5 = cloneAsset(v.path, v2)

	if v5 then
		v5.Name = "Bed_" .. v.path[#v.path]
		v5.Looped = true
		v5.Volume = 0
		v5.Parent = SoundService
		v5:Play()
		table.insert(t2, {
			sound = v5,
			thresholdMin = v.thresholdMin,
			baseVolume = v.baseVolume,
			thresholdMax = v.thresholdMax,
			maxVolume = v.maxVolume
		})
		dbg("[Soundscape] Bed layer:", table.concat(v.path, "/"), "-- silent below mag", v.thresholdMin, "| range", v.baseVolume, "->", v.maxVolume, "@ mag", v.thresholdMin, "->", v.thresholdMax)
	end
end

local function computeLayerTarget(p1, p2) --[[ computeLayerTarget | Line: 135 ]]
	if p1 < p2.thresholdMin then
		return 0
	end

	local v1 = p2.thresholdMax - p2.thresholdMin

	return p2.baseVolume + (p2.maxVolume - p2.baseVolume) * (v1 > 0 and math.clamp((p1 - p2.thresholdMin) / v1, 0, 1) or 1)
end

local v6 = 0

RunService.Heartbeat:Connect(function(p1) --[[ Line: 144 | Upvalues: v6 (ref), t2 (copy) ]]
	v6 = v6 + p1

	if v6 < 1 then
		return
	end

	v6 = v6 - 1

	local Magnitude = workspace.GlobalWind.Magnitude

	for i, v in ipairs(t2) do
		local v1, v2

		if Magnitude < v.thresholdMin then
			v1 = 0
		else
			local v3 = v.thresholdMax - v.thresholdMin

			v2 = v3 > 0 and math.clamp((Magnitude - v.thresholdMin) / v3, 0, 1) or 1
			v1 = v.baseVolume + (v.maxVolume - v.baseVolume) * v2
		end

		v.sound.Volume = v.sound.Volume + (v1 - v.sound.Volume) * 0.25
	end
end)

local tbl = {}

for i, v in ipairs(SoundscapeConfig.TimeSlots) do
	local v7 = SoundscapeConfig.EnvironmentalLoops[v.name]

	if v7 then
		local v8 = cloneAsset(v7.path, v3)

		if v8 then
			v8.Name = "Env_" .. v.name
			v8.Looped = true
			v8.Volume = 0
			v8.Parent = SoundService
			v8:Play()
			tbl[v.name] = v8
		end
	end
end

local function resolveSlot(p1) --[[ resolveSlot | Line: 175 | Upvalues: SoundscapeConfig (copy) ]]
	for i, v in ipairs(SoundscapeConfig.TimeSlots) do
		local startHour = v.startHour
		local endHour = v.endHour

		if startHour < endHour then
			if startHour <= p1 and p1 < endHour then
				return v.name
			end

			continue
		end

		if startHour <= p1 or p1 < endHour then
			return v.name
		end
	end

	return SoundscapeConfig.TimeSlots[1].name
end

local function crossfadeTo(p1) --[[ crossfadeTo | Line: 188 | Upvalues: tbl (copy), SoundscapeConfig (copy), TweenService (copy) ]]
	for k, v in pairs(tbl) do
		local v1 = if k == p1 then SoundscapeConfig.EnvironmentalLoops[k].volume or 0 else 0

		TweenService:Create(v, TweenInfo.new(SoundscapeConfig.SlotCrossfadeSeconds, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
			Volume = v1
		}):Play()
	end
end

local v9 = resolveSlot((math.floor(Lighting.ClockTime)))

crossfadeTo(v9)
dbg("[Soundscape] Starting slot:", v9)
task.spawn(function() --[[ Line: 204 | Upvalues: resolveSlot (copy), Lighting (copy), v9 (ref), dbg (copy), crossfadeTo (copy) ]]
	while true do
		local v1

		repeat
			task.wait(1)
			v1 = resolveSlot((math.floor(Lighting.ClockTime)))
		until v1 ~= v9

		dbg("[Soundscape] Slot change:", v9, "->", v1)
		v9 = v1
		crossfadeTo(v1)
	end
end)

local v10 = Random.new()

local function poissonDelay(p1) --[[ poissonDelay | Line: 221 | Upvalues: v10 (copy) ]]
	return -math.log(1 - v10:NextNumber()) * p1
end

local function weightedPick(p1) --[[ weightedPick | Line: 225 | Upvalues: v10 (copy) ]]
	if #p1 == 0 then
		return nil
	end

	local sum = 0

	for i, v in ipairs(p1) do
		sum = sum + v.weight
	end

	local v1 = v10:NextNumber() * sum
	local sum2 = 0

	for i, v in ipairs(p1) do
		sum2 = sum2 + v.weight

		if v1 <= sum2 then
			return v
		end
	end

	return p1[#p1]
end

local t3 = {}

if SoundscapeConfig.SpookOneShots and SoundscapeAssets then
	local Spooks = SoundscapeAssets:FindFirstChild("Spooks")

	if Spooks then
		for k, v in pairs(SoundscapeConfig.SpookOneShots.Categories) do
			local v11 = Spooks:FindFirstChild(k)

			if v11 then
				local t4 = {}

				for i, v5 in ipairs(v11:GetChildren()) do
					if v5:IsA("Sound") then
						table.insert(t4, {
							path = { "Spooks", k, v5.Name },
							volume = v.volume,
							spatial = v.spatial,
							rollOffMin = v.rollOffMin,
							rollOffMax = v.rollOffMax
						})
					end
				end

				t3[k] = {
					entries = t4,
					weights = v.weight
				}
				dbg("[Soundscape] Spook category:", k, "-- " .. #t4 .. " sounds")

				continue
			end

			warn("[Soundscape] Spook folder missing:", k)
		end
	else
		warn("[Soundscape] SoundscapeAssets/Spooks not found -- spook pool empty")
	end
end

local function getCurrentPool() --[[ getCurrentPool | Line: 271 | Upvalues: SoundscapeConfig (copy), t (copy), v9 (ref), t3 (copy) ]]
	local t2 = {}

	for i, v in ipairs(SoundscapeConfig.OneShots.Global) do
		if not t[table.concat(v.path, "/")] then
			table.insert(t2, v)
		end
	end

	local v2 = ipairs

	for v4, v5 in v2(SoundscapeConfig.OneShots[v9] or {}) do
		if not t[table.concat(v5.path, "/")] then
			table.insert(t2, v5)
		end
	end

	for k, v in pairs(t3) do
		local v7 = v.weights[v9]

		if v7 and v7 > 0 then
			for i, v4 in ipairs(v.entries) do
				if not t[table.concat(v4.path, "/")] then
					table.insert(t2, {
						path = v4.path,
						volume = v4.volume,
						spatial = v4.spatial,
						rollOffMin = v4.rollOffMin,
						rollOffMax = v4.rollOffMax,
						weight = v7
					})
				end
			end
		end
	end

	return t2
end

local function spawnSpatialAttachment() --[[ spawnSpatialAttachment | Line: 305 | Upvalues: LocalPlayer (copy), v10 (copy), SoundscapeConfig (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if v1 then
		local v2 = v10:NextNumber() * math.pi * 2
		local v3 = v10:NextNumber(SoundscapeConfig.SpatialRadiusMin, SoundscapeConfig.SpatialRadiusMax)
		local v4 = v10:NextNumber(SoundscapeConfig.SpatialHeightRange.min, SoundscapeConfig.SpatialHeightRange.max)
		local v7 = v1.Position + Vector3.new(math.cos(v2) * v3, v4, math.sin(v2) * v3)
		local SoundscapeOneShotAttach = Instance.new("Attachment")

		SoundscapeOneShotAttach.Name = "SoundscapeOneShotAttach"
		SoundscapeOneShotAttach.WorldPosition = v7
		SoundscapeOneShotAttach.Parent = workspace.Terrain

		return SoundscapeOneShotAttach
	end

	return nil
end

local function playOneShot(p1) --[[ playOneShot | Line: 320 | Upvalues: cloneAsset (copy), v4 (copy), spawnSpatialAttachment (copy), SoundService (copy), t (copy) ]]
	local v1 = cloneAsset(p1.path, v4)

	if not v1 then
		return
	end

	v1.Name = "OneShot_" .. p1.path[#p1.path]
	v1.Volume = p1.volume

	if p1.rollOffMin then
		v1.RollOffMinDistance = p1.rollOffMin
	end

	if p1.rollOffMax then
		v1.RollOffMaxDistance = p1.rollOffMax
	end

	if p1.spatial then
		local v2 = spawnSpatialAttachment()

		if not v2 then
			v1:Destroy()

			return
		end

		v1.Parent = v2
		v1.Ended:Connect(function() --[[ Line: 332 | Upvalues: v2 (copy) ]]
			v2:Destroy()
		end)
	else
		v1.Parent = SoundService
		v1.Ended:Connect(function() --[[ Line: 335 | Upvalues: v1 (copy) ]]
			v1:Destroy()
		end)
	end

	v1:Play()
	task.delay(3, function() --[[ Line: 341 | Upvalues: v1 (copy), p1 (copy), t (ref) ]]
		if not v1.Parent or (v1.IsLoaded or v1.IsPlaying) then
			return
		end

		local v12 = table.concat(p1.path, "/")

		if not t[v12] then
			warn("[Soundscape] One-shot failed to load, removing from pool:", v12)
			t[v12] = true
		end

		v1:Destroy()
	end)
end

task.spawn(function() --[[ Line: 353 | Upvalues: SoundscapeConfig (copy), v9 (ref), v10 (copy), getCurrentPool (copy), weightedPick (copy), playOneShot (copy) ]]
	while true do
		local v1

		repeat
			local v3 = task.wait

			v3(-math.log(1 - v10:NextNumber()) * (SoundscapeConfig.OneShotMeanIntervalSeconds[v9] or 60))
			v1 = weightedPick((getCurrentPool()))
		until v1

		playOneShot(v1)
	end
end)

local Magnitude = workspace.GlobalWind.Magnitude
local v12 = (-1 / 0)

local function nearestTaggedTree(p1, p2) --[[ nearestTaggedTree | Line: 370 | Upvalues: CollectionService (copy), SoundscapeConfig (copy) ]]
	local v1, v2 = p2, nil

	for i, v in ipairs(CollectionService:GetTagged(SoundscapeConfig.Gust.TreeTag)) do
		if v:IsA("BasePart") then
			local Magnitude = (v.Position - p1).Magnitude

			if Magnitude <= v1 then
				v1 = Magnitude
				v2 = v
			end
		end
	end

	return v2
end

local function playGustOneShot() --[[ playGustOneShot | Line: 384 | Upvalues: weightedPick (copy), SoundscapeConfig (copy), cloneAsset (copy), v4 (copy), LocalPlayer (copy), nearestTaggedTree (copy), spawnSpatialAttachment (copy) ]]
	local v1 = weightedPick(SoundscapeConfig.Gust.OneShots)

	if not v1 then
		return
	end

	local v2 = cloneAsset(v1.path, v4)

	if not v2 then
		return
	end

	v2.Name = "Gust_" .. v1.path[#v1.path]
	v2.Volume = v1.volume

	local Character = LocalPlayer.Character
	local v3 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v3 then
		v2:Destroy()

		return
	end

	local v42 = nearestTaggedTree(v3.Position, SoundscapeConfig.Gust.PreferTaggedTreeRadius)

	if v42 then
		v2.Parent = v42
		v2.Ended:Connect(function() --[[ Line: 400 | Upvalues: v2 (copy) ]]
			v2:Destroy()
		end)
	else
		local v5 = spawnSpatialAttachment()

		if not v5 then
			v2:Destroy()

			return
		end

		v2.Parent = v5
		v2.Ended:Connect(function() --[[ Line: 405 | Upvalues: v5 (copy) ]]
			v5:Destroy()
		end)
	end

	v2:Play()
end

local v13 = 0

RunService.Heartbeat:Connect(function(p1) --[[ Line: 412 | Upvalues: v13 (ref), Magnitude (ref), SoundscapeConfig (copy), v12 (ref), playGustOneShot (copy), dbg (copy) ]]
	v13 = v13 + p1

	if v13 < 0.25 then
		return
	end

	v13 = v13 - 0.25

	local Magnitude2 = workspace.GlobalWind.Magnitude
	local v1 = if Magnitude < SoundscapeConfig.Gust.PeakMagnitudeThreshold then if SoundscapeConfig.Gust.PeakMagnitudeThreshold <= Magnitude2 then true else false else false

	if v1 and (if os.clock() - v12 >= SoundscapeConfig.Gust.MinSecondsBetweenOneShots then true else false) then
		v12 = os.clock()
		playGustOneShot()
		dbg("[Soundscape] Gust one-shot fired at magnitude", string.format("%.1f", Magnitude2))
	end

	Magnitude = Magnitude2
end)
_G.Soundscape = {
	GetCurrentSlot = function() --[[ GetCurrentSlot | Line: 436 | Upvalues: v9 (ref) ]]
		return v9
	end,
	ForceSlot = function(p1) --[[ ForceSlot | Line: 437 | Upvalues: tbl (copy), v9 (ref), crossfadeTo (copy) ]]
		if tbl[p1] then
			v9 = p1
			crossfadeTo(p1)
			print("[Soundscape] Forced slot:", p1)
		else
			warn("[Soundscape] ForceSlot: unknown slot", p1)
		end
	end
}

local v14 = print
local count = 0

for k in pairs(tbl) do
	count = count + 1
end

v14("[Soundscape] Controller fully initialized; bed layers:", #t2, "env loops:", count)

local function _() --[[ Unreferenced function | Upvalues: v1 (ref) ]]
	local count = 0

	for k in pairs(v1) do
		count = count + 1
	end

	return count
end