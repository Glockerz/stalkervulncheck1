-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble)
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)
local tooltip = require(script.Parent.Parent.Parent.components.tooltip)
local spawn_app = require(script.Parent.Parent.Parent.spawn_app)
local entity = require(script.Parent.Parent.entity)
local create = vide.create
local effect = vide.effect
local source = vide.source
local show = vide.show
local v1 = source(Vector2.zero)

RunService.PreRender:Connect(function() --[[ Line: 49 | Upvalues: v1 (copy), UserInputService (copy) ]]
	v1(UserInputService:GetMouseLocation())
end)

return function(p1) --[[ Line: 53 | Upvalues: source (copy), effect (copy), pebble (copy), create (copy), tooltip (copy), vide (copy), spawn_app (copy), entity (copy), show (copy) ]]
	local v1 = source("1")
	local v2 = source("25")
	local v3 = source(1)
	local v4 = source(20)

	effect(function() --[[ Line: 61 | Upvalues: v1 (copy), v3 (copy) ]]
		v1((tostring(v3())))
	end)
	effect(function() --[[ Line: 65 | Upvalues: v2 (copy), v4 (copy) ]]
		v2((tostring(v4())))
	end)
	effect(function() --[[ Line: 69 | Upvalues: v3 (copy), v4 (copy), p1 (copy) ]]
		local v1 = v3()
		local v2 = v4()
		local v32 = (v1 - 1) * v2 + 1

		p1.from(v32)
		p1.upto(v32 + v2 - 1)
	end)

	local t = {
		Size = UDim2.new(0, 0, 0, 26),
		AutomaticSize = Enum.AutomaticSize.X
	}

	return pebble.widget({
		title = "Querying",
		subtitle = ("host: %* vm: %* id: %*"):format(p1.host, p1.vm, p1.id),
		min_size = Vector2.new(300, 300),
		bind_to_close = p1.destroy,
		create("Frame")({
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			tooltip({
				transparency = 0.3,
				visible = function() --[[ visible | Line: 100 | Upvalues: p1 (copy) ]]
					return p1.entity_hovering_over() and #p1.entity_hovering_over() > 0 and true or false
				end,
				pebble.typography({
					automaticsize = Enum.AutomaticSize.XY,
					text = function() --[[ text | Line: 107 | Upvalues: p1 (copy) ]]
						return p1.entity_hovering_over() or ""
					end,
					xalignment = Enum.TextXAlignment.Left,
					wrapped = true,
					code = true,
					{
						RichText = true
					},
					create("UIStroke")({
						Thickness = 1,
						Color = pebble.theme.bg[-5]
					})
				})
			}),
			create("Highlight")({
				FillTransparency = 0.5,
				DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
				OutlineColor = Color3.new(255/255, 255/255, 255/255),
				FillColor = pebble.theme.acc[0],
				Adornee = p1.hovering_over
			}),
			create("UIListLayout")({
				VerticalFlex = Enum.UIFlexAlignment.SpaceAround,
				Padding = UDim.new(0, 8)
			}),
			create("Frame")({
				Name = "Query + Pick",
				Size = UDim2.new(1, 0, 0, 30),
				BackgroundTransparency = 1,
				create("UIListLayout")({
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.SpaceAround,
					VerticalFlex = Enum.UIFlexAlignment.SpaceAround,
					Padding = UDim.new(0, 8)
				}),
				create("Frame")({
					Name = "Query",
					Size = UDim2.fromScale(0, 1),
					BackgroundTransparency = 1,
					create("UIFlexItem")({
						FlexMode = Enum.UIFlexMode.Fill
					}),
					pebble.textfield({
						placeholder = "Query",
						code = true,
						size = UDim2.new(1, 0, 0, 30),
						oninput = function(p12) --[[ oninput | Line: 167 | Upvalues: p1 (copy) ]]
							p1.validate_query(p12)
						end,
						enter = function(p12) --[[ enter | Line: 171 | Upvalues: p1 (copy) ]]
							p1.update_system_query(p12)
						end
					})
				}),
				vide.show(function() --[[ Line: 178 | Upvalues: p1 (copy) ]]
					return p1.primary_entity()
				end, function() --[[ Line: 180 | Upvalues: pebble (ref), spawn_app (ref), entity (ref), p1 (copy), create (ref) ]]
					return pebble.button({
						size = UDim2.fromOffset(30, 30),
						text = "",
						activated = function() --[[ activated | Line: 186 | Upvalues: spawn_app (ref), entity (ref), p1 (ref) ]]
							spawn_app.spawn_app(entity, {
								host = p1.host,
								vm = p1.vm,
								id = p1.id,
								entity = p1.primary_entity()
							})
						end,
						create("ImageLabel")({
							BackgroundTransparency = 1,
							Image = "rbxassetid://10723415903",
							Size = UDim2.fromOffset(24, 24),
							Position = UDim2.fromScale(0.5, 0.5),
							AnchorPoint = Vector2.new(0.5, 0.5),
							ImageColor3 = pebble.theme.fg_on_bg_high[3]
						})
					})
				end),
				pebble.button({
					size = UDim2.fromOffset(30, 30),
					text = "",
					accent = p1.enable_pick,
					activated = function() --[[ activated | Line: 217 | Upvalues: p1 (copy) ]]
						p1.enable_pick(not p1.enable_pick())
					end,
					create("ImageLabel")({
						BackgroundTransparency = 1,
						Image = "rbxassetid://10734898355",
						Size = UDim2.fromOffset(24, 24),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						ImageColor3 = pebble.theme.fg_on_bg_high[3]
					})
				})
			}),
			create("Frame")({
				Size = UDim2.new(1, 0, 0, 24),
				BackgroundTransparency = 1,
				Visible = function() --[[ Visible | Line: 242 | Upvalues: p1 (copy) ]]
					return not p1.ok() and #p1.msg() > 0
				end,
				pebble.typography({
					text = p1.msg
				})
			}),
			create("Frame")({
				Size = UDim2.new(1, 0, 0, 32),
				BackgroundColor3 = pebble.theme.bg[2],
				AutomaticSize = Enum.AutomaticSize.Y,
				create("UICorner")({
					CornerRadius = UDim.new(0, 8)
				}),
				create("UIListLayout")({
					Wraps = true,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 8),
					HorizontalFlex = Enum.UIFlexAlignment.SpaceAround,
					VerticalAlignment = Enum.VerticalAlignment.Center
				}),
				pebble.row({
					spacing = UDim.new(0, 8),
					alignitems = Enum.ItemLineAlignment.Center,
					t,
					pebble.typography({
						text = "Page:"
					}),
					pebble.textfield({
						placeholder = "1",
						size = UDim2.fromOffset(40, 26),
						text = function() --[[ text | Line: 284 | Upvalues: v1 (copy) ]]
							return v1()
						end,
						oninput = v1,
						enter = function(p1) --[[ enter | Line: 290 | Upvalues: v1 (copy), v3 (copy) ]]
							local v12 = tonumber(p1)

							if v12 == nil then
								v1((tostring(v3())))
							else
								v3(v12)
							end
						end
					}),
					pebble.typography({
						text = function() --[[ text | Line: 302 | Upvalues: p1 (copy), v4 (copy) ]]
							return ("/ %*"):format((math.ceil(p1.total_entities() / v4())))
						end
					})
				}),
				pebble.row({
					spacing = UDim.new(0, 8),
					alignitems = Enum.ItemLineAlignment.Center,
					t,
					pebble.typography({
						text = "Rows:"
					}),
					pebble.textfield({
						placeholder = "Rows",
						size = UDim2.fromOffset(40, 26),
						text = function() --[[ text | Line: 322 | Upvalues: v2 (copy) ]]
							return v2()
						end,
						oninput = v2,
						enter = function(p1) --[[ enter | Line: 328 | Upvalues: v2 (copy), v4 (copy) ]]
							local v1 = tonumber(p1)

							if v1 == nil then
								v2((tostring(v4())))
							else
								v4(v1)
							end
						end
					})
				}),
				pebble.row({
					spacing = UDim.new(0, 4),
					t,
					pebble.button({
						size = UDim2.fromOffset(26, 26),
						text = "",
						accent = function() --[[ accent | Line: 348 | Upvalues: p1 (copy) ]]
							return not p1.paused()
						end,
						activated = function() --[[ activated | Line: 352 | Upvalues: p1 (copy) ]]
							p1.paused(not p1.paused())
						end,
						{
							LayoutOrder = 10
						},
						create("ImageLabel")({
							BackgroundTransparency = 1,
							Size = UDim2.fromOffset(24, 24),
							Position = UDim2.fromScale(0.5, 0.5),
							AnchorPoint = Vector2.new(0.5, 0.5),
							ImageColor3 = pebble.theme.fg_on_bg_high[3],
							Image = function() --[[ Image | Line: 367 | Upvalues: p1 (copy) ]]
								if p1.paused() then
									return "rbxassetid://10735024209"
								end

								return "rbxassetid://10734923214"
							end
						})
					}),
					show(p1.paused, function() --[[ Line: 375 | Upvalues: pebble (ref), p1 (copy), create (ref) ]]
						return pebble.button({
							size = UDim2.fromOffset(26, 26),
							text = "",
							activated = function() --[[ activated | Line: 380 | Upvalues: p1 (ref) ]]
								p1.refresh(true)
							end,
							create("ImageLabel")({
								BackgroundTransparency = 1,
								Image = "rbxassetid://10734933222",
								Size = UDim2.fromOffset(24, 24),
								Position = UDim2.fromScale(0.5, 0.5),
								AnchorPoint = Vector2.new(0.5, 0.5),
								ImageColor3 = pebble.theme.fg_on_bg_high[3]
							})
						})
					end)
				})
			}),
			pebble.background({
				size = UDim2.fromScale(1, 0),
				automaticsize = Enum.AutomaticSize.Y,
				create("UICorner")({
					CornerRadius = UDim.new(0, 8)
				}),
				create("UIFlexItem")({
					FlexMode = Enum.UIFlexMode.Fill
				}),
				pebble.tablesheet({
					size = UDim2.fromScale(1, 1),
					suggested_column_sizes = { 0.1 },
					column_sizes = function() --[[ column_sizes | Line: 419 | Upvalues: p1 (copy) ]]
						local t = {}

						for v1 in p1.columns() do
							t[v1] = 200
						end

						t[1] = 50

						return t
					end,
					columns = p1.columns,
					read_value = function(p12, p2) --[[ read_value | Line: 429 | Upvalues: p1 (copy) ]]
						local v1 = p1.columns()[p12]

						if v1 then
							return v1[p2] or ""
						end

						return ""
					end,
					on_click = function(p12, p2) --[[ on_click | Line: 435 | Upvalues: p1 (copy), spawn_app (ref), entity (ref) ]]
						if p1.columns()[1][p2 - 1] then
							spawn_app.spawn_app(entity, {
								host = p1.host,
								vm = p1.vm,
								id = p1.id,
								entity = p1.columns()[1][p2 - 1]
							})
						end
					end,
					on_click2 = function() --[[ on_click2 | Line: 444 ]] end,
					below = {
						pebble.padding({
							x = UDim.new(0, 4),
							y = UDim.new(0, 2)
						}),
						create("UIListLayout")({
							FillDirection = Enum.FillDirection.Horizontal,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							Padding = UDim.new(0, 8)
						}),
						pebble.button({
							text = "Previous",
							size = UDim2.fromOffset(70, 26),
							activated = function() --[[ activated | Line: 463 | Upvalues: v3 (copy) ]]
								v3(v3() - 1)
							end,
							disabled = function() --[[ disabled | Line: 467 | Upvalues: v3 (copy), p1 (copy) ]]
								return if v3() == 1 then true else p1.ok() == false
							end
						}),
						pebble.button({
							text = "Next",
							size = UDim2.fromOffset(70, 26),
							activated = function() --[[ activated | Line: 476 | Upvalues: v3 (copy) ]]
								v3(v3() + 1)
							end,
							disabled = function() --[[ disabled | Line: 480 | Upvalues: p1 (copy), v4 (copy), v3 (copy) ]]
								local v2 = math.ceil(p1.total_entities() / v4())

								return if math.max(1, v2) == v3() then true else p1.ok() == false
							end
						}),
						(pebble.typography({
							position = UDim2.new(0, 4, 0.5, 0),
							anchorpoint = Vector2.new(0, 0.5),
							text = function() --[[ text | Line: 490 | Upvalues: p1 (copy) ]]
								return ("total entities: %*\tfrom: %*\tuntil: %*"):format(p1.total_entities(), p1.from(), (p1.upto()))
							end
						}))
					}
				})
			})
		})
	})
end