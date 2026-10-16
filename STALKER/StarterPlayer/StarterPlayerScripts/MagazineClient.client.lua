-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
PlayerGui.DescendantAdded:Connect(function(p1) -- Line: 21
    if p1.Name == "Ammo" and (p1:IsA("Frame") and (p1.Parent and p1.Parent.Name == "Ammo")) then
        p1.Visible = false;
    end;
end);
task.spawn(function() -- Line: 31
    -- upvalues: PlayerGui (copy)
    for _, descendant in pairs(PlayerGui:GetDescendants()) do
        if descendant.Name == "Ammo" and (descendant:IsA("Frame") and (descendant.Parent and descendant.Parent.Name == "Ammo")) then
            descendant.Visible = false;
        end;
    end;
end);
print("[MagazineClient] Initialized");