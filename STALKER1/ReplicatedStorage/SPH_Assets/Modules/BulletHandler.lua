-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.SPH_Assets.Modules
local GameConfig = require(Modules.Parent.GameConfig)
local HitFX = require(Modules.HitFX)
local BridgeNet = require(ReplicatedStorage.SPH_Assets.Modules.BridgeNet)
local v1 = nil
local Projectiles = workspace:WaitForChild("SPH_Workspace"):WaitForChild("Projectiles")
local Cache = workspace.SPH_Workspace:WaitForChild("Cache")
local Suppression = ReplicatedStorage:WaitForChild("Suppression", 100)
local PierceMod = require(Modules.PierceMod)
local PartCache = require(Modules.PartCache)
local Bullet = script.Bullet
local v2 = PartCache.new(Bullet:Clone(), GameConfig.maxBullets or 300, Cache)
local FastCast = require(Modules.FastCast)
local v3 = RaycastParams.new()

v3.IgnoreWater = true
v3.RespectCanCollide = true

local v4 = FastCast.newBehavior()

v4.RaycastParams = v3
v4.MaxDistance = GameConfig.maxBulletDistance
v4.AutoIgnoreContainer = true
v4.CosmeticBulletContainer = Projectiles
v4.HighFidelityBehavior = FastCast.HighFidelityBehavior.Default
v4.CosmeticBulletProvider = v2
v4.CanPierceFunction = PierceMod.CanPierce

local v5 = FastCast.new()

FastCast.VisualizeCasts = false

local v6 = nil
local v7 = nil

function t.Initialize(p1) --[[ Line: 49 | Upvalues: v6 (ref), v7 (ref), v1 (ref), BridgeNet (copy), v3 (copy) ]]
	v6 = p1
	v7 = p1.Character
	v1 = BridgeNet.CreateBridge("BulletHit")
	v3.FilterDescendantsInstances = { v7, workspace.CurrentCamera }
end

local function ResetBullet(p1) --[[ ResetBullet | Line: 56 | Upvalues: Bullet (copy) ]]
	p1.BulletSmoke.Enabled = false
	p1.PointLight.Enabled = false
	p1.Color = Bullet.Color
	p1.BeamLong.Color = Bullet.BeamLong.Color
	p1.BeamLong.Enabled = false
	p1.Transparency = 1
	p1.PointLight.Enabled = false
	p1.PointLight.Color = Bullet.PointLight.Color
	p1.DistanceEffect.Enabled = false
	p1.DistanceEffect.Dot.ImageColor3 = Bullet.DistanceEffect.Dot.ImageColor3
	p1.DistanceEffect.Flare.ImageColor3 = p1.DistanceEffect.Flare.ImageColor3

	if not p1:FindFirstChild("FakeBullet") then
		return
	end

	p1.FakeBullet:Destroy()
end

local v8 = 0

