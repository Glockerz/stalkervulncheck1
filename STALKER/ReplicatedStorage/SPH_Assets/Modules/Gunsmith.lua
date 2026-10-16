-- Decompiled with Potassium's decompiler.

local v1 = {};
local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets;
local WeldMod = require(SPH_Assets.Modules.WeldMod);
v1.attStats = {};

local function applyAttachmentData(p2, p3) -- Line: 11
    -- upvalues: SPH_Assets (copy)
    if not SPH_Assets.Attachments:FindFirstChild(p3) then
        warn(p3 .. "Not found in SPH_Assets.Attachments!");

        return p2;
    end;

    local AttStats = require(SPH_Assets.Attachments[p3].AttStats);
    local _ = SPH_Assets.Attachments[p3].AttachmentModel;

    if AttStats.fireRate then
        if p2.fireRate then
            p2.fireRate = p2.fireRate * AttStats.fireRate;
        else
            p2.fireRate = AttStats.fireRate;
        end;
    end;

    if AttStats.reloadSpeedModifier then
        if p2.reloadSpeedModifier then
            p2.reloadSpeedModifier = p2.reloadSpeedModifier * AttStats.reloadSpeedModifier;
        else
            p2.reloadSpeedModifier = AttStats.reloadSpeedModifier;
        end;
    end;

    if AttStats.gunLength then
        if p2.gunLength then
            p2.gunLength = p2.gunLength + AttStats.gunLength;
        else
            p2.gunLength = AttStats.gunLength;
        end;
    end;

    if AttStats.recoil then
        if p2.recoil then
            local recoil = p2.recoil;
            recoil.vertical = recoil.vertical * AttStats.recoil.vertical;
            local recoil2 = p2.recoil;
            recoil2.horizontal = recoil2.horizontal * AttStats.recoil.horizontal;
            local recoil3 = p2.recoil;
            recoil3.camShake = recoil3.camShake * AttStats.recoil.camShake;
            local recoil4 = p2.recoil;
            recoil4.damping = recoil4.damping * AttStats.recoil.damping;
            local recoil5 = p2.recoil;
            recoil5.speed = recoil5.speed * AttStats.recoil.speed;
            local recoil6 = p2.recoil;
            recoil6.aimReduction = recoil6.aimReduction * AttStats.recoil.aimReduction;
        else
            p2.recoil = AttStats.recoil;
        end;
    end;

    if AttStats.gunRecoil then
        if p2.gunRecoil then
            local gunRecoil = p2.gunRecoil;
            gunRecoil.vertical = gunRecoil.vertical * AttStats.gunRecoil.vertical;
            local gunRecoil2 = p2.gunRecoil;
            gunRecoil2.horizontal = gunRecoil2.horizontal * AttStats.gunRecoil.horizontal;
            local gunRecoil3 = p2.gunRecoil;
            gunRecoil3.damping = gunRecoil3.damping * AttStats.gunRecoil.damping;
            local gunRecoil4 = p2.gunRecoil;
            gunRecoil4.speed = gunRecoil4.speed * AttStats.gunRecoil.speed;
            local gunRecoil5 = p2.gunRecoil;
            gunRecoil5.punchMultiplier = gunRecoil5.punchMultiplier * AttStats.gunRecoil.punchMultiplier;
        else
            p2.gunRecoil = AttStats.gunRecoil;
        end;
    end;

    if AttStats.aimFovDefault then
        p2.aimFovDefault = AttStats.aimFovDefault;
    end;

    if AttStats.aimFovMin then
        p2.aimFovMin = AttStats.aimFovMin;
    end;

    if AttStats.aimTime then
        if p2.aimTime then
            p2.aimTime = p2.aimTime * AttStats.aimTime;
        else
            p2.aimTime = AttStats.aimTime;
        end;
    end;

    if AttStats.magazineCapacity then
        p2.magazineCapacity = AttStats.magazineCapacity;
    end;

    if AttStats.magazineExtension then
        p2.magazineCapacity = p2.magazineCapacity + AttStats.magazineExtension;
    end;

    if AttStats.maxAmmoPool then
        p2.maxAmmoPool = AttStats.maxAmmoPool;
    end;

    if AttStats.startAmmoPool then
        p2.startAmmoPool = AttStats.startAmmoPool;
    end;

    if AttStats.damage then
        if p2.damage then
            local damage = p2.damage;
            damage.Head = damage.Head * AttStats.damage.Head;
            local damage2 = p2.damage;
            damage2.Torso = damage2.Torso * AttStats.damage.Torso;
            local damage3 = p2.damage;
            damage3.Other = damage3.Other * AttStats.damage.Other;
        else
            p2.damage = AttStats.damage;
        end;
    end;

    if AttStats.muzzleVelocity then
        if p2.muzzleVelocity then
            p2.muzzleVelocity = p2.muzzleVelocity * AttStats.muzzleVelocity;
        else
            p2.muzzleVelocity = AttStats.muzzleVelocity;
        end;
    end;

    if AttStats.muzzleVelocityReplace then
        p2.muzzleVelocityReplace = AttStats.muzzleVelocityReplace;
    end;

    if AttStats.tracers then
        p2.tracers = AttStats.tracers;
        p2.tracerTiming = AttStats.tracerTiming;
        p2.tracerColor = AttStats.tracerColor;
    end;

    if AttStats.explosiveAmmo then
        p2.explosiveAmmo = AttStats.explosiveAmmo;
        p2.explosionEffect = AttStats.explosionEffect;
        p2.explosionRadius = AttStats.explosionRadius;
    end;

    if AttStats.muzzleChance then
        p2.muzzleChance = AttStats.muzzleChance;
    end;

    if AttStats.ammoType then
        p2.ammoType = AttStats.ammoType;
    end;

    if AttStats.customBehavior then
        if p2.customBehaviors then
            table.insert(p2.customBehaviors, AttStats.customBehavior);
        else
            p2.customBehaviors = { AttStats.customBehavior };
        end;
    end;

    local AttachmentModel = SPH_Assets.Attachments[p3]:FindFirstChild("AttachmentModel");

    if AttachmentModel then
        if AttachmentModel.Main:FindFirstChild("Muzzle") then
            p2.newMuzzleDevice = p3;
        end;

        if AttachmentModel.Main:FindFirstChild("Fire") then
            p2.newFireSound = true;
        end;

        if AttachmentModel.Main:FindFirstChild("Laser") then
            p2.laserOrigin = p3;
        end;

        if AttachmentModel.Main:FindFirstChild("Bipod") then
            p2.Bipod = p3;
        end;
    end;

    return p2;
