-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local InventoryController = require(ReplicatedStorage.InventoryController);
local success, result = pcall(function() -- Line: 7
    -- upvalues: ReplicatedStorage (copy)
    require(ReplicatedStorage.InventoryController:WaitForChild("Skin")).Start();
end);

if not success then
    warn("[InventorySkin] not applied: " .. tostring(result));
end;

InventoryController:Init();
print("Client Inventory System Initialized");