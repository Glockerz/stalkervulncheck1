-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Solve = function(p1, p2) --[[ Solve | Line: 9 ]]
		return p2.Instances[1].WorldPosition, p2.Instances[2].WorldPosition - p2.Instances[1].WorldPosition
	end,
	UpdateToNextPosition = function(p1, p2) --[[ UpdateToNextPosition | Line: 16 ]]
		return p2.Instances[1].WorldPosition
	end,
	Visualize = function(p1, p2) --[[ Visualize | Line: 20 ]]
		return CFrame.lookAt(p2.Instances[1].WorldPosition, p2.Instances[2].WorldPosition)
	end
}