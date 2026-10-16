-- Decompiled with Potassium's decompiler.

local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig);
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local u1 = false;
local u2 = false;
local Parent = script.Parent.Parent;
local Humanoid = Parent:WaitForChild("Humanoid");
local v3;

if Humanoid.RigType == Enum.HumanoidRigType.R6 then
    v3 = Parent:WaitForChild("Torso");
else
    v3 = Parent:WaitForChild("UpperTorso");
end;

local Head = Parent:FindFirstChild("Head");
local HumanoidRootPart = Parent:FindFirstChild("HumanoidRootPart");
local u4 = v3:FindFirstChild("Left Shoulder");
local u5 = nil;
Humanoid.Died:Connect(function() -- Line: 27
    -- upvalues: u1 (ref)
    u1 = true;
end);
Humanoid.Seated:Connect(function(p6, p7) -- Line: 31
    -- upvalues: u2 (ref)
    if p6 and p7:IsA("VehicleSeat") then
        u2 = true;

        return;
    end;

    u2 = false;
end);

local function CheckForBodyPartNames(p8, p9) -- Line: 40
    -- upvalues: Parent (copy)
    for _, child in ipairs(p8:GetChildren()) do
        local v10 = Parent:FindFirstChild(child.Name);

        if v10 and (v10:IsA("BasePart") and not (string.find(v10.Name, "Arm") and p9)) then
            return child;
        end;
    end;
end;

local u11 = {};

local function addDescendantsToList(p12, p13) -- Line: 61
    for _, descendant in ipairs(p12:GetDescendants()) do
        if descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal")) then
            table.insert(p13, descendant);
        end;
    end;
end;

local function buildEntry(p14) -- Line: 72
    -- upvalues: CheckForBodyPartNames (copy), u5 (ref), GameConfig (copy), Head (copy), addDescendantsToList (copy)
    if p14:IsA("BasePart") then
        local Name = p14.Name;
        local v15 = string.find(Name, "Arm") ~= nil;

        return (v15 or (string.find(Name, "Leg") or (string.find(Name, "Torso") or string.find(Name, "Foot")))) and {
            kind = "bodyPart",
            part = p14,
            armGated = v15
        } or nil;
    end;

    if not p14:IsA("Model") then
        return nil;
    end;

    if not p14:FindFirstChildWhichIsA("BasePart") then
        return nil;
    end;

    local v16 = p14:FindFirstChild("Middle") or (p14:FindFirstChild("Grip") or CheckForBodyPartNames(p14, u5 ~= nil));

    if not v16 or p14.Name == "WeaponRig" then
        if string.find(p14.Name, "Arm") then
            local v17 = {};

            for _, child in ipairs(p14:GetChildren()) do
                if child:IsA("BasePart") then
                    table.insert(v17, child);
                end;
            end;

            return {
                kind = "armModel",
                parts = v17
            };
        end;

        local v18 = #p14:GetChildren() == 1 and p14:FindFirstChildWhichIsA("BasePart");

        if not v18 then
            return nil;
        end;

        local Joints = v18:GetJoints();

        for _, v in ipairs(Joints) do
            if v.Part0 == Head or v.Part1 == Head then
                return nil;
            end;
        end;

        local v19 = { v18 };

        for _, child in ipairs(v18:GetChildren()) do
            if child:IsA("Texture") or child:IsA("Decal") then
                table.insert(v19, child);
            end;
        end;

        return {
            kind = "singlePart",
            parts = v19
        };
    end;

    if string.find(p14.Name, "Holster_") and not GameConfig.firstPersonHolsters then
        return nil;
    end;

    local Joints = v16:GetJoints();
    local v20 = false;
    local v21 = false;

    for _, v in ipairs(Joints) do
        if v.Part0 == Head or v.Part1 == Head then
            v21 = true;
            break;
        end;

        if string.find(v.Part0.Name, "Arm") or string.find(v.Part1.Name, "Arm") then
            v20 = true;
        end;
    end;

    if v21 then
        return {
            kind = "gear",
            badMorphHead = true,
            parts = {},
            hasArmWeld = v20
        };
    end;

    local v22 = {};
    addDescendantsToList(p14, v22);

    return {
        kind = "gear",
        badMorphHead = false,
        parts = v22,
        hasArmWeld = v20
    };
end;

local function cacheChild(p23) -- Line: 148
    -- upvalues: buildEntry (copy), u11 (copy)
    local v24 = buildEntry(p23);

    if v24 then
        u11[p23] = v24;
    end;
end;

