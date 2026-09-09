-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Head = game.Players.LocalPlayer.Character:WaitForChild("Head")

game:GetService("RunService").RenderStepped:connect(function() --[[ Line: 9 | Upvalues: Head (copy) ]]
	local SoundService = game:GetService("SoundService")
	local v1 = RaycastParams.new()

	v1.FilterDescendantsInstances = { Head.Parent }
	v1.FilterType = Enum.RaycastFilterType.Blacklist

	local v2 = workspace:Raycast(Head.Position, Vector3.new(0, 90, 0), v1)

	if v2 then
		local v3 = v2.Instance

		if v3:IsDescendantOf(workspace) and v3.Transparency == 0 then
			SoundService.AmbientReverb = "City"
		end
	else
		SoundService.AmbientReverb = "NoReverb"
	end
end)