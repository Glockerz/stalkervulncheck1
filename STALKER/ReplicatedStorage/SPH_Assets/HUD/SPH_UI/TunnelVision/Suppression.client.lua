-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local v1 = ReplicatedStorage:FindFirstChild("Suppression") or Instance.new("BindableEvent", ReplicatedStorage);
v1.Name = "Suppression";
local npcSuppression = ReplicatedStorage.miscEvents:WaitForChild("npcSuppression", 10);
local Children = ReplicatedStorage.SPH_Assets.Sounds.BulletCrack:GetChildren();
local script_Parent = script.Parent;
script_Parent.ImageTransparency = 1;

local function applySuppression(p2) -- Line: 14
    -- upvalues: Children (copy), Debris (copy), script_Parent (copy)
    local v3 = Children[math.random(#Children)]:Clone();
    Instance.new("DistortionSoundEffect", v3);
    v3.Parent = script;
    v3.Volume = p2;
    v3:Play();
    Debris:AddItem(v3, v3.TimeLength);
    local v4 = script_Parent;
    v4.ImageTransparency = v4.ImageTransparency - p2 / 10;
end;

v1.Event:Connect(applySuppression);
npcSuppression.OnClientEvent:Connect(function(p5) -- Line: 27
    -- upvalues: applySuppression (copy)
    applySuppression(p5);
end);
RunService.Heartbeat:Connect(function(p6) -- Line: 31
    -- upvalues: script_Parent (copy)
    script_Parent.ImageTransparency = script_Parent.ImageTransparency + (1 - script_Parent.ImageTransparency) * 0.003 * 60 * p6;
end);