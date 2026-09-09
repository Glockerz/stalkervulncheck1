-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets
local GameConfig = require(SPH_Assets.GameConfig)
local v1 = false

if not GameConfig.fallDamage then
	return
end

local RunService = game:GetService("RunService")
local v2 = script.Parent.Parent
local Humanoid = v2:WaitForChild("Humanoid")
local HumanoidRootPart = v2:WaitForChild("HumanoidRootPart")
local Y = HumanoidRootPart.Position.Y
local v3 = require(SPH_Assets.Modules.BridgeNet).CreateBridge("FallDamage")

Humanoid.Died:Connect(function() --[[ Line: 15 | Upvalues: v3 (copy), v1 (ref) ]]
	v3:Destroy()
	v1 = true
end)

local v4 = RaycastParams.new()

v4.IgnoreWater = false
v4.RespectCanCollide = false
v4.FilterType = Enum.RaycastFilterType.Exclude
v4.FilterDescendantsInstances = { v2 }

local v5 = 0
local v6 = false

RunService.RenderStepped:Connect(function() --[[ Line: 29 | Upvalues: v1 (ref), Humanoid (copy), v5 (ref), HumanoidRootPart (copy), v4 (copy), v6 (ref), GameConfig (copy), v3 (copy), Y (ref) ]]
	if v1 then
		return
	end

	if Humanoid.Sit then
		v5 = 0
	end

	local v12 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -3.1, 0), v4)

	if v12 and (v12.Instance and not script:GetAttribute("Override")) then
		if v6 then
			v6 = false

			if v5 > GameConfig.fallDamageDist then
				v3:Fire((v5 - GameConfig.fallDamageDist) * GameConfig.fallDamageMultiplier)
			end

			v5 = 0
		end
	else
		v6 = true
	end

	local Y2 = HumanoidRootPart.Position.Y

	v5 = if Y2 < Y and v6 then v5 + (Y - Y2) else 0
	Y = Y2
end)
Humanoid.Climbing:Connect(function() --[[ Line: 57 | Upvalues: v5 (ref) ]]
	v5 = 0
end)
Humanoid.Swimming:Connect(function() --[[ Line: 61 | Upvalues: v5 (ref) ]]
	v5 = 0
end)