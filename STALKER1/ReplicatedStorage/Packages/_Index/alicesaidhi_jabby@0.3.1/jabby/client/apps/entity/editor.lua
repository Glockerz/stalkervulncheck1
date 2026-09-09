-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble)
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)
local create = vide.create
local show = vide.show

return function(p1) --[[ Line: 14 | Upvalues: create (copy), show (copy), pebble (copy) ]]
	local editing = p1.editing
	local text = p1.text
	local changes = p1.changes

	return create("Folder")({
		Name = "Text Editor",
		show(function() --[[ Line: 23 | Upvalues: editing (copy) ]]
			return editing()
		end, function() --[[ Line: 25 | Upvalues: create (ref), pebble (ref), editing (copy), text (copy), changes (copy), p1 (copy) ]]
			return create("Frame")({
				ZIndex = 1000,
				Size = UDim2.new(1, 16, 1, 16),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				BackgroundTransparency = 0.5,
				Active = true,
				create("UIListLayout")({
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
					Padding = UDim.new(0, 8)
				}),
				pebble.padding({
					padding = UDim.new(0, 32)
				}),
				pebble.typography({
					text = function() --[[ text | Line: 49 | Upvalues: editing (ref) ]]
						return ("Editing %*"):format((editing()))
					end
				}),
				create("Frame")({
					Size = UDim2.fromScale(1, 0),
					create("UIFlexItem")({
						FlexMode = Enum.UIFlexMode.Fill
					}),
					BackgroundTransparency = 1,
					pebble.textfield({
						multiline = true,
						code = true,
						size = UDim2.fromScale(1, 1),
						position = UDim2.fromScale(0.5, 0.5),
						anchorpoint = Vector2.new(0.5, 0.5),
						text = text,
						oninput = text
					})
				}),
				create("Frame")({
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.Y,
					create("UIListLayout")({
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0, 8)
					}),
					pebble.button({
						text = "Save Changes",
						accent = true,
						size = UDim2.fromOffset(150, 30),
						activated = function() --[[ activated | Line: 90 | Upvalues: editing (ref), changes (ref), text (ref), p1 (ref) ]]
							local v1 = editing()

							changes()[v1] = text()
							editing(false)
							changes(changes())

							if p1.components()[v1] == nil then
								p1.components()[v1] = text()
							end
						end
					}),
					pebble.button({
						text = "Cancel Changes",
						size = UDim2.fromOffset(150, 30),
						activated = function() --[[ activated | Line: 106 | Upvalues: editing (ref) ]]
							editing(false)
						end
					})
				})
			})
		end)
	})
end