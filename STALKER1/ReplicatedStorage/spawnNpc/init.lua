-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

ReplicatedStorage:WaitForChild("SPH_Assets")

local NPC_WeaponRig = require(script.NPC_WeaponRig)

require(script.NPC_Ammo)

local NPC_Combat = require(script.NPC_Combat)
local NPC_Movement = require(script.NPC_Movement)
local t2 = {
	MILITARY_FACTION = {
		IdealMinRange = 30,
		IdealMaxRange = 300,
		TARGET_UPDATE_RATE = 0.5,
		NoLOSOverrideTime = 11,
		StrafeInterval = 1.8,
		GiveupTime = 150
	}
}

local function RunNPCAI(p1) --[[ RunNPCAI | Line: 48 | Upvalues: NPC_WeaponRig (copy), NPC_Combat (copy), NPC_Movement (copy), RunService (copy), Players (copy) ]]
	local Humanoid = p1:WaitForChild("Humanoid")
	local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")
	local v1 = tick()
	local npcConfig = require(p1:WaitForChild("npcConfig"))
	local t = {}
	local v2 = true
	local v3 = false

	repeat
		task.wait()
	until p1:FindFirstChildOfClass("Tool")

	local Tool = p1:FindFirstChildOfClass("Tool")
	local WeaponStats = require(Tool.SPH_Weapon:WaitForChild("WeaponStats"))
	local v4 = p1:FindFirstChild("WeaponRig").Weapon:FindFirstChildWhichIsA("Model")
	local Torso = p1:WaitForChild("Torso")
	local Neck = Torso:WaitForChild("Neck")
	local t2 = {}

	t2.idle = WeaponStats.idleAnim and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.idleAnim, Enum.AnimationPriority.Idle) or nil
	t2.sprint = WeaponStats.sprintAnim and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.sprintAnim, Enum.AnimationPriority.Movement) or nil
	t2.reload = WeaponStats.reloadAnim and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.reloadAnim, Enum.AnimationPriority.Action) or nil
	t2.boltChamber = WeaponStats.boltChamber and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.boltChamber, Enum.AnimationPriority.Action) or nil
	t2.boltClose = WeaponStats.boltClose and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.boltClose, Enum.AnimationPriority.Action) or nil
	t2.boltOpen = WeaponStats.boltOpen and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.boltOpen, Enum.AnimationPriority.Action) or nil
	t2.clipReload = WeaponStats.clipReloadAnim and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.clipReloadAnim, Enum.AnimationPriority.Action) or nil
	t2.equip = WeaponStats.equipAnim and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.equipAnim, Enum.AnimationPriority.Action) or nil
	t2.fireAnim = WeaponStats.fireAnim and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.fireAnim, Enum.AnimationPriority.Action2) or nil
	t2.aim = WeaponStats.aimAnim and NPC_WeaponRig.LoadAnimTrack(p1, WeaponStats.aimAnim, Enum.AnimationPriority.Action) or nil

	local function setTrack(p1, p2, p3) --[[ setTrack | Line: 80 ]]
		if not p1 then
			return
		end

		if p2 then
			p1.Looped = true

			if not p1.IsPlaying then
				p1:Play(p3 or 0.15, 1, 1)
			end
		else
			if not p1.IsPlaying then
				return
			end

			p1:Stop(p3 or 0.15)
		end
	end

	local idle = t2.idle

	if idle then
		idle.Looped = true

		if not idle.IsPlaying then
			idle:Play(0.15, 1, 1)
		end
	end

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and v:CanSetNetworkOwnership() == true then
			v:SetNetworkOwner(nil)
		end
	end

	local v15 = RaycastParams.new()

	v15.FilterType = Enum.RaycastFilterType.Exclude

	local Attachment = Instance.new("Attachment")

	Attachment.Parent = HumanoidRootPart

	local Attachment2 = Instance.new("Attachment")

	Attachment2.Parent = workspace.Terrain

	local AlignOrientation = Instance.new("AlignOrientation")

	AlignOrientation.Attachment0 = Attachment
	AlignOrientation.Attachment1 = Attachment2
	AlignOrientation.RigidityEnabled = false
	AlignOrientation.MaxTorque = 1000000
	AlignOrientation.MaxAngularVelocity = (1 / 0)
	AlignOrientation.Responsiveness = 20
	AlignOrientation.Parent = HumanoidRootPart
	AlignOrientation.Enabled = false

	local t3 = {
		IsActive = true,
		NPC = p1,
		CharacterAsset = p1,
		Humanoid = Humanoid,
		HumanoidRootPart = HumanoidRootPart,
		Weapon = Tool,
		wepStats = WeaponStats,
		npcConfig = npcConfig,
		gunModel = v4,
		muzzle = v4.Grip.Muzzle,
		tracks = t2,
		alignOrientation = AlignOrientation,
		targetAttachment = Attachment2,
		setTrack = setTrack
	}
	local v16 = NPC_Combat.New(t3)
	local v17 = NPC_Movement.New(t3)

	local function CheckAlly(p1) --[[ CheckAlly | Line: 136 | Upvalues: npcConfig (copy) ]]
		local AllyTag = npcConfig.AllyTag

		if not AllyTag or AllyTag == "" then
			return false
		end

		if game.Players:FindFirstChild(p1.Name) then
			return false
		end

		local v1 = p1:GetAttribute("AllyTag")

		return if v1 == AllyTag then v1 ~= "" else false
	end

	local function HandleDeath() --[[ HandleDeath | Line: 144 | Upvalues: Humanoid (copy), AlignOrientation (copy), v2 (ref), t3 (copy), Neck (copy), t2 (copy), p1 (copy), t (copy), NPC_WeaponRig (ref) ]]
		if not (Humanoid.Health <= 0) then
			return
		end

		AlignOrientation.Enabled = false
		Humanoid.AutoRotate = true
		v2 = false
		t3.IsActive = false
		Neck.C1 = CFrame.new(0, -0.5, 0) * CFrame.Angles(-1.5707963267948966, 0, math.pi)

		local aim = t2.aim

		if aim and aim.IsPlaying then
			aim:Stop(0.15)
		end

		local idle = t2.idle

		if idle and idle.IsPlaying then
			idle:Stop(0.15)
		end

		local WeaponRig = p1:FindFirstChild("WeaponRig")

		if WeaponRig then
			for i, v in ipairs({ "raw", "law" }) do
				local v1 = WeaponRig:FindFirstChild(v)

				if v1 then
					v1:Destroy()
				end
			end
		end

		for i, v in ipairs(t) do
			pcall(function() --[[ Line: 167 | Upvalues: v (copy) ]]
				v:Disconnect()
			end)
		end

		NPC_WeaponRig.ClearAnimCache(p1)
	end

	local function AlertedHandler() --[[ AlertedHandler | Line: 173 | Upvalues: p1 (copy), v2 (ref), npcConfig (copy), v17 (copy), CheckAlly (copy), v16 (copy), v1 (ref), v15 (copy), HumanoidRootPart (copy), v3 (ref), t3 (copy) ]]
		if p1.Alerted.Value == true then
			local v12 = "idle"
			local v22 = 0
			local v32 = 0
			local v4 = 0

			local function TransitionTo(p1) --[[ TransitionTo | Line: 194 | Upvalues: v12 (ref) ]]
				if v12 == p1 then
					return
				end

				v12 = p1
			end

			task.spawn(function() --[[ Line: 200 | Upvalues: v2 (ref), p1 (ref), v4 (ref), npcConfig (ref), v17 (ref), CheckAlly (ref), v12 (ref), v16 (ref), v1 (ref), v15 (ref), HumanoidRootPart (ref), v3 (ref), v22 (ref), t3 (ref), v32 (ref) ]]
				while v2 and p1.Alerted.Value do
					local v13 = task.wait(0.1)

					if not p1.Parent then
						break
					end

					v4 = v4 + (v13 or 0.1)

					if v4 >= npcConfig.TARGET_UPDATE_RATE then
						v4 = 0

						local v23 = v17.FindNearestTarget(true, CheckAlly)

						if v23 == nil then
							local v33 = p1:GetAttribute("_RetaliateUntil")
							local Target = p1.Target.Value

							if v33 and (os.clock() < v33 and (Target and (Target.Parent and Target:FindFirstChild("Humanoid")))) and Target.Humanoid.Health > 0 then
								v23 = Target
							end
						end

						if v23 ~= p1.Target.Value then
							p1.Target.Value = v23

							if v12 == "aiming" or v12 == "firing" then
								if v12 ~= "idle" then
									v12 = "idle"
								end

								v16.StopAiming()
							end
						end
					end

					local Target = p1.Target.Value
					local v42 = if Target then Target:FindFirstChild("HumanoidRootPart") and (if Target.Humanoid.Health > 0 then true else false) else Target

					if v42 and (v12 == "aiming" or v12 == "firing") then
						v16.UpdateFacing(Target.HumanoidRootPart.Position)
					end

					if v42 then
						local v5 = v17.GetDistToTarget()
						local _ = tick() - v1 > npcConfig.NoLOSOverrideTime
						local v6 = v16.GetWeaponState()

						v15.FilterDescendantsInstances = { p1, Target }
						v3 = if workspace:Raycast(p1.Head.Position, Target.HumanoidRootPart.Position - HumanoidRootPart.Position, v15) == nil then true else false

						if v3 then
							v1 = tick()
						end

						if v12 == "reloading" then
							if not (v16.IsReloading() or v16.IsChamberingBolt()) then
								v16.StopAiming()

								if v12 ~= "idle" then
									v12 = "idle"
								end
							end

							v16.UpdateFacing(Target.HumanoidRootPart.Position)

							if v5 < v17.IdealMinRange then
								v17.WalkTo(HumanoidRootPart.Position + (HumanoidRootPart.Position - Target.HumanoidRootPart.Position).Unit * 15, false)
							end

							continue
						end

						if v6 == "needsReload" and not v16.IsReloading() then
							if v12 ~= "reloading" then
								v12 = "reloading"
							end

							v16.StopAiming(true)
							task.spawn(function() --[[ Line: 296 | Upvalues: v16 (ref) ]]
								v16.PerformReload()
							end)

							continue
						end

						if v6 == "needsChamber" and not v16.IsChamberingBolt() then
							if v12 ~= "reloading" then
								v12 = "reloading"
							end

							task.spawn(function() --[[ Line: 302 | Upvalues: v16 (ref) ]]
								v16.PerformChamber()
							end)

							continue
						end

						if v12 == "aiming" then
							if not v16.IsAiming() and (not v16.HasAimed() and v12 ~= "idle") then
								v12 = "idle"
							end

							if v16.HasAimed() and v12 ~= "firing" then
								v12 = "firing"
							end

							continue
						end

						if v12 == "firing" then
							if v3 then
								if v5 < v17.TooCloseRange then
									if v12 ~= "retreating" then
										v12 = "retreating"
									end

									v16.StopAiming(true)

									continue
								end

								v16.ShootGun()

								if npcConfig.CanStrafe then
									v22 = v22 + 0.1

									if not (v22 >= npcConfig.StrafeInterval) then
										continue
									end

									v22 = 0
									v17.Strafe()
								end

								continue
							end

							if v12 ~= "pathing" then
								v12 = "pathing"
							end

							v16.StopAiming()

							continue
						end

						if v5 < v17.TooCloseRange then
							if v12 ~= "retreating" then
								v12 = "retreating"
							end
						elseif v3 and not (v17.IdealMaxRange < v5) then
							if v3 and v5 <= v17.IdealMaxRange then
								if v12 ~= "aiming" then
									v12 = "aiming"
								end

								task.spawn(function() --[[ Line: 351 | Upvalues: v16 (ref) ]]
									v16.Aim()
								end)
							end
						else
							if v12 ~= "pathing" then
								v12 = "pathing"
							end

							if npcConfig.CanShootWhileMoving and v3 then
								t3.alignOrientation.Enabled = true
								t3.Humanoid.AutoRotate = false
							end
						end

						if v12 == "retreating" then
							v17.WalkTo(HumanoidRootPart.Position + (HumanoidRootPart.Position - Target.HumanoidRootPart.Position).Unit * 15, false)

							if v17.TooCloseRange <= v5 and v12 ~= "idle" then
								v12 = "idle"
							end

							if npcConfig.CanShootWhileMoving and v3 then
								v16.UpdateFacing(Target.HumanoidRootPart.Position)
								v16.ShootGunWhileMoving()
							end

							continue
						end

						if v12 == "pathing" then
							if v3 and (v5 <= v17.IdealMaxRange and v17.TooCloseRange <= v5) then
								v17.StopMoving()

								if v12 ~= "idle" then
									v12 = "idle"
								end
							elseif v3 then
								v17.WalkTo(Target.HumanoidRootPart.Position, true)
							elseif tick() - v32 > 3 then
								v32 = tick()

								local v8 = v17.FindFlankPosition()

								v17.WalkTo(if v8 then v8 else Target.HumanoidRootPart.Position, true)
							else
								v17.WalkTo(Target.HumanoidRootPart.Position, true)
							end

							if npcConfig.CanShootWhileMoving and v3 then
								v16.UpdateFacing(Target.HumanoidRootPart.Position)
								v16.ShootGunWhileMoving()
							end

							continue
						end

						if v12 == "firing" or v12 == "aiming" then
							if v17.IdealMaxRange < v5 then
								v17.WalkTo(Target.HumanoidRootPart.Position, true)

								continue
							end

							v17.StopMoving()
						end

						continue
					end

					if v12 == "idle" then
						continue
					end

					if v12 ~= "idle" then
						v12 = "idle"
					end

					v16.StopAiming()
					v17.StopMoving()
				end

				v16.StopAiming()
				v17.StopMoving()
			end)
		end
	end

	table.insert(t, Humanoid:GetPropertyChangedSignal("Health"):Connect(HandleDeath))
	table.insert(t, RunService.Heartbeat:Connect(function(p12) --[[ Line: 400 | Upvalues: v2 (ref), p1 (copy), Neck (copy), HumanoidRootPart (copy), Torso (copy), v16 (copy) ]]
		if not v2 then
			return
		end

		if not p1.Parent then
			return
		end

		if p1.Target.Value == nil or not p1.Target.Value:FindFirstChild("HumanoidRootPart") then
			Neck.C1 = Neck.C1:Lerp(CFrame.new(0, -0.5, 0) * CFrame.Angles(-1.5707963267948966, 0, math.pi), 0.1)
		else
			local v22 = math.clamp((p1.Target.Value.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit.Y, -0.8, 0.15)
			local v3 = math.clamp(Torso.CFrame.LookVector.Y, -0.6, 0.6)
			local v4, v5 = v16.DecayRecoil(p12)
			local v6 = CFrame.Angles(-math.asin(v22) + math.asin(v3) - math.rad(v4), math.rad(v5), 0)

			Neck.C1 = Neck.C1:Lerp(CFrame.new(0, -0.5, 0) * v6 * CFrame.Angles(-1.5707963267948966, 0, math.pi), 0.1 * p12 * 60)
		end
	end))

	local v19 = nil
	local Target = p1:FindFirstChild("Target")

	if Target then
		table.insert(t, Target.Changed:Connect(function() --[[ Line: 428 | Upvalues: v19 (ref), p1 (copy) ]]
			if v19 then
				v19:Disconnect()
				v19 = nil
			end

			local Target = p1.Target.Value

			if not (Target and Target:FindFirstChild("Humanoid")) then
				return
			end

			v19 = Target.Humanoid.Died:Connect(function() --[[ Line: 432 | Upvalues: p1 (ref) ]]
				task.wait(0.25)

				if not p1.Parent then
					return
				end

				p1.Target.Value = nil
			end)
		end))
	end

	table.insert(t, Humanoid.Died:Connect(HandleDeath))
	AlertedHandler()
	table.insert(t, p1.Alerted.Changed:Connect(function() --[[ Line: 444 | Upvalues: p1 (copy), AlertedHandler (copy), npcConfig (copy), v16 (copy), v17 (copy) ]]
		if not p1.Parent then
			return
		end

		task.wait(0.35)

		if not p1.Parent then
			return
		end

		AlertedHandler()

		if p1.Alerted.Value ~= true then
			return
		end

		task.wait(npcConfig.GiveupTime)

		if not p1.Parent then
			return
		end

		if not p1:FindFirstChild("Alerted") then
			return
		end

		p1.Alerted.Value = false

		if p1:FindFirstChild("Target") then
			p1.Target.Value = nil
		end

		v16.StopAiming()
		v17.StopMoving()
	end))
	table.insert(t, Players.PlayerRemoving:Connect(function(p12) --[[ Line: 466 | Upvalues: p1 (copy), v16 (copy), v17 (copy) ]]
		if not p1.Parent then
			return
		end

		if p1.Target.Value == nil or p1.Target.Value.Name ~= p12.Name then
			return
		end

		p1.Target.Value = nil
		v16.StopAiming()
		v17.StopMoving()
	end))
end

function t.SpawnHostileNPC(p1, p2, p3, p4, p5) --[[ SpawnHostileNPC | Line: 476 | Upvalues: ReplicatedStorage (copy), t2 (copy), NPC_WeaponRig (copy), RunNPCAI (copy) ]]
	local v1 = ReplicatedStorage.HostileNPC:Clone()
	local npcConfig = require(v1:WaitForChild("npcConfig"))

	npcConfig.AllyTag = p4 or ""
	npcConfig.AttacksNPCs = if p3 == true then true else false

	local v3 = t2[p4 or ""]

	if v3 then
		for k, v in pairs(v3) do
			npcConfig[k] = v
		end
	end

	v1:SetAttribute("HostileNPC", true)
	v1:SetAttribute("AllyTag", p4 or "")
	task.wait()

	if not v1:FindFirstChild("Animate") then
		return nil
	end

	NPC_WeaponRig.EquipGunOnRig(v1, p2)
	v1.Parent = workspace
	v1.HumanoidRootPart.CFrame = p1.CFrame

	if p5 == true then
		v1.Alerted.Value = true
	end

	task.spawn(RunNPCAI, v1)

	return v1
end

return t