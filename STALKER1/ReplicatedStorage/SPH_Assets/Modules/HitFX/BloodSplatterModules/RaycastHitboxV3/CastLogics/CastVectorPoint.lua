-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Debugger = require(script.Parent.Debug.Debugger)

function t.solve(p1, p2, p3) --[[ solve | Line: 4 | Upvalues: Debugger (copy) ]]
	local v1 = p2.IsAttachment and p2.RelativePart.WorldPosition + p2.RelativePart.WorldCFrame:VectorToWorldSpace(p2.Attachment) or p2.RelativePart.Position + p2.RelativePart.CFrame:VectorToWorldSpace(p2.Attachment)

	if not p2.LastPosition then
		p2.LastPosition = v1
	end

	if p3 then
		Debugger(v1 - p2.LastPosition, CFrame.new(v1, p2.LastPosition))
	end

	return p2.LastPosition, v1 - (p2.LastPosition and p2.LastPosition or Vector3.new()), v1
end
function t.lastPosition(p1, p2, p3) --[[ lastPosition | Line: 18 ]]
	p2.LastPosition = p3
end

return t