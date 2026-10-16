-- Decompiled with Potassium's decompiler.

return {
    weaponType = "Gun",
    projectile = "VisibleBullet",
    magType = 1,
    operationType = 1,
    fireRate = 700,
    muzzleChance = 5,
    muzzleVelocity = 735,
    aimSpeed = 0.3,
    gunLength = 2.4,
    maxPushback = 0.8,
    fireSwitch = { true, true, false, false },
    fireMode = 2,
    burstNumber = 3,
    burstFireRate = nil,
    spread = 0.7,
    shotgun = false,
    shotgunPellets = 10,
    aimFovMin = 30,
    aimTime = 0.7,
    suppressionLevel = 2,
    holster = true,
    holsterOnBackpack = true,
    holsterPart = "Torso",
    holsterPosition = CFrame.new(0.7, 0.15, -1) * CFrame.Angles(-1.2217304763960306, 0.17453292519943295, 1.3962634015954636),

    calcEjectionForce = function() -- Line: 56
        local v1 = math.random(1800, 2000) / 10;
        local v2 = math.random(180, 220) / 10;
        local v3 = math.random(330, 380) / 10;

        return Vector3.new(v1, v2, v3);
    end,

    ADSEnabled = { true, false },
    damage = {
        Head = 105,
        Torso = 32,
        Other = 24
    },
    tracers = true,
    tracerTiming = 1,
    tracerColor = Color3.fromRGB(255, 55, 55),
    ammoType = "5.45x39mm",
    shellEject = true,
    magazineCapacity = 30,
    arcadeAmmo = true,
    startAmmoPool = 0,
    maxAmmoPool = 0,
    infiniteAmmo = false,
    startChambered = true,
    bulletDrop = true,
    bulletForce = 300,
    viewmodelOffset = CFrame.new(0, 0.1, -0.3),
    viewmodelScale = 1.2,
    serverOffset = CFrame.new(0, 0, 0),
    idleAnim = "Rifle_Idle",
    sprintAnim = "Rifle_Sprint",
    reloadAnim = "AK_Reload",
    boltChamber = "AK_Chamber",
    boltClose = "AK_Close",
    equipAnim = "Rifle_Equip",
    patrolAnim = "Rifle_Sprint",
    holdUpAnim = "Rifle_Neutral",
    holdDownAnim = nil,
    switchAnim = "AK_Switch",
    fireAnim = "Rifle_Fire",
    reloadSpeedModifier = 0.8,
    rigParts = { "Mag", "Bolt", "ChargingHandle" },
    fireMoveParts = { "Bolt" },
    boltDist = 0.3,
    emptyLockBolt = false,
    emptyCloseBolt = false,
    autoChamber = true,
    recoil = {
        vertical = 0.7,
        horizontal = 0.4,
        camShake = 0.05,
        damping = 4,
        speed = 2.5,
        aimReduction = 2.5
    },
    gunRecoil = {
        vertical = 7,
        horizontal = 4,
        damping = 6,
        speed = 10,
        punchMultiplier = 0.5
    },
    gripPivotOffset = Vector3.new(0, -0.5, 1),
    weaponInertia = 0
};