-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {
    Neck = { CFrame.new(0, 1, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1), CFrame.new(0, -0.5, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1) },
    ["Left Shoulder"] = { CFrame.new(-1.3, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1), CFrame.new(0.2, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1) },
    ["Right Shoulder"] = { CFrame.new(1.3, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), CFrame.new(-0.2, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) },
    ["Left Hip"] = { CFrame.new(-0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1) },
    ["Right Hip"] = { CFrame.new(0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1) }
};
local u3 = {
    HeadRag = true,
    lArmRag = true,
    rArmRag = true,
    lLegRag = true,
    rLegRag = true,
    LFootRag = true,
    RFootRag = true,
    LHandtRig = true,
    RHandtRig = true
};

function v1.MakeCorpse(p4: userdata) -- Line: 110
    -- upvalues: u2 (copy), u3 (copy)
    local u5 = p4:FindFirstChildOfClass("Humanoid");

    if not u5 then
        local v6 = {};

        for _, child in ipairs(p4:GetChildren()) do
            table.insert(v6, child.ClassName .. ":" .. child.Name);
        end;

        warn(string.format("[RagdollMod] MakeCorpse: no Humanoid in \'%s\'. Children: %s", p4.Name, table.concat(v6, ", ")));

        return nil;
    end;

    local HumanoidRootPart = p4:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        warn(string.format("[RagdollMod] MakeCorpse: no HumanoidRootPart in \'%s\'", p4.Name));

        return nil;
    end;

    local Model = Instance.new("Model");
    Model.Parent = workspace;
    Model.Name = p4.Name .. "_Dead";
    local v7 = {};

    for _, descendant in pairs(p4:GetDescendants()) do
        if descendant:IsA("Motor6D") and descendant.Part0 then
            if descendant.Part1 then
                if descendant.Part0.Name == "HumanoidRootPart" or descendant.Part1.Name == "HumanoidRootPart" then
                    descendant.Enabled = false;
                elseif descendant.Part0.Parent == p4 or descendant.Part1.Parent == p4 then
                    local Attachment = Instance.new("Attachment");
                    local Attachment2 = Instance.new("Attachment");
                    local v8 = u2[descendant.Name];

                    if v8 then
                        Attachment.CFrame = v8[1];
                        Attachment2.CFrame = v8[2];
                    else
                        Attachment.CFrame = descendant.C0;
                        Attachment2.CFrame = descendant.C1;

                        if u5.RigType == Enum.HumanoidRigType.R6 then
                            if descendant.Part1.Name == "Left Leg" then
                                Attachment2.Position = Attachment2.Position - Vector3.new(-0.5, 0, 0);
                                Attachment.Position = Attachment.Position - Vector3.new(-0.5, 0, 0);
                            elseif descendant.Part1.Name == "Right Leg" then
                                Attachment2.Position = Attachment2.Position - Vector3.new(0.5, 0, 0);
                                Attachment.Position = Attachment.Position - Vector3.new(0.5, 0, 0);
                            end;
                        end;
                    end;

                    Attachment.Parent = descendant.Part0;
                    Attachment2.Parent = descendant.Part1;
                    local BallSocketConstraint = Instance.new("BallSocketConstraint");
                    BallSocketConstraint.Attachment0 = Attachment;
                    BallSocketConstraint.Attachment1 = Attachment2;
                    BallSocketConstraint.Parent = descendant.Part0;

                    if v8 then
                        BallSocketConstraint.Radius = 0.15;
                        BallSocketConstraint.LimitsEnabled = true;
                        BallSocketConstraint.TwistLimitsEnabled = true;
                        BallSocketConstraint.UpperAngle = 45;
                        BallSocketConstraint.TwistLowerAngle = -70;
                        BallSocketConstraint.TwistUpperAngle = 70;
                        BallSocketConstraint.Restitution = 0;
                    else
                        v7[#v7 + 1] = BallSocketConstraint;
                    end;

                    descendant:Destroy();
                end;
            end;
        end;
    end;

    local v9 = {};

    for _, descendant in ipairs(Model:GetDescendants()) do
        if descendant:IsA("BallSocketConstraint") and u3[descendant.Name] then
            v9[#v9 + 1] = descendant;
        end;
    end;

    for _, descendant in ipairs(p4:GetDescendants()) do
        if descendant:IsA("BallSocketConstraint") and u3[descendant.Name] then
            v9[#v9 + 1] = descendant;
        end;
    end;

    if #v9 > 0 then
        for _, v in ipairs(v7) do
            local v10 = v.Attachment0 and v.Attachment0.Parent;
            local v11 = v.Attachment1 and v.Attachment1.Parent;

            if v10 and (v11 and (v10:IsA("BasePart") and v11:IsA("BasePart"))) then
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Name = "CorpseProxyWeld";
                WeldConstraint.Part0 = v10;
                WeldConstraint.Part1 = v11;
                WeldConstraint.Parent = v10;
            end;

            v:Destroy();
        end;

        for _, v in ipairs(v9) do
            v:Destroy();
        end;

        Model:SetAttribute("CorpseOneSet", true);
    end;

    local v12 = p4:FindFirstChildWhichIsA("Shirt");

    if v12 then
        v12.Parent = Model;
    end;

    local v13 = p4:FindFirstChildWhichIsA("Pants");

    if v13 then
        v13.Parent = Model;
    end;

    local LimbHealth = p4:FindFirstChild("LimbHealth");

    if LimbHealth then
        LimbHealth.Parent = Model;
    end;

    for _, child in pairs(p4:GetChildren()) do
        if child:IsA("Part") then
            child.Parent = Model;
            local success, result = pcall(function() -- Line: 285
                -- upvalues: child (copy)
                if not child.Anchored then
                    child:SetNetworkOwner();
                end;

                local v14 = child:FindFirstChild(child.Name);

                if v14 then
                    v14.CFrame = child.CFrame;
                    v14.CanCollide = false;
                    child.CanCollide = false;
                    v14.skin.CanCollide = true;
                    local WeldConstraint = Instance.new("WeldConstraint");
                    WeldConstraint.Name = "ActualWeld_Between_" .. child.Name .. "_And_" .. v14.Name;
                    WeldConstraint.Part0 = child;
                    WeldConstraint.Part1 = v14;
                    WeldConstraint.Parent = child;
                end;

                if child.Name ~= "HumanoidRootPart" then
                    local Part = Instance.new("Part");
                    Part.Size = child.Size * 0.5;
                    Part.Transparency = 1;
                    Part.Massless = true;
                    local Weld = Instance.new("Weld");
                    Weld.Part0 = child;
                    Weld.Part1 = Part;
                    Weld.Parent = Part;
                    Part.Parent = child;
                end;
            end);

            if not success then
                warn(string.format("[RagdollMod] corpse part \'%s\' failed to transfer: %s -- skipped, the rest of the corpse is unaffected", child.Name, (tostring(result))));
            end;
        end;
    end;

    u5.Parent = Model;
    u5.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    local Humanoid = Instance.new("Humanoid");
    Humanoid.MaxHealth = 0;
    Humanoid.Parent = p4;

    for _, child in pairs(p4:GetChildren()) do
        if child:IsA("Accoutrement") then
            local success, result = pcall(function() -- Line: 338
                -- upvalues: child (copy), Model (copy), u5 (copy)
                child.Parent = Model;
                u5:AddAccessory(child:Clone());
                child:Destroy();
            end);

            if not success then
                warn(string.format("[RagdollMod] accessory \'%s\' failed to transfer: %s -- skipped, remaining gear still transfers", child.Name, (tostring(result))));
            end;
        elseif child:IsA("Model") then
            local success, result = pcall(function() -- Line: 349
                -- upvalues: child (copy), Model (copy)
                child.Parent = Model;
            end);

            if not success then
                warn(string.format("[RagdollMod] gear model \'%s\' failed to transfer: %s", child.Name, (tostring(result))));
            end;
        end;
    end;

    for _, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
        if v ~= Enum.HumanoidStateType.None then
            u5:SetStateEnabled(v, false);
        end;
    end;

    HumanoidRootPart.Anchored = true;
    HumanoidRootPart.CanCollide = false;
    HumanoidRootPart.CanQuery = false;
    HumanoidRootPart.CanTouch = false;

    return Model;
end;

return v1;