local function rebuildAllCache() -- Line: 153
    -- upvalues: u11 (copy), Parent (copy), buildEntry (copy)
    table.clear(u11);

    for _, child in ipairs(Parent:GetChildren()) do
        local v25 = buildEntry(child);

        if v25 then
            u11[child] = v25;
        end;
    end;
end;

local function refreshGunEquipped() -- Line: 163
    -- upvalues: u5 (ref), Parent (copy), rebuildAllCache (copy)
    local v26 = u5;
    local v27 = Parent:FindFirstChildWhichIsA("Tool");

    if v27 and v27:FindFirstChild("SPH_Weapon") then
        u5 = v27;
    else
        u5 = nil;
    end;

    if v26 ~= nil ~= (u5 ~= nil) then
        rebuildAllCache();
    end;
end;

Parent.ChildAdded:Connect(function(p28) -- Line: 181
    -- upvalues: u5 (ref), Parent (copy), rebuildAllCache (copy), buildEntry (copy), u11 (copy)
    if not p28:IsA("Tool") then
        local v29 = buildEntry(p28);

        if v29 then
            u11[p28] = v29;
        end;

        return;
    end;

    local v30 = u5;
    local v31 = Parent:FindFirstChildWhichIsA("Tool");

    if v31 and v31:FindFirstChild("SPH_Weapon") then
        u5 = v31;
    else
        u5 = nil;
    end;

    if v30 ~= nil ~= (u5 ~= nil) then
        rebuildAllCache();
    end;

    p28.ChildAdded:Connect(function(p32) -- Line: 185
        -- upvalues: u5 (ref), Parent (ref), rebuildAllCache (ref)
        if p32.Name == "SPH_Weapon" then
            local v33 = u5;
            local v34 = Parent:FindFirstChildWhichIsA("Tool");

            if v34 and v34:FindFirstChild("SPH_Weapon") then
                u5 = v34;
            else
                u5 = nil;
            end;

            if v33 ~= nil ~= (u5 ~= nil) then
                rebuildAllCache();
            end;
        end;
    end);
end);
Parent.ChildRemoved:Connect(function(p35) -- Line: 193
    -- upvalues: u5 (ref), Parent (copy), rebuildAllCache (copy), u11 (copy)
    if p35:IsA("Tool") then
        local v36 = u5;
        local v37 = Parent:FindFirstChildWhichIsA("Tool");

        if v37 and v37:FindFirstChild("SPH_Weapon") then
            u5 = v37;
        else
            u5 = nil;
        end;

        if v36 ~= nil ~= (u5 ~= nil) then
            rebuildAllCache();
        end;
    else
        u11[p35] = nil;
    end;
end);
local v38 = u5;
local v39 = Parent:FindFirstChildWhichIsA("Tool");

if v39 and v39:FindFirstChild("SPH_Weapon") then
    u5 = v39;
else
    u5 = nil;
end;

if v38 ~= nil ~= (u5 ~= nil) then
    rebuildAllCache();
end;

rebuildAllCache();
RunService.RenderStepped:Connect(function() -- Line: 208
    -- upvalues: Parent (copy), u1 (ref), u2 (ref), Head (copy), Workspace (copy), HumanoidRootPart (copy), u4 (copy), u11 (copy)
    if not (Parent:FindFirstChild("Torso") or Parent:FindFirstChild("UpperTorso")) or (u1 or u2) then
        return;
    end;

    if Head and Head.LocalTransparencyModifier == 0 then
        return;
    end;

    local CurrentCamera = Workspace.CurrentCamera;

    if not (CurrentCamera and HumanoidRootPart) then
        return;
    end;

    if (CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Magnitude > 3 then
        return;
    end;

    local v40 = u4 and u4.Enabled;

    for _, v in pairs(u11) do
        local kind = v.kind;

        if kind == "bodyPart" then
            if not v.armGated or v40 then
                local part = v.part;

                if part.LocalTransparencyModifier ~= 0 then
                    part.LocalTransparencyModifier = 0;
                end;
            end;
        elseif kind == "gear" or kind == "singlePart" then
            local parts = v.parts;

            for i = 1, #parts do
                local v41 = parts[i];
                local v42;

                if v41.LocalTransparencyModifier == 1 then
                    v42 = i;
                else
                    v41.LocalTransparencyModifier = 1;
                    v42 = i;
                end;
            end;
        elseif kind == "armModel" and v40 then
            local parts = v.parts;

            for i = 1, #parts do
                local v43 = parts[i];
                local v44;

                if v43.LocalTransparencyModifier == 0 then
                    v44 = i;
                else
                    v43.LocalTransparencyModifier = 0;
                    v44 = i;
                end;
            end;
        end;
    end;
end);