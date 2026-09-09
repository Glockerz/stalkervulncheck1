-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local v1 = Vector3.new()

function t.Solve(p1, p2) --[[ Solve | Line: 11 | Upvalues: v1 (copy) ]]
	local v3 = p2.Instances[1].TransformedWorldCFrame.Position + p2.Instances[2]

	if not p2.LastPosition then
		p2.LastPosition = v3
	end

	local LastPosition = p2.LastPosition
	local v4 = p2.LastPosition or v1

	p2.WorldSpace = v3

	return LastPosition, v3 - v4
end
function t.UpdateToNextPosition(p1, p2) --[[ UpdateToNextPosition | Line: 30 ]]
	return p2.WorldSpace
end
function t.Visualize(p1, p2) --[[ Visualize | Line: 34 ]]
	return CFrame.lookAt(p2.WorldSpace, p2.LastPosition)
end

return t