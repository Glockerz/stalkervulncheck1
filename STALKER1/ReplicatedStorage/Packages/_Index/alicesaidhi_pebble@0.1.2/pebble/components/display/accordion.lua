-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local container = require(script.Parent.Parent.util.container)
local padding = require(script.Parent.Parent.util.padding)
local typography = require(script.Parent.typography)
local create = vide.create
local source = vide.source
local changed = vide.changed
local spring = vide.spring

return function(p1) --[[ Line: 24 | Upvalues: source (copy), container (copy), spring (copy), create (copy), theme (copy), padding (copy), typography (copy), changed (copy) ]]
	local v1 = source(Enum.GuiState.Idle)
	local v2 = source(Vector2.zero)

	return container({
		Name = "Accordion",
		Size = spring(function() --[[ Line: 31 | Upvalues: p1 (copy), v2 (copy) ]]
			if p1.expanded() == false then
				return UDim2.new(1, 0, 0, 32)
			end

			return UDim2.new(1, 0, 0, 40 + v2().Y)
		end, 0.1),
		ClipsDescendants = true,
		create("ImageButton")({
			Name = "Accordion",
			AutoLocalize = false,
			Size = UDim2.new(1, 0, 0, 32),
			BackgroundColor3 = spring(function() --[[ Line: 42 | Upvalues: v1 (copy), theme (ref) ]]
				if v1() == Enum.GuiState.Press then
					return theme.bg[-1]()
				end

				if v1() == Enum.GuiState.Hover then
					return theme.bg[3]()
				end

				return theme.bg[0]()
			end, 0.1),
			padding({
				x = UDim.new(0, 8)
			}),
			create("UIListLayout")({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 8)
			}),
			create("UICorner")({
				CornerRadius = UDim.new(0, 8)
			}),
			container({
				Size = UDim2.fromOffset(16, 16),
				create("ImageLabel")({
					BackgroundTransparency = 1,
					AutoLocalize = false,
					Image = "rbxassetid://10709790948",
					Size = UDim2.fromOffset(16, 16),
					Rotation = spring(function() --[[ Line: 71 | Upvalues: p1 (copy) ]]
						if p1.expanded() then
							return 180
						end

						return 0
					end, 0.1)
				})
			}),
			typography({
				size = UDim2.fromScale(0, 1),
				text = p1.text,
				truncate = Enum.TextTruncate.SplitWord,
				xalignment = Enum.TextXAlignment.Left,
				create("UIFlexItem")({
					FlexMode = Enum.UIFlexMode.Fill
				})
			}),
			Activated = function() --[[ Activated | Line: 88 | Upvalues: p1 (copy) ]]
				p1.set_expanded(not p1.expanded())
			end,
			changed("GuiState", v1)
		}),
		container({
			Name = "Children",
			Position = UDim2.fromOffset(0, 40),
			AutomaticSize = Enum.AutomaticSize.None,
			Size = function() --[[ Size | Line: 101 | Upvalues: v2 (copy) ]]
				return UDim2.new(1, 0, 0, v2().Y)
			end,
			BackgroundColor3 = theme.bg[3],
			ClipsDescendants = true,
			container({
				Size = UDim2.fromScale(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				unpack(p1),
				changed("AbsoluteSize", v2)
			})
		})
	})
end