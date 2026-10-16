-- Decompiled with Potassium's decompiler.

local LocalPlayer = game.Players.LocalPlayer;
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
v1:WaitForChild("Humanoid");
local _ = game.Workspace.CurrentCamera;
game:GetService("UserInputService");
v1:WaitForChild("RagdollEngine"):WaitForChild("RagdollEvent");