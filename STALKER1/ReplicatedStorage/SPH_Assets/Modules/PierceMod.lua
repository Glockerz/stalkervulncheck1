-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local t = {}
local CollectionService = game:GetService("CollectionService")
local v1 = Random.new()

local function RandomInt(p1, p2) --[[ RandomInt | Line: 9 | Upvalues: v1 (copy) ]]
	return v1:NextInteger(p1, p2)
end

local Modules = game:GetService("ReplicatedStorage").SPH_Assets.Modules
local HitFX = require(Modules.HitFX)
local MaterialTypes = require(Modules.MaterialTypes)
local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig)

local function IsInHumanoid(p1) --[[ IsInHumanoid | Line: 19 ]]
	while p1.Parent do
		if p1.Parent:FindFirstChild("Humanoid") then
			return p1.Parent.Humanoid
		end

		p1 = p1.Parent
	end

	return false
end

local function RoundUp(p1) --[[ RoundUp | Line: 30 ]]
	return math.floor(p1 + 0.5)
end

function t.CanPierce(p1, p2, p3) --[[ Line: 34 | Upvalues: IsInHumanoid (copy), Players (copy), CollectionService (copy), MaterialTypes (copy), v1 (copy), HitFX (copy), GameConfig (copy) ]]
	local v12 = false
	local v2 = p2.Instance
	local v3 = IsInHumanoid(v2)
	local CosmeticBulletObject = p1.RayInfo.CosmeticBulletObject

	if workspace:FindFirstChild("Vehicles") and v2:IsDescendantOf(workspace.Vehicles) then
		v12 = if v2:GetAttribute("ArmorThickness") then true else false
	elseif p1.UserData.IgnoreModel and v2:IsDescendantOf(p1.UserData.IgnoreModel) then
		v12 = true
	elseif v3 then
		local v4 = Players:GetPlayerFromCharacter(v3.Parent)

		if v4 and p1.UserData.Player == v4 or (v2.Parent:IsA("Accoutrement") or v2.Parent:IsA("Model") and v2.Parent ~= v3.Parent) then
			v12 = true
		end
	elseif CollectionService:HasTag(v2, "SPH_Collide") then
		v12 = false
	elseif v2.Transparency == 1 or (not v2.CanCollide or (v2.Name == "Ignore" or CollectionService:HasTag(v2, "SPH_NoCollide"))) then
		v12 = true
	end

	if not v12 and p1.UserData.Tool then
		local v5 = nil

		if typeof(p1.UserData.Tool) == "number" and p1.UserData.IgnoreModel.Base["FirePoint" .. p1.UserData.Tool]:FindFirstChild("BulletPhysics") then
			v5 = p1.UserData.IgnoreModel.Base["FirePoint" .. p1.UserData.Tool]:FindFirstChild("BulletPhysics")
		elseif p1.UserData.Tool:FindFirstChild("SPH_Weapon") and p1.UserData.Tool.SPH_Weapon:FindFirstChild("BulletPhysics") then
			v5 = p1.UserData.Tool.SPH_Weapon:FindFirstChild("BulletPhysics")
		end

		if not v5 then
			return false
		end

		local v6 = require(v5).materialProperties[MaterialTypes(p2.Instance.Material)]
		local v11 = math.floor(math.abs(math.deg((math.acos((CosmeticBulletObject.CFrame.LookVector.Unit:Dot(p2.Normal.Unit))))) - 180) + 0.5)
		local RicochetAngle = v6.RicochetAngle

		if math.floor(v1:NextInteger(RicochetAngle[1] * 10, RicochetAngle[2] * 10) / 10 * (1 + p1:GetVelocity().Magnitude / 100000) + 0.5) < v11 and (p3.Magnitude > v6.MinRicochetVelocity and not v3) then
			HitFX.HitEffect(p2.Position, p2.Instance, p2.Normal)

			local v13 = CosmeticBulletObject.CFrame.LookVector - 2 * CosmeticBulletObject.CFrame.LookVector:Dot(p2.Normal) * p2.Normal
			local RicochetDeviation = v6.RicochetDeviation
			local v17 = Vector3.new(v1:NextInteger(-RicochetDeviation, RicochetDeviation) / 5000, v1:NextInteger(-RicochetDeviation, RicochetDeviation) / 5000, v1:NextInteger(-RicochetDeviation, RicochetDeviation) / 5000)
			local v18 = CFrame.fromOrientation(v17.X, v17.Y, v17.Z) * v13
			local VelocityMultiplier = v6.VelocityMultiplier

			p1:SetPosition(p2.Position)
			p1:SetVelocity(v1:NextInteger(VelocityMultiplier[1], VelocityMultiplier[2]) / 100 * p3.Magnitude * v18.Unit)

			return true
		end

		if GameConfig.bulletPen and not (v3 or v2:HasTag("SPH_Collide")) then
			local PenetrationDepth = v6.PenetrationDepth
			local v19 = math.random(PenetrationDepth[1] * 1000, PenetrationDepth[2] * 1000) / 1000
			local Unit = p3.Unit
			local v21 = RaycastParams.new()

			v21.FilterType = Enum.RaycastFilterType.Include
			v21.FilterDescendantsInstances = { v2 }

			local v22 = workspace:Raycast(p2.Position + Unit * v19, -Unit, v21)

			if v22 then
				HitFX.HitEffect(p2.Position, p2.Instance, p2.Normal)
				HitFX.HitEffect(v22.Position, v22.Instance, v22.Normal)

				return true
			end

			return false
		end
	end

	return v12
end

return t