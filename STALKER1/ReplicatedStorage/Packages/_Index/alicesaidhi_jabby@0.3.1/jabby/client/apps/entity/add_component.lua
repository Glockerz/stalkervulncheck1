-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble)
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)
local query_parser = require(script.Parent.Parent.Parent.Parent.server.query_parser)
local create = vide.create
local source = vide.source
local show = vide.show

return function(p1) --[[ Line: 16 | Upvalues: source (copy), create (copy), show (copy), pebble (copy), query_parser (copy) ]]
	local v1 = source("")
	local adding = p1.adding
	local editing = p1.editing
	local text = p1.text

	return create("Folder")({
		Name = "Add Component",
		show(adding, function() --[[ Line: 26 | Upvalues: create (ref), pebble (ref), v1 (copy), adding (copy), editing (copy), query_parser (ref) ]]
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
					Padding = UDim.new(0, 8)
				}),
				pebble.padding({
					padding = UDim.new(0, 32)
				}),
				pebble.textfield({
					placeholder = "Entity",
					size = UDim2.fromOffset(200, 30),
					oninput = v1
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
						text = "Edit",
						accent = true,
						size = UDim2.fromOffset(150, 30),
						activated = function() --[[ activated | Line: 70 | Upvalues: adding (ref), editing (ref), v1 (ref) ]]
							adding(false)
							editing(v1())
						end,
						disabled = function() --[[ disabled | Line: 74 | Upvalues: query_parser (ref), v1 (ref) ]]
							local ok, result = pcall(query_parser, v1())

							if not ok then
								return true
							end

							if not result[1] then
								return true
							end

							if result[2] then
								return true
							end

							local v12 = result[1]

							if v12.type ~= "Relationship" then
								return false
							end

							if v12.left.type == "Wildcard" then
								return true
							end

							if v12.right.type == "Wildcard" then
								return true
							end

							return false
						end
					}),
					pebble.button({
						text = "Cancel",
						size = UDim2.fromOffset(150, 30),
						activated = function() --[[ activated | Line: 94 | Upvalues: adding (ref) ]]
							adding(false)
						end
					})
				})
			})
		end)
	})
end