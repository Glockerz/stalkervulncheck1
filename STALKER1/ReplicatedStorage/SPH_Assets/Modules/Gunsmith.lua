-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets
local WeldMod = require(SPH_Assets.Modules.WeldMod)

t.attStats = {}

local function applyAttachmentData(p1, p2) --[[ applyAttachmentData | Line: 11 | Upvalues: SPH_Assets (copy) ]]
	if not SPH_Assets.Attachments:FindFirstChild(p2) then
		warn(p2 .. "Not found in SPH_Assets.Attachments!")

		return p1
	end

	local AttStats = require(SPH_Assets.Attachments[p2].AttStats)
	local AttachmentModel = SPH_Assets.Attachments[p2].AttachmentModel

	if AttStats.fireRate then
		if p1.fireRate then
			p1.fireRate = p1.fireRate * AttStats.fireRate
		else
			p1.fireRate = AttStats.fireRate
		end
	end

	if AttStats.reloadSpeedModifier then
		if p1.reloadSpeedModifier then
			p1.reloadSpeedModifier = p1.reloadSpeedModifier * AttStats.reloadSpeedModifier
		else
			p1.reloadSpeedModifier = AttStats.reloadSpeedModifier
		end
	end

	if AttStats.gunLength then
		if p1.gunLength then
			p1.gunLength = p1.gunLength + AttStats.gunLength
		else
			p1.gunLength = AttStats.gunLength
		end
	end

	if AttStats.recoil then
		if p1.recoil then
			local recoil = p1.recoil

			recoil.vertical = recoil.vertical * AttStats.recoil.vertical

			local recoil2 = p1.recoil

			recoil2.horizontal = recoil2.horizontal * AttStats.recoil.horizontal

			local recoil3 = p1.recoil

			recoil3.camShake = recoil3.camShake * AttStats.recoil.camShake

			local recoil4 = p1.recoil

			recoil4.damping = recoil4.damping * AttStats.recoil.damping

			local recoil5 = p1.recoil

			recoil5.speed = recoil5.speed * AttStats.recoil.speed

			local recoil6 = p1.recoil

			recoil6.aimReduction = recoil6.aimReduction * AttStats.recoil.aimReduction
		else
			p1.recoil = AttStats.recoil
		end
	end

	if AttStats.gunRecoil then
		if p1.gunRecoil then
			local gunRecoil = p1.gunRecoil

			gunRecoil.vertical = gunRecoil.vertical * AttStats.gunRecoil.vertical

			local gunRecoil2 = p1.gunRecoil

			gunRecoil2.horizontal = gunRecoil2.horizontal * AttStats.gunRecoil.horizontal

			local gunRecoil3 = p1.gunRecoil

			gunRecoil3.damping = gunRecoil3.damping * AttStats.gunRecoil.damping

			local gunRecoil4 = p1.gunRecoil

			gunRecoil4.speed = gunRecoil4.speed * AttStats.gunRecoil.speed

			local gunRecoil5 = p1.gunRecoil

			gunRecoil5.punchMultiplier = gunRecoil5.punchMultiplier * AttStats.gunRecoil.punchMultiplier
		else
			p1.gunRecoil = AttStats.gunRecoil
		end
	end

	if AttStats.aimFovDefault then
		p1.aimFovDefault = AttStats.aimFovDefault
	end

	if AttStats.aimFovMin then
		p1.aimFovMin = AttStats.aimFovMin
	end

	if AttStats.aimTime then
		if p1.aimTime then
			p1.aimTime = p1.aimTime * AttStats.aimTime
		else
			p1.aimTime = AttStats.aimTime
		end
	end

	if AttStats.magazineCapacity then
		p1.magazineCapacity = AttStats.magazineCapacity
	end

	if AttStats.magazineExtension then
		p1.magazineCapacity = p1.magazineCapacity + AttStats.magazineExtension
	end

	if AttStats.maxAmmoPool then
		p1.maxAmmoPool = AttStats.maxAmmoPool
	end

	if AttStats.startAmmoPool then
		p1.startAmmoPool = AttStats.startAmmoPool
	end

	if AttStats.damage then
		if p1.damage then
			local damage = p1.damage

			damage.Head = damage.Head * AttStats.damage.Head

			local damage2 = p1.damage

			damage2.Torso = damage2.Torso * AttStats.damage.Torso

			local damage3 = p1.damage

			damage3.Other = damage3.Other * AttStats.damage.Other
		else
			p1.damage = AttStats.damage
		end
	end

	if AttStats.muzzleVelocity then
		if p1.muzzleVelocity then
			p1.muzzleVelocity = p1.muzzleVelocity * AttStats.muzzleVelocity
		else
			p1.muzzleVelocity = AttStats.muzzleVelocity
		end
	end

	if AttStats.muzzleVelocityReplace then
		p1.muzzleVelocityReplace = AttStats.muzzleVelocityReplace
	end

	if AttStats.tracers then
		p1.tracers = AttStats.tracers
		p1.tracerTiming = AttStats.tracerTiming
		p1.tracerColor = AttStats.tracerColor
	end

	if AttStats.explosiveAmmo then
		p1.explosiveAmmo = AttStats.explosiveAmmo
		p1.explosionEffect = AttStats.explosionEffect
		p1.explosionRadius = AttStats.explosionRadius
	end

	if AttStats.muzzleChance then
		p1.muzzleChance = AttStats.muzzleChance
	end

	if AttStats.ammoType then
		p1.ammoType = AttStats.ammoType
	end

	if AttStats.customBehavior then
		if p1.customBehaviors then
			table.insert(p1.customBehaviors, AttStats.customBehavior)
		else
			p1.customBehaviors = { AttStats.customBehavior }
		end
	end

	local AttachmentModel2 = SPH_Assets.Attachments[p2]:FindFirstChild("AttachmentModel")

	if AttachmentModel2 then
		if AttachmentModel2.Main:FindFirstChild("Muzzle") then
			p1.newMuzzleDevice = p2
		end

		if AttachmentModel2.Main:FindFirstChild("Fire") then
			p1.newFireSound = true
		end

		if AttachmentModel2.Main:FindFirstChild("Laser") then
			p1.laserOrigin = p2
		end

		if AttachmentModel2.Main:FindFirstChild("Bipod") then
			p1.Bipod = p2
		end
	end

	return p1
