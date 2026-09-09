-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService, UserInputService, TweenService, ContextActionService, SPH_Assets, LocalPlayer, v1, Humanoid, HumanoidRootPart, RootJoint, v2, CurrentCamera, FieldOfView, WeldMod, ShellEjection, BulletHandler, GameConfig, t, v5, v6, v7, v8, v9, v10, v11, v12, v15, v19, v20, v23, v24, v25, walkSpeed, v26, SPH_DoF, v27, v28, v29, v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v50, v51, v52, v53, v54, ModTable, v55, v56, v57, t2, v58, FiringBlur, v59, v60, v61, v62, v63, v64, v65, v66, v67, v68, v69, v70, v71, v72, v73, v74, v75, v76, FieldOfView2, v77, v78, zero, v79, v80, v81, v82, v83, v84, v85, t3, v86, CameraMode, t4, v87, v88, v89, v90, v91, v92, v93, Attachment, Trail, FirstPersonLaser, ThirdPersonLaser, v96, BuildCursor, Animator, AnimBase, v97, Animator2, PlayRepSound, PlayCharSound, MoveBolt, ToggleADS, v98, ChangeHoldStance, ChamberAnim, EquipAnim, ReloadAnim, RefreshViewmodel

do
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	RunService = game:GetService("RunService")
	UserInputService = game:GetService("UserInputService")

	local Debris = game:GetService("Debris")
	local Players = game:GetService("Players")

	TweenService = game:GetService("TweenService")
	game:GetService("TestService")
	game:GetService("HttpService")
	ContextActionService = game:GetService("ContextActionService")
	SPH_Assets = ReplicatedStorage.SPH_Assets

	local Modules = SPH_Assets.Modules
	local Animations = SPH_Assets.Animations

	LocalPlayer = Players.LocalPlayer
	v1 = script.Parent.Parent
	Humanoid = v1:WaitForChild("Humanoid")
	HumanoidRootPart = v1:WaitForChild("HumanoidRootPart")
	RootJoint = HumanoidRootPart:WaitForChild("RootJoint")
	v2 = if Humanoid.RigType == Enum.HumanoidRigType.R6 then v1.Torso.Neck else v1.UpperTorso.Neck
	CurrentCamera = workspace.CurrentCamera

	if CurrentCamera.CameraSubject ~= Humanoid then
		CurrentCamera.CameraSubject = Humanoid
	end

	CurrentCamera.CameraType = Enum.CameraType.Custom

	if CurrentCamera:FindFirstChild("WeaponRig") then
		CurrentCamera.WeaponRig:Destroy()
	end

	FieldOfView = CurrentCamera.FieldOfView
	WeldMod = require(Modules.WeldMod)

	local BridgeNet = require(Modules.BridgeNet)
	local ViewMod = require(Modules.ViewMod)
	local SpringModule = require(Modules.SpringModule)

	require(Modules.HitFX)
	ShellEjection = require(Modules.ShellEjection)
	BulletHandler = require(Modules.BulletHandler)

	local Mods = require(SPH_Assets.Mods)

	BulletHandler.Initialize(LocalPlayer)
	GameConfig = require(SPH_Assets.GameConfig)
	t = {}

	local function track(p1) --[[ track | Line: 83 | Upvalues: t (copy) ]]
		if string.sub(p1, 1, 9) ~= "SpeedCap_" then
			return
		end

		local v1 = script:GetAttribute(p1)

		t[p1] = if type(v1) == "number" and v1 then v1 else nil
	end

	for k in pairs(script:GetAttributes()) do
		if string.sub(k, 1, 9) == "SpeedCap_" then
			local v3 = script:GetAttribute(k)

			t[k] = type(v3) == "number" and v3 or nil
		end
	end

	script.AttributeChanged:Connect(track)
	Humanoid.WalkSpeed = GameConfig.walkSpeed

	local Shells = workspace:WaitForChild("SPH_Workspace"):WaitForChild("Shells")

	v5 = RaycastParams.new()
	v5.IgnoreWater = true
	v5.RespectCanCollide = true
	v5.FilterType = Enum.RaycastFilterType.Exclude
	v5.FilterDescendantsInstances = { v1, CurrentCamera, Shells }
	v6 = SpringModule.new()
	v7 = SpringModule.new()
	v8 = SpringModule.new()
	v8.Damping = 9
	v9 = SpringModule.new()
	v9.Damping = 9
	v10 = BridgeNet.CreateBridge("BodyAnimRequest")
	v11 = BridgeNet.CreateBridge("SwitchWeapon")
	v12 = BridgeNet.CreateBridge("PlayerFire")

	local v13 = BridgeNet.CreateBridge("PlaySound")
	local v14 = BridgeNet.CreateBridge("Reload")

	v15 = BridgeNet.CreateBridge("PlayerChamber")

	local v16 = BridgeNet.CreateBridge("MoveBolt")
	local v17 = BridgeNet.CreateBridge("SwitchFireMode")
	local v18 = BridgeNet.CreateBridge("PlayCharacterSound")

	v19 = BridgeNet.CreateBridge("PlayerDropGun")
	v20 = BridgeNet.CreateBridge("PlayerToggleAttachment")

	local v21 = BridgeNet.CreateBridge("RepBoltOpen")
	local v22 = BridgeNet.CreateBridge("MagGrab")

	v23 = BridgeNet.CreateBridge("PlayerLean")
	v24 = 0
	v25 = 0
	walkSpeed = GameConfig.walkSpeed
	v26 = walkSpeed
	SPH_DoF = game.Lighting:FindFirstChild("SPH_DoF") or GameConfig.blurEffects and Instance.new("DepthOfFieldEffect", game.Lighting)

	if SPH_DoF then
		SPH_DoF.Name = "SPH_DoF"
	end

	v27 = false
	v28 = true
	v29 = false
	v30 = false
	v31 = false
	v32 = true
	v33 = false
	v34 = false
	v35 = 0
	v36 = nil
	v37 = false
	v38 = false
	v39 = false
	v40 = true
	v41 = false
	v42 = false
	v43 = false
	v44 = false

	local AttModels = SPH_Assets.AttModels
	local AttModules = SPH_Assets.AttModules
	local v45 = nil
	local v46 = nil
	local v47 = nil
	local v48 = nil
	local v49 = nil

	v50 = nil
	v51 = nil
	v52 = nil
	v53 = nil
	v54 = nil
	ModTable = require(Modules.ModTable)
	function resetMods() --[[ resetMods | Line: 168 | Upvalues: ModTable (copy) ]]
		ModTable.aimFovMinMod = 1
		ModTable.AimTimeMod = 1
		ModTable.gunLengthMod = 0
		ModTable.IsSuppressor = false
		ModTable.EnableLaserAtt = nil
		ModTable.EnableFlashlightAtt = nil
		ModTable.laserAtt = nil
		ModTable.flashlightAtt = nil
		ModTable.bipodAtt = nil
		ModTable.isRangefinder = nil
		ModTable.recoilMod.vertical = 1
		ModTable.recoilMod.horizontal = 1
		ModTable.recoilMod.camShake = 1
		ModTable.recoilMod.damping = 1
		ModTable.recoilMod.speed = 1
		ModTable.recoilMod.aimReduction = 1
		ModTable.gunRecoilMod.vertical = 1
		ModTable.gunRecoilMod.horizontal = 1
		ModTable.gunRecoilMod.damping = 1
		ModTable.gunRecoilMod.speed = 1
		ModTable.gunRecoilMod.punchMultiplier = 1
		ModTable.damage.Head = 1
		ModTable.damage.Torso = 1
		ModTable.damage.Other = 1
		ModTable.fireRate = 1
		ModTable.muzzleChance = nil
		ModTable.muzzleVelocity = nil
		ModTable.bulletForce = nil
		ModTable.spread = 1
		ModTable.shotgun = nil
		ModTable.shotgunPellets = nil
		ModTable.ammoType = nil
		ModTable.tracers = nil
		ModTable.tracerTiming = nil
		ModTable.tracerColor = nil
		ModTable.magazineCapacity = nil
		ModTable.startAmmoPool = nil
		ModTable.maxAmmoPool = nil
		ModTable.reloadSpeedModifier = 1
		ModTable.armorPenMultiplier = 1
	end
	function setMods(p1, p2) --[[ setMods | Line: 219 | Upvalues: ModTable (copy) ]]
		ModTable.aimFovMinMod = ModTable.aimFovMinMod * p1.aimFovMinMod
		ModTable.AimTimeMod = ModTable.AimTimeMod * p1.AimTimeMod
		ModTable.gunLengthMod = ModTable.gunLengthMod + p1.gunLength

		if p1.IsSuppressor then
			ModTable.IsSuppressor = p1.IsSuppressor
		end

		if p1.EnableLaser then
			ModTable.EnableLaserAtt = p1.EnableLaser
			ModTable.laserAtt = p2
		end

		if p1.EnableFlashlight then
			ModTable.EnableFlashlightAtt = p1.EnableFlashlight
			ModTable.flashlightAtt = p2
		end

		if p1.IsBipod then
			ModTable.bipodAtt = p2
		end

		if p1.isRangefinder then
			ModTable.isRangefinder = p1.isRangefinder
		end

		ModTable.recoilMod.vertical = ModTable.recoilMod.vertical * p1.recoil.vertical
		ModTable.recoilMod.horizontal = ModTable.recoilMod.horizontal * p1.recoil.horizontal
		ModTable.recoilMod.camShake = ModTable.recoilMod.camShake * p1.recoil.camShake
		ModTable.recoilMod.damping = ModTable.recoilMod.damping * p1.recoil.damping
		ModTable.recoilMod.speed = ModTable.recoilMod.speed * p1.recoil.speed
		ModTable.recoilMod.aimReduction = ModTable.recoilMod.aimReduction * p1.recoil.aimReduction
		ModTable.gunRecoilMod.vertical = ModTable.gunRecoilMod.vertical * p1.gunRecoil.vertical
		ModTable.gunRecoilMod.horizontal = ModTable.gunRecoilMod.horizontal * p1.gunRecoil.horizontal
		ModTable.gunRecoilMod.damping = ModTable.gunRecoilMod.damping * p1.gunRecoil.damping
		ModTable.gunRecoilMod.speed = ModTable.gunRecoilMod.speed * p1.gunRecoil.speed
		ModTable.gunRecoilMod.punchMultiplier = ModTable.gunRecoilMod.punchMultiplier * p1.gunRecoil.punchMultiplier
		ModTable.damage.Head = ModTable.damage.Head * p1.damage.Head
		ModTable.damage.Torso = ModTable.damage.Torso * p1.damage.Torso
		ModTable.damage.Other = ModTable.damage.Other * p1.damage.Other
		ModTable.spread = ModTable.spread * p1.spread
		ModTable.fireRate = ModTable.fireRate * p1.fireRate

		if p1.muzzleChance then
			ModTable.muzzleChance = p1.muzzleChance
		end

		if p1.muzzleVelocity then
			ModTable.muzzleVelocity = p1.muzzleVelocity
		end

		if p1.bulletForce then
			ModTable.bulletForce = p1.bulletForce
		end

		if p1.shotgun then
			ModTable.shotgun = p1.shotgun
		end

		if p1.shotgunPellets then
			ModTable.shotgunPellets = p1.shotgunPellets
		end

		if p1.ammoType then
			ModTable.ammoType = p1.ammoType
		end

		if p1.tracers then
			ModTable.tracers = p1.tracers
		end

		if p1.tracerTiming then
			ModTable.tracerTiming = p1.tracerTiming
		end

		if p1.tracerColor then
			ModTable.tracerColor = p1.tracerColor
		end

		if p1.magazineCapacity then
			ModTable.magazineCapacity = p1.magazineCapacity
		end

		if p1.startAmmoPool then
			ModTable.startAmmoPool = p1.startAmmoPool
		end

		if p1.maxAmmoPool then
			ModTable.maxAmmoPool = p1.maxAmmoPool
		end

		if p1.armorPenMultiplier then
			ModTable.armorPenMultiplier = ModTable.armorPenMultiplier * p1.armorPenMultiplier
		end

		ModTable.reloadSpeedModifier = ModTable.reloadSpeedModifier * p1.reloadSpeedModifier
	end
	v55 = false
	v56 = false
	v57 = false
	t2 = { v1 }
	v58 = CFrame.new()
	FiringBlur = Instance.new("BlurEffect")
	FiringBlur.Enabled = false
	FiringBlur.Size = 0
	FiringBlur.Name = "FiringBlur"
	FiringBlur.Parent = game:GetService("Lighting")
	v59 = nil
	v60 = 0
	v61 = nil
	v62 = nil
	v63 = nil
	v64 = nil
	v65 = nil
	v66 = nil
	v67 = nil
	v68 = nil
	v69 = nil
	v70 = nil
	v71 = nil
	v72 = nil
	v73 = CFrame.new()
	v74 = CFrame.new()
	v75 = CFrame.new()
	v76 = CFrame.new()
	FieldOfView2 = CurrentCamera.FieldOfView
	v77 = 0
	v78 = 0
	zero = Vector2.zero
	v79 = CFrame.new(1000000, 0, 0)
	v80 = 0
	v81 = Humanoid.Animator:LoadAnimation(SPH_Assets.Animations.Crouch_Idle)
	v81.Looped = true
	v81.Priority = Enum.AnimationPriority.Idle
	v82 = Humanoid.Animator:LoadAnimation(SPH_Assets.Animations.Crouch_Move)
	v82.Looped = true
	v82.Priority = Enum.AnimationPriority.Movement
	v83 = Humanoid.Animator:LoadAnimation(SPH_Assets.Animations.Prone_Idle)
	v83.Looped = true
	v83.Priority = Enum.AnimationPriority.Idle
	v84 = Humanoid.Animator:LoadAnimation(SPH_Assets.Animations.Prone_Move)
	v84.Looped = true
	v84.Priority = Enum.AnimationPriority.Movement
	v85 = nil
	t3 = {}
	v86 = Vector3.new(0, 0, 0)
	CameraMode = LocalPlayer.CameraMode
	t4 = {}
	v87 = 1
	v88 = 0
	v89 = 0
	v90 = LocalPlayer:GetAttribute("SavedAimSensitivity") or GameConfig.defaultAimSensitivity
	v91 = 0
	v92 = 0
	v93 = SPH_Assets.HUD.LaserDotUI:Clone()
	Attachment = Instance.new("Attachment")
	Attachment.Parent = workspace.Terrain
	v93.Enabled = false
	v93.Parent = Attachment

	local Attachment2 = Instance.new("Attachment")

	Attachment2.Position = Vector3.new(0, 0.1, 0)
	Attachment2.Parent = Attachment

	local Attachment3 = Instance.new("Attachment")

	Attachment3.Position = Vector3.new(0, -0.1, 0)
	Attachment3.Parent = Attachment
	Trail = Instance.new("Trail")
	Trail.Attachment0 = Attachment2
	Trail.Attachment1 = Attachment3
	Trail.FaceCamera = true
	Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.5), NumberSequenceKeypoint.new(1, 0.5) })
	Trail.Parent = Attachment
	Trail.Lifetime = 0.1
	Trail.WidthScale = NumberSequence.new(2)
	Trail.LightEmission = 0.5
	Trail.LightInfluence = 0.5
	Trail.Texture = "rbxassetid://5367817750"
	Trail.Enabled = false
	FirstPersonLaser = Instance.new("Beam")
	FirstPersonLaser.Attachment1 = Attachment
	FirstPersonLaser.LightInfluence = 0
	FirstPersonLaser.Brightness = 3
	FirstPersonLaser.Segments = 1
	FirstPersonLaser.Width0 = 0.02
	FirstPersonLaser.Width1 = 0.02
	FirstPersonLaser.FaceCamera = true
	FirstPersonLaser.Transparency = NumberSequence.new(0.5)
	FirstPersonLaser.Name = "FirstPersonLaser"
	FirstPersonLaser.Parent = Attachment
	FirstPersonLaser.Enabled = false
	ThirdPersonLaser = FirstPersonLaser:Clone()
	ThirdPersonLaser.Name = "ThirdPersonLaser"
	ThirdPersonLaser.Parent = Attachment
	ThirdPersonLaser.Enabled = false

	if HumanoidRootPart:FindFirstChild("Died") then
		HumanoidRootPart.Died.Volume = 0
	end

	if GameConfig.lockFirstPerson then
		LocalPlayer.CameraMode = Enum.CameraMode.Classic
	end

	rig = ViewMod.RigModel(LocalPlayer)

	local v94 = rig["Left Arm"]
	local v95 = rig["Right Arm"]

	v94.Color = v1["Left Arm"].Color
	v95.Color = v1["Right Arm"].Color

	for i, v in ipairs(rig:GetDescendants()) do
		if v.Name == "Skin" then
			if v.Parent.Name == "Left Arm" then
				v.Color = v1["Left Arm"].Color

				continue
			end

			if v.Parent.Name == "Right Arm" then
				v.Color = v1["Right Arm"].Color
			end
		end
	end

	local CrosshairGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("CrosshairGui")

	v96 = nil

	local DynamicCrosshair = require(game.ReplicatedStorage.DynamicCrosshair)

	BuildCursor = function(p1) --[[ BuildCursor | Line: 436 | Upvalues: v96 (ref), DynamicCrosshair (copy), CrosshairGui (copy), v5 (copy) ]]
		print("BUILDING CURSOR")
		v96 = DynamicCrosshair.New(CrosshairGui, 20, 60, 40, 30, false)
		v96:Size(7, 2)
		v96:Display({
			BackgroundTransparency = 0.4,
			Image = nil,
			ImageTransparency = 0,
			BackgroundColor3 = Color3.new(0.729412, 0.729412, 0.729412)
		})
		v96:Enable()

		if not p1 then
			return
		end

		v96:UseMuzzleAttach(p1, 600, v5)
	end

	local function DestroyCursor() --[[ DestroyCursor | Line: 452 | Upvalues: v96 (ref) ]]
		if not v96 then
			return
		end

		v96:Destroy()
		v96 = nil
	end

	local Humanoid2 = Instance.new("Humanoid", rig)

	for i, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
		if v ~= Enum.HumanoidStateType.None then
			Humanoid2:SetStateEnabled(v, false)
		end
	end

	Animator = Instance.new("Animator", Humanoid2)

	local Shirt = Instance.new("Shirt", rig)

	AnimBase = rig.AnimBase
	AnimBase.CFrame = v79
	rig.Parent = CurrentCamera
	v97 = v1:FindFirstChild("WeaponRig") or v1:WaitForChild("WeaponRig")
	Animator2 = v97:WaitForChild("AnimationController").Animator
	function loadAttachment(p1) --[[ loadAttachment | Line: 478 | Upvalues: v62 (ref), v45 (ref), AttModules (copy), v50 (ref), AttModels (copy), FieldOfView2 (ref), FieldOfView (copy), WeldMod (copy), v46 (ref), v51 (ref), v47 (ref), v52 (ref), v48 (ref), v53 (ref), v49 (ref), v54 (ref) ]]
		if p1 == nil then
			return
		end

		if v62.SightAtt and (p1:FindFirstChild("Node_Sight") ~= nil and (v62.SightAtt and v62.SightAtt ~= "")) then
			v45 = require(AttModules[v62.SightAtt])
			v50 = AttModels[v62.SightAtt]:Clone()
			v50.Parent = p1
			v50:SetPrimaryPartCFrame(p1.Node_Sight.CFrame)

			if v50:FindFirstChild("AimPos2") then
				if p1:FindFirstChild("AimPart2") then
					p1.AimPart2.CFrame = v50.AimPos2.CFrame
				else
					local AimPart2 = p1.AimPart:Clone()

					AimPart2.Parent = p1
					AimPart2.Name = "AimPart2"
					AimPart2.CFrame = v50.AimPos2.CFrame
				end
			end

			if v45.maxFOV then
				print(FieldOfView2)

				if FieldOfView2 == v62.maxFOV or FieldOfView then
					FieldOfView2 = v45.maxFOV
				end
			end

			if v45.ADSEnabled then
				v62.ADSEnabled = v45.ADSEnabled
			end

			setMods(v45, v62.SightAtt)

			for k, v in pairs(p1:GetChildren()) do
				if v.Name == "IS" then
					v.Transparency = 1
				end

				if v.Name == "ISF" then
					v.Transparency = 0
				end

				if v.Name == "RailMount" then
					v.Transparency = 0
				end
			end

			local Grip_AimPart = p1:WaitForChild("Grip"):FindFirstChild("Grip_AimPart")

			if Grip_AimPart then
				Grip_AimPart:Destroy()
			end

			p1.AimPart.CFrame = v50.AimPos.CFrame
			WeldMod.Weld(p1.AimPart, p1.Node_Sight)
			WeldMod.WeldModel(v50, p1.Node_Sight, false)
		end

		if v62.BarrelAtt and (p1:FindFirstChild("Node_Barrel") ~= nil and v62.BarrelAtt ~= "") then
			v46 = require(AttModules[v62.BarrelAtt])
			v51 = AttModels[v62.BarrelAtt]:Clone()
			v51.Parent = p1
			v51:SetPrimaryPartCFrame(p1.Node_Barrel.CFrame)

			if v51:FindFirstChild("BarrelPos") ~= nil then
				p1.Grip.Muzzle.WorldCFrame = v51.BarrelPos.CFrame
			end

			setMods(v46, v62.BarrelAtt)
			WeldMod.WeldModel(v51, p1.Node_Barrel, false)
		end

		if v62.UnderBarrelAtt and (p1:FindFirstChild("Node_UnderBarrel") ~= nil and v62.UnderBarrelAtt ~= "") then
			v47 = require(AttModules[v62.UnderBarrelAtt])
			v52 = AttModels[v62.UnderBarrelAtt]:Clone()
			v52.Parent = p1
			v52:SetPrimaryPartCFrame(p1.Node_UnderBarrel.CFrame)
			setMods(v47, v62.UnderBarrelAtt)
			WeldMod.WeldModel(v52, p1.Node_UnderBarrel, false)
		end

		if v62.OtherAtt and (p1:FindFirstChild("Node_Other") ~= nil and v62.OtherAtt ~= "") then
			v48 = require(AttModules[v62.OtherAtt])
			v53 = AttModels[v62.OtherAtt]:Clone()
			v53.Parent = p1
			v53:SetPrimaryPartCFrame(p1.Node_Other.CFrame)
			setMods(v48, v62.OtherAtt)
			WeldMod.WeldModel(v53, p1.Node_Other, false)
		end

		if not v62.AmmoAtt or (p1:FindFirstChild("Node_Ammo") == nil or v62.AmmoAtt == "") then
			return
		end

		v49 = require(AttModules[v62.AmmoAtt])
		setMods(v49, v62.AmmoAtt)

		if not v49.ReplaceMag then
			return
		end

		WeldMod.Weld(p1.Mag, p1.Node_Ammo)
		p1.Mag.Transparency = 1
		v54 = AttModels[v62.AmmoAtt]:Clone()
		v54.Parent = p1
		v54:SetPrimaryPartCFrame(p1.Node_Ammo.CFrame)
		WeldMod.WeldModel(v54, p1.Node_Ammo, false)
		WeldMod.Weld(p1.Node_Ammo, p1.Mag, false)

		local Grip_Node_Ammo = p1:WaitForChild("Grip"):FindFirstChild("Grip_Node_Ammo")

		if not Grip_Node_Ammo then
			return
		end

		Grip_Node_Ammo:Destroy()
	end
	PlayRepSound = function(p1) --[[ PlayRepSound | Line: 635 | Upvalues: v31 (ref), v64 (ref), v61 (ref), v29 (ref), HumanoidRootPart (copy), Debris (copy), v13 (copy) ]]
		if v31 then
			return
		end

		local v1 = v64.Grip:FindFirstChild(p1)

		if not (v1 and v61) then
			return
		end

		if v29 then
			v1:Play()
		else
			local v2 = v1:Clone()

			v2.Parent = HumanoidRootPart
			v2:Play()
			Debris:AddItem(v2, v2.TimeLength)
		end

		v13:Fire(p1, v29)
	end

	local function IsLoaded() --[[ IsLoaded | Line: 652 | Upvalues: v62 (ref), v61 (ref), v65 (ref) ]]
		return not v62.openBolt and v61.Chambered.Value or v62.openBolt and v65.MagAmmo.Value > 0
	end

	PlayCharSound = function(p1) --[[ PlayCharSound | Line: 656 | Upvalues: SPH_Assets (copy), HumanoidRootPart (copy), Debris (copy), v18 (copy) ]]
		local v1 = SPH_Assets.Sounds:FindFirstChild(p1)

		if not v1 then
			return
		end

		local v2 = v1:GetChildren()
		local v3 = v2[math.random(#v2)]:Clone()

		v3.Parent = HumanoidRootPart
		v3:Play()
		Debris:AddItem(v3, v3.TimeLength)
		v18:Fire(p1)
	end

	local function ChangeLean(p1) --[[ ChangeLean | Line: 668 | Upvalues: GameConfig (copy), v88 (ref), PlayCharSound (copy), v23 (copy) ]]
		if not GameConfig.canLean then
			return
		end

		if p1 ~= v88 then
			PlayCharSound("Lean")
		end

		v88 = p1
		v23:Fire(p1)
	end

	MoveBolt = function(p1, p2) --[[ MoveBolt | Line: 675 | Upvalues: v64 (ref), BulletHandler (copy), v62 (ref), v65 (ref), v97 (copy), PlayRepSound (copy), v16 (copy) ]]
		local v1 = v64 and v64:GetAttribute("VMScale") or 1

		BulletHandler.MoveBolt(v64, v62, if v1 == 1 then p1 elseif typeof(p1) == "CFrame" then p1.Rotation + p1.Position * v1 else p1 * v1, v65.MagAmmo.Value)
		BulletHandler.MoveBolt(v97.Weapon:FindFirstChildWhichIsA("Model"), v62, p1, v65.MagAmmo.Value)

		if v65.MagAmmo.Value <= 0 and not p2 then
			PlayRepSound("Empty")
		end

		v16:Fire(p1, v65.MagAmmo.Value)
	end
	ToggleADS = function(p1) --[[ ToggleADS | Line: 702 | Upvalues: v62 (ref), ModTable (copy), v64 (ref), TweenService (copy), v50 (ref) ]]
		if not (v62 and v62.ADSEnabled) then
			return
		end

		local aimTime = v62.aimTime
		local v1

		if aimTime then
			if ModTable.AimTimeMod then
				aimTime = ModTable.AimTimeMod
			end

			v1 = TweenInfo.new(aimTime / 20, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, aimTime / 20)
		else
			v1 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.2)
		end

		if p1 then
			if not p1 then
				return
			end

			for k, v in pairs(v64:GetChildren()) do
				if v.Name == "REG" then
					TweenService:Create(v, v1, {
						Transparency = 1
					}):Play()

					continue
				end

				if v.Name == "ADS" then
					TweenService:Create(v, v1, {
						Transparency = 0
					}):Play()
				end
			end

			if not v50 then
				return
			end

			for k, v in pairs(v64[v50.Name]:GetChildren()) do
				if v.Name == "REG" then
					TweenService:Create(v, v1, {
						Transparency = 1
					}):Play()

					continue
				end

				if v.Name == "ADS" then
					TweenService:Create(v, v1, {
						Transparency = 0
					}):Play()
				end
			end
		else
			for k, v in pairs(v64:GetChildren()) do
				if v.Name == "REG" then
					TweenService:Create(v, v1, {
						Transparency = 0
					}):Play()

					continue
				end

				if v.Name == "ADS" then
					TweenService:Create(v, v1, {
						Transparency = 1
					}):Play()
				end
			end

			if not v50 then
				return
			end

			for k, v in pairs(v64[v50.Name]:GetChildren()) do
				if v.Name == "REG" then
					TweenService:Create(v, v1, {
						Transparency = 0
					}):Play()

					continue
				end

				if v.Name == "ADS" then
					TweenService:Create(v, v1, {
						Transparency = 1
					}):Play()
				end
			end
		end
	end

	local function EjectShell() --[[ EjectShell | Line: 757 | Upvalues: v40 (ref), v62 (ref), v29 (ref), ShellEjection (copy), LocalPlayer (copy), v61 (ref), v64 (ref), v97 (copy) ]]
		v40 = true

		if not v62.shellEject then
			return
		end

		if v29 then
			ShellEjection.ejectShell(LocalPlayer, v61, v64)

			return
		end

		ShellEjection.ejectShell(LocalPlayer, v61, v97.Weapon:FindFirstChildWhichIsA("Model"))
	end

	local function GetThirdPersonGunModel() --[[ GetThirdPersonGunModel | Line: 768 | Upvalues: v97 (copy) ]]
		return v97.Weapon:FindFirstChildWhichIsA("Model")
	end

	local function StopAnimation(p1, p2) --[[ StopAnimation | Line: 773 | Upvalues: t3 (copy) ]]
		if not t3[p1] then
			return
		end

		if p2 then
			t3[p1]:Stop(p2)
			t3[p1 .. "ThirdPerson"]:Stop(p2)
		else
			t3[p1]:Stop()
			t3[p1 .. "ThirdPerson"]:Stop()
		end
	end

	local function SwitchFireMode() --[[ SwitchFireMode | Line: 787 | Upvalues: v59 (ref), v62 (ref), v17 (copy) ]]
		repeat
			v59 = v59 + 1

			if v59 > 4 then
				v59 = 0

				break
			end
		until v62.fireSwitch[v59]

		v17:Fire(v59)
	end

	v98 = function(p1, p2, p3, p4) --[[ PlayAnimation | Line: 796 | Upvalues: t3 (copy), Animations (copy), Animator (copy), Animator2 (copy), v66 (ref), v1 (copy), v64 (ref), PlayRepSound (copy), v61 (ref), v62 (ref), v98 (copy), v14 (copy), ModTable (copy), v41 (ref), v65 (ref), v72 (ref), v15 (copy), MoveBolt (copy), v40 (ref), v29 (ref), ShellEjection (copy), LocalPlayer (copy), v97 (copy), v59 (ref), v17 (copy), v22 (copy), v21 (copy) ]]
		local v12 = if p2 then p2 else {}
		local v2 = nil
		local v3 = nil
		local v4

		if t3[p1] then
			v2 = t3[p1]
			v3 = t3[p1 .. "ThirdPerson"]
			v4 = v12
		elseif p1 and Animations:FindFirstChild(p1) then
			local v5 = Animator:LoadAnimation(Animations[p1])

			v5.Looped = v12.looped or false
			v5.Priority = v12.priority or Enum.AnimationPriority.Action
			t3[p1] = v5

			local v7 = Animator2:LoadAnimation(Animations[p1])

			v7.Looped = v12.looped or false
			v7.Priority = v12.priority or Enum.AnimationPriority.Action
			t3[p1 .. "ThirdPerson"] = v7
			v5.KeyframeReached:Connect(function(p12) --[[ Line: 814 | Upvalues: v66 (ref), v1 (ref), v64 (ref), PlayRepSound (ref), v61 (ref), v62 (ref), p1 (copy), t3 (ref), v98 (ref), v14 (ref), ModTable (ref), v5 (copy), v41 (ref), v65 (ref), v72 (ref), v15 (ref), MoveBolt (ref), v40 (ref), v29 (ref), ShellEjection (ref), LocalPlayer (ref), v97 (ref), v59 (ref), v17 (ref), v22 (ref), v21 (ref) ]]
				local v12 = v66

				if not v12 then
					local v2 = v1:GetAttribute("_ReloadingUntil")

					v12 = if type(v2) == "number" then os.clock() < v2 else false
				end

				if not v12 and (p12 == "MagIn" or (p12 == "ShellInsert" or (p12 == "BulletInsert" or (p12 == "ClipInsert" or p12 == "ClipInsertEnd")))) then
					return
				end

				if v64.Grip:FindFirstChild(p12) then
					PlayRepSound(p12)
				end

				if p12 == "MagIn" then
					if v61 and (v62.openBolt or not v61.Chambered.Value) and v62.autoChamber then
						v66 = true

						local v4 = if v61.BoltReady.Value then v62.boltChamber else v62.boltClose
						local v52 = p1

						if t3[v52] then
							t3[v52]:Stop(0.4)
							t3[v52 .. "ThirdPerson"]:Stop(0.4)
						end

						v98(v4, {
							transSpeed = 0.05,
							priority = Enum.AnimationPriority.Action2
						})
					end

					local v6 = v62.bulletHandler and v64:FindFirstChild(v62.bulletHolder)

					if v6 then
						for v7, v8 in v6:GetChildren() do
							if v8:IsA("BasePart") and string.sub(v8.Name, 1, 6) == "Bullet" then
								v8.Transparency = 0
							end
						end
					end

					v14:Fire(ModTable)

					if v62.magType > 1 then
						v5.DidLoop:Once(function() --[[ Line: 878 | Upvalues: p1 (ref), t3 (ref) ]]
							local v1 = p1

							if t3[v1] then
								t3[v1]:Stop()
								t3[v1 .. "ThirdPerson"]:Stop()
							end
						end)
					end
				else
					if p12 == "ShellInsert" or p12 == "BulletInsert" then
						if v41 then
							v41 = false
							v5.Looped = false
							v5.Stopped:Once(function() --[[ Line: 886 | Upvalues: v61 (ref), v5 (ref), t3 (ref), v62 (ref), v98 (ref), v66 (ref) ]]
								if not v61 then
									return
								end

								local v1 = v5.Name

								if t3[v1] then
									t3[v1]:Stop()
									t3[v1 .. "ThirdPerson"]:Stop()
								end

								if v61.BoltReady.Value and not v62.openBolt then
									v66 = false
								else
									v98(v62.boltClose, {
										priority = Enum.AnimationPriority.Action2
									})
								end
							end)
						elseif v65.MagAmmo.Value + 1 >= v65.MagAmmo.MaxValue or v72.Value - 1 <= 0 then
							v5.DidLoop:Once(function() --[[ Line: 896 | Upvalues: v61 (ref), v5 (ref), t3 (ref), v62 (ref), v98 (ref), v66 (ref) ]]
								if not v61 then
									return
								end

								local v1 = v5.Name

								if t3[v1] then
									t3[v1]:Stop()
									t3[v1 .. "ThirdPerson"]:Stop()
								end

								if v61.BoltReady.Value and (v62.operationType ~= 3 and not v62.openBolt) then
									v66 = false
								else
									v98(v62.boltClose, {
										priority = Enum.AnimationPriority.Action2
									})
								end
							end)
						else
							local openBolt = v62.openBolt
						end

						local v10 = v62.bulletHolder and v64:FindFirstChild(v62.bulletHolder)

						if not v10 then
							v14:Fire(ModTable)

							return
						end

						local v11 = v10:FindFirstChild("Bullet" .. v65.MagAmmo.MaxValue - v65.MagAmmo.Value)

						if not v11 then
							v14:Fire(ModTable)

							return
						end

						v11.Transparency = 0
						v14:Fire(ModTable)

						return
					end

					if p12 == "ClipInsertEnd" then
						local v122 = v65.MagAmmo.MaxValue - v65.MagAmmo.Value
						local v13 = v62.clipSize or v62.magazineCapacity

						if ModTable.magazineCapacity then
							v13 = v62.clipSize or ModTable.magazineCapacity
						end

						if not (v122 > 0) then
							return
						end

						local v152 = v5.Name

						if t3[v152] then
							t3[v152]:Stop()
							t3[v152 .. "ThirdPerson"]:Stop()
						end

						if v13 <= v122 then
							v98(v62.clipReloadAnim, {
								looped = true,
								transSpeed = 0.17,
								speed = v62.reloadSpeedModifier,
								priority = Enum.AnimationPriority.Action2
							})
						else
							v98(v62.reloadAnim, {
								transSpeed = 0.17,
								speed = v62.reloadSpeedModifier,
								priority = Enum.AnimationPriority.Action2
							}, "Reload")
						end

						return
					end

					if p12 == "ClipInsert" then
						v14:Fire(ModTable)

						return
					end

					if p12 == "SlideRelease" or p12 == "BoltClose" then
						v15:Fire()
						v66 = false
						v1:SetAttribute("_ReloadingUntil", 0)
						MoveBolt(CFrame.new(), true)

						if v61 then
							v61:SetAttribute("_AutoChamberPending", false)
						end
					else
						if p12 == "SlidePull" and v61.Chambered.Value then
							v40 = true

							if not v62.shellEject then
								return
							end

							if v29 then
								ShellEjection.ejectShell(LocalPlayer, v61, v64)
							else
								ShellEjection.ejectShell(LocalPlayer, v61, v97.Weapon:FindFirstChildWhichIsA("Model"))
							end

							return
						end

						if p12 == "Equip" then
							return
						end

						if p12 == "Switch" and not v66 then
							repeat
								v59 = v59 + 1

								if v59 > 4 then
									v59 = 0

									break
								end
							until v62.fireSwitch[v59]

							v17:Fire(v59)

							return
						end

						if p12 == "MagGrab" then
							if not v64 or (v62.projectile == "Bullet" or not v64:FindFirstChild(v62.projectile)) then
								return
							end

							local v16 = v64:FindFirstChild(v62.projectile)

							v16.LocalTransparencyModifier = 0

							for i, v in ipairs(v16:GetDescendants()) do
								if v:IsA("BasePart") then
									v.LocalTransparencyModifier = 0
								end
							end

							local v172 = v97.Weapon:FindFirstChildWhichIsA("Model"):FindFirstChild(v62.projectile)

							v172.LocalTransparencyModifier = 0

							for i, v in ipairs(v172:GetDescendants()) do
								if v:IsA("BasePart") then
									v.LocalTransparencyModifier = 0
								end
							end

							v22:Fire()

							return
						end

						if p12 ~= "BoltOpen" then
							return
						end

						v21:Fire()

						if v40 then
							return
						end

						v40 = true

						if not v62.shellEject then
							return
						end

						if v29 then
							ShellEjection.ejectShell(LocalPlayer, v61, v64)

							return
						end

						ShellEjection.ejectShell(LocalPlayer, v61, v97.Weapon:FindFirstChildWhichIsA("Model"))
					end
				end
			end)
			v5.Stopped:Connect(function() --[[ Line: 995 | Upvalues: p3 (copy), v66 (ref), v1 (ref), v61 (ref), v65 (ref), v62 (ref), v98 (ref), v64 (ref) ]]
				if p3 == "Equip" then
					return
				end

				if p3 ~= "Reload" then
					return
				end

				v66 = false
				v1:SetAttribute("_ReloadingUntil", 0)

				if v61 and (v61:GetAttribute("_AutoChamberPending") and (v61:FindFirstChild("BoltReady") and (not v61.BoltReady.Value and (v65 and (v65.MagAmmo and (v65.MagAmmo.Value > 0 and (v62 and (v62.boltClose and not v62.openBolt)))))))) then
					v61:SetAttribute("_AutoChamberPending", false)
					v98(v62.boltClose, {
						transSpeed = 0.05,
						priority = Enum.AnimationPriority.Action2
					})
				end

				if not (v62 and (v64 and (v64:FindFirstChild(v62.projectile) and v61.Chambered.Value))) then
					return
				end

				local v12 = v64:FindFirstChild(v62.projectile)

				v12.LocalTransparencyModifier = 0

				for i, v in ipairs(v12:GetDescendants()) do
					if v:IsA("BasePart") then
						v.LocalTransparencyModifier = 0
					end
				end
			end)
			v2 = v5
			v4 = v12
			v3 = v7
		else
			v4 = v12
		end

		if v2 and not p4 then
			v2:Play(v4.transSpeed or 0)
			v2:AdjustSpeed(v4.speed or 1)
			v3:Play(v4.transSpeed or 0)
			v3:AdjustSpeed(v4.speed or 1)
		end

		return v2
	end
	ChangeHoldStance = function(p1) --[[ ChangeHoldStance | Line: 1045 | Upvalues: v67 (ref), v35 (ref), v36 (ref), t3 (copy), v62 (ref), v98 (copy) ]]
		if v67 then
			return
		end

		if v35 == p1 and v36 then
			local v1 = v36.Name

			if t3[v1] then
				t3[v1]:Stop(0.3)
				t3[v1 .. "ThirdPerson"]:Stop(0.3)
			end

			v36 = nil
			v35 = 0
		else
			v35 = p1

			if v36 then
				local v2 = v36.Name

				if t3[v2] then
					t3[v2]:Stop(0.3)
					t3[v2 .. "ThirdPerson"]:Stop(0.3)
				end
			end

			local v3 = nil

			if p1 == 1 and v62.holdUpAnim then
				v3 = v62.holdUpAnim
			elseif p1 == 2 and v62.patrolAnim then
				v3 = v62.patrolAnim
			elseif p1 == 3 and v62.holdDownAnim then
				v3 = v62.holdDownAnim
			end

			if v3 then
				v36 = v98(v3, {
					looped = true,
					transSpeed = 0.3,
					priority = Enum.AnimationPriority.Action
				})
				v36:Play()

				return
			end

			if not v36 then
				return
			end

			v36 = nil
		end
	end
	ChamberAnim = function() --[[ ChamberAnim | Line: 1076 | Upvalues: v61 (ref), v59 (ref), v62 (ref), v66 (ref), v42 (ref), ChangeHoldStance (copy), v98 (copy), v1 (copy) ]]
		local v12 = if v61.BoltReady.Value or v59 == 4 then v62.boltChamber else v62.boltClose

		if not v12 then
			return
		end

		v66 = true
		v42 = true
		ChangeHoldStance(0)
		v98(v12, {
			transSpeed = 0.05,
			priority = Enum.AnimationPriority.Action2
		}).Stopped:Once(function() --[[ Line: 1090 | Upvalues: v42 (ref), v66 (ref), v1 (ref) ]]
			v42 = false
			v66 = false
			v1:SetAttribute("_ReloadingUntil", 0)
		end)
	end

	local function IdleAnim() --[[ IdleAnim | Line: 1105 | Upvalues: v98 (copy), v62 (ref) ]]
		v98(v62.idleAnim, {
			looped = true,
			priority = Enum.AnimationPriority.Idle
		})
	end

	EquipAnim = function() --[[ EquipAnim | Line: 1109 | Upvalues: v98 (copy), v62 (ref), v29 (ref), v33 (ref), v64 (ref), v61 (ref) ]]
		v98(v62.equipAnim, {
			priority = Enum.AnimationPriority.Action2
		}, "Equip")
		task.wait(0.1)

		if v29 then
			v33 = true
		end

		local v1 = v64:FindFirstChild(v62.projectile)

		if not v62.openBolt and v61.Chambered.Value or (not v1 or v62.projectile == "Bullet") then
			return
		end

		v1.LocalTransparencyModifier = 1

		for i, v in ipairs(v1:GetDescendants()) do
			if v:IsA("BasePart") then
				v.LocalTransparencyModifier = 1
			end
		end
	end
	ReloadAnim = function() --[[ ReloadAnim | Line: 1127 | Upvalues: v61 (ref), v41 (ref), v66 (ref), v1 (copy), GameConfig (copy), v62 (ref), t3 (copy), ChangeHoldStance (copy), v65 (ref), v98 (copy), v72 (ref), ModTable (copy) ]]
		if not v61 then
			return
		end

		v41 = false
		v66 = true
		v1:SetAttribute("_ReloadingUntil", os.clock() + GameConfig.reloadLockSeconds)

		if v62 then
			if v62.equipAnim then
				local equipAnim = v62.equipAnim

				if t3[equipAnim] then
					t3[equipAnim]:Stop(0.1)
					t3[equipAnim .. "ThirdPerson"]:Stop(0.1)
				end
			end

			if v62.boltChamber then
				local boltChamber = v62.boltChamber

				if t3[boltChamber] then
					t3[boltChamber]:Stop(0.1)
					t3[boltChamber .. "ThirdPerson"]:Stop(0.1)
				end
			end

			if v62.boltClose then
				local boltClose = v62.boltClose

				if t3[boltClose] then
					t3[boltClose]:Stop(0.1)
					t3[boltClose .. "ThirdPerson"]:Stop(0.1)
				end
			end
		end

		ChangeHoldStance(0)

		if v61:FindFirstChild("BoltReady") and not v61.BoltReady.Value then
			v61:SetAttribute("_AutoChamberPending", true)
		end

		if v62.operationType == 3 or v62.operationType == 2 and (v65.MagAmmo.Value <= 0 and not v61.Chambered.Value) then
			local v12 = v98(v62.boltOpen, {
				transSpeed = 0.17,
				speed = v62.reloadSpeedModifier,
				priority = Enum.AnimationPriority.Action2
			})

			if v12 then
				v12.Stopped:Once(function() --[[ Line: 1198 | Upvalues: v62 (ref), v65 (ref), v72 (ref), ModTable (ref), v98 (ref) ]]
					if v62.magType == 3 and ((v62.clipSize or v62.magazineCapacity) <= v65.MagAmmo.MaxValue - v65.MagAmmo.Value and (v62.clipSize or v62.magazineCapacity) <= v72.Value) then
						if not ModTable.magazineCapacity then
							v98(v62.clipReloadAnim, {
								looped = true,
								transSpeed = 0.17,
								speed = v62.reloadSpeedModifier,
								priority = Enum.AnimationPriority.Action2
							})

							return
						end

						if (v62.clipSize or ModTable.magazineCapacity) <= v72.Value then
							v98(v62.clipReloadAnim, {
								looped = true,
								transSpeed = 0.17,
								speed = ModTable.reloadSpeedModifier,
								priority = Enum.AnimationPriority.Action2
							})
						end

						return
					end

					local v7 = v98(v62.reloadAnim, {
						transSpeed = 0.17,
						looped = true,
						speed = v62.reloadSpeedModifier,
						priority = Enum.AnimationPriority.Action2
					}, "Reload")

					if not (v62.magType > 1) then
						return
					end

					v7.Looped = true
				end)
			else
				warn("\227\128\144 SPEARHEAD \227\128\145 " .. "To use operation type " .. v62.operationType .. ", a \'boltOpen\' animation is required.")
				v66 = false
			end
		else
			local v2 = v98(v62.reloadAnim, {
				transSpeed = 0.17,
				speed = v62.reloadSpeedModifier,
				priority = Enum.AnimationPriority.Action2
			}, "Reload")

			if not (v2 and v62.magType > 1) then
				return
			end

			v2.Looped = true
		end
	end
	RefreshViewmodel = function() --[[ RefreshViewmodel | Line: 1258 | Upvalues: v29 (ref), v30 (ref), v33 (ref), v1 (copy), Shirt (copy), v94 (copy), v95 (copy), v98 (copy), v62 (ref), Mods (copy), LocalPlayer (copy) ]]
		if v29 and not v30 then
			v33 = true
		end

		local v12 = v1:FindFirstChildWhichIsA("Shirt")

		if v12 then
			Shirt.ShirtTemplate = v12.ShirtTemplate
		end

		v94.Color = v1["Left Arm"].Color
		v95.Color = v1["Right Arm"].Color

		for i, v in ipairs(rig:GetDescendants()) do
			if v.Name == "Skin" then
				if v.Parent.Name == "Left Arm" then
					v.Color = v1["Left Arm"].Color

					continue
				end

				if v.Parent.Name == "Right Arm" then
					v.Color = v1["Right Arm"].Color
				end
			end
		end

		v98(v62.idleAnim, {
			looped = true,
			priority = Enum.AnimationPriority.Idle
		})

		if not Mods.onViewmodelRefresh then
			return
		end

		Mods.onViewmodelRefresh(LocalPlayer, rig)
	end

	local function ResetHead() --[[ ResetHead | Line: 1285 | Upvalues: v33 (ref) ]]
		v33 = false
	end

	local function GetSineOffset(p1) --[[ GetSineOffset | Line: 1289 ]]
		return math.sin(tick() * p1 * 1.3) * 0.3
	end

	local function LerpNumber(p1, p2, p3) --[[ LerpNumber | Line: 1293 ]]
		return p1 + (p2 - p1) * p3
	end
end

local v99 = nil
local v100 = false

local function v101(p1) --[[ ToggleAiming | Line: 1299 | Upvalues: v99 (ref), v67 (ref), v100 (ref), UserInputService (copy), v101 (copy), v1 (copy), ChangeHoldStance (copy), v96 (ref), v62 (ref), v87 (ref), ToggleADS (copy), v90 (ref), PlayRepSound (copy), GameConfig (copy), LocalPlayer (copy), v92 (ref), v6 (copy), ModTable (copy), TweenService (copy), CurrentCamera (copy), FieldOfView (copy), CameraMode (copy) ]]
	if p1 then
		if v99 then
			task.cancel(v99)
			v99 = nil
		end

		if v67 then
			return
		end
	elseif not v100 then
		if not v99 then
			v99 = task.delay(0.05, function() --[[ Line: 1311 | Upvalues: v99 (ref), UserInputService (ref), v67 (ref), v100 (ref), v101 (ref) ]]
				v99 = nil

				if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
					return
				end

				if v67 then
					v100 = true
					v101(false)
					v100 = false
				end
			end)
		end

		return
	end

	v1:SetAttribute("Aiming", p1)

	if p1 then
		ChangeHoldStance(0)
		v67 = true

		if v96 then
			v96:ToggleVisible(false)
		end

		if v62.ADSEnabled and v62.ADSEnabled[v87] then
			ToggleADS(true)
		else
			ToggleADS(false)
		end

		UserInputService.MouseDeltaSensitivity = v90
		PlayRepSound("AimUp")

		if not GameConfig.lockFirstPerson then
			LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
		end

		if GameConfig.proceduralAimAnim then
			v92 = 13
			task.delay(0.1, function() --[[ Line: 1346 | Upvalues: v67 (ref), p1 (copy), v92 (ref) ]]
				if v67 ~= p1 then
					return
				end

				v92 = 0
			end)
			v6:shove(Vector3.new(0, -1, 0))
		end
	else
		v67 = false

		if v96 then
			v96:ToggleVisible(true)
		end

		ToggleADS(false)
		UserInputService.MouseDeltaSensitivity = 1
		PlayRepSound("AimDown")

		local v12

		if v62 then
			v12 = v62.aimTime / 2

			if ModTable.AimTimeMod then
				v12 = ModTable.AimTimeMod / 2
			end
		else
			v12 = 0.3
		end

		TweenService:Create(CurrentCamera, TweenInfo.new(v12), {
			FieldOfView = FieldOfView
		}):Play()

		if not GameConfig.lockFirstPerson then
			LocalPlayer.CameraMode = CameraMode
		end

		if not GameConfig.proceduralAimAnim then
			return
		end

		v92 = 10
		task.delay(0.1, function() --[[ Line: 1379 | Upvalues: v67 (ref), p1 (copy), v92 (ref) ]]
			if v67 ~= p1 then
				return
			end

			v92 = 0
		end)
		v6:shove(Vector3.new(0, -1, 0))
	end
end

local t5 = {
	fps = 0,
	accum = 0,
	bobAccum = 0,
	rattle = 0,
	lowReady = 0,
	lastActive = 0,
	prevFX = CFrame.new(),
	currFX = CFrame.new(),
	camRecoil = CFrame.new(),
	smoothRot = CFrame.new(),
	bobFX = CFrame.new()
}

local function UpdateViewmodelPosition(p1) --[[ UpdateViewmodelPosition | Line: 1406 | Upvalues: t5 (copy), AnimBase (copy), CurrentCamera (copy), v68 (ref), v57 (ref), v58 (ref), v69 (ref), v74 (ref), v80 (ref), v91 (ref), v73 (ref), v64 (ref), v87 (ref), v76 (ref), v62 (ref), ModTable (copy), v67 (ref), v75 (ref), v1 (copy), v29 (ref), v97 (copy), v5 (copy), GameConfig (copy), v34 (ref), v78 (ref), v27 (ref), ChangeHoldStance (copy), v98 (copy), v101 (copy), t3 (copy), v44 (ref), v63 (ref), HumanoidRootPart (copy), v24 (ref), UserInputService (copy), zero (ref), v6 (copy), v9 (copy), v8 (copy), v33 (ref), v79 (copy) ]]
	t5.fps = 1 / p1
	AnimBase.CFrame = CFrame.new((CurrentCamera.CFrame * v68).Position)

	if v57 then
		local v12 = AnimBase

		v12.CFrame = v12.CFrame * v58
	end

	if v69 then
		local v2 = AnimBase

		v2.CFrame = v2.CFrame * v74
	else
		local v3 = AnimBase

		v3.CFrame = v3.CFrame * (CurrentCamera.CFrame - CurrentCamera.CFrame.Position)
	end

	if v80 == 2 then
		local v4 = v91

		v91 = v4 + (0.2 - v4) * 0.1
	else
		local v52 = v91

		v91 = v52 + (0 - v52) * 0.1
	end

	local v65 = AnimBase

	v65.CFrame = v65.CFrame * CFrame.new(0, v91, 0)
	v73 = v73:Lerp(CFrame.new(), p1 * 0.2 * 60)

	local v7 = AnimBase

	v7.CFrame = v7.CFrame * v73:Inverse()
	v76 = (v64:FindFirstChild("AimPart" .. v87) or v64.AimPart).CFrame:ToObjectSpace(CurrentCamera.CFrame)

	local AimTime = v62.AimTime

	if ModTable.AimTimeMod then
		local AimTimeMod = ModTable.AimTimeMod
	end

	if v67 then
		local Magnitude = v75:ToObjectSpace(v76).Position.Magnitude
		local v10 = math.clamp(1 - Magnitude / math.max(0.01, v76.Position.Magnitude), 0, 1)

		v75 = v75:Lerp(v76, 1 - (1 - (if v10 < 0.5 then math.sin(v10 * math.pi) * 0.09 + 0.025 else (v10 - 0.5) * 0.12 * 2 + 0.08)) ^ (p1 * 60))
	else
		v75 = v75:Lerp(CFrame.new(), 1 - 0.91 ^ (p1 * 60))
	end

	local v12 = AnimBase

	v12.CFrame = v12.CFrame * v75

	local v13 = tick()

	if v67 then
		t5.lastActive = v13
	end

	local v14 = if v13 - t5.lastActive > 3 and not v67 then 1 else 0

	t5.lowReady = t5.lowReady + (v14 - t5.lowReady) * (1 - (1 - (if t5.lowReady < v14 then 0.03 else 0.15)) ^ (p1 * 60))
	v1:SetAttribute("LowReady", t5.lowReady)

	if t5.lowReady > 0.001 then
		local v16 = AnimBase
		local Angles = CFrame.Angles

		v16.CFrame = v16.CFrame * (Angles(math.rad(-8 * t5.lowReady), 0, 0) * CFrame.new(0, -0.1 * t5.lowReady, 0))
	end

	local gunLength = v62.gunLength

	if ModTable.gunLengthMod then
		gunLength = v62.gunLength + ModTable.gunLengthMod
	end

	if v29 then
		gunLength = gunLength * (if v64 then v64:GetAttribute("VMScale") or 1 else 1)
	end

	local v20 = v29 and AnimBase.CFrame or v97.AnimBase.CFrame
	local v21 = workspace:Raycast(v20.Position, v20.LookVector * gunLength, v5)

	if v21 then
		local v22 = gunLength - (AnimBase.CFrame.Position - v21.Position).Magnitude

		if GameConfig.pushBackViewmodel and v22 > 0 then
			local v242 = v78

			v78 = v242 + ((if v34 then v22 / 2 else v22) - v242) * (p1 * 12)
		else
			local v25 = v78

			v78 = v25 + (0 - v25) * (p1 * 12)
		end

		if GameConfig.raiseGunAtWall and not v27 then
			if v62.maxPushback <= v22 then
				if not v34 then
					ChangeHoldStance(0)
					v98(v62.holdUpAnim, {
						looped = true,
						transSpeed = 0.3,
						priority = Enum.AnimationPriority.Action
					})
					v34 = true

					if v67 then
						v101(false)
					end
				end
			elseif v34 then
				local holdUpAnim = v62.holdUpAnim

				if t3[holdUpAnim] then
					t3[holdUpAnim]:Stop(0.3)
					t3[holdUpAnim .. "ThirdPerson"]:Stop(0.3)
				end

				v34 = false

				if v44 and (not v67 and v29) then
					v101(true)
				end
			end
		end
	else
		if v34 then
			local holdUpAnim = v62.holdUpAnim

			if t3[holdUpAnim] then
				t3[holdUpAnim]:Stop(0.3)
				t3[holdUpAnim .. "ThirdPerson"]:Stop(0.3)
			end
		end

		v34 = false

		if v44 and (not v67 and (v29 and not v63)) then
			v101(true)
		end

		local v26 = v78

		v78 = v26 + (0 - v26) * (p1 * 12)
	end

	local v272 = AnimBase

	v272.CFrame = v272.CFrame * CFrame.new(0, 0, v78)

	local v292 = if v67 then 0 else math.clamp(-HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.Velocity).X, -GameConfig.maxStrafeRoll, GameConfig.maxStrafeRoll)

	if GameConfig.cameraTilting then
		v292 = v292 / 2
	end

	local v332 = v24

	v24 = v332 + (v292 - v332) * (p1 * 0.07 * 60)

	local v342 = AnimBase

	v342.CFrame = v342.CFrame * CFrame.Angles(0, 0, (math.rad(v24)))

	local v36 = UserInputService:GetMouseDelta()
	local v37 = zero

	if GameConfig.hipfireMove and (not v67 or v67 and GameConfig.offCenterAiming) then
		local hipfireMoveX = GameConfig.hipfireMoveX
		local hipfireMoveY = GameConfig.hipfireMoveY

		if v67 then
			hipfireMoveX = hipfireMoveX / 4
			hipfireMoveY = hipfireMoveY / 4
		end

		local v38 = 1 - math.exp(p1 * -8)

		zero = Vector2.new(hipfireMoveX > 0 and hipfireMoveX * math.tanh((v37.X * (1 - v38) - v36.X * GameConfig.hipfireMoveSpeed * p1 * 60) / hipfireMoveX) or 0, hipfireMoveY > 0 and hipfireMoveY * math.tanh((v37.Y * (1 - v38) - v36.Y * GameConfig.hipfireMoveSpeed * p1 * 60) / hipfireMoveY) or 0)
	else
		zero = zero:Lerp(Vector2.zero, 1 - 0.7 ^ (p1 * 60))
	end

	local v43 = AnimBase

	v43.CFrame = v43.CFrame * CFrame.Angles(math.rad(zero.Y), math.rad(zero.X), 0)
	v6:shove((Vector3.new(-v36.X / 300, v36.Y / 160, 0)))

	local v49 = v6:update(p1)
	local v50 = AnimBase

	v50.CFrame = v50.CFrame * CFrame.new(v49.X, v49.Y, 0)

	local v51 = tick() * 0.15
	local breathingDist = GameConfig.breathingDist

	if v67 then
		breathingDist = breathingDist * GameConfig.breathingAimMultiplier
	end

	local v52 = AnimBase

	v52.CFrame = v52.CFrame * CFrame.new(breathingDist * math.sin(v51 * GameConfig.breathingSpeed / 2), breathingDist * math.sin(v51 * GameConfig.breathingSpeed), 0)
	t5.rattle = math.max(t5.rattle - p1 * 3, 0)

	if t5.rattle > 0 then
		local v60 = t5.rattle * 0.035
		local v61 = if v67 then 0.3 else 1
		local v622 = AnimBase

		v622.CFrame = v622.CFrame * (CFrame.new((math.random() - 0.5) * v60 * v61, (math.random() - 0.5) * v60 * v61, (math.random() - 0.5) * v60 * v61) * CFrame.Angles((math.random() - 0.5) * v60 * 0.6 * v61, (math.random() - 0.5) * v60 * 0.6 * v61, (math.random() - 0.5) * v60 * 0.6 * v61))
	end

	local v632 = v9:update(p1)
	local v652 = Vector3.new(math.max(0, v632.X), v632.Y, v632.Z)
	local v66 = v62.gripPivotOffset or Vector3.new(0, -0.3, 0.5)
	local v672 = AnimBase
	local v692 = CFrame.new(v66)
	local Angles2 = CFrame.Angles
	local v70 = math.rad(v652.X)

	v672.CFrame = v672.CFrame * (v692 * Angles2(v70, math.rad(v652.Y), 0) * CFrame.new(-v66))

	local v71 = AnimBase

	v71.CFrame = v71.CFrame * CFrame.new(0, 0, v652.Z)

	local v72 = t5

	v72.accum = v72.accum + p1

	if t5.accum >= 0.015384615384615385 then
		local v732 = v8:update(t5.accum)
		local v752 = Vector3.new(math.max(0, v732.X), v732.Y, v732.Z)

		t5.camRecoil = CFrame.Angles(math.rad(v752.X), math.rad(v752.Y), (math.rad(v752.Z)))

		local v792 = CurrentCamera

		v792.CFrame = v792.CFrame * t5.camRecoil
		t5.accum = 0
	end

	if v33 then
		return
	end

	local v802 = AnimBase

	v802.CFrame = v802.CFrame * v79
