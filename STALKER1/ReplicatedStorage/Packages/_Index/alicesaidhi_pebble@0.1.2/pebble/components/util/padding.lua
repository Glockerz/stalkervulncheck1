-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local create = require(script.Parent.Parent.Parent.Parent.vide).create

return function(p1) --[[ padding | Line: 22 | Upvalues: create (copy) ]]
	local v1 = p1.padding or UDim.new(0, 8)
	local v2 = p1.x or v1
	local v3 = p1.y or v1

	return create("UIPadding")({
		PaddingLeft = p1.left or v2,
		PaddingRight = p1.right or v2,
		PaddingTop = p1.top or v3,
		PaddingBottom = p1.bottom or v3
	})
end