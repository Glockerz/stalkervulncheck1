-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SpatialWind = require(ReplicatedStorage:WaitForChild("SoundscapeConfig")).SpatialWind
local SoundscapeAssets = ReplicatedStorage:WaitForChild("SoundscapeAssets", 10)

if not SoundscapeAssets then
	warn("[SpatialWind] SoundscapeAssets folder missing -- nothing will play")

	return
end

local v1 = Random.new()
local tbl = {}

local function pickRandomFromFolder(p1, p2) --[[ pickRandomFromFolder | Line: 29 | Upvalues: SoundscapeAssets (copy), v1 (copy) ]]
	local v12 = SoundscapeAssets

	for i, v in ipairs(p1) do
		local v2 = v12:FindFirstChild(v)

		if not v2 then
			return nil
		end

		v12 = v2
	end

	local t = {}

	for i, v in ipairs(v12:GetChildren()) do
		if v:IsA("Sound") and v.Name:match(p2) then
			table.insert(t, v)
		end
	end

	if #t == 0 then
		return nil
	end

	return t[v1:NextInteger(1, #t)]
end

local function attach(p1, p2) --[[ attach | Line: 45 | Upvalues: tbl (copy), pickRandomFromFolder (copy) ]]
	if tbl[p1] then
		return
	end

	if not p1:IsA("BasePart") then
		return
	end

	local v1 = pickRandomFromFolder(p2.soundFolder, p2.namePattern)

	if v1 then
		local v2 = v1:Clone()

		v2.Name = "SpatialWind_" .. v1.Name
		v2.Looped = true
		v2.RollOffMode = Enum.RollOffMode.Inverse
		v2.RollOffMinDistance = p2.rollOffMin
		v2.RollOffMaxDistance = p2.rollOffMax
		v2.Volume = p2.volumeMin
		v2.Parent = p1
		v2:Play()
		tbl[p1] = {
			sound = v2,
			source = p2
		}
	else
		warn("[SpatialWind] No source sound found for", p2.namePattern, "in", table.concat(p2.soundFolder, "/"))
	end
end

local function detach(p1) --[[ detach | Line: 68 | Upvalues: tbl (copy) ]]
	local v1 = tbl[p1]

	if not v1 then
		return
	end

	if v1.sound and v1.sound.Parent then
		v1.sound:Destroy()
	end

	tbl[p1] = nil
end

for k, v in pairs(SpatialWind.Sources) do
	for i, v2 in ipairs(CollectionService:GetTagged(k)) do
		attach(v2, v)
	end

	CollectionService:GetInstanceAddedSignal(k):Connect(function(p1) --[[ Line: 84 | Upvalues: attach (copy), v (copy) ]]
		attach(p1, v)
	end)
	CollectionService:GetInstanceRemovedSignal(k):Connect(function(p1) --[[ Line: 87 | Upvalues: tbl (copy) ]]
		local v1 = tbl[p1]

		if not v1 then
			return
		end

		if v1.sound and v1.sound.Parent then
			v1.sound:Destroy()
		end

		tbl[p1] = nil
	end)
end

local v2 = 0

RunService.Heartbeat:Connect(function(p1) --[[ Line: 96 | Upvalues: v2 (ref), SpatialWind (copy), tbl (copy) ]]
	v2 = v2 + p1

	if v2 < 1 then
		return
	end

	v2 = v2 - 1

	local v22 = math.clamp(workspace.GlobalWind.Magnitude / SpatialWind.WindMagForMax, 0, 1)

	for k, v in pairs(tbl) do
		if v.sound and v.sound.Parent then
			v.sound.Volume = v.sound.Volume + (v.source.volumeMin + (v.source.volumeMax - v.source.volumeMin) * v22 - v.sound.Volume) * 0.25
		end
	end
end)

local spatialwindattacherinitializedexistingattached = 0

for k in pairs(tbl) do
	spatialwindattacherinitializedexistingattached = spatialwindattacherinitializedexistingattached + 1
end

print("[SpatialWind] Attacher initialized; existing attached:", spatialwindattacherinitializedexistingattached)