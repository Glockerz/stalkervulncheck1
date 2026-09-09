-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local create = vide.create
local read = vide.read

return function(p1) --[[ Line: 24 | Upvalues: create (copy), read (copy), theme (copy) ]]
	local v1 = create("Frame")
	local t = {
		Position = p1.position
	}

	t.Size = p1.size or UDim2.fromScale(1, 1)
	t.AnchorPoint = p1.anchorpoint
	t.AutomaticSize = p1.automaticsize
	t.AutoLocalize = false
	t.LayoutOrder = p1.layoutorder
	t.ZIndex = p1.zindex
	function t.BackgroundColor3() --[[ BackgroundColor3 | Line: 37 | Upvalues: read (ref), p1 (copy), theme (ref) ]]
		if read(p1.accent) then
			return theme.acc[read(p1.depth) or 0]()
		end

		return theme.bg[read(p1.depth) or 0]()
	end
	t[1] = unpack(p1)

	return v1(t)
end