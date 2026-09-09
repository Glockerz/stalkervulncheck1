-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {}
local SPH_Assets = game:GetService("ReplicatedStorage"):WaitForChild("SPH_Assets")
local Modules = SPH_Assets:WaitForChild("Modules")
local WeldMod = require(Modules:WaitForChild("WeldMod"))
local ViewMod = require(Modules:WaitForChild("ViewMod"))

function t.LoadAnimTrack(p1, p2, p3) --[[ LoadAnimTrack | Line: 10 | Upvalues: t2 (copy), SPH_Assets (copy) ]]
	if t2[p1] and t2[p1][p2] then
		return t2[p1][p2]
	end

	local v1 = SPH_Assets:WaitForChild("Animations").R6:FindFirstChild(p2)

	if not (v1 and v1:IsA("Animation")) then
		return nil
	end

	local WeaponRig = p1:FindFirstChild("WeaponRig")

	if not WeaponRig then
		warn("[SPH_NPC] No WeaponRig when loading anim " .. p2)

		return nil
	end

	local AnimationController = WeaponRig:FindFirstChild("AnimationController")

	if not AnimationController then
		local AnimationController2 = Instance.new("AnimationController")

		AnimationController2.Parent = WeaponRig
		AnimationController = AnimationController2
	end

	local Animator = AnimationController:FindFirstChildOfClass("Animator")

	if not Animator then
		local Animator2 = Instance.new("Animator")

		Animator2.Parent = AnimationController
		Animator = Animator2
	end

	local v2 = Animator:LoadAnimation(v1)

	v2.Priority = if p3 then p3 else Enum.AnimationPriority.Action
	v2.KeyframeReached:Connect(function(p12) --[[ Line: 40 | Upvalues: p1 (copy) ]]
		local WeaponRig = p1:FindFirstChild("WeaponRig")

		if not WeaponRig then
			return
		end

		local v1 = WeaponRig.Weapon:FindFirstChildWhichIsA("Model")

		if not v1 then
			return
		end

		local v2 = v1.Grip:FindFirstChild(p12)

		if not (v2 and v2:IsA("Sound")) then
			return
		end

		v2:Play()
	end)

	if not t2[p1] then
		t2[p1] = {}
	end

	t2[p1][p2] = v2

	return v2
end
function t.ClearAnimCache(p1) --[[ ClearAnimCache | Line: 54 | Upvalues: t2 (copy) ]]
	t2[p1] = nil
end
function t.MakeWeaponRigForCharacter(p1) --[[ MakeWeaponRigForCharacter | Line: 58 | Upvalues: ViewMod (copy), WeldMod (copy) ]]
	local Head = p1:WaitForChild("Head")
	local WeaponRig = ViewMod.RigModel(nil, true, Head)

	WeaponRig.Name = "WeaponRig"
	WeaponRig.Parent = p1

	local law = WeldMod.BlankWeld(WeaponRig["Left Arm"], p1["Left Arm"])

	law.Parent = WeaponRig
	law.Name = "law"
	WeaponRig["Left Arm"].Transparency = 1

	local raw = WeldMod.BlankWeld(WeaponRig["Right Arm"], p1["Right Arm"])

	raw.Parent = WeaponRig
	raw.Name = "raw"
	WeaponRig["Right Arm"].Transparency = 1

	local AnimationController = Instance.new("AnimationController")

	AnimationController.Parent = WeaponRig
	Instance.new("Animator").Parent = AnimationController

	return WeaponRig