end;

local function applyRecursiveAttachments(p4, p5) -- Line: 174
    -- upvalues: applyAttachmentData (copy), applyRecursiveAttachments (copy)
    if not p5 or p5 == "" then
        return p4;
    end;

    if typeof(p5) == "string" then
        return applyAttachmentData(p4, p5);
    end;

    if typeof(p5) == "table" then
        local v6 = p5[2];
        applyAttachmentData(p4, p5[1]);

        for _, v in pairs(v6) do
            applyRecursiveAttachments(p4, v);
        end;
    end;

    return p4;
end;

function v1.placeAttachment(p7, p8, p9, p10) -- Line: 192
    -- upvalues: SPH_Assets (copy), WeldMod (copy)
    if not p8 then
        warn("attachmentSlot for " .. p7 .. " not found");

        return;
    end;

    if not p9 then
        warn("weaponAttachment for " .. p7.Name .. " in " .. p8 .. " not found");

        return;
    end;

    if SPH_Assets.Attachments:FindFirstChild(p9) then
        local v11 = SPH_Assets.Attachments[p9].AttachmentModel:Clone();
        v11.Parent = p7;
        v11.Name = p9;

        if v11.PrimaryPart then
            v11:SetPrimaryPartCFrame(p10[p8].CFrame);
            WeldMod.WeldModel(v11, p10[p8], false);
        else
            warn("Attachment " .. p9 .. " has no PrimaryPart and cannot be positioned properly!");
        end;

        if v11.Main:FindFirstChild("Muzzle") then
            p7.Grip.Muzzle.WorldCFrame = v11.Main.Muzzle.WorldCFrame;
        end;

        return v11;
    end;

    warn("Model for " .. p9 .. " not found");
end;

function v1.getAttStats(p12, p13) -- Line: 223
    -- upvalues: applyRecursiveAttachments (copy)
    local v14 = {};

    if p12 then
        for _, v in pairs(p12) do
            v14 = applyRecursiveAttachments(v14, v, p13);
        end;

        if p13 then
            for _, child in pairs(p13:GetChildren()) do
                if child:IsA("Model") and (child:FindFirstChild("Main") and child.Main:FindFirstChild("Flashlight")) then
                    if not v14.flashlights_server then
                        v14.flashlights_server = {};
                    end;

                    table.insert(v14.flashlights_server, child);
                end;
            end;
        end;

        return v14;
    end;
end;

return v1;