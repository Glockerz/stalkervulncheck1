-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Debugger = require(script.Parent.Debug.Debugger)

function t.solve(p1, p2, p3) --[[ solve | Line: 4 | Upvalues: Debugger (copy) ]]
	if not p2.LastPosition then
		p2.LastPosition = p2.Attachment.WorldPosition
	end

	if p3 then
		Debugger(p2.Attachment.WorldPosition - p2.LastPosition, CFrame.new(p2.Attachment.WorldPosition, p2.LastPosition))
	end

	return p2.LastPosition, p2.Attachment.WorldPosition - p2.LastPosition
end
function t.lastPosition(p1, p2) --[[ lastPosition | Line: 15 ]]
	p2.LastPosition = p2.Attachment.WorldPosition
end

return t