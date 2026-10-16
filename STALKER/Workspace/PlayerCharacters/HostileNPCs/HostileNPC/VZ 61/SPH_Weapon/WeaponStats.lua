-- Decompiled with Potassium's decompiler.

return {
    weaponType = "Gun",
    projectile = "VisibleBullet",
    magType = 1,
    operationType = 1,
    fireRate = 850,
    muzzleChance = 5,
    muzzleVelocity = 320,
    aimSpeed = 0.4,
    gunLength = 1.8,
    maxPushback = 0.8,
    fireSwitch = { true, true, false, false },
    fireMode = 2,
    burstNumber = 3,
    burstFireRate = nil,
    spread = 1.5,
    shotgun = false,
    shotgunPellets = 10,
    aimFovMin = 20,
    aimTime = 0.7,
    suppressionLevel = 2,
    holster = true,
    holsterOnBackpack = true,
    holsterPart = "Torso",
    holsterPosition = CFrame.new(1.244, -0.912, 0.574) * CFrame.Angles(-0.3665191429188092, 0.06981317007977318, 0.10471975511965978),

    calcEjectionForce = function() -- Line: 56
        local v1 = math.random(1800, 2000) / 100;
        local v2 = math.random(180, 220) / 100;
        local v3 = math.random(330, 380) / 100;

        return Vector3.new(v1, v2, v3);
    end,

    ADSEnabled = { true, false },
    damage = {
        Head = 78,
        Torso = 22,
        Other = 16
    },
    tracers = true,
    tracerTiming = 1,
    tracerColor = Color3.fromRGB(255, 55, 55),
    ammoType = "9x18mm",
    shellEject = true,
    magazineCapacity = 20,
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
    idleAnim = "TEC_Idle",
    sprintAnim = "P90Sprint",
    reloadAnim = "TEC_Reload",
    boltChamber = "TEC_Chamber",
    boltClose = "Rifle_Close",
    equipAnim = "TEC_Equip",
    patrolAnim = "P90Neutral",
    holdUpAnim = "P90Neutral",
    holdDownAnim = nil,
    switchAnim = "TEC_Switch",
    reloadSpeedModifier = 0.8,
    rigParts = { "Mag", "Bolt" },
    fireMoveParts = { "Bolt" },
    boltDist = -0.35,
    emptyLockBolt = false,
    emptyCloseBolt = false,
    autoChamber = true,
    recoil = {
        vertical = 1.4,
        horizontal = 1.1,
        camShake = 2,
        damping = 2,
        speed = 8,
        aimReduction = 2
    },
    gunRecoil = {
        vertical = 10,
        horizontal = 2.5,
        damping = 4,
        speed = 8,
        punchMultiplier = 0.9
    }
};