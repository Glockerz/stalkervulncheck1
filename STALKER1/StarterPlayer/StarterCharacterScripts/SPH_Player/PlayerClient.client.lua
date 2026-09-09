-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

game:GetService("HttpService")

local SPH_Assets = ReplicatedStorage.SPH_Assets
local Animations = SPH_Assets.Animations
local Modules = SPH_Assets.Modules
local LocalPlayer = Players.LocalPlayer
local GameConfig = require(SPH_Assets.GameConfig)

print("\227\128\144 SPEARHEAD \227\128\145 " .. "Loading Client " .. GameConfig.version)

local HitFX = require(Modules.HitFX)
local ShellEjection = require(Modules.ShellEjection)
local BulletHandler = require(Modules.BulletHandler)
local BridgeNet = require(ReplicatedStorage.SPH_Assets.Modules.BridgeNet)
local v1 = BridgeNet.CreateBridge("BodyAnimCommand")
local v2 = BridgeNet.CreateBridge("ReplicateFire")
local v3 = BridgeNet.CreateBridge("ReplicateSound")
local v4 = BridgeNet.CreateBridge("ReplicateHit")
local v5 = BridgeNet.CreateBridge("ReplicateBolt")
local v6 = BridgeNet.CreateBridge("ReplicateCharacterSound")
local v7 = BridgeNet.CreateBridge("ReplicateToggleAttachment")
local v8 = BridgeNet.CreateBridge("ReplicateMagGrab")
local v9 = BridgeNet.CreateBridge("ReplicateLean")
local v10 = BridgeNet.CreateBridge("ReplicateBipodSound")
local t = {}
local t2 = {}

local function AddRig(p1, p2) --[[ AddRig | Line: 38 | Upvalues: t (copy) ]]
	t[p2] = {
		animator = p1.AnimationController.Animator,
		LoadedAnimations = {}
	}
end

local function FireBullet(p1, p2, p3, p4) --[[ FireBullet | Line: 46 | Upvalues: BulletHandler (copy), ShellEjection (copy) ]]
	local v1 = p1.Character:FindFirstChildWhichIsA("Tool")

	if not (v1 and v1:FindFirstChild("SPH_Weapon")) then
		return
	end

	local WeaponRig = p1.Character.WeaponRig
	local v2 = WeaponRig.Weapon:FindFirstChildWhichIsA("Model")
	local WeaponStats = require(v1.SPH_Weapon.WeaponStats)
	local Muzzle = v2.Grip.Muzzle

	if p4.muzzleChance then
		if p4.IsSuppressor then
			BulletHandler.FireFX(p1, v2, "Muzzle", p4.muzzleChance, true)
		else
			BulletHandler.FireFX(p1, v2, "Muzzle", p4.muzzleChance, false)
		end
	else
		BulletHandler.FireFX(p1, v2, "Muzzle", WeaponStats.muzzleChance)
	end

	local Muzzle2 = v2.Grip.Muzzle
	local LookVector = Muzzle2.WorldCFrame.LookVector
	local muzzleVelocity = WeaponStats.muzzleVelocity

	if p4.muzzleVelocity then
		muzzleVelocity = p4.muzzleVelocity
	end

	local v4 = nil
	local tracers = WeaponStats.tracers
	local tracerTiming = WeaponStats.tracerTiming
	local tracerColor = WeaponStats.tracerColor

	if p4.tracers then
		tracers = p4.tracers
		tracerTiming = p4.tracerTiming
		tracerColor = p4.tracerColor
	end

	if tracers and v1.Ammo.MagAmmo.Value % tracerTiming == 0 then
		v4 = tracerColor
	end

	if v4 == "Random" then
		v4 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
	end

	BulletHandler.FireBullet(WeaponRig, Muzzle2.WorldCFrame.Position, LookVector, LookVector * muzzleVelocity * 3.5, v1, p1, v4, true, p4)

	if WeaponStats.fireMode == "Manual" or not WeaponStats.shellEject then
		return
	end

	ShellEjection.ejectShell(p1, v1, v2)
end

