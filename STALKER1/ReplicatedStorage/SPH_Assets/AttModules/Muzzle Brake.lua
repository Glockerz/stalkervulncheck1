-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
game:GetService("TweenService")

return {
	AttachmentType = "Barrel",
	aimFovMinMod = 1,
	AimTimeMod = 1,
	gunLength = 0.3,
	IsSuppressor = false,
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
	muzzleChance = 5,
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
		vertical = 0.8,
		horizontal = 0.8,
		camShake = 0.8,
		damping = 0.8,
		speed = 1,
		aimReduction = 1.5
	},
	gunRecoil = {
		vertical = 0.8,
		horizontal = 0.8,
		damping = 0.8,
		speed = 1,
		punchMultiplier = 1
	}
}