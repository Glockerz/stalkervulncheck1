-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
game:GetService("TweenService")

return {
	AttachmentType = "Ammo",
	ReplaceMag = true,
	aimFovMinMod = 1,
	AimTimeMod = 1,
	gunLength = 0,
	IsSuppressor = nil,
	IsBipod = false,
	EnableLaser = nil,
	EnableFlashlight = nil,
	InfraRed = false,
	ADSEnabled = { true, false },
	ammoType = "Orange",
	tracers = true,
	tracerTiming = 1,
	tracerColor = Color3.fromRGB(255, 170, 0),
	magazineCapacity = 20,
	startAmmoPool = nil,
	maxAmmoPool = nil,
	reloadSpeedModifier = 1,
	fireRate = 1,
	muzzleChance = 0,
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