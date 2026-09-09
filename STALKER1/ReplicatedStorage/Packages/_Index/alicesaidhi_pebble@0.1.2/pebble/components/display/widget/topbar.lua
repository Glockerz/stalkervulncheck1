-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.Parent.util.theme)
local list = require(script.Parent.Parent.Parent.util.list)
local padding = require(script.Parent.Parent.Parent.util.padding)
local rounded_frame = require(script.Parent.Parent.Parent.util.rounded_frame)
local typography = require(script.Parent.Parent.typography)
local create = vide.create
local source = vide.source
local changed = vide.changed
local spring = vide.spring
local show = vide.show

return function(p1) --[[ Line: 30 | Upvalues: source (copy), rounded_frame (copy), theme (copy), create (copy), changed (copy), padding (copy), list (copy), typography (copy), show (copy), spring (copy) ]]
	local dragging = p1.dragging
	local offset = p1.offset
	local v1 = source(Vector2.zero)
	local v2 = source(Enum.GuiState.Idle)

	return rounded_frame({
		name = "Topbar",
		size = UDim2.new(1, 0, 0, 48),
		color = theme.bg[3],
		topleft = p1.radius,
		topright = p1.radius,
		create("ImageButton")({
			Size = UDim2.fromScale(1, 1),
			AutoLocalize = false,
			BackgroundTransparency = 1,
			ZIndex = 1000,
			changed("AbsolutePosition", v1),
			MouseButton1Down = function(p1, p2) --[[ MouseButton1Down | Line: 59 | Upvalues: offset (copy), v1 (copy), dragging (copy) ]]
				offset(v1() - Vector2.new(p1, p2))
				dragging(true)
			end,
			create("UIListLayout")({
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalFlex = Enum.UIFlexAlignment.Fill
			}),
			padding({
				x = UDim.new(0, 16)
			}),
			list({
				spacing = UDim.new(),
				typography({
					textsize = 20,
					header = true,
					size = UDim2.fromScale(1, 0),
					text = p1.title,
					xalignment = Enum.TextXAlignment.Left,
					truncate = Enum.TextTruncate.SplitWord
				}),
				show(function() --[[ Line: 86 | Upvalues: p1 (copy) ]]
					return p1.subtitle ~= nil
				end, function() --[[ Line: 88 | Upvalues: typography (ref), p1 (copy) ]]
					return typography({
						bold = true,
						textsize = 16,
						size = UDim2.fromScale(1, 0),
						text = p1.subtitle,
						xalignment = Enum.TextXAlignment.Left,
						truncate = Enum.TextTruncate.SplitWord
					})
				end)
			}),
			show(source(p1.bind_to_close and true or false), function() --[[ Line: 103 | Upvalues: create (ref), spring (ref), v2 (copy), theme (ref), changed (ref), p1 (copy) ]]
				return create("ImageButton")({
					Size = UDim2.fromOffset(32, 32),
					BackgroundColor3 = spring(function() --[[ Line: 108 | Upvalues: v2 (ref), theme (ref) ]]
						if v2() == Enum.GuiState.Hover then
							return theme.bg[5]()
						end

						if v2() == Enum.GuiState.Press then
							return theme.bg[0]()
						end

						return theme.bg[3]()
					end, 0.1),
					changed("GuiState", v2),
					Activated = p1.bind_to_close,
					create("UICorner")({
						CornerRadius = UDim.new(1, 0)
					}),
					create("ImageLabel")({
						AutoLocalize = false,
						BackgroundTransparency = 1,
						Image = "rbxassetid://10747384394",
						Size = UDim2.fromOffset(24, 24),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						ImageColor3 = theme.fg_on_bg_high[3]
					}),
					create("UIFlexItem")({
						ShrinkRatio = 0,
						FlexMode = Enum.UIFlexMode.Custom
					})
				})
			end)
		})
	})
end