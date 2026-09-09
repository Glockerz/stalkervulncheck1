-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local NorthEast = script.Parent:WaitForChild("NorthEast")
local SouthWest = script.Parent:WaitForChild("SouthWest")

RunService.Heartbeat:Connect(function() --[[ Line: 7 | Upvalues: SouthWest (copy), NorthEast (copy) ]]
	local CurrentCamera = game.Workspace.CurrentCamera
	local v1 = CurrentCamera.CFrame:VectorToObjectSpace(((Vector3.new(0, 0, -10000000) - CurrentCamera.CFrame.Position) * Vector3.new(1, 0, 1)).Unit)
	local v3 = math.atan2(v1.X, -v1.Z) / math.pi

	if v3 > 0 then
		SouthWest.Position = UDim2.new(0, 229 - 748 * (1 - v3), 0, 0)
		NorthEast.Position = SouthWest.Position + UDim2.new(0, 748, 0, 0)
	else
		NorthEast.Position = UDim2.new(0, 229 + 748 * v3, 0, 0)
		SouthWest.Position = NorthEast.Position + UDim2.new(0, 748, 0, 0)
	end

	if NorthEast.Position.X.Offset > 0 then
		SouthWest.Position = NorthEast.Position - UDim2.new(0, 748, 0, 0)
	end

	if not (SouthWest.Position.X.Offset > 0) then
		return
	end

	NorthEast.Position = SouthWest.Position - UDim2.new(0, 748, 0, 0)
end)