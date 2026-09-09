-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local create = vide.create

return function(p1) --[[ Line: 8 | Upvalues: create (copy), theme (copy) ]]
	return create("ScrollingFrame")({
		AutoLocalize = false,
		ScrollBarThickness = 6,
		ScrollBarImageColor3 = theme.fg_on_bg_low[0],
		CanvasSize = UDim2.new(),
		BackgroundTransparency = 1,
		p1
	})
end