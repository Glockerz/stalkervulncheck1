-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local anim = require(script.Parent.Parent.Parent.util.anim)
local theme = require(script.Parent.Parent.Parent.util.theme)
local create = vide.create
local read = vide.read

return function(p1) --[[ Line: 24 | Upvalues: create (copy), anim (copy), read (copy), theme (copy) ]]
	local v1 = create("Frame")
	local t = {
		Position = p1.position
	}

	t.Size = p1.size or UDim2.fromOffset(24, 24)
	t.AnchorPoint = p1.anchorpoint or Vector2.new(0.5, 0.5)
	t.AutomaticSize = p1.automaticsize
	t.AutoLocalize = false
	t.LayoutOrder = p1.layoutorder
	t.ZIndex = p1.zindex
	t.BackgroundColor3 = anim(function() --[[ Line: 37 | Upvalues: read (ref), p1 (copy), theme (ref) ]]
		if read(p1.checked) then
			return theme.acc[3]()
		end

		return theme.bg[1]()
	end)
	t[1] = create("UIStroke")({
		Color = function() --[[ Color | Line: 42 | Upvalues: read (ref), p1 (copy), theme (ref) ]]
			if read(p1.checked) then
				return theme.acc[0]()
			end

			return theme.bg[-3]()
		end
	})
	t[2] = create("UICorner")({
		CornerRadius = UDim.new(0, 4)
	})
	t[3] = create("ImageLabel")({
		BackgroundTransparency = 1,
		Image = "rbxassetid://100188624502987",
		Size = UDim2.fromScale(1, 1),
		ImageTransparency = anim(function() --[[ Line: 56 | Upvalues: read (ref), p1 (copy) ]]
			if read(p1.checked) then
				return 0
			end

			return 1
		end)
	})
	t[4] = unpack(p1)

	return v1(t)
end