end

local function ChangeDoF(p1, p2, p3, p4) --[[ ChangeDoF | Line: 1611 | Upvalues: TweenService (copy), SPH_DoF (copy) ]]
	TweenService:Create(SPH_DoF, TweenInfo.new(0.2), {
		FarIntensity = p1,
		FocusDistance = p2,
		InFocusRadius = p3,
		NearIntensity = p4
	}):Play()
end

local t6 = {
	dotMin = 0.5,
	strafeMult = 1,
	graceTime = 0.2,
	nonFwdTimer = 0.2,
	strandGrace = 0.2,
	keyLastDown = 0
}

local function isForwardDominant() --[[ isForwardDominant | Line: 1628 | Upvalues: Humanoid (copy), CurrentCamera (copy), t6 (copy) ]]
	local MoveDirection = Humanoid.MoveDirection

	if MoveDirection.Magnitude < 0.1 then
		return false
	end

	local LookVector = CurrentCamera.CFrame.LookVector
	local v1 = Vector3.new(LookVector.X, 0, LookVector.Z)

	if v1.Magnitude < 0.01 then
		return true
	end

	local v2 = Vector3.new(MoveDirection.X, 0, MoveDirection.Z)

	if v2.Magnitude < 0.01 then
		return false
	end

	return v1.Unit:Dot(v2.Unit) > t6.dotMin
