-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local ToggleHood = Remotes:WaitForChild("ToggleHood");
local ShowToast = Remotes:WaitForChild("ShowToast");
UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 12
    -- upvalues: ToggleHood (copy)
    if p2 then
        return;
    end;

    if p1.KeyCode == Enum.KeyCode.M then
        ToggleHood:FireServer();
    end;
end);
ShowToast.OnClientEvent:Connect(function(p3) -- Line: 20
    -- upvalues: ReplicatedStorage (copy)
    local success, result = pcall(function() -- Line: 21
        -- upvalues: ReplicatedStorage (ref)
        return require(ReplicatedStorage:WaitForChild("InventoryController"));
    end);

    if success and (result and type(result.ShowToast) == "function") then
        result:ShowToast(p3);

        return;
    end;

    warn("[Toast] " .. tostring(p3));
end);