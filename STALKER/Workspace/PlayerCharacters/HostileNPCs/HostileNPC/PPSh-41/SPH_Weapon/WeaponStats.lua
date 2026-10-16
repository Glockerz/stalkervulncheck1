-- Decompiled with Potassium's decompiler.

return {
    weaponType = "Gun",
    projectile = "VisibleBullet",
    magType = 1,
    operationType = 1,
    fireRate = 900,
    muzzleChance = 5,
    muzzleVelocity = 350,
    aimSpeed = 0.5,
    gunLength = 2.6,
    maxPushback = 0.8,
    fireSwitch = { true, true, false, false },
    fireMode = 2,
    burstNumber = 3,
    burstFireRate = nil,
    spread = 1,
    shotgun = false,
    shotgunPellets = 10,
    aimFovMin = 50,
    aimTime = 0.5,
    suppressionLevel = 1,
    holster = true,
    holsterOnBackpack = true,
    holsterPart = "Torso",
    holsterPosition = CFrame.new(0.7, 0.15, -1) * CFrame.Angles(-1.2217304763960306, 0.17453292519943295, 1.3962634015954636),

    calcEjectionForce = function() -- Line: 92
        local v1 = math.random(1800, 2000) / 10;
        local v2 = math.random(180, 220) / 10;
        local v3 = math.random(330, 380) / 10;

        return Vector3.new(v1, v2, v3);
    end,

    ADSEnabled = { true, false },
    damage = {
        Head = 95,
        Torso = 28,
        Other = 20
    },
    tracers = true,
    tracerTiming = 4,
    tracerColor = Color3.fromRGB(255, 55, 55),
    ammoType = "7.62x25mm",
    shellEject = true,
    magazineCapacity = 35,
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
    idleAnim = "PPSH41_Idle",
    openBolt = true,
    sprintAnim = "Rifle_Sprint",
    reloadAnim = "PPSH41_Reload",
    boltChamber = "PPSH41_Chamber",
    boltClose = "PPSH41_Close",
    equipAnim = "PPSH41_Equip",
    patrolAnim = "Rifle_Sprint",
    holdUpAnim = "Rifle_Neutral",
    holdDownAnim = nil,
    switchAnim = nil,
    fireAnim = "PPSH41_Fire",
    reloadSpeedModifier = 0.9,
    rigParts = { "Back", "Barrel", "Bolt", "Cap", "FrontSight", "MagazineWell", "RearSight", "Release", "Stock", "Switch", "TacticalMagazine", "Thread", "Trigger" },
    fireMoveParts = { "Bolt" },
    boltDist = 0.17,
    emptyLockBolt = false,
    emptyCloseBolt = false,
    autoChamber = true,
    recoil = {
        vertical = 1.8,
        horizontal = 1,
        camShake = 1.2,
        damping = 1,
        speed = 7,
        aimReduction = 2.5
    },
    gunRecoil = {
        vertical = 8,
        horizontal = 1.8,
        damping = 2,
        speed = 10,
        punchMultiplier = 0.5
    },
    gripPivotOffset = Vector3.new(0, -0.5, 1),
    weaponInertia = 0
};