-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");

return function(p1, p2) -- Line: 3
    -- upvalues: Debris (copy)
    local Part = Instance.new("Part");
    Part.BrickColor = BrickColor.new("Bright red");
    Part.Material = Enum.Material.Neon;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Name = "RaycastHitboxDebugPart";
    local Magnitude = p1.Magnitude;
    Part.Size = Vector3.new(0.1, 0.1, Magnitude);
    Part.CFrame = p2 * CFrame.new(0, 0, -Magnitude / 2);
    Part.Parent = workspace.Terrain;
    Debris:AddItem(Part, 1);
end;