end

local function v1(p1, p2) --[[ applyRecursiveAttachments | Line: 174 | Upvalues: applyAttachmentData (copy), v1 (copy) ]]
	if p2 and p2 ~= "" then
		if typeof(p2) == "string" then
			return applyAttachmentData(p1, p2)
		end

		if typeof(p2) == "table" then
			applyAttachmentData(p1, p2[1])

			for k, v in pairs(p2[2]) do
				v1(p1, v)
			end
		end
	end

	return p1
end

function t.placeAttachment(p1, p2, p3, p4) --[[ Line: 192 | Upvalues: SPH_Assets (copy), WeldMod (copy) ]]
	if not p2 then
		warn("attachmentSlot for " .. p1 .. " not found")

		return
	end

	if not p3 then
		warn("weaponAttachment for " .. p1.Name .. " in " .. p2 .. " not found")

		return
	end

	if not SPH_Assets.Attachments:FindFirstChild(p3) then
		warn("Model for " .. p3 .. " not found")

		return
	end

	local v1 = SPH_Assets.Attachments[p3].AttachmentModel:Clone()

	v1.Parent = p1
	v1.Name = p3

	if v1.PrimaryPart then
		v1:SetPrimaryPartCFrame(p4[p2].CFrame)
		WeldMod.WeldModel(v1, p4[p2], false)
	else
		warn("Attachment " .. p3 .. " has no PrimaryPart and cannot be positioned properly!")
	end

	if v1.Main:FindFirstChild("Muzzle") then
		p1.Grip.Muzzle.WorldCFrame = v1.Main.Muzzle.WorldCFrame
	end

	return v1
end
function t.getAttStats(p1, p2) --[[ Line: 223 | Upvalues: v1 (copy) ]]
	local t = {}

	if not p1 then
		return
	end

	for k, v in pairs(p1) do
		t = v1(t, v, p2)
	end

	if p2 then
		for k, v in pairs(p2:GetChildren()) do
			if v:IsA("Model") and (v:FindFirstChild("Main") and v.Main:FindFirstChild("Flashlight")) then
				if not t.flashlights_server then
					t.flashlights_server = {}
				end

				table.insert(t.flashlights_server, v)
			end
		end
	end

	return t
end

return t