end

local function sprintKeyIsDown() --[[ sprintKeyIsDown | Line: 1659 | Upvalues: GameConfig (copy), UserInputService (copy) ]]
	for i, v in ipairs(GameConfig.keySprint) do
		if UserInputService:IsKeyDown(v) then
			return true
		end

		if string.sub(v.Name, 1, 6) ~= "Button" and string.sub(v.Name, 1, 4) ~= "DPad" then
			continue
		end

		for i2, v2 in ipairs(UserInputService:GetConnectedGamepads()) do
			if UserInputService:IsGamepadButtonDown(v2, v) then
				return true
			end
		end
	end

	return false
end

local function ToggleSprint(p1) --[[ ToggleSprint | Line: 1673 | Upvalues: v63 (ref), v1 (copy), v67 (ref), v101 (copy), ChangeHoldStance (copy), UserInputService (copy), v27 (ref), v98 (copy), v62 (ref), SPH_DoF (copy), ChangeDoF (copy), t3 (copy) ]]
	v63 = p1
	v1:SetAttribute("Sprinting", p1)

	if p1 then
		if v67 then
			v101(false)
		end

		ChangeHoldStance(0)
		UserInputService.MouseDeltaSensitivity = 1
		v27 = false
		v98(v62.sprintAnim, {
			looped = true,
			transSpeed = 0.2,
			priority = Enum.AnimationPriority.Action
		})

		if SPH_DoF then
			ChangeDoF(0, 6, 0, 0.3)
		end
	else
		if not v62 then
			return
		end

		local sprintAnim = v62.sprintAnim

		if t3[sprintAnim] then
			t3[sprintAnim]:Stop(0.2)
			t3[sprintAnim .. "ThirdPerson"]:Stop(0.2)
		end

		if not SPH_DoF then
			return
		end

		ChangeDoF(0, 0, 0, 0)
	end
