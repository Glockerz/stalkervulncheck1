-- Decompiled with Potassium's decompiler.

return {
    weaponType = "Gun",
    projectile = "VisibleBullet",
    magType = 3,
    operationType = 2,
    fireRate = 400,
    muzzleChance = 6,
    muzzleVelocity = 715,
    aimSpeed = 0.3,
    gunLength = 3.2,
    maxPushback = 0.8,
    fireSwitch = { true, true, false, false },
    fireMode = 1,
    burstNumber = 3,
    burstFireRate = nil,
    spread = 0.8,
    shotgun = false,
    shotgunPellets = 10,
    aimFovMin = 30,
    aimFovDefault = 57,
    aimTime = 0.7,
    suppressionLevel = 2,
    holster = true,
    holsterOnBackpack = true,
    holsterPart = "Torso",
    holsterPosition = CFrame.new(0.7, 0.15, -1) * CFrame.Angles(-1.2217304763960306, 0.17453292519943295, 1.3962634015954636),

    calcEjectionForce = function() -- Line: 76
        local v1 = math.random(1800, 2000) / 10;
        local v2 = math.random(180, 220) / 10;
        local v3 = math.random(330, 380) / 10;

        return Vector3.new(v1, v2, v3);
    end,

    ADSEnabled = { true, false },
    damage = {
        Head = 120,
        Torso = 38,
        Other = 28
    },
    tracers = true,
    tracerTiming = 1,
    tracerColor = Color3.fromRGB(255, 55, 55),
    ammoType = "7.62x39mm",
    shellEject = true,
    magazineCapacity = 10,
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
    idleAnim = "SKS_Idle",
    boltOpen = "SKS_BoltOpen",
    clipReloadAnim = "SKS_ReloadClip",
    sprintAnim = "Rifle_Sprint",
    reloadAnim = "SKS_LoadBullet",
    boltChamber = "SKS_Chamber",
    boltClose = "SKS_BoltClose",
    equipAnim = "SKS_Equip",
    patrolAnim = "Rifle_Sprint",
    holdUpAnim = "Rifle_Neutral",
    holdDownAnim = nil,
    switchAnim = nil,
    fireAnim = "SKS_Fire",
    reloadSpeedModifier = 0.8,
    rigParts = { "Bolt", "Bullet", "Cartridges", "Clip", "Follower" },
    fireMoveParts = {},
    boltDist = 0,
    emptyLockBolt = false,
    emptyCloseBolt = false,
    autoChamber = true,
    recoil = {
        vertical = 0.78,
        horizontal = 0.4,
        camShake = 0.04,
        damping = 4,
        speed = 2.5,
        aimReduction = 2.5
    },
    gunRecoil = {
        vertical = 7,
        horizontal = 4,
        damping = 6,
        speed = 10,
        punchMultiplier = 0.45
    },
    gripPivotOffset = Vector3.new(0, -0.5, 1),
    weaponInertia = 0
};