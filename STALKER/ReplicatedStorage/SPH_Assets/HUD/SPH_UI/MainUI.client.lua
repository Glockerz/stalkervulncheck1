-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets;
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAppearanceLoaded:Wait();
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local u6 = nil;
local Ammo = script.Parent.Ammo;
script.Parent.Version.Text = "Spearhead " .. require(SPH_Assets.GameConfig).version;
local AmmoLabel = Ammo.Ammo.Ammo.AmmoLabel;
local MagazineLabel = Ammo.Ammo.Ammo.MagazineLabel;
local AmmoType = Ammo.Other.AmmoType;
local Firemode = Ammo.Firemode.Firemode;
local Chambered = Ammo.Ammo.Ammo.Chambered;
local u7 = { "SAFE", "[SEMI]", "[AUTO]", "[BURST]", "[MANUAL]" };
local UserInputService = game:GetService("UserInputService");
local Sens = Ammo.Firemode.Sens;

function splitNumber(p8)
    local v9 = tostring(p8);
    local v10 = "";
    local v11 = 3 - #v9;
    local v12;

    if v11 > 0 then
        v12 = v9;

        for i = 1, v11 do
            v10 = v10 .. "0";
            local _ = i;
        end;
    else
        v12 = v9;
    end;

    if #v9 > 3 then
        v12 = v9:sub(-3);
        v10 = "";
    end;

    return { v10, v12 };
end;

u1.ChildAdded:Connect(function(p13) -- Line: 54
    -- upvalues: SPH_Assets (copy), u5 (ref), u2 (ref), u3 (ref), u6 (ref), AmmoType (copy), u1 (copy), u4 (ref)
    if p13:FindFirstChild("SPH_Weapon") and (SPH_Assets.WeaponModels:FindFirstChild(p13.Name) and not u5) then
        u2 = p13;
        u3 = u2:WaitForChild("Ammo").MagAmmo;
        u6 = require(u2.SPH_Weapon.WeaponStats);
        AmmoType.Text = u6.ammoType;
        u4 = (u1.AmmoPool:FindFirstChild(u6.ammoType) or u1.AmmoPool.Universal).CurrentValue;
    end;
end);
u1.ChildRemoved:Connect(function(p14) -- Line: 67
    -- upvalues: u2 (ref)
    if p14 == u2 then
        u2 = nil;
    end;
end);
RunService.Heartbeat:Connect(function() -- Line: 73
    -- upvalues: u2 (ref), u6 (ref), u3 (ref), u5 (ref), Ammo (copy), AmmoLabel (copy), MagazineLabel (copy), u4 (ref), Chambered (copy), Firemode (copy), u7 (copy), Sens (copy), UserInputService (copy), LocalPlayer (copy)
    if u2 and (u2:FindFirstChild("Chambered") or u6.openBolt) and (u3 and not u5) then
        Ammo.Visible = true;

        if not u6.operationType or type(u6.operationType) == "string" then
            u6.operationType = 1;
        end;

        if u6.operationType == 4 and u2.Chambered.Value then
            local v15 = splitNumber(u3.Value + 1);
            AmmoLabel.Text = "<font transparency=\"0.5\">" .. v15[1] .. "</font>" .. v15[2];
        else
            local v16 = splitNumber(u3.Value);
            AmmoLabel.Text = "<font transparency=\"0.5\">" .. v16[1] .. "</font>" .. v16[2];
        end;

        MagazineLabel.Text = "/";

        if u6.infiniteAmmo then
            MagazineLabel.Text = MagazineLabel.Text .. "INF";
        else
            MagazineLabel.Text = MagazineLabel.Text .. u4.Value;
        end;

        if u2.FireMode.Value == 0 then
            AmmoLabel.TextColor3 = Color3.new(0.5, 0.5, 0.5);
        elseif (not u6.openBolt or u3.Value <= 0) and (u6.openBolt or not u2.Chambered.Value) then
            Chambered.TextTransparency = 1;
            AmmoLabel.TextColor3 = Color3.new(1, 0, 0);
        else
            if u6.openBolt then
                Chambered.TextTransparency = 1;
            else
                Chambered.TextTransparency = 0;
            end;

            AmmoLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
        end;

        Firemode.Text = u7[u2.FireMode.Value + 1];
        Sens.Text = string.format("%.2f", UserInputService.MouseDeltaSensitivity);
        local v17 = nil;
        local v18;

        if u6.SightAtt then
            v18 = game.Workspace.Camera.WeaponRig.Weapon[u2.Name]:FindFirstChild(u6.SightAtt);
        else
            v18 = game.Workspace.Camera.WeaponRig.Weapon[u2.Name];
        end;

        if v18 and (v18:FindFirstChild("SightReticle") and v18.SightReticle.SurfaceGui.Frame.Reticle:FindFirstChild("Frame")) then
            v17 = v18.SightReticle.SurfaceGui.Frame.Reticle.Frame.Range;
        end;

        if LocalPlayer:GetAttribute("rangefinderActive") then
            Ammo.TargetRange.Visible = true;

            if v17 then
                v17.Visible = true;
            end;

            if LocalPlayer:GetAttribute("tgtDistance") then
                local TargetRange = Ammo.TargetRange;
                local Attribute = LocalPlayer:GetAttribute("tgtDistance");
                TargetRange.Text = "Distance: " .. math.floor(Attribute) .. " m";

                if v17 then
                    local Attribute2 = LocalPlayer:GetAttribute("tgtDistance");
                    v17.Text = math.floor(Attribute2);
                end;
            else
                Ammo.TargetRange.Text = "Distance: --- m";

                if v17 then
                    v17.Text = "--";
                end;
            end;
        else
            Ammo.TargetRange.Visible = false;

            if v17 then
                v17.Visible = false;
            end;
        end;
    else
        Ammo.Visible = false;
    end;
end);
u1.Humanoid.Died:Connect(function() -- Line: 149
    -- upvalues: u5 (ref)
    u5 = true;
end);