-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble)
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)
local convert_units = require(script.Parent.Parent.Parent.Parent.modules.convert_units)

require(script.Parent.Parent.Parent.Parent.modules.types)

local spawn_app = require(script.Parent.Parent.Parent.spawn_app)
local system = require(script.Parent.Parent.system)
local stack_bar = require(script.Parent.stack_bar)
local create = vide.create
local indexes = vide.indexes
local values = vide.values
local changed = vide.changed
local source = vide.source
local derive = vide.derive

local function color(p1) --[[ color | Line: 32 ]]
	return Color3.fromHSV((p1 - 1) * 0.15 % 1, 1, 1)
end

local t = { "Name", "Id", "Frame Time" }

return function(p1) --[[ Line: 42 | Upvalues: source (copy), derive (copy), create (copy), pebble (copy), changed (copy), spawn_app (copy), system (copy), convert_units (copy), stack_bar (copy), t (copy), values (copy), indexes (copy) ]]
	local v1 = source(0)
	local v2 = source("")
	local v3 = source(2)
	local v4 = derive(function() --[[ Line: 49 | Upvalues: p1 (copy) ]]
		local v1 = 0

		for v2, v3 in p1.system_frames() do
			local sum = 0

			for v4, v5 in v3 do
				sum = sum + v5.s
			end

			v1 = math.max(v1, sum / #v3)
		end

		return v1
	end)
	local v5 = derive(function() --[[ Line: 63 | Upvalues: p1 (copy) ]]
		local t = {
			[false] = {}
		}

		for v1, v2 in p1.system_data() do
			if t[v2.phase or false] == nil then
				t[v2.phase or false] = {}
			end

			table.insert(t[v2.phase or false], v1)
		end

		return t
	end)

	local function system2(p12) --[[ system | Line: 72 | Upvalues: source (ref), p1 (copy), create (ref), v3 (copy), pebble (ref), v2 (copy), changed (ref), spawn_app (ref), system (ref), v4 (copy), convert_units (ref) ]]
		local v1 = source(Enum.GuiState.Idle)

		local function frame_time() --[[ frame_time | Line: 75 | Upvalues: p1 (ref), p12 (copy) ]]
			local v1 = p1.system_frames()[p12]
			local sum = 0

			for v2, v3 in v1 do
				sum = sum + v3.s
			end

			return sum / #v1
		end

		return create("ImageButton")({
			Name = function() --[[ Name | Line: 87 | Upvalues: p1 (ref), p12 (copy) ]]
				return p1.system_data()[p12].name
			end,
			Size = UDim2.new(1, 0, 0, 32),
			LayoutOrder = function() --[[ LayoutOrder | Line: 92 | Upvalues: v3 (ref), p1 (ref), p12 (copy) ]]
				if v3() ~= 3 then
					return p12
				end

				local v1 = p1.system_frames()[p12]
				local sum = 0

				for v2, v32 in v1 do
					sum = sum + v32.s
				end

				return 1000000000 - sum / #v1 * 100000000
			end,
			BackgroundColor3 = function() --[[ BackgroundColor3 | Line: 96 | Upvalues: v1 (copy), pebble (ref) ]]
				if v1() == Enum.GuiState.Press then
					return pebble.theme.bg[-1]()
				end

				if v1() == Enum.GuiState.Hover then
					return pebble.theme.bg[6]()
				end

				return pebble.theme.bg[3]()
			end,
			Visible = function() --[[ Visible | Line: 105 | Upvalues: p1 (ref), p12 (copy), v2 (ref) ]]
				return string.match(p1.system_data()[p12].name, v2()) and true or false
			end,
			changed("GuiState", v1),
			Activated = function() --[[ Activated | Line: 111 | Upvalues: spawn_app (ref), system (ref), p1 (ref), p12 (copy) ]]
				spawn_app.spawn_app(system, {
					host = p1.host,
					vm = p1.vm,
					scheduler = p1.id,
					system = p12,
					name = p1.system_data()[p12].name
				})
			end,
			MouseButton2Click = function() --[[ MouseButton2Click | Line: 122 | Upvalues: p1 (ref), p12 (copy) ]]
				p1.pause_system(p12)
			end,
			create("Folder")({ create("Frame")({
					Position = UDim2.new(0, 0, 1, 4),
					AnchorPoint = Vector2.new(0, 1),
					Size = function() --[[ Size | Line: 131 | Upvalues: p1 (ref), p12 (copy), v4 (ref) ]]
						local v1 = UDim2.new
						local v2 = p1.system_frames()[p12]
						local sum = 0

						for v3, v42 in v2 do
							sum = sum + v42.s
						end

						return v1(sum / #v2 / v4(), 0, 0, 1)
					end,
					BackgroundColor3 = pebble.theme.fg_on_bg_high[0]
				}) }),
			create("UIStroke")({
				Color = pebble.theme.bg[-3]
			}),
			create("UICorner")({
				CornerRadius = UDim.new(0, 4)
			}),
			create("UIListLayout")({
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
				Padding = UDim.new(0, 8)
			}),
			pebble.padding({
				x = UDim.new(0, 8)
			}),
			create("Frame")({
				Size = UDim2.fromOffset(16, 16),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromHSV((p12 - 1) * 0.15 % 1, 1, 1),
				create("UICorner")({
					CornerRadius = UDim.new(1, 0)
				})
			}),
			pebble.typography({
				automaticsize = Enum.AutomaticSize.None,
				text = function() --[[ text | Line: 172 | Upvalues: p1 (ref), p12 (copy) ]]
					return p1.system_data()[p12].name
				end,
				truncate = Enum.TextTruncate.SplitWord,
				xalignment = Enum.TextXAlignment.Left,
				disabled = function() --[[ disabled | Line: 178 | Upvalues: p1 (ref), p12 (copy) ]]
					return p1.system_data()[p12].paused
				end,
				create("UIFlexItem")({
					GrowRatio = 1,
					ShrinkRatio = 1,
					FlexMode = Enum.UIFlexMode.Fill
				})
			}),
			pebble.typography({
				disabled = true,
				automaticsize = Enum.AutomaticSize.XY,
				text = function() --[[ text | Line: 191 | Upvalues: p1 (ref), p12 (copy), convert_units (ref) ]]
					local v1 = p1.system_frames()[p12]
					local sum = 0

					for v2, v3 in v1 do
						sum = sum + v3.s
					end

					return ("%*"):format((convert_units("s", sum / #v1)))
				end,
				xalignment = Enum.TextXAlignment.Right
			})
		})
	end

	return pebble.widget({
		title = "Scheduler",
		subtitle = ("host: %* vm: %* id: %*"):format(p1.host, p1.vm, p1.id),
		min_size = Vector2.new(200, 300),
		bind_to_close = p1.destroy,
		create("Frame")({
			Name = "Elements",
			Size = UDim2.fromScale(1, 1),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			create("UIListLayout")({
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				FillDirection = Enum.FillDirection.Vertical,
				VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
				Padding = UDim.new(0, 8)
			}),
			create("Frame")({
				Size = UDim2.fromScale(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				pebble.pane({
					name = "Overview",
					size = UDim2.fromScale(1, 0),
					create("UIListLayout")({
						FillDirection = Enum.FillDirection.Vertical
					}),
					pebble.typography({
						text = function() --[[ text | Line: 255 | Upvalues: p1 (copy), convert_units (ref) ]]
							local sum = 0

							for v1, v2 in p1.system_frames() do
								if not p1.system_data()[v1].paused then
									local sum2 = 0

									for v3, v4 in v2 do
										sum2 = sum2 + v4.s
									end

									sum = sum + sum2 / #v2
								end
							end

							return ("Run time: %*"):format((convert_units("s", sum)))
						end
					}),
					stack_bar({
						values = function() --[[ values | Line: 273 | Upvalues: p1 (copy) ]]
							local v1 = p1.system_ids()
							local v2 = p1.system_frames()
							local t = {}

							for i = 1, table.maxn(v1) do
								if v1[i] ~= nil and not p1.system_data()[i].paused then
									local v3 = v2[i]
									local sum = 0

									for v4, v5 in v3 do
										sum = sum + v5.s
									end

									table.insert(t, {
										value = sum / #v3,
										color = Color3.fromHSV((i - 1) * 0.15 % 1, 1, 1)
									})
								end
							end

							return t
						end,
						selected = v1
					}),
					pebble.row({
						justifycontent = Enum.UIFlexAlignment.Fill,
						pebble.button({
							text = "Pause all",
							activated = function() --[[ activated | Line: 303 | Upvalues: p1 (copy) ]]
								for v1, v2 in p1.system_data() do
									if not v2.paused then
										p1.pause_system(v1)
									end
								end
							end
						}),
						pebble.button({
							text = "Resume all",
							activated = function() --[[ activated | Line: 314 | Upvalues: p1 (copy) ]]
								for v1, v2 in p1.system_data() do
									if v2.paused then
										p1.pause_system(v1)
									end
								end
							end
						})
					})
				})
			}),
			pebble.select({
				size = UDim2.new(1, 0, 0, 30),
				options = t,
				selected = v3,
				update_selected = function(p1) --[[ update_selected | Line: 331 | Upvalues: v3 (copy) ]]
					v3(p1)
				end
			}),
			pebble.textfield({
				placeholder = "System Match",
				size = UDim2.new(1, 0, 0, 36),
				oninput = v2
			}),
			create("ScrollingFrame")({
				Name = "Systems",
				Size = UDim2.fromScale(1, 0),
				CanvasSize = UDim2.new(),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				ScrollBarThickness = 6,
				VerticalScrollBarInset = Enum.ScrollBarInset.Always,
				ScrollBarImageColor3 = pebble.theme.fg_on_bg_low[3],
				create("UIFlexItem")({
					FlexMode = Enum.UIFlexMode.Fill
				}),
				create("UIListLayout")({
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0, 8),
					SortOrder = function() --[[ SortOrder | Line: 366 | Upvalues: v3 (copy) ]]
						if v3() == 1 then
							return Enum.SortOrder.Name
						end

						return Enum.SortOrder.LayoutOrder
					end
				}),
				pebble.padding({
					y = UDim.new(0, 1),
					x = UDim.new(0, 1)
				}),
				values(function() --[[ Line: 376 | Upvalues: v5 (copy) ]]
					return v5()[false]
				end, system2),
				indexes(v5, function(p1, p2) --[[ Line: 380 | Upvalues: source (ref), pebble (ref), create (ref), v3 (copy), values (ref), system2 (copy) ]]
					if p2 == false then
						return {}
					end

					local v1 = source(true)

					return pebble.accordion({
						expanded = v1,
						set_expanded = v1,
						text = p2,
						pebble.container({
							Size = UDim2.fromScale(1, 0),
							create("UIListLayout")({
								FillDirection = Enum.FillDirection.Vertical,
								Padding = UDim.new(0, 8),
								SortOrder = function() --[[ SortOrder | Line: 396 | Upvalues: v3 (ref) ]]
									if v3() == 1 then
										return Enum.SortOrder.Name
									end

									return Enum.SortOrder.LayoutOrder
								end
							}),
							values(p1, system2)
						})
					})
				end)
			})
		})
	})
end