-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local scroll_frame = require(script.Parent.Parent.display.scroll_frame)
local container = require(script.Parent.Parent.util.container)
local list = require(script.Parent.Parent.util.list)
local padding = require(script.Parent.Parent.util.padding)
local portal = require(script.Parent.Parent.util.portal)
local button = require(script.Parent.button)
local create = vide.create
local source = vide.source
local changed = vide.changed
local indexes = vide.indexes
local spring = vide.spring
local read = vide.read

return function(p1) --[[ dropdown | Line: 31 | Upvalues: source (copy), spring (copy), button (copy), read (copy), create (copy), container (copy), theme (copy), portal (copy), padding (copy), scroll_frame (copy), list (copy), changed (copy), indexes (copy) ]]
	local selected = p1.selected
	local v1 = p1.update_selected or (function() --[[ Line: 34 ]] end)
	local options = p1.options
	local v2 = source(false)
	local v3 = source(Vector2.zero)
	local v4 = spring(function() --[[ Line: 40 | Upvalues: v2 (copy), v3 (copy) ]]
		if v2() then
			local v1 = UDim2.new
			local Y = v3().Y

			return v1(1, 0, 0, (math.min(100, Y)))
		end

		return UDim2.fromScale(1, 0)
	end, 0.1)
	local v5 = button
	local t = {}

	t.size = p1.size or UDim2.fromOffset(200, 32)
	t.position = p1.position or UDim2.fromScale(0.5, 0.5)
	t.anchorpoint = p1.anchorpoint or Vector2.new(0.5, 0.5)
	t.xalignment = Enum.TextXAlignment.Left
	function t.text() --[[ text | Line: 53 | Upvalues: read (ref), options (copy), selected (copy) ]]
		return read(options)[read(selected)]
	end
	function t.activated() --[[ activated | Line: 57 | Upvalues: v2 (copy) ]]
		v2(not v2())
	end
	t[1] = create("UIListLayout")({
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8)
	})
	t[2] = container({
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.fromScale(1, 0),
		Size = UDim2.new(0, 18, 0, 16),
		LayoutOrder = -1,
		create("ImageLabel")({
			Name = "arrow",
			AutoLocalize = false,
			BackgroundTransparency = 1,
			Image = "rbxassetid://7260137654",
			Size = UDim2.new(0, 8, 0, 4),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Rotation = spring(function() --[[ Line: 83 | Upvalues: v2 (copy) ]]
				if v2() then
					return -180
				end

				return 0
			end, 0.1),
			BackgroundColor3 = theme.fg_on_bg_high[3],
			ImageColor3 = theme.fg_on_bg_low[3],
			ScaleType = Enum.ScaleType.Stretch
		})
	})
	t[3] = portal({
		inherit_layout = true,
		container({
			Position = UDim2.new(0, 1, 1, 4),
			Size = v4,
			BackgroundTransparency = 0,
			BackgroundColor3 = theme.bg[3],
			ClipsDescendants = true,
			Visible = function() --[[ Visible | Line: 111 | Upvalues: v4 (copy) ]]
				return v4().Y.Offset > 1
			end,
			padding({
				padding = UDim.new(0, 2)
			}),
			scroll_frame({
				Size = UDim2.fromScale(1, 1),
				ScrollBarThickness = 4,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				list({
					spacing = UDim.new(0, 1),
					changed("AbsoluteSize", v3),
					indexes(function() --[[ Line: 129 | Upvalues: read (ref), options (copy) ]]
						return read(options)
					end, function(p1, p2) --[[ Line: 131 | Upvalues: button (ref), v2 (copy), v1 (copy), create (ref) ]]
						return button({
							size = UDim2.new(1, 0, 0, 30),
							text = p1,
							stroke = false,
							activated = function() --[[ activated | Line: 137 | Upvalues: v2 (ref), v1 (ref), p2 (copy) ]]
								v2(false)
								v1(p2)
							end,
							create("UIListLayout")({
								FillDirection = Enum.FillDirection.Horizontal,
								VerticalAlignment = Enum.VerticalAlignment.Center,
								Padding = UDim.new(0, 8)
							})
						})
					end)
				})
			}),
			create("UIStroke")({
				Color = theme.bg[-3]
			}),
			create("UICorner")({
				CornerRadius = UDim.new(0, 3)
			})
		})
	})

	return v5(t)
end