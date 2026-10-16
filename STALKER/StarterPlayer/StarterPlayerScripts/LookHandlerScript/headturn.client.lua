-- Decompiled with Potassium's decompiler.

local script_Arms = script.Arms;
local CharacterLookController = require(game.ReplicatedStorage.CharacterLookSystem.ReplicatedStorage.CharacterLookController);
local LocalPlayer = game.Players.LocalPlayer;

local function updateArmsLook() -- Line: 13
    -- upvalues: LocalPlayer (copy), CharacterLookController (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v1 = false;

    for _, child in Character:GetChildren() do
        if child:IsA("Tool") then
            v1 = true;
            break;
        end;
    end;

    CharacterLookController.ArmsLook = v1;
end;

local function bindCharacter(p2) -- Line: 23
    -- upvalues: updateArmsLook (copy)
    p2.ChildAdded:Connect(function(p3) -- Line: 24
        -- upvalues: updateArmsLook (ref)
        if p3:IsA("Tool") then
            updateArmsLook();
        end;
    end);
    p2.ChildRemoved:Connect(function(p4) -- Line: 27
        -- upvalues: updateArmsLook (ref)
        if p4:IsA("Tool") then
            updateArmsLook();
        end;
    end);
    updateArmsLook();
end;

bindCharacter(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait());
LocalPlayer.CharacterAdded:Connect(bindCharacter);
CharacterLookController:Commence("Camera", false, script_Arms.Value, 0.1);