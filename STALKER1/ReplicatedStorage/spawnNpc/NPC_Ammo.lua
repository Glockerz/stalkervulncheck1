-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	IsGunLoaded = function(p1, p2) --[[ IsGunLoaded | Line: 3 ]]
		if p2.openBolt then
			return p1:FindFirstChild("Ammo") and p1.Ammo.MagAmmo.Value > 0
		end

		local Chambered = p1:FindFirstChild("Chambered")

		return if Chambered then Chambered.Value == true else Chambered
	end
}

function t.ConsumeAmmo(p1, p2) --[[ ConsumeAmmo | Line: 11 | Upvalues: t (copy) ]]
	if not t.IsGunLoaded(p1, p2) then
		return false
	end

	local Ammo = p1:FindFirstChild("Ammo")

	if not Ammo then
		return false
	end

	local MagAmmo = Ammo.MagAmmo

	if p2.openBolt then
		MagAmmo.Value = MagAmmo.Value - 1
		p1.BoltReady.Value = if MagAmmo.Value > 0 then true else not p2.emptyLockBolt
	else
		local Chambered = p1:FindFirstChild("Chambered")

		if Chambered then
			Chambered.Value = false
		end

		if p2.fireMode == 4 then
			p1.BoltReady.Value = false

			return true
		end

		p1.BoltReady.Value = not p2.emptyLockBolt

		if not (MagAmmo.Value > 0) then
			return true
		end

		MagAmmo.Value = MagAmmo.Value - 1

		if Chambered then
			Chambered.Value = true
		end

		p1.BoltReady.Value = true
	end

	return true
end
function t.Reload(p1, p2) --[[ Reload | Line: 40 ]]
	local Ammo = p1:FindFirstChild("Ammo")

	if not Ammo then
		return
	end

	local MagAmmo = Ammo.MagAmmo
	local ArcadeAmmoPool = Ammo.ArcadeAmmoPool

	if not (MagAmmo and ArcadeAmmoPool) then
		return
	end

	if p2.infiniteAmmo then
		MagAmmo.Value = MagAmmo.MaxValue
	elseif ArcadeAmmoPool.Value > 0 then
		local v1 = MagAmmo.MaxValue - MagAmmo.Value

		if v1 > 0 and v1 < ArcadeAmmoPool.Value then
			MagAmmo.Value = MagAmmo.MaxValue
			ArcadeAmmoPool.Value = ArcadeAmmoPool.Value - v1
		elseif v1 > 0 then
			MagAmmo.Value = MagAmmo.Value + ArcadeAmmoPool.Value
			ArcadeAmmoPool.Value = 0
		end
	end

	if p2.operationType ~= 4 or (not p1:FindFirstChild("Chambered") or p1.Chambered.Value) then
		return
	end

	p1.Chambered.Value = true
	MagAmmo.Value = math.max(0, MagAmmo.Value - 1)
end
function t.NeedsReload(p1, p2) --[[ NeedsReload | Line: 68 ]]
	local Ammo = p1:FindFirstChild("Ammo")

	if not Ammo then
		return false
	end

	local MagAmmo = Ammo.MagAmmo

	if p2.openBolt then
		return MagAmmo.Value <= 0
	end

	local Chambered = p1:FindFirstChild("Chambered")

	if Chambered and Chambered.Value then
		return false
	end

	return MagAmmo.Value <= 0
end
function t.NeedsChamber(p1, p2, p3, p4) --[[ NeedsChamber | Line: 78 ]]
	if p2.openBolt or (p3 or p4) then
		return false
	end

	local Chambered = p1:FindFirstChild("Chambered")
	local BoltReady = p1:FindFirstChild("BoltReady")
	local v1 = p1.Ammo and p1.Ammo.MagAmmo

	if not (Chambered and (BoltReady and v1)) then
		return false
	end

	if v1.Value <= 0 and not Chambered.Value then
		return false
	end

	if not BoltReady.Value and v1.Value <= 0 then
		return false
	end

	return not BoltReady.Value or not Chambered.Value and v1.Value > 0
end

return t