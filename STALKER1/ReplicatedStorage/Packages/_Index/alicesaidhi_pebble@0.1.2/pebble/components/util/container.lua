-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local create = require(script.Parent.Parent.Parent.Parent.vide).create

return function(p1) --[[ container | Line: 11 | Upvalues: create (copy) ]]
	return create("Frame")({
		Name = "Container",
		AutoLocalize = false,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		p1
	})
end