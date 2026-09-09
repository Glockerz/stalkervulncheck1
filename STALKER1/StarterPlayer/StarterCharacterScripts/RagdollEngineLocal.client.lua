-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local LocalPlayer = game.Players.LocalPlayer
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

v1:WaitForChild("Humanoid")

local CurrentCamera = game.Workspace.CurrentCamera

game:GetService("UserInputService")
v1:WaitForChild("RagdollEngine"):WaitForChild("RagdollEvent")