end

local function ChangeWalkSpeed(p1) --[[ ChangeWalkSpeed | Line: 1697 | Upvalues: walkSpeed (ref) ]]
	walkSpeed = p1
end

function BipodToggle(p1, p2) --[[ BipodToggle | Line: 1702 | Upvalues: v56 (ref), v52 (ref), t2 (copy), v67 (ref), v58 (ref), v64 (ref), TweenService (copy), v55 (ref) ]]
	if not v56 then
		return
	end

	local v1 = TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.025)

	if p2 == true then
		local Bipod = p1.Weapon:FindFirstChildWhichIsA("Model").Grip:FindFirstChild("Bipod")

		if v52 then
			Bipod = p1.Weapon:FindFirstChildWhichIsA("Model")[v52.Name].Main.Bipod
		end

		local v3, v4, _ = workspace:FindPartOnRayWithIgnoreList(Ray.new(Bipod.WorldPosition, Vector3.new(0, -1.5, 0)), t2, false, true)

		if v3 then
			v58 = if v67 then v58:Lerp(CFrame.new(), 0.2) else v58:Lerp(CFrame.new(0, ((Bipod.WorldCFrame.Position - v4).magnitude - 1) * -1.5, 0), 0.2)
		else
			warn("NO WELD FOUND")
		end

		for k, v in pairs(v64:GetChildren()) do
			if v.Name == "Bipod_Active" then
				TweenService:Create(v, v1, {
					Transparency = 0
				}):Play()

				continue
			end

			if v.Name == "Bipod_Reg" then
				TweenService:Create(v, v1, {
					Transparency = 1
				}):Play()
			end
		end

		if not (v52 and v55) then
			return
		end

		for k, v in pairs(v64[v52.Name]:GetChildren()) do
			if v.Name == "Bipod_Active" then
				TweenService:Create(v, v1, {
					Transparency = 0
				}):Play()

				continue
			end

			if v.Name == "Bipod_Reg" then
				TweenService:Create(v, v1, {
					Transparency = 1
				}):Play()
			end
		end

		return
	end

	for k, v in pairs(v64:GetChildren()) do
		if v.Name == "Bipod_Active" then
			TweenService:Create(v, v1, {
				Transparency = 1
			}):Play()

			continue
		end

		if v.Name == "Bipod_Reg" then
			TweenService:Create(v, v1, {
				Transparency = 0
			}):Play()
		end
	end

	if v52 and v55 then
		for k, v in pairs(v64[v52.Name]:GetChildren()) do
			if v.Name == "Bipod_Active" then
				TweenService:Create(v, v1, {
					Transparency = 1
				}):Play()

				continue
			end

			if v.Name == "Bipod_Reg" then
				TweenService:Create(v, v1, {
					Transparency = 0
				}):Play()
			end
		end
	end

	v58 = v58:Lerp(CFrame.new(), 0.2)
