-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)

require(script.Parent.Parent.Parent.util.anim)

local theme = require(script.Parent.Parent.Parent.util.theme)

require(script.Parent.Parent.interactable.button)

local container = require(script.Parent.Parent.util.container)
local list = require(script.Parent.Parent.util.list)
local padding = require(script.Parent.Parent.util.padding)
local rounded_frame = require(script.Parent.Parent.util.rounded_frame)
local divider = require(script.Parent.divider)
local typography = require(script.Parent.typography)
local create = vide.create
local source = vide.source
local changed = vide.changed
local indexes = vide.indexes
local untrack = vide.untrack
local cleanup = vide.cleanup

return function(p1) --[[ Line: 29 | Upvalues: source (copy), list (copy), create (copy), theme (copy), divider (copy), container (copy), indexes (copy), rounded_frame (copy), typography (copy), padding (copy), changed (copy), untrack (copy) ]]
	local v1 = source(1)

	return list({
		justifycontent = Enum.UIFlexAlignment.Fill,
		spacing = UDim.new(),
		create("Frame")({
			Size = UDim2.new(1, 0, 0, 32),
			AutoLocalize = false,
			BackgroundColor3 = theme.bg[3],
			divider({
				position = UDim2.fromScale(0, 1)
			}),
			container({ create("UIListLayout")({
					FillDirection = Enum.FillDirection.Horizontal
				}), indexes(p1.labels, function(p1, p2) --[[ Line: 51 | Upvalues: source (ref), rounded_frame (ref), v1 (copy), theme (ref), create (ref), typography (ref), padding (ref), changed (ref) ]]
					local v12 = source(Enum.GuiState.Idle)

					return rounded_frame({
						name = p2,
						size = UDim2.fromOffset(50, 30),
						automaticsize = Enum.AutomaticSize.X,
						topleft = UDim.new(0, 4),
						topright = UDim.new(0, 4),
						color = function() --[[ color | Line: 61 | Upvalues: v1 (ref), p2 (copy), theme (ref), v12 (copy) ]]
							if v1() == p2 then
								return theme.bg[0]()
							end

							if v12() == Enum.GuiState.Idle then
								return theme.bg[3]()
							end

							return theme.bg[1]()
						end,
						create("TextButton")({
							Size = UDim2.fromScale(1, 1),
							AutoLocalize = false,
							BackgroundTransparency = 1,
							Activated = function() --[[ Activated | Line: 72 | Upvalues: v1 (ref), p2 (copy) ]]
								v1(p2)
							end,
							typography({
								textsize = 16,
								position = UDim2.fromScale(0.5, 0.5),
								anchorpoint = Vector2.new(0.5, 0.5),
								text = function() --[[ text | Line: 81 | Upvalues: p1 (copy) ]]
									return p1().title
								end
							}),
							padding({
								x = UDim.new(0, 24),
								y = UDim.new(0, 2)
							}),
							changed("GuiState", v12)
						})
					})
				end) }),
			ZIndex = 100
		}),
		create("Frame")({
			Size = UDim2.new(1, 0, 1, 0),
			AutoLocalize = false,
			BackgroundColor3 = theme.bg[0],
			function() --[[ Line: 110 | Upvalues: untrack (ref), p1 (copy), v1 (copy) ]]
				return untrack(p1.labels()[v1()].ui)
			end
		})
	})
end