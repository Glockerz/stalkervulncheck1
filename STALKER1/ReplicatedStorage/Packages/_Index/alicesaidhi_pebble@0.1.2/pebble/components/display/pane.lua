-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local list = require(script.Parent.Parent.util.list)
local padding = require(script.Parent.Parent.util.padding)
local background = require(script.Parent.background)
local typography = require(script.Parent.typography)
local create = vide.create
local read = vide.read
local show = vide.show

return function(p1) --[[ Line: 27 | Upvalues: create (copy), theme (copy), show (copy), read (copy), background (copy), typography (copy), padding (copy), list (copy) ]]
	local v1 = create("Frame")
	local t = {
		Name = p1.name
	}

	t.Size = p1.size or UDim2.fromScale(1, 0)
	t.Position = p1.position
	t.AnchorPoint = p1.anchorpoint
	t.LayoutOrder = p1.layoutorder
	t.AutomaticSize = p1.automaticsize or Enum.AutomaticSize.Y
	t.BackgroundColor3 = theme.bg[0]
	t.AutoLocalize = false
	t[1] = create("UICorner")({
		CornerRadius = UDim.new(0, 8)
	})
	t[2] = create("UIStroke")({
		Color = theme.bg[-3]
	})
	t[3] = show(function() --[[ Line: 45 | Upvalues: read (ref), p1 (copy) ]]
		if not read(p1.name) then
			return false
		end

		return #read(p1.name) > 0
	end, function() --[[ Line: 47 | Upvalues: background (ref), typography (ref), p1 (copy), padding (ref) ]]
		return background({
			size = UDim2.new(),
			position = UDim2.fromOffset(4, -16),
			automaticsize = Enum.AutomaticSize.XY,
			typography({
				disabled = true,
				textsize = 14,
				text = p1.name
			}),
			padding({
				x = UDim.new(0, 2),
				y = UDim.new()
			})
		})
	end)
	t[4] = padding({})
	t[5] = list({ unpack(p1) })

	return v1(t)
end