end

local function ChangeStance(p1) --[[ ChangeStance | Line: 1761 | Upvalues: v80 (ref), v1 (copy), v85 (ref), GameConfig (copy), v81 (copy), walkSpeed (ref), TweenService (copy), Humanoid (copy), PlayCharSound (copy), v82 (copy), v70 (ref), v83 (copy), v88 (ref), v23 (copy), v84 (copy) ]]
	local v12 = v80 + p1

	if v12 < 0 then
		v12 = 0
	elseif v12 > 2 then
		v12 = 2
	end

	v1:SetAttribute("Stance", v12)

	local v2 = if v85 then v85.IsPlaying else false

	if v12 == 0 then
		script.Parent.MovementLeaning:SetAttribute("DisableLean", false)

		if v85 then
			v85:Stop(GameConfig.stanceChangeTime)
		end

		v85 = nil
		v81:Stop(GameConfig.stanceChangeTime)
		walkSpeed = GameConfig.walkSpeed
		TweenService:Create(Humanoid, TweenInfo.new(GameConfig.stanceChangeTime), {
			HipHeight = 0
		}):Play()
		PlayCharSound("Uncrouch")
	elseif v12 == 1 then
		script.Parent.MovementLeaning:SetAttribute("DisableLean", false)

		if v85 then
			v85:Stop(GameConfig.stanceChangeTime)
		end

		v85 = v82

		if v70 then
			v82:Play(GameConfig.stanceChangeTime)
		end

		v83:Stop(GameConfig.stanceChangeTime)
		v81:Play(GameConfig.stanceChangeTime)
		walkSpeed = GameConfig.crouchSpeed
		TweenService:Create(Humanoid, TweenInfo.new(GameConfig.stanceChangeTime), {
			HipHeight = 0
		}):Play()

		if v80 == 0 then
			PlayCharSound("Crouch")
		elseif v80 == 2 then
			PlayCharSound("Unprone")
		end
	elseif v12 == 2 then
		if GameConfig.canLean then
			if v88 ~= 0 then
				PlayCharSound("Lean")
			end

			v88 = 0
			v23:Fire(0)
		end

		script.Parent.MovementLeaning:SetAttribute("DisableLean", true)

		if v85 then
			v85:Stop(GameConfig.stanceChangeTime)
		end

		v85 = v84
		v81:Stop(GameConfig.stanceChangeTime)
		v83:Play(GameConfig.stanceChangeTime)
		walkSpeed = GameConfig.proneSpeed
		TweenService:Create(Humanoid, TweenInfo.new(GameConfig.stanceChangeTime * 1.5), {
			HipHeight = -2
		}):Play()
		PlayCharSound("Prone")
	end

	if v2 and v85 then
		v85:Play()
	end

	v80 = v12
end

local t7 = {
	SPH_HoldAim = true,
	SPH_Trigger = true,
	SPH_DropGun = true,
	SPH_Reload = true,
	SPH_Chamber = true,
	SPH_SwitchSights = true,
	SPH_Freelook = true,
	SPH_HoldUp = true,
	SPH_HoldPatrol = true,
	SPH_HoldDown = true,
	SPH_SwitchFireMode = true,
	SPH_ToggleLaser = true,
	SPH_ToggleFlashlight = true,
	SPH_ToggleBipod = true
}

local function HandleInput(p1, p2, p3) --[[ HandleInput | Line: 1830 | Upvalues: t7 (copy), LocalPlayer (copy), v43 (ref), t6 (copy), v80 (ref), v70 (ref), v67 (ref), isForwardDominant (copy), v61 (ref), ToggleSprint (copy), GameConfig (copy), walkSpeed (ref), v88 (ref), PlayCharSound (copy), v23 (copy), v63 (ref), v1 (copy), v62 (ref), t3 (copy), SPH_DoF (copy), ChangeDoF (copy), Humanoid (copy), ChangeStance (copy), v41 (ref), v66 (ref), v27 (ref), v65 (ref), PlayRepSound (copy), v32 (ref), v60 (ref), v19 (copy), v28 (ref), v30 (ref), v72 (ref), ReloadAnim (copy), UserInputService (copy), v29 (ref), v69 (ref), v34 (ref), v44 (ref), v101 (copy), ChamberAnim (copy), v64 (ref), v87 (ref), ToggleADS (copy), v74 (ref), CurrentCamera (copy), v73 (ref), ChangeHoldStance (copy), v98 (copy), ModTable (copy), v37 (ref), Trail (copy), ThirdPersonLaser (copy), v20 (copy), v93 (copy), v38 (ref), v56 (ref), v57 (ref) ]]
	local Begin = Enum.UserInputState.Begin
	local End = Enum.UserInputState.End

	if p2 == Begin and (t7[p1] and LocalPlayer:GetAttribute("UIInputLocked") == true) then
		return Enum.ContextActionResult.Sink
	end

	if p1 == "SPH_Sprint" then
		v43 = p2 == Begin
		t6.keyLastDown = os.clock()

		if v43 and (v80 == 0 and (v70 and not v67)) then
			if isForwardDominant() then
				if v61 and v70 then
					ToggleSprint(true)
				end

				walkSpeed = GameConfig.sprintSpeed
			else
				walkSpeed = GameConfig.walkSpeed * t6.strafeMult
			end

			if GameConfig.canLean then
				if v88 ~= 0 then
					PlayCharSound("Lean")
				end

				v88 = 0
				v23:Fire(0)
			end
		elseif v80 == 0 then
			v63 = false
			v1:SetAttribute("Sprinting", false)

			if v62 then
				local sprintAnim = v62.sprintAnim

				if t3[sprintAnim] then
					t3[sprintAnim]:Stop(0.2)
					t3[sprintAnim .. "ThirdPerson"]:Stop(0.2)
				end

				if SPH_DoF then
					ChangeDoF(0, 0, 0, 0)
				end
			end

			walkSpeed = GameConfig.walkSpeed
		end
	elseif p2 == Begin and (p1 == "SPH_StanceLower" and (p2 == Begin and (v80 < 2 and not Humanoid.Sit))) then
		if not GameConfig.canProne and v80 == 1 then
			return
		end

		ChangeStance(1)

		if v63 then
			v63 = false
			v1:SetAttribute("Sprinting", false)

			if v62 then
				local sprintAnim = v62.sprintAnim

				if t3[sprintAnim] then
					t3[sprintAnim]:Stop(0.2)
					t3[sprintAnim .. "ThirdPerson"]:Stop(0.2)
				end

				if SPH_DoF then
					ChangeDoF(0, 0, 0, 0)
				end
			end
		end
	elseif p2 == Begin and (p1 == "SPH_StanceRaise" and (p2 == Begin and v80 > 0)) then
		ChangeStance(-1)
	elseif p2 == Begin and (p1 == "SPH_LeanLeft" and (p2 == Begin and (v80 < 2 and not (v63 or Humanoid.Sit)))) then
		if v88 == -1 then
			if GameConfig.canLean then
				if v88 ~= 0 then
					PlayCharSound("Lean")
				end

				v88 = 0
				v23:Fire(0)
			end
		elseif GameConfig.canLean then
			if v88 ~= -1 then
				PlayCharSound("Lean")
			end

			v88 = -1
			v23:Fire(-1)
		end
	elseif p2 == Begin and (p1 == "SPH_LeanRight" and (p2 == Begin and (v80 < 2 and not (v63 or Humanoid.Sit)))) then
		if v88 == 1 then
			if GameConfig.canLean then
				if v88 ~= 0 then
					PlayCharSound("Lean")
				end

				v88 = 0
				v23:Fire(0)
			end
		elseif GameConfig.canLean then
			if v88 ~= 1 then
				PlayCharSound("Lean")
			end

			v88 = 1
			v23:Fire(1)
		end
	end

	if not v61 then
		return
	end

	if p1 == "SPH_Trigger" then
		if p2 ~= Begin then
			v27 = false
			v32 = true
			v60 = 0

			return
		end

		v41 = true

		if v63 or v66 then
			return
		end

		v27 = true

		if not (not v62.openBolt and v61.Chambered.Value or v62.openBolt and v65.MagAmmo.Value > 0) and (v61:GetAttribute("FireMode") ~= 4 or not (v61:GetAttribute("MagAmmo") > 0)) then
			PlayRepSound("Click")
		end
	else
		if p1 == "SPH_DropGun" and (p2 == Begin and not v66) then
			Unequip(v61)
			v19:Fire()

			return
		end

		if p1 == "SPH_Reload" and (p2 == Begin and (not v66 and (v28 and not (v30 and os.clock() - v30 < 1.5)))) and not (v62.equipAnim and (t3[v62.equipAnim] and t3[v62.equipAnim].IsPlaying)) then
			if not (v62.infiniteAmmo or v72.Value > 0) then
				return
			end

			if v62.openBolt and v65.MagAmmo.Value < v65.MagAmmo.MaxValue then
				ReloadAnim()

				return
			end

			if (v62.operationType ~= 4 or not v61.Chambered.Value) and ((v62.operationType ~= 3 or not (v65.MagAmmo.Value + 1 >= v65.MagAmmo.MaxValue)) and ((v62.operationType ~= 2 or not (v65.MagAmmo.Value >= v65.MagAmmo.MaxValue)) and (v62.operationType ~= 1 or not (v65.MagAmmo.Value >= v65.MagAmmo.MaxValue)))) then
				ReloadAnim()
			end
		elseif p1 == "SPH_HoldAim" then
			if UserInputService.TouchEnabled or GameConfig.toggleAiming then
				if p2 ~= Begin then
					return
				end

				if not v29 or (v69 or (v34 or v67)) then
					v44 = false
					v101(false)

					return
				end

				v44 = true
				v63 = false
				v1:SetAttribute("Sprinting", false)

				if v62 then
					local sprintAnim = v62.sprintAnim

					if t3[sprintAnim] then
						t3[sprintAnim]:Stop(0.2)
						t3[sprintAnim .. "ThirdPerson"]:Stop(0.2)
					end

					if SPH_DoF then
						ChangeDoF(0, 0, 0, 0)
					end
				end

				if v80 ~= 0 then
					v101(true)

					return
				end

				walkSpeed = GameConfig.walkSpeed
				v101(true)
			elseif p2 == Begin and (v29 and not (v69 or v34)) then
				v44 = true
				v63 = false
				v1:SetAttribute("Sprinting", false)

				if v62 then
					local sprintAnim = v62.sprintAnim

					if t3[sprintAnim] then
						t3[sprintAnim]:Stop(0.2)
						t3[sprintAnim .. "ThirdPerson"]:Stop(0.2)
					end

					if SPH_DoF then
						ChangeDoF(0, 0, 0, 0)
					end
				end

				if v80 ~= 0 then
					v101(true)

					return
				end

				walkSpeed = GameConfig.walkSpeed
				v101(true)
			elseif not v63 and (v67 and not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) then
				v44 = false
				v101(false)
			end
		else
			if p1 == "SPH_Chamber" and (p2 == Begin and (not v66 and v28)) then
				ChamberAnim()

				return
			end

			if p1 == "SPH_SwitchSights" and (p2 == Begin and (v67 and v64:FindFirstChild("AimPart2"))) then
				local v3 = v87 + 1

				if v64:FindFirstChild("AimPart" .. v3) then
					v87 = v3
					PlayRepSound("AimUp")
				else
					v87 = 1
					PlayRepSound("AimDown")
				end

				if v62.ADSEnabled and v62.ADSEnabled[v87] then
					ToggleADS(true)
				else
					ToggleADS(false)
				end

				return
			end

			if p1 == "SPH_Freelook" then
				if p2 == Begin then
					v69 = true
					Humanoid.AutoRotate = false
					v74 = CurrentCamera.CFrame - CurrentCamera.CFrame.Position
				else
					v69 = false
					v73 = v74:ToObjectSpace(CurrentCamera.CFrame)
					v73 = v73 - v73.Position
					Humanoid.AutoRotate = true
				end

				return
			end

			if p1 == "SPH_HoldUp" and (p2 == Begin and not v66) then
				ChangeHoldStance(1)

				return
			end

			if p1 == "SPH_HoldPatrol" and (p2 == Begin and not v66) then
				ChangeHoldStance(2)

				return
			end

			if p1 == "SPH_HoldDown" and (p2 == Begin and not v66) then
				ChangeHoldStance(3)

				return
			end

			if p1 == "SPH_SwitchFireMode" and p2 == Begin then
				v98(v62.switchAnim, {
					transSpeed = 0.2
				})

				return
			end

			if p1 == "SPH_ToggleLaser" and p2 == Begin then
				local v4 = v64.Grip:FindFirstChild("Laser") or (v64:FindFirstChild("Laser", true):FindFirstChild("Laser", true) or ModTable.laserAtt and v64[ModTable.laserAtt].Main:FindFirstChild("Laser"))

				if not v4 then
					return
				end

				v37 = not v37
				Trail.Enabled = v37

				local v5

				if v29 then
					PlayRepSound("Button")
					v20:Fire(1, v37, ModTable)
					v93.Dot.ImageColor3 = v4.Color.Value
					v5 = v4.Color.Value
					Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v5), ColorSequenceKeypoint.new(1, v5) })

					return
				end

				ThirdPersonLaser.Enabled = true
				PlayRepSound("Button")
				v20:Fire(1, v37, ModTable)
				v93.Dot.ImageColor3 = v4.Color.Value
				v5 = v4.Color.Value
				Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v5), ColorSequenceKeypoint.new(1, v5) })
			elseif p1 == "SPH_ToggleFlashlight" and p2 == Begin then
				local Flashlight = v64:FindFirstChild("Flashlight", true)

				if not Flashlight then
					return
				end

				local v6 = Flashlight:FindFirstChildWhichIsA("Light", true)

				v38 = not v38
				v6.Enabled = v38
				PlayRepSound("Button")
				v20:Fire(0, v6.Enabled, ModTable)

				if not v38 then
					v6.Enabled = false

					return
				end

				if not v29 then
					v6.Enabled = true
				end
			else
				if p1 ~= "SPH_ToggleBipod" or (p2 ~= Begin or not v56) then
					return
				end

				v57 = not v57
				BipodToggle(CurrentCamera.WeaponRig, v57)
				v20:Fire(2, v57, ModTable)
			end
		end
	end
