-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local serverSideShoot = require(ReplicatedStorage.openSphMod.serverSideShoot)
local NPC_Ammo = require(script.Parent.NPC_Ammo)

game:GetService("Players")

local v1 = nil

local function getSuppressionRemote() --[[ getSuppressionRemote | Line: 27 | Upvalues: v1 (ref) ]]
	if v1 and v1.Parent then
		return v1
	end

	local miscEvents = game:GetService("ReplicatedStorage"):FindFirstChild("miscEvents")

	v1 = if miscEvents then miscEvents:FindFirstChild("npcSuppression") or nil else nil

	return v1
end

local t2 = {
	burst = 0.6,
	semi = 0.25,
	fullauto = 0.15
}
local t3 = {
	Bandit = 2,
	Military = 1.1,
	Loner = 1.3
}
local t4 = {
	BANDIT_FACTION = "Bandit",
	MILITARY_FACTION = "Military",
	LONER_FACTION = "Loner"
}
local t5 = {
	"semi",
	"fullauto",
	"burst",
	"semi"
}

local function ensureRigIdlePlaying(p1) --[[ ensureRigIdlePlaying | Line: 69 ]]
	if not (p1.NPC and p1.NPC.Parent) then
		return
	end

	local WeaponRig = p1.NPC:FindFirstChild("WeaponRig")

	if not WeaponRig then
		return
	end

	local AnimationController = WeaponRig:FindFirstChildOfClass("AnimationController")
	local v1 = if AnimationController then AnimationController:FindFirstChildOfClass("Animator") else AnimationController

	if not v1 then
		return
	end

	for i, v in ipairs(v1:GetPlayingAnimationTracks()) do
		if v.Priority == Enum.AnimationPriority.Idle and v.WeightCurrent > 0.01 then
			return
		end
	end

	local v2 = p1.wepStats and p1.wepStats.idleAnim

	if not v2 then
		return
	end

	local v3 = require(game.ReplicatedStorage:WaitForChild("spawnNpc"):WaitForChild("NPC_WeaponRig")).LoadAnimTrack(p1.NPC, v2, Enum.AnimationPriority.Idle)

	if not v3 then
		return
	end

	v3.Looped = true
	v3:Play(0.15)
end

local function pickFireMode(p1) --[[ pickFireMode | Line: 89 | Upvalues: t5 (copy), t2 (copy) ]]
	local list = {}
	local v1 = if p1 then p1.fireSwitch else p1

	if v1 then
		for i, v in ipairs(v1) do
			if v then
				local v2 = t5[i]

				if v2 and not table.find(list, v2) then
					table.insert(list, v2)
				end
			end
		end
	end

	if #list == 0 then
		list = { "semi" }
	end

	if #list == 1 then
		return list[1]
	end

	local sum = 0

	for i, v in ipairs(list) do
		sum = sum + (t2[v] or 0)
	end

	if sum <= 0 then
		return list[1]
	end

	local v3 = math.random() * sum
	local sum2 = 0

	for i, v in ipairs(list) do
		sum2 = sum2 + (t2[v] or 0)

		if v3 <= sum2 then
			return v
		end
	end

	return list[1]
end

