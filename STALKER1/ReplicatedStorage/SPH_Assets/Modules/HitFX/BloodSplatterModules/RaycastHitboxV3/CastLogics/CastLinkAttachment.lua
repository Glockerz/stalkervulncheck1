-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Debugger = require(script.Parent.Debug.Debugger)

function t.solve(p1, p2, p3) --[[ solve | Line: 4 | Upvalues: Debugger (copy) ]]
	if p3 then
		Debugger(p2.Attachment.WorldPosition - p2.Attachment0.WorldPosition, CFrame.new(p2.Attachment.WorldPosition, p2.Attachment0.WorldPosition))
	end

	return p2.Attachment.WorldPosition, p2.Attachment0.WorldPosition - p2.Attachment.WorldPosition
end
function t.lastPosition(p1, p2) --[[ lastPosition | Line: 12 ]]
	p2.LastPosition = p2.Attachment.WorldPosition
end

return t