-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local FilmGrain = Instance.new("ScreenGui")

FilmGrain.Name = "FilmGrain"
FilmGrain.ResetOnSpawn = false
FilmGrain.IgnoreGuiInset = true
FilmGrain.DisplayOrder = 99
FilmGrain.Parent = PlayerGui

local ImageLabel = Instance.new("ImageLabel")

ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.BackgroundTransparency = 1
ImageLabel.ImageTransparency = 1
ImageLabel.ScaleType = Enum.ScaleType.Tile
ImageLabel.TileSize = UDim2.new(1, 0, 1, 0)
ImageLabel.Image = "rbxassetid://95161230430908"
ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Parent = FilmGrain

local v1 = 0
local v2 = 100
local RadSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RadSync", 10)

if RadSync then
	RadSync.OnClientEvent:Connect(function(p1, p2) --[[ Line: 33 | Upvalues: v1 (ref), v2 (ref) ]]
		v1 = p1
		v2 = p2 or 100
	end)
end

local function getProximityIntensity() --[[ getProximityIntensity | Line: 40 | Upvalues: LocalPlayer (copy), CollectionService (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return 0
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return 0
	end

	local v2 = 0

	for i, v in ipairs((CollectionService:GetTagged("RadZone"))) do
		if v:IsA("BasePart") then
			local v3 = v:GetAttribute("RadLevel") or 1
			local Magnitude = (HumanoidRootPart.Position - v.Position).Magnitude
			local v4 = v:GetAttribute("RadProximityRange") or 80
			local v5 = v.CFrame:PointToObjectSpace(HumanoidRootPart.Position)
			local v6 = v.Size * 0.5
			local Magnitude2 = (v5 - Vector3.new(math.clamp(v5.X, -v6.X, v6.X), math.clamp(v5.Y, -v6.Y, v6.Y), (math.clamp(v5.Z, -v6.Z, v6.Z)))).Magnitude
			local v13 = 0

			if Magnitude2 <= 0 then
				v13 = v3 / 10
			elseif Magnitude2 < v4 then
				v13 = v3 / 10 * (1 - Magnitude2 / v4)
			end

			if v2 < v13 then
				v2 = v13
			end
		end
	end

	for i, v in ipairs((CollectionService:GetTagged("RadSource"))) do
		if v:IsA("BasePart") then
			local v15 = v:GetAttribute("RadIntensity") or 5
			local v16 = v:GetAttribute("RadRadius") or 30

			if v16 > 0 then
				local Magnitude = (v.Position - HumanoidRootPart.Position).Magnitude

				if Magnitude < v16 then
					local v17 = v15 / 10
					local v19 = math.max(v17 * 0.15, v17 * math.sqrt(1 - Magnitude / v16))

					if v2 < v19 then
						v2 = v19
					end
				end
			end
		end
	end

	return math.clamp(v2, 0, 1)
end

local random = math.random
local v3 = 0

RunService.Heartbeat:Connect(function() --[[ Line: 111 | Upvalues: getProximityIntensity (copy), v1 (ref), v2 (ref), ImageLabel (copy), v3 (ref), random (copy) ]]
	local v32 = math.max(getProximityIntensity(), v1 / v2)

	ImageLabel.ImageTransparency = if v32 <= 0.02 then 1 elseif v32 <= 0.4 then 0.95 - (v32 - 0.02) / 0.38 * 0.07 elseif v32 <= 0.7 then 0.88 - (v32 - 0.4) / 0.3 * 0.08 else 0.8 - math.clamp((v32 - 0.7) / 0.3, 0, 1) * 0.1

	if not (tick() - v3 >= 0.025) then
		return
	end

	v3 = tick()
	ImageLabel.TileSize = UDim2.new(random(950, 1050) / 1000, 0, random(950, 1050) / 1000, 0)
	ImageLabel.Position = UDim2.new(0, random(-3, 3), 0, random(-3, 3))
end)