end

local function BindAiming() --[[ BindAiming | Line: 2084 | Upvalues: LocalPlayer (copy), v27 (ref), v43 (ref), v67 (ref), v101 (copy), ContextActionService (copy), HandleInput (copy), GameConfig (copy) ]]
	LocalPlayer:GetAttributeChangedSignal("UIInputLocked"):Connect(function() --[[ Line: 2088 | Upvalues: LocalPlayer (ref), v27 (ref), v43 (ref), v67 (ref), v101 (ref) ]]
		if LocalPlayer:GetAttribute("UIInputLocked") ~= true then
			return
		end

		v27 = false
		v43 = false

		if not v67 then
			return
		end

		v101(false)
	end)
	ContextActionService:BindActionAtPriority("SPH_HoldAim", HandleInput, GameConfig.mobileButtons, GameConfig.gunInputPriority, unpack(GameConfig.aimGun))
	ContextActionService:SetTitle("SPH_HoldAim", "Aim")
	ContextActionService:SetPosition("SPH_HoldAim", UDim2.fromScale(0.24, 0.3))
end

local function UnbindAiming() --[[ UnbindAiming | Line: 2100 | Upvalues: ContextActionService (copy) ]]
	ContextActionService:UnbindAction("SPH_HoldAim")
end

local function BindGunInputs() --[[ BindGunInputs | Line: 2104 | Upvalues: ContextActionService (copy), HandleInput (copy), GameConfig (copy), v29 (ref), BindAiming (copy) ]]
	ContextActionService:BindActionAtPriority("SPH_Trigger", HandleInput, GameConfig.mobileButtons, GameConfig.gunInputPriority, unpack(GameConfig.fireGun))
	ContextActionService:BindActionAtPriority("SPH_DropGun", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.dropKey))
	ContextActionService:BindActionAtPriority("SPH_Reload", HandleInput, GameConfig.mobileButtons, GameConfig.gunInputPriority, unpack(GameConfig.keyReload))
	ContextActionService:BindActionAtPriority("SPH_Chamber", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.keyChamber))
	ContextActionService:BindActionAtPriority("SPH_SwitchSights", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.sightSwitch))
	ContextActionService:BindActionAtPriority("SPH_Freelook", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.freeLook))
	ContextActionService:BindActionAtPriority("SPH_HoldUp", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.holdUp))
	ContextActionService:BindActionAtPriority("SPH_HoldPatrol", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.holdPatrol))
	ContextActionService:BindActionAtPriority("SPH_HoldDown", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.holdDown))
	ContextActionService:BindActionAtPriority("SPH_SwitchFireMode", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.switchFireMode))
	ContextActionService:BindActionAtPriority("SPH_ToggleLaser", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.toggleLaser))
	ContextActionService:BindActionAtPriority("SPH_ToggleFlashlight", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.toggleFlashlight))
	ContextActionService:BindActionAtPriority("SPH_ToggleBipod", HandleInput, false, GameConfig.gunInputPriority, unpack(GameConfig.ToggleBipod))

	if v29 then
		BindAiming()
	end

	ContextActionService:SetTitle("SPH_Trigger", "Fire")
	ContextActionService:SetPosition("SPH_Trigger", UDim2.fromScale(0.3, 0.6))
	ContextActionService:SetTitle("SPH_Reload", "Reload")
	ContextActionService:SetPosition("SPH_Reload", UDim2.fromScale(0, 0.6))
end

local function UnbindGunInputs() --[[ UnbindGunInputs | Line: 2129 | Upvalues: ContextActionService (copy) ]]
	ContextActionService:UnbindAction("SPH_Trigger")
	ContextActionService:UnbindAction("SPH_DropGun")
	ContextActionService:UnbindAction("SPH_Reload")
	ContextActionService:UnbindAction("SPH_HoldAim")
	ContextActionService:UnbindAction("SPH_Chamber")
	ContextActionService:UnbindAction("SPH_SwitchSights")
	ContextActionService:UnbindAction("SPH_Freelook")
	ContextActionService:UnbindAction("SPH_HoldUp")
	ContextActionService:UnbindAction("SPH_HoldPatrol")
	ContextActionService:UnbindAction("SPH_HoldDown")
	ContextActionService:UnbindAction("SPH_SwitchFireMode")
	ContextActionService:UnbindAction("SPH_ToggleLaser")
	ContextActionService:UnbindAction("SPH_ToggleFlashlight")
	ContextActionService:UnbindAction("SPH_ToggleBipod")
end

local function BindCharacterInputs() --[[ BindCharacterInputs | Line: 2146 | Upvalues: ContextActionService (copy), HandleInput (copy), GameConfig (copy) ]]
	ContextActionService:BindActionAtPriority("SPH_Sprint", HandleInput, false, GameConfig.movementInputPriority, unpack(GameConfig.keySprint))
	ContextActionService:BindActionAtPriority("SPH_StanceLower", HandleInput, GameConfig.mobileButtons, GameConfig.movementInputPriority, unpack(GameConfig.lowerStance))
	ContextActionService:BindActionAtPriority("SPH_StanceRaise", HandleInput, GameConfig.mobileButtons, GameConfig.movementInputPriority, unpack(GameConfig.raiseStance))
	ContextActionService:BindActionAtPriority("SPH_LeanLeft", HandleInput, false, GameConfig.movementInputPriority, unpack(GameConfig.leanLeft))
	ContextActionService:BindActionAtPriority("SPH_LeanRight", HandleInput, false, GameConfig.movementInputPriority, unpack(GameConfig.leanRight))
	ContextActionService:SetTitle("SPH_StanceLower", "Crouch")
	ContextActionService:SetPosition("SPH_StanceLower", UDim2.fromScale(0.4, 0))
	ContextActionService:SetTitle("SPH_StanceRaise", "Stand")
	ContextActionService:SetPosition("SPH_StanceRaise", UDim2.fromScale(0.55, -0.25))
end

BindCharacterInputs()

local function UnbindCharacterInputs() --[[ UnbindCharacterInputs | Line: 2161 | Upvalues: ContextActionService (copy) ]]
	ContextActionService:UnbindAction("SPH_Sprint")
	ContextActionService:UnbindAction("SPH_StanceLower")
	ContextActionService:UnbindAction("SPH_StanceRaise")
	ContextActionService:UnbindAction("SPH_LeanLeft")
	ContextActionService:UnbindAction("SPH_LeanRight")
end

Humanoid.Died:Connect(function() --[[ Line: 2169 | Upvalues: v31 (ref), v96 (ref), v11 (copy), v61 (ref), v62 (ref), UserInputService (copy), v101 (copy), v33 (ref), AnimBase (copy), v79 (copy), UnbindGunInputs (copy), GameConfig (copy), Humanoid (copy), v1 (copy), CurrentCamera (copy) ]]
	v31 = true

	if v96 then
		v96:Destroy()
		v96 = nil
	end

	v11:Fire()
	v61 = nil
	v62 = nil
	UserInputService.MouseIconEnabled = true
	v101(false)
	v33 = false
	AnimBase.CFrame = v79
	UnbindGunInputs()

	if GameConfig.useDeathCameraSubject then
		repeat
			task.wait()
		until Humanoid.Parent ~= v1

		CurrentCamera.CameraSubject = Humanoid
	end

	if not rig then
		return
	end

	rig:Destroy()
end)
function Unequip(p1) --[[ Unequip | Line: 2203 | Upvalues: AnimBase (copy), v79 (copy), v11 (copy), v61 (ref), v62 (ref), v96 (ref), UserInputService (copy), v101 (copy), v33 (ref), Animator (copy), Animator2 (copy), GameConfig (copy), LocalPlayer (copy), t4 (ref), v69 (ref), v73 (ref), v74 (ref), CurrentCamera (copy), Humanoid (copy), SPH_DoF (copy), ChangeDoF (copy), v35 (ref), v36 (ref), v37 (ref), v38 (ref), v93 (copy), FirstPersonLaser (copy), ThirdPersonLaser (copy), v50 (ref), v51 (ref), v52 (ref), v53 (ref), v54 (ref), ModTable (copy), UnbindGunInputs (copy) ]]
	AnimBase.CFrame = v79
	v11:Fire()

	if p1 == v61 then
		v61 = nil
		v62 = nil

		if v96 then
			v96:Destroy()
			v96 = nil
		end
	end

	UserInputService.MouseIconEnabled = UserInputService.MouseBehavior == Enum.MouseBehavior.Default
	v101(false)
	v33 = false

	for i, v in ipairs(Animator:GetPlayingAnimationTracks()) do
		v:Stop()
	end

	for i, v in ipairs(Animator2:GetPlayingAnimationTracks()) do
		v:Stop()
	end

	if GameConfig.lockFirstPerson then
		LocalPlayer.CameraMode = Enum.CameraMode.Classic
	end

	t4 = {}
	v69 = false
	v73 = v74:ToObjectSpace(CurrentCamera.CFrame)
	v73 = v73 - v73.Position
	Humanoid.AutoRotate = true

	if not SPH_DoF then
		v35 = 0
		v36 = nil
		v37 = false
		v38 = false
		v93.Enabled = false
		FirstPersonLaser.Enabled = false
		ThirdPersonLaser.Enabled = false
		v50 = nil
		v51 = nil
		v52 = nil
		v53 = nil
		v54 = nil
		ModTable.laserAtt = nil
		resetMods()
		LocalPlayer:SetAttribute("rangefinderActive", false)
		UnbindGunInputs()

		return
	end

	ChangeDoF(0, 0, 0, 0)
	v35 = 0
	v36 = nil
	v37 = false
	v38 = false
	v93.Enabled = false
	FirstPersonLaser.Enabled = false
	ThirdPersonLaser.Enabled = false
	v50 = nil
	v51 = nil
	v52 = nil
	v53 = nil
	v54 = nil
	ModTable.laserAtt = nil
	resetMods()
	LocalPlayer:SetAttribute("rangefinderActive", false)
	UnbindGunInputs()
end

local function GetRotationBetween(p1, p2, p3) --[[ GetRotationBetween | Line: 2270 ]]
	local v1 = p1:Dot(p2)
	local v2 = p1:Cross(p2)

	if v1 < -0.99999 then
		return CFrame.fromAxisAngle(p3, math.pi)
	end

	return CFrame.new(0, 0, 0, v2.x, v2.y, v2.z, 1 + v1)
end

