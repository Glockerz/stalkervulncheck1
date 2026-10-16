-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local v1 = {};
local u2 = {};

local function apply() -- Line: 28
    -- upvalues: Players (copy), u2 (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChild("PlayerGui");
    end;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChild("InventoryGui");
    end;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChild("MainFrame");
    end;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChild("ContainerFrame");
    end;

    if LocalPlayer and LocalPlayer:IsA("GuiObject") then
        LocalPlayer.Visible = next(u2) == nil;
    end;
end;

function v1.Hide(p3: string) -- Line: 39
    -- upvalues: u2 (copy), apply (copy)
    u2[p3] = true;
    apply();
end;

function v1.Show(p4: string) -- Line: 44
    -- upvalues: u2 (copy), apply (copy)
    u2[p4] = nil;
    apply();
end;

function v1.IsHeld() -- Line: 50
    -- upvalues: u2 (copy)
    return next(u2) ~= nil;
end;

return v1;