v1:Connect(function(p1, p2) --[[ Line: 106 | Upvalues: GameConfig (copy), TweenService (copy) ]]
	local Humanoid = p1:FindFirstChild("Humanoid")

	if not Humanoid or (Humanoid.Health <= 0 or not (p1:FindFirstChild("Torso") or p1:FindFirstChild("UpperTorso"))) then
		return
	end

	local v1 = if p1.Humanoid.RigType == Enum.HumanoidRigType.R6 then p1.Torso.Neck else p1.UpperTorso.Neck

	TweenService:Create(v1, TweenInfo.new(GameConfig.replicatedHeadRotationSpeed, Enum.EasingStyle.Quad), {
		C1 = p2
	}):Play()
end)
v9:Connect(function(p1, p2) --[[ Line: 124 | Upvalues: TweenService (copy) ]]
	if not p1:FindFirstChild("HumanoidRootPart") then
		return
	end

	local v1 = CFrame.new(-p2 / 2, 0, 0) * CFrame.Angles(1.5707963267948966, math.rad(17 * p2) + math.pi, 0)
	local RootJoint = p1.HumanoidRootPart:FindFirstChild("RootJoint")

	if not RootJoint then
		return
	end

	TweenService:Create(RootJoint, TweenInfo.new(0.5), {
		C1 = v1
	}):Play()
end)
v2:Connect(FireBullet)
v3:Connect(function(p1, p2, p3) --[[ Line: 137 | Upvalues: Debris (copy) ]]
	if not p2 then
		return
	end

	if not p3 then
		p2:Play()

		return
	end

	if not (p1.Character:FindFirstChild("Torso") and p1.Character:FindFirstChild("UpperTorso")) then
		return
	end

	local v1 = p2:Clone()

	if not (p2.Parent and p2.Parent:IsA("BasePart")) then
		v1.Parent = p1.Character.HumanoidRootPart
	end

	v1.Parent = p2.Parent
	v1:Play()

	local TimeLength = v1.TimeLength

	if TimeLength < 1 then
		TimeLength = 1
	end

	Debris:AddItem(v1, TimeLength)
end)
v4:Connect(function(p1, p2) --[[ Line: 157 | Upvalues: HitFX (copy) ]]
	local WeaponStats = require(p1.SPH_Weapon.WeaponStats)

	if not p2.Instance or WeaponStats.projectile ~= "Bullet" then
		return
	end

	HitFX.HitEffect(p2.Position, p2.Instance, p2.Normal)
end)
v5:Connect(function(p1, p2, p3) --[[ Line: 165 | Upvalues: BulletHandler (copy) ]]
	local v1 = p1.Character.WeaponRig.Weapon:FindFirstChildWhichIsA("Model")
	local WeaponStats = require(p1.Character:FindFirstChildWhichIsA("Tool").SPH_Weapon.WeaponStats)

	BulletHandler.MoveBolt(v1, {
		fireMoveParts = WeaponStats.fireMoveParts,
		fireRate = WeaponStats.fireRate,
		emptyLockBolt = WeaponStats.emptyLockBolt
	}, p2, p3)
end)
v6:Connect(function(p1, p2) --[[ Line: 176 | Upvalues: SPH_Assets (copy), Debris (copy) ]]
	local HumanoidRootPart = p1.Character:WaitForChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	local v1 = SPH_Assets.Sounds[p2]:GetChildren()
	local v2 = v1[math.random(#v1)]:Clone()

	v2.Parent = HumanoidRootPart
	v2:Play()
	Debris:AddItem(v2, v2.TimeLength)
end)
v7:Connect(function(p1, p2, p3) --[[ Line: 187 | Upvalues: SPH_Assets (copy), t2 (copy), TweenService (copy) ]]
	if p1.Name == "Flashlight" then
		p1:FindFirstChildWhichIsA("Light").Enabled = p2

		return
	end

	if p1.Name == "Laser" then
		if p2 then
			local ReplicatedLaser = Instance.new("Attachment", workspace.Terrain)

			ReplicatedLaser.Name = "ReplicatedLaser"

			local v1 = SPH_Assets.HUD.LaserDotUI:Clone()

			v1.Enabled = true
			v1.Dot.ImageColor3 = p1.Color.Value
			v1.Parent = ReplicatedLaser
			table.insert(t2, {
				laserDot = ReplicatedLaser,
				attachment = p1,
				ignoreModel = p3
			})

			return
		end

		for i, v in ipairs(t2) do
			if v.attachment == p1 then
				v.laserDot:Destroy()
				table.remove(t2, i)

				return
			end
		end
	else
		if p1.Name ~= "Bipod" then
			return
		end

		local v3 = TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.025)

		if p2 then
			for k, v in pairs(p1.Parent.Parent:GetChildren()) do
				if v.Name == "Bipod_Active" then
					TweenService:Create(v, v3, {
						Transparency = 0
					}):Play()

					continue
				end

				if v.Name == "Bipod_Reg" then
					TweenService:Create(v, v3, {
						Transparency = 1
					}):Play()
				end
			end
		else
			for k, v in pairs(p1.Parent.Parent:GetChildren()) do
				if v.Name == "Bipod_Active" then
					TweenService:Create(v, v3, {
						Transparency = 1
					}):Play()

					continue
				end

				if v.Name == "Bipod_Reg" then
					TweenService:Create(v, v3, {
						Transparency = 0
					}):Play()
				end
			end
		end
	end
end)
v10:Connect(function() --[[ Line: 236 | Upvalues: SPH_Assets (copy), Debris (copy) ]]
	local v1 = SPH_Assets.Sounds.Bipod:Clone()

	v1.Parent = workspace
	v1:Play()
	Debris:AddItem(v1, v1.TimeLength)
end)
RunService.RenderStepped:Connect(function() --[[ Line: 243 | Upvalues: t2 (copy) ]]
	for i, v in ipairs(t2) do
		local attachment = v.attachment

		if attachment and attachment.Parent then
			local v1 = RaycastParams.new()

			v1.FilterType = Enum.RaycastFilterType.Exclude
			v1.FilterDescendantsInstances = { v.ignoreModel }

			local laserDot = v.laserDot
			local v2 = workspace:Raycast(attachment.WorldPosition, attachment.WorldCFrame.LookVector * 600, v1)

			if v2 then
				v.laserDot.LaserDotUI.Enabled = true
				laserDot.WorldPosition = v2.Position

				continue
			end

			v.laserDot.LaserDotUI.Enabled = false

			continue
		end

		v.laserDot:Destroy()
		table.remove(t2, i)
	end
end)
v8:Connect(function(p1) --[[ Line: 265 ]]
	if not p1 then
		return
	end

	p1.LocalTransparencyModifier = 0

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			v.LocalTransparencyModifier = 0
		end
	end
end)
print("\227\128\144 SPEARHEAD \227\128\145 Main Client loaded successfully!")