v1.ChildAdded:Connect(function(p1) --[[ Line: 2277 | Upvalues: SPH_Assets (copy), v31 (ref), Humanoid (copy), v39 (ref), v66 (ref), v1 (copy), UserInputService (copy), zero (ref), v30 (ref), v34 (ref), v37 (ref), v28 (ref), v42 (ref), v11 (copy), v61 (ref), v62 (ref), v8 (copy), v9 (copy), v68 (ref), FieldOfView2 (ref), FieldOfView (copy), v73 (ref), v55 (ref), WeldMod (copy), t4 (ref), v50 (ref), v64 (ref), v29 (ref), RefreshViewmodel (copy), BuildCursor (copy), BindGunInputs (copy), ToggleSprint (copy), v43 (ref), EquipAnim (copy), v98 (copy), v65 (ref), v71 (ref), v72 (ref), MoveBolt (copy), GameConfig (copy), LocalPlayer (copy), v59 (ref), FirstPersonLaser (copy), ModTable (copy), ChamberAnim (copy) ]]
	if p1:FindFirstChild("SPH_Weapon") and not SPH_Assets.WeaponModels:FindFirstChild(p1.Name) then
		warn("\227\128\144 SPEARHEAD \227\128\145 " .. "No gun model could be found for \'" .. p1.Name .. "\'")

		return
	end

	if not p1:FindFirstChild("SPH_Weapon") or (v31 or Humanoid.Sit and (not Humanoid.Sit or v39)) then
		return
	end

	v66 = false
	v1:SetAttribute("_ReloadingUntil", 0)
	UserInputService.MouseIconEnabled = false
	zero = Vector2.zero
	v30 = os.clock()
	v34 = false
	v37 = false
	v28 = true
	v42 = false
	v11:Fire(p1)
	v61 = p1
	v62 = require(v61.SPH_Weapon.WeaponStats)
	v8.Damping = v62.recoil.damping
	v8.Speed = v62.recoil.speed
	v9.Damping = v62.gunRecoil.damping
	v9.Speed = v62.gunRecoil.speed
	v68 = v62.viewmodelOffset
	FieldOfView2 = v62.aimFovDefault or FieldOfView
	v73 = CFrame.new()
	v55 = v62.Bipod

	if not v62.operationType then
		v62.operationType = 1
	end

	local operationType = v62.operationType

	if type(operationType) == "string" then
		v62.operationType = 1
	end

	if not v62.magType then
		v62.magType = 1
	end

	for i, v in ipairs(rig.Weapon:GetChildren()) do
		if v:IsA("Model") then
			v:Destroy()
		end
	end

	local v2 = SPH_Assets.WeaponModels:FindFirstChild(p1.Name)

	if not v2 then
		warn("\227\128\144 SPEARHEAD \227\128\145 " .. "Could not find a gun model with the name: \'" .. p1.Name .. "\'!")

		return
	end

	local v3 = v2:Clone()

	if (v62.viewmodelScale or 1) ~= 1 then
		v3.PrimaryPart = v3.Grip
		v3:ScaleTo(v3:GetScale() * v62.viewmodelScale)
	end

	local v4 = v3

	v4:SetAttribute("VMScale", v62.viewmodelScale or 1)
	WeldMod.WeldModel(v4, v4.Grip, false)

	for i, v in ipairs(v4:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
			v.Anchored = false
		end
	end

	resetMods()
	loadAttachment(v4)

	for i, v in ipairs(v62.rigParts) do
		if v4:FindFirstChild(v) then
			v4.Grip["Grip_" .. v]:Destroy()

			local v5 = WeldMod.M6D(v4.Grip, v4[v])

			v5.Name = v
			v5.Parent = v4.Grip
		end
	end

	for i, v in ipairs(v4:GetChildren()) do
		if v.Name == "SightReticle" then
			table.insert(t4, v)
		end
	end

	if v50 then
		for i, v in ipairs(v4[v50.Name]:GetChildren()) do
			if v.Name == "SightReticle" then
				table.insert(t4, v)
			end
		end
	end

	v4.Parent = rig.Weapon
	v64 = v4
	WeldMod.BlankM6D(rig.AnimBase, v4.Grip)

	if v29 then
		RefreshViewmodel()
	end

	BuildCursor(v4.Grip:WaitForChild("Muzzle"))
	BindGunInputs()
	ToggleSprint(v43)
	EquipAnim()
	v98(v62.idleAnim, {
		looped = true,
		priority = Enum.AnimationPriority.Idle
	})
	v65 = p1:WaitForChild("Ammo")

	local ammoType = v62.ammoType
	local AmmoPool = v1:FindFirstChild("AmmoPool")

	v71 = AmmoPool:FindFirstChild(ammoType) or AmmoPool.Universal
	v72 = v71.CurrentValue

	if not v61.BoltReady.Value then
		MoveBolt(v62.boltDist, true)
	end

	if GameConfig.lockFirstPerson then
		LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
	end

	v59 = v61.FireMode.Value

	if v4.Grip:FindFirstChild("Laser") then
		FirstPersonLaser.Attachment0 = v4.Grip.Laser
	end

	if ModTable.EnableLaserAtt then
		FirstPersonLaser.Attachment0 = v4[ModTable.laserAtt].Main.Laser
	end

	local reloadSpeedModifier = v62.reloadSpeedModifier

	if ModTable.reloadSpeedModifier then
		reloadSpeedModifier = ModTable.reloadSpeedModifier
	end

	if v62.magType == 1 then
		v98(v62.reloadAnim, {
			transSpeed = 0.17,
			speed = reloadSpeedModifier,
			priority = Enum.AnimationPriority.Action2
		}, "Reload", true)
	else
		local t = {
			transSpeed = 0,
			speed = reloadSpeedModifier,
			priority = Enum.AnimationPriority.Action2
		}

		t.looped = v65.MagAmmo.MaxValue > 1
		v98(v62.reloadAnim, t, "Reload", true)

		if v62.magType == 3 then
			v98(v62.clipReloadAnim, {
				transSpeed = 0.17,
				looped = false,
				speed = reloadSpeedModifier,
				priority = Enum.AnimationPriority.Action2
			}, "Reload", true)
		end
	end

	v98(v62.equipAnim, {
		priority = Enum.AnimationPriority.Action2
	}, "Equip", true).Stopped:Once(function() --[[ Line: 2507 | Upvalues: v30 (ref), v1 (ref), v61 (ref), p1 (copy), v62 (ref), v66 (ref), v42 (ref), v65 (ref), ChamberAnim (ref) ]]
		v30 = false

		local v12 = v1:GetAttribute("_ReloadingUntil")

		if type(v12) == "number" and os.clock() < v12 then
			return
		end

		if v61 ~= p1 or (not v62 or (v62.openBolt or (v66 or (v42 or (not v61:FindFirstChild("Chambered") or (v61.Chambered.Value or not (v65 and (v65:FindFirstChild("MagAmmo") and v65.MagAmmo.Value > 0)))))))) then
			return
		end

		ChamberAnim()
	end)
	v98(v62.boltChamber, {
		transSpeed = 0.05,
		looped = false,
		priority = Enum.AnimationPriority.Action2
	}, "Chamber", true)

	if v62.operationType ~= 2 and v62.operationType ~= 3 then
		return
	end

	v98(v62.boltOpen, {
		transSpeed = 0,
		looped = false,
		priority = Enum.AnimationPriority.Action2
	}, "BoltOpen", true)
	v98(v62.boltClose, {
		looped = false,
		priority = Enum.AnimationPriority.Action2
	}, "BoltClose", true)
end)
v1.ChildRemoved:Connect(function(p1) --[[ Line: 2551 | Upvalues: v61 (ref), SPH_Assets (copy) ]]
	if not (v61 and (p1:FindFirstChild("SPH_Weapon") and SPH_Assets.WeaponModels:FindFirstChild(p1.Name))) then
		return
	end

	Unequip(p1)
end)

local function IsActuallyAiming() --[[ IsActuallyAiming | Line: 2557 | Upvalues: v67 (ref), v29 (ref), UserInputService (copy) ]]
	return v67 or not v29 and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
end

RunService.Heartbeat:Connect(function(p1) --[[ Line: 2561 | Upvalues: v61 (ref), v31 (ref), v27 (ref), v28 (ref), v63 (ref), v66 (ref), v32 (ref), v34 (ref), v1 (copy), v35 (ref), v62 (ref), v65 (ref), v59 (ref), GameConfig (copy), v69 (ref), v30 (ref), v29 (ref), v98 (copy), FiringBlur (copy), v60 (ref), v40 (ref), v97 (copy), v64 (ref), ModTable (copy), v67 (ref), UserInputService (copy), v80 (ref), v8 (copy), v57 (ref), v9 (copy), t5 (copy), ShellEjection (copy), LocalPlayer (copy), BulletHandler (copy), MoveBolt (copy), v12 (copy), v96 (ref), ChamberAnim (copy), v42 (ref), v15 (copy) ]]
	if not v61 or (v31 or (not v27 or (not v28 or (v63 or v66)))) then
		return
	end

	if v32 and (not v34 and (not v1:GetAttribute("_UsingItem") and v35 == 0)) then
		local v13 = not v62.openBolt and v61.Chambered.Value or v62.openBolt and (if v65.MagAmmo.Value > 0 then true else false)

		if v13 and (v59 > 0 and (GameConfig.fireWithFreelook or not (GameConfig.fireWithFreelook or v69))) and not v30 then
			if not (v29 or GameConfig.thirdPersonFiring) then
				return
			end

			if v62.fireAnim then
				v98(v62.fireAnim, {
					looped = false,
					priority = Enum.AnimationPriority.Action2
				})
			end

			if v62.fireBlur and v62.fireBlur > 0 then
				task.spawn(function() --[[ Line: 2578 | Upvalues: FiringBlur (ref), v62 (ref) ]]
					FiringBlur.Size = v62.fireBlur
					FiringBlur.Enabled = true
					task.wait(0.095)
					FiringBlur.Enabled = false
				end)
			end

			v60 = v60 + 1
			v40 = false

			if v59 == 1 or (v59 == 4 or v59 == 3 and v60 >= v62.burstNumber) then
				v32 = false
				v27 = false
			end

			v28 = false
			v97.Weapon:FindFirstChildWhichIsA("Model")

			local v2 = v64
			local recoil = v62.recoil
			local v3 = recoil.vertical * ModTable.recoilMod.vertical
			local v4 = recoil.horizontal * ModTable.recoilMod.horizontal

			if v67 or not v29 and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
				v3 = v3 / (recoil.aimReduction * ModTable.recoilMod.aimReduction)
				v4 = v4 / (recoil.aimReduction * ModTable.recoilMod.aimReduction)
			end

			if v80 == 2 then
				v4 = v4 / 2
				v3 = v3 / 2
			end

			v8:shove((Vector3.new(v3, math.random(-v4, v4), recoil.camShake)))

			local gunRecoil = v62.gunRecoil
			local vertical = gunRecoil.vertical
			local horizontal = gunRecoil.horizontal

			if v80 == 2 then
				vertical = vertical / 1.5
				horizontal = horizontal / 1.5
			end

			if v57 then
				vertical = vertical * 0.25
				horizontal = horizontal * 0.25
			end

			if v80 == 2 then
				horizontal = horizontal / 2
				vertical = vertical / 2
			end

			local v82 = if math.random() > 0.5 then 1 else -1
			local v92 = horizontal * 0.5 + math.random() * horizontal * 0.5

			v9:shove((Vector3.new(vertical * (0.85 + math.random() * 0.3), v82 * v92, gunRecoil.punchMultiplier)))
			t5.rattle = math.min(t5.rattle + 0.4, 1)
			t5.lastActive = tick()

			if v59 ~= 4 then
				v40 = true

				if v62.shellEject then
					if v29 then
						ShellEjection.ejectShell(LocalPlayer, v61, v64)
					else
						ShellEjection.ejectShell(LocalPlayer, v61, v97.Weapon:FindFirstChildWhichIsA("Model"))
					end
				end
			end

			local v14 = v62.bulletHolder and v64:FindFirstChild(v62.bulletHolder)

			if v14 then
				local v152 = v14:FindFirstChild("Bullet" .. v65.MagAmmo.MaxValue - (v65.MagAmmo.Value - 1))

				if v152 then
					v152.Transparency = 1
				end
			end

			local v16 = v64

			if not v29 then
				v16 = v97.Weapon:FindFirstChildWhichIsA("Model")
			end

			if ModTable.muzzleChance then
				if ModTable.IsSuppressor then
					BulletHandler.FireFX(LocalPlayer, v16, "Muzzle", ModTable.muzzleChance, true)
				else
					BulletHandler.FireFX(LocalPlayer, v16, "Muzzle", ModTable.muzzleChance, false)
				end
			else
				BulletHandler.FireFX(LocalPlayer, v16, "Muzzle", v62.muzzleChance)
			end

			MoveBolt(v62.boltDist)

			local count = v62.shotgun and v62.shotgunPellets or 1

			if ModTable.shotgun then
				count = ModTable.shotgunPellets
			end

			repeat
				local v18, v19

				count = count - 1

				local spread = v62.spread

				if ModTable.spread then
					spread = spread * ModTable.spread
				end

				local v23 = CFrame.Angles(math.rad((math.random(-spread, spread))), math.rad((math.random(-spread, spread))), 0)

				if v29 then
					v18 = v2.Grip.Muzzle.WorldCFrame.Position
					v19 = (v2.Grip.Muzzle.WorldCFrame * v23).LookVector
				else
					local Muzzle = v97.Weapon:FindFirstChildWhichIsA("Model").Grip.Muzzle

					v18 = Muzzle.WorldCFrame.Position
					v19 = (Muzzle.WorldCFrame * v23).LookVector
				end

				local muzzleVelocity = v62.muzzleVelocity

				if ModTable.muzzleVelocity then
					muzzleVelocity = ModTable.muzzleVelocity
				end

				local v25 = nil
				local tracers = v62.tracers
				local tracerTiming = v62.tracerTiming
				local tracerColor = v62.tracerColor

				if ModTable.tracers then
					tracers = ModTable.tracers
					tracerTiming = ModTable.tracerTiming
					tracerColor = ModTable.tracerColor
				end

				if tracers and v65.MagAmmo.Value % tracerTiming == 0 then
					v25 = tracerColor
				end

				if v25 == "Random" then
					v25 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
				end

				BulletHandler.FireBullet(v97, v18, v19, v19 * muzzleVelocity * 3.5, v61, LocalPlayer, v25, false, ModTable)
			until count <= 0

			v12:Fire(v2.Grip.Muzzle.WorldCFrame, ModTable)

			if v96 then
				v96:Shove(Vector3.new(gunRecoil.vertical, math.random(-gunRecoil.horizontal, gunRecoil.horizontal), gunRecoil.punchMultiplier) * p1 * 60)
			end

			local v292 = v62.fireRate * ModTable.fireRate

			if v59 == 3 and v62.burstFireRate then
				v292 = v62.burstFireRate
			end

			if v64 and (v62.projectile ~= "Bullet" and v64:FindFirstChild(v62.projectile)) then
				local v302 = v64:FindFirstChild(v62.projectile)

				v302.LocalTransparencyModifier = 1

				for i, v in ipairs(v302:GetDescendants()) do
					if v:IsA("BasePart") then
						v.LocalTransparencyModifier = 1
					end
				end
			end

			task.wait(60 / v292)

			if not v61 then
				return
			end

			if not v62.autoChamber or (v59 ~= 4 or v66) then
				v28 = true

				return
			end

			ChamberAnim()
			v28 = true

			return
		end
	end

	local v312 = not v62.openBolt and v61.Chambered.Value or v62.openBolt and v65.MagAmmo.Value > 0

	if v312 then
		if not v62.emptyCloseBolt then
			return
		end

		v15:Fire()
		MoveBolt(CFrame.new())
	elseif v59 == 4 and (v65.MagAmmo.Value > 0 and not (v66 or v42)) then
		ChamberAnim()
		v27 = false
	end
end)
RunService.RenderStepped:Connect(function(p1) --[[ Line: 2779 | Upvalues: v55 (ref), v61 (ref), CurrentCamera (copy), ModTable (copy), v52 (ref), t2 (copy), v57 (ref), v56 (ref), v20 (copy), v77 (ref), Humanoid (copy), v39 (ref), v29 (ref), v69 (ref), GameConfig (copy), HumanoidRootPart (copy), v31 (ref), v1 (copy), v63 (ref), v2 (ref), v10 (copy), BindAiming (copy), v38 (ref), v64 (ref), v97 (copy), v37 (ref), ThirdPersonLaser (copy), FirstPersonLaser (copy), ContextActionService (copy), v33 (ref), v86 (ref), v85 (ref), v70 (ref), v62 (ref), t3 (copy), SPH_DoF (copy), ChangeDoF (copy), v80 (ref), walkSpeed (ref), v43 (ref), sprintKeyIsDown (copy), t6 (copy), v67 (ref), isForwardDominant (copy), ToggleSprint (copy), v96 (ref), v5 (copy), v88 (ref), RootJoint (copy), v89 (ref), UserInputService (copy), v25 (ref), RefreshViewmodel (copy), UpdateViewmodelPosition (copy), LocalPlayer (copy), v93 (copy), Trail (copy), Attachment (copy), v30 (ref), v26 (ref), v7 (copy), AnimBase (copy), t4 (ref), FieldOfView2 (ref), t (copy), GetRotationBetween (copy) ]]
	if math.ceil(1 / p1) < 5 then
		print("\227\128\144 SPEARHEAD \227\128\145 RenderStepped skipped due to low framerate.")

		return
	end

	if v55 and (v61 and CurrentCamera:WaitForChild("WeaponRig").Weapon:FindFirstChildWhichIsA("Model")) then
		local v12 = ModTable.bipodAtt or CurrentCamera.WeaponRig.Weapon:FindFirstChildWhichIsA("Model").Grip:FindFirstChild("Bipod")

		if v12 then
			if v52 then
				v12 = CurrentCamera.WeaponRig.Weapon:FindFirstChildWhichIsA("Model")[v52.Name].Main.Bipod
			end

			local v3, _, _2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v12.WorldCFrame.Position, Vector3.new(0, -1.5, 0)), t2, false, true)

			if v57 and not v56 then
				v57 = false
				BipodToggle(CurrentCamera.WeaponRig, v57)
				v20:Fire(2, v57, ModTable)
			end

			v56 = if v3 then true else false
		end
	end

	v77 = v77 - p1

	if (Humanoid.Sit and (not v39 and v29) or v69) and GameConfig.cameraLimitInSeats then
		local v4, v53, v6 = HumanoidRootPart.CFrame:ToObjectSpace(CurrentCamera.CFrame):ToOrientation()
		local v9 = math.rad((math.clamp(math.deg(v4), -60, 60)))
		local v12 = math.rad((math.clamp(math.deg(v53), -60, 60)))
		local v15 = math.rad((math.clamp(math.deg(v6), -60, 60)))
		local v16 = HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(CurrentCamera.CFrame.Position.X, CurrentCamera.CFrame.Position.Y, CurrentCamera.CFrame.Position.Z) * CFrame.fromOrientation(v9, v12, v15))

		CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position) * (v16 - v16.Position)
	end

	if not v31 and v1:FindFirstChild("Head") then
		if not v31 then
			local v17 = if Humanoid.RigType == Enum.HumanoidRigType.R6 then v1.Torso.CFrame.LookVector else v1.UpperTorso.CFrame.LookVector
			local v18 = CurrentCamera.CFrame

			if (not GameConfig.headRotation or v63) and not v29 then
				v18 = HumanoidRootPart.CFrame
			end

			local LookVector = HumanoidRootPart.CFrame:ToObjectSpace(v18).LookVector
			local v19 = CFrame.Angles(0, math.asin(LookVector.X) / 1.15, 0)
			local Angles2 = CFrame.Angles
			local v202 = -math.asin(v18.LookVector.Y)
			local v21 = v19 * Angles2(v202 + math.asin(v17.Y), 0, 0)

			v2.C1 = v2.C1:Lerp(CFrame.new(0, -0.5, 0) * v21 * CFrame.Angles(-1.5707963267948966, 0, math.pi), 1 - math.exp(-GameConfig.headRotationSpeed * p1))

			if v77 <= 0 and not (v31 or GameConfig.disableHeadRotation) then
				v77 = GameConfig.headRotationEventRate
				v10:Fire(v2.C1)
			end
		end

		if v29 or not (v1.Head.LocalTransparencyModifier >= 0.6) then
			if v29 and v1.Head.LocalTransparencyModifier <= 0.6 then
				v29 = false
				ContextActionService:UnbindAction("SPH_HoldAim")

				if v61 then
					if v37 then
						ThirdPersonLaser.Enabled = true
						FirstPersonLaser.Enabled = false

						if not ThirdPersonLaser.Attachment0 then
							ThirdPersonLaser.Attachment0 = v97.Weapon:FindFirstChildWhichIsA("Model").Grip:FindFirstChild("Laser") or v97.Weapon:FindFirstChildWhichIsA("Model")[ModTable.laserAtt].Main.Laser
						end
					end

					if v64.Grip:FindFirstChild("Flashlight") then
						v64.Grip.Flashlight:FindFirstChildWhichIsA("Light").Enabled = false

						if v97.Weapon:FindFirstChildWhichIsA("Model") and v38 then
							v97.Weapon:FindFirstChildWhichIsA("Model").Grip.Flashlight:FindFirstChildWhichIsA("Light").Enabled = true
						end
					end
				end

				v33 = false
				v86 = Vector3.new(0, 0, 0)
			end
		else
			v29 = true

			if v61 then
				BindAiming()

				if v38 and v64.Grip:FindFirstChild("Flashlight") then
					v64.Grip.Flashlight:FindFirstChildWhichIsA("Light").Enabled = true
					v97.Weapon:FindFirstChildWhichIsA("Model").Grip.Flashlight:FindFirstChildWhichIsA("Light").Enabled = false
				end

				if v37 then
					ThirdPersonLaser.Enabled = false
					FirstPersonLaser.Enabled = true
				end
			end
		end

		if v85 then
			v85:AdjustSpeed(Humanoid.WalkSpeed / 6)
		end

		if Humanoid.MoveDirection.Magnitude > 0 and not v70 then
			v70 = true

			if v85 then
				v85:Play(GameConfig.stanceChangeTime)
			end
		elseif Humanoid.MoveDirection.Magnitude <= 0 then
			v70 = false

			if v63 then
				v63 = false
				v1:SetAttribute("Sprinting", false)

				if v62 then
					local sprintAnim = v62.sprintAnim

					if t3[sprintAnim] then
						t3[sprintAnim]:Stop(0.2)
						t3[sprintAnim .. "ThirdPerson"]:Stop(0.2)
					end

					if SPH_DoF then
						ChangeDoF(0, 0, 0, 0)
					end
				end

				walkSpeed = if v80 == 1 then GameConfig.crouchSpeed elseif v80 == 2 then GameConfig.proneSpeed else GameConfig.walkSpeed
			end

			if v85 then
				v85:Stop(GameConfig.stanceChangeTime)
			end
		end

		if v43 and sprintKeyIsDown() then
			t6.keyLastDown = os.clock()
		elseif v43 and os.clock() - t6.keyLastDown > t6.strandGrace then
			v43 = false

			if v63 then
				v63 = false
				v1:SetAttribute("Sprinting", false)

				if v62 then
					local sprintAnim = v62.sprintAnim

					if t3[sprintAnim] then
						t3[sprintAnim]:Stop(0.2)
						t3[sprintAnim .. "ThirdPerson"]:Stop(0.2)
					end

					if SPH_DoF then
						ChangeDoF(0, 0, 0, 0)
					end
				end
			end

			walkSpeed = if v80 == 1 then GameConfig.crouchSpeed elseif v80 == 2 then GameConfig.proneSpeed else GameConfig.walkSpeed
		end

		if v70 and (v43 and (v80 == 0 and not v67)) then
			if isForwardDominant() then
				t6.nonFwdTimer = 0

				if not v63 and v61 then
					ToggleSprint(true)
				end

				walkSpeed = GameConfig.sprintSpeed
			else
				t6.nonFwdTimer = t6.nonFwdTimer + p1

				if t6.nonFwdTimer < t6.graceTime and v63 then
					walkSpeed = GameConfig.sprintSpeed
				else
					if v63 then
						v63 = false
						v1:SetAttribute("Sprinting", false)

						if v62 then
							local sprintAnim = v62.sprintAnim

							if t3[sprintAnim] then
								t3[sprintAnim]:Stop(0.2)
								t3[sprintAnim .. "ThirdPerson"]:Stop(0.2)
							end

							if SPH_DoF then
								ChangeDoF(0, 0, 0, 0)
							end
						end
					end

					walkSpeed = GameConfig.walkSpeed * t6.strafeMult
				end
			end
		else
			t6.nonFwdTimer = t6.graceTime
		end

		if v96 then
			local v27 = if v29 then CurrentCamera.WeaponRig.Weapon:FindFirstChildWhichIsA("Model") else v97.Weapon:FindFirstChildWhichIsA("Model")

			if v27 then
				local Muzzle = v27.Grip.Muzzle
				local v302 = workspace:Raycast(Muzzle.WorldPosition, Muzzle.WorldCFrame.LookVector * 600, v5)

				if v302 then
					v96:SetWorldPosition(v302.Position)
				else
					v96:SetWorldPosition(Muzzle.WorldPosition + Muzzle.WorldCFrame.LookVector * 600)
				end
			end
		end

		v86 = if GameConfig.firstPersonBody and v29 then Vector3.new(0, 0, -1.2 + (v1.HumanoidRootPart.CFrame:ToObjectSpace(CurrentCamera.CFrame):ToEulerAngles() + 1.4) / 2.8) else Vector3.new(0, 0, 0)

		local v32 = 0
		local sum = 0
		local Z = v86.Z

		if v80 == 1 then
			sum = -1

			if v29 then
				Z = Z - 0.3
			end
		elseif v80 == 2 then
			sum = -1.5

			if v29 then
				Z = -1.7
			end
		end

		if v88 < 0 then
			v32 = -1
			sum = sum + -0.2
		elseif v88 > 0 then
			v32 = 1
			sum = sum + -0.2
		end

		if not v39 and CurrentCamera.CameraType == Enum.CameraType.Custom then
			v86 = Vector3.new(v32, sum, Z)
			Humanoid.CameraOffset = Humanoid.CameraOffset:Lerp(v86, p1 * 0.1 * 60)
			RootJoint.C1 = RootJoint.C1:Lerp(CFrame.new(-v32 / 2, 0, 0) * CFrame.Angles(1.5707963267948966, math.rad(v88 * 17) + math.pi, 0), p1 * 0.1 * 60)

			local v34 = v89

			v89 = v34 + (-v88 * 15 - v34) * (1 - 0.9 ^ (p1 * 60))

			local v35 = CurrentCamera

			v35.CFrame = v35.CFrame * CFrame.Angles(0, 0, (math.rad(v89)))

			if GameConfig.cameraTilting and v29 then
				local v372 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.Velocity)
				local v382 = UserInputService:GetMouseDelta()
				local v41 = v25

				v25 = v41 + (math.clamp(-v372.X, -2, 2) + v382.X / 2 - v41) * (p1 * 0.07 * 60)

				local v42 = CurrentCamera

				v42.CFrame = v42.CFrame * CFrame.Angles(0, 0, (math.rad(v25)))
			end
		end

		if v61 and CurrentCamera.CameraType == Enum.CameraType.Custom then
			if v29 and not v33 then
				RefreshViewmodel()
				ToggleSprint(v43)
			end

			UpdateViewmodelPosition(p1)

			if v37 then
				LocalPlayer:SetAttribute("rangefinderActive", true)

				local v44 = v64.Grip:FindFirstChild("Laser") or v64[ModTable.laserAtt].Main.Laser
				local v45 = v97.Weapon:FindFirstChildWhichIsA("Model").Grip:FindFirstChild("Laser") or v97.Weapon:FindFirstChildWhichIsA("Model")[ModTable.laserAtt].Main.Laser

				if not v93.Enabled then
					v93.Enabled = true
					v93.Dot.ImageColor3 = v44.Color.Value

					local Color = v44.Color.Value

					Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color), ColorSequenceKeypoint.new(1, Color) })

					if GameConfig.laserTrail then
						FirstPersonLaser.Color = ColorSequence.new(v44.Color.Value)
						ThirdPersonLaser.Color = ColorSequence.new(v44.Color.Value)

						if v29 then
							FirstPersonLaser.Enabled = true
						else
							ThirdPersonLaser.Enabled = true

							if not ThirdPersonLaser.Attachment0 then
								ThirdPersonLaser.Attachment0 = v45
							end
						end
					end
				end

				local v46 = if v29 and v44 then v44 else v45
				local v47 = RaycastParams.new()

				v47.FilterType = Enum.RaycastFilterType.Exclude
				v47.FilterDescendantsInstances = { v64, v1 }
				v47.RespectCanCollide = true

				local v48 = workspace:Raycast(v46.WorldPosition, v46.WorldCFrame.LookVector * 600, v47)

				if v48 then
					Attachment.WorldPosition = v48.Position

					if ModTable.isRangefinder then
						LocalPlayer:SetAttribute("tgtDistance", (v1.Head.Position - v48.Position).Magnitude * 0.28)
					end
				else
					Attachment.WorldPosition = v46.WorldCFrame.LookVector * 600
					LocalPlayer:SetAttribute("tgtDistance", nil)
				end
			elseif v93.Enabled then
				v93.Enabled = false
				FirstPersonLaser.Enabled = false
				ThirdPersonLaser.Enabled = false
				LocalPlayer:SetAttribute("rangefinderActive", false)
			end
		elseif v33 and not v30 then
			v33 = false
		end

		local bobDampening = GameConfig.bobDampening
		local v49 = bobDampening - (bobDampening - bobDampening / (v26 / GameConfig.walkSpeed)) / 2

		if v67 then
			v49 = v49 * GameConfig.aimBobDampening
		end

		local v50 = GameConfig.bobSpeed * (v26 / GameConfig.walkSpeed)

		if not Humanoid.Sit then
			v7:shove(Vector3.new(math.sin(tick() * v50 * 1.3) * 0.3, math.sin(tick() * (v50 / 2) * 1.3) * 0.3, math.sin(tick() * (v50 / 2) * 1.3) * 0.3) / v49 * HumanoidRootPart.Velocity.Magnitude / v49 * p1 * 60)
		end

		local v572 = v7:update(p1)

		AnimBase.CFrame = AnimBase.CFrame:ToWorldSpace(CFrame.new(v572.Y, v572.X, 0) * CFrame.Angles(v572.Y * 0.3, 0, v572.Y * 0.8))

		if GameConfig.cameraMovement and (v29 and (not Humanoid.Sit and (not v39 and CurrentCamera.CameraType == Enum.CameraType.Custom))) then
			local Position = v7.Position
			local v58 = CurrentCamera

			v58.CFrame = v58.CFrame * CFrame.Angles(math.rad(Position.X / GameConfig.cameraBobDampening), math.rad(Position.Y / GameConfig.cameraBobDampening), 0)
		end

		for i, v in ipairs(t4) do
			local Frame = v.SurfaceGui.Frame
			local v632 = Frame:FindFirstChild("Reticle") or Frame:FindFirstChild("Holo")
			local v642 = v.CFrame:PointToObjectSpace(CurrentCamera.CFrame.Position) / v.Size

			v632.Position = UDim2.fromScale(0.5 + v642.X, 0.5 - v642.Y)

			if v632.Name == "Holo" then
				local v65 = CurrentCamera.FieldOfView / 70

				v632.Size = UDim2.fromScale(v65, v65)
			end
		end

		if v67 then
			local FieldOfView = CurrentCamera.FieldOfView

			CurrentCamera.FieldOfView = FieldOfView + (FieldOfView2 - FieldOfView) * (1 - 0.7 ^ (p1 * 60))
		end
	end

	v26 = walkSpeed

	for k, v in pairs(t) do
		v26 = math.min(v26, v)
	end

	if script:GetAttribute("WalkspeedOverrideToggle") then
		local v68 = script:GetAttribute("WalkspeedOverride")

		if type(v68) == "number" then
			v26 = math.min(v26, v68)
		end
	end

	if Humanoid.Health < 30 and GameConfig.lowHealthEffects then
		v26 = v26 * (Humanoid.Health / 30)
	end

	local v702 = if v26 > Humanoid.WalkSpeed then 0.06 else 0.15
	local WalkSpeed = Humanoid.WalkSpeed

	Humanoid.WalkSpeed = WalkSpeed + (v26 - WalkSpeed) * (v702 * p1 * 60)

	if v80 ~= 2 or not GameConfig.proneAngle then
		return
	end

	local v72 = RaycastParams.new()

	v72.FilterType = Enum.RaycastFilterType.Exclude
	v72.FilterDescendantsInstances = { v1 }
	v72.IgnoreWater = true
	v72.RespectCanCollide = true

	local v73 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -2, 0), v72)

	if not (v73 and v73.Instance) then
		return
	end

	local v74 = GetRotationBetween(HumanoidRootPart.CFrame.UpVector, v73.Normal, Vector3.new(1, 0, 0))
	local v75 = RootJoint

	v75.C0 = v75.C0 * CFrame.Angles(v74.X, v74.Y, v74.Z)

	local _ = v74 * HumanoidRootPart.CFrame
