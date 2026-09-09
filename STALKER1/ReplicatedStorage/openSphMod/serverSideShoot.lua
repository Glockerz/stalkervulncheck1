-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")
local DeathCause = require(game:GetService("ReplicatedStorage"):WaitForChild("DeathCause"))
local SPH_Assets = ReplicatedStorage.SPH_Assets
local Modules = SPH_Assets.Modules
local GameConfig = require(SPH_Assets.GameConfig)
local BridgeNet = require(Modules.BridgeNet)
local v1 = BridgeNet.CreateBridge("ReplicateNPCFire")
local v2 = BridgeNet.CreateBridge("ReplicateHit")
local ExplosionFX = require(Modules.ExplosionFX)
local FractureGlass = require(Modules.FractureGlass)
local ObjectDestruction = require(Modules.ObjectDestruction)
local Gunsmith = require(Modules.Gunsmith)
local PierceMod = require(Modules.PierceMod)
local PartCache = require(Modules.PartCache)
local FastCast = require(Modules.FastCast)
local DTS_Assets = ReplicatedStorage:FindFirstChild("DTS_Assets")
local v3 = if DTS_Assets then require(DTS_Assets.Modules.Antitank) else nil
local SPH_Workspace = workspace:WaitForChild("SPH_Workspace")
local ServerCache = Instance.new("Folder")

ServerCache.Name = "ServerCache"
ServerCache.Parent = SPH_Workspace

local ServerProjectiles = Instance.new("Folder")

ServerProjectiles.Name = "ServerProjectiles"
ServerProjectiles.Parent = SPH_Workspace

local ServerBullet = Instance.new("Part")

ServerBullet.Name = "ServerBullet"
ServerBullet.Size = Vector3.new(0.2, 0.2, 0.2)
ServerBullet.Transparency = 1
ServerBullet.Anchored = true
ServerBullet.CanCollide = false
ServerBullet.CanQuery = false
ServerBullet.CanTouch = false

local v4 = PartCache.new(ServerBullet, 100, ServerCache)
local v5 = FastCast.new()

