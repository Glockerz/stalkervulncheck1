-- Decompiled with Potassium's decompiler.

return {
    weaponType = "Gun",
    projectile = "Bullet",
    magType = 2,
    SightAtt = "",
    BarrelAtt = "",
    UnderBarrelAtt = "",
    OtherAtt = "",
    AmmoAtt = "",
    operationType = 1,
    fireRate = 130,
    muzzleChance = 5,
    muzzleVelocity = 360,
    aimSpeed = 0.3,
    gunLength = 3.2,
    maxPushback = 0.8,
    fireSwitch = { false, false, false, true },
    fireMode = 4,
    burstNumber = 3,
    burstFireRate = nil,
    spread = 1,
    shotgun = true,
    shotgunPellets = 8,
    aimFovMin = 20,
    aimTime = 0.7,
    suppressionLevel = 2,
    holster = true,
    holsterOnBackpack = true,
    holsterPart = "Torso",
    holsterPosition = CFrame.new(1.244, -0.912, 0.574) * CFrame.Angles(-0.3665191429188092, 0.06981317007977318, 0.10471975511965978),

    calcEjectionForce = function() -- Line: 63
        local v1 = math.random(1800, 2000) / 1500;
        local v2 = math.random(180, 220) / 1400;
        local v3 = math.random(330, 380) / 1300;

        return Vector3.new(v1, v2, v3);
    end,

    ADSEnabled = { true, false },
    damage = {
        Head = 30,
        Torso = 28,
        Other = 20
    },
    tracers = true,
    tracerTiming = 4,
    tracerColor = Color3.fromRGB(255, 55, 55),
    ammoType = "12gauge",
    shellEject = false,
    magazineCapacity = 5,
    arcadeAmmo = true,
    startAmmoPool = 0,
    maxAmmoPool = 0,
    infiniteAmmo = false,
    startChambered = true,
    bulletDrop = true,
    bulletForce = 300,
    viewmodelOffset = CFrame.new(0, 0.2, -0.3),
    viewmodelScale = 1.2,
    serverOffset = CFrame.new(0, 0, 0),
    idleAnim = "mossburgidle",
    sprintAnim = "Rifle_Sprint",
    reloadAnim = "mossburgreload",
    boltChamber = "mossburgchamber",
    boltClose = "mossburgchamber",
    equipAnim = "mossburgequip",
    patrolAnim = "Rifle_Sprint",
    holdUpAnim = "Rifle_Neutral",
    holdDownAnim = nil,
    switchAnim = "Rifle_Switch",
    fireAnim = "mossburgfire",
    reloadSpeedModifier = 0.8,
    rigParts = { "Shell", "Slide", "Bolt", "Dust Cover" },
    fireMoveParts = { "Bolt" },
    boltDist = 0,
    emptyLockBolt = false,
    emptyCloseBolt = false,
    autoChamber = true,
    recoil = {
        vertical = 10,
        horizontal = 15,
        camShake = 0.8,
        damping = 1,
        speed = 15,
        aimReduction = 2
    },
    gunRecoil = {
        vertical = 10,
        horizontal = 6,
        damping = 3,
        speed = 7,
        punchMultiplier = 3.4
    }
};