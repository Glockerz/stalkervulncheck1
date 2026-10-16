-- Decompiled with Potassium's decompiler.

return {
    weaponType = "Gun",
    projectile = "Bullet",
    magType = 1,
    operationType = 1,
    fireRate = 600,
    muzzleChance = 5,
    muzzleVelocity = 381,
    aimSpeed = 0.3,
    gunLength = 1.7,
    maxPushback = 1,
    fireSwitch = { true, false, false, false },
    fireMode = 1,
    burstNumber = 3,
    burstFireRate = nil,
    spread = 0.9,
    shotgun = false,
    shotgunPellets = 10,
    aimFovMin = 40,
    aimTime = 0.7,
    suppressionLevel = 1,
    holster = false,
    holsterPart = "Torso",
    holsterPosition = CFrame.new(1.244, -0.912, 0.574) * CFrame.Angles(-0.3665191429188092, 0.06981317007977318, 0.10471975511965978),

    calcEjectionForce = function() -- Line: 55
        local v1 = math.random(100, 100) / 10;
        local v2 = math.random(100, 100) / 10;
        local v3 = math.random(100, 110) / -10;

        return Vector3.new(v1, v2, v3);
    end,

    ADSEnabled = { false, false },
    damage = {
        Head = 95,
        Torso = 28,
        Other = 20
    },
    tracers = false,
    tracerTiming = 4,
    tracerColor = Color3.fromRGB(255, 55, 55),
    ammoType = "9x19mm",
    shellEject = true,
    magazineCapacity = 15,
    arcadeAmmo = true,
    startAmmoPool = 0,
    maxAmmoPool = 0,
    infiniteAmmo = false,
    startChambered = true,
    bulletDrop = true,
    bulletForce = 300,
    viewmodelOffset = CFrame.new(0.2, 0.1, -0.2),
    viewmodelScale = 1.2,
    serverOffset = CFrame.new(0, 0, 0),
    idleAnim = "Pistol_Idle",
    sprintAnim = "Pistol_Sprint",
    reloadAnim = "Pistol_Reload",
    boltChamber = "Pistol_Chamber",
    boltClose = "Pistol_Close",
    equipAnim = "Pistol_Equip",
    patrolAnim = "Pistol_HighReady",
    holdUpAnim = "Pistol_Neutral",
    holdDownAnim = nil,
    switchAnim = "Pistol_Switch",
    reloadSpeedModifier = 1,
    sprintAnimSpeed = 0.2,
    rigParts = { "Mag", "Bolt", "ChargingHandle" },
    fireMoveParts = { "Bolt" },
    boltDist = 0.2,
    emptyLockBolt = true,
    emptyCloseBolt = false,
    recoil = {
        vertical = 2.6,
        horizontal = 1.7,
        camShake = 6,
        damping = 1.8,
        speed = 10,
        aimReduction = 2.5
    },
    gunRecoil = {
        vertical = 26,
        horizontal = 5,
        damping = 4,
        speed = 10,
        punchMultiplier = 1.4
    },
    explosiveAmmo = false,
    explosionEffect = "Default",
    explosionRadius = 30
};