local function ProcessHit(p1, p2, p3, p4, p5, p6) --[[ ProcessHit | Line: 52 | Upvalues: ExplosionFX (copy), v3 (ref), GameConfig (copy), SPH_Assets (copy), v2 (copy), ReplicatedStorage (copy), DeathCause (copy), CollectionService (copy), FractureGlass (copy), Debris (copy), ObjectDestruction (copy) ]]
	if not (p1 and p1.Instance) then
		return
	end

	local v1 = p1.Instance

	if not (v1 and v1.Parent) then
		return
	end

	local v22 = if p3 then if p3.explosiveAmmo then p3 else p2 else p2

	if v22.explosiveAmmo then
		local explosionRadius = p2.explosionRadius
		local explosionEffect = p2.explosionEffect

		if p3 and p3.explosiveAmmo then
			explosionRadius = p3.explosionRadius
			explosionEffect = p3.explosionEffect
		end

		ExplosionFX(p1.Position, explosionRadius, explosionEffect, nil, false, v22)
	else
		local v32 = v1.Parent:FindFirstChildWhichIsA("Humanoid")
		local v4 = p2.damage[v1.Name] or p2.damage.Other

		if v1.Name == "HumanoidRootPart" then
			v4 = p2.damage.UpperTorso or p2.damage.Torso
		end

		if p3 and p3.damage then
			v4 = if v1.Name == "HumanoidRootPart" then p3.damage.Torso else v4 * (p3.damage[v1.Name] or p3.damage.Other)
		end

		if v3 and p2.ATCanDamage then
			local v7 = math.random(p2.ATDefaultPen[1], p2.ATDefaultPen[2])
			local v8 = math.random(p2.ATDefaultDamage[1], p2.ATDefaultDamage[2])
			local v9 = GameConfig.useBulletForce and Vector3.new(0, 0, -p2.bulletForce or 0) or nil

			if v1 and v1:HasTag("Dragoon_Armor") then
				v3.DamageVehicle(nil, v1, v7, v8, v9, true)
			elseif v1:HasTag("Dragoon_Armor") or v1:HasTag("PropSystem_Armor") then
				if v1:HasTag("PropSystem_Armor") then
					v3.DamageProp(nil, v1, v7, v8, v9, true)
				end
			else
				v3.DamageMisc(nil, v1, v1.Position, nil, v7, v8, v8, v9, true)
			end
		end

		local v11 = if v22.customBehavior and SPH_Assets.CustomBehaviors:FindFirstChild(v22.customBehavior) then require(SPH_Assets.CustomBehaviors:FindFirstChild(v22.customBehavior)) else nil

		if v11 then
			v11.OnProjectileHit(v1, v32, nil, v4)
		end

		local v13 = nil

		if p3 and p3.customBehaviors then
			for k, v in pairs(p3.customBehaviors) do
				if SPH_Assets.CustomBehaviors:FindFirstChild(v) then
					v13 = require(SPH_Assets.CustomBehaviors:FindFirstChild(v))
				end

				if v13 then
					v13.OnProjectileHit(v1, v32, nil, v4)
				end
			end
		end

		if v11 and table.find(v11.Overrides, "OnProjectileHit") then
			return
		end

		if v13 and table.find(v13.Overrides, "OnProjectileHit") then
			return
		end

		if p6 then
			v2:FireAll(p6, {
				Position = p1.Position,
				Normal = p1.Normal,
				Instance = p1.Instance
			})
		end

		if v32 and v32.Health > 0 then
			local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))
			local v15 = 0

			if p6 then
				local v16 = p6:GetAttribute("LoadedRounds")

				if v16 then
					local HttpService = game:GetService("HttpService")
					local ok, result = pcall(function() --[[ Line: 148 | Upvalues: HttpService (copy), v16 (copy) ]]
						return HttpService:JSONDecode(v16)
					end)

					if ok and (result and result[1]) then
						local v17 = ItemDatabase.RoundTypes and ItemDatabase.RoundTypes[result[1]]

						if v17 then
							v15 = v17.Penetration or 0
						end
					end
				end
			end

			local v19 = math.clamp(math.floor((v15 or 0) / 10) + 1, 1, 4)
			local v20 = game:GetService("Players"):GetPlayerFromCharacter(v32.Parent)
			local v21 = require(game:GetService("ServerScriptService"):WaitForChild("ArmorSystem")).ApplyDamage(v20, v1.Name, v4, v19, v32.Parent)

			if v32.Health > 0 and v32.Health - v21 <= 0 then
				local Killer = Instance.new("StringValue", v32.Parent)

				Killer.Name = "Killer"

				local v222

				if p5 then
					v222 = p5.Name

					if v222 then
						v4 = v21
					else
						v222 = "NPC"
						v4 = v21
					end
				else
					v222 = "NPC"
					v4 = v21
				end

				Killer.Value = v222
			else
				v4 = v21
			end

			if v32.Parent then
				DeathCause.Tag(v32.Parent, (tostring(if p5 then p5:GetAttribute("Faction") or "npc" else "npc")))
			end

			v32:TakeDamage(v4)
		elseif (v1.Name == "Glass" or CollectionService:HasTag(v1, "BreakableGlass")) and (GameConfig.glassShatter and not v1:GetAttribute("Shattered")) then
			v1:SetAttribute("Shattered", true)

			local Position = p1.Position
			local TempGlass = v1:Clone()

			TempGlass.Name = "TempGlass"
			TempGlass.Parent = workspace

			local Transparency = v1.Transparency
			local CanCollide = v1.CanCollide
			local CanQuery = v1.CanQuery
			local CanTouch = v1.CanTouch

			v1.Transparency = 1
			v1.CanCollide = false
			v1.CanQuery = false
			v1.CanTouch = false
			delay(GameConfig.glassRespawnTime, function() --[[ Line: 192 | Upvalues: v1 (copy), Transparency (copy), CanCollide (copy), CanQuery (copy), CanTouch (copy) ]]
				if not (v1 and v1.Parent) then
					return
				end

				v1.Transparency = Transparency
				v1.CanCollide = CanCollide
				v1.CanQuery = CanQuery
				v1.CanTouch = CanTouch
				v1:SetAttribute("Shattered", false)
			end)

			if v1:IsA("Part") and v1.Shape == Enum.PartType.Block or v1:IsA("WedgePart") then
				local v31, v322, v33

				if p4 then
					v31 = p4.LookVector * 10

					if v31 then
						v322 = TempGlass
						v33 = Position
					else
						v322 = TempGlass
						v33 = Position
						v31 = Vector3.new(0, 0, 0)
					end
				else
					v322 = TempGlass
					v33 = Position
					v31 = Vector3.new(0, 0, 0)
				end

				FractureGlass(v322, v33, v31)
			else
				TempGlass:Destroy()
			end

			local Attachment = Instance.new("Attachment", workspace.Terrain)

			Attachment.WorldPosition = Position

			local v34 = SPH_Assets.Sounds.GlassBreak:GetChildren()[math.random(#SPH_Assets.Sounds.GlassBreak:GetChildren())]:Clone()

			v34.Parent = Attachment
			v34:Play()
			Debris:AddItem(Attachment, v34.TimeLength)
		else
			local v25, v26, v27, v28, v29

			if not v1.Anchored and GameConfig.useBulletForce and (v32 and v32.Health <= 0 or not v32) then
				v25 = Instance.new("Attachment", v1)
				v26 = CFrame.new(p1.Position)
				v27 = p4 and p4 - p4.Position or CFrame.new()
				v25.WorldCFrame = v26 * v27
				v28 = Instance.new("VectorForce", v25)
				v28.Attachment0 = v25
				v29 = p2.bulletForce or 0

				if p3 and p3.bulletForce then
					v29 = v29 * p3.bulletForce
				end

				v28.Force = Vector3.new(0, 0, -v29)
				Debris:AddItem(v25, 0.1)
			end
		end

		local v35 = nil

		if v1.Parent:HasTag("SPH_Destructible") then
			v35 = v1.Parent
		elseif v1:HasTag("SPH_Destructible") then
			v35 = v1
		end

		if not v35 or v35:GetAttribute("Destroyed") then
			return
		end

		local v36 = v35:GetAttribute("HP")

		v35:SetAttribute("HP", v36 - v4)

		if not (v36 - v4 <= 0) then
			return
		end

		ObjectDestruction.DestroyObject(v35)
	end
end

v5.LengthChanged:Connect(function(p1, p2, p3, p4, p5, p6) --[[ Line: 246 ]]
	if p6 then
		p6.CFrame = CFrame.new(p2, p2 + p3) * CFrame.new(0, 0, -(p4 - p6.Size.Z / 2))
	end
end)
v5.RayHit:Connect(function(p1, p2, p3, p4) --[[ Line: 254 | Upvalues: ProcessHit (copy) ]]
	local Tool = p1.UserData.Tool

	if not (Tool and Tool:FindFirstChild("SPH_Weapon")) then
		return
	end

	ProcessHit(p2, p1.UserData.WepStats, p1.UserData.AttStats, p4 and p4.CFrame or CFrame.new(), p1.UserData.NPCModel, Tool)
end)
v5.CastTerminating:Connect(function(p1) --[[ Line: 267 | Upvalues: v4 (copy) ]]
	v4:ReturnPart(p1.RayInfo.CosmeticBulletObject)
end)
function t.Fire(p1, p2, p3, p4, p5, p6) --[[ Fire | Line: 271 | Upvalues: FastCast (copy), GameConfig (copy), ServerProjectiles (copy), v4 (copy), PierceMod (copy), Gunsmith (copy), v5 (copy), v1 (copy) ]]
	local v12 = RaycastParams.new()

	v12.FilterType = Enum.RaycastFilterType.Exclude
	v12.FilterDescendantsInstances = if p5 then p5 else { p1 }
	v12.IgnoreWater = true
	v12.RespectCanCollide = true

	local v3 = FastCast.newBehavior()

	v3.RaycastParams = v12
	v3.MaxDistance = GameConfig.maxBulletDistance
	v3.AutoIgnoreContainer = true
	v3.CosmeticBulletContainer = ServerProjectiles
	v3.HighFidelityBehavior = FastCast.HighFidelityBehavior.Default
	v3.CosmeticBulletProvider = v4
	v3.CanPierceFunction = PierceMod.CanPierce
	v3.Acceleration = GameConfig.bulletAcceleration

	if not p2.bulletDrop then
		v3.Acceleration = Vector3.new(0, 0, 0)
	end

	local v42 = p2.spread * 100
	local v8 = CFrame.Angles(math.rad(math.random(-v42, v42) / 100), math.rad(math.random(-v42, v42) / 100), 0)
	local LookVector = (CFrame.lookAt(p3, p3 + p4) * v8).LookVector
	local v9 = LookVector * p2.muzzleVelocity * 3.5
	local v10 = if p2.Attachments then Gunsmith.getAttStats(p2.Attachments) else nil
	local v122 = v5:Fire(p3, LookVector, v9, v3)
	local t = {
		Player = nil
	}

	t.TracerColor = p2.tracers and p2.tracerColor or nil
	t.Tool = p6
	t.IgnoreModel = p1
	t.FakeBullet = false
	t.Visible = false
	t.Origin = p3
	t.SuppressionLevel = p2.suppressionLevel or 1
	t.TurretFired = false
	t.Cracked = false
	t.WepStats = p2
	t.AttStats = v10
	t.NPCModel = p1
	v122.UserData = t

	local v14 = if p2.tracers then p2.tracerColor else nil
	local t2 = {
		hitPosition = nil,
		origin = p3,
		direction = LookVector,
		velocity = v9
	}

	t2.weaponName = p2.modelName or p2.name
	t2.muzzleChance = p2.muzzleChance
	t2.tracerColor = v14
	t2.npcModel = p1
	t2.tool = p6
	v1:FireAll(t2)
end
function t.FireShotgun(p1, p2, p3, p4, p5, p6) --[[ FireShotgun | Line: 348 | Upvalues: t (copy) ]]
	for i = 1, p2.shotgunPellets or 8 do
		t.Fire(p1, p2, p3, p4, p5, p6)
	end
end

return t