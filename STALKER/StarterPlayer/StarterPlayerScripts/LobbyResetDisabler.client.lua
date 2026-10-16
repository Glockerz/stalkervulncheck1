-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

if not require(ReplicatedStorage:WaitForChild("PlaceConfig")).IsLobby then
    return;
end;

local StarterGui = game:GetService("StarterGui");

local function tryDisable() -- Line: 20
    -- upvalues: StarterGui (copy)
    return pcall(function() -- Line: 21
        -- upvalues: StarterGui (ref)
        StarterGui:SetCore("ResetButtonCallback", false);
    end);
end;

for i = 1, 30 do
    if pcall(function() -- Line: 21
        -- upvalues: StarterGui (copy)
        StarterGui:SetCore("ResetButtonCallback", false);
    end) then
        return;
    end;

    task.wait(0.1);
    local _ = i;
end;