end)
UserInputService.InputChanged:Connect(function(p1) --[[ Line: 3232 | Upvalues: v67 (ref), UserInputService (copy), GameConfig (copy), FieldOfView2 (ref), v62 (ref), FieldOfView (copy), v90 (ref), LocalPlayer (copy) ]]
	if not v67 or p1.UserInputType ~= Enum.UserInputType.MouseWheel then
		return
	end

	if UserInputService:IsKeyDown(GameConfig.holdForScrollZoom) then
		FieldOfView2 = math.clamp(FieldOfView2 - p1.Position.Z * 3, v62.aimFovMin, v62.aimFovMax or FieldOfView)
	else
		v90 = math.clamp(v90 - 0.01 * -p1.Position.Z, 0.005, 1)
		UserInputService.MouseDeltaSensitivity = v90
		LocalPlayer:SetAttribute("SavedAimSensitivity", v90)
	end
end)
Humanoid.Seated:Connect(function(p1, p2) --[[ Line: 3247 | Upvalues: ContextActionService (copy), v63 (ref), v1 (copy), v62 (ref), t3 (copy), SPH_DoF (copy), ChangeDoF (copy), GameConfig (copy), v88 (ref), PlayCharSound (copy), v23 (copy), v80 (ref), ChangeStance (copy), v39 (ref), v61 (ref), Humanoid (copy), BindCharacterInputs (copy) ]]
	if p1 then
		ContextActionService:UnbindAction("SPH_Sprint")
		ContextActionService:UnbindAction("SPH_StanceLower")
		ContextActionService:UnbindAction("SPH_StanceRaise")
		ContextActionService:UnbindAction("SPH_LeanLeft")
		ContextActionService:UnbindAction("SPH_LeanRight")
		v63 = false
		v1:SetAttribute("Sprinting", false)

		if v62 then
			local sprintAnim = v62.sprintAnim

			if t3[sprintAnim] then
				t3[sprintAnim]:Stop(0.2)
				t3[sprintAnim .. "ThirdPerson"]:Stop(0.2)
			end

			if SPH_DoF then
				ChangeDoF(0, 0, 0, 0)
			end
		end

		if GameConfig.canLean then
			if v88 ~= 0 then
				PlayCharSound("Lean")
			end

			v88 = 0
			v23:Fire(0)
		end

		if v80 == 1 then
			ChangeStance(-1)
		elseif v80 == 2 then
			ChangeStance(-1)
			ChangeStance(-1)
		end

		if not p2:IsA("VehicleSeat") then
			v39 = false

			return
		end

		v39 = true

		if v61 then
			Humanoid:UnequipTools()
		end
	else
		BindCharacterInputs()
		v39 = false
	end
end)

local v102 = true

UserInputService.JumpRequest:Connect(function() --[[ Line: 3275 | Upvalues: Humanoid (copy), v1 (copy), v80 (ref), v102 (ref), GameConfig (copy) ]]
	if Humanoid.Sit then
		v1.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

		return
	end

	if v80 ~= 0 then
		v1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

		return
	end

	if v1.Humanoid.FloorMaterial == Enum.Material.Air then
		return
	end

	if v102 then
		v102 = false
		v1.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		task.wait(GameConfig.jumpCooldown)
		v102 = true
	else
		v1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	end
end)