function t.New(p1) --[[ New | Line: 119 | Upvalues: pickFireMode (copy), ensureRigIdlePlaying (copy), t4 (copy), t3 (copy), NPC_Ammo (copy), serverSideShoot (copy) ]]
	local t = {}
	local npcConfig = p1.npcConfig
	local v1 = pickFireMode(p1.wepStats)

	ensureRigIdlePlaying(p1)
	task.delay(0.1, function() --[[ Line: 129 | Upvalues: ensureRigIdlePlaying (ref), p1 (copy) ]]
		ensureRigIdlePlaying(p1)
	end)
	task.delay(0.5, function() --[[ Line: 130 | Upvalues: ensureRigIdlePlaying (ref), p1 (copy) ]]
		ensureRigIdlePlaying(p1)
	end)
	task.spawn(function() --[[ Line: 135 | Upvalues: p1 (copy), ensureRigIdlePlaying (ref) ]]
		while p1.NPC and p1.NPC.Parent do
			task.wait(0.25)

			if not (p1.NPC and p1.NPC.Parent) then
				break
			end

			if p1.Humanoid and p1.Humanoid.Health <= 0 then
				break
			end

			ensureRigIdlePlaying(p1)
		end
	end)

	local v2 = t4
	local v4 = v2[p1.NPC and p1.NPC:GetAttribute("AllyTag") or ""]

	if v4 == "Loner" or v4 == "Bandit" then
		local v5 = p1.Weapon and p1.Weapon:FindFirstChild("Ammo")
		local v6 = v5 and v5:FindFirstChild("ArcadeAmmoPool")

		if v6 then
			v6.MaxValue = 999999
			v6.Value = 999999
		end
	end

	local Lighting = game:GetService("Lighting")

	local function isNight() --[[ isNight | Line: 166 | Upvalues: Lighting (copy) ]]
		return if Lighting.ClockTime > 18 then true else Lighting.ClockTime < 6
	end

	local v7 = nil

	local function setArmsGunShadows(p12) --[[ setArmsGunShadows | Line: 168 | Upvalues: v7 (ref), p1 (copy) ]]
		if v7 == p12 then
			return
		end

		v7 = p12

		for i, v in ipairs({ "Right Arm", "Left Arm" }) do
			local v1 = p1.NPC:FindFirstChild(v)

			if v1 and v1:IsA("BasePart") then
				v1.CastShadow = p12
			end
		end

		if not p1.gunModel then
			return
		end

		for i, v in ipairs(p1.gunModel:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CastShadow = p12
			end
		end
	end

	local function refresh() --[[ refresh | Line: 181 | Upvalues: p1 (copy), setArmsGunShadows (copy), Lighting (copy) ]]
		if not p1.NPC.Parent then
			return
		end

		setArmsGunShadows(not (p1.NPC.Alerted.Value and (if Lighting.ClockTime > 18 then true else Lighting.ClockTime < 6)))
	end

	task.delay(1, refresh)
	p1.NPC.Alerted.Changed:Connect(refresh)
	task.spawn(function() --[[ Line: 188 | Upvalues: p1 (copy), setArmsGunShadows (copy), Lighting (copy) ]]
		while p1.NPC.Parent do
			task.wait(5)

			if not p1.NPC.Parent then
				continue
			end

			setArmsGunShadows(not (p1.NPC.Alerted.Value and (if Lighting.ClockTime > 18 then true else Lighting.ClockTime < 6)))
		end
	end)

	local v8 = 0
	local v9 = 0

	local function startBurst() --[[ startBurst | Line: 197 | Upvalues: v1 (copy), v8 (ref) ]]
		if v1 == "semi" then
			v8 = 1

			return
		end

		v8 = if v1 == "fullauto" then math.random(8, 14) else math.random(3, 5)
	end

	local function endBurst() --[[ endBurst | Line: 202 | Upvalues: v8 (ref), v1 (copy), v9 (ref) ]]
		v8 = 0

		local v12, v2

		if v1 == "semi" then
			v12 = 0.3
			v2 = 0.6
		elseif v1 == "fullauto" then
			v12 = 0.2
			v2 = 0.45
		else
			v12 = 0.4
			v2 = 0.8
		end

		v9 = os.clock() + v12 + math.random() * (v2 - v12)
	end

	local function getAccuracyMult() --[[ getAccuracyMult | Line: 210 | Upvalues: v1 (copy) ]]
		if v1 == "semi" then
			return 0.5
		end

		if v1 == "fullauto" then
			return 1.6
		end

		return 1
	end

	local function burstGate() --[[ burstGate | Line: 215 | Upvalues: v9 (ref), v8 (ref), v1 (copy) ]]
		if os.clock() < v9 then
			return false
		end

		if not (v8 <= 0) then
			return true
		end

		v8 = if v1 == "semi" then 1 elseif v1 == "fullauto" then math.random(8, 14) else math.random(3, 5)

		return true
	end

	local function burstAfterShot() --[[ burstAfterShot | Line: 220 | Upvalues: v8 (ref), v1 (copy), v9 (ref) ]]
		v8 = v8 - 1

		if not (v8 <= 0) then
			return
		end

		v8 = 0

		local v12, v2

		if v1 == "semi" then
			v12 = 0.3
			v2 = 0.6
		elseif v1 == "fullauto" then
			v12 = 0.2
			v2 = 0.45
		else
			v12 = 0.4
			v2 = 0.8
		end

		v9 = os.clock() + v12 + math.random() * (v2 - v12)
	end

	local function getFactionMult() --[[ getFactionMult | Line: 225 | Upvalues: p1 (copy), t4 (ref), t3 (ref) ]]
		local v2 = t4[if p1.NPC then p1.NPC:GetAttribute("AllyTag") or "" else ""]

		return if v2 then t3[v2] or 1 else 1
	end

	local v10 = nil

	local function getRankMult() --[[ getRankMult | Line: 236 | Upvalues: p1 (copy), v10 (ref) ]]
		local v1 = p1.NPC and p1.NPC:GetAttribute("Rank")

		if not v1 then
			return 1
		end

		if not v10 then
			local ok, result = pcall(require, game:GetService("ServerScriptService"):WaitForChild("NPCConfig"))

			if ok then
				v10 = result
			end
		end

		local v2 = v10 and (v10.Ranks and v10.Ranks[v1])

		return if v2 then v2.AccuracyMult or 1 else 1
	end

	local function getHeadshotChance() --[[ getHeadshotChance | Line: 248 | Upvalues: p1 (copy), v10 (ref) ]]
		local v1 = p1.NPC and p1.NPC:GetAttribute("Rank")

		if not v1 then
			return 0
		end

		if not v10 then
			local ok, result = pcall(require, game:GetService("ServerScriptService"):WaitForChild("NPCConfig"))

			if ok then
				v10 = result
			end
		end

		local v2 = v10 and (v10.Ranks and v10.Ranks[v1])

		return if v2 then v2.HeadshotChance or 0 else 0
	end

	local Health = p1.Humanoid.Health
	local v11 = 0

	p1.Humanoid.HealthChanged:Connect(function(p12) --[[ Line: 270 | Upvalues: Health (ref), p1 (copy), v11 (ref) ]]
		if p12 < Health - 0.01 then
			p1.NPC:SetAttribute("_SuppressedUntil", os.clock() + 2)

			local v1 = os.clock()

			if v1 - v11 >= 0.2 then
				v11 = v1
				pcall(function() --[[ Line: 276 | Upvalues: p1 (ref) ]]
					require(game:GetService("ServerScriptService"):WaitForChild("NPCVoicelines")).Play(p1.NPC, "Hit")
				end)

				local Torso = p1.NPC:FindFirstChild("Torso")
				local v2 = if Torso then Torso:FindFirstChild("Neck") else Torso

				if v2 then
					local v3 = if math.random(2) == 1 then 1 else -1
					local v5 = math.rad((math.random(0, 14))) * v3

					v2.C1 = v2.C1 * CFrame.Angles(math.rad(18 + math.random(-3, 3)), v5, 0)
				end
			end
		end

		Health = p12
	end)

	local function isSuppressed() --[[ isSuppressed | Line: 294 | Upvalues: p1 (copy) ]]
		local v1 = p1.NPC:GetAttribute("_SuppressedUntil")

		return if v1 == nil then false else os.clock() < v1
	end

	local function playMuzzleFx() --[[ playMuzzleFx | Line: 307 | Upvalues: p1 (copy) ]]
		local muzzle = p1.muzzle

		if not muzzle then
			return
		end

		local v1 = math.random(10) <= 7

		for i, v in ipairs(muzzle:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				if v:GetAttribute("EmitNumber") then
					if string.find(v.Name, "Flash") then
						if v1 then
							v:Emit(v:GetAttribute("EmitNumber"))
						end

						continue
					end

					v:Emit(v:GetAttribute("EmitNumber"))

					continue
				end

				if v:FindFirstChild("Particles") then
					if not string.find(v.Name, "Flash") or v1 then
						v:Emit(v.Particles.Value)
					end

					continue
				end

				if v.Name == "Smoke" then
					v:Emit(10)

					continue
				end

				if v.Name == "Flash" and v1 then
					v:Emit(5)
				end

				continue
			end

			if v:IsA("Light") and v1 then
				v.Enabled = true
				task.delay(0.05, function() --[[ Line: 330 | Upvalues: v (copy) ]]
					if not (v and v.Parent) then
						return
					end

					v.Enabled = false
				end)
			end
		end

		local Chamber = muzzle:FindFirstChild("Chamber")

		if not Chamber then
			return
		end

		for i, v in ipairs(Chamber:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				if v:GetAttribute("EmitNumber") then
					v:Emit(v:GetAttribute("EmitNumber"))

					continue
				end

				if v.Name == "Smoke" then
					v:Emit(10)

					continue
				end

				if v.Name == "Flash" and v1 then
					v:Emit(5)
				end
			end
		end
	end

	local function pickSoundFrom(p1) --[[ pickSoundFrom | Line: 352 ]]
		if not p1 or #p1:GetChildren() == 0 then
			return nil
		end

		local v1 = p1:GetChildren()

		for i = 1, 4 do
			local v2 = v1[math.random(1, #v1)]

			if v2 and v2:IsA("Sound") then
				return v2
			end
		end

		return nil
	end

	local function playLayer(p12, p2) --[[ playLayer | Line: 363 | Upvalues: p1 (copy) ]]
		if not p12 then
			return
		end

		local v1 = p12:Clone()

		v1.Name = p12.Name .. p2
		v1.PlaybackSpeed = p12.PlaybackSpeed + math.random(-5, 5) / 100
		v1.Parent = p1.muzzle
		v1:Play()

		local Debris = game:GetService("Debris")
		local v3, v4

		if v1.TimeLength > 0 then
			v3 = v1.TimeLength

			if v3 then
				v4 = v1
			else
				v3 = 1
				v4 = v1
			end
		else
			v3 = 1
			v4 = v1
		end

		Debris:AddItem(v4, (math.max(0.5, v3 + 0.5)))
	end

	local function playFireSound() --[[ playFireSound | Line: 376 | Upvalues: p1 (copy), playLayer (copy), pickSoundFrom (copy) ]]
		local gunModel = p1.gunModel

		if not gunModel then
			return
		end

		local v1 = gunModel:FindFirstChild("Grip") or gunModel:FindFirstChild("Base")

		if not v1 then
			return
		end

		local v2 = p1.NPC and p1.NPC:GetAttribute("Suppressed")
		local v3 = if v2 then v1:FindFirstChild("SuppressorSounds") else nil

		if not v3 or #v3:GetChildren() == 0 then
			v3 = v1:FindFirstChild("FireSounds")
		end

		playLayer(pickSoundFrom(v3), if v2 then "_NPCSup" else "_NPCFire")

		if v2 then
			return
		end

		playLayer(pickSoundFrom(v1:FindFirstChild("BassSounds")), "_NPCBass")
		playLayer(pickSoundFrom(v1:FindFirstChild("MediumSounds")), "_NPCMed")
		playLayer(pickSoundFrom(v1:FindFirstChild("FarSounds")), "_NPCFar")
		playLayer(pickSoundFrom(v1:FindFirstChild("TailSounds")), "_NPCTail")
	end

	local v12 = false
	local v13 = false
	local v14 = false
	local v15 = false
	local v16 = 0
	local v17 = 0
	local v18 = 0
	local v19 = p1.wepStats.fireRate and p1.wepStats.fireRate > 0 and 60 / p1.wepStats.fireRate or 0.1

	function t.IsReloading() --[[ IsReloading | Line: 411 | Upvalues: v14 (ref) ]]
		return v14
	end
	function t.IsChamberingBolt() --[[ IsChamberingBolt | Line: 412 | Upvalues: v15 (ref) ]]
		return v15
	end
	function t.IsAiming() --[[ IsAiming | Line: 413 | Upvalues: v12 (ref) ]]
		return v12
	end
	function t.HasAimed() --[[ HasAimed | Line: 414 | Upvalues: v13 (ref) ]]
		return v13
	end
	function t.GetRecoil() --[[ GetRecoil | Line: 415 | Upvalues: v17 (ref), v18 (ref) ]]
		return v17, v18
	end
	function t.SetRecoil(p1, p2) --[[ SetRecoil | Line: 416 | Upvalues: v17 (ref), v18 (ref) ]]
		v17 = p1
		v18 = p2
	end
	function t.GetWeaponState() --[[ GetWeaponState | Line: 418 | Upvalues: NPC_Ammo (ref), p1 (copy), v14 (ref), v15 (ref) ]]
		if NPC_Ammo.NeedsReload(p1.Weapon, p1.wepStats) then
			return "needsReload"
		end

		if NPC_Ammo.NeedsChamber(p1.Weapon, p1.wepStats, v14, v15) then
			return "needsChamber"
		end

		if NPC_Ammo.IsGunLoaded(p1.Weapon, p1.wepStats) then
			return "ready"
		end

		return "empty"
	end
	function t.UpdateFacing(p12) --[[ UpdateFacing | Line: 425 | Upvalues: p1 (copy) ]]
		p1.targetAttachment.WorldCFrame = CFrame.lookAt(p1.HumanoidRootPart.Position, (Vector3.new(p12.X, p1.HumanoidRootPart.Position.Y, p12.Z)))
	end

	local function GetMuzzleAngleToTarget(p12) --[[ GetMuzzleAngleToTarget | Line: 430 | Upvalues: p1 (copy) ]]
		local WorldCFrame = p1.muzzle.WorldCFrame
		local v1 = p12 - WorldCFrame.Position

		if v1.Magnitude < 0.001 then
			return 0
		end

		return math.deg((math.acos((math.clamp(WorldCFrame.LookVector:Dot(v1.Unit), -1, 1)))))
	end

	local function GetAngleToTarget(p12) --[[ GetAngleToTarget | Line: 439 | Upvalues: p1 (copy) ]]
		local v1 = p12 - p1.HumanoidRootPart.Position
		local v2 = Vector3.new(v1.X, 0, v1.Z)

		if v2.Magnitude < 0.001 then
			return 0
		end

		local LookVector = p1.HumanoidRootPart.CFrame.LookVector
		local v3 = Vector3.new(LookVector.X, 0, LookVector.Z)

		if v3.Magnitude < 0.001 then
			return 180
		end

		return math.deg((math.acos((math.clamp(v3.Unit:Dot(v2.Unit), -1, 1)))))
	end

	function t.StopAiming(p12) --[[ StopAiming | Line: 452 | Upvalues: p1 (copy), v13 (ref), v12 (ref) ]]
		if p12 then
			v12 = false
			p1.setTrack(p1.tracks.aim, false)

			return
		end

		p1.alignOrientation.Enabled = false
		p1.Humanoid.AutoRotate = true
		v13 = false
		v12 = false
		p1.setTrack(p1.tracks.aim, false)
	end
	function t.Aim() --[[ Aim | Line: 462 | Upvalues: v12 (ref), v14 (ref), v15 (ref), v13 (ref), ensureRigIdlePlaying (ref), p1 (copy), npcConfig (copy), t (copy), GetAngleToTarget (copy), v17 (ref), v18 (ref) ]]
		if v12 or (v14 or v15) then
			return
		end

		v12 = true
		v13 = false
		ensureRigIdlePlaying(p1)
		p1.Humanoid.AutoRotate = false
		p1.alignOrientation.Enabled = true
		p1.setTrack(p1.tracks.aim, true)
		task.wait(0.2)

		local v1 = tick()

		while p1.IsActive and tick() - v1 < npcConfig.AIM_TIMEOUT do
			local v2

			if p1.CharacterAsset.Target.Value == nil or not p1.CharacterAsset.Target.Value:FindFirstChild("HumanoidRootPart") then
				t.StopAiming()

				return
			end

			local Position = p1.CharacterAsset.Target.Value.HumanoidRootPart.Position

			t.UpdateFacing(Position)

			local v3 = GetAngleToTarget(Position)
			local WorldCFrame = p1.muzzle.WorldCFrame
			local v4 = Position - WorldCFrame.Position

			v2 = if v4.Magnitude < 0.001 then 0 else math.deg((math.acos((math.clamp(WorldCFrame.LookVector:Dot(v4.Unit), -1, 1)))))

			if v3 <= npcConfig.AIM_ALIGN_THRESHOLD_DEG and v2 <= npcConfig.AIM_ALIGN_THRESHOLD_DEG then
				v12 = false
				v17 = 0
				v18 = 0
				v13 = true

				return
			end

			task.wait(0.05)
		end

		if not (p1.CharacterAsset.Target.Value and p1.CharacterAsset.Target.Value:FindFirstChild("HumanoidRootPart")) then
			v12 = false
			v13 = false

			return
		end

		local WorldCFrame = p1.muzzle.WorldCFrame
		local v9 = p1.CharacterAsset.Target.Value.HumanoidRootPart.Position - WorldCFrame.Position

		if (if v9.Magnitude < 0.001 then 0 else math.deg((math.acos((math.clamp(WorldCFrame.LookVector:Dot(v9.Unit), -1, 1)))))) <= npcConfig.AIM_FIRE_THRESHOLD_DEG * 1.5 then
			v12 = false
			v17 = 0
			v18 = 0
			v13 = true
		else
			v12 = false
			v13 = false
		end
	end
	function t.ShootGun() --[[ ShootGun | Line: 517 | Upvalues: v16 (ref), v19 (copy), v9 (ref), v8 (ref), v1 (copy), p1 (copy), getHeadshotChance (copy), npcConfig (copy), NPC_Ammo (ref), ensureRigIdlePlaying (ref), playFireSound (copy), playMuzzleFx (copy), v17 (ref), v18 (ref), t4 (ref), t3 (ref), getRankMult (copy), serverSideShoot (ref) ]]
		local v12 = os.clock()

		if v12 - v16 < v19 then
			return
		end

		local v2

		if os.clock() < v9 then
			v2 = false
		else
			if v8 <= 0 then
				v8 = if v1 == "semi" then 1 elseif v1 == "fullauto" then math.random(8, 14) else math.random(3, 5)
			end

			v2 = true
		end

		if not v2 then
			return
		end

		local Target = p1.CharacterAsset.Target.Value
		local Position = Target.HumanoidRootPart.Position

		if math.random() < getHeadshotChance() then
			local Head = Target:FindFirstChild("Head")

			if Head then
				Position = Head.Position
			end
		end

		local WorldCFrame = p1.muzzle.WorldCFrame
		local v3 = Position - WorldCFrame.Position

		if not npcConfig.CommitToTarget and npcConfig.AIM_FIRE_THRESHOLD_DEG < (if v3.Magnitude < 0.001 then 0 else math.deg((math.acos((math.clamp(WorldCFrame.LookVector:Dot(v3.Unit), -1, 1)))))) then
			return
		end

		local v92 = p1.NPC:GetAttribute("_SuppressedUntil")
		local v10 = if v92 == nil then false else os.clock() < v92

		if v10 and math.random() < 0.5 then
			return
		end

		if not NPC_Ammo.ConsumeAmmo(p1.Weapon, p1.wepStats) then
			return
		end

		v16 = v12
		ensureRigIdlePlaying(p1)
		playFireSound()
		playMuzzleFx()

		local recoil = p1.wepStats.recoil
		local v13 = if math.random(2) == 1 then 1 else -1

		v17 = math.min(v17 + (recoil and recoil.vertical or 1), 6)
		v18 = math.clamp(v18 + (recoil and recoil.horizontal or 0.5) * v13, -30, 30)

		local v162 = p1.NPC:GetAttribute("_SuppressedUntil")
		local v20 = (if if v162 == nil then false else os.clock() < v162 then 8.5 else 5.5) * (if v1 == "semi" then 0.5 elseif v1 == "fullauto" then 1.6 else 1)
		local v21 = p1.NPC and p1.NPC:GetAttribute("AllyTag") or ""
		local v24 = v20 * (t4[v21] and t3[t4[v21]] or 1) * getRankMult()
		local Unit = (Position + Vector3.new(Random.new():NextNumber(-v24, v24), Random.new():NextNumber(-v24, v24)) - p1.HumanoidRootPart.Position).Unit
		local ShootEvent = p1.NPC:FindFirstChild("ShootEvent")

		if ShootEvent then
			ShootEvent:Fire(Unit)
		end

		serverSideShoot.Fire(p1.NPC, p1.wepStats, p1.muzzle.WorldCFrame.Position, Unit, { p1.NPC }, p1.NPC:FindFirstChildOfClass("Tool"))
		v8 = v8 - 1

		if not (v8 <= 0) then
			return
		end

		v8 = 0

		local v27, v28

		if v1 == "semi" then
			v27 = 0.3
			v28 = 0.6
		elseif v1 == "fullauto" then
			v27 = 0.2
			v28 = 0.45
		else
			v27 = 0.4
			v28 = 0.8
		end

		v9 = os.clock() + v27 + math.random() * (v28 - v27)
	end
	function t.ShootGunWhileMoving() --[[ ShootGunWhileMoving | Line: 581 | Upvalues: v16 (ref), v19 (copy), v9 (ref), v8 (ref), v1 (copy), NPC_Ammo (ref), p1 (copy), getHeadshotChance (copy), npcConfig (copy), ensureRigIdlePlaying (ref), playFireSound (copy), playMuzzleFx (copy), v17 (ref), v18 (ref), t4 (ref), t3 (ref), getRankMult (copy), serverSideShoot (ref) ]]
		local v12 = os.clock()

		if v12 - v16 < v19 then
			return
		end

		local v2

		if os.clock() < v9 then
			v2 = false
		else
			if v8 <= 0 then
				v8 = if v1 == "semi" then 1 elseif v1 == "fullauto" then math.random(8, 14) else math.random(3, 5)
			end

			v2 = true
		end

		if not v2 then
			return
		end

		if not NPC_Ammo.IsGunLoaded(p1.Weapon, p1.wepStats) then
			return
		end

		local Target = p1.CharacterAsset.Target.Value
		local Position = Target.HumanoidRootPart.Position

		if math.random() < getHeadshotChance() then
			local Head = Target:FindFirstChild("Head")

			if Head then
				Position = Head.Position
			end
		end

		local WorldCFrame = p1.muzzle.WorldCFrame
		local v3 = Position - WorldCFrame.Position

		if v3.Magnitude < 0.001 then
			return
		end

		if math.deg((math.acos((math.clamp(WorldCFrame.LookVector:Dot(v3.Unit), -1, 1))))) > npcConfig.AIM_MOVING_THRESHOLD then
			return
		end

		local v7 = p1.NPC:GetAttribute("_SuppressedUntil")
		local v82 = if v7 == nil then false else os.clock() < v7

		if v82 and math.random() < 0.5 then
			return
		end

		if not NPC_Ammo.ConsumeAmmo(p1.Weapon, p1.wepStats) then
			return
		end

		v16 = v12
		ensureRigIdlePlaying(p1)
		playFireSound()
		playMuzzleFx()

		local recoil = p1.wepStats.recoil
		local v11 = if math.random(2) == 1 then 1 else -1

		v17 = math.min(v17 + (recoil and recoil.vertical or 1), 6)
		v18 = math.clamp(v18 + (recoil and recoil.horizontal or 0.5) * v11, -30, 30)

		local Unit = v3.Unit
		local v15 = p1.NPC and p1.NPC:GetAttribute("AllyTag") or ""
		local v182 = ((if v1 == "semi" then 0.5 elseif v1 == "fullauto" then 1.6 else 1) * (t4[v15] and t3[t4[v15]] or 1) * getRankMult() - 1) * 2

		if v182 > 0 then
			local v192 = Random.new():NextNumber(-v182, v182) * 0.05
			local v20 = Random.new():NextNumber(-v182, v182) * 0.05

			Unit = (Unit + Vector3.new(v192, v20, Random.new():NextNumber(-v182, v182) * 0.05)).Unit
		end

		local v22 = p1.NPC:GetAttribute("_SuppressedUntil")

		if if v22 == nil then false else os.clock() < v22 then
			local v24 = Random.new():NextNumber(-3, 3) * 0.05
			local v25 = Random.new():NextNumber(-3, 3) * 0.05

			Unit = (Unit + Vector3.new(v24, v25, Random.new():NextNumber(-3, 3) * 0.05)).Unit
		end

		local ShootEvent = p1.NPC:FindFirstChild("ShootEvent")

		if ShootEvent then
			ShootEvent:Fire(Unit)
		end

		serverSideShoot.Fire(p1.NPC, p1.wepStats, p1.muzzle.WorldCFrame.Position, Unit, { p1.NPC }, p1.NPC:FindFirstChildOfClass("Tool"))
		v8 = v8 - 1

		if not (v8 <= 0) then
			return
		end

		v8 = 0

		local v27, v28

		if v1 == "semi" then
			v27 = 0.3
			v28 = 0.6
		elseif v1 == "fullauto" then
			v27 = 0.2
			v28 = 0.45
		else
			v27 = 0.4
			v28 = 0.8
		end

		v9 = os.clock() + v27 + math.random() * (v28 - v27)
	end
	function t.PerformReload() --[[ PerformReload | Line: 649 | Upvalues: v14 (ref), p1 (copy), v13 (ref), NPC_Ammo (ref) ]]
		if v14 then
			return
		end

		v14 = true
		p1.setTrack(p1.tracks.aim, false)
		v13 = false

		local v1 = p1.wepStats.reloadSpeedModifier or 1

		if p1.wepStats.operationType == 3 and p1.tracks.boltOpen then
			p1.tracks.boltOpen:Play(0.05, 1, v1)
			task.wait((p1.tracks.boltOpen.Length or 0.5) / v1)
		end

		local v2 = p1.Weapon.Ammo and p1.Weapon.Ammo:FindFirstChild("MagAmmo")
		local v3 = p1.tracks.clipReload and (if v2 then if v2.Value == 0 then true else false else v2)
		local v4 = v3 and p1.tracks.clipReload or p1.tracks.reload

		if p1.wepStats.magType == 2 and (v4 and v2) then
			for i = 1, v2.MaxValue - v2.Value do
				if not p1.IsActive then
					break
				end

				v4:Play(0.05, 1, v1)
				task.wait((v4.Length or 0.5) / v1)
			end
		else
			local v5

			if v4 then
				v4:Play(0.05, 1, v1)
				v5 = (v4.Length or 1.6) / v1
			else
				v5 = 1.6
			end

			task.wait(v5)
		end

		NPC_Ammo.Reload(p1.Weapon, p1.wepStats)

		if p1.wepStats.operationType == 4 then
			p1.Weapon.BoltReady.Value = true
		end

		if p1.wepStats.operationType == 3 then
			local Chambered = p1.Weapon:FindFirstChild("Chambered")
			local v6 = p1.Weapon.Ammo and p1.Weapon.Ammo:FindFirstChild("MagAmmo")

			if v3 then
				if Chambered and (v6 and v6.Value > 0) then
					Chambered.Value = true
					v6.Value = v6.Value - 1
				end

				p1.Weapon.BoltReady.Value = true
			elseif p1.tracks.boltClose then
				p1.tracks.boltClose:Play(0.05, 1, v1)
				task.wait((p1.tracks.boltClose.Length or 0.5) / v1)

				if Chambered and (v6 and v6.Value > 0) then
					Chambered.Value = true
					v6.Value = v6.Value - 1
				end

				p1.Weapon.BoltReady.Value = true
			end
		end

		if v4 then
			v4:Stop()
		end

		v14 = false
	end
	function t.PerformChamber() --[[ PerformChamber | Line: 712 | Upvalues: v14 (ref), v15 (ref), p1 (copy) ]]
		if v14 or v15 then
			return
		end

		v15 = true

		local function finishChamber() --[[ finishChamber | Line: 716 | Upvalues: p1 (ref), v15 (ref) ]]
			local v1 = p1.Weapon.BoltReady.Value and p1.tracks.boltChamber or p1.tracks.boltClose

			if v1 then
				v1:Play(0.05)
				v1.Stopped:Once(function() --[[ Line: 720 | Upvalues: p1 (ref), v15 (ref) ]]
					local Chambered = p1.Weapon:FindFirstChild("Chambered")
					local v1 = p1.Weapon.Ammo and p1.Weapon.Ammo:FindFirstChild("MagAmmo")

					if Chambered and (v1 and v1.Value > 0) then
						Chambered.Value = true
						v1.Value = v1.Value - 1
					end

					p1.Weapon.BoltReady.Value = true
					v15 = false
				end)
			else
				v15 = false
			end
		end

		if (p1.wepStats.operationType == 2 or p1.wepStats.operationType == 3) and p1.tracks.boltOpen then
			p1.tracks.boltOpen:Play(0.05)
			p1.tracks.boltOpen.Stopped:Once(finishChamber)

			return
		end

		finishChamber()
	end
	function t.DecayRecoil(p1) --[[ DecayRecoil | Line: 743 | Upvalues: v17 (ref), v18 (ref) ]]
		v17 = math.max(0, v17 - p1 * 4)
		v18 = if math.abs(v18) < 0.01 then 0 else v18 - v18 * p1 * 4

		if not (v17 < 0.01) then
			return v17, v18
		end

		v17 = 0

		return v17, v18
	end

	return t
end

return t