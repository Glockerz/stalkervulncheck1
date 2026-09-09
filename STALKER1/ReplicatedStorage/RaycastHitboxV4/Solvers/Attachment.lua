-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Solve = function(p1, p2) --[[ Solve | Line: 9 ]]
		if not p2.LastPosition then
			p2.LastPosition = p2.Instances[1].WorldPosition
		end

		return p2.LastPosition, p2.Instances[1].WorldPosition - p2.LastPosition
	end,
	UpdateToNextPosition = function(p1, p2) --[[ UpdateToNextPosition | Line: 21 ]]
		return p2.Instances[1].WorldPosition
	end,
	Visualize = function(p1, p2) --[[ Visualize | Line: 25 ]]
		return CFrame.lookAt(p2.Instances[1].WorldPosition, p2.LastPosition)
	end
}