-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local create = vide.create
local read = vide.read

return function(p1) --[[ Line: 13 | Upvalues: create (copy), theme (copy), read (copy) ]]
	return create("Frame")({
		AutoLocalize = false,
		BackgroundColor3 = theme.bg[-2],
		Position = p1.position,
		Size = function() --[[ Size | Line: 19 | Upvalues: read (ref), p1 (copy) ]]
			return UDim2.new(1, 0, 0, read(p1.thickness) or 1)
		end
	})
end