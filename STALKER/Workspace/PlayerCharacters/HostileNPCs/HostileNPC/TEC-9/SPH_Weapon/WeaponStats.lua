-- Decompiled with Potassium's decompiler.

return {
    weaponType = "Gun",
    projectile = "VisibleBullet",
    magType = 1,
    operationType = 1,
    fireRate = 900,
    muzzleChance = 5,
    muzzleVelocity = 884,
    aimSpeed = 0.3,
    gunLength = 3.2,
    maxPushback = 0.8,
    fireSwitch = { true, false, false, false },
    fireMode = 1,
    burstNumber = 3,
    burstFireRate = nil,
    spread = 1,
    shotgun = false,
    shotgunPellets = 10,
    aimFovMin = 20,
    aimTime = 0.7,
    suppressionLevel = 2,
    holster = true,
    holsterPart = "Torso",
    holsterPosition = CFrame.new(1.244, -0.912, 0.574) * CFrame.Angles(-0.3665191429188092, 0.06981317007977318, 0.10471975511965978),

    calcEjectionForce = function() -- Line: 55
        local v1 = math.random(1800, 2000) / 100;
        local v2 = math.random(180, 220) / 100;
        local v3 = math.random(330, 380) / 100;

        return Vector3.new(v1, v2, v3);
    end,

    ADSEnabled = { true, false },
    damage = {
        Head = 95,
        Torso = 28,
        Other = 20
    },
    tracers = true,
    tracerTiming = 1,
    tracerColor = Color3.fromRGB(255, 55, 55),
    ammoType = "9x19mm",
    shellEject = true,
    magazineCapacity = 20,
    arcadeAmmo = true,
    startAmmoPool = 120,
    maxAmmoPool = 120,
    infiniteAmmo = false,
    startChambered = true,
    bulletDrop = true,
    bulletForce = 300,
    viewmodelOffset = CFrame.new(0, 0.2, -0.3),
    viewmodelScale = 1.2,
    serverOffset = CFrame.new(0, 0, 0),
    idleAnim = "TEC_Idle",
    sprintAnim = "TEC_Sprint",
    reloadAnim = "TEC_Reload",
    boltChamber = "TEC_Chamber",
    boltClose = "Rifle_Close",
    equipAnim = "TEC_Equip",
    patrolAnim = "TEC_Sprint",
    holdUpAnim = "Rifle_Neutral",
    holdDownAnim = nil,
    switchAnim = "TEC_Switch",
    reloadSpeedModifier = 0.8,
    rigParts = { "Mag", "Bolt", "ChargingHandle" },
    fireMoveParts = { "Bolt" },
    boltDist = 0.45,
    emptyLockBolt = false,
    emptyCloseBolt = false,
    autoChamber = false,
    recoil = {
        vertical = 3,
        horizontal = 2.2,
        camShake = 6,
        damping = 2.1,
        speed = 8,
        aimReduction = 2
    },
    gunRecoil = {
        vertical = 28,
        horizontal = 6,
        damping = 4,
        speed = 8,
        punchMultiplier = 1.4
    }
};