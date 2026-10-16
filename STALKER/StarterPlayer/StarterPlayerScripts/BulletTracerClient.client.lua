-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 100);
local bulletTracer = ReplicatedStorage:WaitForChild("miscEvents"):WaitForChild("bulletTracer");
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.IgnoreWater = true;
bulletTracer.OnClientEvent:Connect(function(p1, p2) -- Line: 27
    -- upvalues: RaycastParams_new_ret (copy), Color3_fromRGB_ret (copy), TweenService (copy), Debris (copy)
    if typeof(p1) ~= "Vector3" or typeof(p2) ~= "Vector3" then
        return;
    end;

    if p2.Magnitude < 0.001 then
        return;
    end;

    local Unit = p2.Unit;
    local v3 = p1 + Unit * 300;
    local v4 = workspace:Raycast(p1, Unit * 300, RaycastParams_new_ret);

    if v4 then
        v3 = v4.Position;
    end;

    local Magnitude = (v3 - p1).Magnitude;

    if Magnitude < 0.5 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3_fromRGB_ret;
    Part.Size = Vector3.new(0.08, 0.08, Magnitude);
    Part.CFrame = CFrame.lookAt((p1 + v3) / 2, v3);
    Part.Transparency = 0.25;
    Part.Parent = workspace;
    TweenService:Create(Part, TweenInfo.new(0.08), {
        Transparency = 1
    }):Play();
    Debris:AddItem(Part, 0.13);
end);