end
function t.SetupGun(p1, p2) --[[ SetupGun | Line: 81 ]]
	p1.CanBeDropped = false

	if p1:FindFirstChild("Ammo") then
		return
	end

	local Ammo = Instance.new("Folder")

	Ammo.Name = "Ammo"
	Ammo.Parent = p1

	local MagAmmo = Instance.new("DoubleConstrainedValue")

	MagAmmo.Name = "MagAmmo"
	MagAmmo.MaxValue = p2.magazineCapacity
	MagAmmo.Value = p2.magazineAmmo or MagAmmo.MaxValue
	MagAmmo.Parent = Ammo

	local ArcadeAmmoPool = Instance.new("DoubleConstrainedValue")

	ArcadeAmmoPool.Name = "ArcadeAmmoPool"
	ArcadeAmmoPool.MaxValue = p2.maxAmmoPool
	ArcadeAmmoPool.Value = p2.startAmmoPool
	ArcadeAmmoPool.Parent = Ammo

	if not p2.openBolt then
		local Chambered = Instance.new("BoolValue")

		Chambered.Name = "Chambered"
		Chambered.Value = p2.startChambered
		Chambered.Parent = p1

		if Chambered.Value then
			if MagAmmo.Value > 0 then
				MagAmmo.Value = MagAmmo.Value - 1
			else
				Chambered.Value = false
			end
		end
	end

	local BoltReady = Instance.new("BoolValue")

	BoltReady.Name = "BoltReady"
	BoltReady.Value = true
	BoltReady.Parent = p1

	local FireMode = Instance.new("IntValue")

	FireMode.Name = "FireMode"
	FireMode.Value = p2.fireMode
	FireMode.Parent = p1
end
function t.ToggleR6Shoulders(p1, p2) --[[ ToggleR6Shoulders | Line: 127 ]]
	local Torso = p1:WaitForChild("Torso")

	if not Torso then
		return
	end

	local v1 = Torso:WaitForChild("Left Shoulder")
	local v2 = Torso:WaitForChild("Right Shoulder")

	if v1 then
		v1.Enabled = not p2
	end

	if v2 then
		v2.Enabled = not p2
	end

	local WeaponRig = p1:WaitForChild("WeaponRig")

	if WeaponRig and WeaponRig:WaitForChild("law") then
		WeaponRig.law.Enabled = p2
	end

	if not (WeaponRig and WeaponRig:WaitForChild("raw")) then
		return
	end

	WeaponRig.raw.Enabled = p2
end
function t.EquipGunOnRig(p1, p2) --[[ EquipGunOnRig | Line: 139 | Upvalues: t (copy), SPH_Assets (copy), WeldMod (copy) ]]
	local v1 = p1:FindFirstChild("WeaponRig") or t.MakeWeaponRigForCharacter(p1)
	local WeaponStats = require(p2:WaitForChild("SPH_Weapon"):WaitForChild("WeaponStats"))

	t.SetupGun(p2, WeaponStats)

	local v2 = SPH_Assets:WaitForChild("WeaponModels"):FindFirstChild(p2.Name)

	if not v2 then
		warn("[SPH_NPC] Missing WeaponModels model for: " .. p2.Name)

		return nil, WeaponStats
	end

	local v3 = v1:FindFirstChild("Weapon") and v1.Weapon:FindFirstChildWhichIsA("Model")

	if v3 then
		v3:Destroy()
	end

	local v4 = v2:Clone()

	v4.Name = p2.Name
	v4.Parent = v1:WaitForChild("Weapon")

	if not WeaponStats.disableAutoRigging then
		WeldMod.WeldModel(v4, v4.Grip, false)

		local v5 = ipairs

		for v7, v8 in v5(WeaponStats.rigParts or {}) do
			local v9 = v4:FindFirstChild(v8)
			local v10 = v4.Grip:FindFirstChild("Grip_" .. v8)

			if v9 and v10 then
				v10:Destroy()

				local v11 = WeldMod.M6D(v4.Grip, v9)

				v11.Name = v8
				v11.Parent = v4.Grip
			end
		end

		for i, v in ipairs(v4:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
				v.Anchored = false
			end
		end
	end

	for i, v in ipairs(v4:GetChildren()) do
		if v.Name == "SightReticle" and v:FindFirstChild("SurfaceGui") then
			v.SurfaceGui.Enabled = false
		end
	end

	if v1.AnimBase:FindFirstChild("GunMotor") then
		v1.AnimBase.GunMotor:Destroy()
	end

	WeldMod.BlankM6D(v1.AnimBase, v4.Grip).Name = "GunMotor"
	v1.law.Enabled = true
	v1.raw.Enabled = true

	if v1:FindFirstChild("BaseWeld") then
		v1.BaseWeld.C0 = WeaponStats.serverOffset or CFrame.new()
	end

	p2:Clone().Parent = p1
	t.ToggleR6Shoulders(p1, true)

	return v4, WeaponStats
end

return t