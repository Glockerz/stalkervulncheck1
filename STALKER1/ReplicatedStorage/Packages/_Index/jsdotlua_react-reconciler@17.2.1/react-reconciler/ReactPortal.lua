-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local REACT_PORTAL_TYPE = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols.REACT_PORTAL_TYPE

require(script.Parent.Parent:WaitForChild("shared"))

return {
	createPortal = function(p1, p2, p3, p4) --[[ createPortal | Line: 17 | Upvalues: REACT_PORTAL_TYPE (copy) ]]
		if p4 ~= nil then
			p4 = tostring(p4)
		end

		return {
			["$$typeof"] = REACT_PORTAL_TYPE,
			key = p4,
			children = p1,
			containerInfo = p2,
			implementation = p3
		}
	end
}