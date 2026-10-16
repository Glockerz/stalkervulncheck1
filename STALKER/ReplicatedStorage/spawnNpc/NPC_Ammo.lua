-- Decompiled with Potassium's decompiler.

local u4 = {
    IsGunLoaded = function(p1, p2) -- Line: 3, Name: IsGunLoaded
        if p2.openBolt then
            local v3 = p1:FindFirstChild("Ammo") and p1.Ammo.MagAmmo.Value > 0;

            return v3;
        end;

        local Chambered = p1:FindFirstChild("Chambered");

        if Chambered then
            Chambered = Chambered.Value == true;
        end;

        return Chambered;
    end
};

function u4.ConsumeAmmo(p5, p6) -- Line: 11
    -- upvalues: u4 (copy)
    if not u4.IsGunLoaded(p5, p6) then
        return false;
    end;

    local Ammo = p5:FindFirstChild("Ammo");

    if not Ammo then
        return false;
    end;

    local MagAmmo = Ammo.MagAmmo;

    if p6.openBolt then
        MagAmmo.Value = MagAmmo.Value - 1;
        p5.BoltReady.Value = MagAmmo.Value > 0 and true or not p6.emptyLockBolt;

        return true;
    end;

    local Chambered = p5:FindFirstChild("Chambered");

    if Chambered then
        Chambered.Value = false;
    end;

    if p6.fireMode == 4 then
        p5.BoltReady.Value = false;

        return true;
    end;

    p5.BoltReady.Value = not p6.emptyLockBolt;

    if MagAmmo.Value > 0 then
        MagAmmo.Value = MagAmmo.Value - 1;

        if Chambered then
            Chambered.Value = true;
        end;

        p5.BoltReady.Value = true;
    end;

    return true;
end;

function u4.Reload(p7, p8) -- Line: 40
    local Ammo = p7:FindFirstChild("Ammo");

    if not Ammo then
        return;
    end;

    local MagAmmo = Ammo.MagAmmo;
    local ArcadeAmmoPool = Ammo.ArcadeAmmoPool;

    if not (MagAmmo and ArcadeAmmoPool) then
        return;
    end;

    if p8.infiniteAmmo then
        MagAmmo.Value = MagAmmo.MaxValue;
    elseif ArcadeAmmoPool.Value > 0 then
        local v9 = MagAmmo.MaxValue - MagAmmo.Value;

        if v9 > 0 then
            if v9 < ArcadeAmmoPool.Value then
                MagAmmo.Value = MagAmmo.MaxValue;
                ArcadeAmmoPool.Value = ArcadeAmmoPool.Value - v9;
            else
                MagAmmo.Value = MagAmmo.Value + ArcadeAmmoPool.Value;
                ArcadeAmmoPool.Value = 0;
            end;
        end;
    end;

    if p8.operationType == 4 and (p7:FindFirstChild("Chambered") and not p7.Chambered.Value) then
        p7.Chambered.Value = true;
        MagAmmo.Value = math.max(0, MagAmmo.Value - 1);
    end;
end;

function u4.NeedsReload(p10, p11) -- Line: 82
    local Ammo = p10:FindFirstChild("Ammo");

    if not Ammo then
        return false;
    end;

    local MagAmmo = Ammo.MagAmmo;

    if not p11.infiniteAmmo then
        local ArcadeAmmoPool = Ammo:FindFirstChild("ArcadeAmmoPool");

        if ArcadeAmmoPool and (ArcadeAmmoPool.Value <= 0 and (MagAmmo and MagAmmo.Value <= 0)) then
            return false;
        end;
    end;

    if p11.openBolt then
        return MagAmmo.Value <= 0;
    end;

    local Chambered = p10:FindFirstChild("Chambered");

    if Chambered and Chambered.Value then
        return false;
    end;

    return MagAmmo.Value <= 0;
end;

function u4.NeedsChamber(p12, p13, p14, p15) -- Line: 98
    if p13.openBolt or (p14 or p15) then
        return false;
    end;

    local Chambered = p12:FindFirstChild("Chambered");
    local BoltReady = p12:FindFirstChild("BoltReady");
    local v16 = p12.Ammo and p12.Ammo.MagAmmo;

    if not (Chambered and (BoltReady and v16)) then
        return false;
    end;

    if v16.Value <= 0 and not Chambered.Value then
        return false;
    end;

    if not BoltReady.Value and v16.Value <= 0 then
        return false;
    end;

    return not BoltReady.Value or not Chambered.Value and v16.Value > 0;
end;

return u4;