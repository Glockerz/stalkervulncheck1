-- Decompiled with Potassium's decompiler.

local LocalPlayer = game.Players.LocalPlayer;

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait();
end;

LocalPlayer.CharacterAppearanceLoaded:Connect(function() -- Line: 5
    script.headturn.Enabled = false;
    task.wait(1);
    script.headturn.Enabled = true;
end);