-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    InventoryGui = true,
    TraderGui = true,
    PremiumVendorGui = true,
    PdaGui = true,
    NpcInteractionGui = true,
    TalkGui = true,
    EmoteWheelGui = true
};
local InventoryController = require(ReplicatedStorage:WaitForChild("InventoryController"));
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local u2 = {};
local u3 = nil;

local function anyBlockingGuiOpen() -- Line: 53
    -- upvalues: u1 (copy), PlayerGui (copy)
    for i in pairs(u1) do
        local v4 = PlayerGui:FindFirstChild(i);

        if v4 and (v4:IsA("ScreenGui") and v4.Enabled) then
            return true;
        end;
    end;

    return false;
end;

local function apply(p5) -- Line: 66
    -- upvalues: anyBlockingGuiOpen (copy), u3 (ref), InventoryController (copy)
    local v6 = anyBlockingGuiOpen();

    if v6 == u3 and not p5 then
        return;
    end;

    u3 = v6;
    InventoryController:_setUIInputLock(v6);
end;

local function watch(p7) -- Line: 73
    -- upvalues: u2 (copy), u1 (copy), anyBlockingGuiOpen (copy), u3 (ref), InventoryController (copy)
    if u2[p7] then
        return;
    end;

    if not (p7:IsA("ScreenGui") and u1[p7.Name]) then
        return;
    end;

    u2[p7] = true;
    p7:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 77
        -- upvalues: anyBlockingGuiOpen (ref), u3 (ref), InventoryController (ref)
        local v8 = anyBlockingGuiOpen();

        if v8 == u3 then
            return;
        end;

        u3 = v8;
        InventoryController:_setUIInputLock(v8);
    end);
    local v9 = anyBlockingGuiOpen();

    if v9 == u3 then
        return;
    end;

    u3 = v9;
    InventoryController:_setUIInputLock(v9);
end;

for _, child in ipairs(PlayerGui:GetChildren()) do
    watch(child);
end;

PlayerGui.ChildAdded:Connect(watch);
PlayerGui.ChildRemoved:Connect(function(p10) -- Line: 85
    -- upvalues: u2 (copy), anyBlockingGuiOpen (copy), u3 (ref), InventoryController (copy)
    if u2[p10] then
        u2[p10] = nil;
        local v11 = anyBlockingGuiOpen();

        if v11 == u3 then
            return;
        end;

        u3 = v11;
        InventoryController:_setUIInputLock(v11);
    end;
end);
LocalPlayer.CharacterAdded:Connect(function() -- Line: 92
    -- upvalues: u3 (ref), anyBlockingGuiOpen (copy), InventoryController (copy)
    u3 = nil;
    task.defer(function() -- Line: 94
        -- upvalues: anyBlockingGuiOpen (ref), u3 (ref), InventoryController (ref)
        local v12 = anyBlockingGuiOpen();
        local _ = v12 == u3;
        u3 = v12;
        InventoryController:_setUIInputLock(v12);
    end);
end);
local v13 = anyBlockingGuiOpen();
local _ = v13 == u3;
u3 = v13;
InventoryController:_setUIInputLock(v13);