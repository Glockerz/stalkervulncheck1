-- Decompiled with Potassium's decompiler.

local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientSettings = require(ReplicatedStorage:WaitForChild("ClientSettings"));
local GlobalShadows = Lighting.GlobalShadows;
local u1 = false;
local u2 = true;

local function applyShadows() -- Line: 26
    -- upvalues: u1 (ref), Lighting (copy), u2 (ref), GlobalShadows (ref)
    u1 = true;
    local v3;

    if u2 then
        v3 = GlobalShadows;
    else
        v3 = false;
    end;

    Lighting.GlobalShadows = v3;
    u1 = false;
end;

Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function() -- Line: 32
    -- upvalues: u1 (ref), GlobalShadows (ref), Lighting (copy), u2 (ref)
    if u1 then
        return;
    end;

    GlobalShadows = Lighting.GlobalShadows;

    if not u2 and Lighting.GlobalShadows then
        u1 = true;
        local v4;

        if u2 then
            v4 = GlobalShadows;
        else
            v4 = false;
        end;

        Lighting.GlobalShadows = v4;
        u1 = false;
    end;
end);
ClientSettings.OnChanged("shadows", function(p5) -- Line: 38
    -- upvalues: u2 (ref), u1 (ref), Lighting (copy), GlobalShadows (ref)
    u2 = p5 ~= false;
    u1 = true;
    local v6;

    if u2 then
        v6 = GlobalShadows;
    else
        v6 = false;
    end;

    Lighting.GlobalShadows = v6;
    u1 = false;
end);
local u7 = true;

local function watchBlur(u8: userdata) -- Line: 45
    -- upvalues: u7 (ref)
    if not u8:IsA("BlurEffect") then
        return;
    end;

    u8:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 47
        -- upvalues: u7 (ref), u8 (copy)
        if not u7 and u8.Enabled then
            u8.Enabled = false;
        end;
    end);
end;

local function inventoryOpen() -- Line: 52
    -- upvalues: Players (copy)
    local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");

    if PlayerGui then
        PlayerGui = PlayerGui:FindFirstChild("InventoryGui");
    end;

    local v9;

    if PlayerGui == nil then
        v9 = false;
    else
        v9 = PlayerGui:IsA("ScreenGui") and PlayerGui.Enabled;
    end;

    return v9;
end;

local InventoryBlur = Lighting:FindFirstChild("InventoryBlur");

if InventoryBlur then
    local u10 = InventoryBlur;

    if u10:IsA("BlurEffect") then
        u10:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 47
            -- upvalues: u7 (ref), u10 (copy)
            if not u7 and u10.Enabled then
                u10.Enabled = false;
            end;
        end);
    end;
end;

Lighting.ChildAdded:Connect(function(u11) -- Line: 60
    -- upvalues: InventoryBlur (ref), u7 (ref)
    if u11.Name == "InventoryBlur" then
        InventoryBlur = u11;

        if not u11:IsA("BlurEffect") then
            return;
        end;

        u11:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 47
            -- upvalues: u7 (ref), u11 (copy)
            if not u7 and u11.Enabled then
                u11.Enabled = false;
            end;
        end);
    end;
end);
ClientSettings.OnChanged("inventoryBlur", function(p12) -- Line: 64
    -- upvalues: u7 (ref), Lighting (copy), Players (copy)
    u7 = p12 ~= false;
    local InventoryBlur2 = Lighting:FindFirstChild("InventoryBlur");

    if InventoryBlur2 and InventoryBlur2:IsA("BlurEffect") then
        local v13 = u7;

        if v13 then
            local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");

            if PlayerGui then
                PlayerGui = PlayerGui:FindFirstChild("InventoryGui");
            end;

            if PlayerGui == nil then
                v13 = false;
            else
                v13 = PlayerGui:IsA("ScreenGui") and PlayerGui.Enabled;
            end;
        end;

        InventoryBlur2.Enabled = v13;
    end;
end);