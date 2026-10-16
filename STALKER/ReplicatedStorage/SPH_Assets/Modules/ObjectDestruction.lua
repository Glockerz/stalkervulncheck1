-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GameConfig = require(ReplicatedStorage.SPH_Assets.GameConfig);
local Destruction = ReplicatedStorage.SPH_Assets.Sounds.Destruction;
local v1 = {};

local function PlaySoundAtLocation(p2, p3) -- Line: 6
    -- upvalues: Destruction (copy)
    local v4 = Destruction:FindFirstChild(p3);

    if v4 then
        local Attachment = Instance.new("Attachment", workspace.Terrain);
        Attachment.Name = "TempDestructionSound";
        Attachment.WorldPosition = p2;
        local v5 = v4:Clone();
        v5.Parent = Attachment;
        v5:Play();
        task.delay(v5.TimeLength, function() -- Line: 17
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
    end;
end;

function v1.DestroyObject(u6: userdata, p7: any) -- Line: 23
    -- upvalues: PlaySoundAtLocation (copy), ReplicatedStorage (copy), GameConfig (copy)
    u6:SetAttribute("Destroyed", true);
    local Attribute = u6:GetAttribute("DestructionType");
    local v8 = u6:IsA("Model");
    local Attribute2 = u6:GetAttribute("DestructionSound");

    if v8 then
        for _, descendant in u6:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CollisionGroup = "Debris";
                local v9 = descendant;

                for _, v in descendant:GetJoints() do
                    v.Enabled = false;
                end;

                for _, child in v9:GetChildren() do
                    if child:IsA("Constraint") then
                        child.Enabled = false;
                    end;
                end;

                if p7 then
                    v9:SetNetworkOwner(p7);
                end;
            elseif descendant:IsA("Constraint") or descendant:IsA("JointInstance") then
                descendant.Enabled = false;
            end;
        end;

        if Attribute2 then
            local v10;

            if u6.PrimaryPart then
                v10 = u6.PrimaryPart.Position;
            else
                v10 = u6.WorldPivot.Position;
            end;

            PlaySoundAtLocation(v10, Attribute2);
        end;
    else
        u6.Anchored = false;
        u6.CollisionGroup = "Debris";

        for _, v in u6:GetJoints() do
            v.Enabled = false;
        end;

        for _, child in u6:GetChildren() do
            if child:IsA("Constraint") then
                child.Enabled = false;
            end;
        end;

        if p7 then
            u6:SetNetworkOwner(p7);
        end;

        if Attribute2 then
            PlaySoundAtLocation(u6.Position, Attribute2);
        end;
    end;

    if Attribute == "Instant" then
        u6:Destroy();

        return;
    end;

    if Attribute ~= "Explosion" then
        task.delay(GameConfig.destructibleDespawnTime, function() -- Line: 99
            -- upvalues: u6 (copy)
            u6:Destroy();
        end);

        return;
    end;

    local v11 = u6:GetAttribute("ExplosionType") or "Default";
    local v12 = u6:IsA("Model") and u6:GetPivot().Position or u6.Position;
    local v13 = u6:GetAttribute("ExplosionRadius") or 20;
    local ExplosionFX = require(ReplicatedStorage.SPH_Assets.Modules.ExplosionFX);
    u6:Destroy();
    ExplosionFX(v12, v13, v11, p7);
end;

return v1;