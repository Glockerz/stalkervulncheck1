-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local NorthEast = script.Parent:WaitForChild("NorthEast");
local SouthWest = script.Parent:WaitForChild("SouthWest");
RunService.Heartbeat:Connect(function() -- Line: 7
    -- upvalues: SouthWest (copy), NorthEast (copy)
    local CurrentCamera = game.Workspace.CurrentCamera;
    local v1 = CurrentCamera.CFrame:VectorToObjectSpace(((Vector3.new(0, 0, -10000000) - CurrentCamera.CFrame.Position) * Vector3.new(1, 0, 1)).Unit);
    local v2 = math.atan2(v1.X, -v1.Z) / 3.141592653589793;

    if v2 > 0 then
        SouthWest.Position = UDim2.new(0, 229 - 748 * (1 - v2), 0, 0);
        NorthEast.Position = SouthWest.Position + UDim2.new(0, 748, 0, 0);
    else
        NorthEast.Position = UDim2.new(0, 229 + 748 * v2, 0, 0);
        SouthWest.Position = NorthEast.Position + UDim2.new(0, 748, 0, 0);
    end;

    if NorthEast.Position.X.Offset > 0 then
        SouthWest.Position = NorthEast.Position - UDim2.new(0, 748, 0, 0);
    end;

    if SouthWest.Position.X.Offset > 0 then
        NorthEast.Position = SouthWest.Position - UDim2.new(0, 748, 0, 0);
    end;
end);