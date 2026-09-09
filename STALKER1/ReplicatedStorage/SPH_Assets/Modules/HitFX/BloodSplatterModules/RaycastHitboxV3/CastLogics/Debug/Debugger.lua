-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")

return function(p1, p2) --[[ Line: 3 | Upvalues: Debris (copy) ]]
	local RaycastHitboxDebugPart = Instance.new("Part")

	RaycastHitboxDebugPart.BrickColor = BrickColor.new("Bright red")
	RaycastHitboxDebugPart.Material = Enum.Material.Neon
	RaycastHitboxDebugPart.Anchored = true
	RaycastHitboxDebugPart.CanCollide = false
	RaycastHitboxDebugPart.Name = "RaycastHitboxDebugPart"

	local Magnitude = p1.Magnitude

	RaycastHitboxDebugPart.Size = Vector3.new(0.1, 0.1, Magnitude)
	RaycastHitboxDebugPart.CFrame = p2 * CFrame.new(0, 0, -Magnitude / 2)
	RaycastHitboxDebugPart.Parent = workspace.Terrain
	Debris:AddItem(RaycastHitboxDebugPart, 1)
end