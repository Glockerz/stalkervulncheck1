-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("Players");

function v1.armorDamage(p2, p3, p4, p5) -- Line: 4
    local v6 = p5.SPH_Weapon:FindFirstChild("BulletPhysics") and (require(p5.SPH_Weapon.BulletPhysics).armorPen or 10) or 10;

    if p2 then
        local Value = p2[p4.Name == "Head" and "helmetProtection" or "vestProtection"].Value;

        if v6 < Value then
            p3 = math.max(0.5, p3 * (v6 / Value));
        end;
    end;

    return p3;
end;

function v1.equipArmor(p7, p8, p9, p10) -- Line: 20
    local Parent = p7.Parent;
    local Value = p8.Type.Value;

    if not Parent:FindFirstChild(Value) then
        weldArmor(p7, Value, p8.Model, p8.Target.Value, p9);

        if Value == "Helmet" or p8.Target.Value == "Head" then
            HideHats(Parent);
        end;

        GiveArmorValue(p7, p8);
        p7:UnequipTools();
        p10:Destroy();
    end;
end;

function v1.removeArmor(p11, p12) -- Line: 37
    print(p11);
    print(p12);
    local Value = p12.Preset.Value;
    local Character = p11.Character;

    if not Character then
        return;
    end;

    local Humanoid = Character:FindFirstChild("Humanoid");

    if not Humanoid then
        return;
    end;

    local Value2 = Value.Type.Value;
    local v13 = Character:FindFirstChild(Value2);

    if not v13 then
        return;
    end;

    v13:Destroy();

    if not (Value2 ~= "Helmet" and Value.Target.Value ~= "Head" or (Character:FindFirstChild("Eyes") or Character:FindFirstChild("Helmet"))) then
        ShowHats(Character);
    end;

    Humanoid:UnequipTools();
    local v14 = script.armorToolTemplate:Clone();
    v14.Preset.Value = Value;
    v14.Name = Value.Name;
    LoseArmorValue(Humanoid, Value);
    v14.Parent = p11.Backpack;
end;

function weldArmor(p15, p16, p17, p18, p19)
    local Parent = p15.Parent;

    if Parent:FindFirstChild(p16) then
        return;
    end;

    local v20 = p17:Clone();
    v20.Name = p16;
    v20.Parent = Parent;
    local Middle = v20.Middle;
    local v21 = Middle.CFrame:Inverse();

    for _, child in ipairs(v20:GetChildren()) do
        if child:IsA("BasePart") then
            local Weld = Instance.new("Weld");
            Weld.Part0 = Middle;
            Weld.Part1 = child;
            local CFrame_new_ret = CFrame.new(Middle.Position);
            Weld.C0 = v21 * CFrame_new_ret;
            Weld.C1 = child.CFrame:Inverse() * CFrame_new_ret;
            Weld.Parent = Middle;
            child.Anchored = false;
            child.CanCollide = false;
        elseif child:IsA("Script") then
            child.Enabled = true;
        end;
    end;

    local v22 = Parent:FindFirstChild(p18);

    if v22 then
        local Weld = Instance.new("Weld");
        Weld.Part0 = v22;
        Weld.Part1 = Middle;
        Weld.C0 = CFrame.identity;
        Weld.Parent = v22;
    end;

    if p19 ~= 0 then
        local Patch = v20:FindFirstChild("Patch");

        if Patch then
            Patch = Patch:FindFirstChild("Patch");
        end;

        if Patch then
            Patch.Texture = "rbxassetid://" .. p19;
        end;
    end;
end;

function GiveArmorValue(p23, p24)
    local armorFolder = p23.Parent:FindFirstChild("armorFolder");

    if not armorFolder then
        return;
    end;

    local HelmetProtect = p24:FindFirstChild("HelmetProtect");
    local VestProtect = p24:FindFirstChild("VestProtect");

    if HelmetProtect then
        armorFolder.helmetProtection.Value = HelmetProtect.Value;

        return;
    end;

    if VestProtect then
        armorFolder.vestProtection.Value = VestProtect.Value;
    end;
end;

function LoseArmorValue(p25, p26)
    local armorFolder = p25.Parent:FindFirstChild("armorFolder");

    if not armorFolder then
        return;
    end;

    if p26.Type.Value == "Helmet" then
        armorFolder.helmetProtection.Value = 0;

        return;
    end;

    if p26.Type.Value == "Vest" then
        armorFolder.vestProtection.Value = 0;
    end;
end;

function HideHats(p27)
    for _, child in ipairs(p27:GetChildren()) do
        if child:IsA("Accessory") then
            for _, child2 in ipairs(child:GetChildren()) do
                if child2:IsA("BasePart") then
                    child2.Transparency = 1;
                end;
            end;
        end;
    end;
end;

function ShowHats(p28)
    for _, child in ipairs(p28:GetChildren()) do
        if child:IsA("Accessory") then
            for _, child2 in ipairs(child:GetChildren()) do
                if child2:IsA("BasePart") then
                    child2.Transparency = 0;
                end;
            end;
        end;
    end;
end;

function v1.armorSetup() -- Line: 176
    for _, child in ipairs(script.armorConfigFolder:GetChildren()) do
        local Model = child:FindFirstChild("Model");

        if Model and not Model:FindFirstChild("Preset") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Preset";
            ObjectValue.Value = child;
            ObjectValue.Parent = Model;
        end;
    end;
end;

return v1;