local function PlaySFX(p1, p2, p3) --[[ PlaySFX | Line: 76 | Upvalues: Debris (copy), v8 (ref), GameConfig (copy), v6 (ref) ]]
	local t = {}
	local FireSounds = p1:FindFirstChild("FireSounds")
	local SuppressorSounds = p1:FindFirstChild("SuppressorSounds")
	local BassSounds = p1:FindFirstChild("BassSounds")
	local TailSounds = p1:FindFirstChild("TailSounds")
	local MediumSounds = p1:FindFirstChild("MediumSounds")
	local FarSounds = p1:FindFirstChild("FarSounds")
	local ThumpSounds = p1:FindFirstChild("ThumpSounds")
	local Thump = p1:FindFirstChild("Thump")
	local v1 = if FireSounds then FireSounds:GetChildren() else {}

	if SuppressorSounds then
		t = SuppressorSounds:GetChildren()
	end

	local v2 = nil

	if p3 and #t > 0 then
		v2 = t[math.random(1, #t)]
	elseif not p3 and #v1 > 0 then
		v2 = v1[math.random(1, #v1)]
	end

	local Echo = p1:FindFirstChild("Echo")
	local Bass = p1:FindFirstChild("Bass")
	local Tail = p1:FindFirstChild("Tail")

	local function playDistanceLayer(p12) --[[ playDistanceLayer | Line: 108 | Upvalues: p1 (copy), Debris (ref) ]]
		if not (p12 and #p12:GetChildren() > 0) then
			return
		end

		local v1 = p12:GetChildren()[math.random(1, #p12:GetChildren())]:Clone()

		v1.Name = p12.Name .. "_Playing"
		v1.Parent = p1
		v1:Play()
		Debris:AddItem(v1, if v1.TimeLength == 0 then 5 else v1.TimeLength)
	end

	playDistanceLayer(MediumSounds)
	playDistanceLayer(FarSounds)

	if not v2 then
		return
	end

	if v2.Looped then
		local FireFirst = p1:FindFirstChild("FireFirst")

		if v2:GetAttribute("HasPlayedFirst") or not FireFirst then
			local LoopHeartbeat = Instance.new("BoolValue")

			LoopHeartbeat.Name = "LoopHeartbeat"
			LoopHeartbeat.Parent = v2
			Debris:AddItem(LoopHeartbeat, 0.1)

			if not v2.IsPlaying then
				v2:Play()
			end

			v2:SetAttribute("HasPlayedSecond", true)
		else
			v2:SetAttribute("HasPlayedFirst", true)

			local v3 = FireFirst:Clone()

			v3.Name = v3.Name .. "_Playing"
			v3.Parent = p1
			v3:Play()
			Debris:AddItem(v3, if v3.TimeLength == 0 then 5 else v3.TimeLength)

			local v7 = nil

			if BassSounds and #BassSounds:GetChildren() > 0 then
				local v82 = BassSounds:GetChildren()

				v7 = v82[math.random(1, #v82)]
			elseif Bass then
				v7 = Bass
			end

			if v7 then
				local Bass_Playing = v7:Clone()

				Bass_Playing.Name = "Bass_Playing"
				Bass_Playing.Parent = p1
				Bass_Playing:Play()
				Debris:AddItem(Bass_Playing, if Bass_Playing.TimeLength == 0 then 5 else Bass_Playing.TimeLength)
			end
		end

		task.delay(0.12, function() --[[ Line: 236 | Upvalues: v2 (ref), p1 (copy), Debris (ref) ]]
			if v2:FindFirstChild("LoopHeartbeat") then
				return
			end

			local FireLoopTail = p1:FindFirstChild("FireLoopTail")

			if FireLoopTail and v2:GetAttribute("HasPlayedSecond") then
				local v1 = FireLoopTail:Clone()

				v1.Parent = p1
				v1:Play()
				Debris:AddItem(v1, if v1.TimeLength == 0 then 5 else v1.TimeLength)
				v2:SetAttribute("HasPlayedSecond", nil)
			end

			v2:Stop()
			v2:SetAttribute("HasPlayedFirst", nil)
		end)
	else
		local v11 = v2:Clone()

		v11.Name = v11.Name .. "_Playing"
		v11.PlaybackSpeed = 1 + math.random(-5, 5) / 100
		v11.Parent = p1
		v11:Play()
		Debris:AddItem(v11, if v11.TimeLength == 0 then 5 else v11.TimeLength)

		local v15 = nil

		if BassSounds and #BassSounds:GetChildren() > 0 then
			local v16 = BassSounds:GetChildren()

			v15 = v16[math.random(1, #v16)]
		elseif Bass then
			v15 = Bass
		end

		if v15 then
			local Bass_Playing = v15:Clone()

			Bass_Playing.Name = "Bass_Playing"
			Bass_Playing.Parent = p1
			Bass_Playing:Play()
			Debris:AddItem(Bass_Playing, if Bass_Playing.TimeLength == 0 then 5 else Bass_Playing.TimeLength)
		end

		local v19 = nil

		if ThumpSounds and #ThumpSounds:GetChildren() > 0 then
			v19 = ThumpSounds:GetChildren()[math.random(1, #ThumpSounds:GetChildren())]
		elseif Thump then
			v19 = Thump
		end

		if v19 then
			local Thump_Playing = v19:Clone()

			Thump_Playing.Name = "Thump_Playing"
			Thump_Playing.Parent = p1
			Thump_Playing:Play()
			Debris:AddItem(Thump_Playing, if Thump_Playing.TimeLength == 0 then 5 else Thump_Playing.TimeLength)
		end

		if tick() - v8 >= 0.1 then
			local v22 = nil

			if TailSounds and #TailSounds:GetChildren() > 0 then
				local v23 = TailSounds:GetChildren()

				v22 = v23[math.random(1, #v23)]
			elseif Tail then
				v22 = Tail
			end

			if v22 then
				local Tail_Playing = v22:Clone()

				Tail_Playing.Name = "Tail_Playing"
				Tail_Playing.Parent = p1
				task.delay(0.15, function() --[[ Line: 177 | Upvalues: Tail_Playing (copy) ]]
					Tail_Playing:Play()
				end)
				Debris:AddItem(Tail_Playing, if Tail_Playing.TimeLength == 0 then 5 else Tail_Playing.TimeLength)
				v8 = tick()
			end
		end

		if not Echo or not GameConfig.firstPersonEcho and p2 == v6 then
			return
		end

		local Echo_Playing = Echo:Clone()

		Echo_Playing.Name = "Echo_Playing"
		Echo_Playing.Parent = p1
		task.delay(0.25, function() --[[ Line: 190 | Upvalues: Echo_Playing (copy) ]]
			Echo_Playing:Play()
		end)
		Debris:AddItem(Echo_Playing, if Echo_Playing.TimeLength == 0 then 5 else Echo_Playing.TimeLength)
	end
end

function t.FireBullet(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ Line: 256 | Upvalues: v4 (ref), GameConfig (copy), v5 (copy), ResetBullet (copy), ReplicatedStorage (copy), TweenService (copy) ]]
	local WeaponStats = require(p5.SPH_Weapon.WeaponStats)

	v4.Acceleration = GameConfig.bulletAcceleration

	if not WeaponStats.bulletDrop then
		v4.Acceleration = Vector3.new(0, 0, 0)
	end

	local v1 = v5:Fire(p2, p3, p4, v4)
	local t = {
		Player = p6,
		TracerColor = p7,
		Tool = p5,
		IgnoreModel = p1,
		FakeBullet = p8,
		Visible = false,
		Origin = p2,
		SuppressionLevel = WeaponStats.suppressionLevel or 1,
		ModTable = p9
	}
	local CosmeticBulletObject = v1.RayInfo.CosmeticBulletObject

	if CosmeticBulletObject and CosmeticBulletObject.Transparency == 0 then
		ResetBullet(CosmeticBulletObject)
	end

	local v2 = ReplicatedStorage.SPH_Assets.Projectiles:FindFirstChild(WeaponStats.projectile)

	if v2 and not p7 then
		local FakeBullet = v2:Clone()

		FakeBullet.Anchored = false
		FakeBullet.CanCollide = false
		FakeBullet.Name = "FakeBullet"
		FakeBullet.Parent = CosmeticBulletObject
		t.Visible = true
	end

	v1.UserData = t

	if WeaponStats.serverOffset then
		local v3 = WeaponStats.serverOffset * CFrame.new(0, 0, 0.17)
		local Angles = CFrame.Angles

		p1.BaseWeld.C0 = v3 * Angles(0.03490658503988659, math.rad(math.random(-10, 10) / 10), 0)
		TweenService:Create(p1.BaseWeld, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
			C0 = WeaponStats.serverOffset
		}):Play()
	end

	local v52 = WeaponStats

	if not p1:FindFirstChild("Weapon") then
		return
	end

	local v6 = p1.Weapon:FindFirstChildWhichIsA("Model")

	if not (v6 and v6:FindFirstChild(v52.projectile)) then
		return
	end

	local v7 = v6:FindFirstChild(v52.projectile)

	v7.LocalTransparencyModifier = 1

	for i, v in ipairs(v7:GetDescendants()) do
		if v:IsA("BasePart") then
			v.LocalTransparencyModifier = 1
		end
	end
end
function t.FireFX(p1, p2, p3, p4, p5) --[[ Line: 327 | Upvalues: PlaySFX (copy), v6 (ref), GameConfig (copy) ]]
	local Character = p1.Character
	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	local v1 = p2:FindFirstChild("Grip") or p2:FindFirstChild("Base")

	if not (Character:FindFirstChild("WeaponRig"):FindFirstChild("Grip", true) or p2:FindFirstChild("Grip")) then
		p2:FindFirstChild("Base")
	end

	local v2 = v1[p3]

	PlaySFX(v1, p1, p5)
	PlaySFX(v2, p1, p5)

	if not (HumanoidRootPart and v6:DistanceFromCharacter(HumanoidRootPart.Position) <= GameConfig.fireEffectDistance) then
		return
	end

	local v3 = math.random(10) <= p4

	for i, v in ipairs(v2:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			if v:GetAttribute("EmitNumber") then
				if string.find(v.Name, "Flash") then
					if v3 then
						v:Emit(v:GetAttribute("EmitNumber"))
					end

					continue
				end

				v:Emit(v:GetAttribute("EmitNumber"))

				continue
			end

			if v:FindFirstChild("Particles") then
				local v4 = false

				if string.find(v.Name, "Flash") then
					if v3 then
						v4 = true
					end
				else
					v4 = true
				end

				if v4 then
					v:Emit(v.Particles.Value)
				end

				continue
			end

			if v.Name == "Smoke" then
				v:Emit(10)

				continue
			end

			if v.Name == "Flash" and v3 then
				v:Emit(5)
			end

			continue
		end

		if v:IsA("Light") and v3 then
			v.Enabled = true
			task.delay(0.01, function() --[[ Line: 372 | Upvalues: v (copy) ]]
				v.Enabled = false
			end)
		end
	end

	local Chamber = v2:FindFirstChild("Chamber")

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

			if v.Name == "Flash" and v3 then
				v:Emit(5)
			end
		end
	end
end
function t.MoveBolt(p1, p2, p3, p4) --[[ Line: 394 | Upvalues: TweenService (copy) ]]
	if not (p1 and p1:FindFirstChild("Grip")) then
		return
	end

	for i, v in ipairs(p1.Grip:GetChildren()) do
		for i2, v2 in ipairs(p2.fireMoveParts) do
			local v1

			if v.Name == v2 then
				v.C1 = CFrame.new()

				local v6 = TweenInfo.new(60 / p2.fireRate / 2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, not (if p4 <= 0 then p2.emptyLockBolt else false))

				v1 = if typeof(p3) == "CFrame" then p3 else CFrame.new(0, 0, -p3)
				TweenService:Create(v, v6, {
					C1 = v1
				}):Play()

				break
			end
		end
	end
end
v5.LengthChanged:Connect(function(p1, p2, p3, p4, p5, p6) --[[ Line: 420 | Upvalues: GameConfig (copy), v6 (ref), Suppression (copy) ]]
	if not p6 then
		return
	end

	if GameConfig.suppressionEffects and (v6 ~= p1.UserData.Player and (not p1.UserData.Cracked and (v6:DistanceFromCharacter(p6.Position) <= 60 and v6:DistanceFromCharacter(p1.UserData.Origin) >= 60))) then
		Suppression:Fire(p1.UserData.SuppressionLevel)
		p1.UserData.Cracked = true
	end

	if not p1.UserData.Visible and (GameConfig.arcadeBullets or p1.UserData.TracerColor) and (p1.UserData.Origin - p6.Position).Magnitude > GameConfig.tracerStartDistance then
		p1.UserData.Visible = true
		p6.Transparency = 0
		p6.BeamLong.Enabled = true
		p6.BulletSmoke.Enabled = true
		p6.PointLight.Enabled = true
		p6.DistanceEffect.Enabled = true

		if p1.UserData.TracerColor then
			local TracerColor = p1.UserData.TracerColor

			if GameConfig.teamTracers and p1.UserData.Player.Team then
				p6.Color = p1.UserData.Player.Team.TeamColor.Color
			else
				p6.Color = TracerColor
			end

			p6.BeamLong.Enabled = true
			p6.BeamLong.Color = ColorSequence.new(TracerColor)
			p6.PointLight.Color = TracerColor
			p6.BulletSmoke.Enabled = false
			p6.DistanceEffect.Dot.ImageColor3 = TracerColor
			p6.DistanceEffect.Flare.ImageColor3 = TracerColor
		end
	end

	p6.CFrame = CFrame.new(p2, p2 + p3) * CFrame.new(0, 0, -(p4 - p6.Size.Z / 2))

	if not p6:FindFirstChild("FakeBullet") then
		return
	end

	p6.FakeBullet.CFrame = p6.CFrame
end)
v5.RayHit:Connect(function(p1, p2, p3, p4) --[[ Line: 465 | Upvalues: HitFX (copy), v1 (ref), GameConfig (copy), v6 (ref), Suppression (copy) ]]
	if p1.UserData.TurretFired then
		local _ = require(p1.UserData.IgnoreModel.Parent.TurretModule).guns[p1.UserData.Tool]
	else
		require(p1.UserData.Tool.SPH_Weapon.WeaponStats)
	end

	if p1.UserData.FakeBullet then
		return
	end

	HitFX.HitEffect(p2.Position, p2.Instance, p2.Normal)
	v1:Fire(p1.UserData.TurretFired and {
		model = p1.UserData.IgnoreModel,
		index = p1.UserData.Tool
	} or p1.UserData.Tool, {
		Position = p2.Position,
		Normal = p2.Normal,
		Instance = p2.Instance
	}, p4.CFrame, p1.UserData.ModTable)

	if not GameConfig.suppressionEffects or (v6 == p1.UserData.Player or p1.UserData.Cracked) then
		return
	end

	Suppression:Fire(p1.UserData.SuppressionLevel)
	p1.UserData.Cracked = true
end)
v5.CastTerminating:Connect(function(p1) --[[ Line: 494 | Upvalues: ResetBullet (copy), v2 (copy) ]]
	if p1.UserData.Visible then
		ResetBullet(p1.RayInfo.CosmeticBulletObject)
	end

	v2:ReturnPart(p1.RayInfo.CosmeticBulletObject)
end)

return t