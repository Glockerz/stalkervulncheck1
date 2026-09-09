-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
game:GetService("TweenService")

return {
	AttachmentType = "Sight",
	aimFovMinMod = 1,
	AimTimeMod = 1,
	gunLength = 0,
	IsSuppressor = nil,
	IsBipod = false,
	EnableLaser = nil,
	EnableFlashlight = nil,
	InfraRed = false,
	ADSEnabled = { true, false },
	ammoType = nil,
	tracers = nil,
	tracerTiming = nil,
	tracerColor = nil,
	magazineCapacity = nil,
	startAmmoPool = nil,
	maxAmmoPool = nil,
	reloadSpeedModifier = 1,
	fireRate = 1,
	muzzleChance = nil,
	muzzleVelocity = nil,
	bulletForce = nil,
	spread = 1,
	shotgun = nil,
	shotgunPellets = nil,
	damage = {
		Head = 1,
		Torso = 1,
		Other = 1
	},
	recoil = {
		vertical = 1,
		horizontal = 1,
		camShake = 1,
		damping = 1,
		speed = 1,
		aimReduction = 1
	},
	gunRecoil = {
		vertical = 1,
		horizontal = 1,
		damping = 1,
		speed = 1,
		punchMultiplier = 1
	}
}