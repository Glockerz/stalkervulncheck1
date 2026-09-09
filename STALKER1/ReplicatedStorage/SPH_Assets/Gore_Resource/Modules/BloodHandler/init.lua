-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Blood = ReplicatedStorage.Gore_Resource.Debris.Blood
local Splatters = Blood.Splatters
local Utilities = require(script.Utilities)
local Squirts = Blood.Squirts
local UnitHitbox = require(script.UnitHitbox)
local t = {}

local function Rand(p1) --[[ Rand | Line: 13 ]]
	local v1 = p1:GetChildren()

	return v1[math.random(1, #v1)]
end

function t.Spew(p1, p2) --[[ Spew | Line: 18 | Upvalues: Splatters (copy), UnitHitbox (copy), Debris (copy) ]]
	local v1 = RaycastParams.new()
	local v2 = Random.new():NextNumber(0.5, 4)

	v1.FilterType = Enum.RaycastFilterType.Exclude
	v1.RespectCanCollide = true
	v1.IgnoreWater = true
	v1.FilterDescendantsInstances = { workspace.Debris }

	local v3 = Splatters.Template.Blood:Clone()
	local v4 = Splatters.Decals:GetChildren()
	local v5 = v4[math.random(1, #v4)]:Clone()
	local v6 = UnitHitbox.new(v3, 10, v1)

	v6:HitStart()
	v3.Position = p2
	v3.Velocity = p1
	v3.Parent = workspace.Debris.Blood
	v6.onHit:Connect(function(p1) --[[ Line: 35 | Upvalues: v6 (copy), v5 (copy), v3 (copy), v2 (copy), Debris (ref) ]]
		v6:HitStop()

		if not p1.Instance.Parent:FindFirstChildOfClass("Humanoid") then
			v5.Parent = v3
			v3.CFrame = CFrame.new(p1.Position, p1.Position - p1.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
			v3.Size = Vector3.new(v2, 0.05, v2)
			Debris:AddItem(v3, 30)
			v3.Anchored = true
		end
	end)
end
function t.spill(p1) --[[ spill | Line: 51 | Upvalues: Squirts (copy), UnitHitbox (copy), Utilities (copy), TweenService (copy), Debris (copy) ]]
	for i = 1, 16 do
		local v1 = RaycastParams.new()
		local v2 = Random.new():NextNumber(0.1, 1.243)

		v1.FilterType = Enum.RaycastFilterType.Exclude
		v1.RespectCanCollide = true
		v1.IgnoreWater = true
		v1.FilterDescendantsInstances = { workspace.Debris }

		local v3 = Squirts.Template.Blood:Clone()
		local v4 = UnitHitbox.new(v3, 10, v1)

		v4:HitStart()
		v3.Position = p1.WorldPosition

		local v5 = p1.WorldCFrame.UpVector * Utilities.Random(5, 25)
		local v6 = Utilities.Random(-5, 5)
		local v7 = Utilities.Random(-5, 5)

		v3.Velocity = v5 + Vector3.new(v6, v7, Utilities.Random(-5, 5))
		v3.Parent = workspace.Debris.Blood
		v4.onHit:Connect(function(p1) --[[ Line: 69 | Upvalues: v3 (copy), v4 (copy), TweenService (ref), v2 (copy), Debris (ref) ]]
			v3:FindFirstChildOfClass("Trail").Enabled = false
			v4:HitStop()

			if not p1.Instance.Parent:FindFirstChildOfClass("Humanoid") then
				v3.Transparency = 0.2
				v3.CFrame = CFrame.new(p1.Position, p1.Position - p1.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)

				local v32 = TweenInfo.new(0.2)
				local t = {}

				t.Size = Vector3.new(v2, 0.08, v2)
				TweenService:Create(v3, v32, t):Play()
				Debris:AddItem(v3, 30)
				v3.Anchored = true
			end
		end)
	end

	wait(Random.new():NextNumber(0.01, 0.3))
end

return t